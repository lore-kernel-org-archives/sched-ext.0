Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792828036;
	b=ZNwAq4UcSEvs8AUxwHM48WfobNcmumBLiM38H+Dx6fZ6nQCFLExV3K4RxMvUfRZz30pZ
	 h9bTH45wrXEyOA0smZpdpAIHnAxAzb6UjsjIdYEiHus707zqNEhpmFE7GRny1cx3gNJRc
	 kScXYB4M1U2/LUNCOkzS5EUCQo2WHS5hqE6Rg18wSWLlP04if0r40+Zst3MNmfszARr4X
	 B7jERZKcUb72xaR1SPDTdFi4ZmBwWQxQL/NpOFjO+3AFZ27+x8v6H4TgT24qY0cCcuX/f
	 MFuFi5lk3oyUC6refAC12iMAtruWQgVfHOGYZ8FvOj7WEnOix4ORkthlNEN/7h45nfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792828036;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-USESPAMBG:From:To:Cc:Subject:Date:
	 X-OQ-MSGID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ah8RfH5v6OYr6iRTpj8ge+YVLnDp8X2o3dtZGTD58eo=;
	b=gEaTiUTKtCTLDwaT5Og1rp8wWUdHRs8VZ0yJpE8qOnuLqHen4mpCWWq/iJbOVtd8jVuN
	 Xe9Ub7j0pWAquzj4KFdVNM5fXmWBkGM0tGSOBR8W2tkxcXCgwnOkhJox+/al/197foZCx
	 E9xy+mw6F/or9phJStLRCrztURy6DAbAB9nAAVdUhu7T41atDuSx0M+oO7KkBAkvTJWk1
	 nl8aNP1UIUXqGrxYSRX4lL7MzmrWHkTEyxZThAe4KbhImyV1S5KBub3ZztGPy2Q1ILv2J
	 TDs6qjWF5lZva0Dgq3NQm48SexSZ332bbciecsfSTZK+XVwdb6n2X2BTwvntMtL7I1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=w+pf4eL8;
	arc=none smtp.remote-ip=43.163.128.55
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.55])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EAC606A31D
	for <sched-ext@lists.linux.dev>; Sat, 24 Oct 2026 07:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0EAC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=w+pf4eL8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792828031; bh=ah8RfH5v6OYr6iRTpj8ge+YVLnDp8X2o3dtZGTD58eo=;
	h=From:To:Cc:Subject:Date;
	b=w+pf4eL8pW2BWe4LQtKh5kmPCl6pzC8KxFmXVEsJofRRPjJumRmhLTzpfxCeHwE1S
	 wAfduBu5t2c4Ww7R7Twuno9Xfsz1f5m8/1abm7RvZ8xUuZWMZ6RPJXG9EZ/2KHVnsM
	 dRc7X7aSgp+0GBWw4cXAY04jcyqJqrNicH3GFkvU=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id BC9926FE; Sat, 24 Oct 2026 15:47:09 +0800
X-QQ-mid: xmsmtpt1792828029tygxfm8yk
Message-ID: <tencent_572AA31E5369BE41464E9DDA4CEDA2DA7C09@qq.com>
X-QQ-XMAILINFO: MMvVzQSdFuTpdNSqRJc+XE/41x6b9sScCnCsoioCr2kejld7QaiKnKuHS7QsXL
	 U4XeL7927WYVdsD53LTN0avhEoPmy2fb58DjGXvQfK5ztD35S+IPW8pvF8q2FuP0EDpHrVZemgYY
	 vn74SBxrP/jPf7ra7OKb0e9OKIf6iRWxsB4L03qdyjWYcmNoppd/OnUIE+xGwohmY+cyAzJj2Bnb
	 IsxXytK5ujvG22he8DwYpGXgZgNqLsqBM5Y58bPSHEdNAV97Jno+NIN546DSNmZ6NSRDUOJIE/IH
	 lik/UsxYnOMGoTIjah0I08ChwfHRYhiw2ZCtKehQhuSqLWkN0BPva2eufCQwI6V7L1nNRqPwGDE5
	 7ZBswPXXLwyrTb1VBciV+HA73v1EWGsbR8q4W62N4wBmCmP7ltJ8KdiYAkofrJQwuBJwnqpnwNCd
	 9FlE0WZ5ZOVl8VeooaISwElEULTq5AZmVVsSZ2NgcJWBHjeNfb+B+4Y3zdh7GLWq7kUmzsd7xN06
	 UOzhmeIfWSRBzScI7ikqgGCG5z8gFneQgiXq1S9BUGMk/d4wCf0N/8+aWqbkHoX7WCXXTIrFP8Mh
	 tfpoINimL3hL9B10ad1bdDvENaB6eKhYD3ZVzXFm7Ptn8tJHvwfw1MbrceWOabMN/f0RHrrNlbU5
	 oUH4ki1YphTmCTXEFZKy/N9G6/ERTnoK1LAyihf/2UjGHv2zfHnUQN0fAHU8DaKw23sTKy/uG32I
	 Q7X1fcfhPTnAvfROckR8WzdWqgVaoQzsE2rWUTj7EtwIpFUo1pR0fyhu4HdgQzzGVYuO+hbpdO8L
	 xAHamjFUg/s+7ywqqTniPjSfyMDweaO1fk58OvK8j9/Jfm8hPlGnxvtnbJu/JJ+q5TcppGRKQNmC
	 1PCSiwpPPn+QHERxLcHVgpJGxngVpdR1XgYktYXT7FadAzy7uHX42cTKgicAvqWvsfYqin/alMLT
	 yVQtqlod+//5SgnIqKW0QJs94HsA6S78/oviWVFcO1aH3v/OpSiaMuBkpyxBkW4WWSDf2Yh/SanG
	 pDRgW7hgylNn2JowpFBLyM+s9ql5htmb/e6YPiWPMnewXkQuN+0Pn1FNvyJhnvuWfKMd4qnVEixE
	 +0PKhl
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-USESPAMBG: true
From: Guikun Yang <yangguikun19@qq.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [BUG] sched_ext: sub-scheduler kfuncs use struct scx_sched beyond the RCU read side under sleepable ops
Date: Sat, 24 Oct 2026 15:47:07 +0800
X-OQ-MSGID: <20261024154707.71448-sched-ext-yangguikun19@qq.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Tejun,

The four sub-scheduler kfuncs scx_bpf_sub_grant(), scx_bpf_sub_revoke(),
scx_bpf_sub_caps() and scx_bpf_sub_kill_bstr() obtain the child
scheduler through scx_find_sub_sched(), which is an
rhashtable_lookup() call.  rhashtable_lookup() is the _fast variant:
it takes and releases the RCU read lock internally, so the returned
struct scx_sched * is only valid inside the caller's own RCU read-side
critical section.

The kfuncs themselves only take guard(irqsave)() (sub.c:2323).  They do
not hold an RCU read lock and take no reference on the scheduler, yet
they use the returned pointer for their whole body, for example in
scx_bpf_sub_grant():

	struct scx_pshard *pps = parent->pshard[si];
	struct scx_pshard *cps = child->pshard[si];
	...
	scoped_guard (raw_spinlock, &pps->lock) {
		guard(raw_spinlock_nested)(&cps->lock);
		...
		scx_cmask_for_each_cid(cid, changed_cids)
			queue_sync_ecaps(child, cid);

These four kfuncs are registered in scx_kfunc_ids_any (ext.c:10868),
and the context filter unconditionally admits in_any:

	if (in_any || in_idle || in_cid)
		return 0;

so they are callable from every sched_ext op, including the ops that
bpf_scx_check_member() (ext.c:8194) explicitly allows to be sleepable:
init_task, cgroup_init, cgroup_exit, cgroup_prep_move,
cgroup_set_bandwidth, cpu_online, cpu_offline, init_cids, init, exit,
sub_attach, sub_detach.

A sleepable struct_ops program holds no normal RCU read lock.  The
sleepable trampoline only takes rcu_read_lock_trace() and
migrate_disable() (kernel/bpf/trampoline.c:1446), and the framework
documents this at ext.c:10567:

	/* KF_RCU covers only @p - a sleepable program holds no RCU lock */

On the teardown side, sub-scheduler destruction drains only normal RCU:

	/*
	 * All tasks are moved off of @sch but there may still be on-going
	 * operations (e.g. ops.select_cpu()).  Drain them by flushing RCU.
	 * ...
	 */
	synchronize_rcu_expedited();
	scx_disable_bypass_dsp(sch);
	scx_unlink_sched(sch);

(sub.c:1626) and the release runs from scx_kobj_release() via
queue_rcu_work() into scx_sched_free_rcu_work(), which ends in
scx_free_pshards() (kfree of the pshard array, sub.c:135).

There is no synchronize_rcu_tasks_trace(), call_rcu_tasks_trace() or
kfree_rcu_tasks anywhere under kernel/sched/ext/.  A normal RCU
grace period does not wait for rcu_read_lock_trace() sections, so a
sleepable op running inside the teardown window keeps using the freed
scheduler object.

Trigger sequence:

1. The parent scheduler implements ops.cgroup_set_bandwidth as a
   sleepable program (explicitly allowed).  Its caller,
   scx_group_set_bandwidth() (ext.c:5044), only holds
   scx_cgroup_ops_rwsem, not scx_enable_mutex, so it can run
   concurrently with sub-scheduler teardown.

2. The op calls scx_bpf_sub_grant(child_cgroup_id, ...) (or
   sub_caps/sub_revoke/sub_kill_bstr).  The kfunc resolves "child"
   once in sub_cap_preamble() (sub.c:2270) and then dereferences it
   throughout.

3. Concurrently the sub-scheduler is torn down (its dispatch calls
   scx_bpf_sub_kill_bstr() which goes through scx_exit_bstr(), or the
   sub-scheduler itself calls scx_bpf_exit(), or a scx_error() fires).
   synchronize_rcu_expedited() does not stop the sleepable op; the
   reference count reaches zero, scx_kobj_release() queues
   scx_sched_free_rcu_work(), and scx_free_pshards() kfrees
   child->pshard[].

4. The still-running sleepable op reads the freed child->pshard[si],
   takes its raw spinlock, writes caps_updated and the delivery list,
   and calls queue_sync_ecaps(child, cid), which also reads
   child->pcpu after free_percpu().  A sleepable program only has
   migrate_disable(); it can be preempted, so the window is wide.

Impact: kernel use-after-free.  Under KASAN this is a clean
slab-use-after-free on struct scx_pshard and on the scheduler object.
In production the corrupted raw spinlock and list nodes lead to
arbitrary later crashes.  Loading a sched_ext program requires
privileges, so this is not an unprivileged attack surface, but the
kernel is crashing on an API-legal call sequence.

I verified against linux-next (2026-10-23 snapshot of
kernel/sched/ext/sub.c, 3198 lines vs 2682 in 7.3.0-rc7): the four
kfuncs are still in scx_kfunc_ids_any, the sleepable whitelist is
unchanged, scx_group_set_bandwidth() still takes no scx_enable_mutex,
and there is still no tasks-trace RCU anywhere in the directory.  The
new nr_ecaps_reports/ecaps_report_wait mechanism (7.4 series) covers
per-cpu ecaps reporting, not this path.

For contrast, the DSQ iterator (bpf_iter_scx_dsq_new) has exactly this
problem and solves it with KF_RCU_PROTECTED plus the verifier's
MEM_RCU handling, which makes sleepable programs wrap the iterator in
bpf_rcu_read_lock().  The sub kfuncs take a cgroup id (an integer), so
the verifier has nothing to track and there is no equivalent
enforcement.

Possible fixes (for you to pick from):

  1. Take a kobject reference on the resolved scheduler and drop it on
     return (kobject_get/kobject_put).  The pshard free happens after
     the kobject refcount reaches zero, so holding a reference closes
     the window.

  2. Move the sub kfuncs out of scx_kfunc_ids_any into a group
     constrained by the per-op allow table, and drop the relevant ops
     from the sleepable whitelist.

  3. Make scx_group_set_bandwidth()/scx_group_set_weight()/
     scx_group_set_idle() hold scx_enable_mutex while calling the op,
     serializing sleepable cgroup ops with teardown.  This fits the
     existing design (the other sleepable ops already run under
     scx_enable_mutex) at the cost of a global mutex on top of the
     percpu rwsem.

Full analysis with line references against 7.3.0-rc7:

  sub.c:95      scx_find_sub_sched() - rhashtable_lookup()
  sub.c:2270    sub_cap_preamble() - child resolved here
  sub.c:2323    guard(irqsave)() in scx_bpf_sub_grant()
  sub.c:2346    child->pshard[si] usage loop
  sub.c:2570    scx_bpf_sub_caps() same pattern
  ext.c:8194    bpf_scx_check_member() sleepable whitelist
  ext.c:10567   "KF_RCU covers only @p" comment
  ext.c:10868   scx_kfunc_ids_any registration
  ext.c:10975   scx_kfunc_context_filter() in_any passthrough
  ext.c:5519    scx_kobj_release() -> queue_rcu_work()
  ext.c:5492    scx_sched_free_rcu_work() -> scx_free_pshards()
  trampoline.c:1446 __bpf_prog_enter_sleepable()

Thanks,
Guikun Yang

