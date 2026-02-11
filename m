Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC63327C0D
	for <sched-ext@lists.linux.dev>; Wed, 11 Feb 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825991; cv=fail; b=FeLVo0RJBSFqy7HMyX/sCIXVAQmaz8QmnKqe3Eb9mYg9m8AK7Ge4pVw+07sF9cjyWhrm1uMBHjK4z98ZTefwrKbxNyPgVuDpbU87zfipfO0/R/kUflOP3MYOqIBj7L4E21INRF4xay5MFk5gDLvz6y+EFMCPJucW/aXd36sgyW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825991; c=relaxed/simple;
	bh=F2vt2NKPH5nOyI2C7KvYeHNDTBSvjTzcueCyo//+2Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fyuyaogWXcezHOgr01Ks3JaqEW+okmUPIG1oQwYl6deoSEgqAsuuz7sxwuUu1Yk45GlAxoG5cPqnpbUsKmYvS49ESU3teM4UlbDJvtwatxCvmltjfjjqCpAiuUSa2NNM+qv2nJLpLr4n0VqNX9hZ8HOFihjCbOsE5pZe2uJpym4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mTyhjval; arc=fail smtp.client-ip=52.101.48.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mTyhjval"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT9CCxpam2wbGAR9mWTaNdm6U/x6ngVoHvUxcyythGXuPA2Z/kYEFlpyCeLBBVAdX9Fp653ch1fgLzvXKX+wg6ocqJoYei5Q7M/3OjGQhEXNs7elutJ7wLbqcKOv/F1DplUcx4wLZ2amOFGcHbiWmw3irAyGpVH2tcoIRLLUfYdlotoDDEHmBTCg1hKpSe5aBv5ovuqT6yWv29puecU1SlEZchw869rBJ1ZoEGLczH7a41g0ayjyRxVPUY/dKuPH7dMrpPP38fgt7iwCSFiGc+YaiK/Z1kyharwtThivU2JUUT4UKCNTkniYwIZv1B3oNiwzLMjop/wN/0IIQq5+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtDY4PQANbmeABh5pmMKoZwhtVxtzzO03RKBc7C6jUY=;
 b=g2SDQlfPc3BzSWwbXBm+mj8LljRrVEzTq7WE9QJm0UocRzFvK/TrqgpBtvUfOA11UtIYA4FU/WZcT3NLsTPy2XR2/M+ToNBZ5TOu6sLdnck5vstmuaou0zfrOZjWH7UneoJLuRm6ZGKSCu/QmWDER736dhJQu8Ncn8fmeD2tT2rKRMKzJUh0GaqR3sxrxQPESSiewgz1ec0RZb2vOFy6OUvprvsiCuTuRhNCHvmwu6q7q5THiMic3P2sKvWD9BkvKLwkaEPjvlMdy1t+dVwOaHTbhvMHCqv+Mc67LwHvy7BHA1iz5gv6UVD43jxQ6fv3QyTJ2QacGdesmEyTF2eoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtDY4PQANbmeABh5pmMKoZwhtVxtzzO03RKBc7C6jUY=;
 b=mTyhjval88tJToI2mFvqIQ9ZrI8jru900VJXTuDFqvQ8OUsEENUJ1Ml1qlKoeqOnkYoNcrU7h/DCsKZmibRHBOLW0kHuD+6XLAYezH0iy5VoGYnOzuYl2Yjs3MqpADO3RW4e6ybLtmoGoP+yFttTAb9JZPI7EkyN9b8rjnCZyRAFVnTyOKP6NmtDme/dLlvF1L0O6wo8g9id7sLTx5mLaBFWoUqMtAV9f8wnNYT/sX0HL5IRWJOPzHMlVqrjRaiVwJG/EoAzeMSPDgHuAf5rC8JBLUQuJKy/tRbpzHb8CtJhyd2icOh2MbIYaJ7cG/CGez1Col2iEDSsmwtcjLoOMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 16:06:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 16:06:25 +0000
Date: Wed, 11 Feb 2026 17:06:20 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYyo_ALV_BT6WaE0@gpd4>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
 <aYu9KzKTMfNIFDwD@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYu9KzKTMfNIFDwD@slm.duckdns.org>
X-ClientProxiedBy: ZR0P278CA0112.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: b309c0eb-6909-4fd7-cdb7-08de69878160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NRJlX2z0lSnc9HhWkE3xstTdJcPKm5MAXFCNlJfBtrwTjdBevVLUoEVyid6U?=
 =?us-ascii?Q?he0LdxNhg51egWUf6uu8y4VI+ga+sXmsKryzDHbd5z+XH4gB0ha5pBC4JSMm?=
 =?us-ascii?Q?n/IqAg5h9MqS2MreVaSafPIMOKRI4yMzy0suFZkDwS+R1qmXNVCMHQ+0rp4T?=
 =?us-ascii?Q?Q/CxawHnvB8Nf9bin4lZZONcpHr521aT/lUvXUGIPgRau/lcPN7jPd6Y7Tor?=
 =?us-ascii?Q?5dBxJoOc64FCMlIVCTwDixGXGbVtkLiVFybsgv8Na4c/mEZmmx/FBOana8dF?=
 =?us-ascii?Q?UUdBFEIEGOIDflW5E1Wv9IqQW8nfdFQxxN2douB/iejN05P0TW0do5hv6UR8?=
 =?us-ascii?Q?cwYavf8MlQeFxpJ4x402u5/h814kgy1m4f+Ns4NoJjGpDBDHkmP7Eb0ZUfCG?=
 =?us-ascii?Q?AHGEsPemDO3uHczil29ROaPcsz6rkQhN+05X7UNggdKf3N7yuE+wQU04fpe5?=
 =?us-ascii?Q?tIia7a2VfLHnEieY+cSWW5+rtMhDou5Bpizkgy+GHD4Hy1ByX97XWmGcPKmq?=
 =?us-ascii?Q?Nk+bHRxNBl1FDhfRCFiW2PvtQ4rzbhjmXDUqPTMQOVv5lQz2qfOUu2FqdhEC?=
 =?us-ascii?Q?DkR3E7uq288m/sav9vY37ficGgd7QYe9ydy09DKU6W6Ix06NZDqx74rneOSF?=
 =?us-ascii?Q?6YKFKXAjvbWQZuv4/AwHEaOeJAw9kjfTBWAF26ZHLnFCsLOtbkaX87ogq/MU?=
 =?us-ascii?Q?2UcpN91vsDYwS3VA7zNAoU/PFrcHwHPv1c1JQ7AT+Yk75omHnJ2KNHrE1r6o?=
 =?us-ascii?Q?zflYjTXQKEL9+7bjP9FCPvj1CQkEy7LOWS6M/FwvSyhf4ACAgrRXO+h4Ntvh?=
 =?us-ascii?Q?SEfCtJmyEOUj0UirTwfD1cOZ+h7vqdAPy51qSeibSEZHjVMISEqIDFUOKweX?=
 =?us-ascii?Q?XZhaQMam5P3xgrzPzW5dvnjKpMgGlaKwiYiZsEu9mi7O8xKfqBdiz45r73t5?=
 =?us-ascii?Q?K6zjg8T7j/HYFotidPtY4TtZtforCfib7FhNHpn90+9ln3XcvcPhQ6vWt2N+?=
 =?us-ascii?Q?YHt+o+KtXnctTXZq30JHe6RiKyxc9FZppxdARZrg5KBdG/gN0UkLFJzUa8mh?=
 =?us-ascii?Q?wnHauWhOXwgkk/7s6Oe5rO3q6ykglXD3ndGdUjYPp90HdveYfIC36oHy/zge?=
 =?us-ascii?Q?FtQIPtZ3TjM77YCUFXrwwyneRU9hARNCYwPVuVdpIRUbS7F7e5Gxm4ssn8fU?=
 =?us-ascii?Q?iKaxsJ5y+zh2c3Pi8wD5E8FpgH5oRoXivX5tD+mHcEYz7NQ8ZADKZhx6W/gz?=
 =?us-ascii?Q?UKm+sXtFT0HqV6IsWziQMiEfC8O52tENal3F6ULcvrOvDoJRR2dRtd3NeWh1?=
 =?us-ascii?Q?LAk8/wBAdP7QLMhd/MlX7ZZIUU90vl8h0dqbDI5GefgxFrNpIiO9BH0sWtlF?=
 =?us-ascii?Q?nG0SPy3sVb/+KezQrerWkfLdOffevFN2JgT7Qw3gEmOhRgjFDAIALcbJB7Cs?=
 =?us-ascii?Q?GYEAPw5FwSX/SjzAPJ6Eo+HCUnryZdq7Pb+1gEXjGFv2INNYPmjsQKHG392B?=
 =?us-ascii?Q?udEWa7kDvlwnhhypT9lha6/Z0EOVKMjwX+6sF8X6/CMuQCICiDVfCZdWqZAV?=
 =?us-ascii?Q?maCBjZYBaHoSB3KcRBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f4cEwy6X+DDQRt0wZ+G02nuQzzvR51gB4Isq0+XI5iIbx/kEyoAld8aUOQHE?=
 =?us-ascii?Q?oQJ4vWnhwMoGaWu6r8bIQntcsf0Fqv+V1RoplIbH486Tw/69kEqfaGHN7j4U?=
 =?us-ascii?Q?RTkAdAKbjhfzM9l6I3psKQ5RAyrlDf5KcpryEBoJ2bLBP8EBmz+ihKLBf8wY?=
 =?us-ascii?Q?akD2LXnHt1usF1mIsowbq8NX4812FpcM9+FzQhvYgsd+Z8PV55yTGvm0lqKH?=
 =?us-ascii?Q?ThgqIeoBUD2wteaMXQSWXkyl2Ba2vCQze09ONgtl25Uqk9uqnBwOKSzfxtQS?=
 =?us-ascii?Q?MQ0oCaVLlidXkO7Od1rMFtBgEmV/bkrtQWR1h2kFkfxKDxMnTZG0IUOT1Hf2?=
 =?us-ascii?Q?qYlNj2Y6cSeJGPAfpuUFKsZ/vegxgDiAjfNKJnFEOIrzPE9gqRHC2l9CzCeA?=
 =?us-ascii?Q?Yv8P/Pg/AGkXOuxzxpSBsZh3YpYmAnyo2JV5ZBeJErcFcZx+poHrAcNPjSJx?=
 =?us-ascii?Q?UfaQ+c6pm22XGB6zzXPxqwBrNZxtw6G3MzpXah39GHKQnGE/eDgYo+q9IHwo?=
 =?us-ascii?Q?eN3VwRR2G84RlrJ3qjtZfmRb0Zy6OAiQs1YuOdSQ5iE6QRLhIG7jLAjwk41o?=
 =?us-ascii?Q?tqTojP01/4Q6iaK/RT0toY7o26op9wCCadc/QuoN/yp2eJpRv2OS8kozQzby?=
 =?us-ascii?Q?5FOKnHeLaJBsRdMyHbdi3wKdjsatacp1gOj3BGTEywNfmucB9v/zME2Lh/qu?=
 =?us-ascii?Q?j9x+6tpjefaXLQrgiNmLJEDqzUJhuNAjQtt0176xsiMG+s2e5eWJHgtZDo/A?=
 =?us-ascii?Q?XQHbNc8/uCdef5mfivFgiP5jtyjBRHVvkgBZU30+wqDSnccbQCZu0yYgAnAt?=
 =?us-ascii?Q?EjUSGjvbxvq6Vs4bt+iFh4ZaAKfetyck9iXTqiHWbqXAcS+kKyk1J08joQ1D?=
 =?us-ascii?Q?dTiTKG2GlAhv2fv4cSTEMf0fh4nJ2WydBprDYPM7QvIy35A1RfTUSEbdlmib?=
 =?us-ascii?Q?sA9Xj91aJjRBr9zdOabbobRAQLRoDv4kxkHBXVYjRiXuDNLB8OWv4v/XgLSL?=
 =?us-ascii?Q?N+x/BTcTWzLs66T2oZUfPt3A8jue225Kqypl7x+z2jT9diV5e+2kpMxGBvnT?=
 =?us-ascii?Q?vpq7ptp32q3kSc7flM7GS8Fm78dQDfeUa4+JRIQFt6L0U7tx5YPylPT950Rl?=
 =?us-ascii?Q?hmpxHZqRzu2drJrOh7NS+vSLiZC/dz4tYG4dkaFVu7qsJFPsESKHVujTH/mM?=
 =?us-ascii?Q?AxQWFwe4iN0w3+OISP8PnwoXg0dEntAvVJ4SS4wr0myNMtTTIPh6Ou7xT/LG?=
 =?us-ascii?Q?fkAUeyYlbgQ6elRPo3V6GZe+dExCU6nbuN9tCBSPQnV168ROxurDmTmwv6HP?=
 =?us-ascii?Q?m3A+0OWkf3+6GQs/0Hw6rjt1M6AyibtWU2mv7y/C7Hiv0T9xA++So2G3Mw1a?=
 =?us-ascii?Q?Q6ar8Y5JZS+FDLjMOj+Bds7ILcMuEdAjyVMuzup5+mZiNlBSLvaXUuzkGlhl?=
 =?us-ascii?Q?7psqimHntuKVt722N+CRp3XmCy0XP5Vn8HnzbvsVJI6NIvpsy2aVgIwnzVq5?=
 =?us-ascii?Q?P9e+YbMTdA9yEEDpvdOVDZ4tOSz0Evb/U2VJFC0heAeGzEjesXz6CUH8eMK4?=
 =?us-ascii?Q?cDRn9awao6h54DLRQbv3fgQxCRQLReVvualpX3CmnEUUDCufOjdQ+JH623Ey?=
 =?us-ascii?Q?JSQuKiV4JI6JpdV0Sb0WRoiYrISrO8ndtcqH4kbg/mA77NmAT6Yo41fUYyvC?=
 =?us-ascii?Q?7LNYcAeNvb5lNeUoE0lIa/Q+qxzKp/U8YRYnHyvO034p8+xF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b309c0eb-6909-4fd7-cdb7-08de69878160
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:06:24.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWVSFelBfQy7PvvGSRP0C6tQliupLvp8UrO5FxDV7TqiZ5EP42RVZEt5ZoVGw/PsIMemDK8VmWhq1pdISuEDtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

Hi Tejun,

On Tue, Feb 10, 2026 at 01:20:11PM -1000, Tejun Heo wrote:
> On Tue, Feb 10, 2026 at 10:26:04PM +0100, Andrea Righi wrote:
> > +/**
> > + * is_terminal_dsq - Check if a DSQ is terminal for ops.dequeue() purposes
> > + * @dsq_id: DSQ ID to check
> > + *
> > + * Returns true if @dsq_id is a terminal/builtin DSQ where the BPF
> > + * scheduler is considered "done" with the task.
> > + *
> > + * Builtin DSQs include:
> > + *  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
> > + *    where tasks go directly to execution,
> > + *  - Global DSQ (%SCX_DSQ_GLOBAL): built-in fallback queue,
> > + *  - Bypass DSQ: used during bypass mode.
> > + *
> > + * Tasks dispatched to builtin DSQs exit BPF scheduler custody and do not
> > + * trigger ops.dequeue() when they are later consumed.
> > + */
> > +static inline bool is_terminal_dsq(u64 dsq_id)
> > +{
> > +	return dsq_id & SCX_DSQ_FLAG_BUILTIN && dsq_id != SCX_DSQ_INVALID;
> > +}
> 
> Please use () do clarify ordering between & and &&. It's just visually
> confusing. I wonder whether it'd be cleaner to make it take @dsq instead of
> @dsq_id and then it can just do:
> 
>         return dsq->id == SCX_DSQ_LOCAL || dsq->id == SCX_DSQ_GLOBAL;
> 
> because SCX_DSQ_LOCAL_ON is only used as the designator not as actual DSQ
> id, and the above code positively identifies what's terminal.

Ok, but we also need to include SCX_DSQ_BYPASS, in that case maybe checking
SCX_DSQ_FLAG_BUILTIN is more generic?

> 
> > -static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> > +static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
> > +			     struct scx_dispatch_q *dsq,
> >  			     struct task_struct *p, u64 enq_flags)
> 
> While minor, this patch would be easier to read if the @rq addition were
> done in a separate patch.

Ack. I'll split that out.

> 
> > +static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
> > +			      struct task_struct *p, u64 deq_flags,
> > +			      bool is_sched_change)
> 
> Isn't @is_sched_change a bit of misnomer given that it needs to exclude
> SCX_DEQ_CORE_SCHED_EXEC. I wonder whether it'd be easier if @deq_flags
> handling is separated out. This part is ops_dequeue() specific, right?
> Everyone else statically knows what DEQ flags to use. That might make
> ops_dequeue() calculate flags unnecessarily but ops_dequeue() is not
> particularly hot, so I don't think that'd matter.

Ack, I'll handle deq_flags in ops_dequeue() and simplify
call_task_dequeue() accordingly.

> 
> > +{
> > +	if (SCX_HAS_OP(sch, dequeue)) {
> > +		/*
> > +		 * Set %SCX_DEQ_SCHED_CHANGE when the dequeue is due to a
> > +		 * property change (not sleep or core-sched pick).
> > +		 */
> > +		if (is_sched_change &&
> > +		    !(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> > +			deq_flags |= SCX_DEQ_SCHED_CHANGE;
> > +
> > +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, deq_flags);
> > +	}
> > +	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> 
> Let's move flag clearing to the call sites. It's a bit confusing w/ the
> function name.

Ack.

> 
> >  static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  {
> >  	struct scx_sched *sch = scx_root;
> > @@ -1524,6 +1590,12 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  
> >  	switch (opss & SCX_OPSS_STATE_MASK) {
> >  	case SCX_OPSS_NONE:
> > +		/*
> > +		 * If the task is still in BPF scheduler's custody
> > +		 * (%SCX_TASK_IN_CUSTODY is set) call ops.dequeue().
> > +		 */
> > +		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> > +			call_task_dequeue(sch, rq, p, deq_flags, true);
> 
> Hmm... why is this path necessary? Shouldn't the one that cleared OPSS be
> responsible for clearing IN_CUSTODY too?

The path that clears OPSS to NONE doesn't always clear IN_CUSTODY: in
dispatch_to_local_dsq(), when we're moving a task that was in DISPATCHING
to a remote CPU's local DSQ, we only set ops_state to NONE, so a concurrent
dequeue can proceed, but we only clear IN_CUSTODY when we later enqueue or
move the task. So we can see NONE + IN_CUSTODY here and need to handle it.
And we can't clear IN_CUSTODY at the same time we set NONE there, because
we don't hold the task's rq lock yet and we can't trigger ops.dequeue().

> 
> > @@ -1631,6 +1706,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
> >  					 struct scx_dispatch_q *src_dsq,
> >  					 struct rq *dst_rq)
> >  {
> > +	struct scx_sched *sch = scx_root;
> >  	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
> >  
> >  	/* @dsq is locked and @p is on @dst_rq */
> > @@ -1639,6 +1715,16 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
> >  
> >  	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> >  
> > +	/*
> > +	 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
> > +	 * Call ops.dequeue() if the task was in BPF custody.
> > +	 */
> > +	if (p->scx.flags & SCX_TASK_IN_CUSTODY) {
> > +		if (SCX_HAS_OP(sch, dequeue))
> > +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
> > +		p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> > +	}
> 
> I think a better place to put this would be inside local_dsq_post_enq() so
> that dispatch_enqueue() and move_local_task_to_local_dsq() can share the
> path. This would mean breaking out local and global cases in
> dispatch_enqueue(). ie. at the end of dispatch_enqueue():
> 
>         if (is_local) {
>                 local_dsq_post_enq(...);
>         } else {
>                 if (dsq->id == SCX_DSQ_GLOBAL)
>                         global_dsq_post_enq(...);       /* or open code with comment */
>                 raw_spin_unlock(&dsq->lock);
>         }

Agreed, I'll move this into local_dsq_post_enq() and introduce
a global_dsq_post_enq().

> 
> > @@ -1801,12 +1887,19 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
> >  		!WARN_ON_ONCE(src_rq != task_rq(p));
> >  }
> >  
> > -static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
> > -				struct scx_dispatch_q *dsq, struct rq *src_rq)
> > +static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
> > +			       struct task_struct *p,
> > +			       struct scx_dispatch_q *dsq, struct rq *src_rq)
> >  {
> >  	raw_spin_rq_unlock(this_rq);
> >  
> >  	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
> > +		/*
> > +		 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
> > +		 * Call ops.dequeue() if the task was in BPF custody.
> > +		 */
> > +		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> > +			call_task_dequeue(sch, src_rq, p, 0, false);
> 
> and this shouldn't be necessary. move_remote_task_to_local_dsq() deactivates
> and reactivates the task. The deactivation invokes ops_dequeue() but that
> should suppress dequeue invocation as that's internal transfer (this is
> discernable from p->on_rq being set to TASK_ON_RQ_MIGRATING) and when it
> gets enqueued on the target CPU, dispatch_enqueue() on the local DSQ should
> trigger dequeue invocation, right?

Should we trigger ops.dequeue() when the task is dequeued inside
move_remote_task_to_local_dsq() (in ops_dequeue() on the path triggered by
deactivate_task() there) instead of suppressing it and invoking on the
target in local_dsq_post_enq()?

That way the BPF sees dequeue on the source and then enqueue on the target,
we avoid special-casing SCX_TASK_IN_CUSTODY in do_enqueue_task() and the
"when to call dequeue" logic stays consistent in ops_dequeue and the
terminal local/global post_enq paths.

Does it make sense or would you rather suppress it and only invoke on the
target when the task lands on the local DSQ??

> 
> > @@ -1867,6 +1960,13 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> >  						     src_dsq, dst_rq);
> >  			raw_spin_unlock(&src_dsq->lock);
> >  		} else {
> > +			/*
> > +			 * Moving to a local DSQ, dispatch_enqueue() is not
> > +			 * used, so call ops.dequeue() here if the task was
> > +			 * in BPF scheduler's custody.
> > +			 */
> > +			if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> > +				call_task_dequeue(sch, src_rq, p, 0, false);
> 
> and then this becomes unnecessary too.

Ack + same comment about consume_remote_task().

> 
> > @@ -2014,9 +2114,16 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
> >  		 */
> >  		if (src_rq == dst_rq) {
> >  			p->scx.holding_cpu = -1;
> > -			dispatch_enqueue(sch, &dst_rq->scx.local_dsq, p,
> > +			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
> >  					 enq_flags);
> >  		} else {
> > +			/*
> > +			 * Moving to a local DSQ, dispatch_enqueue() is not
> > +			 * used, so call ops.dequeue() here if the task was
> > +			 * in BPF scheduler's custody.
> > +			 */
> > +			if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> > +				call_task_dequeue(sch, src_rq, p, 0, false);
> 
> ditto.

Ack + same as above.

Thanks,
-Andrea
