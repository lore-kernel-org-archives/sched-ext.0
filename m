Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97755435ABC
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615658; cv=fail; b=QXXluUY4Ra67d2ZqHI2gskSQZYR1sRHA2ovfzrrP+5jAky66qdhV+/qIPxiVDfEZpUwajWnNZyobvcBST8eHmvRxrUxq3sEpo+4yt9koUicXgL09ovBtp4KnWtICB26RvEnBMEMVKa3uea1HIQKVeUb1vmlXLepQauRnXjBHK78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615658; c=relaxed/simple;
	bh=GSO9DXjLtVlUhZlYjqT814kG3N3dNsfZ2E7RLov44/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YL3oHhJJC6+h4liI3yPfviv9AJJAPuy6A7nS8p1jBHWL9+V5dNOc/kXv6xO5sPPQhbUvqQ5xV6bzM5fnSN1QOgQsfzVGCZgzFK2rcXVkjcRY92pOtnfg9QVv3wp/flW5pqnbQKZW5y6McmnvwEBrkv6DCC7DthHp17GsERycs5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oLAT5JTq; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oLAT5JTq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vorucj+L9RsD7rSGf1yrUxFgS42qwL66/1evtjwdJHOsS/bRYRplyiT+h9xybdWcL9+PfxWK3glvmuLzBLdw5e5D5yek7KCsTljpiG2pwrcQEkyIR7RUyRUxs8Z0lreXWt0doFNxT2zbbDMBtjLaJG9byep4lCTcItLYQw9iyAvzLL0ecGyX1xDgBSPFebULXjIghPsdUOvGzjiOGVEfMDouvJWQk7md6s8rPufup+iIXKlcOGXH2Rfirf/3VJlVHnQOQlLA6fG4bHKc0aTPvu6rFrShqXvTWuKIx/ucYgus5TVV1zOapoW1CZ69vD+PmUQlkwSW+vH7m7umh0JgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV5LjLB0cc26tRZYebS8AkVlzSlAuotKpdBz5zD/0gk=;
 b=XdT9I9yUFjuUJ5JQHhtyYaeuJkQ8s4RYRk8otd3/2i8UTTDDIWWAbJQw7ZbqNnSzdxLj5oxeXOwAWLTVvAC5TGqrWLOmQ/N+42Rdu4eqyitX8B/W+6GTMB6D6zVMicqll125G2z+8Re1rqdktpRSM8b7544z9eTAh/FY0Q9C94foqMulV14lPD7kW03I8G6k5OAPl+s8ZIICvalop3oWVARxiEqwNzyQb5+vU83NTE+egEkkGePyCsKZfnvSISSl6bO02YncFTSKYBxIUmnSD4PtBONF+Ih6un0V6UdwhKrikcCBgrMgLzxLC0f385SOxnPE+EzWT3T/BIGsjnedjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV5LjLB0cc26tRZYebS8AkVlzSlAuotKpdBz5zD/0gk=;
 b=oLAT5JTqnbx0RZEXHjeo/X4O+WXnrj+ssLSZq+vap6ciBNFYgohEK2psqC2M+pej97obZu6FWLCcL3BHD+R8X6CX6gJgl4q1T18d1EnEgvrxzeUHKSqL62diA0DK8jj3DNUqUgg4MDN24ACVPzqqNuwi+WvVAzL7CeoBxW1pET8WydVg3mcx8KE7boO36+EHWPMcJCX/CNJKXjUKirsvrlnFWBEPs/CJUfZS/bUgSTxfWyTTu/WjkRSEPCwlBuELIZZZK5+LY36Q3YcxZKEB0sBs6gtJsjtIXOnJ10mLD7VHPeqRVMo2zdfDIOyVbobHF5FmeH4M1nmFMxkgJlv2eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:34:11 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:34:11 +0000
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
Subject: [PATCH 08/12] sched_ext: Handle blocked donor migration with proxy execution
Date: Tue, 21 Jul 2026 08:31:29 +0200
Message-ID: <20260721063242.552774-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: c0355b03-6ed7-41d0-0382-08dee6f2135e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Czk7c+VdQ2BagrWw4GlXCv4js/urdvcwK73Ce4utfKVxQZEpYMkOtxn+xfh1iJUCwkukmxlKxkbA6a23eIPd93JlWveDA0xrgfLadku+4Iq8KQ9ePhotZLeSp8omEVL7rOj63kwx7E+NgfoYJej4WqClYODwbHH4lTIILQArC/rg0Iovvs7jKRyGdJERINoGe4p9BCBjoNIN7ihJEc0R5ZHFNcMR3phq2jauCNdv+XMYZvv7Av77SX3SqmOn+yyDZsdkETxEwOyCFBnQqdiRsmXWkU3HBXonb4hPk64FFBuRHEec1tKYyh+tRuEQVuBO+ytBxjBvWdv+ePZ8Phv90NOOZEjCMuyyI+2yhbqvL7wcDzJ+xdE/+XtppMgyA7I4Pd6HZC4Gsak93/fpZolvStm19RrwvUqbAKlLF1nRYebatDf3PKV5OD/rBNWJyO+zrdgrmkhwgHd63l6DhfpFAVzO/LD5TMSO+Phklm6bu+F4X20F4a09kL/e9EMjApCgKDcvxL/vvMp4mtV+hL+baGPp6GZ7OZZvoH8J58H4cCsUXUhjZgJz6GpSr2RnGCYDlBv6HnDQ1n0jiZtO0Yy1xfMCXG8Huj61b0l7NGejLCfJ6sbozhW8dSjzdQcLE2bVqCj2rZSANj5gTQzNxTbHy/5dg1V3mTHy7n4gUvcD0KQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MjFL8MN58hcIhD6+QqryXqLQkhcRNYccIveQI3yomezUP+SBLrlZ5u0zmV0E?=
 =?us-ascii?Q?Xd49aBalfo7TZruhS93pmYBV9bk+20eyfzYIgfCwi+yy1h+mUHHIc77bgAj9?=
 =?us-ascii?Q?3ZFJErjYnLsJ7WSA2UlA0VwYCjLEXPaSTD1ljm+MzhPzqREr1h/NvF8LkkG1?=
 =?us-ascii?Q?E8wFGTRS0RCjl6ZamlV1NtodN9azW3jBQUOdK5EZuRJLT806r/tr/Jf7QWRh?=
 =?us-ascii?Q?3hpnNA4UHT6IgSiRoVT+d7qOWkOU7j4NrWQlq/94NWiTITmMQJyIs0P7W5Qp?=
 =?us-ascii?Q?AXWqUEFfkSj8hN38B7You2DiABbPk07hWOVeMiwVw6B2yqsVNHjC1SZXe9zT?=
 =?us-ascii?Q?I5PPYEBjA6SzyUw4IqBGlcUoNZ43zEQ2kGZ3omYEtTmKuGT1zi0V6ZNvJJnx?=
 =?us-ascii?Q?6FSmVzUUaSzZ2beKv0O82euODLZfhspj7C9h5QTZJYoYX04f3/W13tEmtc1k?=
 =?us-ascii?Q?biC0Zom/MNVKF8GN7HYaTnZGuSshauJqe6xJR0ed4psu7G84h4MT1GPozwkQ?=
 =?us-ascii?Q?QnGwedzX964nhOti9+gQISZPijYIITc2pEs4PHVCYbyXj5bfWb624u/XXdx2?=
 =?us-ascii?Q?rK/xymN6p1re+86eHNYjVR38PapthE4t3psOszwkspJusG2bCOi2hYXmDvGL?=
 =?us-ascii?Q?+0KuUCbImWTJwX8+kEeqvTM8SpQ1CIo6YqnCNyo4qbMwJ9FijAHHFCDxbMYS?=
 =?us-ascii?Q?B/6a2ZLKkiRlAf8Tj0DPp2dYLkEn+bf/FmR18Q7G0k9DoLN4/jtciI//3G6b?=
 =?us-ascii?Q?vNRqs/JhLsaZQDyeND4aTR+tBHKWPrEZjYn9NxK5fdHnRFt6x2p0nsOdYwJ6?=
 =?us-ascii?Q?7TPH+4PEas8ItRGGM4GZKP+SVy9sAa1vd5Mgt9A9bZdx3UMo3Rs6ybTk6lS8?=
 =?us-ascii?Q?sE1F17Ge14IwH7qYoWHOBbYo8lNrzhaZ3pO9TlmDm5pSD01zVNUBp0hkSYmU?=
 =?us-ascii?Q?k+Gi1SOj1FSoALKWZRkKLEYrVGQbROghrNs9F0N8kZ2yHHx2E6WRbu5UYJ3x?=
 =?us-ascii?Q?it9kk+Rw+TyxY1BGrTdB3Ca7+JVHax8tbh08Y9H2ZT+4uHv5/SrxP2QW3vjV?=
 =?us-ascii?Q?sfw3lZpV176tsPIktU26ZzLENof9GoPFC9T6NbKWSVcyWGYpjB6JT1pNvA3g?=
 =?us-ascii?Q?bAD1H1EZNQY0jXFqt2UE2Pf8N+78jUkoYpqik5XBzEU+sqOm8vw+1IXj1gG1?=
 =?us-ascii?Q?QnMO01JpdKnWMvIebaz/wD6Y7m++Zao6MSQjrC3jTf4hnFS/SkrS+iIfpVxp?=
 =?us-ascii?Q?jpjQPmliabyMv2G0gJnsy8SesQ1cT7xCnRGWLiDFAuGrKMxkmA5pHnhPNOOB?=
 =?us-ascii?Q?B1zr6rJk9vj2RCFnVJPNAq4AiRAz4DKZWwaUmt20Tg93eKSB/EYjDlpb1Usd?=
 =?us-ascii?Q?s1XPLbpYMWwbG/rlng00wGpUjscYxw813fvBe9oZtveuNXuYHkSdrkQcFUgy?=
 =?us-ascii?Q?AgCXsa78wB1Ocx0aPfUT/vzPItro/wB7RKvfnWm6wfh9zq9oV4Nk+Nht6NOj?=
 =?us-ascii?Q?gYYV7KRjUZYBETyJXw8veaqy/jMnzUcxgrmKmgnxJ5/27UfspSbe7KLo6w/5?=
 =?us-ascii?Q?9RG2sVxS6KwaLCfSYp6boP70J5xPfVDTS65jRwg977WI+Gk9GAIT890vj5Vp?=
 =?us-ascii?Q?uOUqJW/qAZTCczrwQ03qfuEXiFMJ9dt4FUMfYglcaGPPGeqNuiQjRiRvycU4?=
 =?us-ascii?Q?WDPWY3xV8WuD0sgqjCUT+SwAdcARxv9fSU8gnAA61Ik+xXRpjLqZKfia3mbe?=
 =?us-ascii?Q?s5If7KrNhA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0355b03-6ed7-41d0-0382-08dee6f2135e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:34:11.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+Ci8IMj+BqQLjFgTVMu44kt2ihgpVsiWorBSOJZhQIMZj8N99pReNUByMwQHTLNfzQbAsW0GJ9YIAu7SIvZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

From: John Stultz <jstultz@google.com>

With proxy execution enabled, mutex-blocked donors stay runnable so
their scheduling context can execute the lock owner.

sched_ext may normally relocate a queued blocked donor: set_task_cpu()
updates both task_cpu() and wake_cpu, making the destination rq the
donor's new callback home. This remains valid if the donor was
previously proxy-migrated: the BPF scheduler is intentionally selecting
a new return destination, which the next proxy migration will preserve.
The usual migration-disabled, affinity, and rq-online checks apply.

An active donor cannot be moved normally because the source rq still
references it through rq->donor for scheduling-class operations and
runtime accounting. Moving it would associate the task with a different
rq while leaving those source-rq references in place. The core proxy
migration path avoids this by switching the rq donor to idle before
moving the scheduling context.

Check active-donor state in task_can_move_from_locked_rq(), where the
source rq is held and the result is authoritative. Keep it out of the
preliminary lockless DSQ filter, so a donor transition during the
rq-lock handoff is resolved by the locked recheck rather than consuming
a dispatch kick and skipping the task.

Allow normal sched_ext migration of blocked donors unless the donor is
active on its rq. In that case, defer migration until it is switched out
or leave it to the proxy machinery.

Keep blocked donors on the local DSQ so they remain visible to the proxy
pick path. This is a temporary solution: in a later commit, proxy donor
admission will be delegated to the BPF scheduler and donors will instead
be routed through ops.enqueue().

Signed-off-by: John Stultz <jstultz@google.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>

 interactive rebase in progress; onto c0414e1387386
---
 kernel/sched/ext/ext.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index a466adf8e1548..bf53f2be77f05 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2455,6 +2455,10 @@ static bool task_can_move_from_locked_rq(struct task_struct *p)
 	if (task_on_cpu(src_rq, p))
 		return false;
 
+	/* Don't move the current scheduling context off its source rq. */
+	if (task_current_donor(src_rq, p))
+		return false;
+
 	return !is_migration_disabled(p);
 }
 
@@ -3122,6 +3126,25 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/*
+		 * Mutex-blocked donors stay queued on the runqueue under proxy
+		 * execution, but the donor never runs as itself, proxy-exec
+		 * walks the blocked_on chain on the next __schedule() and runs
+		 * the lock owner in its place.
+		 *
+		 * Put the donor on the local DSQ directly so pick_next_task()
+		 * can still see it. find_proxy_task() will either run the chain
+		 * owner or deactivate the donor so the wakeup path can return it
+		 * and let BPF make a new dispatch decision once it is unblocked.
+		 *
+		 * This is preparatory code: a later patch will delegate blocked-donor
+		 * admission to the BPF scheduler.
+		 */
+		if (p->is_blocked) {
+			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
-- 
2.55.0

