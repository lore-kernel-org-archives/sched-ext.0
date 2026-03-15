Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A71DDC3F
	for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563116; cv=none; b=qj0E4QbN9x3/HRjXkYNZ2/ksA1n8fm7AmBCzovGVk90afXIEgTQpyvhbOzNDEJwtOVxfDY+GcHWrscwVjh2OddzBgnz4br7JTKgCP8Hs7iapBV5si66AHDr0j3t8uXJAHqrfDXWidyJeZo6TIbS8gQH4TGYBIjduvJYKO6aIBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563116; c=relaxed/simple;
	bh=9i0eFx4jvCNvU7ITXLCx7UFJEI0OV/bNnPFbH2fvpEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Un4Dh5aCswOAAr9KArLrmlfzJbGsmxEAmSvvOl+ANKrNbhQNXU5LVeN5aSmPAODzoYn/CAmloMcMfbi5S7LtADvikOMVKrHaSr7h9YHGn2nXEwek3hrwHT0W673FNrW1gBbOObXs4pD2sqkHWvBjp5sxcDZx8c805Apd1tSqdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS4ypakZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS4ypakZ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7381c4345cso1458589a12.1
        for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773563114; x=1774167914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGK6pI+tHo/Ps38jwDFh34oxz4LsdeUT9vyoXbl3wIM=;
        b=eS4ypakZQyLs/dXSEw70vcs04cFrs8UA6SnNasCrxzjSfBMQOX01ca0P9POgsHXGDW
         YpDk23609uERfcHcoWXPw3vKwfUR5lSFeaLm1cdnC4lLHNVpK150tcIJ8336ND//Dg60
         k0QqUuKtFiLTEtNTtd8N55r648/ZKNIivxBkfGOYIJCi7gsI+UXAagQuebhR0MyKazyh
         mukf6qimsUkeReGzEChY/SZ4zk9P36McypObXQLxefBsr5HN2L1wpnxNGbFe2SGnnzeZ
         iyWADGwKdEvGHCGi2jtwIRhPZbe9kaUv59bYGrr8jsjETt4MCjArNwNJi8PWnEgjxaH5
         Q4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773563114; x=1774167914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GGK6pI+tHo/Ps38jwDFh34oxz4LsdeUT9vyoXbl3wIM=;
        b=CPXtUP04G/TJaYhzFfoKceKpDEZDAJWkhulX+57KdoGaCVEiWMfPOwIDuypbqUBkCp
         4pnlOhGbxPgoqH0ZAuxO2wbowjHB/6cCA0qItvn1THElIJ9g3QpQytVqR6oSygXcg7bp
         bhBeKjHT+7mHPkRTgjHS5MH/+vfW+n7xZ6c+3VV6gLqhRcbLHFpgU+FslpicUNVo4pFL
         su2VrSrNgFcXK7ibYlzvmQ57r9azkL78TajiqWzz7PiQyR5aeRdzRXRUNgA6BXz9nGbA
         CVoOJNM11zu/YnQKok17FrSkeOgkv30Q+tZxucp4/F7agLTxacTbTpPjOYqi1XAJhIBq
         BvaA==
X-Gm-Message-State: AOJu0YzpHQZt7zUstgW/2dlRh5frmEnUTgrE5fDF4aLr5Fv4yztmY4Uf
	QJUsc/3LNiY7czrW3XvMY3aHxb7luyyRroR/yzzu85ZgP/n+b6OqNE0+QHK0tPC6
X-Gm-Gg: ATEYQzwzpIxR0n/IBrY1G8crJBFbuPJ9ZHjTAErzK97LyI1rulRZ//Z+SFgqvtsJDxh
	znSv8Fuik8LF7PcxY7GszMOVjz2R1LD4GHoHMvLDHP9DG6wlnZs/DYSxLxxSI1Q6k9qd6PyEAj/
	3hcTLK+6yN3Wg9ltgtyHYka+4MhNb5fL2ntQhXTm6+6+WdBCrQi2PMSm3FCu2Lx2MnK+LDqq3gl
	9iEtP7CauIRPrIp2Re66bX/t/ZrOP8lttu0iFkB776YXnNU77Cf+NGAMwglvlTyhjM8JNEZszlt
	MaPgYZl+16OliqrGgceO5oZAPVqhHUKlnE6pXPxhZokie+IKtVfc6vvTAK41659vBcoEPPUDkK9
	zBQVddOA7y3fmF94hOT0blyrhI62L/6JNW49QFFj+y9nTovjC4tM8BakOe1D5Rq0T4AlnPToTf7
	zUr6GCIaBhMqjc9J9+Ump91aRqKVHWMAqahbCWKrXbzC/59L+bT3Wy
X-Received: by 2002:a17:90a:dfc7:b0:35a:a1a:6b81 with SMTP id 98e67ed59e1d1-35a11a6de5fmr11110136a91.9.1773563114058;
        Sun, 15 Mar 2026 01:25:14 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:53cd:7adc:9650:ee87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a1c34fa3esm9316523a91.4.2026.03.15.01.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 01:25:13 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v5 2/2] sched_ext: Update selftests to drop ops.cpu_acquire/release()
Date: Sun, 15 Mar 2026 16:24:41 +0800
Message-ID: <20260315082500.597204-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260315082500.597204-1-yphbchou0911@gmail.com>
References: <20260315082500.597204-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ops.cpu_acquire/release() are deprecated by commit a3f5d4822253
("sched_ext: Allow scx_bpf_reenqueue_local() to be called from
anywhere") in favor of handling CPU preemption via the sched_switch
tracepoint.

In the maximal selftest, replace the cpu_acquire/release stubs with a
minimal sched_switch TP program. Attach all non-struct_ops programs
(including the new TP) via maximal__attach() after disabling auto-attach
for the maximal_ops struct_ops map, which is managed manually in run().

Apply the same fix to reload_loop, which also uses the maximal skeleton.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/maximal.bpf.c | 15 ++++++---------
 tools/testing/selftests/sched_ext/maximal.c     |  3 +++
 tools/testing/selftests/sched_ext/reload_loop.c |  3 +++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 01cf4f3da4e0..06379eaa06df 100644
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
+	     struct task_struct *next, unsigned int prev_state)
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
diff --git a/tools/testing/selftests/sched_ext/maximal.c b/tools/testing/selftests/sched_ext/maximal.c
index c6be50a9941d..1dc369224670 100644
--- a/tools/testing/selftests/sched_ext/maximal.c
+++ b/tools/testing/selftests/sched_ext/maximal.c
@@ -19,6 +19,9 @@ static enum scx_test_status setup(void **ctx)
 	SCX_ENUM_INIT(skel);
 	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
 
+	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
+	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
index 308211d80436..49297b83d748 100644
--- a/tools/testing/selftests/sched_ext/reload_loop.c
+++ b/tools/testing/selftests/sched_ext/reload_loop.c
@@ -23,6 +23,9 @@ static enum scx_test_status setup(void **ctx)
 	SCX_ENUM_INIT(skel);
 	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
 
+	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
+	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
+
 	return SCX_TEST_PASS;
 }
 
-- 
2.48.1

