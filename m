Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7851AF4E9
	for <sched-ext@lists.linux.dev>; Sat, 14 Mar 2026 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773452385; cv=none; b=AjZ35zNqOxYPlKCPiM4Vl9aYF3qDGpGu495bpZbi/ef31pXWx59RswMRDJ5hrBuMJSrycXORDOOXZfTeLXT+ljANeYeG2EgxcDu0XLdX2eXjkgH4iNwmKrbhr7PxOpY2LktIV6GMeXANApiDctChPC0Oor6fIv324yNogUQf3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773452385; c=relaxed/simple;
	bh=JWBU+revNLiU051sHSBgTbPxPH54uL0h8PkcTap/zM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iwTrVep9fNVBB8cpa7liDgUDCwHhfvmrGBID+HwSeCh82ExGlENwtdyQL/8kT752XeSoIQl72t2BkA4+tXnWOCcw7Tr10HXSu05Ww7vvywoeLjxlnjLpE5ut/1m1AY3t0cMDM+JmsTO0nkMo+dRwFbdkqBJUrm9BTTM+XnNO7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHCG0HZq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHCG0HZq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab232cc803so13513785ad.3
        for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 18:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773452383; x=1774057183; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAJWNXjsO/O8xArroDNSHxaklI4x8bUA1ttPHuFbeDA=;
        b=iHCG0HZqb7UaoKXL0Cl9hAdUK3DJ/wzQpHvSCtnHCLxZr1pqKDpLPwi0HyoTRR5fjv
         7ZdgpwRM6e0OPBlAKJHXfaZ6BWzWDtHMEuWGC4L/J9qTgGVJ5sL/fcwnljPIN9lDNJY0
         J0BR9YGTUvETEYIl4FbGwjTYxk0u+uL/1/IQrQVqf7ZpgfnApTQk42vEH2t9jweAqCwu
         K6MpL44yz7IKcrd5GN6+QavwhXu8gy4pIVzbi+pcmNGFCvtow1/zgD2OfTJLRYUIe6NY
         gtDN05n0dPqj6d5ZkCdHjZCzs4Ype8sMkc8FR79UIFkodJGRq2BkRpOcuVkut1v1Iz6x
         m8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773452383; x=1774057183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAJWNXjsO/O8xArroDNSHxaklI4x8bUA1ttPHuFbeDA=;
        b=aMvOjMgMOd4nE+eFlIqmIWqvwAmsTR6yu+uahbXiFbqMW3ZnVRKt2iLO1cf5Dlgawa
         vVh9Eh4aKrqOu8rHoe8+5jhK9KjynC7c0HyL9LPqAWxm2RmdAMy79q+huanDm9RLaSBG
         rbSuXZeKvTAziHexfNCmrSsCkGmG+AlWPjzezE4RS/m3NWuJBJmdCWCFXwQ6uBfmOv08
         uA7mjbr4VlaZ6+9U6aFk3zwWZNYFDs98mTnVsFPe9Np9gIP+ddKkUChctl5nFNYP4yza
         HcN0EF5j7z19mCL/H35v4pOCsp25LloOQ9Az/ylQuC8jH+CSzX5cvUWzUuaeUux0UX3D
         8Y8Q==
X-Gm-Message-State: AOJu0YzeSA5NNuMypaP5OY5JfkZrKbY87lkShFNDksDCcPTjJbvZtCt8
	FxAgGLPZqlbJx4H64ERsgBXNnNXyNkf+UWB1yDy19T2L/sS1ha960O4b8kjUKg==
X-Gm-Gg: ATEYQzzdYbVHx7Qo6xRUq7ZPSnVsxWFhWXcXzeUCMitYNLn2JwpTH/Yz0ByhzhRvzOQ
	iw33UaD1bt5MZyiToeeNCq5RZ5HAqj8p634OP9pCJMfJVhAdWSteP78QBpg+r6o2IWp2HxowA3x
	yyppyA/bxa8h2oUMVS4PLOuTpABLzvJfRo8jb/ujC3WHnePMyolM5g+VmhQXE4QwFcWaGblYHek
	KdTsArBfNkHiW2krxlbYV+bwDXIgYHo1xR+SXmqjXhXm7BdBUXDofIyg3wv2QwMZv0pzUPq62IV
	6Dk4paohtR7g12x2EqzTz88AUd7fiQbo894s4uBzkx0uVzA+s1MsVrz7lJhGlyvcQaHqMT5rCgf
	IzJbomYPDQzFDwexclTe3bGhrtGu/XX0yx6S4lo3p4GrQg11x4COJ0wlUHmU5v3qjwuh10sSWIB
	EuyICpsNoPx1Y1ckz0yBT8dgLJLmsbC/Wg3qcalQWSNTLF3t9s5Gs=
X-Received: by 2002:a17:903:174e:b0:2ae:7f28:124b with SMTP id d9443c01a7336-2aeca955e2bmr50515085ad.22.1773452383441;
        Fri, 13 Mar 2026 18:39:43 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:812:f4b6:2aba:4bed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece416212sm35512635ad.0.2026.03.13.18.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:39:43 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Fix uninitialized ret in scx_alloc_and_add_sched()
Date: Sat, 14 Mar 2026 09:39:34 +0800
Message-ID: <20260314013934.12666-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under CONFIG_EXT_SUB_SCHED, the kzalloc() and kstrdup() failure
paths jump to err_stop_helper without first setting ret. The
function then returns ERR_PTR(ret) with ret uninitialized, which
can produce ERR_PTR(0) (NULL), causing the caller's IS_ERR() check
to pass and leading to a NULL pointer dereference.

Set ret = -ENOMEM before each goto to fix the error path.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e7ab3647e35f..c45e4cfbae17 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6210,13 +6210,17 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 
 #ifdef CONFIG_EXT_SUB_SCHED
 	char *buf = kzalloc(PATH_MAX, GFP_KERNEL);
-	if (!buf)
+	if (!buf) {
+		ret = -ENOMEM;
 		goto err_stop_helper;
+	}
 	cgroup_path(cgrp, buf, PATH_MAX);
 	sch->cgrp_path = kstrdup(buf, GFP_KERNEL);
 	kfree(buf);
-	if (!sch->cgrp_path)
+	if (!sch->cgrp_path) {
+		ret = -ENOMEM;
 		goto err_stop_helper;
+	}
 
 	sch->cgrp = cgrp;
 	INIT_LIST_HEAD(&sch->children);
-- 
2.48.1

