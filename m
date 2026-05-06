Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11434C0425
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089647; cv=fail; b=cOwFeUxcqP43/Jzp0aF7fKrxPObke4tayYC6cdN4tfVVLMHJRBIyEOYFNBuJxX0a59gK6qIpb9gVo00CIdKSR8sa/XGqTST/s29bowRSk04A5XezZSvDLhxBory+Or0KNHCAybDv8irkk9MZIx0nbYltjOJq99ZPNjP1pCyRCyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089647; c=relaxed/simple;
	bh=6b+2UbHTN/YY0UEJ+rsmSMfSUWBfB1A4zywKFchUP5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O2+fmQ2/yZ7NTGw6hecPmPtBptzJlaez//dV44lIC2PKD/CrDwyo69qwSxYQg74lyt+v0yjlY6L8mkKB9fshyvVkY0E0LEG2uQB/HEEzGQ4kfVsOgMJHV3E7nJN0pUsu20dQuyACGHHJXzkkfdvnS3jtsflN4oDVri6C58+F63Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Io+w+ylN; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Io+w+ylN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4MGiSLVR5Z2ojZ93xWUUIQ4/wAVdKKh7/gvZvThXP3BOlWQsElE1C3TvsuOdMKYtFgDXN/VQhie6KsIAPin12mPWh2ENo3tf5ET1RNDXZtDecCYfWdQfcQBcqvIqjdtKgq3fJiNc5TG7J510IuMWxgRvASHsk5xmbyF0xHE9KFgrJFNWed0VebzTRK6HsQVi9E/peQhQbjNzPXn/Eb5wTwgyY6LAFUpAK1QgEred3VbJHDRqHtbVYHWFQajSL6lxXdDmrmu0gRQBXnZyjYnijUL6+NkixMk4kb2bfE/e6MDB/o4lW1GsRDF1Vdic/E8jS5IdWvN1umaFovLNtGinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NXtTKcdOk1OrTeX6i1+jHoSU/KZMIxSuL5cuNa2cec=;
 b=EvSvXyz9GI0fPDp/3rP2n6E4p6wokYS4tbPKj8hHit1lEM4QL036hDafk2V70kceN07Q+RLXNxSDWaK7yzMG844m5us6EoatJO1Fbc0PGuEpJBM4A5ixLbvgkwLDgyjHfi0M5cZS1EmYWoqpklpjNdvUDn60bJV7K1Fhxh+BZxAnVJWQza4Rn5KkMXIjsFvjDBBEbSGAi27G+IGf6mstHOM2K1YrbyBHG6w6fDFEZZ8DSc9XgEZNKDuff2JPDTHgtlPxw89GtbXf/Bg3wgb1aDHWuTVlzR3L9atsvUkFwhnDlrTL6lGhd2MYrI8fdzch66uUVSgPRGKNXWLrPRnKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NXtTKcdOk1OrTeX6i1+jHoSU/KZMIxSuL5cuNa2cec=;
 b=Io+w+ylNWJWGIT9Rbt5cmAajtR9f9R6cUF0dgc3lPf59+Pw3CbVPTvALonnb7S21v0xJbFycabKQWCELxL29BtqcCQ/NaTInAMDr6bEgazJQcJR6MKV93IJsmpbBiDVS86pAzj+Nj9skmv3MBqTa3ndbOvmr7zGsen0qkwfvkEeDjmQe5kGfsaWRhmHzeM75tG73qxlyEmi3cZ6/hYyNni64rKJbNC4l+CYsL7F3RKJNm8TgysK2Ps0QPOSzQXCGf1V87aRSeT3gTvFTVOV86HryC/7Le5gHjhan5itgIGrvkweqnL3lFqWuhEt5halGy3zI2eqp4rjkWygxMHSXYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 17:47:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:47:11 +0000
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
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] sched_ext: Fix TOCTOU race in consume_remote_task()
Date: Wed,  6 May 2026 19:45:45 +0200
Message-ID: <20260506174639.535232-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44c) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffd3d22-998e-4946-f7ca-08deab978056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZyxQqdGJTgQreLcFKvqVzG/ffZVnzDREM2h8ltS4t2Ax9DSuw2pFFBiqnKyTVWk4kDkBY2bNIxipxL9pw/lhNbz0Ovlww1WdPhiXOWpqiMM48ah+PIJC3PKLjb4laOYDoIyCXZKZNAhUMt3eA16MJbD2UCSKNJA3cg4n44kS56RnqAbnyRp68fUOo2aAKgHZ+QyTtFGdiEw/OujjfPLrRZk6PrtOy33A3I+A/UYhP24GHIWfzCoF0TEV9ibIVUjF8k9iHoCcsHKwg0j+XBmSYV/v239q+k5ZWAPvdzN24rnuytV/sy9HapECpFfI+Avp3xKh09E0bxN/pWYY0HmmradgRgohDZG0Mkv96PWyvvHA9RXwqTb/2CnFY5SErYvzg/S5m7MnFrGFyUltjbFuB1cspY4jGqMug39faLKwSt8kCVElZrN+qCcXo5Dq4JKOzKkAkdiPzAcYubpXoEX8JrS6J3VUGbZPz5xRHBDnMQq7BvA7THtLCRsu2/Wn4J2rUvylKuDv7BUFobAmcE1cIqIslObT6+MBOMoI0b5ldffUw3xKFa3PC4xFBuIzYfsnV8o34x1t9EqRX0bjKKyM55s1r1GhhaAUhnNZu1oN2Q+8o5IHgUeHVujajCva6ZsrvAvpl7v3uLMR2wzU1pLiszpmkrx2FE8jBV7420t3rasc05eSwA7t9ZdZLa91oDxZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JjXApO0KWQMgx4ShsT62nQA6XTYUddWcKn5USpAdK33jqABfwMgn7MigbV+d?=
 =?us-ascii?Q?3PsxWK3uhFV6uu+eLZk4v9xGkXkeNGJwpBf9HZPaKhM4RpwxR2cp5AwkHBBO?=
 =?us-ascii?Q?Ug6Zlc14bPtkUP4nMAPdCPQc1tQP56B0lmbjsQQNO4T3G65/CLf7pfkvXmlo?=
 =?us-ascii?Q?IhSApxcQN4ncPXmPjBIJTLnMmeOsFxCO0WghJbu01/5EfLCyy8dlsVsxl7u+?=
 =?us-ascii?Q?xGhYVUCrrR5XsiUdbBwX29f6MQmQ3snv/ey3fqUv2xky7CSNQzlK4B8QcFzF?=
 =?us-ascii?Q?Iy4/xNiFNewrzMBEbKXJ64oukCiSLnkd7PrFsl5e+tBWCpeKPlhU87SsSdfe?=
 =?us-ascii?Q?n8PlV1or1njOLJ2Rh6Z8ypeNypNjThAISQwd9KcUrDjCHXn7JhSnxxqX5I+a?=
 =?us-ascii?Q?iwI8PNPuMh26RB3/LGC+hCW2eCyTY2kAqcoA6oaCTw7nQCKd6T3VAUPkRMRC?=
 =?us-ascii?Q?f+fEcim348k8MvrpUQDfAN1ELGISFd3TFLMKZxFS4HkFPpFkK5pnbdzfsw35?=
 =?us-ascii?Q?XDEPb22PfZuZFY7rEE2JlTKyuC8UaYchAw80l92yZGwKK0GYYyKc+Yt9OwNA?=
 =?us-ascii?Q?9IHSf9OTGaPMvto8w5vvFxPmvOztshVZqQv7U/3Wuv2jOz4+sD8vVJZZAGJu?=
 =?us-ascii?Q?SEw8oHWrl5Pisu/woo9UA6Cz/mtxECGerXQk+PFCmbxud2rdzRrPbPsJsWfV?=
 =?us-ascii?Q?gteFVXwAR/JJa+FMKe67ITJgJre10yijV6HFb2LE2vuzISXdr7Wy+3h3EVKK?=
 =?us-ascii?Q?3hzFTum+ljdD0HsyBr6l8DgsiS/Q5gY9EJp4Od0Kszq4HV9B4zAvSEqDOSYv?=
 =?us-ascii?Q?hMi5iXbRgSW5Ihuo+qJXSI8hf9fFK2Hcb+7frROc/JuTHtm7uhITXWbmpr4x?=
 =?us-ascii?Q?8RhJO8JECmyJXdrrRt/YGCLsAwF+E9vjcmwyWVfVgCMFvisgVjHC7jIDzlqh?=
 =?us-ascii?Q?8UCQjOqf2BYIu1FFmR4v49N3zh+V9don7xN+1qHgDjm+/Kqs4OhpvlbxXsqB?=
 =?us-ascii?Q?AqenVG5i5ceVCGEYL5Gumxt1/4+pouyICYHvpOl/4gXJXLkAtXYjo2ygAwzG?=
 =?us-ascii?Q?/b22YM/FU8rK7KS/AQ9F1HAY6FDW4BIOiQ2GaZvgsADGq+iRxNkQOl2O5DNi?=
 =?us-ascii?Q?n22SCtemkqd0lsNETp/TPW+EBZFcxZGlqvMPoycqqeNCS/ow34eUj5w8rwZE?=
 =?us-ascii?Q?m+/oWEO8lrtQltarTnoRHC3loXUgn22N+RpkTpb5WS0UrBug7k0Dg31XOQgM?=
 =?us-ascii?Q?HDxoLZXEj7+BljIH/4FLATDvd9ZuECGwpxjkST4+Xa37F3gU2VTxnuLbN4XG?=
 =?us-ascii?Q?lD3sg0wI8sZdwWiEkuL0DZ7FfYIW8xEE1d9ugCNhuOTeOt+9twBgaCIgiqdx?=
 =?us-ascii?Q?80n+31oiNAgj8pseMzi95R8m2hj8WtM0B3z7oJvnj6DxYBLm2tMmKofQBnMo?=
 =?us-ascii?Q?KeEVVOjvmKmR6gmZuOThJ1DIdkf2PGSDOGKpUeX7KbpD9JI2UR45ZMKIgjj8?=
 =?us-ascii?Q?U5XwP15gNB3W02fCQTEc9xkdZjEJTva93GMt2J/rbGVW07KMdbdjYeM4ClJp?=
 =?us-ascii?Q?Zkb+DvmQqVLRBut/0rEXzFZ0hoFiAZKv5RfTYLJv6UXvRBqnPMPHdVTxSfmV?=
 =?us-ascii?Q?RXM9705PKX6+SZ1KcAH6k4UgwV9t6WvzH+9+DsKtDgGHk8/GBNrYQeZa6Q8v?=
 =?us-ascii?Q?ypRRQxeXkHJWSFIMLqM+5jfIZcm/8T5v9waQRHN1Whj+wn/G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffd3d22-998e-4946-f7ca-08deab978056
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:47:11.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvyWdi3TPf/iiE6B8qyFIhy/UWZ9nzq8NTwMdknwZbmdxtr2JQT+9AcchVJ/Hhe1SFovp3w/Md8iYg2VDBW/rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

When pulling a task from a non-local DSQ, consume_dispatch_q() checks if
the task can run on the destination rq via task_can_run_on_remote_rq().
However, it then drops the destination rq lock and locks the source rq
in consume_remote_task() -> unlink_dsq_and_lock_src_rq(). During this
window, the task might have become migration disabled, making it invalid
to migrate it to the destination rq.

Fix this by re-evaluating task_can_run_on_remote_rq() in
consume_remote_task() after the source rq is locked. If the task can no
longer be migrated, we clear its DSQ association, reset the holding CPU,
and enqueue it to the source rq's local DSQ instead.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d64b1283fa851..a70f8693b906f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2418,13 +2418,24 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 		!WARN_ON_ONCE(src_rq != task_rq(p));
 }
 
-static bool consume_remote_task(struct rq *this_rq,
+static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct task_struct *p, u64 enq_flags,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	raw_spin_rq_unlock(this_rq);
 
 	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
+		if (unlikely(!task_can_run_on_remote_rq(sch, p, this_rq, true))) {
+			p->scx.dsq = NULL;
+			p->scx.holding_cpu = -1;
+			dispatch_enqueue(sch, src_rq, &src_rq->scx.local_dsq, p,
+					 enq_flags | SCX_ENQ_CLEAR_OPSS);
+			if (sched_class_above(p->sched_class, src_rq->donor->sched_class))
+				resched_curr(src_rq);
+			raw_spin_rq_unlock(src_rq);
+			raw_spin_rq_lock(this_rq);
+			return false;
+		}
 		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
@@ -2541,7 +2552,7 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		}
 
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
+			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
-- 
2.54.0

