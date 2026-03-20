Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A53B8BB2
	for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014970; cv=none; b=bwvZp+5T5Lzu4R5sU0zglSkFe7OBG9rklSgfDAbYEhnkAUGIpnG9veToLX5Wzl7RRX4dSENg32LjN3fjKm+mxfk2lIAvEN8+QsdKMv8Xd5/8hu6D57uONKOMEQA3CKGBxTsPsFv/3ZY9PVWTS4s9vESFOCAvQso6MtcF9eWoDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014970; c=relaxed/simple;
	bh=Ed4RA/LJ76SE6OfRzsvXdoFnqI9J/ydzMpwFGQcgi/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RleLmzklZsBISsREHBP4rh6YF6WNs8KMyS16qCZo/eys5CAWwFj2SJQaCRSdO/nKfD+/A2wEAlPqjEJ6Lr9hlVC9K7eM8mEVicACvHism0xRFxw/W4x4vSNYnNvP3Gwj/fxVzXzwZZs3FXMTDRM89jdLrGAZzAXyo4lFHTTIdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HjiXmEf4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjiXmEf4"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-485397788b3so15393045e9.2
        for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774014963; x=1774619763; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvdvfQZFHOMRM0UdRldfEKNUYZsvxzi0kVQOrIIDXzY=;
        b=HjiXmEf4j+fbNJmP2jtNAE0r2jm7pSWBv7OFLuGwMXxGgJKDPUI6aw0CkI1rWDsPit
         EQQrauzoZFr0ngVtuIJV42V2HgqcctFF96o5CWgLVIsbfrC0Tc0rIF6QIDa8B+MniQR0
         SUzPLzE/fPOKxSI3vTH5hQtgpaELNMkZE07XnP1/k68xmqVxBQM1AQtew9f2WAZ56XLz
         rSGXrnmH7OZe4sV+8YVAFg6RrUqpPoxiq/9YeVWXKYBWsX+k76GIqyBN+jkpKvvTsX/y
         NlfmJAZSrpRSibscdZHxFAayKHhVI78fm9VoQCpJJo3ppfzUgtp0CvaYdjiHjNTr1xVe
         lwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774014963; x=1774619763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvdvfQZFHOMRM0UdRldfEKNUYZsvxzi0kVQOrIIDXzY=;
        b=VXQWNR6+kLK3fiUQfjZ9HGBtGOjPfhAPpjOMoUb5i4ZuzG/K/EKBawGp3qF9Tci1EK
         GwaxY1+ZWas40h8z8gdcUzQpMacwNHxxJF5k0GpM8sVwD2Qy42g5MxbeUl1RYqY14/Tf
         qcBpcoJ2TWC6alz1wPeTiBQPwY0bBK8Y3PE+nhEAczE7pS4BMvHRlCSHBpXumTrP0aJM
         /KT454y/ycsMHPAbMC+Nn9RrQNak7qIYi86ChoDa3AFUI9t/9sWFcc1EenviOLp0FYcM
         J74X8VN+25BmAHiRKm9GB8uK3JdRVHow7fTwcFX60eNvxIljWn5sISF+JtSX6kY3Glnv
         QW2g==
X-Forwarded-Encrypted: i=1; AJvYcCXNQwsTA92cxFfL3LtyxTBvzDQezB/q8cnlY1MgptYzCUJcePn7ueuso52zdFr1BmiBlIH/msexOTU=@lists.linux.dev
X-Gm-Message-State: AOJu0YzUFPnyQiVBODwMuNs5N3wEkRq8Hb/FQWYp9VxxJaaHFsy3yMO7
	8cR0itg+rQgaDKneg0bqOxV+b3TqeR1foNVACKT/wDRDM7bRfatHWHAVfjTAhLTaHYSWvk/2Yjv
	IG4p+plFpFvWXcg==
X-Received: from wmbhi23.prod.google.com ([2002:a05:600c:5357:b0:485:33e8:92af])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b31:b0:485:469f:5320 with SMTP id 5b1f17b1804b1-486fee2d9e0mr49152905e9.30.1774014963379;
 Fri, 20 Mar 2026 06:56:03 -0700 (PDT)
Date: Fri, 20 Mar 2026 13:56:02 +0000
In-Reply-To: <20260305062900.43450-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260305062900.43450-1-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DH7NTJ4IRIY1.GFW9V7S6Y1KU@google.com>
Subject: Re: [PATCH v2] sched_ext: Document task ownership state machine
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

Sorry for the late reply, I'm catching up with mail from the past ~month.

On Thu Mar 5, 2026 at 6:29 AM UTC, Andrea Righi wrote:
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index bd26811fea99d..417d3c6f02fe3 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1042,26 +1042,108 @@ static const char *scx_enable_state_str[] = {
>  };
>  
>  /*
> - * sched_ext_entity->ops_state
> + * Task Ownership State Machine (sched_ext_entity->ops_state)
>   *
> - * Used to track the task ownership between the SCX core and the BPF scheduler.
> - * State transitions look as follows:
> + * The sched_ext core uses this state machine to track task ownership
> + * between the SCX core and the BPF scheduler. This allows the BPF
> + * scheduler to dispatch tasks without strict ordering requirements, while
> + * the SCX core safely rejects invalid dispatches.
>   *
> - * NONE -> QUEUEING -> QUEUED -> DISPATCHING
> - *   ^              |                 |
> - *   |              v                 v
> - *   \-------------------------------/
> + * State Transitions
>   *
> - * QUEUEING and DISPATCHING states can be waited upon. See wait_ops_state() call
> - * sites for explanations on the conditions being waited upon and why they are
> - * safe. Transitions out of them into NONE or QUEUED must store_release and the
> - * waiters should load_acquire.
> + *       .------------> NONE (owned by SCX core)
> + *       |               |           ^
> + *       |       enqueue |           | direct dispatch
> + *       |               v           |
> + *       |           QUEUEING -------'
> + *       |               |
> + *       |       enqueue |
> + *       |     completes |
> + *       |               v
> + *       |            QUEUED (owned by BPF scheduler)
> + *       |               |
> + *       |      dispatch |
> + *       |               |
> + *       |               v
> + *       |          DISPATCHING
> + *       |               |
> + *       |      dispatch |
> + *       |     completes |
> + *       `---------------'

We can also go directly from QUEUED to NONE when a task is dequeued for an
attribute change or picked by core-sched.

> + * State Descriptions
> + *
> + * - %SCX_OPSS_NONE:
> + *     Task is owned by the SCX core. It's either on a run queue, running,
> + *     or being manipulated by the core scheduler. The BPF scheduler has no
> + *     claim on this task.

A blocked task's ops_state is also NONE. Or are we assuming here that the task
is on_rq?
Also, a task waiting to run on a built-in DSQ is in NONE state as well.

> + *
> + * - %SCX_OPSS_QUEUEING:
> + *     Transitional state while transferring a task from the SCX core to
> + *     the BPF scheduler. The task's rq lock is held during this state.
> + *     Since QUEUEING is both entered and exited under the rq lock, dequeue
> + *     can never observe this state (it would be a BUG). When finishing a
> + *     dispatch, if the task is still in %SCX_OPSS_QUEUEING the completion
> + *     path busy-waits for it to leave this state (via wait_ops_state())
> + *     before retrying.
> + *
> + * - %SCX_OPSS_QUEUED:
> + *     Task is owned by the BPF scheduler. It's on a DSQ (dispatch queue)
> + *     and the BPF scheduler is responsible for dispatching it. A QSEQ

The task doesn't have to be on a DSQ, it can be queued on some BPF data
structure instead. Even if it is on a DSQ, its state depends on whether it's
on a user DSQ (QUEUED) or a built-in DSQ, e.g. local (NONE).

This prompted me to have a look at the logic around SCX_OPSS_QUEUED and I can't
convince myself that it's correct in the case of direct dispatches to
non-builtin DSQs.

The only place where ops_state is set to QUEUED is at the end of
do_enqueue_task(). Notably, this assignment is skipped in the case of direct
dispatch.

direct_dispatch() will then call dispatch_enqueue() with SCX_ENQ_CLEAR_OPSS,
causing ops_state to be reset to NONE. We end up in a state where the task
is enqueued on a user DSQ, its ops_state is NONE and p->scx.flags has
SCX_TASK_IN_CUSTODY, which doesn't look like a consistent state to me.

Am I missing something here?

> + *     (queue sequence number) is embedded in this state to detect
> + *     dispatch/dequeue races: if a task is dequeued and re-enqueued, the
> + *     QSEQ changes and any in-flight dispatch operations targeting the old
> + *     QSEQ are safely ignored.

Technically speaking, the QSEQ is also embedded in QUEUEING, where it serves
the same purpose.

> + *
> + * - %SCX_OPSS_DISPATCHING:
> + *     Transitional state while transferring a task from the BPF scheduler
> + *     back to the SCX core. This state indicates the BPF scheduler has
> + *     selected the task for execution. When dequeue needs to take the task

This description only applies to the case of a task being dispatched from
ops.dispatch().

There are cases where a task is transferred from the BPF scheduler to SCX core
without going through DISPATCHING, e.g. dequeue for attribute change or
core-sched pick.

This state indicates the BPF scheduler has selected the task for execution,
but it doesn't always go the other way: when the BPF scheduler selects a task
for execution via direct dispatch, at no point does the task enter the
DISPATCHING state.

> + *     off a DSQ and it is still in %SCX_OPSS_DISPATCHING, the dequeue path
> + *     busy-waits for it to leave this state (via wait_ops_state()) before
> + *     proceeding. Exits to %SCX_OPSS_NONE when dispatch completes.
> + *
> + * Memory Ordering
> + *
> + * Transitions out of %SCX_OPSS_QUEUEING and %SCX_OPSS_DISPATCHING into
> + * %SCX_OPSS_NONE or %SCX_OPSS_QUEUED must use atomic_long_set_release()
> + * and waiters must use atomic_long_read_acquire(). This ensures proper
> + * synchronization between concurrent operations.

The transition from QUEUED to NONE in ops_dequeue() isn't covered here.
It uses atomic_long_try_cmpxchg(), which implies full ordering.

> + *
> + * Cross-CPU Task Migration
> + *
> + * When moving a task in the %SCX_OPSS_DISPATCHING state, we can't simply
> + * grab the target CPU's rq lock because a concurrent dequeue might be
> + * waiting on %SCX_OPSS_DISPATCHING while holding the source rq lock
> + * (deadlock).
> + *
> + * The sched_ext core uses a "lock dancing" protocol coordinated by
> + * p->scx.holding_cpu. When moving a task to a different rq:
> + *
> + *   1. Verify task can be moved (CPU affinity, migration_disabled, etc.)
> + *   2. Set p->scx.holding_cpu to the current CPU
> + *   3. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
> + *      is set, so clearing DISPATCHING first prevents the circular wait
> + *      (safe to lock the rq we need)
> + *   4. Unlock the current CPU's rq
> + *   5. Lock src_rq (where the task currently lives)
> + *   6. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
> + *      race (dequeue clears holding_cpu to -1 when it takes the task), in
> + *      this case migration is aborted
> + *   7. If src_rq == dst_rq: clear holding_cpu and enqueue directly
> + *      into dst_rq's local DSQ (no lock swap needed)
> + *   8. Otherwise: call move_remote_task_to_local_dsq(), which releases
> + *      src_rq, locks dst_rq, and performs the deactivate/activate
> + *      migration cycle (dst_rq is held on return)
> + *   9. Unlock dst_rq and re-lock the current CPU's rq to restore
> + *      the lock state expected by the caller
> + *
> + * If any verification fails, abort the migration.

Maybe also mention that the same dance happens during direct dispatch, where
the task's state at the beginning of the dance is already NONE
(set in direct_dispatch()), but src_rq is guaranteed to be equal to the current
CPU's rq?

> + *
> + * This state tracking allows the BPF scheduler to try to dispatch any task
> + * at any time regardless of its state. The SCX core can safely
> + * reject/ignore invalid dispatches, simplifying the BPF scheduler
> + * implementation.
>   */
>  enum scx_ops_state {
>  	SCX_OPSS_NONE,		/* owned by the SCX core */

Thanks,
Kuba
