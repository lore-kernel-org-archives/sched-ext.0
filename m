Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108E48F016
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768851; cv=none; b=W4re+DW7NM1ajo0w6RoZjTshyZ9Zsy0My8S++GBizEsketk3Gur0a6YtVzmu9o24gdGAFKlDboQghjbFs9LLyYY2UrHyOoaB/em7F/dPIk4WzB4GQB8tuW40OycGpkHwElTX78zvTIFqjytV+br6JhYIHb9Z1jP0mgsiZkfTz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768851; c=relaxed/simple;
	bh=S2IteDg8BCUYq9MzemfP7PtVXLKBwoY3Str6Zy5rFOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MX4sXlMCZoO/OXt7E6BCS5eeR0Tz5F7pFRctbG/DMhCLAdIW+ytpxxEQUUNg/Y6/AY9nEUlEvFiwEa5cmosPXE4PlSVvKqsBOrrQ8WLfNuoFCDUMC/loKu7NbPOTKPceXFHHLMGEvLbMUSd9Og0+6bWQjZDmjq8cnMX98D9G4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5NbRtKI; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5NbRtKI"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e735659b7so39250525e9.3
        for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790768847; x=1791373647; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XEJmFxHtcGebW5hV+i8YWLS/cd2PKjrOjbCuo6aJ0BI=;
        b=O5NbRtKIsB0kK/oHGLYlD9JbnhIz9IVg2Vt67K303gJF9XeAHHi4jv1DZ7OUmu+d4O
         +R6Ib9/EcLSu3wb2Ncy0HIk8YWX2t9E52YYcyaCr7PiumwIJIAMntVZHvSVI/xRbRQqb
         6clZ/XMJMxnAG7uxEEvvf+NCsbe/EIvfqeWglQ2luAc6BAwCSmxIRh0VajXZsQOaoBzG
         zQK+x4qW3dSFNfN0H87T2DIeGRpgqm9JQQxY7350d060qnWVz6JX58EaYv/7JTNm9yIL
         HGnbYq5WSr/0xdAgrTzolEbwx1v+mjMWK5gQEfs7e34wLgENfVVFrcZpvQYiDISztRFR
         NfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790768847; x=1791373647;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEJmFxHtcGebW5hV+i8YWLS/cd2PKjrOjbCuo6aJ0BI=;
        b=L+XdeLKMwHLhdrHF8Q5lZy3eUrOdbGJU9Im2fCtBRL4W+q1kljr5PHfrrO9sD50haL
         0IRsiOQYAvGqcnhfYtPV9s785gB8IrYhecl32tIxzkzjFMzCN6B4+wBRfKbKcJi6NRpJ
         DyWnRodeShAGm+0R84iLN7rhTk1WM6mfQOi2ZDAYYSG0zJUiuZVZlHO+40GacO7MCxiY
         iAy9vMNAByjEfAQvi9SLB83mTkDvtvXGV299jgIYZRwnBghZctrbchfENED9I5ep+vWW
         DQ8uU+1aUjzR4edNB8fWl8fKl1Zdvg0gN99/2AAyi4PXJzxpOeLMSsmDx3hK0Gr0cbB6
         HL0A==
X-Forwarded-Encrypted: i=1; AKwUvBwYXbGmhgpLYVVhD6JKkGT5Vbky/mVJs2jdaezxlmEhxSLLxgQEBTlgyTzmmr3gZlnAI+xnlO4DMlE=@lists.linux.dev
X-Gm-Message-State: AFuF++myXEq/155dK2njFbPoAU7bvXw8M3xzBsnJHxFQ6kaVPh8XZ5RX
	mdYC4VDnrvGqhuWg2wLtW2/SeOCTwhQDRL8BWxZ/SSvATQyOUljnNblGycUX9e7Y83vr1Bl2yPm
	3Abc/n+0Jp+7tyw==
X-Received: from wmdv19.prod.google.com ([2002:a05:600c:12d3:b0:4a0:1046:34c4])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45d3:b0:49f:cac3:c68a with SMTP id 5b1f17b1804b1-4a01affeca0mr17228185e9.31.1790768846990;
 Wed, 30 Sep 2026 04:47:26 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:47:22 +0000
In-Reply-To: <20260930114725.331370-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260930114725.331370-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930114725.331370-2-jpiecuch@google.com>
Subject: [PATCH v2 1/2] sched_ext: Call ops.dequeue() when a task arrives on a
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

