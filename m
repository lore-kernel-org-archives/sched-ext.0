Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793074583;
	b=TYgseRc0/PbeXaMudTl6EbQ/N/Nr7MEo0V5SNDDiu8hMTgMRk8KY4aJ19cID3jcVw35P
	 uUtrcYTk1giDUp5DL3zcXWfNnAb9jrYuhdYeohi9sXmCYRwyRCNmevWmskWiLKs+lcVZi
	 Mf306YynECMMHsJ8dYeUX0QSoG3Ezu3WUios543IoSYrpX+p5e9Ic63uUir+MRQAkDJsy
	 CZIxlvCk6McmwssacvJcyNcPm9kCl/YsPGPTb5Fofkk3+Jil6lNrZK4BO2k6WM9kkqcNC
	 6g8j/jqa1x+BYWuVhTay3gXnB3YYsk5m/8Wkv662r52q6123u0dkM8d+r9NfbvvWIRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074583;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2pfBfG+xONTkBrCzxAYzXfuivJwnIXyBhQKpTwtb3hM=;
	b=E6RIN5MHOEBgwujk4wIVOqDrr3tBxfg2vOESNnPJzmn9rhc+kaGsauPtDxYpYNflubuT
	 RoHh4u5g1i1u+JVldkxUi7+W8gLm6SzxQAFI1EcIcodNn5W31YcwvALOPP2WUL+tz3O+d
	 xr00coBLpoHtwKmDjlsxhzzRI55Ys/FuxpThw5c2QSySAKnkKhvVmOpXJVt8eMlbCctDe
	 8Q2FmVmg/nvzLB8g2BAd+LObKK0X996UZHIU53pYQUqUfG3g7ai5DH04NdVI+0zC3k/fq
	 MIedU7pVxn2+Rg+oet2R+NDNOvCrz2umMRa4M683UFuhTvFEZvkmNjb0SiaajkTIsmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qbLUt5bS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AEA606A322
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 04:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4AEA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qbLUt5bS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3NIGi0/3lRfwslF+78WWxt8iFyB69EE3K9Jrk4m//22VzmHxIVMXR576MX6mnoTTfHWfID7XQf8tSALT9TFBsFdtk0VIroleoZ96sTyDQBC2FKewQcXtCLMAGIffqIYRj1LG+UjxRnlUGVodl9TszDbOul01wBcDbUPjENOHv+HkgkwU5pwDmVR2QaEdOMtPHOPrNYq8jxims3Ja/DzmuDQnjzrPkOh/RDty3Pa58f59wtR+vXt47dmgLJ2/m9WpRUw1rCvS+2m13F8nQZ8WUNVrZrLaD9gTQioi7K+uhafDf8OI0N2VZ5ne9xCv8imi7B0MvoMpxx8AhQT1Qr57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pfBfG+xONTkBrCzxAYzXfuivJwnIXyBhQKpTwtb3hM=;
 b=BFkujBXpPzf+/qR3v7vYn86mupcv6fqxGxc13gOO2cEgcTgw0XrlIA/pdlwsOLcDEoajtDlK65byMhQFZ/zGEkR1iOfmFQCcI//niEmVIfoP4vbGBAOmR0752XfuULYU8R+HCjyWW/PdXy/ei/b5D0UMUX2BCn+koF+l4vSqhGxbjMcTbq+a/ON/o83oqmgIeWaoGUbIDQaiy+TkV/zXVskIETPF75o8rO70oIKVUafJHapXAs6zsXK3egTgGWpEfGsiLTUb8WC5HgXOXUPwgI576Z5CrX6XqsZj9eAePE0My7NrauVY3cxKD1sC0nQmmYNQCFIBD32obLgA5/ixlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pfBfG+xONTkBrCzxAYzXfuivJwnIXyBhQKpTwtb3hM=;
 b=qbLUt5bS/DqM9KOcoXnyYSsc3DTnwzFAJzWeBmRV0zbes5W7jSqf502daaLBKWJdIkG7IEcriHVO8rGeeUd4NqHkCRpAgWNn5z0OXwWZb4D9sbf256n9G67k1dxtmmVGfbeQ5upHxO4iURXB14F/eiDp1SciY8k3+rMlJcf2aSvfJpzI0DuvhmUk94RQSZ1Oo2U2VqBohstRoPrupo5SraE33fJuHRBzHmoBn9R1LtG7hB/GwYyHy6mRSZemJpsd5YKNqHdd2uCdinlIoLsxX2zZM8V0bj8b2DtavXlKHArhEPPExkgzgUuEJmJZDzUPGH2v+p+v5LKfGpas5A2jbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY0PR12MB825472.namprd12.prod.outlook.com (2603:10b6:930:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:16:19 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:16:18 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
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
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>,
	David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] selftests/sched_ext: Test preferred NUMA node notifications
Date: Tue, 27 Oct 2026 05:13:35 +0100
Message-ID: <20261027041536.3317971-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027041536.3317971-1-arighi@nvidia.com>
References: <20261027041536.3317971-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0098.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::8) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY0PR12MB825472:EE_
X-MS-Office365-Filtering-Correlation-Id: a03bd8c1-c232-4040-0319-08df33e10cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261009223027099003|261021123027099003|261022113327099003|261022105027099003|261021135927099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	z4QeyGtHZx6Lr353UULz7gcMkjHwGbnapePXDR5E82XMxvHjuX6XY0lIDjjIicqrbnSS4twtVMrxuEW9GHqu4Ou7HiWUqMdk2XWJnBF4snUP7yqoB63XeUaAmNtreK7uTcvHT2N9IlMADZQFFdET1uq/qtukfs3/muB03Occe/k0rqblzK4CYykt23Q+XcJkRJ+zGtTSb10AptWClP3EThsIA0luuH3TmMUUSJ56v+aiPHU3u1Y01631pj6/+KmGWWQQodMrKe7daZPJPTaRUXbAZ2ANuUMXkyN4qOpRdg/mtabwEQ10xUS35CoYlTZNwPNSaUvqwP+Eu7/efLnj0efLYiWH0XpspWWIpMf58R0RdA84NGZXcQ1wMFdQRkCF+X8YW9iAFacpfEb73JJbXt5Z07L1xIayQkUaOxTKOuudbfB1K375aLH0EicBVsK0JsqqVbjcxTgvVfHHqhg17d96oAzK11wGKUUKfn1Bm+juepXpAitfPSXJ1hX3VSbanHIi+qgWZHGgATzlk/Ey9cc2oWGqIgpT5QMKVyPQYx4ssguww90SFAJJ4+5TEzWN8B0iCRCvGaaVrPH04AoSRLjttUjrBCecxBWbEItUXjNkd15gkqD5MGpBOzqKevbogBn4+SvwzdGj+zj1lLSKJngsU5OzshCrAqNPFf5vVdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261021123027099003)(261022113327099003)(261022105027099003)(261021135927099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0MEOn8/3vh4gUm/7Rp297stkzo3TC7NlA22LMD59gkvO1fXuCFRnKlRgNcQE?=
 =?us-ascii?Q?LJ62R3OC6A5aC00Ey8RuYpEPxqSauA/AXzLxdEg6EI7B/kbpL+EZL48C+EJy?=
 =?us-ascii?Q?WDWKM0jpjwbTaTVrkFFltU0ctsUN+k72hthacoHjFiR+37k9UIaA6U3WXeHA?=
 =?us-ascii?Q?Z+NVU3bbGNH+AEu6De9wsJ1q3MebD8Vhgxgc9orGCS35y8KJzLye5kR5HtUd?=
 =?us-ascii?Q?tB7fNoYsnWs/5+uokBNoCb/EocGSMuLimBx4e9s7Ve6T5lOfMd8R0ucWgSoW?=
 =?us-ascii?Q?QsHA9jnABbqNauoZJ/203aCERxPVvnA+eEhcCOokrrEKSJlv6ylDXyYrwMvL?=
 =?us-ascii?Q?bUU35qkCnd55ycFS4qj2FKbXFD+HnbuW4ndvVXEVAIItGSB3yZp6xJpOWDIL?=
 =?us-ascii?Q?TT/kJv3ORo0/yVWQalCYxpn/902bmfMsKDBhvSqqFkx4KyfxxBo1TQRd2Kol?=
 =?us-ascii?Q?LWSiDlonzyL0RZH643v9uGAxVUciAfOxqjC6Ifu8tJCCGdhwxp01bLUgV3d1?=
 =?us-ascii?Q?+iBLqXIiEBBkSudFhQEqG2UTF8Azuh28SGrqMKaZRnvL4qzriUWIdhGDMR3/?=
 =?us-ascii?Q?/7E8RfMv3DTq+Lpu19gfMRKWi/Zhec5curXYKa3SPCkOHgm7As3yTcmxVQfm?=
 =?us-ascii?Q?tnbhPYferTpXdC8Ebimmyf0ndeeQDhvaTObeLUu6j7KEoO5CqrWyFgMEEC62?=
 =?us-ascii?Q?OQSv87m6pK6kaTxN+ZNsvIGtdJQNS8DSKqAGOd96DBS9UznPONXWj/n2/h0o?=
 =?us-ascii?Q?G2BNQhPsupPOkKwa9FP4wGaW/hwJImaWHELO5a5tZzBMVUNIGqkU+DLzZ0Z8?=
 =?us-ascii?Q?dpxnzkiP26aD/L4Jh5aVWvGtFIoj38qm5jY2eHSBSAGR07JUB42V/0Sco8MZ?=
 =?us-ascii?Q?GxiAx1/ByjjLlw3L+3Om1Lwz4jrRpGIyuLxzLmnyHaa8b0ZTFD3d1Hw/Tjtq?=
 =?us-ascii?Q?2yN8wkmiQ9kHIkvJ1w3us6e8Ye891QaszhuoHivDJjfbcI4o9CkxUB84UpOi?=
 =?us-ascii?Q?ciHisvcyzDW38GAm0inOAIknNbgFQzKXN3s+qezMUV8Uk9SPTcj2ljad1xsS?=
 =?us-ascii?Q?84SU654/co3lbFRzpNJcqgXgunz4H3+JC09z/DkKGCllc7UMJSgp6xdeecxJ?=
 =?us-ascii?Q?zCscqeCHFsOwOq5tHAToDX/RBHmkvnuIkDMWOd3pJl5OTYA7Pj6QvM4AlrM0?=
 =?us-ascii?Q?c2C8+eXC96+WKszVmCUj2pnVDvv4KHXVwVsssNgDR38lVQfF8kB5VnhDn6T8?=
 =?us-ascii?Q?nNZc3Swo/6+AOBTHxy52YiSytbb/cQJrbT3DbsZGElV34gCcDf3o8hz74wd3?=
 =?us-ascii?Q?21Bnn9Wi3ooe4g8v/puo2qRXl+YRUk8D0bfJKyAI5YgHKSgnciCxl6rFmHxa?=
 =?us-ascii?Q?DCJNuo5yhil7OvusIgLDxnVE2DaeonalPDtL2y4wMKl/V8k1WsYsPG9+VBNZ?=
 =?us-ascii?Q?HwgbyAjqg8VEItf53Op7KS9bqLkqwqVhr1VtbWpI9Ljc0qj5Dod2HCXlT35k?=
 =?us-ascii?Q?tdOo8k9WOs6eisOBmkH/G0oqA2z/voikXAANFoYKYtFrK8NEK3WQm03FaNDv?=
 =?us-ascii?Q?Perj3GLbNEtrLG1lJSLhanvQy93YcMRB370vRuKcpGh5A+4XpfSQ53FPnmGU?=
 =?us-ascii?Q?tldwqvB4deQEeHe7vD9YvF+JxRuivF+uQ7RK1qAqcZ/2Db3jvPtIbLC63I5y?=
 =?us-ascii?Q?DKtJBwvak0RPMCMnEQXCSD6Ehgdj5AfdPUWauSZkbVu5jVdx4hiK75HlE93Z?=
 =?us-ascii?Q?0GSMR80dpA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03bd8c1-c232-4040-0319-08df33e10cea
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:16:18.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT4W3YRHBaK9SzpMq07W/ondf+WRpnH5p1I/spWixxvOC7UIrcYb8lFu831aUNDHJfOTLWSHA0JeyZ/ywx2iCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB825472

Exercise ops.set_numa_node() with a scheduler that tracks enable and
disable in task storage.

Require an initial notification for every enable before the task runs or
is disabled. Validate node IDs and check that notifications match the
preference returned by scx_bpf_task_numa_nid(), with no duplicate change
notifications, and that the kfunc still agrees with the last
notification whenever the task runs.

Run a memory-touching workload to exercise hinting faults. On a machine
with at least two memory nodes and numa_balancing enabled, require a
change notification: run the workload in a new process, which starts
without a preferred node, until one is reported, for up to 30 seconds.
A preferred node only depends on the hinting faults taken, not on pages
being migrated. Elsewhere, report the notification counts without
requiring a change.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/numa_nid.bpf.c        | 142 +++++++++++
 tools/testing/selftests/sched_ext/numa_nid.c  | 233 ++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/numa_nid.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/numa_nid.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 44083f1c65969..af4cd6c682ea2 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -187,6 +187,7 @@ auto-test-targets :=			\
 	non_scx_kfunc_deny		\
 	nohz_tick			\
 	numa				\
+	numa_nid			\
 	allowed_cpus			\
 	peek_dsq			\
 	prog_run			\
diff --git a/tools/testing/selftests/sched_ext/numa_nid.bpf.c b/tools/testing/selftests/sched_ext/numa_nid.bpf.c
new file mode 100644
index 0000000000000..e584112ca957f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/numa_nid.bpf.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify initial preferred-node delivery and subsequent NUMA notifications.
+ *
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+struct task_ctx {
+	bool enabled;
+	bool notified;
+	s32 nid;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+u64 nr_enabled;
+u64 nr_initial;
+u64 nr_updates;
+/* Notifications with and without a preferred node. */
+u64 nr_with_nid;
+u64 nr_without_nid;
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(numa_nid_init_task, struct task_struct *p,
+			     struct scx_init_task_args *args)
+{
+	if (!bpf_task_storage_get(&task_ctx_stor, p, 0,
+				  BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return -ENOMEM;
+	return 0;
+}
+
+static struct task_ctx *task_ctx(struct task_struct *p)
+{
+	struct task_ctx *tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+
+	if (!tctx)
+		scx_bpf_error("task %d has no task storage", p->pid);
+	return tctx;
+}
+
+void BPF_STRUCT_OPS(numa_nid_enable, struct task_struct *p)
+{
+	struct task_ctx *tctx = task_ctx(p);
+
+	if (!tctx)
+		return;
+	tctx->enabled = true;
+	tctx->notified = false;
+	__sync_fetch_and_add(&nr_enabled, 1);
+}
+
+void BPF_STRUCT_OPS(numa_nid_set_numa_node, struct task_struct *p, s32 nid)
+{
+	struct task_ctx *tctx = task_ctx(p);
+	s32 task_nid = scx_bpf_task_numa_nid(p);
+
+	if (!tctx)
+		return;
+	if (!tctx->enabled) {
+		scx_bpf_error("task %d notified before enable or after disable", p->pid);
+		return;
+	}
+	if (nid != task_nid) {
+		scx_bpf_error("task %d reported node %d, stored node %d",
+			      p->pid, nid, task_nid);
+		return;
+	}
+	if (tctx->notified) {
+		if (nid == tctx->nid) {
+			scx_bpf_error("task %d repeated node %d", p->pid, nid);
+			return;
+		}
+		__sync_fetch_and_add(&nr_updates, 1);
+	} else {
+		__sync_fetch_and_add(&nr_initial, 1);
+	}
+	tctx->notified = true;
+	tctx->nid = nid;
+
+	if (nid == NUMA_NO_NODE) {
+		__sync_fetch_and_add(&nr_without_nid, 1);
+		return;
+	}
+
+	if (nid < 0 || nid >= scx_bpf_nr_node_ids()) {
+		scx_bpf_error("task %d reported node %d, kernel has %d node ids",
+			      p->pid, nid, scx_bpf_nr_node_ids());
+		return;
+	}
+
+	__sync_fetch_and_add(&nr_with_nid, 1);
+}
+
+void BPF_STRUCT_OPS(numa_nid_running, struct task_struct *p)
+{
+	struct task_ctx *tctx = task_ctx(p);
+
+	if (!tctx)
+		return;
+	if (!tctx->notified)
+		scx_bpf_error("task %d ran before initial node notification", p->pid);
+	if (scx_bpf_task_numa_nid(p) != tctx->nid)
+		scx_bpf_error("task %d kfunc node differs from notification", p->pid);
+}
+
+void BPF_STRUCT_OPS(numa_nid_disable, struct task_struct *p)
+{
+	struct task_ctx *tctx = task_ctx(p);
+
+	if (!tctx)
+		return;
+	if (!tctx->notified)
+		scx_bpf_error("task %d disabled without initial node notification", p->pid);
+	tctx->enabled = false;
+}
+
+void BPF_STRUCT_OPS(numa_nid_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops numa_nid_ops = {
+	.init_task			= (void *)numa_nid_init_task,
+	.enable				= (void *)numa_nid_enable,
+	.set_numa_node			= (void *)numa_nid_set_numa_node,
+	.running			= (void *)numa_nid_running,
+	.disable			= (void *)numa_nid_disable,
+	.exit				= (void *)numa_nid_exit,
+	.name				= "numa_nid",
+};
diff --git a/tools/testing/selftests/sched_ext/numa_nid.c b/tools/testing/selftests/sched_ext/numa_nid.c
new file mode 100644
index 0000000000000..de540dd13f468
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/numa_nid.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <bpf/bpf.h>
+#include <linux/numa.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include "numa_nid.bpf.skel.h"
+#include "scx_test.h"
+
+#define UPDATE_TIMEOUT		30
+
+#define WORKLOAD_SIZE		(64 << 20)
+#define WORKLOAD_THREADS	2
+#define WORKLOAD_SECONDS	3
+/* Returned by touch_memory() when its buffer can't be allocated. */
+#define WORKLOAD_FAILED		((void *)1)
+
+/*
+ * Touch a private buffer for a while. The hinting-fault scan skips the pages
+ * of a single-threaded process that are already on the node it runs on, so
+ * one such thread alone would never take a hinting fault: run two of them.
+ */
+static void *touch_memory(void *arg)
+{
+	struct timespec start, now;
+	volatile char *buffer;
+	size_t offset;
+
+	buffer = malloc(WORKLOAD_SIZE);
+	if (!buffer)
+		return WORKLOAD_FAILED;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	do {
+		for (offset = 0; offset < WORKLOAD_SIZE; offset += 4096)
+			buffer[offset]++;
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while (now.tv_sec - start.tv_sec < WORKLOAD_SECONDS);
+
+	free((void *)buffer);
+	return NULL;
+}
+
+/*
+ * Run touch_memory() in the calling thread and in WORKLOAD_THREADS - 1 new
+ * ones. Return false if a thread can't be created or a buffer allocated.
+ */
+static bool run_workload(void)
+{
+	pthread_t threads[WORKLOAD_THREADS - 1];
+	bool failed = false;
+	void *ret;
+	int i, nr_threads;
+
+	for (nr_threads = 0; nr_threads < WORKLOAD_THREADS - 1; nr_threads++) {
+		if (pthread_create(&threads[nr_threads], NULL, touch_memory, NULL)) {
+			failed = true;
+			break;
+		}
+	}
+	failed |= touch_memory(NULL) == WORKLOAD_FAILED;
+	for (i = 0; i < nr_threads; i++) {
+		pthread_join(threads[i], &ret);
+		failed |= ret == WORKLOAD_FAILED;
+	}
+	return !failed;
+}
+
+/*
+ * The node list is in bitmap list format, e.g. "0-3" or "0,2-3", where a range
+ * always spans at least two nodes, so the second node is either the one after
+ * the first in a range or the next entry in the list.
+ */
+static int second_memory_node(void)
+{
+	FILE *file;
+	int first, second = NUMA_NO_NODE;
+	char sep;
+
+	file = fopen("/sys/devices/system/node/has_memory", "r");
+	if (!file)
+		return NUMA_NO_NODE;
+	if (fscanf(file, "%d%c", &first, &sep) == 2) {
+		if (sep == '-')
+			second = first + 1;
+		else if (sep == ',' && fscanf(file, "%d", &second) != 1)
+			second = NUMA_NO_NODE;
+	}
+	fclose(file);
+	return second;
+}
+
+static bool numa_balancing_enabled(void)
+{
+	FILE *file;
+	int mode = 0;
+
+	file = fopen("/proc/sys/kernel/numa_balancing", "r");
+	if (!file)
+		return false;
+	if (fscanf(file, "%d", &mode) != 1)
+		mode = 0;
+	fclose(file);
+	/* NUMA_BALANCING_NORMAL */
+	return mode & 1;
+}
+
+/*
+ * Run the workload in a new process until the scheduler is notified of a
+ * preferred node change, for up to UPDATE_TIMEOUT seconds. A new thread
+ * inherits the preferred node of the test, which may already match where its
+ * memory is, but a new process starts without one and acquires one from the
+ * hinting faults of the workload, whether or not its pages migrate. Return
+ * false if the workload fails.
+ */
+static bool wait_for_update(struct numa_nid *skel)
+{
+	struct timespec start, now;
+	bool ok = true;
+	pid_t pid;
+
+	pid = fork();
+	if (pid < 0)
+		return false;
+	if (!pid) {
+		while (run_workload())
+			;
+		_exit(1);
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	do {
+		if (__atomic_load_n(&skel->bss->nr_updates, __ATOMIC_ACQUIRE))
+			break;
+		if (waitpid(pid, NULL, WNOHANG) == pid) {
+			ok = false;
+			pid = 0;
+			break;
+		}
+		usleep(100000);
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while (now.tv_sec - start.tv_sec < UPDATE_TIMEOUT);
+
+	if (pid) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+	}
+	return ok;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct numa_nid *skel;
+
+	skel = numa_nid__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(numa_nid__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct numa_nid *skel = ctx;
+	struct bpf_link *link;
+	bool update;
+
+	/*
+	 * A preferred node change can only be expected on a machine with at
+	 * least two memory nodes and numa_balancing enabled.
+	 */
+	update = second_memory_node() >= 0 && numa_balancing_enabled();
+	if (!update)
+		fprintf(stderr, "Skipping the preferred node update check\n");
+
+	link = bpf_map__attach_struct_ops(skel->maps.numa_nid_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	/*
+	 * Give the scan something to work on, so that the tasks of this test
+	 * can acquire a preferred node on a NUMA machine with numa_balancing
+	 * enabled. The scheduler reports an error through UEI if it ever sees
+	 * a node id that is not valid and the counts below show what it saw.
+	 */
+	if (!run_workload() || (update && !wait_for_update(skel))) {
+		SCX_ERR("Failed to run the workload");
+		bpf_link__destroy(link);
+		return SCX_TEST_FAIL;
+	}
+
+	fprintf(stderr, "notifications with a preferred node: %lu, without: %lu\n",
+		(unsigned long)skel->bss->nr_with_nid,
+		(unsigned long)skel->bss->nr_without_nid);
+
+	bpf_link__destroy(link);
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+	SCX_GT(skel->bss->nr_enabled, 0);
+	SCX_EQ(skel->bss->nr_initial, skel->bss->nr_enabled);
+	fprintf(stderr, "initial notifications: %lu, updates: %lu\n",
+		(unsigned long)skel->bss->nr_initial,
+		(unsigned long)skel->bss->nr_updates);
+	if (update)
+		SCX_GT(skel->bss->nr_updates, 0);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct numa_nid *skel = ctx;
+
+	numa_nid__destroy(skel);
+}
+
+struct scx_test numa_nid = {
+	.name = "numa_nid",
+	.description = "Verify preferred NUMA node notifications to BPF",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&numa_nid)
-- 
2.56.0

