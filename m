Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015593B774B
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786917386; cv=fail; b=eP/Lj7wFCNaBfS8/zZbxuDqZGbrQ8AVRnN3SUx2TxTwwhKLip6YGafdijnE/Qgo+8SZWfl69ML972OXNH0F06ZmXhGkZX6Nf7ZGFesn1Gy+8CvOzp/w5/INGJ40M5wGv07+ykecdj1AEk4Z8phognqTVX7O9747plxv/InaDrbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786917386; c=relaxed/simple;
	bh=HMpzPOuxPkeR+4G3hIbrG5mCgtCzECqUV293itkG1pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwMHefq+nmIOxvgezyVVzEZNe2k0wwgd59JCj/P+flKYeWDsEx/rSgT9dwlhADcmbAf5UNJlL8FWUOyMVVBbraMZjj5lL/dUhkuSKvPxYAsp2B5tT3w6REEI6e8/DMKuo+wrvrmM3ltylX1szh53oYTDPTltDpddB19bRddrhzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l6rB+GG3; arc=fail smtp.client-ip=52.101.48.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l6rB+GG3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+wWyCMSU3zT+uYeGvNV4DjPBMRDtk+VGaW8q/gezjQkVKx52HzoMgdgk/oWOHWnPKapKabs4shHuMjGD+v3kbbhcazBaZ+oTJvZhVBpleodn527STyqXQbXZGg8vkX+GbyOe0F7Q6h8v+omgHFkwnyifhkNRoQRgLuaQ4lGvo6CC0HJp62eWzXtvXZYEPwcEjw7hMdcCQFzENsiGiYD3AQq7bWRDmq2e7n7SDN4zCnrprWU0i8yZeeC9EW0y5nQpZFS8VQg7qoY2Bu9CT1b7zM8kqEvMx2uUWXXKG71+mAQwQXKA/UFl8fm7VO9aH3BkqN1S4m+cJgbcePKzJO/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0WbQUXanApcVhhTog7coBKoUddYVTFGEHN+idNoS6Q=;
 b=MK6uCdvLYWOSmjA0iF8EzImUMo4ueYVCGUmccJ7y1uXNf4xZHMSoNdfvWJ0UiumZjJ4OSMJiS19h85vVT+RD3TeK2ae2QJRS/mBzOWIsxurATKtSxu5Q03RnAR6TrAwuD0MF6Hg6APntw3yVTefRdCNxm6JsJyttCHscawyPWuwlf+/a7dNw+9H2SqvZtEGo6Jh7Ua1rjTCOLjdbMBF/m3VIdin966xAvPgRewEug5pfk/SPM3MES2sjWdVBC4bQYu0XDZBRNQrr9M16zipESa8O9GhbALwI2QYd2fVoOqSMuFmP148yLK1ozxYZKeCXE4c37PF/3rJ8is3J3irQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0WbQUXanApcVhhTog7coBKoUddYVTFGEHN+idNoS6Q=;
 b=l6rB+GG3XMMQylfuyubCdhz4PDrp+gqc36Aq9bc+jwLlksltbeIqFbHWcp9SyfR7mOwSMxwyDWh0uwUnesjRW+KidmICB1UCRtpdlYYxCRcuGFhekv9gq19MrbCYnrfJ3KC7JcXjE9Ywd9cq77xKGS6mumWqXianMQQL+xzy416oJsiglxCjgUjjb69Fv3gJqAVh9ZXjXzP990JHPJQ5+LJauZpY7S5JRJr8Ia9RCSWTyJHj/6QJXNFY+RxtaOP3addGbmGv3DjWlC2MzqGrO76+WYI/FGCMqp4iSTqnNGC+NE7cIOyLm3o4NxyFwvWSaaRKn7lVP73oBLWDry623Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 21:56:18 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 21:56:18 +0000
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
Subject: [PATCH v2] sched/core: Dequeue waking proxy donors before reset
Date: Sun, 16 Aug 2026 23:56:11 +0200
Message-ID: <20260816215611.77729-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoIbm1-oACB6AZG6@slm.duckdns.org>
References: <aoIbm1-oACB6AZG6@slm.duckdns.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d63fcec-c3f2-4080-8a24-08defbe1333d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|6133799003|10067099003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JDqJ4H0ppNDDjexotlP06+4nmpoyObbu/2xZ/5beBh+basK5s476wK2G+w2R2lnBWnLu+f/JS5OB+m/ht32opCOVzH2lOPet0AUQrmCVljyY43Uer/3TnRuXOx2yMZOSK8/3ymCXXUcQYXd/Io42Xp7RiYLymqkFpHESh2GEypE9tssM5HPgP6PGXmDmdw3QXjzpj6ejmXQSRDWqhh2ibGAB3nxQl6qePgIVFRcbMjyJHe4jyKDF7cakm6tiBxZV85nt0ENzhK4yt3AaAq1H1B07+NuiGO648xGcUQNXPrCwKDXDoFaClimugwEodAlF9BzZQnM3KHNcHvVhWO8rJQvQfUOETb9rcVbQFerTddaLBTX43LQof1ShHKrcaCdCrxD5+6SnzharcOVLzMR6NRQSF1xbyf76lZ76VF0S09ETIGSGJca0H/JPSs7xnlbR1K81JWBMhCBM7XRRAw4VGfYBZnt0nhdgkdEGk5PXxcWDz6PeEQu17Z+sr8zDOta7WgHHj8Hrk6Hen/85In1N2cz5z7bDjczIoD5ZkaAHJy7QETgtqzt/1qNeIJRP96ydzHK8NNPXGk9RmotDo/RsFaEq93H5WfQsNEqo/ZyhSQW+R97n1nWqqjxAXRUQGtMbtQ/dAkgpnN74LqpknF3maLL2wbjirbbpGu52icsoG2w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TzAB6kOEYACsApMpjphYB3iDNlNOymCFr6ACJ+fVROB4Te1uTvH0jKWGEsla?=
 =?us-ascii?Q?Ryzu76U/m7+7amgiAXZoL2zzIw2aOFXY7hppNZatDHnF0cXQgLER+ENhX4Vn?=
 =?us-ascii?Q?DCQudStUqQYKYYCjKZKeaQjb37aDcgqcASol7N7H+3nPNzXAWeoUN67W8Kqg?=
 =?us-ascii?Q?eXL9GbKRFg7qngNAStyfOvjjkK0L+mIaIdEHpVVLS2GH8XUdSE/vN+PsEz/E?=
 =?us-ascii?Q?Uj5pQ7t5GRK4xAm9wgitQAF5+4WzryukMp/yfXx9KLmoj6YxTrNkNQTqW76c?=
 =?us-ascii?Q?ESSrD+X6JJ+iEz49WgZWvDGdvou9pwM0AQTvQBua609W+LFB+EtdY9c3KXtT?=
 =?us-ascii?Q?SsJnmKKuNkK55D0YdkFxhgaMGTnqNdVNxdHhOmKlMsPO8O0JtGGAI/eJUzac?=
 =?us-ascii?Q?vYVU/iRi95I5sX77WhAhYAhRTjYxpL7Bt83WjnPTOMxJ3e+c2hWNQJcDSYr7?=
 =?us-ascii?Q?8meQvL7lZddd6JC8JuMUzvWgMznTo363feiVAU6oaukvxQ8tXWbcsLzclrSA?=
 =?us-ascii?Q?Ww/WE2EKlEIvn+50iD6kF0x2sEQGsaJlfl1ji0m73c10Bogpeyftt1/74eyP?=
 =?us-ascii?Q?YjY5DZJuGDDGkS+4/PkMigzQuMyhriBSZiv83rWV1nweYbk/4vzqI7wR1fdd?=
 =?us-ascii?Q?WNWT8jsLGKq0cXFO26p58fkXvMl73vnqf30OJWsg0tCpwMdV6C/Fok0JFPbT?=
 =?us-ascii?Q?FzMCv8Kas57y1e3j7lwdqZEsGJsTSLUB76Q/JMxfGzBFpdWUBODth2hAduDK?=
 =?us-ascii?Q?/GwplG4LJFuttHtq3r8QZZmivTZWRkDjjcg1FI+nU0unyBs33WuqF1MgeV4W?=
 =?us-ascii?Q?Jhgpg1PU2l7C2qYMHvCMzGVZnMVeROsFEuMoO5WKMH4k2xrIZWEX2OxkghQA?=
 =?us-ascii?Q?8a+xO1/uxg338htoA04UiRUv6v3s4KiwLikOJjum2V7w4BaXyfF8zHyRmtLD?=
 =?us-ascii?Q?L+2M9PAaloYv3BDvYRPeKpedTmD3MtFVJT0ePUINnFHz+oGS9+IVjZoKQC+n?=
 =?us-ascii?Q?ioOxolWrFcvCm5APC1D+fO6FpFPSi0fTRUMBZx2qU5Vsnrb/N4OL0wLRhwJM?=
 =?us-ascii?Q?3U0AGt+8tzADgoVjLWL8vLtjArC89SqDs55Mi1NTY9gFdvRFKXfkCH/21KlC?=
 =?us-ascii?Q?Bf0mkYcnIZLST48K6hfdOHkPoQuNe/6lYylud3JHcgODVqXDPEWUDZhA5OYJ?=
 =?us-ascii?Q?ksnhA4v8yYHJY6PNV2/HQKNr5EgbyYLfheX2HhLQstTrxvbRRqiOjw6Zj/qO?=
 =?us-ascii?Q?ABGVXWIBscY71RXQ3sYRR8SzxI4wKNjDmP7q2XkOea/8O9ThoMEqi5KJPV17?=
 =?us-ascii?Q?MWgYNekZk2ZgedThSicknqYgNfeAsDwjTfpWyNztMMqJWSJYiKyLKsGIGc+s?=
 =?us-ascii?Q?4EojCksPIpN44WFwUeONfnZ6WQV5zoEHfinvUjYFWwLNX6QvQYOmFqv3hCH2?=
 =?us-ascii?Q?KZ/UJUuc7MpgtsUrR/eLrPap7rKH0q9s6euECh/9SaRqSOTP2+Rj5xlcrMFw?=
 =?us-ascii?Q?Ke5LjL8DpFrqR0FHqzBPA70ER2d9xWn04CBnZLUtV8q3zwbCyondQLlOgeVx?=
 =?us-ascii?Q?6EZQWYt++jWC1BvfHpo8+ZlI3anY5/Inh5yLTIu5EHJ2CAU88LGrESnIRVlq?=
 =?us-ascii?Q?BHO2jbrbhX8RWIylkHdtM0SIQrtFT+QfJBX0rAUDUcvBypE0+XbgFiRYgl7U?=
 =?us-ascii?Q?kAQSo5jpNikn6pjQguWguYvd9wznphpm2m2ChDLddW58R2Ev6ot7trIpy75V?=
 =?us-ascii?Q?jQJOOj/WDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d63fcec-c3f2-4080-8a24-08defbe1333d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 21:56:18.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqjoUO00XmLBisOfktjpMSfw2Y4p7HiMVdeARtuL3gv7cPfWsWvWyyTA2zH4E1jkvchZ+ESNVhgg5+gs5zOWLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709

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

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Simplify the proxy_needs_return() control flow (Tejun Heo)

 kernel/sched/core.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1b597e6bf413..a77c042c3f7f4 100644
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
 
@@ -3775,6 +3782,9 @@ static inline void proxy_reset_donor(struct rq *rq)
  */
 static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
 {
+	bool reset_donor = false;
+	bool dequeued;
+
 	/*
 	 * Typically per __set_task_cpu(), task_cpu(p) == p->wake_cpu.
 	 *
@@ -3798,11 +3808,17 @@ static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
 		if (task_current(rq, p))
 			return false;
 
-		/* If we're return migrating the rq->donor, switch it out for idle */
-		if (task_current_donor(rq, p))
-			proxy_reset_donor(rq);
+		reset_donor = task_current_donor(rq, p);
 	}
-	block_task(rq, p, TASK_WAKING);
+
+	dequeued = dequeue_block_task(rq, p, TASK_WAKING);
+
+	/* Keep on_rq set until all donor references have been replaced. */
+	if (reset_donor)
+		proxy_reset_donor(rq);
+
+	if (dequeued)
+		__block_task(rq, p);
 	return true;
 }
 #else /* !CONFIG_SCHED_PROXY_EXEC */
-- 
2.55.0
