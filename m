Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B4342509
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012860; cv=fail; b=AceOt3P/0MV9eMdh18tetp3kO3yLujn6ko+JWQcfl4xLDNN5Pv2v2jtXfClqX2PoqqW5U5SV2jVifI/bfx3V5d/VFb3spIBRDBluxW7mWF7i8tFceTwaFlVfJ1ngbw9nHRshFDoUhFrP8vTiXWTxfT8Xdpj0O4E6xQ9i5/IVhcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012860; c=relaxed/simple;
	bh=U6x7aLFTmLtv7+XV0JOkO/hzOMPwqUuOxCuogjTolhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ShCGzbItjWAIW+VrTi2eY+VodIEwLpDSmiznu3AUbJAX44VmG9nr6y21LZMozeve/PHa4b7Wpci4PICMlKynVa9Dduf2jY54vgKtxpQBqiyQe5vwVM2wg5vIjH7QO4j4HNalseN6GZz8mX6gSOsLP1MQLJ7LyyRaW0e8SqDamLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rKLvG8NR; arc=fail smtp.client-ip=52.101.52.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rKLvG8NR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iw/BrutP47jiIUgWNRq8L5ZSGVlkrMl7Bgu7KJQNrkDU7XwvnzsYUmx+mdBhskXkhtEqZBStCUcJcETMWuviN1QKQxvo2omAF8vifU2hPhIyP68TyBkBF/sYZnslr3rUCtBF10XKHWTZsohKY6X1fQre0nUPYmkTPwYGPpQqPedhOXh8wSuiJns0JRWRL7x3o3UazET3hkhCSsh28yra016cXnyG/aN5i2NYw1+sDsB0U9RzqZ3FWjYRz/6L9J5SnAQqHQBsuuixFsPwiFSqPngmvijq7PIpNg32lavJ6PEDYwpP0hYiV5njDmlBfkgMsIPiPrGYpE68LgaKtM1Q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjwBLvnnciv6jVAgtkNXJfdH7sCycjIuXgS/6XFgyxI=;
 b=tX4YM1xcd/XWtkjKwD/NcFeFS8r0QZHLIg5dvgeNAmzdCyeQtKGhR38ADz/fyZRe7I4tRDxNOjnyBLZvsc5TLULraT1hm13abR+p6AcAaljDA8YV9mn7NlUebPAq6R4lUv+bbOEHawMil53I9Fvlpkuz4qDOdWT7lAocySBlXQJblw46Hb517QLlzy3OzoTyWmj2YPMHcTFn8Iozl9PX0eyAJ2cXkPTyHJl0rEGTj34H397e5si/DiGdHFqw8KUjHTzr32n38ayMxwG3vjdgjfQjhQdb5h8p8hDn3Yjh4xkE2YCREKrTOKOXvg3Ddi79BJMh1753gaOWPD5Dqbl4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjwBLvnnciv6jVAgtkNXJfdH7sCycjIuXgS/6XFgyxI=;
 b=rKLvG8NRuLunL/gR7xyYLWMYrZCerGTCRYr66ilLo7uCNA/DpXzkrIpx1jgXZOqRGAy5iM4bmjXzuuzJdH7sOh17FTMDwQCBgqoL7tjEXIbFYG3rZ87CojxSDeu8xCRDMV22jMGHuzDhl+iCXqNpt9LoBOZMDxC44Xf5YXYt0PJonJecjMxl4XXA1uDyhsmXJwSIv6AjIPz6sfxOY1suytwXxLWPqzoH/Nv6Wx+lFEsOR2zjwsorx+2Zw3ReZP7tgXrI7ZW8fodGag8rfRGMrzIfIfQul+HrbHLoHM1ObJWYtvO446Szruq9NiwSCrPktoyHv6uurvtbq6F0o9N7NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:20:54 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:20:54 +0000
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
Subject: [PATCH 11/12] sched_ext: scx_qmap: Add proxy execution support
Date: Thu,  2 Jul 2026 19:09:27 +0200
Message-ID: <20260702171909.1994478-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B87.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::405) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c0f78c-0d37-4fb7-1916-08ded85e454f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PSZElNgGMawcix2KZXWZ6qFkHI5WYXcjkJ9jj1isXkx/Hdnyv1jXK2BZ6RUWAOtfOZw0ObW0dkNg6kTVDD0qfztQB3vgutuTQNiwVMIHNe2pBe/TpOdkN7Q/wGIF8cifw0bOQ4cuA+nhp9IbNuSsPCqOtH598Wntg7B6juYiujGvQEVofMm2SMwox5ZKhYRFC7tHrASSxjhmucHFNq9TVOb+c9qY3iXkR4CwR8RrZjRq6D621VWp1DABiy6Bvg1KLP6gYm0FnwCMGej9kb1qUXun08bmLDoX1U6jKGixv1kCuGLAC+Cpo3m+tuD5EdgXZaRLqg+n7OMwXuIEKZSm/X+wjT1/YVno394lun7af5lrpLlzY3R/HG5+vrl60lisSq57h9i08vWX7Mo4Pi3zecUph/p5iNYCOt7TginCcZD8gCLzAwuKAxEdwT67JVE8yB6ZoPVgWCs/yRRYB9f8gVxzmTuyY656BG2cuvIa8BFVpY8qvxo2W+Egj0gJG1Xaczi4qg/ACvSOjUtIRwbTQF2TzXJVDzP+0fvN5JiIpjP0PJmlgYSW11eAtWXzWOClWzVpsjuMLKJKoJU0qQPWajgzHcBWPf5wcXeTx9HhgKiNk7BhIvw+VeoyIU+PFva7SCYVIKWmpGSPiR5J/V4tdApyF88ehBp9K52jaZfqRjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zy/2FNIvQSXOuTWatDhCIadZhLnHkMXEwY2reQ6CJCLL0aLinDe0qW/elppJ?=
 =?us-ascii?Q?Il+6+pc8BvgR5lniHLWg0ztG8Iy1rzif+Ziz9DdXoKlJud+FdiEZHTyvFnvj?=
 =?us-ascii?Q?leY1SJ7qYx2qdO4ii2+0ndQSz68NC+JZfW4IUm+yUhQ5WMG6JqPEDldLO36a?=
 =?us-ascii?Q?p9OTZEPKrs3RXk3Jc2EGz8edPbv4kNQ8STxz/Vq7n2cOJaMTXx9uvFnwNw9y?=
 =?us-ascii?Q?IwQGiAc5szpeFDZYsRERvDDSIzy2gWopQBkP/87u/HGZmWuR7/eZgoVnUryR?=
 =?us-ascii?Q?Bfy2Bovc2cfdU2AkLli+7WmzyL1gllU40CCSGMu4axDC0rGEtYnUsGV3laJF?=
 =?us-ascii?Q?fkbGnUiJ8e34goG+y530sgD5Qq+uj1MZNkQpHSatTrrG6YiP3t4rPec3mf4K?=
 =?us-ascii?Q?yt/h0Kf/VtcRBhworJrjArTX+i1z2PH6U/fx2daFEAK05q9PUUfUvMR3p1+c?=
 =?us-ascii?Q?phQNUVhEt9pnJxQJ11YqreBHenCgsKYREVukuXkEHO2yqXufLLNs+IGJ4Xie?=
 =?us-ascii?Q?u940eROeIgk3fdhIA5KUBhHOXlzZxCicxzfnYeTcP/ea1fwbo8HNsuzQ3r3k?=
 =?us-ascii?Q?W3abk5s0+OjBCmYFHuoJiVXVBzLOMIVbLpoUK0D5cQEd2enaAk6dvX7qp7PF?=
 =?us-ascii?Q?qWPM8CLyvriXWkb4/fBVzsS7Qyls6O5YdWZ50FhFgPp3xcJufb3viNLGojXx?=
 =?us-ascii?Q?EO1hGj5YyudqsXf76PhFVvyZrpFV15kRxjoG0obGEjaL/ePZR66sTqW/77id?=
 =?us-ascii?Q?2wbfELvi+OSjN2KEMqpt/1Q4DeRKDtrAElxXz0Qoa7ze9cMRgUj5jrM01+EI?=
 =?us-ascii?Q?T5m1+1Oxp33ZR9aZ9rXSgvykD4SOgtKj4IAcH/V3XLV4DQJ86LS5SDgd2edx?=
 =?us-ascii?Q?LdltAhM6/+I1LciMJ/9NVj7vZ5EeEjOmaRSALGHlXmUiOpvBXgo0fVTdQ58L?=
 =?us-ascii?Q?8z+nlPSaQN3Pxf53A+gvpVaoMk2l0hbXpVPXmkfFTnimsnqq3bmzpnby+JFJ?=
 =?us-ascii?Q?v5W2THhoZF9Mvr2KMi+RB3fnD1AQZQNsn9vQebqPaRoFH3UDM5JFqVrDOwkm?=
 =?us-ascii?Q?nu2To655n/RupuF8l3FcXwT6EquZHLCJxcltLDGlKSN6Ov5d/NzRU5xvmthh?=
 =?us-ascii?Q?EShVt6YR3oTLZWPzEmoMxzN3hOcr/ntiIsLNt3eBStzWrVoehTegjkfE6D9f?=
 =?us-ascii?Q?MqTZ2kZ7KjqlZXE+F0p91qlwvlVgu7PJbRdTVyDmTFo9JT0BYvGuldkJzxna?=
 =?us-ascii?Q?r66U1m3qHhd1j2ODJD6x2rhVS9lyy5D/GUFC7/ju0YH0TNGdYUbMfVN+jqOE?=
 =?us-ascii?Q?dyUWVh84dSfxAfQCIvOeug8e2p0zhPRc3nupCkciNsyPaNAy/cF1d5GMztBw?=
 =?us-ascii?Q?ScMGOLyM9UeBZpb6eVX+BmSFZrwaAYTXaZ4XCGM/YkiDdW0A3IzZfzUsWBBU?=
 =?us-ascii?Q?8h4pWfixuAQ6RCvC5u84C8CKSorOh4EMy2aKGoFGqHeFRZJ2crq9alFZJf85?=
 =?us-ascii?Q?hIsH1xpg8Zn6KwkPvQzgnjIbwnAO1MFJSFPrKlOPhu17jykGiE5OmLoUNaam?=
 =?us-ascii?Q?JmeZ86r0G/Zp1Dm/S4O5b+uaWNoLcVEHgVHArIrPjrTWWCB1+AoAf481pL/E?=
 =?us-ascii?Q?tfgtxDpqymGDPdJ9CtiuFwKSc6ObROYscSvWPtWIh88TtTVV5frVLEYFeQoc?=
 =?us-ascii?Q?okdEr6dWgXEzo06+fch4/TbUJN0DjpgYcxVy3GJuzi41PuR5R2xsII/4Ksnl?=
 =?us-ascii?Q?UEtLRvlecQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c0f78c-0d37-4fb7-1916-08ded85e454f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:20:54.1030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRO5ZI4I6FEWbfRzVOP0Urjlrhha4+PIYT86YS5fwGTAqvmvKvIyfeopKBB0wlEGqu+NPq7O/3JBR68QLWj75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

Blocked sched_ext tasks must remain available to the scheduler before
the core can use their scheduling contexts to execute mutex owners. BPF
schedulers opt into receiving these donor requests through
SCX_OPS_ENQ_BLOCKED and are responsible for deciding when to admit them.

Enable SCX_OPS_ENQ_BLOCKED in scx_qmap and immediately admit every
blocked donor. Query the mutex owner's cid and use it when allowed by
the donor's affinity, falling back to the donor's current cid otherwise.
Insert the donor at the head of the selected local DSQ.

Applying the same policy after a proxy migration expedites the donor on
the owner's CPU so proxy execution can begin without waiting behind
unrelated local work.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index fd9a82a676278..5ecd2ffe05270 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -396,6 +396,21 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	/*
+	 * Admit blocked proxy donors immediately. Dispatch directly on the mutex
+	 * owner's cid when available to facilitate the proxy execution switch.
+	 * SCX_ENQ_HEAD also puts the donor at the head of the local DSQ and
+	 * expedites the destination enqueue after a proxy migration.
+	 */
+	if (scx_bpf_task_is_blocked(p)) {
+		cid = scx_bpf_task_proxy_cid(p);
+		if (cid < 0 || !cmask_test(cid, &taskc->cpus_allowed))
+			cid = scx_bpf_task_cid(p);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid,
+				   slice_ns, enq_flags | SCX_ENQ_HEAD);
+		return;
+	}
+
 	/*
 	 * IMMED stress testing: Every immed_stress_nth'th enqueue, dispatch
 	 * directly to prev_cpu's local DSQ even when busy to force dsq->nr > 1
@@ -1216,7 +1231,8 @@ void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
 }
 
 SCX_OPS_CID_DEFINE(qmap_ops,
-	       .flags			= SCX_OPS_ENQ_EXITING | SCX_OPS_TID_TO_TASK,
+	       .flags			= SCX_OPS_ENQ_EXITING | SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 	       .select_cid		= (void *)qmap_select_cid,
 	       .enqueue			= (void *)qmap_enqueue,
 	       .dequeue			= (void *)qmap_dequeue,
-- 
2.55.0

