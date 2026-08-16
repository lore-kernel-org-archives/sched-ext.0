Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB86353EF7
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901889; cv=fail; b=j6n4BtIKKNgh2RRcaHRYaAjBy3v3hjmasuEKGDUZWhnJVMT1sfbPm5gzFN8E/+53j0c9haiNZiYOB3L/wBCMbqBQM5IVs87ZWzmz9HyD1byPkyfLxmyRv2IqjYmwDeiVUcGapo4bhuFotgP2jhQa+6cCQFLM1jRtwMUhIyPYHN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901889; c=relaxed/simple;
	bh=BP59sJEt2iXwRqt97mjeKBT0iLXqR7pCMD4F7l4CrcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8bebzLl8Zb6c7LUWDzDd4wyNrDxnZjVvfsjrYpi9qDsmeC1k+MKyqiNF/787nWzPZ2Zu8QeIO2HBEfDOwCz6TvvDH7CS/ZoXu+3wXAmgz8O8lqSv86Ee+9voUiXx1nnhR2FmFRNVrgKeDsGQr4Z53Ho+FbJ9PAN4IqedIYx1CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DPe3KgEi; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DPe3KgEi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKc7Cqts3uT9gjKfAwbgqwhRend2Ix6fzxCd7tNXAjliN243vCbb3Z/twKldZPB37DwWJi4dD4DdQYaRbMxOfZQ58WLUo7Atf5eCpVErPzMePGYLywV8WgL3gN5SdkAfypvGVuCxjhoTpgttUTg+wFCQ6MLxV1+UFf5VIR2RWD9rdw12Il5A7UazBgMrTmPfMUw43/kh1mXmNjurQ21f1HHUJfqGp4tD0MJvnNUlpY83BK4ry5MIH8j4pQv/Qt5eY6s3Wi8cBEK050wBnRokD6WgqCJA0AVPDUzR0s0Hg0KlcUx2qJIKtkRQqW0JU67rmNGg6ohbvnnhCakrS4hS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhJ0Nit5ZDvSb6XD0CxFukpZTZ+vKT62Didme4J+FHE=;
 b=BjLxJ4d9xrBarr4kkKkulbyHmUySjPbgN2VJucVFyZ1PHYyhy8eAk3zGCj7AYy92Px+GJrGrbaxbzDva6QmdV/STu0wGmPEcdvcp7+nGhWZS4lVfXVHHEGaEgci1ssqnzttLi+zDNiRXIy7Y6UwQCn8ezEkh0TLEvDD+uz2RSssrE7JBbxM300aA300hM6g+dueX74/ghydnEsUvjwW3AOmsNCMhEcv+Tvp+OxYooAOgoB/jIkIPWmxnyvqLgtlVAWK0/4XYvN+8L7+G05XqpRiYqlOmBA1+ZQdrLLjaIpyI1jfloZ8Phckvg+uK4sZwOkSvsA2r1vhUjPNr6gJ1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhJ0Nit5ZDvSb6XD0CxFukpZTZ+vKT62Didme4J+FHE=;
 b=DPe3KgEi98PBbcnPNikuxfvAgI5WS1cIGW6vt2EpLRT2nWTXEcGR4j+JCdMG7E418GII+gvK2epF7k7bcIQy1UcOC8p6pdkTOQcnocp0Tt98P4abpsvQaJSBCC9VuxF8EaGbbxdj5nGvh9mqO5+hoaMFU9SY/KI0mTdJtg3HCCDfIeOgYSH/q2OI9jxJppQFFh0rqA1BKfG+PwQHtfKL0PCHVN14E74YqDCmqHA4P3uyMU4BR+bnF+kvYGLFiO4GKXdbj+oL4XlTxd4meoZZLSdJexYKZJN4KkVujmsnHW03sS4aaKmfEhn+9YsNhodeavWgSxfc8taKnKtdt6xBvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:03 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:03 +0000
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
Subject: [PATCH 06/17] sched: Add helper to block retained proxy donors
Date: Sun, 16 Aug 2026 19:35:04 +0200
Message-ID: <20260816173732.17162-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 862c2c14-9fce-4d59-62e0-08defbbd1f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	YR9hjhrs+PqZR/7daQnM/lfL/pF9cn8aG1YUHuM+eAh8A7sBI5vGK1eZJ/FUe+V5ODJxT9DYpXpFUDtSg/o1CinVfSdO0tW0bqQSq/gns/pVel5hW8GOdWtujLACyTronZlMYFFb0mEZy1z44ZVkDI44IKdy7KanUTCEkNkVTUdo77r/ErJaY+FSPj0GnhI964OECaOMmwMxujxWo6EL2/DuQrV/YHo6buCk1PM1uLOlnIFAdpyud1HcqVKQXfWkBmWf6s3X+WufdqzwpQIrizTqyJ1fgrIv8AhydibKrC/htjHTjpuU8tBbv4/HpFzTeuxbQGNtssfVZeMlrf2UgTiK+Rp5WsiNpgyQy9cmWRfrFkSMpXfTWIS2JvhfhLAeqFRTQ6HW8pQufJbafJnQFie//t1eUdcBGigriIMQ/wO03v/QZKs6S691hC8t2VmVHYPdz9MBf+C4333P6OLeEi3GAtUumix4Hd7j9i5dR9gFr3uOu4UnlhL2iZzEZh3oPsMoTblNuX0OUPKu4qIkdp6rI3zFgMnc1Ft5myYxCVpmKlo6yMk+THrbzqqpQoQtmFn1v/Tr2hxxprA4R/kZGUBbSumH7qsvV3kjgKrNIrr+zDCp0ICjvPsB10XLKLRom7F88beDwBFQEhKlke3bRQ1EqbHU/2Zk3UFw2EmEMU0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JoukNmRNXJ15dQYFQEU5lz/TjP83SZArEn677hRDwQ0veCFLKbuKNIqxTmgs?=
 =?us-ascii?Q?4dvkIaCydQPcInBUEW1n6XcxHkI4RU5y4S79UmFwERzEkPUyV4+ucbD8vbAx?=
 =?us-ascii?Q?occBpUIlW4F2ZGJfg2QOrDzTl0J5wRUvytED2jYDDxphfqxIFtv7JoxZ9Gsq?=
 =?us-ascii?Q?jZXDKNUFgXQeRIsgf5U1oxMfCl88MBa75BiZTuofcZqnWEPOysyHgFS6WDPd?=
 =?us-ascii?Q?iOapb0WITeBIL9bxTLw4afcmKCo2yv7FxY+7lXN6hzyZwcx+/rpt9iC4eTvm?=
 =?us-ascii?Q?gHATQMLTW/DKssmqb+J0zMXa7FQTw2jlmsI/WYGpxhBP4vnqBsPZ0+peIDc0?=
 =?us-ascii?Q?OnkIQgsqYtyw1KRDZ7LhTSyLuX8M25gKuR60Kxv3mKVSmXO93dw8izBftthl?=
 =?us-ascii?Q?kb/YtBXJh+ye1LUNCGj9h3i3NbEVBkb2p1d6PZVSSoALJnChZYEtHa7x0RpE?=
 =?us-ascii?Q?DerkLOgQWS4TWBGadXGM7doeCbu/Zp9VVCAooXvDLLsUJ6hUtgFp1IAKpF7R?=
 =?us-ascii?Q?d7+I7e2jGXjKky7kRv1mkIew4m/eCSFrnrI+wdwnABjAxPK+Ef4Q2wEHXAP3?=
 =?us-ascii?Q?CL53kdlmabslmyBFxPuUe/RxRKU66B5p6lOcv4FDnNFR7tIAPm684PIPkl/i?=
 =?us-ascii?Q?aZuQq1le6lt912KNWs+brI2eFq0UKO7pFcE+KP0LTybMhkS0nBMdintzwpZr?=
 =?us-ascii?Q?dZiKuKEMyRzaIC2Zo8Wh+Bn82abGLKpEyCfwnzSGOPccbJWU4MG3XYkjHXg1?=
 =?us-ascii?Q?mzZgcQXlsKk9ZdzB5aStXKao7FW1c9v+gJXvq3fhsDxlWGaBdK9cgKsYe9Q3?=
 =?us-ascii?Q?6agpmc9M8vEHQvXIxneuZvffYCeM0tQZ1ea9SZ+RgPeJcDRsGs2D3sQqTeUY?=
 =?us-ascii?Q?1K9Y9rHsMqs9scS8YQitDiSDgrxTHYuks77Mji3/tY9wb2e2MOa8WMMedNkr?=
 =?us-ascii?Q?qHDUk1uCcVT4/nY8f69lp9aUvJWH/7iUeG9j6fKlWt5sGEQkuS7tNS0aal+g?=
 =?us-ascii?Q?WnSvbMczV0FxM6RI6VWC4Kh6jnT7qHhg4/0+Os/LeXCR+uproHkBFsK+EiV1?=
 =?us-ascii?Q?vUVmzvN/4u3i6Ee5wKrQHnYbwCT5vikRdKP5Vmffg2hPvOsWUsQmRQpVDZK0?=
 =?us-ascii?Q?64iPfiQjIhmVfAQZLtPIBFHl0O+cz2W4zi7av4c6wKIKZZ58gLSwm1soein6?=
 =?us-ascii?Q?ZuvAyy+6YvIRnO5XuQUm18kZhKxQ76oGDQc31NOz32Th786HSmurnRuUfz35?=
 =?us-ascii?Q?X7632odupDqGuI0XuO+JgwIyMxPwUWD8GDny7VA19tJwvjZ6Iaz3d21Ps/cX?=
 =?us-ascii?Q?2lfHlaXySGj2Ony0Ave82wvZUW2nfw9ndaMoAGLzmve0iEdIH0HgYQqYlUh+?=
 =?us-ascii?Q?vwdtAbSrRog2N1EaEKuAwuxN6dq4S4zeWxeP+P4j2RYudTwXh6RcWl4/ZK9v?=
 =?us-ascii?Q?Rls2s+M1l51UAQW2PDiLV7S4Ruit9fuszz2xZtorRix/LMDVe0GgKF46Q+Se?=
 =?us-ascii?Q?wUPnX86ayeXFvSJfkGxn7fGS3NGYy6DW492Pq3+4Er1mPQZnQaej1PvSCXdP?=
 =?us-ascii?Q?18BBmBp92UvUEQ7vpWV6sqbD5olVtgtUbSR5twcJHkCkiN1Lnm/GM5xTt3ME?=
 =?us-ascii?Q?f8w4hCSEmpCTovxgEF1jA4dKPjKNB30jRp14we/a7uC5ojZB1bRZPV/GTxO7?=
 =?us-ascii?Q?PiSNs7EMzFUdyUxC1UnMdJrLwhRlnrlCm0xtBeR0uh3QdDzCdp+LZPXf+sbt?=
 =?us-ascii?Q?WrhnCHNjLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862c2c14-9fce-4d59-62e0-08defbbd1f6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:03.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUe2JA5i68VZCk/znX1tjHgw8Nl5NcwUMETb3QeWrYNi3nSK6HnyvUJRMNqMNvj3ANZRhEF5TUa7CtzBgyfehQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

Scheduler ownership changes may need to turn a mutex-blocked task
retained on the runqueue for proxy execution back into a normally
blocked task.

Add sched_proxy_block_task() to perform that transition while holding
p->pi_lock and the task's runqueue lock. Reset an active donor to the
physical current task before blocking it. If DELAY_DEQUEUE keeps a FAIR
donor queued, the immediately following sched_change_begin() completes
the dequeue through switching_from_fair() before recording its queued
state.

This is a preparatory change to support proxy execution with sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 28 ++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6b883d21d5885..bb2b7faefcdeb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6813,6 +6813,34 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate if block_task()
+ * drops it from the runqueue. If DELAY_DEQUEUE keeps a blocked fair task
+ * queued, switching_from_fair() completes the dequeue in the immediately
+ * following sched_change_begin().
+ */
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
+{
+	unsigned long state = READ_ONCE(p->__state);
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	if (!p->is_blocked || !task_on_rq_queued(p))
+		return;
+	if (WARN_ON_ONCE(state == TASK_RUNNING))
+		return;
+
+	if (task_current_donor(rq, p))
+		proxy_reset_donor(rq);
+
+	if (!p->se.sched_delayed)
+		block_task(rq, p, state);
+
+	WARN_ON_ONCE(task_on_rq_queued(p) && !p->se.sched_delayed);
+}
+
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 458edb4e52c49..a6357c2d6a1e9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2492,6 +2492,12 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
+#else
+static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
+#endif
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
-- 
2.55.0

