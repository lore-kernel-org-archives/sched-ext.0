Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338F423EA1
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208190; cv=fail; b=DnIdWVUaA5JqL1WJjtrNfQDkmRk46D/FEhx5Yxy2/8dLbnKyJndu52kmj4vFM3+aMsXhYJbb84A/+ga0qVMnTpsSNi5WaApQapVzYocCuJaM08XjM90UU1VnyUcz3YVdoKJDz6ABfA12y1zKFJpKk3jFXSH96t+0AAQUpmJF8to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208190; c=relaxed/simple;
	bh=Td6JF+dqAJJgJUKigjGtXhw2KBKdArdnM5JZCvPTUZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R/dNQGSYOveTYN/W8j4/lAP7OamLv14+fx7RyPzMfB8HzhjTlI9jY+DKXWeH9VGy7N1kxa/F1XIBG30VWjQ7e/sdSPp2Lv3vShEXbYPoOC/hOdMx5wS3yX0d9qHAV5EOkU3JAc9eUTrKcuR8iP6NKaJrMCJ92/O2tsEHlA6h1d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fd7XfhA5; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fd7XfhA5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpqNOK8fjUjrHeRcRCpQ1+KJXZS8ajiy1cFQ7XbbireY8UG3+hMRwiZVoblib3w6ldp/zKUv0DWPtYPHrLd6TbGBYnUbJeYhFW8VclZKTQOzrPslf7xfME06Q+fJ6x7fluSjFeFO7yOytZ8xRDTkVToMcDA/pdOBZR2tl0qsCBRGkB/bI2li8oSGHlrX+tr9werIIvMhk2g1whWqiLqN9FHvzuB5PZdkEYHRci3ANWDLKhrVBIp3h98lAx9lu5kTlk64YmFGup4+rfL3JTFdeQaKgZ/0CGgOs8DmiGi5nm2M7haPa0WN400+LctsdKkiN4Gg4gsSoGrxxQnl/gfJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi+CAfhkX8Un6lJEuLbUlPfqrDJGTkOo2GIPCdV3Rvc=;
 b=KuFBaZU3DYqpo8dFDbB9NCqg/IhuGnUbyviyNlPijyr7c0PY6dNNRNVVYQ9iYpgf0SHVl6og4LLq8/vzyqcDd7GlT4IWrlhFXYTsT5E8O6zD+foyjIbB2tMtiouWcRU1PkS5xJ1X7sbS0cOoGWGgJ1UfdfKz+5crojhHz1PEyjhsF/QW+F36/vZX6j21wVFQ6V0pgQeyZ+kIJv+Rd461e5tMXH6SiPgqpYFpd1dwe8c0XMeqY+hQamzIW0Sg4n/AaqrjC6ZT+kq0Crq7wLmmCRlSzSh21G4kOzKX94TgnLilBcERUT3t85zl/W3cTdB730KeFD4q1VtD/LC41lc8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi+CAfhkX8Un6lJEuLbUlPfqrDJGTkOo2GIPCdV3Rvc=;
 b=Fd7XfhA51sTOZfObyBiMjKvVN/qJSocSRGMf455Zdgs5V/Jxq25uuA7/rVj83C8Tvh2qTzDEDgfWlz3msPfvSvOwHtKl8NRMUg0XCBfAsbRBAeGTvoc/mihdXO2sUpdJRYekFiJNnEOTQGJqgIwLzywHLONNh0521Tn8vLgDuj7uidV6XWPg4jJOUM79CUppxpIU3ioNes1cp10HeFZJv4G0W4G3efoJt25OmiLvzOLgR7ay5KkauvI85PpJoFw9rQC5Ec9X4mXZTnQPnUtK+tcLVFjO9UbEvj9kRYy7bb4J41AL2Y2PTrQrWKzuQwC2x1NJCOM7IqKl0TlsvPfyrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:23:04 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:23:04 +0000
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
Subject: [PATCH 04/11] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Thu, 16 Jul 2026 15:20:39 +0200
Message-ID: <20260716132229.61603-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:a03:331::29) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: cb558abb-15a2-4415-b5d7-08dee33d5e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|6133799003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fHLyzRtswy7KPnaklNzG5Ur9PHdV/wjx8XHCv0LP1J8LxFX6C2JsklqhwnlZlHds2wICIUVeIUwPZ0+lDR56xM4nrIo/NSNuxutymSm/bHSwpP5cOIwqKvIGscW547bR23ZskgtXkJpFw4WdZA5oEBl0YVUqDueFRx10LNP2f/cfyHt6tQ2bJH1Zh/IDk9i9uQLfkDTGoKTl678gx+JB9Lpf41LZsHIW6zJij2yWFe8b9o6APdunBHPT0NxPnUamM55dIuOLQeYJkmj/wDE6UsUBZp/RmOjmQr61QJllnUVt/jB6GWvlj89iBXbFuc50NgCtx2oIgjTLYRbD5mmF8iIhKBsniVAkDfsR7BdFSbhsiD39O/ehiSZ7zC9k9/P5RjNR7RoMA0tcU5lufXLmT/TPSZrLKTbkq7Xb3pOfy7i9tWFTeI2FvsmCWo6AZn2qje3pznbrbUDZ/DTmicIoapO4XmzLlJi3YrX7YS0gFYWfFkHTLZPTOQNySO3BC9dve78eP+cFILTe1Xzi/PV4vm2wt8xsESvFL3fnkry2WI4GGYik/1l7EaIGGqyRdILm2bcbsd4YQZLOMACujssjl83mmjzR5yx7s9ZeM6NsX/qOD7pRs+1KF+LptPqmP9/00ReSW9z06mdPT726G5i6kIwQCIlJlInfMsTsn0eG+n4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(6133799003)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5KfjlibT6jQHZXW2UNbobCJj0Ls9RmFblGbAFR3P0ft2FxVpKloD11uzx85f?=
 =?us-ascii?Q?YcWttSJYIkBuFJbxBpBJGOMfIzqKk69mBLhuZVFQEt9PtEaB9lQy2RJjmV48?=
 =?us-ascii?Q?JGTnmQaNDdgo233SaHiYPOuGTzZLAVLBWB3MSFLyELh3bSSpQ6yON3UPYtUV?=
 =?us-ascii?Q?MwH/CJdmoe1HbCYvLrDOW5uBBWhQ+/RcHMujylu+fVdb51Nn56lGPfofE6t1?=
 =?us-ascii?Q?9m1As5+4JwOc147lQoMMfpZi7YWa+Wn6uP45Gx/5aoOscZEuRF+JFCdM4EH9?=
 =?us-ascii?Q?0ZWNryUpeXShzFUOwzWfFA+ZE7vPzVsDNWXKFGTzLEQtcynjob64iCOHRGsb?=
 =?us-ascii?Q?azXtyaHApekJcKwbOzZsLDr3zQaxEtFm4Ynqta0Tbb99gpgz9gFtMMEd2g/R?=
 =?us-ascii?Q?RtKTOw5PSoOyVGcZ0dXdcnPxW6xTxmpreOQmDCKd1QvT3zW9i+hlTeNUOFaJ?=
 =?us-ascii?Q?PlHLuxT9+IJ3s1SImrc1eGqBrskfr7qwa9CuqNSaiBeyp2Dm1jy24YLUC5Ai?=
 =?us-ascii?Q?qVjDCKj3O3q8tGV8s8eRi34OvrTRCUq6+T1BM4BWAzdpeafe6gC87PXkdz75?=
 =?us-ascii?Q?d7gH/r4u6aCDvIU1mEEOj2EWT6k18bW6SHNexDAJJRWo8XGXwcfzLGY1Xj3Y?=
 =?us-ascii?Q?1pD9K4+d1G1tSNCMBvSm2TeS52ApYeu8VA0q1AjXnB8+os1Xf8RTr9Iiw2t6?=
 =?us-ascii?Q?DKopzBK2Bx9Fx2EwOhcARPnSbpP25xyUd0PdvhAyvMauLGJNA148myFvjJjv?=
 =?us-ascii?Q?Jli01enAg/rLm2gyXIAd6YY3fs2gDHD5iFPRxD7iS9HM4qYcDlS37RhLI+LW?=
 =?us-ascii?Q?jMg2tvQPuMikQiEU5evfgK9lW8Pi4dkq+x8VEMkd9PGWRfo2Bbkv58Say/RF?=
 =?us-ascii?Q?CG30T39Abk/mAyolOsQGxbkVwT+AJmgihhoCRu8y6BysLJy6GFXAkDE1Kv+A?=
 =?us-ascii?Q?j4mQaNYlSdaC5XOt6VRRqqSqC3thNBh3bnia+0l4jPacPCaWlKE3s7wVaMJ2?=
 =?us-ascii?Q?5WEtjJijO4mHru98Cx7AjD7EDNaTsK41HQfbH+/FcObPWJrX8PgYzPqvnSwk?=
 =?us-ascii?Q?+UWWEg7H/SkoAfZTSztxgpHCW9kONlgxW0vl4Du2qYd3DaT5oKpSRIyox/fV?=
 =?us-ascii?Q?2nFCO0DXwoW01e6GSWz5Bw10nQmnSjrerMTCWwOknq1Vklx647RQ1RcQ+ekT?=
 =?us-ascii?Q?UdvsHHw036rzC5GYqrKo84Z+k9r8nmzNYPaS2Iyguf3VzI+3yESFqiq5zJX/?=
 =?us-ascii?Q?Eb8NgcvHRAqYKxBJAk6vyNHGXJSkLGv0LBZG3dtdt0s+JZu/fTDrQ9UCYEt0?=
 =?us-ascii?Q?lAW+ik4ZucF+Quz6BaLE9tmrJNfpI/cVYbTkpv64+odwflNUiiCLV/RCgeNM?=
 =?us-ascii?Q?1ixrzj60I0DfXzX0IHZ9K5daogqpjmHjxugxbsVGI8znCmcAh34V8jKGpBR1?=
 =?us-ascii?Q?rW6G5p7F0Hhivil07KRBNVEnVR+XahVCTRY3o3eDXt8M618xg+j6j7KW4d0Y?=
 =?us-ascii?Q?Ys3OsPUAM26LC/V6OX0YAN5Ux6KiJGVrTQaU8L/hy2sfr17YRlxNj+k3weT5?=
 =?us-ascii?Q?CnlNZuaj2i8IG2TdoQuAbAAYLiBjptrfhiflJJPj4Vm2Ahwq43Hgo//RC6MJ?=
 =?us-ascii?Q?hCT3Nd0FTbIZtdHgtBXpnx3UhvROH+qFs9tWr4/9WFdbKsFrIzPNXmLNG3NV?=
 =?us-ascii?Q?BAAP275eWyd936sdZLGRh5Ws/a0iUc7jAcsiD9H4d2nMN3mPXARx8qb0x1Wn?=
 =?us-ascii?Q?GXJ1mipHmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb558abb-15a2-4415-b5d7-08dee33d5e06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:23:04.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVcwReV3QL9tDzFygSYZlhO5gURnwMPsN92ktJR35uakXuPQIWpQ9Dc8cCA5ezbpNPUsn+g4CMXN9A5QQRtr6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

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
index 803da0f1e5092..5da12d6562b8e 100644
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
index cd43283e54d8d..ecef4cd9be1fa 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2209,9 +2209,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
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
@@ -2913,9 +2917,17 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. A blocked proxy
+	 * donor is also skipped because it provides scheduling context but never
+	 * runs itself.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && !p->is_blocked) {
+		if (SCX_HAS_OP(sch, running))
+			SCX_CALL_OP_TASK(sch, running, rq, p);
+
+		p->scx.flags |= SCX_TASK_RUN_TRACKED;
+	}
 
 	clr_task_runnable(p, true);
 
@@ -3021,8 +3033,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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

