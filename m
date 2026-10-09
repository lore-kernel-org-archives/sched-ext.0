Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B93D669A
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581940; cv=fail; b=iaxlYeoSpvgIbHNFTa5UY0jBO0YyK18Elp9F4fgMJf9AXr6kLimgu38HlsmAXxTq0FcjNBueWFiOhlud/CLazYKG0ICycRFrBpDx6aAWvTDNMIuE8CVcKZs+3rHy/t6Ukj7QFnjFRbHUV8XOzkSXZukxCYON436EdIBkkkHKhqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581940; c=relaxed/simple;
	bh=K/qnf86Hffi0VKY9rplNcmi2n/ak8rBJX8UVcQGJ2nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HuS7IY6jsbMPV/tJz3GEoc/ftl4a1mwthAkcelOvRC2gjNB0al6gjOSuHIMD4pxxI7UewKAbEV/I8ENQ/2wQ5kBT+X5o1Ws70/H6D3AfyyAcBFyL4XV16evmFp56uRt4PId5wH8gicDTNH86SqkZPhocautgJ0HWjvNNBwl0LOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KXrDCWBn; arc=fail smtp.client-ip=40.93.195.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KXrDCWBn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gm0HWsziAP5uVSZLBpiZgM43WBcu73a6YHemaavoe6v4R7GWBVAzNVCfv57ArG2qJxaTf8RIsxQHvQ2f3ezJSFYU695G4MrnHLPCQ5Ylr6Y1QiIjdPTofI2DRRNdfQXouKJFHdT4u6orytANfEngFvauSq5NWxiZ3T+fml3iSvt6VkfPb8+69ItzTfTVxeLlzBOm5BZnAVZvMoMFHd3to4ubMbnURHXfMFZE7Ufz3pQVN61Gx01V7swwtxEMxMcEeJc+YHN4zMgqLMN7H8ACNyHI3C5cjl+OGczF26Q82/hnlnAYuYdK1mSFcD2XlzKihqLCWGcEZM9IAxZbPUYmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CPSoZ73eFTODBMJYxVzhFmHXATi4VH0fI5mEgVuHw4=;
 b=m9U/+EH1fmPbKX66sQcNi4LK16lJ+ga7faUF35wPKGBxIxx693XajxbDhomxigP4d8JvdaPGGQKEzd4YsW5O0cPYPh+85bk2B1CE5lySU7wJwamkh5e1kVRGlibDknwGnaHEZA7eIesolSiwUTRa8TFdkTy3gPatPFjqyM8nE76y6+w9PMxluceYDIkDB4tsEmzCH0UXQxGScY+nw8tmOOLeLrrjQr3I5Lv+yFF5sdkRIic+b4nJapVBmyb/mC/jTR+T0qEZ4ojiBW5Bc9GSvI4fDn5Bog1HCpFCT1AJQ6Ng6Soa4I31O5xs3QO5Np4gYuEto9p46yN1shied7iINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CPSoZ73eFTODBMJYxVzhFmHXATi4VH0fI5mEgVuHw4=;
 b=KXrDCWBnnb+2SA4YnhhUe2y2BE0ggVsRyuk72yoDKijSTee2K0/N8chDP7ALvd3B/qfF3L/kH+FzoTIhvM9QTbxnNlMxKLnpdlT1UJ9WUDofhpdnS/JuhLSF6m2QbU12EpR5aPbCvy7Gw3gHWRaaVe87XPdQP+QvTx4EevYcALtwsvkofi4tZEDYiPvSwkJSMIALsw6lgI0fPe9czvP8kLYDOgD2QdTN7TeefmUPqkB6fsUr55HBBiu+MaCBErLr96K9OmUZCFZFwtJD2ECFsxkW812hWlEsL12Z8wNBVM6Gn9eX+jFJe9cV4ty8s2Nt+dNPRIXIwSh9rb2/xWxBVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 21:38:51 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 21:38:50 +0000
Date: Fri, 9 Oct 2026 23:38:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched_ext: scx_qmap: Reset a child's cpuperf
 targets once its PERF revoke takes effect
Message-ID: <asle5goFd3CRujUA@gpd4>
References: <20261008093228.2015427-3-tj@kernel.org>
 <330648461b790ac9b6c431318be04c7d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <330648461b790ac9b6c431318be04c7d@kernel.org>
X-ClientProxiedBy: ZR0P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::8) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8f7553-86ad-4007-1717-08df264db549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|5023799004|56012099006|6133799003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QYSsNamI6tYZpFSMgiZ5HTbPM75MZYMuNaRcP+ujMt6z0Yu4A+YRISsTTyDnnqFmGg0Az5OIaAvyLpilj6U7n/LWlWuLXyG8E2ncffftp4W7SYPyzLoKk6uULbClduH9JjWCPOknHrW6zgcvNStAeDrTBvA/j7pnwBNyDxgOh2cSEa8XY+l5vUk4dNmlVVO6Urs1rgZeIUKbCFqz+nWHT68rekvYnovWAjCwZAYk0c3wx0HF2tPV7fjhWKvPNBO2hoNwYhOpjmWAZ7O2c0c7tqDVuez79koy1oy5U9Iy7ICJtddrFeCNdi3EJloJN3yfZyfCUA/OGK9M8bcHWkpv62JVNdGtbBFzIa5xyQsmtl+18q7s/bcKhIFh9IqsWkjoFdznBFFMPk8/sSvf8U/Xs4sH3BNtr2JgrF1M68O6h3hKtyxTmD77/jmEg5mHllVt9LbRiz32LSZJHBNV1z1JQPHqEmmk5rqyDvPfsLKVgaKONRQTnsnAYZJa7lFxdFT/fXc684dkl+08yvRF2I/6Y/q/NhOEYOJoqdDcBVjegrpw44pKZgjT4tFbFHm88Zc5U+iXM5VVPrdWmglfn+e6Ddcrkc8AC0QpZ8F2FX+5M2CWok2nG9+DlJy2rNB/0WROAIJvR2E/FeY6ndvOm8n0gFJQcc1Agz8bBB9icCFR8ag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(5023799004)(56012099006)(6133799003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J1R7EZvLayBhMzuJJuGHZqsm5O8jSKPuJigFnM0Yu5QrDadCdWK9o00myvSf?=
 =?us-ascii?Q?daaXYGIHqwuiibOJvK9Po4A0pCXS3sMAnAxWPY92kB9SpoiSnAdHPUsuQWho?=
 =?us-ascii?Q?fyZ8Nx5FOYTNxDIoG+666w4HotfOsR0/5/uwYsQR88juvD1Q/3XI0OeZNnYy?=
 =?us-ascii?Q?BHYs8OGuPpt5QXSxRu+6dYvKbKGyLdJYZZy2HyCg4ZeS1lkUIRNWO8g+LxDc?=
 =?us-ascii?Q?KyPPKe6YrJo6h1H1aqNloxsHopKXisZxsre1klfuBIyWL7ge8s74hTcjaKS4?=
 =?us-ascii?Q?mRDQtiHoKqKjjwenVJ0CcNtuZ49peHJ2IxJH2kpi2PrjpKBA+fHRKmfu/qRw?=
 =?us-ascii?Q?V3FjbI/9GR+wRGW31CTnd2Y15EaG24yICfW/un6OVImgMBkzH4w0b1q8znCF?=
 =?us-ascii?Q?ZYczBzxtpP12Zf8wg1KxNRWDcXT7QUfP4VWd6M7HcbTlcbq/0QHZxNuELsBf?=
 =?us-ascii?Q?Bfzn6VFOboy9gM0MBoSz8YL6+gwx8AVwDBQWRUK40qlacl7eGOOAzpgAJB+X?=
 =?us-ascii?Q?wQsRz/AZ6A3iRnMLte8LrOJkkXw0BJX4zpEbDNdkJ5dCzMiuI2MUHnlUBRom?=
 =?us-ascii?Q?6Gjy8yk0AVbgu1WPNKiaBxKGURAgTvZZFowJ4hft023l1tRYYvPi32CWR9ME?=
 =?us-ascii?Q?UuHiwogNr8PEky9aa3OpJGwOrkrMYXfJvNfvs8tR+aaRlGp946/ch1sviQzF?=
 =?us-ascii?Q?h1MJ49emcEYsQtTHhG7NGXkudgVuQtDXsdvPCozSTY0GnFWZfJdNDyIkfrCD?=
 =?us-ascii?Q?EtABoOwfdV0NJ4PTZAF45OD+XJRuR+tPhmnPGmqdJvUl7Wei8fCId3hDMPWW?=
 =?us-ascii?Q?Bc6wS9g/52L4ttSWeV9UCko+/tzMev47E94Wmce9TwpmhAkDAi8+QcgofDlA?=
 =?us-ascii?Q?kD+GTvqcP1Qj3G+e3c02ySSLRH/1+lgtwehIykz3QoFsOf0iew58lkcnwION?=
 =?us-ascii?Q?/PgMtYt69ChNELDaYSjNDcAPiN8T9sNM7j/4poGRHqZea4AuAiOoeJVf8A0R?=
 =?us-ascii?Q?kbOHjJc8xF01H6pGdAKPWYSjw4yaL9jUXgOUnQRhxmKbwsZ2XIw1/LGm0ysu?=
 =?us-ascii?Q?rn0He13bYNwCokeepBtKzMBz1+Sv1+WNhbeDRVkhuzU58EKqN+FXUqjsB9+c?=
 =?us-ascii?Q?BJI+v6XgMaT4WRnvTCrMRp5FhcG0V8I6v3fihAjKmzaie+BLVghm3ndDd9K4?=
 =?us-ascii?Q?zCaz74f69jfzBdz5g1rQE5YxA5nosmEFmJpxFaUihcX8u9zhe+6TA8vpbYk8?=
 =?us-ascii?Q?jkpup63pOCFUuHK4d8ufgi1sJDkpGkRsOhyTMqqYiRuhsIH9bIQkdyX4AS9W?=
 =?us-ascii?Q?hEnheokSIvn4MMrt4BJ3hquSuont5iCNbRo6PYv6YSneVqJwmKgUP4igyzSl?=
 =?us-ascii?Q?jMdsDKvtGduLkLQkaQObcPhtygPc0aT0R43Gsun1MK8hxrPIMbSwnmw1/0Fe?=
 =?us-ascii?Q?V0ZmXkqyJrokKzVsDdglNMP+MaXTCgo+BIAkMYNL0qZKxFzV9vt/Zrm1/Lui?=
 =?us-ascii?Q?Dn6EhJuGuM61inUNb2fqBQw5rZqzPLKa9VyU1FSyNsOh/sjsSfsRh8UvIcaC?=
 =?us-ascii?Q?TCvefMRMWporUuS0NZDVMnI0E2HeBnVdnYoMZyIIdWrtMQ6B1+FzYH8B80bu?=
 =?us-ascii?Q?ecQvwLQQuQV+QkKI+cNVFNo402DD4REO7IDWQeuf093W80lVGTL+QbktMzhR?=
 =?us-ascii?Q?6smQXqVVazM+x9owjOUMeEqyt8IJFCcQ1OMvsRrcZYhbkfuamgnOSgbM3OeK?=
 =?us-ascii?Q?XSeo64mqug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8f7553-86ad-4007-1717-08df264db549
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 21:38:50.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGKIrPqJOUJBolosV1vGvCkjBuZWCaaNMTXD53VaNIIg2J1ILLkUC6g2iwYbCjs18Ob+Os1UBT7DnmJ3F1YAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781

Hi Tejun,

On Fri, Oct 09, 2026 at 10:48:28AM -1000, Tejun Heo wrote:
> A child that ran a cid at a low cpuperf target leaves the target there when
> PERF is revoked, since the kernel resets targets only at root enable. Reset
> the target from ops.sub_child_ecaps_updated() once the revoke is in effect.
> A detach reports nothing, so ops.sub_detach() resets the child's cids, and
> the pool unless another child holds it. Count the deliveries in the hier
> stats.
> 
> v2: Reset from ops.sub_detach() for a detaching child's cids.
> 
> v3: Skip the pool at detach while another child holds it (Andrea Righi).
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

This looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_qmap.bpf.c |   39 +++++++++++++++++++++++++++++++++++++--
>  tools/sched_ext/scx_qmap.c     |    7 +++++--
>  tools/sched_ext/scx_qmap.h     |    1 +
>  3 files changed, 43 insertions(+), 4 deletions(-)
> 
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -2167,12 +2167,36 @@ s32 BPF_STRUCT_OPS(qmap_sub_attach, stru
>  
>  void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
>  {
> -	s32 i;
> +	u64 cgid = args->ops->sub_cgroup_id;
> +	s32 nr_cids = qa.nr_cids;
> +	s32 pos = qa.part.rr_pos;
> +	u64 holder_cgid;
> +	bool reset_pool;
> +	s32 i, cid;
> +
> +	if (nr_cids < 0 || nr_cids > SCX_QMAP_MAX_CPUS || pos < 0 || pos >= MAX_PARTS) {
> +		scx_bpf_error("-ERANGE");
> +		return;
> +	}
> +
> +	/*
> +	 * The child's caps are gone without a report, see ops.sub_detach().
> +	 * cpuperf targets persist until the next write. Reset the child's excl
> +	 * cids, and the pool unless another child holds it: that child's revoke
> +	 * report or its own detach resets it then.
> +	 */
> +	holder_cgid = qa.part.rr_slots[pos];
> +	reset_pool = !holder_cgid || holder_cgid == cgid;
>  
>  	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
> -		if (qa.sub_sched_ctxs[i].cgroup_id != args->ops->sub_cgroup_id)
> +		if (qa.sub_sched_ctxs[i].cgroup_id != cgid)
>  			continue;
>  
> +		bpf_arena_for(cid, 0, nr_cids)
> +			if (cmask_test(cid, &qa.sub_sched_ctxs[i].granted_cids.mask) ||
> +			    (reset_pool && cmask_test(cid, &qa.rr_cids.mask)))
> +				scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE);
> +
>  		qa.sub_sched_ctxs[i].cgroup_id = 0;
>  		qa.sub_sched_ctxs[i].weight = 100;
>  		cmask_init(&qa.sub_sched_ctxs[i].granted_cids.mask, 0, qa.nr_cids);
> @@ -2208,6 +2232,16 @@ void BPF_STRUCT_OPS(qmap_sub_ecaps_updat
>  	execute_partition();
>  }
>  
> +void BPF_STRUCT_OPS(qmap_sub_child_ecaps_updated, u64 cgroup_id, s32 cid, u64 before,
> +		    u64 after)
> +{
> +	__sync_fetch_and_add(&qa.nr_child_ecaps, 1);
> +
> +	/* a child's last target must not outlive its PERF cap */
> +	if ((before & ~after) & SCX_CAP_PERF)
> +		scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE);
> +}
> +
>  SCX_OPS_CID_DEFINE(qmap_ops,
>  	       .flags			= SCX_OPS_ENQ_EXITING | SCX_OPS_TID_TO_TASK,
>  	       .select_cid		= (void *)qmap_select_cid,
> @@ -2232,6 +2266,7 @@ SCX_OPS_CID_DEFINE(qmap_ops,
>  	       .sub_caps_updated	= (void *)qmap_sub_caps_updated,
>  	       .sub_ecaps_updated	= (void *)qmap_sub_ecaps_updated,
>  	       .sub_cid_sched_updated	= (void *)qmap_sub_cid_sched_updated,
> +	       .sub_child_ecaps_updated	= (void *)qmap_sub_child_ecaps_updated,
>  	       .init_cids		= (void *)qmap_init_cids,
>  	       .init			= (void *)qmap_init,
>  	       .exit			= (void *)qmap_exit,
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -113,6 +113,7 @@ struct hier_prev {
>  	u64 nr_enq_blocked;
>  	u64 nr_inject_attempts;
>  	u64 nr_rescue_dsp;
> +	u64 nr_child_ecaps;
>  };
>  
>  /* current wall-clock time as "HH:MM:SS" for the startup and interval headers */
> @@ -208,18 +209,20 @@ static void print_hier(struct qmap_arena
>  	}
>  
>  	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
> -	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu\n",
> +	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu child_ecaps=+%llu\n",
>  	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
>  	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
>  	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
>  	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
>  	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts),
> -	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp));
> +	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp),
> +	       (unsigned long long)(qa->nr_child_ecaps - prev->nr_child_ecaps));
>  	prev->nr_reenq_cap = qa->nr_reenq_cap;
>  	prev->nr_reenq_immed = qa->nr_reenq_immed;
>  	prev->nr_enq_blocked = qa->nr_enq_blocked;
>  	prev->nr_inject_attempts = qa->nr_inject_attempts;
>  	prev->nr_rescue_dsp = qa->nr_rescue_dsp;
> +	prev->nr_child_ecaps = qa->nr_child_ecaps;
>  
>  	/*
>  	 * alloc is the cid-time the partition handed each participant, and used
> --- a/tools/sched_ext/scx_qmap.h
> +++ b/tools/sched_ext/scx_qmap.h
> @@ -195,6 +195,7 @@ struct qmap_arena {
>  	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
>  	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
>  	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
> +	u64 nr_child_ecaps;		/* ops.sub_child_ecaps_updated() deliveries */
>  	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
>  };
>  
