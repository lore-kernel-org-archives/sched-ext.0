Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB640DFC6
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374997; cv=fail; b=IECTvwbS6AoWn7LdZBcEhAJEIpjah294lUzeu3QxY/m1w6CEIt2Jho2SN7I3bx5zqj0Ghqs+VwBU7iZ8HUkiMVdaP4L3HbucZ3OaB7DXM48iaUdQNG0hW8PbWXa5tfyC08YbwwRyUagdXPFlbB9U9G/UYGxe6F5dsh7YEzfRPpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374997; c=relaxed/simple;
	bh=2ngNSfjQDKsXm0jkkChf/1TFxMvihWGErhQvEu9edV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciUgaruBGdOmzj8xRJdzoPEn/EZuEEmf+bXuWR9qfR8RmquBil7bBwt2M3cyS/Q4sqC0W/wSunMtryFrc3UVSWOLsIVjPInHZLJpjSmMIR4cg9aBgVsC1AM56OwHrc22vZfiT7QIh5ZlHXmC5wxJgY3K2Cgd62LHuGsQpWOZEps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwVVfqH7; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwVVfqH7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML/HlK5FzxVJxhHiHRD4FvoGdODq5wddBb4p3DQHKHAurRJA6HRlD/LrOfNFE6TI4Sygzz28vjrywZ3JSxqmjWEqqkw5Ec0PeA67Q6WZbN74zIGnN2rkJWiEm0unavbEjWJ4SIb0z0rnJot3lU7AwHEqU4DVMqFyXn4W8pYHn4a9o2H8AD2nBafKaMljfK88kT5B5BO2+FMxIowVTGFBdQnv8sBKBmvyWuDqxg4kRxqk2Ual9Plbjkq1EYtPoNvTu78MzfsQ2pCGGgGc5bocZfPTInGUpPDo1htoWGjst4f2FE+uhuUJaMs7YF/Jk3ZYunOofaMC37mXnipytORu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qv1oBfmmjefGB1oeqU6ZsvaRXWxvnBh91d5NtUEgh4=;
 b=XotOxw2pNyg1All9bTWb9o8GubpDnN8aua7t0PdfpIypTPSKrgAq/LqOa+/b8Java3Fb1Gdu7O/usUKOS99g8NVrQ8eEWyHBtltYq24ZvDcCWDqo6KsFkswrLl9hRbBj/2/hBQVGQNE7PDmh9TfgYcxoQmRt+U2Q6gbATeZ5Vv5TmSldK9RwOJZDd1oawcZPqxg8olq2ELYHhNLWv2EuClrMrDIok64NKy6vwivM+cUMltJ1MR3Iqj4h854OOqH1d1IYHvwZG6pF2/Xdgds3wv022zEw4sTmKf5kZszll8Q0WzbGycS4shKGZJ4akld1Zy+gmckx8Ke4bSeehIAdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qv1oBfmmjefGB1oeqU6ZsvaRXWxvnBh91d5NtUEgh4=;
 b=hwVVfqH7yiz5cDbAcK5+VQHJpZyLmiGDnhHqjJ/g/X70nVrpqCYshVdIw+VDSu5CCvLqq9lLOf0gqC3uKFLecqjgzaTn9S0ceMIZVqb5uXjRUVUhcFrRObQl28QXX4l6AU1PdlbvraADE75sZ/Kz2Zl3eSMYY+rkOWvHw4olSmUg3sKbThkRif2KTKVqR1QmbYl8oz2bm9frC/QrJM1seV6vcbXhWeJEr9TR2cHUFlb4MA7G7E5EJGEPhZGyP5bdSM7lKX4rjtAPScH/MjOtN6zowT5n7soVagh+pzPIQToBOja32nEKyHCrqLf76TThzVCnSXG6CJVnBfZBIY2qoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:16:30 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:16:30 +0000
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
Subject: [PATCH 07/15] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Mon, 10 Aug 2026 17:13:53 +0200
Message-ID: <20260810151523.86994-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::27) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 9793f6d9-df0a-4c13-2a57-08def6f25ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j+VVrd5Cg12diBz7/6W0BszLuBOfH4xnCr4YfqpSKY3T3AO/19KM38VKLHmYjb15Rj9eLDKcjTjqcp6W3YjZLg+FLgEiiMaP8N5KG+LU9FLCqij6EgFNVmz/ea4/uG9y70/i7OVvIz0EkjJzbhkgvQm2xFEjDn0V6zP1suwope9Q/V6ITODI/qrZ9c5qqASe08I7v9UGH69lAXTymTko5EEJCvta/xWH3r1Hnm8cU/b9UZeUpcAXZ86KfHWAknor6lPZCATfkXoei25oKILseWhrR+LkpR/fng+J0kuHqeeYO9GdKeOKGci6tnpl884E0uDwXMa7CIHDU1Lg7Rxe+XhZDLzd1rbuB8S4BEktVtmN+ibT6JektFeLrt+dd5p0Rn2Xwkc3jMw/Sbm9IxcofDczJxyEMS46E7lvA3o3CwiFE8BuiB8Wu3ZHFSOwSVBpVAaYknyVEfhS5j9OD0QtP/zJypzx+0uXl1aQ+4EPf3js84RfffVP8X91mbbLi31GqTMR/ObSjhhNkCoW1PJpG5LS72FqwQ2UaAgktQWU7G8ajBpCrIgHhhRV/LlHwfxxbCb9EOC4gx3jsHSiEF40dkVJS6BnpzHIu+PLzk6nyys0rznhAEu31b+wsorf16WSZHGp5nsEKBYIWU+Ybtu6c0n1e0A1/P/n5w9cnihkJ3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uHba19dysal1BJkj8CJpXaw944TUJdBa06RkyH961htVs3/J6IHtVwdF5oO2?=
 =?us-ascii?Q?ydUzrP/w/P+L1nGJPlFEnyruyRYwoQR+oLTyfJn4ZBAUKrZFUIxLiOVm3Ehm?=
 =?us-ascii?Q?KyFsvMVxdk5cqbOaX1pVfOV25XVNVUi/WoqcHSsF9VaHrgMtApWxZAg+AtFa?=
 =?us-ascii?Q?9WajENJpaYD8zcCoxl50UVdc3daTh3KP0DJPPKrb0uj1mf50PZ4HhfIPd/sK?=
 =?us-ascii?Q?hlWwaQvJxofdlsiXL0ZgHtgJa7ngdjEu7Fy7HDMQIzEnyxXcH/cemQgwtgvs?=
 =?us-ascii?Q?p9qYWoZRQMvnJ5vVDnLfQCvbyFhhhTVg7Nze4l6XmWJsaaDapCJLoCBDZUKH?=
 =?us-ascii?Q?p+uLrb+RQHxHHRDXRaunaIvJ0rVyo0XHjaSENECH6Hd3FmUfceWTSWilqLav?=
 =?us-ascii?Q?pyv9KPVAAKjd0R+HvmOGn52MI6btOZuue/5xquIa7koZ7myPZNVGZDWOspc4?=
 =?us-ascii?Q?9wFRQAHDaJTBFSosmhoKF0XKtRQXR4HHBMaHomfdN4n5w3vlnFZNHoKLySm+?=
 =?us-ascii?Q?mPPUxBXMZ3rMWEN8XZz8RLegNgaTKbHBQaBr9YpJ31+OQBYytTcmJv7QrRYX?=
 =?us-ascii?Q?bqGQtg3T2Hpu5D5vaUuys1oK0GnGBYyEGFR1kcJ4BR+2w+iBN4VgVRCVI+Kf?=
 =?us-ascii?Q?+teNFk4u7N4RtgWiho0hLkULbWBG96yv3tQ0rrMUN8xu/vTwZDFnGsX+QnPa?=
 =?us-ascii?Q?NaOckifuKGSh1zWkfpGhrKo1ffhsjL9/T0WeNYSm7+9GF9HgGveM11waEOjx?=
 =?us-ascii?Q?EjwiV9hpykIX5/303EQsIVB7IdXc0haF0a7Za8mQEKfjg6Ocod3tQEpw52I3?=
 =?us-ascii?Q?dSw3MPa7ITSvZRP1HC6369Zuq7MYDLkWktLkCZjdMnH83faD7rZiaSoHrCLF?=
 =?us-ascii?Q?XkayqY6LSb1lhnJur+PAo8q4veAD+N47/Zu4THFSyEAXcxP6Wz6jyDKfBaI4?=
 =?us-ascii?Q?IIpHFAEyezPUKl9cIirXvjBYEV9pYEtiCuXMk/zrslnEiOreAoUHWs/v+9P8?=
 =?us-ascii?Q?BoPI2bPxvr91xEKAGwBq14RYtOWoWuYGxDaghM5lEIFf7JcjopDTZpm6R+qR?=
 =?us-ascii?Q?GWcQ9PlQb2TYs3YepueyvlxPfMApdtRIDBrzVK8AYJs2nzxaBUfhV2QtPqRR?=
 =?us-ascii?Q?ZSvK34QLnMgKijVYFC+BjVWZvtob6Q4Ca7H+jlrf15iXb/49PyyrdzxlCZIg?=
 =?us-ascii?Q?4h/lWkC6z7BVn9I1ki6gx34Ip83l/jmVFissHEWxc7lGoThf5gJNEMNchd8o?=
 =?us-ascii?Q?6LZOOMAKQzrx9K1Bp1HhQc1yL02rv9VyCYjlEDJm/fFMTP+f4AgpSWyaaF/u?=
 =?us-ascii?Q?e+eNM/9lcq9ZKDgEfX5k6npntA3gJwFIorTLTMVoFjF5fav7EUES9qmNXngV?=
 =?us-ascii?Q?9ilcXWRBCXkeaexWroTifeswAuwfJ3eTna7Luhn+04lMpQqijw/TpAdr+cQI?=
 =?us-ascii?Q?DPTIWQtvQEMyQqkxDYVu6tJpoPyD5hZ27jqRmw+XnB5JYG2a7kIpY9LmRPM5?=
 =?us-ascii?Q?VHMYbLXrzUsFLwZJxvXMFmTh6RZwS9BZ5MvkYqLq8FqGYPWnUuXexccO+8nl?=
 =?us-ascii?Q?Ub2MedmIqJsqpy1QvW2JqGjySNPgzODUzHuQIi4M8muG6BMs0qlJGORudxia?=
 =?us-ascii?Q?nxsIBvAk9v6QOSTr2jqSTRKU1Etz66U8M7sEq+asyLBzoP+ku6r/tUQ88pI7?=
 =?us-ascii?Q?8WrYBkWjAsMgsGr5sESxJdWrKgVDWEQP5saS8sdnyg1okEAXuiSnsgwsdVzX?=
 =?us-ascii?Q?IwCBtpX2Jw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9793f6d9-df0a-4c13-2a57-08def6f25ad9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:16:30.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6ABh0mJHFSsIAuYP1QvlMN6ZC3e5MmSwXm9rNNVx6CbeDKSVlMClcx5nawrxv+whF7vuMYBdZKr6Jx0VIKxlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

With proxy execution, pick_next_task() can select a blocked task as the
scheduling context before find_proxy_task() resolves the execution
context.

From the BPF scheduler perspective, that donor is running while its
scheduling context drives the lock owner; ops.tick() and other
accounting must therefore remain enclosed by a matching
ops.running()/ops.stopping() session.

In this scenario, the session boundaries do not always match physical
task switches. Keep the "running" session open when the same donor
continues on the same CPU. When proxy execution migrates a donor's
scheduling context to another CPU, end its running session on the source
CPU and start a new session on the destination CPU only after proxy
resolution succeeds. This prevents a failed resolution from exposing a
provisional ops.running() event.

Track these sessions with a new SCX_TASK_RUN_TRACKED flag.

This is a preparatory change for enabling proxy execution together with
sched_ext. The explicit running-state tracking is also required by later
donor-based accounting: it prevents an EXT owner executing for a non-EXT
donor from being treated as the active EXT scheduling context when it is
dequeued.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h   |  1 +
 kernel/sched/ext/ext.c      | 65 ++++++++++++++++++++++++++++---------
 kernel/sched/ext/internal.h |  6 ++++
 3 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index a3ec980e29259..c34744c493885 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -104,6 +104,7 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 	SCX_TASK_PROTECTED	= 1 << 6, /* slice and DSQ head position protected */
+	SCX_TASK_RUN_TRACKED	= 1 << 7, /* task is in an ops.running()/stopping() session */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5efbd80304dae..0958622d4382d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2334,10 +2334,10 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	ops_dequeue(rq, p, deq_flags);
 
 	/*
-	 * A currently running task which is going off @rq first gets dequeued
-	 * and then stops running. As we want running <-> stopping transitions
-	 * to be contained within runnable <-> quiescent transitions, trigger
-	 * ->stopping() early here instead of in put_prev_task_scx().
+	 * A current scheduling context which is going off @rq first gets
+	 * dequeued and then stops running. As we want running <-> stopping
+	 * transitions to be contained within runnable <-> quiescent transitions,
+	 * trigger ->stopping() early here instead of in put_prev_task_scx().
 	 *
 	 * @p may go through multiple stopping <-> running transitions between
 	 * here and put_prev_task_scx() if task attribute changes occur while
@@ -2345,11 +2345,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (task_current(rq, p) &&
-	    (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq)))) {
-		update_curr_scx(rq);
-		if (SCX_HAS_OP(sch, stopping))
-			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current_donor(rq, p) && (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq))) {
+			update_curr_scx(rq);
+			if (SCX_HAS_OP(sch, stopping))
+				SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -3052,10 +3054,21 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	return true;
 }
 
-static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
+	if (p->scx.flags & SCX_TASK_RUN_TRACKED)
+		return;
+
+	if (SCX_HAS_OP(sch, running))
+		SCX_CALL_OP_TASK(sch, running, rq, p);
+
+	p->scx.flags |= SCX_TASK_RUN_TRACKED;
+}
+
+static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+{
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3067,9 +3080,14 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. On a normal
+	 * scheduling transition, defer starting a blocked donor's session until
+	 * proxy resolution succeeds. A restore follows an already resolved
+	 * scheduling context and can start the session immediately.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && (!p->is_blocked || !first))
+		scx_start_task_running(rq, p);
 
 	clr_task_runnable(p, true);
 
@@ -3115,6 +3133,13 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 void scx_proxy_donor_start(struct rq *rq)
 {
+	struct task_struct *donor = rq->donor;
+
+	lockdep_assert_rq_held(rq);
+
+	if (donor->sched_class == &ext_sched_class &&
+	    (donor->scx.flags & SCX_TASK_QUEUED))
+		scx_start_task_running(rq, donor);
 }
 
 static enum scx_cpu_preempt_reason
@@ -3190,9 +3215,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			scx_task_slice_ended(rq, p);
 	}
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+	/*
+	 * Preserve the running session when proxy execution refreshes the same
+	 * donor around an execution-context switch on this rq.
+	 */
+	if (next != p && (p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping))
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index b699e7c1103fc..c458a12c64574 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -449,6 +449,12 @@ struct sched_ext_ops {
 	 * Therefore, always use scx_bpf_task_cpu(@p) to determine the
 	 * target CPU the task is going to use.
 	 *
+	 * Under proxy execution, the BPF scheduler continues to observe the
+	 * donor as the current scheduling context. A blocked donor enters a
+	 * ->running()/->stopping() session while its scheduling context drives
+	 * the lock owner. The lock owner executing on its behalf is intentionally
+	 * not reported through these callbacks.
+	 *
 	 * See ->runnable() for explanation on the task state notifiers.
 	 */
 	void (*running)(struct task_struct *p);
-- 
2.55.0

