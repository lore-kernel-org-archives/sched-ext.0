Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCCD18B0F
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784221; cv=fail; b=sYywuRUjLrOrvKRbh146htqa60nbkOv7cj08yNAFjXEkDi5sGfkJaSqqK9y1S86Qfz3RiTrYBruT2Z/bhiobaE7Cx313onYPhbn36g3yGWADMqzvMatbC8sKIFQW02fEVdviDT2aI7IwSQ4OkYyIsqcL3RnEmJY+HT67NgbmEYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784221; c=relaxed/simple;
	bh=WmcvZCxNGTFireeB0PUlbcIf22eZt7oIXgR4CoJwVZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uYwJO52wDsV7bjP+11FoK6/F0N6fYD8c9PHiF5gACeGjPvr1vbTAE9FB0JG+cVRJ6fxcFfDkyTV1mbx0MNImwYqz5a1p8V072SPunSXZfLsjLIxUu9Aaydoifph4T8RYSnaGAN3iI0g6d5e+rgcPr767IpQu0A3uw77Iho+NA30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nSIM0ouL; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nSIM0ouL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6ePGf2xJKG7CQyLiaqDZcalu5GNir51v9CmTy24/4jRG5LI5BDIInnGqzxBToF3PoceBqiVN4oPKmq7bIcOsNYBpRvpZlvz2sp6xs3c10rAiioKxSf2lwDll0Io+zUNCGJZA6vdYyYpk63CEvO3WSqKnhi17onofO0vrl5KFCSw5HBoekfviuUzA8LN340eoI6XvZCxI3zJCXAHNdmSLPaF5dLvkj0zb5L+fTG4TH3b9RyXVjSV5ElgiIa2U0Cdy+9jSItjmatkhZcJ0bHwRdLxO3t+j+RlNHVB0oMFi2mWb61lsgzJFb5Bqvm0kBjWMbsMSyxfwOrhSBECZQWREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTx4RdjOpJc90AOGAozQeTWrf9+UryB2BNo94pCrw2M=;
 b=aMy42Pg0/7cWnQcatwBulNNa/v5lZnKv+en4SI6hrlJKReKCTVTCFVINWx++U+R92uNCGccgewbxLXgn10YdzsPclCPwd3QZE/+WO99/li42QidUTkrExGgkZGcdMpu5nIYwiABavYTr4mi9nO8rl2C1sDGBQub7t0DKXbuy6GhkLG1DeiXIlPuFFEYadiiu4T8rSYzR7sMymamIRLSyx+3JWV+b1hPIGrhzpfXp/stYLExkOUd0raLqI5BBZd0xWE7FXui07IpbaH9i1iqO6/qmNueJcsgU0+/7ozEZZiFhxFIl7uSlziTfDiagn4rmzq1G8UIL790eDA+F9jVsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTx4RdjOpJc90AOGAozQeTWrf9+UryB2BNo94pCrw2M=;
 b=nSIM0ouLaLdK8selnvntcikC2RiiIiyhGMGA7HtXNhNDifM1gd7iCEQz5g4RmF0GRAn/rwgZdxBg6uSz1unzXFTeJ4/yjswUW3RjnLhKCWRdbAaAD8TtCIWC/3Kv6GN0Ynhp1Zr++8cl8TddpD0tm7rHLSJI4AphoY3ZCTTiRSU7xjZLzLXGhT3/QdkIrbtekydw3arhnDNWu0lSYK/Xjaiwch8j0UHaXXUvx+4o+Vv88gvFj4f/OVSlcjWUHjyU+aClYv1qv7ZlKS5oXX4l6R+CTxq9mWjPXb7K4+9tXmmX8NmwmWcA4EnO2iAmaYKEcXMbYnmYZyV7qLCCel823A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:30:13 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 08:30:13 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>,
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Auto-register/unregister dl_server reservations
Date: Tue, 26 May 2026 10:27:55 +0200
Message-ID: <20260526082954.550958-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526082954.550958-1-arighi@nvidia.com>
References: <20260526082954.550958-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS2PEPF00004554.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::516) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 720ca8c4-b062-4266-1264-08debb0101e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|11063799006|6133799003|5023799004|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	E6YucI/4+YIq5hkC0WI+2az5pokyMt5JH7ZnhfyV9HGvZQuU44ngciJj1o1jmLCurQMWTATbsNo9jGscr1K9Q0yPfuQvP6uKuOrQI957hwcLfa2AkOAsXYHwY68nt1hEso2n9NV77GCN9axG3OVTlQp+cF+xn7coLwCSKrXXAhy25LSYmNTz7N3+/knDtVeKYrc+n7jcBG/3nO3oTf08ISjwRsqS0V+usfNn5AJgq/G+V3jB4jDwe9N4WYBNeXDL+hBUtrTJhBSgd7gdNdCusJac4Uaj7IHJSfUMo6R0NHZvDkwW+eLNVuMrjzTDEp103R8BPCzCrovx+JMOL9yryb0Drzar/ZKBLCcUsX7Py3wAaDhxtjaG2GSrAb+PETxNil5osHjFvL39Rkx1+DEvHs1XMXUvPg8gaCzGNVOV8VBOi7X+euxch+p97tRna2M/v8snIDjoqqIGd+xlaoSVUoft6qwuhyvTFI9F3pjs3DevoWSaxFoi3nvfZiOXJonwWK5v88gAUZxta3MoVVmRm+lEII6c3tRj6nEfijkFuYdQhoTXYOn3mfGtFVbwcLEFK6x3PNwxXanv2U9blQzC624F9Zr75kOq56GrAcZUz/g74L75wFLP7HsdCqKANkE4QLHibjThE2kvHe7yUNWD+S7b/HKtYhgpskIcknnKisTWz2ZWYqCsXMNbTaqnwZn1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(11063799006)(6133799003)(5023799004)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Tv9SCI54f+cFQqKjAO+9VsAVlOWaPBPs0NtDo3XWVlDsAodgBlxMRkJMsct?=
 =?us-ascii?Q?udwN6jgMTqZPv4aJIpCdk0azjgy8uG8E7lSDdxPafBHYLfjwovKfMmKwtAqW?=
 =?us-ascii?Q?5/lK0eUIRKS1apXIdLhtkyfACPc5pzj9i9Tk1AplEhd2pcQjPvb1mnj3ewj6?=
 =?us-ascii?Q?4HlxgBKjN9R/bHpc54cPWq/7Yz3WagsE9fKadT6twuDHTz5NmGYwJCGploHp?=
 =?us-ascii?Q?k50UJH+aM4143BWnyyvWX95QNDUgEy017sbBzEpFJTzfZD10vfSKtz1agGQp?=
 =?us-ascii?Q?E9N57fBN3+3iwEw1JXWEiPljS2xvHoEA6XVTj9S6mcBh4Kkf5u/mGugCNa5+?=
 =?us-ascii?Q?nUShhSq28Q6s9AnSfwuMx8ArFxaSODjkK2cgQ/cge3P21miZX1srnFC4zHnq?=
 =?us-ascii?Q?6ckJ80J4mugUOt+xI4i5DVk65Mf6wuo/KD/YCim3jFFeWpAILdm6sQkCss0V?=
 =?us-ascii?Q?xpQG5LUyT6OdlLtBCb29tE6c+Qs9i2eu2razB95jEEI+iCj3a/0DQc49zdze?=
 =?us-ascii?Q?bgZnxhbVCwkUNwiqmDawpwWv7ypqqBbEtUY5GSR84sN0tbaCrbDDXw7YztBH?=
 =?us-ascii?Q?9tWucC05baSvW+MUXobRejIfDQYeju/9Fno8ZpmjPrQeh8jZe4AJumRgBrk4?=
 =?us-ascii?Q?+yo6A0duJcK8PNbFCzUvZPIYtM4HBvuvbe1LZVsEuetLvMr1YvNR1GCTRdnH?=
 =?us-ascii?Q?LNvhpQus+8wp5F9nWVint8Ic6bxxYh1Djk6GHokPrmFJ6+Faup8m8Wf1QCrX?=
 =?us-ascii?Q?mz/7bq4Wi6wezGlNR8DaeETv+NpcULc2MTg1qyNP9rVuCH7zLP6VE5F/HIQ7?=
 =?us-ascii?Q?SDbyMMl82n4A9BxhSIH/AwlyO51ES1YmpPbOI2FoJvBCb4YQz+7orqeJ+8C6?=
 =?us-ascii?Q?VKY2fcJCXxLRJOcEvgkgqzyIJpBMke+pZd0e7Vgq2c11i/O8iMxrITi3orwT?=
 =?us-ascii?Q?3hexLkjOeuI1mYrsIp/M/mW/HoJDyk632u2EVmXMLrPEShFy2IxAUFqP4URw?=
 =?us-ascii?Q?zet+yIvkyJrRcgg2sSZptaNwf//PFj8pRZY9rC/d3Oc55bGqV1KbXALeP8Qq?=
 =?us-ascii?Q?PjfjOrvep93Zu9akEcOiHaLSUCXeOaMNXrJZtOs+cUW5eh9st4qTRTKH1Mhh?=
 =?us-ascii?Q?UdvIMKbVFEpTyd4vTQqKB8PF5oIHsHC7gvzR+swRQ7teClRaqYoiWcZREC85?=
 =?us-ascii?Q?W6DpUoXU0rFz5qRszUFBi4gAnQqiYUXtYLMb5T71MsOctBT6gBqHU5lqLS8I?=
 =?us-ascii?Q?hQ4m96KhTat5i6CVEdI80v7d4MH6+2cR/lgXAZ6vwP2x2JTmWCOVqFFttRxc?=
 =?us-ascii?Q?pJ8C0LHfRtVGWVCnWEtkWSHL2LU3CTNHI1MijNuU+sKLshbqrb3kanbdhucp?=
 =?us-ascii?Q?uCNRNwW0w8RbygRvu91bOQQQviUP6pmn4+6J8C5xrP92LWD6N6XNGh3xz17u?=
 =?us-ascii?Q?mqrK1PNN968f/E3ZaHh1UJQFQlEdpwJKS+ktep/kC0jRI7Orq7JxLfYFmTMA?=
 =?us-ascii?Q?ThcReNoYE9NfEtXRNTP2Ri+c9J14qm4a2Ny0UKCF/G96o4p51+BmRIFQ/Apw?=
 =?us-ascii?Q?3v6gZctAo+B1dSe5EYxzklmkpKZmH8q488A8MYdWv0c/8cK2ZVVwFZOfhxS2?=
 =?us-ascii?Q?pQzBLwVuhYrBUJmSBggJ4PpGzgEd3xpLq9VB7vkg/r1OWcMweJ49bmsaEjZJ?=
 =?us-ascii?Q?n8mL6aE85w0/tXJuyAy+2GIiqSiHhJFqUJettefwAwtTKbft?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720ca8c4-b062-4266-1264-08debb0101e3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:30:13.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OenKKsIE+KKfsO6wc2EJ/USkeUa9C/0zMfjGT8d5GhyNd8+El30B7t+eCp5LHhbB6h/MZGlEV7HjkLe/WeV5xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586

Commit cd959a3562050d ("sched_ext: Add a DL server for sched_ext tasks")
introduced an ext_server deadline server to protect sched_ext tasks from
fair/RT starvation, mirroring the existing fair_server.

Currently, both servers reserve their 50ms/1000ms bandwidth at boot,
regardless of whether a BPF scheduler is loaded. Unused bandwidth is
still reclaimed at runtime by other classes, but the static reservation
prevents the RT class from implicitly using that headroom when one of
the two classes is guaranteed to be empty.

A sysadmin can work around this by writing
/sys/kernel/debug/sched/{fair,ext}_server/cpu*/runtime, but that
requires manual action and not all systems expose debugfs.

A better approach is to make server bandwidth reservations dynamic: only
the scheduling policy that is currently active should register its
reservation, while the inactive one should not artificially hold
capacity (keeping both reservations only when the BPF scheduler is
running in partial mode):

 +---------------------------------------------+-------------+------------+
 | BPF scheduler state                         | fair server | ext server |
 +---------------------------------------------+-------------+------------+
 | not loaded (default boot)                   | reserved    | none       |
 | loaded full mode (!SCX_OPS_SWITCH_PARTIAL)  | none        | reserved   |
 | loaded partial mode (SCX_OPS_SWITCH_PARTIAL)| reserved    | reserved   |
 +---------------------------------------------+-------------+------------+

To achieve this, introduce an "attached/detached" state for each
deadline server, so the kernel can decide whether a server's bandwidth
should be accounted in global bandwidth tracking.

At boot, the system starts with only the fair server contributing to
bandwidth accounting. When a BPF scheduler is enabled, the ext server is
attached and may replace or complement the fair server depending on
whether full or partial mode is used. When sched_ext is disabled, the
system restores the previous deadline bandwidth values and behavior.

The transition logic ensures that switching between scheduling modes is
consistent and reversible, without losing runtime configuration or
requiring manual intervention.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched.h   |   6 ++
 kernel/sched/deadline.c | 207 ++++++++++++++++++++++++++++++++++++++--
 kernel/sched/ext.c      |  71 ++++++++++++++
 kernel/sched/sched.h    |   4 +
 4 files changed, 280 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ee06cba5c6f53..7acceb80628b0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -702,6 +702,11 @@ struct sched_dl_entity {
 	 * running, skipping the defer phase.
 	 *
 	 * @dl_defer_idle tracks idle state
+	 *
+	 * @dl_bw_attached tells if this server's bandwidth currently
+	 * contributes to the root domain's total_bw. Only meaningful for server
+	 * entities (@dl_server == 1). Allows toggling the reservation on/off
+	 * without losing the configured @dl_runtime/@dl_period.
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;
@@ -713,6 +718,7 @@ struct sched_dl_entity {
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
 	unsigned int			dl_defer_idle     : 1;
+	unsigned int			dl_bw_attached    : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7db4c87df83b0..dc46e807a8fa1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1793,7 +1793,8 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	struct rq *rq = dl_se->rq;
 
 	dl_se->dl_defer_idle = 0;
-	if (!dl_server(dl_se) || dl_se->dl_server_active || !dl_se->dl_runtime)
+	if (!dl_server(dl_se) || dl_se->dl_server_active || !dl_se->dl_runtime ||
+	    !dl_se->dl_bw_attached)
 		return;
 
 	/*
@@ -1868,6 +1869,13 @@ void sched_init_dl_servers(void)
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
+
+		/*
+		 * No BPF scheduler is loaded at boot, so the ext_server has no
+		 * tasks to protect. Detach its bandwidth reservation, it will
+		 * be attached when a BPF scheduler is loaded.
+		 */
+		dl_server_detach_bw(dl_se);
 #endif
 	}
 }
@@ -1878,6 +1886,9 @@ void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
 	int cpu = cpu_of(rq);
 	struct dl_bw *dl_b;
 
+	if (!dl_se->dl_bw_attached)
+		return;
+
 	dl_b = dl_bw_of(cpu_of(rq));
 	guard(raw_spinlock)(&dl_b->lock);
 
@@ -1903,13 +1914,16 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	cpus = dl_bw_cpus(cpu);
 	cap = dl_bw_capacity(cpu);
 
-	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
-		return -EBUSY;
+	if (init || dl_se->dl_bw_attached) {
+		if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+			return -EBUSY;
+	}
 
 	if (init) {
 		__add_rq_bw(new_bw, &rq->dl);
 		__dl_add(dl_b, new_bw, cpus);
-	} else {
+		dl_se->dl_bw_attached = 1;
+	} else if (dl_se->dl_bw_attached) {
 		__dl_sub(dl_b, dl_se->dl_bw, cpus);
 		__dl_add(dl_b, new_bw, cpus);
 
@@ -1929,6 +1943,181 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	return 0;
 }
 
+/*
+ * Add @dl_se's bw to the root-domain accounting.
+ *
+ * Return -EBUSY if attaching would overflow root domain capacity.
+ */
+static int __dl_server_attach_bw_locked(struct sched_dl_entity *dl_se,
+					struct dl_bw *dl_b, int cpus)
+{
+	struct rq *rq = dl_se->rq;
+	unsigned long cap;
+
+	/*
+	 * Always update @rq->dl.this_bw, but only update @dl_b->total_bw
+	 * (and run the overflow check it gates) while this CPU is active.
+	 *
+	 * This mirrors dl_server_add_bw() during root-domain rebuilds, which
+	 * only publishes bandwidth from active CPUs into @dl_b.
+	 */
+	if (cpu_active(cpu_of(rq))) {
+		cap = dl_bw_capacity(cpu_of(rq));
+		if (__dl_overflow(dl_b, cap, 0, dl_se->dl_bw))
+			return -EBUSY;
+		__dl_add(dl_b, dl_se->dl_bw, cpus);
+	}
+	__add_rq_bw(dl_se->dl_bw, &rq->dl);
+	dl_se->dl_bw_attached = 1;
+
+	return 0;
+}
+
+/*
+ * Drain @dl_se and remove its bw from the root-domain accounting.
+ */
+static void __dl_server_detach_bw_locked(struct sched_dl_entity *dl_se,
+					 struct dl_bw *dl_b, int cpus)
+{
+	struct rq *rq = dl_se->rq;
+
+	/*
+	 * If the server is still active (on_rq), dequeue it via
+	 * dl_server_stop(); task_non_contending() will either subtract
+	 * @dl_bw from running_bw immediately (0-lag passed) or set
+	 * dl_non_contending and arm the inactive_timer.
+	 */
+	if (dl_se->dl_server_active)
+		dl_server_stop(dl_se);
+
+	/*
+	 * Drop @dl_se's contribution from this rq's bandwidth accounting,
+	 * mirroring the __add_rq_bw() done at attach time.
+	 */
+	dl_rq_change_utilization(rq, dl_se, 0);
+
+	/*
+	 * Update @dl_b only while this CPU is active, matching
+	 * dl_server_add_bw() during root-domain rebuilds.
+	 *
+	 * If this CPU is inactive, its bandwidth is not currently accounted in
+	 * @dl_b->total_bw: either attach skipped adding it, or a rebuild
+	 * already dropped it while re-publishing active CPUs only.
+	 *
+	 * In that case there is nothing to subtract from @dl_b. Just clear
+	 * @dl_se->dl_bw_attached; if the CPU becomes active again, the next
+	 * rebuild will re-publish its bandwidth.
+	 */
+	if (cpu_active(cpu_of(rq)))
+		__dl_sub(dl_b, dl_se->dl_bw, cpus);
+	dl_se->dl_bw_attached = 0;
+}
+
+/*
+ * Attach @dl_se's bandwidth to the root domain's total_bw accounting.
+ *
+ * Use to dynamically register a dl_server's bandwidth reservation while
+ * preserving its configured @dl_runtime / @dl_period. No-op if @dl_se is
+ * already attached.
+ *
+ * Returns -EBUSY if attaching would overflow the root domain capacity.
+ */
+int dl_server_attach_bw(struct sched_dl_entity *dl_se)
+{
+	struct rq *rq = dl_se->rq;
+	int cpu = cpu_of(rq);
+	struct dl_bw *dl_b;
+	int cpus, ret;
+
+	if (dl_se->dl_bw_attached)
+		return 0;
+
+	scoped_guard (raw_spinlock, &dl_bw_of(cpu)->lock) {
+		dl_b = dl_bw_of(cpu);
+		cpus = dl_bw_cpus(cpu);
+		ret = __dl_server_attach_bw_locked(dl_se, dl_b, cpus);
+	}
+	if (ret)
+		return ret;
+
+	/*
+	 * The natural 0->nr_running transition that triggers dl_server_start()
+	 * may have happened while @dl_se was still detached (e.g., between
+	 * scx_bypass(false) and the scx_enable() re-balance loop), so kick a
+	 * start here.
+	 *
+	 * dl_server_start() bails out cleanly if there's nothing to schedule or
+	 * it's already active. Skip if @cpu is offline; the server will be
+	 * started naturally on the first enqueue once @cpu comes back.
+	 */
+	if (cpu_online(cpu))
+		dl_server_start(dl_se);
+
+	return 0;
+}
+
+/*
+ * Detach @dl_se's bandwidth from the root domain's total_bw accounting.
+ *
+ * Use to dynamically unregister a dl_server's bandwidth reservation while
+ * preserving its configured @dl_runtime / @dl_period. No-op if @dl_se is
+ * not currently attached.
+ */
+void dl_server_detach_bw(struct sched_dl_entity *dl_se)
+{
+	int cpu = cpu_of(dl_se->rq);
+	struct dl_bw *dl_b;
+	int cpus;
+
+	if (!dl_se->dl_bw_attached)
+		return;
+
+	dl_b = dl_bw_of(cpu);
+	guard(raw_spinlock)(&dl_b->lock);
+	cpus = dl_bw_cpus(cpu);
+	__dl_server_detach_bw_locked(dl_se, dl_b, cpus);
+}
+
+/*
+ * Atomically detach @detach_se and attach @attach_se on the same rq, holding
+ * @dl_b->lock across both operations so a concurrent sched_setattr() cannot
+ * steal the bandwidth freed by the detach before the attach can claim it.
+ *
+ * Both entities must live on the same rq (same root domain). Returns the
+ * result of the attach: -EBUSY if attaching @attach_se would overflow root
+ * domain capacity (in which case both servers end up detached).
+ */
+int dl_server_swap_bw(struct sched_dl_entity *detach_se,
+		      struct sched_dl_entity *attach_se)
+{
+	struct rq *rq = detach_se->rq;
+	int cpu = cpu_of(rq);
+	struct dl_bw *dl_b;
+	int cpus, ret;
+
+	WARN_ON_ONCE(attach_se->rq != rq);
+
+	scoped_guard (raw_spinlock, &dl_bw_of(cpu)->lock) {
+		dl_b = dl_bw_of(cpu);
+		cpus = dl_bw_cpus(cpu);
+
+		if (detach_se->dl_bw_attached)
+			__dl_server_detach_bw_locked(detach_se, dl_b, cpus);
+
+		if (attach_se->dl_bw_attached)
+			ret = 0;
+		else
+			ret = __dl_server_attach_bw_locked(attach_se, dl_b, cpus);
+	}
+	if (ret)
+		return ret;
+
+	if (cpu_online(cpu))
+		dl_server_start(attach_se);
+
+	return 0;
+}
+
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
@@ -3236,12 +3425,12 @@ static void dl_server_add_bw(struct root_domain *rd, int cpu)
 	struct sched_dl_entity *dl_se;
 
 	dl_se = &cpu_rq(cpu)->fair_server;
-	if (dl_server(dl_se) && cpu_active(cpu))
+	if (dl_server(dl_se) && dl_se->dl_bw_attached && cpu_active(cpu))
 		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 	dl_se = &cpu_rq(cpu)->ext_server;
-	if (dl_server(dl_se) && cpu_active(cpu))
+	if (dl_server(dl_se) && dl_se->dl_bw_attached && cpu_active(cpu))
 		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
 #endif
 }
@@ -3250,11 +3439,13 @@ static u64 dl_server_read_bw(int cpu)
 {
 	u64 dl_bw = 0;
 
-	if (cpu_rq(cpu)->fair_server.dl_server)
+	if (cpu_rq(cpu)->fair_server.dl_server &&
+	    cpu_rq(cpu)->fair_server.dl_bw_attached)
 		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
 
 #ifdef CONFIG_SCHED_CLASS_EXT
-	if (cpu_rq(cpu)->ext_server.dl_server)
+	if (cpu_rq(cpu)->ext_server.dl_server &&
+	    cpu_rq(cpu)->ext_server.dl_bw_attached)
 		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
 #endif
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 83272acf17637..2330657bd66f3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6112,6 +6112,7 @@ static void scx_root_disable(struct scx_sched *sch)
 {
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	bool was_switched_all;
 	int cpu;
 
 	/* guarantee forward progress and wait for descendants to be disabled */
@@ -6138,6 +6139,8 @@ static void scx_root_disable(struct scx_sched *sch)
 	 */
 	mutex_lock(&scx_enable_mutex);
 
+	was_switched_all = scx_switched_all();
+
 	static_branch_disable(&__scx_switched_all);
 	WRITE_ONCE(scx_switching_all, false);
 
@@ -6187,10 +6190,34 @@ static void scx_root_disable(struct scx_sched *sch)
 	/*
 	 * Invalidate all the rq clocks to prevent getting outdated
 	 * rq clocks from a previous scx scheduler.
+	 *
+	 * Also re-balance the dl_server bandwidth reservations: detach
+	 * ext_server (no more sched_ext tasks) and reinstate fair_server if it
+	 * was previously detached because we were running in full mode.
+	 *
+	 * Unlike the enable path, this runs on a recovery path that cannot
+	 * fail, so we use dl_server_swap_bw() to atomically free ext_server's
+	 * bandwidth and reclaim it for fair_server under the same dl_b lock.
+	 *
+	 * The swap can still fail with -EBUSY if someone bumped ext_server's
+	 * runtime via debugfs between enable and disable; in that narrow case
+	 * both servers end up detached and we just WARN.
 	 */
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
+
 		scx_rq_clock_invalidate(rq);
+
+		scoped_guard(rq_lock_irqsave, rq) {
+			update_rq_clock(rq);
+			if (was_switched_all) {
+				if (WARN_ON_ONCE(dl_server_swap_bw(&rq->ext_server,
+								   &rq->fair_server)))
+					pr_warn("failed to re-attach fair_server on CPU %d\n", cpu);
+			} else {
+				dl_server_detach_bw(&rq->ext_server);
+			}
+		}
 	}
 
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
@@ -7233,6 +7260,31 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable;
 
+	/*
+	 * Attach the ext_server bandwidth reservation before anything is
+	 * committed so that we can fail the enable if the root domain cannot
+	 * accommodate it. The matching fair_server detach is deferred to the
+	 * tail of this function, after the switch is fully committed and can no
+	 * longer fail.
+	 *
+	 * On failure, err_disable funnels into scx_root_disable() which
+	 * detaches ext_server, so partially-attached state is cleaned up
+	 * automatically.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		scoped_guard(rq_lock_irqsave, rq) {
+			update_rq_clock(rq);
+			ret = dl_server_attach_bw(&rq->ext_server);
+		}
+		if (ret) {
+			pr_warn("sched_ext: failed to attach ext_server on CPU %d (%d)\n",
+				cpu, ret);
+			goto err_disable;
+		}
+	}
+
 	/*
 	 * Once __scx_enabled is set, %current can be switched to SCX anytime.
 	 * This can lead to stalls as some BPF schedulers (e.g. userspace
@@ -7387,6 +7439,25 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
 		static_branch_enable(&__scx_switched_all);
 
+	/*
+	 * Detach the fair_server bandwidth reservation now that the switch
+	 * is fully committed. In full mode (!SCX_OPS_SWITCH_PARTIAL) no
+	 * task will ever run in the fair class, so give that bandwidth
+	 * back to the RT class. The matching ext_server attach already
+	 * happened earlier; this only releases bandwidth and cannot fail.
+	 *
+	 * In partial mode keep fair_server attached.
+	 */
+	if (scx_switched_all()) {
+		for_each_possible_cpu(cpu) {
+			struct rq *rq = cpu_rq(cpu);
+
+			guard(rq_lock_irqsave)(rq);
+			update_rq_clock(rq);
+			dl_server_detach_bw(&rq->fair_server);
+		}
+	}
+
 	pr_info("sched_ext: BPF scheduler \"%s\" enabled%s\n",
 		sch->ops.name, scx_switched_all() ? "" : " (partial)");
 	kobject_uevent(&sch->kobj, KOBJ_ADD);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d1..6d7eae73a6c00 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -421,6 +421,10 @@ extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
+extern int dl_server_attach_bw(struct sched_dl_entity *dl_se);
+extern void dl_server_detach_bw(struct sched_dl_entity *dl_se);
+extern int dl_server_swap_bw(struct sched_dl_entity *detach_se,
+			     struct sched_dl_entity *attach_se);
 
 static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 {
-- 
2.54.0

