Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6CD2EC0AE
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672633; cv=fail; b=EPAVdROJOGzxZjq9DC+Jl7b/ltyc8kJ9tSDU7/k3G/KHL9yrfaKJ1/Y0GQcBvXs56XBkJIQXicEx8aUu1zgZtZh4uHBJsgXwHtrJC2/sd1gOMwKaUggWY58z5sHhj+NUkrrCz6w7vcAntJ2/iPjqz8+ObruPVYvksAvP8vbo7TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672633; c=relaxed/simple;
	bh=3XyiCzPjQ2h2YwxNcjFwPvhAXYbWg7nqZNzfxZueHVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s3uwcy1XXzfHV9FIy5zMwbGOE1ezBCDVLs0amrfy9yk2vS7VI9Cf9Zo7ApLXaXvYqXc+2piPRzhfVF/qr7fwOFhYzcudOTphxvzygYiXyRChfyA6alcg7VJAGwrA+V/QpNgZBbRe2Vd/TUJSkp5FfR1gBDvkQRiVEE/7WsW6Mc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rfYMUl5a; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rfYMUl5a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIJOX+1TyhyWClxYUZDI7eNrp3Nv0Q/CapDm8zugyACP/okCOiOe50qGfsgrl8PaQCTk2LgedpVE76V2Luq+N8faCYe+Yj90+5A2Xv3ZKFhDo++4gNDOdYTnzPkfXPZS0s3+fWA79aRePwrrFtkgQdrLndAGEsIPYKUf0WlsBdE8nGelO+v6YQtj17GlNTPMPMGP0WZQtyilNjXN8BHam9/bPF6RPU6Ib4HUg9E8IckI2DvwCY866RQsM8qTN1mPx3CBPtCpDamo6nVLIeQvZKSeAQjAmae6PG9WGZArFW6vtuTkZ+U+ymGSedlKydKPEHomtwOr/2QxIx1yyqlKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYf2tmFddKSrPYN5t72QodsCuH9WwKnS1gbXuyKQBzc=;
 b=jZfAgpK6Akae8k4wDT34w+zU0hCZ75ktzsxKs1dhwaaPpFwibt0FIggrBf7qBbiH+i2+Sw1cX7Lp0G+AgAhaVf3RRLl+vEVTht1SWtFztI3dSbhB0oRhPLQ31rJL9SFFLoobJucyJflZL2+rE3jamnNAQie+PqPwnQ3ouwRuWj0RdDTjgDVDjU/bcSY0WH9foJogewLB7ubLe8Y4E7DAHGyixcAQyWMZa3jGD1sHhMIJVRMxBBt/mBCBoZ9MP72iUhHtuVQ7/u0qjTl5WO5MQiihbZeKBB7iefpcFvvpxzUBFUULCtZIcTBQKBfM1ZaUV+SAzRtjAFWsR2rHWnB6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYf2tmFddKSrPYN5t72QodsCuH9WwKnS1gbXuyKQBzc=;
 b=rfYMUl5aTzmMbT5JU0Z8zoULpqGcpozd86Xp5bCdQh7G1pTxho9NoAkLncZ5vZkaNZYcoOPznE3iemNjiF0TEDsrkRAPA9SaVS0jk3K00iH6wvy7SeCAuuFVxpfV9FHXAryfkYHWTSZWb2Uo60HSGU6W/vdxZdl4vuQjxg1aFffzDLPGVG5qx8WyotFru5TydZjkVklK8pVgWzGcyNvTEYPSBhxQu+eaHvBbr6APKe+BdIjpHVzCtKBhq6z9QBxRxhkVCUsctPjRiXWeY30nDmlRlOUP/FTFFNtmyWYfF1/9EQryfG65e7UuyGx1bbfaGY6CIB7b3TM49kbTNVS0qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:50:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 16 Mar 2026
 14:50:27 +0000
Date: Mon, 16 Mar 2026 15:50:19 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1 0/2] sched_ext: Reduce idle CPU NUMA
 traversal from O(N^2) to O(N)
Message-ID: <abgYqxnztIiqhZoh@gpd4>
References: <20260315181017.1377138-1-yphbchou0911@gmail.com>
 <c6857071-214d-403f-9c34-07a095e96e13@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6857071-214d-403f-9c34-07a095e96e13@arm.com>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d4278e-984e-4c70-4389-08de836b5c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ADta0TEeYUxEraFc5/QslN39wmA/bZS7qeL8ffe72mJ2FgzPXO8baqh/oWObcowybxVGZU3NPtRrrSJx6dK/GS78yJcIIZQnNYjbgGQCuyrBZfMU5WLSqUR6IP2h4UCn64VtxfNUkK0wxMqbHh3XXxANRkdSzvvRolmtbm5+NjlUvnSK6Jv/3VTHb2+6dTN53unvA1CYmh3PoRP2l5Zbv4qVCar3dE9kMbKEJJWm5Cm74Lf13piDtlq1oPTnYSEhJUSSUO6rrW1pfP9xUA2tuNpu3QmDhbzO5e250WEu+MwVa3DKWiLWmr0vp2NgGRAczw9yiAq67pS75y7rMhOpd4mkVVLB0OhxCihoFTIpfBPiw0aDCw60OylwyMvbkzaHVImtQ9iFYT+PmyIMD33p3yjnOEp66IFF+zz1lQiuDERUIKNsD3Y0cK5JqjJE8dPTT4fcAyg/hdgu7lpTevnecNshp7qL1ehMjlCZ9dwk+xUV8hpjNZv9oteCB8a34a2+8X2WP1ndV1ficp+3cqcDjRcrSC4yhO84TjyJArQq2hxvrO+hHR6s8YzBGEL3dosDZGmwfzIwjieDD6gT+8olx2boezJX0rJx5BgHjvVj9Bqyn5t2s1CwRMsRjNqsYhncqx6TMoVC2hQZqscCerJuVJHj/r1wmzttj4mkq18QPHMo8tDaXsgzcX4n80vOG1R8LdTA8c3WX4H06bpJO4brnNhTubzAJDlDkluDLahQ6MU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EPvaXsLiuTfDrS/5gQP+a/bV50QTaQUfRgqFUrhquChmXKA6m1IA37FTQFC+?=
 =?us-ascii?Q?HZR0axezs0gF3Vn/xsAjG6XjrPhusiKpPcojvCkwfpFASflD9VeRaeQcSA/Q?=
 =?us-ascii?Q?mSG563RSRrzEIgpFHIkT4hU/wg01ozjgB1PGYknwCoSlW/YlIR1C/g/dEEDi?=
 =?us-ascii?Q?KLWKhmp4V6F2f9+aEzTxTWvq4Vyl6oUxBzLiom0EHVU3bg07JOYDTxIt4kTM?=
 =?us-ascii?Q?Q/1GIZw8qDsb2mj2TZWsAdlZyVEdoYjeytHL2bBmdr2h8VFHaP2oabnWDasO?=
 =?us-ascii?Q?h1MZt3FNTRxaeverQoRAxPl0OQuvr6DBc3dG9m7zy0j/k3lVmikbtlBWHf9U?=
 =?us-ascii?Q?S6vvVt3IuV2xGl+27cntA2XvCuvZ+lr2QOxFhVlh8TpMk0qYlDJpXPleapMh?=
 =?us-ascii?Q?sAIOUP+Fk9TBDVZ+w2nuFABX6YYBaF0hePOU0349DWY0/xkvoUb/j++5JgDy?=
 =?us-ascii?Q?TuHZqrUCRVyvHO4DQJ9hIVl3JOAcarJe3ig2KuiX2aBc5GCTxk2Cz6pacw+m?=
 =?us-ascii?Q?531k64nlwVLMORV3bkZ+ANz/LdFQe0fEP3hcDgKU9mzCAkNVo1sGxDCeWuv6?=
 =?us-ascii?Q?T8d769CKaPESbHlHsQL/kWuSXJSCdnxzK+6itDGQSUtxCEM4wyIDAgzPMbdl?=
 =?us-ascii?Q?p8w3WD7DGFDxzRn5FGwNhqsEfILecdP0NHcdlqoMRAbzqsyW9YEvPUFS0/3z?=
 =?us-ascii?Q?qmtlytuWS64nv/uCKkZxvQSR7HAM2y8OdNosZRncwxGwviOsJpsJZW611M1P?=
 =?us-ascii?Q?ocljpIDOB8WeSH2lmyOWHQUouk+cPk2wcirzeKOz5vViNH5HTugwfOziSXvG?=
 =?us-ascii?Q?Xn3XeYX5SjRdEDvyvT/n4CuQ4z9YQwYfa4K7+7WpD/5kHilVr0AdT6DWPpRi?=
 =?us-ascii?Q?Wt0H7SsGnJ7Wvj3fHFN9Bw2zDyGeHw5oYsqCZWVSXhipavGOmHxkwj8MVzhu?=
 =?us-ascii?Q?JBj49IdYIpikTJNfkoYMxPAonIuKquFDkV4kndjJzc3M0bp+FIrmwu3HfsmW?=
 =?us-ascii?Q?Lq+aOLJQLqodQPv/+/BILzDIkI6p5ZmHfhnNnXyCmpkFhEf/YWmdqDuCLk2c?=
 =?us-ascii?Q?c/NYGJHV8BD1RyjQ/F0nPuJy75QmfTKZ/kjtzNI0DmjGqFSvlNdGLUKWEdm6?=
 =?us-ascii?Q?Q731sf4nnRl4g9xIfR+cnP0xvbRcx6rUGf9uaMRNlEDv173a/Cf0eRazUzaM?=
 =?us-ascii?Q?2CfNuGAwwk2E4MZXEzK7dFyDtxMrhhiDIjyv+HbLK0ubc3C4zmindsCKXIsF?=
 =?us-ascii?Q?F4R/lVyb9zqPU3BGhO2MmZhNyoAVGIbwOjUoeOAVOemxLwOM+S4q4e47WLkA?=
 =?us-ascii?Q?ieHQhMP84wbCCW/DhR/k1ZQmJOW3WI8YBqwyxev8Qirl2Savg22VpemAthgw?=
 =?us-ascii?Q?W8UXFI7+bfxue98Tj3oovk1QUOh4mnnaHCVQH+Qs8p4o7MvLu12Iu1+I3i3v?=
 =?us-ascii?Q?j2aoHE4Ad2XuzZyj5FcQp/QHcUMBqZsLwOTp7a3wwXHvXohpitwEBoU4Ti4f?=
 =?us-ascii?Q?zg0nMIPwWN0EMuMq0usmygsMfN4aKwMPrU0oJYGT415TTiAHs7av7tlw7qlp?=
 =?us-ascii?Q?62rSeW5ZgayXtTP8jrysIJ0gzVm2NTD+Tl3Zm/rXvoPSCZb0tf/tBAvTvi9Q?=
 =?us-ascii?Q?mS2vynzF7SYgK0AGDvhm7YeIhWNKzoa3spViEbV07umFyZKSJcADa8amDTsN?=
 =?us-ascii?Q?RfWFFAkHZ5pjxFpeGGOQnlV959PbWlTKLKwyUjqOr6OynmVswVuaofgWb0c7?=
 =?us-ascii?Q?74y3Z41X8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d4278e-984e-4c70-4389-08de836b5c85
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:50:27.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsUVXF99EpNh6KSIXvDEf7zhqYr2lbW7/k7dtybQgyGkIDqMsGwgOlWwzeR01Ft/TzRxDdOcn/5bRaZ/Bk5ang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065

On Mon, Mar 16, 2026 at 12:27:28PM +0000, Christian Loehle wrote:
> On 3/15/26 18:10, Cheng-Yang Chou wrote:
> > pick_idle_cpu_from_online_nodes() uses for_each_node_numadist() which
> > performs an O(N^2) traversal on every call to find the nearest idle
> > CPU across NUMA nodes.
> > 
> > Since NUMA distances are fixed at boot and do not change at runtime,
> > the per-node traversal order can be computed once during initialization
> > and reused on every subsequent call. This series pre-computes the
> > sorted order into scx_numa_node_order[], reducing the per-call cost
> > to O(N).
> > 
> > Patch 1 allocates and populates scx_numa_node_order[] and
> > scx_numa_node_order_cnt[] in scx_idle_init_masks() using the existing
> > for_each_node_numadist() traversal, paying the O(N^2) cost only once
> > at init time.
> > 
> > Patch 2 switches pick_idle_cpu_from_online_nodes() to iterate the
> > cached arrays, removes the now-unnecessary per_cpu_unvisited nodemask,
> > and adds a node_online() check so CPU hotplug is handled correctly
> > without needing to rebuild the arrays.
> > 
> > Tested with make -j only. I do not have access to a NUMA machine to
> > run runtime tests.
> 
> qemu can at least functionally test that using something like
> -smp 8,sockets=2,clusters=2,cores=2,threads=1

You can also use virtme-ng to easily simulate different NUMA nodes and
distances, for example:

$ vng -v --cpu 16,sockets=4,cores=2,threads=2 -m 4G \
  --numa 1G,cpus=0-3 --numa 1G,cpus=4-7 --numa 1G,cpus=8-11 --numa 1G,cpus=12-15\
  --numa-distance 0,1=51 --numa-distance 0,2=31 \
  --numa-distance 0,3=41 --numa-distance 1,2=21 \
  --numa-distance 1,3=61 --numa-distance 2,3=11
...
$ numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3
node 0 size: 1005 MB
node 0 free: 933 MB
node 1 cpus: 4 5 6 7
node 1 size: 1006 MB
node 1 free: 978 MB
node 2 cpus: 8 9 10 11
node 2 size: 888 MB
node 2 free: 855 MB
node 3 cpus: 12 13 14 15
node 3 size: 1005 MB
node 3 free: 984 MB
node distances:
node     0    1    2    3
   0:   10   51   31   41
   1:   51   10   21   61
   2:   31   21   10   11
   3:   41   61   11   10

Thanks,
-Andrea
