Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089843D4E2
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615691; cv=fail; b=ItYNnJV/DKYfk7DXkyG/h6ILJ3P50n8sOgL5iQT7lomsXfrQxICXCEwSSmvypyNAhrhSOkJ0JYGeJ3SMx1D0KcUFQjjJXxbAzLUdgp6+pYXLfHrbXc6teASyU2dAXtHhiE4Q2Zg8c0OZX/mNBc2V8Ul8XAJCMiLyDabrfE7W730=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615691; c=relaxed/simple;
	bh=jQPhl4IS5CRoFqesqegEEK4PN4zJOPXZ8umM9oMoEBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ejEAitg/LK0zKkGpaxaNeL2Xhv1GoVyXJK/R8Tn2JgsM+5vs2Sd6qpUC7jh+TEEkkJWXpFRpMYti9vkCKqIdvpkpomCkpRFN25XyhQ7l1lXmIRw1BQ1s7lqxixoABOPqGXr5J5JaOAUTvdOpA5xize61NMur773JP2AHhg8IMLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=foBN36cB; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="foBN36cB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlvZKFPh9zAc/CjanIfyBfKqTJvXf2ChSLtWOk0HdYHqT1vHqs0Yr+ztYzx32OC9ysqGFvt/Ptakta76xwl24F3NxpKilTW+Qs/FqRcjgbelTdhIlDZrrEu2QOvafWRLNLRjxrZmkweps/QCfV0rJx+WHMXLU1/39h/hvluSJ5HLimODM6djN6Hm277uyyTk07a+ZgWEpJJlwnLqG3oWs1M85zkI2hr+stsH0KWsP5R66JiPzMRgK698OHKDehhoMI7vmPjOuRENmCeKvt+4VxvtQk3XBeCQrFFyJKbfg11LCD13gaQID1gmSid6nbsgpo28L3RajUgUSri+8DimOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDhAJdWOTrkUWGklCJXvtnAwI49j8X/0XPuSY6oTT2I=;
 b=lhAautyajnUfWQpPnO22Lsuy82YAA9pC27/JIcMk7410GC5FTazZdeTqpIHilgFqVlqbjxW/S/jNWtugf31EULRMjNC1NNRnvw+VJQt7rTQyyt4ORH4Sa0g2lbFDpNnorEZ0D/cd9SGYT81X9oh+vQIeeByBhF37gako8/a9OUxwJvFOl8WF3n5/dQRpO4k2DYWLwF05rwc+mB71GW1qk5BUxNOgiJ5KhfIX92yto5z5FVuAsM+LxOR9Y6cXw53gKRt4PPptyfyEDr1qd8kkDgeDlbfjPDKXG+TlPbglYQq1v6z12hBj1WVrYoHNpunwGpCE8CSW3WiSl5NjkHyLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDhAJdWOTrkUWGklCJXvtnAwI49j8X/0XPuSY6oTT2I=;
 b=foBN36cBaVfUs6drBu6RxPk+klQfU8w1sha2pw9mT7Spw/VxX3SOgnwKtu4O7P+rQkKRD8KzacPugaTTokBjrwuyzRoaJujBKb9nfuFDzedjDieXh/ybxtiwaxjf0VH0cDSojM8Y8pqczTw5Ldx8e1F4q5guudod0b31hcA613XAqr1J+ocdRwxQqOvwVaygcElagfH6XReqtXehQDLbA3vMmpVSUqlQE0YpMNBU3Sc6hONkRALbuSN69bl4NwIVHLj8rehCLqQStprlCBGinrJwhowMvqipkfAKO1ALe/8BcGdeqi2X+7/QHHxQEKQreyZ0/sQ98TNW95KqwxlZUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:34:34 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:34:34 +0000
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
Subject: [PATCH 11/12] sched_ext: scx_qmap: Add proxy execution support
Date: Tue, 21 Jul 2026 08:31:32 +0200
Message-ID: <20260721063242.552774-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B8C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 6488c338-c0ab-4100-1782-08dee6f220f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|3023799007|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NJ8Bf/TEk8HF17CIZmBj37cZ/rOMCy5+HXHYBn4SdhAsAEsEILaCXUOsACw6PApt7u2K7mVF3raUkLVnp29DfstYwdTHMfheEynfyiHceBTdX47bMrCjDRGus3ePFfGBxj/zezSFLT/ciM7R1WBnZumJyqz5ht+jUy5SCQDf/JatTugkzPtnCjsqXAh6G66sl1D71B6Y7SFHGOq0jN8SXKv2xhjYPOpBv9sjuqjZD+ECHd83FR85bHXoo+LEKkRZUk+kcsW3dB3U09rVddV0syXxsWy4nKIfAh+VCiVZUsmJPe1AASGrI1vB5oy0bFXm8g6fFpCFolGs/HCO5kLN1H4F/SzVfGEvRVtAbIE+DWVDkX/awVP4AvMgRKtaft3rFdxyGswhho0d871/9l/5D/uR2bCO6iZCi+ypTUojwxiPsUDq1i96VZupz6I9kciqneEh0A+vakzHlWcTHSLENz5XqKjoY8Jp2FSqkE78IWCaHOAz7TI5Lyi09uJqxrx4y6LmONVE0hr7ukxJkrdtMun0v168jjTq2DYiMnIu895jCLh0qFN7TUAL0C60kyMk/gY/reL4C4lWTWMJxhGS2e/P8n3lcY3rfeQ6gSFcS5IiwwQrYAEgskW6Fd9DKaGEitqlqpIlDtdntC41Lk1XlAIsODv8vzeo4sEsHlYVkcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yVdCKc0fh16+TsCUjDqe6bdFL9SPWkPFRv63pekBLJoDPchl4WHlaNCFAlTx?=
 =?us-ascii?Q?HbF9ccHcMUKpV7Ev92flnVwcnySNqYYH4a0XjBiWeCIt7pF/Mj8AnhqIrplW?=
 =?us-ascii?Q?opsnDKyxDY+cmy95vl6N3Q6jvGy1DawSREDDRiWOrppnf3ao2522Ht+8Wx39?=
 =?us-ascii?Q?LOK+bWfrCMohEFtQAXPSu1jcNq3TH2+A11Z7jItweqPv9TFTvlLI9pxTUSRA?=
 =?us-ascii?Q?IOIMRQ/Wy7jm/DvLR/ow5nzKmXKwNF7AoMtMOJaN7iaoE+23KCN6C5hICIxJ?=
 =?us-ascii?Q?SOooLMDeRn6OmsjAPPTGaW1RGLEAfPQYmJnE3RJe0jz0JM0GDLEhaEyB2u7D?=
 =?us-ascii?Q?fdzlhT84WQrtbYdRw1i2K+MDFrGYyoWi0QDwktmK6pSVubfWn+T5dCC7/VtA?=
 =?us-ascii?Q?mVFFmeTenYIZIptMk9CKfHWHUNudlAKEx0OaEPHYHtdN03YzylaIujTrcRN5?=
 =?us-ascii?Q?FmemsPGy0T+tcge087+uTW4zqOzwaLnZVCKkebzqOiewDBHcOROPBPkjcwkU?=
 =?us-ascii?Q?06k2yh8D9aLE7xeTeqbUxZTMz+fE6WRU9/rSiOZYP7TOLPn6D2/Dk6dMMtxw?=
 =?us-ascii?Q?Oz2mbM/FspUpFJEWWCB+FkkW434YjrHkXgwvLFwIdcDwvBrWRlegIHemC/Dj?=
 =?us-ascii?Q?5S0jIxRpAqi+7czlZa5gs6ANYxZPn443Z3hCyocYZyfPG4xKVFiW6tXWEoFK?=
 =?us-ascii?Q?JBqFahhCgE8TY5001XgLebqEGyhj0dCy/fLs7TQRaGPJMd+L+EEaepPNrBKG?=
 =?us-ascii?Q?fZja8N+UFcgSyXWr55SF5jxi+2oAUq/OCaOfhRHJZh8bleBBIW+6Wd8nOegP?=
 =?us-ascii?Q?M1muu4ZaI+YQYynzQu9wTSAV6L86NWThnaJz3hfT+PKsrZJT9e3PRjIirkue?=
 =?us-ascii?Q?WZDsOX8JZ1onJqoNrh3eLiKw7azXqdnPgI5R+j8JQTeOkblb/VdJVLvKvLs4?=
 =?us-ascii?Q?dZXJ4GJ45A8mDtwTcUFLGUZiZAOt2WWDU+rKFMOjKQANg1GnKcAIgSRjrZmz?=
 =?us-ascii?Q?qIyqJhWwz8mZpAxRlYY0kGVLp91KfxB/74zWegdbfqf2rbphqCjL/GemFuP9?=
 =?us-ascii?Q?eHDkaBwVQuZLajciQqfxSCuT1pF2S1TILq7BkVXWVm1aDtEdNM2gAFyrF8SR?=
 =?us-ascii?Q?X6KW/oSB+E5n8BBCcksIICst+PE9cVmQxYOEjp/RsNEhup8efQnfFElJ/eKy?=
 =?us-ascii?Q?HZxYU16nliaLnHaM4fL2nKibl9kOuQpwH9IDo7GettnoQVA4LdDB1CLYOceg?=
 =?us-ascii?Q?Mwgj0GlY67cjxxAhjIaslUAyoNYaqNmnJBvCnA0+Z/s4IjjRAelZApL7a+ah?=
 =?us-ascii?Q?Vc5sal1l3HzcXLT0J0xpbjILLhteCIM62L0u4v0NsFln/J36b5kVWYOJWVH0?=
 =?us-ascii?Q?r4pGiVWwP1Y4HcUQUnesJYTFRs98plq8xMI65h3FUNGPBu4MTLA8DXFvBG1N?=
 =?us-ascii?Q?PjXwXn1DqotN69Dop27m9qJdp1iAPrNIukd37LVXOAwPOvmyCf94++IOpajL?=
 =?us-ascii?Q?QLxVx5HHIvklaMAFg6VJ0Jyj5lMdSaxjj55Xqx/CGW9uoPCBpHC+YcoZQhK8?=
 =?us-ascii?Q?yhidZda/b9xvDAfghpQoeVfjM3bjgZGz14KBxeJUZp0coYyJTpQP7cIjkTIX?=
 =?us-ascii?Q?I4rMD/1gecQ1WfgqzjnR4NK25B40UNl62PEjEpxY6iUOQVp7Cp0iXLoQ3mil?=
 =?us-ascii?Q?on7s0A/BMuR6cNHF2J++BdmFqtDhOFBp55Y3tOpzfxDX1XxQgNj+KFgn0vrR?=
 =?us-ascii?Q?uaHodPx/aA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6488c338-c0ab-4100-1782-08dee6f220f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:34:34.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEU8WLlltFUH9JaS9jTwoZDMhVjIBlVwRfKJImtasCsw0gH2giRqMhnm3PGPbekOLSwpbXL5ZnSlk7wlf7JAow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

Add a -B option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -B, blocked donors are passed to
qmap_enqueue() with SCX_ENQ_BLOCKED.

When scx_qmap receives a blocked donor, dispatch it directly to the
local DSQ of its current cid with a fresh slice and SCX_ENQ_PREEMPT.
This places the donor at the head of the DSQ and requests an immediate
reschedule, allowing the core proxy-exec path to run the mutex owner
using the donor's scheduling context as soon as the donor is selected.

The blocked policy is intentionally unfair and can strongly prioritize
tasks using contended mutexes, but scx_qmap is a demo scheduler and such
aggressive behavior makes proxy-exec support easy to observe. Count
these dispatch attempts in nr_enq_blocked and report their per-interval
delta.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 34 ++++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c     | 13 ++++++++++---
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index aead17658573b..5ca1467c1325a 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -451,6 +451,40 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	/*
+	 * A blocked donor rejected by a local DSQ must not be dispatched back
+	 * to the same DSQ immediately. Move it to the global DSQ so another CPU
+	 * can pick it up and kick an idle cid to accelerate its consumption.
+	 */
+	if ((enq_flags & (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) ==
+	    (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) {
+		taskc->force_local = false;
+		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
+		cid = cmask_next_and2_set_wrap(&taskc->cpus_allowed,
+					       &qa.idle_cids.mask,
+					       &qa.self_cids.mask, 0);
+		if (cid < scx_bpf_nr_cids())
+			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
+		return;
+	}
+
+	/*
+	 * Insert a blocked mutex donor at the head of its current cid's local
+	 * DSQ with a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate
+	 * reschedule. Once selected, the core proxy-exec path can immediately
+	 * run the mutex owner using the donor's scheduling context.
+	 *
+	 * This policy is intentionally unfair and can strongly prioritize tasks
+	 * using contended mutexes; scx_qmap is a demonstration scheduler and
+	 * this behavior makes proxy-exec support easy to observe.
+	 */
+	if (enq_flags & SCX_ENQ_BLOCKED) {
+		__sync_fetch_and_add(&qa.nr_enq_blocked, 1);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cid(p),
+				   slice_ns, enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
 	/*
 	 * A node with children delegates most cids. A task of ours that can run
 	 * on none of our self cids (e.g. a per-NUMA kthread pinned to delegated
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 27ffda1c519e8..8e943e8cb202d 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -46,7 +46,7 @@ const char help_fmt[] =
 "See the top-of-file comment in .bpf.c for the design.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-B]\n"
 "       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -65,6 +65,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -B            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats interval, seconds (default 5)\n"
@@ -105,6 +106,7 @@ struct hier_prev {
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
+	u64 nr_enq_blocked;
 	u64 nr_inject_attempts;
 };
 
@@ -187,13 +189,15 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	}
 
 	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
-	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu\n",
+	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu\n",
 	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
 	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
 	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
+	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
 	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts));
 	prev->nr_reenq_cap = qa->nr_reenq_cap;
 	prev->nr_reenq_immed = qa->nr_reenq_immed;
+	prev->nr_enq_blocked = qa->nr_enq_blocked;
 	prev->nr_inject_attempts = qa->nr_inject_attempts;
 
 	printf("hier   : %-4s %10s %4s %6s %8s  %s\n",
@@ -256,7 +260,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIBF:C:i:R:J:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -318,6 +322,9 @@ int main(int argc, char **argv)
 			skel->rodata->always_enq_immed = true;
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
+		case 'B':
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
+			break;
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index c42f7ef74b894..7f4d3b33e6133 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -174,6 +174,7 @@ struct qmap_arena {
 	/* bpf -> userspace: stats */
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
+	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
 };
-- 
2.55.0

