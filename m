Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFCE329E52;
	Tue, 11 Nov 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888710; cv=none; b=alib1XCv4BoVqC9LNOBNY8UivZvgX2qNML128IWhbyVPJM04x6b52MxWAzh4SooZFUsWFJj3ljRnTb5yTWkzjHKSN0b3Zr4V65tBUj6ABqHWTIQ1vo1dzlQ5BjvjEBCZJcXFB1vxa4eBg2X+AfkE6XPeCouMzwtVeM/QugLzFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888710; c=relaxed/simple;
	bh=2EXblq1llrlWeUX08OpMOsi73aaJEAJG0anr8l6rapk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1XDFyrl4l2Gn9xb6UA+WmW2iVcXdQN29DLXQdpK6ihqj3+KjJ4dq8tCBA/rBRtcn06Jud0LJOG8c0Ra4waPvWauTW+7/X/+AWcNFq+JG18QhiJUoYbOBWnaBNz9T7foMgOpSRKPbhyABpzOzXz1+aOvW6Dar91PVk+fSBZAEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tge1wlDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tge1wlDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ADEC19423;
	Tue, 11 Nov 2025 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888709;
	bh=2EXblq1llrlWeUX08OpMOsi73aaJEAJG0anr8l6rapk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tge1wlDZbPFRwIRsbXfvAHe3oF//CK5PXGw9MC4yhKyh2KhqKdQehtf0/2RWLJ0Td
	 Un8KDBW6F0jZoFuN1fBbj1h6VxtAMYQ+S6mcVm4zI534EY5Ct4GbxOdSpG3acQdETa
	 VRcvOrmu0ChzS2x3ud5BGikNj/DZh+svHNEoKqJtgDWMjlh2DzkoV+4rrDM0n29CBt
	 1ykm2ZlUDkOwZuCOTVxzSaMgGhz4XvxDFbX89qmGGPEUMGnmx54EC7eVethdQdmejN
	 MDlLXH0uvSradV55pm0wh9RiZRT4w0hU0dmqs3mXBcECtGoZrFuFT78xEP3Kq/3PyD
	 rUQ0R1l0pEq5w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 11/13] sched_ext: Factor out scx_dsq_list_node cursor initialization into INIT_DSQ_LIST_CURSOR
Date: Tue, 11 Nov 2025 09:18:14 -1000
Message-ID: <20251111191816.862797-12-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out scx_dsq_list_node cursor initialization into INIT_DSQ_LIST_CURSOR
macro in preparation for additional users.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 7 +++++++
 kernel/sched/ext.c        | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d6c152475f5b..70ee5c28a74d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -149,6 +149,13 @@ struct scx_dsq_list_node {
 	u32			priv;		/* can be used by iter cursor */
 };
 
+#define INIT_DSQ_LIST_CURSOR(__node, __flags, __priv)				\
+	(struct scx_dsq_list_node) {						\
+		.node = LIST_HEAD_INIT((__node).node),				\
+		.flags = SCX_DSQ_LNODE_ITER_CURSOR | (__flags),			\
+		.priv = (__priv),						\
+	}
+
 /*
  * The following is embedded in task_struct and contains all fields necessary
  * for a task to be scheduled by SCX.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b5c87a03f112..56946aceeb28 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6253,9 +6253,8 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 	if (!kit->dsq)
 		return -ENOENT;
 
-	INIT_LIST_HEAD(&kit->cursor.node);
-	kit->cursor.flags = SCX_DSQ_LNODE_ITER_CURSOR | flags;
-	kit->cursor.priv = READ_ONCE(kit->dsq->seq);
+	kit->cursor = INIT_DSQ_LIST_CURSOR(kit->cursor, flags,
+					   READ_ONCE(kit->dsq->seq));
 
 	return 0;
 }
-- 
2.51.2

