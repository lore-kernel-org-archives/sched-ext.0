Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEDB4FECC2;
	Fri,  2 Oct 2026 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962218; cv=none; b=cs/lsUoYYNqbVXI3dIahJbPqP5o4FBg/sUykkGEaY6g5gITrL5ZNzmIqVEigcPmbeP56hplzdV0aX31LcLoHELQp0/PjFSWmfEjZFT54qyR63JiXWOZkKmHC/YBP93fh4cjz3PRMS15p/oTpJySNYUEWv9mY9LstXGqYRq6Ujqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962218; c=relaxed/simple;
	bh=imy+sXTxS7D7NkNt7hBUQc4iEj8z2NvoUhtPTWtLSCQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxFP9Nl8q9lhKiWIHvztUcm+EMZWsweKDeAAhQJfOv4yJj3RxuJzUw7cT63wWZ+9nhBIz1WrzNCfy0EFehbRgcJqpd1q9rnj0SnCTyYnEtKBr54fThGbyPlxcTvbhmXwyEQhva0u7UXvOZDxkhTI6pj9YSsZcfXxYi5+pORZHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErXxwTN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErXxwTN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA421F000FF;
	Fri,  2 Oct 2026 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790962217;
	bh=u5Ewqhn/hcHfdMaQjI+0tet2zxHIY0RX9foKH3LCiAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ErXxwTN6j+QWkuyH54XGzJrqRvZ9FfQU7BAKYypxx8uqPPR8TINlXY0KgVm5G3VHn
	 XODPxciHX2I4EaHON7CbnpgaKA4di2uarDbCIA7Byq+kFhCkrcy8FS8Oux/fVTsfer
	 YzsckeuM1iTi3yrVvLm1xBifaqKDePrkZGDdL3fPRqLRu942MHq5ETZ4N8XxepeSFN
	 2PCTnHQm424OffRiqnVflb4jN3WTeNrMpzUX8qGMO6cdpNmT02RKsVxhcsx6E+o3Z7
	 +kDXVp88jj+EQ8QNoHeN4YjR+avY2alwwF5ltQGaFWS8evHDs37KvoDWyS/NBLx6oc
	 alT0GX5pQqGLQ==
Date: Fri, 02 Oct 2026 07:30:16 -1000
Message-ID: <59be0f173a7bc73a5a7eb6927f635605@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Keep proxy donors with
 slice left on the local DSQ
In-Reply-To: <20261001191216.2391359-1-arighi@nvidia.com>
References: <20261001191216.2391359-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Andrea.

On Thu, Oct 01, 2026 at 09:12:16PM +0200, Andrea Righi wrote:
> +			if ((p->scx.flags & SCX_TASK_IMMED) && !proxy_put) {
>  				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
>  				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);

I wonder whether IMMED should matter for a blocked donor at all. IMMED
should trigger a reenqueue iff the task is not being serviced by a CPU. A
donor under proxy execution is being serviced. The CPU is working on its
behalf and there's nothing the scheduler can do to make it go faster by
placing it elsewhere. If so, a donor with slice left can stay on the local
DSQ regardless of IMMED and of which put this is, and
SCX_RQ_PROXY_PICK_PENDING isn't needed. The deferred local check would need
the same exemption as the task stays SCX_TASK_IMMED.

> +		/* Delegate retained donor admission to its owning BPF scheduler. */
> +		if (p->is_blocked) {
> +			if (WARN_ON_ONCE(!sch))
> +				goto switch_class;
> +			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
> +			scx_do_enqueue_task(rq, p, 0, -1);
> +			goto switch_class;
> +		}

Can this be folded into the following block? scx_do_enqueue_task() already
adds SCX_ENQ_BLOCKED, so a !p->is_blocked test on the ENQ_LAST condition
would route donors to the plain enqueue.

Thanks.

--
tejun
