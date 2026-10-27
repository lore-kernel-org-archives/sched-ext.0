Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793074582;
	b=aEd4f4Jw8oFCuxe/7wADsEWoBPhPXBB3llchclgb15bHzgCldHgR0lHNoD1qxqyQ2U66
	 l1B1tlM7Vq5Oo47wGJdf7HWFTBl0hl88tHiWocmqVKigXw+z5u0tbeNRI0XXXJf4B9BRv
	 S1/UeF9yRFhkGZ5KweRByglSZXuznSnsxGy6FgDq8Tfaw82N9Rim0sVntItiR8v0aue62
	 7RqmCpe22bbeCgTv+ZFKe3+vi/6LpOr11fDYIvaL9BM6Of7rThhMkqakEu0TgewSK9q0I
	 LExI6v+G+3pWDmVG0wfDdaDUNWliaXwvFd6tdOtC2RNUvrZ6abXfQy7zWt+21psVzOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074582;
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
	bh=gPgnWZGDXfB5Y0bpgc6OYpRby5JJve7s0XB9CBoGKmo=;
	b=PFMp97o7vLoyzXXrlqnykkMXhinDaN5x5eOFplkIW3qVTYv5n7FaWIAtOiH1vPNdsOqw
	 LbI4T+ALuSK4x9HC4TVbazHa7l3gzR9bl9JLcZZFbG/ZDPGi2p4TyTMNSysO7Z7fKzKb7
	 YZ5zGVUK5RbX8iG5H1t2J2WKRmoakXhhGX5Qmk4Xc1qiMPnlXOsorkV/PIbVKJ9ppr2pa
	 RQfqHm0Hm3vK/q0cLeITolITZYaZ76H86+WGxHInVJbjnYLRTnRRtVPIyQVeEai87fxpO
	 2I35dNVVoXZyxpeAphJCiS/TTtDLTdeTYveiT2FlRQDA+spxyDoagU0qWCv6vP7uzAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TV7nbY3j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD7606A321
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 04:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28DD7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TV7nbY3j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TueKu8hTFOaNexLhFBWpE601D0pckLOzxxIsTJXXNCR7woZ2LY0Qm70Mb9SNCSRRoev9U64h3NKfrH4x1XRACmkY2+AGsVaNZKAYpd4/bSmMt8Lg5/un8OYrKP7DCwQ1YiD+b/cNPboLsNIimha19sdSgQ8yGKHgxEmSsn/FkaRMzBPQZxTsDE+rZjIkpLV/r7325ylkkxQ4kWSBFfCKB6wNy62E5ziaeJF+TlWMwDHbqhhlqeb1lC/NARJKVLM1G5myzhjWkFvwFReXGo5Z0dpols/HhoaUkk5F6bm25aRa+hXP0LhZcRhzjLDzZod2/Ejacm57nB5BD17gOREkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPgnWZGDXfB5Y0bpgc6OYpRby5JJve7s0XB9CBoGKmo=;
 b=IvgqJD0S5zSNiU69ldq0MDWJdFHwQCDSXLUBEcmyE9QLrkjllFRW0POsoak7LltYRRnRJ2yluc9kCzqurc+VWRrbtH3goMTv3KOM3U30lXz1sqFkoFpUu1TmgPeEZ4F82O/5mSzGDnL5MUVoVmuSNa6H+txy4bVD8cp2XkFs0XjYEOOPhXlvkqWHXhaA40sY7Zje/wjCS0d/7z18ppqhw8ub+dNLLdNJvAC+tUGiD4uVjwXh5ncAfRfHRIIkWsaPPMPsnO1/dUFCXwJY/TuhHw4nfzdtYbFNxsViOLAVeUW4rpQvyM8pCHpMvBKF4KtgZO+NQrfAGVbAV+UgosXhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPgnWZGDXfB5Y0bpgc6OYpRby5JJve7s0XB9CBoGKmo=;
 b=TV7nbY3j/0t5E6rpsYJWGi5Co9+TRzKNUlbrQjNpXlvaDybX/OiWYMjZNRwpASEBV1rTJxsfN7NZN7VaZbsA6iSsU3/Z5UIX0VrSKaRodkT8ly2Pz2an9TNKWEeBE0YmOxS0HQM6wd6ZsCYg7wGcJ1zI885JVKOK+2hdX6qKN+RAxPnp0xShZkslNTRcynNOc2Cic9ZtZZbKqxNS2CVFJsfcTsmzOXbqwx1oJWCNjs9Ctt9wHb3sG+18Iwx+ny+aHOxK+3c6O1GXszSCknBQToqHL0wfUg8lrEOUdGe8gx92UgNJV95+1jiSQMdfpPLztPLyv5nSnpT8Mqe0maaXag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY0PR12MB825472.namprd12.prod.outlook.com (2603:10b6:930:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:16:14 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:16:14 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
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
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>,
	David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] sched_ext: Add a kfunc to read a task's preferred NUMA node
Date: Tue, 27 Oct 2026 05:13:34 +0100
Message-ID: <20261027041536.3317971-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027041536.3317971-1-arighi@nvidia.com>
References: <20261027041536.3317971-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:806:22::28) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY0PR12MB825472:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9a9a08-85a4-4b0d-619f-08df33e10a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261009223027099003|261022105027099003|261021121427099003|261022075727099003|3023799007|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|5023799004|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	5fCg2gGvd3LlI4YQSboddAng1aac2nmFcTf1YbQXFKr8swNOraZi07K6spyveI3U/oOfPwwgzINSOlEwS3JhAfpZ061WdQchO2yD203ZXI1oForvhPuAxzCCPCbhaOwoUpVaLltOFw+5lD6QT0QIOY8ao/62wFeTHjbtrshfn3nX2Q3Epn+Xa9DNFKfPAUY8cViOM/FSaKduJXqYBNyGuJ2FS64cT2g+TBOJNgcCbZLLfGbRAOKkMh2cJXwUVF3SEUyKyu2jyBMqyFx7NRnjCBxZ9jZ6YIb2Ve/QTnOvDetZrlXVHhQPGTrqG2I2ZRzuwkvmPjaqaM8IBivI4YXJpm23o8ujZ/CJW0O+0uw4mUic+6zvdGLEv45m/ttMHMrBBIt7YjZZk50oR6a2bhuWOAG9rpFZ3kfo7ERlERZA65Yjcy+pNzy26HHV7PF27THH3ttUJnLxv6YuZyasbI56Zxv4UQjO4zzK3kbCXSCm5YdJ3b8v1uqQp5YGOdSbyVMEYB3m0tZYoRmiUNqyn7jT5LNCPjVyfS3zEas+WYhw6hQuRN4gLbQgkhPkDMUghLmilfpbsXfRpeHBWwknHTLBcch1Qe7HHcK7KSf6vZDci+w2PRQ4okGdJPx4YZxSPpYyWiilZzrOnxiEdZ3VchU9Es0IeMIFeB+AiKlJchGvHnU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(3023799007)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(5023799004)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPSw70lR9zaGArejgT+fCNNZAstpNi5QOlWdHytaZt1FejmR5p92ZXq6bmH7?=
 =?us-ascii?Q?/K+tidEJJy6tEsyE1Wc8QGZ/2SkrJhC1wgwrmbXiS57/3QUekDHsT9PV2bYa?=
 =?us-ascii?Q?7f9zfN2/X+VVcSYxSwdpyvg3TIQpIM8lvmon1mT/qK92IQbWl0Dnni+qjv+V?=
 =?us-ascii?Q?jvDzWVG4fmK1TcWdrksMs0RjCSmGA1m8+iGa7xxd9B0nrkqVm3EFkIdLVYgA?=
 =?us-ascii?Q?UPgKG1xUuB6+htoCm0u/H3+qyTaCSfmRuRrmrBVEIdunkY+w5/DGGlaulyrI?=
 =?us-ascii?Q?8R8xBQz4O5i6RWZMiqsvn0LYsm1J/ydAqu7B4ZcFqdLYjkZQLs2w1hnJCNOI?=
 =?us-ascii?Q?6RvHi7Dl82QjAUddcCSfIDdLqXPPRWY2heq7uq2y0fW8fMx+YS7+h46zMs3M?=
 =?us-ascii?Q?JSmGbTV9lHzJBbHK8lSolsQJt+7i1OU2dlCKpgrN0xY1/gtIDYkvzcRcc2b+?=
 =?us-ascii?Q?3KynqH/KOlmxIz6JDxX7iAdqgeMEB8zdolGlvvs6Ms9dhs0HfvgsZIjPRGf0?=
 =?us-ascii?Q?Ngsr0YqCk8beCiZyhuY27Mj5XruhpWEcAXxLayIlV+2DNAn+VX85Mo7gV0lX?=
 =?us-ascii?Q?CFAYouAPt4pxT/hIcEXAcfSV6y/ifQ0rIPbXZCkwA4KrUyB8QTiPtSiaDlHw?=
 =?us-ascii?Q?ZGPlEpHablG/2ugEOIQ7WhNe+mK7JV0oazK6Y0jAHi0ZvNqxIlHKBKteG13k?=
 =?us-ascii?Q?ghoc8j4ITNcoOlI2cukGfDa5t/N+tfSRQvb1EXAxt+brnqELjPhKsOpET/vy?=
 =?us-ascii?Q?RMGnDMLDgECoWsLLIs3UoGlAtxy66XNMWT4AKCC6C800xYIQmp7wG59juNeh?=
 =?us-ascii?Q?FuIG3tdjLPqmztIFcscLgKuMxq/ZmncO/V+CY3kAXU2KUSMNyvqcFlT1ur7Y?=
 =?us-ascii?Q?qCwvcxiWC+GOn5kUoQh8MIfLRGbHbUTz/apk6EJR5frIK15ibR1wtErbZzR3?=
 =?us-ascii?Q?ls8OHHUF/7OlWUmyHUro1+Fbig0am7BNiyIFPPptFE5qoXPc2Zo6OhBUCIn1?=
 =?us-ascii?Q?TaEViTZvlzSogywyy0o+xKO+b3mpYmOEhgqmyltyKBrp062HkKsh7pY8JQ/y?=
 =?us-ascii?Q?QlDQvyGaOyCtbVX2LprvLcorLvjBlYh3vTzRJ8e/Z69OHsmLZ7K9GYpEQELO?=
 =?us-ascii?Q?5Hkd6SWJs8lHs0xQoJ7/vjYrEYc90K9qh1fh90RGl8i4oFCUPZV8hMeg4E9p?=
 =?us-ascii?Q?VAGx/i4LIFLFBFQ3Qvbc/WTe8j9cSuzbcLKVo6pf56MA4/jnEOOuhcnxYk1T?=
 =?us-ascii?Q?zKo8EjkifBI5+HFYqmvr5Otia/FJAPf05NJYC7vnDsV8c7k5kbvm9X21GTzq?=
 =?us-ascii?Q?ON+RJBrMVeJOwwspaWT9Bk3MqSdCxjn48hh2KN/Eon6Jtr8+OKAkrYVyb1Jf?=
 =?us-ascii?Q?VxwKKFQu0QeWH/rDq/4MkYgfxYxNVssJav/d8hEGm2yKk45J5bISgtWlVhBf?=
 =?us-ascii?Q?eFO1INNcP1E7wHjiqcPRSYP92uuoIvZz4m1WDCJzd4sU5hicJwrAVEddFJE+?=
 =?us-ascii?Q?+1Xielny853jpQi9dHLll5WbQSH6Fdtb0ZJ0J0itXKsFwK4Uz7qhYnq/2XRP?=
 =?us-ascii?Q?pnzENyXQOsAfSk11WU7OXlMUUqnac+32kNkBEWAINsGRE25BE2FHmP+cTo7w?=
 =?us-ascii?Q?FXQAC2g6UUUskyde7xLeJUrC8gfll3AdNp5BhhBaWGEVNJXOQa2Bwr3dCjMk?=
 =?us-ascii?Q?OASEqr2T/cY7H4FoC9tsfESTdPQEhgWwWibe6UZZCm9ADYI9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9a9a08-85a4-4b0d-619f-08df33e10a7f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:16:14.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+vOVKHlUKmh+H7J6Mi3YDtaMuHPRXL+yCmvyGO5uYcjMsVIt1eLIZeXBoZ2Gh1nMuoAzqHoGF2LbVA+HEadHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB825472

NUMA balancing derives a preferred node for each task from its hinting
faults, p->numa_preferred_nid, but a BPF scheduler has no reliable way
to read it.

Add scx_bpf_task_numa_nid() to return the task's preferred node, or
NUMA_NO_NODE when the task has none. The value is a hint the scheduler
can weigh against its own placement rules. It is read without the task's
rq lock, so it is a snapshot.

This complements ops.set_numa_node(), which reports changes as they
happen, by letting a scheduler read the current preference from any of
its other callbacks.

Only report the preference of a task on a BPF scheduler if the scheduler
that owns the task implements ops.set_numa_node(), and NUMA_NO_NODE
otherwise: such a task isn't scanned, so its preference would be left
over from its previous scheduling class. Check the owner, not the
caller, as with sub-schedulers they can differ and only the owner
decides whether the task is scanned. A task that isn't on sched_ext
reports its preference as is, which NUMA balancing keeps current for
fair tasks.

Add a compat wrapper that returns NUMA_NO_NODE on kernels without the
kfunc.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c                   | 42 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/compat.bpf.h | 10 ++++++
 2 files changed, 52 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 076e3757c0634..fba2c83451ebc 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -11530,6 +11530,47 @@ __bpf_kfunc s32 scx_bpf_task_cid(const struct task_struct *p)
 	return tbl[task_cpu(p)];
 }
 
+/**
+ * scx_bpf_task_numa_nid - Node NUMA balancing would prefer a task to run on
+ * @p: task of interest
+ *
+ * Return p->numa_preferred_nid: the node NUMA balancing has derived from @p's
+ * hinting faults as the best one to run @p on, which is the node with the most
+ * faults, adjusted for CPU-less nodes and for the NUMA group @p may be part of.
+ * Return NUMA_NO_NODE when @p has no preference yet. A task has none until its
+ * address space has been scanned a few times. Disabling kernel.numa_balancing
+ * stops the scan, which leaves the last preference in place.
+ *
+ * A task on a BPF scheduler that doesn't implement ops.set_numa_node() isn't
+ * scanned, so its preference would be left over from its previous scheduling
+ * class. Return NUMA_NO_NODE for such a task. For a task that isn't on
+ * sched_ext, return its preference as is.
+ *
+ * The value is a hint, not an instruction: nothing in the kernel moves a task
+ * under a BPF scheduler to this node and the scheduler is free to weigh it
+ * against its own placement rules. The value is read without @p's rq lock, so
+ * it is a snapshot. In particular, a task that just changed scheduling class
+ * may report a preference from before the change until its new class has
+ * rescanned its address space.
+ */
+__bpf_kfunc s32 scx_bpf_task_numa_nid(const struct task_struct *p)
+{
+#ifdef CONFIG_NUMA_BALANCING
+	if (task_on_scx(p)) {
+		struct scx_sched *sch;
+
+		guard(rcu)();
+		sch = scx_task_sched_rcu(p);
+		if (!sch || !SCX_HAS_OP(sch, set_numa_node))
+			return NUMA_NO_NODE;
+	}
+
+	return READ_ONCE(p->numa_preferred_nid);
+#else
+	return NUMA_NO_NODE;
+#endif
+}
+
 /**
  * scx_bpf_locked_rq - Return the rq currently locked by SCX
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
@@ -11836,6 +11877,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_numa_nid, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_cid_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 3520a749f8ce6..7dc94e54db167 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -478,6 +478,16 @@ static inline bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 	return true;
 }
 
+/* v7.5: Add scx_bpf_task_numa_nid(). */
+s32 scx_bpf_task_numa_nid___new(const struct task_struct *p) __ksym __weak;
+
+static inline s32 scx_bpf_task_numa_nid(const struct task_struct *p)
+{
+	if (bpf_ksym_exists(scx_bpf_task_numa_nid___new))
+		return scx_bpf_task_numa_nid___new(p);
+	return NUMA_NO_NODE;
+}
+
 /* v7.4: Add scx_bpf_task_set_lazy_resched(). */
 bool scx_bpf_task_set_lazy_resched___new(struct task_struct *p, bool lazy) __ksym __weak;
 
-- 
2.56.0

