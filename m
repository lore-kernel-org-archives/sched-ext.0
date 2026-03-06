Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6636A023
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838901; cv=fail; b=DLUDLbuDT1BHytDL0SMrZOmvKgaWwysu9k+OBJox320v9VwVI97FYqvPJopJIJnKdLA3FevIvhjzZC/cDCq47645qh6sqMcRnN1Q/YcFf7+/sUmHB1RWE5vkLGVap2F0iPL7RQrSUYabtTDfUv6xBC3ZJix9zCw0iFLK1JEDHDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838901; c=relaxed/simple;
	bh=yuAe9OG3rIH/0NbmbbGHdHX3FKaYWPhItne2f+Fu5W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J09NJrsi+6/feXiShwwH9D97cEunpe9fPqqhbxvzrH+JebOLoODP5F0QwMRtmHh4UoWIxzgAVHaWGgICXOFNgTU227c2/Zl71B5hvb6UFr/UwbilBcnqmL8S7oACwRkos6Fo3s1/91k3ZEvoGp0i5mAOq7WY0TUp9fO8EwlmT0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BAgAXM69; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BAgAXM69"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGVLZ4DdkS/11oU1HoGalEodb1/x/sO5ZF2Qq0QTm7Py8o3Ain9ROfD4P9BlQ66OSyqcSYU2QcxyDYx2735Kn+6pZVS5IVtUo4PpUmZqtGnPf4uAnmwB6E05I6qio2l7yfTXxvYiijCV/dHP0DRlMauZe2CDpE7tPX7KIzXdGSIqARhbdTd6gP0ZuBhHN2Gngtm9LRLGZwqAKQ6vm/shyNh7F4pUQ8deUZ2p3cpcZaGm7VpdXouREYa2LoxbIBSDB7ZmUrPofIKVQSmv2JxwbAOg4H6r5eJqL4LUhWTU6DQ9mtI44QDy0hLwotTvtLJqa9aMbHTIiLFXCXtxAinC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA5sUQtsIzYWYhJ/wJLcyU97alMCpyvZHqsvYPFF4b4=;
 b=idQ47hIhzavTBs/u3i+4UvRUjAoLjNbbX69pPhr16hvHFU+HioPF47osoJEHtbb3kIueQZAFQIg8VTisAsBc+or0UA5YuHd33CK2oBQHYL3RFmOO9irIf+f74JXJt6Sil8z28MTaOL2pWChFlPq1bagd3DTVzxagwjBf8mn6ES8Av66nkFMGyqLwyzxO0yPJcU/om0IWxCS9MD8hfDDmPRlJnvEiUJSe/6jZPbJwcWcHagcCK/50HzoRZlZ2p7ihV9Bgk5du+Lrzzjb3bDt8dqvJnf526+uOnSeIwSe+28AwYq+ktk2UcuS+GQVvndRr+4x+tDDpV4z4x6Rv7lNc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA5sUQtsIzYWYhJ/wJLcyU97alMCpyvZHqsvYPFF4b4=;
 b=BAgAXM69kfpqHAe344bfG51/3iP+zTNpGZYxwP3X4uhO3EvFgjgXv+FDGHuTZ9MYuSkCI2QcC2ayzJ033DMDrrFmqTXfMjLhHEHKOLYo9S3eYk7UnllYOkUFATmezKTo+U+SLcOstNxsq8kASQ0bYMtk2kWAUx6wOWic3rtGJQCP1FTV4yx3+a7kaNR7BDVpcyxd0TK5QfhAmJWTx7IKnmKAM77lxulkUdiT4SWoG0z4x0qvbOLO4UfBYpu940nUeJrkLkln49NIg8Nke24Po+Sqg0V3DHUwFTKMdKKiOCQ0IDT9vbFKDdgXuZhDcYF46nx3wSdUAxR2j3Z3IaMeOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 23:14:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 23:14:55 +0000
Date: Sat, 7 Mar 2026 00:14:48 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com
Subject: Re: [PATCHSET sched_ext/for-7.1] sched_ext: Overhaul DSQ reenqueue
 infrastructure
Message-ID: <aatf6GMB3_1138PB@gpd4>
References: <20260306190623.1076074-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: c3486077-011d-4406-3dcc-08de7bd62de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	Q2NEyzgeiVdgCcyR0ER4EaaAwHx/6ttpfqFZISLXV+S517QbXoIRpXavVYg9vrVMmrGn/7DEHkZ6N1jCN5gMLTQxVJlX00ma6iHrAf2uA/WseJ5hg+Z7caV91zxcOsjM/TqGo4NTLSRGuXpwkqHj4I0EZau1TO/AXF4vuHiy+OmyojKqwy3s/fQeOIacnpoP7ARr7TZAnZuBhFs1ZyI7xn0HxQWLgL0Z/2vHHFh0FyFAWsYK4JMFICpZh5mlCTrV9MNCo49CK/SDlTp4/ZVQlu9MDlLMxDXvLY8MgV+6gIlkV2ZpJEmDW/+M+l017141rvTz+TG69zUt3zNpqRVE8Oi9T6PS0z2CNmdGsRhHS+cBTgSXHQ/TcJa2shGje6VtglH76q10qyoPUHPgvZtz5VGRkBFwsc+mWKK+0PwQX4v89FRAW8FAAYlvg60hIpyH6yeNsyjQwTmOVEiaFX+inDVMMRLUvJ8Zq6fzedVk1L7ADG+c6NbSRd3jeUHge2gNJ7Sz/8jMyfdGOBTeyvtn64FvYU+ot4y9WBo8CBluOl6ljBAtRKep/dfDididEBirZnGcCWsj87HjQ99GBq+mwn+uQ80oSGlao9LzQB8h9bmuvsy96GOJ1cbdPaW9H4QvBCoGGaBRhQzM7BQSCeOEB8vYEuiSiPrZsYjKo1vJUEaI/Yee/rjrAiHn76o7eFw0dl4BYRoOHUDxNTLU8MEscD3ulq20qFJzwsw7VLEz7Zk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H9h1lxM0+Bo/9+3WD9Qi164Ew6rhg3Jj9MzAHrgSTNYZfe29fvZPhqVfdYHd?=
 =?us-ascii?Q?z1PVrrciB2cDVNy9aniV6h4k05AYJ2+1aRn7SbcaDA0icYWJOTi+3WSiCEkc?=
 =?us-ascii?Q?MrkKrwFTFBVcqxry6qZcUbRPgye/tXCbfc3rfYaV6Zmv/Xi4Eu0fSD9onXBE?=
 =?us-ascii?Q?FzKzjumVRefqaxcgAfN7W+gtJ4r2UPODjfAZp5leqbusGNpWKYSrcOGBT9CA?=
 =?us-ascii?Q?J0eBNymnPiG98zFUx/viToyLv9XhyV+NjGjvYbLjx5PnVLXc3+bu0D2Ihpui?=
 =?us-ascii?Q?LFGFuC2BLd0L1V0OZ4g5CbjogJsssNsXzNSwdTphNReDNgDLmJ32iXkTJPaX?=
 =?us-ascii?Q?K0/2l8GU4Knut/o047321WhiP0NLDr4m4YejVEQ9O30HRm9+UY3iXCmBMa7W?=
 =?us-ascii?Q?UxdVW0IeVK2G07EJUCY6cHIegkcEsZLY+IUe4S7c3Nn9YBd6Y4ZqONg/Z69Z?=
 =?us-ascii?Q?XmjkIOjaPR2pxSGRjx67rxPylG88CeHtuk8NX5oiZKq0tLMeOIeGQEX3kJn5?=
 =?us-ascii?Q?UjFInb5/JKEDyW9mXolc49XZJNBcmEN3jTm4I8NBJ59flbYD0et8hxz5UQ9n?=
 =?us-ascii?Q?xXKpEFHK1Sp8cUT1FwkV2ZxGLfd1ErBQIjXlWX2M1czVkQS0Ay2FBYLy5GnJ?=
 =?us-ascii?Q?+Mnjo20tzfpf1wE7Sk3dI0CgXMQVISsjKZLZLo1dATs9GqxrL5Vyx9GnRSXc?=
 =?us-ascii?Q?oZl0x1tm/8nUrMpGQ+GQ+hn14Mr+mRPHY9HKC1oF24+rsDvGf9jNHQ4agdjC?=
 =?us-ascii?Q?cDw+RU+bkAKbCwBFe5r7x6vzZg9WYBGjuOK5VKp8e2efgoIoRZqHGktsA3ig?=
 =?us-ascii?Q?oy4bFDtkJ9/jXlplJLXgg0b1s4ZgE3TJtWxIJoNmOurXLHlM2fyN02cJCBHM?=
 =?us-ascii?Q?x1HL2yrVwmhf9v1sBmYItjPy6PaDPN4n7b16dpgf4bPUZD3VpnM5ivxfHRG0?=
 =?us-ascii?Q?vrm1DPwM+LwV+PVREVXziBtuomYB0Tggjti/O/uoJ4y81sC9dvo2NFyBoznt?=
 =?us-ascii?Q?lN+WtMC51o6dar4y/WqRomUDZ39QPKZRDvZ18uKr/zixBP6P6DV9ZGuz8C7K?=
 =?us-ascii?Q?L+OhyKwvD7OuKqjs+wQNq+Xm3EUWfU5M9kWCuVy9nIOfQBJfwRI4add1oby5?=
 =?us-ascii?Q?8SaajvNalXzRj9e08BQ2gukw371LSXPTpibzpqYduV+h3xmlinsuazSmAeKW?=
 =?us-ascii?Q?Ta1lvGFSAAU13T8xb4Dg8/VFWcPq45IR0x+Pm7pacBSTojFbA33MPPICzZVx?=
 =?us-ascii?Q?aV5ALBY1v5aOHiR//VtCUtVuHI6/8HLFjB24Q8OgxeTno7y5zyG0MCV43qd0?=
 =?us-ascii?Q?2zzpMMY7Ce1Z1TaxCj5KMY/hH7SNQ+G3qtWmAljcfkCT+CtcPIPnL3hEc8YX?=
 =?us-ascii?Q?1UZoRfe/C+1fTGjRf03/eQU+slBotns7AqJCwGJ1r3kEPggjp5kCI8zTJl4r?=
 =?us-ascii?Q?Dytwrw7lZ1FooEF0l1FENrhzxo+0evroEiZajRX8P6FywT/fCfuQ4ky4E0bN?=
 =?us-ascii?Q?YQw9d2dcbK/VFv7qDXTXjb1d6SRJqNbG9rnNJqpkEfbcqQTskvoc64qrCdSC?=
 =?us-ascii?Q?GYq5AIxPlVHFwKfuc4TsaYyaO87Ul56xb3sexRosiZWF1fUCIQiqIIS2LxAQ?=
 =?us-ascii?Q?9zg8AXkmPGb63CtCSW3J+dt/oaUPCfaWk/+gR/chkHe04E9CWARgxq9Yqp5E?=
 =?us-ascii?Q?DTltSz8cXmYxIHkyzpWNjJ5NqL6PjJJ7g42rQQ3Eazu8WBxhfBYh71Y8yR0X?=
 =?us-ascii?Q?drBBmPHmuQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3486077-011d-4406-3dcc-08de7bd62de0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:14:55.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adTP8lKqTxT8+0Ql235+tguVfujME/RjiPfrMyQx5QaeqjGpErX2Tksxe/RFN3VqR7ul5L2kuuYm+/1pNK8vkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

On Fri, Mar 06, 2026 at 09:06:08AM -1000, Tejun Heo wrote:
> scx_bpf_reenqueue_local() currently only supports the current CPU's local
> DSQ and must be called from ops.cpu_release(). This patchset overhauls the
> reenqueue infrastructure to support flexible, remote, and user DSQ reenqueue
> operations through the new scx_bpf_dsq_reenq() kfunc.
> 
> The patchset:
> 
> - Refactors per-node data structures and DSQ lookup helpers as preparation.
> 
> - Converts the deferred reenqueue mechanism from lockless llist to a
>   spinlock-protected regular list to support more complex list operations.
> 
> - Introduces scx_bpf_dsq_reenq() which can target any local DSQ including
>   remote CPUs via SCX_DSQ_LOCAL_ON | cpu, and user-defined DSQs.
> 
> - Adds per-CPU data to DSQs and cursor-based iteration helpers to support
>   user DSQ reenqueue with proper multi-rq locking.
> 
> - Adds reenqueue flags plumbing and a lockless fast-path optimization.
> 
> - Simplifies task state handling and adds SCX_TASK_REENQ_REASON flags so BPF
>   schedulers can distinguish why a task is being reenqueued.
> 
> scx_bpf_reenqueue_local() is reimplemented as a wrapper around
> scx_bpf_dsq_reenq(SCX_DSQ_LOCAL, 0) and may be deprecated in the future.

This is really useful! Small issue on patch 10/15 (that you've already
fixed). Everything else looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.
-Andrea
