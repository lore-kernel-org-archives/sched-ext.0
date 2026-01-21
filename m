Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7444E05D;
	Wed, 21 Jan 2026 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037117; cv=none; b=ef4xJknE1HkRZM3EYTLq2xuCxTmgE6eSEnfdxZf8/WwrrQu4gYFIK5rayaADTDpWnyY9RPLpMWEA3IS4i4Tk03jmTuqXAN6yLv7HZM6aGtUt3xGhhCRHSsRIj1D+Jwg6E2cE0ilTQwrxDqvqM13xhcRu99pEb2D0qDb+vAXWNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037117; c=relaxed/simple;
	bh=poPiQiO7M618xaNw3h9q8b8vfZjHbw31N2l9fGglZr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpjz9ZKyL5byxna22Z66w5cpLHNc0xOyi7kQfSlaO/LMbD0o6u/u2M6YDAPPivaW+34wYg/vy+r4XNedAC1UPbiH0HB3Y246QNy6ygMSkOhHx6Wh7YncWPZRksHluzd1U7cKriR5KkeuSyb06EjHqeFxzBvPlpoZ3N0QzrXr9sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJbuvT04; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJbuvT04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261DCC4CEF1;
	Wed, 21 Jan 2026 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037116;
	bh=poPiQiO7M618xaNw3h9q8b8vfZjHbw31N2l9fGglZr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJbuvT04mcWNLDtiDrsx7t4EE18hsFBuxaCA2O0eA8L41apLL2XxVImWxUCOSgg5V
	 xlY/nssU4+dwQ6vRrW4N8jt275L+Dw4J0ucuLWqW8cMcEa8erZdFYEC/Im7jpaHElU
	 0/fwSrNF0WhnOuSi9iMP3z0HzgtfFJf/C42SFLx+IYraSeBlYnfMozark3tpMT/Uw3
	 GdmgSUwguNPOUz9J2fdCu6cYS0IYaI4GGOj4QnxTgKLyRjDspzWc9JhQaeuxbtb65x
	 nCEPcl1zgTe5IV3OORLszbMbNWF0OB8jSJnp+uv9JJcHsdCL2g9aHZoW89jqTN/FmB
	 4fZEAizKtlAqQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/34] sched_ext: Make scx_prio_less() handle multiple schedulers
Date: Wed, 21 Jan 2026 13:11:20 -1000
Message-ID: <20260121231140.832332-15-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
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
index a834da7701df..ad4f8fbc0f24 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2688,16 +2688,17 @@ static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
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
2.52.0

