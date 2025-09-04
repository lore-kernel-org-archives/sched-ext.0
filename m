Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A518277CA4
	for <sched-ext@lists.linux.dev>; Thu,  4 Sep 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990539; cv=fail; b=UmslPBoLG7yabbJ1SxXKsQCDBi/ZZlkG6L+pqyhC7fqLN5NFu8CXApTT4EvFkbGbIJjdcHpbGD8WeW6rjMf50ivLlxkNm9O2K51RP+sFSseTntYjFMHODWn5oEGYoRN/4cfSUUZOr5UAVZ9TvtdaPVGpNJRWA5wxqkBv1L93MAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990539; c=relaxed/simple;
	bh=u/+HyqGSZ5xiCBCDkfNLJj++M4lzNWHhfhFdLpKh0g4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eM+UgjRMYBAAlNIdI2HFdAT+mPUq75jnmvjcjv9oCO+31TtEceYLcw5MU2WWThUkop1J/ySHVzN3u0kHwc5ikdM6t7k1dmGGS/mNlDq+tBCq0sG6OKK7deiIDEV6GoZq+peUy0A7rQ71WKUsg0xKfniCmuyPy1TCeVNX2U8klVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=koZH1Zg5; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="koZH1Zg5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZIWxCuDnvJCsl8T3WYnjgpfxyWn1KVGoO8Nf+N5RKyLj40FGK4+TpdpzatjT8bs4KSNK78tlROo2hgz33grZO4pHAFIVl22Pt4V0BD9ITxBPooIHEF3EATODMO2iKpucE4YydD7/8sluFVigQKMobU1pSm2wrinDXOp/lBclOjN9WwJvDjXqu5HwfsiutLz9cTQIbqlrCvYRQBzhhrsGWxNbLmK7yIxusbPuOQgAtUT/+IKGjttw6HdlYc9BQRZnJhgXYe63/HVNDAUBrqiDiW34KXNfZzK8NfLloiVd97jcTN0BCeL3jLauDGBVMGvE3NfJxBZqsH3m7ANsJDj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUmcES2UNf9ceW52kh0rBzOzSX4rlLaUB9962C/HX+Q=;
 b=kqcgSFO4guiePVnqe+g2OzHA1/76Hy3/UHofJ62+psSNWj0oyZCXyh+NTYNeipb+Hp9YQ67gXElnCrS7IRagNmEeTMNEqaq73ibhDrbGl5cob4hrgG4Og64OEQcENQdjJJiv0wOuW4mmBI4TRsx5Pz5sSKz3bD6P9GowN1pV571y4+lqzYOLA5F86A72BiQRsIAyZ9Fh91b2PrMoqaOCQkffFkF0pBjpK2879qKU6j86cSgviLIap92eEVR9UQcD+CoMDT8mhQRE6+HdoJk3utOPtyVGgZlLgS7uyb5RCYxBSqL9WYiT6KcUs450qpB8E3FqR3WtY5MLhO2YsMmNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUmcES2UNf9ceW52kh0rBzOzSX4rlLaUB9962C/HX+Q=;
 b=koZH1Zg5KZXU7WK4dtwfpNxbxsTVl+65E99vM3Q33UHCEezQvL5M1ZT3Ht0d1fpc0Jca822ITXM0MLi9O81/o3VVu+89pqQhNhQuy1Oy902rVN2+RU/mEfTmRK48+QgA9YAof57wm92blwdr8Hrzg6P2kRoAMfVvBZ9si74dmKdrcsrZ5jaYgpSl+3qPRL2pK0cjZ40Id1hd/89yNMHfldYJDK6UtrgGdH8dkwpTDtVPDGThOZi78oj9O38pYlnMAEyc86+t0uWQWlcUEZ7Mr2hHTvxkm2VrAWWa9Z6mELkSwTSsdehpOhKUtgTOr+NNeuPmUEXifOsMFW6RcetR2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 12:55:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 12:55:33 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Jake Hillion <jakehillion@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.18] sched_ext: Fix NULL dereference in scx_bpf_cpu_rq() warning
Date: Thu,  4 Sep 2025 14:55:22 +0200
Message-ID: <20250904125522.561737-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: b51301c1-97a5-404b-c667-08ddebb255cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0XKqEOWrIjVYumKB3+GMQ0h9ouyMA+RMhb2wyVy6HSw8LjqyyQkU0ymBNTiC?=
 =?us-ascii?Q?djdYE8rJ+2IM3w7hbq4tHboytRSCqiGJFxaOosIEKZv0+svEz+8JE9ikxGjo?=
 =?us-ascii?Q?44/0LabRnE2kRP56JElX0p2y9rZA6MwzIYo8coND5fy2dLxVdikmwEsW8Awh?=
 =?us-ascii?Q?ShOGnD+mN/DVpETrOLC4tkwBv7ykF1gcIy0UbXu8FCWb8ES1acNFNBaXhloC?=
 =?us-ascii?Q?Kih3xQwxj+KwoV9W3E6PjGvqvkIvGONj1WT118tk+Y0Pb9gI5lXOwE358oKl?=
 =?us-ascii?Q?5jk0MmEZSI04cuhCT77LjM+53Ux/1IZu/RaS10sZjNxlrKMiAh8TQYF4AWAC?=
 =?us-ascii?Q?oNyC+gTnvbm1O3woFtHQihiDleIuTzp4uAPl/WEm4rfs7Hqc6PsJ5GdI/Vtd?=
 =?us-ascii?Q?ZU2UBC5Olauxv5IHOUZocbTKR5fUZH1OhEg3gLDAB/1L2znoghf6UMV40mfG?=
 =?us-ascii?Q?cqqrD5JpXpc2KCdOLXkcw6DZptNNr56Nq/rlv+6klmPgJt5GDB8Aeo3TIbjL?=
 =?us-ascii?Q?+8tSwjU5GYWZGK3UxipADipY8OaXF0/xxI19ARTzbYYKFUTdSbMpDu36HhZ7?=
 =?us-ascii?Q?/shAzyy3EiFGAqiBFgiMISNHNtnMZSZSuWl20V4zMnZsKCVbeZbu0MqWGYDq?=
 =?us-ascii?Q?xO07GKbVPYtVv+6rB+4Azj8svezJfqpEzEpr9mzSjAMrz6kB5wBlF59uWOnN?=
 =?us-ascii?Q?zkyGezHbyTbJwvlLnTrty+tIFhyR6gz5MeD68UXg+aoc3Lk2gOgq8XNkIPVx?=
 =?us-ascii?Q?Gsalxfu5FR1JP6WMdet1WRIPAe6zJc5k0FAdtbjbulL3lW1rwOQccUfVqwJY?=
 =?us-ascii?Q?Jti1dBVawjnabFu+oJPdIF/kPYWGj05XAzGKEolqL/m6yJhKA1osjaIlDzky?=
 =?us-ascii?Q?tWvBguVbj7Xjnis1TRZ19lnjyXtkKzKw2H/roKDH5+W/dtkDR2Zxm9UqO58j?=
 =?us-ascii?Q?bUGyV7O3VNy+NLOj+jQm0IarBkHI/cV9h4UNm4kPC118+pBCJGdAZXYkqdxS?=
 =?us-ascii?Q?nTPbgV2026s9JtZnQWAUecNaOhzqhg4RP70ziLtQu10vhUr4S4ZihpwXnTbt?=
 =?us-ascii?Q?B+JxOidAc9WzqHSbDNsfksaixw430KggClYcuxCd7gfwzRK3Gh4ZzI+tY4na?=
 =?us-ascii?Q?t4KL421N4Jx137H5KDHB+XJLIgMzFB3oYEmb7biCmC061CkqFNZMgYPuG5WI?=
 =?us-ascii?Q?rJ3p8OVRTEDX/6rw/Gim4RTIO6v0+8dMYScQrjMP+NhVzS05scnWNI7D9Ev3?=
 =?us-ascii?Q?rOUtmhQIT59tsvlbvCTL8nWG4U+3wi/3uiS4n2r9NGNKIDxffH0nYuaGAUJJ?=
 =?us-ascii?Q?x0axhjE7S/WazBQReEN3V8LXWv+AgWuK8cUgibryfp/RZstMpp8XL+pt5+jY?=
 =?us-ascii?Q?sU/9hPpcCp6A22H+zD3MksgngRqY0equlUr+2NPgc1m/KgJLKoubZlnJZCHh?=
 =?us-ascii?Q?GuBkI/vUgFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lt1lM/oD6z4/p1iwSBoVc55uF5fFrjVr2Pw25BdkfJtfZnX/04RgB76o/nIP?=
 =?us-ascii?Q?v+EacbbwToWNq2e/oIZ3DOUC7MC9iduj5ZGivuRuGHT/fc8YkNY7YqlPzLB4?=
 =?us-ascii?Q?tF7vSiTYiHiPYXUtflagQEDleNLSKSk0nDzCbtfEeRDag4RT2WLpbMIMRzkI?=
 =?us-ascii?Q?iT/Jc7/KEBZNp+VI7yQ47VEcEda2cDRSnVF1OXOhgJwvK2VHgnxB6Oy0Ujzr?=
 =?us-ascii?Q?J/uZSwImj9DB3orepcV/FiAzYqD/kgCwfyzP+Gsa4tv2Nyt1XhpgItHgJet/?=
 =?us-ascii?Q?wAFfndtX3MwhYvCq6HxefJPy+25UDyIp5lNpmNJ7zcoAtd+Op0REyl/DLUFx?=
 =?us-ascii?Q?QLxTiffY3YnPMyePsuCm8DraOUfdnay2ND8r/O+i5Od5OOIho40acCgo/9sK?=
 =?us-ascii?Q?aSLxZtAlnZ+rchfkN13RJ5dLq5QRpFQ5J8pjA3DixJOENDMlTDi6YI6e+YrV?=
 =?us-ascii?Q?XvdpZt8mDM1XPzLMtEGTSjbs54VvqSu1rN9+zBaya6VEXNTFkpdBGcjA+X6Q?=
 =?us-ascii?Q?04zdXN4ct/B3pK9lontV+nDUrdGF1C+JPqAAkm8uRgAwCdv5GmofjMW/Py6p?=
 =?us-ascii?Q?CRspS8+hczc0vxWomjfQL/0Fj1dR20AZwDjd79eJ4dRb3cU/ODy77xcHJRxS?=
 =?us-ascii?Q?f4CiYtmcFYyXkpOxY4ysxD/DWKRyczh0HMkZgoC5tWfb3vn/pRF8HurOaiVW?=
 =?us-ascii?Q?EunCCnVTKSggvwR6M+XbYltlclVp1D7HWt2MbdKomUw3xKJyCZYcox5Z6xCb?=
 =?us-ascii?Q?9Dyma/ctEaTCKLjCF9Ao13uP9GVI39aRVRwab37DKDFqOmzFRLElsqlGkmsg?=
 =?us-ascii?Q?4Uznc4nTUvuHBFzDU0MLyhjVHS4d/egIhgmmGrLR7aQJy//FCvXwOA7sQKBQ?=
 =?us-ascii?Q?1buA2eNA4w/WnGASTai9Ra3lp8D78njM2jINf+pxhqS68l/E8iffXprubE5r?=
 =?us-ascii?Q?eQuu6UeDLlu1/pAGER1xXNSX2ZwFRsmHZCA8aYzhvME7pxb9NBXXw4cDySXu?=
 =?us-ascii?Q?Ffg76z36BoXDzHzdUEwePcLMkXUlcsPFjT+lIufWC5DfiRE4hv4OZp7ZGhhj?=
 =?us-ascii?Q?9GV/u6mqr4iPcmG5yUsXir7mFp8Kb2zLyYzTaFE3SAriiyUEAHWxaIGO3/sd?=
 =?us-ascii?Q?gqKyuQm+zRrNN0MjCDdLDbbNkWbg5gfIaeWvl8Gjbr6m04o5xLXiHlzOdhgC?=
 =?us-ascii?Q?h+YDcsas0vyzeiecmRzXB8MQehuJ5UjG8/w74cvtD9F3KsAN2D8Sbp68ElwM?=
 =?us-ascii?Q?hjPUwkP38HEbk9ZWT0PS+MiR9NpL9BHaXf0emwy0uUJBGj84lKi6sAuesTzS?=
 =?us-ascii?Q?SX91RW9ywu0/b88hwD+dK6tFeUbXIbFdZE9ayl8hKak0J4cABL9/WATHzAcM?=
 =?us-ascii?Q?qxytRfLgW92vPpx9rCGce6/engjIAOC54t3E1ydqk9vaTi1seT/bQviqTeg3?=
 =?us-ascii?Q?fRPCCgSVRJiMBcrjzGu8cXnvqQwmHyr0ALY/HJ8W3n9HYYGDcjbBJe4bOt6v?=
 =?us-ascii?Q?v+zDslVkEojNV/gyIG9mlHN79E0KBdTXt6AwxIku4NlSXRNbotLOrnSQzoCD?=
 =?us-ascii?Q?78gT9xSIqEZ+iHuytpnri1h8Yu1zydh2CJ6td/1c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51301c1-97a5-404b-c667-08ddebb255cd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:55:33.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62bWTlm8Lf5VTerS1DAcMuT3CiGOsQtt0wiffH4JlHJsLAUWMeS2zMILyUfJi43v53zqI5pvXT3BZD4iOJXPbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342

When printing the deprecation warning for scx_bpf_cpu_rq(), we may hit a
NULL pointer dereference if the kfunc is called before a BPF scheduler
is fully attached, for example, when invoked from a BPF timer or during
ops.init():

 [   50.752775] BUG: kernel NULL pointer dereference, address: 0000000000000331
 ...
 [   50.764205] RIP: 0010:scx_bpf_cpu_rq+0x30/0xa0
 ...
 [   50.787661] Call Trace:
 [   50.788398]  <TASK>
 [   50.789061]  bpf_prog_08f7fd2dcb187aaf_wakeup_timerfn+0x75/0x1a8
 [   50.792477]  bpf_timer_cb+0x7e/0x140
 [   50.796003]  hrtimer_run_softirq+0x91/0xe0
 [   50.796952]  handle_softirqs+0xce/0x3c0
 [   50.799087]  run_ksoftirqd+0x3e/0x70
 [   50.800197]  smpboot_thread_fn+0x133/0x290
 [   50.802320]  kthread+0x115/0x220
 [   50.804984]  ret_from_fork+0x17a/0x1d0
 [   50.806920]  ret_from_fork_asm+0x1a/0x30
 [   50.807799]  </TASK>

Fix this by only printing the warning once the scheduler is fully
registered.

Fixes: 5c48d88fe0049 ("sched_ext: deprecation warn for scx_bpf_cpu_rq()")
Cc: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 489462290142a..04fefd34db238 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6362,17 +6362,20 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
  */
 __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
 
-	if (!sch->warned_deprecated_rq) {
+	rcu_read_lock();
+	sch = rcu_dereference(scx_root);
+	if (sch && sch->warned_deprecated_rq) {
 		printk_deferred(KERN_WARNING "sched_ext: %s() is deprecated; "
 				"use scx_bpf_locked_rq() when holding rq lock "
 				"or scx_bpf_cpu_curr() to read remote curr safely.\n", __func__);
 		sch->warned_deprecated_rq = true;
 	}
+	rcu_read_unlock();
 
 	return cpu_rq(cpu);
 }
-- 
2.51.0

