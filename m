Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF433356746
	for <sched-ext@lists.linux.dev>; Sat,  5 Sep 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636287; cv=fail; b=Vcm/9fo/gJ81NdONMndmIdYK8758VBG071eYTTJf0FlBXWVqYif37ePYRL9aRUesiS5HpC5idnNIxmsX47sgpUySoXP4jMto0D8zE2oTRpyW8xRBDnK2hVcv5WHyI+ttUsbIc1Mi7G9fIFgr09VHgcIFExUob64WS72cRxaVJa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636287; c=relaxed/simple;
	bh=MySvdUCIFQdrqQ9e8e+2jVLahaaGyRvuMPx7EZ6ZwP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n7PqrFnb6eI/WA+7jwjmWb0ujQ16si/eQtWN20B3eQPzUO4Ibw/LcJM65/Y86xrZlKRHoUzKz48Kab9fF6EygVkPJC8vxOMhvip1mrJVgsSWDt+nPzP4cehKxaM+gV0LC8ZknLypEVBzk8JEwKu/YQ9PpDobwjWvwglLWX3dVkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wj3nXIBV; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wj3nXIBV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVzp8/PtO0n6ZRG1GrRhydt5Pt22USZsH5qQoY3zl+THoEQcvLT3ySO34HmHZOp/RgXvoh3OYF5ue10mkBbjvDAS4imB1SA9Cz7I5uNL3C7giQWT79/squzV7aLPBbGwSY233NpMh4n7DcDDQwJ49aMhW2BooJ4fCSRIEW5jU5LI+OpOjmJ5VqsGKdiAHIxsqyYRXvRPj+I5gv6ir6TX3l7oWYHobq762Ahk66cxXzHud5gLDyRLV3rBzOVJk9WH/XWKkVIZQgOUKw/XVQLd8tlXGVIvQCeQHt4RCf2gmJkPWHYYVQs6mYjDpFOcY7CR/8HOgKfxY+fLCBDLEpecfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIxFQx/56D8w0lHuaPaBm/KerE+L+eNQ4sf4MTvxxR0=;
 b=clMd1crWbg49sLPXUnUL0mGRkbmZkoCa1Dq6z3DdPUMQ367VVcuvbDQCYgsB/rf53UY4XHyrGS/lmiukGU1BeBfWuu0dY6h0DrXVtlMSxP5mulPYBcsVGPIfStjQk/LPhveqiKK9h/aqR9nliJOjXGXfPYkr3oDoMB73xtXApmUsctVZ4kXbcMoiUdvxmvc808BaHO1tzK1Eqzy4hebbyHPCTr6mX7gqim7q+cwR/3NJ5ztrY0Vk/yPWGp1cFQrM2eTcOmZdOrbE7WjdihdxyElA60ERIGDkGUFIC9ESSYvsgTd9O5jxEijAuymoC7jmNUf+AWcD62Krw8RNnRnIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIxFQx/56D8w0lHuaPaBm/KerE+L+eNQ4sf4MTvxxR0=;
 b=Wj3nXIBVsD3SwlwNHTVeCTyKrXW6zNsa+xyyKdPYvUjSVTjCIEJ2Z8DEHJe9jOXhpRkLbG2/xLBInVL4s8HU2EUkMQbfCZcRMHhozw79QIGjskYzhfHcJtkQXVH4WLfNT7VZoSfXi89UUW3M7C+l5ejFgoOZ8Xumxo2LEumPGJWabnQ5Xxsc3YPcezCFKH1PQ+cMg+DW+j00SnzMdVW4JjYUA6QAN+2xjQGtvJZD+qkheQDtJzX0wy29hAHhD+6JSmFtPcrC19IjTuDyXYG5NnhksZeZ6wtQvfZG7tL0DWIUycQJGgfvW5UzggMu9GsyXzawJVHcHg9sCgRWWSaAlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 19:24:38 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Sat, 5 Sep 2026
 19:24:37 +0000
Date: Sat, 5 Sep 2026 21:24:22 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sashiko-bot@kernel.org, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes 4/4] sched_ext: scx_qmap: Place
 only on cids whose caps are in effect
Message-ID: <apxsZjPo7IzPuC1x@gpd4>
References: <20260905160958.1565156-1-tj@kernel.org>
 <20260905160958.1565156-5-tj@kernel.org>
 <20260905162223.6EF521F00A3A@smtp.kernel.org>
 <c1b5b24af15ee3e117bfa07f8c89aad2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b5b24af15ee3e117bfa07f8c89aad2@kernel.org>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 71172661-a2ce-4028-812e-08df0b835351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BvzngqHhdXl1YtWQJy9+2D8oaeirXA4hD44CdspJ7DUka91LqhIdNd/g4lRrtSjBr13eAqTo0ejRLA0oqKRg+qNDnEDfBkoDGu862ZsEdETJBupxg9H/X6TGoXqKAu7GU47hVllwP6zGU+a0NFUooAhQu4Qs86Jvroc5CNesjoxYV1fVNimGRdqlPiWdD9m3sP/4/7BeHf1w0BD9xmPfm38ZSHGBJ8RXBKtYK626VXIQiU1aPJlzfAetPO+hkBWgu3xgbycObIAtEDTlMVtdfIckFEV9c1UPzOmM03TqJUd10m6WLdsroSk3KPdH7zyDqXLIo9D6O0DF8xKGATH+9qnwlPTHZ7oTa/JGbGnwdTBDVmgMF/80esdUZSyv9WWh6NnJfQdmPcmNMuVtIkqHAmdzirNuAfnSR+hWFrpHvxv1x8U6KtsCj5/6vRPE29tlFww4vOdlYrfZUjjzB2Op19i1NkdYll4OkbSnpzJ2tVtynVb/DXZQnxypufbBE7CARd7ARWX1WuAOSQihnD23G1hbejRPFzHIWNE/uOkc/oKYYpHBU/GjmnXjvl42wy7z6oGpUA5CAEZ0LiVLJVJNlsfK7osywCy2Zg+DggREp6Apt1MB0UgVA3fQBEvlJHxCo1D5gS6bDyHCYwVEg+BoaWIajR5SaDaa/Tg/pKyGdB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HmanEshTguBwfGTNhoyStcCrnYPnB5ZXbPzY6YIwhS8FatLKaOWsJ3QoFUbx?=
 =?us-ascii?Q?55lF2QiK9BKRAcO5z/Pv6abbgp4y4mhaXciXCzLgjKYV4UbKrtzfaXYdcelg?=
 =?us-ascii?Q?0m3wCjV2qQiledMIVK+oLd9v30CqcJLE/huBbuerV8TfUf0MzRPWyZKTLli4?=
 =?us-ascii?Q?mMx+NxJb1bwrnmW5F0ZndTo96zjFYLbgp8RdkRk/dQVcWssLLFvX4W7+aG6w?=
 =?us-ascii?Q?k7lcbl5h8o7YISQukvFBbexCpSRSyP5hT43QbG5aqu/XFIZ4+C91D2IAWh7m?=
 =?us-ascii?Q?N56pqVj7zGRhVKFW4jUU63q/5MDDueL2l983dugC/LAN8lfNUcqjoj2sSYma?=
 =?us-ascii?Q?thdkG6RIP8zYDlKfYli7ppThMXweC6DHEKN+VaDCiW4OCPiQAt9Y0kV9t9sg?=
 =?us-ascii?Q?WRpi2IN5h2RMJRK7s1qg1gzFFW4o4pWZv29S1PzEV1ndeT2WiNRWUEduQYpx?=
 =?us-ascii?Q?48xBKzvfC5skJ+hbLmpuc5GQN3rK4WZFvrcQzaFgEJmbzNcBx3EuUuY2iTnm?=
 =?us-ascii?Q?SA0L4WT4OkLJNPnIMkNPDScJ3+G8RrBSrxwiMNR1+a5+u7tna1CvH9YlBoYH?=
 =?us-ascii?Q?H494fzAHRaWYbH1hS66u5YJHdlNXfZP4X92cSTt0SvEc/MxFTdbJO/qtlyP5?=
 =?us-ascii?Q?PpNNAV+bWzQLJ4SdRs+HmEEdTyLJmmDsySmRDLpZWo242XU2zBMeXpvxzymS?=
 =?us-ascii?Q?ljQLmqHp+AizgHGmWAVV7JSzX6VC1D2WnjqwI7Kx9rpVUI5Y86d+hAs7GPG+?=
 =?us-ascii?Q?ampxIyPNIAY958VdRjJjDhbsuAF3APM66yYMn6peAfnIDY1Q7KjeCmG2YvZL?=
 =?us-ascii?Q?D5/HmhJ/WjHmEwJALcH6mP7us+2ZOVxyEPTbAPxpDBXK7LZ+8SjF/KikA6Hw?=
 =?us-ascii?Q?GZ9e7CHBZzkvxjV6FtuoUQUkWaG1Ex4DRFgGxjJXB12ua2eGk4KYX3syJ006?=
 =?us-ascii?Q?Mnfu5RoBObek3Zp8Szy1u8XjbCB22VZt5C/34vNa0f6bfIu+WzCtjmjeXeSL?=
 =?us-ascii?Q?o1DBUOQH3Dh1//6nyTOUOpCIHG6pQrpdTi98Lm5tp6aw/A3LZTp707X6aGQs?=
 =?us-ascii?Q?waeO8IsiaekcLXIBSO1Y9NQmv6Nh92t5P1Y5kRIzzLa9EdZ7rpk6EFmcOxue?=
 =?us-ascii?Q?bh0VGiorroM5d7HAX7BmKm0c7xGpzRqehW4UN+rqkgKhmvUc3inMdidlvNMA?=
 =?us-ascii?Q?qetbsrZAFYYV0z5Hqv04TQ1tFOtUOAB8NTE3Q67CtqkY96OLRVnosU11lG3C?=
 =?us-ascii?Q?7MOcFGhOnjYoumHaKwZBbLGLOHgzhYGnz7rh/UYj89FemprHDtgmFqjtNTYW?=
 =?us-ascii?Q?a5M14nmj/eUPCdbCLLrjJlprwjvH71JI+zE3N4x7Oj6iwtoqMg1wbxQL8FRi?=
 =?us-ascii?Q?kj2uK2Lz08shk/ZUOnLyqPCSNdSe6b/nzObqHRl+jxAAqj9Pr+bBArPSHYNU?=
 =?us-ascii?Q?g9Vh9rcrjoBEm1Hl3+LMQxl9I4yLrhnUU/fPMDACw36lhO7GQkpsZObjTAKn?=
 =?us-ascii?Q?uWH6qxCWNO9LqtVLUr+JME/niPW3X+YX6NnLFLDkqXUPdoOlH97BG0jKMKDn?=
 =?us-ascii?Q?3QtSyMX02LLYvYHKUrgNN9hfjGYGNqnFH58tHkcHhyiYnINnhzdEX+x+xotu?=
 =?us-ascii?Q?7GZG+r1H/POs84b89tIgk2XZD7eGfssheTqbduqA9XxPxY8FS58G1z2RsUS1?=
 =?us-ascii?Q?Tr1Or2XBV7yCPH1Sy80x9ahsiFjBOrBucAwquWuQF/lYrD5cNnQea1GeHYg7?=
 =?us-ascii?Q?gZOl04suBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71172661-a2ce-4028-812e-08df0b835351
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 19:24:37.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aG7N26Gl5RdeTYaZj9h/w+yj/G7qQI2FhdKxojiSU4w3ym9s4wYE7pBDi1Gf2rsG175wa6o77ccKIFL9vgARw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

On Sat, Sep 05, 2026 at 06:40:32AM -1000, Tejun Heo wrote:
> Hello,
> 
> > This is a pre-existing issue, but can lockless readers observe a transiently
> > zeroed qa.self_cids.mask here and incorrectly fall through to the rescue block?
> 
> Yes, but scx_qmap is an example scheduler and the result is a spurious rescue
> insert, which isn't critical. The race is acceptable.

BTW, while looking at this I noticed another potential different race in
qmap_sub_ecaps_updated() busy/pending handoff.

    CPU0                                  CPU1
    holds part_busy
    refresh_usable() using old avail
                                          update avail_cids
                                          part_try_start() fails
    sees part_pending == 0
    part_end()
    returns
                                          sets part_pending = 1

IIUC, there's no owner left to consume part_pending immediately at this point,
so usable_cids can remain stale until the next rr_advance() or redistribute()
pass. It should self-correct, but a task may remain queued until another
dispatch event.

This is likely not a big problem either, just wanted to point it out as a
separate one from the transient self_cids issue reported by Sashiko.

Thanks,
-Andrea
