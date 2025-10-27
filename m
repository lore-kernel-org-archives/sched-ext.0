Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCC30C626;
	Mon, 27 Oct 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580803; cv=none; b=ZqtV9IbGC4ZDElxQV2foggTKa1MjGXpe/xIAtRqnKk0XlPShfiUKOUbfgY/0fjV+0ur7PtZIDXAckzB0KeHOx9dy0n2Of/IsqvGLTcqE2sp6uSmpxrqaUIIHq0GTBmdZCyAqsMy5PIuRg2SpLOKbONYbK3jMQDQsHZvjO/VDEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580803; c=relaxed/simple;
	bh=ejD04F6BBTL81Vl9OTdY/7AZFnDCRgB6UMngRZW8YUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXa34CT7+OuW9poD97654c1iGA6w5ffAF+fhMIQjTDKEHz81n5dTfDRPx02IcUFYT2HPTP0PlVoUXf4ouhfbhGuPL6Ly4ZXgK81Hpa+Vj7sVqbLIXgTKaLYTC/+rigyFxS77vmYtvUjT0jilFBTfzHrDVeSmzmSnG16IEg+BHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFsTBW2C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFsTBW2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6522BC4CEFD;
	Mon, 27 Oct 2025 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761580802;
	bh=ejD04F6BBTL81Vl9OTdY/7AZFnDCRgB6UMngRZW8YUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFsTBW2ClFo4KaZoAgxKJ/Ql7FGjAW3NKmJlXFyyXWUTCqQYFofvgLGxUJE79NGH8
	 R/wc43y4WCKLXdmsijS4u2ghiubxItq9pCYQ0vkn8Wzgumi9bycjoD86ES4E3Te21J
	 DUKugKhr0CCj+v6j5QYNpYvCoiSL7k0FhNf2iRVVmIReuFXDuNTvwlhV5XNT9I3rZd
	 UZUMGrnYdys1R+pFEvAUOYLDdwSlmCldx2UikSZZU33mzwUt2FpqbSLCnxeXY0T1nl
	 cde/9sKwe4cvKB2b+zTns+865jtRdyIbZbBBUEcKGTC2Ys90pdr6xc7wRq4c4WDfYC
	 3aBHmyIdomW+Q==
Date: Mon, 27 Oct 2025 06:00:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aP-XAGrWQY1d6Bq9@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
 <20251027091822.GH3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027091822.GH3245006@noisy.programming.kicks-ass.net>

Hello,

On Mon, Oct 27, 2025 at 10:18:22AM +0100, Peter Zijlstra wrote:
...
> > The main use case for cpu_release() was calling scx_bpf_reenqueue_local() when
> > a CPU gets preempted by a higher priority scheduling class. However, the old
> > scx_bpf_reenqueue_local() could only be called from cpu_release() context.
> 
> I'm a little confused. Isn't this the problem where balance_one()
> migrates a task to the local rq and we end up having to RETRY_TASK
> because another (higher) rq gets modified?

That's what I thought too and the gap between balance() and pick_task() can
be closed that way. However, while plugging that, I realized there's another
bigger gap between ttwu() and pick_task() because ttwu() can directly
dispatch a task into the local DSQ of a CPU. That one, there's no way to
close without a global hook.

> Why can't we simply re-queue the task in the RETRY_TASK branch --
> effectively undoing balance_one()?
> 
> Relying on hooking into tracepoints seems like a gruesome hack.

From a BPF scheduler's POV, it's just using a more generic mechanism.
Multiple schedulers already make use of other BPF attach points - timers,
TPs, fentry/fexit's, so this doesn't make things less congruent.

Thanks.

-- 
tejun
