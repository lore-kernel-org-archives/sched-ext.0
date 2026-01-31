Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768119DF8D
	for <sched-ext@lists.linux.dev>; Sat, 31 Jan 2026 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769842467; cv=fail; b=fOsd35haeEocpLwdIRlyYt2hyt/hl11oJbFxI4QWiyypiXagM3egftZYuqGZScGrVmlvfl+S+qaDW1RPoK1VPwAWMTa28lwzGqsFpYOu5LA7XwYo5vVOZ2JG4WetEv0aUinQZcKrXO7Bfy91pcuPr20+p+SsNY2HpcjfgoBV/B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769842467; c=relaxed/simple;
	bh=uqTLV0NJHTXks2xqLwQwqtDVstDdEtBsueVobTS66+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DkaQAp0jyn2zPaE+Y/Oj0RUAqSeQNxKnrjxy/m04ISnR2n6OlZ1wNMMmLmtTNoVneRAsBHhjLH0Wwv8jPtxedaUPmpWAxB9zpDy7vH80EQfkoSA75rx6BEld2AhSfWZdSgOnwNl+Kb+aINbnQiMIN3BEwEEWKVYogXaGUYJgwZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H8dRu9DF; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8dRu9DF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+vHRsPGqwXwLHfNT/G2/dXKB2VxLXU5MC+thdVP1inmE83/KMJXbZUOREFmFu3wMxtzpm3zE7H8KsSswyeV84wfn2QfrjsqrUkXgZf6xHt1FmaBM8aYgU7a4fWEb/IwYamT94MR7GK6z2kckb5I0xAhZr/FSDeYeWwGEUgZRGHJF8FD1aIMegU2lx0B91FbZznhSiGwaUwR5x+Rtt1rdEY1mZ1tKQwX2LK6dRrH3e6HbU3FC05EGjZ2zznz/EtGIorwCvTzx6eYGzOZFAyPvEL4XVoSw71BXr4BrGP1cYO7MqHfkA2ttgrphIGUKdhAAPTLTmyoa1rda8cOq2ACMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo8KJn/oPDyNTrsQopUmHv/FtyMY/anS5PnzSssqOT0=;
 b=vD43W7/iWaM+UOpxu0Z/1Q76+/E9Iw5DPtTZz5y515B6n02vzersN2itmKSB40GpMPb3Pwunmy1/vmyi1dMYOvpog0EL2hBYjtvx3OUaplwQydsMDVue9+uDZcCsTynR9oUXwctBuAE9DK0ids93EWrseRA3/vEQWfirXC9ykl3p2Q8IQtrzeb6zUZ+J2M2I2ZB7niOYcCVkbLFDX7R+db7fUMDsnX45N7XmqE7+P8TkCToyeRCTDsyRTBa1MTQoRgJSrIqOI0JXdbQOR8HrpS1bpQw680TY1yc/DhXwZB6rARrPkNV0TDOYZ09d5LcaRAQCzs7IRHGClvjioOsLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo8KJn/oPDyNTrsQopUmHv/FtyMY/anS5PnzSssqOT0=;
 b=H8dRu9DFXoae193T6A1wIdWWtXWASWZfUA6QmtywXuPYE/Dcr1/dXxW3rYPRn5l1bJpX14+RWyvIYcg/GQpwCQ2Y33alxKIYJsxlp/gT9FfALq11PHuoG/iEShvWT015uCDSV8tOVqujsbL58sstdlYlbrB89Inh25r8DdiQPaL+2ARoNPCwtX0vm5O+CzUWc/An2JeUeMfMxb7rEbKbvWZqFNq6Y7YB6IDfgOBbooO4JiozGeCQg944gAfs8ZATVbJOPE9tTU73u+GD4F2mOZC2lpm+k7HEQUoY8njcdQ9xAaGjZuCMx2QvGCH0MAQyB5pqmRbPn7khiF7SJZKZfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Sat, 31 Jan
 2026 06:54:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 06:54:21 +0000
Date: Sat, 31 Jan 2026 07:54:13 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aX2nFSL5QilKsGsm@gpd4>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
 <DFZIS1RRE219.3EWCQVQBFIWHZ@google.com>
 <aXxfBnzs5Xnwm8PS@gpd4>
 <DG1Y8XVKWV9O.24LWXW2G4RF63@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG1Y8XVKWV9O.24LWXW2G4RF63@google.com>
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: d2482914-bf57-4e84-681c-08de60958f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uG33LoxLjACU1RbZLbp+oemxRJ/HAw+i8MfpF7frKjhGMMJJm5wJ+XkRA/dX?=
 =?us-ascii?Q?C75Gsc/jjnj53VVY8VS87j6BwQHO0nv7jHdDGEPn4DKgXFWc/Y/94oYuR6en?=
 =?us-ascii?Q?h3ORhJ4dy0Ouj1JwijHuDSAHuRFy/RpIUZn/qCQUoGfqvJW5UVTncx3FFnw+?=
 =?us-ascii?Q?zvpRGjglAbLxWai5Y8qXQlFpdYFiTrLw/eRcou1JF7M8jP4+Wgbv/sJtRq43?=
 =?us-ascii?Q?ciboLu28AtyC2nDMvLO6LMPpGACIe9BogbS6uiwbo2Z0iZqrFhRj1WAuhQQa?=
 =?us-ascii?Q?TU/6yEvAiZ1sbKDIOXzIjHcEfkWQzJ/M+SWJ0qnpvzUsDd+3QUY8NQutGs4N?=
 =?us-ascii?Q?6gRvwk8SuMdAyizyNwa+fw3Q4r81BL2X6KDDK4DHgHaF7QZ6MRUPIlsRb667?=
 =?us-ascii?Q?wFDdbVbGn9K5TOpLcVnMZZ+4rzF1ENHzDfqo1zL2H95tbLjg0bCkkbsl+CO6?=
 =?us-ascii?Q?fmRvNTTROT8jpv4SEzEv2V9m3G0P2mQKVXawg+Xy/MrWOPC4I4cX1Cj9sRkS?=
 =?us-ascii?Q?LrXuGs2cnpkqmDBturMxPmtkTSnl7r/IBq+TnOejVJfehXu1gYI5t60bEvTw?=
 =?us-ascii?Q?h7+47nOArbkbWt4OFhgBY+Wi/Vpd4x0VIaWejiURSgkpDC099B1P6cWeOH9E?=
 =?us-ascii?Q?w37zOyLUVqYakQd5E5JgGdy9oJgBUuP0bVfTlDNAvlFYitW5pFt3KtFNgbiH?=
 =?us-ascii?Q?xlcQYI3hmVmN9RdvOcvG+ZGJQxpT68uyCoKkx2qJW36VbX/AxCFkh6yUsJ47?=
 =?us-ascii?Q?pO1n9mXeL4Lk7R0BaLHZ2CM4T85aZ/ktHfpgfbcA9XAO+TcW7q8Pv8IOjo9k?=
 =?us-ascii?Q?XG1Ff+cO67TG/QdW6WDmfVbeKaAvKEcESqVBtgJ9s+j15XIKlcGGHFIeTjY/?=
 =?us-ascii?Q?p6LGOi17f7MAuuBO5RoXIOjWj0n6qxAVHuH1R+C4uQL/wrqxLi4Z93rZUHZk?=
 =?us-ascii?Q?5bsqXWE3gISLTIzYTZEGUWSI4PylYiKjuW79H9afVBYX7qsqQEkJUzWTqRB8?=
 =?us-ascii?Q?tW/j/YDU0NTOSbZAY4epEvNiq+3F0mkl+XWJAZeRb3W6Sz8VkpqRt3p/M6X6?=
 =?us-ascii?Q?Wv3MO+XXlGvM9cOuDFYK9er2QRea8S9ynHnPVylSXtYl9ccznAkDXyUJy5FJ?=
 =?us-ascii?Q?znoRVJFsiVBH5HSqQnAtf/PocsF8gf/l+8qwOPiZsyoL0acbwdS50AjD6lcU?=
 =?us-ascii?Q?yhWnPCzYCR4bkg51x/oso/Z7jZIYckfp2zqu4W8jDpE10kA433mJL4mm1tiI?=
 =?us-ascii?Q?tM8G/GkQrGHCEMYJ9Y4QCFLNBVzvNH/iK048ZSFzGTVYDVJXEpvFsnisvcxL?=
 =?us-ascii?Q?UFUs64CI3amfpcQgU0pnQUCQC605g84pdlm8oZ7VKUD8dCpJ69qYC6OWLUzx?=
 =?us-ascii?Q?3ireSgu1Mn87xQ3F8v3AOYe2vOUS8cOi8HkzBPt/LO8A3RTWq3VeeLmRj5Sq?=
 =?us-ascii?Q?c2PLK858kP3YNhvvHS+XI1hJDQtjsKOwNIuBNmYOkV5q+ZCy7Xdy9CSUnZy9?=
 =?us-ascii?Q?2aBm6FPiJgcptyN5oXFo/O2pmUPcB9e01AxfJd9WFXlMolLi//fQmZlGis8O?=
 =?us-ascii?Q?dps2EvDanosay0VEZDk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4AqDUGnw0p2gzEJkY3xPmechY87ZYfHJhUrEhY8aKwGOSdszpeMJBDDipJk7?=
 =?us-ascii?Q?F1ybH0HdVSCrdPJE/fKV2F1fij92He7KEhXUrjgAZOmHSSocGPA5+Qgv98lm?=
 =?us-ascii?Q?83yi3aw99M1v7IchtO0k4yREC2Da1nu5gNc7wkqzjUcG/Dasw3Ib9yRc1XGS?=
 =?us-ascii?Q?CRjpJwD38byVeuhQuVuZt7PpWRJ8yIBY1OB6Rw93kc7a23fEgtioaVQ2hzKt?=
 =?us-ascii?Q?v7cMbvqEdWFl9YVPLR0uNgeQm6qScmV+X27Uc1HWVulfn42oK9ofITp6ednE?=
 =?us-ascii?Q?1r4AtvAMpQgkXzFFYtpiQHXlza9FBSYu+SXC+I/ufzlQaQJkOQ5ygX7kiQ3n?=
 =?us-ascii?Q?dDEOle0kt9mbElS4I2Pw3X9XvBWfU2nElI7NTP+ubI112RA9aKi76pOlBiQy?=
 =?us-ascii?Q?v4zNqFVNf15jYeRrFkXXKoAs3Ex8ZpgoJ3DT2ImUiON/94OtN4EwqU0RkoIL?=
 =?us-ascii?Q?tzivWiIt5HEUzgiohVzGFUpw35bkrhYedpIohM+z63Tkh7u1OHLWod0Du+IS?=
 =?us-ascii?Q?ZIN9qknBkz6QsIysOYgcHhfE8foqJ+Rbv7IFprj/ueLx/pzT255hMs3Hd4FN?=
 =?us-ascii?Q?34x2zrITxxUJh2ABtoBveiWwBxaDdXlpd7CBuDoiRguX2JMQSBFyn6AvzXSj?=
 =?us-ascii?Q?6efImSijucrCOylmWX0uht3ob9p8k7iGP14JvBbbPWRUowKwEAzzam/2aGW9?=
 =?us-ascii?Q?xZ2Tg7twzN/GtiDNPaEyilXUPRg4HrF8cb/4JWoQJiyizSOpT0FBqbB9B9MC?=
 =?us-ascii?Q?CTwPLG/3JsVvOq+HkG3H5MHcLQoSXvVTWb+ryHDlJZelRdFAjBxy1uXl/QDO?=
 =?us-ascii?Q?ueRo9iIjZ1QYoNu+8ViipK/0f1I46qe1I5r/B96MBJiOKZIf9U/m7266QCr6?=
 =?us-ascii?Q?sGLg8BUJ1xvW6voV/jQvwTr0Fvvy+wBtQF5dAsmL8fxChIlFBenHpsih7Rl6?=
 =?us-ascii?Q?lav4gNpddBjn+lafFRe+YcyaekC2o2l2O0bTHsDWEodreEkvMva2SdcgHC0N?=
 =?us-ascii?Q?y2uzIdhxeRhed151nTf0se6B4+1bUwf7nmfd35CMfo8HuO486ysO60dEpUFH?=
 =?us-ascii?Q?/s1ZmgVs05GM/w9wA2ZI/9oTX0ESn8a86yKAjnwBukSw8mn3Hr3OEW7wqW89?=
 =?us-ascii?Q?dz471ijF9Suq64hA1nmjrIR0uu6GbC5k1Sqnricv7/hJFlsG6mhaWp7icAA/?=
 =?us-ascii?Q?i9Tt3/1m4Axz/3f39EHjmvgDf3VwKCIhYVsAtbou5iomhYlsEHSZALS1lWfA?=
 =?us-ascii?Q?epfLZujDwRoWBsTxzXR+ZOUmTYxIRHi6XfjglJwHNsCKSV8HAaJu65wxP8D5?=
 =?us-ascii?Q?q+9ZVdTQJ60/vUvdtQsfJSElwMSnN3jw9foSriBMSRbtrVT4XzmVUzCeGJ5M?=
 =?us-ascii?Q?SCGngFarWdRZRPiQ0IbK1FkhlnNFeHxcqjZqU0AxGZMGYdMnsR4dZAagFvax?=
 =?us-ascii?Q?+ZEkk/rpNLaNml0FIv+Ht56cWQjijRVnWWhP3dNW9iiR36Nm6977dDbG0J9F?=
 =?us-ascii?Q?Qjy/rzSJq9s8xkQwEfxOFD+qS/0qMCVXFL15Z9BuL4Vt/RLPMhHNYOxMFzl7?=
 =?us-ascii?Q?XTdK7B/WOiCPxds/4SBpr+JbrpH8WOIjWK+ZAvqdUhCpMd52OuG8hbz/mo4P?=
 =?us-ascii?Q?9Vp1ppRIbd56NcAzrxT6z/vXwyA5BijEWRpn95dgRbHvLm/BIvFH9dLkCFzT?=
 =?us-ascii?Q?Mt+pgfwDup5bzha0QhxKUntpduVdLKqRduop3v0vVqzB8omj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2482914-bf57-4e84-681c-08de60958f3c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 06:54:21.2337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nk1iRtgpIc6Nzup2rTaIWRAmrL5vjZvUWlztroPCgfLYLhUhQyqIsCY5hpVpROY1F8If+78eKdS33fSkLzX7gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155

Hi Kuba,

On Fri, Jan 30, 2026 at 01:14:23PM +0000, Kuba Piecuch wrote:
...
> >> If I understand the logic correctly, ops.dequeue(SCHED_CHANGE) will be called
> >> for a task at most once between it being dispatched and taken off the CPU,
> >> even if its properties are changed multiple times while it's on CPU.
> >> Is that intentional? I don't see it documented.
> >> 
> >> To illustrate, assume we have a task p that has been enqueued, dispatched, and
> >> is currently running on the CPU, so we have both SCX_TASK_OPS_ENQUEUE and
> >> SCX_TASK_DISPATCH_DEQUEUED set in p->scx.flags.
> >> 
> >> When a property of p is changed while it runs on the CPU,
> >> the sequence of calls is:
> >>   dequeue_task_scx(p, DEQUEUE_SAVE) => put_prev_task_scx(p) =>
> >>   (change property) => enqueue_task_scx(p, ENQUEUE_RESTORE) =>
> >>   set_next_task_scx(p).
> >> 
> >> dequeue_task_scx(p, DEQUEUE_SAVE) calls ops_dequeue() which calls
> >> ops.dequeue(p, ... | SCHED_CHANGE) and clears
> >> SCX_TASK_{OPS_ENQUEUED,DISPATCH_DEQUEUED} from p->scx.flags.
> >> 
> >> put_prev_task_scx(p) doesn't do much because SCX_TASK_QUEUED was cleared by
> >> dequeue_task_scx().
> >> 
> >> enqueue_task_scx(p, ENQUEUE_RESTORE) sets sticky_cpu because the task is
> >> currently running and ENQUEUE_RESTORE is set. This causes do_enqueue_task() to
> >> jump straight to local_norefill, skipping the call to ops.enqueue(), leaving
> >> SCX_TASK_OPS_ENQUEUED unset, and then enqueueing the task on the local DSQ.
> >> 
> >> set_next_task_scx(p) calls ops_dequeue(p, SCX_DEQ_CORE_SCHED_EXEC) even though
> >> this is not a core-sched pick, but it won't do much because the ops_state is
> >> SCX_OPSS_NONE and SCX_TASK_OPS_ENQUEUED is unset. It also calls
> >> dispatch_dequeue(p) which the removes the task from the local DSQ it was just
> >> inserted into.
> >> 
> >> 
> >> So, we end up in a state where any subsequent property change while the task is
> >> still on CPU will not result in ops.dequeue(p, ... | SCHED_CHANGE) being
> >> called, because both SCX_TASK_OPS_ENQUEUED and SCX_TASK_DISPATCH_DEQUEUED are
> >> unset in p->scx.flags.
> >> 
> >> I really hope I didn't mess anything up when tracing the code, but of course
> >> I'm happy to be corrected.
> >
> > Correct. And the enqueue/dequeue balancing is preserved here. In the
> > scenario you describe, subsequent property changes while the task remains
> > running go through ENQUEUE_RESTORE, which intentionally skips
> > ops.enqueue(). Since no new enqueue cycle is started, there is no
> > corresponding ops.dequeue() to deliver either.
> >
> > In other words, SCX_DEQ_SCHED_CHANGE is associated with invalidating the
> > scheduler state established by the last ops.enqueue(), not with every
> > individual property change. Multiple property changes while the task stays
> > on CPU are coalesced and the enqueue/dequeue pairing remains balanced.
> 
> Ok, I think I understand the logic behind this, here's how I understand it:
> 
> The BPF scheduler is naturally going to have some internal per-task state.
> That state may be expensive to compute from scratch, so we don't want to
> completely discard it when the BPF scheduler loses ownership of the task.
> 
> ops.dequeue(SCHED_CHANGE) serves as a notification to the BPF scheduler:
> "Hey, some scheduling properties of the task are about to change, so you
> probably should invalidate whatever state you have for that task which depends
> on these properties."

Correct. And it's also a way to notify that the task has left the BPF
scheduler, so if the task is stored in any internal queue it can/should be
removed.

> 
> That way, the BPF scheduler will know to recompute the invalidated state on
> the next ops.enqueue(). If there was no call to ops.dequeue(SCHED_CHANGE), the
> BPF scheduler knows that none of the task's fundamental scheduling properties
> (priority, cpu, cpumask, etc.) changed, so it can potentially skip recomputing
> the state. Of course, the potential for savings depends on the particular
> scheduler's policy.
> 
> This also explains why we only get one call to ops.dequeue(SCHED_CHANGE) while
> a task is running: for subsequent calls, the BPF scheduler had already been
> notified to invalidate its state, so there's no use in notifying it again.

Actually I think the proper behavior would be to trigger
ops.dequeue(SCHED_CHANGE) only when the task is "owned" by the BPF
scheduler. While running, tasks are outside the BPF scheduler ownership, so
ops.dequeue() shouldn't be triggered at all.

> 
> However, I feel like there's a hidden assumption here that the BPF scheduler
> doesn't recompute its state for the task before the next ops.enqueue().

And that should be the proper behavior. BPF scheduler should recompute a
task state only when the task is re-enqueued after a property change.

> What if the scheduler wanted to immediately react to the priority of a task
> being decreased by preempting it? You might say "hook into
> ops.set_weight()", but then doesn't that obviate the need for
> ops.dequeue(SCHED_CHANGE)?

If a scheduler wants to implement preemption on property change, it can do
so in ops.enqueue(): after a property change, the task is re-enqueued,
triggering ops.enqueue(), at which point the BPF scheduler can decide
whether and how to preempt currently running tasks.

If a property change does not result in an ops.enqueue() call, it means the
task is not runnable yet (or does not intend to run), so attempting to
trigger a preemption at that point would be pointless.

> 
> I guess it could be argued that ops.dequeue(SCHED_CHANGE) covers property
> changes that happen under ``scoped_guard (sched_change, ...)`` which don't have
> a dedicated ops callback, but I wasn't able to find any such properties which
> would be relevant to SCX.
> 
> Another thought on the design: currently, the exact meaning of
> ops.dequeue(SCHED_CHANGE) depends on whether the task is owned by the BPF
> scheduler:
> 
> * When it's owned, it combines two notifications: BPF scheduler losing
>   ownership AND that it should invalidate task state.
> * When it's not owned, it only serves as an "invalidate" notification,
>   the ownership status doesn't change.

When it's not owned I think ops.dequeue() shouldn't be triggered at all.

> 
> Wouldn't it be more elegant to have another callback, say
> ops.property_change(), which would only serve as the "invalidate" notification,
> and leave ops.dequeue() only for tracking ownership?
> That would mean calling ops.dequeue() followed by ops.property_change() when
> changing properties of a task owned by the BPF scheduler, as opposed to a
> single call to ops.dequeue(SCHED_CHANGE).

We could provide an ops.property_change(), but honestly I don't see any
practical usage of this callback.

Thanks,
-Andrea
