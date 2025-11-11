Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F061D275860
	for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884472; cv=fail; b=bfxqcq/FKeJf5b4szi+OWpfqA9LMtXxxhQYzX5Nac4ggagIA/dlnYtRRVjRUSv07umTqngf0XbCesN+H4xD1DiVEwC69Gxb9jB9Mc2slIddlqPHLZfNy16nQJFydpG6tMouPTIMApstVhjbs6Hsv7rL4HDnuZ9B0aBlBtExEJLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884472; c=relaxed/simple;
	bh=7QQ4OrHl28bOAsVc/0kZDrcfk6f/Y6QoKmy8tkxgW8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pOiJZe8PN3aFMKU1Vb34vdd1LEByX2OM92uwMi7M788qICXfOfChQCN0CKqZX3VBYPmtwaOOveXL4+F4Eb6BF7SeFdjbm8VJPkcoabyODW9VgdahzwOb2c7rq8Ew0FrXRoioOeqMx3PQeTGXl5ZvKu5v0TfTi3akLwGIrhl/4iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJlcKjOJ; arc=fail smtp.client-ip=40.107.208.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJlcKjOJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mej/hg2/g8v6jbfOV3jJpJ/hq34tMWU3/mW8kVF7ZOpewPglYwnBNM7fH2ezpH6DKf+v8BoMCSB8gil2RR8GmqD+0GlZurzVbSZuSgzbN9C7Br789KcGAQ0VAM11L5zOMI1o1LU1Oj2Xx6nIWUvwh3dI/90RUpbrQxobRGsaGKKhwgYFZR9VyOKa5RMw/2mbYkN9bwnJle7FolLYmqCHVUR9Gi3r8FK2sEM8u1RXMyuoXrrZOzUNk0UL8reETBblyirUlLCYsEwERcy9mqcT4j5DqaqeHcu9TROjqwa7LfZG3xK+jzhl0p644F2HbpXuxURhoCyUqE3qvZeqTheGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luZeHHzzVqGZOCZyVm1bAlvR10fDi1L1f2HQXJ/5AEc=;
 b=ewD7053NBqWNHsXi6QoALvI+6OQ8r4hkD/LR+te1Y3Oy6Eizg0jeAIi78qpDJUKPgrgkH/CCFprqppjkfvc1d3NPwxadeqyvn5TlqbSAyJPsziN853nn2T4W8ml0iv2rp/VN+xylkuMF7h/Rso72jYJFZRSg7hbTvxU43RcrmY+KpimNJRfbgeCDaKO71FMEpz4oYPUFSOASseLc7rFgNGK+94O7z0Hm+d3RQUUS+j38YE3X1Qx9bDgQQ4BzwV4fWSC7cnMu1hEJ9LmLuHw2k4JT186+RRPdt2r+LAZ4CAGQYhhdsh+VYgqXKmcGIRpUmQlPQCj49lP+BSxnWyKRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luZeHHzzVqGZOCZyVm1bAlvR10fDi1L1f2HQXJ/5AEc=;
 b=OJlcKjOJFlvt7GaX3L7L3w1kiNQ+bZIEsVodMfkLxZS3+ETJO+nNqsPyMcZma1t9pqY29CjS11FKab9QFvhwKBm+Y+6jE/jrt0eoOnibC+8TH+JU5M61ntvnZWpaB+0zHg2t2oHq3CvCq3twje6UQAwukPClEhvhPetYjBUbn7c3pur3H7cOBTvqmaaZke0zp6BchcXAooC4M5NqSj/2Va0ktLTorrNmjQ2xBF+g/a39bXuO9EBnqdNbxCLetlc0qp2iMa5o4WP/DyQxsUrSA74Ejv2M7uCRIK0PvJycsa2e2VGasaWaSPhgZPEDS6lLY2kbws5DuwHtthcsoBPiDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 18:07:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 18:07:45 +0000
Date: Tue, 11 Nov 2025 19:07:32 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/14] sched_ext: Use shorter slice in bypass mode
Message-ID: <aRN7ZFrwY6OFleiE@gpd4>
References: <20251110205636.405592-1-tj@kernel.org>
 <20251110205636.405592-3-tj@kernel.org>
 <aRN1t_BT4IqYLdBj@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRN1t_BT4IqYLdBj@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd39baf-5b70-452e-dcd1-08de214d3735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAiEPSuAtqy6gEWmC17AFXZSoCXHwIEpmUUwtrbDcMz2qCbIKufabGMYiqpd?=
 =?us-ascii?Q?mRxjxlxNgNVhd/qdTzkZ9jl/dbuhKY+h+SYdJyonK11324bdKaRYZZ8azS5A?=
 =?us-ascii?Q?uhsgI/bL/KB6UyzYGwXiFGwo0h+w3LeJCONg/OZle5DraGMbg+t6B78zb2pl?=
 =?us-ascii?Q?Do+fGQq0ldSvgQGwLJtz2nqGLq4nYaG4dg8xw5geQ3jwfRdHQfp6HWClqTlt?=
 =?us-ascii?Q?N8hAxdsavAy2McQEEQYoo0tkqBvB1kKf1HvUQpT2oWtlfgspBwnG+NawBVMZ?=
 =?us-ascii?Q?IyPXzp+ssL47wGd6gZdN9nDL+rdYMYqtVpjZEGglNpJMbQOVCnKsTP1Jouox?=
 =?us-ascii?Q?zMqfPvtb5OkBQph26vnwlGSKHkbiAEn5X6mb248wSdDxUCgvalVUaoeGsmcy?=
 =?us-ascii?Q?EN0y3JGdQ87+dONQHZKDIW1pUCGiwF5ol5xD0O9QNzCSuC3rfzlXmnyIIZHr?=
 =?us-ascii?Q?ahO5Es3P8m4FD7d+w+lyKXzY5KTgJzJv6TKfN3pu3d1ieldBgFg8YYzLmdnh?=
 =?us-ascii?Q?SCUVBTNIBiVhIA3eUyp46JPi07KnlcNxSTadekEfmNMkDZSFaDotOgKXAUck?=
 =?us-ascii?Q?cxxd1HWcrqzEtlE4cRw4xgo4ThkSL+AzouEvGpuyaewHRcUJulDUK5lUkGcy?=
 =?us-ascii?Q?0ES3B1QwktfaJqA61Z+bz3A/xuWzR5iZuUiB1J9s5CjkO5YmQSEyyshNVB07?=
 =?us-ascii?Q?Ms5y/IBluqkUOH+XOYKEUCdxMYfLz+DGb6hmSI1fHyCJwSBtWNAPMxQxhD29?=
 =?us-ascii?Q?A1UW91Zx5xxe040QnUfOo2uM+fMFl5FduhMllwEEpqtXaNrG869bwA5ifcUM?=
 =?us-ascii?Q?qVexQwziRMafI0H9QERfslvOF5lfB/JmOYMnnYGLDrltcnb+A5sPKloUFmL9?=
 =?us-ascii?Q?DFPJ99ICdgFn4OxRQolAe7qyNETP6jsk+NNcU2todWmToD3ylKp9Bw1YAMFg?=
 =?us-ascii?Q?JufXzka4xTGtmh2iDpTwx/L0RLKgeYVXXljab0242f1x/PqvTsOneyQP8oX9?=
 =?us-ascii?Q?VjVvShvye428ThFo3sPvVs0+EGz/UHOISA3zY/5f6M3H/x+B3Bf6qMrbBS4P?=
 =?us-ascii?Q?AK8wG2gUUA2i31S/KC4M9VsATFg/en9B7bdMFBmaUe7DjSnk+PW1Fo9q6enl?=
 =?us-ascii?Q?PhqWB1c8WQ6HNuSuKcBOtpqAD27mwBkCVgUw5gBdTE6Z7jRZsBK5s+Ty3LYK?=
 =?us-ascii?Q?wJdAXGejyXEGMv7eEcWddKhdWUKfn2GDpO4BWZ3hY3M5vEwwvjKMhAkf9VLy?=
 =?us-ascii?Q?LrPtjTvtmWbeXU1WRcM9t7pgq6zBnVvcSI6j5k0Ppq1IubjlC4ZNe9SGUXoS?=
 =?us-ascii?Q?JNS2dOHulFwFoq56EfG9437k9lsYCSg/cE3o7W+co3bnKgi9axMy1tgTugCO?=
 =?us-ascii?Q?rOJK6hCmL636gwXPSJuTFbnOO5NeQ0gO4HWKkAhRM4CSeDk6dIrbKwyEyXg2?=
 =?us-ascii?Q?lpSymrAm48TFbg6GhSbNfbexH+2LS+Sa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wtB6L4oRke95yKKOj1KpG1lL8Vi8+Sv4mkZTTH3FnDR8p7dMaaANq7qWbmqi?=
 =?us-ascii?Q?pg3GrFpxUD8QpK+YtJpr7hhwh8ILEH5aZSWc+EUESXCD+Q66fGRqbFSK5PKi?=
 =?us-ascii?Q?ejacHYeu46OgFWETgk6e89eWJDh6X4q08h0oOxrExbzjmcPvzeJUjmU/LzVc?=
 =?us-ascii?Q?vWBR3AjswEm6ahioj4nesawT7p62chbtitE1BozDinnIOZkuTDvLPXdVsyzl?=
 =?us-ascii?Q?ihm6QGB+zQXpGExPExuP5z2Jf5M2xvSxgrQU0HRPBOtKjNQRIDickzAOnjxu?=
 =?us-ascii?Q?dHUjlyFD7GPwT9JkLmslHZh7MHueyYKv1IkK2lGta7T8u47dU7jezwBtoh9a?=
 =?us-ascii?Q?IRnIeF1FLr+vbB0DGSenAu8DaypollCkf42V4ptt8a47hJA76XgOlGRZlQq3?=
 =?us-ascii?Q?KWJXK2ZCJ8l8G3hYSgv8D4KHtXD0b50GDkarYNgGJnm4Fr/Hb8kkLvGy8F57?=
 =?us-ascii?Q?7LpbPwZZsz/ssTpWjraXPALk7bczxtNcbaCDv3R9TjHRbUH1X9B+ZebzYO9v?=
 =?us-ascii?Q?kihGyfB1RU7Yd6fyFw9E9SmITrDZnP3NNWCdPNmbVt2LrSBN52Ud5GylBklL?=
 =?us-ascii?Q?dCuZ5lG4pqQWBPb5ULzt8pHr+uw876SIAN/hRjo8xDkiIwh4CaNwr75yVqI3?=
 =?us-ascii?Q?YREFm+hJPlRVuwHXuc6D86HNlDqyry0QgdYcPhze+JuoW+d1Yu7sKuPE8fob?=
 =?us-ascii?Q?O8a3Scc0ePU1xZKAwyG4TmM28L7zPhQy70PpDa0cW4L8tM7YGP6BeMIHvgn9?=
 =?us-ascii?Q?2xKlVGt0IvsR9X52cNCLn2ZuvkZ/LHxRPdAXiJNXaKwTwhfIPwnY74TFYBld?=
 =?us-ascii?Q?6QhNnv5cRqZ6t9AhukRmfQfdopdRbLlEDoZj9rz4oT9KundDSu7+iJpbxH3Y?=
 =?us-ascii?Q?nPcaEPGTav/0nTVsP9xnGe4JA6NFUuRHAI0DYZPNWNQp0t1819PKYTdhPB4S?=
 =?us-ascii?Q?bR18sLOfTp1Wym/neB2YbDbMjDpZTyMJ03kHDWr0aAdR/6vFIrm63IaFewhm?=
 =?us-ascii?Q?fEwdPDX1Hg6M8WbiNaxSeW3azedZCTWTaasFSM1Hln0AnNDa3GP+4E9ieNOG?=
 =?us-ascii?Q?Y2UJXknbVhp2UCiyRXK+qaGsWxMR94ItAN0eZr0s1ejUWUBc8RL04uTePFmr?=
 =?us-ascii?Q?KB8KYaw0qGmBMIJm5j6VRlFYqLpKEH5LU5cgAmJd7AJrM6U3qZ4RzWv+Xo6J?=
 =?us-ascii?Q?ftGa6dwmR0xO4NnfdCJq3xhznSNqxEa++fRtgHYt/lZQQV3Ss3YmKeFbDu3Y?=
 =?us-ascii?Q?J444hp51LyIOwOMi+dNiD1jmiJbykB8e9mQ31Hda295mghWE0TePPdVmUUYF?=
 =?us-ascii?Q?9/Y5uNNo16a/uwdkP6GnYlPgHwx6WElgswufBDr/B3CtPhIWXvuW7yAHxRq5?=
 =?us-ascii?Q?kVC5HbJP+mzvge9ruOTyAHCV04CJ9+L5DM+xUfLUmYCmxHVOSEzG6Wdswuij?=
 =?us-ascii?Q?dwJoZdJwwN2dUDNRjzn/0rwHeD3s/mR3ywQ4woejN60ES+myunKGoLMb013R?=
 =?us-ascii?Q?RwR1j2qkOiseVPyrjr7H4w2c4rJiDEZmOV8sWYrHCqn62woMUa0CHsBOM5zn?=
 =?us-ascii?Q?MWfeElBpB4k5qQTymFp3S2wZspfsp/fr09Dxn7gv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd39baf-5b70-452e-dcd1-08de214d3735
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 18:07:45.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQRvFU+Jhbl03As3mhIb/pj+48d2I0yz16aLJS9gY8c4cr4BzEPScperYuj6EqShtkyr+RRZFVpuLRpVRH96yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E

On Tue, Nov 11, 2025 at 07:43:19AM -1000, Tejun Heo wrote:
> There have been reported cases of bypass mode not making forward progress fast
> enough. The 20ms default slice is unnecessarily long for bypass mode where the
> primary goal is ensuring all tasks can make forward progress.
> 
> Introduce SCX_SLICE_BYPASS set to 5ms and make the scheduler automatically
> switch to it when entering bypass mode. Also make the bypass slice value
> tunable through the slice_bypass_us module parameter (adjustable between 100us
> and 100ms) to make it easier to test whether slice durations are a factor in
> problem cases.
> 
> v3: Use READ_ONCE/WRITE_ONCE for scx_slice_dfl access (Dan).
> 
> v2: Removed slice_dfl_us module parameter. Fixed typos (Andrea).
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Andrea Righi <andrea.righi@linux.dev>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  include/linux/sched/ext.h |   11 +++++++++++
>  kernel/sched/ext.c        |   34 +++++++++++++++++++++++++++++++---
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -17,7 +17,18 @@
>  enum scx_public_consts {
>  	SCX_OPS_NAME_LEN	= 128,
>  
> +	/*
> +	 * %SCX_SLICE_DFL is used to refill slices when the BPF scheduler misses
> +	 * to set the slice for a task that is selected for execution.
> +	 * %SCX_EV_REFILL_SLICE_DFL counts the number of times the default slice
> +	 * refill has been triggered.
> +	 *
> +	 * %SCX_SLICE_BYPASS is used as the slice for all tasks in the bypass
> +	 * mode. As making forward progress for all tasks is the main goal of
> +	 * the bypass mode, a shorter slice is used.
> +	 */
>  	SCX_SLICE_DFL		= 20 * 1000000,	/* 20ms */
> +	SCX_SLICE_BYPASS	=  5 * 1000000, /*  5ms */
>  	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
>  };
>  
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -143,6 +143,32 @@ static struct scx_dump_data scx_dump_dat
>  /* /sys/kernel/sched_ext interface */
>  static struct kset *scx_kset;
>  
> +/*
> + * Parameters that can be adjusted through /sys/module/sched_ext/parameters.
> + * There usually is no reason to modify these as normal scheduler operation
> + * shouldn't be affected by them. The knobs are primarily for debugging.
> + */
> +static u64 scx_slice_dfl = SCX_SLICE_DFL;
> +static unsigned int scx_slice_bypass_us = SCX_SLICE_BYPASS / NSEC_PER_USEC;
> +
> +static int set_slice_us(const char *val, const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, 100, 100 * USEC_PER_MSEC);
> +}
> +
> +static const struct kernel_param_ops slice_us_param_ops = {
> +	.set = set_slice_us,
> +	.get = param_get_uint,
> +};
> +
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX	"sched_ext."
> +
> +module_param_cb(slice_bypass_us, &slice_us_param_ops, &scx_slice_bypass_us, 0600);
> +MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]load (100us to 100ms)");
> +
> +#undef MODULE_PARAM_PREFIX
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/sched_ext.h>
>  
> @@ -919,7 +945,7 @@ static void dsq_mod_nr(struct scx_dispat
>  
>  static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
>  {
> -	p->scx.slice = SCX_SLICE_DFL;
> +	p->scx.slice = READ_ONCE(scx_slice_dfl);
>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>  
> @@ -2896,7 +2922,7 @@ void init_scx_entity(struct sched_ext_en
>  	INIT_LIST_HEAD(&scx->runnable_node);
>  	scx->runnable_at = jiffies;
>  	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
> -	scx->slice = SCX_SLICE_DFL;
> +	scx->slice = READ_ONCE(scx_slice_dfl);
>  }
>  
>  void scx_pre_fork(struct task_struct *p)
> @@ -3774,6 +3800,7 @@ static void scx_bypass(bool bypass)
>  		WARN_ON_ONCE(scx_bypass_depth <= 0);
>  		if (scx_bypass_depth != 1)
>  			goto unlock;
> +		WRITE_ONCE(scx_slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
>  		bypass_timestamp = ktime_get_ns();
>  		if (sch)
>  			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
> @@ -3782,6 +3809,7 @@ static void scx_bypass(bool bypass)
>  		WARN_ON_ONCE(scx_bypass_depth < 0);
>  		if (scx_bypass_depth != 0)
>  			goto unlock;
> +		WRITE_ONCE(scx_slice_dfl, SCX_SLICE_DFL);
>  		if (sch)
>  			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
>  				      ktime_get_ns() - bypass_timestamp);
> @@ -4780,7 +4808,7 @@ static int scx_enable(struct sched_ext_o
>  			queue_flags |= DEQUEUE_CLASS;
>  
>  		scoped_guard (sched_change, p, queue_flags) {
> -			p->scx.slice = SCX_SLICE_DFL;
> +			p->scx.slice = READ_ONCE(scx_slice_dfl);
>  			p->sched_class = new_class;
>  		}
>  	}
