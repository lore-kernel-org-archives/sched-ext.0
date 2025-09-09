Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485F225415
	for <sched-ext@lists.linux.dev>; Tue,  9 Sep 2025 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447843; cv=fail; b=TqWfsY67Rw/q2Bimr6UGaTwki8yhuAABmY0owtdYf002Ii+5/GHi0QrM71r+rvevwPNVHlPfAuVumSUmsrqQXyWpJoP6yf0MzW3QUhyXmuqyLNEtp2sWmJf3vHwv8TfJOaHr4H8q2p072mGq2IN8Xw1L16cYVr+F++3oNASUBAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447843; c=relaxed/simple;
	bh=Iu9eqHc1gEQIXYOtnmwXen5HcBS6UwnjzB255KBgX+0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bEpRSAFo1ahsil9ImspuvbqZvJ1vjeICLDxm6N18KUgx2jTm42lH0hL/+o3fDfqn2ddXKkPkDZaCW7LNwvDeh5eN13PHC6R93BVTANUEZtOOjz/LRsNYUUz4qSp7+2bOU//5LHDh7MKfIGEKUW1GAe3vI6Z+Hw0PYrJ2o5WAI9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bTbjJZks; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bTbjJZks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhaQ1pqiGuXxZGeUMMU1p5QB3yeeS43xTtW4I+2acWHXyd7vFQSnPdai88uwTN3WrNOuWuE2PJd3iWMkOpGr9VABtnfZOWU/1s0Q8huVMEuAIQv9vYC45/l4DGkIIpQiG5gNCymhQTUxI2r3snB1UsAUeMrbaD5yE61KHCkyqgrhCBcsIUjlcITA/Jd5Ot8qGCrDiHkTEmstR4b+RDHFCDzfHCUlMpMHTbY//4jSpCyZkCDY81k5iNds5v7B6366QMlEiFfQQk+2fR8NLYJ4UFPdUwLHnI6ZxXt/yX+X2iuZ3L2FnbRxkFPx7cGGzfSzRkIGZGXW/XErH06H7bN79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCu/zuPDSDjb+c7HuasKHfsvQuy5zMzacqTgp1WvYxU=;
 b=BJLpbtNXSdkVI9Kfia6b8Cb+NzSzTbISE1fvFLSzU38sBw0iHw7OWQKfnx5o8v/SziYbzkDdE26G6I3uuWBxR9POf3xNLs+2JvxuZb+Wlx2SEI5ST0hjCLuxiJrVk6BxA5oT9Fg/vgq3Ay3Hjj7TPt3FrjlkTjWXqNnPjmCMwxn9iHyJD3ZWGtpjAJssTFmqDhWkG6fkc2zB2LqCM19OE1Pa5x+vNCoWdq8tKcJY2CiX2bODrVpjazsFe2MU+qecDK8m9KPYT+oYtPEf/2ZBbVkHN7dhMsJ+0Bh3dZtyQOt3gnUj9/Qer8xGwJKOxLatd7HTm2hrLpcrkKpmFfnAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCu/zuPDSDjb+c7HuasKHfsvQuy5zMzacqTgp1WvYxU=;
 b=bTbjJZksVVbvP9Pam+Szquly/VjKQDgLH9mcf5dkqM94BfvPVwPl/PoKl2V3GsU0eKHt8tN0lry9Btto3E4q9471cSoaZBJ2uIvjpdq+GpEtoWysIL3+URLJPU0DVMla0uRfTEVUjyooAAAHWoV9hlSWkGk6HWGOpWnDkGh5ev86BBcuXAO9q1ldhCd5B5Y8ATnLyp867qQPwGZQRr3e3d2kC9ytJmfWLuihxKF1WfPmxyskOMgD0o4oCWwpqWkVHyFEhYFdER1FBA5lJOaUq3UnoUuRhOc8qRgx3/EzUhPidJHVSNJnpTBEuO+MEbtnumKH4rJ/GI/hr89PAELgMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 19:57:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 19:57:17 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.18] sched_ext: Acquire task reference in scx_bpf_cpu_curr()
Date: Tue,  9 Sep 2025 21:57:09 +0200
Message-ID: <20250909195709.92669-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 860f0b57-09b7-4a91-a03f-08ddefdb1420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kSeT4TEndbzBPz2KlB+We8dhHY8wZg3dhfW+cv6RBU/KBeScSeSJ2O/albTX?=
 =?us-ascii?Q?PXx4t78an5/+tdFXJ6lerY6oqhQjXVKxAfZgjhg3sAi/CQtNXAIPdk1KjIlE?=
 =?us-ascii?Q?3zjKErDoBWsB4qXUxbNSGkwlpezWUxZeIEI4bsbRIrCd3bpPN3NLKJ6Lmsk+?=
 =?us-ascii?Q?iAtInCMgutXLt/y5n41Lfl5pcYMItoYz2+C4GYHUGAcu/QuixYAj4JqY8hE6?=
 =?us-ascii?Q?kSkloq2TBj6QSOBajLNEQFZDNliBzgic4FPV9nfNxTJxVO9SZoIAek1Y5oEr?=
 =?us-ascii?Q?HW5/viX1m6HR+EKv3RzKhzF2GC1W+UFZiDib52bq5nuwK6Kqj4Vz5SUI2cK5?=
 =?us-ascii?Q?LxTMraT5G4auswI/BJJxTZ/01S9hgnDuvIrTfiRxsrU5JxFvlmUGztHaY18+?=
 =?us-ascii?Q?jiWMbwUVviEhRWA+0nMDHvntKb7iWemdjMAtm5nY038AKGw+FtwcwSDKXw74?=
 =?us-ascii?Q?3KpV42+bZp0GzcskziOg5qBg44+e/vFyKLTyYiZTSeYuTp5jmNMZuWjQTYf9?=
 =?us-ascii?Q?h9aCv8T6d0+XQ4sj1jra5+vFeBlJTAdi1FlHzZzsN7Sedf/e/brAE9JTZQkN?=
 =?us-ascii?Q?Z5JByzrJYGKNQVAL8kY8UHkLypSeS4/7OYqH1YqF4A7IqcHM5cHTHtEggBml?=
 =?us-ascii?Q?XydfohfHUIPtNmtrV4E9RNstWEqkfS2qhUD1nDLr1m4Woda/qKzw9D1A/eJM?=
 =?us-ascii?Q?RCJ2uDvebW+L/MDEPGbzOwCBLZ8OwFhfGa+SNjQ1WYbOQtmZ7dNyzeXwtp2o?=
 =?us-ascii?Q?GxJntYfpfdhDIpUFZLM4SkmeWPOF/573fIvF46SQqoyWzju55D8e4OkezSd2?=
 =?us-ascii?Q?futFCNnTJr73QhKR7dlEL+jXDrlF8th69OVVZypb73xVc00NeQfTDBEnwrtl?=
 =?us-ascii?Q?u236fs3B189cB+hK7lwr1sVl2Unt4r2Ipb6g5sqjxWCYm6ObJAsLzWeYEuUB?=
 =?us-ascii?Q?tg+EHdOsd0ylr4OWLDOSkwYN1EW9iazSUksdCw2g8mCK16/W8tKk8VI9D3FI?=
 =?us-ascii?Q?r7IJ0C0ICl2vM+V23b4/fheg2XRIXrdQV4YZ1jN+M8EZMjCLzbH++ZoWJXBt?=
 =?us-ascii?Q?CITWa8W/TtiE/yz2QbRQYw0x0aQkZxhRIgduIRxaB+qCWU2eRwnxz5prcH/3?=
 =?us-ascii?Q?uC3YpyYDMZvQJhTn+3K+rsNuuIYts0SegyPONnQYIDO3/uiMhkPP0vz8Gg2Q?=
 =?us-ascii?Q?bMIXGjvq9wRT7fVgVBEaS2wtFmkpBfPu+xbokjiLY+ThX5zXm8JyJjHM1Zfj?=
 =?us-ascii?Q?Fq1LCK0dbYvlZFK3RJSROs4XRO/FtrDqSi128JEnEwlIA8fc7asN+tk+fdry?=
 =?us-ascii?Q?ZxDwIfUIqoprtsP9A+A8gmmIm5+icDI9L6SAoWgBMJEdl3ckAAa9WXbCOjnL?=
 =?us-ascii?Q?DZp5uPZIoayWYJmYeunqhWNsp5s58s/Voq9XTWYle0yMSCyqAiy2JuhSN7gi?=
 =?us-ascii?Q?KuhY02NUxsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/V/Vxd+GeFMMSbRTOWzPmRsLNlM7JjywufNo4J9tt86MJDtPrY+tF9TMrEb?=
 =?us-ascii?Q?XIK2kEGNkHl5QqPoHKHQ6y72uZ5gttHBx7vq3vewrGklnWK0REWN4MF9MGSn?=
 =?us-ascii?Q?74n5GjNJMJjgfi0a3WgvkaMKG3sTCFfPIVC2wTe2B8xJ5JILJVUIOVdYlEtN?=
 =?us-ascii?Q?9ilffJ4HsXY0lVsF92wyIlUlPgQ3IbSVZRfFl06oyFYVIBaJll0JVOKwtfzM?=
 =?us-ascii?Q?vT2D7B3HIaHvdOCAUyMG8NXwRPB3u28ykPVOd5oXH/JH/QG5uBfGgXA622pt?=
 =?us-ascii?Q?YF5oICcf0G8Zbkirqk1Ofa5AeaFx8I2mpufNhrxwVBKikm7oVy1mWIaGUHSV?=
 =?us-ascii?Q?BgAjJdMgpCaMA31tmPlHg8xgtoQVRudKSlhFlV21GqPW79Tp2qbhMrZqm7FN?=
 =?us-ascii?Q?HUNuZxkujRGGPYjKLTUjoJvRrsCzvVtgtaV2srSnGVv6mRap8jx8HXaGErXw?=
 =?us-ascii?Q?iR9i4fL0S+lnMhl0myLqIvYmHN1prMKatJAkaxJBfXpYhsSQGvS6/quFzILN?=
 =?us-ascii?Q?kbxR0s8/f3ltQ79TtP0Km8CoJ0LTyJKsOOKnDMV+zRxsjoheZH/NUMepYBHo?=
 =?us-ascii?Q?3RkMuK/bkkc2uzUIUvW+qlFpy29z5R2SrDaw/1txefRb026A1QRosMY+/sC2?=
 =?us-ascii?Q?rXudE/T20vgtYcWrU9p9zCtz21wynsVmXd3wFZED0x+8akmwhRl5lHxiX6Km?=
 =?us-ascii?Q?rFwEjMgtM8jwiqXv7mQXUYoqi+C5GvSJbS71JsuWUd9B7dHEzzw3Z9l4bF5N?=
 =?us-ascii?Q?BKX5YzSCUziaHs1c1WaXzh64H9jZMPe3OY9rSeN4b9I1e+hFJQHrvTsR+XPq?=
 =?us-ascii?Q?URkqrEgXFcTG8pcKa+QkJPertgOpvOonfHJAJ6R3vv7w6y45oQtG6oX4+m79?=
 =?us-ascii?Q?CZPegnIUQcBz35jbaNO0FeN4DkAKJClAdZke94QJpR+S0lhR0qi9mMtt1ojC?=
 =?us-ascii?Q?4/9jnT3n7+A12/P39n431CVnLv2FoXVgPlMQWp7gkzK7HT0yIv5G2EUy4fI8?=
 =?us-ascii?Q?aAN1jk+tumgHAg38cN5bDFPkggz2RdW37A3TcOzQq1oQ3UNSznGL+SgjBG3r?=
 =?us-ascii?Q?AtdwVw59UwDL84pgi2lfM4J7o9e1QCNeMeCb18ZHEw6vZP5kYobkT5k5SOdZ?=
 =?us-ascii?Q?Qpg7ROPmsVgKn4sPKHWMusljMc0IuLq71HN7wDttRtqQGotb+ipAZtr7w750?=
 =?us-ascii?Q?GXYIZH91JnUzxpheCODJzSMoNaFHsTsUTf6ltkc9wRyYUdulwc8YzwZcD9jk?=
 =?us-ascii?Q?7RY4/WZlZO9xCXrTYkJwE1NQ2PBKSbplSImJD/YmLHDHcDp2NX1dmr7Bfn7K?=
 =?us-ascii?Q?oiv/ih24Vu3yAxsLFLSaCeTMYdokoa16yUZkbgf//raYxBI82jOuVC6Kcz1m?=
 =?us-ascii?Q?kv+RZ8O27GRGm7rtP4CblJhA0eFHYqWtRFmXYzXnJ0fjEvnl/GQO/g4CQHnm?=
 =?us-ascii?Q?5EnPmvN+6eDnqkAd17bL55eMfAV6nyMe+9mS1vfkxFVL1Tqs2qAcs44AwX9c?=
 =?us-ascii?Q?QmTGQEDHlNyQ4vk+eU3CPzYKwrh8L47YtL9MYLI+a4VNoFIgAhPIB9TMpmdu?=
 =?us-ascii?Q?+15ad4y0AJeno9nc8dIIXf/RdJMXlL2LvYUft4Xb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860f0b57-09b7-4a91-a03f-08ddefdb1420
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 19:57:17.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6qih7sP4BeCIAvK6RbtzvlRZw5UYTgfkJcbczWdyHxXjUBCXoOcccuyyWisS3lKrTM4xi8J+dhMFfb42nouAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

scx_bpf_cpu_curr() has been introduced to retrieve the current task of a
given runqueue, allowing schedulers to interact with that task.

The kfunc assumes that it is always called in an RCU context, but this
is not always guaranteed and some BPF schedulers can trigger the
following warning:

  WARNING: suspicious RCU usage
  sched_ext: BPF scheduler "cosmos_1.0.2_gd0e71ca_x86_64_unknown_linux_gnu_debug" enabled
  6.17.0-rc1 #1-NixOS Not tainted
  -----------------------------
  kernel/sched/ext.c:6415 suspicious rcu_dereference_check() usage!

The correct behavior is to acquire a reference to the returned task, so
the scheduler can safely access it and then release it with
bpf_task_release().

Update the kfunc and the corresponding compatibility helper to implement
reference acquisition and prevent potential RCU warnings.

Fixes: 20b158094a1ad ("sched_ext: Introduce scx_bpf_cpu_curr()")
Cc: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       | 19 +++++++++++++++----
 tools/sched_ext/include/scx/compat.bpf.h |  8 +++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 477eccf023388..760f49a9c846c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6392,16 +6392,27 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(void)
 }
 
 /**
- * scx_bpf_cpu_curr - Return remote CPU's curr task
+ * scx_bpf_cpu_curr - Acquire a reference and return the current task
+ * running on a target CPU
  * @cpu: CPU of interest
  *
- * Callers must hold RCU read lock (KF_RCU).
+ * A task acquired by this kfunc must be released by calling
+ * bpf_task_release().
  */
 __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu)
 {
+	struct task_struct *p;
+
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->curr);
+
+	rcu_read_lock();
+	p = rcu_dereference(cpu_rq(cpu)->curr);
+	if (p && !refcount_inc_not_zero(&p->rcu_users))
+		p = NULL;
+	rcu_read_unlock();
+
+	return p;
 }
 
 /**
@@ -6569,7 +6580,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_RET_NULL)
-BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_ACQUIRE)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index dd9144624dc99..551635746f25c 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -238,13 +238,19 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
 {
 	struct rq *rq;
+	struct task_struct *p;
 
 	if (bpf_ksym_exists(scx_bpf_cpu_curr))
 		return scx_bpf_cpu_curr(cpu);
 
+	bpf_rcu_read_lock();
 	rq = scx_bpf_cpu_rq(cpu);
+	p = rq ? rq->curr : NULL;
+	if (p)
+		p = bpf_task_from_pid(p->pid);
+	bpf_rcu_read_unlock();
 
-	return rq ? rq->curr : NULL;
+	return p;
 }
 
 /*
-- 
2.51.0

