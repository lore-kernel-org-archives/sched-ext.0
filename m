Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB198BE9
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776749511; cv=none; b=kyvZ16w1V2Wq+tjKsEsJTl4ymhE3BLrvOw+O+ZLm+LP4B1yuj5am57F9SMOUmgiLq4G5ho3Pwl+rFo17SUZlVm3guYGvxLJWK8ks4R5OQlZt8HO/ZWnRe1w6r8bWo02K5TycsWSveUXBVzeSjR6fw2+gtTTVOOpT1i12u9R2ZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776749511; c=relaxed/simple;
	bh=2HCVv2dSZsipHfm0yWUw3bDddG41iTSV5zAt8Joapww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0TFDBuD+ogOM4rVE/5nHuqz1LuBV4fZnwJz2FM3yDgJnN9eNh8+GzE5tgZKKMwmffwpg/6nJBxckM1VmPImfzsO6klvwzu8Ug+ZTdoT1Bj26mmAmVSL+Escv15SzQ/JVnPPdTgqHWVD8T4MsEHLra396J9lTvef1XEhnMSvraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck5SdwHy; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck5SdwHy"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7961d7bc09so1372425a12.1
        for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 22:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776749509; x=1777354309; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GeHgYd6NE0SLxNVac9nFPJsVzaOzaH3R5Mtf785+xSA=;
        b=Ck5SdwHyrBMYIKrVR1u1nejGUKDuR9sKx/gETnBr8VwHAxvfbEdlr2OOdN+FlUn2c4
         7/UjZp0jEd3dBAeLmPx9ywuKBoXWRx314C7lYkrD4YN+smoCfhdhcyb3TkfX1LgYhpk1
         2LiZXXqm3tugTZb9tBPWXDeOIx0KEpn04zhOLBsyP8wBKxfxXt8ql10Oqfnw8tB3ZrHs
         iJBWdS39f7bZvbgzweosguV1T0tuoAC5lB+kSgKBzynXP1rcCL42Y/vfY573zCajcwSK
         z0diWAOjWWEDesOAdI1vseCIHY38yn++o7N0Oo2A9ZX66uvULO73+SNxmzq3pVmE/H0R
         yCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776749509; x=1777354309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeHgYd6NE0SLxNVac9nFPJsVzaOzaH3R5Mtf785+xSA=;
        b=AiuhjERiv9dLc+H4fuxc4duEIqKFWCyonde3tMjkdcWpOxp87/0VBaLZTnc4jSqHIg
         39nvf4eaP/ewiZkhtrxS/EMNhgplCbWBn3JZIcGahAPLMmOZYItbuppdlbrXmO1brSre
         HBhCYnck5feRNFV15+2KAPLABqh9hgN3jo0baDJgWILkLae77dBEPnu2buNni1U8MrDH
         ckRflTMQp/ak4LRnvIorMd4l+QsrYpNr8Gg1y0L0bsZ1GBedJT9ronNRiQIKk3OoYode
         o/4kMB+TL6cI6pY1eCzebkYbajgs0/YJ+c8F+cuGq2NxdgHAyqn9RI1TERD/eenF0+25
         +cqg==
X-Gm-Message-State: AOJu0Yxdo7s8JfgbpSi32p0/cYts7OUVdwKi2YxGuwUfpSdlJuRZb7W+
	D6oroX+KfEJ87Y3X1RwJY8G/LmMPk+0aQYjTeTiAmrZLawwZlupvbdb6JWhcsQ==
X-Gm-Gg: AeBDiet10GExCGIxSlslVh4ZpazonK9fuuo43FatqtqhedOwLtbIN+Q97N4JGK/UYcj
	ugPJlTEpWqvTRwEuqtNzi59L2F0Nhy3WjhIwlQGFJFVjLBSHmRo3IcEUR8nnKqGsAI7L7jDE3Si
	fpP3H6Z/q90UhiCMb6F1LF7K5K7RqLDDo4DyTevTchex/VN7vfy7NBhAwWkgHbuTbp955rgUoGf
	exIwHJSfSwf8uydMRuh4uqQYxM7vrECuOtZ6A9fWFW2y9Og4XO1PibiinERhroPTukJwrBRxRu7
	Y0hV6mF5haoztayMcfDWPydc6Gotw4uMK32g9tMM7qIUee8HrftpEpVFJA4R5rMb2MCfKWtboNS
	0BY7W3WVKGDSEISAZZsu5KH4XToBynYzIO+c8ILRHli2aXW6lAENi+gd7W5+XuQaTpMAbeqKQEA
	1T5eSoNqmUFDE+atAArCYbnORyKEsU7TCci4+gthCJFtbrtc5wZY2a3KU5CzHIzQ==
X-Received: by 2002:a05:6a21:3288:b0:398:6461:688c with SMTP id adf61e73a8af0-3a08d687640mr18647562637.2.1776749509362;
        Mon, 20 Apr 2026 22:31:49 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:21f5:5215:464d:5ab])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f356sm9438559a12.4.2026.04.20.22.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 22:31:48 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.2] tools/sched_ext: Remove unused nr_cpus in scx_cpu0
Date: Tue, 21 Apr 2026 13:31:13 +0800
Message-ID: <20260421053141.550803-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nr_cpus variable is defined in scx_cpu0.bpf.c but never used in
the BPF logic. Remove both in BPF and userspace side.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_cpu0.bpf.c | 2 --
 tools/sched_ext/scx_cpu0.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/sched_ext/scx_cpu0.bpf.c b/tools/sched_ext/scx_cpu0.bpf.c
index 0b1a7ce879b0..909d1be1bfe3 100644
--- a/tools/sched_ext/scx_cpu0.bpf.c
+++ b/tools/sched_ext/scx_cpu0.bpf.c
@@ -18,8 +18,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-const volatile u32 nr_cpus = 32;	/* !0 for veristat, set during init */
-
 UEI_DEFINE(uei);
 
 /*
diff --git a/tools/sched_ext/scx_cpu0.c b/tools/sched_ext/scx_cpu0.c
index a6fba9978b9c..4966e3d4c724 100644
--- a/tools/sched_ext/scx_cpu0.c
+++ b/tools/sched_ext/scx_cpu0.c
@@ -72,8 +72,6 @@ int main(int argc, char **argv)
 	optind = 1;
 	skel = SCX_OPS_OPEN(cpu0_ops, scx_cpu0);
 
-	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
-
 	while ((opt = getopt(argc, argv, "vh")) != -1) {
 		switch (opt) {
 		case 'v':
-- 
2.48.1

