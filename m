Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8F422558
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432752; cv=fail; b=GlVsLnLusBuhvJ9z8ZKq1wkBE9iYepjRNZTaQJVHBUJpjCL0Dt1FjV/LhFZsxYOAp0D/DuY1AG2BL2UPAysCbwj5AkbFXdQP7b661nYxukQI3L9EBu6jcH5YpO/O1vjPG7S/tiHEsn//4DXi/Dv5zXlKzWQEC/PTceq2La85Lss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432752; c=relaxed/simple;
	bh=/I84qNNWdt+BJ3lKW41JehhlnnrtfcTdo1ECUvn1eAg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DksZAsqB1ashYKTI3sVNX0AAoXrJe2NIbwreztWCPTjY4RAn4k/J6E71WE/xc/ZnmrxKtX5MG4k2xY02N6BPx8tChgiKdgC7Zzn8r3w3cpuDtizpTvXRZSeSYRrMdQo+6dRSjYGC1b776I++stzXxNeRs4i6aHsOUDZxDcH+AQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lf7OExcn; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lf7OExcn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deqoV6+xKtg9XjPGEBb1FgORK94FI6CdsTPFdMF1vnurTLTtUiPeQxRQjO5R/GnEPvTX4+3yubIuZo5MbInzwEP190eZ/QCr5rOmNegghMohPAPgBVhiLLTLHy8Zk7o25esj/bqwHMFKe7SN08SwANqT4vibpyoNdVtHJBm4Ud9H6AFk6IbsvDLStomJIbuUFxhtC8mroy13s1G6uVTok5GE3SRtXXtckXPF4jqcxH+xTL87kaKufWZJaduKbqRb7lQGZGk61FsKp+yYmZGBamH98PZgtnC8Lm2CeVDa9SrdBzND8s/m8JBJlyd2OzhHtbOI9zQW9Dw3/Ki3yeNuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSZ6GVR4IQ4Rhib7EO30dNFsQDnTUr09Tth4Ao4/YEI=;
 b=cvtnGNhoXoXsVhn56dMCYd9QBLPWgC5UVJlT4KN5bNezEwsfC2aj6XV3AG8JOdfMgw5l52OKUZ7R42py5d5z5+zGK33aS7SpS9dYcsVFMq3bRDQ+VCrYk1Um2W54OFeplZRmSwIAbaOI9uDqwCyCsZZEk0GQC7btGvXT3Jy7aODpHc1pHcu++nBaKdy78rzOdWxDeYVIW3xtvhnZ2zmhSdpNiOYDREkZ46jwOzKYc81uq1wL5dGfqo79ZBFNrYqZvPBBqcleAngyryRID2jJXDfj1HY//4lcbo1Faj0RZec4MeAktPQ1gDhmNq98toxt7Pfd8mZ9/l1sN5lOoD/Hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSZ6GVR4IQ4Rhib7EO30dNFsQDnTUr09Tth4Ao4/YEI=;
 b=Lf7OExcnKjZsepTaJ/ZPVwEMm2oC7OU6J6GFhP12JE9WzrEUqk8F0LvWVBF7RwHC1ZB9+o+ZhJkkvHiDgH56TyAqAzzWXbqC15hgxkDLM4nQSs3TOdF0EfbmgrJ1osbN99lk1hDINlb++kEH0j12a/bCoARuzuBVaPTvNG9kl/cpxQSrXjWeGvHtJvFGGvqoYmrpKPux0Uy5DOm+7zaKYcCPX264teNC3YxPLojA+FDosnBUNENLHk7Kk+jW+9ox3mWtsSkuvnvRF0IkOA27az9kDcyryuqqseT+Vn3+gTuXA/n7bhHnqyJ+4NWC4NoLYCP6fPOXAmSLnEzj9lQdhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:59:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 13:59:06 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2-fixes] sched_ext: Preserve rq tracking across local DSQ dispatch
Date: Tue,  7 Jul 2026 15:58:54 +0200
Message-ID: <20260707135854.1379730-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd0cca7-65fd-4aaf-d0cd-08dedc2fe7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e5bOThBVzFJsOpaz4/ZS3MqDgdevqS0f5l4q8Y7uBXqZjbyzYbAZaoEcYSOou6h6NO0q2Urxk6bHPoBHdD60GtXZO/KQX8LcXcFEnpgE+VWffhAXe+D6CZja317dqy7Vz9iDg3OUx1sUF9POpTRShPERtpIYP6LXg18WPI/xyFiBkVstNCBozi5mbsNsaUhL8l77yzZInb6toMqal0RKUPW7KtUgEPT9+7ksuzfceMQlnLcZaE1N6P1hOhVJkgQzdzKhcP/UHeT4VLbq2FzMndof684ma8kfAHCV5jul7caXXCex05fQnt2DQTYp7KzkHBg89MjGZCtOAfmHnCVc07VLeroMLbD1JwbNh21sUWfHiL60JoAmPtOJorgk5C6jBKuwTpQir87KUtNhiy9V7Dx5sWM1WXoEQTj0VvTfGAPks67iLlMFPBzN6qY7CRhfSP10qKubognAoj9ZQXZO8biGQqUsUZlzrUmCm6PfkBcDP187NcoHimobcBUXXJkLivV9jED0HhrQVSYixLgrLlgANhEYtMq+lMV5t8XJvdJFceda1Ytc6juvt7rdnBPPvNhNR6zEmZkhdvJR3wSu2qn2R/7dUsRyGrMv/rHvzaz5CJsnMogxdKyN6dRF2dtx8hOfBd+dakiKdyAEe7oJ2tNHRmxfzF+0vkSfPML+XIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sswT4pEEtK77FuMsgtw2JykohOT5OM/Dl9+0/pS2JZ40Op3z/rY/yA34J8rI?=
 =?us-ascii?Q?+KFrxeELTtJaVSmo+WfinyKHhu0UdFQBMGZj70crd+4Wf1ue5Wbq6i8N2Pdu?=
 =?us-ascii?Q?FeMkKlgK61iNBxHa9QVS5uir4MxLWXwjemPPUGEvW1XsmXlbbPASDPYfqX+/?=
 =?us-ascii?Q?wT+kNZQLVpGzml3sjRUlCzPemO5DnCUViwUZTSGcqfDQbW16yrl34o94YKIg?=
 =?us-ascii?Q?rCY2vTRfEBRHxkko8bRVnNkrAWDp9qtOKX1072x1JSxLPA9rGSEzEfZKVcWc?=
 =?us-ascii?Q?KdHb95c6pUsD7vR1vaeguP08UWyG73991MHZtKOLoXMZTrIi/qlYcFnQB6H9?=
 =?us-ascii?Q?QBONVF1JH03Ngh94t8COLN0K/cXqWZeDUFlBQZWXzEDd/VrSJZhqb27kQ/9c?=
 =?us-ascii?Q?GL+dUsrKxCLP45nU4mSnYQcnGIlaMSBhgvhG6spqFA4IlHafYGXlBGZzTeyZ?=
 =?us-ascii?Q?e3eJ5OP7og7Qa0zvCYjdtJq7LMBoWrRAJBImJpuzLEw+GabxLUEt9NaT92NM?=
 =?us-ascii?Q?cF6qDDNuWrFXWBo0Uco7/F2i6dKIcYzyG63upk9VpeHxxtRwlH8+rqnYrC57?=
 =?us-ascii?Q?JuKu1jItR/doQwn5afXwtJDgIuH4cmmJVj1G6EjdjvxGVOjr1rVyav+f+Oy+?=
 =?us-ascii?Q?a01s3M19IL3aWcfQHQINxdi8YJbZJOzL0atgZzfbRo1AaIHtDi+XOxF+ToRF?=
 =?us-ascii?Q?bGyeWeCqsOZtAwTc+e2ZlUidbaoEIhxpwqlVIPNSkQB3rThEO/53Jk6RAv9j?=
 =?us-ascii?Q?lmav6+RrnGWqWyksbbNdFTCgTssv8PCeM/B+kPUyIfkrVb2PVLmFtze2P2SK?=
 =?us-ascii?Q?x3xFGprzNpkN5rt/4D+SUpgC9cBjQP81wp/f/dcEwdrrPBkyLXvsbtje2bKQ?=
 =?us-ascii?Q?PS7wIEnHRxgbIhhpV8jtn8jbsMNLQy/AoOGrnaHq0prNQH+4oKDYhZ2oJ2yb?=
 =?us-ascii?Q?XWvcK36vpE0ViwQGNp1OICKnjwMIjydFo/qKA5zRa4UZalybLIA8vAIIAM68?=
 =?us-ascii?Q?NZQMhp1tWs1syiykjqg2UCV5Y4bAXgC4+uPhdYs0R/VKNXpn+E2XamZJElp6?=
 =?us-ascii?Q?bEFAwQxDfxga8sPqfzSZ4CSdsX1L3wP1TTdHMlGWF7UAdpkhYRSTEN0Ftjpq?=
 =?us-ascii?Q?B1s1aNOJpyo3PyfPQeMbpskbcXIPqafWkxNg4jxPx10UhKXruhF7Q7ZaKCA2?=
 =?us-ascii?Q?6tGMlSL6v+v/n0HSYzYuR76vxB1kMm00CXq/NHjHXOrtgvqRlxQIxosnPKAz?=
 =?us-ascii?Q?FMqYoB8SUQWpyi2zauuktHa36AWnmgP+HPcCbGeKjk3kFhQhCGopEu6tOoLt?=
 =?us-ascii?Q?2Y5M4beLt/SPGjhXsFxI98svuVJB/wnXceQ5QWog6/M/f97m5CF91lU9hdbm?=
 =?us-ascii?Q?lb1jZOg9udbE5UyF4d/9cxYAgOw292tfsZMD3Q1l/O7LgwIt5iIZtaQgRA66?=
 =?us-ascii?Q?xjrQ4Bc9ZSw/P/syAO3xYNrueKqAiJl2E5fRK3D4Qn2soZb9xaZmRU+Tik8j?=
 =?us-ascii?Q?JVWTlC0soPfiTMFGl8mpeJHgS2CtnNytgHKIOBmdRaoh2Tdi6FV4L0icKHsC?=
 =?us-ascii?Q?i1zalrplePlbnv4TVBEMd7S4tStatVaU7tByHsBeYxQQ1I2YRvca1W3xW4tz?=
 =?us-ascii?Q?L2gfExQUL+nwJ4BZcf7z5Vaq87b25R60U/M8PnebOrEHWE+VE2LzqgzhNbYB?=
 =?us-ascii?Q?8aSfT6KyPIOGWKZj0Yvh3JheuvZIyUe3NvQsGz0BPxvHABN37Xd9F91WX8US?=
 =?us-ascii?Q?JT2XwfssNw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd0cca7-65fd-4aaf-d0cd-08dedc2fe7c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:59:06.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPvTAJ6KWeNaQyjOCvqwEob3jTFhXHqYg+9mKgHKmG4h8iiwKjnex7Asyl6p4lWvKo67YjwAR+Q1CJqM9RgeAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348

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
dispatch_to_local_dsq() switched locks, that rq is no longer held and
update_locked_rq() can trigger the following lockdep assertion while
restoring it:

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

Clear the tracked rq before switching locks and restore it only after
reacquiring the original rq.

Fixes: 7fb39e4eb4c3 ("sched_ext: Save and restore scx_locked_rq across SCX_CALL_OP")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b6a635ba269cc..b8a61f7803d5c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2577,6 +2577,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	struct rq *src_rq = task_rq(p);
 	struct rq *dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 	struct rq *locked_rq = rq;
+	struct rq *tracked_rq = scx_locked_rq();
 
 	/*
 	 * We're synchronized against dequeue through DISPATCHING. As @p can't
@@ -2590,6 +2591,16 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		return;
 	}
 
+	/*
+	 * This may be called from an SCX op with @rq recorded as the currently
+	 * locked rq. Clear the tracking while switching rq locks so nested
+	 * callbacks don't restore an rq which isn't locked anymore.
+	 */
+	if (tracked_rq) {
+		WARN_ON_ONCE(tracked_rq != rq);
+		update_locked_rq(NULL);
+	}
+
 	/*
 	 * @p is on a possibly remote @src_rq which we need to lock to move the
 	 * task. If dequeue is in progress, it'd be locking @src_rq and waiting
@@ -2648,6 +2659,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		raw_spin_rq_unlock(locked_rq);
 		raw_spin_rq_lock(rq);
 	}
+	if (tracked_rq)
+		update_locked_rq(tracked_rq);
 }
 
 /**
-- 
2.55.0

