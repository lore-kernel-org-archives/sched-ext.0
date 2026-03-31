Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A12BE7BA
	for <sched-ext@lists.linux.dev>; Tue, 31 Mar 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948752; cv=none; b=ullfCyDjSx1uk4EBssLoIt2Ag8cPg4e9mzA3DplrcD83qK6zAJK72TrQRIm7Zn/9718FjjoRxaTS2B4UguWBVEwc3n0ZpddmhOEnp346uu7/PLJfI7jaV5SHpPsQAbjpzTALBbk626WH0wS3vQslr3JuCQKnCzsu5GpuWIuIcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948752; c=relaxed/simple;
	bh=ckNdr8Hojx7pFM3J8sQTB6nyXmMwrsxywMGoanzsH84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVuhb99Uvp8Dbt728p14WGE+RtTYwq9O4ACQnIwlAMdFserRS1joAafD+ytMeQRvv4aoQ86qIpiz9uuSEVhoGj5dPLNRdlod41lF/TMfB3DSzX3jjJftTjO6C+OVgc5+u6e6MEUeD7te6fKUdTxG2lH5fwgfoy7kQo75iyzrQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9h6DDYc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9h6DDYc"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3591cc98871so2361930a91.3
        for <sched-ext@lists.linux.dev>; Tue, 31 Mar 2026 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774948750; x=1775553550; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLh7YcJhfIbkrzfwxdhBrqCUjsHPMTkj7OcKA3P0Adw=;
        b=P9h6DDYcoYyMI1OTFMz9tKwAXRY3kCHA8SpHLzhCkjiaF/xGBD4ROsnF1EyHQnF+GX
         lxKRqpbqxSeQGmJ46i7EE8tsO1dDiBpXUT4ixf7Lcri9+DauCqTvztZgrBXWtogbe7Ie
         uXAyj5jaTEjYQQwfS+cSI5ko2dHGlHR2EW9C4aPDKWL0G3CT+SapmHDM2WnxuxBqEIfi
         Qd5Ig+a67npfw2nFVXWVUBAUx/ihpnsgNRjPejlNC4YdTOofIkeiQioeiznsJnj1Hv5n
         U/oKOyuV7v0PRf7VczzCIDh0TEOD+M3uPA/c2qv1G0+wlmEly7b2gKUeLsgmLvXAwT9a
         4iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948750; x=1775553550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLh7YcJhfIbkrzfwxdhBrqCUjsHPMTkj7OcKA3P0Adw=;
        b=s5YGNBklBI8gaS86+ud+jVAb4ZrGEOZ0Go12XziLMtJ+lBj1YmUrKeQqOn1eNON+Kv
         SNdikGxJw+zH50Jqz50pE3BGx7uaySj272ZVBloWAEY4UHtUlA64R26AAiXxfPm+6tHi
         H5nchOiTOKDqkN+c9ZUGngOxZRML/FHchzJakKk+/v89oeEAQ0HMIFssv8u9HNrbkhhQ
         jeWUEGNqW1ppZs88z9nZPuFuYRcI211t+ZZuDN+99iUw0WjBr1sq1al/UgBrx46I0SbM
         GH7CXGK2s2CMO2F4pVEcBmyutOybb+FZhQRSiBzmlQaFx9TgMHB5XLJXrqVRn5KjCh8h
         LNGg==
X-Gm-Message-State: AOJu0Yz8yW0wpfs+HixvaDr8gw6RiNb0Inhi9VHQU3EBxn+nf+9GgJqD
	ZsaRMI+Yua/bqB3rHf8LyodhR1jFiTLBWv9DWDxxAOvx2CmZHS7XQWeUbQOS3Q==
X-Gm-Gg: ATEYQzync3r5jGvpUuu5A+292Q/hTe1iH+ZHm3rST3s1bKeOQiMwiL6w0Qf9B1cM0Uo
	TKDPkMHuHaBgTNUI2/CEObP0uOadMc2F++raQHhbJXbaWSyEp6IyHu7ubdxSmfEX037Sp16V8Wv
	MP69dz83h45ts5btpZ91UBXwsyFPSyIwh5BKgmIszUXahED/P1/k7Uc/8dTT4kcUZzJDeQsyjlH
	Od4Q2G/wXAkdgVOnKohwp4nKrWHCrENNSKY4UPTmH0PUeMVTL02VQZmBOQqQuKuT916PGol7q2b
	JIp0sx/Odz02lwPFToJcBBIGehl+ZDLrt8QFpnn6MC8PJqpRxrkXerRtL8VKID1Rw/XnvKjGjrU
	WOhhIdqHEQXUzsRvwuxT890ujBHOKzB9opqq28IfujzcwD4EMWZEKT8Acf4zYdQIC7EtQIn2Mlp
	GboMRPiGEnqJj8CUFWAqhdpbeY99z2EOX9m6B65KkniJ/s7i4Zgmqx
X-Received: by 2002:a17:902:ef4f:b0:2ae:5eab:132e with SMTP id d9443c01a7336-2b0cdc21900mr157627115ad.12.1774948750330;
        Tue, 31 Mar 2026 02:19:10 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3807:91f6:475e:6b8c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765c7bsm107390955ad.49.2026.03.31.02.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:19:09 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] tools/sched_ext: Fix off-by-one in scx_sdt payload zeroing
Date: Tue, 31 Mar 2026 17:18:33 +0800
Message-ID: <20260331091901.219894-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_alloc_free_idx() zeroes the payload of a freed arena allocation
one word at a time. The loop bound was alloc->pool.elem_size / 8, but
elem_size includes sizeof(struct sdt_data) (the 8-byte union sdt_id
header). This caused the loop to write one extra u64 past the
allocation, corrupting the tid field of the adjacent pool element.

Fix the loop bound to (elem_size - sizeof(struct sdt_data)) / 8 so
only the payload portion is zeroed.

Test plan:
- Add a temporary sanity check in scx_task_free() before the free call:

  if (mval->data->tid.idx != mval->tid.idx)
      scx_bpf_error("tid corruption: arena=%d storage=%d",
                    mval->data->tid.idx, (int)mval->tid.idx);

- stress-ng --fork 100 -t 10 & sudo ./build/bin/scx_sdt

Without this fix, running scx_sdt under fork-heavy load triggers the
corruption error. With the fix applied, the same workload completes
without error.

Fixes: 36929ebd17ae ("tools/sched_ext: add arena based scheduler")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_sdt.bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
index 10248b71ef02..a1e33e6c412b 100644
--- a/tools/sched_ext/scx_sdt.bpf.c
+++ b/tools/sched_ext/scx_sdt.bpf.c
@@ -317,7 +317,8 @@ int scx_alloc_free_idx(struct scx_allocator *alloc, __u64 idx)
 		};
 
 		/* Zero out one word at a time. */
-		for (i = zero; i < alloc->pool.elem_size / 8 && can_loop; i++) {
+		for (i = zero; i < (alloc->pool.elem_size - sizeof(struct sdt_data)) / 8
+		     && can_loop; i++) {
 			data->payload[i] = 0;
 		}
 	}
-- 
2.48.1

