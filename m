Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C630E0C0
	for <sched-ext@lists.linux.dev>; Mon,  3 Aug 2026 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737396; cv=fail; b=Bhb5/cTL1kK9+X8uEtRk6JHIN4GJSc18zWSHrC/7a4GtKw0fP9FaqtETCct+6Bt7vCXWaI217nJflqsBTHmlLL9GqfJlpPftzWMQ9d5u0dfgVsXAwupDWaAFKMXVkSD2ciRVMgKItDYqb/Z0P1JCwmC+KTEof72TwYDiUBc4iFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737396; c=relaxed/simple;
	bh=5nsI47bNkIR5yAxxYStDZetHqah/zNbOlFKHvuhD6U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4Knt8LJRHP4POL3BXOAqk83KUZoEcCRYAvbE3SrOf+1PL0huk5F+qWRrbVwo6RvIf37ZfE7te00Ey8wOj6Wtw2fPj2cGIsDFAz9FhkcpRdL1uLH3l2fae6oP35jc1m38Egtr8F2OzIZ2pM3EZuCGfcir4NEsCpckLChDgRUO4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bxXG3yF9; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxXG3yF9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glFr4GgcCiODI1BZG3jiYFkF6Gf8HT53A6emW8/j9MEb1LZTfyok329u/MU7qw/cfDYQUT+qkHRn8b1sMH3PBa7eKN1/V87x8RWL0n0WOu/zRzZBpwBiWf2v93fX2eSeA79g97kZSXR1E4z4EluzwFxW09LetT6P/nzYZjluFVGt+bz2Fv6rH2jWKo4XRd/xQhMZqGuTeTfLWcZd+NvfDvmdGmcaWJXJV+UK5RcGpRcktE5QFgT7Ul2nmkFHTzeZModywDhc3tq0icksRuGrscgaCs8fk4r9FLiyE48SjiOWmuoJ6a/ZSA9HMjw0EUF8IF8gAhxV6P8BSDDzuzSw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjUU83kZia6yUgwG1bcElLsuwy2lB0ZiZSxzFR5dQgI=;
 b=CFoxMj4WJ1oqkAaCgD5B9T/lD9sSydEHwgwjqufAgIsTVClAjCxIBqrkF5hk/SErIX2K+mzqNDJPJopIuPKECCqiPA57HI63nZYBBo8cAbhQ9GiOJC4eyGz9byEzEuyGdIabkV6VKPKNFOL5GmEnGHV27/WVN5lOCzNpz8QgIHeytFZ2NRR1cBrxGGR0QmyHN6JHPmYphXzDWCffJW+ou7aElsCRR8T+5udNkeeYA8NwcvRL/qBGpHPesw6XcGuJUmDXC0ChkreGHW2e0qzzrdcCD5yyF5qYEN3Hw/5JiTDSZ+YCtLJGV+pTVH9xRB88A5s/y/pN5Z6CybppwXSamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjUU83kZia6yUgwG1bcElLsuwy2lB0ZiZSxzFR5dQgI=;
 b=bxXG3yF9CPxQW/YbDZeVV6NjOqkvjUn+oPTLpAbu8QdYfeDshNeImv7vN9jfFLkAhBctr3VE8ZPrUopQULHHqLFPbm8u6TvLWUWjFzPJMQoNDkl1upmyHNO+q5I2gFqSMibGsS6okA0KiJNp6724Mgwbhb/mH8CwsnqZxGcuJinLgj8kbhNLB3jbOc7Hznj3zhZ2egbbPmeIlrLBi++MC5DNF+5x+Yaq58GzAUxBKaOBtRR+Xy75RijUbpkdANGszxRHB+FstyBSJ5qkHq5/yqVVHHvpFS4RUSTbdj0iEg6v7xZ7TuuZPSy6z0eylSfhz0y4YZjEgh3Sbrdx+g5+og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 06:09:50 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 06:09:50 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Make allowed_cpus idle validation race-free
Date: Mon,  3 Aug 2026 08:08:13 +0200
Message-ID: <20260803060930.4111746-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803060930.4111746-1-arighi@nvidia.com>
References: <20260803060930.4111746-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: b3af485a-e0dd-49d6-e6ee-08def125d3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xGdWxgayQpbsBDb1oI6u2CVIieUdM4jcPL0dhoc3L7d7YM5sCjqDTd284KzYctgWSSLM2g9iZPLE8FgC6SrcLVTlVxzcsD3D8pO6uyJd6IJKmHvVmDGIT2ghW1lCVNtRtw1vVKn4BGWQ4hZ7M8dLj+oY2Y70xazo1s/Qo/nvQXSZOvC7ctNqKiGnR3qiHufVKOCuB3agKC7aUFtZZ3oU8pyN+SRoTG/nflc0cOKwgneqf69yZAGOSheBlB0Z+fqQ/hEeAmSuGk+RxF2zSStUxAgiZlT4NymOxMtteeTHYwVnhCfXJZRDVH0e8Z8mfrhxCpu/FUm1isfhedaGEKYlUwiNHDEcoc2GqaB+o1vULlXOuW9QEgmwBsqfnd93p3nOx1oDxXnIHtCs4q0qMEQjD6l1Hi2PG0rGdo7R/TnXqQSamQMHYJMeGO6AT5nidavRDksb+hV2ZvZUBS6dHrNiQBIUwoFdP6xYOaf+STjr0yr5Y1po7wSJb/OvfWqOJyn27Riazhjld4qrCtBM5XSOLaAmP31q0T5wCOMKhaDU49tjno65M5TwjDhFP6Ij76E4Apmrd9t3k6oO6d3wAucjPpQ+W/2Guu5vING/+rwUWAmhIHaTxYZlWjKkqx7HfTLOFuc6+5F8QX3wDYkOI1/uQ8zFKb5mymvK64INAyIEA8M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W9rYV5P/tdveQe9vce8NtAT4zHOKuT7qI+NU8pGO/ixsgYhWfLjMMp5k9IuP?=
 =?us-ascii?Q?ntFzmefZc4x9y8KEeB5baOJ+o3kg7D6/mTJgjE/1sd3tYbT1WHHIoHnHEMRa?=
 =?us-ascii?Q?EdMH9W/3eFoGdPiaygaM9T2k/ZGn4JDecaKYPKcB5i5w+qvpmpKmUCKG4QRB?=
 =?us-ascii?Q?/iBON7V+mwm10+KmRVLb8+Crx3arTJULIT90zKBDQqQas7yBUcwmYYZlrf4p?=
 =?us-ascii?Q?I+C3veeHnyGXp/Hubnqh3cd4t7dfQ0ktGNANtiVMYTdMTgBnQ9PtlgtLvNPY?=
 =?us-ascii?Q?k1t+Z+ArTyunBlNT24vbwJjmkWeBysIvLBE/en83GA9cdJEW9f+BBBS2ZjWB?=
 =?us-ascii?Q?n1MzsQkbqr3/5Hzh5tZd0VjSHg/0HxKDNuGXeaC2BAmcNK+7l9YYIqktlpA0?=
 =?us-ascii?Q?GvmdFHTj1MnTumgKu228sDL++3DjOLx9Nh4UWa5B26+vWwb3/yfB/3fqdeDs?=
 =?us-ascii?Q?dfgTihtdViIqQMKV2RYstsfL6ft8O4o/7tdZ4IERQIuCsk94lFCR4NVfCimT?=
 =?us-ascii?Q?eyCktKT/U7qcdGrf9tf08JvYMh7JMLYisuTefxaSDok4nwEj+2SbNy+AjPDE?=
 =?us-ascii?Q?8Fi2sDMhtMFga/ptuq7VYGz+LvQt/dl5Fl3hHuleGM/Fm33hMqwYKDPLKIYX?=
 =?us-ascii?Q?ujkJqXER3zftRrrXsGkkCekn6TcF9Zyx7UiO/JhIdgDk4TEWbsV+isULcNbn?=
 =?us-ascii?Q?wmmSqHsBALH/U2VYDY2APepRhH0ZLvDU+2kcSUmkWB9X6Nwn0KHUgYjULOk2?=
 =?us-ascii?Q?DVDkOyrOcirZka9U63uqCDSPgg6E3dRJexVEq2TSmTjCcja6uKGFAJdo11i5?=
 =?us-ascii?Q?S9Ohfu2dHWq2qFFVAG8c3DSgBYiYybvcAHrlkm9c6SNnu99Fay+ayB5xk7x/?=
 =?us-ascii?Q?MlrRW9KlvxRTpP5WYv+5wHOsofNxpA+C2P1PKwqhc6bEinF6gEpkLONHMIUD?=
 =?us-ascii?Q?Kn0cm/WCzGVG12RKanmRz1aHCeaKrRGGm4Se3tFNPhqb4nEqkd/xpFk5pSM0?=
 =?us-ascii?Q?GYXVG6fXPis4mLpFlz0OW83nocGPXSm7SQ/VxzGogWqRL8zJffit5kEJw5hg?=
 =?us-ascii?Q?r82BNGIfJ258/BU8oj253ag41QCEaejkZIGoawJAnLQtcrCeEvyIGtW8cMG7?=
 =?us-ascii?Q?RhjmAloZ3eKV2ZBIfjQ3j3rqHpijyyOhkR25dk3HaaioHF9WAZtkE4Znx9aa?=
 =?us-ascii?Q?Oby/+rgJAMkyJQ+j9MqcjifI03w2jbfWoxxZhWJz3PWyS8pHQApyGGe4+xyt?=
 =?us-ascii?Q?Vx73HhjwVhZa+W+Hcnx9MMB8E8TCxUZHvtSBkp5PpgPiy7dVnZKGYM81GJ0W?=
 =?us-ascii?Q?b6y6Z673YrU8JHjsZ2mhIf0uMxBTUCaif1GFv6JfyYDY/LNeXDF220mWqi9F?=
 =?us-ascii?Q?WMTt+9lcXYhYHMcfL1wSrQoFBwCZ5peSRyuvkv6JQI9tP3wqpZfs63zhqUWT?=
 =?us-ascii?Q?VXdPolDYegK00+UrDGPlLPRLilZUa2D0QIxLDPl8uYIhJWF6smv6+F+LHdXE?=
 =?us-ascii?Q?iF9VUM7tS3PBR0X+kh27t8zCUOiB0Zih3B898dLJx6ZFuiVJcBwIGFgbhfRI?=
 =?us-ascii?Q?ewy3kvFcZB3TeVbI8qgE4vBUePU64Ck0NpoY6FjfnUsilKERYdHmMpKbrQiL?=
 =?us-ascii?Q?oIe/HtRr0njL5M75IcswqVDqpNStgICjUj9t7V/GlhUI0KMsnQX6mublE79s?=
 =?us-ascii?Q?NLYY4SxOneHSt9OvNWmoXZf6QgbovUZZ56UnmCSYn3F9IpzcyVbRCml+VcnF?=
 =?us-ascii?Q?IgcfMa1EJQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3af485a-e0dd-49d6-e6ee-08def125d3d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 06:09:50.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHU3D5/9YWCtPnDh9ooe4GfB0YioZaTI9p3vQSw/LFrp9+tFxb7k0Ac5WUcYKgA1hsjR7uDxAtPT54N4bSUJIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300

A remotely selected CPU can be re-advertised as idle by an idle-to-idle
re-pick before the BPF program validates the selection. Checking that
the selected CPU remains absent from the idle mask is therefore
inherently racy.

Validate a stable local invariant instead: a CPU executing
ops.select_cpu() or ops.enqueue() in a non-idle scheduling context must
not be advertised as idle. Read the idle mask without modifying it and
also validate selected CPUs against the requested domain and task
affinity.

Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 .../selftests/sched_ext/allowed_cpus.bpf.c    | 49 ++++++++++++++++---
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
index 35923e74a2ec3..9dd72d0da29b2 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -15,15 +15,48 @@ UEI_DEFINE(uei);
 private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
 
 static void
-validate_idle_cpu(const struct task_struct *p, const struct cpumask *allowed, s32 cpu)
+validate_local_idle_state(void)
 {
-	if (scx_bpf_test_and_clear_cpu_idle(cpu))
-		scx_bpf_error("CPU %d should be marked as busy", cpu);
+	const struct cpumask *idle;
+	struct task_struct *curr;
+	s32 cpu = bpf_get_smp_processor_id();
+	bool cpu_is_idle, curr_is_idle;
 
-	if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
-	    !bpf_cpumask_test_cpu(cpu, allowed))
+	bpf_rcu_read_lock();
+	curr = scx_bpf_cpu_curr(cpu);
+	curr_is_idle = curr && (curr->flags & PF_IDLE);
+	bpf_rcu_read_unlock();
+
+	idle = scx_bpf_get_idle_cpumask();
+	cpu_is_idle = bpf_cpumask_test_cpu(cpu, idle);
+	scx_bpf_put_idle_cpumask(idle);
+
+	/*
+	 * Unlike a remote selected CPU, the local CPU cannot go through an
+	 * idle re-pick while this callback is running. If it is running a
+	 * non-idle scheduling context, it must not be advertised as idle.
+	 */
+	if (!curr_is_idle && cpu_is_idle)
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
@@ -32,6 +65,7 @@ s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
 	const struct cpumask *allowed;
 	s32 cpu;
 
+	validate_local_idle_state();
 	allowed = cast_mask(allowed_cpumask);
 	if (!allowed) {
 		scx_bpf_error("allowed domain not initialized");
@@ -43,7 +77,7 @@ s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
 	 */
 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, allowed, 0);
 	if (cpu >= 0) {
-		validate_idle_cpu(p, allowed, cpu);
+		validate_selected_cpu(p, cpu);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
 
 		return cpu;
@@ -59,6 +93,7 @@ void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
 
 	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
 
+	validate_local_idle_state();
 	allowed = cast_mask(allowed_cpumask);
 	if (!allowed) {
 		scx_bpf_error("allowed domain not initialized");
@@ -71,7 +106,7 @@ void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
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

