Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712729AAEA
	for <sched-ext@lists.linux.dev>; Sun, 26 Jul 2026 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048488; cv=fail; b=E+7xrXKQ5v9dzGqILbbRaB7kilCCQER01MDB6L9gNkrKodeI5n+Up+LGQThMw6TNSQwpDUjnPwSE0GFftwQ4zJcIEn5KZPUaGJFLzVhQgZHB5wBzonYpcDv4iNU7k5JfekmTlg4m8PkqKhoJ0pyjpNnGf6EZluSjW9IwGPkiCfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048488; c=relaxed/simple;
	bh=2pTbmFRylXjRPi3fcJo17F+fmG6yycKh9UAmm9bVg4A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZN0DePmFk55JUq+RMyH9M4/c2I4xHrx0eUULlDBe29j3qSYq38lCDMvoJY8pRJQo0m9p8Nm3bTpU4wO7Wy4T7S7FSN5M1XlKKmbbKW+cBzFk3nX05bZ5FAEvdeuO0qCDoJdy/+sJ6lYKjiel4B+J64c+Flfc4LCUzhGhPloTfEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fg4ZvrQ2; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fg4ZvrQ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px4r5/+dIlK6501G+JS2/LoU5I+00RsgfF8a3+EuqTARjNM7vQeLmPrxAU+uvKI9uK8IgGxNmc9zYe1WphzB2Z9Xd6BzcRC+4v+pGNLmBTLbA1bGmME26YmevB0BGXJ47Y9am+qLL4RmOEAhHXfLDhOretb158wNFjpdsCRv1JIdAkN+Sqn+4WJx0+W/5MvPzX5Ekbs1wlU7JQPMfsmMlJ4U8xa5f8zEGq31sBYxlCTsCWwPWgRtPwzCvhD2nd0ssqR3Yt+PHgySUBeHGANsKqGV/QlunAzvjUOyOwPiLGINrbCpP2ya1+jmZgcy4w9liR221N5Q7Z34YyAqffBe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iBOquFvHUMQDjUHSaYP78ye46J/T8mJsQpZ9QnCbG0=;
 b=KGlHz1PnUJdsSSNDrtTYjAX66kuu6/sjiyJMNUBVxHvwYRQKPNv3ScOHhM1fk1uCYj0V1FfQi1T5zaJpN+cyeqgGy52ZXszS6VFiqJRct7VptySA4isS+KeiCpH14TKqv9k5ExyLwZS/btAo74mA7eI4X3vtNnSYe4J2EPY+ag5xQjpOjWz4Dqtdzq1/2bMXLSHlQPaSOHs51NXIQH5zGYHhXH2urh2KaNK6ef2N/ojKiDWWbAScy1/CPUe1o+xVJNNIM1Mqzf3H0NQHyluokoX0iexcEzWxUeHN8vbTNu8vcf+2yxNFosSeCHZ0DlCAr5qoi5m0OhSHQkkD42ZW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iBOquFvHUMQDjUHSaYP78ye46J/T8mJsQpZ9QnCbG0=;
 b=Fg4ZvrQ2/OYmbzsTzbQrINNF0RGVtod3NGbZlKvPcOL6ec24/QSKba90JWIRCbbqEclq5G7X9sq3/34XHxC1+MtxV9a/H11Lo0dPIGCCuDz5onbSpcNR2plZzXfibRlFvce4W+mDNBbdA8wsLcBSzFvYF+LZypcDbmSvpar4k3utBXEL9KEsFfXbj6Brvm1dZxsF9F7BvPayH6FIwP4Nf9dQi4FVlfLIADLkpHVbX60OA1QlaCHCXAbG9y4KNtg0xeHX0wEkEhj4e4hF3EPNnbpvjPacaycqHXZJVaCEnyyEE+g/RL9jj+QBas6Ceyrt3OhrO18/gKdfxA4tGiANQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 06:48:02 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 06:48:02 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2-fixes] selftests/sched_ext: Make allowed_cpus idle validation race-free
Date: Sun, 26 Jul 2026 08:47:54 +0200
Message-ID: <20260726064754.378671-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E9C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::458) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: be3a332a-340c-4b83-7ffa-08deeae1d671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Gd5JHJ7nkHkt/rP1DdTpqpLLZ//gVvFTlgv1SdkBw7gqbfkWac58Fcr75jXxW3bzfpyyNDHiVHfxMIi8M10yRvPLVbu2igCVXQLarmQfWLmhk7RqA4scW1sL1rVnJEPgqwg4DMSZNI8KG5UEtYMTJlv9RZQ7Ha3xSZrWkejpNFIDa+6UTn8gRWj1LQ9DJClzzcO0qR6XnN6VLXgPcDTPu/8E6XZT+fE9z/g+C9UVfBVjxI71VO0G1DNB+DJvte+Jz+GYUvxdOEHPP9dHhPBp7uPurwcmPP3ozx3/ksNn7Y76G8LXgm4ljYQVjkswSqYtnjgOTH7h+/WmzYfz1ie/DdmdgKoKeb1EP+wzsLEBrdkJcunKKm00aJnZGhxGKKvW6O3d+ACSjbC6jtpFahbB7PJnJnOymyUiFSLJSJCZxu6irxfcp/6BbI04N0875NZ0FkEs0A8697dtRSXLDtw4rj1qO1rmtxw/hKOqoLMV6bkadEzFbG1QS6A/TXKKUiSeUzmsNrGaWOygL4P4Lyol7QDtzleOAq+tI+1oBehKW/tEcE/USQbcB5DlHIgQXv3e9/CiIfv5WG+hl5aG9XUTUcYGp61bblcd0gIyD4aPdjRpD6zqbtmz6uGDBw/vld0UL5xstRCCq+2Vtf8wFOlGr0VxZdH/6qTUVRLCjVig9yA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xiWnq6jAsBuvRfqmG8sFWv3aC8CrMiwqnWcADXNyff/hpZpgj1oGhBYO59WQ?=
 =?us-ascii?Q?6zMTX1squ20t+IUFZ75XbJmB0V/ZESdpmn8VKTN0/JJGlvkJ956YKYCZ/xhO?=
 =?us-ascii?Q?DevXdgiMIcboRGWRv3Yy+YHIBDeuXchbf4GUWlzCQzqoPPZci189nz2ANJof?=
 =?us-ascii?Q?aYV/FlZCdSTvb9Fe7cp9d4V4iMmrQmsg85mOAHP/efQKA+dgbaRSXza/NxeI?=
 =?us-ascii?Q?ykIXxwMnqmHpyNXK0sUJuW7LnD+/5UZc97GDZfthmRZNsk/soxkWL2rbgvX7?=
 =?us-ascii?Q?Xmp9K3gFeBmynUyQCz0IyBVLxGZVjkasZ4LLELpu7ytuaDTWFRuH+votn+j9?=
 =?us-ascii?Q?RoKUtD3oYivdfJNub7weBHcIr6IKzcacf8v21fWjPG0NixSxi/KluGJW9VsT?=
 =?us-ascii?Q?EGxDUbk591xLAepKuZWujj4YjJUikfCjzZZx6U73MDJyTJxzjiy7mnVh2qEy?=
 =?us-ascii?Q?Aq8x2fgbKRMzFf/elulWHG4uilbYkMaO5eHo0Wd42CMFXFx/D+v09oA49Upo?=
 =?us-ascii?Q?O0I6QUjuCjzhTouqwL9RuGixvGT0W57krM5IrHcY046+LaPl9PKIpHXY0beB?=
 =?us-ascii?Q?PrJkCBIHlP68Qa3brvktNufm1a18N2C6dX9xkxItHVJTHCaDkdLOlvTrdDtX?=
 =?us-ascii?Q?fqxuZdFDiWe9hOeHm0aTVSl2nQDuiSQcMJH9ULP8Ytxbnz6NbIsecckNqoJo?=
 =?us-ascii?Q?bUb1U5cEH2nT+hC5LaE8MRFU0FT6bJtXW4ew63W0g7QNOTHAAKmYl4r+uIvS?=
 =?us-ascii?Q?mgt0dXcyLV1sLpIilYWtyXFF7Jd2RDeZq22VgnqKqPE9lkrwkU8qsbOsJrqs?=
 =?us-ascii?Q?l8G0AtT4eFjQpAY3qkRbUJADeShr1E5Ds2HmeqSanPLES57IquJCwcat13uP?=
 =?us-ascii?Q?/tP5qrMUjupp1xz+3/tkZlJNt1qfbIOBiGIvh4M5B7Ffid64KPPO8MFWYAgU?=
 =?us-ascii?Q?5TXLI25s68ZGSiAi9Gl5NsVWFuV9A+DuC8Bj2bJDovXvYdcU7NwMqFne+Xai?=
 =?us-ascii?Q?LfBch1DN7zrSFqHKducdcxfGyR0LGAKkY6r4FoQXAULJWZYho/rQEVlgbbIm?=
 =?us-ascii?Q?SNxigPsUMPz1mMm2Ua0W2fIXQMOBPqCA0DK3bfVTn6/VjCLqWhBfoSVXjl5c?=
 =?us-ascii?Q?a/M9UmYiGWM5mnRbkv09yxwnVi9VaHhEm5T8yA1pysg3xzgl1ydV92j1RtDl?=
 =?us-ascii?Q?EhIOVP102/Qn96Q+qTtBsn8wYqtFYY///8lEjLyg1cwhFgIE+wZb6l/di5Gc?=
 =?us-ascii?Q?wEiNOvoskvLaYsmzezfw0HMAaVrqtH+u159JbMJHh62WJhknFLFVe+UZgY7s?=
 =?us-ascii?Q?n1xqaIvyd2loFAyaxvIEouhxosys8HSDErYw83HRS3xudLrzQyOGbdc8SkMJ?=
 =?us-ascii?Q?TFHi+ZJmWQri6Agx6oD+gtzMiXZyGLchFFr79Bmy8eIbghwIWGub+MJtXMyR?=
 =?us-ascii?Q?HdNClSs2Do8mWN2Z9tmM5j9ZA4SDcijBeTG56ehNsZZO2R9+0TEAft6+j578?=
 =?us-ascii?Q?JnKN5h81xnVycV9kw834nbvzzMmBk4XhZmt3BK1W7tJOshpZ2DyCw5/OEyQY?=
 =?us-ascii?Q?Na0ghe+0xiQ63YJO+6EqIdkl0P89UWJNGc7um9KdX1lQKyVUeXxz1gWRFUTM?=
 =?us-ascii?Q?N6DSLszTf5sGZtd6vaTEKb9RfDda0nwoNITcfr2IGWxyRsLqIpkQ62B3Ebj5?=
 =?us-ascii?Q?mGhJc0cNvcoqirz2q9czhdG41Vk7Oj4euFiTDSKJ/fPaFUD48kZOrRkXB0QD?=
 =?us-ascii?Q?7tTAHKM/wA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3a332a-340c-4b83-7ffa-08deeae1d671
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 06:48:02.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWWbfZ3hLm1/ShBT5FzELxS7tnoa1HU3FK8v/PSu8nZiMqk8Bfgf7W/zjx4oF5U6BiYgH2s2w1rLNcCwmLYO4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531

A remotely selected CPU can be re-advertised as idle by an idle-to-idle
re-pick before the BPF program validates the selection. Checking that
the selected CPU remains absent from the idle mask is therefore
inherently racy.

Validate the stable local invariant instead: a CPU running a non-idle
scheduling context in ops.select_cpu() must not be advertised as idle.
Also validate both the requested domain and task affinity for selected
CPUs.

Moreover, bootstrap the test by running a task on every active CPU while
ops.running() refreshes the initial idle state. This ensures that the
idle masks are properly initialized before strict validation begins.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 .../selftests/sched_ext/allowed_cpus.bpf.c    | 51 ++++++++++++++++---
 .../selftests/sched_ext/allowed_cpus.c        | 38 ++++++++++++++
 2 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
index 35923e74a2ec3..4a14b05065453 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -13,17 +13,46 @@ char _license[] SEC("license") = "GPL";
 UEI_DEFINE(uei);
 
 private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
+volatile bool refresh_idle_masks;
 
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
+	if (!curr_is_idle && scx_bpf_test_and_clear_cpu_idle(cpu) && !refresh_idle_masks)
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
@@ -42,8 +71,9 @@ s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
 	 * Select an idle CPU strictly within the allowed domain.
 	 */
 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, allowed, 0);
+	validate_local_idle_state();
 	if (cpu >= 0) {
-		validate_idle_cpu(p, allowed, cpu);
+		validate_selected_cpu(p, cpu);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
 
 		return cpu;
@@ -71,11 +101,17 @@ void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, 0, allowed, 0);
 	if (cpu >= 0) {
-		validate_idle_cpu(p, allowed, cpu);
+		validate_selected_cpu(p, cpu);
 		scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
 	}
 }
 
+void BPF_STRUCT_OPS(allowed_cpus_running, struct task_struct *p)
+{
+	if (refresh_idle_masks)
+		scx_bpf_test_and_clear_cpu_idle(bpf_get_smp_processor_id());
+}
+
 s32 BPF_STRUCT_OPS_SLEEPABLE(allowed_cpus_init)
 {
 	struct bpf_cpumask *mask;
@@ -138,6 +174,7 @@ SEC(".struct_ops.link")
 struct sched_ext_ops allowed_cpus_ops = {
 	.select_cpu		= (void *)allowed_cpus_select_cpu,
 	.enqueue		= (void *)allowed_cpus_enqueue,
+	.running		= (void *)allowed_cpus_running,
 	.init			= (void *)allowed_cpus_init,
 	.exit			= (void *)allowed_cpus_exit,
 	.name			= "allowed_cpus",
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
index 093f285ab4bae..eb1708e55982b 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
  */
 #include <bpf/bpf.h>
+#include <sched.h>
 #include <scx/common.h>
 #include <sys/wait.h>
 #include <unistd.h>
@@ -47,14 +48,51 @@ static int test_select_cpu_from_user(const struct allowed_cpus *skel)
 	return 0;
 }
 
+/*
+ * Run this task once on every CPU while ops.running() repairs the bootstrap
+ * idle state. Once a CPU has been refreshed, subsequent idle transitions keep
+ * its state up to date.
+ */
+static int refresh_idle_masks(void)
+{
+	cpu_set_t original, one;
+	int cpu, ret = 0;
+
+	if (sched_getaffinity(0, sizeof(original), &original))
+		return -errno;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, &original))
+			continue;
+
+		CPU_ZERO(&one);
+		CPU_SET(cpu, &one);
+		if (sched_setaffinity(0, sizeof(one), &one)) {
+			ret = -errno;
+			break;
+		}
+
+		sched_yield();
+	}
+
+	if (sched_setaffinity(0, sizeof(original), &original) && !ret)
+		ret = -errno;
+
+	return ret;
+}
+
 static enum scx_test_status run(void *ctx)
 {
 	struct allowed_cpus *skel = ctx;
 	struct bpf_link *link;
 
+	skel->bss->refresh_idle_masks = true;
 	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
 	SCX_FAIL_IF(!link, "Failed to attach scheduler");
 
+	SCX_FAIL_IF(refresh_idle_masks(), "Failed to refresh idle CPU state");
+	__atomic_store_n(&skel->bss->refresh_idle_masks, false, __ATOMIC_RELEASE);
+
 	/* Pick an idle CPU from user-space */
 	SCX_FAIL_IF(test_select_cpu_from_user(skel), "Failed to pick idle CPU");
 
-- 
2.55.0

