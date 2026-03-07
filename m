Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569838BF72
	for <sched-ext@lists.linux.dev>; Sat,  7 Mar 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772910572; cv=none; b=QMpLvAPOMs9qy9hkJgCX9XB6YITRwLTY+bsDF5Gcy6WxPkUpLdmJUU00ysH9zdIK+UbFjS/NwxDyc98yILHJ9z5dmpil1NbACf0mE25EYqCMnxelOtTRbjJvDUVKRyxagMqSQgn7fuaRbV3dZ2l8+AnrKTWTke0pA6oGu3kGVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772910572; c=relaxed/simple;
	bh=tg7Wm5qxROh0XYbyFkM/87fjbL6jRI2nPfA6IgBbgnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuhTbZ8/3ew69ZH705mWBCgCD0Mtu4xAUoGclfLxhLoY8iPbRYIEEp9YAf+OeYBEchl6KzNS//poV/wbZlS2EWqdo0s3/85uqT1PIwUZyhXTUBhhxyXekD9YZBaViru2viQz6yvsuIVkuSn9B7s23TFitTtjc1dqEFnd4pZdbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjllA0OW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjllA0OW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad9a9be502so68022025ad.0
        for <sched-ext@lists.linux.dev>; Sat, 07 Mar 2026 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772910571; x=1773515371; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Tj9B/prQ921rlNJbCa/J4VEouc6QgVgjRvm7bpzoag=;
        b=RjllA0OWVrfU4DavCnB3HNOFkstuMXsUHbsUwf2dp9iHCIDHmw9rxG3Rf934bCgbDX
         34v+oxEjAZVZu5UUvvD9zfpmN5mm8Jgmca4wYVpuOJD3t35IbyzvcAW6q2R9PpGZh8Kj
         nr+FLeU6Np7PDMmIfJNGHTtCb2KXDECMRwtO203xeHy8HlXMAOMBXSLePGl4E7HE3zen
         ARmzdAn2H+IWH9KShdDSs0jCFnjbbeGaCrHZ4WKPjrIBAnLt8+n66KgizMFqXfqNb2lf
         UxkZGxlx5l/XlFvqUh7nYAQVg7LywJqVB4a2IuOpeh0M4l508LOcKM9qyCWui74MgLN7
         QrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772910571; x=1773515371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Tj9B/prQ921rlNJbCa/J4VEouc6QgVgjRvm7bpzoag=;
        b=Ad3l1otxBkribbs0ZzN3X3wjWY02ypvjuhQC/2Wj9aksj6vMz0c4jAzBsTslm+O2V6
         PbilFxa/Kr8tWqUYZq8xSE+W2DtxGDgRYU+IyX8Bc+tuLH/G8OXD3FizAm8w6v9Sc91N
         R7R5C7zPaMZRL1KNGT6fcgnFi0614/sgdioVApndNVey9D0zOOwhuI2Ey1G4mulvvhRn
         cfYRZXgDC+JTS3hkiOxJbepPu0staxx0hpHvg9nq51diZH6DOUYa6EaTTDa1i/+0cqEb
         78BXo/WcUFfWdfz9V9GQaKnTSYsrMG8C+DfUTdZG5oRo8WiHcCIgfyic7BxwbGl62PLi
         LCTQ==
X-Gm-Message-State: AOJu0YztSRGM91xhAtzhQtCqpb0RFfXvuV4YUjLr6PTyvLa9xO2sNqqB
	3//+4uhUHo34gfMgoivJ9fTBekE/BEME9OOckESvW1UcHXRPsy8A026/gFjSWb9z
X-Gm-Gg: ATEYQzzUjMkigv5bjgurWL+yeILUuOEwKCLCFY/jzzyTkmKYYnnYRNSn7KuIooF/7kg
	qQjwg+cq7NC2yzJHxZ3IEkuZGgoNvC0ZFNofApUBuULWFwlSVkv+d0MxtUw7ARquQ0BmuduMX/G
	SYSG6xLE+qqshkBSOqPpc88GWwKy+iUU41cqyeLATUys2zBbkaflFBDXwpqFdl02mx/UjvHujE2
	xwoTIYG24wyGAsE9VcKnfDtt6g0A3NaKRxpc36c7Y3j4q0i2DN4Akx+vtEWabFXAnvvP1BuKL4+
	n+m9v+JDZI+g+CulOmpZ3O+wJnSJVNczvR7q58iElhBhZn0LJih2MTGnQzc1MTI6X+reDVwax3U
	KWwmo3/LOQhH05OvLCmx0xUsmlZou/UbfuB+PV5o36aisDTwZjbE5H9MeoURQmwxfB1abqrfuyC
	lTzV/ZVRdT+Y/mcEN3XlzDDF8L0cJa90Z3IOjNN0VQDzSXfQCc4I8v
X-Received: by 2002:a17:903:13c7:b0:2ae:414c:d0a8 with SMTP id d9443c01a7336-2ae8249a762mr70573645ad.48.1772910570698;
        Sat, 07 Mar 2026 11:09:30 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:80f8:4f1b:d5a1:9c83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e585a8sm57908575ad.7.2026.03.07.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 11:09:30 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Use READ_ONCE() for plain reads of deferred reenq flags
Date: Sun,  8 Mar 2026 03:08:43 +0800
Message-ID: <20260307190843.4117532-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a90449b12682 ("sched_ext: Optimize schedule_dsq_reenq() with
lockless fast path") introduced lockless reads of drl->flags and
dru->flags via READ_ONCE() in the fast path of schedule_dsq_reenq().
However, four read-side accesses in the locked slow path and consumer
functions use plain reads without the matching READ_ONCE():

	/* schedule_dsq_reenq() - local DSQ path */
	WRITE_ONCE(drl->flags, drl->flags | reenq_flags);
						   ^^^^^^^^^^
						   plain read -- KCSAN data race

	/* schedule_dsq_reenq() - user DSQ path */
	WRITE_ONCE(dru->flags, dru->flags | reenq_flags);
						   ^^^^^^^^^^
						   plain read -- KCSAN data race

	/* process_deferred_reenq_locals() */
	reenq_flags = drl->flags;
				  ^^^^^^^^^^
				  plain read -- KCSAN data race

	/* process_deferred_reenq_users() */
	reenq_flags = dru->flags;
				  ^^^^^^^^^^
				  plain read -- KCSAN data race

The KCSAN documentation requires that if one accessor uses READ_ONCE()
or WRITE_ONCE() to annotate lock-free access, all other concurrent
accesses must also use the appropriate accessor. Plain reads alongside
READ_ONCE()/WRITE_ONCE() leave the annotation incomplete and trigger
KCSAN warnings.

Fix all four plain reads with READ_ONCE() to complete the concurrent
access annotation and make the code KCSAN-clean, consistent with the
lockless fast path READ_ONCE(drl->flags) already in schedule_dsq_reenq().

Fixes: a90449b12682 ("sched_ext: Optimize schedule_dsq_reenq() with lockless fast path")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d5849ed4cd3e..88980c840a71 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1187,7 +1187,7 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 
 			if (list_empty(&drl->node))
 				list_move_tail(&drl->node, &rq->scx.deferred_reenq_locals);
-			WRITE_ONCE(drl->flags, drl->flags | reenq_flags);
+			WRITE_ONCE(drl->flags, READ_ONCE(drl->flags) | reenq_flags);
 		}
 
 		schedule_deferred(rq);
@@ -1209,7 +1209,7 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 
 			if (list_empty(&dru->node))
 				list_move_tail(&dru->node, &rq->scx.deferred_reenq_users);
-			WRITE_ONCE(dru->flags, dru->flags | reenq_flags);
+			WRITE_ONCE(dru->flags, READ_ONCE(dru->flags) | reenq_flags);
 		}
 
 		schedule_deferred(rq);
@@ -3817,7 +3817,7 @@ static void process_deferred_reenq_locals(struct rq *rq)
 			sch_pcpu = container_of(drl, struct scx_sched_pcpu,
 						deferred_reenq_local);
 			sch = sch_pcpu->sch;
-			reenq_flags = drl->flags;
+			reenq_flags = READ_ONCE(drl->flags);
 			WRITE_ONCE(drl->flags, 0);
 			list_del_init(&drl->node);
 		}
@@ -3921,7 +3921,7 @@ static void process_deferred_reenq_users(struct rq *rq)
 			dsq_pcpu = container_of(dru, struct scx_dsq_pcpu,
 						deferred_reenq_user);
 			dsq = dsq_pcpu->dsq;
-			reenq_flags = dru->flags;
+			reenq_flags = READ_ONCE(dru->flags);
 			WRITE_ONCE(dru->flags, 0);
 			list_del_init(&dru->node);
 		}
-- 
2.48.1

