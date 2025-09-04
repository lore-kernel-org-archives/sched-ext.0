Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717D21D3CC
	for <sched-ext@lists.linux.dev>; Thu,  4 Sep 2025 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963873; cv=fail; b=Eye+Kb+JB+oTn8fokg/JJWhevwU2PFgfDnelthWC6T1U/Nn6vzhhp6ljIZZfq2O4cjLKU1R2XZvEE4IltmlwHO3UoVuitzB+FDhfpIER7YJDOsbjbIJgumZGWT1CWzh4S6S6INKAYc/NYslRDdhhHVc0yxMw9DZOOtoA0wSjrzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963873; c=relaxed/simple;
	bh=i+XAE9LSgBgdRF31mhDUe3y2txjgIMonQTWfoY02XQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O2B9a1eS8QdKw+fsi1b1aJhHfXyCXiOk+gr+9aHtrmjHp1sTEuGM/MQ1lcCmCTjNeGtP3LSTfBLp7G3FkkctEHqrxlV+PnAkBqto3ZAjiBA4h8TGhDXtTL8FXp72LeOw002wmnCFKCjdauvo47chQ8X/nUqZN663T+X7qOqnenM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MfyNhAui; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MfyNhAui"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqhxnJbHFbYXD+LpZy+Fcrt9WvPS3iUrd6qbLLq0CNKIUtxy0DcPQAkZ/0/a4hjE3QiisFHz50NUBIaHyeL7Hev3tcIzwAsm+SToPx8rMqadKdzARig4WMwIBgm8xMeSprsn7ll+VFfxYRMOPhCQOfqVu+0zx36+Yxxs1hDgxEfMh4AI6XN+NUe00ywAntPw6LOVOlgPVcaPI6YrGsyqZc1Ck/C1UJXIbFx9InL9e5ax1SxuF7YZsImPNl6mZLMYshgp18QK3xabJQ5x9NNWl5ZTJUfMFRLXR8IZIn/FZppwya1C0ykj8ey0djLtPLlNjiNeLQ6R6pRxmwyrEjROgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMGqKP+4uZyZjocLnIqwky9dsbX10iWggKSwE1LZ6f4=;
 b=buG0w2FIUhl0L3Hqm1MzHnwLExtTlVNy4nQvtUBDOLOfxS+gS81bTVMtqwLVe0TTfc/R/yVZ+XPDCDXZbsyUeG43ThYie30POxiPcUWte1SWQqWaJU25yNo7yR8xAo2J6Qv/ciEy0lMnkyXAVWhgYWcYvbFuaS+HbPZgEVOEQb/suW1shWOZ1llxAdyDlGALPwFTJm9210h72houJwGK8jSFS0uExT1vUsozWkbq4Fg4x016DtJSOs6OrbJjMP6A0jvx7XMoDTv4juYGOwvHS/QJyJGZ9/YZkCwMuFMAP6VkvO3Ow7o6ZEx7yu76dlS9PD/R2FV+7Y1A7b7fZw47wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMGqKP+4uZyZjocLnIqwky9dsbX10iWggKSwE1LZ6f4=;
 b=MfyNhAuia+dfKTYS6jujzt1DLGInZMsqw390d6+q4LeZ7+bvLbnCMqwKaVxZSC9ZhCVv6GN28CxgkRthfNxfdfySvqBDNDKZ3dXlwmnmsX4hUuLZmMjhBxFcp1AALWtYUKzACwVpbd+RYoyhfvgZW/RRZCKpbMe7OKz25OqKMjtqJvPCkzGR/393ChJPSKfXKyfEJnHZgtdf/MGRAkr7KrluO/t9fjuWA5/SNYUyqkjF4WxqZy3eoZDW0ZmB9SMb6shnJh1caXCWRQ4iXVn0qXnG9JoDC+EIDH/L1wABNicFzaCEJ4oI7lAATI7AuO3thxpzG29v/rZcKAQruQCKog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 05:31:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 05:31:09 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Jake Hillion <jakehillion@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.18] tools/sched_ext: Add compat helper for scx_bpf_cpu_curr()
Date: Thu,  4 Sep 2025 07:31:00 +0200
Message-ID: <20250904053100.47652-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf71092-ab6b-4419-6e39-08ddeb744078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rupvPfNsOrLBuBcILIpOeaOVJ1F7RGk5/mtQhgRddAsMVRJHokWKWaMNTSNR?=
 =?us-ascii?Q?FOkwiTu12oyKqnPGhhPwij0bspigptDskYOJWl5shlB+rDkedzMIS32YipMR?=
 =?us-ascii?Q?x6yTmJOu6YzG4BaVkNtKXYw+r3vN1LP30C5r7SNJrWbwqc1X5eCI3ZGP0Nlq?=
 =?us-ascii?Q?wxDc/1RrS7ZMTTbEmVj7Kp92c/YHEj0pc8g9KSKgMPn44ZHiN6zykUQrmZeY?=
 =?us-ascii?Q?/K1FgCIMH2zB/Ugjv3sfxNr5ZdPIIZmZVfM/OSxwhTGBTW7zmkNqXAlrDkLN?=
 =?us-ascii?Q?kEFVHfebuwfNb93xEzel3NMu1AXjYigQMpA9U172OruCVelYrPRMVd2QMHsk?=
 =?us-ascii?Q?8/W+lWZscqzSinlZDkp4MZ0z5Vl/iHW4RjG80ZRzZcAZDCKdc0B9L0wAmDti?=
 =?us-ascii?Q?4sSzV4jHOvuiSVU5DfhA8qZwkvxCdrYzTWn3u8LWfhobMiUX5S5uDujZAJ09?=
 =?us-ascii?Q?875g9C0dxezMe/9E/WKSVWDP5P26xL14PhG5YuS6P4IPiIMoOf27wyoYXVUU?=
 =?us-ascii?Q?TNtDE2gSeqZnN2hRTmcMAspQWyK2ZlP+9vpxrIRNKFYv32cPVhenrf3bylpz?=
 =?us-ascii?Q?Ke69dTQ3YHcCfFEA1cS4ZMh8KaYkVXSVfxtOVk2QGL1nvxo36uoIvAjf6JI7?=
 =?us-ascii?Q?zrQnfOBk7qfbSAVxMxO+2eshATNABsasc/+IpGyX35LJABknscRHtQoaAJNa?=
 =?us-ascii?Q?R2jRaE4FR4131+WIpBtUNEL8od5c54/TE3EI7VoW3scp88v6rJAhNwuS+XzS?=
 =?us-ascii?Q?/z6jljzNWTXhiHiD6+TO/W/QwN5d+8pNOei2+uSmtGJc3oByOfTejxdhpl8S?=
 =?us-ascii?Q?lCos9UpdZeg0UzlcFU0NVARRkt0IKzh0Q8ra7l6Nqynb+JYgs4HE/NgjGPK9?=
 =?us-ascii?Q?4/EOGmt629DWXWrTwsZCEdU3cWa4Uw9IwZ++hAHJJTiw0FTTtzR42VawOeXo?=
 =?us-ascii?Q?qR9PeF5+aIorklHFvc5cnA2Roal7Wh6dzsq7QR0vvvcnICrjexT5VrfObYiV?=
 =?us-ascii?Q?s3GX8Unw7S5L56uxVtOgnjWfm96vvAKmltVJvhnfkvRKadDXvWuXbcmA+O+G?=
 =?us-ascii?Q?U5htpOSs6qXCOQXuefqsicLc88bbV/jVF3AHDbJ2VsFOEp2TwK4MzJtjoZUI?=
 =?us-ascii?Q?lwj92/7L4u6wt+8sFqiVUYUpPM54gICVyfdSBo6FKnYkpTMwSNWOXyYMDLza?=
 =?us-ascii?Q?phAo3BEAoFJNqyzrjBZ6CBRG/qmr4E2fx5AnM5Ekxz2D3RQUNs6IrFlQTPBw?=
 =?us-ascii?Q?qHL8gQWBKapfgTM5X5ZA32ejd/sdXm1PYelRb+reW5Pk1b4IeZ5/+Z9NQo7a?=
 =?us-ascii?Q?p4YRq2NwmvfX685quEY9qLbQPATtUDvUVSZRFdoQpqgCUpot+GNNvJOsmPm+?=
 =?us-ascii?Q?79qP3Zz1x4u85V2/apdxZCs6lS7aWiiFg2mHsuP7GxObFMtzeWh/aMmj47zD?=
 =?us-ascii?Q?OQIMLfbnoJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUUGhuRwcXB3CDUoJ3W4HyS/OIJS1dEGOWdUsgMVD9hL0wmacD+aVnhvGncH?=
 =?us-ascii?Q?SCNSianJyVD5Kpq1KMXTb0JbB8/6biDRloDcxxjK7Cp9mMbYnaflXElu9aya?=
 =?us-ascii?Q?ft20ANLvaGNUWJPguZT+T/ZXA7EuUOaFYuU34J5qCNu6wgvosKekOUDQgYvW?=
 =?us-ascii?Q?2Bbk0LzBAucyJl5r3QayDqFZysjxUuWe5pmvL7Ga+Bwn7wiCC7mdR/XmnsYo?=
 =?us-ascii?Q?ysPBKdPkD2f+sXTQGEDVakkXssTJObvkBt3kojPgYEBWgyMLzjJQre6MK5Fu?=
 =?us-ascii?Q?oqExNxSMDl0/wEcA+hHJgVlGi74CpW8RZit6feQaG3jsqOeTAxVsBbolldqy?=
 =?us-ascii?Q?hCVwRbikJnW6CAFWmzy+ZF0rw6Ps6HresUk2TxEwrePc4NqxwNpFbmUUX2DU?=
 =?us-ascii?Q?+lqf3T4U7oUgG7c1o6dOiyGVVmhNFbXTUaCPN409rJcWKqbD4JvGdz/4TbFA?=
 =?us-ascii?Q?f84EvGHbeDeW6Ni76aE81zRpDwJ6bjozoJexK1QKx+MvjcRS2sd8AtAajS1h?=
 =?us-ascii?Q?VF7NKMZY7eZidrdhtu3MdwbPC3NqUfLneYo9GwEVWstmbMZMNwAIUb69Gwrx?=
 =?us-ascii?Q?SGlCpHo7GnpIIGRXgjZi3cnxM0LPrAaBccE2jgpmgXq9CJ9OoO5O1ESamQNV?=
 =?us-ascii?Q?KEsZJ4oqE6ZZRH8vXyK33yd6ZoTda4eGjtte1dCvBDRY5n1s46+5LpBQMy/d?=
 =?us-ascii?Q?27biFaaG6jI4jYQ2/JDsyZlBtkmtvWyQuhl4wGAmSMCM92/ZG7o35BDFd9j+?=
 =?us-ascii?Q?N1/0sSa7gPMsmHiqbt0ztMnKklOC+8ETQbWnyXrCY2Dt1AkP4usY1F2Q31iI?=
 =?us-ascii?Q?FiiwvaZUdGNVRhQLfXNytLWItI36lNRyt4E1vv0ixsrLy9ZJKqzlkQWYiZeU?=
 =?us-ascii?Q?HHdhYiGsDyryDtlzgBqAWNw8BEVcTwemUV5dEMg8RaJekqTGSadcdg8bTC1W?=
 =?us-ascii?Q?6DTEj6GhA3WkIuvlMNPyzlOQJz8H76Tn60kLql3xYGOZFoK2UcqOL6zyIWnk?=
 =?us-ascii?Q?Y+tSaRMY54n1CpcvzQJX69lmh8IZXarWQJHWfHquRX1/VEeIkdlzRccKLifk?=
 =?us-ascii?Q?y+WgL37xgOhzkfmJTlQ88WCu+ECkGTSBkO8IHsTUKJEY+107QOOHM3F630Go?=
 =?us-ascii?Q?4WVibljpoKrJZUdrWsGTGm5NDTsHUSxo8A9Ln2snBt3VmTdmKe4ojlYbjGuQ?=
 =?us-ascii?Q?fAI2Dz4W4IuyYfoabxziKBC9PQqq6Xk8c2pE94oMb07QEXW/V6A2w/oV7cX+?=
 =?us-ascii?Q?fvAtBtC7vrv1jXLMuNttGhWdmH/4dpEPvuFkXLMPMb1XwW4x2+ezSP20Bne5?=
 =?us-ascii?Q?cvkfMYmvFyak8qIrmsDFMILVfHBFjxlnnm/bD2pEgAF7JmoXPgkKDmldZIkO?=
 =?us-ascii?Q?x7G4lKfOlfuj+eDwXoX96Zhcp1ogIFuhtqK9M88o+DfIogam6rDx8pmpg8rn?=
 =?us-ascii?Q?RjF8Dd6Zhjoxo5+WcjEmQyQmvDqddN2DQYjyAHYev8S/jQ1KpboAvN1Iem+T?=
 =?us-ascii?Q?xJpfOrlVRY5mP1pDvC6s1nJQ5NN0eRRdsuzdbOzbB9U38+QXwkKpZPlCAXqd?=
 =?us-ascii?Q?6bSuu50Oyuc2PZisoTHV8M9XI7fXnGs9dolOBoLV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf71092-ab6b-4419-6e39-08ddeb744078
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 05:31:08.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOi9BlTKnswMtLC0dHKlTGT89bp/C5m/1+MibBNFEnjo4WO68P1cl+kiikKbECAk5NxQOVSHbt3ElnWUmxdDhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

Introduce a compatibility helper that allows BPF schedulers to use
scx_bpf_cpu_curr() on older kernels.

Fixes: 20b158094a1ad ("sched_ext: Introduce scx_bpf_cpu_curr()")
Cc: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 tools/sched_ext/include/scx/compat.bpf.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 342c7c48df5ab..06e2551033cb1 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -104,7 +104,7 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
-struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym;
+struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 36e0cd2fd4eda..dd9144624dc99 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -230,6 +230,23 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
 	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
 
+/*
+ * v6.18: Add a helper to retrieve the current task running on a CPU.
+ *
+ * Keep this helper available until v6.20 for compatibility.
+ */
+static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
+{
+	struct rq *rq;
+
+	if (bpf_ksym_exists(scx_bpf_cpu_curr))
+		return scx_bpf_cpu_curr(cpu);
+
+	rq = scx_bpf_cpu_rq(cpu);
+
+	return rq ? rq->curr : NULL;
+}
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.51.0

