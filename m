Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C040929D
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275577; cv=fail; b=ijNnDb02W+nKvikXLQqQ6iQ4vNPpXoXsY4qreG1G7GmFl2V7cnyFjt2PsvLnkisGV3iGbwfnRQcsWPi32Xyg22MUwEq3XnKICSZ0kYAAosY7+r/sgQMCEh2tLxD3Os7F+x/CIajG/zF/awJK9q4Tf80mosilDo6MAw6K4PM8z70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275577; c=relaxed/simple;
	bh=vrt1M/v39+wOM1P+70ohg+7c9EWnNMSLnlDJXr2oGi8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lyai1rhT3JIx+aRQUz8tenYCCLXGRTrYS1nt2t3HS6SAbAkRCoWA4XtB5Tf4VgNdMJTCbdwMfbAPaliu8GK8xPVs9kU0l03W3KC0OawZYXbVhaHDL+zdxVrLDN2o/TIe5JvCLxIr28oH7CPYLXYvTC/Hl7iT8nWNeQAtu+qopP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F9VwI2XA; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F9VwI2XA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO/Zy5MiumSfYJuE3ZjrHS2uXCpiED2a7KkwTMvbw6cZQQ8MMssWDiExZ020GZ3VOVZyAdw9cwdA6mhaXBU/ayxqeQpTXEhilYVSmSFx7ePCaGfetlVXYJhAfsO6YpnekdBFc2crB6INBCUnExpVQ7LX/NOtzrIvqFisl3F/V3zGKt4rRSpUbeTZxk15DFg1mwNHLxq9OyFxwvJQbyW3J6scMIN49cjUonjwsvBmG17EuDCHOdH92WXY003UivRRlrL3UkzWQ4IuFyFM2vIyqE9p0ugRCR5Enf1merARazLi2UxDzsAeMCOlifADlMcP+eyq1jVhE0T+YQJMa9aL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qByenqWWwNT+MjecKAkzhkX5MoHyS/NGZRqAKn2+X/s=;
 b=W8TWVf8EmVtCONmKK1JDeN+oQSlvtIbxSNNl5D7BhLI4GtTIINVSlRI65aPdpXP2IApRUT18wtNJ/iuy0AnxXy2gJ7U4VNbnhI4fk2wOa4woVhyRhkKncpN/56XsjZ5Vfja/gX9PzntD4b+p+FhJ8w+sKPXrZ7cVVHYsi+H6PZWIWaK9Msakr3TDGohE9D0mrPXm1CArn+j1fx78nBVtxKcmyj4vLL4oJKnUaZk1Fgm9etEaH+kt7nknIbWkma4aBG2cwBpLjwaJuJqkswmPOar08CouaBQVQLuHUaLY73Dp+U5Imubmy6KheG6LLxLvUQaXASZHQT88TPiAwlMHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qByenqWWwNT+MjecKAkzhkX5MoHyS/NGZRqAKn2+X/s=;
 b=F9VwI2XAF1FC5kIy6++2ySRhxptWBJLxurDi2DAKWIO1BUIVl3DU8kJ3pesrojbA2kvFYBp8Tnq0dqKYnn0IBKLIHUuZcTdziwjEoL4WPERnKYSiQzHaqnUkmsU/6r8u4KGW1bOJepjGoIlNsoCeCsTZIAe5crg90ipUj+0oUuv8oGvIqOryHVTVmTNdVNW/7c/Z1dWuFBzRlwPxdxx2ZAKajbqF3UtK4QBhuSwi8ks23cayLcEoYDVJ5OCWopdnAU1yTXFHRi6yaYftEULlVcIbclLvzrKTV2MWSdO0nbwWFHTS49lNF3XWLH7ANxEc0D9li74tu46k5JJFqFFGiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 22:19:32 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 22:19:31 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.3-fixes] sched_ext: Reenqueue IMMED tasks when their CPU picks idle
Date: Sun, 18 Oct 2026 00:19:24 +0200
Message-ID: <20261017221924.3908922-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077DE.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::40b) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 2398fb16-53d6-4a24-fffb-08df2c9cb763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bYPvpDauSQrnunHNBFCNDzuUpNr4/P5eoz74P3oz6Qex7pmrnJ57UzNt5UAgUmdO0+l68vEIy9mNHsAmBwVu+hQ9NEPaUJKjL+cE1EOsw2gKTy/nKHajm8zu2Of1VRBZv9mZ83NU8xxIUSRdobOAAbMSCorDR6FnmXsUwoaDAD7hJ9ftsyzKl44YCacO/cpZPDUsVIaC3MIz5CNRj8jxsF0meDpLHZoEEXet5V4VCmwiJei+7erGgrMHg3dWyMMnOHf6KOrS2Ku9iX2QwwW6gG4coxJZ0s+p/DLispygG6udDSNm9U7IzuZke99EftT6JvXXOcuqt3fk9d9/El8HfdECi03tBqXhR2i8jG1Lf1z4GARapjTxGtDjVr7XZ8NzogNshUvZItJml89cgVZIQsRASyJkPmN9XNeFn0gKGbsRCC/cfViz4E35vKv52BSNxE1qMAj8VXtdhsS/INL24lMMQ838FfZYRC3SYYoi7Olm+WAE0KoFUddqTxNgTBrzX0ohLT3+sOEOf9P05oezzSog8TVU/+BgD+7Hjy4jkaQ59j0+vPMK1JQpmLRZsndpuqkq3MgvBwH+lNebdph+n8iEbgDBPKNA2ap8Ms6WX6Ed9SsQgC5qymo3bm8U1w4i3QSfSQ1m6hm4U5xTLCFNY6xr7Sa5HJ3YwlfsJfELbLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckBHrpEhVS7SyiF69P78FDogR3aJQfJih+auLJx+bU+4ZyU253pamG8sd/AZ?=
 =?us-ascii?Q?cJYB1Py+R3yGzGMevnWcbqYJp/hH/5dG2DOV3pzs66RtDXJlx9N6XV3ckKc3?=
 =?us-ascii?Q?ACx2AlrkaAdMU3OA2H6jpweCBRz+NHMVHC0W5YFK3R6dYwOeyzu0caVa6UjY?=
 =?us-ascii?Q?m98R7mA5Spqcx9QvLS0fdQ+FBE/iT2z+3lTCYQgVsUzjXgCByRIaXtQzJZUS?=
 =?us-ascii?Q?J2RmtR9QMYoO8cgWxPIrFW5cDJwv2AEG/lEEeqm6pG4EaV6FNnuZF668RIzL?=
 =?us-ascii?Q?fePLyH6nkNZwV4P+VxS5q4RMcqL4jSjY+lXFE8/d1ZhEZhkme5v0QeiUYoW0?=
 =?us-ascii?Q?y5yriz4bR3pV0VMaZchCOZo924s50Szw4IiLk4TQrPMqgcDL+QjSGzZqqB8w?=
 =?us-ascii?Q?mihgoVbFNQmjDpn3AvIRfVe/oOghYZh5ZeYlCwG7OLjgdcRxTYO2ZnnNTMK6?=
 =?us-ascii?Q?BYSN/rPFoMoLpt2odlkJTvyHk/mCXP7j5xsT0FRr8Sn4diaXIg99hepojxXi?=
 =?us-ascii?Q?JBrsaiDsTxDKbfUQXf1q9DWtX0fPL0Kl2VKQa8YqN/HLs++aU0Ptj+UV1iAE?=
 =?us-ascii?Q?NfTmWgtNAJYGWAyw5VpbjQ9+RwwCAVvQPi3X5DtU+yfzbRHP/1YVfp8/MB04?=
 =?us-ascii?Q?yDSc8Sl/28DX6X9BFAjKjWtNYXiW0LKvEIry0weHo6p6cwk8P82R6tpndKFK?=
 =?us-ascii?Q?Qlc15jMXu0SWjBtD8Iy34qxF6tKRz50nsGFgBxrRMPAQilPgDpeyY7RgTKqE?=
 =?us-ascii?Q?DKfQkRjwT5chJWxE5oR6zSJ3Aa63B9VnYIt8yDAd+yXWCb26foxcgetl94HX?=
 =?us-ascii?Q?7ZFKB6s8smxTPEO3GMIXaP8bekWyRFxLJQ8fQEGF1dbQu4Lzr6+lErQtHYur?=
 =?us-ascii?Q?L80JI2ERP9QoGWrDNGX1DaBn0JbXIDu2jLpz5utfeAXWC0QQtjEUenyrES1x?=
 =?us-ascii?Q?65O2W03ruZXW2gSSWllEz4uJQ6wLe31j4unkkeXJIy/QdJ2kB1uQnOhxDzLp?=
 =?us-ascii?Q?DFM2SG0e0FADTwjEgCVQjXizMQaRPkmY1QS5R+1w7VHWS3X8X953JIB0WXUn?=
 =?us-ascii?Q?z6SV8dvlrsr5kxLThcHt4TKn38obwvKLrZCP84rrKubcnKkfAzll7i3lcmxI?=
 =?us-ascii?Q?IqfFbbP33NrKt9DnS2z5o4nGGnna6n8ZUerx/k72rJFf6GP1SmT+o2hZahHX?=
 =?us-ascii?Q?FP8WmOwgxq+aUlrTsgtTAysy4oN8q+ftLVV/jvCO7AWbT6UOUMb6gxYmC3s5?=
 =?us-ascii?Q?D5RmJDq8TLQGlAcJDhSWXvUVIF7UmZ1mvwTpa/H4iqt/EINOhF18Ynjenhyq?=
 =?us-ascii?Q?nQPLJDdIb7GEojhOWLHJohrxx72/JGlQckwklj4c1zSMe0LsNGUBiBSYRc4O?=
 =?us-ascii?Q?FaN2lq26iaZ9fOBGHkLQXcSIZYHqDLM+jQE85qo1c1eZHuxPGaGR8BkXUvHB?=
 =?us-ascii?Q?aI7A/XM0vTOqac30pioAOBnASofe5+50dgQTeug26BIWqxJmI7JW7nYgkId+?=
 =?us-ascii?Q?EiiNshmRkzTbx9CSfvvBrLlrZC0tMz5gYJRzKEoMbnqkNOrdl+Ivjm2IoohQ?=
 =?us-ascii?Q?N6lHxbRLwQ/1UoVE9GEjd5uxKYLStViI3Arh5jKxCqL1H6al0xy7RC7v1l3Y?=
 =?us-ascii?Q?F/EXCbH2QDxTpGvWmayOw6YKVGCYp3ewfE1a95AKzl5+5P3XZpjy3CLW8mXP?=
 =?us-ascii?Q?z5D4j90mxM1CzXrLLI6bBBUVzwVQmGOBlkJbHXQnxKvVgoLp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2398fb16-53d6-4a24-fffb-08df2c9cb763
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 22:19:31.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcjtNOxkmximixshDxtKbkqScH3LzxRQaO63kdvT63RezTuByVfxhHnadvukumdM4HlCcoUlnGFv/UnHHsTLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

Core scheduling can force a CPU idle while tasks are runnable on it:
when the CPU's highest priority task doesn't match the core cookie, or
when an IMMED task's own cookie doesn't match it, e.g. a tagged IMMED
task while the SMT sibling runs an untagged RT task. In both cases
rq->next_class is idle, so rq_is_open() reports the CPU as open and
IMMED tasks inserted into its local DSQ are parked there, instead of
going back to the BPF scheduler.

This was reproduced on an SMT pair, with the ext server runtime set to 0
on both siblings and an untagged SCHED_FIFO task spinning on one of
them, forcing the other idle in two ways: with a tagged SCHED_FIFO task
runnable on it, and with no higher class task, but a tagged IMMED task.
In both cases, the IMMED task inserted into the local DSQ of the
forced-idle sibling was never reenqueued and stayed parked for the
whole test time window.

Instead of predicting the core scheduling pick, react to it: a CPU
picking idle with IMMED tasks on its local DSQ means that they didn't
run immediately, whatever the reason. __scx_update_idle() is called on
every idle pick, both on a task to idle switch and on an idle to idle
re-pick, so schedule a local DSQ reenqueue from there, with a new
internal SCX_REENQ_IDLE_PICK flag that tells reenq_local() to skip
rq_is_open(), which would report the idle rq as open and keep the IMMED
task at the head. With this change the IMMED task is reenqueued right
away and the BPF scheduler runs it on another CPU.

Fixes: 98d709cba319 ("sched_ext: Implement SCX_ENQ_IMMED")
Cc: stable@vger.kernel.org # v7.1+
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - React to the idle pick instead of predicting it from rq_is_open(),
   which also covers an IMMED task whose own cookie forces the CPU idle
   (Tejun Heo)
 - Link to v1: https://lore.kernel.org/r/20261017124749.3608468-1-arighi@nvidia.com

 kernel/sched/ext/ext.c      |  2 +-
 kernel/sched/ext/idle.c     | 10 ++++++++++
 kernel/sched/ext/internal.h |  6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 32b248a6d1777..7fc306ff54ac1 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4591,7 +4591,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 	if (WARN_ON_ONCE(reenq_flags & __SCX_REENQ_TSR_MASK))
 		reenq_flags &= ~__SCX_REENQ_TSR_MASK;
-	if (rq_is_open(rq, 0))
+	if (!(reenq_flags & SCX_REENQ_IDLE_PICK) && rq_is_open(rq, 0))
 		reenq_flags |= SCX_REENQ_TSR_RQ_OPEN;
 
 	/*
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 28ed9e3270854..3d8d75ffbf9e1 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -804,6 +804,16 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Picking idle with IMMED tasks on the local DSQ means that they didn't
+	 * run immediately, e.g., core scheduling forced the CPU idle. Outside
+	 * of that, pick_task_scx() would have taken the local DSQ head. As
+	 * next_class is idle, the rq looks open to rq_is_open(), tell
+	 * reenq_local() to reenqueue the IMMED tasks anyway.
+	 */
+	if (idle && unlikely(rq->scx.nr_immed))
+		scx_schedule_reenq_local(rq, SCX_REENQ_IDLE_PICK);
+
 	/*
 	 * pick_task_idle() calls here only on an idle-to-idle re-pick and the
 	 * transitions call with @do_notify, so every reaching call updates the
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 03f03204d1582..df8b013fcd09c 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1819,6 +1819,12 @@ enum scx_reenq_flags {
 	/* internal: kernel-issued on cap revoke, not accepted from BPF */
 	SCX_REENQ_CAP_REVOKE	= 1LLU << 1,
 
+	/*
+	 * internal: kernel-issued when the rq picks idle with IMMED tasks on its
+	 * local DSQ, the rq isn't open for them regardless of rq_is_open().
+	 */
+	SCX_REENQ_IDLE_PICK	= 1LLU << 2,
+
 	__SCX_REENQ_FILTER_MASK	= 0xffffLLU,
 
 	__SCX_REENQ_USER_MASK	= SCX_REENQ_ANY,
-- 
2.56.0

