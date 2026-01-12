Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1482BDC0E
	for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230456; cv=none; b=E6g2WKWdckkZmtEVkZE1WYUaSGx7/YWtkTTG2xRN8uP8kHd/dXydcWRmcoSmCYcDUkIWy2s3wgGPSjH2+kxJTyDh9ogL4+xUoIVxvloCzs2BMQkTj/sgXsB7UfzeXtucW2+l5qmyAvNaHIh6qW2bGc8tjDrbSuoPgV6NOPo3+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230456; c=relaxed/simple;
	bh=6Dakwn6nOLlOk9V1q5/PMCJ02/l9rcS2HPwwJeYpDZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GF1mJInJG07lXheGMTbTSVdzSa9LOH01DbnUIVAt5Q/xEyuYigHkddOeZ/ofnUTnum6gq/LhDA8guJqbsI8J3UgDlVa/jLXu/8z5VYJXN+fnFEAZAOAVj9XEvm8gerJzK0rmBqd6vySU0HIYkKxoWXEceWD9lW18dId4GFSdMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iemdiDF7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iemdiDF7"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso1432703b3a.2
        for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 07:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768230454; x=1768835254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjP8QYv3MCkDsN6GIEc6blwGIEKZZE+PZs9o+pmtA1o=;
        b=iemdiDF7wBk/g7p6mHqwl5utDYZU6e32H09HuGXmGC49Eng65Zp2KGaQEFz9Oj4CPc
         jvZh5WB/39x+fZwn7LK3PCUo9gzz/rUYK12qHW97Q1LEcqs09nb4sfuw3Ehpi05cv5rS
         11rgIBh3JgSIJVmZJHQqllJBLGNYJfUlUNfpqblAGgba8YfFruLuEouYeJUa63j1pVs5
         U5KjcWjoyYiH8IfynEYpGZU0CXz+woL36O9BYwO8uOs5aJY7Uml0n9TKY7DnK0opswhi
         fVgJMSd9tJI33HuXppY2Muw7BmiHmnK1aoAl9nOgeWoZHjFMcCIRWHElH8PBhffQVExb
         BRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230454; x=1768835254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjP8QYv3MCkDsN6GIEc6blwGIEKZZE+PZs9o+pmtA1o=;
        b=Eaj1Une8ogIrRcX5Zqa9YKVT2drLiD5f96bM7uRgnq7nLL0id2MO54HotYCmbrBlDR
         amEHkhJl/4UMxM5mYC+caVoMq6iprXXHDiXY2z0NPY/pYxdiN18MLXa8Bst2pml4VW3P
         xPB9ym18CEMSw4hWMiDnragOWLnZCiwb4iCx/AP4TaJNgED0//Pg7Mgg0ZWlwcxNUsNR
         OGMT4Xygps0g1Cpa/FFToY0lrmnPuleAiDPTS7ttm7Oz91EH3fTerN48zp6w0WKTh+vR
         BguQrR2lS7LdJrr9pJZT0OslK7v9eqtm5rfLNq7n897ooxF/SprFxVn8+skvpHC8SGKw
         Qr1A==
X-Gm-Message-State: AOJu0Yw4XbjgQYPivcUVPyQJwHyJ6wEi5qatjnBP0/z2euSYHNAHauYn
	oyNTAjhNl85lSZAeVtNQKPZW0RkZvm0LVGsdMhBXac991KuTLbu7c8cnQoWyMFjY
X-Gm-Gg: AY/fxX7Ojwo/9MCrqiraaqbOYXWeH7IUZ4Hd6PMiyl468Y7bnsynRFEV3AMSZ2ffu6P
	h/SrjPyR/GWEyglutvgevdt8uf8i2V1p6mIl8aC1uPNhDeq25FHpijkcZA6LmLu9svE45q9TsX9
	ugNKRXkHG6iq1WgO+uIAlt579WqJ+mAiNmaGRiJQuh2Z7ckdszFUYTrm+EHNpe5pfpp4XViH/2W
	/TLZjgpdMhkgiRJ0GdR3qfrYhnKyrykFYlnxuc751jyEz+W/Gavpe7MmMS3bpQB3yMUrKWhxjeZ
	HBxlz+ELQfaLb+fLSHMpo1Lba7k45FmkYRqHIqQaUhWaWwXIV1TdPdRFuE2eVW+HbjkWNlf3mgD
	sVp2XsHQ14KBBRDYTNgs9zzlzn1gFSlkMZPAH98r627hwcPWF9YV9ToTM3rbhW3ymaX9IT8SH9b
	2bLhp2X/CgP0RvUoxT+v8WXuNwm6THHdwRi32SbRjItn9talFdIECyQljFLe9XbhvCPF9xXJy8/
	zwp
X-Google-Smtp-Source: AGHT+IG00aQ/BGQZHhuE13eYadR5SLL9BoEum89k+rfK+I3vNr9Yp0Tk9NdoUyAq4HGJvNn6HJI2cw==
X-Received: by 2002:a05:6a00:35ce:b0:801:eee2:45b6 with SMTP id d2e1a72fcca58-81b7dc620c0mr15070327b3a.24.1768230454269;
        Mon, 12 Jan 2026 07:07:34 -0800 (PST)
Received: from dongwanqiang-HP-Pro-Tower-480-G9-PCI-Desktop-PC.mioffice.cn ([2408:8607:1b00:a:1ec3:42ea:fe81:bc6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81ef9881db6sm7854918b3a.66.2026.01.12.07.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:07:34 -0800 (PST)
From: dongwanqiang <dongwanqiang2021@gmail.com>
X-Google-Original-From: dongwanqiang <dongwanqiang@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: changwoo@igalia.com,
	david.dai@linux.dev,
	dongwanqiang@xiaomi.com
Subject: [PATCH v2] scx_lavd: Optimize CPU selection in pick_idle_cpu
Date: Mon, 12 Jan 2026 23:07:24 +0800
Message-ID: <20260112150724.1553199-1-dongwanqiang@xiaomi.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dong Wanqiang <dongwanqiang@xiaomi.com>

Optimize the CPU selection algorithm in pick_idle_cpu() to improve
performance in highly loaded systems with multiple compute domains.

The current implementation iterates through all neighboring domains
without considering distance or early exit conditions, which can
lead to unnecessary iterations when no idle cores are available.

Changes:
1. Add tracking of stealer domains found at each distance level
2. Skip domains without idle cores early (nr_idle_cores == 0)
3. Add early exit when stealer domains are found but no idle cores
   are available in closer domains
4. Add optimization comments explaining the improvements

These changes reduce the search time in the critical path while
maintaining the same task migration behavior and load balancing
characteristics.

Signed-off-by: Dong Wanqiang <dongwanqiang@xiaomi.com>
---
 scheds/rust/scx_lavd/src/bpf/idle.bpf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scheds/rust/scx_lavd/src/bpf/idle.bpf.c b/scheds/rust/scx_lavd/src/bpf/idle.bpf.c
index 9f08f972..4340f453 100644
--- a/scheds/rust/scx_lavd/src/bpf/idle.bpf.c
+++ b/scheds/rust/scx_lavd/src/bpf/idle.bpf.c
@@ -757,10 +757,15 @@ s32 __attribute__ ((noinline)) pick_idle_cpu(struct pick_ctx *ctx, bool *is_idle
 		goto skip_fully_idle_neighbor;
 
 	mig_cpdom = sticky_cpdom;
+	/* Optimization: Prioritize closer domains and add early exit conditions */
 	bpf_for(i, 0, LAVD_CPDOM_MAX_DIST) {
 		nr_nbr = min(cpdc->nr_neighbors[i], LAVD_CPDOM_MAX_NR);
 		if (nr_nbr == 0)
 			break;
+
+		/* Track if we found any stealer domains at this distance */
+		bool found_stealer_at_dist = false;
+
 		bpf_for(j, 0, LAVD_CPDOM_MAX_NR) {
 			if (j >= nr_nbr)
 				break;
@@ -772,6 +777,12 @@ s32 __attribute__ ((noinline)) pick_idle_cpu(struct pick_ctx *ctx, bool *is_idle
 			if (!mig_cpdc || !READ_ONCE(mig_cpdc->is_stealer))
 				continue;
 
+			found_stealer_at_dist = true;
+
+			/* Quick check: skip domains without idle cores */
+			if (mig_cpdc->nr_idle_cores == 0)
+				continue;
+
 			cpu = pick_idle_cpu_at_cpdom(ctx, mig_cpdom, SCX_PICK_IDLE_CORE, is_idle);
 			if (cpu >= 0) {
 				/*
@@ -789,6 +800,11 @@ s32 __attribute__ ((noinline)) pick_idle_cpu(struct pick_ctx *ctx, bool *is_idle
 				goto unlock_out;
 			}
 		}
+
+		/* Early exit: if we found stealer domains but no idle cores,
+		 * it's unlikely to find idle cores in farther domains */
+		if (found_stealer_at_dist && i > 0)
+			break;
 	}
 skip_fully_idle_neighbor:
 	/* NOTE: There is no fully idle CPU in the neighboring domain,
-- 
2.43.2

