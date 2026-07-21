Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57042BEB3
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615633; cv=fail; b=qfigMrNvQpjkXlqx4jWr/Yg4JVb3+/h6f+FTGoJ+ar5umiRiRaJBb7/gJmrcjHsQM6j96swG/oPgSXJ1qjEystDHicmBu3x+c29nYNY/hgSfz59Zdlm9vcpRyhOkXQ1BqF3y5HGlcGNgTkW9v1eQwWp2xB+VcY4ahYOS7GPw14s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615633; c=relaxed/simple;
	bh=JsqYh7/Pw7kAwcDGz2n0sf+i0b6eARDCnJO4OAX5U20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tzcMvye0wfkh5Hj50UMe8nvKpF9ttZsPNIAxFlO0tUNuYoiFY4FG2KBDqNYWlJdRr+i68sQWuu8YuhbiXdSP/T31k+cqoPBucpL7FPmmiVK9KISM6wNRlItn4Zg1lHXhiQ8fvtXv62bJaI3HX5Hp03/KyAV4z63rdp9pWePAY2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eNqtlfp8; arc=fail smtp.client-ip=52.101.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eNqtlfp8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qodFiPoR3/McTQlUKxOY364KIkDS97jstHvdX6TPlBk3xPoK6VVr6g1rXERCyrgkxRFckTfth2ABHSZuOroJUTwtAOhcSqIEYbl67zz03BFEKfK4ZlcM2mxePRHjpMf51FD5s/dTyym2DUpWRZSufGB2lghBcQXd6tillYBjDJtGH57wukw8behkN1Xek3BB2swbrNsqSTQbwW9udnbPYNYr+EiTf9CuJN0B77aieCqMgSXi6vhsls5jftq0UH3G+SnHTFRNXk4pmJy+/NYGQnwvSir3amDw524CuCl3ihtmWtSkx58PVEwqgV9UkhdLkOO2zFgwGPruw8G3KndH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLl2Zpecap2h7wqEkts2jzddoumcNAH1AbphJrOO0MM=;
 b=rxubLcG6aRtWq7OVZi46zf66fQ6bdCcAmoqteT0G/8DLbkMhev/Bm4lg3q1gNa4Qyz131QZhfzVZjhLMj4BpD4DEbqsT3TTI5hAmNkNjZMVC1fWgXOC7g1O1ygE1OY0YHdQD1uDVZrYLoChrzr0C3pUj4tqqNWj/cE0UJqrpaZ7SzSex4lQFYHT5+3pjpVuMCecYXZfiMeHt25a8lZMnm9xZTInp0hQNFrIbswfBNmIyN0loQV8kpw/FK1G2UoDRBuZOBlM1PxQABe4lkO5jaBXDrkjsrRWRkF5Erta8SCx07BbW1fVCElIJqIN5WsQN8hV0AK5KNzvX2pWZuRKzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLl2Zpecap2h7wqEkts2jzddoumcNAH1AbphJrOO0MM=;
 b=eNqtlfp8naho3goi/CkeuuaBgL/ry+MS0gPnRQKXvGcB9AGxmGYw+7JKUvoDbxTvSX4DMgMb71XdhnZjMWwTqGL2uB9ekP+aSwmQRmZrAcs4JP/sfdt6K8jTodLCLs2iw71Bwa2eiWtiY044l7+ZE2k+6dQgQnVdebRxdw0mlDuHH6267xIkrjgHaHCJBepQ/AGNB4omJN68Tgp+7N04fv0ExZDX0FOjcl/BEILe4oyEjK/1L1/2mPpy2eQc/iToVLkoqUpNS9swdbslZVLvjvKJ8lKm0qOuy2nrZcfC6xwQdV+wBqBf6aPKSrdkOxAbIhJb2zASidLoTHBS/ye8Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:33:47 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:33:47 +0000
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
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Tue, 21 Jul 2026 08:31:26 +0200
Message-ID: <20260721063242.552774-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 94aefd55-abfc-4b26-cbab-08dee6f2047e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rr+QxUUVD2jYgeYwJL4i4zImwdC/snB+2kZmBBQ8E5PzfoRy7Y07LUMiMOLp5uOj3aFv1uPcVwI4HZ9NBGOWpMFu07hMp/iNezOp9oGgVUQxJBFtSRtfhSSDgFoSmp/Zj4ZQZC1UPze9QOVRAdTZCD1Ci+PSFccgkz9TQnKy+FkI0yTNypo4MaHV0QWnqyFHQyDIq7dP78W8XUHYLixsk4V/mQ65QoKi0cp9CZJSXN9rYo1+mn69XakH3pu9eqv6jgwTnHXtu3MuScdKXHeLKL74hadEYSKjjM17YliCyol/zvh3oc79m5497yqUxooY3gX2w/bWege0SHyukWcS4WNAvXvHRJROTmtDKrqAlGswz8xl3nf1aDVuvzpooyDveP+TQCBw2u8rjdcJvp8AKpBh4nPG9zQ8jgmZWx0DRoaIIIjiczyLDxc5LyBWtE7agSg2pN5k7G5hd5Ec375wzUH5epC/zVoYIF/RTJycSZH7zKi2gH+e0AWkhUq8lI1s5+0Q9dBKryRiHnp0dA4aTO5fkP/rHB4DMO9NidJ/XmKJKpeQ777wjALskbF2aDMc8TLiG3tkUwGck8Q3w73hetQdKolZJzRwunpLAKUBbSUPdh2C3t91gO8h0lpUObzv1fQ+9xMQdkrVb8rOghKFGgFoCQKkLBkv5+orYYFY1kM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SWVEJv5nV4MVNi3BjhbUrKPPoI6rOHXk5IcZZYv1BceUOZqW0J1CobMfUcu5?=
 =?us-ascii?Q?pj7VSc3yq8tG++bAqibv6iWuHxM1SDlYvHaZiDwP2SAyZeTuAPmAY8K1Ocj2?=
 =?us-ascii?Q?HukvjAbEIDmodo/V6s4JlTcZVtaORt3KqzOohTV3Xsa7pj/5PP2JTIYlsmZX?=
 =?us-ascii?Q?G0WxS6+PA4gSvxa0SGM+lstWVBu0AbFB6b6uQoRnmTbpvzGnQLhYjrGOsOVf?=
 =?us-ascii?Q?h7XNnoOt4DBb2c9le31GSKLUb8oW9h+OBIM0Im9dacwx7iDQyYEjG6tXmASP?=
 =?us-ascii?Q?NP62sFffbPJMpgqDzGVTTvureVyUcdXs40Srkpd2dlTU3OeW09wspfSJdf8q?=
 =?us-ascii?Q?vef9xvCz5pA2b9AM/khSOyLjuOL7mP96CxB54272qNtwe9oba+GzSvQBLDjj?=
 =?us-ascii?Q?jEwYd1UkCxVWM+xtEb9xniF+zRP/nCinRHzp7tkB5WiydQegeLg5fIpcPjqm?=
 =?us-ascii?Q?WZM5+di92VpDJl2aT4oQ4gfhhAoRHCF/gdcF6/EzyAxcVJSRgmH7FtOTeH+Q?=
 =?us-ascii?Q?RnIjYcGb+J07r5Leju42W0P1Xt6TRsZaBOcjwqE9uCtZdmNQS/RJOkypN86X?=
 =?us-ascii?Q?KWCN0AU3k7joCTosUVGgj0JTVvOSWNI9IweHW1Oe8Om6yeCrGqYYbyB94xhb?=
 =?us-ascii?Q?mvGD7JTzCvaqFdHFLDghtWNUEp/Vv7bIzL6LwR53/KrCtG4zKRJ9iigYUBXH?=
 =?us-ascii?Q?U0+eNtH8UHoOIB6J6okSS9uyH90sGd8dCtY1mzCdamiEscba8h/ixCorpJPJ?=
 =?us-ascii?Q?AHKE9x2aH8A80HXx58s/g0HDLJk8ga/SJb5XdbLNVc3l9cUAwcuZq1EU6n8Z?=
 =?us-ascii?Q?mfoh4BHhxRDUkluaE+PrmYUFHjJbcn61vzM2dapCifShZBDKD5Rb/6tIMir6?=
 =?us-ascii?Q?8C5I9p43OK5BUr2uYdWx95LJoXmsP56otmppINnwGYlb3oLOKP7CRkJ643cd?=
 =?us-ascii?Q?j3mV1oS+Fiy0xUsfIrgyUgq5CygnU0L0Ch3s8cnB8uW30Vh6AMzX7W4oEJsO?=
 =?us-ascii?Q?XH5V6g9YyqT1pYyRjNlcJAcYrDA3B4AGgtJuzzOjPSOXKJ/4e4udIm1zEzn/?=
 =?us-ascii?Q?m1YJ8tS1jMblH5fepqV0pK03IfEH7P9dvvtQlxnTxLT0Q/AW3GI4dgB907jU?=
 =?us-ascii?Q?6yC/bSZWVOCxjM/n4ie5wGkDdWA7g0RUYXI79w1kfWzTSvEgZ1k6h5oRO+qy?=
 =?us-ascii?Q?zrfTtxyJHnupjxitNaQHUm2N4LhuYBGky1V0UeyfWY9uvP9XcR9LpBHag7zX?=
 =?us-ascii?Q?a6Lr4paldqvIB4DmW7/9TKEt9UEq86Ez6/Zp9SrTreRQDjB/XskABHpyDOkB?=
 =?us-ascii?Q?HdlBLjHIBbW1gJjoNPt9TQpScFBO8hYltQKMq4C7WcBG8FLfJB2T6KTi2RHB?=
 =?us-ascii?Q?gYN700y0q98ApnPWhEiR5XywkdkVY+re6lPOJvTtkQIj3UIlf1nmD2mBBGLi?=
 =?us-ascii?Q?VybckPX51bqMsE2LRvt5lTwrY4Sv0v4u/RH9uT1wSd6vCmcY2H62+SrcnWGG?=
 =?us-ascii?Q?4G3mPr/RlchzqRcTmWFVis7IN+mn2L4iLVNX0mEOM08+vM3kEOoYj5mA7Pj2?=
 =?us-ascii?Q?GWoTyyKhC9ERnagOuWmfNRbUkXRLSdZ8XzrDMg1ErCpV1l61CW3tCloMQmwn?=
 =?us-ascii?Q?F2cqHDMZXRK7XvfCwsgXTcGsFkQpV7QlAJF2aHVE5ZEbqMFVP3c0j6ZIlS0r?=
 =?us-ascii?Q?YZehftTQjevjzfIqBTn6hqKItOFzEAnjnQbeKZSLoizIzbybysfacCJcZAM2?=
 =?us-ascii?Q?pwIwbvgZ5A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aefd55-abfc-4b26-cbab-08dee6f2047e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:33:47.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxHP6kgrmJWtPE0R0LXq2Jz78RE4rfTj0reDGiyM88FsMgs1RgD2MF9wVtCxrpIPbyJpAFST1rW+pyMDhvo0WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

With proxy-exec, pick_next_task() can return a task with p->is_blocked
set (a proxy donor). put_prev_set_next_task() then calls
set_next_task_scx() on this "ghost" task even though the task only
provides scheduling context and never actually runs.

Calling ops.running() for such a donor produces a spurious running
event. Simply suppressing ops.running() is not sufficient because the
following put_prev_task_scx() would still invoke ops.stopping(),
resulting in an unpaired stopping event.

Introduce SCX_TASK_RUN_TRACKED to track whether a task entered an
ops.running()/stopping() session. Set and clear the flag independently
of ops.running() and ops.stopping(), as the callbacks are independently
optional. Invoke ops.running() only for non-blocked tasks and invoke
ops.stopping() only after entering a tracked session. This keeps the
callbacks paired for proxy donors while preserving stopping
notifications for schedulers which only implement ops.stopping().

This is a preparatory change for enabling proxy execution together with
sched_ext. The explicit running-state tracking is also required by later
donor-based accounting: it prevents an EXT owner executing for a non-EXT
donor from being treated as the active EXT scheduling context when it is
dequeued.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |  2 ++
 kernel/sched/ext/ext.c    | 33 +++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 78b2f289cb986..901772d8ec15d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -103,6 +103,8 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
+	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
+
 	/*
 	 * Bits 8 to 10 are used to carry task state:
 	 *
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index fd1f55c53662b..30d5965d09108 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2217,9 +2217,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
-		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current(rq, p) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping)) {
+			update_curr_scx(rq);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -2921,9 +2925,17 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. A blocked task can
+	 * remain queued here only as a retained proxy donor. Skip it because it
+	 * provides scheduling context but never runs itself.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && !p->is_blocked) {
+		if (SCX_HAS_OP(sch, running))
+			SCX_CALL_OP_TASK(sch, running, rq, p);
+
+		p->scx.flags |= SCX_TASK_RUN_TRACKED;
+	}
 
 	clr_task_runnable(p, true);
 
@@ -3029,8 +3041,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+	if ((p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping))
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
-- 
2.55.0

