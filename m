Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E7207E00;
	Sat, 26 Sep 2026 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790450585; cv=none; b=oPhFq0gdUaWTOzOScRJz/YI5s0aDUchhJN+Z9RZ5slOMT9Sp86qQDRBvKyYeQNnHh29uLtyCa1fMT+LamIC8G7DydujOGywQRZE34Ul208Ls3aXK9/JrwOcI98uCOvYMU0wo1slrJjH+jBk4TJQeGUmT8JJkZvUSmhfJrH6/aU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790450585; c=relaxed/simple;
	bh=SC3msJl0bUlex7Gxgs/POd2M0BnP+HzMQ2x58LBMEmo=;
	h=Date:Message-ID:From:To:Cc:Subject; b=E3dTKoDHkQ3Ry3vZqxdcFO4nIeUFDWAGcX52ArD7hjRwfhtq1Y4913tA7njPJLlOBsTytsm5NtLpLyqzKw230pv+rFkka8q1Hpn5z/ay+MI4V8MdMjnS18zOZqY9SOH44NtmK7yzaGI/fYLI267jkXv4MgzaJbOP5E0BwJ3PNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TArPIsLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TArPIsLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C38D1F000FF;
	Sat, 26 Sep 2026 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790450583;
	bh=RJe2LGFgjtPJ9QebL0+4mIVVJg12BQXuInPJJvuM0W8=;
	h=Date:From:To:Cc:Subject;
	b=TArPIsLVtVmb05EtqFkYb5ko0w04HpHEhYjcVFK03z707lWcJCDA0kFPRBoMANssI
	 CrMwTDyO0s4F/QbxgFwvDq/Y3Pr6Qh/7a47e7zLB3s6ESitV7MSWCfqG+eDlrYCEEL
	 it1qV6Z9u7sfJ/rGK5U8y/DQZkd/Ntk5/6sNmraIWhQReT8lJwrrgc63B6ntIT6r62
	 90azssZa+yj0GCcLInqS7fZ7Vu3PZbBOyTVxSRfDZostJrX6v70ej54PYyGakyGRQS
	 iPk2EjFQzUyO7PYxHKYxQ6cgI5sF2IUa781O97IV2QRNIfjHvakMk1Dw7Tui2RTyFT
	 ET3nC97JWXsyQ==
Date: Sat, 26 Sep 2026 09:23:02 -1000
Message-ID: <fa6479d36b528573565ca22914451317@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Add a size argument to
 scx_bpf_cid_topo() so struct scx_cid_topo can grow
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_bpf_cid_topo() copies struct scx_cid_topo into a buffer the BPF program
sized from its own vmlinux.h while the verifier sizes the write from the
running kernel's BTF. The struct may grow and each growth then breaks every
scheduler built against the older layout, rejected at load or written past
its buffer. This is the usual hole for a struct handed to BPF, closed
elsewhere with a size argument, and it was missed here.

Take the buffer size, copy the smaller of it and the kernel's struct and set
the rest to -1. Accesses to the copy are CO-RE relocated, so the struct can
grow by appending fields, which its comment now states. The kfunc changes in
place: the cid interface is still being finalized and no released scheduler
uses the current form.

Fixes: e9b55af47edf ("sched_ext: Add topological CPU IDs (cids)")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/cid.c                   |   26 ++++++++++++++++----------
 kernel/sched/ext/types.h                 |    4 ++++
 tools/sched_ext/include/scx/common.bpf.h |    2 +-
 3 files changed, 21 insertions(+), 11 deletions(-)

--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -912,30 +912,36 @@ bool scx_cmask_empty(const struct scx_cm
 /**
  * scx_bpf_cid_topo - Copy out per-cid topology info
  * @cid: cid to look up
- * @out__uninit: where to copy the topology info; fully written by this call
+ * @out: where to copy the topology info
+ * @out__sz: size of @out, the program's sizeof(struct scx_cid_topo)
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * Fill @out__uninit with the topology info for @cid. Trigger scx_error() if
- * @cid is out of range. If @cid is valid but in the no-topo section, all fields
- * are set to -1. All fields are also set to -1 when no cid tables have been
- * published yet, which a program may observe while racing the root enable.
+ * Fill @out with the topology info for @cid. Trigger scx_error() if @cid is out
+ * of range. If @cid is valid but in the no-topo section, all fields are set to
+ * -1. All fields are also set to -1 when no cid tables have been published yet,
+ * which a program may observe while racing the root enable.
+ *
+ * The program's struct may be older or newer than the kernel's. The smaller of
+ * @out__sz and the kernel's size is copied and the rest of @out is set to -1.
  */
-__bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uninit,
+__bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out, size_t out__sz,
 				  const struct bpf_prog_aux *aux)
 {
+	size_t len = min(out__sz, sizeof(*out));
 	struct scx_cid_topo *topo;
 	struct scx_sched *sch;
 
+	/* the error cases and fields the kernel lacks read as -1 */
+	memset(out, 0xff, out__sz);
+
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
 	topo = rcu_dereference(scx_cid_topo);
-	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo)) {
-		*out__uninit = SCX_CID_TOPO_NEG;
+	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo))
 		return;
-	}
 
-	*out__uninit = topo[cid];
+	memcpy(out, &topo[cid], len);
 }
 
 __bpf_kfunc_end_defs();
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -70,6 +70,10 @@ enum scx_consts {
  * smaller shards if the LLC exceeds the target size. No-topo cids are packed
  * into their own max-sized shards.
  *
+ * New fields are appended, never inserted: scx_bpf_cid_topo() copies this
+ * struct out sized by the program's own layout, and an older program's copy
+ * must stay a prefix of the kernel's.
+ *
  * @core_cid: first cid of this cid's core (smt-sibling group)
  * @core_idx: global index of that core, in [0, nr_cores_at_init)
  * @llc_cid: first cid of this cid's LLC
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -106,7 +106,7 @@ u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
 s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
 s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
-void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
+void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out, size_t out__sz) __ksym __weak;
 void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
 s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
 s32 scx_bpf_this_cid(void) __ksym __weak;
