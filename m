Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DFD25A357
	for <sched-ext@lists.linux.dev>; Sat, 18 Apr 2026 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776504177; cv=none; b=SI1MfU807MXvA438Ppqix2EJp72GGAcc8d4WgM2uyjo+ThkKvck0MW9Ad9lv9AuzDai/dmueVHZ2GM25wX0qnquTIgsuQTfwaE+tpPD7aKypac1u7rIl4iZGYyqc837cgAHiPFxvlw3DGMc0MUmswoVo44JLTU+YL3aguMd3QFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776504177; c=relaxed/simple;
	bh=FhKhIcShincUPNyJRKTk5Xo28zeRLBWHuhhPhFCp+5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbJCTZtK13+VD4WlT18DaA+vC0FdeCZbFXTouBEr2QMGLbvxyzYemLdkQ4KTDkzd0wxOxtATugJSHMNhCOv5yHa89x3BgPHMxquUzt4vyhr0ukb1eGyVZyMQgTiPsS0cRVNywCi4IbsZ4Hg/NcVtznTbJDmRfy4+ApUF+J8+/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6yPI3j+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6yPI3j+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82418b0178cso857024b3a.1
        for <sched-ext@lists.linux.dev>; Sat, 18 Apr 2026 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776504176; x=1777108976; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/eOv/B6hxy5WqJ7yVnUOWzvlF6LuMzdUFt0YY5GI5E=;
        b=r6yPI3j+JyMDy0RZ/H5OIt09jIcBft//0sEAzpEoEOrkqfEHogBuaEPDCJOw/Bi1VG
         szHtFK1RWDPiz5NINbM+0X3yiSE66jt0HIyTNuNm1xuYeYMeNSQiTI8kCp2IzBnEHnYI
         9NUwa3hmPF67QJmlWN/T29TWMmRU+Y48p46lUIA63iN1uM5UQrR+Hl+Vg7ETYBgJwhWA
         RvbvXW0SGe0FKUE2Nlo+uFvMhAVvxHqjurN+1RZ9yyWkMbQfM5j+ndPhhNmOKxJAGJzw
         nk1C42UIOIX5IThPZpU8xaxAV7HdShQlryP6OFRR6yii/Y7DRyJQw5WMMDSy6btfoNvs
         M4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776504176; x=1777108976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/eOv/B6hxy5WqJ7yVnUOWzvlF6LuMzdUFt0YY5GI5E=;
        b=bGV/gJkA8xptIkJCwJbx7oR/0PL03X/dTyhcx/W/tiXYSnPb0OaTUY4dX9JbFjlr3r
         z7xs1+i0QmFLYcC7p8ebzWVwFWkzzKhidt9pSP/AL6TD4QKi5RYWK1NnlwVaeFmDtxpg
         6QyfG8iRxHi+W6wy/hrW2iD3xWfrLCU1xMAs91f5HruxNiFkozHvIVY299UDrhnimhWA
         7gbp0owZTCYyWc/kFos/Ux/tK2oC4fBKAPw0GTQhd0qEITxJfZatBlU8ao/RuKZ4Sm2C
         W8aPiZjpKsC9KX0VSxugJ1Q7CYff8SEH2UtgjBFLqKTgTQvlTQpU2jlLczHVwH7WRM6/
         Hncw==
X-Gm-Message-State: AOJu0YxlAg+KkjXzbUShO7jUrfncX4T4UYqcOYmey638LKn9Ut/GVRaS
	wMQ7gQkaV1vrnUTDF2DktleWLq+v0sz8CUjJUAcJvwGbkPHTTKlfTRkP9qTcoN2x
X-Gm-Gg: AeBDiesJRitxwDCkdbjI57q0Fa+TCFq+XkUdjO7wYkWgI0yh0pV01U6kAi4kFNCo4rQ
	jyXDmsTqc/Ajz894Lw9/40HIcGvWPtxUq1ZQ852Rw+qtv2T01O3EDdI/GlsoPYNnL9ifDKY3Iy4
	E5zIj0ElJYvPd/JnelwYyuGQLW+wnzLN+ZnhtNel2POULkHG5do+lX5dsIxoctAGJB/tkb/fRTF
	TWluUKwDbvXhOlTqwijZbATqNNDs656UbzvAs+n0hCvSOaQoxX7/A5uSj7ZSZL7azMPaFI+POFJ
	iYi9hy83BYhLI6hB8aWnUQoWZ3YnBvLLPMQQum4rncb1ztdx+AWgrn4RnjcfFWOOxdEavT3ZiNz
	LxNjJlvWrno0j/5vkENdhZ9NGXeRMqjpC8G+ozR2akzPH/FPB0VnATjBciCCgDbLNcOhaHL22D2
	1Owp6FTPckD5I+Kxv7yezqeqG0stCNKMf1MFYdgZ3wk+CiOgXUUUcRjRO6s/2f2Gc=
X-Received: by 2002:a05:6a00:17a1:b0:82f:6e7:152d with SMTP id d2e1a72fcca58-82f8c850ea1mr6491815b3a.21.1776504175520;
        Sat, 18 Apr 2026 02:22:55 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:cfeb:f4bc:c0de:5763])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe40dasm4350332b3a.40.2026.04.18.02.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 02:22:55 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1-fixes] tools/sched_ext: Add missing -d option in scx_flatcg
Date: Sat, 18 Apr 2026 17:22:45 +0800
Message-ID: <20260418092247.1541377-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing -d option to help_fmt to reflect the capability.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_flatcg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index d865c381589b..fa27352f9a6d 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -27,10 +27,11 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-i INTERVAL] [-f] [-v]\n"
+"Usage: %s [-s SLICE_US] [-i INTERVAL] [-d] [-f] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -i INTERVAL   Report interval\n"
+"  -d            Dump cgroup hierarchy on start\n"
 "  -f            Use FIFO scheduling instead of weighted vtime scheduling\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
-- 
2.48.1

