Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE913A9015
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901870; cv=fail; b=RVwIEoy/0cAOzs43I4klDw0rk9k9XwPyhY4szBhhBQcmaAnJsDB5TlFRgg3pXUov1d3WLdHGjUCLA16pnMEQJuSfohLvGxQMelgRfNhFGzZDfTMpz4MMXDAoTIP8V/LzkDVThUSbZg7dkTH5jeS+m2SPULF72mRoAnr3Zo9G3f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901870; c=relaxed/simple;
	bh=/6JKIGEQuuy/FnKgCIAvHs/K1kwbRc+/4mJrlz9q4qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pr8Y1bS2afyIFLa16dCD2W3DHHLlb0h2P/82ggdrCVC9xPlE0uxwwzZpJ4qK5Z/wr3+QiwMPcDrOQLegP+2zeCbRrcia1+f29FGT5JpWp7M4dw0CdHgs/ex0NrWgHIFCaRAmq6VavW2IXNItq1CLg0dyPLzuuxk1w2rgSJo8RsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i/fmkyGG; arc=fail smtp.client-ip=40.93.194.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i/fmkyGG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZOz/yb4lZPpE4e0dByuY8GOD3gNGTM9CdLfnj/FRiiu8lf7KRSEEkluqQOekJDXiYgOBp6tHgHNDw44uP6mxCKq3DYZ6iXTUQuW0g6h+KTjZFbAWc5/LQTpEHkZh+Yeo3JDxUlkEsYbv/EjMOE627okJKoNwBaZSjWZomhzv6m5QCTwxQrQNgu/H57C6VV5MA7mwazClx4SpQ9Q6mx1xsnfLWSBMma1YK2OJWT0nK3dFraSr35MOA0eEgAKrrSey18FGv3vuty+ih51SYON86Lz6Mnpi6aRLBHXcOsdJsmwqekMIKRegjb2L5fDMmtt86whbhoncR7pvpkTexAkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCP4oiiuWf0Wz5P5LoFllxnB56LiWTqkczgepANAczk=;
 b=mKzW+I+zb8uBntoICWHHKCDNjvfq+ntM5T8mDbg9qSLt0aJX2AGAVPX0UU0wuyjZx8gDQeEOuMT1ggBLoRKPFU6i5HaitQSLA0grKo866Wc7mMMjVFsVyS/QMBj5xjnaoEBjET1iQLWIdZEaAfxHE8Y8Of6BjIdQEOVXunLBjJ/4OfmcmRc3XK8bu//TigWHJs5xpL4qHGB1F//dh7Rd2CZYSg1h/94CJ98nxPjr+3Gg3C29oo3ECSzmfy+mLlJ1DQpokntRof7S1Ch2+f0SxL6HFe9hdQ1My0J34rnQEFOCoGqkeDSdosuz6GYEKjRniONUbNAJnqeM2jYUdtoZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCP4oiiuWf0Wz5P5LoFllxnB56LiWTqkczgepANAczk=;
 b=i/fmkyGGzTJzD51pg9WTpMdKUtykprbn/qI8rtVkmIcBTk/E+UGoPE2oJ2QrvV7+Z6GXqeQtdCNwqraEDNouJpP+5I74dT9zPTMyT2YwgtDIXkzw9HgBSvjV9Ls+DBG2mRv/xTYekECenffHLLkAU6W/yFDKvmBz2l5ggn+otCB4GpNrKNWNzy94/B4fMkmato1ABu6mnQVY4GiivHQ7sqNNzDmRKNdGDzRvEl/9twf4ou+wGFnVuJeSzp+sUV1qCQAwt9CcBUer1ChtkcpYRV5E+QBox/1Kf2i52XdNRs/eMwWaAJH5oDAy0Qd8QYzZl/gvqujPk1oZHs9JsSLlLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:37:43 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:37:43 +0000
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
Subject: [PATCH 01/17] sched/core: Drop mutex locks before proxy rescheduling
Date: Sun, 16 Aug 2026 19:34:59 +0200
Message-ID: <20260816173732.17162-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA2.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::452) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0fbe16-64c3-453a-e3a7-08defbbd13f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	BJ4dr1HPr4XpXqHUz6j9sihooyU2H6dtZVXpg1tApj9FZN0TAXLfUK5YENeuHDabWM2FZ83MXHPg40YJ7Q+nctq9PMG0n8lVXhxeJ5Z+tvRPpS6W0LTJn2Cadg4YihnyYHT8C+F0RbNWhgmGmhJvh6EuA9KoSOO0JEHLemuoNMyBUWnti0hrA5o1OhD1zxWnKZrbUTFNR2pzvhKAkqyKAuTDrg4jFbQT8xQjzY3fVrZtmXKjlpuDXcKPXfAIE7b+d6VYvVxslni3bEVWHEPoDUG33Y9o1Vz6JpoFJzRrP2MnvmoniHkw9zdxvS8dRWbxwcW5w1a1nNNJZU0qKCos9rHJSyA6rwBxyAgnFgvI/eGr/gh9OTrVarUwJl/OHeyD1Xmcc85WRtDo8lKqhSm7gJyaOuZ1csMVSB/HdiRyLdk/GZYYyAx7s66zLlghy/2EPoFQ8eRHJyc6ZIFbTN1Q7WIvPTIwUZE2CqKcsqTO5cV4lJUP3mezugYb9bjHy8w6T7yub1pXMwOd53MiRZ18e3XgPAtPE7HtWvcHO+IYkHDbpDqh+vFMqcDpV4ekgI1G2PDpcWqoncJxGR1e8b5LS2IZq2vYbLJk9bO4fwgYTvhqVzTTfi5oLDwVJoK/jaNwctEy5d7R/zyPCp7uNAfyPWW5q96vKkDjD57EPZwLd80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zhN8pI4Ib5y0455yOnAJj/yhAcN4yXmxWj8yxxu/Ng6KUD61epgm/Bc6F9n0?=
 =?us-ascii?Q?VVW8a372WUceS3F4gCNkzyxzF31wJRidYywZ1KMz78PbjIwvWoD91Vh4g0hi?=
 =?us-ascii?Q?A4iRRUvzOXVs+aFT5pizzXjUUTdaVrEPUtp+G11oGBjursVwncf6SaWMWim8?=
 =?us-ascii?Q?XkNXBpUToUNQVEDxWMvQczihy1HLtParhbvpuu+0Ad7iLhR6wDgTkc6Wwy30?=
 =?us-ascii?Q?tysd3mKRGNl4YILkCXtbBT3cTTfFOlFdZ6X01yiBx63ctpSpLyKDEER6C4xv?=
 =?us-ascii?Q?iYBnMHNIFrWHHAil9Up89f3Tlxx8mZXN7QHA7gUzl52SG5I0uKQn4A5I+exJ?=
 =?us-ascii?Q?PXmj4UEf5ctOzMHEZCl7IMJZdNDHDA7uu2NFVuQ/mcPPqXPZ964uGlWqufky?=
 =?us-ascii?Q?wBJHDhroZTachxNH5JHvbnynl1Nhh7ZhT0kUI8dsl54CEXTVVWzJg5vY+GVo?=
 =?us-ascii?Q?i9Y9oPpLt4a//nWovQLLweMRbGTFLw4Ys8Y5z5/VBfCBlE+Vsa5VqrjSlZMc?=
 =?us-ascii?Q?uDS87ZA6K3Ebzm8zo8y+d43FerUMPg3bsNtJn/CswGZJ1HMxlP6kH3h8RnaT?=
 =?us-ascii?Q?+bYTeurYZVxQnAZ2hPqGx/FjhX3Q6iqVthbjpvirSH634N2Gv8DcrJ0eZAlz?=
 =?us-ascii?Q?uLWPxzKzlaT/uqeDjvsKmD1iaI5bChIJUhzmSNbCsSt5zuXskoFmmIWMvpbu?=
 =?us-ascii?Q?d0161pcK+W83RbTPJaDg5TLYw3Bmh25FVoEkaqnYF2eIUiBWBWp6n+CVtnia?=
 =?us-ascii?Q?+3R0fO1FwVGWxsj6xqtiz0zlM9KFlXPtEQRKpMl/r5/k+5cZ5YpgSVqRXdqL?=
 =?us-ascii?Q?xCMBWhKc6RrZ5f3t8DaEfoW+7tl5CWZiByetwkJN9hYc7h2GHc+ZDIYQahym?=
 =?us-ascii?Q?gg95/I15IbWK2zHdCjwc/mXS4ZShe+FcAbHSopQyZEInURrsX2M0VBCgPsjC?=
 =?us-ascii?Q?Vjeca/dBi1NuP82QLKXRAX5ycCp2JDYaZXBCv7mKdX/7VbsNkLV2MkbN4ock?=
 =?us-ascii?Q?KS3i9ToJLaJ17RaEA5jXTxM1xnTDuKRHYN0ormcx+WB9o3SiAYW2o1vtNyjp?=
 =?us-ascii?Q?880ebp2qnd19+DAG7TQkB5nkxE2etyHmPWbMldBHQc15dkrron+GYMS8pRAL?=
 =?us-ascii?Q?S+x/e+rVVIxVcesXovwodNihlkV81BwgyByW3FoHKZ11uDDHy9LTd9QnmnAV?=
 =?us-ascii?Q?6LKSMG0d5hH5H2D9s5Doy8XxS6Wsc0v6vwwy14ZB4HSBrA5yO2GB7CdQPLMO?=
 =?us-ascii?Q?PH8qmAbCxvuWLsY1u+DvHbULSeupX/Fqh8/FQdWrinuc6Y2Gbu90J35hNZEJ?=
 =?us-ascii?Q?YPmrEcw0hBerlCmmz/EPjpMoXah0S/Hqu+2gSS7w2EHDRHtP8BQFHKAoaM+m?=
 =?us-ascii?Q?XWOCOyd7hqPdDlznfgCVcznJzYOLOxzX4k7Xj5DXaljHXv7LyZCvnxqNoJAK?=
 =?us-ascii?Q?J4rg5IslqA5dOtQPDt2JHtyrTOu+PJ6SWnTRleK7La24ltXiYRUWh3I1uV41?=
 =?us-ascii?Q?wUUebMUojS8kJWaI4nLqMC/HJy1dQp7Lr1EhZlqvd/QAbOgM3LI+2orJrhn4?=
 =?us-ascii?Q?d3kEJW62DgahW40hheN130dxUrF1hcOAjGnky8zGabSiktwlZ3vEpMzCvEHX?=
 =?us-ascii?Q?3NC2+p2CImz0eKqAPtjJL1a7YiQwG2eDutcWGQca/YUNTOWInYI1Kw7cqvZl?=
 =?us-ascii?Q?DUh4ExJSTs4U1mjz4vvpd4dmKnvZXtPES3i+Dnk10UKEczLPjwaRFKIa96Bx?=
 =?us-ascii?Q?OdW1WZTSJQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0fbe16-64c3-453a-e3a7-08defbbd13f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:37:43.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDrynlX+zwfUKQ4g/j3HB+wHyKDjz62ktYBdjeoP2cqvA5w0IRhxDqg5NlE4iUdpQA4D/PiGpTt3Yd4P3I5kkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

find_proxy_task() can call proxy_resched_idle() from return
expressions inside mutex wait_lock and blocked task lock guard scopes.
Return expressions are evaluated before scoped guards are released, so
proxy_resched_idle() invokes scheduling-class callbacks while both raw
spinlocks are held.

Route these cases through a common label outside the guard scopes. The
common label is required because a direct return would evaluate
proxy_resched_idle() before guard cleanup and run the class callbacks
under the proxy-exec locks again.

This is a preparatory change to support proxy execution with sched_ext.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0130463798f84..e1b597e6bf413 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6955,7 +6955,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
 			/* XXX Don't handle blocked owners/delayed dequeue yet */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			__clear_task_blocked_on(p, NULL);
 			goto deactivate;
 		}
@@ -6967,7 +6967,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * and leave that CPU to sort things out.
 			 */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			goto migrate_task;
 		}
 
@@ -6980,7 +6980,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * case we should end up back in find_proxy_task(), this time
 			 * hopefully with all relevant tasks already enqueued.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 
 		/*
@@ -7017,7 +7017,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * So schedule rq->idle so that ttwu_runnable() can get the rq
 			 * lock and mark owner as running.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 		/*
 		 * OK, now we're absolutely sure @owner is on this
@@ -7029,6 +7029,8 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
 
+resched_idle:
+	return proxy_resched_idle(rq);
 deactivate:
 	proxy_deactivate(rq, p);
 	return NULL;
-- 
2.55.0

