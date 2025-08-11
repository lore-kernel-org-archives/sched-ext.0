Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E732E172F
	for <sched-ext@lists.linux.dev>; Mon, 11 Aug 2025 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947342; cv=none; b=hp3g3FvzfvIgR43uzCiv0ndjrMydJjNG+1fEnIa7bgO+rBMpJsx4nHkPoA6Kq6eCU5KwVDiUMcJJE3cYvCMCUOcHGqH6Yt8FClfCkiz7/Z1enIyepeQCxZhuYeY+iuNQUJOCV+yrxLjDsqQdK31ZI2dY8Hmf4YvDHLCJ23bgqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947342; c=relaxed/simple;
	bh=48ai1//QqI2vc2O3Mziq7Er7rYM94ChyM3stR4M79ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2HrKa1OL2HUkcic0OQ4Xut5Pbd+BNsEx8G+daX7ab4MrnYlBtN4Q/DD8TTbSTlLS3auabpHBplflX/fOf/CDOHJmFbQJPXJHEqj/q//dtN91evDzsfCzun1urd+q6l02v5eb3HalEuLPBCr1R8aFxxIoXZQ+RYQvx1zTbAGOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 590101A32;
	Mon, 11 Aug 2025 14:22:12 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.55.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DCCB93F63F;
	Mon, 11 Aug 2025 14:22:17 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	changwoo@igalia.com,
	hodgesd@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	jake@hillion.co.uk,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v4 3/3] sched_ext: deprecation warn for scx_bpf_cpu_rq()
Date: Mon, 11 Aug 2025 22:21:50 +0100
Message-Id: <20250811212150.85759-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811212150.85759-1-christian.loehle@arm.com>
References: <20250811212150.85759-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cpu_rq() works on an unlocked rq which generally isn't safe.
For the common use-cases scx_bpf_cpu_rq_locked() and
scx_bpf_task_acquire_remote_curr() work, so add a deprecation warning
to scx_bpf_cpu_rq() so it can eventually be removed.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ded4ace36090..7d2d88e8dd59 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7423,6 +7423,9 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
 
+	pr_warn_once("%s() is deprecated in favor of scx_bpf_cpu_rq_locked() or "
+		     "scx_bpf_task_acquire_remote_curr() for unlocked remote curr\n",
+		     __func__);
 	return cpu_rq(cpu);
 }
 
-- 
2.34.1

