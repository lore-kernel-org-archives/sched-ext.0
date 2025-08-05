Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447271EDA1B
	for <sched-ext@lists.linux.dev>; Tue,  5 Aug 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384366; cv=fail; b=nuBEr2Xf+3m7s/Y/vER09Wcg6ubZKsc1jJ0lptIWPGrv6AzFDTmis/85LsSd5iovW+0HsoiwaBgky6fGMcEmWxMTYe0fNgX6kENogVoLjbUDLZvNeMNUIW5FPB4/UBaT1FM+HkwOxT8p7ktVQh2k/eXxk4bx5yea27TY40a2VpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384366; c=relaxed/simple;
	bh=9W6+1oZODM9b+VGFcLlD/+rwpyeCnxqcnVQAeqt1nEI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TMcOey5Tg3LfFG/jfXVtkXVTUxXjkrxkExPgFykD8dUZm+5e5FsHahdZScRJjkW08RgXcwGAWG9aaPqQQxAsLoHBtEt7N4IO2FUGH65lbfTPE8VQ5XqfFOtuZkLFT4Eai56Vl1LT5jaSy2RHPeu3ZY4xOBEv1wiibYYCS9XiNL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jYW2eAzZ; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jYW2eAzZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0NKg0DqhBkaLXRuZW1zL0dHsPE93quSpqVfoqZ10sYBSNqbVMfn+nfPcvu15/wiVNFNH7ZvCuut1EuN4LmMXRElRnQCuDpSL3JGX4Xl79EmdJJtLjCS/nmpg4ktL43MaAIqtFa+aweWXUrpIWAupT2zyg1POil3iwxPmyFEBJrl3v6qGJKp4B1wtWOBL/Tt3UQ76J1oSZna9M2WcD3zGML5CRRSrgFXUmgM7gYAV+KVqer2bWSi8LR6L5GyyqSQCqwPrueIGoLz259s2R8xdfptyC5w1t4Ho+jI1qXVJu1A6vsQ2W7+aPWKK3DkVLWkEUSCEKMZZaU3R8qnPrC6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVibW2pAazX7IlYNALKgk2ICIdSxZX6c1Xz3Zu2yfkE=;
 b=c7clG/J7KLlEqgWJRP0h4oz4G81hds8Ux8E1Vxtx1Xwg96HJcbBjV0R+fH6H79p+8qRM7y20Irv3FgnBizd0FXAt6NkXxwpvYuXn71AMoiB6y0HK8fQdiUFbJ5yEgOEdLp8hjRLClWQlrnmc4oVktFLp0QCXncNsuzPt6zoh9VQOmIpgqe3xdcbVAiFnverDIgs1WPhgH6LzvgjBBV/6YTlnktwaXA1tCQAqNNPR0seJmqM3soVVEifRtiQv82UqxUw3/N32ZIrCNZcMbTtpQtqsczeaEFR/qAmaMDG3Ej+yOmE2wRn+b8NJUaiLN/5mxiatfG4yhF4argwnanwvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVibW2pAazX7IlYNALKgk2ICIdSxZX6c1Xz3Zu2yfkE=;
 b=jYW2eAzZdUgRZu4eOSFiDZHlK1jYNiQniKhf5qY83AEZJ5/C/4JqXCGKzfS16be739AUlGSN7pOVRil5dohAjzuI52WbS9FhcTytLEG+0w0SYY0xepKKaFUX6vMZXWz2/3I3a9DTc6qiGfLkklKr+U7GzUuRqj13LC0tYOcntzQbouo02Lvw9FKTasDOSaPZKnRuepNa3d0hXJcxPsmBgb2tGMg9m2oTwVsyeisNRClEbLC3va5hkhro9S0FbE0EdzsOva90DLxMoIOf2UwVpaJBew+SkLlWGY1LzUmQ27Id2idtePuA8QLWwIktLq07k0+1WxFK56rxOQ85VBlTXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 08:59:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:59:15 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/ext: Fix invalid task state transitions on class switch
Date: Tue,  5 Aug 2025 10:59:11 +0200
Message-ID: <20250805085911.164956-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: d531b66b-3185-47b4-3bc6-08ddd3fe5aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WmbcO9PqA+yYMr4V2HZ0RftJXClApJhP1/PZTNxcL2t1YTWCVXAqP3TS7ill?=
 =?us-ascii?Q?VYSjpZkRN6FsD46BLky2bjHTS3+dDhNE94LC2ncre0SuXHQBe8nnufHjhX8x?=
 =?us-ascii?Q?/cTWtiHdQWoVJRgKKIO83HTrbA5kgtQjYpWf1WKBN+Qf27xAf1gP6kBA2IuQ?=
 =?us-ascii?Q?ypWytGBTTfe0Ua4pGPGDC9GOkWHae3JYtAwcUoXR97Mbch31Cg8T+IyYCNw3?=
 =?us-ascii?Q?BEDYXpz8ddyQxrNNoKbHiRwM3xnitgizfczE5vsDa3px+kLy0qLLxl6tJpf4?=
 =?us-ascii?Q?RS3u/jZ8nfUeC68dEijR+ddT/wrEX/5G13ilvHOt3+PhzTjnYtzTaDL9J5kD?=
 =?us-ascii?Q?5n4L4d9++FFS42DSayEVXvQrORVYsJUGxBkXKNYlro6Fo5ZQJPiMpvXYTXtp?=
 =?us-ascii?Q?2D8/QJ6Xg3bgyEGh7W0IncLJr3uXz4DTeiCi2pLeBwI9Pjv2dasDI4b4Ru7p?=
 =?us-ascii?Q?CcsxiYG1bWnTykAJzvlp+gSuALZvM4VOUb9y8poM7J+AmSh2HcJGxH+hK5o+?=
 =?us-ascii?Q?Q6jOxHbc3sEBnt5Jlgfhy2mIH+H0gcSod0hx0y/d1XSUc8wYGfiSXppscF8f?=
 =?us-ascii?Q?WUKQezwaY1z3lMIOHyy9DFH2Dxh6oYiFNEKjpTnlytYcKPIqRFaj6geYl1Mf?=
 =?us-ascii?Q?WEmDiZBgsaD0MqRuTFj9T0ZhrUyu3W7q5lt5wqSeaIjTE62hzZUfwZhB/xXA?=
 =?us-ascii?Q?HFreRluTGVL2yDTi0B5e6FU4mIWAsaPHoirMHjukfQ1SwHjicp5/9S4IZTIU?=
 =?us-ascii?Q?n6qbinX7OmVwdYrpJpzrSOM6gbZFCiYQ3g6ZbDEAhoUMpXsjrMD7QZqT0Xf7?=
 =?us-ascii?Q?fhDdRZ0iZmHbART5ZQLKc0HRBP9aTpeIPASIHGIMYkHn8jRmS7ybBCRCILx+?=
 =?us-ascii?Q?U06ifpyPv4nlvqadtsqv+vm6EP8XeSTo0v1JvSheezdVswaSQhnX42HhDcx6?=
 =?us-ascii?Q?mqyWkbdej3wsMG1XxTQYG/Q3RCkSpny86rJ9pvX94D8H67toZyRKQubJ5Ccn?=
 =?us-ascii?Q?LcWrpbM7G6ZMqx1w7miHWbWRXWdkgU0fS2u9ZureOF3Us94Y1zBEJpbps0NC?=
 =?us-ascii?Q?5RDNvLGtv37rteJ8JoLuN+jA/Kx/d6C2V4IvXS8tPa/4iXWhJDj5oBgRR0sR?=
 =?us-ascii?Q?IRJ7EG5AHVovZRIdJ7pzOfq1ZlZGuafgPHy0fkXzir7fjO+JcMxGYyemuUdt?=
 =?us-ascii?Q?4ObU9jix/4UnnZXN8ewbcTLyxxv3h3MI/z+xNunFQPWs0OGT71yvhrGyqhey?=
 =?us-ascii?Q?6eAcnJfCUctcsnzOn7twLbzs6Zw0E/7EVue7JQD9lciXp3mcXFqUuwPAfIO9?=
 =?us-ascii?Q?+ctuBY842uqNyT3zEmme0bl2Kmdicq6hW42ifAhfh7PdtpXV00c57gzZ/EkZ?=
 =?us-ascii?Q?Kd1jJ6qziI9461YotxjaEV2Pt2IOM/mPw7FfOZmytvr1WX4KL1w8m50jBQOX?=
 =?us-ascii?Q?016Y7wE/SwM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQ6ZbXGFpk04/Fb1bKM1QyKVBL9Bn1tCFzup56h9DKbj9aZtGX1WlGmXl5mv?=
 =?us-ascii?Q?yM3cp87XTfypnIOZ98ttKDTwzs1NifSRxMOwBiVAM2lymGLrtb8f9zucDp+T?=
 =?us-ascii?Q?z/kZthTLjF3+wPWBQ6Fg9XXIRmzYKfIEQ8xmJUeYfWjYyRzn0og0tOjjeucb?=
 =?us-ascii?Q?CqXZ0NkRt4TKXUcZbLp6g5UJHMohRouzwsQa4sfj9o3Si0zsbcrNJjDMPCxT?=
 =?us-ascii?Q?iJypWaxWi0qE2anfyGtNkyL1nX/9haBcOW2/73pbyHA7N4xcm5PxeRhh+vL/?=
 =?us-ascii?Q?UgcDWXIRjNfjbAhZk0p1wpfdBaG0bAPRtUl/qNJ1qYTbwN9rc51QQhWWMuNO?=
 =?us-ascii?Q?EYdDZs2zt/IRAFdk3/JnRLEHvXrtZ+P6yaZtEl3lDFChS+b/LLyXZgYreBeo?=
 =?us-ascii?Q?xXVDmkh438tAndryaqSwcqI8/HmWnZZCWs52CmxSbPyifKmV4SghwKInrU6S?=
 =?us-ascii?Q?zznSb5gBczO74basj0HbPmu8BPdWHfU3Ane88vYU3PX4lNofkCDL0IZxspFo?=
 =?us-ascii?Q?voU74cSuXGbZFwhpdTd1a6vudilruNvEBHeG9Sb/NcwqNGWMj1kgx9k0RFjZ?=
 =?us-ascii?Q?prmQ4wwQPmXJI1cVaB+UvGuePla1rt7cxIt10wkWzy/m2ZHWnplk1hcBH5xf?=
 =?us-ascii?Q?heGwubdEnccIUqKMM/uqOnC0PG7gTFxWs4VnUszJOg3ZXv0/lE6ckM0+mgPB?=
 =?us-ascii?Q?AseiLYeE+meqDHDuFMnib4c/RVkuN3NJVap1fEQeoeYtd96HGGknGz1iUYK0?=
 =?us-ascii?Q?B1bQZPHtJeCc6LnNx3X7re9WgRFBgMIoGEk/VaQ0uGeO8Dh7sqxbNXxfasSN?=
 =?us-ascii?Q?MkgtHKRF7LWPj2ZY/aE10nBhLPYDA3Ip9qS5U81IiWoACmaBdXSHhtSqkI9v?=
 =?us-ascii?Q?ryS5O9m9n+0gcjqOV/8ruP2phDAdpVXirtXhWEIGtugjSfsVZ/RPi8OXa/tj?=
 =?us-ascii?Q?SguD/4OfL67USdUXFHweoopRlxNWzCMI3I6n9LEbHlrhp+lY56xb9NKSk4Ny?=
 =?us-ascii?Q?E/cHHGrt78PDP5QVmcBTOmSv8NxZS10QWypGEamDjVVGxFwinz+yfo2QlVtF?=
 =?us-ascii?Q?kPbgjUQpCQmdtLkVCr4wo/voPmM+6E0IOJN4ulFx/2P4488yS3QTL/yl2Y4R?=
 =?us-ascii?Q?QR1CU7vvFAIddcqiwuR4yrf0Isl26bEmM2QgF9aCrUFXNdZwp3xZvVXR+DVL?=
 =?us-ascii?Q?etiHyPAM5bzf79GUaPhcLElTtPRONqyTu/r9fz++qfDSyb3omVaDdS6kLLds?=
 =?us-ascii?Q?6x9dxe+kI3uWlGvsEImviNLil+dGk3K4/HTAZkh3MRo4v8RnmRQNOOEG6tWJ?=
 =?us-ascii?Q?uIMEF6sOIP0qJ45r0yX+rbH5+mNohHLQxf+HiHXojrZMHB9cZJsXoXQk3Xk1?=
 =?us-ascii?Q?aO0umXgWfhNOA8KIGQio8Qu2C0jOssRptNb342MFgo9ALEXpbS9ttRiE+Kdy?=
 =?us-ascii?Q?SlPdmBZ5OGG9oDGnbYs+fnZCGZuDguGGmT+RrriFnxjR2ocrnJFCUBzqgyIZ?=
 =?us-ascii?Q?UVf/wTSsNv+cGzeWEI5ZfUtdnqlcxAkPX5Fm7zoF43IXKeICzWfSejmwUZc8?=
 =?us-ascii?Q?3si2qPwhQMuW+ZdDwlCiiq2qIj41MM42OmR2FQmU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d531b66b-3185-47b4-3bc6-08ddd3fe5aa5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:59:15.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1MJewFLiA3ZiTb6RIzinChZUMmoLhT1GGShfynOb+f5Ce1MvpTwp7TheJJAX0tV8y2NSpDsgg5IfKHGsnpwGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

When enabling a sched_ext scheduler, we may trigger invalid task state
transitions, resulting in warnings like the following (which can be
easily reproduced by running the hotplug selftest in a loop):

 sched_ext: Invalid task state transition 0 -> 3 for fish[770]
 WARNING: CPU: 18 PID: 787 at kernel/sched/ext.c:3862 scx_set_task_state+0x7c/0xc0
 ...
 RIP: 0010:scx_set_task_state+0x7c/0xc0
 ...
 Call Trace:
  <TASK>
  scx_enable_task+0x11f/0x2e0
  switching_to_scx+0x24/0x110
  scx_enable.isra.0+0xd14/0x13d0
  bpf_struct_ops_link_create+0x136/0x1a0
  __sys_bpf+0x1edd/0x2c30
  __x64_sys_bpf+0x21/0x30
  do_syscall_64+0xbb/0x370
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

This happens because we skip initialization for tasks that are already
dead (with their usage counter set to zero), but we don't exclude them
during the scheduling class transition phase.

Fix this by also skipping dead tasks during class swiching, preventing
invalid task state transitions.

Fixes: a8532fac7b5d2 ("sched_ext: TASK_DEAD tasks must be switched into SCX on ops_enable")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dedc9a16281b..4ae32ef179dd0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5749,6 +5749,9 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
 
+		if (!tryget_task_struct(p))
+			continue;
+
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 
@@ -5761,6 +5764,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		sched_enq_and_set_task(&ctx);
 
 		check_class_changed(task_rq(p), p, old_class, p->prio);
+		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
-- 
2.50.1

