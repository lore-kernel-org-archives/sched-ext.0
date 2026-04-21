Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DB39D6D7;
	Tue, 21 Apr 2026 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755997; cv=none; b=uZ8rIGlmrg8XcyhlUJYPDfYiv8DzuAmt0vTYSY3TnJcdJe68AW0rdjGaf1GMhZnw8Y3IRo6Nz4B03RR9YLK+pbjxFvuZfeHcu3yKIF3loaMj87li8v+wHo5Jx4Yt9vFP8sWktgt2xIFJEthejgGHXjWxTndcgmudGm6T6WXv7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755997; c=relaxed/simple;
	bh=8kbQ1kV9fZCoEvFHWH6oSa4jyooHJwCV1z5lvC3bMpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KV0ipGUby7BVdTWpjucd7xGlEVt8TL27Zq4JM/V0fem0wTZuxC4/QNKXveSMpnthgXAiv/6G6jxrQPtS7cbMCQtS8AgfHtFp8pOVIGUINKCpTTN9EHldNeeKj51Xo1tIX5Oo+dhxEDD54H/scX4jfJOoEk8hgopKWjbmbB+mJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJtWZQJl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJtWZQJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1471C2BCB6;
	Tue, 21 Apr 2026 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755997;
	bh=8kbQ1kV9fZCoEvFHWH6oSa4jyooHJwCV1z5lvC3bMpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJtWZQJlOTxyy3Fau+Lxx0ns/BXgM5eEMgyu5qHVf6pUgEpwcyhJVADJ+7S35erS8
	 kAOhXXFJTyQer5ADNaCNzLwcyXmCyPnMkQP3r9zh26lmVfalTQKAgy2QVVb16as4qN
	 hUG/7RovLGydbB0CHsh97j5ryCL3z6lBeudPZ17bbCZ5QCXEGbU3+mI7J86xpfI9SD
	 zPPfjHUgEAXRwSRdO6ch2TNPEdx4XdpI3uWp99zGfwHeOYnD9eotQSDSbDHIO9Kllk
	 gH5Jk/sO6lY6v83R8uf9ag9r7CdAQf7NvtZKH4B2oPY8+X8TFOv/4fOatH4fM1LoLs
	 xQFXWcGFWe8dA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/16] sched_ext: Add cid-form kfunc wrappers alongside cpu-form
Date: Mon, 20 Apr 2026 21:19:39 -1000
Message-ID: <20260421071945.3110084-11-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
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
---
 kernel/sched/ext.c                       | 173 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |   9 ++
 2 files changed, 182 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fedad66d13b6..8d52e579b96c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8750,6 +8750,28 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
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
@@ -9172,6 +9194,29 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu, const struct bpf_prog_aux *aux)
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
@@ -9200,6 +9245,29 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu, const struct bpf_prog_aux *aux)
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
@@ -9260,6 +9328,31 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
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
@@ -9280,6 +9373,41 @@ __bpf_kfunc u32 scx_bpf_nr_cpu_ids(void)
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
+ * The current cpu is trivially valid, so this is just a table lookup.
+ */
+__bpf_kfunc s32 scx_bpf_this_cid(void)
+{
+	return __scx_cpu_to_cid(raw_smp_processor_id());
+}
+
 /**
  * scx_bpf_get_possible_cpumask - Get a referenced kptr to cpu_possible_mask
  */
@@ -9328,6 +9456,18 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
 	return task_cpu(p);
 }
 
+/**
+ * scx_bpf_task_cid - cid a task is currently associated with
+ * @p: task of interest
+ *
+ * cid-addressed equivalent of scx_bpf_task_cpu(). task_cpu(p) is always a
+ * valid cpu, so this is just a table lookup.
+ */
+__bpf_kfunc s32 scx_bpf_task_cid(const struct task_struct *p)
+{
+	return __scx_cpu_to_cid(task_cpu(p));
+}
+
 /**
  * scx_bpf_cpu_rq - Fetch the rq of a CPU
  * @cpu: CPU of the rq
@@ -9406,6 +9546,30 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
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
@@ -9593,6 +9757,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_kick_cid, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
 BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_IMPLICIT_ARGS | KF_RCU_PROTECTED | KF_RET_NULL)
@@ -9607,16 +9772,24 @@ BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_IMPLICIT_ARGS)
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
index 3e353dfafb46..4acfc9e8a645 100644
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
2.53.0

