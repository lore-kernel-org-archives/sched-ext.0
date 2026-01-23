Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62C3033D8
	for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175170; cv=fail; b=TpvD2JJZXXUkUogpVI22AFKs1zub/xA4rcp5vD+8j0s9/KmvnyXT0UvruzQ33SSqpIN07wn0KboRWsaY3X97Yra0cZNiog0CzJlekMRyv/MH+nXP51eQFt+SNaKiMuMFme0Sq9OCC8glist/LcS9nuCfJJTq6xAKsACMcNTAkw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175170; c=relaxed/simple;
	bh=xEBiRKpld9H8aqXLLpBDjDDLCfCjsQ0vZqsw10sn5PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CRYwp6Un2U2D2Ewvt42qBa23szaf7ilq8esg82K2Ovh12V+HD81wCeEy0pfS1qpKTWhGsKEAh8+RQ4bNiuQ4nm97D8AMyzvqIPD/BYWY8tKZ4Y5I2q90rRm+nhjkUe/1GruQk5yXkEsjFDzi3bgwDE9UvNJkLbohzFssKNi4Tpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pZFNSzXS; arc=fail smtp.client-ip=52.101.193.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pZFNSzXS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzGDhDMt8B16jXLTA2H5wjrOMDaZarbLkx/3CaznvD3EA3oa3zoGBH4/oJKoiiQj8HpbYsMBT1xw5gUZhSXDNvGDmEQAYdefsSa3Uzdtu4w+GYRblY4mqBxjfy771GV6vG1PweAMzu01bCsJqpymz8MVVBKzuBaodmrsnR4Y3bhwsKkPze8ujlG7Qo4unhWq8DzMkJKQc164h8Xh392j03Xo8VC65safk5VA7uTB/wT3kfAl4vlWs9wKGsROmoKTJgs/PlWur1scdoYnrZuRCB48HnYkXli9d2leYB9LlIw+vWNAXHhzSKDd+xMbWHn4ta6nC+X/6Ui36LYcZp297w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZRsTaTX18dxkWG1wCk0ALH5Mx2wYfnFNii7xRCW1fo=;
 b=c3gB2RqKCCND0IQWO4ze6E/JQH8Sm8fMN/9jtTuIQyRUBHusHwoo2KNpkXmz2E7oVRNV3lXHFmvWUD3ZoLm0R+mmxapSRXzmkh0+aJCcukw+i1VvGP7mZ8rhoyLPFGXdP0gYbU80EH7pbeXc1stCeYkkg9Te7jmfv2DPL3ZeWfmNnUfsVq6gyfg8Er9IOiR/B8RxNwyjpxL7OYvn830/acGr6PdTwnEWdBF6ADLVSuzz208c4nYZh4i1dD0akoD0HYARvb8qfF0gwF4JBV4NejoKz9d64dOOL/Gbn6I9C+YlEGFBjk45e017hozsgVtlPSLIrGZxFdmV+5BhMZGhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZRsTaTX18dxkWG1wCk0ALH5Mx2wYfnFNii7xRCW1fo=;
 b=pZFNSzXS4dW4IDdUAyUxTBVSH/c0HanfkQh2A1iMy+fyHo7EfUfXR0BedNqXLG+heR6W5DHGFqNoar0AERFQbZvkDhYJnzbxdJo64wFxlJ1kwhUUmaGOAR+ASCUpgIMfpt1GI0I5JqC3xIGia3hoXaQjdERHtILr8NmBxwlhPMGGjA49hjyoJi4KIYDc/HnqocaWZfNxI1PORf4KanVWqOxEAJ9KOFk4Dj1O6+ekyGTcipKLHadrgsd7x5gGK5W9Xn1tKF/KAAnxCd+vrjGUpQGpRDaX8BIfBFJYE5Of54AWuNUZ3noR9qnX8KHULO8k27unFxY4deASMp9QyS7pTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 13:32:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 13:32:42 +0000
Date: Fri, 23 Jan 2026 14:32:30 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aXN4binznj01rNWO@gpd4>
References: <20260121123118.964704-1-arighi@nvidia.com>
 <20260121123118.964704-2-arighi@nvidia.com>
 <DFV0FQUGMEVB.321XK903AC0B9@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFV0FQUGMEVB.321XK903AC0B9@google.com>
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1ea906-d984-4e52-cd44-08de5a83e2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bnV49HDIEz0JOPSlmKOwCuo19uVuatBCSOELwwJvusLBgMvRvbkvxPwogBdQ?=
 =?us-ascii?Q?Ay7XPyhfBG7Niwx1IxT7ClxeAt013h2lbtN94PYuuecgWpov6iiXgzsv/RNv?=
 =?us-ascii?Q?iGmdJ+iYp4jgsf69CNkIG0Aq5aiZKNmxuSdSKXSIFqSwAf/iZbg+LMggv2Ab?=
 =?us-ascii?Q?uBx8Su8xq7iBq+RO542rR7tLzskww2skpFzmwZIHwrdbCX+MvUABA+6mXFRd?=
 =?us-ascii?Q?jgPWLlvVbFjHLGXNEjv7daDKIBBVilFpaQReEHM7YrOYw2xCW6YGFsGYE2K4?=
 =?us-ascii?Q?LU1ghsqf77DS7r+SDoo1KyCaEXtZjJEZ73FQ4D69gLyJIonpZ6B7y5hf7DOj?=
 =?us-ascii?Q?f/ikGAyePRDodWgGqf/RZPnX6mgMvXtVXMJ7GFE9NffM3Mm5x5aRXrIMUX2y?=
 =?us-ascii?Q?9dVyWTGGu9WTvxdgGKUUb8TijGUFHenmyj5JDcfANRH7omobuHfmBblXkfWc?=
 =?us-ascii?Q?WbfqmD1JbIhBnvlePEFONr7CFsffMNXmAKz4j9YqniW38mYFWjhFVSXLyhgh?=
 =?us-ascii?Q?awcqxj/h1zUMGTp1rllzUOvOmRIfnx3FGRNhDG0H78a/a0vyHnwp0xoOTeaY?=
 =?us-ascii?Q?cpMvBUd5hmKV4gDs5LCv1dKcHe6xG7+LPLo9KNO2x0URwUqolxincVIAHZE5?=
 =?us-ascii?Q?DfToFAN+wjT9S2N9kg1SzwbuqXnPWBdidd2Cfiw7tOplg7UWYkLvJqx5TeLI?=
 =?us-ascii?Q?YEjTKhQg+xzWl48MO4IdAa77m20x0/HvoJuTSGSPgJzU9HIkUeKyxT4mq1iE?=
 =?us-ascii?Q?cc4KY41o3b+jcWNyGRy04cd8BzhxfHvxXmUgVd84e1ywAVIeZ75xfgo+MfCD?=
 =?us-ascii?Q?+DIFjNv2u2LBBO9n+HFGLAGQ8qqYZaf6oClVHdX8h+hBrQ2a7+gqtzs+xHzo?=
 =?us-ascii?Q?oIwX90xpxqPZiVKxXmv5KwrLfKHRUiIQ4TzfaqwK/tEPP4FwKkZI1eXhxlfP?=
 =?us-ascii?Q?jHVG6Q8sfcRcf83Tvwl1KsW5n39pnawrQ2ykdOWu3uQPoL2zIX7WKXw2G1dF?=
 =?us-ascii?Q?/tkTrRAYefZpUWAX6iekAyE8BS09io6xB1G8ei6Ojawqi4vbZqJSnixjL1vb?=
 =?us-ascii?Q?8ILjTaYxMMJ+hAICFUGqUbd5eCbQriF/vjOhCMt97QIKs/21ZZq2TabroSxy?=
 =?us-ascii?Q?8FU4/eaRHRYnCYG6C7/NGv/cuX4nVFHx7e9zSdVnsmfvU41pf+ZNzAe5W1I5?=
 =?us-ascii?Q?FTc29KDoyvI/j3BMuRX+iP8bdusHtsk5HU6zZCDRBrhAVwNAjmwSyWL3J/EO?=
 =?us-ascii?Q?2LLqFpzTHCoowCmmizIbJM4qmfD8QrErHtAZF6zSLstaBOPdxes3wHIgGzYp?=
 =?us-ascii?Q?4bHakHI+yJDTgHLn5F+mI17bqfARkNz4KQPME5tLyBstH+mYKczp09o7tB2P?=
 =?us-ascii?Q?6zX9hN47TpPAPuAC0XSUeXZNTmvqXAsLWADmH3iVwGSZfcAZ0U4TRVDIW1Vs?=
 =?us-ascii?Q?XNDnomYzn2dpESodnYddti7b5FV7/pCt2ghjYmedJdLFpG/2cvqCGM+NwD9Y?=
 =?us-ascii?Q?MtQZs5ZBLFuUIG9Y8mzWgN3xtkrqbCcFLIy3EkjM0c8wFxJZQoNOk+o+EC6V?=
 =?us-ascii?Q?J5xi4UY28UMch9C9CmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Vh9CUeRxc2blflsPMx/TafyCJMwbM+a5afH5kkFNJO4UDdNKVrWavjrHsB1?=
 =?us-ascii?Q?uBN8BbddHKO4kUDde7ga59pJyhz114wvP3R78ooRagwfz2TkxDljVuVwr+sL?=
 =?us-ascii?Q?0Vep6McEd/o12bBSrZySmUvyvUy3BvSZ6Hu6UX2JRi3+8axA0BcPed8duxqk?=
 =?us-ascii?Q?ERRVL9WVrZv9TwswpUM/6VJCbv9F1cMX3wdCM+YNcyXW1jX9LJsFaJlDeLVF?=
 =?us-ascii?Q?Ra+1tO+QMRXLrz68GuCPXRsFohYUtPWglV7yVj1muHIRE3sGDoGEpiJY0k4n?=
 =?us-ascii?Q?1hR34G91q+5hO69/FVcpOX5HpNxwrrmi0Jdg8TR0f5Fno4HJ7IZAUmn1d7Ba?=
 =?us-ascii?Q?FE4Kwnzyoefigu9LYQ9d4sU5Jvy/zzahsK5gkSn+GhibeenFA+JJZ1b+KbFH?=
 =?us-ascii?Q?kh9GnpSNEQ7rdrQSznv5OFQXdQxd2Qk9vYU1zOzN9iVPnc1Zx2TEpEwNxQhd?=
 =?us-ascii?Q?g8+8RdhKgoUVSUAYS+e9p0yP0GbqhIytjF1qxKS46uya7hksCiIsKqKid7vC?=
 =?us-ascii?Q?DOJnEPHwo9hMx8ZpJ21Z07Y/Ff4nAOgvTtmMwXCfBrrV+Qq4/NZBbJUDo5o7?=
 =?us-ascii?Q?lY0VcpX8KNvJbEQfaEh+BNrGY4AdxwOCDQfJPEoqJTMkx7INQ6awtlHeAmPd?=
 =?us-ascii?Q?sXnfWgvi31v4PFLL+V0kDhdij5QeQS9KaXK/5pE9HpbK7uOgpSof/1wA4k0r?=
 =?us-ascii?Q?MpEtf9pzEXin0cyK5vHz0WkJkU6jiIRa0nzH7njrGyeBVqcDql9zF1jlKteP?=
 =?us-ascii?Q?hYl4/EtyhfOTeQMgWmVCY0g3H2E3jGjzLzz9kU6jh5bFBVqOokKfT2jMbHFJ?=
 =?us-ascii?Q?tZxlG2uUZ4m5F0Yek/WHKAObKH6ISDIvwL1eAHzP4hwyhg7Nmba0e5RN693+?=
 =?us-ascii?Q?ox1WF7hJ9uci3YL5mTyWIbAPDwEVKVHsVh/ZpfxxA93NbltJV6ctJvbFDSX3?=
 =?us-ascii?Q?brjvryXXoz6cK12mnLMLeJrfDNh+LrdLFZJI3tbgOoaCMsovC6YbMo8JhGWM?=
 =?us-ascii?Q?nM16hgusWUjh7Vlsl4yam5RiJcMbtmrmrlnAq+YBZUZcJ9I2su9SypVDo7Iz?=
 =?us-ascii?Q?h7brt7eBZLr1zoDDfTApdT7v4hBfDYn5EbdM1ZJQLtkgVJG8yCSVCkPmbb8o?=
 =?us-ascii?Q?NJ/ubsJreCCjPy29ah3iA4esZNRubigyI3/h8Ft4lQNzprACRF0Oki0ULoX0?=
 =?us-ascii?Q?ojkRB7vqKlYor2n9Yq7aU74nFUynt5kj8Qi710GE4A5/1NUQhWZ+Wg2aQFOY?=
 =?us-ascii?Q?sPLG5vvYnZ36P0Dr6Co98/XSak4h2/8tlCMseco7fW5IXuZiGJw0gfGlHwN9?=
 =?us-ascii?Q?SrsnPkePfhB5fce244vbl8471BpyiyVFwzrCQALrckfUTkUAGTMxTZlMwHA3?=
 =?us-ascii?Q?HpudV4Yfdx9nmVHKeICq/vcyv/HrsleD3uFXA/lwH6hVZBY4I3od5UvkIuMm?=
 =?us-ascii?Q?8Nj5SOfyzqzI/X6F/FIxhQeRstnuDlHA818nTb5z3BnSu1wP5HIKVAyB7y9Y?=
 =?us-ascii?Q?8goynB2MrhkMW/kYua/zxeKvh4LGw0/2kRKbZRm6u126g/VQ9RLy61dYRkS5?=
 =?us-ascii?Q?/WS2l0bvdx9GqO7jTYrmn4B/uPgEeudgTQ7Fa50ThJmne7KbvV2cxQ1mnxS8?=
 =?us-ascii?Q?LIFGZPRetbVYNOKTeSIcf+aVAPZyaMTAt0sUp18KM6UizYP9dnpToflGMiUe?=
 =?us-ascii?Q?a6yJw/XxpXnrtZ5Ai8lSxXeqdWubLBx5dWFLAIo2MKTcOz1V5DGEtBpKSgjc?=
 =?us-ascii?Q?M23tdol9Kg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1ea906-d984-4e52-cd44-08de5a83e2a4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 13:32:42.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BqybQkPYTMw0inz7pU6IlP2zyYAYUKd7+kVfP6r9YRhVGv5lKBXojQeImlvj5e22M4B2RSrCwzzVftDP9Xrfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100

On Thu, Jan 22, 2026 at 09:28:39AM +0000, Kuba Piecuch wrote:
> [Resending with reply-all, messed up the first time, apologies.]

Re-sendind my reply as well, just for the records. :)

> 
> Hi Andrea,
> 
> On Wed Jan 21, 2026 at 12:25 PM UTC, Andrea Righi wrote:
> > Currently, ops.dequeue() is only invoked when the sched_ext core knows
> > that a task resides in BPF-managed data structures, which causes it to
> > miss scheduling property change scenarios. As a result, BPF schedulers
> > cannot reliably track task state.
> >
> > In addition, some ops.dequeue() callbacks can be skipped (e.g., during
> > direct dispatch), so ops.enqueue() calls are not always paired with a
> > corresponding ops.dequeue(), potentially breaking accounting logic.
> >
> > Fix this by guaranteeing that every ops.enqueue() is matched with a
> > corresponding ops.dequeue(), and introduce the SCX_DEQ_ASYNC flag to
> > distinguish dequeues triggered by scheduling property changes from those
> > occurring in the normal dispatch workflow.
> >
> > New semantics:
> > 1. ops.enqueue() is called when a task enters the BPF scheduler
> > 2. ops.dequeue() is called when the task leaves the BPF scheduler,
> >    because it is dispatched to a DSQ (regular workflow)
> > 3. ops.dequeue(SCX_DEQ_ASYNC) is called when the task leaves the BPF
> >    scheduler, because a task property is changed (sched_change)
> 
> What about the case where ops.dequeue() is called due to core-sched picking the
> task through sched_core_find()? If I understand core-sched correctly, it can
> happen without prior dispatch, so it doesn't fit case 2, and we're not changing
> task properties, so it doesn't fit case 3 either.

You're absolutely right, core-sched picks are inconsistently handled.
They're treated as property change dequeues in the SCX_OPSS_QUEUED case and
as dispatch dequeues in SCX_OPSS_NONE.

Core-sched picks should be treated consistently as regular dequeues since
they're not property changes. I'll fix this in the next version (adding
SCX_DEQ_CORE_SCHED_EXEC check in the SCX_OPSS_QUEUED should make the
core-sched case consistent).

> 
> > +     /*
> > +      * Set when ops.dequeue() is called after successful dispatch; used to
> > +      * distinguish dispatch dequeues from async dequeues (property changes)
> > +      * and to prevent duplicate dequeue calls.
> > +      */
> > +     SCX_TASK_DISPATCH_DEQUEUED = 1 << 4,
> 
> I see this flag being set and cleared in several places, but I don't see it
> actually being read, is that intentional?

And you're right here as well. At some point this was used to distinguish
dispatch dequeues vs async dequeues, but isn't actually used anymore. I'll
clean this up in the next version.

Thanks,
-Andrea
