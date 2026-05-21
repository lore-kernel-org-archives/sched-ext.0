Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718B3C4155
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385553; cv=fail; b=P4DnY9dGOiYY/d6RGADvVPP4GF+V4BO+KCLaVQ5vsSW9aonEfixjiEjChft+NDTIVNY5DHgYYZ1KDX+br5AeSBP7MtX3FZrblW6/aSbMwCRWDaKaH4XMUyYBPafhoZRvCXzERPcMZ5uCC0fY2J8nPilCop9uOYQ0gZ9lsh89D/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385553; c=relaxed/simple;
	bh=JgvxPjrYPSkyvBfOV/5DPDjff0HIzRClW81awacDA9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BPvzbsdw0Q4pPQmWvkx447YhlQc870r1M60qfaFsHty2jbX/ShcHT7LRN5rRCgikzXS3/oo4MHVcUlybsRF3k46urD09DNcSG7UDBOIWFhWzwstYg2FwuMo7nLWKmtM4iY3rCOvfg6FZkCUqU4E5Hg7ZfI4s6bCqxoJnP9hYIpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S1BW9vvq; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S1BW9vvq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDxlKh7GAjhuPav7DHEInbwuyPOoQokWBq4ip4tMHWSViGPyNtsuOFOhln4ofwRsbc1lKUH+8iUi4oMwSJd0J7Ncr6VX0gIu2ZTMu+vyND/p/IhqvwwQNxDHXPqCvR0BE8olipOnh5tbfrWXJ5CgjcCuofogZI+s/QVZkjOKkD0vSZV31l5gM1Q6TxCDTE7+38s13sBflKKSN17TMSYLhmP9e+Adn6p0DYdyvMh7QHI8aWiVdDgPLE8+s93UdBjbsYG8lIryMbXnHHL8+IQrHmzOwMzwuGt5/xaQq3zGlSI2seNG0eCxMj/5FtZvs/x0fr3xWZgACSnRh8ECQkyoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO3Ue+yFUlCBCap2DOb9YzHZ8yhTujc1x3Lb0tgslKk=;
 b=g/c5tESejuSC53Y4AhPb0HiFkd26D9e/2dBEWOTEyiws9FpoiSOm3F4L1FbkTb/T76rkp3Syd33fiwOz6DGdawQchKb7jM4YMilrjzAMSg2KNJWORochygzitdPCyrEWUYIPnvE9Jw4+c9uPi3vyXrOsqrR03XUD8kfvgybpwm9Xjj1b1vQwxsCzVB7nA1Yo36LZ/R06rtpgYIeO+1qhZJmJw9BMQs46Qv9/MvFZEYXRgiYyeFEmtfk85ckJsWPGKTx9SUkaN0ERy9KMHEUTIRdV+2wKGqFQszcLZEd16ZLpYiYQkfIrKL9qQnDmJhhXI+zMrynhesVRgVcVoABdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO3Ue+yFUlCBCap2DOb9YzHZ8yhTujc1x3Lb0tgslKk=;
 b=S1BW9vvq/PtKj32BJqhpfDO0eaHhO8K246QrxIBFOBgjxF+hqwDfmzx3iEkoRpD0MahB1E5maAWtjTWjdPICtRlis5zAfyNAhjb6cbsH8t2wNcm54B3ZMoijMtOjf/c7cOXUjIC4+BAg2ZT0FA5S5AHIAwQkjg7xYxln/5eoHvDALCetrovbkJfysNwSAH2R4+zilPwFITg1d+zJzSOx7oMTuU+aWLqW4P6kl45nxG7JwQg9h5adQdP4QTW5/m0ODx39q7OQQK4FmhWqmrtl+uZEs4Kk1VX7Sw26cJF2/IHuPJiNIAMNOXlZf7j3d3umLpASpAhOSw/EcSUQSdxy4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 21 May
 2026 17:45:36 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:45:36 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>,
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Auto-register/unregister dl_server reservations
Date: Thu, 21 May 2026 19:33:56 +0200
Message-ID: <20260521174509.1534623-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521174509.1534623-1-arighi@nvidia.com>
References: <20260521174509.1534623-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: cc493799-1174-4dee-2aeb-08deb760c3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|11063799006|18002099003|22082099003|56012099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	0B12wip+KvnjREYPph6OQHwUWBi4Snpxi/z+j3YhHta+WJQWJjHRZ2RLd8suVnIaMBCxY4kpnuqauznVXyUnjayRnvNdnAvBgt4ib1JbNZLtwBttV4Yh9GuLjllRANZZpyEz6nh+qLQOBiTiUTuLw5hu4ZVhPMgXHjhUb/OXa/FXciqqU0PXNqUUwtjFteUjZaVx0jFKEak3cfdS1kjIhTXf5SPU4dWom6OXidQZi0xU1GtZLU+OjBAcjbrCSnZD9XGmzdRsMgx5wmXNhMya5ZqSMvXJsIv4sUWV9LAV+z5apRM2DYkEWpnGO5aulbYmgAJAOx6uy3FSp8h3hfaq9pbBNgojX3YVYJIHmgaqnSRmzeXAW+Ij0XEGyTe5cShPlpEQTWK45nH241Nbh29HuYEZPqlCMI8VJXbRywcYuol4D5eCr7P5TjgopMTygJOu0W7/3Cun39FL8OYsE6KWoKdnwMDE5envngFWyRyda6PjQ1zki0T4o3QgPpft0zLiqNhO5UWOfvBzIec4Az5OtpJvRnCVX20UornN58JzXUf4P2QeDv0j/Xu07ZTNwNF/vPisO8gIMALSwMEibNuHnIHmUGIYX2LD9snstG15RBU1Xvfr2o/6kOPhWYvYw7baHn/4RcCFC9Gv9MGZKjGuhXPacALyXTBlBrFJX7PNIVR0jZcoi4Ilj/ZNdJ1YbMNp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7wSFE49tYa53UZ5NMkzNmjLAeY9OegJ7SrJrSHjUZKdI4ZeCVneHbKvJPJtu?=
 =?us-ascii?Q?f2d29wOKQ1zHtdivluI7w4CsK56v8VWJx89d1BkgX/1f8C9U0WUATE3bO7GL?=
 =?us-ascii?Q?lN5S3KCIKyJHCxHifzMXqR1tO3iMdOV77v0fUWp/uYFNlk3fPDveDU8VivSO?=
 =?us-ascii?Q?1pKJ9cE4RS4LBj+QmnmJMOYn0uIE8p++m8OmN/TuSgoX9YYowMQvzN8mEik4?=
 =?us-ascii?Q?CCjvTVrFtKc4aSR1lIES2Clyz50oPbq/IUDjdhQm95Hq6PySJzIAx9P54ZBH?=
 =?us-ascii?Q?rzFF7L8Si7fiBOxGGB3E7dsfHx4LeiDwX65Akyhtu5bY1ML9HjX4fE9jZKGp?=
 =?us-ascii?Q?Nkp54AZdrYGaCwppTZ3+P8aTLHhbulJ2s85ZNcMBdgbTtv7sNays4738Lk6O?=
 =?us-ascii?Q?IQ8jC5XHFZVtBSraTwGIYrfvOIKKsbdEkdAe1PMzN1g321xz8jGJIXowSAWC?=
 =?us-ascii?Q?nX7GY0Ojp6GZwFShUN03ftNXis6daTirISjLrV1ZfQv/07ynwQMDaueT79vx?=
 =?us-ascii?Q?NYOu4Hy5oKLkaoe8ykymv5YIhSYXZ5d8aSnZ0+zQ7q6M6ehKUGUpg+nfc7Bh?=
 =?us-ascii?Q?hBmIiyM7TQU6nne9NiOT9uWQeleTRPU58jcAP8QmXa3XGvl+6G7Fy9ns/D95?=
 =?us-ascii?Q?VAuk7Z+PSo11yZCyr01Yp9jHU5QTQFWuAfPy7Uv5CH30n74HB3X5bk1A585M?=
 =?us-ascii?Q?lBLBYzeFPop57kwq/uBjuEnvdEyuDYCTcDwDgl0yRVV+w8CvIS/jNtAGTpIU?=
 =?us-ascii?Q?xi/NXJLvQNOqYqnmFH6gMqZ1ZSpRL/I/eHoB3XXaHl8ZucvRbv7S6hP9QGVj?=
 =?us-ascii?Q?S4HtSEJlhNPONJiIC2ix8tqUbrcv5p/ZT8gUUtMfF0WhaKp7oYnG2X4Sp8R7?=
 =?us-ascii?Q?DCSRIfFBCVF0pFOQlXYth64DG9UB/zylbbNc/Z/omWnv2Ul4qViPpIfKGe15?=
 =?us-ascii?Q?voP+hlS6+nNFnLB88bbPuDTkTmQWP/sl+qQeHRcSUnnlHoUrDgHBhV20FUA8?=
 =?us-ascii?Q?fZgiD5mg28SkQIhjhxrT7JERyNBPPCqDQTjo1oS+Z4DxG1eet6amuZg4MaaP?=
 =?us-ascii?Q?o7Z7XkSP96YLUDSOw3qkyF86q1KyVBheVYbwXTDq/erLgDBYFSqytwHnGL5X?=
 =?us-ascii?Q?nwsOtYWm2NWA+WDUjGTp7p58qL5mnvSO3kU2fVjp5xJeDSUxiT88GJYmOwAt?=
 =?us-ascii?Q?9LNl04UlzrjYDmn+wq9CDK3PNxg9YQWe+nxxVwD5ZYA7sItdd6CRhulJHpuM?=
 =?us-ascii?Q?WBmb+4lVcBhrRikxYhzJlxIN5oZ4UxMRbkU2iXrVbKz5qJtEuff/XyxHTAA1?=
 =?us-ascii?Q?85AqGY+5NCiF60zgxLVLHi+9uRr4FIT6pDspG6HRQ8T/a5yAFYUWgd08LUBa?=
 =?us-ascii?Q?O1vzOJUGCtPGwnPuVkJERZ4LTEnfZ7yL0UPbMbw7PVSQpm6e0d5ZDby3GyJy?=
 =?us-ascii?Q?4YZfM0xLhAvTqUtr8lmx96fQp2SlAt/a5b70Pk5upWoGvs74ZOX26OqCBkuI?=
 =?us-ascii?Q?0JwSmhXF8vQkJUBgFjBcAMqq8BJA5io54oLilrB0aAaypJhUwoOOn4Efe0Xx?=
 =?us-ascii?Q?u3Gcm86cEBmTu9fqj6fcDYSroxe8FXJCLakJ61Yd7MsR7YTgeUuTEpaUzty/?=
 =?us-ascii?Q?qqwhT8vLaIwVxHu631FEtXfbdvQSV6TaNKpSejO8idoJbyKERos2oo/xqB1t?=
 =?us-ascii?Q?wweqHX4JcQdowwz4vqlyX6O6pxqKGL2Do3Yj0mNWKPpime6q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc493799-1174-4dee-2aeb-08deb760c3de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:45:36.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwH0JE81Rbayo/At+xAwDlUpl5ESp0Q5b1iBOi0Jx0+S1VXQ4wwJ0Arme4b3DdG6Ed1vUyA24gOEfPEGEFyLIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1

Commit cd959a3562050d ("sched_ext: Add a DL server for sched_ext tasks")
introduced an ext_server deadline server to protect sched_ext tasks from
fair/RT starvation, mirroring the existing fair_server.

Currently, both servers reserve their 50ms/1000ms bandwidth at boot,
regardless of whether a BPF scheduler is loaded. Unused bandwidth is
still reclaimed at runtime by other classes, but the static reservation
prevents the RT class from implicitly using that headroom when one of
the two classes is guaranteed to be empty.

A sysadmin can work around this by writing
/sys/kernel/debug/sched/{fair,ext}_server/cpu*/runtime, but that
requires manual action and not all systems expose debugfs.

A better approach is to make server bandwidth reservations dynamic: only
the scheduling policy that is currently active should register its
reservation, while the inactive one should not artificially hold
capacity (keeping both reservations only when the BPF scheduler is
running in partial mode):

 +---------------------------------------------+-------------+------------+
 | BPF scheduler state                         | fair server | ext server |
 +---------------------------------------------+-------------+------------+
 | not loaded (default boot)                   | reserved    | none       |
 | loaded full mode (!SCX_OPS_SWITCH_PARTIAL)  | none        | reserved   |
 | loaded partial mode (SCX_OPS_SWITCH_PARTIAL)| reserved    | reserved   |
 +---------------------------------------------+-------------+------------+

To achieve this, introduce an "attached/detached" state for each
deadline server, so the kernel can decide whether a server's bandwidth
should be accounted in global bandwidth tracking.

At boot, the system starts with only the fair server contributing to
bandwidth accounting. When a BPF scheduler is enabled, the ext server is
attached and may replace or complement the fair server depending on
whether full or partial mode is used. When sched_ext is disabled, the
system restores the previous deadline bandwidth values and behavior.

The transition logic ensures that switching between scheduling modes is
consistent and reversible, without losing runtime configuration or
requiring manual intervention.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched.h   |   6 +++
 kernel/sched/deadline.c | 109 +++++++++++++++++++++++++++++++++++++---
 kernel/sched/ext.c      |  43 ++++++++++++++++
 kernel/sched/sched.h    |   2 +
 4 files changed, 153 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 004e6d56a499a..6d55b2ed9651a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -702,6 +702,11 @@ struct sched_dl_entity {
 	 * running, skipping the defer phase.
 	 *
 	 * @dl_defer_idle tracks idle state
+	 *
+	 * @dl_bw_attached tells if this server's bandwidth currently
+	 * contributes to the root domain's total_bw. Only meaningful for server
+	 * entities (@dl_server == 1). Allows toggling the reservation on/off
+	 * without losing the configured @dl_runtime/@dl_period.
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;
@@ -713,6 +718,7 @@ struct sched_dl_entity {
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
 	unsigned int			dl_defer_idle     : 1;
+	unsigned int			dl_bw_attached    : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index edca7849b165d..08b8a8c23e80b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1868,6 +1868,13 @@ void sched_init_dl_servers(void)
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
+
+		/*
+		 * No BPF scheduler is loaded at boot, so the ext_server has no
+		 * tasks to protect. Detach its bandwidth reservation, it will
+		 * be re-attached when a BPF scheduler is loaded.
+		 */
+		dl_server_detach_bw(dl_se);
 #endif
 	}
 }
@@ -1878,6 +1885,9 @@ void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
 	int cpu = cpu_of(rq);
 	struct dl_bw *dl_b;
 
+	if (!dl_se->dl_bw_attached)
+		return;
+
 	dl_b = dl_bw_of(cpu_of(rq));
 	guard(raw_spinlock)(&dl_b->lock);
 
@@ -1903,16 +1913,21 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	cpus = dl_bw_cpus(cpu);
 	cap = dl_bw_capacity(cpu);
 
-	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
-		return -EBUSY;
+	if (init || dl_se->dl_bw_attached) {
+		if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+			return -EBUSY;
+	}
 
 	if (init) {
 		__add_rq_bw(new_bw, &rq->dl);
 		__dl_add(dl_b, new_bw, cpus);
-	} else {
+		dl_se->dl_bw_attached = 1;
+	} else if (dl_se->dl_bw_attached) {
 		__dl_sub(dl_b, dl_se->dl_bw, cpus);
 		__dl_add(dl_b, new_bw, cpus);
 
+		dl_rq_change_utilization(rq, dl_se, new_bw);
+	} else {
 		dl_rq_change_utilization(rq, dl_se, new_bw);
 	}
 
@@ -1929,6 +1944,84 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	return 0;
 }
 
+/*
+ * Attach @dl_se's bandwidth to the root domain's total_bw accounting.
+ *
+ * Use to dynamically register a dl_server's bandwidth reservation while
+ * preserving its configured @dl_runtime / @dl_period. No-op if @dl_se is
+ * already attached.
+ *
+ * Returns -EBUSY if attaching would overflow the root domain capacity.
+ */
+int dl_server_attach_bw(struct sched_dl_entity *dl_se)
+{
+	struct rq *rq = dl_se->rq;
+	int cpu = cpu_of(rq);
+	struct dl_bw *dl_b;
+	unsigned long cap;
+	int cpus;
+
+	if (dl_se->dl_bw_attached)
+		return 0;
+
+	dl_b = dl_bw_of(cpu);
+	guard(raw_spinlock)(&dl_b->lock);
+
+	cpus = dl_bw_cpus(cpu);
+
+	/*
+	 * If there's no active CPU in this root domain (e.g., @cpu is offline),
+	 * just record the intent, so dl_server_add_bw() honors it when CPUs
+	 * come back.
+	 */
+	if (!cpus) {
+		dl_se->dl_bw_attached = 1;
+		return 0;
+	}
+
+	cap = dl_bw_capacity(cpu);
+
+	if (__dl_overflow(dl_b, cap, 0, dl_se->dl_bw))
+		return -EBUSY;
+
+	__dl_add(dl_b, dl_se->dl_bw, cpus);
+	dl_se->dl_bw_attached = 1;
+
+	return 0;
+}
+
+/*
+ * Detach @dl_se's bandwidth from the root domain's total_bw accounting.
+ *
+ * Use to dynamically unregister a dl_server's bandwidth reservation while
+ * preserving its configured @dl_runtime / @dl_period. No-op if @dl_se is
+ * not currently attached.
+ */
+void dl_server_detach_bw(struct sched_dl_entity *dl_se)
+{
+	struct rq *rq = dl_se->rq;
+	int cpu = cpu_of(rq);
+	struct dl_bw *dl_b;
+	int cpus;
+
+	if (!dl_se->dl_bw_attached)
+		return;
+
+	dl_b = dl_bw_of(cpu);
+	guard(raw_spinlock)(&dl_b->lock);
+
+	cpus = dl_bw_cpus(cpu);
+
+	/*
+	 * If no active CPUs in this root domain, the bandwidth isn't in
+	 * @dl_b right now; only clear the flag so dl_server_add_bw() skips
+	 * the server on the next root-domain rebuild.
+	 */
+	if (cpus)
+		__dl_sub(dl_b, dl_se->dl_bw, cpus);
+	dl_se->dl_bw_attached = 0;
+}
+
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
@@ -3229,12 +3322,12 @@ static void dl_server_add_bw(struct root_domain *rd, int cpu)
 	struct sched_dl_entity *dl_se;
 
 	dl_se = &cpu_rq(cpu)->fair_server;
-	if (dl_server(dl_se) && cpu_active(cpu))
+	if (dl_server(dl_se) && dl_se->dl_bw_attached && cpu_active(cpu))
 		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 	dl_se = &cpu_rq(cpu)->ext_server;
-	if (dl_server(dl_se) && cpu_active(cpu))
+	if (dl_server(dl_se) && dl_se->dl_bw_attached && cpu_active(cpu))
 		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
 #endif
 }
@@ -3243,11 +3336,13 @@ static u64 dl_server_read_bw(int cpu)
 {
 	u64 dl_bw = 0;
 
-	if (cpu_rq(cpu)->fair_server.dl_server)
+	if (cpu_rq(cpu)->fair_server.dl_server &&
+	    cpu_rq(cpu)->fair_server.dl_bw_attached)
 		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
 
 #ifdef CONFIG_SCHED_CLASS_EXT
-	if (cpu_rq(cpu)->ext_server.dl_server)
+	if (cpu_rq(cpu)->ext_server.dl_server &&
+	    cpu_rq(cpu)->ext_server.dl_bw_attached)
 		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
 #endif
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9c458552d14ff..15ba49fcba9af 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6061,6 +6061,7 @@ static void scx_root_disable(struct scx_sched *sch)
 {
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	bool was_switched_all;
 	int cpu;
 
 	/* guarantee forward progress and wait for descendants to be disabled */
@@ -6087,6 +6088,13 @@ static void scx_root_disable(struct scx_sched *sch)
 	 */
 	mutex_lock(&scx_enable_mutex);
 
+	/*
+	 * Snapshot the full vs partial mode before clearing the static
+	 * branch, so the dl_server re-balance below knows whether the
+	 * fair_server reservation needs to be reinstated.
+	 */
+	was_switched_all = scx_switched_all();
+
 	static_branch_disable(&__scx_switched_all);
 	WRITE_ONCE(scx_switching_all, false);
 
@@ -6136,10 +6144,24 @@ static void scx_root_disable(struct scx_sched *sch)
 	/*
 	 * Invalidate all the rq clocks to prevent getting outdated
 	 * rq clocks from a previous scx scheduler.
+	 *
+	 * Also re-balance the dl_server bandwidth reservations: detach
+	 * ext_server (no more sched_ext tasks) and reinstate fair_server
+	 * if it was previously detached because we were running in full
+	 * mode. Detach before attach to avoid a transient overflow of the
+	 * root domain's bandwidth capacity.
 	 */
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
+
 		scx_rq_clock_invalidate(rq);
+
+		scoped_guard(rq_lock_irqsave, rq) {
+			dl_server_detach_bw(&rq->ext_server);
+			if (was_switched_all &&
+			    WARN_ON_ONCE(dl_server_attach_bw(&rq->fair_server)))
+				pr_warn("failed to re-attach fair_server on CPU %d\n", cpu);
+		}
 	}
 
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
@@ -7314,6 +7336,27 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
 		static_branch_enable(&__scx_switched_all);
 
+	/*
+	 * Re-balance the dl_server bandwidth reservations.
+	 *
+	 * In full mode (!SCX_OPS_SWITCH_PARTIAL) no task will ever run in
+	 * the fair class, so detach the fair_server reservation and give
+	 * that bandwidth back to the RT class. Always attach the
+	 * ext_server reservation since sched_ext tasks are now possible.
+	 *
+	 * Detach before attach to avoid a transient overflow of the root
+	 * domain's bandwidth capacity.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		guard(rq_lock_irqsave)(rq);
+		if (scx_switched_all())
+			dl_server_detach_bw(&rq->fair_server);
+		if (WARN_ON_ONCE(dl_server_attach_bw(&rq->ext_server)))
+			pr_warn("failed to attach ext_server on CPU %d\n", cpu);
+	}
+
 	pr_info("sched_ext: BPF scheduler \"%s\" enabled%s\n",
 		sch->ops.name, scx_switched_all() ? "" : " (partial)");
 	kobject_uevent(&sch->kobj, KOBJ_ADD);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d1..1e233618257ac 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -421,6 +421,8 @@ extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
+extern int dl_server_attach_bw(struct sched_dl_entity *dl_se);
+extern void dl_server_detach_bw(struct sched_dl_entity *dl_se);
 
 static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 {
-- 
2.54.0

