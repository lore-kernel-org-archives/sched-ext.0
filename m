Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F93A6B9D
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557770; cv=none; b=Zt72sQ7zUMVUxlDb6ER70yRNY2CSJPRQUiOQRmUxskpneESHiRI1WytMaJYQOA/FiWUFIMJwZnKMC0pmHWg4MHIeWM/MM2lzxNvpSnV17kP038BtC0qtSul239kDdutxnVN27StFOCOE7Q1xf9QCRWfwfOjrnmeaojF/63LFH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557770; c=relaxed/simple;
	bh=sjr0pvglsqscc3vE3CGBUirkr1tZeu6bXqIK38JFGYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lT/BLSPDPaceshs7TpRYrcEuJYpuUEzVB4cAf1CppxmBFyEwMeE4QLDf7/bokvgi+OEyuOjwu5eWNKTGaviOLAFrAq9r75OfAuE4zZ5Jk9+8EGLQQiCw7kGr07fuGtML9S5V0iGYIOz4UyVK3RwgRrNYu80ZoIwRWV0jJq5x/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgrP29RP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgrP29RP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b062069f80so8370895ad.0
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 13:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557768; x=1775162568; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/EjjtWJV/7DiKNlIfPwibx36CB9xJaEZVo+QaHyNNU=;
        b=DgrP29RPXhCqZLq8XkhUGVJAVJQyXHfhZV45fCsSpBKqD5Ugr1EyxowCtGO8C6JB+O
         zDHbNc8kyL4EGmi7HfeqqN23csRWOfIQN2OK+PC6OE//w/dGVvlybmgd1aI3rj0DZu2O
         IB31Nb3y3Uo3xz86LYclWKU9O9f0cC5+gRQIpLmpYVuqDrEdeK3IOhjh4RNd/JB+tO07
         /DFGaNA0FO95cSbo56Wyftc+4v1y3U3806qvldH0ktiOsf9xcmsJ2VWUqjAOU7/DidBk
         7OkLa/dWoRfoF5HosZv3qVITbWhSLEfyKwusE5ijV/bXo01e8X5AiW52z22/6SsL020X
         HVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557768; x=1775162568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/EjjtWJV/7DiKNlIfPwibx36CB9xJaEZVo+QaHyNNU=;
        b=cTNtOCnFM1kT77bWDdqJm8h0yBiqqJGDkfh/RuAJiBjPflbVnKkDIcpzjUSTz7Q6PD
         5Rv5OtwPp7AY/JD4iuwQBaeB4VZenqRFBbM/nQ1rNYJ/1foUE2WOX3S9pDv4Ain0/wqz
         +XA8VSR3nA1mZTSrv61kvlTZ0ZJM/xz2ci/xctYcI1K9p74tlP77vrVRNGM5EH4VRgXf
         KRuije/mV8ohXc8EbA+czUTCdjUVQw5Wub3i1nPrCdtoViMHGUinnXWY0aDjOPcY89vx
         pehFTo8sA60Tr335auf9wPI40+huITCNCWgfdAvhPoBy0y9TypiAB6YacczQ6DtMWi70
         krMA==
X-Gm-Message-State: AOJu0YwpCiPRFAg9DP0zW6oIMsuIj162vMIu/tAdIgEap3OqbOhylOK+
	7B3oVmmiY6c1PYKVmmdJboQv/uWFfWXKtTrshs4tLkRoYi81kfLQ5AEyEH8PTg==
X-Gm-Gg: ATEYQzzi2o7+eEvtOTh3qyM3Frar8B/c4MgQVSvvbU384LoLibMr74LIGJb4fLSt8de
	VqD9OViKpVmg8DTDrOEtTHL9Bg2jF/MA4+k2mMnQPtxuQWeuac3X5nxsUm0Y387LldYbtiIE5dT
	kDuxmrOXLCHdo0gf/4OrRV5C+AGvHj8vdDQSQ0uHZL8ueH//plmk920BUQ3/WXFkAQmopAgJbA5
	f96UmrJ0IsZClOHtd273ySCozdsqhxkf1vGOJJf0+yzM8c3MohmWSm5hESSUc2a6+ZRs5bip6v2
	plSX+dsayRNqs4Bkl2h2b9rHh2u8SvFhqWpyUhlxq3znmh5u9trZHYc6qIBtvLCfq25S7ZrRyC0
	CgxrEJU+GLulWsEaTYExXyXPAED57mIoWbbL7fTaDhvll3Xtfv7RnAAD8stkJi9d14rqh5KM5Uv
	oiv26jQTPVVqnZxR6RHavsqZ4Krzf8oJmFF2MLYxZYv5KvMbTFZH1roUCHpj+d21wzcY7DLe4Dg
	hc=
X-Received: by 2002:a17:903:1a23:b0:2b0:3f7f:8115 with SMTP id d9443c01a7336-2b0cdcb7d34mr153505ad.24.1774557768136;
        Thu, 26 Mar 2026 13:42:48 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0cbfd17d9sm4004905ad.25.2026.03.26.13.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:42:47 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 1/4] tools/sched_ext: compat.bpf.h: fix scx_bpf_dsq_reenq___compat signature
Date: Fri, 27 Mar 2026 04:42:35 +0800
Message-ID: <20260326204238.3755737-2-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326204238.3755737-1-suzhidao@xiaomi.com>
References: <20260326204238.3755737-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_reenq() is declared with KF_IMPLICIT_ARGS in the kernel BTF,
which means the BPF verifier automatically injects the
struct bpf_prog_aux *aux parameter.  The BPF-side weak symbol declaration
must NOT include the implicit parameter.

The previous declaration included an explicit aux__prog parameter, which
caused BPF programs calling scx_bpf_dsq_reenq() through the compat macro
to fail verification on kernels where the kfunc is available.

Fix the declaration to match the calling convention expected by the
verifier (2 parameters: dsq_id and reenq_flags).

Fixes: c50dcf533149 ("selftests/sched_ext: Add tests for SCX_ENQ_IMMED and scx_bpf_dsq_reenq()")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/sched_ext/include/scx/compat.bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 654b566bd94a..6fbacc909b8b 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -405,7 +405,7 @@ static inline void scx_bpf_reenqueue_local(void)
  * v6.20: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
  * will eventually deprecate scx_bpf_reenqueue_local().
  */
-void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags) __ksym __weak;
 
 static inline bool __COMPAT_has_generic_reenq(void)
 {
@@ -415,7 +415,7 @@ static inline bool __COMPAT_has_generic_reenq(void)
 static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
 {
 	if (bpf_ksym_exists(scx_bpf_dsq_reenq___compat))
-		scx_bpf_dsq_reenq___compat(dsq_id, reenq_flags, NULL);
+		scx_bpf_dsq_reenq___compat(dsq_id, reenq_flags);
 	else if (dsq_id == SCX_DSQ_LOCAL && reenq_flags == 0)
 		scx_bpf_reenqueue_local();
 	else
-- 
2.43.0

