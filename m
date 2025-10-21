Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5134164C
	for <sched-ext@lists.linux.dev>; Tue, 21 Oct 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058665; cv=fail; b=SHf5Vq1oAERLdTUfoC08lQfRO/nI9/L/GyIYZSSBtnH+csrSbJdhFQB6OuHMlA+WvBbyhiHjnq/WMpFoCivdgIps6OW6ZoUs1bU9FxG/LY/BWLVhV7rL4SrBbpKCCtTzES8AEPTCeLIIb7i1ucXgJA+5CboY/gj4jKqE7KnBkvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058665; c=relaxed/simple;
	bh=7g76afPNH0hgc67rH7xgs7Iv14UbvQ+Ikyl/u26H/3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HRPWan4snsbadLwmCeRkw0jCNi0AETb23Q7hl6+fDaMO78Yq+q/YEouhXOtZQBe3+VgYer7lsL9XJMUPAN097/lC9OuSuPcOFI7UYq1X+ECphHom+x7wme3eLLMlu7BMYhM8ABwmRQOz6KmSR1kbTSOykvPsKP1yWkVNgGaMMf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rKG79Za5; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rKG79Za5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2X7lzr6L2XHG4BFVaHsgacWVKDs7DPTr3WBQ8JdClnGDvfSHcvymRIFdEcbDl/uXZgEjyWCBcLxFzyb9NI23NEKJaDPapxsFswZZWH3Z0QRlxUpOKX2jOSetIVIKiPJWhAlFZ8mYr0ql5GbZ9fEPh6fI/QQ5GSQ4vIsmn5n/aTQosZheZMB/CT/4bgkAHKb5vM/p02kXtfpGREo1Bgsj8NTl0SWt8fUFebVIaEfrSraKzLsVxFqvsybXNmprB0cE5+3t7gQl0f/RKQiHHGAiF6s7AJ+t5/aw90dSkDanWhLocuadGlEFvZsIN8UterkAWKBeVVMPmfNZg0oeqvEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tljl0puf8rwEWkpb1tDSUmfDWL/pxVORAzS719Ei8cE=;
 b=IWKm9/Kpm01u3fKX2F7OYpRCVtWoA0zq8QuJ4IDf82KbsAZJLEiurlqtcXStK25MU++tw01rGR8hnA8O6vKf7MzmxYBGhLe36BPXqve1udWBq+01/lvCXlvou5aiHcK/wfpV+9T2WkHzI/17LVCv5rDcqDetnmN/KMo3Rg3XW2RYe1PXtJCxL+YCFkQQTwRl/6uC7pa2l77pDAGpt62AwDLg01VaHHyoOy6OUIO6pVIUpJOoHTlU+/DFmy9JbGc7HUtOCAF68ysQbEtWSgqd8SzsZr1G0//v68Jvyo/T2zsOuamD+l92fJ7W56USBqJDuuGP+v7bBzy6wtHeC1LN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tljl0puf8rwEWkpb1tDSUmfDWL/pxVORAzS719Ei8cE=;
 b=rKG79Za592S2Cl/WqQc1rUdg42U4TNyIiEWO+Q8YFYVgW1YHsNAIjYgIwi2xRTcXS4xjTAyUnwuHxK0uUMzLKieO8i1sQT8KZ3cAXfO0iRnI4sCflXjkw3RMBdUN3eOQyzggM9dt/O38kH4pWyojhLFsZo2h4CG77KKguHmlTlPPFuTw3bgfcyS81fkrtSBsk6OJjX3KNGoM09qdfQGyvmWuYamjpzVhjsiP7sTBnvO0hBWXOpFwW+SfzZqwNI5m91K3tDmKzrmNy7luiWqWa/UsxIUyVBCBoBR4hqmKzIY4efOofBZZvNzFMzsVQE+yZulWbFZK20+yXdYF4OKaBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 14:57:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 14:57:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sched: Expose sd_llc_shared->has_idle_cores to other sched classes
Date: Tue, 21 Oct 2025 16:55:43 +0200
Message-ID: <20251021145706.61534-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021145706.61534-1-arighi@nvidia.com>
References: <20251021145706.61534-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 73839ea0-3d44-4fd1-3108-08de10b22e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DqBuJx1oy7DdVN4oUSEC3hIHkL0dQMow4yRyHzurGIx4drbqoKkXp5/w6KW1?=
 =?us-ascii?Q?BTXgFfvk2Heza7j30h59HbCS31+zNbgCj65UFBrxtHQispuLfxXI9LhiZiHK?=
 =?us-ascii?Q?G4K1AuEnJStK1f041nmMwJNSyBnEbW0LhBoofjpYgcSDZmfI+UVKrs8pMQ2+?=
 =?us-ascii?Q?xb1Rma2wLiMTUiUQjmfQfsGY7CDnD875Xe9KBpEeXwBE5b51/M2vIxD4gR5/?=
 =?us-ascii?Q?6kEQVMZw0dCmsIBhTM0+YhavsVhR9Mqc7jyeM16l9mCVFZla0geHTT8iuewP?=
 =?us-ascii?Q?UqjqzZmPpuonjvo+dVayJ/yba1SKP52nryoZOC85mmPoVmsML5jdoyAuBVve?=
 =?us-ascii?Q?b1MAoetx6nLmhrIM9Qpv3o1qyQpyHpnPEixMex3R9sCEWk1wtcuQOSOs/DiR?=
 =?us-ascii?Q?/BE3ciwpFfz4+jSidmRc3Y7QaSbE9Pfv3Lz/K1e8IXAaitLfZvt9JElZ+3Uj?=
 =?us-ascii?Q?mAKw9ZwGco8UAPmCCBM0wDwCEBhI9KZNbMBgiR+44GyEWx3KU3Sq82XmEnTw?=
 =?us-ascii?Q?49hRbgeKItaM/cmceFAuWQCZrwhBq4MjjxG/odYq0bv4X9qpshPrQ9u5LPEx?=
 =?us-ascii?Q?ifWLKh3ZnjobwRtnzxus+Sg0ae+LL7McHa5RhFOuAhP27YJiGMOsHP0Gd9lg?=
 =?us-ascii?Q?QcozXqgsijdwqGpMUn/yOvayvErsRtUIMGxxdQIQCQmbo0CliO7Aouz3mZqx?=
 =?us-ascii?Q?tsatHmVnQl8AFm6KmpxBmP9OBMP9RGjsEyHaq8y5gtzdcyreXattB5D29PPS?=
 =?us-ascii?Q?/jNsB8WuqmJfZ4D1SGB30naXkREh4/8A88YTpFDR0nkl1UwTKAUMsRkqKK0l?=
 =?us-ascii?Q?+C89b6PYrdi2qZfWndj59xz63lL5yNBnlO1EoqWLL5B3ZPI22h12FSwT2upS?=
 =?us-ascii?Q?H9b5AqEWIjmVTMQ8d1dkgxo193kCPBJQkYh5hpbSn7xxddtwjPtZpHuNiPRk?=
 =?us-ascii?Q?JGtimDzcWf6QM6SsFKDoSLhhnzZ9iMMn4WtxhMiXaakKoSL0Cyt6aFlZbOdy?=
 =?us-ascii?Q?6csMuUgomMf8ddg1nKFNNx7oxxqrb+R39b8Wht+CqiWv99RQ7D9J4TlXTEdM?=
 =?us-ascii?Q?mXf20ga9Q0A5vU51M00QSHEUwKUYtGhqi7EufgAATVNB1jVL9J1Aaavjpbx2?=
 =?us-ascii?Q?ey2iyqQjqs88YCS4Y8Nwpeua9vABX9YyXENLRB4TpKzu3qJkzNsrqqjNy8yb?=
 =?us-ascii?Q?WHCkrDa6Wuc0zL3BjVAbb7bQBs/g19fRa9twuQK7Rfv1u1DhttwprDe8ARTP?=
 =?us-ascii?Q?DvpnhosjEXdu+5i/r8NbHbAF+xSOzM4jQHpAigt2MeRG2RV1/TmwACDUmTqq?=
 =?us-ascii?Q?QNd+vd+8Phuc9iulEoHn44AerATkeWi7F7jbC5UCY3dyQUgJOsguHPagOUud?=
 =?us-ascii?Q?9Unrw0RA025MIl2nPURIFd40TPTjqEgBmBPAFtfKPFocQ3UWgPJCCCP2gPDm?=
 =?us-ascii?Q?7DWE93ZGpb1Eh6E/Eo/yisEJFVKw/BWP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCK1XwMPZCwxFgJSFK9mJOgqGq7VCUIdlAIRGudpfziNmi8S3WDfaGkP/4vR?=
 =?us-ascii?Q?2FnIOD6erLnXM9hfi/SEmwGWjeOSQJgXI6YJ1Jw7OEq/Ft6/42F0qWVXPl00?=
 =?us-ascii?Q?noTNTVGEX9lkuHoGb8tj1dyY8tnxzWA3fOt/LNqKL8SbK0BxgudyfGAWqv23?=
 =?us-ascii?Q?7joNBHhIDCDZYy02PiWQSu4QY8tjm8fxqNq0Oje4vjLgCPqjEXn9RcXKBz+8?=
 =?us-ascii?Q?EINOhsCZVdt/tE3Y1CZbB0+6xALmUKZvCeC5Cjvy1Lsr7VBc22sTzO2cWHWL?=
 =?us-ascii?Q?T8+d+QrBMID69ptS99Oe9eCSTT+L/WeSQavTJVA/saEMVUBR7l7J8xY9f6XH?=
 =?us-ascii?Q?5Q/jW9KEubfCST5BDsiKACk7swKgb+C9MB7aoe+zJs4AMRQIgoAehZxYstUq?=
 =?us-ascii?Q?7rOmeuxzO/7pumQ6YRnvNQZC8boKULCT1FRtj4mx7QABL/bL+S/YPKz9DwA+?=
 =?us-ascii?Q?Am5CY6/eCXtbpxib546WmBvC4ckCu3X4PcgN3WoNbVX+r1Y1R0mY4b6ak9/g?=
 =?us-ascii?Q?7fVo7D1axsZ0DeeUshI/Ku4YhXin5f7qNi6/Dp/CmVpMpqpjdgdHjTszKvju?=
 =?us-ascii?Q?40jeMngwcr+Nxkn970FhGyMmFzTxmzVcFISYfE1Bb5xxdKHR+jv2R1aDnRkL?=
 =?us-ascii?Q?wzr/N2UtJQ+i82YhJZN6MdvRXp0a+ga/FxJw/OGDI9axngWZhQZOf86JTAHR?=
 =?us-ascii?Q?R5PbFqoi2qdEz0mC42rQxo95k2xLVpyLzGigEkmm1tfKvNLgyLJH3ceMa82y?=
 =?us-ascii?Q?Sme65tqhpys8+EvUnkOz3pOFeIozCr7E7d/fn1OGA7Ud8yGO5h/D7EdomxJQ?=
 =?us-ascii?Q?tbL0qPjIbjhq3Nf8hVCwEftuExaI9BwgHKJBn/mbYWmZAf8lmw6/byPQYTDl?=
 =?us-ascii?Q?iKibloUPMrDcOH5x1DTnWiTsdHzwVFhctJJXcT+aVTnCx4mRgO8nf3ULc9kN?=
 =?us-ascii?Q?mzmUCnv6UUZ+NS9iSy4DNP2e4tgXizkWY48sFvGlSXU2lBQhBInif3Et02Oc?=
 =?us-ascii?Q?Zc8NdfxrkWlN2pCzukvD335h5qe5n7gYy8RGzzRd9pxyEhIMZcersIOuuMk1?=
 =?us-ascii?Q?Dr1OphtXJBQ/KMGKkIG/yn0/7yBCkF8ghk5XTfkHlgWKFnTICUeDSAHRhNXs?=
 =?us-ascii?Q?bw6ApIrw9peo7sdIwsJwLagv9jzi3QDcDxbJdChqClkUZ1BVEZhxpZiev9/+?=
 =?us-ascii?Q?v0FTSueHbJSmpSE+5bDuT+HcfnbKGCyPpMVhVzSj+s6K6bhReB0LTLRXkbxP?=
 =?us-ascii?Q?bQbu2fwZbL4dDPOpSvB68+myiXMszMDq6+NJ23A4U7WkATqyXbaNg+l9TZVU?=
 =?us-ascii?Q?IrcF+3S8qlEWeMDfgA3j3wxO15BD2S8lYCWa5xw8yPWy00kV8g6GWP9kSaeD?=
 =?us-ascii?Q?xpp1JT+ifGvSpylBIjqHrjwIpH0MbnsdPQoZLpz0yo2yIrTIjhY9We+1kARF?=
 =?us-ascii?Q?0ZgepfpK6TnqlpB2CK+7Z61b6C+767Gawg8QWmFwUPqfx8OgG6c2/z2mgBVE?=
 =?us-ascii?Q?oNo3A+U0q1KyXMjI/ZmgClvWYO2U7ZZomnC1hXvg/GFCOeP5LKWX2slA6ghI?=
 =?us-ascii?Q?hFJ71BtzJRx1nZA5MIq3OlXOVccGq0oS0UTcXmum?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73839ea0-3d44-4fd1-3108-08de10b22e9b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:57:40.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AC9ASzuSXqsNJvyP+CYOjgjN3slx7uWxlX7Aa5s4kTHvWZ8zyV6hJm0O31FlVTFD8L7xce6Iz52pe0VMt8qkJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

Move the logic to manage sd_llc_shared->has_idle_cores to sched/idle.c
and relocate the set/test/update helpers to sched.h so they can be
reused by other sched classes (e.g., sched_ext).

No functional changes.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/fair.c  | 63 +-------------------------------------------
 kernel/sched/idle.c  | 31 ++++++++++++++++++++++
 kernel/sched/sched.h | 55 +++++++++++++++++++++++++++++---------
 3 files changed, 74 insertions(+), 75 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef0a1bd26450b..64ec1527d1af4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2080,8 +2080,6 @@ numa_type numa_classify(unsigned int imbalance_pct,
 }
 
 #ifdef CONFIG_SCHED_SMT
-/* Forward declarations of select_idle_sibling helpers */
-static inline bool test_idle_cores(int cpu);
 static inline int numa_idle_core(int idle_core, int cpu)
 {
 	if (!static_branch_likely(&sched_smt_present) ||
@@ -7539,59 +7537,10 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 }
 
 #ifdef CONFIG_SCHED_SMT
-static inline void set_idle_cores(int cpu, int val)
-{
-	struct sched_domain_shared *sds;
-
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		WRITE_ONCE(sds->has_idle_cores, val);
-}
-
-static inline bool test_idle_cores(int cpu)
-{
-	struct sched_domain_shared *sds;
-
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
-
-	return false;
-}
-
-/*
- * Scans the local SMT mask to see if the entire core is idle, and records this
- * information in sd_llc_shared->has_idle_cores.
- *
- * Since SMT siblings share all cache levels, inspecting this limited remote
- * state should be fairly cheap.
- */
-void __update_idle_core(struct rq *rq)
-{
-	int core = cpu_of(rq);
-	int cpu;
-
-	rcu_read_lock();
-	if (test_idle_cores(core))
-		goto unlock;
-
-	for_each_cpu(cpu, cpu_smt_mask(core)) {
-		if (cpu == core)
-			continue;
-
-		if (!available_idle_cpu(cpu))
-			goto unlock;
-	}
-
-	set_idle_cores(core, 1);
-unlock:
-	rcu_read_unlock();
-}
-
 /*
  * Scan the entire LLC domain for idle cores; this dynamically switches off if
  * there are no idle cores left in the system; tracked through
- * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
+ * sd_llc->shared->has_idle_cores and enabled through update_idle_core().
  */
 static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
@@ -7645,16 +7594,6 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 }
 
 #else /* !CONFIG_SCHED_SMT: */
-
-static inline void set_idle_cores(int cpu, int val)
-{
-}
-
-static inline bool test_idle_cores(int cpu)
-{
-	return false;
-}
-
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core, p);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c39b089d4f09b..06b67c88e70e6 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -452,6 +452,37 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 	resched_curr(rq);
 }
 
+#ifdef CONFIG_SCHED_SMT
+/*
+ * Scans the local SMT mask to see if the entire core is idle, and records this
+ * information in sd_llc_shared->has_idle_cores.
+ *
+ * Since SMT siblings share all cache levels, inspecting this limited remote
+ * state should be fairly cheap.
+ */
+void __update_idle_core(struct rq *rq)
+{
+	int core = cpu_of(rq);
+	int cpu;
+
+	rcu_read_lock();
+	if (test_idle_cores(core))
+		goto unlock;
+
+	for_each_cpu(cpu, cpu_smt_mask(core)) {
+		if (cpu == core)
+			continue;
+
+		if (!available_idle_cpu(cpu))
+			goto unlock;
+	}
+
+	set_idle_cores(core, 1);
+unlock:
+	rcu_read_unlock();
+}
+#endif /* !CONFIG_SCHED_SMT: */
+
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	dl_server_update_idle_time(rq, prev);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f5d07067f60a..b943ebbc3fcb1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1579,19 +1579,6 @@ do {						\
 	flags = _raw_spin_rq_lock_irqsave(rq);	\
 } while (0)
 
-#ifdef CONFIG_SCHED_SMT
-extern void __update_idle_core(struct rq *rq);
-
-static inline void update_idle_core(struct rq *rq)
-{
-	if (static_branch_unlikely(&sched_smt_present))
-		__update_idle_core(rq);
-}
-
-#else /* !CONFIG_SCHED_SMT: */
-static inline void update_idle_core(struct rq *rq) { }
-#endif /* !CONFIG_SCHED_SMT */
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
 static inline struct task_struct *task_of(struct sched_entity *se)
@@ -2069,6 +2056,48 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 extern struct static_key_false sched_cluster_active;
 
+#ifdef CONFIG_SCHED_SMT
+static inline void set_idle_cores(int cpu, int val)
+{
+	struct sched_domain_shared *sds;
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds)
+		WRITE_ONCE(sds->has_idle_cores, val);
+}
+
+static inline bool test_idle_cores(int cpu)
+{
+	struct sched_domain_shared *sds;
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds)
+		return READ_ONCE(sds->has_idle_cores);
+
+	return false;
+}
+
+extern void __update_idle_core(struct rq *rq);
+
+static inline void update_idle_core(struct rq *rq)
+{
+	if (static_branch_unlikely(&sched_smt_present))
+		__update_idle_core(rq);
+}
+
+#else /* !CONFIG_SCHED_SMT: */
+static inline void set_idle_cores(int cpu, int val)
+{
+}
+
+static inline bool test_idle_cores(int cpu)
+{
+	return false;
+}
+
+static inline void update_idle_core(struct rq *rq) { }
+#endif /* CONFIG_SCHED_SMT */
+
 static __always_inline bool sched_asym_cpucap_active(void)
 {
 	return static_branch_unlikely(&sched_asym_cpucapacity);
-- 
2.51.1

