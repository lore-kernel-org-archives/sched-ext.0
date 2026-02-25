Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD62DF134
	for <sched-ext@lists.linux.dev>; Wed, 25 Feb 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043396; cv=none; b=cQhwM36eD/CyA5OQqHuDlhqFbeJ6Mz41aCHgsazFkc9e5H29uyOYPItHW6KYaskl7CvCvoIE2BPGrDjtTgA25L57vLuiIpHezdTTYWucx21i6KcrBdaEbY7w1GeqJbXXDhngCoy0z62C15N3xc05AU24wnO6dukYz3UOgSfWbr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043396; c=relaxed/simple;
	bh=aainDFjD8ZWyLlAIRBhbZPAOtz5HV1ia+gAaS4MCc8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0Ejm20v7sDCH3ynq2uLTZExEA9ohx2a+2CmV4wF2lTz36FaKTkAOKb745ku81VR6918SpF+sVi5cRGwo65fs4W+3iauBwzaW5T6HBwqOQzcoIQ/YJ8g1kQdKG+WWO0/XwejNrHCYEKMtdo/+7f/T0XTnzroUsg9DqULZWNR5Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIsKSt5M; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIsKSt5M"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2adec255754so2485865ad.3
        for <sched-ext@lists.linux.dev>; Wed, 25 Feb 2026 10:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772043394; x=1772648194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snpvNedf18MMWPdFxGZNruEJwKMMl3KYz3FbqiGn6JI=;
        b=QIsKSt5Ms9Ea6jKsYhUb8skH2Zm0t2V6aAIrDaF/na9ef52hfGolNAhmCyrMVk7c7n
         bUdfyeiLY2HhkQOELLJR+PPy/lQ1Ji9vtiP79aJX7SfKkoZcfbNqMJYUwr9i8iBuJcNC
         /3hibYRRfaPy/R3mcgcQ83HO5Zq1BRgMBZrHOepxcsQjBAZTjPIphZRFsK8hen9Jk3eN
         Co3VG2WgV2BvXtbaZQgrPi3pjQE20gyijDBQovNbRoe7zagfk7LHWo9Vf8dxm6/NTeJc
         CjX2l+zYHaEmR6tlxN7odQoMSycePvtgK0IC+tZ6ZKT2s5dkXsq3KxaHOtSwPdlSf3n1
         gLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772043394; x=1772648194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snpvNedf18MMWPdFxGZNruEJwKMMl3KYz3FbqiGn6JI=;
        b=nJOM48Z3f+MxWre2ycK1YojK6ETQgMUIIyCzghSReji2QrN/Z/yF+iytxToWoTMni6
         I8DykeFlZ2tBtzFPnLdxQ25/VuFDOPjn5JHB3PLfNG2kt9+R5kVEptyuZ/kqskNvVhWn
         RqHBYxSp1PNOx3NRNDIiiCaeyZJ0SJIrjpzhBjSS3rXBUpB6/p6u2n0srh21kfkg2UwP
         gWwxZZ2iBlbQOCDpIQqW+pDOfyp6xcYfZCUTsAvc0wYe2vp09KznoHF9dITtjBrLUBLV
         /d9mJlondmnu2pfoUfPqDq5O/ZgdHiuWjSUyNUIN0t9fkcq18jTG0iUIydugPWgcq5QA
         qntQ==
X-Gm-Message-State: AOJu0YxdN7xbruHrN2bccYVFMbekpaqOhWrhiQvZYEuvm70NGfNmHBkH
	k9SyMmLLxvN9GPg7r2qsjfecZ3Dl+gfMkxozY4Cs5lTnpKttVllGIwcKeEmntQ==
X-Gm-Gg: ATEYQzzCJooS786t6346tVa9N096wwsxQsUXAg4bce7hdnJK4fXe/qZ0vKVN2rZuXQk
	RFnEd/gL4PpojmLCIlEUaumr9oTgTsbZ+FKisdiHMgi5DIQSTHE8AKAb1VF0V10S8SXsLPr8jcy
	z3x3QwlethvmAzKAqHwaH9n3N9rAWA0NWeQK1VUSgs+h+mgIVIU9Js7IuwBGmLD9j4RmcwzvEiC
	SziASgSc2eJ9tFNG9WnAk6kfiG3FzDb+yemxc3/7RuWUsCE5J3XB/bO2ic9XKohv+0vRmLcwTgC
	2An4+kWWcApeBdZPsw1n/ZHMzmSCCqaBeLNLc8TrY3d4XntWSEzdqKztB6V0UVaZdiw+jBwOctH
	awxFK3hrvCwWax1Jc5Nh5ShtmBplxGxheX6ll1snxTbM4k0QSg6niVau393SrA5jdWjG/cOft5w
	UtNk8WgpLtNvbjp9p/Juej69J4HHAYnv4Ym/PQ+6byB/H/JuWR/TSTp5UQF31lGw==
X-Received: by 2002:a17:902:ef45:b0:2a9:62f1:3fbe with SMTP id d9443c01a7336-2ad745136dbmr171323325ad.34.1772043393931;
        Wed, 25 Feb 2026 10:16:33 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:68f:cc94:9882:f73d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34fe7sm139695025ad.2.2026.02.25.10.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:16:33 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Prevent null deref in scx_dsq_move()
Date: Thu, 26 Feb 2026 02:16:24 +0800
Message-ID: <20260225181624.427916-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a null check for the `sch` pointer at the start of scx_dsq_move().
This prevents a panic if the function is called when the sched_ext
scheduler is not active.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9280381f8923..79d8184e4e11 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5990,6 +5990,9 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	bool in_balance;
 	unsigned long flags;
 
+	if (unlikely(!sch))
+		return false;
+
 	if (!scx_kf_allowed_if_unlocked() &&
 	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
-- 
2.48.1

