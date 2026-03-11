Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98E39936B
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270898; cv=fail; b=myG1M34KyJSTXwzdsRk/KItPKKE5apmr56VwZMwY7jvHIbPpzGTOcdQ6/HG0zNUV3jXwU5FVU/mEIYlJfBD7wUL/9zNZ7Y7mmJXSe+6rexq0fWu8SCtE1rsi6ETegOidatYgrd4QIWdEBBF3Az9ytDyyEFSPOV12xPi2ABSsJus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270898; c=relaxed/simple;
	bh=4PcryZ2BJO3SBeYicgCDfyHanfIR+tCuHMWn/csu4rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZowJ+dTXhPaEHlwAjU2piVL5DDezOsYuGKS44kv40hk7d5Tedtl7+TTvpPzOjmQoIghTtA6qjoUk2pVEmR9kSRAIPoyUsWsTv2yiOxvrUPHECkKuh1hkHzHtYeGQk52p1NPnYvJsYMaRC9w/UBaewo6/2+HDa9TEAKluDeoYKfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dbKAPmym; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dbKAPmym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYS0ZPzrRAOxmYwha47XVneDinsMc9SFoGtltagSYqRTl0/rKy3XFX8U5wiYzL6IinJJJx1CtxVpmLnnLQdlNXY640BMKlRksczmp2yuIpDYkVgKSsI8UyjXYaFpOnwl6KTR1+RCmiDSno/sKVO5kYewPWUtItYRcQQF0MGbtB7+XqgZKe40qsFQ0+g+eZY+iS6uAbg51IK1JFV1KxZNYpm7Mf3bzrbMCN8pgwmMbBqYUZX3fEY9+ZOkEuRqynKt2iUXXOiaALz6RrLGz+tmCe2v5csYmMLBiB1ngdNak1wbi6JJ97zGnXJH/5p3PlQRbfH1ChZDwvkP0wkoxlakLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7iKo0ZI6hYgyGjuXOlHh/AUoaApUis+qsvq+IlKdm8=;
 b=OTfYcSr4chZ7czIzc3vkL6hTdnKPkAhCBvpGYuH9EBDlEyyLsfQOcLGzdO4GX5NKe+aip29K3wtN3euvJwwOmN3z7JTcAqDrHra0ilip1rZlrXDpjnDWqbDCvca456r2/LlyPF4xyYX+yeYoQ/Y7bOfA6Y+7wFBAIbvbGcOycCQrogXKSagwCAU65DH9csiugyuwyjC5qhNbnZdLNuY9/XsL/2LtJW8m0HSvWMsyRCDkKPTXFdd/HmG7oHdhSFCm3rEDoQuPyhThbuhB5CxpSkpUREM5jDzBoG/CQ9nfKKF6UFjaTwH0tw+9g0viYDeciQMWYhF1f7CLipOdOe+C7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7iKo0ZI6hYgyGjuXOlHh/AUoaApUis+qsvq+IlKdm8=;
 b=dbKAPmymxQpGYiweCkHlmaakk45zXq/aWDFsNHNS9ceihfQZcEiQl5ngY8P9B4acx78nUy9vdFBCTva7iZIx//H2dq1wxL/de0BxCRBK19MfR37b2d0b/I7Ieqlb7XRJydOcJM41A0k0AUCjWJuQTMgDC1dw+8fyDRu5zBWc+DjdLmHqVGknOBXMyXkRqLv1JFkzR0W9QR1q5xVWCZmA5QBiXuw3C3nh5RSLTPDZTpH5Mmkn8Mgm1SmYfYhsQw9ExEdxTrRjpmRF2RQqJw0olpjiY29tJzCySz+B19p37dV3TPJwlbpoERvO6VlKnSsiMK4HyvBUlU+M+JoFli/OcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 23:14:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 11 Mar 2026
 23:14:50 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.0-fixes] sched_ext: Drop rq lock before calling ops.exit_task()
Date: Thu, 12 Mar 2026 00:14:41 +0100
Message-ID: <20260311231441.276689-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f32a21-d947-4d06-bd85-08de7fc3fedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sRe8RvtfwEMosif41lShi/Al0Bfhed9D5T/jZKwqR/QbPVxyWyZMThFb+fVVKbwkN85BPZN/5hy4HJumAoCH8h/cWiUTYerZZ+Oev5iFWxgEoF9z1w5m8BQhUrEfvKqhF5LsRY4LF9YvwXf8xjFVFqAonwFC3kKoOrHP4UrxmkfGGLrQTYnIYVCdXWR690SFbfsRYZFHU0l4U18tIk0hbO9JAXg944sFyKPErVI4xbPYe8UKxTgKDSCPXx6KZm6UngmF+R/g51P1Lwb6NeKuC/OA6bRqCZbl5deoRrAo3b5/4uh39uP5lcjBAko95ar0XcyRUjr7fiCG1gYko7/+VXEZaODC2RV83sExqXc61975c/cWKNJZzMg8ZT2ezJxG9qMDMQ3dVJ9qn6lOXBT7uB6yNiR5NyHRui0v8fObZoP/9zCZaVGKmlvya00nkVW0BHC/JpnL4oZeT1jMKM7jKWn/2qOStVx/Qh81KmrnKqQcfXgvW8f3aWhVPIl3aYGcAvnO2Jqazv/PDDr639vU0bdx9CUrtYVS/TJDVULJiNgNLtzLAoB9K6BiC8L8+rE9n3QUSOWVdozHDeIxG/Ar8zYe10E89rfDxsI0+33NM0h/D2bCaAdGvThZNA4Y0gHNjVV9YuXJIFfbM6fgFoApS0xD9sW2s9WcZ/dsrqt5cHmabFCRaCpWLSjiOMN8N4u4X73fcyv+VDzWDIfVgK/irN2q5dpArwtmyDRtzlFybQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzdTNhnupoGHWiSXsFkZi2X3kGrlaKuo7qaQcJsI+JYLc7xVGsmqHpvObsNM?=
 =?us-ascii?Q?d7whdgIsHG80Jh3kQx2P7fZDThRvrB0JHLPAIOX2/z4/CFICxS2mFXMLuP8m?=
 =?us-ascii?Q?k3LIXcu1FaSDc+ZQ5rD4CnjSCiH33fPZUaM+5pXU7fBG7sNc8/+M7guaGVf1?=
 =?us-ascii?Q?sP2VqHenr07Qr66uU3l1olmIxzPVhcAMI8K2GKmyiu/AHGv1VuNwvTt77KnS?=
 =?us-ascii?Q?umqutvXOSOrD+Vgc4HXRzIKSi9+t63mu8OLZmc62mZ198SzLWLM+2GqWDlCp?=
 =?us-ascii?Q?UFGXHzL4IFWQrWEDZ2sGdq495t+MciWFj7EPhmiDz7NGPmso7918SVK5iRP3?=
 =?us-ascii?Q?wvpRq3Xs953dCRshzVGfbBEL0WbHuWvdaKQiG9mArPaUwo/HN92u4w+OmEl4?=
 =?us-ascii?Q?owY6ZydIZ2g4UjquvBQNJoQqIPpHQcqwBl0dGe36m5rG9EnAQrvCYiHqtvJv?=
 =?us-ascii?Q?yB/Or2yNhCtAHafmZfj/cAFId1Vtn5hjAUEq0tdx7PjfYsmVxwwgAw9xDN8b?=
 =?us-ascii?Q?+kebCjg0jkZrfGC38n/05wzLXvbjMdU5gT+OqwgZH6O7gOd8okRwrQINh4yR?=
 =?us-ascii?Q?PGN+BIcJ05hTEWFuAthO1fd+nd2qD4xC54vB9/+qYOyF+VqnvCXm/sfqaFhI?=
 =?us-ascii?Q?AK87ih8WWhQTIGJ/5Rn3j3Gq3/l6/pRpGwiFnaIy6fJehzDHo/bX+rFAix8K?=
 =?us-ascii?Q?rYUSTWqJhVjbOaKynJ1p1gTPu2VpYca6zNtUfXnNyrHgjU81L9nVhWDa/MX5?=
 =?us-ascii?Q?PCnr2X3DFhQAREYMJ0oYeDum38tLxIQo0kOqD0sioM5lrUaqJGYZ2NS2tPt7?=
 =?us-ascii?Q?In8B5qfkvSVRRv4qKS3T2HLswIsOmWpxY3EU2Yp4ONH/Cl+4xhtuBF5PdSXL?=
 =?us-ascii?Q?zhEN9xaXIJy7QSQ+q4WNrb8loXEJImOJYa2//ykoUCfv2jIVZx8vU/RLKQ7L?=
 =?us-ascii?Q?5ZWhpSOBa7KeHQvgy/1Vjh+f0RObvetgBsZ9kLFCTCqFWi40fRtC5qW+dREi?=
 =?us-ascii?Q?eRyAMjvrzlcKl6whefVZ2bwITduqiRioZrA8J5JFSb3ZSX+0Gk0QxwdkHem5?=
 =?us-ascii?Q?+rxbt/dm1jWxdZ1Drx+YkaXhgurulAAEDIlcxKBJ8/Lj8iIpK1gzffutkxbP?=
 =?us-ascii?Q?85vUQfVau5S+DNs41+So24GfSi61ogCP45sU1UZpXRhyaVJtPQkwJTsg5fdE?=
 =?us-ascii?Q?P4mqfpZ8KJynu+0Arjj3Dc+V/D6GTTlijQ7sUf2ibv+LTxW0yp5+CT1mk0DX?=
 =?us-ascii?Q?FZLoKEA7reNbzsTMravQirkg2zZz4kMMsA/ctBPjn+lP66GnTlyRWP+Zgybn?=
 =?us-ascii?Q?VyJ1qf0kM0Gyun/XazdKOyTfkX96rmnGna1VAmFobgvQ5xUgQF+HwRbkWAjB?=
 =?us-ascii?Q?YD0Dh56Klv6xM859qLdPo6FZH/E4ZjUSDxiORLZn8uHsCBiFSagbRIR6AybV?=
 =?us-ascii?Q?N5yXziuBHSkm+//0RHLuZQZ52Y/Iwo34acZ6LXXYY37EBKcfNJG8JAlAuvCv?=
 =?us-ascii?Q?B4xTRhWF5p1eQQKVhiEOUqnmzAiNA3cPM/6Eh0y+g5IQH4wd5NNbl5XAfFQE?=
 =?us-ascii?Q?we0ujV9TX5wK6OSdZAf/wL39MUVsWrbRjE1gpxraO9XsbKGvYSUobJnbT1PA?=
 =?us-ascii?Q?SGFoEQhWmXhKGkaUV2zGY6WZXXqwnIuxXJvztl5Ukp9hrslj/cvR7K1W2Z44?=
 =?us-ascii?Q?8JxaNQslCJ0WQDrm8s6Qt+N8hHUu6EvOgKDQCCNnM0Nz+whxGoB2UMzyVG0R?=
 =?us-ascii?Q?28gGMalt5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f32a21-d947-4d06-bd85-08de7fc3fedb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 23:14:50.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VN94ygLvUmluYhHAcQ+MsqiLKyG1PmLKF/EWywVVhxzgOWJLKGpeUVos9eobS1lHTCQ7TpIcXy3CRLfYUD1FxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416

sched_ext_dead() calls scx_exit_task() while holding the rq lock, which
invokes ops.exit_task(). If the BPF program calls helpers that acquire
non-raw locks (e.g., bpf_task_storage_delete()), this can trigger the
following BUG:

 =============================
 [ BUG: Invalid wait context ]
 7.0.0-rc1-virtme #1 Not tainted
 -----------------------------
 (udev-worker)/115 is trying to lock:
 ffffffffa6970dd0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{3:3}, at: spin_lock_irqsave_ssp_contention+0x54/0x90
 other info that might help us debug this:
 context-{5:5}
 3 locks held by (udev-worker)/115:
  #0: ffff8e16c634ce58 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
  #1: ffff8e16fbdbdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
  #2: ffffffffa6971b60 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
 stack backtrace:
 ...
 Sched_ext: cosmos_1.0.7_g780e898fc_dirty_x64_unknown_linux_gnu (enabled+all), task: runnable_at=-2ms
 Call Trace:
  <TASK>
  __lock_acquire+0xf86/0x1de0
  lock_acquire+0xcf/0x310
  _raw_spin_lock_irqsave+0x39/0x60
  spin_lock_irqsave_ssp_contention+0x54/0x90
  srcu_gp_start_if_needed+0x2a7/0x490
  bpf_selem_unlink+0x24b/0x590
  bpf_task_storage_delete+0x3a/0x90
  bpf_prog_3b623b4be76cfb86_scx_pmu_task_fini+0x26/0x2a
  bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
  bpf__sched_ext_ops_exit_task+0x4b/0xa7

Fix this by extending scx_exit_task() to take optional rq and rq_flags
pointers. When they are provided, temporarily drop the rq lock before
invoking ops.exit_task() and re-acquire it afterwards. When they are
NULL, call ops.exit_task() with the rq lock held as before.

After dropping the rq lock around ops.exit_task(), interrupts are
enabled, so an interrupt can potentially run and call
enqueue_task_scx(), which uses SCX_KF_ENQUEUE; scx_kf_allow() would
treat this as invalid nesting because the interrupted context still has
SCX_KF_REST set (from ops.exit_task()). This nesting should be
legitimate when the inner call is from an interrupt handler, so skip the
nesting check when in_interrupt() is true.

Fixes: 7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1594987d637b0..37415713b7c0b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -275,9 +275,10 @@ static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
 static __always_inline void scx_kf_allow(u32 mask)
 {
 	/* nesting is allowed only in increasing scx_kf_mask order */
-	WARN_ONCE((mask | higher_bits(mask)) & current->scx.kf_mask,
-		  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x\n",
-		  current->scx.kf_mask, mask);
+	if (!in_interrupt())
+		WARN_ONCE((mask | higher_bits(mask)) & current->scx.kf_mask,
+			  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x\n",
+			  current->scx.kf_mask, mask);
 	current->scx.kf_mask |= mask;
 	barrier();
 }
@@ -2968,7 +2969,8 @@ static void scx_disable_task(struct task_struct *p)
 	scx_set_task_state(p, SCX_TASK_READY);
 }
 
-static void scx_exit_task(struct task_struct *p)
+static void scx_exit_task(struct task_struct *p, struct rq **rq,
+			 struct rq_flags *rf)
 {
 	struct scx_sched *sch = scx_root;
 	struct scx_exit_task_args args = {
@@ -2993,9 +2995,17 @@ static void scx_exit_task(struct task_struct *p)
 		return;
 	}
 
-	if (SCX_HAS_OP(sch, exit_task))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, task_rq(p),
-				 p, &args);
+	if (SCX_HAS_OP(sch, exit_task)) {
+		if (rq && rf) {
+			task_rq_unlock(*rq, p, rf);
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, NULL, p, &args);
+			*rq = task_rq_lock(p, rf);
+		} else {
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, task_rq(p),
+					 p, &args);
+		}
+	}
+
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
 
@@ -3068,7 +3078,7 @@ void scx_cancel_fork(struct task_struct *p)
 
 		rq = task_rq_lock(p, &rf);
 		WARN_ON_ONCE(scx_get_task_state(p) >= SCX_TASK_READY);
-		scx_exit_task(p);
+		scx_exit_task(p, &rq, &rf);
 		task_rq_unlock(rq, p, &rf);
 	}
 
@@ -3127,7 +3137,7 @@ void sched_ext_dead(struct task_struct *p)
 		struct rq *rq;
 
 		rq = task_rq_lock(p, &rf);
-		scx_exit_task(p);
+		scx_exit_task(p, &rq, &rf);
 		task_rq_unlock(rq, p, &rf);
 	}
 }
@@ -4359,7 +4369,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 			p->sched_class = new_class;
 		}
 
-		scx_exit_task(p);
+		scx_exit_task(p, NULL, NULL);
 	}
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
-- 
2.53.0

