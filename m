Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32E47DD50
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089623; cv=fail; b=OKIAMWZ+IpGx2hSAVULrX8s26r7pd7MU0Ht+io/p511hK8MXRtVdCGj5PPFVKGyYycdn+a0lrf+KrLGGm+S4gzeoPbEp7VoQZBGhaHJAX2Re3PcUgHwkbTiUMDsSbEVSMNLxtj4rdSvYWGDwuOQHXVbX6sz0Fg+luCFT3UEiPaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089623; c=relaxed/simple;
	bh=Dw9RBvPEGa1SKC4tCOAy23XkGRsuQFxxUNhzT+pDZkE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FV4ILn9GRYO7vD+hzmy5YjdzBZjPGUZDwi6Hg50pKM1+KfJ4ZG45tBxalnqKPcXNDI/wuEq+74UbVvKknNZcjtRPJ5RsSf5caBy4iq5F4l4VxJcG7Xt5/BHpYmol3Q11Sfd6QwCjzNsmSEZr0bu/SucuVoKaA6t91kh/qSJ/YWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eZlQEgS3; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eZlQEgS3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hepusvy4OZuBRKu2sA2DddbWXMawhxAjmC3niz7mJigEPf/Rq1sDfirxiyx4kvwBq+Qa0H9VmG8t3xHG5kk4QQDrHHQrQiDLvODoKF0WTfIB3nzQQOj2+MNx8Fuk6H/f7DIOzeCneT4WGQ4AezjhNhTGs18ZdhybAhLz1Vr7q33MNe2sA//q0m89a4n/fYPQRyFLBFkC0PqPOrH0BZyoD032V8bz51ghxGADH1baEgPkOXEyEwpH4vapG8aE0xvOuJwm06J2gSvrNTEB7Uwzkf1R/Q/XARo6VIpiswnjpFdzx/TLX+STUiJxNvoqdXZXASk7UJo0UDsNse9Eb4jV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X+voupwWfyqNHcYMfCLg8fKof/f/hgTZsUify4DUls=;
 b=tbQYjwwx1hSN8a/bWdcdtxy/lTcqiFqFZXNLc8aLczVO1IcwiAz4d50CcpZ8VkvOWJCRMamvfPwRHxvIUoMWMwiDTgOe+xbsF9LxNGNEHTfv/D61t6nsvtHteSvPdcnqPEgWeu0W6QhywoY+dtsnB+vcbPKiBJn260I7uw4YJ16hw2InP2DEyLWawVGIKT18RC8lPcDwwc+YsuhuJhzCIyqO9C3nDlSfpSAzYJoXLpH7HT751Fnd/kOOPKitLIUUpdgPCMcslog2yruVF/MzIOAR3tjVxUOHYxwCOUa0fMhEBC0LGiiDX3FAqYiS9lr+/7EaZ+B53Swr5aKFEKDdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X+voupwWfyqNHcYMfCLg8fKof/f/hgTZsUify4DUls=;
 b=eZlQEgS3fRX7aiI7Fn/g1j/w+GVP2DY29FJqS7jmSrgJr+L4lopOgoWZKSkBPaFvJF4KRAACeDs1TxR11lkgcBKVErLyMZOIR2ofrzhtNFiv7vTNd9LN732yx9TrrD1CPqk8S3q4IDmU9hHs67ZEBXpP9DZs1YvW9dTAaMSrX7xjhz+ykI7K2OwCFF9M+tYtD+9We1+bZ4eZ4vS5ZEpdAKrRBk1r6mb8D11W2TdgDN4nda1bqETbHT/VKmJPJ/DjWTnP1LCha1bhoy56cG6gILMnZyqjBk4w8QvyrazS0XZSZTFHW6Hu5WGkPGih6ax3zunIguzTqbMqwBQelJ8yEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 17:46:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:46:49 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH sched_ext/for-7.2 0/10] sched: Make proxy execution compatible with sched_ext
Date: Wed,  6 May 2026 19:45:40 +0200
Message-ID: <20260506174639.535232-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E9F.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::451) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 718ee7a4-b76a-4740-b44e-08deab97731f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	D0vVQsuT4kCyWrxd5YgTI4v7sy2JMQPx/ZtxoEu8zIoFBeqyfA2ZFP6wG3nrkhz7F64EtUAipCVzxnZdtp1HLxfl9+e3IQhtlmf7FO8W34QW2psdy/yjQSpBhDSUqqLo9x8L7zhSW5YLmwF6ycLNm6RiUj1nVglFAKUlcwq6YSxs24DUgQNSXdK0q4ZrAxbeggUZk0/YeukH/0m0sOod28IA8dN2mmHhNMABKjm2jpnRQONjsAHlErFfqbOC4p9RJOMbm6moNOdzirU+R1V4VQXFYf7Cvk2kDBP5wAGF+poE2qYeHFSXnpaTxc3mJ6bCtZdbkE55pPH2qdB3TXTE8pLdPXrbhjkeY6rp6E/Pm0F5jvztdqfH55gpFpQ36tJ6y3Ycer6XRuegeUihOowZkrbaPfLkwnFjNx7EG/5d2xtxsA7QFMc2yaasds65twBDREX4QUzlvRqZ/HoEQkYLZngYeMzLgh8bziUDylt6vfcQFanX2nnzqSvbLdg1WKLkN2WJnymMbZ9K+otLxjkGytcQ4gEvVtxeq6boDRwkJfSQSFtBmGOv42tb6sFZoXzgpIXOx40KeY/fF8AdX9uNKO+Jm24D8Fpr8HAjNzJveUwEx4sa/oDe4MfIU7BDnUYbc3rqrYpxdyzQ9QE8GYJjv/eSJdNIHt9iCkH3/ErTeNkDO39V/mG3XhSDKSp0dLN9eoHbb7iyAGiwf0dtkxpDEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sTgdAWkEc/ewfSkL8Qh6+mJ3UQW2G/P8C1DTw+qA4bwxqicCnN0f9pAuR/Va?=
 =?us-ascii?Q?hpyja4bb+65Qq2A6kY1Ntfg97cj19QrNTxW3syW3u7a/l+I7ur0SdOa07REk?=
 =?us-ascii?Q?mf4sAyIDHPu3rGWYLuqkt+OlSmhyrkj7sm7kpVfWZtb9mjqeejY4dQcywPsM?=
 =?us-ascii?Q?qseYliAPH2j8Hf85D4mtZp0ZJSt8mCT0Lqams5TBvrdwDR0ItF91BDBveY2+?=
 =?us-ascii?Q?4Bp3rhi0jTgWX+lUzqMR3wqoYBGUf8SudqLk1BPNfYHmFMzjPXAdAdjH5XGW?=
 =?us-ascii?Q?3rc4Xhk6KZkKMZuzef8DC/6q8PrkhzneA4p6mxRawOhLHcb7nFBdFKEg54dM?=
 =?us-ascii?Q?MKX5aUuPq28Bmi8NITe0YawIh5pbr/gQL1LPE1ON++qDN7ZGgEAi06jJMsR8?=
 =?us-ascii?Q?DPFXYf0ohbC1ZTOAOk/qWZ05nTTi8AOOSArUNn1t5OoyMVgfX5FdvD0xVWkJ?=
 =?us-ascii?Q?1pYh/MntxwcLRimqcw43RY6yF/Q4GNjClsYV8QD9bKgT3NabVbotJBeM0LPz?=
 =?us-ascii?Q?cT8f4G5gip6Eb6iAFqVInMIc8DkUUKXK0xqETpYAzxcj0oTY5uKJ12NfjHGy?=
 =?us-ascii?Q?4DQ6V2WZPax+RmaE6rpSjfyQ6cwYTSygf4dFvH/dYSskAT5o5va2m2kDNDHK?=
 =?us-ascii?Q?EyEOlwFxIxNkTfWdeEdeMozaQ0kgNtdc++pbUKLVQ/b9mtz013fpGnEGmeeR?=
 =?us-ascii?Q?9xJuV+G6FQ4/kaEzfftnsFs/rxjfb+azhzrA0CqSdv9ML5XdW8jK3xJCQRel?=
 =?us-ascii?Q?qNaMAJg+kRtrhnxm6YxF3T1TwdULDDnb1LCldXmRP34itZ+Nmxjc2xHJS2R/?=
 =?us-ascii?Q?SE8YziFArDUoaSFWz2cb65UOhMAyT6Xln7H/LeJp5ddqsTMLkR11Itr5ioUF?=
 =?us-ascii?Q?cjukDtv/Gn2Yn1uzMbIFoPZLqmBu8k9p9HNXAd1LyVpyZC4PQcSnLqvLNXAM?=
 =?us-ascii?Q?xwZ3HVfbIiQ7bDDqrqtOHqDMe+W4+OFUDZKuW1gFiv/nfd62Pl/oGmw35zr2?=
 =?us-ascii?Q?ZvClH50NnTTfWebEc7OF8D+ou+ZX2HNii//QDqj/60Tf0+zZe22boWv0v6C4?=
 =?us-ascii?Q?weXNrlN60ir6U4LRXcxlwZ4xAkQSFN5d4BeZhnWHrVNJDokIN8C/Nvolo51I?=
 =?us-ascii?Q?1KRLsTII568ethgUV/TnZAlnL3PGLf7D7y0McXGk8QUbiQPeCly2/BjR2rXP?=
 =?us-ascii?Q?z6HV54W+MypIAkOWF7weCFYUuYRyuOwtMkKvQzdWEcG6DBJDngK4l1+BXtjA?=
 =?us-ascii?Q?j6k5tzMTPJmoXbEg2QO+lZptShTK8e9ygrvr5Wjteadg3ZIDkxrdY6ufDbzB?=
 =?us-ascii?Q?k9ZFW2MyMNE9VVJmkW3ywRrhq+U+UMNBpdFhuBRIHcpKib6rAMsfOljz+rM1?=
 =?us-ascii?Q?vd/XCiBg0F7Jer/zorFGkIsySITbBGYBNl+E5EbOv/2wzfXWE8QodsilhvpE?=
 =?us-ascii?Q?w56rG3n3oYTRB2iTptUDrx4xpZQf+giedWiXV0kacvCY1mpVT6PUpX2kkDJk?=
 =?us-ascii?Q?M52IHMc1ChtKORBgk+6Pi1Zb/uFWp71D1ZtO/sN0F/zK8P6f3yUggGHWjEK3?=
 =?us-ascii?Q?6N64Um7j37XD0w+2cL6UTkv55R3ObChX6m2SYWB41Gbxhe3wSNbMUiG/5afe?=
 =?us-ascii?Q?QXWNJte/EGonwB74Tc6JtJz6Gf+AT8wNEmdoq6d/CuzRHxqGacpxY18ZmuZU?=
 =?us-ascii?Q?bj1hYcHetY4I9Dz3+osCqBwJVCpnOrNwt8GEOpI/eBwsYFuw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718ee7a4-b76a-4740-b44e-08deab97731f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:46:49.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7LEYfBNDhLniRmLqRGvncwHRV6ef9Fr7EwgjaNjWygL2vFRZQtp7icTqEGZvhTmYIVcekFmPVc3o+NMKJeABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467

This series enables using proxy execution with sched_ext and is based on early
work by John Stultz [1].

Background
==========

Proxy execution (proxy-exec) lets a waiting task ("donor") donate its execution
context to a mutex owner, so the owner can run while the donor stays eligible on
the runqueue.

Currently, proxy execution and sched_ext are mutually exclusive at build time:
we can't enable CONFIG_SCHED_PROXY_EXEC=y and CONFIG_SCHED_CLASS_EXT=y in the
same kernel.

This restriction can be problematic for Linux distributions and for anyone who
wants to ship one kernel and choose features at runtime.

Why they are mutually exclusive?
================================

sched_ext schedulers drive dispatch through their own interfaces. A proxy-exec
handoff can run a task that the BPF scheduler never dispatched through that
path. sched_ext callbacks then observe a "current" task that does not match what
the BPF side considers running, so kfuncs and helper state can see an
inconsistent view of the executing task.

sched_ext also tracks runnable work through Dispatch Queues (DSQs) and BPF
chosen dispatch rules, while the core scheduler still maintains classic per-CPU
runqueues and pick paths. A proxy handoff can therefore switch the CPU to a task
that the BPF scheduler never inserted or ordered through its DSQ interface.

DSQ state, vtime, and "who is running" bookkeeping inside the BPF program can
then disagree with what the core actually executes, so helpers and kfuncs that
assume their dispatched task is current may observe stale or inconsistent state.

Default behaviour when sched_ext is in use
==========================================

The series relaxes the Kconfig coupling, but keeps proxy-exec context donation
off by default whenever a sched_ext scheduler is loaded: mutex-blocked
tasks are forced to block instead of staying as donors, and the pick path skips
proxy selection; leftover handoff state is cleared so mutex retry paths do not
trip blocked_on consistency checks.

Users who accept the semantic mismatch for their BPF scheduler can opt in at
boot:

 sched_proxy_exec_scx=0|1   (default 0)

Setting 1 allows donor->owner context switches under sched_ext as well.

This enables Linux distributions to set CONFIG_SCHED_PROXY_EXEC and
CONFIG_SCHED_CLASS_EXT together and ship kernels capable of supporting both
features.

Then users can decide, via sched_proxy_exec and sched_proxy_exec_scx, whether to
enable proxy-exec alongside sched_ext, use sched_ext without proxy-exec, or
disable proxy-exec entirely.

References
==========

[1] https://lore.kernel.org/all/20251206001451.1418225-1-jstultz@google.com

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-proxy-exec

Andrea Righi (8):
      sched/core: Skip migration disabled tasks in proxy execution
      sched/core: Skip put_prev_task/set_next_task re-entry for sched_ext donors
      sched_ext: Fix TOCTOU race in consume_remote_task()
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Save/restore kf_tasks[] when task ops nest
      sched_ext: Skip ops.runnable() when nested in SCX_CALL_OP_TASK
      sched/core: Disable proxy-exec context switch under sched_ext by default
      sched: Allow enabling proxy exec with sched_ext

John Stultz (2):
      sched/ext: Split curr|donor references properly
      sched/ext: Avoid migrating blocked tasks with proxy execution

 Documentation/admin-guide/kernel-parameters.txt |   6 ++
 include/linux/sched/ext.h                       |   9 ++
 init/Kconfig                                    |   2 -
 kernel/sched/core.c                             |  78 ++++++++++++--
 kernel/sched/ext.c                              | 138 ++++++++++++++++++------
 5 files changed, 193 insertions(+), 40 deletions(-)
