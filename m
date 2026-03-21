Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8342FF65B
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774076775; cv=none; b=cmPUUrTypQigdZMl05KvXhkJEb2SIFuXIlDAvEWFdnMURxHyesItuoq/+8aMKGtEM9UKBddNmnBRfDg52FSbuET67dXFPYWwNsHMGvDMntLdK1D56v6N/01K/69W92zZrmvuiOtTN4vQb4WJqhGMHeKblyPnTlJjnLoRr8/NK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774076775; c=relaxed/simple;
	bh=8uuFV7QZa/G3UUlhzZubAEZJEKryz+WS3w+0HiOck+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4E2ziSbnNsApKGu2bCdvv3sl//WKiEutKi3RRPIWudLxcj9/JSs+VNvyHMvBGD6xRb9yW2SAxfDkjIMjqY5clLDb21XvJXsZ0h23hiIl71dncnbE1PXh4mI7hqeO889npzl+PJo3y/Vocs7kchNrMpgtixJG4W2/WN5dp2OD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT4U5SMi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT4U5SMi"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82ae379000fso589590b3a.1
        for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 00:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774076774; x=1774681574; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+E9RzLFtwhTym7kZaUZpBD53/envJOcDPzBdZKPAfkg=;
        b=AT4U5SMiKD28xbEIEkGju+2XMfAC0oQlddEbaad6CW3f6gAsD7CMQL6ciKOy+qCKew
         bVMdcLmG/PRtsJn4W6cN3x3ey34oKjUHKRswWov3FI1iZeXv0lKNQMAmxml3wJs0JxpH
         xtzQDUZqo2CswRMHEuBXOvjZTJGpZHz7vTQNI4HlDtB3PQHJOl0/yJsldeN5NcL0geBg
         4Nd5ZWqBcdRxeLDr/L5URx2ksfwDB+o52anm3jlKhrJkqq5sZd0MiPi07rBPZSyMvfkE
         X4IFFsHQ/i2PIlK9mROgVKafA832ks1e1RJ0N75WtIgirC8ngZTWrIgkpJqH3y2iG7Vm
         8HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774076774; x=1774681574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E9RzLFtwhTym7kZaUZpBD53/envJOcDPzBdZKPAfkg=;
        b=mTfyrrTH3t0CsQMCViSdmAIcdOpgeF328quS6XYq1kwFV4z5i7Lt5z958w6EfqVAaS
         y+brwPOiYZWaeXdka/ewvdG1J+rY0nlf2n3+zOQn9tCTslbSMzT3eA5+YE61lbez1FQo
         7/ZWCayGaAvKbQmTsKJY/vW1R8VGZFXk/jh3Vpn7ghvIco5arh3gHtW/WIyac2DL5lsF
         Q6JtvG4NJ7tUc1ku5dGy5WLJ91Ttvvs9uhUyorH70Y/A+YTvyHE6J6P3YWv84D4p3mSl
         2HgxZ/xanv0QIRuFd92+LFNNujqnp2wW3KuYim3RePGCM1LPZmnUxzCWq9HkKSKAg6c8
         0jnQ==
X-Gm-Message-State: AOJu0Ywx5hOD0LaHx5gEStOntkGI9T7gYQ0ikzQ6bdc8xfSsNbe7aj2o
	cC9QEWqS5JFAmvN+UKsQYPYZFftVonUH24Udb3kTFbhznGL9lJihHjNQZzqnA3mV
X-Gm-Gg: ATEYQzyJ9+ryGnvqvk9Sanfx2HJl75zAG/7O04Nve5u8mCVX6eVg4ZM27a2a6t0wpai
	jGpl9XEEh9mpvqypUNMOaDAn4NjBvw03lRueqQ5X/3e0s34DH4EPyStsUXAEwRz+HB1Sk6nzKqp
	0Xphey93lNYnIxmZ1Qb4TBIG/N81T047UVr8KUhDIVhpOjInCtVdu5QT0DBXAh+G+mqowq3GLow
	gpyYK+Fi0gSXefnmNGwuwekLsi7euzbJkO8TyaqrmkiO4ipri+O6by+trXftWxn6rv8iynQpBg2
	RtMTKF2koDzDrcja5oKa2J7m/Dxwv9dWnJGt2KwcUPIPO6rrh+tHsCcErB3H2+hrWqK1Cze/JgU
	3ya/YVggd/J3fWbKKUjR2Htxt7APnIbqJNID44/MM3YGXMEo5oActpxXmXokhJxE+e/0OIzItel
	DXxRy0vXngWIZwT16mXOq6P9ggxrgEwcSkqm/HBOenqd7KKmHYBkIn
X-Received: by 2002:a05:6a00:4197:b0:824:b03f:2f65 with SMTP id d2e1a72fcca58-82a7a7e5f12mr7106316b3a.7.1774076773757;
        Sat, 21 Mar 2026 00:06:13 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:ccd0:c749:3565:422c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bbebbfsm4705431b3a.18.2026.03.21.00.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 00:06:13 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] sched_ext: Fix build errors and unused label warning in non-cgroup configs
Date: Sat, 21 Mar 2026 15:05:15 +0800
Message-ID: <20260321070605.691776-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building without CONFIG_EXT_GROUP_SCHED and CONFIG_EXT_SUB_SCHED,
clang reports errors for undeclared cgroup_put() and cgroup_get() calls.
It also flags an unused err_stop_helper label.

This conditionally compiles the cgroup reference counting functions and
the error handling label to match the configurations that require them,
preventing implicit declaration errors and unused label warnings.

Tested with both configs enabled/disabled.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603210903.IrKhPd6k-lkp@intel.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94548ee9ad85..2e7a1259bd7c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6494,8 +6494,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 #endif	/* CONFIG_EXT_SUB_SCHED */
 	return sch;
 
+#ifdef CONFIG_EXT_SUB_SCHED
 err_stop_helper:
 	kthread_destroy_worker(sch->helper);
+#endif
 err_free_pcpu:
 	for_each_possible_cpu(cpu) {
 		if (cpu == bypass_fail_cpu)
@@ -6514,7 +6516,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 err_free_sch:
 	kfree(sch);
 err_put_cgrp:
+#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
 	cgroup_put(cgrp);
+#endif
 	return ERR_PTR(ret);
 }
 
@@ -6603,7 +6607,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_unlock;
 
+#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
 	cgroup_get(cgrp);
+#endif
 	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
-- 
2.48.1

