Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299842314B
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221257; cv=fail; b=O01PlcOjFFeAzD91awOMDtCwIHGvKa41p99rFIQFOqmrdtV+DVxd+ma68IomesijSNAUgGekqNGqe5AKPdApj9zyS+u2RWrk1+SlfkPb8msugLDAt+gdf2jkY5+PSth4lhu6T7hag6C2CiON92A+OkVHrc8jDUMrFndgb2Oz+GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221257; c=relaxed/simple;
	bh=XMQ6bB4n4w5ko3rZbJYuNSQmJSc5UHhQ/nfxtjK/9Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBjgJJQP71AqqUx60c0H2o1aqtlyJKaGH7qwmce02gkxLXqiRcnjbg9nxd46zF5mofxeNw/do270VA1nE9/SkPnbwMQJDrD4n4AV7gAWGcc0GbQdtKdw+6vuUbi8uhioQZbbYX9h3C3XG4k4klhuGFfrfRS9perLrJm4vDJHF2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PIIzLl+i; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PIIzLl+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkwEePd1fy/aPyjjBxdNjA/mWCO2i343Saf98PrCebKVlTZM3c5GPOC4SwrVyCNNUGhoQcCZV77oyzG87GMGQKieQQ5hYx+XDbD+XIMblMzEKtRCWHx+qFzGGNf4LiDnzvc4ZX+FzmmzcgGS4rVrMKylC3qw+hMfbX/NAwgZd9xvx1lrC1VFXioC4uJfiNtbcg6EJS5rg7AjIj6d/mpPLDzBjGiDv9RUcXop5EQg0sfQ0i7FRff13SIjnXYdX936UciAuGY86jqKxalgJYXugNXnFJWN3F/nc4+7N4KWw6fSKy8b0ZQDwpZ88eNeHx3kszo/RbLK/MdsVrkREL5wpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoCNaCbnL0W1nHEhgyqoCZG1GKlmTomCwYhXQKB7JgU=;
 b=kqHVjQF392WUPH8GEtu5roTwBo5h3ti/+S39XBylU8Xw+BsM2TLOjsqzFy9TQ2E1XBsmQuWwy4OXWABjv3DWBWrjz924HgCk9Vo0wf518akZKiXTvVxKt9kFtQMEeWKl7XYjSARQkxw0RHAkaNPpsGYZXAb7UxfVRzpYzjaa54V/nb8gdl8gwWE8z+O+nhLc9xv3CBmrBx+gYpkLKVINK/i/hZYHuM0JtsHeMOyZTZN6eI2VswMHWcFbHOX6kuv3l9eXYpZ68YlKYNIvlvXkNzSnSH1kT51Na2vvErlZkUVyiDqGFQBRewbGI2laSD1xwv2NSbFniyCQDpnA4XLy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoCNaCbnL0W1nHEhgyqoCZG1GKlmTomCwYhXQKB7JgU=;
 b=PIIzLl+i1HzUTylBxCvEk/qNIaN//935s+S5uNCYRfzMTeZEXgfg7C9tyZiIQP80Xc2tQ6ZbmZ3jpc3gL8EkSQpxd7yPsSQ0kJEfFNTDjKMN2E+NNfGnW6Xj5EFgwbH2+o/sIiDw41DDblQjM41woNckrY0pBPKfgyo0JxoMsmgu381BvKmTSn+rlLRjuAb2wtql88r4U5GYjIpmwJhxItWYzOwToim3MKw84+x1IIvndgA50YvkxtDFxuMRefMweIKIPyEjCJLOiwqp3xiAm+wCKP+LJbqHN2n8t5FF5Z05oJ27yt9g2Cvd4PaOiK6jW/RW3H66BBaYKl+Of/9+jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 16:07:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 16:07:29 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Date: Wed,  4 Feb 2026 17:05:58 +0100
Message-ID: <20260204160710.1475802-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204160710.1475802-1-arighi@nvidia.com>
References: <20260204160710.1475802-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: f2afc006-241e-44f1-2338-08de64077eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qxaSLCC2xGlTvLHrwtrOOh+2ApqPqwBSzq4HBI5PaGkGJwMaHazh2sYmdVWM?=
 =?us-ascii?Q?V2L03BS6W5Bkch4ni42fnE4/EoFcJBfJNASAmLQbqg86ENRZDzFc72gKXhXj?=
 =?us-ascii?Q?PmWyd5CsaJBCLC35QqxieMo5oeo4T67aDqrU6308A+Sg5KjANnOcjGxE0BTQ?=
 =?us-ascii?Q?SXrv5lzuYVozU/g5KSvgVhDInSUeQ6gy8lLxx10CaGa0yxH4Fwoc43d64u8L?=
 =?us-ascii?Q?zVqMtMmf2xUtWzMnncD6xEfIMCmjONs9eJBS0kC2ndPL7KE0xskM0uTGDuAM?=
 =?us-ascii?Q?8m9V6T19MjSk5qW9fiogO/Lu5RHllYuvgL9YomvSUN6TXeLUVq1o5AzMCV1w?=
 =?us-ascii?Q?YZUEAco9c7FXSyFFZLrwWmyehgF2qviNODuyBwZr9GrMzQ5KSHZ6fHNXjCFj?=
 =?us-ascii?Q?JzDODIhf4B1ZIN3C7aVGF6ie37pL2Nl3+lhBoca8vLkO8cRYj7S6bBUdJUp5?=
 =?us-ascii?Q?kxkuRHfiH7cGxRccC4stTA42md9s8wE9C0TBlfMZYm3Fe3WwaJoB/Qbmcfqa?=
 =?us-ascii?Q?th5vStK/9D2t+C038vRdgBHKipTiIig5uhUHfm4m1D/e68gQqz+gPubHZbsN?=
 =?us-ascii?Q?le6OFd1XyetaagbtBoelC44V/v/Rmg+Ajj6FsbIWk26zYiZxzswttAmL/WKG?=
 =?us-ascii?Q?hzmO4iT1EH4Pno9zAHjumODAxTotmNbaK1lpC3TzblpfVcGHPdiY7uIMpeBB?=
 =?us-ascii?Q?cob7MDOkaH0rWVk68tCsWm3lmWMcLdPg1GCVjzn4MsNxfU80ezEUh3UviSYw?=
 =?us-ascii?Q?2zysD0GbENF6Wj43bamwRFilYsr9SaOtiX4xUN062KaqPvD0pjwlclAkS/jn?=
 =?us-ascii?Q?dWQEO2UfbfmZhRpXKg0ZhOMyx9hbRrgpBmxEZlIqLoIFad4T9fEwS7KzzcXU?=
 =?us-ascii?Q?pcPA1pVwMjO6T05LhKIqxzUUrs7VeKRQPpfVls/6boNXX7QOHq+5dSOquuIg?=
 =?us-ascii?Q?EjnF3/Ev9X2QmUQSkVKXuI902wzcMxUF/KEZpVJFji7iKU90WtgbAvugOlFB?=
 =?us-ascii?Q?sK7cUkXZh2q/zGGGIQK+SgEZOzpNgYVwrxM4fR9Zq3V3hkKS8SMPiAOvjrYL?=
 =?us-ascii?Q?4qcsTuhWJrzFdmJ1Cg6no9yGYNnNe+MfMeJYKSKyXtEIkCLbvY4HCtlcsmMi?=
 =?us-ascii?Q?bKcSx5MQOC66rfBFyCILU7k6qcinKUZPdkDszkZKtjt77+6jwvBJC26RuiyM?=
 =?us-ascii?Q?YiXqxfrbryd6pUERQirC9yh07DX+ziLv3DS90dGA07GbGEy6FaUkNXFqdowO?=
 =?us-ascii?Q?rWFWUrHHhjvsmob+PX1dYPbJIEyE6BkYYTDaZUv62CJcQsnKRnGwNKiN10Tm?=
 =?us-ascii?Q?aW+W7gXZWFBL4h3EJHAngoQqdM4bp9Jbb0MnEOJwMX2rYJWOPZfN+ZPJ5naW?=
 =?us-ascii?Q?pazR/gb8cPAhWJWDGqup5Sbm+guO1lMegAr955wp+ffQM2ma/G1fsfA+8a5R?=
 =?us-ascii?Q?sNY1KhiRJka89wmXqVwl355BLwpaORDC+PvCQGrnft3ThPVhCNq7f43J3t0W?=
 =?us-ascii?Q?7jFgobhWL9Mz5rcjwaMNvUr7ROxopmLjAEHjoZJLGx8iMIQg6GaYShWEVo9k?=
 =?us-ascii?Q?Kj0UzAd+DcwYSBK2C8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?teHtOIQMTVrkSKfXwxNORWxKOumhdoYN2DWkSkAib3e2LKXJ1GjK0Tp43PWT?=
 =?us-ascii?Q?Y7jlsCh9ArMFOpmg1JTNlzlhfDEc6mbi2KegoJqg73WR5tCCn5faE67Ri6bl?=
 =?us-ascii?Q?iomtQQ5LuzAZA2Askgk9Fe1yVYfBddPSQUVLXDP8x59thTe08ranQqbUVH6D?=
 =?us-ascii?Q?+5QpEAGtTjysRyHAk+MUPdaXmVYj+PvuO+DCmR6FQTFp9SWuPpqHGskLOhU6?=
 =?us-ascii?Q?vcLe43tE/kQfulVqhZAx/VbzBMptChm1fz60CsXRPWnF0LN8ygRzn/Rwid7A?=
 =?us-ascii?Q?fDlzzNClMDzMVhpDHj36XxsE4gzev7jkUQJVdTTKyg2kOV+e1AIgdRH5qLNF?=
 =?us-ascii?Q?T3bP52dB7bAtXN2ZsqfrVvFt3ARzfC5SWKDFx/NWMhzwvREpj3evXV+j5BjI?=
 =?us-ascii?Q?iy6GhFt7CpPqka0FJkb/xEy9vZ3sVDELvBzJ95GKUZq8kmFTRFstKuirFwGc?=
 =?us-ascii?Q?XqmrOGqWJ7tA2Agddil1DcrbRzI0xXEmKpCZ7qE+zCHRHvktDLyMVNIGBV6C?=
 =?us-ascii?Q?73xjLpzq1ztt6cIohQMxKa+7/t70a4O93Gv+MnsHhqLQOHScHMzVfXOoDCTw?=
 =?us-ascii?Q?HNQ+EXuibza9BdXMIvdX8tJJ8a0b3kHDyPCyqKT+i9LIMrbR2LSKznFyE6L4?=
 =?us-ascii?Q?VOGwZP0tIjVW6lvFMg8k0dYylW67qdRaYsE7WjlbtjqH2thkAYWtsSiyj7aw?=
 =?us-ascii?Q?bW2iYCdG2CeyKoyhDK44mjyPFszJ/8ia8MDb1UcDrT07QnpJ0Dh6zP/UCOrp?=
 =?us-ascii?Q?Y18/4HU0JHnabzNgMmahmZXo/ceN6V9mJs+8JujlEw1WtJP8VqTQaqz4nw66?=
 =?us-ascii?Q?WVvn4gp1y+1wVKvS1Jq9rz+LTJ+l5pf32nvoP4IJp28mMvJm00lZQZSNLV+7?=
 =?us-ascii?Q?Vu+EMg8Qyy/I+dB731IP5hmcWfTKdli/hnx43Ln5hu4exKPnY4L2/kzxw+UF?=
 =?us-ascii?Q?rWH6vnSxABPVmkJ82NtCbAPli9tQqUITyqz5cyMgVygsNAYAFWHIFlbyv9ej?=
 =?us-ascii?Q?mhsvlcsbj7Bn0aic82El2D+Zqu0TVjTPc4HVW+L0wE/RQ1y7T1Bq0S8iRS5Q?=
 =?us-ascii?Q?aRkv/AQgf3HrBh8vxdaqVTIMkUZzbzYejND89n9qm4rnWa6FEQ5Ee3TUEsfY?=
 =?us-ascii?Q?26LzZGPAe++S4/52b2eOtVRZZY+2vQzFBZNQQ/bVf7qc7Is3RtwIuZr4iq+G?=
 =?us-ascii?Q?Y+jfvJN6zDUrefT9SgbBQRqsgjUmZUM+KkKsx+YBHGtIYDXmHcVCfbhZU3w+?=
 =?us-ascii?Q?ZYvQ8ictN8mi/GyV2DjXEtlOrxu4pA3Ov7zB1ePu6CDA+2Du53IbkohCoa5A?=
 =?us-ascii?Q?KWw6gwYII+6YJBxpv+StKsOZT9yKhkZqHJDjAapoUeHjKTkPOIWrVyU1aKYW?=
 =?us-ascii?Q?PH6QETJ+4zU1XVix7mDJT6nM3vqnUuMKg/bhysrGFkSOBtKRE0FzWWQRzbXb?=
 =?us-ascii?Q?bqXRfY1H/KfLxgKJTTj4SdZd4X9QMHlfapgrAa/q9ISBBy5LJbo1QMsYhqkM?=
 =?us-ascii?Q?IF7QozonZNsCai3io7Rd908+AizS95TR1wllBDfL1NwTqoXotKORRs5BNEIJ?=
 =?us-ascii?Q?4+cIn/d3r9kdeLOlvA4DQ9u5UtGjtJxqo6KipRULYw973gRS/OlM4sz5wGBd?=
 =?us-ascii?Q?Mu66bAmcb8Z0PAwBPwcy3OMk65kdfHDYjumoe/6A9zj0xJLR9TY0W4/ia5t/?=
 =?us-ascii?Q?wmOjznzeEOmvFH03GHlXfpx+g5lkQkCxfbeaq6plDbB8ZY3mSFvfXjPLAe52?=
 =?us-ascii?Q?6hw0WrtQsg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2afc006-241e-44f1-2338-08de64077eda
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 16:07:29.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2GSRCWkRwAA1vK0UZftvn4CQD7JzmwzfwPAxPTZ2OddV+9wCtSRimtdKKnO9EIlRa86HLu6OHHavpcYRh3aJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

Currently, ops.dequeue() is only invoked when the sched_ext core knows
that a task resides in BPF-managed data structures, which causes it to
miss scheduling property change events. In addition, ops.dequeue()
callbacks are completely skipped when tasks are dispatched to non-local
DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
track task state.

Fix this by guaranteeing that each task entering the BPF scheduler's
custody triggers exactly one ops.dequeue() call when it leaves that
custody, whether the exit is due to a dispatch (regular or via a core
scheduling pick) or to a scheduling property change (e.g.
sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
balancing, etc.).

BPF scheduler custody concept: a task is considered to be in "BPF
scheduler's custody" when it has been queued in user-created DSQs and
the BPF scheduler is responsible for its lifecycle. Custody ends when
the task is dispatched to a terminal DSQ (local DSQ or SCX_DSQ_GLOBAL),
selected by core scheduling, or removed due to a property change.

Tasks directly dispatched to terminal DSQs bypass the BPF scheduler
entirely and are not in its custody. Terminal DSQs include:
 - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
   where tasks go directly to execution.
 - Global DSQ (%SCX_DSQ_GLOBAL): the built-in fallback queue where the
   BPF scheduler is considered "done" with the task.

As a result, ops.dequeue() is not invoked for tasks dispatched to
terminal DSQs, as the BPF scheduler no longer retains custody of them.

To identify dequeues triggered by scheduling property changes, introduce
the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
the dequeue was caused by a scheduling property change.

New ops.dequeue() semantics:
 - ops.dequeue() is invoked exactly once when the task leaves the BPF
   scheduler's custody, in one of the following cases:
   a) regular dispatch: a task dispatched to a user DSQ is moved to a
      terminal DSQ (ops.dequeue() called without any special flags set),
   b) core scheduling dispatch: core-sched picks task before dispatch,
      ops.dequeue() called with %SCX_DEQ_CORE_SCHED_EXEC flag set,
   c) property change: task properties modified before dispatch,
      ops.dequeue() called with %SCX_DEQ_SCHED_CHANGE flag set.

This allows BPF schedulers to:
 - reliably track task ownership and lifecycle,
 - maintain accurate accounting of managed tasks,
 - update internal state when tasks change properties.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         |  74 +++++++
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            | 186 +++++++++++++++++-
 kernel/sched/ext_internal.h                   |   7 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 7 files changed, 269 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a769..1457f2aefa93e 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -252,6 +252,78 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   **Task State Tracking and ops.dequeue() Semantics**
+
+   Once ``ops.select_cpu()`` or ``ops.enqueue()`` is called, the task may
+   enter the "BPF scheduler's custody" depending on where it's dispatched:
+
+   * **Direct dispatch to terminal DSQs** (``SCX_DSQ_LOCAL``,
+     ``SCX_DSQ_LOCAL_ON | cpu``, or ``SCX_DSQ_GLOBAL``): The BPF scheduler
+     is done with the task - it either goes straight to a CPU's local run
+     queue or to the global DSQ as a fallback. The task never enters (or
+     exits) BPF custody, and ``ops.dequeue()`` will not be called.
+
+   * **Dispatch to user-created DSQs** (custom DSQs): the task enters the
+     BPF scheduler's custody. When the task later leaves BPF custody
+     (dispatched to a terminal DSQ, picked by core-sched, or dequeued for
+     sleep/property changes), ``ops.dequeue()`` will be called exactly once.
+
+   * **Queued on BPF side**: The task is in BPF data structures and in BPF
+     custody, ``ops.dequeue()`` will be called when it leaves.
+
+   The key principle: **ops.dequeue() is called when a task leaves the BPF
+   scheduler's custody**.
+
+   This works also with the ``ops.select_cpu()`` direct dispatch
+   optimization: even though it skips ``ops.enqueue()`` invocation, if the
+   task is dispatched to a user-created DSQ, it enters BPF custody and will
+   get ``ops.dequeue()`` when it leaves. If dispatched to a terminal DSQ,
+   the BPF scheduler is done with it immediately. This provides the
+   performance benefit of avoiding the ``ops.enqueue()`` roundtrip while
+   maintaining correct state tracking.
+
+   The dequeue can happen for different reasons, distinguished by flags:
+
+   1. **Regular dispatch workflow**: when the task is dispatched from a
+      user-created DSQ to a terminal DSQ (leaving BPF custody for execution),
+      ``ops.dequeue()`` is triggered without any special flags.
+
+   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled and
+      core scheduling picks a task for execution while it's still in BPF
+      custody, ``ops.dequeue()`` is called with the
+      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
+
+   3. **Scheduling property change**: when a task property changes (via
+      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
+      priority changes, CPU migrations, etc.) while the task is still in
+      BPF custody, ``ops.dequeue()`` is called with the
+      ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
+
+   **Important**: Once a task has left BPF custody (dispatched to a
+   terminal DSQ), property changes will not trigger ``ops.dequeue()``,
+   since the task is no longer being managed by the BPF scheduler.
+
+   **Property Change Notifications for Running Tasks**:
+
+   For tasks that have left BPF custody (running or on terminal DSQs),
+   property changes can be intercepted through the dedicated callbacks:
+
+   * ``ops.set_cpumask()``: Called when a task's CPU affinity changes
+     (e.g., via ``sched_setaffinity()``). This callback is invoked for
+     all tasks regardless of their state or BPF custody.
+
+   * ``ops.set_weight()``: Called when a task's scheduling weight/priority
+     changes (e.g., via ``sched_setscheduler()`` or ``set_user_nice()``).
+     This callback is also invoked for all tasks.
+
+   These callbacks provide complete coverage for property changes,
+   complementing ``ops.dequeue()`` which only applies to tasks in BPF
+   custody.
+
+   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
+   don't need to track these transitions. The sched_ext core will safely
+   handle all dequeue operations regardless.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -319,6 +391,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..8d7c13e75efec 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,6 +84,7 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_OPS_ENQUEUED	= 1 << 1, /* in BPF scheduler's custody */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afe28c04d5aa7..34ba6870d2abf 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -924,6 +924,26 @@ static void touch_core_sched(struct rq *rq, struct task_struct *p)
 #endif
 }
 
+/**
+ * is_terminal_dsq - Check if a DSQ is terminal for ops.dequeue() purposes
+ * @dsq_id: DSQ ID to check
+ *
+ * Returns true if @dsq_id is a terminal DSQ where the BPF scheduler is
+ * considered "done" with the task. Terminal DSQs include:
+ *  - Local DSQs (SCX_DSQ_LOCAL or SCX_DSQ_LOCAL_ON): per-CPU queues where
+ *    tasks go directly to execution
+ *  - Global DSQ (SCX_DSQ_GLOBAL): the built-in fallback queue
+ *
+ * Tasks dispatched to terminal DSQs exit BPF scheduler custody and do not
+ * trigger ops.dequeue() when they are later consumed.
+ */
+static inline bool is_terminal_dsq(u64 dsq_id)
+{
+	return dsq_id == SCX_DSQ_LOCAL ||
+	       (dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON ||
+	       dsq_id == SCX_DSQ_GLOBAL;
+}
+
 /**
  * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
  * @rq: rq to read clock from, must be locked
@@ -1102,6 +1122,18 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
+	/*
+	 * Mark task as in BPF scheduler's custody if being queued to a
+	 * non-builtin (user) DSQ. Builtin DSQs (local, global, bypass) are
+	 * terminal: tasks on them have left BPF custody.
+	 *
+	 * Don't touch the flag if already set (e.g., by
+	 * mark_direct_dispatch() or direct_dispatch()/finish_dispatch()
+	 * for user DSQs).
+	 */
+	if (SCX_HAS_OP(sch, dequeue) && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
+		p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+
 	/*
 	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
 	 * direct dispatch path, but we clear them here because the direct
@@ -1274,6 +1306,24 @@ static void mark_direct_dispatch(struct scx_sched *sch,
 
 	p->scx.ddsp_dsq_id = dsq_id;
 	p->scx.ddsp_enq_flags = enq_flags;
+
+	/*
+	 * Mark the task as entering BPF scheduler's custody if it's being
+	 * dispatched to a non-terminal DSQ (i.e., custom user DSQs). This
+	 * handles the case where ops.select_cpu() directly dispatches - even
+	 * though ops.enqueue() won't be called, the task enters BPF custody
+	 * if dispatched to a user DSQ and should get ops.dequeue() when it
+	 * leaves.
+	 *
+	 * For terminal DSQs (local DSQs and SCX_DSQ_GLOBAL), ensure the flag
+	 * is clear since the BPF scheduler is done with the task.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		if (!is_terminal_dsq(dsq_id))
+			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+		else
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+	}
 }
 
 static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
@@ -1287,6 +1337,41 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 
 	p->scx.ddsp_enq_flags |= enq_flags;
 
+	/*
+	 * The task is about to be dispatched, handle ops.dequeue() based
+	 * on where the task is going.
+	 *
+	 * Key principle: ops.dequeue() is called when a task leaves the
+	 * BPF scheduler's custody. A task is in BPF custody if it's on a
+	 * user-created DSQ or in BPF data structures. Once dispatched to a
+	 * terminal DSQ (local DSQ or SCX_DSQ_GLOBAL), the BPF scheduler is
+	 * done with it.
+	 *
+	 * Direct dispatch to terminal DSQs: task never enters (or exits)
+	 * BPF scheduler's custody. If it was in custody, call ops.dequeue()
+	 * to notify the BPF scheduler. Clear the flag so future property
+	 * changes also won't trigger ops.dequeue().
+	 *
+	 * Direct dispatch to user DSQs: task enters BPF scheduler's custody.
+	 * Mark the task as in BPF custody so that when it's later dispatched
+	 * to a terminal DSQ or dequeued for property changes, ops.dequeue()
+	 * will be called.
+	 *
+	 * This also handles the ops.select_cpu() direct dispatch: the
+	 * shortcut skips ops.enqueue() but the task still enters BPF custody
+	 * if dispatched to a user DSQ, and thus needs ops.dequeue() when it
+	 * leaves.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		if (!is_terminal_dsq(dsq->id)) {
+			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+		} else {
+			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
+	}
+
 	/*
 	 * We are in the enqueue path with @rq locked and pinned, and thus can't
 	 * double lock a remote rq and enqueue to its local DSQ. For
@@ -1523,6 +1608,31 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 	switch (opss & SCX_OPSS_STATE_MASK) {
 	case SCX_OPSS_NONE:
+		/*
+		 * Task is not in BPF data structures (either dispatched to
+		 * a DSQ or running). Only call ops.dequeue() if the task
+		 * is still in BPF scheduler's custody
+		 * (%SCX_TASK_OPS_ENQUEUED is set).
+		 *
+		 * If the task has already been dispatched to a terminal
+		 * DSQ (local DSQ or SCX_DSQ_GLOBAL), it has left the BPF
+		 * scheduler's custody and the flag will be clear, so we
+		 * skip ops.dequeue().
+		 *
+		 * If this is a property change (not sleep/core-sched) and
+		 * the task is still in BPF custody, set the
+		 * %SCX_DEQ_SCHED_CHANGE flag.
+		 */
+		if (SCX_HAS_OP(sch, dequeue) &&
+		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
+			u64 flags = deq_flags;
+
+			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+				flags |= SCX_DEQ_SCHED_CHANGE;
+
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
 		break;
 	case SCX_OPSS_QUEUEING:
 		/*
@@ -1531,9 +1641,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		if (SCX_HAS_OP(sch, dequeue))
-			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
-					 p, deq_flags);
+		/*
+		 * Task is still on the BPF scheduler (not dispatched yet).
+		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
+		 * only for property changes, not for core-sched picks or
+		 * sleep.
+		 *
+		 * Clear the flag after calling ops.dequeue(): the task is
+		 * leaving BPF scheduler's custody.
+		 */
+		if (SCX_HAS_OP(sch, dequeue)) {
+			u64 flags = deq_flags;
+
+			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+				flags |= SCX_DEQ_SCHED_CHANGE;
+
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -1630,6 +1755,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
 {
+	struct scx_sched *sch = scx_root;
 	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
 
 	/* @dsq is locked and @p is on @dst_rq */
@@ -1638,6 +1764,15 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 
+	/*
+	 * Task is moving from a non-local DSQ to a local DSQ. Call
+	 * ops.dequeue() if the task was in BPF custody.
+	 */
+	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
+		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+	}
+
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
 	else
@@ -2107,6 +2242,36 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
 
+	/*
+	 * Handle ops.dequeue() based on destination DSQ.
+	 *
+	 * Dispatch to terminal DSQs (local DSQs and SCX_DSQ_GLOBAL): the BPF
+	 * scheduler is done with the task. Call ops.dequeue() if it was in
+	 * BPF custody, then clear the %SCX_TASK_OPS_ENQUEUED flag.
+	 *
+	 * Dispatch to user DSQs: task is in BPF scheduler's custody.
+	 * Mark it so ops.dequeue() will be called when it leaves.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		if (!is_terminal_dsq(dsq_id)) {
+			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+		} else {
+			/*
+			 * Locking: we're holding the @rq lock (the
+			 * dispatch CPU's rq), but not necessarily
+			 * task_rq(p), since @p may be from a remote CPU.
+			 *
+			 * This is safe because SCX_OPSS_DISPATCHING state
+			 * prevents racing dequeues, any concurrent
+			 * ops_dequeue() will wait for this state to clear.
+			 */
+			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
+
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
+	}
+
 	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, p);
 
 	if (dsq->id == SCX_DSQ_LOCAL)
@@ -2894,6 +3059,14 @@ static void scx_enable_task(struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Clear enqueue/dequeue tracking flags when enabling the task.
+	 * This ensures a clean state when the task enters SCX. Only needed
+	 * if ops.dequeue() is implemented.
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+
 	/*
 	 * Set the weight before calling ops.enable() so that the scheduler
 	 * doesn't see a stale value if they inspect the task struct.
@@ -2925,6 +3098,13 @@ static void scx_disable_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
+
+	/*
+	 * Clear enqueue/dequeue tracking flags when disabling the task.
+	 * Only needed if ops.dequeue() is implemented.
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
 }
 
 static void scx_exit_task(struct task_struct *p)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 386c677e4c9a0..befa9a5d6e53f 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -982,6 +982,13 @@ enum scx_deq_flags {
 	 * it hasn't been dispatched yet. Dequeue from the BPF side.
 	 */
 	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
+
+	/*
+	 * The task is being dequeued due to a property change (e.g.,
+	 * sched_setaffinity(), sched_setscheduler(), set_user_nice(),
+	 * etc.).
+	 */
+	SCX_DEQ_SCHED_CHANGE	= 1LLU << 33,
 };
 
 enum scx_pick_idle_cpu_flags {
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index c2c33df9292c2..dcc945304760f 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -21,6 +21,7 @@
 #define HAVE_SCX_CPU_PREEMPT_UNKNOWN
 #define HAVE_SCX_DEQ_SLEEP
 #define HAVE_SCX_DEQ_CORE_SCHED_EXEC
+#define HAVE_SCX_DEQ_SCHED_CHANGE
 #define HAVE_SCX_DSQ_FLAG_BUILTIN
 #define HAVE_SCX_DSQ_FLAG_LOCAL_ON
 #define HAVE_SCX_DSQ_INVALID
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 2f8002bcc19ad..5da50f9376844 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -127,3 +127,5 @@ const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 const volatile u64 __SCX_ENQ_DSQ_PRIQ __weak;
 #define SCX_ENQ_DSQ_PRIQ __SCX_ENQ_DSQ_PRIQ
 
+const volatile u64 __SCX_DEQ_SCHED_CHANGE __weak;
+#define SCX_DEQ_SCHED_CHANGE __SCX_DEQ_SCHED_CHANGE
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index fedec938584be..fc9a7a4d9dea5 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -46,4 +46,5 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
+	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
 } while (0)
-- 
2.53.0

