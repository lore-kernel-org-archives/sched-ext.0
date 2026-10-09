Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50AB43F4B5
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576522; cv=fail; b=NNhJA6A8nKMC7Dt2OlaKLIU4DvRZGPeC6ZhaCMCQp4P+Ajpn2oCsqWbAChrP+Mz1P8R/CAqmLv1n29MnZQ4/wJSS/4cYs3rHaZbq/7XxHmqc5igGeJaB6kmPX3Snt9GzZ6ENLrJJQOAVTHwANdhDr6fqhcaBYHqVXny0A+xPHws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576522; c=relaxed/simple;
	bh=sZwdkJkYI31FqFdGaF31CpNiARiPJilsV1XeJyDA+wA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TF7I/258SRycHlNT2peGfFb+4u+FcubKLpLvHXWgTUwofR81tmZlbrOgrcygUVIyCVvBYCpijMYOPsOsJ169Qb6JoYOV6XeK8Bd5c/CFRtGkg+W6Y/s8IxG2kqloRi2OhqsZLpkysOfAydRdmw4+tcSrs0VCOvRQuUufo+uN28c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gWlZozbl; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gWlZozbl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSbkt6zYLiykJiz5eTION7gur0Hk/22henJ/slvJ7mDc1BH27mq/xqcL3RRJtNKZ78ErW1rVvOel0nT8kgv/ACQI70PKalXJT91d7cHszERz8za6S/EDmIqunCg0zk4+z4snHxTEjarRV1x6mr/V16CDMUSEcwYdOmBdfcpGHi6+vLmx9j14JrIS6FWSLZ+QDVevI6DDLAF5h8c4/4j0EsIIWeNiJQdDHEohCQtjtPzj8vuCuQ0j/i2QauYlnAEAGaB/++hnCDkcT3DaTQjxbiBE75ts+kNhqc2nQrFSUP7G3PnjWAhEAojUpBhux518UeOtzu4znhz9DrP9o8gIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYRJDhtyEIdm0qFQrM3rNIARUvl4dcbvOE7PcSaUFVI=;
 b=UnMxxM0YTsTo/eeeHM6+P3ShHTMyvrGQ9Rbhy4z4Y0ONveDn2Jnv0QMrFG2xV0btENQ5GSlqVzZ7Kz7BJh+ZXOhMkaLpK0XkRLo9kT5DC8rdp3j83FtuzXVaw7P7wRl+prfV34PHm4tnsCOyCIi3Wezf33D2L/hrA+Vy7RKRAf07JCa2+yvVniN79XOk5Gt3juhNb+zUWgx7A+JhJvaFrhw0eGBjAwv4RBUVmSEcyumTdXULDGIEDakNaykFKPb8Zy+lRZ9QXTBEsEnIqZ+TvEGYsHOuF9mhdGdvKO9mRxJ5dOQux89cB9P285sv0iYxBvavEZ6epVqFr6BwXTY7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYRJDhtyEIdm0qFQrM3rNIARUvl4dcbvOE7PcSaUFVI=;
 b=gWlZozblayFCfkzCNmoD9I/k0C+vwpADH5c2ziPgixhuwdEZmJXLPzMyLhTiFB4cqNTJ+sUymr/SV0SsCPbEngEX+iSYfUfVwbc064VCOfGn2n17BGtfP6IvaW/dPetbF37tVocS9G+uT5BiyQqoOVbsCR0nL7TYkP3oK2YRmfqwJfwya4lV/6JCOabGFt5OiltZcNSgyE03K4GcDK4jriRZeEmXa6YY7PEkKQ6L50ssRPIVYYjGR69fSFQGVN/4TXv7w+uyDKPLjMfHs8Zf1d45rkVuJ4WAFfdDUTNoIpPnWyPFWeizfpzPLTmTQ8ezbps3BMSNuV8vwKlJfdVpjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 20:08:36 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 20:08:36 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: John Stultz <jstultz@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 sched_ext/for-7.4] sched_ext: Keep proxy donors with slice left on the local DSQ
Date: Fri,  9 Oct 2026 22:08:26 +0200
Message-ID: <20261009200827.4026499-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: e176116a-6043-4d6e-bbae-08df264119e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|10067099003|11063799006|18002099003|10063799003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2Kh0H//DxmQ1mdGxPMtRcYq6v/KqQ5/vOyIoRv1ZwDnrdBxEqLEuRe8mnb8XNqMLgJR9xNFaf8VNN+JQMNjM1jwkthcwm9O/1xyq8Uio/WhPeWQC38LILBbqlJrUiQ6tVJ60e42bvIXz9ObJzSG4FGQZO+bD1s3gOlkMZ3TntcmH89+grodL53EUVGGyvFFX6i2055oNCdAWE51CwyhzAG9un7/tTvCRg6tHCv8zgP1PpJC6L/qxcYQ8D05/EP5HH479rMH0HMcQHvEGQOTUn04q+QsFhBCRQRMbvoEyMNwyIYQ49tx5LJ+fNlkl3V51Tb5xanPL6RX9zutnUKZa/DWZSrzQyd18Bp2O8OdFOCVxcNbK4nsJWxjEvQY4oBKUAf1DcXLEHF84xTqFM6F7ooUMTGVm+Df8vO+TK3urxqHWnedGCM8MxPA/rOKtmZ/1R9VyWQBSt/EFjDuXZ2PuaL9xEF9PTe7xqjVA3yzE+25JYr2tIrLJeSvT+r+PQR2sBeWr4fnmIswtQMQA18i+GmVytpKKUsNPZ1v+OddPREOOyGVmI3VxhonIURfs0LROo/AX26kZRdcISme7MMWm6UBP3n++Dr8akvBHGVs97WjN1KXPd7Cjm5/nXacBemU79FjpOn/ecQZ/jltH2udWHhGt3cyFJUFGGcUeqY/bpJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(10063799003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHRUa1ZHVEV5bEtwancvQjRvRjBRdGhwNUpCNkJBbUVIVHV5bnlHVmRxa0lx?=
 =?utf-8?B?MHJFZWJ2eEthOFp4TzhoUTBTMWt0N01LSUFWUmU4eDNjUE84aTljYThBMkFJ?=
 =?utf-8?B?YmlRU1pHckY1YUMxa1lmcDVMc3JhZ2pBQmVmL28xZ0VEdzhlRnU3VG1tZHIv?=
 =?utf-8?B?S3NmTitQMHcrRlRHMEZhdzgybWNvb0hmSldqcmtYcTlRRVRIeHJxTlFqa3Nv?=
 =?utf-8?B?Q3dZVnJoUVJXZGJISXh4RWp2R1ZmeUF0WklNaTB5VGtGL0NCK0grNExva2hC?=
 =?utf-8?B?RVZEYld5UlhZcWE1WVAvVStwRnNlUE1GUzk4WTdFeVNiL2FrTytkQUFqZmhq?=
 =?utf-8?B?aDNQdkFIM1NkTjJ5ZTRQRGUvSjRqZGpXWmxEcmxwblpHczI1REk5RVBITlkx?=
 =?utf-8?B?bVhRTTVnVTI1eDFWdk1DUGpuT1h4YmlKVXJld05jWktEamhoWkF1REZvVFEv?=
 =?utf-8?B?U2p0dzBqZi9hbDB4dE9CbkxPNGJZWC9YWkNTNUtaYmEvbEJFckxnYzlHT0xz?=
 =?utf-8?B?YVFSbnZlUHlrVGZHODMyY1FKRWVCenVScFpOYmNCMkJBaURBNi9LblY0NVhn?=
 =?utf-8?B?aks5Qjd2Z0d0cCszcjVjZ2p2VjJ6TkVJYnJGRi9GU281TjFzQzFmYUlQOWE0?=
 =?utf-8?B?Zkx6UzZSRkVYSzFvV3RKMUNBZ1JGTFliWTcrY0hKT3Q1N0x4MVFIL1dUY3JW?=
 =?utf-8?B?bExBQ0FNc2NPZklQNUtyOEFkT1NvR2FaWjZJeTl0bFlqclA0aGNaV1J6QXBL?=
 =?utf-8?B?Q2ZKNWFnejJoYUhvZ1BBUEEzZXgzWFVpT2JBOC9hTi9IWXpnNG1oZUFJZzNL?=
 =?utf-8?B?SVR6MFRaNDVjRDFxZTVvSzAwckxtVGVqZVpBcUlXaFVwVEsxNndNKzJmV3Fq?=
 =?utf-8?B?N3lhNTViRU44SWpXSmw3b1RQSlpLNWdLSUpRT0xxRW9rcmk2elhzWE16NDVn?=
 =?utf-8?B?MEhlenZlRjZRcTd0TWY4dGJpdm51NU5TTCtPTWtlRGhNN3ZwcTgwalFrbFpy?=
 =?utf-8?B?dUc1SGdKRmtLMUs5YWV4QVZaYzkyOXdYNzNuQURHWEdzM3hHMVY2VkhoTzFR?=
 =?utf-8?B?NWpKNklhZ2YveVc5V3c1a3dDbE1oRDZ3L3I2N29yQTViUEYrZVdETFlrbzg2?=
 =?utf-8?B?a2kwN2szak1KSnZjMS9ZbmdHSkN3UDZJRUtnQzZma2RuVVphbFRqTno4a2Uy?=
 =?utf-8?B?VW5TcCtGbnVzR3ZFa2ZmSWtQdW1WZE5WWmRuaHN2WVNpaTFVOFVQR2ZVYThG?=
 =?utf-8?B?Y0ZCQmF3MWV0VjhYeVZHK25ZVEZhZFdlVHA0NnpxcXUreUpkUjU0SmZkNEVt?=
 =?utf-8?B?Z3h6SGNIbFN1SExlczBXaGhQWFU3V3FQR0NTWExPYjcvOGt0NjdQRXd1Zm1j?=
 =?utf-8?B?SzNqM3BuL3JZWTc2QkxsajlzbGVxOEJHZnZ0TmI3ZDliV1pUMmlMcWFpbDlL?=
 =?utf-8?B?clhZYlhzMHEzemowSGhDRXdjRTRGKzFGbkdiUUR1R092dDZmRVMvOWN4QnFN?=
 =?utf-8?B?R1JLT0hoampkTnkrbVpUeUNoMFZxK0grRWZyYXNKRU5HWm1GcTZJN2tzZlB5?=
 =?utf-8?B?Q3RzcDV4NkdMSUJadkxOdE5vY0FoR085WmZPMkxzVS9qMmFmZGpPQkxUUi9l?=
 =?utf-8?B?TEJpWXBpdnZtdFphb2M2aFhHTHhzdGdoMFNYVHZoREhFdVFDNlowZXY5Wjh2?=
 =?utf-8?B?RC9LVUhLMXppbm9EYWN3c05mc05haWRmU05kSGlxd00vcG5zck9DMld3YkpP?=
 =?utf-8?B?b0hFVHpnbFpVOXhPNFlZVVA2Nk1SWVBHU1Y4MkxlOG5oaDZua3hQYmNmblhp?=
 =?utf-8?B?dzNFeklkQ3luN0lLR1NIUDZUWXFWbm53clpCV2NiOC9HMWkrN0xPV0FHYVFi?=
 =?utf-8?B?ejJuREVTM0RuRWR5UVBtQ2h0alk2MTkxT3BvODJGN0pmVTR3L2QxVGNFZklW?=
 =?utf-8?B?MXlMdWpCQmdIaXVOMzR6cEZSZC9DakZoZXBuQ0x4TWNOWEV6bGtkT1hHRlps?=
 =?utf-8?B?eXBVTXZkcXQwVEVpTklDL3lFWEkxcndpUTNNVEVIVStIR2RPNzJjaEZ6bnhz?=
 =?utf-8?B?Zi9jWGwvRG94dXdETFFwa3oyZVh0VHdIN280RVdhU0M2R2pYQWVTN0FOV212?=
 =?utf-8?B?Uy84S0o4MXY0ZTJCdUwvZW9paWRVdllEUWFFM0VOVHFuQjE1ditDU21oUTFp?=
 =?utf-8?B?aE9ZRWZZdG9ScVVqaFdWakRxaEt1NHBFR3lIMm9HVExOZ2wrLzJ4cHVmL3M0?=
 =?utf-8?B?ckNZQ1MrenRUWE95aUxHVXNaZlJyaGFaOUgzVVJ6VmVIU2lPcDRkeFYrNVF5?=
 =?utf-8?B?UzVHaUpmOWNFM28vUDNNQ3VzUm16dG41S25zTElxSllJcGNjRnVqQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e176116a-6043-4d6e-bbae-08df264119e7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:08:36.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvlUfqI84EsT9jdJQcioWacU4IEReBGUmk49Qv4ZzOXRPS/cBHxI/yM64PGLoO7foTBtTumgn08+dMpLlhj5jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

Commit ee172227d0dc ("sched_ext: Delegate proxy donor admission to BPF
schedulers") makes put_prev_task_scx() pass a retained proxy donor to
ops.enqueue() with SCX_ENQ_BLOCKED.

Some of these puts are only proxy bookkeeping. proxy_resched_idle()
drops the rq's donor reference before switching to idle when:
 - find_proxy_task() finds a remote mutex owner before the donor
   switches out,
 - proxy_migrate_task() detaches the donor before migration,
 - proxy_deactivate() blocks a donor whose owner cannot run.

In the first case, BPF has already selected a donor with slice left.
Returning it to ops.enqueue() forces BPF to dispatch it again before
proxy resolution can continue. In the other two cases, the caller
deactivates the donor immediately after ops.enqueue(), undoing any
placement BPF makes.

Keep a donor with slice left at the head of the local DSQ so the next
pick can resolve its owner, or deactivation can remove it without an
unnecessary BPF handoff. An IMMED donor can stay there only for a
bookkeeping put during proxy resolution. Mark a blocked pick as
awaiting resolution to distinguish that put from a real preemption.
Return a preempted IMMED donor to BPF and apply the normal IMMED rule
during deferred local reenqueues. Use SCX_ENQ_IMMED on the temporary
local insertion so the base CPU capability is sufficient.

Moreover, allow blocked donors to receive SCX_ENQ_LAST when the
scheduler needs to arrange a follow-up scheduling event. During a
scheduler ownership change, mark the active donor's proxy reset in
sched_ext and skip reenqueueing it: sched_proxy_block_task() will
dequeue it next. This avoids a transient enqueue/dequeue pair and a
false ENQ_LAST warning.

For donors with slice left, this leaves BPF to handle meaningful
placement decisions rather than transient proxy-bookkeeping puts.

Fixes: ee172227d0dc ("sched_ext: Delegate proxy donor admission to BPF schedulers")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v3:
 - Restore SCX_RQ_PROXY_PICK_PENDING so only proxy bookkeeping keeps an
   IMMED donor local, real preemption and deferred reenqueues follow
   the normal IMMED rules (Tejun Heo)
 - Allow blocked donors to receive SCX_ENQ_LAST and use
   SCX_RQ_PROXY_BLOCKING during scheduler ownership changes to avoid
   transient enqueue/dequeue and false ENQ_LAST warning (Tejun Heo)
 - Link to v2: https://lore.kernel.org/r/20261002221559.3090900-1-arighi@nvidia.com

 kernel/sched/ext/ext.c      | 78 +++++++++++++++++++++++--------------
 kernel/sched/ext/internal.h | 16 +++++---
 kernel/sched/sched.h        |  2 +
 3 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 248b39d09ce3c..e168aadb5c032 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -24,6 +24,13 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
+static void scx_block_proxy_donor(struct rq *rq, struct task_struct *p)
+{
+	rq->scx.flags |= SCX_RQ_PROXY_BLOCKING;
+	sched_proxy_block_task(rq, p);
+	rq->scx.flags &= ~SCX_RQ_PROXY_BLOCKING;
+}
+
 bool __scx_allow_proxy_exec(const struct task_struct *p)
 {
 	struct scx_sched *sch;
@@ -47,7 +54,7 @@ void scx_prepare_task_sched_change(struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 
 	update_rq_clock(task_rq(p));
-	sched_proxy_block_task(task_rq(p), p);
+	scx_block_proxy_donor(task_rq(p), p);
 }
 
 /*
@@ -1574,7 +1581,8 @@ static void dsq_inc_nr(struct scx_dispatch_q *dsq, struct task_struct *p, u64 en
 
 		/*
 		 * If @rq already had other tasks or the current task is not
-		 * done yet, @p can't go on the CPU immediately. Re-enqueue.
+		 * done yet, @p can't go on the CPU immediately. Check whether
+		 * it needs to be reenqueued.
 		 */
 		if (unlikely(dsq->nr > 1 || !rq_is_open(rq, enq_flags)))
 			scx_schedule_reenq_local(rq, 0);
@@ -3318,6 +3326,9 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	 *
 	 * - A non-IMMED HEAD task can get queued in front of an IMMED task
 	 *   between the IMMED queueing and the subsequent scheduling event.
+	 *
+	 * A blocked IMMED donor may make this scan a no-op. Skipping it does
+	 * not schedule another scan, so avoid separate accounting for it.
 	 */
 	if (unlikely(rq->scx.local_dsq.nr > 1 && rq->scx.nr_immed))
 		scx_schedule_reenq_local(rq, 0);
@@ -3346,6 +3357,11 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 	bool first = type == SNT_PICK;
 	bool can_stop_tick;
 
+	rq->scx.flags &= ~SCX_RQ_PROXY_PICK_PENDING;
+	if (sched_proxy_exec() && p->is_blocked &&
+	    (type == SNT_PICK || type == SNT_REPICK))
+		rq->scx.flags |= SCX_RQ_PROXY_PICK_PENDING;
+
 	if (type == SNT_REPICK)
 		return;
 
@@ -3425,6 +3441,7 @@ void scx_proxy_donor_start(struct rq *rq)
 	struct task_struct *donor = rq->donor;
 
 	lockdep_assert_rq_held(rq);
+	rq->scx.flags &= ~SCX_RQ_PROXY_PICK_PENDING;
 
 	if (donor->sched_class == &ext_sched_class && (donor->scx.flags & SCX_TASK_QUEUED))
 		scx_start_task_running(rq, donor);
@@ -3485,8 +3502,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	bool proxy_put = p->is_blocked && next == rq->idle &&
+			 (rq->scx.flags & SCX_RQ_PROXY_PICK_PENDING);
+	bool proxy_block = p->is_blocked && next == rq->curr &&
+			   (rq->scx.flags & SCX_RQ_PROXY_BLOCKING);
 	bool rescue_keep = false;
 
+	rq->scx.flags &= ~SCX_RQ_PROXY_PICK_PENDING;
+
 	/* see kick_sync_wait_bal_cb() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
@@ -3510,45 +3533,36 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (next != p && (p->scx.flags & SCX_TASK_QUEUED) &&
 	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
 		if (SCX_HAS_OP(sch, stopping))
-			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, !proxy_block);
 
 		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
-		set_task_runnable(rq, p);
+		if (proxy_block)
+			goto switch_class;
 
-		/* Delegate retained donor admission to its owning BPF scheduler. */
-		if (p->is_blocked) {
-			/*
-			 * If the donor is the same and only the mutex owner
-			 * changes, avoid triggering another ops.enqueue(): the
-			 * BPF scheduler has already admitted the donor, so it
-			 * can continue running.
-			 */
-			if (next == p)
-				goto switch_class;
+		set_task_runnable(rq, p);
 
-			if (WARN_ON_ONCE(!sch))
-				goto switch_class;
-			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
-			scx_do_enqueue_task(rq, p, 0, -1);
+		/*
+		 * If the donor is the same and only the mutex owner changes,
+		 * avoid triggering another ops.enqueue(): the BPF scheduler has
+		 * already admitted the donor, so it can continue running.
+		 */
+		if (p->is_blocked && next == p)
 			goto switch_class;
-		}
 
 		/*
-		 * If @p has slice left and is being put, @p is getting
-		 * preempted by a higher priority scheduler class or core-sched
-		 * forcing a different task. Leave it at the head of the local
-		 * DSQ unless it was an IMMED task. IMMED tasks should not
-		 * linger on a busy CPU, reenqueue them to the BPF scheduler.
+		 * If @p has slice left, keep it at the head of the local DSQ.
+		 * An IMMED task instead returns to BPF if it is preempted, but a
+		 * proxy put only drops references before resolving the owner.
 		 *
 		 * An open rescue must keep @p on the local DSQ even if the
 		 * scheduler zeroed the slice in ops.stopping() above.
 		 */
 		if ((p->scx.slice || unlikely(p == scx_rescuee(rq))) &&
 		    !scx_bypassing(sch, cpu_of(rq))) {
-			if (p->scx.flags & SCX_TASK_IMMED) {
+			if ((p->scx.flags & SCX_TASK_IMMED) && !proxy_put) {
 				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
 				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
 			} else {
@@ -3565,6 +3579,9 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 						enq_flags |= SCX_ENQ_HEAD;
 				} else {
 					enq_flags |= SCX_ENQ_HEAD;
+					/* SCX_ENQ_IMMED uses SCX_CAP_ENQ_IMMED, the base cap. */
+					if (proxy_put && (p->scx.flags & SCX_TASK_IMMED))
+						enq_flags |= SCX_ENQ_IMMED;
 				}
 
 				scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0,
@@ -3756,6 +3773,9 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	enum scx_dsp_verdict verdict;
 	struct task_struct *p;
 
+	/* A retry can abandon a provisional blocked-donor pick. */
+	rq->scx.flags &= ~SCX_RQ_PROXY_PICK_PENDING;
+
 	/* see kick_sync_wait_bal_cb() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
@@ -4776,7 +4796,7 @@ void scx_prepare_setscheduler(struct task_struct *p, int policy)
 	lockdep_assert_rq_held(task_rq(p));
 
 	if (scx_enabled() && p->policy != policy && policy == SCHED_EXT)
-		sched_proxy_block_task(task_rq(p), p);
+		scx_block_proxy_donor(task_rq(p), p);
 }
 
 static void process_ddsp_deferred_locals(struct rq *rq)
@@ -4823,9 +4843,9 @@ static void process_ddsp_deferred_locals(struct rq *rq)
  *   rq_is_open() is true.
  *
  * An IMMED task is kept (returns %false) only if it's the first task in the DSQ
- * AND the current task is done — i.e. it will execute immediately. All other
- * IMMED tasks are reenqueued. This means if a non-IMMED task sits at the head,
- * every IMMED task behind it gets reenqueued.
+ * AND the current task is done, so it will execute immediately. Other IMMED
+ * tasks are reenqueued. If a non-IMMED task sits at the head, every IMMED task
+ * behind it gets reenqueued.
  *
  * Reenqueued tasks go through ops.enqueue() with %SCX_ENQ_REENQ |
  * %SCX_TASK_REENQ_IMMED. If the BPF scheduler dispatches back to the same local
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 8dcab02a38ab1..d61eb88ea8d74 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1816,14 +1816,14 @@ enum scx_enq_flags {
 	SCX_ENQ_PREEMPT_LAZY	= 1LLU << 35,
 
 	/*
-	 * Only allowed on local DSQs. Guarantees that the task either gets
-	 * on the CPU immediately and stays on it, or gets reenqueued back
-	 * to the BPF scheduler. It will never linger on a local DSQ or be
-	 * silently put back after preemption.
+	 * Only allowed on local DSQs. Guarantees that an unblocked task either
+	 * gets on the CPU immediately and stays on it, or gets reenqueued back
+	 * to the BPF scheduler. A blocked proxy donor can stay on the local DSQ
+	 * with slice left because its progress depends on its mutex owner.
 	 *
 	 * The protection persists until the next fresh enqueue - it
 	 * survives SAVE/RESTORE cycles, slice extensions and preemption.
-	 * If the task can't stay on the CPU for any reason, it gets
+	 * If an unblocked task can't stay on the CPU for any reason, it gets
 	 * reenqueued back to the BPF scheduler.
 	 *
 	 * Exiting and migration-disabled tasks bypass ops.enqueue() and
@@ -1865,6 +1865,12 @@ enum scx_enq_flags {
 	/*
 	 * The task is blocked on a mutex and is being kept runnable as a proxy
 	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 *
+	 * Blocking on the mutex does not enqueue the task by itself. A donor put
+	 * with slice left stays at the head of the local DSQ, except when an
+	 * IMMED donor is preempted or cannot stay local. It is passed to
+	 * ops.enqueue() when its slice runs out, the IMMED placement cannot be
+	 * kept, or proxy execution moves it to the owner's CPU.
 	 */
 	SCX_ENQ_BLOCKED		= 1LLU << 42,
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fc65296f5c745..d6813eccd7f74 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -793,6 +793,8 @@ enum scx_rq_flags {
 	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
 	SCX_RQ_PROXY_RETRY	= 1 << 9, /* proxy-rejected tasks need retry */
 	SCX_RQ_PROXY_TICK	= 1 << 10, /* proxy execution requires the tick */
+	SCX_RQ_PROXY_PICK_PENDING = 1 << 11, /* blocked donor awaits proxy resolution */
+	SCX_RQ_PROXY_BLOCKING	= 1 << 12, /* donor is being removed for sched change */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_DISPATCH	= 1 << 17,
-- 
2.56.0

