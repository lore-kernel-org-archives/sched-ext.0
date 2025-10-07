Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087071DF73A
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830542; cv=fail; b=hUILit/kN06R5dt8uyHtWpvdMX2rvmDLKx3eofmgm0T67Bh5A8ZtzPMTjmC/XRvSB5lp38WPyb8O1wa/PZRZaGkcIzE9P3vMyWKC2j3IGFwIY3sDUNor+MSZkdRrqLEczwJIusuQNz3fJWzFYzz4VyEOErRBcssjtbvuci1O3CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830542; c=relaxed/simple;
	bh=0gaMXazfsEwaE0/R5+yNNpiOErWxHg9nYrKW0hJCzdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cMIAwN6Ju2iXC1DpXsSVTiauSOafurqAVVJweinR1kShQgnxdd53J667ncAMsasUTVYR/BaU8eEOP4qEa6RI0DDbxiyX4Q8lWj3fZb5QPLmr2oeOJe+bP00T5rAci+JPXjjaC60kYjRb4pT5aqXOx+xyKetfkf42Sj/Gd9pUBWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LHGZaBTp; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LHGZaBTp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zF9HE3tTdRvgYXcf+xF6f6Uj7Cqi8UJvghjlpeMA579BcsWbYxQH0/EZw8kQgA4zUCk7D/0JXWeboMYOkn92nOkRGKTuTBipadaxASdirVH53RNORwmdnAc7cyW8Ax8m8Ecw9JRSPA+n98foSvlwGZWwrURUD/MF9GxSe9ExbN864x3bj5F1ojQi1K4kqADbs7F2k3KrqaW1WIuDr62qUY9HC244el+VSqpv1veSAGc7AFDG6d5Crl6nCqP5jEOZv2zwun1ncwj5aAQoZ/XbH/zx52A/v96vcAaYSHNqOfP4K4/Vtn45Y7v5z4xTZeYC0jMzf5KiCZtstMVw1xso2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN0wie9AgzjmKddpGhZfRGORk5b8eGxKxZyF6EJ/D74=;
 b=a1NpbwhPax02IkP6u3c1+g105iKEU36lf822tt2PaZD7i/dDrzmahnohPVcV72WbNRBNIY4kKoNKF2AQPnwXWhBRKUiayjt0ZsLR3xMMUlKfFeCia+aE8+Uw9y4YoDjXnvh1dgpPIkgJjUveq36hEEB1eSPES4+rR+uS081Rr1pVSmnctx6sX4fMUKedW8yjSVOBLnbF8SbZBGabj+l47nMjCDH0ixIxR9v4SXuWEsUAoKg8XgsTrxr3oLeQuR85zZ6BgzhiAgUGQ7MaL/RibHhvNOTdqf0VNC6JebwJdGWALZAxqkJV3qRkknB3h1aNC3z9xdbjE3TA91H1yWqGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN0wie9AgzjmKddpGhZfRGORk5b8eGxKxZyF6EJ/D74=;
 b=LHGZaBTpKoRN6xB/quRcuesI4SvLLNnl1fzTvv93ihc3u3LKRI0ueAHRVbABidoMdhhkkVKbZXIOUdp93RyVcmTusFsfof/UKY7/37buulLbm4bx5Enh635PkdLHIHge/SXRRAZbdt2HPXIV68D+HthMBbO+posVsEbwxnnzkvp9C0RV9lHlhdPiLxTNiprM6SxdZLdIQc53+xpklF8sVgsf0fMLY4Fyr96RwRTdRfQZ42dOEpHgj7yBG2a1zxdH0bobrPwydqAhvsRZKiaAACcOdhAzukCmeBpsjcPZzOlZ5VOxiw3Rm9uQ2bFoSvLjZnNtIoMcLkudIhCJOi20kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 09:48:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 09:48:52 +0000
Date: Tue, 7 Oct 2025 11:48:44 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 3/4] sched_ext: Wrap kfunc args in struct to prepare for
 aux__prog
Message-ID: <aOTh_PAGkX9y2Tsy@gpd4>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007015147.2496026-4-tj@kernel.org>
X-ClientProxiedBy: ZR2P278CA0086.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dda6b80-7b3e-4f2a-af5b-08de0586b8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mwck1RkGIhW8tRxF2gjEAmvDXK13OBP8FCD9346R6oIGLDw/G0kMeEFDAGil?=
 =?us-ascii?Q?uAaNhulVHXvHyGT5U3+qTjvIiCO1QeX6/O4f50xbT2qn4WUJWDL+Favi68m5?=
 =?us-ascii?Q?ISO7mRBnLpvAh7wPoLlSAigQcdOv/jGkaEBstukDAtz+pguqb4krigjqz83c?=
 =?us-ascii?Q?BRgZcEGgJuTREqnnMRYWZCKcz1f5Bguklx8OPdmG1X8Nf+g0Phy1TZsr/7IU?=
 =?us-ascii?Q?yFNT4RFi0u6FO+0p4fM1wHiTf8u38+qjUmhUc5Ab8zqnsvQV/3ZJoo6NT0FW?=
 =?us-ascii?Q?cWVjJJOLhd5pxIN9KhJHg6ZGuGxFuzAfNqm3rql7Qk7U6HQQ61RbkQj4dGSn?=
 =?us-ascii?Q?AiXSN7l8SYEw1kuWPgCMZWMBw1QSI4RvrnwydZpW6kBkTe1UM8T3a+SFioSV?=
 =?us-ascii?Q?4zHQoJkh90HH4spLF5Spmm6zpAkze9pU20hvgUI02JAd8qoOn5uKCJFtfDqS?=
 =?us-ascii?Q?oOmU5Ih6jRwryRaMXlBaRJzlJjxrL4zezEdieVVEVMpN2oZfUZH5YcZBDbDl?=
 =?us-ascii?Q?5+YsR5Z2xQ1aUczaGRV9jGYEFQn2fVysg9DGl8+EuiWgBiG6mVefxYPjVPAs?=
 =?us-ascii?Q?L/2zQh5nyPkkHzGZdfO0x5uaGZNcGBiAANHgHIn4VUF1JjKUoObno35OitQR?=
 =?us-ascii?Q?TqcuMZ8LhpIENm9bKF6GjduRXV32T/O1DTbCcRDB3MZ0VGaxJTy2jGmmePO9?=
 =?us-ascii?Q?TWg/iojIe4z+tWQvCzS950KKuGMuj9w8U9uDNbgomjYvcvrWsDGhsfVRa62m?=
 =?us-ascii?Q?VCUt6QGmR1DhlxaVlcJNPSEUbTb9eCJDyCBRI21SvBLCGoHhgFxv8YWP6BXk?=
 =?us-ascii?Q?q9QJ/qjoFEmvW2gGajUwORHsNf4FLtLawXdPvM53l6HrKDyvToWByWmeFhKl?=
 =?us-ascii?Q?Ya8T10vnVZccxKGdthMYhZiE9newUuKLv7Rgbpw03svT55q/f3Amk8MDFoJf?=
 =?us-ascii?Q?UeRpb+F3zz4jttNNVOzCaJnIT/gIxsp6oN6XE5xFeKItrcy21Jl31qQhY2Gl?=
 =?us-ascii?Q?OkeYYaExwYwfF0gV7/uaTBpiG2PdmeRsJZN/o6XdMBYufvUw+hZWUNG2b84X?=
 =?us-ascii?Q?VP2K4U+YaBHR4r8YzEtFPcxQT/Obomj5NCNYtzRE/BZv4B37PreLMfTXCiCg?=
 =?us-ascii?Q?3iDhvjL+u0DpdM12lnyxl1POeK8dUaCjKa4b+NJnolMebQOFHx7h4+Lm/BkY?=
 =?us-ascii?Q?Rz363VbSmAFBwBvYigHY6o8iUkZM0KXXqpVmqFBRSPoojeC2xai0U3wwT8YS?=
 =?us-ascii?Q?voWpk1fBSR2ELEWCDE5CJAJlYKRnLnn6FCuVF7A733e1eAToPEoSBCtxNQgn?=
 =?us-ascii?Q?F3FBB7Gstg6MgfVflFVjNNqA3OgV46VNtkhmXmirUvIhZBAxEYLCHPpGaalB?=
 =?us-ascii?Q?LpWZFjJeyV2mxJizMlZVZ/0Dl+Dq3mXsCFr8IAxq4CO7lljIoWX53JbT+5/h?=
 =?us-ascii?Q?KB3gldRP8lwZynYurz6KIl8AygjZBz0o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PjmPEp/3iKZWrHP/yCgamW0dcvMU2LALkH8m6Ga9y+69mg/SmiiL54r0wfFM?=
 =?us-ascii?Q?lbf+YkQJ+irCzd1z7G4fJeDCREppjNQVVUpyporNS0Epjerc4kqQDfMXCd/N?=
 =?us-ascii?Q?uJGF/1syuJ/Cx2Kf7XLb8QCER2Pf7ABB0pY/bAOMVP3BnE4lpPZdLJ7rfpQC?=
 =?us-ascii?Q?DXwqS3WQMObof8LRIIcdlQevo7vAqR8f/9+gwpWx6RnHDk28nZxWHD/Y9vft?=
 =?us-ascii?Q?2mgcnUjyFvcb3R9C625o58rwilY4dtKG8tCSuefiIfVxbfh+3XV9kFBFMwdr?=
 =?us-ascii?Q?45FgvI8u+OryV31I+XKDOltfgopschwKjSri6MR6JyiUYfPY8rBakcpFnyaW?=
 =?us-ascii?Q?/0vv7eN+DwE4fJssBajLIP85pCGj2MlgmtEeo/hKptn4AiXbJfAPf8vlENqh?=
 =?us-ascii?Q?Dx8gFXof1vxOWCCZ4oOAAra1bVeHs4qMDPquT5mtN9D0sYaZ1fq5ZEqptQ0C?=
 =?us-ascii?Q?kPUpE+mI3tff0GtH5cECk/pSOYu3uHh7lBRVVmZKPjo8HVlFFFl0ItxIGu8z?=
 =?us-ascii?Q?6mWvRHgRIye8gyTt2LSdt0zZK5kFzG2wL9oUl6P4bvOvfDUyplsrS7kDLINl?=
 =?us-ascii?Q?RHExMCC+wsa2bbACcqWzsSAdjza9V3KaREiasWsnZFAPJojvnLIaUuYMaFOS?=
 =?us-ascii?Q?kLWPA3xtjM4OvkHzgfuF91yBG+y8UX+0Bgzf9rCF0R4ACUiViIz8PEncr/cQ?=
 =?us-ascii?Q?N5aFzXks6sI4vAwqCUvj9mN2mHCP1zW6o8vRcXkKmafzVgp8K8JMhxRXuXOf?=
 =?us-ascii?Q?bxKsSEDRNSVGuZzT6gYTX2A+0U6aXssJAlSjhx1jZC29QOrj7GdygEI2MzDP?=
 =?us-ascii?Q?v1cAVpivRD87xtp2gW1GDJDmv4DafwQ/uLiquSpDUVx8I5XNf0WYC/IzZJMz?=
 =?us-ascii?Q?wL7qrilAf92R5TeX3axAlVlA3XVNOjOBU8LsG11Jyy9GVx9Pck0YZPdp5MC1?=
 =?us-ascii?Q?icr0ORxLaQ4UGDN+eOOCkzNrz2rQlTOxBUu7oNxMbKMM1WerwbOA4k8k+2Vo?=
 =?us-ascii?Q?U+ya4QwJgvrqJ+jl/Itze2MVdRvOeUe7G73R2YFCp5J3bEmupffSNiZi4M01?=
 =?us-ascii?Q?ZuvoUlnwd0oJklAPbkBio8ciBwqmrlDpd1ZJUwtRWLvCUfrs1bt3Mrv3GGLf?=
 =?us-ascii?Q?gPqISZ0ttwIoYyadK/+TOMRiomr9EoRoniMeIXFyV6GopKSsckOuj6eUSSlo?=
 =?us-ascii?Q?23SmKCOChGk5mSZb5FBmC50IzZFeZdLCsEKOmBsFu0+vRVpHJ4SWr3SzDxuu?=
 =?us-ascii?Q?aWAXsDgzktji0Giar9EBhs1O/3sIqdwQT6K3KrYQkR6g39r3th9Pb0h6qcmo?=
 =?us-ascii?Q?rOvG7m0ZVmlQxJgV79Q8N9JddyYZScTj6CNRknJKZiphpARhCbErS7WabmpA?=
 =?us-ascii?Q?XH5x5b/0rdZgk01uLP7hArp+j2AkesSuRiHX2rCKzyFmby9tR48k+Y+3Yvg+?=
 =?us-ascii?Q?YZg+9xshqzB9fn0729MmH0pKRS4dSN3/T7J2vqAYyk2iAbkM16bqta2lNWHt?=
 =?us-ascii?Q?McEvXPTLCM26AdXqPalc7uRLnml8K+rBNB7hifo6BDXMg1BwvJ3O0/cKVCvH?=
 =?us-ascii?Q?yLOWP2gQkY7TfA/hN4Ipb2FpVAS/bQksqWrYpsTk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dda6b80-7b3e-4f2a-af5b-08de0586b8d2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 09:48:52.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7ey+wbucmznB/4YItIoSOY3Ge9RwMtL5KxZJIMYArlMaQEtlKXMCgHfDZpDFAk5mDPatmVpBdqXBv+L/t/Ijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167

Hi Tejun,

On Mon, Oct 06, 2025 at 03:51:46PM -1000, Tejun Heo wrote:
> scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and() currently have 5
> parameters. An upcoming change will add aux__prog parameter which will exceed
> BPF's 5 argument limit.
> 
> Prepare by adding new kfuncs __scx_bpf_dsq_insert_vtime() and
> __scx_bpf_select_cpu_and() that take args structs. The existing kfuncs are
> kept as compatibility wrappers. BPF programs use inline wrappers that detect
> kernel API version via bpf_core_type_exists() and use the new struct-based
> kfuncs when available, falling back to compat kfuncs otherwise. This allows
> BPF programs to work with both old and new kernels.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c                       | 82 ++++++++++++++++++------
>  kernel/sched/ext_idle.c                  | 43 +++++++++++--
>  tools/sched_ext/include/scx/common.bpf.h |  6 +-
>  tools/sched_ext/include/scx/compat.bpf.h | 72 +++++++++++++++++++++
>  4 files changed, 173 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6d76efaaa9b2..a34e731229de 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5345,54 +5345,94 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
>  	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
>  }
>  
> +static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
> +				 u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags)
> +{
> +	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> +		return;
> +
> +	if (slice)
> +		p->scx.slice = slice;
> +	else
> +		p->scx.slice = p->scx.slice ?: 1;
> +
> +	p->scx.dsq_vtime = vtime;
> +
> +	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
> +}
> +
> +struct scx_bpf_dsq_insert_vtime_args {
> +	/* @p can't be packed together as KF_RCU is not transitive */
> +	u64			dsq_id;
> +	u64			slice;
> +	u64			vtime;
> +	u64			enq_flags;
> +};

With PATCH 2/4 introducing scx_bpf_task_set_slice() and
scx_bpf_task_set_dsq_vtime(), would it be reasonable to use those to set
these task properties and then completely get rid of these args in
scx_bpf_dsq_insert[_vtime]()?

> +
>  /**
> - * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queue of a DSQ
> + * __scx_bpf_dsq_insert_vtime - Arg-wrapped vtime DSQ insertion
>   * @p: task_struct to insert
> - * @dsq_id: DSQ to insert into
> - * @slice: duration @p can run for in nsecs, 0 to keep the current value
> - * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> - * @enq_flags: SCX_ENQ_*
> + * @args: struct containing the rest of the arguments
> + *       @args->dsq_id: DSQ to insert into
> + *       @args->slice: duration @p can run for in nsecs, 0 to keep the current value
> + *       @args->vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> + *       @args->enq_flags: SCX_ENQ_*
>   *
> - * Insert @p into the vtime priority queue of the DSQ identified by @dsq_id.
> - * Tasks queued into the priority queue are ordered by @vtime. All other aspects
> - * are identical to scx_bpf_dsq_insert().
> + * Wrapper kfunc that takes arguments via struct to work around BPF's 5 argument
> + * limit. BPF programs should use scx_bpf_dsq_insert_vtime() which is provided
> + * as an inline wrapper in common.bpf.h.
>   *
> - * @vtime ordering is according to time_before64() which considers wrapping. A
> - * numerically larger vtime may indicate an earlier position in the ordering and
> - * vice-versa.
> + * Insert @p into the vtime priority queue of the DSQ identified by
> + * @args->dsq_id. Tasks queued into the priority queue are ordered by
> + * @args->vtime. All other aspects are identical to scx_bpf_dsq_insert().
> + *
> + * @args->vtime ordering is according to time_before64() which considers
> + * wrapping. A numerically larger vtime may indicate an earlier position in the
> + * ordering and vice-versa.
>   *
>   * A DSQ can only be used as a FIFO or priority queue at any given time and this
>   * function must not be called on a DSQ which already has one or more FIFO tasks
>   * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
>   * SCX_DSQ_GLOBAL) cannot be used as priority queues.
>   */
> -__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
> -					  u64 slice, u64 vtime, u64 enq_flags)
> +__bpf_kfunc void
> +__scx_bpf_dsq_insert_vtime(struct task_struct *p,
> +			   struct scx_bpf_dsq_insert_vtime_args *args)
>  {
>  	struct scx_sched *sch;
>  
>  	guard(rcu)();
> +
>  	sch = rcu_dereference(scx_root);
>  	if (unlikely(!sch))
>  		return;
>  
> -	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -		return;
> +	scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vtime,
> +			     args->enq_flags);
> +}
>  
> -	if (slice)
> -		p->scx.slice = slice;
> -	else
> -		p->scx.slice = p->scx.slice ?: 1;
> +/*
> + * COMPAT: Will be removed in v6.23.
> + */
> +__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
> +					  u64 slice, u64 vtime, u64 enq_flags)
> +{
> +	struct scx_sched *sch;
>  
> -	p->scx.dsq_vtime = vtime;
> +	guard(rcu)();
>  
> -	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
> +	sch = rcu_dereference(scx_root);
> +	if (unlikely(!sch))
> +		return;
> +
> +	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
>  }
>  
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> +BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
>  
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index d2434c954848..3d9d404d5cd2 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -995,26 +995,56 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	return prev_cpu;
>  }
>  
> +struct scx_bpf_select_cpu_and_args {
> +	/* @p and @cpus_allowed can't be packed together as KF_RCU is not transitive */
> +	s32			prev_cpu;
> +	u64			wake_flags;
> +	u64			flags;
> +};

And for this one, would it make sense to pack flags and wake_flags in a
single u64?

Thanks,
-Andrea
