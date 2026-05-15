Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445AC3DA7FC
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866100; cv=none; b=gCeAuJdsJ3p2NkeZJckTVdINxZhTkU2Q8fnOJLztgke4+anqJFYorYEzYmFlX4OvxIsaldxZNyokGLqwGvNir2FWhls5zYaTc4MNaPt6ofphHzg78xekKde6KRIuG+TBbSLfHCc6ApR4oxxKKTIwP6Vn3y/2Lx4OGqFLUjtnlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866100; c=relaxed/simple;
	bh=5FiyWVx0jGoEqmoqVBf1Q45K+Yx/9+Ro6PF42+G2agg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwBPLnCp6yI50jfEPIKNMyA3lkf9hEfb8Pa2NCw2h7Rd198pWOZ1kO+m+xJzgsyNYcaQKWh4yf0H92NKIIaJb907/4CKr3qVbfQzLbQiQGMl/s7+SXzQiGFZbLznyJdhRD3+LhWMWa+HYUAhB5e4dVscmIhrBAYXTBEfHXLKvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtL+keiS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtL+keiS"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so73059b3a.1
        for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866098; x=1779470898; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTTEuOyznvK2XUk2FnntOXQY99D7rLg8I3+aK0nkjdg=;
        b=VtL+keiSs4oP/RuqtyvWU9Qhr/n4iu6DrcxGDfKrJweGemEQllwtUuPGsP9m84YvAj
         DR70lmd1Fh7NAzXMVDw/MqvDKEvJYNZ1se1EGAYPyOIPwJOpMCslSWkDIOKV5qi5tOPo
         HPMf38Dj75cadRptEQYCSNe7PekT4TN3LdkshMzfVe5XzDkMneh9yeOQHoCzEQR7b1Sv
         lMTGAF3Xj4OczoiAwCoKMAG9HARq/HbIEZs8rArz0V92hPofo+RUUFMK2JxbHK6+unSe
         fWGgTJKN/ARIqULLm5L1nVIp1TdimQxvS+CfBQqNxAOzzjOpYUttbLIhNGyBKM0N1jsY
         iN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866098; x=1779470898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qTTEuOyznvK2XUk2FnntOXQY99D7rLg8I3+aK0nkjdg=;
        b=squLCBjUtKeyYUwrKHq+WLdp18xT50T+2GQ0S5dYWA4tjwEBC/tgkyqZg/VbDKrN4b
         ufIv1vPABGoJQqgN6hxSd4m1leD1bt/ZP/Ba3at0vJJa8xJSADZVnKrEpD/mhx7Y/YYc
         eratNo1krefEtNpWOk0qDe7IT9vDrcNZicLinkdhSi4sInelNQlF6n4QDs9PYkdBhVSw
         53rzta6ehe+Vj/0apa9KBJRxgy3uqQof1++e0a0Jo4FPbjLpjALXNHJ7noJnZ6t0M4sc
         3jMD4VGM6Pd5eoqb23806r5NZhrNo+nhjLNV68Ry6ExbFP6dwkZk0/kRxjZi3ofc6jqQ
         wb+A==
X-Gm-Message-State: AOJu0YxXu8r7nf8mINVnG8SDqiJj9vDT4Ju/nUFR/K+GAd35zFPqqwed
	h85jas+qRtwrGoFtD2C02DI7cxLVR1yS+SksRAhkxCds6XZn82t5708Bd4fJvw==
X-Gm-Gg: Acq92OHu1k1iT3+bGY86HjSzK0yZ1ygf0YDPXPK5KjHLcW8x9zEphrvYYjGjc9rKUZu
	ohq492cpLLo/8oQzSVJTS+v7cMFxcKbgn3ku1JFILuPgeSPwVPUueRJCgilY9ah3VKijF8CrDoB
	M8TLeXlaGd6SGOpSFp0JfFGTgYK6o3pOapu+qpSXdlsH1FIEs/29xtAKj2IDt6/0iCiUG9AtnD+
	Z24NjNtwb1cN77FVtvcE8g6PPVvYHykmiTLi+3TlXk6MCDqstL2iXxEzZ4RsFZPdb2ZYERdY9Gq
	I3S9IvSDGPLAfmIX+5Ykkz+8St+MTob6lWbQg1Cio/af1y8DeAQXtNFDk0DSWpfHtnaatLD5Uc3
	dG/ZwPcJPd2aglMREed4nVpndhHWdpabfgbgSA8l2sWChjPoqK1llCGCPvZvj64Ea2r+a9O63Tf
	suxz8WDxkzIMRf8zA6iPdlpXWxw4dYb7PnnrQy8iztoiSoXI7eo0tD3/JczbWcExw=
X-Received: by 2002:a05:6a00:2d19:b0:827:2a07:231d with SMTP id d2e1a72fcca58-83f33b31163mr5488438b3a.17.1778866097729;
        Fri, 15 May 2026 10:28:17 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:9584:f97f:cff9:ff7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b71fsm5973035b3a.29.2026.05.15.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:28:17 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 1/3] sched_ext: Rename scx_dsq_insert_commit() to scx_dsq_insert_stage()
Date: Sat, 16 May 2026 01:27:39 +0800
Message-ID: <20260515172807.254804-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260515172807.254804-1-yphbchou0911@gmail.com>
References: <20260515172807.254804-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the internal static helper to scx_dsq_insert_stage() to better
reflect its role: the function stages the task into a buffer before the
actual DSQ insertion, which happens later in finish_dispatch().

No functional change.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3ba3771ae02e..9e59b068f02c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8422,7 +8422,7 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 	return true;
 }
 
-static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
+static void scx_dsq_insert_stage(struct scx_sched *sch, struct task_struct *p,
 				  u64 dsq_id, u64 enq_flags)
 {
 	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
@@ -8508,7 +8508,7 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 	else
 		p->scx.slice = p->scx.slice ?: 1;
 
-	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
+	scx_dsq_insert_stage(sch, p, dsq_id, enq_flags);
 
 	return true;
 }
@@ -8536,7 +8536,7 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 
 	p->scx.dsq_vtime = vtime;
 
-	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+	scx_dsq_insert_stage(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
 
 	return true;
 }
-- 
2.48.1

