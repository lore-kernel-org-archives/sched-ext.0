Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31DF2EA169
	for <sched-ext@lists.linux.dev>; Wed, 18 Feb 2026 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403867; cv=fail; b=WCEFls2F9ZTiGBrHzKShqwTlJ8eGRrvHgWmIUDvXJjf7g6sZuTQVvYI1bDnIrhep2hCJyaP2eBNrSTgWiV1m7lJfZ1nV0LnL51WU8lnb4ORU2RMbkarLeoLizu9VrLaNpnIRXoX5aiOLoBy22jbX56daN9kZsfFKTWnaNaglNrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403867; c=relaxed/simple;
	bh=B79w4r9KJ0td9d3GYm1b2X7rN16PwBInr04TOILDrIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJeSrn/8IKenLrut4quDFks5+XW7vGeDYj1VdLdLTcUy1nzMJrZX7T+sd89rOpPhsyxk81QM6uYUAZAlS6I5hAsHkvuVRbKQFYTP9vNip95438Mb0Bb56pLDIoP/9JIg3NuR4PlEeoHI7WNK9odXeUqKfEU/xxY1GBcb/rahUuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TYbgZs5S; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TYbgZs5S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywsdb7PnstnaYiXOPRoctO93tAvRPmQc3kXPszl2ktr1rCeFT3Gwvsn+QFGn6LRXUz4oZwbwndddx3Z8wbpD9fDM1Q9TQwGiUCChINO8th7usvDHF9hBQ8hpmSKCTBjML7jMJ2hLEY8P6KEH4KR4U7/Xta+8lCFUAQ0NA5w0jXeiFC1JlNF/lPwO61BP/JZxKAn9/y0jv1RvhZZcQLy7+hIT3DXAXkpuL2LrRzV2LEtCYfJM/+RnUDxX0Szkq4jnNsi8A+pRUEwfkGi1orqyeodG672mLe9q5NefDAeKC+khLjEJchtgrPSCwqiEwOCbcG51PMdaJT217iLI9+wSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RFrKf2lhohHHNQo+OKSJqGnp/68eOOn+K4uGW7A/6c=;
 b=YrGCjuLmIRvWGdFxRfyH7YcDuEvZ23CQfNMaOMknyqP+Qm3tQ8gB8AvBguAtBc26p4Y/p833NYH9vigPV3PSzPPiBS4jh/nmRwltd34rCe6HajZ1kNDvf/ohlAb1KuTDfFvp6LhjA/EhgZRTe3o2HYJjR9zbncv4rDetHYCppOmom+jNzVztzrCAMh2Dj0zR5DgJYUPkALSzZYzLs+YwThywMnKVh6zh/efmZX+6DiZbUM7CW4ihoK78OCmI2FeFS42+tEzu69lfIePQLjIyXBzhSvznPP3jWgpQw6EVWlw01QDWstG5y2rHFTDQHVWRWZ3GHVCo0gdUvWBxxIwGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RFrKf2lhohHHNQo+OKSJqGnp/68eOOn+K4uGW7A/6c=;
 b=TYbgZs5SJb4II0J/W0uEoTmYce4My3aCE3dVGUHvvUM0tc7Re4PJNdARA7IAU6BP8mNKeLe55LXN1gKRmb56qy+ISHr7u9mfkVlnxE5WuExwhEeZSGNPSLDEyerNbTB5v3OsFjOyT09uFTcJLALDKaPAm8B0mFoo+pIqqqVj5xaS2XfCqdwmjb+nNer95oCd/UwOestMxP9w7mfT4TG4UNZIYuTMlM74hoc52+Uic6US+lr1nhkYWZRD5AMF6JAZuRgFRKAGz8n5ZKj3pwSXFQQaTMD+JxGgMRpggI3JRmrSyaTJcf/7c2X5bcWkf6gurarHHy+gdOceiqi2v6VJpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 08:37:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 08:37:38 +0000
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
Subject: [PATCH 3/4] sched_ext: Fix ops.dequeue() semantics
Date: Wed, 18 Feb 2026 09:32:17 +0100
Message-ID: <20260218083703.22785-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218083703.22785-1-arighi@nvidia.com>
References: <20260218083703.22785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8e88f5-4db1-4e1d-423d-08de6ec8f8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?knTbFMvSDx42V7ULi7Fkit5L1IAI0bHFafs+sLm34xmkXOn2wS1TRxQL+DJQ?=
 =?us-ascii?Q?KqZKWKyRKnU+BZP23ih9ML4m62I9iKmPiCjqR7qSbGh2N5Zb6aTU6gtYmOsZ?=
 =?us-ascii?Q?H4S5yj84404WBrTA19MK1nSVx60zjDZWUaGYmTjp5zSe0QgaUnTFnDXZos6Y?=
 =?us-ascii?Q?pN1jiaYY+WDH3vax8zLCggRRu6lMNVWgF7COEvXsm3jp9cpj86/E5l440XZs?=
 =?us-ascii?Q?uI2dwhUVK9o4A+vxe0hkrv9R7FiyV8sRZ8H6Q9A0G1EFTAkh3zUdrKX6qqMR?=
 =?us-ascii?Q?zwAMVcNGY9GMYj7k/RST12hpk+HdkFn9fChDtI20PXJXCf7OrxAcbGfo7JUG?=
 =?us-ascii?Q?keH3VkLJzEhDF/6PCH2kCGnCwO7g1+CpgV3retJTbL5hIQCgiLLvwH/EEyYB?=
 =?us-ascii?Q?SZuXi/pXSY6dSedDpWFI+jZQy22CjuIonF2SuivQ0z7SivHvSyXHgRUEKHuP?=
 =?us-ascii?Q?H2901mL3x9eK2qid4Kw047vF3Zq+h6WzhZoBtU4ZjCxVXK8fX+0HmItG8gv9?=
 =?us-ascii?Q?PR1BwbVU32rg9W3GQiRDdX/PJ/cwAiFuZqGMKPIsjOXmvU501MhMfsF9KPad?=
 =?us-ascii?Q?mza2pV9ncHYyRrZVKZSUTflmdQSHZbRXlmMt+WTWIPbSuKAkN5Kc880UOcdS?=
 =?us-ascii?Q?r1A3p8eESv/IMvQ/uDLjPJhy0PldV/hBYYzsD/UFPNlg7UZiytJKFoDRjzm0?=
 =?us-ascii?Q?m4yG7NUwP6UZSSaPDWyOjg+rm6O5SDmc0jdksS6O9kYgsEfoQiFEtFmet8tx?=
 =?us-ascii?Q?xolSJpxY7mZ39w6GeRjMo/gb980xBvo3hYRAKa5CMsmz/L65zJkKEGWNi0kI?=
 =?us-ascii?Q?omeaVyzSap8in+P2nfmfXoXZneoQVJ8F9ZpXPk+caNwJz0Ix1WYF8HtMprYQ?=
 =?us-ascii?Q?Z0pm7GS/jFELDEMDoMfvXcjtEKzJ31aWbGhgxA+j4u4PHiAvc/OZJGjAJy5y?=
 =?us-ascii?Q?VMjr+zqYdsE+M0cMI/Ocljdgi2h9A6G0t8OK//6Ydgz4sHQsZmAUufh+OhTT?=
 =?us-ascii?Q?sp7fiR1Rz6XiW+qYL9rPdZKQaPslXOPs6q7d80VRqfaEGdK3aOLjkoSeh2Re?=
 =?us-ascii?Q?vbUG3N/kHqTGmpUcuGTeDdDu2ul5AkJkXvAutyBVeBfBCCuI/oqPJGdiN0O1?=
 =?us-ascii?Q?GT/OH2Km16lmylVKAqJNeciOPxHY2PPoQHcBej6Q0BVTy8TbGmHHW9aDtoVy?=
 =?us-ascii?Q?xEqdnkepLBLRdgLC5YEJe+DFoDKhudYPOEDtu5HhLX1nmTzYCOfmvLEUyqAm?=
 =?us-ascii?Q?/nR7Dzs28adZlY6cUYu6defr2YlV1bkdNvhRoV17eR6YGzmwEP1aXwWKGAsJ?=
 =?us-ascii?Q?7AD5DzTM9Fx3LrvULeCdBCx29GtIfOrcF6QPjUTBrjOXjhQyGF1WQAMZgNnT?=
 =?us-ascii?Q?/eZCD5Ad0nGPv/bJirOUMGVKfSqcbZ3VJFrwUabPnlaMq554YuuMakT4CBq/?=
 =?us-ascii?Q?C/ga4fdui+pDKhCv3xfrqnCb/BiVY0M1x8TrIjfR5tfQg/LuAIiT/bOazcWl?=
 =?us-ascii?Q?90CiEii6swUY1/GWQel5REFb6RGaBgN6Yz4YjykX0MfTU/jxgkXA46PuhLgA?=
 =?us-ascii?Q?Qr2zDvEsmmh0F3fv6e8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ICx6DvPalAozGqzEypY3v6cOdnlZsyF+P8MwePdwyyl8KXIolStU87R7gFYS?=
 =?us-ascii?Q?Z89p8/ZBs3nSNZh5U2Li65GRQR1fTh65qLnETNRWreTgsWblPZXfcfoW7pko?=
 =?us-ascii?Q?Y2XxBR37v1hp9JzsMmasLnOVAXnNwPsIucxiaIt+Yqo/eBsWEGsu8FX54qJd?=
 =?us-ascii?Q?1hKOugHufr5BdkuKAGzvwOb9TYUpQPgzC83eRzDe8MwdlpFFqcQx20zUXA2w?=
 =?us-ascii?Q?qe6gup+D6H8JvNHnu7GcUsg0Q8009UvrG8WaGFCG1Wiw9y9zYESRWVu1x7eB?=
 =?us-ascii?Q?siaOZLpcQ1lA9G4ZxB05c/eXvRq6hkCMOoVwtzB4NiviRqOLH9fMQUT3FsOz?=
 =?us-ascii?Q?S//K8gRTZNgYS1p8R0A3r4I6+RXsUMyLBXlSz0hNKIChzOqtSo7NL3SwG6br?=
 =?us-ascii?Q?qjqO9uHCgWVbxv1l7YnkA/hnmwGBGizNM7dna/wZDzTjIItwZo7a4wNaGu77?=
 =?us-ascii?Q?wQKMYawSGCBMpMEGODjMdjueoFFc+Al7mwMPrj8x/773onMvGryiWxstH1rB?=
 =?us-ascii?Q?Z++1SDXDzhgOqcAqN+fZUI/+YLb6eT/lL/fgjXvZdFq9tdgTUgMRPUU3ujT1?=
 =?us-ascii?Q?TTBN9f3XNv5bKu3cZXP3OlyLLnY9F3fT6rcgj9iFLn8bBMPJxcMazc6CJjf6?=
 =?us-ascii?Q?iKrliADEl4Bzi3x5tCTJO+ZZrUohHKpsQHMjXGOXIyGXsCpItlSHVOA7ShNF?=
 =?us-ascii?Q?+CMHkeAlssPS8BeB9sN61HQX2ksszoCM/+BBDnn7LRdKTG15FYznOswKglsc?=
 =?us-ascii?Q?xlX1qqALv/a3pyJ3/DD7tGdnbhhH0wDsfrmpLHihYDfVcosF5KKSVr0OGq9X?=
 =?us-ascii?Q?voAQEqpA+GYESeRTvtll9pBwkdFrDW/eXBR0RXMYCv4Vcr6szKZ/Gz2Paa7R?=
 =?us-ascii?Q?M4RjfknK3/AtG3oGc+8aZ8Z7JN7sAKT82Moc13EMuhfLuUuIVR/FCMwp05CR?=
 =?us-ascii?Q?r61mycs1wqsGGjeE1iUTV1p2k7T+hx+P8QNOowAPsSNOUvQTZfjf05Q5uFpN?=
 =?us-ascii?Q?xFONr56tclu/uxR8XfzCidUsVzf3YFLuBDeWENX8yRm5lRWZgotNVWtgE/Nw?=
 =?us-ascii?Q?8gAjUUs+7be9wYtOkx/9ndfYstHyk+zXHO5kSxgK/OTE1vNupkJXbWVPcBAv?=
 =?us-ascii?Q?DL6JxexVIabmr9ONJVcsPxYIgcdPO5ONtCOjlDRHLQrVOZTysazKKzlLAM12?=
 =?us-ascii?Q?9jyTQONS4ZXFWTbbZkwgiZoKA5shnBhLtLVZlj61IRPeXRPlQ4C5MuUV93Is?=
 =?us-ascii?Q?z0KzwI8AqUcrPpI8fw5Al89U2Fy4MbjyRnQgxbknIfDDMprvO3B+SBKLQyW3?=
 =?us-ascii?Q?i6lyVo5u6cjJqXOr8zMVxkPH072Vg5eVpG2yLXPfVS8zOWAgSoV5Tlb5DDgC?=
 =?us-ascii?Q?HEERxEW7A8FUZVe+8GW7VEj2ziF+o/ogml4QvtK8ltkfJnIYQwM7GAGZEL9J?=
 =?us-ascii?Q?y9Qjkj/Qxvzp6GXy5F7dkWbhcwc+968TDgZ1mLI0TBk+mkRZ75h0Xk0gwWB5?=
 =?us-ascii?Q?8gGHRo6MsPdlm020uz4JdySgB4nY7tSDrot1GLd30WYKTAOZ8WipE1JtH09y?=
 =?us-ascii?Q?cofCfP47j+g/rqBm0EkB6rSEvA/GcHHp2t2DofIdKdKAzX7/v+50ZaNX7qXk?=
 =?us-ascii?Q?sIkvK+oPI54XSULaKi5vxWlcM1kFmOPq4nJVP8IgRh+hnJUZhN06DBKEC52B?=
 =?us-ascii?Q?/5eAo8p7okkgLUnr/S/WJHpjBXoEeehmYp7wURAwEPbwj9w8918ZNY/x9/16?=
 =?us-ascii?Q?NaaM9SOvBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8e88f5-4db1-4e1d-423d-08de6ec8f8f6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:37:38.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV/djmZftOTWyEbF+fE5uDGZO4foDl50tTdPIzTO/4KirflqMwq3u4EQQoHNnti/jYFcgSJEN6gfcjIskcP3Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510

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
in the BPF scheduler's internal data structures from ops.enqueue().
Custody ends when the task is dispatched to a terminal DSQ (such as the
local DSQ or %SCX_DSQ_GLOBAL), selected by core scheduling, or removed
due to a property change.

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
 Documentation/scheduler/sched-ext.rst         |  78 ++++++++++-
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            | 126 ++++++++++++++++--
 kernel/sched/ext_internal.h                   |   7 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 7 files changed, 200 insertions(+), 16 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 9e2882d937b43..7cb77fd2e4d7d 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -228,16 +228,23 @@ The following briefly shows how a waking task is scheduled and executed.
    scheduler can wake up any cpu using the ``scx_bpf_kick_cpu()`` helper,
    using ``ops.select_cpu()`` judiciously can be simpler and more efficient.
 
-   A task can be immediately inserted into a DSQ from ``ops.select_cpu()``
-   by calling ``scx_bpf_dsq_insert()``. If the task is inserted into
-   ``SCX_DSQ_LOCAL`` from ``ops.select_cpu()``, it will be inserted into the
-   local DSQ of whichever CPU is returned from ``ops.select_cpu()``.
-   Additionally, inserting directly from ``ops.select_cpu()`` will cause the
-   ``ops.enqueue()`` callback to be skipped.
-
    Note that the scheduler core will ignore an invalid CPU selection, for
    example, if it's outside the allowed cpumask of the task.
 
+   A task can be immediately inserted into a DSQ from ``ops.select_cpu()``
+   by calling ``scx_bpf_dsq_insert()`` or ``scx_bpf_dsq_insert_vtime()``.
+
+   If the task is inserted into ``SCX_DSQ_LOCAL`` from
+   ``ops.select_cpu()``, it will be added to the local DSQ of whichever CPU
+   is returned from ``ops.select_cpu()``. Additionally, inserting directly
+   from ``ops.select_cpu()`` will cause the ``ops.enqueue()`` callback to
+   be skipped.
+
+   Any other attempt to store a task in BPF-internal data structures from
+   ``ops.select_cpu()`` does not prevent ``ops.enqueue()`` from being
+   invoked. This is discouraged, as it can introduce racy behavior or
+   inconsistent state.
+
 2. Once the target CPU is selected, ``ops.enqueue()`` is invoked (unless the
    task was inserted directly from ``ops.select_cpu()``). ``ops.enqueue()``
    can make one of the following decisions:
@@ -251,6 +258,61 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   **Task State Tracking and ops.dequeue() Semantics**
+
+   A task is in the "BPF scheduler's custody" when the BPF scheduler is
+   responsible for managing its lifecycle. A task enters custody when it is
+   dispatched to a user DSQ or stored in the BPF scheduler's internal data
+   structures. Custody is entered only from ``ops.enqueue()`` for those
+   operations. The only exception is dispatching to a user DSQ from
+   ``ops.select_cpu()``: although the task is not yet technically in BPF
+   scheduler custody at that point, the dispatch has the same semantic
+   effect as dispatching from ``ops.enqueue()`` for custody-related
+   purposes.
+
+   Once ``ops.enqueue()`` is called, the task may or may not enter custody
+   depending on what the scheduler does:
+
+   * **Directly dispatched to terminal DSQs** (``SCX_DSQ_LOCAL``,
+     ``SCX_DSQ_LOCAL_ON | cpu``, or ``SCX_DSQ_GLOBAL``): the BPF scheduler
+     is done with the task - it either goes straight to a CPU's local run
+     queue or to the global DSQ as a fallback. The task never enters (or
+     exits) BPF custody, and ``ops.dequeue()`` will not be called.
+
+   * **Dispatch to user-created DSQs** (custom DSQs): the task enters the
+     BPF scheduler's custody. When the task later leaves BPF custody
+     (dispatched to a terminal DSQ, picked by core-sched, or dequeued for
+     sleep/property changes), ``ops.dequeue()`` will be called exactly
+     once.
+
+   * **Stored in BPF data structures** (e.g., internal BPF queues): the
+     task is in BPF custody. ``ops.dequeue()`` will be called when it
+     leaves (e.g., when ``ops.dispatch()`` moves it to a terminal DSQ, or
+     on property change / sleep).
+
+   When a task leaves BPF scheduler custody, ``ops.dequeue()`` is invoked.
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
+   **Important**: Once a task has left BPF custody (e.g., after being
+   dispatched to a terminal DSQ), property changes will not trigger
+   ``ops.dequeue()``, since the task is no longer managed by the BPF
+   scheduler.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -318,6 +380,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..4601e5ecb43c0 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,6 +84,7 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_IN_CUSTODY	= 1 << 1, /* in custody, needs ops.dequeue() when leaving */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9820026b74557..e9666d5f6832d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -925,6 +925,22 @@ static void touch_core_sched(struct rq *rq, struct task_struct *p)
 #endif
 }
 
+/**
+ * Returns true if @dsq is a terminal DSQ, where the BPF scheduler is
+ * considered "done" with the task, false otherwise.
+ */
+static inline bool is_terminal_dsq(struct scx_dispatch_q *dsq)
+{
+	switch (dsq->id) {
+	case SCX_DSQ_LOCAL:
+	case SCX_DSQ_GLOBAL:
+	case SCX_DSQ_BYPASS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
  * @rq: rq to read clock from, must be locked
@@ -986,12 +1002,45 @@ static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
+/*
+ * Return true if @p is moving due to an internal SCX migration, false
+ * otherwise.
+ */
+static inline bool task_scx_migrating(struct task_struct *p)
+{
+	/*
+	 * We only need to check sticky_cpu: it is set to the destination
+	 * CPU in move_remote_task_to_local_dsq() before deactivate_task()
+	 * and cleared when the task is enqueued on the destination, so it
+	 * is only non-negative during an internal SCX migration.
+	 */
+	return p->scx.sticky_cpu >= 0;
+}
+
+/*
+ * Call ops.dequeue() if the task is in BPF custody and not migrating.
+ * Clears %SCX_TASK_IN_CUSTODY when the callback is invoked.
+ */
+static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
+			      struct task_struct *p, u64 deq_flags)
+{
+	if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) || task_scx_migrating(p))
+		return;
+
+	if (SCX_HAS_OP(sch, dequeue))
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, deq_flags);
+
+	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+}
+
 static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p,
 			       u64 enq_flags)
 {
 	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
 	bool preempt = false;
 
+	call_task_dequeue(scx_root, rq, p, 0);
+
 	/*
 	 * If @rq is in balance, the CPU is already vacant and looking for the
 	 * next task to run. No need to preempt or trigger resched after moving
@@ -1115,17 +1164,34 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
 	p->scx.ddsp_enq_flags = 0;
 
+	/*
+	 * Update custody and call ops.dequeue() before clearing ops_state:
+	 * once ops_state is cleared, waiters in ops_dequeue() can proceed
+	 * and dequeue_task_scx() will RMW p->scx.flags. If we clear
+	 * ops_state first, both sides would modify p->scx.flags
+	 * concurrently in a non-atomic way.
+	 */
+	if (is_local) {
+		local_dsq_post_enq(dsq, p, enq_flags);
+	} else {
+		/*
+		 * Task on global/bypass DSQ: leave custody, task on
+		 * non-terminal DSQ: enter custody.
+		 */
+		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS)
+			call_task_dequeue(sch, rq, p, 0);
+		else
+			p->scx.flags |= SCX_TASK_IN_CUSTODY;
+
+		raw_spin_unlock(&dsq->lock);
+	}
+
 	/*
 	 * We're transitioning out of QUEUEING or DISPATCHING. store_release to
 	 * match waiters' load_acquire.
 	 */
 	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
 		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
-
-	if (is_local)
-		local_dsq_post_enq(dsq, p, enq_flags);
-	else
-		raw_spin_unlock(&dsq->lock);
 }
 
 static void task_unlink_from_dsq(struct task_struct *p,
@@ -1405,6 +1471,12 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
+	/*
+	 * Task is now in BPF scheduler's custody. Set %SCX_TASK_IN_CUSTODY
+	 * so ops.dequeue() is called when it leaves custody.
+	 */
+	p->scx.flags |= SCX_TASK_IN_CUSTODY;
+
 	/*
 	 * If not directly dispatched, QUEUEING isn't clear yet and dispatch or
 	 * dequeue may be waiting. The store_release matches their load_acquire.
@@ -1522,6 +1594,14 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 {
 	struct scx_sched *sch = scx_root;
 	unsigned long opss;
+	u64 op_deq_flags = deq_flags;
+
+	/*
+	 * Set %SCX_DEQ_SCHED_CHANGE when the dequeue is due to a property
+	 * change (not sleep or core-sched pick).
+	 */
+	if (!(op_deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+		op_deq_flags |= SCX_DEQ_SCHED_CHANGE;
 
 	/* dequeue is always temporary, don't reset runnable_at */
 	clr_task_runnable(p, false);
@@ -1539,10 +1619,8 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		if (SCX_HAS_OP(sch, dequeue))
-			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
-					 p, deq_flags);
-
+		/* A queued task must always be in BPF scheduler's custody */
+		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
 			break;
@@ -1565,6 +1643,22 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		BUG_ON(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
 		break;
 	}
+
+	/*
+	 * Call ops.dequeue() if the task is still in BPF custody.
+	 *
+	 * The code that clears ops_state to %SCX_OPSS_NONE does not always
+	 * clear %SCX_TASK_IN_CUSTODY: in dispatch_to_local_dsq(), when
+	 * we're moving a task that was in %SCX_OPSS_DISPATCHING to a
+	 * remote CPU's local DSQ, we only set ops_state to %SCX_OPSS_NONE
+	 * so that a concurrent dequeue can proceed, but we clear
+	 * %SCX_TASK_IN_CUSTODY only when we later enqueue or move the
+	 * task. So we can see NONE + IN_CUSTODY here and we must handle
+	 * it. Similarly, after waiting on %SCX_OPSS_DISPATCHING we see
+	 * NONE but the task may still have %SCX_TASK_IN_CUSTODY set until
+	 * it is enqueued on the destination.
+	 */
+	call_task_dequeue(sch, rq, p, op_deq_flags);
 }
 
 static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
@@ -2935,6 +3029,13 @@ static void scx_enable_task(struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
+
 	/*
 	 * Set the weight before calling ops.enable() so that the scheduler
 	 * doesn't see a stale value if they inspect the task struct.
@@ -2966,6 +3067,13 @@ static void scx_disable_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
+
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
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

