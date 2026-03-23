Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54577396D3D
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276689; cv=none; b=QyvFJvvCyB6aBQEQ6uTpnFdhe1lCbX+nu8aOdhxvsBF97zDn8Uln+mnp9w0LSvGdnDO4/e+6w4yY+653msTPEB8JQHrGe2qijRpt9Qi4PNqLfzebrDZlaPpm1pfho7ZHxbXn4NyDRtMgNc0SfYK0zVrBMNxX6eTykqrF25QQ1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276689; c=relaxed/simple;
	bh=WBagI2WzUiOgyCptEIcLLSOnUNtbYdGFu/soOKVxv30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPyoKcqfbselXSU3Q9KuE42YoGcT/xE3i2rGPgbK71GMi5m6c3y0vHyXXfwQxvyaXec1d7oysBjupc9AcEpl0ASzB2VmfmP+BTpoGFbmDZvq894GGZTdO2qMX32bPPtFnexc2aaZMvvbKM0htzifab3mk8bX9VppavES6WLFGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I520gt/z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I520gt/z"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aae146b604so28337835ad.3
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774276687; x=1774881487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXelyMCLhbRf9qUOnK73+vaWYPpEfZGU5o1SuvXyV6c=;
        b=I520gt/zaUbBjlDcVfSQuTywMaNqoMqBWiOHglZSbFxtoHjAKOyH2HwTEIi8dvHqWA
         hA3+1fdtJBAdtGK04Z4wKxhueCjOQQ4ctB4P4FeZeak1JsHqI9cJhviQby5aWwGiuS0E
         wgZ+zV8pdNMKybOTL5d7vaWbqXiStNoafF/55p46+HmSWU4sxrvkJvKpgimU8AzC1WVp
         icsCkTrfQP3+2oPqAllpXwxKDF7xj0Cmfxof2Qjc2GWrMvHssLbTFWRZ58LRBuneD0gJ
         sqaEGU5Vhd1fl6c3bFX/6df/dUk3HUKqhfUIOHu8AxSU1qG436VswwdBkwtRQ1qt9r1H
         JiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774276687; x=1774881487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXelyMCLhbRf9qUOnK73+vaWYPpEfZGU5o1SuvXyV6c=;
        b=NKBtxZN2WlOpXW2VGrgUmgBY775+McdOG5Jp7eVexAyLlocHb0T/m1mZzH6p0eoesE
         ONUfgQzeGUT+OHeRu0A44x0X/8X+l3hQq1YpVxccXIbuZg0NMKlT+SXgnHsggKBJdbbB
         h+SPaGOt3MmW2uQ7wms4jhhO4w9bLd7lo/BIe8rJvlw+qHC9TBUHcyoZHLP6IKMJoWtP
         VPimAnCvkSpFRjxLgdVEJdjwRHNZ08oWyx2EJ56xG8Jz6yjDn6AEbURUjkKvLWZKomEj
         kadkXQvDf+N9YZKhVt3JccsysYMQijcWKT5HJ2/mX+K+J/GK45vi2fHawxwCkKOj4WyZ
         gTKw==
X-Gm-Message-State: AOJu0YytWGXlTbu5W8QDFwc3+UpOOjDETS2O90Klnu/ZrMoCvHPgFk7i
	GrpbqFq4mKYubVzLemG64xZ5XDaNyX0dp4vzbWzHzBS9RVLmdDPnvol8fkDEmVuN
X-Gm-Gg: ATEYQzw1imBiQB8pw8B9BwtJUdk9tObBk+sXQzgjQgu8Q7m+pMUlm1+AOd983B3AUEJ
	T4ciwyXwBSV84V681DPMPg7/35kGctv7SxVnnTn+FPqSrrF9bJrGd85FDEisEV3Ip9SQzHrTfDL
	EGcxGK5jXp3UdM0Dh2oHpH97SF8ccN212mDq4SjYVUPH8qkc6YaifTldF9zlgEGt98EE6jrZx0j
	taQM8r5I4Tslqd36RXsrLrn2NbByIFkebG5vmZ3TGnPRnzjNRODSnPIwV+Wybc1AjavUxuHuVVc
	GZpgPCcXdHHQvs3E2hkkiqNJ7+uerFDEhcw+dMPWtjSTDwLS84qfg2GjlD69xo4v+3JN/TU+RJH
	WtSm/gDBVQisw6ne3KTptT52iUIr6dIRSW5r1kjyzNU/m7nn2pKsX6XGrEKhECLsKmCiwY7fkqq
	2Fe5JhJdopp/YX3imHF4OGh1XHJ8N2JKISndyc1FNZJ+AE1j8RmAUB
X-Received: by 2002:a17:902:f690:b0:2b0:700e:fc9b with SMTP id d9443c01a7336-2b082793ebbmr132074875ad.34.1774276687268;
        Mon, 23 Mar 2026 07:38:07 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c95d:66f0:4661:427f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08351675esm145744895ad.14.2026.03.23.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 07:38:06 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 sched_ext/for-7.1] sched_ext: Add scx_bpf_sub_dispatch() compat wrapper
Date: Mon, 23 Mar 2026 22:37:36 +0800
Message-ID: <20260323143757.4149146-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a transparent compatibility wrapper for the scx_bpf_sub_dispatch()
kfunc in compat.bpf.h. This allows BPF schedulers using the sub-sched
dispatch feature to build and run on older kernels that lack the kfunc.

To avoid requiring code changes in individual schedulers, the
transparent wrapper pattern is used instead of a __COMPAT prefix. The
kfunc is declared with a ___compat suffix, while the static inline
wrapper retains the original scx_bpf_sub_dispatch() name.

When the kfunc is unavailable, the wrapper safely falls back to
returning false. This is acceptable because the dispatch path cannot
do anything useful without underlying sub-sched support anyway.

Tested scx_qmap on v6.14 successfully.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- Adopt the transparent wrapper pattern with a ___compat suffix instead
  of the __COMPAT_ prefix. (Tejun Heo)
- Keep the original scx_bpf_sub_dispatch() name for the wrapper,
  removing the need to modify tools/sched_ext/scx_qmap.bpf.c.
- Remove the #ifdef CONFIG_EXT_SUB_SCHED guard since bpf_ksym_exists()
  cleanly handles the fallback. (Andrea Righi)
- Link to v1:
  https://lore.kernel.org/r/20260322144433.1649092-1-yphbchou0911@gmail.com/

 tools/sched_ext/include/scx/common.bpf.h |  1 -
 tools/sched_ext/include/scx/compat.bpf.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index a63a98a96b86..19459dedde41 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -101,7 +101,6 @@ struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
-bool scx_bpf_sub_dispatch(u64 cgroup_id) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 83b3425e63b2..654b566bd94a 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -108,6 +108,19 @@ static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
 	return p;
 }
 
+/*
+ * v7.1: scx_bpf_sub_dispatch() for sub-sched dispatch. Preserve until
+ * we drop the compat layer for older kernels that lack the kfunc.
+ */
+bool scx_bpf_sub_dispatch___compat(u64 cgroup_id) __ksym __weak;
+
+static inline bool scx_bpf_sub_dispatch(u64 cgroup_id)
+{
+	if (bpf_ksym_exists(scx_bpf_sub_dispatch___compat))
+		return scx_bpf_sub_dispatch___compat(cgroup_id);
+	return false;
+}
+
 /**
  * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
  * in a compatible way. We will preserve this __COMPAT helper until v6.16.
-- 
2.48.1

