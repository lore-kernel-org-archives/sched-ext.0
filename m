Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2647043C
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522299; cv=fail; b=maFaOHyp2hyc2MCQ1od4degwya57x77jOSJhcjnxetPNLPq69myn44AvcZCPBBkrnZICe+P/ZK1QJuXMJvhSL8XLQICN9q84HnW9Zvybm7CmNXFeoyWqHIZ1WsocCeZ6G/Na8EsENWBls3xb7lilR2chrGLBulPH/RgJsNPL+YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522299; c=relaxed/simple;
	bh=5nsI47bNkIR5yAxxYStDZetHqah/zNbOlFKHvuhD6U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chhiGlgYiwxGOxfvmEhkRI4oT9nrmVZ2gO8Cxc22NNAJSH7v/HqwvSD+5RjJv0lbw8i0P0idwKHPP08P8b3F0PU6ROUFm7OcoonPu+lBENL8nkQBsFkmIzriPQKclZoxaiq/VTZaToc8T5G070Vlr6kDzR8oZW84WjJcn5oi70I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L3pIYqef; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L3pIYqef"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V69ncLOmkZPY4q1coTmUn5bM9YhxQjDbbEQHVY90QOn1yBZu0aIgi5EdnX5J+HkjQ7UeII7sKUaDvlHxMzVTMr6npZQEG5wBYq3+Q9UIBFnS3bHeGaoEBIYrHLENMFVbPmP3DWidfuhFXniToGD//EPD0iz6swK9MM4RulyKQDbCLl1qDpOPd9pW68rRBRkriClTLdIyVbVb1dSkdAyxWxBOMBL47Q58Zpb89BMYB/TTPBDtMJIG5to4eXqnSAtTfTJZwmxGwolss9zs0n4KpTkwq+A60dBpr9MDYmpcGvSpxN7Geos8TMcchufz6dPyPB4VLtTvQI9sUXqUENhCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjUU83kZia6yUgwG1bcElLsuwy2lB0ZiZSxzFR5dQgI=;
 b=aah+D86T28Jk1Cnb08d3G7IcyEemF6dfpUQytMUi6Ufh1Gti1vwc1bwEVJCAe9ElV1ARU3p7gQFqyDKQsCmDDWJPS9OomH4BCV3ncpa4/kBKPjVC/P42Thj6z91CDp5egupAL6llX1BV50kxzxyn5Z7QOq0KAN4D0hhAd9xYKXGBy+eOYVq7jjF192z1r5mpLNqfrjCHVELwPm1DQY5BDvqCXEPQBUqY4kxgVWb76In7zCH9/Mo/eEs28tYAG+xq+2Pox46hQzQMORXqM/TsV6dAWB39jKctvUgcJmrHTPXb/tlx4cgTPuegzn3Hi0Dtx0HZPag2SRjGXlO1S0oMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjUU83kZia6yUgwG1bcElLsuwy2lB0ZiZSxzFR5dQgI=;
 b=L3pIYqef89469DUZGHtuAXeXSM9S/ccYW9qO9Kzgfi0tbXQGBdJWfEaGYuStQ/YbX/ysi05fv1cxZRzThGVrzFMPUFgafJcaQIgfPUxK+J0jzP8lUs35nW08ApnyHTjL/r8efoyR4j1aAfHw9SVZKKeSJbGbwt9dWTQxC103jVINILstjkVNzrS+VftQ/RAKsbxj9XmlZAKXdF1BnnY+nU/5wQnYD88kd7nprfXV40Cbkn9aM4HFtECYDTQZbJCHIPL+9YkT5zQjgkmfAY/NELlzknw+YRuhR4KlMc3sPrkSc9ZObd+QpIt/TcKWdEHC8Awpec9rrdhV8YvnBAfgLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:24:49 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 18:24:49 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Make allowed_cpus idle validation race-free
Date: Fri, 31 Jul 2026 20:23:34 +0200
Message-ID: <20260731182406.3166853-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731182406.3166853-1-arighi@nvidia.com>
References: <20260731182406.3166853-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a65d18-9f70-4aec-9a8c-08deef30faa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1scY/q4KR4+S8h9ha4cxm9ONCc223Y5GTn8XBSj/8Z2jkssu+87iF3kSsFtlFzMConWcwgDMUMKaVUKRiDu5/tLhc3I3Zhejw6w0s7J730rQU1KFhL2O8bRnD2qtuObm8CjkAZ4mTflShcmP+bwhzeB20Eaqryl4XJr81lohJpeMvyb7SvGAPvK370bUNa1Mjp779OuQxToBNK/pEJ75D088TZNfP64oaijc0FV49wvhLxP0pkfMfyBXDKCnr7heXZxrCOLfOd8y3RQKOH7X4P3+SslOohEnDSrqzAf6CcEISRp9ip397kzLZ5ef+ljcliOeNtmQRdcHDesV270RkFpcE74S7niX2i1gYuHHD8cn1Gl5i/LPEefHdqRYpMM5gYhD+833LiZCYia3I11CTDo/yiouIxRwJ+O4wtqPBMEKXNX0Z5Vt6kkuMe/hnkh4h4GWg1fbGiT1ZpYiku0NLbYTyrMj2c58e/SvkgTl/NrfpcaTCzQqZciK8iAYpqZxCrXGL3vEItDK4bl+JCz2ZwvEtEhKGBOeI3Ushsr+t/BqF9KUxnwEswBsxXeGIeSlx2MheBWjXG9XhQf81qAYoCFuvvx+bhBqkfi/3kXmuf8Ys2ZsOuQ2KXGnMVzdvmn4ki2yViYnAXw5rdC/o4RTCJCMKpl65rUFvE/DU4Wm+Xg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6KJaoI3wj9vhspFwHdA3w1hqHq2ov+U6lp617ueASBX0fVJe8EloCjIfeDyq?=
 =?us-ascii?Q?FIgpY+I/9QRnz28CAGCd/bUzQe2vN2T14WXTj7ED2AQ9VZW8EO77HPUXZy0R?=
 =?us-ascii?Q?ucIrX1fgWbN2nWgcEBhEO0/Iucxy3tVzoUd4p/KZG6Rqyan6+seRmfpZoxbC?=
 =?us-ascii?Q?bWHtP8+gmJkuqICrF8VTocUI2tI2aiaQtalPqEO3uMPdpu73vPuqzQXO5LK1?=
 =?us-ascii?Q?qWKltfU3GqUB8Lr0Yr/pwxatbgx4nAkefIWvi0Z4r37mwDQ7Rc62wb5IQsfx?=
 =?us-ascii?Q?xkLaAbFsy/jYciDpVhkt12M2p7RcKBI8Qh3Pxp5yprBurQ0Vl3+MgpD8wQ/1?=
 =?us-ascii?Q?yKILZU45ayfFmgbA7rrBzi9FJs5hPhvOON6zgzWX61IcYrNK0/KcdUJZZT5Z?=
 =?us-ascii?Q?GJxLId8bZDjaX1oangAmZUNNUP86MvS7TtyTSHSIT7Dr0AYHbp9tjMUfInPu?=
 =?us-ascii?Q?IvjEqGmuJD676D3YheMWLd8dJ7FdmGnqyJlG+8RWRHh0yUPlfcDcXuQj+dC6?=
 =?us-ascii?Q?itxCFE0tGmgSg+3UQ43ycM1wj+MH+2treIMknbCk/f4SVBuqeXhVjKaAOZHj?=
 =?us-ascii?Q?iOsOSdNVWpe57LX+DDscSV8nYruxxGywSowO/6rgkJCR9Ef4muX2CIFY7dja?=
 =?us-ascii?Q?4BQEvJDDw/dGZYoM1bdJmO+eU+CfDd5cfGllkXVvxEU7bmu/CeZj1efW3zn2?=
 =?us-ascii?Q?fQ6TYoqabWNCAGssfzHNTo+CC780SP4HRhqvqoDDbk3QaENo6Nrfuc8AlW0t?=
 =?us-ascii?Q?O8klmdASnEjmLVdWTapHPnmkcAfKHwmgl9NMIAXMR7SFjuLtzha5qkI063VB?=
 =?us-ascii?Q?NxnJTPmdtKLZrmjcKu5SFceaS+Yn8lePYEfhAEcbvCuWaxRWwSo6pLZ95n0R?=
 =?us-ascii?Q?6KSAcYQyQ/Qx73gZAA/ckQwxUEZS74csD0qfrU2tH93UN3oW5i/1kjoQxIC9?=
 =?us-ascii?Q?qKS+wGH93lBuoud5kg/Us2hdyiEcICIq/jc5oMi8+Qc/BtKIgRU5sH8nW1Gu?=
 =?us-ascii?Q?tFtBcrZd1m8jMEIFtHVrhZmLngm3KWvr5LZVyv8qsnvQZZvcFI5osi3zDfRF?=
 =?us-ascii?Q?+YRfjLv6CRgdGELQiiJkjwgP+XI1vXrXmmPZ/cLjb9jDjHDEEeh8oGkjiTaI?=
 =?us-ascii?Q?DQXWFvkhVSsRNz6q5EGO8XcL7WWNV3whdJJ4hVskVHHhwe+du2OGuGak5IrZ?=
 =?us-ascii?Q?lMPDOHVIVX72SVypugaqZNL6whylqbc45w93/WLT7Ika6NI9fXWrKZQ/TVZV?=
 =?us-ascii?Q?G/BmP9ldMjO8GcO/Yf8vpJeZS3g09ocrVsWEwIlKIpLBVuEZHA7IwVX585e2?=
 =?us-ascii?Q?Yqi+eSit0BowPZr5WwRKg/7wivBYVHeJaHKe99p1fx9KmCoWaJfDlgMXzFns?=
 =?us-ascii?Q?pN6BbSX57CzZnb0VYrVpNUcqPVzGTcf00zpix2hQPkkHA6Cp51JVAYiDN6Iz?=
 =?us-ascii?Q?0cDdpRzVUQ+dPKEetqr7Tkjtf4ECKuyxHShsjtctBkowxHmgi8wa1DMLZieJ?=
 =?us-ascii?Q?ZCmDgGGaeN+KMaiKV5/u9v3wReVdJUGd0VjFAy9HKB6Bh6qbGmeqbv8i456X?=
 =?us-ascii?Q?0lOIZq8wBR2+UC3auZFq+L9myn1ReMc2Y596IuhqkpD3r6PW+9DLN7/uELbb?=
 =?us-ascii?Q?hHqoUdWELcxwwP6zwulcq5z0t8JbEHDM1A8gK50sfl/wONwPycFzHkVxWDDq?=
 =?us-ascii?Q?TXiNT8jTvYe0eE3A0Mrm68GbKzvYFGW0OoigD/SJ1bvtEIPvXgg2d+yFeM2t?=
 =?us-ascii?Q?K0fruRgF/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a65d18-9f70-4aec-9a8c-08deef30faa6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:24:37.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siiwfn6lRDN1va5/j/O/0SjGnnTV9RmU9+bnwFJgYw2fYVeLiJVz+364o93MtpG+r5MNB43fQ83MfB/8E0dNqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047

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

