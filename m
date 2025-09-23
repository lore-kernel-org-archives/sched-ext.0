Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFE320A0A
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618761; cv=fail; b=K1sf0TOorUBDWToGhd9Jvl3ed/WeD55lADaQ8vbv/iHf8DepKnQ4EehhbHLiUcXsZ1XEp5LRTAMhLZDlbi3o9p4VCFzhvobmh1X6v5yvy5myqu4fqLsVYilpcDz+0xRISp1qgItuTO+SKC/vch/IuNCfk3WxMBcUeuckInTlNls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618761; c=relaxed/simple;
	bh=OLWC6cjYwoXK2+qVr3hwZOELyIUSO7zwLKGWblvaT9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j2fsbaeMAxWAEfz+nLWSOo+M0wa+3gRiu3zkQbyUKh9kRpPmoTB42EFJxhN1/+m2SA9Z+XRQUIBrdM+dmFQeTxK1IW6aw7CXabAwUYKPmZLoVFBxS4W9r4+psGKW5xA4t3Y1yJc4CdwP4mOf4ApIVPtHbNoKPwAaHvB49eIpkW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HMZv5Ca8; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HMZv5Ca8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5Z8GgTo1krEUgIux01VpuX0Ahmu701Fn12BS+qcWRcgJDsLYw/XWL1hBYwUYQC+Vl2I3ziIQ4Xql55LaZbHvs662bG0Z03ReKPI4QjLwd8+3zDD7gTts386MswHDAR/AS93N/y4eyGEij/R2g9gczgykF3EILBkaShEXh6RMZ4yPTdNbigReO3vZFdIL1Wssx+YGddFZjtMCAmnRZB15Znhl5jym0RRLAWjcPits0ggorefR5kjMHwCzaJL14XsR7oHhaJBX39+cAdMmOKcCnisNwlrtbpBYf4nfRlVwiN4rIDCsh0IosdohpUbBbTs9GNi/aGO3UviIY2MVxa6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vAdlDxgvHTYU86FWIoQ8ahE1i6YK/odSm27nzc+qDU=;
 b=fNv1Yh8hKG3FE13GHjst7Q5TxSLjfY36Gmgrn4asYl9hKElwkXBnz/iNP/tv4XvhoKs3aBgLMRCTiUjFM9RLZa2uBZwtFk+oCZRY1f0irm57GeZwQh8d+fuKuVNfzCvAewGUhtRu/ZbdW/8m9OcapPs/PpzowEi4kFEEklCwQNWoRkl9ZrfNXdNu2bm2ovz07mcwGWmBp4Q1wPN4jaToF8qB7eX+2Bgc2fH0TTLrQ92aNX6Sz11Wr4em/Jrqpd+uIDibQl4UIxuzuWQ2hl7sgNSDOTIsTe2STfpMYp80p8p0btQ6m+xNz8JZY4U1dng0zBsFawrL3GpyNr9uyvhN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vAdlDxgvHTYU86FWIoQ8ahE1i6YK/odSm27nzc+qDU=;
 b=HMZv5Ca8RBJrnLKrYFO6HbrjZwhsb2UYeLbnOkRk63UNycaEWhV11MVdGKZvY2CU/y7heJZg8Xui9/QIXYd/kzRald7p1ufthTvYKwa2STmpydSP7+QM+2jmVzywFF1zrkDFdsZHQ1oTq8uxDnWPazvLjnhQf5/0EHsnj5ZPPrNo4YnsvBd/TeRbLoVonb+BIKdIIl/54anenE6Q3ibkxzPuD5DwKYlBREQicWY8PNY5NVSaAVbIVSPb+CwH7pnl6SHI/U6cBc9gmredfJyRDTMvUBls+zddUpaoBKiHRdpcrcMnO2tKXobvYPitKff/1cqtE6TBY9ccOsaGt5kPJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Tue, 23 Sep
 2025 09:12:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 09:12:29 +0000
Date: Tue, 23 Sep 2025 11:12:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, changwoo@igalia.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCHSET sched_ext/scx-misc-a] sched_ext: Add @sch parameter in
 preparation for multi-sched support
Message-ID: <aNJkebyknbj4kSeo@gpd4>
References: <20250922161436.358949-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922161436.358949-1-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: c89f3972-d972-4c33-42e9-08ddfa815236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jQ+OAc5/fbRRsGKeszhJ8jGuza0Uw1U06eene3spMS0HhIMBXPlc6I47aGwt?=
 =?us-ascii?Q?vJVcqPx6TJanjJjNbtCKlvCU0638tRvb7Yg+fF/iif7u5/MxeVl/5hKadGoy?=
 =?us-ascii?Q?oNBsXAlxkdrS713qWxeHoZc1nLJFpepoLdwAUSPc95DCb4l5Ode/XBEhF+4a?=
 =?us-ascii?Q?lvqOHm7W5cbEli0+RtOW82brDhBCU1Hbu092R1u9iP5lFHN2zE/SlR8j/i9k?=
 =?us-ascii?Q?Mp5wxYesFLz8GcAMBWevaGHRwBIo0PMnXJGhLD2YlMPN++DMWAdM7VoTaso+?=
 =?us-ascii?Q?S2SBZXOLSYK7ggBoCLjTzwrWfos3r37aO8iU7H5xq+3eeCz2tcp+MUw0l6J8?=
 =?us-ascii?Q?4Stqb5/OCIGNdWP9yh2GVZZStr2BSfC0xEoSiq8HhYp1jig6AoOKTjJhUOq0?=
 =?us-ascii?Q?AtFJROG3Q0ImxJdTokYtsP7GHp5sT+0aE6UIHD960cUivvBjtk2nNeP/Q8zM?=
 =?us-ascii?Q?XdkSJrhggKe/s3tIU7qO8zZrxoAP3HTBVagO7MF8azUa3ny/H1k7zfrER5Jz?=
 =?us-ascii?Q?B3bT1mXeFut2NqOgYlHJX7vNNZq16pJIzwSmOp+avLhGgNVGfELN1ffsATsE?=
 =?us-ascii?Q?q8fCtG1P+V56ta/zcnCRUzdTwUz/3bNW0jMjs6bco9OHutTowK7T2V68QhWi?=
 =?us-ascii?Q?pITgOeBeV9+pH4YT10NZSp5SF0d1g4UaHfhXTDNHnozzYOU2HoOC1EuXpjWw?=
 =?us-ascii?Q?V96yTQUFL1XxKKj1wl1yGJx4DaO3UZUZ8MAFVXdwIsfyRSlG0Kj21r+qWvfj?=
 =?us-ascii?Q?smT0SmcnQljhgHySvsnbGIH3RxIGIdKpK/qyXnRilALSJ9dr6dobWYIOwMls?=
 =?us-ascii?Q?uX1wfKUzmkRZA/ewOkQLVeA5FmeNdI/gsft8LOpOMJfu8NRd/Dwc/dmOMKnE?=
 =?us-ascii?Q?ji/sC3bDmtmzUM5ll7yePelnK1t8zw+pIgR6ItrP4lU1LWEl+Tt24LBo8rHV?=
 =?us-ascii?Q?AqeriHFRgRto3Uz2HqlOFYBdqum6WOkAdGDySD1O/VyJSEpkfFl0s+4c+iRP?=
 =?us-ascii?Q?PEOLUSQjSJu5RIo2IxzMD6XCwlny1qGy11ITB53L7wqFO1Y0riPN/kbgjLcn?=
 =?us-ascii?Q?4L3N/JfbS2VpfzZEwLTlL2HEDlujKwdTul2GVtytG63mrJw5gDWt3Vu14io+?=
 =?us-ascii?Q?9uiuWuzIcxQZ7A0pjdSfYFqtYuTjoOVf6CLBJ34m6SaFhE/iX87rHaWT7q5L?=
 =?us-ascii?Q?PeJ7+GndNI0s6kQ7S49bmaNhELy82F1oWQLwFvSWjlSPhelaQBT8dqg/d7W/?=
 =?us-ascii?Q?SU8cfq7+Nr3zxJoYkyFlWQWkByjhTw5t4OWchSyTsvEWH5b5/9DvpO1UlYVm?=
 =?us-ascii?Q?af8/oV/HR6BxJKTh6OgmjPhdutIsTdaT+yk4+899P9f5OC25FdlqobHe6mF1?=
 =?us-ascii?Q?4nRcW4Ens6KxywhZBW4CSn4Xj8gbudPjRPokUIwY4DBGoxP0i5CUxwlNPEpp?=
 =?us-ascii?Q?PUyAuTcTvhY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LmpNA/TS7FUQcv3gqsNuu1I68sPSdiyAkP5Ee+Zl7uL49TjaqoqVd5NsPJYO?=
 =?us-ascii?Q?vLBBbrOgWQ1xoJQI9YmrPZE6ExDZTVIjtn4MB1NVbuOKLdgRWtFyTaneH1kP?=
 =?us-ascii?Q?7Tic0wQFb7Rq9snCp+bNytqKJKMI8muiuygZGJ0TO1qdkBJkQn9GcJRUTJUB?=
 =?us-ascii?Q?r8JOoRUP6VZG+EPB4PTIe2USpX0YS805pDx5bmcW5Ebh9oaYBhCnVoySyU4+?=
 =?us-ascii?Q?cxgc6ZwZJRl3kTP3sg2N9aTWkMEWLqwsBgyTw/oQeoq1wiA/lpCGIb9C3C8Z?=
 =?us-ascii?Q?21kxAd6lttTNCV9YhujhMKEL9LoWybWNeuvn1eoFg2oqn/q348c6E6hLj5+P?=
 =?us-ascii?Q?c8kH/zcxWz2nCIHqzP0zNZ3Mfdyq+TLHxf866U2UqwBw//6bjrROENIRokGK?=
 =?us-ascii?Q?lSKRIWCyBwkkPk4klbmhzqmik7FwIPduaKZGHTvSGcAktOV8FZK0QngWjAhb?=
 =?us-ascii?Q?3UbN/YbeYJS2OBFatU0cM9GYToUT1+VkUp761z4FM5VWddfLJv64Vc3OiiVn?=
 =?us-ascii?Q?Ymbuxy52ue8rUpirqyuJiceNgNCiVwytxnOMWfdjqc7GcHZQNwCXoaWjP9ps?=
 =?us-ascii?Q?d9zujCO/kto/L/32tf3F7qHkqB+xfnTtkWzUm7k1ItJ79bVnyrHWbZJMiPpE?=
 =?us-ascii?Q?OOOrMb0jPJMPKRGw05/9DvkdkxNHtRO9c6+v6vesmIuxJ3fCs82oKC+Ngutq?=
 =?us-ascii?Q?JWjcwL4up2+nOgsK4R6Up8rV1r+K1KDh2bWIYj+hN6ei0rxPReWE4hVus3kB?=
 =?us-ascii?Q?aqAv7FoB0cWDsIEJn6OuvW9R4D0gNtkTmhrDx3iblXA4GvTc8XArrEP/md8g?=
 =?us-ascii?Q?AuZe0RKfyf+0UVTASiWNSLWwoT0hapmWzimLDXhr8eWulPH7iESAOMVx3JX6?=
 =?us-ascii?Q?QAy1+o3YZSjoKmhlqKGBS9A+UywItfgJvpbUBTLBn1cVbTyMd8jmtAbFIc7I?=
 =?us-ascii?Q?pcjt1AzN0gn760xqb8SMV+/iIiF9rkO4L+pvIGrmZNFBrhTirKHrCU0x5jNo?=
 =?us-ascii?Q?IrF2AlHrExTAYa3clb8HofabtiIZWoSz3vPl/dqTYGMzLOLzOwTTOOqbAyAm?=
 =?us-ascii?Q?AQyERxxpYGG+CPh7sRh7H5o/UVPgyIxOMgoXqGpUdDz4zW27+P0bIgrQspPH?=
 =?us-ascii?Q?78ZMAE5nEFEOymxHFY0As/2+RGZ/3oYQlZrCqpNocMIYAw83bdhjAppDp0qE?=
 =?us-ascii?Q?clj0yBS5IsFQkuh7l3KhumKNHWc3siHtcukBef/+Zj3iqe/NjaD7SlHyAmS6?=
 =?us-ascii?Q?/KoK3MrkikgDCCDnZ6oLe7DMJXL1qMYiACt2IsyfCO16QujkhUd+e6CWCZq3?=
 =?us-ascii?Q?FNsBJ8l0wEGJpoRN26n5TMwqyr/ABIz2HKiSBxUTRE7tRokRZgLS+qpPm479?=
 =?us-ascii?Q?jC58bYYpbzbUyoPLcjX6MY+1JEzUJCGydqT1Qqyv2+GNJHxL+63zCDu7BFv0?=
 =?us-ascii?Q?SzYRp/F3Wqr1AaTib+Q3KOFAKxoUlCz41yWv9MBZle2ry7G1xMOmN0C5TlKF?=
 =?us-ascii?Q?5lhZlTwQPiFhDtUlFmn2tAUVlJRfEZYrcinniy0ywGyfC3qf9DibDMjnWzdU?=
 =?us-ascii?Q?AxS3tCnUb6AdXIf8vkn43/SKSh9ZJFbHx7l2tWYq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89f3972-d972-4c33-42e9-08ddfa815236
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 09:12:29.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vnsmRqtDA2XrV2eVsFoJyBBEf2Trk4pyh4L7ZcigrTrjJTmNVqMIPDMLQc6GpG58abYf1HskBjvDrJ0syedqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884

Hi Tejun,

On Mon, Sep 22, 2025 at 06:14:29AM -1000, Tejun Heo wrote:
> This patchset systematically adds the @sch parameter to various sched_ext
> functions in preparation for multiple scheduler support. This part is
> needed regardless of how the rest of the multiple scheduler patchset
> develops. The changes also remove a bunch of naked scx_root dereferences
> that trigger sparse warnings. The changes are mostly mechanical parameter
> additions without functional changes.
> 
> The patches are based on sched_ext/for-6.18 (ac6772e8bcda) +
> "sched_ext: misc cleanups and improvements"
> (http://lkml.kernel.org/r/20250922013246.275031-1-tj@kernel.org).
> 
>  1 sched_ext: Separate out scx_kick_cpu() and add @sch to it
>  2 sched_ext: Add the @sch parameter to __bstr_format()
>  3 sched_ext: Add the @sch parameter to ext_idle helpers
>  4 sched_ext: Drop kf_cpu_valid()
>  5 sched_ext: Add the @sch parameter to scx_dsq_insert_preamble/commit()
>  6 sched_ext: Drop scx_kf_exit() and scx_kf_error()
>  7 sched_ext: Misc updates around scx_sched instance pointer

I just found a small issue in PATCH 7/7, but everything else looks good to
me. With the fixed PATCH 7 you can add my:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> The following git tree also contains the patchset:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-sched-misc-prep
> 
>  kernel/sched/ext.c      | 355 ++++++++++++++++++++++++++++++------------------
>  kernel/sched/ext_idle.c | 146 ++++++++++++++++----
>  2 files changed, 340 insertions(+), 161 deletions(-)
> 
> --
> tejun
