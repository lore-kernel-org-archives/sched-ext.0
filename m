Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3F411A04
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374978; cv=fail; b=l89CAqcyNXz4H+X1mjAnGCfvNWKolp3bnSNt46itSeiZ9tDFJH6ZK85o81PzGEY/sEVE56PsO9iQ3bM0FYOCxmRX7sY3C7CZPRbT4Lx+d8OudWucBebpscTD8PMVXLGCMsnPTyaj29A71nJxB/FKkfSa+w2QDjCI13s/r24jsGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374978; c=relaxed/simple;
	bh=g+cLo46//RuHG7p2ol2UuW0AC0qkFBRSkgp+hKupFmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJyjNogoYBK2k3CkpX9KuPsBetj0xGzMxikTw8n3BsptgjLP93aau9+E8Pp4oY3NY0Tx2YiblO2ez4Z1xLVxfEuX0yIiptqxqEFjncs0VaAdax+Uym0wDVFFV16vZCRydwKLlD2l8OmMaa9i0i2ulRJv4h+vMflNEf3mCPFZsxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FFxVakCW; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FFxVakCW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTV80DgnZrXRje2P8/BWRtOeX4djQJXc2sWaTqqLEDZpNzOm6GZofNIVnUs8Uw0GhFTETuB9o8TUghBiDAiLSRIRG8mfzh2MhpJW3I+FoOczHn+teAkwxA3SYCXcmzhOxkyNZ9CzQm8+y7EU9SL/6GkZc9ljJuc4Vy1PrdVc8Jquh4M3GHzv0mtLnMB0MoWsPgEVa79OPeVwXBsyG1k7TqH69xOdKT5VJ2+Ti/Via2izitXDyE5lQ7ceifXreplmGTup+f4zjL94CJdTbRemF0SIkTkiwAtNSTXu7JDKxsMcxikownn1TLXKkfzWgHn6Wb7GRnS5zj0jRqpXOIs73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgKsb1165NHAim4WIjJ6ifKYWiK+dSdVJwSATZxgbZ4=;
 b=U5tjSrQ+kmMMu3LUrmpRRIYzcwKgQqQ0nLmgphS6qSLnuScqF4V2j1EAcO+3Vj1m7BIkk//GHM0OfD6C6wThDG7cuc+2MxFZ1plCthveNzpbCsQlgbYgLtDN4ekd4B4CzPDrdSpjw4E+iQmG4dF2ccUtTJwTciLuWQFd+gWgm4mihzhzUR1qRZc5JWPqEJOI2/H2KG44WTgOUpRGXX1jvuNI+DXOT4XxoojLHav9DwlX/9ebeulGBXPrczG+PLsMWEDeeDJBDEd2otEc75xKBBr8j+VtmrBkJ0+arBMDOsxVJzCbxo3fkYeijoZaDukxbjaPfWc9vdbfA8EpJ7Kv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgKsb1165NHAim4WIjJ6ifKYWiK+dSdVJwSATZxgbZ4=;
 b=FFxVakCWPmoZ+7gmkYBvLFJY3nGTHysLcSKPQBF7KygiGzDIdlv2sxeRe4XZkkCJHmWJJj3KCID+pLAYP6TPGX3OsbDi+R4RaBefeXfevL7SoPZW3LyVGGJwAbJpQGbRkqP0y6Pam/6yprqtsi7BosdgXjawFhPvl0+oOaaWFxHjaqXbYFta4SO13OUqtkJdGmGvHlAqz6GRrbuGbBfnpDV2kYaX1LVXSI/XomtQt+oc8CCSMSb2znyxYmkWr19I1QkGwTKfJJo8KfQFcj3pUiWKReufXMPOMcv+hiY8ItsO0q6rYUmVb7TMSwL1AbuH8tbKTNS+eOOm84AepS7ITw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:16:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:16:00 +0000
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
Subject: [PATCH 02/15] sched/core: Avoid false migration warning for proxy donors
Date: Mon, 10 Aug 2026 17:13:48 +0200
Message-ID: <20260810151523.86994-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E96.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::446) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a90992-467b-4c0f-3b55-08def6f2489b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vz1grERcBakm00E77tLhg1wpEWppD25WkPYp2LltcUIKXll7B/fKUnAb2lsDqpqFMQ7t9cwv41sHNsmHGrC7Hf3PmczP7e9pad+izg5bjjvsYS3PEq8PtsA3EOOhlkduN5pOxEwQslgBf/NF2bK5jCJBEqWi/RjQkStB3UCyPYjiXFMeRaJvM/KOPISh0kHJcj4k4dEWEg5xLtdTsP1iZCCDDChV+AmSJ3R6PpSrKLbo2DvX2G/bViLDgkwiC6Oj+XP0xz4BfojJPWcj9hW66X/zXZlifLgdV17TttRCJFpVF1rWsHhwfiN0YBpBTidGT5NICCqXhsL31GpkW5UroXOlapF5ix+Jgq5lWIQby6l8kIcRu+aEdzydOxhJkL+maNXEHMHFtaNdWRLQQq0oRNTijwZzwmUdF2cES012xB6CO7yUyBtgyPreOH2VxNfjjVue48gEJZFVArfrTmoeeZbgVMfbOPybDmOUdxWU5inCGU8XCVJSzi3/sxHIjekzDsE6+vrMGMwUd+YpXktZgv3YcSMPNNdr1qEtcIAsxXC1P3zKn/rwejjoYFpQw5Yq+ZuH7YNKPxavALLtjD7McBDxKYvDAx7LsebAJ0X3KDs2JSyf0t3PyzOKMitJfh2iJb5za8TINy8eLeZzSZhWj36xF8Ju6GScPLglhZa6tdI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TzBKAvcp7OF/Hm0MrohKwSvhXRtcP019MQca8owSb/GBFZKgmwwD+QZfY8wD?=
 =?us-ascii?Q?IIrwJSY/zyBf0Hb3pyIJSogrgn6mkDQe6J7wgBsU+rKdMXJx05lZM5dsu4iF?=
 =?us-ascii?Q?vkUhaW3XiEPX0OFXnbYQjqoA7ds3a884OYRAmOrKQzrOdiJy08dfJV9S8v/j?=
 =?us-ascii?Q?/rHHOeTd0Qmqz7Zldw3ye8js890UKeiFfSng0D33HFLXGqYfxFN5DLo4mT9m?=
 =?us-ascii?Q?JI+ynyzG8URtjC5kJjxOSI9S9MonJ0fQvlEkj/psp6bTKlC6xnb/FdfgafV2?=
 =?us-ascii?Q?dg1MNktwBizqC1iI2GkGjOSXqKUBM7AbKK93IdPTelx6afh+/h7mpgJE8nSr?=
 =?us-ascii?Q?z9d0G3YnJBZ7c2ORRd2Zv6cntKIRI6Q2FIHebPbsX6pBx5G8UQpplZH672Cy?=
 =?us-ascii?Q?en7dnmht7pNzhvnrpi/hb/6QM4lf+mFyhnOBAMJgDkh6E2dS/Tf/QydF/VLM?=
 =?us-ascii?Q?nxo3RY2yqFcQU1pLyI2xZ+lJYIP5OGpipqAeEQOimyeOQFyoP3Bb8fz9Fa13?=
 =?us-ascii?Q?hleEW50JfKYayNmHmQHsCm49ubSVi7o5zDCRJ31Ib1z0t9WQMo/9g7giap+p?=
 =?us-ascii?Q?Cq76VuxO7r4j2P5T1RlR32CeEFlr0mksaAQVWrJ2J9bYsbmFPCSIoko1ytwl?=
 =?us-ascii?Q?k/GMS54502wQ9PdXg38KRj4c2SsKyvD52TN5UUtEwGdVPU2vQVJ2l0jcfjVQ?=
 =?us-ascii?Q?kWJt/LRf13P8gNnctZGttI+KThRSDIak+fhZA49YfC9BnczZoWbmjHtNKNRw?=
 =?us-ascii?Q?2ITJT1bEv8UznnyejLPaWrx4f6buKQfbltJcIfdKzVTwjMbWdLwu7EfjfRF5?=
 =?us-ascii?Q?Vin40He7TYXOaxnAYh9HqUnCfm6L7bLbE4NUiK0UNA6b252uVY0kHeg3bxBO?=
 =?us-ascii?Q?k7RRuBQ3kp3rSRIhTwMnOdY0p1ZFn5w7NRKXgZF2NLGBntmVXocw1CspVcz8?=
 =?us-ascii?Q?R6QBaFriQae8ya7m3B0dkXkpVWiFh65cs25T85YZM4O/br4MSiOoN9JUDuEj?=
 =?us-ascii?Q?dfGkxQNraIhyVPIjjEupBeeXJ60y8FLMoaLAqF0PsssuoCpf/nr7SkBnQoGO?=
 =?us-ascii?Q?CvVRXV4x4fAyMoO4PRs40Ds2jGWdieDCPw9dOr1hgmJUUyCPPudFt01azsbG?=
 =?us-ascii?Q?c+lFzUE/MIe6rHy1VOcSHhJF8sp5D1uF6qLkwXCwsN7axG5Jrv6CeX/dIx9c?=
 =?us-ascii?Q?QXivHjtMJ8W6THbubcRdEArETWcnYGevUcEtZM4MNvnPzJnUZ8hyEpHeqxro?=
 =?us-ascii?Q?+TeppeEQIx5VVF0YQdM/ihcrvy+saYSDIG5X0WUD524oKOCNJtXzJIH0tjWT?=
 =?us-ascii?Q?eNUEJidF75gkOWw3hXzgqomf1T2NPyqtOZtCAie8QOPMrSoQZnoZLFG/ScSZ?=
 =?us-ascii?Q?rpgD3vh8e6Ow93hcKUFtx33eZXqUrC+zDGVzcxXVwn8pA9dMIekceMTMtSHl?=
 =?us-ascii?Q?gXY5eIr65ZZDqs8I5sNCrOzUP68dQpNPzWn1J+MjoIvS676O0ESPV7dmKGCU?=
 =?us-ascii?Q?9RDV4cBpnZRH2haqRKmot5IRLHzehrUTnj6WqJ9F7ABcijPws1v+y60QKXZS?=
 =?us-ascii?Q?mwKoaxUtyKkbdJ1LVj55EiBSuZnVmB2yhHWRS7tlyTNZERj2riBmJ8JasgRf?=
 =?us-ascii?Q?QB0VgmcvWrJj4MH1094iOI8ju+fD8zkoXzBy9v8Es5z95oxWPbW44uWWQ5Ed?=
 =?us-ascii?Q?kHCeLX6Ky2mafPST7m3EML1pX/rSyFbiinL/t7HOgjKDmDNTcbSTIea3TJUT?=
 =?us-ascii?Q?RUnA9hoBmQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a90992-467b-4c0f-3b55-08def6f2489b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:15:59.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LexESQ5l8NpIh+/ArNe2iTeRgUyxO1Bn288k8hwRn9I5cFMHQakqwD9fVTx8K33A/PMeYvG+O84DPJMqhMQFdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

Proxy execution can move a blocked donor's scheduling context to the
lock owner's CPU even when the donor is migration-disabled. The donor
does not execute there, and its original execution CPU remains recorded
in wake_cpu.

set_task_cpu() warns unconditionally for migration-disabled tasks, so a
subsequent proxy migration or the wakeup path returning the donor home
triggers a false positive. Moving a blocked scheduling context does not
violate the migration-disabled execution context.

Exclude blocked proxy donors from the warning. The proxy wakeup path
restores an executable placement before clearing the blocked state.

This is a preparatory fix for enabling proxy execution together with
sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fbdbe2762ba96..96b8b01d43101 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3334,6 +3334,8 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 	unsigned int state = READ_ONCE(p->__state);
+	bool proxy_migrated = sched_proxy_exec() && p->is_blocked &&
+			      task_cpu(p) != p->wake_cpu;
 
 	/*
 	 * We should never call set_task_cpu() on a blocked task,
@@ -3369,7 +3371,12 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
 
-	WARN_ON_ONCE(is_migration_disabled(p));
+	/*
+	 * Proxy execution can move a blocked task's scheduling context to any
+	 * CPU without moving its migration-disabled execution context. The
+	 * wakeup path will return the task to a CPU where it can execute.
+	 */
+	WARN_ON_ONCE(is_migration_disabled(p) && !proxy_migrated);
 
 	trace_sched_migrate_task(p, new_cpu);
 
-- 
2.55.0

