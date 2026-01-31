Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A434DB71
	for <sched-ext@lists.linux.dev>; Sat, 31 Jan 2026 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880258; cv=fail; b=Ob4fZDlRSE/KrLzjq5sApnr8kor5ad5GWcifVXyzGhT2yunrnZkppzQ69K6YW+FNGGR7LevGhf4c96PeLDEKRLD10a4AGKwi920d2uJ6IZMT57q9yH1i6ZH8lMb9DjnvOpmO3IXU9RxXmhCATnnYdML/WsCwZ8WkFGGkyPU8WcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880258; c=relaxed/simple;
	bh=iNxCdzQp89f4Fjfhk7WZtCtIiA0GsbeWSRI5d3fc2cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PqUrBu/h0M96M8u7VyDQnknh7a081hQSuc4QCJPJ7HpIVo8/Ti78a3zhYS0vjwaFm3j0sIOd7UTV7ipyRu6eLS+AxjQHxXZiCOzhdKubeAhqvRkIilKsXC6NTQ95ojcA4ArVZ6chINS71Vq/rhZc8Scd5BmER4Say+tUAA/UtTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfoM5g1M; arc=fail smtp.client-ip=52.101.56.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfoM5g1M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Duv925BYmwrj9P0rbxKb1stJhhJc0CS3V5aH1EWfOZ3tseLTnvNpSh2qItAFr5EHyv1gURIGxtSc+JS831HaVtaUoWmy43JvxhiirT8Qa9p9dwx2v+XGy5odT+PsTLjsP0399asFueV8FTJGKVZ2UJa+EBFIARcEWjAZU03jdHgs+TwYmrejudKjPkYt7/YJd0umPdKhnmNHLVDRBJAdUMt8HMOtga/oFP+bsmRUMKOnRVZSvMo5sApO2jZbT9w0/OZCL2zArcu9GpUqZyNajHd3QmpZpa63w9LuDg32oz5k1pVom9ruleCMta/Xgo8Va7gjwo6uuFpz4JjBOs3ksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t2wqbFIcFdGp5EPMF08VaMBfSjFSNWkIBBs0/KwSSo=;
 b=vRq9Ld7HlHPLZ3PVKiun5Sz1fU8EvLQi4R/qmH+VOM76U62S24Sz45ZLJA5P9qVJke1BgPoOq2UB3RUOYtzPMRQBLM0ZtVkQD/amD3dcfkkub+vJjG0RpS/k7es3Ga2geWS1TPXo82Dcqxuv97drQNntvVuo0JPu+RmgxGm+CcP6cms3b/NWL512cywuiPldQG7wZrAM7Rrh44FJhJvIoWV63a2KJsz1saFck9zrztYTviXTX76RC/F3A3IFyuav6aTEPc87iM5IcfI+h+r60VGXdjEVZZkYr+BF0BTx6mM2IV+2ZlVuo/0ttNW6DckfWa+fIsytEk4ZtlSSvKls3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t2wqbFIcFdGp5EPMF08VaMBfSjFSNWkIBBs0/KwSSo=;
 b=UfoM5g1MItKpXA1pL+7Jl4GrRFFsc8L5ht9l1c3HITcuKWdOwdQRyWzCom24O+Z/rBS4p6voACefJ5w70Wc+PAscuQmfhHu6cdIn80IyLRuTsu3+pcSLhVij4rHaEZTzDF352cul6UHSLV5UD+vqzA6zCNcRcXiCEjlByZGQgZi/8bG5rM74TpcgnMcClRVvbeJ128If2wCxOZ1ClLvY4cmy8808RMRiBgoNSYdO9HGA86CW5Ix2Hc2wfwcASyyL8IRBU0LFsuUOucIRJ+Cc0ixyL/ZUAMgsahj6V2sKZpnjBjyMH+RWq0mbGNWqp+9yHhADRueSwv2sFiHLxTPzpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Sat, 31 Jan
 2026 17:24:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 17:24:13 +0000
Date: Sat, 31 Jan 2026 18:24:06 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aX46tvnTjLZy0pCW@gpd4>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
 <DFZIS1RRE219.3EWCQVQBFIWHZ@google.com>
 <aXxfBnzs5Xnwm8PS@gpd4>
 <DG1Y8XVKWV9O.24LWXW2G4RF63@google.com>
 <aX2nFSL5QilKsGsm@gpd4>
 <DG2XDI382JPD.6GDH6BO96EXY@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG2XDI382JPD.6GDH6BO96EXY@google.com>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bd5265-dd4b-48da-ebbb-08de60ed8d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CyxkD/hHEB3R8OYip2Y35IVjI7+Lsf2edy0LS4opkAbjLlID0ZALyTQaATOS?=
 =?us-ascii?Q?dpZM5kKE2mSwtS5kSzEyVY9C8RIfbFeVE3ldqTmduK9OQhF8Ba4rKKB8eJ7I?=
 =?us-ascii?Q?e+c5x7PCooloQVFU2f30oa8+cdfl3i5YS4vFDxmadn4u2Pgs2IP+J/E4gI9I?=
 =?us-ascii?Q?BlsuzMuSL+sQslu8Yco3h+JaHCwWC+RcgymQ5DjIgoTsRWbXoMcfErBVZMN7?=
 =?us-ascii?Q?ysdmD8sth6fXYmao+UMM/+hx52ye2y7Frk5BOB/eKeHz9/HgPARsTJF5da3w?=
 =?us-ascii?Q?cd/0uYamm8M8IjSlXZ2s+CYMf8TK3Y9aECHAT3FHroOdhPuRutXfUfRPN99o?=
 =?us-ascii?Q?Di2QVyrpN8K1+G8yPKZNbwrBXV7k63w010KW4QRn9khC9ti5BMxf0HKViVSK?=
 =?us-ascii?Q?tt6nL/2RYRqOTa/9ZqhsiVbmefwqPxlS2La+kJV1MfJ6u5i21t6m8kJ+wA/d?=
 =?us-ascii?Q?O2DBIcfs1ry0hb/ZBzvsK84rdfJAn4UNArRq1WswpocVPYYzNpVgnfts/tl5?=
 =?us-ascii?Q?bT3nw5RDeNIOGo8QAfm1GzGU54857s8mDz86LDMC8HDyLkc02OqMthui+Doy?=
 =?us-ascii?Q?HPGjmTiuQaaooLKG9tj0JFmixz44Ouc3vc1OLaHPNGEn4FEBd8iG2fCBECwE?=
 =?us-ascii?Q?mnknNdPmt7BsVvP+4nEFRWz77RbLUHHhFbhYzG8CZVRuPu4PBq/DE8Y+knP7?=
 =?us-ascii?Q?EVMrpO5Ulqv+zijXled6/i+M6X+uJ5XcEnmOVsVdst/NtnAbKWPCHwwCcAVw?=
 =?us-ascii?Q?hEDxRiC37KlRtn8dTPELEZygLYGaA0eeleehAY6GLbGVmjtgAxgbaJZDeJif?=
 =?us-ascii?Q?BxEqKGRtqIQDB+a6yS245q0avA5mFDCvTxS1SamuwoymcA74BB5IQo85qoev?=
 =?us-ascii?Q?eyfuk1o4CyWdwVdpd+NL1l5bExEfLc/tgdK1y0YsHn9SNv7gYyfFnp2v2n4D?=
 =?us-ascii?Q?pEhL7a30yp527MZ8xXqelxQ9KQka6W9k+cHhaazsMbood/w/nkEb+CQzewEQ?=
 =?us-ascii?Q?GYEDDZUdR7noZybRoHZfYTVMT+hecWRKGAMH9FdBsK4KcXHiSILFx8p7N/5B?=
 =?us-ascii?Q?PuSY3Itm9G+dN6pdr+HbLW7qPw6CrtblzgHkuuU/zih4IBrHEz4aox5MDVP2?=
 =?us-ascii?Q?P5lEdIIWG7/uA/junplwRNsrr/r/WjX8JtYI5zXWgMkA4CQ8okJVk7l2q6/x?=
 =?us-ascii?Q?eBNtDu/RpRdy4I9fU5cJteHoinNdzKrKyP9HKog14FqBUkgPAig3A9C23Mto?=
 =?us-ascii?Q?eGDaluD1zCGvqrvGjErXO6yiZAvCq52N9mMrnyMQPXfGBldY/DeNYQN4XFUO?=
 =?us-ascii?Q?S3hWZguHAS2BdZAQmkSHXxeQs8a55Qnkff7bLcEp/9P7l+SDy0ytnb3Xvnuh?=
 =?us-ascii?Q?0uzYdZkfWSWoq87LuHDoUakGD5ji+4u6hr28fqPgd6nVixSDc4BVia22WWnF?=
 =?us-ascii?Q?YCKO9yNgnbDOXliHmck8anhkDn1ltndO7wVnM5FV5IiDKs2ZNCAT0act+jML?=
 =?us-ascii?Q?fVv7rzGCVt2Q6QWcKtzAx9gY/tWRdk/V3gavwTzjkoq4PJrXRM5e+5ZrK2Nv?=
 =?us-ascii?Q?4wIvo8QvOX0u3kHMGis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+4ge5cs2npwpMg0LmJXR1I4pAvUjUwSGMwTRQxYbWyrKxFvDj+3QlvgmIBLp?=
 =?us-ascii?Q?30mxKMNd9Cnx/1uCLmeIm5IaTUmU8ul184TTNpl62YM5xdW8ZAy/NMEZ5k+s?=
 =?us-ascii?Q?Gap2fW7ucWWMd1IL+iEtxOcssflBCF4l6MxLIvpDxRPw5iknKbn1mp+TOWF4?=
 =?us-ascii?Q?kmF2m/GbXRy/V0oqNrF6EHn75B/6MWd3gvpNjvNo6Cl2jG00Umi1AcgX6fLe?=
 =?us-ascii?Q?OvxXW/i9N89DSnCBIN+xU6dmbPLb9ebBJqsTtW6kzWBnC/A/RRsdMFpIqw+o?=
 =?us-ascii?Q?vu3gvrZW2DDT0CbY3xYvyKP5COTMgHmfBVSaMFsT9XLxLk5nCjSktAJ6zwI2?=
 =?us-ascii?Q?JNqjZgCzJogAjjxvZz8QJvxYkuHLJ3iTZTEWkJI4klITYybGN0Te2yC+QTB5?=
 =?us-ascii?Q?j6KHoaZ6VHxKO3FZrNFjUyjnnbTu9n76uyZ9BbzvFg4Xhe78pYL4EcyxRvQX?=
 =?us-ascii?Q?FmwxmsIqxJlEsFHjMR2LV1QdtiEWsBSWR6vRCn63x9urlJwVu0I9wr/RzUS2?=
 =?us-ascii?Q?OtWGKlx3Qs3GHhF4jeJyEeVazYHH0SuVPrSGT045bxN6lfz1TZhdnBWOHCO9?=
 =?us-ascii?Q?epdnp+iG/WJkH5SpREBKaxweLuR5oviFTTGhsa4veOna+RyaAnco9zqXQ7Zv?=
 =?us-ascii?Q?v0pFpEbTwAvCoceZ+v/dIVUUS2Lx5Zvqk+xIuW/fPIXBYnijER5awV6RuTmm?=
 =?us-ascii?Q?rmexgYX8E/EcsCL1dOMAr3t/y6inYGw1y+DSQStC0eV4wdSOjls/PcueaZSC?=
 =?us-ascii?Q?zTTxB48dAYoilX/0B1I7EREI18W0kDfTK38mGN62CDyAtnHrdIUR2+a5aycn?=
 =?us-ascii?Q?s2UrWaNsXksXi68k/pQxOmbvQrZqsh640F4B5VNmhxAQq9nTVxj59JPt3sHf?=
 =?us-ascii?Q?GaYjBCvq6a0PABwIjPvY8G/dv30pJkreZwY+cg99Urtd9R39g/Wj/3Nd0an2?=
 =?us-ascii?Q?mK10FVRw2q0wKoQxFjJRt6g4Q0vWnWYaPHksxA2JQzc3SuZh35Dfc/L/cDYS?=
 =?us-ascii?Q?l+aN31hSeXZ3FLH+c/kD8dMXzHE8UXNqIrzSycQhnX2dobVIUQ+OP9JAT/tw?=
 =?us-ascii?Q?TccxTdwhYPR59wUW5gBqEN0QW9AtyBu+TQGN37QoJo7U0lb26c3gj+uqBqJ1?=
 =?us-ascii?Q?VZpk9+weLtn4ZITg2hzQLmPH5OXnHgytxVFcCQG99/XVPFrWDFVRTrxpCYBt?=
 =?us-ascii?Q?3PctomGkhK9Gubfmdx8HpHFJGkP+JYcTyCJmx2JvD5VTjUn7ac1f4oH0wtGQ?=
 =?us-ascii?Q?sYz7oznkPnGq1r5RAWJtKRTx9DkRClBQyluG85Ge83ijZSwESpNs02diCkC+?=
 =?us-ascii?Q?qJoIu0HtVcsD9pUDdDlhkM/lCgR7NbNGbprW+tM6peHQcKtXV480He4mAx6E?=
 =?us-ascii?Q?Jn+hU7znt6xh5+1+FaQRUvAOnpBt7PlcMPGHW6D0LSxkK2C05ekodLLvf1qO?=
 =?us-ascii?Q?6MjNQeq5RtSF23KqoBUId5fVkbNnm0tUK/+Pt2H0j9X5NYZxO3at7zyt8XZ8?=
 =?us-ascii?Q?+NR5r6NF54u0j62y687r3sNpcrdt6FxDX9gVaHkZFgZ6k9tsJIBjJTXNNBN1?=
 =?us-ascii?Q?szntZlLj8ELJ47+K09h1Nlgl479FEKTVzdQlIwVfhd/k8Ad6j7AJw6nD2cSy?=
 =?us-ascii?Q?u6sMQIS+zShoKleb4Tnr0iTKFr6wHQ/Cx3dU3xxDoqNiQN9JiQxwIbrCsEMQ?=
 =?us-ascii?Q?Mq3f1YZHdS1WN/AzBmRQza87tyfK358XCp8MfyKvJkSV5jlj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bd5265-dd4b-48da-ebbb-08de60ed8d81
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 17:24:13.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouXMD6O6LYcOjSVvFeeRaCzOHDMaTW9taNwuY2+5QwwcOQZLCm6zUI8h4XQBT8jumN3v/+3htsN3Wf/ukbMf9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762

Hi Kuba,

On Sat, Jan 31, 2026 at 04:45:59PM +0000, Kuba Piecuch wrote:
...
> >> The BPF scheduler is naturally going to have some internal per-task state.
> >> That state may be expensive to compute from scratch, so we don't want to
> >> completely discard it when the BPF scheduler loses ownership of the task.
> >> 
> >> ops.dequeue(SCHED_CHANGE) serves as a notification to the BPF scheduler:
> >> "Hey, some scheduling properties of the task are about to change, so you
> >> probably should invalidate whatever state you have for that task which depends
> >> on these properties."
> >
> > Correct. And it's also a way to notify that the task has left the BPF
> > scheduler, so if the task is stored in any internal queue it can/should be
> > removed.
> 
> Right, unless the task has already been dispatched, in which case it's just
> an invalidation notification.

Right, but if the task has already been dispatched I don't think we should
trigger ops.dequeue(SCHED_CHANGE), because it's not anymore under the BPF
scheduler's custody (not the way it's implemented right now, I'm just
trying to define the proper semantics based on the latest disussions).

> >> That way, the BPF scheduler will know to recompute the invalidated state on
> >> the next ops.enqueue(). If there was no call to ops.dequeue(SCHED_CHANGE), the
> >> BPF scheduler knows that none of the task's fundamental scheduling properties
> >> (priority, cpu, cpumask, etc.) changed, so it can potentially skip recomputing
> >> the state. Of course, the potential for savings depends on the particular
> >> scheduler's policy.
> >> 
> >> This also explains why we only get one call to ops.dequeue(SCHED_CHANGE) while
> >> a task is running: for subsequent calls, the BPF scheduler had already been
> >> notified to invalidate its state, so there's no use in notifying it again.
> >
> > Actually I think the proper behavior would be to trigger
> > ops.dequeue(SCHED_CHANGE) only when the task is "owned" by the BPF
> > scheduler. While running, tasks are outside the BPF scheduler ownership, so
> > ops.dequeue() shouldn't be triggered at all.
> >
> 
> I don't think this is what the current implementation does, right?

Right, sorry, I wasn't clear. I'm just trying to define the behavior that
makes more sense (see below).

> >> However, I feel like there's a hidden assumption here that the BPF scheduler
> >> doesn't recompute its state for the task before the next ops.enqueue().
> >
> > And that should be the proper behavior. BPF scheduler should recompute a
> > task state only when the task is re-enqueued after a property change.
> >
> 
> That would make sense if ops.enqueue() was called immediately after a property
> change when a task is running, but I believe that's currently not the case,
> see my attempt at tracing the enqueue-dequeue cycle on property change in my
> first reply.

Yeah, that's right.

I have a new patch set where I've implemented the following semantics (that
should match also Tejun's requirements).

With the new semantics:
 - for running tasks: property changes do NOT trigger ops.dequeue(SCHED_CHANGE)
 - once a task leaves BPF custody (dispatched to local DSQ), the BPF
   scheduler no longer manages it
 - property changes on running tasks don't affect the BPF scheduler

Key principle: ops.dequeue() is only called when a task leaves BPF
scheduler's custody. A running task has already left BPF custody, so
property changes don't trigger ops.dequeue().

Therefore, `ops.dequeue(SCHED_CHANGE)` gets called only when:
 - task is in BPF data structures (QUEUED state), or
 - task is on a non-local DSQ (still in BPF custody)

In this case (BPF scheduler custody), if a property change happens,
ops.dequeue(SCHED_CHANGE) is called to notify the BPF scheduler.

Then if you want to react immediately on priority changes for running tasks
we have:
 - ops.set_cpumask(): CPU affinity changes
 - ops.set_weight(): priority/nice changes
 - ops.cgroup_*(): cgroup changes

In conclusion, we don't need ops.dequeue(SCHED_CHANGE) for running tasks,
the dedicated callbacks (ops.set_cpumask(), ops.set_weight(), ...) already
provide comprehensive coverage for property changes on all tasks,
regardless of whether they're running or in BPF custody. And the new
ops.dequeue(SCHED_CHANGE) semantics only notifies for property changes when
tasks are actively managed by the BPF scheduler (in QUEUED state or on
non-local DSQs).

Do you think it's reasonable enough / do you see any flaws?

Thanks,
-Andrea
