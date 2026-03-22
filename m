Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EB2D2496
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199600; cv=none; b=qBMpnlOV19jYvQQ/V8BnJFR8SxEpGLXDa2FOblz2DNU50GnTIeR0Sj5S1NdqtqOcCjBqHL/yWZAU+FYDfbj4NqcTc4aO9eATvtGpPxyO6J50pGmKBL4rIRpd4ammpUD56lnmz5AeaO60eEMssah6fG/ikqwipQx1nasF3wviJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199600; c=relaxed/simple;
	bh=fW5Bp5xHP7X0OJ1YJr30k22RCkr0xCzA6mo16FSlKow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJ0bbOp+9Z/MTxeLwd7OX43/zRf3T8h7iwl8OWapcjiVcIxuBHyAqpIBhhdizjj7CK2qOBZnA0L2U+/Ehnng0fPvFd7h8ggKDbhEKO/tGfL8CejWU50a5E+uHen40snSoswrikzPE0TZ3Oo6aLt7kIPIYsRADYsFA0Xgks+ATa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6xiUA7H; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6xiUA7H"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so744560b3a.3
        for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774199598; x=1774804398; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K6qo01IQ3XaXSXgbBtjuhdJGIL5gLBo1GyCSLVuluhs=;
        b=M6xiUA7Hokuasa1Jeg46NMG4sub/3yfE8Cd9s3k/LqwnM7KfOs0Cvw1Xkbc4y2mk5w
         h2Y5VHPonSPWPErLvxevVhTHygGqZHkxT3mlGAjGOaFhGZsq2VU5uj8ABCBOB5wFhmxI
         MYuB3T/RLqJC1ZYIvXQH5PJb/RazvKW9p1otypoi9HCz5v4rd6qUsRmfv0qhJaTXD+7E
         OikskKd9o/X/1/PlxzbmtKSIV6XFdofNRF7WqU37yu1CjNJDUmS4Wts6+GRDfo0+o8Eu
         IZN5GH7QZ7udFEoA1Wxr4pNVtq4on34XuXfgp8ovfo5rAEdl55ouaepEBO5FF8ESPUPc
         25Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774199598; x=1774804398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6qo01IQ3XaXSXgbBtjuhdJGIL5gLBo1GyCSLVuluhs=;
        b=P4q/uvFeKZfBWB40AhoYE9DG2DO9rw2YoRDN+sNGIRxGGK1EVeDK408eGAVm/iHdTT
         gRYwRT6JZRWAtOAih8iHuzqgsevaUXhm34ymGoHgTlltvEzeaIJ9mggJILoGv+Zqn2Li
         8OAu1DAPcq5tPhfNInHsFdH484cR9/L8z8wbUQzJlbe8CSrpmHL+OPcvmACMoMS7fFp/
         v5YcXY7DCdPyp4QCEzF8nRVvBAMhnbmPvQJDEBMhfUaqiWuOlp9aCAJ9aoB9hY5wO39r
         y20JsLrVm5o+e1EA6p6A1TKASVhE0D+//ncz0gYWK2J4fOTl4ua1e3Vac2WxtR74Hnim
         RQXQ==
X-Gm-Message-State: AOJu0YyfPr1ewsAuP0xLjfFHXBwWfOmz9i8ZD30eoE5M3w5unPg1xGTj
	/OA+5CxE92+ZGyZEtZ/X/ucOsHinUw2eKFg7BBaEewNYlkdI1EQNBF0CbiVTxgmo
X-Gm-Gg: ATEYQzwpNQtQSU8whxBjJqi1evTp+zWgQbEthZ6jXaMcqwJtGfi4Wb8xMOPN6Uer/mN
	te/m8Jd53srsubscWiGyffZdzDH3Ce3OMUuLla8xTK+LAhF/on4IE7K92QpAtzEG1CvB62A2GIp
	M1Iz0rplP1aZNLztcHiSkLVgEVoCGSoZV/h1o65fHZu1+pSMnyn1HeCUwWwRXBZSBZVhScflmIE
	5EW25XDEVc/aU7jAqX9fCiCpAOLqqi1OC1+pWzkA5ok0d7ZkAfUk/FIrWvZHKB6kFwW8TpdOxV2
	XiQL4M8v3j/OOaiQtxDFfKzjbbrkH5KagaTwti5MIjXqtTEn8JeKDlBVGrq6BCKwjitSV+jUg8A
	vAYGYwS29guxWi7+WwgNlBT1TJzVrtkDK54dM9HMkViitywW0ABxz/KxE40LO4YDpZBjKu57J2f
	DrShQg9oejc81BVCB1k4lYtB9RzfltEhOA5IsaD6mbQQXOBo5k4Fw=
X-Received: by 2002:a05:6a20:e291:b0:39c:113:14b6 with SMTP id adf61e73a8af0-39c01133c1dmr2112288637.61.1774199597797;
        Sun, 22 Mar 2026 10:13:17 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:a92:d962:9ffe:7c38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a938aebsm5863459a12.17.2026.03.22.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 10:13:17 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.0-fixes] sched_ext: Fix invalid kobj cast in scx_uevent()
Date: Mon, 23 Mar 2026 01:13:06 +0800
Message-ID: <20260322171309.2640439-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the sched_ext kset is first registered, kset_register() emits a
KOBJ_ADD uevent for the kset's own kobject, which is routed to
scx_uevent().

scx_uevent() unconditionally uses container_of() to cast the incoming
kobject to struct scx_sched, producing a wild pointer when the kobject
belongs to the kset itself rather than a scheduler instance. Accessing
sch->ops.name through this pointer causes a KASAN slab-out-of-bounds
read:

  BUG: KASAN: slab-out-of-bounds in string+0x3b6/0x4c0
  Read of size 1 at addr ffff888004d04348 by task scx_enable_help/748

  Call Trace:
   string+0x3b6/0x4c0
   vsnprintf+0x3ec/0x1550
   add_uevent_var+0x160/0x3a0
   scx_uevent+0x22/0x30
   kobject_uevent_env+0x5dc/0x1730
   kset_register+0x192/0x280
   scx_alloc_and_add_sched+0x130d/0x1c60
   ...

Fix this by checking the kobject's ktype against scx_ktype before
performing the cast, and returning 0 for non-matching kobjects.

Fixes: 494eaf465197 ("sched_ext: Replace naked scx_root dereferences in kobject callbacks")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Link to full log:
- https://gist.github.com/EricccTaiwan/9d3a2bfa11326fe134cec9f46125094c

 kernel/sched/ext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94548ee9ad85..9164a2348e39 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4834,6 +4834,9 @@ static const struct kobj_type scx_ktype = {
 
 static int scx_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
+	if (kobj->ktype != &scx_ktype)
+		return 0;
+
 	const struct scx_sched *sch = container_of(kobj, struct scx_sched, kobj);
 
 	return add_uevent_var(env, "SCXOPS=%s", sch->ops.name);
-- 
2.48.1

