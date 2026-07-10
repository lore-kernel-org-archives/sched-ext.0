Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B063EFFDB
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672787; cv=fail; b=FVtoWxrw4h4faedopk7aCDX/mc2cVUKIikw/RwP7JFNuubwiyOEPxG0Zbt+88hXDsWL+S+wdDXt8012/dCCcXf0qiZSkheXhx5SIalAcdF6iVTL1NPsy7UyXfhYRVfa5FFMuT+Kv4QWTF1FFh0zecH02Gqv3cdKwEsgKi0gHQ5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672787; c=relaxed/simple;
	bh=4T7b882NAMu/7csnp2+lnS/iRCWTEiTQomRVsmRaAbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pez016h+jVqMYRXTISkZT618e0eFECxp9Y4IhY+fPjVCMHU6SpOU/8pT7+/C3YVMU9L8h5cOMBHC1k2b04SJv7R/4UN1w+h3PMlNypmpQeJPeW1s80eekNh0jL5RwqDSzfiVOt/IgHaIvnC6Htt1UWWsof8gpAt9BPYM9x4jMZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F+EKXmwA; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F+EKXmwA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vphWKbkjLQ2Ll3+BBQOrQafRcQhes0CIP96e0wgZ5kKyo+c6jHM/dMmlPT/651XBCj/vjdxRSIGOhEdcjxbQW+pNBZ2hvukp1hyKMeuyn9zMsVhBjH7D1QTxDQGoaXxtnVYL4RZVtH9WfrnOk1nZEb+jE+CCW9wdUe5p5mKn2P4KL7myoim3qKEQ2xZUU5usdReBN7Tfp/C1CITSbZ+YGBoZcqPe3Q1UwowN6YJ5A3q/QAFAyhaFaFf7eT4Uc22n+AZgeDCf6Zkj3kVYS6yoxoL9SNtoZctVksIQJstWd30ZyvmdqImxxR17OAmouFEaFYwJ0r/PON66/z2mxNwynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7Okt/mutHVmmpGqwZnS7wYXmf670IY2MbnES/wtObo=;
 b=CM70EoBy5lqs13++lP40l/CIfKT2Jmvg0ISIOQi+rs/b0epBhazSVQyv/5dIWkz3QC9hmGOQ1HRh0ZRmLiW6tCzAQSrBFUxpwXeGpdzcV6IZun+LZzqXkt1Iz3xLYDJ9T+tQpnMnah0akeR2zD6XKAXwHOOxZuzckf1m1Q8RzDUslPXiwRWhwlohH/WclfRNONU0lijOlr+8+6HMkFsZMLsW7R6vQKa0OdeNRxSSAyf0IdY5/5eoShm1gDSXMYxd3ajEy97KzeBdADvSetPTzjKV6vKyGA0/0P22z3CIjTvUpkJadpqRIqccd7VfKCRy5lAjj0ZHxWU1jdLjccMWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7Okt/mutHVmmpGqwZnS7wYXmf670IY2MbnES/wtObo=;
 b=F+EKXmwAZl7IMvukQD+CLG5/Jc/xmtdBOXupxgLiK2ClMX6hyCR9GuGkBtab6jyNbSjIRoRuetdG2i1XlAkcSqCXBkWnthRllV3PoUQUZEs5Tp6Dz4G6vdJiV9Q0cc+17k3+2LG3FBYqS5tT46UcNAfDZXxorp1VZso4MTkCr0vZKbDQn7VArpthFmL2t5/5yEDxjUPl9LNvDS6G4CwbBFrCDY8r0RmJVLpe80bPbDHc4HgY8VYBWr+h6FWoRUSHkXbXU5p5DnoCQnNqekCeO5r5GJTV8LUdm56IRw4F461PgzffhnaGNfyLeFOhpyS3y0DWuYdi3aR0nZpQRBEOcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:39:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:39:39 +0000
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
Subject: [PATCH 02/10] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Fri, 10 Jul 2026 10:36:26 +0200
Message-ID: <20260710083913.30573-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710083913.30573-1-arighi@nvidia.com>
References: <20260710083913.30573-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44b) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a4269a-7ff4-422d-75ad-08dede5ec75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2zcwQEvCKVmiGUUYHByK+8JtWaqFioV52WNKxsKhmDVSCCFGry/tNSCjsT76nWlSSc+4MCYXcfXxlIORywUXMYpwVYuBfwneiDvjL2Ggju8BaXNZH7QVo/8/+R1LdHMWWb9A4X/n4Y0Eq3UxQ7WuHNt1C7el2TVylVCXZ50kI2Bvz7GFpgrIMI81Z9v+pAGVlGnl/zhL12XsIpc96G7hkY4aIWE+O9ayo+aU74KbGN8cnO6++3zbpHQI1ikBt8ZpmqCg1L+89K89uMTGCmmOi5xiFVZ6DvYxHuv3HH/tQvTGBdqMFEq5y3sPZW5zIoJkyG+1fcF7F7Q0PRmHXIQHxGvDrfDL5bVerRRp25j+E1S5E2qAy+G/QFqQPnFU+uUZ4N2IcfWw7gD2N/ivB77Ho0PAyO+ccd65Vy60dTV5F3DrDuXpQM69xJcKWHYh4zsPFSp02FrHKrpgBeSYlg+rozGY6fxiZL1KXviJZEBjuE4kh5iQxnHrRSiMirwMeVA6M6mwhOgFn1vZGVb6eAZ6zcYyHqwgGqP7WtOqKNV5rUW1j+cJCEioWh12Vt99eJB0Mp3dqM0QK21Z0d1TwVh/rTF8ifMzXV5mpxjvlP0zs/kTb69N74ANjJFkt1bspyRoSFD1iFwQGCc6QwcuRqW/fBsC57FZPU6mFJXB6lDvozQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BO1hXjW4W9jcODp/6MHE+SKyk/DXd0J9n2A+Kivd2+dP0f2za8I1y18Cc9rs?=
 =?us-ascii?Q?QUDMv5HxCyK3zOje0HJZXQmLYBIr4m77SUQ3Qz22rEPhwSjzIur1qRoyxehs?=
 =?us-ascii?Q?ljGnESqb/Z1orEtZFlMRTc2hvxCfao8gIaigEUXei+LnADucyx/kehIogS6V?=
 =?us-ascii?Q?R6+A3NeEdCT8TJw2CHeuU+Uc99y8IJEgOVqn5rvHOHegtgnOd9ASwjdUcQ5T?=
 =?us-ascii?Q?JrGJJU8hO/F+795DGECObqz/0GkdvUht0FGDrvwRLjuuBDu5utUvbN895YY4?=
 =?us-ascii?Q?S3V2LugTrq7BfDpzI4LaAR8bnLqc10vSlzMQY6U7xtH00W2xsn6HSEi4Qs1V?=
 =?us-ascii?Q?E2OatuAFdAqZ0KuGYdggyRoQuSw/DZWjnWhSyfKBwnIEuAHGjf5sTmSqsq+C?=
 =?us-ascii?Q?qWn41Mzc4PKnSxSWVXDL0AmY8VaEMwedPRpoMdGHqDx6fYIArvrRh5Avc1rd?=
 =?us-ascii?Q?1TRshN5y0t5CKDQDduECuyo5FBhb2ApzrPICjnOp2s5iQm/Xp8/YJ6o5+krG?=
 =?us-ascii?Q?cau3pYY3G5QREKGSGY3uHaivh7E4AmyGG14RtPPDLjpwZ5hIaFpQEyh36VSz?=
 =?us-ascii?Q?MDDPoFwjHOLB4giS9CzOWDQbpyCCogG/fm7UjKZf6/51E4hBrbvo6nuWs/iF?=
 =?us-ascii?Q?9gg1QNykpCYmbfggaak9sYi0bYRmTvlpqbH2dIjST0m9WboWl0ymwkINzRNm?=
 =?us-ascii?Q?N7MvpweHfHNfW3STdj1wf8WOK+mX1yCMZIKXuNvBKJ+QibA4sARkBsT+4yet?=
 =?us-ascii?Q?J2X6bb4eUUCTfYOmTZTr6FSqinZpmLA1xOoneJvWvNL4zUk6vZHNhrHkOLmV?=
 =?us-ascii?Q?IvjldPOD18Jh4Y04DFNMTg1ej6s/Fj+405OeP5HcbaGYucEuuRl7SNGkwtTF?=
 =?us-ascii?Q?z2KUlWgaqTvi1hDWyFJN1zmj/3RlFJlW23maKwz/VK8h/dz4K/jRVSbl/Nl1?=
 =?us-ascii?Q?sFoNJrqc5wvz0gvj6RYrv9p8kmNf8InE4S8MmnDZq2qQwmQpNFVul1FvrQcS?=
 =?us-ascii?Q?5E5vUL8DmFGz86f2PDy86wZl2FCAMFx+dXTsdLDxY8t3wQFUWWGpf7EfieDq?=
 =?us-ascii?Q?9DuqDVHWN0B24/nfoJwO9qXGADRQvVlAGdY9x+9XTiQyObwSBIL85j9CAXC8?=
 =?us-ascii?Q?PcVOM1veyBXcekawP4xrViGuty/n64l2HCt1mMIHr2LOFLHtpaWQi6LjlR4f?=
 =?us-ascii?Q?2KCZBnBD3/lCeaFkPsGRFFdvYCX54BIJIQQ2Mh69NlR9RuJ05XXPAB/vNSg1?=
 =?us-ascii?Q?7yb1AQ9Ryp1P+weppXRkrO60I6SCsTcBq0QtQHcrF87sYNxfEptbBDYCLGBd?=
 =?us-ascii?Q?UUMELT1Gncz4c5l1yMndzPk/ymHNHCpSiQnSnoobgZ4AHyaBUYU+Y4RAq7P7?=
 =?us-ascii?Q?K7FkukXP2xw/n4c4QSJJXkggitegoSxSObTqrEfOkShAohdMBQvGgbHNNaen?=
 =?us-ascii?Q?o7w2SJO9rN2L6ON6nAau4sgJ9Wa2TrCWZFWl2KiVbsNrNeXo8f+IEh3rQoPY?=
 =?us-ascii?Q?SaVMM8WrpZWTZ1hcHoIo7WsXKVV4ALo5ABadw1ENC2+O3EQTZy/onXNhF2qc?=
 =?us-ascii?Q?ZefJZ5TAx0ourqbZDZhhcadJjA5VgiIk/6igWHZAngpYgEQcx7L6NaclTVj3?=
 =?us-ascii?Q?2kOjqFRwykJXcNpqoJOXZUApG/CnE7ZrBqbFq5ALIJHg4MJk0Z+ZV1jraUR4?=
 =?us-ascii?Q?XQARmUH0sKQRDyWeico4RjNl152mzODtralIzzF3O2abCK8mUJxlk6fA9XVv?=
 =?us-ascii?Q?DSYsiLSFiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a4269a-7ff4-422d-75ad-08dede5ec75b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:39:39.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj+2zKoteByUAc4Lg1WoTrpbBfwSp8VdvC9VEBShUDM8Lw/uWriGm2qxFqYXhmNLzb/dB6YjZnmZJunpEozsOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

With proxy-exec, pick_next_task() can return a task with blocked_on set
(a proxy donor). put_prev_set_next_task() then calls set_next_task_scx()
on this "ghost" task even though the task only provides scheduling
context and never actually runs.

Calling ops.running() for such a donor produces a spurious running
event. Simply suppressing ops.running() is not sufficient because the
following put_prev_task_scx() would still invoke ops.stopping(),
resulting in an unpaired stopping event.

Introduce SCX_TASK_IS_RUNNING to track whether a task entered a real
running transition. Set and clear the flag independently of
ops.running() and ops.stopping(), as the callbacks are independently
optional. Invoke ops.running() only for non-blocked tasks and invoke
ops.stopping() only after a real running transition. This keeps the
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
index 75cb8b119fb79..c6f58e1a66cdb 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -102,6 +102,8 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
+	SCX_TASK_IS_RUNNING	= 1 << 6, /* entered a real running transition */
+
 	/*
 	 * Bits 8 to 10 are used to carry task state:
 	 *
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5241b55a58eca..6b7efb19d2843 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1989,9 +1989,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
-		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current(rq, p) &&
+	    (p->scx.flags & SCX_TASK_IS_RUNNING)) {
+		if (SCX_HAS_OP(sch, stopping)) {
+			update_curr_scx(rq);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_IS_RUNNING;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -2686,9 +2690,17 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. A blocked proxy
+	 * donor is also skipped because it provides scheduling context but never
+	 * runs itself.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && !task_is_blocked(p)) {
+		if (SCX_HAS_OP(sch, running))
+			SCX_CALL_OP_TASK(sch, running, rq, p);
+
+		p->scx.flags |= SCX_TASK_IS_RUNNING;
+	}
 
 	clr_task_runnable(p, true);
 
@@ -2791,8 +2803,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+	if ((p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_IS_RUNNING)) {
+		if (SCX_HAS_OP(sch, stopping))
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+
+		p->scx.flags &= ~SCX_TASK_IS_RUNNING;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
-- 
2.55.0

