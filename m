Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC53F0AA9
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098982; cv=fail; b=jqbJ1l1nmAJEDczP21EFXfx423IJmg5weADmB9TuetOADSRa3J+ksj+ZIXpD0YnqlPy3ei7dHj22gzBSQn2bdtYcQ3EvufX31AuRDObjqH80grwArxCy6LW7Yr2IgQsApkKLvVEZSIfUgWMOkz/xMzCwftkv6iOSzO9GzSSiwKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098982; c=relaxed/simple;
	bh=ZaRae7w33zW/fwANWaHye2KzeQT4p74i0hpXAfZkfTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hc/sR6bhFEPkw84bYs49PZf5X+j8priaa3Vw8jCspU7MeY1ie1asYDdaUL24kQvqxLvZ0jjah84v20nRvXvcohAPv8Ic9i7wf6ifrrdUtvx8/fgIumvFBk/4CpKfXzuR1cAJ/vnDFLihL84E4Rj9+X1jsm7CIaM/mkCuArFele4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=md9GvGZf; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="md9GvGZf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbFHFOY9FqifS1bFVAFO+QDlTrhY8Qs+ko4oFDwm+/DV2+aeO/84FHu55htTjKKy7g1LVqqIAx40NcpaVZDr20+npKqnlHD182ykcMv8C6Z4StNBqQ4BFGSt0+Z+jzRaD0BfnM7lntpr/sGe+HMkII/OAjyAhG0xsO6D3lO04Pq7SzqftW4DxAnPT7BxOyXhC0RjdXjT/GbXvXaxAL2tgCt2sNzWJLwmctDU7wcyNUvSs6LlUC6wBxJUtBClR+a/6VLV5IbFT8CfzpQiu9CmwU1VPhQKQSbEsVDZ957OsHzCfvKP/9IxMzKrTr6P9ay5bSYmqZP3GmwXLZCK0o7FKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swJBExAbenl1TjOZ2dGCJcLMZNi9i4KYo7b0snbI1YI=;
 b=B6mQR9bJnYeo4bCb6dBO9NjYYAF9ThXkwC2n2YtfFDOYwZ9y7jSFpnS8A39xVXHZ8YUTtx6eMqXk+qlErBR8Ycmz7wVbzQUdw8VQjE9DAEi9OjRlW9nnW5n/kq8z1qkt073S7xjyFgYeVz7MPZCsfpOL5Jgs9qVpbW65xzvoFUiLkjDv3r3PaWqauevSbwFSd00TmYGowwduOk1eBtBHGOagCEPdHsbQY22HxuKKOq6gzkjqt5k30iFWhg9OJ7jmSioVDdkcAss7K7+/QvqboSJ5b4tFmvd/xm9+N6VxoPc1HXMGCwCpukTwMNDVlwykXG7BbadviLsD/Mvpn0PttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swJBExAbenl1TjOZ2dGCJcLMZNi9i4KYo7b0snbI1YI=;
 b=md9GvGZfb6xi6c9R0dI/GxNyD+4m1VszMa9r/lzX8Sy+lN/6DD9R9H+5KPDTR+CQ+jmLUkF/Ncw4UWdKFRJOnmV1SLMEuKEZUkimhIUbV9c7XSIm6H2RECNjWa4OrQthD4BAb1phoMfrPH5vUUyT1a4YR8GKEOkWjLc+GoHguuTbdCuE45dsmXd8uTqhP9RlB5i4mACoXKWjxEWSNHx4JrpFQ2VaORFFSMxg8F1/80cRqf8RDC2jOlpPoGvYmmFNhbnuXZxoUS+/yEhXqJUOSH7rU3Lz+lyyNY1Les8P5lgvPz94sVqCbQ85VTkVzgmTeqcCSWflOMHMxnMKiiwqww==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 07:29:25 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 07:29:25 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
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
	Vladimir Vdovin <deliran@verdict.gg>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] sched_ext: Add scx_bpf_task_numa_nid()
Date: Sun,  4 Oct 2026 09:27:10 +0200
Message-ID: <20261004072901.3579967-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004072901.3579967-1-arighi@nvidia.com>
References: <20261004072901.3579967-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0379.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::11) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbf4f20-9763-4529-52b7-08df21e937b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|10067099003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	T/VlXTBI0GGBaqblW15Mh/tFxaX8r5XOk5csnwKRV4qEsmiJdKhsEK081YXWVD1g6LF5tTsNAeSuXN7ZnJzJHKZPrST/XCjFl1Rk7XZbu7RuSLnaAGZsyjAD6x44IY5SE3Fu74oiHnea8G86FazuAP4SG05APYeaRSye4VdHYzC/4Cob0eDe9AZqnh8cD5fBbKB7Pm6R0o80zByJ5bdeSDMkwPl4dnH+/kv8b4IpndYDMSpjB+NvBaH41blidV94OEhwgur5BMQTfKDYp37LYWVA0tGBCKs1cT0pypwOouJffRoWO3l7MRZacHygT+o6noqGNwtYEveHGuWMmfFQK66FMnQ/G/+zNKnt4thM1Tgqq31d5Q5M+0P+icSRDKfe55xFC7MCQw5+slnUB6f8gQeFYtM2G/PBHctjWmqdVga7P4CXsbR7zJA6kul9S8OmPxrezt3oreld6o7q9lIjOv9tDM3ny7eOAp0WG0ZwEUjUvid7JWrRwja8HMnKvRELrem1+uoNIfTecvmJyqL2Bxv0jNN6SwTbn6DT+oMQiq4WyND/WH61gUfV2yGqcahatEQm7nIrTrhaXNCagbMmV0u4P9apofoGNNJull8g01oAVll0tVcI+o81oYpu+EKlu9Liot1KxSdj7DjOKhKv41UXbvLnb5AhI7po37iKcps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sF8HlkpKv77jeGNi46owhqQ/WcCO9PSXHbAN5bSLiE42fE8Lpp/9dZ7s/x03?=
 =?us-ascii?Q?6/oINm9eAjuCOeMRYEyTk71wgKUzXHuFaeNkWbE/4Oui0LisunDBnUw3doLB?=
 =?us-ascii?Q?qPZqdyFyZ/ZoP5N5qUb5fJsa26mbZidgFpqp7mfth1jxcJH49y0xorLno8/2?=
 =?us-ascii?Q?XMHIxz0ZYvi9O6qnBV1xeevDI9Rbt6QdZzAt3ypv9r+FTTI6n/7N2bu4FRy+?=
 =?us-ascii?Q?oXu5US9E1SWp/8acWGp/6y2hJH1AGwM59qlQsgelWH5Pql5YF6URUYnzCAC0?=
 =?us-ascii?Q?Ic4pHerCaB3gy4QluZTXSWWw7/wN7zDdjoraO5y+9PYh3tXSQFBB67luQYAW?=
 =?us-ascii?Q?ZHTF+6Blv+U+zVer4wUqjLgLbdycBMZiAZT5DZyjaLToRnrHc9pu+hHIFWv/?=
 =?us-ascii?Q?hvg6w9AORAC/xdIYDFb2omiYoYLwM60YfJro6E+gEE7H6ZB0wGUb/Fsd/3ia?=
 =?us-ascii?Q?QeKksweoNGI6S2oOuSrZmQVUsnfRG3S45gSDZa9ZoDafEGdsOV613InZ5yzS?=
 =?us-ascii?Q?TklmjS3IB+kRnIq3RYaXAio2gxBWGihPZKlStY6eB2zqOVWDjqexyUYXhFB8?=
 =?us-ascii?Q?qNuHyE/cHEE9Rt+RJnnesiilJSTgjY0+Z6Swu3lwFyEr4vsanS9f3d9luJ0X?=
 =?us-ascii?Q?daI1xXDL/oghQDSoJB90VeegZpUaYLP4IDGnLt3zkJqS5fIHwa4DkeyXYIgF?=
 =?us-ascii?Q?+pskrjT8pfF7CUbfB3qZP3IJ1eaaSX1/HAh31IzMP3agqKjs8Bq9rQgCmQGn?=
 =?us-ascii?Q?PtcNYncfgIUnReu7MhMbZWEIL+cjV7V67kKX3rc14UmAjNICQO7zdRW8DJKA?=
 =?us-ascii?Q?eVZYjJYoLDENKUg2Aqt+58RRBSUCUF7jzstHIJCiIevNORoSqT7fsBpE8yF5?=
 =?us-ascii?Q?/okxNCGe98AIy01Q0DV+hZKKB5XHqLA+e43cjKsmjZS93HRkGzu0n3ozm09m?=
 =?us-ascii?Q?1TRvVpUaUoJ3GcIheonUzVXJhPvYYC/lO/qaOLzPaL/HN9mkgwbcd92TWSMW?=
 =?us-ascii?Q?PWo/zH6Yf4EodfFOtLttr10EcJZmpsVkwfBT+2uWlw7sF9Xd6xzXA1XgmEh1?=
 =?us-ascii?Q?Pu2xZzoThebRsZ7ynxn+cn+MzCxA9VqaLBRdNOn2aKT9vCmDFILr/XAAGVPP?=
 =?us-ascii?Q?Qo57feqHx1rPNPpslA5NB6AOdTAsmet7gDuLGO+GZTGg97vbpiPTekVM7YoR?=
 =?us-ascii?Q?qRAP14A7uowZavZg79V6165k5kxX2i1N9AHyPGp2wkFUfQxZn9Vpry72f+g2?=
 =?us-ascii?Q?1cJMWfxWdw0Z3CvqCE76PxQcq+R6qiBm8MrEFj2hN023mzjXiZ/xoR9I5KdY?=
 =?us-ascii?Q?qK5phY4mAlJWj6O1n2Vso9pI7MODO4RnRWLP7RE+lP//tMary/2ND0MODCEo?=
 =?us-ascii?Q?cvNUYvRtTkm66SHTqgQBoHIPJeib6l22U3NiTZ2c3OAVHtkb1PYuWnDSUmwZ?=
 =?us-ascii?Q?cZc+RB2LJANqxnNvZFmKs91BG6P036r7BzlL3FYNJw/1gH903guLmyECpl+Y?=
 =?us-ascii?Q?s2fmwlxOIgUSXOcSPnn5vTilhRBGdD5/SmfKPVsPhb5JU7GttbobW6GeEPNk?=
 =?us-ascii?Q?7xNgcvRFMibkXOmDZd0dCm4Iehm2MuGV/H6DlG8+C2P7BZgjx0zFUyeFCakL?=
 =?us-ascii?Q?m82gE5hxx4zaFDvKMScdikScV+cDZCS5h/hwdsKk3Wgc40EUepRKJVmCjQ8h?=
 =?us-ascii?Q?6iJuHtm6pmLL+WJKQgJCSnotZv1zBRFm4PUle4PTjqFhhEpOX+uYiNfA/sru?=
 =?us-ascii?Q?j1/S98Qo/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbf4f20-9763-4529-52b7-08df21e937b1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 07:29:25.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpuzfALTMybcQii8JlAKwb0cC456kygXV3iU1XNkoKFFhp4SjjHUN541wFbUAIftuouqUjDiFsciXW4r3m84Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

With the hinting-fault scan running for tasks under a BPF scheduler,
p->numa_preferred_nid is maintained for them. Give schedulers a way to
read it.

scx_bpf_task_numa_nid() returns the node a task's memory accesses are
concentrated on, or NUMA_NO_NODE when the task has no preference. A BPF
scheduler can use it to keep a task near its memory when placing or
balancing it.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c                   | 26 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/compat.bpf.h | 10 +++++++++
 2 files changed, 36 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b22db5ccb91ab..21caafd2cfe0c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -11140,6 +11140,31 @@ __bpf_kfunc s32 scx_bpf_task_cid(const struct task_struct *p)
 	return tbl[task_cpu(p)];
 }
 
+/**
+ * scx_bpf_task_numa_nid - Node NUMA balancing would prefer a task to run on
+ * @p: task of interest
+ *
+ * Return p->numa_preferred_nid: the node NUMA balancing has derived from @p's
+ * hinting faults as the best one to run @p on, which is the node with the most
+ * faults, adjusted for CPU-less nodes and for the NUMA group @p may be part of.
+ * Return NUMA_NO_NODE when @p has no preference yet. A task has none until its
+ * address space has been scanned a few times and every task has none with
+ * kernel.numa_balancing disabled.
+ *
+ * The value is a hint, not an instruction: nothing in the kernel moves a task
+ * under a BPF scheduler to this node and the scheduler is free to weigh it
+ * against its own placement rules. The value is updated under @p's rq lock,
+ * which this kfunc doesn't take, so it is a snapshot.
+ */
+__bpf_kfunc s32 scx_bpf_task_numa_nid(const struct task_struct *p)
+{
+#ifdef CONFIG_NUMA_BALANCING
+	return READ_ONCE(p->numa_preferred_nid);
+#else
+	return NUMA_NO_NODE;
+#endif
+}
+
 /**
  * scx_bpf_locked_rq - Return the rq currently locked by SCX
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
@@ -11446,6 +11471,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_numa_nid, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_cid_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index c26024a6e2b1b..64c2855d37875 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -478,6 +478,16 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 		p->scx.dsq_vtime = vtime;
 }
 
+/* v7.4: Add scx_bpf_task_numa_nid(). */
+s32 scx_bpf_task_numa_nid___new(const struct task_struct *p) __ksym __weak;
+
+static inline s32 scx_bpf_task_numa_nid(const struct task_struct *p)
+{
+	if (bpf_ksym_exists(scx_bpf_task_numa_nid___new))
+		return scx_bpf_task_numa_nid___new(p);
+	return NUMA_NO_NODE;
+}
+
 /* v7.4: Add scx_bpf_task_set_lazy_resched(). */
 bool scx_bpf_task_set_lazy_resched___new(struct task_struct *p, bool lazy) __ksym __weak;
 
-- 
2.55.0

