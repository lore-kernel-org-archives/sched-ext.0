Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7038A707;
	Fri, 10 Apr 2026 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802651; cv=none; b=bDP7BtH3UwMAjG+aY+jd/EnN+K/AGWlPAR1si0wleVxcg+dB9b6V49VftjPtCrv8hxgb0quOd7EycBXpKE6/pI6BCW10sSmZOf80lf3ixAbgps9vtGWh1gMaGiTV38u09BHCWMsA9iKDlDaCWFdEXmkag1HqP6yYAm1cypdxy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802651; c=relaxed/simple;
	bh=C49naKqyOgKD2u74pAoCPGdZT0vY7iMqhpveLqsiqOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAOe+aE7ZVkZyPTuSCqe0+DNNbOUx2/7b/RFG5h+oyk1gumN+a6R96fTgqTdlY01hTqTiQFhoipNHOiGigTC7v/bUN4fTA9mcnaJ28PRTW8eLW1nbqEsq7FIS7oM960GFHxCJKSjBydw0KtWqOoRIh0yiyRmWkK79AegWyLQQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwFCNMZj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwFCNMZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E78C19421;
	Fri, 10 Apr 2026 06:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802651;
	bh=C49naKqyOgKD2u74pAoCPGdZT0vY7iMqhpveLqsiqOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwFCNMZj6I2qdCWI+8ly58UnylhNUOIVBQnfAK1GQ758lq3sxF7YCEWRyjoXglq01
	 hCh3ykoxLO6E2D6lLUJzGn8Z8Y4Z2PveNmY72J4+TAoFdBzC3OO5M/jIwS7jozqRha
	 UIJ3ihYmTpaxpeRHUyvVBlxwayh/8wOiVY+na1vBYlTGNLFp31OEz9TBj0qKMSrvH0
	 f1GxhwhGC8VFuVnWDDdAR9oxtZCWDOn349GgtTxfkWmqDYGNYAtKHrEmsOAE4a5Qd5
	 Qjd+bORqE/Ls5lDzZ3q8R2I0CgdtNX34uvoFHF39qYKqv4M1BFhn5S34honLWrTAmm
	 ch+aKKo5wN4Jg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/10] sched_ext: Track @p's rq lock across set_cpus_allowed_scx -> ops.set_cpumask
Date: Thu,  9 Apr 2026 20:30:39 -1000
Message-ID: <20260410063046.3556100-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410063046.3556100-1-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SCX_CALL_OP_TASK call site passes rq=NULL incorrectly, leaving
scx_locked_rq() unset. Pass task_rq(p) instead so update_locked_rq()
reflects reality.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index cf441fb4b1ad..6ca0085903e0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3360,7 +3360,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(sch, set_cpumask))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_cpumask, NULL,
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_cpumask, task_rq(p),
 				 p, (struct cpumask *)p->cpus_ptr);
 }
 
-- 
2.53.0

