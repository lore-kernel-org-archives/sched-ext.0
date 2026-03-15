Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D135A933
	for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773598227; cv=none; b=lMbiz/niLGnduQhOiiQzKoUSSLs8s1g6ppletQ8bHdz3Ig65cTB4tyQL/46aAiAvJ27uptxU4Ral6WxTqDbZO9xdWWDP2ou78B0sFzY1s3XrB+Zs3k9T+efsW+pYDr/n/cDvUoOgJ8/bKSQhTOHhJK+w2D833Ia+wIEw2R7xnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773598227; c=relaxed/simple;
	bh=KX4Qbg46Y2MxVnuYTsimCnmCjw/y0kfI4qmcr8ZCfG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qecanW6yG/39I6RyDh3oilvxUcNmA78GxIswlfTiKct39qzfJBQH7c9XbtZlCQoNfIOTWAeoIk4w8cvCXZShFug1tBx9qtK9fqZDT4xgcbseIiJ/fV5F5YEaZt1xMuV4vn/ybxT1sFy+EZ6GVLfmpXTupRKsUMA7wINy29LluzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAOOGySR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAOOGySR"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so1677390a91.1
        for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773598225; x=1774203025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8Ss1rRUXjV7WwJPngAJsXaChnn1dRI+lDoVQgNHMHw=;
        b=dAOOGySRn4P64c5hwM5YV3Rji/kapzfu/7d+N/QhxVREC6dJ/+g0PWbhnlVzyHwYRt
         Z8tH7mBCKbsGBsNhNldron5IZ5uBieIuWae8mRVknwub0jvAlIQLgVkUOmctwSUx7n3q
         y7okmPOc8ZoJq/yRAfFxU/na/baWjw2q35H+MBcaXbMqD3otyD9Eg0kGFbB3xgU7WDKq
         prAewaqQpPnYpCOKgbIKrlPIr2YWlvpUskGt32qLnmA5QsSAEmmkqoHW9jlCYjj8hdj+
         qckFKBcdVD8VV0n9zO2Yy0B9BErKJQCmIlmkjN4r0oWtAifnWwaWOs92f628PSMc+GqT
         W05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773598225; x=1774203025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8Ss1rRUXjV7WwJPngAJsXaChnn1dRI+lDoVQgNHMHw=;
        b=Vz3mshOBcGCd0T57IvxN+lVflYxlfMV4Psc9pf28bzla7VmrvJltwZGyny//2ShASv
         1IOT3ws8hxgGEuku8Ba2O6uOvWa87JSliO0DP9+Y3Oy0wvj4ohru+fGwYWVDOTB+5LSN
         4p/rPPBXfxoIQRKF4fgrMPm/fFE/n8ZAhdPcIKF4YykDqQO3jCTx5BWhOlWDy52ycOzV
         bLBv5xqrZYBXgZ1/7RTkivDgt7kxnmuH9o4O9NCdMFntau47G4kV6ZqlZdWjCv0018c4
         SEo/heR4N7vNRVJgrWP9psfwkiaM+vpIoPAxNnNF1Q5WiXLzKFAcmzZ5nD+jUktmha4P
         Pv8g==
X-Gm-Message-State: AOJu0Yw2iOQv6lyXyMTHx9IRYRAaqeQofx34cuGusMVS7QgZOt/6z5hU
	OxTRjjFBvjiTkksrop+Jwoyque0j/W/hUfh3/RhYObyau7M+E4gw2r81XI7qkK1s
X-Gm-Gg: ATEYQzywUriZ/geVjIIygMHp+qZDIuFcOm6Rna8z9n5Ed0wciZq2W40qzAXwEUCHVrJ
	gb3BpucoyKOZo7Sn5b9VZDEJ8p5GVuvReSUr/Su6WnhRoBowDT7UGfIN2r+0rIV4Azxv3v/IuBY
	uY1b+1IPP1AWsGaMnhM3Yi5Vby6eAQlKiPENAgpO37WVdFcAwTYzyDT3QPLJ07aPYEbdBWopN7E
	hI860NVuesym8n3XRe/Z7hgnI7gMlQk3mYwu4Eq4ILaalPt5AMjyr/oc/28U4MOMUjcpJNnHSc5
	K77Khzgu+1DJCM6xY0yKRIXgghRj9gj8qcR0QzktAE/H7EOl94ktFL9bTYjljYBNAPGNMBwH89o
	nittMqseUVqwl2u2Xij3wNNb4yV2oGzktSsz2CWbXreF2iOvdwOEHpaSwQC4aIc6tF+pSC6SUH7
	GRaPkEP9Zz6MZMeos9v14ap+3UL/KKlbPqQ6rVXSLp33PDU8/Gjiu7a2WnA0gCHpQ=
X-Received: by 2002:a17:90b:498d:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-35a21fd7f9bmr8120639a91.11.1773598225135;
        Sun, 15 Mar 2026 11:10:25 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c21f:f7d6:f4bc:6198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9b797ab2sm1537624a91.7.2026.03.15.11.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 11:10:24 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1 0/2] sched_ext: Reduce idle CPU NUMA traversal from O(N^2) to O(N)
Date: Mon, 16 Mar 2026 02:10:13 +0800
Message-ID: <20260315181017.1377138-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pick_idle_cpu_from_online_nodes() uses for_each_node_numadist() which
performs an O(N^2) traversal on every call to find the nearest idle
CPU across NUMA nodes.

Since NUMA distances are fixed at boot and do not change at runtime,
the per-node traversal order can be computed once during initialization
and reused on every subsequent call. This series pre-computes the
sorted order into scx_numa_node_order[], reducing the per-call cost
to O(N).

Patch 1 allocates and populates scx_numa_node_order[] and
scx_numa_node_order_cnt[] in scx_idle_init_masks() using the existing
for_each_node_numadist() traversal, paying the O(N^2) cost only once
at init time.

Patch 2 switches pick_idle_cpu_from_online_nodes() to iterate the
cached arrays, removes the now-unnecessary per_cpu_unvisited nodemask,
and adds a node_online() check so CPU hotplug is handled correctly
without needing to rebuild the arrays.

Tested with make -j only. I do not have access to a NUMA machine to
run runtime tests.

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Cache per-node NUMA distance order in scx_idle_init_masks()
  sched_ext: Use cached NUMA order in pick_idle_cpu_from_online_nodes()

 kernel/sched/ext_idle.c | 81 +++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 32 deletions(-)

-- 
2.48.1

