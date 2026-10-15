Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D350C28C
	for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059601; cv=fail; b=qeetKIiln+CUEXhViKYwzayBe9SPv8nFqTFAlyK9sOtf+acebG4eg3gCxG070xBuJQVB0/3hwO58VnLwSBP/yWCvAInnwVlB5xXcHkrXIk79NMxdaihvzaFfLSvdJCqEK16n9oiXgvKJU5HYGW4xXaAhgCS5njzDvEI+CpASai4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059601; c=relaxed/simple;
	bh=N8LV8GoBd9oDwzBqb0CJA4wLiCtHSs33EJNLSDYrOLw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dkrw/w3cTFI7Qpj68lmaM1p+DM2hkMhBee/FlEpYSObu70y7AfwuuGJxoMuBcpedSufprW6RvjpQ8gZQbDn7OUNW973regN5HUecn7UJ14NtzifiBaB15s22WN/PQ2CipmilYyMN07jcfLxRRBoV6UPSwfIc2nYA2FPuKvlrCng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QiBW+00q; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QiBW+00q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppRLygIC2Xu+ip9oXFwfJNQY8aqNd6X/d0vyA008Zdq1UNqalVJKlLmM6rYPs5/Pv1eHF1jkNaOp/bqBVLaVX7exYeRlFK+GJrJWhKWgjwsJIHkJ+dGzz5P/3kBWdWXlhSzPyhl2d49lEG2Xr4mTrIbNm6EPZTLkU0pw286npyPCm0J1+/S6Px5wbY9VVSvOWPcDSfUoMJt1h1iQUWuInCl7SefVdJZYGTU1gaUZAp8jzuucgnGNOttUha8l5bjiFadtaW5KTUuO454EwFzLcXboCarlL9WTLRwTdjymFaGGasXZi4G9e2j8Fd8IDs7a7RCXnCdNfk1np1xjht3tdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9oHil/WBZyAgJ+OehgY5vZQzsWvesQDkqKjzxDwL4w=;
 b=eEburhBHiTXnH4aZ+kWLXqCuUi0n2ykmiDfUz6bXJ6YR1vg/KopYEwSDGpL1mHe/795g8C0Npq4iT9ocMBdQB/B37fxrIyy1EFSkwMbhJqkwBolx+s5bh15z+KkEC5jgwt7MOc1El2Aw622P4E7ec9MPVogHTJO+IuzheaCYPR56ISoJ8icGPUVvfY83UniWmptPc3eLPFbPuojgwqr25IYtrj4qMo80q6+Jc0j3neUall8Gofqxe93l9M4eyYDwaKyJzlmZrN6bxdR4XxxHUgv2c7k19mHK5WxxHmaMwFpLk6cnwYNdCpdVsLoh7VdN7aCGDBrSF0T4w1NGGvYQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9oHil/WBZyAgJ+OehgY5vZQzsWvesQDkqKjzxDwL4w=;
 b=QiBW+00qoMqsmmifLjCPjGu4DvODrdyRw17PS/b8zMxutkIXI/Uf5xdwPSGiDG3PcOz2tOrBcqnPCCHh4KMP7UK7bXLbqPWZmxL0G6hm+DqkSGWEI7YO9yIXbV72ndhLMBep1dRxBlqqIs1OkXAUoaVW8e4u3fLobG0nEkCJ4XiygGigkK18m1+vVQEFIl/Jf+TGbuCsOEtLfeaQvULLwucTSjP3auQrUOq+CPx8qTZ1Fg/N6aqO7rFMt0f0XEnm9PVEKUYdia20dhVDaDcKGDM3NacAjmHQ60uMXS840iEhczYNCxWixeiUbfeq+Ey1q/5hmDSrdX+RIkaiBwo/3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 10:19:55 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:19:55 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: John Stultz <jstultz@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.4] sched_ext: Keep proxy donors local through core-sched retries
Date: Thu, 15 Oct 2026 12:19:35 +0200
Message-ID: <20261015101935.2844323-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0141.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::20) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ae9d9a-2f09-4040-b765-08df2aa5dbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|261009223027099003|18002099003|260925022911599003|10067099003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	+ua9QxrCkqxbwdUbtDj/7SCe9LblZPprXjk0YBDeedk8zdzeAIwv+0NvN3H50MxYYLNYSqYtTvaxKO41Ca47Y8s7hlzdRzJeDFQvmAXvpWkRM8rI8j0q/gSngHi31r31afw8acX6HbZPmvLWDr33EANy7pZiVVvGkMrnfwvZh0oPwzrO7pXS7mMFL8DEUvQAiOzsKPbC0YOMiW93qbkIgFYe49bdaFPdfBTjKKprss3AAkFgh7zWZxpuf/3LxV3hQDxbYFOINarbPbnJLpIa3ykIftJXM8gzHrovXQ8YM6Md/P08Tbt4dOeiRR992H141rr8hvnjEi+iP7hNxy8ZOatSXicyNUR4HjF6tMFxIwEBShkckYLCUz2kWS1Sk+4awEjcMZsQToNiur/U5wtrOj3nuohi4skGGuz02Vfv4OIUDr2n0cnmQS8fYPNqOXOFe+sOrdSPqI/3TeR6x4zAjgvAJcrmVc4U4snTiFalIaok8YvuY2gxXB0B54lUYfsAXdtZex515Wl+6pnhmNHs+de8VmJsIB3rr5HZrDZwCJoLE4xkAE1YWl+xLR+ln+ei6eHWA4+rJJozjXZGe2Lh/YfCieAuO7+9Krm6W3Hx9jbsQv0w4vvGyCrWJR+3JbRAw3B5NyUe1Wu9iKt03uTq+AM2H3J7aprSq8FpV9BdWXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(261009223027099003)(18002099003)(260925022911599003)(10067099003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQCZtjSzOs3Y7GJWdjt9wES0oSTXr8qbKOd7yXx5Y3IWZDVEoU9uE50Pm9hE?=
 =?us-ascii?Q?tQFXCPOJaLqyZU/TWDkEpw7dmhj8S0mAqAOOzHYCY6yBkURA4tYlg/yGOVqm?=
 =?us-ascii?Q?jfLJiemYzmX+0BnaZ49ZTob8LJlejEI5duFIuI2dOfRj7ePMklKFPts8AdL2?=
 =?us-ascii?Q?lobjZXiDTtsNr40k1SqQdkPKa4t5KbtlxGTQgVax2bde+QwKo2AWMsGEJmrm?=
 =?us-ascii?Q?GIvaobFDULapu4gRHNpCol9hytjz6dI8ZgU/B/pwFUh9M2XJLHDDY8B9FssW?=
 =?us-ascii?Q?MAyeZIZa1EAOXquRz4Mx/tfIYOJ59G4Vp5N7/EF07fo7JrbGD1Iab30JtKvp?=
 =?us-ascii?Q?4FS00pKpCpAhYu2vQYTdg+SSflFtb+xBAHdvGhOHqO1OAr6suuluhh4skoSS?=
 =?us-ascii?Q?JDW+fxPzbHojl3TUC6GPE3nUVj6oESGinHQCdZU+/0758TMIxaz69DclM5p9?=
 =?us-ascii?Q?lhwJH6/o9cfeePOvpEYiKavXJppDaGJJFzYfQ1d9j18quCBfY73svE+kfnDe?=
 =?us-ascii?Q?1Gk86/WW3sBQCRfETOyMHu8I+lzSEfEEfrqN+GSswtH/e6vW0x6zkIVHjO9g?=
 =?us-ascii?Q?KOl6rK4ZLRpeSENXN/6f+QNsaYI4SSXQmmg2BVhDBaz4Doj4ZoGTvRfJVuqo?=
 =?us-ascii?Q?mG1pIeBzDfka4QEG/ULDXtqHfZmYv41gEuirctmbdbMNlrKxyYUZWIR0Yj9a?=
 =?us-ascii?Q?4GLdvN3b83gN4X9fvUk0rApVbbLbB7AfD93o7xbSda/JrlhLCRIM3s+0irR8?=
 =?us-ascii?Q?Z6pDRU8X1AIFDIO3zSQ1KC5346EX6Coqm+BlIRyqmpAWfVX4Lykxh55tHIgY?=
 =?us-ascii?Q?91QCXMBvfv4a2+8iS+7MeZr1iD0t9qey/8kWTI82YJAS+i/AlLWdGX5a5PRg?=
 =?us-ascii?Q?YZNB+dPFQVRvIpGzty9ymHy3l3Hl7l0Q4QlN6MLrsvoD3scBkxjxy6CYbIUw?=
 =?us-ascii?Q?pIcU8wKodJCdtmxreOVeRGZyM+StooPpMbIQcdcbK8mjEBkgLx3wVxXFdpps?=
 =?us-ascii?Q?YCTLGstnl6zo9CWNsYNYtSilVofc0oueG43XVgpPWTi6WrxRRFzijDhxYk91?=
 =?us-ascii?Q?6NPhawk2gWKi7HMxVqhhVpC4zGQSfVdk/iRkXQ9fu2Ruw/XJXiQlKiSppacI?=
 =?us-ascii?Q?dF3PMKApAMNKHIzptLp4sNd63LwwGS12az6rCm+b4pj/OyUxddBHNlkPko6u?=
 =?us-ascii?Q?u29fEvkUdYlu2hBfes/EVSDq0FbIOOCeGB1F+x+o/UEYueTJbDn6uyGqibh6?=
 =?us-ascii?Q?9VQIlbXFzE7+twTVb2XMeKnqHoIapAr+NEIj2DoCJ2pI7rsEaZ4DeHafaNpt?=
 =?us-ascii?Q?+0bbOxOSFLDj7qYRIbKxxgH+C3ZvOZu/kJT7YHq1pT27EfJ3ksv5RRQebrqQ?=
 =?us-ascii?Q?LCJhq9bFMO94gXkSM2O280l5/WcUZiRF7VHnDDEnOKnFyQZNp5Zgv6pTbg14?=
 =?us-ascii?Q?z8jrWF/aW6vZXxqL9jN/if6Bg1Hz2hSj2Kv/DOHhjXufZOk+lLmli0gbxln2?=
 =?us-ascii?Q?EB2RYybq1SD73hPT1eyV3DGTrc4shIh8jRtNqFMuk24vK99RJkotqNxBagrC?=
 =?us-ascii?Q?lsu9tS7bpivW1wcfW90GATQL5GdRhJBG6AJQnMdVMHr0QFfrfCzHQaO31O3V?=
 =?us-ascii?Q?S8+HBQV0BV9VW3t676kyTF17xmPb4B9FlEKc3YoGdUTXXEKLQkiNvDpWJ5SW?=
 =?us-ascii?Q?aK/agR9zHtOQIj+znyWcPkg3Tsf/CcpjN/JjaL84yCOmnWTc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ae9d9a-2f09-4040-b765-08df2aa5dbac
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:19:55.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yt8EclwpEWuyFDIGaH5VtxcfBExmXXSE/kqKd8vEJ92UoMhY96NNVWCnCCj8Vb4w/3DICGxqtC5nK8rGmPhwsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

An abandoned blocked-donor pick can leave SCX_RQ_PROXY_PENDING set if
the next core-sched pick selects a higher-priority class without calling
pick_task_scx(). A cookie mismatch can then force the CPU idle, while
put_prev_task_scx() mistakes the stale flag for a proxy bookkeeping put.

A valid proxy put of an IMMED donor also schedules a local reenqueue
scan. If an SCX task wakes before the scan runs, rq->next_class becomes
ext again and rq_is_open() reports the CPU closed. The scan then sends
the parked donor back to BPF even though it is first on the local DSQ
and the CPU is switching to idle.

Require the donor's cookie to match before treating a put as a proxy
put. Mark donors parked by a proxy put in dsq_flags, clear the mark
when they leave the DSQ, and let rq_is_open() recognize a matching
marked donor at the head of the local DSQ while the rq donor is idle.

Fixes: 7ab553756463 ("sched_ext: Keep proxy donors with slice left on the local DSQ")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/atCQB_nF5di8pgUN@gpd4
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext/ext.c    | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index ae696d11dac9a..4267304823cf4 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -157,6 +157,7 @@ enum scx_ent_flags {
 /* scx_entity.dsq_flags */
 enum scx_ent_dsq_flags {
 	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
+	SCX_TASK_DSQ_PROXY_IDLE	= 1 << 1, /* proxy donor parked through idle */
 };
 
 enum scx_dsq_lnode_flags {
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4fa294f810f4b..2465e792db2fb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -437,6 +437,23 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 	if (sched_class_above(&ext_sched_class, rq->next_class))
 		return true;
 
+	/*
+	 * proxy_resched_idle() can put a blocked donor at the head of the local
+	 * DSQ and switch @rq's donor to idle. An SCX wakeup then raises
+	 * next_class to ext before the pending IMMED reenq scan runs. If the
+	 * first task was parked by that proxy put and its cookie can run here,
+	 * leave it local for the next pick instead of sending it back to BPF.
+	 */
+	if (rq->donor == rq->idle) {
+		struct task_struct *first;
+
+		first = list_first_entry_or_null(&rq->scx.local_dsq.list,
+						 struct task_struct, scx.dsq_list.node);
+		if (first && (first->scx.dsq_flags & SCX_TASK_DSQ_PROXY_IDLE) &&
+		    sched_cpu_cookie_match(rq, first))
+			return true;
+	}
+
 	/*
 	 * @rq is either picking, in transition to, or running an SCX task.
 	 */
@@ -1608,6 +1625,7 @@ static void dsq_dec_nr(struct scx_dispatch_q *dsq, struct task_struct *p)
 {
 	/* see dsq_inc_nr() */
 	WRITE_ONCE(dsq->nr, dsq->nr - 1);
+	p->scx.dsq_flags &= ~SCX_TASK_DSQ_PROXY_IDLE;
 
 	if (p->scx.flags & SCX_TASK_IMMED) {
 		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
@@ -3521,12 +3539,18 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 	}
 }
 
+/*
+ * A proxy retry can bypass pick_task_scx() and leave PROXY_PENDING set.
+ * A cookie mismatch means core scheduling forced this CPU idle, not that
+ * proxy resolution put a selected donor through idle.
+ */
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 	bool proxy_put = p->is_blocked && next == rq->idle &&
-			 (rq->scx.flags & SCX_RQ_PROXY_PENDING);
+			 (rq->scx.flags & SCX_RQ_PROXY_PENDING) &&
+			 sched_cpu_cookie_match(rq, p);
 	bool proxy_block = rq->scx.flags & SCX_RQ_PROXY_BLOCKING;
 	bool rescue_keep = false;
 
@@ -3612,6 +3636,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 						enq_flags |= SCX_ENQ_IMMED;
 				}
 
+				if (proxy_put)
+					p->scx.dsq_flags |= SCX_TASK_DSQ_PROXY_IDLE;
 				scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0,
 						     enq_flags);
 			}
-- 
2.56.0

