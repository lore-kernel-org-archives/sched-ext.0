Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E711EB5F8
	for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771765717; cv=none; b=hBrXle9vwZdvTgfjb7LBC52yy98WyopF0F1MlUnciIN55M4TmbwWMYK3J89BYUBywCq651mOvu1m4O1exiCXhytM5377WSHPUIoAd3bOfSSpmYX2tTzVePwcPult7sq+J3+DrohtdF2mGQVsixgGddQw4vrLp6goClxOkCRLplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771765717; c=relaxed/simple;
	bh=093W+aBFDSsGozCiLRITQTRB/Q1wSgOb5Php984e3MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX2LJ+Bpcg/8G5ASS1uxTSsVZkLvVJLpcDN0l1kZI82tw5uvE+Pxq2TL5Ff46nG4w6GGY+4Yf2AjLzRuyOGUXFucQO+le9SNOEsyPDaTVqayFu0AKTDmbJop+unD1Y9LJ9g6RxnyQDM91m/PtJ+eRE0fSaM4GaqxcxsGU2tNpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8D6bXnB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8D6bXnB"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad21f437eeso24449545ad.0
        for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 05:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771765716; x=1772370516; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujj3Hu6gUFnY9sYjUY12+YU8loRXQ42zO9RNeAwGRv8=;
        b=d8D6bXnBOxgHGKaEpAT7ZizVDqyFl+SB2cRujhA9Btfp31iVmgA+Gn3RIcd/uNnJAN
         MPjXD3+X1Xa4ZdYHwChv8cOMIUihtuoenMxPuSqMh/myxQ/4bos7Y5xeYJ3fV1aNXX5X
         jv5otZQxiVCDOluJc769+MLkHYuVnLtdwz6CZXTzaGXDGymQUQw9hIn+fims2CqpHcSi
         ubbw6zzgewlIyAmqLbsjze3R5xuUo9rlO+cAAK4w6610yLGkhYD6X1LhbS2xWK4X1cba
         2TLPCr5iQMGrBjatOIP8BVkqkVP88JgzSOiUzQ8jvb71kDnVcrl13mnH6NrKlA+XbICZ
         zBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771765716; x=1772370516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ujj3Hu6gUFnY9sYjUY12+YU8loRXQ42zO9RNeAwGRv8=;
        b=q3FeWlo/eNHnJrcbpuC9DVQdiaAzFDmvbtb2hS/LaN/g3V/oxoYcE/ignEOLZfFl/8
         OEod05QpMQw8bct2pzxSEX0Qd+fnMUKSmmWLqKWYbdvI0pLdu8/VBFB3F37Sp0xLizMg
         vA0EZylmfKEhFERUsqP13RXNvlyH/1DDS+9JqeRb7DGQlV+RqPXqIP/mllOOyAI+IH8E
         uuSdLPXqC5IaerWrydYpzCwOMUWycwTZ21VBA+p71wGoOYmLbSlAgyYmH/1YlErdlWZo
         lVKdLNu9oRwkI/HmDsgD6XhgfB76wYacjPiVOFUIt28+wBA6uxxDsifGCX+x7bMKWKgv
         c7XQ==
X-Gm-Message-State: AOJu0YyLPQB79S2E6R8oyIIKyKIhFaO6LkzIAteQ90+ZwjoswdYfaSdi
	p78QYmv0Woqp5YgRBJkLE8QeR++RbKmGonOoQBf9g+I9Zrj8KL99KVLPyYj+gw==
X-Gm-Gg: AZuq6aJtV6V9yiRWmc0pwpe/ty8OHRq/QpUpUVjsVsd2LaOULAgs//EEMq7nD4BSmM2
	HWP4wArNdY9VYymsAliMoF7FstEduQauyyPTe57c8i5h077lAZkaLQMVICr519ElR0rD8GxbbL6
	FIownmzz3Osz7OPDi7K2LT/qPQ0dqGE1aAvgAiNW6hMEkslNUqeReky1oPo/eAYYDAMMPCZAQep
	0GGTpnADZL1BNxjzx5BwDw/Lx6TZHruG9KVtCNElVNv9epcvkLIE411J8JtlhwksIqLNjIcPQ5Q
	8DZo+bv0y1iP/oX7YheWpo1uhEbufjeCHMLLKOh3OnfYNA3sAYLmvM5wlJKQAlVxQFBRjku/zJf
	E8X7XDb7lcdq/mVm7HiLu8RWSD2roWqWuhwlLe8pGU5rEgxmmU7S/gfAeGqjusaK/MOxvV4THIq
	kEqiq5HHnU7DnD7C6kLRzTpAff6QSYsGAO2n64K6+yIHWOW35PHfMP
X-Received: by 2002:a17:903:19f0:b0:2a7:a6fa:eddf with SMTP id d9443c01a7336-2ad74284322mr56167425ad.17.1771765715919;
        Sun, 22 Feb 2026 05:08:35 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:f3c7:b896:5ac6:4be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75027b0asm48433865ad.67.2026.02.22.05.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 05:08:35 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 1/2] tools/sched_ext: scx_central: Remove unused '-p' option
Date: Sun, 22 Feb 2026 21:08:25 +0800
Message-ID: <20260222130826.37085-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260222130826.37085-1-yphbchou0911@gmail.com>
References: <20260222130826.37085-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The '-p' option is defined in getopt() but not handled in the switch
statement or documented in the help text. Providing '-p' currently
triggers the default error path.

Remove it to sync the optstring with the actual implementation.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_central.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 2a805f1d6c8f..710fa03376e2 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -66,7 +66,7 @@ int main(int argc, char **argv)
 	assert(skel->rodata->nr_cpu_ids > 0);
 	assert(skel->rodata->nr_cpu_ids <= INT32_MAX);
 
-	while ((opt = getopt(argc, argv, "s:c:pvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:c:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
-- 
2.48.1

