Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2131423173;
	Wed, 29 Apr 2026 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486905; cv=none; b=NeefGHGTp+dw0qBmUmMJX+DXLqFWbrLbsGTKi+lpL/jb7A3e/wj3kOmihJ2A7QWHuAKZ9WiIDrMFvlJ+/AfJ020rqW1s28qORm0IV0h7CPpk/EpM0ag97uTjcl6qsecU43cF+/MRDDNjDanvnOlq/IW6XzK2uCQnQY7y1ZyesLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486905; c=relaxed/simple;
	bh=L8K0I/pAUVl6TbGcdE9wg71sBfpGrjVAIw6uxcnnCRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/m0PedTV/CfFnybiyWb27fz1g0SZCX7qzmPqv+bkkAGBQ/Xgrootvf5v9OKLdkmwYh6LR9tUaWqtZqQGBSBdEpNSnrskHClPVhww3RXL2I4NqO2lBH4rzRaH+KgaM3xvDPBbxmjTty2gORYnj+B8SFHq5NTdt0s1cOrxFWpGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djlXgGel; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djlXgGel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7425C2BCC4;
	Wed, 29 Apr 2026 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486904;
	bh=L8K0I/pAUVl6TbGcdE9wg71sBfpGrjVAIw6uxcnnCRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djlXgGelhv30wXtywhE/Iu6NYDvj0nPknRBbz9JCbvgIkIInDxoGwXOStgzBe4TZB
	 sReL2jRGehXOwWwhvWsNwBHfhT51KfHQBfw2Gzk2G2r4x+xBGza0clfOVgvGx6F2nN
	 fYRupDXMak9qbcvF2zdUXdM5FNiXtXqJveP/iy5Lrb9jRWfn8owuV2ZSzNjvQGgC09
	 o5B/6qDC1uKChNkHGyDXc+PMzeKrc6Op2m74FMnCb/QPTvYr6HPKxI1Sv48AKvgKqd
	 e6mS1tjNrRJx+oq189E7FKezBI229hzxs5cBP5dD+vIXpnsxtuFWEpxcMLYQnrhDGN
	 +nfbN0hCV20hQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 11/17] sched_ext: Add cid-form kfunc wrappers alongside cpu-form
Date: Wed, 29 Apr 2026 08:21:25 -1000
Message-ID: <20260429182131.1780125-12-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumask is awkward from BPF and unusable from arena; cid/cmask work in
both. Sub-sched enqueue will need cmask. Without full cid coverage a
scheduler has to mix cid and cpu forms, which is a subtle-bug factory.
Close the gap with a cid-native interface.

Pair every cpu-form kfunc that takes a cpu id with a cid-form
equivalent (kick, task placement, cpuperf query/set, per-cpu current
task, nr-cpu-ids). Add two cid-natives with no cpu-form sibling:
scx_bpf_this_cid() (cid of the running cpu, scx equivalent of
bpf_get_smp_processor_id) and scx_bpf_nr_online_cids().

scx_bpf_cpu_rq is deprecated; no cid-form counterpart. NUMA node info
is reachable via scx_bpf_cid_topo() on the BPF side.

Each cid-form wrapper is a thin cid -> cpu translation that delegates
to the cpu path, registered in the same context sets so usage
constraints match.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       | 184 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |   9 ++
 2 files changed, 193 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e3a6de5efe02..12e43df08376 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8890,6 +8890,28 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
 		scx_kick_cpu(sch, cpu, flags);
 }
 
+/**
+ * scx_bpf_kick_cid - Trigger reschedule on the CPU mapped to @cid
+ * @cid: cid to kick
+ * @flags: %SCX_KICK_* flags
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * cid-addressed equivalent of scx_bpf_kick_cpu().
+ */
+__bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	s32 cpu;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return;
+	cpu = scx_cid_to_cpu(sch, cid);
+	if (cpu >= 0)
+		scx_kick_cpu(sch, cpu, flags);
+}
+
 /**
  * scx_bpf_dsq_nr_queued - Return the number of queued tasks
  * @dsq_id: id of the DSQ
@@ -9313,6 +9335,29 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu, const struct bpf_prog_aux *aux)
 		return SCX_CPUPERF_ONE;
 }
 
+/**
+ * scx_bpf_cidperf_cap - Query the maximum relative capacity of the CPU at @cid
+ * @cid: cid of the CPU to query
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * cid-addressed equivalent of scx_bpf_cpuperf_cap().
+ */
+__bpf_kfunc u32 scx_bpf_cidperf_cap(s32 cid, const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	s32 cpu;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return SCX_CPUPERF_ONE;
+	cpu = scx_cid_to_cpu(sch, cid);
+	if (cpu < 0)
+		return SCX_CPUPERF_ONE;
+	return arch_scale_cpu_capacity(cpu);
+}
+
 /**
  * scx_bpf_cpuperf_cur - Query the current relative performance of a CPU
  * @cpu: CPU of interest
@@ -9341,6 +9386,29 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu, const struct bpf_prog_aux *aux)
 		return SCX_CPUPERF_ONE;
 }
 
+/**
+ * scx_bpf_cidperf_cur - Query the current performance of the CPU at @cid
+ * @cid: cid of the CPU to query
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * cid-addressed equivalent of scx_bpf_cpuperf_cur().
+ */
+__bpf_kfunc u32 scx_bpf_cidperf_cur(s32 cid, const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	s32 cpu;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return SCX_CPUPERF_ONE;
+	cpu = scx_cid_to_cpu(sch, cid);
+	if (cpu < 0)
+		return SCX_CPUPERF_ONE;
+	return arch_scale_freq_capacity(cpu);
+}
+
 /**
  * scx_bpf_cpuperf_set - Set the relative performance target of a CPU
  * @cpu: CPU of interest
@@ -9401,6 +9469,31 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
 	}
 }
 
+/**
+ * scx_bpf_cidperf_set - Set the performance target of the CPU at @cid
+ * @cid: cid of the CPU to target
+ * @perf: target performance level [0, %SCX_CPUPERF_ONE]
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * cid-addressed equivalent of scx_bpf_cpuperf_set().
+ */
+__bpf_kfunc void scx_bpf_cidperf_set(s32 cid, u32 perf,
+				     const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	s32 cpu;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return;
+	cpu = scx_cid_to_cpu(sch, cid);
+	if (cpu < 0)
+		return;
+	scx_bpf_cpuperf_set(cpu, perf, aux);
+}
+
 /**
  * scx_bpf_nr_node_ids - Return the number of possible node IDs
  *
@@ -9421,6 +9514,47 @@ __bpf_kfunc u32 scx_bpf_nr_cpu_ids(void)
 	return nr_cpu_ids;
 }
 
+/**
+ * scx_bpf_nr_cids - Return the size of the cid space
+ *
+ * Equals num_possible_cpus(). All valid cids are in [0, return value).
+ */
+__bpf_kfunc u32 scx_bpf_nr_cids(void)
+{
+	return num_possible_cpus();
+}
+
+/**
+ * scx_bpf_nr_online_cids - Return current count of online CPUs in cid space
+ *
+ * Return num_online_cpus(). The standard model restarts the scheduler on
+ * hotplug, which lets schedulers treat [0, nr_online_cids) as the online
+ * range. Schedulers that prefer to handle hotplug without a restart should
+ * install a custom mapping via scx_bpf_cid_override() and track onlining
+ * through the ops.cid_online / ops.cid_offline callbacks.
+ */
+__bpf_kfunc u32 scx_bpf_nr_online_cids(void)
+{
+	return num_online_cpus();
+}
+
+/**
+ * scx_bpf_this_cid - Return the cid of the CPU this program is running on
+ *
+ * cid-addressed equivalent of bpf_get_smp_processor_id() for scx programs.
+ * The current cpu is trivially valid, so this is just a table lookup. Return
+ * -EINVAL if called from a non-SCX program before any scheduler has ever
+ * been enabled (the cid table is still unallocated at that point).
+ */
+__bpf_kfunc s32 scx_bpf_this_cid(void)
+{
+	s16 *tbl = READ_ONCE(scx_cpu_to_cid_tbl);
+
+	if (!tbl)
+		return -EINVAL;
+	return tbl[raw_smp_processor_id()];
+}
+
 /**
  * scx_bpf_get_possible_cpumask - Get a referenced kptr to cpu_possible_mask
  */
@@ -9469,6 +9603,23 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
 	return task_cpu(p);
 }
 
+/**
+ * scx_bpf_task_cid - cid a task is currently associated with
+ * @p: task of interest
+ *
+ * cid-addressed equivalent of scx_bpf_task_cpu(). task_cpu(p) is always a
+ * valid cpu, so this is just a table lookup. Return -EINVAL if called from
+ * a non-SCX program before any scheduler has ever been enabled.
+ */
+__bpf_kfunc s32 scx_bpf_task_cid(const struct task_struct *p)
+{
+	s16 *tbl = READ_ONCE(scx_cpu_to_cid_tbl);
+
+	if (!tbl)
+		return -EINVAL;
+	return tbl[task_cpu(p)];
+}
+
 /**
  * scx_bpf_cpu_rq - Fetch the rq of a CPU
  * @cpu: CPU of the rq
@@ -9547,6 +9698,30 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	return rcu_dereference(cpu_rq(cpu)->curr);
 }
 
+/**
+ * scx_bpf_cid_curr - Return the curr task on the CPU at @cid
+ * @cid: cid of interest
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * cid-addressed equivalent of scx_bpf_cpu_curr(). Callers must hold RCU
+ * read lock (KF_RCU).
+ */
+__bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	s32 cpu;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return NULL;
+	cpu = scx_cid_to_cpu(sch, cid);
+	if (cpu < 0)
+		return NULL;
+	return rcu_dereference(cpu_rq(cpu)->curr);
+}
+
 /**
  * scx_bpf_tid_to_task - Look up a task by its scx tid
  * @tid: task ID previously read from p->scx.tid
@@ -9734,6 +9909,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_kick_cid, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_IMPLICIT_ARGS | KF_RCU_PROTECTED | KF_RET_NULL)
@@ -9748,16 +9924,24 @@ BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cidperf_cap, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cidperf_cur, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cidperf_set, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_nr_node_ids)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
+BTF_ID_FLAGS(func, scx_bpf_nr_cids)
+BTF_ID_FLAGS(func, scx_bpf_nr_online_cids)
+BTF_ID_FLAGS(func, scx_bpf_this_cid)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, scx_bpf_cid_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_tid_to_task, KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_now)
 BTF_ID_FLAGS(func, scx_bpf_events)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index ff57a7acdbeb..5f715d69cde6 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -105,6 +105,15 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
 s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
 s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
 void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
+void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
+s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
+s32 scx_bpf_this_cid(void) __ksym __weak;
+struct task_struct *scx_bpf_cid_curr(s32 cid) __ksym __weak;
+u32 scx_bpf_nr_cids(void) __ksym __weak;
+u32 scx_bpf_nr_online_cids(void) __ksym __weak;
+u32 scx_bpf_cidperf_cap(s32 cid) __ksym __weak;
+u32 scx_bpf_cidperf_cur(s32 cid) __ksym __weak;
+void scx_bpf_cidperf_set(s32 cid, u32 perf) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
-- 
2.54.0

