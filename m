Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2842C0299
	for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480305; cv=fail; b=D94xNYIx+WlepCtgfxwj+w8o6tOsiiVHm5ZGX8mHKVtJrVUPZwR4cdMSQIkH+2KvkFR5S0QtslkJQyFTVJwXVZRf7OYVNd4sq9AG21CdCrXgffya/xXOMIIf3hK0B0XylTDjj7V9xBFKGP/Mz3sFm2aO2dd0O4lTUqrJ6ddCzKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480305; c=relaxed/simple;
	bh=94/YSD48Ah8+35FSRKoijSrr8pdmL4BxIf9uWEa9zuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AaIKbaY9tZNGUvHVYejgyYjKoavScuaDxSVzZIJBbkWKXTDIlKXt50P505v+USu2DiqPZJgpy08ks7eFZz2FsY2/JIfGn33CasRCSNABMk54cJ2B2gkUL34b4I88Epm0M9kq5+bLtOThQbjHhBByAGYABpvKP8eEev2OYNcCUMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ssGiLXsc; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssGiLXsc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w49qmj/80HMpJtSyFFEZTA+EJTENwh6tdNLi8Dc2/VvxgUFwqHkMxDksVYQO/PeVrABwgIEbTfV3yWqeWCwKP0ZsuIUirdQR4qRH457Co2omIlFLYUqMBTr4EPVioknnrb+mugwe2tw1zPIVyABcm2IZ8ngdsy2Vof9FCjbWxQI6w01Xol0ZRSJC4uUvSWZrXyJwfExXSx1zVbsnsRujG0aZLd6MexpLRCx0YiPBUdKgAMgsRQP8OxCoJuk3VL0yJFrDr+BKjv9Q2WxrQ8soyEujYwvfQjsixwvCot2m70Dn1EJmvGE0tP7MExSXnio9Vss3hN54FhniRQmlSTS1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6rUTZI+YnkozoJ/0vWZict0vKksZhd8sDjadN6wQSI=;
 b=qRCvL//t2EJkZDhetGaeF5/4n/sjtuYf2nQySKGVUuR4FNvhrLHaaT5zN9JaVIKoRzE5cWnLZhJRp+FB2XiyhCzUpV6afrvz8oxXPH8h8kxuOPHFs8kJzruGoLDxqmX/JzfftXz3gTJ92pP2FpFlakQ+TvvL6hKoQQFZoz5hli67ElT5mhX8WmurqWsJOCyjmzzDmX96lS6P7XxAeYYjAw0QHBKOcf1uzuuTNPIEUEtbzOT4rEN157dFz1WkBV31wvYDQXmYXJRa9BxzJafxC2bxGNN+QOPOkYnrlnyeDam/GArC+8hInEfQXbfUb3jYfm9B7u4mz5+iBYbw2VIqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6rUTZI+YnkozoJ/0vWZict0vKksZhd8sDjadN6wQSI=;
 b=ssGiLXscD9wVKvJi5B/y6XE60y/SLElXUFnPGKqI3S6LLT97rPcqoIlbCe9bdVHz+ubCZzkvA/i/JXt+4xRcYsGhYLwMvax8eEbc0tSU7JQnSQHpKfRy8AIcX5KkSaJSQAqaIXA0O0gzMWPBUYXkTgUrkzLWecdqCiZKV3JnE7mlFUzQOmlq/XuM5ajNc/ZDudIWvYjfVMOqlj5h0yhr/ErRJvEFQ6ftGOrMTGIwXEfcMOD0oi1LRRMWc1FGqMBs3CxmGJNlnnrkI7dHONdK7+FWTz6qVW30pOCcTktHro/Tw9BuPDtnwl4A9DKIMX+C4Byfejel3vw6cTtynlxMEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 06:18:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 06:18:16 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix ops->priv clobber on concurrent attach/detach
Date: Mon, 11 May 2026 08:18:12 +0200
Message-ID: <20260511061812.2459458-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: a78a2aa5-2c12-4543-f0be-08deaf251699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RSITlh/KhNfuwhjn2+BOoYJTvgljCVhvUxU6SbWV3Ybhld0Tt0iNgiL6Af0BtgvHj6PJIbf6/cAf4eriakEMdpCQmxkyACsDHeVc7O5e/YmnNDF1W8OVx4QOeZ+s+fecGPQb8bqKCBHEGI4lYGF/HvpIDmdFtGVLaDaZaA12Nc3EE6tTwL7s6/8/2MDWKHemonz27Sugiz0Z/l6r16j5T2E7qR+tH9LgddvCLrFl+2IWNMicgPfVNlxA7u6PFvpjSiFYJF9vVZ2hhKt9Yt6JadtlnsaXCoVcETpnKaMJw2Sd+yKWseMoqtqBc1uMte4On/LFxjzSgzDckUx5o/mf7Zti69UAVikF14OTCIVj+M1iQs1KFwPufMF7LKucicXrMOnczV5NMmKpD69/9CT2G3Ce3EniUwIuKPNvM+z/vM5LbzHBgtVOUUhUOy4AT4gs9xW5/w3+cYzVr6EnutsIH8nAJ6uPLA6z6wEePYwcfteNDrA6gebjJS/N5r3yz+3MIOf2cEfigYix7CiAlTiG3vOHqVVb/2MJIywp+v7i+Thgl9hgj7+DFbqfzAHssCvhDXCAZz5s/XzY1o0uQ2h3CqxFf79Xod/V5YIKc456YUIklQhSVaFVkzajluu0WdAEIGAFjoVFht6qNMskOg8GrIqaPJ9b/1qeUMX8PdoK6tQP8gaUxRQFTCHsqi4EBzGcHFZFsQ4R9OG6/QM7he/JwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BiencXI6goLR6+oQMtkKP6FAm/vQW9lX+2WN/RMsRQjUsV2+NnEBd623RRaE?=
 =?us-ascii?Q?TqT4lBqgD+yt/Aw19R49nL90gPEb2+0OmjvJSKtGzdZm5yoVFzKKmvdId/Sn?=
 =?us-ascii?Q?YsXMvR3PUWKoaLY60xPbG6Osij5VaMxiyMmzL9n0GMiKVfmcz5qGP0GAsfOr?=
 =?us-ascii?Q?vdQ0ygOFF26gbArSIjZMKhLO1AY37sstWGcphLjYnu5ZIn5XLygLcT/TQkhp?=
 =?us-ascii?Q?AlE/Wap+1at7T5TbXc+t0Lq+3nWK2r0e7q8ZEkg1MJFnxte+WqQjffkzVRTe?=
 =?us-ascii?Q?wm3dh2NWiIhnNDOm/egYZyWkUWGBwZJE1B25HnEuBmmuTun6k3fdQ1aznwIA?=
 =?us-ascii?Q?xGLtkwa6vfLF+bG7AOwdjPBzFos7EVipLbIRdbEAWNxdcfiA+C09hR3oNAGU?=
 =?us-ascii?Q?tMjPMn9ni8cjuZ3LmIysSPFEcOVqB1wZgAzCcXP9l8/Ni7u7Sb26Fdovq+av?=
 =?us-ascii?Q?hKq0whMffgemwDnjCgK77lAFlWzafmInIcqqxcVmIJuSoXjZE+q/TNjUZYHy?=
 =?us-ascii?Q?/JzjapALmDM/ZouY2Q/pwx/Gb7PDx4O0cYS9oyMu9CDofXTVNvcwz7JFibG1?=
 =?us-ascii?Q?B8GCR0uyFOLwLQ2ivTpd2lk0SXXDbwx8fUB9iMcyTHrUTJ0E/eY3AGqRuBrD?=
 =?us-ascii?Q?fAPfB4Csd8nC7+1c5B9suFLzuC9J8CItOXX/ses4YbZiLpikwQpzIgzRnLxo?=
 =?us-ascii?Q?uECeIKx1ufVdFIuLkGo5Da+N9b60djCcgUUYtxSDY4spV0wI1Mx11BwAT2/1?=
 =?us-ascii?Q?NO8OEYvUrOZGu1XLC/TU/mqpJpyQz+ZMa6T0eLMzKzCAFy7GvHVywMFg9rMP?=
 =?us-ascii?Q?qWwqP4BzlOq5v6L95Hr+um+ASOihGKnRWoL+LZj7LKjnYpb/sKiU7QavH3ay?=
 =?us-ascii?Q?cXzhm3RwD1kCsAEyPWDvC65Cb/bLNhS9WksG2lzR7555mSYeHSdXt+3Kz/j0?=
 =?us-ascii?Q?SLS/qJTCHdQN7ebt+8N1xV0D/cm06TcmjpXa3AzOMgXQ1ToisW1FKYxOxmFj?=
 =?us-ascii?Q?0VKGdqQzELHj9vwZSVTud/fB1irpOPkazlskSg1dPl4U15fLL58r8AERFmY5?=
 =?us-ascii?Q?epswKlXFSM+ScCCvvGrqUbaheu5apNitB913YjJBQid6FqhT1B/mGhSb4l1E?=
 =?us-ascii?Q?Nyb4YwgiRRDuh/9uoNhQrjRxL8X0ZZ/OfJiD/ZnkCGuzSt64h3SX5M1KXHI4?=
 =?us-ascii?Q?mlIuIfPVSNihEkD+/ErQVTLQsc08GY80wCEVGtY4vwAqzc+ulA6OlAtq7Axg?=
 =?us-ascii?Q?Bz6+woUEeMFuKPbtuJ8AND7S2gbAJC3tuIK9KxhIDyWT0ySx79i7Sz/mOULd?=
 =?us-ascii?Q?kg8YuH+s5WjgPLxqeOSqlHfr1uDjCMT3BVEmRbbQ3Fg2G25iLfq22O4N3NiC?=
 =?us-ascii?Q?j70PIsCqkTSmGPn/Po1GIuu6dPPl8ZUyCk8VRmT/e9YcH5cK9Rc8qPPtctv9?=
 =?us-ascii?Q?ONHRCSJhXkbpRk2rpxvhTKKcVrHBNco6gA+iV3aavmmm0V9GqnZAX3C2J3B6?=
 =?us-ascii?Q?27qicN817LYvfz5oFsuJcVEcwKhQqWUXBbEXmu4zKuHvUTTqJnPg8nSY3X8l?=
 =?us-ascii?Q?iAGYsIZCdau/lSMPOuEpILNwRJQ/oS3//KBvEESaEFYOQWy3uZhm54R8h+my?=
 =?us-ascii?Q?t4nqtFgf8w0mP4L44rJk8hdANe4LeBSzElU0suOhXLoRtgC+YGgpRiWTO0vL?=
 =?us-ascii?Q?G4EYchhhFnJ/Pm4muqNC/AUnUcgcwkmkMz6/v3+VbexCRmDAj1Ub/j15GCyf?=
 =?us-ascii?Q?kVQqTvbT8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78a2aa5-2c12-4543-f0be-08deaf251699
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 06:18:16.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1zWSkR+m+Tb/85AiAEvGihVjXWfrgmnfYgqD4ECuntX8Atho05iSf92C1dx810oanyK+/x/QrZp0TvrGv5VxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251

Under heavy concurrent attach/detach operations, scx_claim_exit() can
trigger a NULL pointer dereference. This can be reproduced running the
reload_loop kselftests inside a virtme-ng session:

 $ vng -v -- ./tools/testing/selftests/sched_ext/runner -t reload_loop
 ...
 BUG: kernel NULL pointer dereference, address: 0000000000000400
 RIP: 0010:scx_claim_exit+0x3b/0x120
 Call Trace:
  <TASK>
  bpf_scx_unreg+0x45/0xb0
  bpf_struct_ops_map_link_dealloc+0x39/0x50
  bpf_link_release+0x18/0x20
  __fput+0x10b/0x2e0
  __x64_sys_close+0x47/0xa0

The underlying race (diagnosed by Tejun Heo) is a stomp of @ops->priv,
not a missing NULL check:

  T2 unreg(K)                       T1 reg(K)
  -----------                       ---------
  sch = ops->priv = sch_b800
  scx_disable; flush_disable_work
    [scx_root_disable: scx_root=NULL,
     mutex_unlock, state=DISABLED]
                                    mutex_lock; state ok
                                    scx_alloc_and_add_sched:
                                      ops->priv = sch_a800
                                    scx_root = sch_a800; init=0
                                    state=ENABLED; mutex_unlock
    [flush returns]
  RCU_INIT_POINTER(ops->priv, NULL) <-- clobbers sch_a800
  kobject_put(sch_b800)

T1 acquires scx_enable_mutex inside scx_root_disable()'s mutex_unlock
window and starts a fresh attach on the same kdata, assigning sch_a800
to @ops->priv. T2 then continues out of scx_disable()/flush_disable_work
and clobbers @ops->priv to NULL, leaking sch_a800; the bpf_link is gone
but state stays SCX_ENABLED, so all future attaches fail with -EBUSY
permanently. The next bpf_scx_unreg() on that kdata then reads NULL
@ops->priv and dereferences it in scx_claim_exit().

Make @ops->priv the lifecycle binding: in scx_root_enable_workfn() and
scx_sub_enable_workfn(), after the existing state check and still under
scx_enable_mutex, refuse with -EBUSY if @ops->priv is non-NULL. This
rejects an attempt to reuse a kdata that is still bound to a previous
scheduler instance, closing the race without changing the unreg side.

Fixes: 105dcd005be2 ("sched_ext: Introduce scx_prog_sched()")
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Address the root cause (a @ops->priv clobber during concurrent attach/detach)
   instead of masking the resulting NULL deref (Tejun Heo)
 - Drop the v1 scx_prog_sched() fallback to scx_root and the NULL guard in
   bpf_scx_unreg().
 - Reword the title to reflect the actual bug.
 - Link to v1: https://lore.kernel.org/all/20260510224332.2011982-1-arighi@nvidia.com

 kernel/sched/ext.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 864fb21344205..c49ada0a89c7f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6800,6 +6800,19 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_unlock;
 	}
 
+	/*
+	 * @ops->priv binds @ops to its scx_sched instance. It is set here by
+	 * scx_alloc_and_add_sched() and cleared at the tail of bpf_scx_unreg(),
+	 * which runs after scx_root_disable() has dropped scx_enable_mutex. If
+	 * it's still non-NULL here, a previous attachment on @ops has not
+	 * finished tearing down; proceeding would let the in-flight unreg's
+	 * RCU_INIT_POINTER(NULL) clobber the @ops->priv we are about to assign.
+	 */
+	if (rcu_access_pointer(ops->priv)) {
+		ret = -EBUSY;
+		goto err_unlock;
+	}
+
 	ret = alloc_kick_syncs();
 	if (ret)
 		goto err_unlock;
@@ -7118,6 +7131,12 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 		goto out_unlock;
 	}
 
+	/* See scx_root_enable_workfn() for the @ops->priv check. */
+	if (rcu_access_pointer(ops->priv)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	cgrp = cgroup_get_from_id(ops->sub_cgroup_id);
 	if (IS_ERR(cgrp)) {
 		ret = PTR_ERR(cgrp);
-- 
2.54.0

