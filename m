Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09115422540
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615644; cv=fail; b=nyL/T3QUGTFlE38IyCmITG/BnOzIOCpXuPgxQjExSOqXvSfwtDQarkvKZEMk+uxt3T2oBlgHJCc7w3tUxaHS3Lfy3GrDsh+8rsh5Y9dPXqyeguwWz0N++UggM9nanJk655Ls6FBkd5XTZYdzhS1kJSsNXF6kVxXTR+Pd0MJznsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615644; c=relaxed/simple;
	bh=5v70Wu6Oz4BoSuzyur5THji3m06kESqRgcbS7s4mpSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aOxwpKq2C6Bb9YdFeRt88ue6zUAj1FYCDnKuJ2N+8mVoIFv1QVLPpD3ndmZd3bUo0DydfrLMfZRj3LPEqXuOpO4sUv3/l5hXu1BQO7CaHSf7xBHEDZWdsUX2ctzWdlP27m8yZIcKIZfq+Baqv5a+Yoma05e3oX92JA2sitFX2cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ss/kXg0t; arc=fail smtp.client-ip=52.101.85.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ss/kXg0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iriYkB+z6p6V4RRRSCi+KdTTbUuux2+SylaXqZJLtu69t5vGG4DH3stRCFlRBZ0IYVTlD7g4WiZzzJmywzf6tHknXL3vz6D9F2Ad8a37OXjKfgZViAYcI9QRGYiuDfDFr/55cwvIyv4eHJe5POo1IYCEMMDTeVGvEawkoE5sehNkz0eR7TThD20WQI1yXUUKnait4eYCiAssvgZt7qeFiiBZQBpx7bqcSOniMntYq+mhBW8RGU/CpEELoSRwpkQpLUUUyK79X41LYulsUbYxdOFBNZQZ9HgnPrP0iBTbiZukRTLfGikIWDnU4Pb1yf8j0Ro/gkDuVH+TV6RJPr/drQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0mZie4D4CGEYqNzmUkrDI7ukzf6LLTh3H5KdE1C4+w=;
 b=jLKZHzA0SjFWxhurZnm1DeHXeXuLQplDDKgyFbbFceqtiquXL7cytvGq5mZ0NVCfghgDawol3CriS2sVOrRQC81NWOS/9WYJp/9C18F6eF1MxN9pM7De1x9hxeEJpUaH15c5QIviu+K9j4VGXXW9mnZW9iEQn7BKpNIt5kABtkgNnD5PdO6PSV3jVI8GcANxDvaTzwROtt/7ocCkyQVZkand4wSTX/Gued7tP1hRFTlBN/jSQn4GT2V0Tys1NbCcCQfFUlsAERF9qbDiF6QiS8DiW1GO6/OZcbNnJZUwJR+ypzNfyegJrlMimmUEMkBzcEo87w/usjvxMeRY3wFrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0mZie4D4CGEYqNzmUkrDI7ukzf6LLTh3H5KdE1C4+w=;
 b=ss/kXg0t5QpumxqUToGj+rzgq3cTEVcPVSOFdrm6rQRod4as1Jjnp9hSzfopesnJDiKjm8NdfbTf7H8uOqdYU8kTNNGs1dtv8WkyxBDhczSchj4/UXxLgd7DLLTGIuF8vjc4NASsIW7k2GgZnLp9c8pEjNP/oh3b1gjU4vgyBPIssz3OTxpwZjHM6EHVQEwAcEtH7ZoQkO7bIUWK20jlQ9Sgg+pziSJo969yA2ywA+0wHIUfTy9cspwqKKhOYRO9zE2qGkS8YK26dTpkuWAx+Nb/vitiKmzn8ZkTbKOCMxHPjA8he7x57n2fcsDTq6WwtlnRY7uu3ic4N92AZg9Eow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:33:59 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:33:58 +0000
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
Subject: [PATCH 06/12] sched_ext: Fix proxy-exec race in consume_remote_task()
Date: Tue, 21 Jul 2026 08:31:27 +0200
Message-ID: <20260721063242.552774-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0009.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::6)
 To DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 0354e2c8-da98-4a47-e713-08dee6f20a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	shPbKixSfYmgODNxmwnpW6N3lpaepdxBLVAKYsMm4IBeWYlFwF/MhJisZWFHbl5VxQZOVWAYPDw/bCaXva67raDgLyLKMIlIGJj1GjGelhNGlLuKbRzbyvZI7n7inEMyddBejY9Ode9PC/2JA9okKBydYb0N9wHowg0kmuIR7Fp8GqywssYhvow5eoXGDWaQhgvyZolEoVk/KYBCIDrpCi3ju6faqoV/yPCxajcRgJ3J0Qi+GqZ4ugggBa+h0qvEZLRoeg4iS4/kLOzgMcDNYnDLnAYN3U2N9VzPF/FM9Vio1SKOFxtId/B2qHEJ6Z+BiR3ljI5FP9DAGMNlJLH7R1Q2wtT7veepNnxy6jzkOlI36hU8QaPS3wZzJWX2sFyyThxI4fnvHUo31wBJBjon/429fZvJN2R1QKXC+tQZ8idu74oAAaXMqHr17tiGLgz7MjrPYc0IfEs1QZRD5kGieRUa7A8zJGErTq3CXSh8LQBDgejXVMGjfoJc+c2DET1zqMRe9AUqSZNlPiqN/JSuqbG9mm6Gpx17DgLBn7+EQwoQ8tqvK/OpM5cb+6BEnyYEjQXD8YIldDMvR5SXRLyp8Dg8IDfXLZVJQbzF7uEp+2F4VMrFmjM5IxsJL77heTaNBKyRJjwDjSz6vGJIhH9/5L6jfEmk/6CyHaDSn0tDqxY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PVzueXYTtYrI96X5WKr9RKwlWtO2a6wHlizoDx4UTGzes2uOugbyrjmC+2wX?=
 =?us-ascii?Q?CYOSE/Pkf9Do1BAqwiUaQnH2XCjpAdcuBvhANj2szMn9Aa2do6qt3JFyKKx7?=
 =?us-ascii?Q?X+v1RVGaHCv1O5ZRNIlVlmJXjAnitKlK+Ide6Hn+10bk3U5YEGmlIFMkZrN9?=
 =?us-ascii?Q?3chVPHPNEVw5oVp1+HcYDh6QKQvTGsgJYKUgnZ0KeqTbsSG9eFBoLnTmo80v?=
 =?us-ascii?Q?VX2RYolqx7Ie29RzSgDBi2xh36u0QzPLQgpie6I3kVzsTtXhN2C/+z3/7dKx?=
 =?us-ascii?Q?kX5dwKzBPx8M22WeAjiAIAI3MzlVG7Fqucy5GqCBiKyyMeqHnrRXmenXo4+/?=
 =?us-ascii?Q?KZdrwFShtMPacc+oOKOk4yZ7B8vCFmSH/HC+vO5psvCtVE8o+BOkVCc0Sk/E?=
 =?us-ascii?Q?xzvm97jAM57kF7hDlFeFqkEO+Csq4zmWFqLlN8jLEV5cLTqSs3D9BW5Lo+8J?=
 =?us-ascii?Q?SwPRysW6YcsAp/LTX2D8WW78jhz3d1Q5zuHXF7MmcpKOEJHE+kUYf854Jb6H?=
 =?us-ascii?Q?4/lViOWZ0vGRrlo2HPWhXNzxqS4VnxbjM0fhtKr4cn/UPuAHSyVnNuOgyUGN?=
 =?us-ascii?Q?Tg5UAG49b8rhaGQXjj1E0KHQ8qTPJcv1i0Yx4/aPlaRNyrAU+1Z/L36r/dK7?=
 =?us-ascii?Q?6cRbHGIc7ib3O41V5I8+PYiOWKJo+XBduXdWmXmNuccGQCMRUPnTkQR014xq?=
 =?us-ascii?Q?/HdhrfkI2m2cbVspiIu2pvu8LUukCZh+nZKPs4IH1BC56fr9hf18y5HXg55Z?=
 =?us-ascii?Q?xqoVHUW84ued3saM4Hc5bQKEzoIvIVDfNVgX29bKeUyKpE2x5DO2uxlVVeWR?=
 =?us-ascii?Q?tehs4iYRrsy32XQ9FzGFpeiIOG1xuVVQ2T3Vr6VhPRpoiI71dNlvbdO47JDE?=
 =?us-ascii?Q?17UENGOQgxaQ3ALBYOvApCNVjM9ywvDNvB5/PnwE/o5IWj+HpcqHuj+IdZ1x?=
 =?us-ascii?Q?4hmvZXWD5tsIaYMNfsERToo7/sUoK2idWzZzSkHHNyok6uJkYDoy/JcrCSzt?=
 =?us-ascii?Q?v8pcszNYe9j4mmXIH0ZMVtmgtDLNurjmlXIidhUmros16gcu6/uN0pRjscCF?=
 =?us-ascii?Q?hMhID+COJoYR5nxUMPLBmd9h5M2O1V9oI+hRKPJXNHWzbWYaWXwfr6pjN+Sy?=
 =?us-ascii?Q?rYMesBw27OGw3dTesVsIA7XqlNYpQ08NGMkML5uX1+SNoSCYVcXR2FJq5Ike?=
 =?us-ascii?Q?ORe3zQvNmi/l861BaWPMpDaPCf+HBho5+vYM/AN/9Sw/Mi/TYoLxdiiARkDr?=
 =?us-ascii?Q?E8u8IKhsCvV2yuOjaztUDmke/kFrRRw4oAqhRDARmLgbHzXJmZN1RVzlAODR?=
 =?us-ascii?Q?3oXqD0nMGKzuQuAdkz/ytmpMHA8lE6FClxtln7n7fAJTRNdN+LIMboOHbwGA?=
 =?us-ascii?Q?k9ioXEubw6VksfJn9Rjbqhv+ADF3K8Y7Dts+ZVpfBXLVyKVq3OSaCroWMsnC?=
 =?us-ascii?Q?f9YUo2TW6JhjuQUPn2W/0M4C3Vj2JGkpCJ5xs+0v3VqOt9+uYuuYLx/cFo6v?=
 =?us-ascii?Q?ZiaSzlgY2gVVGKg9AANT9bIIl9x3pEgGaDs6pWT3624R3Tfta8Tx8yQT9hyQ?=
 =?us-ascii?Q?k6sT0HoMaNZkEH+cKJYLh7OJgz26BK345HfYUI5fS10pwbzCg/APLR81WO2K?=
 =?us-ascii?Q?vZERqW6HMc5gbYFmHOHB3IG/o2mYcZcQyPKaF+tPSC0K9e9TyfdEDJ6zjLnE?=
 =?us-ascii?Q?/J0yelD63LyZecMN/Axx7ghz7dbdM8JrXLTveSpjJzU7yYUL87GHinOzS/Og?=
 =?us-ascii?Q?rShr22l0nw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0354e2c8-da98-4a47-e713-08dee6f20a16
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:33:58.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTVUn4NF2qhCVYCm9AUdb/+0gJ6SxLP+R4pM/nob4lHy5BCMO8qfLS6tFTIcAJzjJc3VwvN53u1NJ59gJZ1yJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

Without proxy execution, the DSQ lock and holding_cpu handshake ensure
that a task cannot be dequeued or start running during the rq-lock
handoff without clearing holding_cpu.

Proxy execution is an exception. A task can start physically executing
as a lock owner while its own scheduling context remains on the DSQ. Its
on-CPU or migration-disabled state can therefore change without clearing
holding_cpu.

Keep the existing lockless destination validation unchanged. After
switching to the source rq lock, recheck only the on-CPU and
migration-disabled states when proxy execution is enabled. If either
changed, cancel the transfer and requeue the task on the global DSQ
without treating the race as a BPF scheduler error.

A rejected task may be requeued onto the DSQ currently being consumed.
Snapshot the DSQ sequence and skip tasks added after the consume attempt
started to prevent repeatedly selecting the same task. Keep this retry
bounding confined to proxy execution so the non-proxy path remains
unchanged.

With proxy execution enabled, stress-ng --pipeherd can trigger this race
and migrate an active execution context, leading to
sleeping-while-atomic warnings and subsequent lockdep corruption.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 79 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 30d5965d09108..b5fd91d9bca4f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2372,8 +2372,10 @@ static void move_remote_task_to_local_dsq(struct scx_sched *sch,
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
@@ -2381,11 +2383,6 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
-	/*
-	 * To prevent races with @p still running on its old CPU while switching
-	 * out, make sure we're holding @p's rq lock so as not to risk
-	 * erroneously killing the BPF scheduler.
-	 */
 	if (enforce)
 		lockdep_assert_rq_held(task_rq(p));
 
@@ -2432,6 +2429,28 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	return true;
 }
 
+/*
+ * Proxy execution can change @p's execution and migration-disabled state
+ * without touching its DSQ entry or clearing holding_cpu. Check those states
+ * with @p's rq locked. Without proxy execution, the holding_cpu handshake is
+ * sufficient and this must not affect the existing migration path.
+ */
+static bool task_can_move_from_locked_rq(struct task_struct *p)
+{
+	struct rq *src_rq = task_rq(p);
+
+	lockdep_assert_rq_held(src_rq);
+
+	if (!sched_proxy_exec())
+		return true;
+
+	/* @p may be rq->curr under another task's proxy scheduling context. */
+	if (task_on_cpu(src_rq, p))
+		return false;
+
+	return !is_migration_disabled(p);
+}
+
 /**
  * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
  * @p: target task
@@ -2489,6 +2508,27 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
+		/*
+		 * Proxy execution may have changed @p's running or migration-disabled
+		 * state while switching rq locks without clearing holding_cpu. This is
+		 * a kernel-side race, not an invalid BPF placement request, so don't
+		 * abort the scheduler on failure. Fall back to the global DSQ, where
+		 * normal consumption filters can select a valid destination.
+		 */
+		if (unlikely(!task_can_move_from_locked_rq(p))) {
+			p->scx.dsq = NULL;
+			p->scx.holding_cpu = -1;
+			scx_dispatch_enqueue(sch, src_rq,
+					     find_global_dsq(sch, task_cpu(p)), p,
+					     enq_flags | SCX_ENQ_CLEAR_OPSS |
+					     SCX_ENQ_GDSQ_FALLBACK);
+			if (sched_class_above(p->sched_class,
+					      src_rq->donor->sched_class))
+				resched_curr(src_rq);
+			switch_rq_lock(src_rq, this_rq);
+			return false;
+		}
+
 		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
@@ -2527,7 +2567,8 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
-		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
+		    unlikely(!task_can_move_from_locked_rq(p) ||
+			     !task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(sch, task_cpu(p));
 			dst_rq = src_rq;
 			enq_flags |= SCX_ENQ_GDSQ_FALLBACK;
@@ -2570,7 +2611,9 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			    struct scx_dispatch_q *dsq, u64 enq_flags)
 {
 	struct task_struct *p;
-retry:
+	bool proxy_exec = sched_proxy_exec();
+	u32 scan_seq = 0;
+
 	/*
 	 * The caller can't expect to successfully consume a task if the task's
 	 * addition to @dsq isn't guaranteed to be visible somehow. Test
@@ -2580,10 +2623,23 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		return false;
 
 	raw_spin_lock(&dsq->lock);
+	if (proxy_exec)
+		scan_seq = READ_ONCE(dsq->seq);
 
+retry:
 	nldsq_for_each_task(p, dsq) {
 		struct rq *task_rq = task_rq(p);
 
+		/*
+		 * consume_remote_task() may drop @dsq->lock and requeue a
+		 * rejected task onto this same DSQ. Don't reconsider tasks queued
+		 * after this consume attempt started. This bounds the retry loop
+		 * even when the rejected task remains on-CPU.
+		 */
+		if (proxy_exec &&
+		    unlikely(u32_before(scan_seq, p->scx.dsq_seq)))
+			continue;
+
 		/*
 		 * This loop can lead to multiple lockup scenarios, e.g. the BPF
 		 * scheduler can put an enormous number of affinitized tasks into
@@ -2605,6 +2661,8 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
 			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
 				return true;
+			/* consume_remote_task() returns with @dsq unlocked. */
+			raw_spin_lock(&dsq->lock);
 			goto retry;
 		}
 	}
@@ -2690,7 +2748,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					     enq_flags);
-		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
+		} else if (unlikely(!task_can_move_from_locked_rq(p) ||
+				    !task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			p->scx.holding_cpu = -1;
 			fallback = true;
 			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
-- 
2.55.0

