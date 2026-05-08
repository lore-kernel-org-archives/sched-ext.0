Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645372F9D85
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255270; cv=fail; b=YKF8YfDTcD5i1XQL84DsZKAsX84YQBRMqs3zpz0OD0/gHtdwKRhRGb0PlPkwQO8YAvIOMVqwkluuahffiYadsUACXmdwD0ce/s3Mt2y0p94CKKTn7oNhxrVC5hlvlhm60yIssc2atjAv7KRkPG7q2hnQzvUWRuB874+rcXW52fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255270; c=relaxed/simple;
	bh=E8/0yJmDcShX2S4TFK+7LFJLeQDsIAEW5MpSHr1V42k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kfvhTQfVMJzzOItfGus4k8TS/jZ3lZ5/aV8aEx0GPd/mvVpFU8Ie1RC6j3jXC6V22CDnwdCy7K1dhYj9qlNi3Vx+HVODfhNu2n3CVBVYtRSbl7pc+fanAlYm7h4erhXD5XOhjGrQjbASfQPuF+bXfDXGbShJujfqFHCrHmBX8GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MC+uZ9CX; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MC+uZ9CX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2GGEZ7RsPRGL0JcsTsf2dNws/tAbKda0p2ATKiXjBy4PtChN/sALL/cwPqcagvumzCVL7FLsYBeKLrHuCTG5PP7ywec/Qd7wOTaVnc3jTdivVbOd3Kr3cwbVb6yMtGUePXeqVSlszDxhtaY2TrG4Wqo56+ZDuWx8cbYXpwEAm82QS61DQ0lYsnbJ/WyoR8CB9PvsXmWmMiCrOA4oFS5hk5mNORtQZO38U/aaQAvCpnPskKlGqleKGtqlexOtbjiYzWLwUKtOYYqRgZ7PEKQbi5rDQRpJjvC7MK9BR2/YHAnLKxyRZ65lk+AXSOjaHqahYmtsCEHUmOSAIV9/zoDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnxQNcuyAPdW3/gVhG+2C6/NXzK7aypnokEM44LS98U=;
 b=BqgeEqHIBdTI0BOoT5I9lTktjHzP7sFaKfAXiEuMlBcDWGxM2BnmtUacLe21FlisKQF6Z43Co1JXVkSSqYiDDJ4GGdEAZxzymSPx5jayyFW9OeqSUllehb/gAZVCmxoUcXHzI5lM4oEyqtjUa7Xre+lxyafLBgTy0LcG+1rpVuoKqKRflZp/8Bhd2QFPtx6W0ZNipfNCuuGAZP4OBFupNSVqWwDgdXOW2TPnricPxViQjfoGQDsMe3yU8ZCcLvi3KJvF0tn23d+1bs3mmMkkEJ8hKZKsOJ8nYh/9zsmYlhvrZoPckEM+fj9lyMWKe8RxbjQi07DyBs+wIj5oXvyinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnxQNcuyAPdW3/gVhG+2C6/NXzK7aypnokEM44LS98U=;
 b=MC+uZ9CXKW6oPt/71okqcnZOBOhDVkeq65MUs55vNrb1sK3iusSCkBgzFOOTZAdOJ4ss6m30brzQqedh5qcWYGZzrHFhfNMy84LmKXsToUpUuKl2Ip8126+JxRQxS7gk+rU3hyesGBbugWLiiEerK+SC0JJ7mtFv563KZIKB6pLOoq7qH3g+DiymNkpugSjbGBoWfLrWOW1zQfDas3PWgB3Y4lAHL2BHOwT/Y/hcJzGixVhy6PMq1fAM7Ivk+fw2HfWDjelID+43XGtiKRtLvceQxqrcoEN8uYL1sr64FxiTQBRVCgFf1G09RCZnldVU6L2BJXXN1pjz4EuPcWvoLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS1PR12MB999187.namprd12.prod.outlook.com (2603:10b6:8:495::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 15:47:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 15:47:45 +0000
Date: Fri, 8 May 2026 17:47:36 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, void@manifault.com,
	changwoo@igalia.com
Subject: Re: [RFC][PATCH] sched_ext: Allow consuming local tasks when aborting
Message-ID: <af4FmAr5sVfkWcHI@gpd4>
References: <20260507135642.692290-1-christian.loehle@arm.com>
 <af4BHTzRaDx8aZPh@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4BHTzRaDx8aZPh@slm.duckdns.org>
X-ClientProxiedBy: MI1PEPF000008C7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::429) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS1PR12MB999187:EE_
X-MS-Office365-Filtering-Correlation-Id: a9174cb6-fef2-4fc9-c2fe-08dead192591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AJn8YRmnx0PNOatsvRvGoenk1jpThXwLogJxE2wmKoaD1dR9e6Rn4xLUOKtGp9cM68zxZpuoIZ/hvFt/nTaRbVaUrg5fLfybd6g/pMQsSilZSrd5zDKN6xd3pIDPlaaJt0mTbtty06PGUQroOCXmE/pFABeguvFOJ7bxNZ1Q2ZxRz5L98AALCLfG9oPGH/04N2WeFTJpttRURZHViVyPqxGCxt7W7VkuJh5mWZ8HeJLMjHzNIGYc6Jh6k0IZ64LszqyNNHPg6vggwilxvu+RDU19P4C9/Uo2SSJCt3D7QhW63z4Dkv2fdO8DYIFl+MdFMmR8KcHAZ/jYRAVsToXFPBc+W+V9mB6RLvooMJP3nQkcMSWOLaUy4zaUcJ8NekfX3w+DzQyJDt7C5gv/GBiwooTcSD+4uR0RE3aRlLu7oTEQ+IDoRtTTgLox3/hTT629Y3FCJt1VgdMJUHPbPsPs6tPsWTBDiXdZp3ntjMZnYzs8NZXW8qzhlk5wYqWOsYcFwEYTSa7X0eIzQBdzoi3wwxz4fqTXnms5DlQdk3YA5tGKd0QOPrUavgYS84MuPkEPiYoxGKVlkJwwiyQyFhZK97loX7tkGJEoCGhnWSQJx22bKTW4ojw6gLDNzdzGH0t39ARSXHmKThx0NKY4jcZVrrugijxiEjMqaEw4uiIQ6Y/zwYsDCxBzusnR9yr4ArvJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RV6jwMpkg5Q2G6hEMd7ws+3oTaDwCz8a9lcE3fcfnk/7/++Mi3ZuYCFQ2mIq?=
 =?us-ascii?Q?7TQBpoAdfMBsHcID9zDnCPNFQh7ubGz+pwt5MENbGxg11biB9T+HGPVi+2H7?=
 =?us-ascii?Q?9QJJaALu4d7jb1e7oqQ1pmoPNNBaoWavDhiE/KutgTlWLwF74qkcDitWztKD?=
 =?us-ascii?Q?ri5HCAHJ3ZfZ4zljyEZBGvLit7WWV67NMtzuPS64dCPgOpzYCulJK0keCFyM?=
 =?us-ascii?Q?QiP8skL2oRq4IpGF0snGMTjVxQSOME9RK3O7EDIi4rciY/Tkblgz0IMtw4+n?=
 =?us-ascii?Q?p3No+8LHdYCHkRdxzJZKIJQmF6XRfaYNGtfMvAZ5+SCpoO1FeAAeUZzw/WeX?=
 =?us-ascii?Q?CUeIVvU199UqxcUlLGTK3jYwLKvM3i3ONM71xC78sBqsbmVTZjVCkjBa4/sG?=
 =?us-ascii?Q?Vn4ZAW0bGfToIkeTrKGIhm8JO0EVst9OmYCfyS8G6cZrS9MnTeJaTdTwBwRT?=
 =?us-ascii?Q?Ad7No6A8tTnxgUmJnrCFAYB7wi+PXo3YXKT6zfte4NAsq6UVq62v4NLI6Xps?=
 =?us-ascii?Q?y1MjmLOfIgeavtnLESt0pv80iP2kfRgYCF9eeuBpySZTiQ0DqP8VUudFvebB?=
 =?us-ascii?Q?KzL040EnVdYUofiZ11RXII8hd8HhuNogILZHDE9zjl+rU58+h3H9HSbz7Ixg?=
 =?us-ascii?Q?lHxpMZd9NTid1g9pQTJjWL507vV9neI6BIoit4DR3hH0MyWjoiVvPX5jlckw?=
 =?us-ascii?Q?P7YtOQw2wRycXvfYu13MQzmYWvAEgeGVB3IpBYegBoFzIx61e/SX0P/lmtf3?=
 =?us-ascii?Q?qXTDHjQCIBs2Eaxypy710cAMEAgir80alQ/X4MtZVrx6X+n+SyrsaB4Dyc21?=
 =?us-ascii?Q?NoLOBDpKBe6FMLIXSe5T4ngmIwtw5RzFifd0kDJ41DC3BVppcQ47b4BMedUV?=
 =?us-ascii?Q?th2wpRUtk5bXMDDGAdW5j+ehlazieHIol/5JR4SVwwFTKg0zFN5Vw0d8zQUG?=
 =?us-ascii?Q?25pZqONU2UVXtctmXHEwCBIuyvqpEkel9f5nPgecaRStZeSvjYn/A0NyE3Qw?=
 =?us-ascii?Q?S4Uxrxz7ln4zxSgf+lPYBiG9z43TF1QsyDSkBp2FmG6z6ObE//bU4XyX9/1s?=
 =?us-ascii?Q?J+nBm5U9RibI60IYY4MpD3yev3RGGtWmUQ/pUHWabuYzoQrDrhb4OsTZvnPU?=
 =?us-ascii?Q?+ph/v1bzRyVj7iGG+otC0hDK/ycE9zpwN4aj80kdAfZHFgwzRLx5iHr9ByJb?=
 =?us-ascii?Q?gjkWtMPiSpda1uf59MuIIJ7YAipwr4usW5r5UXc5G4b2EMzPFG2E+VHmgSoS?=
 =?us-ascii?Q?44lukCIs9Wazjsb7eNFObNNQO828CRW0LkeGlZTjk2qgKVoNoNR6WNbfMHVm?=
 =?us-ascii?Q?er4fn3HpVprFaO7wpCDs1gbOvPmmQ6qyMuoez9mErCPCgg4piDWZ+qXlWOm3?=
 =?us-ascii?Q?NWy7hVW/6ATgkcs9XjDp1HnJ+NzcjCUMQnLWRJfGzxGsCacW4+UygGGKaJCB?=
 =?us-ascii?Q?GDik5HKhz9vcicGitEtN+TviX5LW3lnB7e5TpSpe8TGvV4cVU5bsPHlw8U+O?=
 =?us-ascii?Q?3bOsgQ2K+LwF/09bIc6jepegxN288mbPSyYF0DpKs29A9DBly6dCWPdmMPiO?=
 =?us-ascii?Q?HP8iQAHtt37Mfmfffl0RDXaxmlVtqNXf1YmlvW6A8z+RQQ5FLiqFX4+MK/RG?=
 =?us-ascii?Q?OU9hcuEjzHS57Qj8xaCEW5D6CaX+s35504u7Wprm+ugs1MHwP6YWHQJw+7P/?=
 =?us-ascii?Q?eztMdPrTZsHWRPSN+Ra+u0zkrL8HyIWnCan9bAgxnT81WCMxFPw7WAUxY3Mf?=
 =?us-ascii?Q?Yr+MOZMjJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9174cb6-fef2-4fc9-c2fe-08dead192591
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 15:47:45.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9vehM7JcuYmlFk0Sv1PKreVR1gyP7yKHkr8EFq5ju01SjN14HVL+f75sAxFLKU8DkZ2ciGrH46HmZik07W2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999187

Hi Tejun,

On Fri, May 08, 2026 at 05:28:29AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, May 07, 2026 at 02:56:42PM +0100, Christian Loehle wrote:
> > 1. The BPF scheduler's cpu_offline callback calls scx_bpf_exit(),
> >    setting sch->aborting and queuing the disable_work on the helper
> >    kthread.
> > 
> > 2. The helper kthread (and other tasks) are stuck on the global or
> >    user DSQs because bypass mode hasn't been entered yet.
> 
> The helper thread runs RT class, so it doesn't go through SCX at all. Can
> you try Andrea's patch?
> 
> > RFC:
> > I guess this reintroduces the live-lock of a BPF scheduler having a
> > highly contended DSQ with a lot of tasks and the outer loop holding
> > dsq->lock and therefore it still taking too long for the bypass to
> > activate, is there a better way?
> > I also couldn't trigger a lockup through that, did I just not have
> > the right platform (e.g. 2x Intel 8480c). Should we add a selftest
> > for this too, then?
> 
> Dual Sapphire Rapids is where the problem was initially observed and I could
> also reproduce on dual socket Zen 2 too. SPRs are way more susceptible tho.
> I *think* I was running scx_simple with some mixture of saturating
> stress-ng. It wasn't that difficult to reproduce. We should probably
> document the repro somewhere. I'm not sure selftests is a good place to host
> this sort of repros.

There are few selftests that use stress-ng in tools/testing/selftests, maybe we
can put a script there calling stress-ng, if present, and a sched similar to
scx_simple and if stress-ng isn't present, skip the test. Do you remember the
stress-ng command you were using? Probably we can even reproduce the issue
adding something to the C part of the scheduler that mimics what stress-ng is
doing.

Thanks,
-Andrea
