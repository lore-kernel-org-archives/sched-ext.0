Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87734A23
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852598; cv=fail; b=Ac4Cqv2YkgVAjacUbLZnNwfY2p5KBrIPNcj4wFrwXMamp8Oh9rDukgwMCdHyt6hwuGWJcqEgyQ74JKIvODfjtoRMUdpckJPs+bBixA/9Bcgb4hDVo7U4EE3BNYxnGQbCuf2Xtyw8LqJ4Pd3gtMAOGvZ/ZcranqPL2vIhOoVqLi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852598; c=relaxed/simple;
	bh=WRPSFIzC1n1MWEHkbYnZ+05IqN9d2wOj53UJQBV2vx0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W67epmlB9Zh/dg1zACLwxBUGGyvl22qjoaRHHQUIJArIV+b8C8kLwsCP91iNcx4y7jVz7zl05XWv7Ng1tdWXNlwkInQYJv1TK+XAhY0by0iokOsiox9U7iADyn0t8Ewx+fXNiunjJ2lDidY7vLPxyFTdH+iC7BPILzmluZUc6zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k1EV9/n+; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k1EV9/n+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMzN5OFj1/NPoL9GY835SGD07rU+qMHWNkjsAxG6HNCg5cTSEwKUVFEJaXE2v6NpJvctIOMNF+OI+oqMeH2n6og1HANJj9MOpN/kCpbreZC7/L+Ula899iPvD8R2zOL49eRofu3vgtC+iEopjt/i+BHrH2j6ROfpPqgJ6ynXBcBJ+0ahpl/f5YJjlZMz3g3I/SG2P6vizKf4Jg7EfCSzwcw5XsM6h30/qeQfg4Au0x/CFj9yP6zyIcv6yVjxLkAUA2VefLdPbidroxFWAz3TRL00/BaF+onGxPckxn+1uihqEIirqDJAZmC9+zE+bjSueVipi8aYJ7ykKsugmYs9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzqQxBryPwdWPZrw8GLRMi2FaIEI5qzOSeDNBoe27ss=;
 b=LxlRFUb0J8VkVfZ509+pgXsi9Cj/3BdBjGwaB1XK9jNItb4Pz+WRJxPh3jmYxbWru7oFxs2lHU1Fr9oqNV7OC5KudlfZmA3z0R/cj0GWTnaBhctFW2Y6raRaa0HZLGcg1Wg5u0Jj1uViNPJFjpJrpuQe3fGYmyE6veVmqtu/CtlQloppW+0XRjdR+F6SyjqV81hDypFCf6cFdLXkpWzhorUotQk29lUVARs6i6xCZQ2wxyjRUCfb8urrBzwlqngqkjEbrGplgP15Ea51mo9ORnEPQoM8JogeG2++vnpIvZ5ygCk4Os3rQsk+DxjT4dDRnoxfOHXyABAD/SQKfv5GUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzqQxBryPwdWPZrw8GLRMi2FaIEI5qzOSeDNBoe27ss=;
 b=k1EV9/n+seoBmOoPPnrzZI3nVjaOc1hSXBQsh2/yiOeZOef/GwEKfINOcdiEJHn/MH9KVZXi3mh/3gi9fA5v9bqa6SZdHvl8O651FqIWaDensRDXxLPgRWRZFP7mnPNN8R3+9NbqEry8B3hfcLPPCQU85hmOcSYsISmCdsg+gY6KmOxY15Qz9W3elM7bE9zBNUigMBb0z8UgTw+lTbMC6P4X9cNOWaCx9nmpPRzl1s8h9Bp8QV+Y8rbVCeEjoModSqWEeYEFflcmWvOlKDmItAf3MXiUBeQkIkQG+AksahF6x15XdCamrnugxCorvDWOUGvl4SgsnXtq8rzesPn0FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 10:09:48 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%3]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 10:09:48 +0000
From: Richard Cheng <icheng@nvidia.com>
To: arighi@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] sched_ext: sync disable_irq_work in bpf_scx_unreg()
Date: Wed, 22 Apr 2026 18:09:38 +0800
Message-ID: <20260422100938.35781-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b13acec-a8a6-4b43-dabb-08dea05748d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OEAuDdxgNLHvY1vsxgs48u38AA8jKffBF9O2sGV5xUSjTHAV2r7u5g9UcUyp4vb5Hue0j58eCRCF9tVf0Ix+v5khFqxhaf48xaFKst912Du7VI6wESjnbpdW2GNYg888TZENughAJd/aEiexl52eb/20WcQEDtPKXGByIUrXfhy8ums5j4wOaLV3N8uQ5CC1XBiEF8GCJVRS4hekphBBFu3vB6wIgyKBNQtS48OxIS5bQJlNUb/nXkKidTWZWifzAgjtPdfrmp8bsLJjVaQ7vYhXv+N2Ty+7SYGsRRV36nxzvGGpxXk9Pu1XL9+tF2GfreHQec28dfN4nzx8JeR0g0wldPYtBrjif5TUw1wxzDo3H6AhsMYL9N/sclCHKhZyKY3Gt4j8w4GIxxKT0Qkd2MCfBLVedYPsSbf5Gna0PTOOazA/Q7M3fdie8yXRhP0zKLdQNVwcoQ0ZcQN77/pZFb/dnXiYAwnrbN+249flxjTOtAkwuRJDKKstXbSqL5N5FRwcAYtVaiEEiO5cEM9t7UvukdJQCLEU2if0tl2vZ8fOBffJsnjuiUWFAzJyKNwRipJdWLpt0wAoESoTW+jPSimn+XKqwsW2/DDMZnt+RIJd+0zRBrWU0ARc9Eux0rLyWV9L7toHrov/9uINyOHbxL5V35JO8pqBRIDW84XcInyNju7VVoquFQPwMvGQ0Wp14Vg4vNgIepEpbTMX2+jW+/4/RNNJ5UHq30yvTE5YMxH5BAL8nm8NWLJ6Uq3a3XL8VXcdcM+XBdLo7EiZtplH6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?40xdjs0AMdjc4rZzy9A0IFqrj8eb50i+WJV0G7hC8FbLM/W+IajXzEtcNG6H?=
 =?us-ascii?Q?2y5IE+m14n019aUrz2ZeJOB0YnF2cNDIWSyhU/1ucoZxpjZB+Fe3HGqPGtv1?=
 =?us-ascii?Q?rCVLPsSy9X0g9oigLV/8w2m4GELab3F+fwlZgyJ8wY8fTsBAOLdeR9eShz61?=
 =?us-ascii?Q?XnbT7XF/aIPpQqNL6x1BgIYuk+cPa6/DWe2pygT0C+gLho4iQ2pabXicPOrh?=
 =?us-ascii?Q?YIbtFBQsmwVm8Q8sShSlxaz7qVgpPhQROVDY7yZ+UY9UIObe03uEP9vIaowK?=
 =?us-ascii?Q?gwByBuZ6v9agnPfPqQLbi5++pnpVCLkVW8rIFxRNfciqBbeygB2T7kOmaASS?=
 =?us-ascii?Q?pg56WmEjmLfG/w6kcgbDxvlSWLDOKWndUWVOVUpcWbG6IyIXCeRLYoFc5W2o?=
 =?us-ascii?Q?LRBO3NmHCPLbG+7Lr+ZKY2XFh3yfWoGEO0Nx9mnjuj8rxjyvqLN6Hr1PhpZE?=
 =?us-ascii?Q?AvUPmMNGgg3iJNcRYe3WHcMxvbpc45CUBXqX7EgxqGzXNwUy5CzskhYLPbnW?=
 =?us-ascii?Q?2gWNGRIeZrJEP2HP57HPB1js2kLo//UiPtK4VJ5rPmMGQiMBVYLCgf2IjYjD?=
 =?us-ascii?Q?PX6hVrIg2lfwyW35aw0MelbtF5+0PLICBH6HzwkbloX1B4CBsH4yIwR0wfkr?=
 =?us-ascii?Q?YQGBwxSQlG564hd3ZTbcu3nenJiHME8ethRnXvLAeyM8OCC+8qA8VuQ1Tt4W?=
 =?us-ascii?Q?lxbyHu57qZBor65E0gMH6nTs7OtmOW2EqWSdnA142aDDzyU5NnN1f93700zz?=
 =?us-ascii?Q?Wc/pihAGRGUyCuA4EpXQ8OsaLP4DTihXeQVfFTNssWdIpMtNQrBHNynOh1vy?=
 =?us-ascii?Q?uaTpMYKeJeYlb4SYqnXHVB94zgaaK33F80qBz4Czke1G7kjYmz8fd9F2pbFW?=
 =?us-ascii?Q?bfbl4t9ScrPE+4UrRrX4b8XUdxXUnb3Ki99zSR2nYflkeNQh5XSzpS8PfDTx?=
 =?us-ascii?Q?1h659GVdlir6K3OtBF2jR2EQFSraWrQo1Sq7c1VW/jy8TsmaUFfINOwPh111?=
 =?us-ascii?Q?3SvcGgTEWOS6s4RvO3rakSlvgiMrIbMVQwd447t0ypWK397lLhbNACEhrOgu?=
 =?us-ascii?Q?2bZP/dsgpB/rvr85vDthP9/fV1QK+FZpES9nvkEMNy2kYvU6Q8NbJqMa/0FH?=
 =?us-ascii?Q?9jz4i9AyszUs63bEUpA5+Nb9t4OHE/Fub0Ak4eEjd2stlfR9w4nDoN8mDp1k?=
 =?us-ascii?Q?hndL7T0qGjhVhHHcUMwf3529vAhgy3+wwagZuPfax4PBdC9DqPddlJdfshpV?=
 =?us-ascii?Q?T8dAs+6Jmv9vIHzOhc8EtvcEcj4gzVlawfrawIlY7ktyeFIRcxS+O223HbnM?=
 =?us-ascii?Q?WgzHNvc17kk03pIMDDXH2kPjQ9DbhqZnIUdkMaVbzQ97hnTgDVvAN4SFZK8c?=
 =?us-ascii?Q?sOx1mxBXtrQ5r2FzPDb0sP6k/rlvNqoOfDSCvWAt7YtC3lM0cZ+gncCu77Mh?=
 =?us-ascii?Q?jkLJpbDN7A49CtUyH72u7tJzBuNxV7X7Y4ulqPdQ7V3uwMUxyEanWCd8h8D1?=
 =?us-ascii?Q?MLCCMzRxciD7w+TH/42OhzS0NeOqIjeFi5dQuUozW1/mdGzaVcFgsrkDXJn1?=
 =?us-ascii?Q?Wrbo4PymcnZOy0MVyS4IwTnpYiJ1pbZY8Rk/drNoi3yxofbqWHcF5aPyp2Du?=
 =?us-ascii?Q?ZtC1kxYjdydQdwrdlIqVEusD9eN3H1wIMOkF0UieJmsxEQgMwYOXvh5zD6Tw?=
 =?us-ascii?Q?v5CfAuFWn3r49nOqoELlI9Q4Te+wbaQlyUSYtYZkPAhnqPIN6bjnrEOhty+e?=
 =?us-ascii?Q?ES6Hr6fKwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b13acec-a8a6-4b43-dabb-08dea05748d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:09:48.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNHxtsFxfPam3edqcrS9INQYRN0Wf0nBKIeC1ZI3seTNR121+yiyLFnMU0Q/rxPEIxHDnrYFeN2G9knk0H1fMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200

When unregistered my self-written scx scheduler, the following panic
occurs [1].

The root cause is that the JIT page backing ops->quiescent() is freed
before all callers of that function have stopped.

The expected ordering during teardown is:
    bitmap_zero(sch->has_op) + synchronize_rcu()
        -> guarantees no CPU will ever call sch->ops.* again
    -> only THEN free the BPF struct_ops JIT page

bpf_scx_unreg() is supposed to enforce the order, but after
commit f4a6c506d118 ("sched_ext: Always bounce scx_disable() through
irq_work"), disable_work is no longer queued directly, causing
kthread_flush_work() to be a noop. Thus, the caller drops the struct_ops
map too early and poisoned with AARCH64_BREAK_FAULT before
disable_workfn ever execute.

So the subsequent dequeue_task() still sees SCX_HAS_OP(sch, quiescent)
as true and calls ops.quiescent, which hit on the poisoned page and BRK
panic.

Fix it by syncing disable_irq_work first, so disable_work is guaranteed
to be queued before waiting for it.

Fixes: f4a6c506d118 ("sched_ext: Always bounce scx_disable() through irq_work")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
[1]:
[  188.572805] sched_ext: BPF scheduler "invariant_0.1.0_aarch64_unknown_linux_gnu_debug" enabled
[  229.923133] Kernel text patching generated an invalid instruction at 0xffff80009bc2c1f8!
[  229.923146] Internal error: Oops - BRK: 00000000f2000100 [#1]  SMP
[  230.077871] CPU: 48 UID: 0 PID: 1760 Comm: kworker/u583:7 Not tainted 7.0.0+ #3 PREEMPT(full)
[  230.086677] Hardware name: NVIDIA GB200 NVL/P3809-BMC, BIOS 02.05.12 20251107
[  230.093972] Workqueue: events_unbound bpf_map_free_deferred
[  230.099675] Sched_ext: invariant_0.1.0_aarch64_unknown_linux_gnu_debug (disabling), task: runnable_at=-174ms
[  230.116843] pc : 0xffff80009bc2c1f8
[  230.120406] lr : dequeue_task_scx+0x270/0x2d0
[  230.217749] Call trace:
[  230.228515]  0xffff80009bc2c1f8 (P)
[  230.232077]  dequeue_task+0x84/0x188
[  230.235728]  sched_change_begin+0x1dc/0x250
[  230.240000]  __set_cpus_allowed_ptr_locked+0x17c/0x240
[  230.245250]  __set_cpus_allowed_ptr+0x74/0xf0
[  230.249701]  ___migrate_enable+0x4c/0xa0
[  230.253707]  bpf_map_free_deferred+0x1a4/0x1b0
[  230.258246]  process_one_work+0x184/0x540
[  230.262342]  worker_thread+0x19c/0x348
[  230.266170]  kthread+0x13c/0x150
[  230.269465]  ret_from_fork+0x10/0x20
[  230.281393] Code: d4202000 d4202000 d4202000 d4202000 (d4202000)
[  230.287621] ---[ end trace 0000000000000000 ]---
[  231.160046] Kernel panic - not syncing: Oops - BRK: Fatal exception in interrupt

Best regards,
Richard Cheng.
---
 kernel/sched/ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 012ca8bd70fb..065660382a0c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7349,6 +7349,12 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct scx_sched *sch = rcu_dereference_protected(ops->priv, true);
 
 	scx_disable(sch, SCX_EXIT_UNREG);
+	/*
+	 * sch->disable_work might still not queued, causing kthread_flush_work()
+	 * as a noop. Syncing the irq_work first is required to guarantee the
+	 * kthread work has been queued before waiting for it.
+	 */
+	irq_work_sync(&sch->disable_irq_work);
 	kthread_flush_work(&sch->disable_work);
 	RCU_INIT_POINTER(ops->priv, NULL);
 	kobject_put(&sch->kobj);
-- 
2.43.0

