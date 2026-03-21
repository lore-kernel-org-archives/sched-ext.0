Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1992550AF
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090514; cv=none; b=NYt6rC5cnWehpCsH0IfZeln6a/GxcbiJG/p5cbT7/ED2p+DfE6AX+sFIikfYvHLEsUnWYu3Y+uimpsYMg+CEiZ1WwAP58zx3Zx3t1C2t1rq0avEC4yLi1918Eq4ooomxk+rDkzRYojAI0bP4eZcMN2UUMJVZAHvR1/SBvozwQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090514; c=relaxed/simple;
	bh=aLZuQKnLmqPUXntnv2NiDfp0MxmpEigOhcvZ9Nwjf8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuoagrH4CjodGhBD9mPBfKL/+Oi1UGYeH8h1E7al5f9z5INyCTM7QG5jRUYr+j6wXpNwQ8Uw7jEmTPZfwgIJTDVUkhJX7zWOQ91cC2HCjxi42zv+BHwzTml7UK0oXsUZ6ohOFLdRg34C4oqRJN0QKCOj57S8ge+dueVE0jsA3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dqofw2/7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqofw2/7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82c2239140aso403077b3a.0
        for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774090512; x=1774695312; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFbZX0gdDexqfDtd31d7tHXY6GB/Rp2CE0kt6mwya08=;
        b=Dqofw2/7TjhwpyphDQRYmPRiwofPn0CyJe3G/uwjSzU47sLLdZ5Cy3NTRp8lJta2t0
         oRQ+uVr6K84ycMbgbPc61qk0mRLVI/SOqJPx/4YkDBMX2rUogyLkDlGBWgXFUp/H66FC
         QeNlB3uTfMyiYTC/sW9EwmwSWP4HaDEhrU0+ClBsdeNcP18jgXipdYKkBTn93tyq00zI
         vjDaieHYPqsvCnkt9NJBCxftjduD1+I4NAAmR8AU3tv1LJ1PJmv6gfNOhipdMW2Y2k2E
         W9os8ThXyxMHZx/zle8B0gRHifuPVvsI77M5LUvA/nAsdj7lUfspxA4pJI+iPz/30h91
         UTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774090512; x=1774695312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFbZX0gdDexqfDtd31d7tHXY6GB/Rp2CE0kt6mwya08=;
        b=eIBZluc7nSw4chrtIIrag4ZMc5XI/e4S3kfHKkcqzWegWgpxkmIDL4wtvGAB8ctF7G
         IocQz/jQxtBVbDn4iu5N4QoM9ggMgX7liTfqky4CXHxPhdGzG4NHG5z2W37BYd44ayQb
         pQF6fEtq8PiQgf4q7h2L4NNQnWgoCyyQYlYbgl7H3IZ2pDTnbyz2HVmdTMP5jBTJ7lLB
         VUfHz8fNVOO2KKRr4knMssvemVJ3/CcGGnYdEgnDC7MGI7JHXEBcwLj+0xM09flzH8ud
         Ck2N5+8k0nwTN/WeDxriqBj4XSZ+mEKGu9Ek+eS5Akiwrqt2vZTU/I+WSypF5y1uJsV0
         0D6A==
X-Gm-Message-State: AOJu0YxODa9WxS48VRBmr1xbobuqMUeFtOC0Pw7ibyIGN6pi8Zhea0La
	E7iM/UhhvH8iiDxnhAp5UUVle3x/t4aCx04s9zLGhed1qWYatxhQEp+exYvffg==
X-Gm-Gg: ATEYQzy2rPp6x8QqalXQ3xhT2ve40I9VaaEGWNTdKl5RDr1DZ1YjgNiOGN8tUHaR2IK
	IIdc+oNtwpdgv3Et6JRU6nbqOp/ePAVhbDL6CvSTYxSeJhbYEq8i1lGEm5HxFRVeF4vIOc489+s
	C+ODE2hQtxmiIjk4Bd8t75mdCJsipXSteOUaK/2SNhTmBJBIdpIjCvp+fm8Gw+RHWQHiqLVXkEW
	6xi6M9JoElgsM0jGFPvuRKgJ8KhEJrpnRU5oH5UhwFlQtGg7x2zMUieNhPX9mmNiYn+e33v3iQf
	boxr1OLiP2NhRhrZjUcloJ12SeEGWQsYcLl1Vg7/TwuHn5l6Ni60X1PiM/9YuK0Gks3OdSpaXIq
	N4jrG7Z9usJBLEaacVmSLwwJhVfYam72iMZt/0vZgRQoTGCcDXBD2MqYXoKFJjAd/FeXXShc0Hi
	xsZ/5GwM93EBktnaRr+aCzd+WYaXt7QN4AeIfbk/QxA+WJTltxvjzF
X-Received: by 2002:a05:6a00:b42:b0:827:441a:c970 with SMTP id d2e1a72fcca58-82a8c240b3cmr5192827b3a.6.1774090512244;
        Sat, 21 Mar 2026 03:55:12 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:ccd0:c749:3565:422c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040dacd5sm4648824b3a.42.2026.03.21.03.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 03:55:11 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Fix inconsistent NUMA node lookup in scx_select_cpu_dfl()
Date: Sat, 21 Mar 2026 18:54:58 +0800
Message-ID: <20260321105503.869337-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the WAKE_SYNC path of scx_select_cpu_dfl(), waker_node was computed
with cpu_to_node(), while node (for prev_cpu) was computed with
scx_cpu_node_if_enabled(). When scx_builtin_idle_per_node is disabled,
node is NUMA_NO_NODE but waker_node would be the actual NUMA node,
causing two issues:

1. The (waker_node == node) check always fails when SCX_PICK_IDLE_IN_NODE
   is set, preventing the waker CPU optimization from ever triggering.
2. idle_cpumask(waker_node) is called with a real node ID even though
   per-node idle tracking is disabled, resulting in undefined behavior.

Fix by using scx_cpu_node_if_enabled() for waker_node as well, ensuring
both variables are computed consistently.

Fixes: 48849271e6611 ("sched_ext: idle: Per-node idle cpumasks")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index c7e405262697..8436c7df0a56 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -543,7 +543,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		waker_node = cpu_to_node(cpu);
+		waker_node = scx_cpu_node_if_enabled(cpu);
 		if (!(current->flags & PF_EXITING) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
-- 
2.48.1

