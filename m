Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B472727FE;
	Mon, 13 Oct 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380421; cv=none; b=SGeIdW4iHtR2+rRNBM540RQVqiIqc6aamBRWbbMobjK9/eEuz6oQR/2W4GIgnR8FdoEz1t0h3q66TUzQx9OFBspLpnlaAXR/6lR2ujy/pyluuRgFJjy7PZfqMmZmCKb5dLYh81gsAxgfdeGiTQd9OEWY2Jf4nFAbKFSCymq94cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380421; c=relaxed/simple;
	bh=Pb1YK9uXTK5NObze1RcKWVMvmWGEUjHg2vA9rnvzUKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfGL7cYU+HzHiNV+fsst11jra+IXwHxyuPE5JbCDNDGaW+bsg2oRjXy7kTp9zedlHDsT6VA5GMoCX7RYww1HYVCkKUQrXN7sFdHEo5MKfPq26MsMfCbaTXd42bq/eo+88abtSN4blSVGPYOOXOXxqWASd77h1o6gzD0Nk7e0hG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWAE3aKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWAE3aKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E97C4CEE7;
	Mon, 13 Oct 2025 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380420;
	bh=Pb1YK9uXTK5NObze1RcKWVMvmWGEUjHg2vA9rnvzUKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWAE3aKDzRZdqo1a7OrjQwQiQ3NnsQAnwAQjsVqA+aaWVRtFxgkjqXK9lb2MOjwP+
	 i32qITcAff92/J2ndsjtFLJk20C6o1U0HkX6teNzW9ca2vTXPIpJjNYNkvPMdjjWuV
	 Xk8TRKrYnMkYb1PGHuCo4rWM1hhGb7lA9hJjq3LQAsvoKhGKcyGuM//p+r5HOOOhYV
	 YSnGQsGyTnp5zWZuaEIVjrbxnH6M8xOjT7yhNoiwo/XIV/+yHJ9+N/Mh4GknlYztFW
	 DyKBVLXVBZSF0Q+EiFPenD4zbh+1aahdO0A9RUuJuTktZyNItYDY0m0838UmRQ4EcJ
	 XZ2puAeTmwrWw==
Date: Mon, 13 Oct 2025 08:33:39 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-6.18-fixes] sched_ext: Sync error_irq_work
 before freeing scx_sched
Message-ID: <aO1GAxf6zhSu7qxL@slm.duckdns.org>
References: <20251009235623.4135746-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009235623.4135746-1-tj@kernel.org>

On Thu, Oct 09, 2025 at 01:56:23PM -1000, Tejun Heo wrote:
> By the time scx_sched_free_rcu_work() runs, the scx_sched is no longer
> reachable. However, a previously queued error_irq_work may still be pending or
> running. Ensure it completes before proceeding with teardown.
> 
> Fixes: bff3b5aec1b7 ("sched_ext: Move disable machinery into scx_sched")
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to sched_ext/for-6.18-fixes.

Thanks.

-- 
tejun
