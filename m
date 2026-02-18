Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4430CDA1
	for <sched-ext@lists.linux.dev>; Wed, 18 Feb 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403848; cv=fail; b=VPT/oBhhUhXpUXgassuOE9bM51AbUVZzNNQSpiaibVNH6os6paZSYBzJmnRJzPrSvKMxpeyPVmrHQt4zBQ+CA7jNl/4LsQrhJv8RXKcJGbRdrNeqxd85iNJ6NMrZazCr9Gn2ju04q4E4aS07rAj9OW13HPQqr2WScLNRVz1UTpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403848; c=relaxed/simple;
	bh=J8Nl5zlMR1osG6i+2P2REpttDtZjcctl8iM/+kZ1RKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OFXu96/C/Fw/rUKlw2CBrvXbKPWWig1rGQ1fozyYFHZHAxnnkk3E8ATwC+DZ91eliK1haFsvZy6Q+Y0OQkrRbU5ckMdDEhAovL82IkY75NqJCzAkFrv7L+7JaOi+wSJ/fRZlzGCwedRM0Os4Tt8BbnI7DnfxrOJIy1vR7UbgPTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AieY1s5i; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AieY1s5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0O8DrCfamTh0to3NpmjDT/axe2xg/uVwCXFjNnK4MaQDmYynLQWEAFHMhGBkhQPjZtUljV8m1wJVLBbCERM5Pp4KREu4DEfjPlcwkCeJinJ+u8gPSoyUvr03NibLohjcA2YFtTlOEa8N0XBDkur7eZdA6pHBSjXeesrIFaHdjeVLJvrqNneIDFCsh1hnbOnaPDtT+rwHBX2dGyQtLlzoZGcpwtKOfL1iQH27YX/aBMsjDBN9fR4ZySD/QU9ROQh5tt4o5dMVHOeqGf/gnHVFJ2hnSMrGRJmCdqbGC7ytPhIPp2rsNNyOSkZZhnpHf24ykkh6VUg42j6VIrUElYrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGaU2i6FNHj49mNkg/XXTK/fC7F8A/WqZnS8TZeJnKw=;
 b=YMsH42lSArGBCbrLhlimeGhTwxKBQ5YPGsJSAtued3iA8dHZ2Z+MZ0s4ncMt6Qr1ZwoBjzNK+C4eVRgd9tdr9k6UVnPQOt0hbM8daz1/xJUaAFqmu3+ZYxmxG1oXZLfzAbK7cfwVGAp6Cmaz8niA2mSErMU1ql+KVm9ewcmd4CPS3VAx1Zra/CFkMO86oSIghkVa+Osh4rJJxu1vWb6vakP+rQ9j2pPFWLRO3ndCaoBqSKi+aaai4xiyUYYzh1i004aEdMGAe24WjbeD+t4G4Z+J4qrJfoZdQZ8M9wPJHOFM58gQj7s93m8G0nx3d5afGr56qYRlcoxPwcj62OTtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGaU2i6FNHj49mNkg/XXTK/fC7F8A/WqZnS8TZeJnKw=;
 b=AieY1s5itt6naMPLHDglum9SW6ZhQMjPyFtIWUqdE7ehlss80e/S0HspPHzrIDKXMEjIxfBO/nSSKWFg7KZ+dg4PNJIW8YMLe4gM3bIHpAYKw3lHnJxXcvUSF0nERvUD15Kj+2zWox5Z+RkNqZUdlqUEIoK5DqPdn3JPiQ4x6ESb3tJywIMa/6pMN4ElB0N+nvZCj9MHZkN3yKriuXuxyeHnktGSIW2xYgJi6WaV0Jfib54wMBv3dy+1d5DlT2VEmcvgl1MhngegY4Wy3m80755MG23OL0Sup8MQdRCaQaLnN8R7Q+PZDVrUOpoqnh00uNP0PpsoO/aHqvDdcmNrvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 08:37:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 08:37:23 +0000
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
Subject: [PATCH 1/4] sched_ext: Properly mark SCX-internal migrations via sticky_cpu
Date: Wed, 18 Feb 2026 09:32:15 +0100
Message-ID: <20260218083703.22785-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218083703.22785-1-arighi@nvidia.com>
References: <20260218083703.22785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0168.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 7794b7f1-25d5-4a7a-4b9a-08de6ec8f03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G78udLRJxkiyr12FBy26ZYIgrQPzDc8/PdWZdUeIbttYKSPOf7R0IqggY+N6?=
 =?us-ascii?Q?dI2Jqw9nuMANHDpB1E2lRwM7PEYCxAnxuMcZSBA+tdq2MTGH8X6VIwnyjhcw?=
 =?us-ascii?Q?qRfkBW2s9Fg8IQHSd8VQ1J7Bg44XMMyLDZusolUfOW/Qz4eQINuqIS4zk8df?=
 =?us-ascii?Q?xh6m13u8RWQHdNcjvX+nJXhF+fXtd4d/prH+AIwdwvGdJvetVKMDjXOHlwfO?=
 =?us-ascii?Q?cOJwBGbFyBOJ8GeHU4hYc1oxRJbxhaO2uL6hf3hyNZF9D3n1q6LjpvV46hYK?=
 =?us-ascii?Q?RSaYNjUYalc5N7Oyk25yHpU3gZDBAVnQnyfcWB5QPg64rw6QeABMsKCMAyec?=
 =?us-ascii?Q?7zvlW6zLmDmqZg1hlNgJWUBltu465eVIIIDNMkHaTmQF5pOGT1tafDZTwGW8?=
 =?us-ascii?Q?yAiY7hZkNy6HN1iilaDE9ocoZtIJg0Rwa+l+8Z1ZsE2zWjUHXjCtnRKxHO+U?=
 =?us-ascii?Q?/21O+NL/eOZVCOguO3M27JMedeVoGHLhhiKnTYMeZaSa3jKk66Ataa+muYx6?=
 =?us-ascii?Q?vPrHIrNyWUVi1iCFP4QCHNl+58Cw0xk+AwjLEY4R2qUOxievTf1eE3w4B8tK?=
 =?us-ascii?Q?d1c3WGiDVgaeHnXiO2+FYOYxYMyyHLEcAdUUnp9CA8ur7BcebaCVc20+tvYW?=
 =?us-ascii?Q?zelux6+fxihpvqmczfzfoLn4MreyFSNCp/R8SqGK0+7tU+fMRzLWy3+NSCRU?=
 =?us-ascii?Q?EjBj0mF+3blz2EVy7Ack93pgHFs1Qqqpgpgb+RibSdeAorheSIUKccCjonbo?=
 =?us-ascii?Q?TTnJ0NkdAzNUPwWF9iBLpGhXwebqsPpd47HaIJT3+CPtpCHxb2sqWiz3VlY2?=
 =?us-ascii?Q?kPzzMsA75hg1pEYARhkrgVWD9SRvDwzWb7RQZSv4UeZtHB8gjARe1IaHIA3t?=
 =?us-ascii?Q?5flml6HOZ6rTUPBPBzqJpjLRXTjj04zaZC8RritjTyF33vNZD434hmQ73aMX?=
 =?us-ascii?Q?f1IBDLMIJdG3YUWRLOeimQ0wIzSRNo4V0WUsYaSVlTpjKkVr7JBQ0FRSaj1P?=
 =?us-ascii?Q?OtQ8G2TbcFiZDJlTgppf7T2HNX/WBvwfiWs2pOcucp94zFpJYNZBvXLpcBOp?=
 =?us-ascii?Q?ti3nGAZpOkKU7fFS5T/D/YdE7UAmEUSR+1wleIwT2JNaU4jkRVC5VlPIqEwC?=
 =?us-ascii?Q?LwfKDBYxYj5H6MdnMdkUq9kwvoHvqyjypW1O2zhqtW6/z1+gixppbAGiZWID?=
 =?us-ascii?Q?j94mgVnjEHX/3hDjy+qFRvkPM1lzE9leAPFoGkIN9I5Z/WZcBZWCPO8dywyj?=
 =?us-ascii?Q?TkkCYmiQ7vPAdo8ynSKn60zb/9FARISTDlOKNaqPDrfStpoQcjKLkESM8hK4?=
 =?us-ascii?Q?cHpNrr5hpVg/Hrf2VHspzuwFsDmzhpsmy7RE3BJwmqrgKodpEGhI7Sr5bvjS?=
 =?us-ascii?Q?41U+sPcOJ2f/OU0j6TX8R4EqT69cnbjXXkhWduhL+iVC8ZBwxZEP7+e8AfgD?=
 =?us-ascii?Q?52vvmQNmf8cwcjikAUumXdsTMqGHZ2wEN927T38j17shOqwWJ2KUaWCVDzt6?=
 =?us-ascii?Q?3eThuL9xH8V56fZce23Bt98tG3t2QWtA2jwpcVx+yI8ues0oTqwXo/Ix/uov?=
 =?us-ascii?Q?42c0ZJ5Jsnu8dvuHvGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TDgT3trgVF+6WuPoIca53gx36ieqvF685MbkozScGEhcUcls1nmeZ9v3vmt5?=
 =?us-ascii?Q?4wFVKcmxVUAikSdgLfmffARlZhOY/v/N495DWiKK5SzNYvUwMQn5LkpjjT3e?=
 =?us-ascii?Q?DaHEbbL94SRtO+oabWHntdAPXnt1cdbPjqfOrU5vAeA6Ab9P5gHXZ/svsnJd?=
 =?us-ascii?Q?mtwR0zbKUECZ/ZZ/SBkW359l5/xS5sLAw2mQaxp4PwoYeJDkF0yxelIPluN4?=
 =?us-ascii?Q?OOZqHoKU/guMAZzNDHf5Yi8hzAem8gZvkus1cmKGf8iCnelMrNY0Hmkv0ceX?=
 =?us-ascii?Q?8j8qCfskk9YguKQoTAe8WtZC4uoTYN4lGDoBR2AQxOY9Z9b+RO02GLYuareE?=
 =?us-ascii?Q?iwKb+i+skD5/0XKhnV9nNOg8OtVWNDHg7aPyfDM5kx4TTA0zr46wDqsCSHpy?=
 =?us-ascii?Q?azuDX2jK8uVF6aGDxqrsaUd7x1Br7NM9rip21i565tM1PZgb3MQIZ5pc7b1g?=
 =?us-ascii?Q?kRdHiR1iOYJ0tCAWLu1YvuSakSIZt0u+X+QGjBFtMoGq5QQU0ZSu7JiedGk3?=
 =?us-ascii?Q?DDSOAsUBV0ytFTAsr0VDxPyCAohEGSwipgV0Iab0o753MkHSOd8qcHfxN64J?=
 =?us-ascii?Q?LFlwFzOnjvFsS+1hX41JHLpbO8ypYl63A8nwx9bmzSqeG5TdSsRBOcbudjd/?=
 =?us-ascii?Q?LfJec/ZaPg7UM24rl/X5Ygb+RU/ccJC0GgqAND1DjtQHDqKqrzrPY5LJC3uK?=
 =?us-ascii?Q?KorYT3OV4uxsydh5sJwkTuRdmVq6sDFTHlKSjhLSODUJO7qX5WrWFQoQK10H?=
 =?us-ascii?Q?UattxOITypWiE7bm6+Bx3moPO/UVNHbYIuHT2RcCRxN55pmRg5Iv8+zemA73?=
 =?us-ascii?Q?EzwSpaNBGxb/L296XbZvsNHJOQzIeuy//EHnDj+QWgsxnzhhCoArYWtRmNhx?=
 =?us-ascii?Q?mVKO4adV1QSYBUvcft3JSabONlfoYv90SmLh0tnsSadq89Mtk32gHDelCjsr?=
 =?us-ascii?Q?IeUyrA6DFTA6PuogcNwtnXzzLfR+Nyo++B3z64Kq6L9HU46KUa1fWp5OQ+C6?=
 =?us-ascii?Q?z9A99AklE2yAoaUEAzYpX5Mg/4jHsjxSyLPKfsimP26LS0qLYJ+A8hucSa1k?=
 =?us-ascii?Q?PdBLge5asIYL3eI+qMB4NTCGMUGN+7+REs+0+tie+dSg+5bLMQCvrhIA8Rvc?=
 =?us-ascii?Q?CG9ujDQCFVWaEdjmjx8X2mSeHK0e/DUhXd5dD7UxAnpmPDHM420zNnEBtPRV?=
 =?us-ascii?Q?pmNXgSqQ4E24OsIh+TQ/hgYKeaYq2Ki0VW7t0f5zgE4zZpHvAfZNsiw+j5QD?=
 =?us-ascii?Q?XmF52KTnKudCiKNz+sO7t2XYNqerX61VIAZ6PJs3A4w8/XxO1/DGr0vSGkxp?=
 =?us-ascii?Q?FDRO2ym1kncil8kV44ZXzODK4l+FP7OJ/SPwv3Rqi+1K5qiaR5jBjHzJwLjC?=
 =?us-ascii?Q?khcDMxT/xAWVDyRMoS44oQteL99aLnTpuZ2trogQQ/kknESOnjXVTUj5Ltwt?=
 =?us-ascii?Q?vybU3dQEuqtXatxoPbYIZQbQdGG5NtvoJRs5Uj5IxRSwxojPvaFjHaMZun50?=
 =?us-ascii?Q?lNrp7hTpYBp767PcQyAQ1JNQRYkPzeUIUwQoK/8F+3gUq50MGyCEy39bFQBe?=
 =?us-ascii?Q?NFo/bc1ceGK5/y6jmJ3nrJu4YS6kdyRwcWgploCQKTsKBHSZZeulierpicfZ?=
 =?us-ascii?Q?ADxBkanPeF5vTU3I2qvoVmDORKtoKrtpiVj/FPMo/WDKKQc1pfsRsv6g5hMg?=
 =?us-ascii?Q?szoUHwXxs7xr2geG7eus5ipH8FLcQetQ5RJIc5cT6tFd0fcy49iUT7sJj4az?=
 =?us-ascii?Q?yyfMXMOOIg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7794b7f1-25d5-4a7a-4b9a-08de6ec8f03a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:37:23.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xi2fcj7VUyIXhxsMINfcAKjH7P7rtCio7YKCBI/htFS0Npgr3mTzHnFlJu/grLtXaWK7cnff/y20X1272Y6gtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510

Reposition the setting and clearing of sticky_cpu to better define the
scope of SCX-internal migrations.

This ensures @sticky_cpu is set for the entire duration of an internal
migration (from dequeue through enqueue), making it a reliable indicator
that an SCX-internal migration is in progress. The dequeue and enqueue
paths can then use @sticky_cpu to identify internal migrations and skip
BPF scheduler notifications accordingly.

This prepares for a later commit fixing the ops.dequeue() semantics.
No functional change intended.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c18e81e8ef51b..3885dd06dd573 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1476,9 +1476,6 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 
 	enq_flags |= rq->scx.extra_enq_flags;
 
-	if (sticky_cpu >= 0)
-		p->scx.sticky_cpu = -1;
-
 	/*
 	 * Restoring a running task will be immediately followed by
 	 * set_next_task_scx() which expects the task to not be on the BPF
@@ -1509,6 +1506,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 		dl_server_start(&rq->ext_server);
 
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
+
+	if (sticky_cpu >= 0)
+		p->scx.sticky_cpu = -1;
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
 
@@ -1670,10 +1670,13 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 {
 	lockdep_assert_rq_held(src_rq);
 
-	/* the following marks @p MIGRATING which excludes dequeue */
+	/*
+	 * Set sticky_cpu before deactivate_task() to properly mark the
+	 * beginning of an SCX-internal migration.
+	 */
+	p->scx.sticky_cpu = cpu_of(dst_rq);
 	deactivate_task(src_rq, p, 0);
 	set_task_cpu(p, cpu_of(dst_rq));
-	p->scx.sticky_cpu = cpu_of(dst_rq);
 
 	raw_spin_rq_unlock(src_rq);
 	raw_spin_rq_lock(dst_rq);
-- 
2.53.0

