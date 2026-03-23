Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE73C553F
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279067; cv=none; b=NoEqrazj1s8tixMagfLERBHk3IsTyQ3o5VArMEox2i7jk07ZTZtCYjpmGhJOYea2KLkeDdO8Ri6j0dAR+J6VjytXz5LBwqiSoCWrmWd47bnsfDxZXb8rYTm3/Y36rzEgJlLC4S00ahsfCNEN0Ng73kj4MXkYsmajog2nKPLmb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279067; c=relaxed/simple;
	bh=C5kjwV2DGJKTXoBCd8krrrCcOeFthKu454NhQCUVJpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9DUth/vwpOWn6mc+BxvNUmYfhuWGOa73TTLHF0/q7e0OApE9HHN7Igh/ovE4lWQOwsdyc82FItRlukb74Wn1dnlCWpsYyiJvhA1wH+zRPI4EUk1QIl86t0mC5QzcElNKWJ1+Z9w/DsPxPecQRpefBqeS5lQR5L2VNt2LSepvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6GTnI3B; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6GTnI3B"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9516a653so1482675ad.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774279066; x=1774883866; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQgfNlKwrbC3hNfKBSwB80JknB4D0Hgryalf68gS8XQ=;
        b=f6GTnI3BQG4rpKp7NUc3npA0XERp3OJ+0W3hSEtKgB1lOzhd5T6cuxFgzHX3oIAkPu
         W5HOMh3zkylGzcA+j+zpESF2PcYvmTUhQVwU3cWKDb84X59fT93H2Hyc58/L6be6lM4R
         Z7GFX9O9v1sxZyAihcxEUmFX1nqFYfPUkz1JXLuG6rpAIxJkeD7crnIxg5bAjP22UWbf
         AxJoQrXIxlDzmEmW9VTCZTKFWUKVEkqNqvJEyrE30bny7JoOQqZ7Hhdi1UBTRV6vGmKJ
         e+uxiiPTMOSMyqglcsjbOMjExusgf/hfsXvSrntC/Waf5wiJlFpWxgjxEjwu2qIcQkgN
         RR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279066; x=1774883866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQgfNlKwrbC3hNfKBSwB80JknB4D0Hgryalf68gS8XQ=;
        b=MbVb+u2sbaLP9M3Yjj2kpVRcPbp/uqAdgIEcG02coI7In3DhJLa5O94QrSpk98FQTM
         nIylOAtx78TNfmMnw2Z1m8/gDTacEt8xmEdWDjJU7/HLVRcRmcvJwpvC2QC1uXnMu4B0
         6P/RAkShGHLbrhcgxR/+ZDtaAXJkwF7+X4qoN5VvZcXvpPIttodpefiqWMt2O5shRpO+
         On/08mEgizyZL7vhXr2sjtoYEMc2KGXFc3dEgf5NKCLYO+tooInvSmeVKoTQG9t4t+be
         4SPOljZvl01Hh6N+yzaFTPQZcp3ogRM9cdktM6tZcJ4nafp/drCk76ig41Rlq31OFSeH
         sF4w==
X-Forwarded-Encrypted: i=1; AJvYcCUfjXbFaxHQjRjOFvvNti8V7HGieiWRGiF1kY5+XhI2xUG5S17rJQcR9wWrGxIYjGwTIQwCrMlPSJk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7PON31UllIbCZ2bWmP+fJ+bk+7w50e9gn920sFAa0Q+FHLsUx
	CM/H0BMpdI/KQ1/bzBE7vj4uG0n7iRREZQfVo/tYCVPIBgd2x81GHWNc
X-Gm-Gg: ATEYQzzhVlg18rDzRHrBkT7w/pVH8r1Dgaxks2XrnHA2pgnMIZleiBlhErNuwBYAvcl
	EvfQDFdVW6DlVguYf1Zq1GYQX33wlAxOCqPaozJC9mkyMMXCMsbDholwmE8NXLTqcui0YALnXW8
	Jw8MEu0LYuUZ70mXZ/mXXQCCkO4aqRCbnGV6vQLfJgLMKsJ4NGQgPCzo41mOqvIBzLip0lNEKIO
	HSte4LWR7yGjqeFbu2w9YjDrQBac0r1QjnYHpt01gDJIguyob2gcENAJxyVtXWGRNs2XA7TELGj
	HES+eMva6Yc5BCW1+IaviQDFx6PsgHuH8hPiZvJYBPeLtqH2Nzn+S/JdK1YP8fDt8SizJg+N1Un
	KbMX8uoFAKs4y8kHM/5lo7wTEHeoDumi070EC4t0gA2awiG2pX37e+rrnnyN8X//S0LbYOvpFxp
	OCyJsXfHofyBgQj9N4JLqK6L3lyMoX64SgAyowMmwVlUCE+mNVDMF+
X-Received: by 2002:a17:903:283:b0:2ae:b807:da61 with SMTP id d9443c01a7336-2b0827a3f1bmr104849235ad.35.1774279065746;
        Mon, 23 Mar 2026 08:17:45 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c95d:66f0:4661:427f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516b96sm146213265ad.7.2026.03.23.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:45 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: yphbchou0911@gmail.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	chia7712@gmail.com,
	jserv@ccns.ncku.edu.tw,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com
Subject: [PATCH v3 sched_ext/for-7.1] tools/sched_ext: Add scx_bpf_sub_dispatch() compat wrapper
Date: Mon, 23 Mar 2026 23:17:33 +0800
Message-ID: <20260323151733.4175605-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260323143757.4149146-1-yphbchou0911@gmail.com>
References: <20260323143757.4149146-1-yphbchou0911@gmail.com>
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
Changes in v3:
- Rename subject prefix from sched_ext to tools/sched_ext
- Link to v2:
  https://lore.kernel.org/r/20260323143757.4149146-1-yphbchou0911@gmail.com/

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

