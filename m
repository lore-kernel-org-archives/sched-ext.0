Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2130F55B
	for <sched-ext@lists.linux.dev>; Sun, 10 May 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778425108; cv=fail; b=jrkMXKNrl7/79XoJXafmjtenuf91QNEHm5k/SAp/F398NxZwnFpeRnDPuuk7eL4LKrQSEOwZQpZ3OGdcrYAOMIOOa9T+g9xAqErIiYxLWLPLp4+NEgNTWlf1Uvlg2sq5eVoWY3j61BhVKAU9ltPy5q/yiUc0+yDpy3KzqkTbLBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778425108; c=relaxed/simple;
	bh=mNrO6JskfvgN8ELNpjoIVg7WEP03PpAfd+twRtBgwaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9TNWC3U7Kq5CuISD1FbM46FIhM5n8L65lJHYVeUgxH9eladfSSr567AoorEHunW+FkH0jDAUcqfQnNNi/v9DcKt2NPRYwGmClIka/6NOj962yndXCwIbr/G5sL1cC82SRY03Hsdf6X+zu/2Ab83zR4PKqpJa41qKuKS+/50syc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S9kgmkBD; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S9kgmkBD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dtj3VSDduMcB1VwPDq5C7wTzFnEy+frMzksKL+yUNnJ/y1bpDf/LuupqTSflwwB1P137FZv6hF3X3bk8LqdavIt3cPXZoiFys3JcE+sVvOkN1SHeJEzqBeLajTDGUu7fKrgCSeML4pDgeHOJdpiruvBySaRrllB9xbuYNTmmXrQspNDaZGoc26ZfjLBfd4G2iLjFOpE+HRuIe6vjtKYhEWwQjqz3ljlLz/+QtJc0YObGB3pJu0RO6SFBMED4XGqeg44QNOO5BtYnMfcxoAKlnvNSEr8zZnvitip1fPAcMM66L//K8IGTV/VPSkFfP09aLQknL4Cq40L+sLahxLnOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yudMFMo5AaiC2QRWFr+G5lerAx0A+Xk4t6gjj8j/uxA=;
 b=sETJMYJ1/iKzWtq4vMQiEY/tauuFN2RrJy077LRLSugN2QRTAq2ZG6hcC1Yd77HC1KAZH+2J0hv+LdGb3d+6/dXqvMkHUaE5Zlcu+Gf+lsY0/80k0mG7CDNbYlulhzK1uM2XawOhhSaIjN659udnIZVVn0aC9GQsxqZllCcUGhR1KcMx25VuHSgAHPtA7x52+bSkL1hjLuQNM6Yix3tQ/s2yhNbQDQMMl2QAvV/97w+d1hIDer0Mi69UnuH9Wz1FwDSY2/RW4ImLGTFZ35cGFThRnRMMsPVaXgB5bNskOYY3p/PckoEY27ewO7ndZM2JmgxoFI//ZOEFMQH8wo+vzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yudMFMo5AaiC2QRWFr+G5lerAx0A+Xk4t6gjj8j/uxA=;
 b=S9kgmkBDZVVhnBvZODb1WtUAjaTFmPAikt1gkCSkHVj9iC/2gpSwVW5jVkxQJ8CkXEZFE/JeyVna0au6aMlWJ8i2ytpunrxZSO3uYUD6WpEDCf94m/wSlndlCvLSowEOAhz3eC5v9W5DhqScpPPrjGvSGgVDKQWpD6yW7oYGUg7oqxjH3H66NOqogiPwVukWJDiTrCfKWd0GFuslynLB88zabnCylJtn9tvBugqsBhOZJSbkhsvtCOCYgSaG3L4CCIlVmkM70j9i+y06WPSayz3pXa1KsfhP/50e0eCruAJzpZ632TvtV5303xpfmaY18eC7bofJrNc1Le0zOzTA8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.22; Sun, 10 May 2026 14:58:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 14:58:22 +0000
Date: Sun, 10 May 2026 16:58:13 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 1/2] sched_ext: Add dispatch transaction API
Message-ID: <agCdBQXkDNO4CWoT@gpd4>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
 <20260509191223.168648-2-yphbchou0911@gmail.com>
 <af-l_M9p9npc9FUA@gpd4>
 <agCP-e9ZL8smNoNQ@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agCP-e9ZL8smNoNQ@slm.duckdns.org>
X-ClientProxiedBy: MI2PEPF00000B83.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::419) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a12139a-ecb3-49f3-f245-08deaea4945c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8km3KQTpbSTxEMSOM0lV/m+LRt6RvaEJQIZn0a2brX1jAukZZxXuYUWk8wwxUhOnjjDF2Oq+1YdIHzWt1ddrZk1UZHp89UG0jv5MeuERcYQShSCLiGRkl8u99OIqn/cL1XU4vnj4soPxPDAwtXfABhxH3zda0UgiorFXr1bSWMu6rasFP6+l58A+6/nElgQN7LIL3Rbrh2qKSNp7mgKXpeMMx2bxpmCRpwoiKjGKFGfmsjPWRnrcIHsbQ6PXuD+HgvE7wsNvisds2A1eBLcGns1KKqRPVx3gSQpbjY1aYoQ2fbr2yXmQ5rBe94VdRfJt5/z2+p9GL3DB/LXH3Z0/hkZYWD/4UFo9069sY2lbi0g06HHgSUgOs2mYqOM11uPet386AfJWJI9hKYltjZehtUCbfEMfa/FEPfn2z4NG/Z2I/YN8aV1Xt8vhOg4WC57QoX+dYMl7IPrR7OL1QHEI3a23GfsLQivbLZ0/l+jka6JrUsNOxoJPUXJpthi/Zfc6oBZZcT79hGCU4V4A549qo92YSmpEzg92eYn5YN/5M6vustNKJeZ7pjA6ailzacy2yJBDXlVnWqZ4Px9YWZucSnVJ/vmz8SB0nfkGPKruu3SJEZ/Hxi/n3djWoU2wmzj5pF7r+RCfDqWIUkOY0orDehJVSTcdpmoo/F5X6b062j4P8PPpMH2en6fXawBZaZg2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kwv+INw3xqecixvWBEvbwjJeMvINS6teHgSf0o4h10wGZnwFoFgZYzSMJDy5?=
 =?us-ascii?Q?g1QK/TrwdGKY4b31Kh2CIHJ+oAncrAXuFSVr11WFjlZHDaIv2hR2mC8W0J2j?=
 =?us-ascii?Q?bM76OYcVFR6E2UISIaJGNVse/RkqRevhm1su8TtXhsh7TOxjbd1tyRFQWpjy?=
 =?us-ascii?Q?QvC2ipvP8p7Sh3HfpvaiDsU8IV6bBb/CMI/aKgHRDWp0lBUAOtEgMXLTVZR0?=
 =?us-ascii?Q?ue7oMzTt0OwI+YYerBDv1VoXkrLwZwqk9SaaYONBuo/jYx3fQWxEfFNl4OQz?=
 =?us-ascii?Q?1g58jrSztK1EJiWp0i1Kh1INZ+4pbCFwFY1RCp5ZQl1hY+4m2vQME/MQ/Gwn?=
 =?us-ascii?Q?FmSITJslbhSIy55n20LXYptst26l7yVT4HEi5n79UHv+UB1aVnF1DhjfFzEr?=
 =?us-ascii?Q?Kz0bntfeA9fcDHxjes96YwQaxdLpBfiiri8wYbjPcd+9nwyt/kxG8tcnLYh3?=
 =?us-ascii?Q?+d+FDcyJlN8+mkfRvTulhT4I2w1AXLNgoZFu1Ra5viKBhrqQXCe8svMV3F5S?=
 =?us-ascii?Q?ZOJD6jGN+wPAPV8h/ouQkgbyDUuN+aJQ5W6Gj4jw3bu+DupB+d6C/ajRYn7r?=
 =?us-ascii?Q?6ruzldURcJwOTvLmTgwKha73Kf/gqCA9qSKDnCEN8Q7jb9PYLhIv8kGtrqMj?=
 =?us-ascii?Q?0Mmrjl4+btJz0KjhoeW2s7rkDMygar/eKuSjkOqvSSEmy277XAvjSl1oxX8B?=
 =?us-ascii?Q?ulPSP5uZLQXyCKUgZ18PsWw7OSuTa19VUxA4D0XTw/lKOXRMpnf7ZDM5Zuhb?=
 =?us-ascii?Q?rGceG+h5agiJdzEix+gKejsofUmTSDnmM2QJsjUOLji1GChR+yhWKXo2Q7GP?=
 =?us-ascii?Q?AiRpDo0Vl+nunWmf8WqPjAutMtUeJtQlqfJEG54sdQlNZm3ZK5SHrqWOa20E?=
 =?us-ascii?Q?Kw6mfBmsv3R8w2Ocx4UlC+Q0z3zY5hHAAOYV/bso3o06mhqJXd5u363WRIEB?=
 =?us-ascii?Q?WteBIGyKGz7LpG9HLTlB5r9qeoy5wUU4rPaqxun9dUEWATbSUrBBAeIvwody?=
 =?us-ascii?Q?UVEvcvrdAIx5wjl4Oq/bF8h80YRODAnTyDx0Faa0nQVMnyEyUjJKydPha54B?=
 =?us-ascii?Q?7RCA7niSzj4osk+VFwV+CqzQGA8GVpTbnc0dtNOH4Tc34gN23xalcHntSTcn?=
 =?us-ascii?Q?euJ/uzXtxxIXfGjJPli084xE+YTF8B3fiCO8u2iLy96EHUMbz1FZuFdSPgon?=
 =?us-ascii?Q?pIIvP9oE7xz4vfXfV0dAAIBX7H7D2UXCxsqPNxZdv6LbIRpnNHsY5mhBiOZt?=
 =?us-ascii?Q?HIvMGZBCAYVb3SNCMZwS06c/Q6z6cNOO/GJGeRn8iGmmTmuesG/+AkoGf28f?=
 =?us-ascii?Q?ZyQsVex/3WoXzLs0rT3XQkPoWcV1/bP3R8GvJjWY1sERsFEJa1rv6jYNGxJ1?=
 =?us-ascii?Q?jELetygp4K4ZhSXuSfoZsn/NvyUTaZoue/A1dpQLudK31xlkrZwBUD+3GDEN?=
 =?us-ascii?Q?us2p/54oSDtlzl/5S/fCwJ7JWwuMao3SEyggwV3qbE/tRfOYZtUJanNI+BRA?=
 =?us-ascii?Q?ktLDDbO9aRklnelEcG3RY4gx5rYQ8noIlv6HFTv/zF7RVUHf57zU8Mz08fCM?=
 =?us-ascii?Q?pDaKdqXrTjlrvwlLNFEhKWmCF7GmQP1i42+jV4lwnXzRFDTU7/fraJowM8an?=
 =?us-ascii?Q?tR2/9dfATdLsSZWe2MCmSMO4WkLmMfZT4e2jeqtJu09rz3XM7qMAKHrEX363?=
 =?us-ascii?Q?mWvPd6UToaetMmuNancLXxHGgZyDp5AKCKuCMa+1XThIbEnshIXCl/r2rTw9?=
 =?us-ascii?Q?nUOMFMHF0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a12139a-ecb3-49f3-f245-08deaea4945c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 14:58:22.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSntsWnnxOzej+nrG84Fhyt74kT1YAbgSoGUlO/lsd1e6jhSQdvuUNQx5mdqHhzhsVcvDEVzp43rktWpxjUXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

On Sun, May 10, 2026 at 04:02:33AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, May 09, 2026 at 11:24:12PM +0200, Andrea Righi wrote:
> > Why not passing slice to scx_bpf_dsq_insert_commit()? Is it because of the BPF
> > args limitation? In that case we could introduce a struct similar to
> > scx_bpf_dsq_insert_vtime_args.
> > 
> > Speaking of vtime, we may also need a scx_bpf_dsq_insert_vtime_commit() that
> > accepts dsq_vtime as well, otherwise how do we use priority DSQs with this new
> > transaction variant?
> 
> Given that these are only meaningful when targeting local DSQs, I don't
> think vtime interface is necessary. It'd probably be a good idea to
> explicitly restrict usage to local DSQs.

Ack, it definitely makes sense to restrict this to local DSQs.

> 
> > > To support explicit token passing, rename scx_dsq_insert_commit() to
> > > scx_dsq_insert_buf() and add a qseq parameter. All existing callers
> > > preserve the original behavior.
> > > 
> > > This mechanism is intended for schedulers that do not implement
> > > properly synchronized dequeue. A scheduler whose ops.dequeue()
> > > synchronizes atomically with the dispatch path does not need this API.
> > 
> > I'm wondering if we should validate qseq also in mark_direct_dispatch(), it
> > seems that we're not validating qseq in the direct dispatch path, or am I
> > missing something?
> 
> In DD path, the task can't be lost and it'd be a bit silly to use this
> interface. Again, probably good idea to at least start with just allowing in
> dispatch path.

Also true. Thanks for clarifying.

-Andrea
