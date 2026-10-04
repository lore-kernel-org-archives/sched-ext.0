Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03973F3285
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098979; cv=fail; b=jqWOYyoAwywJF3PkMg6MXnrY2dOhywApBBZNCnx3UvopTjz3RkJnGBGx9UjNHI3JUyM5yNiYtD9tKR86hLS89rEMGF564Aohw93wm6B9Y8jf920ayd+/PTSRcwaAT4a+eco9f0ad00S36a7GfeuTjvO0cAh1HvLGNoJLNRRtcaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098979; c=relaxed/simple;
	bh=88UVXTdgnHEH2Iw6EbbGjZZ17r1e1euUgyuRWFEDtsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1f/BGFkbbEouYiUaCMoz4VDE+5JPl61jzJiEQ0Te7t7huNoyC8GRcAcxN6uKI7N1GLUX/PFSy/mNcdurofruPuKH12hb02knb33F61JERhlkbIZx7umoVE06xjubkZKfi7BLcIvJ01oB9OikDKMlOi37SpVJ0kydy3QIYaRMB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j/dfhlqw; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/dfhlqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZ9JeFIIM7Oe/voIohRumF/cBe815ar0/ysJVjdvR80zq41ZnXE+RKUepks8SF/frQxXD58aNdcPtO6I0U9O0cFHU8Zd+OKCblks9ivVn41AmwUxajLNO6wjMyPNv6tFeG+kaOnObN2KScXn0u26XG2X1kCUJgRFzxYBnK2cr/Aa9tonNStRLVP4GcqA0Z+RnUe5wl0mmjJ1/nExqB4OyVL+8E/mn0CK72T5jmfxOG9NxmU/Nt98EL56EHQ2F0+fqJOCJPF1ucMXU1pJZ5zeTlK+EdOvKV61iqAIXdAZRVaY87rK5MxO+0tZ85snWeYyT0l5a3+clFzMwaSIBFTx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnQHbWkBP64zMvYhBj7FJid621ZVfheKUYI0SIPhQXo=;
 b=WV0RnH9Dg6dDxvytHiiZc65Q5akGoRqgxwfBTyeP2fICWKClZbHZlCFb+Qx0NT3udScs2+MpA777XBmh+9PcFdmIfAyBRhwA1LYKalO7s1aCCThWLB+PiKRXoO+k8/My6Gkb20dZyYKc/T3wqAJNnQqw6agacHE7gXP7mMhoA8wn6ase1VrbwMWXkCa2t8H3fA6pkoPmDVEq7bSH1vyca9u4EIH+vPXqhp+uipInwtuNAl5XlnORDKtk2U54NwLnR/5oY8zGhw7ekZnPGXqC7/pd1k1PRtkFWXKkx2ioo6uQ0KMTX97V4iLrWMEA3hRXwc3+XWBa2yhErzRiYb9XFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnQHbWkBP64zMvYhBj7FJid621ZVfheKUYI0SIPhQXo=;
 b=j/dfhlqwZsiZR3IQJzuewhnw1Hp3lL5Y8aZr2XUUu/GRbvEmMPSYLrFooOiKwxtDfvpwnBzMwdkSpGmwUHc8h9AgnVLSiPGhih9Q4bIRBpuf6JkeayzRD2zwJH9kXO35uk3CqT5odcKBq7KOKbn9DTceRZk2ZI8tSRXoYYQf6w6cHb25mwPjskQkcyWqEF2lydzrEblSbMf7OxgIP8CDx2CLjOlpVfDBvkayQr2NEiIR/1SoHG7KEtQ0RlbUQ6T/tFBCKUqd5mUzH8GU6TW+xj6eZ0oIRDstlI0GJ+HJUGV75D85jsefTSzB72LBQYYcRlqtsBuk/sfOqjVDPQv2aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 07:29:19 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 07:29:19 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] sched/numa: Leave the placement of a BPF-scheduled task to its scheduler
Date: Sun,  4 Oct 2026 09:27:08 +0200
Message-ID: <20261004072901.3579967-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004072901.3579967-1-arighi@nvidia.com>
References: <20261004072901.3579967-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0026.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::19) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: f90758bc-55e4-431b-535e-08df21e93405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	WXCsvFzEI4BrMkzWdZcwNQsGiQzNxLsglK841T0qlvQQ/IGU79+voYMq1n+wDMSfBLufCw+v0q1DM3gLyI5v9QHSzsAZ1GbKQySDGnGJZS24d17uCLi8KMrb2BhtYD+K62o+D+rsNNrtK0o7NUN8jAR/Iszqtwj4wxouB5C56csmYP178CYsBVDcz3/wJfDQRqIY+ov/VY7noWFiM5olaQUe2sm2MYl8I4zLURp7MHa8Cbjjdw0PamBaaG/nEBQvEwvrwQnioK9PJzcNEE8pjLguZeC5qW8G2cISMwj3UhFk3enzvEAID9kUIqyXB+jmNvlshWME3pz10uk9LSPQJZFzPa1edzMUXJ+legqgCMg4lv+vTaB/TF8/N8TAYkianV0wZS9ybcRSMbTR4c2aX+QdqXqTvgQeAapLVS5IahvvqSuIa2im9F1KDj/itSWX+JwC7oKX+FIaJxrsSLd3NNdp4u8aPSe/DebquAXulvucBk+HOxPKXjYxUZHOU9T40ulsV11s5ms1fR4jcurSjJB21NrdpRYI/Y3D9IbuPcd7Nck5LJA3b1OJI3+6Q0E6txevzkSKsmhzgVM2HwT62wBoj7vhHwZbYmDI3QpZ9dfpBj3ntzthNV2QZOL+ag/zAq3VA0O3mH6+WJZ7XRuq/T8VOcEiIGBFVI4YhaBJlcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SkjHtHu8XRnBN7kBSzPmsLb40SxixE2u3xr7ojC+YcLU7j/bR/ukBp9GH7K0?=
 =?us-ascii?Q?jc+tgE7UL9Dg1pddParUq8C5iZVbMe/vZ/xc6ot6g0Xb914doCqi3k8vXKS6?=
 =?us-ascii?Q?4c2LLhjDbUdPCTNQA+E5FBW5At8vztbYfv1S0weQ74axy/sg6jNiGNjvoUV4?=
 =?us-ascii?Q?9XRoswvwk95MdVa53C1vh7vYzQoeF31NqrUoDrSDyqMznpG3PeUQtaIWUhKW?=
 =?us-ascii?Q?6kMlvEGIc6kL/am9bTSJZZlA0RGEIb91DQM8vYrwdYK9rc90/6BymaaJGnSO?=
 =?us-ascii?Q?E7vsxtcBmnMjFUeTTIB5dI83JsIu8/RVaf9faRAeqXQTrncbk+Tn8jIJjXqB?=
 =?us-ascii?Q?Xdb6dP6b0rvEhJCSVpRIeVbsUxoROUJl8OqwJ6+5kvURE0h/mT8TsuMRs7f7?=
 =?us-ascii?Q?UJGCMwtYH9bT7j89MYBgooIpp38U+1frc4ZEvFUwyWIDHfGEC0754iObOEcJ?=
 =?us-ascii?Q?61ZcQclFExp3L3ADWVxjPj3hHj1qH1TyLsEDW48Ze5edUdeM0iiHXKe1JehI?=
 =?us-ascii?Q?sOYzMWKhU+1SsMd71LV43Rl/eCh8kSFvpB/TV1fYcJcdU+S5paNyxgsDVHbN?=
 =?us-ascii?Q?WQfAqh6QJS8iUzxtpgkF5lYjFC5nJq0mrkkMVstvusvJOsTlYbxwJ2pMYGi4?=
 =?us-ascii?Q?FarA0yRaGLXm6MDD5FaJV5ktNLaUzoFBN1rIZIl9z58kYcaxSayqDswL6DdS?=
 =?us-ascii?Q?0eEsekn3aY0q6E11S9LzvVp9zEqP/MkQU2m6tZKfDtC5ZLP5qurnYXKaWmbq?=
 =?us-ascii?Q?wrBreL1pHLQxja9bjDhlAxtlmRsNK4Dv3lZyJbulSLd2G2TYEHeMUlEUTZSO?=
 =?us-ascii?Q?Fcb/FUFs470c1v8jkcYsDjY0L8VcN3YAQPBNTj3y1tDzgCCOQNYTtaU+0x0C?=
 =?us-ascii?Q?CwsjWq9UcGQyWR0l2/IaNjz6q8DNuxKPc5dfTCGMlkr+IlIudOlSxmyfTw3y?=
 =?us-ascii?Q?oskNWtKHcvLegoVkCbclhooi2LtjTXH2eK0QSk5NFj80R4ZJYLI1fslfBvSp?=
 =?us-ascii?Q?edab1U838SIga1/lerhI5PxINmTUziOYWbblByq/dRbYF0dTQ35Ik5a/pDsU?=
 =?us-ascii?Q?hPCIhc/SxkN7lfwQ/uNz98lXc2p6zh+vA61HFXeoCdfmQRGhyCrgWp3z4zZ2?=
 =?us-ascii?Q?V9JRGK6pyclTgT+u+iyzl+h9mvY7DOFOv0SatZjOk0owPIXHJZVVkWDxj1Dh?=
 =?us-ascii?Q?LIrTFoo240pcBEdiTt+TY2mUZ75zJ2q77hY5rWWYz9gps4O+J2FaltHL/3oX?=
 =?us-ascii?Q?zeDiJddJZRpktjrYNfAnPiqS50Is0YS/u89ZqvpMOKUU4cYDLFbzH4h3kWgz?=
 =?us-ascii?Q?pEIxKLwEJJP3P6k6xaBflIdaont+uVrVMjpgKWXBHRjGOe9QshAlxymsQPJv?=
 =?us-ascii?Q?qhfGn5amA6yMqGRUbe2+jWXbpxqwmvWrzOA1Tg4hY0u25Rb8I4f8RRap5pvV?=
 =?us-ascii?Q?QS0IGsoz88f6g3jwBKJvWCve5/bVax/r5NYEGZRKaCvay3aIlwqKmCAqlXEg?=
 =?us-ascii?Q?z0hd0/DPBfLIJkoWsL5SXkF3qq0KGabLXA8k0AByGEGsj35IVom8TIVTSzFj?=
 =?us-ascii?Q?ykJyN9Z6pnCbRWx6H4Of9BDkfv4f6KyM9usfdJgIStubFiLRDT+5dP6S8pct?=
 =?us-ascii?Q?hWLF98/G6uMSZsnmlhsZJjXM+QxWDVkEsvbppS0yCnHFj9VgWnbQhXw1G5TV?=
 =?us-ascii?Q?yOLRX9ZNZ5DLG9Yob61DiURiuRtaL2QQffm9v6XcWC8STm5CtU10irRnjW5/?=
 =?us-ascii?Q?6N19n+wfgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90758bc-55e4-431b-535e-08df21e93405
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 07:29:19.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dacajn60AMyZNA++TsQLhr4thIdU2404rh6+XNyBJye8rzFvJFWMTXPAFLawUx/h1jDAUU5U/pelmR/6otgzaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

A task under a BPF scheduler can take NUMA hinting faults via
task_numa_fault() and then reach numa_migrate_preferred(), which may
migrate the task to its preferred node through task_numa_migrate().

The migration of such a task should always be driven by its BPF
scheduler, which owns the placement of its tasks.

Keep collecting the statistics, which is what makes
p->numa_preferred_nid worth reading, but skip the migration for a task
owned by a BPF scheduler. The scheduler can read the preferred node and
decide for itself whether moving the task is worth the cost.

Reported-by: Vladimir Vdovin <deliran@verdict.gg>
Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2d52faacdb7a..019c1331545bf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3446,6 +3446,14 @@ static void numa_migrate_preferred(struct task_struct *p)
 	if (task_node(p) == p->numa_preferred_nid)
 		return;
 
+	/*
+	 * A task under a BPF scheduler is placed by that scheduler. Keep the
+	 * statistics coming, which is what makes p->numa_preferred_nid worth
+	 * reading, but leave the placement alone.
+	 */
+	if (task_on_scx(p))
+		return;
+
 	/* Otherwise, try migrate to a CPU on the preferred node */
 	task_numa_migrate(p);
 }
-- 
2.55.0

