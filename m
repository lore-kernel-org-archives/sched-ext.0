Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C166386C08;
	Fri, 10 Apr 2026 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802649; cv=none; b=skGWBC2VZxf8CmvAubWchLW4M/M5zb3JicK+7VUW0xqD2kKbHAY/4mPY+cMZ6B61X0WFCSKXK0kvY0p5WSZWw8yfbKYLNx0P8v4Sj4KJ+OL22zz98NJeabNPNnOx0BsUp4rNbycIqtkhl25Or/zXDU04hltoc1gHs3ZfyljzFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802649; c=relaxed/simple;
	bh=5ig7wCBeIbg8liz81/giiWDah2fXawg/C50oKl6Rpiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gddQaw7kuy7/QjFta0gDRhuOspUAwQacSI7jH6zVj5EzK1ANlcb9OvJHVHYf2P7ctALk0DZsrKXpOaAeyaSTsrNBPAZgNmumm86AKjxJ6qJ6fJ/8tZ9oEtBv/RHhyQdX+j1eOteuNoXiqIOebSj7AvbUKVaEMnvEm5Wjavs/7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckS9I40S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckS9I40S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A1BC19421;
	Fri, 10 Apr 2026 06:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802649;
	bh=5ig7wCBeIbg8liz81/giiWDah2fXawg/C50oKl6Rpiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckS9I40SGRYkcmyZx/+nIGtPKCY2onz0Y/PiLTFK3Ax4RzJeb1cX4p4KT/XZm7R6R
	 20x0IlnEd/6ni9C9sxgdJ/P6upvjuUvmEJOObvayuYvAGN5tp9hKHKXJGzS3l7Zovj
	 pnLADgVLXSGGfY7bGTncs1yCiP09LDtpFaNYPgs/QM745yGnxvnb/9mPlChUMGONqI
	 jYddcR0oK1/uorytGR+hy6tuG7da4YNG9N4l+aYzHMdJGxINmyS4VGKSzDETDLvErZ
	 g/tUo+pENAlwYchPsWxQxrtO6YlS2TGZdApXaVNPAGVrh4vT47pT8+urlto7VtU7aD
	 EJDd+5IoG21Yg==
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
Subject: [PATCH 01/10] sched_ext: Drop TRACING access to select_cpu kfuncs
Date: Thu,  9 Apr 2026 20:30:37 -1000
Message-ID: <20260410063046.3556100-2-tj@kernel.org>
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

The select_cpu kfuncs - scx_bpf_select_cpu_dfl(), scx_bpf_select_cpu_and()
and __scx_bpf_select_cpu_and() - take task_rq_lock() internally. Exposing
them via scx_kfunc_set_idle to BPF_PROG_TYPE_TRACING is unsafe: arbitrary
tracing contexts (kprobes, tracepoints, fentry, LSM) may run with @p's
pi_lock state unknown.

Move them out of scx_kfunc_ids_idle into a new scx_kfunc_ids_select_cpu
set registered only for STRUCT_OPS and SYSCALL.

Extracted from a larger verifier-time kfunc context filter patch
originally written by Juntong Deng.

Original-patch-by: Juntong Deng <juntong.deng@outlook.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_idle.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index ecf7e09b54ae..cd88aee47bd8 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1469,9 +1469,6 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_IMPLICIT_ARGS | KF_RCU)
-BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_idle)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
@@ -1479,13 +1476,33 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
 	.set			= &scx_kfunc_ids_idle,
 };
 
+/*
+ * The select_cpu kfuncs internally call task_rq_lock() when invoked from an
+ * rq-unlocked context, and thus cannot be safely called from arbitrary tracing
+ * contexts where @p's pi_lock state is unknown. Keep them out of
+ * BPF_PROG_TYPE_TRACING by registering them in their own set which is exposed
+ * only to STRUCT_OPS and SYSCALL programs.
+ */
+BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
+BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_select_cpu,
+};
+
 int scx_idle_init(void)
 {
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_idle) ||
 	      register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &scx_kfunc_set_idle) ||
-	      register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_idle);
+	      register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_idle) ||
+	      register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_select_cpu) ||
+	      register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_select_cpu);
 
 	return ret;
 }
-- 
2.53.0

