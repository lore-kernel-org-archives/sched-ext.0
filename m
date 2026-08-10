Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40EA416CFA
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375061; cv=fail; b=Pme+a2L4Nh8FFJK6IPvwbgjTptY19rg2T73HQBginw6GgYx9pJi2v4KsEDCU9qPpGaDoGxhx58mZHOWahdhG4WNa6hHIiZ8mIVlIn8J4uuz3uiEPJkwiRi3SzdOkURbCMaaRwMedFnvv41iQ66ZhD/s+1vvedEAvxQ0Xk7zITck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375061; c=relaxed/simple;
	bh=Y0IaTOSXFbvQX7VPS2opkJa4h5HrxS1Adzw2Zp7RLVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MgniirZt5hIbKezeS38VRQQ5zGPQMfUrmBW1L/HgpzIuVX/+r3pcV+2jQfrZQRG9u8ebUiuiq815vednqecMT6Ufxuvhpc9yc7YeVDs0ziaAHpketn7OkRx47kH2uM7445bX6edkL+PYbQBGpDHcRgTzOpNWOuoSQSQ++DNFjCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rlKj9hlr; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rlKj9hlr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo2iLc9MgCYDHlbeO7WB951LkSut1/5rtjBhJif6pTpcNxQvnHwuGSzgDjj4pm0WU5+iC54iYiJ18pAzOvQ6xNjdYMjlEV58KuE+NJ/OLvker+9HWB16Bmk96RLsSXSIePdfx4PExZzyGj+QRQlGFzXK0r/TfuaRfmZ8UeFWOAtLLcovGp1u6eRC+gxxfkiOwKmchrHXYnHONQ16q65A0ugoL1FTan5uvmVpGScHzSy7UJy1gaYkVRjXAj3zc1nC62AupB3CUExqHp/qQZo1iNR2JLVGYuXRdr/sRUnxA4fya3TnqcKXrM+YnJumK6WuB2UPuufjyfsQf2AqZq+hag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d/wQc211VkzMbbNXlb1LTs49VdvHFVQkKcuFJ2ioIA=;
 b=SvoKBDrO/deVtZu9f/VY7YyCmIehcBUs9eXQU5RPw0UuxLgFH3a+Bz3aSee43w5cecCCnlIKEusUOwZUCKXyBTw/0n5efdX8vOrOfzMLap1V6ZSV14N1S4FgFSqBKX3W0/z/WRN6RxAKLfojNRIut9K8d4KlvHVyLA2djK1DE2BiZVLIXX/yt6f4URwXcdpHQnfH6lr00bKBKHaTBzfXdrnNj44ENyUIGcqj/HzfSPl2Huhxao+Wu6WjVvjb+sOn7GrKsh0bxkp1z4W1LvG7AvKxStvio350d5CA1TUviz8kLuKP1/CRhEsYPjFQOPTtTh7WucncKlw/WbQI7nz8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d/wQc211VkzMbbNXlb1LTs49VdvHFVQkKcuFJ2ioIA=;
 b=rlKj9hlrpmpJUyW5XjdrPJOEkgH5ItoH5oEYISnBauWf5W6EHhkQQ1Agj6eZtTD+hx5GIFtIMXTxHEWKJSCxiKtToI/yEeb6gT8/eULlGupTq6BGnnaDW80egm8TV+7UeqBxg777RcFtOWasIzkk9MvlEklzo9XEW7fVktQqT0J/wd/Zrrd5Z9KH04ltn7Ii08JzN9fBBTUVd50PBLtUJ1w9D/ml7anDFE9J5pgpgchzyhKX2NhCya5L5a1KIrccF5sgeLcoFQzEeYRCYwudBsXNSVwiWRa7LQFcUayOok3HFOVDomNK35vrxdcB9uALr8lfH/PWPRfmL4GOK9a7Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:17:22 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:17:22 +0000
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] sched_ext: scx_qmap: Add proxy execution support
Date: Mon, 10 Aug 2026 17:14:00 +0200
Message-ID: <20260810151523.86994-15-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ce43fc-9bba-4db3-b518-08def6f27a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/MtV0TMKpxgOu2p24IDxkDSSTFLSHi+GgOrCTcXS9y86KJUkabJSaQzJtBhauPetJY3/uU2WY7uH1Iq0mRuE0WKYleycgI0nuylUgfQ78NihXxQCOFiyGz7vRXO74hW9YYu9am7twLSG1CTA6Y0919jsqteBmpDnJ+KrYglXY9FzPgr8hWzjeV5MCio4tR3NuNnaFDkhuwAwCZ5oCLOSN5iJgHrEBvqHQiFT74ZjLWC4XDP+C65iBLIB0SPRduEieFOG8k51iCi/Tw6NyvatcMLS1lVtyq4fhySenqDnaCOQKzm795U/WvDBePkSzgTk0jzbMlVfegmVdVLyTATuztJeS/H8x5ih0UQ+NjCTy+UrWPRb8N2e3tT8kT14DXnTfZNjrthhPOylkHjQAIgNPOc+JruUTLokmccmVtlf6U+EJRlQ668SqhgYnVWZUIOqgHXb2VQ/SUciaM+CREImFBL6xed8oG/z5udplroeZwFeiMizZbZ8xzTHMyJh1GA5NOP8//8nRDkxxXZYldC4DVreVPr9M+CXRN/X3/fkGYTrYG98R3PM8/dQ/druuYz/VDZaZKBp2J9wzrdW3lzL0A/o1amw2IGljSdcgL3FKhQqT5s2XExmLUpIrd9n+DXu4jRuYjEcErDCzSLdpZwkxL4x9yYWt1IPC7Q/vHpEpm0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kzq/MuFnF1tGJs7nSU1Ko3iomNC8Eu+o77s9s07BujRfiedswts8NJhODoT9?=
 =?us-ascii?Q?6nSu2TQf2HoJspSeezKkjSuG2wLOXm1hVhZ7dPipFF1SaqLcwaDn10lWmaf5?=
 =?us-ascii?Q?20t+JVHV4K1/j/ULKZ3RJhBo/oVh3NZX/bAmU19pDolvKboOt9JX+gKTDdUQ?=
 =?us-ascii?Q?EipVCd2moHM3+hNaIET3+3JkE9hcU7DjKIuIWGO+kVjJUnVS6XOJTESRiCDW?=
 =?us-ascii?Q?7vKnc/TFveRPlI9DMWVLhmMsVnfuOducSVbwGqRVuuFcfpQafD+8EqJYn78w?=
 =?us-ascii?Q?Nv8avKz7eEEd5w5t+mmlmDLSog/XZokw6dVhailGAOepkaY0z6e1Ma4y/ZnU?=
 =?us-ascii?Q?9p8lIIUIkwZrh/o5ecyHzgb6XEThgjcHWsDakpiBILLlMCyuxlmpiUnxBKi1?=
 =?us-ascii?Q?5JLQ0NUi62LOqc3DAzZvdTynKqCrSPZzwhxby9XSeyR/jBJ1mCNS8tMjkvZj?=
 =?us-ascii?Q?6Y3DDo530vBf9Y+twv/ew/2dJMdtx2y27fI0+BZcTRB6jUxVdpRD4yXYuk2Q?=
 =?us-ascii?Q?tDg9/S6vjY/m4z/EGzTAoSNo6nY44zkj/gU2FK4kovkUWuThFwghLgAzql6n?=
 =?us-ascii?Q?1Sd9k0ipyDV4CwHpHBES9TXF9LXuWTyDR78xj6HoVH8A3Sa+vLCxw/YwUO5c?=
 =?us-ascii?Q?7KXd7VgcUeHgq/7OQb2GkatxnF8xVSMHfrdO5MLB/+ywdINJuSTPEdVYBzvL?=
 =?us-ascii?Q?KFFvEumoOkAPc9qIMQkIKQBnMX1KPGbpsIGu+s5qokJilcHqqI+c9Xqu0QOQ?=
 =?us-ascii?Q?kOXW+GIQKS7ffwb0wl6o3uP4r/V1+xTxaXRdmC6bW7r4lcS8WShMPYEIkyGN?=
 =?us-ascii?Q?8z9LvA/PW00YEEZYuBNqq6SeawZNeupZvvzJvTpS+CDNly3uwObEDoxXrIb4?=
 =?us-ascii?Q?+7gHEoPVReAEKtQGl0XkQy11383mUHPJmpqe+9bVcu2qwiYb2Ec80oo00ygm?=
 =?us-ascii?Q?+LDVp3FxMklMJO2/o8mhgqfOYJFzW6g7/iHPHpIt7WzqG+g42aCDCoyFLlk/?=
 =?us-ascii?Q?3JIJYnbhJW0AXk4tb4Zx2ebqke3SJyJUC7lBEtN9fC30YM37zpADgIlmNie4?=
 =?us-ascii?Q?u+3Ct+K/R/8y5eWBJqTbV6POMjfR/1acwHq2sNepga1t2JDWresVU/Byn8Kl?=
 =?us-ascii?Q?ie/z4wSygMv0vI/gsmjHo8+jmQN4QujnmRZoUEh4X06tqrdi2T8obKGI04Mt?=
 =?us-ascii?Q?diTFMviGAsdlGtjhMJoa3YavjLqsU8jAxwdaWCbGWzWVQde1s+hSPK2gTtR1?=
 =?us-ascii?Q?r/EPNUtDLlfKMUryoR3EEPsSwvzThZXlgh67V8e2EAxTLmTmiNJN29O/ARuS?=
 =?us-ascii?Q?XR17hAwYjCHmS5J0lSlsqMwT+hs2GPdmMz8m4upxPh6CQbmga3PHieo6YRYg?=
 =?us-ascii?Q?UsvgHeeC43ImyWgsJexFLk8thmRJ4iJchwaQOnGgIAGhjVv0nS4i/bi5CDjj?=
 =?us-ascii?Q?hAvg0k6XAOaeYYliOxczjH4guFqGGJA25TEqJkJ/yhibxxZekduO/onMSspB?=
 =?us-ascii?Q?UXQq+fjAkc3jAsEiggjGowU1MP+OkU7nY9RZsKRE0RuNSyaNSoMB0rtg0dSf?=
 =?us-ascii?Q?E7SACczISUPCOV+jzONi7RyUORkKJXXgqrsVEsQiBm4rlsSV5YHBqpRrLfnr?=
 =?us-ascii?Q?QQmJLHynO5vI2x/oRPcwsfYDQabP8pzsOAo14knSbo8Qm4his7FeYTQzo4tW?=
 =?us-ascii?Q?f8xT/qRErApC598kzgbbZRUSbixuNmMvoVt0L1ansKaEGIKXQd93jJXtkh8z?=
 =?us-ascii?Q?3fokwWuXIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ce43fc-9bba-4db3-b518-08def6f27a27
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:17:22.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5wXXnrYRNiWBFmR14tJrH/OnXzw2GcGpxgY0ldu7lBWTf15BBgOAe0X1JAX4HgeaT/sKF+aSvPcB34vbN1G3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

Add a -X option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -X, blocked donors are passed to
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

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 37 ++++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c     | 13 +++++++++---
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index dd04344378356..4cebe9d9e151e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -447,6 +447,43 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	/*
+	 * SCX_OPS_ALWAYS_ENQ_IMMED makes the local insertion below implicitly
+	 * carry SCX_ENQ_IMMED. If the CPU can't run the blocked donor immediately,
+	 * the core returns it through ops.enqueue() with SCX_ENQ_REENQ. Inserting
+	 * it into the same local DSQ would repeat the IMMED handback until the
+	 * scheduler is ejected. Move reenqueued blocked donors to the global DSQ,
+	 * which doesn't carry SCX_ENQ_IMMED, so another CPU can consume them.
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
 	 * A task of ours that can run on none of our self cids - the parent
 	 * didn't grant them or we delegated them to children - would starve in
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 988b6931633e9..5b74595d7d452 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -46,7 +46,7 @@ const char help_fmt[] =
 "See the top-of-file comment in .bpf.c for the design.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-X]\n"
 "       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -65,6 +65,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -X            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats interval, seconds (default 5)\n"
@@ -107,6 +108,7 @@ struct hier_prev {
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
+	u64 nr_enq_blocked;
 	u64 nr_inject_attempts;
 	u64 nr_rescue_dsp;
 };
@@ -190,14 +192,16 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	}
 
 	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
-	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu rescue=+%llu\n",
+	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu\n",
 	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
 	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
 	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
+	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
 	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts),
 	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp));
 	prev->nr_reenq_cap = qa->nr_reenq_cap;
 	prev->nr_reenq_immed = qa->nr_reenq_immed;
+	prev->nr_enq_blocked = qa->nr_enq_blocked;
 	prev->nr_inject_attempts = qa->nr_inject_attempts;
 	prev->nr_rescue_dsp = qa->nr_rescue_dsp;
 
@@ -262,7 +266,7 @@ int main(int argc, char **argv)
 	skel->rodata->max_tasks = 16384;
 
 	while ((opt = getopt(argc, argv,
-			     "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:B:q:vh")) != -1) {
+			     "s:e:t:T:l:b:N:PMHc:d:D:SpIXF:C:i:R:J:B:q:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -323,6 +327,9 @@ int main(int argc, char **argv)
 		case 'I':
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
+		case 'X':
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
+			break;
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index c8f602d58ca3a..ee054f6775ffa 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -174,6 +174,7 @@ struct qmap_arena {
 	/* bpf -> userspace: stats */
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
+	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
-- 
2.55.0

