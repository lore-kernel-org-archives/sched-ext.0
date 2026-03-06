Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4F392C57
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801356; cv=none; b=gkO2RfP9qQ6usWXyOyNfLAho9G3yLD7cK1RKM/UFG4i3X9XKOpQWYk+kjAHDUkM1aQCwKTPKk9nG8tFipWY0iS3OcAQtFK8jI82Vmjmm9Jm+nchwXU8oV6pBUQlD2UecbmK4pd1cbrbca9K7EqgBmFHmVklarSHfQFWPAQO6wEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801356; c=relaxed/simple;
	bh=ELlzxJVqqauBzRnx2M/V3kWxTpAmlO4Sa9vwg7vpvVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfbCerR+s5I5O12rV/yf3aV4kwjJZCEbFpGGvfULG1Er4JK368ypLH7Xp4VyEKGy6Z+LClf7eMOe4JOT4KCyPXVW8bF0QTXP0rU0YBrQx8a9QmzdxjSQM6N2V6PRS1jhYdbpyN/uHDrtDf+bQ0Ik2I6WEetoTUy2UUNRmesgD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA2gz6ah; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA2gz6ah"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae4e538abdso53124075ad.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 04:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772801354; x=1773406154; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lEmGv2FLRFuslu4qBQwLsjeV3m7Edv0VCgYCAY8R+hU=;
        b=FA2gz6ahQkbRl4OXQAbHpUupm6ouTUEAJg/aGN6swU1B4CbCHJz1ZHCAeyyGjAADy5
         UM9/h20MXDlDFQ+7ryR3odI8Gjd6/7/kzOzi+1ab/tcd5+KRjrcnbt5FwUFrOMYtCDD1
         c8Vzy1+G/ImriedqW6mkU7h7qZqmyaDmDc2jDev3kGE7fTvnzI8yOJcieF0S7xexJMki
         91bfFwJIg0rTNUh/0juQhJ/vYsdYlRYROSArboDSwT8eSCOPR0Pet9fmjUM4SO15Z6oA
         yeuSVfD2km7zf1QczRgMLHtfs0V8CgeUuPEh27RRqWI2U7YRpHRjuYyBrxE4+bDYreus
         8jDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801354; x=1773406154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEmGv2FLRFuslu4qBQwLsjeV3m7Edv0VCgYCAY8R+hU=;
        b=o1ORAsO0/FvE2c0Ehd6HqQ3fjfGbQ/6L+vn5mGQ2B7ZQr0v7saCA3g/adSDjfY3d1E
         U+iwfVwQ+0p+181uN3yp/6NpG/dCMLc0Hs0t8CZDH47BjM6LAUV1kAc0f0TWOJzNRRwb
         TIKucB1QuoULdXDdsOCebhofC7N89DEk8Vd5TaGRBVB8iBKEJolfMfupAOaN03xH2Jwn
         6L5BPXWNPdJniMAhBvRyQb3w8ZoNUdUT9JACNtbp3CSlSh+KDiNPKNPalmCS76MgeJxO
         EsZxurWa0wilynA32w02bzZGS4mgbW0NYcXPZeBZXRvzT6aAqMxVHA4pplLXExDTJRao
         Uu/w==
X-Forwarded-Encrypted: i=1; AJvYcCXnsOAn0c0BLVsmNCJ2Fehnd/PcYldeKId3CxS5qTq2vvZb6sRrSksBAms5UUvJeSQklGbwuw2Fkfc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6n3KxS6qo5nO6fSLbcv8uWOjYMy5PXAN7FE8wxwZwnPrNsiWw
	eefn1HX7MNvOFqW5lCH3bpq8B5NT1/G/EFmqVWn+yIv86tZyftgLIGDVC3QgGEGs
X-Gm-Gg: ATEYQzxR95TYMYIeUfRQi49xOUZ7NvXFzRYlUWaWIE5ao2Pu77M6QGIYNF+bYxZy7F4
	xt7n3pD9zPlJMMn0TXHs3fPZ1hTFSR0UGoHsBKgjb3xTAhsPc8CUeriGd2bnNGTKcjk5EZ7BLb5
	uL26U34dkgsCJHu287hcTCCgy+ai7vl+IgviTrh8zZi8ZC7ZWxLhVmmi2m4M2/cmK5lryVPqGMP
	eZP/Aj0uj0QDaxeeSAmR/hgdVYFMRDlUlY6XohyAGvdd40PIKbvyvzTy6Ujlec4or6I6FNmsoTL
	w9bW82VqV8aTsTGs5qF3ifnx/JvcrZVimNHEvFHssFklvyYwyYuU1pFp13XcCn0q27KI0HP3rTm
	cTf9MJGQFnhitaRZe+p14KufuGjRxZTiS4zEJQFdTjCstDWXcNR2prFSZyBwvXI6GamvU2DRYPN
	XOgW1CNWhaqjOMmf89YdrWTlLKig4R58l2S6V8bF+psZR2LgbWz0v6G0aB7S4kALYE7nDBVeTsJ
	xw=
X-Received: by 2002:a17:902:dac7:b0:2ae:47c9:68b9 with SMTP id d9443c01a7336-2ae8247fa09mr22519595ad.49.1772801354232;
        Fri, 06 Mar 2026 04:49:14 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78f77sm27712845ad.21.2026.03.06.04.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:49:13 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kselftest@vger.kernel.org,
	Su Zhidao <suzhidao@xiaomi.com>
Subject: [PATCH 3/5] sched_ext: Use rcu_dereference_bh() in scx_bypass_lb_timerfn()
Date: Fri,  6 Mar 2026 20:48:59 +0800
Message-ID: <20260306124901.2653465-3-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Zhidao <suzhidao@xiaomi.com>

scx_bypass_lb_timerfn() runs in softirq (BH) context, so
rcu_dereference_bh() is the correct RCU accessor. The previous
rcu_dereference_all() suppresses all sparse warnings and masks
potential RCU context issues.

Add a comment noting this is a transitional state: when
multi-scheduler support lands, the bypass LB timer will become
per-scheduler and the global scx_root reference will be removed.

Signed-off-by: Su Zhidao <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 053d99c58802..c269e489902c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4170,7 +4170,13 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
 	int node;
 	u32 intv_us;
 
-	sch = rcu_dereference_all(scx_root);
+	/*
+	 * scx_bypass_lb_timer is a global timer that fires in softirq
+	 * context while bypass mode is active. Use rcu_dereference_bh()
+	 * matching the BH context. When multi-scheduler support lands,
+	 * this timer will become per-scheduler instance.
+	 */
+	sch = rcu_dereference_bh(scx_root);
 	if (unlikely(!sch) || !READ_ONCE(scx_bypass_depth))
 		return;
 
-- 
2.43.0

