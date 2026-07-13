Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776B40BCC4
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959746; cv=fail; b=mmiw8lozQVf/89OmDQwUGLsYRyrTRhZCRg9YHDI65TUr0YDX3PvUzN307j0upz3ntPXorIc81bDNuEG8xqoxU4RmNI3PG0SVYiTlNb/5t2m/Y1BiXzUIKTn8qAphJYGYhIperAl4YTuant4lE6Oq7EJcJimES2/PFV4v9js0Yxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959746; c=relaxed/simple;
	bh=9srcXO2mdDb8Zu54s6M+en+vbSVxXEOv727csxc6ZoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ShD4Yf+M0PdxvwHIwaAG6y+yx9f4LU+pkz7oG2Os14qXR90yrshIYGMXN+wfNpuDErjpGxX4gsQ7zbNJJXa7fOAj3mS/cp10qMgwnNWMapulVK/mqgSXwprrDEigV7OFcU09iUPUGlPKPVM7hgLJrhgDeDSC5AXEewRLH3Z2ARw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pg/sQegV; arc=fail smtp.client-ip=52.101.57.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pg/sQegV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmlP1cUmu212SH1mR1zczfZyCFbYLKkgN5JvsfYJkkldgr8SLBz+0K2vOsYEfezJkW2N+R6HsBr8509Qb1KBEfZRIYF53FMotbqVH9JR4a3yR/rOjd1dXGG6P6ZvrTQkMdeEM/4w7KPQQJJ3Bth87J/s43+eQ21wCFhIcEXIa7KBvtf0dkWEgzqzqTdGYqLecwXER/WA0euL3QslovFEA59byYZCNzZOJOJKhkuwNPTiKXxqBL9Cy/yUWxDx2LAMK7tkVXQmPLGyBB+iGgmQuemS0a4NhDo3SpC2O0fXcRAbLRnPu2YT61nCkipNBCN9jgw8xaBaJ7fjGFlOIUp9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYJMFXFKeGd7BF3reeJHOC+fl8HhDw3BRfjNKSzZUMw=;
 b=CYvF3kb2p3JFs3ZeN80ZBD9emxwwcRAZvh6U/HXMcHXkuJQOPswhAiDKC0tUGupuHml/Oo9Rf/C6xuDePy9qjaY4/iV5anfVWlnngpv+yTMuGiQOMF8bAxReu+XGl2cRZ+sdxpM1k68PG8kmlVFiP6dQ/XXLrgPjM1mr9xnCMBR9CYMaiVSKi4zDWNeMkqPOQFaIr+RGvX2ahMxTm9zgYc/qfyueSFl6joBWGU8k2129cPOJaDzZ/4L6nAEzGUiHqFWvSJaWmXP6M91I1d/cqOwALM3jNtzT4FYfSDDScKtZOIW+TwYy+wZyfkNt83bfzsPo2glIIUnbpuAl+J+FNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYJMFXFKeGd7BF3reeJHOC+fl8HhDw3BRfjNKSzZUMw=;
 b=pg/sQegV5fZCdn8W1wwO+HFgjUfWKFPDhtDm/uGOmE4yXg9WIIuYR1NjlNwkdlHboBAyfjHWUetHIUlLyWH8tFSF/dLwees8MD9bqZai9OP3XutxlM5gdQyl/JFxytFTWvy40su5X2SKbndYGHhAlN1ErqiW1n3tj2PkLxrzIjfIxFFjZqZkcFlcPpEGyc5i/E2kNTL4blNz5WGPjtQJ6BqJRq+25FzuBtsRO6VbGqJEqAVNl9OUwJdzHy/RU4hwBEg60uJ5z3NU40MrJUkNkPW2f0J+7lfwOFSngMBidtbcu16c2VC57fYjI80ojjTXhVXNbhg00ZH7nKtcSgIGOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:22:20 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:22:20 +0000
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
Subject: [PATCH 09/10] sched_ext: scx_qmap: Add proxy execution support
Date: Mon, 13 Jul 2026 18:17:09 +0200
Message-ID: <20260713162112.26785-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713162112.26785-1-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:a03:333::29) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: f172c088-23c8-468b-da2b-08dee0fae9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	qn299Cz6K5wGZ4KOBgxAa/moSkNZKNhHW7dkikqLOl8v6mGUPuCgmY5iN7a0bSgZ4q65IY0tvqDDvu0+6hl+YIZQVUEnxepdwv4Im9xawEPyaeoEef+hgCLO29JzfB75s3jEoG2aemZZ9sA/f5pq6Ay0CbXpHIdyYxO0Oh+x3gPB4BWw7ucWcPm7AfmbD85shdWRZLr96XQ+uRgFD268mOxdMCAMGxvy9TRm8Zgkt2zVq1oyj8a+9T4hthg2sTrwz6vDehLgzD5hlmPBmllod4Kr2fSkzGdrBAWowyQqZmcB4xPJx68daLfgOr6UvL3hbgXytICMwWVE6n0rlTHwdnEQVKlQv741PFeBl6XZy5tT2wkDgDocD2hOQa2AruVvMHJEyAttErrxKU9Tu+lu/fpCmx8CDFga0qvzAEUklRi7HSNqKZDnLSMpaxGz2pEV93155b48c1wEpr900vdYl8d0Hvk6TOUCcj4RupCAAZkMqwOsXqY+hVMD4VXCGi3hr5za36tbPN2n0mqNDu5EciZHWlPCQwfT6xgYRtbNTvVFpWZL1N5XPXWX53fYCLQhrkJagc4dU0NuZpc3sUFSh89xHLY/6xdmmWGgHYcyi01IP3rsBRmqPW7fCsaqbrWf4tOWc/dZXCGI2XHguB+EsaXBDuFa60f9AujSnYusZiM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ooWDB++xPlU/R096VTVPDPrxxzNre3DP0VY/YVyTlO0YVCB/GY/MxFimmMrP?=
 =?us-ascii?Q?ZNSS+eEUlLFVCkSAVTRMk2kexADeoAsDDDB6SOsa3RdJWyid467miC3hdE8u?=
 =?us-ascii?Q?/uA2eytojP8kf8v71UEY+YHggdx/db1BqIzYyhrWdXFrnPVGQ+wxJY0rY+7M?=
 =?us-ascii?Q?vNCTxlWuJnCxxEGQeG2s6bzTjlioDQOTG5RNKF2wJEv8SpZ8kvQLe085g7RY?=
 =?us-ascii?Q?U0NgBG135EOGZCaaS4D6NMu4fsjpfdRyO36DYLK1KDl5z0/jN3+uSvOVxcPY?=
 =?us-ascii?Q?ViCNig+oJ8xlNf66zGtsCUv4Sk6m6qT98PEjQXlGEEKI7CfipgYq3WCbH9B4?=
 =?us-ascii?Q?VWJw9GKPnPwZhQYkXBWCg9aVtCcKH4UwcV0op0PwMfbvWRGeyoI+vP9qnly7?=
 =?us-ascii?Q?1fEtA+or6FpqEdAHrLCrTVvOyGOElcGj3naRyj+J/lhANVfPBCsjY42I9HVB?=
 =?us-ascii?Q?r43Q5oZUktlQl7bs2BxQI9NvxoS7dhtPUmBuof0hinU0/mHYOV3dqisZjjQX?=
 =?us-ascii?Q?LcvxCjKU9Gv27Nt4icc6Cm0oCNJZEWNtl6TO+fZksydsg6et+oj98wYglfBI?=
 =?us-ascii?Q?i9fuP8AmljNwshgvYCtKnHI+b+JXuVcW1rhtYYLUBEodi253SPLBclmaT5i2?=
 =?us-ascii?Q?Er/BbP7dVrbc5hMfBGm9mFkoXaXkCysspgZdxgNqis86XWBTw1PtEGj0mJJX?=
 =?us-ascii?Q?noX1wHuuo63wPdR0IliuSLUCp4fiHhEurRrKnWLSXUP6m6Fs2hEkG9Z8dfnJ?=
 =?us-ascii?Q?GDR5deqRLz5Ds7O96mYTaLSzppzzmgrOJO2xGuQTA6ILlnQFIHZD0OGX8TRh?=
 =?us-ascii?Q?G4Vyu+O2XvXuQTxFZAHi5nxC9LzSghMvQSW+VcgthGJKgexDnWMkzgXLk8wN?=
 =?us-ascii?Q?wIumqfPqXXKwtvOuK4O6957wbS8A/qje7/OtufE/ECvrDtbInJh8DXvbqK5j?=
 =?us-ascii?Q?OOtRpBCtOIn1rJzYBZMynzDJp8lpFeXeRv3+yy9dIRWcYcEtV1JG7vawag4y?=
 =?us-ascii?Q?Hw42I2fnRlxIrbmzAqxiGK3xQ73ffoHP+T/7saA0pDr3ph3JOCjpBChOZSek?=
 =?us-ascii?Q?h9N5aTKrBR5Vj5c+IOZzsjcxK9J8y6wlnu3PsWuhPpnN4cm2Jy3FxM7H3bDG?=
 =?us-ascii?Q?TyEcDc86eKs8opevVEZVD86lbxMHyIptsR4w5VudqvJNcQQTYN8XPQz2aiIG?=
 =?us-ascii?Q?xbVIsxAwKDGPNBAFQHXIcXXk0GB4f1lDIgMQWflssG+liM7ia3W7KcJnqfg0?=
 =?us-ascii?Q?HQWRNxsS8S14bnSgXgTPc1dA9MyuOphS/NiwPHwoo438pqcqUKWK1aAeFN/O?=
 =?us-ascii?Q?VZXRU2/GXh8ooAQpYfSu7Ls65oFb6Z1td8egEWCyLS2E4kubw14xXSPDbujX?=
 =?us-ascii?Q?hb+WKcI0dlFx4m6SxWnOl7L0L8Ln2NNol1uVOdDjJOpY8zq2eGJIVMfaygov?=
 =?us-ascii?Q?f40PTJTzL1OCm575YOKWl7Enoavehq7Pc9p4K1FRxdwmVOANdtm//tn7+cSq?=
 =?us-ascii?Q?Ke0hLZUksc7S8Gm62INyIyyHJYE6SecJ6DnPtnAJzk1uL2S54+MvKUA9SAMn?=
 =?us-ascii?Q?NES16nSwtsHXdggdhcKWODmBD8o2DzCIeAlUsmVAovbB5eTWGsfPeQ1mtCB5?=
 =?us-ascii?Q?rKzpuzc6YLtAmaMGjPegtFe3TGT5glergFKrgfvEcxiu+ejaX6xyn1LJQr01?=
 =?us-ascii?Q?W2yI+e50/0iSWvpJ6tlqM31ipqBe6k6wor8R2OtWZQrzKF1vBqf9p3GM0q94?=
 =?us-ascii?Q?m6b5sLbo2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f172c088-23c8-468b-da2b-08dee0fae9c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:22:20.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0A9k1bkkl1SeC0Oj5Mo0PhFOWsyhnJHSfIYGxGS3/Oe9JlkqQG1GcS2f/Q19p/VzVwGkc3p76jWTjm+3dAXBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

Add a -B option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -B, blocked donors are passed to
qmap_enqueue() with SCX_ENQ_BLOCKED.

When scx_qmap receives a blocked donor, dispatch it directly to the
local DSQ of its current cid with a fresh slice and SCX_ENQ_PREEMPT.
This places the donor at the head of the DSQ and requests an immediate
reschedule, allowing the core proxy-exec path to run the mutex owner
using the donor's scheduling context as soon as the donor is selected.

The policy is intentionally unfair and can strongly prioritize tasks
using contended mutexes, but scx_qmap is a demo scheduler and such
aggressive behavior makes proxy-exec support easy to observe.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 16 ++++++++++++++++
 tools/sched_ext/scx_qmap.c     |  8 ++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index fd9a82a676278..5285484733507 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -396,6 +396,22 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	/*
+	 * Insert a blocked mutex donor at the head of its current cid's local
+	 * DSQ with a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate
+	 * reschedule. Once selected, the core proxy-exec path can immediately
+	 * run the mutex owner using the donor's scheduling context.
+	 *
+	 * This policy is intentionally unfair and can strongly prioritize tasks
+	 * using contended mutexes; scx_qmap is a demonstration scheduler and
+	 * this behavior makes proxy-exec support easy to observe.
+	 */
+	if (enq_flags & SCX_ENQ_BLOCKED) {
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cid(p),
+				   slice_ns, enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
 	/*
 	 * IMMED stress testing: Every immed_stress_nth'th enqueue, dispatch
 	 * directly to prev_cpu's local DSQ even when busy to force dsq->nr > 1
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index f1eaebcab5dc1..85315c61a6476 100644
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
@@ -149,6 +150,9 @@ int main(int argc, char **argv)
 			skel->rodata->always_enq_immed = true;
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
+		case 'B':
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
+			break;
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
-- 
2.55.0

