Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E530EF84;
	Tue, 28 Apr 2026 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408551; cv=none; b=WrAJrDRd4wexTMN7VK8dlUv9m+/dMcyPENP88VNkTW+cGBI+HLWdf7fBZ2vIW5YT2agzi8Nup3Tnh3IzK7bCiU7MSbLpn4BHm66FxmbY6TQXZXiTvZPK71Hop+2DD8mlqjYjou8jypCNhfjSsIVt7GGWWHZeAJxacL8qmgWfSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408551; c=relaxed/simple;
	bh=lYHSfiDW0Pcg1u0wZI9bbhuKEbf6vAwdGCvZZOvIu+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkGaY2zoQwfUT22qFTYT1pAjhBaqHmNjxCvt2URI8AjXVdgRvkxhIjTMbPcnOzjfvf+g4IRVFa953JqDlgem1ZcB7yLg2rwfh3qISpzbwu8BqF+aCeI/CCIjfG/bRxBJJPk1dXz9jBWx1TunSCVhBrDOaudIg1UUXzloVzKaKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5NvRHLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5NvRHLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CB6C2BCB9;
	Tue, 28 Apr 2026 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408551;
	bh=lYHSfiDW0Pcg1u0wZI9bbhuKEbf6vAwdGCvZZOvIu+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5NvRHLhYaq9IyANSVYRABt6xclZ8WGPkj0ub4Gq1zSM9kxphff5Ik0Am3rixfItg
	 fDVI1Qd0axecvnjVZ30wcmp55n8A4OppqULzQIZdi2gW3Nk6+H7wGq75ZbFX8rQzTQ
	 V+84Lhorrx0J4b/9BxIe8qlTTo9jszlqtl/pK+gSBtZ9xwup7COwbWtC9BanlNm26P
	 zR7m0WYdrNsqlyNDr8v/prEeZ+obTCc/bQH3YK2SJq+G4VcF+svlUKMk/zsiPDDjFb
	 b2Q/TJ4co4HmbqsQlXz66INFOav4PTu9eEiJUHlMF6j7zmDmHf4P6ST6iVwvyqXr0c
	 B9GbtPs7SPw1g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 04/17] sched_ext: Shift scx_kick_cpu() validity check to scx_bpf_kick_cpu()
Date: Tue, 28 Apr 2026 10:35:32 -1000
Message-ID: <20260428203545.181052-5-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
References: <20260428203545.181052-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers that already know the cpu is valid shouldn't have to pay for a
redundant check. scx_kick_cpu() is called from the in-kernel balance loop
break-out path with the current cpu (trivially valid) and from
scx_bpf_kick_cpu() with a BPF-supplied cpu that does need validation. Move
the check out of scx_kick_cpu() into scx_bpf_kick_cpu() so the backend is
reusable by callers that have already validated.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8d41b4e2cce6..e9cf9d8f4626 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8786,9 +8786,6 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	if (!scx_cpu_valid(sch, cpu, NULL))
-		return;
-
 	local_irq_save(irq_flags);
 
 	this_rq = this_rq();
@@ -8851,7 +8848,7 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
 
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
-	if (likely(sch))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		scx_kick_cpu(sch, cpu, flags);
 }
 
-- 
2.54.0

