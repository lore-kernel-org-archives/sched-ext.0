Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C32F5C5C
	for <sched-ext@lists.linux.dev>; Wed,  2 Jul 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499013; cv=fail; b=YwVrdYvrIvVqWihJDFHjeDowiAJjLMVNG/J9/rY91D6y4uPPuqv5Urwo8BQVX6vaKqPTgIY96b7L8DoBylSIAK0nHM12tsqXsj+8Jr33FuloPcBVU8LnbgoH03lYW1XL4ok5MuviX9opkH1Ey4SfnklTQXhZ9jbXCYrZzbVENvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499013; c=relaxed/simple;
	bh=+73dKM3TgeTNA20S32ox0Gm5rUq2AJxNITw+yDrnJV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8DgyHGsMKH/e3O/2JvGugQ+drIikKwT4QCKEOZWA/tf+GErKM9lXLVeB1ViIpuLwfQw9J/5gilYY+0wB/v5yVVXoeth1shn/EfMSEhd0Xes+1F+5fbCz/gEXQ2dz1W0vHUfM+5T+UVdtYzWOLJCExNFYmxX6HCDtR7dDqLM8OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gfZz1gq/; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gfZz1gq/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR0g0kFttFMEjEz6YCpdjZWRkP/f1LqQgXykPHYVxRZ/xKNgQ1do8bPzhD9kjpUjO+ridAAYsnI5R6so0Z300/9ts27IvQX9939XoK9JRxUl1TnX3KOfTP8/U98KUq+8UzHfKsdYiYjJSeBtgNpB1hmoMx6pNDrg6oW/KO0rS5clc/Dvq6T7QdG/YlVmHdvQzDoYieooAsw52GVa7XkD6GRREM4PG/Nj5ytWZOkXz5whfov8dwpem4P5L0ygtJ1E5GmfEhkLaSt00X9Jfn67/2slV5RlhAXiSNcYgzZp54O9lP3RDO4HpUIJcdG33vGBKh1nXqGGNvgidjvQcDCLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k0UrMroM4NjCYSF9aLNPhA/GPUkQT7mrRIwAi/KvVY=;
 b=VY6Z5OwUBuA7fJ3gPYJE+FqbiuviNrl9CFx2vNKRafbLl9mUNgdBnnPcc2/JDqEEmx+UF3EWWtI67veMbcL3V4W63QUMkMzXc0kl6gy16lT15r3IB4HCHM5SRHlTV4KtMjoTH5FSK2Trb7K3fjOG5gMHnin28mUH2/ITdB53saNU0NYsiuSmN3LM1Yd4guObU/bonvAvLILfBycCWOAOn5tOpJPCNmpHF2NtAQXeBS+YddzSNOpvJhE02iFs/RpPyBimTQPQsg5tenCgWrlCmkwAHOa9pnr1l+w3Ak0OKrOCLEny6hw1ZGSt0mn+fmorsP5dvKQH01gCNICskPoM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k0UrMroM4NjCYSF9aLNPhA/GPUkQT7mrRIwAi/KvVY=;
 b=gfZz1gq/bgciB8/E6TAW/0ekQpdahLtXSDPxcrY2mz3JNjX8au+/kXPRB7tZiQmCgiX2nFx+ypHNVoFgDkHv6IjZ2gVcyYLsL8ixI1gdUtVcT/WBV1pwdjJAEpJzZKNqzzPrSYCKdH5qGiqxxGqBP/T5p/kVdr5Thsu+4S535swR1f30wdwJx2tPvwhaVC26yFgekyiKsG7c8+nngvobyvaxkaIefzbwoVqMB56iaBUZqbMFOIn76N59Ec91hAHaR+Gmjd2e7kGPW4Wv5RGsS1poR/eaKQ5FDF0eDCrUbBr5Lm8ZmvXE51gwc8iTyeKpSlPPGFpTpMqGakq9BdiEJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 23:30:07 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 23:30:07 +0000
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
	sched-ext@lists.linux.dev
Subject: [PATCH v6 06/14] sched: Add support to pick functions to take rf
Date: Wed,  2 Jul 2025 19:29:31 -0400
Message-ID: <20250702232944.3221001-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702232944.3221001-1-joelagnelf@nvidia.com>
References: <20250702232944.3221001-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:208:329::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5a44e9-ed34-4b1b-8e35-08ddb9c06138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lSEBp4tn0hg0KlJwh3548SVi1/EDHpsPN15OefNUV4XDRveQvQxtRu+SI5R8?=
 =?us-ascii?Q?Py9BOYC10rAi8NHGtHLr/6n8YUpmMYYdsk/ucapoKKtzKS6M6D25/KTsu1Fm?=
 =?us-ascii?Q?2Bd9SmLyLbr7lK7Gu6t3xsT8FhuKuq5BEldtVMBzrkwyehp1S2lF+8j1QLrV?=
 =?us-ascii?Q?Po6YYReN4kmOwqggj5R9b3tF2X9XLdN3XBd56acCzXBwc9VqgOQGBT3YDZjV?=
 =?us-ascii?Q?FEhzSIwZPAvf/IPvt+qvV3Kbd7q29JyYFh0qO2t0QPVld+CxBS6YIWgxyDhO?=
 =?us-ascii?Q?4ASUCJNN8aO7m8GtTm9IjxQZMvtpyaNcVDFzpuZR5K4YlLj+7Hh4lWWlCZ+N?=
 =?us-ascii?Q?YBz9jKmObGkyOj3wp0Nxou/Su6h5h6Fxogiv7Veb/PGJrYjndowX0BlYjVw7?=
 =?us-ascii?Q?dgzvzt5IybBLybdoDa8rOdrGZarws2J87pL607lImHalT/4WMG0sAshTaK0b?=
 =?us-ascii?Q?w7izyHa4s+8gHZScTGJ3RbCBT4OsOnbERBzAphye0bz4ciWNCrrf3qfYSdCp?=
 =?us-ascii?Q?vkpWzpz/YiW3mwVsWwCl/RlNXvyJ9jI8cPe5+kUEZf2zuv//F+TesLDPe0B9?=
 =?us-ascii?Q?RHdTWi611SwwaLpPPSFOfR65QlmLS6j8dbMpgvT3ZjcIR7e+Bc6hnUkqUSpc?=
 =?us-ascii?Q?2bEqCPQ1W+BjucmOApj+MQPg43OnqqwRG44np2Yp/9O0tkpR4/COhWRaioEW?=
 =?us-ascii?Q?+xiOKnVsukrUpMzrcgBJuyBVUNBRtizbQAmnvPILgGPXjxbtE79pQo5Nq23N?=
 =?us-ascii?Q?XrmJNObXidf7wvmkNhCfnxiHlB1WhqilCvQUcMRR51qNSch7oQCTDhg/1iGh?=
 =?us-ascii?Q?6jpPDb0tzqP3QTRsgmTw8lIruXvWPanJ5VJadzQRioWdXgwL6W8hTP/P/hvq?=
 =?us-ascii?Q?ScKLbeSkVS0uMYIUgdc18lvQ8wkK5Me5pa11xXC29PpcRLUUVFY4e4WG/KgT?=
 =?us-ascii?Q?GUD4trbK43VrXZF+CC+KhSMaxbQ2mvTAVMHov/HwGLrAKkeTD5lX3jp8k792?=
 =?us-ascii?Q?qdZKhymYwul7o/GWmhFMWjqDt1REHDlXEQVCiRx/WylmjsDagxxiV9aO7I0P?=
 =?us-ascii?Q?9LPjVvgWV1Bz6JUY12N86a8Sg32zZHhic0BWPouC3KFEz6yygaTmPW+/402h?=
 =?us-ascii?Q?tlOhQsNpdIbhDx2LUzN8p2jSwbq3l0U38UmHfDjPKxcgFAS5VKACSmaFVbMT?=
 =?us-ascii?Q?ZuNTFx6iFEEayNDSVYHD8XW2w3rhBSPqjmVfgScMLcT8XGQV9Xc3gPdalNyj?=
 =?us-ascii?Q?Jqgk2HGRhKEgbREChEKxx7mGPBgSa0K9uXQfypq5CtQfHnm1rF6Rmjn2c6rf?=
 =?us-ascii?Q?4A8YNpQ3JdjZWiJ1HxT+1rgqijWpVpp2HkTgxsoSGii8UzK4/EyJwK6GZ4G3?=
 =?us-ascii?Q?QhyQ8KPGrSZU6hN/U17Buidn9fXKC0iYDpiUs/9f7/O4UsWfNwytmqSgcIGX?=
 =?us-ascii?Q?eCRNqO86kEj0iY+PmdlcLJCED4i2UvYxmZlL3zeeZ/33EbNyb/tbXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wTz5z3yZfR97cvOBMxN2eBRX5kQfifgiO4UBUxi5d0gKP4xeaEow2nh8gOjI?=
 =?us-ascii?Q?+Pd1TrBb7qv7D/0TYdh8fX0KUCiRtd40qBzIrEqDqMeiXmcsnSzO/QWJevds?=
 =?us-ascii?Q?vGOw/2wuVT+t0WHFHMLsZNrWXZLvmVR2rE+mCo2/PikfPV+vYK3+lwK1A/3s?=
 =?us-ascii?Q?z2UFZ2Vh6fUBk3ZbHDn3kzDP35inz2sMPqvXomL6rVkrekJTqlj5z54Ug48i?=
 =?us-ascii?Q?Mv3i53tJNrzEhQrz+V+0HSqzwcFmeTXXVBPIe0eDPl57RI3/kN/XM17m/jau?=
 =?us-ascii?Q?dGknXM6POFpkU30rtTZnhNfp4TTRNs1CY/gna0wkRQmFNsJD1DnAE+qqusC6?=
 =?us-ascii?Q?aJJ6zMKGzB+teZravHRtCqgIqkV7e6pha7xtJtmXqFePmha8WyT3qerKqmSV?=
 =?us-ascii?Q?2/VlYUQJ6dVlEwcghIxR3jZcMCwCW1fjIiiDA9dRJ/Cz0uPDSNvIhU42elBC?=
 =?us-ascii?Q?sMKpoknBe1dxZ/s9kihNqhZOZMIXr6c8wM8pGbBwSlNQf+qN8OAk9B5n+Eho?=
 =?us-ascii?Q?EnYdSWTe2aGBsGfimHus7RNQDZbjjLntVVP69ULzrCHosaQTykFw7VQSyqf9?=
 =?us-ascii?Q?Z+oA8euD+6scO96Yq0PYzhePY/o5ZHjj6lxPuFcy1aq0COG/SKTdR/fmtWQg?=
 =?us-ascii?Q?/4WqTjdFaIbFC307nlKb5vqbB0tCp+kGKknLYDtpUfJve9ByImTlPmIXtmq5?=
 =?us-ascii?Q?Xh9721aS6u5YvWcsd0WuU1sHW41IUAIyqC8jG/jq9jcRr94zN8LJNrTHvV4m?=
 =?us-ascii?Q?2BbLE5ds0xSUGfIHzNPyOIzow0DZVXy9Ahs18/SqNo87tzpxUjitOCU4Sb+Y?=
 =?us-ascii?Q?fdjYSPMYzP+ixf/D3vMPEsrzvgt/7WUDzrqDsaNQqBKnJyXzGYqBH68y1PvP?=
 =?us-ascii?Q?7vqS29y/RTagYfYvgGNIXtHikp9cfmNKYfxQvWwU3NN1B/yDLoW4u0oskMGZ?=
 =?us-ascii?Q?6KkVnjpC7FDhSzuRq+XhrnwFSyhxAnku7qrGakBKtEc/LNDu/c1ajAg5Cb+A?=
 =?us-ascii?Q?VhPrReFkxzWGsPX405ql3mHjXxSbs10Y6+3+mJgk0f6tI2ItGYz8u2NXZtDS?=
 =?us-ascii?Q?mrG78d4fawRLXkSohUHgripxSJklOnOE6fbvq30KihO4EHLj/iPKkjp0TbJU?=
 =?us-ascii?Q?LNlQX+AneH6iA0nQqTw99fHZbrlw+wg2br6zHPiWCN4A+m7fwfxRBvZ/o0id?=
 =?us-ascii?Q?NTRrv9RlZFKfAKOdwbVqBkmQnrc1dezhqB67vrTf7N2YuaX1VlIgnRF1VU/i?=
 =?us-ascii?Q?8cu6oTlISalPFA8V7nS5YYQgkApAe8ZwdTK75iByHS4ZS7gRBH2DpEkr3P1h?=
 =?us-ascii?Q?MYXMwGzpmp6pt9JaL+oOy6Ilqa9pC4IvKPHxqZ6A8wCNGsPyMMta38+VXdd+?=
 =?us-ascii?Q?1NFzaU5UjxcbOMvsMlDwkBDJab2qIvLfPpWwB2/ldw5ENsj0dZjWkP5hWGN7?=
 =?us-ascii?Q?u8hKP2Ieq7G1Zi0GAkfT1XwPa3iHHMAzi79jOyVrC9SOsittaj7MIQvuFBKI?=
 =?us-ascii?Q?WVK8HxLE1aoZV6SB6WPo8VdokBxyNlcFvPy00a0auZfhAApEQAwWaGCmSL0w?=
 =?us-ascii?Q?6GNW/MKDXq7fVbyR4fl9wMB/6PwSNAZ6vFeun16g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5a44e9-ed34-4b1b-8e35-08ddb9c06138
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:30:07.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyDIiw6T9NtCu/DVxzOELEobzEenKcBHlR6sn2NtiNI5yAKRAh1Y5BEWd9efWyZH0ElLmUFLcWlsS57QlLjakw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

Some pick functions like the internal pick_next_task_fair() already take
rf but some others dont. We need this for scx's server pick function.
Prepare for this by having pick functions accept it.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/sched.h    |  2 +-
 kernel/sched/core.c      | 16 ++++++++--------
 kernel/sched/deadline.c  |  8 ++++----
 kernel/sched/ext.c       |  2 +-
 kernel/sched/fair.c      | 13 ++++++++-----
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  2 +-
 kernel/sched/sched.h     |  7 ++++---
 kernel/sched/stop_task.c |  2 +-
 9 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52..6799c14061b7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -634,7 +634,7 @@ struct sched_rt_entity {
 } __randomize_layout;
 
 typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
-typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *, void *);
 
 struct sched_dl_entity {
 	struct rb_node			rb_node;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8988d38d46a3..7d856d8dcb94 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6049,7 +6049,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
-			p = pick_task_idle(rq);
+			p = pick_task_idle(rq, rf);
 			put_prev_set_next_task(rq, prev, p);
 		}
 
@@ -6061,11 +6061,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	for_each_active_class(class) {
 		if (class->pick_next_task) {
-			p = class->pick_next_task(rq, prev);
+			p = class->pick_next_task(rq, prev, rf);
 			if (p)
 				return p;
 		} else {
-			p = class->pick_task(rq);
+			p = class->pick_task(rq, rf);
 			if (p) {
 				put_prev_set_next_task(rq, prev, p);
 				return p;
@@ -6095,7 +6095,7 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
-static inline struct task_struct *pick_task(struct rq *rq)
+static inline struct task_struct *pick_task(struct rq *rq, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -6103,7 +6103,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	rq->dl_server = NULL;
 
 	for_each_active_class(class) {
-		p = class->pick_task(rq);
+		p = class->pick_task(rq, rf);
 		if (p)
 			return p;
 	}
@@ -6203,7 +6203,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		next = pick_task(rq);
+		next = pick_task(rq, rf);
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
 			rq->core_dl_server = NULL;
@@ -6234,7 +6234,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
 
-		rq_i->core_pick = p = pick_task(rq_i);
+		rq_i->core_pick = p = pick_task(rq_i, rf);
 		rq_i->core_dl_server = rq_i->dl_server;
 
 		if (!max || prio_less(max, p, fi_before))
@@ -6256,7 +6256,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			if (cookie)
 				p = sched_core_find(rq_i, cookie);
 			if (!p)
-				p = idle_sched_class.pick_task(rq_i);
+				p = idle_sched_class.pick_task(rq_i, rf);
 		}
 
 		rq_i->core_pick = p;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0e73577257ad..2889cfecf835 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2424,7 +2424,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
  * __pick_next_task_dl - Helper to pick the next -deadline task to run.
  * @rq: The runqueue to pick the next task from.
  */
-static struct task_struct *__pick_task_dl(struct rq *rq)
+static struct task_struct *__pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2438,7 +2438,7 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		p = dl_se->server_pick_task(dl_se);
+		p = dl_se->server_pick_task(dl_se, rf);
 		if (!p) {
 			if (dl_server_active(dl_se)) {
 				dl_se->dl_yielded = 1;
@@ -2454,9 +2454,9 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	return p;
 }
 
-static struct task_struct *pick_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
-	return __pick_task_dl(rq);
+	return __pick_task_dl(rq, rf);
 }
 
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba21..f00bb75ad539 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3397,7 +3397,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 					struct task_struct, scx.dsq_list.node);
 }
 
-static struct task_struct *pick_task_scx(struct rq *rq)
+static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb..6bf097e39b4a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8852,7 +8852,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	resched_curr_lazy(rq);
 }
 
-static struct task_struct *pick_task_fair(struct rq *rq)
+static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
@@ -8890,7 +8890,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	int new_tasks;
 
 again:
-	p = pick_task_fair(rq);
+	p = pick_task_fair(rq, rf);
 	if (!p)
 		goto idle;
 	se = &p->se;
@@ -8969,7 +8969,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	return NULL;
 }
 
-static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev)
+static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev,
+												 struct rq_flags *rf)
 {
 	return pick_next_task_fair(rq, prev, NULL);
 }
@@ -8979,9 +8980,11 @@ static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 	return !!dl_se->rq->cfs.nr_queued;
 }
 
-static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
+static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se, void *flags)
 {
-	return pick_task_fair(dl_se->rq);
+	struct rq_flags *rf = flags;
+
+	return pick_task_fair(dl_se->rq, rf);
 }
 
 void fair_server_init(struct rq *rq)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 2c85c86b455f..01e9612deefe 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -463,7 +463,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	next->se.exec_start = rq_clock_task(rq);
 }
 
-struct task_struct *pick_task_idle(struct rq *rq)
+struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf)
 {
 	scx_update_idle(rq, true, false);
 	return rq->idle;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e40422c37033..6e62fe531067 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1744,7 +1744,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *p;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb5998295..35d7b328a9c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2401,7 +2401,7 @@ struct sched_class {
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-	struct task_struct *(*pick_task)(struct rq *rq);
+	struct task_struct *(*pick_task)(struct rq *rq, struct rq_flags *rf);
 	/*
 	 * Optional! When implemented pick_next_task() should be equivalent to:
 	 *
@@ -2411,7 +2411,8 @@ struct sched_class {
 	 *       set_next_task_first(next);
 	 *   }
 	 */
-	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
+	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev,
+										  struct rq_flags *rf);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
@@ -2574,7 +2575,7 @@ static inline bool sched_fair_runnable(struct rq *rq)
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_task_idle(struct rq *rq);
+extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 058dd42e3d9b..1c70123cb6a4 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -33,7 +33,7 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq, struct rq_flags *rf)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;
-- 
2.34.1

