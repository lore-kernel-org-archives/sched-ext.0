Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215C2E0415
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272480; cv=none; b=UsNvTmJaM5xx7pPz/ot79BsCpmNPIsPFez3R1kcL97lYjeSOBHWTIf3JUfM17gn3TDNY2KG7gRlILAuaAI5D+t/uBtFj4mv819kIrG6CPdTvVzIkwQUQa3LGx9ERM8BGLVJPP+9dJy7BDgCtJ6BXXMTbsX9PqNiaWA/Q2PzyfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272480; c=relaxed/simple;
	bh=bDdsk1NUpREkm5e8Yt+b1JV7LI4ZhN/KxZa+fF9pf9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7gZcF1feZbm9y722pMgLbilTi/iS9mJKrVC0pKNlpwpJA3nWCsrk+IA+Y4HzDr0ncIsah9x2hPptkF3H2eTZG4OdjC+UZH/FyM2ogKyNdj5VtZV7BqY0ZBborCdNyrWeTNjX84mxsH1WhtIyC1bYNuC6A41VE0zy6Qj1S2LIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUMm31V+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUMm31V+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7490702fc7cso4161055b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272479; x=1753877279; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeSOZmC1fukzQdeyAh5Ku2W3N/XTKst+Mq1rtE3Figs=;
        b=bUMm31V+MBgCQgvXg4StrvOr9MqA58KlrVLTqpuwfiZha9mI8QeTe01+/MGivcnjfN
         jTP8uCR84yfx7bNrGrYFHOrqoWyv8By+M71Vi2FCJpUFKa8EAQ9UkM2wLkrb4G4u6kFE
         rA+d899bFP/KGlRzxiDz1O0GiiQAP9DgYBejUjNBLcTBdg0qyn3aJAHLJZ9EXok3RKMK
         THQKa6RqAzd9VzB9TR2C9T6UaLYzi82w8ocJ2IaKdcRUrgIoqRXedtoXSjAcK6uM8GGG
         K7sVel6iwoccmUxWb6P9bAYZ/uc6MDVPmdcGpuPPx43XS/+zXnHf1nLD0P4zWWNdRdQS
         TSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272479; x=1753877279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeSOZmC1fukzQdeyAh5Ku2W3N/XTKst+Mq1rtE3Figs=;
        b=KfNXGrPeGl8ZXajbdQR0ni/DoJMaL0K3pem1b56KbULhyf07y5JwLDR+aXxdLaiUSw
         +tePGvj6BIZWNkv9ogNLNA+O8Zo46whXilvv+7A2Sp/+gunukjX4istY+e5yjyYPsKuu
         ONJ+ECzsSwXr5iAGHHH0+7IVtsu7fPTit2bHryGWx9/Dfs8lEAO/cOhLLGzqJOdDmlVt
         2CCi6PSLOgFwZkc7mvonI1KpEdiYMfr3czuUCuzB8K8Aie9XrPJ1Sxe6NvO2tFy5GSQg
         /ZmjoLbNRPJNbZQ79D3AF0vojAY0CvBlbbUN2kusNii/fD0W69Dv4qx6pz+534+8+zyx
         syYg==
X-Gm-Message-State: AOJu0YytfFyaQF57ta83VxwRpv2x7UN1vrhnjvNrzWRl60KrzsKFiai/
	6KIj1kWDP6zmwV2NahvBVOgT03VXcpR4ziSQc5phSsyWkHZ1OEs5D+nVvAGygkP2jq4=
X-Gm-Gg: ASbGncvASbezPwBQURe1eyGVyzmOQ4Jcmu7GinNVLa6oQAnPl8uhr1jCuNEt5Vr+cu/
	ykdhK8IFaEOuqLQ77ohTfPHihocm9gdyviCB2MS8M0t2RjIAQ76xbeYdy/PhTSjvHWrmck9YJ3U
	CCqFGbBx5fyxOcZixk8FsxkKF81pmAypYWcKA3Qi2mgRZ03or+dI/l7L/4laauml5vrbCGuXYuZ
	l9YJ49IjBHa1w88lY1qyQlh6xHIA8VdCHTHSC/74SbmismZNjVr2BgDCUyN84bmh5pGjbsz1bQu
	ohpH9P3H/SgIVNOOOpU/aEMW6K7ET7fSY5i8q8rgW6nhj9Yc2ztBDUyv+8Z7A7F0x8ERgt4lCjI
	GAGv1Odp8GAp7633LoSiIZv8lxVsRZQWW8NuvHOxrpF/Hm1cEW1Ee
X-Google-Smtp-Source: AGHT+IGcu9sZH3wJXA1unJQI5Tx73tN2CvUVrscgg7AErWS2rODLwhg21uPz1A7dXABLD385u7/Zig==
X-Received: by 2002:a05:6a00:460e:b0:75f:8239:5c25 with SMTP id d2e1a72fcca58-76034c78fd2mr3648785b3a.10.1753272478422;
        Wed, 23 Jul 2025 05:07:58 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:07:58 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 03/10] sched_ext: Sync with scx upstream in tools/sched_ext/scx_flatcg.bpf.c
Date: Wed, 23 Jul 2025 20:07:39 +0800
Message-ID: <20250723120746.52847-4-yphbchou0911@gmail.com>
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
 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index fdc7170639e6..2c720e3ecad5 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -950,5 +950,5 @@ SCX_OPS_DEFINE(flatcg_ops,
 	       .cgroup_move		= (void *)fcg_cgroup_move,
 	       .init			= (void *)fcg_init,
 	       .exit			= (void *)fcg_exit,
-	       .flags			= SCX_OPS_ENQ_EXITING,
+	       .flags			= SCX_OPS_HAS_CGROUP_WEIGHT | SCX_OPS_ENQ_EXITING,
 	       .name			= "flatcg");
-- 
2.48.1

