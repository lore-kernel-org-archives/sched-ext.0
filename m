Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410B3BE62A
	for <sched-ext@lists.linux.dev>; Fri,  1 May 2026 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777643139; cv=none; b=OqHdoeFfI2v/mX5QMAZ+hSNregPzmxz4S+KRAXZQF/t0VTRonk/dXbFElpfX9bYyu3pUtDSi2PvI+/r7i2iKN4j7dgse3AGdcLvcBF2n+paprTuq7fNH0uzCrlygci1wJRG9aKGyAsvk027JDk4Gwp47jLAXtIylefn6dvji+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777643139; c=relaxed/simple;
	bh=AR+oCTza7l06wZW/oqZbI/Z62TW5wyPFJm+ydYforMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U5Y6bJrdYUvPQHrtHTdQPudk5q7iNyEYur59McBW2AZ0VixlMAjZuNeR1NtOdX7+V7LIeO9Bk828vjA1YOUNQkPh/QUefVMX+SzLwt0Ewwo6EiBQbKg6mV9X9Jww5WlBVZVJvcQneqbBKDGk3gkwW7tc+6r7qga9v1PjPPJLbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX0dVIDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX0dVIDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2C6C2BCB4;
	Fri,  1 May 2026 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777643139;
	bh=AR+oCTza7l06wZW/oqZbI/Z62TW5wyPFJm+ydYforMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WX0dVIDXCD9Fklf6tTzj/4ESWVZT4XqV5idz9IPIuTQlb+21DHoyZvMsbiCNV9oZk
	 wkuZPm4QF8YtPXzV1TcTpxii1+s+JyzTipDGBNGXE3giQGkYuxbWEXk1f4HKbB09Y1
	 HfLAwylnZKCnAMaDx+9Xc15XOFWGvu38lM5K3lGEwKL0QaSaVmBuhmkBKkNt6kcSyh
	 W04pBXIyfAfCuxvKTlhm8m6ENgqBPGyEDYFxkumPUh9gWMijV3adhcFvUqz/S35mlr
	 2KgEhfzX2lNbgFiGgGnQc/i77OzHvGtMnwHedLOJovDt/JQENkBbHYoZcc4Nck3S6K
	 Rt6C0YYBuYf8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Reply-To: sashiko@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260501131521.161852-3-yphbchou0911@gmail.com>
References: <20260501131521.161852-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 13:45:38 +0000
Message-Id: <20260501134539.3E2C6C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect CPU attribution and preemption warning in synchronize_rc=
u_expedited_wait()
--

commit 90ea438e747b72bc99a16a5708470577b00e6a1a
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

sched_ext: Fix exit_cpu accuracy for lockup paths

This patch adds an exit_cpu parameter to handle_lockup() and updates the
lockup paths, including RCU stall detectors, to pass the actually stalled
CPU rather than the detector CPU.

> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -675,7 +675,7 @@ static void synchronize_rcu_expedited_wait(void)
> =20
>  		nbcon_cpu_emergency_exit();
> =20
> -		panic_on_rcu_stall();
> +		panic_on_rcu_stall(smp_processor_id());

Does this accurately record the stalled CPU for expedited grace periods?

The commit message notes the goal is to avoid recording the detector CPU
rather than the stalled one. However, passing smp_processor_id() here
appears to still record the CPU of the task waiting for the expedited grace
period (the detector), rather than the actual stalled CPU.

Additionally, is it safe to call smp_processor_id() at this point?

Looking at synchronize_rcu_expedited_wait(), it sleeps via
synchronize_rcu_expedited_wait_once(). The nbcon_cpu_emergency_exit() call
immediately preceding this balances a prior nbcon_cpu_emergency_enter(),
leaving preemption enabled:

    nbcon_cpu_emergency_exit();
    panic_on_rcu_stall(smp_processor_id());

Could this trigger a "BUG: using smp_processor_id() in preemptible" warning
when CONFIG_DEBUG_PREEMPT is enabled? Would it be better to pass -1 or
extract the actual stalled CPU instead?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501131521.1618=
52-1-yphbchou0911@gmail.com?part=3D2
