Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD437C913;
	Mon,  6 Jul 2026 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302067; cv=none; b=C5h7QVjGA1gQRCh/j+BzA22DRfmoacTP8PwwZyPJcQK7xgHXe2WylCNI/eTc8m1vePq1idyrgwCq1aU2rk2Py5PSHaqKNrwEYHws51ZDCI1vqHne843uucQum9A9Rt/wK+USRibtVJY2OtHvhYLLCdNT2LN/IgoYtMC0JUPEDSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302067; c=relaxed/simple;
	bh=O3VlYN+U4OS7RIOZ03pUbVkyHxI5GRYOU+OOTllTGfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4vjV1QO8l2Qu+MTpLCWTC/yPJ2KX/gFazPDU3agMm7fqKCI/Aj3jmfgREd8mKBEVXlRozufgRkv6iHtxo2I4vncwsC+FNOJpLR53v89zNlvW7tGc9xOmNwnN6VMe0ucTozHL4MQUvzyeWYTL5XTisd2L+/r5cHG1H9d/M5rYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgUjMwAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgUjMwAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400B21F000E9;
	Mon,  6 Jul 2026 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302066;
	bh=xGrpNSkXftGTHFyNAnXUjbWsTFfOQ5LqJQVTo7g3vj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZgUjMwAxkmHxMRC4fcg7I+OggDMttHJFWWTitrWrYPnGQVwqbVLsmhHLsADzG8zgK
	 DvTbxJ4EfObRBPut5N53MNm0hHgyqPosFqZU8bmGqjEufLwKyo1/67VLbdeK9JoccA
	 kET/NtBcKpJNomd3U3gD1/QCoxPQB014cim34VhEcKQMTtWvo784qW0QSnu3EtkD0r
	 r+Ic2KFQZqKmB6fM9OsLvA/jhmp1Rgf9gueHdF3RXHNvg1rdkw6LlPVT+BF71ISJGW
	 y1lzGZwJXr/6BGU4q1WWEXZ1creHjPHxoYfiLLLTtwp94l9nlr/qUAWFx6tzj0o1IA
	 z2TweULQi3yYw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 07/36] sched_ext: Reject direct slice and dsq_vtime writes for cid-form schedulers
Date: Sun,  5 Jul 2026 15:40:29 -1000
Message-ID: <20260706014058.439853-8-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
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

