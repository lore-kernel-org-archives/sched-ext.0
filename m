Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF733B8D78
	for <sched-ext@lists.linux.dev>; Sat, 10 Oct 2026 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626593; cv=none; b=JDEGIOzY6hNOWNsirJgwm6VOtEnOn1fpr2qZ2Cjo/EJpygOJy+9L56UVrULxcsGMFW3ap7tvs7C/wk+UQFcfP5aAy6xYXAZRKIxSLOD/pscoShUhPQUF+thrycanctnzlozjzZ1c5aJEU9/RZhlUYMUeB2UX5CKIAA8JqxhG1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626593; c=relaxed/simple;
	bh=XcOL+h7wWKEn+/Nbt5d5kQoRxyGPXAa1BS8V2J8gY3U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RfBgNAF2bxqFHDQYJFjPZPULu3G/a654k4LzaHMrApjsgVxuTsPO+Dg9wcg5x8TzWs7mUlXwdx3QrQQ42HnNpOiepzPn9sdW8VqIuU/yfscmUKgj5NZj8otB8KQ8haVGE4fQZrHKoYOIwxLYrGEh1dQt+/fvNpJJHnJacQ3Z4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0R5JRHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0R5JRHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CCF1F000FF;
	Sat, 10 Oct 2026 10:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791626592;
	bh=irk1VIiFAUun1lNtLxR930pXbFeMh4QYKvDjTDyi7VU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z0R5JRHJYd8YokCPbs3GPPV2rFuXjhiLC+uL5NVFejTra+pwqOjcyeW29ZLPukFzP
	 6xprMee5BZDzw++zhzElU1on5iP0uH3Hggfe6S5ABALz2v976MeA0uPG6+DQGhl3DZ
	 +S8WUNwGY2dokixDSytt5lOiXk6PtanU9w+MTf3/H0FkrFDxLmxfFOZoNjMtFZ7Mhe
	 R99xPLf+Ok4HwzbfNihHVlpWbyBduLyNMed/uLEmiajEeeH16p9+jSF3p6zBVUWEwu
	 vKdiz6CO18oIQ+41tLrATLJRbNtf2mLztZdziE8dXpChzU+a+iaPFyHyE6SjrwvUj9
	 UAyyZtiWpMZNQ==
Message-ID: <sashiko-outbox-166417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Don't leave balance
 callbacks queued across a pick retry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261010095208.276806-1-arighi@nvidia.com>
References: <20261010095208.276806-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 10:03:11 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched/ext: Balance callback queued on NULL pick risks lockdep warn=
ing during newidle_balance
--

commit 82685b13d2a91f21d4676e7837dbf23573a2e3ac
Author: Andrea Righi <arighi@nvidia.com>

    sched_ext: Don't leave balance callbacks queued across a pick retry

This commit modifies the dispatch path in sched_ext to only queue balance
callbacks when the pick is final. If the core needs to retry or continue the
pick, which may release the runqueue lock, it instead punts the deferred wo=
rk
to irq_work.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 3f79156467799..54fa382ad8d78 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -3433,6 +3450,17 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *r=
f, bool force_scx)
>  	return p;
>  }
> =20
> +static struct task_struct *
> +do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
> +{
> +	struct task_struct *p =3D __do_pick_task_scx(rq, rf, force_scx);
> +
> +	/* after a NULL pick from the dl_server the lower classes still pick */
> +	pick_queue_balance_callbacks(rq, p !=3D RETRY_TASK && (p || !force_scx)=
);
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^
[Severity: High]
Does this logic incorrectly identify a NULL pick as final when force_scx is
false, leading to premature queueing of balance callbacks?

When a normal sched_ext pick (where force_scx =3D=3D false) fails to find a=
 task,
it returns NULL. The boolean logic evaluates to true because p !=3D RETRY_T=
ASK
is true (since p is NULL) and !force_scx is true. This marks the pick as fi=
nal
and queues balance callbacks to rq->balance_callback.

However, a NULL pick from sched_ext is not final for the CPU, as the core
scheduler loop in __pick_next_task() will fall through to lower-priority
scheduling classes, such as fair_sched_class.

If fair also has no runnable tasks, it triggers newidle_balance(), which
unconditionally drops the runqueue lock via rq_unpin_lock() and
raw_spin_rq_unlock().

If another CPU acquires the lock during this window, rq_pin_lock() will
trigger a SCHED_WARN_ON because a balance callback is present on the runque=
ue
while the lock was unpinned. This defeats the patch's purpose and triggers =
the
exact lockdep warning it was intended to fix.

> +
> +	return p;
> +}
> +
>  static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags =
*rf)
>  {
>  	return do_pick_task_scx(rq, rf, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010095208.2768=
06-1-arighi@nvidia.com?part=3D1
