Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107C523781
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967093; cv=none; b=FTJyYOxNlQLNl+zVzTKefDFkiswOWvgWCJD4QFsl5wLoTtEArezTZjBslhb26ztwVfPab67HfP8Y0k4Bb9MAnBc3PuUmt5PvqMMgqEPIEM+H1mYqqxIFoJ4FiVIPHfsGR1pybtHlgewXh7T+sN2NeUPwg/aQaDrzOUVkA0+FcpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967093; c=relaxed/simple;
	bh=zSpdtoHPr8IBN0bibk7kGhRYtQiMItgkMgGvLhwCYrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+J9M51/cTyaxm4PLZjLInfkyWC464GDTSbqUHK1afImkhSlMKfVioh13Y9IelMHev10CyXmhPjmtfsAg7FaOG3DVRDD0wMos6Tj91EkJSwawM5rCCkAT80yAUHMHGRw0JCJ2ZyrcZHScxh+92TOFsGTEa/6LLU27sgwAKXRXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrHroISl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrHroISl"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso52731005ad.3
        for <sched-ext@lists.linux.dev>; Wed, 09 Sep 2026 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788967092; x=1789571892; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MBO+9Nbk84N9CTFvP2XXyLABs7otbO0NOFxjKCNvedo=;
        b=JrHroISlnfqF6WoZq++l53Yy9vNexNzuBWQnuoioH/EXqknS6zVxsbdI9m0glmHR7T
         XSrlpirvXUw3xsLK6t5n3rAEjs4LuwhTlGim2e4WTEQzVxNMI+iCqrGXaRLM4eKAyrx9
         xzJgRRpoFG8A7x9Z4ng1HxuxCWIhIBqC8qVcLD48OG5ShGkbFszZ07y+tKQgN1nO74x1
         1VmQjeqK9vAbJuFBjeeiMOidyAFdMvHdE+Ww+VzH7Huz5j95N+z2u4p/xECJZPCV18Ks
         eSOs/m2IIuGVf8BvWbA0/8ULZx13hTEJUQBDJow78RmDtKPS+c29A+JynuqPP2R3u5HL
         X23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967092; x=1789571892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MBO+9Nbk84N9CTFvP2XXyLABs7otbO0NOFxjKCNvedo=;
        b=jx9C5Ve4kkHpq+ia24q8A1ht/lEyTb2bUMZRSUnidpApX9z3nvHHTA8wvAzOy8Vtq6
         e8lVyw5E9qzINkDDcMTlYWU2Z/xlCVwV4wA7O75H4zNMByNkxTP6nTyqmKjFxWXu3MZl
         Lgm/oLfiE4ka4842bqLgq8gmVesePzvvPbTYCzLpEP3NeZZEk4jDbmK7B6asYt04jxMe
         8T/2YG3DU2PFk+aTZfTt11erbhwm35lBOfQ3UWRjh/mkNFj3pb9bjtV+aS3A1kjJqxxL
         K5tm3MrFA8BW7BrXlmKLkz65EuJRDu+O70o10iE4I+8jYG7ESt2Ul5wu5LsnzdlxpYFU
         26MA==
X-Gm-Message-State: AFuF++nJ76IhOJjuoV3hrp0V7OFirHQkgICK4vQOS3OpBIYL60Yjuu5o
	wTRBzx03tUg1Quek21zVI2Tncs71WPp+Dei3mAkM7SbYIVrNM0hgstbeORl1dcjP
X-Gm-Gg: AYBFou0iCP7Yw+2psTu3/IOF8sf5tROzwztRSQm7json4PzNxK8N7lU+NqmXF4iwXf3
	eJdglD8HKd3XJSo4/1aduyfHWxqHvJp8BEyWT7y6KYjEdLQyR15hVO8xPP7uvWh8YUN8lAQCPX6
	Cu/mM1zQKiI4c/54IlgjMWxj9RlJdoia4U+2JIoKlt4selOEquQ2w8a8cP3NJeNEATFDv+s33iB
	6wL5hAO56KlSTdcOUT0+hbZu8ON8ohEIb952aJ+wbELMzSXH/gIQDPcwUnUQ4tzbYC+93MdIjsg
	TrzamVWtt19sPHzSUPGuPnAX7EYkUSgGAZjCGZyM8v1jiaGfZqpjT03stTtsHa9glOpmwcBNJ6U
	lfFFeJw4jvHeHsmgiKovGo9PRxNUc/KIDDQFOnk1guuZhh8R4u4g+FlYbVP1zOT6FxzbXcAjbis
	fJ/4WcHZRIRE7YygguxnP8VIZfbTmKenoT9cP5d8JdCHoHguD/1oHbonc0tP1dTCO5VXRy4m8d6
	n4FxQD/Z4rBvC6DJ61jrEX6bi0sSS2cJcd62eBHwLCvEom1XRZc0/++JlTON8ej2oWsDYOKh0dH
	i0P17Q==
X-Received: by 2002:a17:903:1b47:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2db124ca14amr524797135ad.9.1788967091695;
        Wed, 09 Sep 2026 08:18:11 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-229-11-35.dynamic-ip.hinet.net. [36.229.11.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db4bec1fd2sm48566895ad.49.2026.09.09.08.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:18:11 -0700 (PDT)
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
Subject: [PATCH v2 sched_ext/for-7.4] selftests/sched_ext: Drop -rdynamic and stop clobbering LDFLAGS
Date: Wed,  9 Sep 2026 23:17:22 +0800
Message-ID: <20260909151741.24742-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Nothing needs the exported symbols. Separately, LDFLAGS uses '=' rather
than '+=', discarding USERLDFLAGS from lib.mk.

Drop -rdynamic and append LDFLAGS with '+='. This fixes builds with
CC=clang-N while preserving USERLDFLAGS.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- Drop -rdynamic instead of moving it to LDFLAGS (Tejun Heo)
- Link to v1:
  https://lore.kernel.org/r/20260908134722.8671-3-yphbchou0911@gmail.com/

 tools/testing/selftests/sched_ext/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 3cfe90e0f34f..5f5dd9ab903a 100644
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
+LDFLAGS += -lelf -lz -lpthread -lzstd
 
 IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
-- 
2.43.0

