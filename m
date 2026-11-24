Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795503632;
	b=5Ma+saYpAdHP+omdecuE2h7GBxxiOY+LrlFWy1E4Wm5+a+YvTrmyyp5cjEYPDoBxWoE3
	 tHVHAdV9ilKlKN/oU+DYAf/kkGhOgubYIsZxthGjcToeCO8SxrGU+j33Yd2TvvpOcP7vw
	 OKS2JqLZSnPKwExMjvMIQZwL0fuGOqy0xlOMQSSkdMvxWgJ4N+I0rjehLvCyRK0+lEGxS
	 zh7Vv3yUSrZX+ekMMI/bkIlpCgUR6aFCbIcbNMMDJ/1BPcCuIF70U7jBrb5LocHkO/oL7
	 35mf7RgypjxVVwZdHk3Kaw4lX92xcT/4kzkj5bkeoiAMbR44TOe0et3MxdnnQC58FeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503632;
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
	bh=OK8dpi252IPkfh9VsPtEH4UrDTMMf1Y9fXdXlohCeBw=;
	b=aCDlTOu/Cq+SFN5auIRwcICj7JyY3z9DmSAfXwvGnAzdBgIy/XTrUS0B+jeLMdNl+isz
	 Lx8U2e+cAsbNwa/wyhStMJFQKURKehmrGnp8zEwOyxziOmuGKs2eU0y+yBMbXv0QiJNND
	 qE6p+UxCC6POOx3ePNAPkEWP3SSfmQ71rZq027h7ZA7QMevT0LIQk4IU0h3moBVvqVWnx
	 n6gVK2HYcFpXa13O0Qzfo8kKVTFUy7Blb6mtLsJoRX+vYBr5T42cqkmnCixtekMpKLiOl
	 D15drB2FAKAaJYuCv1wzP81c0kBPTPxN6J+PYY3K/w7qgSpU42PrYzWHHLSXXqljxIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Zge9+92Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.38
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF647606A322
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 07:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF647606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Zge9+92Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7L6Soso2XwkbnMowA+24c3YArnKDDGjr/6xWrUBop18x4Jknt9MxwWUaEIVK15Xdbkm2sXdqDMRnlzfJv4uJc1ol4V0AFmm9cG+Ww11WnsLC/QfwIVmtCGJKAplsTqHYc+pP4RUIL3nMSaX3ufZzmrK364CaAmhqgA2/LFSfhfMO735oUJ2z1vuPnz3cHpFfFYJx52SIZQpmNpFTGeFFHjlq45IFfP8VtPgYXBM4QFG9Wfie0N6Eyd8AfHvVoud2j9A8kZerbhZIlzREbOy8+s/VgeGlLxPvee2s8+kh1tJAHzJ9IwMXaRzyXPRPczxPbd8r2ul4AP0Ckl2g7y5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK8dpi252IPkfh9VsPtEH4UrDTMMf1Y9fXdXlohCeBw=;
 b=G87jrAP+gupVJyHx8InUePsuEbIS7iT1tUyCqTCIiGUeQOhOgXOLi03SXw6YdKo7rGB2pZTC/zQCuswjd60FMJpYSpcanMvOXnb6gFOKgHhrCgHJ9cF+wt766gchOJuY0SJpbXPGEzUQX/9ZFSYMmQxiqfs5XRm+4wGIpQi6NKdEAd9U0wC3GxeDBmKF4wlLh7BP0I9oV+dse8h3SjRCjMXAzWV0qAIaZuTqk7kac30mNecD5+YbMKmaHPqvQo/ROF0GgYikGOgiaAh9HVynRW4dwoYxkI3oLm1FBZZqDPw48LsiF1x3UscdByvqRkH57p0dQ6E1nJxkRZuBKxm+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK8dpi252IPkfh9VsPtEH4UrDTMMf1Y9fXdXlohCeBw=;
 b=Zge9+92QkLgtPh0fjiruB7niTk06D19613gP3o6sUOKmG5XEZWsGvi6hm+aPqH4DPM4Vkg5KNGh5Z+S6xh0viq9e0fnFDR/2R5DUF738SaOHs99ZPBppoXLia4o3P4UjkZ/f5rfP8TL3NRz0nlWp+N7En+EZnWXSiujAFYTVB+iSSpWDlU0Hphgtenwpeb9w8tw+j7ZVrBOlRpiA2H8+xcnMom/6I8hMGMh8zAkVS34Guq6qAegjJBxAjzdalmMSTvBTw2Octr5po+VKyf8/LcUSYwijrw2DvUiKXHytprzarR4Yg6VgYzhsQt3zou+Io4co4XPzXE+YJHGSnddEmQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by LY0PR12MB782425.namprd12.prod.outlook.com (2603:10b6:404:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 07:00:28 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:00:28 +0000
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
Subject: [PATCH 3/3] sched/numa: Only pick a fair task as a swap partner
Date: Tue, 24 Nov 2026 07:59:09 +0100
Message-ID: <20261124070011.2498455-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124070011.2498455-1-arighi@nvidia.com>
References: <20261124070011.2498455-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00007549.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d2) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c1786394-68d1-4d39-af95-08df49f89f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|18002099003|3023799007|56012099006|261028144727099003|11063799006|261021121427099003|261026140227099003|261026121527099003|261102123227099003|261021123027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Gr4tgkuOAhUirytIp7gvTwloqJseHilmqzLxW46Moceh2v+6vpR/shs6+dVs+0WVlXlG+8lR+iii+JPlM1nRefxJXoFOtCqSDC+ODn2hLaT1Chj33sQZ9WtFNAwDIgjkceIn8HYz9smflM8WUI22cKSHCmRUOiLL1HPa2boPIqykJ8wAYRlKNw0uSzyXCL+09/98hZCnveEx1wx0t5PKUhtv6CXYBLtTUzLnulE30SjGm7uuwpNCUz8Om0cM9OerIdPHu7MAfaurC5nJKbhOtJ6K2w4yfPa/8K52HBkDgKFgXZ/kq5JeZtOwqvfZ+fihqcbBB61qp1K18pulBYbiiJZn/cWJLS40hzU77WiTVMloklGu6c95p30NZjnWEOEd3lZcMN8pAzQfmSjHnFyAtnu60o6KkNq2RztGGBkBv1SANILD9LIV2IoIQr5ZO8lBIpX7rUyYQbEgBha/koMXdVya4VMW6EoT5fGXVXXYLo7cOXrv6AfRbZIXlaeLtOhaVYX4XPrW0AuMOltF1OkqgWwrm4k2vt/RmEIQ1i/9OS2IJA/fO+IWq9m9XJFqAkZw0EXExcLP9WUPhS44dzCkFDKTKt+JCePFAJeIo/WMYlAwNoRpcdDlseH/LSau2VY91lfoVTAqEwMkyPU5ZCIcdiISdqfy13JofxqF8xFaDcc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(261028144727099003)(11063799006)(261021121427099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6nBJrRCrAoql/qUuaa1YUOieAoW0Ar14xDOWKSKziu0FfWUTM3URLvaYn5v?=
 =?us-ascii?Q?CtLPw+nphxCFZyuJ/iYImZIjfi/wr5zEx8MBruXHhsihGqKHFFbtWb4MOu55?=
 =?us-ascii?Q?c9EdaoxM5EXWyWgCrG2b99oHksZQ6Npgue9tKTSmU7IsIhnMoXERGS0Sbl6z?=
 =?us-ascii?Q?p29x+teqdWt7QonkpQBW6Gd5dHh7Dy/uoO8DX8kibshHZp+Tz2dZolJ3lNAK?=
 =?us-ascii?Q?GiLnsQaogQiFkKWHAg+NshNUpuPkryOdrWRmFROtjnFNe4Zy5Jx3XjS5UC32?=
 =?us-ascii?Q?HqJpdBT1VTIHt3pFmW1kcLr0tsmJLdfj0sVjnqtduyGuvBmdNy6SWUuu5jsu?=
 =?us-ascii?Q?LfjNL7auvQWs+LQC68lcYy6IAR3bjsaTHSyYnW7AT3laJDdFIm0nTAQXa249?=
 =?us-ascii?Q?2vz5iEj8IONFgT2i/9TJ9rxIygZQBBZG7GxYL//F3FV/5YIngGM1pVT+p7dQ?=
 =?us-ascii?Q?WctpOWaP0JHWnhSXKv+sI+d6kxa4tPie4/0ImSQV4Uv/MF1YgqYM81wm7vVq?=
 =?us-ascii?Q?FLfAGq74D66d7YW+676HCC+A0Bhz4/HNxOYSAvCRW/5WkpF0bC9LrhO5sm0b?=
 =?us-ascii?Q?G0fxrzOFiJ61id/vfFVLmE8zTJw8wyO6YfoGtrRsUrEFUxQLtzhH6qHg8mms?=
 =?us-ascii?Q?E1d/5c5JewiQNbz338Pn3MzT972bUsE9tgPBysYrCVii0aJCE5wi6I0TUjux?=
 =?us-ascii?Q?AGauKYpYOTeDHGIQdGD0q0B1YAIHkCBq9YH8pmjL8ZUq63iCMxPcp0fhP7ed?=
 =?us-ascii?Q?xP7QjPqj8VtjBBFirgBO6NJZkdr/KFGbH3ZKUuCkiawQsm9/H8/HsW+9uthx?=
 =?us-ascii?Q?w7XYgpmitNKTejRWLveFQN2+t7c7d+Zn7ngun+o5u3fPuQGungE7Y2mmWZ1U?=
 =?us-ascii?Q?pu/6lzY7R5e++P0y4DDfoDs9cNuhHuyMyPUMy+ePDXDc6YYTwxvyeIq7hxJA?=
 =?us-ascii?Q?eXjUd9w9JGqJVg1qgD6iRWMD7QZEyGqSZILrjdfYUxMu2G6lfLZxF/KKLOsw?=
 =?us-ascii?Q?gPHjYQ7cK0MvT3N0B0470OJBzQhqz0tCNUInLMJYez/riSBXukpeMZ3tm9Ps?=
 =?us-ascii?Q?+a8XYeRzyGH4SbbgEVNSJGuq0W4XSPEeR4HdL9na5ggA+Se0DAAXwCXZmP5d?=
 =?us-ascii?Q?hyPYrFAi0FFIxmGVaxovtW2KDuHHHYVNlAAOCWz4ESZjRl0COiXHY/5MUlEs?=
 =?us-ascii?Q?3Mdl5x7HlJXmRnpnZwaKhFK1uxQILqQseBsReXiTCoYxJknWjqn1jGf80Xjv?=
 =?us-ascii?Q?PE3U1p/1HkeevLE3XS7OdTp66NmV8jFQIPyG83/irKPg8kYiXT7gOjd8buqI?=
 =?us-ascii?Q?sd/n4GrH3+aZlaXqExspdW5lXoH+rA9X4dyhjbw+6gjVcaAOwJ7s7eAamv2x?=
 =?us-ascii?Q?q+ZI6YIA9NjG6+hR/GrIS6TqI9HSTTAalPAGoeprK4AAMnTHsvqkDh8tAzRX?=
 =?us-ascii?Q?UwSxAWQH7euevm70eYJCI9IcXpmJ6SleNHQCSq2YcAXgCHZKRXfwAarFFecY?=
 =?us-ascii?Q?blznvm8ynhJgMoS7nS1dqkJlEDrJKFT7dDcnr4OgjwfBaUG/GBj00iUif5bg?=
 =?us-ascii?Q?LuGKkI9c/xf70rUX6Tj7dvrywKOnd0HlqgE16btKNmt+nTg/zTZMjgBQBayy?=
 =?us-ascii?Q?47nn4OVGG6asnrn7T+IDwxeI0aV/dmZfXRNUPYN6CECBHGIPLnoaNfH/c1vH?=
 =?us-ascii?Q?S8Z1D1GEKUM1YTulCs6kuJg8pG7zGPFQiiUob5mBvLeHLNRg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1786394-68d1-4d39-af95-08df49f89f57
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:00:28.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XblkaVxKFWzjmbmvIIELK9khp6I/fT3uFRRLn2gP3k+kD4MJQcP6xFdHzwC/bU0cdSrje9PEKOn7DQEoX6pRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB782425

When NUMA balancing migrates a fair task, task_numa_compare() considers
the task currently running on the destination CPU as a swap partner and,
if it picks it, migrate_swap() moves that task to the source CPU.

The task running on the destination CPU may belong to a different
scheduling class: an RT or deadline task, or, with sched_ext in partial
mode, a task owned by a BPF scheduler. Moving such a task is wrong for
two reasons:

 - its placement is driven by its own class (push/pull for RT and
   deadline, the BPF scheduler for sched_ext), which fair would override;

 - the swap is weighed on task_h_load(cur), but the load average of a
   task outside the fair class isn't updated, so the decision is based on
   whatever load the task had when it left fair.

Treat a task outside the fair class like a kthread: never swap it, but
still allow the migrating task to move to the destination CPU alone.

Fixes: fb13c7ee0ed3 ("sched/numa: Use a system-wide search to find swap/migration candidates")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reported-by: Vladimir Vdovin <deliran@verdict.gg>
Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5f420141c3026..fa0cfd48a133f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3223,8 +3223,14 @@ static bool task_numa_compare(struct task_numa_env *env,
 
 	rcu_read_lock();
 	cur = rcu_dereference_all(dst_rq->curr);
+	/*
+	 * Only swap with a fair task: the placement of a task in any other
+	 * class is driven by that class, and its load, which the swap is
+	 * weighed on, isn't tracked by fair. Moving the task alone to the
+	 * destination is still allowed.
+	 */
 	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
-		    !cur->mm))
+		    !cur->mm || cur->sched_class != &fair_sched_class))
 		cur = NULL;
 
 	/*
-- 
2.56.1

