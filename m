Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793259323;
	b=jphnN52xvYEh1+NxPOGRJVCj18lOgktmRVeC4aOQEmFOleXOjCb68UwitJsoUEJXXktZ
	 QgudnWvIOCW1nQo9qXS7bawJ9V1D83Valk8rVOVsqOJc0pjdttlKfBMN1Wi4jXz48PBQh
	 wrzqGTmAF54fWTEFBEKAHRMSt2JRAKnKfZ5qjof0Y7+IvZt0CIgEQFL0XcmZ/9rf+mQ85
	 62rKtDCSsTWzrQNKkeL+Bdv888GB/nkApOS6bKpGdRVPpFYtyytpSaoEZXfosjQ9YoB02
	 5crpW6ddMz92NPNum2t37CxZpEseLuL7Jel+UHkDJBr7uxGrEWpl8/1afEzzftlCvpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259323;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RvFDBcBfjaQE/Mn9jGFUBcfgjjmQKzykunP7APSjZw4=;
	b=pVAWTSFKHjULH4ZlzAlieyY7f2YU4GdnC5Z4kohOfjv4R5bUSox2TZu9H6eULWTY5mPz
	 YZya/l8QaCnUph0hKiE/bsdgyYpLMvIc4/qdVy54j54anSorY8tzaKKPubCY31AEnqzVW
	 FCJSLNcrlZkx8rJ/NU0scTmtPIXAUVUlxQxbgIJbRPe29HD4N5MCN/Jhvyaebt2KknFHO
	 7zq8mXNC9n/pxp3TMlDtWnVza0RDOqp2ntq0e/W5w8Ukke8DT9PoWb7qu5TRe2Na5JuRD
	 ZLWo/wqMsDoSUO7PJjBI0Ps6IXT35sCXmBxwjN4/Jj42jYp/kHqcdB6v6CUWwpCAMkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X42reEGL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.14
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA9606A31F
	for <sched-ext@lists.linux.dev>; Thu, 29 Oct 2026 07:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39DA9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X42reEGL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2zr1UYYK73qh4ERNek3UIcISxBOhLrqTLg/M12TG63YgZaP2h+CFGEIKv+b0iJhFfazXUGTkAUGie2MRBn/Kgcu5G1HsXd0RipkukPOovUhwnmhFeNL+NFIbeeqAHZub2yaFsvhiV5lurHFO8xeX+uqvLsOvrAcObeRttKnWN0SNwgJEVZ/rysIbut8sWl98GjK9E3fs9yVVdsuek1G9rx6IU66Tm1F9q1ro9fk2IDx6OGUiWrlpL7CVcSRDJe2b/HuTORFlNfRT46qWH8sgnxOv3aRRb2kS9fc3RWJSbvXNjF5GmIA2cjd6rdq3KwoiK+karoi1hm1NPd4k7S+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvFDBcBfjaQE/Mn9jGFUBcfgjjmQKzykunP7APSjZw4=;
 b=WyHomq+Q0mVe0QCf+7RS+qAX5PgdhKwHkpKiZ1KpKDYzlyJaUuT/Gkh8IawlyHNXDOVVseUY6fEjDXmUH49r+2I8xmRtGmeJJXuNc9lec+RNfgKptuxQccGU5UzbkktsR6gChHAMu/oPMOIwON5ffTqx2BKe/x2qNsmIdxbC9uULm37Rlj2ywTfQjCPniC4L9wbbMnJJBUIvzMlkVxTsP/3yXQBs5fHO18z6079BXHieXlsXbINw5Ep2JrmkUNeXu8Ata6xdz7Yijm7Xcep6u3i5zEJ6uDWjE7XvIRtTanjfNsTncK4amBQm9C7vutA9MUIksymOX1z7OJVrFJdz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvFDBcBfjaQE/Mn9jGFUBcfgjjmQKzykunP7APSjZw4=;
 b=X42reEGLZnM6xW99EOpNeMN5Fr+U9MMs8cgL1j3B/UiCyjhibsT+b9Fd4m6Y34GxUrATSiEN0EtrcKrLWHJhNwvshIt8h59sEeywjKmTK0/wxTGFVbnSFairk+1cTmdqzd/UiBo3j8Gd8Bx+K450fhJqxu2mxDdAWEdnRRF6sZeMcAOuMscjjjSOuIpB/c4jBgltbZbYkdkjSkHp1nyLqPklAQik5q/sZVKyeq+olb0fM5iiYiHkXHHUEfpGzHTmMtZr0Y8kd6nfSWP7+Zs0XVU8ugIl0w7qaER+xcZCjntz1Io9gwqiFI2VSZyVZ6ipI/rbErJkY1Q7MpV9uJtZZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 07:35:18 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 07:35:18 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Avoid unnecessary IMMED reenqueues on idle CPUs
Date: Thu, 29 Oct 2026 08:35:08 +0100
Message-ID: <20261029073508.3901589-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0059.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::10) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcf05eb-4f0a-4724-9942-08df358f2df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r8srFqjiFLDTYqdRL0Mkpl5i1Vh9AiTbyVTdg78K4d+V52u8mISKM5rnZEaawAxEV4hCRVvCtH7/iEtx1cOb142P9WZmTNn7q9uNhHARUWc1NUg1++bSnWmqZkLG6lTXzfuD2DA/5LzIupVLxuVVwSjl6pVS1GFZpUAemh5hzvNjIsSJbD4itVC+p+CpnhnzxPqhaDZ4C18ODnw2t2Uv5w0GW+ihl6UJRJvbvoZekBGKcXlyCiZDWZhGi0Yc71vV6eAKfMybh0+wgpOCnpjDkLb+niYcDTIyRXFxSbIunsG6PUN5oPDtLEC7Bu9SKQ5MaKIquCmGICYsFrP2YZTizxrGWDZMid46i9AfChYsnPmgdJXBPGOhhbC4NKTZ8QPpKWjlqKp9f+yBalWDRPvgAR86kUXAemFqaKI2GRbmtmStNKoI2nf2ZpPVJ0hq3X2sk4l7orJXf8rASj/t8uHSL7rXyeRO9xlP9sG2RaPHNq+9G2GCZx4tuLDZdZQvT/9zfjjfLf/NuYOTACOruRG7Ip635rEbeGXoy7cmpW4zwhL+R4JPws9l4o1H2ruMBl4fiMSkhDw3hdd2gxnHG8RyzvSOK1Tgry6aDZIHRcrfDh34VKHJYLMfehJtJtvNZfR/fsnjLhou6Gwi5/AZsmooiR3Jih7OMqXOXGd14+s3FxY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fhfGQFn39KvIsV7SPhViEJPpvcVzbum0lr0C+gCuH5/y374U7nxBuVDVQXjW?=
 =?us-ascii?Q?PK2nHb/+Oiu1Dp2WY6h/7f9fji+0QtLcCYcvyKrsKnmw8IO3IWwPqZTWwmBL?=
 =?us-ascii?Q?f7IZo2KkwOaBGlsf/rPs8QZZkLb2UyV7FkNKoSK+6ITSQUZTsGw90isXnLcA?=
 =?us-ascii?Q?0UsGGdk6/hlp0yWNvh69u4CA+ty6seGF1ndBeIsf71b7KIQl9zX9mnQpeF+O?=
 =?us-ascii?Q?AS+GjOuLoQyetVaKKGWqodFVP/I6AgOGAa/AiAO+SH0MyNUL+VNZbex0OQJc?=
 =?us-ascii?Q?+dDfo6o+PPxjYBbsOfHOkcPmrKi16eVQpBCVRt0HWzjSRVucQMc7v2ETUYGQ?=
 =?us-ascii?Q?eakTL/2IVbnmqKC+wS0SoAy/L30F073IQX143zS6M0hIl2Y0bhzyySFV5aVa?=
 =?us-ascii?Q?nQOW3HPJpyCd8nf4l+TPLv4r+ivvJWGaMzRQTOwf8fGEG3Zp1K8yeCa7AXYi?=
 =?us-ascii?Q?uvjo6cK6Hr7scuH73IPHNeg9ARcHnAUUPNiWofEAaTMXa9flA9g1JxKbEo9A?=
 =?us-ascii?Q?+MU6y2Kj6uL//6tBRPtK+mwqopeUSEVYKwvxGHl5h4V1YrjLNwtbFg0am68i?=
 =?us-ascii?Q?tZ4sifi+kD3iuvRSTSoJOrCnlmRrrk8hXMagVzzTUEZi9fdd4VTgqKukUaCI?=
 =?us-ascii?Q?WgNcmEVlDm4Zcs+XM+9F9xJyqhcg7SAknf3AY/o5fN0UtI5bD9LHHu+ZuNfN?=
 =?us-ascii?Q?1qYvRh/d8+fIOgQ+lXCIfwqQJCUlZTW5UKlD1B2QB079jZCs5q3EijHaBylP?=
 =?us-ascii?Q?xbm6SI6CAHpjnlOowMtkmMVoa/9UiuxnRNsopzvqxCdRg/hz8464J2bnyiL1?=
 =?us-ascii?Q?w5nd4oOSxQ8AnOXQi25f79HBYOR/zXw4HHvyknr5TRKLOQF/AzTSL+TYyfyR?=
 =?us-ascii?Q?z6VN4ERYxW2wG1eUJjL52CudQlGItYAH8yEUTvtqHa1aez2uC2wkz+BgDPjN?=
 =?us-ascii?Q?9CSlwCqKXwYx1m2SXrkdYTUurwF7y1TkoQN+X0kN2b9ZfP0bja+KCxbaS8BD?=
 =?us-ascii?Q?QZvSOClTgWbeg7Oy97reKO0jXAfIhEZGivm7XDx0eT55Mu/eV51qb8IemMBB?=
 =?us-ascii?Q?+KwWZSZxfbHO/yTt50JAL9hMZXyzDqXxKkrvzaUGWybs/jRGWNouxOHnp9rD?=
 =?us-ascii?Q?zY0g8o+QM6Sng4QhLubEyuSIbA/MLcK/k48ZF0hS9VL40bJvAlb+m5a5+hT1?=
 =?us-ascii?Q?398D+xxa9ogh8ag1v1oxowYY9nmjx/VYEBcr8xYAicley0fHlN3cLGBhoulM?=
 =?us-ascii?Q?WZTelWL2xjZCszliqJENDUdPY1sLu8XflDdRa1QViS5nqxwY8468Jf8R1+/x?=
 =?us-ascii?Q?j1BlvA871Z65FWmeYXLYaTrl2pKDWFQLH/wCMrQ5hALgzaXCa5tXJ/r0RjOf?=
 =?us-ascii?Q?GsmYcmOLaTl6O5kS8BhTYru85RDsu+5+GGfrU59g37D5q6F9C3a807gd633I?=
 =?us-ascii?Q?jTTrfZfZQSZgBcqiFfY58PiQX8/3Vywklb3vxG1EbdWqNBGEfKcNRe6PElfk?=
 =?us-ascii?Q?BjgNIRqEodLNs95rgYxcvl1PZ252KZJQGAP5rwxT55RH6xrZvsTJZx+Zno78?=
 =?us-ascii?Q?G5gR0IHieBwgqACPc107mlfFWRiFjbOJPbkpVLM/7H+fdOtX9q4lfBP5qVAL?=
 =?us-ascii?Q?ZH8bSdgPWTCS8HN/azEYTaWCCBQjGiajINKc9a2e+5ARxRmJJ2MaEifj0phl?=
 =?us-ascii?Q?Djg1w22k2xiv+r/Kk9TsUJYlW9I2v39tmBFYwjj3pgkzRuYy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcf05eb-4f0a-4724-9942-08df358f2df0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:35:17.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DE4sx3MuY1hO8TVs23LG6O9r2ft+T/2h1RPEjmv7YTmWbKOJ26W9lvb8y43ocJp3L6eiY33CapLvS0W86c2Elg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

When two IMMED tasks wake on an idle CPU, the kernel can unnecessarily
send both back to BPF instead of keeping the first task ready to run.

The first wakeup inserts a task into the local DSQ and raises
rq->next_class to ext before the CPU leaves idle. The second insertion
queues a reenqueue scan. rq_is_open() sees next_class == ext and reports
the CPU unavailable, although it is still idle. The scan then reenqueues
the head along with the task behind it, losing a placement that could
have been honored on the next pick.

Report the rq as open while the CPU is idle, even if a local insertion
has already raised next_class to ext. This keeps the local DSQ head
through the reenqueue scan while IMMED tasks behind it are returned to
BPF.

A local reproducer runs in a four-vCPU virtme-ng guest: two futex
waiters pinned to CPU 0 are woken together from CPU 2, and the BPF
scheduler inserts their wakeups into the local DSQ with SCX_ENQ_IMMED.
Across 10000 pairs, kernel instrumentation counts 9776 unnecessary head
reenqueues while the CPU is idle and next_class is ext. Keeping the idle
CPU open eliminates these head reenqueues.

Fixes: 98d709cba319 ("sched_ext: Implement SCX_ENQ_IMMED")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/1548cc9309a6e0894e358262e0b3d4ee@kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
- Remove the core-scheduling cookie check (Tejun Heo).
- Remove the independent skipped-head bookkeeping fix (Tejun Heo).
- Link to v1:
  https://lore.kernel.org/r/20261028165258.3723153-1-arighi@nvidia.com

 kernel/sched/ext/ext.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1b098728676f3..8862e81b63157 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -461,6 +461,14 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 	 * @rq is either picking, in transition to, or running an SCX task.
 	 */
 
+	/*
+	 * A local insertion can raise next_class to ext while the donor is
+	 * still idle. Keep the rq open so that the local DSQ head is not
+	 * unnecessarily reenqueued before the CPU can pick it.
+	 */
+	if (rq->donor == rq->idle)
+		return true;
+
 	/*
 	 * If we're in the dispatch path holding rq lock, $donor may or may not
 	 * be ready depending on whether the on-going dispatch decides to extend
-- 
2.56.0

