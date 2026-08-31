Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB9523788
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183952; cv=fail; b=nVAR4+G0qdd9tPsqDd0R4r2iaVqCYYZJsEaq4DCVS5CUBOoCf/nYFTMIg1EOQ3ULQ2AZPT5H/7gVymTJEQa1GRMciY1EZu/Kw6jwWyxovoF2/ZaH8Nr8W2kVhp2vxHzYgsPSKF7ajN/Q66tPfssa61gNPMCsag49LykhfKbQxcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183952; c=relaxed/simple;
	bh=b5Iox2BiMHDQqxfdRfxU3k/fZELPMVJ3yK5auQt+kqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJXGWUreolF3nw06jtY0S1kXNpdfUdSvxP0+0pE2nMkxLcwUl5BhRAy3w4MUO91ID+bAoC3jfUQNJhAe1iNRjg5vkQx5rTv3oHr98pHwwtQZIULeaRGVEwG/BS+huf0lLGGdO1JX6LX60XIrpfFa9+GbiL+MpHBpaXj/lpbcV6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NmUrUpxQ; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NmUrUpxQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHExRYjDFd72ipoXp7yI2vMRFoYaCiJDcdsYArMbaK/6MClr+CG5I7smk1sKMAGMHPwnxW9gWcI1KOQ87Q7XqYwu+9pqkPyIwEH0qPv0doXMqtGq5eE38623u2vz/MM8k77pDMFcf1fDeAbeFmgBOgk8broUQQi+GYfDipxsRyYIXQSnHGVO/NLl+ikWQr6xvBLdVyo6tnCGZUtCa7smlF7kOEqJID/RaXBhwCnz/ZldJJFxQxrBnJd97y78dGzsvy/qm/duUkVZoRuNc020ajA1QRxXq3bPeui12hkcPvO4ggsFx+g1u47/AmnSmrhAIE3kvLMltRlKDPD5Fs0KjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37o+N3k4Lz/864y+WHocPGNUhRUqc/9/YGiXIgP8mu0=;
 b=UIUNYmhQRyL9bIPcj/KHaX1lRTzdbTIu2pYWf9dhA8KeYTxSJG1/bfbbyuoEbeKBUSm432/qHy9BRqGXpU0n0kA7ShzUEg43MMXxC6YQOWaF6SggCJG0cezHe/gaVkjHb+n9FlENrA3kexqChE/vty3UYd1IkgUO7n2Ts2JN8t9UsusDkRU9tiRn/kBEgpsb+xAiVif4Grgi1nlibpegsQyE/npYwcc2re2t4dtpz1tFQDbUTZKHWCuZqp9CvjhbalIcqGizkXxs1GjjIKivfQ3AXTMPpag8EZXhlOpo2/fra8wEJC6hUisclfNUsAL+9rd1xTZGtP9tMnQt2U5DvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37o+N3k4Lz/864y+WHocPGNUhRUqc/9/YGiXIgP8mu0=;
 b=NmUrUpxQv4pHmtU5KCbdOJnVXX7ktidTFW2T/0Wi2Iqz4oXKJNap7ziGUAxoDRTS5CkXAxyHYUhemLieErn7ihe+BDC2eZ6qiZHEFt7WLQ3PaypHGrPiTlefDiHTsqrK7KCnidHAeLy5UugLjNcc3F10TsFqP6Zl3Rnk5bGciRCcOX9dTl315MPoy4YbzpSBJzyHUysMTT8EBDwTOd52qRm7D4NMydnoRCm4+Nyjwtiju6bdNm+/eteMNZi39Af+Ot8wCfRA101VuCqXIc4mI/rudPjARqjM14T0qZy0h/12LFsmjDkfIk2M1+a4fYR9bJnjRVdn2VcJT2wmrtkA8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:45:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:45:40 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Mon, 31 Aug 2026 15:42:25 +0200
Message-ID: <20260831134338.1531664-16-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077BC.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::477) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e8e7d8-5414-45f6-e83b-08df07662555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vao30wZbO8ooEYE8bsJuZWxjF+7noszaezq2WXjF9NkmGBEqxk9+hLlMVP3NhiS9BAIPQSrvZ9GgPEPSqTfJcRkR4tp1PcE2lzlzLw5E3rzvNNjP9J/kjdntKpHHhPdtKyFRmWgp4yePSXwU6RQRDg4N83LxYUqAdFjNNtdAPPHbdUeUOvqU1/u0ET3WgE2gTa1D9eVL40bQPS+x8gS947VcmyYi5jOR+DS3ELCPU8J/IksVoEn30d2FYZbtUCy3ndWWtQtU0VhK3Fj4t2FKi+teOmRAiFSHxDjUzTIVcNr5H+XaVup4c20kZX1hG+GkuGbW0mKR9eCSq/m4vgPQx751OBJEPYA4JYxnkoYP5fqGYj8rJKFHIirXft1m+G7kZp2gnrZo3/GbV4ptScDmupsSmZUCJomYHRwkuuFRLlSomIYLXW0AzdPoB2z9D6GCiJrA5+3O8aER35nDRMtNL6XjdvmI+aHXpZxKGdb5DDoZ4OH9YKqweh8AlWKs9Oqa0FNT+wkmpGq+R/He/UMCu0/5LkkJmC74EloBN4s1di5PV4w1YrZ0zOL8ZqIeUR7NBMVOe5vpqMqJ5hqccrEfLUo2WN8QOdoyePAl9gM/ft+OzAmRu4WspjER7HV2KLj8433zq2cuTICYDh/8A061sO6yZIvDvuwASzHhnamf92g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yvti+aqCZ1QKjGMNcYvEPQpu7pdxOd0qx+2hBCnG6pu6zlxI32r6sxVFMfd2?=
 =?us-ascii?Q?uy3HkPG4GGwuB3ViLv9xXErRgTbqggOEzTX2tcHfAD7ARBESe0ceIy1CNJPk?=
 =?us-ascii?Q?xLF36lVQzeI4Wln8b3O6K9NKxYIwsSqcRaSIj3wTXpjVlyDiX6jo4gCO5DAV?=
 =?us-ascii?Q?RHuyptJfKf6x90+DTZYb0m9LrNZI55tFJU3UkzBmPtYt7JxutvFQSbOy7o1s?=
 =?us-ascii?Q?q8UtZBA3uzdRHHV/90oIwsK1WR1ehwOJy29DMJpXUJEMw4f5hcJoEYOLo2dF?=
 =?us-ascii?Q?/NieNvrninm240brsS+bgSow+d1ToieOazJirU3O0Fd4953jh4YI+D0xOOyh?=
 =?us-ascii?Q?8J37/xdjzKKPglVNh9gBPaO+GJsPIyNnygGnhaF7HnnjEqHfV/mufp2TljOl?=
 =?us-ascii?Q?QNSaHeMjTgIcH2yr/A81Z1jUgFIzYE7j2mh30iKmIvSVKQN8w4QUlBUWykNf?=
 =?us-ascii?Q?v9CJexC9a9OGkpa7/TvE7DFIx+R7fCVrRuOhRvIoJo5YI3YmfzkACGTBfelC?=
 =?us-ascii?Q?6ZHzyLYd8lACmQwLUNG2xwZS4kla6ZgLRFhuG8xBOFysWWFTBScugahadJgt?=
 =?us-ascii?Q?sJomxYeCJjC3U/6vmQSibs8Y4SfSHjbTnOp2psczF/bVk7fdvbq0bgEjn+NB?=
 =?us-ascii?Q?fpskDln2nsPLyB2ShVyur3BSVeh+RVk0bT2Un+kABhACnI6vwc4YnuFNk5iG?=
 =?us-ascii?Q?eXmcXzmHOYTlUwfYVJb+aFRG72BbCZrXOPMpVmFGqeEPOYbKqKeRY+yS38vq?=
 =?us-ascii?Q?p3KoWnIKvZKlkH4cOwelUh8aE/Uql/QOpOMEP2EHkzf9aFTGPpSKxSchmx77?=
 =?us-ascii?Q?K/pF5WW41rCzsygWNMOnFJIyt+yE2lb7ZNe9+TFxq4gV+nyDuvoOllAouU4P?=
 =?us-ascii?Q?NIwgcAWZ7OqNdHA3zi8F4gI3vmUeViC0YcrezqValkD9XuEjVu2dCzuS8jwm?=
 =?us-ascii?Q?22m8uudMNQsQBKJ+utcmb+X7qu1f7oBECRTWynxrWv90aESqlLnBT3ajW3lo?=
 =?us-ascii?Q?bszPmC7z+a310JG4YKuBBrQQEjIOmDgwhPF8QpnwoWKn8OJ3t/o2PT24SX9V?=
 =?us-ascii?Q?eO7MQOzdB7g4taknqNpPEcE7WKrgaMa0oatjvaT694IdyXgPAelLA9l2m+83?=
 =?us-ascii?Q?mzv5EENpTi93kWoz84mlRZ7wci3jTuRl1Q7zP9GN89WC+wlhJMYja8oddtUq?=
 =?us-ascii?Q?7nF05IeK9lgVIDA+woNuLtprekpJrZnjF1zR/8wNJ6NslcuZLodW2/s6q0Yi?=
 =?us-ascii?Q?RVzrpE9t6JhuJ961FDLZNgQboaWZgAhQNSUWgWLlaFhZcE/D1/DVswLKg8lV?=
 =?us-ascii?Q?PlHxM4eOuBAD/5RrTZd/DbZ5z0Fqb7LhnZ3ZzJ3Mua7VxFYqwRlfaYy0NNTM?=
 =?us-ascii?Q?nosfdEpzRUG9Umc9jUUmvUq0XVdqoCMgYV7CrBdLAGPnBHQ/5PCkjt7B2Z4L?=
 =?us-ascii?Q?o4fw6vHR4Ld0cCh2SOoLW5ENrP1+2Y24iBSxX2RkUKxlKWuAEB2PLyhTxUcG?=
 =?us-ascii?Q?E1GDRFDjFGe/FyOpwDIxWcw8cZsH7kx8h8mFRKMz7GoEa2B/RYm6m7R4Jfvw?=
 =?us-ascii?Q?osfejz+9q20MVl8E3KANuvyc4CsQaMmz5OyI3N98vIu6t6LL5L9raP5hZi/g?=
 =?us-ascii?Q?BwHry+fTUWeNg7FIBHXKL7tHJFPO+0sC8uPqoijtHT2jpFoIgvnSljBN7izs?=
 =?us-ascii?Q?K4srcPUMJstSxVfYrA/EDpWtUleh61y3kO90bix1q0Fhu6zFatvc+GP84NY5?=
 =?us-ascii?Q?W4uMr40ZVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e8e7d8-5414-45f6-e83b-08df07662555
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:45:40.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUdAJw61nIrBq0z+LO8yGRt54zfekSk7dM7Ug5cnOpX93J1PrEr96LX3zHj/ZpE9vRGbkRpqXnOzSwfoCM+jrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

Proxy execution keeps a mutex-blocked donor runnable so that its
scheduling context can execute the mutex owner.

Define SCX_OPS_ENQ_BLOCKED as the admission contract for retained
donors. Schedulers without the flag block EXT donors normally.
Schedulers with the flag continue to own blocked donors and receive them
through ops.enqueue() with SCX_ENQ_BLOCKED, allowing BPF to choose their
DSQ, CPU and ordering.

After BPF dispatches a donor, proxy execution may move its context to
the rq of the mutex owner. This move is distinct from BPF placement:
proxy_set_task_cpu() changes task_cpu() while preserving the donor's
pre-proxy CPU in wake_cpu as the starting point for normal wakeup
placement. A proxy-migrated donor returns through the full wakeup
activation path when the mutex is released.

Do not carry a retained proxy session across BPF scheduler ownership
changes. Before root activation, parent-to-child takeover, rehome or
punt, fully deactivate a retained donor unconditionally. The incoming
scheduler then starts with clean task state and applies its admission
policy the next time the task blocks.

A retained donor can wake through ttwu_runnable() while still on-rq,
without another enqueue_task_scx() call. On a WF_ON_RQ wake,
wakeup_preempt_scx() requests dispatch reconsideration after is_blocked
is cleared. A full wakeup activation has already enqueued the task and
does not need the additional reschedule.

Blocked-donor enqueueing takes precedence over the exiting and
migration-disabled local-DSQ fallbacks, so that an opted-in scheduler
sees every eligible donor request.

Co-developed-by: John Stultz <jstultz@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c                        | 121 +++++++++++++++---
 kernel/sched/ext/internal.h                   |  23 +++-
 kernel/sched/ext/sub.c                        |   9 +-
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 7 files changed, 139 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5f4956cf7e369..aa6ba9e8d7cb0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,7 +26,28 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	sch = scx_task_sched(p);
+	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
+}
+
+/*
+ * End retained proxy execution before changing @p's BPF scheduler ownership.
+ * Called with @p's pi and rq locks held immediately before
+ * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
+ * is updated only once.
+ */
+void scx_prepare_task_sched_change(struct task_struct *p)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	update_rq_clock(task_rq(p));
+	sched_proxy_block_task(task_rq(p), p);
 }
 
 /*
@@ -2055,19 +2076,28 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
-	/* see %SCX_OPS_ENQ_EXITING */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
-	    unlikely(p->flags & PF_EXITING)) {
-		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
-		enq_flags |= SCX_ENQ_RESCUE;	/* avoid looping on cap rejection */
-		goto local;
-	}
+	/*
+	 * A full wakeup enqueue happens before is_blocked is cleared. Don't
+	 * report it as another blocked-donor admission.
+	 */
+	if ((sch->ops.flags & SCX_OPS_ENQ_BLOCKED) && p->is_blocked &&
+	    !(enq_flags & SCX_ENQ_WAKEUP)) {
+		enq_flags |= SCX_ENQ_BLOCKED;
+	} else {
+		/* see %SCX_OPS_ENQ_EXITING */
+		if (unlikely(p->flags & PF_EXITING) &&
+		    !(sch->ops.flags & SCX_OPS_ENQ_EXITING)) {
+			__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
+			enq_flags |= SCX_ENQ_RESCUE;	/* avoid looping on cap rejection */
+			goto local;
+		}
 
-	/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
-	    is_migration_disabled(p)) {
-		__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
-		goto local;
+		/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
+		if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
+		    is_migration_disabled(p)) {
+			__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
+			goto local;
+		}
 	}
 
 	if (unlikely(!SCX_HAS_OP(sch, enqueue)))
@@ -2390,10 +2420,23 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
 	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
-	 */
-	if (p->sched_class == &ext_sched_class)
+	 *
+	 * A retained proxy donor can wake through ttwu_runnable() without another
+	 * ops.enqueue(). WF_ON_RQ identifies this path. Request rescheduling so
+	 * that ops.dispatch() can reconsider the task after ttwu_runnable() clears
+	 * is_blocked. A full wakeup activation has already enqueued the task and
+	 * doesn't need the additional reschedule.
+	 */
+	if (p->sched_class == &ext_sched_class) {
+		if (sched_proxy_exec() && (wake_flags & WF_ON_RQ) &&
+		    p->is_blocked) {
+			struct scx_sched *sch = scx_task_sched(p);
+
+			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+				resched_curr(rq);
+		}
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2508,6 +2551,21 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/*
+	 * proxy_set_task_cpu() preserves wake_cpu when moving a donor's scheduling
+	 * context to its lock owner's rq. For example, if BPF places donor D on
+	 * CPU0 while its lock owner runs on CPU1, proxy execution moves D to CPU1
+	 * but leaves D->wake_cpu pointing to CPU0. If D is later put on a shared
+	 * DSQ, CPU0 could otherwise consume it and move it back, only for proxy
+	 * execution to return it to CPU1 again.
+	 *
+	 * When task_cpu() == wake_cpu, the donor has not been proxy-migrated and
+	 * BPF may still choose its placement. An actively donating task is
+	 * rejected separately by task_proxy_running_or_donating().
+	 */
+	if (sched_proxy_exec() && p->is_blocked && task_cpu(p) != p->wake_cpu)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -3309,6 +3367,24 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/* Delegate retained donor admission to its owning BPF scheduler. */
+		if (p->is_blocked) {
+			/*
+			 * If the donor is the same and only the mutex owner
+			 * changes, avoid triggering another ops.enqueue(): the
+			 * BPF scheduler has already admitted the donor, so it
+			 * can continue running.
+			 */
+			if (next == p)
+				goto switch_class;
+
+			if (WARN_ON_ONCE(!sch))
+				goto switch_class;
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
@@ -7640,6 +7716,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	if ((ops->flags & SCX_OPS_ENQ_BLOCKED) && !ops->enqueue) {
+		scx_error(sch, "SCX_OPS_ENQ_BLOCKED requires ops.enqueue() to be implemented");
+		return -EINVAL;
+	}
+
 	/*
 	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
 	 * may set it to declare a dependency; reject if the root hasn't
@@ -8027,6 +8108,14 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
+		if (old_class == new_class && new_class == &ext_sched_class) {
+			/*
+			 * This is an EXT-to-EXT scheduler ownership change, so
+			 * sched_change_begin() won't end retained proxy execution.
+			 */
+			scx_prepare_task_sched_change(p);
+			queue_flags |= DEQUEUE_NOCLOCK;
+		}
 
 		scoped_guard (sched_change, p, new_class, queue_flags) {
 			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5a1f6875e3d7d..f830e76aa645a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -215,6 +215,19 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, mutex-blocked tasks remain runnable as proxy donors and are
+	 * passed to ops.enqueue() with %SCX_ENQ_BLOCKED. The BPF scheduler controls
+	 * when donors are dispatched and whether they should preempt other work.
+	 *
+	 * If clear, mutex-blocked tasks are removed from the runqueue normally
+	 * and cannot donate their scheduling context through proxy execution.
+	 *
+	 * For blocked donors, this flag takes precedence over
+	 * %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED.
+	 */
+	SCX_OPS_ENQ_BLOCKED		= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -223,7 +236,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1735,6 +1749,12 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
+	/*
+	 * The task is blocked on a mutex and is being kept runnable as a proxy
+	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 */
+	SCX_ENQ_BLOCKED		= 1LLU << 42,
+
 	/* high 8 bits are internal */
 	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
 
@@ -2044,6 +2064,7 @@ struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
 bool scx_set_task_slice(struct task_struct *p, u64 slice);
 void scx_task_slice_ended(struct rq *rq, struct task_struct *p);
 void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq);
+void scx_prepare_task_sched_change(struct task_struct *p);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 8c5b64b57b24a..f890ef2ee94d7 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1211,8 +1211,9 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
+	scx_prepare_task_sched_change(p);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -1242,8 +1243,9 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
+	scx_prepare_task_sched_change(p);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -1897,8 +1899,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
+		scx_prepare_task_sched_change(p);
 		scoped_guard (sched_change, p, p->sched_class,
-			      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index d2e4384df5af7..8313a2f6d03ce 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -117,6 +117,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index b1351f346e1d9..d3e1185f00ac1 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -85,6 +85,7 @@
 #define HAVE_SCX_ENQ_RESCUE
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
+#define HAVE_SCX_ENQ_BLOCKED
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 7268131010de3..c45ce9f1c39ff 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -133,6 +133,9 @@ const volatile u64 __SCX_ENQ_REENQ __weak;
 const volatile u64 __SCX_ENQ_LAST __weak;
 #define SCX_ENQ_LAST __SCX_ENQ_LAST
 
+const volatile u64 __SCX_ENQ_BLOCKED __weak;
+#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
+
 const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 #define SCX_ENQ_CLEAR_OPSS __SCX_ENQ_CLEAR_OPSS
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index e616326545172..52d64a67401ea 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -48,6 +48,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_RESCUE); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
 	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
-- 
2.55.0

