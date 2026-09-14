Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232352C11DF;
	Mon, 14 Sep 2026 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388351; cv=fail; b=qrzsNOj4kZr1P4XHTthpV4c3Bpj9wJGNdG9NgUyNhLTMH/T3VfTLKEXHDWozQ3zQdDTEbt+o6gFWLEgDtzuW4pm8FhflQFyg+Mj5i+Dzw+l10YhVJx5TPDfrpcDiMNCx+ZoCm44/dMI1Lu/wZzZr+zglulKEc8b7Asx4nJYubCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388351; c=relaxed/simple;
	bh=W5NOi6Wq5vY31i++tbJAJg0m9wU8YXJUJ/4KMXqC7Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GfTnbR8fxONwmJ3eIAZhaEondA1Evu2QSSpYb1gez9/DikTs1u9Jo8uhxiFNA43ZnlgF8paoSYmoP8aOymX0mj8EpiUOYiQ6IymLs/zcoYG5PWPNgDLWZOoU5BLi86JzaN5u3vrP0mKeECTajllZUhlTSK6i6cOTglu4IUTAvBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TtONWYlB; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TtONWYlB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c61b+CwKwXWBEFHBiHd2XozQPFZj6RuJrKMbTsM3xjvPy2OviLEnK9yZBkeC4NHYv321r69K/X+VtfCvXNcYYft5WrjeV0zM0rMg+KLSl1VkATAWVtPqIcRNzKt49t40/kiRBM9mrg88RBr/WHvQEP0tM9+XlTPsUqqNzeauZMOdd7H6tGWEG79SaDi9gdPwvBv6RPOeIljkv+2FuxdyCrAZuAocBedQURfX0yn/ZHMup+yYY7+p5puVcmplJmoUhwFKMay8Eqek8ULW+RuEMHYcLN5c3Hmnn2PvOx44PdWIOXr5e256PrvLFtcjf8Yd8g87oCu819+cwqhU0vzGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8YJEh/jVbzhKno7SNxErArxCxr2veKDoUQMr8XGoCo=;
 b=qktniq8S9BKqKxpx6MDhpF8tF3AjlPEdc3VhylTsAasBm3vg64h0X3mxrXVRlWJ2pQ4zK4O+RaXCJXCrZruqfJCmC8Nn1tsfkXahVKoy0fNdq6iLQJX/has4gz9PQBenjw23MG5hWGhnzlMBdWWDiP2LD2j1lIvftZs47W+5JM3Fk7Dmb8s7WaWU1kDizwOChK3sOQmXD4j23e+pMdU1vHFMUDYmSSQc4ytuz0ctF1CFqrK+BB9C/2TUD2ni1tslrt+Hf0dUmpqzjpe31OlmucbVwqUIpNxscSRxzc6gNVZruAPdDjrA+YEhwwf8tdbJT8Kmgs2H0AoTM6FnhwmocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8YJEh/jVbzhKno7SNxErArxCxr2veKDoUQMr8XGoCo=;
 b=TtONWYlBDwoSJmOcFgrbSOBDiQX/IXzi3rEeeM+66OFhY9PXk8klYYku69gWG5Nrjwmfm4AKXXYhQfnYDfkHC1g4VCawGWAgqvrF4n2/3+6E3poklHGJx+8g6w8/2BjbbSMAHIdLaiwFQFCS7ZdIrd0aJWCbiybq5XhlQovrb9y6sVh6lBpupW+v+AVPndeoXigmaIllbo+XMFxmhgPNhsP4NiiVR3qCLxqYGfWEsNS43EsqmDklSBl0BTTBlAfRI/yHc1ewxVLasHVuRynsUokq3C1xFHdKb8iynBwmjnLxLaDJfrbxK91vzAx3RilqqUSdCNyKnhUiA4qSGng2Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Mon, 14 Sep
 2026 12:19:05 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 12:19:05 +0000
Date: Mon, 14 Sep 2026 14:18:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Message-ID: <aqfmLZXNue5VhK1w@gpd4>
References: <20260914084955.1798562-1-arighi@nvidia.com>
 <20260914084955.1798562-2-arighi@nvidia.com>
 <20260914090640.A47A81F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914090640.A47A81F000FF@smtp.kernel.org>
X-ClientProxiedBy: AU2P273CA0107.AREP273.PROD.OUTLOOK.COM
 (2603:1086:200:6d::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: d789d19a-4eac-487d-765a-08df125a5e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|4143699003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ARyuD+ZLwYRzWnUMrUZ2QWEpX2sN+/OOnoSWfOTzN708rOOtOR0leUhRPvN8AFL96zYUfcRsfO5kzE0a6jWcI0FShS3O924OLoCtpKC//7FqeKOR70qbLFbFSq/SSvPNyrTTr8BaQs+2Sex3XYEmUxTEXqEQ0EEOuvTKmpRYumyhVXCdD7mgLkLRuRRQOK5U4mEJWkvCyPXXUYXHdIKM+KDr9gg3lr+MIMy0FfJLeW/eOIF8XLzGZd/NiA9AeOGNKbuS/rr19sRadjsKhV5Vj3C/DP91L3E73KinwWsfsXyyvolQOtz7v56FHLDJhnqOenLCuBdbJjuc/S8YzLFrZnZlUlMJuuOJFlFMDbitvkZ0EmX+7P3ElgM5U7t4Tq9WA7vTo06JrNSpbaCmlfoTK9mxaPoXD7a3vMYLH3O/VjuKetQJRNNJ6iy51IB4BYQBrbPb8nHOP4yDKNj9/+HWTHO/SQi/FBD68ki6BKYqsxK+70mY9BeqpJWfg96tIW4s9sH9X0Vwo/L3mMXAZWCATbhPk1D/reuaV/7rYcjPZ6R+WTELyl6RK7rzv0Bc81JI73NDATr/7IW2vLw5Q/vbeQfM2RE/sOK2aCS2w9uCddyhHDkLlXjyW1r2Km9GDmOdpnR4nmkehiuciTDZsBSb4W4zvz+JpJVY3dLeYNVYbY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m5u+fLXClH+qukkA4HFDv1x7BjSVTmLonTV+THzFOl4greReo1wNgxY2rBZv?=
 =?us-ascii?Q?cTqQWXFVsZzf2dfGjwp9uUGFA4yirMAk+Q6rskihIdVKq43b36T6vK5vLzJy?=
 =?us-ascii?Q?O11o+fCW/V+mOII6EhkljRWP9sEvyWhOQhDeveyON3gyj2POQKTVc8aP37VX?=
 =?us-ascii?Q?gD0iw7aBFsj9U3oHpTXtLfJoC/J1/f5fTyebbPAJduJgasUvMD5viBCiHb16?=
 =?us-ascii?Q?QIAdk1iNIYpzASGEZ+rEfXT0KNPQ+L/R19quH/oKdX5+X4QcNKDHW+Bno5sE?=
 =?us-ascii?Q?++rj/RtjqabKk15sXmWMseDx+q4kzyS76qIg+186OXPcVGGmRXkCgGkJ9vN8?=
 =?us-ascii?Q?Umx6OikDolOuGjjPyqEt18533j467n2R3B8C8hiTi2J6N8h1pXI+kwJ87ZJI?=
 =?us-ascii?Q?YY3kgGNaViEtDYIJwVAJWmwmCLnJ2amEAcQoygebwiHRABTmCc7w8p/MIuJy?=
 =?us-ascii?Q?bW+HxXObbgxbCSLTQxgGAxixWemVB8AP29we8FXJU2HYXCv9Q1PZ8IC3TKSa?=
 =?us-ascii?Q?+Kn5pE5V/QahYwZ0wzr2CtQsFh2aTqHlsA8oxVMIuA6t1K1l52pGHMKqvfcm?=
 =?us-ascii?Q?EnQt2EGpaR4zKKPPeSP76/lfLDwQth50ekVC2uOKPKPCueeR8J6RpKa7L9F+?=
 =?us-ascii?Q?nfB83NEkebjysChpo6XdrTQDlS5e0+4FvNxWZ6HFTm73x+kWQvArKfBCXCm2?=
 =?us-ascii?Q?UCfAzbF/AYTmrV9Tqq5rAYCRVXnCkr9yw3FdP7b6Ici5t9pgC/EQiyI8A0Re?=
 =?us-ascii?Q?TmiGQz6Fu5U84Dfy0FxSfvxBLmAunsJaX9DxPZCnnMU/3+7+QqMCmdSniKpX?=
 =?us-ascii?Q?0oLsyV2+bQ5kaNWHIKM83FhdXLGDOlsFW7BLvJeypkfr1A1BvOrffl3X7LFm?=
 =?us-ascii?Q?yITMUlnG1XUXHkFYw0zrzn0mLf6N6f4OPPx5ghCKr6BCvij9m0gGtGu4Kk8x?=
 =?us-ascii?Q?IDijfPUhwRvPI5atOA7MMNuiLeB7kQEVxntEKrZzP26w5E5EKNeaLNqJ7v0N?=
 =?us-ascii?Q?8cXWtRjXVIjoZKcT5POIvCaXehDGM66wmf7zjJM6RwsVVqnMUU5pbADhkyr7?=
 =?us-ascii?Q?5YUS7ZP4zotTcpIWDy848gDbaGV1yTT+Yru2cAGiiGBMVINZ8C44uuW0KamY?=
 =?us-ascii?Q?7fPlviiav4mENvJxq89jmiRU5ampq71ZqdeScgrF5BLQVdyqj2r5fWmc+6+g?=
 =?us-ascii?Q?FuTBzonVeWCFWOzne1SLk5l0qi0Ow35VYTIgYE36uk4ekmFnZf1wwd+pQRFS?=
 =?us-ascii?Q?J8lOZBmCY8AbrwETZ7fvZhFUccYxkfJoxIJty9DOzRhM9mW5eJVr9NVP1L6z?=
 =?us-ascii?Q?eGxtW9KxSebIjOufeceDLzDCy53E1gJJJVPc8t0DOc4WSwjgkodnLkTX89+I?=
 =?us-ascii?Q?plqmDRU04QeZ+s3C7rx+B2c2v+4cNuDVu/vzbYfKrAHsB++zNR2JKAvoZET0?=
 =?us-ascii?Q?L/wuHVaMDm0bVe07oS7pc1kw6yxTIm16Ljn7mebAaGa1FJ65+3ou1FGubrNe?=
 =?us-ascii?Q?6E75b0TUav0uWqgyzlAq6i9qSorHVVFz4g6WWuot5OnRd+eCMtJ5P/cINiBN?=
 =?us-ascii?Q?tj22X20QoiZ6Re+VnJcSr6+85VnNTyYfvm+cJmXwvh9wBP1ms4AwQmSMimvv?=
 =?us-ascii?Q?9TV6Md1QAtE45Y3Z0+ZDprUL466282O00w5PoUHJx3uUhziNf16UuREpYA5Q?=
 =?us-ascii?Q?vHCDJM/w0W8BKdvko5TDjqtARjlQMbKFmwMhOodqTbtdbSaiLDFviRpcZLbD?=
 =?us-ascii?Q?uea4m6LJIw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d789d19a-4eac-487d-765a-08df125a5e65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 12:19:05.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCN8/tXHa4vEZl7MkyVHulTZZIHDWom7o42lR+e6Iwen4tMHVvtS7xcLrjMmKvwfQS/DCiRNkqJj4xQakqrvQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

On Mon, Sep 14, 2026 at 09:06:40AM +0000, sashiko-bot@kernel.org wrote:
...
> > @@ -1515,6 +1515,23 @@ static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
> >  	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> >  }
> >  
> > +/*
> > + * A task with an infinite slice may be running with its tick stopped. Lazy
> > + * rescheduling doesn't send an IPI, so restore the tick dependency first to
> > + * guarantee that the lazy request is promoted by a real scheduler tick.
> > + */
> > +static void scx_resched_curr_lazy(struct rq *rq)
> > +{
> > +	if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
> > +		rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
> > +		update_rq_clock(rq);
> > +		update_other_load_avgs(rq);
> 
> [Severity: Medium]
> Does this trigger a SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED)
> double-clock update warning?
> 
> It looks like update_rq_clock() can be called from paths where the clock
> has already been updated or the rq lock was taken without pinning.
> 
> For example, during a task enqueue, enqueue_task() updates the clock and
> sets RQCF_UPDATED. The call chain then reaches rq_owned_post_enq() ->
> scx_resched_curr_lazy(), calling update_rq_clock() while RQCF_UPDATED is
> still set.
> 
> It also appears reachable via kick_one_cpu(), which acquires the runqueue
> lock using raw_spin_rq_lock_irqsave() rather than rq_pin_lock(). This means
> RQCF_UPDATED is not cleared from the previous lock hold, and calling
> scx_resched_curr_lazy() here updates the clock without a valid pin context.

This seems legit. The enqueue path may have already updated the rq clock before
reaching sched_resched_curr_lazy(), while the kick path doesn't currently
establish new rq pin context. I think we can avoid the redundant clock update
when the clock is already current and using a pinned rq lock helpers in
kick_one_cpu().

I'll fix this in v3.

-Andrea
