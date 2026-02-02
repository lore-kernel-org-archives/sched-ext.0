Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277A2BCF45
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018322; cv=fail; b=tvyJfhJePERG3ZySZq2vaBTAv8bGpaeNlnliOBKty5ijc6dBGhEJgDelxLn2IVRF7iQyQRdrr6YoZbY9/bPT4jaD2v4yqy6fjKgAj1JH9lBxNv5jTo/2tnrzOwycOfsg0Iz6e0Xe497yLq+F6d2ksqhYMtAVorqdm0lE71tmzFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018322; c=relaxed/simple;
	bh=PL9ZeNuH6XDPsUqVgnh7WY25zbWcYZjpR9MO4YQNmWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELavsMmv9WjFZ77NrFhNjpP5kG24N+ogaUqMuTYdx1u2KNKYmS5OWGzEkJ7x1nD9D5eKwmSmTv0mcxv9DK31TetGJ4TsoSsz+E56gDEOC1ZpDwDMLVGJMaLq7IvBRmsLrIbJlAm0MQ0fHPaAWOjdakrM0dgo9UaIXTxgzQ5MFDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ou0Hs38d; arc=fail smtp.client-ip=40.93.195.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ou0Hs38d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR1nLRIiMSVqq1VZ76AEQkJb/x3YFW1IAwqDyBKH5F1SYLyHhp3BFzeaSN5Lsk0k1f8JqnDD/i1riAXl4PpkcXqDmf7EFnmYMNhQ0aJPkc04P1ixf1SYngbei+d79ky+1ZXICGTctidKk2oy//vRqNqV2upOiqE90jHrmuoL2DAQz/nKlYy5KQb69BGwDErjxHHC31qgGnT4cW23S6Cqjgb4Zc+uh4OS2+AsDSlycOujFqGjCblCiLJQ9MavB0y484yuDsL9NwV3JDkWceuJ4xhuCVLOBVjg+RGf4Af4mYJPVXtKVZgIjHXn+or5Qzgp0caj83V/uZZf9iMdMsaykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEebsvreSaZkd/zWtS0A6vc/e3rEICMWCZmlF7u7se0=;
 b=aktqAcTWpT7fp+zmXBZ7u3ip0iO1xI1a8cyImv6AJeiAeBD8s1fnftUSGYbyfy0thi9poJk+7Pk6mc/lGCgFTBCsLJDWikOT7cFsqB8N1TscMD10fNEfk/r3YmeBgVsDolxUO7dA+WbbiTF3Ukd1OqWFv5DLiI7vLJSms0yn9Zh4iuWUbecd6NikQ9sJZ2C+/GoMgxqgXhHb/1MfLaKb0857RGlBQPVa9s8HA+Pi01Ul0ZmAuQLxOslEfoGcDMLrAuI+SVuCbo6Vpnmb61REINsyvNq8LXuDpB+78Y47r4znwSbqXVuNfZzWWNx64lgkkM4r8disgHBiltuFwEfcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEebsvreSaZkd/zWtS0A6vc/e3rEICMWCZmlF7u7se0=;
 b=ou0Hs38d8JnLet94s5tbgPxPPEwxIZ/MYh3qFAqsRNQia1pUzVVsMZfwC/h0EbF+JvEIe2NLkUQ31u8tnRdb9UqAnigfTAUCP3NPQJSbTELPqRNxRryYZKJ4x7vMnVCRRCOiLKGH4HpNu4N5PPwJp6PKdh3ajMWB7TWKT8orIw+1kkrIRZMy8Za2itviFKSrV4+7W3q7735zlpaBTLtB6hGUfPUHPwCgBSYZ6IB4xu0DsgiEsI8u/Q2deKJVAcFAVvhjcxp2Cx+4mUxQLjr4YDII56DPj0dKJFiiq5jnO0kYt3KMpK5T2kll7ksSkBW49QHYomlBK65+sH2ALnUIzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:45:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 07:45:17 +0000
Date: Mon, 2 Feb 2026 08:45:07 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYBWAzFDX8Rv-paN@gpd4>
References: <20260201091318.178710-1-arighi@nvidia.com>
 <20260201091318.178710-2-arighi@nvidia.com>
 <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com>
X-ClientProxiedBy: ZR2P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: e92853ab-a5db-4a21-9022-08de622f0226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q4DaC32iRTAs3/0WcrzQfP96mHRd7bx2WrNe6o19uZkXlsrj/FcipCx9eUFi?=
 =?us-ascii?Q?SJ+21ll9ARnx+/L5JyDqzpe9H+q1nCoXGcTKFaKWRetWTJsprLch6cYBUflm?=
 =?us-ascii?Q?edUkdb5nVl8eecki45J0WaxGn7NIAj2CkYno2CEYvdbNoHXWEL7IC0nj8bEV?=
 =?us-ascii?Q?twloGTpdrfL0Jfr85xJhV+CNIPXNv2lr1aab1WuV4DrUUXYheJZMO3K5eVfY?=
 =?us-ascii?Q?YwosMZXNu/LJ2DiY/mMmdwoKO3eiyuYtK51c0R0FEJz5jwkcAfkUWfuityKC?=
 =?us-ascii?Q?5g6g3LyUTyLnINY8hKpRWIB6bwHtcKeLMToovY48zC1uNYqVyU+dUXs/e1Eq?=
 =?us-ascii?Q?eGS6rgvDMJVwUOMUbN+iuUMxqof8iD8imzCjTWDmctRCc9QSqnm9/8jAJ9/Z?=
 =?us-ascii?Q?eqtMPvUSe3H8mYquW2rFWfycrfJ/jVnIgBS1bM/ZlDTNKE1vW3jtk0Cy9NhR?=
 =?us-ascii?Q?F3ejki6pMj1fF6pWqPI6D17IBAFcZtdoq6ZFOswDUutk46s73BDhGLI9IuY6?=
 =?us-ascii?Q?uSDL+xRx7kUahOo+i05L13OTkbXBwqDiQFtzRsB8e2dLUPr0apYYCEY/jl73?=
 =?us-ascii?Q?t5NH4Yxrh1SSF80oBrydu3288p4UADpN+CiQTXPWbPSJnncV/B5olqiv2d7U?=
 =?us-ascii?Q?J6kNLW3rr1A1HiR5pT9rtJ9xl/AF07Ld5Y/ycIzMDa4/vs0yAz4VIdD3V1ze?=
 =?us-ascii?Q?Q3zWKrvayzh1Hzf6C22mD90fhXaXb/YqiA4W/W8XeC/V0lJJOfkFkxQh6OVd?=
 =?us-ascii?Q?n6kvYpQzDzFlkTzdWH1rN0dmCgPHhm6pA91bqfw4V/47e+CHYyjQInAU4z6/?=
 =?us-ascii?Q?gBTHMQOQkDPefQhGhcCM73co+hgSzpH9ixbVDGVT3gqE9D21WP75uhJAPSYH?=
 =?us-ascii?Q?eltlziKMVu/hgRf3ianuaPnPqPi1rhjCc6bTZs0H6irxtcKgJ/kO0pNFrAFD?=
 =?us-ascii?Q?ScAQX5xAfMZZCdbN9rNkGcyW8lLw5ehG6sacynqqdOTHZJ2InFTzOzkVfQVj?=
 =?us-ascii?Q?JjyAX2qB3Y0r6F8hHPb5c8jf150fQVMxZ3wMaLM1ggaO2c3VwJS26+9di2gq?=
 =?us-ascii?Q?ZVjriOdMJXZVyK5eeQAIFj66GUX8ZEBZJwrcXxXMqj0MUsaGYObbhoRi/9VL?=
 =?us-ascii?Q?gRLet2d7HCZNEJetAS+7hb/7hySXdIhcGAQNe2Ffu++pDBMKPVGbOvGX8NJT?=
 =?us-ascii?Q?5y/ScUoR8qxfiSWI0sIxUwmtlJN+RbYYP8AaW7+TrStR6iyYUdP2mVW6ItCp?=
 =?us-ascii?Q?sn72Lz5uEv/oRxQ85Iky6UZhlyZWHoNYW4Ad+TVdEzVvpB4OveL5Ds7C8yI5?=
 =?us-ascii?Q?bugFucqd1HeDij3M7M5bN1RtY34no2C43AkDjIOdrlRiaV4pXWTMgPt94kl+?=
 =?us-ascii?Q?rrmUZmMypXxc1911+orEgq3PMt+ysA93F+TYdgGnbdtYWGOlEE++lefCy0Bo?=
 =?us-ascii?Q?8fBFIbYdnqIw0EVYKhReqkxVFksXYzhw5F9aWsfrI0eLV0jmjjvQYRpAhNy/?=
 =?us-ascii?Q?wwUHufnMjkttrUyH6HABWd5LlpTenoh9qH/NCIa49HEP/vG2XKntB80qziYx?=
 =?us-ascii?Q?2ADn45rb3QA/JEv+rjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LadxdAL94kLOJtFzEihhROtCykLyY8sV7msgVcYtOx8k5xm7VNjgCqtYIpqF?=
 =?us-ascii?Q?WjA+fPmBesNxv4G6em90j+9n8Ks5a7M/BhPcWxZElRbRQRjYK88qFbVwKAfZ?=
 =?us-ascii?Q?pKiY9k11Hp1eog63JOuj1N1kipx58U3d8NG54sJq4x0VcECwDb7WRvok0sCg?=
 =?us-ascii?Q?Tq8RBxrudVkfEHyCaVjgc0B2w4oDziGov00zeE8B74TQ0MZ4lwPoFJj3DwIn?=
 =?us-ascii?Q?U20zZ/z9v7WksV3Sk/lOsgEJsNbpkyalYe7TsK9Jgkz4dEEplxUyZ3PwvTwm?=
 =?us-ascii?Q?1wCz9cFmbXTVPNQnr7daxeSEhO3zn1y3cZLtslWck9Ydnc656RZ3uZP7GFl9?=
 =?us-ascii?Q?UPnh/5iX1jp09ONpGAo7qKI5PPTcr3zVSpBFNZKBs7xnCzeWSBGwrTZDOoye?=
 =?us-ascii?Q?367kBzq+tjLxPxI7FeDikMVUaNkjPE1R3fvlm0LM/0vcDV32FbvJQw32EW2N?=
 =?us-ascii?Q?/i8slOqaDkbGeEDCEKwD9BdWEsuW+61BHnrYJb/PK90Paj6O+hiPFw9wd7r9?=
 =?us-ascii?Q?Z07+ZIoQZdpV58Ew3KzU0BR7enswpXhvSbBrkyJNbfAzU4NIa6JnyWx8hnTa?=
 =?us-ascii?Q?2hg2km+S5SKngTX0l0Kiedh9w455nTWk2CGY1cMhQgGS637A+reu7Wl5+cSh?=
 =?us-ascii?Q?grCT0N8zISOvplY5s9lrbjyJeyuSKZBzsjGDkz/OENfnfntnThpBsRiq8DPn?=
 =?us-ascii?Q?nzSq5B2sCPXog/fTlr75okkiUbhCkyAMZonQUvTqvZHVCwLUY7ahaOMGXVHF?=
 =?us-ascii?Q?8IESczqDXH3XykyK9MK3E0y/4uURfbL6iMkID1o1QX6RJ0C4DXcPKxyABpZH?=
 =?us-ascii?Q?Ot4dRBjr89/nU2xrN+cT/M32BCc5qT5YluyNq4xfvKT7IpBomomtb0dTkPvX?=
 =?us-ascii?Q?SgLjX12s9WoRCbGrsDKR6Of1x61Rw3yKsTM3U91vDjTubjq2/8QUt+Ey+8KQ?=
 =?us-ascii?Q?A9UsGcHddEwNjC/LnaGSEiQV3maAnBSIC/uOnc47vYhqG9i7A+WvOu4U7Jjr?=
 =?us-ascii?Q?ShRhH1bjBM/qkGSp5yUeExYAJwSQR+ZRTYi3F5Mtm3ylmczS2yG9gWRRa9He?=
 =?us-ascii?Q?cKz+XIrxOc8e8O/vYzFsSKbtYCbEOlWU0zfa6ePhgVuW8IwwytOWL1oLRHzN?=
 =?us-ascii?Q?6ODBk+QPIlcGvaEK2HDQJfGSdZoQ+z0H/tqdTy3WFkzVd6p66NvvKedl8ibI?=
 =?us-ascii?Q?NoY2FMH7j87jWv/MxnzynefgSkiomM3UEaJv6cf8uvXTWnzl0/rT8ddm54yf?=
 =?us-ascii?Q?0y27Qojn/9/9jce2EWuvva5ufnVqs5duWeRXFGU525OEEiU2N7QKI8v+odJZ?=
 =?us-ascii?Q?pObF9BCgnkv9idE+TTjwwSVzhN8lRjQwChu79JtSLwa9Ocu312RJ/We/hDVg?=
 =?us-ascii?Q?5bJjWHyIoYPEwwSN0HBZ6TlNojzzXTORcZVQqCN4it5IyBDKVC9Ht2OJm+Lb?=
 =?us-ascii?Q?XwCt+6331+jOJnuttl6Rg974lCLZx5QziKprOXhHbG+AGOVo0O7+jnSTsnlV?=
 =?us-ascii?Q?fgiqCao0u0iEbV5gV6ZVPeynLC1SqR4wmz+WMbB76kGXGYgRj1MdvLt8ZYmj?=
 =?us-ascii?Q?XAHgj1M1wv9xOE91cnq+QVuUtZH7zEqWwikGd+eSM+XHP8QWTfZU0XRQkYZ5?=
 =?us-ascii?Q?i3IxySHVQa9Wj0vMgTIC7oyTnvBfqPFcyp4jWiSjVrAeyV0G5faGj0/9PWk/?=
 =?us-ascii?Q?Ku4tdD7EcXokn4g2wU6yGllVPmU0HbTLporXwvvPAvW8Jfih?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92853ab-a5db-4a21-9022-08de622f0226
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:45:17.7535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej4cgXx40gar9L+MAzUR+4dAf7oaQDT45WSHjhc1MLG9dPscqXjNNw/gnuOcqj2T+q2VbJ4iC+v626lTiX7QVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827

Hi Christian,

On Sun, Feb 01, 2026 at 10:47:22PM +0000, Christian Loehle wrote:
> On 2/1/26 09:08, Andrea Righi wrote:
> > Currently, ops.dequeue() is only invoked when the sched_ext core knows
> > that a task resides in BPF-managed data structures, which causes it to
> > miss scheduling property change events. In addition, ops.dequeue()
> > callbacks are completely skipped when tasks are dispatched to non-local
> > DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
> > track task state.
> > 
> > Fix this by guaranteeing that each task entering the BPF scheduler's
> > custody triggers exactly one ops.dequeue() call when it leaves that
> > custody, whether the exit is due to a dispatch (regular or via a core
> > scheduling pick) or to a scheduling property change (e.g.
> > sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
> > balancing, etc.).
> > 
> > BPF scheduler custody concept: a task is considered to be in "BPF
> > scheduler's custody" when it has been queued in BPF-managed data
> > structures and the BPF scheduler is responsible for its lifecycle.
> > Custody ends when the task is dispatched to a local DSQ, selected by
> > core scheduling, or removed due to a property change.
> > 
> > Tasks directly dispatched to local DSQs (via %SCX_DSQ_LOCAL or
> > %SCX_DSQ_LOCAL_ON) bypass the BPF scheduler entirely and are not in its
> > custody. As a result, ops.dequeue() is not invoked for these tasks.
> > 
> > To identify dequeues triggered by scheduling property changes, introduce
> > the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
> > the dequeue was caused by a scheduling property change.
> > 
> > New ops.dequeue() semantics:
> >  - ops.dequeue() is invoked exactly once when the task leaves the BPF
> >    scheduler's custody, in one of the following cases:
> >    a) regular dispatch: task was dispatched to a non-local DSQ (global
> >       or user DSQ), ops.dequeue() called without any special flags set
> >    b) core scheduling dispatch: core-sched picks task before dispatch,
> >       dequeue called with %SCX_DEQ_CORE_SCHED_EXEC flag set
> >    c) property change: task properties modified before dispatch,
> >       dequeue called with %SCX_DEQ_SCHED_CHANGE flag set
> > 
> > This allows BPF schedulers to:
> >  - reliably track task ownership and lifecycle,
> >  - maintain accurate accounting of managed tasks,
> >  - update internal state when tasks change properties.
> > 
> 
> So I have finally gotten around updating scx_storm to the new semantics,
> see:
> https://github.com/cloehle/scx/tree/cloehle/scx-storm-qmap-insert-local-dequeue-semantics
> 
> I don't think the new ops.dequeue() are enough to make inserts to local-on
> from anywhere safe, because it's still racing with dequeue from another CPU?

Yeah, with this patch set BPF schedulers get proper ops.dequeue()
callbacks, but we're not fixing the usage of SCX_DSQ_LOCAL_ON from
ops.dispatch().

When task properties change between scx_bpf_dsq_insert() and the actual
dispatch, task_can_run_on_remote_rq() can still trigger a fatal
scx_error().

The ops.dequeue(SCX_DEQ_SCHED_CHANGE) notifications happens after the
property change, so it can't prevent already-queued dispatches from
failing. The race window is between ops.dispatch() returning and
dispatch_to_local_dsq() executing.

We can address this in a separate patch set. One thing at a time. :)

> 
> Furthermore I can reproduce the following with this patch applied quite easily
> with something like
> 
> hackbench -l 1000 & timeout 10 ./build/scheds/c/scx_storm
> 
> [   44.356878] sched_ext: BPF scheduler "simple" enabled
> [   59.315370] sched_ext: BPF scheduler "simple" disabled (unregistered from user space)
> [   85.366747] sched_ext: BPF scheduler "storm" enabled
> [   85.371324] ------------[ cut here ]------------
> [   85.373370] WARNING: kernel/sched/sched.h:1571 at update_locked_rq+0x64/0x6c, CPU#5: gmain/1111

Ah yes! I think I see it, can you try this on top?

Thanks,
-Andrea

 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6d6f1253039d8..d8fed4a49195d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2248,7 +2248,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
 		} else {
 			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
-				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, task_rq(p), p, 0);
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
 
 			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
 		}
