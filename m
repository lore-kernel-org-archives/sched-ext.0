Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09A2DE709
	for <sched-ext@lists.linux.dev>; Wed,  2 Jul 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499018; cv=fail; b=l6ir6f3oaQY/GqG4x7btIsY/QELGtZEzO1/wpJmn86a3EZ9wh90Tm9t9BCjvddnS/yxo5I4GOEE5ZRZENfeLIpy8W17zpXc8hpYZXcYJgiJvkA4c/gTkSfsqMiPk11+VtwhAGOGJ+bQAPFMyk3ttqBktxfmCGacvlcZZSQI62Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499018; c=relaxed/simple;
	bh=WtpmkKxh99zrJX4hTje2ThQ1RLR+JZ3CYMTo/CUd3Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4WsRRmSU9owhRIedO2yDmpQBH0LmDIVr9zuOh5hpA2V1lr3toTiaR25+36+L5EV3Og6h9EsonwAAadr/tXnLdauFn4cZNCakeTvAmcRCi9hTDHJ4V4slpuUnfLtuxJjBc0yEB+z0aEgjfRZlMbvahAsO/glWC2Vk608ATzxeSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ko6c71kQ; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ko6c71kQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxPJB2OgMkwQdIvwJT4ZNSUwiygWr8ayqQR91PeP70rT/G2YqVLBRxzSBlOLlNtUqGeJ3bsyhsPzxAK7ULdfDxSu99dW+8fEhhJOZxu95/S1DdLgOeWIC+6oKeza0duq1wETFcDJHLVSDdh4JdTvnRQvonDG4/LjvagJi6LgtWVXUu7XlZbLKY70yfWrfpij46C3ZKzYzzXkRm4gZI3GemVhqzF+CcNHRj/J0vDoS7JAVDcBQVYDBXfZqjUJ2JkacI48RppU5UTdSES2RcBDTLbNbyqEtlctajxr0HnbkuYi/Do4ey9y3ecxASiVD9F83jJqY+mrWY1fr2WZzGJTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMV0pisGA76dSe13TKEzAoYKnE8YQhq7bUMyCcNQVgY=;
 b=NgEELWbvktev5fpt61f0ixqTP5+G9t56MALplC+JSIXu/6vWe0r13YOvIB5cfw7RQ+USG/7jm6KHb606R97v16uFToKO8dzFurqQNMbn6A23TZBAxaRgoT3Bu+qXUFEOf2APc8k8dkqcSMDolZewOadnPi/iEbXR1AF8+UzXsajtJ4ujd0s8slVxLRmhuhG5Iry8G0zaPa4INgh1VUFgk4fomJZI1AsLwdNqVY7Sp+ndEhGVywyzUy4rGruuqdeHGWy6QyFjgej/ewwI8kWBgV+9AcU3yncS8qeehtfayVifOTVkwcZuy479Y0cAX9a6CBEScmLBXWBXlgMEpplvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMV0pisGA76dSe13TKEzAoYKnE8YQhq7bUMyCcNQVgY=;
 b=Ko6c71kQKI4S0EqsTIogSMNzOKvbGYJ3AqO0p/km0FdWBdbNJf6VmI2eRCVNTXlFv2JgAukNngVb0xeIrYYwy1d9V8Pnf6YUl9D2akfHD+4oT1XdYFczoUMoOCXP+Wh/qwI+DV5hbYv0NL4oz5vUSVsqeMgwQGd9w9mmphkEBPtzDHlVL8ATxeIt2Bi4yaDtTS7RdSL4CaAf0k76t2WmtNXVw5D3sDtPzsSMaJsrkH3B8XgePaP89BSHpEC13pGls+bs/F9NC8ZlL5omkubtPRwCcvtCGZwzpYN0+Ac/YLt2NsQdwvQDpsDwQKHTje9X7zYwXQzUHA7HHi+gHUJ+sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 23:30:12 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 23:30:12 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH v6 08/14] sched/ext: Add a DL server for sched_ext tasks
Date: Wed,  2 Jul 2025 19:29:33 -0400
Message-ID: <20250702232944.3221001-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702232944.3221001-1-joelagnelf@nvidia.com>
References: <20250702232944.3221001-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 08064471-d94f-4146-51bf-08ddb9c063ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fwf2cHWtxd47pQNCiyU1rd22WyWxzLdgfkcrKQggwf12fczaIRelF5B1GA+Q?=
 =?us-ascii?Q?gUwDmowh3rsmY5bNQO4ss4d9Qq/6noxxLmaY3eL0CeDEXQtVGoEsIBPbclXL?=
 =?us-ascii?Q?kJiw4ju9okcSz5np1kYKdea/LAlqspH4C6bLyDS4lafkHjAS9UKuCsm7cXLh?=
 =?us-ascii?Q?7ZcdDPnv+L/pg3s4fbidRB0eab5UaHNOZZprPR2RkfDsJleJGNjd45Kn/7ij?=
 =?us-ascii?Q?WRZl9EktuMklcrteISgnqmF+vRbmm4iWPBAT0DJv/mQgTBypRbzCF+XeLhtS?=
 =?us-ascii?Q?9u5ayyo2id9Rn0oMD6VJ9SC4GYHtBVCdVUaD/9idG6yPqezn4EsdCo0IgcQT?=
 =?us-ascii?Q?gbNxHsN24l26w+dlj8Uy28INxi8T9ic9kNfW84myesUiQHsdiSgz+Mr1wAOm?=
 =?us-ascii?Q?tjTUEf05ZZs14oa1JLDiFmJLtiughSYpZrFwgtnh7rbG7rKNcCBwcUrI2fGw?=
 =?us-ascii?Q?TD7v03quczb35w+1yWX06pm7F8/k/IyDqnJk/PyiN4E/wKF1LR9P1sykyaZv?=
 =?us-ascii?Q?2yAOZB/jjaf21svNdfg/4zl9TIFj4zd7czU7ygveqcZLeZRRRoHntnGkq5fm?=
 =?us-ascii?Q?K+u3LPEnj+dxS9kJjdC9dz+rUPocBllqfD1FNhd9DlyCiBSvnjckC1Rk0oJ7?=
 =?us-ascii?Q?vfDwkEO3XmLCld43b+nHl3/P6Ucewk+nHnjj1fQ+EVr3A8C5JqBMwMo8lYql?=
 =?us-ascii?Q?bDT9GmFM9lZQ6n6sZ49vMzVOT94b2nR8cFu9UH3Ys1e42ok1z4gaJMKL4h+A?=
 =?us-ascii?Q?qjjUaj6Za12WNO1qQOYE1l91zx8l2F8R4ymw4ZEzrZW9Lxv9kpGQtuNLH5hZ?=
 =?us-ascii?Q?8c91NIwCHaQQt4HkcSzw/t/1q6Ej/GpqrK6rFKDHEWB9Cgzg4X1SstoQH6ti?=
 =?us-ascii?Q?6hv+XgM66EpPKLAbUPlpuX3uBIG6LwlcrHvi9ieEhJzDyLpWKmpWoTCnBr0p?=
 =?us-ascii?Q?BobLku3/c+d3oJnD4aKmuy4Sq68qJej+TrDR1sDy6t5Wi194Z2fyb6QqrXdM?=
 =?us-ascii?Q?dTgwhrAf8ah6c1aYl0MruIf1PNSjtHZLDSCuf2ShHqrvYfbG6zA672W6lIiM?=
 =?us-ascii?Q?EyBdsZM3qM8VoLF+mZlCx8MlC4mJUQwoqRAKJKzb/6MGcmCjP5Calx89uSDi?=
 =?us-ascii?Q?HbOr6cO+DekKHNHqVs2UHglVjEYaJLj/mnJep+8d/FpsBsHEW1GtG+ExpDko?=
 =?us-ascii?Q?H9bkV2gkhYxzUr6cLXSR/lFl5gICG4gkbzMc91xUHHRm73FJGmQuUZXF3NKz?=
 =?us-ascii?Q?s986uU5R//W6LXubX3Eb/dHjTwjdbX+TfT252WcmdsgZpGbfKUOHb4Acech5?=
 =?us-ascii?Q?H+uSM7qTuc6luCfrxkGjnZzypVai/BecEoLa0flLIu4DuZ+eaSHe9r4bD8V2?=
 =?us-ascii?Q?k3AArz3zqDXrm7ajgeGg+WisvTRZolwBU0Tylsax72anFrSVY0bZISY9Zttg?=
 =?us-ascii?Q?9XiwXfpkOoiQuNnLMJHaARTKbzE9txvr9N11TeHmTljrfAlVDveTCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbnG6FYDdOxhgegPPkMWt6GIeGSl43ZJkvR3EJyFJ9FqslQfSa+3xtFrJYbe?=
 =?us-ascii?Q?fLSs5L8P/ikFXGHGO2rs64eca6RApxTMHAhW5WOZVB2iMNwRO4mJLUe7TxpE?=
 =?us-ascii?Q?5so7RewVDLQ4VE0CtDBvr/JT4MEsh6fBVj17KKsnbfwWr/oTHbYnAQSARI2H?=
 =?us-ascii?Q?4fv3Pt+mFQ36tGEV3QxWs0c0lWPtuUNh0MP4RDoUtYk3Urb+p1/95OCxV9w4?=
 =?us-ascii?Q?nsPfxSsoL+6doQ50CXYAqyCfHQvzW+TC7cubhiRSudEdgsQIP3AemK3Ms4lQ?=
 =?us-ascii?Q?DP4a6bm4ctIgunKnXfLG6BYEc/JEyHqUserQpeX8dF2ZgOT5ovg1tjRUkq5U?=
 =?us-ascii?Q?E0/F+lhcnaCS+vSRpsXakR3O3Y2W/sui1x7+sSQWuxrb9Z3OV3uE9MN7dwuj?=
 =?us-ascii?Q?/yk+nxUzlX0XI0x/v2t+ZS2BkSl8CVNlVsehL9mx9HeFxQ4ZG598phuVWjuB?=
 =?us-ascii?Q?sxE2zu9f2QK5mxgQD5wLL5+ysN5HiFG4pxa4iNcRDwODkkeej299OMt6M3KE?=
 =?us-ascii?Q?+rAgN5Pzk9qxdNOncVkL8fhhkr++wxhKJCFxoqa9k9UNbnq5nuDpsWVc6021?=
 =?us-ascii?Q?B/pqN4xfyHIe62iMQRIjU2RgMXprnb2abGN77sXNFFUaMZXKx/5yW3AMIdsw?=
 =?us-ascii?Q?Gvvk6R4z9oRnjj3TsTushtCndEvAWw6VXJdmiyss4cEf1b5kV3/jDe5Z510u?=
 =?us-ascii?Q?wXZF4Bn7khwVmZmw4hOz1GnEf/O6jp3yKj8u1zDwAjXFPswSI8VdFBzqBft6?=
 =?us-ascii?Q?/kF+a0yyTzV8Mx9SinoWianL6X57jwM1vSOMH881q1b019P3VcyjY8E8h/m4?=
 =?us-ascii?Q?A7cFiOyG/fFYv88iyCoDv/VHNXImdg3vu9kcF2ESp+3HyrOb3Ve79WYRt+YM?=
 =?us-ascii?Q?nOO78MJL01w2KqnGfmY1DPP8bVsTrtrEgayt5bqnnoT6eulYbR96Uaitpym/?=
 =?us-ascii?Q?cFr/IEPEdnI6AovUZWdAtb8X2/YbOQ39o/q11ElXnk2J22zEF1BkvGx1F36I?=
 =?us-ascii?Q?3y0akRQtIm/jw7UhCXB8IHwBad3q6KgcsKQAzhuk/MjcHyWhVKP2GuwBZNRN?=
 =?us-ascii?Q?VesKtdYtEC2e+rJLiQKa5QFdXKdGYlN2vWHz+z9IIh2Ui9VO17v/NT1CU2lC?=
 =?us-ascii?Q?U5KgrmcPykTysdpSlQvQBzSh2YMc0cJeE5VAzz/NTtGTKO/ot0znjE5APkpk?=
 =?us-ascii?Q?E/7IiDW04D/mVS546+Vtwk2Aghnq9AOGBA/epjPKh23WI+No7qzGeMm8FWwp?=
 =?us-ascii?Q?8YxQmtGvJ2Og6pL+dLODeA1QDKnRVCM0pIpdS+Rd4Z71uoxMg/kUFf3gsZGd?=
 =?us-ascii?Q?StCQaxE8jAMqFhneoVuFH1o6ilvuKlIOm75HhnFsQ3o6LwYdYk1oh+vAPNQg?=
 =?us-ascii?Q?M9pwhzcqwM/QZD4kJq0VMkiu8v7PaXc8LeTtxQ6VZtzN6t/7psoz4+1ILgOJ?=
 =?us-ascii?Q?fNcH+rsaGNSnYqenU+jVyrYrHXXrmx6hVn1SLpXkz/LR8tmLa/XQyXCrQn+G?=
 =?us-ascii?Q?yLyVrbbeqSjSImjKmkxETaOH/a9IcNBTKkHJ/ceCblhnr5wthfJWkCGpbtuW?=
 =?us-ascii?Q?c+0DaioRIEz5ZJ68RRfydeKFojCDliWE5xWNJZId?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08064471-d94f-4146-51bf-08ddb9c063ef
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:30:11.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odQQdvgO3CWJZnNlXmIfyX3Eu268Xd8nGquEZoDcXdmS1yd7WXcYOymKjA0KojYiZIQMBVoUx+kp39LQwBINHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also provided later to verify:

./runner -t rt_stall
===== START =====
TEST: rt_stall
DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
OUTPUT:
TAP version 13
1..1
ok 1 PASS: CFS task got more than 4.00% of runtime

Cc: Luigi De Matteis <ldematteis123@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/core.c     |  3 ++
 kernel/sched/deadline.c |  2 +-
 kernel/sched/ext.c      | 62 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h    |  2 ++
 4 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d856d8dcb94..a1ee241a63ce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8650,6 +8650,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b571d06c837c..b7f1724c54a6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1570,7 +1570,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	 * The fair server (sole dl_server) does not account for real-time
 	 * workload because it is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se == &rq->fair_server || dl_se == &rq->ext_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f00bb75ad539..34c95100fbe5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1909,6 +1909,9 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -2396,6 +2399,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	if (rq->scx.nr_running == 1) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr, &rq->ext_server);
+
+		/* Start dl_server if this is the first task being enqueued */
+		dl_server_start(&rq->ext_server);
+	}
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2495,6 +2507,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+
+	/* Stop the server if this was the last task */
+	if (rq->scx.nr_running == 0)
+		dl_server_stop(&rq->ext_server);
+
 	return true;
 }
 
@@ -4050,6 +4067,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
 	scx_disable_task(p);
+
+	/*
+	 * After class switch, if the DL server is still active, restart it so
+	 * that DL timers will be queued, in case SCX switched to higher class.
+	 */
+	if (dl_server_active(&rq->ext_server)) {
+		dl_server_stop(&rq->ext_server);
+		dl_server_start(&rq->ext_server);
+	}
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
@@ -7310,8 +7336,8 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
  * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
  * schedutil cpufreq governor chooses the target frequency.
  *
- * The actual performance level chosen, CPU grouping, and the overhead and
- * latency of the operations are dependent on the hardware and cpufreq driver in
+ * The actual performance level chosen, CPU grouping, and the overhead and latency
+ * of the operations are dependent on the hardware and cpufreq driver in
  * use. Consult hardware and cpufreq documentation for more information. The
  * current performance level can be monitored using scx_bpf_cpuperf_cur().
  */
@@ -7603,6 +7629,38 @@ BTF_ID_FLAGS(func, scx_bpf_now)
 BTF_ID_FLAGS(func, scx_bpf_events, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
+/*
+ * Check if ext scheduler has tasks ready to run.
+ */
+static bool ext_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->scx.nr_running;
+}
+
+/*
+ * Select the next task to run from the ext scheduling class.
+ */
+static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
+						void *flags)
+{
+	struct rq_flags *rf = flags;
+
+	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
+	return pick_task_scx(dl_se->rq, rf);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_has_tasks, ext_server_pick_task);
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_any,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1ac2fb398982..576b69cee6b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -389,6 +389,7 @@ extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p,
 		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1137,6 +1138,7 @@ struct rq {
 #endif
 
 	struct sched_dl_entity	fair_server;
+	struct sched_dl_entity	ext_server;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.34.1

