Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C07314A7A
	for <sched-ext@lists.linux.dev>; Mon,  9 Feb 2026 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675749; cv=fail; b=KpyAQJ+o3L/q71K4/62tbOk3Kk9AWj4x7ctlsTRti+lzPzTJkJwTtOQ4ZWO+FYobiamiHNXMqXSvriltv99za8kxsoeX4t56gQk4oueXX106Za1FM7b0H0Fpol0vKJkWeIWIIBAqw2t6NaQoc3MWq+HPQIP5g56Pf/ViEg25fL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675749; c=relaxed/simple;
	bh=JyKpSir/XhgG9Jlo6vHjjbs8tfVRAnmGy9D9wbh3CJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cammBnEedPL+pdlAsEAdSML3ekEzeYPaii4qtX5Tw7zvsUT4IJ6pQvagZf2dv5jTAk/XlxmTmjpIro4zn2+RfYaAJuwQsgfnA9LG9L1cPxv0aao6AmSzZkSuFp0aIpb+EYsG9hkUSdzQrFuZqeldwuoKoNKJaiTgPtqeztQ9bkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/QXB79W; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/QXB79W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ3zN0p338Fv8/RRmNg3z5OdJJN2B+R9PIYGkqf0EgXZnv0ZNpX7stq39IDyqHXj1Y7DqQlM6uLjxfOSqlAr3YS03hIaYKzi/VBywBl5NncgbXcRaBFODw64R5hK0gwo5Vgi4SsGFoP5Roda6/Jeo1s4UKi1xtiEqqSHwZw3zHJM+ek6b0HMoTQ84D5y/mILfJQRU9DwyXh7wquXiWItJqnOnvX/3b7x1tp6UPfM+76PmPKkW9WD+wHpgllcvY1042m3gsXFxgPTkOuvZDigqL37pUYVCCsZWgqlxh9pFBGXyZ6K3HtgbLEDp1GEHiFBr18+BIb6RAmRMgwto4bwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ISqSGWsPVPPQceDIqzgs8BS5uLXTmrmh7mQXBAY+WY=;
 b=OGgPV9ay5toPQ3UtaAKQaSRCPPbKLh7/8r3hZZzxaci4QS7PuI7BwZG/54K6auUx7oU1NWDHwPmjp85Lj7zuir9IbTtqRrKnMdYhL4vfI/ATUgjj7SYWHJQEWnxu9MDBvcEj+ncY7u8uwQX2a6p98j1xspdIZoIFcID7SO3aDn1IADYslSbiYaPbfknNcfdEI/dsoeUL6D/dkzyasOnc+mxF3PZmACS7Nyg0MNJV/iWkYUMeYMeIkaIecYzndPukupH5i++aF1BjKoFBkQIYxVr7/CNG28y3LJNv8pk2IckL3Hgh04xKevMdD0bJ+lM1SOisSg20oHoFsa842sa1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ISqSGWsPVPPQceDIqzgs8BS5uLXTmrmh7mQXBAY+WY=;
 b=t/QXB79Wn/OG2wtYtI5z4JiGL4cA8o2US4Nm2xjMd2f9dwqj1VsisWhZxQFDhIMuIU6LR0aS1f5KtBoeXHTqYqudNrcAXwF1kLXiVxghIEMtvM16yUbLyZdXsziMb7HyC+KgB47Te+DOr6J4U30umix5pueIVlehrepumXdf/8PicNfFC3AN+meMPvB05FRH3yV+/15E7KXUVBPsvMd6flg7XT8nHJc2BeaTjfOYVIbSbDIR+SLaJJSrKFJaEri2lT7AtCNNQj8DLCGVJHt1DiKSjmkCQLyWkudxevd1DWHbIfSSKLKbPCTQ9NSeYEI+iaKZ7D0cqMDrYUqdGe05Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 22:22:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 22:22:23 +0000
Date: Mon, 9 Feb 2026 23:22:19 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aYpeG8ZUHKizSLAE@gpd4>
References: <aYhkv2K99aqiuwr5@gpd4>
 <aYiVv998mfMGVMCq@gpd4>
 <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
 <aYjtOQP0tmGIqoOM@gpd4>
 <aYm00oHl3BRWNFFA@gpd4>
 <DGAIRREHTBTV.E8XTJPHQUAN8@etsalapatis.com>
 <aYoAmES8tKNZJkdx@gpd4>
 <aYoYECCY_k1IrGqp@slm.duckdns.org>
 <aYoyxIkzp0E5dL1g@gpd4>
 <aYo_NsAkKvyMoXYv@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYo_NsAkKvyMoXYv@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d23aa06-262b-495c-424c-08de6829b28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLl2nMTlf0VyMsN691RKOLGRZqRG/BlVDk0AllGalfOr8n6ohmf4SADqeeDN?=
 =?us-ascii?Q?BCuofGvbPozuo+o0xEeR9S8Z737hHXShoKoGQJC7IcVK6a2bgnQoKRec1T8E?=
 =?us-ascii?Q?kqPhA+olMjNy7DGGTTlk/eHoMWEtlgb93zfBEXRmJdF3cOT2rN98jxX2RU2V?=
 =?us-ascii?Q?KvLkBYVxZzjmQ18zM0tsnpxJMtOJn9v42J0wekNbwaGOAgm1X74ghbH5kmAC?=
 =?us-ascii?Q?CWJlx9MR08uHSKecOcgXkQGrGHEcQs1LoBPqQGWq+qG55gaUfPoN5NT6/cbj?=
 =?us-ascii?Q?TsLfmE1IWNEBWjofLbnJEOdjShhQXKW2WcWH5xDsAtP3TCCO6Y9kq2vbd0EY?=
 =?us-ascii?Q?Cr7zkgq/iuT7UsejEkDyFn3CVVVKzJxQWfL1f2YZJfQyFCYXJXjuaU7S/EYX?=
 =?us-ascii?Q?jR2iWYRZjgXff66LOEiYLRSKS5efcUKnuLtIKp3Y3fOzwP63+vsw1ncgAxaM?=
 =?us-ascii?Q?slIDadMojeZ4vG/gDg3KoGii3IfLyA+a45onHdJ56Xlr4dk4GDZHEc/7G1MA?=
 =?us-ascii?Q?x2lsK2A8gmLIe1YHo2kHfq/89NXTVwUHh26RcbRljjiaS1WO6j9ZfB5fOF1d?=
 =?us-ascii?Q?lywoYq/PZE4SZIio1eS2HsD9Hk7NXle7bvvK23TPCN7qfTXxth5hfdbFwqIf?=
 =?us-ascii?Q?JmEKGf4eQVuPIdals1Jaf2nEzWjxzOtsLe4J1BDGoLmVHa07Dy00H0GNqEvt?=
 =?us-ascii?Q?3l58FxJi7f3+Nv4XqBhJRdsvMFm9jPcSka5e1EezdSQdCSFwDA+RUVw+uLHw?=
 =?us-ascii?Q?xhz+bddbbqgBy6fFou4ed9tcjc2Fr/NyzJAZoXL2ylnq2Q+r7n1zjL1476ed?=
 =?us-ascii?Q?8llBTjLkZwv5PN76h9I+n4AWdLuI7JHI+HjzOvUNwNnENWFl09UGaRlAgKXd?=
 =?us-ascii?Q?KEDWLXu2F73nTZ18z6JWMdH+SBNUNtOa9yGYPwqYiHEv6a43yLbJzagdkUaR?=
 =?us-ascii?Q?/inAbSMAj5GBKqlptAOtFfdYXvdlG5V/X43vgtqpHR7J/R7Hk9tsRejwQJ8q?=
 =?us-ascii?Q?xfKTnUyHtjU206PtlDpU3Rg/42P9X67Pii9tFHrYYz5mvbwKLKzh2erpFNpl?=
 =?us-ascii?Q?VER5PhzVnh1NpsT2lGygQLQPadPGjc75qWe7vVzywNWKfK0qKQagoShTyqDj?=
 =?us-ascii?Q?DgnxTtXMVum/1E/huwaWyKtIQaKHk2ZvO2J7we652TdeDHvELg8xAMC2gF44?=
 =?us-ascii?Q?VC4M+TYR54pAgs7sWvwMpZGsDPaTyvs47JLnX4uLS+4PXEytZokEQFlGhj15?=
 =?us-ascii?Q?Vo70T8y72ud3mTuCwWWtWRYb7a01vmD+bRnzPdS/QaqwIID8KpoPLY8DTtKG?=
 =?us-ascii?Q?WxcpHCShxFOtVZxeYCWNLGPqWHDlTRQPKLbPOO8oyk552ToekcNFWo+VYjZ2?=
 =?us-ascii?Q?qnqKUn0xVBnq20ZqPlyENMMpc55VjJGCxtGhxyvsd8jgCyCd9/RgDIdPjftZ?=
 =?us-ascii?Q?qtwrLLucIVKpfMxCAGABMF8QuWDeD3tJ5oQfQHXnx4gCH2z2eQxi1i+frEBT?=
 =?us-ascii?Q?xyJ03YYZTsU7uc6fZE97cGl1bZhNXjw8Y+a2Ho/yc94U1tM2jsZXPC4cO7Pa?=
 =?us-ascii?Q?+jrbbO96CwpPNG6qBLI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AzOHJ+rhCSXRBtOxKt/3eheyQoDpZ8A12pknZfae0U2lFdUWhXkFF/eiEk9a?=
 =?us-ascii?Q?kD8baC/7j+8M7Oprxkm5Ipp3hQE5BjjKjzlfi9sGlF6FarsvvvkW7pvkZshT?=
 =?us-ascii?Q?x7zrzj0eoMQV7gtl2kdttERUmMjs8q+coqfK5Q3xl5CLEljcHDPNyrMYTRp5?=
 =?us-ascii?Q?jKXll/TCCAjeJvOiYJb/FOXnqQxpmqPoMZnL/SCSgB+hZOkWeKXQYVwFOIKM?=
 =?us-ascii?Q?hRMmwkwPAZyoy5ORARey6rQ8lWZTX1+NXKJClq7DgVuUeKmCHJ5c7ZJGRI4/?=
 =?us-ascii?Q?14KhcvHUROIeHqJ0o3Ec60pr2vSG7jFZt9bdG3ByZt/6VzWxp9e8A1nG2Vc1?=
 =?us-ascii?Q?BVNBIh28m7UK1rAC/ZNsqzlkc9YopmQ38MZrrtGzNbhHn4/W2xvr9EvHXGxP?=
 =?us-ascii?Q?st3fu0fw6BSbeKwA4gUTFm3o59Lc6FvE8Rvbmy8skzOs1Ax4f2nogNt+P2gf?=
 =?us-ascii?Q?xn6Sbm1iVcqXgS+/YCj+coKjQwYURbqdfNyBD8RXeSkYNDM49lCTpJeTHdBj?=
 =?us-ascii?Q?bEQN+u4FIyj89vONT5EJo+6/tP2fj85pZoFRqC+J6OrPFka6qXXKgWAxaL5U?=
 =?us-ascii?Q?kJ8b7NLUG0lieKETw7S2Q6bPtvFL2dQhB0X4hvLBWXKAijUdsYEN+OxQgeyH?=
 =?us-ascii?Q?TfkmY7WhUQlTfuyXqbHU8rkQSoeKtksddsN4wvo2QI0CLQaO8hXdZ+J6O3eu?=
 =?us-ascii?Q?y9QCK+aNSGf1BLLiGcrqtUe+pP8H0Jeg5r1APDqCrel88CZ4dCv0hM2G9YPU?=
 =?us-ascii?Q?Wl6PXZO/+cJ4Ut3vov0IZ+oSmL+KFhjoOgUuNuUn/ijoss+zbMCjmSYPvehU?=
 =?us-ascii?Q?evXNVdX+rFg8KFYzwly2mvigAvhvYVc/hmToRuzZhbG8aCbNtNA/j725bpMH?=
 =?us-ascii?Q?63mg6wDqFU32FE2IiYAyKlV2O2fRQCUscwb62e3aRTrPHCoPFjBZlPFYbVe0?=
 =?us-ascii?Q?n6n9sma+LM9L+3xeP/kx9VetqkBmRnZu2mNlh52YlKiDsfLNVBhUvOZNinAA?=
 =?us-ascii?Q?2fR/7dSrgG1wmDpVIxX4eyvU7iyx6b2A9t+0Dapf+AuXzlMJlKkWg4M35ZIf?=
 =?us-ascii?Q?VUOS3Sai/9NkeeRciTNRRAUKNE8HILkDEjPo/IAj7yKoLWjMgLlvJU2XShTB?=
 =?us-ascii?Q?gFhF2twVGaI4KKyNNm48+QK0gTHwWnzkE8992g+umYV4jNsQRPgOBuSd2FBb?=
 =?us-ascii?Q?IxfFcOkeBcMpZfjZzZGj8BDofeSGoJLVe91ltCd80MoaCOM14jje5XK97pJh?=
 =?us-ascii?Q?THCPscWN2B0xnJdJ/gPIPAw6hAZA0UDPpmV2SS0gkcsBiPavZ3lfhBxpDfiC?=
 =?us-ascii?Q?E+SNYA6lSgsMF0Ml/r/Ruy8D3D+/R1ciWcLQfA/MjOfSuDH1LmIRjyTiIeDC?=
 =?us-ascii?Q?Y323MsxJnSXqtr+ZW57uSWsVbkEPaU03sgMpyTujZvFiIMwxMzKVBBX4PJlD?=
 =?us-ascii?Q?UTNgeIKfdfi/Wf8hxc5PIvcfTaZt9YZKshtWox1WuoFpMO8FUPL+5E6yMEij?=
 =?us-ascii?Q?AEYQzB5kbQMGOHE6wMgw5N2U1cX6fgYyms9oAXz6QELvD+SEK6shIksnOBU5?=
 =?us-ascii?Q?1UtbH3j2TcSqZPoRLwrktmYjFBcwErca0bt0hOqEX7KfhFoMpm9YNQzwUeVP?=
 =?us-ascii?Q?WRmUiYdbR01sKn5AQkzDwEMfDp+HEjrtVIT2d9ElFp+pkuTAjerrbYzpntuB?=
 =?us-ascii?Q?Uof4vt2YxOZYNb515cVuNeWOuQzpgmfVM4LjISgd55es84jU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d23aa06-262b-495c-424c-08de6829b28c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 22:22:23.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PopN8r29DUL7KgAaSJWVVAdua9F6LPfzJfEFEAETPXubWzQuVKBTRmm+yXFJLHcrmhpyiXwSaDYijqQGtJle2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260

On Mon, Feb 09, 2026 at 10:10:30AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 09, 2026 at 08:17:24PM +0100, Andrea Righi wrote:
> > Agreed. And just to be clear, for the purpose of triggering ops.dequeue(),
> > **all** direct dispatches from ops.select_cpu() should be consistently
> > ignored, including dispatches to user DSQs. I'll update this behavior in
> > the next version, because this one treats direct dispatches to user DSQs
> > from ops.select_cpu() as if the task is in the scheduler's custody, which
> > shouldn't be the case for consistency.
> 
> I'm not sure about that. ops.select_cpu() doing direct dispatch is just a
> shortcut and should be treated like the same operation being done at the
> head of ops.enqueue(). That's what's happening semantically and I think we
> should stick with what's happening underneath - ie. make ops.select_cpu()'s
> shortcut the special case, not whether tasks in a user DSQ get ops.dequeue()
> or not.

Ok, what you're saying is that a direct dispatch from ops.select_cpu() is
just a shortcut for work that would otherwise happen at the head of
ops.enqueue().

So, while ops.select_cpu() itself is not "being in scheduler custody", the
semantic operation of dispatching a task is still the scheduler taking
control of the task. As a result, a dispatch to a user DSQ from
ops.select_cpu() should be treated the same as a dispatch to a user DSQ
from ops.enqueue() for the purpose of triggering ops.dequeue(). The fact
that this happens in ops.select_cpu() rather than ops.enqueue() is an
implementation detail, not a semantic boundary.

Under this interpretation, storing a task in BPF internal data structures
from ops.select_cpu() should not trigger ops.dequeue(), since the task has
not been put under scheduler control yet. However, dispatching a task to a
user DSQ, regardless of whether it happens from ops.select_cpu() or
ops.enqueue(), does explicitly place the task in the scheduler's custody.

If this matches what you mean, then I agree with this approach.

Thanks,
-Andrea
