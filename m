Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70615A87C
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272477; cv=none; b=fTnWNVReDtptqcLl0YKUM22sdLJJyChLgd3mMxG50q9CTTZzVlauolGiyhsf7c9lBhkr2ue+xHiUFiCe6kjMvOEwFPptApbAJHqlUVgCLoxoUa4f7Gkn9hyoRfwwBGOJX3avpCoa1TfL1AWI5bcxZtVdFFFMVEgBcze9rXLCDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272477; c=relaxed/simple;
	bh=hoAPjBcVP02DasM/WmMS61Op5P1hRspy8Pz0u5F9gmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlOfOM0tZvSX/QrxspCPZnSW944K//9EZdH1lnoJA4xnD0r9kvTaLvadL97Obla397uvsI/1eTitPVZl41gwrt2zqoKw/DycSt7CVJDK2soBNZ52ujhe/byeQ39Dr68SIHVkF4f4VyLQ4HslqB8Y9y/1jLRrMIfhuHY0FzKe+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPjnO7ns; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPjnO7ns"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7494999de5cso4468308b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272475; x=1753877275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBiDeo1WTckHdaRFlFvPL390jfMbNRgieZNtVG932xY=;
        b=EPjnO7nsyG2HwXvJ6V6uxtYaX7X6bKtp2ZTRUnNOzCvAgxguJFOW67ljSSsShlwwtC
         XtAXLQTpA+UdOiL/BNLAGDUeKcfKvNbCkrB48p2GNF3J3Twwrpgc4QPaVfuARGBzhpW3
         34RvvkS5UHAMX6+IQh0R3hib4SLKyw+j50+DVCUtAgkemUNWvf9r2QtzngAn8AHQ0pOy
         cNJbAhVu3T3Coj+LgNMiziXmwnT7w1u4fDZQ8Ey1JLiSSKJddo9BiYrGOSFGEBsnK8sP
         ell2tlr9QP0Fo0Rb6lDQcpJ0hl4+GBKnfCAR2NOc7lIhci54p8x6UCL6qN+xdlek0/Nn
         DzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272475; x=1753877275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBiDeo1WTckHdaRFlFvPL390jfMbNRgieZNtVG932xY=;
        b=m+JpZnD4bErfemawJHrY1QhLtWwMqg7l/gLFuBDxZAyLGrRIyKYvux2Nwj/pIRpbY4
         v43zUt4iRRFVm42iUfo/STXUZdR5qzZ402imqcvwyC3FhJjfkfu+EYD73S8C403h4UGQ
         SdFDRNfRjvSAaMJthi0EjyOPFe/GZBhmnA4HN9POVnhXEGvxlik8+tV1UMQgZ0Yz2eqg
         BEwfZtzRQVrtDJ5PMk25bKHrqh6xOC21qF2sHo8n9/H1DZ56uyzirfeH1/oyCRqBKzWi
         r5XOgUXVIjs5lp21FWQjY+FEmrjkqlycm188BniWvxaGpCEbecs5PI++iaZQ9jHZk9gl
         8wBQ==
X-Gm-Message-State: AOJu0YzbybSD0Q0FLq5q+H4by6tuDr2H08COayEqHJDz/qc0235PuZDj
	ZfcXWF7GdrnQuF4wNmDJuYSB1SlzUGG9WrfnX/YlVJUyEUhtNxUd8MVa1+VlDp0M+ek=
X-Gm-Gg: ASbGncvUpCU3Hdp4yWXVbjgRVxmuXRQQiQgeKzr0OF+9EJveiwzRFTRhkMSvjlvxCt3
	V1tXb8pLJfweLLR5GIjf0l2QMHhUZ+McvM5XY4UXWveBLiedtomMXJopah2uHr2hHyYjd3CHFr3
	8aY0uPaOcvoYUAMNOhrJ+y1MwF3lCWPEw7mFOqfnko6qahXnnjr7BViqwOO/NwDALtwo6SIhJyG
	+Y8iokvakl8WTrUyxZT9xFw6DVP/U+erLhuULArvvDF0HgG+3/gNh4VFHfK3etKg5g57AGOEf+5
	TfBXWRVhp8hhyqV6Ea8s9w8L6kt/Vm4Q2NnAGfb/f4C4ScJEfIQUAiP+LUKWVrv6sqUfJyrMWKx
	TtpkZJLpP2GgQg7TNfNaU6/1D8/PeT82upENRlstdbxheCB1eLvPs
X-Google-Smtp-Source: AGHT+IG++41/SLT5ex46T+1R6XA9KUWzZ/lfhu+JcHSSoW/TfR5tmGj+wcRATjryC1UQFBRShYJsfQ==
X-Received: by 2002:a05:6a00:9a2:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-76034c0526cmr3902485b3a.5.1753272475130;
        Wed, 23 Jul 2025 05:07:55 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:07:54 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 01/10] sched_ext: Sync with scx upstream in tools/sched_ext/scx_central.bpf.c
Date: Wed, 23 Jul 2025 20:07:37 +0800
Message-ID: <20250723120746.52847-2-yphbchou0911@gmail.com>
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
 tools/sched_ext/scx_central.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 50bc1737c167..55df8b798865 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * A central FIFO sched_ext scheduler which demonstrates the followings:
+ * A central FIFO sched_ext scheduler which demonstrates the following:
  *
  * a. Making all scheduling decisions from one CPU:
  *
-- 
2.48.1

