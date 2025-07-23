Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CE22E4989
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272489; cv=none; b=Cm13Sz4n4LyrtsXAkb1XW5PUn/+OpvaQQUV3tjc0lxIYf6IfPQwxl9NkB42kJwGOZNxJyokRkpgl7UGV+fAxaIo+J2MAXI6pQAL+Ry4Cwm5qxHOcLlBKxG+Szw4G90iCW0zNECD/EOIBN3JYLWWTzCMmBGveNyW8pnYzqTCLeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272489; c=relaxed/simple;
	bh=WKak2jiw+OoqBvUeILZ3CEbx/73Ltul7+sCRkJgqgTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs312UrAYYWHzMXLU3iSDB3agUSutP00i/bTDG8Cu4F0o0f9kK9+LuR9ScL/MkOvgqGFSh0tmDIrYSrMPdECUZEceeGBjZsXXc7cXLZn3vsvuh3OE1k/otQp3LHIMsMJs9wvmLiaxZXNhdKDtrXiRHf4rxRcaLyqIwB9cbakwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRlrJurL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRlrJurL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74924255af4so5685387b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272487; x=1753877287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lbAXBBV2w7IWj9ixcg8DqiyH1Xxnv0LnftGv5HMuXk=;
        b=fRlrJurLVj77BYcm7jyiyZyinbN5E1fGP4HNtoBcQWr9TecxCtOBJB8YalnHu7mAIW
         NO+NSCWNKuRU9NloZvnDSYAMVtMlFbBvi4elogqiN6yshgKFdDoZjfH0B1WLrvxt1CVl
         rh+yEo6mTpxl4iyPNdOhl44R12Of23W2NjF/N4nYB+/zxb05r/J9KRbTxGORl61Mpsur
         hO/YaNa2bsQBh7UjnlT31PBnNrInS0P1PIZfhSy1E/WMIlVJMkmESHpi6KsKJLDgJbtC
         9wUhZt5nxXNS+wPqf9wS9VHqeKSd5tSroGK7wT6xzK7zhtbl61p3zRqarxvK+5/Bh6lZ
         cApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272487; x=1753877287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lbAXBBV2w7IWj9ixcg8DqiyH1Xxnv0LnftGv5HMuXk=;
        b=VGHo8BDZpjFABTPul5lMtQpCNsSoTpAjckttSsnOoK9yTT4rUWpaZeD8+bGOTESJ1S
         d8lqwuymNZfFzWj5Qlbjg3wAwciW1TaNpJELuYKsy7QqaQC2nrpmHeHIjGkTwSct4XG/
         ySfAzRYH7n397nNT3cb62eExQWrGrYBrxNuPBGwor66f29vJ8zXmVa6saxWzS0a1ocyy
         UEZOk6Bwk2da8OCcj9csYPftCbH1qf67vnJmdgsG3mbn4g7Pfyebgip3gFr5icrgvaCi
         aa7omRgkRUg+bFfoSYKfy2/x/zs0cQR2cRu6k+1L0lmk5ehnQbrD7xVC3uBCcjVm8D0+
         Z8ig==
X-Gm-Message-State: AOJu0YzGQ/wVkbCcFtSiGijFazekq3Q3hYoc2arhggRvwoDLYOcHwYa0
	9quk9s2xIW3KQwwCzI9fMEqMLv63tvYlOd+stiIHLjYBZKeodAajRUcFC08dChfOZ8Q=
X-Gm-Gg: ASbGncveiWTyuRCPXFhBXdkjQH+5UBpyMNOEAb1ZuHDqzCGLp518wpKKSW990iAR75d
	8j/7KSY7UsUTJ3nmGbKZjKtovDCp4RDUogPsyChdP0lXAc5xw+jxCrv1lyEdJS9eQkbGvMMpkrt
	AV7TX/i9Ilvw2xzFRjHL+VZ1+/h5Z0mI54uufxA8AXFUbJpK04oRh5UR+AY3Gkl6p9TlBNu6zt/
	OZA7HwKkcXiyerQwoQNNm9TTq1bZzd3xfNp0OI18iNsUdF4n4UCUD3It2OIXRViPwi7zSikOcf4
	kP5on1DaJxPtZrsKSPVN54kOWQb6omCFNAMrA4T0vlwYE+rTL2VrQtBKnAxe7IOSgt6t/GEVKpv
	tyGgyye1kk4IfNR55RGLvAOQmQHFsDQy+L5dlNw3F4AgTBRRKOGGS
X-Google-Smtp-Source: AGHT+IHQ00dBEzKy9TvDB19yyql+/aLsqoMrwSiNEnZzIkJ4X1yGK6OM0UzGMylaAd5xEE7QtF49Ng==
X-Received: by 2002:a05:6a00:2345:b0:74c:f1d8:c42a with SMTP id d2e1a72fcca58-760353db5admr3387211b3a.13.1753272486866;
        Wed, 23 Jul 2025 05:08:06 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:08:06 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 08/10] sched_ext: Sync with scx upstream in tools/sched_ext/include/scx/common.h
Date: Wed, 23 Jul 2025 20:07:44 +0800
Message-ID: <20250723120746.52847-9-yphbchou0911@gmail.com>
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
 tools/sched_ext/include/scx/common.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.h b/tools/sched_ext/include/scx/common.h
index 1dc76bd84296..b3c6372bcf81 100644
--- a/tools/sched_ext/include/scx/common.h
+++ b/tools/sched_ext/include/scx/common.h
@@ -75,8 +75,9 @@ typedef int64_t s64;
 #include "enums.h"
 
 /* not available when building kernel tools/sched_ext */
-#if __has_include(<lib/sdt_task.h>)
-#include <lib/sdt_task.h>
+#if __has_include(<lib/sdt_task_defs.h>)
+#include "bpf_arena_common.h"
+#include <lib/sdt_task_defs.h>
 #endif
 
 #endif	/* __SCHED_EXT_COMMON_H */
-- 
2.48.1

