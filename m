Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D440B6C9
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959732; cv=fail; b=GOU7rwrvopB776MQy3MVThSv8JYRVlNw5ZdIhR3Ond4aOKoH1i9PD995pxv3WcIEERAubAZb051Lqxc2qHvJlRPVYz3a22VjV1uvIpOswrFz/ZBQyfzpDCbO90Fs+KXfnOND3+hHIolVTT2JrRnWKwN6r+pB7rEryAOtCYV9p5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959732; c=relaxed/simple;
	bh=ynbHq/I7Jb8LuYYBcXn+bI+Gdp8TStg6tVHTfjdPM7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9QUhtCIIpdyyLucPdEwwiTsxE3oWCeX74TDGftLK9EjC6nYTKAdwGXrWOqnbEa8R2a27LJgnX69Pg5nfNFlvwJ6L+wHzG0oJ8WXFwIYyEv3/DCLvH95/HEvtBc8ByLTp1ck25mEZZFbVfb7osRgvSaVZOzy5/p0ALrhSieRc0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ITn73lwS; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ITn73lwS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CENvThj1UQvB8a00DzzkwLaoJvEiBS3pqEmkfikwmQR+GCqpDaoiD8ysx+HmviM11g3URWWSg25SNrdEutGyA5AaoBhojGHc0HvaidpXhQ0bGrkWd8jbbBHGGAvPwhLxQX50mVxvBcm4PmaKO0WvRh+pP/1IBsgN536rJt8p4ANi8RmB3wIvfE/0+F95jCNZqZ6zXb2GHEI3vIGXu/pJ7IvHutaDZmGvytsgIFOCiVgz54X7et7FaCndq6xji3vfS4kbCVhoz/X4eFc1RYWAHK67Gq6IEW+FJTa7alo8JP+po8VFSZzo+fmzwRGsGh+xXXrc0iSci3k5tuKpa3pDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j30UJ0UYLhhp+NPJl/qxRrADeSi5p1XAnwjvK8wurE=;
 b=yOj/9UFNP2RzaMPjvFTJP8W6QqhIk0RSRyioi5oxmHDIh4of6YjThX12Q8BF8H/yLmndpzGXHIdUYR9eCUtV3ScoF5HuHu1gqssWtc57n0VL/SRpE9xdZIWniR/jiveBegBD0Hsq0XZ+yGZth3aD2a2zlEq+ztIbTcbTv/DNrJaFaU3rLWO5WU6gSFTOJ7PBE3Rx4yVAh7SQj63YtZ/LusX+4xWzT2VEVr/i1uS34ZaIfdn7h3jWN5WwRqTpQz2nAGQcUR58m+i8FSYPFAIPqxdQoLFyyA68gl4EIuaGuUbiQF5NAnSzqOkKu/QxayPnEFnGMV2NjdJGrqdC/K0UMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j30UJ0UYLhhp+NPJl/qxRrADeSi5p1XAnwjvK8wurE=;
 b=ITn73lwSa0JJEcHiawNQaeuf+BAJ8PC26eobKBnow0ogJEc6v7sgWcBl+4jyd4M5hOJky04rRnOsnY3Ki/tiHrWmXU2hezw3J+bEWG0LoJ3iEvnms0ru23TslMZAotLsx3IDKYruV7LcoFZA4KeinSM7YnhvR914uBlBXICl5SH5iSFUQqSxuYVwdKUrM/U1+kriYJyn8HlTJ8JPVok8KausliXghZpptCm0UUksc7DpPkyANb7hdlE30rtLWkQzXwBBVDIUQse+jAOI71M0MBnYz3AWJidfgjoieNb8mZPxiQIGLcpdmnJCRXPIAofU1Rks1aC8CMU8iCZc8XzeXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:22:00 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:22:00 +0000
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
Subject: [PATCH 06/10] sched_ext: Handle blocked donor migration with proxy execution
Date: Mon, 13 Jul 2026 18:17:06 +0200
Message-ID: <20260713162112.26785-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713162112.26785-1-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: cea39fcc-652c-4197-d942-08dee0fade20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	YJMwrl9mjAUJGfi4RtFJYwZptcOFvYfB26ZaKwiR6LL8OknK6GyQQrqw0UQYp5kWXNJtBo5QAnAjXL6vZH4F6G2SdN4Am0VVL00Wg3EGoeUPaZFNvtpVVV6mNibR9opGLDeB9MnalwgJhgIgPGkITrj3G84GKOO0W9Lki/i/NMFiW+yvfPBbqOvqSo0mZdYd8nqLCPsMHjKkRDBpZ5E9+EWif0cybg1Vgby6aE+p6RDWiC90vOt5/YJtU9NO79wxs+zYkchox7YlpCQ9enLZwfByg8UHADKroJ3cXMkTLmA3IhvKsc7cpXD0OJI+RyM/os64BPB8PTTBoOK8YPhqAXHKV1s89wjrPLKsUc+oBQfgPmVYU2/gpfHazP1w9xe/r9qhwpklFO7YEj+1tfdElTMww/2rQwm/oRpMr7CqjMofcXla+XG3kS/AX9DTqvylyoNLqfZEFp+Y+tNOoxOPoL4F0t5nq1cK1GpAP3+GNDEerP+5FIV0kU5w8siiH+dFrRWzXJL5X8M4PIN5r1am4zyYPfZ4pVV5KxT2O0NNHXQ2Rd8T06jTFTeQhoiLJRXGAZz9AS3bBNMvz/43zDUwgKxtv26WIJbnrM1Xd7BIyog9gDZ2dsEHSFqSYXsDU8nSu3mZswY0E0SH1xBbZb3WaINhSBS2hqisaGOWhhUKuZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNC7PwFCCIAaZxcp6Dt1tPyMkUVryP3WgQXs+yR0mTL4695Zvh0B0UlfeV5A?=
 =?us-ascii?Q?OBk+sXX8P3YFoopH3HD2Ek/cYSGpO8YDHURV7bWM7k8OBeFfhG6hg4JSJef8?=
 =?us-ascii?Q?VX608zpvi03gH3FSIeCIxUZt7VMjXJkXLHjdiovNwyo9WXrgNbUWbWkXRK0T?=
 =?us-ascii?Q?vAbsHJ2PxO9QHrhG1ocbBRA11XTQS+JqzTH6WQOQVTsb/kXfuBIeG7SyfAj5?=
 =?us-ascii?Q?iM6VYErzud/auwKSMwWkLyu73iguZy3qIKUYxyiWdpuLl/FWHOl2dFdhkprz?=
 =?us-ascii?Q?up7kcXcOgSx37JhrrlFTrTe9e4vGPafABDWe06RpXqB1Wt5qCptDm0v4Ujg+?=
 =?us-ascii?Q?KwSqCX2alWofsnDCb8/jH6fT6MmtrCcRrgCsA/gJlrenXBS+fhbzOZze7cP1?=
 =?us-ascii?Q?7gcjrgFih/LU4L65gAvwWRYLsTMoK1Px3GiV44vP4erklsSrE8pp+us9pPxg?=
 =?us-ascii?Q?RfhwzwHH9QaX8CR6IR1qeBJGhjMloh9blAGL/f+O6xeDyCCCm7Q7WEvS+UmG?=
 =?us-ascii?Q?g6W8RHRwwuD5ap+I2yKr/jP55uyT380GpngrkltukMcz+ZZL6n8GB79S3HSE?=
 =?us-ascii?Q?EOCiHyqef/cITgR/vWH8/Sc89QC+EY3bCw5ZyCMzy0poSkw09psCOxrteKG4?=
 =?us-ascii?Q?K5jt1rQda4BOSzLRdH7NJ7new4FZQ8h1NHXL5pAD8vNGj95SJFvWb75AK6NN?=
 =?us-ascii?Q?IBzHg9atOtpgSi5kXBZSig8tbXxCrepoIi83CzAApn9UhHqYarv5UwkAUo/j?=
 =?us-ascii?Q?6WEzLWdJylyB/Dh2UrYF5q5BHO5HPd5VV9blJsHABq/hBBZ5yNbq0CCiZqy1?=
 =?us-ascii?Q?mULhV2+/LKdyCLp9J/qAloeou9xne7Eum7vM244crLgHi+HEv6CbYlF0WnOA?=
 =?us-ascii?Q?Ji5ppxEyly6G2kxdDeaylqmlytzJs5MAzsxbGO1m1Q8rOFkOB+cjFd+oY0zD?=
 =?us-ascii?Q?xNTyTAdv1sHh3AGZtGWdy7I1g33uMlhR59j9/QIh81Qth3Y/WtDdlJNbnRKV?=
 =?us-ascii?Q?U6jvaBNdTIKVPg9msCBua9JBdsj0l7YdDXZBxQGex556R3xYWLw+opNsp+0G?=
 =?us-ascii?Q?0T+gv4t7NKjydPn4893EGIbumUittvSnrKzAVuXTb9L0H8DrwU7xjxCy2paB?=
 =?us-ascii?Q?WyF4ybjDTpchGBFxJjFiVQmKhGkquxi+MNwrkx2SOU/RpagqBtQL1n+uP5g+?=
 =?us-ascii?Q?Gg0cRgDyZkPrlEwD1fZe1jKHeVQBtuf82Uhq/C7FC67Xz53B4UVC+mbNTPLY?=
 =?us-ascii?Q?d0cSK29P6MS2lOCXRvTbtXCWEeFc+ptDzX0iUr9S2G+I14DI+y8vyh1Xf0F/?=
 =?us-ascii?Q?fyFrhDWE+bMnZgylXKgRU50+LltGDARpkxf8SKdz44Y/wHSr8INupsb2l+2x?=
 =?us-ascii?Q?ImpKJ1ZWAQ+AXt68MisVh2t/aQqyrZRPE5jmOQPdzkfawmUqNrOtxjetRZil?=
 =?us-ascii?Q?MKCFq3eHs3AqKW/Ac+ofab+S/ZWOhBZ0nZ+2KfuA4VUXaxRGy4BvNqbIFiGg?=
 =?us-ascii?Q?lJDHzO/p1KBv0tvtD+sIVazLBPfMah5IIA7lhofXt+2MPlIc2tC3sxxRV2ps?=
 =?us-ascii?Q?7SfXEuCdHVJ7lLSiF4o1Ytvxinu+MsuhzWfJ8nm51B0tt6h6q70jliMs1SoT?=
 =?us-ascii?Q?FvJZEJLLR5f6HSZzF6zp+NJ27AsrRexXJcA61apnF8S4Q6g5kBL82HwOsDkP?=
 =?us-ascii?Q?1N4XpL5XKP9LaaGthUJvoSOm2J+M9UWHWwrWUiH08tCjZcpyn1A/QeYLiMgB?=
 =?us-ascii?Q?/fLaHFdldA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea39fcc-652c-4197-d942-08dee0fade20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:22:00.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Snvo7nf2SIRcNvPK/BAAayFiqz0zazMGaOncRWNtbqzMDyu03zkG1FwMhzSgGZMoe1reLgKBMdSHKTb9zrF+nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

From: John Stultz <jstultz@google.com>

With proxy execution enabled, mutex-blocked donors stay runnable so
their scheduling context can execute the lock owner.

sched_ext may normally relocate a queued blocked donor. set_task_cpu()
updates both task_cpu() and wake_cpu, making the destination rq the
donor's new callback home. This remains valid if the donor was
previously proxy-migrated: the BPF scheduler is intentionally selecting
a new return destination, which the next proxy migration will preserve.
The usual migration-disabled, affinity, and rq-online checks apply.

An active donor cannot be moved normally because the source rq still
references it through rq->donor for scheduling-class operations and
runtime accounting. Moving it would associate the task with a different
rq while leaving those source-rq references in place. The core proxy
migration path avoids this by switching the rq donor to idle before
moving the scheduling context.

Allow normal sched_ext migration of blocked donors unless the donor is
active on its rq. In that case, defer migration until it is switched out
or leave it to the proxy machinery.

Keep blocked donors on the local DSQ when they are put so they remain
visible to the proxy pick path.

Signed-off-by: John Stultz <jstultz@google.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index fd530b55c68f5..578929dc40e9c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2191,6 +2191,19 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	if (task_on_cpu(task_rq(p), p))
 		return false;
 
+	/*
+	 * A blocked donor may be moved normally to select a new callback rq.
+	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
+	 * callback home, even if the donor was previously proxy-migrated.
+	 *
+	 * Don't move an active donor while the source rq still references it for
+	 * scheduling and accounting. The migration can be retried after the donor
+	 * is switched out.
+	 */
+	if (p->is_blocked &&
+	    rcu_access_pointer(task_rq(p)->donor) == p)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2873,6 +2886,22 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/*
+		 * Mutex-blocked donors stay queued on the runqueue under proxy
+		 * execution, but the donor never runs as itself, proxy-exec
+		 * walks the blocked_on chain on the next __schedule() and runs
+		 * the lock owner in its place.
+		 *
+		 * Put the donor on the local DSQ directly so pick_next_task()
+		 * can still see it. find_proxy_task() will either run the chain
+		 * owner or deactivate the donor so the wakeup path can return it
+		 * and let BPF make a new dispatch decision once it is unblocked.
+		 */
+		if (p->is_blocked) {
+			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
-- 
2.55.0

