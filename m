Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD21FBEBC
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548111; cv=none; b=NL9vc2DvDuolq/0Zm9ee1v1hztAQ4IqygrGYWNG+hGW0YG137G5KOKYh1ze4AdPrZIrrxzw7OoWkJQfp1MD2NCAZFrwo3lZ6r2Hkbe6nu8+4Hz2GR71foe732PZPJeBLbDX+R8YxCUQWVpCJY79DVsKVxaEEhFEFsFZyCpRuAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548111; c=relaxed/simple;
	bh=gYTvsgURl7shF+lIZ8z0Owg8p4eNrAvsnEK+m+NzaU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mw+ycxIIcJm9PWZ5OJbeOGFAUZh2GWWuB7RhdWAoLGnt8wQGjRvGLbXLPQJr6p335NpG1EAONTFk4Z9jjhDyui/tKbKzqKDidT6XAFpGaP/KCJEoZI1cLfujqkwDQabvld854B9r+cP/kXgM/A1y1vpnf1Lkhlo1+Q5JJART17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNqLRZoe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNqLRZoe"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b4650d5f5cso19084075ad.0
        for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 18:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778548109; x=1779152909; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aILpCgEqT0N8e2IAjrKER7y6CRdisH4VAq5ophgt1vk=;
        b=YNqLRZoerDA6jB6OfwummynkLo6h4nYuEt2SRJOKRC3dn+WSIdtSIGZyc9Echx5+h8
         JA9ofOlROoZT2YE3JHgiNiPNqO67bAZT292OQRMe4RKNZKLhwACfo0jfMp0OJb4sa4qn
         fSL47fz5Iy/fbtD1snfN5qEcF8hH4dv4tr/Mu06RBv292PptZo3vHUdVLJGQjiJSu3Wa
         TSc7MQtVRzerBhwKNsVxnMeAGpfA1Ak13a9st0KfnGm8uNe4Pz97UMq3Hmfz49KtoI6D
         U9tHeMNCbcgTfG5C+SayI+ricgd7YqvLgyG61AIMiHYAKiCSl0denNPEAlN8L9hnFXP5
         IBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548109; x=1779152909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aILpCgEqT0N8e2IAjrKER7y6CRdisH4VAq5ophgt1vk=;
        b=C5tOUJX1oSDgucyJ+HIRKNCXnyJunYIuZe0IbGnJHciMzlwYiMIEISWcwWzdng6/Bb
         kn/QRcwdi1Mx6IdLUoFOWaqVI9FeQQxyvE6iaNvbSVfg9+Izvdy9o1372G6xbLlOU7+7
         SDfAC+n4xufrkHkLoGYrjnGZgNbRX9ruAdfLzxFLq6WhokTB2Ylm0UW46iXP/gP60Tpn
         jK/e9Ztt+hQVMzo3XNPEE6ZOyIqHU3mAcbpFHRTvGEk3qdYzSp6B2+3xbfulpiZzdpVR
         ocNaDVk9+uzUYEvuv2aLiuYxBAT9V2E2ZtqN8OCyh4HPzNbSJhJ1eJQTqiMzvI5gyHhF
         9WGA==
X-Gm-Message-State: AOJu0Yzrs5CbRheuKFjlS+83wTqnIh5oPI39Yvi0lvWPcKxgzRZrPV9X
	kXod1TxH0kzLzr37rx452LEQr8TG7Y1GLlaOjsYXIfnmAk9u19Y0l6/3ZAVXBRRV
X-Gm-Gg: Acq92OGoJ6viT9SZfaqCe8vH3mSp5jzfUWi+JPg6JTyCtEh2LmKRff94DclQMxXZP28
	c3kctwf+HucRUiDj8m55PeQKNmxbEOWB8x+Y5wWzp7wrqoT5X5J/ffx8fiaBFj13IxiE14stlk/
	vw2SFNrzgAZ9/WGC9bW9PTRdbWstlexMWBGBfE2FYXmup12MrgtD8QScr+en2C59k+Bpy8qAzxs
	a7C6j2cjMDa7FKFSpUJRJLXGJjVJsTs1PfeWiEcAseuEdn88PI+xtIXG7TZCyJljb6/jY0jk9tf
	ktz+njjRMLsSLx+Qdnw1iqokpcE+7LdMk6nOppo1hqdJaY2UnG9ckDJ2vZLgcZISyYl2bAR1OkA
	6ncd9/oUJK0KbkP68P0MO+2YfU4SkDfWEVhXC2bi6F8qtnwQ24QcYsuTLnHxtO9Sda+PSkJuOIS
	MjXAmddgPba9R6Rs44P8ZClieUvlR4PdUHboeabDPsxZf90tz2yuMDq4neFJqXw6emm6v/Df91E
	iQo0FQ1sH9x1wCWkGv7RsKGv91boEMRJ0c=
X-Received: by 2002:a17:903:2f0d:b0:2bc:c089:ff10 with SMTP id d9443c01a7336-2bcc08a1233mr71808135ad.34.1778548109392;
        Mon, 11 May 2026 18:08:29 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d40a65sm116438545ad.20.2026.05.11.18.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:08:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: sched-ext@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH] sched/ext: Use flexible array for exit backtraces
Date: Mon, 11 May 2026 18:08:11 -0700
Message-ID: <20260512010811.40754-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the fixed-size exit backtrace buffer in the sched_ext exit info
allocation instead of allocating it separately.

This ties the backtrace buffer lifetime directly to the exit info object
and removes a separate allocation failure path.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/sched/ext.c          | 6 ++----
 kernel/sched/ext_internal.h | 8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1d7f206941f0..f8d18406cfa6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5628,7 +5628,6 @@ static void free_exit_info(struct scx_exit_info *ei)
 {
 	kvfree(ei->dump);
 	kfree(ei->msg);
-	kfree(ei->bt);
 	kfree(ei);
 }
 
@@ -5636,16 +5635,15 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
 {
 	struct scx_exit_info *ei;
 
-	ei = kzalloc_obj(*ei);
+	ei = kzalloc_flex(*ei, bt, SCX_EXIT_BT_LEN);
 	if (!ei)
 		return NULL;
 
 	ei->exit_cpu = -1;
-	ei->bt = kzalloc_objs(ei->bt[0], SCX_EXIT_BT_LEN);
 	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
 	ei->dump = kvzalloc(exit_dump_len, GFP_KERNEL);
 
-	if (!ei->bt || !ei->msg || !ei->dump) {
+	if (!ei->msg || !ei->dump) {
 		free_exit_info(ei);
 		return NULL;
 	}
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 0ed79bd891c7..9fde7f1eee01 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -80,15 +80,15 @@ struct scx_exit_info {
 	/* textual representation of the above */
 	const char		*reason;
 
-	/* backtrace if exiting due to an error */
-	unsigned long		*bt;
-	u32			bt_len;
-
 	/* informational message */
 	char			*msg;
 
 	/* debug dump */
 	char			*dump;
+
+	/* backtrace if exiting due to an error */
+	u32			bt_len;
+	unsigned long		bt[];
 };
 
 /* sched_ext_ops.flags */
-- 
2.54.0

