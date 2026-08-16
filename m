Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44C3B42FF
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901929; cv=fail; b=BRGVuqgRsThoc6RaIQHxiMEB0Di8+zC+L9wyWHxGYwiMZlmdy9SJPB6FpUNMwmybvIaOGJB7q3QzekYSBGJy7i/TQjLD0PYA7OqL6wAn6j7vgQRqjy30fC7vy28iKh9yBKCJRsORHv5TLdTY392jYqw0kDbmfCSkSQL7lpvGjOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901929; c=relaxed/simple;
	bh=AW22c+oIVPm54OunVnTdZfmqlUX7ak5Fx9HZTSaJyuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8BBAVGgotj2WFr5ChzkWx+7XuVdpD4yjAdakmeAfhks2yXkruyC4GvNAR+/z0+QOdWwP8AKTtFxI8PtPBcX0JQc6IJdMGkoN1QRe89mLQb0pbx4UkRex552k0wpcueDCTq+OxEl0gxcxuZNaTD/P2ChGBflpiAv9Vjeiu6P93s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqjGdLet; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqjGdLet"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYa3eznFUH4QOg+D37I6pVwI9JTjvtGi9kyotBpKPrS6TD+rHKWxVvL2uQYqLHZm5mc9HvVe0OZk2sL9eHAu/qGuU+QY/SVWFvUosbITwu6yc3inNsEgvYQo2JP2rAjFu9Mr2Yu3rql5jVULks1RmOWQ4rAhf2tzZWl5Hyzc3RcMjqMdwpaP0i5F2OGvmmEORe0sMnyFkcbWxe10b3FnCnGYkdoDsOneySN5ykJ6Le81gQ7oK5wwn8X8U07+tEgkvO9JqTgkGXAnpjgFhqNMQLQHI7wZJNW75glDdt3yS66YlFg0TFs9HbAyRYRNPg16eb5DkEUGs9pznoZ9ivRKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKBjgsNrAPpclO6ZzyqJNEcASQmIz711P7QoZ9+Jc5Q=;
 b=gCrndrLFT4djIZ3suZrExsoXZ7tVR2ZpW8QQv4qqqQQdH+PRCzA3R7wdAncXL5O4Mcowh3TWZlPECOud/tAptivjSlRi5tm7V+mo85kbEeKMnQD1/MoVsSgYsIYIqWTIteguf04ZA8VD14UT5wAJtyUUSdmc1RKiXhtTtwIjCwe4WzVTNAAsYX7NOoAcXK05tUTe+O8TpXGxZZX1mYMbR7SWruCnVPsa9UQ8W0eTFqyB7KZL/KA+mT0LJjU1cJxZ4jQdXQ0VbzeWacEiT3Kke2PSBPsMTWjdesPQhuh/aaf8UmvKyQRq84lR35TR7B+ahESDZwIXJPjnT6JMyxAVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKBjgsNrAPpclO6ZzyqJNEcASQmIz711P7QoZ9+Jc5Q=;
 b=uqjGdLetbs3lwLHKFrOco/sdRWJ5OK1Ge/8KsIBqNPGeaWhF3LoWdQyPpDE7yIEuvwKC4ugMKxDRwlH6crycElhRDrzIlvosewaXWZt+GbiCkoiKYoXObMCQxHSpBGhWpvH7xVaNhA7GuT/ZauquTr2zLXg4MpBcrVTarEkcXEv2sI7ZRPv5K2wkmextBGJoaVoB19RDT5Dzd7y4puaPz5WKiy5cwio/w31LT/kU5YqV3qNCLixqR2TPvDl5PttpR53U/FiGjA0U2EYumfERlxLycZTdWBoxsis8tNo0wZNkZHgyX4PwkoxFmkaYPqQyN7USpyl8EG8jB1cL1BDvCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:42 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:42 +0000
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
Subject: [PATCH 17/17] sched: Allow enabling proxy exec with sched_ext
Date: Sun, 16 Aug 2026 19:35:15 +0200
Message-ID: <20260816173732.17162-18-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 076af203-0978-4eee-f13d-08defbbd370b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bw4aXbc+UKCQcCDleoRLYGkTke+ER2TktFK873AuisRIoVuqnowY0R1Lhz7CnY9xBTxJLnhe86AWVpG1ODNR+44psOtg/9uXWw5Aydl16c4yjGKtVeGjTMFJN8m083fw7rcNjkjA/twajMwqglWK8BJmZXBkMUwSVU4ffuLhT5h+2pJnxg67FCsQPcei7orejzNgA1O6y+Sajcd+vBE4Dfs2S3c+2d/Q3wDxa7LFqh+sVP/c8lofFXFI3KAVEL34IcRn3KabYSIZY/LgwsgXZxYgXVbUYZE4ss2ZbskPAU1RZYT+SYIZpyAc6XU/8O74BYkSUS2PRW9F7e50tFCsXGn4J4iVk87DGRr1myUEREw70bB1QkxruID+XAtC5bR22XPf4tkytuC2ySfgBAGR7AZ2qfU6T81Q+L8iC/aM5sDs5Zu+nF+efTNLpmZiwKT9jJAPGjGRre5ExNVh+oK6Tyzyjj7pj5SkLtTR6XrbHLrqmU99p3peJkUPYtsL87+vNWgfC/L/gJDhuIfp8jGdMdnajZE5zJ3xLhGY9hTfuXZ4ZY7FWinGHcwgKxPAbFNUjCKSQojh1Y8OXnX10OmUjyxXsESU4ISXmNTfHDPp1VzXnEm1QkdTgKUFpFbIX4kTPBBTcVjzF4owxaTYr5WMLTqLWyKxx7oQH/C/+Yo7w24=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rFc3r1cPleg+wqmaAI4ZlRijv7Nen64rx224zNyDMv1eyYrWz5K+nvsiAgSl?=
 =?us-ascii?Q?OQBVFnTdoe1h2fX9bmLTFcmCEyY/qOyVjkYngHoAZ6oAko84F4PYmQaHQ3V7?=
 =?us-ascii?Q?xYR5HiPNDwsCo/V3KW7LrN4MWs4xMpLDnyDkQv05qUe0OUernv/lyPvbUvaS?=
 =?us-ascii?Q?PyTOHa0vrUQDteoeHbuXsweHstVUp1V+iEWhzgjajGfB8GJ0unk3fjeXVcfr?=
 =?us-ascii?Q?EpRjZH3+ct2jLdif9JOqMPWqVMiMwFhp1s9TU5H6FvXAC2DfYSjVmPrS7rm3?=
 =?us-ascii?Q?Ja2modD5egTVSQW/yMlIIs1bZhNQo+/lGGsYP42gfHRcro3tJqxvFiDIcDM2?=
 =?us-ascii?Q?6jcAEExuKHy2cjOzS885oZM0StV++/eOI74mJ4THrb5h0hGAUhQpg+mDUqsr?=
 =?us-ascii?Q?Wq1N2a9cUNLX7ZqmZAAZxHKkW+bu0kCCD871Fa7CSTV9YXgCS2sy0aZfCKg3?=
 =?us-ascii?Q?JShFU8R18x7k5qWegbB6Y+d2tzfJraCKvDshP19g0lbHrfbSNSF3mRJbfIBn?=
 =?us-ascii?Q?usqt3MEg5zNJAt2mSq6xu1P+18tQ6z5JnZgJRqWMTtEg7cEOJsdoDHqtx1kf?=
 =?us-ascii?Q?Bk7GXgqeqD1/D4mqfelk1H86dL0rsv+Mv1pnBMMY2YjPj4ofGor5CG0rc3We?=
 =?us-ascii?Q?ANcawJyTXh0rSZcRCiuq7v7jB8M/s0TRfp5qLJSnLPZ4AIXvhNA846suuowz?=
 =?us-ascii?Q?UX22MWZDBuJUk6oNw53ZfSHbeEeN3UMEHpPue7YdmtioQAonoHatT7YKTlmD?=
 =?us-ascii?Q?Em+tdAUJ8/sw9L4IQwN1ceXkRrhYYTPzoEcWPVHRf5BRCqX6hTMGNbz/+2FU?=
 =?us-ascii?Q?5gdcnIenCe/70RzB+UniIwsDKF/mfpdJlCAGeJMCN2H98AfUGbR1y27lc2jV?=
 =?us-ascii?Q?08N927RrphMKisBEIewdbANPhNYQHA0YhCTyvK5Jq6irEGGGIZebPZuph5gt?=
 =?us-ascii?Q?Bjyuwz6jpZux3at24taqhoQYaCkt6AhG6GbRc6Zlz7ra8B9i3oz12IEYSUpb?=
 =?us-ascii?Q?Yg3wqZuQZGxH010h5/JW/ROQlE3EVzI7kwCYrahNAyi/H3UUOvUADHHqp2Yt?=
 =?us-ascii?Q?VykzfMonjcdgB0mXzK615QIbjHm5ppIM1j127mn5xdd6qJBkmc1XSID3vIqI?=
 =?us-ascii?Q?Ghm4UTDDSigYTeXkojgghhLpw9NvA8GpQNXz10/kP8I5dOmg0EWe5hhVspGu?=
 =?us-ascii?Q?QFVJZlJQvlI4UBXFIj2MOoGwLv0QZHthmSQJBs5u+JIVIiwAoVXBiZdegsv0?=
 =?us-ascii?Q?f0dtSeG+MTQEkSMrXWc5e7sMRaqx9ALlmilIOrGeLyXZmGycCuYLER9kK5k3?=
 =?us-ascii?Q?1mjnNqCo11yWWDbFKASyouuCD52SApFG7GfIYUuHkLkhSha4/sE4U++ye8Ry?=
 =?us-ascii?Q?x6irbuqVl1IXEEvhEaB09FNj1mgUpvucGsJyD/SgtsOdeH5BRudSUrUvgqO8?=
 =?us-ascii?Q?qZpzLQxYZrmXQFOfNY/aTlN3vDdVyRLQlq8nwBeDE2GXUrfFU5YbjiYuLKug?=
 =?us-ascii?Q?bQ8JknAfuhB3ejRZ3S5j13lJCvqSJ48kdu/MxRGhucRxnVUIVlT5YIdlKq3i?=
 =?us-ascii?Q?GTUQHvUVyiIcRD8ipeSKElSCP6SpXB+MuvdKdAeftnWYv9eq87oyyUOL6orU?=
 =?us-ascii?Q?3c6cXXTkKbXFtO86xHPSZ71eYHUkk+Z8kRJKUxwUQDSf0bfxV6WWwJgVqd6P?=
 =?us-ascii?Q?i1gmqLVOfvMuxa+jwDXborP6norygViVGBsgu1vHsyCGp3Od5gbSK9ghrDE8?=
 =?us-ascii?Q?a3UXhfi0fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076af203-0978-4eee-f13d-08defbbd370b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:42.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsfvmRqoglOFDb079pA/LAuL9V0M/JCCFmKAAxf6qiGAeZid1GALSVndcA19udAxqxSaCv1JrZy13IwV13ZuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 init/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c8..0817e62266e03 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -934,8 +934,6 @@ config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
 	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
 	depends on !PREEMPT_RT
-	# Need to investigate how to inform sched_ext of split contexts
-	depends on !SCHED_CLASS_EXT
 	# Not particularly useful until we get to multi-rq proxying
 	depends on EXPERT
 	help
-- 
2.55.0

