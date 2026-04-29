Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DD2FE560
	for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471926; cv=fail; b=LGjPZstBIIbHED3hwiEhsy/PfGmtG0Et7uVFMqbWqaGaiexLStJNumcK+eF2l3JAkbGeA6n9IO7ie0egmzRjzYaWoky1TDLlWinDxqfNj91xistKs5sDJoe91fTPcf+y7H3jdnZaMoEF71HnNWVqemdtUXwpFUumTd+ijruefLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471926; c=relaxed/simple;
	bh=dJ/7fBUzxTU+lyF02TyPIJ5TqoGiKG8FEe6xjolNRDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OgOk5E3rjXfmVbaqMa3ZcUbLNEH1GPYZWxiE8YkxlEGhu69hR3nw/x5CgpnAs0zq0Pxfm9l6OZdOAN3td8wrAEOG4/Xz49GoYX1R8BG29vnxWOFnqREE3gK1NVggRUNj6kOdogFdrY/Um1jRLIWD2PERXB4eSHw3/plA2q20/T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NRlnkXPh; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NRlnkXPh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TySI2zejEAmh+2E/QUjTCEX2tSdSowzsEk/AgMbeeho7tzAoUI5gCCmBhRze3Rx1wxA1W+kf1HxfqgUcGcpXVzcwrKC58dBt1rk1dmd+fiJz8o1Np1ciwXZlIkn1SjauBXHLC8LITeos+etmFc7t5n5XZJt1bOmO4qiWpA497+WloptkjyXBdndFlCwc7dBYt5fjXUKpXBKLdAbP4Kjgxt9fJXvCiQMNMTFac5vyJNCMT8xaeV0790ZYhjx2zWgX8i/pCVOFeJ2MOqS1pm4qSW50m7ripEePYbDx3u1+sPG7dpFp2euScsd2VP47GV56cQuXIXHFg/vdVtLUqQk5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ntu12QZ+XVxVQYC0CRzF05P35Yk6GBjaFFbqS3cZZrw=;
 b=dWVCvtL2jwRzb3C6Wrgbd0dJZEHP0q3HD+DfcKclJHLyFmGwEwOrMne6tf0USMWZFM3XxtfgiOL+/bAZx073N5TRazvx+uiHluEOOqgfh8Tc2m046zJ5Tkwm79Yy5PiBe4odF005awTukTBYV3RmqM6anZo+oQFWyFR+OYwirB5uI994xUzX6Ry7XFyiv9YrSdVv3o6+7FlazwrAtWNervzRRR722I8AOzMbThb9ZNxI97rr0tlFy9vghIkXKqaGzjp6TmTTQ7x+10ocu18RbUngsrnv+gteup7D91jyK/PgcGV6UMn+rPeai8iNvrYlejo7Ed8UXqwlmQOn+CpIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ntu12QZ+XVxVQYC0CRzF05P35Yk6GBjaFFbqS3cZZrw=;
 b=NRlnkXPhAQb/1Qzi6jP/zNnvjpNKe7NAsM1mgFsYt1L2BFS4gR6fAS0wlaA2bHt8tSL7b2z+Dz2MIxtrZm6hLHMXtJCbCrG9CTlGvxQR/qoDz5xAAmGEVAfVAUZjEJLT1Evde8xwAJrlbU1F2CddJETvOB8PhUqvAmesXDOEzAZXWGx88oT1+wzNmUD9eAhmfYjX1p40COMxzHt7Re8l1e8KkzyRct1ufaESIsVPigNC0EFnloW0Bk45/SpLEYygYqgR3840ALzLfHilMcwcEn2gaLn6oA0Xnpr9stGPo054ZPzlnmtPmnS7CMQcrUGVnB0gWOZHNSFZwja6Gx0ieA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 14:12:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 14:12:00 +0000
Date: Wed, 29 Apr 2026 16:11:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Topological CPU IDs
 and cid-form struct_ops
Message-ID: <afIRqTwn7UbMo2v0@gpd4>
References: <20260428203545.181052-1-tj@kernel.org>
 <afIHuXXJWHEJnzaO@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afIHuXXJWHEJnzaO@gpd4>
X-ClientProxiedBy: MI3PEPF00004EA8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44c) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 954a66b3-6616-4050-edf7-08dea5f947e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	03CdAEzTJAJn+DxewhLs1tdhKA+Nkzdy3xWwvZDMNpvcJmuzxcjMAIgNjUEjLse1gfsrLUES1AqtyyVKmjcE5052yyrw13Rz9bHx0QE7Cby18aV8ofa1hc+nTYcIEKjk3davnlx/OElWMthAAQQlQt5NHHb87PR3WSadxqrymgQpI2BhwI2itPgDjU1BxeBnBJD9zIoL0oZcfnj1tnUpaOea46OagTGzd3XtQnpRX+3sxpDkWYt9f7HIigl3MO2M+18HJ4U4sesRdRFltJDzE1ug+udQFIXvCAzfpkYniu31sEpKODayS8uNY6egdqHpySo5lA2qZoVAVJM7z39JpXoPD0vlb+h+lIrCdbeToFAQH5BcHj+t0R6teYKNRuyo0KM0mFVDnH/mCcdw3Z1cSEOgYyyQOuuKbr6idz9KZt7o31UKcXSJhf/b4C7Uwd7DbS5UZsEeNo3W7VdtTLaHzZ+2R1X1K4BJ40ClVJXefVv5Lrzzg2ahL+KzwpH1carxLY9OudDuXMWXnXfUyt9PvYJzTggODi9ROgqAMk8lri1YxCoUBoHCmW9MQajD+xqu0aLTDNE3Vs4Y1+OdFd51QO+ipDr4SU0l2N8GkTBougyUdWuDLYZyan5pefB9lFsGcFsnKqkFdzhDfFjT0jSG2jaXFWTuNHl0LxwZtiXYzbcOACcVJDMRfKF61qCf3BECjPa2LVR3XBt90xOGCeOKapNjjV7JrcUHiVgYoj73yIQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXmOw/Tvrn8WOhFQDevo4loIjP/Diu0/T+KPZhiknZUDOfmOoWroftAvvCXG?=
 =?us-ascii?Q?vK5zMzWUF0ZOUdsIXm6V/1tqGj8QNBG6tezvh3xJavSvTYHL/A2H1Py0ryv5?=
 =?us-ascii?Q?rqhu/uSuzg819kS5x3DMVTk3jN6Df2ngW6GIn0WN5bpBe4/00UoYjXQW/7GT?=
 =?us-ascii?Q?cdU+pQyWRY7410hFm2vAFmhcfybOQb7/PxAKF+2i4mmMbGDsz+FsURAXgKlw?=
 =?us-ascii?Q?cw6i8kom0dJCiLGRC8hHCryjspW9YznjnERreZn8MAIZIgWUDztzNORKcNPv?=
 =?us-ascii?Q?VKv5JWIR0+RUCkfahk3mkKuc8H30Z/BBMR0Z/Wd58I6sdk92x1RChpozClD6?=
 =?us-ascii?Q?9sQWj/X5HRScZH/Sm5VvJBO/v1D5jBLx9fXVoRrEzVCKd9q5U83e7OXmxsYy?=
 =?us-ascii?Q?+t0SHOYqhX/hAqgd/jWJXd2vSAkJKWHtq+HEMUTK6fW5oHeMRJ+oy9Cdmk0x?=
 =?us-ascii?Q?ia5asGYcJzxcsOa79vC9lrIALQTjMkO8hpkW93YUPaQT2kicL3LQVayrCwua?=
 =?us-ascii?Q?yW0yWV89tNGrOiZ1Axbnq/oOxTwvi/mXieBEcpqLS3EUn7GOrK7jqMnyp5h5?=
 =?us-ascii?Q?aMJ7EyepOjKz7wBLU9dxdkO+KQkDi3LI+C9vjyAs+A8dvOSduBfILWJKe5G+?=
 =?us-ascii?Q?+40y2DB8n/d+otaEIjArA6YDAw57YHMFZovCeYyj5LAtJr226Wv2zY+nXaQh?=
 =?us-ascii?Q?IaFM/INHmCVLXoqbsAOlX4C0X3oSpEp+y5N4uDR2C2140HqbW+eXfMgF34uq?=
 =?us-ascii?Q?kSrBJq3bQ8HH8tniQwNYy3avpnY9Kdw1IYjaZ96QZ54F+BiWoABMF1jCziMX?=
 =?us-ascii?Q?a7aUr9wwA/4XFiCA2b79eE36PPMT1khhSjAVeQfzfjCcyJJWm9dhrMBoyYIP?=
 =?us-ascii?Q?IBReUhEm4M9szz5C6C768Sks1q7n5Yx/k5BAKJzdxzjuq1/kYGgJio1FsRRx?=
 =?us-ascii?Q?T2bjyvDQsErp+ntZMvD97wIGacDWpyqOIHngC0AgkJD4hBfS4Oxf0pIcp8eg?=
 =?us-ascii?Q?rkhYBk31ZbXMl/LVA+wnqBNdLvMh7EXVhadNppiMcXMcP8OXLgmZv5VYUmDz?=
 =?us-ascii?Q?ZkRriUHDcgVMhckh2Lj3DXIdN0SApLUe1u5ouycE72uX3evHkhTo34mQ2/Wc?=
 =?us-ascii?Q?wZMWnEOm7ZbdNm/K8twfOCHvBzoEfWdqBE7kknEZZ7NjpB+W8+MBdaf2T0O4?=
 =?us-ascii?Q?Ki8DYndYdSbCclqGzT6xaIr3DZj1lgAJCsjO/OfLGCqH5wVRnRLKsWf+w2iQ?=
 =?us-ascii?Q?Ku8FM+HDSfraaL/b3rnCNppZvakw2oVh7AITQxWqVgkcS5VpGRq2vjDwoj9e?=
 =?us-ascii?Q?X9CKiLtVYTVpOm0MT7r87TqZahxp5IZ8DdyrklvAs2CS4YfYf4AXDoeylqz0?=
 =?us-ascii?Q?Jo6JZMHBRg/yTNMCZbawep9CaVRKXEI4c4jzxCu8tLxClM4RBQkzgcsQGW6h?=
 =?us-ascii?Q?S2lkbTyvQX22BwEPqgoypGS27X3YCmfMuegglG5AsokJafir4lAh1/AoF8Rb?=
 =?us-ascii?Q?+EmMX09WM9QxvQHGU6M4NdFzJyL4/7X9G6h4ZzZ4dzFX3EsdjGw/HlOs6rIJ?=
 =?us-ascii?Q?YATFyhZhwznk9yQX8SIvqYZaymbka0R5tX/GghY2V7WUI2N+xWEG0D+YPqiT?=
 =?us-ascii?Q?wSJb+YVFbS5/h5cMmlsXNLt6mH0xdIaHcDWp2wSJQErz7nryebqWDA1Ac7rN?=
 =?us-ascii?Q?XFBHrS8qNi73L17LK1vxp2jWBtCXrjNKIwjQHJMYJ2Mt/ddH6hUOi6wJzaQm?=
 =?us-ascii?Q?nNHK4MaUDw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954a66b3-6616-4050-edf7-08dea5f947e8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:12:00.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNFP426RGEvg38PA9ftgVzdfzVg3mkD1EGCGR2jAZz4c5LBhBi7IivNzIFaT6myQOrRvasNzniy8Q/d37zXyFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609

On Wed, Apr 29, 2026 at 03:29:43PM +0200, Andrea Righi wrote:
> Hi Tejun,
> 
> On Tue, Apr 28, 2026 at 10:35:28AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > v3 (all from the Sashiko AI review at
> > https://sashiko.dev/#/patchset/20260424172721.3458520-1-tj%40kernel.org):
> > 
> > - cid: drop leaked cpus_read_lock() on scx_cid_init() failure;
> >   BUILD_BUG_ON tightened to NR_CPUS<=8192 to match the BPF cmask
> >   helpers' CMASK_MAX_WORDS coverage.
> > - bpf-struct-size: use offsetof() in struct_size() to match the
> >   kernel <linux/overflow.h> macro semantics (no inflation from
> >   trailing struct padding).
> > - cmask: cmask_copy_from_kernel() validates src->base==0 via
> >   probe-read; nr_bits check is bit-level rather than rounded-up
> >   word-count.
> > - cid-qmap-idle: qmap_init() refuses to load when scx_bpf_nr_cids()
> >   exceeds SCX_QMAP_MAX_CPUS; the task_ctx flex array would otherwise
> >   overflow into the next slab entry.
> > 
> > v2: https://lore.kernel.org/r/20260424172721.3458520-1-tj@kernel.org
> > v1: https://lore.kernel.org/r/20260421071945.3110084-1-tj@kernel.org
> > 
> > This patchset introduces topological CPU IDs (cids) - dense,
> > topology-ordered cpu identifiers - and an alternative cid-form struct_ops
> > type that lets BPF schedulers operate in cid space directly.
> > 
> > Key pieces:
> > 
> > - cid space: scx_cid_init() walks nodes * LLCs * cores * threads and packs
> >   a dense cid mapping. The mapping can be overridden via
> >   scx_bpf_cid_override(). See "Topological CPU IDs" in ext_cid.h for the
> >   model.
> > 
> > - cmask: a base-windowed bitmap over cid space. Kernel and BPF helpers with
> >   identical semantics. Used by scx_qmap for per-task affinity and idle-cid
> >   tracking; meant to be the substrate for sub-sched cid allocation.
> > 
> > - bpf_sched_ext_ops_cid: a parallel struct_ops type whose callbacks take
> >   cids/cmasks instead of cpus/cpumasks. Kernel translates at the boundary
> >   via scx_cpu_arg() / scx_cpu_ret(); the two struct types share offsets up
> >   through @priv (verified by BUILD_BUG_ON) so the union view in scx_sched
> >   works without function-pointer casts. Sub-sched support is tied to
> >   cid-form: validate_ops() rejects cpu-form sub-scheds and cpu-form roots
> >   that expose sub_attach / sub_detach.
> > 
> > - cid-form kfuncs: scx_bpf_kick_cid, scx_bpf_cidperf_{cap,cur,set},
> >   scx_bpf_cid_curr, scx_bpf_task_cid, scx_bpf_this_cid,
> >   scx_bpf_nr_{cids,online_cids}, scx_bpf_cid_to_cpu, scx_bpf_cpu_to_cid.
> >   A cid-form program may not call cpu-only kfuncs (enforced at verifier
> >   load via scx_kfunc_context_filter); the reverse is intentionally
> >   permissive to ease migration.
> 
> So, IIUC scx schedulers attached to bpf_sched_ext_ops_cid can't use the built-in
> idle CPU selection kfuncs (ext_idle.c), right?
> 
> And that also means sub-sched support => no built-in idle CPU selection. That's
> a bit unfortunate... I guess we could implement a similar logic in cid/cmask
> space, maybe in BPF.

And apart from this and the other comments in PATCH 8/17 and PATCH 16/17,
everything else looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
