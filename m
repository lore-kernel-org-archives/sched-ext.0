Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A143302F
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615626; cv=fail; b=i14pMSmGQtS7fnfsIqfbQViMAdYcgDWUtPqfxq2zQiZHcH46BQT7LNAWU/nfqMoGop4Q+HeXa3w1Y9UK/dy0gD17ibAYnCx/h02/QsQdxAet8h0QLS3awB9Z8sitFYVBfw8kYmnpes+qVioGhoZD+EuWFnPIYc65D61wRkWSazk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615626; c=relaxed/simple;
	bh=rMxehciKa85mnrClbH8kLPNyiqkktcd9RpqcTpUcv/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUeSSG/DxBVmFpECJJkfIpYpPy6LURj/zJKtGpQP7yJTfQ59Gkd0shz/oQI5YDck2pI4BIdYTAf4/AoyDxnTW8YI20xip1YboNCTIWjUgo+ahkJqU6zLytn18beanKhOk3dL3AIOE7KGezOTkp4jvEEmkhVDrBWtL2TyPwtC+vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mtbGMvXl; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mtbGMvXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQz5oSJ6twNfaSR7h86QLhKxiDv7qFRLvUA0Qlh69C5N5fECtMfmXFJjRDE30bA+NmyzQKQZ8PSYzo4xSmPDofdmLW3RtCYWYRqrJRCqeNDoHLjv6hhGjD+GBU9aUWJE0sSq9vlzXDoo25vPU8jNyDhswowFfsD16/IklWA9Rhwsef0Hv5ZLVLj5UQxPGhYwqNP+lu9t54hgYp/PiHucWA6TyyNh1D3oE4zA5KPH+BJpgodySLv0gxtH/nFiWDpiL2YRC0b7rzxwTszJFfW/5W4HKSmhaRkhV9okRXO7b+Uz+FLRfiCD7tqYh7jDa/E8dKGr3jSndkXD1estodPRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUbMS40JJVqmVmejIH9PAl+a2fW1HmdIAkicHC5tZnQ=;
 b=Vn9FRNYDbzzOpA77H+bZcoqtpVH/CXpI/Lf40ZVw9+XFwAXQfAhs2ZN4eqkDAzKAAJg2kTKHkWdmqsVZp7DGu9ZQFbGj4Gb/8hciWOAUKMmjCF/2OMI4HXWMF7NQcfcXsOiobifhuh9OFEEX/KHZpw3dm+63o5TKqx0MqIdEmyY2McWgkbWnA9AwcvKEw2eYVG0bjmbgoYZIZnQIXlyt0iVg3YIWrc7J5xoCec0cRihPvqCBD/U3D1IfypK3K6VPb5/ooSa/qfMCiKzvcKUwsbQKg8HDXgptMNXut+Sg5pwPYN0nYVeBvHujzmCQPC6/8I1wv4bN4c+o5pzqCxLgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUbMS40JJVqmVmejIH9PAl+a2fW1HmdIAkicHC5tZnQ=;
 b=mtbGMvXlRUJeoiWW9yKYRBsTFue0PAopsNZbAEr2kRMk+hYu2KTRINorXBUZTwiJZsFDL0Tw9o4kDkcUIZ6qH5CHutY8j43Grv7TUPw6ih4rBg7XuEWJGi//qVtzebKX+r5R7M21oBzatbar97zBRBwisqTNv435EyteduXoRkRNq5oo8lMCLIltSPbB1P7Z72XLygNMlU6UNptdYb53xoqc7ulfCsx4ioG7OurSCsvMQClTAo6XR8DSFfCdN5ycjJJ3ThZ1mt7oT5tuS9Q2JxJZJTUWO0GtihFvZCkRBhDaprBEmsm6waLetGi7SPVZC0K04FSkKBqvd4mIEteGzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:33:38 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:33:38 +0000
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
Subject: [PATCH 04/12] sched_ext: Block proxy donors across scheduler transitions
Date: Tue, 21 Jul 2026 08:31:25 +0200
Message-ID: <20260721063242.552774-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0143.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::22) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d784d8-3849-45ad-2fe8-08dee6f1ff62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k7QVBuErUWYLofX4+oJrXiJSUnb07f7SeD6hRhFD+GAg52DsOKwaL2CsZm9tOZ72Fj/DtX4ZIN37lOz87aErfVhNim0mB2TOqFcMoMmYz2EEYoCAHNosqGx7R1Y4nV23daDN6GYyfMVdg+apYcKMXVrwUKKr7s1TK35HQxKtRrD1Xp7zcvPrG+NYthM7sVUSImPHLxJcwaGDFgZlfGcBBNmtUQcqkuDPdWt7koeobMmCDowYP2Y1WQ9uzmG6XGnkrfVg5ppzrmDNrbzNgfeKHqUJJq2SJuXhBQZuna4FO1CEwt20EBMkn89AeelT3KbnfjMnHJvFzZUBv7hG/81277Y6d7+xZ1at/4dGc1Iu12n4PveaCtkK7laYVtQaJvPqI5hFaoEZShsKMJ6IJaRQV3eTkBxFjbgAXV9EfLUkwc/T4qFd9+DHZ3Qeij5aWpYIJ4XKbO6RVDqZZlUL2ctk57PqKFKji4uQPn1qMHlK7HX0HKDxH8lVipkYKnKWTOJvbxLLz+bi5ORO1pmdCqCgeRorAmgh46FUf7IaK+TfC4dHs7wGo0NYCF7bRCr24QzxkoFoS+F4OhhSvfluUceKBHtrL5U4gn3Lko69necy84QG69S+lyXkkj9Fdhfc8jwF8ZIOCd32uxDhxe6l7vFq773+t/EbYZu13oxsprxJh9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wMYKmzgnO9GbUVjEposvdMTW5TDKwB2BQUMQZjNoQM2ZRrXI7niomm08c/O?=
 =?us-ascii?Q?+m/5BdBEuO0abk8uTtE9f2Vi1aUBZ+C5xaf0QYFmbO0zz3wnizQGTV4MpOZz?=
 =?us-ascii?Q?AEfvW42KAEPqko7yBtPEf+mQVugpVal2CCsx3ZS+1GNsnm60dO+rzqjfy5o3?=
 =?us-ascii?Q?Z6Vwi+k5U/D4IIMCtndVhkaf42IOcttKcLggJWSuFmn/MQ06qOueW4w5C8Ch?=
 =?us-ascii?Q?hMcNILtXqYe7a72Gc6e9cl8J/nr2yhPRoJ4jO3t0NJTEKNjNrNr0H6FsCmpk?=
 =?us-ascii?Q?GitRoIm+B2Yb3FolTrjdh1BurpTr/al8i0nSAplYgRDOeNjNi4jGzvDfX/Nr?=
 =?us-ascii?Q?KsyC7w67rPUbbaKNILEc9s24xagi/b+6H08RqB8FUS/yNon+V94cdjWJXqG9?=
 =?us-ascii?Q?/yg6LDB58sK6eNykjr3WzvLIrx8rDSe/DnR1wVeEsQnNQTSexyc5nkdAbb09?=
 =?us-ascii?Q?ycocR3qe2Eon7Ciny0SZ26IhbhS5OjVoO8uZxLnN+BCmGld2kfgZscciiF2g?=
 =?us-ascii?Q?mPFxVrWH17K7ahX1PEfO26MJRdn4f1oXH4FCtM10lx5VUdDnFIVgOzqrVgI1?=
 =?us-ascii?Q?0MHLHs7SZhvaI9nyOkM5hKpwpgJghjT62lvzlFJJbPi8Fqv/Lw1ruvxOUNGK?=
 =?us-ascii?Q?s9QJwQu124ZHGUzwzEDF6blAU9LVtkSrD3yRpLGgm2sb7GkXXV2mGVhRRpus?=
 =?us-ascii?Q?H5p55YOA5MYlKatEByTGp1jOxUnE5XBgVt5EXSLV1pxKuRfepBitq+zPtpQn?=
 =?us-ascii?Q?HlOs22PirW/TmoV9PKykBBV9o+KolLI8GFWW0uw85Ic/oFQQ7dj2nXmmky9s?=
 =?us-ascii?Q?wzrKcCYJq0S2kl2izM8U7S+wLWGUOBxSbe+OUYHpKtIBi/rIdnyJDv0ISiPF?=
 =?us-ascii?Q?r4akbn0S6qxKOszyc9bjhsV8Z4erHPfNaYO9dhJsnnz5vrEsbp4HdxnqbHgA?=
 =?us-ascii?Q?4XV8c7C8cj3vlnfJtvp2wYHF+5+yCBU5jUlgthScqdbI19dEg1sBSJj9RRE5?=
 =?us-ascii?Q?YWE8BKdstJAfFJw1vjNm7JUwqM7mJGURv+syVTn7Z5BGe0gENGq8sYFVnVjK?=
 =?us-ascii?Q?nJs0+wPCb7vyOYrON280pBNG7RyWF2+WxDGx4asUi6omAl1m9GllTxJPYYJm?=
 =?us-ascii?Q?GJLS6TutYvbOsgTLdnLw/9L9wIh8+PLMmyUJadGnou45sWlPmqjEj8eMy1Of?=
 =?us-ascii?Q?3rexNj7DPmq63VIHriqfUuk+Ci6C65gDi9PIlyyVRlS7pzaRPFxQE9vH7S4l?=
 =?us-ascii?Q?nmb0TbUrJRddO/WQMwoCYdn5Gst7Wox4F3kwqnpYX4fPZBILh0Wolpm7efu7?=
 =?us-ascii?Q?kJgCkA5yRzNNbyZepy+G+j2PoNnftGk4nzcD2lvVB2khGZ0D4Bq/Xbh6PeYn?=
 =?us-ascii?Q?aHFDu0jdQUp0WXlsedkvPofaECZxyJBxik4Ps9xBcr5VLEUGrJbEKdWzjDCl?=
 =?us-ascii?Q?Y5OQRfYliU4wIPjqO7RQlaC6rZNsFoGe4XKXzEbha4e+6G/GCGPbwXNbQhcq?=
 =?us-ascii?Q?wEXHVT/BmRWB98TC5d3RT4mwW5EdnLE89SiQj+ZIh2/+LlY/DLpx2u+jnifF?=
 =?us-ascii?Q?Cu7kz6T9gj6kY7GkqotqtwZPjcPstclR+s5JafrF8DtEQY4/NTIE5igrPKlV?=
 =?us-ascii?Q?dO9sBzjRQYlkKFcHU7qFVhWXZzyGKFACLAPgtNFovWbAEpjmL1Ia4+SZjaa3?=
 =?us-ascii?Q?s8aVPyLIqkkTtqS+M/p/C3AWbWio0bRnkXRXqnYC9NVKGPuhyC22XQIiry3W?=
 =?us-ascii?Q?utRWcK6NKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d784d8-3849-45ad-2fe8-08dee6f1ff62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:33:38.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S63yGzfV0v/MYMdqe/qpPXYKBhYI/0EobbJZuJ1D8aRvB4Hklb5JHb9AYr8S7Yg9xTtzxp6Q6MVw2YHvPnAYhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

Proxy execution retains mutex-blocked donors on the runqueue so their
scheduling context can execute a lock owner. sched_ext cannot safely
retain such donors unless the BPF scheduler explicitly participates in
their admission and ordering.

Make sched_ext reject retained donors by default. Force blocked EXT
tasks through the regular block path in schedule(), and fully deactivate
a retained donor before sched_setscheduler(), PI de-boosting, or global
activation moves it into the EXT class.

This is a preparatory change to support proxy execution with sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c     |  5 ++++-
 kernel/sched/ext/ext.c  | 44 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/ext.h  |  6 ++++++
 kernel/sched/syscalls.c |  3 +++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b1a320365bc16..e6ea4f88153d9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7168,7 +7168,8 @@ static void __sched notrace __schedule(int sched_mode)
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
-				  !task_is_blocked(prev));
+				  !task_is_blocked(prev) ||
+				  !scx_allow_proxy_exec(prev));
 		switch_count = &prev->nvcsw;
 	}
 
@@ -7721,6 +7722,8 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (prev_class != next_class)
 		queue_flag |= DEQUEUE_CLASS;
 
+	scx_prepare_setscheduler(p, next_class);
+
 	scoped_guard (sched_change, p, queue_flag) {
 		/*
 		 * Boosting condition are:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b730eac4b13fe..fd1f55c53662b 100644
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
@@ -7431,6 +7471,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
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

