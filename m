Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D80202C48
	for <sched-ext@lists.linux.dev>; Mon, 25 May 2026 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729825; cv=none; b=hkfl3VHDako/1a2XP8PGEmCGpqH2wMf20ARY+pnX2kfT4RmgEvBRRbJx1idhA1yTbwk46oi49iUOMlWwQBwOpmuGLe9pKWz3RbPn1wxprFKP94tsgoGh44hgY1dOG7nMcoF+6iH4Wiip3wbI5+nZdAZaay2/oWkmiKgL6KZkN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729825; c=relaxed/simple;
	bh=JdvYWGrSco54EEqETbKJVg6q93Z4ZxJu0AmOTiAuFJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABUzB/w2KDBYFi8OdfTnovDjqmZxBTKx9DD7jujN//aQniRUi4Ou0FjfO28lUpPg/XIQhkRmF56CSw4/rzO5ZnPMPLcKBkfwwRVwDxdGL3Oph9vBkExak3NZl/xVhhkR8uB0vtT0mi1QTwEqXyizYprcnPlBklYLywvjL08u9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCWceZFV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCWceZFV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bc85eda6b6so49224025ad.1
        for <sched-ext@lists.linux.dev>; Mon, 25 May 2026 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779729823; x=1780334623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2GwsuihI9h91LLFb14RdfQIAiapZCcyVFrlmi8na0M=;
        b=DCWceZFVkPrJco5a5IzoR1g7+0iMOn9kjC4UZdEMrDYjpyL6M8cmiff+kYwjvkrO1c
         Rih0dSAfYycnDBC1XNEeiixiOk56q+rRskVY6TOuBKhZWedB/MRoajPsnxau3FJw5G0U
         /q1mGeHYFW12C64k2ua4nn0d/FJ7g6jOByICNazLaSy2beZ+9Wy4HFwZlWwbDDCRXkbf
         k0cZHTvCq5IMlp0vylqyEzzvs3V/VL/WMZyu6S9AOp4BY2N3cr61TYz+ORCLvJFSIMwR
         C4kR0Z3IS5c1/hVtGQpT4piG+1JK7pzA+hbChMtaNqFmY1coXy3jz0/LuVy17sjjvrzp
         l1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729823; x=1780334623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2GwsuihI9h91LLFb14RdfQIAiapZCcyVFrlmi8na0M=;
        b=el15D2JjaN4ncQvFObTQIGQuiCCLhpfSmoAv0G9gaIbDmZrhhiCzQEPHcbhg8MWKkK
         WKaMsxxuDiXn43nZbeYRRmJZl3COrfFc3jeAdLx6157svzlzbonkGg353zpVnwAJdTf4
         Vu5tAKcrsIkedEvqf4BFIEW+ePZ+2gD9vLk7aq5MmzoylSTNZaCjAt7dD36W0UKAFHaG
         aaYJMJYFqPAFd1zz0DoD/XzpUPdNEb30bRCuruZBaJ4yZrdl2ENp/GTeRKiFAzXFl1ZK
         7kKztGg+etgJimxejdjU41tfMewGbHHTE9nTm+I1dO/Lj5DfbTvKA6j94P2yUhgx7/1m
         mzXg==
X-Gm-Message-State: AOJu0YxXN5Vz7VU2dA+1stS4AHHmBS5HFUVnAQeGnBNESVdbAbeOe2Iz
	KKlru6EEmMeCIYM8c8SaD9ZnY++c/py61krXtPlQCW4fD6zSJi9As92i+R6zKA==
X-Gm-Gg: Acq92OGOx/1WggpyDMLZFom9ck0cH9HxXzJyMC1ZA0/CN0VDN55JWwSGek0NjgbY2LP
	8nUJQu5nUtDxze6stvXMlyejX7Kvr54484B/XBFnf9/Nz9FSQjS1TfX42NvuFukeE63hi+xe3jV
	57ZpAfwnlzSykICZjFL1svBqOv5GqPB4fM9tr/u5OMFy3yHR/mFuhxXK9HmzXDlS4Rik1MA55my
	RC49MfRA9YZm33vYQjCzA9Z8+jgeKbLnm0z3w0AeBIbJO+GkwkeWoLX6Spm9q5/+JT7WTbdkZ/N
	twUELksSutBI/7dXuNjYRe0JR94+F8siCxt/iLGVLiInYt2m9BEIjB5Ia569Ac+I1aj5yWGhLLn
	gBxkLC1qxkBAMZrEVrUbCCf0KPRMmn5BWDH0jPa5xTRhF6GkAWlfJ+Zi/fISb2CzWbri1ewPWhx
	ZVptP+UrxEkrXKtoq7XzDVsdMT6ZGKvmE2oZF7qu45ojiGL6otwigL
X-Received: by 2002:a17:902:db07:b0:2b4:5b82:a8e3 with SMTP id d9443c01a7336-2beb0631a36mr172186075ad.24.1779729823247;
        Mon, 25 May 2026 10:23:43 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:1b1d:c3c0:6d07:6b5f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ce43bsm95569185ad.28.2026.05.25.10.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:23:42 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: idle: Fix errno loss in scx_idle_init()
Date: Tue, 26 May 2026 01:22:31 +0800
Message-ID: <20260525172315.156381-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

|| is a boolean operator, any nonzero (error) return short-circuits
to 1 rather than the actual errno. The caller in scx_init() logs and
propagates this value, so the wrong code reaches upper layers.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
scx_cid_kfunc_init() in ext_cid.c already uses the correct pattern. 

 kernel/sched/ext_idle.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index bbb845f36a0a..6ff80722f645 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1509,13 +1509,9 @@ static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
 
 int scx_idle_init(void)
 {
-	int ret;
-
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_idle) ||
-	      register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &scx_kfunc_set_idle) ||
-	      register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_idle) ||
-	      register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_select_cpu) ||
-	      register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_select_cpu);
-
-	return ret;
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_idle) ?:
+	       register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &scx_kfunc_set_idle) ?:
+	       register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_idle) ?:
+	       register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_select_cpu) ?:
+	       register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_select_cpu);
 }
-- 
2.48.1

