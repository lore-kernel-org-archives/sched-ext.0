Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926219F130
	for <sched-ext@lists.linux.dev>; Mon, 30 Jun 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309256; cv=none; b=RNKtxYtDRvH18zh4/S9bmSNuCWF/d1PHGV42veRMQiZrkt05W32wqYILCSkQJnz7+W365B+hsKDLuTzHajMIq0C8AhQx5bZBfRHlZMFvFVXhu/48JfKyUzBqS5sq+bZ5gFbOt8ogW2UNwq7OHzzOqK00oS+6hU5DmQ0d0QgC0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309256; c=relaxed/simple;
	bh=9cK6Eq4nefv/GghvD5HJZDoT7MsabKRb3dFtA7O/Kv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juCwbFZZzQN9C0kaBSv9o3j2MITSGePp6KAbFEqht2AppE/4JQ7PtovSfmFXp14Tshm436YwMqkuyhjCfb1TT/FVyfloKurD9Xw+MctxHhvbXlUkT0s05cjiDQfpbMeWVuTv6CZN+uXKXMICiFPrnVYK8nA1LvCqgIbCqY79d58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPioV14o; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPioV14o"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a522224582so2509409f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 30 Jun 2025 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751309253; x=1751914053; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWCDZE0FTIR1xBnsspCUs5W2BaZP5zicVS/tsUtWrIE=;
        b=BPioV14oYubgP7BgrvKmD6ueMrjkntHXvdamjpuUTewRhCBF1BHbEX7VEDBlrmqqP7
         rw8cMU+7QR2MXtTDE/Cw0boJlEBKaP6zvWIySITkttq/jW5WyGTSunNfzI9OR0hYwjW6
         q1TjeS/7zhpEnWwjR6P5mbgynGZsDeJNrlZzkT6ThZJhvMahdg5vuXRK/9Hr+IOX+ex5
         z3TN0FgQjTnMRE8wD94RJNeRGr3AKo0bAVi73C8HWE/xdBYlRJoTPfu/q2jX4Kol78St
         o/R1cZQbkiFLEyn0JXKLqVrJisJcFhd9jVTYTQyyhYpYB5E3L/gNFPCwolK1bYZO3d+L
         KYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309253; x=1751914053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWCDZE0FTIR1xBnsspCUs5W2BaZP5zicVS/tsUtWrIE=;
        b=NBGIu7U8VqRaUI4rLluqmdIe4ZiF6sDzg7NftxbcvvZjFQdIWZE5N0I6khNqZus6Ar
         J//8iTfVaJHYOJ2WK0MIiWaqO+LGi+9BMmKrswjtC2PAewZJjoaALAvnNHFB/hhFTRaa
         /qh1H75UAMQjEywZbWALMeRbN25aiGoQGxByn9N6SHdZziW6KwWY1A18DSk77EeVcGX9
         xt3Qqt8WgANYlmYayYvcENiOSWXcj5JrMDLBFHu5kZCMuTzbRXyI8Wm7qf3IZRCR4xPI
         uFisjUHdQxQ5BrR35gH9SBONIMeMagW2y4JX6XN+H3EfYsbf/uCtOnp54OERh2N9pcbr
         vbqg==
X-Forwarded-Encrypted: i=1; AJvYcCUgmrAHzLhsJkaE8whUP1dqw6rSEbe1pk5LAOaILyuJIoSBI0hiZk0C4bXlRlE73GpOqcn8VeDsy0U=@lists.linux.dev
X-Gm-Message-State: AOJu0YzB85+vbwA0wp4sAUka2OvB5YHJfyiI1UzGStk/kFuad/rZMGiP
	uwLowjxuWUldT+MnziO7qiDm5TqTzHYGL5cQy05HJ6sIB9PMHVZXt6Nx
X-Gm-Gg: ASbGnctrNAnXlRSQadCsB+ynaqqvsYWQMkvlH4TaM7vRiFDL4JYC0C5diLHscbaRIuA
	eR4negxjozYAoH5tdw+xICDM8qWOzlTs4i0PAf24JOb+VibsYw6hSruXrDCcAWOlvhSc2GYLvst
	S1zofTPcZ0VbqpiLFY5/2U0LBKzlJHKedYj1sVDjO/dG2bCJPTx1o8LoFmr5R3doSwJW86C0TFV
	c7xv0WHaRdQoGzLA9EORi8W5osiseChUMIIcrqv7d+W5q2nIFbHF3xX2l/xHikm6B2ntBjl+h0e
	dDx79udd8MgXpnT8gfasQcvB8Bj+wP9hIhVer6zhfsW4OPBv30TyllQEYCwkB8UugZgwqbQrhoR
	AfSWfLw==
X-Google-Smtp-Source: AGHT+IFO2osZbMXuKWxvWyX9Foircyi48OTYoE9MHLpj0kcKgEMymDAzwhFfHneslieiNv0usMhi0w==
X-Received: by 2002:a05:6000:648:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3a8ffccac71mr11268712f8f.32.1751309253100;
        Mon, 30 Jun 2025 11:47:33 -0700 (PDT)
Received: from cachyos.customer.ask4.lan ([89.26.177.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa751sm205862f8f.25.2025.06.30.11.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:47:32 -0700 (PDT)
From: Marcos Garcia <magazo2005@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Marcos Garcia <magazo2005@gmail.com>
Subject: [PATCH sched/ext v2] sched/ext: Implement cgroup idle state notification
Date: Mon, 30 Jun 2025 20:47:09 +0200
Message-ID: <20250630184709.3831581-1-magazo2005@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add scx_group_set_idle() to notify BPF schedulers when task groups become
idle or active. This enables schedulers to:
- Optimize resource allocation for inactive cgroups
- Implement power-saving policies
- Improve load balancing decisions

The implementation safely invokes the BPF scheduler's cgroup_set_idle
callback under RCU protection. The callback is optional - schedulers
not needing this notification can omit it.

Signed-off-by: Marcos Garcia <magazo2005@gmail.com>
---
 kernel/sched/ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba21..7cecc0ca700d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4258,7 +4258,13 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 void scx_group_set_idle(struct task_group *tg, bool idle)
 {
-	/* TODO: Implement ops->cgroup_set_idle() */
+	struct sched_ext_ops *ops;
+
+	rcu_read_lock();
+	ops = rcu_dereference(ext_ops);
+	if (ops && ops->cgroup_set_idle)
+		ops->cgroup_set_idle(tg, idle);
+	rcu_read_unlock();
 }
 
 static void scx_cgroup_lock(void)
-- 
2.50.0

