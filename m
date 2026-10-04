Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50635F170
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098981; cv=fail; b=u+WurVM1IHNoVSJCa+QPd2XqBfCkBKECh6cy0/e3A4cQQ/BswLcRdR6zc2HB905eQVcBcbX1UDwWpaKWYktmMYBu1QEdPpgvU7O0QHBOXhp/TT77zGn7Putaph0ORc51WDVGZ5FG4Zik1KI0FkIN/c6j2TThHk1E/2QSoWVPofs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098981; c=relaxed/simple;
	bh=MyTzZEX9AL4MZWRE500Fnc7ROhwxXO08n3igJPPMii0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gr4db1lsO7at7NN5SvM9UIUA4wk/OOhAHGf9zCMfPuN03ZraDmHcU1R3YOmgWOI3fsymNFGviQz7VQLt2zuYwRs8uqvIMOd3kfa1xYEdgJBXdNgTmAXPD/sWLK7kYnM5HrMIHuYQKsqkhOWpuiCOa1+HQZPspNVl5mOpMzik8uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3DzozMS; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3DzozMS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL91Rkha+Y7zkQy+xnVbCjgjeuWnJcwKehz001k+Fu4PZCIctUUHhKb9J1VBX2c5s+MNC2yL3sfZKrS4YUzULodIn9NcLkaZlcW3lV0DtjXurCmMNbohK1+2iXwtClR+OD85NMYxlcgaw2jP2x+ZpbE70PrsN1zqvNAtaRhxV8k6xTOULcA2rACMm+wM2vsqknbiEarnTTDwgo7eouzXRv/CqpW2p40Bx9ULZKe9QVaoMX9jrJZILSBe2z4SmDqn1U/X0DSN4tSUrcDCnkqO+6uuNLgrKsL5ubw5s3AmAy8k5E/3juNeM1znbw/2vc7p0nIgjFRXR5Cb4Jw/UTjTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKe+aLyFsi795JKIn8hlpB0Js37jGdXgXHtu+CUWbTc=;
 b=OFmmuYxBCVIz1D4DIi4diKNSd+rC4Khv/bNGz1gpcomAM5psafzFUNAhR/fBcxfxz4Jvmr46iHXSpOXihr3vyU5qePyFnLguW1y4sWpFplU1mpQmdDqRNKt5K1Io3cdBvMZub9uTvd/wU9oQkijPMtslu7/NI5reshEar+eg57bKnZwMumN1k5PjLEn2W7wkU7X+9s3zX7xJaEI547L8sRe0rmUjxY13b2/aAivkdB+KVmX3wJbfONz04qU7lKJEW0MOUaCYUs7pdXEjwYgR4M5CF0oyY3slfhOtgR2itenGBLBeTIYXzthJ6DAgMf/zqcnquIbfc2tKd8GNTO93jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKe+aLyFsi795JKIn8hlpB0Js37jGdXgXHtu+CUWbTc=;
 b=q3DzozMSVWb8eEgLsuj9pJ7iM1hVu2WtZU0rBMz6DmmHvJBK2EtDRjV3Ikq9Qi0kvvJuf765IKLAjolFgJiZgroRqvb8Byys/GWjHvg4KxAuCj2odnLbdcvcgDd4O6NToK1Yuft2q138qS7GMVYT1dexUGBxvwelnFXc+YngzYOWvgDLPKP/yd636w8Ge4FLhwcX9HgcnMh2oWclWVIXo0lOzk5ZJtLxqDn0Y4ACLxwk+6ywawkbosl03H5XKw0CR3yIY0q64wc/nJ1FO4FkzBoBSJuEouYD18agQv3u/MLOhkIflMxsmmvkfqOex3wnSkJIoT/YaGiZX8WESyU0Mw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 07:29:23 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 07:29:23 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sched_ext: Scan NUMA hinting faults for opted-in BPF schedulers
Date: Sun,  4 Oct 2026 09:27:09 +0200
Message-ID: <20261004072901.3579967-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004072901.3579967-1-arighi@nvidia.com>
References: <20261004072901.3579967-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0193.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::14) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c00c4d0-fbf1-4432-0253-08df21e9360f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9DBpEIaGdTJYVNwmLtrNxh9be+LARiKZaCY8iTLMkbGvnaM9vXQHYkEmC+LRm8zT2Fdv5hhOyKOMPDw+e2IIW5W5IVcdslXNmHL5BY18ZwGsCLZeejCTf+Px41i6awYuFmLUDMzTpTylGqjRBv5c13e6DqcLbeTaagHXa82OLQ/NeJfWk8q8yEYzcFIZoqyFwO4npJqvRmRbX4nkv+x+PyJcWFByrKGmFQrJMfaE2g3W5DY7O1zRBUOmcX4l/yB9PJI6qHCCZzjWJBS/J9nafFSo1i8XFhAf32GWT/Pxc7XcyTldDlLFuIKds1B+xuqfQN22bptZbAhV1mfeGP3RMcD2359DGCbAxnZOgxqryl8UF4+cF4xA+EDNSoJ24dJ4nXlBq4chpFGR7MAE+PHBagVMySeZpSAbmAmc4v7PI1yK7bqwvyWR3DWr+6LkHvL6J0+DMSLNrCBjrr5SRZI53U9yWoo6dE12/5SrSm0QT2q0oPebJcxDK6V048P+raVHGyDjMqSVJk5LqMqhpNd4ek0VGnlPq9iW8qFs3e/LdCKpMfzLUWec5MX03v3rXMuJPIzGblyj9yGZK81vsyaemKteIuW/3bSbknw5wuNXrRU1+jRqCKuw8mLeqVN0AzHe4eTbG9Mr01rszTycAcH0biq7GaduS8FxVcH8pI9Lz9U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O+tzqlcktGpkvqdrkwD98QMBE3R2vP0qW1/Fl1jm4mFI+2szlFVmK6ADZq1+?=
 =?us-ascii?Q?koPStJo23IIsd5X8VwAuI8ofHpSCFFkdafE9yrwBustNskHUFJ8+Ie0Vi4KP?=
 =?us-ascii?Q?9BBVs1BjF3f1QSZ3KhnwmXXNn+yOE9IyW3BcwFJizRWXda/tLc7yu7Yso2Mb?=
 =?us-ascii?Q?SUuV9n5a0cVCexoHXQlvEPkjhU5iO80zsNhflrafhJyEm0gfnXwM7yJDmaMI?=
 =?us-ascii?Q?XiWM8LkGU3AmU0zJAn+DT2xP2MVxLFLtmgefIep5BwWGyckaAuYBPvUqY3O3?=
 =?us-ascii?Q?IrxEwRbMMTdswWIYafHMePXUWSQJjL9oJBuH9TpuIxDsF61wbZS2qpzNCV5S?=
 =?us-ascii?Q?ILlIrYjyZmMo65frAe9n4WMsmbmmNiVftzctZX9wSx1chbjZf2j6FAbJ2gP0?=
 =?us-ascii?Q?LO6jGbz9hOG1vs6Rb3Qv/5tEJ+8aLbh6njSAodRdaEWBIJ8zZMmkUxMt8/h7?=
 =?us-ascii?Q?RkIEVTEn0XZvdDil6jN5aboP0o+wPmtgmZE/W5MUINk6hm7M7ZqMJYV5G3Vu?=
 =?us-ascii?Q?OE7RjoYHq7bTFCoExbEJc7GpB5iqKlgCKO8cLQwubV/oMuAJJW2OM/WjHTsn?=
 =?us-ascii?Q?/vW4HZX4ZGaLRrq0fk6QcxIEQkEk67mEGKnjOXfZ+jEcGYr4Ia4GCxWawrnY?=
 =?us-ascii?Q?LpLAONDxyNaYITcsE43LvWcv35UoNfQFnuYdHxLe6ow9SpPUzn0vMGkrkYyU?=
 =?us-ascii?Q?cG/a4FwJFAOTCT9Yw5bRTNwSOxStio6hy91ESoq/ZUW+iFUUaz2xC5xbbQUw?=
 =?us-ascii?Q?a7+1L73X2lGgpYlajZTCHMuokRMU4c4c+RmiFQJhVPbxdoC46U5cwIyNu5vW?=
 =?us-ascii?Q?urgq/dA8pvrWjSjrRxjwTe19k1OR42slqs3lXRXZfXguhvpUJArvLIs9sDjB?=
 =?us-ascii?Q?rP+sp6ze8hGviZ6V+Tt2OCN+NcPrjxUYpDf3EzJ/bKeyqcFN7pGUc5/28wAs?=
 =?us-ascii?Q?4fMJ0sjt9jn6RClqMOQARiWU0fb0wWmKnNblHIzYpi3QYzz7vnbIMJ7s77F3?=
 =?us-ascii?Q?3mHDXosC8i6VrmxqI+yuxuqLh4pNoSFyKPd1+gJ4sOdSdjjsW8wzwlRNHoGN?=
 =?us-ascii?Q?sr9pkad4VMUDQrJ1hnn4NWXDDH+RyHM1KCBr+fuzBguFoZDn9yAxkjlxll7y?=
 =?us-ascii?Q?hK0hn7jq8PXyrqtLpZ2UWhLZA26D2+k4wZvlk2O4WzZl4SylbG8RCOXopa1G?=
 =?us-ascii?Q?6lavV1CQDqloWH/rYxh466gqXVAwgeu8mUK/Oj1YliMZPUJNKRwoaIyFvkcV?=
 =?us-ascii?Q?QEXtQjTO/n7rK9n2l3pB+Hv3WvIULRDVRGMOQhN7RER/yx6jUd1kWLQrC3D7?=
 =?us-ascii?Q?yaAg4KYo0noZ47zxHdweQhEy+X5sWRRTnox9QoNIEBowmkGyRGFArMnM07++?=
 =?us-ascii?Q?Xjn6mdqF9L1PztVkhMN+eUrYXOIdrtf0KjQ7/jf3dYUC/3ihdEUjjrKjhGBz?=
 =?us-ascii?Q?DnPCMCHfg0YuvqZz9taF4kwz810C8r/IZjjfD2lOGGCro9SrmFq1Or/vpANw?=
 =?us-ascii?Q?yZFRCYmaRemysBOyoqvotyZX8kdYcXxlvYRgzkFEF6cOwq1jyo0rbR2IPru/?=
 =?us-ascii?Q?o8wqw+g7MDGym5SesPvX2Unuxxn59uhIMVOKcGnPVvbhIqiPyO2opPrTLAh9?=
 =?us-ascii?Q?CI0R14fEk8BqGySUg3lFlm5EC90HifHZgRSdMuC4U+UR0LI588Z7rzELXhmU?=
 =?us-ascii?Q?iOq8yp+DZQ4T3XG5KAqoqNPwNpozFLO+ykGZ3DyzaRKnGRCC1ICqXrNdAjXB?=
 =?us-ascii?Q?TnbeHRONPw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c00c4d0-fbf1-4432-0253-08df21e9360f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 07:29:22.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+sOeewTlEy9Ok2+9f6r01o956tbengOgPuZa87PWUudH5eI9oPIhnKVLOZCann1dSqs4cFKTTfvu9C2ybZylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

A task running under a BPF scheduler never has its address space scanned
for NUMA hinting faults. As a result, mm/memory.c never calls
task_numa_fault() and the task's NUMA fault statistics and preferred
node remain empty.

Scanning is not free and a scheduler which does not use the result
should not pay for it. Add SCX_OPS_NUMA_BALANCING to let a BPF scheduler
request the NUMA hinting-fault scan for its tasks. Drive the scan from
the sched_ext tick for tasks owned by an opted-in scheduler, the way
task_tick_fair() does, under the existing sched_numa_balancing static
key. The hrtick, which only fires to end the running task's slice, does
not drive the scan, as in task_tick_fair().

The hinting faults then work for these tasks as they do for fair tasks:
they maintain the NUMA statistics, the preferred node and potentially
migrate the memory a task accesses toward the node the task runs on. The
tasks themselves are not migrated, the BPF scheduler remains responsible
for placing them.

No new accounting is needed to pace the scan, task_tick_numa() spaces
scans by the task's CPU time, p->se.sum_exec_runtime and sched_ext
already maintains that field through update_curr_common().

Reported-by: Vladimir Vdovin <deliran@verdict.gg>
Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c                          | 13 +++++++++++++
 kernel/sched/ext/internal.h                     | 16 +++++++++++++++-
 tools/sched_ext/include/scx/compat.h            |  1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |  1 +
 tools/sched_ext/include/scx/enums_abi.autogen.h |  3 ++-
 5 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 96c904b396019..b22db5ccb91ab 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4227,6 +4227,19 @@ static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 	else if (SCX_HAS_OP(sch, tick))
 		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 
+	/*
+	 * If requested by the scheduler, drive the NUMA hinting-fault scan as
+	 * task_tick_fair() does. Neither the scan nor the statistics it feeds
+	 * depend on the scheduling class. Where the task then runs is left to
+	 * that scheduler: numa_migrate_preferred() does not move a task it owns.
+	 *
+	 * The tick that only refreshes an already queued task does not scan,
+	 * matching the @queued check in task_tick_fair().
+	 */
+	if (!queued && (sch->ops.flags & SCX_OPS_NUMA_BALANCING) &&
+	    static_branch_unlikely(&sched_numa_balancing))
+		task_tick_numa(rq, donor);
+
 	if (!donor->scx.slice) {
 		/* the slice can't be trusted while bypassing */
 		if (READ_ONCE(donor->scx.lazy_resched) &&
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index d65fec631bdf7..10cbbee48e094 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -243,6 +243,19 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_ENQ_BLOCKED		= 1LLU << 10,
 
+	/*
+	 * If set, drive automatic NUMA hinting-fault scans for tasks owned by
+	 * this scheduler. The faults maintain the tasks' NUMA statistics and
+	 * preferred node, which can be queried with scx_bpf_task_numa_nid(),
+	 * and migrate the memory a task accesses toward the node it runs on, as
+	 * NUMA balancing does for fair tasks. Tasks themselves are never
+	 * migrated: the BPF scheduler remains responsible for placing them.
+	 *
+	 * If clear, sched_ext does not initiate NUMA hinting-fault scans for the
+	 * scheduler's tasks.
+	 */
+	SCX_OPS_NUMA_BALANCING		= 1LLU << 11,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -253,7 +266,8 @@ enum scx_ops_flags {
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
 					  SCX_OPS_TID_TO_TASK |
 					  SCX_OPS_LAZY_RESCHED |
-					  SCX_OPS_ENQ_BLOCKED,
+					  SCX_OPS_ENQ_BLOCKED |
+					  SCX_OPS_NUMA_BALANCING,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 07fb55e63c57c..f4c35f8750730 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -215,6 +215,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
 #define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
+#define SCX_OPS_NUMA_BALANCING SCX_OPS_FLAG(SCX_OPS_NUMA_BALANCING)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 4fa82033b99c9..1bed9c9a96f29 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -172,6 +172,7 @@
 #define HAVE_SCX_OPS_TID_TO_TASK
 #define HAVE_SCX_OPS_LAZY_RESCHED
 #define HAVE_SCX_OPS_ENQ_BLOCKED
+#define HAVE_SCX_OPS_NUMA_BALANCING
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index 1186daa9cb141..1cc1aad845023 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -184,7 +184,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ops_flags", "SCX_OPS_TID_TO_TASK", 0x100LLU },
 	{ "scx_ops_flags", "SCX_OPS_LAZY_RESCHED", 0x200LLU },
 	{ "scx_ops_flags", "SCX_OPS_ENQ_BLOCKED", 0x400LLU },
-	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x7ffLLU },
+	{ "scx_ops_flags", "SCX_OPS_NUMA_BALANCING", 0x800LLU },
+	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0xfffLLU },
 	{ "scx_ops_flags", "__SCX_OPS_INTERNAL_MASK", 0xff00000000000000LLU },
 	{ "scx_ops_flags", "SCX_OPS_HAS_CPU_PREEMPT", 0x100000000000000LLU },
 	{ "scx_ops_state", "SCX_OPSS_NONE", 0x0LLU },
-- 
2.55.0

