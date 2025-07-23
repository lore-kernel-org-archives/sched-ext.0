Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B912DA743
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272484; cv=none; b=aF0gMyrwQDsjWhL6qyTOtrR93HFS+vCoKzlHQtS+yn+CE5t5veBEeTznOrQu0GokLTKAK6G/HXWc74f2FqV+ulb8Rhx+eQ3a4YpOWletsesRvI0uSv8G2U8yG4vzbrRUxtBqwLoQKMKtpi8bcwfiVZC98OPgxjG7iLIAaf6b33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272484; c=relaxed/simple;
	bh=jTc+Pb6PfWvo39/1rZY0fGKlB9CuPsthj8GH3hGSANs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvR8GaXz8W+feXVQFVb27SnVLXWWjT3r0l/qYN+bzStl+lChg20mM64o1inISSFZ+LFnNADmDBeBNY7BzzscjzxialXaTJcmC/KrX7vwFXgwKISHWPfCWeIUZTt7JvGhb03fF4HzXSS1uALg6om0th/yBHFXI9nnyS6aRJr+aa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEs8ly+a; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEs8ly+a"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74931666cbcso5328476b3a.0
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272482; x=1753877282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/molExmkfXxrkLpeLTIgxSRDw68qSuF66DkPV53qIU=;
        b=PEs8ly+acV6kCLGfMzj04km5jnpspta0z1ssAZDik2O9a3F3pj2nmW6CkXzdubTyDR
         zUXvP76giTzZ6Fr5viKNXpp4jJ7SseXzOc5R2yq3uE4RPdnu6rBv9pcCCUHW9atpUIOM
         Quv5Aqz6OqmOBQBq/EbMCqBa4ky1PGr/Az6x5bL2G9FtOehVuwmo7H5y8drSI1FwA9Er
         jc0v4ruNdoOZNBHmxzYMc0AdtQx8C9mD8nfS/H3PMnuNlDJTY5Py6JSgT+uuOCiEkSYJ
         68lNmQUPaAZRP797wWW3bqZNtgajUhrqpzjC5iWNeP7i9MQ99cJz4t/uUtsRbTw+c47D
         mnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272482; x=1753877282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/molExmkfXxrkLpeLTIgxSRDw68qSuF66DkPV53qIU=;
        b=RoLvOv02aQAYwcgYgpDVbxXaD9uZCFOnAmYz3b4oZHv6fSEBQ0MIGJF2u14XkE7oeH
         ZDFz4PgdLaf4qcLedQ6E5HmzYuu45ZJBAdyGYsL05te0q3KucMqfuoSYAiGHTZP4Rct7
         l4sOxRj/lBmG0yHnSKXmp83tXAjc2P7lAj29v3660P4JuTAcdM5+KOi9aXYa2kmZVPpN
         2nnNMNC+471BPdA6KoLxr3UBHXSwKhaN9WyEGDrRmGtH5dxoZ1mcZc4zQOGlcGQ4MtT1
         xMs6E3YtqGvksCQvgdr4vU6yBtYRC0aKHn/eUjjQ0SZU4RI8kAJSVIykJBiUVUEubGny
         Y/PQ==
X-Gm-Message-State: AOJu0YxuEsrl2g9sGpyQnGfefMW6G89wztjGT03T/hjto8UoRE5uMaf7
	y5Qds/3qRF9LYFbJMkyFuZ5yrwaiem2udzUs+A91LB/+mSFIa2SKgf/2UVVDUVatQVc=
X-Gm-Gg: ASbGncv8YiW2Tb0tZBl4/T5h8jd1Isu+MUp6Hjbzo44ZNFcAMKwt8H+ucchhp3SjQJW
	4yTGSUTP2QNmsjGaBNC+FsZCBmEfdNbCsHAlagAkhstu3O1Y0AuMr2HOqPGan/OkinSugsxC/dH
	cUWYQ8z9I+DImm5azKGLf5p9cAtk/uhBG9asDUmI3P48uOhVlsFn+96An3odcZWS6Awi5D/DTQH
	lmi9S2+RaKQa/Ohfs/EvUJjD3hcdI+k0+LX/DKyK/68WvTH7H9Bx7oaLu8GZB+k7eZnqn54+eo1
	h3qxfT2gh1UZF8z8pf0YfN0/vMzPu0QayGifSLQR9pDNf5egmj+hl8i1WivZOM/TzTLzV4QT2j4
	+u9t48ORkRz5Y/+sU4YJP4dC82tKKSbacvLeqjxXI57OlDuROVynW
X-Google-Smtp-Source: AGHT+IFfmO8jAz5rYiKssB7TvBW3VMFaum7xURZ5GUzu0fcQTzYyDcIECAPy2CLbY3LmZZlncKG1xQ==
X-Received: by 2002:a05:6a00:1823:b0:751:6ff5:df35 with SMTP id d2e1a72fcca58-76034c9066dmr4879610b3a.8.1753272481747;
        Wed, 23 Jul 2025 05:08:01 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:08:01 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 05/10] sched_ext: Sync with scx upstream in tools/sched_ext/scx_qmap.bpf.c
Date: Wed, 23 Jul 2025 20:07:41 +0800
Message-ID: <20250723120746.52847-6-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723120746.52847-1-yphbchou0911@gmail.com>
References: <20250723120746.52847-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync via ./sync-to-kernel.sh /path/to/kernel/tree, as suggested by
the upstream scx repository.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 69d877501cb7..c3cd9a17d48e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -615,26 +615,6 @@ void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struc
 		     taskc->force_local, taskc->core_sched_seq);
 }
 
-s32 BPF_STRUCT_OPS(qmap_cgroup_init, struct cgroup *cgrp, struct scx_cgroup_init_args *args)
-{
-	bpf_printk("CGRP INIT %llu weight=%u period=%lu quota=%ld burst=%lu",
-		   cgrp->kn->id, args->weight, args->bw_period_us,
-		   args->bw_quota_us, args->bw_burst_us);
-	return 0;
-}
-
-void BPF_STRUCT_OPS(qmap_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
-{
-	bpf_printk("CGRP SET %llu weight=%u", cgrp->kn->id, weight);
-}
-
-void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
-		    u64 period_us, u64 quota_us, u64 burst_us)
-{
-	bpf_printk("CGRP SET %llu period=%lu quota=%ld burst=%lu", cgrp->kn->id,
-		   period_us, quota_us, burst_us);
-}
-
 /*
  * Print out the online and possible CPU map using bpf_printk() as a
  * demonstration of using the cpumask kfuncs and ops.cpu_on/offline().
@@ -860,9 +840,6 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .dump			= (void *)qmap_dump,
 	       .dump_cpu		= (void *)qmap_dump_cpu,
 	       .dump_task		= (void *)qmap_dump_task,
-	       .cgroup_init		= (void *)qmap_cgroup_init,
-	       .cgroup_set_weight	= (void *)qmap_cgroup_set_weight,
-	       .cgroup_set_bandwidth	= (void *)qmap_cgroup_set_bandwidth,
 	       .cpu_online		= (void *)qmap_cpu_online,
 	       .cpu_offline		= (void *)qmap_cpu_offline,
 	       .init			= (void *)qmap_init,
-- 
2.48.1

