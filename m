Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9713A9619
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805818; cv=none; b=Lo7ldJxDS2lQwkYgzkSk8wyXt21yTuyqn3kAOyw1q8n9d6V17LeFg6c29bHFZScEFl0Z7bw742TVsMH9zRwXKZW11lCPzg57r1cMfLNh1tNrBFVEZQyBH2Ef24xpubbU9bmW9cXo6i32WQ6I6HKGu8wT2qlfx9KmTWbFK5Lmr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805818; c=relaxed/simple;
	bh=z3V40F0kGIL8yvCLdRRK98TbuZQ8stHEY3dTCT0ogJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lntCmWrP7BWC10+ORIQ65aM4I1bFzEbU/uQjzhDDxh8Wx/Umbsy7n4c1XKalJ4fZBpomXnc98lvVOBxLd+94JSQ6HAUr35DKF97XP//KNm5RCZb+cF6po5y34SZer/wem0YJO5fb1TmeV5IcXdyvoe+CznKY4c4/C1w/UbtWYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRRN8H8O; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRRN8H8O"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c739561f0d3so1108599a12.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 06:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772805816; x=1773410616; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZzuQXuKro+GXBxmmjg8yJdwWTDQZtX+cD1VaFXmUG0=;
        b=lRRN8H8OuGSbV5/8V75w6NUTRr5/8xpj7oE7KHuqIiXp9KbWUXzWvLacOKxRWXcbTw
         FCzWv0impmUcM4ChjLU/Ow+n/UoT3SIX6HoA/yovUFZPU/E9g7rhw4xYK73Obx3NwfEi
         YBSHeo21Rzo710fpc1tdbW1RU0X4tpMzvUcS345URwAkaKVjeXMxW6orJFKrlRJTp+4X
         h5qo1lq12vjpv5ijZ9pw25tkw8+yW4ZMvtXev6K8YRSk6cMvWs1ltB9GHvI38fZd2RcC
         ZKzXnqzAR4CIjuzkgUyY1rAkOVL1jj3Xchva3v+l06yfKSmemwZrk9f63ceD1rtOvNQc
         xjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805816; x=1773410616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ZzuQXuKro+GXBxmmjg8yJdwWTDQZtX+cD1VaFXmUG0=;
        b=hyngScBjAYCXQQWD+Sn9YDfPS651FPPn8pO/x4hIykayqy2nL70kvziFxrmjAN6Wvz
         6fK00sQT2038rljr/LK+0KAI5pvpOYVa6TogKp3oZ/n36MmOcuEJus1OiBN7VIEUxm4K
         zebdf5sCRmA13+y6bsoAiaQ4XLVZotCK04fqSbN2cm4Mi0AXCNHUokpPC3S5XFrCmIP4
         wfeqwa9EdpxOIXGaD2pFYPTM8aXAFH8bKGz7qKmO3qv7zti6m3TMIAaDSvGheNKhDSw8
         B9+wzNEPpR6m3mOavqG/veftraDE9avkokYyrskXYwq6zb7uQ43jmU+XfTJLDdT074Ds
         QfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkOIjOJrOC7+kQpknrsTcigya6Z2MrPPD9pdJwv6liIzNE9VHoHa61qP8tF3+YlK7i2L5KGZAma68=@lists.linux.dev
X-Gm-Message-State: AOJu0YwawN8GyVtykrrbhxFSrX1e0xeLKZ7Cv1ILAiWuEBEENdFbJuzE
	K56NkSJZtzag3MQkTZkKgjtKkNH5JVWzriaCFIHxvP53RJfOgiow1DZjV4DrBv3J
X-Gm-Gg: ATEYQzx468OPCgTebePomjrszw6ljg+d7ZOiTzG0JmAQkB/82ViogYbCFRb6ZRWLiIb
	2ACBbAsrFAxV2tmB0LcBBE0z8kZLL5Bq5PU9HocDy2RA4E/wpas7Ks1a6ZUH9bnRxzWH+zF2i8o
	cQ04GNxHMCqffWIWmEIxdIV6dHGrNicyyxWvLu66hY0tm1ht7/2eVLEsseswvL79ts03wtLLY5R
	4Vo3cI7rWrILGT9hw914zkXnwT25H3OEIHNQ97biU+YxRDNv+TNDhS9KapT1pAPWF4JjwLz3kxu
	y464gY8DdCOqMlil61I4Kr+9uA87ThlVU9FGvjfjDCYtUNr1IKi+G/S+YRr9oLFU1VW1lTOAY4a
	5GpCYSCt7TU8Lrd8FgLTHx9YeipzbZN2Gu03VS1g8RfpiAmmpBtcQWfRSsS11Hk4KoiR4D7zpD2
	Kc4nzpcCXV7yCwffvHstB3UeElNd6rwolcgUlvyM9pjy3Xybpno9gBOT+sxtZ4EEseU6HPU6H34
	aw=
X-Received: by 2002:a17:902:ef0a:b0:2ae:4fc7:8053 with SMTP id d9443c01a7336-2ae82481982mr29214585ad.46.1772805814651;
        Fri, 06 Mar 2026 06:03:34 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm29134715ad.92.2026.03.06.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:03:34 -0800 (PST)
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
Subject: [PATCH 1/5] sched_ext: Remove deprecated SCX_OPS_HAS_CGROUP_WEIGHT flag
Date: Fri,  6 Mar 2026 22:03:21 +0800
Message-ID: <20260306140325.2710927-2-suzhidao@xiaomi.com>
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

SCX_OPS_HAS_CGROUP_WEIGHT was deprecated in 6.15 with a comment
'will be removed on 6.18'. Now that we are at 6.18, remove it.

The flag was a no-op and only triggered a pr_warn() on use. Remove
the flag definition, the warning, and update scx_flatcg which was
the last in-tree user.

Signed-off-by: Su Zhidao <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c                              | 3 ---
 kernel/sched/ext_internal.h                     | 8 +-------
 tools/sched_ext/include/scx/enum_defs.autogen.h | 1 -
 tools/sched_ext/scx_flatcg.bpf.c                | 2 +-
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c4ccd685259f..56ff5874af94 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5061,9 +5061,6 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
-	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
-		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
-
 	if (ops->cpu_acquire || ops->cpu_release)
 		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index bd26811fea99..3c86c53e1975 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -174,19 +174,13 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
 
-	/*
-	 * CPU cgroup support flags
-	 */
-	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
-
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
 					  SCX_OPS_ENQ_MIGRATION_DISABLED |
 					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
 					  SCX_OPS_SWITCH_PARTIAL |
-					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
-					  SCX_OPS_HAS_CGROUP_WEIGHT,
+					  SCX_OPS_BUILTIN_IDLE_PER_NODE,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index dcc945304760..80c885f781ba 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -91,7 +91,6 @@
 #define HAVE_SCX_OPS_SWITCH_PARTIAL
 #define HAVE_SCX_OPS_ENQ_MIGRATION_DISABLED
 #define HAVE_SCX_OPS_ALLOW_QUEUED_WAKEUP
-#define HAVE_SCX_OPS_HAS_CGROUP_WEIGHT
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE_SCX_OPSS_NONE
 #define HAVE_SCX_OPSS_QUEUEING
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0e785cff0f24..a8a9234bb41e 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -960,5 +960,5 @@ SCX_OPS_DEFINE(flatcg_ops,
 	       .cgroup_move		= (void *)fcg_cgroup_move,
 	       .init			= (void *)fcg_init,
 	       .exit			= (void *)fcg_exit,
-	       .flags			= SCX_OPS_HAS_CGROUP_WEIGHT | SCX_OPS_ENQ_EXITING,
+	       .flags			= SCX_OPS_ENQ_EXITING,
 	       .name			= "flatcg");
-- 
2.43.0

