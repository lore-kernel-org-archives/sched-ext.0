Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F974E77FD
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776461; cv=fail; b=P/G1o80TveGwlNvxsLa2gYBzo/kV3r9bojsANRKuzfleR3Ug2HBVmm4Mabsfdb/sKWk8NAFX6SFqse/NKqob1VZDB/jR/ejT9LZv+Z0xG/6WdNxb4mfSRBzedP1uhDM/MfTR5UtNvUwPeKruFjkIKJRHiRBowD3U1tm0py4JiGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776461; c=relaxed/simple;
	bh=bVTxio82X9oaXdAEearzuR7Mm42kprHtjNIn0wnisVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IYTijdEdyuEvCxBsnajZPP1onorzgNJwnhUk/cnT1nLGnwNRK8bKTaGzqRfOOwXay50hsS5Oe+4Ri/IzH1UCvJRNslnAqEHeVgpCkHpr1AZDI8/mcDcr4ixv7nqvGeNEQBg+w+n/4yqCU5Zn8inaqbs2HOKgoBsJ0SEAiZKfcEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q22gTTxq; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q22gTTxq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVsHn4S/Sl1vbcEjulWjSt+8i7AuoRii8nVnGXfOthnWjr0MupY39i98P7tKPOXp75fYOgoXD0+2dWhUyfUMJIE3k7fGhVrJC58eDcfe0YJkxx2jnxQkHxs6jOiR/w88xnnGYaki3NhNcGmr/6CXB4yioA2qhLK9GDSzu8Igw+XGsk7Xwm1cIkfpt64affLz7xA8youOo3TdphxIORbWgX7P1ClNGXkkH57kb7TG/rks+cxNY9pokUZJxDeW47Z+7oj8hluYtZb5g3GU3+uSOyrg1gT9UI95LpJQqU8zL5UEMBOiYKq6Scf00HG+gCSQt3y1QW+H3ayemZfkFKm7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Yuzn+PwDvD1/jyNI/oQm665H/eW/zRucG8khdmaN4=;
 b=w9eHD01koPxdWbA60OMuh6qywStAjI1iAdv6cL+3kpKho4LWS+ZSeN9IuFCKiNJBU3d335jfhEnQeG83Qv6p1oxjS7lVwaaDkVbukZ0xSFFSpJhAAweokj8p6IrOLGg/SEHMapzA4CDDVnagzLpJfiTOw2QD3pnoHvsx6WWwzPLjZG8ZydcUFTIFaSF3NMP50Nd9pJHFqt9ewkwyoWw7KOFpyJMgzB63kNPLLbhTb/JuTyCKDbFBJIsmLK0gTpYjBPX4KEWrEqxE4it87LXxcwbhgMwdCv5WmcRRDnb3uCa8GoorXU0r6J7TmkCXrdpTZ4o+tVRoQvGF2pQGQ6jcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Yuzn+PwDvD1/jyNI/oQm665H/eW/zRucG8khdmaN4=;
 b=q22gTTxqHxLeDLZTBbQOBLXSuG+71ui9PAFx1MJJJg3tdtAGo4K+BtKaxTBVowrtvEOU32WdTHnABwX0tCuYnDJu/NZ9df3bwZIKv4P36e6e13Dn2oQzzP1GL5CLel4vbOQJbZMImh9GgRpEV+Vwre/AF9kP+Kw3L+OzUEkDO2W9VKWt6qyfDDYJo5qiAMjTrc2PUywhC+6dgMbjCCCRYa7dESD1g/EZPuBKoZF6aO0YQTrNMdtqqOkN2oxxzu7BNO11HUBjMkC8P/CvBf2whdk/pSKUyTv7I6nD/03J6nwXAY+Wdxa5SjYqPSvZiYgWUMZ126ReWilx0+X8K5PDEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 13:53:57 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 13:53:57 +0000
Date: Wed, 30 Sep 2026 15:53:47 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/sched_ext: Add a test for ops.dequeue()
 on remote local DSQ moves
Message-ID: <ar0Ua_zkwY7P22iI@gpd4>
References: <20260930114725.331370-1-jpiecuch@google.com>
 <20260930114725.331370-3-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930114725.331370-3-jpiecuch@google.com>
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8768f6-6f53-464d-4355-08df1efa45db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XNHTQArasOAUJ0nzf9ZwPHv+0kCegeDpctH7yRDzJpirVZ2baoygbOPbHWnuDzYeR+9JxO/fbJ0w0EBt4KP2yPdW/iNGgys4/tRpB6xOgJ4JCte077yFANeIx7dUwJ8zo3nwusnlhG9nNpGiGPm+OElzmQikQ7EaiDNLvXyM/TF/CoK+oCDkgYlV8xX5a3LDxn4of1D6TquVd0CZV1xunssyI9g2kz0DZQL71VaTNPXdKo0Vav1Xx0PoMeNCbxO8eZLm2q/hVpahtq1tknD51yRy+zHIc/6vqNMhmLY9mSq+Bd6tsTPBeYP3Psy1hNTPo7S+9M5L0yUT51B6o1HVVlpvNpYRCnrLQOsh8uyhJwulzV6QJdqJdjgbKBCguXCiY4MXUC9rX02u+59tY4yjp5jW/XKpGGubgfrT7WBHfoqMu+DpEp+Iet+mpGAMHoW6ibj57UteK4U+Mq8F77AI2DZbHr6TV3oVLtYep7DAixvbjEUyCHODua+xcVpFS3JMz6buqsUYCiVua+9G9t1ns2TjOaM+OtHUdXhUMdButiCgPVRcjAOPZ/IqcF+htFObbORfoa6DpKLFld4V1FfeL4s+yEn8i33/Mdsq3q7RaoU+dNjl0FCu9m3XGjVFvZLgtQ4nCKWxynfxjfeqmnOz/EzBvovSyOuztfUdnsIMpIM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0dXGfWBtCwfzsavv0jjFkZ8wWphr8dbuxw/ZkwB48wItwLXlLRt0JToTqC1l?=
 =?us-ascii?Q?hU7ks04EtNy/4b9Eff4edSWxGPTj4rmFr334R229wSytlNWdmCDwJQMa8OyW?=
 =?us-ascii?Q?xJ/VV5FQoqI8p3T7ZH2ldQDlshnFwHxuguoPdYZRUgan1JXNaOs0V3P5H/Yu?=
 =?us-ascii?Q?8zs7Y1Dxmr9lunzoiLKugIFKixOLi7ucHRbmi1kDNbCZTHjThCH7zucgBR2y?=
 =?us-ascii?Q?odYY6WSIZjcAN6xc9bY7Niy1FkSI0gWBF3GGCWhbWVM5je8xLYCxApfGodGp?=
 =?us-ascii?Q?S4/764qPwtLDFK5HJUlF9i2LCaxljyqkcISvrlrYkNOX3tx2xAQVnq37cP40?=
 =?us-ascii?Q?xOTZUoKlQIfWFL7vzhTcxPBDLuhz+JLZGbUfO5sfK7+2Sy9wzPYUORr6Y2Vo?=
 =?us-ascii?Q?JsQgRrpC9Ae52DzJ3VXTvbx0TKJg6IT9evqJlTLJoUO6i0nZRFQFuef005ja?=
 =?us-ascii?Q?PrnkdenpTizSU/FxFikfXvcrH7MeF1ruKyHoNZePDWTmEnROJDSmxqQ4KpnC?=
 =?us-ascii?Q?eFAF8VPVlvZ7+Fa7dEF6I/JygSNqK2E0uwTE/exhvSM6LzmZZB7ELsqApY2U?=
 =?us-ascii?Q?79EOFV3yJmJ71XRwrFRJdChonTXYO8LrnQe401pugiqJOVozDW4EfcRES89H?=
 =?us-ascii?Q?PxaJArewvuHWb4GIlxrv0YDtqKbYCjigPJylH9YjK2058VcYMqLC42ltFBeT?=
 =?us-ascii?Q?qPyw6IYIvmeD1TiwrS3LkcnK8OXr+cVJqLFHZI5pWJPg3YhWKhxW1F5abVJs?=
 =?us-ascii?Q?G1jn1+WFMXs3qNrCu+RMFioj/MB6LrWI/hG4NbJC6KlGCmWGCLlbXHbpFtmA?=
 =?us-ascii?Q?FmcLBJA0p7vd3Q6mAOdTRLME+sEN4O4NcIWDyFmbOYUPsS7Uk4/wMaS2o/EN?=
 =?us-ascii?Q?clnxKExjjBn0Hu4QzqjMNfdnr6mdWx1iKV2Y2e3jWfgeqDaiALXgdsyp1NJ8?=
 =?us-ascii?Q?1ilfZ784JRKJbS+2Q9J3jNFV2FmTTGcsuFL68KN6nck8ebh6e8EaXU5p3Oht?=
 =?us-ascii?Q?ZayQf6Tcl3dGj7JK9TuAMZXKsIW2QvWGavkyVy47WuhtLLCfh55ys6PLCGMe?=
 =?us-ascii?Q?vxrX/woHfk3xGFGq13EVrfT/fsBQb377eXSmDxFOkMt7a4sZGPqe+cX+Us4r?=
 =?us-ascii?Q?SHmozAK+VWgd3Up8+df9OZSA7Uyr61NryRa+B309foQs9E3CdcyjzmUIprei?=
 =?us-ascii?Q?mxWqDO04Vb4Iu1LwcFydSq/U3RANpVoZSrxnikRyZBwJOSFVU4ns2QkAeNl8?=
 =?us-ascii?Q?9sFtvVnGwvxRwXyLOfp9ZhrH+iTMweRbmWMYtPCWPBgwFpxtlhGRvw+0m09P?=
 =?us-ascii?Q?TjbOIGJW788enJlAqk99KyBI536sCdDQbr4D90Za4/h5G8fO+aPDsH62RHWD?=
 =?us-ascii?Q?iSEBVH8PnHYqRalKmIYu/p6MZY9tKae/8CfRhSbrZi8/Uf/swBCFrVzBglW1?=
 =?us-ascii?Q?zvfN70z2Asp7jos0bbuC6SOQYogIbORRKTb0HdWR1c6Bx/5Pw+Fud72wKleC?=
 =?us-ascii?Q?OcYlsR3kkUM9pDlNe7IpnE2PDFrZvM8v/CE1uWMUpm882S3qX2c3dJffscYb?=
 =?us-ascii?Q?R2jz3fAiHFzwbvNr55YAdT2ScdYxhQZWGUWQejVnDtFuGMtY9mVEIoBy13gP?=
 =?us-ascii?Q?ODxOcu+Wy7CUJzfPVqzkVr/YwooVz4k2cucePle7Xexz8N58kqWyfF4UpWNa?=
 =?us-ascii?Q?7cuAdwRCRsICj4Y4rkLZoBNnJ4TPZZpf4OwyfSJeHisv9xnnFMYpH34mFW16?=
 =?us-ascii?Q?sojsyWYoYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8768f6-6f53-464d-4355-08df1efa45db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:53:57.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lADRyupMYM/YsRiv68ySn/WLFzs+F7ANmkLvnT2XUZ78ArvktUeUPY/UrEM8TvIBdInJiiZoWUHjElZHj8Tu9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404

Hi Kuba,

few nits below, none of them are blockers.

On Wed, Sep 30, 2026 at 11:47:23AM +0000, Kuba Piecuch wrote:
> Add a dequeue_remote test that makes moves of tasks in the BPF
> scheduler's custody to another CPU's local DSQ the common case, both via
> SCX_DSQ_LOCAL_ON dispatch and via scx_bpf_dsq_move_to_local(). The BPF
> scheduler tracks each task's custody state and triggers scx_bpf_error()
> if a custody period doesn't end with exactly one ops.dequeue() before
> the task runs, or if it ends with an SCX_DEQ_CORE_SCHED_EXEC dequeue of
> a task without a core cookie.
> 
> Without the previous patch, the test fails with:
> 
>   sched_ext: dequeue_remote: dequeue_remote.bpf.c:141: 15 (rcu_preempt): late ops.dequeue() with SCX_DEQ_CORE_SCHED_EXEC (enq_cpu=3 cpu=2 seq=1)
>      ...
>      ops_dequeue+0x114/0x170
>      set_next_task_scx+0x104/0x1e0
>      __pick_next_task+0xc7/0x180
>      __schedule+0x154/0x1870
> 
> Assisted-by: Claude:claude-opus-5.5
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

...

> +void BPF_STRUCT_OPS(dequeue_remote_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	struct task_ctx *tctx;
> +	struct task_struct *p;
> +	s32 pid;
> +	int i;
> +
> +	if (test_use_move_to_local) {
> +		scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
> +		return;
> +	}
> +
> +	/* pop past stale entries so that they don't leave this CPU idle */
> +	bpf_for(i, 0, MAX_DISPATCH_POPS) {

If there are MAX_DISPATCH_POPS or more stale entries in front of a valid one, we
return without dispatching anything and the CPU goes idle. It's quite unlikely,
but maybe we could re-kick this CPU when the loop runs out of pops while the
queue is still non-empty to make the test a bit more robust?

> +		if (bpf_map_pop_elem(&global_queue, &pid))
> +			return;
> +
> +		p = bpf_task_from_pid(pid);
> +		if (!p)
> +			continue;
> +
> +		/*
> +		 * Entries are stale if @p left custody through a property
> +		 * change dequeue or was dispatched from a duplicate entry.
> +		 */
> +		tctx = lookup_task_ctx(p);
> +		if (!tctx || tctx->state != TASK_ENQUEUED) {
> +			bpf_task_release(p);
> +			continue;
> +		}
> +
> +		if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +			if (scx_bpf_task_cpu(p) != cpu)
> +				__sync_fetch_and_add(&remote_dispatch_cnt, 1);
> +			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu,
> +					   SCX_SLICE_DFL, 0);
> +		} else {
> +			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> +		}
> +
> +		bpf_task_release(p);
> +		return;
> +	}
> +}
> +
> +void BPF_STRUCT_OPS(dequeue_remote_running, struct task_struct *p)
> +{
> +	struct task_ctx *tctx;
> +
> +	tctx = lookup_task_ctx(p);
> +	if (!tctx)
> +		return;
> +
> +	/* tasks can only run from a local DSQ, i.e. after leaving custody */
> +	if (tctx->state == TASK_ENQUEUED) {
> +		__sync_fetch_and_add(&missed_dequeue_cnt, 1);
> +		scx_bpf_error("%d (%s): running without ops.dequeue() (enq_cpu=%d cpu=%d seq=%llu)",
> +			      p->pid, p->comm, tctx->enq_cpu,
> +			      scx_bpf_task_cpu(p), tctx->enqueue_seq);
> +		return;
> +	}
> +
> +	if (tctx->enq_cpu >= 0 && tctx->enq_cpu != scx_bpf_task_cpu(p))
> +		__sync_fetch_and_add(&remote_running_cnt, 1);
> +	tctx->enq_cpu = -1;
> +}
> +
> +s32 BPF_STRUCT_OPS(dequeue_remote_init_task, struct task_struct *p,
> +		   struct scx_init_task_args *args)
> +{
> +	struct task_ctx *tctx;
> +
> +	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
> +				    BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!tctx)
> +		return -ENOMEM;
> +
> +	/* task storage persists across attachments, start from scratch */
> +	tctx->state = TASK_NONE;
> +	tctx->enq_cpu = -1;

Nit: maybe reset enqueue_seq as well?

> +
> +	return 0;
> +}
> +
> +s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_remote_init)
> +{
> +	return scx_bpf_create_dsq(SHARED_DSQ, -1);
> +}
> +
> +void BPF_STRUCT_OPS(dequeue_remote_exit, struct scx_exit_info *ei)
> +{
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SEC(".struct_ops.link")
> +struct sched_ext_ops dequeue_remote_ops = {
> +	.select_cpu		= (void *)dequeue_remote_select_cpu,
> +	.enqueue		= (void *)dequeue_remote_enqueue,
> +	.dequeue		= (void *)dequeue_remote_dequeue,
> +	.dispatch		= (void *)dequeue_remote_dispatch,
> +	.running		= (void *)dequeue_remote_running,
> +	.init_task		= (void *)dequeue_remote_init_task,
> +	.init			= (void *)dequeue_remote_init,
> +	.exit			= (void *)dequeue_remote_exit,
> +	.flags			= SCX_OPS_ENQ_LAST,
> +	.name			= "dequeue_remote",
> +};
> diff --git a/tools/testing/selftests/sched_ext/dequeue_remote.c b/tools/testing/selftests/sched_ext/dequeue_remote.c
> new file mode 100644
> index 000000000000..0f03044a5bc6
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dequeue_remote.c

...

> +static enum scx_test_status run_scenario(struct dequeue_remote *skel,
> +					 bool use_move_to_local,
> +					 const char *name)
> +{
> +	enum scx_test_status ret = SCX_TEST_PASS;
> +	struct bpf_link *link;
> +	pid_t pids[MAX_WORKERS];
> +	int nr_workers, nr_forked, i;
> +
> +	nr_workers = 2 * nr_cpus;
> +	if (nr_workers < 4)
> +		nr_workers = 4;
> +	if (nr_workers > MAX_WORKERS)
> +		nr_workers = MAX_WORKERS;
> +
> +	skel->bss->test_use_move_to_local = use_move_to_local;
> +	skel->bss->enqueue_cnt = 0;
> +	skel->bss->dequeue_cnt = 0;
> +	skel->bss->dispatch_dequeue_cnt = 0;
> +	skel->bss->change_dequeue_cnt = 0;
> +	skel->bss->remote_dispatch_cnt = 0;
> +	skel->bss->remote_running_cnt = 0;
> +	skel->bss->missed_dequeue_cnt = 0;
> +	skel->bss->core_sched_exec_dequeue_cnt = 0;

Nit: uei isn't reset between scenarios, so in theory this check in the
second scenario could pass using the exit record of the first one. So maybe we
should add:

    memset(&skel->data->uei, 0, sizeof(skel->data->uei));

Overall, the test looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
