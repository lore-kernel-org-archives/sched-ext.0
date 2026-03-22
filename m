Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE32DF3FD
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774190685; cv=none; b=RHn9p2C2KuMCTmygVvkmY0vYDCHr8pQu+NAIyNjIzFsT129aKQfjJrjY+27NQEcFTVj2Drt3I4QG7rEhNYNPniESG6yAN97y7Gt24xsVNZTpqk4TeRUvqm8pOf/HnQq+7ZiZsgxjwr+5RSxIg1qHd5At5tP0eQVRUHZQLDqL1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774190685; c=relaxed/simple;
	bh=PK8H6HOQ1dm80hbWQYWEPLEdLe8Rfb28Xs2viOtbWJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pE7i0B3EuNQADzt9MRi7lIXN320ZTVrRQjRROup5wpvT2hnOdJo9BGV0UHp85V636phCCLzx3hfPXq8sWd0yq8H4JBAWpKDESfbbRR6fQrgbDwropgnMX1L2EoSP8sJEoomezKVnSnyvJMFOQ37VdEXXBWbUhxnAgPpBxHa+o2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiSkLu/a; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiSkLu/a"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a288a2c00so1597150a91.2
        for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774190683; x=1774795483; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VpCv+a9MfuThGGUoCKdAzGa8oLlUPNjtdKJuphSnHw=;
        b=RiSkLu/an3Na+zJWybM7yeSrouoCsn9BkdNpbud1Prg4e9DWsOdxUSstoc1qA3ywD0
         rw3vD/R61oJJi5qpN66Ir4gkg1jOYSzOpPhSsquaRxMVPkIFUWZsCCIz3p4/QPXCOWNd
         4f4vE1+sFvOppzBHg92ZZMDnqmT2DlCWSajMMaJsFr6zdJLsu7WlMjiNnGmShLeH8JGC
         9aDl448gtp8m4MmQLFVMqXCZzgKtrHG+Pa+Lr5XGapTY9CUWaj+eYOIJmlwHmZsgSa08
         53jF5rm1+5qvSMtD/gAY0gInVCrS17OmYli4tAavXIsgUGXoCFe93RagiJQcK4DikZlg
         sTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774190683; x=1774795483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VpCv+a9MfuThGGUoCKdAzGa8oLlUPNjtdKJuphSnHw=;
        b=SZJBu9RLfvy4g3hIpMGD412bFa8/EwAvf+HX0ja4nvVD5PCOKWsAfkaiFLQfOQ68CC
         0vrppJB7CRlKQ7j8Em3yGByM2Z46LHQHx3LjXKravVuBTM3d25ic0CmDBBeVS/qqgCAb
         kU3vBNZISVVdEHqR9Hs75guMDk2gc9LOcuS8TYDHIh5FZ5Z1T0TUck+Fakb5bNgMY/BB
         /dHtNY4LolEXKnbTvDpjoBrlS1g10EGCV4j66rVz8klHLRdC9KYpIoiBfE/p1TDbKDG9
         ABqF7o7stS1otJz5eOGM87P/exZ59tp9FUqPZr9BAgZ6F6UyDCxhN2UmT+3KQhILCNg/
         6e3g==
X-Gm-Message-State: AOJu0Yy8dmwgPSQK5zRZRLmk+H8uscGUM83crujGtBsL6tKmGmp9X99/
	Z10SBzCt8Iha0Es7QvFp8hz3is6h3o2FFUqcLtq4M/CVf1LWp6su5UHK9nfzM8uJ
X-Gm-Gg: ATEYQzzxvRLUZSLWDFmwehYJprYmobO1UhiXQuGrg7rjDa6p+Mr9p+JvczlVBa+hFdN
	D3/2VywZeXwbjAkbe2c3NHdwyGrvr5hTP50K8eegRZZDi3vdW/4t7r9T+1r/8Y1X72un19vcm70
	rEtMufzv5f6/OQkMs7oBDQJ2rglJtSz8pNj15HLOOzaHwgs/r3xrnGreX7fxHO4tzmDn7ufyuNA
	g3aq6Yi1ksCyhdtKdqv8HlJo9ayZxv5ZYrFossJwfQHR673nf34tguUMWoJqf6GNaHPEjXjJF8n
	ZOjpVqK6dcfVHQwKksEuDzoZOVbn55HilKnamOOQ6zDiVGMC+yy2Pt+lNhXLXM7j70m1+GcdaJE
	HQIyEi21ZmJlc3KlVYT5iFQlctIJk3lG5AxVMUSvkJtG9u5JWSb5CY0bm0VBR4sKc7hPb9utZax
	8w2RQZaZCEtlqyyoQrCnMxfTzv7DcshEYPEdaqbOXdUlnLonzK2ko=
X-Received: by 2002:a17:903:946:b0:2b0:531b:b3e6 with SMTP id d9443c01a7336-2b0826c382bmr92678815ad.10.1774190682905;
        Sun, 22 Mar 2026 07:44:42 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:a92:d962:9ffe:7c38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352a17asm78926495ad.24.2026.03.22.07.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 07:44:42 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1] tools/sched_ext: Add __COMPAT wrapper for scx_bpf_sub_dispatch()
Date: Sun, 22 Mar 2026 22:44:23 +0800
Message-ID: <20260322144433.1649092-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __COMPAT_scx_bpf_sub_dispatch() to compat.bpf.h so that schedulers
using sub-sched dispatch can build and run on older kernels that lack the
kfunc. Guard the call with CONFIG_EXT_SUB_SCHED and bpf_ksym_exists(),
falling back to false when unavailable.

Update scx_qmap to use the new wrapper instead of calling
scx_bpf_sub_dispatch() directly.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/compat.bpf.h | 13 +++++++++++++
 tools/sched_ext/scx_qmap.bpf.c           |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 83b3425e63b2..f24b9a1c75ad 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -108,6 +108,19 @@ static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
 	return p;
 }
 
+/*
+ * v7.1: scx_bpf_sub_dispatch() for sub-sched dispatch. Preserve until we drop
+ * the compat layer for older kernels that lack the kfunc.
+ */
+static inline bool __COMPAT_scx_bpf_sub_dispatch(u64 cgroup_id)
+{
+#ifdef CONFIG_EXT_SUB_SCHED
+	if (bpf_ksym_exists(scx_bpf_sub_dispatch))
+		return scx_bpf_sub_dispatch(cgroup_id);
+#endif
+	return false;
+}
+
 /**
  * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
  * in a compatible way. We will preserve this __COMPAT helper until v6.16.
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index f3587fb709c9..dd44d8db0341 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -490,7 +490,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 
 	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
 		if (sub_sched_cgroup_ids[i] &&
-		    scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
+		    __COMPAT_scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
 			return;
 	}
 
-- 
2.48.1

