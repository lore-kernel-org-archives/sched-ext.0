Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D43064A5;
	Sun,  9 Nov 2025 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713087; cv=none; b=tDFXTU1PW8bZzmreVl4/Zxh5JO5calOxj5w2q+6bVIaJJervBj4uTQyP3oPLcBpuOVxSwyawPRFzPa6tuNCuPOdcKnD1mWZjGaXsM823aAxIIC/MSzbZK58OTYlSmEakMQ512w6ptEjrwcf6rfOhTf6BoGwSLTLrdVnoBM7MHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713087; c=relaxed/simple;
	bh=yn9Y6Ganl7JXLkjLauJB1C3SuRbC586BEf64Lqftvbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUkFrXym3+C2LqmQFuyvpmYojU8LeH6iRiGgBV14jJ7a9ycqzYC0mm5KIu79O0tHFnp0FoU9KIiyMloxh+iic5U4NmLHyZdLt3KBEG1PEhGHJC/nO2sBpEdskcOIdSkpg6RWgo4n/CiKVB7zdAzxoerkyW3mVxEkA+mOG7P3Cq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0kBTbJh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0kBTbJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7096C2BC87;
	Sun,  9 Nov 2025 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713086;
	bh=yn9Y6Ganl7JXLkjLauJB1C3SuRbC586BEf64Lqftvbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m0kBTbJh9U/13AqJLwX3LJiujrFS+vEOP+x6/4abHQbbOf4pXNPT68x+1MNXr+lzF
	 i1LKcee6RZ8qYcPv6mFT+qPXokZYfl7tixeRHKszZ8pHZ8XFDQPBQVDQuaUQUmrI8A
	 hs6BXQ4o/gbjql61eTjf0NeCH3wh6Q0O/OEEL8wGEpoT3uDJTv+bGtxNh/GUCVtVNe
	 nat+eCKYobhdBM/ygjs1oebb/V73jl9qswhSbdroyej2ouo5NoZp9fzd5TBqSRfMO0
	 DXYpbDPjNI28GQ2Wx6Q8VLRVLWw79AVZzBe7pJzzDvmoDixf+ojpE/kI3jchycV6z2
	 EJr3xWDqoR1rg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/13] sched_ext: Factor out scx_dsq_list_node cursor initialization into INIT_DSQ_LIST_CURSOR
Date: Sun,  9 Nov 2025 08:31:11 -1000
Message-ID: <20251109183112.2412147-13-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109183112.2412147-1-tj@kernel.org>
References: <20251109183112.2412147-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out scx_dsq_list_node cursor initialization into INIT_DSQ_LIST_CURSOR
macro in preparation for additional users.

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 7 +++++++
 kernel/sched/ext.c        | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 12561a3fcee4..280828b13608 100644
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
index bd66178e5927..4b2cc6cc8cb2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6252,9 +6252,8 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
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
2.51.1

