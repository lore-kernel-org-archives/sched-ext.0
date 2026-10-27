Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793061267;
	b=AfiV3PSzSlFi+VoaYHG9CW6BQeYixJIDXYJI4/i7RsxRGzN7HWx2h1EL9v86Stk6rpZd
	 j6u113tUc02Dk0gXr66L/zxYU4THASzJ+6wJPv93Tuty26wIHI9nRQjkDl6cu83EFcR/9
	 Ypj+UX3rxSBx3+zPITLgNh85wBCGHkCChWdHR5MuK5iLcWyAwqM9AcQcNsYHAufJPMzMs
	 OAFiv6yCFqo3z8oy9wFZ5qqvgP6YC8y9t68Lw1HVgWgY6Tb94JFb2ZkPAP2fuA+ub1meB
	 QyGMmNN1hEo7zaqZ4pyrfgl2/iwyQ2Mx/sbRAFXkzVAhDYTKzSWBAj33UWJYcwW1ULQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793061267;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zLv0nBaW953mbd9PYGYtcFni/BWXaPWPCP4+J3nvGPA=;
	b=fTylKUiPoSoEPm8GS48HEVbC8s2XAq1Ri/0LKfRMYAmyKbSFFfujcgXgJMt5CiLj6kiu
	 01WU5dcs1od8PRhnxwGqOrtb/9FBKZ/Lbc7CTx8GZl/hws2TDcCKFWriV2CTC/toJJCLa
	 djfdmIKWecRzAZJj+kyP258O7ivSeCS4WQ8oWMl+p8pqiY/0hqMjtoLBOriuRIpkoSdzk
	 b6lJ7LhfYn6Rkcs0FrUt80t04lBgEYMhePgQlpeyK2UMNfkixgg7lMT7JEYY4iSKHtXPK
	 9mCc9RA8aGY3ri6FO6NrOAU3uVtYUaxBm7Vzchsygn7aXcMOHj/jSrsU5LF3/V3YkNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="miU9/T1A";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22C606A31A
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miU9/T1A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260DF1F01825;
	Tue, 27 Oct 2026 00:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793061266;
	bh=zLv0nBaW953mbd9PYGYtcFni/BWXaPWPCP4+J3nvGPA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=miU9/T1AOe/99lsOqJekZ4JJsRoPYOktrX7RB45B9I3z/AvImc4p1HdqqqX9k9IOO
	 MSsgNDW8L8zAXoTITbgx040orLJu2iiNDNjkf6Ry5mYmThjxZVbi1iIxSZBSan1LMA
	 V0fQaLhXrlhaGkkqYjR/Ndha7PZ+BqbL6KczefPSPsYJqrS1XCz/Kx4eI+0BUIYM59
	 540ges64eCCLDqbW9NE+EghSfKdC5LHUHnDApWofjcBqjatv7iKXZCglZD33z97r+K
	 mOFI+2Z7Mqx6B7fE2ZOP/G5qSWjSYbABM3Rh2UNwBG43FvsLbw+vBfnN+t6ASg1KC0
	 3BwcmUkNS31Sg==
Message-ID: <sashiko-outbox-185952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/18] sched_ext: Fix a cpu idling with a runnable
 rescuee
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261027001749.1821379-9-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
 <20261027001749.1821379-9-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:34:25 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched_ext: premature slice restore in dispatch_one() via scx_res=
cue_keep()
--

commit 84249cc9d9822a67a9e62226f4711cf219c9db29
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix a cpu idling with a runnable rescuee

This commit fixes a bug where a CPU idles with a runnable rescuee when a
scheduler zeroes the rescuee's slice without dispatching another task, by
calling scx_rescue_keep() in dispatch_one() to keep the rescuee running on
its unserved remainder when nothing else is runnable.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 56742d1ce5131..2504a6a9911b3 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3396,6 +3396,34 @@ static enum scx_dsp_verdict dispatch_one(struct rq=
 *rq, struct task_struct *prev
>  			verdict =3D SCX_DSP_PREV;
>  			goto has_tasks;
>  		}
> +
> +		/*
> +		 * The scheduler preempts a rescuee like any other task by
> +		 * zeroing its slice. The grant survives the preemption. The
> +		 * rescuee gets the unserved remainder back and runs again
> +		 * behind whatever the scheduler wanted to run first.
> +		 *
> +		 * Two sites restore the remainder. When another task won the
> +		 * pick, put_prev_task_scx() restores it and queues the rescuee
> +		 * at the tail of the local DSQ.
> +		 *
> +		 * When nothing else is runnable, the cpu must not go idle with
> +		 * the rescuee queued. The keep above takes a rescuee whose
> +		 * scheduler holds %SCX_CAP_BASE here and doesn't take the last
> +		 * task through %SCX_OPS_ENQ_LAST.
> +		 *
> +		 * The pick then ends its zeroed slice, and the rescue with it,
> +		 * and refills a default slice. The task continues as an
> +		 * ordinary one, which is fine as its scheduler holds BASE here.
> +		 *
> +		 * For any other rescuee, a reinsert from put_prev_task_scx()
> +		 * would come after the pick settled on idle. Keep it running on
> +		 * the remainder here.
> +		 */
> +		if (unlikely(prev =3D=3D scx_rescuee(rq)) && scx_rescue_keep(rq, prev)=
) {
> +			verdict =3D SCX_DSP_PREV;
> +			goto has_tasks;
> +		}

[Severity: Medium]
Can calling scx_rescue_keep() inside dispatch_one() restore prev->scx.slice
prematurely when the pick is subsequently retried or aborted?

On the existing keep-last path right above this block, dispatch_one()
returns SCX_DSP_PREV while leaving prev->scx.slice at 0, and
do_pick_task_scx() only commits to ending and refilling the slice after
checking for retries and higher-priority class modifications:

kernel/sched/ext/ext.c:do_pick_task_scx() {
	...
	if (verdict =3D=3D SCX_DSP_RETRY)
		return RETRY_TASK;
	...
	if (!force_scx && rq_modified_above(rq, &ext_sched_class)) {
		p =3D RETRY_TASK;
		goto out;
	}

	if (verdict =3D=3D SCX_DSP_PREV) {
		p =3D prev;
		if (!p->scx.slice) {
			/* the slice is consumed, protection ends */
			scx_task_slice_ended(rq, p);
			refill_task_slice_dfl(scx_task_sched(p), p);
		}
	...
}

By contrast, calling scx_rescue_keep(rq, prev) in dispatch_one() writes
prev->scx.slice =3D remaining (> 0) before the pick is finalized. If
scx_dispatch_sched() temporarily dropped the rq lock before returning
SCX_DSP_NONE, two issues can occur:

1. Under core scheduling, dispatch_core_pick() sees that the rq lock was
   dropped and discards the verdict:

   kernel/sched/ext/ext.c:dispatch_core_pick() {
       ...
       verdict =3D dispatch_one(rq, prev);

       /* if dispatch_one() released the rq lock, restart the selection */
       if (rq->scx.lock_drop_seq !=3D seq)
           return SCX_DSP_RETRY;
   }

   When the pick restarts and calls dispatch_one(rq, prev) again,
   prev->scx.slice is now non-zero, so dispatch_one() short-circuits at the
   top:

   kernel/sched/ext/ext.c:dispatch_one() {
       ...
       if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
           !scx_bypassing(scx_task_sched(prev), cpu)) {
           verdict =3D SCX_DSP_PREV;
           goto has_tasks;
       }
   }

   This returns SCX_DSP_PREV before checking rq->scx.local_dsq.nr or calling
   scx_dispatch_sched(), ignoring any tasks enqueued while the rq lock was
   dropped.

2. If a higher-priority task (such as RT, DL, or fair) woke up while the rq
   lock was dropped, do_pick_task_scx() sees rq_modified_above() and returns
   RETRY_TASK (or core-sched cookie matching selects another task or
   rq->idle). When put_prev_task_scx() then runs for prev, p->scx.slice is
   already non-zero:

   kernel/sched/ext/ext.c:put_prev_task_scx() {
       ...
       if (!p->scx.slice) {
           if (unlikely(p =3D=3D scx_rescuee(rq)))
               rescue_keep =3D scx_rescue_keep(rq, p);
           if (!rescue_keep)
               scx_task_slice_ended(rq, p);
       }
       ...
       if (p->scx.slice && !scx_bypassing(sch, cpu_of(rq))) {
           ...
           if (unlikely(p =3D=3D scx_rescuee(rq))) {
               enq_flags |=3D SCX_ENQ_IGNORE_CAPS;
               if (!rescue_keep)
                   enq_flags |=3D SCX_ENQ_HEAD;
           }
   }

   Because !p->scx.slice is skipped, rescue_keep remains false and the
   preempted rescuee is queued with SCX_ENQ_HEAD instead of at the tail of
   the local DSQ.

Should the slice restoration via scx_rescue_keep() be deferred to the
verdict =3D=3D SCX_DSP_PREV && !p->scx.slice block in do_pick_task_scx(), w=
ith
dispatch_one() only checking whether the rescuee can be kept (for example,
scx_rescue_slice_remaining(rq) > 0 && !scx_bypassing(prev_sch, cpu))?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027001749.1821=
379-1-tj@kernel.org?part=3D8
