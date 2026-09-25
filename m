Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8F1A6839
	for <sched-ext@lists.linux.dev>; Fri, 25 Sep 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347593; cv=fail; b=N5mrO//+7Ei4S1kEdtL5TQjAsbquBshkNu4m0RqRSvkEl+F9V23d7qJRiSEXNMNyiabGodOz9Byku3SHW+FE/0Ii+qTTi1C8efn7KYCw2mdkV0Fo79DvsIhrguq9UDB7yHy805Mqjk+BInQTaHtRDuZ+GebMbTUlWenGrkyJM0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347593; c=relaxed/simple;
	bh=aZ6ntxiMGcfUKYHwhvi9yMv3p70Zzx/SQZHeTydk6cw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PHA8QifQCEy8xoYqgvemc9N9F0jC7nv/oF1xbz0Lp4rr/GyScWJ6x4iqnWqNKcG5EyEz7VHdmxieihm8AdGn6kz9cUK/DKxLFTwolIrLglLhuK7atwRl8Hsgka2gAfWigJX17LffLMm2iOLe9TN8m18YxlNgeP25NYjy0Vb2fto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1V6QtHp; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1V6QtHp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b67c+QwzkiHHiIXdab+5Hm7G1b6clcc5tRTeRt3N1wVIHJMLfEX4e4Tk2hyZ634yF7Ao7YJPp4Znf0h2DisHFJwHOFTZEHFhB50DZXZzfh1YPPxJzvWqyI5qJAibHTv/50/Rg80tj/fBSBe3Ea6Nvxa5oFWQnWe/FAdhYZOiMv6Fqvyq2tLqODWI5RDJ+TpIgq45Nist25wPLOLpVHzhgEnDogkIKaXR8FoqRK58i0jg6bfJx4eN0jndUbX64PCBFKbOVwyQxgfHZqKqqrotDQVSgCjjifV8K3eEswp+pLYfmfDvZC2bW2wHvXfpX9dJ/vPubpi8DccvhSYT8x22NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY9fjEpQviPdpc6gSYUkf0elKI6OD+x1HzLWPeDSKRg=;
 b=wPXlKulrujFD5jzwYqxwN6vlwp3jE35S523OlR087LAkTeK6fb+1sti3v7nl6yjNFoNdWtyhjyFPjS9zFdB9JkyNOcEziEApscH6McogcGjfEXGpPbDg+rjXKtZ0A3H1gRG430eXkkYzB7Unu01wSr19pPRRw7C+YuzG4zl4AOTR0VitQ2mePuAn89iAJLzY5gL5vWeq3587KaBjab+zGyFszI8lK6ala4ZIl2XTRCHeuZPdn8z2GIp6uYeB/iZLsdF6FlpfIJOVXvH5FZz2WWjU04Vuo6lkGJhMjnEIUIz5yTONpFla/ZmLHujTD2s16rA6hK9+TR/1PfQxmWj1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY9fjEpQviPdpc6gSYUkf0elKI6OD+x1HzLWPeDSKRg=;
 b=b1V6QtHpSnwAbRAik8OLiBM+azPRHHMU1gxTHBC1k6TNXReSMyghTCQw3Eu7PpkMqZqI5wipFdc2PDW2sxZ8bKDb+scUpC9omETtUNnm/8Ji6r+Dk/Awmh1FIOhKZAn3HNU+GIex0lyQHIteW5thV0KnYPGBBZhqC+l5qYk8Kk/IHbI9nQL4Hlp1V19qrw64RJH9dSuL8fvrA15hsyytW6OHYFEOqn2lqLI0PR7kZkTMaNWi9iBO6BCHndjqIHJSGOzrtI38zoxSs/tobX7LQD7s7A2kFJ3c5dbz6/4i+gZ6Zur4SMRMG4FLFnyZ615p2Vxej1unf/KGRx2GF6BXbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:46:18 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:46:17 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.4] sched_ext: Add a CID NUMA node lookup kfunc
Date: Fri, 25 Sep 2026 16:46:04 +0200
Message-ID: <20260925144604.2451177-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 411be744-b415-459b-ec0d-08df1b13c16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|5023799004|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LJ3c9dsE5FRTrXbV93tkBB+bZtOWYgQ2TSq+4ZkfzoyqykC/Kt5VekppI7thPvxJFBIsbjOcgw56DBKnMhQrVESlUQVVRSp+A/C+xeZejLFw5PRhtUmG6CjyFzYHrJLK3HrWY+zo7SvS7g7kNWY4S8kO8Zb4na1a9bkbwZP6ZrmHS9rio8SgnOQgVYat6V/LWqUTnqGuJn66JFmzCezhIloFOZYlU1QOa4rlTPAPf756VC92MR2EFvxg/mrSNVtdbTiS6HApmghZIaNvb8svZ4dQa9BBtaRzTrE33phFeI7RWFLUx3lHBw6sZpMJdVn7dhNloBtGJkuWdoZy/0y4JjfZkq6c/yfvITR8nOFybKHVKHbM6c1KjhJM1EbXtrqKW8lMxYBCq7eZ80ZB5tGKyRjxW9C0ko6pHuV+gSwoBndsCY/cO/QyP28l1BDk2ecMpnY26DJBSpZDbQSKRvqhvNGvaN7P9911hX1kHSzGEz8nk892i8XJyyCY4kGHQOGD32+rnsF1jS4r1t6qEruoE6reMXOJteJhLN8T4exKwlAIkTh9JhSG+pLOw81Z8kelJOxhc3BkvbnS3W17wW8Ex7sGqIasVeDfy6y0RITPwv4+n6C64S/GX92jlTUEhTDiSm3OZI/XkUkTuLuXiTOtQ4MUl+lHGzTPFzJ85gMPSZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AHT+SWxkTP55552k+GaSaOugYSrUMYGn3csGbJj7WMRovYBanJ11gDha0uZM?=
 =?us-ascii?Q?r7WIVpNrMMnOG2wHwpxwa2EHL1+BSj4REqFfeW4DzR3vxuLX03GResedvubV?=
 =?us-ascii?Q?IhGrgO+R2/05dYPhVf2MVJDYhqnnU6sxWCrFALlcHndmaUK9NbgfR8v9T5Tw?=
 =?us-ascii?Q?A+/QhJiL8Pe/2mgL0/ammlPtNfE8YnevoM4+PZGlT2wZknt1bwGnU7VrqQ0E?=
 =?us-ascii?Q?0n+nJRiGzedSiwxMbzsB6Sm6CmPVBoIl8Lzhrrb5CzlEyjI/UNxykDnVrmUj?=
 =?us-ascii?Q?AFsB1pNAFi4s+tEWw+oHCHrSP5hQW2oIHKePSI8cxonOh3mpqkWL+1eXce14?=
 =?us-ascii?Q?cWDQn6fLAOAgv+sFOgxusnWLUNzu518bwwVvnJj4CjMVkzhS7FWI4y+HKMnR?=
 =?us-ascii?Q?9rMWI+ltuS4+uZV6VbGFfHOZEXNMwbkwRLCfLKbfia+uz1Pz9f2Gv5XChYvk?=
 =?us-ascii?Q?X3y3301cZOQaFPxyyVIZQsOyuzihthHxIrM/pyQt7oqiUJZKL7VLaZ74KKvs?=
 =?us-ascii?Q?1YL7Lwq1VnGWu9+3U5FfES2fGpeL/ItZRKAsss2NiEldExDPujzDNA/WVZ0j?=
 =?us-ascii?Q?H5X7Lye/QSmvIIF2JMSkEx2tZWrpUnK4CueAc2tP5wZC6ENCF4j2RllChcy0?=
 =?us-ascii?Q?23mkjvejHYs395qq3E9Huo1IcijiML3YvcJLbEJcirRSWLqUaXnp8PpwYgBi?=
 =?us-ascii?Q?bB91qBmyJAJ486Xlywaz/P36+JPMueqJBzHkSStOcX0lw85tU5KS9oWyaj9T?=
 =?us-ascii?Q?wvo3MPCjSSMknGOZlIve1klp1kVyCx8Ua6Atj+TXpJMAXjc5BL1H8NLT2l6I?=
 =?us-ascii?Q?s1khKxwbjYd3+NEboXRHGaa7qa/WnbAIZzB5bAbx6ys7EDGz0DpKOUha8Vtw?=
 =?us-ascii?Q?Fr9EfM7/ZuopQsdiThcz/pBx26mQ6xYo/rr81k0oOdxon2/VzaGYTW0QLZyc?=
 =?us-ascii?Q?sk5/XtilHIhuRoLGlOCzmOBiFED17qN3ku4vQt65PGryoA+AQ06RXIWwrEAw?=
 =?us-ascii?Q?ZdXpr2wdSDQpKwYh3y8wUhbH2ohSxqO8iP2WVK7GBNmQsGGNoRBmHCYTmZBA?=
 =?us-ascii?Q?iTmHGpl5qqGXYp6enuSEAputuhuyTziTb9RpeIRDzOnJTKvExoCQuaC7cdTK?=
 =?us-ascii?Q?QIrUMnot1mBlZDHmUhK7PlA9N9Qho72SveXe3GorRodHqU41qvzxW9OLSf0/?=
 =?us-ascii?Q?EvhJ+XMmhRwq1hReAAV8LzM6h+/RRsesn/GZGyM7l/HDB3Wf6Lgp+PCS1RbB?=
 =?us-ascii?Q?yWy6A/p3S0dGlVCaFJuE+/7ENmaOYdKxPhngZTVY2La87cc1cnshdoQfsA5z?=
 =?us-ascii?Q?ii26rLj4rgh3pFkuYbUqsF3DEVVRoVhe2nNAdl7T8AHR1QtCG3PR7geoq1OZ?=
 =?us-ascii?Q?5tnRlcZ3aVNxkhsvZSs+N1CSfENKazRgEDLRkC6QFObAeaQe1zQPW10zjoXr?=
 =?us-ascii?Q?Ocani8H4KnzXXI/AhMR5mYJcFJqarYjWJL9uvjEoimH7//rqJXj6YhPKb4W1?=
 =?us-ascii?Q?N+tpRqVIRbomL1BOzddFXuLCxleIRg4g8zmA6Ir1K6x358yEqe/1ZTYI8D1c?=
 =?us-ascii?Q?sobOKvK00KvL3HYzm2Q6oXHeH4uL+2H8qG7NgrnWqQQd7yNnrJeL8UVYn5u+?=
 =?us-ascii?Q?El6/kE6tcL6jNqQOTFxL84jOYWFlKzS4WSeMYR5R2OfKWaXtDDCZ5CS/TOA7?=
 =?us-ascii?Q?Qcj4YzXVBAd1xp9ZHcqjVckcNEDfErkAERB17l6gbdJvGa1tRiZ8leP9svZU?=
 =?us-ascii?Q?If+bn/suHg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411be744-b415-459b-ec0d-08df1b13c16b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:46:17.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/fnk4swo8ZeivQVS5+STij+O8dLew7mBAiDqhxnpMbNGAbm0CeyQHel8IQGGnOjzhknW4qAvdpdwnHFj4AJqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721

CID-form schedulers may need the physical NUMA node for a CID, for
example to allocate arena memory on that node.

The CID topology's node index is not a physical NUMA node ID, and
scx_bpf_cpu_node() is restricted to CPU-form schedulers.

Add scx_bpf_cid_node() to return the physical NUMA node for a CID and
provide a compatibility helper that returns NUMA_NO_NODE on kernels
without this kfunc.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/cid.c                   | 24 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h |  5 +++++
 3 files changed, 30 insertions(+)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 39f88deb94bc4..932f640ccc2d8 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -640,6 +640,29 @@ __bpf_kfunc s32 scx_bpf_cid_to_cpu(s32 cid, const struct bpf_prog_aux *aux)
 	return scx_cid_to_cpu(sch, cid);
 }
 
+/**
+ * scx_bpf_cid_node - Return the NUMA node the given @cid belongs to
+ * @cid: cid to look up
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Return NUMA_NO_NODE if @cid is invalid or there is no scheduler. Unlike
+ * scx_bpf_cpu_node(), this kfunc is available only with CID support, so BPF
+ * schedulers can use its presence to detect NUMA-aware CID lookups.
+ */
+__bpf_kfunc s32 scx_bpf_cid_node(s32 cid, const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	s32 cpu;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return NUMA_NO_NODE;
+	cpu = scx_cid_to_cpu(sch, cid);
+	return cpu < 0 ? NUMA_NO_NODE : cpu_to_node(cpu);
+}
+
 /**
  * scx_bpf_cpu_to_cid - Return the cid for @cpu
  * @cpu: cpu to look up
@@ -952,6 +975,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_init_cids = {
 
 BTF_KFUNCS_START(scx_kfunc_ids_cid)
 BTF_ID_FLAGS(func, scx_bpf_cid_to_cpu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cid_node, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpu_to_cid, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cid_topo, KF_IMPLICIT_ARGS)
 BTF_KFUNCS_END(scx_kfunc_ids_cid)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 9660b43d612ce..41342f1bdd311 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -106,6 +106,7 @@ u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
 s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
 s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
+s32 scx_bpf_cid_node(s32 cid) __ksym __weak;
 void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
 void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
 s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 7d870331b2a6b..c5c90d1d81e04 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -243,6 +243,11 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
 	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
 
+/* v7.4: Add scx_bpf_cid_node(). */
+#define __COMPAT_scx_bpf_cid_node(cid)					\
+	(bpf_ksym_exists(scx_bpf_cid_node) ?				\
+	 scx_bpf_cid_node(cid) : NUMA_NO_NODE)
+
 /*
  * v6.18: Add a helper to retrieve the current task running on a CPU.
  *
-- 
2.55.0

