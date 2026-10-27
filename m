Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126007;
	b=k3Asn29LQj0udvFBY9FdBHKNdL7YOwjeVBLgwlB9UfnACNqnR/IiyBrD+Xc9zdaHYygV
	 w2ilqRUQrO8o7yi1gNrX8Bzyh7Qx1q4xn6Ut5ihtYwnVcw4PhzLacctMH+kzRLLtRy+hd
	 9Gj/xc7eQLvHf6zOdo48PsnJNb51nMY9DGaE/s9OQWyEOYZGts0Zivh5tnAj6xWHIfADI
	 KgoQdKHoDWI8bzkVFT7Wv4rktozIimA34eMfQ7/580mHeZiO9ANVI7J08RHk54gEh1KqN
	 Hzupyr8OS/P/9NMj7iA+77JfjUxbVwornqU6CsnALJD1VJAF6w77GOfhRI4092LgPhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=N1LY7pJvjkM/pkcUw7KqUMAFNGLmL8TO47KkT32tO/U=;
	b=oBOj5gTMtHs8yRLuVZSJNhAzwmcYzvcAxs43DM+VvOBRnZ5KDZSSRfIPVHnSrSupS4IQ
	 FER+bstATaKNoWR0keqvj+FU9taeKhL7I0bXydhQIi/MOEhdQ5OANxv3Rq5wyjNtwpkGG
	 o6tpHUoPZa+qyOOFqRX1FwPSatexjq1Tk8XFg4rdXLgX3XisVracPGwY9zgB868jhyilt
	 JmrTnTh8pvClbIaeBxLziIWUTP2MqGBvEzRY1ZU60gv6mquIlfeUDycnIu5rQDo0XGyay
	 6sBYJt86Ka696Ee0g/UPhaOy3fbtUE1raObE0Yn1tiDQzfNL2guD0s/2yl2HkJ1n4DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cn9Sv8/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517EE606A31A;
	Tue, 27 Oct 2026 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cn9Sv8/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F841F01825;
	Tue, 27 Oct 2026 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793126006;
	bh=N1LY7pJvjkM/pkcUw7KqUMAFNGLmL8TO47KkT32tO/U=;
	h=From:To:Cc:Subject:Date;
	b=cn9Sv8/XAyyWdogjOGWNcw/WD55dgE0jOXAU0MHnrLsU01JBzL1OyXmUky3efTLRx
	 +fV8vS1Hyzys9pR0/6zGOmW4m4a4EKPex63vg8dlWQrNPNn+DaMWLFy5Ka6sj9owI9
	 e2zJ9luVc8m0u7sRvu7SW9uj5D88+VUTolko2ramJXfpdn+okLBeZobn1+/oYHPbEn
	 jRAPtn3fsknL+//IEFaKUclJ29yDma78f7br39so7DVAV87to9zd+zTKKhJimZObbV
	 k4nC/CD0hB8nWX3o+yiHdATW0DHXEayebZti8NotKtDfY4bFu93Hsx6xglpVy+hhvS
	 qYMSihRPPRiXg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	Junbin Zhang <sprooc69@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Reject scx_bpf_sub_grant/revoke() in tracing programs
Date: Tue, 27 Oct 2026 08:33:25 -1000
Message-ID: <20261027183325.2479784-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tracing program can call scx_bpf_sub_grant() and scx_bpf_sub_revoke()
through scx_kfunc_ids_any, which is registered on the tracing kfunc hook.
Before returning, both invoke ops.sub_caps_updated() of the sub-schedulers
whose caps changed, so those ops run in the tracing program's context. No
SCX op expects to run from an arbitrary tracing context.

With an rq lock held, this leads to the same deadlock that b07a7450f6ef
("sched_ext: Reject rq-lock-taking kfuncs in tracing programs") fixed for
direct calls:

1. A tp_btf/sched_switch program fires from __schedule() with the rq lock
   held. scx_locked_rq() only tracks rq locks held across SCX callbacks, so
   it returns NULL there.
2. The program calls scx_bpf_sub_grant() on a child, which invokes the
   child's ops.sub_caps_updated() before returning.
3. That op calls scx_bpf_cidperf_set() on this cpu, which sees no locked rq
   and takes the rq lock the cpu already holds.

Add both kfuncs to scx_kfunc_ids_no_tracing and rewrite the set's comment to
cover both reasons for membership: taking an rq lock and running SCX ops.

Fixes: 5f2a9a4c2e6c ("sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3c3fb8c18eab..f05d737e7007 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -11831,19 +11831,28 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 };
 
 /*
- * Kfuncs which may take the rq lock on their unlocked path.
+ * Kfuncs that tracing programs can't call. A tracing program can run in any
+ * kernel context, including with an rq lock held. scx_locked_rq() only tracks
+ * rq locks held across SCX callbacks and returns NULL there.
  *
- * A tracing program can execute in any kernel context, including ones which
- * already hold the rq lock (e.g. sched_switch). scx_locked_rq() only tracks
- * rq locks taken for SCX callbacks, so from such a context it returns NULL
- * and these kfuncs would acquire the already held rq lock again and deadlock
- * the CPU. They cannot be made safe for tracing programs, so keep them off
- * the tracing hook. Members must also stay in scx_kfunc_ids_any so that
- * struct_ops and syscall programs keep their access.
+ * scx_bpf_cpuperf_set() and scx_bpf_cidperf_set() take the target cpu's rq lock
+ * when scx_locked_rq() returns NULL. Taking it while the context already holds
+ * an rq lock, the same one or another cpu's, can deadlock.
+ *
+ * Before returning, scx_bpf_sub_grant() and scx_bpf_sub_revoke() invoke
+ * ops.sub_caps_updated() of the sub-schedulers whose caps changed, so those ops
+ * run in the tracing program's context. No SCX op expects to run from an
+ * arbitrary tracing context. One that calls scx_bpf_cidperf_set() hits the
+ * deadlock above.
+ *
+ * Members must also stay in scx_kfunc_ids_any so that struct_ops and syscall
+ * programs keep their access.
  */
 BTF_KFUNCS_START(scx_kfunc_ids_no_tracing)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cidperf_set, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_sub_grant, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_sub_revoke, KF_IMPLICIT_ARGS)
 BTF_KFUNCS_END(scx_kfunc_ids_no_tracing)
 
 /*
-- 
2.56.0

