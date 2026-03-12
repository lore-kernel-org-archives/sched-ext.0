Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8899337FF5A
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773289213; cv=none; b=QPSLMo1kq0Z4CDFy84QSybMU7ksDVN5cFLBJ/kver8WA4DKAuj1JEkCt9Vn/erldbPgsXcdU2PhCayQdUbAllSnT/9DO+lzAUDGZwLIsm7iiH225c3fbJ+hVyL+yhA90rO8kQzvpXPSt9Ukrv+ySdrlIsbqyjvtqR7O/aFt7VVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773289213; c=relaxed/simple;
	bh=Sne7+gL9jeS+ckgM5qb45KtTjCW7LxyJAAikGLqIBCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx0a14DKSGTKJv0hDKRs/zwJxtPoE8h4LtdhWYG8YABnhFs0o7KlXfDtBqxhaCqoZM+Git7KemBR1lfkCjwnuQmVY3EsSfNlKoVSPd2QwAHT/GxCTKqSCJKXQ2cc2Cl3c2jVPT8LTj6NdWNH9pby2ceOrWc/ZKOnIDND0AbUv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuRf838s; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuRf838s"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c7382731edfso372257a12.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 21:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773289212; x=1773894012; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qhUZ5w6RDOT7l6VG+dFwbfy5lbHXKXFjU1HWcnbrD0=;
        b=YuRf838sannoJ3lcNmdr5qw8icWdTRn1pusGud00avVosFFRCjrww2FgIOEe+NtNpu
         Vc/Zmv395CsM957Yqn1CvV+B2N5dDyYjnn547cJBuxL8tfMaMuK7ESxinQRIT072MoNV
         23zUYMmJRoEEwdVQ1ZBYkEqCFw26Yh4PT+NmJ2uXHH6EpB1xm61udQYHGG7YitX106z1
         mCm0cTO2l5Qcpk0tGQbqnYwa9ng+PKhspysUEUV/QgmArl/sStzh7knGIihJUUEV+VlA
         IrxvUk0OpIeb3UOavPnngmfs8GEtZE4/hnPk8hrWGjPCjcUSnFn+rhK4zjRyuLf3JZFo
         8z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773289212; x=1773894012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5qhUZ5w6RDOT7l6VG+dFwbfy5lbHXKXFjU1HWcnbrD0=;
        b=qIUcSEeS7K0DAXgm8O2alDjU+5Gm60dUL7lHkwJhFvs4mGyCt9fh2IQ0KBLbmMP3iE
         A+s+9TusCV4lVKGWkSYOnpEAHQHCvy+ElVwwwCS3nC5Ntg+Bzkj6Ck8uf5X7NYnCggUq
         luOWlhVUKfFfbGUE/gwCUeN0TYguKHyhkhL8ZPFpe+Ij7K3zmhtxECnn7GAuFjqY80Pw
         dbmyEJU8yw4UhgO5XoYhDJr5aOJa/gm+wqNBBNvbNb4e+UQNtp2wt04rSLFi9WYsDNaN
         3gSBJqGE3a0YgYHFvLLeC7PLjqylwEYITcLjso50g4SpU2BcRV4PKfPnsfPfInuIE283
         PEqw==
X-Gm-Message-State: AOJu0YxWdabScTz4HhsGG4l5I5zKzFnfpkykaO+GJhWI2unYBK+nZHwW
	w4SD1Sf117naj311rDcRAVoGyXWX1u4BKcuAt1t3+/6+xKH81aaZWFzrzbPgE06S
X-Gm-Gg: ATEYQzxel6JmmSihnkmq/3Sm8vdjLdEL1L8Izu2ipuzNxSlLVl9YnjWDHjMi8eWHdHz
	m/dLjJl45WEDvimTzvLa5kNkYD0iXFwY3Tjn3I+duV7dL+Bkp0rVrKfrvyWck5tjatduRVqvU3h
	8PJc6JOQP6LHA6Hd3G1zQ8H4DiTykS5twiT9NzU5+II8DSldrsNlqcm26rFOndEiQ3br3hggxkn
	pImsaUaOGL094QLebFTGBlOaOi7b9wod4vQT6R4CuR49TG0W4vAsz+pTCxvzq1oHwENI4ljHwJ0
	iWlStyQsMw3WEiATit4nlh746RU4FhCwjCs9w7G0svmeK2iT3+oAKaMZL7shSJmDBT/ulhLIqlc
	L7EobKUW38D+ohRI6IWGdM26r4GQUESbXgX58w0FafnlfvJyTHy1wDnSylb+Mu/nWSn8N8cqjn1
	kffJak9mYEgCEX1sKynfP97sUZGloISOt+zgNFd6JxQ+p4ICu7LAaq
X-Received: by 2002:a17:902:f681:b0:2ae:4222:4535 with SMTP id d9443c01a7336-2aeae769957mr53466995ad.12.1773289211683;
        Wed, 11 Mar 2026 21:20:11 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c33f:dccb:5456:7509])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aebf1dd261sm6265375ad.90.2026.03.11.21.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 21:20:11 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 2/2] sched_ext: Update demo schedulers and selftests to drop ops.cpu_acquire/release()
Date: Thu, 12 Mar 2026 12:20:01 +0800
Message-ID: <20260312042001.955675-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260312042001.955675-1-yphbchou0911@gmail.com>
References: <20260312042001.955675-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ops.cpu_acquire() and ops.cpu_release() are deprecated in favor of
handling CPU preemption via the sched_switch tracepoint. Update scx_qmap
and the maximal selftest to use the new approach.

In scx_qmap, remove the cpu_release fallback and the
__COMPAT_scx_bpf_reenqueue_local_from_anywhere() compat guard from
qmap_sched_switch(), unconditionally handling preemption via the TP.

In the maximal selftest, replace the cpu_acquire and cpu_release stubs
with a minimal sched_switch TP program.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c                  | 15 ++-------------
 tools/testing/selftests/sched_ext/maximal.bpf.c | 15 ++++++---------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index a4a1b84fe359..a11e27c8de77 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -11,8 +11,8 @@
  *
  * - BPF-side queueing using PIDs.
  * - Sleepable per-task storage allocation using ops.prep_enable().
- * - Using ops.cpu_release() to handle a higher priority scheduling class taking
- *   the CPU away.
+ * - Using the sched_switch tracepoint to handle a higher priority scheduling
+ *   class taking the CPU away.
  * - Core-sched support.
  *
  * This scheduler is primarily for demonstration and testing of sched_ext
@@ -562,9 +562,6 @@ SEC("tp_btf/sched_switch")
 int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
 	     struct task_struct *next, unsigned long prev_state)
 {
-	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
-		return 0;
-
 	/*
 	 * If @cpu is taken by a higher priority scheduling class, it is no
 	 * longer available for executing sched_ext tasks. As we don't want the
@@ -586,13 +583,6 @@ int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
 	return 0;
 }
 
-void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
-{
-	/* see qmap_sched_switch() to learn how to do this on newer kernels */
-	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
-		scx_bpf_reenqueue_local();
-}
-
 s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
 		   struct scx_init_task_args *args)
 {
@@ -999,7 +989,6 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .dispatch		= (void *)qmap_dispatch,
 	       .tick			= (void *)qmap_tick,
 	       .core_sched_before	= (void *)qmap_core_sched_before,
-	       .cpu_release		= (void *)qmap_cpu_release,
 	       .init_task		= (void *)qmap_init_task,
 	       .dump			= (void *)qmap_dump,
 	       .dump_cpu		= (void *)qmap_dump_cpu,
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 01cf4f3da4e0..5858f64313e9 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -67,13 +67,12 @@ void BPF_STRUCT_OPS(maximal_set_cpumask, struct task_struct *p,
 void BPF_STRUCT_OPS(maximal_update_idle, s32 cpu, bool idle)
 {}
 
-void BPF_STRUCT_OPS(maximal_cpu_acquire, s32 cpu,
-		    struct scx_cpu_acquire_args *args)
-{}
-
-void BPF_STRUCT_OPS(maximal_cpu_release, s32 cpu,
-		    struct scx_cpu_release_args *args)
-{}
+SEC("tp_btf/sched_switch")
+int BPF_PROG(maximal_sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next, unsigned long prev_state)
+{
+	return 0;
+}
 
 void BPF_STRUCT_OPS(maximal_cpu_online, s32 cpu)
 {}
@@ -150,8 +149,6 @@ struct sched_ext_ops maximal_ops = {
 	.set_weight		= (void *) maximal_set_weight,
 	.set_cpumask		= (void *) maximal_set_cpumask,
 	.update_idle		= (void *) maximal_update_idle,
-	.cpu_acquire		= (void *) maximal_cpu_acquire,
-	.cpu_release		= (void *) maximal_cpu_release,
 	.cpu_online		= (void *) maximal_cpu_online,
 	.cpu_offline		= (void *) maximal_cpu_offline,
 	.init_task		= (void *) maximal_init_task,
-- 
2.48.1

