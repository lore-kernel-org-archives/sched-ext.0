Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B792409624
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959696; cv=fail; b=XxuzHxDDsRDfJEIs/vliFVcPBZWNXtzMH/rQIKPKTxdCd45IhqUj1yPd/Kk8ZvgoQhJxDpN1koB9y7dihEhzHuJS9HwYCVh6wGJRi+byE1mlEeVlshdT7Rq1g7bznXWpBfSN+vM6q5WTVLmJhEELJH8475Bd6SxlpybHskmQWI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959696; c=relaxed/simple;
	bh=0SGG7dclst2k691UfPWZ+kJqcuncUx3HE9LcF7x6di4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qR7jl4mEngPdnAT4UtLs/skHnaSgqxjZAr/iagIHw+03bNo2s4ZhksK8f1WBDanweXfobUAen1dnyaUZwE5BbaVIGYvWezP5Y0Y51KN4Kf70n6fJZt7uvS4OhisKkWUC6rrNdn+Cy+ywmVzdCLrL8EbZJDpplU2CZBVGyYgkFhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LS/igUk5; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LS/igUk5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOb5BHBYI3otUDQnf8OoSCLrzklT5cm0vnozFvq3MgGXsm9a0Jfa/oLvu0Lcc7WyTCpSBPhdSXgUBBf69ZjdDTOjNH07sv+qdDbfiV5V6qjxmBX6SX9EHxKcpPvYq3MW5YqUVMKM8fknAotUbLgOqsM5IJoOqdsj5DwWN7EmO7OolXHtCPPRAwGrNPwSyviFrPUtOA+IcPURplpXNQFGl8XVshK/PC8Jp3LYQ5jG4igrxPEEQoGCS50eHzjMCqVoa4NIMarLugfaPVZ1hzCPqmJjJJpaJFi6L5Ie2DdJsvvWplat8Sh6YcjVipbuPcPgqoUQHroD48xqaHYQoL7XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUVLPp4iN6YPQEgY7FZy1so3ikC5KL7R79dAyNCIVrE=;
 b=LUW9zn22R3KBhil7trNKedNWvDUtLjt1tzzEFhBp2z8JvsBBsvY7V54c3wsKXFouw3+k9QP4KmjmDMeB0UzNgFFP/R/+9odhKS/S/UNssIZEZYV4qK9eRgIQI5jXgJIV1yA1D6hbTzjwfcegExDMx4JBYKYYFZBESRq38R/EZ4fbpySskAk3Of+8lgblGFdpjFMAl8Xei5Kz/iHKFn0PozbeMBJTm0TKtIBgaU/nbgBDa0XnMGMIEYnCd7U7Q7oTVRf6V9/AuQJPgvsxRmgZyRL2RCaNoXAa51Q1kWUkYczM5xmYDbPlXxXdwfEJEivla9dbZ07wcNTl/mgnjSssgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUVLPp4iN6YPQEgY7FZy1so3ikC5KL7R79dAyNCIVrE=;
 b=LS/igUk5FYyWMXoOmwA2NqbMhhmy2QLpSD0w1yk2mEzBWuE5Ji6XhF3qiM5Ogdqn4nJrRZYEXUoiAMwy+ggCBQWYV0Wz7GCgypTN55PWISn/Zec/NExbWyUvX3NygfEc42col3aUIjNDqSmxh0aBuetmY7bCAB5L+crxxBgVJfsloQB09oD2w5eVGsXXrzYNh2lQOytsh6XGt/Pn85Pl+YOFXVoLBJXi92upxmCuQs8zq9Vx6b3SaIy/AcJyB1TjXQ7aV8QluKbkA10B7UoM76pLb+U4xkSA2xGLjcfK2wgjFi7LCQV93IE8cEuF3cUhMq4Jyk0UG784VPo4GihMvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:21:24 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:21:24 +0000
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
Subject: [PATCHSET v5 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Mon, 13 Jul 2026 18:17:00 +0200
Message-ID: <20260713162112.26785-1-arighi@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af1d389-1aa5-4240-607e-08dee0fac843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|3023799007|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	PP2rjpWiTUOLkIbM2J9RqljRELpHLLRGl+1SKhSs5yk7LNzxBehTXhrUTbswhUFmmTKW6s0ilI9TZHEgKQIzQSWFdhZb6GR7O/0jBSdS+9mAYIbXVDDWLt/E3ARCiSOUGCL7W4H5i7PM7hWRozbTKg1uoGXlkWjHx7+nSxZ6+D5ptQNAW1fQBv8J7csyYkZ62HX5BZt/WhgAlBhmij/ThQ/uyvE03BzbksmDQ7lA2ovPpCiYclKhPeJm0CP5mmvUNzFkAHJkLQoRGh1+6lql5mvL7MuHM91ZDACeKmIeRo2VLogIqZPVPVy4vuFqi8mH1aZ68wKJTQWR5Nvo+yttcIcKYlktgIn4ejvnOeR/3sl993/hucPasNJHMBbQP6D8Rcr9kBa8kLNhB9GGIXB5Yk3J3L1IPoPvEVx5/FecVeKUtD60TS3Mo/cfXYfhlk0oVVBpNJdP9/3A3Sn7SrvYq0dGEx8hBiWVTjwCVpeRC1qOEu7wO7OMPG3cBS2ikICuNTFxzOnFjGH2DoTGBuckTeqeuqW6wefQc9suKeHOJpdIGwDG71ccJIrRax6RFL/l6rVVnzVIaV1UsFD7Yr5vAm7dzNpgUyv3aEtqY9IC1RS3vEzzVDvlYhk3EgKOZv41DVFAHs+tyw+KbiYQvTChUmOrnDcOJcbN0yG014NuJYs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(3023799007)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qsj7JzyAqZY31JGrsAFsOUr5mgs2ccu4d5ZQnrW8QFU+G+9cGnmnuXhKz5XG?=
 =?us-ascii?Q?Fq+HV91cH9Ro0CcQOtFHyuPMsnK+ziyZnCw78Ny0RJTDqCtJDRitNL9QukuR?=
 =?us-ascii?Q?AMZ/n2FXcA0jo4/hoM+l/xUYGLLMkJxfvS0sGALfXWp2/xOq0bCXhjgDlZiR?=
 =?us-ascii?Q?UZQ59ov89+i81xfTLtzKtQoHfOvm/JyvUv2XwCM5spNYyutCNT8/b4Us0f4x?=
 =?us-ascii?Q?uC9ynxxsryFGAzv+xIZgOPnw9qhhVspJVuU85Lf6N9oHfnEKKkKyyfRf2R1w?=
 =?us-ascii?Q?4AD9cd5jYxZlNir5BkFkfAXugzUJMci2mkXivJ/oJRLj32p9Ws4bwPrMxNGJ?=
 =?us-ascii?Q?jQQAcsSEsdZgIf6pSRVa8Ju4bN00Aupwoat9CQzYfjtoWtm28UXzI4peV7lU?=
 =?us-ascii?Q?y1eo+wWEZ/imOgOlYPhBg+cn+JdbQquL/eUHdl0DS5dOw8QRs0CfWZjyHgFW?=
 =?us-ascii?Q?nMEfP7YbR51iW0nNXK4lk/F4ePaUNS0cnGoXXOjviAwAwZEyyS9qlC4uMkLk?=
 =?us-ascii?Q?JscHqAOgy9AiQYOZf+nY8sDCgfx0DQuBIlqLeseyQ8lw1ntXPrhEbQ0I88pp?=
 =?us-ascii?Q?aalW94v6m4QRAcnrIW1FpeM562H1Z22/msoiNgSBFKfX05dbdqsQynS7NWvv?=
 =?us-ascii?Q?0Sr95nuAsC7vRMC5emfxI/kC3BAEbeENaCY6Rdg+NWSp1Iz6gQO3M7i4MfMG?=
 =?us-ascii?Q?9e2nh9/rX2kjyuJ6wkWcC9iP8B3OkQXYpV+qjyOl0ya2Y8Vxp0LLaUHfwJt2?=
 =?us-ascii?Q?XaaMkqtrWM+eN8aLDXLbnlmuZzVzJU+GmPLcfhYGWcFsXSWxrd6KP18QZkU/?=
 =?us-ascii?Q?Quiy2OwA4pFfvAAgGWr+y1Ce8IuIcRT04Va/HUBdHm1+RD/Y1wZVRYGvpdEh?=
 =?us-ascii?Q?yLVTTyKlh/+420pDfr7QmjEoPE0K0uxmkuoW0DQM3wlynRrdD3WVAWlwK/AQ?=
 =?us-ascii?Q?4fh8kpFZ/WhdsQLqXpvnzobVrgx8bF3BMUJMwfZuvfXlgU/d+1hze47enGtK?=
 =?us-ascii?Q?80DFu+TcegEoK4p1Ja+NiRAKZaxhEZtN+lo9exLKmGIx/RqFhFfeyYxmNNlp?=
 =?us-ascii?Q?PbI9GCoSRrvYWXPWQVzMrx7/LDmzSiB4w7r4z0UcE3KN7ZocbzsnsnQiakP9?=
 =?us-ascii?Q?aVWU64gW9AJJOPi6eOohYT+RpBuAAws6nJz+aNCOnnD4Kopca+t9cdIgIJgG?=
 =?us-ascii?Q?9M82nE1F9il1pjZXCpcXKHfa96ZxR04iCeXtHmMePmCetjc6xkfFXATFc2VS?=
 =?us-ascii?Q?SkaeuxgmFsKLccxUY5Yk3RUdYLmDbw73euBTmVcnz4WGhPLQYhx97R8coB3n?=
 =?us-ascii?Q?NIWAP0P/p8MQt3aHOIa65j1Y1uRBZ4XaCiDo3pYYSJSqLKf0f1TpJYVy5MGz?=
 =?us-ascii?Q?eeP61bRKckO89k61Oq7NKnagP6XFa6z8ZWNN6KM1lbCMy0P/XHOs3pBvwQSb?=
 =?us-ascii?Q?Jc/PTPKP10MFaUdhMy2UvSS5wDMiviBvK2ToM79TQfbpcoy2UAA+RsPpETGk?=
 =?us-ascii?Q?q47R85gCg6OI5CO+lkWumkLdGAhjcJtlgpFoTRURSHHd3KR1axLgw5Bj58kB?=
 =?us-ascii?Q?G3aEFbR6kbCBIBBuaN5EcQSpXErpN/T1zkxImWZFl7bqDv2+tkeWZzS06wud?=
 =?us-ascii?Q?n5ZyywyBA6nB8R7Zv4mwsN8JvDyfkJLfj0rEB4XUJnW1wdPOwNKY9zD8hbOA?=
 =?us-ascii?Q?yoeAhRsyyDnPA995hkHBsZolSYhLpseDokv+IBifFeZ+tNHCxiBRHXT8EQf4?=
 =?us-ascii?Q?HQnE51VlrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af1d389-1aa5-4240-607e-08dee0fac843
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:21:24.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkaYHz2UXx4lse+2uOVKw3UwheGxEq1cOFpf8fJmd0NJv1cMq9X3jtjc4fjxDMm0wBbovxs4U/iP9Hjziqhq2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

This series enables using proxy execution with sched_ext and is based on early
work by John Stultz [1].

Background
==========

Proxy execution (proxy-exec) lets a waiting task ("donor") donate its scheduling
context to a mutex owner, so the owner can run while the donor stays eligible on
the runqueue.

Currently, proxy-exec and sched_ext are mutually exclusive at build time: we
can't enable CONFIG_SCHED_PROXY_EXEC=y and CONFIG_SCHED_CLASS_EXT=y in the same
kernel.

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

Design: supporting proxy-exec with sched_ext
============================================

Provide proxy-exec in sched_ext as optional per-scheduler capability: a BPF
scheduler can set the ops flag SCX_OPS_ENQ_BLOCKED to keep mutex-blocked donors
runnable and receive them through ops.enqueue() with SCX_ENQ_BLOCKED set.

This flag requires an ops.enqueue() callback and gives BPF control over whether,
where, and in what order to dispatch each donor. The core then walks the
mutex-owner chain and, when needed, migrates the donor's scheduling context to
the owner's rq before executing the owner.

Without the SCX_OPS_ENQ_BLOCKED flag, mutex waiters block normally and do not
participate in proxy-exec while owned by that scheduler.

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

The sched_ext callback bookkeeping is adjusted accordingly. Blocked proxy
donors do not generate spurious ops.running() callbacks and ops.stopping() is
only called for tasks that entered a tracked ops.running()/stopping() session.
This state is independent of physical rq->curr execution, which may refer to
the mutex owner instead of the donor.

Scheduler ownership changes need special handling because a donor may already be
blocked when a root scheduler is enabled or when a task moves between root and
sub-schedulers. If the incoming scheduler does not set SCX_OPS_ENQ_BLOCKED, the
retained donor is removed from the runqueue and stays on the normal mutex wait
path. Otherwise it remains eligible for BPF admission.

scx_qmap has been modified with a -B option to enable queueing mutex-blocked
tasks for proxy-exec. Blocked donors receive a fresh slice, are inserted at the
head of their current cid's local DSQ and request immediate preemption. This is
an intentionally aggressive policy for making proxy-exec easy to observe.

A new kselftest (enq_blocked) is also introduced to validate proxy-exec with
sched_ext. The test creates a priority inversion with a low-priority owner
(nice +19), a high-priority donor (nice -20) and one nice 0 contender per
available CPU. It exercises both a same-CPU topology and a cross-CPU topology
with the donor and owner on different CPUs. Each configuration runs with
SCX_OPS_ENQ_BLOCKED first disabled and then enabled, counts blocked-donor
enqueues by CPU and reports mutex hold/wait-time deltas. Access to the mutex is
provided by a loadable kernel module built via TEST_GEN_MODS_DIR, with the test
responsible for its lifecycle.

Example kselftest run:

===== START =====
TEST: enq_blocked
DESCRIPTION: Verify proxy donor admission under CPU-wide contention
OUTPUT:

[topology=same-cpu SCX_OPS_ENQ_BLOCKED=disabled]
  proxy_exec=enabled
  donor_cpu=0
  owner_cpu=0
  nr_contenders=24
  measured_trials=10
  owner_nice=19
  donor_nice=-20
  contender_nice=0
  mutex_hold_avg_ns=515695988 (515.695 ms, samples=10)
  mutex_wait_avg_ns=494700768 (494.700 ms, samples=10)
  nr_blocked_enqueues=0
  nr_blocked_enqueues_donor_cpu=0
  nr_blocked_enqueues_owner_cpu=0
  nr_blocked_enqueues_other_cpu=0

[topology=same-cpu SCX_OPS_ENQ_BLOCKED=enabled]
  proxy_exec=enabled
  donor_cpu=0
  owner_cpu=0
  nr_contenders=24
  measured_trials=10
  owner_nice=19
  donor_nice=-20
  contender_nice=0
  mutex_hold_avg_ns=246493710 (246.493 ms, samples=10)
  mutex_wait_avg_ns=208787590 (208.787 ms, samples=10)
  nr_blocked_enqueues=403
  nr_blocked_enqueues_donor_cpu=403
  nr_blocked_enqueues_owner_cpu=0
  nr_blocked_enqueues_other_cpu=0

[topology=same-cpu delta: enabled - disabled]
  mutex_hold_delta_ns=-269202278 (-52.20%)
  mutex_wait_delta_ns=-285913178 (-57.80%)

[topology=cross-cpu SCX_OPS_ENQ_BLOCKED=disabled]
  proxy_exec=enabled
  donor_cpu=0
  owner_cpu=1
  nr_contenders=24
  measured_trials=10
  owner_nice=19
  donor_nice=-20
  contender_nice=0
  mutex_hold_avg_ns=299893985 (299.893 ms, samples=10)
  mutex_wait_avg_ns=302001124 (302.001 ms, samples=10)
  nr_blocked_enqueues=0
  nr_blocked_enqueues_donor_cpu=0
  nr_blocked_enqueues_owner_cpu=0
  nr_blocked_enqueues_other_cpu=0

[topology=cross-cpu SCX_OPS_ENQ_BLOCKED=enabled]
  proxy_exec=enabled
  donor_cpu=0
  owner_cpu=1
  nr_contenders=24
  measured_trials=10
  owner_nice=19
  donor_nice=-20
  contender_nice=0
  mutex_hold_avg_ns=229506890 (229.506 ms, samples=10)
  mutex_wait_avg_ns=231099684 (231.099 ms, samples=10)
  nr_blocked_enqueues=108
  nr_blocked_enqueues_donor_cpu=48
  nr_blocked_enqueues_owner_cpu=60
  nr_blocked_enqueues_other_cpu=0

[topology=cross-cpu delta: enabled - disabled]
  mutex_hold_delta_ns=-70387095 (-23.47%)
  mutex_wait_delta_ns=-70901440 (-23.48%)
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

Changes in v5:
 - Split retained-donor deactivation and sched_ext's default rejection into
   preparatory patches so the scheduler-core changes can be routed separately
 - Drop the proxy destination query kfuncs and the preparatory mutex lock-scope
   change (John Stultz)
 - Use p->is_blocked instead of task_is_blocked() to fix a WARN triggered during
   scx_pair testing (John Stultz)
 - Rename SCX_TASK_IS_RUNNING to SCX_TASK_RUN_TRACKED and document that it
   tracks an ops.running()/stopping() session rather than physical rq->curr
   execution
 - Keep a proxy-migrated blocked donor on the owner's rq until wakeup instead of
   allowing BPF-directed migration to pull it back to wake_cpu and cause
   repeated donor migration
 - Extend kselftest to cover same-CPU and cross-CPU proxy-exec switches
 - Make scx_qmap insert blocked donors at the head of their current cid's local
   DSQ and request immediate preemption
 - Link to v4: https://lore.kernel.org/all/20260710083913.30573-1-arighi@nvidia.com/

Changes in v4:
 - Harden scx_bpf_task_proxy_cpu() locking and blocked-state validation, return
   -ENOENT for unrunnable owners and drop unnecessary donor-affinity checks
   (K Prateek Nayak, sashiko)
 - Reschedule remote CPUs after donor deactivation, handle sched_setscheduler()
   admission and assert scheduler-change locking (sashiko)
 - Avoid a potential KCSAN data-race report in the lockless blocked-donor
   migration check by using rcu_access_pointer() for rq->donor (sashiko)
 - Fix tick dependency updates for incoming EXT contexts and keep the tick
   enabled for blocked donors (sashiko)
 - Dump EXT donors in scx_dump_state() (sashiko)
 - Reordered the preparatory sched_ext changes so real running-state tracking
   is established before donor-based accounting, and split the proxy
   destination query kfuncs into a separate patch
 - Add compatibility wrappers for the proxy CPU/cid kfuncs and document their
   results as scheduling hints
 - Link to v3: https://lore.kernel.org/all/20260706070410.282826-1-arighi@nvidia.com/

Changes in v3:
 - Dropped the core restrictions on proxy-migrating migration-disabled and
   single-CPU donors: proxy execution moves the scheduling context, not the
   task's execution context. (Peter Zijlstra, K Prateek Nayak)
 - Dropped the sched_ext-specific put_prev_task()/set_next_task() exception and
   fixed ops.running()/ops.stopping() pairing inside sched_ext instead; track a
   real running transition even when either callback is absent. (Peter Zijlstra)
 - Dropped the kf_tasks[] nesting and nested ops.runnable() patches from v2;
   extensive proxy-exec testing did not reproduce task-op re-entry, so retain
   the existing non-nesting invariant.
 - Replaced scx_bpf_task_is_blocked() with SCX_ENQ_BLOCKED in ops.enqueue()
   flags, identifying blocked-donor admission directly at enqueue time.
 - Expanded the curr/donor description to cover mixed scheduling classes and
   fixed local preemption to expire rq->donor's slice. (Aiqun Maria Yu)
 - Allow inactive blocked donors to be placed on a remote local DSQ while
   preventing normal migration of an active rq donor. (Aiqun Maria Yu)
 - Deactivate retained donors when ownership changes to a root or sub-scheduler
   without SCX_OPS_ENQ_BLOCKED, and extend the selftest to cover attaching a
   scheduler after the donor blocks. (K Prateek Nayak)
 - Harden remote DSQ consumption by rejecting active tasks and rechecking
   migration eligibility after locking the source rq. Fall back to the global
   DSQ without treating an eligibility change during the lock handoff as a BPF
   scheduler error.
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

Andrea Righi (9):
      sched: Add helper to block retained proxy donors
      sched_ext: Block proxy donors across scheduler transitions
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Split curr|donor references properly
      sched_ext: Fix TOCTOU race in consume_remote_task()
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

John Stultz (1):
      sched_ext: Handle blocked donor migration with proxy execution

 include/linux/sched/ext.h                          |   2 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                |  42 +-
 kernel/sched/ext/ext.c                             | 248 +++++-
 kernel/sched/ext/ext.h                             |   6 +
 kernel/sched/ext/internal.h                        |  23 +-
 kernel/sched/ext/sub.c                             |  12 +-
 kernel/sched/sched.h                               |   6 +
 kernel/sched/syscalls.c                            |   3 +
 tools/sched_ext/include/scx/compat.h               |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.h        |   1 +
 tools/sched_ext/scx_qmap.bpf.c                     |  16 +
 tools/sched_ext/scx_qmap.c                         |   8 +-
 tools/testing/selftests/sched_ext/.gitignore       |   4 +
 tools/testing/selftests/sched_ext/Makefile         |   2 +
 tools/testing/selftests/sched_ext/config           |   2 +
 .../testing/selftests/sched_ext/enq_blocked.bpf.c  | 112 +++
 tools/testing/selftests/sched_ext/enq_blocked.c    | 898 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/enq_blocked.h    |  27 +
 .../selftests/sched_ext/test_modules/Makefile      |  13 +
 .../sched_ext/test_modules/scx_enq_blocked_test.c  | 193 +++++
 23 files changed, 1581 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
