Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A113C7690
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149050; cv=fail; b=fw9HpkznLBuy3CXXNnpCyB6PADfC8id0RYbe4NELpRr9BXOm4wgIaw+r1em4AxEVVwMF6w61YDv8xSsB0OXMuowsHSt5lJaEv5hbrsLK7kOIIorYKRdcbrZPB7u8xWiXxavmgz+QMdd9sGOZ+55hYgFaFLwK3UP8NA7zH6kDUb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149050; c=relaxed/simple;
	bh=DGB5AqXkd5LyO/p9SCZXxivRVn52T9hBA6/SXZ8d3mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mrPkqkK/lGn1stntwNFl60QA/G6pchFAyAhvR6wKLCSFOVttaKJxHVATmih4BDG8d27KtiklTVBX6wKFs2odXdfO9BWIUmMHucaVhUzwh/O1t8iH7zVdsUekN2aDXIn/SxDbQdmm8nX7JkPqsvcf0NSDr3Tl6aVOtJTrYsKzuvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fgEIc3b7; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fgEIc3b7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8RY9X+ZRKSS1gnkBtXj4EHSauJRGkAKaolEmX9dx9T0TWnStIGZw7N7NZbcU8FVMGq0ag/68fSAcpyg2ABYdZI6HwxHQgAyK2Yx1Jv6z11SwvqLjaBCydlu9XpmgiXdesbEpfMQj2bASPLpAj7zOWVNPfwFgB/Pu+a5i+2anZUsrKf3aVCKyC2bayrJJk1/KPnId5/9ywzTMoghuh+uYUyskzEuDhG2ssN0gEqU0EHZzoNBxz1yZ7gZwpeMgHZe0emVzN+NDu8FDiMtXmNihFLqH36NpsfRfWuqdsu5uLgT5ysWbNZcsU0lmJVeF+KGaJJcopKqF1DOg+Sz+ZJypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqPPhB97UyXix3xCuftQzeHxKT7g0mK/6HWuhsDmRtk=;
 b=OxQPkwME0+WhdNc5WkChyvv637VaVMheC+PAYg4JL2/DIvGv9mZycR0FrRpjPrdONbrCMIAof80msQ1hLQvDiUfEzLJsUwzzg5c/XxwIEUfdb54Od4dQOUbL+MKRi0yWibMpzpyhCiAKMkriPf6PlXkt2D/nGlTMFXfMWORgNQrxbkWZ/92JPDmpu23LRIA3Nagc14JsL+9PdjsJzgca4LQnWsqx1f/bzNzmAm36isxY0XYlquy4u2jgFeRxOi5fZIRaAxLNMvD6RH3+LZsLA3vqGpEpcHqKefPuswM04SBn0XNfUdA8jwfPeFduXsT7dhjpp19j8UdezfyE7tn2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqPPhB97UyXix3xCuftQzeHxKT7g0mK/6HWuhsDmRtk=;
 b=fgEIc3b71aYoruOPa6RB0a4HxKWSKbzXYH1OPqYTv7aVwBxpVZwfNRFJTil8PhevKDACtNIcPHefltYmeLbyzLKQbYN7yJCxuUpcNTZKzCtqhR5h0buTbhudAAIQjBnSulmLFhOHF6upnhXkqCU5yMIk4FJX88y7l9gMpcNJ5neovtuJPWlI8iVjfPvYl200lc55riF6+uULOFAEpb3JyHgbffDoDuX4X1G+E7nz+4fw36xvdjCbpUw/CDA3F8Zddl3jVRtdV+k/krJT2q7Np8XH++47CtvtaGUwo3k0q6ykSc65BpK0otN5kwAh5QnEeApH95DlJ7Evdi+iccvl0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:57:18 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:57:18 +0000
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
Subject: [PATCH 08/11] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Wed, 15 Jul 2026 22:54:16 +0200
Message-ID: <20260715205622.276220-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 2043ddbd-a30d-4b39-0a17-08dee2b3a82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|3023799007|10067099003|6133799003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ffq6/BiEMG8+13u20uqaYpX/F77UDgEzh2HYiHiHV69ecm2PftIAtxVz4X2kSz7lkLWU0NtrXXtvq/sL411H8jLOQ2UY930QZ8M6cViAC4WFai8PFSCn6J7jApVDVFjGPDTaBOB7NMe4RPWHZ/UJuPF3AnvPECqz48mI+PIflds+6R06WBlCA/J5i7dG7tEB3IDqoNEVxQb/IS60L0WETgfDOIFO8pQ4tyw4pfBJzjHHt6WTzEcq1dt8wn7Mc64xBlAm/pdRF18p0yM9oZyRb0QTflywvUmGRSopEQFNZH82ksHsMdP+UMBKIdfdBTgD4DNmgrptbfsIJc1zpruqDqEH6Rhxj/nAqK7rhGWz5J7PbkK0GYKHmMAo2xujAxXT00tz/3woYRNyFljkmmfU5L/iQwYrPuKKG50n3T+0svROYiaAEw4uoYXv8p59iey0j+/S6SW1syg8PEEzVfGw/Sso6XB5kHCrhQBDXp8PY/uHztxF8BKXyDuCL0P5HQ59faSJ5kpGmY6PIeW7Tx8lrbYKcr6xz2yIHy0Sm9YddKJw1AM0N4Lx3cLVvOp9R7t9HZCOm6E73Ie6l+brYvlLqcNY7ldkpXSrzN1IaFYuAKV51cRzrr85+6tLjyKI4mvxe21hI9bSL6gJkfZGKpsP4c7VKonZIV9b3IjR9cs4VXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(3023799007)(10067099003)(6133799003)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i8JQ/5jB/aPVSTs6lcJTbzkhS/HTBaMOqjFcij6xpxjkV50+PbST1pgbMm3a?=
 =?us-ascii?Q?0dXDlhUAHoajTd72Kd+NL2muWl45gGMr1izEEaNWwvol8fGRh+DPFDI9Wir6?=
 =?us-ascii?Q?Pg7e6zqDkRxszDY42drCnPffraf9KHWmhxJQ6gTN02oZ6C62w493f/pz+iWS?=
 =?us-ascii?Q?lTbnleR9sZHAw2N1vW4ynzwJ+gMUHw19/In3VOlZCcPaOelzYZrsoZr/1/LW?=
 =?us-ascii?Q?KnohVuhyO3+4W9C5Q3nLADDVqzCe1E9RJt7ZyMHf+PHqRlf0lSObNH3s5vCo?=
 =?us-ascii?Q?xfjbyfdwh1jraLUQB3WYR7I9qhsMmS0mMyvlwTil2hWRlifq8n+n6LdO7L44?=
 =?us-ascii?Q?G1fOKSwKfDLeqVkN9tKTragxk80VaC6RnzriHY4Rufr4jOMUvElLb3JVpiJI?=
 =?us-ascii?Q?dRzP6fMkpQVHFLGHK77rT/IG3fXYmPhJTuTX9TEBrDKYXahiwNV7VTALjGWA?=
 =?us-ascii?Q?FcApkPloHrsCc4yZhR9/JswB9aJIykaZtJ9Vx+Ms2GwdN4T900ZjPtxUofG1?=
 =?us-ascii?Q?gswrpNQFJ/SZipfnnnWfWGqdE0OZaQBNEq6Kj1POx9FjmmZiqtZGEKK4yZbJ?=
 =?us-ascii?Q?EkwLQanV0PkqvoUt6by6+QajIS2JesolhkETTnJa8AZqCjmkpfhern6N9J/+?=
 =?us-ascii?Q?hkLce9WITrvr0rem8ndI9VbFHKrHZD44vlOoqweF8AqA85Nd16eoCizz6KhO?=
 =?us-ascii?Q?dUc5kZF3oXy6P/o/hmH28xA05fHsM9qtnKTHt0agyskJCSzrQAEfZY+XfoxL?=
 =?us-ascii?Q?rYEP4T3gVfIXPKZ20tFuK1VJKax7AB9DOESRMWwMM25JrQ3hVa/vaU7WVmRu?=
 =?us-ascii?Q?opbdPUrhxNGuJNe2Uy1Xt8lcOe3JkX05zGknVD/jODxM8nPD45tId7mFtuP0?=
 =?us-ascii?Q?4OeuayPpErL4HvswX85bh4PGOxiNJ2dHdl+dGLaaZowVPghuG1pZYaGhcyUr?=
 =?us-ascii?Q?iCuNXybsdG/oequyAbIJGePTOVH4bGXFQwrXtvOVvdDTXQ+TrNqT+ckLjuej?=
 =?us-ascii?Q?heD5F+DAxwiVVkUplpdldt+MeBVfJ5MTHHK9hY7+AE7NsNKAWGrDRVqKfdjN?=
 =?us-ascii?Q?QlekXE83+3nMfl8FU2yjl9gNfxh+Uomtt5Qzic66WBmzyVQbDRZSd/hmAV96?=
 =?us-ascii?Q?svO9wq3KE/ylYSjcLo1iw4K6RCyXDcYrKpi7MqZ/PbTNbmmNockUa0SBNFne?=
 =?us-ascii?Q?GTkiUUB3EvRLotYlcNTCGU4KAsAlGnNxTzkqEHlwUpiRXo7VyUqb1A0b6mfF?=
 =?us-ascii?Q?1JO7b2UFFPY0VACyGfadxjbLOd4HpUL6ivIDf81yH7R24aSW2BAOV+SkIya/?=
 =?us-ascii?Q?Ucdo7dcpQ2z3t6PLsXTwvokP7TUKXJQKSn0jbQ5nMNKphG2D2PYzNxpfZ55z?=
 =?us-ascii?Q?zBXk4bUoRy+lDMBEPiJKB/FigZ4Pn+pHhTp/kWZxO4eUphHL448WxFDL7t1Z?=
 =?us-ascii?Q?p5CU4KpKqKtTsskHkTbO8rpbNYIpyUMGnr7FTbdjK0aUbca2IyIF48Y+tRc3?=
 =?us-ascii?Q?CKgBYkdp+7BddZXKoq1toh9KiG/9Pka6q4Dn6NwfVtIweCra7aa49DBhf8j6?=
 =?us-ascii?Q?ol6qkCovVGpMFBAzdpFTQJlNnUCpb4I0I01QiWhYvQZHW8H7TZsEwB78oGXS?=
 =?us-ascii?Q?cVYkZotzLpzV/CZI3FY0WhQOd4QnxZ/IfQZyO7gtKvvW3GLHQNJnnoBLArP7?=
 =?us-ascii?Q?caJWYr8/d4LZ4uBqu6EbdkRpeAqgiGUlN4Bsx78BipcDgFbf2w5zDkBAd9eX?=
 =?us-ascii?Q?Ylwxo3fFzw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2043ddbd-a30d-4b39-0a17-08dee2b3a82b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:57:18.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RktOWjxFZuVF6PD/67mm+Uditb0GVKB2L50yF+eYONtSkUSyacpQVdx/ZtAfMsI1kqrjpz5SGBbuTExmvFJvMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

Proxy execution keeps a blocked donor runnable so its scheduling context
can execute the mutex owner. Dispatching sched_ext donors on a local
DSQ bypasses the BPF scheduler ordering policy and can give donors
more CPU priority than intended to perform the proxy execution handoff.

Add SCX_OPS_ENQ_BLOCKED as an explicit proxy execution capability. Tasks
owned by schedulers without the flag block normally. Schedulers with the
flag receive blocked donors through ops.enqueue() with SCX_ENQ_BLOCKED
set in enq_flags and can apply their own admission policy.

From a high-level perspective, the resulting flow for a BPF scheduler
with SCX_OPS_ENQ_BLOCKED is:

    D ------ blocked on -----> M ------ owned by -----> O
 [donor]                    [mutex]                [owner]
    |
    | ops.enqueue(D, SCX_ENQ_BLOCKED)
    | BPF dispatches D to CPUi
    v
 +-----------------+
 | CPUi local DSQ  |
 +-------+---------+
         |
         | pick_next_task() selects D
         v
 +-----------------+
 |   proxy exec    | move D to O's rq
 +-------+---------+
         |
         | run O using D's scheduling context
         v
    rq->curr  = O
    rq->donor = D
         |
         | O releases M
         v
 +-----------------+
 |   proxy exec    | return D to CPUi via wakeup
 +-----------------+

A proxy migration preserves the donor's wake_cpu while moving its
scheduling context to the owner's rq, so task_cpu() differs from wake_cpu
until the donor wakes. Prevent BPF-directed migrations from pulling a
blocked donor off this proxy rq. Otherwise each blocked re-enqueue may
move the donor back to its callback rq only for proxy execution to move
it to the owner again.

Scheduler ownership can change after a donor has already blocked. Since
sched_change preserves queued state, handle both iterator-driven moves
to root or sub-schedulers and sched_setscheduler() transitions into EXT.
Before entering a scheduler without the flag, deactivate the retained
donor. It remains on the mutex wait path and wakes normally when the
mutex becomes available.

The global sched_ext enable state can change while __schedule() holds
the runqueue lock. Once an EXT task has an assigned scheduler, consult
it directly so the task cannot retain a donor during the transition
unless the scheduler opted in. Tasks without an assigned scheduler keep
the generic proxy execution behavior.

The preparation helpers require and assert that p->pi_lock and p's rq
lock are held before updating rq state.

The donor starts associated with its original CPU. A BPF scheduler may
dispatch it directly into that CPU local DSQ to let the core resolve the
mutex owner and execute it with the donor scheduling context.

A normal sleeper also has p->is_blocked set until after
wakeup_preempt(). Exclude full wakeup activations from SCX_ENQ_BLOCKED
and carry a transient task flag from enqueue_task_scx() to
wakeup_preempt_scx(). Retained donor wakeups skip enqueue_task_scx(), so
they remain distinguishable without changing core scheduler wake flags.

Reschedule a retained donor when its mutex wakes it so ops.dispatch()
can reconsider the now-unblocked task. Make SCX_OPS_ENQ_BLOCKED
override the exiting and migration-disabled enqueue fallbacks so
opted-in schedulers receive all eligible donor requests.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext/ext.c                        | 110 ++++++++++++++----
 kernel/sched/ext/internal.h                   |  23 +++-
 kernel/sched/ext/sub.c                        |  12 +-
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 8 files changed, 123 insertions(+), 29 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 5da12d6562b8e..82d47a046a4f5 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -104,6 +104,7 @@ enum scx_ent_flags {
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
 	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
+	SCX_TASK_ENQ_WAKEUP	= 1 << 7, /* wakeup enqueue awaiting wakeup_preempt() */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 94a6d7ffd924e..6fd4c70c73fc0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -25,7 +25,18 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	/*
+	 * scx_enabled() may change while __schedule() holds only @p's rq lock.
+	 * Once @p is associated with a scheduler, use that scheduler's policy
+	 * even while the global enable state is transitioning.
+	 */
+	sch = scx_task_sched(p);
+	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
 }
 
 /*
@@ -35,6 +46,8 @@ bool scx_allow_proxy_exec(const struct task_struct *p)
 void scx_prepare_setscheduler(struct task_struct *p,
 			      const struct sched_class *next_class)
 {
+	struct scx_sched *sch;
+
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
@@ -46,7 +59,13 @@ void scx_prepare_setscheduler(struct task_struct *p,
 	if (p->sched_class == next_class || next_class != &ext_sched_class)
 		return;
 
-	sched_proxy_block_task(task_rq(p), p);
+	sch = scx_task_sched(p);
+	if (WARN_ON_ONCE(!sch))
+		return;
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(task_rq(p), p);
 }
 
 /*
@@ -54,13 +73,16 @@ void scx_prepare_setscheduler(struct task_struct *p,
  * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
  * is updated only once.
  */
-static void scx_prepare_task_sched_change(struct task_struct *p)
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch)
 {
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
 	update_rq_clock(task_rq(p));
-	sched_proxy_block_task(task_rq(p), p);
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(task_rq(p), p);
 }
 
 /*
@@ -1913,6 +1935,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1945,15 +1968,22 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
+	/* %SCX_OPS_ENQ_BLOCKED takes precedence over the fallbacks below. */
+	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
+		      p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP);
+	if (enq_blocked)
+		enq_flags |= SCX_ENQ_BLOCKED;
+
 	/* see %SCX_OPS_ENQ_EXITING */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
+	if (!enq_blocked && !(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
 	    unlikely(p->flags & PF_EXITING)) {
 		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
 		goto local;
 	}
 
 	/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
+	if (!enq_blocked &&
+	    !(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
 	    is_migration_disabled(p)) {
 		__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
 		goto local;
@@ -2061,8 +2091,16 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
-	if (enq_flags & ENQUEUE_WAKEUP)
+	/*
+	 * p->is_blocked is cleared after wakeup_preempt(), so remember whether
+	 * this is a full wakeup activation until that callback is reached.
+	 */
+	if (enq_flags & ENQUEUE_WAKEUP) {
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
+		p->scx.flags |= SCX_TASK_ENQ_WAKEUP;
+	} else {
+		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+	}
 
 	/*
 	 * Restoring a running task will be immediately followed by
@@ -2267,11 +2305,24 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 {
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
-	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
+	 * task's slice to 0 and triggering reschedule on the target CPU. A
+	 * mutex-blocked task is kept queued for proxy execution, so its wakeup
+	 * doesn't go through enqueue_task_scx(). If the BPF scheduler manages
+	 * blocked donors, reschedule explicitly so that it can reconsider a
+	 * donor it declined to dispatch while blocked.
 	 */
-	if (p->sched_class == &ext_sched_class)
+	if (p->sched_class == &ext_sched_class) {
+		bool enq_wakeup = p->scx.flags & SCX_TASK_ENQ_WAKEUP;
+
+		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+		if (!enq_wakeup && p->is_blocked) {
+			struct scx_sched *sch = scx_task_sched(p);
+
+			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+				resched_curr(rq);
+		}
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2398,15 +2449,23 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	/*
 	 * A blocked donor may be moved normally to select a new callback rq.
 	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
-	 * callback home, even if the donor was previously proxy-migrated.
+	 * callback home.
+	 *
+	 * proxy_set_task_cpu() instead preserves wake_cpu when moving a donor to
+	 * its lock owner's CPU. Keep such a donor on the proxy rq until it wakes;
+	 * otherwise normal BPF placement may repeatedly pull it back to its
+	 * callback rq only for proxy execution to move it to the owner again.
 	 *
 	 * Don't move an active donor while the source rq still references it for
 	 * scheduling and accounting. The migration can be retried after the donor
 	 * is switched out.
 	 */
-	if (p->is_blocked &&
-	    rcu_access_pointer(task_rq(p)->donor) == p)
-		return false;
+	if (p->is_blocked) {
+		if (task_cpu(p) != p->wake_cpu)
+			return false;
+		if (rcu_access_pointer(task_rq(p)->donor) == p)
+			return false;
+	}
 
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
@@ -2954,6 +3013,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	struct scx_sched *sch = scx_task_sched(p);
 	bool can_stop_tick;
 
+	p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3095,18 +3156,12 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		set_task_runnable(rq, p);
 
 		/*
-		 * Mutex-blocked donors stay queued on the runqueue under proxy
-		 * execution, but the donor never runs as itself, proxy-exec
-		 * walks the blocked_on chain on the next __schedule() and runs
-		 * the lock owner in its place.
-		 *
-		 * Put the donor on the local DSQ directly so pick_next_task()
-		 * can still see it. find_proxy_task() will either run the chain
-		 * owner or deactivate the donor so the wakeup path can return it
-		 * and let BPF make a new dispatch decision once it is unblocked.
+		 * Mutex-blocked donors only stay queued when their BPF scheduler
+		 * enables %SCX_OPS_ENQ_BLOCKED, so always delegate their admission.
 		 */
 		if (p->is_blocked) {
-			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
 			goto switch_class;
 		}
 
@@ -7049,6 +7104,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	if ((ops->flags & SCX_OPS_ENQ_BLOCKED) && !ops->enqueue) {
+		scx_error(sch, "SCX_OPS_ENQ_BLOCKED requires ops.enqueue() to be implemented");
+		return -EINVAL;
+	}
+
 	/*
 	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
 	 * may set it to declare a dependency; reject if the root hasn't
@@ -7431,7 +7491,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 		if (new_class == &ext_sched_class) {
-			scx_prepare_task_sched_change(p);
+			scx_prepare_task_sched_change(p, sch);
 			queue_flags |= DEQUEUE_NOCLOCK;
 		}
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index d7a1d6a14ebf3..cec43d47c5fea 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -213,6 +213,19 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, mutex-blocked tasks remain runnable as proxy donors and are
+	 * passed to ops.enqueue() with %SCX_ENQ_BLOCKED. The BPF scheduler controls
+	 * when donors are dispatched and whether they should preempt other work.
+	 *
+	 * If clear, mutex-blocked tasks are removed from the runqueue normally
+	 * and cannot donate their scheduling context through proxy execution.
+	 *
+	 * For blocked donors, this flag takes precedence over
+	 * %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED.
+	 */
+	SCX_OPS_ENQ_BLOCKED		= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -221,7 +234,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1614,6 +1628,12 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
+	/*
+	 * The task is blocked on a mutex and is being kept runnable as a proxy
+	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 */
+	SCX_ENQ_BLOCKED		= 1LLU << 42,
+
 	/* high 8 bits are internal */
 	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
 
@@ -1909,6 +1929,7 @@ void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
 void scx_task_iter_unlock(struct scx_task_iter *iter);
 void scx_task_iter_stop(struct scx_task_iter *iter);
 struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 68ab3675337f3..c279ed997490f 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -753,7 +753,9 @@ static void scx_fail_parent(struct scx_sched *sch,
 		if (scx_task_on_sched(parent, p))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, parent);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			scx_disable_and_exit_task(sch, p);
 			scx_set_task_sched(p, parent);
 		}
@@ -845,7 +847,9 @@ void scx_sub_disable(struct scx_sched *sch)
 			continue;
 		}
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, parent);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			/*
 			 * $p is initialized for $parent and still attached to
 			 * @sch. Disable and exit for @sch, switch over to
@@ -1172,7 +1176,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, sch);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 23d9ef3e4c9d2..8d5606e465080 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -117,6 +117,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index da4b459820fdd..79b31eb7db7cb 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -55,6 +55,7 @@
 #define HAVE_SCX_ENQ_IMMED
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
+#define HAVE_SCX_ENQ_BLOCKED
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index dafccbb6b69d2..7efe7b9346b49 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -130,6 +130,9 @@ const volatile u64 __SCX_ENQ_REENQ __weak;
 const volatile u64 __SCX_ENQ_LAST __weak;
 #define SCX_ENQ_LAST __SCX_ENQ_LAST
 
+const volatile u64 __SCX_ENQ_BLOCKED __weak;
+#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
+
 const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 #define SCX_ENQ_CLEAR_OPSS __SCX_ENQ_CLEAR_OPSS
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index bbd4901f4fce3..f8fbeb7fbf95b 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -47,6 +47,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
 	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
-- 
2.55.0

