Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12FB43B498;
	Mon, 17 Aug 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988480; cv=none; b=DqTMjqm7ZoaPX0GpXBml7BGXXHNc70Rt0PjuDxyRzYzDpocvYxF+/QcIa+5s+HEDEABu67c4cPArOsuqdy2CQxlesErElw3urHui9uHC6urwmibwCttbJkI8KQxMuXCtCgjT0dIA/+GzEXRCPGCT9CCN0WNhe8pmKbyCv7jO3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988480; c=relaxed/simple;
	bh=4Ibw18QYiPJIh8OW20/aDo7+DdqKw+4MOs9piPSqptM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hrgWj7i3C4tPeU/QwltY7vNmLsVRRAoqVDe7V7KuRRqOJspBQrm6GQUWleNLtCQQCrVRgv4FmbEGlaOi5qKm/Nib9l7g2ooAC6KQCO2CUO+c1zZj50Crcw3mB7emzMqkB09+B2UqQATql6jbz/Ar6hv/DadoGQzvE7rXCjguEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFp6Na3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFp6Na3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFF31F000E9;
	Mon, 17 Aug 2026 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786988479;
	bh=EiFoxD5F5oxtX49ytt/022bU43oM3OER1rZ9REVfRtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MFp6Na3yNOBoSwVNSjsqldaabDgD4IpCaA81mxyGfU88RiVOMswuHHrLrzrMFwokd
	 8/hqDqXTnZAozTebS6LsC+YE0wgcpr8QKGb17V9VsM98JOrXLDdC4qj3h1OvqvveXT
	 nJmRnxYKEnvX0IpAE4cVqwnIsE7wU9oXC0TM/yhPVPuj6OTKXk7NRufCaeXhbLgCr9
	 8Lm2GsR32EK5ZgFX9TNMnZKGsVHt2GOx2SDjax8I9a/+ittsB5llFexxnGPV70rxDR
	 rAwsuOdzaXiMX+0XhUOMvg14Ru6MIywxFVgowuIjUinpsW6ZZLt/exznt00kWgrsSl
	 uJmUcu4tkwOJg==
Date: Mon, 17 Aug 2026 07:41:18 -1000
Message-ID: <ea4d0262ca08706b2c3b0cb4eaaf3ad5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>,
	Gavin Guo <gavinguo@igalia.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] compat.bpf.h: Gate scx_bpf_dsq_peek kfunc behind kernel version 7.1.0
In-Reply-To: <20260817143126.562923-2-changwoo@igalia.com>
References: <20260817143126.562923-1-changwoo@igalia.com> <20260817143126.562923-2-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Mon, Aug 17, 2026 at 11:31:25PM +0900, Changwoo Min wrote:
> __COMPAT_scx_bpf_dsq_peek() selects the lockless kfunc whenever the
> symbol resolves in the kernel BTF. However, its lockless implementation
> could return a stale task_struct pointer. The stale pointer issues are
> resolved only after v7.1 kernel with the following patches:
>
> commit 2f2ea7709266 ("sched_ext: Use dsq->first_task instead of list_empty() in dispatch_enqueue() FIFO-tail")
> commit 71d7847cad44 ("sched_ext: Fix scx_bpf_dsq_peek() with FIFO DSQs")

71d7847cad44 shipped in v6.19 together with the peek API itself, so every
mainline release that has the kfunc already has it. Only 2f2ea7709266 is
new in v7.1, and what it fixes on v6.19/v7.0 is scx_bpf_dsq_peek()
spuriously returning NULL on a non-empty FIFO DSQ, not stale pointers.
The gate itself looks fine but can you update the description and the
comment so that they describe what the gate is actually avoiding?

> + * The kfunc exists on earlier kernels but its lockless implementation could
> + * return stale task pointers. Require kernel version >= 7.1.0 before calling
> + * it; otherwise fall through to the bpf_iter_scx_dsq fallback below.
> + *
>   */

Also, the edit leaves a dangling " *" line before the closing "*/".

Thanks.

--
tejun
