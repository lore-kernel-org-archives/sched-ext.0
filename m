Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF203AE188
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805822; cv=none; b=uGfyQqEx87GS/qkHUc/ZQWiPP6SC0xLZbWpguBrl9evfw7wQFkOVU8suV9Utjz+chDzH6GxPn9lJZKDwHi4H9d35jmqTTJ1oJ93kKlgfyGrj2RObZ7obw3HIVWQ3ZVRRv7nJOVW3TSPzmbqA4Af8EsYwYsXdkIgV5RFMgxNfK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805822; c=relaxed/simple;
	bh=ELlzxJVqqauBzRnx2M/V3kWxTpAmlO4Sa9vwg7vpvVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIiwyrrzt3IJBHJuCud4G2DCX766lC8SKPHjBycu5A04dYZV1FWFtVs4/cFnUwTOkm6uX+UdOyk0hEPcYra37+pHUxaXEA7lTt7LwSIE3imOvb08U9x36MA2DUCk/eqU+c4iRp3anS7fiTTM4yfOnwtdT2rAE54XTXG00ualZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxwyZQaK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxwyZQaK"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso26241175ad.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 06:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772805821; x=1773410621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEmGv2FLRFuslu4qBQwLsjeV3m7Edv0VCgYCAY8R+hU=;
        b=mxwyZQaK/mYrzf0YEDuX7CQAxb4S+LNAZG5RUrt6DEeYrPQTlIkmMIHuxLvRWfIWuT
         l40xekUYxafrVQEQ26xvxw2zmSMnKa/XWn7NEWDzDmAr7ghsgS9kvxKfkApYS3oXQYjM
         Z276d717PVl8u6aJ2QxZ/f1OgDdxIK6Jdwk0Fl2zKl2RbPE5JvuHsip5NenkaWjkoAc3
         SvMiyOtM+T/6CEdmt7ypj3JOzuUj743En6ZbfZsGt9lpmCTcyUBFWt0dVIq7ENf820qq
         ZqO7IMjI5qU8MSHrWDMDOuLj5LOW+wv3j9bEqxpC1zMnq4KlRD9yWiwci5ZshBo8t33E
         Gv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805821; x=1773410621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lEmGv2FLRFuslu4qBQwLsjeV3m7Edv0VCgYCAY8R+hU=;
        b=hPBX3uAckjASY8eBHSsZrnWriQ/vYf8C5Zy14oO8ESwFSgD/plXMQpMUHZSsTGnFar
         OdRPk65BbRmsPJ6y7vSR3sEuz+J7sOc8cWKYuY07IqEN/6U6SRbeufhrfRMLGwgEo7Ui
         zow893rEcRdUjNj6GgAcLtODPwHyk1EGoQJ13xD/X8C7vOC0yn1yFzKB9uh8ee3oGSgY
         1vBkXWRwoEvalFeAS1PqVRzpyUEZ/Al3TOmfrvXgZoRYVbkWOWf/UJ+iThpz/nw1kpkK
         QV6BhQlfsl0WJEvtmqYX6UPwtPEO1GO/6DTbTbAG2ugzpc+FFgebOrGfXngcExsEf49U
         wdPA==
X-Forwarded-Encrypted: i=1; AJvYcCVf6dK4YBQgbM6nCh1PpUTkgZlWEBmxZ3EkhvQwqRhP0tIinP8cvWCDA5ahV9NJ2A6uKW7nIs3BjF4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxIWGVBHlhAD9fWUM0YKDsipyDhYpQEBzgwy/ptKIhr8GZ541+z
	fcivhpGr4VYJNwrcuIuY0qtOMjDi1nXPkKwtM4fg2urVWgY2c/lvjlIH4PKd6FxT
X-Gm-Gg: ATEYQzziLVJBCaxZEv+wEasdPg7kWjD4Ssib3wGuB8IOQkux8SpNrcNmlfJPmdfBNFO
	HdtqXZOyP3Ei/Z+jamVpxjZKhlhwKwmBHnR6iY/lvuXC+S4+CJ1NJPsfUDyRoW1pBZ9Pctq9HQ9
	qzGleriRe7u7hf6169sb0aak5upB237DUu6qW6ADG/6hND2hyuB10oYEsRlt8JdhFnfiiCZyZSd
	IC0nAwqaiGK04sbUcRGYHuqMyB/teFo/90Zt85r/7yGq7K2exbITrKOjckPkjLTkLDoTmjLfGLe
	QA9plEaiDJw0EpjKd957tlBr2s0QXl2SoRyGI77FWNAqDxVTeNXmkMBx3a8+P4RVH5pI4t4ukhI
	iu3NCqu3m0VcN8zdK4PV7VHH/rAdSfkdyg0UAq9AX1Y45lkMnIelmpQWyk5bbf+9bOw6rHVTad1
	bAsEGesVkfIDG1lQM6lG2r+AY+fgPkbMZkto5Xi/11h5YglJJQ1OWbu+UjCn4kcoKTxZcgmbwYx
	sXheA0JBrUlwA==
X-Received: by 2002:a17:902:c94a:b0:2ae:41d1:344b with SMTP id d9443c01a7336-2ae82418016mr27067745ad.6.1772805821034;
        Fri, 06 Mar 2026 06:03:41 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm29134715ad.92.2026.03.06.06.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:03:40 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kselftest@vger.kernel.org,
	Su Zhidao <suzhidao@xiaomi.com>
Subject: [PATCH 3/5] sched_ext: Use rcu_dereference_bh() in scx_bypass_lb_timerfn()
Date: Fri,  6 Mar 2026 22:03:23 +0800
Message-ID: <20260306140325.2710927-4-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306140325.2710927-1-suzhidao@xiaomi.com>
References: <20260306140325.2710927-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Zhidao <suzhidao@xiaomi.com>

scx_bypass_lb_timerfn() runs in softirq (BH) context, so
rcu_dereference_bh() is the correct RCU accessor. The previous
rcu_dereference_all() suppresses all sparse warnings and masks
potential RCU context issues.

Add a comment noting this is a transitional state: when
multi-scheduler support lands, the bypass LB timer will become
per-scheduler and the global scx_root reference will be removed.

Signed-off-by: Su Zhidao <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 053d99c58802..c269e489902c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4170,7 +4170,13 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
 	int node;
 	u32 intv_us;
 
-	sch = rcu_dereference_all(scx_root);
+	/*
+	 * scx_bypass_lb_timer is a global timer that fires in softirq
+	 * context while bypass mode is active. Use rcu_dereference_bh()
+	 * matching the BH context. When multi-scheduler support lands,
+	 * this timer will become per-scheduler instance.
+	 */
+	sch = rcu_dereference_bh(scx_root);
 	if (unlikely(!sch) || !READ_ONCE(scx_bypass_depth))
 		return;
 
-- 
2.43.0

