Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4B3F12E1
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672825; cv=fail; b=NyvKhqnK27guA4b6zKffwEkshshchnTnxsju11sV3lAWz1UkGe5iR0NZwOlAn6i7BZAseJcK8NjzgrTy9ViHHywbFhWBjYSi1SzbYQYB80reXIOvvhNKkZVpxs3hoSvf+FZCpxw277WATiozeEQbyA0F0klu2bjo7WRju2Yec5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672825; c=relaxed/simple;
	bh=7MuTlIhpCokeqIEfH92DEis/so/u9DMvo1A3xbu1hEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iaG5GTup8vBt3KgWzsg5cZBWRsmGcPkuTZfd6gPSEh03ed4qAbbn/4tQ1VDiWylgDaeDd2KeUkNhBvK+QvSd0KhfFg+YQYNUegeOr9AUQvDIcLrDZYAi6wKYONkuQrIrYw5MPvAMA4h3nygkWAtNo8gSi6nFI2rM0Wh3qKQ/bvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWM6n1J9; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWM6n1J9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNu242EncGqn5i2yRO2RUTy1pDR1e7udGKUyUidLTw1J+I2viomF97eT3igi4UzwGcIWLKElCFR5dugw7Tc3jquXh9/gYxJejpHRAXKPuJml8TPmHRCOz1kbua2ew6Q/9lNutjWH7kyAD0bC/8N1eK/3dgBMbYxSAvKhctrAeu0c3zAarbyYq49g1BmowrWKpYikBpi/E9DRk9hLy8ccJAze/m04TB7dJfKCma3EglLYTYXzMew51P44QvJu3oOwBj//ZMX7hMHeLDLzZ63fZHbQiCp01oKtgW3NaQUIkMjl53kM6jZ4ip/d2gN1EMkRMOQcnBoiNlvMJ5VtPepg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWUVua5jdPYTcMpFYJEE5tPcNXzbBX88GmeVPcKM3IE=;
 b=Gb4GGqNvauca5Nv81VckauNbZIbSCvwkzik3+ofLVE0L9jKXWwWzHcLELhrC+pS8NHqwjIVcuLFk5AF35VLrLNmGpUTSI2mjykcakzfC4Fk24GuRwAK5E+u81CXQYDHGn1w6wlzO6RAqBGJLgFs4WsDK332hlu5tt6tC32fgr1BhHwgI8bK2cTNnV0NKzimsPKIbRsyNXR4GAZATsbFnUXmTP8RMFdE/+FH2arMrA1ZalRGc23UvvPO1NNUATOMAGMSCK9o4NHAH000lIO+JNHXlpdgmuuqSjA6mxMM+w7WxKYZqdGrOJoud6T1zH02bvvk6Zuzy4oTMTP/iItH6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWUVua5jdPYTcMpFYJEE5tPcNXzbBX88GmeVPcKM3IE=;
 b=GWM6n1J9qUKDgz55BFmffb+pafVh74JYReWss7nGagQdkfZYsNDXhvchhDhm6y4hfKUuEciMvFlfg/OKMpeT1z0csCESSQ8JYFfXxh1S6tXhAje7U/DH4cZSpkGQq8gdSedyskpIWBaqIcreagRH/RhuYk5kGQco+sDLmhGC6lvJn8OyrU8eopwjBUl6ugrW0/5vISlpS4lBLyazoy2uqSwrwvX08lDLRsl/Gczgx6Vz0l8+dDeC0tGyG7eKcRktiauDUFcHB7yFZ+xEFrCt5xTmCOU9yLlhakNOeiy0o+pAX2b7odTSAAGRzMLZr0W9vAyy7vNQV4rl6rcKfOHouw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:40:14 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:40:14 +0000
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
Subject: [PATCH 07/10] sched_ext: Add proxy destination query kfuncs
Date: Fri, 10 Jul 2026 10:36:31 +0200
Message-ID: <20260710083913.30573-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710083913.30573-1-arighi@nvidia.com>
References: <20260710083913.30573-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd1364b-0ae3-406a-e77e-08dede5edca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kgGNnH4Jw+rkO2nGOz0jk+BLHIIm84BfuJEWyNibVlcXFJajS2NgAJA8ru/Ls3iegjQK8rQrnfMk4P7/GKqrbR5sTxsTjJugyxD5+bTqwaNnObvb2vEugGBntqSCrfQATm3MtU3Dm7ei3PwDy+ThP2cFvWcJ0hAt+s7ymcjlT/EBBKMCoJga1HcU6Lo6GGLy0ycOWpb8zcreo+OdVtv7wMGtnmpQ5KiyMbzHySMveiBQ/CNh6dheHNon6lvOF2TbUko9ZPwathZq6lJu6iRUecgxi2UyuteVM6IiHGCS8NQuDIr0JxEDsNbjncKc/GXbtlQJ9sz9hLLRR+rk7ZbKKKM+5tcDK3tSL1+NSQoqVRzbQioX5dcgtayrCXbn+hKg+VsZF0eT0fXv7YXgjmJrlVkdWWh/+wfmri8Xsnc7TKVIoCK5RxaGDj4YwKOqB9N7J9RUVrHlOo0hqSRydUv/bFUA+5U75lWKNWYuYOLFfYX/cY0VG94n+Muo75840+8RPPB0IBTHaUjM02S6V75mIVu37btvtGunhdMXss2MRW/x7PfQZFtLn44GfCdzrRgbMKhcy0PNX4e7kVUuN4L4HnHoCEC++CqTbwJqkmRQnfHrsdmvvBshl6qTy82EwEnvJ1hw9Xx4YoJWUKp2lcNLYLwE9iOHglwuCcQn2OTen3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pgUBc8/xV9qLfqEupVM3Vfmn0R0ks3roXg5lv0lsbwsUJDbfr21vZc3Ly/kS?=
 =?us-ascii?Q?axzIqxxI+hnCf7UHOSi4i0j5iGCpaRpVoUAwtH0ezshfC3g1RJEP0MZyB5/N?=
 =?us-ascii?Q?N4Wdprr1a1t8BgT8ytPiVsifqScPTiPDgL6KRbMhMS3yhZ7fH5n2hghkr4Ux?=
 =?us-ascii?Q?ZzhCr8z8CSMphJz1kuDyoA9RymJD+ERbExUQ86k6UsnJ1C/Nhgl/jj/XbXv4?=
 =?us-ascii?Q?U/b0Nu6E4clQp5pOzSDd5VBKwOlPEv2Z7FSAmrh1GSQ205pDqgNuuQBHWp31?=
 =?us-ascii?Q?wu5k86BXUwANvgUlzO2F+su4SKv/tW9DXGoOW67HvGQUOxyiaSmZBRQ7CEDk?=
 =?us-ascii?Q?h5kHjpJ9MIDDURLGUWfLAqv9aJi6oSqTdEmwol4RvMcDoL0ksxJPUL2Utk9n?=
 =?us-ascii?Q?0XuZtCoRHvm9o/sPbGQ4jS+VHlClt44OOKr/mXKKiQhXkJGnaUx7jW9YNSSV?=
 =?us-ascii?Q?YBg7HjWudwlGeI/rrh0YKGNvts0nFdTmfE/fqLKgK7EHhMh7gvjxqqCB/xuU?=
 =?us-ascii?Q?A1qK4Uk5N8ZdJ94j96XNsmoSDpkP0CZij9cWZER2vLPiFn4auEPYcsNXEb6I?=
 =?us-ascii?Q?wKlejzGTUz7vo5iI2v2lQea8/5Twf3TlWsl3R9Tdnx3CvqiymPBD8t/QKoQ3?=
 =?us-ascii?Q?UEB3b2EKdWHWZnprveDlbofyUyErcN4BVcV3SCOJA5wppp8Xl2hPvTGfX/F8?=
 =?us-ascii?Q?+mm7IYO7PNAJzU+7pR2QoixmM/uGwrO02G56ygW8RLgvAo9HEkTQZaLVLa+o?=
 =?us-ascii?Q?5VFqYkpNG4vnrRuQrsrY+Ah/sGBItDtnr8VarldmDEKm54rgM54Zz0ZhwkDH?=
 =?us-ascii?Q?xKKloHZDAgnHu8l5y34Utd8J6F1+hrjJSX8VHi4Vzm13jkIbzSVT57MVzaPc?=
 =?us-ascii?Q?WrSLGbEso+55rGWHvFoN9sNST+tXaCQ4R+RyY/Q6PzD1yIZj9dYVvkexYGDf?=
 =?us-ascii?Q?XpEBjf0BHn2A3IoHUdyd/+AxAS68M7V/4fGM2Pc8Q7AZG/Sgm9i4OR46ehpT?=
 =?us-ascii?Q?spLNrOavM3LC//Z/agUdKiZAfC41C0HOM1+k70GX37lUB6WTGi/x6WDinhEn?=
 =?us-ascii?Q?Kvedt+Sox2YcC2To2tbAXrEaa8sAmbtxo6OoYj5yXVtIkfYqd77d9fndCPNy?=
 =?us-ascii?Q?j2fvNjShqY4Calz1rJTSdhdqgd4xd1Y7NgSz/vSNv9WyJR8u7aJS+usPOpLw?=
 =?us-ascii?Q?owpgTfNAh0fVcR3zOh9z0mTthXxyxAqSKUXNyQyl2kC4ekqwt/7+yebNZQVO?=
 =?us-ascii?Q?sioqliSRlzsr8vVHgyDX161HQvsL/fv4wpY+Vcok4j7lQl5ocXQsGiHzEwqX?=
 =?us-ascii?Q?EacqPrHQgci4B/ol56+bU88hh+HwGtu92BKyyLi5YCmBG1UZd5ozTnXZRVUK?=
 =?us-ascii?Q?8iDl7KFpePs05YzX3QZ4PcJGgHCky5KCNjM66ePlawgmwwlc/nNiUcmEm/8+?=
 =?us-ascii?Q?W7qxTFCXE0TJi7XM09TT5RrnlJKCLzDeBT4M7jxGt4LJShYZ3OvZCT3rbHGP?=
 =?us-ascii?Q?O+UzwknZqreodhrP5Z4KimUrhF1h1uTs11J5LP5j/eBa83M/zCrgBwwKb05d?=
 =?us-ascii?Q?rMcZAmpGPhWRIvfEXcLQKn3ZH9sva6wdzgPtes70UEJMdTOF0HViZS/DjEF4?=
 =?us-ascii?Q?93Z5jrVSPGwJWYRveZJ6NFUulVGTiED+pKcCtetmX2uSnIGaIUONyr0sQasF?=
 =?us-ascii?Q?HkKZ9bMDF2/JP80wyDXG0Zvfi6LXURVFDv/SSB5GcfMexhpTdN4MRnjEDUQT?=
 =?us-ascii?Q?b5qi56iuwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd1364b-0ae3-406a-e77e-08dede5edca2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:40:14.6065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIzUqHE0r0YFOlyCr77FiiUQi1+JI+a3TGocNTVw92FAnj7ZMwLdLUunM4lyPcbTHdtue5i8pAL9fELJl1wg7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

BPF schedulers admitting blocked proxy donors may want to know the CPU
or cid where the mutex owner will execute.

Introduce scx_bpf_task_proxy_cpu() and scx_bpf_task_proxy_cid() to
return the CPU or cid of the next mutex owner in the proxy chain.

The owner relationship may change immediately after the query, so expose
the result only as a scheduling hint. Return a negative errno when no
valid proxy destination or cid mapping is available.

Provide compatibility wrappers that return -EOPNOTSUPP when the kfuncs
are unavailable.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c                      | 28 ++++++++++++++++
 kernel/sched/ext/ext.c                   | 42 ++++++++++++++++++++++++
 kernel/sched/ext/internal.h              |  6 ++--
 kernel/sched/sched.h                     |  2 ++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 tools/sched_ext/include/scx/compat.bpf.h | 18 ++++++++++
 6 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d72f64ffe627..39e2689ea6c3b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7046,6 +7046,34 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	return NULL;
 }
 
+int task_proxy_cpu(struct task_struct *p)
+{
+	struct task_struct *owner;
+	struct mutex *mutex;
+
+	if (!sched_proxy_exec() || !READ_ONCE(p->is_blocked))
+		return -ENOENT;
+
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+
+	mutex = __get_task_blocked_on(p);
+	if (!mutex)
+		return -ENOENT;
+
+	/*
+	 * @blocked_lock stabilizes @blocked_on and thus the mutex lifetime.
+	 * The owner is an atomic snapshot used only as a scheduling hint and
+	 * may change as soon as this function returns, so wait_lock is not
+	 * needed here.
+	 */
+	owner = __mutex_owner(mutex);
+	if (!owner)
+		return -ENOENT;
+	if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed)
+		return -ENOENT;
+
+	return task_cpu(owner);
+}
 #else /* SCHED_PROXY_EXEC */
 static struct task_struct *
 find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 60154b25ce975..5d755d586e1cc 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9432,6 +9432,45 @@ __bpf_kfunc bool scx_bpf_task_running(const struct task_struct *p)
 	return task_rq(p)->curr == p;
 }
 
+/**
+ * scx_bpf_task_proxy_cpu - Return the next proxy execution CPU
+ * @p: task of interest
+ *
+ * Return the CPU of the mutex owner toward which @p's scheduling context
+ * would next be migrated for proxy execution. The owner relationship can
+ * change after this function returns, so the result is only a scheduling
+ * hint and the returned CPU may not be an allowed BPF dispatch destination
+ * for @p. Returns a negative errno if no valid proxy destination is available.
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
@@ -9735,6 +9774,8 @@ BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_proxy_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_proxy_cid, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
@@ -9770,6 +9811,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
  */
 BTF_KFUNCS_START(scx_kfunc_ids_cpu_only)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_task_proxy_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_cpu_node, KF_IMPLICIT_ARGS)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 8ac195934f63b..df7420b816a04 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -214,8 +214,10 @@ enum scx_ops_flags {
 
 	/*
 	 * If set, mutex-blocked tasks remain runnable as proxy donors and are
-	 * passed to ops.enqueue() with %SCX_ENQ_BLOCKED. The BPF scheduler controls
-	 * when donors are dispatched and whether they should preempt other work.
+	 * passed to ops.enqueue() with %SCX_ENQ_BLOCKED. The BPF scheduler can
+	 * query the next mutex owner's CPU or cid with scx_bpf_task_proxy_cpu()
+	 * or scx_bpf_task_proxy_cid(). It controls when donors are dispatched and
+	 * whether they should preempt work on the owner's CPU.
 	 *
 	 * If clear, mutex-blocked tasks are removed from the runqueue normally
 	 * and cannot donate their scheduling context through proxy execution.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index dfa0cb722c00c..8e55c922e16ca 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2472,8 +2472,10 @@ static inline bool task_is_blocked(struct task_struct *p)
 }
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
+int task_proxy_cpu(struct task_struct *p);
 void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
 #else
+static inline int task_proxy_cpu(struct task_struct *p) { return -EOPNOTSUPP; }
 static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
 #endif
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index e7b3ba491c5e8..98a69be2dd502 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -95,6 +95,8 @@ s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
+s32 scx_bpf_task_proxy_cpu(struct task_struct *p) __ksym __weak;
+s32 scx_bpf_task_proxy_cid(struct task_struct *p) __ksym __weak;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 133058578668d..d25996163206a 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -133,6 +133,24 @@ static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__s
 		return scx_bpf_cid_override___compat(cpu_to_cid, cpu_to_cid__sz);
 }
 
+/*
+ * v7.3: scx_bpf_task_proxy_cpu() and scx_bpf_task_proxy_cid() for querying
+ * the next proxy execution destination. Return -EOPNOTSUPP if unavailable.
+ */
+static inline s32 __COMPAT_scx_bpf_task_proxy_cpu(struct task_struct *p)
+{
+	if (bpf_ksym_exists(scx_bpf_task_proxy_cpu))
+		return scx_bpf_task_proxy_cpu(p);
+	return -EOPNOTSUPP;
+}
+
+static inline s32 __COMPAT_scx_bpf_task_proxy_cid(struct task_struct *p)
+{
+	if (bpf_ksym_exists(scx_bpf_task_proxy_cid))
+		return scx_bpf_task_proxy_cid(p);
+	return -EOPNOTSUPP;
+}
+
 /**
  * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
  * in a compatible way. We will preserve this __COMPAT helper until v6.16.
-- 
2.55.0

