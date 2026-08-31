Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C45437F9
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183968; cv=fail; b=JtrN3qKRZ0DXptaLWZbMLABpKuUy0CPdpNFP3PuUJuUi80naUBXOnHobkHo5Z6v+Y/M9H08V/7wzibhkbCW4T/+x/9Og57Zcw4uOPsZEVOzWeiqBElYsuwbvuFz/D3m1DDTU5XBoii1tcaiByX2xkDvAiJevH9KCRFkdOpWzdzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183968; c=relaxed/simple;
	bh=WzG0k1yeb5FVPVtC92BF7i1tZyQFwWhU5MMfw9TIIa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAyBHHWdAmb02fTuyaWhXLmiot+eEiN9L/UUol832qSZjBDTQNsWkJ9gTAtJA+5InE+XfWkjwELEFisR6t/NaihoPrpQ7ulx7QEHBpxeSvf+1II+v7bFOb3z79lWFH0Kc8xcT+PcRNhLDP5kytKO55d6YRVFeGJgRenMM1/dlbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FGxc16VX; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FGxc16VX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkxHvkPhgHisAft6i0Xr5lfoyhvG6z/uVow7kKrBNbzV9nzWgsyEc2RQTvruxMaOs4b0LiEwvA7TTULS881Q3pDBjXEnASo4N7HfJp1dwy6UzV+wIxqkXm3Zt0cD5v6phlSRgoPU/XRYi7oPcRbzZL8N7XkrhUHFUV+YzvRzEEAquMUNL5emh/4UVavBcdBnbBVV2rDisxm0yKwWc5p2nGrmGaqiK8q84e9TCu4lk5s2NeIUM9QEhx2IwJ+AQWz3lenw6tYDVDJ9wRjDzZBef0yWQceEB2kZQyNKVsj7E6RQkcUGQuOjEPnEmqjMNq8w8lUkg6U9zwmnbTGkghVz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da/6DOy4DCvo0YfMcUzJJ+qiJ4IgyJh83GlRGCukyFA=;
 b=LcRuqFNU0U0YdtZiiQXo1e2yZrH9SIenpsCbLMfxpj3FsLt0UtmfWvgYVo0fgy8mkPUMX/kcCIlUM6i9vHKIGWdksN9j1kErMj/mWOrzGjZFDxOVqnis3MF/kY08LlVbUpKL+pIn0h1j8tLYHrVza+BbqqkEM0u4wv6A+mmQzJJtExVB5nkoG435zwEajW4EsOLN+KxPQqaRFHNgIPWeFdaDq3fp9IxDd9mD8iVA/NyvUQ3Sj8rVn6/vxF9qSWQXupl7IV3ozyljU+9a6P4DMu4qIoJWcdolql1d6wF67oBMJ1TjLscOZUI5R8t7E2N/2axmhKu805/xbi+LsFog1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da/6DOy4DCvo0YfMcUzJJ+qiJ4IgyJh83GlRGCukyFA=;
 b=FGxc16VXAgncq4QEZKPZ8WLD1eYrZbjr/V1LSCm4qPK9tM9S2PrP3R2jG1jm2TW2uYuClTSAnvNSN+XFrROCNUH0Qp3xTXHXEXklQivsAtilFJLKI0Z67x4Tn6kESyzhwtcY0ybMjzL8JcQwTZGXu6JCEJqxB++ycb2i8mJzw1d2AGx4ea3gAKfHLzqmYawG5tKuauHqSS69nvVh4aWH15fDEtVAYnoSi0aImdinvJgpotgZfm7N4ZLbpvpmQhnw5IwSfcY7enzkyWeue3Cv8eaH0ZB+idTpPr+DcnAlYvx2xEbSmHrD0JfUrnHbRdWWxqGDsf4zrUjEx0KjUZotCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:45:57 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:45:57 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/18] sched_ext: scx_qmap: Add proxy execution support
Date: Mon, 31 Aug 2026 15:42:27 +0200
Message-ID: <20260831134338.1531664-18-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008C4.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::426) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: e6714003-9915-4b91-8207-08df07662f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ccEGpzbXYmZqmaylPcUlgPDsTraLEXy3j/b6Kvlrw3Ol+kAHVRKT0WF/KeMtQ5CiXq34jKTpF92cN8woHaArn/VA95EKUsQhL21NmMaGGWdOaMKcH5HRUOHOkP3+xz7yLWOHncxc2GOgv8c5ffFR9OvjKmmji6eLcoqm2sPJVCUxCy7Z/97m+DBVx4y4kHSWQyb16ajJvipcXPJI2Y0/BdGIPR5WWdmIg3hKu0Wg/Ea9Ysi4QqjxveOWC7oa4+wwulJTyW5n3/GR+Vj0ixkl1vJ2el82VCKZMRkc/OnPUt+XZ6vHNpKeHFSYjN+lkH5rUKmOcrChGXCvOOswWuGI1ep/BYzNGWME0J2C5zZ3XHLXbZUL8gRI2apHpxVJSA0x6I2vZYFKn4MGs8471Wv5CzhR8LFsNOuQBFL5r8CgoVAmf5vGtnPO35Ht2mWq4wrbcfdgAVG4hSdMQB1XVXwOlMtp8+zzyxpxq6RcW4MMQkt6Zw2R2GiVHOSf99LXKPoBHqYps7GyMPiC9g0zbIZvPAJYuMoFhYesXZwoX9fyULLhMqq1VVc8t65rAB0IpEYUgQoet0y5JdzgETouSQ1dUXuzBqHYipL8D4vs4kYxZIwJEQHxPk0gdKYAbukhohHR77ZRjopHxo+9jWoF4YWwIQycMF9Dp+3tupNuenEhX4s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yOgvFFd9Q6nFD490qT0YOPdql7KP9Hh7m3bYKx2tRsfYbG9F+m5iekcU6LvG?=
 =?us-ascii?Q?g840yqe6ci7VHo+qV7R9+cNj1SOqrEiXpihqdCitFWZDEGEv5RyskSYHYm1P?=
 =?us-ascii?Q?QQu26eWI8hIQjajdxrSci2su6brkS2jXRJLJrqFQLbbVPNHUMsNbtPbSYUbA?=
 =?us-ascii?Q?zw0N99eiq8zyZrRso0mcTawoqDqDqpLYubQxFO+fITTXZUHn3VWhGvRk4vS4?=
 =?us-ascii?Q?9WhwLdtJ6E5/fjKjXxcqYh0ijdJ0AAGpZDfwuvZRo8JKNFBMPQc254zDigWQ?=
 =?us-ascii?Q?yEJcFd+XQpydx4/AKztrkMfORiPyK3Uy7yp0YpZy2Q/wUeIDHgpVuoNwo3jA?=
 =?us-ascii?Q?pxZlSVzM96snKAQzKYFG+WCzh+Tro9n1XO8n3Fwi6WVXSLK9m5VZ1i9sIF0k?=
 =?us-ascii?Q?H6hoBCkCybECfufKqBGgAL216IftjrO/mUbPDSTLT/UI5GLRYG8cKS5/RGGS?=
 =?us-ascii?Q?3YsBq3JY7EDuEJ60hzNosANnhh9We2C6LeR3VCldr88nQSrJAvM/tl6CbFhF?=
 =?us-ascii?Q?F2kqxRm3IdpoP3zD4lUPsa+r1oL2PdIAUvEX7073nw6wFvbSiRFHMT29EouL?=
 =?us-ascii?Q?shKQTLr8e0eVD6lglRcnMB9PO/uQHE4bEcwWx1NTrTlAEmP2e/SL9MyJBjeN?=
 =?us-ascii?Q?FP6MTK+hyxiorC7/pJxWxeKRKlUJD7TAQjjiX1I2lMGxm5KQ3Y0aQtxHE2z6?=
 =?us-ascii?Q?MIgV48X4en6CxkjvcLNt/0gvE+dISf0PyiF5GfQI1n/0zJ+DdPLMi+xnHzCV?=
 =?us-ascii?Q?ZXQ/R9kUaZbvanOTb4AOL7KxtpE+4VLJqCF0NJOvtmmIfTqdgacPJHcWwzq5?=
 =?us-ascii?Q?Cx263EBvelxBh8aKIZKsqJV0Qd+OTx4Xr7awUz5aj44c1VyVLQlGwLP8Z4pg?=
 =?us-ascii?Q?I8l5e+K7zUydxERgT7tZDvRSMmwFPQwd4FuLnkrBFD5Q5B4qX+u/bge/9sE3?=
 =?us-ascii?Q?yJdlFNKjNJ9dTF9cMExYkhsKP4FyaTjM1RwVQQrWRK5aLq6Rr9V6SZA94/7L?=
 =?us-ascii?Q?jzQOdPabfo5Z3Jupn681Pp8H/v0Ewfqk81PBIiq5kp3JLCITcGAgnsa/HbNO?=
 =?us-ascii?Q?McQLkV5wXjF/kiG8hf1C8empwGz50SK5mIW8v601VpUhYEa5xU7FnHsJTdTO?=
 =?us-ascii?Q?72iOOQ8CmmbtdlR8QK/rdGnozyrqQD2bNWhvHol2dHV7LKJoXvc+8XznFuWG?=
 =?us-ascii?Q?STgMHkEyyBnw2xR+P/RoWUM9uN+WmgX7rYx5GfJObJDO5XaRE5gOr+UITHTg?=
 =?us-ascii?Q?8dQgb6urWh0GxnvkHoon8fBwVLtO8flz8TtgXaHwYj2tnoztEPoeiVn1bTY0?=
 =?us-ascii?Q?QWThLvJZH+SPKmkI/h4T0Sm7iW4x7iLLhfEQEIFh3qUTeFt7mnMVMRsm6RFV?=
 =?us-ascii?Q?FTwTJ7Sr7B+2GALgCHTD6pE6OgqaJ6c4Hi9JRgmhOlcOiFY9GNHvOpCSh/ug?=
 =?us-ascii?Q?Ma6J6vRJQepnem7IozPnf/QF+cvfz5HUKSFrXcrGiXRF47PCGs0VrFE6yiAI?=
 =?us-ascii?Q?Wsd4cVxi+DhszvC8V9AHS8FSpfP6vIKvo+AlUwTexkiMCtxJBbDteelPdw7N?=
 =?us-ascii?Q?yx8niFoqNznWKlCj2w51UQr3EpkDGscCp67Es/Z5MwJFI8ns9o0vP3H3bJX5?=
 =?us-ascii?Q?NJroyZH3MNQDI0pN6Xc47Ayb6xuqaFdWXPIy7sqlZ6eMVVit7/qHl6cIDIWc?=
 =?us-ascii?Q?VxiBEo5t/+1/LYNygwLQYYoVvuD5V3oTrSIeiqBQWu/m/PaAHi3EDCEIkgUk?=
 =?us-ascii?Q?QuVoRgGR6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6714003-9915-4b91-8207-08df07662f48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:45:57.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHS4wBbyjx5XNNopSxO1/OxKX9fZ31n98Xy5eZKLvWsV0ZUpRs6kChuQIBDe04O3A6y2zkan1GOt/qNM97UP9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

Add a -X option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -X, blocked donors are passed to
qmap_enqueue() with SCX_ENQ_BLOCKED.

When scx_qmap receives a blocked donor, select a cid allowed by the task
and held by qmap, preferring its current cid. Dispatch the donor to that
cid's local DSQ with a fresh slice and SCX_ENQ_PREEMPT, adding
SCX_ENQ_IMMED when the cid is time-shared. This places the donor at the
head of an eligible DSQ and requests an immediate reschedule, allowing
the core proxy-exec path to run the mutex owner using the donor's
scheduling context as soon as the donor is selected.

The blocked policy is intentionally unfair and can strongly prioritize
tasks using contended mutexes, but scx_qmap is a demo scheduler and such
aggressive behavior makes proxy-exec support easy to observe. Count all
blocked dispatch attempts in nr_enq_blocked and report their per-interval
delta.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 53 +++++++++++++++++++++++++++++++++-
 tools/sched_ext/scx_qmap.c     | 13 +++++++--
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 5bb8b90a275a3..21f8a9be9650c 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -439,6 +439,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	if (enq_flags & SCX_ENQ_BLOCKED)
+		__sync_fetch_and_add(&qa.nr_enq_blocked, 1);
+
 	/*
 	 * A task of ours that can run on none of our self cids - the parent
 	 * didn't grant them or we delegated them to children - would starve in
@@ -446,7 +449,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 *
 	 * Force it onto its first allowed cid's local DSQ. If we hold that cid
 	 * it runs. Otherwise the insert carries SCX_ENQ_RESCUE and the kernel
-	 * diverts the task to its rescue path.
+	 * diverts the task to its rescue path. Do this before the blocked-donor
+	 * fast paths, which also require an eligible self cid to make progress.
 	 */
 	if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
 		s32 c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
@@ -460,6 +464,53 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		}
 	}
 
+	/*
+	 * SCX_OPS_ALWAYS_ENQ_IMMED makes the local insertion below implicitly
+	 * carry SCX_ENQ_IMMED. If the CPU can't run the blocked donor immediately,
+	 * the core returns it through ops.enqueue() with SCX_ENQ_REENQ. Inserting
+	 * it into the same local DSQ would repeat the IMMED handback until the
+	 * scheduler is ejected. Move reenqueued blocked donors to the shared DSQ,
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
+	 * Insert a blocked mutex donor at the head of an eligible local DSQ with
+	 * a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate reschedule.
+	 * The test above guarantees that cpus_allowed intersects self_cids, but
+	 * the donor's current cid may have been delegated to a child. Search the
+	 * intersection starting at the current cid, preserving it when qmap still
+	 * holds it and wrapping to another eligible self cid otherwise.
+	 *
+	 * A self cid may be held exclusively with SCX_CAP_ENQ or time-shared with
+	 * only SCX_CAP_ENQ_IMMED. Add needs_immed() so either kind can accept the
+	 * local insertion instead of rejecting and reenqueuing the donor for a
+	 * capability miss. Once selected, the core proxy-exec path can run the
+	 * mutex owner using the donor's scheduling context.
+	 *
+	 * This policy is intentionally unfair and can strongly prioritize tasks
+	 * using contended mutexes; scx_qmap is a demonstration scheduler and
+	 * this behavior makes proxy-exec support easy to observe.
+	 */
+	if (enq_flags & SCX_ENQ_BLOCKED) {
+		cid = cmask_next_and_set_wrap(&taskc->cpus_allowed,
+					      &qa.self_cids.mask,
+					      scx_bpf_task_cid(p));
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid, slice_ns,
+				   enq_flags | needs_immed(cid) | SCX_ENQ_PREEMPT);
+		return;
+	}
+
 	/*
 	 * Fault injection: deliberately dispatch one of our own tasks to a cid
 	 * we don't hold. The inserts carry SCX_ENQ_RESCUE and divert to the
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 5bb5f687e579c..d5226e0716573 100644
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
 
@@ -263,7 +267,7 @@ int main(int argc, char **argv)
 	skel->rodata->max_tasks = 16384;
 
 	while ((opt = getopt(argc, argv,
-			     "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:B:q:vh")) != -1) {
+			     "s:e:t:T:l:b:N:PMHc:d:D:SpIXF:C:i:R:J:B:q:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -324,6 +328,9 @@ int main(int argc, char **argv)
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
index c78d61806b398..fc10b542fb477 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -178,6 +178,7 @@ struct qmap_arena {
 	/* bpf -> userspace: stats */
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
+	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
-- 
2.55.0

