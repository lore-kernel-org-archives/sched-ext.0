Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E12DCF57
	for <sched-ext@lists.linux.dev>; Fri,  6 Feb 2026 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361430; cv=fail; b=pPCyd2Qu/0izldkyf8LFxBX6H/zduStBERgYazwq1dYbhwwQEUeaacANgWNutUdNn4OT3rt1h6N8Lab1Yeukc90Uu+tx8NkphDX+k0cZag8/O/8QLbYNDDzKRAU376MYhMt7dz6Xz9exJWjRh98sMzyze9DAnJ+banUciteb5hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361430; c=relaxed/simple;
	bh=EZVYrxfS4Scl5HOR43JYSruGfujv9WCohHP4az+hwAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eIvhBr5oxR5iitTlAJ85mnF2xPQQzvl9jVQ0Sh7r06rFzZzFA0XNBj7STENeJMUBiz91EdKHmJApxTaWtRsouGdSzZ97pdad6o9qcoLsTLhM2ATCIoxUdBTNF+aQtxZEsqiixMhSjvWdBQQ0VNuoegn/Kn3BYK9QKnUQ/Iu107o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TLybEpf/; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TLybEpf/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRs02NET2v5gwet2fwacXDoaNKKD19t/uLDWe/mXarP2OXzFrPBt+iNyXCcFaLYyHQgPwE8Sk/kVY8uu739ITKPZ5zIx7iHbmzMnLOoF5zGRKO8tQq1EERj8vkuEDjssJmYX6PSxnpLPC4zFtUHsYQimkFoINtB0uxSlHNwQ6bQ1RH9K5CQE6LXIieBugc554Fbrz7U9aQaXVR3roYslmUNgHrtITopAWSTT0HvYS5v8trBRpvKNDNW/YyEyF6WVq0FkA6HgIp3KN/i1f+FtssroGgmxVGfYkNQ1s9Le2FKnytUch/v1WIcRkbJ8wfHSVww/w3xfZ8reK962LHs5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYZ2P/YdPb3UTjOd1U/kqr57AefAAfdht0h0MigvV5I=;
 b=rzGyiQBOnpy64/mDoLS8i+ZU1S9Mh727h/SmfmHY9wwo79Nd9qjxDd675vPTmbfm+tqYUC3UWZuVcckfLfULzNx6NwNJQNPpHsRlN4tONmCRRZ+lGbfOm6xoZppX4CVWcSqSpo7sMQGds2GUmv9RF4ftkMIZ0pPh7YwRaGkIRj4DWxHZvDpx/gCngUOs9SGAbV840v4ABorNYb0l9XRVHtgl4RupQO8AalH285Lyl48tQ0T7cn5ppIbjljqX6q7tEaUyxdgTX0Hnoo0YX3DgqZWKPQKWqtyArQCWDh5tP89khSNiLhCUoP9fok1BQpVp3yq7GdZ6nOAnu/V/hYVQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYZ2P/YdPb3UTjOd1U/kqr57AefAAfdht0h0MigvV5I=;
 b=TLybEpf/SbE2JHj/WjSGa8KZmneRMD9SWBDto2ZB2EfJ4ZvKh1hAgZCi4PaQgXqHX0rqjr493h8aRpKoQhIPLfRMjxS6uqA+RpiklHp7qdFvhhNV7//rxY3FOct6V9xKYJpS/KOTV0YuZEP+Sp6wbSbgmXqi7Mqma8g/IoxlJJrsN+V2V2cIlEl57UY9oaT/6SLt+iAivCffr6PATMk8LLTuu3cIkBOCC8nPdVZAx631NGeNV9Shf1GujwyxyWjPNafu87eHqCVFMuErdqjCmr6WqmyerlIBK5bPPcQTnc5Mb5gC1+ISenoO9+c8ldC8sRvtWPuHa7xFuMXycsei4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 07:03:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 07:03:46 +0000
Date: Fri, 6 Feb 2026 08:03:37 +0100
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	suzhidao@xiaomi.com, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] tools/sched_ext: Improve BPF verifier arena detection
 workaround
Message-ID: <aYWSSVDwOYEruRb2@gpd4>
References: <20260206041808.170926-1-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206041808.170926-1-suzhidao@xiaomi.com>
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 393ab3da-e35d-4362-3da5-08de654ddefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f179GHIYD0QuuA9Yu9Nib4ihLpkvV+ar2/fm32JtNM2dvQ+W396q5U0imtF/?=
 =?us-ascii?Q?FJRMNSzjzxlG/CXYtLkgpKMHhZSnBjxyZEpHFLlpqOnClY2PwjjGsyCTgCM6?=
 =?us-ascii?Q?2+UNunJ4r+YHARmCn5fh0Jmht+V61lFUhFPs3YxX2XHlWtX6IcqPnVgGP+AE?=
 =?us-ascii?Q?W0NfN4Yy7iHjrIXLPcdwFfBEBiSUsqjI21B4WJkhmTn0W+jbJ1CBv3uGgJXE?=
 =?us-ascii?Q?jr2oXLQDC1Nq8XW769pODW4LOroRKpKmaAgoKZbi66c8Jab2JkJ2BOB2NgCF?=
 =?us-ascii?Q?oidD9EK5fzuqoVXs8mV3HvXgBZ4DIgD3C1/pX2hdgzW0fmCuK/9R/l4fQZgs?=
 =?us-ascii?Q?KFptryqiJRAW6EBVl53NqbBLntHSJHfChuEKAvdvXfbdux8Zl+QcqzSq1tJZ?=
 =?us-ascii?Q?DeFe4kOqvQ//S5x3dV4So9Bx4LdeT6lHz6WELzJ4heWsOWOv9JIt+T7xYscA?=
 =?us-ascii?Q?pyiIGcWY0Kte5kQKdm69n9iGuES9VxvdODoR20Lvh1S7cNwsIJhDUCbDfCiW?=
 =?us-ascii?Q?vMjqxOx+TwCP/kKlVPulKVHsCv1M/uVAizu/2c1Joz1qoo12XXAkIo3ysQSL?=
 =?us-ascii?Q?5BKQM/qkqL2ZGwzD6V1sqQF8cVflKK8aNpCmYb+qCoqFQfSvbFhmtltUelMH?=
 =?us-ascii?Q?qr06GGX34qoVXSelug9pKTn9Ygd/wNmJVHJeJWf0EV+CIOy+4/oPwCoU9Qwn?=
 =?us-ascii?Q?AYi7brxDW610vR0i8DasmBSKp0pkxhrW8xXGkjEWTpGieH9TMhoVXYvKbjCq?=
 =?us-ascii?Q?I8owwXBje45NIj6S/PwiJXGvvdXF600ZnZBCC49RDJ9NYpzN4AIHhQ/TYpgA?=
 =?us-ascii?Q?Hfo5Sw8zcRIYaO4AZde2D1CxPrppIrJs4+55ddXElqJ2W7U57e6h24iS+0CM?=
 =?us-ascii?Q?brwh8aRchY/IJsLwBibJyT+synBqKkRWZIvSPqUmeRtlLku7ygcHHmXvu89W?=
 =?us-ascii?Q?WnFMroBNNvNKvai4ThzokSgDyYw2QNX3ZIVfOjyjRx+KQ4/35FV4hZTpQ/Y4?=
 =?us-ascii?Q?d4f4PfSQ8Wf4A+DbWavb7FeX5D08qgNqt53QndGi/kJ+G4x3tVJytbBcFjWR?=
 =?us-ascii?Q?3Nayvhxrv5n5g1Q9/vWEtVm9x3I45nUJf9bNNPi8/zHczUFtOpbrZX9j1xXg?=
 =?us-ascii?Q?g5LXho2+NSvbUbDk7qxo7F7fVvTKq00i6wxKCYPfYx0xEhXNMZrzpMzcNfU5?=
 =?us-ascii?Q?I2N5NYMgpaAkxewLf5gWUL60gstr3hzZsNeNKipsJEnJvRpY/mzIS0N99UJe?=
 =?us-ascii?Q?Lv5EUhmKwAemiFyiY/SSh/uKJdPVyWw4mqC1+TzH6H9NEco74o3U1XE3E0Q7?=
 =?us-ascii?Q?HlQRYz/sfbVGTKIY2VEbVYy0KZESW50n1PEKSqWUDtAgXWDE4uVYfw4tmvnQ?=
 =?us-ascii?Q?W/IRZ1gYLTAorthIEnIahnlSEdVzO0DYoD/3RhkT3JjebvrYlMPVMzuXD9/0?=
 =?us-ascii?Q?+I9gqPZZ3zfeRPUHFpFMsUcM96Z64yvbVDuiXQiCzbcRAysapUs/TstwntmZ?=
 =?us-ascii?Q?k4/YQAnyZdSo5VfU6gY1fPiUQKS8z5oACQgqs6E0sApF5Kf8qdBiBFMqYDNp?=
 =?us-ascii?Q?iKNJmzO3mqtAqm4Nxkg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9P0tME97QOLXZ4ORPtui1N6HAkmyHnPCOy6PfmoXU8GlFL3id9EzItJpFg5P?=
 =?us-ascii?Q?4AYOlrzwG9LF7ZEXIu//V1Vu+iDTLVVhAcfks+TiXL8Tu4etOHFntC/9gBDO?=
 =?us-ascii?Q?oXsMGsGd6YW/P2Ek+yDx011DdVJfFVDu8ZJBRscxxDrBt2Fcj+eOzezPViwF?=
 =?us-ascii?Q?8ps2B91xfJn76PKKSPk/0Vt/EvmEpi0pFFvY0GiCgi+HDRlC3rVa+JzhC0W4?=
 =?us-ascii?Q?oeU+q09ZYy0tuOl0XQQJY5Q6zn6NU+UlTSzFDpLt3Fw9PjkhBXycPJd3cfvj?=
 =?us-ascii?Q?ZGeuA7uYNYl43Clq5kgNQChltrO1RM3deFrrCR1PGmf9pfrsNwn49nYQ0999?=
 =?us-ascii?Q?kLdJlwZX/ri+WRrvVWF6smsJ7lwCWOZlp0Fm+bdaLWWxaWxzxRalP81IrDrn?=
 =?us-ascii?Q?XcrKZ8lxZlowdOL0J3v+te2xS/vX8M/lxp2qy2gsY+oJ+Wt6SmxKV2UGSunU?=
 =?us-ascii?Q?lmT3aYCXfMaJ12kBqABK90qMWSCoLNekUDPoR3wlBCtMN0RVlZ4CThLWXA+L?=
 =?us-ascii?Q?1smd7PoWAX3GppgvwJQonqPsJ7ixipvUri5B42StCoXeFsRPyl7suUgg2tTi?=
 =?us-ascii?Q?USDzc1fy4UDsxl2q8wVWJuw8aWAtNCWNo4iijBPr6cNEGOzzA7LRtN44lHUU?=
 =?us-ascii?Q?l/bABMwPQTq/1td+lWQWGb6eu38KQOQaVEMJMmeF/eV7XT2VzbPBf7L06LCv?=
 =?us-ascii?Q?Z5Qlw8ohT4wAtBOQBUvGlwVIigEzkXMf2mUOF/Fo625p2HgjZMhyLrljlWOx?=
 =?us-ascii?Q?HLyY/cn608A1J4bsxXTodchkm1wDaOvL9T5PxKwQ6KK/qlH5APgvVFJH6FPq?=
 =?us-ascii?Q?O6TGNkmizjSp4HeZJ5TRVYSqu/j476ZaP8whtunKjhwKC+MXMnFfFxJekOs3?=
 =?us-ascii?Q?HUj0jZ8T+eEzA093nig+qjto040DNgl1RUfjiHhpNesAD+xTzrBi2VJQSPcY?=
 =?us-ascii?Q?dA0iHRHmp8NBHV6egHnOXoJK/8pRobkMGHbrv1LCzETgb2AYr0mfp28aj5KL?=
 =?us-ascii?Q?Hea1tLavbTkIa5KeCetHhnTbcAXVLGj4rZARqpjgwKPMyanMtBZrctgo8sMh?=
 =?us-ascii?Q?UQXlZta5U15517YHbvA2C4w92ixTc1/KErC1xNg5Hadp7spf3G+wKwh5BRG7?=
 =?us-ascii?Q?D64j+Gtg6D93jWe02P2uviytWN+xk6BuTTIWLjmOXqHEZh4WFHrnnFHoUJSn?=
 =?us-ascii?Q?nsq76ajcRaBlOKcZcubsGUMiheOpgpXGoohvlGq+Ju4/ztE43X9JvVDKXpey?=
 =?us-ascii?Q?l+ZpdcbiyrWjyX5yPQYqAhksPWmg+ap7PWL++EW895vC7FuWtED7kyt9C99V?=
 =?us-ascii?Q?IMc+KTm+bpkcr+XjOnLZXQvB/lDSnY06eHfoy2DV5a1yqDHeB8/JkmDY4G0W?=
 =?us-ascii?Q?/infW8DTl62OkrTXe5m28Jn8so/CjTxGnMQ8bbfpKTgve5nhwoPdyqIFplkv?=
 =?us-ascii?Q?ubPRUV3f58bac70xTins6qionvKKQbpGQYjNjF+oSwPOYSH0u3VvSHrVQmbW?=
 =?us-ascii?Q?rCaubfyuarHg0CJvKDp9a8msUirVGa3urHsde5SZkyODokdfTzGO0KdXNACz?=
 =?us-ascii?Q?+pw2dJJ0geo24yE92xRKIcTRI0M4vYBFvEihzraS4rlt7YT1/pAjxZo3XRBt?=
 =?us-ascii?Q?2yw5eth3ryrCKLJTslY1YJ4RreYEpWe2eXH/sjjEazv9sTTgwdkLO4GxzBlM?=
 =?us-ascii?Q?kCBN7i2TZ5MpqThzkzdhIQuD/teW1iTn1IY+22GL1lrewMyE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393ab3da-e35d-4362-3da5-08de654ddefc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 07:03:46.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOlOj9UgSLYX58cvKavu0E7Uj9jqZQzECvI83J8Gl/JIOzY5NC/mss3Lc/Y0Tg27Xs5F8yPQM95mgI1jiAfdBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049

Hi,

On Fri, Feb 06, 2026 at 12:18:08PM +0800, zhidao su wrote:
> Replace bpf_printk() with volatile access in scx_sdt scheduler's
> BPF verifier workaround to eliminate console output while maintaining
> the required LD.IMM instruction generation for arena detection.
> 
> This addresses the side effect issue of the previous hack while
> preserving the essential functionality needed by the BPF verifier.
> 
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>

Adding Emil in cc.

> ---
>  tools/sched_ext/scx_sdt.bpf.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
> index 31b09958e8d5..13d3060c99ff 100644
> --- a/tools/sched_ext/scx_sdt.bpf.c
> +++ b/tools/sched_ext/scx_sdt.bpf.c
> @@ -64,14 +64,10 @@ DEFINE_SDT_STAT(select_busy_cpu);
>  static __u64 zero = 0;
>  
>  /*
> - * XXX Hack to get the verifier to find the arena for sdt_exit_task.
> - * As of 6.12-rc5, The verifier associates arenas with programs by
> - * checking LD.IMM instruction operands for an arena and populating
> - * the program state with the first instance it finds. This requires
> - * accessing our global arena variable, but scx methods do not necessarily
> - * do so while still using pointers from that arena. Insert a bpf_printk
> - * statement that triggers at most once to generate an LD.IMM instruction
> - * to access the arena and help the verifier.
> + * Workaround to help BPF verifier track arena usage.
> + * The verifier needs to see an explicit reference to the arena variable
> + * to properly track arena memory usage. This generates the required
> + * LD.IMM instruction without producing unnecessary output.
>   */
>  static volatile bool scx_arena_verify_once;
>  
> @@ -80,7 +76,11 @@ __hidden void scx_arena_subprog_init(void)
>  	if (scx_arena_verify_once)
>  		return;
>  
> -	bpf_printk("%s: arena pointer %p", __func__, &arena);
> +	/*
> +	 * Use volatile access to generate LD.IMM instruction without
> +	 * producing console output like bpf_printk does.
> +	 */
> +	(void)*(volatile void **)&arena;

Makes sense to me.

If we want to be extra picky we can do something like this:

  volatile void *arena_ref = &arena;
  (void)arena_ref;

In this way we take the address of the arena map descriptor and store it
in a volatile void * variable, so the compiler can't optimize away and we
never read the content of the map descriptor, we only use its address. So,
we're not reinterpreting the bytes of the struct as another type (no type
punning, no strict-aliasing violation). Even if it's probably just a
theoretical thing.

>  	scx_arena_verify_once = true;
>  }
>  
> -- 
> 2.43.0
> 

Thanks,
-Andrea
