Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB444C65C
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253505; cv=fail; b=QFCYhzIOzjltlwC87PmEjCNKgvmKTCrBCKrNmVrr1l+fg6t8BiEig35dLxShNtZb9/5jzQdPAfdnLf8i6elBcmxlhZG9dClxu3BPfa+zrX164bZfvfQcfysJsCpZ5kRv/hBrZcs2cqtdOcZ7x7dbvy141MrlWMTPjQUEVg8rOYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253505; c=relaxed/simple;
	bh=i78ccmtAq4c/bvpgTOMvcAySA9ZX1kNmXVgsyEEk0Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TUxDFiZY7gTXUVTZLEJnSqs8QYN0a9l+Zkvm51OcWJ7ZLvpQmPyDFMhkOpAmSmTuVCWm7MArjaZaKqaACejst+WVoXjVK28ojy51IyQ25j9hUFmznzz4piaa9mIImAAIDQRbNJsBD2aCd5G9XT1dbWtvT5jriSlwceMaqwiibCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PDPNvmSO; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PDPNvmSO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPEWUt+kW1FohEqIMo/hESJtNptnHutD+m0zlgNz73c/eFDTYXieRLKwWaKvla6Gp2LUgzN9qiZTlsiR4EEFDrRphFFjE3ViiXQEbxglfIPL86bs3vO5dS21/SaLnCxUdlVG6T785t/rFO/klkww67bK3mr/JOlxVXF8SPpDhdqRE6oQwBTnGCk1bsGDSaTnUllkVQVmS1hk+WJP9dsQooBhFdtsjnJytxafTYv4yx1ddVZxefqyoC94ohekoGtg24wNFpcU8DUxduyIkx882I3UA4VC1NnCw6Dw1l+NdvAG7f6mZEtSGFXt7vvqoHFz6bWwqDLPuSeOXokL+SnSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMLrGROyk3EeGTLI0u1KRdLv7PYUybEjZWdUo7S/qo0=;
 b=bTGg9fxZfzqALicBjgRWq1XEOX+DNfvLQpU3XrzjoaX3bI8YVYFXBS+p909iLekINL9ZHGLyqAzoygBYXkHsUgUUviOzT8EhZBNjl3oD7CTjAOrUlyY2EFtm3RANoHtUyP9jTMs3m9S77ZYAkSJZCaEzvFtfC/zWyORFFlKl6/ZdRdMJOKveGeaks/GVIgB9Id0aOE0znI3dgj8s9HbxLQrdZyGiF+hpAjgX6g5Ggs/srfJuR7xMa/2uaeeG3zjMLMGR24nKepI9h1Asqz7AQkKjsclgrrox90VlpUEbvEjoUxwwOGD9Pzb7Q8euILWqbvSIOD0PNsLqiyKdxzh1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMLrGROyk3EeGTLI0u1KRdLv7PYUybEjZWdUo7S/qo0=;
 b=PDPNvmSO3d9hwtVca8Qgg3NqXXaTPRXWmfm8pcmStb89cOngFDStSuTv1vTABmR+kYN6AX7fIRsyH+MEB7jFsBq0LdmhSRFnacu7RBLxJ1c7mgKUJR+AEQBRQHQnlpFtV5Zu5gxYkhPalX/0Y883yxarqj0BVw284nqme3QmKKtrC/Zr+wVFF60FMAi2cD00409JPg0LfXx/40PcfVNqcpDCH1IG5bMDFL5Nebt2Fbh6r/p0nMcidwVo39Gsw75H0n+mSNkYMJK6u1TIPKJJ0HuwAYIDPx+tD7zmXogvwb53gheapMO7QkHmzKfKtSZlU83SNP68V38z/hnkInzNLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:44:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:44:53 +0000
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
Subject: [PATCH 03/15] sched: Add helper to block retained proxy donors
Date: Tue, 28 Jul 2026 17:43:21 +0200
Message-ID: <20260728154425.1549660-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: e16b2ceb-9874-4f58-83d8-08deecbf2abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MNVieCN4S29s4KfNeIUtU7VFnf0aPWkOmjWpIlMoM7vO+DzSinrBEFXqw8lCtclu7uq6jdzmsTW5H4vOaqUMLNDjf2Dwvf99+4+JSwTMLh1E+W+FI1EPKDAJbQtdWSEolccrGm0UeYRsO5YNOsctdarVHzgmRzfTXfuREAbkynkM+ppJt0kiC9fWsDeHM/csdjbxBi6dAPJro+7yPsS/dyvys3SGnheBTTpBMfVdniNzv5zV02rZp2Jg+7JK8rcxWlo7wpmTl/I40swCV7KQZKSegu/NdDkog4qZGlfGWlS7F+ZIOWzE6jkIHsXSClxpD9lBtlYIcgwp/45Yt3rTyD4vvOk1sZTncyffLHzJp1J4UOzsIT0fbdp/wkjQC2BpR5MR3BPX8SGlSCmMrfv6BFEkbKBITJbsLXM47I4Bx94lx9uqyQv6zkS9dEStnAqc1zRqAvkHdN/3mJf9C2Gw1ZOZde7r9OL3u+GZ6fSiBa2tTCFnetm382uSiRY3I6el4CIzXg1X9bCg96NTDeIti0a7lXRKhO7gBborcP+y43vZ+7Ej+VspTTiTvTGMdTsPJmo22ruJcITTJQ6Sn9lgHgrpH3/fI75Dc54MrdaMgpAaEiK1rMWerHS9VPkYLp6m7w5yKHSy8pLGjRacOMdNPSNpofnwdi/4Cahg1b73Mng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMs/eOjpGeOlHagrL9UqxIoA1zVLJYCnSOBm0UQl8faFWz6nXwFdNjaVT0xB?=
 =?us-ascii?Q?Tcq/qx1WfqL+4J0MXEV82GrOrq5ak4zea4nzROFlCyczvJOjHyoUYV4f8mGC?=
 =?us-ascii?Q?rl1OLL1cSPMHpzkLwBY3IGEWX5LiHnssOcKQAxwGEKNzsaZRiYoxev6bgZMU?=
 =?us-ascii?Q?FymC1M9sjWgX6+yaIJ0v+lkiNo2VMFx5qDLW7gM9QO/5LZdM8oYH8aLGPEWK?=
 =?us-ascii?Q?wpDZHVDkMTeNaFBdeHYSPbKXxn+kCguYS9fSagL3iiy08CeTfoZ6jaTxMc7e?=
 =?us-ascii?Q?B/J82iG6LtH9HzhffSc1f49FATLPdI2xa5X75CPPFAKFq+2vyyhmqislBSFr?=
 =?us-ascii?Q?g2bPyTyL8KfZCDPmQLQWb+FozGpnE639GcaLklVY/kx5o8cmYL/8PGhpd9NR?=
 =?us-ascii?Q?Gd8RVbmdKMMWEqCOTTXd1uuBjJVa+0CIg6xDJCRCSXxCzkvnCGrP/Jt66mGM?=
 =?us-ascii?Q?pvK7GB+ZAd6USMZuFDiVLReaK7GCu8OAOBPYnDUlIPh+xASv/6Q2tMku055W?=
 =?us-ascii?Q?ln/9qR9udtle8gsRY5YcTCpjzO5CIPLBBCrzIZCrH1GNJGQsWvdtUxvMDI9J?=
 =?us-ascii?Q?NfOodj5UABS5fS0d3AoohPQcfGiqUT4Kr62iW5AC7LMqZ3W0YnH7wW5Eh3Gn?=
 =?us-ascii?Q?o19c3tKxQ/0LZ7yRF8rFpbXTbdW5NwMFBQEaE2hM8Tzfa2uSNXyEogz3sWjp?=
 =?us-ascii?Q?XmFfWKPqRawG+Zs1owjW8AeAkgs0CHzAS9BmJd13snakCbRHFhI5S0sPDFdK?=
 =?us-ascii?Q?Nuacjc8xNNCu2UDBYLrZrQKoYsTzE7Vvs2wiHoo40w8QFNm2C7NF35ybkJls?=
 =?us-ascii?Q?i9xyniPuNYAVLAM3RDFYGiKjA4lMivd2xd+kSn9z75Yv8236qW+3RtnhOh4Q?=
 =?us-ascii?Q?w2JC8dreRgWr+tac0ioiC4XjleAt+bQ4syqnO1fYSuno1kFXd854/hi27uPl?=
 =?us-ascii?Q?BhytLBNVAXYf/lhklv4C5xMmU+Jrm3KIBzpRQNLDYZqjlmk1wiJtmsC+06h6?=
 =?us-ascii?Q?2ZWp8O1IoZoZ6YO/k8QPUe4uZ+CUuvfulzd0t5R57v4RdJbt4fLCrp67345A?=
 =?us-ascii?Q?PWnICwYBvyhYw7JpKNHyE77amFkkwv2HMjMTIYSGDbJZUfjSxbC4CZ99bVHT?=
 =?us-ascii?Q?fixSsx/cgp8t8HAihuPk8Fr5ln0iubh1N+2Z+7qmSyuCivOK3KLrZekRYJri?=
 =?us-ascii?Q?oer93ofZ0X/r293FCIaEDuXmrWZsH5Bfa1U68JWITv2UxJ4J9ZWzf+TsTdm+?=
 =?us-ascii?Q?uyW+vOCMnmKmAQY6gFygaZnN8vnKBxd4oNkofcGmFoO8RxBi2qqEDv0Hk9v3?=
 =?us-ascii?Q?+Ye26g7/I9eQRNitNizW4plsKOsPlWyEZ+Pj6detvrPhshhUcRLRVsRtrk6h?=
 =?us-ascii?Q?crNKf/utX2NcezgVXCuSw0+50WrNzC/yGqmLthYerQnvxO98jJPw/FDJBbwY?=
 =?us-ascii?Q?Cxp8dg6ZzOqKN348aOKoWCtV/CaL4/FX0euMJEF6kEjTITajebMRzjSjAZEQ?=
 =?us-ascii?Q?DCUqg/OmgzxgiR9vrfDzbK8wNsX8nmikDcxmHJzPduHR11L+CdEf+sCklsaN?=
 =?us-ascii?Q?ut325JTr/FD/HvuSFgClrKDs3Xk73umjoV0ka1m6KbrpOl/HRqSoQJ01SXlU?=
 =?us-ascii?Q?hkTopRv+4zNwmHCEv2V1aIpYpRrN2+1cCjRZTg4LHljk3plxXHRRPJVsCoPA?=
 =?us-ascii?Q?K3InrlgyfSbcVd82wTh0GrZhD5NHrBXvQo1f/gSDkUpMefyc3TwdVAewLEK7?=
 =?us-ascii?Q?SVKPtbyxjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16b2ceb-9874-4f58-83d8-08deecbf2abe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:44:53.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbGjdrg+6baD8m1imhKOdjATNKG6upWkNWTvoTATkn6kCTjSfDkikfq5PhCSPT+KyjQ4C7hQud4XTa/uSNybHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

Scheduler ownership changes may need to turn a mutex-blocked task
retained on the runqueue for proxy execution back into a normally
blocked task.

Add sched_proxy_block_task() to perform that transition while holding
p->pi_lock and the task's runqueue lock. Reset an active donor to the
physical current task before blocking it. If DELAY_DEQUEUE keeps a FAIR
donor queued, the immediately following sched_change_begin() completes
the dequeue through switching_from_fair() before recording its queued
state.

This is a preparatory change to support proxy execution with sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 28 ++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 96b8b01d43101..2cc6c9d16200c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6764,6 +6764,34 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate if block_task()
+ * drops it from the runqueue. If DELAY_DEQUEUE keeps a blocked fair task
+ * queued, switching_from_fair() completes the dequeue in the immediately
+ * following sched_change_begin().
+ */
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
+{
+	unsigned long state = READ_ONCE(p->__state);
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	if (!p->is_blocked || !task_on_rq_queued(p))
+		return;
+	if (WARN_ON_ONCE(state == TASK_RUNNING))
+		return;
+
+	if (task_current_donor(rq, p))
+		proxy_reset_donor(rq);
+
+	if (!p->se.sched_delayed)
+		block_task(rq, p, state);
+
+	WARN_ON_ONCE(task_on_rq_queued(p) && !p->se.sched_delayed);
+}
+
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c0cb879d75f03..6119bfd2de60d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2476,6 +2476,12 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
+#else
+static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
+#endif
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
-- 
2.55.0

