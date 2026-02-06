Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6150F3EDAC3
	for <sched-ext@lists.linux.dev>; Fri,  6 Feb 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386327; cv=fail; b=jgPvE4SIcdkjTVargnGxe0Exf0Lb5ieY69BWGEvbaqb+IrJPCqCrRzVAubGCnS2xyqXHyFXr1Vw2obNh+/6rY8JqUipPI2gDExlByB2Dg/YBsxjviTLh7zttZ+Q+qUOTJCNQKI5Q36JGXRq0dFUY7+fy7SjIQR/fzHR5b3OBlW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386327; c=relaxed/simple;
	bh=pfj4941YylW/Tqxc4be0N9lTziywGzVR8/HY7PjHY+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r50x3+Purd9VL6nor7gJtfE2jT5xv7GNx9Ks0Y81BNcJminwvfcBmWh+CCIVcjxLTi5J8Qh4E7atDOVo914PvgV0qy2nCDKsICfHomSVbu6pjSKYeqU9urypnPn83CgmyJGJoDyA8kKZ/iAPfi+Py/WgHQ6uh2pCqMkAM6zhK/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I62wH5SA; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I62wH5SA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+ESRotXSpSaRYIrnPWTt78AX6CrvRYiu8zWYDc3wEoalmvkxMQ3ctuQ9kFE9OYBLqavM+AL6YbTkG8Ug3L79HhXiqmznxk3dTNcENnpZL+okjxu9H8ynONDFpmFg1YPXA5wMl3Vm4lvpyA1X8eJBuJ2JjSbVu/COVNIG32Z3NSl/pcWbv9atoiBRZWq3L8W0FVTItABEZlvZjR0Zgx7Dze6w2VhroXNH5OkqPCFtOP/s+TKFOQ5+a1ZRPudKo6WflroAWSZovgYg8kjpNk/4Jnqqg1TpUhF07GmwRMtgZiDKDTQuzDpppx3Y9gghPONBXKUJiMrTK/Fc9CVtw3Mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrHUi7k/Rhf+zFEQ5eCFJB0b98r3pjpMNnwBY/QkRSQ=;
 b=dETNwCWsW6EwNNiUQqnaGochcyXew7n0YD2AvY2iwcml84Uh3+DqTvpXxA2ff1LCJ6SLC+fu3rH4Q6UhZUjAKSywWLsG+z8w6x30qqHn+MyKR+Hw2gPTbLb104hwXm3M4lXUamXUU45BGxvEwUeH8Ej5giiT025Fbi7JlYWTaSOELtmMKdhvBEx4T3P0M/+8BXdMVOPK+OL8YTT6WRSOiV683d6Z22VX5D9I3icGKoB4QGgxPuImRl1tpaBdGwdb3SyE5eVedfUdAlCteZEUEc9gPSfpNrFxNpkrxvbK/Td796k8piKocSIEtmd8p5yymV1rQj4o8EfWkLusjzmdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrHUi7k/Rhf+zFEQ5eCFJB0b98r3pjpMNnwBY/QkRSQ=;
 b=I62wH5SA3RLOEyCevJFhDdobOmpgwHJ0k9TtUxawY3YNegs6yGeRDo5ZwtVsZQOS+1MZ+1xiJCf68ZPqJxXnuW3TLQVsKXSUh1jdAvtfn4tbkkWM0UKzsMLgXFMlTN0zNhTSA5oC96zcgScpfbB5nxeoqsbc3j8vjsF2+Rwu/lo9itJ5g4xGFDmBWuRalK5BXdkbk2ai8jfO9WDG8lxFmX+BWZchVMk0kAMq1xvRlq4zezCUgRQDtvM4pz3ID1Xx5YOIKurG+t0FRLeXjZENSszaUBzavhST1P1feJGdgtGYEYdmOSGQM+bZuaEXpFd3SqOt3pLVH6RDhaYeSjP2PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 13:58:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 13:58:39 +0000
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
Date: Fri,  6 Feb 2026 14:54:17 +0100
Message-ID: <20260206135742.2339918-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206135742.2339918-1-arighi@nvidia.com>
References: <20260206135742.2339918-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e4b4ef-db50-4a40-963b-08de6587d45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b3HhKSRfw5c1udaLIQo4L2vKMyGSKzYotsVCXfePTAFE8TKVjiPb6S2riHxh?=
 =?us-ascii?Q?B7sPgdP6DxFbzZ4sbcIQvClHbDOosYVDyT2wxZ7m16zstqHKRvnUaspRH3u8?=
 =?us-ascii?Q?9ucMghSZVNSaBJCVMaBz47bHwOFhA6XvDpn+r0arG3gX9RdBwMOlFtCqGG0Q?=
 =?us-ascii?Q?y/Rta1rTUeAO98Eck2PGhmDEubQG6yOc0NxjWm5RVmXx//5j868d0N2+g6IO?=
 =?us-ascii?Q?avpmAiiX/yPUVIxVgWBbAyxAHv6dnu9F0n40dZTv0PA96N2fOcQKpkRxy4xM?=
 =?us-ascii?Q?1pNNRKOAwZkmbs4zON+dFbciRxf0YhSl9/Ugb3Szw4CFicxj9NEpv/MdwKlS?=
 =?us-ascii?Q?6QCtv3KgWPiBGE9JJ60TNDRttb34UmxZFHzxANY2vtqgwy9mz4FvPEX0N5ae?=
 =?us-ascii?Q?S8RSfScB8kVWuiPHfMmLWsv/rdoAnFtTfWi/792bX3vpNyI3wwam3Wxd2ohX?=
 =?us-ascii?Q?WhEcUIMA8HR1HCQm/TmtLWNERsY7mvmLyHbKiiDFFiymTH5OAE32wURW33KG?=
 =?us-ascii?Q?yuWslYqFFyDpk6mgVvjqHkWh3th33Qulvgww8hbHTg1/ZuF1DOCtyW6vREPK?=
 =?us-ascii?Q?YgHoO9C/SrxF5/UcLUS5OiGn7fQEg5ijByC7kGXowpG7wx18+9jE9JXxuQdV?=
 =?us-ascii?Q?rG1XDwGOQXopAtSAE2dwr2foZz97myLEeLZS/JFdkaUVHKIoi8dGTcAGmlzG?=
 =?us-ascii?Q?vi4O1oP5g48Mk0b/Xy09AiBfx7nRMrmOwW+Vb3MfuPAWZ5AjGgHFvhY6k9H7?=
 =?us-ascii?Q?ubl9gfORlb2UpENPKg1GDIii1pwNR5KFQXIji3sGf5Neu0nHlgo5PKJifnyi?=
 =?us-ascii?Q?hab/wgUdypMK8g5CYZtPcUV6LyiIp3jOLFgKr8y23AhheKEHRJ17eqtFiwFw?=
 =?us-ascii?Q?g0iAmBHVVS7E8b4Z0pJHneCKM/MMIizRDbcXz3XV+t4f277ndv5fH9YpHEHe?=
 =?us-ascii?Q?UNjPZEkcdxLjk6/ibi/0SfjYA1ga8Le2hJInLeLgbIAXnceyOMuWdfBb/X7f?=
 =?us-ascii?Q?mBPZ9WRLTbDZjciKD3OjWLbMGCFOTe/cdkIjeUWnePb4F9Oo2Vnqqqof2RG+?=
 =?us-ascii?Q?/qzAolWXAU7v4OlpZQHzXXUWI5RYEYsP8xMD4R/4PGMKciHNMyctLFASlDYg?=
 =?us-ascii?Q?6kM5DQFW63H6BkLCFF1ECEV8YCWXwthtTnHF92s1ojzAxch7+CTEIxzKe+Hy?=
 =?us-ascii?Q?9reem0T8U7ItFF+snmniZAgY3hKLcIN64NOqvy9Ova4uoAAHcJW4+S2dYfu+?=
 =?us-ascii?Q?SiAaLmhzXDEQ4WeK0Rc0zp/XPyXSqyW552FBHsiKS3DLzo5PN8Hue0x4gQ+3?=
 =?us-ascii?Q?BItVu2VyALJgOBH8zE0D5dhWQ0Ogf39zAhqJqcPhzBdOUAxUcXPf4Z21AKUe?=
 =?us-ascii?Q?k76tMW/YF8VmLrTuGNlc5URhFKFgMphxN6LFTH1kPepZejokNxFJHZcrOQ6h?=
 =?us-ascii?Q?Jvq524/g+etQoiKedsEw0p9m9HLJDDkvD04OKhqIHwnXOupVIH+fluLgYyRR?=
 =?us-ascii?Q?hwXCvJucvZ8vzH5X1G9N/Zckl1ogwDnWn+BDWtaXysJ80VjjoN786/vA9gJj?=
 =?us-ascii?Q?6kSZ6JIRibtTT0RhujY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jkwN6EOWm5k1eYUGhjAFNzWfKl+KOpJqw+sUH5s8q9xQRQPa9cmA654yc8Bk?=
 =?us-ascii?Q?6GH48nsQB/UOqQJAZ/7muNlTLpYy1GUnQApLNELzY2VoPb1JBTknBNLf5cGQ?=
 =?us-ascii?Q?hG7myHY1jCFn8t2OhgZBcHH7jYhINbhkK4QwOdcfxKA07warBoR6u5IqH8dD?=
 =?us-ascii?Q?4+SF7GA+yShahz/M6kpUWvBHgTmX672AsO6DLMN/FqY/M3mbV3vawi4icgnQ?=
 =?us-ascii?Q?cGs33vl/2bcWPBzdFLrmJ+haRqOiiuLYuA/NSh2jMVjxW9xNxs+e4uoFvJFm?=
 =?us-ascii?Q?U3bsQW9vO6to2VaiEMk7cv++uvTDFfnbjRbkWUWH4SkW+HVu9Ei3vtfRgsvd?=
 =?us-ascii?Q?/VYtmNJ8EIuM0uCtlTLww1XN+iM1Z/ls7JhLUj9QOz6fMhiCLv7cOdjpRNzG?=
 =?us-ascii?Q?cuJ4n25hXQ6jQV+ige6HRJHbSvJIBXSM/Vg5PsgsDVHfPJvSBRIpBflhZMti?=
 =?us-ascii?Q?Gn+UjPv/4fFvZxr1x5XNO6W3oSXHqOGhZSnFStnSC8FaXnfZPxNcRGYlGUn0?=
 =?us-ascii?Q?1NbEfr93hu0RBCfalBj/52aCvQ/7DYbEsmTJra8uA8UDdO0HIARFkbQnPZW2?=
 =?us-ascii?Q?vFXU+fIhJ67yfGuXBhAlsLhvMZqJJDBt7t4UkjljUDI+ODJDPxrIngUhpc7N?=
 =?us-ascii?Q?fxB8wcD4F7QcA7WchMliFfGP7Zk/11c4LTGuL4X7aK8y7MoCcIVPacnbQBRw?=
 =?us-ascii?Q?fWlQwoWSBrXZEBdWGUoaOHT4xoNREZizGaDCYc3PvR77vsK7WrhqliXnC9Kt?=
 =?us-ascii?Q?ZEGbwhS72FUINtdaLYG0l3b3jVMXuvo6ICTNajrUYJ16w8NuTvJq4f7zfLsb?=
 =?us-ascii?Q?BB9vD92rEv/h9KALIuFTiYJHwsuO2472yhWtHdXM8DX4qW5NEvgdnOQH6Tsg?=
 =?us-ascii?Q?sKy3I8goUjtcNfVVOkN6P+IaunLAOQqqDLyGxb7pKq13z0kAxe2ti/2cqoCj?=
 =?us-ascii?Q?3jzlJGYTXcrhUgVL55wYZuZFh28ZLzy4jnYWo9TkuK3ppZlxdAV4k37iEJ+l?=
 =?us-ascii?Q?vVK/RyU3/sLRU0oRxdmREvpwSVNgwZmBu6udQm2wHjdKoUEtpxGmtADPF+2L?=
 =?us-ascii?Q?sGjlyUhroQM7pxoeEgZc5wX9JRlqvm1kYgZIwedMzteuLsk4N7Kn70YLI5XK?=
 =?us-ascii?Q?BRpaxvyTu04ht6cjKvroY1D5fOQZU6HzGHCheVnlnViaXGEuEmgOaqAi3+Aa?=
 =?us-ascii?Q?vvei6YLDICpmR0ZCheZ3kN9GWChEYb0OVGq0NS9DzEgvS4APgbQp64SXJn79?=
 =?us-ascii?Q?nej0G4Oxk9SMFiun5c4eXurN7mo6prwxAn9XvTU7SkOgtufE0Bs9rd/qNinz?=
 =?us-ascii?Q?RA1JAON+ueUA16ZKm0it7BRE3TAAZt55SdDNYsHi/t4/KNUbrY5XUpI8qdym?=
 =?us-ascii?Q?eI822liiBfK+3Rd41I1ajumYLD4HX2fejkUETGCKszpAHfSGfDKCqT4io/is?=
 =?us-ascii?Q?j29eyRki5kPX3alyoBLjkK5Mwq1j4hxTpzEx/EpfMN18GDy1/M/mbhSMxcb3?=
 =?us-ascii?Q?nL9BJBQoZYnd3NyxwJnkdnX61dLkzHwilEpodXS75aytIO2GryEqeAT2DsDl?=
 =?us-ascii?Q?kvZ3CUn+U5WwOaYZg4WAJOrZt9aSgj2/1MnEHTPhm1RIewUK+JJ5VruhiqiE?=
 =?us-ascii?Q?1MdMWCus6h1j5ScG6RwIS+XFN/ezNNuYorhPmSZdnF22jEBucD2nSouZqvbi?=
 =?us-ascii?Q?eawm+abTyhK3HdUExtSVgGy16GDPAnjCe5xT7vBevTLedcKF7pFCrhhhXlIn?=
 =?us-ascii?Q?XLajnsS/Dw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e4b4ef-db50-4a40-963b-08de6587d45f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:58:39.4154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QASDDoKVgYoA3IzNGEtQyojs6FVCTJ9iKqd2BlIGygIjkZJJ0rWBufJYNIxyJH9mZsw3RKrHHKcf59QwAxma3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

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

BPF scheduler custody concept: a task is considered to be in the BPF
scheduler's custody when the scheduler is responsible for managing its
lifecycle. This includes tasks dispatched to user-created DSQs or stored
in the BPF scheduler's internal data structures. Custody ends when the
task is dispatched to a terminal DSQ (such as the local DSQ or
%SCX_DSQ_GLOBAL), selected by core scheduling, or removed due to a
property change.

Tasks directly dispatched to terminal DSQs bypass the BPF scheduler
entirely and are never in its custody. Terminal DSQs include:
 - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
   where tasks go directly to execution.
 - Global DSQ (%SCX_DSQ_GLOBAL): the built-in fallback queue where the
   BPF scheduler is considered "done" with the task.

As a result, ops.dequeue() is not invoked for tasks directly dispatched
to terminal DSQs.

To identify dequeues triggered by scheduling property changes, introduce
the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
the dequeue was caused by a scheduling property change.

New ops.dequeue() semantics:
 - ops.dequeue() is invoked exactly once when the task leaves the BPF
   scheduler's custody, in one of the following cases:
   a) regular dispatch: a task dispatched to a user DSQ or stored in
      internal BPF data structures is moved to a terminal DSQ
      (ops.dequeue() called without any special flags set),
   b) core scheduling dispatch: core-sched picks task before dispatch
      (ops.dequeue() called with %SCX_DEQ_CORE_SCHED_EXEC flag set),
   c) property change: task properties modified before dispatch,
      (ops.dequeue() called with %SCX_DEQ_SCHED_CHANGE flag set).

This allows BPF schedulers to:
 - reliably track task ownership and lifecycle,
 - maintain accurate accounting of managed tasks,
 - update internal state when tasks change properties.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         |  58 +++++++
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            | 157 ++++++++++++++++--
 kernel/sched/ext_internal.h                   |   7 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 7 files changed, 213 insertions(+), 14 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a769..fe8c59b0c1477 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -252,6 +252,62 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   **Task State Tracking and ops.dequeue() Semantics**
+
+   A task is in the "BPF scheduler's custody" when the BPF scheduler is
+   responsible for managing its lifecycle. That includes tasks dispatched
+   to user-created DSQs or stored in the BPF scheduler's internal data
+   structures. Once ``ops.select_cpu()`` or ``ops.enqueue()`` is called,
+   the task may or may not enter custody depending on what the scheduler
+   does:
+
+   * **Directly dispatched to terminal DSQs** (``SCX_DSQ_LOCAL``,
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
+   * **Queued on BPF side** (e.g., internal queues, no DSQ): The task is in
+     BPF custody. ``ops.dequeue()`` will be called when it leaves (e.g.
+     when ``ops.dispatch()`` moves it to a terminal DSQ, or on property
+     change / sleep).
+
+   **NOTE**: this concept is valid also with the ``ops.select_cpu()``
+   direct dispatch optimization. Even though it skips ``ops.enqueue()``
+   invocation, if the task is dispatched to a user-created DSQ or internal
+   BPF structure, it enters BPF custody and will get ``ops.dequeue()`` when
+   it leaves. If dispatched to a terminal DSQ, the BPF scheduler is done
+   with it immediately. This provides the performance benefit of avoiding
+   the ``ops.enqueue()`` roundtrip while maintaining correct state
+   tracking.
+
+   The dequeue can happen for different reasons, distinguished by flags:
+
+   1. **Regular dispatch**: when a task in BPF custody is dispatched to a
+      terminal DSQ from ``ops.dispatch()`` (leaving BPF custody for
+      execution), ``ops.dequeue()`` is triggered without any special flags.
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
+   **Important**: Once a task has left BPF custody (e.g. after being
+   dispatched to a terminal DSQ), property changes will not trigger
+   ``ops.dequeue()``, since the task is no longer being managed by the BPF
+   scheduler.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -319,6 +375,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..c48f818eee9b8 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,6 +84,7 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_NEED_DEQ	= 1 << 1, /* in BPF custody, needs ops.dequeue() when leaving */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0bb8fa927e9e9..d17fd9141adf4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -925,6 +925,27 @@ static void touch_core_sched(struct rq *rq, struct task_struct *p)
 #endif
 }
 
+/**
+ * is_terminal_dsq - Check if a DSQ is terminal for ops.dequeue() purposes
+ * @dsq_id: DSQ ID to check
+ *
+ * Returns true if @dsq_id is a terminal/builtin DSQ where the BPF
+ * scheduler is considered "done" with the task.
+ *
+ * Builtin DSQs include:
+ *  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
+ *    where tasks go directly to execution,
+ *  - Global DSQ (%SCX_DSQ_GLOBAL): built-in fallback queue,
+ *  - Bypass DSQ: used during bypass mode.
+ *
+ * Tasks dispatched to builtin DSQs exit BPF scheduler custody and do not
+ * trigger ops.dequeue() when they are later consumed.
+ */
+static inline bool is_terminal_dsq(u64 dsq_id)
+{
+	return dsq_id & SCX_DSQ_FLAG_BUILTIN;
+}
+
 /**
  * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
  * @rq: rq to read clock from, must be locked
@@ -1008,7 +1029,8 @@ static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p
 		resched_curr(rq);
 }
 
-static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
+static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
+			     struct scx_dispatch_q *dsq,
 			     struct task_struct *p, u64 enq_flags)
 {
 	bool is_local = dsq->id == SCX_DSQ_LOCAL;
@@ -1103,6 +1125,27 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
+	/*
+	 * Handle ops.dequeue() and custody tracking.
+	 *
+	 * Builtin DSQs (local, global, bypass) are terminal: the BPF
+	 * scheduler is done with the task. If it was in BPF custody, call
+	 * ops.dequeue() and clear the flag.
+	 *
+	 * User DSQs: Task is in BPF scheduler's custody. Set the flag so
+	 * ops.dequeue() will be called when it leaves.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		if (is_terminal_dsq(dsq->id)) {
+			if (p->scx.flags & SCX_TASK_NEED_DEQ)
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue,
+						 rq, p, 0);
+			p->scx.flags &= ~SCX_TASK_NEED_DEQ;
+		} else {
+			p->scx.flags |= SCX_TASK_NEED_DEQ;
+		}
+	}
+
 	/*
 	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
 	 * direct dispatch path, but we clear them here because the direct
@@ -1323,7 +1366,7 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	dispatch_enqueue(sch, dsq, p,
+	dispatch_enqueue(sch, rq, dsq, p,
 			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
@@ -1407,13 +1450,22 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 * dequeue may be waiting. The store_release matches their load_acquire.
 	 */
 	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
+
+	/*
+	 * Task is now in BPF scheduler's custody (queued on BPF internal
+	 * structures). Set %SCX_TASK_NEED_DEQ so ops.dequeue() is called
+	 * when it leaves custody (e.g. dispatched to a terminal DSQ or on
+	 * property change).
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		p->scx.flags |= SCX_TASK_NEED_DEQ;
 	return;
 
 direct:
 	direct_dispatch(sch, p, enq_flags);
 	return;
 local_norefill:
-	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, enq_flags);
 	return;
 local:
 	dsq = &rq->scx.local_dsq;
@@ -1433,7 +1485,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -1511,6 +1563,22 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 		__scx_add_event(sch, SCX_EV_SELECT_CPU_FALLBACK, 1);
 }
 
+/*
+ * Call ops.dequeue() for a task leaving BPF custody. Adds %SCX_DEQ_SCHED_CHANGE
+ * when the dequeue is due to a property change (not sleep or core-sched pick).
+ */
+static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
+			      struct task_struct *p, u64 deq_flags)
+{
+	u64 flags = deq_flags;
+
+	if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+		flags |= SCX_DEQ_SCHED_CHANGE;
+
+	SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
+	p->scx.flags &= ~SCX_TASK_NEED_DEQ;
+}
+
 static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 {
 	struct scx_sched *sch = scx_root;
@@ -1524,6 +1592,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 	switch (opss & SCX_OPSS_STATE_MASK) {
 	case SCX_OPSS_NONE:
+		/*
+		 * Task is not in BPF data structures (either dispatched to
+		 * a DSQ or running). Only call ops.dequeue() if the task
+		 * is still in BPF scheduler's custody (%SCX_TASK_NEED_DEQ
+		 * is set).
+		 *
+		 * If the task has already been dispatched to a terminal
+		 * DSQ (local DSQ or %SCX_DSQ_GLOBAL), it has left the BPF
+		 * scheduler's custody and the flag will be clear, so we
+		 * skip ops.dequeue().
+		 *
+		 * If this is a property change (not sleep/core-sched) and
+		 * the task is still in BPF custody, set the
+		 * %SCX_DEQ_SCHED_CHANGE flag.
+		 */
+		if (SCX_HAS_OP(sch, dequeue) &&
+		    (p->scx.flags & SCX_TASK_NEED_DEQ))
+			call_task_dequeue(sch, rq, p, deq_flags);
 		break;
 	case SCX_OPSS_QUEUEING:
 		/*
@@ -1532,9 +1618,14 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		if (SCX_HAS_OP(sch, dequeue))
-			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
-					 p, deq_flags);
+		/*
+		 * Task is still on the BPF scheduler (not dispatched yet).
+		 * Call ops.dequeue() to notify it is leaving BPF custody.
+		 */
+		if (SCX_HAS_OP(sch, dequeue)) {
+			WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_NEED_DEQ));
+			call_task_dequeue(sch, rq, p, deq_flags);
+		}
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -1631,6 +1722,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
 {
+	struct scx_sched *sch = scx_root;
 	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
 
 	/* @dsq is locked and @p is on @dst_rq */
@@ -1639,6 +1731,15 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 
+	/*
+	 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
+	 * Call ops.dequeue() if the task was in BPF custody.
+	 */
+	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_NEED_DEQ)) {
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
+		p->scx.flags &= ~SCX_TASK_NEED_DEQ;
+	}
+
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
 	else
@@ -1879,7 +1980,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		dispatch_dequeue_locked(p, src_dsq);
 		raw_spin_unlock(&src_dsq->lock);
 
-		dispatch_enqueue(sch, dst_dsq, p, enq_flags);
+		dispatch_enqueue(sch, dst_rq, dst_dsq, p, enq_flags);
 	}
 
 	return dst_rq;
@@ -1969,14 +2070,14 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	 * If dispatching to @rq that @p is already on, no lock dancing needed.
 	 */
 	if (rq == src_rq && rq == dst_rq) {
-		dispatch_enqueue(sch, dst_dsq, p,
+		dispatch_enqueue(sch, rq, dst_dsq, p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
 
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
+		dispatch_enqueue(sch, rq, find_global_dsq(sch, p), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
@@ -2014,9 +2115,21 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		 */
 		if (src_rq == dst_rq) {
 			p->scx.holding_cpu = -1;
-			dispatch_enqueue(sch, &dst_rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					 enq_flags);
 		} else {
+			/*
+			 * Moving to a remote local DSQ. dispatch_enqueue() is
+			 * not used (we go through deactivate/activate), so
+			 * call ops.dequeue() here if the task was in BPF
+			 * custody.
+			 */
+			if (SCX_HAS_OP(sch, dequeue) &&
+			    (p->scx.flags & SCX_TASK_NEED_DEQ)) {
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue,
+						 src_rq, p, 0);
+				p->scx.flags &= ~SCX_TASK_NEED_DEQ;
+			}
 			move_remote_task_to_local_dsq(p, enq_flags,
 						      src_rq, dst_rq);
 			/* task has been moved to dst_rq, which is now locked */
@@ -2113,7 +2226,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 	if (dsq->id == SCX_DSQ_LOCAL)
 		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
 	else
-		dispatch_enqueue(sch, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+		dispatch_enqueue(sch, rq, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
@@ -2414,7 +2527,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * DSQ.
 		 */
 		if (p->scx.slice && !scx_rq_bypassing(rq)) {
-			dispatch_enqueue(sch, &rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p,
 					 SCX_ENQ_HEAD);
 			goto switch_class;
 		}
@@ -2898,6 +3011,14 @@ static void scx_enable_task(struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		WARN_ON_ONCE(p->scx.flags & SCX_TASK_NEED_DEQ);
+
 	/*
 	 * Set the weight before calling ops.enable() so that the scheduler
 	 * doesn't see a stale value if they inspect the task struct.
@@ -2929,6 +3050,14 @@ static void scx_disable_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
+
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		WARN_ON_ONCE(p->scx.flags & SCX_TASK_NEED_DEQ);
 }
 
 static void scx_exit_task(struct task_struct *p)
@@ -3919,7 +4048,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		 * between bypass DSQs.
 		 */
 		dispatch_dequeue_locked(p, donor_dsq);
-		dispatch_enqueue(sch, donee_dsq, p, SCX_ENQ_NESTED);
+		dispatch_enqueue(sch, donee_rq, donee_dsq, p, SCX_ENQ_NESTED);
 
 		/*
 		 * $donee might have been idle and need to be woken up. No need
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

