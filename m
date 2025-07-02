Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB92FC3A1
	for <sched-ext@lists.linux.dev>; Wed,  2 Jul 2025 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499022; cv=fail; b=Di0Ss8lhh6IbCgmIPuFGjVz8VhD8Qm+jT/vTtf0L6HMkU5NioGY9gAesYL+Ic+BsZjtSACCmbu5TApq2vituSR8cf5UJk69HRqcwAA1ZHOuznjww9KWvixfAs2NXneu6OH2r0R3/gUFqIwguG+1kFYu3rlMzgCciMoCsuS2EOIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499022; c=relaxed/simple;
	bh=HMUplUkaJVV3VEe15ExKiFV3uay5VBF8Pp9zwxdQ+LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJZKbvRqtxp8rHk3SqAWtekicGEQSgLNiDnUzYEAsRWWLWHSt7fBiNmr2Wpcik1fyNgAMZjm1w8idGL17+Ph8xTuDvR90+M9RhjstU1gk/rOKupkM6CEDY6Hrakc+KkrmY2Fbkb0+pqtkKIgKAolmyy0PyCQvFI/UcKpSMeoYsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8jwIeHX; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8jwIeHX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU6VS5kXDPaOQUVDQvhc5R35zOVfZV5ZDeln6ZicT/ACtAEgl5OdwrORCEGtFWazjzGkK+2QnCCzSYB0m5RLbZlfXmmWYzaqIKGdYRLgMvDJee/IakUcY8+O4VfBLSchdEu3fhhgIIffHv7msBkpQlLOyIAwa1HjHSwTdDKBfgrdbPCQNhY9FrrYOqBdSa9pet6zY+QZajrLdCU7t2eHOqPxl1vcvg2/0ikbawwBbgQlgtZooToDH3PTv0SvHRijPGF2iebCByqIpPkDtdUmAQr9OLBUtY6zxzYIq105QvL0uF13YRdISMELnRvwBpJYpr1bandwQwmc7XKeCsHEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV4Q1pr/qC6UfMYTBnETUZ9BJUuuuaO7hRDHc4CBZFU=;
 b=OooEeWWJKf+xnuKDODWcrwHig4IG4+JwlR3xSNjtRmpAscwaoi3vbDTI6rYD9/PH214mhFknUB2hMsDnvW6YrX1NFasIf+FMpUPKHnltZnWQR1904YBwL58bmCw49UJPL6TSenLlGvE4mBoHSn0LTSBUHeXYxVFefmFrHa52YQLLEWII6j6bGSbd9ltxGZkWS+Ey3ECV4AJunfqreeMF0zUGpcNFsWLf/EOKsLeg9FxFaHhOnhouXG6vwZa6pF6+/Q3+BOR7DTdXkBFyMZdKDV12SPzNXz6LgbL+iYZslMaNlSNHaFPOi3vzqG6c5+JRaM2BoF0Udt4yowLaq+dYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV4Q1pr/qC6UfMYTBnETUZ9BJUuuuaO7hRDHc4CBZFU=;
 b=t8jwIeHXAgBfZP9bYk+I99dNuoG2IA6irnqS4dFDL4iMt11UK/5uiIkCYrbaGc5impWR2MSQm/nd+Byi7NXk2uLNa/RAeJJZZg0NOEw/UHWbY+J+xB+F7pml1k78+c268WKPiVli5PM1p/fYxykhdcxEE4A/BAZhNg9ZfvCGCzcQ5ziYsgWv/FKyFkT+xtsbmbPKVXDf7xlF9jfKlbKFq8sYSVY17hSla3rTlQtcvILCL62smGBlHAXiUi0Yiu4gP8nOZAdSv5EoPzHEt5RVpVAjx4sE+uc/Xq90C+HsEc85WEc4WEIrvkiwjzWFuc1okECjWEHL5a4P5hZ1hw8t4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 23:30:17 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 23:30:17 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH v6 11/14] sched/ext: Relinquish DL server reservations when not needed
Date: Wed,  2 Jul 2025 19:29:36 -0400
Message-ID: <20250702232944.3221001-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702232944.3221001-1-joelagnelf@nvidia.com>
References: <20250702232944.3221001-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be2424c-7b14-4492-a359-08ddb9c0675f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0iPS7CE3P3exJqZb+92n3P7hhtReZ2H2eS/YDGcAKGf+TjXebzR1ZFHIdny?=
 =?us-ascii?Q?PHbyDJ7wm8+fLap7Bxu0lPAv6eccdXiv1uhjfzk+VHQhE9ri7JnqfWXoR3HY?=
 =?us-ascii?Q?JNfBi3BrPmmlrYm/4gIU/IP/uNjrMbNcYxzmk//VewzezZabGye2TdUTFqje?=
 =?us-ascii?Q?LKN1Oenuxtt3THVuOLqGY7O4vbJvyNMEdHAgfgYnLddq8Z7Aue7p6A2IYj60?=
 =?us-ascii?Q?X1SramK3bNkCKQnSADcka+bk6RLI8gYDYHzT2Cl4Uwcqg/hrtxUKGJ3Rthz1?=
 =?us-ascii?Q?J1n4wdZh6Bd/2v1KUhFoAtlfgquaWQ6SlRvfKUacd0jh7otG2zp9icxtFDVp?=
 =?us-ascii?Q?FaFO/qmn+ghYLNBtP8rS23ArQ+tgK1y07lMdLP0k2A/kAWol3yGTVRotWWkO?=
 =?us-ascii?Q?CDGBxNRREuqL+HL7myKlBLZB39EmAzIAmxcyjVUF/LX9H0KBAYsrNq/x9Ixv?=
 =?us-ascii?Q?IX+QKHSZ4UTRbrRKfXQCXtHKdqLIWlz8IzeBEXhC5K+ekE6Mli3L1HnFwScS?=
 =?us-ascii?Q?YSsr/vkuvgf8ladTTxVVrtcI0J1cdzmZQpR25SEDN/tmZZHswVA5bzSsQTtF?=
 =?us-ascii?Q?eqiWLiRaPG6KADByc9gRzoYx8ynEiZIuBn2zcz2c8lcylAbtPNEuW0HxCmz5?=
 =?us-ascii?Q?YdIuG9nVBQ9FrKJNX62u4QJSGowCTlqQQP7sAV96hfyY9cGLiMrXjzSXKegR?=
 =?us-ascii?Q?huMyUeeka/S87GMoZset41raBNNByh/hpA5gmDhGBDma2D/i2aVOD0zcc6jv?=
 =?us-ascii?Q?9vnQG8l0ybZ47AGWURRZqb7VxGy3bWOn8iI8EzGd4WYFAa5RwpeJKEMBztbs?=
 =?us-ascii?Q?TpxA8GkiYRaH+XXcyI1oFzXCCMKS76xad9RBcVO9QGQQE6coErOf+jLNCgeC?=
 =?us-ascii?Q?bXQr8V61dhg0g+LEiLnzK0SbeWZjhwSYuQ1O+DTLMumt+FkPgxhdRx/AgBqn?=
 =?us-ascii?Q?Su0oiE+Zv1nmWO4PTwNEl1h+aaJo4Hj+kbUnpoSY1G3GaVBTWCp/21M/358U?=
 =?us-ascii?Q?Vlbj0NllKD1rBNQoUFpvINWWwZ6IIgE1FxeXRxXlNYGNvebBn2sDabnd4BO7?=
 =?us-ascii?Q?rG9oxml8+c+XMLVZRaiO20n3bSDP+ScHTGcr0MzmMxi3b4pGmKK+jeofeASu?=
 =?us-ascii?Q?jg0tU3W/ro5k0NWPKUTl7OI4f35kTKdmKBAXfAlnh8T9LVgAEIiAbXalkaAN?=
 =?us-ascii?Q?RGWqsoCd0vSdsPoR2wzWskkqZsDxlOmyPalW+CTrnh2FliH+hagNorDVizVV?=
 =?us-ascii?Q?nCuZFlzb5eyjBeSuI+rmh6Y+lesQnnELJQAmt0SR8okpb3JvjUxkq831gzHW?=
 =?us-ascii?Q?h78aT46v2J278uH73JgCNurmVVXbunYoAe6CYRy9/E9lbgQWE/VMNpHNjx8V?=
 =?us-ascii?Q?K4mTThDSd1BVnchzkPM8DHpD5KqBTvEPkLpwEyzr3QRC+xER3q7Jq3DkgCly?=
 =?us-ascii?Q?qPKiG0Y2thxlqk6r4B07xKWpvbFsIXDScXwBdnE7zFTQnORrqs7TuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYSnAwMf+DF7UQ6KiK8xlwxgMuzunOjGT/8maCe7E7aiUvejv+vOY2hJQD6a?=
 =?us-ascii?Q?XJZJaeJqajZKcyzN0miqoLUgsXszgXG6hAgMCRwqz17n79CD+ZcImuE4Lc9Z?=
 =?us-ascii?Q?zLirWGXHLhiGkbPRJDGHroCP0VwAPH9ANMPmqSWgYXC2hcu91YT1iO9KBlFn?=
 =?us-ascii?Q?wM1R3JcwFJKo1RR1FcvdsJZOLs9mvvHjMv3UTzSHFdxFNI7dSEYZCKHSyD/Q?=
 =?us-ascii?Q?gTqPDld2MwkIhcaKv3QKkspjVk/X7cKBtrCBcrDlkAYdd7xhmzrxdQp48/M8?=
 =?us-ascii?Q?oVU0+ie7iMbz6HNrYej7J9gPGMnerZr771s9FAJOUFDQ5zQl15XtJbvQGXX3?=
 =?us-ascii?Q?peNWbf+5J0kAq5VVlIg0WQm2ygxJcebGcJBMMn3AUdvJLJdjwfaMt7O5Ee/3?=
 =?us-ascii?Q?9ryKoPIlNjl70wYvfPemkN/TWlFsYwqnwyV2Y5FguoOHWOXsMRlctrrXNhvz?=
 =?us-ascii?Q?htU9jW+NGp1NrvwFS1yw9NWqSh2cIm3Ciwz6v3BenzuHt7SRrkPpVF5aia2O?=
 =?us-ascii?Q?84QsD1VKSRmllIP0ITjKq7Nf0JAkpDFumAil3RXMtEqFVD5nzH5GQWUu93Mu?=
 =?us-ascii?Q?dimRL30iCIVpmhGNhZShrow/9wjahzeANheA7jKCA4bCOfqUDqz3GTr3bQrx?=
 =?us-ascii?Q?xv0rXAlC5jCI9HcNhZJ6xcHpwqIAYOT8ZGuH27bY5jFNsytJIu3glNAPlWBM?=
 =?us-ascii?Q?t/m1dB8KkSHvhp5G5Dv5rEUv/3nvRZTi6CvV3ewP+Ll4KVIn1YwRiXgEcVyB?=
 =?us-ascii?Q?Fex3xtJU9e7BwHrSAp+KQgJHhW5tl7ouQReHRqxia5n8Mb0i0m/ph2J7MeFZ?=
 =?us-ascii?Q?jV+K2eEaVomt+8QnPKrCvPLKKEottMXCMiCS9s8bZhbahdZCmcqFq+RPLUoR?=
 =?us-ascii?Q?nN5/FBSz+3gkXmMcUs2Gk1KgRQh1cDUcdDBVfLbiJjoFw8dLkHnsWucm5q5R?=
 =?us-ascii?Q?kQn4YGQ7X4gmq5RRPmFBCEhmt5cW2hd2gNfpyyMET6/cvNKoPChPzJeFwwet?=
 =?us-ascii?Q?WD8JeiTmGH7Ft9LHaXiLalulAtjarUyjUOTDNI6Unr3SocJxrqW6oT6tdAOU?=
 =?us-ascii?Q?WSp3Q4dyPPln/wlVSnQceoiXPsxLhCqCpeD+YY7jB6/xYjaGgUQDm4U+mxlz?=
 =?us-ascii?Q?5k41WVXaddrC+ZELDB0Lhi1PMWGhIEcZL/zJF219Fo7dnvRFx27DtuQ0hOiL?=
 =?us-ascii?Q?NZ8TVtkA/kPoPwyWzSj0zWl79kwXdv274ke9sHAdbPk+B9rnb/TZNySYmDaI?=
 =?us-ascii?Q?08TxYVgru+UzQA6RiRGBHSOHxBw7riYW8kJLtyg4SzIfJ+o1bYvANaGGKMuB?=
 =?us-ascii?Q?yKi6Q5+nNHKng3Yuy7/kC1f9Kh2TFJLDrtLH1TT2Yx5NfizjVB0UATm5smuw?=
 =?us-ascii?Q?pWmf6Ky6YIqrfLsRAbmbXKNkVuMt0iQugF8OKGrxyJsfNWUeHiL8hnnG8Wgi?=
 =?us-ascii?Q?+KN9qa9GHphgl/NwuIt9zLui7EcKcHt74HlL5p3Z/pbc6dBRtdFKR3DVGzUg?=
 =?us-ascii?Q?GXnADVqw0jHbPEUZ26l/agklLdTNqIygJA7CRPTTQ9vpDEr0EWHcM2Xsl+O7?=
 =?us-ascii?Q?fxBY0MsFnIv8tyMvVHx8XcOOPKsJptDF+linRriU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be2424c-7b14-4492-a359-08ddb9c0675f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:30:17.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zftLCGz8AdCJAVSONjTpK6O16al1YVcYdEDhI4yq97amWKEYAtEtnKBoGDW6AGx7oI1IQGJiOdYzuD2Ih5PGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

I tested loading a test SCX program and verifying the bandwidth both
before and after applying the patch:

Without patch:
Before loading scx:
  .dl_bw->total_bw               : 1887408
After unloading scx:
  .dl_bw->total_bw               : 3774816

After patch:
Before loading scx:
  .dl_bw->total_bw               : 1887408
After unloading scx:
  .dl_bw->total_bw               : 1887408

Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/ext.c | 56 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 34c95100fbe5..6bc0ce358238 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4965,6 +4965,31 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_init_task_enabled = false;
 
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		struct rq_flags rf;
+
+		/*
+		 * Invalidate all the rq clocks to prevent getting outdated
+		 * rq clocks from a previous scx scheduler.
+		 */
+		scx_rq_clock_invalidate(rq);
+
+		/*
+		 * We are unloading the sched_ext scheduler, we do not need its
+		 * DL server bandwidth anymore, remove it for all CPUs. Whenever
+		 * the first SCX task is enqueued (when scx is re-loaded), its DL
+		 * server bandwidth will be re-initialized.
+		 */
+		rq_lock_irqsave(rq, &rf);
+		update_rq_clock(rq);
+		if (dl_server_active(&rq->ext_server))
+			dl_server_stop(&rq->ext_server);
+		dl_server_remove_params(&rq->ext_server);
+		rq_unlock_irqrestore(rq, &rf);
+	}
+
+
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
@@ -4988,15 +5013,6 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
-	/*
-	 * Invalidate all the rq clocks to prevent getting outdated
-	 * rq clocks from a previous scx scheduler.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct rq *rq = cpu_rq(cpu);
-		scx_rq_clock_invalidate(rq);
-	}
-
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
 	static_branch_disable(&__scx_enabled);
 	bitmap_zero(sch->has_op, SCX_OPI_END);
@@ -5730,6 +5746,28 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 	}
 	scx_task_iter_stop(&sti);
+
+	if (scx_switching_all) {
+		for_each_possible_cpu(cpu) {
+			struct rq *rq = cpu_rq(cpu);
+			struct rq_flags rf;
+
+			/*
+			 * We are switching all fair tasks to the sched_ext scheduler,
+			 * we do not need fair server's DL bandwidth anymore, remove it
+			 * for all CPUs. Whenever the first CFS task is enqueued (when
+			 * scx is unloaded), the fair server's DL bandwidth will be
+			 * re-initialized.
+			 */
+			rq_lock_irqsave(rq, &rf);
+			update_rq_clock(rq);
+			if (dl_server_active(&rq->fair_server))
+				dl_server_stop(&rq->fair_server);
+			dl_server_remove_params(&rq->fair_server);
+			rq_unlock_irqrestore(rq, &rf);
+		}
+	}
+
 	percpu_up_write(&scx_fork_rwsem);
 
 	scx_bypass(false);
-- 
2.34.1

