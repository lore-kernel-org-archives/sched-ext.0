Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0CF402B99
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500234; cv=fail; b=jmG1T3KB0g0jQAaFtztrEtaFTz2B7+GMb4A8gViQMirtt+EpZEEzM/2p9Dtyse54kPk+6RaCbLmcyAtYpMoSCu2Ud43x3PQqEYOPul7GPdSEfZTTS3X5zTc7vasl3/6gJ9oKS+rDuegtS4RcKhd0Jv38oraLbH24UukLnxCfmyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500234; c=relaxed/simple;
	bh=spfkldgkqbJGJKSGOZoqJTMnBXIinRn35la7wFG/a50=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZjDthizl9mZDuFbA2sDnr6CWBOrdvDnX3tDMTHJF6jGcL1f9bOt7X/cK6kw0bGNLLzp9D99aNivlyr5HyXzWxBh1/NnXJe0WcnrXM9JLiP5689HliZbsjlZf4j3SWE05u2SREKI4b3lv3boHwsFvqYzARIfPs1ApEsVopT08FUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E+Fhv0FU; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E+Fhv0FU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSbfXbUKT/8Y+cRzQQThFYK1AlphNFSh5qb0y+Rp0KeQjyV7yPi6cJvAGitROZL/WpcKnDBxzBVFVePNpfN/Ep+j9rB6B8mLxL4lOSRTZNIumNaZMNZI3lUeBUxk3I8Rox2YM5/SiNj89q4Fjgi2GB9vRUlENQ/d5jiukKFg95/y0Iiwkaqy6faY64aEJznf8xbrMN42zxKhnE0Pvbi9fns6IIG9quonmyrJfUDe5TuscxkJsZRdLHvT+fBMgVFrPGqr6QyIW1IZKohLrryFM76sr5JaMgU+iOpfmSxeiHMSjIS3BH3ZDLFEPhTzLizIbM6P5ldDovc4yANMy5OMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcrpI+ljJvgxPh9+COj6lES7YOmGy34ZvEgnHr1HxJA=;
 b=CuCLzSqQNoGt57KpoybRpXLw2lw2pFrNHl7xJl+/iArQyiXqbUAaWygvj/Q5hIsxfLotGrVnEXd0h+jrIBSlu5usuhgOtNAmBwa2V4FRwwzeYr438KyCG/LDsVfqDUyth0NwNOb+pYTNJ1tVEOoDPvmsZ7PfFpD/O0Cw4BGk32MzW4zkujfFD1b++zZj8oLfa0glMrOzaOucfulGhyhF+e9bonvFiIDnLUNk1yuV/lDaX9R2OPT1FMdbzw7j0spX3GrCqyiTdCFmnKwk9RnIY3Q84pqB83CFPNTk+yZ3x923F9oBOvQVKO4xc8SI31OdWNENJazXZGmEIxJaxGNr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcrpI+ljJvgxPh9+COj6lES7YOmGy34ZvEgnHr1HxJA=;
 b=E+Fhv0FUvdjdCAh9A126TCLPPMp6O93dgOGGB/q7YYTV7Mf5FjNGhWSdkowgTeBpLZ3Kdfb0PlOXaht4odb0Gu8Wo3XXOx4WeLs2lWEemEsWUMxzS3u39VHWOgW1P0k1Rj016EJERwyhhFLuxyTWq+4/CoXLME3t1ANgUJYjiO/bukMfvfH618CicJgb8MQDCaWeBLpwv/hWKNQNgAWX1Ln/HIt2+kecdsPEJLq9JFaGg0GmSsdh88VeCWM0wXS+4o/Fj6WU85vbHpVACtEFovX/Cz2ILVh/Cnbrs9CzlDtXRHMqn/ype97Z7RKsPj+wEhd4fAZWzZWSGgBYIa6syA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 08:43:44 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 08:43:44 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 sched_ext/for-7.2-fixes] sched_ext: Preserve rq tracking across local DSQ dispatch
Date: Wed,  8 Jul 2026 10:43:27 +0200
Message-ID: <20260708084327.1088186-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::19) To BY5PR12MB4820.namprd12.prod.outlook.com
 (2603:10b6:a03:1fc::27)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 379802cd-effb-4e1f-7573-08dedccd03f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	/Gde7OneYYCO+b+ItHm1OhDzMhphK2/d1qWQtbnr4kJobtGaANXtri/8EVch+mGI0Gq4GgB113QZ74iMKdc/eRTdtGR1ll8vbTulQQwCBoNwBeM/J1I9mRcUUAkh2iTwdvjnykR3ih3WWZqr7Kt/1JztVf/NBopIkDsvG9XMMiMUX24tUDPt+RaGODQCo/5WWgvznzOEqCWVzBvZyAKXRFCDizRYbvpLnkvP1l6N44MLVaBT1/PSmhSaWXzCDbdmnRRB8tlyujFqan0AeMWRXwqJ2c3pJI6NTOB2CywiQ+PPyHJmMa4HFZ4H2t3xUVGz+dUPcPth6uVmm41NW7hj8PlJbD/tbX9e1CIBzcmn6V+heWLEeq1mit9JAIZ6T4PxsEsZ/wq+L9redb1RCy7doB5TWDWeSM+vmEIhHIOrzoUh9FFbzpG61A7x48N+1vpHiLuhMaVYzr4ME86Tdd9FgigU0kAM3lCC9HvfMW1oQpQXwfapHeobYlkfU02WuVMGeDeT5YEqhdYaD0fZQzBqrs74jI1yjG9c0XMPrW/W7fpkq1BPPVI9kB6bbfY4oKcd/YtQKXISbcjG11V0piQw+4tamE/HDyoJi9TYHw4uw4QiPhHx2P+oAxOoXEE4CGtvR1S/YyduYOz17oJTjTP5SZRfMr1rBMAOq2pl1vvJ7/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uf8eZXC3YR5hpmlzYhgMgAa6u0RBjkS0cGJHbx842PVj6D4RzsHfmg6IJopF?=
 =?us-ascii?Q?p4HACZPK9inCy/ZSCzVqeB7VMtPHubnJZ/F7941oHpWIU78txlmAG1VgnFlP?=
 =?us-ascii?Q?eCMSw+vnR1TUKwnR4fMBxibiRjnQ7cwuLF0pdKqiHrZ9ksGIvpVC048NCE8M?=
 =?us-ascii?Q?MyGgSFwEB2SFy9ibijdE7HLq8fJKgn8+HYpq7ieY0cqBLLU9gxCY9blzrlVA?=
 =?us-ascii?Q?201eWrc9v2so55XYSNmk2k6MfctqB+Dy6UmmwaSCkF/5jban1xJRnoVmR8gk?=
 =?us-ascii?Q?mwFbm4QOquvVfMZlCo1DMz3VeuysZZZpFwJtxL0in2UPQzg5Mt++kGFiiS5s?=
 =?us-ascii?Q?v63WjvBn8sIx26R5B2zdoguQxT+WtpBlk3i/x7L+6CbUexXHhWr3feCnrU3k?=
 =?us-ascii?Q?2vFvFMvgVrTbYRxX5gXl7wXb61qCkMqhEJTMA2BCTH9osWEEZl2iK2sqVguc?=
 =?us-ascii?Q?4LFTaokko+cjLiHJGHZ2cGeu3riWL+tBH63lhOaPqOBLqJzMTN477/qRYtFX?=
 =?us-ascii?Q?tTpdsop3Ml9Z6+Bt2xtlalkCbigmpKU+PsfT/12Oe5sdUNWBNZzqK5+WR/J+?=
 =?us-ascii?Q?AzFw/4tQDd+1RsROUwuGMq5IR4SdmjMAvHFHoUXMxnEtyG0uDgrWfG+713hf?=
 =?us-ascii?Q?c+KEDNPIy2HkLG91E9P7WLEJR208CDYGUgrqyJTVrSejYMooy5mv8Yl9xF03?=
 =?us-ascii?Q?nNSRYFqnJTVs+INb3HX5vOsQjvCqTi/0M8XyorbrPkwQivPgfuXQgI2poOwu?=
 =?us-ascii?Q?cAyeQNgTuBVBgDnkedjYD2dr4GUSffHmbYy7hsYYU0LpcIXAyMQg4VDu7mzS?=
 =?us-ascii?Q?IapwCqzdRQ8+J3dLBwFOYBQBy5xyqLy808RseO8jga4B//yYAEgkfSkOSm5S?=
 =?us-ascii?Q?zuhRCPdJc8Hn/t+tmEAzCnOFTznKzBf1/c50mG4t657twNlo2YONtAIjOa21?=
 =?us-ascii?Q?tJ3oZTlSE2MYSb/ChpgI8Pv+X8r9J8hK7+JTRPxsiWCx9RJcWOFiTGkEWMXz?=
 =?us-ascii?Q?5JaF5iHp4yoiIrJ0WTESNFG80uSIMErXRYMPwqqlpOVxehrvUv0Ei02CVGCn?=
 =?us-ascii?Q?hdZ+nU3efvLzl5fwVMHyihN98mwF3QGQds3rzqogpIYpwNj+zbqt31qGgpb5?=
 =?us-ascii?Q?IoVJdE3oEpY/hegHI5nyZsm77jSf7wGKabGq+hK1WPmhHWbRHhWATIrsQuEH?=
 =?us-ascii?Q?XQxCxjJOoDgrF6E5DAF8Qk6D5Mypua0FbBYH/zuBP89am6j9fsP7ehX5t6RR?=
 =?us-ascii?Q?gna7qqGakuWxLj2sUmaBEdNdaXrM+97DjtzkQ+gliU298S+WLs8zj6D7MUe8?=
 =?us-ascii?Q?s1ADgAqF212fA4SHs7Oqz1aKywbaVkQe7wvCodK2jve/ZQZH7SkHCVMiQyDO?=
 =?us-ascii?Q?CMD+F3OkJwPfZsTejMtCGgfw1nORLWmA6XoBgSku2pFZPR9sDzi8vl02gvX4?=
 =?us-ascii?Q?sLL/98TG9QlXKpH429w9aK6/IpRlVo+VnhZMeTYk3qdFUYJjyGvXgSYtxSyo?=
 =?us-ascii?Q?7UYthuKitPkLTg3eFjLZnrXuxljooKD4uenEd6aDLagHz2lvoolc4RVA07gH?=
 =?us-ascii?Q?RW9h0+scSqXm4jTocqe/xaPX+5L5fSG1UfHt07h7W+DIvwsHZWnrTXXhTpq8?=
 =?us-ascii?Q?j6Pq/6YgMPFIHxItj303BRLrlHYuOehIO3BvyPeJ6FO8MhHUq5gwLwUcAZE/?=
 =?us-ascii?Q?/imyYu6JQBEaJbZRHNQkUu57rwV4kQmTI5nZz982ECpZ4pQPD5wRrYirYUA5?=
 =?us-ascii?Q?2La5rGe83A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379802cd-effb-4e1f-7573-08dedccd03f2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 08:43:44.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/or/udH7CIDmaVSuTuEoOeEGx6l09vGV/KAyrQ9gQXs7WbUtoBwsq7JNtod7Of7KKO8U3Yn6jkMX4LObjP4qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874

dispatch_to_local_dsq() can run from scx_bpf_dsq_move_to_local() while
ops.dispatch() has recorded the current rq. Moving a task to a local DSQ
may switch to the source or destination rq before synchronously invoking
ops.dequeue() through the following path:

  SCX_CALL_OP(dispatch, rq)
    ops.dispatch()
      scx_bpf_dsq_move_to_local()
        scx_flush_dispatch_buf()
          finish_dispatch()
            dispatch_to_local_dsq()
              scx_dispatch_enqueue()
                local_dsq_post_enq()
                  call_task_dequeue()
                    SCX_CALL_OP_TASK(dequeue, locked_rq, ...)

The nested callback saves the recorded rq and restores it on return. If
the rq tracking does not follow the lock switch, update_locked_rq() can
trigger the following lockdep assertion while restoring an rq which is
no longer held:

  WARNING: kernel/sched/sched.h:1641 at call_task_dequeue+0x160/0x170
  Call Trace:
    scx_dispatch_enqueue+0x2b0/0x460
    dispatch_to_local_dsq+0x138/0x230
    scx_flush_dispatch_buf+0x1af/0x220
    scx_bpf_dsq_move_to_local___v2+0xe2/0x1c0
    bpf__sched_ext_ops_dispatch+0x4b/0xa7
    do_pick_task_scx+0x3b6/0x910
    __pick_next_task+0x105/0x1f0
    __schedule+0x3e7/0x1980

Introduce switch_rq_lock() to update the tracking state together with
each rq lock handoff. Use it in dispatch_to_local_dsq(),
move_remote_task_to_local_dsq() and the in-balance paths of
scx_dsq_move(), ensuring that scx_locked_rq() consistently refers to the
rq whose lock is actually held throughout the lock dance.

Fixes: 7fb39e4eb4c3 ("sched_ext: Save and restore scx_locked_rq across SCX_CALL_OP")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v3:
 - Track the held rq at each lock switch using a common helper instead of
   clearing and restoring the tracking at function boundaries (Tejun)
 - Link to v2: https://lore.kernel.org/all/20260707173851.153379-1-arighi@nvidia.com/

Changes in v2:
 - Apply the same rq tracking fix to scx_dsq_move() (sashiko AI)
 - Link to v1: https://lore.kernel.org/all/20260707135854.1379730-1-arighi@nvidia.com/

 kernel/sched/ext/ext.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3fe06d05ffdd5..2dc6977d7984b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -479,6 +479,18 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
  */
 DEFINE_PER_CPU(struct rq *, scx_locked_rq_state);
 
+static void switch_rq_lock(struct rq *from, struct rq *to)
+{
+	bool tracked = scx_locked_rq() == from;
+
+	if (tracked)
+		update_locked_rq(NULL);
+	raw_spin_rq_unlock(from);
+	raw_spin_rq_lock(to);
+	if (tracked)
+		update_locked_rq(to);
+}
+
 /*
  * Flipped on enable per sch->is_cid_type. Declared in internal.h so
  * subsystem inlines can read it.
@@ -2274,8 +2286,7 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	deactivate_task(src_rq, p, 0);
 	set_task_cpu(p, cpu_of(dst_rq));
 
-	raw_spin_rq_unlock(src_rq);
-	raw_spin_rq_lock(dst_rq);
+	switch_rq_lock(src_rq, dst_rq);
 
 	/*
 	 * We want to pass scx-specific enq_flags but activate_task() will
@@ -2608,9 +2619,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 
 	/* switch to @src_rq lock */
 	if (locked_rq != src_rq) {
-		raw_spin_rq_unlock(locked_rq);
+		switch_rq_lock(locked_rq, src_rq);
 		locked_rq = src_rq;
-		raw_spin_rq_lock(src_rq);
 	}
 
 	/* task_rq couldn't have changed if we're still the holding cpu */
@@ -2644,10 +2654,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	}
 
 	/* switch back to @rq lock */
-	if (locked_rq != rq) {
-		raw_spin_rq_unlock(locked_rq);
-		raw_spin_rq_lock(rq);
-	}
+	if (locked_rq != rq)
+		switch_rq_lock(locked_rq, rq);
 }
 
 /**
@@ -8848,10 +8856,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	in_balance = this_rq->scx.flags & SCX_RQ_IN_BALANCE;
 
 	if (in_balance) {
-		if (this_rq != src_rq) {
-			raw_spin_rq_unlock(this_rq);
-			raw_spin_rq_lock(src_rq);
-		}
+		if (this_rq != src_rq)
+			switch_rq_lock(this_rq, src_rq);
 	} else {
 		raw_spin_rq_lock(src_rq);
 	}
@@ -8883,10 +8889,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	dispatched = true;
 out:
 	if (in_balance) {
-		if (this_rq != locked_rq) {
-			raw_spin_rq_unlock(locked_rq);
-			raw_spin_rq_lock(this_rq);
-		}
+		if (this_rq != locked_rq)
+			switch_rq_lock(locked_rq, this_rq);
 	} else {
 		raw_spin_rq_unlock_irqrestore(locked_rq, flags);
 	}
-- 
2.55.0
