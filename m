Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BBA2E0415
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272482; cv=none; b=gbVNy74c40ucIUW1hw5BhGgq1JCGdR929f38A1H7MmRa4fXYO/5km4NW/Dic5Q9p06oPF5shRHCGAEB1WJVeVks4XUaTiUkytlL0TumZZc7PBJGZyhYz2AsZWE35ZCYXr6WTxqprnYJoyGzRCZcfzQMBFgpMfyvDYFP+WwVQbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272482; c=relaxed/simple;
	bh=UdzaojP8tKd0ecBjWOZHcfQaUbONvA7aYyLCoqHYuV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQlaYqsbTLdXqardLXkTFaNhUxZFWbq3peqrG+0AvJpf0dd8y21Sc3fEe+j7DeytaRwxqCNBbqEG9KqfR0q3iIRX53mexzz7APEGYQbVsXXmph/1yDti+ZwSbK8DEe44wYWIAieDxAwPXSpg5w1sBg0fvFJ4aW6FrAmyc6VXcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln5ASkWH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln5ASkWH"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747e41d5469so6980686b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272480; x=1753877280; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KA3PaYZqt45yq14yKey30D9sblTtQ/6geKWCore6uU=;
        b=ln5ASkWH1r7fQne4qO55Fd37PXmGrqbrREWskXHp0labId+qdUP4MY9vaqHQilnEmi
         sfJDeOVTH3i83voxVcNOp90nJJsGeCHjFxIjfveMUNLZc89F670KE0dU5lEiVfwIjcDN
         1EAOVUoqYE8OhtrAJ1BTNQRz+Yfj+KqM9/54c0mHqepSWxofG/shsAauxH8kYWCLHYES
         T7cRbyEB5/MQ7yn6LGoyCPiybKk0QxGmwxLFIw2SoIESXBFLj8vPxX3AEynaSWGncH/9
         cAHKQKJCI/u5m5tJTIUszssLDEatfhuSCm1Ll6wMmYoL7O8PcbyK0hzcY25BrO81E1bV
         j68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272480; x=1753877280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KA3PaYZqt45yq14yKey30D9sblTtQ/6geKWCore6uU=;
        b=QIwr2q+CKjhWXUNRPZ06pKNABpSqSOemgMqXyRm1SWhrXPu6NDNq8rBmcrc0GaCwAi
         XSO5Z7ZvQVal/HLnpidGhaLpXSfysuz4c0nO12Sr8veX/MK7FLGDVDVdFlI0slQwVgPO
         9ymdNXan5ocgifRrFhIfSabGTs9DTdAuz29mmQjCVxFN7Mias2xZbvseIWikdN8Jr3or
         ID07b3//Wnd9ttbMVVyewiMPxtMMuDARPaKuML24YrWyrQxo9xfh5CQYoOv9xozaVyzr
         FD+k/hn24RGvi7We9ljsIcGU6z/3apKXTSG6dsH8y8Fl/L3lYtPzo8ZKev1igIgjhqEu
         RB5w==
X-Gm-Message-State: AOJu0YwomUr7XUxrj/leMGPi/6ZHgbB0BtWXTiADZNEwUVkaBt6S2rhG
	/HwqJSRxpoj4SFGqwC1Vv+R91KVAwTsxHGbCGv3GnzvacfS9TMpkY8OpyyHjbGmVzfY=
X-Gm-Gg: ASbGnctdYwF3UK2XMCtp7T6/EyyS/jHefBTT1WNftbs3ew9u9CiU0DulrFuIOSNy01+
	T1AMGJQ8lIr9lfHNHGgXFssiRKU9WCBUTzEBzE1psy1FzfPn4RfZRrcXzZ5zsap8Ps9rkjHGWyZ
	GaikVaezVqrv0lCJjWwqQ1auFYZVJ3pdnC2mPxlzzp7flP4Vl2fBSnFzSK7EEMuOB5XplpKwHs+
	A62Am2v+8bJn55RTx1JYMgUqPA7cSlOqA5+QDtQHON2M2siHT7PwfdrwwKUcIEnYAPLNvLFOwDl
	Is14O23WK9WUm9ws0fyx39CHTQ++NmXDc3rvNkoW4KK/nOWq4lkkxJwBzfgwEdVeZqLGU7Cz608
	8BvFJ7vya4l69scLEKAaVEp9Sij7LOsUJaBafS/3kRsqNbDyOFI4O
X-Google-Smtp-Source: AGHT+IGk/DeGI5N0JBIHwfgmsFA9TLT7ruUsQrPXPEuPZ+y2H2UTp4nbTqSO64RSYALscudzAKgphA==
X-Received: by 2002:a05:6a21:10d:b0:220:4750:1fb1 with SMTP id adf61e73a8af0-23d48fdfd32mr4586044637.4.1753272480104;
        Wed, 23 Jul 2025 05:08:00 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:07:59 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 04/10] sched_ext: Sync with scx upstream in tools/sched_ext/scx_flatcg.c
Date: Wed, 23 Jul 2025 20:07:40 +0800
Message-ID: <20250723120746.52847-5-yphbchou0911@gmail.com>
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
 tools/sched_ext/scx_flatcg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index 6dd423eeb4ff..cd85eb401179 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -6,6 +6,7 @@
  */
 #include <stdio.h>
 #include <signal.h>
+#include <assert.h>
 #include <unistd.h>
 #include <libgen.h>
 #include <limits.h>
@@ -137,6 +138,7 @@ int main(int argc, char **argv)
 	skel = SCX_OPS_OPEN(flatcg_ops, scx_flatcg);
 
 	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
+	assert(skel->rodata->nr_cpus > 0);
 	skel->rodata->cgrp_slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
 	while ((opt = getopt(argc, argv, "s:i:dfvh")) != -1) {
-- 
2.48.1

