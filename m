Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7F2F5319
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682414; cv=fail; b=iPnvMr6SSu2IrnA6apnigpFUnHKonLbLlSvnJ6Ub5X6XU6NFas0IIBDknJU0gJ41CXxmGT2QUI53op8vCb5U686kgXdNouAUb4fPyk8EgJIfW3IsLJMyAy6eiRTmRgre/T4NgY03AUm19x6DNs2c16rJb8+bmWfYphv19ej6ogc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682414; c=relaxed/simple;
	bh=7t+PDNv+j/G21avZJcfpkolmL1QDbILHZiWOZhMF6WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kLc9SU+ksgYX3k9aA7bNTJuQX9j0Fre1vKzFNZ3f3G8NbgtxoCph+DvqXXMseJpw4fYmUdyXJDfH4pBGiOzRe2wBohpLRng4zH4Yf5nfBZHQhBEtrhVKR1MNZmbwTgz4xDfge50QEQ8TixUk0p9WNvJgZ7+ftMo0d6/DDZSTjvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ADLqZ0ia; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ADLqZ0ia"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thAfS3KkahZhlcmU9I2bqgP30MpriYVFuNmQrPBNlt2GfUSyiwuPoCQtbEi1IQKqTeM3NCyr9ZVVFcSIFJrllod5sGQL906LgxpZkCz70WczQg+DFO67G9TCyLUq+8T4HiYJ7SFofiqx3UE075DfqDl8H6MR8WBv1m1SW4PJJX9DskkM903buWUs6vn/QeFOLLow0Mz1UmUB3zPWu3Na6NBNwNd2cEcGNZqn2zyEtqM7lPddSOESn9V1zT9iH5nsI1jN2mLFCZa/GfHj8LsaBf6qcALZG32cPcqFRzryU1hxK6pyQi1/NbV0UTsXf9cnRxLPBui3+ArRDYj1/vabOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyi166oYG/GqFOnJz2XCCnPBPPobeSX3yrlMqZ5GFOo=;
 b=a5uYlkh9SSqRq2TkdQNv3VEtc0e/x4pxWb3hZHmH9PjU7aSjZx9xv2GurEwwg9WIleHXw4rNJgKHkVlCWPNR43VV0+qHvscOuIajEJpzLKEwKJdJSM+Tll6cDuq/fFAjW1bb5ID3XDyFs9bV+hPrdywPCR4v6Tovqba0Kf7zB8t2DnV7isAYYMkYoicLVFxQaJdjhspkBLwM2DfBy1sujGoIHu9DIfwtoxkuIq7eitRnwF1YGmQu5NZ1mM7LZikd9WxPKJ1fzQmP7SjOcCE1Pw1AQoR5tCP61lLsQ//WnCC1ihf0spKa7MS0oAKNGidv+IDLRnMKIGV+EjuuFyQM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyi166oYG/GqFOnJz2XCCnPBPPobeSX3yrlMqZ5GFOo=;
 b=ADLqZ0ia+VGU2o2xYXW+qw418Sx62Z3g6+/6nlSdUJ4k/8jXGow+y6KRce8uFjrHJhwZHimATgv0cZy/HQrcjd7kbjpd0xc1bSTcRt6NkEbhNrHTzmUztumRTFvyjphmApNcpQ/dknfm/D3gENEqGGuo4RIrpEMDYkWKVJrxxGwqOdFKlXw0OgTQNG3RcRbn9Zq6Sc4xutrGtDdEUMYSt1bfdiKu1Z96F3s/hVBJoJd6knNz7ExCKgFGOniGDsV7TBTjo5ItgO7TOaOuRI6nV8Wod0RdHS+B8J0LEslNl13/iPF1JRU2EhulJflJRr3VYdB+aHH0CM+/Uwu3uXX4vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 16 Jul
 2025 16:13:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 16:13:24 +0000
Date: Wed, 16 Jul 2025 18:13:10 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <aHfPlm2wXPJQQiQn@gpd4>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
 <aHel4LvT_Y5gpYfy@gpd4>
 <20250716133631.GZ905792@noisy.programming.kicks-ass.net>
 <aHe2j6pIyQiBf1S_@gpd4>
 <imrfubmkw3a6qdznnpounrnen5ituzchwtbjmouocuk77upn67@ljrz32ppyqyr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <imrfubmkw3a6qdznnpounrnen5ituzchwtbjmouocuk77upn67@ljrz32ppyqyr>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 3deb2f2e-59d8-4079-dc9d-08ddc483b0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vLmVXycQPoWuSOt5XfQkz1gvn70/RydJ40sOpomXTLa0pMdxnnxXuR/0HQZg?=
 =?us-ascii?Q?/OYwrobXIHtV93WSGlQLHGOA7z2qdV5GF0T+CBocTWTgKYDNE9L4Vp+SfGjK?=
 =?us-ascii?Q?uXIyo3z1lj+/1TobWO4q0X1S9Tbxj+Xo14CPxHQM2iM99hVMiXgVnltUkVpH?=
 =?us-ascii?Q?wID0+I8LV9LumXInvzTus1ZEhgWZOtuKegfV1nvT7F6M1UCDBsCMkVueSLcz?=
 =?us-ascii?Q?KGi9DHJYaToCPqvDfEYbsjOqPEMQux14U27rLOyAyrXnJrUJTK+sOWngPW4u?=
 =?us-ascii?Q?FmDoUY6ohC4H7kYr7OUjb/Cdv17yfBvDpgJhc14biufc+TdT78sTQRKkswqG?=
 =?us-ascii?Q?Lde8/1eet5Up9q0D9N+4NWLIuovhqduLTz92ZBhf4k4e2e4ybXj1MxPnkOq7?=
 =?us-ascii?Q?FVOKyFGnkP9/4r7NZJATmG3/7w9JK08A0GKWj5FuhwBVw5Ff6jls/KJaoeM3?=
 =?us-ascii?Q?sUk2fKo+vixoqgZTwLvcHVqQCbexGU1Fl3L/gz2Sh8MUR+ZzTIL2IGmq8jtg?=
 =?us-ascii?Q?fQWRFSLfqWNCrCPIsTZCvJPnSri31wKYm2mboULGZBch7dzLszPCHzQ83zfd?=
 =?us-ascii?Q?BheAgGebEdM8LoOEP7hz8pR5lfQ1YcYZ1L2LKsAAyNVY1HXqgFMcsuXgOBxg?=
 =?us-ascii?Q?jbhGsdFmrtMFxMZ9mxwnRKtCG9U//fbLlD2vncJ4FVvaThze72OAm6HV79qW?=
 =?us-ascii?Q?69SQmR/+e3Kbo0zSBe8au/q41yjcze13oeeI+1Aa5UIwGpOzvhR49LTpaJ5Z?=
 =?us-ascii?Q?Aj8vTES42BhTlUGCmTMQDPUbfDEXDJqLXDC5QorZFD0ycfLj8Apq9bDqgAAe?=
 =?us-ascii?Q?ysT2+7C33WUDQYqyL+tpZ/ZBExXTQSceWF7MInvguxZdgxaqz4AugNC1NHdM?=
 =?us-ascii?Q?CU7VYpzmHe2v+c6KoMzvKqpAxepIyzWLRhuytPp5UBPqhAP/ctCfDpDOKGtJ?=
 =?us-ascii?Q?iuAvIItETU5U6rdn6mHkK7XhZnJrvgLrdaO2PjM76K9QFcW95wMRDb7l2z4X?=
 =?us-ascii?Q?TT5sEM2uiA0uVTT8cs/tLfSsdMzaQyj1o+GJvcro+6kUOKWBd7jcfNvfnuEL?=
 =?us-ascii?Q?+kvTnDLsVj75mhE0VdahwkAAJBz6l3e130kKGo/vLySR9pp+hIATuvHhXgfb?=
 =?us-ascii?Q?0HOQnX8nWY18jzLq26vxGVfAMsBJVg59BcjyDibZTstMfwqrirj1JO3/eP7y?=
 =?us-ascii?Q?6nTX39sSb01PV8tpClidujJrVv2ZkRSYb1DMPGJ38ui2jrwHAwOZZgASjDFX?=
 =?us-ascii?Q?/MTq8sKKby9kqqb0eYdDb+UPG4gBoUg/gBDyNcB9ytr8Pzc0PeLLvllj4X+4?=
 =?us-ascii?Q?b8uDXqc12G6nFilId5ySd3d2zy9S8jkCCzJ3/6RdvIXch0TeivGGt7UN53Ex?=
 =?us-ascii?Q?bWOimcaKAXpQSmCTzH1cc6H6MTUL3FlRSmfbOvR5/RtuqTcsanVGzmDMO2EE?=
 =?us-ascii?Q?VH9sGL3y5IE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XlBU/LiMTsqFjmMdADLPk0HlI1VAEIrBPKbgnh2B2PgcIT+Iz/ZMjs54ZTC/?=
 =?us-ascii?Q?yycYiUFXPIUaUzmjxhYpyF5jGca8sXb/PkrjjvCPS9ybeJMc4OFqCRI6qqb8?=
 =?us-ascii?Q?rBCcURFfEglfC5xMzm3HD//UCsNA19dImIvNcJJrds9TE/H1kbFxKrQM++0a?=
 =?us-ascii?Q?DASSM1U/RRSdY6tO+wVqMpChgc1+ObTCWXIahQNV7YEkqim6ZROWScJky1UM?=
 =?us-ascii?Q?LJ+5oGKk6R7aoxKwvxuEjo5eS9QS7034J5SYc5wdVndF95dTJw69EEdLSkMz?=
 =?us-ascii?Q?I+fbaKXWvj5Uj1hQEQrOKKyXROctOqb0T/TmBu2tK62E9rbnldiSK8vfjHTN?=
 =?us-ascii?Q?4wmLXKutI6lHkdGhBAj49/3y66yfzOpNruI4SnBUoY5mgtjDYAp9uEtgamSg?=
 =?us-ascii?Q?ajAPOZyPFD4ujZi/uEkSh7wMZpg3sjH/GJt9rhJAubagyLPDhWR2HjL+b/ze?=
 =?us-ascii?Q?C5dHlVtVbUmNSCYTy3XT94nFKLDbii2mq3sfN84LTh0fEYWsu2I8YOCjT9r9?=
 =?us-ascii?Q?wNU4vqGei5tbuVQF1ksundfd98M0gFlLzD1lL6GLHJDQ6LRh3gb34hGpXfSi?=
 =?us-ascii?Q?L4SlT/rS4DDAC1lDYtf46r8kIqSj/DcWVjQs6ZWQzkkdFBE0rsiPY+ie4mja?=
 =?us-ascii?Q?au8xuGRJGIK+PULLehdAVogs0x0h8ObI3OXCf2eipDNNqdO/yDmulegKIMDd?=
 =?us-ascii?Q?JbWlgptCR1vzmzL/VLyrKM+6COL/pjW81XMp69F8LeA64AWTVL8h6eKhaBvp?=
 =?us-ascii?Q?UF0a5+H7J5NlBhjHszfs3921XRGChQroUV6E3wRfKV/03xYrCkaFFz+SA1IS?=
 =?us-ascii?Q?VZVGfIqC4R0LbYzJFq5MumdmG1saSJ+QCME5lUQXAzQ1Zk6PpY+BGSLUS5HE?=
 =?us-ascii?Q?DV7hrk8fQe8KpbYC5nH1GcATC9K8ngFapdQmTa4naIrdhlLfxUfu595ZoS0c?=
 =?us-ascii?Q?zMqOq8KMy6h9l+uM9gC6fl/VPec2PlHHQUJdIs3ICNuIVBP/85CnKztrlHAK?=
 =?us-ascii?Q?CMpP3zGTbOPKVnkrDqUu5jUckv6YAgO9LRlJlvXVAS7vEb6DFgaUUd1hnU0q?=
 =?us-ascii?Q?qN+BSjXvFD1Zwon8doZ5uiBGV1MLfkFC2zct9PFhwYcM2CuudTN8scmUuXow?=
 =?us-ascii?Q?Tvx5vGUYL+odfxVEIrOfTCQy50Ub20gEvuYd2HKkAVr8KQMApJa8vQBdT3cR?=
 =?us-ascii?Q?YXxreupEeMDcrJP+MLQh8wuonnZr7lg5X7VAOrbPm6cZCOtb7jO18a0/wgUZ?=
 =?us-ascii?Q?YdAnCsD5f9MVgiS4IEszZ1w/KdHp+4ILfhvQyX2XFqNAP+G42ZIJsWvOsUy0?=
 =?us-ascii?Q?Z5sDZEQkVZkzMwLjTYKQo5UWJCozGhxrjuwmm5Wc2DVFD9/n9j3fK1AC/hT8?=
 =?us-ascii?Q?VysiXWw9qq6G8daykz9viLKKffisusR6iMg2KUUgf5mUWYJP5/PyK3akPgjn?=
 =?us-ascii?Q?JvCjJ9XajxePSXVrGdd9EPzY3N3MQRwMVC7pvKd4tGBKQT1ouJ6TnVmWamgJ?=
 =?us-ascii?Q?A9ECeUw3zfATTb62B7sDRuzYiQRoiFVBdc32n521AaSktHI894Uk3KrthF5J?=
 =?us-ascii?Q?Xsly+zt1NcqXWSGm2yifj1NaTD4D5CHGnuZAJsTC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3deb2f2e-59d8-4079-dc9d-08ddc483b0b6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:13:24.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fE55eTWvfgEA28BxWskLNRyjAzNTMme45tptraQnTXygxQmy/St45pworZzfbKCMKpuoO79zhHig6BvMCEEow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586

On Wed, Jul 16, 2025 at 09:08:36AM -0700, Breno Leitao wrote:
> On Wed, Jul 16, 2025 at 04:26:23PM +0200, Andrea Righi wrote:
> > On Wed, Jul 16, 2025 at 03:36:31PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jul 16, 2025 at 03:15:12PM +0200, Andrea Righi wrote:
> > > 
> > > > The idea is to track the scx callbacks that are invoked with a rq lock held
> > > > and, in those cases, store the locked rq. However, some callbacks may also
> > > > be invoked from an unlocked context, where no rq is locked and in this case
> > > > rq should be NULL.
> > > > 
> > > > In the latter case, it's acceptable for preemption to remain enabled, but
> > > > we still want to explicitly set locked_rq = NULL. If during the execution
> > > > of the callback we jump on another CPU, it'd still be in an unlocked state,
> > > > so it's locked_rq is still NULL.
> > > 
> > > Right; but doing superfluous NULL stores seems pointless. So better to
> > > avoid the store entirely, rather than making it more expensive and no
> > > less pointless, right?
> > 
> > Right, we can definitely avoid rewriting NULL.
> > The following should do the trick.
> > 
> > Breno, can you give it a try?
> 
> Sure thing. I've tested it and I don't see the warning on my side.
> 
> Would you like to me post the patch, probably removing the WARN_ONCE()
> as raised by peterz?

Sure, go ahead. Yes, let's remove the WARN_ON_ONCE().
And thanks Peter for all the suggestions!

-Andrea
