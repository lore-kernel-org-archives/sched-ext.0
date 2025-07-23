Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E12DA743
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272492; cv=none; b=Rd8/AjdgbgS4sVD7SSa9yXpOyVwhQoCXYa29mJV7g3fqWn34yf9oNdmSyogYGYsDkEsvuCP8WDYdFLndJHnf3dJXk80Y+SbxsZK6G0p4dIyQfszJIZStwvbB0sX+3KB5xwhfRhJgpSM7g13M1PabW0naPE/nNxXXHI1wDO8kQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272492; c=relaxed/simple;
	bh=Jlc2ZgqkUCpmI2pYwaMlosjmhoAtyt9hhqP9TZJBRvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKDeoPYBmvNNmHoRIn7YgdnBqmX9Iqm4AJOudIrCmXYGu1tY1eEBGZjrmZGskU/UF1MMndNWjSUlHS5DVxe0zdS66tD3m2u3bnwvAjezIWZrY3v8i1go7l5ir9+pTxHKV2uSubCt6J7UvH+B52MQNdoGlD3X/HDkG0zKU6GXGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIovnA7N; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIovnA7N"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74931666cbcso5328618b3a.0
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272490; x=1753877290; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcpyT/fmZ+71u9+NXxtuM1IOR2IvZpoZ1TeMlswhEBM=;
        b=RIovnA7NOfWkC8mXuH2o2NkhpKQxH/vKHKbeocx39bRRDBwbuLu9cJvOj7rXyGx7vU
         fQWBR9tR7eKriAetq/xHzN+awd0tvvZ/0w2RgQllibHirauhlD49K4i30jhT9hgs56Tx
         BIgyhGZD6k/umJob/TOQstxVtkeQ3Hx/rWCeRdmywkY72Kw46vH+6UpIgv9TOZ6hA4rH
         cdDUSAn79H2Kp/+wVbFJfZFrjTwBrfhWNBvpbFDq8Kx787NbL+kGZhuIMM/F5e5IqBMy
         iObrbDDCaZoOgBisUKdW41dd6IeezHSkTyYFxigHPlQJYFi5iWyXVYr3lmh4Y8eaX3Mo
         sA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272490; x=1753877290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcpyT/fmZ+71u9+NXxtuM1IOR2IvZpoZ1TeMlswhEBM=;
        b=IVDvSgKqtgnJUUVVDZ0kAavMxPHNnbBuCgRCkBLWvhh7L9ZkGEheBlO2LcN5SPIL04
         5lPQGWGUxZPtNpPqG01i6Vvtp7Ad7tt6LOBGlg0PtWU6IKGNPFKjuTJSp8bDqR0p1m5Z
         ojXpf4xy5nigjfaEoG+sWUoExczmFGsOO1HceiUioEgXgwvfeWL3d5mrk3uamawexz2J
         Gci+NuI6h6TqXgrqMQoEDxKBZbpCpvhlWyU7xhrb0U6RokXi5HzPUsvGqOcI1z4GCF/z
         2eij0pL4bGWct9PJTF7nE66W5bKpIZAeyUSGfbuLb4DBbCwdU0n/M8J5h2TyWswv5gDq
         yr2Q==
X-Gm-Message-State: AOJu0Yy8zeN2jlhBh49farJPQiy7kfxHU5K+tTg8iNKw72GzQc5AWp1O
	lOsmtT+OaB2FCQBUE6v1+Ju1TyBTCQVvfiTTptzQW5ECZSaSX+2+lBOvywkYtvmCktA=
X-Gm-Gg: ASbGncs6p2rhUqx00lGMZRmS2RSFb5yEIL7A/1eyEby52kS7aH105yQrlKMgZBd5IRh
	ajzTthOI89SiTOBxfvqkoIDVWSD1UUkSxTp21bKzksq5HBOQiicJ6GlXn6QYUQHSPIuGHcqKMDt
	STiJzpHyCie+n2b/DVoMl/j6upXddpsE8v2xIZdIYZ+AQ17yrSYxQIfhgaU65Se+rRg5s3JA+Ym
	jMoRn5W7+zemacuE2D0vYYnknIFQa9WWRvrkreWmNVa7wv5zvY1nyfuO2yb3XLFIlZqFsPwadRO
	lzvjNqMFvCpg01PPjv4wnKhrS5cDWk6rc2VS/8oeN0uvOEXApCXAi9sO7KF4SeTJfBBe5lUE/9B
	UJpxszxQudIGOgteZ4m9Kuo6Z80S7iHK6ND6Iqpds57tamlxa7DLH
X-Google-Smtp-Source: AGHT+IFetbSLveuHG3xI4D2dJZ1jJ8/hgAjkHRZTR13PRvIiEFtcngGJ4aMZivmx8fJwpZ5/SHem2A==
X-Received: by 2002:a05:6a21:6f13:b0:234:e900:4fb7 with SMTP id adf61e73a8af0-23d4913122bmr4541691637.24.1753272490223;
        Wed, 23 Jul 2025 05:08:10 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:08:09 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 10/10] sched_ext: Sync with scx upstream in tools/sched_ext/include/scx/user_exit_info.h
Date: Wed, 23 Jul 2025 20:07:46 +0800
Message-ID: <20250723120746.52847-11-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723120746.52847-1-yphbchou0911@gmail.com>
References: <20250723120746.52847-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync via ./sync-to-kernel.sh /path/to/kernel/tree, as suggested by
the upstream scx repository.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/user_exit_info.h | 49 +-------------------
 1 file changed, 2 insertions(+), 47 deletions(-)

diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index 66f856640ee7..399697fa372f 100644
--- a/tools/sched_ext/include/scx/user_exit_info.h
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -10,55 +10,11 @@
 #ifndef __USER_EXIT_INFO_H
 #define __USER_EXIT_INFO_H
 
-#ifdef LSP
-#define __bpf__
-#include "../vmlinux.h"
-#endif
-
-enum uei_sizes {
-	UEI_REASON_LEN		= 128,
-	UEI_MSG_LEN		= 1024,
-	UEI_DUMP_DFL_LEN	= 32768,
-};
-
-struct user_exit_info {
-	int		kind;
-	s64		exit_code;
-	char		reason[UEI_REASON_LEN];
-	char		msg[UEI_MSG_LEN];
-};
-
-#ifdef __bpf__
-
-#ifndef LSP
-#include "vmlinux.h"
-#endif
-#include <bpf/bpf_core_read.h>
-
-#define UEI_DEFINE(__name)							\
-	char RESIZABLE_ARRAY(data, __name##_dump);				\
-	const volatile u32 __name##_dump_len;					\
-	struct user_exit_info __name SEC(".data")
-
-#define UEI_RECORD(__uei_name, __ei) ({						\
-	bpf_probe_read_kernel_str(__uei_name.reason,				\
-				  sizeof(__uei_name.reason), (__ei)->reason);	\
-	bpf_probe_read_kernel_str(__uei_name.msg,				\
-				  sizeof(__uei_name.msg), (__ei)->msg);		\
-	bpf_probe_read_kernel_str(__uei_name##_dump,				\
-				  __uei_name##_dump_len, (__ei)->dump);		\
-	if (bpf_core_field_exists((__ei)->exit_code))				\
-		__uei_name.exit_code = (__ei)->exit_code;			\
-	/* use __sync to force memory barrier */				\
-	__sync_val_compare_and_swap(&__uei_name.kind, __uei_name.kind,		\
-				    (__ei)->kind);				\
-})
-
-#else	/* !__bpf__ */
-
 #include <stdio.h>
 #include <stdbool.h>
 
+#include "user_exit_info_common.h"
+
 /* no need to call the following explicitly if SCX_OPS_LOAD() is used */
 #define UEI_SET_SIZE(__skel, __ops_name, __uei_name) ({					\
 	u32 __len = (__skel)->struct_ops.__ops_name->exit_dump_len ?: UEI_DUMP_DFL_LEN;	\
@@ -114,5 +70,4 @@ enum uei_ecode_mask {
 
 #define UEI_ECODE_RESTART(__ecode)	(UEI_ECODE_SYS_ACT((__ecode)) == SCX_ECODE_ACT_RESTART)
 
-#endif	/* __bpf__ */
 #endif	/* __USER_EXIT_INFO_H */
-- 
2.48.1

