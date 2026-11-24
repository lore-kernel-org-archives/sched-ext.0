Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795503625;
	b=EkkyWBmWl39ly6QHeEQSc6w2gW8wS0HTnlEO2R7OvyNe5NBawNkF6XFcOTLErUdIO4TN
	 jaf4OmFgpqKxy/HA7tnitanCyDDcz3ixua3JBxnEVckJ3T5i1BQ6ji6MCiIVIbqsVPg+k
	 BIO4ylBEuqQ9jITaKBqU1cF/WiVZQYiuFkLvdoNhYwEzbUsXHWqaYG9NSV8Etc7pS5KTc
	 kHDX5F1VD1mufGG1tdxduiEEzzFyp5i2mV1Z/a6vOKBcoCUqI0U/jPW2q+10g7wgRfFcK
	 cSjhx+ZO9uOpthYnUdxcqgfP2LOJcdQHK7mO9zlG2yAWi279KvMiLZVfePPt9ibMnCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503625;
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
	bh=7yRa+/MNJrbNSTIK8umnWH5w0eK4qlu88c8vmhQdjlE=;
	b=2M9AhVqV//Or9Ybz4JQuCklC6pqcADHnsi1qQulEvrc2orvCkggU8yzWXIccID3zsssc
	 5L0dQ6DPPHDf08kaQ/MV9xZOzfTs7EzDUmR1OH++4H8+Dv7RIPDhevHAo2lD3B27OWDa+
	 sbGRguzXtqhcxew8mXWnKbN2UBt3pcmhBf8dbeD2cNBiCRlqBulRwbJsuJ8K+BbdsOeYy
	 kbi+U40SDhTvp4K5KHhXRhvuR8fGUe+OtvETYVZAs9V8CMhLUaBNyWb0ry6hX75m89ChQ
	 QCwUxTkkjFYsMX4Nqh2LRvt/DQs9RKcmQfChj5poIxrG3Enl0dcAQTivBMWiVzOfY2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qMnwFXGa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.4
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC9606A322
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 07:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81AC9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qMnwFXGa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXOY8+pIWARe1EYncpHQXJEixntmFCxTJGKgi/om/zFAUcVWjCrnqLveu8g8BlVXl3waR26O/QaSCaW8vyaan6jRjXJC6rhP3yhKjQkOR7ibrVLhXgsDZ7IeKLrH0wKgi/8IH1Rsrz1mKwTuQ8xcgVPyd3N8K69kE8Yn4mZA6LpfD8ybTxX+z/SQpHd+s20ji9xjVXcgg5iszuL98Vy7YcqSmWYHjHzkIXsmvqhTuMetStWrKuOWwNCkUPtAWtNv3rfKTGyoSRs55zDcafSfKaL4/tk2yOKooeDdxm1mJMoBU+2kWoFIlZKCV/O+holNjzzqcAmm7ZKzyaQi1NtXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yRa+/MNJrbNSTIK8umnWH5w0eK4qlu88c8vmhQdjlE=;
 b=lyVzjUjwUS1BC+jiwJzNQkRjZdiJ2w6ynf8ZZ41cIVRpboF2WvWBcp7bxHEBDzpmwiIiPnKNF/Ax/gDHPIjzBUrmSUgQdeu/+mcY0F7V2+e2V8rIwfVT5sjHkqwCWevA1eZjWmagGVPAVKTxMaUjeJRu9SEBj9kuGfPL0bsXyfbCFw37YRcmgdG9siuSfENC8UhqQY+5N4u6KhPPk12JM9/kvA2+z0GK9/9o3plM86TfkTf9BT9r697jDdx7wiC6mRL2rcKX/QHbKV4v6PYylOpFWLBHLJxs0glolxxJBErd3uBT4fF8XBsDSJYeVwtK7CDkH7zF9dLH/jJmDy5J3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yRa+/MNJrbNSTIK8umnWH5w0eK4qlu88c8vmhQdjlE=;
 b=qMnwFXGayTQ6XMLU9Zrw/b72fPEpNFU9H1Gv8HGumI/BkY43QWcNJD9j+yh1FPqflJGql5GLnfSHGs7ZaiecAqyFY4cLeNfwakmACdayybJDvqkw1wduVxsJXwwLkcI8JdNl2N+PHi8Ou8/2ck/cZo7xHFSENT0qtGG0dXwx5+YCws5beWxsuGRyviF37MhZXNz5TUpjfCBxHtxk76MAor1kH4YIyaC3wDEBEEZAqoII88U4hTfcOJ+75ADFmYY+Xoe2X5U1f5tb+hI+9qQiAwm/7X9G8k5xBglCGqijiIouYU3RIp1E7eWQ6ZFhPCG+bFQEG0QoIaN8mK/sV0s9Fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by LY0PR12MB782425.namprd12.prod.outlook.com (2603:10b6:404:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 07:00:21 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:00:21 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Tejun Heo <tj@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>,
	David Dai <david.dai@linux.dev>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	linux-mm@kvack.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sched/numa: Ignore stale task placement state
Date: Tue, 24 Nov 2026 07:59:07 +0100
Message-ID: <20261124070011.2498455-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124070011.2498455-1-arighi@nvidia.com>
References: <20261124070011.2498455-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA9.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44d) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|LY0PR12MB782425:EE_
X-MS-Office365-Filtering-Correlation-Id: 449e25d3-b7ee-4e8f-ce49-08df49f89ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|18002099003|261009223027099003|56012099006|261028144727099003|11063799006|261021121427099003|261026140227099003|261026121527099003|261102123227099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KE64lWblwaE/TJyFiO8Zq9oD+fLF5YpSPP4kpOjcHSrjCUIO3kwpiHh+aRgbaikE/uNaFL3V5SftxUZuTzE8o8FZnEpdQuNz/xx3g/kBg9A1CA58iDpa+OEJqZ/Nv5092hm4NmUc4B2ZIorgaMQ/xhtyMPVSt27mGMG3+lE5w3MNEj3HusPG8JseOd3DhCgfeT4DQC441UmHq1rq9OI9iCqPRH7rOUyG0BpZHB/g46E0O75o6yPkntbcIg9eJ8sjiIb/2Qe+tlnEUXc//AQkNr8X6QyTSZgVfCtdz6rVCFhFxFq94cnmpy5n/z+iKiGCwc2+Tk+FfLF9RYS/L1MTwjGv7jjpNIc5VnO3RNT4vz+wLcv+wdj+uNeccEpzJkVhQGwczQ/gsULe5xTZk3fSKlr8dXSn83Wksu55TLlFWjQFeBdJJ3wFE0BJZkgG3Q3npHix3jgwJu5W/dhYHEVthFA9eX6dVep4Qh42I/uB743RbWGDC7HJ+g+56AhAUxF4p+IJutmCMfH3+h9eW6U5uRc1BAIfQlJfCBjG7pAPInXmJSoSYk7bKIk0h+QoGJ+6oScHsn9GuDlsbDWLIA6tX1S70XXLKva9d+rQDgw8VPz/MgjP0FgcwF2SBM8S3d7HqdljKuCg/G/FKBygwk0XGjfQZ00CzdHyZB3Be8U8nDo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(261009223027099003)(56012099006)(261028144727099003)(11063799006)(261021121427099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021123027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57HDrOBkJ1a4vZRdcgSyaJ5OrYCnovJQ8gmvZ+6Xd84NRrZPVQZiifWj2yZi?=
 =?us-ascii?Q?RLrZkGixgq5Qll/ZibrqSzKYp69kh3xyXqtzHbeF5wxLx76keISUrzaOXUYE?=
 =?us-ascii?Q?Ef+xa6B5743nuFiilRnxyG2rhO9DBkBOk6GsHjHaMbhzuhKx53tZxX1+mUl2?=
 =?us-ascii?Q?0FIbDaghVYQL05VYIJqF4laz51y6giP6+tAVBcXo7P3vSjsYQd/dTLuY4Oke?=
 =?us-ascii?Q?EGcP3Yapx8rQOrsb1T7j3PTYsOWOvKlz/lXTjT3Y1PyrmvL2RpkYHdGa35kK?=
 =?us-ascii?Q?NuPhG0I6Kmj0LR+1XT5V+1IoXX9oTfH9ZsvIWFNTnBTx15PCCT+/HWC7pIwr?=
 =?us-ascii?Q?GBZX3OfvEsa5+aKc/Wxq/ZFrSENWR8gMb9x+lnvVkpNDOl0Th2ytsrjpU606?=
 =?us-ascii?Q?EexVQjYmsLuSsVYCnGAuud2CmsaLRrvtcbhGZiEl0HQDMhIbVA69Eq/UOkY/?=
 =?us-ascii?Q?4Tf7biCnTRoHk00wutl7R4YFsieQM6cF5CahJ2fduB0iLt7+5m88RwqBFXDa?=
 =?us-ascii?Q?RPT+p1dfUzS10REwlBoyKJtqIXxP32oguqeCLQ5+FhKYHYSkVCj8hWc9unBr?=
 =?us-ascii?Q?zv1kai6giXHID7lXrhPwLuHALq7mDMOySF1Lh8LT5b6mqqX6WIVvG4gTetMf?=
 =?us-ascii?Q?M6GQoi6I2Xo1MhZREk79e5taPauI3rfhTKQIOwue/CqG7pe9tg5i8E5RkUzr?=
 =?us-ascii?Q?dcX1sWnRzdoV5xrsnSmYMLxplaDDD32R31tl7Xprbl6tGIo2qUr36nJGZjwF?=
 =?us-ascii?Q?7OfkUvs4SGJtlqd8RT1mhGLSLOZWYnFTLUZxYaNyFHd+6J3HtfoGYIXzex0/?=
 =?us-ascii?Q?A89+Fct1wmRYIMZ4xidWXfQdXW4QuXKX+kZrY3OalwbnltZZgJUAEIwe5T83?=
 =?us-ascii?Q?x3qwvEHIFH7qMYGE4R+l8Ev3NwEKiYTnnGzfqN3J3dwJMf1TfQNcevGoWcFk?=
 =?us-ascii?Q?NRVnHokgLSN6F+uJ6cKGRvRTJYMQ0IwGVk96N0JIsW2A4PeIR13DAeQOhY3Q?=
 =?us-ascii?Q?fJPQCzYnnilAewYO8znB0xoT2jC5LBjhs22l2kMJCXKl7MyCvfH4v3D8EInh?=
 =?us-ascii?Q?mIiVLCRpmL+ea6LGqzBweKI1a+6baO37d0m0CtTiHBHWHjBvhuZzPKxhwSEH?=
 =?us-ascii?Q?Ld4YNiCcnYo0uKTBjJ863kCnywn3FBCc6v1JPpRpyIQdd4GtQh0ll1XdAztS?=
 =?us-ascii?Q?nQqgGgpJbfNAo0Y8O0hK059xC4WwH+3xtVhffs1e9yJeNvUZRblUxCIQV9zS?=
 =?us-ascii?Q?C5I2oxWEq3VCyzpLZGtSR8T/kEgz07yIsPxa6yh8TV4ZInYxoBg4f9Gl0kcU?=
 =?us-ascii?Q?f1b2j3j6ZbzzdexbmBORoeTx1gz3126RXNZE52NsvlD6mLDCFjZoVAf8viq6?=
 =?us-ascii?Q?SjgOeCTfSKXf98UaGKvzFgFtDiN1DbXKjpX5b4nxv55d/m8YA3yKuloebwes?=
 =?us-ascii?Q?DxdlcVOk230E6tfh/Z0E9TMes1cbLQR+0hmKPzj1GOO0k0R4g5g2plHOo15b?=
 =?us-ascii?Q?MfyMUoHL0NdTZEgyKFBJLnerqNhvkRKfdDP7FY8eFc+bOQJfhU21zCSdIEz4?=
 =?us-ascii?Q?WlNX9l9SxnMf6uRmAsNX2EH7j1TNWNMW4B77V4o+A4HFFNXu/aZQurBauWUt?=
 =?us-ascii?Q?Q5WvgOYTJyKOmCK+lEVKHXLgzieueD2Kpsg0WJR9DsVCMuQpoDFjo4fJXkvu?=
 =?us-ascii?Q?8yemaT0+O8aixN4ldPhW5PNJIWLQ4NXPDkBh5RdRL1yIXp+d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449e25d3-b7ee-4e8f-ce49-08df49f89ae0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:00:21.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggf5l4Qw0XkLX6T/v9QNKPXYE5BZnCXYsxwbOFkbaE0yb55lv1cLq9Ecgh9iI7vHtaIBdR0oZTEzZ1O5aymuNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB782425

NUMA balancing maintains the task placement state, such as
p->numa_preferred_nid, p->numa_faults and the cache-aware footprint
derived from them, from the hinting faults recorded by
task_numa_fault(). None of this state is reset when NUMA balancing is
disabled at runtime: task_numa_fault() bails out early and the state
simply stops being updated, so it can become arbitrarily stale. Some of
its users don't check whether NUMA balancing is enabled at all:

 - find_idlest_group() steers the slow wakeup path toward the preferred
   node when there is spare capacity at the NUMA level;

 - the fbq classification in the load balancer, based on
   rq->nr_numa_running and rq->nr_preferred_running, skips runqueues
   whose tasks look ideally placed according to their preferred node.

Gate both on the sched_numa_balancing static key, like the other users
of the placement state. For the fbq classification return the same
values as the !CONFIG_NUMA_BALANCING stubs, so a disabled NUMA balancing
behaves as if it was not built in. The static key can change between
the group and the runqueue classification of the same balancing pass,
but any combination only makes the "rt > fbq_type" skip less likely, so
no runqueue can be skipped incorrectly.

Keep updating nr_numa_running and nr_preferred_running at enqueue and
dequeue regardless: gating the accounting would leave the counters
unbalanced for tasks enqueued and dequeued on opposite sides of a
change.

Switching kernel.numa_balancing from 1 or 3 to 2 (memory tiering only)
has a similar issue. In that mode only the folios promoted from the
slower tiers feed the placement state, but top-tier PTEs armed before
the switch can still fault, and task_numa_fault() records them as if
NUMA_BALANCING_NORMAL was still set, possibly migrating the task.
Without NUMA_BALANCING_NORMAL, only record the faults that migrated the
folio: this drops the leftover faults and keeps the promotions.

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/fair.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 731d78155e654..46d3c927b8b58 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4163,6 +4163,15 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	     !cpupid_valid(last_cpupid)))
 		return;
 
+	/*
+	 * Without NUMA_BALANCING_NORMAL top-tier folios are not armed for
+	 * hinting faults, the only top-tier faults are the folios just
+	 * promoted from the slower tiers. Any other one was armed before
+	 * NUMA_BALANCING_NORMAL was cleared, don't let it drive placement.
+	 */
+	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) && !migrated)
+		return;
+
 	/* Allocate buffer to track faults on a per-node basis */
 	if (unlikely(!p->numa_faults)) {
 		int size = sizeof(*p->numa_faults) *
@@ -12538,6 +12547,13 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 #ifdef CONFIG_NUMA_BALANCING
 static inline enum fbq_type fbq_classify_group(struct sg_lb_stats *sgs)
 {
+	/*
+	 * The preferred nodes behind nr_numa_running and nr_preferred_running
+	 * are not updated while NUMA balancing is disabled, don't classify on
+	 * stale values.
+	 */
+	if (!static_branch_likely(&sched_numa_balancing))
+		return all;
 	if (sgs->sum_h_nr_running > sgs->nr_numa_running)
 		return regular;
 	if (sgs->sum_h_nr_running > sgs->nr_preferred_running)
@@ -12547,6 +12563,8 @@ static inline enum fbq_type fbq_classify_group(struct sg_lb_stats *sgs)
 
 static inline enum fbq_type fbq_classify_rq(struct rq *rq)
 {
+	if (!static_branch_likely(&sched_numa_balancing))
+		return regular;
 	if (rq->nr_running > rq->nr_numa_running)
 		return regular;
 	if (rq->nr_running > rq->nr_preferred_running)
@@ -12848,17 +12866,20 @@ sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int
 		if (sd->flags & SD_NUMA) {
 			int imb_numa_nr = sd->imb_numa_nr;
 #ifdef CONFIG_NUMA_BALANCING
-			int idlest_cpu;
 			/*
 			 * If there is spare capacity at NUMA, try to select
 			 * the preferred node
 			 */
-			if (cpu_to_node(this_cpu) == p->numa_preferred_nid)
-				return NULL;
+			if (static_branch_likely(&sched_numa_balancing)) {
+				int idlest_cpu;
+
+				if (cpu_to_node(this_cpu) == p->numa_preferred_nid)
+					return NULL;
 
-			idlest_cpu = cpumask_first(sched_group_span(idlest));
-			if (cpu_to_node(idlest_cpu) == p->numa_preferred_nid)
-				return idlest;
+				idlest_cpu = cpumask_first(sched_group_span(idlest));
+				if (cpu_to_node(idlest_cpu) == p->numa_preferred_nid)
+					return idlest;
+			}
 #endif /* CONFIG_NUMA_BALANCING */
 			/*
 			 * Otherwise, keep the task close to the wakeup source
-- 
2.56.1

