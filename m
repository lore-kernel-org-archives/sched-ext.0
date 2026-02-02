Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C81ADC83
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024404; cv=fail; b=l17uMQbwQb2JAePc0wTTHV96nkcyrjxEEEJi5t4/j4e6mqvmD3ab9YF7yMfVwhmcrcYVsbSBJbOxIbv/SMMDoE0sJOdIx/MZ52JMhjb291GDKghkdnStnJLgFaOGr0v1V2mPIjYaOs0qDnMk8ys5hr/E3zffgJ43Sdzh1/CEFxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024404; c=relaxed/simple;
	bh=PJsiiRO1KV3elHAct9QEMyVTt7RJiwCSe56S+crUgTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T9MNgRTn66reQrcDlXf/sx9Iq8TkWDW49/1D1UQY9+5q+iRaUIhy/H3yCbETJQhXGCd+VjwMxIrF0NRcobyxrSmyEbUzURdChK95g4MLtg6wRTRgccqEyZUd0zB3GklpEjOX6G+UyAQEQv3DBPX2qIQhaygsXXlU4SsZVPNlPBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fwXhJlbT; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fwXhJlbT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfIpTVyckIYB6LWKQWyYwpICQpbroojTOCuMUyJ1TMFwLDWQ1biDmsD+ODpJFUDszBwjAH/eTCEcwQ4B+rrz//T+hKe6PwYFyTrA9Zc8p0tHOYS5ZpEdrbD8VXRb4/5ANL8NhAGNInGHP38NhktPoTKRV4oqWCXITSlIhPxwwqT+8R2/vYUEfYhPGpYP4/uCadUfuGhSzpwHcPJ5uZRfVGQR1ZzBRvFhnY7/TdP4sov0tBbaPtJ6dGaIIL3BKSJ4bHvvO/qLR2AFGoMDhYzd8Ca6YdmtDLFCnZSPXqb87d9DGxY71RCT+kiBb1U/XwOeOnzcgMShdSqv9dAIaEVLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5lcat9hfV23EbwmlVvC6JzvnV+Rqf0ER7/FGp9vILY=;
 b=EClUeqAYewsaQX2u6bEeziVsWqV6z5+Tmbghjw2spdKAI2ea4BJAL36WlO6+W6uoZYG6FY+p6OWb7WYdF1arlzx5WwWHVOSo3iPQ/H12fuH2BBsGFyq35k/2PrsuW6KkIMVRJSXJRZnClugTnkOlROkeDVAl9mcKzpUW3Mwnt83XELbb+BNPWAm+O2SBhjR3VtUmo+6l4vJ0CZrNAASxY3eDi8Dn526OLfeQ7Hm1OjyJoYzAKgpIFcCy2xLOjoB/2Ys4TACLLhqux24PUyBwXYEWKQKcoH2GshcOvzMCp5vGUVOuB4dndrZq4XOZPAUkWsvY/ZQrxvqzCOBw5dqtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5lcat9hfV23EbwmlVvC6JzvnV+Rqf0ER7/FGp9vILY=;
 b=fwXhJlbT/zZmvbc2IAT0Ih0MF045LSXPh/XtRzCqXm0bhn/1WJnEKujF/aZBLIZ0z7XOQjsaT/cJUOUClKzEX1c3l8Gyl62OQVp0f/c6BDu52rIHkfhRoiVqzTlV1MUJj5d0JuR78XDZ8PuigJNMqxjN08OJC9Nact8o7eWJo0Y9at5M3izs1VhbD2rjAfvpMNbUMdInLpEiExEWqpvwQvphzz15P5W+ecILD7PIpDh4K/ou8H/gS3VDoFjNmj0DnsaOk+4mrEchHD+UUZnYjxVvCow2g1Bo7/OfAAYpSXNieRZXBdjgJO3DtASOlQ5j1tdH8MdSkPO7LxdgGZJt9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 09:26:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 09:26:37 +0000
Date: Mon, 2 Feb 2026 10:26:33 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYBtydrekCC-pPL_@gpd4>
References: <20260201091318.178710-1-arighi@nvidia.com>
 <20260201091318.178710-2-arighi@nvidia.com>
 <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com>
 <aYBWAzFDX8Rv-paN@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYBWAzFDX8Rv-paN@gpd4>
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 94121839-12aa-4d40-e79c-08de623d2a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i417qfDz/1g45rpvg6FLLrUiHTUqeDuKE5tMcL06dPALdTpwOF1T56ZHArnl?=
 =?us-ascii?Q?XZqVGUaBMez5HWG7DQyQ0ZQWu6Hjxr1Ue7vwpoYXjOKdUmqXGvACAGL4KKZK?=
 =?us-ascii?Q?5iMgkvjUzVBw63rpO4ZT7rl8UJV2J7fn1IFgL5vC/FNTi9Y7Sp/l10H9Kmn+?=
 =?us-ascii?Q?WeUZZ0tmsmPZf81uX8SOEqmbQvwRBsbYzwx9Yp0BT6bpg75c0kvfuTqBhfMY?=
 =?us-ascii?Q?TzgKPICZp9inPAa01OdYc6xpbLs3OiaXz0RatDsUvTIvgOyzHLadKzV+2pUq?=
 =?us-ascii?Q?gn5p2M6BKPh8v7rGkSv/dOIHLjtc7ZpY4pvVb26LkDcukMZ3VRekJJOX5lOo?=
 =?us-ascii?Q?MveNMDuGSAkcFF4NSPL4xvPaDbnpm9QzOwA59EOV80VdbxWvIfEG/TBj/H5H?=
 =?us-ascii?Q?vQ17Ox3nE+8cuOre46BbIha2gF6CJb10p3rsawbCo9EwTvxlxzEP8uRTw+2G?=
 =?us-ascii?Q?gCRL2/WMNPOq4YRCC8jyHNk3DKwARErzu5MOtzT0k9h7PwEEIuugsHDUYmkf?=
 =?us-ascii?Q?xZG4bOMpvZ5NGIiEDEFK91if/e9kOxieDleUT9cU5lt7km0bcsBHP3Tht7qR?=
 =?us-ascii?Q?w2TGx9C9ke4zbMzJKqqQic51TT5TdVsxme463I70ki2sSyGkT0vzkdE8rYX5?=
 =?us-ascii?Q?DwfYxtMsEb8N8xijo+2AZCpjnEw9B3VhL4ZNLdwPczYFkaZGYI196kFo0eN2?=
 =?us-ascii?Q?Wkp7czvVQouVloLeCygQrtzRoIe+QXC0QfqLM50Du1A7ZTJEcrFIb3hRz23m?=
 =?us-ascii?Q?QBroWXG+9NKxsbkDvPjtnIxXj1YmRpiLI+T5eePGVoH2uOf8dL7JZFn11swk?=
 =?us-ascii?Q?xBT8nSrc0DT7i4Hddi9iA61GfKaFQ8q3il0Vbzz9IEHsR18AgpZ5xa1w30JX?=
 =?us-ascii?Q?L8Dt6Y3CtnA1653Xmgl5mADgYblL93UOTzS5UOW4MdTy1sJuNPTCemXTUUCl?=
 =?us-ascii?Q?wBC2T6KEO2JXU0X5bsG1e99fTU017ohTPdGiBM14Nx/7ZYcAtBROI/P0vkbk?=
 =?us-ascii?Q?x9cITvcghsyI1A2KHF71cNw0o13B8ThBG3Tkwsz/5oyAFJ3snUmi9vB/sQp/?=
 =?us-ascii?Q?t9PzGnDpYGjq5CjnOGzCydoaj+dwJCocg03oL23Qq4UUmF0kCpgBOVK7m3Be?=
 =?us-ascii?Q?yfIf4JvLFj72d/yt6Zr0eUeeVwo98dIxgucTP/M4/kq/aU42Y4uvbjnmlITb?=
 =?us-ascii?Q?rPzOy2cXa3+EncOx8ySQJDlQc0I5JJ8MZeziDCJwRgICfSSj+Opb7jjvqifW?=
 =?us-ascii?Q?0lj4XJoAfWx90Ti18pf6mRtf7qyUHnbapbYwPEeC0xWN4Dw6rQyrS9ZisEF2?=
 =?us-ascii?Q?XUXEDsvY0RjzEK985RSH/1uavQoqWL2vQeI+/wi8aHMK7Ufuf9bi4MmP2pom?=
 =?us-ascii?Q?iqZi4XKgrWkSQB3QIQwGvQg1gXniQtxuyM9qX6RPFBTbp6CRkY6qU3lhIBuD?=
 =?us-ascii?Q?X6pNnI7oG6BDlFBjiwKz7BtIE3383EiFlqYQXnB9HWnQXEg2zYf61cuqfM06?=
 =?us-ascii?Q?4uFy6b7jZeFB7b5ov8ny+T7O2e1ajB7PiIsPUb4UGXOS/tSqrm3hUVoHy+/q?=
 =?us-ascii?Q?tVqItBSOJC8DK09I/xo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FplKSz3cLEqAqKZCNPOw/lBAO4JrBcpcLqZyLz0zBkiT0+Xcvj/XbxVU3ewk?=
 =?us-ascii?Q?Mnc2K5+BtMXUgBMxTwB+90aVsM66Nnm9rLJmrpsrz72cqumhIEakfpKax73P?=
 =?us-ascii?Q?PVemmhyFmR0fbh+T8TcMJ1l+h3bBo9ISQ83lwJamk2l+D+1IGhrnL5LzWEfW?=
 =?us-ascii?Q?QOZl70z/LZq2bGyserFTqeL2IJoBIZyuO38u3Zaz2m/pO1KAh+Ro2hN34Z9p?=
 =?us-ascii?Q?ZvLYd+Bt8Td4GkySloCJWptJng0y78dpfpNU+Dno5RK1jTD9BT6LrXZS5IU2?=
 =?us-ascii?Q?vB4MJ/q7daHisztJijFOrP44LMdMTtHeqvmGjQ+LQ89gdEgTHHVN8U2vh5o1?=
 =?us-ascii?Q?w9/j1cP406Mv2sqoNx6iP9HL8sZL1Sm+RdolKfpLTlUgTzL5IT3gAXIqi8pk?=
 =?us-ascii?Q?B6RWNQo/khxsnBINbof9QBXTV3u2qgdtO1sRYofB2WkQOD4tNn0GFf4yDrfb?=
 =?us-ascii?Q?iOvrlFBb6/yFn2V0QWahrBTrIryq5Ms/9cxY9+RJaVlhjcAdrTfzd2E1P+/C?=
 =?us-ascii?Q?BOM1Tn98qLSYt6kp5SIjnjycgsBiqgGugjaFZeh3JLtSJOBtoirujQlB5y7H?=
 =?us-ascii?Q?x+8JQmiu+h+rTouZRGyy9bYzVBv9PF3sloEmn/iNQVEAAMfBMTMBgin3TMj0?=
 =?us-ascii?Q?xXQia3xIcWxq4tyPmhfHs8ov2Rr2NxNnYV+XDa4bbNsk1Y+qVDd7NA0REy6K?=
 =?us-ascii?Q?tifOCKeSwpZoyPuIs8x6N4waCFeW4wNIItXPbSW/WkPgXjzIHkBbta+OLGdn?=
 =?us-ascii?Q?1AzkTlYv0rYjxnVv+cfzz322XqB5MFDm/Zx0i4BuMZaI9hfnJBUPywWRa6Rv?=
 =?us-ascii?Q?2tv1Lpqmy7hHZSLCGYgZrPjFQX4SX6qLgDUfdF5d3SnpsdDsJsDC5gRwzpaW?=
 =?us-ascii?Q?bqWbgQrBYtmsXQwCSH62WNXMaVJpwDz+P57vhFi+wtgIPtLdfIdwSiGJsUsG?=
 =?us-ascii?Q?jhSzPLnn67aH35UKoqf8paILqmqc8uj5ga3HR2yxWHpAs+6P0QEJOMNdAyMh?=
 =?us-ascii?Q?qkzHguHvNR+p91WwD/kCUN+e3NdY20rpUCLsnIbqRDc0ZR3v30rfiDBc2ckB?=
 =?us-ascii?Q?UF1c2InnCf4DkwskThGLlyAkZKQ0TGVqJFrSSsnVpoqvwCJXl/yuqMP2hsp1?=
 =?us-ascii?Q?9UvAmW9aaV3E90Lh6NsvvMHBykT5ERdOrUBPfo5S/8d+9ouu0nN3hf/1TqNU?=
 =?us-ascii?Q?InmmgGtX0XBXp4Mpiqv9FwSj8E4DEb+mcdMFvaFG8G2M918FCHnBrzg7Zio4?=
 =?us-ascii?Q?V/rIYeecIy8qeQdZJrhpXE+dWXZ3zHAjSmqe80i1AyDrvXOQsAhvYDW/6l75?=
 =?us-ascii?Q?1UY6zRGqsozYlHn3K30zqAmB240SnhSjEJjZIVxsuHoWtti1nVZxj9+xbfPz?=
 =?us-ascii?Q?ld93wxbGgGB6IhI7mK4SLCci89PgwZUdUhUf9W7l2+rq3VWeH0VSRUZ7Hh7d?=
 =?us-ascii?Q?qh0b+C68nglt7N+ohkLRzyuB21U64AB2RrL2Xh5WPqHhQKGvodgDrXCTXS5F?=
 =?us-ascii?Q?p9aHZSS2+pnYYMIGA4YYKrcsQq1Q0fwL+6H2XZvRIQJU9MVtI7JwyUfCmttM?=
 =?us-ascii?Q?eAoxuvsjx1tLVaX+ytjAhQF1JTezndS5EtJ5y2yJHXWcImvWaWKXHUoGfi6H?=
 =?us-ascii?Q?VRgdMfvv56x5lL4VoMc11S/wDl1X2uRRVQZWK+B8ZbBb071GfYPd/LMB0k79?=
 =?us-ascii?Q?AS2zpkkvrUwTvlnaWdCLKNtB5cCFn0Je251LKAiKFjw8Nzpo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94121839-12aa-4d40-e79c-08de623d2a0a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 09:26:37.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atJOoDEjxd/IqdMTs0WlLHebGvlg8w/7k25w4cMPHgdhHspZhMiHaAVPrgY++K+W2YvpKhkXFR7G3Dz1EfJFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686

On Mon, Feb 02, 2026 at 08:45:18AM +0100, Andrea Righi wrote:
...
> > So I have finally gotten around updating scx_storm to the new semantics,
> > see:
> > https://github.com/cloehle/scx/tree/cloehle/scx-storm-qmap-insert-local-dequeue-semantics
> > 
> > I don't think the new ops.dequeue() are enough to make inserts to local-on
> > from anywhere safe, because it's still racing with dequeue from another CPU?
> 
> Yeah, with this patch set BPF schedulers get proper ops.dequeue()
> callbacks, but we're not fixing the usage of SCX_DSQ_LOCAL_ON from
> ops.dispatch().
> 
> When task properties change between scx_bpf_dsq_insert() and the actual
> dispatch, task_can_run_on_remote_rq() can still trigger a fatal
> scx_error().
> 
> The ops.dequeue(SCX_DEQ_SCHED_CHANGE) notifications happens after the
> property change, so it can't prevent already-queued dispatches from
> failing. The race window is between ops.dispatch() returning and
> dispatch_to_local_dsq() executing.
> 
> We can address this in a separate patch set. One thing at a time. :)

Thinking more on this, the problem is that we're passing enforce=true to
task_can_run_on_remote_rq(), triggering a critical failure - scx_error().
There's a logic in task_can_run_on_remote_rq() to fallback to the global
DSQ, that doesn't happen if we pass enforce=true, due to scx_error().

However, instead of the global DSQ fallback, I was wondering if it'd be
better to simply re-enqueue the task - setting SCX_ENQ_REENQ - if the
target local DSQ isn't valid anymore when the dispatch is finalized.

In this way using SCX_DSQ_LOCAL_ON | cpu from ops.dispatch() would simply
trigger a re-enqueue when "cpu" isn't valid anymore (due to concurrent
affinity / migration disabled changes) and the BPF scheduler can handle
that in another ops.enqueue().

What do you think?

Thanks,
-Andrea
