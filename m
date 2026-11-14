Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794648821;
	b=V8++swjxCtMJMy+l0yB4f/A4m5Wr12J0/3Z24Pz76hJIGt5Jn6Aj8s1+FPKifE0n14vy
	 7ctuyxFvHCJtdCYWrPdSFOu4HKcfrWqO+yZJQ9MTogqM5K8mRGTGemxeaHar6sqrfRmku
	 37ZToftxkk+Y1prTH7GyzmfAhBqVDjMeRmBh87iVOaz7dUavG08NSMy8Ub23m2G98hUSO
	 cRnuBh9Xnx7CjeH6Gs5ihUMW2XQrySO2ubKIVK5sec1+vP0lYHcJAAGFn3pAjfLWIkp93
	 0CqpcY6q+oUMhzfyxL+MAiditgXB3riU0tEtHyrnnDGrbQmmTTpKscCBPUr8ayt0/Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794648821;
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
	bh=F1LhvNH1OGbP1fETUk2FltJbgLwx1EM2kRcECiWyQII=;
	b=tKi3cRHZDOrJ22Bhcr3DoB3BBZn4M7pkzTHbZJsRWq/GQCR/63cSQA/bvQS7plavd+Uq
	 cef6r+sSXL7FTpXacuzWwvT21LYs6iu8EnyQBcsGWfTFMm7C+tdWct7Zwu3ZjHDqOwLwA
	 h41df5gNcBWrSCA/7K3JqaM+JP6BtwceYzYZ6Raufn44kPyEHtl533PdlsThyeLGfooUw
	 p/RgxUYjL2GWpNAdmzYeabG+vXVt2ssriivW5JBmP1ZHOIrzgElZsxV4/Y+u5os+aoF9b
	 UgR14zUeShu/3SDOZqGlOvX+Y92YdNzKNEulFZnHsBq6SbtPFi40uKzqNyYttfSsppQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uSUWRY8F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.51
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55A606A329
	for <sched-ext@lists.linux.dev>; Sat, 14 Nov 2026 09:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA55A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uSUWRY8F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L73qb/PHvLuT8A58YkN1MDlSsaypvk7H26m2zCI/WsEzxJMXVR5P87GJeQfR3qPmdiiTK0Ehm6ADj+QholEnyynz0bVTAO3eJfSkRvhku3yh+IawC3lXZ628NUfWxhgCwJHJUNdF22an6p3ba4ARM5inSM7tFk9tvWT4BbU/Abg/Zdt53ZS4ooLDFHPV4plP2C59XTAXJALD2ZTuvVimww9YbR4ubimqeVZ9leKUQ69Veh91YgA/joLW/446WIKcQA126DkWOrckRNjNsNSi1mCq6jBAuUIQ9MCW4gocBw3BQGOQ055+QWsLV4V5mfTh2pSin1k/AZVpqgoRKdX4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1LhvNH1OGbP1fETUk2FltJbgLwx1EM2kRcECiWyQII=;
 b=xN2rQEzVW1fZnINhc5rhbIuzxcSMgqcYE1EtDyemEwXfyrQ+KBxkCedI+gYUN33K271hgDFnnMYLdkchljaBhVqCp6Ik9mFRmgx+pXCminqctUlcUqZ8SfGfAEFFjwPVAk817gyerEnjGD7B5g9tzISG68ArQGq7kGyl+pv7i3ja4zB4T08om4AzW++dw9mHkpgxRkGsGkA581G4y5zBdkTtD8FVdTTID2NxslXpyfDZfwQfpx4yWzL4f3Yqf+NQcbdUPeoQFs03bbhnnmfrJ/PBdeCvGApZsUQM0CPmFzIkTL3gbsT6YiANdTTb9QFQAK/Mm/rJEQwYMMdHtl50+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1LhvNH1OGbP1fETUk2FltJbgLwx1EM2kRcECiWyQII=;
 b=uSUWRY8FoB06oVJaYGrfzaZm2hLL1QwQy7A0zMeAUCoH6UTsLqmt3IfLUDW9tj9DFay6FBI+iUQ94Y1ASWmLofU+RaB0oAnVVzREOBV7qWPGxQxi63CqAtWUz2I0YiH3Ymlu768DmU5Ecd8LAZRKrIJ5lntfalwMJXu6XeNWnFAhCdxnLpOz3SaikhLmSzcZAh7nhsZvGUTARbm+YT9H4CJGgiVSheoWjMSaGNVKQacczH93UV3eTJ+kztjJLgUocH1EEkY8xb4TRLwTw5Ns93X67EFfw1tAgDHS/YOCKCJjtGlERicI6eFAkXCkyT+KFyem14GHFWfLM5mBMdyw9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 09:33:35 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0615.010; Sat, 14 Nov 2026
 09:33:34 +0000
Date: Sat, 14 Nov 2026 10:33:26 +0100
From: Andrea Righi <arighi@nvidia.com>
To: thamrinjonathan@gmail.com
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH sched_ext for-7.4-fixes] selftests/sched_ext: Measure
 rt_stall runtime over sleep window only
Message-ID: <avgq5uoA1hXkZg5P@gpd4>
References: <20261114-scx-rt-stall-v1-1-4188a9378067@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-scx-rt-stall-v1-1-4188a9378067@gmail.com>
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: e729afac-5d3a-4f4e-d90b-08df42325a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|261022075727099003|261022105027099003|5023799004|10067099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261026140227099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	f8KcKgdDDZKtSpc22B5OeJdDM/Gmi3yN4Fj5wZCdjxdqRlpaXLarFd1EtF7r0LyRkN0g4fz7aRecHWi32kiYzXWfyjTD78JFoU/qFBjB5PAJ/jE7CTyvKPqLNu1M4E+ODWjo+LFJ7P+vLQ7x69FLFYh52GvSXa2WLnuIVRQ5Io/9oK8/+onwSLooGBRWWL6CQpoSFDJo2xOfc7hy5xqHX4mJgiemQ/VDt2esd+ug0jYtVDzmu/aLejIYfARfwk4hqgptWauGQeShqlc6tvVicfkKpgAj2rEdYYtKQ+oNX/fwiyA4BxQsDN+zbe3lAy2CIPl4SDfjNhxZwVBPwp1LwUD+7V/afUpLrBTOStqZLDed6k5vK8tH7qnQfzjuPxPVH7Z3QgY8LhHQEU9Nv4Kw/dKvOzqRzmqjGNxjheuBYrVrdyRTs66nPivPq6XFx8R5B9OIkuhLByIZrmJ26T+P0sW+7N6S3W238+OD+MKrpkka/dFkErxNV56A2ezvYjaO9rZzCCpWx+q1CzP8fKQqprJwAyjRsL02jJEn+aEC4p3NAseE/kY4t7NdiF8NxYDREtz01YQKHAttCL2lGmjXhXGhrUSZB72E34hYppsIjCqC2YBWhZ1kjGn0OGfplUm+vPJtyeIUzBv69SST65DJLzJ8WZnWnylshzwno/+Sy0g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(5023799004)(10067099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QMURXuty2TOyQJsdtDxmK2Qr0Vh1EGIftHq4YIE8157sgolIZGufqeW/KoxS?=
 =?us-ascii?Q?vCjuRKqE1aUvXpW2LLskzKECPiWo+tlqUL8VbB3oNqQsMVoJpRVqMkq19NpH?=
 =?us-ascii?Q?ABh6mKkAIFq2nAdVwl1hosLkZNDcebvZA+UH0ka6QBHxTZ0MnDydPao+aGBH?=
 =?us-ascii?Q?8pTwXHYch8/QQVoE/nLKr6rTS8t8YPHQOOF5WG5ZQp/VIRVxYmdZHSeDuAC5?=
 =?us-ascii?Q?PAgZUg7ffqe0TgsoYepPvTxHtAKcGoxHkSq9kxP8YrS2kWg/GPvx9zSvzbng?=
 =?us-ascii?Q?LcjAGerxMCL42/O4Ow9oZQfvMTFR2cWWfUppuz/SgJlE5FGP2YsSaCEgJRRp?=
 =?us-ascii?Q?+iDzxbvY0+smTehSTKEggwBOgVFGK0s+c3YoAT98sOw4nhg0BSy40zMqmurY?=
 =?us-ascii?Q?ou6TmfirAfXjfFzR8SUE3HuwG+OxHWmPzdbkiqRhC7wXEna+6E8QD+u6tChq?=
 =?us-ascii?Q?KhfSsHbZHWTKowlVg1KuPgUYAk4YOWhEsl1czthnZEermPd8S95xlBkX4pk3?=
 =?us-ascii?Q?RwFMXEInD2KV1yU//F+KsWkgg4WX8mfqcg7T6pYIMMvQmZiMIQ2vIhhJSLS5?=
 =?us-ascii?Q?GTDIc9TMxxfxFgiYrIEl4mBy4U+2kM6F8r64X/muPKwQXqLhr9N77ogS/L24?=
 =?us-ascii?Q?pq9eC4oUpEMnGPHHkoV0l/345FNBadIy2alj+ZEXQfl7RCx//EOr3lScjNE4?=
 =?us-ascii?Q?d+vjgOLuoSId07m+OlLP9r3nu5bgTlgTUZ8qXgzYLt6WTn+0f+MeKR4m+4Di?=
 =?us-ascii?Q?Fmht5DkWuVJ7skVMXzLX9p2Ct3ba/JtJgK2+rpOp0wp1QxYxUyIGS2fuaDqj?=
 =?us-ascii?Q?mCnGq9ozx+eThffldlM5nOJfQ6BGJiaaZCcPJmScnhxfSrahAa5xbyW3T4qR?=
 =?us-ascii?Q?Do60wpADiXLHcPplKoPm/Ip6gEHp/MFEsWLQ7mIgWlLWRDOgUr1vxiIEJcAf?=
 =?us-ascii?Q?he0m/2EdKGiuWEJNRzYbLdK80WjYCL3fhB4QOLaeG5KxiabVPbgya8OUsE5J?=
 =?us-ascii?Q?AVVs/qIMp7XdUjdtMxy9fgHX2w1sGcirl9rBNxBTPsKxvwziff+e7grXbL6S?=
 =?us-ascii?Q?UhX9wBnR/JvW/BQxaLlUASPQl2pJFiriwk7ijDwLOaC4CuarSUQpDGNpSTES?=
 =?us-ascii?Q?IPvFWMb3iE0DgJHRjXRosQrJqPhzfPv3jtuDgRK+L3QZPqB0qzBHArJ7RUNC?=
 =?us-ascii?Q?QIQeSlVyfOYQmWY+MZZNjysodC5O2CucCovBVbC5NBFpCyQ2YICUXQB30Bk7?=
 =?us-ascii?Q?wVa1UPQJV6Z4Eav7OrOV2lWa+RI9ovdXCiqcArrLcZJ/SkkunmP8A9UHq9ce?=
 =?us-ascii?Q?hBjtTNQaL8y+arO4ZNC7QJjueyoGNv7EuObuST59z8KlIB28rVKeg4cmO8Bv?=
 =?us-ascii?Q?nrLmhZYDGxGp4ZF5t8rAepPUOlQ239oGZwgOOaSuwBz0EbJB4hWJJs3mmF/J?=
 =?us-ascii?Q?iCH20lGCXfGDabRax7A5akUD2ecP7WZq1c0IaAQ28WbLtlP72BF2vCjB0VZH?=
 =?us-ascii?Q?fBt7saekLTbOHkGFTBZCh/89bW4tfPUCCPEcLzLaPYJnWBr+YqaSAeQWVpsP?=
 =?us-ascii?Q?wUfVynycRB53RGXU95Kmibmf+2eKrlNOro/+ZtoeAmhAwP0HpsvWE4XWWSlx?=
 =?us-ascii?Q?wxMRSbC/V6qGpH4JC0wqE+xu+MZ+jZge16waPhAYuLd07ASqTBldmfMjKVrr?=
 =?us-ascii?Q?f6r4+aRdRhLix7a5MOWn+sFMDZ2mpqxkJON1wgmPWKbizR7g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e729afac-5d3a-4f4e-d90b-08df42325a52
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 09:33:34.3827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HzHyWoZ3OkJN415fKnpfPQin3nhIM3wAu2OM2dkAufqRUGdgsvjlsR3DEn9SjkgQQGX4VXrdOPUo/T8NSiTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

Hi Jonathan,

On Sat, Nov 14, 2026 at 02:34:26PM +0700, Jonathan Bastari Thamrin via B4 Relay wrote:
> From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
> 
> In sched_stress_test(), the parent can be slow to start as it has
> to wait for the DL server before reaching sleep() while the RT task
> still runs. The runtime of each task is read as a total since fork
> instead of during sleep(). This adds extra time to RT and makes the
> ratio inaccurate which causes flaky failures on CI.
> 
> With the parent pinned to CORE_ID, the RT task had already run for
> ~0.95s before sleep(), so it was measured at 5.69s in a 5s window and
> the EXT share dropped to ~4.2% against the 4% threshold. CI has seen
> 3.0-3.9%.

I don't think this fixes the flakiness completely, in two of the three
CI failures from the linked issue RT ran less than 5s (4.74s), so
there's nothing to subtract there. And in all of them the EXT/FAIR task
got only ~0.18s instead of ~0.25s.

My guess is that the test is flaky because the test task isn't the only
one consuming the dl_server budget: the 50ms/1s reservation is per CPU
and shared by all the EXT (or FAIR) tasks runnable there, including
per-CPU kworkers, ksoftirqd, etc. On a noisy CI VM they can easily take
a good chunk of the 250ms available in a 5s window, especially right
after the scheduler is detached/attached, which would also explain why
the failures mostly happen in iterations 2 and 3. On top of that,
utime+stime are in USER_HZ units (10ms), which isn't negligible with
~0.25s of runtime and a 1% margin.

How about something like this:

1) Read the CPU time of the children with clock_getcpuclockid() +
   clock_gettime() and use deltas around the measurement window. This
   keeps the part of your patch that is correct, but without the USER_HZ
   rounding.

2) Pin the parent to a CPU other than CORE_ID, if there's one. The
   parent is also an EXT (or FAIR), so if it runs on CORE_ID it consumes
   part of the same server budget, adding noise to the runtime measured
   for the child.

3) if 1) and 2) aren't enough, slightly lower the threshold (e.g., from
   4% to 3%), to account for the server budget being shared with other
   tasks on CORE_ID, while still being strict enough to catch a
   misbehaving server.

Thanks,
-Andrea

> 
> Measure CPU time right before calling sleep() and use deltas to get
> an accurate measurement window. With the parent pinned to CORE_ID, RT
> measures 4.75s and EXT share stays between 4.81% and 5.57% over 20
> runs.
> 
> Fixes: be621a76341c ("selftests/sched_ext: Add test for sched_ext dl_server")
> Link: https://github.com/kernel-patches/vmtest/issues/458
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
> ---
>  tools/testing/selftests/sched_ext/rt_stall.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
> index a1552b38a6e8..0c6403d25298 100644
> --- a/tools/testing/selftests/sched_ext/rt_stall.c
> +++ b/tools/testing/selftests/sched_ext/rt_stall.c
> @@ -149,7 +149,7 @@ static bool sched_stress_test(bool is_ext)
>  	const float expected_min_ratio = 0.04; /* 4% */
>  	const char *class_str = is_ext ? "EXT" : "FAIR";
>  
> -	float ext_runtime, rt_runtime, actual_ratio;
> +	float ext_runtime_start, rt_runtime_start, ext_runtime, rt_runtime, actual_ratio;
>  	int ext_pid, rt_pid;
>  	int ext_ready[2], rt_ready[2];
>  	bool ret = false;
> @@ -201,6 +201,23 @@ static bool sched_stress_test(bool is_ext)
>  	if (!wait_ready(ext_ready[0]) || !wait_ready(rt_ready[0]))
>  		goto out_kill;
>  
> +	/*
> +	 * The parent can be delayed before reaching sleep(). Record each task's
> +	 * CPU time right before calling sleep() so only time used during the
> +	 * measurement window is counted.
> +	 */
> +	ext_runtime_start = get_process_runtime(ext_pid);
> +	if (ext_runtime_start == -1) {
> +		fprintf(stderr, "Failed to read %s task runtime\n", class_str);
> +		goto out_kill;
> +	}
> +
> +	rt_runtime_start = get_process_runtime(rt_pid);
> +	if (rt_runtime_start == -1) {
> +		fprintf(stderr, "Failed to read RT task runtime\n");
> +		goto out_kill;
> +	}
> +
>  	/* Let the processes run for the specified time */
>  	sleep(RUN_TIME);
>  
> @@ -218,6 +235,8 @@ static bool sched_stress_test(bool is_ext)
>  		goto out_kill;
>  	}
>  
> +	ext_runtime = ext_runtime - ext_runtime_start;
> +	rt_runtime = rt_runtime - rt_runtime_start;
>  	/* Verify that the scx task got enough runtime */
>  	actual_ratio = ext_runtime / (ext_runtime + rt_runtime);
>  	fprintf(stderr, "%s task ran %.3fs, RT task ran %.3fs (%.2f%% of runtime)\n",
> 
> ---
> base-commit: 0021f17128de5dc0b19f1a523f448df2440d8088
> change-id: 20261114-scx-rt-stall-ca1767a8ab4f
> 
> Best regards,
> -- 
> Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
> 
> 
