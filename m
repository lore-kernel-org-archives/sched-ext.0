Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691833;
	b=wDDa0rNVB23L3fnsRxuRDmnDGS7G/JbN+vBDuFNjbpP31MWL9jNrGQNUPuDYySHptmFz
	 4lHtt/j+NpuRZiwTXOq66qd1l4e1oFF0rLymQV3Ad9y2eYdX1f3Z00udNXxBlfOhiTHFb
	 SKwQpXkG8xnTN+otrR3lZMjDnXYhYQ+HPIkwsdrMErGAnNZQyV9LozWNipzeNAoqYYvhg
	 zqiNCOv0kM0p+wVD8s95xDgavu9oEFvqpfsGOM83QFpkt4aCck7CiDsc58khoQQpnJun9
	 zd8935k1cS23GE+HrEAFkt+b5PShwUEsQnoqPgJrBoVe2GummsAes85HzEcQX4YmE8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691833;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mM2GItN4O+dIaEix231adsY8uYcs6P49Q3S0Sb2aNUs=;
	b=dQ3DdNSGGrIbyJgRrxGeYlZXbg7Mtx606oHfnDf2Y893PUahLRzeRJnWBvZr6sYESmtl
	 MgqiRhdWXNtVgcuRYN7VrFO1OJrOYLKrpHyjf7R4ZC0n3t+dPq9yGqNd6mDv0IN8tYqfM
	 uM8gOYfk2pqn3o2WaPHln+/DsQTT4/f8hSUN3ZTOwQ9ASvpGYHQVnjPlvZofbnrllGXZ+
	 iHAHHE2tYBxaKXoFEztpMPnTg/32ZGARy/ZVcKMovEGQZ1zoN8PFaY8hjmKpCmJ0xfx+Y
	 MMxXJL1Pzkw6vHG3eVj2d3WBH6fxcTBOT6RF+CVncqJiXvb4f9lngpj0opNt73cHa/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZqQI6Als;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.9
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50037606A33C
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 11:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50037606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZqQI6Als
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veaKq1j37OufF+S3yTgD+tFCXLrcGyaBWgqoyCLLkGAMjGp9ytiX5uHxNFveuOPaSyCZWIe3V1LVjh0yyz5q75vZw8am+y4XZO9vsztw7PGvJ6p42us9xkQ9nfXmCVRYBbHamnrCm4FLWkOB00xh00t3GH1EU7fMSPubXpxwmsfQE65IM6moTFs3ckFBamAalKtiCXH2udRLlRwi/8YaLiUefT/c4dwboPdTzH2ddXq1oB6IWE8Qo7arAI/pqExcs8YCBIUm59wuwKmtxDzFblicTSpkMSVttK8oMlRf0CQreBdhk7w7N9GClC6UvnOkqVM1RwCpk6gXvEHAtETqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM2GItN4O+dIaEix231adsY8uYcs6P49Q3S0Sb2aNUs=;
 b=mGT9xPOniiUNb6KN1Z76gkh7XNKbSGmvVAQODBrK/uJfF6EUWgvCLZFX/wdYI/wuUGduQ5DvpknRupMlENVcJu8tJ6gLDakcl7ax6FiZFfhX1gCks/WUgG1GAW/reDe1nnlQartodwE4QUnz7Mb2mc3Q8wKCVl/80l1wWABvofaKQK9aUGNBxZy4/sZROAUa1eewCQ04wX3DpAG5GRgt8UlvLnobCRdEFoj9agzM59HflGaNiYEas6LUN2CTqp09TGtUbAa15CR8hRygWG+JKYwD9NQmNaFFooOW7rcLxHxfQdemIxDKBQ+OhKfDoMq0FEmXBFNBxCepYiEFR9J5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM2GItN4O+dIaEix231adsY8uYcs6P49Q3S0Sb2aNUs=;
 b=ZqQI6AlsRqe/4wGXoVcl3xturldRdN7J18lm3+t8PdfuewLeGd68Vxi3SRzBIeFGbKV97f8oB2tfQz3smxUXYMsdhrGkrFQ83579nUdfV6fL4aLW9tnZjDbvM9kAa/Tr+wjNZ2hGdisNe+EmaGOVoBuHD9oCbqXht49HNCTPq0ilsYDj/izBTiyXYg5hJwUTPBolVKFlz0nayTpg79AYQxE66klFixmKthZaGprU8lFPqQ4T+5QKUbMYXK3qf13mfrIZAQq++9mGXxYr1XqlFQ2NAzTQNNs2aq5k7mHgWdIJg/tEoiEK92s27h7f5rKKm+Oz2Y02ajM3ClnCTccZWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 11:17:06 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 11:17:06 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Tao Cui <cuitao@kylinos.cn>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sched: Let switching_to() decide whether to keep a retained proxy donor
Date: Thu, 26 Nov 2026 12:13:57 +0100
Message-ID: <20261126111649.208476-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126111649.208476-1-arighi@nvidia.com>
References: <20261126111649.208476-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:130::28) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ff293f-70f5-49f5-22a3-08df4baecdb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|5023799004|261022105027099003|11063799006|261026140227099003|56012099006|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zMIAwLXAH6b3O/EzDZ8jqGnN+lYgG4e+OeArsEnezdVHLja0FvY1oBmA5vaVfHh7RPPQ+2M0wbIOViGrW8qVavLyxwxoCHeKgk2Jw+nJ6J9MAiKgQQaDstgxSlD6+e1CF35eEU3r1wonQENwFvd/Y9VZvqYY1AIltVHgmeQJXkAF7zfiTgC5UUU18btFy1MHT3bDbVm16dbJwY2b0p/E4d6NnbS7ybnYvvPkhn1xZWTD1SVxf5rYMThmiVHs613bYSGZBytoARyJUBtzsV9ZGPw/2OfW8pfXwMnLYMh0pn2W3wowXdBxiqvmdTcEGIKB87Akh+ISmfqdDSIPvCU3O2kQBhT1Rc6YHrU68AEWmNiajSUv4OodbNSZNmNBH9fpBfV/pUpMg5YNhLaDIjzP4VG1ZX15F0Tf/o98hhwAjz/W1HVtDHozYyoZwxouXTqv+0Fq80QV1n31XIMAW/G2vrpquDUBlSPvmtKOQswe67Bx/1QE5tY6pS3W9ynothwxb1ZoI/BQUJElU3biOtUSwI2crZe2BL/2lNsn4S6hgGiDZDNIHY6L+qZpz+X3H6RWEDKPFreNveU0BnxPNCK8zRPvH0++pTECdm7Y+j8OBBdfv1QZfzlPJIAd2QMLhQansUJZ/EJGihPAewqAMPXf/PU8lcViuykxGER636LvBwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(5023799004)(261022105027099003)(11063799006)(261026140227099003)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cf56bZKWrp8eJOt73g8Xv3537gAJTHmSHEHG8ftHefHvhdYZituQSmDYl85Z?=
 =?us-ascii?Q?w7225Ux7qHTAu+I9BkSOqdHoN/j0VfbyTfxV3G64zsvlNz4PRzY539I1ncGn?=
 =?us-ascii?Q?77KYJqSOBOoyx/P+KWnIlowtdr91FTlOgt5VsXR+LcKKtjVQ9NtZD7BHs44c?=
 =?us-ascii?Q?kslkGcVIACr+SPS0RPMCsRJiHA7Bpy9u//KOTeCAmyuaFJ0ddxDkmBtUzt1H?=
 =?us-ascii?Q?MYzCPa5qWwKeco8GpVV/PCgoG3Elj05lUa96AMW9BytyF97gXXPXUrng6Zuq?=
 =?us-ascii?Q?N64CSWQ/u3H7fMjtff3QZa2y/nNunaOfkHiOBk2TtYDDXBmOjKVU/f6ctJGw?=
 =?us-ascii?Q?HGM10q3H2QunezRIbJFFNWW3wCeGeb3Ac2iNIAT00rGmzqmRRNRo6Gz0Hokv?=
 =?us-ascii?Q?COEu7ofZ+AMwqbXgz5kgXbAhUwz+oWpueZG2zsum5stRb6logMeMvX6LNVDW?=
 =?us-ascii?Q?SKg7/1G1WV9c1QVefihbqDDe50Zf+jHBpGnaB4euSyr9KMhXhkxcEqafyoYK?=
 =?us-ascii?Q?KbUbFWWMcLMVsoOpTxn2HJA0MB3ZK9GGysWEAMkZhR+nHWjVCgASeyKzu9Fp?=
 =?us-ascii?Q?if/vOjMtYlgE76kVX8N7OejMyQQvzYxR9jKVjb0eoPXBxL3CLiOfDmMPjKN0?=
 =?us-ascii?Q?c65W5BFh3zZ5RCsO5vEXdMGVg6jpgmQbFgOFIfxXRr82YC+t/8d/YIsG52iT?=
 =?us-ascii?Q?kY9UV1XBz7/JynjbNChV5cY0dHeG2vm6t38GjnydzWGBOoKpz5K2BrqAr1IC?=
 =?us-ascii?Q?IB0z1nQbO9d6CqKnlplUIxjZ03JE9af/6bcIY+iGbzvlVeU0GEL2Pd9IrsD0?=
 =?us-ascii?Q?lzTc3PGnqQWUinchzpFDyxB/L4U5xFxqKq8q8q0aCS9hao7YHYv27V69vIKC?=
 =?us-ascii?Q?frRWGygMq8pktC+818IJyo11sGKXh6nRzbvOghd9vlmAcF92aNPjlOyk+E32?=
 =?us-ascii?Q?/IKtIKnv87N9HV920TscRwPjl8D3b4/ekGwJ2U9okl8VgSeG04HTuTLn5Oxq?=
 =?us-ascii?Q?Xds0QLyl+1dRoqL/LkkcYkAFdszyr+4ZB/O82Klck+hmv4P4lyNO74tmhyVr?=
 =?us-ascii?Q?loXeF+g4oaQ3ogdDFAmp2pj2ekkkD+DD8dlATsQ4y7AYLBAENV3oejBMYxv3?=
 =?us-ascii?Q?OaQWthGWRAU1IR+tOPlSPlnmVo0YICfG4RKx2NO7oY2yIDDx+XcBZTOPnZTy?=
 =?us-ascii?Q?UGWIRocCA3AcJPFHO0UkMD5bjhS3hjkQFGlHiRakD8aw6nTqFaXICeMJZ9yU?=
 =?us-ascii?Q?iwTxYjA6epeHPMRrwtYJ3IH3zgjLw72vGZsXQIyW+EoxGgw0EFXghOEY+jrB?=
 =?us-ascii?Q?7C/PdhimY618+EmmCjGOifrywJInVnMEVGYhM8fWGCGQy6YM6LRLBVPnaK1+?=
 =?us-ascii?Q?vCoQpe2vK7jmmT+4c5Ag0kE80GbwLwu5zkraLj+HiHtTtJwTY30bEOGIK9dx?=
 =?us-ascii?Q?SD62TvSC4h93GXa4EkRJwEoJ9jCoX37bzgD1EPc9cyBn0YocwhnZUBjtXJNw?=
 =?us-ascii?Q?dc8NF2pmiRo+ZHBKTEEkE3jzDI1cQ5hHIcjVbue4Ae3rxlMmbLy7/gTyViwV?=
 =?us-ascii?Q?I9gDZrzh6an/rGTVlpxfaDVy+FEL5EbXGmUWZfEo0FPttLh2gAKZgKLVeT40?=
 =?us-ascii?Q?byRs8s2etcC2OGzSauwmH33q0vpCLQS5mFV8ihi0NBhuETRbo8iEsnvyMW1Z?=
 =?us-ascii?Q?PPsVk39Ery9yUZXmMptsoNf265WzdUdGlmWq8x6sPKGU9cyR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ff293f-70f5-49f5-22a3-08df4baecdb8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 11:17:05.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6uMrErHlywFPLWuKJ5yrn2tujlnucghBpI+8ryflgGqiJdJXxr7no5F00AENAx5cVdPjcRUGPZ+W1zigZnc3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

Proxy execution retains mutex-blocked donors on the runqueue. A BPF
scheduler with SCX_OPS_ENQ_BLOCKED admits donors that block while it
owns them, but sched_ext is not currently designed to pass it donors
retained elsewhere, regardless of SCX_OPS_ENQ_BLOCKED. To enforce this,
explicit hooks in __sched_setscheduler() and in the root enable path
block a retained donor before sched_change_begin() records its queued
state.

These hooks don't cover every way into sched_ext. For example,
rt_mutex_setprio() has no such hook: an EXT task that is PI-boosted into
RT/DL and blocks on a second mutex while boosted is retained by RT/DL
and handed back to sched_ext as a queued blocked donor on deboost. The
__sched_setscheduler() hook also only triggers when the requested policy
is SCHED_EXT. When the BPF scheduler takes over all tasks (no
SCX_OPS_SWITCH_PARTIAL), switching an RT/DL task to SCHED_NORMAL, e.g.,
via sched_setscheduler(2) or sysrq-n, also moves it into EXT without
blocking the donor. In both cases, a BPF scheduler without
SCX_OPS_ENQ_BLOCKED receives a queued blocked donor it never admitted:
the donor is enqueued without SCX_ENQ_BLOCKED and, once picked, proxy
execution runs the mutex owner on its behalf, even though the BPF
scheduler opted out of it.

Rather than adding more hooks, let the incoming class decide: make
switching_to() return whether the class accepts a retained proxy donor.
When it doesn't, sched_change_end() blocks the task instead of
enqueueing it; sched_change_begin() already dequeued the task from its
old class, so finish the block without dequeueing it again: hand the
donor role back to rq->curr if needed, account the sleep and clear
p->on_rq. The callers hold p->pi_lock, so the task cannot be woken and
migrated underneath.

On the sched_ext side, switching_to_scx() refuses retained donors unless
the BPF scheduler admits them, which covers every class transition into
sched_ext, so the explicit hooks can go. The root enable path also drops
DEQUEUE_NOCLOCK, since the hook was the one updating the rq clock.

A BPF scheduler with SCX_OPS_ENQ_BLOCKED now inherits retained donors on
class entry instead of having them blocked. A queued donor is passed to
ops.enqueue() with SCX_ENQ_BLOCKED as soon as the scheduler isn't
bypassing. The current donor, like any running task entering sched_ext,
keeps running without going through ops.enqueue(), and gets
SCX_ENQ_BLOCKED the next time it does.

Update the enq_blocked selftest, which checked the donor state after
root enable, accordingly.

Fixes: be8be8acb268 ("sched_ext: Block proxy donors before taking control")
Reported-by: Tao Cui <cuitao@kylinos.cn>
Closes: https://lore.kernel.org/r/20261112144935.583937-3-cui.tao@linux.dev
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c                           | 90 +++++++++++++++++--
 kernel/sched/ext/ext.c                        | 34 +++----
 kernel/sched/ext/ext.h                        |  2 -
 kernel/sched/idle.c                           |  2 +-
 kernel/sched/sched.h                          |  9 +-
 kernel/sched/stop_task.c                      |  2 +-
 kernel/sched/syscalls.c                       |  2 -
 .../testing/selftests/sched_ext/enq_blocked.c |  7 +-
 8 files changed, 111 insertions(+), 37 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2f46922982f32..1b4ec78738861 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2252,15 +2252,19 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_task(rq, p, flags);
 }
 
+static inline bool task_state_contributes_to_load(unsigned long task_state)
+{
+	return (task_state & TASK_UNINTERRUPTIBLE) &&
+	       !(task_state & TASK_NOLOAD) &&
+	       !(task_state & TASK_FROZEN);
+}
+
 static bool dequeue_block_task(struct rq *rq, struct task_struct *p,
 			       unsigned long task_state)
 {
 	int flags = DEQUEUE_NOCLOCK;
 
-	p->sched_contributes_to_load =
-		(task_state & TASK_UNINTERRUPTIBLE) &&
-		!(task_state & TASK_NOLOAD) &&
-		!(task_state & TASK_FROZEN);
+	p->sched_contributes_to_load = task_state_contributes_to_load(task_state);
 
 	if (unlikely(is_special_task_state(task_state)))
 		flags |= DEQUEUE_SPECIAL;
@@ -3772,6 +3776,17 @@ void update_rq_avg_idle(struct rq *rq)
 	rq->idle_stamp = 0;
 }
 
+/*
+ * Make the execution context the donor again once the old donor has been put
+ * and rq->curr has been set as the next task.
+ */
+static inline void proxy_set_curr_donor(struct rq *rq)
+{
+	rq->next_class = rq->curr->sched_class;
+	rq_set_donor(rq, rq->curr);
+	resched_curr(rq);
+}
+
 #ifdef CONFIG_SCHED_PROXY_EXEC
 static void zap_balance_callbacks(struct rq *rq);
 
@@ -3780,10 +3795,8 @@ static inline void proxy_reset_donor(struct rq *rq)
 	WARN_ON_ONCE(rq->donor == rq->curr);
 
 	put_prev_set_next_task(rq, rq->donor, rq->curr);
-	rq->next_class = rq->curr->sched_class;
-	rq_set_donor(rq, rq->curr);
+	proxy_set_curr_donor(rq);
 	zap_balance_callbacks(rq);
-	resched_curr(rq);
 }
 
 /*
@@ -11200,6 +11213,58 @@ struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int
 	return ctx;
 }
 
+/*
+ * Block a mutex-blocked task retained on the rq for proxy execution, because
+ * the class it is switching to does not accept blocked tasks.
+ *
+ * sched_change_begin() already dequeued @p from its old class and put it if
+ * it was the donor, so finish the job a sleeping dequeue would have done
+ * without going through a class again.
+ *
+ * The caller holds p->pi_lock, so @p cannot wake and migrate once
+ * __block_task() clears p->on_rq.
+ */
+static void sched_change_block_task(struct rq *rq, struct sched_change_ctx *ctx)
+{
+	struct task_struct *p = ctx->p;
+	unsigned long state = READ_ONCE(p->__state);
+
+	lockdep_assert_held(&p->pi_lock);
+
+	if (WARN_ON_ONCE(state == TASK_RUNNING))
+		return;
+
+	/*
+	 * Hand the donor role back to the execution context before clearing
+	 * p->on_rq. This is proxy_reset_donor() without put_prev_task(), which
+	 * sched_change_begin() already did, and without zapping the balance
+	 * callbacks: nothing redoes them here, and they include the pull that
+	 * switched_from_rt() or switched_from_dl() may have queued.
+	 *
+	 * If @p is rq->curr, __schedule() retained it and dropped the rq lock
+	 * while picking. Block it like any prev that blocks in __schedule():
+	 * keep it set, and let the pending pick put it.
+	 */
+	if (ctx->running && rq->curr != p) {
+		struct task_struct *curr = rq->curr;
+
+		__put_prev_set_next_dl_server(rq, p, curr);
+		curr->sched_class->set_next_task(rq, curr, SNT_PICK);
+		proxy_set_curr_donor(rq);
+		ctx->running = false;
+	}
+
+	p->sched_contributes_to_load = task_state_contributes_to_load(state);
+
+	/* The DEQUEUE_SAVE in sched_change_begin() skipped these. */
+	sched_info_dequeue(rq, p);
+	psi_dequeue(p, DEQUEUE_SLEEP);
+
+	__block_task(rq, p);
+
+	ctx->queued = false;
+}
+
 void sched_change_end(struct sched_change_ctx *ctx)
 {
 	struct task_struct *p = ctx->p;
@@ -11212,8 +11277,15 @@ void sched_change_end(struct sched_change_ctx *ctx)
 	 */
 	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
 
-	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
-		p->sched_class->switching_to(rq, p);
+	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to) {
+		/*
+		 * A class that refuses retained proxy donors gets @p blocked
+		 * instead of enqueued, see struct sched_class::switching_to.
+		 */
+		if (!p->sched_class->switching_to(rq, p) &&
+		    ctx->queued && p->is_blocked)
+			sched_change_block_task(rq, ctx);
+	}
 
 	if (ctx->queued)
 		enqueue_task(rq, p, ctx->flags);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e3d1bb3fadd84..99038c2f6f4b0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4864,12 +4864,12 @@ static void prio_changed_scx(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
 }
 
-static void switching_to_scx(struct rq *rq, struct task_struct *p)
+static bool switching_to_scx(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
 	if (task_dead_and_done(p))
-		return;
+		return true;
 
 	scx_enable_task(sch, p);
 
@@ -4880,6 +4880,18 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 */
 	if (!scx_is_cid_type() && SCX_HAS_OP(sch, set_cpumask))
 		scx_call_op_set_cpumask(sch, rq, p, (struct cpumask *)p->cpus_ptr);
+
+	/*
+	 * Don't carry a donor retained by another class into sched_ext unless
+	 * the BPF scheduler admits blocked donors.
+	 *
+	 * If it does and @p is the current donor, @p keeps its running session:
+	 * like any running task entering sched_ext, the ENQUEUE_RESTORE in
+	 * sched_change_end() puts it straight into the local DSQ without
+	 * ops.enqueue(). It only carries %SCX_ENQ_BLOCKED once it goes through
+	 * ops.enqueue() while still blocked, e.g., when its slice runs out.
+	 */
+	return scx_allow_proxy_exec(p);
 }
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
@@ -4921,20 +4933,6 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 	return 0;
 }
 
-/*
- * Don't carry a donor retained by another class into sched_ext. The caller
- * has updated the rq clock and invokes this immediately before
- * sched_change_begin() records the task's queued state.
- */
-void scx_prepare_setscheduler(struct task_struct *p, int policy)
-{
-	lockdep_assert_held(&p->pi_lock);
-	lockdep_assert_rq_held(task_rq(p));
-
-	if (scx_enabled() && p->policy != policy && policy == SCHED_EXT)
-		scx_block_proxy_donor(task_rq(p), p);
-}
-
 static void process_ddsp_deferred_locals(struct rq *rq)
 {
 	struct task_struct *p;
@@ -8641,10 +8639,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
-		if (new_class == &ext_sched_class) {
-			scx_prepare_task_sched_change(p);
-			queue_flags |= DEQUEUE_NOCLOCK;
-		}
 
 		scoped_guard (sched_change, p, queue_flags) {
 			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index d32bc01071b01..f2b98b870f083 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -18,7 +18,6 @@ bool scx_can_stop_tick(struct rq *rq);
 void scx_rq_activate(struct rq *rq);
 void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
-void scx_prepare_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
 bool __scx_allow_proxy_exec(const struct task_struct *p);
@@ -71,7 +70,6 @@ static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void scx_rq_activate(struct rq *rq) {}
 static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
-static inline void scx_prepare_setscheduler(struct task_struct *p, int policy) {}
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
 static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 76f3c84ca6846..23217b91db03a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -543,7 +543,7 @@ static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 	update_curr_idle(rq);
 }
 
-static void switching_to_idle(struct rq *rq, struct task_struct *p)
+static bool switching_to_idle(struct rq *rq, struct task_struct *p)
 {
 	BUG();
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9e7993256c817..11d38b2e18f05 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2775,10 +2775,17 @@ struct sched_class {
 
 	/*
 	 * sched_change
+	 *
+	 * switching_to() is called with the rq lock held when @task enters
+	 * this class, before it is enqueued. It returns whether the class
+	 * accepts @task as a retained proxy donor, i.e., a mutex-blocked task
+	 * that is still on the runqueue. If it returns false and @task is such
+	 * a donor, sched_change_end() blocks @task instead of enqueueing it.
+	 * Classes without switching_to() accept retained donors.
 	 */
 	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
-	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
+	bool (*switching_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
 	u64  (*get_prio)     (struct rq *this_rq, struct task_struct *task);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 1e0109ec36b3f..b7541bb7b5933 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -78,7 +78,7 @@ static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
 {
 }
 
-static void switching_to_stop(struct rq *rq, struct task_struct *p)
+static bool switching_to_stop(struct rq *rq, struct task_struct *p)
 {
 	BUG(); /* its impossible to change to this class */
 }
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 45a127deeadd9..b215b0ead9a60 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -678,8 +678,6 @@ int __sched_setscheduler(struct task_struct *p,
 	if (prev_class != next_class)
 		queue_flags |= DEQUEUE_CLASS;
 
-	scx_prepare_setscheduler(p, policy);
-
 	scoped_guard (sched_change, p, queue_flags) {
 
 		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
diff --git a/tools/testing/selftests/sched_ext/enq_blocked.c b/tools/testing/selftests/sched_ext/enq_blocked.c
index 1d5e090b54bc5..54ee5633c5720 100644
--- a/tools/testing/selftests/sched_ext/enq_blocked.c
+++ b/tools/testing/selftests/sched_ext/enq_blocked.c
@@ -624,8 +624,13 @@ static enum scx_test_status run_one(bool enq_blocked, bool cross_cpu,
 		goto out;
 	}
 
-	/* Scheduler ownership changes start from a fully blocked donor. */
+	/*
+	 * A scheduler that admits blocked donors inherits the retained donor,
+	 * otherwise it must have been fully blocked on the way in.
+	 */
 	donor_state = ENQ_BLOCKED_DONOR_SLEEPING;
+	if (enq_blocked)
+		donor_state |= ENQ_BLOCKED_DONOR_ON_RQ;
 	err = wait_for_donor_state(&thread_ctx, donor_state);
 	if (err < 0) {
 		SCX_ERR("Unexpected donor state after scheduler attachment (%d)",
-- 
2.56.1

