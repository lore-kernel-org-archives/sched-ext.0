Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E234A3BF
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012787; cv=fail; b=o8EkqUELRL0+gGOJudo7wJ7l12FNo3y1lpYBVzCHu8c20qxtftQZKFQQ/UkCZe/Mlfibi+skjmEnmK79dXm91rU6LaNrauUCRAyRCm+keq4QarkNBwzL1SRuekOxIDh+pdaYpzZnJ4Bfku31gUZ+6aSyfm0u9kB8Ul+g9OWVHRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012787; c=relaxed/simple;
	bh=j6YY8M9Ly3iGy4jCSLolP7HfFsJJSi11g96ghlZecRk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vC7uFuzXLGaF+pjgxJnMQ+dd/smEYmu8AqYeAtWsdheTOihr6sy+f+2UkORp9dVA7oPydEhRX1w+5NDVnt3Oo6+ydCAveh9hNe+0METZQg84KbT4O2vUks7w5govbEpmCTFHg59HfljpUJdfa9jflQKaRc2d6PyPq3c6wgH4U+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lcLmLadE; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lcLmLadE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luCvR82MOIVGZ9ryZtf0+zgjATCN9tjT2pAgDJVgbkCKXckQQurxux8IjdmXZmWzZYnQqBgxNEaM7SabREFYx30oDt1xBFcrH5w5P72PvyLgTSBBRp6xOYM606tWFBhJD/l3QDUqRBrtzru6x2k01r4mkePt7npq3F5aXZw+PIB45vMwbvJwrX/ncVGNv3NrIarRm8Y28/5niERanmls7HryeZDv0jDTJxZHQw7GECj4zJBm25q1obLHBniarRkiKrCU5AtUhGU2QLMO1cVx6MtkBE5VjPSYC+mqNtoChQ/OxiJpFXXOr1ohRODP0FsdFXJCH5lkufhA7twxe32z3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAgneSinNsUb9FAuP2hADUrELkKaFGg8qloPngRgVm4=;
 b=g3yf/fbowY9maOsD5hpN5QDNAjHBEDfGUo6qLnK3AjHwINhliSOd8NjOD1PzYH//B3j+TPZzMGkGkkyoOaFhG6hODSQ3+vw8UAn4cEL8FWykbCfx3DApVB+F7ddPoFNWRfohVudZ4zc2m0/5H3A+VmqKZVbyzTG5uhbFygvfqDr1PG0/rWrzVYDZ+zgIxMyNTx6cEZ+uXCz6F90Nvc+vNWpnG4DQA3E/nfNmgyhTPvtC9fYSJYT1uBCDXdv/xMrM8KKI2GE5GQzzQFAHUt2SM/E3TzbVWMqD/cBCZ/GKj7VJs5TDnmJ/UzJlVkBNFNgphNN/6IW7SpdnwcbMZN64+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAgneSinNsUb9FAuP2hADUrELkKaFGg8qloPngRgVm4=;
 b=lcLmLadEFDfORs8E4AJGfVThLG+6e/Kj3Heq9tLiLcD6k++k1VYQyjv1lyzuaAUHiOyI+uZu+eZDozUSGk+K7g58Xl15r5Ib/+J8oXrt4gvt2G8dG1zAvC0Ca/phwUnb0ksniZBKbP6rglVCMadGnhtloki/Xndr4vCIx6K6zn0viQmxFPBy7Im6qJ1LrNQe00QUJchBhPAWPhExoKid2SMlY+6ecAswwjjHBrAljD/fZia2ZMDuBVUSWqraLLhwdS6JiRYt7rB0QoTS/sOsK/UK9v9Rlcw7UXPPk/D3gxQkMA1+hB9Ih3uvNilO9uJN+NaCy2zxIWB99htKj4dq+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:19:38 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:19:37 +0000
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
Subject: [PATCHSET v2 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Thu,  2 Jul 2026 19:09:16 +0200
Message-ID: <20260702171909.1994478-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 065e4209-4d56-424a-8668-08ded85e17de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|5023799004|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dWIGn5/VrWi8vBJbbPL8g9Up+MwBBHrS3RQUIko/kUU8ZSLEQJGgCwHrf3ebA2CHvddJBF8NiCs+Z2zWE6iFtv+Sz5aGRXlNPH0Po5fi3uq+4jqL0NfyVTYcKUBJ+yARCX6VNTuAKGodFJ0km8rONda8HfInIktE+gT6GFB7f9BC28VR/JuX7T//pe/5eRMis8AeqP2IrrgWAMkiHhmY3RiBNJzvWSD9aUPYzNHtHCsOuw+q+us680hmnrkZGi8qKQOGHoWW0TL0RMj2S9rzu1c72P2w5l/qflqj8eYzKNM3qDd/Y3t38RuzmtoqmTCyW4Q3kg3wOw1TgGIIszDv2knLQCZz0C86sBeeMUdbKjIMbkVwEWIDmdwZ6ryeYQu/aM6pyldOpOHfpuAVVAYOnzA0ODm4f/KaYtCTxfXoXnpGQwed/wHqVacHPFFrhXs6JFXBrszWPp+aVY0kz1jifzxgX3qIIinkEbLWUvUjXrpScS4UNDvH1VatA07Xqq9bxjdbf3RiPDDt42W/Jyrv5+8dfBkYdamL85M4c4evgy+U6h/7oO89V03Tk5Uin4V/PilA6WpQhfxr23BfubxZ2ButM3B52rwZfPnN9Z8oObYF/lc02JIn2779SppAbxlwD4HRYn0qeRfWWWG01N42iLWVN56d0q7pUtrPL5Fa/+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(5023799004)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gb8VmTYz0hW3Z6GkQdwHlhz/YASoJl3QVmPWqiXz6daMd4N/OkZHDY24Rbvm?=
 =?us-ascii?Q?cL3wLHLY2sjMg5a6TU+4NDh08EC3ablNw2EdjPhvjDQx+InYChLaEdx5ZMFs?=
 =?us-ascii?Q?PnQ4KXmYrOZ+QdCpm/fw2pJZEmA3qUbNKHEXEsq2IudWDqLHiwOsPCIGpxRe?=
 =?us-ascii?Q?OmUfc2BxsnkI0TCsjIuoS7hQu8EL6q+02Js+jGtIZNn00LVXwG0ceiMfleH8?=
 =?us-ascii?Q?VNZTrqJvVBT5wIj+stnyTAXMDDkcO1yqKNXt29npUW9yC63rD5+zU11XGKMW?=
 =?us-ascii?Q?LBG6ngS+D7cof82p/G1PiFWnxIMATKcUACnxlHG2R6+8/mfZYFZQcmZnqrem?=
 =?us-ascii?Q?7A3or41kSYJckmUVr/ZVY07UxQIk4HNGNGOKVd0n2IQGvFeUrOoD506Ad+Jb?=
 =?us-ascii?Q?j0rf02FEQDWk2I3+4TgjILe/iUCUR/+ym4tTwFQGxp/b1WslZN5WDlh/aqzy?=
 =?us-ascii?Q?4wmMSgBb8Lkbou7bMQtKOI0WBIWoDiqjpmYV1Ln5xfMz7B4O5joO/uNP1cxu?=
 =?us-ascii?Q?1DZaJtMy3NPLuqyg3XlxaFj42b4FVWQaL6dN2bQN9EjxmGHUx/yW3w6HpuP4?=
 =?us-ascii?Q?oO9bixN108dEA3MtFAF3ofBRdMYu0EphIGElRayKWcn99JaTx6lfMvLdkNM+?=
 =?us-ascii?Q?TRAUplM2UC5ZosvjqbiFfHvyBQuRjpCjcI9HIQm0NAWlbMtIJD5wuBrLCZLn?=
 =?us-ascii?Q?GdHOlVTrB5ELoS/9pPcyCfhNV+bLjWx9d2GiDwtkFZ+Mm6ze9MfBGHUQJKiw?=
 =?us-ascii?Q?8PJUf8xdTL0GTy6HLmgwhceqJ/9yFgMwlFc+AyBm40VB5lbiHcgi0LddeNz1?=
 =?us-ascii?Q?Nam0WPInpAZJsqwfS9wulWVXrueCinWY59qrWvLYcU7X+bwsenBKsV5HkFPA?=
 =?us-ascii?Q?T1KcwDm0L1zx3dHoimcwJs9OGbo37tjJkMg3x57VlCKbbZZwFbJfhGV3c9Yv?=
 =?us-ascii?Q?my2yrYB/UhZHJnZmHR1qxsdm4jvWRDGmvpRDOIPmjJCB/qdzrQGDvL/9dPz0?=
 =?us-ascii?Q?qWY2ZNDTfP7xK1Kbv8qfHbF0IXosB0y/btB7mrlnEei11zGqO/w7TXGL+cg/?=
 =?us-ascii?Q?PEzMVvqO4LblhlDjKpkP7ivMab8MNLPWs1KY7cgzBz25ylVzcqu0S4RkrPtN?=
 =?us-ascii?Q?b1EDe2R9vD8QwyAQhVcea5NrGPHfhK8/nVwNgaxl873t6yi2BvCuPM/wsGeS?=
 =?us-ascii?Q?uzq5iPadn2N5O8ScjOpahfsPzdBuOH1fSGXnXtLKzEZ+HPg+lJlzQ1WTaBop?=
 =?us-ascii?Q?u0gRuNyzRAODFLDeRsioaYku9Gdqe9G9EhjmH9SNzhhV4T/TdAjznJnlZw2J?=
 =?us-ascii?Q?39uEIKZEUJwHu+lFsqhqmSdm71fFNfZ0IcgXS6sOMG4Qva/yOyE+hFfskUcW?=
 =?us-ascii?Q?X4LcXKiJjFINR373Y+3DOnD7pZyuscwr3jtFgdSh8Q+1cESYYoKuxokZDv57?=
 =?us-ascii?Q?o+XcUeEF8ttMM2IKqEyoEwdaCW+5G0W/NXyzOW4BI9VyIhkMvH6dhwkvHCbM?=
 =?us-ascii?Q?GnmxuI7j76gy4AAt69W0ZP0qIITdRqFL1idFaUO5kMG5aHLF/FHEqdzZE+RJ?=
 =?us-ascii?Q?W0YCF6jvhly+3oC/74pSz6N9xcSiQ5b+6i+oOZBQ9Kf9mVPQqrdd91y6aecQ?=
 =?us-ascii?Q?Ivk51e0mppfr0MmMsUG7i3dhOC6y6hjVNNEeTOZfGUBUIsG0YSLZjrHNA9Oh?=
 =?us-ascii?Q?QBD+2pFXFGF+SA65jxtEysPQAC9uUnXTU7kUIhROWebOcaYcFaCAZv7pTm2i?=
 =?us-ascii?Q?r9g0q92oLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065e4209-4d56-424a-8668-08ded85e17de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:19:37.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISvXlw1eUA0f+hCbByvnsmyrD8xmOkbcniIC93SXd5/eNFx57mo+ZvzAKF9JRjU+NYM7klQzlZOIE6FOlDIgLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

This series enables using proxy execution with sched_ext and is based on early
work by John Stultz [1].

Background
==========

Proxy execution (proxy-exec) lets a waiting task ("donor") donate its execution
context to a mutex owner, so the owner can run while the donor stays eligible on
the runqueue.

Currently, proxy execution and sched_ext are mutually exclusive at build time:
we can't enable CONFIG_SCHED_PROXY_EXEC=y and CONFIG_SCHED_CLASS_EXT=y in the
same kernel.

This restriction can be problematic for Linux distributions and for anyone who
wants to ship one kernel and choose features at runtime.

Why they are mutually exclusive?
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

Proxy execution support is an optional per-scheduler capability: a BPF scheduler
can set SCX_OPS_ENQ_BLOCKED to receive mutex blocked tasks, without this flag
mutex waiters block normally and proxy execution is automaticaly disabled. When
this flag is set, blocked donors are passed through ops.enqueue(), where
scx_bpf_task_is_blocked() lets BPF recognize them and apply its own admission
and ordering policy.

Knowing the mutex owner's location is optional, BPF may enqueue a donor on its
current CPU's local DSQ and let the core resolve the owner and perform the proxy
exec handoff. Schedulers that want to reduce handoff latency can use
scx_bpf_task_proxy_cpu() or scx_bpf_task_proxy_cid() to obtain the owner
location and steer the donation there when affinity constraints and policy allow
it. The core still revalidates the owner relationship to perform the actual
migration.

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

The sched_ext callback bookkeeping is adjusted accordingly. Blocked proxy donors
do not generate spurious ops.running() callbacks and ops.stopping() is only
called when ops.running() was emitted. The normal sched_ext migration path also
leaves blocked donors to the proxy machinery, and cross-CPU migration is avoided
for migration-disabled and single-CPU tasks.

scx_qmap is modified to demonstrate the opt-in policy: the scheduler immediately
admits blocked donors, prefers the owner's cid when allowed by the donor's
affinity and inserts the donor at the head of the selected local DSQ.

A new kselftest (enq_blocked) is also introduced to validate the proxy execution
support with sched_ext. The test creates a three-task priority inversion on one
CPU: a low-priority owner (nice +19) holds a kernel mutex, a high-priority donor
(nice -20) blocks on it and a nice 0 contender competes for the CPU. It runs the
same workload with SCX_OPS_ENQ_BLOCKED disabled and enabled, validates blocked
donor admission, the reported proxy CPU and prints average mutex hold/wait times
with their deltas for manual comparison without enforcing performance
thresholds. Access to the mutex is provided by a loadable kernel module built
via TEST_GEN_MODS_DIR, with the test responsible for loading, unloading, and
managing the module's lifecycle.

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
   enabled, validate the behavior, and report hold/wait-time deltas.
 - Link to v1: https://lore.kernel.org/all/20260506174639.535232-1-arighi@nvidia.com/

Andrea Righi (10):
      sched/core: Skip migration disabled tasks in proxy execution
      sched/core: Skip put_prev_task/set_next_task re-entry for sched_ext donors
      sched_ext: Fix TOCTOU race in consume_remote_task()
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Save/restore kf_tasks[] when task ops nest
      sched_ext: Skip ops.runnable() when nested in SCX_CALL_OP_TASK
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

John Stultz (2):
      sched/ext: Split curr|donor references properly
      sched/ext: Avoid migrating blocked tasks with proxy execution

 include/linux/sched/ext.h                     |   9 +
 init/Kconfig                                  |   2 -
 kernel/sched/core.c                           |  59 +-
 kernel/sched/ext/ext.c                        | 209 +++++-
 kernel/sched/ext/ext.h                        |   8 +
 kernel/sched/ext/internal.h                   |  58 +-
 kernel/sched/sched.h                          |   6 +
 tools/sched_ext/include/scx/common.bpf.h      |   3 +
 tools/sched_ext/include/scx/compat.h          |   1 +
 tools/sched_ext/scx_qmap.bpf.c                |  18 +-
 tools/testing/selftests/sched_ext/.gitignore  |   4 +
 tools/testing/selftests/sched_ext/Makefile    |   2 +
 tools/testing/selftests/sched_ext/config      |   2 +
 .../selftests/sched_ext/enq_blocked.bpf.c     | 116 +++
 .../testing/selftests/sched_ext/enq_blocked.c | 682 ++++++++++++++++++
 .../testing/selftests/sched_ext/enq_blocked.h |  21 +
 .../selftests/sched_ext/test_modules/Makefile |  13 +
 .../test_modules/scx_enq_blocked_test.c       | 134 ++++
 18 files changed, 1299 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
