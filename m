Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685939282C
	for <sched-ext@lists.linux.dev>; Fri, 17 Jul 2026 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279494; cv=fail; b=CkjzOL8F5PW3O5biJ78VstzMQ0LAjuidw9wp664Ku2HyZeFjQduKUNYelatD1ODULof1saooVYa7pQXcejQWjwZ0D2EyUSs2XlpJ7TmDFTYvXkwZ9WqkY0rGr8OxPRcRxWfJIeW22HsiO7qw9GR4aLrr6LegqR8WBDs3/P97qe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279494; c=relaxed/simple;
	bh=fbzosyJZhClKDNQsrLCTY36mmOb+MmfKRfo7WzXsT5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pnYboDL+beb3UzwfnnPqpFRsRm9Vo/LaYPWNwYCxxCiLqPEQp+dMm5pbrQxzpgPqfrpylXjZrwwLf+3yDBEtC4wMyrqCHiH8sTLrnQpaZg5FgNub0CtnsY4VgZPZOq0XQ7JFcE+YgLtGf2a1dyVsfNCsgxE41iaTSth9R3RU6Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MZwkra0U; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MZwkra0U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUCSz8sEBOvMh2baaDnuOPlFT5NQ8JxgMKFBR9AbbzWwjI4mEhP8jsbmd8+mUgbOhiaBAcebaewzb81FRiFo/+ckXCIqHwJWaiCWf7KiT1n232cH6NXzuQzV4bY1GkpGd7xc+zOct6zaPlKDLVYndX739Cm2ls7+q52XKEpgw1n90YI/hGVqax7i/D9TB6tM47unsnDoQynQ7maZfeVMs2ndTzt81S1yDz3CYJ9RXUZOi3GHnor3f5iDh8I4vZan7rLJ4ToeCC1gmi0D4bJ8ZcrzJuiKuG+8DoJ2G+iIzuQd8yygkdiIa5t3agBo1aYDkatfli2/KdNs4aqku39PtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYfAXnAN9seWD0kJa/bnY1i113OELZ6aG8n1un+NqiI=;
 b=vuqdvUV9aiTVuwWR/ThHf1qdxJPyIOsv+5PJYj+UsxqaR/Xrw0wr9GP1JgX9+JXkGAClEXSRyEcT9egOM5c3E2JqKqxjyh1RrH4YGJUWZ2cwMwTuU4G96V4Ys7Vd3tdmjaeU/90WFI7HNsQdk4JgizuREjLENq7qqjif2ZSt4ULKbUC7YmSDD55dAcP7OTmpJWdIt4xYuumi/w1ravkstffFU7ZclqSwXW5S7lIRinbs41qsA/K++E7bCWCCxsixLahaG/hlMXTi4f4hnKAX14fsH1+/7C2yIFyXIZC+DfT+M+w5f5xcEh+sSxINACFHccJeXNEOw9Zrolyba//rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYfAXnAN9seWD0kJa/bnY1i113OELZ6aG8n1un+NqiI=;
 b=MZwkra0UbTTp80uuskWKTOPTZxqGaKjeRLzJSCLZrogKWUOBD63Bj8qjP9oAGm7POHCZtdHZw0xP2o1xGs4W3NGCNHlFb9eMH/ByemWJ/DluunuO6/f6TlVCuZDeF9eoFAZuSNGrKevQcjnXzGRcILjEWuHJibM3rYOGywG7w73FtTxu5xDw5NnyXB5ORCYCoggmwYIesLtAPm3t7DsqZbpBuCayM+UlEFbzaG3JizKNFZXCsSCn6aHR9otJbSaJUuOrEqeUhPAuX+FEoqh9AF9Vku8s9zgw0KIW69gUU/tjlcgVEw47RiWsW8dMXNgXZUHNx8Hh6g94olgthod/1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 09:11:22 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 09:11:22 +0000
Date: Fri, 17 Jul 2026 11:11:10 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.2-fixes] sched_ext: Assorted
 sub-scheduler and cgroup fixes
Message-ID: <alnxrsexEe_nQwqL@gpd4>
References: <20260716213058.1739522-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716213058.1739522-1-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0209.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::26) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: b9181171-a9d4-4b3f-24cd-08dee3e35e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|6133799003|11063799006|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DP0HvVGLfgnQ5F4UyOZf5rEV6lPgNsfxOFieqGh6p5Y09tN+eEATDxONNSwbIbzsRIYWSanyIt2ZpkVWcVDmj4VwkfFi+jAm8M5ZAr4RdQh6NjfrNzijO+os9USxUtPMQ8/wVjEjkvlZv7bkJ9MLnMybOPLXOWTaUeTAlgfxTvYRDg7Yy1Hu8CJk0KSjEbPHfyuy4DlaYbvXS3P4qPmS1S8ooU0g8C5Y0M1BtQLb4ymAcHbrsz5rYufDlUtde/+5Fe/SQDw/xDEL1GRVYW88CXBYvbo+PEJFT65C41gff8crwDjmPQhRBMRWpD6HmLcO6mSAKhzzKKGWBwxMncrPM3/KbCX68+5CWFShQgrHlagjFQH0luQ1TOWCzaOfPH1/5Dy7wwAlQwdaKDGsqnnjKWPu6tBbfLc0CIEXTvb8erYosXc7aQ1B/j149z+eUxeKRBQx/3SIAgStR6+m2cc521KxpXGayWAGXrmqiq6olS7ixQKwrjJNkem8Nudy0y9xKCNVEg2OXWvdJoW7z5mh5HqbA9Bnxuop7Az/IL0Mta99KyvvXTkMYffTTbxEiKnap6ykdqUytdPmcA6chBP+AKY96pvrZk2kW/asN6HmET/RMS62AANBOOhSW4+9dSVoOi45mdVl2bQzXaixBmncXrXjOZRHU/olguuiLVIZdXw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zROgUNIkinQdGmpQ4xPZB7YARKrWsmjrheXQmLz0nvuiSk+oeUoyvmLVpR8K?=
 =?us-ascii?Q?tjJT4df7Zmyp0GnZ50NbNUpKKphjqgdEpg7Mu/mRrbfjjjnyWPGy+Yu7yTt7?=
 =?us-ascii?Q?by/AR3i/A1uvxT4P895OGj7sOGegoEE/tPVlFfwK6vCAMBHIV39+MLGe6QVt?=
 =?us-ascii?Q?/dCUcCcBnw4f32T8THn2z68BBf1df7EBFZf2uMhsRarpMW8stDkjzVY+uALm?=
 =?us-ascii?Q?XsLpgWp0EnXrmvT83YeQ/rt5i9tW6XneiEgxQkAkBFOS+DexzJ4Jm5vjWfYw?=
 =?us-ascii?Q?pfGM4V6hR/Lvxu5ndr8rzMMez01+rRwao3mo/mLpa1Zkd7Y7+vrrhWD3vQuN?=
 =?us-ascii?Q?SuBOEuO9h4S2qqdDtju7JSsaHAtdF5jclTCfrntM+wj81wOzNcN2z4zfUpYy?=
 =?us-ascii?Q?myOfifw7vJ38w0lSgx/F05dcsDXqn/14vb0e4zfChG/3gDTDdhjEI495zC0A?=
 =?us-ascii?Q?JxKv8HePQaMIZw8QcsJvBPk6v/prp2gBw9fotlTqCzhyMIyQuEG+3vFdnkZe?=
 =?us-ascii?Q?ASV64Mj8N2k1et80SwiNwq7K+4GCcBfQjcTgEAG6Y5AfXot1JeokwKR60cz6?=
 =?us-ascii?Q?jvw++IL4UMhg78DP9a9W2Zx6GzxUztTGZEiCeJ9OZwB3uDhzVg3oju0ft6Kg?=
 =?us-ascii?Q?xx4YASnrrB9ZSHttnABc8VIdRByEC67vAWyTSMdbe7+ZmVk/GGWf2YPpHLYb?=
 =?us-ascii?Q?L9K0SIsyzk5zSqOzHsKNj554hBQ7YGfWs/v78mdN7Y/KQWWk2/9pi8GXvYP1?=
 =?us-ascii?Q?dV6zazJknKiHzrNXe8aoccrv+ZZNxkzzcsWoBebExi963L3jCNxRt0n9P5Hz?=
 =?us-ascii?Q?UTvwaPs7JUYbv/r10GRvsNgUT0oOs598V18N23Xs3kDzGsLXcFKEl5C8Q/6R?=
 =?us-ascii?Q?KLYjlsTJPAnSse8ldhmJwadpr8Sjpi5RKyQr+rdIJGftrjvMdQe3+TuGMrZV?=
 =?us-ascii?Q?jy7BkpBV7QHXLf4an3sTKJrTTT+fmUFI2QkUV5bRdm1vi1jt0JWZH6RSqX6j?=
 =?us-ascii?Q?1J38prIu1uGUpJMEEuD7bicWMq3cMEFYSlkhcxLnoHKWjJx4iiXL8Je/d7fx?=
 =?us-ascii?Q?OgLF8AXBrTJRTT4gPILJv+2zzRaHWXKektZbEjmnEJ5ttrwqWW3UF0mHCueF?=
 =?us-ascii?Q?kB10Fs1nPF2iwuoKVmNFt0AiqKtnaWYHDQKR7jaIte+zHzye2Ii36rTBvVGk?=
 =?us-ascii?Q?oRi9rPheDY8DL78yLbqOnX70ylB+VE0J+AVOn13rOB8bWHjXVqgsWk8v9Dmg?=
 =?us-ascii?Q?308r+iMM/+3re5ttp0Iyk7czK0DhER/d6cb7zxtkvTH5quehP5XDqz3HIhoQ?=
 =?us-ascii?Q?LbexfsPOYGhcacaTxJLkDJpc8dVfToSxbOiJ3Jc7WgPzH4DSYodLpw9vWthd?=
 =?us-ascii?Q?9Hna08MfFoAhuvNkbHhrsrVSgjUvq4mvFfAHsvQmFfJG+B6RvvKvgR5n4+Rl?=
 =?us-ascii?Q?7e0gHqoRB3zWr/h2zZuHqjFrJ1WjP7aN03ga3oM6qXr2UqowXtJN64XEoOXP?=
 =?us-ascii?Q?mJcf+pChtn2Xni6jQ0IOLxop7f9ZASNXGgfols5aQnN8w1tMCTPBSSeGezt1?=
 =?us-ascii?Q?Ie1uwzNsPTsrIX56msTvFXov1e7AwEPFYHH2kYVQKPngxQQtH80XzAei3uqW?=
 =?us-ascii?Q?3l+Uz2JyriIrslT0Od/o5rbPEJp07B8g5sMpY034n9xqzlVU5GfndAqQhlus?=
 =?us-ascii?Q?0gubcs0388HGVN/rH/pnrHfo0tx4OcwTYRc9wv3ZF6ELH1f9rQBosf/VCPHs?=
 =?us-ascii?Q?xbR6mo/HNQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9181171-a9d4-4b3f-24cd-08dee3e35e64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:11:21.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yY4yJoYrDf3tGXoQb3Qph4mEtcQNst+Dxzvnz1q5eyVLbghqROg2MsowekiKQnkFEDUniunjdIbbzM113PN1ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326

Hi Tejun,

On Thu, Jul 16, 2026 at 11:30:54AM -1000, Tejun Heo wrote:
> This patchset contains three sub-scheduler fixes and a cgroup lock
> ordering deadlock fix.
> 
>  0001-sched_ext-Reject-setting-disallow-from-init_task-out.patch
>  0002-sched_ext-Take-cgroup_lock-first-in-scx_cgroup_lock.patch
>  0003-sched_ext-Skip-sub-disable-teardown-for-never-linked.patch
>  0004-sched_ext-Don-t-enable-non-ext-tasks-in-the-sub-sche.patch
> 
> - 0001 makes ops.init_task() setting p->scx.disallow outside the enable
>   path fail the scheduler. The sub-scheduler disable path could reach the
>   load-path-only policy revert and silently rewrite a live task's policy.
> 
> - 0002 fixes a three-way deadlock among scx_cgroup_lock(), cgroup teardown
>   draining the cpu controller's files, and a concurrent cpu.weight write.
>   Present in released kernels since v6.18 and marked for stable.
> 
> - 0003 fixes a use-after-free when a sub-scheduler whose enable failed
>   before linking is torn down concurrently with root disable.
> 
> - 0004 gates task enabling on the ext class in the sub-scheduler task
>   loops. A non-ext task under an SCX_OPS_SWITCH_PARTIAL root could be
>   marked ENABLED while staying on its own class, corrupting the task state
>   machine.

I randomly triggered the following with this applied, but it looks unrelated to
these changes:

  [  140.251732] BUG: unable to handle page fault for address: 0000000000020037
  [  140.251914] #PF: supervisor write access in kernel mode
  [  140.252020] #PF: error_code(0x0002) - not-present page
  [  140.252163] PGD 0 P4D 0
  [  140.252237] Oops: Oops: 0002 [#1] SMP NOPTI
  [  140.252339] CPU: 5 UID: 0 PID: 103 Comm: kworker/u65:1 Not tainted 7.1.0-virtme #1 PREEMPT(full)
  [  140.252575] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  [  140.252704] Workqueue: events_unbound scx_watchdog_workfn
  [  140.252766] Sched_ext: qmap (enabled+all), task: runnable_at=-1ms
  [  140.252768] RIP: 0010:scx_claim_exit+0xfd/0x190
  [  140.252897] Code: 02 00 74 24 65 8b 05 4a ac ce 02 85 c0 75 19 65 8b 05 27 68 ce 02 a9 ff ff ff 7f
  75 0b 65 8b 05 a1 a8 ce 02 85 c0 75 46 31 c0 <f0> 45 0f b1 a7 28 04 00 00 75 14 41 c6 87 b4 03 00 00 01
  49 8d bf
  [  140.253102] RSP: 0018:ffffc900003f7d10 EFLAGS: 00010046
  [  140.253160] RAX: 0000000000000000 RBX: ffff888125ed5000 RCX: ffffea0004768bb2
  [  140.253232] RDX: 000000008881093f RSI: ffffffff83685140 RDI: ffff888100c45440
  [  140.253316] RBP: 0000000000000001 R08: ffffffff8411c438 R09: ffff888100c45440
  [  140.253406] R10: 00000000000003e5 R11: ffff888100c44780 R12: 0000000000000044
  [  140.253501] R13: 0000000000000000 R14: 0000000000000016 R15: 000000000001fc0f
  [  140.253595] FS:  0000000000000000(0000) GS:ffff8882b379a000(0000) knlGS:0000000000000000
  [  140.253681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  140.253791] CR2: 0000000000020037 CR3: 000000000364c000 CR4: 0000000000750ef0
  [  140.253865] PKRU: 55555554
  [  140.253903] Call Trace:
  [  140.253966]  <TASK>
  [  140.253996]  scx_vexit+0x3a/0x170
  [  140.254041]  __scx_exit+0x51/0x70
  [  140.254087]  scx_watchdog_workfn+0x25f/0x360
  [  140.254156]  ? process_scheduled_works+0x219/0x510
  [  140.254208]  process_scheduled_works+0x265/0x510
  [  140.254272]  worker_thread+0x226/0x360
  [  140.254311]  ? __pfx_worker_thread+0x10/0x10
  [  140.254386]  kthread+0x10c/0x140
  [  140.254425]  ? __pfx_kthread+0x10/0x10
  [  140.254465]  ret_from_fork+0x189/0x330
  [  140.254521]  ? __pfx_kthread+0x10/0x10
  [  140.254562]  ret_from_fork_asm+0x1a/0x30
  [  140.254608]  </TASK>
  [  140.254633] Modules linked in:
  [  140.254689] CR2: 0000000000020037
  [  140.254733] ---[ end trace 0000000000000000 ]---

This might be a pre-existent bug, I'll investigate a bit.

Thanks,
-Andrea

> 
> This is against sched_ext/for-7.2-fixes (0e2f4ab68a89) and also available
> in the following git branch:
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-cgroup-fixes
> 
> diffstat follows.
> 
>  include/linux/sched/ext.h | 10 +++++-----
>  kernel/sched/ext/ext.c    | 47 ++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 43 insertions(+), 14 deletions(-)
> 
> --
> tejun
