Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E633F58CA;
	Wed,  8 Jul 2026 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545880; cv=none; b=EbtsP5MvbRbSJ9UarwgjJxf3cuKUtORk3ne3ucP89yk+o+abHxsz9aaQDslCIvrfXqqjj4dlHTMTfM+J3gs/7wtkhIV6jPuLmRbiAe4PRw7XpiaQQN+EsaoN1LrT0Lh19iarntjFKUT0zvHwhAS+QPqvl7IT40Y8j8y7W/UT6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545880; c=relaxed/simple;
	bh=O3VlYN+U4OS7RIOZ03pUbVkyHxI5GRYOU+OOTllTGfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFQ17HeqDf0RvDPp3dZ0YRlmlGGbBhSYGsrcjfHM3DTXrZGGlqMw6sUrcz2E85Xkq+7bgHpWa5Cm/PLBOgG/eu/qkadxBVp/RHqiBqdgshfeoUc8j7VNa77kigKYAsphq7zljayO3HBlD3QFtkZv51+FRoZcQ3x3f75TYIDC/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhoTlts0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhoTlts0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1461F00A3A;
	Wed,  8 Jul 2026 21:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545879;
	bh=xGrpNSkXftGTHFyNAnXUjbWsTFfOQ5LqJQVTo7g3vj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BhoTlts08lNi98BSMgnMU+YVH2TRPR8esRkENy4wENiNyl0CgtHOaaJxtKNsniWjZ
	 gO7mOswCGNwayc1EgmQPDojoSjsB5rPQp2euX7S3QAYRaJZJK3apg8yVBcPDEg1t26
	 /TSKLLVm0kttclkehxlrSFP2CVaB9XK/mJKjJgG2XZtgXGQfoBkS9pdvz9iw5fW2sF
	 Ql/AsJxbWFHraAG28wjnx2iQx6I/O2UNYxiFli0zxj/bB8bmH3jCybIoFX7qNNd6Eo
	 j27GhE/PA01nM/u6F06nvQcpGTb9/bghZcSBI93KKNucB06tYU2xPMHgqcg0x2cmdx
	 nQQg7L/MRvI2A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 08/40] sched_ext: Reject direct slice and dsq_vtime writes for cid-form schedulers
Date: Wed,  8 Jul 2026 11:23:57 -1000
Message-ID: <20260708212429.3405787-9-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Direct writes to p->scx.slice and p->scx.dsq_vtime bypass
scx_bpf_task_set_slice/dsq_vtime() and the authority checks they carry.
Those checks exist for sub-schedulers, which attach only through the
cid-form struct_ops, so the direct writes only need to be closed there.

Give sched_ext_ops_cid its own verifier ops that reject the two fields.
cid-form is a new interface with no legacy users, so there is no
compatibility to keep. The cpu-form keeps direct writes, and the deprecation
warning they carried is dropped.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 44 ++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index be75bdc9ada2..bd3cb59b1dbf 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6995,6 +6995,21 @@ static bool bpf_scx_is_valid_access(int off, int size,
 	return btf_ctx_access(off, size, type, prog, info);
 }
 
+/* common to both forms: only scx.disallow is writable */
+static int bpf_scx_btf_struct_access_common(const struct bpf_reg_state *reg,
+					    int off, int size)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (t == task_struct_type &&
+	    off >= offsetof(struct task_struct, scx.disallow) &&
+	    off + size <= offsetofend(struct task_struct, scx.disallow))
+		return SCALAR_VALUE;
+
+	return -EACCES;
+}
+
 static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 				     const struct bpf_reg_state *reg, int off,
 				     int size)
@@ -7003,23 +7018,22 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t == task_struct_type) {
-		/*
-		 * COMPAT: Will be removed in v6.23.
-		 */
 		if ((off >= offsetof(struct task_struct, scx.slice) &&
 		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
 		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
-		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
-			pr_warn_ratelimited("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()\n");
-			return SCALAR_VALUE;
-		}
-
-		if (off >= offsetof(struct task_struct, scx.disallow) &&
-		    off + size <= offsetofend(struct task_struct, scx.disallow))
+		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime)))
 			return SCALAR_VALUE;
 	}
 
-	return -EACCES;
+	return bpf_scx_btf_struct_access_common(reg, off, size);
+}
+
+/* cid-form rejects direct slice and dsq_vtime writes in favor of the kfuncs */
+static int bpf_scx_cid_btf_struct_access(struct bpf_verifier_log *log,
+					 const struct bpf_reg_state *reg, int off,
+					 int size)
+{
+	return bpf_scx_btf_struct_access_common(reg, off, size);
 }
 
 static const struct bpf_verifier_ops bpf_scx_verifier_ops = {
@@ -7028,6 +7042,12 @@ static const struct bpf_verifier_ops bpf_scx_verifier_ops = {
 	.btf_struct_access = bpf_scx_btf_struct_access,
 };
 
+static const struct bpf_verifier_ops bpf_scx_cid_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = bpf_scx_is_valid_access,
+	.btf_struct_access = bpf_scx_cid_btf_struct_access,
+};
+
 static int bpf_scx_init_member(const struct btf_type *t,
 			       const struct btf_member *member,
 			       void *kdata, const void *udata)
@@ -7368,7 +7388,7 @@ static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
  * verified to match by the BUILD_BUG_ON checks in scx_init().
  */
 static struct bpf_struct_ops bpf_sched_ext_ops_cid = {
-	.verifier_ops = &bpf_scx_verifier_ops,
+	.verifier_ops = &bpf_scx_cid_verifier_ops,
 	.reg = bpf_scx_reg_cid,
 	.unreg = bpf_scx_unreg,
 	.check_member = bpf_scx_check_member,
-- 
2.54.0

