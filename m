Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792568587;
	b=teHHQF3At8NUWdgjytPaCO7KIcYp0VFqtlZPQVNk6NvFUe4/edZU8TYTNBHVjRkMwcbp
	 YJ7BYHwcaaqZFGyY9g5PtQwIolIqq91YTbqLfpg1A6/ny5AiEIKQmKQ4v4sGlTA2Jxr7i
	 YrkBNArUbPIyzJmA3qvt4ySEhFpKWa3B0bPAl7OznlnsUe7tedzZGeK32RidS7HbrfqMR
	 DEfQPq9VRtDGOxEV84WpC1EopzILZllMK8Gm1T5vcq3xyDlvx7IRi9TuYs0BypVRQg3vk
	 yatO2ZpKfiLJwwEl63CepqK6kuSiFP7edO2UD5BVSYUAWORwdRYG+5bpzr7Oi/LzeSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568587;
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
	bh=aSQcvITll7wH57L/2aSjQ+aqI8gm9ERD2id7WlCyn5c=;
	b=dxVnSUZSpw3VrsknnCVUCEP5sPwqjWmI2+o94sjFBSfagHMl/fFLa/chDY/irKZXY41R
	 DsAgX3sqhOWLh8skD4KCscojyR0Hy44wMsU9Cm4d6b1HFnXIX2XEMEoYpNS/cp/50LA4M
	 YKhNNidY3rpxjWbhNa19KUbMyo3IeKYhfsxvFyYscc6U9U4tu/bOawwOOBAYR5QHK/RZf
	 0XmTTIUAkFTZmdKN3e6wPwfmXk7WVGyJuXxpOhmTdm2+7M9XVEfX+1cRDeZCa6QK+VDHc
	 wxV4ngK/nUV5bXS5qn/8gbwgafCsbQNoKzGkaYq+XsTMIf7mLnCeWlr5hLXe3tpfUFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ugdDEe45;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.65
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F077606A319
	for <sched-ext@lists.linux.dev>; Wed, 21 Oct 2026 07:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F077606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ugdDEe45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjBWpu+E4XXwUMXsCwakSR55685mip60h5MojukNSJShcYYSuoaHteKjSmXxsJ8xrNJ1KnRcpLMfEIgkkY0w+wXlJsX7vjmYFFca+5OOq3ijCq3iQnXzl8D7uAzBTpf+pcHDli9HEQr8cuuxvhOXidYgFd3zFOuEntRfnA3YCpCCwfWP54Pf5HTJOPMd5FFI8qCoQLT5mlBQgrTUhKdRvD1iMTwb+UVtk1IQBeCmouLUtrl4VS/3jj3euMQDoMFM0BWVXmRfeU/TWWJXm84wl07SQn4LkyHfY6VSMHdCqwCSuILtNzUsmqT92kuPe5W2YxH8A5kaYeINmE9VeU99vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSQcvITll7wH57L/2aSjQ+aqI8gm9ERD2id7WlCyn5c=;
 b=LCxwZuSh4rZPP2sc2ebkZ/M7cdpY5LEH3W+eS1PWmuEh3vfYca5jLzVc9YR5jQYRL4+CkcrX+M0KHq0V9LAj9TJw0NBGrkB63Wp7RoAoRVUNLU8D6fgig87HWCwdF62Zl64qa1CT4l8g/Q8wuCADYkbBL6GzclyvyO5u9VEDkEbS4RLgcAFw/z9E34Hp+xNoVGWwUuiaY60wJvkmlW11sKldqkOROPImBfRTZkrG6VmTIHd0IM/0i3MB4WB/yE7JB5SkXhzp76XVUo1rr3Jr5Olq/OIMCv5LX6/EKey+4R7rrzoBxOlxv5i5s56KByDISYSLIlujcydsAVobR0RdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSQcvITll7wH57L/2aSjQ+aqI8gm9ERD2id7WlCyn5c=;
 b=ugdDEe45V79qtWOIFzlFe815iW8wKnRae2x7tZWXurXwhz8PvAa9oZOYTIVWW+LmVLbjifRfBfdgJsfl8L3ZwtVHDHzSAji2+iPq23CY/6cOsdfGWU6WGk5G563NyLhdgQdOQOsYBUhykEo9hnZg4gDxFAYU/8AOo/7PMdc68XljfWxBBZ3iLUi6vOSMJgLAmjzqBtRyjjGqtgVtM6yBnxAM3CpTQqXHA6pSwyDVYgJKjBrKokGeMZ4ZQE6IYZvUgf7CGIZyY9PHGUN2PZv4UiOZRAImdZipLIgTj/a5g/eq8nN/By9iTgAqN6lS/Ewi+lUNElteztinn9Y3EnUXbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 07:43:02 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 07:43:02 +0000
Date: Wed, 21 Oct 2026 09:42:54 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Hui Su <sh_def@163.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Reject oversized automatic CID shards
Message-ID: <aths_re-QX5Er4Vq@gpd4>
References: <20261021064946.1445728-1-sh_def@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021064946.1445728-1-sh_def@163.com>
X-ClientProxiedBy: VIZP296CA0023.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::16) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: a736f1a4-60fe-407d-290f-08df2f46ef80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	UTVqct0aWwLscMFr4hyzPxFs7EW+vsp10/Pw2AlfC/O7CVWZfR7lw2ljd3mIFWhEO8OmX4mO9EIkO3Sdhx0Ek0IyBtj+/vDaZXPwiX8xcqp5tnucceWrqfxv2rfXrfvzAX3/D2gie/d7hiUXJknefGCkYO5ZjnsXZ2NtGYzb3LE4XlUKXjKasdqae1Sw98ZCUQn6CXB64cd1wSBML7psxqkglu4m20QNEdSPn/PEfMeIuaGHXPXTPbpd0FqkvcZt3GjobV0s1AOJ2STJlKiXC3tRN0hmV3uf7oyVpGhDB0M+wJB/SDbERZzlq/vZXWvtZKlxBkxC5POyQggqjKS8qxZpwut9JF3Deqa6TBCGqEXPNM69lI9D4et+63LfF2n0TAOEfwEiEXqVuRocnjcqUav/EOdy5HjdkNi/KmLY/hYOvB3GN/q9uZAyoVkPiXkWRU8Z6ia7/3tw1z9Q1/1qXpdJltBWNKGC6QuWOjuFde9ogBCrfru9/A5QuCfQ8EgCsmj/Fey82H5RvU+6qK+A3lJpA2MdAFtvJ864fUGbTzHYublCpuIN8lPb9l0eVsZQt5RUzB5WoRsS1J3sGbzocApp5+W4xDzzE495bm2ANmv5cDXrtDhuOk8QqZDVPciKfv7UV0NMVosQkUaYUL6nyQKAHv4ylbI6lh5SBcSPUfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8V0G8MMC6DV7PD1g+pFpt8TLGTb7CHeEvHertLYTtmq5Cwt++EgB1KtZYNlx?=
 =?us-ascii?Q?9r1ePRu0RUuD7dklF3FJoJHT1JheOBgXB21WSjQzOKiIvTP5n2cop3p/ykk3?=
 =?us-ascii?Q?BAGhQowVLy2osYCwwUNZ7TwfcfLygFWo1lExddnYu53OKKQMUejOO/pb1Aq4?=
 =?us-ascii?Q?hEnTUr6UHSjc7U36IFMzDTRw7NiGEh/S7nird+FfuaGPD66xLGzWELRugzfF?=
 =?us-ascii?Q?+0yUBPdDbH9BeMjP2Z2UYc2dwWwlK7/YjY2zW65PYXWLMcJpAG8ALUuZqWKu?=
 =?us-ascii?Q?S2FAbpVzVg9gwI4PHtx9l4V8vq9NOdwevHYi/ywVfAzeJ/HPTOa2UfG7AWDA?=
 =?us-ascii?Q?mnH7IiEWANAwK+FAh2GYpAQ2gkvYUzwtAG7H1/vNdGBGrITT+6NfnlNXkBhO?=
 =?us-ascii?Q?J3zc5Uni/qH+fkcZGs2sg70pNeYxCn1BHoqnVrj0cvwtHpAurXhsVDiu12M9?=
 =?us-ascii?Q?+iRwTyp26gib2Zmzw9R1aHjN9FYKiWOuVUvhunZoEFKejeCKlsfdDZxkp99m?=
 =?us-ascii?Q?zbp4ef5EF+rAYhdWXlWs/mEzNG7lPvo2zNZb7vruneo+JFkQNpZdGkmWaV5F?=
 =?us-ascii?Q?kDZWD7CI5gwD9pR5zG5pgsW7W2m1HZhy1SfYoWoLTiKsQzpDpRklfTKmlFvG?=
 =?us-ascii?Q?HRmkex8PORDhp+Ciqdd1YSluvBFnhouwRCSMvQy6PvKFkmYfkDCZtDG2Mudy?=
 =?us-ascii?Q?LST4SoHy+l1uFP3Q8mJqIgHJqvOe8iZ1y8WRiPt7o7qwut4XAkJVkHjuORUn?=
 =?us-ascii?Q?kk5smj104ONm/v4RqT7H3Gc2FF73Zvj8tUstEHL/Zw6s4y52uLkAnlqbXF37?=
 =?us-ascii?Q?REJIXQqPYXAMuqKUt2lm8Xo6jQNV6JYRcOme//iJy+uxd4fV2F55TVSgzspw?=
 =?us-ascii?Q?zwYVkRVFUZCviUw4DDyN90pS1XQK253wGA36tu12Cs1U0of13FD2fQpwWes4?=
 =?us-ascii?Q?VV1UzH7hHvhlIfJPbwFpkqanH1OuWiQhjo/FsPcWlCsY8ZaS9jABJx6NTQpd?=
 =?us-ascii?Q?34g58j/Qpn7psCIWkqPxzEpS0bNJ1mdYr0ATBBvi4x0/O8fmhnB3Z3lI2+0p?=
 =?us-ascii?Q?LvBtfz4v9vrpSHCZPIByCFvgJQI2JFpejx/otnsigeCyQRMzTLfS4RXZjpy0?=
 =?us-ascii?Q?HsQvfKvAwfbNbCKlXY2dBFjLde7R0dQWZmmXeXBFflvhCHxbo2nQ//g/7EIE?=
 =?us-ascii?Q?dKBkyylfy5TYW0ZzSXlMvVuk/pL0I2IsjP33tNzRAtQ8dsk+4/RVhcKw7K3H?=
 =?us-ascii?Q?iqc8Howyt1wrAcdAvWGYodK58tfbM6cRPRh1GKbZ0iHY6Jr2nY1vZRv9QHW9?=
 =?us-ascii?Q?HOHNJ5b9Ifa4XFT4kuE7E+LRb85PikLQLO9Qb7T+F5MxS1hRoy6vWcAIP/Uw?=
 =?us-ascii?Q?/qwqNZfcvZ/+zNS1KxwQgfCykpXJF7zkuMZKfoSxKdLYFesoV0EROU/wsO8F?=
 =?us-ascii?Q?QIgQuMmlGUwnY4SAC0jGxe33qnQnJy/0vSZQI080y5yN1j2e2c/id6fLtRPz?=
 =?us-ascii?Q?vesXhvT2jqvh1BLFdpVA8YwENtpI2Zvq96BADdiOs9XSb0qQk/GJn1V8Gkh/?=
 =?us-ascii?Q?suUQAG9bJqxgWeJC9fi1dXhbq51yCrv9YUY3s1si1B5Sclgdmni5UzyLEkn4?=
 =?us-ascii?Q?kc0Wmq4AvymTq2+EYgo1Xdt/dYveOZFyN4O8UlBGTTMM3r+OLKJby2ZyXvkx?=
 =?us-ascii?Q?562SBpxyDocZdgj5pFzqMO8bAU12sXwAHUnoR3NUlLmDNvB6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a736f1a4-60fe-407d-290f-08df2f46ef80
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 07:43:02.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z323wA8fe2yXqui8qMNNkuvqXlab+awesR/AFZNq8FsYd8bHOYemxA/8yg+exuuTLVVEq3IRC+Whk5lxQoOzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB473522

Hi Hui,

On Wed, Oct 21, 2026 at 03:49:46PM +0900, Hui Su wrote:
> Automatic topology packing starts a new shard before adding a core when
> the current shard would exceed its target size. However, a first core is
> always accepted so that cores remain indivisible. An indivisible core with
> more than SCX_CID_SHARD_MAX_CPUS CPUs cannot be represented without
> exceeding the hard shard limit.
> 
> Per-shard state uses fixed-size inline cmask storage sized for
> SCX_CID_SHARD_MAX_CPUS. Passing an oversized shard to alloc_pshard() can
> therefore make cmask initialization overwrite the following fields.
> 
> Reject an indivisible core larger than SCX_CID_SHARD_MAX_CPUS before adding
> it to a shard. Existing non-empty shard splitting already keeps the total
> within the hard cap, while an indivisible core may still exceed
> cid_shard_size when it fits within the hard limit.
> 
> Fixes: e2c841b91bf9 ("sched_ext: Add CID sharding")
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/sched/ext/cid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index 4b08866d75f6..3c38650d78d5 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -287,6 +287,9 @@ s32 scx_cid_init(struct scx_sched *sch)
>  				 * empty shard.
>  				 */
>  				cids_in_core = cpumask_weight(core_scratch);
> +				if (cids_in_core > SCX_CID_SHARD_MAX_CPUS)
> +					return -E2BIG;
> +

This requires more than 512 SMT siblings in a single core, which doesn't
exist on real hardware, but it's possible to trigger with a synthetic
topology (unlikely in practice, but not impossible).

In fact, I've reproduced this with virtme-ng (and CONFIG_MAXSMP=y):

$ vng --disable-microvm --cpus 600,sockets=1,cores=1,threads=600 -m 4G \
       --qemu-opts='-machine q35,kernel-irqchip=split'

Without this patch, loading scx_qmap triggers the WARN_ON_ONCE() in
__scx_cmask_init() and then panics with stack corruption in
scx_bpf_sub_caps(). With this patch, the scheduler is rejected with
-E2BIG.

However, the only thing reported is "scx_root_enable() failed (-7)",
which doesn't say much about what went wrong. Can we report the reason
with scx_error(), similar to what scx_bpf_cid_override() does for
oversized shards? Something like:

	if (cids_in_core > SCX_CID_SHARD_MAX_CPUS) {
		scx_error(sch, "core with %u cpus exceeds max shard size %d",
			  cids_in_core, SCX_CID_SHARD_MAX_CPUS);
		return -E2BIG;
	}

With that addressed, feel free to add:

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Tested-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

>  				max_cores = cores_per_shard + (shard_local < nr_large ? 1 : 0);
>  				if (cores_in_shard &&
>  				    (cores_in_shard >= max_cores ||
> 
> 
