Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD527EFFA
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232416; cv=none; b=ffP1MVl1tbOocRtGRLaoXrEgwpnNmM0IR21BdBgIRTLwMorHW8UzRMOeDOcB1D9QOD3KZ0QfrSwYQ1w5vODSrdDajtCd4bWoFTJT+40qfsN0w3IbSK2cRTQA0/okh4lE7GmCWorYL3stC7sWMLa6Uf3cn1oZtL45JiUfxvC96Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232416; c=relaxed/simple;
	bh=q22kPQbkbl9glB0Q9IYvIKJGYNX+f4GuDcD28/tfsnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXTjd0nQ/vIQujCYXUcFDjCU6q2G9cIe7Q241CLjb2ucVflhGL0p/Tyc7Yj9dMnDvCcKQbTj7M0csbLTzTnS1Ikl57nxmi3sDLFg5uew+CYcKqNeO2iYAh8tC+UuhhO2kxn8ka7aZW4A+TM6JbRVC25yDETFmxqKhVrMQ7UcQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzrau5eQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzrau5eQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae8177446fso39166515ad.0
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773232415; x=1773837215; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYEAXJDWi4qvPhZ+2v0WN8aw6qWVkvNP2VKc8xftcoc=;
        b=Yzrau5eQn7dID0AKcwji1tu2rmjjwddoXodZy39XF8TavZoLtDKJpA57IecrNmbjFh
         Vh4o0GRgzyu/JscmVt7FFn36kTd+YBgUG39r2n28Y4MBgjijJGEAA/WP8I1vgfVMMZ/X
         +lKUA0KaIMLPnrJzwmarZxfJE0i3/1rDmjf6q8bTQb0wfj+/hX0kUy/8tr57bOVaOOAh
         BFNOYMmxFkoYN+ZIwhVFGIWx9pUV4DfjNUqVjxGeE0IlDxWEQQUQah3Vfb0UquIu0YFG
         ISuCWQgl7g0Hcuxplq8VcSW2OKPcXRVdEhPc5kpqotWh91hf/5LrEDihOXDOvl18/Ran
         3Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232415; x=1773837215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYEAXJDWi4qvPhZ+2v0WN8aw6qWVkvNP2VKc8xftcoc=;
        b=P4KDVPNNuyNBfZivGEW2hlcNb0isx62kpujXMPD6fmSJ1JkmQ0P8kgxHa7EPHbr13d
         bbEUWiN5Ua9RnYlkSuWeub0W+ILpF6TV5YsVSFvDUrUs7EzZCeFyr1KkUIbqjKrrb03V
         kVLjgyOdrxOrPtEO0DVhfViihmzKWf6IFoxnDxFH+IYJ7unHbjahzKSdPh6i7uUaClJr
         oKxob0MqgBGe0Wng86w1ffyq3iGOnm8fXX/UoSY2aq8eyoj8OJtm32Vzut/ktu+YuKQU
         dJLfNmLx6IoUrp9Th/SoOSuaqJc4txhLLwWjZNaJ6I9oHsHZI5kX4ikmmulGUmN7yhHz
         OgfA==
X-Gm-Message-State: AOJu0YzYvVWIoerkIpS7p6P2ItQFx12yY4Hk+S4r6+kb68/rjVwgPh20
	QV3bVqZ6zosKWruzn04oMqUcL8mT7VZx3NvjMzFHWtMfUa93wKmYA7zJoqg4PTJl
X-Gm-Gg: ATEYQzzQ6NZkhXv4y/mCTpc3KVYkVh4orOUMfmCCbHRwWnQEN0rruu+VC087HH7Q4k4
	V6gV9dCD4MppR5Yj5+ir18zaOXOQot8DFU2jK6BqkTLkstBw18xzR/rPD9OHdg0cIPH/HsNkHbG
	l52A3AR+S9mMkmCMEZqRZ/P79pds27DWWPqs2cEv9Q01sJkmKmCLZwWoaxCW/sIUfzwkLqM3Hnw
	N8jGZTsJN5xdHnMw4hQhgia4uPmVFfAfF5lN9h00BE5CCA6DYRLAGFF+RGKY38VOTYo7Ym5+zdv
	oS2nHIUp7KWMKQi4XmJUQJqqsXZeXAluYLiO4sDiiTqhwI4xEeH4wjMZHBKqYxi4bgg0H6ICa0g
	J/vYdTAd/yBQ2gZ3/h38fq683A9B6vT5hCeBjNvdUDy9oaQe/URp9FxJWExOdMsqBq706Aklwvh
	w04cH2xQzQK3gc7buBCtv5ed5J9hdV5wkDyaE5qfZnDgNZgZsju2wH
X-Received: by 2002:a17:903:2b0c:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2aeae7d0754mr21695675ad.22.1773232414810;
        Wed, 11 Mar 2026 05:33:34 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c33f:dccb:5456:7509])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae3625b8sm23405045ad.64.2026.03.11.05.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:33:34 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] sched_ext: Fix inconsistent indenting in scx_enable()
Date: Wed, 11 Mar 2026 20:33:27 +0800
Message-ID: <20260311123327.688263-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_EXT_SUB_SCHED is disabled, the #ifdef block in
scx_enable() splits an if/else statement. This leaves the fallback
kthread_init_work() with an extra indentation level, triggering an
inconsistent indenting warning from smatch.

Fix this by adding an explicit #else branch, keeping macro boundaries
clean and proper indentation across all configs.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603111617.MkdRE7g9-lkp@intel.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e7ab3647e35f..21cbefb4ecb8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6914,8 +6914,10 @@ static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ops->sub_cgroup_id > 1)
 		kthread_init_work(&cmd.work, scx_sub_enable_workfn);
 	else
-#endif	/* CONFIG_EXT_SUB_SCHED */
 		kthread_init_work(&cmd.work, scx_root_enable_workfn);
+#else
+	kthread_init_work(&cmd.work, scx_root_enable_workfn);
+#endif  /* CONFIG_EXT_SUB_SCHED */
 	cmd.ops = ops;
 
 	kthread_queue_work(READ_ONCE(helper), &cmd.work);
-- 
2.48.1

