Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93733F5A8
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995623; cv=fail; b=HFf2RFCzm73P4lwDcC2qicJDQawfwas1OIGZ8P/8cUqKl5i6GgePqTrHr8jUv/qXRXarGuRPHVN+/e1pNfKM0kVIpjfW8xccO5CYlTM8g9i7Hf53w1XP/YyGHs/O/4ifl64c82j0xl4hOSkSSOJUa2p7GXJ/3qfR0pd97hyY+PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995623; c=relaxed/simple;
	bh=njxRx6/sI/89BDPcZUdDroNxGayX396aJ2K9xJX9xE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N1VtP32nkVt220+3hE1/r6/+GwSoPZnjp8cjK5QqoK9CjlXdthfnUr3Vf6SO/U4gZx7owt2eb41r8J7vko+KaQ80wDb+uWv7W7vJd5+QrCup9NvlSHkvCdpcVYKXNRP2+XSytJEpuwCEh8/ofyoW6hlnmOBcpW1kdxH8TKDZKNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/xQFbeL; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/xQFbeL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ8zKcAl5aLM9lMsovBnyUoN7nNSXawXFd4agDX121DToVYHbquR5vwvz4aNOgKW/zq9QIp3unldNWEHRwoiOwh4H+g9wSk+Rc54O2YiEavEV4m+jcGNh9vj+kxMLaC+Jfw1CtVBb5q5+J8W10KlhbI+ZeQdLICB1uS+mI2hnCUNKs+aVv5afRqC+iSJqlgn+s6DJH3+g/9V64UJ4FfLVqssvZ3fzQ2lM1ihm41Yw2zLeLil3XCv7hHjc1BGg3pHJ031nas42IrugJfV/7in+if6u/CTupgxXHkvu8pJyhHZ2RGoK0M0FZhVSqid/PTxLSgbYqugqstjh1KOx7H37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4EXJ7/i3XxvrkuI1VWT7ZO78wJaYK8S0Tp+9WLxS64=;
 b=CvIAt0RescqVlN3qvZzFN98ZgWnj82AtA/th+K6BOJ15/1uyyi9Gg4lQHwalarF99/S9N4ILHTlcntmGI43Ak9AE+5OY7gZU06Zh+viYqj/kRu/PXiTYkY9Ij/TkLE6twPCPfBCFCF0k7sNN80U5AaQmxWbpj8/aGbMYGOvzS4UBm40GrtM4rJxGLX9PJs76ZEz+knlCjOdYslhupkNhLiifBHZ0RWr2Lce/Ima+NDXs02NOWAR34HBrCh6K5rHnLUc/5cUeMTfgMHwQ42kCtmvclsUj3R7E2MxKFG4C3X2y2TbhNm3vpUKb3rymzBGqZ0MGRl9PeyR5V2IbDn+D/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4EXJ7/i3XxvrkuI1VWT7ZO78wJaYK8S0Tp+9WLxS64=;
 b=s/xQFbeLPNuV7sAhAItxCdpOHhdiH5rZgVstcOshUfmELiQOHXNEx62IrpG2fgNWl+T0SZKINLtVZxlFmFlcl8HVWZaDQcanxVisMWwfjzs9Dg+JBVezlRwsVcKkIQqJ+EMg8QX1/Uzwm65ly5GtVxvVW9d50r/mUjHphLOok3Bhx2g9+3ipXGAjRBH/2FayENvlkLiBukdoryZcYC2BY/M/9oGl2tRABoJ0rzYxvTJ5NpSlXLtZSIx9/JRoxq3ATFecHtI5bSvw7Jd6v0WQ4TNdr1ZrESfrpquDnBD2WGs1XEoKfgME56b1ju6/tPBYKoqdfLuD9otfS8616J5aZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:06:54 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:06:54 +0000
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
Subject: [PATCH 13/14] sched_ext: scx_qmap: Add proxy execution support
Date: Sat, 25 Jul 2026 18:04:19 +0200
Message-ID: <20260725160513.57477-14-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::22) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2edc5e-1710-4bfd-d3aa-08deea66bec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FWqNmXst8bBH3QZSA8EHeFPwaus3S7ofOSLe0uuYBk/8qZ91ar821GhGAvjYKp3MWyTkmvC9c9ykcGEuNxqR92UJaSyN8sp6jZXWH62g6Hgogz3QFZ91G+ZvxS6bllZpXz9wVMhrDyOVU9Ae6UctxrwT6OyfVc8pF7SCAfeKRmRDw31SuQukypPGVegX1VgRlWNQlf11tMOMbJ5bizyTuyZYT9GgL4vLs7VjbFB5TBh4FlYvHXNDBrN8tmRRWrLwQwieDN7VEZSYWeT9otT/bYe5mHfVL0GzgFo5ks+qwT8CC79qcH1lxJX6aWtMnbAT7CIuDyGQdmWVl6B1c4jpNqhX5JsBcnSibLIBC16v8E9l2MWkIKS2e4HwdVLlCYQrg4aXHfYdqmYlrGw8GXw9Xon9pjNOT3NRgbbsMEdQpQbjjp6S/Eyj1VUqqwaqmvZtvy3EoFta6K4XrtCCk10xAx1XCSFtGs64qzL0gFKtHjnj7/ug8kLIjMIRUpEDOUXClaDqjtdPF8gFyNNFoewCjTGGKUFpfC0mlJmFW3ADZxuNZl2krq2qf3zGIzCVRV3HQeo9LtE8+iaGPYq8sEwxotrR99E1PKlVXTH3Wh6JYjw6HeD4B0D+Z6rWq/7kchu///h7uFM/jbbTpxUW8I4QRNquJvdvmBUFYzan2xJr7NQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qkpsli0eAQIDoeF6QcV7iQ7lzeIzQr77RAt6pdHFvGKcZGIduWIQtD0KmIVj?=
 =?us-ascii?Q?fnCSBd9PVfB3lDtREPqBYLRFwWrseHt9ss8UlcWHhaknxsq0ZjchaaJNMlMJ?=
 =?us-ascii?Q?2JRucOGIu45EtwOrqbz3q9KWP15xG78D3hLByQgFGupnK4nzuRC/E1s6rCrn?=
 =?us-ascii?Q?iCMBDrlqB2MY7pUgYyCdivB/ti0tglqzmYRFeYoLb8cKII0Qi6TBncwy/wxi?=
 =?us-ascii?Q?wGP+Qj9KaIi1Cvs982ocgJlvF1i0E+0wvsy2EHskGouvzptYmKz2DRMvFU8h?=
 =?us-ascii?Q?dRUltYpQLK5HCGV75yrFke7R8ZysETcnKwiswKah536lOa91PnQKIh07o1MJ?=
 =?us-ascii?Q?uTgSb7jzyF9/bfuxGJ1AYJsAR7wVwdSrx1z+QFfblBnji2vHJkgTxk0H7AEd?=
 =?us-ascii?Q?8MGtq1Hqk6R9c6Udd7m+GqFv/53PJmegauu/9WWR1ABzNGsmQaPc/WrKVHv2?=
 =?us-ascii?Q?kp/Ai/Vxz3hlp7hraTW+iAxIraUNOOshVPfdcWHRYE9LUqskBgGEN4fRYbAV?=
 =?us-ascii?Q?iuo7hPe05oSSXflABaCAGlSPBLvQzwKPB3pBFWw0/4VlKjiq5lgjRwdiZhQX?=
 =?us-ascii?Q?vM/jYVi7dcU03LsATQBKimRyJyieIC8Gt7Ypb6xsL9WC13nYQQ9zHxo+WBPQ?=
 =?us-ascii?Q?g0TpJKTGZRvNYhnHO4+oNqRhEdAitJ9lAsJooXGlx1nEMuKcHTZpYynRBQ8z?=
 =?us-ascii?Q?EQoSKuLuzUsjPSyqfqDXbdWt6L8BeU5KQGyGi2BtSgBDCQ4SLWul+0NKRaQM?=
 =?us-ascii?Q?8HNIChsYc1uRCdCVeiKLqJx0/hzPh9rtXVByL/6ZCXaEEZRMWdeOAYJXK5Yj?=
 =?us-ascii?Q?Ilqu98gS/hi/iy0+ZgHX0XakjITdRMDKu0eEUQVAQeUie8is2BPcZe86a8H0?=
 =?us-ascii?Q?UAY0HoXftIdQ4Wx1/brSFuCLW0Sx7GblG6BOMWofv407Cz5l3x8hTxd2IkcK?=
 =?us-ascii?Q?S2nBn0D4LqQNncLm4AT6SfQrRQN890SoXRLMI7RjtutiFNBM8GRkLiKSKcR3?=
 =?us-ascii?Q?qQP98z9qMprt9PDZxT6WRIR6PkyvLUzPRc81rTIkvDy+FJa0gz8PtpEDdlzL?=
 =?us-ascii?Q?EDwOE/EdirIrKU5Bjt7ER46BHsryIgTwQd78gZpCPIfaQuxd/6qU3FD5eJ/V?=
 =?us-ascii?Q?rnRm3Wm/ucO3c2HIDJMMQ1leJ5RNz1K82aq8xFAJUikBZmmMOBifXTGW8SDP?=
 =?us-ascii?Q?wVSskzo2NJx1E67swUEPDVdXqZGTvg+TB6QQrPvG13cOeQVPrtNjWxQz5njX?=
 =?us-ascii?Q?HzPLSGkmMjmbqI/EVaz3e8oWFdvBjfqfOfm4pmoGi8sojrr6s/2J/L2KfG1z?=
 =?us-ascii?Q?Ho2NFc8fLrOG1pbSegpl3hJGmQ2JriXgkSwvVcYoXGIw9JPoJp8/0hmh2lwc?=
 =?us-ascii?Q?DMg3QUUuicaewyOiTiT5XXax/tH/Fl+jwd+vxJi9yD4iHiKN2QS4TzNVULuo?=
 =?us-ascii?Q?yk2CYwiDKCOyNgbLjzJUUqolmb3Y27W0rLm0eQzfduDkc/trdyp8oN/u71gC?=
 =?us-ascii?Q?vOOYv0rU4toGV9OEN3QEVKc9MhTsoryiIli+dYv3KCLr3bpr9OU5i5wODD0w?=
 =?us-ascii?Q?HXbi3ORy5WEEN3Pne44lDFb7ca4p5vq4+v1fNnvtyPegPetB5WT5kXcB+9e8?=
 =?us-ascii?Q?PV3RsydMqCJ7H4DNJlR7oQZYUMb62iELM3b/zdVcAVAuKyFj0OBhIb4QXMVC?=
 =?us-ascii?Q?xPOuo98X0vOuSpNC/iDaJpVUsaxTwPnefJoh6qZGuHG0yP0WQKWIsBzPCfFd?=
 =?us-ascii?Q?16BII31dcA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2edc5e-1710-4bfd-d3aa-08deea66bec4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:06:54.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz5y1EnDRRzf3p3VtdCiYUoKBkgJUTqkZqwnZL8xB6h165fm2YgNCCs387rnX7+I5Sw4/ayENB2HAtVvMudaEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

Add a -B option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -B, blocked donors are passed to
qmap_enqueue() with SCX_ENQ_BLOCKED.

When scx_qmap receives a blocked donor, dispatch it directly to the
local DSQ of its current cid with a fresh slice and SCX_ENQ_PREEMPT.
This places the donor at the head of the DSQ and requests an immediate
reschedule, allowing the core proxy-exec path to run the mutex owner
using the donor's scheduling context as soon as the donor is selected.

The blocked policy is intentionally unfair and can strongly prioritize
tasks using contended mutexes, but scx_qmap is a demo scheduler and such
aggressive behavior makes proxy-exec support easy to observe. Count
these dispatch attempts in nr_enq_blocked and report their per-interval
delta.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 34 ++++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c     | 13 ++++++++++---
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index aead17658573b..5ca1467c1325a 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -451,6 +451,40 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	/*
+	 * A blocked donor rejected by a local DSQ must not be dispatched back
+	 * to the same DSQ immediately. Move it to the global DSQ so another CPU
+	 * can pick it up and kick an idle cid to accelerate its consumption.
+	 */
+	if ((enq_flags & (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) ==
+	    (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) {
+		taskc->force_local = false;
+		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
+		cid = cmask_next_and2_set_wrap(&taskc->cpus_allowed,
+					       &qa.idle_cids.mask,
+					       &qa.self_cids.mask, 0);
+		if (cid < scx_bpf_nr_cids())
+			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
+		return;
+	}
+
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
+		__sync_fetch_and_add(&qa.nr_enq_blocked, 1);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cid(p),
+				   slice_ns, enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
 	/*
 	 * A node with children delegates most cids. A task of ours that can run
 	 * on none of our self cids (e.g. a per-NUMA kthread pinned to delegated
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 27ffda1c519e8..8e943e8cb202d 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -46,7 +46,7 @@ const char help_fmt[] =
 "See the top-of-file comment in .bpf.c for the design.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-B]\n"
 "       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -65,6 +65,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -B            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats interval, seconds (default 5)\n"
@@ -105,6 +106,7 @@ struct hier_prev {
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
+	u64 nr_enq_blocked;
 	u64 nr_inject_attempts;
 };
 
@@ -187,13 +189,15 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	}
 
 	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
-	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu\n",
+	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu\n",
 	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
 	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
 	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
+	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
 	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts));
 	prev->nr_reenq_cap = qa->nr_reenq_cap;
 	prev->nr_reenq_immed = qa->nr_reenq_immed;
+	prev->nr_enq_blocked = qa->nr_enq_blocked;
 	prev->nr_inject_attempts = qa->nr_inject_attempts;
 
 	printf("hier   : %-4s %10s %4s %6s %8s  %s\n",
@@ -256,7 +260,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIBF:C:i:R:J:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -318,6 +322,9 @@ int main(int argc, char **argv)
 			skel->rodata->always_enq_immed = true;
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
+		case 'B':
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
+			break;
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index c42f7ef74b894..7f4d3b33e6133 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -174,6 +174,7 @@ struct qmap_arena {
 	/* bpf -> userspace: stats */
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
+	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
 };
-- 
2.55.0

