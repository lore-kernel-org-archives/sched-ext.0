Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F332B107
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995545; cv=fail; b=hbaGDJgBi+8Mc9lTMim2v9VNM7J7R8MujuZyt7B4dU5KKorob8Um39MrTbE2UWjajLKHz3FuETS5RhDi+yFivubqtJYnWWyfu0Y7mF0taT58rJ4Cdig9VFxQASgCQPpne2BHy8W1Zm6ne6hMHqhqmRgXFVglk6XjYuT/4kMJVhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995545; c=relaxed/simple;
	bh=QM43rFv9JH6ZA4ilAVcffsTACuIOGkFZVBnIB/QZvlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjtSAn9a+vhctKrFK/kxpIEQwaSBt/34aDt2oB6BdLQ8UMJY9F5TS+TpRCJcomPb3xd89P5vJ1BQvIx6WlOo3H+z+nZrzEYpHEP3WGF2K7tB9yhjkt4GyMXc+QkFccPYTERCzlbwxhrgbT/QJthSda9n9xHqZjjwKe1feeD5dNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dS/Jrb9M; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dS/Jrb9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLxIJlFx9rF1ic9f4ns1iom/VmOg4dyYkRauRyYPh7oKsij9+mBvYG9JFfQhnPHxFoIV+2qIsqdIkVmpwIifVoAsBww1Q78x8VwH7Euw26Diu2dcIF6RQP3ai4tXrDW/gsNxN6hOP0vtXCmBNn+FgI85ozy1qNu89ltn1IIH17/DhVF8NAfNUmBjBIJBepLamXTLG1A5eXpb8PNGuT9ME94hJtPQtcJetZyF3J1i6IpbfXYhzWDLLd9gmQBuCJVvAl+moVu54oRAnX0swXM6TjMMLart9u73n3w0hIcoHb7uSZmDoas53QjmSf1Ho/RNqaNG1d4UCfNlxQRJVT7egg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cgdSbZ4L9wMcWYUFo0Jnk+RhdiDycvK0mieqoERmGU=;
 b=l67OB5o+QaSR8MKIGa9utZnaqzP8h37CEgO04tWsUwRpObKV0Ek7dB+kaZjw11Lh4Puj0Kk5QJq2GOtd9CwUcn/fgaIcCVeApD364tQv7p0C2UKbs6DxdW2g//+Q8DwajgYKy9/NKx5CL/yq7VwXeLm4VXH+YjKTqWL8NcWhvRprrBm8c91dJ999xOFxQ9TnZtQHmLAtfsn7IL+7D0b5xH6on7yPhORDb2BXNXM4W6bhwmPovRU1ddXpR7Z0kguwTipM6i0ZeY9mqXSGJpVTWFf/Y4tOxOVPs8Xm2kRohDeadilTiV2amzaJ/jbl9UEByYyuu9HEAUNlNlEw2b1nPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cgdSbZ4L9wMcWYUFo0Jnk+RhdiDycvK0mieqoERmGU=;
 b=dS/Jrb9MDrBJy6qVtRGYkg8pvrOBPENUhzPqvV+swPkKHZNE4fHlr5bAViKlJC5RFw0lystZR9JYSllgzWmka54kvVtpXaO7ReVz1BssCD8Sx6G8qOTMtghxfUIbrQ0k/PAVASthvY1IFcCe48C8sqMtv2R8b1a35AYsXtx/tTdQlc/GfzrhwPpEJaK1GcDiQttwV7KAXdTjnzXf6J3MvU+1UlZrR6aS27EVnauBGI42qqFuqxVK6jGJiJdopkBzxvlmVSXRT34HGt378uyCud4OVoT52x+PTDh/g218mNATE6RY2H8bAz+MDJmommNDzrdhHXnvz6AlGv1rlmHiIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:05:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:05:39 +0000
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
Subject: [PATCH 01/14] sched/core: Avoid false migration warning for proxy donors
Date: Sat, 25 Jul 2026 18:04:07 +0200
Message-ID: <20260725160513.57477-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E9E.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::455) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddac1b5-00b0-4b15-bfb1-08deea6691e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	m1nhiwJpZ4/VzQTMv6C6Y5Z2MNyV+3/MS71WVbN/5uqqjwkHDUL0WnTwVOeazMh5VPXZs/1k2MS5B0FaeKi5U3shTfuIhitS2J9KNYteALgErgXBjpgxG8Gi+XlL8bjG1Ls+6nsFJ8E3enMTWc9+Anme+LjKAiE0gESQAtI2xRnmwaTekxeN5SDoiardUL9c2UN643sb/n3O19yXgji+ysvxlHfCoSZcnxLfiYfK1aQWiQsW+NcQyKOCDvkBRYzSnH0QsW3enwZK8zh7fZFCk1KAnZletM2UvkP2+smihzg+eQ9uk5aAakkWoaNvfwa3r0+xyCvBHfCIApcnJTKLU9brM/LtgDSiiv2reRvToxtQHFAxXg1fJrjac3EiJwwEMtLnZCFWxjl9E37gt6TsediFyGrUmjiBC3bCW7HVr/d+0WsqJbHopYcNKZdRz/Xann9Ec2pwWS4XMH7Ae3EdH9FRAPujobzgXAvzrEoUBq9uIPrV/d/NRnUejVR209aLHHjEamgJAXcOIFLd7Yt5jt1xr/9MchmeAiBmKxzPSoiZDQ4hXNw3Q7bf5RD/XoWtVy0kTCLYFP1LdFSlrcAakRSNd90zUxalfF513GjUt4XkPbqJYLlOD4D80Q+X3kWp4F+h9Q00MCF2xD84qIakY6W+ecOqd49lMo69gYW7jxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vZWD8DO0Kc8fhBACxEeMKNhoMsPXBP01K1GEstIU8Ow/OdWahwJCJPgF1YZZ?=
 =?us-ascii?Q?lcc30DNYy1kHWdX14tCGsN4vM3FLj3X47ZINzV1c70U9++rGW0ah7jsBZJGX?=
 =?us-ascii?Q?jAJzfDwpf9erlkYwEPVxuvWSo3gn1y8hHm99feZGp3HDlhv97mi+94jY2dt8?=
 =?us-ascii?Q?5Ow+EHE+XTXUEp9zuWEV5+Q3xfBuvHoryfVrmcNYaDPbPGrYUskOZxKbiKy2?=
 =?us-ascii?Q?6kS3GzHJFJZhZqT/0eEb8no6eW8ooJjEmL51SYaRZ0eh2LkqBZ2Aeb7lLf+t?=
 =?us-ascii?Q?qfhyPKa+txrA0Brfi1Dl3IsnzjHKCzttVNp8aKvcxN2KKLqfWOHmw4wJakwr?=
 =?us-ascii?Q?GyqoMezbw/VsSJhMqESfALu34UfkYO1h9ICNcJkadjPUgGtUHsHtZnjm1cLb?=
 =?us-ascii?Q?wz194pMbP23e4z5QIUTYHDHAfV6n/IumL/0gOnXlISizYIwEMoCsahUluGCO?=
 =?us-ascii?Q?U+oFrOQJHUqhE+VMlO0wSIHH7vsJegehuUX3nP2IXxTXrwUBQxyY3gNc2Bsr?=
 =?us-ascii?Q?pUzXOrgf2AsnRCynvi5JH5VNqG7KH65f4vKKjNWO4EeLseMM478/U3MwNhdv?=
 =?us-ascii?Q?jhGq6FXFKOsqEbFt4u4oacda3vHm5YU6CUZcnx25x0uQNiL/2W7pLZuCfuyA?=
 =?us-ascii?Q?gVIa/HP0QRxiQWZGLHICLxmlLIgrGBbML6/cjiZd5Z20WpmvXLcb9wC7utU8?=
 =?us-ascii?Q?9Prh31jE4ffkEi7yhxzVJSC4upBvBlhtPQmtyvTqMQwPgouKz/fkS5b7ksUl?=
 =?us-ascii?Q?2JvYu/moIH0uObwoZ3J1YAXxqwmSnD8aCzToZ8/iX8eXJXZ8sDLhsDw+8eOT?=
 =?us-ascii?Q?rKKZ73wefrAIDMnenqf6GIBoInbadOCuOwB1P/GLu40+U5kni88tXcfdouN9?=
 =?us-ascii?Q?Gv+JLGi1I/ol2ILQacD7vuclSZbZuLFgkibuSpFObzLdEJzEiBqKhKfSbGri?=
 =?us-ascii?Q?yCuebi5oiriPtHyfkcecTygeWoYdDZJFO5efykOp56awSNeihgnWlN9EEkR8?=
 =?us-ascii?Q?w7lmYLb/3qtU68DRwpNZXlBdWBWzvp18dzME190nZfA5Lcr/GB+rPSS3x7D0?=
 =?us-ascii?Q?tAYSQsey9fNIo2DNp8rms7/xu3B6tR6JkIbug88fEe1TQZnW7ZmJOSxjCaOx?=
 =?us-ascii?Q?5m06c3/jFDNuiFypKVVN2xno5n6yoyrnw2sShYpCro7zDVIy1fmw85saJwtK?=
 =?us-ascii?Q?oRa/1Yha89SFs3b/7bsqlvWu7monMGN6JtZGFA5q7M6o/dqn7p35Yj/Sl5qL?=
 =?us-ascii?Q?M8fAmKcXsfYwK7lhxGv6DCmPH3IHmrX/DNdBnwICgEY7UUaBSr5MuifaWErO?=
 =?us-ascii?Q?CQDEwdwt55Ti522tEt9VFYVF00fhip+1XZj7p+5fzbOx53AtGGLIs3cN7Xez?=
 =?us-ascii?Q?Nf8MMOqyFmIPxjGzoPUZkz7mg36oG6qruKj8AOSgmr3ojfma8VdKMf7HBZ4j?=
 =?us-ascii?Q?lw0T7cxHsvcQYoB8JhGd55rCkxCxZrSwpa463LRNuwmnVzZLRw4dUO/N2BgA?=
 =?us-ascii?Q?zplD8SxsaLaPNHKbd5XeYculzYhbiJ3tfJLhBAhNyFZnqkBrsjwgC2tyOYvv?=
 =?us-ascii?Q?hYL5DJrBBDQeBsRDAPCtZHBAiyR5DtRYiPZCPJ2KRKLts0PSM87S+vU7Zwi8?=
 =?us-ascii?Q?EaK7yFhfyxf4V7OV6zsAL2OSY9zllU9xXy6jaPi5FC52FwLOxh+Bub6bEpuK?=
 =?us-ascii?Q?3VfBjSwNvYtftMjroP/wjEw9BN6SRult5peaqkx5Zg3qcjzyk8MGtpZLU5WG?=
 =?us-ascii?Q?/n6ZLpxP6g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddac1b5-00b0-4b15-bfb1-08deea6691e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:05:38.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAr43SInWkDTZmcqp1HuuYPjSoJvw/KSZ35LGJ+2B5vUXf8w6Cr1/MU9gbIoOzPqk7owD8eXMi3F+gewBBktEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

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
index 3cc6fb1d20547..e11fac7f805e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3341,6 +3341,8 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 	unsigned int state = READ_ONCE(p->__state);
+	bool proxy_migrated = sched_proxy_exec() && p->is_blocked &&
+			      task_cpu(p) != p->wake_cpu;
 
 	/*
 	 * We should never call set_task_cpu() on a blocked task,
@@ -3376,7 +3378,12 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
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

