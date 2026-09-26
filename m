Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54B377A92;
	Sat, 26 Sep 2026 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790459999; cv=fail; b=p0b2bSLdftr4n2pCnZhk12AFxjjlgEQ8k25QkM+XaKtMtp9mcuGdjueSMKh+0E7TcAXOLQsUlVB3kLfRWX9dg69o/hlM4uqbI277AgtwedLedPqh/bIgM7Au7mVFG3JXmI7MjU7MPk5dNhlXTiItEvu54JHgF2TTRFtDZcOag0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790459999; c=relaxed/simple;
	bh=ka+onTMj1FAv6+9GWOtLFebO75B7wmJULDsg9xOXYBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gF72vsOcUCks2B5igjmL08z4BQKRHVFMBhoHjAO9XKdG9N7w31CmGELv66sxwjkVq4zt0yDo7R2V1H1jhsQL502M47tzAky5ELL9EoIihOYOUL5P1BIKLVMT72npKWoFq+mkp7l2KzRFw5bAOczum6oaj1Lb46V+mjIC1ZICiu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=InR/1BVX; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="InR/1BVX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tB8bODIGjTg44YS3uXCGvIYtYKAjLvGiM2rXVntJIOiTMTHoJKKZuN/IoMBvhrOXRlhOmURBnfViVpe2INwwGMr7sFKM4d0qD6qTjHE+SvOBwHmIY3HxUcryD9M8/bXuVxsd3s5V6tt8GX5G46OjGxA5ocusWC4d6FUDbu8MJfe6XpC7nOCmfgaJZh6XIo4R+6Z6eKNJ2ozF4NhP0TKeEyYGLy3w0MEcEPZOJefbCul3hi67XUEOn+KINBAgVosQjJzp3wVfctU2mixMLR5MOdDkaICK9br0rC64MuIABmaaB5YnenRcny3WQaY2K4pvd+u1gzlbq2jVHaokbJbXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU4hRNAhUZQalFVqpZnwQ3K/8Fy0vUZ+kzJTfqIhKVo=;
 b=KgVZNGzlQcb3iqeTxAgQd0Cd4/aN9nBQ1FVO6QRUm2JNXRUh4U3g18xqtskOzx6DRD4S16Ppfiik/K0WBMOflm2xMyDL64DIlryq7ctJsTvxYCs1y6lBCu7yilIc4AEA1x23s6k6uiqBLCTGUHamPpONagSrojSlVGMOX+kuh0rLf9U7/8hb960hZAU4OiUJFmMc7olIugOZ+UNU03UupTRlgoXUp3oLL5RjWhZG89b1poPV7P07LHTfwZA9g7o87YiorFp8Fig5U0+8UFTZ/3pY4Y98olNMsqNLZ2H0QEmdpMgmz3uTNZ/zpi2Mu4ks+841vajwrvbMng7NJ0kBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU4hRNAhUZQalFVqpZnwQ3K/8Fy0vUZ+kzJTfqIhKVo=;
 b=InR/1BVX++ru8EuiMVEGbZlmAnGwr2+RKNo0C7eydFqRQ3mR2RGUKUMMF3yu6aQaMWDwG1sHlOZvDzh92QrD2evP0k92S6y2W3yW1TTLWsXWpIABq0GXOAT7TgAIkThWU0PP3JLnNVJztrsvoPLyx79uP5kFuun/Q/nHF4B4H5Frl7TwKjoUXvU4xu06fKF+0rmGADGSAeK9J5zzhmC1d8j5w11IIFdQhPCE/pJ8A3DsBsevGooiUlJgP2L6Wosh3mWQkG2ME/6HO/T9U43biBrzG+1dWmElD2tbRzC5XfezlQ6rbxLGnCt/eg6n34NKvDYJbM6dubZh03GHJUJt9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 21:59:54 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 21:59:54 +0000
Date: Sat, 26 Sep 2026 23:59:45 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.4] sched_ext: cid: Represent clusters
 explicitly
Message-ID: <arhAURU46nFUpXPc@gpd4>
References: <20260926212017.3351797-1-arighi@nvidia.com>
 <20260926213437.5FAC91F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926213437.5FAC91F000FF@smtp.kernel.org>
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c10ccba-c781-41f4-75a8-08df1c197ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qR/sguuf1u6LL/XtTZU34LBio1Da+CIsJrx8Dx9SV3Q1Gg1djt8KGX0nJWvfBxS1P8wp31RNIjjPUSTr+Z6hHZYUBc5FrfhcohN2IzSXdTMhSfzDrordeEI0C2at866uM5xYLyFjEBMuw3+yX+J7C7RR2wLlIv2B4VHDP1P2Wr6YmsDgtIxE6yAC4d2IJ3yZdT2Um86J68Np4Dm0J0furhNoNqXzwKp0wVesLCxgTYzwS+Nj+Ps97anWcBz1Xlj70nPv2zDOe5d5VMg43gvvbVK9XKgH6j+cQ5hPBb3dtlBwf5s2dw7p9jxvGruARtU0lapsWgbz4X6+3eSBgB50PwkZc2kdFNLkC34ClY0ZV9dphbMT7icSAoCuH26iabe9BJSLnnRF6Ru2Q35DEBYWebg02T4HExbI+UB677r7HFQKl4FjkavyyBoThHISdeGnJs4D6XpYB7ZZzOvtS58E/L9Xp32YIW+FRvXSYKtc0jUJeh9GLjGNseuVXnOXEYZG8BAK+iEpnIxNfNZXTOi9qw+Um6DekzQ8An8iR2famIBiJfB/XPbSsxAl1WkUWCSMDsEONsUPP+ZAVVNWJ2RqhLJwp5Z7Cvp0oZaNbjF8kCi6a6Dj71RdPGJhbofS2k31
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2QtO0fu0ozxhy56c+cY0arkooyaxV5wtw2wysv4onFDQuxzXlTn+/CUj+qI?=
 =?us-ascii?Q?dc6hpUkhBMvV5v3AZ2KMIe6FHIfaHbTKd9xDHJdwMu+NyDGQEsqo8Xsta+1N?=
 =?us-ascii?Q?ivfCMs/8fcsh/nqKjCqnfQVWrbeJ03yCwSzGHP3rTxlJOL3YstQoY88feoyO?=
 =?us-ascii?Q?+jxnGQF5+257NPsoMdYXlOMNYYtUl3bAWRiMndIFUhK9bfnlMmFBWvOqYWP8?=
 =?us-ascii?Q?5YBTJIJQyf/jMaXYaWWb6NeDOtrxYBAJ9U0p2GKnMD9WhCzWURiYO5ibZ6KU?=
 =?us-ascii?Q?MCwN+PU8k+BE8eTo0miKxUGo9KJWZXpL9FJLe+bJM7o2I9J82r5eJceCcZ/+?=
 =?us-ascii?Q?jo7vp/poljvA6o0Zp4bQzJlTXp8krBola6ZcfR7jDg8hNk9pkK98oLWXfBqh?=
 =?us-ascii?Q?48Ijaafq4vK1IvvfOhxChnwEnKFtNHcXzmNpjNC2VajJw1Xn2AmbwdJccqfG?=
 =?us-ascii?Q?B/Z+ehmO4jNX0t5VMWJdWPtattlt3rxCI2//2WemPF1yYrBlR71v6dzMufn8?=
 =?us-ascii?Q?yhttV8+N1J3TiLFOsIIaqxmZvi062wlJmXLuGund9j6db/8xAWjFN7qQ/a4s?=
 =?us-ascii?Q?ZrYf4jjlKBwzHAHvxdpkcD2Q8v+V9up9h36LHNtrTZ+YqraVPh7OFa/wj0Jd?=
 =?us-ascii?Q?m210UGiigxUdNk1tR5lUX1Ns6C7QC4OfphfwEe1fzqMHFuPsGWExHVG9bcip?=
 =?us-ascii?Q?gGzmQIQi0xgmwgO/IXApSil0IRyBTHUVbIUizvA7ODpv22mTyUutCCU1RIjk?=
 =?us-ascii?Q?+rY9ZnHuym5lVih20MoCe3kRK2OiU032g8rpIh9ZdM2z9JrEiLOwqyVW0icN?=
 =?us-ascii?Q?KlV7YCxenpDV8Ok5P8raAc47NVoI0GtI5vv441JbjHzqe9TXGxFKnNWr8aLo?=
 =?us-ascii?Q?KKv5sf49cIK/lG7g73AE9shXRq0Um+q3McAhkY4tpyYfibBIrpPZ/pHEhRxd?=
 =?us-ascii?Q?TsGtS3mH2OwdzLSO3/5pBLdWD47tj2xrEgRCXbEU0FZGPshM8GWBuIlhFuBo?=
 =?us-ascii?Q?o7Zuzkb7SxnrJ6MH0SamJHyBh3hAfQskVfq+g8FWMxRUOdGuN2btc//QoQKu?=
 =?us-ascii?Q?G3TmvA25s2Tusfd4+oVp9oIncGDScbSXkrLNA/HHc2Kg/ZLFbPCo//LNyosx?=
 =?us-ascii?Q?rK7hM9xM/VtR0F7wOeL3Bailz9d9rgH+qvfKP/mVaa/21Ms502jKHZzbMHhx?=
 =?us-ascii?Q?7C5Te4tIg9Ze1pR76lT5BtP3dochhplIhKco1mNgbXIrOuOnQmyviUXDEs6S?=
 =?us-ascii?Q?48WktGlrgcsXUP7no3+NBkgNZcd/SJacNn1977nU76hPhU4YGz81dAkP5Hju?=
 =?us-ascii?Q?Y9N+IbD32xzn3d4vTFkB+3BfPVDqPkYNCrYV5v4oWitOI4H1FGGB4sc2YpQn?=
 =?us-ascii?Q?NtiLX34eghEHlFbdAMAL3H81ZmtvCCVXpK/Oj3slHrEXtMr6XGwQ+ZKdyXbP?=
 =?us-ascii?Q?tZL8x8E22ENTZfb8aNTYl80jwFTPbnk407oCzmFVjmGoC7SqR5J/A3/bCNEY?=
 =?us-ascii?Q?BIE+gSOJuyzjChxO7Z714WoRRmvxLB4E5gxrc5ZfuFWCBxIj+XPc46G0FKwC?=
 =?us-ascii?Q?VAblrUAEmHhPGbsgWO+X6xqzy3Tmat8XpT1+mplsKeqxkOLGv6U3C/GQFX4p?=
 =?us-ascii?Q?zVTDhDoyTr1PQE9MTYoqNDs22uk9MKtpjfvHBNFVqIl7mNaZ5qkbZZ8y4gPD?=
 =?us-ascii?Q?R81UQJ6ypswkEOHA5W9NUEBT5komGU3KEItQogU2HQEPD8miQODX8XUUnGsP?=
 =?us-ascii?Q?IudKNXvGkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c10ccba-c781-41f4-75a8-08df1c197ee5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 21:59:54.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlCJkabIUb1dvoRHkZm1rUXYwkFBLP8mYonUUQ6cF4aeOwVGtwVU9PrvtDojePmEb1yaNhSAjFuoCJ0uTmjslQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470

On Sat, Sep 26, 2026 at 09:34:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] bpf: scx_bpf_cid_topo UAPI break due to struct scx_cid_topo size change
> --
> 
> commit fb59a730e3e34d8a0c1fda134fb4459d8183c802
> Author: Andrea Righi <arighi@nvidia.com>
> 
> sched_ext: cid: Represent clusters explicitly
> 
> This commit adds explicit cluster representation to the sched_ext CID
> topology. It modifies the cid calculation logic and updates
> struct scx_cid_topo to include cluster_cid and cluster_idx.
> 
> Link: https://lore.kernel.org/r/20260926152306.3190774-1-arighi@nvidia.com
> 
> > diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
> > index 943d8d429a2c9..765d7b9208144 100644
> > --- a/kernel/sched/ext/types.h
> > +++ b/kernel/sched/ext/types.h
> 
> [ ... ]
> 
> > @@ -88,6 +95,8 @@ struct scx_cid_topo {
> >  	s32 node_idx;
> >  	s32 shard_cid;
> >  	s32 shard_idx;
> > +	s32 cluster_cid;
> > +	s32 cluster_idx;
> >  };
> 
> [Severity: Critical]
> Will adding cluster_cid and cluster_idx break existing BPF schedulers that
> call scx_bpf_cid_topo()?
> 
> By increasing the size of struct scx_cid_topo from 32 to 40 bytes, the
> expected argument size for the kfunc changes. Since scx_bpf_cid_topo()
> lacks a size-aware __sz parameter or compatibility wrapper:
> 
> kernel/sched/ext/cid.c:scx_bpf_cid_topo() {
>     ...
>     *out__uninit = topo[cid];
> }
> 
> Could the BPF verifier strictly reject older BPF schedulers passing a
> 32-byte allocation because out__uninit demands the current kernel's BTF size?
> 
> Furthermore, if the check were somehow bypassed, would the assignment cause
> an 8-byte out-of-bounds write into BPF stack or map memory?
> 
> Does this constitute a hard ABI break for existing userspace binaries since
> they lack a deprecation path or versioning wrapper?

For the records, as specified in the changelog of the patch, this is fixed by:
https://lore.kernel.org/r/fa6479d36b528573565ca22914451317@kernel.org.

-Andrea

