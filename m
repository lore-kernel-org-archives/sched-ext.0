Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817F3D3013
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813886; cv=fail; b=sxtWdpfGU4UFctKqGEzqqDvDDhv+8KBA1nr43dw99NcHH0q2pvqRg/+ljAQfsdh/et4M6/MTMZziBJfKrFuJvjK0pqTas5LPYC9um02Xn8TfBQxboXoVqO1TusQXgG6wOnaGmXHsXpe5FqwlQDkL9LY7BmKJsek4eiSJhxD2IeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813886; c=relaxed/simple;
	bh=+2e0O6yrlPuJehyISohzHem5A1EpxpGZAJcIVQRlu9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4IfrB4b6zGAFbjOP4xRTCSvHiTKQ7TgcrmZX8VelNBA8lWf3fPavMWcRCfKpqglyvIxxWpYZHdbxgzTbXnvZMWkxjsNi1lDuv9smvI5KO4TiYTTpScjM5qEoZpmjlqIPls0eQO0I99Fx2xZhWjsMR7N0QVXKYVbBLu9Tv+ZZL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ccFsy5NN; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ccFsy5NN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XALJ5QMOUxlv5Tssh0XNHibJAKcLQEWkVkX0vLyWqefMpEkZZvFH+3abeX+PpwcVOv58QptMaBaPKVhbGpSB3+r5IMOt1b9RmzBvBIZ8f8wVFfxhAaYB7+ank09X2kYC0b2cEEIGY3pqAFNAX79Hz4+/AtLWNTqncH6Mx18dN7Mfk6FyIT8glH4fSCr6w1VrYURxnkVhncliKjgMHLPk3TS0xi9Dan+cXoxz7PaN9W4D6fnVSMLtbRe/cRconaeTTNF7PIpr5Yu729gur6C4lKE5exRBUD9NPIfajabixtjGdstdLSSFnTr8zOlnhxHpVgVawKup2ejUz1YcAGhOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiXM1n5IQEirucl57ahfdRW8fvQD7YAuqhENOeO4cQc=;
 b=fIRUzccDovbxsAGS9adfBP/8KafT0qLsIPr08wmJlCuit4BJbthJWV+RTQruGR0Ji2dgeTvNU57wRrIjuRfSc81OaeeGtcjQaWpKMTMMMR/Ey3ssrVCILOLJUOG/LPOIt7reATN8q9lzL3XCGIQuHVTzF9Zjgv4WRtdT+sS4H/AxkYeFJejW+HzGZcp6FU7ZvBgMqUxIdTOU7T31ibUNf1snQNifXobqbMY4iqAApe+9HRodbdmTV1Wnx5ZsudNWXcvyWf14Hb9l4wZXVJTVCYabDqtF+6aDad9XxwNlC2ZfQTcWA20Apq0gkvF+v2YmW6EYQcksh9NuLIA6tubpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiXM1n5IQEirucl57ahfdRW8fvQD7YAuqhENOeO4cQc=;
 b=ccFsy5NNVRY3yfxPA4eCtOG/8oQxjGNJwABny6GyEYHUQHAejZ3GEE46v5l3CJ2jcp4mzFxyThjYSmSvO7lZjn07d6h2fZrKd4dSm7LqikpUr1MXkY/V8zTpu3hPAQ1Dpqaym95TdhxdI+8odRUvmtydCWwE+DCCv5C7e7yQ7owIH4glwJwscX6muElE6uI7wWtOrRxp2tQv9R0PK32ZWrGnQdM8r2Jckx+0YxGslVtzNGkNMX7KBIKq3wolpqEyadarR954VLwW6mIZhsX6sTwL5ds0nRUrJYcD2JQDAXWTT9ryXEk6E5NIqjlDDQCD/4sN4DCGm4boGXZcY3NPbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 16:44:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 16:44:40 +0000
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
Date: Tue, 26 May 2026 18:42:48 +0200
Message-ID: <20260526164420.638711-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526164420.638711-1-arighi@nvidia.com>
References: <20260526164420.638711-1-arighi@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c602b0c-47fe-4aac-459e-08debb461443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099006|18002099003|22082099003|6133799003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	2GUlnT7GxOOWwHVOdYqUo1clru/+YkORr/zmzmfTByl9iQnY//C6XpmDD7XPCTe+gGN0VqAT+ruFkipwWihNuMbzpoz/TkQxOGuHar1EcGh5cOaiWzI9a89HHiGfu8g8R8UQwXAFqUli2BybIAZbgrsLRroM7wXiO9yPcy2n6aMjU7v0yFzpLVPWiGvI66XEs/PPGEiziMH/EPil+5Ftmobak2+4i43Huoze8a1PhT65/fluoQyrKFdpGnS332EIRlb8V2HW40tjNwfNsiYCAFS23u0S4HMuXG6GpRP1jLgwWALG8v3ep9meQtGXToxI4n82qo5X9SZelg5ZbN6oi2gK0tkJAlRwp7Mxv+/b1BWV3zWVDA8O+L3jMfQ0ZQw+gf0JT7j/AM7r0U1MOXS21v84VkXh5IBVAdIM0klKURQegYQZhfjoJqJ/vtZDcn0BK7Wro+NBfDzohDQ9/q8t0K7UyaniZ+Bm8ymzLDJcKFFUbBVAWAjVKu+j4DRW+GY60jg6TbO0V9TFS49xMrMPqdlgebru0vrvBBmm7OQmOaifB1vWqtgLSTfq1qyNoO8TNZA8sl9If9tElzoKS+Sbyic/RTpBuo3YWirUkSRqruUtNebvUZDALKD8Wmc3F9B9LtjoMze1Okie3v5LDLqsiTQZl8MVsoKUOzVENoe6TYLPv2cu6NbnMVsJ+R5O9WOQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099006)(18002099003)(22082099003)(6133799003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M7MFwEk/mnBdesVAHc01I2ytwgzpgy/M7CD//BCOrbzxP/8/MzMhspmyQfzc?=
 =?us-ascii?Q?QcDDexd/zOJ8wsJ9NiHXWqnqEuHgOb81yD3eIoyQ4aBvps3lkFBGbWJPwell?=
 =?us-ascii?Q?JNp70K4PL4wEcwpN2sjF8Ui0/+h4ZOsr0IRuF2YEKT1zEZcQooUflYnOJbYl?=
 =?us-ascii?Q?MGpIEYDmDD20Wb0VCwrCKsll5OwscitsatKYHbDLg0gHWgRQHJaGD4fF11B5?=
 =?us-ascii?Q?PyghSouoxUAJL2uILPAPL6QyZab6mY7gyUSWzpouJxRBUn91PmM2QujdJxYS?=
 =?us-ascii?Q?3tG8Qpp2OT50JvdY+1fZgk+tz80BTO3goMetPlqW5WYgoFAVZsKzPw8BndX+?=
 =?us-ascii?Q?95XEP/4RIn9xPf69ECo+aaGtEgHlZxomTxmEdqQOYnje5kt55EwtTdTi5hGL?=
 =?us-ascii?Q?GNQzQ59Y1htsKb3pRMyY8KHZuLAr9saysjYQgQQknD5ge424B1DjB3YPr5WZ?=
 =?us-ascii?Q?Xk2urUw1l7sHupDI6mLppucX0FhjMrWo9h5TI47Zzaed+3a424ib1ICk4zYi?=
 =?us-ascii?Q?n7rsIdGA2Jp4ZT5Vbc0IwtRX7mjsusrln7LaghlMjQ7iMqfENodD95u3nyAy?=
 =?us-ascii?Q?zmZx/Km6ZCwOGWAemFPoM4fWaTynacKkmeB+45lgmM2S7MJyCrCJTObWeGwG?=
 =?us-ascii?Q?QPR2LffcVUcGJQ0BL+T28Jy8TZU6Eo2Qx9As84IF+fYhk5pJ6m8dYQExO8ai?=
 =?us-ascii?Q?Cp+KNdkuPqxgUSXkXzHeRhgGidoSPZDOx9ybfUOp+Zd9mnhW0yddA5nZ2zfX?=
 =?us-ascii?Q?2ZvwcnhNwip59qYPh80gDPix9i1yFZrU36nlWZYO4xtyVwjnhxIQ3rqkWcap?=
 =?us-ascii?Q?dHT6gCcIYfXwF41GcMB5w1gM7apwx81qZ7vwTRs7FoY1wbObvrGXwR91sWel?=
 =?us-ascii?Q?/t2pKTf/H0G5eZd7yr/5qtIGQ582VuXv3HkmtTMdYcpeyEtU2KGssQC1And5?=
 =?us-ascii?Q?zna4Pr/OVxdOTJt0sDcLjEcFvvEVBoDTV049QZvL44OHspelgtukZ9evcC9k?=
 =?us-ascii?Q?H2d+WL8miU2PvFPh5q4vFDVhmusmxtG03i50xpd+zGptBca2lH0VqHtuyFOD?=
 =?us-ascii?Q?C7XtiT7/POrlVHz1unVQvixDqw0j1DtCJA/z+m0gtQBpIviiyF9SqLT608D3?=
 =?us-ascii?Q?tntks4SlY8ITyR9M/LJU+WU8rBJ+zgy9WOfUaGabIB5JrThJ60+nk4jpjX3/?=
 =?us-ascii?Q?BL0EVr73nRO62bfH8k5IWl32bpEbPVWsJ7KzyAnP0TrLNm+z2Jaghe/aB17m?=
 =?us-ascii?Q?KzLqB0elDwit6yGi48F8je2gCiRtuaPrsO977mqK3WCDC1nS2mrjOVnMQzxT?=
 =?us-ascii?Q?2A0gcWdp007qg3Q7RJiyM9A9bAYblK5YB5CP67xJBdylesdgh78u2HIgS34l?=
 =?us-ascii?Q?boWgOwcG1C7uYkbCb/l0wTIGtO1byE3rSOlyX06xlCZ4Gxpzakzf7hAbtDM0?=
 =?us-ascii?Q?VMJpiBjDKLoCzRO9lLKCFFZ1ZLwy+5f6O4ovBeqDfPKg4DKwGPeULlUNrboZ?=
 =?us-ascii?Q?d7VdEtFKIDjjOh5ghEnqLRrgdf5i0yLEgibH9Z5MUvys5+hWb7DmTsvPDnOA?=
 =?us-ascii?Q?e/YaBPSIlkP0o15It/rDtSVBIRxemBzkMrGvinUTluzeGp3edMjBsAe9Qsys?=
 =?us-ascii?Q?dXVZ5T/jY074r5lPPVA2C4wMLW0upF+cHDFEPK5PzuXvZc6rPFFoiaoiPvh7?=
 =?us-ascii?Q?S8Kbx+8ZEpH8eJ24z+WfwvSpRnZtxaoS1e5f8JT2nzdS9NaV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c602b0c-47fe-4aac-459e-08debb461443
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:44:39.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJ+TAAy8cCOtUbi9TAK4bF/4z3zwqTQWFQTSn0lVKVgGBs5Jx4ex1TAizrnSPHQp6Hi+n6izgkvYtEMWaTY+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

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
 kernel/sched/deadline.c | 204 ++++++++++++++++++++++++++++++++++++++--
 kernel/sched/ext.c      |  71 ++++++++++++++
 kernel/sched/sched.h    |   4 +
 4 files changed, 278 insertions(+), 7 deletions(-)

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
index 7db4c87df83b0..5672f9c583982 100644
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
 
@@ -1889,7 +1900,8 @@ void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
 
 int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
 {
-	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+	u64 old_bw = (init || !dl_se->dl_bw_attached) ? 0 :
+		     to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	u64 new_bw = to_ratio(period, runtime);
 	struct rq *rq = dl_se->rq;
 	int cpu = cpu_of(rq);
@@ -1909,7 +1921,8 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	if (init) {
 		__add_rq_bw(new_bw, &rq->dl);
 		__dl_add(dl_b, new_bw, cpus);
-	} else {
+		dl_se->dl_bw_attached = 1;
+	} else if (dl_se->dl_bw_attached) {
 		__dl_sub(dl_b, dl_se->dl_bw, cpus);
 		__dl_add(dl_b, new_bw, cpus);
 
@@ -1929,6 +1942,181 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
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
@@ -3236,12 +3424,12 @@ static void dl_server_add_bw(struct root_domain *rd, int cpu)
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
@@ -3250,11 +3438,13 @@ static u64 dl_server_read_bw(int cpu)
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

