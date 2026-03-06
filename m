Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3D3A640C
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805813; cv=none; b=O3qeXhb9RjUWxTEUnWidEn+UrQvYx4byHmYJ8pi+3pla1FC6+Zwtu8XO5Ih8U/ih5RpEcKIjcxaA+P1lhT1eUu/g67O3wUqFJjSD2YCNK0uizjBT82t0On2GPHsUPam86olRhz0AqsROqVGAvGp9E2SQMIZ+6xjpzSJ8jbPx/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805813; c=relaxed/simple;
	bh=yKSrxm0w7R7rf8DwTeSORUdpLC62zlDW3KpKzJo1uZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HofnAVdCSo3JXeuO28bOOBUda7xiQ/bSGXZZ03UvMoYjJmW+Y5IkyZKgnVt6Bn20L7vJPXgD1z1TZtRVtPjssypHlvkffdKoR6MclWGI/bmp2cvQv/AhugM0GSKcdwTiXZTxAnTZ57VaWsYF6LoNe13gnrlNCgbuLkd8gEawuE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB1qruXC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB1qruXC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae3a2f6007so47606985ad.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 06:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772805812; x=1773410612; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InKX+d5TOMIn4QLgyy6Fu4JN4MhM87tVHkjnRlVwYog=;
        b=EB1qruXC2I2QJ8uYN1Wm++rXNjCWLA51W+FGuayVyXpXHrUpLdabgKhixvgGqxZdYE
         821rGGJuYA+mvTfX6ErZp4IVCS633ICO/8zedNd5m3QMAMI3FLM3/o6cTy9gQG/RzynS
         iNqkSexGbLLHqx1rjn+Hhlt79oLSZKZDCdacL3D67DphDRwOXWliTtHRiSEGAYrAG8vt
         I//yFUju2mr2a5d1u1Hl+B4c19rutMKkQ2QCaasMRrLmt2PPtCS/phMwarhg6a2cHpHs
         bih+WH4uSYnC5WqHLPlHgIkL+uxJIX70bsGLksmTyqrc6BdM4xgaq9BLKI7nI8106MlE
         hmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805812; x=1773410612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InKX+d5TOMIn4QLgyy6Fu4JN4MhM87tVHkjnRlVwYog=;
        b=iIrUtj4wqb6kTQbF1PXYf+czZeBYuryztXekhMhvZr38jXLhU/DQ5MpazAYSTcv0fN
         N2ETsIxNv8asyk3BgcgHMnl4TV+NUQOxC0z1++nPHCBELEl5zt2JSSqjahEgk4ZJilPT
         G8CLSKZLVKVdb9T72gYB/huUefOeybmgBaoFvuANnqME1vceyiO7jDqAmrT3XEgiUjUh
         aymc9vVaFsijp42mR6tMzY5BZwgK4YclPFY4ctZL0o+EPNmGgVWzupxmhBlj5yoRcvxn
         pulrEvWs04hHulOvw13P/JR0EkFfilIenedgyzxD9g0lvZRsTm4/KpMCklM9Qpbpcfm7
         bmbg==
X-Forwarded-Encrypted: i=1; AJvYcCVpLb4CGF/D4XIaPGE0bGi69IyG621fQhfzEX8Qqn+JqNi0hQaGFYS+0aJq9A+3GVuz0tLNlEMmC30=@lists.linux.dev
X-Gm-Message-State: AOJu0YwopRk3t89fJTMohwig8OxYzAWcnVGl9b4RRRGgyi19077mvOEv
	CqSLP3QoGdhXvAuWNTwGrLhu7QzimTw2G1jyc6kcLBik2SzS7fecF3V7
X-Gm-Gg: ATEYQzyNy935svjGjEB0apbe2wq7ireXlaxsKyXhBjBwcj5LstNn2/XQczR+bMDp4HH
	M3q7lZHX4AZ7GAHw6rAfOyqI937Ra+5mkbXDyrxsJIluhKAIoSiSzwDpZ8CuGQ7aXAdWRfWITJ5
	j4j+WhAqXnJPKGvG1zYSYaZEN812Z2UGMzsUqMXjdVN0duHuDLRI943GzuW2z0fhrgNX14QuXUU
	hNRcg0MyGfH9jXwfCelM4bCpgcu1JEoIHGzaVb6ZZqX/nFEtn/QcbmCPA+Y5RYFu7oaBuaCgMSD
	z0q+kASV4w3/dJh/5jz5GnuH1gWEBKJL984Wg8oasWjYWPq/fS5bexvePcowA+Q6qe7tUPZ36RW
	e/twbAdA5MI+CrwK09xWhCs6mbBaS1cohe/nqtEpjTT3rasFj1naNpO6u2EAbLrIxOlMJTAq+mT
	yaIxdMdrfcGzgKYbQWjavqt10p03UVjkquoHaPfmddKKv6zeeMiARIrq764Z0FFljBxj3VRfc8q
	8k=
X-Received: by 2002:a17:902:c401:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2ae82455273mr25656635ad.22.1772805811507;
        Fri, 06 Mar 2026 06:03:31 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm29134715ad.92.2026.03.06.06.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:03:31 -0800 (PST)
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
Subject: [PATCH 0/5] sched_ext: bypass state machine cleanup and selftest
Date: Fri,  6 Mar 2026 22:03:20 +0800
Message-ID: <20260306140325.2710927-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Zhidao <suzhidao@xiaomi.com>

This series does a small cleanup pass on the sched_ext bypass code path
and adds a selftest for the bypass mechanism.

Patch 1 removes SCX_OPS_HAS_CGROUP_WEIGHT, which was marked deprecated
in 6.15 with a "will be removed on 6.18" comment. We are now past that
point.

Patches 2-3 improve the bypass code in ext.c: add inline comments
explaining the bypass depth counter semantics and the dequeue/enqueue
re-queue loop, and replace rcu_dereference_all() with the more precise
rcu_dereference_bh() in scx_bypass_lb_timerfn() which runs in softirq
context.

Patch 4 adds a selftest that verifies forward progress under bypass
mode: worker processes are spawned while the scheduler is active, then
bpf_link__destroy() is called (triggering bypass), and the test confirms
all workers complete successfully.

Patch 5 adds a comment to the scx_bypass_depth declaration noting its
planned migration into struct scx_sched.

Tested on 6.18.7 with CONFIG_SCHED_CLASS_EXT=y; all existing selftests
pass.

Su Zhidao (5):
  sched_ext: Remove deprecated SCX_OPS_HAS_CGROUP_WEIGHT flag
  sched_ext: Add comments to scx_bypass() for bypass depth semantics
  sched_ext: Use rcu_dereference_bh() in scx_bypass_lb_timerfn()
  sched_ext/selftests: Add bypass mode operational test
  sched_ext: Document scx_bypass_depth migration path

 kernel/sched/ext.c                            |  29 ++++-
 kernel/sched/ext_internal.h                   |   8 +-
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 -
 tools/sched_ext/scx_flatcg.bpf.c              |   2 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/bypass.bpf.c  |  32 ++++++
 tools/testing/selftests/sched_ext/bypass.c    | 105 ++++++++++++++++++
 7 files changed, 165 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/bypass.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/bypass.c

-- 
2.43.0

