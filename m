Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403493624AA
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024968; cv=fail; b=XdyZWwT7PK0h/+Md7AXTqFiFJTAEkGuzXIsmkWsiu0pNreHjlQWnI9/CduN7panHX2Ib9pvK2XMDeMJyJMFzbGLFandi+DRM3n1RSMiR5Icn4SZpzOcfNVxWejA+gdStQ67YM1fK8Y4N2cwsRH1ONs13nlyXRRGSPkfD3N0Jbas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024968; c=relaxed/simple;
	bh=uobvIAY+Tw4s6gqy8icB3M74Rt0lnqPSizHXqYPpjDY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HwMHfwucDvuJxnRoUPN8iOw4mVb1Y38HDzqM2159QM/XuswdBWT8n/OTqDpMRJfiq+JCLwtNvva6seRyzj9rsF6IBZEcN2kSzjzsNY09q0dJrG7i/Wa/JXxnLabDhWai8EWuT2k5mI5BtlL4BpCJs2n2eAiAiCQMEVlntBo4zYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MnLQj0WD; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MnLQj0WD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+9tNXoEu0KtTc+uLjdsV6DvJtozNKJ5mv0iFyxXWmI4wbT3gTkR+iK4lcZIrvCgHBISmyCcUbA6ot9lQNKcHB0qqxjn0m57Rp8nz4Ze2Nvy43E3wRl2mO+xs+JUMKwAp6QI9pTJdHpTjQs3fihLusWw0NW0AAToDfGQe00U9xF8CKcMBHzCuahjKV3A+xzf1JLGVGpFcz3NcXCl2Wj1DhJ2Wtb1QDp92gHPfZnp9eMwDXukL0krTdd0jx3XOrGly3vTHpTGcfNhO7BhnmVLXc1UxsAXwInUgGI5DkkHVoEdlV+K4sDH4yX+RlNt8+2dg01dSKV5DnNAQ6EFPHju4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+Hd4zOa/gqFm5bsd9sG/nXkqld7L1OlaWhwtqlzgg0=;
 b=UFDd5P0tLoB0jKm8vR0v1dAka0YtBZy4tGWDfsN6Ol6zMcxh1r02UAXqsoFu4MzjJUh9RCSocu/W6/CAT9IOUv+CcT4xrKOjww5AWOPrbyaVKr7IAVqhGKlwbOXxi3NJXJg0Y3CI1X/szT0BHjI2NkNWW3CmYYUm8HGXzDNnwVR2B2esUh6z7NO9LCZEtqCBBzIb9r//wZZm7br9B2TRfBDY70t4TQHPuGWdX0PK93Z+djj5lys/Pzv54GInfYZTCutdMxKfgC25MlW+yYuy8airly1ApdbZ4AhPIJmXmzjwBOq06FZCDDRGRtP2xKRUBIkbVylTOax4P9yUQQwLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+Hd4zOa/gqFm5bsd9sG/nXkqld7L1OlaWhwtqlzgg0=;
 b=MnLQj0WDL7E+63q/RUjj0ZxxEg/iVevr87s9kCakmuhlilJL407Xyc/c8G1PWXQZVBLNlxy+DL4HR71+oESpecFqebEjqiyNohB4QpyJSRYTDrfB/UKzNt9Q6RIvqlmLyFDCw73hxGwitDofaHFeo/wjIMnvBBEEXbgKMWD+0SiOOHaBLReeqTCxDDmBtStzTD1ZbY2Stmvlk1nIyvZ4H5nvCktzwD/eqrne/uoPls510AMizKQ6Nv1P9x6klW84mC5bSf87tAMhDPFsX7LvDsExLn/1kKgvvnwwSKm77BxVC5QqJ6iPbeFZ4wmjW9/gn+6Fr/BiB/xsZi0U7cGe9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Fri, 24 Apr
 2026 10:02:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:02:34 +0000
From: Richard Cheng <icheng@nvidia.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yphbchou0911@gmail.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	jserv@ccns.ncku.edu.tw,
	chia7712@gmail.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2] sched_ext: sync disable_irq_work in bpf_scx_unreg()
Date: Fri, 24 Apr 2026 18:02:21 +0800
Message-ID: <20260424100221.32407-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 058e4716-813e-4b05-4c61-08dea1e89b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6jzY80i2RIg2lv9Zqwx4n5rkRTpUOkb/R96XHz/zmxV+o/+t/nV3K6dyDvmwl8Oh1fL5s4kLc/OscPVhwzjqILM7tg6SSHMfzP0GTemjn1oZKfdY/GwxICmmrHeiX/nUhOrhv73jbA3H4k0obKk5MrIAPIq+C/R29EaiPCxb9GM57GEUY8VBKXmRXq2Dexd0HYlmHkchjkL4lyxEiQ8r6mI1HiEaJxUC0xdJzqu1ZcJMUqiOdosvaRbnOnUKCi58pA7WpJMA4Yf9JDQtVNmKPJP0dZeRuTE67KTtYaHcRbDSVYBWpXa5z+XeXB0jtyHxKOIDC54JgKPJHVByXawJ0taxwtt7+NZvKLUJlcmpnCK/A5dB8zHe/8px35zsWLPuCESstcTxoRH7BNy2S4S+XnN4Kwb8PAqSUAhwYt2PKBQmC2aQZiAZiRnEkGKpdRPnF9nGdTh/ap/bx6xN2W9lRvBfmMsM/Dpdub6j/hy9GTiSMAdYeztkbATW13XlsJb1aVg9StKsB7Mha4ymsmmHP2h1H6B5dyByZTgICkcpZel8Enw6yK+NSktjP8uuky5OdF3ThHLTOPIqccqTN7Y1LEHlbLvsZ55BmhXwGp29X+Kjv7V8flwCTSMmx1EIiPdrXI/J1/sxQJcWUMXDUYfDIZK7RwvYGk1Q+S/ldZeLIO8QqdZJwyloep/jbyQRZQ7L31+d6vceECey/3Xst9aBzSF56scFh0ntRUT3fkrOy2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlW3XNMZmlvWO7nHn/nUbATcErr5vx8UCnkzbhkktFXwJrxO0rWpsbUKL2HJ?=
 =?us-ascii?Q?LZyW6iG/y0W8UmWaB0ovexPFfhTJF/oMp6L3MuayMEgX3fEkncPyHmWwcvsW?=
 =?us-ascii?Q?HGoFGxrEtHjP0eo/ujNr13UPD4lgEyDeDO0FNYMswcHLhwPH3R505aPpoMqH?=
 =?us-ascii?Q?8qYAs1wDRnU/Dj+WpyGiC9rM2yCzuLF0THB5Z6v43XctjT9c6LH0gylX0Gcm?=
 =?us-ascii?Q?cOgEyBn6sIigjLSwDTjZ4gbfvHUD0Ntw7VpGJPQ/j4tm2QGS2yVmXFHr8vQa?=
 =?us-ascii?Q?GtseyU83doiE1pVg3Dfvge4ldldoX0IAHJcKkDi/qfwn54J4RdyWoB3qSBwL?=
 =?us-ascii?Q?HbNjPDslgGBcfoz/FFWoDY4rIjo2LpDSNvm5zF2ZOeDrNcNzxW1dui1zPanX?=
 =?us-ascii?Q?winb/eSfLqwSMkpRZfZBMm2NnorRnfVr89OaIfgGaIZxxn9AxJMmrxY1IH0k?=
 =?us-ascii?Q?hfvJFia9D72iVjs8dghf9Y7tT5vdAvMm0MNP36oJvRNex4IEajR+RQZvn5AH?=
 =?us-ascii?Q?sP5Cqp5UqLFFNgpGlWSlEkiR25f/hK551hUVVNXsbjhpzByzyZamTv1szPla?=
 =?us-ascii?Q?IVHwmKTWMzeDUxrzxuyH4cdnYTuJLaCvSBCyomggcmfUqaPdr89N9rzZGPDY?=
 =?us-ascii?Q?tYt9JQWcAujh+3pNxSpaU7Gs53sEhVE6XgAxjrBBqna2Loq52LmjfKSm/ZnT?=
 =?us-ascii?Q?KrTH4im3+TRw4xjuvoaTTIB1UaG+P8iCJIGu/k0TssFnAI41UAXh7GeN34Hn?=
 =?us-ascii?Q?JY+A1uqKCmBhHhm2t4nNGSzkHKYiZD7A7Ugio0Wgn7maA7BbtNx9sdmvF9J0?=
 =?us-ascii?Q?9hP9+IAy3H4l/vn1Dced/+y+M/8oWL5tP+c3BlLfMp4jBtgqXleqtt2X1Fis?=
 =?us-ascii?Q?vpwbXKXY0Edqwo//7MxARrjSuz9MaTI0ntxcBDfMfIjZinY4wOI9loRLAkBm?=
 =?us-ascii?Q?6ezfZprxVLweFyc8/Q5qZJnJa22OxcvM6TS9s2RA2EqvE9B31ogOoG7O1NvG?=
 =?us-ascii?Q?YvXiAaCIB8Vz4tXJ+PbPjis35XsE9bL28DJxycUHsmQOjpZONDo+vmfgs3I7?=
 =?us-ascii?Q?6auK+3kvQeQMRCD4ugtYwQzbaseYiJfAkFuAo/yHk1GobGnsC1Pr/V8bkPHk?=
 =?us-ascii?Q?/k5cul15Eb90Mt40tuqpxs3ZFGxIFApclZD71RYwMB1XxpmeUJlYV+B+iSKp?=
 =?us-ascii?Q?yUsCuhqVdnlqZXyUi0ZRcteeQr+IMgfV5UD1P+91mx3v5/DGcV9HQKrPYcHb?=
 =?us-ascii?Q?/1bDOEwVGSyUe2/9doy5fpm2LnvWGDLAtm//bNfo44OblNvKlItTbTEsEGIc?=
 =?us-ascii?Q?V3NaQSrxFLe7j2ALkwz+TvT2s+DzbAPW6omjtDcnNcJg45J4dCikY5pg3m7B?=
 =?us-ascii?Q?5JpA9iizHUmfEdvTesLLeXeUl3ywfS4vY5H129MlaKT2wK7tnckzQyemgs5t?=
 =?us-ascii?Q?+0lVUsH3UTYCcn1453U3F6WGOkJqD4wj8AG6Rk1NE2r/xN4zkPwWqGLTPZ9J?=
 =?us-ascii?Q?ZGoB2ewC5nwbDUwtCN/0y0re0rrBYaLl8lQ86kUfxUi17D7WNIzGBC6Zgzqd?=
 =?us-ascii?Q?8HW4Qmk2yxQVtNDtBUaNfx0ffIOXvH5LeZPsflJRQ4dGtifwjH6l0oXkexlQ?=
 =?us-ascii?Q?+OTvxyDHAPG6HDc21S8+P/FpcSBc9nHTY3mZXNblO0ABasLr31kvDVxekL9L?=
 =?us-ascii?Q?+KIbnxmDwk9InsMyDfnQxYMkkcLTM2YS5pweNu8r+fqvioUw5Vu8DFpKTPmu?=
 =?us-ascii?Q?rXT4DOqmWw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058e4716-813e-4b05-4c61-08dea1e89b2a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:02:34.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yq5HH/iFl89rk3Wci5WiGP369mqCH/HBcfRNwtE8KWrtO1xgrOxnwHYdWy+npHuGt6H5AY9WHyDnxWSmH5JjdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531

When unregistered my self-written scx scheduler, the following panic
occurs.

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

Add a helper scx_flush_disable_work() so the future use cases that want
to flush disable_work can use it.
Also amend the call for scx_root_enable_workfn() and
scx_sub_enable_workfn() which have similar pattern in the error path.

Fixes: f4a6c506d118 ("sched_ext: Always bounce scx_disable() through irq_work")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changelog:

v1 -> v2:
- Add scx_flush_disable_work() helper
- Amend error path in scx_root_enable_workfn() and
  scx_sub_enable_workfn()

Best regards,
Richard Cheng.
---
 kernel/sched/ext.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 012ca8bd70fb..ff42ac197bfd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5921,6 +5921,20 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
 		irq_work_queue(&sch->disable_irq_work);
 }
 
+/**
+ * scx_flush_disable_work - flush the disable work and wait for it to finish
+ * @sch: the scheduler
+ *
+ * sch->disable_work might still not queued, causing kthread_flush_work()
+ * as a noop. Syncing the irq_work first is required to guarantee the
+ * kthread work has been queued before waiting for it.
+ */
+static void scx_flush_disable_work(struct scx_sched *sch)
+{
+	irq_work_sync(&sch->disable_irq_work);
+	kthread_flush_work(&sch->disable_work);
+}
+
 static void dump_newline(struct seq_buf *s)
 {
 	trace_sched_ext_dump("");
@@ -6821,7 +6835,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	 * completion. sch's base reference will be put by bpf_scx_unreg().
 	 */
 	scx_error(sch, "scx_root_enable() failed (%d)", ret);
-	kthread_flush_work(&sch->disable_work);
+	scx_flush_disable_work(sch);
 	cmd->ret = 0;
 }
 
@@ -7088,7 +7102,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
 	mutex_unlock(&scx_enable_mutex);
-	kthread_flush_work(&sch->disable_work);
+	scx_flush_disable_work(sch);
 	cmd->ret = 0;
 }
 
@@ -7349,7 +7363,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct scx_sched *sch = rcu_dereference_protected(ops->priv, true);
 
 	scx_disable(sch, SCX_EXIT_UNREG);
-	kthread_flush_work(&sch->disable_work);
+	scx_flush_disable_work(sch);
 	RCU_INIT_POINTER(ops->priv, NULL);
 	kobject_put(&sch->kobj);
 }
-- 
2.43.0

