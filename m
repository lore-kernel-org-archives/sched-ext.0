Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F053DDDD8
	for <sched-ext@lists.linux.dev>; Wed, 27 May 2026 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874847; cv=none; b=my5juXqcGeSb4LX7cCF05Wm6c+tGHv7K2oy1v1WJWjlyEo8VAfzqV1BYLi7HF992/VvIBT8GQJA1FwzR/PBdGohNu/cOppXatXanhSe3DVdjz1c1ubCRVxhSQEjXYnu2LcLQlTVS7YWhBAxS6qmdBIDXNkKWQ1DTNCzMg6eoZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874847; c=relaxed/simple;
	bh=WtgAnpJGi8d2V5T2iU0SmPo8DW5jzZPXxYgeNriIfvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVhoL8u741ImnPFNiASxV27/g3YT413MwF6XWA/ShxSE/ZySwEOolzPxcG9lcKLSy2GTZ5DfInjVZoO6RxaTcae9SCL6iU4pOnvAbgxAdvK2MuhRWooC0b2o5prAKuyipI9U7KA3SZsCSeujZerVNOdZNjQv0AUVlSZqfyEbUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTjbg3QS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTjbg3QS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b9ec9443c2so64572365ad.1
        for <sched-ext@lists.linux.dev>; Wed, 27 May 2026 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779874845; x=1780479645; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT5ovlXV2hwYWFaDR0cFf/KGNdIRaHnP1CwRs2YeKmU=;
        b=oTjbg3QSBVjS2Y+6goFPZqSZBiy31Q+eYOZQD8cFt/rS/E6y5pjTuZriA2vWOjz/WH
         bUsII7QeRoAyiMyM7/kocXZBx+Onrf8RoBNefWJrKVEEVovLdXdF1za/RrhRSJkh5fXK
         tLsa1TdcaFm8JCVt/OZGD6jK3XEl4WeEYQOlGNNBqz2a1hshZpd9W/0DTSvD4ca76Zee
         MiV1Qnq5YpN1rYSm6NpixOYwO08g0MyCtKq5YcXFvtrc47NJWrR2P1iGW47O6JUQYhYB
         kYgrV+3Qe7DxzDtX86eFVRnhsXgVpOswoaOpLhQjmysyF9GUMFh77TMVsFhMFxSiTbyq
         /h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779874845; x=1780479645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tT5ovlXV2hwYWFaDR0cFf/KGNdIRaHnP1CwRs2YeKmU=;
        b=YEmGZKerFkXyGNlWamaUezBYLboqPj5Cxmd4T7jaGKUZoM5zNTxbZiENjm4qiHcM7E
         M01KU8XHvNl3ExD7+iI0bK8XBHt15k/pTR6lTDFzwiQTgvHdNKx8sYQ/E2UwAmZ7ObB5
         i7+HWrsUvAp8jiL0Xr0rq6JVDESXKx1+i0ROf65MlwYEZD5q52groZHADXAtS/VIVg1e
         dyZT4ZjjLRbj/G9aC5i7PiUkfGg/+Ajmuk/qW4V12XqaoHhFev/OmPVzq5UMHI5ui52R
         o0lcTLggm5SXEIs9CsjcVMDR8FKsRqgKsLEZ9oykBTtyZrB4CHvFGLHx/r8Hpfdcgt4E
         XgrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ghqvKDhfxQoFe4kR7iMCP25rAwQPjk5CyW4ijS6Z2oCxkHJUciB7WXvUi4KFUzKQxEHPs1IAzep0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5cBB6BfZNv8SUfd99QDtWxtas6MfqXi7bBLyXMrM7bAqAOFm3
	p0u0HkEv4uXFjwq65HyNp037u96FTTNHhvKFcig0X+wS35sAo8UCeelq
X-Gm-Gg: Acq92OG5Os1im6BGF+0CNUCu2CVtrKphCw06hwjJwjDurDu9Nm8g5ql/sqXGbo+u3Ja
	zjHmDgapIC5udwqbhS6tXjCu9nlGc8wByfFnZdbQ7ldpf7mIf+ErlmRYS7zwkFQizfq7NXIGesO
	Rren6osjm48gW+rSY5/F2JbXndUSQxS7Xu4g2xfjKOLAv4qpZjN/ZmWyguPScK8L5W76U1DSLNf
	CdL6KxkfWr2iOCMH7E/Q53Fn4C6iVPl5EqumP6qmjS/sAeZ0jWOSLKZjSRdCuJ4EapJ3xJYWdl7
	g5y3L9NzCBsumfXZNHvp9wyKARUQ0JJyDJ8yjDyCcHMrug6oie6LoFU3Um7jpGulLEOeU+TrdL0
	2jPFvQQ8GkiSyXG19T85PFdMsbEJCTufBtZPldat8mDgRnu3EM0zQl3UIquqHCKI5ZhnMXnQ7U6
	Okvu76DC4x385zye5STnwpVsq6kFfFjRVzhjv3QdwY8VI=
X-Received: by 2002:a17:903:2ace:b0:2b0:badc:c9cf with SMTP id d9443c01a7336-2bea2227affmr236833765ad.13.1779874845418;
        Wed, 27 May 2026 02:40:45 -0700 (PDT)
Received: from VM-0-14-ubuntu.. ([124.156.198.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56bc46esm157388715ad.25.2026.05.27.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:40:44 -0700 (PDT)
From: quzicheng315@gmail.com
To: arighi@nvidia.com
Cc: brho@google.com,
	bsegall@google.com,
	changwoo@igalia.com,
	dietmar.eggemann@arm.com,
	haoluo@google.com,
	joshdon@google.com,
	juri.lelli@redhat.co,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	quzicheng315@gmail.com,
	quzicheng@huawei.com,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tanghui20@huawei.com,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	zhangqiao22@huawei.com
Subject: [PATCH v2] sched_ext: Rebuild fair weight on ext to fair switches
Date: Wed, 27 May 2026 17:40:37 +0800
Message-ID: <20260527094037.3494671-1-quzicheng315@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ahXWaL2BYLU6ukkO@gpd4>
References: <ahXWaL2BYLU6ukkO@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zicheng Qu <quzicheng315@gmail.com>

Tasks running on sched_ext do not use p->se.load as their active
scheduling weight. Their nice-derived weight is maintained as
p->scx.weight instead.

When such a task switches back to fair, CFS expects p->se.load to match
the task's current policy/static_prio before the task is enqueued.
However, not all ext to fair transitions rebuild p->se.load. For
example, scx_root_disable() switches tasks back to fair directly, and
partial mode can move a task from SCHED_EXT to SCHED_NORMAL through
sched_setscheduler(). In the latter case, set_load_weight(p, true) runs
while p->sched_class is still ext_sched_class, so reweight_task_scx()
updates p->scx.weight but leaves p->se.load stale.

Rebuild the fair load weight in sched_change_end() when the class switch
is from ext_sched_class to fair_sched_class. This is after the class has
been changed and before the task is enqueued on fair, so CFS sees a
native load_weight derived from the task's current policy/static_prio.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
Changes in v2:
- Move the fix from scx_root_disable() to sched_change_end() so the same
  ext-to-fair rebuild also covers partial mode SCHED_EXT to SCHED_NORMAL
  transitions through sched_setscheduler(), as Andrea pointed out.

 kernel/sched/core.c |  2 ++
 kernel/sched/ext.h  | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..c694aabc451a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11200,6 +11200,8 @@ void sched_change_end(struct sched_change_ctx *ctx)
 	 */
 	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
 
+	scx_rebuild_fair_weight_on_class_switch(p, ctx->class, p->sched_class);
+
 	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
 		p->sched_class->switching_to(rq, p);
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 0b7fc46aee08..1f8248c897af 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -35,6 +35,14 @@ static inline bool task_on_scx(const struct task_struct *p)
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
+static inline void scx_rebuild_fair_weight_on_class_switch(struct task_struct *p,
+							   const struct sched_class *old_class,
+							   const struct sched_class *new_class)
+{
+	if (old_class == &ext_sched_class && new_class == &fair_sched_class)
+		set_load_weight(p, false);
+}
+
 #ifdef CONFIG_SCHED_CORE
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi);
@@ -55,6 +63,9 @@ static inline int scx_check_setscheduler(struct task_struct *p, int policy) { re
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
 static inline void init_sched_ext_class(void) {}
+static inline void scx_rebuild_fair_weight_on_class_switch(struct task_struct *p,
+							   const struct sched_class *old_class,
+							   const struct sched_class *new_class) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
-- 
2.43.0
