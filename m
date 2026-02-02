Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D521D3F3
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046346; cv=fail; b=TvM5yBgxqvieJ1g2i+/X3fmhjjqqPY3oU23/nvAvRETK6XT6Yl1rivJDHNOko1+Lgwju/dPL8qKUJNTgQ4c/HXmIduHElnx9TNlffRwIQDxfVl7wzPbz0Sxoh1cvd/H5xr4uZNGYrUyiuwXSI+F5YEiFpInuIzrwEWzru7lRVuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046346; c=relaxed/simple;
	bh=IuAjhTq3wvnMwv/hTHYjpmLtaGR183pT9TyNtyYQWHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PTrfI7sHDn7l83RpkJmri6ckPI3LvochopdhZqbcQ9WT9/MtBhC0D5uzZ/Igt0FXKMm+OeYwpgD2Itf509/IIYhIVS16RTTeowNKLXuC7qZQkG0oZgyCdB3oHdkCS6bAeArn7pFZrCVZV8NNqO7DPdQlL1eVqueGxote6B+2DlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mzw/6bjz; arc=fail smtp.client-ip=52.101.56.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mzw/6bjz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4lzz3buY0Yl7yA8xyhMZGJ8+ZH5SenHgUP/XFgUxaTlxI+kBci7SMa7LoL/C9NuTrO4iDQC4VnMndpDIXkLK/uoUu9uk6q4WGIQbpVC20t3TiIlKr/jQuWH1sSKngmrz6Z4onRl1bq3UG7jIW0Cy0R+2eRoZRlTj2ba9fT/NT1KzwTVGJ4/K48GCk8rOu/amEe6WSt6jV/YuNQbzdzJCJzBBSgS4HmUeooSz5AwDsJYf6rX1IU2GGEiLvuW3Efdc2d0SOsrmMEwEneUk6uD9IIYYf7kb2z19IICoojru1gxoyLgXx+rljsInO2GFXn90Co7752SY+0008sQDliAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Jj7fMwj+f2/Djvk8QsqTNhKh0ugne1HuHXxzX7bFAE=;
 b=n/qgVd6JS8bVsFXwkQ3HRjA9TT9E1yTfsg/KhRJ7ITKwienJoG0+e/atLlBwyCKQNFozOAdU/sG5gXa9gYr9s/Fk7VYtqEsLB6sURS1XxlziqD293hXRj7iOyEgokwvIqx6ctJBFayXEGtvECpJOVjxTbPnXF5St4VySCOOO/woFxh8CpVjacU7F+BuTNKiYj5Rxioh74q273acCYZt7KiAw5aA89J745uRh1XcHo0c+cGchsN55xX1rDN/SLpqpRrxF0NNU7R6V/p5uoGC0g8d6ar35BLJKG8HWHU607Omoesh4l+ey7LqYp+9jaDU1aUURN4j6tjDgcP6jlt/GbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Jj7fMwj+f2/Djvk8QsqTNhKh0ugne1HuHXxzX7bFAE=;
 b=Mzw/6bjz17eFIemgt6Q7N1SI3jkIM6Y/VKBlrAf2OIYRFZ9bG2aSqbPrkcpBHdO0PNlh9I/dG9qLGLdJBWFILD97y56545u6Zct1S4iqjzgwy9lGgk9INMjHOI5XAKB8vRmrg1Nn+qtXTzCcj8Tp1DQai6cbP/WMyZhld6byCOQGy15IrPBXOav9DwMsAWkrU1nNixJ3bqhSAjPEnHtfJaa92m73leVrRc4ziaoZXWKnv5t7iWZftHI94tBH7vRlbNbhohipx6MIViHQAy2ffhR9jG+xelNOERZqgE6M3jvV/8P4SiNxLjwTsVoUtDRl2M40okwDCPy3L8SBKcVQIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Mon, 2 Feb
 2026 15:32:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:32:18 +0000
Date: Mon, 2 Feb 2026 16:32:14 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYDDfjZv0pFgO2LK@gpd4>
References: <20260201091318.178710-1-arighi@nvidia.com>
 <20260201091318.178710-2-arighi@nvidia.com>
 <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com>
 <aYBWAzFDX8Rv-paN@gpd4>
 <aYBtydrekCC-pPL_@gpd4>
 <dbced6c4-388d-4f2e-90c3-cb2299fca34d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbced6c4-388d-4f2e-90c3-cb2299fca34d@arm.com>
X-ClientProxiedBy: ZR2P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ebe7a92-a3e5-48e1-2d5f-08de62703fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W83xjUFx09r12HJYkZIvbc5i80q/RpS2EOv04iq1bhlnKF2UbRcP2LOA/lIe?=
 =?us-ascii?Q?Kt2KV7f76g3bMdNVl8jw1nv0+W1yZa2++YF4DI2qNv/yfyxLJyCzkNkwtaZE?=
 =?us-ascii?Q?wb9tb0pg15aMZ7v0hVDPeJkSfZEx5TugwbVQXKLOygGv6cQotvOrNWAWqMHX?=
 =?us-ascii?Q?MrUqMORj0Lu02eWj4u1yO0KNFQgGUAwuq3dO9cXKosyedYmihzgNMSkbtofu?=
 =?us-ascii?Q?cCGcu+B5wzVgJu9cfMVCkmt8r2UFcydG8H9i3SdT8EhiXQ6TpJN+I7wrEvlu?=
 =?us-ascii?Q?129QTOq+BPcoBYUeEVQTe387VsjFpT0J8/8o4pm4lOdC6U0G8itrsNUmScx+?=
 =?us-ascii?Q?XfrvPCrVR/h8Xpg7+cLHrVF8pqf4t6ALd+70KNQerd6EEq2dxtTQreGghaef?=
 =?us-ascii?Q?oVqnTYktsFxR7s4VQc7BjHJheWR/z2VtKipUQhdz+XRTggm23HwkQ59ZztC7?=
 =?us-ascii?Q?Hh7vDdAb2KZCwgy4IFFyfMjHsSAPHclnzmom9A4hYxHZhBCMaip+g21XeMBE?=
 =?us-ascii?Q?Vf1k5cCXsqSgmYH4anF38jXMrz8EHWPmSZ7/lU3lSoDiMjp8EiK3w3q9dLFZ?=
 =?us-ascii?Q?JqUiBBV5vqxo7/n0boK0rTLCRDJUpJfxC4IO+JIlXF/qkqFJKoDNLZXUxszx?=
 =?us-ascii?Q?JJhWp4fKIQyeNt7M7Ps19QUMqHjLXKCDlJ/ZVhZmLTA7+38n1YGTVpUtkeEx?=
 =?us-ascii?Q?nEj+q0OPFSGnKJAvYwOyXsHN8waYrdocXK4+tCrCpa6aQzwn12iJOBXBrprQ?=
 =?us-ascii?Q?FSJyNWsC2b0jpkFEEDYnoUjAH2f3SbFlQz+d4SS9aBNAjWfwF35yy5IR7d8Y?=
 =?us-ascii?Q?2eObduNQxRnTE6Kl8I3/Gag6w2218Oa9fciwuW5neHZb69g3JJxxgV/o88SC?=
 =?us-ascii?Q?66Mjr7a9ew6CFAYUU2y9F+6iMh4tTXamw1+KXI2L95Q9aqTEmRp57sI5TfA5?=
 =?us-ascii?Q?DfbDCCbuoTZmQOC3d/O061AnDdZ+VXzVdkWbZ/mZqnDZzWO4kb17oa/x7Qjn?=
 =?us-ascii?Q?HYWt/JKupnCRAK4UFW6b0b1Dji8OdVEuXlNnHx+uZt5p33WHzhbLUQYzQQwj?=
 =?us-ascii?Q?4DsSZo+BUv0fTkXiMNeGd6rSMsKkd/6UK/8SnA+si5B8vPOp2NyrdnrvT7Gk?=
 =?us-ascii?Q?FoR+Uo7DtK/zOufbnPwemi+ljiyO0wmHVMerZlONMmDsdZCReTgWxh16ZyBK?=
 =?us-ascii?Q?kDpnmxw+pkJAlAWPKjbe86g8pEkI35PcvMWmAYmQVuyIGvhW+8Mo1UopinIY?=
 =?us-ascii?Q?QXAdihUXdV8NsIFJHaEtX3b6ny59jYfIS9YeRTzzo+4suOumhJyqwPeTCEsP?=
 =?us-ascii?Q?EEIDERtFD57uN7e20EwpJpYpg+kx0+HJquoQLag+suJ7c8j1Xs7cR27gMuLN?=
 =?us-ascii?Q?FCIFRoiGdCjbuDkDFh2iZHUgFOjadE+Nz4XrfphwIwrJX5TGhTDHqBIsrj9Z?=
 =?us-ascii?Q?7DjkHZME7E2BrvQs4FrgYhJXWOgUAOPwg2pQqHVrGhZY1ORw/ENMnJssRGv3?=
 =?us-ascii?Q?F7mE71FhpPqFQ0Yh3BNM/bA5b/zlbR3MBMTEgyI3JNS0Ftn9xNy3lqKbYKSo?=
 =?us-ascii?Q?dly434wYclJVLrmir38=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k55hOYqxuUTM+gBkun8Npfb2vYil0EndThnv+lBN6cjaZlH7/fXEGpJax/BI?=
 =?us-ascii?Q?J0Tf5vEZGxiDrzKA2eBT0x+ZNhiit6eWpVGR+D56KYFntgCdyluzpjGgcq34?=
 =?us-ascii?Q?GfC8KdNmj54iGuq7diSFXsxqpEd4tI52WsWQEXBz+Xq3GKabxrsWJAREGviU?=
 =?us-ascii?Q?OILn964CW6lYU3AnuvpRoFGHXqpccABzu6ubAPqeDG69ibEu4NEE5/BhpJQo?=
 =?us-ascii?Q?fvWprrNgo7Ss21FTWZhlw24KU/gYIbb3Ey1o3r+LP4gLgB6alq2E6oOinSja?=
 =?us-ascii?Q?KUEiE+DaJuuUMYwZc68uTgHQjoFyXefAEnTbLoXVTibwC0kG2vL9yreeMn3J?=
 =?us-ascii?Q?kUpmlQ0A7j25OTz0hmFgXutz3sTWhDn3NSWZvVyg1w9i5m/OzgLUSxQD21fO?=
 =?us-ascii?Q?NXTw+5KjgfONNFGOva6sBlpKPgcVBvjyxwiQ9hsBjzoKVK+dhpjzhC90qVcl?=
 =?us-ascii?Q?y+KpdzsF4k4VcrmsKyh+FHkB/tMEq7YGpGzCGpVMJBWPHkMVl9NkhnQY1BBc?=
 =?us-ascii?Q?xH1mImU3FihhtpPpyox4sZoQ83fdAzHwgvEFuGIpoCkdTmLC/lV1CQBrQgbg?=
 =?us-ascii?Q?J01AoOrybJetaXSlxYtwdoW5WWTq7YmXYAJCgnDVPKF1YrQYCLSt/sHk+Gf0?=
 =?us-ascii?Q?mCN+W6jgZzAR8JJ+VdET0G4B/34lMOeK967XQ1ugOaKbfpW0NbHODt+3V1vL?=
 =?us-ascii?Q?VIgsjTmt0KQTIH9P1LdndVqpgw18h/QQNLYrlXp4AiDvX6i6Dq11FCMMS0M8?=
 =?us-ascii?Q?bMiZZzbEhjyCLXjIDwsBBatzMxx92dFKYnZksSdw9Vy0GskqMr1BaAL3oxjZ?=
 =?us-ascii?Q?XnKFFJc1l6F8jzZfyrxkvnPlH6K292uOW97PT46m5RwgeTe1eWgETx0M5jzn?=
 =?us-ascii?Q?XoPCB2CacFMBwc+SXUfPVP7BnN1WBfAkex2GiNOqe9/Ll29vVgXF4g0+FR6R?=
 =?us-ascii?Q?TwcxmUVrJVGiiOzFt6Aw4TEUQUIvR+AbJK6+LE2m6Mz/F+sdtx/P3wgiWx8N?=
 =?us-ascii?Q?1nzWQFIaK/TPzMgoXMdq/cczeU/9MYl9ZA9Pqj69iaJ0s27PFx1ZcPcyUvXo?=
 =?us-ascii?Q?oiVDL4PqeJAc3OsCXBAL+QwCFLvU1haB7QUSORrqdtl0OMHi+5BIeeY/NZ0p?=
 =?us-ascii?Q?bl6TK0ecj63N2g68td7FMk1NVjkN3qB+3tAeKVHTTzcR8e4aJbECf+Ne12M6?=
 =?us-ascii?Q?/VaA4aYIKSu2OY60kUOTbv9OyDZVbyBucCtkGIcDr1/24TsHV7ivEurLefbq?=
 =?us-ascii?Q?179TjQbGLWfaQPmUwFCvZV5k7CcXVVvE5lruKqRiAWlIu/Vtrr+XZODY94Sn?=
 =?us-ascii?Q?K4gBpmehOmbd+tS5IP40lWHBfC34Ar+fL1cBwLuANPGyykqIq7VlTwU7U4wn?=
 =?us-ascii?Q?QJDaHIg9YeFngZX4lI8hd/5v7Vokiu7lrYJlFLoVi5zcSP0IK3O+gSWXfA31?=
 =?us-ascii?Q?uV/51jBgu1hfjmzmKiVYKP0KRNbQ0sjWW6Ln/XKNpYXkVd45eXTHeMdb3vuA?=
 =?us-ascii?Q?SMJ3kUmglKxAEm4Bci/qm5P2vZ9WDBbNFtYJ/ATDI2g7Qr5tFxxNdDXDW3BH?=
 =?us-ascii?Q?+jxHvDL2XB6cZ+YHFTFiCuKa1zBPyXEHA0efwE7WuofZ/68aDmiahhV+obFE?=
 =?us-ascii?Q?IDdNqZU7eR1TQE3H+wxT/dwHXyh+Et5wNf9zByDxnYYcdERmJwIxICKB3dHD?=
 =?us-ascii?Q?q8Jmsa/C4arrg0nIeaRm91ZocL9RlSHUrAes+i3tYxtcaiCN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebe7a92-a3e5-48e1-2d5f-08de62703fee
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:32:18.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4soe8v9Iop14W33N9iv5e1VPijn7IsCEYFSUyVvbDM1mZg/p/N2jlA/dGZlEZHpHvqgcmSEVNBDZ6IbDQYD+ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911

On Mon, Feb 02, 2026 at 10:02:30AM +0000, Christian Loehle wrote:
> On 2/2/26 09:26, Andrea Righi wrote:
> > On Mon, Feb 02, 2026 at 08:45:18AM +0100, Andrea Righi wrote:
> > ...
> >>> So I have finally gotten around updating scx_storm to the new semantics,
> >>> see:
> >>> https://github.com/cloehle/scx/tree/cloehle/scx-storm-qmap-insert-local-dequeue-semantics
> >>>
> >>> I don't think the new ops.dequeue() are enough to make inserts to local-on
> >>> from anywhere safe, because it's still racing with dequeue from another CPU?
> >>
> >> Yeah, with this patch set BPF schedulers get proper ops.dequeue()
> >> callbacks, but we're not fixing the usage of SCX_DSQ_LOCAL_ON from
> >> ops.dispatch().
> >>
> >> When task properties change between scx_bpf_dsq_insert() and the actual
> >> dispatch, task_can_run_on_remote_rq() can still trigger a fatal
> >> scx_error().
> >>
> >> The ops.dequeue(SCX_DEQ_SCHED_CHANGE) notifications happens after the
> >> property change, so it can't prevent already-queued dispatches from
> >> failing. The race window is between ops.dispatch() returning and
> >> dispatch_to_local_dsq() executing.
> >>
> >> We can address this in a separate patch set. One thing at a time. :)
> > 
> > Thinking more on this, the problem is that we're passing enforce=true to
> > task_can_run_on_remote_rq(), triggering a critical failure - scx_error().
> > There's a logic in task_can_run_on_remote_rq() to fallback to the global
> > DSQ, that doesn't happen if we pass enforce=true, due to scx_error().
> > 
> > However, instead of the global DSQ fallback, I was wondering if it'd be
> > better to simply re-enqueue the task - setting SCX_ENQ_REENQ - if the
> > target local DSQ isn't valid anymore when the dispatch is finalized.
> > 
> > In this way using SCX_DSQ_LOCAL_ON | cpu from ops.dispatch() would simply
> > trigger a re-enqueue when "cpu" isn't valid anymore (due to concurrent
> > affinity / migration disabled changes) and the BPF scheduler can handle
> > that in another ops.enqueue().
> > 
> > What do you think?
> 
> I think that's a lot more versatile for the BPF scheduler than using the
> global DSQ as fallback in that case, so yeah I'm all for it!
> 

Ack, I already have a working patch do to this, I'll post it as a separate
patch set.

Thanks,
-Andrea
