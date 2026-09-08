Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6104A64CA
	for <sched-ext@lists.linux.dev>; Tue,  8 Sep 2026 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875286; cv=none; b=LDLKstKxgVMsRH/rhkFB73NMDIQNMFvnt4PBAvikTYD++XSnfj/uLy+omgmYdvqvAgFa4K0I5Lkrl5UiyTAs8GyxNtGXhQ0VSIKmouo60KzPb6/A/KUkxGa5B2e9BfoIBhG2k1+ryCAWmn80GpKtTb0h7TsxXCJm6mMcsd3NSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875286; c=relaxed/simple;
	bh=gh09IyRsThQWx9ZCstoodNJ+/iYSt2LyzXPum/cqr6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvG7O0sia7OhCM0S6vqWvQ3cIa2Y/NJGyQuQr+st54UOmnbNF7PoiR1UrIiQkBRlB4x+mm2kfa6X+5Z0JSX27vKNsz5Zr8T+2zjt72NlqVELZ8QjEhDxjRdUIBR63txltQaxLpmODD7/z8hvmUVfawwH7XJPGr61m+iSY+0fC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmnDNYa6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmnDNYa6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so6068624a91.1
        for <sched-ext@lists.linux.dev>; Tue, 08 Sep 2026 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875262; x=1789480062; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XqLE4PtdQ7IrbiqyougLup5KvNAcM/Jd+TstECMgtrE=;
        b=lmnDNYa6Xc9QWeE4SU8u51ui4QmHn1jsfktBMDhHuFzZlvOf9dGlGnqCOvGqRRKKTS
         2cFTWRSgTb8d25Il+IlJGt9GP02CuW5FceJtWYsnw5Z54nN5XQFSg3NQzc4fmkPQAhil
         xGUJuunpiD9cINRxduEVb+K+qoG5lMywBsORSYWdMbq2EfxS/KhY5XRny5L3N2gxR+be
         lzzb27khcXGBKziN/aHBYw14xB77uHmnQl39cs/CqYwtsKcUSxfLJd79wrI/5OON4JW5
         A6eBBgB0LgHKubaQakSWc067AzyDJdiCtjkfyJoTdd3NkZ8mjZ7CZnpQZ/zoKSDG2+IM
         WTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875262; x=1789480062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XqLE4PtdQ7IrbiqyougLup5KvNAcM/Jd+TstECMgtrE=;
        b=geaqH9vxgDRt60EBp81RZMWOcDl7qx6XdPL7ICHAAXADqSzHKOtCMf/SgMUIm3cX/T
         gjlf39IPo5rr+FY9UeYGANUgZxW9WN2TB9gTQQOo03VQgZ0UizKMW/R/hD1u296eFM/2
         79Vb5d8TF8p8mR2X9+QOk3AIwwBQYaEVKmw7RJr8J5ncVfad4UBliHmzJhEYxklw4HH1
         ppzwC5kAuqxH0YQuLGaJAtI8a4V84oAqlkKlMTYW9JXTT4MNczP210S1izMKgOErmLfp
         wTUcflh9IFei87jb0DaXS+alSRxZhI8oP8nZcVs839HRuXwB0/gaOyZKHYcdJPnNGa8T
         QBgg==
X-Gm-Message-State: AFuF++nHxbTP+k7ISbwyaPCXqshhfqdNzrWI7oo+HRCfM8tVsT7R/z/h
	Zd/CQYcagXtHTRrKDA151gDh7nvm0Hc2pN5IekmH3Q6bUmQObQWVp3O8/91oSg==
X-Gm-Gg: AYBFou1NsfPUCkE9CeXRo99BP3dqaoIuGNWA8fXP6SqhuaJDXXqDxFAFp1sm+abXjkF
	nJefZ8cgRVb3A5SkDQZHeSoxvzjzmmIpPJu73u4QoKSs6OMHWXx8gkYM/AG4H8Q8qVij9wSLTCC
	OectlWbzILadjiB5yTIXTSDNxJBr/YjunM0QiJGbD0lDtZy5OMXXQxyQuYPHHIyb9ZOLXqaCzC1
	YLGxamWOhNIPqieTrgH+om8cfjhSI3IkLrg45AXKH8+LcwdRlnxp7vgvTKUj1hBeJH4yhAKT/oK
	251gxeFDvM8j6dbh1JfNU9kw4OBkiH1qAhCuIEH2S1ujp+VBmNaIJ18Ml0wSYkDXxwnC/F+1UJd
	x8hcEe1mXPSP7pnKhagPA/R/C5XSWErDz9Tl/w3nGZldxZZaS7PgaY5zaIz7gS2Ev2xgqoFrbff
	/hqDBJDj/tw8zXuvkFB7CrLE54t3f1XxldDeRDWmE3W2mt/mh/GVAfm99Uw1Antbugvufc0g3do
	SnXYOfJvNPK1epCHSGvuP6J6t1i1fL+V8q+3RmhKPK+2124Yj5OV/fVzjMSSkgnmPwxfFk=
X-Received: by 2002:a17:90b:2687:b0:395:4290:46e0 with SMTP id 98e67ed59e1d1-39b2609f768mr49545777a91.5.1788875261597;
        Tue, 08 Sep 2026 06:47:41 -0700 (PDT)
Received: from cchengyang.duckdns.org (1-164-68-170.dynamic-ip.hinet.net. [1.164.68.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae610e5b2sm9994013a91.0.2026.09.08.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:47:41 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 2/2] selftests/sched_ext: Move -rdynamic to LDFLAGS and append to it
Date: Tue,  8 Sep 2026 21:47:09 +0800
Message-ID: <20260908134722.8671-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908134722.8671-2-yphbchou0911@gmail.com>
References: <20260908134722.8671-1-yphbchou0911@gmail.com>
 <20260908134722.8671-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CFLAGS passes the link-time flag -rdynamic to compile steps ($(CC) -c),
where it is unused. Under -Werror, Clang fails the build:

    $ make CC=clang-21
    clang-21: error: argument unused during compilation: '-rdynamic'
                     [-Werror,-Wunused-command-line-argument]

Unlike the demo schedulers, the selftest runner requires -rdynamic at
link time to populate .dynsym for testcases. Additionally, LDFLAGS uses
'=' rather than '+=', silently discarding USERLDFLAGS from lib.mk.

Move -rdynamic from CFLAGS to LDFLAGS and append with '+='. This fixes
builds with CC=clang-N while preserving symbol export and USERLDFLAGS.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 3cfe90e0f34fa..c756285a4903e 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -53,7 +53,7 @@ ifneq ($(wildcard $(GENHDR)),)
   GENFLAGS := -DHAVE_GENHDR
 endif
 
-CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
+CFLAGS += -g -O2 -pthread -Wall -Werror $(GENFLAGS)				\
 	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include -I$(SCXTOOLSINCDIR)
 
@@ -62,7 +62,7 @@ ifneq ($(LLVM),)
 CFLAGS += -Wno-unused-command-line-argument
 endif
 
-LDFLAGS = -lelf -lz -lpthread -lzstd
+LDFLAGS += -rdynamic -lelf -lz -lpthread -lzstd
 
 IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
-- 
2.43.0

