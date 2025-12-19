Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C42DCC01
	for <sched-ext@lists.linux.dev>; Fri, 19 Dec 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184321; cv=fail; b=os4URJBSqO07TrIbUNDE7uSLwDlDxO0zUf+aLPQPY9m38jK8jzsycDkq/8IHAFEWUUUy1cOWdE8rPILkyRVMqGFBom9/KciGY6fOcY9H74ngVF1a0BSowVtwFsRlYFy8B/Tty+o6xVl253TK/UnlL72VV62XBHcaJYN5Xj/kwDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184321; c=relaxed/simple;
	bh=KuQ3DkkgB/pO2SpnYneZQl8tqyU+MgK9Ax0xhfWnL7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NwDxmVW6ia0O9Mw2O+McTy5ViuyJew8jmtJgfAmq43uNvw2PDdtZFkjiupPMQ8PT1II07YjzmlGFgWBLMuVKnv0eH2jlYOZdaganGehqB7tXMtnnkDizJa5t2T8mbp+9Fw88JmbHKEjM2rz1jBsGF/7YB6diECEAZIwpk2DauPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tQ9ZNU47; arc=fail smtp.client-ip=52.101.52.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tQ9ZNU47"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwDP1m/K4xe1m8I7K3tTQvxJcTCUcSPc7GG+R51khM8AATZnJaM4u2n0PGBbjxKl3U70Fb5Z0IBnbebKkUHkmdrOFrQ/Is9loqIfc4KoGTkYn4fKpQv4nvZthMwEccBi21tSgbE+YJJh3zQqSZmgp0bN7cvPoAHZ+bSnTErubPlFRIinYGbv8jcKWJVCOkMt6RkOf8R3D/HK0nzMVSZBAVrUDT0xm33Lk8NwQPHnYHAn1+wj1iwsGKb8BgKvA+wVCuil0GkWK+x9GfBA0Rq/BtmvqDxKICN+wQya1vgI0tE+t+Gf1/H0hCZa73li76yy6FngRRMOJjWl8ykBNNwyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R39J3E8G13xdu9rM/9EMTSEVzBOlESdXYXdYItfNxjo=;
 b=ggZlVvcn5Qn5pGZKFjaiJExnZZ+WK4eE6PPedoTOvUXIY74d7rTaag8yTJyOZCUEEHrJxcX+xMg/K6ySHbaZ+KnQf612/jeBFtkYwXYXQ9wDIM/pqhTYp77aWSkm4Ce9EvBkjkXtxw1sMcHqDkh59+3m/F6Qveslk1Hl3Q37EcvImFfOGq1pJfsx0cDM16WeP0LUu30uhyTrkohlZBJOBz1xRl/cMVYcDPBB+LQR9sfYNCC5kEouVAPxrGvzm0T56q2Z6L0HCKQD8VuhafOdo+5slGehIeqMI9ZleMBDzlda2kkOIJvnBwSYGviiPKXh8kif/xU63ue0Olkw3k0rTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R39J3E8G13xdu9rM/9EMTSEVzBOlESdXYXdYItfNxjo=;
 b=tQ9ZNU472S6gl7Jq8NUm0R9DCeLy0BWipnngbLrLx9pxMZT5LzQpZpY1BRuu8/zVFYCiYNEUlGbIqqYchC3Pwz220JZ86SKvFOwqLVjXt4ptYp0Zgv1GKoS7b024Pr+1wADyAGQvh9rNBh+B99uljBbt/dHKt1JJUpFa0tS3q05DWglp/aHUK+TY+gZwbL56y1t6/1TULrdiiZBhOnuvpsxDhJVaIaSYho3fvAvZD7oycoOmg0IuqIPe8rI2LgJjsj3Zof+NsuzLjH6gVtYgVls3+kggHc0KaJEZI69Vf97U7afJTYdp6tNhtdVQVqjWfWFfNIzuDxDOYy9vxNZisw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 22:45:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 22:45:16 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Date: Fri, 19 Dec 2025 23:43:14 +0100
Message-ID: <20251219224450.2537941-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219224450.2537941-1-arighi@nvidia.com>
References: <20251219224450.2537941-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bdc393-9047-4580-1a0e-08de3f50475b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pikaRqy7iAWBRgUJECXF3zy0FwWAbwUnd9EO8t1E5Zis/XNzWreqKvffL5gs?=
 =?us-ascii?Q?hWc5m10d+jDxWL13JM4YLbG3aBdA8K44o/5yisKXfOlP+JXjtaBk7R2PASZo?=
 =?us-ascii?Q?3xwHNRrz2I9C0I/eTskKbT4d/drcssYUS3hyn0OzVUOIV2bg9VKuGyYwoHoN?=
 =?us-ascii?Q?KIQJSRG2cnN9pCk4kIW5MGZos3Rr2D/3c+ekFSh4x+r0+LyZycjcXKgE5a5p?=
 =?us-ascii?Q?iSKrAIzlc+Ho97ifKmRiQq1g57lfrU2DtnfueyD2ylsqr+5mTOjjaUptZ0QM?=
 =?us-ascii?Q?fcPv3LgFKdVzhaWqQGB6K1QGRJ/siMuMpVTYXFI+1MplfwAj+cg3e54QNT0S?=
 =?us-ascii?Q?9mvppg6aeYCdSr4z2pTDhdcA1fsBZgjbSftAg3zKYMVaTMVWfKf6yGvdsXVJ?=
 =?us-ascii?Q?1hREpQo0MNuaROC/1u8Ag2ocHXYGwZFgCFG+OlBv4HWpjP93EaUW41Z2hiu6?=
 =?us-ascii?Q?nY1Y1p707itI01sF0gTbZEDFPOTtvcIVDSvz316QHyibgzDLHp4p/McRgILy?=
 =?us-ascii?Q?XhW36QAxZGtG7APypWZFh66zW3ViJ5uJdG4o2ejWl6TqkwZCXu29rHhRSGo/?=
 =?us-ascii?Q?lNWHzfbbJ1QXC0/nw1fUwDwRYsJWS3M6NOMAkvnkadfU6d02y9V3kMiMKjU+?=
 =?us-ascii?Q?XrTDww0L3jAJkB5aZxeJjgrY5HmwPbdx+yJShEC/qkR995b1b/jFpMtL4iF4?=
 =?us-ascii?Q?2gjs1HjtGhtYRAIq37kFh/Iuqxq8VlosrhrppmSxQRIwoBUnjyrBZkwI9HZJ?=
 =?us-ascii?Q?M3OHofb3fpRoBLixkL9IlUHGCNpM0KRKfmoDO+yXaRCCD28+0KBl8pRKHTcV?=
 =?us-ascii?Q?Af/3cZKsUix7mSdYed1T/0eij8aOoykui/Ic+MLE1RM60W9cOojvv7n6r8Ep?=
 =?us-ascii?Q?0b5lxsrfi0VJKy22/5pK0uEWGSKpQy55GRFZUFy14ceLOQLPK+21xHAS6CBE?=
 =?us-ascii?Q?+6ycQgAH5yj1Vs90f3OVAMAQGNZn9RMeCpvEmInQ+gJ0U8X+R0azS7jtmpOT?=
 =?us-ascii?Q?J6FZO8KIYFpfPyPVxDW2ykHlgzJgmU7gr4L39g6lVLZEc8HGMwygo5wMvLFp?=
 =?us-ascii?Q?fTrLuRU24nVqheYWYJQINBW8RCoOJNGIM/fY6g2ECNZxwI2cmC/sWYgdL2ut?=
 =?us-ascii?Q?TXIOC3KMGnsgVhFYjAjjriVjwHN7iNurd3Z+nRs6TeqvGtaPmUkf6fMk0zBS?=
 =?us-ascii?Q?cNZp+mU8ZvSLSVeoeQ9ybXEKuUT6DiNt13UiojNbIONSLV0z8cihlukaFWEb?=
 =?us-ascii?Q?JpODg9haH+xiTEktlDmDPtI7WFwDzclcrGoh3/FUNYrDvpEsfWv2PYZs24G+?=
 =?us-ascii?Q?E+XXeEyyweDXkOY4Y0zqjFP8JXmtRCu2JfUcRveWYcT4wo2ccNhDAPhn9ZhQ?=
 =?us-ascii?Q?c4N7mO5m5r3ANaWcV2pDKf5VtdRDbEiIPJT9apygEeR1Ay8Mn6JFx4iERbD5?=
 =?us-ascii?Q?Ry5aySUsJcWJHJV/9At9AU/bUrqk9CAa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qGQjmPcHI5AJHxdRLkPfQ2FUttFZmLeAgQ8tzeaKrzayhgPHJMOPL7pxBqkd?=
 =?us-ascii?Q?8qKk9O01sShWT+hk21vj0EYvsbJ1O7+FZurCA82pdN6TLwJIt7a46IS6tr6A?=
 =?us-ascii?Q?6zYS/zgYkq6g31RCrClFeE6gKoRv04FuIbZ5q8v67+moj41sueUkfIip8S43?=
 =?us-ascii?Q?CqjU0ZpSmAQ5ZtA8Ha+3hddg1QPy2RNUcEoS1e5F0wk2KSaddU79DtXUHEZq?=
 =?us-ascii?Q?CQd7Sc+BJmeuZuD797+cEEYpMDGa0taNW4/k1l/WuRTDpHKOzX2mNcCHRg7Q?=
 =?us-ascii?Q?3TIRhbUCx+cOgYNM9JuRoCgTCXDUvMIQv5Z+zxTsaJXwqc/rFX8IFKCpBfII?=
 =?us-ascii?Q?ipxy3oykUUAN8QXzhusXNo41gl+y+cfKQC1TAw5OROP2pE+czIJzEpiZBsYG?=
 =?us-ascii?Q?BNwFY0g8EwPPNEv8xw/EOmLjOBaMYfZDr3OcuSvd/2IQ0oNl9XFgBMg0NKUL?=
 =?us-ascii?Q?UIsiDni62LLDPNFdJIFXmhCp9ueiw62dzETJ7DNvnuYVys63tkvUD4qcc02q?=
 =?us-ascii?Q?2QykAcOrFCvLWLjDaSulzsmb/v6rwPA99nGc9Um6DtF20o57HZQy37/KbVIo?=
 =?us-ascii?Q?1N7FvuKkGp3DkEZzT0Snhach7cGGGWzICWFYXGUyldVI5u6ORKla2A6gd7Nd?=
 =?us-ascii?Q?dEhhX8bhdVVm4Ecw+qUB09cwB4WnxLdB4Qu7BeE+4ff8VSBc2JtkHKAp+9Vu?=
 =?us-ascii?Q?zj5Jmo5AWGV5QhYbSM+dQeYzEQl20+VhIKcwjYjVXvFQ5LHvs4sTOGHDIVmR?=
 =?us-ascii?Q?vmfrBuifI8pcRu+hzVOnfH/OgklPYybNf0Ofyi+bXlsZwnwx2rkCsXSE7z5j?=
 =?us-ascii?Q?ASxAEZCq4eE++dZ4VIteftEoJnZfUzMoRV3d/VYWdx2w8V53Z21gyQ6i2uM4?=
 =?us-ascii?Q?4eD80jOjJtiqrEnMKcxqiht8KhulSQyTtqu0Zo6ffT5sbn/xyjegCAeBkQVi?=
 =?us-ascii?Q?cO5oh7wYkkK8sNFGvdWBtddj8KZz9H3lZ6FL+HIO1nZ95rmw5bayC+Yu6xcp?=
 =?us-ascii?Q?eLkfREuHhdFfldpwWPWY6//fYyjiYJfCEFBwZeDC4c+DHIKBzIL/myg+4eaa?=
 =?us-ascii?Q?WQA1HdNh6jF1r5RcgpJxmrvexFMk3iEn9N0w7nkL2UYxXdlIKb6iDDAQbQ3P?=
 =?us-ascii?Q?O+n+TlK/QgH5j7IlF5AVBROZxUGHlW9AWiZ/MLuS+qom7AV1oCFrVi2x3yfu?=
 =?us-ascii?Q?2G1bm3mgIiRvmwFRvlfDczA1uCNgbYq/zCFgJdTW6kdqEMTwl6PhHU/kIvv5?=
 =?us-ascii?Q?SFnWVpJBUmHa2e0fTR9hR9zFJOkeDzRIPr+VxUPl4bpasrKtLGumtDIGhiwq?=
 =?us-ascii?Q?R8tt8B0UZUt+D08NrokYTCCjitduaTq9taxaPLQvbyPfJ1J94F+2ddgCRfBB?=
 =?us-ascii?Q?WkhexZu03ctPvaw1w+nBqmXnmoMqbh+PFbg5pFK/lRHNlAGPYw340CDyIi3w?=
 =?us-ascii?Q?mefvzNRyIb4uaMw9tiu2XnoZzTjtsB2w+S7gFyN0bVv7zMxFTHs5ZM4ySMmr?=
 =?us-ascii?Q?o4nbb/RqMJjFTj9EIjZ4bB2bZl/ybXo62oa9cIsKWnAkhmFTR/zQykpTIseW?=
 =?us-ascii?Q?yTmF6YlaJPbacS0RkFEeqePhuGP//q+sjpBHkhb+yS8Co0a8Sf/hSQhJLTtO?=
 =?us-ascii?Q?hLFV08QDM8LPpLS3pmL+r2uqITeH3R+4LikVTs2vLZlNU86h139VtnWr9T3k?=
 =?us-ascii?Q?HPXWqMq8Or/2t6hScmlrDz78xo1tvK3s+hLRpcWQDgq02Hp+eDul8xgoqNC9?=
 =?us-ascii?Q?FO12UDSH5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bdc393-9047-4580-1a0e-08de3f50475b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 22:45:16.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e470luohh7z9nPwFQJL9ix0p8qVrXH/Q2ym4sICaHKFxHv3N2LLwWVt+eQo8/yn1lvQswrnEsisLGS6OeVvecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421

Properly implement ops.dequeue() to ensure every ops.enqueue() is
balanced by a corresponding ops.dequeue() call, regardless of whether
the task is on a BPF data structure or already dispatched to a DSQ.

A task is considered enqueued when it is owned by the BPF scheduler.
This ownership persists until the task is either dispatched (moved to a
local DSQ for execution) or removed from the BPF scheduler, such as when
it blocks waiting for an event or when its properties (for example, CPU
affinity or priority) are updated.

When the task enters the BPF scheduler ops.enqueue() is invoked, when it
leaves BPF scheduler ownership, ops.dequeue() is invoked.

This allows BPF schedulers to reliably track task ownership and maintain
accurate accounting.

Cc: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst | 22 ++++++++++++++++++++++
 include/linux/sched/ext.h             |  1 +
 kernel/sched/ext.c                    | 27 ++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a769..3ed4be53f97da 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -252,6 +252,26 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   Once ``ops.enqueue()`` is called, the task is considered "enqueued" and
+   is owned by the BPF scheduler. Ownership is retained until the task is
+   either dispatched (moved to a local DSQ for execution) or dequeued
+   (removed from the scheduler due to a blocking event, or to modify a
+   property, like CPU affinity, priority, etc.). When the task leaves the
+   BPF scheduler ``ops.dequeue()`` is invoked.
+
+   **Important**: ``ops.dequeue()`` is called for *any* enqueued task,
+   regardless of whether the task is still on a BPF data structure, or it
+   is already dispatched to a DSQ (global, local, or user DSQ)
+
+   This guarantees that every ``ops.enqueue()`` will eventually be followed
+   by a ``ops.dequeue()``. This makes it reliable for BPF schedulers to
+   track task ownership and maintain accurate accounting, such as per-DSQ
+   queued runtime sums.
+
+   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
+   don't need to track these transitions. The sched_ext core will safely
+   handle all dequeue operations regardless.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -319,6 +339,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..334c3692a9c62 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,6 +84,7 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_OPS_ENQUEUED	= 1 << 1, /* ops.enqueue() was called */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94164f2dec6dc..985d75d374385 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1390,6 +1390,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
 	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
 
+	/* Mark that ops.enqueue() is being called for this task */
+	p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+
 	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
@@ -1522,6 +1525,21 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 	switch (opss & SCX_OPSS_STATE_MASK) {
 	case SCX_OPSS_NONE:
+		/*
+		 * Task is not currently being enqueued or queued on the BPF
+		 * scheduler. Check if ops.enqueue() was called for this task.
+		 */
+		if ((p->scx.flags & SCX_TASK_OPS_ENQUEUED) &&
+		    SCX_HAS_OP(sch, dequeue)) {
+			/*
+			 * ops.enqueue() was called and the task was dispatched.
+			 * Call ops.dequeue() to notify the BPF scheduler that
+			 * the task is leaving.
+			 */
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
+					 p, deq_flags);
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
 		break;
 	case SCX_OPSS_QUEUEING:
 		/*
@@ -1530,9 +1548,16 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		if (SCX_HAS_OP(sch, dequeue))
+		/*
+		 * Task is owned by the BPF scheduler. Call ops.dequeue()
+		 * to notify the BPF scheduler that the task is being
+		 * removed.
+		 */
+		if (SCX_HAS_OP(sch, dequeue)) {
 			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
 					 p, deq_flags);
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
-- 
2.52.0

