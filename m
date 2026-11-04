Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793803630;
	b=uPuKfd+gnRkuuwATN+uSomLhMgYqXyVJQbgarPS2lSXOZxJ7La7mfINJfWCYmj7EpsaS
	 rx7N/LzL+21TG1o5Dxm1RE6F5009AGNfGb+UZ0OC1Q5Ovi9/eUzfoLAmvzVjb7gEk2r3K
	 w9Cr10VZpUihFQJERCx4sN1YtVRkcHmyE3/VszjLKcqKg96aMdwfdYyrKae2Scw7djr+/
	 NXqulxbH2X8fpeeD+60vwhSeyX1L3r2U9GhEHYE3+kdun1UBlOkviR8RH6JtdVmxqAEPY
	 ehdG7GIlJtO3hzVJfWKsBfPXUwlH4ZFCU5LLSwTazJF1QzgwS/fG/WK86/vpdwtTIkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803630;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=o3FELEldPkbdOmMBfoiYJSiwtpEsqe3v1xJih5C1kdI=;
	b=mHhFss8UHjlcKO+/FcNYeUPLx0/i3xGn43ag8FgyWQiUsndpOwvpuJa8pwhnqxzc3nA7
	 pl4Kley4FpQIxezebNwIKogdgZCo1J8QgpVngJDOJ7m4eO+AcNgcVswlNQdelJ/kyovz8
	 JMdK/eOhvr6CO82I24pLIYLingoWipWusDcFaWBLAlnlYNcUvNaUqxBXsC6JSPVuVmPcF
	 NgRkeiVLb9pCdjULHd1qC/B7zj8aFGT8OK0UNbj4YNLDcWz36Bw8GgtkrX5d+DSEHT+hO
	 aGJHyqSKTHfDHw/N/15o8EJ0JRZouxrEQ48jesy/CK31yAlIx+qlowv334fbwYTIgjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="CsYUV/Dc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367F606A329
	for <sched-ext@lists.linux.dev>; Wed,  4 Nov 2026 14:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E367F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CsYUV/Dc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdiL/ET/t6qQV1oQjdOXDcpYAGklmYyzyfVYnWbr0G5i2sI2kfyyuJScva+l45aJZzPz9JMTgOfq5+Em0ddWsnkwNMIiUoBzSvsBoEYb0ePbOcfcZ90qcA9MrNXLJ/+Pa2SiC6mjSAwE2wBB1jbvlCFSzjXB9UPAEWZootni14oRMDfvOdrflzk9JayVi/3lGklNmktR5lS4/6AgAYn3xPKebj6xxYvwjxLaq9Br3z50GJGIi53DU6BHBHRlgP56iNQQ2OabK8cgcuR/GX03E/PxcO3LadOR8OowoBGTOc6Gk3x3G0ZoCMT+RCzBd2pgmO+XV5CKbn0j7hmTtdjGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3FELEldPkbdOmMBfoiYJSiwtpEsqe3v1xJih5C1kdI=;
 b=mgZwQMZMnBU5DjhnH6Wp7IB4a6QkRdo1SkVwFJYPgAJPEA/oBWVEQQHHhOfUOhUZgdpa8ce+PAooJUuKHf+ZoGWkHLNhD7UV5kSQTo5TaCydGEZmUyKor2eXWTjHXPtbvow58+qq3Fba7p1FlhNU8fTbUKBnlDmQH+H+LeNOATtu656fiQs/JPJa85EqGGePXj3Te6ItK7mjQFkNDWnPTKw1e/JE+nyLO/7feSuM/qJnpXrtKw8kvMYmEw/ndHcnomO9c5BUHzt5jmuCKFXFBm8iAftDUUoDuVgcvDLE69yr5GrsxAIlR+tjjApYwQNb6YBFTlifN7x47Pi8Ea1sbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3FELEldPkbdOmMBfoiYJSiwtpEsqe3v1xJih5C1kdI=;
 b=CsYUV/DcTqUFXTiwyJGt2xel4zLHUYGrIkIbxlnHCQcwZBgKXzIs74JLheWSklr9X0DqQJ0tVdEh3k4TZjzP0YVIF5VdIuzqQUK/LCZGDfG3iHkU2NPuGzD0FA0D9EOd/7MU0Vv5xaSRQyNid8fGdA6y1l3rR7YCkoyfvSTNmI+RnPuN6AZzYntypogOMme+tV3qKI+YKrvFz+NnQ59IKD/SnKHvNPqkOTXe7yQXbP9DxmMhygjsuPGK02DTmrmODGDqyCmL3Dwth3LF7Uve0eUVItzh4acs/WhFsDFI8BpJHMEp8in7o+sxLweg4eozD8ACB98zi93ucW9cd4CsHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 14:47:05 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:47:05 +0000
Date: Wed, 4 Nov 2026 15:46:54 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Richard Cheng <icheng@nvidia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Read exit_kind before
 flushing in scx_flush_disable_work()
Message-ID: <autFXkvat2yB5z1R@gpd4>
References: <20261104111449.3984318-1-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104111449.3984318-1-jpiecuch@google.com>
X-ClientProxiedBy: ZR1PEPF000077A8.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::439) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 866f81ec-3d92-41b0-af93-08df3a827e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|261028144727099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|56012099006|11063799006|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+SVHdsnD2/iky0e7gQbK400RvDG8uIgbYO8TWLCOlcje9mh78pOwa8U4PpHowAgFN7BjqeekX+BHiVcE8LuSHJWgwVRLNvNG4bDvblrjp4ZIHqfrzpAGWaQjuzQvVGGrSFCq/1xpj1AaaTyx+CQHcr8vhvNsXHLqCej1gDO1gCol510gscC0dGygodaK6fzBMleeAmi+u0bHmaNprOxQ736aeViAcmfz7i3WRYgR3HwbUeHyuUwNluaJnaV6KHuCka0MNVmKxgKzY6hnCo7s3lKY+aIWYCwN8wyajeaufw9QTSQzNT4RtlAeRQZ3tvzgX30T3LzMLNXIGiC5fG/T4jsCH4vUANJrKAYQFJ3QMZgi+I6IYjTWQBjiPXsOCIQHmoh5mQjc4uvwoj5GUOvhfWl2oxEmt4NJPuETcwUYAcTf/go1OPRsgQV47VIEqxuPy92fEI9O4ILYOo3f4njJ9q15m2vsLAW/1AkwdCmQgaa60GfMjgjP6JI0xfh06aToq6tMcK+aAGeohrB0YkdlW/T18KuKNOWZS/Oe7AhYtBeBx17IDllt9In5YFpjV3lmDWqfyvo3Hx+zL8woQMn6i4tjkxPP3x/MVrW/BhjnYr0G8Od+FYd0HdYRZamnp1SvjtvEja7hEgzX9t4CYcnoEvZQCBo34HYmVM3qI9iPGMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tapTa5jMI6XsgDA7LuKuRD4IZTnh9tY4fCCGllCRM9Kd28lkP39ZMe8yTabI?=
 =?us-ascii?Q?R+uWkesqhTSngJttqxaDXG8indR5PtJCOy+6DNkRj3ubc12rXZwf/4kuepGb?=
 =?us-ascii?Q?tBan+nzb4neCmJJEV4OfRd5nLQ/PN+dCBw/efu6N+HP7DsUkyr///UERBs7I?=
 =?us-ascii?Q?Sp6NAh5vqrqPt6TIIGBuvCD1Vag84mRnHa5tSWniokc9z8wZjZWGhkdm6G3F?=
 =?us-ascii?Q?mSfu/IYr4XcZdQD/1JXwP5BTAyweS3kmAvJbCgnM9gV6WSaklIuktFF687x1?=
 =?us-ascii?Q?cA3y4WD4JNkwf8Qh6OetMPeDK71kdbsN0KLVK64GxBj+LJJ3k03l1EF3i0Gx?=
 =?us-ascii?Q?QvbKnhdsA1mm+AZ4AmnWDTAj1oObUfU+DZ523z4jR5++DgFJdLga+FIizzW0?=
 =?us-ascii?Q?ps62pNBB05QZYKy2NllgzqOvJt/mU1tiqss5dsXIL3vqwOCi/KVz+BhQZN0w?=
 =?us-ascii?Q?kYAYYGqAY2zAoZa9oemjBRdVZhvvtsHR4xfrP/41ctzfMgzsKSN/j8PgOISM?=
 =?us-ascii?Q?veq06gR3M1eA0A3jVb3gKFc16ZHZW7IY91EDw9PRK+z/lvpw3VPEhfxTe8lb?=
 =?us-ascii?Q?yK1lyO8vgtz707RFZBi7wamsA9EHCZCoHhZN0sH2ePu6Mz2RaCUq866UnfdI?=
 =?us-ascii?Q?PHJQOIy/TTSvh0EVBhSB044EJcBMx9j+jTVDyrvkEb398uA/UJN9UXvGQ2Rg?=
 =?us-ascii?Q?FcT59U4mC7dIXLrtoA57mp0SwsxAiXxcAjwGdBcc7oNc39ThmejLxbDS/05D?=
 =?us-ascii?Q?x4oNYj9Jka5DNBdQgtMttyCr82smpRX42UdQBTX0KBbdDtwEInkasb6fgTpD?=
 =?us-ascii?Q?gpLxr0XD1kJTgVNRsubESpJwuSFGxULGHAUOa44G8SLXBvJ09tHOK5GtT08Q?=
 =?us-ascii?Q?Xsg8IxQYaiF0ZZ2xaJPMRcEqH5Sp3niC2GHq7gu+Ku2hztMeoclS+JEXxoj9?=
 =?us-ascii?Q?ofEF+U+dxgz1YhmK23TvmoFmm3y105lh2Q8unKgGF5Grcwk66hP7EJPvn+en?=
 =?us-ascii?Q?dNFjL5ShicOoOqj/AHJ8swQ++K0HadRRCK8Ft8zAmnmIr8TXAtAXBiD/3HfH?=
 =?us-ascii?Q?RU6czDvC4g3l/zcLMcEwuTEGyrzmL1XaWwMGAuqkSfRILK54dEe33f6mUEYV?=
 =?us-ascii?Q?fBHa+1VfYYMYHrmJXLKwcR1vY2ulJedSvRBI9PNCc07seN2/pwyObMWQJ7VD?=
 =?us-ascii?Q?aO/94V5kDC3NULdJ4l0FkhubmbODMNaaGDbPcfGQLaEQfTqm3FytMb17lZxW?=
 =?us-ascii?Q?7CvaPTQv68yTrRqbZEwKHd5DgvOb7kjUzkS73zMZlrEWCFhQ9Y/4dOWezOcK?=
 =?us-ascii?Q?zjLQ6LuGg0U8nFIWLK4y8dlWYH+8kinxLM/H/ilC+XndFN72VKm8sikirCzw?=
 =?us-ascii?Q?bfsJECH/7AbzVeag/Kq+YeRjiNqFJo9c5xVQFZTjmcJtfBhQ9yL6SPobHIZ7?=
 =?us-ascii?Q?VWZM1MxMD9udQWWHSG5FPU1M15eiOdyqclpcgdz3NLPa966NuoExAWLFQmmg?=
 =?us-ascii?Q?UhWnr7SnDnPo+pmvnjzYCWCAhzLtWig+Shjw/wg7GpSl+c9LzQgFps8RNISV?=
 =?us-ascii?Q?MUpYejKTETyOgpNzC8YiV5NB+qVoPlJubV6nRh6laTwuoIKD2bZ+tuZFi5MN?=
 =?us-ascii?Q?i6iF4V0Xn0JO4XHipXIsY9k6Jo8CsvR6oPPFZGPIvYf3PEFG64GbZw7FslqQ?=
 =?us-ascii?Q?kvihOJwCEw+hOpsOXugFCw8TssOrvUy6Wx6dWQn8rVEe/OvC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866f81ec-3d92-41b0-af93-08df3a827e40
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:47:05.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4tHl2A7a44fdYg+MqbkmdBnlwgwXBKo3cSMHafjPHnZ+hajYdYCv/gLHA5a1as1u4a0soXS3YDPo90zckb3aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

Hi Kuba,

On Wed, Nov 04, 2026 at 11:14:39AM +0000, Kuba Piecuch wrote:
> scx_disable_workfn() sets exit_kind to SCX_EXIT_DONE before it tears the
> scheduler down. scx_flush_disable_work() reads exit_kind after syncing
> disable_irq_work and flushing disable_work, so it can observe DONE from
> a disable_work that was queued after its flush and return while the
> teardown is still running:
>   CPU A                          CPU B
>   -----                          -----
>   scx_vexit()
>     scx_claim_exit() -> true
>                                  bpf_struct_ops_map_link_detach()
>                                    bpf_scx_unreg()
>                                      scx_disable()
>                                        scx_claim_exit() -> false
>                                      scx_flush_disable_work()
>                                        irq_work_sync()      // not queued
>                                        kthread_flush_work() // not queued
>     irq_work_queue()
>   scx_disable_irq_workfn()
>     kthread_queue_work()
>   scx_disable_workfn()
>     exit_kind = SCX_EXIT_DONE
>     scx_root_disable()
>                                        atomic_read() -> SCX_EXIT_DONE
>                                    bpf_map_put()

I was also able to reproduce this in virtme-ng racing scx_bpf_exit()
against bpf_link_detach(), but only by adding an artificial sleep
between the flush and the exit_kind read to widen the window.

>
> 
> Once bpf_scx_unreg() returns, its caller drops the struct_ops map
> reference, and the struct_ops trampolines can be freed while
> scx_root_disable() is still running and can still call into the BPF
> scheduler, e.g. ops.exit().
> 
> Read exit_kind before syncing and flushing, with acquire ordering paired
> with the atomic_try_cmpxchg() in scx_disable_workfn(). DONE is only set
> from disable_work, so once it is observed, the following
> kthread_flush_work() sees the queued work and waits for the teardown to
> finish.
> 
> This patch was created with the help of an AI coding assistant.
> 
> Fixes: d99f7a32f09d ("sched_ext: Fix scx_flush_disable_work() UAF race")
> Cc: stable@vger.kernel.org # v7.1+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-195908@kernel.org/
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

With the artificial sleep I also hit a refcount_t underflow in
scx_root_disable(), followed by a GPF in kobject_add_internal() on the
next enable. I saw this only once and haven't root-caused it.

In any case, this looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 6c593d3dee3c..949143bf4752 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -7810,10 +7810,17 @@ void scx_flush_disable_work(struct scx_sched *sch)
>  {
>  	int kind;
>  
> +	/*
> +	 * scx_disable_workfn() sets SCX_EXIT_DONE before tearing down. Read
> +	 * exit_kind with acquire ordering (paired with atomic_try_cmpxchg() in
> +	 * scx_disable_workfn()) before syncing and flushing so that, once DONE
> +	 * is seen, the following flush observes the queued work and waits for
> +	 * the teardown to finish.
> +	 */
>  	do {
> +		kind = atomic_read_acquire(&sch->exit_kind);
>  		irq_work_sync(&sch->disable_irq_work);
>  		kthread_flush_work(&sch->disable_work);
> -		kind = atomic_read(&sch->exit_kind);
>  	} while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);
>  }
>  
> -- 
> 2.56.0.398.g882cbad275-goog
> 
