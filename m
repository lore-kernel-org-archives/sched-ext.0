Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795503628;
	b=iXf7vkKAoSq1Png/z+HyovSvRL1DPD5Rg77GMtThnfjadg3//U53gAMH7XsigWlP44BG
	 g1vzMK+Z22a5SNhZqMBhUY8zWuDETjub6qQC9Va3ZF9Tp1zO+9Fw+KD+1FREJFdDiLJrW
	 8GK+bSwS2Sckw32ZTACmZj9sJ9V24rRMgzeuv40heD+/7uLx/zJ4JZNaHTjxR9Zp4db6V
	 ilDDWYrBqeYM16Kpx3cCiRdmXrxfWoxw8+hacwabYd6PJO0LrIDIVEhCtsRF/49rlWmxs
	 W6RyEkLAiMMj0sG9PVbqgA9XPhFz4WOHb/JX+7iEjRwEWcF75KYd0qBnVdV9sjGJfqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503628;
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
	bh=2vCaUItWIxZEPUIM1Zs4Kd2jsIS4JTibkW61Kh+LCPA=;
	b=NV7xm4eTx4qffdxMFuHF3CfAVd8LMRUHIFvuvTDbl10vm/DxSh6GhaZt675YniyEB+tL
	 4dQHFGcAYwWzF90sbntrh1Fa9W9ivLPdOlaZgG59y7CJphWC6oT1f8xrnDiUo+5vtv8Lj
	 sM50vXMOBykdF5FR72XQfkCUoEYvi21yI2NcehR0wrjR9GXoL+lBtC/I0FvDGLwRSOTbG
	 RLBYFLe/wVRCVLsNKZVuo4iORHVHKfoxDYIfHWNDoPkk4ys5HLv5ZTcgRwwlwDUWlOzJl
	 kqnw31c0k5+FjpKXJGisj/lYYXw6qHHw1lQCpV3JCwdPghCySeGFwzDpa19dQ9hhLFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q7qPrY9x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.24
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B3F606A31E
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 07:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74B3F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q7qPrY9x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBF+WvUbH6xYCmQoyll0k2B3P/RbSBBIo3OEv23BEQZaQ+ey6ZYg3ypCZlkVlhQJm4Pj5wvWyyJ4jeDdtB8zyeBOvH+rrO3fmUnCzMAU4xy+n2n5u5C6YJFK/O/PCZrz7337bBrZmdOGG/QCje+WObMkqimdZLVYoIQ9rWP+AtztpgMMMVkfToMFFWmYmY+64/ioWbVx9p4Iv5/P/xaaqOrftPPsFAB38g72m0IbL1wsOBCzgQg6TLsk52y5R5unQBctDYpWGyuJe7TtPCkxy2HZaShyeOCMz42POkrD24iPx5+B13fQcJVQ/20ybOMxCPwV4vshlXm5LpLJTqB+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vCaUItWIxZEPUIM1Zs4Kd2jsIS4JTibkW61Kh+LCPA=;
 b=uhWTnwXVzQ7eaCjYJCnXJSMdRf5OWacZI0DRGxct6XuCW1eEI35DLxB+X6lUaH0pVVc0OJK45NGCvrOrZY7RUGy6UXXLMVc1ioeGmD/yu+sIDWUj4xJFwHGucrOh35UD/zn9WHJZTHIhL4rux1LxmBu25zWYovYdFuWCcQcurlBOfTppnEDOXFYi0pr4mnCjGdFBpuSWNw74mPhakUFSbNdcXxStCXZwm1EYlEUDVvXqOVvH2A5XaBeArg+vOuqfL7u0PnlyXBKAxGoJ26bLmVW01yHhqI4dHRfWCxOxdQfU2JASo54/V40i2HrX2lGrLSj9iWTwqyBPL2a0WNHM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vCaUItWIxZEPUIM1Zs4Kd2jsIS4JTibkW61Kh+LCPA=;
 b=q7qPrY9xvAtTapzfPavr+QP8mcZiM1E+NYgUt8JK5jxa0hCwkxlfbF9pFmo94RJK3+evyj978RgjIdt4Y9aUuNrHIKIbf3CqxHt1BYBec1VsQsqzQ17zXncQc/WbVHUewNuxKhflxvzr0jUl6bUa09Pe9qMXe7VoqMp+mRKoRcx28gV05KNI1yjhIC4u8KepRkscupgiBCke1v9ZkU07fbiP6O0kTXB5svYGzaCjcbq1IYT9btxVrIJLZHW0e8KsqfHcPI/b5V+v2BGcqIYeppmyCYi+5Q4CpOjJiQf5fecIMGlTMJpQTlCpDPbDnMakHp+qKfTYG0urm9Syi3tbwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by LY0PR12MB782425.namprd12.prod.outlook.com (2603:10b6:404:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 07:00:24 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:00:24 +0000
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
Subject: [PATCH 2/3] sched/numa: Don't migrate memory on stale placement state
Date: Tue, 24 Nov 2026 07:59:08 +0100
Message-ID: <20261124070011.2498455-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124070011.2498455-1-arighi@nvidia.com>
References: <20261124070011.2498455-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF00000AE4.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4b2) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 2c8bb840-1bcb-4e2c-3ec9-08df49f89d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|18002099003|261009223027099003|56012099006|261028144727099003|11063799006|261021121427099003|261026140227099003|261026121527099003|261102123227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+1bQ3lXIfPgw6+NXsJmmVqd0tXHnMsuPjyJEvTbMNx3k72u3MtzMuNBaR9zIDRchRHWOVNTSc2REl3wX5uAeYu41+hrucZPutejLweMHeo9g0IVDrpmFxPQafsfkzn6O4WzBby3L5WxQtrSllWvQ44hVunSvych/4uSJWAebPVqDDdm7PeBu2JRlqUYsABcqqHs0ISVkoXoxEkYiQSu7pvD1iyMHzYkf+PuAbLbLeABjXikw5RF5DJn1tI4IFXtwBVsXQ4nF6ODhZcuNfLlYs8AulWxrYMCgoqLaL/4HtV0Up/hlDuBlSRGhqIJamQwgbtK80mqBtR6oaanGE41IGXDGFcC9EsVUYvBHBojRtpKlkiOG4YHa0Iw/s/sQUrm5POx+I7V8rNaWz7yq8MTqWpx1JiR5Q7m68daw+7gvxWsm20MZShBJnykGA6jSd1ueXLrdJGdNxoA20RK62cUaM5F4jYVj6yiVPjLnDUNtqQAT/T93Ycy/jhiuCo3ZLo7/2VTKKlr2zIi4uPCtSVt74oK3wSLvWPXl/EDfWX64g1BdVEY2l5SsKhPx9yk/h8XPXPNMuK4uedW7dLBAkrFAuTddYS4Dbq2WShLDKivw23PFxOR5mPGp3z/ubXhURWWhjMKCT5ib/Vq+ov+0XUoPHLrFCeHWsIbBZtndXsgjM8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(261009223027099003)(56012099006)(261028144727099003)(11063799006)(261021121427099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YWyJ1E+Y8/nP7rZ02GBvvpig6rEXOwFvu6BbJig7wE856OWxc4kF8BbMdpTV?=
 =?us-ascii?Q?5pdLK9Q/kYmFi3MaXaNRj+JTjiEQLHB+n5LL9mUJM83ZHyT2UNppdnMHuOHB?=
 =?us-ascii?Q?92x6n+eXveXOB1FlqFlAYYk1kqrPw3dquVZ8fnpw9H+G8gFM7QeoLnmS3RAo?=
 =?us-ascii?Q?se/c8bGWOp7+HOaWfVV6soRtzCrbCMuapV/po8/3dakEaI2LtTGrKOSO6AA2?=
 =?us-ascii?Q?9DfpS4iwUnDhTmSMA0RNan8/AtWEmsKrriFMh2DQwbAIGmPwiOqFAslH6cXk?=
 =?us-ascii?Q?wBmvUhIKeTXJK2M3dPrCagEURNwI+R5dipVOQMKRHR8vZYBqGsDdxCnBD5Yt?=
 =?us-ascii?Q?/xgxng+2AFBwvoXqXvVqmAloE0IvAw1QHfgO7BvnCHaaYARmnSiin7RMsMpq?=
 =?us-ascii?Q?vj7ewfVpW6SNpP4g6bBr0s+RftsT38liWztzMPILBq8rvySFbPVmywF+gF/N?=
 =?us-ascii?Q?rkd2migrHxuHV6KgNAGDmcUPHcG3ppXDcBEVB9KX//fB/s4WkSy6A9dXU3B2?=
 =?us-ascii?Q?emkivEoIPVWvL8s+3E/Ex7Hnm/Q+nN8/H0ZbKo8ZF+vn680BjrKxiajGVqja?=
 =?us-ascii?Q?gLiWfoxMFR9syH7bydv5aIVNpQedKKa5jm96OuYzCkQxSk8gW0xnY/xeE2iO?=
 =?us-ascii?Q?86lBFrbTDL5OpXdUFBUzmtZkNndEgN+HXx2lBOJ8bUGpodhRmQS6k2A0/3eq?=
 =?us-ascii?Q?a6yRXVYmvTHZrZekvo5L9vCBGe0W/XXoc4DzNKKDnQGIm/GFp2mAzpo3efc4?=
 =?us-ascii?Q?POvfblMDje5+BRHxM1Moof09Cjdad+qxouBzGBFsD8/i2ZW7nG4e8hz/TdJk?=
 =?us-ascii?Q?GoS6o+iyt/bQW+CxIsvp6bo+Yt7iRiEs87O+mriUr9XXXCfcDw+K0P7byMhJ?=
 =?us-ascii?Q?UFuPue++I6uHGwYmpJw+UYRojw0Dlz1TWrld07LaRpd6c8gJ+Y5S36Y8WR6p?=
 =?us-ascii?Q?uyroR2PpDOr0XHk69GFu/bL3tV7pfetz6HV8HXrBVM31rOCfvjo4SDfUPIBu?=
 =?us-ascii?Q?2J7g2JW4a6T7uVjEQTzjK3G19eNRGV6mXmGcnsD655OyKMcYthqv75ezORGQ?=
 =?us-ascii?Q?teJ2tuL3hXQQnlDbuQCMvuQYLXuTfDcH9AVvoVkFVtupULzgEEcQfNQ+2lP8?=
 =?us-ascii?Q?bpftcU37rm/ZGYXU7Tlk5IIEPaNc/wTZdfHz6A/BCAfaXDlzyVokD/P6OxEM?=
 =?us-ascii?Q?Wt8R6O63rdCyOyVV6gMFoiGyXbXoAK4xXRZPWxrVhmvzyzcajoFZtKjVX50Y?=
 =?us-ascii?Q?0UfFuPykC3SovIN5cIFwmcRLvUkeSflC0mn8Cbteqd/7Pjk+WJJyXp6STYTq?=
 =?us-ascii?Q?wfYOW24zpv/4hIfQ8rwPSo8EwCX9gwtlzLp3cIeqxmG8/cKdRDUXigac0mkv?=
 =?us-ascii?Q?twB8HaH1Sirc8Lpva8R6yRYmWJNdGA/hNVHridNBElAgMpuV0qKKYLrHawrE?=
 =?us-ascii?Q?OjdGhjpO7fHthARvSINo8YX93D6kpwObnof2XcNa1JtdF5oeol7af85f52xJ?=
 =?us-ascii?Q?SJvO7a/qyiC0mvNIvfk063uIofIu9E9jdcvUD2ulwNyaT++6ibRESzdvLdGx?=
 =?us-ascii?Q?EhDg53kSeE8fSc3twiTNdCnbRjjKqyH4qdyJU2NADsXHLN2aypVAMYJ15Wms?=
 =?us-ascii?Q?yCcYNIl36Ytmrrl5YA9kBcVEUWMW8mb0CpWM0aJX3pCxr5IcYqFSPO8V5AvR?=
 =?us-ascii?Q?a5ozQXbxbI+HI7TrWPe9iFsziPTzaxMzwiW0dqPhOoiTAyHn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8bb840-1bcb-4e2c-3ec9-08df49f89d24
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:00:24.8075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6t2fIsRqj10jpTA0gokvQNXmCxnvrkuT6Nojrvu14mh2MQ0O/xWFACcll46yuLVQlVFSU3GrmOhKZHvKETIFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB782425

When NUMA balancing is disabled or NUMA_BALANCING_NORMAL is cleared at
runtime, the memory side of NUMA balancing doesn't stop right away:

 - PTEs and PMDs armed for hinting faults before the change can fault
   much later, and should_numa_migrate_memory() then migrates the folio
   based on the last cpupid, the numa_group statistics and
   p->numa_preferred_nid, as if NUMA_BALANCING_NORMAL was still set.

 - A task_numa_work() queued before NUMA balancing is disabled still
   runs a full scan pass, arming the folios on the slower memory tiers
   for hinting faults.

In should_numa_migrate_memory(), keep the promotion of folios from the
slower tiers, which only depends on the memory tiering mode and the
fault latency, and only migrate the other folios with
NUMA_BALANCING_NORMAL set, so that a leftover hinting fault just
restores the mapping. This covers a disabled NUMA balancing as well,
since the mode is 0 then.

Skip the scan in task_numa_work() when sched_numa_balancing is disabled,
after re-arming the work, so it can be queued again when NUMA balancing
is re-enabled. The memory tiering mode alone still needs the scan to
promote folios, so it is not affected.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/fair.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46d3c927b8b58..5f420141c3026 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2910,6 +2910,15 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 		return !numa_promotion_rate_limit(pgdat, rate_limit, nr);
 	}
 
+	/*
+	 * Past this point the folio is migrated based on the task placement
+	 * state, which only NUMA_BALANCING_NORMAL does. If it was cleared,
+	 * or NUMA balancing disabled, since this hinting fault was armed, just
+	 * restore the mapping.
+	 */
+	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL))
+		return false;
+
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = folio_xchg_last_cpupid(folio, this_cpupid);
 
@@ -4313,6 +4322,13 @@ static void task_numa_work(struct callback_head *work)
 	if (p->flags & PF_EXITING)
 		return;
 
+	/*
+	 * NUMA balancing may have been disabled after this work was queued,
+	 * don't arm new hinting faults.
+	 */
+	if (!static_branch_likely(&sched_numa_balancing))
+		return;
+
 	/*
 	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
 	 * no page can be migrated.
-- 
2.56.1

