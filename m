Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B683469EE
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012843; cv=fail; b=f+1LSISz3heeOZqWAgt/1+pvvpMzp5ty8o2kQ7PBRNQFRYbF6MLjpbbwlzt+pEKo/VSKhSJ3nUAxP0tacmaA5qWP9tW4SZeGA3P5I2TUpt9h7S8nM/i85Ru5zgWoAWH2U1iz4x/1fx1Mg275HUdn5Bdo/TU6VnxXaUY7JFVb1kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012843; c=relaxed/simple;
	bh=O491Rti8Y4q6esomIZmohSYXq2eUBJEbDa7+/MaEI8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZGtlxHAq0a4Lg5RA6faFRooMQCcsnj3htpylCX7lTkyBwSlmqBLoviF+m717k+NvpDLIRKVmoyzuUUiixWo6Mm2+eNg5ZzfGOb4+Mto+2uUV3tjKl5LnNqRjL6PKJAmDdituu1y895MbAYAplqFoZ6407wh8hZpPagYztpbP9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IYmrpKvU; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IYmrpKvU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqqpm4khLAKwmfHnCmCNpaPMO0jH4W5uoszw7M/QGl3P7QSPdUrW0jH5/GQl6+EowGA2mS/FPFT2sGVkLWEavf8Mrw7n1L3hwBHnDb/BzKpAp7ZqqXD1RIncK/A0r1i82UXtWfYsouFwqMrCBCLG1rQyctNUQvcMHEvmXYUoZGAkTRb0lcrCW5Bx/rBd7I2TeImF+/HxIihG6hD2ASLfw8tHkHtBXG/cPIy/XndFTxhMwN6xhiMO3FZmiDjzE8C0BqVfzpuDBDu5Nv52FWR2Ah1Y75LFfGbp1zuKOCwnFTyPG8TcbuaeVzmfyGCpJQTgWAqS3ySJLVVfy72O8dOR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCS9NXkyGeuGTvLsoAQppJd2YmvQHTVFk3sD9Yvuuh0=;
 b=x8MrncCJHo1eSGK6Vmbdn8pLgFD7QFeVruTtNOajcwot473vncVMM7T6C1B5u1C4OAVGSkhLtYvvr7qghsaq8v/uxDaIf52MTZHOUcrZV1ORaaGJpesDBE9FcmGDc0umE1bc/5CNtGmPAfzQrtVwrQLn88CvH9dWR9WI4FhsjlUE3yLhTtvyW4aKYwmjem1DIC39O9trUTnOwDTkD2J4hMZ5ijSahPqM7sJw/nroHaxkz2M8uAynj65lwBQ+TctLAeZRwAf09/y7nc0xDCW+tmzbVOw55nsnqwMxpdkMqRg09mfZqw0AI0ILYkqVvoBIGtj2QS9KlerQD4teYioehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCS9NXkyGeuGTvLsoAQppJd2YmvQHTVFk3sD9Yvuuh0=;
 b=IYmrpKvUSAcntQxsh9mcDULWzKLqJqY2Nk9TvJ5CrJ7kytXWhGq2cGKPV+g8JQrmKGEmIghwLRgugN2Z4Ounq9NsSdiWJX6HC82i+7pBcISAtVFUr/xmOhEQxPdCNAGkMSEq+ub3+uA8QgBbEz6ELF02750xzidxF/ZpkkxpsRIqST1dlNrNjrBH0ejWekfo2zk/Fi8ZY8cAfJJon/xwnUoPgaC2GqOmCBF3gaKh1caXXR6mYhx5/4IfTNbsRY0/qtj/o+/Gn064nGzvjIudQeo5N2hv5y6vbqpLSKVODViBcpVV7PxmEwvva7TayqRk4t8m5UUlRGHhMYfVCC/Sjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:20:35 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:20:35 +0000
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
Subject: [PATCH 09/12] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Thu,  2 Jul 2026 19:09:25 +0200
Message-ID: <20260702171909.1994478-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0084642c-c392-407b-4b0a-08ded85e3a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|5023799004|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	uhRKnbTrmmr1f6bECZeGV/6jwKVrpOHz4Xv+AgmMCJuyTAnx+mR9jFBgm6XXIoms93xPUHBK4D7/H0FsMf8J+sVAli+NA+uO6DvsUrww6rEsIzLJ1D7BqVnFoXilMcnCycgbQFumBrbLlPmq91WDTMDmKnhM+AEHK+Wco7d0U1bMeYyV9HR0TgAyiiNHE13eSPse7x/nHf3AieYo5MvBHuoKU0m5wmfKO+rGIeuPDhoxhnRc8hy9rOdABh+qBE/uvflWYZ7kHIXrGi5PnoIIH1YEcG2aECiZXUvEbMaACwzDPS11bSDgbhATTtg9HjZ9M/PSaue6SMRXiR8/EHJCvHZ2dD4wLaGdTZSpbWFUMdsgD6ZtiiMBXdePImTQ3WYHt+jE6ovLiZp5wlAETdyggYSXOxnrvReN9A/hEv7ZfmnN8OKw8HrI7ZDm8w436721xApxAsaDkYEf+SqjT0cD1oY6PJfsg77xgrBdQVZJwFtrrj+bDg9zNNy3bIHAl5xDLlO6Cuv27A6AvTxAhDuHtaJKPqoQOrswZvQZF9fSdue3yHOmMoFtglHA/FIg22e89sKA4I0FhLs3xvUCnVqO1uzZg58Up+81BipfWIbe7mH9TZ7uduhNg4VRbTx00cP0WkOSzK889nOGFPy/lBC7nJ0zYqf5/8lw75PJoUrj4V4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8Rbw+WHNDSG3ADyQGDr2aadzDV2DnKbYYOPN7b5vMQPKOtbEok+4f9Jury6?=
 =?us-ascii?Q?V/98Vh3fbnnAsaOsNSoxT8yozBm8vSvBIvXkw6Gr9UVEOkvCMrjSmp7eDQz+?=
 =?us-ascii?Q?HuaZueIPyfjMVZAed5tLDitLHrqSEhhD0UUOCrBQ+n+bmMxPPV30H83VjhT9?=
 =?us-ascii?Q?hqoryuh4oyEeP+0+oAgxdZ9G6DEmJwI8Gq1dcRZ8X7fWxttnYtUcwn3QrwGk?=
 =?us-ascii?Q?Hab8bPBzLUTCoee6mMwTGjTHBlOYvtIOCnpCFe+DuNmhN+olpTrgkOf9A+ca?=
 =?us-ascii?Q?EivhFzs3AZ0CJuXlAGoNi+EVr8kqPrPvhirUmGYH6aFetSWGoLId1As2Lfvc?=
 =?us-ascii?Q?6F4G/IQCEXUbI/DEIOi/mbvCL6iszNe6DEreMGipVp3rQYqDI3gw9nm2+GNr?=
 =?us-ascii?Q?iMH4nvK7w/yNtkMw1+ipP/Zo9V8YQ6UoZJ1OJPn9Gmqro8EsxobLf7sZojzC?=
 =?us-ascii?Q?8tXiPwYNhl2wM3N8ttMC1UBedGJuS8LVQSIuA2yFyiYaMbqEhcm7Qb+/Kma4?=
 =?us-ascii?Q?51y/qkZJRuFvLGBdihBLndocbadkeKiEDI0F3VH34t/5oihgp3+UR/xEXLOy?=
 =?us-ascii?Q?5vQKBiqzQrZ1OfqRg+nbumElQStF++GT0TAHfRDu8cULK9m53tDmQy8hPNak?=
 =?us-ascii?Q?9+HXkULVDHDtjlpPJQKrBF6u6ytwiG4f5a/FlyhYr/504S9SNQsBQwLDxL0u?=
 =?us-ascii?Q?Gu7wgBEFblBUThvCGea6M1U3XoGWjmz/gccTeiX9ksuBfJnggSf3yq2I8iHn?=
 =?us-ascii?Q?QSW0w+1LT+Vvh5QXypf9kaeFvjw3H8h26fbueMymiFxeWEI9qP7OKGoGKMsz?=
 =?us-ascii?Q?QjZC2GkNZbyHip/QRuOh2jchIL6WE6ARSI3TnZ1AcffGypp0FApV+wDyTs7I?=
 =?us-ascii?Q?HqOiwXIwA562Al3CDDHCqoFQnT+K4UsdxCrCx5SqxuSj1ZLt3/Lw9cQd+LfK?=
 =?us-ascii?Q?rLUw4BiOAcQsE2rN0lMSn8FDvIvUHdD1poF6ujca8whhZqxsiK6Ve5+babD3?=
 =?us-ascii?Q?sxtKerict7GIE/ld13TeHatqZdPMlo9SqYkBni2IMlb02rnsnaaShOzlSKFN?=
 =?us-ascii?Q?3RY9fVNrP8fNRxrpgxs+HNdvR+ppwoQZeZYaYLTZfcvuDR/R7YZfgf+akysl?=
 =?us-ascii?Q?9v8qkceAzfavBXPAnt9Hha5LeXQMPyk7ZlXxAf/KMhfI+yiyMWmAe0rjlbm7?=
 =?us-ascii?Q?M1yNb342zzHbJKPyvzB18dfbIQiPj9Zv9Q0TlRMOVwUbGnhQVbHhURNNSeG2?=
 =?us-ascii?Q?8vEv+Ybqgom8yRwqjtCE0LjW3Yn5IbAqx9nvH94HKRlUPdSPbU0aSLxfnCgF?=
 =?us-ascii?Q?XP/YUpGwpw/lLtbLxyt2U5NdcZoEfLxM3cmYJAmZdowb9vt7FR2z6XlkX25Y?=
 =?us-ascii?Q?qpNOUpMvIm+yiD43pDAkMXHIE8d8CnhBr8WhSGkgwEHOvBUQHY404zapLMx+?=
 =?us-ascii?Q?TLeq/8fhu/q+4lSTnqUvsIiD0g2K/cWZ21fGGIARsUcYeKxOgdrm+H2UO513?=
 =?us-ascii?Q?Qshlh0tteojm0uTjeW6Igv/FKFEiM6TeTHIj3nZpTdidbPfPEJzN6i2OsgnS?=
 =?us-ascii?Q?cBn4H7wL6BdnvHuRl8XYbTORzopjE5vDVSYh4PQb55V9WGAofvvMwWDVV/rj?=
 =?us-ascii?Q?OZvrwBVSWHK6PSX1TbScWsuQL80t2268tYj1CQzr5Lk41qHkmuFdoqalN5Io?=
 =?us-ascii?Q?XC3HapYSwvMGOe0AYlyX5Ni3L2uhmlprGYgCv0jE4XppHc3ghy7deXt6Km2H?=
 =?us-ascii?Q?o3rMim8eSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0084642c-c392-407b-4b0a-08ded85e3a6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:20:35.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9fPpG4PPI/SJTM5tHm4xBomtIN/9SVYyJMxiCBoPhaMK9C3SzbCO/zFCSdUDcsiD4fHDfEl7nFJNrPi/DUN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

Proxy execution keeps a blocked donor runnable so its scheduling context
can execute the mutex owner. Dispatching sched_ext donors on a local DSQ
bypasses the BPF scheduler's ordering policy and can give donors more
CPU priority than intended to perform the proxy execution handoff to the
mutex owner.

Add SCX_OPS_ENQ_BLOCKED as an explicit proxy execution capability.
Tasks owned by schedulers without the flag block normally. Schedulers
with the flag receive blocked donors through ops.enqueue() and can use
scx_bpf_task_is_blocked() to apply their own admission policy.

The donor starts associated with its original CPU. A BPF scheduler may
dispatch it directly into that CPU's local DSQ to let the core resolve
the mutex owner and execute it with the donor's scheduling context.

Knowing the mutex owner's location in BPF is not strictly required, but
steering the donation there can reduce handoff latency when migration
fits the donor's affinity constraints and the scheduler's policy. Add
scx_bpf_task_proxy_cpu() and scx_bpf_task_proxy_cid() to report that
destination in the corresponding address space, and let the BPF
scheduler decide to migrate or not the donor to the mutex owner's
location.

Reschedule a retained donor when its mutex wakes it so ops.dispatch()
can reconsider the now-unblocked task. Make SCX_OPS_ENQ_BLOCKED
override the exiting and migration-disabled enqueue fallbacks so
opted-in schedulers receive all eligible donor requests.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c                      |  36 +++++++-
 kernel/sched/ext/ext.c                   | 108 +++++++++++++++++++----
 kernel/sched/ext/ext.h                   |   2 +
 kernel/sched/ext/internal.h              |  19 +++-
 kernel/sched/sched.h                     |   6 ++
 tools/sched_ext/include/scx/common.bpf.h |   3 +
 tools/sched_ext/include/scx/compat.h     |   1 +
 7 files changed, 156 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6aedb26c08ee7..f0edfbe8ce232 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7018,6 +7018,39 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	proxy_migrate_task(rq, rf, p, owner_cpu);
 	return NULL;
 }
+
+int task_proxy_cpu(struct task_struct *p)
+{
+	struct task_struct *owner;
+	struct mutex *mutex;
+	int owner_cpu;
+
+	if (!task_is_blocked(p))
+		return -ENOENT;
+
+	mutex = READ_ONCE(p->blocked_on);
+	if (!mutex)
+		return -ENOENT;
+
+	guard(raw_spinlock)(&mutex->wait_lock);
+	guard(raw_spinlock)(&p->blocked_lock);
+
+	if (mutex != __get_task_blocked_on(p))
+		return -EAGAIN;
+
+	owner = __mutex_owner(mutex);
+	if (!owner)
+		return -ENOENT;
+	if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed)
+		return -EAGAIN;
+
+	owner_cpu = task_cpu(owner);
+	if (owner_cpu != task_cpu(p) &&
+	    (p->nr_cpus_allowed == 1 || is_migration_disabled(p)))
+		return -EOPNOTSUPP;
+
+	return owner_cpu;
+}
 #else /* SCHED_PROXY_EXEC */
 static struct task_struct *
 find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
@@ -7148,7 +7181,8 @@ static void __sched notrace __schedule(int sched_mode)
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
-				  !task_is_blocked(prev));
+				  !task_is_blocked(prev) ||
+				  !scx_allow_proxy_exec(prev));
 		switch_count = &prev->nvcsw;
 	}
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c48d043dbe58f..8ffbf857acd51 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -23,6 +23,14 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
+bool scx_allow_proxy_exec(const struct task_struct *p)
+{
+	if (!task_on_scx(p))
+		return true;
+
+	return scx_task_sched(p)->ops.flags & SCX_OPS_ENQ_BLOCKED;
+}
+
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
@@ -1700,6 +1708,7 @@ static void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_fl
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1732,15 +1741,20 @@ static void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_fl
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
+	/* %SCX_OPS_ENQ_BLOCKED takes precedence over the fallbacks below. */
+	enq_blocked = task_is_blocked(p) &&
+		      (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
+
 	/* see %SCX_OPS_ENQ_EXITING */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
+	if (!enq_blocked && !(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
 	    unlikely(p->flags & PF_EXITING)) {
 		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
 		goto local;
 	}
 
 	/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
+	if (!enq_blocked &&
+	    !(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
 	    is_migration_disabled(p)) {
 		__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
 		goto local;
@@ -2042,11 +2056,18 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 {
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
-	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
-	 */
-	if (p->sched_class == &ext_sched_class)
+	 * task's slice to 0 and triggering reschedule on the target CPU. A
+	 * mutex-blocked task is kept queued for proxy execution, so its wakeup
+	 * doesn't go through enqueue_task_scx(). If the BPF scheduler manages
+	 * blocked donors, reschedule explicitly so that it can reconsider a
+	 * donor it declined to dispatch while blocked.
+	 */
+	if (p->sched_class == &ext_sched_class) {
+		if (p->is_blocked &&
+		    (scx_task_sched(p)->ops.flags & SCX_OPS_ENQ_BLOCKED))
+			resched_curr(rq);
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2837,19 +2858,12 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		set_task_runnable(rq, p);
 
 		/*
-		 * Mutex-blocked donors stay queued on the runqueue under proxy
-		 * execution, but the donor never runs as itself, proxy-exec
-		 * walks the blocked_on chain on the next __schedule() and runs
-		 * the lock owner in its place.
-		 *
-		 * Put the donor on the local DSQ directly, so pick_next_task()
-		 * can still see it, find_proxy_task() will be invoked on
-		 * next->blocked_on and either run the chain owner here, or call
-		 * proxy_force_return() and let BPF make a new dispatch decision
-		 * once the task is no longer blocked.
+		 * Mutex-blocked donors only stay queued when their BPF scheduler
+		 * enables %SCX_OPS_ENQ_BLOCKED, so always delegate their admission.
 		 */
 		if (task_is_blocked(p)) {
-			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
 			goto switch_class;
 		}
 
@@ -6581,6 +6595,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	if ((ops->flags & SCX_OPS_ENQ_BLOCKED) && !ops->enqueue) {
+		scx_error(sch, "SCX_OPS_ENQ_BLOCKED requires ops.enqueue() to be implemented");
+		return -EINVAL;
+	}
+
 	/*
 	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
 	 * may set it to declare a dependency; reject if the root hasn't
@@ -9294,6 +9313,57 @@ __bpf_kfunc bool scx_bpf_task_running(const struct task_struct *p)
 	return task_rq(p)->curr == p;
 }
 
+/**
+ * scx_bpf_task_is_blocked - Is a task currently blocked?
+ * @p: task of interest
+ *
+ * A BPF scheduler using %SCX_OPS_ENQ_BLOCKED receives blocked donors through
+ * ops.enqueue() and can decide when to make them available for proxy
+ * execution.
+ */
+__bpf_kfunc bool scx_bpf_task_is_blocked(struct task_struct *p)
+{
+	return task_is_blocked(p);
+}
+
+/**
+ * scx_bpf_task_proxy_cpu - Return the next proxy execution CPU
+ * @p: task of interest
+ *
+ * Return the CPU of the mutex owner toward which @p's scheduling context
+ * would next be migrated for proxy execution. The owner relationship can
+ * change after this function returns, so the result is only a scheduling
+ * hint. Returns a negative errno if no valid proxy destination is available.
+ */
+__bpf_kfunc s32 scx_bpf_task_proxy_cpu(struct task_struct *p)
+{
+	return task_proxy_cpu(p);
+}
+
+/**
+ * scx_bpf_task_proxy_cid - Return the next proxy execution cid
+ * @p: task of interest
+ *
+ * cid-addressed equivalent of scx_bpf_task_proxy_cpu(). Return the cid of the
+ * mutex owner toward which @p's scheduling context would next be migrated for
+ * proxy execution. The owner relationship can change after this function
+ * returns, so the result is only a scheduling hint. Returns a negative errno
+ * if no valid proxy destination or cid mapping is available.
+ */
+__bpf_kfunc s32 scx_bpf_task_proxy_cid(struct task_struct *p)
+{
+	s16 *tbl = READ_ONCE(scx_cpu_to_cid_tbl);
+	s32 cpu;
+
+	cpu = task_proxy_cpu(p);
+	if (cpu < 0)
+		return cpu;
+	if (!tbl)
+		return -EINVAL;
+
+	return READ_ONCE(tbl[cpu]);
+}
+
 /**
  * scx_bpf_task_cpu - CPU a task is currently associated with
  * @p: task of interest
@@ -9597,6 +9667,9 @@ BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_is_blocked, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_proxy_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_proxy_cid, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
@@ -9632,6 +9705,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
  */
 BTF_KFUNCS_START(scx_kfunc_ids_cpu_only)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_task_proxy_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_cpu_node, KF_IMPLICIT_ARGS)
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index c7fa4d06ac7d3..08c64547b0143 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -20,6 +20,7 @@ void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
+bool scx_allow_proxy_exec(const struct task_struct *p);
 void init_sched_ext_class(void);
 
 static inline u32 scx_cpuperf_target(s32 cpu)
@@ -60,6 +61,7 @@ static inline int scx_check_setscheduler(struct task_struct *p, int policy) { re
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool is_ext_class(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
+static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
 static inline void init_sched_ext_class(void) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 1774e44aebcf7..a958c9d3144b3 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -212,6 +212,22 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, mutex-blocked tasks remain runnable as proxy donors and are
+	 * passed to ops.enqueue(). The BPF scheduler can identify them with
+	 * scx_bpf_task_is_blocked() and query the next mutex owner's CPU or cid
+	 * with scx_bpf_task_proxy_cpu() or scx_bpf_task_proxy_cid(). It controls
+	 * when donors are dispatched and whether they should preempt work on the
+	 * owner's CPU.
+	 *
+	 * If clear, mutex-blocked tasks are removed from the runqueue normally
+	 * and cannot donate their scheduling context through proxy execution.
+	 *
+	 * For blocked donors, this flag takes precedence over
+	 * %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED.
+	 */
+	SCX_OPS_ENQ_BLOCKED		= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -220,7 +236,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 56acf502ba260..c4eb70371f7af 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2470,6 +2470,12 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+int task_proxy_cpu(struct task_struct *p);
+#else
+static inline int task_proxy_cpu(struct task_struct *p) { return -EOPNOTSUPP; }
+#endif
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index bd51986c4c42e..4b82af377a15d 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -95,6 +95,9 @@ s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
+bool scx_bpf_task_is_blocked(struct task_struct *p) __ksym __weak;
+s32 scx_bpf_task_proxy_cpu(struct task_struct *p) __ksym __weak;
+s32 scx_bpf_task_proxy_cid(struct task_struct *p) __ksym __weak;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 23d9ef3e4c9d2..8d5606e465080 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -117,6 +117,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
-- 
2.55.0

