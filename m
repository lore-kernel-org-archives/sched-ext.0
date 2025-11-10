Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC66332E730;
	Mon, 10 Nov 2025 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808210; cv=none; b=GWDQa5LsmNa/RWVtRA5H1yqPTiyLJYQRiw73TVU9maGFJPjsuCmOeyXImU5TSalOd8qpSJAk5nfaSbb9ST/dXhIr9AKLN9zE8S4Fr2hNkF+P0S8u+p41O8YZj+bhBprKZ1FDn7C74cLPFdcbO63qf7q+b1+5g2zl7XM8r8QZXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808210; c=relaxed/simple;
	bh=CO3Q4VfDcEwb5cYRvfkaUl9hA+CEb50dhXsFbgpMVWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6gFBRAi3xNj8FGx7ZaJvdO3MsHaZdA8cUJPtpNsdO/hndPK81fXGRfvKpvmhvqqs6UFhbGIK7YlwlXKCM2lED8E+9cuHWn57Fmfs84x9g0tn+HZhdKakeYQp/cip6EfxLFX4uRcVsnVORhk09WziiiWCvk880QMO4Y63X8e/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAJ6kcaY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAJ6kcaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0001FC19424;
	Mon, 10 Nov 2025 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808210;
	bh=CO3Q4VfDcEwb5cYRvfkaUl9hA+CEb50dhXsFbgpMVWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAJ6kcaY2WRpwSgLpsE8xj3m64bYBeHbs5PoFfzOhZDSVDXSQWFHKrhZ+Kx6xsLkU
	 6drlMu2N3JbFCcba3J5omNHj4cH8qCR7UtwWr2ao5ZhB61IQIhoqSD0QBSt8Ptg+BL
	 YNqyKY82uTXiDcl32VgHPSNRMmaojCNEpyrfZgKiFJk4hUXF6d8YrBscXLZSZ4CoeW
	 3NuIOejRsK4/DfIi/BIPkrh6z6iqm60EA9zbJZq7yMEs2IMrbjT/4rWMTpkZA1D1Kq
	 yU6Vfnw3TObjlIJgxSnKBjZe5QuQPccCE/LQldRYzTBPQH9dYwvEu2Jo5N1EnoN1X3
	 FHPU1rOPQU5zg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH v2 12/14] sched_ext: Factor out scx_dsq_list_node cursor initialization into INIT_DSQ_LIST_CURSOR
Date: Mon, 10 Nov 2025 10:56:34 -1000
Message-ID: <20251110205636.405592-13-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110205636.405592-1-tj@kernel.org>
References: <20251110205636.405592-1-tj@kernel.org>
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
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 7 +++++++
 kernel/sched/ext.c        | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 4b501ad7a3fc..3f6bf2875431 100644
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
index d16525abf9e0..82f0d2202b99 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6249,9 +6249,8 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
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

