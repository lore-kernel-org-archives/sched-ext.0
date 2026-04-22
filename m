Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77D3CE48B
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854823; cv=fail; b=n7mMrN5IxSFqsH/6qRN6h0vP7DxUMQqtLQqxnjSubHW03mRIrSyPp71SDhnaSIexXSJc8VFMRFBZJ8DkGhX7//euOaaerE+mltspGCHcScGZ0GP232icuCe/aphkZtNozgqnx6ACSDSb/c5BCUahMrTnLRTzw9Ru/x3IqpogAF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854823; c=relaxed/simple;
	bh=DPhJ+MNwOU9Pdt5zThjIX7Vz8M9oFBTT9uzi0liuwCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jvRXf2YwfrKea0VQYQ8jY93Wgcj5A69ki5j5gOjwhv+pu8zt818X+ndYlvMmpGZnt52eqECTnUtndInLH4K4mqEHBJQtfXFz3T4WYoi4CNQlL4i4la1ddrrON/r2VuH9JYh7wd66jWhIeoh97m0sc19rEOncfFZhd+QjVO16nMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YyvkMxzt; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YyvkMxzt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGIJY78ol7XFPufRaCozCqLvsEs+SLNPQGkepJegUePmSk7NemxAIg4mlCV+26tpKf9V3+qih+eou7lkX+kNUuWyswLu+7Jpjo+7tEZjg7XMt9WlydpxQSFy3+cdbUq4N564W14Nd3kD7pUjXdHssNklDgp/5lVctve36xDDf/dz1LVEpMyW6gcFsst0u/J/Ltq/nFTlOycpvrHv2cP+CbgEQzhMu6+eHpn+IRsH46lcXry7D6JjpPm/7kDe4uDlLsnR84fpm/kC3aZ6BVgEW9QFPXYFttfO985nuc/JC9K1dVtX7OEWVu+HFWc5iroECj0VhGpVZpHy31XesPVmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPVbwuWVLIDMWZaeGVM81VBnnUGs3glnN+H5z0756RE=;
 b=WnWNnABOn8nm8g9qK/xuSmi9uNJd2MqTS9ONR4TygELXIMnfp68ogh5Y+2xZw/PzVEMgB5RPnTumZsiDpM1KqizOPZ4ePKOLf3oRNoNo3bbnsv1TiggTr0chOp90k0UC3nXQ6NUuiiuE62FocT/8r5V2QFKk6K4h62JYPKa4BD5HLaKBw4de6fZy1Hh2aYoyq/pocWTaRbaLkpW4CSy6wjgR/mY+As7TMuf8x1awkHbjrQU/jBrUzB+xPGt7W9/IoHdAfpaF08r7LWTQ6eNcyuGkqilscQmv5e/f+jz6ZbfTLsVP1lLnZ2rYHxFJK7Ol5eitfaS7zMP9jbbIfD6SzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPVbwuWVLIDMWZaeGVM81VBnnUGs3glnN+H5z0756RE=;
 b=YyvkMxztDimkC08psXy7hu10H02xQQCKtbrfSpZ7ZoIJuwSCPZBZKagK6ZaALRritD3LsbChqd0YalZ06vdY3UUnVrNf1dT2SG2WIWQwIxFoLwBo6+GP+LyfYFN9BpwDBDIewxYCPiNzfgf0QmJqg57yInOm0SabXlKV6ztK1WU4s3Mwz1DRRc1ED0DRR3mdsFqaa/hcZAjg6NUDso4stERxsvBnFWzZgUtY+TiMqlIUXqSWJ6gsQI7pIbpa6BsmSNtJJvzhvxTher/+tAqNxuHxydvDLyfqG2kjuXPifs+8cGX2gqoMdylWYGJBR+IcAO3oNDpqg12GjioErKiybg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 10:46:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 10:46:55 +0000
Date: Wed, 22 Apr 2026 12:46:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: mingo@redhat.com, peterz@infradead.org, tj@kernel.org,
	void@manifault.com, changwoo@igalia.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, newtonl@nvidia.com,
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH] sched_ext: sync disable_irq_work in bpf_scx_unreg()
Message-ID: <aeinGzIPq4ACjQDj@gpd4>
References: <20260422100938.35781-1-icheng@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422100938.35781-1-icheng@nvidia.com>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea54573-5769-41f5-9574-08dea05c7827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7hnRzBl1gXJgoikbcFeU7VoloKe9TTLBfNZCgrUFB+FaLbGiIrguCzHxCGBJB9J18r5tow6eF6mL0GIxQX4QMdBSlewaexmFgXVa1498HNsF3kIPmzeMc0gJ668cj7FsEhRrpubt5YV0J19RzVB5c2ynIYSk+94dNCRgBoKkop4qWtn/RxP1uG9Q/KB/LLCzOdPjhPW74Sn6U/U92BL8WJxnwXK1VDAYt3ZgYtb/bUawNkXgQrBi5m0U8Dvl71epMaCvzREL4VX8d1J2Ua2WPJMQUz3WIGkOHaSCdbaTFAH2+j7ftKIlmamdlDv7kOy6qsS3XKRhtanwSh94lTw1XAs32MreraiXtTu+rWTslDtR0jhg6huQgT+cybvVcc0P62kb3BWxu1QWyp5RZaB+bE/tOe22YKx/lZWlgc90Qi9XYwIkla1OqIaI/UCls/5020ckF8t0VK0Z+FYOHhOn7eK+wikbPGEPLkuhk1AI6JD7Xre46INGedkIfdXWOAVvpgdcjCREq1nu2dSOXtI5kbV/CZLmEE4IZpICZlzrq2LBz1DL6Qzodm0ElImgfAMxnHcVez3OCX6g6kju0dDDalo4zNTvOX/c+i01M0wtT1DFeMRbLGZJEMHRJQLSQOqIeikTGlj0i2Xq148huU1+fQG+he5K15SmD3XTnq5D7xxM1F26W4cPK+DTXXWPz94Vi/8/bIYjU+zrpeTDcNZGC4rDeySlryQaRtjO65XYetU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rU7/F/8JrDjVHjqMwjsJKlXLwwu4fE8mJaNri8yOJCQiBtkCRyFL/PpCj6L7?=
 =?us-ascii?Q?vpAccxRjYCeuZnTCGoi51cFgBxAaiY2MV+xP6rDoGrPUB7GhkpKV2CqDPYza?=
 =?us-ascii?Q?x5hbsQfkAxip53iZELRiRriMRV8RBv8xaXCQBVZ3gGZwAlSGc+UhfJ9C4DnU?=
 =?us-ascii?Q?x5AGr0Pe7ArqF3SloGyRXhy0w5MXORbr4HzCZQtCy8+HFwqedrzroust7ARP?=
 =?us-ascii?Q?2q2hk+YfV0L77A6rd+MEou9WaMlF7YWFeHb/BA5ytYbhpQ6Yb6iKd6vgmTuZ?=
 =?us-ascii?Q?k1M5Tao1zs0bTVtuTHkwvuBlO8Q4D3ntQQJ7MASRgLytfaj5ohWlpRiM+Ze0?=
 =?us-ascii?Q?mvzQnuZ7Jje4b5CHil4k8cmP1EhKUBrcbGdbhf83DBWgvvw035fEZZLnPKRY?=
 =?us-ascii?Q?9wZhHe0UlAsOxHKHLNIM7hc92WJhrmc4XRiIjT+nQB2dwZVrUbT0YQWyB6rH?=
 =?us-ascii?Q?+lgiSbufL/7utBEtbNPWiqvkNSR9ZBClUDPto++U2SEMDTfAWLpfiFwP2M8i?=
 =?us-ascii?Q?4tgUQARRNImSmKmmVRSB45QItpCIpRBXLWDHRUN7Lmyo6HLKROIlAhlHLD7W?=
 =?us-ascii?Q?LBp6kfKuBglOTHi6DsBqnlHRkEliyukHnegdlWsCJRO59ErMs6QwgyUk9QKk?=
 =?us-ascii?Q?35PtnbnvNsG2wxGi2D1PqxFo+xT0Qy5zIKbTIYSh77b9jcSdLuNHZNtaU4W5?=
 =?us-ascii?Q?I6UMgtrDPrN7p0aTol6i3/xdo8MBdR3Kef+kfu01U1xLyS18Dh9FGG7QKbD+?=
 =?us-ascii?Q?sSo7DTL4e8C41gpn70YuYtFeNW2afMS9fp+Bp3JOgTnGegRsoWBztunWUXKd?=
 =?us-ascii?Q?CCd9w9mujDpzSMVjTUMRs1/PY41ythW3H63AmqfjUXws8jN8AaQ85rokziYb?=
 =?us-ascii?Q?McsYrtUjKN15Get6YhdC1TLSzb2gRCRIM2Pmi+G7FHXZ9VyYJJIz4qixzYmV?=
 =?us-ascii?Q?k132CJ/i+2+VQHXmXU0ipdgyYwZihSudkoqY5LOxF+k38I0mMOIsqpkxwn1Y?=
 =?us-ascii?Q?hqfaEuwIKdGq5XB2RTjlpJqItlR8klgtPxCcAB9b1Wpw2cUijDIpGTN5iups?=
 =?us-ascii?Q?RNtbBd9mO/aJhBDnq7aTvlmZCUHzVU31UeGaQ4N019k1930+/+jBmRkrLBiz?=
 =?us-ascii?Q?oi68jwGhDzxhtDpWtQPOR7MlFm5rjEfQ0/CK80KRWyIJJbR0OFt9+qFkprDd?=
 =?us-ascii?Q?HLa5HsxnHcstOFr0H/k3Yn/oatSQssj42h0OveuzUHRNoeqKthaeGSwSK+ub?=
 =?us-ascii?Q?om3BbXr6m12TmTD4DzMpHVB0724DmtNh/krGZ5Xzt9Sw48cl6EkPpswwjxfN?=
 =?us-ascii?Q?Lp0R3sJSXgmtgkV/LhyDUPYCKL+PZcxZ7ojWUQ7re75KDrcUxr6ZkZIT8Bi1?=
 =?us-ascii?Q?euGcPaBvGA7J6jg+c/ZwZ9qIufd7D3QbFc74DiXeJM4omN9CdsQ7GRfbV8yl?=
 =?us-ascii?Q?CbZLv2HJn+8oLY/R362rjLjWm9OtrO3Ic5qSfRX4nM+rEjwH9pucetVwwp13?=
 =?us-ascii?Q?BQSMSbPPD0CMInsvI7yjhLp3YIDyJpBTd2q8IYtW+74fsIR135wGfUnjKJzd?=
 =?us-ascii?Q?vK6MUEbSZsYu3X4lDcuqB6EeTSI+1aDuHDwORiV7guP96Wb5dzywWV6x132E?=
 =?us-ascii?Q?JBm2ewXJzs2SL7y8sC+rv5r7tHZyP46dyQXD7GYFD9Kt0vYVMZqWgKkld0yJ?=
 =?us-ascii?Q?InJf1X2/Tf6iL/A+NgP7olU/cthvY70e6/feHusfdcUi7/LcXtDRjb9gxNbM?=
 =?us-ascii?Q?jmztzWWp/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea54573-5769-41f5-9574-08dea05c7827
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:46:55.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dh/RJXhxVpGt44hnIChuGmZbTyGKAkcT6aQGuhVtOIsXGCsyE6B4UOyn8t4+AhXp5wHfrE4noudsob8wui0pfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

Hi Richard,

On Wed, Apr 22, 2026 at 06:09:38PM +0800, Richard Cheng wrote:
> When unregistered my self-written scx scheduler, the following panic
> occurs [1].
> 
> The root cause is that the JIT page backing ops->quiescent() is freed
> before all callers of that function have stopped.
> 
> The expected ordering during teardown is:
>     bitmap_zero(sch->has_op) + synchronize_rcu()
>         -> guarantees no CPU will ever call sch->ops.* again
>     -> only THEN free the BPF struct_ops JIT page
> 
> bpf_scx_unreg() is supposed to enforce the order, but after
> commit f4a6c506d118 ("sched_ext: Always bounce scx_disable() through
> irq_work"), disable_work is no longer queued directly, causing
> kthread_flush_work() to be a noop. Thus, the caller drops the struct_ops
> map too early and poisoned with AARCH64_BREAK_FAULT before
> disable_workfn ever execute.
> 
> So the subsequent dequeue_task() still sees SCX_HAS_OP(sch, quiescent)
> as true and calls ops.quiescent, which hit on the poisoned page and BRK
> panic.
> 
> Fix it by syncing disable_irq_work first, so disable_work is guaranteed
> to be queued before waiting for it.
> 
> Fixes: f4a6c506d118 ("sched_ext: Always bounce scx_disable() through irq_work")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> [1]:
> [  188.572805] sched_ext: BPF scheduler "invariant_0.1.0_aarch64_unknown_linux_gnu_debug" enabled
> [  229.923133] Kernel text patching generated an invalid instruction at 0xffff80009bc2c1f8!
> [  229.923146] Internal error: Oops - BRK: 00000000f2000100 [#1]  SMP
> [  230.077871] CPU: 48 UID: 0 PID: 1760 Comm: kworker/u583:7 Not tainted 7.0.0+ #3 PREEMPT(full)
> [  230.086677] Hardware name: NVIDIA GB200 NVL/P3809-BMC, BIOS 02.05.12 20251107
> [  230.093972] Workqueue: events_unbound bpf_map_free_deferred
> [  230.099675] Sched_ext: invariant_0.1.0_aarch64_unknown_linux_gnu_debug (disabling), task: runnable_at=-174ms
> [  230.116843] pc : 0xffff80009bc2c1f8
> [  230.120406] lr : dequeue_task_scx+0x270/0x2d0
> [  230.217749] Call trace:
> [  230.228515]  0xffff80009bc2c1f8 (P)
> [  230.232077]  dequeue_task+0x84/0x188
> [  230.235728]  sched_change_begin+0x1dc/0x250
> [  230.240000]  __set_cpus_allowed_ptr_locked+0x17c/0x240
> [  230.245250]  __set_cpus_allowed_ptr+0x74/0xf0
> [  230.249701]  ___migrate_enable+0x4c/0xa0
> [  230.253707]  bpf_map_free_deferred+0x1a4/0x1b0
> [  230.258246]  process_one_work+0x184/0x540
> [  230.262342]  worker_thread+0x19c/0x348
> [  230.266170]  kthread+0x13c/0x150
> [  230.269465]  ret_from_fork+0x10/0x20
> [  230.281393] Code: d4202000 d4202000 d4202000 d4202000 (d4202000)
> [  230.287621] ---[ end trace 0000000000000000 ]---
> [  231.160046] Kernel panic - not syncing: Oops - BRK: Fatal exception in interrupt
> 
> Best regards,
> Richard Cheng.
> ---
>  kernel/sched/ext.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 012ca8bd70fb..065660382a0c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7349,6 +7349,12 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
>  	struct scx_sched *sch = rcu_dereference_protected(ops->priv, true);
>  
>  	scx_disable(sch, SCX_EXIT_UNREG);
> +	/*
> +	 * sch->disable_work might still not queued, causing kthread_flush_work()
> +	 * as a noop. Syncing the irq_work first is required to guarantee the

nit, maybe rephrase: sch->disable_work might not have been queued yet, causing
kthread_flush_work() to be a no-op.

> +	 * kthread work has been queued before waiting for it.
> +	 */
> +	irq_work_sync(&sch->disable_irq_work);
>  	kthread_flush_work(&sch->disable_work);
>  	RCU_INIT_POINTER(ops->priv, NULL);
>  	kobject_put(&sch->kobj);
> -- 
> 2.43.0
> 

I can't reproduce it locally, but from a logical perspective it makes sense.
Nice catch!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
