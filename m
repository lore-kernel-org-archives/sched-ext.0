Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A22ED848;
	Mon, 27 Apr 2026 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285617; cv=none; b=WBcFzNFButdRYPMWfBwDVp141RTghlXSFH6pXZGoHrNxSG70Gc1QAAgNHQPaYBeCmRc6bbTqe7kgmrNwMmhiKkH0oyH20a6up2zfV+/2kwlfRQHS+RsuAUjewzO7smuGyXRTtWP9Cu326bvPCJ/zE25ig+A1VCVteZw0JWv4HFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285617; c=relaxed/simple;
	bh=I9OF7sGkMk8ad1fBqojuKCXS3GzbB2CpU1gn3gnVTiA=;
	h=Date:Message-ID:From:To:Cc:Subject; b=mJPxSKgBH/uorW/U2Z171p9O7R+S04AqA+M//WaN47ydjjw1nFGo0ujukmKJeugVU9rR4XuVbuDOFRhkl90Ia5qNfXtgai8pM/S/kOo5c4sUShKyB4bFW5M7uVKKemirVz/S7BZ36QQQ1wpCeUuCvnQh74jfE1e7zCBTfh750eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBYEWMC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBYEWMC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAF0C19425;
	Mon, 27 Apr 2026 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285617;
	bh=I9OF7sGkMk8ad1fBqojuKCXS3GzbB2CpU1gn3gnVTiA=;
	h=Date:From:To:Cc:Subject:From;
	b=UBYEWMC5KzDoJZBBgBPQs43MlfwDbrhqFzmduVJRWY23VvgoDBo1cln/hNRYIG+FQ
	 SKJkW78m4JpdaeJQ9nehcoTNf8254ZH2it+0LFFKKCMV2LF6HaDwXrcBHcN+Q6Lf9E
	 GqlDXRq6eBAV/4jewP0Tn1ZrLMZ58MDYQXAHuZf7QrWFigd/yLU/7clDp8IILQsOlI
	 t4Z7pC42flnAvCK/zQMRbGCYu51sgqCgPVOfeSMh29clQ7MCeVX2tF56/bBSRwIUNL
	 CaKsjap0KfRGvgqZNVDpZEDC4eZ2TSjwAvPh1r2f8FmtfnAtMuDxhZz50IZaj2CE9z
	 9qgKimuAgC6nQ==
Date: Mon, 27 Apr 2026 00:26:55 -1000
Message-ID: <b7ce63c1c16b6a21106b4fde986c3778@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2] sched_ext: Collect ext_*.c include headers in build_policy.c
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Move <linux/btf_ids.h> from ext.c and "ext_idle.h" from ext.c (plus its
self-include in ext_idle.c) into build_policy.c. Subsequent patches add
their headers the same way for consistency.

No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/build_policy.c | 2 ++
 kernel/sched/ext.c          | 2 --
 kernel/sched/ext_idle.c     | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 755883faf751..ffb386889218 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -58,7 +58,9 @@
 #include "deadline.c"

 #ifdef CONFIG_SCHED_CLASS_EXT
+# include <linux/btf_ids.h>
 # include "ext_internal.h"
+# include "ext_idle.h"
 # include "ext.c"
 # include "ext_idle.c"
 #endif
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7b1b16e81a5..11893f00be06 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6,8 +6,6 @@
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  */
-#include <linux/btf_ids.h>
-#include "ext_idle.h"

 static DEFINE_RAW_SPINLOCK(scx_sched_lock);

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 7468560a6d80..f0f4d9500997 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -9,7 +9,6 @@
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
  */
-#include "ext_idle.h"

 /* Enable/disable built-in idle CPU selection policy */
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
--
2.53.0

