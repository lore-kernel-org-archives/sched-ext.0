Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841563DFC7F;
	Wed,  4 Mar 2026 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661695; cv=none; b=FxsqynRR/sjkpaA96Fap/iw6qXGleRi/vhUxbjDVXVDwof1ZkNyfSLYFM3REIFhWsWsftHswCRXRnmcTHKMbOKcBb8LoQgx/AEBFfz59hQvz0y1QHPb0ZgLyeErNxPfP2mHra5dxlxI7ADb+bGqASaEUbRzou951hmdBtf7GMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661695; c=relaxed/simple;
	bh=U8D5kMDpc9Zf5YxxxsPJq+9EBS9dAsqhDXuLkLNOAWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DisHH4hMY10bRfrhKBV4HQ6TWrQ83pUe3SFLIbJ2P3D3ODoM2C+WQCeG0b6NnJliU57VCEKKX3r7+TZd6DG6cZP3i0kVufMDRRQ+zHLuZq1+bpqxX3OAWNaHV1q9izJrdnScFneOSuv5xz8NMiI2q7IFl1g8kZIv8Z5x9p4KPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErtdqaV1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErtdqaV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDEFC19425;
	Wed,  4 Mar 2026 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661695;
	bh=U8D5kMDpc9Zf5YxxxsPJq+9EBS9dAsqhDXuLkLNOAWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErtdqaV1Kpq67Ld3mUP0pSgpKdiI6e/ZwY+HoSV/UhL79xfG68PxAadVKizw19L0y
	 6DVG49JEJEqS8LvhVPwXp7RLHhq8HeGONa6JZda8zvvubwNV5k5y9XbsJ7FzgNePIA
	 woCNBDbd0tj9ws6wWF8K6hgiJ84/lvNsCrlsRMfr/6lh87hq6VTsHtP0d2kY8qaGO4
	 Uqt1y8UYqDY9yYSxQYsKl+YI0VbZkN+K7QyktNvA3dMJLNeaevj2L+dF2RySfZ1+FN
	 4E/ICjf9+57AIAghm65alEyOb9+YNo2E1/9niKcDc/Ya1K01A/JC21uM3pd7JF5mcq
	 Rct3nV4DnzTpA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/34] sched_ext: Make scx_prio_less() handle multiple schedulers
Date: Wed,  4 Mar 2026 12:00:59 -1000
Message-ID: <20260304220119.4095551-15-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call ops.core_sched_before() iff both tasks belong to the same scx_sched.
Otherwise, use timestamp based ordering.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4280b639a6e0..54210cef3bc7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2809,16 +2809,17 @@ void ext_server_init(struct rq *rq)
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch_a = scx_task_sched(a);
+	struct scx_sched *sch_b = scx_task_sched(b);
 
 	/*
 	 * The const qualifiers are dropped from task_struct pointers when
 	 * calling ops.core_sched_before(). Accesses are controlled by the
 	 * verifier.
 	 */
-	if (SCX_HAS_OP(sch, core_sched_before) &&
+	if (sch_a == sch_b && SCX_HAS_OP(sch_a, core_sched_before) &&
 	    !scx_rq_bypassing(task_rq(a)))
-		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, core_sched_before,
+		return SCX_CALL_OP_2TASKS_RET(sch_a, SCX_KF_REST, core_sched_before,
 					      NULL,
 					      (struct task_struct *)a,
 					      (struct task_struct *)b);
-- 
2.53.0

