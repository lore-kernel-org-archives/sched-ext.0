Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962C424D4A
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208222; cv=fail; b=ctz+j36AX4MznRxxRuOdO1Ks/A2Vmgw9J23G2U4rZ8i3buReAHADZfeItF/GekMLRAFpk4bhUgzVIGwyZHqO8qAQ7pxH53667o2L/WADKvrhVHl+Om3M8N4+1Xvxu2D4IvPV4WsxS8psIa02iEAsELwtnwKXirdEeEJQ9faquPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208222; c=relaxed/simple;
	bh=NSpy0177ZBor7Mr77vLXhYNtjB/9cxmvu5DgHXpptlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X92NNlKw6Wt/n+MqqTdQJY2rkSqsagbrlkjGPxQ1FOi5KoyMZrMdnv1P2QjfUqCJbMZ+4nzY87Swnrefzlr9ff8Res6Ud9TfUGJMDQiMB4v3dFfLrFdQP0BfGGp4y1UkKlgSurOay99Ta8plrtFQCRALDn69gRB8lsiX2PwLWSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hTLbvYm3; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hTLbvYm3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf1ry+xm0GX1A6dW/+OfgtjG9rtpFG7fh+3vtKe/gb2F1ZWnWc/Juiky3xHFyxkXLix72wwX5/MkgJfqdiNpS+Bi2b+f9PxziUD7zzZZH7jc7l+bykp3jMp0ygLP9bw4/ZgzjAMZMUxc41B9G5WDENaKDbcgpME2Fqtsz/jxpI6g7WH/gG8QEPWUtJU0LxUCWm7BvosL1tlH8zMwuF/TdqMZsIlri3sb+fFA7f0gYRwVZEHOkl8aJy3HrKf7tgf7d7IJuyU7ihixmT9eHFkPSxVTTNKhAYJeMeRNW2om0EBxjzF7z7AR21oeZAJJ2gwnKfZVUr0xGaS14DwJCiID8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+5VJ7RPN7GtR+NNsPduUtNyrNTlzTBL6VNqxy/1kTA=;
 b=o8d8T6VhfkhMmpP6rZKoYxfdQgwYfMLKVs9ucxojRFtLwviOzFkf+UymJ40tSi480uWsq8Q2tv+4A5O0V/6Q/QE6dGFSIhdfnKMwEH/ebinRDRB+ZgZUfaSA4k6N8jiR1RST+PX5bdTPPpep1aUTiN500bxnrP44c+FLZDPrFp025Y64K6RhSOap52NTg8fOzCFstMin/SUKunndfXz3AnV7tWyPREBzW7X0x2wczlkHBHLeJwr2/Fnw6m+70529e3pidNT9pXV/Ow561ST4xV8OlYSJ5pR8IolcLSxlxg386nS3bonb2iIAHZ3ONhLGIO0hu+lXZpu9BaEKIiQCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+5VJ7RPN7GtR+NNsPduUtNyrNTlzTBL6VNqxy/1kTA=;
 b=hTLbvYm3PtaiOj1I0YBrp8QOwIi3yKJR40jTcMxYfG16Lv+4UANA1HI0EGbDXrvT067IFoq7R7nQmadfkwfoO0COtvqRUBjGdItNrJyK8Bb694+oxYAX9FxvaV0bbVAndcaTrBUOxx3OuHodqDBr/wyFy7biqi7817cVVp5ucBYn3SsEGn+c0IoyVhYyLoU79ScKz+l4B1H1DSTCKE/sl0elTyqz9KQ3C1S9bf8UP3eJfftrE6rwOZAtffKERTgzff8UhMl2cUv7UGrYk5yEWe6C2tOYIIVB4G249zgW1XWxRbLXOjXm9IzHsB7l60caYxN0b2oHtHZnPGzsbaHmzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:23:33 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:23:31 +0000
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
Date: Thu, 16 Jul 2026 15:20:43 +0200
Message-ID: <20260716132229.61603-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff8150c-e9d2-46bc-2c31-08dee33d6e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|3023799007|10067099003|11063799006|6133799003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jA8Ngbl5QgVoMHIu83XZTLobHrUA2OMnYLqoJNWzjagUAG1oZLSyDCQ8nb0vdfsdDaY8HGQ6jRu2q7Jg7P3ipXaddzdsbKFUXiVYofwzUa0SXsKcAbcPB+aUpZ5wynz8svHnDcsqMJKqwzh23OeRf0qbF7TQZoSaKvXdU8HE7w0ZCx4QwdnVjqwOE8Y3ZzpcH1zWHSvoIsdrHAAJvs0kaLGlQjzcyhLcb4gCUzgcIL6wzo+Nn6en4NqDjOFno8zF/nZcC/08RBp6ljUIVRRqfyraZMy33hqsLg1EdHfGyq1h1+0tHuHRujrxlcfAJPrGjtSmL/9i1X+TQQDIjPtwvlPvkV7AlgiKnkhNRYhmiCHofzWp4ApPCMKLu/l6oPbstdrrNU7zhNdCzlb/Te5a77BPd4dG+thl3I/sV/rewcsQjJDP2H72IAEkqxg+Hkf6X4fheh2Ux4d5Cl0VEienQ0U4jSYBfVHNydRGPNozmgUxZVeZ/rfJCtfyLlIkXnISH/ZXWfraok/s/8p/FYcP6g4PUBL1DPpjLTrylbso5Lta2ON37Ya/aqkyAq+fzOZSiaXrFIdBFbOJvoOyYJkrQiNS7NkFm9Qkg91ZILGmCwgY+Dm8Kvuyl3mRPbO27NgP2PAl+d656NGjjgTEIA/3H/CdxE3e3suSUY5xw50bCv8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(3023799007)(10067099003)(11063799006)(6133799003)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kNw2vToB0EfAkAjcOBFGCsILztdEPpx8/oAUaou2y7X3ouHzDJHL6QC0dpbK?=
 =?us-ascii?Q?EXpRmoL3TH4IpPV+Ed99gJ/uo6GUuLnNykwx+9NujasjiF+yFPo1vSpSlmWj?=
 =?us-ascii?Q?NggHpoL8FTcb3KFVoi0s1hAISiFnPM4MGt/o8ECBjXOegDVNz5QKsvigqeAG?=
 =?us-ascii?Q?34scYept+ZzpGNgfBnHV0Rxee/0o4b4gq/k31Sih/q5YcgFPdZdEdvZ8ws+f?=
 =?us-ascii?Q?C+6Z21U1UCCHuLFhjVHM+lDoO1TYlAoC0e9VUxoxGKjH3ZybKelpOv/0hiER?=
 =?us-ascii?Q?ULq3cElEYirUia0S50J+RzBGOynd2WP81EH7z1od4/qTfZmty0VLLXQTxUhz?=
 =?us-ascii?Q?AKRyfY7yz7PSiyGG+fl5E2exp5pF+Umv+6hHppaw3YQAp3enpXY2/HzY+0ek?=
 =?us-ascii?Q?xTFybL3MSLpVVDzSgnTO3/PGCKJMU2+n0ZzFbfMtGER2/YUQAxCz+M5Goz6F?=
 =?us-ascii?Q?X9lV4irnCxOeLm8RbgANNHUdaXRMTLyxpPMR+aQeEHHxQM4BTblnMf16E93M?=
 =?us-ascii?Q?5a2rkGbt2oY5dWTEwVcMhgRCPUD51mKz2Xb+c+Uf+HUAalnHrk2kOYULbiFx?=
 =?us-ascii?Q?lXM0WeKA0DpTjUIPxocPXX3/1DXQWu+ZhIKLXjD+BbWGVPapyMguYeWx58Y5?=
 =?us-ascii?Q?fsD86phtFuW1R0iHoJ3apsyZ44tSnMHRkxPU6t03p93cbCXQm/hd7HzX8/gE?=
 =?us-ascii?Q?efS3Q+XX1Qtj2+WdxYidWQ2rJmPvf6Y/1Z5wT2tc/VKbS1QGergxhaKzcKv2?=
 =?us-ascii?Q?hx9NbgkavPmw/jWQnX68VVcrTfeCDwXhuQ3LcFl/p5AEi2Iv3VR61AeX8mNY?=
 =?us-ascii?Q?TqD9UbvWsjtiBQY7ZqmOnx5hikcJIbCa0zTUSzqs46SCo8tZGPtAM6T+t5al?=
 =?us-ascii?Q?yx1kfOGVv1ZhSezmGUcQwXXpjpZu3CUcYvoKT5NwDBmDQmrQ5INdUMTLYg89?=
 =?us-ascii?Q?mf/7cGlUo4Rzq+X/ZvTssecpeSqlG2l1zvrlCCLYCxhTuRbFkkKA1BL/UIfI?=
 =?us-ascii?Q?9E9DkgZb51qVP/U//9UDOoyYwQzH9aL7ynOv/0jU92SUs886U5opFNs9E9m4?=
 =?us-ascii?Q?0ouT81TPfxhyVQXCQcxo61rQb12wHh1jVfk3jngbDrOgiTQS9vGIi5x9qisA?=
 =?us-ascii?Q?xOR4Z9ffVUCcwOIPorYHAGcxngGNSKKYTC86erW70LibXcYT82LT1VsJgr9E?=
 =?us-ascii?Q?TE6C9/+lo8ciecE3NBLcH1F0h//gy34771Bv/DD0sjHLUpBaig6Ha0yQFMkE?=
 =?us-ascii?Q?wf+f3LpL7siP6Jj9mH4eISzBHAGIgHSbaYVK2VdJ7veFYzyXVl8Kwk9huuNi?=
 =?us-ascii?Q?7zCsQ4RAOwihfCNBWL/1eKuokN8grkT2xeYyZrMl+tJoUFm/NYY76zDXVHWz?=
 =?us-ascii?Q?JlD5116YNadAXpOM7mRFU8Od35PSqlrI34brNxZGRdbvxhxriu8owejEWxOP?=
 =?us-ascii?Q?n9KHLwHM2NkGNrWG+tLMZlqvSTTLo5TB4QXkGvZnCDNb3sgsYaukmC5OyE71?=
 =?us-ascii?Q?hppmLxU6sJ4dTDiNcF/qSGY6tK4gMfnDdkYsXtx2ht3DtbVF0b/n6zdlqa64?=
 =?us-ascii?Q?xCutcrbyO5GuheYLQDhOkPJDibELjQgYljnQnyJP6JbUJxhkJTTl5cVWX07P?=
 =?us-ascii?Q?gCyfAg5gWEtnS5pzu5CGgEusLm5s1AQzCMU6CC21DoZDpB9XOdLuv04XjMmp?=
 =?us-ascii?Q?+irwLPAu8W0mleRDwVpSoyOErtw/Qa7CsdZAnTzutgR5bi0YDI6IOVAVmmRU?=
 =?us-ascii?Q?yr7poRoIUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff8150c-e9d2-46bc-2c31-08dee33d6e5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:23:31.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxl6dCLqg7LtiEH2qQEQBTzOYjmPdzTBmpaZInV+1xLC+H69Z6QIf808EMqeMkLSRMdoBj05fLbvqGAchF22LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

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
 kernel/sched/ext/ext.c                        | 109 ++++++++++++++----
 kernel/sched/ext/internal.h                   |  23 +++-
 kernel/sched/ext/sub.c                        |  12 +-
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 8 files changed, 127 insertions(+), 24 deletions(-)

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
index 02e3ea7add16f..3456be01d5548 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,7 +26,18 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
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
@@ -36,6 +47,8 @@ bool scx_allow_proxy_exec(const struct task_struct *p)
 void scx_prepare_setscheduler(struct task_struct *p,
 			      const struct sched_class *next_class)
 {
+	struct scx_sched *sch;
+
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
@@ -47,7 +60,13 @@ void scx_prepare_setscheduler(struct task_struct *p,
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
@@ -55,13 +74,16 @@ void scx_prepare_setscheduler(struct task_struct *p,
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
@@ -1914,6 +1936,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1946,15 +1969,22 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
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
@@ -2062,8 +2092,16 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
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
@@ -2268,11 +2306,24 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
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
@@ -2387,6 +2438,19 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/*
+	 * A blocked donor may be moved normally to select a new callback rq.
+	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
+	 * callback home.
+	 *
+	 * proxy_set_task_cpu() instead preserves wake_cpu when moving a donor to
+	 * its lock owner's CPU. Keep such a donor on the proxy rq until it wakes;
+	 * otherwise normal BPF placement may repeatedly pull it back to its
+	 * callback rq only for proxy execution to move it to the owner again.
+	 */
+	if (p->is_blocked && task_cpu(p) != p->wake_cpu)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2957,6 +3021,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	struct scx_sched *sch = scx_task_sched(p);
 	bool can_stop_tick;
 
+	p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3098,18 +3164,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		set_task_runnable(rq, p);
 
 		/*
-		 * Mutex-blocked donors stay queued on the runqueue under proxy
-		 * execution, but the donor never runs as itself, proxy-exec
-		 * walks the blocked_on chain on the next __schedule() and runs
-		 * the lock owner in its place.
+		 * Mutex-blocked donors only stay queued when their BPF scheduler
+		 * enables %SCX_OPS_ENQ_BLOCKED. The rq lock has remained held since
+		 * scx_allow_proxy_exec(), so @p's scheduler association cannot have
+		 * changed and @sch must be non-NULL with the flag set.
 		 *
-		 * Put the donor on the local DSQ directly so pick_next_task()
-		 * can still see it. find_proxy_task() will either run the chain
-		 * owner or deactivate the donor so the wakeup path can return it
-		 * and let BPF make a new dispatch decision once it is unblocked.
+		 * Delegate admission to the BPF scheduler.
 		 */
 		if (p->is_blocked) {
-			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
 			goto switch_class;
 		}
 
@@ -7056,6 +7120,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
@@ -7438,7 +7507,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 		if (new_class == &ext_sched_class) {
-			scx_prepare_task_sched_change(p);
+			scx_prepare_task_sched_change(p, sch);
 			queue_flags |= DEQUEUE_NOCLOCK;
 		}
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 4f4130f0d1211..5cbc2808cf365 100644
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
index 3cc6d2633f73c..b1c464061d394 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -780,7 +780,9 @@ static void scx_fail_parent(struct scx_sched *sch,
 		if (scx_task_on_sched(parent, p))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, parent);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			scx_disable_and_exit_task(sch, p);
 			scx_set_task_sched(p, parent);
 		}
@@ -872,7 +874,9 @@ void scx_sub_disable(struct scx_sched *sch)
 			continue;
 		}
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, parent);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			/*
 			 * $p is initialized for $parent and still attached to
 			 * @sch. Disable and exit for @sch, switch over to
@@ -1207,7 +1211,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
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

