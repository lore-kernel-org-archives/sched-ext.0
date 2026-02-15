Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4C8287E
	for <sched-ext@lists.linux.dev>; Sun, 15 Feb 2026 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771183196; cv=fail; b=MPmlcTRoS6O7cDD2t4UhPTcPbsJXUOZZI/xAW+sCo2ufBJV3v696lVPb3Y4VSSiKtpXwrpainEy00Nm+yJq5W3sg0gSG7haiBE/L+5z8tG1x7vIGfVgSt6U8+eM2z2hNLgShzel9DaZViljqGqPpYEXyskZp3Zdv2AntGwzCr9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771183196; c=relaxed/simple;
	bh=65aYI5rcDZTXAunvrBsL4vT7K8muLie4ULgFnGoGKrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sSz974nND7yXnOkH1EY15CvVbif5a24MI3hVg0t9AOAO2ojIkb4mPasle10ONS0dXSOegBjSvfLBtQhdIO0s3nxvprbM0Lo1gjQIbztDBI9CNf9vOH6qXpN0/bRGPxWediQJhGHOEeXc3CaTmpkk93y7HwDmFm7tKIeqPqupQi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9r9aRlj; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9r9aRlj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFdATYxwG5PCkTV01BnCWz7Nzaq8NkrVHD2RpoRNV+Y+z2uYHSexi6My7w9dMvnlBcPGMoET+UdYrXB96bQ/CoQK57XVEAUr330yjCJZ4n8GXerEA0d4Ll4PBPaQ1dlznPIZbz3xsYTylChZwdOS6gdm69YzqKdFF30NRtKVBpxzj+jpMx3t/tOB2fYzW+CasI0pagIMnHxeHHorqnSJn165Rjr0LWvySBZ7x4fO+4TFk58B2ZyKHnI0GSSbXv2d+JEbl7LNzVjm9Gcpp6rG+Gy9E3Jo3TiXELbw9zX7ZNxcEvsR5pkahnUWCYj7xPECm9vw7kU4sXwmWVVLMjhXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLN1USS68cGiCAyVVlADcOputiA4qdxu7hG955L9DqA=;
 b=yb5gVipg/uTK2EVsVAamP1rAR+L/cWR/VqMBJeoJJ+Pjoc1Z6uNF57F2fFaGeRX3ZrOxSDmTZdgJnkC/3j3vPytV0q9HUlAykX+gGQll0ajqoPIh6JbwdSGZ0urXs87F3D+ez/ZSHkLnMA3Z/nXADEaZg7PLcn6Eb42FelxR+qZaoXz23aj8Az/Px5AhD4cXq51x0S7Meo1Ok3tWInzmWW6xHWptYyR+6fUhXfuiI3KZOSPZui9jr+vz3l17Gech4RigneVmVEH1/y4m9nspVKEDF0JAhoiJWDA/J57W8V5cb5i9/5ulyQGzZlpKlFnbUxnm/rFQaINIBDksrng4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLN1USS68cGiCAyVVlADcOputiA4qdxu7hG955L9DqA=;
 b=M9r9aRljI1YCdpt8vMIyuz8YJGCnnPif1j6vnB87e2idHlGKyp8OxDEVq+eL5gMcb2nnSACTOsj+oVO5Qn1UMg/sf85cSqtXp813vy4HQf0WK7v1nBr6nPAwDO2GSAUDAzUg0ztU1F8MtA8ioBO6XNkrAg619xABlvVEcnr9XsOvIQD9FA3ygtQvgRfp8rAA7/1LabmJvBSPg74b9Z5xsUKSzxEhBqTZ5SfKLPBqtnoczjFAUFzv4EDnbTt8zU7AOZSK05WmWEyU6WAhdkimzEAY0Kq4rPUtrQuMRdXyp0KEWNsQe2siRwXH7Y4S/DVFq+0pGLzQ22Ie9WO3cHGMHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 19:19:51 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 19:19:51 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sched_ext: Add rq parameter to dispatch_enqueue()
Date: Sun, 15 Feb 2026 20:16:54 +0100
Message-ID: <20260215191933.2358161-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260215191933.2358161-1-arighi@nvidia.com>
References: <20260215191933.2358161-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 5633be00-eec5-461a-fd6f-08de6cc730de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X0NXLTXlRQVN8NVMWyLIU8AMOTCNwZouYwqiVfWk+NjgM44W1mqv/v/2OP4z?=
 =?us-ascii?Q?mdLFnMcoKMf8mKyfYRofcU/06H1YDeaV6fwUBLFt8BjHX7Yjsw/bwUmV5x95?=
 =?us-ascii?Q?aPrWAkKFXxZY8jf4FRPkiqzSw+On4wJmfUGBNPOBFoVEB9IxVEsAmtD2he57?=
 =?us-ascii?Q?jKBB/o6nlH7Qd0c1CRpACTi8A5pPfs2barmiJdu4j0CwSM8oPNT0jcOz+6dm?=
 =?us-ascii?Q?GPc/Gjo23JGCiD+2d11iO+GRqXZjvReHyeanuXFPQGbaK14dNUHoAssd5Iho?=
 =?us-ascii?Q?EwcocRHQTITZnerQuA+CmXN5+OcQxP7AS3e1vL6mzDPEjE+N22XKEYm1Yw/K?=
 =?us-ascii?Q?BeRvxm/sNMP1FdowdtCKV6j2h6LJZVyja/BUncpHQYTlRralNMNidwxKVKka?=
 =?us-ascii?Q?Um0zXO9+ehWJQgC/UPeHLvIsxJV0LFrQH1ORjLJbbr/U/iZpSP11BGaCek54?=
 =?us-ascii?Q?fr5RS+h6Fe48WP0Zp73pdpyY3Q8zZjOAUnmQsZSKDhzXzff5ehAt6jletr2z?=
 =?us-ascii?Q?UuUBK8fp7UipAG6G/62DysLcPCvzTdjn0d7Xfq9UAXVtA9UfpboyP4QqUPN4?=
 =?us-ascii?Q?bkxAQTd+lwoD9/dgPqFtzfx01iDDEx6Rz8kaE3x7/uL5nDhODi1kRpHY2rfn?=
 =?us-ascii?Q?M7D5XgkBPrGsYbWRHQxdviS05ufj+5f1bq6fSx+0qh8b2qqNthowgkmggI6f?=
 =?us-ascii?Q?UBXt7YUVJZE+83So9wLnvNXHh099rGzBkPb71Xo4kTFgaecXibF3Bec5bJuS?=
 =?us-ascii?Q?HGMNkj82zGEAAP7m85vhj+LY3eh1ptDUS9mqXoXuEx/iJIawoFKIBXTn1O7q?=
 =?us-ascii?Q?7X3zlfsoKZBvQ4hE58Xl2PlBsAYdw2Z7IDPRov6Ta7cg9+nbf6h04oGkDkWV?=
 =?us-ascii?Q?PV3gcE/XqY3zslZ5Nqt6N37cA6WGBINlGCyU8Nc6DjohRCJpqlmjkr0Psoai?=
 =?us-ascii?Q?uqSti9KVv4eUTE4S54XI98P5A/CU0D2ig/GohHoQ1b5ZjpJcc/NmsEXXcwLg?=
 =?us-ascii?Q?XJdu1SRZpiUkBdBE2sX0Rw/Ho4SBt5yIYgYewZNHXAFLnI5vyuTHdK17XQ8+?=
 =?us-ascii?Q?MZTG68rNusD82vJqm87F52eJMPPHLxDiql91LWkN5A26+k085dkGMwnTThl2?=
 =?us-ascii?Q?j3V4Dd5QF0nsSu9r2WjTs/VhXdnGAThZS9lhX/cie10o8hqXTTfr8rvecQAk?=
 =?us-ascii?Q?HVX8kochIjlAJmQTIG1kcWGt9PNyGtTTbzs86dX+SCUoRLBoKEiH8FJEgFxK?=
 =?us-ascii?Q?F+W6becSDvby1P80BobbyH/q1eZYZuF/g7dsmvlcrUUEJl4ifQAERhOC9eKv?=
 =?us-ascii?Q?hL5A/cRBTQlTAak6Fq5YFkFGek7VuPo1nyglRpr7YqsezyWnOuueRJj0NyNl?=
 =?us-ascii?Q?IKGFp3VSonp4OzbrUGRmxb4crt6e6F3Wah9ErofcQtwbIHthGOz8qeQlif2G?=
 =?us-ascii?Q?37GUJIB9HBzxda390x4ybjWVudnIcDs2m9gbvXCx/D5pP82N9W9zmbo8DX4v?=
 =?us-ascii?Q?9luHC8IFoPQ4QgLbyQax5lOjA+xvNWeRNT7HukOKhLsUzX2Xb/oIItbPUcwY?=
 =?us-ascii?Q?uCMDNI5mrnKgzxHhPfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OQSesk0TLZ6P7zGX5qm+ku0CeK3ULeHj7HOwhnQwHAQnYYDjfFioP9Xyfz+M?=
 =?us-ascii?Q?JonQ8T4bV1CSmQS1zWSninTSWM9S3orZ1Wr3YS76Ie++LxUx8I+syuuv4JiU?=
 =?us-ascii?Q?v1/43waMlX+tF0vE0mlZNIkCGzk/mI7lSN7JJZLxkZNZjEw1jlTo+X4XXIJa?=
 =?us-ascii?Q?EG50a/c9qUdXjrXtfrL6xhzsUnaHGu09ILIrBci30LkWW6hotpXO7tW4eFHT?=
 =?us-ascii?Q?mTt090e3tPd1Lg2jbO04xGKwvALNlS6P1gwduXg+7IOVFSBFFI1qXazdfFac?=
 =?us-ascii?Q?pOW4Z+o/mKyMp8NB/bhzdsbVwoO9Au2usXY2BsqHz20RQM5fTHakICvVeQDJ?=
 =?us-ascii?Q?j/djojn8XRs1KUeByvtP2XX4jCm3gDh9yJ6HW+Apgleoj6HnF8JScif9ge14?=
 =?us-ascii?Q?i6xA7hWjDigDlQF0ht8IhsOHNSCpxjmTSkk0tWx9ET95hHRj/7hMeNgW7Ne4?=
 =?us-ascii?Q?PaRT1CfUQVylSSf8BusRcBd2WJPk1aSdsNd1v6s2BcAd9M4zhE32jiAmmtBA?=
 =?us-ascii?Q?qs1K3V+R3yEAr6d/mu525ley/LT6uc6fdWFZ5sq8Ld5HT2YG7sAE/QffdkBr?=
 =?us-ascii?Q?jtX77E3wZzRP7vF01k0inRCb0HfzdL7alRueYskx0X1NeXMmnYI5qua6HzXU?=
 =?us-ascii?Q?VEJLjHBuWyPUkaEiNneuWZGQbQHgzOL4/v9ENEs0DSrNdPz9JnSEltSFevIp?=
 =?us-ascii?Q?yzyltNkolmN9y3CA2+Mz8oSoSrnUjY2qofmBDYM2zpGmqRPD9HdoVqTFElyZ?=
 =?us-ascii?Q?CP/xBHu723J6W9W4fPrNaJoXyDRDyvyChIsOUHdRpYvwZuRWpww8KO+d0+o8?=
 =?us-ascii?Q?dqCHurgcRAakhRF2/vEHwOSbzJZF0mapMXhjgICnZWoqhszc695/Yr0HBg9T?=
 =?us-ascii?Q?WKHZe0KaGSbp9Gs8ngm4K6MYJnGqtFjR6npIDYgBpcxgwGnxN5cMSuZ+2naK?=
 =?us-ascii?Q?Chq0Y9vUgTFwVqOyhIXaJ63rsq6gWD7jjRz++72x3E1B/c366Sq8sRgwdeN9?=
 =?us-ascii?Q?tkS/DcYC68VvxEvfWZsHNIoyBb2IT792CAIQV3+QHKCEpK/8aul+pGG1GVmL?=
 =?us-ascii?Q?mFCDjpK5n5+k41Tc66AeCu7TtxHuJrsdv+Sdh80evqxCUlkpFe3t5mJGWsYD?=
 =?us-ascii?Q?NioLTD+M2K87t8kxm5Td3pycu0sjGUXtoo9UF89p4gfrDrtCEuzkZmXXw4Je?=
 =?us-ascii?Q?6S7fehH/0jm3HNytvLbG2vsv51mVxrpxT7jCNiMyVhyMaj+aho1H6/9fNviJ?=
 =?us-ascii?Q?x8hAII/CZInX3hxniIaSCpWr2f4aKg5NhpyPQ5o7EdvkfZHfwkxw+qGAFuam?=
 =?us-ascii?Q?tW5WUpKhp9meLxMQFKVqolDD5l5bmYczE7ltjELUL8ZLxyR6+PgFjYqWDG7Z?=
 =?us-ascii?Q?/wvzt0ijBwrTi/xKw9uUu+pD+954vIZlmZlaH0VMUXGe5fWCB4PKNrn2hsdg?=
 =?us-ascii?Q?7L6a0ym3ekJFjY/b03eU48GPkXF826U38e+7lRobyGUnamNbie60EzP1HcqJ?=
 =?us-ascii?Q?GbKxCw9cdp+NTwUvcYFdFpfdahfFBwr5+ZQKxKhQP3AdFjEbp/wk2x2TP0MF?=
 =?us-ascii?Q?Kk4ul0ZHzbXe1J4BSw2udtmtjzYHakp1S2VO5E4yS/TQiZAKwaABGqJxousN?=
 =?us-ascii?Q?xputW9TUY6Pb/htwodNZNbw3aJrGoiG/yvsgYUXcj8OiKJ3HD78EKm22Q8/K?=
 =?us-ascii?Q?9+snJ1NDxJZhbaSX0YxnrvG9KLKSq54uNt7g93OoiA3Ap85D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5633be00-eec5-461a-fd6f-08de6cc730de
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 19:19:51.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AH2dfaS+GDtNZx5gqfX2hfgdwKwDJIuY1gVZ1mVHOkS1SRZOwBIqI1bpmKWKpJqK5/iA+XJlr8y5SbyRq/w9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

This prepares for a later commit fixing the ops.dequeue() semantics.
No functional change intended.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3885dd06dd573..9820026b74557 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1010,8 +1010,9 @@ static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p
 		resched_curr(rq);
 }
 
-static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
-			     struct task_struct *p, u64 enq_flags)
+static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
+			     struct scx_dispatch_q *dsq, struct task_struct *p,
+			     u64 enq_flags)
 {
 	bool is_local = dsq->id == SCX_DSQ_LOCAL;
 
@@ -1325,7 +1326,7 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	dispatch_enqueue(sch, dsq, p,
+	dispatch_enqueue(sch, rq, dsq, p,
 			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
@@ -1415,7 +1416,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	direct_dispatch(sch, p, enq_flags);
 	return;
 local_norefill:
-	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, enq_flags);
 	return;
 local:
 	dsq = &rq->scx.local_dsq;
@@ -1435,7 +1436,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -1888,7 +1889,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		dispatch_dequeue_locked(p, src_dsq);
 		raw_spin_unlock(&src_dsq->lock);
 
-		dispatch_enqueue(sch, dst_dsq, p, enq_flags);
+		dispatch_enqueue(sch, dst_rq, dst_dsq, p, enq_flags);
 	}
 
 	return dst_rq;
@@ -1978,14 +1979,14 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	 * If dispatching to @rq that @p is already on, no lock dancing needed.
 	 */
 	if (rq == src_rq && rq == dst_rq) {
-		dispatch_enqueue(sch, dst_dsq, p,
+		dispatch_enqueue(sch, rq, dst_dsq, p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
 
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
+		dispatch_enqueue(sch, rq, find_global_dsq(sch, p), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
@@ -2023,7 +2024,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		 */
 		if (src_rq == dst_rq) {
 			p->scx.holding_cpu = -1;
-			dispatch_enqueue(sch, &dst_rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					 enq_flags);
 		} else {
 			move_remote_task_to_local_dsq(p, enq_flags,
@@ -2122,7 +2123,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 	if (dsq->id == SCX_DSQ_LOCAL)
 		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
 	else
-		dispatch_enqueue(sch, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+		dispatch_enqueue(sch, rq, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
@@ -2423,7 +2424,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * DSQ.
 		 */
 		if (p->scx.slice && !scx_rq_bypassing(rq)) {
-			dispatch_enqueue(sch, &rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p,
 					 SCX_ENQ_HEAD);
 			goto switch_class;
 		}
@@ -3954,7 +3955,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		 * between bypass DSQs.
 		 */
 		dispatch_dequeue_locked(p, donor_dsq);
-		dispatch_enqueue(sch, donee_dsq, p, SCX_ENQ_NESTED);
+		dispatch_enqueue(sch, donee_rq, donee_dsq, p, SCX_ENQ_NESTED);
 
 		/*
 		 * $donee might have been idle and need to be woken up. No need
-- 
2.53.0

