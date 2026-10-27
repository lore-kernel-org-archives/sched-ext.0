Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793074582;
	b=3U+Jmzyc5ZhPX/ADA3ttr8qp9CeYMypHJChhbqtNAUcRUtlbxssiLR0DCjs5mycZlCVf
	 EEcVrwSuOGixyw0f4YtnWtCoOEa0K5G1CRe1ktdFS++KpQkksZqGQAn5YqyB6pEzBCQXP
	 Her8N7w/tgSn58hR0ApN8+C+N8MTsj7S7y1CLv937PUqwbQ5bxIEuOUBYwzq60Nbs1EXI
	 yIKF216JxZ88GTOuoash2zKsUryhAs5ssjVMZb5kGbTMrdMAiol/9JfuY3Aa2Hr97W8Y2
	 IOLASqZyVFb6R+74uqMY1IAFMHqLo3bkV8gTc0uKqz/7IWfeIfCFmm+XxYbr1Ti0wcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/1iY1iQ8LBa58Ut6EL0Wx7KFK+tmJtT3zTFQ8H+pj5U=;
	b=tGeQbgOhZLKyLdq3vTHKfxltnnqr4Fs4pATf2Vp1a0sMJ2O9HvYG/qeVeG/O9H8LweXL
	 p+C3f7yNeI5Dh530/Aj5SK7KrxXM4TqES4cTjeXZKMBz2890ilxhrAoCFoVPYwyuPX27n
	 YVYvqf39Q9Z596NVu5Nlp25U8WS6zneRvhU7FPX0up8Qd7Rl5A793dVIjUdEcwkbzIhpv
	 jLAk3peiO2G83V0ZkRh8wk3aH7QzaFnhJ7mHLMao0o7zLBcVhikIoHaza0BLtHruC0/hq
	 4HSpMlc9U0LESohPQyc4s9Gx9TWlGJI73EphNySPP3sVTO5BJo5ciXjhr5DzWUIiLMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fwQ9Ia21;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F45606A31E
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 04:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F45606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fwQ9Ia21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGdxPZiXoFuI0Bc1qXCqdUepCCn3qXC6GE5cEEZDlVFxh9Y02paTktoER55abd6GUAZveAs8EXfZyR/fIxFWh+cQdA5oOo9R4OgD8lK5L+IpgweFoMFecVyN/jqUD5sfe+JZtJ/BWrLrKTzc2/2BMGkb1CKhrJ/s89kZ/qlUIlmgsz5Fe9wtrf/RETS0Oc0gQj1TxlDdjK1CujuDR88w9CPfVxBuQ+vPDe6A2mKMTvoHkqxLCUlEBGckbriT9Zr0SqN2KdoE5TQjPGnZLU6C03uN3hEi5TgygB7Je0OWYlB09HFQ9M/VB/9UU6o0jShFIJ0Ol23vTABxmGlCpClhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1iY1iQ8LBa58Ut6EL0Wx7KFK+tmJtT3zTFQ8H+pj5U=;
 b=l7tmPzWl1oVdWCQdLCIFAboJ/g+ItoFJzZaBvCmGrICA0hoReawtEMsx9erO0rh5KrT/mxHdhhkC2QptRu7N6vkhEBX91kaAWSjPg2pUQGfIzkZF62weRiXmwR/zvwau3Lv9XFwsUyZ6WiZjV9yTM3QKIRYoayY8klT3+NmkP/E43GKgxNJBEFC0hEkU6XXAmkB8WoYH/JVmNUAYgg6/j2qU5chCKZNuLcDjUmtqZgtCQodkbbPFnlAjDvQsUDJzQUvungdtU0860bWNZpPBGv8Rj7XImxXh/cijn05hSD9pDb25lg2faHE+5G+Y43lFn3ra3DB/cDekZRfTj5c1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1iY1iQ8LBa58Ut6EL0Wx7KFK+tmJtT3zTFQ8H+pj5U=;
 b=fwQ9Ia21KNCNOUX6fY9b9zgV7pc9VIutBaMFXlUdt3F2f4Vu74mEy6GSx1FKtrch8C1AHoT7Mb4gHPXyVTfSKiWzcqU+++ylRQ5cZQxwWSEipeaunCMvJ0xzuoR8HkF8KL3/o2+ZYfg+tBG7Q63S92hMMjSs7XNpsqPQmXszKgd4+B/ERntBxGSotUfiCefsj2JUZIss68I+6y4PfN/426yzgwe+wPJSXKqR4C+bjjgHCt0huFxUJRENjc3/Phq5BxSCoArr/F7dhh9DQnjhTQXMkHXfoDfRMudRe7k1ImJP7oeoZQ/7IANShzfduotIYx53hsR4fnb3ml6y0nJBMQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY0PR12MB825472.namprd12.prod.outlook.com (2603:10b6:930:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:16:10 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:16:10 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
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
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>,
	David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] sched_ext: Report preferred NUMA nodes through ops.set_numa_node()
Date: Tue, 27 Oct 2026 05:13:33 +0100
Message-ID: <20261027041536.3317971-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027041536.3317971-1-arighi@nvidia.com>
References: <20261027041536.3317971-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:806:127::17) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY0PR12MB825472:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8e6cdd-1ab3-4192-b9c8-08df33e10827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261009223027099003|261021123027099003|261022113327099003|261022105027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	wWfYHVcIaP55VW8tFCaSQD3s5MwEwdQS4bgm/jHPPD6lYbNbpfNB4kJCWxVPTZgoxPa3Lg4S+r6199ILvhZNtNsnRNTpZSuH5fqjP05QUoR9AMbA1DfU4fze1hV1bs8+v6W1Egi5q31H+zO3xikDmbT95T+mI6KDMjg3OcLg564TX3WIjMPMUWDOiWTWEdr2brwY0L63ykNP5T6VvBMjHtikuBgDunZARB2ZFSqZlHFmCRPUgYpZwFFTalD8tccoar7SVS7tphNaICapIm6Ws/dFdnwq5rVlFwuw7zz8qI22ffaQBTPgZ2vtM53XMmBsKwvQ+g8FSP+sOOo1khcxVZBdp+9CaubI1xAfyNHtSRoDn8KnWf8hr6qkABaeuv4oiXkGPePQgEj7f5fGQ6GJarnVOq5y2TaAofKPyit8bznox6Rjuk3n7oXwPIIAIaQfm0k0TSDjkZiMGX3n5yo3iVA9jPYpOkBOsWfUBS84KQMPlyVNY2aVVGqlw0flQ1hxY9J9u6VfurLSeFT0GjSrFzdC4Q1FkuQVdXBE5ogXXfKagzXhkfLObNfNXGqnqW/VWuKKnPrOKIoEDpgRIT3pwPWUHIvSZjXOZd/KB0HxMlQQcLAXvectzYXIiiF78uvtTs/KxjlvMEHUe8L9v/VY/MyaBHOz7OIAYEKypMISF/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261021123027099003)(261022113327099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4+AsQO43im6ub5rbCZcvdtSfOxyTuG9VehExQ3yQPWQjjRpT7SapufhqkujL?=
 =?us-ascii?Q?JhHDy7MWM2rknfloXuPuoj2RthmoaUZnmwc+z2vf5hVwhPiWhnPso/5u1LSB?=
 =?us-ascii?Q?lgm95aaLc3070+l/kiXHN2ue19W3nxYD8vd/Fhwo9zQoVa/mErfVZiWB6yhG?=
 =?us-ascii?Q?gYxScwhtmHGQv2cFGk5rlv/9KzEbYuF6tBJ13LCD9Fp7hYKl+Rb/cf6QTeVC?=
 =?us-ascii?Q?/Id1QUlIrqZeTxyswEJyFLNpSghTFhKXgNnQna/ZEPy2fp0Xf9ghdXqbFD6v?=
 =?us-ascii?Q?aUdkYpSzZNFSpotIWi1icZtlDMxk1froAFexna9/0m6CtrTA+EGsje0rrfAv?=
 =?us-ascii?Q?gRYfVmYlACtyVRgqg/oL6vgU4rP1G45wzt0+sghR30+Z9hm8z3qkYH8P+in5?=
 =?us-ascii?Q?8BxySvoUrL8jN0vkCsBbCiCNaK5ZAMEv7hixcDbluAgmAmD+GpBZtMb1nIOS?=
 =?us-ascii?Q?XEsCxs4QunPn7qJFg+wVypaGxxy5QSFhnag0LjiaDI96Bz9SaxPBBnSvS/Yg?=
 =?us-ascii?Q?T02BML1QLqwcOqLs894hncc3YlFIl2o5idiXsTSCxV9V4hkhuL7bS24iT/6a?=
 =?us-ascii?Q?pkxTyBVV1iI6uRnUUjXSvuQoa8jh2PZKl2FctW5iDmvLaudrLvIZbn4Oh21V?=
 =?us-ascii?Q?R0vV8imdoVD8/+I/XwxMrg3vbZ+GJqlF2dn6aEUTOSr7F2Hgom8+Ys5jEFhi?=
 =?us-ascii?Q?RTxYkyTSVm050G6m5tgD10OjO/sAUPVyv4fgp+3yNiVzxeG9+g26cJ45qbD5?=
 =?us-ascii?Q?VgnAW+d9dqY06KXMDpwByUA4mQZITNFvsFcVFMCV9eM04LDpNkLmqUwGhRSw?=
 =?us-ascii?Q?IPfx5+MB4mBgABapbcplEbporsgs1JnSxGzcmbLqYOY9lscWkHJnHEYheSyW?=
 =?us-ascii?Q?+jXO245PqptVNdx02b6WqPxMtIRtdiLF7iHhPg+/ldyPJmzBbKDSJnZdDuG4?=
 =?us-ascii?Q?IAkdJjIlI2dbB4FcRS6NSr88lT0tIf8Lg8kVyT4mB0MXQfNs/5H1v5Sojk9P?=
 =?us-ascii?Q?omKkNvigUJBNUxV4HmEfS5ll427K1mQ3w/2xbA10pz+oTa/V4vq7GSqlAb0V?=
 =?us-ascii?Q?fEbZp5gbHfp5Boafl84JzEbmjq7nCfyfweO4eH8qPzfudhiWceRW7T92V3Xx?=
 =?us-ascii?Q?gN6pCksNJX00GseRXFc53T+t9r6PvM5EOUsz8Pq/M7+QpclXSX8JrWhPAM8z?=
 =?us-ascii?Q?6T3HOKKsmEx7MxB0jUtpyowjKwv0IWlhNCkZOyJ/COQLrPA11GpiIpzyTi2z?=
 =?us-ascii?Q?DpkRHAeTXlKAsceHVsSlYVC1cnJKy4r2Pj9KOf50Kl/EynP08zQxLJCD4VfE?=
 =?us-ascii?Q?Ocr0qLVwjMCjqveSVT7oKVe4WVc4JprvnOoBEVCDBJ3zcqds6xufeykZtpnh?=
 =?us-ascii?Q?K4HLcnZF5o9A8CMt8qQHbOSdpZ5alMpVHLKJHJAzWbWsA1/e7YKij5/Y74SQ?=
 =?us-ascii?Q?rKI9tJ6Vb3OMbZFfGbkXsrbpac6ehxyneQhibPDjeMWu1IhdrHlclpPO5yfR?=
 =?us-ascii?Q?ZMrMfdKQnfhPTMi/qDtSX6S8+5lAgIvsUGgyDZe/ZKzy2g2pqftiVTXO87PG?=
 =?us-ascii?Q?BUGBP8rb34TRqZwl6ySmz5aMKyOEOe1gefZJu9PrFkQQjg9uyxDKUZ3Eod/w?=
 =?us-ascii?Q?LS7FVW+PRLcY2U9PFGICmVCDUjohG6XfXzBma5gHPMWyjG+17oE4DtbYd0OH?=
 =?us-ascii?Q?p+nk4tX2fO+WPgTjWT+erbsAdDLkTC0/Y2Vw2xCF+mE982DT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8e6cdd-1ab3-4192-b9c8-08df33e10827
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:16:10.8302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ga3nb7jmsqFsqqnu+5uMB06i0Z/F8PllP6URj9oxwKc+mv/3XEMU/MrJIrgNOnA6IyfQ8UIxHWbt7GyP0l6lgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB825472

BPF schedulers need NUMA access information to place tasks close to
their memory, while retaining control over task placement. Deliver the
preferred node through ops.set_numa_node() so schedulers can update
their placement state when the preference changes instead of polling.

Report the current preference after ops.enable(), including
NUMA_NO_NODE when no preference is available. Notify subsequent changes
through sched_class->numa_node_changed(), which sched_setnuma() calls
under the task's rq lock, before re-enqueueing the task. Support both
CPU and CID schedulers. Kernels without NUMA balancing deliver only the
initial NUMA_NO_NODE notification.

Drive NUMA hinting-fault scans from the sched_ext tick when the callback
is implemented and global NUMA balancing is enabled. The faults maintain
NUMA statistics and can migrate accessed memory toward the accessing
CPU, while task placement remains the BPF scheduler's responsibility.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c      | 46 +++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/internal.h | 20 ++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2a2b56c6074c6..076e3757c0634 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4379,6 +4379,21 @@ static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 	else if (SCX_HAS_OP(sch, tick))
 		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 
+	/*
+	 * If requested by the scheduler, drive the NUMA hinting-fault scan as
+	 * task_tick_fair() does. Neither the scan nor the statistics it feeds
+	 * depend on the scheduling class. Where the task then runs is left to
+	 * that scheduler: NUMA balancing neither migrates a task it owns nor
+	 * picks one as a swap partner, see numa_migrate_preferred() and
+	 * task_numa_compare().
+	 *
+	 * The tick that only refreshes an already queued task does not scan,
+	 * matching the @queued check in task_tick_fair().
+	 */
+	if (!queued && SCX_HAS_OP(sch, set_numa_node) &&
+	    static_branch_unlikely(&sched_numa_balancing))
+		task_tick_numa(rq, donor);
+
 	if (!donor->scx.slice) {
 		/* the slice can't be trusted while bypassing */
 		if (READ_ONCE(donor->scx.lazy_resched) &&
@@ -4528,6 +4543,15 @@ static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
+
+	if (SCX_HAS_OP(sch, set_numa_node)) {
+		s32 nid = NUMA_NO_NODE;
+
+#ifdef CONFIG_NUMA_BALANCING
+		nid = p->numa_preferred_nid;
+#endif
+		SCX_CALL_OP_TASK(sch, set_numa_node, rq, p, nid);
+	}
 }
 
 void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
@@ -4834,6 +4858,20 @@ void sched_ext_dead(struct task_struct *p)
 	}
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+static void numa_node_changed_scx(struct rq *rq, struct task_struct *p, int nid)
+{
+	struct scx_sched *sch = scx_task_sched(p);
+
+	if (task_dead_and_done(p) ||
+	    scx_get_task_state(p) != SCX_TASK_ENABLED)
+		return;
+
+	if (SCX_HAS_OP(sch, set_numa_node))
+		SCX_CALL_OP_TASK(sch, set_numa_node, rq, p, nid);
+}
+#endif
+
 static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 			      const struct load_weight *lw)
 {
@@ -5745,6 +5783,10 @@ DEFINE_SCHED_CLASS(ext) = {
 
 	.update_curr		= update_curr_scx,
 
+#ifdef CONFIG_NUMA_BALANCING
+	.numa_node_changed	= numa_node_changed_scx,
+#endif
+
 #ifdef CONFIG_UCLAMP_TASK
 	.uclamp_enabled		= 1,
 #endif
@@ -9069,6 +9111,7 @@ static void sched_ext_ops__quiescent(struct task_struct *p, u64 deq_flags) {}
 static bool sched_ext_ops__yield(struct task_struct *from, struct task_struct *to__nullable) { return false; }
 static bool sched_ext_ops__core_sched_before(struct task_struct *a, struct task_struct *b) { return false; }
 static void sched_ext_ops__set_weight(struct task_struct *p, u32 weight) {}
+static void sched_ext_ops__set_numa_node(struct task_struct *p, s32 nid) {}
 static void sched_ext_ops__set_cpumask(struct task_struct *p, const struct cpumask *mask) {}
 static void sched_ext_ops__update_idle(s32 cpu, bool idle) {}
 static void sched_ext_ops__cpu_acquire(s32 cpu, struct scx_cpu_acquire_args *args) {}
@@ -9111,6 +9154,7 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.yield			= sched_ext_ops__yield,
 	.core_sched_before	= sched_ext_ops__core_sched_before,
 	.set_weight		= sched_ext_ops__set_weight,
+	.set_numa_node		= sched_ext_ops__set_numa_node,
 	.set_cpumask		= sched_ext_ops__set_cpumask,
 	.update_idle		= sched_ext_ops__update_idle,
 	.cpu_acquire		= sched_ext_ops__cpu_acquire,
@@ -9181,6 +9225,7 @@ static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
 	.yield			= sched_ext_ops__yield,
 	.core_sched_before	= sched_ext_ops__core_sched_before,
 	.set_weight		= sched_ext_ops__set_weight,
+	.set_numa_node		= sched_ext_ops__set_numa_node,
 	.set_cmask		= sched_ext_ops_cid__set_cmask,
 	.update_idle		= sched_ext_ops__update_idle,
 	.init_task		= sched_ext_ops__init_task,
@@ -12026,6 +12071,7 @@ static int __init scx_init(void)
 	CID_OFFSET_MATCH(yield, yield);
 	CID_OFFSET_MATCH(core_sched_before, core_sched_before);
 	CID_OFFSET_MATCH(set_weight, set_weight);
+	CID_OFFSET_MATCH(set_numa_node, set_numa_node);
 	CID_OFFSET_MATCH(update_idle, update_idle);
 	CID_OFFSET_MATCH(init_task, init_task);
 	CID_OFFSET_MATCH(exit_task, exit_task);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 80c746054ce7a..a5a8044d3c5a2 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -616,6 +616,25 @@ struct sched_ext_ops {
 	 */
 	void (*set_weight)(struct task_struct *p, u32 weight);
 
+	/**
+	 * @set_numa_node: Report a task's preferred NUMA node
+	 * @p: task whose preferred node is being reported
+	 * @nid: preferred node, or NUMA_NO_NODE if there is no preference
+	 *
+	 * Called after ops.enable() to report the current preference and when
+	 * the preference changes. The task's rq lock is held, and updates are
+	 * reported before the task is re-enqueued, if it is runnable.
+	 *
+	 * Implementing this op enables NUMA hinting-fault scans for the
+	 * scheduler's tasks when CONFIG_NUMA_BALANCING and kernel.numa_balancing
+	 * are enabled. The faults maintain NUMA statistics and the preferred
+	 * node, and can migrate accessed memory toward the accessing CPU.
+	 * Task placement remains the BPF scheduler's responsibility; @nid is
+	 * advisory. Without CONFIG_NUMA_BALANCING, only the initial
+	 * NUMA_NO_NODE notification is delivered.
+	 */
+	void (*set_numa_node)(struct task_struct *p, s32 nid);
+
 	/**
 	 * @set_cpumask: Set CPU affinity
 	 * @p: task to set CPU affinity for
@@ -1214,6 +1233,7 @@ struct sched_ext_ops_cid {
 	bool (*core_sched_before)(struct task_struct *a,
 				   struct task_struct *b);
 	void (*set_weight)(struct task_struct *p, u32 weight);
+	void (*set_numa_node)(struct task_struct *p, s32 nid);
 	void (*set_cmask)(struct task_struct *p,
 			   const struct scx_cmask *cmask__arena);
 	void (*update_idle)(s32 cid, bool idle);
-- 
2.56.0

