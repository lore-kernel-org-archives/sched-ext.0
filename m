Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1732B107
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995555; cv=fail; b=I8Bv9rw0OVJMe1Cd1t16xE8wE2sPEf0FR47saLjRIj0ZDPftNw8FtWX630g2IdHc86o49i7izKew3diryQOduuKFBaABXRPygxJRIcCH/9MQeecxBUdr24gIyItGpZ5zvnQWlQFNZ0sb2qtCFMr8dARYYFPjEAsgxGZOCbmV5SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995555; c=relaxed/simple;
	bh=2UF27KDx/+JaGh5d7XeWe0agC7B3wMkl2us129C14/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FPq7/AIEp+XaW5ykJ3MxxqnyuoS5eGv/qpkJaj8U0UDXooDGi9KLQ34Welwmzs/5XkUGnY79lUDbLJl5ITFMJ9BJgnhDsTBxROnoObloyKYbTcZbraECWDqHWQkXIeQTN5mhQBfVJOOmcSimvwgIWI9OY7lBXuI6b8UL9t4xxpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dMl1FxFC; arc=fail smtp.client-ip=40.93.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMl1FxFC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpPrapQjDU1QDFGsxX1eS1kXN0aLc4lF7i29wYX9Zk6lzuBRKUsrmH4fod8kxSOuAi0FU9NmByquWtjZNludkG7NEjYI8icm6qkXShXHNdRZWN7NmOGAHypBFpekr2bZe6e+FXsHlF7jgRiDlm2MMkT/4VBcRAjbCyH5yvo/V9eaD/p1Iosg8g3JjmBEJM+pDoOUkUUsZgkOE3muKDlPDpTH08QVEAPovIOeGADfoih0BG6hNxomep9TCf2PWFUN6o/pQvukvHmdwYDbpzVqc+2UGM/E5nZP7EZdEXy9XU0NyQ7WTYmIxT53RMjBK+vV/fVUonpKrtuCdsuKM8lHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiytngDYRvxhjNrbSlA/LNZO3B0KUZ0Ljt3CN123278=;
 b=R5B5JeSinq5C7E+NJaG0Jn+T23h6ycWruMfy2xpGIMWXT4fIH2mJKYX0zHf7jfQH5XhK/1uIFeRUSOvnYRZUaubzcZ2dpfA15nSPJ09z8+jTNqbg+jCZ7ZcaFKiE5H7oiAk6KouaBwm3pQC8apSrsdhfGiX7Xz0zJ7RFO0bN+/bTetWtp1NVmijAzKabpEyBxx0Kh6ZLDbETHpVL0VJQNQ1ZJN5XQK3k0alC00k4vyLYbYd/9rUvr6nmNJVyMH9brg2zZ6HcUAgBPni3Xa2yMyzsLpqTaWhbH6IYTKx6QNn0kBO0xwwYodHf06yjCXGyuAPnBQEeogKUTgcbeNsywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiytngDYRvxhjNrbSlA/LNZO3B0KUZ0Ljt3CN123278=;
 b=dMl1FxFCtrHwUAVi9mufGiGnAve4t8onM+mle4aXlklHxnjHZ6KdbIffI1URiaITLW98Xdfu5//kNZfwYJs1AHJpqt21BXVq1xi11khaZOmD+eSycL3TYDn8JDqygECuY5Yu0TsAQzfkKcysWi+F8cDuRrbFwECdEmEsbgw72KwUHpc82vlb/kOD8kP/WxOq20VR+p6NkBslOVba/ToNrki0fIX1nIJQTnUykVD+eDy5g7gzoNO+1ojAQNA4KAM2zWZpY+GxZNXmnwFeIVvPw0cUbIGbERlgzAC79nBeqRfjkXI0atyJk0w8ZK6X563MjNMRW1kwgD8VPh43pj/Ilw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:05:49 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:05:49 +0000
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
Subject: [PATCH 03/14] sched: Add helper to block retained proxy donors
Date: Sat, 25 Jul 2026 18:04:09 +0200
Message-ID: <20260725160513.57477-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e154e8c-ac39-44e6-eeab-08deea669817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KSmZ88JfqNEckMXEQtVCSxNboTH4BuApbZdCZ5waTppelxNIYs/vQuw16DQX37bsHw515uuH7cNICPu5QgN3lf5y3k3ETV1zVwVeKScKwlmp81WZ7JqOjn9ehvwi8YEtaOx5U+4EMNNpE9gmoib3S5/62weOVBGD4a1eucul1McI6tVJW8rHec5ikVZ7lmuRd+53M+tz3ZNvEgeQOTSwB+rvEaEIf0oWgGN3EaICLOuHLkeZKITaMFO6SLFLxxZNEU4M4wzlRE15AHyIiI3yO/glqfKpfu7jzneOZIIWThHq5ePdTWVABylLEh6DBWNbIu+kis4Hyo9h4pYLjEmb9JRNmfadzLZDyAM7l94P0BEP7i4VZCDvsO7enQdM1tWOCMAdV1E0l1gyoRETbyMusdTpi2j24iaSHPO/UOb5Ud+4877HxwH92k+Jt1/vex1SI56OkiXIuRx5E/sfQuulNpc8XT9iC8CumLifA69A/4uZr9axtyesyT2xJC0oaW7jqiJN4mbBg9l0rffw5fNsXL3R5e+m1ZdHkKKsXIh2XQh2l40Ozfl8x9OIIOyPFVpwNcCQ8Hb+/Cwim52DJbAOACReeK/IWNgw0JAYhOeVWqsT0tBA6sVseUx1YZQFNRnDCWQZ70ThFEgIeEzLY8KoXk4BzqTiTFSNroVcQJhSK1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6oRnnrKwKBXTfkxdIU5vdrgVMVCUCY3m7l3s/ujE7bD7Oxd1y3BU0/cQe+L?=
 =?us-ascii?Q?Eps1daq3bibmLYHF0MWhP8fan4BfWblN8JSbAX1HRnC/NH6LENknowPht0et?=
 =?us-ascii?Q?Ozzw8L2/QrLcRGgabwSSRRPVGL9MP1Ij+epenx6kelnR8KhHJYojgfQems0/?=
 =?us-ascii?Q?ZOLVJAlb+heLlscU1yvvbOog17VCfC+4TVz2SsMxy6tlrapQzaNnCahpmfg9?=
 =?us-ascii?Q?eR3V6ZMVJxTnMPyFczb/9uFM9zLxEUG40BoKaRV5hs/9PL1R9ikysf0nvZou?=
 =?us-ascii?Q?cqTmv+KakYwB2JaxuYSiS5L5ZFxCHjDBnHPWsWFnIeCiig5bGH9TwNyXx/I5?=
 =?us-ascii?Q?jJKrcJ3doMiw4qLsG+0Y19/XghPHr5/7gmg0JzeqJ4/O2uIohR1HHOulnbvr?=
 =?us-ascii?Q?NIYnZFAWCxK6gWvDbpRlQuE3OBwB6l+o102mLHXLp8l15fF2rdJQTxT7a4ID?=
 =?us-ascii?Q?YJWwkXwKEggE5hUDHY7W3U1gmtEMc+ajcjsb4qZeWmuWKOaPmON9QSeyYjJ/?=
 =?us-ascii?Q?efHaqBeSg/ouqDFHm7HZiJt0v/Nm/8xrBiz+d0FZqu/qvvhcSRGjyLnD+fMn?=
 =?us-ascii?Q?mjTK2oBEKQu9Rqo23/IKGR2mZqBqImW6+m02KzRwEQbyK49s4YPL1J6QE9Je?=
 =?us-ascii?Q?62CvJqjLOVuSZ6tDlEWOikjwqGiQj1XpMzXBVYGtSrVxVLTLsfqc1hChtjfy?=
 =?us-ascii?Q?i+Q7NR3+VrwIrTMgmS3ySROq6u3lSXVpM7TYd2by+EoeWQZxDjHqnTJnPj+x?=
 =?us-ascii?Q?aA/lB5BqrcN6DDtE4HTZtXbUxYMHzMgYR8bj6PUOqVzJF1rz4nqRfPziMyMl?=
 =?us-ascii?Q?Z5cmAIzinsLCob2lXDGF+8y+EcU+K+lHpZytu8tAge8WtVyYO2ZTQmvyJu3n?=
 =?us-ascii?Q?fODIhX521HRsBeKdQVJKXJxPvri/NdWh5cEDbrwQu3BhYBwU//DXbT/lFBJa?=
 =?us-ascii?Q?nUYKPgvf5WWkWKzoh3+f8SOKnTmXnqx1GJ3Z977aiUkVl8UhD1Nn5gtJt+If?=
 =?us-ascii?Q?HcCDZlNEZuhcOHIbAfe4HSjM54Wye4dSUTkWlUqdrAEz5Wu4XqdaaXnMjwjw?=
 =?us-ascii?Q?A/2TttdjQ1Pii6wH1sZvUxS7KMgEOO1GZCOb0vtIXEpVJRIV+AspIcMIh1BK?=
 =?us-ascii?Q?nUbn0i6miYnWWGlMCqovdSPTRhJlyTNHfk6nv/aff2mJHK6R38KS8McV8TZq?=
 =?us-ascii?Q?P0u1yrVhhnlUahw6fi8yff4RAQXb/9ADFz7BSqY/1TVDs7GuyfLYfPQaKc2O?=
 =?us-ascii?Q?7OUa7xWc3g1f1V24lfC1L8B6txM6nyuE/p3ZK6xdDz7IioP9MQ0TKWQGhGNl?=
 =?us-ascii?Q?YkWalb7cXudYb1HoNzdfMuBK3JJS9g+xky5qdiq20/jKH4DRlrr9hwhxJHlZ?=
 =?us-ascii?Q?37ijQiRP9Oonx2np76CnQLU2GWOK6Ed5HxqCxipchAoQCnKamnE18ziBl2y7?=
 =?us-ascii?Q?Kje5QPbYVhPQDfH/c+5+Hp13vmEa40knLsr1VBexUdtTeyFhA8rf2H5e8wp4?=
 =?us-ascii?Q?Vdc8j1Cyn/VG+M7kb7FvXSybsbeVcOOC97wJkCNSVC8gelXnU7LxqJH1ZUVt?=
 =?us-ascii?Q?PgtuvvF1ZGhcH6ueKENYkEX7mfEJJycfZzEIyAEz/5LKMr0AnQDf1tgA/MN5?=
 =?us-ascii?Q?e3RS30gKPdeINraZGK19VmyUXbGADmbcB29enzzyIEYTkOsDlG2AxJFPK+uo?=
 =?us-ascii?Q?cXKz5Xilq6LOOxaYWPk2sgCW4iVKRu75lU9wIJ8TZFKc6u2So75Rfz55YSiX?=
 =?us-ascii?Q?Cx2DLLuhPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e154e8c-ac39-44e6-eeab-08deea669817
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:05:49.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVBtJkwAKcEbfWoFR9q/y5AnoUv0KV5iAqxrpvs+kXKpRPklG/wkvAnPXUczDWzZzdz8EMfvZZ3aMTSdZimrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

Scheduler ownership changes may need to turn a mutex-blocked task
retained on the runqueue for proxy execution back into a normally
blocked task.

Add sched_proxy_block_task() to perform that transition while holding
p->pi_lock and the task's runqueue lock. Reset an active donor to the
physical current task before blocking it. If DELAY_DEQUEUE keeps a FAIR
donor queued, the immediately following sched_change_begin() completes
the dequeue through switching_from_fair() before recording its queued
state.

This is a preparatory change to support proxy execution with sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 28 ++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e9829a289da45..9a9d4b5040089 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6771,6 +6771,34 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate if block_task()
+ * drops it from the runqueue. If DELAY_DEQUEUE keeps a blocked fair task
+ * queued, switching_from_fair() completes the dequeue in the immediately
+ * following sched_change_begin().
+ */
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
+{
+	unsigned long state = READ_ONCE(p->__state);
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	if (!p->is_blocked || !task_on_rq_queued(p))
+		return;
+	if (WARN_ON_ONCE(state == TASK_RUNNING))
+		return;
+
+	if (task_current_donor(rq, p))
+		proxy_reset_donor(rq);
+
+	if (!p->se.sched_delayed)
+		block_task(rq, p, state);
+
+	WARN_ON_ONCE(task_on_rq_queued(p) && !p->se.sched_delayed);
+}
+
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 64d79e9efc3d1..437c4f68c9e53 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2477,6 +2477,12 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
+#else
+static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
+#endif
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
-- 
2.55.0

