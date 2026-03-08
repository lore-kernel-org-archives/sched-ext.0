Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F720C012
	for <sched-ext@lists.linux.dev>; Sun,  8 Mar 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772975208; cv=none; b=nobisc/g8a3tQ+tT2wLNEOw1OtyvKnHvCxB+zBRmQBlfBci7+Q/YnA6ixQy/YNbuk5EkrlzKiSR9x5zWb7X5BIOTb0aULWl+Z4vCJJ9KjbkecexSO9nfGlrbXsglIDApTwn7Yy/8ROl53LfSdzLX1By+f4JzaNTOHrv76d4kbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772975208; c=relaxed/simple;
	bh=aBqnZPB7yXg4yJmhtiZ17I5tNwABbJ6GKvlbzBEB1oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVwklyrz8l3dQE7xJgVi8S6TDxDT7x76BRWYDUlaASbPVd4H093S10rHpzCZEQbSYmKyC2IHwDddqCrAOK2SN6Nk7tMOfoMQR3NT2r4kUTr8iSDYpVVPu26VsYPv7q5mhb0J1JTaUcff8x85mP6wCLTtLuxCfWtv/RGhLtMSfYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A04MJeKS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A04MJeKS"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso1648479a12.0
        for <sched-ext@lists.linux.dev>; Sun, 08 Mar 2026 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772975206; x=1773580006; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MA3qycKPJvpcyKSEySaG3ekXCWfE9L2232ZHOYea9s=;
        b=A04MJeKSTehfDThjxxUYD55j1KrJFkei9eBPpBeXb2iKh4c/v8gmTIIjrcU3JHCAm/
         SK8o4vaTbw6y3c0913+TDVWo87HHygavBB/SW9yzpqPr2kffxWLj4dxmmOH2EdLob0Yw
         /sH8l9CPmhNJLOrETwKzaa5iNpovB95/HECu2cMxGLwsWC2IaaIb5C4XGf8qXNkU8gxC
         mqM9bP7RYb87XDhrTWY5+S4JqQt7IMaomIAAksazLwQuHHQwda2P3h7OtMEq7BVDC1ad
         72/Swb2c/vvKYr7GCBKiG8+cRFcOrC6f7SK856azs7eLbMxXKo743b9a5i8Xsw04tcSC
         FVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772975206; x=1773580006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MA3qycKPJvpcyKSEySaG3ekXCWfE9L2232ZHOYea9s=;
        b=VLQDlYKSuIBUXycuFG3Oq6i1Cyco4ODL3iuMxip5I5zhXBASSpwf90/URFBWUEahV1
         a+13WkAq31euwMuGVHyoVaxOeKnmX4MKxPaIvNjKxCHwHsWvg0aIB1Jfuu4om6Qsfpaq
         08TIF4TLZonPZtEpghs2CjzT0vlsEEhe6YHOwQEYYOm0lSXCf6NI3ZCIUm9zighTOhqE
         OF9Qys6wplEA/KoQCshn7efyKhZAQaC4rBr21ZxXe1AeddURF/erwF9f+Ly0M1C8pkM3
         Aro7sT0Y8QZ0ZrjMA8NDYiLug5UVsMRNBXTjw6t5n+IFWReb2+/D1WIo0ofjO036YIz6
         2QcA==
X-Gm-Message-State: AOJu0Yy/1DBrvyfVltjv3WrYdmmxfNZs8iuBpzXExC+xrLYViF4OM8xC
	nTQFwBCZTfDdb9RxlBDkjz6pdghbt5GAOLDPng7Qeu6CB0EuepqvYABhHHe25Al7
X-Gm-Gg: ATEYQzzXVfnlsltFH7JTonEOFvP+/5SSPzbYkze682ZU71v2B3adJW5LVTywUBtCb0B
	8pkHaZPX175E5W9MZhFdQ6qDonSE3JsUAW3609hC7Eb1ihJGKjuNpeZtnFn34bquxuWycgms/Hq
	bwxqEB/ew0Zy2mPmyX/GEr4QuPfA+Lhtc8lXfCYHCu1+VKcfoKIyyiZdP7L0xDsqHbG7LRTvedD
	trwOOutmlofg29hqL2NwTG+YbKO5mJ1dD19JTK88CwQKgvrTxOuxf2rirf2vGeJnWdnHiQaJN9S
	4yp4JpPs8WvVS5f+OgINDFLKkxQZEmQji8QsvWLqktFUupqdStKjV4vbEHQD8kzRkJoVgUBDz6O
	HRF2LaqvhRiwpSHmU3ub+DYayotXmtDB8c5cPZxvPo24/Uy/ZgGDKsLpwlJ4FWNjTyknL5n56nW
	Px1a45Q4QVC3HW9LE1mBNqnW3RQCfusFWSFyviZl7OT/11704YGtM=
X-Received: by 2002:a17:903:1986:b0:2aa:d506:d189 with SMTP id d9443c01a7336-2ae8242f5a7mr86073465ad.34.1772975205904;
        Sun, 08 Mar 2026 06:06:45 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:1163:666:eb8c:915f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b2e9dsm108663615ad.85.2026.03.08.06.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 06:06:45 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] tools/sched_ext: Fix get_prandom_u64() prototype
Date: Sun,  8 Mar 2026 21:06:38 +0800
Message-ID: <20260308130638.719915-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In C99 (Sec 6.7.5.3), an empty parameter list in a declaration leaves
the parameter types unspecified (K&R style), not explicitly zero.
Consequently, the compiler would silently accept arbitrary arguments
passed to the function.

Declare the function with (void) to form a proper prototype asserting
it takes no arguments.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index a63a98a96b86..99b1a94097e7 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -621,7 +621,6 @@ static inline bool time_in_range_open(u64 a, u64 b, u64 c)
 	return time_after_eq(a, b) && time_before(a, c);
 }
 
-
 /*
  * Other helpers
  */
@@ -870,11 +869,10 @@ static inline u64 scale_by_task_weight_inverse(const struct task_struct *p, u64
 	return value * 100 / p->scx.weight;
 }
 
-
 /*
  * Get a random u64 from the kernel's pseudo-random generator.
  */
-static inline u64 get_prandom_u64()
+static inline u64 get_prandom_u64(void)
 {
 	return ((u64)bpf_get_prandom_u32() << 32) | bpf_get_prandom_u32();
 }
-- 
2.48.1

