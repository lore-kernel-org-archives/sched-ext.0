Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229443B14BD
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901910; cv=fail; b=i6Xv4Pa8gBrwkekcEHK+ObKjAnOphZz1w38JPN6ZB+7lUVx133n9N1HgOCp72/zHjPIfn5thvr3a2+DqbonVmU59PgkH6Ny1enyg0A5hFw/xVUUWZjItwlPnzvErVAq7zc4qTMAt6jC4yDXm/QGLJEP1phxGucEwaDNCP52F5h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901910; c=relaxed/simple;
	bh=wxv+max/pkFN6RiLYuQt9OhuVViAF2/SkFIkSa4TuB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gwd3wfdvuvCD+N+tqBzqSMORL+4RH9vhUvl7FTQhj72LkIfbuMn8VV3otWCPHjwuyAulBEkQWXnTmLhf3fJ7RjtikYT6xZDXI3ugmQ1cNgq6+EW62U0cyyTrBSSWVEq6d0AwKPt/SLhotjMb4sgqDPflIwRP9gheTaS4WRz3X34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ix45Arb9; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ix45Arb9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEO9QEHezkrwDDGMRK1GccgFSU3zztAXDaSBwzGr6mM8JLLYg9qRTJhOP0zNAatjq7QtiC75NIZsjZXKM08vVOFxCSHIwwPbGyDPg4S+bn6wlCIeeTcwwlgGbKdYYSISpIt9MSF7r0/HnudnEGeGMDHDNeuHRH1x6SaTOvNSV+U8R/gmbna6Fhh+KqwF9eX7J/toJlEiOa3sNg0FjFqzXEl6kIjj9s7gUhootV8Ak4Ggqvu5DwAgeeTWa6yVpSX53mxqdZq5HemrvtiA68O2XuqtZcM+kPJzdws1TvSqvCay2OPk1ic5fqVzc4eUI+RQHFYCH1uv2sav1o3iMuUMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7CVpnJsph6Tny4tvrDU5m4tz5JyZwVVd5eRGFMbbmA=;
 b=V7J19PrixYE2TVo2rbq3HRTsGp5xpbjdOPrgxAdH7NA2ogu1gnDHR2AXJYVNgX6Ug3NmHradnEvoVIaPBNGOvLbT+BfUVVXsO0GbOJGBkBGX50WWGlURVflNI1Nuwd0emEOEzhamk8azQZlhXOm9RYH4xUFTExh0na26OxXMp/QKNqEtMkiF1YDXCovXc9oGBHhw7tjKfXOpTCZICuc/C+xhSb7nF4451h+ylMsggNQqCDz8G9rFwLDYA8UgSvHmII8s6jUnAGgFApnKv8ZNRbd2HrriV8dXEL//rrwKkGbioL1NUoVRHT9nn4u62vovJf/HJzyOXJ3+axPj9kOG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7CVpnJsph6Tny4tvrDU5m4tz5JyZwVVd5eRGFMbbmA=;
 b=ix45Arb9KDqistJfYfGTvCLJHSyMf1cWRuA6Jy6qV4a/elkqg7p3fKSzONlCCCyCIEiWHZnCMXAAViWxSMC3f9mbKqQYvKQozz6efohPijmuISBBiIW02Vl3902d9Z64ET37GknzDDJ++AsCIURomZtGnf3gHMPkk+pPzjhSVB0NB+a9PC7lKclGQIYS3A99sVwVq4bplGXbiN778DceOMVY5Wn6kZ1gljPobaSHTDM3NiQShCRAslBf/NKgl73gbjBDl7x5VLjKhqN55gLs3SeaqJmiGXHoOR9frZmgElfmjAo0jyOcqJnPpIFgqjF29Ov0zk/fpcKw9Stpe4jqRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:25 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:25 +0000
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
Subject: [PATCH 12/17] sched_ext: Handle proxy-exec races in remote DSQ transfers
Date: Sun, 16 Aug 2026 19:35:10 +0200
Message-ID: <20260816173732.17162-13-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6f1935-10a8-46b4-7bcd-08defbbd2c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	HwiP2BjaYkGlQxi/xotmSSAfLJApaXKKiUjOVwM79ybNk9cj630hoOXI53YKaeaayAafTF4IvJRy+ryR2ZiF/8HbvU7n2k379U9VHeyBsI5OY9vE5XAgwbRSPyNzeNsPFJAeS2brOGlbIyWyhnyBXZCY8JAkBtAkd2FbXfOADNbcGrSWx8C+ys7AXmETX1Msd7hAoQr8+m+QDKnaeA1Z56tujZKq8TwcNvx1k+WzLllDqwCtD0uRUNHEIpBOHyplMcGMlO7wAgalH05mgKvba9pRC6DQDqcT/pequ/4KBxLLfqi3kQtx7ETav0AGtv6KFYmyxSjEDBFybq2lgIb+7QSli8YYqYyXYCldVYLXdZPDr9TAhwwHjiUXT4RF6LRER9DXr54JAMbAAR1kNyP4FxzXqfgpZKKZHHZfriFUjCGUUgJCSJ2BfvAT+Rq2mnKgBQ1bmN1UMcqudi7DyH9Ak0tv2xBn661rf0pl4mUv7NortK53XzZvHS/B5Q6ZV05kYWQodgFwbVbhltNc4THRP//E1kytciUXRGj79LvmQj86ZgXER8jwY8LFy7R5+8+VWy22WAiAEu6taCIKmI1bpZYeiV4fWV8Urd0x93lcDGjw8jRFHCy4Ab5iDj/KeV6mBmZ8ayLrGfd/Rpm0TgC6/gtuwpgCu9RQZVzD1PMAIyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UYwEqcy1p0cStl3E+cPInu4k0ztlEeVPk5WEVO3+/hsJIcCe5+9a5949IioM?=
 =?us-ascii?Q?VbD2wqF/oZ2LXwuVLdnnkZwvs9pDuNT5ot6DWdPVucE5tafX/jQ7vVFJwgWe?=
 =?us-ascii?Q?YPs3z3f0SR56UwPrxcCXnPJv3eaZBCKplu2ErMHOTeXbEJ2qRDgi82LZrSlY?=
 =?us-ascii?Q?6tnOkziNAjLDjzJnCgU6OIfaEisPQHRM86cWD0bvw/j7Ifj9P5b8zEWqWLQO?=
 =?us-ascii?Q?w+Jj3rjGwufRdvLALSOsK8bAM515cgWm5+dCplbjHzRU3hUVrDO1CV1N9sEx?=
 =?us-ascii?Q?jVmsc2shiZkfqmCjvuvKro6mDBEb1+elaSE8NkU4+s5H+ocq6ej4Wtl2bUnC?=
 =?us-ascii?Q?pfmvFSP57FYEAhFZp5Vbo/uF6E4rm+sc2IJVz4CROAhI5fN5eylZcXh2D+VU?=
 =?us-ascii?Q?t4bZNr8QfxtUmbvxpeLFRmgHVAyQZz7TftYp4zrNlvm+ARTyEeNFc2x8NFV6?=
 =?us-ascii?Q?MMPoHrQ1uqSJEYfla0cXgrpWRFk/eOx39QWh+yHbcsxvLTGieIbx7pXCNZx2?=
 =?us-ascii?Q?nQ7Qb37MHVNvfwQH1BiFS17JfTT4uE3wv3CirQztwjalAmPWNnCAyeYRD/jb?=
 =?us-ascii?Q?JyaceIwvvkQJDvEgtPgQkc3UmTW0n4ctUyVird6N5XaBA/krpq0bTDmVUW7/?=
 =?us-ascii?Q?LXSJuOjMntva5AoQEaKdCZYOR8RlE3m07T6AUykel75x9gs0wOz0N+W9c4Rp?=
 =?us-ascii?Q?4N4Vedf+M9uQs0ZWJDGdimk1QOQeiHkSA75dld9xqnFZOMFBAUKQRlqYiVuB?=
 =?us-ascii?Q?kPDAXMZNLJUdkV8nTy4pZqk5u5RAQXudZoJrt9BNL74xqQWcLhdYnTW60jGI?=
 =?us-ascii?Q?+A96EXMYYMaucRWXVNAyzhwcca4EHhhAywOUISQUTLbh+OFpEQq60KbRaqXQ?=
 =?us-ascii?Q?rXL94Id7A4tTSs/Up4hoCCUAfBS1zL7+zq+9kOdlDi1l3Z5gezfqD892OkGq?=
 =?us-ascii?Q?eabf+VppNljkX/sEDIRX6oJXzi1L1Cu4bvubatBLOmJPptx9Jvw09uloKeXs?=
 =?us-ascii?Q?UoxULJFrwso9jj7KxfgbYVCZ00pImBaDfzxv9QRgdpBmoF9IFdjKsXI6vSAO?=
 =?us-ascii?Q?hSoUZB61L3aiSui1ZIEgw7yI4G17f5xwW4bVQcyMXZ46NfDm7vARa4sWNk0S?=
 =?us-ascii?Q?G8WaFnQ/szkGwmQr4Jll2+Q4cq0MdkFLfhYd/bFIuoXD7gWudOdoKZWcYm/K?=
 =?us-ascii?Q?uIjuVzGG7uCupW0JG9CxqYSrrjMJVfZoeNL1AI1Kz7AUXpVJmOugFAx+2M9U?=
 =?us-ascii?Q?yWWSXPBTlXf1IVVqaqroRJfyGo+DLrAnGhQDku+AELPDNAGez/ypyKQslGMq?=
 =?us-ascii?Q?2yO17bKe9RDT7ydYC++HPSq6gSsF8yWeTruYttcomm8LNjOKTADcGPLs/2Fb?=
 =?us-ascii?Q?fLcyYTmYEnfPCYptLB7VnGbrw2gl7dcEeJ/kWs9Kj5dDXYRt0R8gKpVn2xzE?=
 =?us-ascii?Q?EjjqqlML+AFurmEYW3jxb/OWehRXmzytmC+F0/+vPRGJAkiuIKkyMCByXBAO?=
 =?us-ascii?Q?Xoglicu2dDCyuKnQPeRjzRGYilXtRdwjzNfZFrAdj5lwGcqwbDqTc3UDkToL?=
 =?us-ascii?Q?xkOg+iB14MEXQLtIKcDG/4rkdGAQ1jMerRdEmxDMTZJttQEQPWe3nKRrigfc?=
 =?us-ascii?Q?W85lBE2On93juNqLHggM+dqbzFVxn9KTwkW8UKl/852rwHpkKJPKcHHil1/l?=
 =?us-ascii?Q?FVKlIZ90W49nYYI7ENmZapeuUgS9oEKAk3TMaVkIIYjn5tVqIrP24RX6pXDR?=
 =?us-ascii?Q?GmvKP56WjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6f1935-10a8-46b4-7bcd-08defbbd2c7a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:24.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+6f67ESVaEfJU6xAekbFMGjHJt/6iDlsXxDNPd7VDePvcIbH+QBDH8TI5CU5OpwSlPjl+bmMOeCkZNL9ilcWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

Without proxy execution, the DSQ lock and holding_cpu handshake ensure
that a task cannot be dequeued or start running during an rq-lock
handoff without clearing holding_cpu.

Proxy execution is an exception: a task can start physically executing
as a lock owner while its scheduling context remains on a DSQ; its
on-CPU or migration-disabled state can therefore change without clearing
holding_cpu.

Recheck these states after acquiring the source rq lock. If the transfer
can no longer proceed, park the task on the source rq's reject DSQ and
re-enqueue it through its owning scheduler. This preserves the BPF
scheduler's placement policy and keeps descendant tasks within their
sub-scheduler's cap grants.

Implement the scx_proxy_resolved() hook to drain the parked tasks once
proxy resolution has settled and the outgoing owner has switched out.

Without this change and proxy execution enabled, stress-ng --pipeherd
can trigger this race and migrate an active execution context, leading
to sleeping-while-atomic warnings and subsequent lockdep corruption.

This is a preparatory change to support proxy execution with sched_ext.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   2 +
 kernel/sched/ext/ext.c                        | 168 +++++++++++++++---
 kernel/sched/ext/internal.h                   |   8 +
 kernel/sched/ext/sub.c                        |   4 +-
 kernel/sched/sched.h                          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 6 files changed, 161 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 9912ad0c2d445..55c2665a6d37a 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -137,6 +137,7 @@ enum scx_ent_flags {
 	 * IMMED	reenqueued due to failed ENQ_IMMED
 	 * PREEMPTED	preempted while running
 	 * CAP		sub-sched cap miss, see p->scx.reenq_reason_*
+	 * PROXY	proxy state prevented a remote DSQ transfer
 	 */
 	SCX_TASK_REENQ_REASON_SHIFT = 12,
 	SCX_TASK_REENQ_REASON_BITS = 3,
@@ -147,6 +148,7 @@ enum scx_ent_flags {
 	SCX_TASK_REENQ_IMMED	= 2 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_PREEMPTED = 3 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_CAP	= 4 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_PROXY	= 5 << SCX_TASK_REENQ_REASON_SHIFT,
 
 	/* iteration cursor, not a task */
 	SCX_TASK_CURSOR		= 1 << 31,
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 59261218ba37b..7fdf16886eb27 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1083,8 +1083,17 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+/*
+ * Proxy resolution happens before rq->curr is switched. Queue deferred work
+ * on the rq so that an outgoing proxy owner has cleared on_cpu by the time
+ * reject_dsq is drained.
+ */
 void scx_proxy_resolved(struct rq *rq)
 {
+	lockdep_assert_rq_held(rq);
+
+	if (rq->scx.flags & SCX_RQ_PROXY_REENQ)
+		schedule_deferred_locked(rq);
 }
 
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
@@ -1530,12 +1539,17 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	call_task_dequeue(sch, rq, p, 0);
 
 	/*
-	 * Only local inserts get the wakeup treatment below. Rejects kick the
-	 * deferred reenq and rescue parks are paced by the rescue timer.
+	 * Only local inserts get the wakeup treatment below. Proxy-active tasks
+	 * and rescuees remain parked until their respective resolution paths.
+	 * Other rejects can be reenqueued immediately.
 	 */
 	if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
-		if (dsq->id == SCX_DSQ_REJECT)
+		if (dsq->id == SCX_DSQ_REJECT) {
+			if ((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) ==
+			    SCX_TASK_REENQ_PROXY)
+				rq->scx.flags |= SCX_RQ_PROXY_REENQ;
 			schedule_deferred_locked(rq);
+		}
 		return;
 	}
 
@@ -2479,8 +2493,10 @@ static void move_remote_task_to_local_dsq(struct scx_sched *sch,
  * - The BPF scheduler is bypassed while the rq is offline and we can always say
  *   no to the BPF scheduler initiated migrations while offline.
  *
- * The caller must ensure that @p and @rq are on different CPUs.
- * If enforce == true, caller must hold @p's rq lock.
+ * The caller must ensure that @p and @rq are on different CPUs. If @enforce is
+ * true, report violations attributable to BPF-directed migrations. The caller
+ * must hold @p's rq lock to avoid reporting a transient race as a scheduler
+ * error.
  */
 static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 				      struct task_struct *p, struct rq *rq,
@@ -2488,11 +2504,6 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
-	/*
-	 * To prevent races with @p still running on its old CPU while switching
-	 * out, make sure we're holding @p's rq lock so as not to risk
-	 * erroneously killing the BPF scheduler.
-	 */
 	if (enforce)
 		lockdep_assert_rq_held(task_rq(p));
 
@@ -2539,6 +2550,66 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	return true;
 }
 
+/*
+ * Proxy execution can change @p's execution and migration-disabled state
+ * without touching its DSQ entry or clearing holding_cpu. Check those states
+ * with @p's rq locked. Without proxy execution, the holding_cpu handshake is
+ * sufficient and this must not affect the existing migration path.
+ *
+ * A BPF-directed transfer to a remote local DSQ performs a normal task
+ * migration and thus cannot move a migration-disabled task. In contrast,
+ * proxy_migrate_task() moves only a blocked donor's scheduling context towards
+ * the mutex owner and preserves its execution home in wake_cpu. The latter is
+ * therefore allowed even when the donor is migration-disabled.
+ */
+static bool task_proxy_move_active(struct task_struct *p)
+{
+	struct rq *src_rq = task_rq(p);
+
+	lockdep_assert_rq_held(src_rq);
+
+	if (!sched_proxy_exec())
+		return false;
+
+	/* @p may be rq->curr under another task's scheduling context. */
+	if (task_on_cpu(src_rq, p))
+		return true;
+
+	/* Don't move an active scheduling context off its source rq. */
+	if (task_current_donor(src_rq, p))
+		return true;
+
+	return false;
+}
+
+static bool task_move_proxy_raced(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+
+	return task_proxy_move_active(p) || is_migration_disabled(p);
+}
+
+/*
+ * Park a task whose remote transfer raced with proxy execution. Reenqueueing
+ * from the source rq makes the task's owning scheduler choose its placement
+ * again and preserves sub-scheduler containment.
+ */
+static void scx_reject_task(struct scx_sched *sch, struct rq *rq,
+			    struct task_struct *p, u64 enq_flags)
+{
+	lockdep_assert_rq_held(rq);
+	WARN_ON_ONCE((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) &&
+		     !(enq_flags & SCX_ENQ_REENQ));
+	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+
+	p->scx.holding_cpu = -1;
+	p->scx.flags |= SCX_TASK_REENQ_PROXY;
+	scx_prepare_dsq_divert(p, &enq_flags);
+
+	scx_dispatch_enqueue(sch, rq, &rq->scx.reject_dsq, p, 0, 0, enq_flags);
+}
+
 /**
  * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
  * @p: target task
@@ -2596,6 +2667,20 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
+		/*
+		 * Proxy execution may have changed @p's running or
+		 * migration-disabled state while switching rq locks without
+		 * clearing holding_cpu. Park it on the source rq and let its
+		 * owning scheduler choose its placement again.
+		 */
+		if (unlikely(task_move_proxy_raced(p))) {
+			p->scx.dsq = NULL;
+			scx_reject_task(sch, src_rq, p,
+					enq_flags | SCX_ENQ_CLEAR_OPSS);
+			switch_rq_lock(src_rq, this_rq);
+			return false;
+		}
+
 		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
@@ -2626,6 +2711,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 					 struct scx_dispatch_q *dst_dsq)
 {
 	struct rq *src_rq = task_rq(p), *dst_rq;
+	bool proxy_raced;
 
 	BUG_ON(src_dsq->id == SCX_DSQ_LOCAL);
 	lockdep_assert_held(&src_dsq->lock);
@@ -2633,6 +2719,19 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
+		/*
+		 * Unlike the rq-lock handoff paths, @src_rq has been locked
+		 * throughout this operation. Only active proxy state can race the
+		 * move here; let the enforcing check below diagnose an ordinary
+		 * migration-disabled task.
+		 */
+		proxy_raced = src_rq != dst_rq && task_proxy_move_active(p);
+		if (unlikely(proxy_raced)) {
+			dispatch_dequeue_locked(p, src_dsq);
+			raw_spin_unlock(&src_dsq->lock);
+			scx_reject_task(sch, src_rq, p, enq_flags);
+			return src_rq;
+		}
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(sch, task_cpu(p));
@@ -2788,7 +2887,9 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	/* task_rq couldn't have changed if we're still the holding cpu */
 	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
 	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		bool proxy_raced = src_rq != dst_rq && task_move_proxy_raced(p);
 		bool fallback = false;
+
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
@@ -2798,9 +2899,13 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					     slice, vtime, enq_flags | SCX_ENQ_APPLY_SLICE);
-		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			p->scx.holding_cpu = -1;
+		} else if (unlikely(proxy_raced)) {
 			fallback = true;
+			scx_reject_task(sch, src_rq, p, enq_flags);
+		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq,
+							       true))) {
+			fallback = true;
+			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
 					     p, slice, vtime,
 					     enq_flags | SCX_ENQ_APPLY_SLICE |
@@ -4682,41 +4787,64 @@ static void process_deferred_reenq_users(struct rq *rq)
 }
 
 /*
- * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
- * scheduler chooses placement again.
+ * Drain ready tasks from @rq->scx.reject_dsq and reenqueue them so that their
+ * owning BPF schedulers choose placement again. Proxy-active tasks remain
+ * parked until proxy resolution schedules another drain after switch-out.
  *
  * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
  * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
- * scheduler. The private list below prevents a task from being revisited in
- * the same round.
+ * scheduler.
  */
 static void scx_reenq_reject(struct rq *rq)
 {
 	LIST_HEAD(tasks);
 	struct task_struct *p, *n;
+	bool proxy_pending = false;
 
 	lockdep_assert_rq_held(rq);
 
-	if (list_empty(&rq->scx.reject_dsq.list))
+	if (list_empty(&rq->scx.reject_dsq.list)) {
+		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
 		return;
+	}
 
 	/*
-	 * Move tasks to a private list so a task re-rejected by
+	 * Move ready tasks to a private list so a task re-rejected by
 	 * scx_do_enqueue_task() below isn't revisited this round.
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
 		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
 
-		/* migration_pending tasks should have bypassed to local DSQ */
-		WARN_ON_ONCE(p->migration_pending);
 		WARN_ON_ONCE(!reason);
 
+		/*
+		 * The affinity machinery owns placement while a migration is
+		 * pending and will dequeue and reactivate @p as necessary. Don't
+		 * return it to BPF in the meantime. This isn't a proxy-resolution
+		 * state and thus doesn't contribute to @proxy_pending.
+		 */
+		if (p->migration_pending) {
+			WARN_ON_ONCE(reason != SCX_TASK_REENQ_PROXY);
+			continue;
+		}
+
+		if (reason == SCX_TASK_REENQ_PROXY &&
+		    (task_on_cpu(rq, p) || task_current_donor(rq, p))) {
+			proxy_pending = true;
+			continue;
+		}
+
 		scx_dispatch_dequeue(rq, p);
 		p->scx.flags |= reason;
 
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
 
+	if (proxy_pending)
+		rq->scx.flags |= SCX_RQ_PROXY_REENQ;
+	else
+		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
+
 	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
 		list_del_init(&p->scx.dsq_list.node);
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 2b2dcde923600..8b0be25cda7d0 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1758,6 +1758,14 @@ enum scx_enq_flags {
 	SCX_ENQ_SLICE_DFL	= 1LLU << 62,	/* carried slice is a default refill */
 };
 
+/* Strip priority and carried slice state when diverting from a local DSQ. */
+static inline void scx_prepare_dsq_divert(struct task_struct *p, u64 *enq_flags)
+{
+	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
+			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
+	p->scx.flags &= ~SCX_TASK_IMMED;
+}
+
 enum scx_deq_flags {
 	/* expose select DEQUEUE_* flags as enums */
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 26e0acc65618c..8a7b712228bad 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -735,9 +735,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * or HEAD - a diversion has no priority and IMMED is not allowed on
 	 * non-local DSQs. Strip the enq and task flags along with the slice.
 	 */
-	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
-			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
-	p->scx.flags &= ~SCX_TASK_IMMED;
+	scx_prepare_dsq_divert(p, enq_flags);
 
 	/* the enqueuer opted for rescue instead of rejection and reenqueue */
 	if ((*enq_flags & SCX_ENQ_RESCUE) && likely(scx_rescue_bw_1024)) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e7a82eed59a4..2a9f42a43b332 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -788,6 +788,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
 	SCX_RQ_SUB_IDLE_RENOTIFY	= 1 << 7, /* sub-scheds are owed update_idle() */
 	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
+	SCX_RQ_PROXY_REENQ	= 1 << 9, /* proxy-rejected tasks need reenqueue */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_DISPATCH	= 1 << 17,
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index cccc0c3987b85..b1351f346e1d9 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -119,6 +119,7 @@
 #define HAVE_SCX_TASK_REENQ_IMMED
 #define HAVE_SCX_TASK_REENQ_PREEMPTED
 #define HAVE_SCX_TASK_REENQ_CAP
+#define HAVE_SCX_TASK_REENQ_PROXY
 #define HAVE_SCX_TASK_CURSOR
 #define HAVE_SCX_ECODE_RSN_HOTPLUG
 #define HAVE_SCX_ECODE_RSN_CGROUP_OFFLINE
-- 
2.55.0

