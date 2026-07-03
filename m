Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092637A493;
	Fri,  3 Jul 2026 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065726; cv=none; b=s70k5+bwzITo8OAJyGcdQOwwMG1rXnsXR15G8vBLh04ClsJ3HY1NKB3X/PkPH99kOoygWm1VOOCRbFAI7G9zfrF69+0IiudHwI+XzhaqyydQyLdbTI+TRJMaMNHyk3X8PqjMFmyRTD2LeOez8jp0cBlHYAV9yqkNt4ZwZl9cPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065726; c=relaxed/simple;
	bh=CTbbRcyCwfbYhp8kCF6nzcXd1yzTyLyvkFOyrxhZyTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWMVeUTEXd5HkDbPnCfePG9gn8Ut9tig6XkdfLyGSeU6BNv0156hw/jkEyJKdKL5QdbVGjSHOjBeFx0Lply5HCzA8B5MKIPtNnUxFpuRIZUMJziYHpZ3e4Q9ErRc2bOebWlKrnycoaMp166vfeZ6aJrLuOV31xssXQIJmQ1zVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/tAQ6EP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/tAQ6EP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3E21F00A3A;
	Fri,  3 Jul 2026 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065725;
	bh=/ysQXVmdNtRwpAk8w40cPhflbZq4cAwWZ9sqkSL7tfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/tAQ6EP3KhvrLtV4kHdYv5m10mjJAY/dn997b0pzFROUZx5STpvIGi5MkE7ahLcE
	 tqjRl/n6vfaVKQ9zkKcHsq5EXsIzMbuwwqLwpfmuuK4lFT4kdWLGSciE166yTYwbsk
	 LJ2g9ilZg150sef7FrxCeHicSUBMqeeTbUdPpqsNMmrgu3oiGvJ62o+SthjpXk0dMF
	 zyZe6Ii2tvOuFnTF0DdGKbNH9tbDQr9gUW5OR26X0Dub617Ydm7DgN+YPQBJtGaHDA
	 37tautocSDG7u+LlcvSFTEhqKVFLt7X7vFvRIimA0vZD3xLKJl8Md2TPcnRi5A9FsB
	 ZXfusWVdOMcGg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 05/32] sched_ext: Reject direct slice and dsq_vtime writes for cid-form schedulers
Date: Thu,  2 Jul 2026 22:01:32 -1000
Message-ID: <20260703080159.2314350-6-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
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
index f4725698f5ef..4a93ed72e5aa 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7003,6 +7003,21 @@ static bool bpf_scx_is_valid_access(int off, int size,
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
@@ -7011,23 +7026,22 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 
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
@@ -7036,6 +7050,12 @@ static const struct bpf_verifier_ops bpf_scx_verifier_ops = {
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
@@ -7376,7 +7396,7 @@ static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
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

