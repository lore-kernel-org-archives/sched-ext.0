Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE353DB31E
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839163; cv=none; b=Hv7yRQOSKoalHnq6mfDwqgvZfBLHUEiyyJBglFqj55fnsR/vuIKnD4e6FYITI7Zf7G4J5zu6lCGJJ4KjBL4oti9eKZ7aNXHibemLR3HDyZTZPO+7nhaglwx0J5ox4KgweUn/B2phQcc9wiFvQTrbJ0V4fACzPBEdxGqwnWcmJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839163; c=relaxed/simple;
	bh=WYETMkM3pIDNQcz8fL4C3PZ+TbLghToI0ZK3wNz1WRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riUUwXrYCPrG9B8pBgW497AeJvL0/ykO81mlLHMRK0haptpeJlunYRexJQ0Un+cbTi1gXWZVZS72RssRBrkyf8SRCu2SEKWXAw7PTagHY3IRlezzEO95iFNN6CLyUj5SapbHCqW46QrmapT4VumFGcALmzm0UxYf0VxrSzIUeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkNRzFaG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkNRzFaG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9d87b1f9eso18568465ad.3
        for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782839161; x=1783443961; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAVOKASgSOqutsUqWwmOWL4mnBULdJpfxiRlqGBPmtE=;
        b=qkNRzFaGtDBDxyOdrp2F6DMuw+OZ4R00U/5+23ohcfOC17OEpKVQSZtW42l90Wi1j2
         IY7FtCvYLTno9ycoEt3EEjWC81XBWaYX+9kJ4dU9wRK46JO942uBVz2lZpDCJVESrVOn
         MpDCX/C0FMMJGn1XldKAIblhSVc0ch4Vde0d25QYEIrOArC3IcJaDPEyJLXdyKLPfn8w
         cfZVoVvLJg5WQ13/NVDR67pOL7rLj+PjL59uD+4my7daA6E01Co9FgC0BJ8aWc3kp/Vw
         RNzkmSJC9xH28oPiXNo9zjgacZwWe4RwNHb1g4PFXeETH9kJkiaV/ntfKvKcWD7BVAmH
         i20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782839161; x=1783443961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAVOKASgSOqutsUqWwmOWL4mnBULdJpfxiRlqGBPmtE=;
        b=fXQ35gbd4pG2y12dtmtaDz5IQIYpLw3rbxTIcnG/hTRFsQEEUt9AA2qEZLDtRUfuja
         zBCGDJaIgdC7Uanbf5zknr0jxH6806uNLwk+Oe3hg8gfXOu/REwe5ZppPtceaE58bm9H
         bLaxNqrO3x5zRfOEJyUy/IvRH6+iKMTGAb+5HrELrsBw/YijRqf1VDlVlRDVQYszC0TA
         KvrBL+IhPUbq7AQuVWeXDToA/EzTcjx4zy07l/mANnLnTx4y1wBC3pLSidhvyQVCV2y0
         XwxoBj4QjwRogOjXh3aAbcnM81Lym2dhxB5guOt//ub7HEVEqxW/u/MZAwm1hzQBM/mC
         uoJQ==
X-Gm-Message-State: AOJu0YwramuEBxPvfP8JeyYnEoXDySazpa2qc88sp/GeaH2rf0KRhT5V
	r4GRCj4B7FmMdYSLFe+ymL92bWsU0JIgQsoKNbWVitsAWF6qG4DN4XHSvEQEcwC6
X-Gm-Gg: AfdE7cm8SFyO7Gr1voaR64ui+Tw/MYqucKk2mD4CYu8lFvvKg8lCPInm4AYEKmD9M/j
	tol0ZEEakIOmNUA2vt+zWYuVaaTXAV7APXyYXs8VP17KR2pDpF53yDaoKLQNIyXan4vBXSvQjho
	g4mIHiREMnxadVjiGieL7RJUj/ExBQ9q++X+NTTesi79h6/z2U3N4+2aHRfvaXRTV/M3Lk9pSSy
	pQ7vvyzAnJOz/yHGw4sl4cJse6oOhjFzrjX70+8lV47KJnr8TLOAUbU7AC79ZkuFYnqgwOFGcMk
	TB499fASHtkB8lJ4azSEw4V91y9NnXR2VQJ32KYk6wI2M5+0G9Q33Bnzo+9MXoYS9OwD2cCpx3M
	5ofZIitK1YwHpo02mU+TQ6bxk6/n1keFrNpZJH74RicRebqYAzF/lPK2NIfumnMSlu0FxmATY3Z
	U3juULsd6KpmukV3JSSCWmIwCr0BDN31hd8aLyBxJ12s1+AoiwhTvxFU+Mhm1EsQ9fEHuMCg==
X-Received: by 2002:a17:902:fd8d:b0:2c2:7baf:139f with SMTP id d9443c01a7336-2ca2ed345e8mr32541505ad.30.1782839161406;
        Tue, 30 Jun 2026 10:06:01 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (1-164-87-64.dynamic-ip.hinet.net. [1.164.87.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a70c37sm18694725ad.5.2026.06.30.10.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:06:01 -0700 (PDT)
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
Subject: [PATCH sched_ext/for-7.3] sched_ext: Parenthesize local SCX_EVENT defines to fix checkpatch error
Date: Wed,  1 Jul 2026 01:05:35 +0800
Message-ID: <20260630170544.18772-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch "Macros with complex values should be enclosed in
parentheses" error.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0c51f9826a77..a9d23d9f5947 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4979,7 +4979,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	int at = 0;
 
 	scx_read_events(sch, &events);
-#define SCX_EVENT(name)	at += scx_attr_event_show(buf, at, &events, name)
+#define SCX_EVENT(name)	(at += scx_attr_event_show(buf, at, &events, name))
 	SCX_EVENTS_LIST(SCX_EVENT);
 #undef SCX_EVENT
 	return at;
@@ -10309,7 +10309,7 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 	memset(events, 0, sizeof(*events));
 	for_each_possible_cpu(cpu) {
 		struct scx_event_stats *e_cpu = &per_cpu_ptr(sch->pcpu, cpu)->event_stats;
-#define SCX_EVENT(name)	events->name += READ_ONCE(e_cpu->name)
+#define SCX_EVENT(name)	(events->name += READ_ONCE(e_cpu->name))
 		SCX_EVENTS_LIST(SCX_EVENT);
 #undef SCX_EVENT
 	}
-- 
2.43.0

