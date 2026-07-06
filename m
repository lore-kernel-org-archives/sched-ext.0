Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372C330662
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321488; cv=fail; b=uwwQQQmvM3f6yINQyhWiGEZqpFFn7AbktuwkHDSdQ9gz7A/BUtFzSLR7eLkrw7PxnMD9rsOZK0SEni7Hlk7EjmADzlla1iqmtJPnX+tGFUH9RBb96dlr+MJSP1SB5xPbEeDzt8Kfq1AAUZtwW2ZVpw0GLFVnLqAi8/JeL+3rD+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321488; c=relaxed/simple;
	bh=hkHmol9DkzaCDV+5n+MSL8/NvPeO38OrpCf3mOEiDvA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LFRo+vGHCfzE3+SHdFtj81MwNCFWRhOjynR9zb0NzmyozFm+mJqsRseYP/h1p4wLCwwkWAYDhxJ3Jv+oZ0G5yp0XUCMKyqsArdwJTFbTd8ZGhbKEgDNL0urYx/94qZXJTH5ZMUuIjeOOETZfwEp0GWqhwNtdt+aD+qaGWaBP2Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DFN8FWDH; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DFN8FWDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bidr27U9l4IJ8UQGVIHqlG8FhMR1YAzwajyDC3O4YsXGC2SXIi+RQuwZ7Fw4w/d5RCbFLp3eSPsBzAKFnMzLfOCXlrFGHlC5OYqBVy7pT8eCQMsD6OimSnubZ9wwNgYqKfmNMRjuDXIaHK3iAsh4r+xwZxncGDkdluGfz1iT7KSMs+7ar7k+rYVBxBfL/+Li9GzfVAEocm7n8ga1YpEFx1WnMckAMD3NxuHITrCMK531xGj6a0FQgj/S80yt4LN3D/uxAyX5sdXtgPMYK7tAendUJxHjxmERDGRgN4EcEM957st0pUM58nhsJUp8eOwKR9HXKrFfxO4iDK8spUiE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8zrrSCdjsQF5M1C9MbcmGJViJtUVDHN+VIfHC3kC8c=;
 b=vPjZLamEusg/6YhnBt7KXxcEPSwH45Qh6R30eeAdWhjOqVjRBRfzwSVNWucbtyDApC7uFaBtNGgAYcOYH0eDpSF7LZq0hzVXB8RYQn8tNH4ScgqOJIlO2kye8nocnHLcdS4cC3yC9lp59xbklgixlxzWdWvEo53LWrOzRmfaKOna/PRUpsUK3B2G5bkz2C7C+K1t2y66YtMHWaYRLpfsh42jkU+B892bhWf7/za2ANLycRH+nLl4yw2/8RT6au5pYcTVsEnWp+0hDiylQFFJ4lSSuGzH/S4IjbkS9EvScKKVUs1xw+g40mGbTTtDisZ4iV+lysXK1H5tJ56pe1OAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8zrrSCdjsQF5M1C9MbcmGJViJtUVDHN+VIfHC3kC8c=;
 b=DFN8FWDH+UeBseJMBKO7pfs65cPiwBcwRHUlf2YCUBH4MXI9ZyebwlGVZcL5qO9QHJxVQTCfBbKAx3LdPBokLZyacsI1IMZe4/OH1ldw9LeIGo6FfENjRFDrMcXGdOMUyLdsbnv54nswDM3mYnRNX+6cR8LGWSks2tfOdXV69jxL9bWeVqY69tI79mtrxnQ/itb8mVfAShmFbiypnhZn3zq8AL9aHnPjCM4v0QXJfBKjk8LaV2a4VMJlPtOvusdswwcmFD+u/OTQ/KZTVY2NoCJUhBlSDm52P3hSJ/AEdK957mOv8bDiPS1SB/QGkvgggC7Sh7lgL1Wsn+wZ2cXZLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:04:30 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:04:30 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Mon,  6 Jul 2026 08:50:55 +0200
Message-ID: <20260706070410.282826-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a12083-1240-4095-bd64-08dedb2cd299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|18002099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	8acdxIyzs+8+J5nGed/i3DDCtpS8Uo/wOoHUdfH1pftI1A24Ni/vJ3NCqtB+CcwlU36pftK0sn8Af+nqjbemKe0TtxoCS2GInU7ZlTzuXSTCsHqbXiQN0ps4uMhBUpOtNASqz3OzlJs6oXSA8EPBe9ffe1TlBRXpDY5pTxfMz2vzn91vKdtcUXcKhPHlX8DYKS0Y21s7QgJq0mvHPCcbW+qwEcZZYbbxu2w1SEmGlQvk6eBEAGo0SAsza041WoQmtKSeLcbyD9TDvz2w6FSwhS1JoT9BaPwDdFNX26cTsnJC05vW73S3PVVqIB1+SPDjXtXAJa0bksofSKKAWcS30PBQ8D40oha3Ecx+LMIjWw3nPUTKEVxXN0azRCDY8RBJ+JX5d6Bj7B0RIwjh5TkZ5yzKEL4ECTpeWk8dr/eZ+x4C0i71QOIH4n58uF2O1StGSBSjeuIfFjr30UN8n4eWy3oK8fBmazvBp47UTeJzDmijHJzGpLCl6r52B4XJRtVOcyvCHjsBPH1+PtBeAUfZSJwwRHUG6ofukIvOHo1zsYMgWNJwcfDnJd7ErWh0ipybil52RUwlffYqf7ylSq5e1HX+IpRUHZmpAYuEn0iIaJXPYCrHPcjzK/FXchEctSuQx9Ocbv1FRzt2JWuG1W3iviSE3Fnf8q3B87lnYcDLpYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(18002099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u6QWhcJIxpgtoMjusCmLheqL+eAKWU5je4wuweTT3V08OHFbRuNHJQP021Ij?=
 =?us-ascii?Q?vuoVHW/btWNN1FlEfBnE6y4eRaiclCKNObaODUt+VoRvmL9rerDOiWTNE0RZ?=
 =?us-ascii?Q?R8e43QmUawAnZgk9H4CdRr2Ng+rqsb3yV/d2vcM1raWVgWwc6wCJbIEtJlMS?=
 =?us-ascii?Q?eyd5kZMX+CI6AP8o4prSqA/WDn82FFjmsQ/EEVF5V85fi2pOoAHfcQ5wzvja?=
 =?us-ascii?Q?HyVtMRvi3JaFmWvQDZZPl9seu4bxeIGJ9saK/UaaLLatJyCoRBkJOrEYasr+?=
 =?us-ascii?Q?ohOtxNjkczftU15ERjalSMCoU6KItUTuj7JwjiDGAGNrJ6nUJH5c7qRMZssy?=
 =?us-ascii?Q?HomHcsTtx9WmeUHvCDauElF7TZDkMaiDS1kvKuz+PfO0gArhtgDWVjJTpkj8?=
 =?us-ascii?Q?5/yg6dbtv00xkF9Kprh3WJDG0Y1NaLg2l2oXoRxkAp8V3ENCArPd06A0GoE6?=
 =?us-ascii?Q?oTCfEEeoBSaECFKme5wSVOJgNV53qWLVHHyAbEiFF0mbTl0UARoPMjT7+4TK?=
 =?us-ascii?Q?Htx4PLTKX2NjG+pvrtsN91Yb+L6NywDw6AiTDJ8pp90wAmu6ewx+IZEL0HPY?=
 =?us-ascii?Q?QO6sZBf7KILtrc4HUMk06h8DJe9sXffxN/PccrvAA901nekLD+URXLhv0oZo?=
 =?us-ascii?Q?7EGMfBB+XQKBuMSHg3FafAA72dHXmXJvpcoa7YefHyXhM7gfI1hBaoB9uawl?=
 =?us-ascii?Q?QZDMPh6W63S5SBLtFkvcPPNZ2gp0hLIzJl/1qRnzr7qxzBl3WcWMxdjWiitD?=
 =?us-ascii?Q?8OZptRD/bs6GEY+8T/h6ql2hLdxlGug/c5vmDDlQqAYhmWxe62DAHbTZk4Fz?=
 =?us-ascii?Q?R2TDbRdzGQDgekOntKdpeTDvK61h9D933vlGGsFumjBxjD5d1t8Qt9j+DNWc?=
 =?us-ascii?Q?6gRRgtOmvian2NqP0z+q43QABuhKihr1KWBf4UM5iArXLMH5s8T+ZfgfQkKx?=
 =?us-ascii?Q?ouqQ/+pVDotSBfT7RwVyjFrKQMcsUtIedvnR/ABB6g+t1ZVPI9maOcLAAymd?=
 =?us-ascii?Q?nTlnQ8DIkFYvUac0O5chhwbCAkqBoEDOtfK5AOHfyt1YMxgYCVczVSOQ5/72?=
 =?us-ascii?Q?N1dsbLtgvx9HVwA1bukyuZfoas5ECaTdvh48nipCVVa1V/DM9WHky0XX7EAw?=
 =?us-ascii?Q?wwBPDtQQNLRyJj6NL29AeFn1OcN4YbTzgYvDGYL71HvUqarA4GMWakl3dmJv?=
 =?us-ascii?Q?njZcWA8ArVXun8xIoHXnbAdbd+4VXn0z4dCopQlsuqbkW0tGHZLeySHIZhUo?=
 =?us-ascii?Q?wEuOwfrtQDBl+uZcgykM3hVFEoOIUHgEaw68hy8hOrZj2VYekc+GJxlqIZsQ?=
 =?us-ascii?Q?VjSgw7qMV4y/K2DtKVPyVLAY/np4BW//uld2Ps3TeAqIU/DozGe/tbQV7rF2?=
 =?us-ascii?Q?JcNmu4rws16xqrmshHl45YajrnSy0T91F9IfE6zA7DdYrpJLXxNw4vDOTu5n?=
 =?us-ascii?Q?EZhtJFUoYMFQeOEVsSPtWQKFtf7OZ8Bs8g6e5GR+1X8SQhAEICSZVj0Bdely?=
 =?us-ascii?Q?UzG7IN9fn1Kb1jCub69LCeqkb3b2SI6WQHMSYrEbVyvTh24//ZZkniDkd/yn?=
 =?us-ascii?Q?VUtAVAetfSx1ijswqaY/QEzc/q1dH66bUVQLsvidNuO4nPaHk3RRgGIO71fZ?=
 =?us-ascii?Q?9iFDmX4nZ9Wri9WHNTKE7jSvU9WnBkClB7Y/xJKl6jcQwR1poP8hf+IZ1b53?=
 =?us-ascii?Q?YXYaUANpsx/L4+X7mHD1yXNdtsmlYOj0WiwLNYVKpzinDtc96liLgJX43LuE?=
 =?us-ascii?Q?xP6yJQ5JKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a12083-1240-4095-bd64-08dedb2cd299
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:04:29.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAZVRnTskGwnO8Qk+aPeQiJS970SXvdSTL8IsvJ/yUd78rHbc0N4toWTKl3zzTV1vDtyj77EiUf1SsIJZCTO6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

This series enables using proxy execution with sched_ext and is based on early
work by John Stultz [1].

Background
==========

Proxy execution (proxy-exec) lets a waiting task ("donor") donate its scheduling
context to a mutex owner, so the owner can run while the donor stays eligible on
the runqueue.

Currently, proxy execution and sched_ext are mutually exclusive at build time:
we can't enable CONFIG_SCHED_PROXY_EXEC=y and CONFIG_SCHED_CLASS_EXT=y in the
same kernel.

This restriction can be problematic for Linux distributions and for anyone who
wants to ship one kernel and choose features at runtime.

Why are they mutually exclusive?
================================

sched_ext schedulers drive dispatch through their own interfaces. A proxy-exec
handoff can run a task that the BPF scheduler never dispatched through that
path. sched_ext callbacks then observe a "current" task that does not match what
the BPF side considers running, so kfuncs and helper state can see an
inconsistent view of the executing task.

sched_ext also tracks runnable work through Dispatch Queues (DSQs) and BPF
chosen dispatch rules, while the core scheduler still maintains classic per-CPU
runqueues and pick paths. A proxy handoff can therefore switch the CPU to a task
that the BPF scheduler never inserted or ordered through its DSQ interface.

DSQ state, vtime, and "who is running" bookkeeping inside the BPF program can
then disagree with what the core actually executes, so helpers and kfuncs that
assume their dispatched task is current may observe stale or inconsistent state.

Design: supporting proxy execution with sched_ext
=================================================

Provide proxy execution in sched_ext as optional per-scheduler capability: a BPF
scheduler can set the ops flag SCX_OPS_ENQ_BLOCKED to keep mutex-blocked donors
runnable and receive them through ops.enqueue() with SCX_ENQ_BLOCKED set.

This flag requires an ops.enqueue() callback and gives BPF control over whether,
where, and in what order to dispatch each donor. The core then walks the
mutex-owner chain and, when needed, migrates the donor's scheduling context to
the owner's rq before executing the owner.

Without the SCX_OPS_ENQ_BLOCKED flag, mutex waiters block normally and do not
participate in proxy execution while owned by that scheduler.

The donor-to-owner handoff is modeled like a "function call" from the
scheduler's perspective. The donor remains the running scheduling entity
selected by BPF: its scheduling context, runtime and slice are consumed while
the core temporarily invokes the mutex owner's code to make the critical section
progress. It is not a scheduler-visible switch to the owner.

Accordingly, the donor remains the scheduling context presented to sched_ext,
while the mutex owner is treated solely as the execution context selected
internally by the core scheduler. Scheduling state is accounted against
rq->donor where appropriate, while rq->curr identifies the execution context.
The internal owner substitution does not generate synthetic sched_ext callbacks
for a task that BPF did not dispatch.

Scheduler ownership changes need special handling because a donor may already be
blocked when a root scheduler is enabled or when a task moves between root and
sub-schedulers. If the incoming scheduler does not set SCX_OPS_ENQ_BLOCKED, the
retained donor is removed from the runqueue and stays on the normal mutex wait
path. Otherwise it remains eligible for BPF admission.

The mutex owner's CPU can be queried from BPF using scx_bpf_task_proxy_cpu(p) or
scx_bpf_task_proxy_cid(p), with p being the mutex-blocked task. It's up to the
BPF scheduler to decide if and how to use this information. For example, a BPF
scheduler may inspect the task currently running at that location and request
preemption to expedite the proxy-execution handoff. Schedulers that decide to
not use this information can keep the donor on its current CPU/cid and let the
core perform the handoff.

scx_qmap has been modified with a -B option to enable queueing mutex-blocked
tasks for proxy execution.

A new kselftest (enq_blocked) is also introduced to validate proxy execution
with sched_ext. The test creates a three-task priority inversion on one CPU: a
low-priority owner (nice +19) holds a kernel mutex, a high-priority donor (nice
-20) blocks on it and a nice 0 contender competes for the CPU. The first donor
blocks before the BPF scheduler is attached, allowing the test to verify that
switching to a scheduler without SCX_OPS_ENQ_BLOCKED removes the retained donor
from the runqueue, while switching to one with the flag preserves it. Access to
the mutex is provided by a loadable kernel module built via TEST_GEN_MODS_DIR,
with the test responsible for its lifecycle.

Example kselftest run:

  $ sudo tools/testing/selftests/sched_ext/runner -t enq_blocked
  ===== START =====
  TEST: enq_blocked
  DESCRIPTION: Verify BPF-driven proxy donor admission
  OUTPUT:

  [SCX_OPS_ENQ_BLOCKED=disabled]
    proxy_exec=enabled
    owner_nice=19
    donor_nice=-20
    contender_nice=0
    mutex_hold_avg_ns=254084719 (254.084 ms, samples=10)
    mutex_wait_avg_ns=254095120 (254.095 ms, samples=10)
    nr_blocked_enqueues=0

  [SCX_OPS_ENQ_BLOCKED=enabled]
    proxy_exec=enabled
    owner_nice=19
    donor_nice=-20
    contender_nice=0
    mutex_hold_avg_ns=228884734 (228.884 ms, samples=10)
    mutex_wait_avg_ns=207903720 (207.903 ms, samples=10)
    nr_blocked_enqueues=51

  [delta: enabled - disabled]
    mutex_hold_delta_ns=-25199985 (-9.92%)
    mutex_wait_delta_ns=-46191400 (-18.18%)
  ok 1 enq_blocked #
  =====  END  =====


  =============================

  RESULTS:

  PASSED:  1
  SKIPPED: 0
  FAILED:  0

References
==========

[1] https://lore.kernel.org/all/20251206001451.1418225-1-jstultz@google.com

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-proxy-exec

Changes in v3:
 - Dropped the core restrictions on proxy-migrating migration-disabled and
   single-CPU donors: proxy execution moves the scheduling context, not the
   task's execution context (Peter Zijlstra, K Prateek Nayak)
 - Dropped the sched_ext-specific put_prev_task()/set_next_task() exception and
   fixed ops.running()/ops.stopping() pairing inside sched_ext instead; track a
   real running transition even when either callback is absent (Peter Zijlstra)
 - Dropped the kf_tasks[] nesting and nested ops.runnable() patches from v2;
   extensive proxy-exec testing did not reproduce task-op re-entry, so retain
   the existing non-nesting invariant
 - Replaced scx_bpf_task_is_blocked() with SCX_ENQ_BLOCKED in ops.enqueue()
   flags
 - Expanded the curr/donor description to cover mixed scheduling classes and
   fixed local preemption to expire rq->donor's slice (Aiqun Maria Yu)
 - Allow inactive blocked donors to be placed on a remote local DSQ while
   preventing normal migration of an active rq donor (Aiqun Maria Yu)
 - Deactivate retained donors when ownership changes to a root or sub-scheduler
   without SCX_OPS_ENQ_BLOCKED, and extend the selftest to cover attaching a
   scheduler after the donor blocks (K Prateek Nayak)
 - Hardened remote DSQ consumption by rejecting active tasks and re-checking
   migration eligibility after locking the source rq; fall back to the global
   DSQ without treating an eligibility change during the lock handoff as a BPF
   scheduler error
 - scx_qmap has a command line option (-B) to enable blocked-donor queueing
 - Link to v2: https://lore.kernel.org/all/20260702171909.1994478-1-arighi@nvidia.com/

Changes in v2:
 - Rebased onto sched_ext/for-7.3 and adapted the series to the split
   sched_ext implementation and cid-form scheduler interfaces.
 - Replaced the global sched_proxy_exec_scx boot-time opt-in with the
   per-scheduler SCX_OPS_ENQ_BLOCKED capability, allowing BPF to control donor
   admission and ordering through ops.enqueue().
 - Added scx_bpf_task_is_blocked(), scx_bpf_task_proxy_cpu(), and
   scx_bpf_task_proxy_cid(); enforce CPU/cid API separation for cid-form
   schedulers.
 - Added proxy exec support to scx_qmap, including optional owner-cid steering,
   affinity validation, and fallback to the donor's current cid.
 - Added a kselftest with a kernel mutex test and a three-task priority
   inversion workload, test is executed with blocked task admission disabled and
   enabled, validates the behavior, and reports hold/wait-time deltas.
 - Link to v1: https://lore.kernel.org/all/20260506174639.535232-1-arighi@nvidia.com/

Andrea Righi (7):
      sched/core: Drop mutex locks before proxy rescheduling
      sched_ext: Fix TOCTOU race in consume_remote_task()
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

John Stultz (2):
      sched_ext: Split curr|donor references properly
      sched_ext: Handle blocked donor migration with proxy execution

 include/linux/sched/ext.h                          |   2 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                |  68 +-
 kernel/sched/ext/ext.c                             | 245 ++++++-
 kernel/sched/ext/ext.h                             |   2 +
 kernel/sched/ext/internal.h                        |  25 +-
 kernel/sched/ext/sub.c                             |  12 +-
 kernel/sched/sched.h                               |   8 +
 tools/sched_ext/include/scx/common.bpf.h           |   2 +
 tools/sched_ext/include/scx/compat.bpf.h           |  18 +
 tools/sched_ext/include/scx/compat.h               |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.h        |   1 +
 tools/sched_ext/scx_qmap.bpf.c                     |  13 +
 tools/sched_ext/scx_qmap.c                         |   9 +-
 tools/testing/selftests/sched_ext/.gitignore       |   4 +
 tools/testing/selftests/sched_ext/Makefile         |   2 +
 tools/testing/selftests/sched_ext/config           |   2 +
 .../testing/selftests/sched_ext/enq_blocked.bpf.c  | 128 ++++
 tools/testing/selftests/sched_ext/enq_blocked.c    | 732 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/enq_blocked.h    |  27 +
 .../selftests/sched_ext/test_modules/Makefile      |  13 +
 .../sched_ext/test_modules/scx_enq_blocked_test.c  | 193 ++++++
 24 files changed, 1464 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
