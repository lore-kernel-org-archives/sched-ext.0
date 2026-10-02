Received: from outbound.st.icloud.com (st-2006i-snip4-11.eps.apple.com [57.103.76.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276D481672
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945190; cv=none; b=gB+HyMEqMqzF2V2TAH5o2p3UW9iu6iUmrRphIzh7PBeeERLbf4MBSF1rHstvpHp3cYHsswnfPSGc2gPkLwNfRLPTUdqPfO6G2H3agXcU8OXeDgbVFh3qrzvzovon+kP6pyEzwcYsLw5TEC7cLPwev3UlX1skcB+1Tp2XqDKjF1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945190; c=relaxed/simple;
	bh=uTZ2Msm1bFQOaWXuw0goE4NYE/PiReH47ExlMX4JleY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWWnizYj4vkGhzGoiom3bTNHD2NzBrZv7f4iGpt7715QsZfVrzgwPUshbeiCHXPXIzSFGDTw3Uuo82IS+Yz8zhFMTqu0HvyRyI9amVaEyzhmXtvxKYwRsgqKayGEMrNrkrsXxKtcA6uTGuZapZOnFSyNfkb2JTCtQBsZJ5bcdIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=S9Bgp8WC; arc=none smtp.client-ip=57.103.76.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="S9Bgp8WC"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id 769971800278;
	Fri, 02 Oct 2026 12:46:21 +0000 (UTC)
X-ICL-RepId: 01a0fca6-bea1-7963-9304-6c68dca42052
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwORQFEF0oBTVIPDxRcFFofVgVyBlwKVwRUHxwXXlhVCQodVwJdEVAZGQxVUEsbDlwPS1oVVRcOAkIfUB9MFldDRB8cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKHVcCXRFQGRkMVVBUEVdQC1kCQg9JA10FWgBEDE0KQwZbAUYOVQJAUw5eGUsZXS1BDkAUUBtHQ1AMDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1790945185; x=1793537185; bh=JMWannhlf3vc6cpm3QLXkPwrg+Zi3B9XTT50gbnd6pM=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=S9Bgp8WCHzLgZamVP5Sc6ML4uj+5nHISNjQKx/VI6GQ2sAw6rEVw2VXHEmgIBS55zB+tz5QGt1rkDg2vJL3/NcBczoRwA8C+DhJ3FY1+2E6vWGJyD1d0umgHev0rhB//XJSQU4upUxfi0310aLxLQX0tDCXVSwzZ8vciK8Q4Zm0jl9al/KlAU4DvTHvR8jZXi4K2Xq4VN8SRjJ47CDNyS9H97I/+I5c5BYQNx/T6reeeXm60YO4+Jp0j71s/UZcPo/qYbUXwXKAx7lCQxE9YwByIwf5UxDkDjYsL1SE5LnbMozVir8wjAT7SKARu8OhNaUr+cXVTmk1KgxYnF8HeCQ==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id 72CDD180026B;
	Fri, 02 Oct 2026 12:46:17 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Vladimir Vdovin <deliran@verdict.gg>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hui Su <sh_def@163.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] sched_ext: Drive the NUMA balancing scan for SCX tasks
Date: Fri,  2 Oct 2026 15:45:31 +0300
Message-ID: <20261002124559.10367-1-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=JLU2csKb c=1 sm=1 tr=0 ts=6abfa79f
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AzMV9amX_PX6-bkl-foA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1MCBTYWx0ZWRfX6fWROFrH2JnT
 uMHsXyYz+dcAh1l0Vop6hYu0gZlVpUwTl4y0gzJmO13mNc1e9g4trOzj+Mg+0Pgz3m4aH7RFGrv
 i+qsDBJkJJwC2yg2FIIZYrzAxND7DqE8NHQkYsdift3p+ia1iw0BYRBGcLgF48qVWV1jBVmlTvN
 05TXJJHgdff9Vc80RgOCsTjPN+KpTUgSzNIkq/n3OsLpzTGHUyWk7INNsSTiJuqIWzlQ6BEirmn
 8NeVS62Lz5odldpZ8fGQ3stisYeBgU2BfwZbDxAg7EAf4P8lNQZZHzsBl5M9q3yG+U/GzOHqxPA
 piQ3Z1aRn85YlbfdoM/RSHAq3U4pNNyBJ509L8Hs5VBpdXJNmEvcKFLgtulcwo=
X-Proofpoint-ORIG-GUID: 7vOcNMKqGXT4V5jTTl24QbSkRdnqdHBc
X-Proofpoint-GUID: 7vOcNMKqGXT4V5jTTl24QbSkRdnqdHBc
X-JNJ: AAAAAAABfcpVKPyVCy5mQijTXK/Uerx28Jc6gaE8Ayp3zE2OnZWt3W4QHFphv7lghfhyxx
 czrBsiNdWU6OqcYZ76Qusv3OsRSBPS/J+tveFY+2dFpkG3s85vVhXnWRMiLg3noZlTdX4P
 i71Yq+dW0Ju5+XWGmslXQ+B7yBra0HJGwVnOeP/dR7/KNWOpKyfzgfOZE0CFf8qLTTB73q
 Yuc7ML4NCnnwWXVQ2MkBHT0P3J8/IIfLee21Vf1DhkhftcerKRknjmPnAhXhmqsnI36euO
 YiEsZcyA6/oXGs9FB8WHph/Lg/5lSeepPITms+/vpYyRJ2U8P/BK8wVtBqWXP8QvkLDU6Q
 6689oYwwil5hqfc/p8hoA7ajhZRR10oFy3W1fmT7KMY1QDZih3+fd987N+3PPf2fA4b2kH
 bMrX9mLsy6oYKHac+MLwjHfOMY+/uz9dxaiR/yVgD1Jf5HdCyssDCIsb+zz4IjDV/GtiKI
 w7uZmcEaaUgomoHc7luRqVb4dcifHxXkTRxF0HKC/HICgxDTMWk8rZD4MizSJQFnYzAFaz
 k8WqD92jVpSxfDv69xsQ9dp5T60YGctbcPpMbA4c0pgxslEhieoHyD5zwHWfs1UKWQfns4
 OEFrXGn6JljyfDhztvBSoCNi0xA9glEQHnBe9p5No7aPCOzChRg5+v4X+Z+QQhhtpknNuo
 hr5R3AtyG4B+E0GCh4YRAYosSnE6j+45V7AQKURg1baNMaFc6MgV5BAEF7XeH70j09YbGW
 JGXOIGi2zRfdOQoH7KKmVmoq0kdM9IU5kX0Xm8742RN/1MWOuYS7fXBs5ZW+1G2lzb0f7c
 H1SM4DpEeqlz88AT2hZae/f7BO9nmyDrmvb2Y6HlCxWCyO5y0zNcBl+VopGox2mGYUiOUa
 Jhj3cirYsATYRfyrDPrfJyetFU7GUB/Uccj9zkwG45tEUW9ARhaU9KWZAyQJSvzaL+ICmU
 R8oFzFDGMJ2rfYpDLHNKwG2V5dDdwz4pFc4THSazzozqY1Pwx0C14V5Z3Pz2bVpZu/AMdJ
 u8cfCV2mucLUaNmFtqZBbseW/kGQe7txqVAcxucoGvRK+mTWgeSQhovzgyYCqghTQqcx57
 V8qvjtlwYPkEOQNAmyvGubco7CpnO8gZ6AmS+9Yk+l0wY6v14IcIvwY9Yv+v9LQ2G/Qnmw
 x9sMV4+YXJc9rqvCC9RKLSOsIigeSD7SHCSUJXHHMS2WIbzOiYY+4krHw7kKff0x5q2N6j
 I2YdaG5h7v2KmKgSxQDK33veXnZqgFec3sbIF6pgMKhcP/kOYS6SFt9ICbWO/1BehxK2EE
 di/4YldNKUslKFEFN/S3eqAB4Kt/BRpQvJakGzwO1DdJvWfrZ4Gb20ImlOjiZ1PgM7cNYj
 Py6SgpaIlFSPnDQBjpgGxbFiVPCoW+LL6sxkMhDxYLU=

Automatic NUMA balancing is effectively off for every task in the ext
class, even when kernel.numa_balancing is enabled.

The periodic scan is queued from the fair tick only:

  task_tick_fair()
    if (static_branch_unlikely(&sched_numa_balancing))
            task_tick_numa(rq, curr);

task_tick_scx() has no counterpart, so task_numa_work() never runs for
an SCX task and no PTEs are made PROT_NONE. The fault side does not
depend on the scheduling class: task_numa_fault() still accounts faults,
runs task_numa_placement() and migrates misplaced folios. It just never
gets anything to work on.

Numbers from a 2-node, 160-CPU KVM hypervisor on 6.18.5 with a BPF
scheduler attached, detached for five minutes, then attached again:

                         SCX      fair (5 min)   SCX again
  numa_pte_updates/s     0        2.4M - 3.9M    0
  numa_hint_faults/s     ~0       10K - 34K      200 - 300, decaying

Those five minutes under fair changed the placement data considerably.
Measured from the BPF scheduler, as a share of task runtime:

                                         before    after
  task has no numa_preferred_nid         58%       10%
  task runs on its numa_preferred_nid    37%       83%

So under SCX p->numa_preferred_nid stays at whatever the last fair
period left behind, tasks created while a BPF scheduler is loaded never
get one, and memory is never migrated towards its users. A BPF scheduler
that wants to keep tasks close to their memory has nothing to read and
no way to start the scan itself.

Call task_tick_numa() from task_tick_scx(). It only needs
p->se.sum_exec_runtime, which SCX maintains through update_curr_common().

Keep task placement out of it: after a fault numa_migrate_preferred()
calls task_numa_migrate(), which picks a CPU from fair load statistics
and moves the task. Those statistics say nothing about SCX tasks and
CPU selection belongs to the BPF scheduler, so skip that step for them.
Scanning, fault accounting, numa_preferred_nid and folio migration keep
working.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
This is an RFC: the patch applies to v7.3-rc5 but has not been built or
run yet. The numbers above are from an unpatched 6.18.5 and only show
the problem. I would like to agree on the direction before testing it
properly.

Questions:

1. Is the missing scan intentional, or has nobody needed it so far?

2. Is calling a fair.c function from the ext tick acceptable? It keeps
   the logic in the class tick, in line with the per-class approach from
   the "sched: Fix execution-context tick handling under proxy
   execution" discussion, but it does make task_tick_numa() non-static.
   I can rebase on top of that series once it settles.

3. Is skipping task_numa_migrate() for SCX tasks the right split, or
   should the BPF scheduler get a say there through an ops callback?

4. Should this be opt-in through an ops flag, so that BPF schedulers
   that do not want the scan overhead are unaffected?

 kernel/sched/ext/ext.c | 3 +++
 kernel/sched/fair.c    | 14 +++++++++-----
 kernel/sched/sched.h   | 5 +++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e56c3c9..82c7d6a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3840,6 +3840,9 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (!curr->scx.slice)
 		resched_curr(rq);
+
+	if (!queued && static_branch_unlikely(&sched_numa_balancing))
+		task_tick_numa(rq, curr);
 }
 
 #ifdef CONFIG_EXT_GROUP_SCHED
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57360f5..669c8ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3642,6 +3642,14 @@ static void numa_migrate_preferred(struct task_struct *p)
 	if (task_node(p) == p->numa_preferred_nid)
 		return;
 
+	/*
+	 * CPU selection for SCX tasks belongs to the BPF scheduler, which can
+	 * act on p->numa_preferred_nid itself. The statistics used below only
+	 * describe fair tasks anyway.
+	 */
+	if (task_on_scx(p))
+		return;
+
 	/* Otherwise, try migrate to a CPU on the preferred node */
 	task_numa_migrate(p);
 }
@@ -4630,7 +4638,7 @@ void init_numa_balancing(u64 clone_flags, struct task_struct *p)
 /*
  * Drive the periodic memory faults..
  */
-static void task_tick_numa(struct rq *rq, struct task_struct *curr)
+void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
 	struct callback_head *work = &curr->numa_work;
 	u64 period, now;
@@ -4696,10 +4704,6 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 
 #else /* !CONFIG_NUMA_BALANCING: */
 
-static void task_tick_numa(struct rq *rq, struct task_struct *curr)
-{
-}
-
 static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p)
 {
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c70..f6774bc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2133,6 +2133,7 @@ extern int migrate_task_to(struct task_struct *p, int cpu);
 extern int migrate_swap(struct task_struct *p, struct task_struct *t,
 			int cpu, int scpu);
 extern void init_numa_balancing(u64 clone_flags, struct task_struct *p);
+extern void task_tick_numa(struct rq *rq, struct task_struct *curr);
 
 #else /* !CONFIG_NUMA_BALANCING: */
 
@@ -2141,6 +2142,10 @@ init_numa_balancing(u64 clone_flags, struct task_struct *p)
 {
 }
 
+static inline void task_tick_numa(struct rq *rq, struct task_struct *curr)
+{
+}
+
 #endif /* !CONFIG_NUMA_BALANCING */
 
 int task_llc(const struct task_struct *p);

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.47.0
