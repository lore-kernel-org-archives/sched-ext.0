Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595F489896
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488652; cv=fail; b=uO6euRZfhGLfAGjWTxdT3gfdzLlCciFq6dZ7Tz4NSfGNoi0zlO5haEX+Htz38eh9bEtDhcp+UqOJqkLzyP2vvtHU8jb0L+mj2/lAorqXUtuz/fqtAIRluBHepV2eRVcP0GibU1zDW1RBXH07xwY+DN16xMvjU4+WCSSdk2csJcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488652; c=relaxed/simple;
	bh=8LeIh3WBc7IlfcucTCDNsLTq+pHscrqTlXsdBHc/v7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ai5I2gkz4BXf++ZXJ4ONPnVOxPA5HhIpeXPdINSQQMDhJAkqZUMMlgqFGoWdmtadqIoHiapTDIkKYdWTqvwKwk09i+cWt4Yo9A8wSchq4jefLFbjHhTjHsYfL0gR94Yq5L5h24glBYfwZYVx2oysiivvlnW/WlOg9qrZhWeuWG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nM4IeTMK; arc=fail smtp.client-ip=52.101.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nM4IeTMK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTHJMRkYLpspRDuBZy+EOcvBKygiRGf/100aP7QBu+j6U4fr1mZUWAgl2rnPJFpYf3mtDp90ZbQH3nV1GZY66FN96befPIqCQhS2i3hBtsKXFtntJszGqeZ4XM6FPdbpLEAW0pk1QjEPa5WBtgoyCfr/l/txkmcxDebqDkLh661B/ubVHMadjhKXAXrc1NaORvKcw2JrzrCxfWSscgfPdBGMmb+xD0XmbUsMNN9iJ6D42O/L3UYxVQZWpwvVGBIzLdYgy5Gxa/86S5sAmoVCBryDqfF31upFEmOGkbSYfnIHtdi6OkiPXc+r9w3NKtrrhUhc9VBtVcB5mjtSicKoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrr7ueGZD2QZHd6AnJa88mEXzgLYoUxeRoBI5+lCG4M=;
 b=IbPyVTj9LYpZM/b9iZYV8NRixkRoMWAHmkEv2EQT/0O6ILRgilT+YiNWqdGEg8VH1FdVSiNVMNxf+rwSRkVPSAWQ0vzOFX9XvSkpWzljq59371o1sfcYcwDJfaYh7cUXYW8hTGX6pvKpTOe2xxMGs8nhuj4tMKNhHS8/axNBZLqLpT8shXpmBNqtezbuOQQ23v2TvGA6iq6ueyvg6wapO6k9mq1aVIm7cLRoSP7DZyNZxTTf+/7Q3GfrZjXcK9PDKM/rG+h9PBszxLmYLU5U0KozpTaG2tLCXskbsZsVa8b6qg+X2oE4yxvdquxQ/dJyc+ulnnt7ZwvUtnx0igIVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrr7ueGZD2QZHd6AnJa88mEXzgLYoUxeRoBI5+lCG4M=;
 b=nM4IeTMKnf3SPpCbcccvYXDJv9gPCk884Vz67tNwUlpNLe6A2W+5EYglPMAVwifZKzHzLb0jAd+E/ulMa5cg3/VKnNk5fohAhIb1zxVI7J896LwGbzSBkisbg16XyZWfNeuRaTmOZevs6TlJ6JB8DzEZcLbTAeYbgh/u8tljQ+rjUh44hv6KkUWTvA7YrBmFTG3KvTFfgQiLASRPsl4QzPVQzSmzLXUUiGN7atDNlYdmPXnkTDWQLKTZkibMAKMdMtBf3KNJ3W7muhlNX08kuBC5J9wN2Ee9Ua7+9vAyTQkk6Fi+IMCos9x/TAAAdTcmUGAClZ5tDNYqmJafK/hQZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 09:04:06 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:04:06 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Make allowed_cpus idle validation race-free
Date: Fri, 31 Jul 2026 10:59:49 +0200
Message-ID: <20260731090334.2911948-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731090334.2911948-1-arighi@nvidia.com>
References: <20260731090334.2911948-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dad8a8f-5f03-49ff-bf6f-08deeee2acc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tu3mZ/EkVhDrLF3YKlpTSECvOanNy63JJHXbx1KtxN7xT/oy+PRFtE6oFYNrYgyzfeUlsxAnMzQTcbsHe3ypgby2rcbtcsFJjB+vLtnwW4a4chBmLi77VqFW/8VaZSZkCyg2OJbVT7od/pvF5YmKIjBEfjPUBn0S5mxhZLoEnTegpDhpwPNO4+km2jFZ/AGIFdbhDWK7dfv53ALFX8Y+aNsZcl02Ol7rtVkOCqPfx4QYO6HwXlKHq4PBZoYE3Hs9m3SiNrXOMGWM7O1+VObk9LGhglMcFhmemGfBk35nXEn7llMnHPOMypvSTK2u/i2tU83t3SUVRdGWPNo4rmR/jT3dU+3de5jgx0JJh6hMBHVLAECtRxLw6PqfYqgIn1wmaZKPQS+AEaYByQmfH0xkvbrYt0mzv2m+KQzL2rPkMupXky7D4iAa6aa7YaRRwG1ZnmB/wJ8lu6rjSr23mOs16Hew77oV+C7aGsfSTA08azWj984zciyw94zh/gDIjTLhQXwX2QdMHpRUMJZTmdhTKoQnuPzse7OP6jfrmF2ABUKPmZb4dYMI3UwR2I5TRsuvT1ke101XpTMyKJRq1R/FFwNUZUjlc2vRdoRpBin5hmi5HtHv5zbGe6llavBVomIt3DqNBY+8zKVDgWtgwnAF72if4Uv13tW7h3FGFbFc1o4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WCADDPdUud5Y5w2XvaJylCimZCQEssdWmQ0jcwkrD+Octhf7eqRBxvjsu4NF?=
 =?us-ascii?Q?+hM5sv1uZBwWoFlNPm4kG0sQCgOhCThhdfTffD0Gyclo4NEWpvPzoNr+gEjS?=
 =?us-ascii?Q?H/K74Qke1Li4F4O/iuHYszPLoQHaqarrksnfRLxUz9P+yQz8fmyvaqIojhoP?=
 =?us-ascii?Q?cj1T3peFeGo5nkcbfxT7+/C4sp6ooH9E78cs3U/UQlhHzLjvkgHB6VesWcOk?=
 =?us-ascii?Q?aSlqbXTQ6XbUsKcfZnhKrGBfmky7tDLFrs+E5+8nIZNG/O8tkx34ckD4yUPO?=
 =?us-ascii?Q?p1GUIcEwrFPj//nQY9dEQgW+h3pnrC6WO4B7RF81ZPT4PdT3DK75m4PL5TBW?=
 =?us-ascii?Q?3/2ghToCa0kyapbOmdqxiJ73C+HpeXPyXYuf7woTQM/a3YKjhGlskFRHfqfW?=
 =?us-ascii?Q?FbHjbZkiUNNocaB3g3DBPMCAVmxyaNnSc8o+lAKpiDyJNeANxBJpbueG3nwk?=
 =?us-ascii?Q?MCyECzOSd3wWO7kGI7UdMq1lR+H0ot0GfCISQ7bwmqi6mAbRGRPeXU3vFh9o?=
 =?us-ascii?Q?+q6G1fEDAFYOUNTfGE6dYLLO3uq4O8hRF9p6dLNfsKGRLyFma3TghdonjrLx?=
 =?us-ascii?Q?SFzDFcz916UDAfe5VSfe2YrztvjBcyPNZI5q/vYu7r66WkhedE3Nh2k4r39b?=
 =?us-ascii?Q?xUKFIODTy4Gy0w5IdPss3HM03LsWERsmYLb1CzzzF/8gyc8YmAdKXCew2fOy?=
 =?us-ascii?Q?cljlonAsp5M0LIIq4Gi5chZhoQUUkLxLPAZVi9gHKXNzssz4c8pudVwfoGYQ?=
 =?us-ascii?Q?nc+O5FKzIyj/WuuF+cWeAvQ+dqhpipEjTvoFfBAhQt34aZAyiFGBFGZJN9JP?=
 =?us-ascii?Q?OK/R5nTvIIr9Hm5wGa6HPExXdIpNmA8p2iBWrYV1dHWC8ZywgncmDRTpAUvo?=
 =?us-ascii?Q?gEHasbdS9etA64a6qS+1uYm/8+CoDnbPr/jigvgjB9/d0WeWb8xpEzK4Vn8l?=
 =?us-ascii?Q?gtQTgaeojlQ3IvPtmcSenZjV32U9oDBRVph2NUGVutFnbbBZO9ld385xM70g?=
 =?us-ascii?Q?je4O6zswlX1MRjac9/Nx+swmtTT91ZvZgUt8/cT2dlbqWdmWjVtGxvATpV+s?=
 =?us-ascii?Q?4YNB7ka39Z+e3jBHFEdtvAAgbGLnf9tYGR/1VE32z4ypBd7DMBI2TBsIfdxI?=
 =?us-ascii?Q?dO5ef8o70Tobz2PcKJeayaD3OBJpx62pS3ar+4kCLwDQkYgvs3jEAjawrJy1?=
 =?us-ascii?Q?9v82XLrbEgfnOtDhFuz41y86aqrO2nPXc+N9BPvyU4hXDU1BPhFSAHjmpzCA?=
 =?us-ascii?Q?Q8r9mUEcITnLXZXZnxJil8KZwGlV58bW8L4HjQ30FD45ZL5vupbrYPgO39YJ?=
 =?us-ascii?Q?XIagv7YZbqBUzJWA4wMu0+l2i1Mh89XwFOSLNPs0MvxYrQRi3NBM8fop6Zw7?=
 =?us-ascii?Q?p4tR+do35/ND2asj7jTLWIfNUsoEoUew8j1H9/qyt8aJI9pNgyOFmYYOPjFV?=
 =?us-ascii?Q?K6Wx453qxjQFi6AxPcC8s5EO51K+8d60oAAttlTJyn1eDzfhkvxjxML4wG+1?=
 =?us-ascii?Q?UbOgUzHzCtfEuiE3l3i6P34jCaFV6kmM8Nma63J8hTDRbTfGBfgqsrtZPzrJ?=
 =?us-ascii?Q?4BQxeKluDMmy/oHz59W8nAgbB9EVIkYj644C6T/s7UKyrBBGPE0BFatvIkNp?=
 =?us-ascii?Q?SvxToX0QX0owtzkpa1BHXidAgdrdcJThRQ96ohIwKc0eBGGOGXAJ4swYCazW?=
 =?us-ascii?Q?uKJQRTqarwrHj0hibitkYmQqmEvIxyjIjzdMj7pi4diq1orziZbk5LMwzSfE?=
 =?us-ascii?Q?dum8oUqN8w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dad8a8f-5f03-49ff-bf6f-08deeee2acc9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:04:06.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNFvhauvZQSqj4V2R34ud24ILin3w/eIb93rVrPQ5WMP6XzYSTVJ5BLOTii46fjtV6ZAmL9xUGmNtsQfvssCBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961

A remotely selected CPU can be re-advertised as idle by an idle-to-idle
re-pick before the BPF program validates the selection. Checking that
the selected CPU remains absent from the idle mask is therefore
inherently racy.

Validate the stable local invariant instead: a CPU running a non-idle
scheduling context in ops.select_cpu() must not be advertised as idle.
Also validate both the requested domain and task affinity for selected
CPUs.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 .../selftests/sched_ext/allowed_cpus.bpf.c    | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
index 35923e74a2ec3..411a7edcb9605 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -15,15 +15,43 @@ UEI_DEFINE(uei);
 private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
 
 static void
-validate_idle_cpu(const struct task_struct *p, const struct cpumask *allowed, s32 cpu)
+validate_local_idle_state(void)
 {
-	if (scx_bpf_test_and_clear_cpu_idle(cpu))
-		scx_bpf_error("CPU %d should be marked as busy", cpu);
+	struct task_struct *curr;
+	s32 cpu = bpf_get_smp_processor_id();
+	bool curr_is_idle;
 
-	if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
-	    !bpf_cpumask_test_cpu(cpu, allowed))
+	bpf_rcu_read_lock();
+	curr = scx_bpf_cpu_curr(cpu);
+	curr_is_idle = curr && (curr->flags & PF_IDLE);
+	bpf_rcu_read_unlock();
+
+	/*
+	 * Unlike a remote selected CPU, the local CPU cannot go through an
+	 * idle re-pick while this callback is running. If it is running a
+	 * non-idle scheduling context, it must not be advertised as idle.
+	 */
+	if (!curr_is_idle && scx_bpf_test_and_clear_cpu_idle(cpu))
+		scx_bpf_error("running CPU %d should be marked as busy", cpu);
+}
+
+static void
+validate_selected_cpu(const struct task_struct *p, s32 cpu)
+{
+	const struct cpumask *allowed = cast_mask(allowed_cpumask);
+
+	if (!allowed) {
+		scx_bpf_error("allowed domain not initialized");
+		return;
+	}
+
+	if (!bpf_cpumask_test_cpu(cpu, allowed))
 		scx_bpf_error("CPU %d not in the allowed domain for %d (%s)",
 			      cpu, p->pid, p->comm);
+
+	if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
+		scx_bpf_error("CPU %d not in the affinity mask for %d (%s)",
+			      cpu, p->pid, p->comm);
 }
 
 s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
@@ -42,8 +70,9 @@ s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
 	 * Select an idle CPU strictly within the allowed domain.
 	 */
 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, allowed, 0);
+	validate_local_idle_state();
 	if (cpu >= 0) {
-		validate_idle_cpu(p, allowed, cpu);
+		validate_selected_cpu(p, cpu);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
 
 		return cpu;
@@ -71,7 +100,7 @@ void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, 0, allowed, 0);
 	if (cpu >= 0) {
-		validate_idle_cpu(p, allowed, cpu);
+		validate_selected_cpu(p, cpu);
 		scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
 	}
 }
-- 
2.55.0

