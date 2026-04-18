Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10782303CA0
	for <sched-ext@lists.linux.dev>; Sat, 18 Apr 2026 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776513703; cv=none; b=C1MrUhJjDbv4R0epNuaDwyrIiLghmyaxsQCzyyBQL+IXr04KQTGjdpIAN1QW7rVj+0SAKB1SECumWBhVyQIdy5QmcdjOe/ytvSfmyzlQPgDdEjSa9jTzw5q6242b3b4fcYCAIN7LMABubauVygIX4EkX4dKqnQKLeVT118s79U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776513703; c=relaxed/simple;
	bh=FuPrqgvsZ7JXlkRS1jHTzyJjpzJUBhoOOJGUjHLFTFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hknUUT3I4dBL7NSxIH9QO2lA3OPXC+GolX7qbC9eBI1Po9Rc0HfMA/iDQ5mFXNaewMxRWXNGFhwjmn6qvL4rX9h1xRUdLLPIIg7A5dgck9fbJRzK3St8axS9tI8FYS16EVtkVxiOcR+XNex/C1yluiFR5kNHaTULKcDcPisYWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQHzuG/D; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQHzuG/D"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so1631819a91.3
        for <sched-ext@lists.linux.dev>; Sat, 18 Apr 2026 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776513701; x=1777118501; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqehVZJXJ8gQu4Y2nxqHasYLRV6dErXpifqhpY32KUk=;
        b=TQHzuG/DPFPNouuSkHyOBJjxVOdpsdixC3Gq8/mveIWODNiv5oxgFKSWfslkImAnvd
         gO8GHPoR6TJwzou/Qeso9xR6ilrKA/4KTllnhdQbxWP/4RAb9P31ShsDH0uJZYdjFivt
         f2ASKTNk+lnfwmvqSd8WtZv6UQfP9GV51/suQMFynPOjQ1td8CoY1fWrUYkYVO8KLhG3
         +zvPhq3n5oCZd3/9VabC89iuxxJOElQUJxXSeTr93f5SP18lERH23iqfBfwBizNIb4j7
         Be3dTKxjczqErZjOA47u6QWxtm3xHwJ2t5CtPmP6gkv6JSYI4fQ5mcHGOCaDD/mpkkKs
         VOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776513701; x=1777118501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqehVZJXJ8gQu4Y2nxqHasYLRV6dErXpifqhpY32KUk=;
        b=c26IOrbu9lCVa+Xipsv6u0FWlhPXJkxNIggsjs9NkmSoToSwtPpPWF6FLsoQI39jSb
         p0TeXYda+LHrwyhVvAQaECfa359zpf13WG2cGMOkW7X5qBqff9zzznOOA0zPBuUl6auo
         /DsXrFgOK9b04ZUSx38K2cZGJ7e5vuaLwZUw7S0KAvziBDJJPBnQwDi6LS/YbWabBYvb
         MNRYVdwXR6WtBJEQ4+sCRFzcKGMmceLGgO27dnr25LnI8YkKzx5sgAsTkSRpkPmqWy4F
         ZvjPxTrDGq7ZuVEEb7WXRj401ATOWBpzG7BSmuSlOHrWac7E7F4QRUvveToZ9oXLpEDP
         pZ5w==
X-Gm-Message-State: AOJu0YwwyertSAATHTRVp8OOBTFhZhf3ZMoJ5KeRSXcDRu/JeFXl7rdL
	gFOq+1eP2RQc0mXajXXYsjMcMDJmgctRjosBlbud4xE2+hxTHmAY2sPNY+Q4wv+M
X-Gm-Gg: AeBDietNT9sAR+GDpV8NctKcGDZuDfx7s+60oGk6wf5fGSHXXdf2/i48SHYv2WY3+GM
	ud08QGAd8BQ+t69fwUVZAswmnL9fXsfncHXVcS48j03GOCoHUbs/FjJAj3O7nPJ+ImRYj6YlO6A
	dWrmmNXiQrx0NLoMlyYHEqgswspMu+qYsuqvDgHT0ACtgDye80c4OcNr38AnsJzL/Ck/1axfW8B
	LYN9d8lMald68dDHSqooTzRcBidE27dMLZu5t9ZPrOQT3+Ahy+AoekKFUCNcoDG7/e/kxHgHJMm
	FhW77NOjdDpxm3BUvCkG9r4hBqGBkRQcP9W665Jd6XIZeEC4PyMT7g3qzxL9CLhcov4Rh6Indib
	VQB9BBq7pxAD1Ukz//QDiqAQz9T6OGsuQRGTbS7BmuR4ugDCgjBA4Ue+KVdqR5EO57OXOu5L/40
	oxISx/Uu0/cuHyeueNvwir5AYyvM9qkrzj2m+87hxPw7SMLmLI0amRqppw70LTzh0=
X-Received: by 2002:a17:903:2783:b0:2b2:4a9a:b168 with SMTP id d9443c01a7336-2b5f9e80db8mr49023885ad.11.1776513700807;
        Sat, 18 Apr 2026 05:01:40 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:cfeb:f4bc:c0de:5763])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff8d6sm45953945ad.1.2026.04.18.05.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 05:01:40 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.2] sched_ext: Documentation: update scx_qmap description for BPF arena
Date: Sat, 18 Apr 2026 20:00:34 +0800
Message-ID: <20260418120058.1555036-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update scx_qmap documentation to reflect the switch from
BPF_MAP_TYPE_QUEUE to BPF_MAP_TYPE_ARENA.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 Documentation/scheduler/sched-ext.rst | 2 +-
 tools/sched_ext/README.md             | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 03d595d178ea..ebe3b74094e8 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -503,7 +503,7 @@ Where to Look
     custom DSQ.
 
   * ``scx_qmap[.bpf].c``: A multi-level FIFO scheduler supporting five
-    levels of priority implemented with ``BPF_MAP_TYPE_QUEUE``.
+    levels of priority implemented with ``BPF_MAP_TYPE_ARENA``.
 
   * ``scx_central[.bpf].c``: A central FIFO scheduler where all scheduling
     decisions are made on one CPU, demonstrating ``LOCAL_ON`` dispatching,
diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
index 6e282bce453c..9ab25ca7a02c 100644
--- a/tools/sched_ext/README.md
+++ b/tools/sched_ext/README.md
@@ -168,9 +168,9 @@ well on single-socket systems with a unified L3 cache.
 
 Another simple, yet slightly more complex scheduler that provides an example of
 a basic weighted FIFO queuing policy. It also provides examples of some common
-useful BPF features, such as sleepable per-task storage allocation in the
-`ops.prep_enable()` callback, and using the `BPF_MAP_TYPE_QUEUE` map type to
-enqueue tasks. It also illustrates how core-sched support could be implemented.
+useful BPF features, such as `BPF_MAP_TYPE_ARENA` for scheduler state and
+synchronization with `bpf_res_spin_lock`. It also illustrates how core-sched
+support could be implemented.
 
 ## scx_central
 
-- 
2.48.1

