Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE2DDA9
	for <sched-ext@lists.linux.dev>; Sat, 13 Dec 2025 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765588619; cv=fail; b=Qod9EIUYhoH5skHlr65IcZ42xM2Q/mQ9aiCQ5ba0sc79OZBuqhMAJ7E2SSAabx/3xQZve6+jiemWaSaRwtuI9Pq0rymDoEYPP9eRhehEhdLnxbN+J548UOmSwSB332W/YkpB9PP8odPkeA26kcHlsADTU3TGdhYUrTnznss9Pdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765588619; c=relaxed/simple;
	bh=Oq/a4jS82NQWxgE8hDV6IMrkCHug9W6ghoWfCNxPkaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dEcKgY+S66SIP3Sxva5+TwzadLXHZCVnsVRDlU+zuxCQNw04L3TNKGUKkT2BiCEyjYaI0Vp+gM5sWv0pcajwfqT8cbvmrdntNCmX155Y+dtNyTFiAkw9ITFaK2/yBDUqeBrDAb9dLEeHakKZEehtd3SUbv/lbJO4VzPIfUkSk+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q+ehlkI4; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q+ehlkI4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqUWdvCXSldXzlypTSFyqCdDfuMhax2c2r8CqDMCAcS2zMguTyTPxxSidD5h6asqM2kht/sILx7bBJaAl76naOeQ7VK8WbGVj7VaZu3R9DTpR6KGxw/GiCPV+7cb2DSzf9C+hUKRMg/qDqFEU8Tc8S6J4pUdHxrPvlVEJrUW8o9LGVsX4taL/RXJwU9rX1a2Ulq3Z/ZJBWLwOmHGT70jHRGRiiMYvOoJDyXAWWr/YS/03Y3m1Ncuxu9YsB98H9pMikdSGNhOuKvyT329bMXRSTT6gpjD1rBqTWrv/ozOrEPd/WN6/1TD8lDJSCbEIBHQIvFUhn4T9bfVevGouH0sjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z7NFhTkRF8G4ikM/gPfZzUilk86Oul0yrk6bNTRkYE=;
 b=F1Kc4ziOPV7lp3j8XAUzbpUhrr1Ir+PifmVDAY0WfDD9NnkTaC1mtFOZV9goA4wTbmECQavGma9EH106Jf0O0DyPe6Z5Z461Kw7m0eFSSwsW+g4fqoNt7CPiTz2JeDjfVyvYDnButnJ9Rxn8GLIOcmkU3JI7xKe4NxO/r4VEAXLFH+ba9dkkrm3XK+/qGt/KtyF30Mff+3/M+P6CvF6f3EmcKwUzQMgNTCY5E8scoYjxZjDQIH/awJzf3lCsi85oOuHcZSLou7fKyHU5dooCufhKZ7xyp30+fLiSsciqdf6Dcia6PiKpjwTu8ARbWlz+LJLb2BGf4BMpNtHedfRMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z7NFhTkRF8G4ikM/gPfZzUilk86Oul0yrk6bNTRkYE=;
 b=q+ehlkI4WA+/rCM+RpncmO24gQ1zab5umR/9VgEu5jqsYobl2PhVwbClzJfUql/rYSrmKPTUrMW/L7PgkBPpv+VC+26zrcZ0OnwOp8tPhq3wZ0t+UfZT2A34aGL9mE7kA+Nn71T5PRGHY0wVqVC7CkVRZE86jfbc/27KObgjZLB9WbFK0jGyKxNROFUsLQeNOvgQZwitbmpV7WJqwmnkJ4B1U2NhqZsZcjeDg50liWlalXZq5odfOTxnV3P6Qc8cFvkG0zMG3Qi0XM9GZMuRY98n70vfmYSpnie6sgg8S/AT5hkrXwT7fMu/bjXRALSGOzm0azlFE+WelR3QCoM7Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Sat, 13 Dec
 2025 01:16:53 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4%5]) with mapi id 15.20.9412.005; Sat, 13 Dec 2025
 01:16:53 +0000
Date: Sat, 13 Dec 2025 02:16:44 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH v3 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aTy-fFNjiVfMZ-cP@gpd4>
References: <20251025001849.1915635-1-tj@kernel.org>
 <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
 <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
 <DEVGF29ONM1A.CCTFEV5OZI9D@google.com>
 <aTruf0rK94ujYH0f@slm.duckdns.org>
 <aTrvRpr8yblKXlP7@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTrvRpr8yblKXlP7@slm.duckdns.org>
X-ClientProxiedBy: TY4P286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::14) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 489de9b6-56eb-4b1a-4818-08de39e54c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?voMwNEw7OHnKeJzdzstqpkeZZxpUrSAdQrnUKrVtmjSqUG4ti3DWmK55L3m/?=
 =?us-ascii?Q?YIBvHFP8pABTxpxtmnkMU72BS11GdRdMo+vsr56W495szobwqtWnpkPwd0ud?=
 =?us-ascii?Q?se63AlDVTQjT2ZS5pZuR4vpygHoQ7GXUwOMJu1J+7DWIbusGL1gOPVtfjo6d?=
 =?us-ascii?Q?gt0uncSkBaboUBgRyQdhfexNoLAk1qUB4c+wfY3uUeW1MLg4+cANH8b5e0B8?=
 =?us-ascii?Q?EgE1R82hra7ylNcJl0rOQOvumRrHSHBZjMGO6vJC3eWmXHeGDRFfRukmYEPI?=
 =?us-ascii?Q?MO3GymW+cSPy+C0zZ1dm0Efs9eM0WIeQsunpExJX60WjTe9nAcFxzdVDaJGv?=
 =?us-ascii?Q?CnOxm4IfcuiQDiWUdyFgrgUUTDmxfhq1wh80QGL0HSsBu/2SbEekOAzXQjrj?=
 =?us-ascii?Q?dLFL+757keX16lFZFhUyRW35BRsZpLKaOnsTvunA9ZjLpHcBt2nO/wBSTwd5?=
 =?us-ascii?Q?tuTiSxLscT0OgoB44khuO4jppiYTjYjcqrKx4YpPeCBYTpsd0+9jRuVfPrVt?=
 =?us-ascii?Q?byaDtTZk0wxAEmzU3E8ijwKUXzs5kZEFcm5KGMFhyFoAcj6dIi3efyBPyFeh?=
 =?us-ascii?Q?SAw4vW9aRoNJicnXp0TCzkUdY2Hk1X65kBIcjTIBxfNLvdhQHCEJtZ9A3NMN?=
 =?us-ascii?Q?Gq+JylDtdNIW3y2aFcWKV82n7G/IwwuaWUKo/WcnN0WXs5Qw/66EZCEx/xri?=
 =?us-ascii?Q?lnomUdIW51RsmjuNHQRVJU1p062jiJIMF7SKjDcaXSNEg6p8VKjU+oF4hIR6?=
 =?us-ascii?Q?4NKgKdlxnZNoi4fJBV64mh0QD84hy/axOyp8fOVi2xE1OhRYET/LBe56N0/A?=
 =?us-ascii?Q?DAE3sYvQxONF7xEbc+i9Yk1faFiBPol+Eeuj1z6o+J3q32anqul2JTQiCNk2?=
 =?us-ascii?Q?LkGb1Frk9B6fxWsqCs5bQofRt58c/2Qh4nTNLUjrnA4ZK7XlwL6/eWPtE0Dk?=
 =?us-ascii?Q?tE4dGswGDbNuWpjfCTl580u8SrRsLy51KpoEAT2qHgKVWE1ojes+aXaBKeKJ?=
 =?us-ascii?Q?2z1Rn/qfKWNyPo9K7UkFJ8enJhbftrYs1+g3gjJLMBfBF+Lmk2Jeq2lJ0jPv?=
 =?us-ascii?Q?u2BfC1rnPI44nutVyupoEEopEreRgxUBLP7cRXlQnfjfhDV3fX5Ix7n34/ll?=
 =?us-ascii?Q?nKku9c0SSM7wF9xBha+1shINEBo1YejNvyJ2EPVl985FDqK6j1aNxySpZZ7E?=
 =?us-ascii?Q?bi/+ehlH1ZED20z+67ZSIQTJgy+AzKKN8fv9J4O6XpRXc+te2jnUXB91meWE?=
 =?us-ascii?Q?fGnH2sy3isX5e+NrMjZjlmc/RuROzdM+w6EzQnh5d2gyGMHh4VlVRXhR7oIL?=
 =?us-ascii?Q?Gj1A7BjOjRcXnARmXFh4ARnlkvv3oxFLlhX+hd3c04Y4+gEOptQSD1Ne2fdH?=
 =?us-ascii?Q?xy9Amu1vEIoi2fHxNNrpw7FnoC5MqdNadMZ60UPlmSzW1jyGrb2d+pSP+kH6?=
 =?us-ascii?Q?gRQn/SNy2AUomaGvOKrOxVCysxbSrtZW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vf6OsZkXpcdxc18HAXYaYQh0GYp5bSkHg/oUEt0yCNYEOwjex/Zrf/3jXfn+?=
 =?us-ascii?Q?oRr+/ffUeYmNjYvhICs6XzLnCE4qEEOWM8rANHEdZgkoluZgXqbg/bSZrg8p?=
 =?us-ascii?Q?CVq5cJAW6Pg4OXIadWNj7S3V71502nz5/2GFU8S/0rDPSmYimmVImprDBjnq?=
 =?us-ascii?Q?5cK2GHQOnZ+eE+jTqO2o+NM9ONQz1hWlxPxNRhC73Njz8A/pSnOEvtR5jB8/?=
 =?us-ascii?Q?ejxz8/1SI1eslHDGkN++7jL3NeWYTsT+b9nTpFjhFb5UCkMDlgEhP50F5boG?=
 =?us-ascii?Q?fX1TqYiph4Xpa2BnzkZBhnjW1c/NFUxDZ/1FH8DjPd5tiUKfaX3CfzCeHu5/?=
 =?us-ascii?Q?yfsnjRJqhjrMHLYxSBxZ5jkPs0PyvAScyDm1z/RWQTliZTtvBx55W6QHQYzw?=
 =?us-ascii?Q?vW1qLeE2qNd89VSL/ytY21f3GHr0y54EeB5L5IbqqQmP8MWZ+LsUHWWucXGS?=
 =?us-ascii?Q?DqgMVSHud6PB7u8pbk5FQvNWluJxY2qVJI1tp2cSAxf057mx+ysaZkO/nPK7?=
 =?us-ascii?Q?ptHHyBst4tBl8I8aYNwd3muQ3gK/cJPg/bbbKnGjSw0N4dFKw3Jh4Kmy4DV+?=
 =?us-ascii?Q?jtWPuFZEXRKxdNE4abGHqJL2ZGnB2m7hmeQloLeQcKJVGlOFmwYY4mYiMD9+?=
 =?us-ascii?Q?6EOmyA2IoXrqoh5NDxUXnkM/vWugBDnEXlSdRz4aQ/+cBpFh7XqFAP39pSYT?=
 =?us-ascii?Q?QSM49IgZjdLOwlKaP+LENbh91331eJOIijubCtuBj8C056IjRP1Queqm/UJO?=
 =?us-ascii?Q?gjO774ewsip8k2uhkwzW22HXRQtX1ihX9dBWmrcucKo1mQWNqxz5EGqG+duX?=
 =?us-ascii?Q?kxT9Wn3hgjKnQ9gdssD6tR2cKShJ/D3wMzvkjYMzJfeYLmwuOmCR4g9IG4rx?=
 =?us-ascii?Q?g8VvFCTILYr8PyJYrey1d3KE6bdXBaRtKv2Tygsqx2IXek5+0T+Y/5F1+Z+g?=
 =?us-ascii?Q?qxTF9r+8oJz9+zKzZXFsZW1L7s35ktDp8hCXK8DlaucnjbRGgoMw1JKRAuHj?=
 =?us-ascii?Q?W82uts6vmEBxKkl8Q25l26ahpvSdvai075JSkepJNz6DFBGpFhWpgHoSf5OR?=
 =?us-ascii?Q?/q86uSzssXaezEDYr7ctik+XaY2kQW5nTnzYPSJdjhBCWbXerc0dvLcRQXMR?=
 =?us-ascii?Q?0oXI1xbXAtK4sJKi7bA4hRsVeY4DapSyx+c7vVOmTFQkgElpT+RCiDLfOqM9?=
 =?us-ascii?Q?qHPsHEvJ8PIlElKlt27CeTc9RCOsZHx9SC3TF8xCKDL9Jg7nI33cPK54wsPg?=
 =?us-ascii?Q?zBspooX4ErfTBEMxLO4K3biRCLy86ODrMddrkUnBO7/9+SG3IX0p9ZSCbVQl?=
 =?us-ascii?Q?7wkeVOzWqdcPH+iArVSqTRS3vy8pIGBEDeEQkgeKE3WyIzWG3609bQPjumdA?=
 =?us-ascii?Q?aAkibEQJODx1rr/Dd1gjfxKGVqHfFrKOgzUfvdleQTR+q6dbtZpZze/rzNHo?=
 =?us-ascii?Q?y5HeQ0FSf8UYKr+zC8jVbCRzISsuLHI/6A3rWf2dU91UfPIMAmJ6wlKLUpzR?=
 =?us-ascii?Q?N6UXISylKzL0kDZZOkaxHa0YwGoYm9xS/hv0VsmjUNjG3qS2pDa1QAhgA9S6?=
 =?us-ascii?Q?b9HRr/ExOK1bkAU/k40AAjAoYxUG6EyFSliBqayV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489de9b6-56eb-4b1a-4818-08de39e54c9b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 01:16:53.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8uv4Ip6aaK8D3OzyEj+XpiTVw3XT/Zo7MpH4xq0RvRKwbuhUOEZ7cNEQqLHiItc247yG6+MRosGRAmnrY1ffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714

On Thu, Dec 11, 2025 at 06:20:22AM -1000, Tejun Heo wrote:
> On Thu, Dec 11, 2025 at 06:17:03AM -1000, Tejun Heo wrote:
> > Hello, Kuba.
> > 
> > On Thu, Dec 11, 2025 at 02:24:04PM +0000, Kuba Piecuch wrote:
> > > Since we're doing a direct dispatch, the user scheduler task will be
> > > inserted into the dispatch queue in enable_task_scx(), without dropping the rq
> > > lock between example_enqueue() and the insertion, which means reenq_local()
> > > will run afterwards (since it's deferred using irq_work), removing all tasks
> > > from the DSQ, including the userspace scheduler.
> > > 
> > > A similar problem arises even if we don't do direct dispatch and drop the rq
> > > lock after example_enqueue(): since dispatching and reenq_local() are deferred
> > > using different irq_work entries, and irq_work_run() processes entries from
> > > newest to oldest, dispatching will be handled before reenq_local(), yielding
> > > the same result.
> > 
> > Oh yeah, the asynchronity can become pretty confusing.
> > 
> > > The user may be unaware of this behavior (it's not mentioned anywhere) and
> > > expect the reenqueue to happen before dispatching the new task.
> > > 
> > > I think at the very least we should make users aware of this in the comment
> > > for scx_bpf_reenqueue_local___v2().
> > 
> > Documentation is always helpful but I wonder whether this can be improved by
> > the reenqueue function capturing the dsq seq number and re-enqueueing only
> > the ones that were enqueued before the reenqueue was called.
> 
> That doesn't fix the ordering problem in the other direction, but the
> reordering in the other direction seems inherently less useful at least.
> Maybe this can also be solved with seq - ie. make enqueue record the current
> seq, mark the DSQ with the latest reenqueue seq and at enqueue commit time
> if the captured seq is alreaddy reenqueued, trigger reenqueue.

How about making it even more explicit renaming the kfunc to something like
scx_bpf_async_reenqueue_local() (and documenting it)?

Thanks,
-Andrea
