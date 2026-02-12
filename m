Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76441DC985
	for <sched-ext@lists.linux.dev>; Thu, 12 Feb 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920068; cv=fail; b=DDPuO7+gWGW86eeW0Q/AJWRHyNzFDmpOBad3yBDmajFZntegi7+darOUat1uYuNoXqwkK2r8nVrhtAXc2swG1WBpvpVYVWEwzGkrXLnDrYi0igKDEty9MWpYRwqMn9hjGleDEHXOHle0UmqplGi59lwaIetU5y+ZVeuQxEFozk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920068; c=relaxed/simple;
	bh=KhGYczB9a+1RziEQsD5KRGiUd4lwNWTaauoEAvZSu2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uQWKP3qRHd0SUrYWDreaCB+ljiYJ4TwLNGuETE1/L84WExWfMrHNb2XyoVWxw10cbXMcR06JYh+YbARPb3t7FLk2RveEW0xAmckzdWkGKTzWVllmHdUq5WkQxgaUm12YtGVCO1wWd7ZPOgd8Y5yzwJnLQkjONjpEHyycimz9K9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NpvGq6E/; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NpvGq6E/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8iJKoFrk9iEuruTGW4W0CjRuFxDgcj51otYLUcOpBa4HegPeDQnGcHzeCqKdIrblx7Jt3mm/50pb7lo4MKUWVnnZkCphgev/lP0hMQ9/2CQiPHKISB2Is6oc6Purry11mj6qJc4VGSmUomx3FzCSr0cdOp4YCfRyP12f9IMVNVu+H/HGKais1+t11D15SVjKP6S5UN6E5myKC5C0YITifOmCPoc57FI4p18Ux9J3o77suvitHMchNWThffi+yXhpKKLy8QXqlRReuFE3NHK1XdOpZwj7uMPfX46rfEbIe2wXply7OA+4H4/QnUCYcgv1fXQ5wPslUx7uEs5uaLEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts19wd6UFfVUKMg6gP43xFYE0AeC77b8P2FaUESHGkw=;
 b=t/plVYYIFuF1yjwan3K4a4zwxRGVUtP+Tj5nnSD9yjWvrP1WExB4El4yMUcTvJCxSfLRgKpbYoPZ/52J1mrD3ADJf/nbxdxcmineusKWc20JMKAyZCDgWjntv+J7vAQoR9RovLRhiDANwPh9calyWefvJeDwkgn2CWYLsjPt9Vv+CiykBPjBQwOyeDIZ8CVM3Yre7QVj9JKWoMpKV3ZRkrVMoqJ4opwodyd9XUsu3AiLNXJGfyHuED9AeF1fnazrLfJ40CkRl9iHVtIGN0R+dy3e8iYE8MMtqzU1YUPiv5sMH8QiFctYEoDq/flirV1MtbvQL/9AAx7+NZnFi+Up2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts19wd6UFfVUKMg6gP43xFYE0AeC77b8P2FaUESHGkw=;
 b=NpvGq6E/fNN8v8qvjW2+TsKJLTb7D6MWpWkRuU3rw8LWAa9GF8G1PyoMF4/qfiagLnsaCIR4CF3QVJXwmB6RrIrEcO5twFZlJ2XkUrbQlre3kzup9Txaj2E3HuImtzj1h6x6h/iXgcUO/PmdsCmLe8r3KVza5K7K8bKNm8t1kKIJM7hntvKODTFQI7S3/HEKeS28urEsIyHytWCKZqLiQ5nVCyktTERG4tZtJFB2qSM51w00Pi/I/QFIHS0+brfN8FMr20g8TVj0IjO6TymO1hbrDfgfrZFoO44G9QzMh9MVHDMM+sfljHAh4uwFMroj0ZC8m2OSS/xndNaf8giUBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 18:14:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 18:14:22 +0000
Date: Thu, 12 Feb 2026 19:14:13 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aY4YdW79Y3FBM5jo@gpd4>
References: <20260210212813.796548-2-arighi@nvidia.com>
 <aYu9KzKTMfNIFDwD@slm.duckdns.org>
 <aYyo_ALV_BT6WaE0@gpd4>
 <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
 <aY0EDpFD1FSrigB6@gpd4>
 <aY0EmUnmo4gGitcW@slm.duckdns.org>
 <aY2ofYcZpni9L0px@gpd4>
 <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
 <aY31pzTFyZ-nKK1J@gpd4>
 <aY4IuX59PsmSsi1g@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY4IuX59PsmSsi1g@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6df822-d1d4-44ba-c7eb-08de6a628c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5X46YPXTHX9lOlmIT5xZq7grfNyQ2BoDtDqjxoHjjx9H2KxzBFz2J8CmNfwH?=
 =?us-ascii?Q?xIoNmc9m43W0UNm4YoJYOa4BFcsdECLuaxOD0P8P0igIiskvZRoJIhcrYHrW?=
 =?us-ascii?Q?RYZbimIeLUxtN8DCZJ6Ry01E/5qBOWD6SBmf/9uOGPBG0x31QLuNoj+UJd2k?=
 =?us-ascii?Q?XFS0HtG1HKmtUOP2k8mtrD8Nh8etkoWGfrK11VgaLZTzvNZWLS7LXkY10bb9?=
 =?us-ascii?Q?lX+QR5JpmCdm3D72XG7MjKzctWzSnTsIgWAQTLvAho0HCN04UwbVHH2tyOi0?=
 =?us-ascii?Q?wPJunX9k1ETQgqAQIaPRIf8uljnoj6XFxh6ZeVlxz3mMNd/WEZRrcavt6rzr?=
 =?us-ascii?Q?oVhR6XxmXPkUFbQyh0WUPMS1bY/1BUWAlbc6LvW6qvuhoha43aAQVcAL3Zyn?=
 =?us-ascii?Q?x+22oMgnQnPbNvzfhLo18fhyf03lGpDy/tv+CDTyl5vbSlg45fT29Ibuw2ZO?=
 =?us-ascii?Q?svFjs+W2RVEkAzVGN4Bb9v2RNiTtgN9vNdVyDDdQQUnaPsFBaH0YQ0Ate9Vr?=
 =?us-ascii?Q?KCWTHwsegPTToKjScPnTOc4ODtHyXfbhelrPeC3KxvBxf/4AExXoA72YgHrj?=
 =?us-ascii?Q?mLvOfOd7xjCPiVM3fR7zypPqKn76rpZjCDN1hZ/JVLo0GJXrgiHExod6/Zk4?=
 =?us-ascii?Q?BhU6CD5gWuVyWXqSBR8xeVI3RKwh690xYOsEFXI97jK4Z6O6VpMmgZTMuq+r?=
 =?us-ascii?Q?TJvmSVS0a2guBHrcEYiuYe/led25mO4CVl5e0jXjJCYR4vn7PsxrbGttZQyS?=
 =?us-ascii?Q?9YuMGRErT/VXDS2VE0ZsmOFk45whYA3YqAuxeNqZ7ye8KVdeEhuGC2zYpegi?=
 =?us-ascii?Q?zYj1mIswajhNNbfu26JnNw0nDrjyGSJQxCPWzFtEDe7k7159WCjGixP+7YVD?=
 =?us-ascii?Q?6F5WV5Cbzx9bYxYTagjheUbBNzt95SDnzV7oL5iy++MFj6iYHOAMlQCHbhxq?=
 =?us-ascii?Q?lX/yQqJdsl4MiDamRORHa6VECNrJ9bLx/i4f1OvhlNP/KZOITYLeY5bIUrPl?=
 =?us-ascii?Q?DrrTMeTR12gBFxVfH9MH+PC/lRNfxDdVyetKbuzHozYOLau4xhh15FBHIWib?=
 =?us-ascii?Q?QUW5d6PG5eFkoEhSd+acGFjtCpLY4XyvtpAyxVm9tx1KFGA9a0d5OU9BDo7D?=
 =?us-ascii?Q?RPoYmQfBbbxDXv3FachHenl7DBAajRE7P98A7MYYrTy0k4SCVnJdrZzXA8pQ?=
 =?us-ascii?Q?rfhMDjZlt8K3Moyk/m8pMW1QN7KOeMuw3bZchmc5lmAE8f6GKlKEIGlatRMp?=
 =?us-ascii?Q?hdvC1QcuGvahELLjtUre4IzMf7Ikf+x9fyPCqBsYktRgYVizJeB/CJluCGLU?=
 =?us-ascii?Q?l/znrhbo0IiHujnoE4C6BfDvOeFQ4MZ6CzI+RIj9+5O0b9JfWJdjcdbs0I5V?=
 =?us-ascii?Q?prvS7xR7dlAbU3pWKDmnKvohYRChQH+Hdgouw+oF3f/KeykFDh4Xt0oEQMY9?=
 =?us-ascii?Q?Bry30KxoKnVEa2ZqemD3Mws644vJursILzBZT6n1ch7oyGw2EtGb+aTAuF6b?=
 =?us-ascii?Q?QEqZ/AhPu7ZkK1g9Vjfwppvfq5fUrwJ08omaAxuHcMicGMk4uS6mAqt8JcbI?=
 =?us-ascii?Q?KfjiKvwrWXeQXKkIiuk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uboc+mBMPCdtfbFLMTb95CJyg7ppTFjJO1QZO5432ZZd0ButMBpG0ZCet3bP?=
 =?us-ascii?Q?seXoGYC/1xyQgAOhLkcdCsl2Tamtfu8do2tCLa70gGH3qtFys1WZq9dyH4/A?=
 =?us-ascii?Q?fIxGitHiSfu7SdWO4i8u1u/2XniYx21c2ly1LwhPqmr8yHkdxBN8C7hdStu2?=
 =?us-ascii?Q?B01+q5bGox+Yizn2786FMgDf3vsk8xtGZJVuBZBeUvV/Hm5+cUmXmGJJ7u09?=
 =?us-ascii?Q?KHl80PgF7k1CTHeuVkdqLlV93NEg0qP6UoSL2tcm/kHlRQNWtSGj2exqAhd3?=
 =?us-ascii?Q?tCCzwz4Rli0/2imfA9XW/mt2Ld8dEq3h3ZthawLCrQcsXWngUgfyQGoqiJ8r?=
 =?us-ascii?Q?PKpLXXt0hmVz69VYSsXOJrTQunRh3/NRoxEKdNJq74vuU7FEcjyuteVn4NmG?=
 =?us-ascii?Q?sj9ppRIraVTHq6rODFoGhJZwm1uzYwF+6Z2Cvj/ytsq+U1DPDT3vFiDOVX7K?=
 =?us-ascii?Q?uYGZa33KIp1SuErl6X/0FvqP4rVVGjDeRCj/e9L9treWb4uI6z765MS3tQTN?=
 =?us-ascii?Q?Kn+8IS8OsnJ0PXV3MiZu33HujxoRfu5JWhAQSgpGgGjP4ZmhY61ylWpU6kVE?=
 =?us-ascii?Q?FwoHkUqnVveQjNmIeUPTK6licZce5vhCDYdXWF4o7pcAuXRdaLnTB2SMgu81?=
 =?us-ascii?Q?LiKK42z0W+3qc++Y6dXMPD33330d2C354fNhtrun6XD2Nw/3Hcrj/HBGZLx7?=
 =?us-ascii?Q?Sqs8tL+CzSixkc11y6PeXD2lWFDEsgTSD1W2eFizgWiKQlMF3fl6lTqEi7Ef?=
 =?us-ascii?Q?Q1FQpYtQfAuSNrdL8eH70t+4Sz/Od/KHEkFZPfjFgcO/R6UGqzSlFB3bK8wC?=
 =?us-ascii?Q?ON1Pp1vMyBZFa5z+Ic1dUPlgdffVLfRAYOsWcuZly7uIxgs/juy3yTiWHc+s?=
 =?us-ascii?Q?Y6AREeQmqfiKu7D1EkjAbkfqDMUy+Kj7S7ILsrViBKqxxsMziN8v6ya4kFML?=
 =?us-ascii?Q?XzFGd7AmUONqly2SWijS/uV1sRrr/QrhmORs9WJjdkqJYnS2LQyGLZX9br9M?=
 =?us-ascii?Q?qfn1RE0E5UfyAOQLX0R2z/dWKmX9bE3b07CY7eNh1c6TTMcQTyJCv8ZgzoiW?=
 =?us-ascii?Q?grP8v2u1LrdQOwIiDSjit2J7OZL44iUIr3z3yrdrPGRWRaZZeFhitkG3gb9K?=
 =?us-ascii?Q?INt9wfdIrRHbVmtK+eEbLAMJqAlaR+1YkF7OE+Vzyv7zvMrfFQsP4JVKriex?=
 =?us-ascii?Q?srqIjlrFV8oBywyD41cLRkl689GkpZ6d2GQqm6wMfBUL+u+JnBgIXb4JBDrd?=
 =?us-ascii?Q?4jwtIMif01NO34syHLL7QiebOwq+Wwale5pKjXbKPV5ndX4OiRCpRMT5JU0d?=
 =?us-ascii?Q?DxzIvjKaBTwDMPFHx7mKrK58lCzZcM6X8hlu8pfNMKrrco9JiPYjI0qHTiAl?=
 =?us-ascii?Q?6JoKljPdimDDwyoqt/ZCqzUoM7mJ7RMmurpW55cPpFLTtW8VpxWooS0JQHvh?=
 =?us-ascii?Q?QA/wGciDsPZzYJrDMS2pjYVSbBhZ054vXLDYpoGkUaff1DG23ellV1hUvXZP?=
 =?us-ascii?Q?HzXoSuCxjGeUJDEmcNRg64xoeqP9YTIvw/M/UARzYPMhcNYTVjV03xxek2db?=
 =?us-ascii?Q?6odLHpnazIqD4DnE4dTZBKq3nBikFVfLCBK+U5rMpCnCtXm4JrB8HVgorlqK?=
 =?us-ascii?Q?8qQ6SxJR8ybXFlyASDxpApccoigo1HDMp14UpmlurCMwvjMvI5vKoeI0GZ5W?=
 =?us-ascii?Q?1QTcxQQ7bJ9Kglwm7eTovkavJ1Si0Nc9Ro5eblE6ECByW5c//XrIyZx+aPPM?=
 =?us-ascii?Q?+BtlS9Sk3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6df822-d1d4-44ba-c7eb-08de6a628c1a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 18:14:22.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJab74ogKMRFeKIXGtR+PpD6hBX/eA9YvXjkJZntTLWWsBumPWsdCc3PteFCyN9wqW20V2ecpyDYuDc8g7eBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

On Thu, Feb 12, 2026 at 07:07:05AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 12, 2026 at 04:45:43PM +0100, Andrea Righi wrote:
> > > > So, we need a way to mark "this migration is internal to SCX", like a new
> > > > SCX_TASK_MIGRATING_INTERNAL flag?
> 
> Yeah, I think this is what we should do. That's the only ops.dequeue()
> without matching ops.enqueue(), right?

Correct.

> 
> ...
> > > IIUC one example might sway your opinion (or not):
> > > Note that not receiving a ops.dequeue() for tasks leaving one LOCAL_DSQ
> > > (and maybe being enqueued at another) prevents e.g. accurate PELT load
> > > tracking on the BPF side.
> > > Regular utilization tracking works through ops.running() and 
> > > ops.stopping() but load I don't think load can be implemented accurately.
> > 
> > It makes sense to me and I think it's actually valid reason to prefer the
> > "always trigger" way.
> 
> I don't think this is a valid argument. PELT is done that way because the
> association of the task and the CPU is meaningful for in-kernel schedulers.
> The queues are actually per-CPU. For SCX scheds, the relationship is not
> known to the kernel. Only the BPF scheduler itself knows, if it wants to
> attribute per-task load to a specific CPU, which CPU it should be attributed
> to. What's the point of following in-kernel association for PELT if the task
> was going to be hot migrated to another CPU on execution?

I see, let me elaborate more on this to make sure we're on the same page.

In ops.enqueue() the BPF scheduler doesn't necessarily pick a target CPU:
it can put the task on an arbitrary DSQ or even in some internal BPF data
structures. The task is still associated with a runqueue, but only to
satisfy a kernel requirement, for sched_ext that association isn't
meaningful, because the task isn't really "on" that CPU (in fact in
ops.dispatch() can do the "last minute" migration).

Therefore, keeping accurate per-CPU information from the kernel's
perspective doesn't buy us much, given that the BPF scheduler can keep
tasks in its own queues or structures.

Accurate PELT is still doable: the BPF scheduler can track where it puts
each task in its own state, updates runnable load when it places the task
in a DSQ / data structure and when the task leaves (dequeue). And it can
use ops.running() / ops.stopping() for utilization.

And with a proper ops.dequeue() semantics, PELT can be driven by the BPF
scheduler's own placement and the scx callbacks, not by the specific rq a
task is on.

If all of the above makes sense for everyone, I agree that we don't need to
notify all the internal migrations.

Thanks,
-Andrea
