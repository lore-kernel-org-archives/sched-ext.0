Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A2502574
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778275; cv=none; b=dwQqkOqTiwpD9TuaaJ2yw9xziSS6JgVao8TBI9jzHhos5uvnkkf5ErwpBNfJP+eEWokNOvaUcQT0WXVjDMMojPxw7QgS3yVnKUUU5ds9v4i7dZ4YeHA8HD39+BRfXHrr0jkQpV17zn7XPzVcuJ+N9CTOn3/3QNpOGL7AgQczr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778275; c=relaxed/simple;
	bh=S2IteDg8BCUYq9MzemfP7PtVXLKBwoY3Str6Zy5rFOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cUQduVrOxWTWoeb67AVZbCwCF/OQvul/i7WBbiX0HgwyomxOZalyme0QatZso6hhhnyAUEdsSHHZyVlSvh4qpApLxSw5ThvoDU6cT3380pylr+s9ovWH+L3+rXoDusS0MBmmUVpkgMyhMlgiaDu9s43LWLLGEgqkPMJ2dNtw7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAEmpaFs; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAEmpaFs"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a178080182so6712338a12.2
        for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790778255; x=1791383055; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XEJmFxHtcGebW5hV+i8YWLS/cd2PKjrOjbCuo6aJ0BI=;
        b=AAEmpaFsjXN9tzX/kTWHRw7GogUp1SLVORGaN1kn5RLMAqt6h+RCrQWJL6/6wg0T27
         4UoPS8rZ2Ofg9qZ7Qgb38nfsIwFBxHIl9b06tXfcEAraWEzQJzqfGHhtgReGj/YmLXg2
         xewytAiDkRxW3Q/ycrmHnxWlEwiuHlH9Vk4QWd0IDXNnH/aE74cnn365b30c4fq/pERL
         0HsDc8IJIg01YinFo/rKKAfyU0GyUZdk+iEpQp6JO0921kHQlhmMRxLwvoayfXuc0wj9
         AKsgV9GTHK81RjeuvLhWv2ObCyV815mn2TvOQ5DKERH7r8iRZEC7yDniQ0ZoPQr9EKym
         A2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778255; x=1791383055;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEJmFxHtcGebW5hV+i8YWLS/cd2PKjrOjbCuo6aJ0BI=;
        b=lwv5VooPqBl70Uv2EPdvVmh8qc6Pp5gxI4nbbiMtzjatMANr6T/UCEKTQRCUbi5/xk
         dYrBqHwql5Ihu0gV+RQ8+h2M3JR0k/r482LGFsCsA/yd7ou+nIhnMJdDDuSlbM1cdNnA
         3vKYoyJ/HW3RPW1VOTJdOe8NQ8xEhMk89WYGd5gxJ2pjO05AFLOL1US+h/yann6sq/bb
         rFQOMMedmUmvPjNwIiV0kA1emPPmKNe4HXWxlmEmBDSK/+DX84UBfMopxB5S/ZTGljn4
         FTrMV7YUULqVhXAeBBwfVwyfWK4QufCAWzB30QdgKNhjK+GPoUDZ99CkigwwSSHKDF0q
         n0Qw==
X-Forwarded-Encrypted: i=1; AKwUvBxNBsgLSf9lHl8oofTasav7tHyrK6zTl0XfyJNQm67T6w18YE7pzHiYf4irKw9EGMKjQnCH370BpKA=@lists.linux.dev
X-Gm-Message-State: AFq9FYLhEy6lOBpW9OA2mxlLe79E4PMhp2UT3CjlRkizCEMoEnfxeMr3
	C5E/okOodFSx8KHb+SvUtlL4b4u8r0/lHlYlvjibCnsZQwEs3uFLyVyLfECTXnqwx9F5xSsfh/F
	A+32A1CPDA+Ogfw==
X-Received: from edvn8.prod.google.com ([2002:a05:6402:608:b0:6ac:c63d:3870])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:52d0:b0:6ac:ae5a:a9cf with SMTP id 4fb4d7f45d1cf-6ae19959b46mr1245787a12.34.1790778254704;
 Wed, 30 Sep 2026 07:24:14 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:23:58 +0000
In-Reply-To: <20260930142412.552765-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260930142412.552765-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930142412.552765-2-jpiecuch@google.com>
Subject: [PATCH v3 1/2] sched_ext: Call ops.dequeue() when a task arrives on a
 remote local DSQ
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a task in the BPF scheduler's custody is moved to another CPU's
local DSQ, ops.dequeue() is only called once the task is picked for
execution, from set_next_task_scx() with SCX_DEQ_CORE_SCHED_EXEC, even
though no core-sched pick took place. It should instead be called
without flags when the task is inserted into the destination DSQ, as it
is for same-rq dispatches.

move_remote_task_to_local_dsq() sets p->scx.sticky_cpu across the
migration so that deactivate_task() on the source rq doesn't end custody.
Since commit b75aaea24c9f ("sched_ext: Properly mark SCX-internal
migrations via sticky_cpu"), enqueue_task_scx() only clears it after
inserting the task, so task_leave_custody() still sees the migration in
progress and skips the custody exit.

Clear p->scx.sticky_cpu as soon as enqueue_task_scx() has read it, as
was done before that commit. The source side is unaffected.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # 7.1.x: 18d62044cda7: sched_ext: Preserve rq tracking across local DSQ dispatch
Cc: stable@vger.kernel.org # 7.1.x
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 493b7aac7087..5209510d6a5e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2152,6 +2152,13 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
+	/*
+	 * An SCX-internal migration ends on arrival. Clear sticky_cpu so @p can
+	 * leave custody when inserted into the destination DSQ.
+	 */
+	if (sticky_cpu >= 0)
+		p->scx.sticky_cpu = -1;
+
 	/*
 	 * SCX_RQ_IN_WAKEUP promises a task_woken_scx() call once this enqueue
 	 * returns. Only the core's wakeup path delivers one. The flags stashed
@@ -2190,9 +2197,6 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 		dl_server_start(&rq->ext_server);
 
 	scx_do_enqueue_task(rq, p, enq_flags, sticky_cpu);
-
-	if (sticky_cpu >= 0)
-		p->scx.sticky_cpu = -1;
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

