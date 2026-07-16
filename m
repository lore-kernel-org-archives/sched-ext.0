Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1641F7C9
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208182; cv=fail; b=JvCv/N6T/5mjtRD63n+4o/eLVVI2okCQ461fkIbS0F/S/o9VAfrOsjhFcwIkCz5sX5WF4Wd5FPH0jL6YQhDiRvep/iBs5ODFwLo1XEbrNemAamgR4ti9CuHF+OVPFcV+mayi+AvzhWl7tQUU/q8dQQLqvldNBOhU0L1RNuGFuzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208182; c=relaxed/simple;
	bh=OewLTDKV8ya/bbWsuFfhUu7Eg84cPtN6WcyHnHRN65E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bGP9lCipSpuXjb/e78e7Suui8fxQ/Zb2cnck0r0tEaZY9K5Nh0YOxTP8rgihC0muLJP6Hr4wMSYwlu3iRJrXIOHyQ+BBfzGXfZuJgE6ZO+UYTUa5Bp14NtSvQkrQBkgBwwKFO73KScp8uHojb/HZTBWgMd8I4GYfMaGppuxjcz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oZ4bC4nJ; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oZ4bC4nJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV3DISDN68nwU1ZK46BKUgURIl6uETBL3YtrcU+Ti0+RJS9Z/CbLwS3K5YRpQ2cS39loVarvljGYGhRXup56SG3P4luoBRHgQE7/HapOjSmTVnpaTln9+Nz+T9VaMysMqAdr+OW4ThKw93Yg2/blop669pOyuIXOAhypSn8e/mS6+/v9LDPm3zeywuRg/njMB3Azrdw3NKAOnZKCPbxfSNjfFT9Li5bG+9QESmEjJSLjIk6DO7a87KrDNKEn5xuH7l7owX5Xgskc+ItpWHOGmQyX1UbSo0/cbqyJMkhwRlicgZikQrQxyvCpBitbiHdA26JuEgaGKKQWVTvvBbFslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2ap1Lu7uNUFJbVsYq9ie3G4O17Cjrvk8Vciy5cvVtw=;
 b=nMip9tUHQ2DFsrEPW5kIr6XevIVVfZ0THr95H71UQEswssGpBfO8pJd6KV3ilLtxUuDevfm/PldJcrPBmrN4O85UIQhVUFH+vvBjIOS+Kj/NsO5XTTcanibFuZOAf/L4zsYUJ92In8DKp5IoacD0TZAQREY3MXo3IzrA5a2qOFQOzdB+LhPIDqSZmnnhmIvggooz042xNEywHQg7Ko+zDhZLfMKwTdForkYnzj1kyRoftvCeAHL94V+K6aaadG0SqqRLYPLYn191UbIucXtZny8uEpaPXMKc1aTuJYI3Pt0YAYg8uPvbw0wB5u+dvdRxR8aAmauYQR+YCs0gGLkUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2ap1Lu7uNUFJbVsYq9ie3G4O17Cjrvk8Vciy5cvVtw=;
 b=oZ4bC4nJLyX4eA+X0/ZXrjziwJA2ORYtOjFGsbc1zma4t6uo1Cuyi4Gn0b92yDoZ9SWFWP1gE0bxiT82Lxox/oYdPrprHxIaXM7pAYfNUoHx8n+7JnSROuaRkMJWz/6yJ7ViMjF7yTnmvAvmZM7Qg4PK5ccCbTXC/Brjh4oM33iwzK5tlmWqUWestN5uedYzYE3S+8nc3jJDQ5cgLcJRoL8OOE55nHhwodRRp4foy75UhLcPOdefSb5+mhsag4iGsnQC0Dwm7hk39TOAPrpJvmwC+rMUinnYB3602OLHN0gtt6jBNaeQFLWGfjG1LwF6ikqtUezzEL0aa/1Ad4Gbvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:22:55 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:22:55 +0000
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
Subject: [PATCH 02/11] sched: Add helper to block retained proxy donors
Date: Thu, 16 Jul 2026 15:20:37 +0200
Message-ID: <20260716132229.61603-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cc3faf-46b0-4169-6891-08dee33d5865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JfVqt3vYNHSs7bWjS1RtKgw/kpQkiw5UK4FRiGXNtEF9RUMUKYu9izNsqJAbj4BL7LnGynbifDMw3f7AEx2eNjOreBgVO2qr2ywYbJ7gqeRsCTBwWNbNfkRthEphpD32+ZPOerFyMYsrP2zW5Q40ZiWad6BbOjG3uHZ33ks7wVrZ+zXtR4Ub8J7YBtjOrEkH53hdBYUD2z/arTa0uOcIgk8k8uABct0Jw7wWM+0/oAzP/4pE/Xo8EinZR+p399LIMtiNTsUxsKyr7MZ1Wt2at9otXM/G7hQZzmh1ECYFP/MjRA3kzzpXyfM5uQyN+iW/DecBUYjjv6/mO3nq/JqnpEgyZKnJrjUw7YzG/sE6Wu0RV/VutQ+B37rN1W3HSdznygoMIZBMlw5Ieow04fT63J1g7B2+NR4PEHnzLR0HptnAcsvMOUsmu8loXcxYPuGW6hOVnQQ6vZp2ZdK8UXPxpBJCfEVI9xBc2ohwQYY+pdqWNKoR20l3uL2Q0prbMVBPnzXVuqtAHf7fQ+QkSwaFSZ3O2Ema6Q/FnCqAmjkH26bBqAdprv3k6oEl5MxTKGbospWGE9uifQTNHXGmGQ6/yMwavFBX0Y/pfBCOC+Y6nFz+j85AozVdiAb/+zuH51MFtN0y/TW59ruOOsjdLlhwX4GjNOMhIKEgs8wa1e9vcHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5gKGNFpohMqid6c+4FxnXUybIcYLBoExtkWeRL7AZBD10j3LFtn7VJViOciO?=
 =?us-ascii?Q?JVKgmbpituYc/1ZSxKmARSvXbfUcsmtMe9VhO1H1eWE+oU7n0e4+rdlp2qhw?=
 =?us-ascii?Q?C4yVWNV4YomO+z9GIUK8rSV/x+zVHlqSQFRiBpf70o/dUgB5qdJIIfifMGKH?=
 =?us-ascii?Q?NtQR1E8mNsvbclmwHOVctSDOO+MGPybPlZSVZQcuSAtz/R97m2uvAeT/wdnJ?=
 =?us-ascii?Q?Ejq0TcxfE+MJ9Eaj7hI9Y4cIw/MpiZlqemcOMTHv2sQ9VNtYMd1dni7IsLD0?=
 =?us-ascii?Q?KxBhd3m2gBK+kxjrIXp/uN7VoQG58zme0aIYYt0PYRbrEana9JaNkup/nZPi?=
 =?us-ascii?Q?xtVktQlEDSGCmXDZzyTMwG3sNm6SojCzQIQTnz6K/oqTq/Wj1pLEBEkxy5gY?=
 =?us-ascii?Q?TmhM3esaHlShyhpsQmS22joyZfKujJbf4p2qvbd4jx8wkw19L2Ay/kt3sMz2?=
 =?us-ascii?Q?NqY/yEeYyNG8XsHcFrE8Mxxd7/YulJve3jU74gFOCvkmGI1oB6f4AYHvZggg?=
 =?us-ascii?Q?voHbt3dI0J/StihzmA/MyfytLwO48AOMC+RwKSkkad4PVSu292vrW+XeDHAX?=
 =?us-ascii?Q?wkzSTW62rTtIkrfgfpmdxh3FMenoOpkwGjxp+D0jAvI9gDFes+nuIA7Rp8OR?=
 =?us-ascii?Q?BI4h0bxeVvYwosCHaH/uObKkGav10dFs7E9ZAoiqNDIZiZUJj7fXj9ei0wRB?=
 =?us-ascii?Q?u1M6qFIH9NhbfobeLKL4bPziYI+hgzW9jXbD5DHhDRV3sLi+6rYF1iGQyz3P?=
 =?us-ascii?Q?/496ib9rrTLQ/tMzb2Y4k/T669kY6tWeX/v65LDYjJcf8GZjAnwUjkiu8hAD?=
 =?us-ascii?Q?ewguF7pCshhJmlV8NYsPl/8S3jcjnkmClBHkDNMEY0yRUf6FxukdKqnVqjuB?=
 =?us-ascii?Q?URfN1n1nQtyepGIXn8btEjns4LjhygJ02TJdaMhH+i3hSWDziOtiUGiaXty4?=
 =?us-ascii?Q?qF+7AgogSauE0zNL6N8VuO73zoIlD2Wgq9guM87pxQHcVY/L4nHDS48TxrJ5?=
 =?us-ascii?Q?MPLIB3T7+xdK87bGCCt8Rh0ORg4m9mLKAn3J/HKnsQc9o7Uj+HVIRra9YUvr?=
 =?us-ascii?Q?Q9AukqjYhNdBoRPgjbPOgkRdchKTWOgwJXl1vWTD8BHXayjfcCwSxKt0qKr8?=
 =?us-ascii?Q?IobfpeiSW1rRTnZ5kn4qoQbLgDiGwfFGa1B0CZXtpVg3HUfdIjd5QpeZZEtO?=
 =?us-ascii?Q?Y0ha+M2ptstm/VgF6C1tuyJRpZJTy5PNZV6HGB6LreLYlvv3NTx0lLk13XOt?=
 =?us-ascii?Q?uQSjW+mFfzC71+Hz03vCgDgBmNZtmJwqGXXaqqxU+OxOg2JHwT6YMpT7bDB2?=
 =?us-ascii?Q?od9oMUUGPGg7zdh8FLH3EK16Zr4o1Gp5SLULJmONYW3X0qMqwRMcvND9vQva?=
 =?us-ascii?Q?6pPUCx+qUQ63nSFzhXe6LZkKZD/5dzEjMj+ga5gZO9y8xB35wHYsFszENxDt?=
 =?us-ascii?Q?v4kJ56wz4F8+hXBC0Mf5HSGs3aOUx55nTHq/pflS+FSeQibzntWagpCCmAvQ?=
 =?us-ascii?Q?RgafHnR9Aa2sRQmwmxuJAhVc20yd96GTkx5PvaX8CyLjOMxyr4MELVEHf5FA?=
 =?us-ascii?Q?DsjMkw0rnJgyY8O+bkUCANJGUUADHEws8pKQ4r9TCujHrj5FAPhY2wrtysqp?=
 =?us-ascii?Q?VyWctB9HdCxvoMoecr6gNjhdjp5twWXVvJ+xeY80FsEtgMoAe0yBmL+uW2Nl?=
 =?us-ascii?Q?EyNURsazMzpLMfDZYlPU+QaNwTu/X+BbezaGTVbmOF6zSRJmt7wFidmEWVRb?=
 =?us-ascii?Q?bbXITt+8vw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cc3faf-46b0-4169-6891-08dee33d5865
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:22:55.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx7GFqcSpKLXsIttQbrN3Xw1kxZc1pbth5pKdv/IJTUxAcqo9lL8Jz6LHhPhPLX9f86vOKf/mKT0FjrHWDJpGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

Scheduler ownership changes may need to turn a mutex-blocked task
retained on the runqueue for proxy execution back into a normally
blocked task.

Add sched_proxy_block_task() to perform that transition while holding
p->pi_lock and the task's runqueue lock. Move an active donor off the
CPU first, and complete any delayed dequeue so a following sched_change
cannot preserve and re-enqueue the task.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 45 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f47bcfb25033a..e7827cffc2f0c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6764,6 +6764,45 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate after block_task()
+ * drops it from the runqueue.
+ *
+ * Unlike the regular schedule() path, this must leave @p fully dequeued.
+ * DELAY_DEQUEUE may keep a blocked fair task queued with sched_delayed set,
+ * which would let the following sched_change preserve and re-enqueue it under
+ * the new scheduler. Complete an existing or newly-created delayed dequeue
+ * before returning.
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
+	if (task_current_donor(rq, p)) {
+		proxy_resched_idle(rq);
+		/* Kick the execution context if @rq is remote. */
+		resched_curr(rq);
+	}
+
+	if (!p->se.sched_delayed)
+		block_task(rq, p, state);
+	if (p->se.sched_delayed)
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED |
+			     DEQUEUE_NOCLOCK);
+
+	WARN_ON_ONCE(task_on_rq_queued(p));
+	WARN_ON_ONCE(p->se.sched_delayed);
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

