Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C4314D05
	for <sched-ext@lists.linux.dev>; Sat,  1 Aug 2026 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575477; cv=none; b=We5eHNXR6AIAqmpQt4VO9dMVFGaHwouFsRWYonmfuaiqrne7fU+LoqdZKeprBxJGPqz1euuJtmrulXAhkiN0RfMZCK+UEmVoDqBWjunYaDTb3I3NR4YeeOhCxcC0EcNbcKBXGEzSZ1Zt8eyOHCpocI57gVd4At3YsfzS4PLR0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575477; c=relaxed/simple;
	bh=f5RNPLAssa1UzCa/NF9B0SkPPnXjKu7M3VsiGUgrya4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QsAf8VdPR77Kuhqhvhj75ZKPGDBmHwDMaAae7IRbHRZs6C68F0j8VVYVb417O4wpDLP3mYrBTqTX9pBHzUYzIJk+wwpBpjqoVc9TmgFIb4zecDG5oyC0oKnIIPYLHBcr4KqhsZ7+9GOXA2ScERmCA/eO2EhOcN1FpcradR+9FV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWmj/u/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWmj/u/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750DC1F00AC4;
	Sat,  1 Aug 2026 09:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785575475;
	bh=TIa8In1MEnNifXavlMKOtO98ZKrlz/hyD7jLx3xBqvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nWmj/u/i1iWG1mRAHKFxMSJ6lozfOa8qU95fMIuxTLHD6RMXY1D+V5jXUOd8XaLCM
	 HUabVWLTLv6UZKOn/W9lbo/4nY3pTOhwov0PPe4dG1Z9q6INYFIIR7bcXMeG7Imf1I
	 THRjXt7rclPzDHRqmvvVM2YBhG+MZ8hHTbhwZABOERFmZXl0Po8/hT0grgiCWdrnXh
	 uYpDM0gFA1Ikp6UM8kqCopwf+qinThc6HMjo7vdY2KjMJfCiTRkmfv9UGU4y1Mb0Px
	 +TaRQTGsjoe5TROPkiVix2n4CdIqyPB2baV3q1qd/osolY4FTqLS80QeMmdSKmAQf0
	 C2yOJRV96eepQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] sched_ext: Eject the top rescue consumer on
 overload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260801085150.2697653-10-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
 <20260801085150.2697653-10-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 09:11:14 +0000
Message-Id: <20260801091115.750DC1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `time_before()` check in `scx_rescue_check_overload()` suffe=
rs from a 32-bit jiffies wraparound vulnerability, disabling rescue overloa=
d protection for 24.8-day intervals on systems with 32-bit `unsigned long`.
--

--- Patch [9]: [PATCH 09/12] sched_ext: Eject the top rescue consumer on ov=
erload ---
commit 50e2ffc187a8450dacf680dcf11b98c2167b7621
Author: Tejun Heo <tj@kernel.org>

sched_ext: Eject the top rescue consumer on overload

This patch tracks each scheduler's recent rescue consumption per CPU as a
decaying average. If the oldest waiter on a CPU's rescue DSQ waits past a
configured threshold, the sub-scheduler with the highest recent consumption
is ejected. This prevents the generic stall watchdog from unfairly blaming
the waiting task's owner instead of the misbehaving party.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 3c1f11268e7f3..fdbe1c1bfaa8d 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -434,6 +459,63 @@ static bool scx_rescue_try_admit(struct rq *rq, stru=
ct task_struct *p)
>  	return false;
>  }
> =20
> +/**
> + * scx_rescue_check_overload - Eject the top rescue consumer on a stuck =
rescue
> + * @rq: rq whose rescue timer fired
> + *
> + * If the oldest waiter on @rq's rescue DSQ has been queued for too long=
, rescue
> + * demand on this cpu persistently exceeds the configured bandwidth. Eje=
ct the
> + * sub with the highest recent rescue consumption instead of letting the
> + * scheduler stall path blame the waiter's owner, who may just be crowde=
d out.
> + */
> +static void scx_rescue_check_overload(struct rq *rq)
> +{
> +	struct scx_sched *victim =3D NULL, *pos;
> +	struct task_struct *p;
> +	int cpu =3D cpu_of(rq);
> +	u64 max_avg =3D 0;
> +	u32 dur_ms;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	p =3D list_first_entry_or_null(&rq->scx.rescue.dsq.list, struct task_st=
ruct,
> +				     scx.dsq_list.node);
> +	if (!p)
> +		return;
> +
> +	/* has the head waiter been queued for longer than the threshold? */
> +	if (time_before(jiffies, p->scx.rescue_at + scx_rescue_overload_after))
> +		return;
> +
> +	/*
> +	 * Grace period after the last ejection on this cpu - the freed
> +	 * bandwidth gets one threshold's worth of time to drain the backlog
> +	 * before another sub is judged.
> +	 */
> +	if (time_before(jiffies, rq->scx.rescue.kill_at + scx_rescue_overload_a=
fter))
> +		return;

[Severity: Medium]
Does this time_before() check have an issue with jiffies wraparound on 32-b=
it
systems?

If no rescue ejection occurs for LONG_MAX jiffies (about 24.8 days at HZ=3D=
1000
on 32-bit systems), jiffies - rq->scx.rescue.kill_at will exceed LONG_MAX.
Because the time_before() macro uses signed arithmetic, the difference wraps
around to a negative value.

This causes time_before() to incorrectly evaluate to true, falsely trapping
the CPU in a continuous grace period. Would this disable overload ejections
for the next 24.8 days and cause the scheduler to fall back to the generic
stall watchdog instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801085150.2697=
653-1-tj@kernel.org?part=3D9
