Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548534404B
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995576; cv=fail; b=AV8OutVm8gM2zrnuuqWv2o/opHC1zaU72iZjX5N1hSQaK7U4CFvZR/y5ZCKLOxup5DvpGgdwAaj5BKQBX40BThDJ7/C8RAfViO4lO0xYEj0T8nNpW7R2z7yLEnhJiXE7BjiL9EcoGeQQWXJUFV6yUqk1ur7hlxZhe3Tx0ZJXwhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995576; c=relaxed/simple;
	bh=oW0cmhidhA7KQoBkVExoPK28QcJQiOUDsrTwFni1pgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxBqCiFfh2C8cqclOXlamTx+h0f6YiQPh/pZBCfgTtv6uTq2aumSJNGBHac66fp0B+yKBh3o2km6CRFhhDSBSalGXMHt7/PYGVRdI9pje3xiptmZlq37GBkJkTEsKjJgbRyNe44zbBQszHbjlHc3FKD5oXG1Tjp0bYCqJmO5n6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CzQWPJhm; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CzQWPJhm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZleNz//0H0VdNbGChDZ7DFVpuG6rWlzXkOpXG6NW2Zw5/emMHnbAeM2UgJcqgtV/EIQZsch5XLs+Z54lylo4exRTnfs4t4rZyjYbBYkpHuaJNHO30JKV/s2yG5T7OI37bqFAEMBgE9kGpFYlObsTUGLpeVrpkQH6jK6MWwd8dYTXhMGoBETZTQeri6uSVirbSFjC2EZY8mVNXm+XJT9zsZ11mJx2b0jqmRADSejOX1xXhmauM5leVK4iMIr09c2Gp2yb9xvzOQyMg9BtWIG1f8aFy/02WIkJu918hJyzqTUdbtTjuHhaQP2xL5SLi1R8dk0Dc7Ofp9DHEaWANxs4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOjKRO18nawBFU7F4yQVMAUB2O0aMPJtDdln5AvNQVA=;
 b=t079LIJc/7257/oJ9RuDdc0Ff+y7iRbn0jEZ5Dvft0ouZU99flpaAJo0Zzynar9AKrrNESV3uEaXUgRBpmuSfRPwu0sIYlU7cX0z1KSfZchVfyahFprCVqGH7sw1jVILdPLcn5oYDrrb0PapOoHX7nZ3biWxyugotf+0WlTnUvnBct1+lCzPZMvHWRTRZdNpQS3Yn6JmZQAklBeDt8sbDc5BrRR11lmDL9DV2u0B3/n7ri/GOUR46ib8X/A364Inan30I+dI+nC490KRXd875RVX4xk+VJskKrjRdML4VM7b7IjtmnHMIDnnr/n40BK1CU2JeA8pWo7NmGFy8701WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOjKRO18nawBFU7F4yQVMAUB2O0aMPJtDdln5AvNQVA=;
 b=CzQWPJhmPDDUKMgT44Wp5eaSlxMm/yhhjWVchTW3rwe45ESNwV6EzLvuPfWfjPdBFW3PwA6OUtBRavmGH/2hDF39Bah5/jA9lOYn9DFjjn0bUog0vERAFrRwToUn7TLtrv49aoVBSBUL7YAR2YMxiHSzUC4ZgA9eaxAR/PBLnZ1J4UQ2yLvb4RazCJn2ggcVo8ljuTv3utHxxFSmsfc+dRWkNDELLc7Tx8zlkpX1is1YovS+wGhDmqbzo8CDOKwjMuklo6ecWaMozVmGYFEehovYRN0J6WqkVs1nv1rmGiW0pj5kQN1prTPaohJpG7ubsY9QSw/o4a2xZy/ZEha8Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:06:07 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:06:07 +0000
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
Subject: [PATCH 06/14] sched_ext: Block proxy donors across scheduler transitions
Date: Sat, 25 Jul 2026 18:04:12 +0200
Message-ID: <20260725160513.57477-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0009.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::6)
 To DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a521721-5c6a-431d-963d-08deea66a2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iJenyAmzrYst3Di8xXGxm71cAKa0M5S7Zjx8hz7UZ6P/IE5isqI6aBqM+qzBzLgds01RiHWJcpDLdHL6A657bcSC+Rs2h3LJXM5jz66+8XjBIxm5EoEqVbyHf6+uMOmZuJdzKjchqGMTUsvmClDJpxGVL/dtyVjS0NFXJOaacy4XUhhBlBir5f5TLhxVB2mA8vB2/7a64ABlueUe6HpdUMTiT8axLycRzIULl/gbofVMsyEWwGA8tz2TmqgiGQNy714qmAaq0xjgSaFKrYI31c93uDtmKDmq37ZcQ6s7MFM47vAvxhxJez7J3LS8SvCMvE9ceMJqnwBDoTVAjcHA0Z+YkC93Tv67fBDOB+xAUvjXxTLERF4sCtSmj/wIelNwBddPLPDDO6UePJ965wIvejbNkEhZBG6QLKJI2JmvLbBCoJElfUE5IAPgJl57FBB6lIR98KmtPNsvKOSjrIf1wddEtVvZaQstUFc5bEAeKu8XKfqAZ3VVN2zjy6Oe8K77ja/ccwPg8OOzpjSH5h/TbmEC3pmETsNmXJ/N+qO/zpGNz+wKwga+RyE+j7WNvV8EQhQTvVs6YvIxjwo6KkKeqwobVpA5P+vDwrtMgiGvMNnsVxXLoo+jNO1dyoHPTzXEA3Gx7sebjWXAsnTa+e3kKTdRDY3/s1VqZ8K5pujoWwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NwCFOFq0jx+H7PHq67biLtRpKdOMlLcszuuPkahDbZtLPpntPEvu0/LPRLtu?=
 =?us-ascii?Q?bhSHc5D8kEBmkgZ2rMhiY6Gkn9RNejjCsNW3u6Eq6EEWXRvn96ragCINQ3QO?=
 =?us-ascii?Q?Fdm2cqAvE9bTv9vJElcC7cyL2SwwaI47W+GTz3e1zuhRRxXCn66uMHT4Qg/0?=
 =?us-ascii?Q?huNzDrkiiRcSV7JIMfV7lry2gYGXL/TT0LlSZUQ8PWsb/tmW1TmgMyISk9iY?=
 =?us-ascii?Q?9FEy/h30jUt5aLEGGiglklb3KdFGBp5KIt91ksvWUM0oTE5mYCRnMZCP8ANb?=
 =?us-ascii?Q?x7kIJm4EZ5+EEtNCZLHTwdxJE+ovDb7ABrzbmJRY9jQDUPZfJYtXX1Ee73fs?=
 =?us-ascii?Q?aKVi6JuhVu8rvQm8KUaWj7v6Bioxd82ulgBmiXWxZ/7TriqL1Y92rSeN0jzk?=
 =?us-ascii?Q?xZJicWDL4NffyhkW/2y1tTbyMk5JoIZnRG4TLMO1lAJ1uDhHRVvQM1nX5Ate?=
 =?us-ascii?Q?plQgN5x8EDUIsB3whOIsDefQNeL7ZSeOeq//wfrSKgkZgIFavKBorEyPShKX?=
 =?us-ascii?Q?3qiCFDlaNFR2pgJbcKt6fe3ZlujqCuuQHwnt8SShO6OzXeOkEpNoV0Ca1bIF?=
 =?us-ascii?Q?UpGGXE4hdVzUW5niccS1oQ1SJaOg08m8a4LRWYayLA+juNfrZAyobl5j1fVI?=
 =?us-ascii?Q?Q9e+NY94+JgEzkXayOZxo2CJjaMjVfukjo37039GkXqH8vjCakPlefadmDgI?=
 =?us-ascii?Q?/MijLp8Kywbh4wcUMCYwj+61qVFTPiqQvUzHyUE3pYVFhhO1Cw9viuEsrYs3?=
 =?us-ascii?Q?387xh5f+5+w4j+erZeUcXHNFvbGn2x6AVokFnBjAVqNrMnJaTf/bN5/M3lj1?=
 =?us-ascii?Q?1BJIzG/Ziv58Q+w2Z5oNOZvf/vAnDFWoeJzwsd2KgK4EEf5nwY3/U2BqnPLj?=
 =?us-ascii?Q?Hju94zhkrUh5P5nA1GKBhYi4JcXkOq/KV7hCQ7BTPiAcYGAPo6OFmZDtY9fp?=
 =?us-ascii?Q?t1c/gQDJZD0CRjR3csTYRPdCeOoRHRwF2MCWeM5BpVBFOuSb5yokr1AjAo7K?=
 =?us-ascii?Q?KJmmbm6aWKDyQuHcdvqq5OPKiktt6Icl+51c7fvUrSXT7ReG2IHZR0/7ZqBU?=
 =?us-ascii?Q?Pc1RC5zPwPDRi6bT7gdBK337a3ttEuWi0gGF1FGAESmnEO9wlC53CyNXmPOc?=
 =?us-ascii?Q?g0ZR9v50ug4LnKUJIrtmIXj8QF5V3pHFEn21Hk0jTDFw1AfPRTdaGCc5B6aN?=
 =?us-ascii?Q?zphee4hijbpeB+bd4ubENZ1aZqYReU2c3yJfBFGIQfCGKeTafB3DjHoWcGcx?=
 =?us-ascii?Q?RVzOmo6BDQOu4JSyoBpgCIk8hqdvrx65Mm7TIyjxn4gXjxien0IWQc+1J4Hn?=
 =?us-ascii?Q?eAJjCSlNml0myVYGzqY3TJq7t0AA/aILI5uOeQJ3Vq9YBWBr1DDr018uroU0?=
 =?us-ascii?Q?ckj3F+8AmGkRgkJRquhbxgZ1dA3XrZMn2rW3BgKIfAGB8UOxdi07h6Jhi4+l?=
 =?us-ascii?Q?TJxeTRbUin8QKPjQ+1MI10vl3uPb1iouqq9ouNlDlMFJVhIJFX0Pwvvl1xrm?=
 =?us-ascii?Q?6kaYnIWCjztVcaX9c2vpYQk60nENRXzx6bzCiLN9L+ffRp7lodgMKve4ba8t?=
 =?us-ascii?Q?I3yFXEema2JBxtMbJ4wD4PDS8fYbOpfxtHrLqwyse8ilaLGsGkr3SZcAjP3W?=
 =?us-ascii?Q?KmAc1rpJWZ5/ujxmjiNokRkCkh/4Ip5XaCnIMLSg/0kdfaftDurJcmYpQwgc?=
 =?us-ascii?Q?4xtwKmyNUdTQjRyGDr8Nvr+efsfq4YS+l4jWBLA+rTvbzxcA37PBIII6efU+?=
 =?us-ascii?Q?/uwiHAHNOA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a521721-5c6a-431d-963d-08deea66a2e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:06:07.5489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNcbp1Rbxw9WRYVlVB6lYUXLsQke/5x0TNn49g2CJnMa8otpN+ypaBCWEF6yPcInXfeke6XzizQ4/aWM0nYOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

Proxy execution retains mutex-blocked donors on the runqueue so their
scheduling context can execute a lock owner. sched_ext cannot safely
retain such donors unless the BPF scheduler explicitly participates in
their admission and ordering.

Make sched_ext reject retained donors by default. Implement
scx_allow_proxy_exec() to force blocked EXT tasks through the regular
block path in schedule(), and fully deactivate a retained donor before
sched_setscheduler(), PI de-boosting, or global activation moves it into
the EXT class.

This is a preparatory change to support proxy execution with sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c7a77cc914cd5..bd9a8c3a269af 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,7 +26,15 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return true;
+	return p->sched_class != &ext_sched_class;
+}
+
+static void prepare_switch_scx(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	sched_proxy_block_task(task_rq(p), p);
 }
 
 /*
@@ -4731,6 +4739,7 @@ DEFINE_SCHED_CLASS(ext) = {
 
 	.task_tick		= task_tick_scx,
 
+	.prepare_switch		= prepare_switch_scx,
 	.switching_to		= switching_to_scx,
 	.switched_from		= switched_from_scx,
 	.switched_to		= switched_to_scx,
-- 
2.55.0

