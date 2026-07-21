Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2EE432BCD
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615615; cv=fail; b=RbcQsQj5+62jVzbEPxlLVXj1Hc59YuXJEUxWSYd5BrxkKR/N2diepL2pZgQb7jaYkpr7/8l8bveliRP7ybExQQkp8RVOLhZUKGRKTR+AffSSsVOk4Zx6TV+5VO4gecDoHu7BpWOytTTVattgqA9IiQbicuN+AClwRy5Ttjh6Xqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615615; c=relaxed/simple;
	bh=iSDJMZtEgi7Eni+0V+D0ER+VR0edhL7AI5KRXR/k/Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IxulL3DGah7A1gM9T+Mfrbe6CVP9VzBj+27EGidPvfMyJan3pd3K+utg/EwqSJ0vICgJnmB/h6UngrtQAGZqiA6RClYiPF80adP4bfDD8wDA2nlU+cOgEEbkaeOAleCppQ5toRNrvJAvOscUP1SZfRB1oZhEZSnlvoGQumPqgkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TF0IRigX; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TF0IRigX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdO5l8W4qOGd8yDGQBrIH4AFW1DJxdO7Q828P36aXeMCJ7aLVFlDhwREw6AlZ0LeZLGgNYkk7j9vZkeJ51PsX57pDrw/YSLqSVp7YgEZ9qhp5uqXiem4nxKQlIMkRoGYXU/JSVoMIVZ9IfNMMUnDL2+lKuCZJSMZo+vxzV94mkhd7lIMiJXfhzqWCNGW3dAhF9juinHVE0nauE8l8qYCSQ9BPeOgFYhlYDmFNsGmuz/aIEEonMXE80cAfobmZVc84oU+30mOWqM3sQY6i9/Gg5m4oAVQ0w/TijjsxNaYEFv33bSnjiUc8JhxhOEePQpwatqv87evTRGGYvlnJhW1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHqjlb3ikOeuqR3/6FgqP1zqy1q5tgEVwAZIdqDgLb0=;
 b=SjXVJbNav5qdcDzJY+wmNFsWV8PnMttpMnoarBg10DsH18SaOKvG71fdRW6CZUvBUh4wKjAE0IvxjjaT0gIuuEpJQvmV4GsGIp4LtL+4a54rM+lk/unvghqiTDflvASGXzhWqusMen+kLHVM1dBahS3v9IeHU+MsXbIJb9m042b6RxEGm/apkZsI/pN3YoSz+rYDsbbeXTJRCcRyv4TYqq/q8i2wa/fWOuisTg6SD/Lon1EMFX1vNFPGGtiZ/cehtFotIZtAQqbFEyFbwy7YA6sknaS9CL8U705XyqcbTNCvRnJLHUWvxnKSTSG/60WWPkNzFUIPmrvIlWtd02NDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHqjlb3ikOeuqR3/6FgqP1zqy1q5tgEVwAZIdqDgLb0=;
 b=TF0IRigXfeypTvAWzLu0OTRXFiNJokG70m/Tf7nWy7vENxpT0il9oyIpiRLEeJEJpm65DZze4HUgVgzDpjIuUn9oBTpPhTbp2sYKv9k+/cLbaSkfD+mAstlH50/7dU6wRJN2viE21Cf7hNuwSmVURk5FWX3R2ICuyPc7nJZTsbULfoMHUP3O46mWpG+GX96oDMKhHcx51gE5pmniqo+xa2P2JFw0GluG3nKISkLUP43jxNg7Szhe9Oqd2Rbvlr+4V9R1hgyX9O6ga01XT/NQy+dMgd/BxINak8v6fMWaWrmCgGkqiicmJUKf4CkqnWQu55y4gkE7/gYCRKvDFyjDFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:33:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:33:29 +0000
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
Subject: [PATCH 03/12] sched: Add helper to block retained proxy donors
Date: Tue, 21 Jul 2026 08:31:24 +0200
Message-ID: <20260721063242.552774-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: b42dbba3-5cba-46da-05cb-08dee6f1f9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KhGcjatRFLFn84E6ZGzYeogO1Kj+/O/NUBmiCGrV5gL4oDlvt4EgwvdQYQ2XBJufEZIl9jNOqxMFZTAZ1Fwz2TxOi93IQOsbLvwJW9gT6f84oukdFb2bAflhvrCJq+1wuPBi0lK0/PtJeeroSyKlV7Q+C4/YO2TmdDYQhMxTi3EEzygqGIfTgbsz5kT1zVNJzhyo/iKiBNKSwqzspHXep9Nz6BA3mlDyX+cBlZrronKyOLwuAp+LyNmFpDgo7Ka15/ujnbH4g55rPJndo10r5bq2w7PtqIBk5o/xUNQtSYajdZZXH0oEjoO1WgiISM253GiVW2X0NUCoErTe7qI1aIxNls+hQJOqhvTp2UabJvkZ+Xbr9fTUi+w21Eg3RrR+yuwqliPFIHFMqK73nk7uvTFAdM9htIt/nu24EQ2gj1HCQzTRl7Cku2QPkVhINYNzKj2RbLZC9lyVTHdM23gwU9tiJ8Da8JMwf9KNuXvar5s4SdL4mcN5VMajuNY550kzCKq9dXBqfQI+pwdaDDaLykpSBDa/w5fh9gQs5ZyUS2B+jJ+ketqW2ZXxMUha+gH3Ywpd8O8CqxKqp6z9XoNpsKxHgoGwS2iEYaBrmVz3p5sFaYUiNhu8ReShMoz3y6uUVia9hPq/QGh8TQWfe2VbsFZJ4LNx6m2/Bjp4V8fYBsY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p55Lus6A147cgB09BZrmf4RUdRs/iMCNzFhlVQ6LU2dzcqvhz8v0Y7TMXYlO?=
 =?us-ascii?Q?kvvFI9cJrUv2UKBcuw4wLUSKEcKfzLVMJI5YPByM213Lie27IZs30jlQm7rs?=
 =?us-ascii?Q?6R4EzXQ8mK9vTYp0WQ8TfY05/giojezLR8WGAp6stcQR7DgHeQQJTwF8aiov?=
 =?us-ascii?Q?g1ImEWzUbPJ5qELZqjWoOQo0uhVipbfjOgkstm1NLQQSKystclMaeI1VreeH?=
 =?us-ascii?Q?oOiJ6fq21s+cIsbOUBKT5yKGXly1YOJZmQKVjtCtxtODq6B4VSfBNYV8wdsb?=
 =?us-ascii?Q?Lly/oL6SPkkK0SUIRGWEFx2duQiuXP0iNefAfn2Ost4ne1LLa1tVGKb9XcAM?=
 =?us-ascii?Q?FVtVs/M08ycjgycE4H9aVECOGnHcTEV3IRSxtiAwiAlaESw/dv/zI7crTr6x?=
 =?us-ascii?Q?RBnlY6aE+dv/oopboKECIELZK6jma7GQUx/+H4AAANbaNQrWthWmw+wDRlW2?=
 =?us-ascii?Q?4KtUV2joPi5O1xdMuYc20oCeJCiwlHQO6VrSumTXV/YFTSO8PdEBD8uuEeda?=
 =?us-ascii?Q?wf5eZquENe208NLb6ZYY1CAdLMHaUcxy8W5TTuBbOxxI7NrYOZABBhIzD8bO?=
 =?us-ascii?Q?DhlJ4M/zwQUDPqvFcSpuPIJXkbej498zrQ1ku9/ZD7lyvfUNiqGTSvRsBtbg?=
 =?us-ascii?Q?Yk9v/ZCoYY9mvZnIUcBGwvgfRd5RLTGmoqVI4ZmlhT7DfXKcsJOlwMYvKMSF?=
 =?us-ascii?Q?Tymtkaeu4Atkp4kqra8z0QubSG99kkf6znPIEZp97sVbU4wIKUsdFEq9Qilt?=
 =?us-ascii?Q?PoNR39v56VaFWYuN2/ACQ4TIyRj4VtUNlqWCxhdHj2gFWVACJLbT1cdUCOH6?=
 =?us-ascii?Q?WNYCAgg98bjUYCZu421Xvc9yidoDIAmwXOtXa75v/5Uvt6X71Q2YHa4T9d0u?=
 =?us-ascii?Q?f+CuZM0YFsq9tFM82DvTU3NR555WyYQMfjoqoH9dAwPRD+pIxilzFVK4nTLD?=
 =?us-ascii?Q?3I1F/ThAZTbw14K3Q8cF2Uoevye3yAIFUyO+tty8W0h0f5T23bB0LDOYViB7?=
 =?us-ascii?Q?ccT5aKIZ/l6LjtiShr8iJ4w+7005Y7+3QeF0cAOy2+7XPSVAkETQ0JoRCNI4?=
 =?us-ascii?Q?skBUuwVjF/htvZOtyunj937DtZWO6EMplOr2Tx/iizCIRqh/iBRvYyCllC+H?=
 =?us-ascii?Q?Jq2fVn0XqMVglTtaQXmBlrZwjOmGbx5KiI/P5p5weQ+HmIdaoSeTJQRzU4U7?=
 =?us-ascii?Q?txqKyTopTPkDTu26A+C6JRjOYzb7Wf55cLhXMWIjJE5W/HURC6KcXTHqx7EO?=
 =?us-ascii?Q?t+T8O9UoDw9c/L3iMIbdoVyuc4ldGLUbw8gh0OgPOct5lBuShu2qm222/X6r?=
 =?us-ascii?Q?Md0YR1teklHg7YzpWYHZNd8kcBS75Wyxa4PFjug7iwPJHnbeomfPuFtXEme+?=
 =?us-ascii?Q?rwuD6CE+ZhdgP4ESc5y4x3nVUdKUjBpZU1E6Lk3JEFs8yZrTbAepCRFHXNzB?=
 =?us-ascii?Q?czt7rBCi4aIupT4g9IhD09+oJvA7toyOjegDFENMs3k48N0qLJBwUWrZVREH?=
 =?us-ascii?Q?c9xzSiNWI1gBu4V2Vz57oi1jki9SWtFgFvRK1Z9llxavuqlziQLm4vuFdO4e?=
 =?us-ascii?Q?B9STtFTsRkJgtHJE7a/ysg5t6FSV1kpKhuouP0fHqvt5UJgOTL50dTUhhouB?=
 =?us-ascii?Q?OEl5hRt8OTFQTgK6buZgeR0WcyMq0K1M6JLwMpWEHWLCh2xv6FUVO99Kz9TU?=
 =?us-ascii?Q?OVRRKKiF/iVf3BmzJh1j92IPkR7Ny6ht3SBwS8yima05ukeDm+kUXx7HiBuc?=
 =?us-ascii?Q?T/pi976PgA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42dbba3-5cba-46da-05cb-08dee6f1f9c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:33:29.1287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcvJNdqlfNjvBxKtEjvdYZe/SCH5UEB3CWaD/Q0fqUtiukAhJnRX6CIyanfUaatvN2xdwQ/nTgvc9NaGVoMVXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

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

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 28 ++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 074dc14c22d5d..b1a320365bc16 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6770,6 +6770,34 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
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

