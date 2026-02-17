Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F42A2C2346
	for <sched-ext@lists.linux.dev>; Tue, 17 Feb 2026 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313171; cv=none; b=qgaDlvuH+5U7SyorYibCVja9oZ1+ncLDngfj1jZrwhhZAY4I6xiVOx5oW1Ii1YlnxZsCorjgXgBnX4oQZ94bZh7nrB99mdWxWX1wUT/XLMSv2bPYPmL5AzvzqZJrOEMvnabL5DCHHRflYH8hycIulm0J2+mx+aueWeaoTpZY6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313171; c=relaxed/simple;
	bh=gLXyC184Mr6qrOZDcvJ/Tw69QpddNemhW7wz+deMPNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeaQmRSW1ZkhgK1vSqNTfqhJj39SV8A1l+sGLG6TruF7GI/ZVGEHc+S6iLHMqmUTTV7HTqlsQ9VFHxkmnNZZ52H91Cfk22ExL816fyzAH92W+jfx0gKbtzw9tqNQiq2yPAWjjMOfVEVXYPaTq/4BRUt6fJpk9Gaq9prn2dPsb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAFkNirH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAFkNirH"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7d98c1879so20513325ad.3
        for <sched-ext@lists.linux.dev>; Mon, 16 Feb 2026 23:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771313170; x=1771917970; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1g9G5wllI4CvIF5yyBw/O9capOj+XlyPuXvKw3iH98=;
        b=cAFkNirHCvF03un22loBnL37jhyYguLbU34paQ2bPkK3Ct8t28Fx41gPlZ7Ef4yOiE
         ml0cBojLvixZ0P+o7LIPBzrSWrwnSNwBsG6APIRIFPPMcyTv8ih9Z6t5bMGlV/w29J/N
         ydoKxmDFyGPkQBZtSYhVPQ/VzBbsjSfg1BtF1Eb7BK+mx1bZEb/gZYeNDnNQ1mnhwPiO
         d6xo7RJV6OouuGQR4cp+bD6jElwhfdp/VU2x1w9LdKdQA5J4wVDScVQhK9FDJtikFT81
         bQIbVH1c5RGEIrUYz7QAOXt/M1m5LqEzQTIjAZc1ML49SwLjJK7NHqPtJN/Igl78hSML
         dp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771313170; x=1771917970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1g9G5wllI4CvIF5yyBw/O9capOj+XlyPuXvKw3iH98=;
        b=hfCqe8uBmwzyOO60uaeip/mvxc6JePBYmljviQCc+TUVn+uDLwvJHfYcvp1C8273/C
         GSOBo8+qhIfsdFMrDiVn/udDHVexkk4n5vVVemBMS44aD7UzPNQ7FeJu7GdLdMWtD7Jl
         WMyZpDRkoIWVI8WtMPA8zmiLom1ZKzopUGt/XTAIGTvVKoRHUx6KPMzbRlaJLEDgm3+1
         QADK6boJnF0pSWEmQsisJlofJZW7xFgvo7k0qJ31iqH56frfV8G+X194KG7xX5bSM0W4
         y90LJ13rvOZmhNL3Flffvdj3F/DoUZk2HBxeHclVQeLphCskqabOpWz+8W2L/JZ/LbRn
         Df/Q==
X-Gm-Message-State: AOJu0Yweernuvy0mJemTnIbR0Zf1I02cvgMG/jBf3gJe9DPD39wnp/zf
	cdBlxhlzU4zMpmLAfumogyR8wsUVTgQpaQ8O2AU13I+M1BRtJdHlvSQ+2aByqg==
X-Gm-Gg: AZuq6aJn7G/NLTSTjoNpzbPyRkOAMJOSQcdfMSTkUanalazISrpuOe8HrF/ucdIhpky
	O1//Z2rkXPeqFYDRWYruMhlCFV1IWAi/lcda/sLatb0H/HbumFg6305EbO4aMhsHFbND2xutQLC
	LEsZGu91Hm0I+1fFYpn45aFdxxsTRU32IE0ZZpV2HMnlsWgZBa8Th8mkoBazM5vfMFqV34Fnd+7
	iyx45GoqVGRbexNEhABgkBJrp0cvBfUj8xlNEk+3XH2rpzyJXhQmiMnKZT2QK6RRBSP+FV8syYY
	Y4gwOj4SVI/3PK2Y9M3UBAUQVELyKLgEXTKEqD3gzbmTMspPQlflm3DEl/Hi+l6ufUhC+OTjnTp
	OQU1XYINOVa1EEzej5cfBACWndG/twQOgrWc+ZSDGYDt0zps0A2w5drBIiz8+fZYDD0akrVUCYL
	UybcRcS83M98rOhuoKVrxPlF98+664qJc8zatVlJEC/2erNRS4Ukps
X-Received: by 2002:a17:902:d511:b0:2a7:c2d5:bcd7 with SMTP id d9443c01a7336-2ab50560d51mr141806995ad.20.1771313169804;
        Mon, 16 Feb 2026 23:26:09 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3f49:4f7a:a0d9:2554])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaf4b31sm85528405ad.86.2026.02.16.23.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 23:26:09 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 1/2] tools/sched_ext: Sync README.md Kconfig with upstream scx
Date: Tue, 17 Feb 2026 15:25:59 +0800
Message-ID: <20260217072600.953197-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260217072600.953197-1-yphbchou0911@gmail.com>
References: <20260217072600.953197-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync the documentation with the upstream scx repository to
reflect the current recommended configuration.

Ref: https://github.com/sched-ext/scx/blob/main/README.md#build--install

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/README.md | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
index 56a9d1557ac4..6e282bce453c 100644
--- a/tools/sched_ext/README.md
+++ b/tools/sched_ext/README.md
@@ -58,14 +58,8 @@ CONFIG_SCHED_CLASS_EXT=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_BPF_JIT=y
 CONFIG_DEBUG_INFO_BTF=y
-```
-
-It's also recommended that you also include the following Kconfig options:
-
-```
 CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_BPF_JIT_DEFAULT_ON=y
-CONFIG_PAHOLE_HAS_BTF_TAG=y
 ```
 
 There is a `Kconfig` file in this directory whose contents you can append to
-- 
2.48.1

