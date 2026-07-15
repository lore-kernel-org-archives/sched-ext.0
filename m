Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA933CB2CF
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149056; cv=fail; b=mNbexvDf9oSZR0ol7/pxjIJIo9se8woQHD1+cDqa3DeZehDKYVkv/cHwLRTLP5JXhVap9aSIKv65MdGfaJD6ZA7IP1m9p1qJfLvDBpM2he7lrURF2AN/4q9uhazjyF3d0fw2EvUtOAkcuF4FqUFQUgOxBR/ChNnmvdS8X2XN/GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149056; c=relaxed/simple;
	bh=vYk1xaOPehhdEejQRHYlbeboT++AxDNhFTormxRe6B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SoFwn86FKYyUnzDdKfCKXaFT/2JUu0RpIrJlbUP4pAmfKUnaHhMFT3PWlk+Q3q+sdI2e4p4qrDrgPqbIneFb8T99THfyg3uolzgFYZF5UPKkmg5ikn4Yp8rPHG28kX4tWxEv0g/KnwTCTfnSybeC12hWOqfaLWgCwmcAJPJGMs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O1o+FiyQ; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O1o+FiyQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQencZfxQBkESsNbBU5mDzP0X8VNc5uqhLRX3k9leww4LY39bn9hdvJJYQibmY5HNwwhSGrQFdYcuUJi0RP8kVHXzh6l9uvti8SyPoLL2Vc/TwGzKwjth4JcwjHfKR++EM003YdI1S1lAB4L5agybJpkrO4t06mNPswSktlKNoet40HMEGvKrP9/2C8Sh+3GZNRJAYLiIDQoTd3i3SiECe0tI2yZ6RDXK5OOiCyVjzpD+PwInmMy005aRFk7rKuoMiQgssb97AsLkLmNOPGSxkTgl/ruutVjeb0/0bftIbFCG0GJOAAMYZqh4PkJWLcII/2TUPQ/SIPn+zqT0aFAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uQjSbDs5ccdMKJtQxm+Y5KvBU0MS8Fu5nWc5eOply0=;
 b=XzrIzsObJqZZY/1MUa4QvzjFiO9UnkMA/JA7wNF61OeXl/0nITeE6yqLgklcO9fl18DEmtGpLf9h/jN01ymrbw/WyWlxUbATrfeijJYEeKYGeXKWbAUJ6aR8YkzFzprtOVG+hz0n9ifj933+U7o2pmUmvpDqUFBuIezuwWTD7FcYjBZQgNchxz4KdWNZhFNGD1Ie6gO70iJbl6MpufMIbVzkzk5+ES/RB1MyYxjgDMEmoUzazfukvO4WnlduYY0n/GDkEEjU4FrXI0VAwmkPM1L/NHgQ9njxNiTmc65nBGxr70bJi+hesvEBkMTD8MjO0lEgQgKcAaIJye6pv7fvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uQjSbDs5ccdMKJtQxm+Y5KvBU0MS8Fu5nWc5eOply0=;
 b=O1o+FiyQrbmkDqS0qNkhlC8/Tb7IP+fhEsEPsUes19of3xGmJ7RadzRaxBMWqTwbh0yzeVI+Cccw9RmM3FtGi+4tVcRg3yV1L2vP8TtBlmXW0gYKyQxjpfg97hxRB9w59kA0tcMlWrHCUF0UVwvOhGqgCoA5GuQZPSF0BEwMkFqkAjcDtr8kvcb67zzyeemn3Chu3oXsmjlUqot5Zonxq2zrd5uB2OUI/2+QHfKVqW1xxSHTs4vIOOoOqB3t+bDNmVgPG1Nx/fNVH2l8+6vWZvCUjy0i6OkC7RrBxMg45tlH69nL/1wad/igcHTGfDxos/cSszacwzqrquNDnhXKUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:57:28 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:57:28 +0000
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
Subject: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution support
Date: Wed, 15 Jul 2026 22:54:18 +0200
Message-ID: <20260715205622.276220-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: a843813b-5ddd-4121-6348-08dee2b3ae68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|3023799007|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	D32K+ODcFCDtkkNlhj/H/Co8KisWDZVFrwHIlCsf4T9rycx1i4kbk44Ahngf+rsYDncOBudNqAToGtVv7/DNtZGvj+gNt/j8muhfLJo82EBM3FRBqNFEY/Fk8HGS8d5GPlLH/FcxT9VMgXFC6humg/yMW6R2GrGK+clJZrse3YXH0TWrBDw0wlD+nj26x6AfmpiKDJ4V8inxFtjcl1AMn/dDCYfDK+6zHye+foukUDq7mEJGfMx7NXmuYzC2/SgINAvN9uGL/BXUXOTcSBVmqkI91wZovlIA0kePq+62d69IEycZQ2U35IvV7UGaHBoK7Ry1Wb3/+06lza48ViO4FvHmcZG37tbXDpJhC7Esqj9pwDcRW93wf4TSuk36uUZzmVC9HTYmCj6pOtyz9KqqhyFpJKR8lMaL+7hi91zlWyJKtcOi+2GbpejIePbzoQHyNHigdQN239ih/3uJg0xaWk7V3xegHmzM8m8zXB/OZbd+1j/vF4kjhozYQJfe4WrYXuEw1ct7e/5x8inuGnOtfwbTPhJIuQSA4OTnwj9frzMb/MEZSTzTZSVU97Cyxs33qLQmiqfVwuEAadRpW+n1oQ+1lg2JTU5csUaKLUTFMAWQW08Jb5NDePGbwDgBcEvCQILqkhhW+lzNeRVtomTBsQ6zhXQv9pB7tov7w1pEdWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B6pNcEFdp4WtVISuIQPzrqFI+faou3YAv9tx4bf1BkoPBAzqZ6BlBsD68VcK?=
 =?us-ascii?Q?ZozhqjDIrLq/SJjwvYIXigXho3S2jGityopu+iwQBEc6cRyqQcD9TXGpWzSx?=
 =?us-ascii?Q?65YFkjR9/OsXWzQSBe/vALagv+0wTmlbdUqMinjCnoINLC2PnPu7l/nf4P61?=
 =?us-ascii?Q?Eib/GNJ04Y5OWDUdBC81ezs7jtF/vPwktbw3+DJw+77JoRxbwrYA8Ux6A7yz?=
 =?us-ascii?Q?MY4ihx3/+TnLJFo8k7PbfDPBwWZ3Z2N/PPKlu+z1sAFr0x8DoDvA52n5+X6x?=
 =?us-ascii?Q?Z2AdFsPR6ZJQujTmMKhfKNop2ipN5/bzdTck95l5bpvjMQTZdZOTrW4IUv6d?=
 =?us-ascii?Q?TKMk0tpv5XmzcoNPDS4Vtp0JVUZlIo5TKQkD9AniU16Zjp0xNSXEyHakRWKt?=
 =?us-ascii?Q?GT+7/1PIvA10z12tnSGQabuuMEVyImaAa2U6KnpMzoTsuGfr+RJsO0aJ4Sqm?=
 =?us-ascii?Q?+Bhip6dB/kQSItoQd6VRnjBSc4XIUjTHzh2CrzpcJyMuke0wgxUj48vkbTwb?=
 =?us-ascii?Q?puGxtoGyjWXW8FfQj+CuTT5ihrKBgzoG2r67oDFBrIBs0a6R+ak2UMKOeonA?=
 =?us-ascii?Q?SC8LBaXSOJVIalpqM/wKdaOaA4R4VyodWFbkQJswiW70Zqap2kPTJqXpncl0?=
 =?us-ascii?Q?Gk41Upfyz2HE2IIPRLaiZQK155XX1fZD7CjelGTC3iMS7Md17BnwaTtLNKen?=
 =?us-ascii?Q?CRI1mfH9s6BsImTaMbsP1ZoVZ+ELmx2G06rSWQY9R7Gl3zCN071k7Chqjwx9?=
 =?us-ascii?Q?M+Kkd2RFOcviIrO5WidPxCK8j0aSgrAhws7tV8Ag251J2s2X3D5o2mbhSsbC?=
 =?us-ascii?Q?DpF0bbWr6WStgv89J/ZT024NVmOZcTKkGCw2gXJ+AFkDVRGwsSSXS3FwNHKZ?=
 =?us-ascii?Q?IUwhlrFREjOZW7pTUJpAK8wWAGhaZ9W+N07WbRPIi2NoJX9xuj9nWEB5HcD3?=
 =?us-ascii?Q?pGr0R1DbsZ7rwv668KYfmLcKNl1/Q1+1zduD4m0Sy2jXcakIMJH4EwockpRX?=
 =?us-ascii?Q?Rt4WiYKw7pQuppaJ58T+U7pvCI5IgLyEDR+o0KuIiAA9JM7c+BGjxe9yjrqq?=
 =?us-ascii?Q?wo9vBvOtYxrkSiOVsJVPEBz1xPilVo1lw32Yoz0ZHcjcHB99a+z5ymG7ECIN?=
 =?us-ascii?Q?wlfJ8gXY1D7SJsP0TFzZy8h3Xbz10tHLsvEjxljZ/pH71hiFJYnQD3OnmC3W?=
 =?us-ascii?Q?+y7ikM88HL1MqJNGtKJ2kCBiWu4M98wKCbdKo/K2WYsyWhGiDPzuWPsFS1nc?=
 =?us-ascii?Q?FtHKoH3xB6h3iATU5dETGep3pxLPU6VU12m906kF1HhX9b+4RayXL8Hnu/CR?=
 =?us-ascii?Q?bEzIRYzjsjwpblndpulaiB1GPUMo3xlEitX9eN4roG25vnKdh06NBnOS8IdI?=
 =?us-ascii?Q?/7PYpAbb3f1dWTsmgaGcooJpB770WRB/fdefVhc58vgOsJW+th7g8yK2X2pv?=
 =?us-ascii?Q?boLmUcAt6b87QPAkJYpYRRcboeCdaRzuM5A7qpzzWmetdDtImzHudmw1KN+l?=
 =?us-ascii?Q?yq0V3vtz0iIPRtcR6NwrrTGVGsQEj9EaJyicuedq+g0pZUX2lr64aeV5qiNs?=
 =?us-ascii?Q?PNLb5TI7/6fDYLZGmi3VXMVeqNPFAx5zvnFADX8LK/y9K7zuY7ROFd2Wvto1?=
 =?us-ascii?Q?/uLvVc6ANXjNvricXLUi2kUeeeaeJniUzEMWCFsMW/o9SZwuMylUBPskYTK2?=
 =?us-ascii?Q?ehz2LT0nPfDooA9+sHvdnZ3i3ckrDcgEpfRWkyLaNx1uZKCU5CcSmZsXkjPa?=
 =?us-ascii?Q?zvDT5iT60Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a843813b-5ddd-4121-6348-08dee2b3ae68
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:57:28.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj0cEUIrKzPOUcM11pt5fSy0wu264xJQObqYqex33fsEbcwBBfGwlHArQDr300GGhPxbdkjyz04ETgGQqvLkIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

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
index 09aee49120c28..dd308d1c89e2e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -451,6 +451,22 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
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
 	 * A node with children delegates most cids. A task of ours that can run
 	 * on none of our self cids (e.g. a per-NUMA kthread pinned to delegated
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index dda3ddf5b7494..502d9013ae628 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -51,7 +51,7 @@ const char help_fmt[] =
 "See the top-of-file comment in .bpf.c for the design.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-B]\n"
 "       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -70,6 +70,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -B            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats and weight-refresh interval, seconds (default 5)\n"
@@ -336,7 +337,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIBF:C:i:R:J:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -398,6 +399,9 @@ int main(int argc, char **argv)
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

