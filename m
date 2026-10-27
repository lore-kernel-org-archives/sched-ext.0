Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793074580;
	b=o2e2BGzy5xarAF8zHZnvi0o/jUw4CEoKujv1nFL6WO2NSej3d2f+j5v4jhDSBilSR/Sc
	 lNrM9Z70/qPUPZMqkMYExH//32aIFd+f20PpQKF6zKLWOPN+c+rGHzoeoHufxXYbNTO4w
	 satpaj5jkt/FQLwccamoW/vftSiBIw53L1qCIdBJlbSqVibvLXYs/MkcyqfONIVo3Swog
	 9UeS1ZmDGhuk46a5Cf1NuNdGU9Hdz5Z5sDWX70PqCdtXeu6/NSjbTPoBOcB9OP8YOVPlz
	 DLhrvPUGpRz8CqizPBSc4r4KO0D/MNQRPXnFLhcZW7HhGlHrTl6ec+hhb3wyqEur5uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074580;
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
	bh=b2xk2wiXIJlJDeF5UoJ+0Vf9CorL8Uxq96F9wHfaDyI=;
	b=ddjISxz9OqBzlktdJrlY7l7lUTRYd8V/0MB6hB5Va8usE+0u2Npkuiff9fyApSwWQ8ec
	 2bgqWpRcZu3vyt2loI6ifHfnGZj/5olc4rZ/xf0UylavsbTz5fdeA2FhIZaYMuuy5CEAg
	 1AKko4Khp9wMpBvdbIbD3eoPDraeopSNZApEuqP22+TpvdCSG3jU2N9apLoF2CTuoC/WI
	 4eoLrPvFRyIkmuxZeh2mhFwM8euPRos7oifwADFRph5bgL1zrRBN49LHVf/eeEMm2AuW4
	 f1g9qsfByE4pIHIrIZKIhmx/lAHgDT2P2zqdopeOfVlw430ol9ReraySHdky3M7WStg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZUygLaN0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAA606A327
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 04:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ACAA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZUygLaN0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcohdML7yizgufoMDhqE9lw+qhM978svlGDlyY2AIWZI+F4eitAfsDmz2KIy5iks2ozeADX+5GbXR3MjojgeTqrFnMe/fDGOiNquUugNWpPTcnQFKpHm6BNEonl0zcb3mzKGKwZ9yDumkIpxsJ0qWZ2aEF2jH7Z/pAF4Ssvs/PqYqnked4P8PADHbxgdORTiTGSVLsbZxU+X9CRV2Wi05hY9UyQ5mgwyp5p8O3uudJg+52pEqsoY65I2RFx5M6KbpqmAjZSe4X/P2ML99QmkzL4bbLvN1tzCG9oBQuV7ZQyAvEzXL5L6TPrzy+zjtdfN81BTnOwJtBGuqMaLajEB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2xk2wiXIJlJDeF5UoJ+0Vf9CorL8Uxq96F9wHfaDyI=;
 b=YJzYqJpOhNbdUOJgWmprrsLw7fDUVDDw8FadFydD5Y8Hiv3qb/9VwB7HWftsbjlO/ujdbnmgl4eOx5L1OuxL6MpcYotMjDfg7UfQ7CvIaoX/eM58Irqqqvd056KNkOZ1Qdtj6OZ/vLYrbj5rutTKUChS1nB5UqQQvXyb27nNuvlaf6uNygm9TB79nJtaRw4fcdfAZW+EkG/cfBbrNVS1mxdJeXZVqHpYGIrlB9YiRa4DXIFvSHFtZ9de1wIwVSelXMFsvnCEY/AkHYwl7Hi/h+1TQCvKhUizM94pnFsAq9IDTzhJDHFi7axWFTQXpz0bRgTtTSi1C89rD1z3NKOiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2xk2wiXIJlJDeF5UoJ+0Vf9CorL8Uxq96F9wHfaDyI=;
 b=ZUygLaN08F/I8KjAfb0icT2LoZrWAYjrNIpHYPDJwcisxP4G+gJcLUrVc92CeMsTDCVJhZ/pryC1oHwHptmYJljX0rn5KFpaAsHSwDjRz/qTLVNM1cfwuqokqhBkUKmp0wFjpULbymlMDWtt8Hs1KCWbivo4ttH41n3GqUoAuM/VfcNY19Q9EfhTGjDK7GPWyEh8G9z6G7TYG1SunT7mSmDd5l3epgrVn54TaxnKo5DXoVorCPxCWBtTyNVUtF7etw271AQxP3C1N9A02mZdNHVVdSl5H47VpPgelYuzQlLTiVoS7j8ffGoxglDmtxk8zuivOrv4P3tU8n+bVnPJeA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY0PR12MB825472.namprd12.prod.outlook.com (2603:10b6:930:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:15:50 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:15:50 +0000
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
Subject: [PATCH 1/6] sched/numa: Let other scheduling classes drive NUMA scanning
Date: Tue, 27 Oct 2026 05:13:30 +0100
Message-ID: <20261027041536.3317971-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027041536.3317971-1-arighi@nvidia.com>
References: <20261027041536.3317971-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:223::17) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: efb5cbe4-5e32-436f-1aaa-08df33e0fc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|5023799004|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Ch4b5GExotuuC4mmccCmenIPMz6m1W+KvKgZFhRNko9xDa7eXWrV3LSb++ZqLwzdO/GnQUVKUk1x0C8cJtSOdYinBEvGqxMiVqpeyHftEc5KzyNBz/attuKhJ7SsikodNfqsR7KLfflY9xNmMv75jnRBIkt3YK8FzgMaqGhWe/F2GQJsJ+reC0BhlLpONpeGsjyM/CgLvoywKnUSDLEomKD4rkXKjlwxJtHCpqscA4vAczRoPmg175VVTriaf60h3XJ9H3SGz9bvv4b3Kz28jlpLEbIPb7phWV+AT+1+5z4K2SRxSls+HZhiYli9ULC5QjJJ5/qtVCu0RxjUXAMBgr6A0wIuZ54xDIhvCQ1P/Bh2r61l3jI84QajwBxzjgx6FDu9YwFxxyh2uzBMys5dRyXrxyQ9YPwfwqYLt1JOVPQB4Y3UPmOFR8bVe/FroGkzeWGUdyDIiBMo35+3aGHUPfuqjqVtKno+pPueqgO6rhwiJQ6v3Z5HKPN/3UaYUA+/Tg3PvhCgLQpF3EyD1QlXqZEQafnvILEdZMcG6oeeuIo/1Ablc/LUoRNtYovOJTLOy/E00TuKtNiCOlHiEraqajDErmcqfl0YkDlfUnt5KZ44XCUd0l/uxrspDcw49+l2wfR6iUBkcAxNmLfVwusckgZ1uLnX5gcV4F+lbEnmjkQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(5023799004)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BihXLoFPQW+8tEGIbUm8lP9CvhEoNlHHSRIfYYuipSJQn2uKLzYVhLccpzmA?=
 =?us-ascii?Q?TSaOac2UboOGSLStlTvPhgon6JjKoSBwGc+Um9orQcS6LpNlcvcIwhYGT/q2?=
 =?us-ascii?Q?JXscek8j6/gQOm1hA2uZ/OeUeTl9SJxIJzFdn1Z5zoKUUY6qQVswJ1uO+y5W?=
 =?us-ascii?Q?QpasRuH4BSwn3G4mtt5c5meYURYG3LID4TCUbEh9JEXbfTeTkUDU8nzsTj0r?=
 =?us-ascii?Q?wv+Jn4GQ53U67wAaacgE6RU002XySAJF5pIFWLQ7WiH/dUZXAI4TLvYcjmf6?=
 =?us-ascii?Q?w4PLmVsJFO01Q8NWiODx47aTPukmjpuUdaoxFWT7bLkMYOhR+i6RfzhMS3Qn?=
 =?us-ascii?Q?YBsfQjyqeLxtm6bfaIgXSuEWpTAcHqpQXU3930KkZ5UP8v/1cUd9jthD8NjQ?=
 =?us-ascii?Q?vhwjgyvWhehydSFtnN9xsbR7n6Z3oZDpTC/U4P/2j1z/0flNusEjzFDvodDC?=
 =?us-ascii?Q?Tu524m5rMjpqo9jeXGVseAsIUF0zMEgYKu6Eh2THfA/fH3cpWWGz81TcXoMR?=
 =?us-ascii?Q?CqXvouIhQzJzwOy/qFirvkZ/fnAnMqu5g1wi12joZoxEaQgdO9Vz5lm6mcbO?=
 =?us-ascii?Q?Vc6M4zsnLRb9oWO2vJATMsyWTL3kSXORcotwPNru0H3BauBtqhhQkZzENxDi?=
 =?us-ascii?Q?AJAJMDJ1LDyU/TAvA3z9iQVqZtYvWcm5Hde1oMjKO19VEiPIXvELrsyo94Zb?=
 =?us-ascii?Q?/nhRM0afseP0d6RXiw15CpcNxUdJBc/GarsFmvtJn4fi+wVNcZAaG5hjtC77?=
 =?us-ascii?Q?DSFDxsjc4Vba6jsm0RgnY/VQdHRmm1/WfS1AL5m7bGEg4Z8YzX1ixjxYPGxf?=
 =?us-ascii?Q?9RCyPCCPxkpIICFup4JIlPBIyrUA+CkdYaXaYW7caQsSafqvpOJ3FlIptBJU?=
 =?us-ascii?Q?i3aGtinegoe/TW9Ln64ulgYUz5ovAHdDIlOf5O+Br1hrFUfnxYr9tdlEh9Vl?=
 =?us-ascii?Q?EKEgoTJB4U3sqCpHattkAoiRPJpPXScV6tBnROPOnF+o/TV3qRziET3koTfC?=
 =?us-ascii?Q?+VI0ZNjS1RGvj/MRibU194LG69XycTjc1omgDB8aGVM0EPzzhjEIPO9qBKe5?=
 =?us-ascii?Q?0MH+PsUC53hvBLjtQWLJRm589fKgLUaTTbTj9UodlXZ2kEnBOBjEKQblHNW0?=
 =?us-ascii?Q?aF4tvtszI48xtjBOd1T34cw43DLQqWVv+8zldNlCpCVvqqNN5c2Ld5dpfEi7?=
 =?us-ascii?Q?VpQ5M4TM8mx6lytiRCdu4IaaSpCfKu4SpWYODwPuVgcF6IcfP7mjpyUilJmW?=
 =?us-ascii?Q?4c2XJd0fHiTRIs0iFvBCH9QpSg2mElikl89TTFj6ijZMGXY8nEVMYnse+uoC?=
 =?us-ascii?Q?HhxRkMnELLk3bTSBdYqD1R/Hp3HB8Pzarylqm83xMjNAOFWI9g+gEByfxXNC?=
 =?us-ascii?Q?7vn5MRMiR+pUMKmo2R7Jn63JWytXZx4ihrvRin89B4fvcB6gav3Ehf24xcwB?=
 =?us-ascii?Q?PS6pidFpNYbx4btncafzbOWWPXHVy5sxwM5qccX8CCbUpE6YxFuPAAXcTTA5?=
 =?us-ascii?Q?coaGh/fWZInBQsnRcaDWH1RlmYzjJTRDRDH1c6yIEaihintf95UsOJ1FzQqa?=
 =?us-ascii?Q?eITviBZwhjDIV7x5/zEfLfCQAdGzi9ES7TwWoGjys0v8C2UccgYKNeE8mb3K?=
 =?us-ascii?Q?dikZIZrwS/rlRCVR2yVnnMEosNjrmfxhXvP9YQCrUQnVJXtDrWX+LpZyZh7M?=
 =?us-ascii?Q?UN9lhdISvXbJMzjn2BEFL1NCmXCpDJDV8ggyq6P5NIBZS3g1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb5cbe4-5e32-436f-1aaa-08df33e0fc21
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:15:50.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEuaPUqoomiV653tOuS2z1NnWnitTY8V0K0269nvYkgL2IvTlOwKQqbTAvu59OZ7QGNF89JPPWbqZEFeBgL0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB825472

The periodic scan that installs the NUMA hinting faults is driven by
task_tick_numa(), which is reachable only from task_tick_fair(). What
the scan feeds is class independent, but a task that is not in the fair
class is never scanned, records no faults and never gets a preferred
node.

Make task_tick_numa() available to the other scheduling classes (e.g.,
sched_ext). Declare it in sched.h and move the !CONFIG_NUMA_BALANCING
stub there, so a class that has no interest in NUMA balancing keeps
costing nothing.

No functional change: task_tick_fair() remains the only caller.

Reported-by: Vladimir Vdovin <deliran@verdict.gg>
Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/fair.c  | 6 +-----
 kernel/sched/sched.h | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0e279a7768754..36df9a4dde534 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4636,7 +4636,7 @@ void init_numa_balancing(u64 clone_flags, struct task_struct *p)
 /*
  * Drive the periodic memory faults..
  */
-static void task_tick_numa(struct rq *rq, struct task_struct *curr)
+void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
 	struct callback_head *work = &curr->numa_work;
 	u64 period, now;
@@ -4702,10 +4702,6 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 
 #else /* !CONFIG_NUMA_BALANCING: */
 
-static void task_tick_numa(struct rq *rq, struct task_struct *curr)
-{
-}
-
 static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p)
 {
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9e7993256c817..2b05c41e66e29 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2151,6 +2151,7 @@ extern int migrate_task_to(struct task_struct *p, int cpu);
 extern int migrate_swap(struct task_struct *p, struct task_struct *t,
 			int cpu, int scpu);
 extern void init_numa_balancing(u64 clone_flags, struct task_struct *p);
+extern void task_tick_numa(struct rq *rq, struct task_struct *curr);
 
 #else /* !CONFIG_NUMA_BALANCING: */
 
@@ -2159,6 +2160,10 @@ init_numa_balancing(u64 clone_flags, struct task_struct *p)
 {
 }
 
+static inline void task_tick_numa(struct rq *rq, struct task_struct *curr)
+{
+}
+
 #endif /* !CONFIG_NUMA_BALANCING */
 
 int task_llc(const struct task_struct *p);
-- 
2.56.0

