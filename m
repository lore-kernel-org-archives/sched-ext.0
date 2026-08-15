Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515272EEE9D;
	Sat, 15 Aug 2026 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786787037; cv=none; b=r40wKefU1O6u1VEdHZ94VoFAKegxcAc1yhTp0RENMG2eEi4txeh2eyzcQs/UBML0G1eYNSagDI/JAhdraU8hlQEBvtuknU1f5SzViCHfn2PvwZXwYzXkv5PgPWbCxDOmrxv9QMM/xgi0D5QQxCAQrlP6DwgS84AP+SjAcyv40O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786787037; c=relaxed/simple;
	bh=gglZd8YeE5+4R9k4Rexdy3sxkonOrGZaouifF2ymsW0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=u8gh/L4YGXmUA9MrV1cRrWHKa+s9rik9q1GrL6q1YFb2zV3A/WCzwiPiYldgJQ8/1oeCea+AQz06y3lLI0hP3PigvmOpVskD4hA+p22kKehNj4Nh/h2iWToEOsiYstZ8Wa5k07r0GaN3jGAo4BtPx+OXGv2mRKkPmbeUoT5+8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqcYkaGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqcYkaGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA581F000E9;
	Sat, 15 Aug 2026 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786787035;
	bh=rcBEFUkbjtpI5G1RXqhorbMNXkzANkNnhpVos7t5m5Y=;
	h=Date:From:To:Cc:Subject;
	b=kqcYkaGFG9DNurrCaFdgu0q85oGrhxvhPMIN3uWVsepgRE76F6MyeoRyGbOiT8Buk
	 fP/Vav+Ki5+e7wnIAdFXFhRWwu8SZVC6EHkTVTbSo+rU4RhCnThBl/sEmFkAE/rpxm
	 rj6OsXgGMK9Y7FN1uNwzy09A6OK5fIw9Yf+VDj3AsSOZTD8MPjQ4uTTCLCIEwl6xTh
	 cGKSG9RELvPab/ZBO157tU/X3yMC/0sGWAfN0nH6+rnbZFV1VO+T08hTEdltiIlC35
	 YSVnS3Q71cbnN4jgjH4cNPS+0ehJ2kcz7BxeTYsAPgucKhckk2N9yxV0qAcaz/DPG0
	 OoaW0Jz39NRDA==
Date: Fri, 14 Aug 2026 23:43:55 -1000
Message-ID: <34c6e5eb01c406d93c8845b94a990069@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>, kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev
Subject: [PATCH sched_ext/for-7.3] sched_ext: Make SCHED_CLASS_EXT select
 GENERIC_ALLOCATOR
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

kernel/sched/ext/arena.c uses the gen_pool allocator, which is built only
when GENERIC_ALLOCATOR is set. SCHED_CLASS_EXT doesn't select it, so on
configs where nothing else does, the build fails to link:

  build_policy.o: undefined reference to `gen_pool_create'
  build_policy.o: undefined reference to `gen_pool_for_each_chunk'
  build_policy.o: undefined reference to `gen_pool_destroy'

Fixes: 9eca087deb0b ("sched_ext: Sub-allocator over kernel-claimed BPF arena pages")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608151315.tvN3X0Oq-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202608151632.3p91bTQj-lkp@intel.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/Kconfig.preempt |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -169,6 +169,7 @@ config SCHED_CORE
 config SCHED_CLASS_EXT
 	bool "Extensible Scheduling Class"
 	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
+	select GENERIC_ALLOCATOR
 	select STACKTRACE if STACKTRACE_SUPPORT
 	help
 	  This option enables a new scheduler class sched_ext (SCX), which
