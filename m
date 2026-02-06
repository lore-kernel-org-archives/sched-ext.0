Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD9B2D9782
	for <sched-ext@lists.linux.dev>; Fri,  6 Feb 2026 04:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351545; cv=none; b=JQxvWGgw6KA8nCd8lhhn9vk26v7Qb75XONf+1yBtZsXtdA9GdHiT39C4sfkty+rp1HB2alyALLeHHJ+IRzhZPVHYuegI54ca0AgEMZodZicMer35GBZTkTWP4CDpX4CZTVX3ABJPYOPJJNXX7LPaVFx0dP2dvqcyt77xD0MMYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351545; c=relaxed/simple;
	bh=vvEVKjJCtQo4nmuo3z04CydsrpGhwrX7+I/UCM695oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sm6KCRH0z1bSnVKNV2Bp6NdscWvsogPbnKB2R2ppj9qB7638tY4G11LwILkr8zAhmE3qErHBwGMKzrsmCANWVkPPTYvSmfeoiyP0rXhXhUSJADbYkgBFCtj9/PHYJYzVTG5WMGHul1FX0BzFw6A+yCShA+qPRr7y+LdQ4e4MhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhV8VST1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhV8VST1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a9296b3926so13193705ad.1
        for <sched-ext@lists.linux.dev>; Thu, 05 Feb 2026 20:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770351545; x=1770956345; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NtxdwbyBhJCjJN9Ud01S5+F/PCx615rL1edEy0Sb+qY=;
        b=KhV8VST1JTSR3IZr97oa4ryfJ+wz1zK1axzAPdTlFQoDfzfn/4vxHFZegOVqbK4ET9
         vojjM8ceIHEX73SHqKLHPuD7iThavmlcqC7Hb3pXItuRgC2v04EtvoC8D96fErXe4EpZ
         6ScwLZcs7hQxkQ33YCx+1NReW18pZzUogbOh0a5rD5e9ykMQNfug09A2vsXha4XwiFYP
         Tkgj15Znwilwbh7oQSosI+1OnmkjbsFBIskXNwPrmiAskEl6gnXAbA3Eciorx/FSVsN+
         bo8eElL6XMv8wB+GS0i0ft/Oxn9z1liXVhrZnbYrqgZrXrHo92PuJAdos8TL/E2EhT++
         A09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351545; x=1770956345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtxdwbyBhJCjJN9Ud01S5+F/PCx615rL1edEy0Sb+qY=;
        b=mzHizBzZdvqJ2QQQomCjE+9yWRj1anifMwhNHtRdqsr6ZK6EFmV5bBkfFnj3uKag0y
         DPSnQm6hCEkIM0UWHXwPqzBglCmB/xeZmIyk70UrUD6BAvP38TPI3uYYqKoV9GQLgDhf
         pzIzGtZOIjoJKL7ArBwgbUcMgJHKfoVxohTqhBpFYwFsYAWppZEswgZj11fNNivk7tei
         LfyD2ifLYM30/359zPlkMxNzO5v7JiUjMJO6GNLpnWSkpmEmQ7HMGz2H4HVfGXpaQ8Kd
         U7NbCED0NgfKvlCQ12RmUwZgXCvosDxDFeCLiWWTsS4hnp1NuA2cFAEjSsbYDjwd+qv5
         yEog==
X-Gm-Message-State: AOJu0YyfKB5VitXQTp6feme/KYPMIou8UklRZu0QOHEkv4y/JUx+RqIF
	2YJ7zHNw3nxJJyI1ApwriF/64dJE0hQVyvAa/yOZE0Aj1AMPrBL2b4+X
X-Gm-Gg: AZuq6aIoM3IIlVd5dOhvBBMyxsM8TF4ljuSz2UYrjaTOE1Wxko+yCDCbpb4TX5FZaCQ
	mYRC+7at0Gttx6VITUcRYxaGqWLtUWfSk8x6c2N4CrLyP36gWH8fj13ZCkV2wKPZ5PFudxCyt6r
	g7jSRJNnDuBAZbVEoZJOef36FZfE8S6PR7y/qmmQQtKSkeyP9HjdwxFTJbtuWbFk65bxPG9VuSD
	MGuwl/LjTve1ZKJ2d+OFXuWDm2fk+4C/vH7ZoZzuYfclBnYePpuKU6WA/gx0T4hu0EjK+ssZBr7
	2OELrbApov/A5lh1VYboswaJh+I9JqwmMIWjj+j/vLc4GhhwSTrP5kGppSpP0r25fgqgEiUjRjS
	H8Q2+yiK5sI46eu3QtVyj76abWeuO14dl9aa/gBoNkIR51jw9xVhLSQUqE+w1NdLIMEN4gH/iEz
	dqO2fOpFCq4Ted5o/HLWDVhc2zbJ+j1WID6AC9Q99AkCfdjpbcOqZXK4od3Spoe7l6mztKoipUP
	w==
X-Received: by 2002:a17:902:eccd:b0:295:86a1:5008 with SMTP id d9443c01a7336-2a951709bafmr16003355ad.38.1770351545074;
        Thu, 05 Feb 2026 20:19:05 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a6449asm9291985ad.3.2026.02.05.20.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 20:19:04 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suzhidao@xiaomi.com
Subject: [PATCH] tools/sched_ext: Improve BPF verifier arena detection workaround
Date: Fri,  6 Feb 2026 12:18:08 +0800
Message-ID: <20260206041808.170926-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace bpf_printk() with volatile access in scx_sdt scheduler's
BPF verifier workaround to eliminate console output while maintaining
the required LD.IMM instruction generation for arena detection.

This addresses the side effect issue of the previous hack while
preserving the essential functionality needed by the BPF verifier.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/sched_ext/scx_sdt.bpf.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
index 31b09958e8d5..13d3060c99ff 100644
--- a/tools/sched_ext/scx_sdt.bpf.c
+++ b/tools/sched_ext/scx_sdt.bpf.c
@@ -64,14 +64,10 @@ DEFINE_SDT_STAT(select_busy_cpu);
 static __u64 zero = 0;
 
 /*
- * XXX Hack to get the verifier to find the arena for sdt_exit_task.
- * As of 6.12-rc5, The verifier associates arenas with programs by
- * checking LD.IMM instruction operands for an arena and populating
- * the program state with the first instance it finds. This requires
- * accessing our global arena variable, but scx methods do not necessarily
- * do so while still using pointers from that arena. Insert a bpf_printk
- * statement that triggers at most once to generate an LD.IMM instruction
- * to access the arena and help the verifier.
+ * Workaround to help BPF verifier track arena usage.
+ * The verifier needs to see an explicit reference to the arena variable
+ * to properly track arena memory usage. This generates the required
+ * LD.IMM instruction without producing unnecessary output.
  */
 static volatile bool scx_arena_verify_once;
 
@@ -80,7 +76,11 @@ __hidden void scx_arena_subprog_init(void)
 	if (scx_arena_verify_once)
 		return;
 
-	bpf_printk("%s: arena pointer %p", __func__, &arena);
+	/*
+	 * Use volatile access to generate LD.IMM instruction without
+	 * producing console output like bpf_printk does.
+	 */
+	(void)*(volatile void **)&arena;
 	scx_arena_verify_once = true;
 }
 
-- 
2.43.0

