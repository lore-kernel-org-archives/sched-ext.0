Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908537DEBA;
	Mon, 11 May 2026 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537017; cv=none; b=WVKLpMp0HRNy+qVuDwMHZUSrhjc2y9yH+GjYHmL6PVdRCZp6yeYqAu8tG6f2JPGGJ/Sf6RJOUCD1rOyNzqjyFAdHbygtdY5Zs1/vLmvpeaqavmCESaXDRrBHKEAHKTQB/ZxwSzEzLnScZMkHVuI5FfcJfzm12arFXCDRXtsjKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537017; c=relaxed/simple;
	bh=KyEdPWkVvJVcl3kwEFMfGF/vIvoJQ1RgxyA8hNrUA4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJTRisOz3ggnh8H+3WeMaFZgoQfACdQ9o0P2Q8zayJuwHuZ09W+P8kqjJgt9ene5WgBaEUdru20C1Oa9tLt9TjNNjQ06c428zP6b1i+PZbfhXqHH1WFL/4mrUiIoIHn2ZtofYgg2eJgU+TJ3rGDi+2RTrebDXzQkoNxnWhinO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE+KjpMv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE+KjpMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818EBC2BCB0;
	Mon, 11 May 2026 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778537016;
	bh=KyEdPWkVvJVcl3kwEFMfGF/vIvoJQ1RgxyA8hNrUA4c=;
	h=From:To:Cc:Subject:Date:From;
	b=VE+KjpMvPO6vnI7xcSvmeadyzHaP6L8qb20Qwuj16DTc78YSIS4TUTp3hsYpKPtX+
	 CW5xWJfmNtOF+uK9b8iwImE+P0g9je51DWvqhu8aI33ONjCj5yRyck2hz6XEnbOAkt
	 Hwya+3puOaHFPTdG7sMEsqcv3yZZr98ZKS2onfNZSC2Kwrf5JDC7Sritij1woIdNd3
	 uSeYU1rZAdrwlGvz7NURRSK99Hs9NqHbUwEGlrFh9XCPPBjBWC0yuZsvOE6v6rl6RN
	 KWVBE90gRQdC/cxY5J846GTcD4VdcUpWwGnslsvfs1Pa9ThLPwYwWxgfEcSVyg9FCI
	 0aSLaS1K7enrQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path
Date: Mon, 11 May 2026 12:03:35 -1000
Message-ID: <20260511220335.144621-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In scx_root_enable_workfn(), put_task_struct(p) is called before scx_error()
dereferences p->comm and p->pid. If the iterator's reference is the last
drop, the task is freed synchronously and the deref becomes a UAF.

Move put_task_struct() past scx_error().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260511214031.AF5E9C2BCB0@smtp.kernel.org/
Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1efd5d82b08b..9354da79e162 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6973,10 +6973,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			if (scx_get_task_state(p) != SCX_TASK_DEAD)
 				scx_set_task_state(p, SCX_TASK_NONE);
 			task_rq_unlock(rq, p, &rf);
-			put_task_struct(p);
 			scx_task_iter_stop(&sti);
 			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
 				  ret, p->comm, p->pid);
+			put_task_struct(p);
 			goto err_disable_unlock_all;
 		}

--
2.49.1
