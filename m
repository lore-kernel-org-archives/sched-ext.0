Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1C38B149
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321564; cv=fail; b=mu0uxhvvU5P86AzCEbInX8mEuJT6RN52Jho1CtgKudbeqQEx2thwVp5uAT3OQCrvdvCjGecVWdoXO+cQDU3WVNsDkwPTf/QOmg/NGqDhApWv3nlLvmhgtLQjO/+W+XDSNlwhXx8R2W42TPWDZHyBklonB7aSU/8UfhButLHYu2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321564; c=relaxed/simple;
	bh=VKvuG1OJ9Z5GpqYJopOES+6ZBMSr77C1H1CYvKY96lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M83B2BhUcTCr+2COXhv5SARSZ5PAWVqJstuXtmx7fWJhVjJXQDARq2TYi81q6HgeO1B9pAgMp0XB0WXi7jsLuokGqn1vccoQu5bMyU0OHkAuo4Z3Me30zqMGwF+9bGDJl+m/9dud/asiCbBrKVr7DBgoLs+Ayzzu7R/VSIIRAvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SUOdVbtl; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SUOdVbtl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFMY8ZgE1inFNBSoeAYF44CmodZHleUjdhF6kFqRDPAmlJKfK4iVVWsUZwIJ1OgsNzDNfPKqbXWSYjyApzYE8hHbVVQOfeUJ+uRF/XSIaNO2Ihf8m1QgCy6WUY7RcG9rsIWdRrCTX4rSBY3ak4C2qVcfcp4zb76IYFAPKQY6Po3A4aieP4IHP0I6jvmTUFhHkJfG/aXogR3tdaHRI+jm2Syjv5pjBSmZj7ASwAIpvxtOp1fOjtzJo6bxBh2XCsEBbyTDDHw/3i89qkksqaE8wfYpy6TPB1f5AFx8axw6m8owM+UACGx5S4zox9XC1s3KXOKmOS7qpfo8AS3GZc4fyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsAkCPtuG5Do30idA+vUsg2i7KP5AlysTjccTFBjXM8=;
 b=HfU+ikrSOqJW8PBWkIiVo3LGchM3N033LX2ea7m3qe9qSIQ6NG5KnaJRjHEgJyNdfIln9YqmO6NZt99X8XpXjCJRombgieqLX6/SUiNZx/SxMuWrM4K6AH9ARE8TyhAzx25fjk3hLidZe6aWfaTxD054QMCtWM0qjCxjTvb2IBhOzTUyl3moR4eSEDW2G/Hm+2tfoK8mquLSSUQIA0v1zxLwjKNAgE67erc9mtwLPYAE9+RR5sLVCmZccGzvXxkSkUGyMSrdsI+BP20pe8wByePW0vI9tUbi16C0kC/TgEc8NPGhrglc4iGG0TnpsNVy+1i36fV0o72yWGpJZM35Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsAkCPtuG5Do30idA+vUsg2i7KP5AlysTjccTFBjXM8=;
 b=SUOdVbtlVEwODLhOMQa9wiVGjkYRLH/ZMkIS12UxrzXhah08e6g4GLY8dmpPs12GHpF+EfqiQr/FBWUATnjPb3GmDapPdy2RQvGcZoHsVwMoUuWTiFxqFhOoyWhzf9C9FPRE/zr+gqPowTuR4oHKNUB+HgwjSxG+Nom56k8LudRPnp0WNtMwRSHmxtDHjFgPlKHErCG2ZRfoOTazQqh7TMkT8AU3La4J6ns9jZw9heCGIYa3VLPrQng7ky0fVJr3Bc9V6sKUBFVZw7Sw7LEDD/W9MHJ+kfAUmzV060SY6ye9hd9f3s0fbrNABLW8f3c+uTqz2yJqCrQazNMnqNqfrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:05:21 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:05:21 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] sched_ext: scx_qmap: Add proxy execution support
Date: Mon,  6 Jul 2026 08:51:03 +0200
Message-ID: <20260706070410.282826-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706070410.282826-1-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bf7d02-b468-4bac-19f1-08dedb2cf1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ABquYCMsbo3NAOY12LZVdSt1uSbfob1gQpqPi+n/zaqNLF6CS57ZjeSohRlngYRJ2IQwZG1WnMCSFj+QrFiYqO0K6lX3+dUn1kjuCJazsgfwz8fQ9vNPB3RvfXOVZNKwlaLPMocWPv0zKALOJjYAPIcLUpGgRTeFnlw/kbZx+PdXX7R4XRJq4wrjqG/YXMDsdbeo/FMZjFl7a946lpUG3Fdf5xNzlkAftb4qG/xBFApdCt8S6QH1A8lArwhg3lb5YPBkDv2PcXfhu/cihz9GpRxAJ+h1mOWHp+h6XaaOJPeeg1S/mzeE4TUroVK2onEIc2ZZOcn8XieFMfzZqAEp7HBEewI259cDwxl/S/OoT83mogWXwdBSIPNvIK++e9RmpHKL8JyjPBvX4oleXeDSMRTIKTVZ49RJnaay7zO95rKD/kul1nS7IxtZQB17n8WbSacqFSiv1ZcyCg5xJmIVV3x6Af9EJkOBzbHTUWvcS91kw6oA5Z3dCK/5zeMFSis9dAJQDOc0VMsWrtNutXW6w5BqM8Et30aodqI8gentJqkYsdmJ5GSOXGv2lS2dTvXRgwJwteKYGcI0E1vCVHXTQO/OV7ercMSQQJiU4V3eK3S48iq+XyxHKpBD0shCMXt/wiZKbdfJjtAMQkgBS3/oPct+kNhF3V2chSnK2KXwekw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?53uBFiI61Um/SK2+LcpvEKQlYRbjvJbEwcxrQwVElW7ef7WKAcGQAH9FDRDn?=
 =?us-ascii?Q?0aEco0Jo1FDlZ4ZKzVCTlA5n4E8yY4KTAkm3Qp5IxSW9pSRdmDKiosrjIj+v?=
 =?us-ascii?Q?/157Ayk7HPAZwn8B2FP2UI8EK42DegnB2J7kmGQiz7/OD8cvtc2qex2mYuA9?=
 =?us-ascii?Q?pXKT5jPpO6mhBEYI4W+mSXNTDk82BvQOmH7jBpfrImbcH/mWanPOTCcKGnXw?=
 =?us-ascii?Q?CsyPGsPMBSf6z94r88S4IknSF3sjeKDo6beLJQa4v/OHCu3wHt69jAqf4FSA?=
 =?us-ascii?Q?0OkMNpczXPViqvtFOz4Nwc246PPp+GLobUvosZlGeMyzCjvP92ilNapdNUx9?=
 =?us-ascii?Q?zCqyfS6lqohuVwuf4gKDbMlFNWdUicljmFEso/hUQW1AAxthy+73uNvoP3hA?=
 =?us-ascii?Q?gFRKuSciV2xG99cA3tn8K+mYlKugpReLxRAlDVGTZfqUC3626Dv+Wts3ry4W?=
 =?us-ascii?Q?jbiHRhxs6oJAGc97Ui0VVhF6uyk34UpIY+rxXTgFJSgMTo00LtMQOUg5wa5A?=
 =?us-ascii?Q?4p/1GLKvetYVdAR3gzAcHydXymmvXdQYgnwVG3MaY4cKI+OqQpC4CADsZJKL?=
 =?us-ascii?Q?Bnl8oHYatUPTNY+WzTkMkMlZSPO7imzb3EUQ/tkpHyAvuYkAdMhocVi55/zc?=
 =?us-ascii?Q?qGRqMDGKHZmgE/8L8N3AbwGd1QNrle/+CrLrkcyrhK9hhl8XgSeM06Thvdkh?=
 =?us-ascii?Q?EYuZn7HpiiUKiMD4kH47H8TavyCUYWM0GF+OKSxXhwI4qDWJRdByddqYLl/m?=
 =?us-ascii?Q?v1+QUwMJWwcsbH42WYRlNm3uMawQxmpJy2XxNw5nDQQ22NG9ow3Pyl/yIj1+?=
 =?us-ascii?Q?gT8yVc/0ApoGkWSlDwMKloBu+G8pL8EbaOC6wH9vUvfje0AnRkk80BXJUjnx?=
 =?us-ascii?Q?/TlPOBQZaaR4WwIlN0mBBiKALPtfAeUIWXSFL4iC+4h1+vHkRaHqE6TC9Kgp?=
 =?us-ascii?Q?VCRbjztcozVkMIZ/ik14ziT3pC5XDatZQgwjh7I+e1uAzOVhAQ2Ij955qzrg?=
 =?us-ascii?Q?evcG9SDKnam8Jx+RSKwnj5rpLHzL56YwuzR1icr+arGQ1c4wq17VjU+O81HR?=
 =?us-ascii?Q?Mzsy5Xtxgq/KEpVvAHXVwrpUWGpZEqQUqJpMS9kfshrow9pPBrmMsxwdrPEI?=
 =?us-ascii?Q?tU5e7v3a4dWA6Y3hPbPYGxPLfZ9NxA1ADv+osfRAhrQM9GMKUr2WdI/t02L/?=
 =?us-ascii?Q?xV333QI/9oRbFOLItvrB8/+l016EEvJqBhIzqJO3I9BARKOm8Z/myLT9BAIq?=
 =?us-ascii?Q?6u4ZSc6KGjbMv3CZWOVRthV2fbbFHPyOzn9SxvCe76XV9r3YXVhqok1NC1ei?=
 =?us-ascii?Q?oacSwb7JRkhwM6m3P7Vkyd5zgnw6m3lT7VaF+X4US1EmPciG7x/DjDXo+gOK?=
 =?us-ascii?Q?oDR/pH8ZlqHALmEiZdq49myKNBTaO9gGQ/utITdavhYyK7P4ZbXC3yl1I2GG?=
 =?us-ascii?Q?6HHIdP2pAuXd3kB5KW2/uHplk8ffPOMDw6DJRVqEx1fRCYQMNLRME9EB3Diw?=
 =?us-ascii?Q?b+Ti+9nejHBVCy/htutSuJCrNzfhJnh8umoU5krwEkhuZmORhc72dI4pmLAg?=
 =?us-ascii?Q?p1Kbe+bX/ybmQrTd4A9YKpWr7xBurvRfp7dWR8C2jD84K1LB37MQoPNg+nwY?=
 =?us-ascii?Q?uBY2XGiYd6+Bo/ltm2DfOEcTgeFwy5/rnn4skfIlD24W+OIXF/kfkFJPXym2?=
 =?us-ascii?Q?SL/peRobKIvSkEhtxIK0MOMOmSllXuprLuQpnUM72mtM/11P+aX7L5JU8xkX?=
 =?us-ascii?Q?pWkYQzNFOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bf7d02-b468-4bac-19f1-08dedb2cf1d5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:05:21.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1XsN9zPZ7Cn6nmcUCMczcY8g411PUxYrepzGWA524ljNpGMZ3l/t2asm0Nda/k6qohLKlrOBI5Mc7uj23/0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

Add a -B option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -B, set SCX_OPS_ENQ_BLOCKED and
enable the corresponding BPF-side blocked-donor admission policy.

When qmap_enqueue() receives SCX_ENQ_BLOCKED for a donor with runtime
budget remaining, insert it directly into the local DSQ of its current
cid without refilling its slice. This lets proxy execution continue
using the donor's existing budget.

Once the donor exhausts its slice, let it proceed through qmap's normal
enqueue path. This applies the same placement and slice refill decisions
as other enqueues instead of imposing a proxy-specific policy.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 13 +++++++++++++
 tools/sched_ext/scx_qmap.c     |  9 +++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index fd9a82a676278..2ba3e2a4f625f 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -49,6 +49,7 @@ const volatile u64 sub_cgroup_id;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 const volatile bool always_enq_immed;
+const volatile bool enq_blocked;
 const volatile u32 immed_stress_nth;
 const volatile u32 max_tasks;
 
@@ -396,6 +397,18 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	/*
+	 * Admit a blocked donor with runtime budget left by inserting it into
+	 * its current cid's local DSQ, reusing its remaining slice. If the
+	 * slice is exhausted, fall through the normal enqueue path.
+	 */
+	if (enq_blocked &&
+	    (enq_flags & SCX_ENQ_BLOCKED) && p->scx.slice) {
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cid(p),
+				   0, enq_flags);
+		return;
+	}
+
 	/*
 	 * IMMED stress testing: Every immed_stress_nth'th enqueue, dispatch
 	 * directly to prev_cpu's local DSQ even when busy to force dsq->nr > 1
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 67ddd483a4c75..236a9c9bb13f6 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -23,7 +23,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-B]\n"
 "       [-F COUNT] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -42,6 +42,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -B            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range)\n"
 "  -v            Print libbpf debug messages\n"
@@ -89,7 +90,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIBF:C:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -149,6 +150,10 @@ int main(int argc, char **argv)
 			skel->rodata->always_enq_immed = true;
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
+		case 'B':
+			skel->rodata->enq_blocked = true;
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
+			break;
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
-- 
2.55.0

