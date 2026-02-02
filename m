Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9B378830
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045230; cv=fail; b=MJvLFdtwOl2pR4EqDHjCWznySo+7GI7U1nzYsUuQbyAfdo1eM6oUERF/3hygPDSSAp3nTE378fGA/oT3CGNhSSBL/kdJbw01iq9IuP6vPtYgKuAmM6aQ9wxZ0nyl9NczsPi85h4pBl45xnSLDGBPS1JuE85Ec62o9JfBGkU5LJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045230; c=relaxed/simple;
	bh=QM4AhDV7VyOt3S84siiu/F3pEqkspjriEQC18pP0tgs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=heBPnW0fvHdQFGFAcVCUKGT4w6pfr+Ei4JMqAv9QinFs8AbOp/aoif6GefS6MpKHJaN7cmsUzhlqL5QhbH2SBnSrmCFPH70mvCaPhapei9wsqxY3kZ1wp8vEgqkHiX5NtYDqlvdbGjoxUvPheK/xsme7Um4jhMySRHeHpLl6cAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQLV+uiE; arc=fail smtp.client-ip=52.101.193.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQLV+uiE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhLiOE3P5oiuZonP8wrsLNzafOLqP483CNuigYWjqEi0KfS/6/4xWvLlkPz7prDc9Q2V/z1+FwEctan9ocyTOuWcXVutyfGVq0vDlzRkdiL2P1fDPGvXFCSnyKifsINtvE9VzpynpwnmNHMJxqqO1C5yneHFHOlbKYOSDLL+99ghXbe91VXFS4XWUp6Ma3NMEI661GrQ27yK1eN9JHlqTPIWLu7sF0sRRaLW9GSYhDMS0xRMAQggufKIYQviScKIcHkmPN7z4NeiYqT9akN1K/6ne4xBXg+jY7ibwe/FvjQEJryYf177eX4B9oFVuTzt2bEdq95JQRPr86gK9LTCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV6tYnVfe+sL0/xYGhmU9WsC8avKlQgbxRPySIsDIVY=;
 b=imXAIN7mIQB/mI21oTGZ7RqXnpJX9wJJUxUFm5fV3p0RJyXLoGXs4LTssZxtV+zqPJsxV1B7SauqTxwilwyDlUZcAHm6IWPkNbh/5ghhbSY4NuXxBfBssRj1KQrhWK9TbxW/BSrSdU2qe2AbuOJgN8P3/DFU9WztZ/05zdZlWfm18ryHBtExk+JMruCGqN3IPNm09jb1RRtBv92HcLyAhZam7NNlX4Elp9I3v3KNd7TAUjJQBk/iHK32zzbHWDQbEwRk7qbDsEeZoVeqLAPo4aG6asISpZKMieSgasAtiNW98nQHi+If+kMSTto01zZDlTo7H7Hrb8jLKO1tiy4Wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV6tYnVfe+sL0/xYGhmU9WsC8avKlQgbxRPySIsDIVY=;
 b=CQLV+uiEaVMsAblp04AUz/vw1lFqnpW+gaIWGnhGA4YSBB3Cj7zE6SSe7Noj37PFSr5hBznKk8cS//brRgJI9to5ep/5P1eVJf4jaxaT4svj42jw0eCqabl12J6Ts/OU51aRR4eZDADLZH5P1PHTAUqHqVhAW3ezW/7yLrqqOuy/y0o2ximzFL55aOcEu8z+VTyixZEhyNF/Ms0m2OfpcJZw0AVEnaTJp/Gsx64MxaUhvTYlOBIpNHZP7e2cIKxle/fZ+KzsnnrrJQeC7oDmpER4nqpa/SguOmt5oVA91k2kDBjj59ySY5yjnvb607h4YSUOtPkx/b8FoLSlzNLk3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:13:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:13:44 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Fix NULL pointer deref and warnings during scx teardown
Date: Mon,  2 Feb 2026 16:13:41 +0100
Message-ID: <20260202151341.796959-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0185.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f056933-e098-4764-6041-08de626da7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jSQ45f0vo4d/zu1aqThYPbKuDkbqk992TB/nwsERnKbLYFIktZvGF7c8wqEe?=
 =?us-ascii?Q?wkW/FYetVCkxzlDcu0RvEvpD43Fkv71OJ6j5RS5yqeFPmnAtVkYh7CRVxhU5?=
 =?us-ascii?Q?9NJhBTb/od4KafIWFmwJgHyL3VAbTDRlprX7L9VJJnyYzgBN1N18jhCd1ceY?=
 =?us-ascii?Q?/wXBjSq6Xsej3pK9mcI8Wjh5OtXHDxlzE7//n9Qd+ATzr6do2luveaLFr54w?=
 =?us-ascii?Q?K1KF6D/qEQ6D4kR+qlCwlPAhFi9kXA9k7uslqo7lE+AOWIB+VsLmGd6uGle0?=
 =?us-ascii?Q?qr7NtywwPdartU1nKMckBnYFXQ+sLfraagqUM6WhDOUG5vYjC/YW4XFihC1i?=
 =?us-ascii?Q?iA605Eiy5gXCAQABk7QoqDlKowXudtov+iYPSSLBfeqwmtFT8wepuIMfE8Cy?=
 =?us-ascii?Q?IF/La+GS8K/HdZu+hMcSKC0jCvEYzROMPBof7swCnwjZsJ/hQiMeWXywpkvZ?=
 =?us-ascii?Q?nCNtOAMEX8G1UcRd3UlGTVR5NrXWahyNr5R1Dnu5dQDAHOd7t3kXw12WPQSD?=
 =?us-ascii?Q?Ax5IrDnShYKCjIk6hyo8hSFVdWy72gK2PgnF5yV9seIrwvjmj1C0PUpOUIaW?=
 =?us-ascii?Q?QCbSnrt+N1pwVRoPJCCL0zQ9p12g7AGaJW6bfG8yjCEArHGSU+RRFDW8csYF?=
 =?us-ascii?Q?/stAOSnUQsPRm6B++cCDRZ2EYxdFBQ5vqJb39F//WhkCB24v1Zdj7HBtxxNw?=
 =?us-ascii?Q?gQWaa3whQOMsOPHzmIlJN8psCeuwmozXe6mGrpcL9RzbAIR/F5D8zjDJZWa+?=
 =?us-ascii?Q?p1NPReFBeCNUqmAea5xtBjIeAnBp7S1rg3eNTF3UoES+14x4FVS5z2wE4Rzu?=
 =?us-ascii?Q?S0hN2XA3pOUxAGTMPF5gbzj1hZRJxvIh1jek+R6NqxbPQI0izw/6C5tDD69b?=
 =?us-ascii?Q?6/42R/VzckR0pxcutmoQ+Mh/jhVunTNdWfvmjoGJMYbt4mpVoLR2IFxDWwIT?=
 =?us-ascii?Q?EExmcDHMTS63HGYQg96DdiY8Qx3dBZvrTxn1Basy+op1iDb8FSrrDRe2Z1UP?=
 =?us-ascii?Q?q/Qms9IZTPazIjZ6WiV4XbHTof4I4G3teKeK5xj8IZWq2KX7288bBf7EZoY9?=
 =?us-ascii?Q?pLCdfR6QQGhKbyXZ/9fenzqbK6EQlty6lNsZZZj7BSES3yyVKoRWx0h7aGNd?=
 =?us-ascii?Q?O6dE6YbSv06f1VdGRaEVeurqY5MoQuXRB3g3lT+bS/RuGYhht7sWoL6lxnRW?=
 =?us-ascii?Q?NqKzp77YVQ53o8aMaqxaGJ3RZxwnkG4gaZRXOM3lAAZwkxaprcvkPByx4And?=
 =?us-ascii?Q?iqJ7obwPROL5APs/gVm32H6g1UyCMe/7yPhqDlNNQh9DDEWN88eGUct/fyzE?=
 =?us-ascii?Q?aCJT7gmeTZWiVAj3DUmtu7UDa1DqDw3Sh1K3MUenkWYL11U+pp/y98iCf/fV?=
 =?us-ascii?Q?LbsiDYhZLsDUtQbM+AJubzmkaUGSGNniWCm/f/pkyKkmAXV5BpDOPe9RSSGe?=
 =?us-ascii?Q?msjb/wAo5NOr4v7azbYIZlmqpc/GF8vyhp2Au+KamgBTG8l42YngJvLgV7py?=
 =?us-ascii?Q?EgtLnpayOngP9K2jRx3rxOobIiYbNv/5SOmVCdbvktll0d7g5OKWapgQdOai?=
 =?us-ascii?Q?+sufoNR3dgTO1ofBJyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NzR276VlXsqd9xBgc3Lc/rxYufG31FgDd7kLey6yE/eb0DjfUTKY0gnlcd0s?=
 =?us-ascii?Q?O+YWSmBsvjqD8kmrCVK2BZSBmSoRn2AkMmn7z/fPYiOf/LGulBMplhvgiZOd?=
 =?us-ascii?Q?l+EmClvsyIaSUxq3Fj+SDuBAKr17hQY+dD4jRHBR5Zv+UD+cZZXTNZx543/k?=
 =?us-ascii?Q?1XrVbDn5+kwckIGiZm+ZBpfGqu0NqcCeWcMWhrkn+1vDH9B0LxyHBj9lzPfb?=
 =?us-ascii?Q?2lLr+8mSVd+jKS4Tt8rpC+Oli9HaiH7gvu4KX/9cKmpsXSWfx6Fr6nnEaDSP?=
 =?us-ascii?Q?nkI6xnznBwnJAi3ALqU4CWMGiXk1OS1qfpm/saDTd8rFVMU7tuYEr9F8zT8x?=
 =?us-ascii?Q?CZwocJ4gEXPpXBxLoyB3VKhh8v2F4svxUD4/GUAe87C62AwzYTwQ8NiU/ai8?=
 =?us-ascii?Q?A4KVzgbbHFZ9Q5NO7QgCDH8rILjPqApOizODdxTo4c/CyCYjFau3Ljacpyzt?=
 =?us-ascii?Q?GiCFyn6SxuSBe2DGdeB0DCCJqgaivuQGpAh/kbp9j1vga0gVje9zDsClXzKF?=
 =?us-ascii?Q?8fLdpNVcqRV7taWxxzqP9YuD1ZE4R1UpNbaLD+rP3Y+cYQSEwoPonFm/OgJX?=
 =?us-ascii?Q?kSCo+ucqqBh2hh8BTcK7icolpqWganQiEyUhC/P90LruH8plzV7XEpbtifta?=
 =?us-ascii?Q?ku6becAf8vK8RdecARBdEc0sTlwndG3Jf1s/D9xtkWFjYxAJ8jgInGZkZ2ds?=
 =?us-ascii?Q?+/lpeb8kLOZRv+0QOfp8t+PXsfdTjb9chlzMEybR7KgF2o/KVu0oaIfRMWOM?=
 =?us-ascii?Q?hWJOvWg6vK2uwT/IAcJdFj6oEpAfGrxv0uMWNVnRPiROmxQqrlgQouzstz3S?=
 =?us-ascii?Q?46JY0JSC9v0NOxnYoNYfXkwnvnop7hbnPAMVcXt9Y9YEW+fAi/ihZpEx9+pO?=
 =?us-ascii?Q?P/JqL0rwvvhczwW0qDbdZAvDmKldgs3rJFcVTiSO0lcxcFZ+xd04Uf5nWRXv?=
 =?us-ascii?Q?CdpPzn2v3Ql5+3JB4F1ExPHm18ZOKY527wk+lZxW99pDfSsXnHR+KQQ09y4g?=
 =?us-ascii?Q?hKUXoAFs3y8TubzoVWnvR8Ep8YCDw73OKgiOW3fJKRv0EZIbZREr2JgVjpss?=
 =?us-ascii?Q?4He3UPPIZG50OQNYL52uh/sFtcUb4RQryj8PABePpGKHkG9TKsid1YlQSPq5?=
 =?us-ascii?Q?ciUZdN6oPWcJT7/IALtOy3yV3EENOYsqZAKp5pDMNYfLqkvMhRS3vnBS3dxs?=
 =?us-ascii?Q?8FBXF2g2m4QMK5fdHiNPzeNeDchv4Jdfi636+eN03Zr5nEBHcJBYUeR3xL9i?=
 =?us-ascii?Q?aNPTWHlq9++7CBu+xQGZI66NK2xM+d0ul87cASikj8Mg5oO0LB8nE8GqZoox?=
 =?us-ascii?Q?lqGzGmRf7DsNd4X4rmdNoZisST78XzUeML+g0Uc/LwhNS5bkyb3d0vSgLHwO?=
 =?us-ascii?Q?GU4oUfbT8s1lRrZs143/RvJLM8c5wfakV0uwF+ylkT/ka/3yPluJCmkLtD6Q?=
 =?us-ascii?Q?8ZTND8thTEdw0tDQml+ugucokGIIrRZeTFyTF8Rd9pzbyrBmldLiEfxMdcl1?=
 =?us-ascii?Q?hAg7ES9ITDSzoDnoSFzCQ1v3qQ/wu3a+rvZuYvtaWWCY59qzyWIp/ubXG5oe?=
 =?us-ascii?Q?99REuaPgrnSvWo6EPPE379tc4Q2KI+aC7PWI1h7Jx1py9G9FsEyBi/XsT6N3?=
 =?us-ascii?Q?qpM5Yl+e+ipwQvNH5htbA7huZwNiMJGipZYwdVcBNaj53SRDX89NOvfo4gzp?=
 =?us-ascii?Q?uZD1/yzaLH5c69vl7OEIqBnodbYOwoFSrYWn+5X14trTcfRh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f056933-e098-4764-6041-08de626da7db
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:13:44.5163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upOEsFt0bw5X05ZHIdU+RylXV0exkrEfJfFi/APUVunTSQQWVqRPcb70lHtrdGbXatcmmi0BLQ51R1UT7C2xWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614

When a BPF scheduler is being disabled, scx_root can be set to NULL
while tasks are still associated with the sched_ext class. If a task is
subject to an affinity change, priority adjustment, or policy switch
during this window, sched_class operations will dereference a NULL
scx_root pointer, triggering a BUG like the following:

  BUG: kernel NULL pointer dereference, address: 00000000000001c0
  ...
  RIP: 0010:set_cpus_allowed_scx+0x1a/0xa0
  ...
  Call Trace:
   __set_cpus_allowed_ptr_locked+0x142/0x1c0
   __sched_setaffinity+0x72/0x100
   sched_setaffinity+0x281/0x360

Similarly, tasks can be in various states, depending on the timing of
concurrent operations. This causes spurious WARN_ON_ONCE() triggers in
scx_disable_task() and invalid state transitions when tasks are switched
to or from the sched_ext class:

  WARNING: kernel/sched/ext.c:3118 at scx_disable_task+0x7c/0x180
  ...
  Call Trace:
   sched_change_begin+0xf2/0x270
   __sched_setscheduler+0x346/0xc70

Fix by:

 - Adding NULL checks at the beginning of sched_class operations
   (set_cpus_allowed_scx, reweight_task_scx, switching_to_scx) to skip
   BPF scheduler notifications when scx_root is NULL.

 - Making the state assertion in scx_disable_task() conditional and only
   warn during normal operation. Add early return if task is not in
   SCX_TASK_ENABLED state to make the function idempotent.

 - In switched_from_scx(), check task state before calling
   scx_disable_task() to avoid calling it on tasks in a transitional
   state.

Fixes: d310fb4009689 ("sched_ext: Clean up scx_root usages")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afe28c04d5aa7..aae5c5141cf1e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2619,6 +2619,9 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 
 	set_cpus_allowed_common(p, ac);
 
+	if (unlikely(!sch))
+		return;
+
 	/*
 	 * The effective cpumask is stored in @p->cpus_ptr which may temporarily
 	 * differ from the configured one in @p->cpus_mask. Always tell the bpf
@@ -2920,7 +2923,18 @@ static void scx_disable_task(struct task_struct *p)
 	struct rq *rq = task_rq(p);
 
 	lockdep_assert_rq_held(rq);
-	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
+
+	/*
+	 * During disabling, tasks can be in various states due to
+	 * concurrent operations, only warn about unexpected state during
+	 * normal operation.
+	 */
+	if (likely(scx_enable_state() != SCX_DISABLING))
+		WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
+
+	/* If task is not enabled, skip disable */
+	if (scx_get_task_state(p) != SCX_TASK_ENABLED)
+		return;
 
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
@@ -3063,6 +3077,9 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 
 	lockdep_assert_rq_held(task_rq(p));
 
+	if (unlikely(!sch))
+		return;
+
 	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
@@ -3077,6 +3094,21 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_root;
 
+	/*
+	 * We may race with a concurrent disable, skip enabling if scx_root
+	 * is NULL or the task is in a transitional state.
+	 */
+	if (unlikely(!sch || scx_enable_state() == SCX_DISABLING))
+		return;
+
+	/*
+	 * Task might not be properly initialized if it's being switched to
+	 * SCX after scx_init_task_enabled was set. Initialize to READY state
+	 * first if needed.
+	 */
+	if (scx_get_task_state(p) == SCX_TASK_NONE)
+		scx_set_task_state(p, SCX_TASK_READY);
+
 	scx_enable_task(p);
 
 	/*
@@ -3090,7 +3122,13 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
-	scx_disable_task(p);
+	/*
+	 * Only disable if the task is actually enabled. During scheduler
+	 * disabling, tasks might already be in READY state if they've been
+	 * disabled by concurrent operations.
+	 */
+	if (scx_get_task_state(p) == SCX_TASK_ENABLED)
+		scx_disable_task(p);
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
-- 
2.52.0

