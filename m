Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4CF3C457A
	for <sched-ext@lists.linux.dev>; Mon, 27 Jul 2026 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187057; cv=fail; b=NU5aKypmuuWOCRAkAD6Tz3n8UaDVP+W3cDqA5qUNWO3omfVBlG4hj6XvtGr6PCQ9YxEnggw6BzKHbk1NjsEFicJVcuF7u++jP87fE63dD4zcPgeVhFBZaed0NxIQBAb3hjaN84W139gxvyYB8AV0toJYypxgwHcoVaJRadwfutw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187057; c=relaxed/simple;
	bh=/gUQ8JEZSvKdq6RfVz0gu0DaBrX3KbTqGurJnvw3Xqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hg8xl3aRyEQhOxyetQ1ZSVuVV/3fomWUFbiC3j9GSN7N3kkRC1u/HliynR6lOiIKXqq7WvTfRi5F4UQOnJLw8HEZvgHRLxg7jI4cgz1n0gHfRvq+CU+2WyfynPM7Ga0hZL5KJts5acI0s5lPX0efbdsUSupDmbbJ6NIUnSZ8IwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LEiqQ1+i; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LEiqQ1+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCtd3zf6+cjliih41hGqUP7nWBoGK/caG4Zwf02X5eB3uZAJQ/zYoQLl1WoaOjrTsXzplpoYJ50I/V0BqRei6q9wQTIV/OynnojFDzPVaouPgW+A8L8ovP86pFSmGGwrE+kIm9klUuQezvpgDpsIOw4eXn3Hm0PWiSSD5TG4VwTwz2s5+w4kFwk+0b122hl14Tf9lDcHnyEVi1lf1leDq8oxkp56y284w8z3nbhEzpkV2G3MJBcDL6tDaPEM+glhxF6mZtdAthPSvvvdLp5CTecaKNQHvIOkRMFMOGrwATcPQ6xPRcDbelc1oYtyml3QMaz2cMkLy9Q4L5rnb5dGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz6dWIdW3MF7LJw4HGRdjeVmj1ekyvONEmYdb8HjbHY=;
 b=r4XwJFmPn9v8THTz8D6s5qF+GQk+rlhs0KSXrO+5hQn+vi0Nnv74ts2Yu9JKTjnGyoy1UQdApDTC3xaFbZlmMmx5h893j1a8KJDbyUTIxuXPApVbErfaDJTluBbsH9KgsvqvFceBOTdRaz5+XRaSI2vV6pTvt+ds5vvJigtXr0Bv60Op6cYpuD49tJcN018dnu35/Vz3SrDhaT3QFbmZTvupK6IkpfBvtOgaAfV9bq7b4XWlnOBy9EmdDvaLHMzowH919h8/+msmyu0ZBq8l6K0b9+GmwZYXjENfY473jBe2b/o1cmwNMYBXa0nUa7YsbSG71p7sSWjfAJcpgZAshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz6dWIdW3MF7LJw4HGRdjeVmj1ekyvONEmYdb8HjbHY=;
 b=LEiqQ1+i9wNdvTaIFuhYW8Nbfqo+K9E9lDra1MTJE3F4nUtf77df0boVshKKmk33tAyEwhnyhGkIW/lDgxJ0ABArPAxx9S4xesixfMyplNJxPAp9+kvSCIuQVKq2G+PuGvKhVy0SRxKqIsON4zvzOXSU9Z1ly5sqcCT2co5ip8bhiolxobyHZNASJ+MKZEqezeJtfGiskmruReD5MYNlw6AKNsQEVL7l4qsdTltL0Fj3vAYZ0Fh+lV9uIwotfYkJHBno5dERi6vF0whdYHhqQ1bPeSiGCay7oOzrOUfRnCCAa3w9t5zd5ewUnvEhMnV9fEIB5nCKy6/FakQ+xD4eCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:17:31 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 21:17:31 +0000
Date: Mon, 27 Jul 2026 23:17:21 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: NMI-safe exit handling
Message-ID: <amfK4YdxcJqRp0jn@gpd4>
References: <20260725005019.1297049-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725005019.1297049-1-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA0.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44f) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d6d62c-9218-4e0d-6bbb-08deec24781e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	35YqVs3Jby4AA+KXxFVJ2/QVZB1ElHE/ksAh1UJcb8d6qOXGnahLfj0OxQIihfbdG7SSC4HOtXOrp0E3NEetd/mkf1j31LIRWVcbzqAJzuSdnPTP5sYXwmMt1tF04O2UPneZcUanYDpCbQUR/PK8fvKvJzPKle50At5gpam2S96UyWNAxSTgwgfOabffHtgYUvECS8W8CzrFXioR/3ujTqIJAxEd2cW163wlrAMYT+Y9lGIBt6r7z216UBPCnWHbL/Xcdpde3t0018gQos1n1HiOsfl9t38+jHWbhjS6mm6C71ufhKaKVo3Hl1Jjy0Y+2kfCLA0iYGWhD6p2+4vQ880keBV9pQy/9rbw8B26RVk9QBVTSAdL4Y6kN9oMzOhd1bH7L2m7IoUbaPZPr8r/wvmjQudtKLAaAmHBiw7Lxi6SPC7QZEXStKR5mHtiXxIgXp09GnZRS6ZSYm8fuMl2dwIw+Xvy9Vjf1u937wW8sLeFO1MwXC8q8zkvwmt7mgLiamSfZuvV3gzMSPxLz/zDujBXoAqwhcQ0L55ho4DNnbAzOwpzwsJTjS5nGOVgm7ZLdGK5u5JXBBDPRfOgqsGtWGmZS1XsFvvxnUubuto/iO7uIVcJvG8FCP4Ljcdix/BY8UPojEIb56wY1EvcIueS55i/0FGq4QbzGOjYDAVRIZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8NdDavbw868+0yLYJDI92Ig8fKC9yVxk3+K/dWHdLGzqzQbzrMhHjOoCLVyL?=
 =?us-ascii?Q?bzQXb1QPvRG3pF6r9YSKTHLdZ1MHRSkvPT/IEKJeIY/ufrqVW2Us/sFtWFCa?=
 =?us-ascii?Q?S7/Il3/Lea7qjS3Z+MxbrK1vCC/nY9ak5u9e8XGS7vVhznPUKaoWH+kZs+Oc?=
 =?us-ascii?Q?SY/zBBhAnPI1rLT01GyafosNDn6YeeN/fpfxpBkL99fV1sg0hjimW/19ynq4?=
 =?us-ascii?Q?5t1s+Hs1smP6TTMAlLujlArUxHo9h/IWw0thXX6P/M1S9yLfuhRr4u3gScPa?=
 =?us-ascii?Q?J0rhxchFOA0YVyirXJLjGcS4eh2QZO5Xx38Jgh8EOdsrhbfArzAjBTqg0Fxx?=
 =?us-ascii?Q?K3x1ugPfxnBm2sBXumFTVv6RFPMNiRft2+qxf9pGnf562VVhS673sNocU9E5?=
 =?us-ascii?Q?sWgEjPkdyOPHrrt8ZL6pYrBzzIZJTreCC8/3GNetODE/f1fY5DCFIUAEiIQ5?=
 =?us-ascii?Q?x/z8PZbSsr1Q/zfUMMjOdis9p9rl1R4IYh3WHQ3ERvKhdR/MBRUFedhahovO?=
 =?us-ascii?Q?IqZgnMBMDqSNVxO/cRD5NR9cHI13dvCNd5Of1BIMyySDGQNC2aiD4nHwbcBJ?=
 =?us-ascii?Q?4AZTsazx3Xo5QRcTWipPKW4/BojnB960+HpRiZ83XmRyHcRuvfqrzwO11J5J?=
 =?us-ascii?Q?73uWfIFY3T57eMw1Y9L2vQecaGOV6a3J9rgV/TvzTLXV5kSdoFfl902H9CSR?=
 =?us-ascii?Q?aARgErbYqSDnFxi6K4C/VnhDHjC0jGrAtXpJ2rLLo/KhH4HaB90xOHJxwYxh?=
 =?us-ascii?Q?yK/l2BrvESmDI6V11yAgNu4/0EJuiu1mU95ujeENfbFVRxFFMUg1c1e2+NCO?=
 =?us-ascii?Q?mHGFYtSUQdpyuridFe0cXi15yuotDJ9SlGFJ0UukUQy7Zji74RmGxmmAsxSV?=
 =?us-ascii?Q?quM7T3p3OwViguqPtb4z4BWNH5eoQhFwUNR6EoiL5leV4NRA1IkgA6KUv7G6?=
 =?us-ascii?Q?9+De21qJbJ/Khdoya8Qmyr6+kI8IidW7awADt36LHocVleoPh4QxPNrI0jLj?=
 =?us-ascii?Q?Jin1uUdQR0RkqlHxyA/PfGlQDZyq2xqwPY+fsLd4Bbfvvw1PIbf4ZH9SoS5/?=
 =?us-ascii?Q?B4GilwulLoD4GwfggZjPWni+q9hCU77iD7dHcHidVm0YSdC09LLqRabVU/xu?=
 =?us-ascii?Q?OePdwPB08qjcqQOvfPbEjG5B/34HJzP2UYwcHlLC+XRuW6yT1NwusGKRVXIK?=
 =?us-ascii?Q?LA+4mjRbkO+AJwtcNcFi1TpSOklSf4lsU+Fb+KmoJ/i1L+fNtQEo+J0JaZx7?=
 =?us-ascii?Q?BNLLH1ytM12EVQlHTQ39wdLXtgpKu2L7UEPUiwyxjZGx8SWYcZPTEhY2oYZ4?=
 =?us-ascii?Q?Z0k4GnVa82gm97Qfc8Y5giRYt4CBc7hG4ltY/WXdSN5RoN8XNyDxBlfrEYnv?=
 =?us-ascii?Q?mTW32l7UgQU31eotNbEAPi6T5azOCjSImcsLJfj+W9FegRPfZ75oGninlZLN?=
 =?us-ascii?Q?1MIiovt/aEQhl8+kkVVXYaDxb0wDFNekSeSkZ5UFLspKNaBU4rj9O7EPJWP+?=
 =?us-ascii?Q?v9FXgcR2DnYKrPH0tjdlea0ofhpRJQZrM6wRgvp3OcqUxZSc/JJsa4M0jQjh?=
 =?us-ascii?Q?mkdPsq8iRhmzqroMLtxOJl9U7puK04tFzc5lDKJNVsPMj96SchX/Mi39oZpJ?=
 =?us-ascii?Q?VrQw9PyGVOp5KXX8ZCwjYiDS9IiJ4KAvoo9gSn5obf02kU/2wr79GBJ+meQB?=
 =?us-ascii?Q?IugbyXv3nhwrUzP+BGSYPB0ddIc7cOQwyQNQD7yPT9vKzXFaoUCNFX+zsNdr?=
 =?us-ascii?Q?Fhaxc1WXzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d6d62c-9218-4e0d-6bbb-08deec24781e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:17:31.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4GfFeIpj9sOfgD1XgKeq+I4hpybrQ2uihrlrEbmAB/iqehRDyEB370DUAp43tRziTA+ATfUU7U6Kr5nB/NoOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186

On Fri, Jul 24, 2026 at 02:50:14PM -1000, Tejun Heo wrote:
> Hello,
> 
> The exit paths weren't NMI-safe: exit claiming walked the sub-scheduler
> hierarchy under scx_sched_lock and the bstr exit kfuncs formatted their
> messages into a shared buffer under a raw spinlock. Kfuncs in the "any"
> category are callable from tracing progs that can attach to functions
> running in NMI, and many of them raise scx_error() on invalid inputs, so
> an unlucky bad argument from such a prog could deadlock the machine. The
> hardlockup handler had the same problem and deferred its abort to an
> irq_work, which can't even run on the CPU that detected the lockup.
> 
> This series makes exit handling NMI-safe end to end:
> 
>  0001 makes exit claiming lock-free: ->aborting is asserted with a
>       synchronous lockless sweep and the locked SCX_EXIT_PARENT
>       propagation is deferred to an irq_work.
> 
>  0002 reverses the bstr exit sequence to claim-first so the message is
>       formatted directly into the winner-owned exit_info buffer. With
>       these two, scx_bpf_error() and scx_bpf_exit() are safe from any
>       context including NMI.
> 
>  0003-0005 apply the newly-possible direct error reporting: NMI kicks
>       abort the scheduler instead of being silently dropped, the
>       hardlockup handler aborts directly from NMI making self-detected
>       lockups recoverable, and scx_link_sched() reports failures inline.
> 
>  0001-sched_ext-Make-exit-claiming-lock-free.patch
>  0002-sched_ext-Format-bstr-exit-messages-after-claiming-t.patch
>  0003-sched_ext-Report-NMI-kicks-with-scx_error.patch
>  0004-sched_ext-Abort-directly-from-the-hardlockup-handler.patch
>  0005-sched_ext-Report-scx_link_sched-failures-inline.patch

With the new patch 1/5:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
