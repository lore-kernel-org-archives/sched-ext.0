Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54738F64A
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333719; cv=fail; b=Au97iiDRYzlEGpx2xLmGGpdXFFzzlVSvTqmI070VPDh3ggNl+2hNtU6unE5AC+vqfNhFGbag5YiGc7alSnzl/+beBLqSOml9DvX0SyIfNjG00X7xchHMoyej6kzlciQc+W3g2MvnHufwE2P5F7XOKFQ2naeLTtr9BSzoGYQzIGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333719; c=relaxed/simple;
	bh=IDWlhKK/IKJChccK78yrs02L5s5NNwmH2NrT0Il9YgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fHL+ByITERUvFgFOBLJOqH6mlaDBz6zzveMdhKxDKrEC7sE/W1DqpONRu/CZN/yCazDLThHHQZePOO7XCjIZ3X+iV7zzxECVu/AK3/JBXbC/DEvyTcXWYuzjd67tYkfQdEVKea3B9mWj5+2fLcPOFIUoLWvlHA1YYb/cjPiA8vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UrUxEiYa; arc=fail smtp.client-ip=40.93.195.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UrUxEiYa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWDCclljStPoatJ933nCzfaUnY6ZyqpH5/EPE4abqtRlbWW/2zP933D7NOMgnWKbwWkYrTmfArycYAjdX3AMAjDDlWDdriLyyThNFy0K/xQ3HQfR4NQ45H9OOw5awyYfDD3UYaXAn3Ny1WHoxwfk+AmLXC7+c7wFhx53iXpHtV7Yp5vrwEvx+etpiwyNa7t5krw/KWdJZMzhP8UaohxgyEUhmNnlLfmEAhA1pWRU7PSgPhoZJBjhU0hT+qwNqRIbK878BM64YNThitJpVg6a5gircjvsYB7XEkU/yWOpHnRbKRPB3U7VbX0jx9HGLwXaiSdS61xxhX5D7LNEcmmx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttaahJ49At4jif9TUpQ/UEVXWcqnRwg+UeiNNTlCU5Y=;
 b=wp2rSGd1moCGpuO5fHIVY6t0t4pPzAYPeymZ14peNIs2nyVwNN2ey1O8Ekh2QOXZCNDikgBItk36chIbWv4Kck5UpEltK7rgmhCjNNFxRcpwajrai72OwANQf0IwqOdmfG+wZbSV58qSDLw+Ns3TZLQ9rSxtiYcgTcQieO3kLe3oFxx5k1wEbMN0Z9Z94nbBxAuLpEGooZSI7F5I3YcTeoJx9UymL35vK0vi7SIXgH897MAo4ZF9R1OMycl+sHlxC9/vcmiuX4baZjXgyGZRCQ03G7Srln7Se/5/Xqk74kZTRC7X7uxQJdeA+Hy59ThD4LmBB6RJ6cB4ZIEWbIcqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttaahJ49At4jif9TUpQ/UEVXWcqnRwg+UeiNNTlCU5Y=;
 b=UrUxEiYaxspVEQXWzsR5pne5IdZGcbihK9M+n9TmxWBLw4bCEDFxiks2f63x4XyQJbJt5sOYLGsqNoIc7B2WQPlD5R0AtFQY4FP92EwWAXsktxkOhfziQpkWD/p6+27r8UBn1LF0QVYjhqMrmh/GL77lHjghROMRdSjlM3d8tcZw2/EFhlHdUL6/Si9QdbPCUifENPAk5TgZNuNiCrqTXySeFRaNa5l4xfzYX8eZmBy871YclnNtu5W2a3G/eobe+e5EYldb+0+f8c8u/Yxn4v/pNU1G2AGqsdNi25freTfF29O5bIFgXe78uGjgGuPfSYihbk/CwvWUdBJVUX4+Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 10:01:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 10:01:54 +0000
Date: Thu, 16 Apr 2026 12:01:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched_ext: scx_qmap: replace FIFO queue maps with
 arena-backed lists
Message-ID: <aeCzimksD26i4gMc@gpd4>
References: <20260416081626.1285617-1-tj@kernel.org>
 <20260416081626.1285617-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416081626.1285617-5-tj@kernel.org>
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV5PR12MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: d62bc769-9fab-4076-3d2a-08de9b9f3031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	E+Jq1PazzCGmWuJfSMoVw87OOiWeXvUnjE3M6SCGNmGv1SCp9MbmO5ZEWCjBkJDkFBhJxRdRlKDr5a5gZJG7gOUa8lR6RXcdbh9OUPPRzrinIWGcDQLg2kHCjPx5sV0Acl4K9rXi8+MJ5rgSKE78C2KZlyy3HbgqxlKyqgwmndb7UUU30zlGHyrDbTey5z/Uk8Qu0Yh+xH31jJkGWx2FjRUJ8T+rvXFybUnBDi+tEptLzGTmtFtmIoEdLCPAsVguhffhzP2KyiPad8uldLMGrDieHP3KlHoPtDPsbsglQ4NkbBImRfQ7tZEkZSlm2ympBSrUJ/2puPzJIT6KFyhs/IAPmTbYbZBk7X5+fF0ko5IotmC1Wf8MvGHSKw3m2wkKUniGFBJyjvAUs9AR2M6MHfIK2zhQDrxzRtTrvGzu7FDeRV8esa/cTcXjpNg81AGdQ5izdlfZTnDGi0sWMvx2LT1jNS6/FP5QC7ghv5cRgLsXFIT5d44iyX1TuJsDuXsTEo0orr2y+W7AIrCUnCzCtWT66EJ2Wx1PAMqsoM5j4NATt0cEQeLu+4QnJffYPCm4wS7HUnBU45w0+F+FZGziMNZD/X8PoXO5+du8EPJ0/kSUR9jdw2RfwsuCXun1vQqdkiUeKenMfFQxKzvr9bn0XrawfYzzuoGrndFZI8mnO/+XzKubsGeyS+UPN7++K+qHA+MljlJ2oQ26NfUDo72CLkJqO5QaWkOuVjOPseiklmA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ipFrLuXNOwF1xuwtl75/8x3EOgdbL0VCV80Gs3jRGvZ/2W4i2DDqQ1kyU22I?=
 =?us-ascii?Q?iO8jcu2ykD1hu3k41/iVDT/pbM2ovhvu3OAFqouthfM5NIC/e8oRwvbMpRnJ?=
 =?us-ascii?Q?VZUdotW1fdppCxGpCFrhr/MOIntIVEYCmo2ojuMg5FitcuAyrr2owexsLpP2?=
 =?us-ascii?Q?tQ9SFSe+QEnH6azpR1k/GeVq6gbA0V42Ctbar8xvXQ63RUjuipDFr9kOzHv6?=
 =?us-ascii?Q?EpxRkImHTQHtFMoFoFeVU1pdHjzpWuVDCRJDZhdjQMJDzXk8osKWgolP3awb?=
 =?us-ascii?Q?gp3MKS0aYKXJfJLTalC1YdRE0mP3vLww2qF7DVZ2T/eG2rJH76jQC1eFTJSC?=
 =?us-ascii?Q?bia+2mO96EcSljWVVZmbfxKK+X/JgXTqixGY5JpWQczi2NOAnmuv5oIOl69I?=
 =?us-ascii?Q?pmF/g+GEqLjl89MXu5WwSw7qdOhRk+EyJJQkGTlDyV7Qb10LqjkMDsX+BVlN?=
 =?us-ascii?Q?YCLLcFISGmQRhM6ZJR2y7Grf2RydksvXkAWAvL3g798stK84idw16TPsapYK?=
 =?us-ascii?Q?j3VEnRhaY7Rxa2ni3K+iyHAuWRI1Uh8cdGz8slyj0hgAZAHEiq6uXw3e5iAH?=
 =?us-ascii?Q?AePRNHTMYYY2UGTXQGDfPnrErPUbdt3cUq3gvfsjGGn0Wq1xnpPLVVI/DMyD?=
 =?us-ascii?Q?v2gtOKH8yeXIlYwEy+6gMc2/OlKS0fB7sdjE+sFpmfc7kqJf/K886P762BXZ?=
 =?us-ascii?Q?7DO4eDAlzLXsOIc1oI31KqBrsT5JsXISx53LXOudQR5d6PE1/6dm+3cP47tG?=
 =?us-ascii?Q?o5seRLgkgrvFdMzcDxybuQhvGY1jICYSb2H+XgOyXEsPEq+ZuVyve2OmN6Mc?=
 =?us-ascii?Q?TiRJBX7uQRq8vAA8Ws0wqDjsvIn49kXOhrjn+0rYVJ4C6evwVOMN8uaAVuh/?=
 =?us-ascii?Q?jereKL4IaQWi00agtztkWzUTWsLLwxDSbXgGlgiOvrf0j6me35Vz37WTZ5vg?=
 =?us-ascii?Q?ytbHx2YItDOq3KNfFN2wLOGRhxx74ZuKh5DICGM0InvswPS8tP37LrHDYAg2?=
 =?us-ascii?Q?7kR96NgZXRjl2E8/+zZwjqGReRjaOwzASmjS9+eeNsNV1WfZUTU63uF73jGA?=
 =?us-ascii?Q?SeT61FlYEnwGYFmuqdhB9uvIbR6AjcRBtHFxgtkR2zWTPtRK8usyhEN98F8e?=
 =?us-ascii?Q?NntQtkkVZlyLtVA5+Ro86qIzWGDAxKZuF5e8dc3uBwnoNF+obSPZrqcCML//?=
 =?us-ascii?Q?ySo5Ts+jVB/VGf/26uxWuImnpQnKwF0rJYsDiu6cwCCeswcuUJSAguXRoJyp?=
 =?us-ascii?Q?OWOMaMPb3nzoIaAqhZ2ymH3y7LJ1PidUjucGOCv2iyeSCKYUNJ+WE4LhqRX6?=
 =?us-ascii?Q?Xrfnwlwk6k3GQExt53FRYnUh8wjNh9BYVO8IgeiymE8sZ6AsjhC0pi9SNwLG?=
 =?us-ascii?Q?ZSROK+8CxMY3NlAY1Y7SEhLNEub7ouBdN6KQexb6gc1HAR3NS/w/q2ioSvE4?=
 =?us-ascii?Q?qr02ITivkqqjPmm6e0qcKhHjwyGC9ygJwTQMadGLMQ24/MMIumdPsdGh13IG?=
 =?us-ascii?Q?cYkrCTo/J1apxKwqlkRwQ7yEW2PbH+oYk/MJPedEd8Qwc62nPTo3Rcq/EUlZ?=
 =?us-ascii?Q?oGhMNl4JL7IwXdrcWKcLJk/DRadKPOnbsRcCDG2Rlqq8dd72nkxBdnQ8aawm?=
 =?us-ascii?Q?EgaUq1NTFzs8BvHPcT2MbeDLPuUvkKxiuvQXmliBV9rg6HnJOPh+iVFDMVGV?=
 =?us-ascii?Q?33jl3agiszC3oi+yGmxeUoAgN5hb1R4sC9/1smA3Fixw6jdtcdqYHwtu1A1n?=
 =?us-ascii?Q?NnkYQDzuxg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62bc769-9fab-4076-3d2a-08de9b9f3031
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 10:01:54.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JH+tAbCuGjy++dOnCP0t+0A5GFs2A/eHLSUaYfwrRGGOakQf6z+gM0LLXF6d9iC9ciICLXdivwTn+mznzz3FQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9828

Hi Tejun,

On Wed, Apr 15, 2026 at 10:16:26PM -1000, Tejun Heo wrote:
> Arena simplifies verification and allows more natural programming.
> Convert scx_qmap to arena as preparation for further sub-sched work.
> 
> Replace the five BPF_MAP_TYPE_QUEUE maps with doubly-linked lists in
> arena, threaded through task_ctx. Each queue is a struct qmap_fifo with
> head/tail pointers and its own per-queue bpf_res_spin_lock.

We should probably update the description at the beginning of the files as well,
mentioning the arena-backed lists.

> 
> qmap_dequeue() now properly removes tasks from the queue instead of
> leaving stale entries for dispatch to skip.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
...

> @@ -756,6 +808,8 @@ void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struc
>  
>  	QMAP_TOUCH_ARENA();
>  
> +	QMAP_TOUCH_ARENA();
> +

Copy/paste noise?

>  	if (suppress_dump)
>  		return;
>  	v = bpf_task_storage_get(&task_ctx_stor, p, NULL, 0);
> @@ -1018,6 +1072,9 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
>  	}
>  	qa.task_ctxs = slab;
>  
> +	bpf_for(i, 0, 5)
> +		qa.fifos[i].idx = i;
> +
>  	bpf_for(i, 0, max_tasks)
>  		slab[i].next_free = (i + 1 < max_tasks) ? &slab[i + 1] : NULL;
>  	qa.task_free_head = &slab[0];

Thanks,
-Andrea
