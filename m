Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FA2EE279
	for <sched-ext@lists.linux.dev>; Fri, 20 Jun 2025 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451589; cv=fail; b=thO6Smq7ECpv4jEsJAqbGdKyBrLJlt7wJ6reZb4U06YJRdrX9LNWJgiss/PtyHq0HAGgIpscJsUWxp580wcAcX+L9IDxAc6i6dPNp3PeqjTBw8LRGeHJ4L7DGYwJ7An9zfFHM/ZX5dGxsyDG9uQ6ry9++kwr8fJKKRI1VHrJtKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451589; c=relaxed/simple;
	bh=F33wuKMnE6irQObKVDp+zEZIttNbtNAJXpm3FLBjtwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOOsUPVdi0VeqYimRU4jwLgTRiZqnXNpndGaJi7TK3mcFiAlKz3ZDje0+ts9o69bs4iyNbrtQ5cg02U23auF45woVts/HgY3KG3ryKOnHdGJLuPEGlnfVdTkJe+Ugp+LZrdjzfpBsGfCir5o4DK1VHKEKdlV+0AI0Rh0E0bBql0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fUxjvHcj; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fUxjvHcj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky1TB/Myvqpe94yoJavFG/xNNJImE2S2VGYvGUUSUJTwpW2yCBVRvjgDXNuqXpN8BjFA+t5/jed1zWcVprwVjqbPgXcKmJNL9OGTKC8KQCcfKeJBpJJAOmvCJB0dyK3bGebfkBhvVtcyGAJV5q36TxPg/DMyjNh3IT6oO+xTNXq38M7XdrYvU7SzrpfMS9HpM8xOaCw6ktYATQF1heIASVdgTujASPaf+dQdSjs16/Fzd6b7Evz7A6zd2lXQQKaS5J72to4i5qw1CyPY6HRwCT9UCfNdW2zfmTtKCkrPSJdJElBcYKHwzQMzpDHTmO68XdOobAB6zAdzWq2FVLuXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/scwWDuQ2xqGyxZ4o70kRn0hu0fSRh4AlA5r7htbh4=;
 b=jgYlDhmxdNvJX+uh5LnjFVGA1o6CPvyZBcf60CJt4g2QUNXeI5d8TSdacsRZXnG24NPRhXI7duJYW1rrH2TlC8Y9/zr/6MFXvtQe9Vfpu0l42UpWLuS7v6eTGM4E+eiU7MdpGwEfXFTVRSRWRx2FRVN4QTpL4T+aSn4ZqwBHSQXftJOabKzGOpxvY7K11E70bh9BIv0kwHhQyFNCenAjMwXwKi+zEJWF8DYsZQht5MIEp3GBG0Gh5fINnkdX4agt3GdJre9310HGUMK5HXtycKiElWN7H2F+MwSytHolg9tooNcL2jOrE+j4lrYd5lRFHa3jMlNZaQn3/MnpnebDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/scwWDuQ2xqGyxZ4o70kRn0hu0fSRh4AlA5r7htbh4=;
 b=fUxjvHcjS268vez/4/70aR8dg7OWB8FBnb0MR5mMu8vlVblrZINqpXB7CjXyVMTjw8LFzLxPvuy390Ab4QwKrowqI0+Eld5YIzWPPVu9oPTImmw+LVB9dJgXz1W2UzTVMYFhrTGpPTb5D0YUcLasOVVzhikhwjMcrrTY69z7ickT90kSDUEw756vAU8eXG4mzQunXT4WXhMdHEQj6HFY3VU9kaLW5/6Ik24/Tto1EbiN42HJQxrzDfvA8+ONangtVae6lavjjNElJiXGazEi3HlcJ3Pl6uhB1DOyOdP3fbKaO32xo/FJULiJ2mtLJvnMJ+SPnoYi9NdeZLRlkvlh6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 20:33:04 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 20:33:03 +0000
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
Subject: [PATCH v5 11/14] sched/ext: Relinquish DL server reservations when not needed
Date: Fri, 20 Jun 2025 16:32:26 -0400
Message-ID: <20250620203234.3349930-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620203234.3349930-1-joelagnelf@nvidia.com>
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:408:ee::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: af6de1fd-57af-4336-68db-08ddb039a833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZAUH+pvYE6qYVA+ryYEwE3HFyh1ykd1pf5BWaBQSJT07cWLZS+vvUW3+Yk13?=
 =?us-ascii?Q?LtAXqChVexlkiqMLXe1xkDFfoNGHwsoOMvKhUJ+qIwkzt0Me3XdHqclNhETm?=
 =?us-ascii?Q?gfFhoeYvuDn5m3fnDTL8XD9DPHVemzBe/5i8CPwav5I7eYmqm9cEzWnSfB4A?=
 =?us-ascii?Q?LRJ6xmMgkGx+WK9NPc3Ob3yIXYzv0eplLOR4BebFUeoKK6D0b9YTNK40p7bd?=
 =?us-ascii?Q?9/+5rPDrjgXIk2OZOZdzwaJG7uhHjY2ukkraJeyLR8f1DzN9xs5H1qcjXLKd?=
 =?us-ascii?Q?QnHy2nBAgFhpYu7PIUGo6Gf5Mb3JagryPdEQt1EPaTv529O4y3jKWNJ5AkBB?=
 =?us-ascii?Q?coFlPfRideAxcOMJjpKqhHHYDXh1mEgvdE7GKaRcnBj2hCvDC5eng6xQF0as?=
 =?us-ascii?Q?A7HYsONX+yF023ev1Nbx8sNZw8JUL110XMfaysf+KzWAcZdGxwkYTHHeKMZW?=
 =?us-ascii?Q?OFG0sxkwlVPZjI03MG/Q/G5zdhZvQSd0D4ufYQQVdVWGp+DCErLcULhX4BlS?=
 =?us-ascii?Q?JEKbJdLrTKhCqpJ7S2Ty/5VJ2AzooGsdrC1vVC1mmF9ym+u+Z5wpiL8gPKoH?=
 =?us-ascii?Q?UFQkBOOy3f4oS9i0eQM0fzBXB7jmzuTwrhNTka13EGPBoBW8dWTPDp0FhTcW?=
 =?us-ascii?Q?j9drAsheLYfjg4/teMss+NLnk2xNFS/oSSoYqg+LxO8MKAyUE0OnbOmHFgDA?=
 =?us-ascii?Q?QNUSU7NLEuqSun5pcyccc+N/Ml/KOaUd4vJY2SoKMFs2HoIksxqx8jR/TGIv?=
 =?us-ascii?Q?nIIN4vSMm9JmFk7CbImkeni4dWDaEz+8b/hebo3RaNlBSX3po8JEU9ekr2pt?=
 =?us-ascii?Q?q8GZvTU3yXDhyB+XmIjjkh5sAqZr78+ThZwgm4kLz++oDYMADQ2fd0OV9dLP?=
 =?us-ascii?Q?oi6y+HQ1ob5AXjq/NJi22MfhE5X6gbLoKboa50XYUohNzKXAoNYRp4IDpG8s?=
 =?us-ascii?Q?TG9Vs+i5TL8Ee9H7UmBOIIpMr1gu4gPaTZIdElLRRA1K5snAv5Hb5AVG/tZz?=
 =?us-ascii?Q?De5IPa2lVEg/imkR4X6OMMiMytNX1ZWwjd95ByjpSgpiDSIl/a+I7c5u4tBi?=
 =?us-ascii?Q?7V2QlNK+iuwTYPI9KLdUkHlAOXDmW7ZTwbsQcCsVvaeDjG2WaZFJ8tujhxlm?=
 =?us-ascii?Q?ruvDTDWRxrk9Fehwz2cuTgupXI8BVp2Y3ENPHusaS6vVRDUhmqnUinc1AowK?=
 =?us-ascii?Q?B8XiV3+C9X6Pug8NtFfGcYgmwXObQohC07lJmGot+UB8gOZbESyLuU6RTq6i?=
 =?us-ascii?Q?QkvT3rtxoDUwCVFv4iRQ8mnCu3t6vBlAWoSrLT+wOxKDjWvvpf9LOSyOoqOC?=
 =?us-ascii?Q?6ETtuMXlMv0D1j2vVjEI5i7gzWm4B/jDi7X09S4ORmj6wrhq9oFY5PmGHIom?=
 =?us-ascii?Q?vmvscELCgXOlAPxaCVjS1Mw3Yez6rA8Hr/+CsSCdHIrWZTXvZcjtKa5BPP+9?=
 =?us-ascii?Q?QHQHVRSotbBeA47I/Dzwuw+VtX+Pa+WahRcujxdZxhCWAIH3SAaryg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2iNZnRJijAfOATZiZAiciy/1dgGUD5YdF7GgGvN/e8bsPR5naJGxlakLis5g?=
 =?us-ascii?Q?ur/Z8njsJwyl+2/eXW3Z6sx5Wae1uNJfrtnhNjJD3/Ej3Z0XQb10qNgveJU1?=
 =?us-ascii?Q?vfn5IA65F9mQ8QRKlM4li8IKojX1yEseH9gBi/05X1PFGEykP4S96Tc4lIjX?=
 =?us-ascii?Q?Ips6DzqfyDI+7ycCwJ9rbOOSfWS+7B24yXRzSM4Yx/c/Gfs2cA7nCi/rtQSs?=
 =?us-ascii?Q?wAt/reL8JWBtwVTr0ZorJtKDeAY6hZmenUaYeXA97WH3rv3AVaptwcBV14Lz?=
 =?us-ascii?Q?AF6JhqUMcsLUsLhMP8zYwqOtDThx2xzB4uU1NEzzV20G5889axhWmkz11fbz?=
 =?us-ascii?Q?tYrTrird/1jbqB4ThrOXFkvobWfIW3ajGH9G2CReelz/k8dywF1GQpJu0zCH?=
 =?us-ascii?Q?uDtapcbxakqf35BYUdJgWJG4W90UEHvrDMGaleIrI4qcp0eu+H52NFy8FVd5?=
 =?us-ascii?Q?NBPcRlmywKG5iHRZ4Wfq485rU03ZRNlAo4z2y69tGdFyeIhw6hzlwHinj2um?=
 =?us-ascii?Q?fBGhcZe7WbfMkrkQ0y1W+4DAGusnD64oUCssulgOSfbIDAM9vIHBt2bjjB8I?=
 =?us-ascii?Q?1/SsqTqh4uYguy2RB4xawm11DsnbJdvkQGYZf1Jtib2pZLFZ2b3jlDDueOmg?=
 =?us-ascii?Q?R/a2mE9NWGBegemxTffnHpIWHLDjtqkicaCGHRV51JKPpmEVjkeMKgeKvaCl?=
 =?us-ascii?Q?tGtcXZNAjl2MgPhASuLTW17O5pxsA8b6bMO1Vv+6zSs1bnp/sS/BJW1JbxUN?=
 =?us-ascii?Q?amkfjhFCxmotPboY98ntSK5VmsmUfMU8j2prhjjpokCI30ACG3+zVYAcM7Df?=
 =?us-ascii?Q?xlVMv6b5Bbc3SmWSrfKydGoLlLxgmPR4/3hi6CC+9vg2UL+JjIjSO16UiPFy?=
 =?us-ascii?Q?7Gxj+Kd2JajAMdXOtGtqOVf7c+Ou8u9cQnQLyj+MH1NzAMTxYJuYdUwbjeaI?=
 =?us-ascii?Q?VnSVo43CTXD2+QQtLDElLqFAQROWwOHZWf+dIeOHfoTcm0usHvyH6/yDJ+AF?=
 =?us-ascii?Q?Jti/Hk+fzeUy1aFo0BZNx1OpctPECZ4nzSTbwI2aHwFYB33rYX15BNBCbreh?=
 =?us-ascii?Q?BGZhTkLRQwKr5Ip1qMTrubR+2Ov75uwPGSxar6ypash5GhAmrUbM6wOiGlbj?=
 =?us-ascii?Q?MLqvCLccrhcr180nmcZ9kuUYpqsv1M447LAShCfSf2oI362ovS/8pIBQkVvQ?=
 =?us-ascii?Q?Jp9NCCs5hKWQV4hgU26OhhihWyU1IUXdLV5Rt0tnFDhx8ScLfPvbPjFHfPpf?=
 =?us-ascii?Q?WyY+WNxS6q1VDXVb1ykBiJ+lR/BslBguX7efEoIy8noq+lriZ3VUivmfZGO9?=
 =?us-ascii?Q?aL6cCfmEYSzduCoIQPV7fejHrJhCAieP0zQm4G4z1d/ydMEw1YAIk0sPi4w3?=
 =?us-ascii?Q?ydUgCbvdFC0DjtbvcpqmAB235bEu81Pe0YpazC1XpvRRfYbxA/dYWFgsHCMj?=
 =?us-ascii?Q?QO3s+2AYJ/45aFW8wHlowB4olSqB1lgf5ZVVBLsb5oUvIyeRCMDBmu3jUSe4?=
 =?us-ascii?Q?RZhP8pNRfzrfgxaNMiz7fnaJc5LdoAsLl6vsJkS37CiqMZwR+ypIQP2w0ib6?=
 =?us-ascii?Q?HrksuRamkqm38GIg7S6mMhkXRZOBnv8IOk+51K0d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6de1fd-57af-4336-68db-08ddb039a833
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:33:03.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukPvaptMDt+D6QIeZyan3gRBQpxT9sdo8HTc1ZhSx2iSVS0SFZ+/t+QF9VdKpcTQdFQAc3N635u+GoofQAIB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

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
2.43.0

