Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECF56E05D
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096123; cv=fail; b=toaeFt/DoCy+QffZRDH8mwUqvHznfr/NzSjh0S3JFTzMsWhYtYmzCFy6Bcn2b7QKkan0ZkftUPTHI0gTlD3mMY51HN1k5kJB4zyeH3f8DEEcuBx6UOuBgBpci+gdNoGYFOjl4uHdvQKQTnjpZvCUO8AcF8o48imOkoqXcl6jBfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096123; c=relaxed/simple;
	bh=e4bdmw+MaQvuua4WYW34XgMnWGZEDmh6H+TmMxqGXSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYrf+JVIYaiCb0Ao6I5/vYH/j3Vx65rffri2HFVGrbt/dqMfZtyiilL8+sGJNsLr0aO7B1544PCXS5M65xDQ3SzokiBjGyH0+dC+V5g3+ootV5j5FQX5NCyhVSgKLqP0iL9rjA9F17fHRG9zoLCl7iF6PFbW8HHyOEpqXM2vkBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Id0FhfRB; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Id0FhfRB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wshPebB+T899Bh29ED5OrL8YCaM9WkJlffCwxQ2Em4P0wm5eOceixLwu1L6QzbiVa98el7mgawDtZxSRADVP9MYiFzS87aPRdTtIiFg4l50sQk1ro4ahTCrwGvICxnP/PJYXgl5s1W7tdhowFZwBE3m/yuFBZG/Qxg+4hqTuflq7VVHpWh3sPx6vgDU4ESdbi1hGSe0wil7jE99qXMNX4dKdnR3RFKpw3/2CpK2JQycdQeKmI/j8GtMG1BKQ3E64jmIxhznitQAAGIzXFABHSrw/HTQeL1LD/J6DkRiv+wgy914O5qVgCClnwn6Qv0CkOcgMLT+HSIgafIoTMI00vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkpNDJLWUW6FNygCZob1oWxdwDzrGIKdJqsHzdwyuLQ=;
 b=q1u2djQEhfpybNJqYdE4LYthkZTOBLwHh99nRGLnX0s3/PJxG4PDQ4JLI5gBBYbkCY7F7ozebW7M9o9u6pi47KbDJIQJaVexAUMkXVtNL3FmzlJzEvrQEovfA4i4Ek8cQoo70n1FT0bH5h39k5zX+hpTiltlC76FGlCQNUxnpwPDc+e17XnFcNZCwIZCv+E9pQ/MCoHIrxgQBlrSjqwbr+SocTKQdIQu3/+CFygxl3h5rUmahYoCcyak80+WPeOyOo7R+GhCxB3zWdHDtdl4p7k/wlL8JhEknRVGdS60l3v7K+DbW0zqUTr6pxPXLkb8dtuzFaJl0Mwu0uw3Dddcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkpNDJLWUW6FNygCZob1oWxdwDzrGIKdJqsHzdwyuLQ=;
 b=Id0FhfRBav1DkGOZOQA3Od5fK+2SsZMLU39ALtNVm+qp8H2Ei8W1FZFpIH27t7qaLIznENVt37EdNkfDyQzJ6svRRhJT7km1loCILbAe75uYCYw0/Rs6AiSUj1vtP6zdxd9RKQ2EHYv/SSYucPY17jqbmFFtina9388JeM5MznbRO/ud9XyGFpOVNCS4RTUC819e12ntV84W1kL5elP4Nuv7yALSWo4B9/1dhMqbzGAA603QPtqOXdJ+r05z90hab69nk89CrAxXoxbvX5lIPfl1ISrz+kSk7L5jz+/rZBMDqFACFgRmoPkYkvyOHzhLUKqs/nLBCPrQ2i7WGXdPlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:55:18 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:18 +0000
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
Subject: [PATCH 06/16] sched_ext: Block proxy donors before taking control
Date: Tue, 22 Sep 2026 18:51:45 +0200
Message-ID: <20260922165445.943315-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::30) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6a90ec-2675-4336-a8b2-08df18ca47be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|5023799004|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KYllAJ/Gus0JichaS8abim0jixwk7gJvpSBPr1q1uVSYDXL2RRVrXFPVXtwZvQyEkzGsLez0Km7Ti8Q8c8s+die5vI90p+NZ6nFu21FC+W/EyA7m6nyRgnjtIIaVrOvqVyrPVhQ0Nb/KoHVFWWHl2HmZo5S4moraoXJvACHSn9Nk88gbyu0DhZR508OHJtdXx7zsgIFhi45dQgq8Vm1IfWDO6vYd/MGIh1gUqlLdiZ+N/Z7WkPd9fNLzXUpbEAydMaceGQOne7WFu8DSl6pzDGIE8ou1gLXLtavg/A2NxEsRenN112YcA5reutYwmC8NYLJWfBkY/GKBckBlEO3mfSmWx4gTYfBD9kh0aLEf5N0lKEH/8nJznhoUIlWzCARo28MaNBNDCh2teIpczV8bnTHR4EIY0qVgY0ptGiDdZ7QYsvyEC32he4z1HbTXe0zh+ggnd8yDqPNurVEd5za1OYSjw//u0nt/i7KJBkUCqH++Q7/A7dURJvVIH/iNIowOBQxg4U9X4NP+fH3eBRTQeQv9q+4uuc1ZtvJgyYPpMCbJkNtt3u9ILTULT38jXjrXEl2RSBHtLpGzSv4fsecDVnm9efbhLe1iBm5ZVlVo63MAG925BHp2yUCCoopaWbymjjeTPJF7whBui8D3XBHhR/NEB51IVkrlH22dgDgvQoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(5023799004)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aUhBOWB3V2bET/IaEUDys4aseBDogEF/UFCcmRCdxJnXqrHRbB6aUGiE8SKd?=
 =?us-ascii?Q?H3/v2aMw6YDFDPbkhDSQTjcRFtm/SQRHsad5fazfhugO7KCbCiOG+Xp6xVs8?=
 =?us-ascii?Q?VRsAXg+rmpsnzWuu1ttiTsJdeyWC/2qAVTaQPJcpPBk5pUPXhjKHhSFNGY41?=
 =?us-ascii?Q?8vEbKgzZHb6nCljJ+uy6PvhghmVwDauUimlyp76+jNwbB0S25uA+mkgYrNJE?=
 =?us-ascii?Q?AgG+ENcsh2joB2FQpIpV9VnXB5g4fgtCLx/Zu8UwVU/jUNzP1NRTWvJyyMUT?=
 =?us-ascii?Q?9l8kOTBp1B+QQ6oM8oaA4nMlsbNxJYjnLANReH3vOtl0hIcyZrn7rFUALwBX?=
 =?us-ascii?Q?IOUrblAhSdvq5v6ETr9oXDcj6F3ft6NUr+LamzGIcUFmqdayPBTfziJsrW4S?=
 =?us-ascii?Q?q5MuK5Hb8kbyT5Hol7jlMRWX7asipJPNLX/IzssuO6V95d2U13Qq77S5TmK/?=
 =?us-ascii?Q?kb9wpshV/N1uIKSJU9SrJ3DjqfJNN4QHIt4gL3mH3vuIEdBmg0WwPbLCzri0?=
 =?us-ascii?Q?rsL73RlSAAUSSn+RRQ2Q84o3q7wnGby7dPEEW1EvG/9HIvk5S+OfvpQDRHoG?=
 =?us-ascii?Q?k+2upKEj/OGSpkVWeR5blehN84M8qkXZdvByGgqaRYjQeSIdvpiFy2ugheY/?=
 =?us-ascii?Q?0aI90n72nqJNakIcAKfvWa+qZVRSJgfMmElFXP2hKbgDxHV5Yg6IAOzIs5NV?=
 =?us-ascii?Q?xnJyIovSOf0laI/BOxo9nD23TGJ6Mrdk7ZaD2HHIqV/hvQhxLKK/auljzYc/?=
 =?us-ascii?Q?jLk+wHbS6k9hXUM8HKZqaoXZfHF+v6rl6wytXWxFzBThA75PUjP+mUeQrKVt?=
 =?us-ascii?Q?q9P8dl/Da+FB91kqlEF475rNGYp847AaXYT/iGRyV90i4i8LwHgm0IeYqdkl?=
 =?us-ascii?Q?rSU9uiugYUSiKHQ6aGbQzJKtUaGraP9XUnztYUaMZhOv2x+G7UHbKUyw6ou6?=
 =?us-ascii?Q?LcPdaPJAVOug/A7etSWf1RC4BLYYNhgU+AMKTjVfnfk9QagobWEZwAjE8ydJ?=
 =?us-ascii?Q?rUvBs4OIkN5t6aBSAqIL2QR0S1chJ/rmtngk810ZfLctb5tKif65edNtct9K?=
 =?us-ascii?Q?MFHaDG+EMuKk832SwmRsGEi1skagxUFsa3DvB14v9Ywhb43dDZ9oScbdGTxE?=
 =?us-ascii?Q?y25gv4Gaqjj1kKdIo8xOOvo7sOexJnZzmZqZuvgLDBjWl62UsCALL5N26WMd?=
 =?us-ascii?Q?qdtda7PS504IUALKGyD491Q0PKAfM5MVwiQjAv/J/fu3eBT4jqOTOhVShj+J?=
 =?us-ascii?Q?+DRjXru4ECte7c+F8NIPkW47T1KN32V5/OcIEHhZOSJm/2SrQrAF4X3bzi25?=
 =?us-ascii?Q?JR6utyQN9EjMu1U5jHrbEVpHPKBP933lmND9rzjWLqlg1yDhySdZiH3P5mGi?=
 =?us-ascii?Q?RLAZksNEcRbnQKsi72TAm/z6JiBwCWmfZtpt0meBjmo4cphf1w0dyB/R8ZdR?=
 =?us-ascii?Q?dDB1O1f5YEqyv/TTkHWzok4OJr34XcGr8Ebsko196nOH9ongiJgar4nPGz6G?=
 =?us-ascii?Q?opbdrYcRglyF9IwCa/pHmuukRIWTZfmboCRADk1EY+wGESomduByNess5bWX?=
 =?us-ascii?Q?fM+9JSZhaPnJO4jrhv/r1PBTbF/PaHCDH/p1wlMCVv76KaH2HxYSr9KIq1lZ?=
 =?us-ascii?Q?4vcYXKJoEXUy5R6NWaBrBHLIoJneZjBOtS193gLsk5o3c4vMAPpyXmQfCA+/?=
 =?us-ascii?Q?TYQgHvOoFAMvQnEIYBy60zqNUnbTK+96KASU5ViLz7bYJY7avmx0CnH1jQZr?=
 =?us-ascii?Q?c4OEK9VCPw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6a90ec-2675-4336-a8b2-08df18ca47be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:18.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bm6ROIj/L7TbubwdKau4Hi+aFhGj7OlR256a/J9JGsZmgl5iP9qJp9BjUQaaJK7ItXbS8PFU6h/EyHoKan6GJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

Proxy execution retains mutex-blocked donors on the runqueue so their
scheduling context can execute a lock owner. sched_ext cannot safely
inherit such donors unless the BPF scheduler explicitly participates in
their admission and ordering.

Make sched_ext reject retained donors by default. Implement
scx_allow_proxy_exec() to force blocked EXT tasks through the regular
block path in schedule().

A donor retained by another scheduling class may already be queued when
sched_ext is enabled or when a task switches to SCHED_EXT. Fully block
the donor before sched_change_begin() records its queued state. This
prevents sched_ext from importing a proxy session which the BPF
scheduler did not admit, while leaving ordinary FAIR, RT and DL class
transitions untouched.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c  | 37 +++++++++++++++++++++++++++++++++++--
 kernel/sched/ext/ext.h  |  2 ++
 kernel/sched/syscalls.c |  2 ++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index aaa6ee66917e8..288d479c71694 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,7 +26,22 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return true;
+	return p->sched_class != &ext_sched_class;
+}
+
+/*
+ * End retained proxy execution before sched_ext takes ownership of @p.
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
 }
 
 /*
@@ -4370,7 +4385,7 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 {
 	lockdep_assert_rq_held(task_rq(p));
 
-	/* if disallow, reject transitioning into SCX */
+	/* If disallow, reject transitioning into SCX. */
 	if (scx_enabled() && READ_ONCE(p->scx.disallow) &&
 	    p->policy != policy && policy == SCHED_EXT)
 		return -EACCES;
@@ -4378,6 +4393,20 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 	return 0;
 }
 
+/*
+ * Don't carry a donor retained by another class into sched_ext. The caller
+ * has updated the rq clock and invokes this immediately before
+ * sched_change_begin() records the task's queued state.
+ */
+void scx_prepare_setscheduler(struct task_struct *p, int policy)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	if (scx_enabled() && p->policy != policy && policy == SCHED_EXT)
+		sched_proxy_block_task(task_rq(p), p);
+}
+
 static void process_ddsp_deferred_locals(struct rq *rq)
 {
 	struct task_struct *p;
@@ -7892,6 +7921,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
+		if (new_class == &ext_sched_class) {
+			scx_prepare_task_sched_change(p);
+			queue_flags |= DEQUEUE_NOCLOCK;
+		}
 
 		scoped_guard (sched_change, p, queue_flags) {
 			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index cca3f7c97b788..8348d6008651c 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -18,6 +18,7 @@ bool scx_can_stop_tick(struct rq *rq);
 void scx_rq_activate(struct rq *rq);
 void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
+void scx_prepare_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
 bool scx_allow_proxy_exec(const struct task_struct *p);
@@ -62,6 +63,7 @@ static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void scx_rq_activate(struct rq *rq) {}
 static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
+static inline void scx_prepare_setscheduler(struct task_struct *p, int policy) {}
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
 static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a60..45a127deeadd9 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -678,6 +678,8 @@ int __sched_setscheduler(struct task_struct *p,
 	if (prev_class != next_class)
 		queue_flags |= DEQUEUE_CLASS;
 
+	scx_prepare_setscheduler(p, policy);
+
 	scoped_guard (sched_change, p, queue_flags) {
 
 		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
-- 
2.55.0

