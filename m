Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3903750A3
	for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400339; cv=fail; b=CdhXCWiH3vL6ot56RL15JuDgO49IJWBCeW44B2GLSaXaEo4KqR5wUM/uYPmlKrX7r4/uaaxQhpkF5Lx9++o2qxn4ZZ42AlWAalLE+oe8FPg7Js8a/Tpp3TWe+xdcGT16uIz5HeVbdpDoD5wSL9XGIzbpfFkBHSxtCOCB2AFIkFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400339; c=relaxed/simple;
	bh=A7pUUIL9N019GMLHkP1udpKnJ/lpK9vPQ++84fyZhVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q1SYihkTBAcDyHE+kScanJIjCXBRNmVSuz6ItFowTH6ATBBwou3oQxI8RDpqyoHEcGTTDVZkX0XHZnIGjlZtP2JjgNbUs+gu3YXiiVKbAyb+bN2rum4RB+65J2vCQM0/RpOGmpYRG+lZKRg46Sccton2C2dPiUA2UEOHRZO7bLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d+h5mqHi; arc=fail smtp.client-ip=52.101.53.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d+h5mqHi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EriW3livmv7j1vaIb4XJmm3Wn7E2xX5GHpTPRx2Xjsm6YmUtPpjR8bAIjMdWfPJTgsQaBCxlwwh0r37Ekdh+OKU3fZ8bDKOJnjmLY1W4eCHTK+/bvry6/TWerJ8PY9Xkima/YmpfaMaq4wOjMkdx0fIY1Xt4EU4+8GpyKiFtqpL8WB0A7BCGdrT3YXxR/muigl2qbx9LcH80QN4nBrdXWnYg4r9kd1L1FV9F4hmEgn1yp+J/AWG9G1QGhaO94s6egm50oR/Gi5KAHRGYCn//M9Sj6B2rpb9WykfwfzFqSf6hqSvJdOPo8rrsgR1Rna18nJB27pIRn+l0KnDeKvBqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCmteThpsrhC4N7kXT+U7idYHqF5kqLmMaK4Es+6Y/0=;
 b=YvXlu0EC9GofXtUbMg+Wf6/5vSzodPluoBEdECBpoS/aUj3ZrqOLvuXNkXD8Ptqqv59uUSANzD/syxOFaP1MEc+wo/jD05uIFlNfzmfdBWj0SA2Vb7w3/33I3tAZkSdpgeRcg/Y0gamfqNSsFBihmZwZ3EKb5apeOR0GEVZ9kbtO5eWnkaKpL9xauiBZFMyRu9Ge71X5KBbZjZ83gpGPIUUYJd++VBDyJdbvXagD8T1mkgX35aD43xvn0yyxBkNYORy8TUBPq735tH8jFrE+Lrjiw/5Y3H3xySljvqLov3N4ovO8glQKQU+102G/P7OrVpkw2PsksHl2SVcelkbp/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCmteThpsrhC4N7kXT+U7idYHqF5kqLmMaK4Es+6Y/0=;
 b=d+h5mqHiqPmrsXDN5Mr6CfEHOwATax6rp24DpGMnpYLWw+M2ZtoykXrMk1ral0kM6HnaRETpYpRJMSzYQedZj+ecJNTNy+XZ797oPLXUz5lTnXeO6rjjwHBdNh/qBTR1+R8NKaGvkshObpeuL8nHZ+RmsVGpBQgxx4Sj+UemZ/t5zlwKADtXWN6u+ylwoh+kxcaDW4VBtgp0Ti/MYhU5I7KhHi/djzBS7vhqf53UfCa84sMdBDd9C8bKAGrhAECNvKgOxkeyDLjqgCe4P420qbJq3XhRwn9FUqOOaY19b9hqwo4mXGE8ENOWs8Vjp2EfVdZfKw/v8TZ+KG+kCmMvew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 11:12:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 11:12:13 +0000
Date: Fri, 13 Mar 2026 12:11:59 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Implement SCX_ENQ_IMMED
Message-ID: <abPw_1OSCnQFNhcC@gpd4>
References: <20260307002817.1298341-1-tj@kernel.org>
 <20260307002817.1298341-3-tj@kernel.org>
 <aa8E6WauTRALRCqs@gpd4>
 <abPpromdlJNm8DGd@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abPpromdlJNm8DGd@slm.duckdns.org>
X-ClientProxiedBy: ZR0P278CA0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5785ff-2857-488b-ea05-08de80f16090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8mQAY+tSvvfib+w9eXk+c+IIKJkrHYWnkerAwyswbGXmMJWi2QoWaDypMZ3DhVeEDOZqgg8m3lydAqebBHRTHtX9tCfPMM1z18IlKzGu6bnLjb29608TEV0A2U/AElLmNjBNvDVjU2X/AULKBqc76hdNFt6E/FdIX+4x2kZcM+Ebwg1gGjuW2/Ou4t+zf1pqES+0mi6x5ykB/Xo7xcm3vX2c/SjSdlH1F+fvUSl8NGR6E4e4ylHBe1wzWc4a+UsXDBroNIGMTFjTPMC0/SZy6YvH2gTk10dH9PIPzwVtJbQfQzHwONu9IJW8wtpz4OweaKVzIDL1ueKHPIUxVooy6Wvzjsh8+3Zv25t56507nOJNXylyLypFApQnTTXO3TM5TPf1pfkg7Ewv0bnHJKXw3AIG7rsPRLclGzTtUEmjMdANvtqSyKnFCIxRmPtfxZ+9BlO4ZbId1w/k2JeRQbGlWDe/HNTeXt5BoFz+rFawn6lAZZfGAUhno/VxNylTG2Zr7/EZuC4nqZcIyCGJGltlKkUTSrTa6xf40yVvBRQlnNhv5nhOPQGFkQWPTf4D7H51ikqbEwguBRjb61PU8jeAwcKY5gPPYYKJ7j/Dmmspb3k2KZJoVAACFG+228cMQSYzXV9zTrczJW5A2Ktr3o9BmGNLILgvtyyrKw75w0NOYzzUNk/LHsp1j2FGjcZ3ZMtuXLNI31nwJ3nHDUdiYHLC9nYi+lSDlJ/5Vf7dmt1KSTc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yeXKq36HuiH4ehxuNAUoboZqVw7WN8VVT2f9ElcqKokcExbDGRigt/9utpmW?=
 =?us-ascii?Q?VtRlNNc4CBfyaKnnDUaHWh6YIn6hGFpB3ZDpRXfYAzhqcZgg4wqSuh/R526q?=
 =?us-ascii?Q?DQPErNb062SsV4tDWEVDGfK9XyzwR2E1QnfF2Kb2F2FD39wrp4KMxoyfopr+?=
 =?us-ascii?Q?bQjqWjo5jT23GYXAgnYo1pBfVpKbzXPxsLH4TCUmP6JdjBJFv+gwWsEham5w?=
 =?us-ascii?Q?Scd9FidQXilfloaI/TpwHZ+nLZjyt4/c5kQkES/fwBe96d172my2WN0DBlwX?=
 =?us-ascii?Q?i3NwHU6Zt91l4vC1g3dpAGgPkJptn9lUKxgrXl7+ZwtOpApYWSUKyHjL94HL?=
 =?us-ascii?Q?AKDkbWqRwLQxLgj7dhupw6GI/F32CAxm0iUmqclBKPIv2dL8WuROi7ipaXy8?=
 =?us-ascii?Q?+4z1XpVUI7W9jVjGsfJghE4XaK/YgH834veJ74jFjvGKLbzotDAcSwsxlVGD?=
 =?us-ascii?Q?jK3p4USgYzLM/3/jU8weu699ImJYQzfUX6iLoGeJlpowC3YOzDbPPIAUY8w8?=
 =?us-ascii?Q?OZir6+RDVm5KU44r0K99aizCRrTImfuSpwk3AUeHR1ciYB1fK6mGqK17jixm?=
 =?us-ascii?Q?C6vYCKGvpJ/YTD3C1rxAC9A9XaboyJPe71od9gWXiX7ceCy00eP9P1rXv7eC?=
 =?us-ascii?Q?Rfonr98irIbLJV0TRczICXYk1APyATiHCfNklA1jb9oSAX4EeP1xTwpl+cpb?=
 =?us-ascii?Q?kio4OPhtuuabfR9OPy8js+GhTL9kIqpjpXo3+xah3ouMnqPdkG4yolo84yNe?=
 =?us-ascii?Q?AFSCpc0fvXnH6FnB3Af9BjPjkDBWTAxywDUXP+u9aXP3dMv/RHlATqQjHjii?=
 =?us-ascii?Q?1wU1ayXmkFFX1f5TcuJfmoz7JNBl/UkyQ0tLnZKeH8F3buwE/Xg5rKsS095C?=
 =?us-ascii?Q?kVCCmWHSfuNWwm46tByQ3cTp1oY6GlCY+aTZZoLbotfSEIh2LroMzJbYNU6I?=
 =?us-ascii?Q?KPrETwu2KkBECgRnuc0NnZ/wgi648C/xIBbBbk8RpoyvhLEsOvfQVFDeUPts?=
 =?us-ascii?Q?3wHNb6rypg4vrZATT4MBibxPOgET1BRFKBSq+JBPb2wKDMvME/TmP7VMsk6a?=
 =?us-ascii?Q?XLBQZao4RBf+ClmP7+dBPb4+b45QAnTd4B/ch1Ni+hHKKoJjl6AaLbIBoHlE?=
 =?us-ascii?Q?wzSXm/dPQktEw6QI5JQre2ad1fp2fB43vsfAIkqPzMMfb2XMvjQrQ5/YQZbu?=
 =?us-ascii?Q?qevzxuUIDRtD1ZQVR0RQ2MMa8QW965akOG0lK/FTwzF5LEOS3O+7NYurILwP?=
 =?us-ascii?Q?qO6Gtg2AFib0k4QN6oIrMcnGFiaRATOcRaGmPoRxenNLXmK00v5juZeSw5F3?=
 =?us-ascii?Q?/+SXmUwOZke1fdpU3fbGk22EE5PnOBdS2EPxIwbaJnM3iLlpftSlCvcFaOUc?=
 =?us-ascii?Q?oSWKgz4Z1RHrweZrgFMk7aovXF0xVeW8pcc3hrmeweocO/lAnUP7q282yctj?=
 =?us-ascii?Q?NRecF34uh8UMt6RJ+Hd1VmECeChwx0dtKpjrYKUXJtC7e+HV1x9vkBpzp32J?=
 =?us-ascii?Q?W9a4LaCfgnFDJzwGlk0cQzKJ6qsCYwskTUu0XSi6uGZEgh6XMrqcj0Eie2lk?=
 =?us-ascii?Q?WAYys5b6QJc2d+xofle8qUw58l4upBLC+/tMxMUrAbkz2UI+9DkrhospbVJG?=
 =?us-ascii?Q?jOfnHNlrccKMFpxPvsOavRRevF+Jdk2fahfTzKY7kTNMOtXiy9XpD6yrOyiS?=
 =?us-ascii?Q?Zdntmmwch55IP0eNh5qvYPIz8d8u0GgJnn6fyGPGv4jHHeWMKuHgPLq2hKjD?=
 =?us-ascii?Q?ktylZeg1SA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5785ff-2857-488b-ea05-08de80f16090
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:12:13.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7UvFjrLyRK9a8YFpCONxUUXnyw47Q6fUaGdKC6+tXLWhiqkX9ZvkqbBEIaLc/uA+RNuXvWEZYDajPdijTwlEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423

Hi Tejun,

On Fri, Mar 13, 2026 at 12:40:46AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 09, 2026 at 06:35:37PM +0100, Andrea Righi wrote:
> > > diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> > > index f8df73044515..cd4272117be4 100644
> > > --- a/kernel/sched/ext_internal.h
> > > +++ b/kernel/sched/ext_internal.h
> > > @@ -31,6 +31,8 @@ enum scx_consts {
> > >  	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
> > >  	SCX_BYPASS_LB_BATCH		= 256,
> > >  
> > > +	SCX_REENQ_LOCAL_MAX_REPEAT	= 256,
> > 
> > That's a lot of re-enqueues. What if we simply ignore SCX_ENQ_IMMED when
> > SCX_ENQ_REENQ is set?
> 
> It's meant to be a safety mechanism against system lockup, not a workaround
> for BPF scheduler misbehavior.
> 
> > This would solve the SCX_OPS_ALWAYS_ENQ_IMMED issue and naturally limit the
> > loop to a single retry:
> >  - first attempt (IMMED) fails -> task re-enqueued with REENQ flag,
> >  - second attempt sees REENQ -> ignores IMMED check -> queues normally on
> >    local DSQ.
> > 
> > This approach seems more robust and would avoid the latency overhead of
> > repeated failures (the re-enqueues were actually the reason of the latency
> > issues that I was experiencing). If I don't use SCX_OPS_ALWAYS_ENQ_IMMED
> > and I selectively use SCX_ENQ_IMMED with just one retry I can actually see
> > some small, but consistent, benefits with scx_cosmos running some latency
> > benchmarks.
> 
> The intention is making IMMED guarnatee immediate execution - if IMMED is
> set, the task will get on the CPU or get re-enqueued. On v2 patchset, this
> behavior is extended to staying on CPU. If an IMMED task is preempted for
> whatever reason, it gets fully reenqueued instead of e.g. silently put back
> on the local DSQ. The goal is giving the BPF controller full latency
> control.
> 
> I don't think it makes sense to paper over IMMED failures. The BPF scheduler
> shouldn't be doing that in the first place. If the CPU is not availalbe and
> the task keeps requesting IMMED dispatch of a task on that CPU, the
> scheduler is buggy. Is cosmos doing DSQ_LOCAL dispatch on single-CPU bound
> tasks? If so, it shouldn't use ALWAYS_IMMED. Instead, it should only mark
> dispatches that know the target CPU to be available (IOW, claimed idle) with
> SCX_ENQ_IMMED. I don't think that's too much of a burden.

Yeah, I think that's fair. I was trying to figure out an optimal "default
behavior", but ultimately the BPF scheduler can just avoid setting
SCX_OPS_ALWAYS_ENQ_IMMED and manage the IMMED dispatches directly, instead
of relying on the "always" behavior.

I also did more experiments using IMMED in scx_cosmos and it seems useful,
so you can add my:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

BTW, did you send a v2 (in that case I missed it)?

Thanks,
-Andrea
