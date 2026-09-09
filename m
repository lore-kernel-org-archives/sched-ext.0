Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4C37BE7E
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974871; cv=none; b=TY9YWbodJs+V2QSVFmclkZrnTvgsJxNOF4ZaH0zh8UdiiaaAAIVkmyvIFGITb67H8tnOXWU3evc2rqlr5RNK84r9p7tXCRcAr1jf5plXGKrw36+70JvFstIh1R08iLzGcbCMz+tHZ4PBnfnVedL1/YALxWj/aJqpSF4I7xtZPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974871; c=relaxed/simple;
	bh=Dcbz/Jr4KqaI2o/IdrcJoUzy7DVOg/V+nsQLO8uH4Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bY4i1lMNC88GW3wu+BeAhxoK5tifi/hqZ09zHteerZvsy9fLYxzscbnucUbJk3sKsGp+0BrfsQIkjxB7/+nfWvaFg57FyBc4WSVw/70ixw+MpemlbY7rPhcj40Hfh6xTcWTg7+z394vNzxyaKJmIh4AbYhYhTS7yzjMS7PY7Mos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2benyKY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2benyKY"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-869ac301739so107342b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 09 Sep 2026 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788974869; x=1789579669; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hhMKn/49+cJ2XLToEx49rVIdMx+kzQrvulkyhe1PeSQ=;
        b=c2benyKYZnbNZYJTAUfpRWxDF4e1XWpwBOkobYSo5zZulsltQwQwFlqOiBaP8npZqM
         czxNXDCl8MNtGYGBdguYePtL8d9SKkxRAW0nSuKwl6eMUwlYLJh6nHNLxN412tTFR2Bp
         nhEhgoJzRKVglHeKQlKuPMQmr5iBn6wfCxg/6gcsvwJt7NeX9lOQBHYjUSgP8OH8+F25
         3enIniOLzlggMuGPfKK5RUK+oxiDGFjVlB8XfW+gSb74prXiPrAml4d9t/61jDRJJTY6
         aVh7B1DkhV7ZOkm3taXwuLDP1ILo9wLk1n483+Eb6gNNCiUFu8R0N3lK0x7M7t/GkxY9
         2t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974869; x=1789579669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhMKn/49+cJ2XLToEx49rVIdMx+kzQrvulkyhe1PeSQ=;
        b=CLdJrpvJ+bcsg61DhW97cgl4PGlnZpn3kauh1wovUnFkla0RLetP6JSa66xx6UuZgc
         xOFENJC91Y14XPADoHIIor0uKkyEdW1tBS5xP0ybuVBesGM86k+FBEgQk24Oso5XCSqM
         cRWiBIypPYLx2WfA6m4EzUmPTydNWgNkC+AM11Xs6gQ4t9wmsBxKCiRVE8D078pBBghS
         dJZAWGjxIJ/CpFtwS1ZZfMQTTflpZ2liGq4mt28505mWu6uA3/JtJXod28jZamDJ2qfB
         XsxPk9QcB4x68Dgze0YjeOf6grZvHCqLff5ceWC+tEpxyxfwqZ0jPHmgctFa4DD08WZl
         lhWQ==
X-Gm-Message-State: AFuF++no8VYI7a8a/og5iillHaQyW99ESF1rzEAfr3WfgWsJwLfu5wgc
	WRy3Yfva51UFKjicsYuovXrCawf0cR02jOR0o3Ag2b2tgj930uO8FgGmDNxqER+X
X-Gm-Gg: AYBFou1uKgEiuOn2/R+xP+yEY7Daa2kDYzHSJ/BgPm9bBl0Xdg5F3xwhKxRIKoRKMUD
	tjvvflKJbg3Tvyk3fCDmDECORj4OjL1tCZ8S4JS5J0MlO9P+4sSXri6f4+b+YHK/BqFRFDf42cH
	R/azAm2A+D7oi2FGyVFvLXop/dwwYQKUTTLURsRbnkipw/L++h2rvQAtJTcCI9BHZeh+9TdURg5
	rZ5FdHL7HHQAbJiEs0HLQOs5xIQaUKnjMqOFiaTwEikfFVjRmh/u2GyuejK1h7YklIznDjbG6Pf
	pJLYXAaFjfbw5WtsfSoR6NxQEG20/B2NmuL+T63e019CIg0iESKFEO0VgokdYRncCMeant5qxrO
	B9o9V/LTZRa3jTT3/itDKMotF20glnbcQo83O3wsQnZzOLsmOcpL4mMGlDSQ5ISvMHNFTJqJawJ
	raVgmZc4KBVqeFAnrS6wTJSbpK78cq7muTuQKB2J07GqsZhnCe6y+eYbWaplre+BvFt6yWVbl9Q
	3MfzCTArAnZuXPL6pwtSR0gjVq34BAJRY5d5z4zN8A5eTCQHhnnMma6mHCf2Pz3GPFbBAMX/5gH
	fwZ54Q==
X-Received: by 2002:a05:6a21:a38d:b0:3d3:adbf:777d with SMTP id adf61e73a8af0-3da3a14ecbbmr58716713637.25.1788974868581;
        Wed, 09 Sep 2026 10:27:48 -0700 (PDT)
Received: from cchengyang.duckdns.org (1-164-88-211.dynamic-ip.hinet.net. [1.164.88.211])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45c62012bsm6765048a12.4.2026.09.09.10.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:27:48 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH sched_ext/for-7.4] sched_ext: Merge adjacent ifdefs in ext.h
Date: Thu, 10 Sep 2026 01:27:18 +0800
Message-ID: <20260909172740.36375-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6a1cda143c23 ("sched_ext: Always use SMP versions in
kernel/sched/ext.h") dropped the CONFIG_SMP guard from scx_update_idle(),
leaving two adjacent CONFIG_SCHED_CLASS_EXT blocks.

Merge the declaration and stub into the primary ifdef block.
No functional change.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext/ext.h | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08c..0012f708a5504 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -21,6 +21,13 @@ int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
 void init_sched_ext_class(void);
+void __scx_update_idle(struct rq *rq, bool idle, bool do_notify);
+
+static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify)
+{
+	if (scx_enabled())
+		__scx_update_idle(rq, idle, do_notify);
+}
 
 static inline u32 scx_cpuperf_target(s32 cpu)
 {
@@ -55,21 +62,10 @@ static inline int scx_check_setscheduler(struct task_struct *p, int policy) { re
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
 static inline void init_sched_ext_class(void) {}
+static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
-#ifdef CONFIG_SCHED_CLASS_EXT
-void __scx_update_idle(struct rq *rq, bool idle, bool do_notify);
-
-static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify)
-{
-	if (scx_enabled())
-		__scx_update_idle(rq, idle, do_notify);
-}
-#else
-static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify) {}
-#endif
-
 #ifdef CONFIG_CGROUP_SCHED
 #ifdef CONFIG_EXT_GROUP_SCHED
 void scx_tg_init(struct task_group *tg);
-- 
2.43.0

