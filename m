Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603956C63E
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096108; cv=fail; b=BtEzuMleV0wSIH+WmVf7KNiW7MxLlsIhyYuNSurg80I300pHK0riwxGPhKZouT6BCa6BXxmTRk+FOr73ZCG1hnDbQf4d+Fp4Hp2BgF2gKjxNlWraHxBsnaLc2zMib86PRsItPRopN95UaklsELM3ggvk9kdQEKp9EIjF80cwxqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096108; c=relaxed/simple;
	bh=yzfoGI1kdwDzpKJVLBZQO5R0jDU4lFil+t3/SRPe/hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=slO3KdAiM+guwwCvouHmIARtR4eXKzpXV4Zb69+uimxo8xYsFdNLWe0RH7wIUBXwXzMCpxKfVVV46Wo/IFRq1jWkG/+CvXpBT+iAGveH/+x8APkDvCvkiUGfZ8mqsDz2Zk/XAlcC6odtnOV3kALLLBIV2qKXERyC/Y8pFySIOxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qdLTY+iI; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qdLTY+iI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OydAqGHmt59YAR5vczlE2sCxgAauM6cdsYbuU+oMMWOeg7bSxsjf7YCW/Bx5o3MKnwgZhoCvwyJ6hk0w9Mq2LTW5Tc5s6F42SFiZnKCIjUu8pjfjSEPg0tPZ3pO0BnnoOGhI8jWKmx8D5e7FICySS9JRLNVubGTa7HweVTxRxRdfkZtzOrdSDOZAKiM+6DEfJG3yFJ8NhgKyzA6bJmqEpyBoza6o81MXjsukaALVBcQh7SYvsFPWdSXdKnDIjdo3sAwfO4Z09yxlPpdVQWslnytjOyFMBQmK0K2R6KzV+4g4DbFEFml75PKFUtiipsUbeZb1EL5WKQQbCpK+3ghVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcwHH3GThfLBm2GDHEfQhvJGMr1mLECXXYfEukpQnek=;
 b=Cp5XmR5RNOUQGrHWSmiufYO5CH0kpeLAEuksBI4e7yCNI5nUA5Rm+7efCqe6rvRNVOrVuplKcrHC2Pz8nS6Ec46WZRZvu5VQL7jYF55Rbf193elbXK6bVauMLZY4n8LCSxr1QE7huKTWhxgPwx3KNhPq7X7/7fmdpbe1I0uKyaZTaPlHV0hoKej10iRcsHtHAmTq/2+xquM9bWd6+ZZ15FK9fOnjXQ3bcHj2UyRKJ/GB7542fG/1MGs5RBTGA4Laktbss3zO9stHqNB95uYSXb5h3HsJl0ti0NWgwiYdcOyxpoyy/AnXReLMkdgpjAE/ESs5h4kub2dGeK503c7n1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcwHH3GThfLBm2GDHEfQhvJGMr1mLECXXYfEukpQnek=;
 b=qdLTY+iIiV4cLA6RqeEuqzd0r5UsDJMRiTCzrY/RUEFUdIWnkmftbLM8RL6FbGnxOlp1ZBnhTFwnSizRcZZA+3EFdRJikFYBf+TUQLRGNoZIW/aXkJo4RO4pl9AvyAoERcWbxnMepF2H/6qlRL+IVCCrW8fe282oLQuPbL/BLXKLiHUb9cQHFm7a/bR0dbfrQHI6A2fDjYyhXvsWl3TqvL+4pw1jHk78u9RcpObTWBnHqaeFWzp5+sjwVfRPhY2oucSmVr+TTe5dZXokFzwsEHEtoZLJCjLyHh2zKFom0mG4OZ8GWt2Jm+m2jEohQN7VImq0u0ZDsx3NmexcaIVTpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:55:00 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:00 +0000
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
Subject: [PATCH 02/16] sched/core: Dequeue waking proxy donors before reset
Date: Tue, 22 Sep 2026 18:51:41 +0200
Message-ID: <20260922165445.943315-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0209.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 4801c1cd-3c4c-4c1f-0d71-08df18ca3d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|5023799004|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qDAmSZTNL7rIvM2/RILRaddlqbCbBdKU86Iif/SaA7pIJFq2szhMfFG8mIucO5DRfJZIyLt/0fSvMCqhfhj1ZwZ1514lyWiv6GbBLKYJR7RK3Yhd3Rb8PhnZUkjTDUjOWQQfb1vqlp0n8fZzUkwFbOQ5C/s+fEdGnU+33hofszDw1qMGkxeDvVw/mWRMIj/K/3oAPloXV4zTJHKcJsvBvEAeTMFrJuLP1r/xTNWQEbSqstE6c4UpB6TcYUtwUDHNtCO0qen78I8EhsEQEZEqhA+xLrDLj0kEouhXayIcyC3EkW/8pPAgg2vw7OqF3tZzKPSSf3WdIADOq333jVrJcUgodDjfKewCB96zlhK/yrThSC0XJkKAzXk3X0Sf8VmjLx7CzQ97YaO3s1tkzlbscxrHl+C+Ev0/mYjNmMDnXXj4/u+J5UhUkkFvCWQtOV93QZlOuNaihQiKeDB2lvv/+L5KDAhCASgQ/YPNH8SzatLQXHkVYq7Huygf0UVF3EathsZOcqG/3O2PpElCE2UJ41Ndhb80z5V0yswfB0TgsFNTuBhUIb46LwoXQ/iNHLpbznl2MHRGjUUIOfsO1Go5AaUWSXhSDQZ2qCkmI8yh6ztB7vc5AfTQyUwE0jkwHXsfPrAxzwuXFpif016UOCJobPTfIESycmShdWHqcvR7NAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(5023799004)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Waqlq6Us0AhAc9lphIpUpPr9PIZJa8tgP8Fj8p04DcduxUqMrRJRdiK+h5fq?=
 =?us-ascii?Q?tlqrw5ej2gydu8FM0Ug+sDbUpBY86NeqXNnqjHHqv/B939vj+g/W3zZIT6+m?=
 =?us-ascii?Q?7JQnNbU5/KEc7g3gARS2TSuFkuIF240dhSQMblvp8ewi33HrbaX7jRQN+nFR?=
 =?us-ascii?Q?SHAgu5rcAkUzPIZyHDpet3Gi4TNT7WDyOFBYViSOP7+gdrqqBtoAqgcwQPJY?=
 =?us-ascii?Q?D3kxYQ6ZCoe3hdUjP9iJO0ixNhrrkmTkmwERBi9jwX1pMWjVbWavpSpw9vHL?=
 =?us-ascii?Q?dJhA0gKsbzRFTL5uwnpfAfa4DjM7nRvSm3jZ5kLdvRFRpyTla1RbG3xZlulj?=
 =?us-ascii?Q?Bg1YzRs/NdatILoFIxQROqz7l4HbSgqmykAO2q46/m7cTp6n5Oz4SqX46AfD?=
 =?us-ascii?Q?OdCfdjwpVzpehTJyXb0ySAR7pi4mvHuUU4nwwSf2+/FnflI8guHHle0F7f7C?=
 =?us-ascii?Q?5T0rvZywBYhLbiihSf7nKbXNZDPwpnrIxT+qUHvB1UAfRKsts+FoG4m6QxKg?=
 =?us-ascii?Q?oGQRFatT/sFvd722scSIq11EfLyQ8+QBL3WeIW2ph6hKv5hyKJM4pqVP+Liu?=
 =?us-ascii?Q?RMD6YG3tHOAzdNRuOBdqvMLaJ7v8bmRzwfm03Nr2x5gfNyZczwYO0PaQwfz4?=
 =?us-ascii?Q?Bmlj23/Hl8goBsKxAAeRlUyX4D+3CUQczrPA+nIu8H9nSEfFNGnrSP+KAcPD?=
 =?us-ascii?Q?sumMtCI8befPHFxBuewfyZJyN7vC8vzJmtrYqR3t8SFdZ6Acc7ciK8do4ZSh?=
 =?us-ascii?Q?1y2OBA+uyY2BSINE38l1tpPb8AQldEUIfUOdVapC1NuCM+E81OCLbgJ/PCxk?=
 =?us-ascii?Q?h4OKeAhYCRQdFXGyyF7JHkMrwnMT2ixFXyTaPJdXNzyc+xwo+f/CfesoPZ8J?=
 =?us-ascii?Q?fimIwD/xvZ/Z65LedXm+DQDqAZ4KcV1NvxQxhM/h/EjAe+Tm8jnT5xLXfWT0?=
 =?us-ascii?Q?febIS2xK+OedlqHZWrEn1MRcIjFEFtoK7P1IF4CO7BH3DQOQtGel5YgMsQQl?=
 =?us-ascii?Q?vvn83ywNjNIM0dCQ1ZuLrlxHgO6cjTSdL4Pv3yRbEyE3/sErv+OJ/1s7P2p+?=
 =?us-ascii?Q?dSPe7otzDEJ3SlCYjzbbK7c+gFzHm8zYuEx4NFyd506CF931xh89kTEQLFtk?=
 =?us-ascii?Q?UgGIk8e52jZqKTkN3fw7HGjvq4NX0Px4uvUxJghCBXs4n0oAthF16+7mQTUj?=
 =?us-ascii?Q?wpNXEaxIe2GF4aXIAmQBAWgpLaUPp5LqQrUmHhLCHsuhd1eLvz//Fiohncjc?=
 =?us-ascii?Q?JyxdhXHx42y2Qg4bXrs9D76641FK2x6BgB19uKC02i+2PEVfCPU4O5QKyLk8?=
 =?us-ascii?Q?cLr7T6XxSTnIW4yOWc3I4BTqGBMJe4lou7SGdbXv8nuYuvAmks2lsAUfhJPx?=
 =?us-ascii?Q?3USpPpUqChTT6J3q0HIe14+3XAZ/K2pczEFFbXzjzx6wy5vcyym4fUt7rKZC?=
 =?us-ascii?Q?nMbZkfnzMcAmFN6A2XMeZ9b/JCueypI0/XPE1vFMEOHsCrbnJ2Oa9wdnRSgm?=
 =?us-ascii?Q?8sugQosHzhd9OIg6iIC1oPosHXf4kAPgUCwLAMk0WSJg1JRfV3Xj+fOADKTs?=
 =?us-ascii?Q?41MzSR127ifwGHWrEXmo76BxIPw5gaWzk1LybL2xpydjU/sn0541kvjBQgy7?=
 =?us-ascii?Q?yS3XtpjbezfK+JRxrCYR3Wkn2dPFCvmhPeaqcrnIdwvq9WFYnIS+AJ5ZSrMA?=
 =?us-ascii?Q?N2qeGwipzKshYV90rYhjSUq+G0IChc/K0HbFQ7LKamMFSlN6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4801c1cd-3c4c-4c1f-0d71-08df18ca3d37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:00.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Qu5CQf87BWXkagR94ehDAHyy6BrnyIEZAmSu6LcHQ1RH77HMOFdtd41qdqI7pKrwTr7gFs3LJGfWAB4yHYtJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

proxy_needs_return() resets an active donor while holding blocked_lock.
proxy_reset_donor() invokes scheduling-class callbacks, adding an
unnecessary raw-spinlock nesting.

For an EXT donor, resetting rq->donor first calls put_prev_task_scx()
while SCX_TASK_QUEUED and is_blocked are still set. That path reenqueues
the retained donor through scx_do_enqueue_task(), only for the following
block_task() to dequeue it again.

Split block_task() so the waking donor is first dequeued from its
scheduling class while it is still rq->donor. This lets
dequeue_task_scx() end the donor's running session and clear
SCX_TASK_QUEUED before proxy_reset_donor() invokes put_prev_task_scx().
Keep the generic on_rq state set until donor references are replaced,
then complete the runqueue removal.

This follows the normal sleep ordering, avoids transiently re-enqueuing
the waking donor, and moves the scheduling-class callbacks outside
blocked_lock.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3026d01fd7aef..83b220e3a232a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2253,7 +2253,8 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_task(rq, p, flags);
 }
 
-static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_state)
+static bool dequeue_block_task(struct rq *rq, struct task_struct *p,
+			       unsigned long task_state)
 {
 	int flags = DEQUEUE_NOCLOCK;
 
@@ -2274,9 +2275,15 @@ static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_
 	 *
 	 * Where __schedule() and ttwu() have matching control dependencies.
 	 *
-	 * After this, schedule() must not care about p->state any more.
+	 * Once the caller invokes __block_task(), schedule() must not care about
+	 * p->state any more.
 	 */
-	if (dequeue_task(rq, p, DEQUEUE_SLEEP | flags))
+	return dequeue_task(rq, p, DEQUEUE_SLEEP | flags);
+}
+
+static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_state)
+{
+	if (dequeue_block_task(rq, p, task_state))
 		__block_task(rq, p);
 }
 
@@ -3775,6 +3782,8 @@ static inline void proxy_reset_donor(struct rq *rq)
  */
 static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
 {
+	bool dequeued;
+
 	/*
 	 * Typically per __set_task_cpu(), task_cpu(p) == p->wake_cpu.
 	 *
@@ -3797,12 +3806,23 @@ static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
 		/* If already current, don't need to return migrate */
 		if (task_current(rq, p))
 			return false;
-
-		/* If we're return migrating the rq->donor, switch it out for idle */
-		if (task_current_donor(rq, p))
-			proxy_reset_donor(rq);
 	}
-	block_task(rq, p, TASK_WAKING);
+
+	dequeued = dequeue_block_task(rq, p, TASK_WAKING);
+
+	/*
+	 * Dequeue @p from its scheduling class before resetting rq->donor.
+	 * In particular, sched_ext needs to end the donor's running session
+	 * and clear SCX_TASK_QUEUED before put_prev_task_scx() is called by
+	 * proxy_reset_donor(); otherwise it would reenqueue the blocked donor.
+	 *
+	 * Keep on_rq set until all donor references have been replaced.
+	 */
+	if (task_current_donor(rq, p))
+		proxy_reset_donor(rq);
+
+	if (dequeued)
+		__block_task(rq, p);
 	return true;
 }
 #else /* !CONFIG_SCHED_PROXY_EXEC */
-- 
2.55.0

