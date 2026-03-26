Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA923C503
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512638; cv=none; b=BOiUnVsFOvjqNic9lxMMYWe7l3mYheF+lYXuQJInXOf2a/mbjHBVqVDY6EpWJY89iAsBs9eO0IwxfIkRFggjyQxZZy2OrNqqd+oJ6gcg3ygc63CYCuSgs2DcGoA3kAz/CYTDvIeDAYVLp8/U/KuwQh7yINizMJNLVLr9iNmyceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512638; c=relaxed/simple;
	bh=OE7PtMT4bGlCIr+KYNkFo213ghLb1E5IK9no3K/7Woc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ap+xUrlH8TR7+YFwHg6nOVWjkbNsYK/YdizBGCiD89cEup7/87BTxuzBi6WNkuvoEviTSM2AMZCnUAwjVQKB9hC+I3OlEhlvkE0Tyh2ZJhlAx+CsS0EOSDirew32H9XCn/BnH0Seg+VbVaqljllgvwZCPSsDkB4mUMlJSkJ5erc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1af9tMq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1af9tMq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35b95a7444bso396285a91.1
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774512636; x=1775117436; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Etj0mwZtpUXhx6zzBLMJTsvKjtSQRtCM9z70q1Bz94s=;
        b=p1af9tMqKBdhNQlWJV14JqnrxtZRN1fHhDDXlukJtQHyjqtpVUj2LyVJlRq65ywZGt
         oUJI5TyrR+45rK8RMiBrB/xKiw6q4gYdjr6X7uGxRtQoZqABiQjK2WbIZbvJPCYMtGDx
         PfAZGRI8BGgIf16VTR+eYxhbCbXnBRSQgzI3QSW0YP3TQ6zB/xqNysbUEV8Y0HRQGLXK
         GUZgblavNwlf/DZQ3lbSTpYYXvCkPKVS18cGUMNJRS3x2X6S7rbI+bQBPrO4+oNb/GSs
         +fpYS4ktoi0WG4BgZ0CtpF/F0+d6Ha9CIMPZ17u/co5OFmJbmC9hG5WCau5VuVviQnWR
         gktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512636; x=1775117436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Etj0mwZtpUXhx6zzBLMJTsvKjtSQRtCM9z70q1Bz94s=;
        b=Q5QszxYrlFubgP53j3AScRA3itFFGgDxcnUrlfIM1iM97gakC62GZMsWxtHOW0YjFq
         g/SKZwup1gU57321hM+tcUk5X7NMJ+qDNGpGwHG/5DmGiiHSwJnjXeOQoDKI6QKYKvPI
         0XXjQjuvAeXSvLAgUenCa+6GvqpS1PSy8YbtpycquQeNevJVKDsSB/mlKbSFR2skZEUr
         sswL6fpf9se0G6CGXYu2ADZ73RapW1Iwefyk+DWxWmqgUrPrYwJ6+2zx5Ocv0vwqk5m9
         8wG0nGUUUUmhqR4+KSZRjtIL584oBhGEZew0LVWn/FWR0EfVLmuc/jqO1Ag3Pg4AIXRy
         n3/A==
X-Gm-Message-State: AOJu0YxEMAiozFF+3Mcgv6VJynhwFHAcOjUYXQEIe+VovjLDmYpj0xmd
	xLoklMW0Q9bAYycCOU9vWpMhrFE0vl/B+gmV8FMi1/IEH/0P16AahlH2fjcfTPmN
X-Gm-Gg: ATEYQzzRM6ilgBgzMtg1uFpiWKZWpjZ2Qj8KL6obDbxNyGYOoCoN8xDArizcafJVMVt
	6J/XJYnt3nMS1O6rjHeZ+/qMWHDhtJ7k1S/sqCq/wKrcV/uIeKKlKkxpEqLg7ShvKE1lJk3pVAX
	ef9rJ8RjmXWX4lWdfIkXP8reoyQMxbrSY8w9b2wUkDhbpZsspwkt1fyLj2TPme2XM0myUp6W00q
	2fZRsIwCZkUmr8PN9xQKEeFufdtrWdRgpqj8RM7WFqNw9G4Y5MdkswTeJ9iN0kgqoPBg9Ydk1Ol
	+fULUvABWjmK0HqztsHhznOz2VObvjYvRhyB6FREC8KDa2GgHVIPjXa1SwppXmgsyfUny89bkLw
	IRI2BgZXbOcdV8wsmiuhcyrVvEZ1zwPp2ffons8nWBtbYYK2V/E7aTTA8vFLkXsYAP2ijeA7zIM
	6/6d6a+9If0QOJoMj/64zRwmQh21AVmlhNJQsfF7eei5mIfR5b0Ws=
X-Received: by 2002:a17:90a:e705:b0:35c:d37:6022 with SMTP id 98e67ed59e1d1-35c0dc80d83mr6138488a91.10.1774512635937;
        Thu, 26 Mar 2026 01:10:35 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:ac9c:4df3:99d:84b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d8c26asm998189a91.11.2026.03.26.01.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:10:35 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com,
	Zqiang <qiang.zhang@linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] sched_ext: Fix print_scx_info() build error on !CONFIG_EXT_SUB_SCHED kernels
Date: Thu, 26 Mar 2026 16:09:15 +0800
Message-ID: <20260326081021.687711-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_task_sched_rcu() is only available when CONFIG_EXT_SUB_SCHED is
enabled. Wrap the call with #ifdef CONFIG_EXT_SUB_SCHED and fall back
to rcu_dereference(scx_root) for the non-sub-sched case, which is
semantically equivalent.

Fixes: 60d4b17e886a ("sched_ext: Choose the right sch->ops.name to output in the print_scx_info()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603261453.8kiJImYo-lkp@intel.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 551bfb99157d..a40edd4d7cd9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7689,7 +7689,11 @@ void print_scx_info(const char *log_lvl, struct task_struct *p)
 
 	guard(rcu)();
 
+#ifdef CONFIG_EXT_SUB_SCHED
 	sch = scx_task_sched_rcu(p);
+#else
+	sch = rcu_dereference(scx_root);
+#endif
 
 	if (!sch)
 		return;
-- 
2.48.1

