Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769591A6830
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774187351; cv=none; b=cbp4TkgGUIrxdh2VyitxKc+lLaG5Gc6BN0DQPdsFQpkDY5P/Z5gNyJLfZelsO8OxJJ/tGO5+LXp0gLfI5S4DBNfCdsyf/GhiiEOJ4n3Si4vPpvQ2z5Z4ZNg5taj9Aep1Tp2UzkScSz66YDat6nDmBbzWJ1wTq50EtT2yoCRfVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774187351; c=relaxed/simple;
	bh=03VDgSS8aNBdiQRuA0Cu9J0eZvt9L4r2CGdjMa6bFGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnIoQeOae7zRlF2MJiMYqV6PKdhYJwKdsDvlb64O5EuFBiXRQ70ltksA5NtZ3o5Z+AYzj/4/hKu+Bi2DSX8wqdinmhezr5KxkQcY149Zo3qDq4tEncC4BNYKkBdqligYuY5AsjBEInYfc49IiZTvqw0jS2AQggSgR+4DctnE3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1GY3BXR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1GY3BXR"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so2670271a91.3
        for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774187350; x=1774792150; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8RTlOPl5i5sxgKtt2wkfYNlvFKiJhEWP5uljmnwuaE=;
        b=P1GY3BXRgV9J8GfuBpIXRYil4eWAfZy1/aElAOTOSUOe3hUu8k6brA+foZyF57JI68
         a+rDWbGYsO3HXmV2tot6rRQtJhKszZSJZPxmlDvvnB/5umAY2ukAM2GDyzlt8+zsot94
         1ORAJETpWCDU7bO4DFsmINyZw8TdhVCniSYcEPVWZ52m+ZIpOF+a4ZBV4C1SnHq13VJ0
         aHaRPHkNIe/F01tp9n37DG0xCXo2bDsnslb5Jk5vhXEo2Nvi4e0YENsEzbEQpAWP4BAh
         Aarg5kYTKWWc2ttII7TpVTSSJxpLj0nLioqBB84JqhXgtdYSv7FuTCziW6J2xse4aEeW
         eoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774187350; x=1774792150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8RTlOPl5i5sxgKtt2wkfYNlvFKiJhEWP5uljmnwuaE=;
        b=h7t7UOIfwfy7IMF/BGHjg97pdtiIGiSieG3YdAu5TH4n/XHFk10FPJ3NgNFJshBK6L
         KG34FZrNR3RSlJAWOs9N9SRDZB/jmE/gA4CqRtDjQgAycwa3RBX0XF74sS1XjmUj3Hzi
         4g95kj7+Y70P5Pqe5cqP8wQqFu5V292NLJZSQfxVPGV5jHtdMei+gXINIWraWV7AEkKh
         RMm+DVRUxp5HYOx2seqZRH5oEXSq6d7ijmJ7WKgpMXTULTKbfg/OV8r1Mg3B+wNWgDbe
         Y9Ay7Ij+x5XslveEsoCTrWcagozdOvfSQ+cutN7WNAPVLVt/JBNAieVib6O4wmVus09t
         SeMA==
X-Forwarded-Encrypted: i=1; AJvYcCUrshCuF5m9YyW4+WzqLdFTOlfkz7iOAZE0Y9dw6hYcutauQOhzx9jjLTqV/1IaY9OFULrL2wj+/Jg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxMTZRxR1VbF/TefBwVKOB3lgck3a4MAHzRihhXko3lvhV4Vlcu
	SmkLFuT+Q8a45wnuBjzyjeUrdnSKU5IthBgbbMjKypeppicjASWBecOl
X-Gm-Gg: ATEYQzx3teOZ4Q31zWxY38+usBU0cR4LQl0QhYjql5fC8AGpXmAiERdH3eCrrJVAvn6
	LIP8PtG6KgvfFQQCJwxS3cag+bijuj/Go6FrpduOUiUAv5S0Swlllwlf+9C7hfatqnBjeTa9O+l
	gx/XnK5fR5Ewi6evdKGQyxmsWASo65wLDPoomZJGTPVJOnyG9cp3pdDDYj2z4CFfQUgQ58zdilr
	uOYMBPyKQCdteaaqW1wdGd/R8y6kcZWFHCLnkWIj5VxnN9gq3sTkKbbKfwEkFuxpV1KmkKhPYmm
	NxiLbTN+p6qEJ1PszlrXe3b+Twp7JPIEEFtUhhH0lgglCJBgn7rdo3M0pPAXuxQLWWyOp+7L3V5
	ZsO8BRa8vo67zzAb7PEGTmk3UnS93XWGgMvtXfOfG8/2B+vPNxhQhb+6fmL+chw5ASdzVHcgIbV
	GGO141TUqbUUFYI4WpoaJW4JXcyVwjpWkIA9dMUFLYbaSomv5XNAY=
X-Received: by 2002:a17:90b:3c0d:b0:359:9014:99e7 with SMTP id 98e67ed59e1d1-35bd2d68359mr7645322a91.29.1774187349509;
        Sun, 22 Mar 2026 06:49:09 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:a92:d962:9ffe:7c38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3eb46b2sm7127430a91.2.2026.03.22.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 06:49:09 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: arighi@nvidia.com
Cc: changwoo@igalia.com,
	chia7712@gmail.com,
	jserv@ccns.ncku.edu.tw,
	lkp@intel.com,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	yphbchou0911@gmail.com
Subject: [PATCH v3 sched_ext/for-7.1] sched_ext: Fix build errors and unused label warning in non-cgroup configs
Date: Sun, 22 Mar 2026 21:48:16 +0800
Message-ID: <20260322134900.1641781-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ab-WrGgPTU27W9vl@gpd4>
References: <ab-WrGgPTU27W9vl@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building with SCHED_CLASS_EXT=y but CGROUPS=n, clang reports errors
for undeclared cgroup_put() and cgroup_get() calls, and a warning for the
unused err_stop_helper label.

EXT_SUB_SCHED is def_bool y depending only on SCHED_CLASS_EXT, but it
fundamentally requires cgroups (cgroup_path, cgroup_get, cgroup_put,
cgroup_id, etc.). Add the missing CGROUPS dependency to EXT_SUB_SCHED in
init/Kconfig.

Guard cgroup_put() and cgroup_get() in the common paths with:
  #if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)

Guard the err_stop_helper label with #ifdef CONFIG_EXT_SUB_SCHED since
all gotos targeting it are inside that same ifdef block.

Tested with both CGROUPS enabled and disabled.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603210903.IrKhPd6k-lkp@intel.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v3:
- Include the changelog which was missing in v2.
- Link to v2:
  https://lore.kernel.org/r/20260322063955.951848-1-yphbchou0911@gmail.com/

Changes in v2:
- Add missing CGROUPS dependency to EXT_SUB_SCHED in init/Kconfig.
  (Tejun Heo)
- Refine commit message to clarify why CGROUPS is required. (Tejun Heo)
- Link to v1:
  https://lore.kernel.org/r/20260321070605.691776-1-yphbchou0911@gmail.com/

 init/Kconfig       | 2 +-
 kernel/sched/ext.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 06abd8e272cb..487a93e34be9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1178,7 +1178,7 @@ endif #CGROUP_SCHED
 
 config EXT_SUB_SCHED
         def_bool y
-        depends on SCHED_CLASS_EXT
+        depends on SCHED_CLASS_EXT && CGROUPS
 
 config SCHED_MM_CID
 	def_bool y
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

