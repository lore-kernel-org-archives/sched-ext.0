Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D7337BBD
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001401; cv=fail; b=fOW6Dc9rL43dFjw48D0KdNy9NRer8rYV0OzSR5nSmYuqm4ssitwAK2inXffjd2f8l5FMIxQdwJv+wyMZ3nQYT8MYkWDcLHJj4IGmIPHxGrsQTpQC9X3gyRpzZo9M9QKB6/pkd4TkGEZMNhaXHN+ud1XwCaHlxRdT67YXYQ5SxfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001401; c=relaxed/simple;
	bh=4lFTrbh0ofVQyYqL1ZuuJkz+HuwJdDw6KAvAokd6p6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bTzDDYZd+4yc9vJQ+pLJcWJbpYtzc2p2JD6fiNnv/TKC1vTYB/LOxfng8/iEqzF16tDw2XNIChORPmlaLEIV3o3KZZiLY1bBptxRJGRMtbAPAS2qnTCpXCHLXp20CfUuNuOGinUxzPC5ZDymJgldILA7ChAbtx7NY0B4eGgvO+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A7eQVX4D; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A7eQVX4D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRmyJBQpFEM/TFNfkKZtovcCSoV8XsX50LtkrxtLIa3Mtfg/PvP8j1YtYPevYvedAERWg/aL6JKnO8EekWxw2eobGOS7zrIlzgSYpLjd9gmjMABoajZW4XFS1FfDsWSOAsLkKQYuLukcXWgdZIhQB9PeAOfLfdfglKSJWbpK5EoFUv50+LHtyW4BFWU1RCgsoPNi6n8GGJOzkXcoEyh+hXa5nnk0sXti9iwLm0h/d/FUnuLTTk4fNkBLVmgkvoeNJwvmlvRYL9XxdVLyfuzzxDo08NHRq1Q66MV3JCgaU5FXfUQtfZ8dlGmCv6YBb46+H5ieIwqNcJoBGUKoYxMiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vchoZM2fuSlZzzEL24KsTQrUsrZo9qF3zGD5iCmkF1I=;
 b=RNrDSFG+BwIU8Ygd240ktjUWgQkEuQvg4S30dGOm1Rj9NE+Oc2XTRenv+D8vloDD55CzeCZMY3a16XjVS61ZpnoN/1IVsI9e1fIFPinHarrEp0lojq7j44bA0bEmhumbIcjDcfMXfgkp3mweaM0niu46DVEJwR5PxM8hY8O3Gb8x3cgTub86DZWzvco9venT6+llkANdFqSh8Msb1TkRxc2SPZbEqNqhAtYooBeACi25/UoozR0TS3rGGTy4ZqIx367wyZzRIRVYYwzbk5ulnkKN6NBZi1YE2o+PgF+WcpR0X97Wf+oibWUVSHIh3FMysC55BWkkN1mwfSBx9DjgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vchoZM2fuSlZzzEL24KsTQrUsrZo9qF3zGD5iCmkF1I=;
 b=A7eQVX4Dhdp9S9vPFLtWMP9UrJdyJn7elamasHCAnjodv64m7vSQptG/xmk/EkG2SOuD5oAOysUiSV6oeJ9/LzVcnhVWb8tKJORT0IEiSk31xTFG0fBULk5S+HobxNCO6rvslNQniWupCjZESd/dpSF6pb0x9aj98qnKCBJQ5ZfAZonpSSoMhyLmtmqYGXL1YCnLPvXQ+f/YKwBOJ5e3Esv69VrNcqgn1vOK2F4/vDp8xL4S0cFGlyTv5ELyRBQv3f47L+GqXjJhXWOJsxd0g+9NhHrVZx4MfHmPBNH/RQTV1b5Q7NRPNvkxoZWe8QrDuv44uOgEj5jaOhr1hF0D9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 03:29:54 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 03:29:54 +0000
Date: Fri, 24 Apr 2026 11:29:47 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: arighi@nvidia.com, mingo@redhat.com, peterz@infradead.org, 
	tj@kernel.org, void@manifault.com, changwoo@igalia.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: sync disable_irq_work in bpf_scx_unreg()
Message-ID: <aeri7w-jU_kSzn8K@MWDK4CY14F>
References: <20260422100938.35781-1-icheng@nvidia.com>
 <20260422183307.Gf0f8@cchengyang.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422183307.Gf0f8@cchengyang.duckdns.org>
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e71d3b5-0bf9-42d7-fde2-08dea1b1c020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BOMJp2oAx4IPPZGRClDC1yjVbsLAmzLZtuNW741TlbBd9mfjtmH4euI+LgHHuPJ3nyo+tZ+FffP3wnpWto+eirX9Na9OT09YnSadg4Vz3pwO9Kd/EKfMesS5/NGJs7HWhiN/UzH0DX8k/5zXFdFsAMsRCzo+XCOn+yZ44Ev7lt9ydPSoVZ0pMQ2VpnrNkrB2xW6UrqDPfIa9TQVA3b9UeMC4Xwgj65/UzYOwClmu1QG/0VNtXF67l55HEWArrquj2/cIe0dULAlxHpy6zlomghs/gmM4uw2e0yp8dDmYbLuHkfiI6OdW4+MpVq7TQBx6I5mnix1geIMf67a1zS++DWjBl/9u1piYRVQxBVIBCPeLKXeujPNU/V+0dR9dv7txHBsJkpgVCuKNc53Bo/cD2WCcuU/1DA6EsSuWcyUHXy2iA3MvcYUGSCWTwyxFkgubL7lrIzbCth4h9hl3R6dSbTrD24NOX6FWGf28j9LrCRCkc1cMVlasG6uvRsV7UwyzjJ3Qr6TC+iXARq5CLK7QMo37+15xRvUe7VMsTXBHCSbeVF81JGWgPFWYUbX/vJRo263qcPpcDrYQRzu7XGiw+haIQweBl29NsibznuvmwT/wvmJFuSC0D2198vYOt7stQenRWHU2IdpO5QIrnr4Y1zrviAjmbdAhee2C7JUEo/thBXL3uqXYEYrQHdbt9oFQ/Kr3XkQhE3kJ4oaRdBJEUHO6s+OUdUkV1Ri6LtWRHGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UR9xnOSU/ANhQ0X7tEStu+d002vL9xFncWP6ho55aYEstMzdIbL5GFobhJW5?=
 =?us-ascii?Q?Ef1jzbM5015EJA2X2er3TNQe+eC/hJWSAKNIHhs7Ohr4AjswTQ3fddkAUop+?=
 =?us-ascii?Q?JQzj3vrKdtgwbcFwec8mvBfh96rmh5VxYAWP2jAdkktAR7ZM5OmSoAHArXTB?=
 =?us-ascii?Q?KylIf/ED+miUCp9hbHBtCWFCuM+GHR4JMjg73hNt79Wr0ykZLFsajAgyqIAO?=
 =?us-ascii?Q?4qcYv2OPb0HOvLBkLK+B/WvHpag5uGkdCp749XkB6lmav3+vNTxqzdVmVePq?=
 =?us-ascii?Q?Fwy7iFAiTX2X9GOkOYSDx0p5F/tG/332vCP5GX+O7Cewl8y226pazUcKPRYU?=
 =?us-ascii?Q?9yJnsyAEAKNcB07mBQU1KFPiHs5Er8C8zE1OLzQqnbLpRb7v+V3sSPH7rlZg?=
 =?us-ascii?Q?QH81tifB+7AAC1aRQK0qmhmnRvO5siMYxj2gf+11TmgcXJ9n3rLMASwgagwm?=
 =?us-ascii?Q?iRyL3b89vHXU0JZO13ZUhe1MUilAWMB9fBnOILFQ9lyyZID1KTP0KSypd2FH?=
 =?us-ascii?Q?x/38Iy3bE84MpcAiiaIy+ehTsq5TT7rDtduQMScsmko3qJDQlI/nSlWjnYEG?=
 =?us-ascii?Q?uvoe6LKEt0NdTFEmwPta4BHgvxQiEumvoEzQ5+YOuEYNZq4D3yhEMginRagT?=
 =?us-ascii?Q?2FnH9//TNA8C0Q0FJT/Rmb8NGhyUTkZP4Gn19hd6DelpGyZZXVZDxe+TLlWv?=
 =?us-ascii?Q?norYnEHOcCh4ZGVK/kaWulHWHz1Z1GS0X4+fUqT0FWDornNqgQe3j3nkILjl?=
 =?us-ascii?Q?xv209iWJm9+Lf0BG3stP7Iw1rA3mSnZKmGYfBBmvskKcRPFA8QBTYHvOog7p?=
 =?us-ascii?Q?dYCKwHsU3qaFXFM7afVKxfuUaQAfAx1yZYVDxjcvWAXCkNRtmMndB+wmZItT?=
 =?us-ascii?Q?eLvhVTQvA63x5L33RwG8DT3Ss27KwOzfR5wX9A3o+50aw76//RFL3WVpYF4H?=
 =?us-ascii?Q?Kl/FKGELZYagwewfwVeUhLwIuLzRCUzaWdLN9MCZup3oDCBfLBQNRiApQTlO?=
 =?us-ascii?Q?NoLpEzEwqNDwPJaZsR2OUbNXvkvw8TyzcBPuMdabDtvQcN6W/nBvzSBmqf8b?=
 =?us-ascii?Q?VIKSjDwA28tHM0swN17/rtZPEUISs6ss6gBnXSGjpIBa7mbz4uJpkXeny2XV?=
 =?us-ascii?Q?I8Yo9DFxnj84tU9XFAc8uLyBk1XkTaFtkTr9uSJaWToNieOT/UFEmynOJ8pS?=
 =?us-ascii?Q?qkUnJHgmE5woPqhrBspuackASGo6XdM0rK0dPW5Z5ruenB/VLzHJSnc7GtCT?=
 =?us-ascii?Q?xf0tVz8+NCuO38ZcHvgg0uU4n3PfiQg6ub35RGzmT8+g05SOtSboc2KnmTeS?=
 =?us-ascii?Q?38Ik5AQTcUN7akARbR2sljezX2YNy99CM9PgUZIpBEvSfPWGiMjLK1S0Jkls?=
 =?us-ascii?Q?UJrI16hVrTdRx08u+vFPBVT5xPrDzNfrygmg7xTomYsh7xDDScgr7u1xCro9?=
 =?us-ascii?Q?5YC8fM4WbbmJBfpdIrRwO9G858Ivh1O+YXhVZaYMDjBZADce2Lbzc9Ky0Hp4?=
 =?us-ascii?Q?XXTexrJ34UmidnGXzljeaC444Gvbj3OoDv8mAxcapNF+1ZDaasEdMEf4UR5p?=
 =?us-ascii?Q?fYaunj2IYtoG/VyewpYDDguHZ9t7z1YkjKfFSTW2TUru2O/hUkYPmkFToH7l?=
 =?us-ascii?Q?tLpPnklmM8XLQOT/ZaTfsyIKvC0P1TTIo4mDWXG9wbplCPjeXhrWH3V29kqn?=
 =?us-ascii?Q?IVtd6x+hnxqtqGD0H69g4EwOTw+fbWb8JBYrqpSqLrNxHrG6uepp1fbWynI3?=
 =?us-ascii?Q?v2P7CL95QQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e71d3b5-0bf9-42d7-fde2-08dea1b1c020
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 03:29:54.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B33OB+qBTd3ZH48+UWYfjo+SpCrWQ87qUyLRkYNrkxL9+2gt+zJtumJ0+mEztc4yNoIi/Oov44QBhhiclRP7OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765

On Wed, Apr 22, 2026 at 06:51:13PM +0800, Cheng-Yang Chou wrote:
> Hi Richard,
> 
> On Wed, Apr 22, 2026 at 06:09:38PM +0800, Richard Cheng wrote:
> > When unregistered my self-written scx scheduler, the following panic
> > occurs [1].
> 
> Nit: you've placed the panic log [1] below the --- separator. Content
> below this line will not be preserved in the comment msg.
> Could you please move it into the commit msg body and send a v2 patch?
>

Hi Cheng-Yang,

Sure thing, thanks.
 
> > 
> > The root cause is that the JIT page backing ops->quiescent() is freed
> > before all callers of that function have stopped.
> > 
> > The expected ordering during teardown is:
> >     bitmap_zero(sch->has_op) + synchronize_rcu()
> >         -> guarantees no CPU will ever call sch->ops.* again
> >     -> only THEN free the BPF struct_ops JIT page
> > 
> > bpf_scx_unreg() is supposed to enforce the order, but after
> > commit f4a6c506d118 ("sched_ext: Always bounce scx_disable() through
> > irq_work"), disable_work is no longer queued directly, causing
> > kthread_flush_work() to be a noop. Thus, the caller drops the struct_ops
> > map too early and poisoned with AARCH64_BREAK_FAULT before
> > disable_workfn ever execute.
> > 
> > So the subsequent dequeue_task() still sees SCX_HAS_OP(sch, quiescent)
> > as true and calls ops.quiescent, which hit on the poisoned page and BRK
> > panic.
> > 
> > Fix it by syncing disable_irq_work first, so disable_work is guaranteed
> > to be queued before waiting for it.
> > 
> > Fixes: f4a6c506d118 ("sched_ext: Always bounce scx_disable() through irq_work")
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> 
> Thanks for the fix, and the logic looks correct to me.
> 
> Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> 
> Also, scx_root_enable_workfn() has the same pattern in its error path:
> 
> 	scx_error(sch, "scx_root_enable() failed (%d)", ret);
> 	kthread_flush_work(&sch->disable_work);
> 
> The comment above indicates that this flush is meant to "ensure that
> error is reported before init completion". However, because scx_error()
> goes through scx_vexit() -> irq_work_queue(), the flush can be a no-op
> here as well. The same applies to the sub-scheduler enable error path.
> 
> Should those be fixed in the same patch? Tejun, Andrea, wdyt? Thanks
> 

Sure I'll amend that part in v2.

> [...]
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 012ca8bd70fb..065660382a0c 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -7349,6 +7349,12 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
> >  	struct scx_sched *sch = rcu_dereference_protected(ops->priv, true);
> >  
> >  	scx_disable(sch, SCX_EXIT_UNREG);
> > +	/*
> > +	 * sch->disable_work might still not queued, causing kthread_flush_work()
> > +	 * as a noop. Syncing the irq_work first is required to guarantee the
> 
> Perhaps s/noop/no-op/? Though it's just a matter of taste. ^_^
> 
> > +	 * kthread work has been queued before waiting for it.
> > +	 */
> > +	irq_work_sync(&sch->disable_irq_work);
> >  	kthread_flush_work(&sch->disable_work);
> >  	RCU_INIT_POINTER(ops->priv, NULL);
> >  	kobject_put(&sch->kobj);
> > -- 
> > 2.43.0
> > 
> > 
> 
> -- 
> Cheers,
> Cheng-Yang

- Richard
