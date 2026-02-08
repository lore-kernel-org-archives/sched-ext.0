Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670D288D6
	for <sched-ext@lists.linux.dev>; Sun,  8 Feb 2026 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770541368; cv=fail; b=dIGfEkQ39J3PB545rITOO9GGx+6fsVZbRciZ55JwtQuS0tQ0CgvDWj6RCh2qYLh5Ai/KyB0EtL0tU1nBV2Ton813Xv9qbBhq0xHD3+O+qBY6S5M3N5Fw3U4VwjTXuAec3TThmitQneTbbqCt+kDOG/1qKFgJZLpSAnslWnHeBZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770541368; c=relaxed/simple;
	bh=bKSTAPS8k93lf4SU7r+BVc04zFRTrxVbvDPtmHVUm90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hsuKPVFsyPd2X06OHDjIcvjqxch8rq4L0dpiqkcgus2Gi1CgBLARpxnUQ2o1n0671czcRNwVGmTO66hGbl7K082EeVZNHmPEfURqEwnh7oxYP1oZCrTtpnuA0x/WnvTm9XctEChoKMfCujRRB+mRBCSTDY+OEtreoFITBYOMjRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZGMIcAAD; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZGMIcAAD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtQgu5FjWLp1hOEIPD0y7X3Zek0w5Wnsuc9DXUb3djU3RCebGEMfSNh0ROUvvWoX3kmlDWeTdY/egeW41np4x7yaEjg9YJyHseafmsXewsa65BZpW1OYoSBtSV+EiCvEzpT0qUt0692UFfoJ9ItoY8MBJxGSugDaBuxVSPvzB9qIfSzSIg3iHWXzRnLHQXWSF5YcTaNAR3D7L32YmhUrDBQv+Y/Pqu8RJlE4/d4xi+OvwP+kjRUD/QYehEZqK/0b16jlE6etz13s3rIYlpYJALejiOwBBkCjEWvQM6T9qBJ334UPCTuFQ5QUzMQCAHf4KYWdbcNEkrBJ2BmgsYcGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxhCMqk/Of7PSR3O6WQLP6FDFhAbiptQDvz41VIpoeo=;
 b=NLGIGKxKt0dMaZ8pqghXrtc2XBMuAZQPawF6kEntRg1NE2NDlYh1exssQ9rFDeDAJsIw++la0QjrXRdmRXcJBsFieY4V9CVscfcfJK7LD8seJEOZHEh7QiEoNkMVaLfIPttUEOHXNAIfytw1+/eZrFTUx4raAO2BdWjoXhXPk60779pQqSDCZQe3Jr+Mcvag2cdhwmW91hkqeEClIgmFmy1rNAMcoTGII7rtMcJQYgUQG91r1qqnCaERemg1NeR/SW6PaI4Rlrxyx22EeMiOVUioC7fVv01O+kJnhh+P2vIBodSZVrMIMfHFrlUfbnqHVeEduIB68Poz/FaE0O7HFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxhCMqk/Of7PSR3O6WQLP6FDFhAbiptQDvz41VIpoeo=;
 b=ZGMIcAADffWAd4JPKIg+Rh5FUovTcgJhLzychqwUpC8tseo2DKDnuHY9zqQTMJeC+/nVLNqxXc+WrLTS5r1smOC3pPk7rT+rRP4Gp9sAUfTlzJwGCxNUWOw0bMWUFhhrlii7fdOy0+GuRz6aW2N0F8Do1bAsCZHdAnu63yrUepIB5WwP8cNQrhIEdk9p0ENf6tdZiWqoOw4bsvHrDC+/30YsKWifYqWyvLVT6FT6jimKo3fCdEhiRwd/biN4ryytxcMkFjeTcF/9+U5rsWrSd1llKxH+8Lk0XLKj7BwNFUoIospogygJ8C35uY5OjTi0JglSc95PsHjRqJYYoGtJfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 09:02:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 09:02:40 +0000
Date: Sun, 8 Feb 2026 10:02:33 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aYhRKbkHf-or9lNO@gpd4>
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
 <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com>
 <aYcC_aKj_tO62rXZ@gpd4>
 <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8365bd-b716-49f7-4e23-08de66f0d022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mjkNd3RGlY9Am4B7KrDMJgDybiPjyHIk/ER9CNJZjoIy651w13LRBO8iG7bQ?=
 =?us-ascii?Q?TGMAi+6JEDswkAts7IT+qVv83FMEXkU4A5CsYoTnj6emSaFNJBaXD6H5KP13?=
 =?us-ascii?Q?JSNjZSLGzFHmmZ6A9KghXU73AaLr/cA6A/KAVQcx/TVooEdI+835pjnmFbn7?=
 =?us-ascii?Q?guWHwFtfmHI/kpAlvXK5pDZZzDMXtJdbGmlEPnwG5iopVmcFccBrFrDKDbSL?=
 =?us-ascii?Q?pzJUQiWbnEAnyxMPhdtRQzuYJEEzV/M/B1EXS1p2GspFlwdpgG+2+x3yrY5h?=
 =?us-ascii?Q?2376lb5e99y79/cKkf9Ev/h6XLtkjAEpq+c/YLjtC/EjrZ0aDZ1AxL4csVy/?=
 =?us-ascii?Q?mlHWy/996GeXAaQCa4Wj4VW6LZ7+zSGdrsLJZ6LwLc/NfgeJr7PXlSOOlAUY?=
 =?us-ascii?Q?s+vuCQlqkfyaC15aPcvB0El2+y2RQjA3yqpNHy+HwqD12kdG2W+YZjKFQ7sz?=
 =?us-ascii?Q?vpk1RDGNzewuD6K1HU56tauEeNtnJ+OXcgukL3SkKAyCwiB7hybEz4rOPZJL?=
 =?us-ascii?Q?bksMR1yBxiV03hLZN3wlUJTOz07OLcJt99Ak4lalaXoBHyx/VOKv+psi5EXe?=
 =?us-ascii?Q?E77gPqnbCH3sPMtlJT7CdYhQYaEwq8U/ZZS9BYWqpJrPhnXC2n821UlmufbI?=
 =?us-ascii?Q?TcSvr85/cYkcD3tpE0QrpM1ursAQ203d0Z6rua+Icp+ya3mGFbitSO4pZ3w0?=
 =?us-ascii?Q?znDUGx214Gw5ZM0P0PQENAi+K3Ud5Osdnh71q/r0xRaJeSxMe/ZNOD7R8nXz?=
 =?us-ascii?Q?kcIsfHB/hfAflUWkyP4HNSqomlEz/GB8d82Jw/b741qPyAPqUuggv0sR4BdC?=
 =?us-ascii?Q?RIJE9uVPFvQnZkILV9/AukIomWT7CCGm1/SH9kU9KC3BlDe03TWm875m1kSD?=
 =?us-ascii?Q?JFW8PQbJktyeaRRcSmVcMmdcbcqMrTnm3wyiBq8T9JTcSCle0YvGi86c0+wp?=
 =?us-ascii?Q?8rCylKX5GgzlVhZuzpG1/k/6oqs31yS3RyOd91azAyR2T4Qamkf2uSikaZMg?=
 =?us-ascii?Q?010FT1E4MGJ8j/pkr7ZM+0sTUpxJGPMFaEQXg45eklIli/t2LnYwncOLbQNB?=
 =?us-ascii?Q?WHphgnrJH8wE1n5HG986wf2pOKPXrhOM9kjvw1/BtMBl+8X6BufYlQtdL9d6?=
 =?us-ascii?Q?rb44UKrACsoh72c6kH8gTMuYYeFFjDnbJU7whNjJdWEuumRXK7LK12kaPXDH?=
 =?us-ascii?Q?ogPuy9PjtEfSC4+zQusC24DoiLVUliCLOO1BjqrbBVKPUzYPI5tN4YplxWmK?=
 =?us-ascii?Q?PGdmm9Y2YfcvMf5GV41VU2uyapeXl7d8FucuviWnHS55UfYBmxz9Mj9VunvT?=
 =?us-ascii?Q?N6pvt4YG0ENetyP9XY8QMlIrXu+SFIx42IaP0J9aLelHncmG2IaqwOzH7tAn?=
 =?us-ascii?Q?wn+5IE9ORJVLHLwINxXSsRYjzF0u0j8P58CsW5ZLer+W9UWgqLUbmW+c9vsr?=
 =?us-ascii?Q?Ec/iIGluOFZdPSIaNx7mLXqFvrUOz4InHZAOTzpdv8Ngx8iv0C35FzNtbvx4?=
 =?us-ascii?Q?kjj/n2lc9a3Hg/2VX5H+9brJj0/2h0d7BAwzTee6/LDBh+Pm0JcSSDued9my?=
 =?us-ascii?Q?mLCnZygShwhkStp/T0UYZ7vIQA59Jc+SvrxZN3Tq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2lIu6RUi99/pK+vkBCFxfLnNCzy39KH9AqxfXSyf6wsw5AVkQv9URMNtkNGc?=
 =?us-ascii?Q?CTWSFSbME36pzUQxWLmctvMX/xYeVDLIT2b9waX3SLVH5YZi0w9HdCvL+t+z?=
 =?us-ascii?Q?WC7dzQOick6FPnmKJs+1N9/vgOIZnOt2GATAMvbdXUY8LsiNDMUzNd9fcqez?=
 =?us-ascii?Q?yIiaGnV34TtJS1MkVGwN2DL8V7CxtBZi8hjGvTQ5VmkT+Ua+wbHk08l3+URa?=
 =?us-ascii?Q?e3RtpGbZ35IWosgK+5TqTbdy+5AQRhJdmCEv1zG6Js6hWfbNgdKT9LNZrxU6?=
 =?us-ascii?Q?TlASPPJIE3ZbK/5wpO9HrX1KWudBa8mUIdfjZTm8u9cS73DtgxDhrcyutc7R?=
 =?us-ascii?Q?ffn+UrNklvM5iC6mspDjSPqh+MJSdYM95tPjz1daCg4hZNr2zvsZJSOIoaKc?=
 =?us-ascii?Q?BtQ81UDou5Dy0meOd23Rq+euuROQHLyZ+h3+/t0Q22O09VAHU3mqnyQEGrsY?=
 =?us-ascii?Q?pz14IIkKiiOEXUAwLKP1Qd1qTCf0tG3BHEugQQ9Ij4OFYIIrUdI0mRgO2VFT?=
 =?us-ascii?Q?lJ+zIBuKItAt+VqEaTj8pYtHfEld54Bu0eet5Isl+ezNVT2JujDzS96jYxQE?=
 =?us-ascii?Q?IKOfOX3K6olRgjyDkBQcildUUz4SKNvN5JKXx+9aet/EMAqCY5p9+TJoiSQU?=
 =?us-ascii?Q?9mkbfrRkVm/bqRxMQ0yvzGB9GZj0e0UByDOQ+5iy9VOIbtiBM7CjWX6y55ID?=
 =?us-ascii?Q?HslMpMLH77pLqNW/coelhYKMIwyVThFBblKaSmSH9R3sza7ZJZgyQ1ve+rrB?=
 =?us-ascii?Q?FHouWDg61uPNbTXAxWwzqpZFFFICsXMxDFQ01ydjQsRGhQlpG4B5UsnPy+hw?=
 =?us-ascii?Q?gm+ep4gR1h9yLNEigaQ2EX37B+0soQLrM3katCHon4WCf0z8qlJJn8x22zvP?=
 =?us-ascii?Q?SmRU0DAOaWG09var/BuMsJO8Y7lmMAI+YmU2/bexaVW3C2bnIg3mrOMikksL?=
 =?us-ascii?Q?D3LUQbj3AnUs+D/upF+Vr/tJ+k0thiTm4QmZjBQv7fAljCwLKsI3uHBgf9uK?=
 =?us-ascii?Q?ZhwnpRl/EnL3leIV0dfJQ8s8nrxONEoOrGEnvNQkrRWH40TCXbmMMu/556+v?=
 =?us-ascii?Q?PcyB8KGn88d7MoUxCr0BvtheAW7JVX/duHRo6k6Skqz0HqSyhNfelk3BTiJm?=
 =?us-ascii?Q?dYOlwfOZJjED+Jb151aiSJDSjKVsi0mEcuF0485bDKhXxmrCRp8uro7TPgJF?=
 =?us-ascii?Q?uqEc8MgkSx+eqsdsa1DyWQLJXC0UyG9FMmR1kJymUB7Pdvj2V3o85+OI6j0u?=
 =?us-ascii?Q?SLyQk4HIT4ZkEJb4Gx12mzxGZn8gZW/w6GnrNfxzXbDAUiQavafJ0de/kG2u?=
 =?us-ascii?Q?bKhr6kLXpGQ/5mYbABmKuYPYD1FELyw7UZjx0PX8DrHHMKh/OckckmQDRCsZ?=
 =?us-ascii?Q?G+Bs7aD/omKz2hobWQlV1GgAF7NoGbkyoAXZhE2iw+qM0BNl7a+aXQlkNKFq?=
 =?us-ascii?Q?I0rr5f1RG44qDoYbYUsVJLSTyZu6E38009dmdgLouVYuCIA35gjII0vB15Ki?=
 =?us-ascii?Q?fltQ6VwmJl/YeH+p1j15qemsPUopYtZOQ8eTpRKhGn6VLAmx8fj1G+3xRM1j?=
 =?us-ascii?Q?KnvuGsHI6fQaRKqrvjXBWns4x/GzWM6YAMcT2PTIOUA30RVX9O1n8adIaBrR?=
 =?us-ascii?Q?mTBN3A1YBJXmeDhFhT5EYUCcmr8WTJyMeUmv3Easw+YgZ3DLRxnwnGbroozj?=
 =?us-ascii?Q?gHJTaDkCAeGvuNct2K/d4CZfOh4rWR2lcWtWhk6LkL7DnaCm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8365bd-b716-49f7-4e23-08de66f0d022
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 09:02:40.7406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHyGzQ6uOZVGzmeGE8KJNH8xlMKWVekeF9KxzBfeBSz8mVIpP3ZpVA/z5OAfcb6t72syc08kkkIBuWF6c6mPdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

On Sun, Feb 08, 2026 at 12:11:11AM -0500, Emil Tsalapatis wrote:
> On Sat Feb 7, 2026 at 4:16 AM EST, Andrea Righi wrote:
> > Hi Emil,
> >
> 
> Hi Andrea,
> 
> > On Fri, Feb 06, 2026 at 03:10:55PM -0500, Emil Tsalapatis wrote:
> >> On Fri Feb 6, 2026 at 8:54 AM EST, Andrea Righi wrote:
> >> 
> >> Hi Andrea,
> >> 
> >> > Add a new kselftest to validate that the new ops.dequeue() semantics
> >> > work correctly for all task lifecycle scenarios, including the
> >> > distinction between terminal DSQs (where BPF scheduler is done with the
> >> > task), user DSQs (where BPF scheduler manages the task lifecycle) and
> >> > BPF data structures, regardless of which event performs the dispatch.
> >> >
> >> > The test validates the following scenarios:
> >> >
> >> >  - From ops.select_cpu():
> >> >      - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
> >> >        the BPF scheduler entirely; they never enter BPF custody, so
> >> >        ops.dequeue() is not called,
> >> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
> >> >        bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
> >> >        not called,
> >> >      - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
> >> >        enqueue/dequeue lifecycle tracking and state machine validation
> >> >        (expects 1:1 enqueue/dequeue pairing).
> >> 
> >> Could you add a note here about why there's no equivalent to scenario 6?
> >> The differentiating factor between that and scenario 2 (nonterminal queue) is 
> >> that scx_dsq_insert_commit() is called regardless of whether the queue is terminal.
> >> And this makes sense since for non-DSQ queues the BPF scheduler can do its
> >> own tracking of enqueue/dequeue (plus it does not make too much sense to
> >> do BPF-internal enqueueing in select_cpu).
> >> 
> >> What do you think? If the above makes sense, maybe we should spell it out 
> >> in the documentation too. Maybe also add it makes no sense to enqueue
> >> in an internal BPF structure from select_cpu - the task is not yet
> >> enqueued, and would have to go through enqueue anyway.
> >
> > Oh, I just didn't think about it, we can definitely add to ops.select_cpu()
> > a scenario equivalent to scenario 6 (push task to the BPF queue).
> >
> > From a practical standpoint the benefits are questionable, but in the scope
> > of the kselftest I think it makes sense to better validate the entire state
> > machine in all cases. I'll add this scenario as well.
> >
> 
> That makes sense! Let's add it for completeness. Even if it doesn't make
> sense right now that may change in the future. For example, if we end
> up finding a good reason to add the task into an internal structure from
> .select_cpu(), we may allow the task to be explicitly marked as being in
> the BPF scheduler's custody from a kfunc. Right now we can't do that
> from select_cpu() unless we direct dispatch IIUC.

Ok, I'll send a new patch later with the new scenario included. It should
work already (if done properly in the test case), I think we don't need to
change anything in the kernel.

We may need
https://lore.kernel.org/all/20260203230639.1259869-1-arighi@nvidia.com to
avoid hitting potential affinity issues, but that's a separate thing.

I was also considerinng to include this in the series (which I have a v2),
but it's not strictly related to ops.dequeue() and it actually depends on
this ops.dequeue() change, so I think it makes sense to fix this later as a
separate patch.

> 
> >> 
> >> >
> >> >    - From ops.enqueue():
> >> >      - scenario 3 (local DSQ): same behavior as scenario 0,
> >> >      - scenario 4 (global DSQ): same behavior as scenario 1,
> >> >      - scenario 5 (user DSQ): same behavior as scenario 2,
> >> >      - scenario 6 (BPF internal queue): tasks are stored in a BPF queue
> >> >        in ops.enqueue() and consumed in ops.dispatch(); they remain in
> >> >        BPF custody until dispatch, with full lifecycle tracking and 1:1
> >> >        enqueue/dequeue validation.
> >> >
> >> > This verifies that:
> >> >  - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
> >> >  - user DSQ / internal BPF data structure dispatch has exact 1:1
> >> >    ops.enqueue()/dequeue() pairing,
> >> >  - dispatch dequeues have no flags (normal workflow),
> >> >  - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
> >> >  - no duplicate enqueues or invalid state transitions are happening,
> >> >  - ops.enqueue() and ops.select_cpu() dispatch paths behave identically.
> >> >
> >> > Cc: Tejun Heo <tj@kernel.org>
> >> > Cc: Emil Tsalapatis <emil@etsalapatis.com>
> >> > Cc: Kuba Piecuch <jpiecuch@google.com>
> >> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> >> > ---
> >> >  tools/testing/selftests/sched_ext/Makefile    |   1 +
> >> >  .../testing/selftests/sched_ext/dequeue.bpf.c | 403 ++++++++++++++++++
> >> >  tools/testing/selftests/sched_ext/dequeue.c   | 258 +++++++++++
> >> >  3 files changed, 662 insertions(+)
> >> >  create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
> >> >  create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
> >> >
> >> > diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> >> > index 5fe45f9c5f8fd..764e91edabf93 100644
> >> > --- a/tools/testing/selftests/sched_ext/Makefile
> >> > +++ b/tools/testing/selftests/sched_ext/Makefile
> >> > @@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
> >> >  
> >> >  auto-test-targets :=			\
> >> >  	create_dsq			\
> >> > +	dequeue				\
> >> >  	enq_last_no_enq_fails		\
> >> >  	ddsp_bogus_dsq_fail		\
> >> >  	ddsp_vtimelocal_fail		\
> >> > diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> >> > new file mode 100644
> >> > index 0000000000000..4ba657ba1bff5
> >> > --- /dev/null
> >> > +++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> >> > @@ -0,0 +1,403 @@
> >> > +// SPDX-License-Identifier: GPL-2.0
> >> > +/*
> >> > + * A scheduler that validates ops.dequeue() is called correctly:
> >> > + * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
> >> > + *   scheduler entirely: no ops.dequeue() should be called
> >> > + * - Tasks dispatched to user DSQs enter BPF custody: ops.dequeue() must be
> >> > + *   called when they leave custody
> >> > + * - Every ops.enqueue() for non-terminal DSQs is followed by exactly one
> >> > + *   ops.dequeue() (validate 1:1 pairing and state machine)
> >> > + *
> >> > + * Copyright (c) 2026 NVIDIA Corporation.
> >> > + */
> >> > +
> >> > +#include <scx/common.bpf.h>
> >> > +
> >> > +#define SHARED_DSQ	0
> >> > +
> >> > +/*
> >> > + * Scenario 6: BPF internal queue. Tasks are stored here from ops.enqueue()
> >> > + * and consumed from ops.dispatch(), validating that tasks not on a user DSQ
> >> > + * (only on BPF internal structures) still get ops.dequeue() when they leave.
> >> > + */
> >> > +struct {
> >> > +	__uint(type, BPF_MAP_TYPE_QUEUE);
> >> > +	__uint(max_entries, 4096);
> >> 
> >> Nit: Can we make this larger? I don't think there's any downsides. I know
> >> there's a mitigation for if the queue gets full, please see nit below.
> >
> > Sure, like 32768?
> >
> > Or we can keep it like this so we can potentially test also the fallback
> > path sometimes (mixed BPF queue dispatches + built-in DSQ dispatches).
> >
> 
> 32K makes sense. If we keep the fallback, maybe we can just add a
> WARN_ON_ONCE() equivalent that it is being triggered so that we make
> sure we don't trigger it every single time (e.g. because the BPF queue
> is misbehaving)?

Maybe we can add a bpf_queue_full_cnt counter, similarly to the other task
lifecycle counters and print it to stdout as the result of the test.

In this way, the fallback won't be considered a critical failure and we
have this metric included in the output if we need this information.

> 
> >> 
> >> > +	__type(value, s32);
> >> > +} global_queue SEC(".maps");
> >> > +
> >> > +char _license[] SEC("license") = "GPL";
> >> > +
> >> > +UEI_DEFINE(uei);
> >> > +
> >> > +/*
> >> > + * Counters to track the lifecycle of tasks:
> >> > + * - enqueue_cnt: Number of times ops.enqueue() was called
> >> > + * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
> >> > + * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no flag)
> >> > + * - change_dequeue_cnt: Number of property change dequeues
> >> > + */
> >> > +u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
> >> > +
> >> > +/*
> >> > + * Test scenarios (0-2: ops.select_cpu(), 3-6: ops.enqueue()):
> >> > + * 0) Dispatch to local DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
> >> > + *    scheduler, no dequeue callbacks)
> >> > + * 1) Dispatch to global DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
> >> > + *    scheduler, no dequeue callbacks)
> >> > + * 2) Dispatch to shared user DSQ from ops.select_cpu() (enters BPF scheduler,
> >> > + *    dequeue callbacks expected)
> >> > + * 3) Dispatch to local DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
> >> > + *    scheduler, no dequeue callbacks)
> >> > + * 4) Dispatch to global DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
> >> > + *    scheduler, no dequeue callbacks)
> >> > + * 5) Dispatch to shared user DSQ from ops.enqueue() (enters BPF scheduler,
> >> > + *    dequeue callbacks expected)
> >> > + * 6) BPF internal queue: store task PIDs in ops.enqueue(), consume in
> >> > + *    ops.dispatch() and dispatch to local DSQ (validates dequeue for tasks
> >> > + *    in BPF custody but not on a user DSQ)
> >> > + */
> >> > +u32 test_scenario;
> >> > +
> >> > +/*
> >> > + * Per-task state to track lifecycle and validate workflow semantics.
> >> > + * State transitions:
> >> > + *   NONE -> ENQUEUED (on enqueue)
> >> > + *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
> >> > + *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
> >> > + *   ENQUEUED -> NONE (on property change dequeue before dispatch)
> >> > + */
> >> > +enum task_state {
> >> > +	TASK_NONE = 0,
> >> > +	TASK_ENQUEUED,
> >> > +	TASK_DISPATCHED,
> >> > +};
> >> > +
> >> > +struct task_ctx {
> >> > +	enum task_state state; /* Current state in the workflow */
> >> > +	u64 enqueue_seq;       /* Sequence number for debugging */
> >> > +};
> >> > +
> >> > +struct {
> >> > +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> >> > +	__uint(map_flags, BPF_F_NO_PREALLOC);
> >> > +	__type(key, int);
> >> > +	__type(value, struct task_ctx);
> >> > +} task_ctx_stor SEC(".maps");
> >> > +
> >> > +static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
> >> > +{
> >> > +	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> >> > +}
> >> > +
> >> > +s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
> >> > +		   s32 prev_cpu, u64 wake_flags)
> >> > +{
> >> > +	struct task_ctx *tctx;
> >> > +
> >> > +	tctx = try_lookup_task_ctx(p);
> >> > +	if (!tctx)
> >> > +		return prev_cpu;
> >> > +
> >> > +	switch (test_scenario) {
> >> > +	case 0:
> >> > +		/*
> >> > +		 * Scenario 0: Direct dispatch to local DSQ from select_cpu.
> >> > +		 *
> >> > +		 * Task bypasses BPF scheduler entirely: no enqueue
> >> > +		 * tracking, no dequeue callbacks. Behavior should be
> >> > +		 * identical to scenario 3.
> >> > +		 */
> >> > +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> >> > +		return prev_cpu;
> >> > +
> >> > +	case 1:
> >> > +		/*
> >> > +		 * Scenario 1: Direct dispatch to global DSQ from select_cpu.
> >> > +		 *
> >> > +		 * Like scenario 0, task bypasses BPF scheduler entirely.
> >> > +		 * Behavior should be identical to scenario 4.
> >> > +		 */
> >> > +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> >> > +		return prev_cpu;
> >> > +
> >> > +	case 2:
> >> > +		/*
> >> > +		 * Scenario 2: Dispatch to shared user DSQ from select_cpu.
> >> > +		 *
> >> > +		 * Task enters BPF scheduler management: track
> >> > +		 * enqueue/dequeue lifecycle and validate state transitions.
> >> > +		 * Behavior should be identical to scenario 5.
> >> > +		 */
> >> > +		__sync_fetch_and_add(&enqueue_cnt, 1);
> >> > +
> >> > +		/*
> >> > +		 * Validate state transition: enqueue is only valid from
> >> > +		 * NONE or DISPATCHED states. Getting enqueue while in
> >> > +		 * ENQUEUED state indicates a missing dequeue.
> >> > +		 */
> >> > +		if (tctx->state == TASK_ENQUEUED)
> >> > +			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
> >> > +				      p->pid, p->comm, tctx->enqueue_seq);
> >> > +
> >> > +		/* Transition to ENQUEUED state */
> >> > +		tctx->state = TASK_ENQUEUED;
> >> > +		tctx->enqueue_seq++;
> >> > +
> >> > +		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, 0);
> >> > +		return prev_cpu;
> >> > +
> >> > +	default:
> >> > +		/*
> >> > +		 * Force all tasks through ops.enqueue().
> >> > +		 */
> >> > +		return prev_cpu;
> >> > +	}
> >> > +}
> >> > +
> >> > +void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
> >> > +{
> >> > +	struct task_ctx *tctx;
> >> > +
> >> > +	tctx = try_lookup_task_ctx(p);
> >> > +	if (!tctx)
> >> > +		return;
> >> > +
> >> > +	switch (test_scenario) {
> >> > +	case 3:
> >> > +		/*
> >> > +		 * Scenario 3: Direct dispatch to the local DSQ.
> >> > +		 *
> >> > +		 * Task bypasses BPF scheduler entirely: no enqueue
> >> > +		 * tracking, no dequeue callbacks. Don't increment counters
> >> > +		 * or validate state since the task never enters BPF
> >> > +		 * scheduler management.
> >> > +		 */
> >> > +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
> >> > +		break;
> >> > +
> >> > +	case 4:
> >> > +		/*
> >> > +		 * Scenario 4: Direct dispatch to the global DSQ.
> >> > +		 *
> >> > +		 * Like scenario 3, task bypasses BPF scheduler entirely.
> >> > +		 * SCX_DSQ_GLOBAL is a terminal DSQ, tasks dispatched to it
> >> > +		 * leave BPF custody immediately, so no dequeue callbacks
> >> > +		 * should be triggered.
> >> > +		 */
> >> > +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> >> > +		break;
> >> > +
> >> > +	case 5:
> >> > +		/*
> >> > +		 * Scenario 5: Dispatch to shared user DSQ.
> >> > +		 *
> >> > +		 * Task enters BPF scheduler management: track
> >> > +		 * enqueue/dequeue lifecycle and validate state
> >> > +		 * transitions.
> >> > +		 */
> >> > +		__sync_fetch_and_add(&enqueue_cnt, 1);
> >> > +
> >> > +		/*
> >> > +		 * Validate state transition: enqueue is only valid from
> >> > +		 * NONE or DISPATCHED states. Getting enqueue while in
> >> > +		 * ENQUEUED state indicates a missing dequeue (or stale state
> >> > +		 * from a previous scenario when the scheduler was unregistered
> >> > +		 * with tasks still on a DSQ). Reset and proceed to avoid false
> >> > +		 * positives across scenario switches.
> >> > +		 */
> >> > +		if (tctx->state == TASK_ENQUEUED)
> >> > +			tctx->state = TASK_NONE;
> >> > +
> >> > +		/* Transition to ENQUEUED state */
> >> > +		tctx->state = TASK_ENQUEUED;
> >> > +		tctx->enqueue_seq++;
> >> > +
> >> > +		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
> >> > +		break;
> >> > +
> >> > +	case 6:
> >> > +		/*
> >> > +		 * Scenario 6: Store task in BPF internal queue. Task enters
> >> > +		 * BPF custody (kernel sets SCX_TASK_NEED_DEQ). When
> >> > +		 * ops.dispatch() later pops and inserts to local DSQ,
> >> > +		 * ops.dequeue() must be called.
> >> > +		 *
> >> > +		 * If the queue is full, fallback to local DSQ. The task still
> >> > +		 * goes through QUEUED in the kernel and gets ops.dequeue()
> >> > +		 * when moved to the terminal DSQ, so we track it the same.
> >> > +		 *
> >> > +		 * If state is already ENQUEUED (e.g. task was on a DSQ when
> >> > +		 * the scheduler was unregistered in a previous scenario),
> >> > +		 * reset to NONE and proceed to avoid false positives.
> >> > +		 */
> >> > +		{
> >> > +			s32 pid = p->pid;
> >> > +
> >> > +			if (tctx->state == TASK_ENQUEUED)
> >> > +				tctx->state = TASK_NONE;
> >> > +
> >> > +			tctx->state = TASK_ENQUEUED;
> >> > +			tctx->enqueue_seq++;
> >> > +
> >> > +			/* Queue full: fallback to the global DSQ */
> >> Nit: Can we remove this fallback? This silently changes the behavior of
> >> the test, and even though it makes sense to avoid overflowing the queue,
> >> it causes the test to succeed even if for some reason the
> >> bpf_map_push_elem fails. Why not just bump the queue number to a
> >> reasonably large number amount instead?
> >
> > Hm... but if for any reason we overflow the queue we'd get a false positive
> > error: task is ignored, we trigger a stall and it looks like something is
> > wrong in ops.dequeue(). WDYT?
> >
> 
> I agree, but if we bump the queue size to a large number the probability
> of that is nonexistent: I think these test make sense to run in CI-like
> environments where there's few processes anyway, so if a queue is large
> enough there will not be enough tasks to overflow it anyway. This is an
> assumption we make for dsp_local_on, too. Maybe we can keep the fallback
> but warn when it's used (see above)?

I think keeping the fallback + report the counter of "queue full" events is
the best option.

Thanks,
-Andrea
