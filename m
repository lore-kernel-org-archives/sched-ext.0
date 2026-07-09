Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EDC3CFF5A
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629570; cv=fail; b=Xiexl9ZmOk6MudOf3n48IVSWB+dDAQPKPZQOt5Fnoka8Jbfl846Ng8k7FfOxS0Fa8Edo3udAlETFko4764hsOxl6KcEuyrcRBO+DvCQ5fE3PxK1oulwq9cF7aLE83AGpmEw5PLZL5tQSNvlBDwZP32Va6gAocPjZAHboAGPlDSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629570; c=relaxed/simple;
	bh=3Z7iKk+xm+Uw8j1TgnjrDOKEftvPa6rElzR87zMiCv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ET9WKcmDvW8BuO6S8Jk+JM0Xum4Rj5dHx4nz4PNk3ImPW/qwbRGmsSxNqyRPYImch6S/Nqv/e3Pe7Tfo9nb+asU6GlCG7xsBwIgIVr7h0ZhCp3vFLMoFuKzx2aJORTuba/7dsnC46ewIGyIl1TWwf8o3i3Tw07SnrVFsMK6/U3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3k1CP/g; arc=fail smtp.client-ip=52.101.61.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3k1CP/g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGLq5wYMT9C4SnGjfKx2Z2OXPZ0ozvM6Ui9hXhcK30b7ss66Ehb8aYC4PdFNbPElc/iAJjwNP0agbVY0+oVQG7yNLLlkssKBtTCnbP2xj1ytr3TgP96RVBQlVhnm6BQ6buDtZzedMTE2bWODktIteOXg/014tV88kbS/8MMl8+tlRqTqJLxyIEmYQTFCaFWdEwcIJ1DCitrjpGL+Os++1kcdkInm8LaoyBto3O3zSWcQxtPYCZlDpJIQY8E4AZ11zVs1FUWVyfw7Fj0xiMPgvoDdYbD1lSt8W8kSKMDHOS9FdHBSHgBLXqTj7BE4ilt9NDm53GZZllT1STBKUYVYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDp/kjldDVvgr3NYpf7wi0jiIedbR/6XYQh+nZGacIk=;
 b=OXOTDQf8NIGq8NaUo8mYXRApqZtticXPkp4ajMIa8DsUPSYe3a7Jn1+6/e0giReHBWJDXA1ss0axJMg5xq+mwbK29UxIvEIvFhjhqrrWlvmc7BFMyAlEtL2WLgMPkkk4totT4jBPx/+YziE6wbNP4/WNsufWzpDTptYTtRTYwYmPElLlfAgKDnkMjUhmpkftApna2jt6i7Yg7JRaGzMYS5bEkBjAjqxBqAXZeYQsPWE40WQ+aNpAgmJrcRIWKgrIqGzKR9nNjr/XGfCvtN+lOh7n5GK+alncaCymOfxmRASiMXZcNqJe0LcGobhnU+X31lb7sSEr1ADNpZLVjv/+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDp/kjldDVvgr3NYpf7wi0jiIedbR/6XYQh+nZGacIk=;
 b=e3k1CP/g+FQlQm1xRfAm7f4ViYp4fsWZLaXHx0D5SL2xzZz7dYTwttCkYiOr73gDr7DeI0GGb8OczQjbWqS8IB0t/e3Ap48KG3lKvD2kWl71vuql3pOx/E3A38UdnYmsLV3TuqQfi/W/pbeJu0KSw0Dq+XPvjVYwIwTZGHHrJdt02f6vhBjXPtJIC20py1hJHFmsIbiBh1h26yGhbd+RV/ScUPqQ5dnu2rFSq3CPuTsvROV9zn3yaiQZpVbK5GdncDfsEOK0pUFfZCOJjmcsomH3Jl+k4I+L2tsdG2W7A9PMrau/PUfCiIZfkYPK52HjV2WVVxbM67T55Do70H7nxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 20:39:20 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:39:20 +0000
Date: Thu, 9 Jul 2026 22:39:11 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 03/40] tools/sched_ext: scx - Fix
 cmask_subset(), cmask_equal() and cmask_weight()
Message-ID: <alAG799dqY-mJPAh@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-4-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c77fa4-0969-4da7-aa04-08deddfa2737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	uxrIvBe0tx322A2jJPMCLgofA7dEXiQac/rdUSx1YBgJhgnohUzp6CH0vbXS0aoE06ygr9kgpgVsqKmDiBkbvijRB7PQ0hFjJh8C4E0+yR7eM/qc23q3d9A2T0Vv+xiBx2X46tta02KIJ/LpnUpOZqGTJ4KuJt0xugddRPZDiKJRcJIVi7pnj2AfDdfxfZWmsFLaoKuIh63yBdwSTKuL1VoIkcLksLqE/xIHE020gy/sRo7eIihd7MQTx9EaeuCzXhirCBm8hfHkLEwvabKcmmFXOO5cgE7PrqtX230zTe07r16Hs+E2phqPiuyUqin8LNJGhjuZjbagz5Hs+CvORAqjVLsFsnwt7aHkv8cNyyXDM0eB681NnW7xDA5eSPeP18AB+d6wWmhRntuiuIUPiQR7rEk5kHg/ZL5FI6ZSRvaMdsEJRtWGSjlNlh9lhQnU6/atHCaaSQRtodyH9Yt7Um5iwUvE4I6VQVGaHq90rUPkths1dMEBfWuovsD9+DgYyuqMroaE0uayTb9Kr5iquFppvQUHtyt714dPke/S4ygBid2W3Va/CORb2A7n93ulP+jmpVcrSGk8+peIvjLBF/KEYdvs3ttj2b7N6jj7xE7AOZnRL/RVN2UrNlA4Azq+SCqizPkhTYgLDD0/MJn/6Gggj0I1vajEr3Er89zX0Zw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pFzz3ai67Cf02Zp1DYjLLBkWyWve4rabjyqneW7CDZaQReckwwgWyAtdnDdM?=
 =?us-ascii?Q?g0Lgxd4FFkFNfU1HjQD81ej6X0HRVld7LHLV/vkH6fXLzbY7CPaMX02NZIb9?=
 =?us-ascii?Q?JNAeKD9t/Hsv9DFRqLNgQxUAljUyi1Bi8+6gel+hpHHkONSoPMRfWIcFdDhS?=
 =?us-ascii?Q?G8WUegvjfTWfTukGg/gZe1+c0bDPG2hRNLsqbb2FpfyiWggd7hM3nuqAhppt?=
 =?us-ascii?Q?EKg+dcId6xa8TSm17Z0+EBfGpu1DENfmkZQ3kFsO0ifWeLOhjk+uh8iWTd8y?=
 =?us-ascii?Q?4TkcVnvtslgDLWgfB69BMBJZjzK6WqlLdW1CGOHR4LAoQsBZfascBHAgGN53?=
 =?us-ascii?Q?W9G/XQrnHEQ4e2Cf9pxHeMoEiwGvrpZmvKB20YN3EmecB/N2FQ+x8NokfeYu?=
 =?us-ascii?Q?NdpxTKLDJ8JD9Z6diVmBBFJbIUICtqtae431PU1/qXg1DYnVRIBB0/GwXsSl?=
 =?us-ascii?Q?4NMB33LrZGTXqMEvNCUP5s6LtD0wuVkd9Ol8lrHlS7VpwGUQxJ2UQ7MYbPd1?=
 =?us-ascii?Q?TazHHYK8jHWVCIgpf+dOH4F3kjcXoVtOLfuC7/jdceK1iYxOR8SfTvtL2FEN?=
 =?us-ascii?Q?qmMZNhqObRpUSmcVGUuSikiPCnIEQQPByuuqF4eqlO4gAx5JcyaPw5W5ymyg?=
 =?us-ascii?Q?QN7jSqUSxVg4iYOSi/aMf65YfL4K3lfmN4LBFzs7Y94Le/p229kBklqmdp37?=
 =?us-ascii?Q?ZwjibwDOvVbNXmUlp+dBKXbjJ+K/eCX7OjKbOjWAyellddWB4jhCngo7LF4b?=
 =?us-ascii?Q?rgfxazJOaxRIMmDb3Hij5td/YNNA4mr8dGFt88+KuGKq1iHlg6qG/Fo//tj4?=
 =?us-ascii?Q?tIOHPKPaZ5kDcsR4dSftF2hUZXOEadolHKmnUewucgUY/tl320cnRYzbEqSQ?=
 =?us-ascii?Q?wamZXmGkVIRr36DmYuGvu5lDHUnqOcrBVvk4OJog6GR+ihWiwnxygbsseJ9/?=
 =?us-ascii?Q?8Aq2rsJbTTD0VZpPv64ZBf7fsOsgjHgNmm4EtaHlyERJp711uu5Y7896ZjCK?=
 =?us-ascii?Q?KmqzLXVZwI7QgYdoq4EVOjbDX9y0oGXhGoU9Lgd8+yO6XxDnJRBB/BeFNQKN?=
 =?us-ascii?Q?nh8FM3hWKwlNC2pBIE5tAXyh2yXlx+JL488RYL5eqA2Wf1ktIeh41BZti5D9?=
 =?us-ascii?Q?TN5J42jl5L/I6EzyuxWwdRh6PuXTFepKWuZWhVR9VHlHKcWQsPG5Zq0iPQZY?=
 =?us-ascii?Q?G8FgvzZNLffr0SeQZ+14FyBTt+GFQtnAuJV4BNAVV0gj2GljEBtIFelFCSLc?=
 =?us-ascii?Q?pZC/DkIqO2SD//nNSPTI7IfIOZhVqMrwNKaqZXsKQdtZQUqADpTR14Fi/BAN?=
 =?us-ascii?Q?M54oIi9puIfkYCT0O60UzOLl+AYNMSJ+AOLuXTDXr2gWWevHZ/WF/95uIkov?=
 =?us-ascii?Q?Len2xrbatVYmKPUZ4kAgr/SPX3HqS2d2INhtuHUtA7xuXeXqSwJ1GLt2hDwH?=
 =?us-ascii?Q?J6a7Dq9Cu92HvRnT6CrjYxye+MCCCPTY73J+tiK6eW7t4v1WNOd0jYvDPS2r?=
 =?us-ascii?Q?X4qagPX4HszmaMXpv7Unvx060J/W6qgK3dJQ64OQAPF/1/ZMZFVG4oa64eA5?=
 =?us-ascii?Q?yPVeEQmV4oTDcPkumqU9VN+JaOMbYFLJv02L8ZTX8Uka7LCfbRrxQ5dwCZfO?=
 =?us-ascii?Q?cnd11mBGJr/927KPve0wD/7waHhZQQQzkqqBRR+XMVSLePxTC5knCbxL8p17?=
 =?us-ascii?Q?tOPWx/pSBbh2fbc537egPK/+tMalPXtkznqgrR128qaCPtXNuHXHPHrURd7E?=
 =?us-ascii?Q?GOQhm8lMrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c77fa4-0969-4da7-aa04-08deddfa2737
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:39:20.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/+iQ9Z0nPPefqfuqNXr78KniXeiy7y/MjDLBK8lR6gxDmM6nvuC+zqcUnWCrcF+tGZozw0OwxPq5oB5/c5WWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487

On Wed, Jul 08, 2026 at 11:23:52AM -1000, Tejun Heo wrote:
> cmask_equal(), cmask_weight() and cmask_subset() bounded their word walks
> with CMASK_NR_WORDS(nr_cids), which pads by one word and can't tell the last
> word in use without @base. The walks could thus cover a slack word past the
> active range, which cmask_reframe() leaves non-zero: a stale bit there gave
> cmask_equal() a spurious mismatch, cmask_weight() an inflated count, and
> cmask_subset() a spurious violation. cmask_subset() could also read
> @b->bits[] one word past its allocation (within the arena's fault-recovered
> range, so harmless), and deviated from the kernel scx_cmask_subset() by
> failing any @a range that doesn't nest inside @b's even when the overhanging
> bits are all clear.
> 
> Bound the cmask_equal() and cmask_weight() walks by the words the range
> actually spans, with early returns for empty ranges. Rewrite cmask_subset()
> to match the kernel semantics: scan @a's overhangs for set bits with
> cmask_next_set() and walk the words of the range intersection.
> cmask_subset() moves below cmask_next_set(), which it now uses. Padding bits
> don't need masking as every cmask helper keeps them clear.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/include/scx/cid.bpf.h | 88 +++++++++++++++++----------
>  1 file changed, 55 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
> index db247e42fb45..6b0b4e41b288 100644
> --- a/tools/sched_ext/include/scx/cid.bpf.h
> +++ b/tools/sched_ext/include/scx/cid.bpf.h
> @@ -391,7 +391,9 @@ static __always_inline bool cmask_equal(const struct scx_cmask __arena *a,
>  
>  	if (a->base != b->base || a->nr_cids != b->nr_cids)
>  		return false;
> -	nr_words = CMASK_NR_WORDS(a->nr_cids);
> +	if (a->nr_cids == 0)
> +		return true;
> +	nr_words = (a->base + a->nr_cids - 1) / 64 - a->base / 64 + 1;
>  
>  	bpf_for(i, 0, CMASK_MAX_WORDS) {
>  		if (i >= nr_words)
> @@ -402,36 +404,6 @@ static __always_inline bool cmask_equal(const struct scx_cmask __arena *a,
>  	return true;
>  }
>  
> -/*
> - * True iff every bit set in @a is also set in @b over the intersection of
> - * their ranges. Bits of @a outside @b's range fail the test.
> - */
> -static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
> -					 const struct scx_cmask __arena *b)
> -{
> -	u32 a_end = a->base + a->nr_cids;
> -	u32 b_end = b->base + b->nr_cids;
> -	u32 a_wbase = a->base / 64;
> -	u32 b_wbase = b->base / 64;
> -	u32 nr_words, i;
> -
> -	/* any bit of @a outside @b's range is a subset violation */
> -	if (a->base < b->base || a_end > b_end)
> -		return false;
> -
> -	nr_words = CMASK_NR_WORDS(a->nr_cids);
> -	bpf_for(i, 0, CMASK_MAX_WORDS) {
> -		u32 wi_b;
> -
> -		if (i >= nr_words)
> -			break;
> -		wi_b = a_wbase + i - b_wbase;
> -		if (a->bits[i] & ~b->bits[wi_b])
> -			return false;
> -	}
> -	return true;
> -}
> -
>  /**
>   * cmask_next_set - find the first set bit at or after @cid
>   * @m: cmask to search
> @@ -488,16 +460,66 @@ static __always_inline u32 cmask_first_set(const struct scx_cmask __arena *m)
>  	     (cid) < (m)->base + (m)->nr_cids;					\
>  	     (cid) = cmask_next_set((m), (cid) + 1))
>  
> +/*
> + * True iff every bit set in @a is also set in @b. Matches the kernel-side
> + * scx_cmask_subset(): ranges don't need to nest, and set bits of @a outside
> + * @b's range fail the test.
> + */
> +static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
> +					 const struct scx_cmask __arena *b)
> +{
> +	u32 a_end = a->base + a->nr_cids;
> +	u32 b_end = b->base + b->nr_cids;
> +	u32 a_wbase = a->base / 64;
> +	u32 b_wbase = b->base / 64;
> +	u32 lo = a->base > b->base ? a->base : b->base;
> +	u32 hi = a_end < b_end ? a_end : b_end;
> +	u32 lo_word, hi_word, i;
> +
> +	/* set bits of @a outside @b's range can't be in @b */
> +	if (a->base < b->base &&
> +	    cmask_next_set(a, a->base) < (b->base < a_end ? b->base : a_end))
> +		return false;
> +	if (a_end > b_end &&
> +	    cmask_next_set(a, a->base > b_end ? a->base : b_end) < a_end)
> +		return false;
> +
> +	if (lo >= hi)
> +		return true;
> +
> +	/*
> +	 * Walk the words the range intersection spans. Plain word tests
> +	 * suffice: the scans above guarantee @a has no set bit outside @b's
> +	 * range and padding bits are kept clear by all cmask helpers.
> +	 */
> +	lo_word = lo / 64;
> +	hi_word = (hi - 1) / 64;
> +
> +	bpf_for(i, 0, CMASK_MAX_WORDS) {
> +		u32 w = lo_word + i;
> +
> +		if (w > hi_word)
> +			break;
> +		if (a->bits[w - a_wbase] & ~b->bits[w - b_wbase])
> +			return false;
> +	}
> +	return true;
> +}
> +
>  /*
>   * Population count over [base, base + nr_cids). Padding bits in the head/tail
>   * words are guaranteed zero by the mutating helpers, so a flat popcount over
> - * all words is correct.
> + * the words the range spans is correct.
>   */
>  static __always_inline u32 cmask_weight(const struct scx_cmask __arena *m)
>  {
> -	u32 nr_words = CMASK_NR_WORDS(m->nr_cids), i;
> +	u32 nr_words, i;
>  	u32 count = 0;
>  
> +	if (!m->nr_cids)
> +		return 0;
> +	nr_words = (m->base + m->nr_cids - 1) / 64 - m->base / 64 + 1;
> +
>  	bpf_for(i, 0, CMASK_MAX_WORDS) {
>  		if (i >= nr_words)
>  			break;
> -- 
> 2.54.0
> 
