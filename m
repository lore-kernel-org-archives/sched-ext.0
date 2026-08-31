Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE645287E5
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183872; cv=fail; b=mLmQwG/QcOU68vFoF7oeEjx7wq/w/C3zELmyC6up2s7sf2qaCIS236jayR2FYfarCwDNk64Ma2umKngU3e/fNcXdWaq17UNcXdp4SBq8BW2154lvYsh1Dm0Jw3dliyhN8C5xn8WsMP1pO1uzhOdJtKetF8bEXrjMAThvU4cfIIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183872; c=relaxed/simple;
	bh=/RSZHIo/RtqYE62ho3S2MH8J7bWCfFEXJx3DvUVF93c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7s1238p4fwP0sdKxqANWEo7//CbVRhvW/MJKgqm+pxtv9r2wjjyfsMrztN1THEssE5ICf0nspp853LL3RwhfjSDWNm2dQXkgLMpwpAAb7FY75x7OCe4lQI4OfINo7rzsqrqwjFyJbE4jXs7RkuQ7cgO7s10yVuYN6kTTQ/tYro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NK2O1KF2; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NK2O1KF2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1JsIynzP9UFZ/14JaVTBYKJj8/8irRBia8XlHELJ84hMCBM2gKOnQBJAlgFug1tb/OD3jyCt32xRj4QdTVqCe7NexJzuqILXK2AJDg4HcVVEYf/nNqu74l5iubBk50h9EQW66i0G6HgFko3SNfJ2DaiLgskpADhW1ZFU/zk4pqaY4xvd3nWuKNpkY4+karzHWDhi1Tc1e3mgLUI+kzFqKo3PTmHOjbttM2gTI+12gkoSoADdNUQt0FZ7ExFaNamtDPtT8qtJ59lISUlgksPJyf3Rt3oIZn9IsmR4UJVJSAiVbMP422QeDF+7fYe26yYO1Ym5RKKAn4jB24XJlVEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZI00+kAWlm0T92BsF/GYrGuOWTiXC5qTzTuXQS7jKY=;
 b=XfUQBpG5Oq7B2fW5EQEf3FBrB6uo0J0meQhfaks+muNU7s/kY0JsNqDS6H3zqPouKta+U2F/RWrN98Y2PpViUQ0UFjPSJ6fhiObmCA+qp8ti2WAN4WHnSbqT3AbCqqYL6RY8ASxsVHsgzoi8XTrSXPIWzjggwQK+OJbXme+VQh2v+1QWzINgzcJ8/yy5HRJIqiFvyUIjMebsEzO+gazIgGGwKaedren29rqFvAGHFHgPkwuRCcMbIIYTQL/lTyMR2s0eABVLDrGHt1cOjePBYY3EyTWdu6hbxZSe1tAZhKq0vWhz72sApdlhkm9lq9CDuV2dn/qImxNTjdygWkQ+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZI00+kAWlm0T92BsF/GYrGuOWTiXC5qTzTuXQS7jKY=;
 b=NK2O1KF2vEXotqSZ6UbzCIzPFstZLNHFtd2uWX7BsE32yO3EBMGQK9sXRryjLEDBBftk7oMqqCNcHgVZqbpsM5lKM2zg1mdQFvz9YZHiICPY63fv1MamAGf9ugIKdnMSwoctjdVrImJnhYdLaeTN3dCHB5nOvm+HmiH5n0z+rktjOL5OZDJbzDfh6Rmns/vHlOiDid+kxU1AdSEbnziRnWAgf6ks4e0hMHAf2UE8NepXNFuRMrRQ2w6Aq7Vb20995GcETqt7DspBm8mnq5eRhKmCuMUuEEm1x2WzqlOL8/x+yqZbhyDRDZBJ+4/fqRK7av1wQVdCnrw5HwXSc3dq0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:44:23 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:44:23 +0000
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
Subject: [PATCH 04/18] sched/core: Avoid false migration warning for proxy donors
Date: Mon, 31 Aug 2026 15:42:14 +0200
Message-ID: <20260831134338.1531664-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 15186f5d-9f8a-42e6-fa85-08df0765f763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9eKr7UxbFcNFWl8Jwfk4SLJUppaaY8DKOeZ+6jKFXmm/YG5Qn2wZBbmTaVrPBMa22zsZT+R1L8fsda8qn8KkKO7A+/0KUwQq79PaunVLU4+a6vIRew2QU+kMoBs/2wOgsBxFRqV4735PHpF8Id8wcQzN9M46u4mAOAkXuHCecPw3s3Pq8PvisMwhxOLIuLfHW4EsWNP0WHCIA5yg8v8u9/0SwZfRk08ykMDURaHmvFgYrvDVtY00sg2VRAng+KKy0bCo8isEnqAHQa4Sj57wIgH2PhFWw7Nrdwb6FkiwEkg3hELKAeQ5/pLG4oqpqU/gHrEyKCU3zqKvJGyVKRtxhAZ1aF1dZH2Lz5+Qh0aqWpRTq8IyoYNXPStVPzUydFDr1DiKR5JG5usiZgYzAbd7985J9dTCBKoCWOhbDkiBZ70eA9fWmAwQaJnzFnIRMOLz7DiRloMGUdJq/DMYFP6M6jDQxdqvxCQAj9uZh57lEUgN9RvVNvll63qJw5qAZ+WtXrigoAUF3PYHcXmP8C8LuuzP6Zx4PMSJZ47IX4ys22xVhgIyU40XtA1SutTPh/GedXXa2P0e1MIxsGLb4eCyzHS4uNSK0puwHEOpL+btukcqZMNDINPk6EFKmjBCUU+T3tVQ+gC92Ul4oJ03imZ+KY9umYqw+LetYWp2v0VGRQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dHNduoBVahIo6SCh/hzBD9VpmQdBHgHg8NpRulDVRhlNflm/I55fXajzYce7?=
 =?us-ascii?Q?4lwtbiN6BiEiFIsb4r+In+RQSEh+9jjAYZd3AAHU6ig1N2CIgWnNfdU5Vr2w?=
 =?us-ascii?Q?wWWydJgfDXiPTc69yxSR2riQ5QUbHjH0bTy67ZRSUkHgbDT0NOfXKXt4MYxU?=
 =?us-ascii?Q?yKmm0wK5MuG+s9ZxS9CKDM+CbCH+J5kFP8homFGYeqtkrBgJxV+AGQ0gaGqd?=
 =?us-ascii?Q?4dEyPnJm77cRKRCKWNDiClrxaqoyIEBvp5JCgXNr/7fSkt/OPdTiTYIM76PS?=
 =?us-ascii?Q?8gNqzUT4AveCvhpNjmxLz1lEyGhG0bKnaAhbp0qBttp9ngdOxiqRM0KNC9GE?=
 =?us-ascii?Q?+fD2aYp2C9VIuAWGUNDTp+WFSpTLp8HEriw9OdiX5ObzOj8IP6myIlq0OK0/?=
 =?us-ascii?Q?2xkx6Z5jARInE3dUC5XWNhdWT34jxiLa4IqaraldelhSDf28uprQSrWNlooM?=
 =?us-ascii?Q?1DC7Fmz68E9JF5UfC65Zz0/U6U+PthKYPuewnIg9R8k0SI1w57OawoHaTP0B?=
 =?us-ascii?Q?ABO3Xk7AjRFAOKZSSB6DDdU26VmzZoGN6RVTnnMKp3hYPUsBEfWaHBSa50r/?=
 =?us-ascii?Q?9J17t8LEkJ4YOqriTrIRYNQ8ojVZtoSs52hake8IVxQXwQFsDpf1ibrsW/5n?=
 =?us-ascii?Q?oxHKCDaiMYOHzaX969npgPIttb7tWt68H2+HGDUrWw9wpreU5LVm1ip5FCof?=
 =?us-ascii?Q?87H9Qrx12K9xwe458VWUHtVXxwfp/3lxgv3UhqHxr5ihvXoGHWDnZE30ZdcR?=
 =?us-ascii?Q?S4l76WUNfzH97hifWyxxqQvArYludpcxVJpuD0C48q3W+fP1XarhwCpRUGu8?=
 =?us-ascii?Q?Di4DZdx75/jIv598il/u0XKyfwSGq7z3n2W2LpjpNfGnlmYjb2CmowmlfITN?=
 =?us-ascii?Q?9cSrv5AypDpZ9gzdkSNezfUk7qCJExSDv1PUkQ9EWUxuWgzWUhGzeS6jMSEF?=
 =?us-ascii?Q?7Cwy1v9eOd5pHrGqumoxMQvMiin9L4EXjnsgoMHRdS3Y6kT8svTLRWd5Y6qo?=
 =?us-ascii?Q?Sr+bcCu/wyzYhWG53MfRIZ9znSWbSPs3IFGb1I9D54UVFFJnhyqSZ8gRgl84?=
 =?us-ascii?Q?meCF/HRnPG8r5c2Z51eNhdddY8wJfDv0m+OG/mAq3/55i+LwoRuzmmIX8VEA?=
 =?us-ascii?Q?HN80JQPUZmMsRam2/9cPDopfg0udG4qy0B7C9d6E26HeLh2GzZ2KradkUqyw?=
 =?us-ascii?Q?1+SkS45Bcx6zsy/slLeHxfulj8sFlQknkSmIcO7ObOmZH5gG0plm8Jlm/E0L?=
 =?us-ascii?Q?moIOqT9c58uc0vE/rLi9Z2GWdSKcSdJWtWu/i+aoCeOW6f0ivSkpttOnAtgq?=
 =?us-ascii?Q?oLJfzIF6q0YNf26b1GgTCsNc0u+WCL/ZUufJ3NkeBq7wqDRkYoQOwKGuA2I1?=
 =?us-ascii?Q?o5hYrW42SlV9m7j2949NMQS2sA5fJ7mNUKNn0w5j9uC/q6Dg81ujFRsQfbjG?=
 =?us-ascii?Q?bJM/liuA4QeDASkq1hXO0jNCp7akzTNsksvuUODehOB7EDHeN1oqo45VHwr/?=
 =?us-ascii?Q?3tRpNhNfmcDEC9GpcmurV+CD82BzpaY4hL98q6+DR5S22wqhl6YdYNmN6Qca?=
 =?us-ascii?Q?Ilux7T962p5a3DI+J3LI3TFe5DXaA5uOuOTJ5cg1uhpVba46BoW0QRxck0Fc?=
 =?us-ascii?Q?SvMejc4whitpvR2TP9YI3RxjR4CgLHCtflowO1fRJ5+Cdym94TRM36IZLcep?=
 =?us-ascii?Q?o35FGqs0Fn5jrSP+G0bBFx8UwPr4r4o20pLLkLzttypAdU/M9ELLv8UHlGQ2?=
 =?us-ascii?Q?Gt8JeEkz+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15186f5d-9f8a-42e6-fa85-08df0765f763
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:44:23.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6/jtxOWn/mkL9CoWqpOM/Lk0sHO0InqLd6SELbocCZ33XuC6hKaFy8xaB8eybvVg22JQPDu27OeiCNngCZsRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

Proxy execution can move a blocked donor's scheduling context to the
lock owner's CPU even when the donor is migration-disabled. The donor
does not execute there, and its original execution CPU remains recorded
in wake_cpu.

set_task_cpu() warns unconditionally for migration-disabled tasks, so a
subsequent proxy migration or the wakeup path returning the donor home
triggers a false positive. Moving a blocked scheduling context does not
violate the migration-disabled execution context.

Exclude blocked proxy donors from the warning. The proxy wakeup path
restores an executable placement before clearing the blocked state.

This is a preparatory fix for enabling proxy execution together with
sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 14d0d5c884393..0a2eabadfee02 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3351,6 +3351,8 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 	unsigned int state = READ_ONCE(p->__state);
+	bool proxy_migrated = sched_proxy_exec() && p->is_blocked &&
+			      task_cpu(p) != p->wake_cpu;
 
 	/*
 	 * We should never call set_task_cpu() on a blocked task,
@@ -3386,7 +3388,12 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
 
-	WARN_ON_ONCE(is_migration_disabled(p));
+	/*
+	 * Proxy execution can move a blocked task's scheduling context to any
+	 * CPU without moving its migration-disabled execution context. The
+	 * wakeup path will return the task to a CPU where it can execute.
+	 */
+	WARN_ON_ONCE(is_migration_disabled(p) && !proxy_migrated);
 
 	trace_sched_migrate_task(p, new_cpu);
 
-- 
2.55.0

