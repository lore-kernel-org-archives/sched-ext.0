Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762F366DA3
	for <sched-ext@lists.linux.dev>; Sun, 26 Jul 2026 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047890; cv=fail; b=btipHhYIRo86AdXmTGD6ezS010+bVu9g83FWgsKLU27/UFco0XsUD/QMV5lOsnEfg0aWDQpEOf0g4RIc8J7xK7k9cdY3gJwwM9Ak+lNtk6zMco/bcD8qLmXXpefaqhRy6Cyptubo7SgJGFX9fo6RKf4pFtlM59pUEMHzqt/EsjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047890; c=relaxed/simple;
	bh=BPSg9h3KhHpBlJHJZ6UGsPv2QrdgQQqO/OT99O/yKu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rINtnAjt6TH3WCqnvCjwVjwdtWQgAZ9GdvsImfaW1JAa5CasKMmqROZ5AuykpaFfAJJhVQv/SWpIT+67OTAYbGY3s5z/0JRNQZHwM7Cv/NqUkOkvgIb7RL0bwCTDV2Gi8mgEsT+xfpGa/KhCAxAp6ySbXM+KqaRtidqyH07LEZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uSyQIUv5; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uSyQIUv5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ex6/ihFO0uv4oVxHIw/4wG9WxJdsKjdSCZeQvLN4JcamZRbKWJBBzT0NXA4LJHKlOnmcsUUJyJxQIzfjezdytfFN+ahYwPCvwSmoRfofZE+pVcFIDnl1BKrAdF5Dplhsx/TzS/EekJOCunWVL4cSGn+wNx09JV0e5rkiFiNAtXNVKx+59Likzi6I33a0/FkE8JOhVxyt15pUQyupJRAxLUmf7wUUzn2E5OszWHYjScjPIquULo2O8ahUxfiMkI74HG8ZMFD1nBtoqTw2RhtnOzT+qd2jsSYWkXSTFUslcbWkoOmq8KgjoecdvL+Xo0+qflu3nJ6Y40sDWJTo+loTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhoTHFXLAYuWxLw9MRwrkSawPlA4NgTUjDXfU/433bI=;
 b=SnAWrzkNYdBu/ENTjmIJ+9k5yJrH3wh+NVtUYn+0V1abCdxsYw20MEs3/8FmjV23yBX8Rvr26tdamozsJd1RNEVPvc7zEiwHe5eGkpOETAimoGosCqF2Rq3RtmB9syoFlGs73TdVf2YxGAo31mMZGsZQFFFXvBjJPOCe+dz1g2eyVI5dPv1kOdl2B4l5VicbO5elsPdtpTOfghzq078nPkkUO65QFA31Z2oDBORJPXgJfqyabb0uLLAjZBCJQPeQPzMpi+75/IxvhMqMpCcB/UOVTHOWnu16JFMZN4GjwJV7GuhTmThjv29ireYYVOdTOfWPzYnaywidQkx0xEUoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhoTHFXLAYuWxLw9MRwrkSawPlA4NgTUjDXfU/433bI=;
 b=uSyQIUv5Jtqn4CDlwIEK7CKC2m6ys3+TOGSjYkLaTHKXr8xTcxlt5vZRNYcnSW0jPwpfFNg+7RXsmxfhvMyleGWMNzTwjJGAYffHMWOGoJYQD6y3amubQECFziKGL7Cvnoe0TQwThXmiveB3J6k7stqUQPsZ/9r3NvhOwCezpJFKjpYLslzkb5hzeCKwYdxSzAJ/IqhL/mRt+N1vyAe5fvQwc8eJNRUll1eJjFLRen/dvnKJtS0jQ1VjRVUtwMEaYSGJxXt8ZFvGQYjyiMUDFnfOiWOrbz7f826pnTxOzurgG9O3l4G2wLX2EwBDZ0IDTfeuFwOetkXeeUQP6f0Now==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 06:38:04 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 06:38:04 +0000
Date: Sun, 26 Jul 2026 08:37:50 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.2-fixes] sched_ext: mark waker CPU busy
 when selected in WAKE_SYNC case
Message-ID: <amWrPoJQE7K_XOQl@gpd4>
References: <20260722143307.2772632-1-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722143307.2772632-1-jpiecuch@google.com>
X-ClientProxiedBy: MI2PEPF00000B76.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: be75af83-47f1-47a3-2e55-08deeae0720e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pkUgezFhF3qVvQg1XOEakA14KnAo0hmlCcnFiwvpoylSslcqoqMc4MQZyhkZ3lglbBIqmjsUHhd4HBY55pgo/743QV2P203/L6Jo6tErGPVu0ni1hTzH89uxn3gMtiiWcRxUn1691Y2yOs4dJ0A/oF26afnkuc40V8a58ef9Op02gPY6B8QhH0jf9O2naR5wQb+gDLuDG5/L+5b871EbheJYQfw4oBxXmn+SIO6iPC/uH8wpuvTWddORRcl6J5HNhUh6mKa4n7YFq07btIzRwV/Qu2FK2Xkpv1MomyZZTAwLvw6KiYL47I5j/8P5TR7ZeCwLTvHMVqrLw5wLzLhxPfcf+cdmL7Y/Yw3qzcODxVdnGjYBuzSk4fYiAPzZKsMpzpI7kzrzaWDftFnxWKgOxlhhmnBqE2YzEeLydoK14JZfvGDxG2ypST5B233zRtcmN4UjnU3dEgDj3AVDS7pfKeVTSAGSQJNB6t9rytrmEfNpCxs9OG/f4MQF3YvkpuTB6VWIlSFcS4mi8WPWjmSh2xZH7AsKq9C29IYXjURJCFvU9pSkSTj/x9XRsxvLRyXejbC//fvIKXlZQkiYbAUtP6g6BGTsoHxu8R5ggCvlM+yWblMTcnfeXydsL+2iZO7dECEC7bsMKQP6RIF4HkxEQPaQ6fVYC2Zb8n4Q82BNllg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mgyHLeJPqgefpM1BoxyOoFff7MGg62s4bvMknTY13Po2dpKYTsys5z1UTyZl?=
 =?us-ascii?Q?wUVGieJEGscVWasPqI+0Og15XWZ7htRBpjMifm3nEoNcTA7NvX7bZrS7tW7a?=
 =?us-ascii?Q?xEjsIUlt+yKwIJK1GXIqZ38xVXNxdzimvbwK+YUfVw+Shyt8o0kwqtqVruLh?=
 =?us-ascii?Q?QVzUwkMahOtdIIOxL2efXBD0rLMTUy27x58By3GrB1L/px12RDLcFQolgSWx?=
 =?us-ascii?Q?UKe2mfkOxYuCaDIB/ldC+cI6NvQTbvjgIOCT9aAP47TCchvTcidn2NGTzw87?=
 =?us-ascii?Q?CS1pXk6g/Vl+cS6YHG0e/e0vc/0LDEmXP1NCYwlxZoCc/uuSM7+4MSl1yMIr?=
 =?us-ascii?Q?t3JNFcuJP3KzfbfY1VZW9tDeSfHa8vTKyCNLueLuddL2Oj35dvihhLfXXekk?=
 =?us-ascii?Q?s41jZCN+Ft+80cHFPPBmpGvRhtQW40nmP4LvDv+1kG466canTxn+7/fofb+d?=
 =?us-ascii?Q?l7j43kfhQW3zURMINFHt6AHLdN/gMfWO1xryG/eSKH0ro6BkHajs6/b7i2ZZ?=
 =?us-ascii?Q?XeKyvIQ3hs58sTgMIQMmpO/lQOBCpyJW3xfQpXDk6GYqe2/5yRwxNars6bfb?=
 =?us-ascii?Q?qXn3RCvnHlDfBgWzkqSfwzkOUf7HQ1QiqqX7Zook8X7oKnOalVp+BKtgk9nu?=
 =?us-ascii?Q?L/3YRaQcuxh0VQdBDjQix8ix1kf+18vaL0uRIuTdPdtIfASfIToiq586No+r?=
 =?us-ascii?Q?Uk71v5x9fR0DZw/FLNiXJ/pV+mo/iITm3KpBmxlkfB+uKoZD7ZdpmmHACf2x?=
 =?us-ascii?Q?zm2QyJhgM0RnNsGrPx57/5FCGKoJufoHwp63p861Avp2/4yRPDFoyFEwR/Dv?=
 =?us-ascii?Q?kPDtnl2d9FncykSlBK7WgZNULOPP82W4RBNOAonpQ42NQREBQ5tnuBMNMxml?=
 =?us-ascii?Q?bxFmLuoYdj7IXfut6MUPbOeKFM3jFPdEpTqxEMLJpo5DbKrPxsAJHzlX3eB4?=
 =?us-ascii?Q?Vrtk9r9fhVgp7TeHocvhfH9/bzFucG5twHIrEj/9P97MUwHMj0ORmrSujOzo?=
 =?us-ascii?Q?vrkFx2/2CMCAwV7+K6jeiCqG4sA3hwvZRk97VYpGonLaY5bTBbFb8nB3cj+T?=
 =?us-ascii?Q?VcDoUMWn9Tl5H+uUm7FgfRDtqDVCr8YacnblMSUUWVTjFbSIQyYZnSeFxcVM?=
 =?us-ascii?Q?fgLkcMef/FFyru24EV8d9dKlhm8nKfiwDiBxW8P3oUVnqLA85DI6ZBzr9cea?=
 =?us-ascii?Q?Us47uasOOREKfh0EvNmH0j+vSGF8wfvB7f4jUp1x6R6WAIHt/0z1On8FPRK9?=
 =?us-ascii?Q?VChSY0n/aXDQUXgmZzn+wJVMs0gnlcZo7552xKh2P35LGOLhSihfDdBpjxNY?=
 =?us-ascii?Q?+2U/eEccwA7XWDNbqFwzYZqh6NxbCeYwgWhEs734+bTJN5qzpTYQOrWXMe4o?=
 =?us-ascii?Q?rBB94qyaDlCMBprm6tuoFjDpbyo3ppYZ2FcULJtCjNTnI1FdIwNrHx2cl7yz?=
 =?us-ascii?Q?8x1h8Ck47tG+G+nwFBhLlSkmIXGdwXqr+Xw2qWXye2esXhG/CH3fI/IfPyKT?=
 =?us-ascii?Q?oqYAjE6drW3KTOk5xrP/Z1poOcERuPMVO7dpIp9FijhGsI4Ron1wgzEKXF6S?=
 =?us-ascii?Q?0xEm/GzNUI9tvFt3jOYPZmpOgweqDE5tgUQzdENYNAhO4Lc9sEXfryvrLKtF?=
 =?us-ascii?Q?RrVVnOSVuY4tO6aWm8xpWYsP1dax97fM0Erb8KHmFKQGJ7q4Ou/8ts9rJROX?=
 =?us-ascii?Q?rLApMvaU1TlG/Npkc080/DaOsjrdEBb8ncFrHH95gMfR20L17z59+zXpq7M4?=
 =?us-ascii?Q?DsuQPzbLiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be75af83-47f1-47a3-2e55-08deeae0720e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 06:38:04.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJ+2GG0b+w2lDuR6QDUErph8vcxdSQOmiJ3XEtIr/vdBdebzMR4kaebA3GhgsdEX4dTeJOCK+wPprOQt/kJJvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754

Hi Kuba,

On Wed, Jul 22, 2026 at 02:33:07PM +0000, Kuba Piecuch wrote:
> SCX's built-in idle CPU tracking is imperfect and can be out-of-sync
> with the actual idle state of CPUs, especially immediately after
> enabling SCX due to scx_idle_enable() marking all online CPUs idle.
> 
> scx_select_cpu_dfl() skips marking the selected CPU as busy if
> the selected CPU is the waker CPU in the SCX_WAKE_SYNC case.
> If the waker CPU was marked idle by SCX, it will still be marked idle
> after CPU selection and potentially even after switching to the wakee.
> 
> In the allowed_cpus selftest, this can manifest as the test failing with
> the following message in dmesg:
> 
>   allowed_cpus.bpf.c:21: CPU 0 should be marked as busy
> 
> This patch explicitly marks the waker CPU as busy. With this patch,
> the test failure no longer reproduces. There are still some pretty
> unlikely races that could make the test fail (e.g. pick_task_idle()
> marking the selected CPU idle between selection and validation), but
> these can't be fixed easily.
> 
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

Thanks for fixing this. I'm wondering if we should also rework the allowed_cpus
selftest, since it's inevitably racy and can trigger false positives.

In particular, we should avoid checking whether a remotely selected CPU is still
absent from the idle mask after scx_bpf_select_cpu_and() returns. The helper
only claims the CPU at selection time, and an idle-to-idle re-pick can
legitimately set it back to idle again before the BPF program performs the
check.

But the logic should work for the local CPU in ops.select_cpu(): if
scx_bpf_cpu_curr() reports a non-idle scheduling context, the local CPU must not
be present in the idle mask. This should be race-free because the local CPU
cannot run pick_task_idle() while the callback is executing.

And we can also run a short bootstrap phase, forcing a task to run on each
online CPU, to make sure the idle cpumasks are properly initialised.

This would make the selftest validate stable properties rather than a transient
state. I'll send a patch in a bit.

Thanks,
-Andrea

> ---
>  kernel/sched/ext/idle.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index 8e8c6201b7df..6f93cc32b650 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c
> @@ -554,8 +554,10 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
>  		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
>  		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
> -			if (cpumask_test_cpu(cpu, allowed))
> +			if (cpumask_test_cpu(cpu, allowed)) {
> +				scx_idle_test_and_clear_cpu(cpu);
>  				goto out_unlock;
> +			}
>  		}
>  	}
>  
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
