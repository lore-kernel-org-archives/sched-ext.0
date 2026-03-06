Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99F392C24
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801350; cv=none; b=D5nKISdImDhClBReU0vY3+wDfKW7DwGADqiPWAYRZ3hEiXw33+euA2p4ZDfH1ucy6ESuIVwt9moqB6JSgXZA8KqP26ydb0NXGYwt/x43Lj5dYcqg4EpmkzNSyE/c7g1y3NKEQTrze1B08xDN74/T/BuHZJcpfRJ6/eGX82rLJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801350; c=relaxed/simple;
	bh=z3V40F0kGIL8yvCLdRRK98TbuZQ8stHEY3dTCT0ogJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=etieGg6AVQjYBCs5Wgxfn1JZQJgcDgA9nPxKepT4ge1oBdYBrZmD1A54yLjb7JTUaTDc0bAQondcgmGyA10UkQ9D5crDRJ1dgMTcEbJNevInQXP1iTHMH5sRGmFuaE8ynEBKFwWL8To2I4T3t4TA2DaCajEOxJLA7LunwZn9JqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzmSoSz7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzmSoSz7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so2918377a12.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 04:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772801348; x=1773406148; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZzuQXuKro+GXBxmmjg8yJdwWTDQZtX+cD1VaFXmUG0=;
        b=CzmSoSz7tJCR65nZrxknx5xgI0VDvne8iNXQ8FpDQ7d1Bhjz+MHEo65NJvAAT3w1Ir
         yrOfyQQQZftAtBfah6FV5BratxY8QwwnEQmOrlpxZjvxs3edKQuqEWnaa8dHP1oBPXfz
         qR/cdJaoeWver3Dx+nWGEX+8mD5y2Q7Fd5xEf3Qzrg8O4p5kXuUV5mPJfLx0d77MceLv
         q6FotoMEgsK1wKJlIp4SNLoUtPj2Yj445gKj5MxY19ponk1z36cjGIshVimSrcBNE6EK
         OhoTzTpJmQjwnHfQNH4mQ244bHVhJ6GF1EXKj66gFo7gh+Wi2WnQi9lroS3ai+XqPnwX
         adNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801348; x=1773406148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZzuQXuKro+GXBxmmjg8yJdwWTDQZtX+cD1VaFXmUG0=;
        b=Vq0C6PURXJfss3FbcKFs2RrX9BJylpCxs/Wskk+UPJ8rgXicpY644Cidab8LP9CsrD
         4QAbMnlxG6K41U4VAl6O6ECdlUqY0GbH/DqBppEXBgO/tiC1LFQgqIJQ90b4QS24YhT1
         WeF8SrIvxu25egMVYff4YNP60rFexhinppBAQsRfbs+/E9Wc83h3dMT/QnacVarZ8Pqi
         mB20WmqlsX9IfoY0fytfVVqPsb3JBoUQhV3ZU+rpYbpxfJnAdDfoeye5VeEtNG7dW9fU
         qka3hWgUdbP09nBmFqFuIUgofWT1Fpm2Xfh9AXVXPpJQjlKuGgqvRB1LEJG/g+ciXL0S
         kSQw==
X-Forwarded-Encrypted: i=1; AJvYcCXHMFtw8aGyHKNXfY8xeUP0OMScDkDcvm/rTwHyj/yYDpWG8DItuZL8bk50rVo/pcMLsdrW4xj/RjA=@lists.linux.dev
X-Gm-Message-State: AOJu0YysXfPaPEjRYBNLu0+GOk6jZ7S93Tt/jsT22gvRNpLZa6GA9g+E
	SAV8P/IzhmlBYvdpOHvNHtSGMBP5HCSC0hjXiMe/ilQG3ncWxDbkH8Mq
X-Gm-Gg: ATEYQzxv2CFtzMoECQwM4qGsO0q5Tj+2WTmqY8bt+WPSD8+Mxln4CFOL4cThyCh+pdm
	pek5eSIfmj2zGeJSUubVnUbdhwL05Kaf5VcnkNkDa7RywRNbpMvzqPgHvB8NjNqCknSFOvjoRTw
	U6ho/kDo3NS4er0nGA64VdiLUeUxatZvRJC04kCIutKGthBWlIzgAn5dk4XXbBIGDHyoNBbveE8
	8GA2Qc8kAcrx2COIos6dyWC7w2T8uoFmWphKoZMoep/zfUnQaXssvMorEUSA0Mc9RzOOkAWcALH
	N4MIV6OULw++NwGK9P/d+ZboD6a68Yl+dh/+uDzB6uTvYZcFcKFYSJTw2/0auf/d932Rp8+zAMU
	GtQUEcBKY017cSKiO9sQYjGYujV0uizocBc61QDl4kjskZx3NjtMZnSzsuv+xcsGK4IVYliOtdg
	Q7Yoe9PAxBMJsJAWsUzH+td8wAvx5iFv7GhXkLZqaDqsoxBxpqw16tIesytVrI5o7WvwqhA+W/R
	GA=
X-Received: by 2002:a17:903:2f8a:b0:2ae:57cc:63d7 with SMTP id d9443c01a7336-2ae823ff86amr24082965ad.7.1772801348105;
        Fri, 06 Mar 2026 04:49:08 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78f77sm27712845ad.21.2026.03.06.04.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:49:07 -0800 (PST)
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
Date: Fri,  6 Mar 2026 20:48:57 +0800
Message-ID: <20260306124901.2653465-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
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

