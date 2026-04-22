Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D81EA7DB
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855787; cv=fail; b=KVzmIUZWYCmbZivEp/uyBgdnEMItuZQTi9Km+M8tv23PXVNvyqahuTJXt2t1YlZY5eTUC9aBDM8YJMrCLp4RvT+ajJgrDgupQFjKRuvwqtjfLHasFvhfAq3qyaqQwb39fMEiF66JO1JSB9lbKAZz9KOaWkTeAY8jDpnaw3p65Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855787; c=relaxed/simple;
	bh=P6fy5e5zqL6nm8AvW3D24g5lvGK+YLitpJtILaCiiiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VZEq5nAPXHRlI2RDIDhw9u3k0OSL+t2rHfbwknyQTvKmKjsAPCNqQW4MTTut8asBPXEPGzo4Dlzpu+oBrZBqrn0gDcVCg5P0Y/EP9vk5CSFe1Y/DKBpes2DeDKkUPJhhn7ZCyrGwj7PYT9hDZ2azBuHoOo9VfyNj0Sr91cHbnJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T34x8U8u; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T34x8U8u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FscFBEhHWU6/aEn73+Vjl42qhDeU+WPZHjUfCsZ0NXpk8i1sV84ZXfOs8BLMdtEiGvkqVmscEp1svof0xyfN2tNHBqCfy9d13CUoIv8keabmICMeEkQmpnyTGS/zaX6seoiWzIjTINl2JPrr2abx8mUoOpUX2ps8gXgFFsNPujMF9ZMdEidjdaGXhS3p7mR8dxBBCihbfBL210vTH65Ml1jdB5HNLX1utO9k0mGRv9HQdEjO1ovgwmXuYqio84s1sjunC25+4e8czFcFUuJVNLi/aiEhPE+cp77JNFrp823SWOxJD/VJN8+i7Z/8UzbjGMnd46O7aNxP2WFC0rLvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HFOkGaX2/mD2lA4aAsN9PVI9DAsaqWVSTaCuopjMuI=;
 b=MiR4+RAb3TkqYytKinZThAW3MJvFuLikXV8HxQpgtQVmiEh+BN99LvQfiA6Iluss4SwTQmlcQJbjwDEBF4Wv3aw0JlZiVCw+hu+4EKj+WozN434MCQ91HM/qlK+18jWUsKxNvgW9g4YmDEqdDmEhc5U4RxIxNeLzh0aTQMKcnN9PqUqQOpyxqs7iZLJQHASAiO6eReBoi9b+WCW6RiYobw6xzLCPRG1N5SIztsmJG6h3rvaJ/iYd/t62A34i0ay5NIek3AVHMgayOBAX2inhCgvRj3kYctfZ5SBU/5TLgQ9Xlen9iCMQ0DaiZwAPB6pZcfB+HY6iYNKdfCang8/Gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HFOkGaX2/mD2lA4aAsN9PVI9DAsaqWVSTaCuopjMuI=;
 b=T34x8U8uJaXaJHjOB0JQtMqmo/UmNmv7R7+5ogScP7FEznDKrjqVJAJ9icIW0RZU8Pwgj4uCAH66WPeRE+tbftFge1ciamlbZ/Ifz2a4x5VgRizuYcMVwCcBZ8B9uUshxAZ+5+JqbrkKkVF9kYq+lA3r8g8UuY2hbcRr/srKJQBEyYRuH7EiUslnrtIddpoJSrRyUjTxzmzdFqGFUJj+zS2ngJowfAmohUNwRDEaaIztPYuIklrj0wEmgjK7kIx3htamji/X9HPrNcA+08FPmw7UAUn4oh5IKyyGSbDszAC+7/V7P1Z8gIv/uOgEXfteTKq/3ETQKAcp61xEi/of1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 11:02:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 11:02:58 +0000
Date: Wed, 22 Apr 2026 13:02:55 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <aeiq3-TGABRgOrD_@gpd4>
References: <20260319083518.94673-1-arighi@nvidia.com>
 <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4>
 <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422142633.G7180@cchengyang.duckdns.org>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 135f6dec-0884-47d4-0cdb-08dea05eb626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	E5xBe6b6SsUcjGVcdW/IxLOrR1Nf66tS9nK1zIYMTorI8njzh+2wa7Tu49UNalTNplS36s/jB5A7ClqxlN/Q5oaU+C3Yt6ADLdu5pyKz7Fh9MaseJZfpMXyOa0NwtmTD+LWaT5J4RQZn6VZGd46Wo/0ndYWvcfNp3t9X1YDKZyKo1a/vLNGY5/zVIdIx/abhb3tcqdq3JcpyHbOjWQsoBp/EiHwEMpLci2khkqK+qycC0L83G1xANYv4CwiCC5LF3UJF9TZ4T7lYPSKiVMzF7bPBB1kcOpric+lwzrqQkfQak8s+Wb6dG+22WxXlldhdvzUiIvjNYRJTugMCdGX98/RF03CpI1xk92TqsvMWDUzYTR62yduodMSUmraYM3r+GegTLVcZJJ5YPN1P99iyqa4qOAZK2M7Thm/K/RzARVLKB0F8okGzL7cGkqZe0PsAP7gXsvDmVBVmYcDZt4hHHQRwaxg1x+hqRhtHtUKkE2A33lpPQOK9grtHHMB9c57j0zn7fOeWXlnvRaUJ4Yz0bEL5SC9Y8wdjnu7+nprRPBxh8VUURk/RtTaM0Gw1YgIBBPasXkO6/9vh48TGxebszTmi05E+/7ZtTtB9EfeO8cIh91rC0ZaKJMDM1VXnqi4bBsVzNcR8Esd3ArNAvJScYJW9+IrzC9YoYITSVQWj/4uD2qdh2Mn2ynXaQI/viic+PtoK3GSKb8STd3utP3Glu9MW/5Kw6Bv1IOqMEwFlHIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w9FLRam4pbOccNC2FaC8hIfmAvuXQhk3LDNFySDFTX6s8knHjfDOOi6gIfeB?=
 =?us-ascii?Q?aq0bh/bDQ8Z3WhM6fnpBSaNhPkp2emJ3ntBR/S6QsyBfSWO9DjPYUYjGj8em?=
 =?us-ascii?Q?iDOCuocTyVYexeKGW+K8kgP9Ukao6HZCuhJVN1iNA2AQyiYGSw4bwNMfqRMU?=
 =?us-ascii?Q?NbPrEvFTU+QFOLL2I2exBKPxr2o1IrVZEK3pR39cbDPIOfyb7IjebxPk8GgD?=
 =?us-ascii?Q?GCZNqMqp6crzG5dWQaLCL/R5R86lcdMZh0KZifBt0CVYnosl/g9yduTnUZVs?=
 =?us-ascii?Q?PyFlhgRaiScYs5xx/0H3GdgepirMiLvm/ITSDuNbn6uji17VzeUcm+/rigky?=
 =?us-ascii?Q?tPGBWODytuNayc3W07MV8xAgTjWQj8Emh/cfWDAkHmHdS7X6fUoAsbWe01Lw?=
 =?us-ascii?Q?egd/r0kSiYzodVKYj+45JmnnhkmCTr5temfia/TdQh1vzNRJ638G7ZBSi/9F?=
 =?us-ascii?Q?Lxl6/c7vIyzTMxBH4Qeq3tB/cOUtZLkrPrg10tLqj755zpNFJ1TFukaw8W62?=
 =?us-ascii?Q?toqafRp/8XJF9Bt4UkgahxVZASXLluZ9SkBDYmjziJM9icmIzU2BI72otnrD?=
 =?us-ascii?Q?+A9Q2sShUZtkcEQiQoxRWTQh45QtMTbzXrJGvsC2phb/QW7HRfLHhKoPl4L1?=
 =?us-ascii?Q?X0vb0LmwyhA7ftCLvy266nxZ+3XaPvygyBME1cModXbWcRmVeJ+Ntj+wf8S7?=
 =?us-ascii?Q?Ku/ycAAo9KFtuElfW0fpYPmpOSpvuEX1W0T7BOyxmxu8g+SFZ9xzJBfikL/P?=
 =?us-ascii?Q?9agA/gvz19NE6oFx5PO2Wlx24IECWEkKiKsjaU8Uzz+K6LJzM1476Fb00e34?=
 =?us-ascii?Q?4UO4mH9ogFSQpzVrOFCZhij7A3gOxzGfGvTOmzuxvE/AxInJ73MJBNubM3aj?=
 =?us-ascii?Q?I+UhoALnLsJVC4ju6Ft3Zelje2rgVKa2lXWGov5xUiPGA/PYMGrY2wR1s9U5?=
 =?us-ascii?Q?tD2INC/yjwLvdON7RKZVIDyAnTXsX3YM0pb0YBczBh2nBCj241fglxrYO3eJ?=
 =?us-ascii?Q?dS17y1xRb435zfgmm99gzKJ21s6GFr/PSaO9Q9gQ5qxO6/B+8fcjsvVHkKQw?=
 =?us-ascii?Q?0aA6Hxas73uYYCTvlVi0lmlm/KyL/UoIYM4eSYTK5jJKiJmUMz/pQmReyqbp?=
 =?us-ascii?Q?gnXPUcHMlQLF9fsrj3Iq5NeqPRxxcJFbCpGLJz6OpUEMGMsQ6TsH1Nf7rD7t?=
 =?us-ascii?Q?fA8waNCfC26Ivie01O970DIrxEa9HKun3dpm/QTdZugW6Jku16f6ZRzDiOBm?=
 =?us-ascii?Q?xujKzDzcgf5L1JoN0/hdZapvMBos2XYThrcfyLyLbbXJJr0jVdnoWiep3SA0?=
 =?us-ascii?Q?gIDqKli+g8gOVudVDK057ez+49sg8YR7v+qv8Uin67S29d82ozQO7Ecmsarv?=
 =?us-ascii?Q?O5J9Q2FEeP8fiVPYjHNBiggYh+bt/jt1CHotyW4pnPjTqQc+cZkx2vSKjHv/?=
 =?us-ascii?Q?irMzkrgBaOFxP1hKI/eBhg8LoVQRROOSbVew54+HvxB7NV3vISxRFG9NydK9?=
 =?us-ascii?Q?+NIhbaNc0Qp1JHWQLnlORgUJ4gqmKWjNHB3mYCT3MqmEL0p1FoS3GMeFQS8I?=
 =?us-ascii?Q?u6TjmSOsn7rv5y+N6pPqTG8awjuvktng4Krug6qccL7oCG96Sv95THnDxqR3?=
 =?us-ascii?Q?5sFK3t0DNRkO8q0okobXzG5KZ4QJvpmdpt8h7LU2Thdm1doBdfjMITWcBDJr?=
 =?us-ascii?Q?EYz8NW09cfkcu0Fs85l+oQC9YTfJZkzl7oILnYvhJ8AgF4u9eRaRZz8Kmd06?=
 =?us-ascii?Q?m3VLximztQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135f6dec-0884-47d4-0cdb-08dea05eb626
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 11:02:58.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrjCCy9smhJM48urJtaGpF7NcqFuFP6eemSEcB/8PJDw1Tby9HDVIJJtQ+sUQRpPUaV7YTKwBIZl+TtBWXhoSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487

Hi Cheng-Yang,

On Wed, Apr 22, 2026 at 02:33:40PM +0800, Cheng-Yang Chou wrote:
> Hi Tejun, Andrea, and Kuba
> 
> On Mon, Mar 23, 2026 at 01:13:20PM -1000, Tejun Heo wrote:
> > > The simple way to do this is to do scx_bpf_dsq_insert() at the very beginning,
> > > once we know which task we would like to dispatch, and cancel the pending
> > > dispatch via scx_bpf_dispatch_cancel() if any of the pre-dispatch checks fail
> > > on the BPF side. This way, the "critical section" includes BPF-side checks, and
> > > SCX will ignore the dispatch if there was a dequeue/enqueue racing with the
> > > critical section.
> > > 
> > > With this solution, we can throw an error if task_can_run_on_remote_rq() is
> > > false, because we know that there was no racing cpumask change (if there was,
> > > it would have been caught earlier, in finish_dispatch()).
> > 
> > Yeah, I think this makes more sense. qseq is already there to provide
> > protection against these events. It's just that the capturing of qseq is too
> > late. If insert/cancel is too ugly, we can introduce another kfunc to
> > capture the qseq - scx_bpf_dsq_insert_begin() or something like that - and
> > stash it in a per-cpu variable. That way, qseq would be cover the "current"
> > queued instance and the existing qseq mechanism would be able to reliably
> > ignore the ones that lost race to dequeue.
> 
> Since this has been stale for a while, I prepared a patch to implement
> scx_bpf_dsq_insert_begin() as suggested.
> 
> Is anyone else working on this? If not, I'm happy to send the formal
> patch to fix this.

It's sitting in my TODO list. If you have time to work on this, go ahead and
send the updated patch. I'll take a look at it ASAP.

Thanks,
-Andrea

> 
> -- 
> Cheers,
> Cheng-Yang
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0a53a0dd64bf..0215a21a02db 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7933,6 +7933,7 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
>  {
>  	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
>  	struct task_struct *ddsp_task;
> +	unsigned long qseq;
>  
>  	ddsp_task = __this_cpu_read(direct_dispatch_task);
>  	if (ddsp_task) {
> @@ -7945,9 +7946,16 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
>  		return;
>  	}
>  
> +	if (dspc->insert_begin_valid) {
> +		qseq = dspc->insert_begin_qseq;
> +		dspc->insert_begin_valid = false;
> +	} else {
> +		qseq = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;
> +	}
> +
>  	dspc->buf[dspc->cursor++] = (struct scx_dsp_buf_ent){
>  		.task = p,
> -		.qseq = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK,
> +		.qseq = qseq,
>  		.dsq_id = dsq_id,
>  		.enq_flags = enq_flags,
>  	};
> @@ -7955,6 +7963,39 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
>  
>  __bpf_kfunc_start_defs();
>  
> +/**
> + * scx_bpf_dsq_insert_begin - Snapshot qseq before a dispatch decision
> + * @p: task_struct being considered for dispatch
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
> + *
> + * Capture @p's qseq before the BPF scheduler reads @p's properties (e.g.
> + * cpus_ptr) to make a dispatch decision. The snapshot is used by the
> + * subsequent scx_bpf_dsq_insert() call, extending the race detection window
> + * to cover any BPF-side checks between this call and the insert. If a
> + * concurrent dequeue/re-enqueue races within this window, finish_dispatch()
> + * detects the qseq mismatch and discards the stale dispatch.
> + */
> +__bpf_kfunc void scx_bpf_dsq_insert_begin(struct task_struct *p,
> +					  const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *sch;
> +	struct scx_dsp_ctx *dspc;
> +
> +	guard(rcu)();
> +
> +	sch = scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		return;
> +
> +	if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
> +		return;
> +
> +	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
> +	dspc->insert_begin_qseq = atomic_long_read(&p->scx.ops_state) &
> +				  SCX_OPSS_QSEQ_MASK;
> +	dspc->insert_begin_valid = true;
> +}
> +
>  /**
>   * scx_bpf_dsq_insert - Insert a task into the FIFO queue of a DSQ
>   * @p: task_struct to insert
> @@ -8134,6 +8175,7 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_begin, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_IMPLICIT_ARGS | KF_RCU)
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 4a7ffc7f55d2..adc4f1c01b56 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -989,6 +989,8 @@ struct scx_dsp_ctx {
>  	struct rq		*rq;
>  	u32			cursor;
>  	u32			nr_tasks;
> +	unsigned long		insert_begin_qseq;
> +	bool			insert_begin_valid;
>  	struct scx_dsp_buf_ent	buf[];
>  };
>  
> diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
> index 64dd60b3e922..fb68a7d7e201 100644
> --- a/tools/sched_ext/scx_central.bpf.c
> +++ b/tools/sched_ext/scx_central.bpf.c
> @@ -155,6 +155,8 @@ static bool dispatch_to_cpu(s32 cpu)
>  		* reflect the migration-disabled state yet if
>  		* migrate_disable_switch() hasn't run.
>  		*/
> +		scx_bpf_dsq_insert_begin(p);
> +
>  		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr) ||
>  		   (is_migration_disabled(p) && scx_bpf_task_cpu(p) != cpu)) {
>  			__sync_fetch_and_add(&nr_mismatches, 1);
> -- 
> -- 
> 2.48.1
