Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFF335BDB
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253551; cv=fail; b=omsFG+It9FXFvIwmH5Tk5urhCrPNXk4gohFcAGOWitkgeIPq+lTsgXmK/H05+3gmylG9lVmOmXcAZxY+679UKjshPxFHITEzspI73SR+hnSaFYNnW5iVfty2aGFYtZ1lNUSjKVkcFZSACAJ+BkOqush4jSMc9EPArSkjdHNQY3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253551; c=relaxed/simple;
	bh=CpFKOC5cnQygKtz7QRHcDpKgvDYMZlw1LEUuMXrxCcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WCvI74AsBms2GZddlTCMh/X9vDrF5WT3adpnxuI2GH83rWGWN/ZRnk+uk3cC4lAyxZujNtVWYOCwJhimLoCAohUYg98xWTZuA8XLQ7oDfxz+Rqs7bt7x1tOZfh3PT0QvwpMJHHq7xx3mEgQ5UvdLXLsNYOituTOURRpLk+BVkTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ANS58S0a; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ANS58S0a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0tmEi+NXqmhdAhHvNRKKYZYcPvzcssxecQP7pYo3wWRZaYzzFWlpEvvaRDkp2CVgyt1O2P1etPjmNfFDGzCXPPlzsD6WZmzTrNt/qfpznCK5roX4D9B6go01xCTU1MLS29baBNkWiqymLrUlp4wipep2DzrNZE6hQ5HoPVnX1lXdaSotf0p6RZIzgWH8sLoVb4jznbXISiyF09GyaKnZpbWSskVfPAEaEY7sXfuhcPNMu8IvQVOjoGCedQ98xzFsWgwY2c2/qHbP6PwzGGUsqRK4nCXvji1SH2uM34dQMeIXDb40Kd3TqpNCMYtEyoJB476vdyg0y7u6rBpEl300g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDniAHKatrVE2DaLYtI3VL7YVxIZcxQ/Pk9SNNMA2zM=;
 b=ZKjoNTSDocv3trTwdAKgy5p2g9ZCd+N1vO5w+8r2k0O8l5XkBmJjC+tk6Q1hOh9IsS0bIG27Af7KbYsYpaczpTtbyLh6Im9D8Z9inI9xVAEEGlHRngWZcqmGPYqKPNzIVoV81Iasy1qC8NfS6navQlPKN1htKGdA6xM+pzGPmcNlZrotQOKLMFaF7szHmO5Nz/xQHM4AVzMUBU2kKXl4ckdw1PrQa9G2YWPvxRXIqLQ2M0VNbgQ5ju0YzIL+5NSDT8PXfQxNaXaglAURFOZc98emqy33hS10GN5ewr8EpCnCm1Pn8p94+7uD0hvWVwzhiXkbkAImwndd5LqqtXA5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDniAHKatrVE2DaLYtI3VL7YVxIZcxQ/Pk9SNNMA2zM=;
 b=ANS58S0aswBzdADKono8xSCoyqeYuXepo+Q4b5Vs8QEmjHkBoiQgIPHmIsCmP9Q6mxuBFihW0dqKp2V8U7yUbN/gXT/Xt7dfS5+FhTPlbZOEOIxTyjaP3LSHLHT8vLqNwZ9/mBtP9sxNTx2kAhs/9uIu7nqGjp+T4jVDOuC7G1F5zeQEYlsMrucN8YIChdKCi/fnKfNNqjJpTDD8Am0Oc7ZxezZKtrPWW+uRklCLtGCv8UYRa6C39sbMW2GR48Oa2wNxOGRaIjlYZUzGPVW+z5htj1ir1lUwZNMK8YXGO5DKI6u5a1oYrQEfnd6AYASG4WezXiXXlnuI7q80BCPgRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:45:41 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:45:41 +0000
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
Subject: [PATCH 12/15] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Tue, 28 Jul 2026 17:43:30 +0200
Message-ID: <20260728154425.1549660-13-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 646c12ce-94d2-46aa-6194-08deecbf4763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|5023799004|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9nXBej8dVeiSos3KYae/vr6tz4AtoHiqWTOD6sDOhbJGilwdoRnRkCChsOPMYvfis7d+ureXTGwK9RzcRbwpzRLkDEsqSWVD8nwfEFKP/b8YvK7oBdqsefVqUNRrmdB4DFc1ayV5+LAdlOd9RG7xBVPWx9Y4wVmJOsdgtJOpLS+ZYBZX+noyA1ESHObjdqXm4I0jjoW/gopJ7TM0UvO/8Gb90rrMFM98ZyPQZi91TpVRGGU+QSnHFKci0wF3A5QRwJW8enl3SF6knkn7bawQLs26kA0pqxYC+d164GB6eAwy4NCX9Q+TUUQQG7Lh2xvnFz5ARBwYvEofJfS2Cswv40DbAi7d0PdLwRahlp2uu1SIWg4U2zN9qDZihkprtUW+tKBRpcn44uauhxHh9Oef1hUjwvLkwkxQNRjx7lUIfohqb/C6cAcqv0kFRxqD2AJmrO/BfMCE3IN2gSecPD3V31p6w8MXkykvvViFu9iwEoioqN7aV3VfJhhKnx/jnqBxHRDsq2IwCIHo12tq22ZHR1+wJME5fPccHzk6K8neQC9+jl7LlNG70pYKEQ0X239M6XRywVmQMflzWCN4lezlX4a/TGs6pX3N1c757kUOZWkYb7SbcA518hoNhgBtbulOo+HUaPv9dVsiQfkYWMw3+Z/m+B8PjYBkxoDEmilsCts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(5023799004)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQ0vQP3SpC0qX+eX9IARPyNXFFVY09Gn6qUXS/Z6T58tUNesa4CzpgEATdvC?=
 =?us-ascii?Q?dfLoTRLTMYTNFx8MqdutPMNyUF4JJ58FX42M4W5Lg307058mL+ljPPySYA2B?=
 =?us-ascii?Q?hOZ+RpmEiRqB8hDAXTa0hsRHUB9xCbILaalTyaH0gmp6E1nluNYGeWIpQvSz?=
 =?us-ascii?Q?H4yVCkdbJvSh/SXGZjc5A4/UXhfimWfbXqoLz2YvLkho0ySj3U+jkjBZe+DQ?=
 =?us-ascii?Q?CxqhaJasgfOjIa25sD/cINn4uJPrUtwf3BwTZwE/DmBH+LlyRchIa1p4eckA?=
 =?us-ascii?Q?21pgjKeEb43pcK7nSABP5Dzu9yey7DHYIkzcpxEV259kkoBt1QCAkRNPzT4J?=
 =?us-ascii?Q?PIxIImip56xNWC4ougCufYuBmoubiYicggkTF0zaX5j0bsD/GqwKy8RXqJPH?=
 =?us-ascii?Q?j8pGg/m+PaZEB1iirMiG8qrJMbxDW7xfocIa2i/0YGfZOp77XZwtlt9bXvX0?=
 =?us-ascii?Q?n24329CiVuEY7Ed2Gze2W6v0famqAYgD11yHT9PXPAFlocIPG4zTvSu1l/T9?=
 =?us-ascii?Q?ODLJT8crNE/mHW7iI9tVIaLJ8ODstXX48XZYd5m7vSfJDlGwma3BBhf27gKB?=
 =?us-ascii?Q?pqdKNsAqCq/5NWmuJVwV0KjpMVYsZeQvISTC9qi+REg1KPMACUaJIfqHwyxi?=
 =?us-ascii?Q?usyydgmlAJ0Nbudr1Jm2raGD/M0+g0+aWpEHJUVv0OYaizhlFgeEaXg9QriO?=
 =?us-ascii?Q?11PujasSfScY7rJPraqWycxTswS+Nv0uthLloSS2MRFaIgFiXp86YQOa9X+D?=
 =?us-ascii?Q?YsDUAcHKMLGjR5coEMRUCYyaXwaSyc9YpHxnpWgE+YT/wzctmFAZi6F671rg?=
 =?us-ascii?Q?NpDwJ9FVhXOZ1M7h+qYE8EhvBkKna6vLp/1A+3ImuLpca7NUF8WmP9l7EGpc?=
 =?us-ascii?Q?a5vRWLt9SC8cOjHGVlAgc4YIdpeHpE08AgJJXBPNFHAGSOMLZDDYOx4T4KK/?=
 =?us-ascii?Q?g43PkfF+/81Xc6JBm1cjkCnf7tV5XjWbuzWzxKm7K6SHw6wPOea4ImXYFKI/?=
 =?us-ascii?Q?yVFOYOgV8d2YvJqaN9hNNMrSvmHlj9VKeX63Ly0JZ+vMxA0H4Ps4ee+ZR2dQ?=
 =?us-ascii?Q?0gWOEGVLYy9u5MdN707ohT5DHKa7grdQX9xUSjuaUQMWbmkwoY77lZQFNgvp?=
 =?us-ascii?Q?DBtWJbtHxZ1Jj4u4ynVIWSiRfzUimiYY/xHZDJ2Jxoz7luS60jeVZ+E8WVwE?=
 =?us-ascii?Q?25HgjEt9I94hVbxXrr50VNx6GLgEv9kw9HH+dpaV/KhjZoBcIy02JrZxv7Qy?=
 =?us-ascii?Q?j7TaM2E4LHs5dY3cEccAbUEjLrTnUls9t3uoEEPU52pZ2GKgM7eBNEWy/92V?=
 =?us-ascii?Q?NBnLDP/tSM52XpiDxmaYyBaVAhZw1iqLxg6m90txSTxYaLTeUO7NYPKItUsI?=
 =?us-ascii?Q?H1zHw+q8V9tkKQTTpvZQjoUw5w4LoOjWf5ocbdMteI8OWU4E0uVGUGZjefZB?=
 =?us-ascii?Q?VsAjSHK1mUMtjM2JzsoD4oiHQxrVSuPKDuTZZXItw8aspQCgdCx1sdzNXOie?=
 =?us-ascii?Q?2xBn/2fGIPMG0asU/zIO2qOFNmo0WCh0DaX2MAoclHIFQVn+JUk1KJSlncJ8?=
 =?us-ascii?Q?wLNKAgsnyTMaUcsVbk32ouigYIpbeJjnDycQQ5B7+5V/alqaxTIo/biLxFC2?=
 =?us-ascii?Q?8bocja4hRNcA+NAtCbZYk2m7dxqwHQh33DvbzuhzFgGLaIZHZ3+qrj3nYdhc?=
 =?us-ascii?Q?c2GMwrfJySNziCFVVckyT59tsJn40CrIrlaDXkD8PvFHTQH94grPx3oPpOMQ?=
 =?us-ascii?Q?dakaqwNVtQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646c12ce-94d2-46aa-6194-08deecbf4763
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:45:41.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJ0neHFYHYWkLSL12A1AIJiBj6BBMOKe5AFePSalX6LouuzM3agHnXdHFr6O1Arga30b2u8FMKO57m2Fm7rXYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

Proxy execution keeps a mutex-blocked donor runnable so that its
scheduling context can execute the mutex owner.

Define SCX_OPS_ENQ_BLOCKED as both an admission contract and an
ownership rule for retained donors. Schedulers without the flag block
EXT donors normally. Schedulers with the flag continue to own blocked
donors and receive them through ops.enqueue() with SCX_ENQ_BLOCKED,
allowing BPF to choose their DSQ, CPU and ordering.

Once BPF dispatches a donor, proxy execution may move its scheduling
context to the mutex owner's rq. This move is distinct from BPF
placement: wake_cpu continues to identify the donor's callback CPU,
while task_cpu() identifies the proxy CPU. When the donor wakes, the
normal wakeup path uses wake_cpu as prev_cpu when returning the task to
the BPF scheduler, which can then choose its next placement normally.

Apply the same admission contract across scheduler ownership changes: a
retained donor moving into a scheduler without SCX_OPS_ENQ_BLOCKED is
fully deactivated and remains on the mutex wait path; a donor moving
into an opted-in scheduler remains queued and is handed to that
scheduler. Tasks without an assigned scheduler retain the generic
proxy-execution fallback during the transition.

Blocked-donor enqueueing takes precedence over the exiting and
migration-disabled local-DSQ fallbacks, so that an opted-in scheduler
sees every eligible donor request.

Putting these rules together, the donor admission flow is the following:

    D ------ blocked on -----> M ------ owned by -----> O
 [donor]                    [mutex]                [owner]
    |
    v
 +--------------------------+
 | SCX_OPS_ENQ_BLOCKED set? |
 +------------+-------------+
          no  |  yes
       +------+-------+
       |              |
       v              v
 block normally   D runnable
                      |
                      v
          ops.enqueue(D, SCX_ENQ_BLOCKED)
                      |
                      v
             BPF admission policy
                      |
                  D selected
                      |
                      v
             proxy-exec resolves
                 D -> M -> O
                      |
                      v
               rq->donor = D
               rq->curr  = O
                      |
                O releases M
                      |
                      v
               D returns through
                the wakeup path
                      |
                      v
              BPF handles D as
              an unblocked task

Co-developed-by: John Stultz <jstultz@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext/ext.c                        | 155 ++++++++++++++++--
 kernel/sched/ext/internal.h                   |  23 ++-
 kernel/sched/ext/sub.c                        |   6 +-
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 8 files changed, 171 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 53da9eea0c925..8944e96fd4673 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -103,6 +103,7 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
+	SCX_TASK_ENQ_WAKEUP	= 1 << 7, /* wakeup enqueue awaiting wakeup_preempt() */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5dbf89debc6c7..e7ef114f5f074 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,15 +26,51 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	/*
+	 * scx_enabled() may change while __schedule() holds only @p's rq lock.
+	 * Once @p is associated with a scheduler, use that scheduler's policy
+	 * even while the global enable state is transitioning.
+	 */
+	sch = scx_task_sched(p);
+	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
 }
 
 static void prepare_switch_scx(struct rq *rq, struct task_struct *p)
 {
+	struct scx_sched *sch;
+
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(rq);
 
-	sched_proxy_block_task(rq, p);
+	sch = scx_task_sched(p);
+	if (WARN_ON_ONCE(!sch))
+		return;
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(rq, p);
+}
+
+/*
+ * Called with @p's pi and rq locks held immediately before
+ * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
+ * is updated only once.
+ */
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	update_rq_clock(task_rq(p));
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(task_rq(p), p);
 }
 
 /*
@@ -1925,6 +1961,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1975,18 +2012,24 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
-	/* see %SCX_OPS_ENQ_EXITING */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
-	    unlikely(p->flags & PF_EXITING)) {
-		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
-		goto local;
-	}
+	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
+		      p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP);
+	if (enq_blocked) {
+		enq_flags |= SCX_ENQ_BLOCKED;
+	} else {
+		/* see %SCX_OPS_ENQ_EXITING */
+		if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
+		    unlikely(p->flags & PF_EXITING)) {
+			__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
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
@@ -2093,8 +2136,17 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
-	if (enq_flags & ENQUEUE_WAKEUP)
+	/*
+	 * p->is_blocked is cleared after wakeup_preempt(), so remember whether
+	 * this is a full wakeup activation. If wakeup_preempt_scx() isn't called,
+	 * set_next_task_scx() or a subsequent non-wakeup enqueue clears the flag.
+	 */
+	if (enq_flags & ENQUEUE_WAKEUP) {
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
+		p->scx.flags |= SCX_TASK_ENQ_WAKEUP;
+	} else {
+		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+	}
 
 	/*
 	 * Restoring the current scheduling context will be immediately followed
@@ -2299,11 +2351,24 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 {
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
-	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
+	 * task's slice to 0 and triggering reschedule on the target CPU. A
+	 * mutex-blocked task is kept queued for proxy execution, so its wakeup
+	 * doesn't go through enqueue_task_scx(). If the BPF scheduler manages
+	 * blocked donors, reschedule explicitly so that it can reconsider a
+	 * donor it declined to dispatch while blocked.
 	 */
-	if (p->sched_class == &ext_sched_class)
+	if (p->sched_class == &ext_sched_class) {
+		bool enq_wakeup = p->scx.flags & SCX_TASK_ENQ_WAKEUP;
+
+		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+		if (!enq_wakeup && p->is_blocked) {
+			struct scx_sched *sch = scx_task_sched(p);
+
+			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+				resched_curr(rq);
+		}
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2418,6 +2483,20 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/*
+	 * A blocked donor may be moved normally to select a new callback rq.
+	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
+	 * callback home.
+	 *
+	 * proxy_set_task_cpu() instead preserves wake_cpu when moving a donor to
+	 * its lock owner's CPU. Keep such a donor on the proxy rq until it wakes;
+	 * otherwise normal BPF placement may repeatedly pull it back to its
+	 * callback rq only for proxy execution to move it to the owner again.
+	 */
+	if (sched_proxy_exec() && p->is_blocked &&
+	    task_cpu(p) != p->wake_cpu)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -3047,6 +3126,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	bool can_stop_tick;
 
+	p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3198,6 +3279,37 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/*
+		 * The rq lock has remained held since scx_allow_proxy_exec(), so
+		 * @p's scheduler association cannot have changed. An associated
+		 * donor stays queued only when its BPF scheduler enables
+		 * %SCX_OPS_ENQ_BLOCKED; delegate its admission to that scheduler.
+		 *
+		 * If @sch is NULL, @p is transitioning into the root scheduler. The
+		 * root is published before tasks enter EXT and cannot be cleared while
+		 * this rq is locked. Preserve generic proxy execution by placing the
+		 * donor directly on the local DSQ.
+		 */
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
+			if (sch) {
+				WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+				scx_do_enqueue_task(rq, p, 0, -1);
+			} else {
+				scx_dispatch_enqueue(scx_root, rq, &rq->scx.local_dsq,
+						     p, 0);
+			}
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
@@ -7372,6 +7484,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
@@ -7758,6 +7875,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
+		if (old_class == new_class && new_class == &ext_sched_class) {
+			scx_prepare_task_sched_change(p, sch);
+			queue_flags |= DEQUEUE_NOCLOCK;
+		}
 
 		scoped_guard (sched_change, p, new_class, queue_flags) {
 			set_task_slice(p, READ_ONCE(sch->slice_dfl));
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index c3b1f9a5cf3a9..40bc2ec217a79 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -214,6 +214,19 @@ enum scx_ops_flags {
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
@@ -222,7 +235,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1678,6 +1692,12 @@ enum scx_enq_flags {
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
 
@@ -1974,6 +1994,7 @@ void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
 void scx_task_iter_unlock(struct scx_task_iter *iter);
 void scx_task_iter_stop(struct scx_task_iter *iter);
 struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 640e4a4f3c07f..0fc08781e0347 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -751,8 +751,9 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
+	scx_prepare_task_sched_change(p, to);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -782,8 +783,9 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
+	scx_prepare_task_sched_change(p, to);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 7757252d52e21..0e83ebfbee2b5 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -117,6 +117,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 0379eff117c9e..d0b7516a05d96 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -73,6 +73,7 @@
 #define HAVE_SCX_ENQ_IMMED
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
+#define HAVE_SCX_ENQ_BLOCKED
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index dafccbb6b69d2..7efe7b9346b49 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -130,6 +130,9 @@ const volatile u64 __SCX_ENQ_REENQ __weak;
 const volatile u64 __SCX_ENQ_LAST __weak;
 #define SCX_ENQ_LAST __SCX_ENQ_LAST
 
+const volatile u64 __SCX_ENQ_BLOCKED __weak;
+#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
+
 const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 #define SCX_ENQ_CLEAR_OPSS __SCX_ENQ_CLEAR_OPSS
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index bbd4901f4fce3..f8fbeb7fbf95b 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -47,6 +47,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
 	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
-- 
2.55.0

