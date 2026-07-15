Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C73CBE7E
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149015; cv=fail; b=Scp2R5R9QqCMOGJCs0ZTEgsN56oiuRtiXsqNJcD2RABk9Y9e326qsrPsLBOeixG+j+VqZTZN/7tDKqyDP+AubRWu6GsPDDaeSuB5cKDF4tfPYqn1WPGH494o3/epTe91kKJj6FkPkRR6I1r1AtrysHUUf+Y5KqwYXhKB9fGU0KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149015; c=relaxed/simple;
	bh=Y1NUQd1iCaPCOGh3ALDhe5tOe3eAsmz02qoecb3B6yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmS8w0j/Lyub06M1H+4BKvvh1sFzOtIRpfJTDSLTpv46bf0blSCzYwoSGUVFsKUHRQfvNaPQekFnAiIPvf0HmwLs3/xkPrBz8rIdEoXH332c3pF2f0vfkk1Z1aYmvT5CwyAEToSQ+M9Op0Yceb5zFYpJn1PLktK32ITwpIDglBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ho/ceUQh; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ho/ceUQh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJRCX6BLoDqJhrm3jsFkXHtolG0komnj7k/xqNcB0cxvq3oYhxLzKjmf/9qmIszEFC3cELmIwW4qJZ1jt08XYN07x7qsThIPRzwXeTfwXFqCXlBZaoqKTsLJM8R+oTwMVuuyPsSOLQBmDvYw9lhAQqP7Zh55sNo3i1zvVPww7XD50ThVrETFZr5tL3Epm94PTnhGS9ivXsUFMrxEYa5QPlRueFHLg4S8NrfinERK9vvKyHbMStUAO0vmfTVGzeaJj+q9DNhU4H+X4xDxirgaNK3cKQrfO8XIcer3L+ziKtf70tRgkwxz8NGmI+YPLnZbbROfKP67x3tEIGPquKaTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CuLo0znosM8mHI88o0KGTFXCbWEg53Rq3f5VOz/GjY=;
 b=jeP9JTnozJuMu1oiK9L12p3mppYWOqz4A89f/QyT7Xb+LanIoqZ4yWT3kYATxKVwD1MxLmZuFEUMO+V2qI4YaK5LwErI9t3iOaE0uHIZQOuLArlmzb/Q2obIacmhusftPHOLnZRr3/eAq+qt9sEErDyP1JMgooAoSK5GrtkdAd7NfN1taT301aFxYAOyS05TijVq+JZ8BWfCBS+aj5DgnU8Y2ZF+6uNPElrzTyUAUt8iaTQDabzh0pAuTHR4Iq4BtaDO88pgZ7Gm8HKuS5h25BkQOwnDC6eR7XT0hVuvONHdoL/m8AZIKYIAeuYE11KAHq6YA76jGSw9z22Xyg/Qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CuLo0znosM8mHI88o0KGTFXCbWEg53Rq3f5VOz/GjY=;
 b=ho/ceUQhyOGa1wkYQxNoGMRlJc8Lt4yaRZcnvbq3a0KgMtNLipFR15GBKAvAun3p/3U7Pkx7N9wewKVrb9UU/Fq+xyeax0xjcoOcESvtmyVxYbTRB+UlTI30Z/dCUmPfOwaSdZ0NxGAdnGPLokH+B853LQLc5qhsdZuX9FL55J4zrnbrTnWXA0b5lVose2o4tsEj14tkZnV9q4aqfBrvNtqGwCnC7h9RWi5Y9iTLTilIqlPYhU2HEW5VE2rM7kOfxcK7Kh0ghcdBUJ5Vaxm9NUoAgHdwoDtseuALBskklhobm6+52cUelWoQW73EVRPPN0quh4aACIiYwAEU0sGl7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:56:45 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:56:45 +0000
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
Subject: [PATCH 03/11] sched_ext: Block proxy donors across scheduler transitions
Date: Wed, 15 Jul 2026 22:54:11 +0200
Message-ID: <20260715205622.276220-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::32) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb37bf8-8e6b-4b2c-668d-08dee2b39451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fgrM5EGcB6XS0ZBUzVvlHWqy41If4GDIGG8PGrLeI3N11DmxV2FjxKbWI+j+4rUS5ykqK8SEmVDSj16ZjdDVAN/3C2uhMa3XSNUFssm0xtrs3A0bp2/5jX9Ij52Y9sI2f2oWZ0p6Pk8UzbAarX5Y9AjyE8Bj/j0Hgt6f83REUyVnzb/D3vgKYY0iGnzx+gB3KxEGMkO3BbCSNxFXE84UXP17/c7nBX3l62G7TSDBQY85SE3yR0GhxjEIV6djzvo453yIdfUw8PsKaLHJWaAJ65UqV4I7kRUTpLn9UGBrkKq5p8sRNJttARPwrTi6NRexhM8EXmbf1TOYoPOF6hWFRKHc+t+4+uzHUlA7kwrFaVtUzcqC6/p0R4F4GHPUAaItg+IoziJhyHJhyaMusiV9AJukpS7h7WM71B19t7w8RbtftAWEkALg4t5LsRLvhLkCVr4UVb4MZfmx3jEhmcKQH+2jU5T4p/cdgVnH5N3ZTnDQA4lBmY4wrFXIQBMJHmDUeLK9RFfmUDM0CxI56QqfZvBrJUlNOwOHGRepb0y46L9vehgppWClOVG8OCDe609q72MC6MzQng9yBsEPXORSc8V3dW1I5w040/pwFsS2x6jzxwjEW5yG9mep5Wlu8aHgOX01nsfqDwzmjRud+2SzxaAIEKWUAVrfmnVCvu1xXTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?63Ep41zLZ1NRYJ9wWJt0irTDjmgW684VAzhyxG8q7+lq4BfQY2FZ0l9THjgA?=
 =?us-ascii?Q?M9h0YQiFMvrRShEA2MSg37d2ZHnDRJMZ4fa8regUdHh2n/4ynjG2yP8g9jkk?=
 =?us-ascii?Q?HVFa2Zl9eM2CFztUmFhFDpU0upnZ4suqMqpVMoX3cDqgFYSaqd2pGzhMWNnF?=
 =?us-ascii?Q?FA4JqQ1Bh0EvsKBjH+B2LWzSU9kkGxWQVYMh441/PJeCMHeDqsY9a90iWzqE?=
 =?us-ascii?Q?In//CE38EQ9ddToaW8SPn84m3q3ZvUTP7ZRbxggPfjpuzQx0nz9ZdQXUQ8NY?=
 =?us-ascii?Q?UiXdnzz1kQlDymDIiMEWcTQP931bTLTrUTW7yWsCDMfhq5Duw+zqqECJgiR7?=
 =?us-ascii?Q?Ys2k0osJxz+2KiKTacbkB9eL7qk4ColaLPS69QacqvPrWWqNNxc+5jFRcoqe?=
 =?us-ascii?Q?jVORbJBaLTBH1pLC2pPNWh+FgbRPpRt90ttz9INHpVEfwrXUFeUBv23/M6yx?=
 =?us-ascii?Q?JTn7MsUO8WoGnjIrwPPOOprAqOIrhKcYdBP/HASHjNkPtjSE1FaopYRKswR7?=
 =?us-ascii?Q?9un83QiIVlLfwIeCoEnjugb9YsFrJiMRIgZtJWbZrBcHO7cTq9FzSXE4EMbI?=
 =?us-ascii?Q?l8+qgcIL/NTiuzTyPBmqq4+W6pf10W0lp1Ygrv3rs6VY/7J2Bx6YcQg5HWhc?=
 =?us-ascii?Q?ADTOVkpXNjMdqh7ZirvVO1iNfW6aOGIF9SowFGr6YrGrHiZKptw8mYkHiGQl?=
 =?us-ascii?Q?WN1rN2xIW78tMRv0AMIiNHoDVxDcimzfIXK/BIM07EafcLuCZVeotQri2DIz?=
 =?us-ascii?Q?109ZhBP55gChkD/JhsBSxHKkLf8buQkocgebXHM/XHMeTP8SJCnKGxf/lZ3K?=
 =?us-ascii?Q?olsyi5TYZ4+bcKBZ/99NmDlfafrqspzH4KFMrRAPHLaGJF1b6XT2LiglrTWY?=
 =?us-ascii?Q?+etjXWbaquouvNz82fbNHfDYbhOF/NpnwsnIojQ+aEeiNAuymZnykkHVVYq4?=
 =?us-ascii?Q?PTy7K6Dbqdsgc6wRfxPa50LbIaJquEarLK5jUfe+tY3HhuXnJF4Rjpsp/QNT?=
 =?us-ascii?Q?BQtDBvu5aldQOggsqA9x+bKvaK1ysrPP8Txkhz78m5lraf+ReRLYZSGUDFJV?=
 =?us-ascii?Q?/qyza4MGN8MxDojLA8E2gVL7+rN8TibcV97mnPBk/jDrwd4w6kcFZATi3Cin?=
 =?us-ascii?Q?K56oFLvfYo2KQyfV5B68Wntuh+EG4occCtM0IHrSb1/JxtfbLhKfTTcdaHLj?=
 =?us-ascii?Q?7JRnigbihG3rxLuKtKW4MdDopRGpKOhHp42hMtma6btFXXaxRaHMl1/v5QIp?=
 =?us-ascii?Q?JO+XW3xxek1DzxFA4m2gX+w/9DvotNMakQsDOthwNF9NnHA7mKt2ZvO5opLq?=
 =?us-ascii?Q?7+63oIH1zI7Xy9YnMgsaNUczffijcX+/KDCuZUpW+FVS3nD6i0f+o4I5x2+z?=
 =?us-ascii?Q?ddIdk54/5xdm4ZHh9hAwgWUGZGNe5Bh1VEJOcPxU86+5JZUPP8woSt9FpB9v?=
 =?us-ascii?Q?ttDOsbm9jPG1LH7/+qj5qwUXuAd0R63GldnWeChMEJamCe9dETRoqCN8cYjX?=
 =?us-ascii?Q?GVuN+1UrizsUP8+MdIy0SMDrMo3JAhbtOG8R0jF1ejKNfFdeuniQTnfdkDq3?=
 =?us-ascii?Q?pyjpfm3d6vYszGrRI578qrvSwvG/y7M9MJ80QVlgm7uUmaQ7hhI/819CIpJU?=
 =?us-ascii?Q?77e8KKAnMSFcfri1In+LxYS6G/Pu+0wyZP33xMDlCeZfWCWRCIAWrEKuJMPm?=
 =?us-ascii?Q?mAPk7sXTJcOtVQ74SXy31GJg2TlB3u4Mv+am5H1JEtu4ed7tg2zWHkC/xLOB?=
 =?us-ascii?Q?OYtwDw0ZlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb37bf8-8e6b-4b2c-668d-08dee2b39451
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:56:44.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vm8lA9gEosYiII0FU130VnqMXJDMiust/SRqCyz/mjzvEpMu+TNyp5zM4rdVeSzIE9wRc/BkQDTFbcqDnMZpVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

Proxy execution retains mutex-blocked donors on the runqueue so their
scheduling context can execute a lock owner. sched_ext cannot safely
retain such donors unless the BPF scheduler explicitly participates in
their admission and ordering.

Make sched_ext reject retained donors by default. Force blocked EXT
tasks through the regular block path in schedule(), and fully deactivate
a retained donor before sched_setscheduler(), PI de-boosting, or global
activation moves it into the EXT class. These hooks establish the safe
default that a later opt-in can relax.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c     |  5 ++++-
 kernel/sched/ext/ext.c  | 44 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/ext.h  |  6 ++++++
 kernel/sched/syscalls.c |  3 +++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7827cffc2f0c..ddc832035854b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7173,7 +7173,8 @@ static void __sched notrace __schedule(int sched_mode)
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
-				  !task_is_blocked(prev));
+				  !task_is_blocked(prev) ||
+				  !scx_allow_proxy_exec(prev));
 		switch_count = &prev->nvcsw;
 	}
 
@@ -7726,6 +7727,8 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (prev_class != next_class)
 		queue_flag |= DEQUEUE_CLASS;
 
+	scx_prepare_setscheduler(p, next_class);
+
 	scoped_guard (sched_change, p, queue_flag) {
 		/*
 		 * Boosting condition are:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f8f8597b6f781..2035b71671a75 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -23,6 +23,46 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
+bool scx_allow_proxy_exec(const struct task_struct *p)
+{
+	return p->sched_class != &ext_sched_class;
+}
+
+/*
+ * Called after sched_setscheduler() validation and immediately before
+ * sched_change_begin(), with @p's pi and rq locks held.
+ */
+void scx_prepare_setscheduler(struct task_struct *p,
+			      const struct sched_class *next_class)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	/*
+	 * Retained proxy donors need admission only when entering EXT. A PI
+	 * boost moves an EXT task to RT/DL and may keep it queued; the matching
+	 * de-boost moves it back to EXT and therefore falls through below.
+	 */
+	if (p->sched_class == next_class || next_class != &ext_sched_class)
+		return;
+
+	sched_proxy_block_task(task_rq(p), p);
+}
+
+/*
+ * Called with @p's pi and rq locks held immediately before
+ * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
+ * is updated only once.
+ */
+static void scx_prepare_task_sched_change(struct task_struct *p)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	update_rq_clock(task_rq(p));
+	sched_proxy_block_task(task_rq(p), p);
+}
+
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
@@ -7298,6 +7338,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
+		if (new_class == &ext_sched_class) {
+			scx_prepare_task_sched_change(p);
+			queue_flags |= DEQUEUE_NOCLOCK;
+		}
 
 		scoped_guard (sched_change, p, queue_flags) {
 			set_task_slice(p, READ_ONCE(sch->slice_dfl));
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08c..d708abf2c3bb8 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -18,8 +18,11 @@ bool scx_can_stop_tick(struct rq *rq);
 void scx_rq_activate(struct rq *rq);
 void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
+void scx_prepare_setscheduler(struct task_struct *p,
+			      const struct sched_class *next_class);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
+bool scx_allow_proxy_exec(const struct task_struct *p);
 void init_sched_ext_class(void);
 
 static inline u32 scx_cpuperf_target(s32 cpu)
@@ -52,8 +55,11 @@ static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void scx_rq_activate(struct rq *rq) {}
 static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
+static inline void scx_prepare_setscheduler(struct task_struct *p,
+					    const struct sched_class *next_class) {}
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
+static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
 static inline void init_sched_ext_class(void) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a60..2bbba3dc8c890 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -678,6 +678,9 @@ int __sched_setscheduler(struct task_struct *p,
 	if (prev_class != next_class)
 		queue_flags |= DEQUEUE_CLASS;
 
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS))
+		scx_prepare_setscheduler(p, next_class);
+
 	scoped_guard (sched_change, p, queue_flags) {
 
 		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
-- 
2.55.0

