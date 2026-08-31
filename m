Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7945A2BB
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183939; cv=fail; b=c89+b6Uim2cjw/6hKOBN5CSUUfr4cSA7MH6gjgfg9oi0+M3NYYeD0HPHHtZQCnc0LRQK1+2a1thP2i2wwNJsCvGgeZVFPZHQxkYN/ROS9r06/pJxZdBh7dsnb9ITo8Z/Ui9JlXrwSzq63hc6F9L5QYBWr/vD5UCEl0/l6FnPRXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183939; c=relaxed/simple;
	bh=OZxc00Sae5WShxuZDHzCnhXy3RnEVTNwJ8xQemXNlHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TzOLn1OTJ8bTU0ZW/AUMclpvPBdyiZJuNnKBqG0Pganxw5dexRIo234XONlPBld1LlYeCb6MmyxIBnYGvGkxYoyAKDBKc64sE3rPZO3Q7Hv5YMRzMgIgkysy/Ck0of8PVAyrbv+VC/1XsoItSs/osBrXVv61aACrjQ51RkJLm10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G2SVL6hU; arc=fail smtp.client-ip=52.101.53.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2SVL6hU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8nTg9exzQRlGlTGsWo6WiOL8FiKCJJX1PEwKIl2YJu9I8mGZWI2IHQq6kC+auDP2k+07AQPCPRe2Wg5fbF64f0PtbdYqFFP0gioou3tGAwuVIBpOWywKzAq6oU+BkMzfYagXxxq47oxfinkxWsuMaRoqWhp6vLkiHsyKtrscBMI3VQMhHEBCE+8VOZWTkcMHhxWQlNkMBpe4DIDCPScO2VH2cnYgRVnQ5p40qBG9lkV/y7G18lMn/4mKWW/DiHseDXMhDnmmTuhXyFZzrbf/26rf9vA8HTjgylSV1CfzWOMPVrTJ8JMHjkmc2z6tLOALGD/M3esCzk1Ozf5jJ+hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgJN9L6JoI/KzvQXEkiQhqImLjG4UpcYqZ6hYUtdqp8=;
 b=aYOAiYBK8ajS5dYxua/EvGm8Vtb2taP3qSJyHhdB3qAhixJYD6jCMV/2sIyPifC4rIItQgU+ZPD09vPEXrIK0KSlodZCXFKd1Zgo0hxTxTtPIh1dyMCFq/t8lD396yUHsOmcAb6VRIf65uCkNrHCoRc9Rv9XOmozdvS6Wn32M8Jwni1R+fS2e/v1tWuQIgEvla/qtHqWFFiW5slXz9A1JLW25anXQA/KUPLqyC4emnboZNQfn4AAZFBkemZfXyNHc0T3KWpHekUjcu8kyoVTeXv4MgR4qrBx9EdIc6uXZw2KDZapGhJXEukshV4hyMgxeAfgM2UcHWVUXdwkiPGmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgJN9L6JoI/KzvQXEkiQhqImLjG4UpcYqZ6hYUtdqp8=;
 b=G2SVL6hUoOr3YN0TwkTuZsnMeH0lW2wpmXp0lJ1MPJvZMJxPNFFv+BmE0AOUMXMBdLf400KD0hrp+LBpEPnzj9bhBgJr+fy2qLRAui8pv4DA4TfeqQyuCyIHkBWynGZCL8DAvXiL9HkiFmO7/LiHzuwhamSD6AZOmCQlvCsAJVr2XZdsdpqfePzMuB0E0By9sDbvM0YhFXviNFrJ1cuovlUZErOrC2Wr9/6nweJ78YlgMjtBBRAZxc17euCvU1SdkHJNe+PVEB+eiilz05FoxmQeNxZr3SITn2ya/XV+Lpz7plaJcf+oPK1RwDuytszi+NSu+wrdbKsjAbgOloIg8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:45:26 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:45:26 +0000
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
Subject: [PATCH 13/18] sched_ext: Handle proxy-exec races in remote DSQ transfers
Date: Mon, 31 Aug 2026 15:42:23 +0200
Message-ID: <20260831134338.1531664-14-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: c1005c10-c3c0-499b-6162-08df07661cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rS6Hp871b5TJv76CgjfjszFG51ueuSSWSrM/xNemw4FNuJ6rz0nYNY2zPGSZ5AlHc9Y3YzUjsm2P99Sh9fCGFMksYDu/yyWFz1YJIzvG6lvTjWrE4D/DsUuiR1AuLXwIv033BEWwiPK8If0/8A9AH2D37s2vjoDoDmrmjx/vxOk0tYyo+2gGdo2zTTP4o/yuFqVeTX7fnZiX8zHk85JVAsCzsBNGyy53SK6nI0eTVyKqkUTU4HH8++q7ie7b+6Fr0nCmBF1MN51q+D1VoUMatHUBGz37eXiW1jnPLwwgZNcGuD1ZcVkp1sxhEuCJn3KTiwoFpVB7FT72uxUhFp4SVo9knPAGbXQ90eRn9/6bVW+XuVvgLENZf3EcBt64uhoACUN0vhcLLu7EhUvmyqyWOXnJDBRyvsL7LkWew/PUL/LhqUZwAA30nML3l4fj5Az9N/ts13VFaiiyaWSMd0m2tSYgor2unlaij1j4X2gC7hKkS5I5gXXojqlMCmAfgaFEphgjpqRmS/onFCLEKq1TawfZH8uwQiWqZ7AjH5pi1RlMP3QQ2CC1ojidATXq7ZIaMLEnbfu8fYQzEmTK0exL3KHgH8FsRDsudil8G5RcmaqblzjHELSOjGCOak0by994YGd5D/Fk9+pibtxM0UMgZRIalkVeL5oqDfircS+URso=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qaEFrjuneL0r3DqeSUq6j5c25apvYHZVYmRw6Vi9tw83/HMa/HOxqwsQQgzl?=
 =?us-ascii?Q?JlMEg72rz8ypNsCgpdHirF2R8100j4pmQeZeMaqFLurm/1e0ccXa0t9dpOfb?=
 =?us-ascii?Q?ikRBqmiWSDsZOB/fFVSSkxk8W9P8nHbumXVmE59959Q2j07qTC0qSqKBUDFa?=
 =?us-ascii?Q?xsTCKJW2aG+h5PGIRoyYJsmHcx69dSZaAM4C2I8hOFV5CZMEIUNnaqgbvoA4?=
 =?us-ascii?Q?QurluHsWgj3TLLpascHMp1yEbFQ+ZWA3sCyvHVWU544jkafV3pqRCL6wqtFY?=
 =?us-ascii?Q?Bs+i0zF5Mgy9do0so1Vpnnu+3LnZ2xaaIxQe2clHmrWApFEDSBEarXx1FS80?=
 =?us-ascii?Q?18f6YCDHSBmguuSlgZeP+A7DK4OUJ9P3RXqUykALXn7L7/HDoVjGpGx66/4M?=
 =?us-ascii?Q?qUZ7FmZNnKPKkeT1CkwlBGeJrngceRD86CN2OqfGwVHebASNYvk+MFtQsvbF?=
 =?us-ascii?Q?PyDCUlZfF/urk5GurH80VV+NzP7KG7QCx6vbfh4voGHa0pWpIboCthPg8Zi8?=
 =?us-ascii?Q?4l1bWjaOahDls6eofcJpNaGN9xWQ7P/JlbdnVosIG905zQ26UMKZ2nc4/hl5?=
 =?us-ascii?Q?zzjYRvZz7IInzbDSUYlOGEGtxU9IontozVZ2YWbWXtXM74V6MHMP7CF4O5Ko?=
 =?us-ascii?Q?LbtIq8B51/xPLuG27w5fLkdfF34UxtlVKqgW5viF9QgZcT75mBmZBYj9pKsR?=
 =?us-ascii?Q?wPhgV2f169at8l9jm7qEuaoa0Eb5GlwiXhx78EK7dio1OIGrHjQYVe9RLB88?=
 =?us-ascii?Q?T+gxeU4V+0Y+T8g8XuT3Z7iv5xFA6WhpTUMB2QskmShiBQbtEG1Jqf/84HHV?=
 =?us-ascii?Q?Ui3wmH3EQKZhgcbRdTJYLC9mt0ej8oXJpKpahI5zEGbxtci/7E9R57oizx+r?=
 =?us-ascii?Q?cxDYHY9cOcZqRjPK7BtszApt5argEXHocafC7tsZChw8sziaKw0w68D10HXe?=
 =?us-ascii?Q?NRrb6Qo386H2GZtzhgu+2hj1LzEWD+VrH7ZZejGgbP0QKZ1v1kjvDuTkcjh1?=
 =?us-ascii?Q?E2F4EMeCjvldHGEGFjHCx0gxbwL9ze5j0/BUzko+j+xolRPC2S3+3rOL6n0X?=
 =?us-ascii?Q?QBOrs6yPrsFSju67b0BobZ4q46jErGUjrriC6zcyvpzn0gNI1XCEkAAFREkS?=
 =?us-ascii?Q?i84aDKfmGq6zhlfYONN1Og7Ebb9YS2i+eIQoG8dumg4juv3BbTotzVtX1GUw?=
 =?us-ascii?Q?wKlSY8+Vr120o8QN9ANuvs3dlQ3trvgD90Ly1S+Q1dFFsf6AfPxKGyXUpsTX?=
 =?us-ascii?Q?wHaBN8fN8A2s6uKS1wlTR5GMvIVpTSCXWUyT07ZUN4mMx7iMhW7fvdehguDe?=
 =?us-ascii?Q?rDUGFcmgxJBg163VFYv+UEEccW0eqotL4zjlw1tMz8P5WV+CPSJ970UE2Tcz?=
 =?us-ascii?Q?LCLM/jqM7a7zWKaaaArspwhW+0VDA2zdtxa1r+f91oHGMEUJEAa311XP7kag?=
 =?us-ascii?Q?fU7h91Mm0dyYFRHD7piLQ+q0G4P6/rS7D/qzL1N4zg2yrq/IMOdzAgq3iX/j?=
 =?us-ascii?Q?3KKrAJJXETEUlNwddB7PqcCPrFSu1yXPxmunkrnaUpU/yC1KPlnVBfscTls6?=
 =?us-ascii?Q?zXp9KO4MCrAx5e2+qw01ilhE8QDxaqXyrGBDPCRVZXVxCC0bxufS5LJ0eQPe?=
 =?us-ascii?Q?mWZxmCzntYezY0Pv1kdOvtWFp0AWqsSxcSve3/hajVER0tsviiCiZpDzwPCr?=
 =?us-ascii?Q?Bndum6tQ9vdDMi3X+Matgipd839P5a+Iexk4yUkjZVLy6GTHTw+fQp/0Tamf?=
 =?us-ascii?Q?A6GmD4e/Bg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1005c10-c3c0-499b-6162-08df07661cef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:45:26.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvG5RXxK7DyFF/mqk+mE1m9xah9rhaO13anFm3dz/A141u0SVFWhXyTnFSXe6mg6rmd1tLICxd/yX3tTsl9rAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

Without proxy execution, the DSQ lock and holding_cpu handshake ensure
that a task cannot be dequeued or start running during an rq-lock
handoff without clearing holding_cpu.

Proxy execution is an exception: a task can start physically executing
as a lock owner while its scheduling context remains on a DSQ; its
on-CPU or migration-disabled state can therefore change without clearing
holding_cpu.

Recheck these states after acquiring the source rq lock. If the transfer
can no longer proceed, park the task on the source rq's reject DSQ and
reenqueue it through its owning scheduler. This preserves the BPF
scheduler's placement policy and keeps descendant tasks within their
sub-scheduler's cap grants.

Queue a deferred drain for every rejection. If a drain finds a
proxy-rejected task still running or donating, leave it parked and record
a retry request on the rq. scx_proxy_resolved() consumes the request and
schedules another drain when proxy state changes.

Without this change and proxy execution enabled, stress-ng --pipeherd
can trigger this race and migrate an active execution context, leading
to sleeping-while-atomic warnings and subsequent lockdep corruption.

This is a preparatory change to support proxy execution with sched_ext.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   2 +
 kernel/sched/ext/ext.c                        | 143 +++++++++++++++---
 kernel/sched/ext/internal.h                   |   8 +
 kernel/sched/ext/sub.c                        |   4 +-
 kernel/sched/sched.h                          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 6 files changed, 139 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 9912ad0c2d445..55c2665a6d37a 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -137,6 +137,7 @@ enum scx_ent_flags {
 	 * IMMED	reenqueued due to failed ENQ_IMMED
 	 * PREEMPTED	preempted while running
 	 * CAP		sub-sched cap miss, see p->scx.reenq_reason_*
+	 * PROXY	proxy state prevented a remote DSQ transfer
 	 */
 	SCX_TASK_REENQ_REASON_SHIFT = 12,
 	SCX_TASK_REENQ_REASON_BITS = 3,
@@ -147,6 +148,7 @@ enum scx_ent_flags {
 	SCX_TASK_REENQ_IMMED	= 2 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_PREEMPTED = 3 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_CAP	= 4 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_PROXY	= 5 << SCX_TASK_REENQ_REASON_SHIFT,
 
 	/* iteration cursor, not a task */
 	SCX_TASK_CURSOR		= 1 << 31,
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2c5ae2811c77e..94d2e1507c54c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1084,8 +1084,17 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+/*
+ * Retry proxy-rejected tasks which couldn't be reenqueued by an earlier drain.
+ */
 void scx_proxy_resolved(struct rq *rq)
 {
+	lockdep_assert_rq_held(rq);
+
+	if (rq->scx.flags & SCX_RQ_PROXY_RETRY) {
+		rq->scx.flags &= ~SCX_RQ_PROXY_RETRY;
+		schedule_deferred_locked(rq);
+	}
 }
 
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
@@ -1531,8 +1540,10 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	call_task_dequeue(sch, rq, p, 0);
 
 	/*
-	 * Only local inserts get the wakeup treatment below. Rejects kick the
-	 * deferred reenq and rescue parks are paced by the rescue timer.
+	 * Only local inserts get the wakeup treatment below. Rejects kick a
+	 * deferred reenq and rescue parks are paced by the rescue timer. Proxy
+	 * rejects which aren't ready when drained request a later retry from
+	 * scx_proxy_resolved().
 	 */
 	if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
 		if (dsq->id == SCX_DSQ_REJECT)
@@ -2473,8 +2484,10 @@ static void move_remote_task_to_local_dsq(struct scx_sched *sch,
  * - The BPF scheduler is bypassed while the rq is offline and we can always say
  *   no to the BPF scheduler initiated migrations while offline.
  *
- * The caller must ensure that @p and @rq are on different CPUs.
- * If enforce == true, caller must hold @p's rq lock.
+ * The caller must ensure that @p and @rq are on different CPUs. If @enforce is
+ * true, report violations attributable to BPF-directed migrations. The caller
+ * must hold @p's rq lock to avoid reporting a transient race as a scheduler
+ * error.
  */
 static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 				      struct task_struct *p, struct rq *rq,
@@ -2482,11 +2495,6 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
-	/*
-	 * To prevent races with @p still running on its old CPU while switching
-	 * out, make sure we're holding @p's rq lock so as not to risk
-	 * erroneously killing the BPF scheduler.
-	 */
 	if (enforce)
 		lockdep_assert_rq_held(task_rq(p));
 
@@ -2533,6 +2541,64 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	return true;
 }
 
+/*
+ * Proxy execution can change @p's execution and migration-disabled state
+ * without touching its DSQ entry or clearing holding_cpu. Check those states
+ * with @p's rq locked. Without proxy execution, the holding_cpu handshake is
+ * sufficient and this must not affect the existing migration path.
+ *
+ * A BPF-directed transfer to a remote local DSQ performs a normal task
+ * migration and thus cannot move a migration-disabled task. In contrast,
+ * proxy_migrate_task() moves only a blocked donor's scheduling context towards
+ * the mutex owner and preserves its execution home in wake_cpu. The latter is
+ * therefore allowed even when the donor is migration-disabled.
+ */
+static bool task_proxy_running_or_donating(struct task_struct *p)
+{
+	struct rq *src_rq = task_rq(p);
+
+	lockdep_assert_rq_held(src_rq);
+
+	if (!sched_proxy_exec())
+		return false;
+
+	/* @p may be rq->curr under another task's scheduling context. */
+	if (task_on_cpu(src_rq, p))
+		return true;
+
+	/* Don't move an active scheduling context off its source rq. */
+	if (task_current_donor(src_rq, p))
+		return true;
+
+	return false;
+}
+
+static bool task_proxy_unsafe_to_move(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+
+	return task_proxy_running_or_donating(p) || is_migration_disabled(p);
+}
+
+/*
+ * Park a task whose remote transfer raced with proxy execution. Reenqueueing
+ * from the source rq makes the task's owning scheduler choose its placement
+ * again and preserves sub-scheduler containment.
+ */
+static void scx_proxy_reject_task(struct scx_sched *sch, struct rq *rq,
+				  struct task_struct *p, u64 enq_flags)
+{
+	lockdep_assert_rq_held(rq);
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
+
+	p->scx.holding_cpu = -1;
+	p->scx.flags |= SCX_TASK_REENQ_PROXY;
+	scx_divert_strip_flags(p, &enq_flags);
+
+	scx_dispatch_enqueue(sch, rq, &rq->scx.reject_dsq, p, 0, 0, enq_flags);
+}
+
 /**
  * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
  * @p: target task
@@ -2590,6 +2656,19 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
+		/*
+		 * Proxy execution may have changed @p's running or
+		 * migration-disabled state while switching rq locks without
+		 * clearing holding_cpu. Park it on the source rq and let its
+		 * owning scheduler choose its placement again.
+		 */
+		if (unlikely(task_proxy_unsafe_to_move(p))) {
+			p->scx.dsq = NULL;
+			scx_proxy_reject_task(sch, src_rq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+			switch_rq_lock(src_rq, this_rq);
+			return false;
+		}
+
 		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
@@ -2627,6 +2706,19 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
+		/*
+		 * Unlike the rq-lock handoff paths, @src_rq has been locked
+		 * throughout this operation. Only active proxy state can race the
+		 * move here; let the enforcing check below diagnose an ordinary
+		 * migration-disabled task.
+		 */
+		if (src_rq != dst_rq &&
+		    unlikely(task_proxy_running_or_donating(p))) {
+			dispatch_dequeue_locked(p, src_dsq);
+			raw_spin_unlock(&src_dsq->lock);
+			scx_proxy_reject_task(sch, src_rq, p, enq_flags);
+			return src_rq;
+		}
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(sch, task_cpu(p));
@@ -2783,6 +2875,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
 	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
 		bool fallback = false;
+
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
@@ -2792,6 +2885,9 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					     slice, vtime, enq_flags | SCX_ENQ_APPLY_SLICE);
+		} else if (unlikely(task_proxy_unsafe_to_move(p))) {
+			fallback = true;
+			scx_proxy_reject_task(sch, src_rq, p, enq_flags);
 		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			p->scx.holding_cpu = -1;
 			fallback = true;
@@ -4676,13 +4772,13 @@ static void process_deferred_reenq_users(struct rq *rq)
 }
 
 /*
- * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
- * scheduler chooses placement again.
+ * Drain ready tasks from @rq->scx.reject_dsq and reenqueue them so that their
+ * owning BPF schedulers choose placement again. Proxy-active tasks remain
+ * parked and rearm the retry notification for a later proxy resolution.
  *
  * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
  * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
- * scheduler. The private list below prevents a task from being revisited in
- * the same round.
+ * scheduler.
  */
 static void scx_reenq_reject(struct rq *rq)
 {
@@ -4695,13 +4791,26 @@ static void scx_reenq_reject(struct rq *rq)
 		return;
 
 	/*
-	 * Move tasks to a private list so a task re-rejected by
+	 * Move ready tasks to a private list so a task re-rejected by
 	 * scx_do_enqueue_task() below isn't revisited this round.
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
-		/* migration_pending tasks should have bypassed to local DSQ */
-		WARN_ON_ONCE(p->migration_pending);
-		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_REENQ_REASON_MASK));
+		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
+
+		WARN_ON_ONCE(!reason);
+
+		if (sched_proxy_exec() && reason == SCX_TASK_REENQ_PROXY) {
+			/* Affinity machinery will dequeue and reactivate @p. */
+			if (p->migration_pending)
+				continue;
+
+			if (task_on_cpu(rq, p) || task_current_donor(rq, p)) {
+				rq->scx.flags |= SCX_RQ_PROXY_RETRY;
+				continue;
+			}
+		} else {
+			WARN_ON_ONCE(p->migration_pending);
+		}
 
 		scx_dispatch_dequeue(rq, p);
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 0d7efbee2862c..5a1f6875e3d7d 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1747,6 +1747,14 @@ enum scx_enq_flags {
 	SCX_ENQ_SLICE_DFL	= 1LLU << 62,	/* carried slice is a default refill */
 };
 
+/* Strip priority and carried slice state when diverting from a local DSQ. */
+static inline void scx_divert_strip_flags(struct task_struct *p, u64 *enq_flags)
+{
+	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
+			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
+	p->scx.flags &= ~SCX_TASK_IMMED;
+}
+
 enum scx_deq_flags {
 	/* expose select DEQUEUE_* flags as enums */
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 40a79028de8e6..7b61e3a3a11e8 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -735,9 +735,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * or HEAD - a diversion has no priority and IMMED is not allowed on
 	 * non-local DSQs. Strip the enq and task flags along with the slice.
 	 */
-	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
-			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
-	p->scx.flags &= ~SCX_TASK_IMMED;
+	scx_divert_strip_flags(p, enq_flags);
 
 	/* the enqueuer opted for rescue instead of rejection and reenqueue */
 	if ((*enq_flags & SCX_ENQ_RESCUE) && likely(scx_rescue_bw_1024)) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 43f04989557b5..8361a38c3c263 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -791,6 +791,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
 	SCX_RQ_SUB_IDLE_RENOTIFY	= 1 << 7, /* sub-scheds are owed update_idle() */
 	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
+	SCX_RQ_PROXY_RETRY	= 1 << 9, /* proxy-rejected tasks need retry */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_DISPATCH	= 1 << 17,
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index cccc0c3987b85..b1351f346e1d9 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -119,6 +119,7 @@
 #define HAVE_SCX_TASK_REENQ_IMMED
 #define HAVE_SCX_TASK_REENQ_PREEMPTED
 #define HAVE_SCX_TASK_REENQ_CAP
+#define HAVE_SCX_TASK_REENQ_PROXY
 #define HAVE_SCX_TASK_CURSOR
 #define HAVE_SCX_ECODE_RSN_HOTPLUG
 #define HAVE_SCX_ECODE_RSN_CGROUP_OFFLINE
-- 
2.55.0

