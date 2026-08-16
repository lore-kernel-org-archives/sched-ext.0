Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C9B3B1ED1
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901871; cv=fail; b=t1C5ZLi/ZcVuBXqufpbdqzMzDGIMnSifdZ7dkr5D7KZQd/owKXtWgfKPOOzjUKzKfp9OPEMcVEjvD+9ndDCzKkFRryZYiDAqrnofWCvzp/VFYt3lbVbnOReiT19WaacHdQQa8/FnfBWQcFbIDZIj1pnSzClIMgvJHB7NJpISCfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901871; c=relaxed/simple;
	bh=ColR+tHpE9MKQ6giG3ul8FJ3gAr0ogtUTm9N2zDTnN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mg0U475At4NuW27qfAZoQLsCI+lb9lMwm1QhJg052f5oFFqQYHUzssbeo4aJk5T3y0zbPt4XZCShUjfxjyrX4fAYX9A1YSXHVjYkOQTX9zG9aMlQyzz03uEojhzvxFbJ9wV+CH3RyeUvO69ZiRiyHjxHxc2iOfCdbXpzBQMBclE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ukx9PAtr; arc=fail smtp.client-ip=40.93.194.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ukx9PAtr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut3OhYWQjEooxWF6y7zC9jS0QhSif7PnQX8v6Vp/P/lBxAaXtf549VxUksmvYKOzvDYlg9O4E6amzW335KBfpvHAKlFG8yvAnf3q8Yrl/o0RL7Ys5VwHePoozsya7vYiIRC3P6WwVa2zfFK7OidHSKu0eXuef2ynPijC3znS2knuA2l1ZEYjrNqbxW1NBL8551+EA8yr2Cy22EY4I884DSb2KhDNFQ7+UDtYbgbw7nwiqYRxydFhMQSD6ZHirVvr/YfyVnz4W0yVj0jNMvOJoKdeVRuC8zpnWT9CtzySE/FX9I5dzqJHYI++edjqvYMqBuw7an0NAX+2OgaVjZ/LiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59xZQz77mk+dx/zSiHter7P3xLtOmCNoVb7ofO1v0Ww=;
 b=NiAxvnnKP8pmSFnJhrvskKtuSCe5u3V9ub6tA0VWjf584ESViBeJX03U8izNiH4Atjdlwqk9yHWPjqRz9eIrarXgrsYTEgE6gpDcm+v/jjxu1Uu3XFDZL1DZ4GNH6gGIr9Jb5l8CXgiKG1YkiJ3RCM8nt2XnwedtSKTsddg4+L66XBXxkz7g3bq7H0GmqiAja4yzQj6AKcgTTnn0SHCPGOQ45a4Bq69O69AzdGfXJjvXHnzkETqCETNkQ7Go1Z4DLmrY5Dr6rmHo9QYQaTAW5h/wk0AbnOvNhaLABCyCIiig7i6lA8FOxDrmIJpm63pLsqi86NE7nUFttcnrWXVyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59xZQz77mk+dx/zSiHter7P3xLtOmCNoVb7ofO1v0Ww=;
 b=Ukx9PAtrGxbjptFBGCOOhYu3H0QT9A+TkizE9wH7WVFiieGp+gkqzxQhsQCsGYXeBb/6nsSy9/RJgWSShI+ld9OBc4sYnQiPwGbsFqFLrzszHpsVLSpqOcc1ejmOidvcJKOdxCmdrzUtyO4L6uOR7/6Q3ap8JmybVUQUqjjnM0k+48Ie5XiS/t6usQ/NPlCm79wj9OA7pj4IOffYxR+hLX3fQbA4Dhc07Op/n5fJmBDAMqDP+5mDvjhFmrW9+on3Xx4sePpeiBKiHBUVE3YUJHRDM8CxFq95ROhYhHltsXR25v3DG/lyeyXndJnM9elqu7LW9Bslifhz29rl+DHdrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:37:48 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:37:48 +0000
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
Subject: [PATCH 02/17] sched/core: Dequeue waking proxy donors before reset
Date: Sun, 16 Aug 2026 19:35:00 +0200
Message-ID: <20260816173732.17162-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: f75da4b5-93f7-4e3f-b611-08defbbd166b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	cuIBWdvsNSqSh6V/Kw7LXIKd7cEexRR2suD0Pnoz9DZ4DTBtb2TeC5RExJn8zBWxi4h5IKQT2/QHunjrRr9ef/p4k6tnLZIxFPSzS9y1jYMC0itaN0KuMYHkukQKCyN6hu3PFXS+/fHVaDx2q2XYRzygnTnYevUvXSXqkmDWvpdv/j5N25H++LlgYytt+F/lrkECE1uyrmWWFYaLI3RWse2P1q9RoOdiWGtdEbNVDz3OGW7FkqQWnPOSJoZkCwp5zU4GP07lFU/WU8Gc3kUyfFqJgm3Xl78NvhmJcjpSjeEQYc5+qy/gtXvNDvOtMzVZ4v0aDxWrQ+GFq64W/D4t2AU+nI8/h8Ll9DPFj1F2jq8Vrzpjs3rte+Wdqmy1K61q6F7gzdIbvxpgOuK76updmYeUnVo7tuqmBdJ6rtchUA7UJJe02tprnqrWI/Noj/mUhZc3bSDVkSFNRAqLoQD6X0F5UpqdyO1z1VL46a8T6aSR/k/HlyMvIf3LEXd1yRc+q1GF1rJf8ZeFtrADf2LEr0lUNStSJw0trwTH4+ToVgjFUBRqeCOBn/UbTd5qAnADOXEy/gUV71hFSDjiCfBq0yEI1/tGVENGAjsgbScXtEnUHhg/dITTqDq9sUVl087o2T4URiV0cJEvRbkTJAEdnt4ZcyOryL4zzRLfFu1aitQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qjdqORDA79RxD0+ZxEDUX5+fhjj0Qp4IviPbep6GN8BNoGJoBRP7kH3nd+pX?=
 =?us-ascii?Q?zCBKWaN4sHjtAixKFFT7kFPJMJHpfNpVujpD72hi9YPEhoTK7A2ZbXYuN6Jc?=
 =?us-ascii?Q?D9S4HPBBNRqmxRHqKakxex2RYFPhMFQnuTxOWMJ2cj7ujd2IFoHlJCN6sPMh?=
 =?us-ascii?Q?J1NT3TS6aqIHUdfzZUzto8UJWMSQKydP/dCB6BrNU/Bz6E1XyGfEE03n3NiY?=
 =?us-ascii?Q?uG4Q+mVLq2t+J681M1LesEU0TrG8YM1b//idi5qpXfp91HewhHRen1bTjtyS?=
 =?us-ascii?Q?U93h/v7klV+iLtiHZl03oFbFcQfm9CxxpP+uOqXhIb4/CBDAW6kwEH2YDZyj?=
 =?us-ascii?Q?sGxl4oZy/MxrZ+JDBcjNkjVmIfU9bVkgLJiudDcALN/Dvk40qlIYmmPpYHc1?=
 =?us-ascii?Q?9Xkw7A7Rj8EzIn+ZLmafqymTnf4EFozuHRAvbYxGxmkYyu5y9Z4madgceF0f?=
 =?us-ascii?Q?icTplmrn1YXFmQurwVIXT+UnI9EtN53jqQylnxnac9rnWklgtbyAw1hT9C6w?=
 =?us-ascii?Q?EjZ4haNBocDjLrWSjbNvbiA6sME32bdK85PjLMZ+IWxz50ph5tYBNes2kJ+2?=
 =?us-ascii?Q?SfYW4bcYnl5wHivCM8y0WS/QS8wtxNwymjp173qgFUDz4v7pCigwcx4hQCwx?=
 =?us-ascii?Q?XBrz0VdiUethnxv8LuHXRxNYzy82quyh1nTUt5ICX1ozt5+m3Jx9sWFxOVWZ?=
 =?us-ascii?Q?M10LSE+Me27luBVM/Oe5uPgIb9+r6Jyqm0yHyY/h47Np7wc+9ee7DBs4zLiT?=
 =?us-ascii?Q?Wv03Rq7ZyNJ5idB95he1PRbXmUlpXpz6MbyShDZvbDgI4s7VNCs1saU21SGY?=
 =?us-ascii?Q?IWlqzMVlCoUbiJ/2kSEocda4kZWXQxoxxX4Uad3zQgzjRFomy1dFzIj5uTC8?=
 =?us-ascii?Q?UCOt1bEDeke4z26xQmdESVn6WNpgTLzFaZdx71askBFfz1nT86kmATqUnLkj?=
 =?us-ascii?Q?9+A2vTypLHoz7nQ+3+p9/GN6llUlXSflAO2f6jsZeV5z8yrGYXEODry1WtIK?=
 =?us-ascii?Q?Pxhk1HIoPk78hlQp9VQX2nMy001xOIdZrOh6x8btoCww3BlFB4Ufps0VJD2z?=
 =?us-ascii?Q?LC4F+EfPGONO6tQIq+tLM9e7bS1G0YMESpzxXmq6A+4p1TMx2/Knu77SLGy0?=
 =?us-ascii?Q?2RbeKbEgyyrydzo0+SVdLfL7k3duhqhazZ1azLlmnTD4jqqf1R7avUiP270I?=
 =?us-ascii?Q?DNHL00CcNPYaXmVzgX1albMfqYALhH7M58HyPFEufwGzwt/dhJiI0QM3VwYj?=
 =?us-ascii?Q?2ylGnjdP2wgouF2r9RB6W/OFuB1RjV/gIEFlW56+ao29HE121pZivDqI6DZ5?=
 =?us-ascii?Q?uRtPh9WdbWyv/VjyTR1dUM/ceSvJYZaFr3rK9sN5/p2ofTmCsnNjOihjj5bL?=
 =?us-ascii?Q?besG8FqNQMRq5CaBq79inf+yRHfm9V1OLJqnnv5S2iv5v+wpjLsLD7zjyML/?=
 =?us-ascii?Q?GFSdxvsmbLTVx6pk96uFc5GCf+IudvXZMmsGJEXjZd0/Kwmf2FGokleUbJi2?=
 =?us-ascii?Q?9SB4I6H7RVhdEZUqby9vs589JIqDTe0kpoJd0GmoADp4A1gXvCkBUKUHHAuK?=
 =?us-ascii?Q?f5pdzbWVfJNiTF9ZF75zsHrH44nlxP+okjtuJxmAVNIZtTayDS9DNsDA/fyP?=
 =?us-ascii?Q?CUOpb16BCbGAo2QGMVbY7w4Q+65BhoXXbAe8gApemB0lFbopMjJybMiRwp6m?=
 =?us-ascii?Q?gdS4lYb03BjEGXViOjqblFv4vXe1V1lNBGfNocYqrR7toTUVVVglnZDA8A/+?=
 =?us-ascii?Q?6Ga9RK7S5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75da4b5-93f7-4e3f-b611-08defbbd166b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:37:47.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReLcuUKEn7I8/ILx4d8DWW2XkwnjDb7f1E9/gMso8/MS7Ml3uu+cUtXbbLLmsjuXn2NVCbPR/ysLfIlw1lJvEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

proxy_needs_return() resets an active donor while holding blocked_lock.
proxy_reset_donor() invokes scheduling-class callbacks, adding an
unnecessary raw-spinlock nesting. It also presents the waking donor to
put_prev_task() as still runnable immediately before block_task()
removes it from the runqueue.

Split block_task() so the waking donor can first be dequeued from its
scheduling class. Release blocked_lock, dequeue the donor while its
generic on_rq state still prevents migration, replace all donor
references, and only then complete the generic runqueue removal. This
follows the normal sleep ordering and avoids transiently re-enqueuing
the waking donor.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1b597e6bf413..27164afc7b0aa 100644
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
+	bool reset_donor = false;
+
 	/*
 	 * Typically per __set_task_cpu(), task_cpu(p) == p->wake_cpu.
 	 *
@@ -3798,11 +3807,19 @@ static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
 		if (task_current(rq, p))
 			return false;
 
-		/* If we're return migrating the rq->donor, switch it out for idle */
-		if (task_current_donor(rq, p))
-			proxy_reset_donor(rq);
+		reset_donor = task_current_donor(rq, p);
+	}
+
+	if (reset_donor) {
+		bool dequeued = dequeue_block_task(rq, p, TASK_WAKING);
+
+		/* Keep on_rq set until all donor references have been replaced. */
+		proxy_reset_donor(rq);
+		if (dequeued)
+			__block_task(rq, p);
+	} else {
+		block_task(rq, p, TASK_WAKING);
 	}
-	block_task(rq, p, TASK_WAKING);
 	return true;
 }
 #else /* !CONFIG_SCHED_PROXY_EXEC */
-- 
2.55.0

