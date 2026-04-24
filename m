Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB762DD60E;
	Fri, 24 Apr 2026 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064884; cv=none; b=chog2re8TFtMxLVW3Ja5GgQyXTdyLkn14R2q+2hTXXCfFeEdorF7UIC1XdgtDjCbzPjQeCEw+YU06Md/luvX5SYsCwgSDiu0pRXIXFodm3YoUpLpRodoqn14ip3pQs6XQMa4MC6Ypm4P1zgVoZcnXUlYN/8SqA5iDLBa/nBX6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064884; c=relaxed/simple;
	bh=6Xg568wGZEpJgesa8kXcgOlmqz0Ux9ylANP072PQtEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aF/yFTkWgbanL3Ca7XaQHwsby1aFO03DJ6lDTRnOrP6/BPBEwUq4qIcMViYMGDr9d971LYekKwKh7TP7J/ifRojfA3kis8IzuwyE1AcK3vUnKP1JAwc0LBDTFRBJzhIPwEZC4MHBG6hCidTZoSGHnt88kflLDsxEqgKKmbGUZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeckG9d8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeckG9d8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A95C19425;
	Fri, 24 Apr 2026 21:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777064883;
	bh=6Xg568wGZEpJgesa8kXcgOlmqz0Ux9ylANP072PQtEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CeckG9d8tKBuuoiPZquWyUaPWt0pIQv2VAg6Iwt2OrU/n0gBx4D8Hy1hr2mJHVHU0
	 StqgWNrWJ9Gt602uTufgVFeSH4VcKVmi8D4FFOi6ynUjuMyx7PPNGllyEvC43BiVZ4
	 49dNHNZ3YowQzsbSGNumk5NJh9mEAe2om4G8hKoLByiLTEIAOSDmYvlme1nWnEtOly
	 QGKHVIKf59L6baYQhgRSsNiuJKYSx7rLI8c1etoGhUrop0eg80CzjIjHiZX3JKN+lQ
	 G3k8OnsXQzg6k+dzbGW8Gfb+FPZluqSZVoMLXyUeexyCUoo+b+q7US7i+gKanHGUB2
	 yNEMYU5vCnrxA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/13] sched_ext: Reject NULL-sch callers in scx_bpf_task_set_slice/dsq_vtime
Date: Fri, 24 Apr 2026 11:08:01 -1000
Message-ID: <20260424210802.3842919-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_prog_sched(aux) returns NULL for TRACING / SYSCALL BPF progs that
have no struct_ops association when the root scheduler has sub_attach
set. scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime() pass
that NULL into scx_task_on_sched(sch, p), which under
CONFIG_EXT_SUB_SCHED is rcu_access_pointer(p->scx.sched) == sch. For
any non-scx task p->scx.sched is NULL, so NULL == NULL returns true
and the authority gate is bypassed - a privileged but
non-struct_ops-associated prog can poke p->scx.slice /
p->scx.dsq_vtime on arbitrary tasks.

Reject !sch up front so the gate only admits callers with a resolved
scheduler.

Fixes: 245d09c594ea ("sched_ext: Enforce scheduler ownership when updating slice and dsq_vtime")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9a31b8f064e9..52b63266e647 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8619,7 +8619,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
-	if (unlikely(!scx_task_on_sched(sch, p)))
+	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
 		return false;
 
 	p->scx.slice = slice;
@@ -8642,7 +8642,7 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
-	if (unlikely(!scx_task_on_sched(sch, p)))
+	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
 		return false;
 
 	p->scx.dsq_vtime = vtime;
-- 
2.53.0

