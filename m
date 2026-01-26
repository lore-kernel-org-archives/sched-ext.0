Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20631354F
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421666; cv=fail; b=o5ELn47bWhUD3dUE6cHh947rTdTtb+bVPbMy+2RMnWAdxuG+BQbDcqZO8IMpvAQH9BWu9XSo+0hIaZT/G7N8vg/BAULvIKp16xKpMySyuFwH2eLBNxnC49qJ463TaNO6ZWpsg7xWzQw1yeXgz4DR6CE8caOQOtpamKhcOGakPzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421666; c=relaxed/simple;
	bh=vuq3nVzg3ZFD4AwoGemiA45HH6CD9iL0Ba7PuZSN4wA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tnWadohe2BOActdvFDP9xrcwV6QmMAr6EVTRyW+5n+bU3laQaZ1sNJr8IyYHmDhRwo8SHCk5d4nCiQFvb7jWnNLWKwKeLXCPqxugd9yiyv+yJS0ivnoHNUJvK+mAtrhlS2+Tjo7J3hvpgrFnAc1oluYoLB9KcHMQQTE00BrWTBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J1Bda3UI; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J1Bda3UI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATMV9iqIjHDiLD5r59WgwLTIZZa5gdOuTtqOHip2Sg+v4sypMSSJC/CroZ25GrYy0sHDgzTGHanl2cGQR16C+N6w+QB3GdiNiqeHcZeBjxbifskWo/6Zi0iqL0qg4es8bmhgEN1pp733oE5S0c/XIJfzdjTXjZLSJ+2OiFVXc7B4NGCVKf43ghKK3ejjS20IN129Zrh3SL12JDxKpTrSccel6mV3w1fiM01FPcYvcyrfv1peFSaiDPMkO02kt4/ceKUPDkD0XLwiPrZ2KiYQH0JjJlf3AhrkY7BfyRBF7vHcwP+z4RZAK2LTgHTNPjxnNYAYopyPkUE2QUo2BrwKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6yD85QAFwInoHKUYRencugmxEDsA34LstDCKoKuehA=;
 b=FprnuZiseeduP+EoBVvtVKiBii6jlJ84hGB43jXFZTb6lTJ0KSwPTZTCGlF9Qm7YgHqksvqwr3nPb3qS67TYWLAKFWCMJEzgn5+x3w2OraCQnWDh8Xm1EDXlruUVLFiumZxu0F+R+fhc2VMfvb8FCO/H790Gybh476ufqfjjI+G3a+eRWcehGz+Lt8VCJKNyPypbJIweqyr6Hbtof4851mpTZ8DO2+LklpiT1b8Dr9ITr0U8RFHGPZStXMvul7OAHVj6ikYgYFRC7/0HKZX0ogGDCCoBqcDJJs9vrPLTA467ihKmPHsonNAfNcoNCbohDjOtSajsDcnd1KcpGH2JEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6yD85QAFwInoHKUYRencugmxEDsA34LstDCKoKuehA=;
 b=J1Bda3UIQeiCYngsfgjJ6G9ewxgaILtGkdhkbj4pVTXiwHvoM/vIu7DqOmJUvLaSSV7DR1T0bRWgrEaSKyH7KzKrGXOh5PbzqVUs/gHyKtvVgyx6zdSx/t/go7XJ3gSEFUI/4CEmrw61AGTMcLRjsrKp0SmgaqKUYXOSV9q9MkPtYA89WaqT/jd+ukkiKnxI7B/dZNgwNIzmQo56DMjjn9iNtInBAp9/WAYR0eVd+xiqJemaMft8O2a5dicG56GT5LUiiz9U3kRdtbg4IpiYRj9oUZUvMl69T4nNGe4kI8Jc17AAd+K6j0fQ0MeX2fDVWnmQEAGyUFoggJaXSJsG2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:00:58 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:00:57 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v12 sched_ext/for-6.20] Add a deadline server for sched_ext tasks
Date: Mon, 26 Jan 2026 10:58:58 +0100
Message-ID: <20260126100050.3854740-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::12) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 7351e581-ead6-4972-5abb-08de5cc1cd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sPVPjWf0TBMMkX9MDKvfbMb5JaDXsz7NIkr+/aJ945GgPTit1tMV+np+7D30?=
 =?us-ascii?Q?5iXz3rabYWk0r2hAOYjfPRkT7wY8Ps/VsPaWWk7dsHdjLy/1UcApiKVxVS1x?=
 =?us-ascii?Q?ozx/XGMyhe0T3sFVvuunIN4cjw9whUG5Y0qsvVWAehPMc/joRDCaj42WsgGq?=
 =?us-ascii?Q?MGlCKqEvGb7L8oCH1/gzYjp82Bq47yW1AlwCekVMHUZi2x9ml9Vqlx27j9ej?=
 =?us-ascii?Q?pj5U1jECwcAkhuGU5LYkwwY0mOWPQpxpebekgZK7P112xPQT5xXVoSOJpeBb?=
 =?us-ascii?Q?kJ0T6WvuzH0U5oNMq7i6Oq8ZXUu6MqfereFkEfGk2fRmHiqXz5ImqvBULk72?=
 =?us-ascii?Q?RJsDSbdLZeAgKwyKJymSApUoYo6mcv0Cl0WVuKrB6oCUZ5gn1xn7rCv/kpr4?=
 =?us-ascii?Q?eWxnynAIP9wqVwhvN0LiOU6JXvoWwSGq2oK6zyraV4bWfWltmRDHdmSrBKff?=
 =?us-ascii?Q?vpB4FF2qu1FSFJ6X47NegM0kx+/fF/K83sVI2Gx7EY8qQjbXCquJ5rJEV6TN?=
 =?us-ascii?Q?PRg/iV/idHvrtjDqeEda4a2sBQDZaR3/wFl8cvmjq8/uwE4dBw5JH6WJdiZ1?=
 =?us-ascii?Q?3l+Ah9HNzViE0PiBiT+oCCMGOInbnQm0pfHAgrNAQinbOvGIbrzjKRIMAukF?=
 =?us-ascii?Q?yO6TvCBI4/2NxycW30v0ark/4lNoSHawVw8fbvluCrfOOdgo/gF77EHATQxv?=
 =?us-ascii?Q?tPj6im11vvp8IvQqFX6aW0MzQ704H6pEfn90u0F00/FHXOonG8b99rs+5X3J?=
 =?us-ascii?Q?yCGEHL+dzl42wVc6+jWHr+NCFQ49JmeSQCtpogLAXOSGVRCeYvjvQxn8n9gu?=
 =?us-ascii?Q?P3c0YwVoPpr+qSDUdj7SwqtYDjeTETY7cPPBJ/CM8kk8bddBMaM4NAu9+JY6?=
 =?us-ascii?Q?VrqWgNnmwIbWph7+p+Skpr8MRTZpJtG7VtSxNJh8z/lh6AzLwwlsqxQ/xpCo?=
 =?us-ascii?Q?fl8ByXTNhEN1g2mpV9Qoyp79Uh55HxRGLU8MUpBxh27v4yi1v9XlVqYjsbGs?=
 =?us-ascii?Q?zpC3YkoG/fXA3w6ot6iWA4s4pTOywBvnjrNs5QjfCbdZF4bMLuIIg1qIdA0c?=
 =?us-ascii?Q?HFsZsizt/+5JviLV7UMVyfljsrUoiyhAVGTOEWXuGdN55iCaM0li8N2OjMFi?=
 =?us-ascii?Q?Wm5Gux5gevz1fsP2HxZEqigvGvmgut+0RsfKA7BzhuSPCYQJTM8RCW2CjtT5?=
 =?us-ascii?Q?d7oIcioyD833t/9jWNqTsj6rgH+/9wPqnEHla7sKxt9CFwbwKh+YFdESMhpO?=
 =?us-ascii?Q?bVV+6nH2lCxCVwT/UhPvwlm1Z0WSBfcbl2CvQZ5lPahwfURubmc9QGvVLhEF?=
 =?us-ascii?Q?/e3J5dnwjoLZZSBAkIWc/cKrro0u7F6U/fqVEpgsnBxism+5BDs0MunrtbAJ?=
 =?us-ascii?Q?WvP0CBLA/5z7poV4ZeZYOjyKDE1hclS/GZn+4raqSahkHXyDAgzei+V8PPnQ?=
 =?us-ascii?Q?bUWR8R+YKciQ402laBjkXNy8/inTtaCdWYs+YGijQcROkDdsW+WPeJApiv/t?=
 =?us-ascii?Q?AbruaG2WPx/FPmEU5AslY8l0Bis63N0FlCtOtXfavV33DA0At4o4zb0EfG+7?=
 =?us-ascii?Q?zGQhXERegknPhSFdeAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x9ex9D5DFaklgMg+6GreeHFunboN6nItmoNp/xtZNmeJnvMoUH1Yz/K7zELl?=
 =?us-ascii?Q?061oPutKp3jBrNJ5152k6cBBeG88VLA6zeHL+6goOHXe+fM3MSpvJ/MVOcwy?=
 =?us-ascii?Q?0rRFANxohwlX1UJxAAZ97PlS6Y02Q6HDtfRX5vz1B4cd2KLehogDG/URVT+8?=
 =?us-ascii?Q?ADruh2SG1NEDMM5wHHGh1Dh6NrtggQR1stVesEVteE8hrOIusDfMxwel2+gp?=
 =?us-ascii?Q?hR9AUv99dUzpHwuy1lcimZqkTrpW1oPOIv+Ed9RcFSEiJFXrhJx+e8kp+zj3?=
 =?us-ascii?Q?oqmgCghdgQ3jjafE3HYtOhLPgCQIaM8674dIwh121lU19FZReRS6zaLOUxhP?=
 =?us-ascii?Q?hLjm7UsjsdBSQEiDEDRT5DczLGN9Ygzqa3rIPPqKVWs1t2T2WektISBltavY?=
 =?us-ascii?Q?htQG7UCoxSZl7CS682LUb4DTeWN8BEouA18G7aRrl+OSzHkk007Z+gWBakaR?=
 =?us-ascii?Q?tMQa6Cn6sCjPKJq75kbKqRVbvzx1n3YHLtwXlH5wGU06VUr789UOD7XxNg4b?=
 =?us-ascii?Q?i2iLHdt9wKd36Y3gLrnf9PJ8otJd4MIf+PiSk6ju0YKcPGPJUzhr19ru3RnV?=
 =?us-ascii?Q?nKpeOs4tcrk5cOa3HAGRen+ZMz9HgCjEn3735cwpz9PlyRLaCVH3hwEvgN70?=
 =?us-ascii?Q?iysSD2KOrjeC6kSfHAMu5StiesH0JRe4WZsaZMiBf+v3iAGiSoUxwC762/gb?=
 =?us-ascii?Q?bW99wfPACD3LFW27GcWqptysPDvdl+y4IvsAsSD1tMKQc3go2G4Fb5Kz54ch?=
 =?us-ascii?Q?/Cgc/9J8zBBZS+Od5pNDZ8fDthjR5NeK9HkzWJpEA0sUd8um3GJ3H4DK42tG?=
 =?us-ascii?Q?w5EZsM4DmTuun+r8wgNEj8QN+DNAhH75sFALekOM2M1TEYgq+efp+6SuURXu?=
 =?us-ascii?Q?HsmMOIAA94nnAdeKkJjzImjYmn8+lt7fJnrYlucul7IaQwLDl7W/XsgsEtd7?=
 =?us-ascii?Q?ih+SsBGR6/KanGvwm5HoOS46ladyCL3oqgcpg9y/nps7PrLBzzzbhqTRGcD1?=
 =?us-ascii?Q?poXwLv1+EOgCc2HFWe+IUE3mYsVl0iU0mPTNg8+qESjJ2ooeAetgRq1/m0Ud?=
 =?us-ascii?Q?FwoR8wdwq5i4hAfBepRfqA09TfBmYKCxZPOeveI0h95D1R4bZKXevW0q7BPX?=
 =?us-ascii?Q?EYc4YSt8VZxoE5guuU/wyRLfzDEn0kTJezOWQ71QK2hpVhndteBwyqp9fIni?=
 =?us-ascii?Q?I/7n96k4IveMmHsNqexwpBMA3XL9QZDrfmcoTNvHdnGTnarBblXyTP7tVtj8?=
 =?us-ascii?Q?t0JzkERMlDAq8vJZIA+MsengnlF02sXsjcum3AFNaf7r6CPvUB8K+aAyrmKn?=
 =?us-ascii?Q?G5qVZiuugc2Ovmuno0KcAjpmFBBcN2R3IYAuDE0S6MrcKgVy5++7AUVrYRpl?=
 =?us-ascii?Q?HT08AbmLXI7fRwE/gLW4W88B2UdlLsGhhd+YHFbrvsYYp+sLOj+F3aVrvQOv?=
 =?us-ascii?Q?uHbIquPDMgZNsh6Ib5by9XDvGIAygVwjkT/HeOgGi46w9Mf+FltXJK7EhVGs?=
 =?us-ascii?Q?qOOPZC7eB8HxaW5pzbvKksN6SsOJTVyIzkpn59GrgbkHv7Rd0Og3sbZbBDML?=
 =?us-ascii?Q?6sg8TKhygI0w6TZ5CQ/eGMY12l2LtrtDRiSZ4HkZZMr1YToZoJ+GuuBCROB7?=
 =?us-ascii?Q?OEqTBiNeAlntvz+2n7kHN3ZhN7HG2+GhFknHE5PKblGQ4QoI3BrS9PfoZE0A?=
 =?us-ascii?Q?O4ZXrEScXUTVIUcey8WcAlK2infP4VBnYRkgQXDMTBwHojtG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7351e581-ead6-4972-5abb-08de5cc1cd13
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:00:57.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dFvtrClUWXPJ/r+3EdIXLjN1Fw4sIZ4Roo5kPUoHysW49yYXuOYkJYxEy5H4tJCUJkT3NbB76ksqiHcRhaA6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

sched_ext tasks can be starved by long-running RT tasks, especially since
RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
tasks.

Several users in the community have reported issues with RT stalling
sched_ext tasks. This is fairly common on distributions or environments
where applications like video compositors, audio services, etc. run as RT
tasks by default.

Example trace (showing a per-CPU kthread stalled due to the sway Wayland
compositor running as an RT task):

 runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
 ...
 CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
           curr=sway[994] class=rt_sched_class
   R kworker/0:0[106377] -5043ms
       scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
       sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
       cpus=01

This is often perceived as a bug in the BPF schedulers, but in reality they
can't do much: RT tasks run outside their control and can potentially
consume 100% of the CPU bandwidth.

Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
also boosted and do not suffer starvation.

Two kselftests are also provided to verify the starvation fixes and
bandwidth allocation is correct.

== Design ==

 - The EXT server is initialized at boot time and remains configured
   throughout the system's lifetime
 - It starts automatically when the first sched_ext task is enqueued
   (rq->scx.nr_running == 1)
 - The server's pick function (ext_server_pick_task) always selects
   sched_ext tasks when active
 - Runtime accounting happens in update_curr_scx() during task execution
   and update_curr_idle() when idle
 - Bandwidth accounting includes both fair and ext servers in root domain
   calculations
 - A debugfs interface (/sys/kernel/debug/sched/ext_server/) allows runtime
   tuning of server parameters (see notes below)

== Notes ==

1) As discussed during the sched_ext microconference at LPC Tokyo, the plan
is to start with a simple approach, avoiding automatically creating or
tearing down the EXT server bandwidth reservation when a BPF scheduler is
loaded or unloaded. Instead, the reservation is kept permanently active.
This significantly simplifies the logic while still addressing the
starvation issue.

Any fine-tuning of the bandwidth reservation is delegated to the system
administrator, who can adjust it via the debugfs interface. In the future,
a more suitable interface can be introduced and automatic removal of the
reservation when the BPF scheduler is unloaded can be revisited.

A better interface to adjust the dl_server bandwidth reservation can be
discussed at the upcoming OSPM
(https://lore.kernel.org/lkml/aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb/).

2) IMPORTANT: this patch requires [1] to function properly (sent
separately, not included in this patch set).

[1] https://lore.kernel.org/all/20260123161645.2181752-1-arighi@nvidia.com/

This patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-dl-server

Changes in v12:
 - Move dl_server execution state reset on stop fix to a separate patch
   (https://lore.kernel.org/all/20260123161645.2181752-1-arighi@nvidia.com/)
 - Removed per-patch changelog (keeping a global changelog here)
 - Link to v11: https://lore.kernel.org/all/20260120215808.188032-1-arighi@nvidia.com/

Changes in v11:
 - do not create/remove the bandwidth reservation for the ext server when a
   BPF scheduler is loaded/unloaded, but keep the reservation bandwdith
   always active
 - change rt_stall kselftest to validate both FAIR and EXT DL servers
 - Link to v10: https://lore.kernel.org/all/20250903095008.162049-1-arighi@nvidia.com/

Changes in v10:
 - reordered patches to better isolate sched_ext changes vs sched/deadline
   changes (Andrea Righi)
 - define ext_server only with CONFIG_SCHED_CLASS_EXT=y (Andrea Righi)
 - add WARN_ON_ONCE(!cpus) check in dl_server_apply_params() (Andrea Righi)
 - wait for inactive_task_timer to fire before removing the bandwidth
   reservation (Juri Lelli)
 - remove explicit dl_server_stop() in dequeue_task_scx() to reduce timer
   reprogramming overhead (Juri Lelli)
 - do not restart pick_task() when invoked by the dl_server (Tejun Heo)
 - rename rq_dl_server to dl_server (Peter Zijlstra)
 - fixed a missing dl_server start in dl_server_on() (Christian Loehle)
 - add a comment to the rt_stall selftest to better explain the 4%
   threshold (Emil Tsalapatis)
 - Link to v9: https://lore.kernel.org/all/20251017093214.70029-1-arighi@nvidia.com/

Changes in v9:
 - Drop the ->balance() logic as its functionality is now integrated into
   ->pick_task(), allowing dl_server to call pick_task_scx() directly
 - Link to v8: https://lore.kernel.org/all/20250903095008.162049-1-arighi@nvidia.com/

Changes in v8:
 - Add tj's patch to de-couple balance and pick_task and avoid changing
   sched/core callbacks to propagate @rf
 - Simplify dl_se->dl_server check (suggested by PeterZ)
 - Small coding style fixes in the kselftests
 - Link to v7: https://lore.kernel.org/all/20250809184800.129831-1-joelagnelf@nvidia.com/

Changes in v7:
 - Rebased to Linus master
 - Link to v6: https://lore.kernel.org/all/20250702232944.3221001-1-joelagnelf@nvidia.com/

Changes in v6:
 - Added Acks to few patches
 - Fixes to few nits suggested by Tejun
 - Link to v5: https://lore.kernel.org/all/20250620203234.3349930-1-joelagnelf@nvidia.com/

Changes in v5:
 - Added a kselftest (total_bw) to sched_ext to verify bandwidth values
   from debugfs
 - Address comment from Andrea about redundant rq clock invalidation
 - Link to v4: https://lore.kernel.org/all/20250617200523.1261231-1-joelagnelf@nvidia.com/

Changes in v4:
 - Fixed issues with hotplugged CPUs having their DL server bandwidth
   altered due to loading SCX
 - Fixed other issues
 - Rebased on Linus master
 - All sched_ext kselftests reliably pass now, also verified that the
   total_bw in debugfs (CONFIG_SCHED_DEBUG) is conserved with these patches
 - Link to v3: https://lore.kernel.org/all/20250613051734.4023260-1-joelagnelf@nvidia.com/

Changes in v3:
 - Removed code duplication in debugfs. Made ext interface separate
 - Fixed issue where rq_lock_irqsave was not used in the relinquish patch
 - Fixed running bw accounting issue in dl_server_remove_params
 - Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/

Changes in v2:
 - Fixed a hang related to using rq_lock instead of rq_lock_irqsave
 - Added support to remove BW of DL servers when they are switched to/from EXT
 - Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/

Andrea Righi (2):
      sched_ext: Add a DL server for sched_ext tasks
      selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (5):
      sched/deadline: Clear the defer params
      sched/debug: Fix updating of ppos on server write ops
      sched/debug: Stop and start server based on if it was active
      sched/debug: Add support to change sched_ext server params
      selftests/sched_ext: Add test for DL server total_bw consistency

 kernel/sched/core.c                              |   6 +
 kernel/sched/deadline.c                          |  86 +++++--
 kernel/sched/debug.c                             | 171 +++++++++++---
 kernel/sched/ext.c                               |  33 +++
 kernel/sched/idle.c                              |   3 +
 kernel/sched/sched.h                             |   2 +
 kernel/sched/topology.c                          |   5 +
 tools/testing/selftests/sched_ext/Makefile       |   2 +
 tools/testing/selftests/sched_ext/rt_stall.bpf.c |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c     | 240 +++++++++++++++++++
 tools/testing/selftests/sched_ext/total_bw.c     | 281 +++++++++++++++++++++++
 11 files changed, 801 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c
