Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BB31E85F
	for <sched-ext@lists.linux.dev>; Sun, 29 Mar 2026 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774799541; cv=fail; b=HpoPjiBkuihobnxcPpraZFKeDtqFz90BSBmfRbxmnUar7y9CjznFaVo/6LDVkZr8VXY/TEXDfmmE+NLOT61QuVWzWa8L14Afi0xGevv4BOE/rF9lzFOE3dPO5yWFo/sZ8vbzFjc1CdlHe8EdlP/npCk9WOsWXbTvJmw8ZTLjDGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774799541; c=relaxed/simple;
	bh=dCQylEwgvGD4Tr35vFAEPJGYncWHi1AeH+JSlJF2B2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g6EZJHM3oTOMhMrRhWnkMv8Rnyj095Rgo+qYU7RWzfjkScxi+3+/9PtB5hqEJ21/ibC/jwzQIbK8SEZsa/0R9Fdj3B3/+/dJIvxS6UhbY3kBuBFxZQxkjuJ+IkYPegmS/ZfzFKyU+Z0gwWXpk5OJsTVzbD+90kAQq8PXHpNH4lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SLzl1L5g; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SLzl1L5g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD4fuOZwBcg+ydZacw+lWnhEUvxn/f/IAMutP0Eq+u8N+zltgs5bNuyLiASdlyYpgpY26FnSqbutgqPp1JmeIZ+EqyunfquaFqVbf1FI90J2Gr2rjE/FHtmv7j6cMgF8OZBGmI0oi/4X8yxev7u+OOdZ2Gdu6J6rRUignSfC+35E5EEqVGTeSvv+UPs54Yk0vO2EUfjSjiZ8/hDnlN87Yk+X43Vq0bVXtVWPz2jBo2T8aer9Ziz60P9kMGTiESn4PobgouwoPiU+NKJSqDZFQWwz87iAe0n9/ifYNF9pIU7u5za9XmEb2UByo501E4RnX9evJSGwWWjnRYUvqde2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8FawjffSlsDWOpODe+HVxOG+cSMQitrlb7KxEQRL/4=;
 b=SIdUaUy2g55Yqo1vSxSfN8SZJ2gDifWJqayzMf4m1bWeQx5I6MiGNZcrpZz0VzojfV7qKhTT+aczCR6QVvBPJ/OAE/DMkkT8kXXV2i0SJo4GDsWOuS+oJZuMhL1dEIJcpwPcIjlppasZStky3ejGwaKCRl09mBm1wzCiNfANKA8J6oQHHGChQKt/9yb/NPL7CglJL4ELvDyegDKley8QkGtUuwSfT2eLddFXPnwLtmwN6H4yKgtJcykQH279kuq4mlKWnifzlv6o7fJfclcF2k3flTcxGDrjBP0zeVSOvH65XYlm6anAHasbBmCfFkCGaLRf9UMTgjbvDkGc7QPlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8FawjffSlsDWOpODe+HVxOG+cSMQitrlb7KxEQRL/4=;
 b=SLzl1L5gcajpfH0nTF+HNmCKbL0r/JrNvPcjlKXcbXCVYycEg+gVJ7cU+INba7OTdx7Wj+V3PKL9yeYcEN+EevsgHypkfog3TsTlMIdiUp+U8QdSqbFmDEY3y2OXp+WBqAP8p6fs8UHXbBSEgsi4M6sjqs39q+G1Jo4nhyNH0mwl4fIeYw8dSQeaAhrr01nVMq4Xae8qEuxtye76IxLI0WX9vN75BUE/byJBTi7T6+rflDX+a9qXEBOMJJS9ArOxAd4lfF0WC8ZG1jlMzA3xEs68F/kxLXeS0dJNV0gbTFPHNFJG/nx9ztZlgnJ+5IrWjIQNIai77I/N0oUXXhMaGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Sun, 29 Mar
 2026 15:52:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Sun, 29 Mar 2026
 15:52:16 +0000
Date: Sun, 29 Mar 2026 17:52:12 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress
 test
Message-ID: <aclKrNMA4CG7K5K9@gpd4>
References: <20260329001856.835643-1-tj@kernel.org>
 <20260329001856.835643-3-tj@kernel.org>
 <r36q4trzw267surx5xbod3ilm4wgmmyurqk6kres6gmtj7qbfl@lyasdc3a2zlk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r36q4trzw267surx5xbod3ilm4wgmmyurqk6kres6gmtj7qbfl@lyasdc3a2zlk>
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d62d6e-c9dc-4dcb-90fd-08de8dab26b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u9Tx02SDzdVYqVmhsvaOuiEZ7VMpVOTy0u5UeZdmuQC5ajpB2IITW5ShPosr00OS3U3Eg76h8T93ZpOwFr3yBgBj/nR934k342MIuC0Cc52w6Viu/0TzMx2wG9jG3BQ/p2HH6MAMoy1nXqMnXQkx18qv66oVtWxGhujORs7HMwyxt8lzCjopqkMq4b7Iv7YQIJt+85w3vl/npvEJL5oIsgKOf04gwGaopMmTXraldRFiJqB7cUX8Ss/F97NoQAnVZ9KHInsl+9AjO3FYKrKEQUXX9joLYEOuFjOyFYCAVOC/vzl9VzU+qzE6TEbHr8LPncQaJY8Bl53V4lpMnZcRKccm8zFzEdC4bZxElfzGyG89u4JZbq2ycWSHkrHcmNoTRKL5A+Cc2epRqocpOfvLRaU6JPODJlQLlqwahww+4ncnkNkved1iUfFVx3a/1DgAdQ2Y5zFlzcpJI4QIwDhmOaJzjH45K5OfnK+yGq+U2P2iST6g+PRhzFGDzyvvwOm1OiBKwydVohqnBwRF+Su0FWBROWe57SVXa7g1wVxJSxDyIeI+iaGfNayE7f1ygowJkvXs2edB7LZE+3phb0R9Fxd3WGtxVQ+PPXZjeOgtRqiFW+j4ohTRb4jiagawh1pmBAzz5MO952CHG+RM/UHqwjFC1ReO6mQqTuJQBi7w1izsDXR89AAewFA8uQ62YVLriHO9Pz//cvNakK9q2snjerW5/QMhSQ+iuLQvFBxosa4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2nZyA9IrcrqBcpgFJFgE78JukiEVE4nZwjGJdynx+sRgoF97zulPj+3thPk?=
 =?us-ascii?Q?VIabw6m9cSNOjKNF0lCl+vlxZv+82Ahc9YpFy9Z5D77xu98zltojxr/DP7rD?=
 =?us-ascii?Q?Eo/YLVDmBW7OCyN8DmyNaDiPr4oJzsQnlXYI+H0pjWvCJYR9ES3cLBzpy0Kh?=
 =?us-ascii?Q?EIQO+RDouulRoVvh9IsQWpbZ4pptIASq29MmChvojgeUkbUapITwNHYMPI/n?=
 =?us-ascii?Q?G/C1Ll0f3TAXAVvQ9Isxu4l5f3dSJfkJD2DAXHgNmEfay5V6iu9/F+gbMhNQ?=
 =?us-ascii?Q?MoVHvL8GA0CzLikQWdW4yYjyuQisFP5B6G9sUYI01fjPgnv6mArEvX3AM9uC?=
 =?us-ascii?Q?B85Md01WeSAOnKCXfIkgicsHQBr7Z6ELXU9VbijXLAuYSe7Tep1cs3HJGq7m?=
 =?us-ascii?Q?B6XaXEgvD1SulDAapJX2ReoKvjmCv6EIqy+U+RcgF7O07APXXHQGQScEQrZ3?=
 =?us-ascii?Q?BxI8vni7hf4oiaC4MdNajH0NkqnD+Q/RsownmPr8u9GEKjzhVDScH22w3mBU?=
 =?us-ascii?Q?lrKthC1a8MXd8mhX1mwgEKe4Ezs2s0D1Tgkbcpj6PtupZHFL3vbetiauL6Fh?=
 =?us-ascii?Q?e+NPrJK2/FwOg1xjO2guwWC1FpO/Tn/qhl13YfsjkBskX3hgTdBuQ8aL8eDv?=
 =?us-ascii?Q?NTm7s/Rgp+qkOl3XiKvdHdb4tfN7mcgcKFsgt/1BiCttNVmQdxtJbfYlDq5Q?=
 =?us-ascii?Q?bvdO9g7QbWwnrL15vhyF0fv8o6gRgG46nQepT62m8cQanpQtlvdZ3FH7p40l?=
 =?us-ascii?Q?6hkAGGoSi33dNdx6S0dMCySTOuyQ50zIEJ/3jkwDbx+/po/l9cux70CnPIeD?=
 =?us-ascii?Q?JLr2n2T9xi26gyoy+mVFYGDoX3qXHwf9/sebEIEvP+TGtvGCll/xwelDXakk?=
 =?us-ascii?Q?hSsmCr+PLls8Gyb79nVsBQbp+/5UkHhZoask6CoTCrPXFYPRCnYMyTvoCHgV?=
 =?us-ascii?Q?OCX9U2/036seQjuuLhre3n+Qdfa4dG3UXgl9n7wAvcM7Ykjj5u3jGllVbq1T?=
 =?us-ascii?Q?evYHcBaXp4KJbxKdFHtI6XGPpr0A4UJKLmFyTC2H0LjoURMRP3w+7hLEUYPS?=
 =?us-ascii?Q?KGRtJt6oFos2al2oQR+rRWlHphVsK8RjYv8BHAIVG7xJv2Sm7yPssjZKPrjP?=
 =?us-ascii?Q?vN4ZnA0J1ye8RlJAhKAs7vYbiTTigs3ZSY0YsmPSTyv+rFe73Rwu2SJ/YjRU?=
 =?us-ascii?Q?lZS7G4H048kXkREqe+z44JTX4YB17HSje4iz882hjyik3G/Qs5yzRiSPWw5Q?=
 =?us-ascii?Q?CmqOfZw84PvLyJoSwAQvicRYjAo/n0jSpB+3KgL9Gh18RUKLawP4kih24BCX?=
 =?us-ascii?Q?U61znf9HqC267tWo1C7gMh7cdIGljZYiKT/Kzqj4NOHVTsyzFWqcqGuOHpDr?=
 =?us-ascii?Q?LcRoeYodkMeBRFoeGfBDNsTgE4r0LuXNL8bwGaXINVBc7P2e7dtEc15/R7tU?=
 =?us-ascii?Q?0Ye+qSWC9C8izjJji9M2XeNjXRtYqyLn7N9QfR1VCfQdYtKVQFuyKq1919eW?=
 =?us-ascii?Q?6DKcxlKdhpVWXFuO5kyX4ogeqEExuHgJd5HqhufOIcoXGY3xeRwhvb5SmsHU?=
 =?us-ascii?Q?eSGJ8aqVZunxlEQUF1yxrRWuGnCUe0gvUdVMZAr1Jh1YcTS63ZZNlauKzG6a?=
 =?us-ascii?Q?r3SRt/lI9MASyrireMcw15iJzso4zI7IABZmjcqOJZCXgMZ3IOhP/f3RbixA?=
 =?us-ascii?Q?c11KhHQRhxQ20XW8ffOKOsdBH2rGb3+lpd705ZsosNniAaxiMLhWgr7LAHFf?=
 =?us-ascii?Q?9WRwxO0Wag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d62d6e-c9dc-4dcb-90fd-08de8dab26b0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 15:52:16.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cILb4vGCB8YmDLAh1Yr91HCZevaosS5JIPiwIr8M8cbc531Gd1Cjp8+eE/jANNNQuNte0ml5+vkzBcCZbzPChQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

Hi Cheng-Yang,

On Sun, Mar 29, 2026 at 05:06:20PM +0800, Cheng-Yang Chou wrote:
> Hi Tejun,
> 
> On Sat, Mar 28, 2026 at 02:18:56PM -1000, Tejun Heo wrote:
> > Add a test that creates a 3-CPU kick_wait cycle (A->B->C->A). A BPF
> > scheduler kicks the next CPU in the ring with SCX_KICK_WAIT on every
> > enqueue while userspace workers generate continuous scheduling churn via
> > sched_yield(). Without the preceding fix, this hangs the machine within seconds.
> 
> I think it would be better to skip this test on older, unpatched kernels.
> Sometimes I use my local kernel for testing before the stable patches are
> fully integrated, so skipping the test would be a safer approach.
> 
> Otherwise, this test can stall the machine and make it impossible to
> exit the test runner.

Actually, I disagree. The whole point of the kselftests is to expose kernel
issues, including bugs in older kernels that may need fixes. So, I think we
shouldn't skip the test.

-Andrea

> 
> Log:
> 
> $ sudo ./runner -t cyclic_kick_wait # on v6.14
> ===== START =====
> TEST: cyclic_kick_wait
> DESCRIPTION: Verify SCX_KICK_WAIT forward progress under a 3-CPU wait cycle
> OUTPUT:
> libbpf: struct_ops cyclic_kick_wait_ops: member cgroup_set_bandwidth not found in kernel, skipping it as it's set to zero
> libbpf: struct_ops cyclic_kick_wait_ops: member cgroup_set_idle not found in kernel, skipping it as it's set to zero
> libbpf: struct_ops cyclic_kick_wait_ops: member priv not found in kernel, skipping it as it's set to zero
> ERR: cyclic_kick_wait.c:169
> Failed to join worker thread 0 (-110)
> 
> Thanks,
> Cheng-Yang
> 

> From 6f09d2298e547aa7a519d4bff262fc6851a969ea Mon Sep 17 00:00:00 2001
> From: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Date: Sun, 29 Mar 2026 16:07:05 +0800
> Subject: [PATCH] selftests/sched_ext: Skip cyclic_kick_wait on kernels without
>  deadlock fix
> 
> The cyclic_kick_wait test triggers a deadlock on kernels lacking the
> SCX_KICK_WAIT fix, causing the machine to hang or worker threads to
> timeout (-110).
> 
> Use __COMPAT_struct_has_field() to probe vmlinux BTF for
> rq_scx.kick_sync_pending, a field introduced by the SCX_KICK_WAIT
> deadlock fix. Skip the test on older kernels that lack the fix rather
> than hanging the machine.
> 
> Example failure on unpatched kernels:
>   ERR: cyclic_kick_wait.c:169
>   Failed to join worker thread 0 (-110)
> 
> Fixes: e9b990b76922 ("selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress test")
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  tools/testing/selftests/sched_ext/cyclic_kick_wait.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/sched_ext/cyclic_kick_wait.c b/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
> index c2e5aa9de715..b060ffe63ba3 100644
> --- a/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
> +++ b/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
> @@ -88,6 +88,11 @@ static enum scx_test_status setup(void **ctx)
>  {
>  	struct cyclic_kick_wait *skel;
>  
> +	if (!__COMPAT_struct_has_field("rq_scx", "kick_sync_pending")) {
> +		fprintf(stderr, "Skipping test: kernel lacks SCX_KICK_WAIT deadlock fix\n");
> +		return SCX_TEST_SKIP;
> +	}
> +
>  	skel = cyclic_kick_wait__open();
>  	SCX_FAIL_IF(!skel, "Failed to open skel");
>  	SCX_ENUM_INIT(skel);
> -- 
> 2.43.0
> 

