Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278918DB1A
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243606; cv=none; b=qpfVOuzkLbKFfsAqOrVtYvn0Gfc3YUf9H3b9xK5CvY+owgpIn1WZUyHMU0DmjwYJ6OulzTgbBbFKJvF7gIGfrVRDC9sox1Qr1Z1gnfSE9OArD9SCl90sRVYUl62sTEijGd/srbIBVQaIjhBkziWMfWZRhfGO4/vqLXcwUoSODdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243606; c=relaxed/simple;
	bh=U1ejqvPOhf91bwxiikwnqtkE1lXQRoLHEHkt/PT5EU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1MmQjsj0K1xak/7llsixJDPST5UsyrCHFuq02ZbZzEyI6OnzsP8bNCkYFNkER8/FFS9h3V8dAu8TYzjYiLZrc8MiGEzbv29v0tNt66YqnLYlZznmJoquiwNcwZ/D5G0FLo5Do/t0WI9lTY80r1/Sn12eW8soHdGeP1Fmvhtypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpSq7bt0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpSq7bt0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aea68839a5so480285ad.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773243605; x=1773848405; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CCZGmyw38hI7W+dmiKQS1ZwG5zoB6fr9T89YJmp8DWo=;
        b=NpSq7bt06dGzNKk/iRfb+rW/57gDcmmwfPy2p0XrlzFuV6IeMgm5DvWxSUginWiQvc
         ZF1PY4jVNnnsvbnJ8DrMnv03bza9VGd4Q3OdqQl69CO1bS4QepFaZw7xaBcBFfaCgfZ7
         5N5OqPGSd1/B3DLP44+iinkkg08KwPWnm9XosxG17LFKfO9tFRtLGYXmU1r6UCzRsHUp
         m/aymABQpQ8+gTsAJp8Ohxh4118S0/AoQt1TqPj04/MM/Os3MpT4O2e/iBD2a1izlufJ
         E1d1XbJmKfw154UH/p1kHgEGPzheIg+ed2Hkcdqb3T0LXtU53pT2k/KeWjgAwHyRB+VG
         ErEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773243605; x=1773848405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCZGmyw38hI7W+dmiKQS1ZwG5zoB6fr9T89YJmp8DWo=;
        b=R7CHt+mBc3FN17wqX1QInN+l2L6g7d1WerOql9D8Rz3JGGQAfwkmTTTFxOJbksyoP9
         s2B+7RE7pUfxJC/wJlzTg9ZSqvs1DlxGbUfCyitDijo2EbG6avTZLDIXV+oecalYgUOu
         Fy23v1/cyU+HBnVQzZrSqIsIz/7YLJOxmv3nx9sDKiXzG5Ti7K81Fsc/KXXDHF5VM45s
         XD1TznzrBvQvjCDsaa+BI0fg8zCfeEG3nejriOXe34JxcKXkp9y7rnlapbY8oAV2boPG
         OBxPWx6xTNuxmZP6GgbPOgSbnzAFLm30F+YEnOXbVYiQPUqgVMEBFFdnKc5zfnJOihhr
         evcQ==
X-Gm-Message-State: AOJu0YzNTOau7ZQq7j0g55wSLD0z2JWCa4bgCBPz1RG/nxNzqsAnZVjO
	ZkGuiYVI7fW7yH/VL4JOKQT4j/aa/16nzD6QjgOjAHG1qHAJ8IVpas+yTvDgJVfv
X-Gm-Gg: ATEYQzxWpnLUci7twAeSwejgZSpaheKhUvhzsfVEJ7pdsTM99kWH3JrXlirSk4Yix/D
	dGxunqCiPaT3/ClpecNtGtBbiQpYoAhos6m9OxIuxV4qyJBI15U5uIh1v/jghfsTtm431jVp0UM
	Xeeu2Z9K/0mbBKAoA0HMGPOCQnczVnfZive51H3IUaAM7Nq5KJB6n9cPGHWHk3OnDaR7A3FXPBK
	+oSqlr6uBdvLgcbtXjASLW5frhtDnV/pJeq4x7FpZIKuMGH+delSNY1dwontrlHG8cxJITq1wKK
	0XsVd0YBtpZNztXxs9FzuwFTxlvn35KP/WIpmrhDgw2i7sLlLi2NmoHjiyl7M/cU7/eFMk4AIGc
	WFSVi0dtxzaDY3CAhyAc4mIGjkLgPa6E5gybskbvVrS5eWsCyMRPRSxByM75ffCf2Yuy3eD67S+
	GvwDtemcFJ6CK13kt4/5azrSWxLtevIMdLw1s9ZgZq78SarMwcG6ME
X-Received: by 2002:a17:903:1a70:b0:2a7:5f26:aaf9 with SMTP id d9443c01a7336-2aeba4eabfdmr95465ad.14.1773243604347;
        Wed, 11 Mar 2026 08:40:04 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c33f:dccb:5456:7509])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm27204275ad.40.2026.03.11.08.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:40:04 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Add scx_bpf_task_add_dsq_vtime()
Date: Wed, 11 Mar 2026 23:39:57 +0800
Message-ID: <20260311153957.699608-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing directly to p->scx.slice and p->scx.dsq_vtime from a BPF
scheduler is deprecated. Currently, if schedulers want to add a
virtual time delta, they are forced to do it directly via
p->scx.dsq_vtime += vtime_delta.

Unlike the existing scx_bpf_task_set_* helpers, this direct
modification bypasses the scx_task_on_sched() authority check,
potentially modifying tasks the calling scheduler does not control.

Introduce scx_bpf_task_add_dsq_vtime() to provide a safe and
approved API for schedulers to easily apply a delta to p->scx.dsq_vtime
while ensuring task authority is properly verified.

Additionally, update the deprecation warning in
bpf_scx_btf_struct_access() to suggest using the new helper.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c                       | 27 +++++++++++++++++++++++-
 tools/sched_ext/include/scx/compat.bpf.h |  9 ++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e7ab3647e35f..26a85ec58d31 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6963,7 +6963,7 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
 		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
 		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
-			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
+			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime() or scx_bpf_task_add_dsq_vtime()");
 			return SCALAR_VALUE;
 		}
 
@@ -8281,6 +8281,30 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 	return true;
 }
 
+/**
+ * scx_bpf_task_add_dsq_vtime - Add to task's virtual time for DSQ ordering
+ * @p: task of interest
+ * @vtime_delta: virtual time delta to add
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Add @vtime_delta to @p's virtual time. Returns %true on success, %false if the
+ * calling scheduler doesn't have authority over @p.
+ */
+
+__bpf_kfunc bool scx_bpf_task_add_dsq_vtime(struct task_struct *p, s64 vtime_delta,
+					    const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!scx_task_on_sched(sch, p)))
+		return false;
+
+	p->scx.dsq_vtime += vtime_delta;
+	return true;
+}
+
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 {
 	struct rq *this_rq;
@@ -9167,6 +9191,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_add_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 704728864d83..06f298f6909f 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -343,6 +343,7 @@ scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
  */
 bool scx_bpf_task_set_slice___new(struct task_struct *p, u64 slice) __ksym __weak;
 bool scx_bpf_task_set_dsq_vtime___new(struct task_struct *p, u64 vtime) __ksym __weak;
+bool scx_bpf_task_add_dsq_vtime___new(struct task_struct *p, u64 vtime_delta) __ksym __weak;
 
 static inline void scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
 {
@@ -360,6 +361,14 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 		p->scx.dsq_vtime = vtime;
 }
 
+static inline void scx_bpf_task_add_dsq_vtime(struct task_struct *p, u64 vtime_delta)
+{
+	if (bpf_ksym_exists(scx_bpf_task_add_dsq_vtime___new))
+		scx_bpf_task_add_dsq_vtime___new(p, vtime_delta);
+	else
+		p->scx.dsq_vtime += vtime_delta;
+}
+
 /*
  * v6.19: The new void variant can be called from anywhere while the older v1
  * variant can only be called from ops.cpu_release(). The double ___ prefixes on
-- 
2.48.1

