Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307C314B73
	for <sched-ext@lists.linux.dev>; Mon,  2 Mar 2026 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435621; cv=none; b=M1ic4OkD/s3GVIcah4vfkhJeqWShqG0giPdMlibtNc88kw6PiwZSl66H0Jj6QpW35vPF1p0TESonShev8duyqCUD/ZDl3fQUIw4Canq1FaL51sL2NADSu8EMA+TTo7Lg0meVTQ2M2ynVHVXTdb80pBW3EfZeO6dbSM3fzv/NouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435621; c=relaxed/simple;
	bh=5svc6Cvyls0hNSaY2Q7UEe7bwzu877Qxyz3M/KEVlrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHpo03IYPyxqcl3CuOYMjj04LfWR1GStJY5T5/BtGfZW6nm/Rb7wwSJ74TB2UXyvEnkN28WhJsQMcTppFoSfjyaiQogjNQ9qyXH9uindg/qYPfwweMVHygqwNtxvHpvije+ziCUplMKSIdOVp2rQzv34niit6IF7/HjGFOUBOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFc9OINv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFc9OINv"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae4e538abdso6857325ad.3
        for <sched-ext@lists.linux.dev>; Sun, 01 Mar 2026 23:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772435620; x=1773040420; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CoenBrjsNGCroObM+rt2eooeVBNLB4qK7qBj2qCiN88=;
        b=JFc9OINviEzoQLadFSSNKUMrx2D4zSqm7+PaVNlYAFLFewz3deMHg/SgNhBLa0duJ4
         A7A8G5p/ftEqHwoQLKizc9ZN/xEVVtu9Fq/flrD8ySP5GTKFdJSDeksqwQ52fs4zGny7
         2Zi4g/c1obrCRWXbbhzoHeJVuWvXdjzyaiSzHwRKSdrCe/2qVfjBnvWaUDSDFNrFID6C
         7AG8bV/1+US3cdK7IZ0uwLLyUThKESL3Q5rETSUJBOnqdUCAWw5kinPA9pRC01ml++O9
         FTaRiP2VUCKsH6o66aqZ763+dANx+QmS3yqpeKJtS4YGSgX4mNpMmQFgrTRSSLAmGXsS
         L1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772435620; x=1773040420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoenBrjsNGCroObM+rt2eooeVBNLB4qK7qBj2qCiN88=;
        b=bYw/ChuX7elSQz6QgwLRbiPAkPkdXEOYYdJJBV1PpxLuOxvpQ049KzciQDCHsItc6S
         An/nYsLNZSqsRTtzrSdQIFW2DTBdsr3+ALteTCl2ugOHTJoZzwZsLbAQUT2a4QSczeHM
         Ni8YHn8gqvK6JcOi9VlyuHZfZc6FWAUtk8uv5p1/VfvSKE2mZMrLn4uSI86r8JR8honC
         RK+uI2anUgk8TO/+f5oKk3uO84bkd15xNNqzHl6HhSjuOhZUMzR4E6O/7+er3TRgyyN1
         EbmvfWOIs3G5Tw1f+L5NWEPgh9aT/WHjDZa9kzq7dYTKJ0m0qoeg82oZJ+sgPRtiM5Ra
         P3oQ==
X-Gm-Message-State: AOJu0YzG6vf8RnEW5nf2PXtZaXo/4YF3US5eAkzeEHQ6CF5Mn3Z1DbBK
	GungfAn897o/PUylzkpesi0n3AmaWbtu4Hs6Mg3uuCK83z0JwvIgtUydZpQEuI6U
X-Gm-Gg: ATEYQzwDppZjVMAASiwvC8EtG7ggy3lXcU/qjjfzuTSzvmyRRH3+xdhIOdE91WJRRZ9
	vPL9VW7Gg4GBC99HLngyNR8xjI94qZNk/0S44V5A1WTS0rI0L/eYhwjw5ZYx2g45/P3SE+U3uKc
	BOOZ7gBkmBqmm/Cc9hO8U4BW9gTbRjjP95P7rqOzTd0BQ9ST9Vqeq34Fx6A8CInzAqYD+2ppjyt
	HP7ZYeUpgFfIjiEDNYtYUlyKo/kqDLRgQsodcbsY8OmZyzND8itgwBe42ujUdHRWxdGkcW++PzA
	u2bIVDVdL1O+dYOZw26tocMsxcmFVmhu5aFWSGDtT5iTjR/Ct4hV9s8uC+YdyTIAHn/bolBGlxg
	m8KxAoV0bfkxcHpH3Fv/v8S3oLcZ0m2EXp1aNKh1L0oNzW+iXICug8EZUa5FFY5TYtaZt0shuZ5
	PMATLyC0+pX/pAbUpC+IqISUIeLLdst//HOe2eVljEOg8BcxVWSxRm
X-Received: by 2002:a17:903:3c23:b0:2a3:e7fe:646e with SMTP id d9443c01a7336-2ae2e3ebfa2mr123784935ad.5.1772435619827;
        Sun, 01 Mar 2026 23:13:39 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:6293:2d5e:3bc1:348c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae464ffff3sm42505865ad.42.2026.03.01.23.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 23:13:39 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Add missing braces to multi-line blocks
Date: Mon,  2 Mar 2026 15:13:32 +0800
Message-ID: <20260302071332.3957905-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add braces around outer loops and conditionals that contain multi-line
inner statements in both ext.c and ext_idle.c.

According to the kernel maintainer tip bracket rules, brackets should
only be omitted if the statement following an 'if' or 'for' is truly
a single line. This improves reading flow and prevents future errors.

Link: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c      | 6 ++++--
 kernel/sched/ext_idle.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9280381f8923..8fcee252d30e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5038,9 +5038,10 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
 	}
 
-	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
+	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++) {
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
+	}
 
 	ret = check_hotplug_seq(sch, ops);
 	if (ret) {
@@ -5084,9 +5085,10 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	scx_bypass(true);
 	scx_bypassed_for_enable = true;
 
-	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
+	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++) {
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
+	}
 
 	if (sch->ops.cpu_acquire || sch->ops.cpu_release)
 		sch->ops.flags |= SCX_OPS_HAS_CPU_PREEMPT;
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index e2da6c3968a6..22bf96753f1c 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -323,9 +323,10 @@ static bool llc_numa_mismatch(void)
 	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
 	 * domains).
 	 */
-	for_each_online_cpu(cpu)
+	for_each_online_cpu(cpu) {
 		if (llc_weight(cpu) != numa_weight(cpu))
 			return true;
+	}
 
 	return false;
 }
@@ -752,9 +753,10 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 	 * In this way we can avoid updating the idle masks twice,
 	 * unnecessarily.
 	 */
-	if (static_branch_likely(&scx_builtin_idle_enabled))
+	if (static_branch_likely(&scx_builtin_idle_enabled)) {
 		if (do_notify || is_idle_task(rq->curr))
 			update_builtin_idle(cpu, idle);
+	}
 
 	/*
 	 * Trigger ops.update_idle() only when transitioning from a task to
-- 
2.48.1

