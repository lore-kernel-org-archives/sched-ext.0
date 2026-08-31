Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE75522ED1
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183856; cv=fail; b=jWpeMeXEMsgoQb7SE8J4ZkMTz4cHiQa2ebmDjFLlobYZc78cmPFLXDo1arCbqUBSzENBvGlwmsv8CmqIS7MhC/lYpAiA5xfneR8n6AS+qyYaF2fgm8ebWtBDKCey71RGnAfzWRJfOkOhspHN53nxhGjLc6qI6UwlCRJ9JMJLVik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183856; c=relaxed/simple;
	bh=Oq6xmh92QkGHnPwUu8gz/zwNU2NmL5VwxwNjEw5f8uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhJocAvfxT89+/638z+O1QYjaTh8WrtGcMY5QzlypIKxNT8RVBrWRQOH2llJ4v9ovbTFBaq0Am6Gsen3nQx3ZGkuX5ho/rrGZJb488FYLG3CpZTb4v5Jm0N9eeZTUg5Qh1agLJIefz4FjRemGMz3vZQCUACiGZ3haNsWbeSzp/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TJghdJ2b; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TJghdJ2b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIrdUN6iRtDt0ns0SShE+o3RS7kRnFhxbuLEouFJUqpd7Yv9I2rhV+f3wEgW9A9XJ9y/y/dt5dhelsgxUMP432rkp+GcamrK/2R0iecPe54RPG9MQ/qcOVVdEr50JGJAqvS0wxjWu+Xwkznlq+PHt9D1aNGS8kEcpMtF3QdTOHyfrK1SVJT5G9YwjEOi5YdJK0R25Tc9TA4wQO/QHQdSP9vkg4iOOwskwJs8vggibXs6ihP1P2ajSdGwJl760keYgKqPxbbv45YSEcrXcZ/KwDpU7KXO7up44CHA4+VMzUp1e5Cvhd7oyaOL4DyjxobX/ORJIK5PH4gqDcgMx509rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiZoPV1Nm5qgTSiR8OpUKaRmqyZma22TeG1uvkt9iRo=;
 b=jQn2VeI0/Oj1NTaUxBp9yAmIOKrlm54eJxASiaInVW1QGARrEaMleqSN3nXA5APt4jDXn3o0KjLbO+brt63pWeUtMgclJxSBeaDxCfwuhe7E+Es4o1bZLqyTHF3NHgmNxZkalZtuhtzb5hRAq8tX5AxCyMkguxOgK5KpBhIYrKKvGjjGovtcbLii6ZT/sEIe7m3IwWaMrgVS0b15mctK7ldE6GJIoI6wQtZzpFkukCHhZ+1xNKE9y46/SQHedQ146Sa+u6NqE0RAzFEZO/HPiaIuJXoWVx9BzpOwlOs/WiItpMJdznPu4ROdMCfdMZ6YIJpGQ2yu5BKrx75Bkb8wSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiZoPV1Nm5qgTSiR8OpUKaRmqyZma22TeG1uvkt9iRo=;
 b=TJghdJ2bg96EIEipTg8IkLTXqmbvrg4c5bA9lBGEhDP1Y8SAODQGnpCmnHHKhKtiIoGXmcWDcbsFcJJNwvsr3Peud77kn8KuZURkF6WmtL+XxddseEcpKyFxZRFEYQkTaIT+GxlEUBDyvVzEAnGDaWEGBzwfVvlo2fJeMFoANEl6+iJDTQTuIc7o23rsg4oLJtutG4GnRpEfMahHAPmYnTw0iMpYv4v7rySjcjDoNQfy/UFYnLl+Bo/tx+/6VxrDoSnv+shzGg3NzjAeqUWUBCS6U4oJ9RXLR8BfyqrSV0Pjx/t2DvejsxoyXl+fVdutgCpVX9toHezJiTSaGpjLGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:44:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:44:06 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/18] sched/core: Dequeue waking proxy donors before reset
Date: Mon, 31 Aug 2026 15:42:12 +0200
Message-ID: <20260831134338.1531664-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00007548.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d4) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be621d7-7b46-4b9f-0e54-08df0765ed25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|10067099003|56012099006|18002099003|22082099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	I2jnrqF84nexyABI3AiTbSxm8dPZ1HxEFdX+1/2+3AE4XO+QF8wGRw0w46x2AkAWluu0rA0CaXEalWzFVdZevbWHyo69QxNHSSnle0+LUiqBEsZfRjLWamAzCZI63/6KM4NAmfjPc/y5H+t9jg6efmJEcR6kQHumltXKQOH4Nk3arS/6zzjUrtYsxYByrJxhDanE6QoxvxVCIv5brwj0P1fymtzMhljyfeB4bAJdKwxc0mPshdlaroRYQqysQNAYE+edjV7lDwCiYzv0Al8dtEJM2S2/1HGxC866FlnbXU5F0tWJEPvqsjQSl1FplS84iB/3zg3EkyAvjHV/ByaP7Q00yfgiflfCPxCCWwZZzEqgqy6KxpatJhh1ls8JrzjjJYdHLysYaZ2EODhMgt30Yhg/Mo14mUDInBtGr7KJ/Go1Z/FLZhbGSePk5FdWmi5STBT0YVXmhdRen0mfcxlEKA2ibSvdlt9XNSKJd2c1/HQg1n2EYCCeGQeMOgYfW/CdzO72F4cae/qe3H7Rwi6If0QD4LnfNbGc+odbBw0p9+gkRcliAvR8eakwGYceiCW01xvEw5q5MawHzZogqqXc1+RozxoF/35nW1uPqzMWWnDN0nRAkHf46aLCs6GYXuZZbkE5NcTtNoYDq8rR52eEc84Gm1Fo0TFXtUKGCu9kq0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0tg9ZYhwPvUus7cSmCSAy0REfJlEU46dMc3C6d+WalOtmdifXZYgrAhU7flt?=
 =?us-ascii?Q?23zu8nm7bI8x1JxV0JyE1wN8aLJ8cSw+uRcvILK2/NI96h3DSMmzuvK7cIBA?=
 =?us-ascii?Q?IAcnrJOxMFmHQv8k1DV/a/wipsV5nmREaV+xnAW+wPaF8iE2V8XdF+FtLrEc?=
 =?us-ascii?Q?DSzc4GXdXcdrLmDqpY6yz81kbCbAWq4qC7nmwnOfwuAkfQjDqoTsCzXv4ma/?=
 =?us-ascii?Q?fdpHwJLOLEA0qOty5mBZfI4zusK0m+4tHwwcGmoOpcudEvCmgHlYGUVTLFzs?=
 =?us-ascii?Q?3RM6AOycx0SlbOJfDi//LOEKHHF2w8p/8VipkjfV5AqEGk5n6HvuJxv5+cSO?=
 =?us-ascii?Q?DkixUVofG4L6jLrddtQNSiT8wnfngsBVifCFIICVy6ExEMr3AhKweOi3Oszu?=
 =?us-ascii?Q?M0HhnvTVqNOU4H2lCeCAb0LJNB9RrR4/HfRKDMJWSsdiY91tBCwoIUOy1cgh?=
 =?us-ascii?Q?M6tRKdzNC17xM80WxTRKVz+8lnEf4wA7dsjR/chTbzkV2tXjkOGeslUaTtJW?=
 =?us-ascii?Q?MGvMF5yISLOOzU1MO/p8pBKR6xyJ3SWOKpSSiwAS2cALzx7w+BzL0oe/HHn8?=
 =?us-ascii?Q?uMLlHA7sQ6jatTGxra4Qr4x+2TSTPJ63UCW8twj1IoQOvqbkynK7fBbxj9GT?=
 =?us-ascii?Q?GRaqwKnccRTc8RXg2HGmlSXMxO9Ph/HoFWzs9QPDBvY5AsK0gyUAnNE4uwWa?=
 =?us-ascii?Q?Ovy/XdkC0UGZ17vLz4J33Nwa1yjD2VjLB9TV1XMFbErdmRyfmAWGXfhcPAR4?=
 =?us-ascii?Q?EF5Fh9BHNMjcQzxuHz3pyRn8auzJfqpiaeJMdb3XQDUfJli3oeS6Yo6rvB4z?=
 =?us-ascii?Q?XxgUV0VrNVSa4g65Q2rBNruhyaeRYBEiWJph5jLgtMRnyWCvK93f6umiUm+2?=
 =?us-ascii?Q?GemqMzaEOVQusdHMGMd5uragN3AU06QRZoOqaNLA6a6FA/EJaEkEkqO1lzdI?=
 =?us-ascii?Q?UONzxomBuGkgs6UgMnMwiONsf0Du/LyexNd3NTA6V2fWBLrmXCNrQorDa+Vc?=
 =?us-ascii?Q?ykv12j/YKrzmILbjMVqdCHh4kZgqHOabKZ5cx+l6muEtSzPuHrkNB2BZbVIy?=
 =?us-ascii?Q?l8z3MqnoBDj63HciSwC6Ht11GfkPINb2p1/SxSSDVB6Tp9O48f4kk2melO+v?=
 =?us-ascii?Q?OIqZyv66PA6Y610AalaxTUz/GlfgMLuAvE1IgLb2J5qukzNfZoOrEY2AeG3q?=
 =?us-ascii?Q?fUq2O6rHF0PhOgZ8jc6g9qXmVxT0fxGTt/Cx2LCh/b/kmiBgCxDz5GgKuH1o?=
 =?us-ascii?Q?EXPs+1V1P3CvqAcc1pxVHlqACJ9aduWh+rQM5k/xot8/AxNJjm2AlgYb8oxe?=
 =?us-ascii?Q?zOFM9xvhFv495BHiHHQKC32wO9SJX+oetboKSDy7hc2noAwkeoeu5LurIhKi?=
 =?us-ascii?Q?CoWwkvsa6AinFrMQxx9+7JdzAGC07JdQeSnS5RkOhmm0zzPx1rhF1f1PG8or?=
 =?us-ascii?Q?Qzei/diB3411aPHUTOVLN7bL8hKYLmbI6Iqte2DWVRu0gmr6blr++JqDTVFv?=
 =?us-ascii?Q?xlAGy5POmad2xd9W5fAzLZlo1q21RI+Ag98IuFZypbOHZEXgcXSuubbficIO?=
 =?us-ascii?Q?ZxKCmnrHXO427pDcNtEUfC8RXlkqvKet+xA5S1oxLPldd2/HVbiOIBxjQv/G?=
 =?us-ascii?Q?twII1umxe7Dwr4FGYytv+8fQcLsoeUJfLXNeVa3l3DxOzpQzOIMp58X/BM3C?=
 =?us-ascii?Q?dxUlre9DOekxTpodmzT/Bd+WhkGxZCPERaOOejvhp0j/2txpXXWDv6w2LMrU?=
 =?us-ascii?Q?2V84U4Q6bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be621d7-7b46-4b9f-0e54-08df0765ed25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:44:06.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSZDfAA9iEAAzPe+gWHjqRzsT97R38Y0HvuIRNYVWbQR2v9lq55daLZa8ypQeZ+zas0Qc2VfhKF112e6g9Q/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198

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
 kernel/sched/core.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5817d1a4cea2c..237d216382f46 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2252,7 +2252,8 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_task(rq, p, flags);
 }
 
-static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_state)
+static bool dequeue_block_task(struct rq *rq, struct task_struct *p,
+			       unsigned long task_state)
 {
 	int flags = DEQUEUE_NOCLOCK;
 
@@ -2273,9 +2274,15 @@ static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_
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
 
@@ -3774,6 +3781,9 @@ static inline void proxy_reset_donor(struct rq *rq)
  */
 static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
 {
+	bool reset_donor = false;
+	bool dequeued;
+
 	/*
 	 * Typically per __set_task_cpu(), task_cpu(p) == p->wake_cpu.
 	 *
@@ -3797,11 +3807,17 @@ static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
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

