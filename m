Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51F31D39F
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616626; cv=fail; b=JA0yPoFhbbywz5wi0JNWgDSVVK1YCOFAusExAvBkwywyd9MUNw5sGMJ1dbMhH27epQPnkzhVpJzc+v0NHxSA36onFOaMHFm+mXcuxW6846sjZecVMmtq5CZGgrv3RHN+KPsWhQ306y/VLsPB0hHk6W1l9B0XzdyV1T/z9lBi4Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616626; c=relaxed/simple;
	bh=LtHPV+hrfJFGS3gnz5b6SAeNmkq4tTyC4XYohDmaZCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VdfYD1Z98B1a8K3DzM9WGm+QdcKDJjlldkMr5/e6uuOUHko1VHacbOsA6lZAM1gBIsx9LUHCpuD1IYArCkC9XQTMcOSWEGLardRbs9mJU/A4gXUTuhBCin31J857y8N1yx0U+I86Fwpk6OfK32Zk68Yiu91I6Nazv3sDGzezEPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IXb36ufr; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IXb36ufr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8xKxL2VsWmTpGwWmysdzr0k3XzAHPFjw2VCPfgZHyAqkFWZsRXNKcQY0ee/YO5JSiJLH3JufKZCHh8J1lDb7KWREVhvRN+oTZnxM7WhgpqB0AMGYKPJFeGgQ70b9B0oUJwiXoO/R4057KHMnPD84M6qSe5saf6Sbke4Xg2cZmlvRAJfdE/8aoCczSjj4DKfEmUXF+aXNC9kdiwVtY7LwUKcvF8H42Nlqs0lYRBJGuQt5uwjRe4qkPYYnJNguni8HWR6TnmWdwiTlhlEgZq1V3wLPkr7RMJ/p/4d8hlcZfO1sGd/oQiUd0zHQ4jsu0+wnglX8exftIHQM+RMb7EjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdPX6kpitNcQNeg452koJoi+eMSPy9RVsX5HKRunUE0=;
 b=nD+15Tk210B6iHYniM3URJtGZGQ6GM/ijiiQ6R86I3l0cn3zALOvRbYgvl/r2C4d9TsuLUY88qfnZIKm4/TL9OQnjlRG6ymHYUGVfH72m2NfjA7KXJWR9qElO8NFWpzUiGScDmV4MkUfK73uJjX+incpDoCRnKuR3NHv2iyqv+kHzU9rIFvl1fH1rOO919LzZ83cStGWFN60ub2D9EQ1I5C6UEDSdEuA+Ixeivi0chWGLYhz5QqswDptm8vTW5QvLt4YNrwHSZKL40+SOeCwI6vV1sVVTBb4j5Zv7NvowX62R+xHhPpEoKFKNFq2/psy5p/hL51U1cxZdiXnAyfEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdPX6kpitNcQNeg452koJoi+eMSPy9RVsX5HKRunUE0=;
 b=IXb36ufrY9qsxAY+peu70oonFn4dRYbVR0tCRw9YHyyq19QI/qdLGMIO+2oi6BMPoIRUNPjSl6w2YnVR242CH00DSZfJsIw5qhPdzWzHhkbFpAkf/0x3EOSdq6SXyEhPTSUsGbuB2EzI4q09/GTt5e1fvjdPJZ+TBCOCUeRPwk7l0v/O8hF+sKim80S2Qsq8aMu5S29Y93CCtest1UDEWm/pmFgkxzRusv53e9Ssr7zUcRta+TdVXYZaVcQwMnDsgtnAcCHyGfiiXVS/smdDtIi0PK0CQwgoQ/DxZMbK4lSaMbVp2UktXoacoMdVetKDPj0UDuVrfhJAT49sgrhimA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:36:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 08:36:59 +0000
Date: Tue, 23 Sep 2025 10:36:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, changwoo@igalia.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 7/7] sched_ext: Misc updates around scx_sched instance
 pointer
Message-ID: <aNJcJTOhl77pdkb_@gpd4>
References: <20250922161436.358949-1-tj@kernel.org>
 <20250922161436.358949-8-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922161436.358949-8-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: a735d7c5-ecde-425f-602c-08ddfa7c5c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u12jYEBd/rZ/igwC7hYKuP7klpi/v4t8t11aEqKZLNkvdnLz2Vzt1u9PMbj8?=
 =?us-ascii?Q?xGpmxr8Oe/G92eTgxVoc6KhdoOI3B2MlwVU3DwsPhD4lK6UClEx4FJFCio9C?=
 =?us-ascii?Q?5Qbie3Ms9dT4Er6jXv09OZeaylOf2AufZp8bqJaemUcoBru7D7zJk6CjFFn9?=
 =?us-ascii?Q?mLTF2KlgOGoIWPlNvlI8Qxk2FmJA6DWQxmXMJj9S6sIGFvNOT9wRK9sbteT+?=
 =?us-ascii?Q?KlzNHS8QmzFEUIiRmWRLMb8MW7Au2ALfaha/gbBacWXwE8skMID4uz5ODI5P?=
 =?us-ascii?Q?S1cnIZCL/NMuE9RFgH01YDONAGMfmPdABJeLBzz4Jq6hkE8LQ00G+LzK5Mss?=
 =?us-ascii?Q?0bw4fb2L6+78pVwdUF6B46WQPz20fEhAeozhq4ve8ki0U/Y4AebeePjvrs6q?=
 =?us-ascii?Q?sBI0jbMpkx2UDHB7T9S8dVPfhdAQMQLe4/Ub0PsxMPBa0E93jsew+dtvxg7Z?=
 =?us-ascii?Q?Ch/uiZQavmq0+U+YpMfBTbgaO/i5nCRpiW5t5VwDLWQIuKgnEJkIrbfW4FPH?=
 =?us-ascii?Q?WOOWsNCsDv5DDDSLFt3g4WpqJScgtYMvojqdV8AF79BpV+TzPNmn/t/8bH/h?=
 =?us-ascii?Q?pWdpi3RcsRHDRi8bgkItz2gyDvKixrQLbZK51Kv6YT+GlSZArRtaYNMST7j8?=
 =?us-ascii?Q?dB83l5HqmL6vc1SUACYkY8Nv/o4d7daxzvxSLgwWRKV0rrQdXxembnVC5MfW?=
 =?us-ascii?Q?d3IGV6yCP1c3/9qVvgTQvCQqvUWpNfmIiDOpaVk2rtzG0PphXugROCuIEV6P?=
 =?us-ascii?Q?jdWljG0z00bpMNnSsA17vwk6odU1mpQnRMywme49Hss3KbWprUzbZ1nz7lz5?=
 =?us-ascii?Q?cRGwktCqlDwKvlFjGcybcvCMTLrQqHHxzyhZLxuAt1tMzDb1l/9ANS+Ua59T?=
 =?us-ascii?Q?nPZXv+urm1VmkvgFQ312L8blm++2knBfzOKECF3j4hXZ/v1RsDOZ969hkyYA?=
 =?us-ascii?Q?oTm34768Ja6RcRSin7+Sv3lQ8NGXv0EcvSvE7BDtXvIQz5ch96xW2dCjDbAk?=
 =?us-ascii?Q?m0WpLN0MAHgCo/EM9jVjgpE/VzINb3bvzFKVbY6yAPkU3PkOXHv9pYMA1Oie?=
 =?us-ascii?Q?uc7oZ2CcXq/UWG8d3b4mwi2qQkkjO+9ppIIa1atriyE7of331ikGvK3gcsgD?=
 =?us-ascii?Q?m69qsNT9nJ9t9yaE69IsnGqNcSwy40Jz5Pw0g+ReBCeIiv8kRUCOfO5aLlaZ?=
 =?us-ascii?Q?FOLzV31pDUhFVs4BmdcBIGVnnTHhEyZXw/JrIPU6lWyBEUPeTTW1gsSA+NX5?=
 =?us-ascii?Q?apqAOD59s23JLbVmJyrePtL8r8IYgSpu4TE4yNiDX1ouVtaXcIqYWXLeP8lu?=
 =?us-ascii?Q?/4HQ8whjyBWqMAj7QsAr14jyuB9KQgUX+6trkSG++H2G0AKIAllsPHS1EZl8?=
 =?us-ascii?Q?cMMtf9VxAJrnUKgtamtjiGQD6UNPfmpJ/Bm7xtlf0iuUblLj8uycsAPynVbd?=
 =?us-ascii?Q?40r7ri7PrgM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2OLtosh2NGuXYAZBgP4WiSWrPTRCI4oXonwkJBZZ7WeUCGHi/VzQV47FNNwm?=
 =?us-ascii?Q?5EoicDrSmDf/SyRkrW5E4soNooEGHcGavgxLt/Z9a2UtQeMOY26z8qKo0PTC?=
 =?us-ascii?Q?yUzpVWQ00SDeKWD2KpQtpmrso/VieLihhx6XR5aqU0noqJx4iYEfwVJ2ipw8?=
 =?us-ascii?Q?S8ZOBxRtQGSWMKhQiBoEMJUspnZ3vuv5KCH64S0JGBgNU5Jrx/g5ZZq6WXi6?=
 =?us-ascii?Q?mvhJYk8T+t+CYnkkB8cMeeL6n+fQqm89sqrKHvuL4AKqYRFgQEuPnwPeLKfa?=
 =?us-ascii?Q?E+nJArwmgv6g7Zgx2lejdvEAnQumGC4WUFWdHqa0kGScm9D4Qi2V+u53vxIC?=
 =?us-ascii?Q?oOJdaDeei8YmLyuFEJbPeDTkGwGpIedxt10iai5GA3stMJnxuYDpFsC0yrq1?=
 =?us-ascii?Q?Hqp9rC/TzASQcCFCGZGTxVb1GQzqhjwO1nNFCb0Q7hPG4TOGeOMBHPxK4b9Z?=
 =?us-ascii?Q?1xKAiDtsDp65p00xgOIFwlCx6TNqbGrJEn2yIJKIhQPJLY+2iCG005Nu1Tm4?=
 =?us-ascii?Q?Nt1ivLJ5JcLY4hn3z/SZxfmeg5NHOGrixnnN6dmYdVH+AstvldX+Zseyant8?=
 =?us-ascii?Q?fnVki/lXQw2nMRdNyHwpxRKk+Kzn9i5Cj0SzMDyrY9olqhnAqTHXgCfYE6La?=
 =?us-ascii?Q?3zT5jtoXUjBobok+y4b7Rgn//+3kpn7/hOdEdZGsYdGN0Dppbv6h7Gcd+g3i?=
 =?us-ascii?Q?5WCYj8B2J/5EkvUMG0EvPEZlC3UA6B95GCmbr+kSC+3+dylxfLkv1EVnMH3f?=
 =?us-ascii?Q?Ca6XeBbpiPBjT2Gw7klX/ax6HD1vg6M/3vvx52o4DdLodS7XvJNiMltHZkfk?=
 =?us-ascii?Q?olcPsYwUnmqbk9rm8/po+nibD/0xtVHUq1+ZXi6dcGCJDq2BJ7GtLujaCumm?=
 =?us-ascii?Q?yYD0t4T4T5X+8rMC+2h3aNdrKFREieifmdEFh+ZixrL3AC11ghM0+Km7rRCU?=
 =?us-ascii?Q?xGGYwYHPPxJJKVdCajjmDSziTiNk3rCnLVnKR+Zgbk4PVEaZ95t16sGrwW9/?=
 =?us-ascii?Q?H4GCzSPCbYVZ6OnJ9Nw//mTZlWsvBnmfzVxNMpNx8CLGarodYREFecgK26dl?=
 =?us-ascii?Q?zgU1vLgUC4zc7f2gAVqsqeEZwFpX85RuLVpDneJiwayYFCtc7Ij/RyIvqgEx?=
 =?us-ascii?Q?bJuZF8Wn6SGIdeOw0xRrXnoeuP7Mm793j8HBQgpwe4kwzpVJsdWiOvJofynN?=
 =?us-ascii?Q?RGIhUvHjCFztinUb2LghbvJFybmpKU43CZ1ZIJjMP85gGFcBGKvvA4EzeXZ5?=
 =?us-ascii?Q?dgyhn6ZxStvbscyRebk6aatBpICgWuCzF7/xICB1X9H916NBLnipN0sRNyRM?=
 =?us-ascii?Q?gORJkiPCazZD5qfpKU7RX6w4AXUT8w3eFzZNPM0XlN+PU4MoGpBgMk7OkqCC?=
 =?us-ascii?Q?8D7RgAzi8RXubB5pIM/IEpr/dcYuApsk5peuegnUZguariuz4q7e5Y2N2ZFD?=
 =?us-ascii?Q?ltURntTMspobWZHgbziwRbunc9QYK6CJnBCy+9c9swP6n4B5+J6MvgEnpGDN?=
 =?us-ascii?Q?VJVeYW0nwYXN7RWFf7VNi10fO0G8eoD45z5WDoTOsOxtInlqifnPTUCfHHQp?=
 =?us-ascii?Q?ZmKshmE+qJjf9KqOHGTyhb0QtWPLze6J4FVqqbb1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a735d7c5-ecde-425f-602c-08ddfa7c5c8b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:36:59.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zP/9Tth+hv4vJ67xwcu/cTyX8D6pD7O4lCikMpYMjd7Ye/lA+IvfyZmQzI9GFm8sfQtovI0sdmxaTVvfezpf1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692

Hi Tejun,

On Mon, Sep 22, 2025 at 06:14:36AM -1000, Tejun Heo wrote:
> In preparation for multiple scheduler support:
> 
> - Add the @sch parameter to find_global_dsq() and refill_task_slice_dfl().
> 
> - Restructure scx_allow_ttwu_queue() and make it read scx_root into $sch.
> 
> - Make RCU protection in scx_dsq_move() and scx_bpf_dsq_move_to_local()
>   explicit.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 62 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0c99a55f199b..32306203fba5 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
...
> @@ -3572,9 +3571,22 @@ bool task_should_scx(int policy)
>  
>  bool scx_allow_ttwu_queue(const struct task_struct *p)
>  {
> -	return !scx_enabled() ||
> -		(scx_root->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP) ||
> -		p->sched_class != &ext_sched_class;
> +	struct scx_sched *sch;
> +
> +	if (!scx_enabled())
> +		return true;
> +
> +	sch = rcu_dereference_sched(scx_root);
> +	if (unlikely(!sch))
> +		return true;
> +
> +	if (scx_root->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP)

We should use sch->ops.flags here.

> +		return true;
> +
> +	if (unlikely(p->sched_class != &ext_sched_class))
> +		return true;
> +
> +	return false;
>  }

Thanks,
-Andrea
