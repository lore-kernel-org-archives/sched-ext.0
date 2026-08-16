Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEA353EF7
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901899; cv=fail; b=p+J2yP2D7fNJJ8OgJoTJM6LAz2CUhvTEtPBllgZApCoFWRH/LY+GRUn/EuOMdDOscReyEmuiktZrYBjwljXbsE/BXtTvXGJI9tHLLx7I1VGvoRljSkmFy4pB0ih1fXhYnJ+8AfmoGicQnWGUr738JJwRpmoDARdwwtQCsyx3Z84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901899; c=relaxed/simple;
	bh=t/IMZf/ajlhPfu0XOXO6sx7GI9eszofMk05hOSEWVBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HyR4d1qby65fPY/0tuXR03fYps5Py6b131jWwKZ5CD2O7xwpWBMOGEHXShDq94c7TzfMHEnTZN4bBNa3JxifR75QhFExLGhgISF8YMSnHj/sfS6PmboZoJfGFULrGYwIbPePddXZekY9DtSYogeYGZsaq4nXx1whS3QPNTkNhYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Me2Y74Dt; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Me2Y74Dt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flZl8ocMWQbMzReYoDnYzcy7GIaxl2B98MsPbwV3dEXjsQ/iSlYRpr9Ge6t4EPnYsCVhyjr4sYV03gjUZQ64b3dfOIc0vwADEeg5jSdA5y8RSmIEh9FsFc2aRts06cokKvltE570P+1q+q7vgKbBYob83rxszkyrRu5EJWaWAV/QQpruE8gSLLslJhwUh4L2jGiQQHBTFWYP1DgEZu3hNeux2Evp8r32wMXjxzB2YYe5vbslgg8MzAhPAJ9iDMZNGwVTznDi8a57T0a2CUW9aUDQwAnX6Kn7WQZerqYpQgnWq+/dl22Q9ho5QfrrJqC0JY416Hawq8Q1cm8kM3Ftpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqCeRn0bQj7gy+hAvOe6H7xMzJAv6iQ2qP7eITLsChU=;
 b=hfZgNGa49dheJNEuefS6E3vKxAO9YfGHJulNaDKkSn0U84OqAV6JDRY4cLjYagkQoyqivP8W6Y0hHgpgFrqpGC22WNLqEYQIAiBnPNM6Hrz8qXUOE4qkowy4zfIPsa/xIkPObK18BEQuDdDdceZ5iAp+aXH6v4Wlsg8JNLnDGFpkhmkAE+uFqlWDU7DqilUbv9Fr2aKeYIK1gahojGlKYo2pkqz1m2n0vVvwMY/Wsz9ZsF+gaRvGcu+psaN9NmoHnvaIto+k7VAA9d1oGSCV+1SWwGfSzpE9t5dThHojSQNkKzsZ3eD1v5IDPgHxfD8J8cjoUAH9pBW9+sSTS2BbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqCeRn0bQj7gy+hAvOe6H7xMzJAv6iQ2qP7eITLsChU=;
 b=Me2Y74DtW4DHhGWbF+yl9pkegsm75pZrOTLjXrSKpiCto5VwXRdQzruEKxrmwuLxYk4u6wtGjwFFDjZJLYlOqi2apKsSxs9DESS3cYNARC40bP0SymfOo7xnlDnq3XzajGkAhXddLd5qNC7v5ClUi6QFlSn67XfMI6qcc8Z6mmUZgKqXUpqFWt1GZK/BTthCxKYVJtDRaHqbQjhQbMLtNSE0S4qIpvN9Ahi7sAoUiyPLVfBxKR6XskJjhg6GX0FnMxLrMI1Y5itkv0xbXWlmutPEzHvEYDr+8PLI/qmyL9RUugFsC0exTion2IMgfd564xNdf4K1iPPzAOzt2m2+rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:13 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:13 +0000
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
Subject: [PATCH 09/17] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Sun, 16 Aug 2026 19:35:07 +0200
Message-ID: <20260816173732.17162-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8280fdd9-a1df-4f14-fd76-08defbbd25e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hyKxEYUQD8I/k4VWLOxgdzRa/eSWd1SICc3qFfnxcHGYpsM4c8Lf/1+mALltq9z23VXR4kXmrY021yJR4IoKC6sOSphsaXHsj0RoToMaSKNK9j7r4Skpgq0tebNWFf/dgDnQhJG5QY5Ld0QxGTnDp8b0lOpO3/xDOVoMmnGtA5lJb3FImdjg5rlPofKNIfVbeiWDsXEgm/Pjvzn0FiLfIrQVeXbQSTItZ0TDm0KGjdxZLakxfIRQrdHPFU0/eX0AnlLBIlHVGvHY3cLImjhxLso2e/YbiCIpDoF/i0+5B7rkk2pngA/2RL25FtaNurBT7oTsjXOUaY+hkB2Sg3CovN1Q+Eh/xmbLBrOOmVqKe/df7mfirnUm5Dxn+IPbUc+FAxtrI9b4IOnJiCb+XGA623BROHl5wAu2qauQhKzS53piqrjBAYfUW3XSDuK/sKy0f66TV5TezE964BjmeLYCFXNgXRtIz8wDIBAmo4hmehN09Wiq17MjsHDVFDAotAWsAqNRQO11HmuMIeTqLmp/Npg2Bt1WbE8aA4cCte1LhYjFpkFgWwgPCzHtmh4YlgZ8QmtTpNUpxJe3/UPqujpSl12GZv5AXt9j3ATj3dIOSn4trQQ69Un+eyw6XU4MqTnYMbb+wI+vVSgZzexdS1hIXMPQMWcIsGVu1znBG3ILfcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QinhIhND4HoXbFRg27n2HHxn+VGn3pSYBuYuysjQA2ZgcjIVwHdskg9pOBpG?=
 =?us-ascii?Q?JdgMXE6zxeBeC47V3NTKhjEwdEjA+jpqavZKfAm0SOqcDw7cda0ddHUIOC1M?=
 =?us-ascii?Q?UB9w2n0EfH4pr52GUxYrg1v90yvde6tPWwHv8ggILkwanCRf8T766j9KAnO/?=
 =?us-ascii?Q?LLVzlTQEQEGNns6oj2R/2m6X/RlvNx5CNLIcDMd+QOASIU6DaOXx6FNReZQo?=
 =?us-ascii?Q?lQExnyL90UvND+efCG4gmTAMvPOAxo2UDr8hYCw/zz9sbEJpcYdCHB7SzYLg?=
 =?us-ascii?Q?7fLIeh8UvHNK5xV+tzbl7V4ZeZbG/HtYMB2cUEzJBpJO7dVScnPu9MpnIQBz?=
 =?us-ascii?Q?RSEmUl7dWiJRnYoXHPrrCcHJgUXb1vbp3nbNlY2IuAEvOk4eoEwldiCDN8wm?=
 =?us-ascii?Q?zwUf0TvoMZb1up2hrfbzoYYJ068mPg7ptUxoN9ZDEsz4yIkp27oS4aB2Fk0P?=
 =?us-ascii?Q?U662MS2tyHVcotkCNykxCDUDzBEnJH9jQ4nNlyB2HFaLxgmIg5ZqsvarREyQ?=
 =?us-ascii?Q?eYTBXDQHSGmNtaZZ+ZOJiOlk9zswfML97ZC+vTyRRqOUZSElShAv4k0y6NzS?=
 =?us-ascii?Q?S9Wsgo+A7fFp+cMT3gyFsDvGFTYzhBloKmWqOOfjnznAAhUSx1oXgyPjw6kt?=
 =?us-ascii?Q?hik0aRWU0lczt0xEOHtT3rzF/8HaLkr1yUW2rjaUxzyLJOOzZfmlkgSD4Nnw?=
 =?us-ascii?Q?dvEqcadl0pGPMUCTATJAQebPf00ofc6JdpHFlQfgzaT9LS24QSp+HCD+3rcd?=
 =?us-ascii?Q?t3Qgui1MlvIA7kxW9uXDd2etwfVflHk1D/V8zS6GEp/pKkDxUTEw9i12TLwR?=
 =?us-ascii?Q?gU0GsQ7P7j0aHjMUiUZXOXkINWuMnmD4rTcJGz4Hp+bLiZcNrAvlEsnv80pq?=
 =?us-ascii?Q?NiYjdf5bIPDNc2A2dPB7ohaGAiMGX016ro9Xx/NP3PNyPg5afg+9gIJFyH5b?=
 =?us-ascii?Q?Y4dvuVGVZd1x4glpCWjN+2WmWwI88LpDqN08Scm4h0CucJtIWx/l9J1u7pf9?=
 =?us-ascii?Q?V00Q5ZWU/IH4xocQ/ZA5Hq1NCscMevPsOkYGIkKCsBdsUQS5B1C5pNO9G0T2?=
 =?us-ascii?Q?Zpd+GM0yd0eAfmmKhh/J51WUKF20zIANDHjqcYVBJOspHIA59h3fY0S0UxmL?=
 =?us-ascii?Q?4qwva9OP15jPPhsi4ale4yJEYySBcxNK5u1Sus/p0mgGOguC0TzG+QeT0h8f?=
 =?us-ascii?Q?+c2F97aCvbgBhAkfiC18iGA6XxVCKcpEMMgyz/iSicdLwJHnfg+07ZXnfBf6?=
 =?us-ascii?Q?r44NbN2AbdEkg7AbGDsD1lvUT1d5dc1sWLbXrcrt4qVvV+EPsRLA4cCAMW5H?=
 =?us-ascii?Q?aDXXPmnalNgFKWAVdkHsspJfDAPNNHY2zW3E6eKFL7FlkREfOCEpvTUYY4c0?=
 =?us-ascii?Q?BoH7d9d7xG9I1K20G9cXYSDiTCPtQHTd9zWHIcyuhLZ4LjBKn17KFYOiimVo?=
 =?us-ascii?Q?pBsIYgwwlD0VxIzq/2rzjDZErXEqkNriBGOZN8viBa5Xb0lfIrx5VYttHiBL?=
 =?us-ascii?Q?gzKwu4BF92RVgupkNvhcOfAl3jnVgmsW/NKxIHVPsM1/bBxde4HIq4tMfMS2?=
 =?us-ascii?Q?r/+K20GqxkPEHq4Tg1usjBF0v7TADmoD+409DAF8HPv9DD3pmwEwhGrYSDI9?=
 =?us-ascii?Q?cTeh+Tbdg2fwzZLcmx3UT46oi4rvg4xuBmRrHHTEWkiCD0cPAMZara5Sn/vS?=
 =?us-ascii?Q?3BvPuqy32jIqtq0xnfau9f/MDgFDyS0wYCbGj/Jdzpo3ybmMeW4glHHIp5Op?=
 =?us-ascii?Q?vAhx+ptfMQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8280fdd9-a1df-4f14-fd76-08defbbd25e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:13.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jY7fwmMRuq5lwopeFc2iUj0q6aGX0+mcSH+00EVmm//QEoVcxpVg6Uj3/Iiu7qAJLIsYqYnUnPap6b6KHUeKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

With proxy execution, pick_next_task() can select a blocked task as the
scheduling context before find_proxy_task() resolves the execution
context.

From the BPF scheduler perspective, that donor is running while its
scheduling context drives the lock owner; ops.tick() and other
accounting must therefore remain enclosed by a matching
ops.running()/ops.stopping() session.

In this scenario, the session boundaries do not always match physical
task switches. Keep the "running" session open when the same donor
continues on the same CPU. When proxy execution migrates a donor's
scheduling context to another CPU, end its running session on the source
CPU and start a new session on the destination CPU only after proxy
resolution succeeds. This prevents a failed resolution from exposing a
provisional ops.running() event.

Track these sessions with a new SCX_TASK_RUN_TRACKED flag. The explicit
running-state tracking is also required by later donor-based accounting:
it prevents an EXT owner executing for a non-EXT donor from being
treated as the active EXT scheduling context when it is dequeued.

This is a preparatory change for enabling proxy execution together with
sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |  1 +
 kernel/sched/ext/ext.c                        | 65 ++++++++++++++-----
 kernel/sched/ext/internal.h                   |  6 ++
 .../sched_ext/include/scx/enum_defs.autogen.h |  1 +
 4 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 582d7cd4a9839..9912ad0c2d445 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -104,6 +104,7 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 	SCX_TASK_PROTECTED	= 1 << 6, /* slice and DSQ head position protected */
+	SCX_TASK_RUN_TRACKED	= 1 << 7, /* task is in an ops.running()/stopping() session */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 7bbe3c2e243af..2739cd180bd74 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2289,10 +2289,10 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	ops_dequeue(rq, p, deq_flags);
 
 	/*
-	 * A currently running task which is going off @rq first gets dequeued
-	 * and then stops running. As we want running <-> stopping transitions
-	 * to be contained within runnable <-> quiescent transitions, trigger
-	 * ->stopping() early here instead of in put_prev_task_scx().
+	 * A current scheduling context which is going off @rq first gets
+	 * dequeued and then stops running. As we want running <-> stopping
+	 * transitions to be contained within runnable <-> quiescent transitions,
+	 * trigger ->stopping() early here instead of in put_prev_task_scx().
 	 *
 	 * @p may go through multiple stopping <-> running transitions between
 	 * here and put_prev_task_scx() if task attribute changes occur while
@@ -2300,11 +2300,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (task_current(rq, p) &&
-	    (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq)))) {
-		update_curr_scx(rq);
-		if (SCX_HAS_OP(sch, stopping))
-			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current_donor(rq, p) && (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq))) {
+			update_curr_scx(rq);
+			if (SCX_HAS_OP(sch, stopping))
+				SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -3009,10 +3011,21 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	return verdict;
 }
 
-static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
+	if (p->scx.flags & SCX_TASK_RUN_TRACKED)
+		return;
+
+	if (SCX_HAS_OP(sch, running))
+		SCX_CALL_OP_TASK(sch, running, rq, p);
+
+	p->scx.flags |= SCX_TASK_RUN_TRACKED;
+}
+
+static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+{
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3024,9 +3037,14 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. On a normal
+	 * scheduling transition, defer starting a blocked donor's session until
+	 * proxy resolution succeeds. A restore follows an already resolved
+	 * scheduling context and can start the session immediately.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && (!p->is_blocked || !first))
+		scx_start_task_running(rq, p);
 
 	clr_task_runnable(p, true);
 
@@ -3072,6 +3090,13 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 void scx_proxy_donor_start(struct rq *rq)
 {
+	struct task_struct *donor = rq->donor;
+
+	lockdep_assert_rq_held(rq);
+
+	if (donor->sched_class == &ext_sched_class &&
+	    (donor->scx.flags & SCX_TASK_QUEUED))
+		scx_start_task_running(rq, donor);
 }
 
 static enum scx_cpu_preempt_reason
@@ -3147,9 +3172,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			scx_task_slice_ended(rq, p);
 	}
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+	/*
+	 * Preserve the running session when proxy execution refreshes the same
+	 * donor around an execution-context switch on this rq.
+	 */
+	if (next != p && (p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping))
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index fa20cac3ab61f..2b2dcde923600 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -449,6 +449,12 @@ struct sched_ext_ops {
 	 * Therefore, always use scx_bpf_task_cpu(@p) to determine the
 	 * target CPU the task is going to use.
 	 *
+	 * Under proxy execution, the BPF scheduler continues to observe the
+	 * donor as the current scheduling context. A blocked donor enters a
+	 * ->running()/->stopping() session while its scheduling context drives
+	 * the lock owner. The lock owner executing on its behalf is intentionally
+	 * not reported through these callbacks.
+	 *
 	 * See ->runnable() for explanation on the task state notifiers.
 	 */
 	void (*running)(struct task_struct *p);
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 19aa1de3e7005..cccc0c3987b85 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -101,6 +101,7 @@
 #define HAVE_SCX_TASK_SUB_INIT
 #define HAVE_SCX_TASK_IMMED
 #define HAVE_SCX_TASK_PROTECTED
+#define HAVE_SCX_TASK_RUN_TRACKED
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
-- 
2.55.0

