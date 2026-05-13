Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B803A6B83
	for <sched-ext@lists.linux.dev>; Wed, 13 May 2026 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671492; cv=fail; b=h2FW1PcW4orquMBN3L1Z4Sq83naObmRHpgfT+uw1j86xHBSfjlOiCgkB9LuteIXr+A7XBhufpEo+Gjx/OH4hoOvAuCt47rS5B39dN54utKMlRskc95sp9K0iqNRZc+iXJhbOfkuwda1RbKIkUGvwrxVvXQ/CvMvqwZfEx15wYMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671492; c=relaxed/simple;
	bh=s4Uad6FZoXCJ5QVAL0DgcXYPGqkk5jSbil/YkPjIgyE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aUAwLlTpqFpBXNZwbs9ANGHJzKalM254NmeXciM/nOsK8pHkbYVX6MRCUaFB/dQ3vkPjPBN3DqLLgY5jByUZ9KM7Y8UGaqUsS+nAxXyABHIaLvrkyya6SoFVy2hD9J5+PNOmrxzfoRzEd7COS9pDJjrhKLy1ZaZbxMJGEVkncZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Axtj5q44; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Axtj5q44"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhfwZz9Q83QIvO9dO0vD1uoFMqTGy5aUmQlaVZzr7OdpSIup06YYSYVvPHPJIun5i8pU24I849OmeJuiUl/iPqJmKP7D8+/dRRNlFuRCC8hCx6iLLthAVqHIjlcC0ZH6mvn9Aclim700PMW9fYXM+L7FMTcOt9PjmP2jCt0ZSuAyhprJXI84DKnkrM0fR0KR30uAejbaTb0StAIJE85dsDEwJ3pCuVaEQUpEF0US/Ce0hSJmRbHOnu0D7oJHkt5LwTmV8P9efxwK04+NeAMk++gxvfO3o5qMTM9Sc4sne+zHR4uzpaacBdnrnK8PGn3uNe4g4XjmfkKPidGYUDDYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48InOuNpeoPDcpsG97kRGRn8J84UdunvdqVSiTYbgR4=;
 b=TDabW5o4NVXWs9py7lDrr5wComJohp+PPRB1cH3UPQl6WvPz00fgE/pJvjNu3Xzb2EaIUNSMteetaZrL5kd7xddlyoBpGZ3B0kJGeiDsqWljYLuLHwpAKtKXQkgEji0mEiNzi5XMkgEv5PFU378L7Ctp9lmPpCzeGEnzusBGzszprVMLDs71QmL8eyiPE7OF+o5s+HpXlEnYnLCORH/g5bjyWJVrt+JrLsk6pxD4x7AD2ubP2ShGSGNOV/JCiMGArr6+CK1uFKK7A55DI3FiKAmh+BieMsibZjbfWTnAXp+XNlnrI5VchA1ywtqjMPr9ipkA41L8uXTbQAEOw2PdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48InOuNpeoPDcpsG97kRGRn8J84UdunvdqVSiTYbgR4=;
 b=Axtj5q44YnqroDGfV2B1tFzqKj2gvv6SZZYHg+QOK5XlUJdZoZ0/1oMBidhfF7KZHhUROpK4jUgateQ8/ES3x5EagcPcOknigdmw4hTl5sxKuFewtG/rR8rjdxlJsoIZhoNJ93hgIyM99H49dIDUoUNy4vvB7iaBnIprEULdX83rlubVAS5XM5QQfO7Rqo2RbKggYd6fUmaC1EcwkgATq4oFQqaDqMaPiwnf7RsBg2qR3wHmvtlui4XhRXmZsvu3OgpL0rOawQbhb6N8znzvy/nuzHe7tgXWc7s8mTgwtcp1CKJrrCbiK29ld/96P8IqRkivuKIES6xx1ayHY+yGsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:24:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:24:46 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation
Date: Wed, 13 May 2026 13:24:38 +0200
Message-ID: <20260513112438.642055-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0180.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a6f4e5-f1f2-4595-1035-08deb0e23caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oOZHSr2+0qTft5dCZZyTKi5Jat6H/aCjezsM7/CduP+VhovwjBtC9lTNeUcaY/AGx0BDUhhODF87SsAJMVddCZRKAeNxl7dPnoPrHIaUzDNBdYDsIYDDuYa94i5jlMFZPExkqw19Pu/wijax7V0NpBgqdb1tJhrzWdQYnW5HtqcVr0TeT9Lcy4pUQ7+RJdXkX7vhrd5EFTnqBpzTMt8gMSwoOaYAMrtRUGgc4mvRAxYBhuIP3cUCSYcoS24Q2YJOALEIT+Lc6ksNa3XhWo9JblAKHi3Zv1Ay/V8JxiGWs7cUmfRFUZie0sFJ2Xma71IoX/v8db/CeUIRoRaXDLDyMcH36q2yx/tiXslfcSUsQqSR+4/ATNw1+yXFF2cPE7ig+EcLSZcsYP03N02svd330xf+eRXCrtWtYsT+ag17lSK+tK+qaTUVovAWPsWn8Lf9Mvj6d2ET5m3P51ZgfxD5Jk4iDgmlM2S3smqH9D5Ocxk2JPGQyuHBGUQAGtL00T3yoHNNuVf2qZpH4escvtCTVWt0XpYM/DBsrQGM7SxL+p/NtFJwsn7eJNQz1ceI2YGLHYJwaZYf56TDwo8RUASzkmA5l+5Mg2VVsK/lH1WvZCnh8r6Y5CPvQx0p/QVDfLw7KOhFFJl3FyDxhNvdrqHVlJ9i4TifQcKRRW9aAHvqREGKvGTuIBY7dq7elcmixoov
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dly/KYhyhzrXebL1MPweUwUPCW6IAN91KeSKezMRktJS88piIX9UQhLL8lTE?=
 =?us-ascii?Q?9eyYcCvCq2TjKp0uYw4zZSpsK4dmV9w7abdrWjCQ35dEY17Q2MDX1DfEEISs?=
 =?us-ascii?Q?pE9S/T9vKvDq6AaQAfu7Ha8KjOg+DYfKMw6Sj0fydmBPa3YockC+7iW9DeQh?=
 =?us-ascii?Q?OSBLI6XQvOPom0T3ID7uUtfuxhZIflELMjqY9/RJ7xYv5jPhyExP6Dr6WLDP?=
 =?us-ascii?Q?0ZxmVYmjxef2GuG6TqpagqBo7wXTQlVUhbvIA2kea8qv90C+g/QxBMzB5WLs?=
 =?us-ascii?Q?4tHJrE+YGvwIoOJisWZbploR/WbaY0WigULrJoDbZ7TSAka3/hL0EFrzTzLd?=
 =?us-ascii?Q?bDxTkhkOZ5ziwkMJhJE5ggi/YAKFVSsniALKOX2oCcBPfnDjRv8spcUoYxbf?=
 =?us-ascii?Q?buUf17M3hPaI2iOhF7joLFDXN8Ewm1ZrdPkSDP+jIbkmHO1w+YSuhnpubuAH?=
 =?us-ascii?Q?9jXqlEB3Odp9DEbk2mZHgkA/WRHHVaTYTyhtd8dYJHtpmUfIWntWg+7uEG/e?=
 =?us-ascii?Q?sGSnmkizEjKv9TzZ3ZrTVKFafWPooJ1DiwU4/nPSlYt/+H2yFQm8nczYPDT5?=
 =?us-ascii?Q?vezDd/5/OZw6m2SXwmNHYy6xgdhjgLa/I78fiqFGqt0Oeapooydnqp7fkEiZ?=
 =?us-ascii?Q?hOVFQ/H8njZh31I9ozA3jPBOdhZq9J2M6hBIxJVvVrz9kns3BlCUkqp2n7cb?=
 =?us-ascii?Q?AjUQu8enY4J7gZUptz/O7uBcHCkqGZ6kOndaJVXlOjQKmFvMEzLVcu81lEHQ?=
 =?us-ascii?Q?2p46a8OkESi/rZ/2i1h5ICBbnW0lVr2wIPO8XwmFcFE48rTsWbsZMgpbg4UI?=
 =?us-ascii?Q?rMxhaRKHtRmZUJE4NFhoi+D+dbQQdg99EYE706P8lhsvE07IM5CKlK5rwZw+?=
 =?us-ascii?Q?64iXA2fgEaNENQr8I73FUQNJQnI54wKhnL7sw6vP0M3KnmJnkf3msAIXC6B3?=
 =?us-ascii?Q?/hJ1i3E879gFE5AMVIbNPVM6aYhbM2NPJ5NLGlxGZxzqH2j8RVzSvnQtfdeT?=
 =?us-ascii?Q?VBbxDs3nd0GhNJvrF3fVBHcKwKBSxYyTAh06C+MDSe6itI/0tibRLCqO5DzM?=
 =?us-ascii?Q?QS3abETASHBQqrTFul1eB6HGuHrVycUHifB0GwF1XnMSKtzdN4SKdaD3NGvl?=
 =?us-ascii?Q?8zyqY7hOpsiZ7fs9bxlB4t/iyWd/UDCqtEtlSntTXjAXEBWRl4e0Xixjrj3d?=
 =?us-ascii?Q?SNEHfz05xqrRDe+Tyd2IhDEqUKcnA0dPJeoSLTPShuTC0S1k2V/hrcvnF9jz?=
 =?us-ascii?Q?+NtxOzVZWKQIOukFTRpH0PGB8ISHeq0LxgNlFf5qHHsyzc+95hykcENXHNe+?=
 =?us-ascii?Q?i4ItmUbkZFiWwCA/P6LWVzHP/16q/QAEvODFkOEoMulUqa64J4qQ0OqrIv19?=
 =?us-ascii?Q?g2EOHvHt7pDIGGeXsRMeERhekrDUn2ZfiNjQIBqwvqK/mL8LKOerWKXEyX9X?=
 =?us-ascii?Q?Ks9/chX0a0a3efHZ9N7kQOBxHLrJXPUbJkHb/LJW/H2Rdqg1Io/qZjWzKPT1?=
 =?us-ascii?Q?KJVyXvRi625VBSUlk2J7vwhuBT6QzhE0w81hKAVG0+C7EZr/ZqJkGwD37R3b?=
 =?us-ascii?Q?tBIjX2qZ3efNC9N0EHZrprWXluVFEE+WRqBWokZj7pDfDoy75BCaDfiDDXtm?=
 =?us-ascii?Q?zcxPbr1udahgyUixtNR+2UQFtZitdfPJnD+btL86xv/uPRJ/RjTdl3STrlVG?=
 =?us-ascii?Q?v3dbYDO4PmtZc2X1MXJU6l3Y2fWyit0KsSV2yPA795ZgA7Uh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a6f4e5-f1f2-4595-1035-08deb0e23caa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:24:46.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkfCnCCe9J5OMc30DMVLf0YoL4u5vKzmyBV2hJSri2Dzzv4L0Kj8W7Lz/Q18sJJ5z6JD9SeDXH5JT/eTL9lnag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469

scx_enable() refuses to attach a BPF scheduler when isolcpus=domain is
in effect by comparing housekeeping_cpumask(HK_TYPE_DOMAIN) against
cpu_possible_mask.

Since commit 27c3a5967f05 ("sched/isolation: Convert housekeeping
cpumasks to rcu pointers"), HK_TYPE_DOMAIN's cpumask is RCU protected
and dereferencing it requires either RCU read lock, the cpu_hotplug
write lock, or the cpuset lock; scx_enable() holds none of these, so
booting with isolcpus=domain and attaching any BPF scheduler triggers
the following lockdep splat:

  =============================
  WARNING: suspicious RCU usage
  -----------------------------
  kernel/sched/isolation.c:60 suspicious rcu_dereference_check() usage!

  1 lock held by scx_flash/281:
   #0: ffffffff8379fce0 (update_mutex){+.+.}-{4:4}, at:
       bpf_struct_ops_link_create+0x134/0x1c0

  Call Trace:
   dump_stack_lvl+0x6f/0xb0
   lockdep_rcu_suspicious.cold+0x37/0x70
   housekeeping_cpumask+0xcd/0xe0
   scx_enable.isra.0+0x17/0x120
   bpf_scx_reg+0x5e/0x80
   bpf_struct_ops_link_create+0x151/0x1c0
   __sys_bpf+0x1e4b/0x33c0
   __x64_sys_bpf+0x21/0x30
   do_syscall_64+0x117/0xf80
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

In addition, commit 03ff73510169 ("cpuset: Update HK_TYPE_DOMAIN cpumask
from cpuset") made HK_TYPE_DOMAIN include cpuset isolated partitions as
well, which means the current check also rejects BPF schedulers when a
cpuset partition is active. That contradicts the original intent of
commit 9f391f94a173 ("sched_ext: Disallow loading BPF scheduler if
isolcpus= domain isolation is in effect"), which explicitly noted that
cpuset partitions are honored through per-task cpumasks and should not
be rejected.

Switch to housekeeping_enabled(HK_TYPE_DOMAIN_BOOT), which reads only
the housekeeping flag bit (no RCU dereference) and reflects exactly the
boot-time isolcpus= configuration that the error message refers to.

Fixes: 27c3a5967f05 ("sched/isolation: Convert housekeeping cpumasks to rcu pointers")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 23f7b3f63b09b..a6d0a93d81748 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7415,8 +7415,7 @@ static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	static DEFINE_MUTEX(helper_mutex);
 	struct scx_enable_cmd cmd;
 
-	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
-			   cpu_possible_mask)) {
+	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
 		pr_err("sched_ext: Not compatible with \"isolcpus=\" domain isolation\n");
 		return -EINVAL;
 	}
-- 
2.54.0

