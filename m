Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993E4A2E1A
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137555; cv=fail; b=Mci/Z6hOfrAD5Vup3OL+k6Nf/DlrqAGoFNifSYH0juqnvHP6hWrO1sWhUkcaVJP2FBMuZniAC1gXiFUyvW/Vomm8O1fmue2+KeRVQGzaJr7wSU9GW/8MnWGa3Zuygk2SZbalLETPkvIZf5TC5Q//u5N/UPwOKSv8MbtLMtnxNGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137555; c=relaxed/simple;
	bh=13b6kodwVAXw5zXo29sxlr1BuVn6shFCASsGzY9M7wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O99o/eDyHf5Vf03WoCVEGl14pSF/QaS2iMHAKufwnyBjaq31Un4w7I2E7/b6i6OMjfghJ+xaGWBsIWus+7znaJGRGow9bBj+6mGsxE0866Fzv5aGOKomREwNu+stJagCseYw7yoPxJtBN+yreOyAyZGF3TIdjj25pQqm5Rr61yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NBD9I4s7; arc=fail smtp.client-ip=52.101.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NBD9I4s7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfTp5Ik+hC5bnm16DTwLNwY0xflxfVpKHtN0ICWMJY9EnCS6Da7NxGekV/AGWSsmzil/8haXXCOPHSLvsavlnhXRgr0x/+Dcbq5MzE09DHg/lhbMIsjUKhWiebVyYwU2jTRmy7WQrwxaKKKAQxF7lHh8jr6P+j6RDv78TYRtPgCZ6v8Hm0SRnsKQUm05AeC39KzNKl2cJ6zaCegSV8t6eEPwN+ANSHj0f74OXrRTUviC1lk2rsNhkdy62/mKS9j74tWz63sF7iHxbvle5i1VRCMDaw8dZj5mnyr0JRRMdILTjukwwUwl3Q3Bwe8gcsRw3d65Fv0onydMMrMWH0IXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsCxRlClj4naZR408E7NU2mhobe4zRWf2xqZUD8yesU=;
 b=Ap6ZoO0TGuF+Qg6J8fQqFleZhD/IVjhofmkQ7vHH7DgJVGLzwum0s2ZgDeuqRQSBpgj7g17rs29YY1Tp1vE6uAeXxe1bBu6RhDb2pSFtLskuizY9l3bDE0sAmctH1/v/QwS0dVWFQnlwXfa5I68LYg8j7vjLsIFhDAccWs5B3S8DZvJneQ8JT0AF83JPjAAsAFkdqJ+FRUMMITR8qDFN7sTJc3M1PVXNIaKpWMGwElEDTycTTLYqGpKE8QWF8kSeVa8N0gdVtV4B1tFV2NmM8pImi2R2RcuK32NrB0syDYAvx98CL918MkXufLxlCCWMlEtXS0vLbQ6WeadWalL2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsCxRlClj4naZR408E7NU2mhobe4zRWf2xqZUD8yesU=;
 b=NBD9I4s7W/dOSAGZJqo3b0vwOZv3xj5UKxuwLCAGW1WlrZKZnh6vNeRHa3ve5erNM5a6ceCluBZhCNTZRoHkox2+90H/dM+2w2L3YEu8UvDO5bFzXhzyqt7E52kRKnMVAcmSFbf7yo1VrzvdKMMLA5HiGhc9yGNIqaK7Xi65UlgjBkXe5TI6t4uvm/NgMMm5U+mgKFwwd9ZhN2BVbGdukgxdIQpJ5S/xWrGknCf8utAGVij1TDCxpChJxQQWilMGZu5I+BLM8oyEVxN7vc1zfE0J4Cnirk+klinFpY7NubU4yo30KQ+Kfeae7amdUBFAtcGi/zaMi4GsYoW9CizRrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 17:45:49 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 17:45:48 +0000
Date: Wed, 15 Jul 2026 19:45:39 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: Sub-scheduler follow-ups
Message-ID: <alfHQ94yxJpPYe0c@gpd4>
References: <20260714230917.84158-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714230917.84158-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: d63a4793-956e-404c-4377-08dee298e7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C7TsesHwyIIocOVJiHQ7nMzxqg4QpsnLFvjf8f7OYEfqFc1KhXmTBM3Dmcd7lqkWctAza9vBEiYnwawz4CIFctdXsM0zFbLmL0ioM2e5X4HaCctgQMmek1fMiUfL/IuZ+o68+ieCT6yrN+gm9nz7I0V2Nq+ItJ4AEIyR2svOhxYZ8eFK1eOQToyte8wY9QDAOriOtn0jGOT4e/EmTbrJTCr5GNhL/B87ROQ1ijj1UiPLlXNDA8qec3pbZk8tDQCt30r+Rbe1CFueSlW4/XO3I5KwfS0wjseLENA0JZN7qC38bi373KLoEWLCbyIh+SjgUy+R1k9ZrepcgqBx9pskOsddntFVAuG2lItgMlhiRD0L1C3fdAtXwNuQ/aW/pQk8rLU6PA2qMlmH3u1I/nNrEnzCvUyd1Dx1A6Roxg6JffX+Dxz7mtSB9wLK8kl+hVV7cC62pzhGbKLnisNNt2QAUZg0hCBq+sM8xamOVjj24lSYCHgYcw3r4G3GNXqCYXtIR09niJzwbHVWa40nxoQ3631xcFY7iZ91NSuoqEHjLMraYK7gJlbp1FAsnjLz04C/yYttlxFCOgVTmcLQ1kdzXYZtaGZwMt8IWwsdmRZgoyBhojaOv0ydqeHcvrxmqsFSucVZlTwnF4Fb18JQ4cJ5XY4jIPA04BM1/xzeUtNOu8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sE6+rGi98AMJ0pCOfCU5lbkBCuUUXO/zGrlPydYL8zGusvxHGz1MLS4ko0fD?=
 =?us-ascii?Q?WBolLxJVR/NvwqpEivCaFhy/GF1Q1Ugz9e9KulwJyDZ6SSA1mDH4D3+zIspA?=
 =?us-ascii?Q?JOZJTDUxAcNluGjgiL6eEob3X3AGjNRfkbV63TOzons67SKSqg/JjrOOn44u?=
 =?us-ascii?Q?upV0SJ3d67eNhwxNES4CHgjFzmv6yHKJshh540ARdWK81CI7cD7GdNoVNT+b?=
 =?us-ascii?Q?gyYy4Li+uhymCs+0WSje51UveqhLyPe0nDYrtp5AWzebJzGqR3KvUMAi7yPR?=
 =?us-ascii?Q?gKlhlOHWH6vfa0ZXZNbU8y5wTyBMILc6TLjUncpu+S+Rm/qVNCeF9TNknNoG?=
 =?us-ascii?Q?i4b2OhB9SYkYKV8wJdanJhFdDncqruHqp5HEVqomJG8SDYKOwuPvlTVWphW/?=
 =?us-ascii?Q?t7CYvHviLfN19NXk4aOk73G9cPYKDt9XMyFMVGgJ18tz7OIph2AbavHDhdhV?=
 =?us-ascii?Q?dDJ33dUUxuzaPXatU6v2UwB5ZGUg7eswo6BvQl1KkcHm9QBUgnwapANOSyGo?=
 =?us-ascii?Q?WOzFiaut9GTD1m0XFt34tD4g0mSepiTXLwcyGSisKqC+HmTpedeoSU4++/gx?=
 =?us-ascii?Q?5HV0SYn3w8hGq3X3/l9lUZukaprKWIgRtz9rmAIlgW/UMkGgNmLTIbvnn/n2?=
 =?us-ascii?Q?UVayP6LufcZujeXfv+3O4T5aTlaYkCPUpOPLNAOlsmlubtzkBDZFwhmnxmoX?=
 =?us-ascii?Q?Xl6+pLH3tPFuCxY6rq2mzm5HA+zUTKdyuLocaAp5oMa66On4KKKJnkk7nAqh?=
 =?us-ascii?Q?y9PpYqRYiienMP7+a3XgDnfd7g710X+hGDz9LSxIlJiiWEHzNjUIFfKvOSkU?=
 =?us-ascii?Q?TQbAMfh/W2s46Ga0s4wPoGaHbsj/OEBn9MpVubi7fyMVX0YMPjcmIJhqG4Jr?=
 =?us-ascii?Q?FVDeAPe+nG03VJVIs4aM8K6V64I5/GtoJ5K1KGcRTD8O/pqX39uvBP949kSi?=
 =?us-ascii?Q?6w5Ivo4DFWf5UkwASBs3jkg9QK104yJPquCehnH1jeFaod9tDkv4JfZtfzRA?=
 =?us-ascii?Q?1LSwcSagSPD/4uLZqgqJ4AXKnu4ND2cMnwGyOqYeGD43UESW+w63JaPzTC6U?=
 =?us-ascii?Q?cPN7LYKeU+xAVcS7vGQux761iSegy5jKGwEG5HA1vM43PqEKrFO76Qo41oii?=
 =?us-ascii?Q?k5LYPFYidRElZ7ffKPQN2jADDuQe2u+mFfo9Wk81R8Ne2gX5unAOkOWOUjou?=
 =?us-ascii?Q?sDlRqepKATj5dZhK6R9bqsTrE8rtJRjzQBnR3bRKpKIHjP1I5mgXUiWWokyz?=
 =?us-ascii?Q?HMMUAddmX96p7M7hlyqQQsgOEVkKXtxCUcKX0TxLWqeIk71hHZ+xosUSllrV?=
 =?us-ascii?Q?ToFfzQzhlUrPzTt8uLUx0GvUJT18vGxMx4gTUyiG7vTs7CCniPedTcnSc8mc?=
 =?us-ascii?Q?0nFn0TS/fB28hp5lG6JT8UkyYm7bA7vrSA9OZ4/Mv+DdgUUp179mRSrt447c?=
 =?us-ascii?Q?fbRwzV7IQSS9VjfHuEczAu+ETk+M+NJ/KXjy36ojKd4YX7RzO0kZ2o1TafaR?=
 =?us-ascii?Q?JUN8QZOOSvJsglswt3x0PcasFO/xQB/8S8I96nUXBR+qb/PTmBaZAH9jBy1A?=
 =?us-ascii?Q?uoQTN3c9NhIXhhhToVKGobttrFkz9obJJXcpcMXWsw3zojAnvgBz/B3ty2xM?=
 =?us-ascii?Q?rN0eqoSaw4hB7lLNYC4PUf01VBP4hpreOWvoNdIKlRuvwkGZ6Nn894oEddRi?=
 =?us-ascii?Q?XUxXN6NCEjDxR+K13ZLgnEztBco9BxYzOru3/7BrjzgynkQM+Kn5oUKrnqxT?=
 =?us-ascii?Q?EYIuiJqpyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63a4793-956e-404c-4377-08dee298e7dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 17:45:48.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc0SXacJQqLIk5Cqb6dpM/KSK8omKH+7ZPzK7TZawr9+kl3DDMgznQHoGejnHFFhbpxou3bfVsfOm+v3SCGU7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999

Hi Tejun,

On Tue, Jul 14, 2026 at 01:09:13PM -1000, Tejun Heo wrote:
> Hello,
> 
> Follow-ups to the sub-scheduler capability series, addressing two things
> Andrea raised while reviewing v5[1]: sched teardown drained queued ecaps
> syncs with an msleep() poll loop, and with CONFIG_EXT_SUB_SCHED=y hot paths
> keep paying for sub-sched bookkeeping even when no sub-scheduler exists.
> 
> Patch 0001 replaces the teardown poll loop with direct removal from the
> llist. Patches 0002-0003 are prep and 0004 adds the scx_has_subs static key
> and gates the sub-sched portions of hot paths on it.

Thanks for addressing the issues! For the whole series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> 
> [1] https://lore.kernel.org/r/20260709225041.1695495-1-tj@kernel.org
> 
> Based on sched_ext/for-7.3 (35f9cbbacb67).
> 
> This patchset contains the following 4 patches.
> 
>  0001 sched_ext: Remove queued ecaps syncs directly on sched teardown
>  0002 sched_ext: Move scx_dispatch_sched() from sub.h to internal.h
>  0003 sched_ext: Gate sub_dispatch_prev with CONFIG_EXT_SUB_SCHED
>  0004 sched_ext: Add the scx_has_subs static key and gate sub-sched hot paths
> 
> The patchset is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-followups
> 
> diffstat follows. Thanks.
> 
>  kernel/sched/ext/ext.c      |   6 +-
>  kernel/sched/ext/idle.c     |  10 ++++
>  kernel/sched/ext/internal.h | 133 +++++++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/ext/sub.c      |  88 ++++++++++++++++++++---------
>  kernel/sched/ext/sub.h      | 124 +++++------------------------------------
>  kernel/sched/sched.h        |   3 +-
>  6 files changed, 223 insertions(+), 141 deletions(-)
> 
> --
> tejun
