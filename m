Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0839794B
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901894; cv=fail; b=bVW25/2O8WH9vmOlLMuH6fxxUtOVzoMp96AxLgIPKga70H4EPcMHe8mYW0a3Xm+JXFrPkbRM5WaB5dwZ8NCbZuWISml6NVFQk1ILgTHvcmomAHZ5E+hv3OJPeAhchigGwrBIa477Jv8oymFwMhp1O5CYO8NzmXtBVH79tUUrDSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901894; c=relaxed/simple;
	bh=wGEIe78AqwFKGKBMtiQ5vNC7taJFMF3Vkoyt/7vQ65U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S0j9gorImBlx5KBn3iBkKfVP/uzRoIt8Dujq2Rzqe3cbf9SA+ZbCdCKSbTCSwxJ2SJKq3TMCWtZHl0Y7onjhA+slITgTsCzLJDtzdbgLEzUG2X1kCfLVoGNjHYpjqQVE8BuvpLZ+ztgQPQEmsXaAP8tgpyyizbRwcUn641kJ5bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P+07QuV5; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P+07QuV5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG5grSDLkdcIlTWsEWSASK1oRO0Ajir8RIpz5loGnxBfdeKqn+UQM6h6OTTyi/KzM3GqUNTS5d8avc3alF/aTJBGwOZyDKbxU3kpuVTNVKMac3J7+LnbQdsrpd3ofPqmpWTAs8a0tM18iDpoiB3Lv2IT7z9OiyWIqEfX1VqZlcMMcZOfMAG9gArGso3oLK21qnQWvTFFC1NoUi1HNcBS1RQ26NxsBhERvA7PgKGr/w8SbZ649BIG46idNv6T47QO3/ebsvNFaipFPs4s9MEokjNQfhkGDyuSXEc01hzMYKxS5ZzQoM4vHM1CrpvWB0LtdtRW/pZp2b6KYvRvM8f+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy7P+wgKw/8NVAQ7dyR5IzYz0uMWhs5/CoyyUGRpME0=;
 b=TNmD8C8NkGWOufnx2RJcIUT2cV/krfLBE4S9lqBp+FUuHKUkM2yazYoMIhDua4hgQL9Qln1GCsWMgRsyYfqfWf+LMj85xleYY+B08aobi7CMfs5ZUN/iYJ2CxZobuvg4ITabmsPp9m9qvEBkcipp9WI6LacqCb0l0UzL1fh7MuiyNZ7HNGRwmxs3Ik7jmD2mBogizVrbkJ286DIjEQs4Acql0evImz6NgAjghJyN3Z7VamgRWisXUXyO8mvKUTGwKgsVE/FqK0y3wI//DnlL58bp2EMKaYaasYwykVB8+W1uMYFi2PxHJxmZ7IsuEqPJkPqy4o5HMAX6np8fyZsWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy7P+wgKw/8NVAQ7dyR5IzYz0uMWhs5/CoyyUGRpME0=;
 b=P+07QuV5/+tXQablVjpq6GHzhEAZThaOYHAPIv+l0O9Fgdb7z3jmEwq+JYcBmTcPFvTVvY8Yl04bjsymvFOzzHmLoEG+hklljQR3ZN87OOsg/F7TItWwbwL3A1y8mXBLNktHMrsHDrONKIZTrinN+OLAVc8vFwEnf6yJwmaNy2fsPmylfG22eBdzVtLnSFM+urkHGLrz5k6mwNJ4+T76un/TUBTahiKdqQk/C/w+tSEtEtwIb7o9Wwbd52NdmifWEFrjbqwHC97LAKA9GG8TU+k1p6n3nBAzdMCO1yG0NNsc3vdDl3AvfpKkDs3XNOZATfgydZfRoPiAiSXX1OR4Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:10 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:10 +0000
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
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] sched_ext: Block proxy donors across scheduler transitions
Date: Sun, 16 Aug 2026 19:35:06 +0200
Message-ID: <20260816173732.17162-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 575b149b-9c17-46c0-6783-08defbbd23e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ieYjyqANdANl5qomLkpgS4mBam5GegverwUL7ZMNQey2AvGXy4abDbrWOvqc0vmeOrBpcuyuBr0WXBkuLIxmxfyXmCm39ICyxdUvYzvuxUSpBSaEkwZVD+e0M1Syj+YB+0K1r1ATKKkZCWeytRRZgQHN76s4d2chOqzu0OcF6ulu5+lxyB9DzKgV0g2UOAGUK7Tx4VXWF6PIDCxiwkJQ4OaFmuz7jRSRiwGoM8KcQ7S3h2mAtJVMTRfdwJUWb4mYQRv7J+/iZ4VjegXwEmGZD8Jo/uculCqkbTEEqZo+fKylXny9zIO8wqPhaJa8CImqc+loyYHPrjTBXHmVojHnae54lfJAWLF8vtPt7WNwc8ACv5D9A72OP8eEjrZowfxpYhNEzf/yZbdncWfEOBgwz3JwzMHzj3e3jkIVS055VJIyd7S3XNIWsgxe+1zOGPMXHVWVcAjzmUDwoQxHQC6XcBcUA1PFsKV8z1A+0IUV75yGALA96CryG85hhlE3EpBstXKXfV/K8bCWVjx5fo2d+Lc51Q1HxCL2OVKQY1RVVlMz2LG04hD/ZyYsCJDiugkha1uFSNwYssoz87GoFbauSm7fTRJcy2RMN/8w+M8xmWCZX0o6Bqktclp3OXE0RYbfaNw2dRlC8Gn55HMw3WJDdNioqXGWus9KlmJZ6VQ06vU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Kckuwo9tFhmrX7u/EUBQwB3bxBBlg6D3AkM1MJ+SLjqOxvqTWw1MJDkURL/?=
 =?us-ascii?Q?kRQ8TJUF1I/PdqrWYZ9QIPUQqNN+Z2hVOyujLoB91B7Fzi/oK6SmLTlQ0Mvs?=
 =?us-ascii?Q?7VFxyxI1GFzWWuAlkqwby/eD7rAnZSdXRY0LXs3SXhiWPS6kcFJO2gzfGEkX?=
 =?us-ascii?Q?z1+udwJy1TJ78r5vmMjSi6VHiCewAKbf/qxREyBekkwRi7Azlj0jlmlNRrJZ?=
 =?us-ascii?Q?a0lyP453W0Y/KMVOMuQHq5KnCxdfVnUfu35dEiul5KXZKhZHRyp3SKbAhoFw?=
 =?us-ascii?Q?U5BdrSFtqBHbah2U2+vRynL7FYjWZNZ7CUYBGYDbSArTbS49SBpJOSuVYbGo?=
 =?us-ascii?Q?J5HFWIn9bTF7WsBjpa4P9KhzJ5BsN3C300psoBwmUTtVkVq8j8kJV+iD+c8e?=
 =?us-ascii?Q?i6QC4/k6k0/eUdTf3f0EK1ftHk8kRk1Ts50TgiWmoiL+Q/Vk8OLi9Ju1fdWS?=
 =?us-ascii?Q?0PxBezM8xroX30xHeaA/dIKfjaUdS0YJtrn3B7RQTLK1a7KoFkMwYkigfgPt?=
 =?us-ascii?Q?TAbbHzF5lN1iBL3Sqm9ZekaPVM/YbWE7LHbrmIon/UMxH1wxI+IyEOBYdi6O?=
 =?us-ascii?Q?XHpd+N4Ezx4oPg6NppnadaXnVhm2XcKBptc1pc8oryDnGNphb1vUr3qaKubN?=
 =?us-ascii?Q?XXQc3kTlvz+3IxLZNczPSuLn1wl+jNgHCg9xlyQxs9GzWEl1RMRiwpPpBRAB?=
 =?us-ascii?Q?erCqv3oJ3qBMA6DO7lnkwQHf6zVNYuGhdHPnCsZNtiJmeF7odb3CHPt6u2C2?=
 =?us-ascii?Q?NzxQ7WePFFmmqO45DmsMyOW2RMFOVg+OzkcTYi/yLBl4b2SCpRFurKma2Xvu?=
 =?us-ascii?Q?7sqQsTk0Twf8PIGp9UKZqmlSNNbwRb4anpq4cn61I2wXmhyAXQtdbyapXwIL?=
 =?us-ascii?Q?fgjo3b4jVkq+ZYNYTDNtFaieZ6uQFYHEb8XcO95WViDDS+C2d8T8rVWOcdls?=
 =?us-ascii?Q?I5A1Xg14um7rh77vGU1nIBCGn195zPrriTPlwvnx6GxQpNvP8az0fJy0J1B9?=
 =?us-ascii?Q?x9PSvJbIFQtAW5GXnLRbD2wa0F3hfetJgDGP6YVcgXhEaVE+M5DEJgoZgwwK?=
 =?us-ascii?Q?Zqil9nL3XfxjiKNlz9GZNEvmbJCuNnWvf3leZH/36sAid2FTPzJWqqCQ8rPg?=
 =?us-ascii?Q?dziB3Bs9BlFG/clpNR2GDFESrYm1jYiGJaRUz8PNp6c8Og1b620E2cjHsXXQ?=
 =?us-ascii?Q?zxxZJ0kKCC8eOdGpGiz2w/5fkwBjEAn6HisSdMvBNErOfznuzxYJMj8DyhJY?=
 =?us-ascii?Q?hPtJ0+KG6hjKUvLyighvC2nE0Mm8ql6qJo09nHB7LI8ZhBR+mEFjMhXOqBI8?=
 =?us-ascii?Q?pQf1xi6KZjAMzSsCSvj23xYIFIehD+Ud604h2E1C0KnntbXxVXKhnw8fl+P2?=
 =?us-ascii?Q?eI+kucNpFGuR/lqFGKLnPWveAYQgIb8AsjqG/gTImisR46roeD51/BKqJtkE?=
 =?us-ascii?Q?LGYHxnaUxxa4npFk+HlE1yK0D1HL8KIwHO213z8gI6c1X4YGCGr/S3wR8YS+?=
 =?us-ascii?Q?7uN/CLPvABakdGUNhNqFeVRPD0squ0FvkyS3II8RKNDgvqQQEwB/VsHq9H7x?=
 =?us-ascii?Q?1vTZXYu/2lMZa9MqnCa/RRek/hpQCALupu0s91It1TVtbBl/RZbFuiCxZpm2?=
 =?us-ascii?Q?e7k/tinbv2BfkCbyMccLxnO9EEomlK9+ncJKM1ylIx4ZDW4BcdIkE3I1jmI2?=
 =?us-ascii?Q?f3AA2VZ455BVvmTdIY8ZYEgKBpE5jXIXYSO74Nw5M9JUL/svDV4HCzbdHkpk?=
 =?us-ascii?Q?DJ5YT9Yt2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575b149b-9c17-46c0-6783-08defbbd23e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:10.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBLdYP0xkJO2HfeHkbt68Jp5VKVJJkiFeOhoT6G4SKJc2mq1m41XmGyIx6eju9F9wYCITMDkQbYMNmqzSJYxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

Proxy execution retains mutex-blocked donors on the runqueue so their
scheduling context can execute a lock owner. sched_ext cannot safely retain
such donors unless the BPF scheduler explicitly participates in their
admission and ordering.

Make sched_ext reject retained donors by default. Implement
scx_allow_proxy_exec() to force blocked EXT tasks through the regular block
path in schedule().

Also fully deactivate any retained proxy donor in sched_change_begin()
before changing its scheduling class. This prevents sched_setscheduler(),
PI transitions and sched_ext activation from carrying an existing proxy
session into the new class.

Some RT/DL PI transitions could usefully preserve the proxy session. For
example, an RT waiter can boost a FAIR donor which is itself blocked on a
non-PI mutex; retaining the donor would allow the boosted context to keep
proxy-executing that mutex owner. Doing so safely requires defining which
scheduling classes can carry retained proxy state across a transition. Keep
the conservative reset for now and leave compatible RT/DL PI chains for
future work.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c    | 9 +++++++++
 kernel/sched/ext/ext.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ea432bf307c1d..23e92db0d2c74 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11295,6 +11295,15 @@ sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
 		flags |= DEQUEUE_NOCLOCK;
 	}
 
+	/*
+	 * Don't carry retained proxy state across scheduling class changes.
+	 * Compatible RT/DL PI transitions could preserve the session so that a
+	 * boosted donor continues proxy-executing its lock owner. Defining which
+	 * class transitions can safely retain that state is left for future work.
+	 */
+	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class)
+		sched_proxy_block_task(rq, p);
+
 	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
 		p->sched_class->switching_from(rq, p);
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 6b1d9c98b8efa..7bbe3c2e243af 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,7 +26,7 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return true;
+	return p->sched_class != &ext_sched_class;
 }
 
 /*
-- 
2.55.0

