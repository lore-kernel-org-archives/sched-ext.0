Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9675923D2B4
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770021468; cv=fail; b=ikWD2NpA6BHPEa81c7jE7K7IPH4wfwPla7Hxca9mcH3u4xdGkyNSf1PDLrhxIwkEXyTQ2dPoRIuDaBWZbwv6RPD7jPWXkqmYe8L+dzFrx95kBkKhhb8tU+5TWeKd4BvnT6rNLR6fipWJ3aA0FJ1mxrjQA6PkHRwtnaumNlBaiv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770021468; c=relaxed/simple;
	bh=miuTVwWidHjphZt5wilJDhNSWaHgyolsPl/enfR7frg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tkVRS5ym0Ez1N2VlJFgBB6ZUseQCXf7Vj+j0w2mMJmT79O+nZfWBWlWJdOT18fj3YfVeCeb7gqhFM3NGiumAVT3jXFqH28dyhzfE/VLuBrcwamE8/IewEuPfgAVmw8qrnjUP1sF2ng24o+5Ub9uU5UE9S77PYxwyfAN3LHQLFmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IxXUbC0j; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IxXUbC0j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbg8fCJfUkfYwH2QpY6n+PrE/cHgvwmiEc06R+duvlh46ymHOdNC24HgM94WrWjm7rTf2YdUeLsQBKL7scZZdQ/lgG+4znHaJ3DvIug5vhEvsmFWqFlSSPEfSEs1X4N1rc3mgwsH0lAC7wepJQPQsz15W7F0egZCOYdhxWvVPv5SNdpCiwvwHTbrWTYFEhIrWRysfAJfM3LstWbI3vOSYeoU8pr8tocrNHl62q/8LUBs2vQXn/HyVKqyxlMkyZgo5x20B508P4wP3Aor71/gVsrLCV5z/12SWoz4p/pwzeTB7nok7AzX8+Ehs7rRMqe7Xx73XKYS6b90JQcXin1MDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvoJ6F+0sHUPmG6bR+OgXNyWJbF6eJ9M0697mvxIgkk=;
 b=pa/rThlb3AdMUzt6RoHjWaWA3a8iCYAgRhUsPPhcRmVMoiyAlLHpkdXFU1M4Uz2Fb07vUXRG2nrchRT+3gekC3qaAEsKLm9wyYPnQIiwOaNR7irJneaAcBLRWhMGf8KXtgkbw2zfGc2KfXfY9uwSeWOiHjgUteMgzxUQPXS7IYQU56/WgiR0g9TLh2KwteVnwIgIbobqK7iyJHFpwsbAslMQjcrUoLyJRWz81z9nBFA89tFDBd7fd+r3ZbSRLlD/dKoAVmo4oXQBaYKE/gkCVXW0ZYxaCqd6bhlci3EGb0QoIhPN4bImlhsQZIn0pu4IM63XXxcN8+vlzSjKLeoFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvoJ6F+0sHUPmG6bR+OgXNyWJbF6eJ9M0697mvxIgkk=;
 b=IxXUbC0jTV1Mdyunmn7yog501LdrUje48Jo1HfAYIcTRn63dXElMVXArJYennlwe7g8j9BpFe22qtV6GIkuiANxHk+eCpUClBXIZiNJwXAG83+dEMH/+G6fhcNhfjnT7kz570446+SiYJJXZY/XfgjsiUBpJliiMmJ6x6NVYJsKV6VfTSrCDcLXXUDfO4Am8S1g/VxxUggYsLm93tDGUMcowwjGrOXerVHUMlZnJnLs+wTD33ku0NUeyDQUjC2GxOkAPt5FspTDVZ24/7VW7slmqV854qDLlZKj5d5gTAfCKvdqBYrSnmnathcjnWeUk4oEDi/AfGHr/kGLqazXZnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 08:37:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:37:42 +0000
Date: Mon, 2 Feb 2026 09:37:38 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com
Subject: Re: [PATCH] tools/sched_ext: Fix data header access during free in
 scx_sdt
Message-ID: <aYBiUvh-egdmINUO@gpd4>
References: <20260202004208.42364-1-emil@etsalapatis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202004208.42364-1-emil@etsalapatis.com>
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: b7632de1-7a3a-431a-0585-08de62365485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H7bpHcmBzq6lU4h2Nwt8uzB0X8EK5o/od7rgVhYezX2At0B23wauTEeE0qAt?=
 =?us-ascii?Q?fDO3m3hyDpUfhbTLPIqtZarcSVsitGp1e90H4HuRhxujgEsZbPJUxi2OT1lR?=
 =?us-ascii?Q?ZbBOqG/NAA6AngetizEwirRm22LNsu7y3iysPX6gxWZ/rjbGGou2A+HBhTKM?=
 =?us-ascii?Q?ZCSubrCsceFMMSYZf0KrnAR0eHChdv6jrEALKb5gVet7+ZIVkeHn/8ruHZXm?=
 =?us-ascii?Q?NIm3zMckwjm5wLDft5pKCvQxXmpNnRlw20fBO3XZyLXzFiCNRch96NfX8MFs?=
 =?us-ascii?Q?TUI1nHt3TWPywEjbI8Cxzz6p7vMsdXjZfQUfCR4QUCeZ5Urjn4PmJuu85q6a?=
 =?us-ascii?Q?5Djub+a8uxeRwH0IPEhVB40n8D0smNqTfalOYAPrWNpoZ0XvH477GlgketOF?=
 =?us-ascii?Q?D6V4uGFkWvoSCmjeyim4ziN0/i9/N2wLe0pZE8fNz7s9YITpnIKKOe5PLpVG?=
 =?us-ascii?Q?x6aHITho1XxS3naTKXww/0liALAjPNNAJq+ytArwVTTRvgH7wJGiH4t7zydN?=
 =?us-ascii?Q?xxio1Kc3KQIyGBqc/VuSyR8RXwPuTc37DPx0JOMzXDjPzhbUrCyZcPft20C0?=
 =?us-ascii?Q?ZoqSY7UreJGVq6XhANRFXY2K/cbPmTRPoVEuI81HSPDO717qHDlpP2QpgTtV?=
 =?us-ascii?Q?3Ya5qUmJ23CcU3Tfn8cCfnktlWo5EHUZ2qqjbfD/br9abHFWy71hGDkN85mQ?=
 =?us-ascii?Q?4YehkOgq1rC9hpIpGBVrKNcNVOhBU4uTRclAP8KA16HsXJXtHkua5/HoR+Bd?=
 =?us-ascii?Q?O6wNdGIRWApwyX8IFE3FID5x48HMUbgGBvKC7hhSYqQvdEzCOVynY7A2dgyz?=
 =?us-ascii?Q?7uIKVEhmjMfjtN830CfjI/QS2ujQ0eKVa77aLD2IBHHjnjIk3fiIO5uPAJRi?=
 =?us-ascii?Q?a06uZQ6cJfTavQwRrNu9qf9z10rRPfvP5hIDdIEgg1D4GlvN81wQzVxm11gg?=
 =?us-ascii?Q?HyfMm3o4tzXHJqFgFi0sYnHKdcS/Lk5P6iEWX2c2zJACMd+FlbsoI3jRKjgV?=
 =?us-ascii?Q?OwZmrzVWWQDXuOvJUJVeXv9eNTfW95Sslg0KXq6UuecPpByfE67BIbrxONkD?=
 =?us-ascii?Q?OXE3s453SewI47j5D0HTJF0Jx08cwMKOf7CNEOZ/o9KeOAYwlMRbkUh4raPc?=
 =?us-ascii?Q?G/lXKpl9i/jFrl3eFsheuvHwCQDHTJX8seHu15QngLdVxbhv6BWs4Nxaf7Vr?=
 =?us-ascii?Q?ko9cOAlaryj98RSEm5E1iXRM8JAcJm3aFTyFbZeboDbvMB4x4hoo0QYH2zB6?=
 =?us-ascii?Q?cgDiswgHiGsQBK+creOJ8HZREdZAUihXtGIgLiy51b9185zjuGZfq71fPHnS?=
 =?us-ascii?Q?Zrog5zL1oK6AdjEwJSpnPJcOoBZyUk0n+PyE3b4hQLsJ2GgUmrWa4ujePgBK?=
 =?us-ascii?Q?nB73KnEmc9wgtFMa/K01oXnrCxpekT98Dhbr8tHJHQlrKpfaw1I60ybl4k/3?=
 =?us-ascii?Q?y8FdV7drLak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LfchqseukZK1+B3Hp6Fi7ptXPuzejDMgnlGGa9PmNx8wbJaBuBgTngIB0cC8?=
 =?us-ascii?Q?rFVG6Z8YFmn7CwYWoyD5BLSvIeU443JKbckfU//i3ZKrJG5KXX5v48/Qea1V?=
 =?us-ascii?Q?VIiAsmCa1aQwS/E6fvLH64uZdmoiJqO4kiy7HNNvdG5cM1GRFoL/6sPL/ppV?=
 =?us-ascii?Q?kgYTqOmn+Oby6C7cKd9NkohNYNKjgN0RlUpBQZA4xWHRh2tdy/Ll2Qigsq5T?=
 =?us-ascii?Q?HEXxQTybm1u9rTzXNcoEtr5jNPqT2oIofvS1b6yiEyEPUbw08UNKJmle2rSY?=
 =?us-ascii?Q?wTLxIjsZGgQQSVXMrbU4Ut8p7p9ShuUQhMh3vFbNB/CI8U69mGKQ2NsDCD24?=
 =?us-ascii?Q?VEvUaHRtDPW6UgQcIbMGy9RlUUx00uI+JJqLlUGF5I29IbInSmuuj2r3Tv2y?=
 =?us-ascii?Q?C4gx6ux3DpNBOrecw6PkP6PUqLkVJ1FaogVoSdROGX+RUPEl1ODYfT7HE1J/?=
 =?us-ascii?Q?G7qIQxVMV5eATMcH01IaRLY7IHHLLpFXzPMmxBlqpfw4+tq6eMBJMAAJBnJ3?=
 =?us-ascii?Q?Ee3nEshHO4I3alXAbl/fvB258q+EHCIDnmElJEmvhdv1aeenlaD9fke2TdfW?=
 =?us-ascii?Q?fpdZdQmC7av+Rd4OrH2CIumcsxKW3aqjAYBgh3AcxhB+PfUc0nfneTgNU9uY?=
 =?us-ascii?Q?FQ57MyUxovaRooNxdhXpV5yiu+AlG5m41lBPcI1IZSigOQ1/iZJTduQ5ueG7?=
 =?us-ascii?Q?tcMAIxbZiZms1YM9cl4Mv3uPPvLdeyyZdTPpS+4iPxjR02rgul6j+K+TPVTR?=
 =?us-ascii?Q?SUY4Uy48lv7zhEd4jyT+8g5Gjq0/OgTRoGs1bXZQCMqMsWOQKb4dsuGvghhm?=
 =?us-ascii?Q?N9MX0xQMgl0oQB4hIL9BwbdlJqkT/kmaHqlXszNW9Gaw/Hb4h8/3gmzhxh7T?=
 =?us-ascii?Q?kwPY7snUOYz/OKZNYHJ1IA/f7KOO03zjCKEJ6HLhFOta3KBLNQfcVK0Xp+nn?=
 =?us-ascii?Q?otsftzXnUk1jOZFmrkwNqLZg0q+idNdtKOh9PcOp/KlJFyYDINCwEwCxZ3ur?=
 =?us-ascii?Q?TCgmk/0Tr6TI2R6dgZpi8+H7pc2+Lep8axob2QHHt77eZ+7RTl5i4RxN94ic?=
 =?us-ascii?Q?WnISHF70cEphUeYZTuteg0arAL38Ch3xoiWthRkALIamWPKvBPfp9Z1zWm5P?=
 =?us-ascii?Q?exTWmRIMBCRHhV4GzrQNqeUqYbYcPPK5iv5fE7TPw6EBk22y7KUy+f4ohTqV?=
 =?us-ascii?Q?mn1TXmiwracN6xQ+dV2tPOHR3TeL8iXkoLMLuKntF9Ue1x5fcdb+doNsDGa9?=
 =?us-ascii?Q?fnMjyiUiSw9OLBlquI1/hXt12Sv8WUTYLBUWaTWDH6erijnq7T8oaG0xvcy4?=
 =?us-ascii?Q?NpzDwifKrpjCQHQhiZhtWEbYub5JOzkihjf/x76w45XiZ/SM63D94wvzQa0a?=
 =?us-ascii?Q?4DcKn9T50JWr7dW1TGf0CW6b5Nl7eKJhXrKe7s35SC7uWoMjc8RnaFGlNUW2?=
 =?us-ascii?Q?p9leC7O6O29l6xKqsT9cPx3PBOWUfa6GEHfhlIZkIaMMmax23/AT8gMMm6xI?=
 =?us-ascii?Q?/jk9hpohJbvpeMGqvmaMXGn2klMRuedCW9oXQeT4ajqEZW1T8dgmXyWAn4xI?=
 =?us-ascii?Q?nXsxgGtZHkmTO6rTmN6NrKpxXtyXj38f4af65Lt1bJJTnsFtPQsWnhtULPgV?=
 =?us-ascii?Q?NC/aqxhexXOWxmDuqAzRh+lTu7mGBsOJ/5OTnovtJPyB5VTRNSeDzvfIKgG9?=
 =?us-ascii?Q?4SVzACjlT0j7+Mvj9L0KjdnWhYv16pQszPGiTKQxF3j1szKa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7632de1-7a3a-431a-0585-08de62365485
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:37:42.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gG9Fog0egzyAFt+KxKSdaxqkHn9vxzfmvrA7JtvDILk2Dxpty6FXp6ZxP36/Oge7DvZpz9sQAfgeGg3vF+9yqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

Hi Emil,

On Sun, Feb 01, 2026 at 07:42:08PM -0500, Emil Tsalapatis wrote:
> Fix a pointer arithmetic error in scx_sdt during freeing that
> causes the allocator to use the wrong memory address for the
> allocation's data header.
> 
> Fixes: f0262b102c7 ("tools/sched_ext: add scx_pair scheduler")

I think this is fixing commig 36929ebd17ae6 ("tools/sched_ext: add arena
based scheduler") in sched_ext/for-6.20, right?

Apart than that, LGTM:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/sched_ext/scx_sdt.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
> index d965f7d209de..31b09958e8d5 100644
> --- a/tools/sched_ext/scx_sdt.bpf.c
> +++ b/tools/sched_ext/scx_sdt.bpf.c
> @@ -312,7 +312,7 @@ int scx_alloc_free_idx(struct scx_allocator *alloc, __u64 idx)
>  	pos = idx & mask;
>  	data = chunk->data[pos];
>  	if (likely(data)) {
> -		data[pos] = (struct sdt_data) {
> +		*data = (struct sdt_data) {
>  			.tid.genn = data->tid.genn + 1,
>  		};
>  
> -- 
> 2.49.0
> 
