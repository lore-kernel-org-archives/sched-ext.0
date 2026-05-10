Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CD8834
	for <sched-ext@lists.linux.dev>; Sun, 10 May 2026 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778435278; cv=fail; b=mIu2dR+6/ARcCDzNWjRlmAwSN3m0K24oge8H6jm46xcTU1g1w3um0d4vki23yumUVb97cLR0ZjNW0+SD396GsOUiEAB1Mk/PSk6JStvYXXB1IfwLHR3Z1NbAWjpfVCiSJFrQOMFpqAU43DoCqKxMiEpkPzRY6SzVs/eHs2TZ98U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778435278; c=relaxed/simple;
	bh=Vlk6UwOdAXZDRDhKkbvk+WMzMjyPf5D8V2vZnvRSNdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OHDH+t8aX24s0hphvAR4dH8Q79zMKXg8hhMJks7FhuSf9jZ2zWLNVqnRDjDdBQIqnDXYEB8fZpQsoCJhpcfrBvsZdnF/lWoGN0YInuPkGZOYJXo+VSrLjqykzYQDV+lqkcZWrn1cv0i6JVgJU8SJQXyqp++VMDVhfz2DrLuAb7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RQMw/BVT; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RQMw/BVT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuwiMvJgC/DeX5d5tvtqciPmmrXdTAswu6KDhQ4bvKbi4hzUsh/V48zsHNrNqRpuXRyVvYyJsIgSErl9TFV+TkUuFMr7s0aEHuifCKmVFZRhD2sp6G4IGk9NTaQTXlNljEURD95mrjKMkIzT45KIwNioN83mWf/vDxD+mx52ebKuxzItjpY3RjVIImxxg7nykoy/eq1r7z3LrH47sHh7uG8/mG2DNYAlgS3/2IhyxRyUj0yWuYYYZwD/O2yUFX4manVxvOFmw0pRQUalXJQTc2+fC+gVJlmME0fw+yal139g8DmfD5IQ18TGrBtnWMgPEJbkxdiNtL1IA10rZox8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nl9cvN5O3spzPBwuhxpOnGoSXb5QSiyrkRJkaXHwg5w=;
 b=LmIC2jwUm/T8m6vgp2r+rhXOcakkcLS9N1Ly4n85CAQZQJs3/ONBOSD8xKy2SDvZEQOkRXGEaJ94Z72R6/xtCzt0wo80AxKjxvUnS89cjNDN2ma2iyOnBQb7EZ5cC+djCe1Ivyp/3Xi+3W+MYJdyvjqHNiYP//0E0Cce/p95OZpLsN0h/QLgV1s2UVOhhD8IajEWHcQPtzqYlAzR8Xe52n2Bm0tVVgW4ykx+4ZLvlE8BIB+cS1ljfTMnKgY3rk94jQWVd5L/WBnvukd5K4AZL5vRwebiPloPVVP/pYjt4eUTBRwRGwQhY+6uabCfreq5O48soAPp0bycN5eF34O6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl9cvN5O3spzPBwuhxpOnGoSXb5QSiyrkRJkaXHwg5w=;
 b=RQMw/BVTWqBE5DdOPGaVAlIWC/tEPhN/eibaQHL4VXxkd2AP0ZWQqR9LD5WMwO8Q0bss0L5UmeQ0LtR0p8x6Jkb8UYTkiexnc0rA/sE08ApMwlFXvaK/W2jFtOomjbJQJR0X4BYKtLApxAUnohRkd6QXqugST0TWcByF6XoTbCcoTpSkn+H+sXD400+NhzswXGc6ZFkxDocSrys0e/k5M85LNzeQi3uio9oFRCt/PpvLDM8vVkDxH0UFL8NEtYnCzu66PsWOuZer1Haibn7r7YVys1k+cntkT3RGMi4pzQxJEgcsUszbg3Q6Ya1sJtud3Wq0/Viu7HDFaUd1UQMdhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 17:47:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 17:47:53 +0000
Date: Sun, 10 May 2026 19:47:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1-fixes] sched_ext: Fix
 sched_ext_dead() races with task initialization
Message-ID: <agDEwkQ-dfQXtGYr@gpd4>
References: <20260510074113.2049514-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510074113.2049514-1-tj@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B7C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40f) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 823c1d33-b0e7-44e6-cb38-08deaebc42e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YibK+iy3KPRzN44yW8M4ZFe7zjIi/pxhu8c+RNNQfjTE2xzyWwYRlhx2SsMz1ne8dR9mleSWTcztL64StV3+uBmKFDiypIzYK8M+7dL4J/Hh1NPgP3SURBv8rWVxQ46Adg9h+HadoBeXEajySfmwal3hNuAUWn1eNo4pYPQ5KXYEfWkWEVLDDu3XjwOZjk+bdkpTqArlQqcbJf04WiBG0/cCj5NuPquAJlVRdGSDF74uXHbjyptyuwsJi5x2GUd1A7WBYPsCxSykb9+LBXDR9DF9caSL/MABd2fGFXIdrQ8kKE987CoZolfM3CvDBd5tNlMY5aD2hAlTbspRppAuxL23pG7aw6yvs2liRiAYATkbPL/8cZcwTeCVB5K0ujrYAx7CCPMfAN8ieUHo+OzMJgM+zpaUPUslkVlO9QGhROUTvseR+w2lHDSuUvK7lSw3tw08Khd8qigrecol8N349BZbcKFgy+l8wtsv17nOhB+gloVwAiEAzUoSJlxfoat52+uQWDn1Bu2U/QRtUFpPCQ1Nn87jMegsMdPQy2onIoMmi3m2AdKKauB+1whcL8tZPSmiYM+u96l4a9kSiTBP38sd6Z6x1d4P4rMGLYZNSxMgmhs0jNJiRK+1BE8QDtxVJVLcB9YMSfBoOrUN1RjYIwdQoDnjXY125B1X7eeQlELz5zRiH28t4c7vTH+kgCHV3ITCuy5cYHkJiqRXj5ri2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+lSO++G/vQS+8mwZIRLMZReTs/Z/2U9El+2mLlMfTfuM4d6kSCQJFv72maG?=
 =?us-ascii?Q?FWv9lX2VwkO0OTIUwJpE8ZiBGah5evA2UIQGNJVHqJO5xC72viZjKD6XrsdX?=
 =?us-ascii?Q?/om5UMElistXPIu6858XGnWtQv+EjGNzsdrMCknB/1uaxs1PjXqwu+MMrVD5?=
 =?us-ascii?Q?y2vegvnVzi8BM+by0BPv5AAgnGZTNApZxpoMS4Idc+3AIKQzgHBtISnzVO0/?=
 =?us-ascii?Q?k0eYd9lN+U7ukra/22OaHSA67Ai+0Jkv92qyh7UhkZKE/K+E4dDMk3Jsxxhq?=
 =?us-ascii?Q?tYQ8eVopDVeDPrAGnHnUHtTZxSXGiPEQ2WFLFR9soD6go2mJYF7EvhnHOCUh?=
 =?us-ascii?Q?kVSjNcWeA0HtRvMPLvD65vg6FjlMXdKWXDvGdmNTx7DtDCpWUk7mLYHuU7HC?=
 =?us-ascii?Q?Z8ubhoFPORzIrd5w1jMH04mnObSvkGzBLwdL63E/wO4D89gw5QQgY4Azt5Zd?=
 =?us-ascii?Q?RDY07qAMnH2gkz6FHz8LNq8/W+2GJr09SxkVBZVfxMYPxsAuIab05b48dlIg?=
 =?us-ascii?Q?zibuN+WqR219hA5gsmiqzYgXDnkxHmG975RnxPrTqFZpjhjJKzmTRul+/7Fb?=
 =?us-ascii?Q?LX+9EWRwf9e6DX3QQzreChfLy2F5Wb/YZGytJtvXCLTiB5zCW3yFIClMPEvj?=
 =?us-ascii?Q?5ceFYGYd/d3QdMMhMzDfi0MIUNWEiluE07/nldXdIgjPtFltPecjnNTOT714?=
 =?us-ascii?Q?LDms1h9Q9+vCaBplHA5U+3h8q89UAygMX1wk2gWfOTqG67F8gJvLMGb4YkzP?=
 =?us-ascii?Q?S9/V2ntPjMIfCuE//pSV2TP5FwihigDFoi21ML8bXR6u3oDkZO8I9npUuTNO?=
 =?us-ascii?Q?zjThrScREUFjWVJT8jBs41DPKaLE0pSs0ouiELXfRBqUAzAX+U1xJEzKXSAn?=
 =?us-ascii?Q?2Za98a2JpYumtFka2MD4sFFWohI8qwaoFXdWugAAseEMuc4Mjeol+OgmRCZ/?=
 =?us-ascii?Q?auVXUbn1xaW6ihRVxq78kpOOX9R87fTkwaC8J2UQzcqREBfdS7R2AjLvQude?=
 =?us-ascii?Q?bMEXK4rFDhb7ZYt58dZYQ3TYug9/62Zm3JiIzwBobZKWSounxYgRQGD+NWZj?=
 =?us-ascii?Q?GTzE8YM6q/Hh7dTT3UOhycaY5rAQhukjIeRnempzPGuwPkOmwZ49IseQ7PoQ?=
 =?us-ascii?Q?aHYrkQwBjnJ3BiIGOaj0ImO017RpOGJmaX3EcO/EzrB9qd24sGAdDur4kkfn?=
 =?us-ascii?Q?g3t8mDSpZwUYZ/Gs4gYAHc0qQRmx+xzCmyDD8jVFQdh/5Ba+NBs7iol1ZK9d?=
 =?us-ascii?Q?fSWGwXWOjdA/NPkMm5aLfGJdpmqdHBRYsw6WlM5I8+OH9bcEWU/YdQB6dlg3?=
 =?us-ascii?Q?n1RU5AQez7CrBtCSDavOw0P432Mmk2Q34mnRtsrdSnJSKzubmBLwOfLBMg3S?=
 =?us-ascii?Q?uQ2kne3e9q74vToUguGh+IqkmZho1u1G3lkH0uuYdomMQD7DPY6AkCPAb+AH?=
 =?us-ascii?Q?8YwDPOxEV1FA2V68Mlyyblqsf5egop/p/QPGYawWf3qYEhCLSbJt78ECKPSW?=
 =?us-ascii?Q?5PUH2t9bFPLCIXr6K5AyCSjf02gRIi7pM6N0agN7gx/ogDxRXspxoZXg+QYH?=
 =?us-ascii?Q?gr0Xk8Q4WFIO9iTp8C2mUas02dv4o1HSc672grBnQRxbihdOCQefzU21iKdv?=
 =?us-ascii?Q?igV/S4I+d7n0J43BLWq27QSFZYWEB1m7cBhOqm/LGRaxBcbH2+9kstYIW7UK?=
 =?us-ascii?Q?Xrkvy/wPMu9Li7tKrR62IKeGi8FwOYDrdlUZLkdntlSNDvsyOkND1WicTn+K?=
 =?us-ascii?Q?fxBzp3IxDQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823c1d33-b0e7-44e6-cb38-08deaebc42e1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 17:47:53.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6qzaBwkC/HMCWQZYgGUrwXCtQqiIY+XfkmTjECDFYTFgMGsh8v67p+n6nXQNqEnUKZ4HUIZpKMHuesgban5VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550

Hi Tejun,

On Sat, May 09, 2026 at 09:41:07PM -1000, Tejun Heo wrote:
> Hello,
> 
> zhidao su reported a NULL deref and an ops.init_task() leak when
> sched_ext_dead() races scx_root_enable_workfn() in CONFIG_EXT_SUB_SCHED
> kernels [1]. The same race window also affects the analogous sub-sched paths
> (scx_sub_enable_workfn()'s per-task init pass and scx_sub_disable()'s
> migration loop), and the wrapper-disable paths trip on the NONE state that
> scx_fail_parent() leaves behind. Closing all of these calls for a
> state-machine extension rather than a localized fix.
> 
> The series introduces SCX_TASK_INIT_BEGIN as an explicit intermediate state
> between NONE and INIT, and replaces the SCX_TASK_OFF_TASKS marker flag with
> a real SCX_TASK_DEAD terminal state. With the state machine in place, every
> init path uses the same handshake: write INIT_BEGIN under rq lock, init
> outside the lock, recheck DEAD under rq lock, unwind via
> scx_sub_init_cancel_task() on hit. The wrapper-disable and
> switched_from_scx() paths get NONE early-returns to handle the
> scx_fail_parent() residue.
> 
> It is more invasive than zhidao's patches but covers the related races
> uniformly and avoids the implicit list_empty() check his approach relies
> on. Credit to him for finding and reporting the bug.
> 
>  0001 sched_ext: Cleanups in preparation for the SCX_TASK_INIT_BEGIN/DEAD work
>  0002 sched_ext: Inline scx_init_task() and move RESET_RUNNABLE_AT into scx_set_task_state()
>  0003 sched_ext: Replace SCX_TASK_OFF_TASKS flag with SCX_TASK_DEAD state
>  0004 sched_ext: Close root-enable vs sched_ext_dead() race with SCX_TASK_INIT_BEGIN
>  0005 sched_ext: Close sub-sched init race with post-init DEAD recheck
>  0006 sched_ext: Handle SCX_TASK_NONE in disable/switched_from paths

Apart than a small comment about PATCH 2/6, I haven't found any issues with this
series. Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Based on sched_ext/for-7.1-fixes (ab28a0673daa).
> 
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git for-7.1-fixes-dead-race
> 
> Verified with a debug patch that widens the unlocked init windows on the
> root and sub-sched paths and counts post-init DEAD-recheck hits.
> Reproducers exercise each of the original races plus the scx_fail_parent
> NONE-state regression, followed by a multi-iteration stress under fork
> churn. Counters show the windows are hit and no
> BUG/WARNING/Oops/Invalid-task-state appears.
> 
> [1] https://lore.kernel.org/all/20260429133155.3825247-1-suzhidao@xiaomi.com/
> 
>  include/linux/sched/ext.h |  17 ++--
>  kernel/sched/ext.c        | 221 +++++++++++++++++++++++++++++++---------------
>  2 files changed, 162 insertions(+), 76 deletions(-)
> 
> Thanks.
> 
> --
> tejun
