Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DF219CCFC
	for <sched-ext@lists.linux.dev>; Sat, 20 Sep 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374799; cv=fail; b=Zz1X/7mw+l/6GrDfPVxrd7nmF0utaRRSrTwmZ/OJDEDN3MEjqtNBERnk+OESpGXJsxFw3CBN9m0ueTyVXBmiexRDk2nRMlS5J2Kbs8Yrol4q7O+XapgPiiSXbrLM17PbxiCcqUs1CEcwttoxPboQDyMoD4Ylo/6iMrVypRTKNpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374799; c=relaxed/simple;
	bh=CwkJ21P1qITLHHQ8lSEPZbtxNElTpXIqMHpdJeOrAys=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tC5iYtf9CutBAw7tT73URsiNPQEphLRgouP0kUIhzw2PJWsp1g2LX3v8RCdQwKHK5t7KAU3X3mUWrFfBQZuyjgmhUz9DfIGt5UZs3RxIEg3BIANCie1XOjekYRK1vUZh3BemnMfXQiooJNst1s/c8QMBJO6TycAR+pSwhw+sjIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AaUNsqi7; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AaUNsqi7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGXkk0hS/h5nTFf8Jj3qzNRH+1BsvM9x0E79ewM7O5TLpkfZfuFIwgGH6jrCPmjXASMoYk0uz1G+obBHzlKS0dcF8JOSmFWlp6ZpBWj3AFIxJaMMEEDV/1MgnKXxnmI7Z2Wi9k//W2fwIlteSEF5pbXypfqcPW8isabWDjudUNNvOtgPP1bmR3zLN5RpDQf8G3/q304AkdPSgV5oqcvO0eoKtK3FQZddwHMCAujMKBwP9LBedPl93wPRLirfZS369jAAp1+tow2nMjilTas1m6l0GDYRP5J8vkJ1L1FjZLpXJtWIVA8K2+ncvQutm1hXZki0QGbQ4F9R2NSHrK3skg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAF9bQzh0y0WbLBB+2nm52+54nPuy+J5B6F71bfm7D8=;
 b=gmrxPk9Ta4VFzppvun/6r/WjBUwV9BECM6SBajmdGhqPykzWiENtPVFQr+GvxLNE+wLt8N9N3BE/4pY1PVvcLFLvmFeeCqFpXn3nk9S2QJDwJJQAiAkNFb3yAyGdHeCX6fr/U3CsxOJ08dgUG7CyZtOYpeDV5JfZ4oFUZQpIMRsGKHh9vvE5Sh+fj/+jzECQMbX6nKqSzKbG411nY6I6pYlliMooWGgaJPHZxpmEOEmNFcInfoUbeVEyPGV2l+5U3ngEUFOnhWbrBMbxEqRz39WcQHXsSjlCwkGUWazYXmmlEScXZQDEPCArZF3F8ctURZyrWekmtm9vcDjSgqnA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAF9bQzh0y0WbLBB+2nm52+54nPuy+J5B6F71bfm7D8=;
 b=AaUNsqi7dkMvAVSjmmLSPXQOVVKh9+tFH4S7azySmF4/r2r7sB2Iq7YKU/sL2smou4zKmW9zNxPqh5xWK7qakraywKELlMzDHaAe5abycR+yIkVTFVNB2ViUJsqp8RSJ/7lyF1qm5b2Bp4I+5uJBHtIAabjXVnrpVbnxhLqf8zyU/vP/6eH29wI39MY6gikPj9kv0NvuBMZxNE+32CS75Nr8KUJ9WdHgDn6ynbwLNzRkPk7zgUCRPtB0Byu0RQOxOsLxJclfQMfUqRFJn4U5hlwp6oSAXlu+fBuHEUEPTXsjGCk9YC6dhzi04FsgRfe3RKwP1Ywmsu47hIHBWVuAfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sat, 20 Sep
 2025 13:26:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.016; Sat, 20 Sep 2025
 13:26:34 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: idle: Handle migration-disabled tasks in BPF code
Date: Sat, 20 Sep 2025 15:26:21 +0200
Message-ID: <20250920132621.16263-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0125.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: bd99248d-ec4b-4fad-fd66-08ddf8495137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UOLyw/DcL6niqolVQtJYVLil7sOsO+XMLrJ24jeKgBVQYqVFeIq8Ikz+TF1k?=
 =?us-ascii?Q?CsqI/GuSeZDivXKerVJ8j3QOnbg0OjedL9rZBMe/DgQk4tJIgD40GmRdCAxG?=
 =?us-ascii?Q?K6hoO5uWqW0uPF6TLKJyIDOfeWdyu8fglpYUou2xRgoMBQNfP/yV2zSlRHGn?=
 =?us-ascii?Q?E45VoU6x5/8rOvzKPwlsfzcvkFbFzgSITWGgRBnOeXeS89MeeFZnwB4VyrX+?=
 =?us-ascii?Q?FMV8GsXW2/a25WQc6INj1awFGNbm19DN9bBh2dXj3cHADj1fm7LX5YHplUeP?=
 =?us-ascii?Q?dEg8uprqw8kzJkui4+ncMU+7ec2VGowu8eKea2ODIoL/l8cziKGGbkJzMk2m?=
 =?us-ascii?Q?G1JFZ8a7cLHd6v3u33OkM5Z+OCaVUwmNaNfmI446zicyIonHiWWG76U2zzrl?=
 =?us-ascii?Q?sAs4dyYcmEKAUGriKplTc2K2SDv2N/2PiCF2S3Eahc/8+E9Y0//GlIst3EtK?=
 =?us-ascii?Q?hmGYaEPMByI6NV1uWDX2UzJI5IcS8WV1V4Uifn61UPuqdxFNwe80AsjPPW5l?=
 =?us-ascii?Q?zYj1l2rGfycEh1+ffzNlVvFrEVhjzKFZRyHSFVXsw0i8lufbZUFFobIYjmq7?=
 =?us-ascii?Q?xEYTXft1Qt4KkXFigJY5iVEw7FvKs6rDpHFBPwo+PaFzO1Q0Ml2kZBDn6n/5?=
 =?us-ascii?Q?CygnK9QC42lPcg1F5ieJg5TUnyg3EFW3s1/MwFwJwhJkAjNjtudVbvKC/xjw?=
 =?us-ascii?Q?dCeeU8XOSEjJ0sbcXPu0UfIynj3HGGVtujxv3T9JN2HTydbjANOY36+LgMiY?=
 =?us-ascii?Q?qElPMEkjuyA4qNZNSd3l3bgki5yLf6gl1B+Qw4CGmADs/J318O/g+pxJzP9U?=
 =?us-ascii?Q?gc0qFmLA0yNt/FyEgNHkmKYDypxZH74FB4OYSYJjV1lUeGoz/l2ZwaSBUMjh?=
 =?us-ascii?Q?Qdc/C1hqI9i89QHoznPGL6c8dOKuPWM8eSI7kXZRvkyIeYvRUMa+Qd169R95?=
 =?us-ascii?Q?9LC20lO21HXsPSX4DSugOehWgS7BI5TaE9CgvtrZFMmbwMbrRIqckVlRI7VW?=
 =?us-ascii?Q?IeUy5acU1v5DckOUtQuXfcuPJVRpkZVYc4p5t6wP6j3TT3FDpqzzl8ky0BFc?=
 =?us-ascii?Q?/IpTF0x6x/dFxFO/96HupEslVc67bYURAPpUvHw73stFDhieEIvdIWMoZ5k8?=
 =?us-ascii?Q?Ib89Ghy1tihf6J7Z0ghypYw48Km6Msvw6FvwMy0UFK+zIX3+duevezI1PAid?=
 =?us-ascii?Q?qoEC/2HLHoLK9UFDBpRnBiwKoM1dQZmxfxOkyzToGZHw640BeAIVGzC3BpXO?=
 =?us-ascii?Q?u5GR6dlSjnZ1vhO8u3zmPwby1KUlTS0fj3JA+QF00qCT/QPPZ7MO+CZa00T/?=
 =?us-ascii?Q?W+HrbTkyCyWIl3WNp31lHpD3rcNQooxVKxPvj0A4QFtIbxuLmC2+QpMaBNbn?=
 =?us-ascii?Q?zS1cOLybVLBuhIUziI/whwTQGLq9PNvwj/CHDFIRlO9ccZ0Bjj42dKGdnPu9?=
 =?us-ascii?Q?tGc0rsAs9Yk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jJdkblkVlTHM1z1xwQVgZGyHY8xGfpboyTqD9xV3u5wu2TEWKggGZBQB6sM?=
 =?us-ascii?Q?7spX/CpGKene7xheth3PKWnjBNItzeJCaCubmr3wAfG+L1stUct2WxrxmXoH?=
 =?us-ascii?Q?nxUdFqVa30zj8aQMcH+Ski/2ytCWtgd93Taa6L0m5TVi3ltLQb224dYBxWcH?=
 =?us-ascii?Q?uOD1Rp9b4QgK004/SqeRuYGO6YxP+iTnmoY+ZmeQp3K8RV6xOqVop4fkHft9?=
 =?us-ascii?Q?wjiAplK3W+2+JaoznwNz9mdixKZcq6hKnEV0SBiIIfMqx6wPYsWFbP7/wbA4?=
 =?us-ascii?Q?H/svgoHkvDBZp6xWCLJCkR4oTgqhfk2bJlCM2l9QQq2wLR5pnSz05b5Zhi4U?=
 =?us-ascii?Q?SebGJD5Xr1S32bszRjhS7CSW0+5NsRBEEsS9CQ8RIuGYBI8HPRzaoh3CrNRf?=
 =?us-ascii?Q?dSKu/BeFSshv2N8SFTYhH3aLQP4+Hkppjka+QpazW6Ee/nBa6dk2/JCKtlX4?=
 =?us-ascii?Q?H/LgBiC58eRQ9OEoZdxA3GaqHI8AlXXuI1dBGtc4QcvM7GbYT1NVK5iSI7b9?=
 =?us-ascii?Q?Gbomtju+VswOmpbi74qtIm0nnICzP8/xOBkgIEiWn6rtDwj/S7NR7+6fvHik?=
 =?us-ascii?Q?cKehZK0gPDYhJXuTpg5o2/wgF5fUTYS/y/rKBLcv2I2/2VjGub6Wh1rRiqLM?=
 =?us-ascii?Q?dkYbCS0G1y3qBR4HsHGNv8RnBrmVx4zOVdy1OOTOaXlgyQ2Aa/VSAE7eLHMa?=
 =?us-ascii?Q?U7BDiieS12nBT0iGI3dR/kjFvy+eDAKXhLnHfYZX43doLNIpgACx45URf3kz?=
 =?us-ascii?Q?aamhJoSgO5Tt5VzlcawJDgZaUC1sTqs33QIIqGzw0NveDvBhXLth72R4R3Dr?=
 =?us-ascii?Q?F/U/ar76JSwdVocjlE7M6hf7pAdoyf5qQmvGTUoUcxOsyLu8finxp2RSnUsq?=
 =?us-ascii?Q?j5W+lyjm2r8OKo2H5Tmk7SqtAuY16utEWhJARIMkEKV8AoR3DTDsgRfhI2ie?=
 =?us-ascii?Q?NfBK4eFcIAIzSOR9CIDapA1n+KFV9ZVUXgt87FIfNl8vVXoXZEWjaByfgODv?=
 =?us-ascii?Q?lv+diwvOcpb6lacGrYE9r+zO3SEV7uMXl6EhKV+FlrhHrFDW3qF7/Ua0r1NO?=
 =?us-ascii?Q?a0LxNhkOtPDozsfJxtcOsL0rKGV87Hig4YgxF87nT5DBqxq2RN+2MmY/5chR?=
 =?us-ascii?Q?0DLB1141wEmQrOjkhQ2xxMOaHpz972LLrUfZy6eII0NQ835nU2WQh+YdtKcQ?=
 =?us-ascii?Q?pu8ZHraOEZILAQJGUS+5h9DPRMIXXkrIwYsDu6ZF+nGBMyq07RxwEpVCP39D?=
 =?us-ascii?Q?atrsCoTlzAoZpSgQGRmh9Ujyk839W9K6p1kYKICwMvCwWeAEgR+BkoARcdoJ?=
 =?us-ascii?Q?FxNB+SyFfaqBQu8Gjva0Rbzj40klZsNlSPQJw63ZT5QmafoO2RtuT8OtxL6k?=
 =?us-ascii?Q?isyoqDY6Vx2i+eX5HqAV2CHQjPGyrbTPGcjfrOIJc7FiI6ZDwuLHjzFUEafQ?=
 =?us-ascii?Q?Ox/4mdLvDGJnb9Zz3leE+mMxDBMXrWHyhP1teMC/wMC169nOk3smMP9LjVv0?=
 =?us-ascii?Q?+YZDJFmopTwAWx/hhhYV2FZwlVf6uX3mRPPxmu+i/2jEEEyI+MyMy5SXwf6F?=
 =?us-ascii?Q?fCRlafvlLTUXTAl7CGSzzXXwAHv/xUUj9/GH1QwK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd99248d-ec4b-4fad-fd66-08ddf8495137
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2025 13:26:33.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNxOvy9QA2l+VhaD/R87nRiBf0GmVU1/86LMNBzNDCuit0iQlhvE1ilXlm25NSHY0SdYSY0d4GxyRj3h7rDPSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327

When scx_bpf_select_cpu_dfl()/and() kfuncs are invoked outside of
ops.select_cpu() we can't rely on @p->migration_disabled to determine if
migration is disabled for the task @p.

In fact, migration is always disabled for the current task while running
BPF code: __bpf_prog_enter() disables migration and __bpf_prog_exit()
re-enables it.

To handle this, when @p->migration_disabled == 1, check whether @p is
the current task. If so, migration was not disabled before entering the
callback, otherwise migration was disabled.

This ensures correct idle CPU selection in all cases. The behavior of
ops.select_cpu() remains unchanged, because this callback is never
invoked for the current task and migration-disabled tasks are always
excluded.

Example: without this change scx_bpf_select_cpu_and() called from
ops.enqueue() always returns -EBUSY; with this change applied, it
correctly returns idle CPUs.

Fixes: 06efc9fe0b8de ("sched_ext: idle: Handle migration-disabled tasks in idle selection")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 942fd1e2ed44c..e8ca71cbd0d47 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -880,6 +880,32 @@ static bool check_builtin_idle_enabled(void)
 	return false;
 }
 
+/*
+ * Determine whether @p is a migration-disabled task in the context of BPF
+ * code.
+ *
+ * We can't simply check whether @p->migration_disabled is set in a
+ * sched_ext callback, because migration is always disabled for the current
+ * task while running BPF code.
+ *
+ * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) respectively
+ * disable and re-enable migration. For this reason, the current task
+ * inside a sched_ext callback is always a migration-disabled task.
+ *
+ * Therefore, when @p->migration_disabled == 1, check whether @p is the
+ * current task or not: if it is, then migration was not disabled before
+ * entering the callback, otherwise migration was disabled.
+ *
+ * Returns true if @p is migration-disabled, false otherwise.
+ */
+static bool is_bpf_migration_disabled(const struct task_struct *p)
+{
+	if (p->migration_disabled == 1)
+		return p != current;
+	else
+		return p->migration_disabled;
+}
+
 static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				 const struct cpumask *allowed, u64 flags)
 {
@@ -922,7 +948,7 @@ static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_f
 	 * selection optimizations and simply check whether the previously
 	 * used CPU is idle and within the allowed cpumask.
 	 */
-	if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
+	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
 		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu))
 			cpu = prev_cpu;
-- 
2.51.0

