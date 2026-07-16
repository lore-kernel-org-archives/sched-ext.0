Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7C423775
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208185; cv=fail; b=AH3Av/2b7OSbeHj2eY1NMz0tG24252eJSVZugKvttrAI0pBam9BT6FzaJNFE9UaYQn8hd9SaEskLf8scKcaiMszSoynhbXCallKu2FAO6QSeme6pJ5GvciR6wc4Sr8EHDr7XgBvrpFAy2rrXfMkFjrQxYPwERdauT0vj6zzaz8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208185; c=relaxed/simple;
	bh=oYkR2yY4eKNv8pFepzlaZor8a/YXbx9tAZqPk0KOozg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQ/NJy3blB6Z+aRukzA8XyMIiniSp1OPxHBYAqIAgPtuTooSawZ+0bpM1RIhD94DioGGllMcpTPKQ0oMXH/yZ4gymYjryiVRACbIoLjmNO+N1GWTIiPWh1VjbF88iehfiR5zi/u0Ya5/HpsW3iOErKlgrdWQxcuLAVsHx/3eTHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uZ/50L8r; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uZ/50L8r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COhjexVoHMcFotxXiiC4b2PHEWNbUaO9XLNBfb0OzSdZ+QSiIJd2jqCwHrKVkmAvJSQro5wGTbEBbHwWoNfFMcALoWDNCKtrcgWK3iT67a8gn2qccOZ2tp/S2BU/7ndjY6DFwQmY9QSNEPb3MGj/shqvDQ4IkN/uc2xVM3OjgGdUdSs3MFTBZWm3VI0x9hWnGX7hUiqfzub7bJlAVMnlACk4Egou08r8f4AkhmpMvkvcq2SKOIcr0q5kQ0bPTo+98f3nG15EJ0hwuFlm2BbuWmK9pEQo0pCZKc1UjnlzJLd8LsLWNH58JB6/E9ACtbGhQNLF1hPYGvYWGytv050yPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+FMDOw5fN5QVB7MLZz55FeRra0cZvVWB8xfJuxYZeE=;
 b=ik/p7uY1fUhUj85lvKdcqMFoYMSSf6FG9uliGwlOmbTAVimx3iEIbjn3YlJioIL4WqDxXBuRlu1GPSHvcxIVhMRntRLeN2Gk/QSeSkGIhXrIwGLYWk0RXsi9VYRIIxLn+6Rv8zWg2b57D7vzP7MTzymXi+k/UST0Pi781Ec6M7Hgg9OGiu6t+qKR2fUjB+FVQC9LQoXFzf4+8V0jN4vOh++AmEdRl6gnK6aoRiDwvhVgdHvSPdE57MvpFhI/sPhakss8rLzYnNQXvIbXOCiGkDIyX5Iwj5/PPrHVup6cjPM+/W5bImgThvrP97X/l5F0/egqDFAdtv3HT5AIf3Jbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+FMDOw5fN5QVB7MLZz55FeRra0cZvVWB8xfJuxYZeE=;
 b=uZ/50L8rJ+1QcWe+axQpS80gyL/qIQMki+9qY6IluCnEzQz4FHetnOZgKB1+Es4WmLzOibiPciLIrt7c90sPO0jdRXtIiiC+XwlkN4/SM57+8QWc1YQ7aEDLc8a/CWXk2UcZkW8UMoZhECXgughm7QVtZ3JM4eO/V/PkI/rx1XnSGvOOLDyfOSFhwoEluCbAUhzcPxJ5+FR0NJXu0ey1EMPUJEQdw2mUKRHZypNpd+AHl/OP5//+Rn4gYVbQ4PVmPTO1iKAtVxgUld8O0F/QdrCCzmTi09Ff/00sGJvj4JHQQT66tyhPhBH400ju6cmonXyz/nOlpFgbNZT/eR3+nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:23:00 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:23:00 +0000
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
Date: Thu, 16 Jul 2026 15:20:38 +0200
Message-ID: <20260716132229.61603-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: b27ad0bd-6664-4839-3f05-08dee33d5b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	J0+KXaEU3bXimSfhSuIuYXy14QIuk1Bwu+jrjly5Dup3OkRrNtrG2YagJHLL/MECgnxl9t8tvMG5uY8iINhXnFzoYeHaowhd0qedwaUQO2sWLt6IZAccnzRKg/IOqzBGHiYm0eJOxizEb2KSZQGk1Qh1tiGyeNIFBLAGlbpFjC6cs5HItBRXHjwHbWXCrYIB5gBNb2kHI76CV+jKfx/rL5pX+pQwC3Db3Wv3raCIZbJbNRXvOomSLc8ga6HHVGrPgZx+m63BxL922Ly8M+YuCVo/y0kEi6e9+b2gDiY16KT3b3tBkriTf3k6PLZz9FkyqWrbaj3aPNquIlKOzxK+M9AkV1ptwj8eMYYaioE4vnvO3X9SBfIYN+2BvuCrW6ZaTR4MkzThvs4EV6hYc1jTc40XmP6a5YZMrJpgbbs0ki53PRAvQ/3w+KC2yeD0pVoyW7mXJWullTGAHoRrRVDPS559BH3IrxdpurZBAwsaK2Y3RYFRDPt9iCmLNWpRHohjIbQVLu+pdWf5BJz3Rtxx32Lp6Ecfg6msmWvK+mdc8lTVujETpUHM60C9uH40IqzdSpIkDg0xbTfi7ltesFgxN5WGWHZ1Tf3TAdPE5pZbfNecJ7D4ypEwrbM/TyBhz/4JgCfIlTp/XIq3KlcTBqhlxGWIYvcQuMoEwkhNygLrKOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?75NN4uS5nIOXm7XnxXOlw3MqZcxrSdq4yFXGR45c2u0ynJe0h4VLtFADgIY9?=
 =?us-ascii?Q?53EvG8e9Be7f7m049RPIAdDaFvKgb7Z741ek2HTqr5/Z1TGQ7fF3mWqFwCAO?=
 =?us-ascii?Q?0zWw4SiacmlnAbbvGOY8nnUf6WAYGKT3XVS7yrgtdm9KvVc++HeZC+0jRikv?=
 =?us-ascii?Q?aXEQduwO1qWXCUKW0TM2Le1hdbl/MW5IR0ce6br9+Llf+uU/xLzIhUCdpz7y?=
 =?us-ascii?Q?dDSBLx4OuZMCmdQS1XglPVz8QT0ds5ET2xRbAUdgjzbaiCdkHCHgcWg5urDJ?=
 =?us-ascii?Q?Xdj/TdJ/+EaPsVNY8ndruQpmA6lC8+ySY40NHQcu8ofkn43rgAcIruueIyk4?=
 =?us-ascii?Q?SD7yw6Yj99En2qQ9RC7R9/HaMApem37Q4L8z3dpsImpT07S6DxaXXazqM17K?=
 =?us-ascii?Q?rtx9OYlDbzRUGR2Yw63qFNo6zaJlCAOJ/AxwHlsAcIbuZKSOhZB1OUmtJZqm?=
 =?us-ascii?Q?w9+pow6mmdhhWJnoha8pqV2RXq9bQmZawAzaoCofmzfza45hLC02m482GEUA?=
 =?us-ascii?Q?tW22W684LPua0TEjYhgUUl6PsLmIhyWp6cWu5h56adIAbX3mzffhUtRTfxxa?=
 =?us-ascii?Q?2D50OkikiHZoOwPHW8t7jjAvIP+rOL8iGIDATB/i4bjlvyK9LQOLc9mjyoDz?=
 =?us-ascii?Q?36EYQocepxic/3VT+TER/U4pZ4Iec2p17PSDfXGVCsZO5ZyjT5r6hH8c+ZL4?=
 =?us-ascii?Q?fNqltitmkbPPsxsmOMotjjf5ha4QKEy0cvogIamzcpnbe87pFZHbBaUXA8Tu?=
 =?us-ascii?Q?qLbPJBMMfOGXnDzHAiTAem1YMtqnj3djxpPKm9RJ2eut+4bmStiL/iuhrVBn?=
 =?us-ascii?Q?tjzsBb7fuPtWLcmwzuGaQgOugwu1PjeaNWKFpokZ/iZ7iAwceb1yKduGFlYh?=
 =?us-ascii?Q?0B8kQZQA0Dks353C92tAQ/WFq4lseSJgzWf0kRYTm+omQX9NvJlyh4gXQrAS?=
 =?us-ascii?Q?AmVz7vbUdDUS1MZf1hZ/qwetLqGK0Raiw04tMHdQ43kmJh+H6paeuuDwI1GT?=
 =?us-ascii?Q?dt5wBAQDH/EsCei4vrCefitU1LwnmYRXQmQ+WVdi6sMIV6vs3Yk12+bRDAQl?=
 =?us-ascii?Q?f8EoZWuWf6reF3+EY0l6BnFvF4/yByEivnJHrE0DbXmExxyZa/4+R5V+bal9?=
 =?us-ascii?Q?wdMT3KQGq8LAMMVnCQTbhAw/btmmfmxtzQWSZPcnLwi+WnHDOtWmQwIsMrAO?=
 =?us-ascii?Q?Xoj4cNMfGLAdVA65OwMWMI5Df18v2ot/D9XXZl4gTadG8WTxWXqnAdsYg/O3?=
 =?us-ascii?Q?gwSNExkmtlEkv6cnYgDeHjVGnPlXQhZHKDpVNDxBJzdDOYpCFX5RuaHxlydR?=
 =?us-ascii?Q?dEl6io6eRlU0cI+KjLMDdPOMh8b9BUmDg8n0BPlJ/QRvLDlp9ff/QSdGWM2Q?=
 =?us-ascii?Q?Sh+oDsVPz9sfUnyc2r5LhRZxNu9MdvUdFpO4B66aHMleljOhN5YKIJf6AgTa?=
 =?us-ascii?Q?JjScUVI5FGHN8EeozU87uv89Uxfh26VjKqVSdtguTiOnlt36x8ixqiJpxrUv?=
 =?us-ascii?Q?hjd9JAY+ZlwKcd/gMvG+dwrdRNzypDmbtN/p3pUeTkh2N/BMHut8D9wFlSk3?=
 =?us-ascii?Q?OiXsWOphpOpvr4YPaHkn33zzJWabTLtVk41NZPdE8oWnqd82aKwH8pThaEd/?=
 =?us-ascii?Q?5TfADaIajYNXBvlpoXq5T4l330mPAsgkRNIH9gQ9sU6iXpKnBcDnwVPEnrxy?=
 =?us-ascii?Q?8UOiDoHNhvB0hq1NGka/PZetX2dUJYocKfNwoxkMKx2440TzF3JN2AQO3zPb?=
 =?us-ascii?Q?iutDbLs9sg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27ad0bd-6664-4839-3f05-08dee33d5b6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:23:00.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBRtnUCdbYlV8hFyN/TsedG1fo5QwipcC51PWiePg5YgEQAEjx63Pki0oavyb7Psqtkhb/SDFhC5UrgfuNup6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

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
index b3b8cf95e0f7a..cd43283e54d8d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -24,6 +24,46 @@
 
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
@@ -7303,6 +7343,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
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

