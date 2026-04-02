Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0813C3C1B
	for <sched-ext@lists.linux.dev>; Thu,  2 Apr 2026 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149264; cv=none; b=oz4UH7E7lJk+HVJVB36lfxaqkKt6Y9b6sWOHtLGLYX1Lx26eAkCIG7ZJfMw2aCtT/zlYEjUraps8/DuuGXHYMEAKuTODxAbm88EzCwDkBQhutRKFHekTkQ94ZUm5A6YMvBuUGVLPJ8QvQiuN9HDnmJno3D7TPzYvrLt0t1cZLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149264; c=relaxed/simple;
	bh=avoMcYafLkUSkpG0Fgouky+gloPC+O4Q0DVzrVGAA+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qM1pmEy+AKhVtpdlBPP4Anm5TZB5e005fqSFAURwLVSbtecO5uQhxtNuPZlHOYAEJIp6ILmqNLTBNZev3rsEF0o7xuDGhi36mNx7syl0IxNTFML9+BF8zea6a2x6O0MmFvIk77K2zdGQx3DbL1dTmKSr/rwT9+1ZPGf2UQuFHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hfGlc+Op; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hfGlc+Op"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9B7F3261E9;
	Thu,  2 Apr 2026 19:00:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with UTF8SMTP
 id WrsSg6cJYiEb; Thu,  2 Apr 2026 19:00:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775149254; bh=avoMcYafLkUSkpG0Fgouky+gloPC+O4Q0DVzrVGAA+o=;
	h=From:To:Cc:Subject:Date;
	b=hfGlc+OpXXjulE3OWA5B+4K/kOyLR8ZzABBLsR98DAA12k0+7rRaQ/1zTJmkhmHXP
	 2CsT5V8QPDAFKlVyWquEeQjHM+XzlYgHvFnFoLgn5eKPra0ttZDWbGn2qq4UyGLgqq
	 td8gKxKumLI/L9kARdZELTvhz4H5iDf94fSEEebF65Vum0X4JC46kiTO/WcCQpJgcR
	 B25z4s7A9y5uT95l6/XqhcdObai9rT6HicJ96Cn+PJlvrEVO/Frbz11mLDQYYbouSq
	 oQ73Xe221VvqVTtq5VlZU8TaeDa8Wel7fYYialOeaM8LbHvFYZhWDGtTr9JYZHk+aV
	 lDzA9930wL1IA==
From: Samuele Mariotti <smariotti@disroot.org>
To: arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Samuele Mariotti <smariotti@disroot.org>,
	Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH BUGFIX] sched_ext: Fix missing warning in scx_set_task_state() default case
Date: Thu,  2 Apr 2026 19:00:25 +0200
Message-ID: <20260402170025.1387202-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In scx_set_task_state(), the default case was setting the
warn flag, but then returning immediately. This is problematic
because the only purpose of the warn flag is to trigger
WARN_ONCE, but the early return prevented it from ever firing,
leaving invalid task states undetected and untraced.

To fix this, a WARN_ONCE call is now added directly in the
default case.

The fix addresses two aspects:

 - Guarantees the invalid task states are properly logged
   and traced.

 - Provides a distinct warning message
   ("sched_ext: Invalid task state") specifically for
   states outside the defined scx_task_state enum values,
   making it easier to distinguish from other transition
   warnings.

This ensures proper detection and reporting of invalid states.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")

Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1594987d637b..10683ce4e415 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2863,7 +2863,8 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
 		warn = prev_state != SCX_TASK_READY;
 		break;
 	default:
-		warn = true;
+		WARN_ONCE(1, "sched_ext: Invalid task state %d -> %d for %s[%d]",
+			  prev_state, state, p->comm, p->pid);
 		return;
 	}
 
-- 
2.47.3

