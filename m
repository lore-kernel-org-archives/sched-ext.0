Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301CE3A48F1
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663196; cv=none; b=Ouf7QDj89V/ZCwD+KdbDzBrJqBmYttBuXxbjCAsWiNPob8wXiptl0fsxTzEqsLT9oV/RXnxohWGNNTPowC6+s8BW1ykLVMcVJfX/HMv1ESKzgmIm2gHgZDeyQL1iQE5075VcqXa3pB+dxTUVsl1kRupW0SfdF1nIObV9+M887oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663196; c=relaxed/simple;
	bh=U5eIq2jJdcr+HL+4cEu8OsiIz4xlUlqpyeR32pmymi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAMQZEXaZ3VWj1SRGz3nhOvDYai1o7J/4SIDE782Ndnm/06GFOlEtEyxxV6Fa9bISnvhUDggMrIhv6qiBPh4MwDU+UgfCuZi6GjvHWrGEFaqrPWkXDvFNHACQ8VXonNLwazJLgBOvR5jK0PLnxKwqUhVDzUodgokcIjtKV5ZiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io; spf=pass smtp.mailfrom=likewhatevs.io; dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b=QwC7/MwB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PKpa28h+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=likewhatevs.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b="QwC7/MwB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PKpa28h+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 455EF1D000A8;
	Fri, 10 Jul 2026 01:59:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jul 2026 01:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=likewhatevs.io;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783663193; x=
	1783749593; bh=qPtB2jeXZq8nRuvXh/pXPmUfbAQFKKHP5XyTdhwFbto=; b=Q
	wC7/MwB/CAbL/eyyCFGVyLn3KAPgjNrohiYB0vb6Tcv3TUpKHyR8cg0chgKyTviM
	UJrh9CZZC8UwUyhdtFBmFVpoxwZ7fjGY0ydNZUApLkQ/UL1OLlqt8Qg+Efe8pCwE
	h//3ZF3gXQD/uasfg2tozZ9lAnfcX5cwgcMMqJMF62bcj51c/EdbcsswvdfzJ7eY
	RuU+3r056F+yPTIPBy9j+Qjvwkqx8JX0Jb7rUxBaiOs2aTkLwyjrY23qOgNb5S8L
	0bRGu1bs7pHtP+D/ilSPStuF68Jm66u5L+yv9eh0Kj2F+aan8c4+5tlbeNcjN/GV
	J5d1mEhYiQoHHV/BDnBeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783663193; x=1783749593; bh=q
	PtB2jeXZq8nRuvXh/pXPmUfbAQFKKHP5XyTdhwFbto=; b=PKpa28h+VsVfzEXQI
	6ulnutyypVsBGWwXXMtvSQ2xdMz2GookRBfKnN9erhdaLBpakyZtl9RJXmMstvH+
	x7US4VodCdkFthU3hWqn7D3OGl4Ljv2Xhko7HCW+BQy5fnnRKdjrkKa00X5x+uWR
	MxG7zWeH1Hz7D8bzU/KJovFi5SlxqNUSGUr1nDj3TJY1FQS8Vj09xUNHMnale+UE
	bUuNJJfhjBYHDUjxk7xVrwfwjFPpZxdUh35OV2UGFwpx8qkHCln++RV+R7uT8too
	2IJXVeGs9Cuj6taFaFwO1lNCA9u5IytJ9wKboOuSa+ruyGxXjrdAWvWRZEOvPOCN
	e+btQ==
X-ME-Sender: <xms:WIpQasVb35w8CTSsd6d_VtcKo7XeR8wFTQCjQkAK2OzRIacfuS-uOw>
    <xme:WIpQaiE7ymyLiioOjW1xC9RJ-ANeOw-gtTdgOXZ6t5BuXy5yFl2PVi-UfXOHXpsBh
    _XurMRj977v-Dq2FWF6eG9IF5fk7wkP16b2UxcjRaz4bg0vt5j0Rbj3>
X-ME-Received: <xmr:WIpQageQvFhyon1gdBPZvdRR0zIG3UwsFq1l8gMdcLkdh9teMKCtNBb6EWITe8QFctGYlPX6q-GZzA>
X-ME-Proxy-Cause: dmFkZTFdbX781tJ9LjFh+flZnCl7OlU7A3B5rLsLEKTlOltii4CpfyrXUdEavLpjFWWfCx
    wT8LmsurgKSubKfdEl5nUrtKDHNuSwuHe86jZh1cD0MPrG4x8ZFEkmTQWrUziVwwFQ2SRG
    Wz167mhs9h1CYFbZamqTj/G1Nt6way5H5uAs3qO2ovmZpF9a7ukl1V12BfOQohoElNDfcD
    CU4Gz5+zsqQO5grXuYjmBgE4eoCPhfbTp/dbB/KCKNcgSz6ehQTKX829mY2h06/JtbGCBj
    KTUdnDYBhnSoQIWZo51n0qhPt6p0KfQvLBqu/K3Al1xhYUXZNunMzrQJ4XSPMiU2AFXit1
    9udI7fiRoNMfwDS+9Uo/GpVza5k+ObEf9164XqlhBIBN7ZVqncMSwbsKAcYuzACPL907eJ
    DgxTLdLouSxLtbNFz84dIg2hDve7j/GrytQ2dQcLEop3zcrLb2POXXeINoWryX1pV24kPd
    FS3EbrKI3Os0f+gmJhHGUgI7DLIlWspQvQMuSO0O2h75xKvWnZdRh3L9Q1Txi8pPsf2JtM
    vgXdoSkv/rF+fIeFaopFISe+tO/n14sQbg5ovUpI5Y9M7oFCgepnHzgXidx2OBVEIrW0Ns
    QxrwXaszIbGvJM1FpQFpH7yYZLrMUXm39GPoePXUyvtUakgGB8Ie9GR9EX0w
X-ME-Proxy: <xmx:WIpQarL2Hw7WYINoU8ut65EwJ9-wEzHOiue4u0sfuAjS7X953ChgBQ>
    <xmx:WIpQatE9kdnIlhhOuBw6C03Lp8cAuE7dbbTNyfSllyoIL-hp71Jb4A>
    <xmx:WIpQamBZflLgc-l3-cfj7cNIWTWmRWA9tPLtkhZoW6WO7rEK5sostA>
    <xmx:WIpQao-oW5HOfS9-YAsyzlS5yILOmTwHIqRCHHHsXKho-M3lw_VWmQ>
    <xmx:WYpQamhuDYMoI2I76X6lHEV1PWlJIt04VV4aSPsw8W-P6WZpMw4rLLeJ>
Feedback-ID: i7f194913:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 01:59:52 -0400 (EDT)
From: Pat Somaru <patso@likewhatevs.io>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pat Somaru <patso@likewhatevs.io>
Subject: [PATCH v3] sched_ext: Add tracepoint for scheduler exit
Date: Fri, 10 Jul 2026 01:59:11 -0400
Message-ID: <20260710055911.914465-1-patso@likewhatevs.io>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2d3d31a802b30f340248db4a986cfa4c@kernel.org>
References: <2d3d31a802b30f340248db4a986cfa4c@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_ext schedulers have state in BPF programs and kernel. scx_dump
provides kernel state and BPF program state on error, but this is static
in what it can provide.

Add a sched_ext_exit tracepoint in scx_claim_exit() so that BPF programs
can dynamically inspect scheduler specific state at the moment of exit.
Pass the exiting scx_sched so attached programs can read its state, and,
since exits propagate through a hierarchy of sub-schedulers, identify
which scheduler each event belongs to.

Signed-off-by: Pat Somaru <patso@likewhatevs.io>
---
Hi Tejun,

> Thanks, but name and level don't pin down a scheduler in a hierarchy -
> same-program instances under sibling cgroups share both. Recording
> sub_cgroup_id and cgrp_path too would make the events self-identifying. Both
> are already on sch. Care to add them in a v3?

Good idea, I added this, thanks!

v3: also record sub_cgroup_id and cgrp_path so events are self-identifying
    in a scheduler hierarchy - name and level don't pin down an instance
    when the same program runs under sibling cgroups (Tejun)
v2: https://lore.kernel.org/all/20260707090314.2567145-1-patso@likewhatevs.io/
v1: https://lore.kernel.org/all/20260512055632.1096713-1-patso@likewhatevs.io/

Tested by running scx_mitosis, attaching to the raw tracepoint and
unregistering the scheduler:

  # bpftrace -e 'rawtracepoint:sched_ext_exit {
        $sch = (struct scx_sched *)arg0;
        printf("sch=%p name=%s level=%d sub_cgroup_id=%llu cgrp_path=%s kind=%ld\n",
               $sch, $sch->ops.name, $sch->level, $sch->ops.sub_cgroup_id,
               str($sch->cgrp_path), (int64)arg1); }'

  Attached 1 probe
  sch=0xff3bd35691464000 name=mitosis_1.1.0_x86_64_unknown_linux_gnu level=0 sub_cgroup_id=0 cgrp_path=/ kind=64

and via the tracepoint's formatted event:

  # grep 'sched_ext_exit:' /sys/kernel/tracing/trace
  scx_mitosis-51 [000] ...1. 30.552740: sched_ext_exit: sched mitosis_1.1.0_x86_64_unknown_linux_gnu level 0 sub_cgroup_id 0 cgrp_path / kind 64

 include/trace/events/sched_ext.h | 28 ++++++++++++++++++++++++++++
 kernel/sched/ext/ext.c           |  2 ++
 kernel/sched/ext/sub.h           |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
index d1bf5acd59c5..1e54f9564ef3 100644
--- a/include/trace/events/sched_ext.h
+++ b/include/trace/events/sched_ext.h
@@ -84,6 +84,34 @@ TRACE_EVENT(sched_ext_bypass_lb,
 	)
 );
 
+TRACE_EVENT(sched_ext_exit,
+
+	TP_PROTO(struct scx_sched *sch, __u32 kind),
+
+	TP_ARGS(sch, kind),
+
+	TP_STRUCT__entry(
+		__string(	name,		sch->ops.name		)
+		__field(	__s32,		level			)
+		__field(	__u64,		sub_cgroup_id		)
+		__string(	cgrp_path,	sch_cgrp_path(sch)	)
+		__field(	__u32,		kind			)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->level		= sch->level;
+		__entry->sub_cgroup_id	= sch->ops.sub_cgroup_id;
+		__assign_str(cgrp_path);
+		__entry->kind		= kind;
+	),
+
+	TP_printk("sched %s level %d sub_cgroup_id %llu cgrp_path %s kind %u",
+		  __get_str(name), __entry->level, __entry->sub_cgroup_id,
+		  __get_str(cgrp_path), __entry->kind
+	)
+);
+
 #endif /* _TRACE_SCHED_EXT_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1a0ec985da77..6ec774435cd1 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5730,6 +5730,8 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	 */
 	WRITE_ONCE(sch->aborting, true);
 
+	trace_sched_ext_exit(sch, kind);
+
 	/*
 	 * Propagate exits to descendants immediately. Each has a dedicated
 	 * helper kthread and can run in parallel. While most of disabling is
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 460a9fd196dc..9b5ac07e5e76 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -25,11 +25,17 @@ void scx_sub_disable(struct scx_sched *sch);
 void scx_sub_enable_workfn(struct kthread_work *work);
 bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux);
 
+static inline const char *sch_cgrp_path(struct scx_sched *sch)
+{
+	return sch->cgrp_path;
+}
+
 #else	/* CONFIG_EXT_SUB_SCHED */
 
 static inline struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
 static inline void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
 static inline struct cgroup *sch_cgroup(struct scx_sched *sch) { return NULL; }
+static inline const char *sch_cgrp_path(struct scx_sched *sch) { return "/"; }
 static inline void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch) {}
 static inline void drain_descendants(struct scx_sched *sch) { }
 static inline void scx_sub_disable(struct scx_sched *sch) { }

base-commit: 57194a3172ba0123e8f37c4574a8e2863ab67622
-- 
2.55.0

