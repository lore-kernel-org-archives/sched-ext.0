Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7A3D1CB5
	for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024189; cv=fail; b=kBVByDNpKsHFzUlIUM6BphaN1yJ9df3DE/nq1AQIMnA9QUDKN0HEYsTnMGsQMhISzFN/6KGoK+GvGx4k/jjB1mG7Q0WJn2iNCHBRJWoGsIL6mA0WMV6SyTL+34YXeip24bgC/ww0wsYVs+MNOGwO3qY2h+lOZ6chDgUOpuW0icA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024189; c=relaxed/simple;
	bh=rJRZDmY85X3VryFF/p9WuSe4olsPXq2gPNEuJREQOzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eIIYCgTm4Qnf7AWjDhzXADlQ59BbXR4P45D7ok034F1xKaVyQv2U7pDiyJfJiQ8zTuWup8U8lWXMqf72sxUEY7m1WxGwydCB5/WjCR/u6lr0kK7mJ7pUGBmRTee45R6H4pmefw4HFW4t6Qnhz0Yy2Io+QZ65bjh+415wPlKELhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EKo5VQHc; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EKo5VQHc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs0aoCBW/Pv+UEw0/SRrrMfIdMOaoZsaHM7tI/+XT3RCKrdKKPUKEjFU0EQ1BXweoM500bzeeiwgxP/9oPM/UQGrM1SRHEpMjswdOW2fAA8pPOAv8+gR3lg1S8i2XriOM5FApQsgvId2zUfMIfZvIRIYHu0HuWDJ3vKQXc0sAObb7kDUCFEGV+aoPnhnV91OKVAkwRM/bqn969cUzfA/D0QglUwtB5ooGyd8+idDKtWnlm15JExShhsgC3QPGissgMNJ3jBdu4cUwUD9PaXAKDk8XaspOpXtwRhJGjyJ4xjPY+Bc9k/X+9K/yDY75CL9hekOySp31OEISy1gxrjNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwXkQT6/cOaeXN/NQvxC3iIZSYCtqHDmDRAPUet7Apw=;
 b=HL9gx6mWkqWPWHW+yqVE6mhBflcBf8Y5MNy8wumBlGxogwBNYeSBfU4ITeyQO4G0t02HkyRLHfI5JI/MVPaKUpo4zQUpwO8TVVloay39+3k7yJdJHUIp7dEp9hgqT1G2UsgEOlYYFi++jV6RqlQax6idlLfvRao4YILATQ/36QvHvdyCQhNervI+Qy+b7+ln9Pelh7Q4PXjWH/xeeA5tvKYtDqQlGTmjemGcA6H3ftyhKao9JhFY6S6GQTkbQeFm6LCMks5Nak1XNziadaKl0QiPqCxp7lnJILV64WyUugO6CkJuNxmttt6o8GwOCNAkywsyLeOcXFT/9pgu5ge4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwXkQT6/cOaeXN/NQvxC3iIZSYCtqHDmDRAPUet7Apw=;
 b=EKo5VQHcgsfQVQGxvrd0ow/u5r0nqDr7o6yYaFzCOr0NVEN+0B3MNCvAUtTA5/VAhFqbbRI/qvX29BmEqZD7kZ/AO7/tuVebQHOP1fZ0OyCtYCqUIU9LdVR5L4Hyhjxynpj0/DxoGqY5eUZePesOteYV3u6e861lS9CWt0zUQQ+4GxFEL2/lassh7CncwCXow7JHsg42YykpEqn/3z0prXplO/kn9kZQsTKHcAqcAW257E7I8mbpSb9k9zwv482KEpbdxlifYOKrUKNyVr9kCiqENmmamCjvM9D+iXwfYVk9/KAHXVCuZ//0gvM4RmSCy/FEPvPIR/QcRE+OiFmlhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 16:29:42 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 16:29:41 +0000
Date: Fri, 20 Mar 2026 17:28:51 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: idle: Prioritize idle SMT
 sibling
Message-ID: <ab11w4CC0dQzRwgR@gpd4>
References: <20260318003842.762275-1-arighi@nvidia.com>
 <ab1tumOcNCiwZqOc@dmjordan-vm.corpdevsubnet.oravirtteamphx.oraclevcn.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1tumOcNCiwZqOc@dmjordan-vm.corpdevsubnet.oravirtteamphx.oraclevcn.com>
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: da8a0267-fbb2-4121-b950-08de869de339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ou8qV9km8n0X2ScATnG3rFF7aYP4p3GeW3C5WO+GEpBVJx4yOPC0kIjbRA38y6pMzwLKVtECMNv36wHHRaSxMDt/FX65QvD1Waasztdpex2OR54kSnjIyMYP9pMZoMO8GJo2vQnT5BryvPDATdADW8EbNNp8cSkayW60J7/CTjC+UWXEM1A7ne65a5KLEdxEki38/GFtOlb5hl4qMJ+6AcWI0M2YZETEfG9wqmRZW8CKfDLSJMs39WawlaccrdeBjxM5SdxGzA3ZH3hdUqejj+EpLEMcCMc9vX4NI+wnaSNLnB4LGEhzPEE1hxmF3llsX2EJN8MP6a3nAUc71gUoLcHA2nghnFYdOwr1+Go/31a7wcb+OAuT1vFqDFkcgYC2jQoXauDcziT+cFJGUBzGDps8l7FLlesIvoRsUfitBYmo3i/BG5gTL6+d9/R5eIDhEdFOZmIouguhy2MfH4F0Q8+tVCWT4YCXy0FS/hkd+8qji2H3NvrZ8StNY/jZ//GodNoxsKsbp/AlkIURiIphxyoTrYAtqJ/1ghCBmylx67IJgULhPd5U+nvc+6xUd7+CoU5Guw7fBFOLVDoZ9t3DitgkRCLX6GkjEzHcpEgDsaDNRxkN3OGvkAXlgSKU/k3KF4PFqNvqh3iqpj9mtc0a20yZnDCNd5XPBqfkWQfADTSxpYSO1YmxfgcSJ4h4Bv3rpMeSh98Io0lWMCyr8+jbORV115BDraIBEEREQAMkRS0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LQfa1RqB3+W8NHnHMCZx3ErUpIrn3do9TC3hiAH2GPTp7GsnroZR5crP/pvc?=
 =?us-ascii?Q?b28iZn6yLtUVuzlJXNRbq8oWlc2Nerd+zdQCDrmU1gdfTh7eET7C5zfh061z?=
 =?us-ascii?Q?xxjG0QZeKgHaiXEox2xyYe5l4iDyT4S+SvzNQzxh6si7F+LlyAWHGIB3IoR/?=
 =?us-ascii?Q?vbHK4gLiT0pbeE0UlOP4SfvH2szCgjhPzy/VvTQjcZsXQxLkW7d3Tu2+y6mu?=
 =?us-ascii?Q?LGJ6qBP/fi1akmtfyGIIuGxvFNOTGbl1vShxLx4CirWZqjtYgVHpM7lfgd/G?=
 =?us-ascii?Q?dmJNnAfni91E+CRSwzmtgB4lBkTcppRTGSAIeYkuxAfXM52Y+sio+UFzZ3Uw?=
 =?us-ascii?Q?knl27QnvjFg3r/mvJEMYp+8Pna1i6WhcUSAdR4MwNyHnuHoDsm9fW5v8CCa5?=
 =?us-ascii?Q?Tm9tKHvJQS9S0LtrqkJmSOS8OVb7KqNXWwas5WAY2y/WYc7RJJT4Z/yoYte7?=
 =?us-ascii?Q?bafVegd/jXl/kZpbqpQXPly3/t5qWNEyhHdJiV01XzqoPtAk+lX0z19795B8?=
 =?us-ascii?Q?3R7MUuOpIKFTHlDBEzI4k2tu+DPgebafJEDmF7NPHL3l59d+7t1r1GAwd5Su?=
 =?us-ascii?Q?3dZqhoypihchKxQhSnNhDxYj0T0bHNtO5ezvgH6RsdRXXxxaQweUTNUBiH4b?=
 =?us-ascii?Q?j8KTPLKokpIWgvNIsR2yMeWQJJp11SH48oqNAAD9tS16/zqL71iN7PAI3hkR?=
 =?us-ascii?Q?xL/Ssu1xRc6rHf6l8aK+XPCdnA2B5LJzyBVtDRHnl9fo7JSZe74oHXU8Pbg4?=
 =?us-ascii?Q?es9Ob1KRQhumrPafIgCfpOS4MOPR2U62Xetx5Bff+xEftSW4NsTrnnT+s1+K?=
 =?us-ascii?Q?UQ3HajHb2JoIcx0TtZ0MJv4OknH2u1t2fbrD/M/x4nlvG5OSuOArhna1OOtp?=
 =?us-ascii?Q?xkhG6RyISTJsOFIksvDMhwos9PRz/23RwI5yz+Qa5/a0TvBSkUBtNg72aQOU?=
 =?us-ascii?Q?/eESnLCTcY9dN8lOjv+gWMov+ciwPYoD0qnna4bfHtwLwiu5EjuYCOwZwuL3?=
 =?us-ascii?Q?XdsoZFDPekwzy8Wzm6BtJItr9VIHyQwOJGb5DPJcaYtHhaB16hBoMmEB7KIv?=
 =?us-ascii?Q?gN32rz9jTQ1gbO5lB3zSidasLtV5V7chE0I+tls0QD9+cNzig/fFr2f1QRil?=
 =?us-ascii?Q?BlSSMYTIqBQazANGfe0dh3l2WBuiB2sDE9qUT4q3nsvFu8dBM9dSOsPx1hN+?=
 =?us-ascii?Q?I1bN7YWeocB726YyA4Uo9fa8tw+jdWpXttNVPs2zByD6Q4cJ9e6Z7wiVJvzs?=
 =?us-ascii?Q?s3mMiGP0KgcgDj/AZx0zDUvFrBX8JyNVm6wPj4xtBm9aH9prcK8uZtxGBd6f?=
 =?us-ascii?Q?/Y77jFWArcbcOrenvxX+/uqsiIIJsRSb/2c1Uxezs3/JVBTLag/jNMl8uWvK?=
 =?us-ascii?Q?CBHHldvU0b/bxurQH5juo9gjuDI/msuVvL35K6kP6XfDURGsxEvn5vtZHy7A?=
 =?us-ascii?Q?20/ORIQj5+EhZe9tApEYIu88MkkbLm+S4Jn2yYr4+zYDbkWMEQoGvNJ2Y9CS?=
 =?us-ascii?Q?0bK1Mt0756KGdZ+uUVf58D1RngdrsKQEpZxgYAqOTeMHyOPYXSGh8vv4aRAw?=
 =?us-ascii?Q?+uZ4rcJrG+70XY7irvSYvS96azzSuQwlClnAql/z19fntAClJhn+Xgy9iok9?=
 =?us-ascii?Q?ABgol41NekDE/EUZjLeICB1ksXDCmKCsL7V7VZIaaC3tbenCSxLErViJRHaM?=
 =?us-ascii?Q?wlJ/E+YSwwM9q0SFUeQkNzqSgS4cMpU2Zb2/zL9IK1JPTeJ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8a0267-fbb2-4121-b950-08de869de339
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:29:41.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDGRun3+foye9FXJ8/9s/lrvx969Iq1CRUp6ObVrgRi5NaPWrFUaaM3MGnCEKMFCSZuAhUTgUtXkzMqTrbgYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117

Hi Daniel,

On Fri, Mar 20, 2026 at 11:57:02AM -0400, Daniel Jordan wrote:
> Hi Andrea,
> 
> On Wed, Mar 18, 2026 at 01:38:42AM +0100, Andrea Righi wrote:
> > In the default built-in idle CPU selection policy, when @prev_cpu is
> > busy and no fully idle core is available, try to place the task on its
> > SMT sibling if that sibling is idle, before searching any other idle CPU
> > in the same LLC.
> > 
> > Migration to the sibling is cheap and keeps the task on the same core,
> > preserving L1 cache and reducing wakeup latency.
> 
> Seems reasonable.
> 
> > On large SMT systems this appears to consistently boost throughput by
> > roughly 2-3% on CPU-bound workloads (running a number of tasks equal to
> > the number of SMT cores).
> 
> What workloads out of curiosity?

For the "server" side, I've used an internal benchmark suite, the workload
that is showing the best results (3% speedup) is based on NVBLAS, but doing
pure CPU activity.

I've also tested this locally (AMD Ryzen 9 laptop), usual gaming benchmarks
checking avg fps and tail latency. I noticed small improvements for this
use-case as well (still in the 1-2% range, nothing impressive, but it looks
consistent).

Thanks,
-Andrea
