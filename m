Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83759288C08
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668128; cv=none; b=eG5euUEE5HWSeVptFxf68P2x7R4zlJ4EHm/AxsQgzrTJIExk4qfwiV6GgODtLu3ARq54/0ivxQaPOi3sM/zuxgEqXL0hTGQ0YDPYKZLoQsT4j1DrPL/RNo4bGP1dWvC4DOjhAW5gk5RTzw3WkHEDWval9MRY2sB3t/gdUYecbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668128; c=relaxed/simple;
	bh=KOX35oLix0aXeilDvaE9a88hTtqUVaG6GDtVuYXJgJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRP1z21d7Bn2ViItql/CSTKHlb83A2IM0MT60FfUZiROAh+H1hTNu7jNo2vl0oWw3gxFL4T/Udj6lodJoCXde9FvPOFXCh+1zZR1kKyShwsuEmIgp3mkQeXCXfkyJhfQl4GS5sooM8cuclyJqk62vO5TwRjjMdt+TyjLeF8k0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX1Wm7aD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX1Wm7aD"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82418b0178cso1549737b3a.1
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776668127; x=1777272927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JMsUjrgyaz+2/pkpJr90o73StFnaRr/aiPe61+5lYc=;
        b=bX1Wm7aDfN6wYjLMu65bx32q/IBjPBAOdCJ92yd3rz5ztxR19myw838lM3IN3UPxqh
         MsimTh4ZstPiZBocGgw0Iew7TFDR5ZLf3dzMDMdqVOU5xsonLq9cNSF2LDKdM4cMbeKa
         PLDA5LpB8I6pWzHaYkcWLjq8BacAbJtLjFIZEY3lUbHCacmhbyd7vD0PsiVjK0VzsdPg
         pG2ajfH026Rv0cbEzLpwGiQRBlMdbJKV85ohIVUjgdZ6K6pJ2y3fvuiphPjJNx8YbO1d
         LqUX46/U0/sS5/SkZZrfPX2MqZQMkX9CN72KvrO8u02lDrj+4qunjZ85/wLSoOaGu7MJ
         WSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776668127; x=1777272927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JMsUjrgyaz+2/pkpJr90o73StFnaRr/aiPe61+5lYc=;
        b=go7cl+Y6MMX8limU0dQSUz5HZVbYALwo7IfM/XYMPk3y7zVT1Hl0d6KdfFgIAFoF8B
         0BbmhroyK2VWDrmGLsqzBwAs7L0cE2ZoUsuLcIp+4WpAMsU6d2u4q6/ePjPD+06EBTIB
         zt8DvUOvlHJjCuPRcawJN6hweYrmFmQRWLI/74YxiNLf6/ZlhfjuxkjQFaRyZy/V4Rvk
         jrkVg9IpQuoctSd8ibSVujGUHx7b86/KFgMW2RgEN0tKHfxk8iZW82LXeeNZEg5lM8zZ
         zmuZCtdg2n2plwyu10MV65SqNXhR1EXYqs8/SaDrklb113mTlUJjNJfQUvayMuEH5TO8
         LfmQ==
X-Gm-Message-State: AOJu0Yw7LCJuyqIGfFC5RZE1w6WVbSz5HkrRdAeSE/d3j332PpEZ9FzS
	rUMj2XPeHFTPhfumE72OvyBgBv01obfUsG69K8PpUMEqS/pIao9HcWwnAeAqzA==
X-Gm-Gg: AeBDievKXITRnAe3E0o0xxtpEUN33ntYvhLAHIBEQqLub/r4EEl+aavyi+4169nOY4O
	x4bqUXQC5NOdv6UitO7XuXIdAyWLO0M3SXzeWsu74bgRV8OY+crkuHjaUKXvggF3LKZU9kEhub3
	0N8UIcJnVu0buNfLig/+K+FDPzDaIaXs1mgTuTBQsFCW/24lyaLfRJFnsPfO73dkmX8Ky1T98cp
	zXxS++TNffxlMirY0Ct/YY3rMunCHXm+fmO/OI2tS5GPE1nBkVrZjNQCfAyYsKR9f0Fjg/5FFI/
	9vEwifb9CYqpDVZwtXlZ59axPAMw3aMCC8Xj6hadat/w30DEk5w8AOQP17WeJeQ8UjrBDBfjqVE
	pHzM2d831Jls+9oGwxdeSAi0ju5ZDMAMGh7/2aqT9cWliClqCDRUBH1Y6uu91iSOBXNUX0qwOsC
	Gw1os6yhslfX44j/pUSdoRDjHI9SjnoF7T16qLVs5dd02i7YI4ZKYqJz0tt9KGIg==
X-Received: by 2002:a05:6a00:498b:b0:82d:24f:2509 with SMTP id d2e1a72fcca58-82f8c7eee48mr7889000b3a.1.1776668126451;
        Sun, 19 Apr 2026 23:55:26 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:21f5:5215:464d:5ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec24850sm9845853b3a.60.2026.04.19.23.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:55:26 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 sched_ext/for-7.2] sched_ext: Documentation: clarify arena-backed doubly-linked lists in scx_qmap
Date: Mon, 20 Apr 2026 14:54:44 +0800
Message-ID: <20260420065520.383127-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update scx_qmap description to reflect arena-backed doubly-linked
lists with per-queue bpf_res_spin_lock.

Also update scx_qmap.bpf.c to reflect switch from PIDs to TIDs.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- Clarify scx_qmap uses arena-backed doubly-linked lists with per-queue
  bpf_res_spin_lock. (Tejun Heo)
- Update scx_qmap.bpf.c comment to TID-based queueing.
- Link to v1:
  https://lore.kernel.org/r/20260418120058.1555036-1-yphbchou0911@gmail.com/

 Documentation/scheduler/sched-ext.rst | 2 +-
 tools/sched_ext/README.md             | 6 +++---
 tools/sched_ext/scx_qmap.bpf.c        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 03d595d178ea..aa030fc1a59a 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -503,7 +503,7 @@ Where to Look
     custom DSQ.
 
   * ``scx_qmap[.bpf].c``: A multi-level FIFO scheduler supporting five
-    levels of priority implemented with ``BPF_MAP_TYPE_QUEUE``.
+    levels of priority implemented with arena-backed doubly-linked lists.
 
   * ``scx_central[.bpf].c``: A central FIFO scheduler where all scheduling
     decisions are made on one CPU, demonstrating ``LOCAL_ON`` dispatching,
diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
index 6e282bce453c..0ee5a3d997e5 100644
--- a/tools/sched_ext/README.md
+++ b/tools/sched_ext/README.md
@@ -168,9 +168,9 @@ well on single-socket systems with a unified L3 cache.
 
 Another simple, yet slightly more complex scheduler that provides an example of
 a basic weighted FIFO queuing policy. It also provides examples of some common
-useful BPF features, such as sleepable per-task storage allocation in the
-`ops.prep_enable()` callback, and using the `BPF_MAP_TYPE_QUEUE` map type to
-enqueue tasks. It also illustrates how core-sched support could be implemented.
+useful BPF features, such as arena-backed doubly-linked lists threaded through
+per-task context and `bpf_res_spin_lock` for per-queue synchronization. It also
+illustrates how core-sched support could be implemented.
 
 ## scx_central
 
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 2f4c45f6544d..a73a2dcbaeb7 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -10,7 +10,7 @@
  *
  * This scheduler demonstrates:
  *
- * - BPF-side queueing using PIDs.
+ * - BPF-side queueing using TIDs.
  * - BPF arena for scheduler state.
  * - Core-sched support.
  *
-- 
2.48.1

