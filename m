Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411C315D58
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774488584; cv=none; b=eP2rX5w+p0o9lOp6wZSFIh3KebwCuXXSWLgSZV/QIkIphpXXXat5oq2oUWWczY0yZ/3sL2zQUZ0XeSO70ZI4ojHCpD9XMsJITOUrwbaR3ce1QSSP14oq5fb3VdB0d3MABoTMAu8VLyAT4gESuDFDyPXXjsOGSD+jG8hJQ9dGWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774488584; c=relaxed/simple;
	bh=aoMS4Z0c1Tw/xJJd20bcIM5ajCI63vAncNQP5u8aru4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ndj2Z9r3hUDs5WPVVWaJNAOm7YNKxVVbUO2t544rg4VmsYGoIzjPHmSgq9toRD17IjDHbDkEBHFTV2TDivnScHID6SmO5Bh6OE4acb+BKn0Z/0PEPupEd4SAHvfnWCkqDbFHzjVrICc2ZBy4OVIGXvuFPnoEDWhY7JMQelcfBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUGWgT+v; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUGWgT+v"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76682834a3so211260a12.3
        for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 18:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774488582; x=1775093382; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5qf22fMJpnBD1TIE1e+DEl9Gv22pMUprSj5i2JfdzI=;
        b=XUGWgT+vRFwL1iPN2zlVT5S9fvKEt+XZ8oo9WFNeULzLFAX3ddhoJdua7Wvouq8Xug
         KIiUrghx8sQhuLSSpiz0Jw/se8SJWcimxAPBvdVvlYT8YDbxI5zbu1VyQaWtF4sTnl8c
         6GZMAFFqNht/G+IPMXe4zfC2UtR2VaXR1iHCw+RHkBXA8ldMTj1pf+3x9OGqwyNDqbZo
         FSqE8AnR2CroblZ50WqA/SvpAUL5UKWUieWBDyf5CXl8WYLzifQBzTv3SRskXq0SR1LX
         QdXjaYB3o+MhIadLD7NQIi9lt8U5O+nZ92lN9XHsfolElhIpI3KMLFzarIG9H/voyzVo
         9gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774488582; x=1775093382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5qf22fMJpnBD1TIE1e+DEl9Gv22pMUprSj5i2JfdzI=;
        b=jtbFpzAR6Yk/cSU1F42NETWjwXcC1ANxEX4h7tn/1wcoVmGxy7W1ntoFFNq3Nzq6Yi
         nqUc2hJweDQX4HLGvKzwivRR50BWL4swNADuloCsUhwkW8voXzz2RS3k9OnkzhA4gCV5
         GShPKe4CB90mVQJQCmz+ydpykm4DVKB7wvAr9BeS0OhX7wX+OryzX/CABkb9wzkC0ih0
         FGP8KdqP1wFtysIHItQof7T2o26s+2F2O92VwJOQdfoc2ZXu378jnoWFKGoesTVht2XH
         Nz/Q8DinaZGPEZ7pJPLOKy/SiSfzxn1yRTdQYN9775tx5bc/x+PHRudD8Ue2tQMN5vYX
         J3JA==
X-Gm-Message-State: AOJu0YyGuz3xxzHzTt5J8spT84lFN4NJrARVdG80XdyxG7LqbAeRh4sH
	GMxUuykTEujYIpKehKQKEnwkIBgt2FeIoVLu+N+ekUDp8yO3YKYZIjjsTT6+PQ==
X-Gm-Gg: ATEYQzxvHPaRoDG/0lFvcYpL+3ME3nxukuatU11CoYVP3d9y+t/SbDFSMg1EfKgXRzL
	HsdUEXk/4S4DPoo3VTwDYh2QDMd2CaG5AFPbN4v8GOXfZprGQPYozr36QKWiXqrboPLcL/HGuLL
	GMGPN2Fokv6v0ig/YyQK69HzmyvMRGpZwOTyA/XInypuyea796pxjn+7Q5sVOFCuM+UqxiKc+tP
	L5OxtR9QgUIAFPWWBfkOcsMhbJZ0qQONVpkywoYvnJ/vjgz5/WT92a+c+OTyG0auLUk/dKNmgUL
	27emJt57ZMW86EFywCx3njwJIxviKcfcWjM4gpCCRCpfedncXHQ3OhQic8ieRUTAdMJDo1eAbKt
	ZK683POvpzbdWFkt6EeNG8oOfWXVxQs9ZRJLvZyUeb1tR1nPYZ8cEvPRuo8W7ho6pPvcrYpGQu2
	NEwG4jTj3dTxKotRVbHofMdl+sYQh7K/L4hqr8XlVJsdz6TndvugA=
X-Received: by 2002:a17:903:37cf:b0:2ae:bf32:20c8 with SMTP id d9443c01a7336-2b0b0a8ceecmr59648105ad.31.1774488582037;
        Wed, 25 Mar 2026 18:29:42 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:ac9c:4df3:99d:84b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76bbdcsm11672055ad.5.2026.03.25.18.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 18:29:41 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Fix missing return after scx_error() in scx_dsq_move()
Date: Thu, 26 Mar 2026 09:29:03 +0800
Message-ID: <20260326012929.610671-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When scx_bpf_dsq_move[_vtime]() is called on a task that belongs to a
different scheduler, scx_error() is invoked to flag the violation.
scx_error() schedules an asynchronous scheduler teardown via irq_work
and returns immediately, so execution falls through and the DSQ move
proceeds on a cross-scheduler task regardless, potentially corrupting
DSQ state.

Add the missing return false so the function exits right after
reporting the error, consistent with the other early-exit checks in
the same function (e.g. scx_vet_enq_flags() failure at the top).

Fixes: bb4d9fd55158 ("sched_ext: scx_dsq_move() should validate the task belongs to the right scheduler")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 551bfb99157d..a5d8871ac865 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8094,6 +8094,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (unlikely(!scx_task_on_sched(sch, p))) {
 		scx_error(sch, "scx_bpf_dsq_move[_vtime]() on %s[%d] but the task belongs to a different scheduler",
 			  p->comm, p->pid);
+		return false;
 	}
 
 	/*
-- 
2.48.1

