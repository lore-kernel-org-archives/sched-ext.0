Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68FF347BAF
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321522; cv=fail; b=oQFTESGf6C0ykNBbFVWZ1Dxj3nt+jx3i60QXdIQZAZxqQ3scORXubRqOPsqbAdcMVXJZeHxg9yMA1Ui9Y8O6gVJbRwLldG4ExiVFQ3/97LQ0VBsUOc34isSBHAC8ArLzbZDGBiArYApZmGkDJHh/7GFzzdCJ4sQ2h9Letzk7z9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321522; c=relaxed/simple;
	bh=r1nPWP25vxJk5U3ISWFDaHVG4yvmQ/KOS2NME33Iluc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dKEUgXpIWO2jaR16GirxMzyLYw3QO3E5zzGu8UXWbwbPsh8Wp/WDgL5L8zDfmuuRm09z+9CDgZCkuMCYtnoMJxFJkDkaZCvaGJqUzAXre7WSkBmrpdoP0hU/e6OdnjeeImyfDRV/9KGAqxhL7IFKCSsVUOoz6zAG13D31f7Ogws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aGOzrFHz; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGOzrFHz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZixPWZAu4yQfZPVVis9qqqL0wtF/bMLLbqsWji9+LlPj58iCe82CKIJuXJ14X5q4OmzR33R5T84uQnn4bmWilm+7gRo+zIHFdt65szVZJtQv1huZVciwXXopscC51EeSnw98ojqcHWro+h34Nyfkr9ygjhl3EMwFSsx8LyE3X6Yaibp4+x8Kp00KeAPknI5dUKcpJaLQKQAki5x2nJtp72vgnAz8dZ7NaJHqw+3JNCqgcHEdPmK0cb0ZDjNQ27v01NEnIQOHjs/k2vKoVP+9scUJIKV8qIEccK7T0Azp2Cd4mp/e8CmjplBJo2SKesbS+hT+SGyoK2g6ro7UHS3h1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49iidhY+SJRTxAjwB3Klc4ns/9V1FGcsNNrIq5uO4rQ=;
 b=hFhVZ+ekwZCZLmGNoIGKoFxoDhqSSLsJ9kBj93wBRZASuTLT2FT7l3rIF0RoaHsWbmPNK7vJFvAJzEv45yEOy8ydYqFJ3AWkMNG8+gzk1yZt9+q6Mbzg/W9cl1zcv+iTD5Z6wOzgj3i84phjVLwda9Wp0XYmWIVd2A//6O6AXEg42frhg8xFBTsjxadiC62d3zoJZZZGRAiWoQQgYSD1PIT4Pdr1Le3VwZCl+iLNViyPCHTCR2e6yA+yDFN1ht3kC8IJq77Ob86rNYoR3mK/FXDBcMd/bCUAmPnGx/0/J4qg5A55llEe6jdjnOE+cjDGOHaKSpz0Z/guQkO51PFv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49iidhY+SJRTxAjwB3Klc4ns/9V1FGcsNNrIq5uO4rQ=;
 b=aGOzrFHz91U1aYTXa9Hh4Oy23Xs+PMvRIa1F9nmOowbG+AIIkVdUSr3sTFUaGg3JUPr0ICWMK7d6VpctnjgL9LKc0Qxm20E+hdRtlTC6ELmqaSL8XIq0vzyv6LYHJ0VrPWieElWoRNod//8WzaTX+zBvCzpvAmPSTB+SwMGOOrk4TG8qZ8+Wjfet9JVzDq/Yq1NvLC3Ou1QWsQLLK5/61TbQnrGfTXiCd3C3C0pRvi3RJX6HrWF0HSNBCw0x3AG4GqZh9yohTIw+Z/VW0qAsOWJP8Ue+eOsN1UUG1WuZteNc0AAi0j7TUGZC7ng/SjjxWB/zeph5UGvdxxoFCjueNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:04:51 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:04:51 +0000
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
Subject: [PATCH 4/9] sched_ext: Handle blocked donor migration with proxy execution
Date: Mon,  6 Jul 2026 08:50:59 +0200
Message-ID: <20260706070410.282826-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706070410.282826-1-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B7A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40e) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c35e714-f2f0-488b-0171-08dedb2cdfb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	eUTYfcAqmdew/RMQ2/xwot2CCemo4sbqvdwbzToSmVNCnUzJXlAxLe3h8es7s4rw/hk1GFupvF+BU3Av0c//buaxoszZGMQvG2tSelUqxI2icM5JalxPBTTd4pq4EudckTjyJRSqX8TmS6AtMfCnN29wt/KJQsJliHSgzhmZ1Y6bcGlG4iKNAs13KfHXbQuw9AdQQg6vQFBmRnzcAUysMa1U9/eoVnMTyGxFvnx2zUQHWV+is1CahRORYJjo8ZfT71M3TDx9MzfXMUYYdVC7V0gD1gpop0DAymDoa204PIX03+vwYs57XNYCnQIueD5HJBAr8mHutG1CtvW4lIRDdKzcf+ynEIb2zlZ4WyDzPTYoFokTuUjk3k6Hgz25PcvTHDOAcEC1r19zKVQNgSczioAxHNsHUIqgQscs+k1IVvA1lSf/HV+tvbqFZ+FhGpfAYkMJqpfxyUfpAeQr6LelRtkRoUf491qThTHYUYNEI4aqZMbcpxvZPyG23zEGYt6fYzr9qc7vUtyKR85x2j3g1pfefWnaSlBO95FaaMzGrIf0g8oJugnFnN6qnbM05/BPCATyvPK4uAyiw2F5Tnr97uCPDK8z7DXE2g7gb0FupvLDMgP87h9umxN6LMSaHTf/AyWj+zefzBD0ZDtZFu20crxTziKMlbbZ9seojuZnuOY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+WGcG8yiv+3uBxianAsk5N0eeZV8Vsa/kpq3CZHS+UiaKkFjf0nVTrL1mUx8?=
 =?us-ascii?Q?ZeL/xphxN+sxd6WHwBJUNhyuwR7kMoP95raGb0dy3Uk0zDhHAmgMlXaTjRDi?=
 =?us-ascii?Q?QP2xfzxQqiaAz5pe6ybHqNgl3UaTl6GCSXpwByY7PW3AxO6/EgCTbSr0UjRv?=
 =?us-ascii?Q?ZUN7vYUEImIY4QSMxuL3ZDrwQvkMS81Tz6LgLmVQwm1CXjrpNSLBHk6IuSLM?=
 =?us-ascii?Q?Na7pxR9TSzsqQU2zzvIoKymxng5nvFB3DX/+mr7U+B1fBVv7FOZ2StPI+gOx?=
 =?us-ascii?Q?ldjYa9t6B29HBOEvvfFPpBUzacptlToAsKsAcUxDiu7ruAGSslMM44cl3LSL?=
 =?us-ascii?Q?apavMcqB884fSEtXdxJc6uQh74HQ7aNPkfrrcvlVzOneCdDV5Su3f8bUm4wF?=
 =?us-ascii?Q?tHK/x2COT5dFlWrodWCdCL8wVsqk/EgPqEc0VyhdTTQuPGytlVNGgxqCsHbY?=
 =?us-ascii?Q?fl4n3vTVNtVdgPA7dMaj6q3511UKfZ5O24cFRrR4S9lFDs5AsnvXS8LpQ4nR?=
 =?us-ascii?Q?ZvkwdCmISKVQ9lKbsFVm41YGq9FtpEM2vSD955hhX2oP3wdgoox35rlK4+86?=
 =?us-ascii?Q?Vowy07Fdi3RrE/5R2fCvcgHdGPCg0m8QnC9zeaaMyA5Y2wZ2hYFRsQLB5Iia?=
 =?us-ascii?Q?xj5NQKvA9KJDNCE1efqWjrPBQ+YwDbiNLJlKne+GiLVdMULccNbTFQtJWIzF?=
 =?us-ascii?Q?hc6PEffp9dJVVZt/tjwfRR60TL6WzCPv8gh8VKLnx5dR5QV8VcybaM6C4NT4?=
 =?us-ascii?Q?9RuPwn/JhBwHYWBRis4YyWBOlA8J+w2/8E1nsHUeS68ZjoJ3eo5rK8wqrdBp?=
 =?us-ascii?Q?3HPQBCQV7q/7a7aJ0djIl89upI78lxBAkln2aF8rpHvtWHVWldwjDxqnBlO3?=
 =?us-ascii?Q?6Wn5bn8juWuLOUZO9NS92Mi2DjtY2e+HoAePvdk9kknPVflQgdZFcP/JCmtw?=
 =?us-ascii?Q?tzo36Y1GOYxciVjoI+1sljAE3E8Lj+fhixlQrmSRB6bD7rUVWbxRYaH1eeEO?=
 =?us-ascii?Q?fnK0hBQTLTfbvhLsAI51MGCvevNmSMuAXYtRrzVACqLkbDBKrx8BW+csaZpr?=
 =?us-ascii?Q?TcGKHt9JAknbE5ERzztZZxgJZJYL18u8VISotAbve+zk3VhELwAj/ZRR8ba3?=
 =?us-ascii?Q?9cIR0F45sfO+InEya4+2aPjQfiN9TcO50O2hz1IaNRNl7oEt5k4Fh8agnMvP?=
 =?us-ascii?Q?CB4lTbKCj6vaNf0waw/bMJ5dueJOm8ZwIBqoZ4vM3IHv8wDpiIQoOpRlkKZw?=
 =?us-ascii?Q?XUEaEu5ZSMLbJaKANXGkyuf5yHRjqzRHJrHeOTbiV1NTPbD9Qb9w1ojERnTF?=
 =?us-ascii?Q?vILe8VsRe+OhZLgUUi56PecJv2dcgAa5wEyifMsT6KUcOoiFIBh0OaiOuhZw?=
 =?us-ascii?Q?Z1iwG/As/zGzpG6Qulh4h5Awr+9NWR9qatCZD1bsC1ex9x9nD7ylW97jdihH?=
 =?us-ascii?Q?osVuhgkCzyhY1ECvkaDnNDPnswILjxIMeLYchk9G7O2HagEnCI0InOrWL9IK?=
 =?us-ascii?Q?Aw57Ke5fpIT1zWDAjEsnKPbX41a6yDrReWT7mJjMTeOPYeTdklb7UwK8URTP?=
 =?us-ascii?Q?25uULsTyg/qdokVg8nlZJ+VMH/E2HpxzHCAeqsDEMi/XvjuTxqGzuNxgaMIb?=
 =?us-ascii?Q?lRagq3ZleZ66b6Kd89O6nmuj3bYdWyFUcONx+SdIYyfQBCF5+4mbC3sLOG9b?=
 =?us-ascii?Q?O2St+50Arhx6caqY+jo8UuL2ab2Gs05daOo+LMODYtgufgNPNHw5a66Uqhlm?=
 =?us-ascii?Q?oSiAaXCz7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c35e714-f2f0-488b-0171-08dedb2cdfb2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:04:51.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffgZ9itDSSzAY1vVAc8ED8eMmeaEDPxKVF1j/3q5yvGgy6sxjPEm8rjmz6ZMpWPo/Wj71GmZtentqQH7a99qQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

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
 kernel/sched/ext/ext.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4c6cd694c86db..e7cf88b2be7f6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2156,6 +2156,18 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
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
+	if (task_is_blocked(p) && task_current_donor(task_rq(p), p))
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2828,6 +2840,22 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
+		if (task_is_blocked(p)) {
+			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
-- 
2.55.0

