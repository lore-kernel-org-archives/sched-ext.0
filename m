Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A92D7DCC
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830082; cv=fail; b=OJAadyysNgNrLImeHrkokYDS65CDN9Fvza457OudEsi/uvLD3j1XrHSJY3PIKfMBdNcA+N8a1nC0TCdfJOPg9gpIyU1wJDSdmmIL+bvRfEYHgfh0cJWoxmp9riVFxZUVnfaDMlZFlX07EWukGgBJIxUqnAXksPGkyags/B9zlpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830082; c=relaxed/simple;
	bh=MCl1rPuaz1HOflljpoIH2D7ZvZ6g6lzL4yJlOszbLpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K70prK2sRjJavt3CJ1QjiDKt0hTajW3M5BNU302fZ7RHMtdURLXlV1zLJVwGGjD7R5qWe5pxgBDEkqNAQ99DBozsHFrucaGvxR/IQhPsN3NHu0oktXsb6PrHCz7PSnf3w3DPyjdPKxoD0OZAt04F7Z3NnjWsjtn9XzHCbnvC4T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cINPUUGM; arc=fail smtp.client-ip=52.101.52.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cINPUUGM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xi/4vE9kwxDhkNWr5mmQR4ar2zETHSc4E2NO9UjM9q5bA7HxMk1y87mekDqEdpQw9Xols9eDXHR8ndIIqOOSOC38LosyKquujPp3JEOVK39Lftss5Pd+5oSHscdxm9iwAZNSA+Swi3GDe8hF9CkvscaPDUsxMgtqoZVTQeGqqBHuY3lgxvzySyt2V8lcURnQb+GTzFRpANDIFN/kYbw3oOmMsZ0ThQNTPMWOQqPawnT4RRHmy+lm/f3ioJCgTab9h5qLATimKlkft3UX2cYkrXvJIRfV7XZLzw+ljsFZFyC5A/rnXiPOzEGVVDo04rORzvI3IutWcdORtnq7xnOBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAWlaYZKkmkYoyKVV/2cDDDmYz9d2X9Y+cx0eUZUZR4=;
 b=K87TctyN3ZVKvxbVUOyB3aTv/GZ3OCiFgn95qCoOzi8CHpaG6D/UaAuAxV9hEoW5b7E4P8ApPDQ4bAeJEVs3RDgwmfFBSmZoqLstubXxshJBSFjr8TqOBthMv9sP+4QXawH1DDIKmfnEExo48LbjANqwMYhfgXXlUePkaTh4A7DGHyMtUgpw8G3a9DOIx2Rl5BYP6T4XKAHLDPBgGNqarkUUJhGPw/m7hboCKXf8XREw66Sr9FaE8oA8/qJiYRkLD2JRtsKnC3wTn4nTjr14vlmoL5bAMPHFA6Bz6Y0FBWtWDyoc0Zs0fuOyLaJ5G8KcrwFPwX43eXQL7KG3NrEffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAWlaYZKkmkYoyKVV/2cDDDmYz9d2X9Y+cx0eUZUZR4=;
 b=cINPUUGMLXz3ejQLKfI0VHu4zxNgerRt6h7Td2lZsYORF7SS8Ae05woHemiPc/mQgbgpAvGD7MPgfd9D7Swp51fOTuh+FNNKg4mGEIZXXkOPx/67B7vIN7+pu+zLtmfL8H9d4fZZwkMQgVB7RXVwgeQmiuV1gxHP11XATyQ5zoTI4p8Qhs/Cc4wnw/8ILZXU0mQXAvEfxaaclvU6XBQDFTTj8kEIHAih1CvoK2i4FEDVqXI/zPkzZB9HkevDY981tBE9L8PneAjq9OaZ4IDv0/gl/VdL71Y7tl8HqmTxK/PCRX5+MztkQ3+V/XS83469fOudwNtbvfNG4yjajm2E7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 09:41:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 09:41:13 +0000
Date: Tue, 7 Oct 2025 11:41:04 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 4/4] sched_ext: Make scx_bpf_dsq_insert*() return bool
Message-ID: <aOTgMIGoeBuOGldz@gpd4>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007015147.2496026-5-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2d51c5-536d-4300-e2fa-08de0585a74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+pdSNHjMtcNqVvyESHwxhKCEjKZdu9FpbRA1AlCU31CBmkgDXCmvHwEnuBdQ?=
 =?us-ascii?Q?sdkW810Oq+MRnJUKvE6pn8tOQohLtNYovM9VEaqOENdumClAZFmZARViQl2N?=
 =?us-ascii?Q?vPsCq1rBfYzBx1JsqdZXW0vrr02LOhlwZ3S8ZaCGWksRnuCO4gxRvzLvAcVy?=
 =?us-ascii?Q?DgXROn3tB4tPZra1lYH9KCjXd2HtbPoiIZGdmJBwhsSR3uMQHYaNow/DGfab?=
 =?us-ascii?Q?pI9QgqUOvY8MIQ4r8+pBM2pPkSi11zaY9fY6Mv4PcJIRFJjchdFGPMOuouFt?=
 =?us-ascii?Q?/2PuYnqNsehokcpRIkOErKndhtbKK+dreTeZiSUhRGvvx3+gHxXgFyPo2r7j?=
 =?us-ascii?Q?z/O3gzBKtpg4BJbJ8R1B8W+7cNt0XNl7FvgXlEj72Iuuu2vRIyVNQRYTc4cu?=
 =?us-ascii?Q?Bv8rvoE9g1s48Qlq1aH+n6iRXUUsGCcLHcT7aUPoztFnBeIw3FyRzuP2uJwV?=
 =?us-ascii?Q?KhPVyGXAhaV5p6oNk9H+6rFua8r18sohjlrC/qr/K6uI4TW+zkEdSWVowqFn?=
 =?us-ascii?Q?cs/m8DlArHZmzjXaV2Hw2Oyl9nK0WQCVpMTxQcqPL+GFsA7Us9FImZM5Pt0Y?=
 =?us-ascii?Q?srt2o16TcWgZh6x7Do8G44HNDUc2UPZrzjgxasJEFLCb0WvzP+M7e7+08TUo?=
 =?us-ascii?Q?7xhNpPaOsWQxcA2JcrPtZcI9YvMa5LJsAaWWupOwprS+ynC379OXlWYKdbLg?=
 =?us-ascii?Q?IsI6NRPEZRWFRVMpH9JxzVgY4rm665AtUsaI6jZAHSDzcFFpO881ssfW2tqF?=
 =?us-ascii?Q?AjjyaSmShPrrKzewnhFg+BXs5KJcaFVQq2RBt5/xb+ew13rr2+iGTiaX1vOw?=
 =?us-ascii?Q?ysCmH3TIZ+xwkqsfPF5Nb2yWT+VpbhBESd4PnBAQewW26xG2YniSIs8G8NFb?=
 =?us-ascii?Q?CMtxfTDsvRikNVTxFXRpIJ8xpw+5lHteQFsbl8k/b3cJ1iV/sFSAQB/WXxSZ?=
 =?us-ascii?Q?RI7bS5baJM6tfegXvGYViTw/M0e01izcuYRn6qZiDr0vmoKerZ3jxP+25cnK?=
 =?us-ascii?Q?NTwzGqUlYOTLib2bAmk7v+Hyf6v8fXtwg8D0q7R+0My1m+J5vCwGGhNa5GLV?=
 =?us-ascii?Q?XxWZKD9pu+z8QiqvnGbHRjVyjqvadslCvRY99FRhJwWROaZQOkTSuRKY+TjF?=
 =?us-ascii?Q?BI6YFmDDvE1IAbkTMx2nGgaOjNatOBjlLiNFLnEKooGJDvGLnszxDFDVeelN?=
 =?us-ascii?Q?ivf54m4aojH3hp4UHkBgzv58SI0txHyPZVrYi1GpbWNecYoCSwfCs6Q8E7y2?=
 =?us-ascii?Q?gMHeaRgS9v0aLeY4/fpzeu0gXMUaPtiKWQaC9roWy1TnAagTOr9p37BOlMQh?=
 =?us-ascii?Q?u7xpOCcNLW7SxtE5pWt8lCy1HCx97KXk0q08Na1JP3iesoX6G9SVmklQ+uD3?=
 =?us-ascii?Q?QLvQolqBMjvDbRV3NWZqeYpKq4eb2X1Rz7FzwNYj3JBIJFNjvi221H+RzSsb?=
 =?us-ascii?Q?SYEwYZN9rlcYoH0xQEz9quBoAasqdhqc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1HCK5r3H415lEWZflfX8l4c9DPMBfzMY/loM/JafMOA5Jv0eJZeBbLkjYvtr?=
 =?us-ascii?Q?UpKcmpbuiuZsPmxgIJc6EJF1r5W1u9v2TyE78BEuA/5ZajWx2YcxccM4lQtk?=
 =?us-ascii?Q?MDd3kc8o+LGLTDzNUaxUXQGBHgh55bgWX5HK518IWAhrHF8SfZ0FNBSEU70E?=
 =?us-ascii?Q?okXsQAvRa4td9N7Z/zsEGnYzvhp8Jpfp7IR5baYddl03zgvg8REm6qj5fVBA?=
 =?us-ascii?Q?JjXspOSbM11NL5B1MWy3pIZC8FTfXa3eo0i+l+vIQ3kNI69I+da/t78+gmik?=
 =?us-ascii?Q?lhU702MyByFU61J00AGjOMG8I1bLneVn2x+EGJ1QWYUowForiEfb0x5cTaB/?=
 =?us-ascii?Q?rcMU+2WisuQtH3DAiHNT+yzRb9/794hvMwWUhK4Dw8A8if6z7rUuy/rImteM?=
 =?us-ascii?Q?93P0sLYQ899Xo/dnDpo0TpTCkyDbffnjquFZce+mI6BwmDXiFreoLrMrcRzX?=
 =?us-ascii?Q?nzhwXZi6b7OQiqX7lrN0e+tXjxsSWN1boiht8J0zkbs/iZC1NuMGAoor2UZK?=
 =?us-ascii?Q?Y9uXRG8Um5qOPQJFS+KWcPI8qPLXBEKBq8TxfwYXBVMzpkiMtT7l2w28GYZ3?=
 =?us-ascii?Q?J5/3kEHBqiMFQJXY2po37lN3X0JxkHJ41VZPieUf016k/Cf4kgBmGvvjTWO1?=
 =?us-ascii?Q?htjyPSRkW5tczsK3mXf1RreFojvAq59HobYHZx9vUeDbKQcoi7spbb0eVba9?=
 =?us-ascii?Q?oBFwtQjZhV0Rfa3CxG1gOnxptlag0zmN6/j+eVFV9/6qI6K5HZ3p9OkprFdG?=
 =?us-ascii?Q?84hzvGr0BN3lutjES0Ga7+V9XqssI5ggVeypUaJR4ntKDqsPcaarJIZKq+2t?=
 =?us-ascii?Q?kP09aiXFPjmuIP1AExxg+Hz+nkBdzbTWio0dbhsGcIJb7vLZLpXYSGjgRYV5?=
 =?us-ascii?Q?YxkV+g2whyXOAV/UEXQHZaCBiw14p7m21YP90gRZk3QPtyuoGVG+S6SkJ035?=
 =?us-ascii?Q?MeijNAaL36q/+2oO/Vfog8bI1T2q0Lsea0YYhWzuvCUaaYsKhAsPigZEz13O?=
 =?us-ascii?Q?F6DOrHvBI2RfS/GW7RiGG0/quI8dqDgD6DG4CC9Hb5tw9f+vaVioRF9Rr9kv?=
 =?us-ascii?Q?WuDGV7dXQHb+1/CRjiWkinv3PqD7Cab6Zk7FiizXIJs+X1bXRlubIgX4WOgK?=
 =?us-ascii?Q?phQnMqRmhq+Vud3bAmMzDhEaIhvKwGZKy0wzNexSY+P0VgJ9JerBHcVKoiki?=
 =?us-ascii?Q?lBng+AyFB45cvXqmDjf3TDHrE79KLoWPBwGK20Sjx7L95xR+p5JZ9adBMXZN?=
 =?us-ascii?Q?kTmHCSo1zX5apgUT2kqlPgfkB5Obn67dh2IT7V3Zf5EpxMvEYXA59VNO6yit?=
 =?us-ascii?Q?GQF241tNfdxHJ83qIJm1Ugr3ucB9A5v2URJQuGpQNVdd8IcEefT7Jdd/npY5?=
 =?us-ascii?Q?018KgMUpvD5cng0dFaDeYC3heqr3bALoR3/kpmraKVykfKzXHpdVkMjP0ecB?=
 =?us-ascii?Q?/3cYw9UF1rogMi6wtS0naH0ibikMkynFw/14BlsTH/CJn5jKeOsl3SidD3bw?=
 =?us-ascii?Q?VPB3Xirc4U47FmIdRr03zFBEctwTT5aGB9vL7tfwdp7QBIVASx+rm12X5g/e?=
 =?us-ascii?Q?iFOooQvEWYR5V9HMQGlBVq1mHIuBgiZwqIWcIX13?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2d51c5-536d-4300-e2fa-08de0585a74e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 09:41:13.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlPFF79SzMlru31OjDuWs6Ln5NoXTz/ZgCEW776qeaNvNbcxkiVKb4oMXFsISoJbD0qlPrHy6geqHoYqBzcW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

On Mon, Oct 06, 2025 at 03:51:47PM -1000, Tejun Heo wrote:
> In preparation for hierarchical schedulers, change scx_bpf_dsq_insert() and
> scx_bpf_dsq_insert_vtime() to return bool instead of void. With
> sub-schedulers, there will be no reliable way to guarantee a task is still
> owned by the sub-scheduler at insertion time (e.g., the task may have been
> migrated to another scheduler). The bool return value will enable
> sub-schedulers to detect and gracefully handle insertion failures.
> 
> For the root scheduler, insertion failures will continue to trigger scheduler
> abort via scx_error(), so existing code doesn't need to check the return
> value. Backward compatibility is maintained through compat wrappers.
> 
> Also update scx_bpf_dsq_move() documentation to clarify that it can return
> false for sub-schedulers when @dsq_id points to a disallowed local DSQ.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

>  kernel/sched/ext.c                       | 45 ++++++++++++++++++------
>  tools/sched_ext/include/scx/common.bpf.h |  3 +-
>  tools/sched_ext/include/scx/compat.bpf.h | 23 ++++++++++--
>  3 files changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a34e731229de..399e53c8939c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5323,8 +5323,12 @@ __bpf_kfunc_start_defs();
>   * exhaustion. If zero, the current residual slice is maintained. If
>   * %SCX_SLICE_INF, @p never expires and the BPF scheduler must kick the CPU with
>   * scx_bpf_kick_cpu() to trigger scheduling.
> + *
> + * Returns %true on successful insertion, %false on failure. On the root
> + * scheduler, %false return triggers scheduler abort and the caller doesn't need
> + * to check the return value.
>   */
> -__bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice,
> +__bpf_kfunc bool scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice,
>  				    u64 enq_flags)
>  {
>  	struct scx_sched *sch;
> @@ -5332,10 +5336,10 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
>  	guard(rcu)();
>  	sch = rcu_dereference(scx_root);
>  	if (unlikely(!sch))
> -		return;
> +		return false;
>  
>  	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -		return;
> +		return false;
>  
>  	if (slice)
>  		p->scx.slice = slice;
> @@ -5343,13 +5347,24 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
>  		p->scx.slice = p->scx.slice ?: 1;
>  
>  	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
> +
> +	return true;
> +}
> +
> +/*
> + * COMPAT: Will be removed in v6.23.
> + */
> +__bpf_kfunc void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id,
> +					     u64 slice, u64 enq_flags)
> +{
> +	scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags);
>  }
>  
> -static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
> +static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
>  				 u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags)
>  {
>  	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -		return;
> +		return false;
>  
>  	if (slice)
>  		p->scx.slice = slice;
> @@ -5359,6 +5374,8 @@ static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
>  	p->scx.dsq_vtime = vtime;
>  
>  	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
> +
> +	return true;
>  }
>  
>  struct scx_bpf_dsq_insert_vtime_args {
> @@ -5394,8 +5411,12 @@ struct scx_bpf_dsq_insert_vtime_args {
>   * function must not be called on a DSQ which already has one or more FIFO tasks
>   * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
>   * SCX_DSQ_GLOBAL) cannot be used as priority queues.
> + *
> + * Returns %true on successful insertion, %false on failure. On the root
> + * scheduler, %false return triggers scheduler abort and the caller doesn't need
> + * to check the return value.
>   */
> -__bpf_kfunc void
> +__bpf_kfunc bool
>  __scx_bpf_dsq_insert_vtime(struct task_struct *p,
>  			   struct scx_bpf_dsq_insert_vtime_args *args)
>  {
> @@ -5405,10 +5426,10 @@ __scx_bpf_dsq_insert_vtime(struct task_struct *p,
>  
>  	sch = rcu_dereference(scx_root);
>  	if (unlikely(!sch))
> -		return;
> +		return false;
>  
> -	scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vtime,
> -			     args->enq_flags);
> +	return scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice,
> +				    args->vtime, args->enq_flags);
>  }
>  
>  /*
> @@ -5432,6 +5453,7 @@ __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert___compat, KF_RCU)
>  BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
> @@ -5686,8 +5708,9 @@ __bpf_kfunc void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter,
>   * Can be called from ops.dispatch() or any BPF context which doesn't hold a rq
>   * lock (e.g. BPF timers or SYSCALL programs).
>   *
> - * Returns %true if @p has been consumed, %false if @p had already been consumed
> - * or dequeued.
> + * Returns %true if @p has been consumed, %false if @p had already been
> + * consumed, dequeued, or, for sub-scheds, @dsq_id points to a disallowed local
> + * DSQ.
>   */
>  __bpf_kfunc bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
>  				  struct task_struct *p, u64 dsq_id,
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index b1c2a0dde76e..522c90d0ced2 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -62,8 +62,7 @@ s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>  s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
>  s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
>  			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
> -void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> -void __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
> +bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
>  bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index e172de696f99..33c26928f4e9 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -196,7 +196,7 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>   * Inline wrapper that packs scalar arguments into a struct and calls
>   * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for details.
>   */
> -static inline void
> +static inline bool
>  scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime,
>  			 u64 enq_flags)
>  {
> @@ -208,10 +208,29 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime
>  			.enq_flags = enq_flags,
>  		};
>  
> -		__scx_bpf_dsq_insert_vtime(p, &args);
> +		return __scx_bpf_dsq_insert_vtime(p, &args);
>  	} else {
>  		scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime,
>  						  enq_flags);
> +		return true;
> +	}
> +}
> +
> +/*
> + * v6.19: scx_bpf_dsq_insert() now returns bool instead of void. Move
> + * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper after v6.22.
> + */
> +bool scx_bpf_dsq_insert___new(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> +void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> +
> +static inline bool
> +scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
> +{
> +	if (bpf_ksym_exists(scx_bpf_dsq_insert___new)) {

I'm confused... where is scx_bpf_dsq_insert___new() defined?

> +		return scx_bpf_dsq_insert___new(p, dsq_id, slice, enq_flags);
> +	} else {
> +		scx_bpf_dsq_insert___compat(p, dsq_id, slice, enq_flags);
> +		return true;
>  	}
>  }
>  
> -- 
> 2.51.0
> 

Thanks,
-Andrea
