Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5F42EED9
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615674; cv=fail; b=sL0tgTNc9xkhpuJsnJDaL22bf3pRhzEwHZ9uW5yPqRDpCZnvyIwr+qvBE4esghRyqsTXnPWQUPa9kIbrshA2460IIFW2taE5TPUiFH94TmHu4i+CSveT1d03CuIQGuO2ni8IYBNE/QkrOiDN7z+oGg8XDaEUPj8UdRxsr7ZC4Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615674; c=relaxed/simple;
	bh=MmnYOqc472P1MEZDBnYV4LUoX7LzVhQv0kIV9h6UmW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p91Y0O//359iQDoTIXlRIbgAgAG2GQSpfuZYUWwJ8kZKWTsc8H5coe3kJaG4LqQtkkH9czyhW5ZZ6kWcGI4L3eWiWSz4Z++AO2X2JbXxdz+yqGwHnUpYnSpWTS2NEJAKMpf8o7DaC+Dkz8j0loXmcjn2Kiy41cddjDDCfLtEFSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UQISbWkR; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UQISbWkR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkOWSrXaXDdTGTx8XhjYRih7yndOGu/2T5QA4uUj1DoT/bB/e2YY2U3DBcj8lxxJtlAdLztc8xtc5IS9aF8oCQfN8970pK2iBPpsivZcxaV2Zpv4c+7oppMn82OlFQ8juEf210IK7Foo5W+SrRhnUcrtM4J2KCuGwocEu6O9cU8K9TbRr4VhT8N50caxfZhC6sw2K71JXXFpyGNaVtxe8T/j5o4tcsY9E0rE6AeIUv14FYdrY5VJO6ESjf5o3dJXxeLdDsRzpGqXhMqGBMx8fuYjQBs949UuS4TonTFtBRrmHtfbtx8aJzWbn7E5E1KNRiIWZg/UhY7RNp2/iHirLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+4cLogTTFGRvsD4TXU38DoXEPR23R+XEeEhriqQQvQ=;
 b=ACgeojYVKxTooRQaaGI/+FLRWFBCHKcuqj9h+zcojimQ3ttLfAaAGC9bVttlO3QecBiHNnp1/vgvaAzvWa4w7R2Tp7XNAAtv9epg0c5cGpXia7hdyFhikbdox4qKXAEsf6Ag3H+oASCTTnOqq9i8KMC6q8Kud7MHlRn7aUS9ydxUveTl7uCMPt0t+4tMhWdslPje9MK7iqRg5yVOBuQUPoDRoHw0oejuGDLoDB38GWDufwUFP9S98SoR5fW9Y1U/ftWP9ekp1CiyFFGc3mCsLwPfVOLi6A172ssh0HzujWqwSCZHe3WwMbV+UOLCoC/EC+FMEPTsx4vc1H1yvWVtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+4cLogTTFGRvsD4TXU38DoXEPR23R+XEeEhriqQQvQ=;
 b=UQISbWkRtUnt//qU5pQu2RltSW7CHX8KOzFqbOTiy71IirasSZm7ALpbe8lEJeh9gpvXw8YheqfsDATNmifTplajLorLcOGiAguN5RtGng71CL4aws/wZUNvSSZPvBaEdDBv7A8rLZKkJbKgy1ViVu8WUVMiiUvRBCxm9qHLtCqlsK9aVJdbfnHpXNMFyD/5Als4dvuaFwc84Z+UH3ZZ1DXvjnAwEM82zIiJMCz/MWhpBEmZsEbarKdU+oJvs19N17H/TD+p2tZ/gkwjENfoZhsiUROEpFw9Lvq2mCgN8tjL3fR5ZP89JDwhpaLYTzCynPqa97JIv/6iqtfDuCu8hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:34:20 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:34:20 +0000
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
Subject: [PATCH 09/12] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Tue, 21 Jul 2026 08:31:30 +0200
Message-ID: <20260721063242.552774-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0059.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: ea52d635-6f12-4f81-0144-08dee6f2184d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|3023799007|6133799003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ninMUk3egRRgk5Cs2fYoTU4GJpgqim/pgJDl0gacqnypQbI1xr8gnk/BqFWz3fKD3i8oSZRYw9knX6mFPiQI7WjW3autoRLnHUwnNros0LKW+5Rz4s00v97UyrJKS2Zuqb6wq03J9ndR41gaq86MVBQAla8DgbRPDNbh9sL8VTn+X2IqdiQS2+x7bxm2fSTo5kx0hX48QZxj9QwbdKdcMUxc3yM17wVpqIarfNdVWfDMwlxwPDgbH+hqexvgcPrF+v8LfM1kHX3FlwFvnGfFTbDBSTulIqEcgsxYTckgQKfTkrFedwqC1w3zL4lHICu4AXlYG+yjOARpaKj1zJamMwLGjCEMSZPYnSBNr+2DNDOgUb74Vhv+3piLK50zdAkIjHm76A+a2PXjBbUsr7CGK3WK2qyKus7mRZnmkUFL3Y8UufYjgVMIS6I+fEmSPuGASNVB7pVRlehKSu2IyeDaV9vbowQRkFNe2S5M3Ep9Dl0okEiptZ6slk8f9fKt85f7Mfz1YPEFlyMYFwLB3u9B/wg+ys/HRwB/EqsaOnlWkNbs4g0Hbr32KpPsDfuijgFkcWZ87b0yJqUaaOuRkM4XpVIobOnS4gWYmCwoNzjM1E7qHfPawlVQSIrPDxrEODuhhaba85KyT5OfwRTd9vXmILHiSrx+aOy8DwgqqaT8C18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WJiV4sYGfBhz5W2pyII+gLfMpD9u2+WdIr6ARXLhQTg4CjB72H5cniJSr+bx?=
 =?us-ascii?Q?uqdLaBpWfCuLmO+N5wpGeTg10PePcPRRmBVX29IUHBa5C1bBVaEh/UnTfp+4?=
 =?us-ascii?Q?f+2aGLNMk6maVz/Mh8uUP7hEs52dwdtjquRaMTIJHJG8/GGXg+AF2V3e6qN0?=
 =?us-ascii?Q?AtMER/pj/Rs7zPZ2v9EPflUW1WlZDn6ZPSwnxoNYJ1qjezwIBLigOcd2TVWH?=
 =?us-ascii?Q?UwDCptJl4VhoXgVnPudXVqQ2rJqhDsaIOzPs3r9VWab5YRSGqGAGukX/IjfW?=
 =?us-ascii?Q?KRbPxEZbzzXvT+Le3CiyOE/+Eu4i+FV3v9AgX59Sls9uCPFDINLWbk2iSq0k?=
 =?us-ascii?Q?x7KDdeutlbBfe6+5jP3WnKCT0p8SnBm4XEEXpUxlqQG/rYj2IziLAkBuWUCh?=
 =?us-ascii?Q?pe2smgxKybwiXXk23OUucxEpnRffBuwsBh5mfiRCP6VaJsNuwlyiioquRRkM?=
 =?us-ascii?Q?pCFffBHm2bBvGmjUWKe6R0xZUw2oMALx2FEvDa44iROnjoydV0WWZ593lsME?=
 =?us-ascii?Q?yviRchC2BOdE6pO6Ms55Jqq3hJaFLlfqu0kMQKoWgInWZICNZUQfENV0b2Rw?=
 =?us-ascii?Q?FsZ6RG8sx5iILUMbc4pksCkqIRwq97z0+oZW+savy1DyCBPTjoQopxBziFnp?=
 =?us-ascii?Q?le5CtkzZ/8+nCe1mjcB8F5XtSYpVLk8auoeiKwRvaCs6vS6zzQG4FaUsmWY5?=
 =?us-ascii?Q?H0BXdHqubFkFjvRRMzmf4eF3QIx7Am+gb7T4lhiPtvkwUIQ0YlA+QBe3E0Rk?=
 =?us-ascii?Q?19rHvzDoHrnFlnQmtvlaWPqDXjIY2N+rVGozTkc7vu1Rad1nm2QV4IG7dJac?=
 =?us-ascii?Q?i/Lcf4aZIbeFuUonPUXGiMPiRgfZMUkMoXnCndPAmd8mP65LPWQ9yLR71qtF?=
 =?us-ascii?Q?+1ii0Pqm/yXbCKSRpv2HXa6+O6OYN+LqBx+7Q31W6tUZhUMnYkOl2F+UcCta?=
 =?us-ascii?Q?0OHblyx5pt3pN55ua5KIYJfxjnhEIehObrWk44SV2McWklgzzjf/sceblMFa?=
 =?us-ascii?Q?PaupfqSVJoMOvA3Fk5Gm9xw/TLdLo/Qz5V0TD63mSaRRjXqTtarQmhcgN3AN?=
 =?us-ascii?Q?rQbMWQaOMimO0GR1oBjqgiVnS0Icg1VbvxHKzzye+1s6r5z3WZvtU6V9wSAg?=
 =?us-ascii?Q?+PzHK/0GCxkQrZT+3OvfgCDhM27daUKeyA3yj/4WjqJ0Dl9u1pW3Juy/9Gca?=
 =?us-ascii?Q?ik8Va21NRkSJ6/mkkDooHm0PbC4N8x8or0lAiTJvrI4xme5dTFYSGIVlByMZ?=
 =?us-ascii?Q?JlG/Lbm8lT0wMmlBrQn2zbCtyzom2tdQ2D42Ty80+RahwUBWMZ8pGa98Ld8r?=
 =?us-ascii?Q?NziQlFbO93sT7IM9xjTMKrhtS5LUqv82wdgxyhh1EkLbJg/hZD/lTyhqgVqo?=
 =?us-ascii?Q?FhTSvVZcXF0PDffauRlKfeTHmjpkzR8yTn+2zkWyYnVtj3elB7i0YZbDdsjE?=
 =?us-ascii?Q?Egp0KAza5C9hu18OQeOFnKb+qBRulTlLRXAI9t81MJO9zDFoHDRpqeewvSdO?=
 =?us-ascii?Q?ljtvDMtCspTSaxuNCQmu/hfILfG3Jr7v6YWTuaJFjt8RYfjKg5oOq0jOz8cR?=
 =?us-ascii?Q?tlCtxxbB3Qdk/E5AVzQTyIok4hYL3yVAJsA3QKuJDzfv1OOc0rx1r0RX6VcE?=
 =?us-ascii?Q?tDl3/Fz+nuuF1yvSqwvAAowkSbfBq7yFVyPU63VLl6L3IMWLq25jcJs8VkWu?=
 =?us-ascii?Q?vWa06oMDWiCst7h6RQPfWEqqJszh0C7rmLiu668546D77F2BVYb8J7MhW9qM?=
 =?us-ascii?Q?WTGhUtIefA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea52d635-6f12-4f81-0144-08dee6f2184d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:34:20.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yQiCa5HYbPd87eTq7TffTTi66H2d5F+9LH2Esv0VtZ+/4gd4+jAR6BbgzUqGd3dPKrvMnnmld/Ay8GZ2Jk8IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

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
 kernel/sched/ext/ext.c                        | 122 ++++++++++++++----
 kernel/sched/ext/internal.h                   |  23 +++-
 kernel/sched/ext/sub.c                        |   8 +-
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 8 files changed, 134 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 901772d8ec15d..946659749d58a 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -104,6 +104,7 @@ enum scx_ent_flags {
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
 	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
+	SCX_TASK_ENQ_WAKEUP	= 1 << 7, /* wakeup enqueue awaiting wakeup_preempt() */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index bf53f2be77f05..1e91f5e71cbdd 100644
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
@@ -1922,6 +1944,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1954,15 +1977,22 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
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
@@ -2070,8 +2100,17 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
-	if (enq_flags & ENQUEUE_WAKEUP)
+	/*
+	 * p->is_blocked is cleared after wakeup_preempt(), so remember whether
+	 * this is a full wakeup activation. If wakeup_preempt_scx() isn't called,
+	 * set_next_task_scx() or a subsequent non-wakeup enqueue clears the flag.
+	 */
+	if (enq_flags & ENQUEUE_WAKEUP) {
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
+		p->scx.flags |= SCX_TASK_ENQ_WAKEUP;
+	} else {
+		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+	}
 
 	/*
 	 * Restoring a running task will be immediately followed by
@@ -2276,11 +2315,24 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
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
@@ -2395,6 +2447,20 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
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
+	if (sched_proxy_exec() && p->is_blocked &&
+	    task_cpu(p) != p->wake_cpu)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2986,6 +3052,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	struct scx_sched *sch = scx_task_sched(p);
 	bool can_stop_tick;
 
+	p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3127,21 +3195,24 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		set_task_runnable(rq, p);
 
 		/*
-		 * Mutex-blocked donors stay queued on the runqueue under proxy
-		 * execution, but the donor never runs as itself, proxy-exec
-		 * walks the blocked_on chain on the next __schedule() and runs
-		 * the lock owner in its place.
+		 * The rq lock has remained held since scx_allow_proxy_exec(), so
+		 * @p's scheduler association cannot have changed. An associated
+		 * donor stays queued only when its BPF scheduler enables
+		 * %SCX_OPS_ENQ_BLOCKED; delegate its admission to that scheduler.
 		 *
-		 * Put the donor on the local DSQ directly so pick_next_task()
-		 * can still see it. find_proxy_task() will either run the chain
-		 * owner or deactivate the donor so the wakeup path can return it
-		 * and let BPF make a new dispatch decision once it is unblocked.
-		 *
-		 * This is preparatory code: a later patch will delegate blocked-donor
-		 * admission to the BPF scheduler.
+		 * If @sch is NULL, @p is transitioning into the root scheduler. The
+		 * root is published before tasks enter EXT and cannot be cleared while
+		 * this rq is locked. Preserve generic proxy execution by placing the
+		 * donor directly on the local DSQ.
 		 */
 		if (p->is_blocked) {
-			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			if (sch) {
+				WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+				scx_do_enqueue_task(rq, p, 0, -1);
+			} else {
+				scx_dispatch_enqueue(scx_root, rq, &rq->scx.local_dsq,
+						     p, 0);
+			}
 			goto switch_class;
 		}
 
@@ -7209,6 +7280,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
@@ -7594,7 +7670,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 		if (new_class == &ext_sched_class) {
-			scx_prepare_task_sched_change(p);
+			scx_prepare_task_sched_change(p, sch);
 			queue_flags |= DEQUEUE_NOCLOCK;
 		}
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5dfb7e466108f..47bf8e8c34590 100644
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
@@ -1650,6 +1664,12 @@ enum scx_enq_flags {
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
 
@@ -1946,6 +1966,7 @@ void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
 void scx_task_iter_unlock(struct scx_task_iter *iter);
 void scx_task_iter_stop(struct scx_task_iter *iter);
 struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 8d8737149bc07..e167bb7b40cf4 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -773,7 +773,9 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scx_prepare_task_sched_change(p, to);
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+		      DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -803,7 +805,9 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scx_prepare_task_sched_change(p, to);
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+		      DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 7757252d52e21..0e83ebfbee2b5 100644
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

