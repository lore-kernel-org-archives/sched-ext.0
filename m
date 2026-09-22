Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3C56C63E
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096106; cv=fail; b=Sx51DuLkn3z2OTfsTJph0pu27CvkSLaWkT1itGHHyth2Rlfo/N0z0+h78mi3tkBjhrr6bsVCcj8tbfrOLrsXrd+tVRIL/yIfqyFmowGbpI0BC9+l+aiT8SJeuUEuv3Gan22Qxhen1KviJLwaeuMehruxMEiF8SzcfCSdJ+YVyzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096106; c=relaxed/simple;
	bh=Yp6LHnlrryCkdvo8JXnws+6aakEMxrkV7LdcvWujHOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlOizVJxwMLvFNVwzCWjpjlizj6I1LqaBq9M7ytX/8aEnIooNpNflEsC/uHbH32MkAJIZ0LKQqaJDwb+34s+AKA583gXv805vEfzkPopjk/kyQTUWEJ81hypZrnUL7qaFxzHXNYu7dfrUFJYY1YVzpmlum6S3HqZDYZyTV+XLhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JUTM3rZ0; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JUTM3rZ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMyCAyp+bIevy1AViFqoajzxvaY0QiMUzIMm5PQC8AipbtvPC1xsAM2kzm/Ub61OMvae8migD3TKktwG/Myq1ZvyCr34eZ8L2oy1tawl+oEKJ/vc+UBBbXFriACmsALz61GQQjYxYqGKairkJ+fkr5qKeWFw/LmrcKQhdm4uBgxR40CETt7XxnIHZNt9BSeaJl7M05qUxhBGo0/7i5zP/U2zr++0rWDHdLRXcajGlc0Rd7u87j7zHgw8uUK6WUC1KZXX/pRqVTdyn/8mrvnrDrYkAcv7Pb3Y/u29g6avNuhh8CRw44pO1arBg7BxWCcnCdAr3DRbMtcQH4M/WiOoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dOKrBfqq7SO9SYJoMNAM10KZg28qV7ZOTG+MsZtmKk=;
 b=HLOUkUGv0I1AdEyDKwJwHxowcF9c5qkn1ViZnncGZdcSSNREeoEuaY53qNoUntLC8rKn+iBTmbIG8q3IwjydFyfl/lWvBNwI/ZVq3hph0zA+MJZs7AZwyamMRvO0WmfQYLJxQq0QpsbJqseJ4aviBi4GXTfq5pX2mlwKGk+ENPBdm80pCMFA70gEI5MVPyn2kGPxGiI7SBNHD/k7fzr7l9bzantLKSAD89FjN4YwXo53e39o+fUXoHRA7smazcCJIiSnC2Ryf7t9S/eRn9+gJQMwjIMB7ltJ4Zd3G9rx5b7zw+UmkeHneve8C5Ct1Tw22trSP8x/Kt1dI/soLdFEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dOKrBfqq7SO9SYJoMNAM10KZg28qV7ZOTG+MsZtmKk=;
 b=JUTM3rZ0IFyzKFv1iq1qqR3JVpOzza3QbnQ/uMU4R8nLpfz1YRJwyrc6bAyDba/2BaAMq3c6cWgS7xumvNM3mD8PKlU9RvlgEcpdyL+VYcvYcN3ASnlpG0VeSkENLlbIGEEshUjC0zxm/2aQMdNypGkHg8+eUBJ3fYn1mk4VJQxurhDDxh218xv80K7evnEW/VvJuRwdPqv375FhT3x04g3EQWJ/kE3JEhgv3E0ap5F//PrDIuQGOLZgzY7NCR7Nfywzb1LjY4DD55m14ekVA08AtaWxQMHuihtveGVDrZTKYH9c8/8ftJMsb+lsj+BzVHWWdzlrNgdFhFust6GBhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:54:57 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:54:56 +0000
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
Subject: [PATCH 01/16] sched/core: Drop mutex locks before proxy rescheduling
Date: Tue, 22 Sep 2026 18:51:40 +0200
Message-ID: <20260922165445.943315-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0040.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ee08bf-7d7c-47ef-533f-08df18ca3ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|5023799004|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Od+GvpndHNiE1VlP3CjIAM0gFiSMmI6rCqbY5lIVSb4n+pJySfSNfP5aGGJ4vmshDbZprOfoloY2sMhWGE16G8FP+A7Y79qCzXtdFc3xSg0ohlRK18p1O1xRmifuEtYsCZKPzq+P/hSyBRSMGpdJwwLtHz1tzFt+p318uyd54hRAIjvPd/ORJJMv+don2qdl33K6hLMuR+ic4y87lKGdt4MYbC+qRN2U4nnWk4JI+CGODsDvKrDFjcoXMScNoLLF4UqnJElS3undGi9hFKIMIl32ftFEmbiE7/t5yZVam1IMeTmdlc6wlOKqhcpN5LvP/WEc56FtE4U1Z4Uce9yYV5k7IhpHoCtb4yTEKCUSSrGeaTxSIgQO77c9MOpmTU6gqd0siufUsbH+dJeQFvwxDTZQi55R72RnX7QmUzaNmYN0c8+gqF9GFZSgkGE7Rz4UXQpC5FZA4DSSw68e+HJU6LK5RIIYcw7E8wtnfV6lfQ64/FFGpMrYeuiVSj8S1GnjV1MqnSw9WZGLLWmXE0odx8fRsf0GteCizRunPUc9li8c4OLU9JOf2PkyeZTHNCG45rvasgcetgbNJWkfOzISSu6uY+eTmDdCv9OpQHxvfKZsRIMM7EXn9imK1xM4CdZs9QK2/TJ25wOTgtdVyod6WC+g+T+w4FPeoUfkbPfb5lI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(5023799004)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBdZZh3rP/rHYWJOElAPuvZHUOKPW7zMywpwbfZOS9Cl4LBWjm/BRoGHrKJE?=
 =?us-ascii?Q?tRSrDG8uFkYPJhk6CWo1ISeHIN0x77vNkFLA6xgwA0vTOq86Q5qVrVF9BPRq?=
 =?us-ascii?Q?QVirDozVyyPokEUSiN5U/aX8Smp3we01sef1XsFviTmDUi3d2N07VOOKXQ9n?=
 =?us-ascii?Q?pBGF7fM2yRRRbCMP9ROryudbvSukNzlRieJR7gDoaeMz6ryRo+CtRngm40LQ?=
 =?us-ascii?Q?GS0ssJy/y0XTmF39K2A0dH4tQqW3dgzhkzaL8PTLC4THvGp+tQlX55bUgImH?=
 =?us-ascii?Q?I0J8T8pCUX9mtoyz2jxz41IJiOymyzIGsupG84ubrIGF8tFmPxTZ7FM87Rwy?=
 =?us-ascii?Q?9GKWALqfjfNQ9mJfJv5PnAmTXN++ruGQIiPphYvjGbxWBAypsz6QsmLh2/Rj?=
 =?us-ascii?Q?laGctZTGTSyvRecAt/X/NFGMJDsIsUJ7BBS1tifVZdGjGW8/GzUPArzJcdhN?=
 =?us-ascii?Q?e2odfTaS5L6no9GXtJ73ePEUyDhEDGv35fHRtuGjzDiJb9cbNPz7sCHitttM?=
 =?us-ascii?Q?RuQoF8yioqIT5tdMalM/46md+gTSthQFEU69tHlbCS0l50CfCzHShsRml4Nl?=
 =?us-ascii?Q?LRFS5p/UtPsqnLgrOktDOwQ+5nRhOm9aa4DURvnA3IQ8B1pmy1oUu5b/ogZ4?=
 =?us-ascii?Q?w/Ha2EKoO8xT8plcSeZLOaUdRhGZ+GY4lqtp9D9p7SAEO2Tb6AOWZdWFj208?=
 =?us-ascii?Q?pqk54yxO0gV62aWwdGG4pLptU8bbSVkdpgKPLsTR1ra+ciiUKzPlJJvgLpwX?=
 =?us-ascii?Q?joqW4FbImTptY+lt5Qdfz9MuYFlty6vzJ+ZkvUEKS3iL0sY9QPggcRKgmtf+?=
 =?us-ascii?Q?+eBc/BTpu/eIaRScBTe8qyHSx2If3l9n4SHOFLq42yo91w8VhA0R4UEW7Zg3?=
 =?us-ascii?Q?F//f1bRPa+zs/6uXT2h8WJMI0W5CX502KfgjsbQ9kLdbpbX3eic3278n99cK?=
 =?us-ascii?Q?6QBSGlKPTJ6SkvdtUXghqQci0CktoScgBVhZ+nd6RGggSRu02iSKA30naKEv?=
 =?us-ascii?Q?B68OyeRXdYSbjJr/4ztrzpYW4DAiNgOPlbjQB72mxOP3Rtmleu65wzgaMPdK?=
 =?us-ascii?Q?Jqg8DHw3rzdVebn3DRhfEvP9TnBNDmIpr1rB/zl0TeGm0aYtOJvL8Q8t1aoG?=
 =?us-ascii?Q?Sct+PrCF+NdVlkswJYu5ZFV79HVN4SFwa5j2F4XL+9iuCdxxarDkNny4Y46q?=
 =?us-ascii?Q?BNz3g2+Jj4FxYO6AMXaidxmEkKIIYI2hiTlynNbazXCQdq45Ws2oPA4GTC2W?=
 =?us-ascii?Q?6l1xNba4paQI3ExmhkV7HEGLwjWrmTjsZfBcomnb/kpH5hentUscm6T+4bGS?=
 =?us-ascii?Q?xmvJAOWts1hYujWoXowvlUUHWmuLflYrs8Dch3OsMpWJR5RT5b3hYDsHCeOd?=
 =?us-ascii?Q?Rbgay1tJRZXyDxDjFwa00gmVTR2A6l/jEXi0R0Z+TxNYHyjURuid8MPj27hY?=
 =?us-ascii?Q?sJoBEe8xIJFFJnG7rbszp50jFW506YQIrjuHLD95cjA+jTFMNxt3OOM9I2z5?=
 =?us-ascii?Q?YOC4ponnpeG0aMs8NE0mqZ8sSq7wNedmeOthCW7zR1gZ1P4ZSju/4Q8jQDmU?=
 =?us-ascii?Q?GKybI6PB9eQWaeTC9rN9DPJ4DpjxsxxLzK8sSp9E2axWfGIwXW7B5QQvLOmP?=
 =?us-ascii?Q?CRwfJUt1kgy64rJ10Qy/exkqTNr+hMCYw21dEw6hipc5KJRtU8HXkqLveNVr?=
 =?us-ascii?Q?h/an3S7l3YJSZsEJk/X0JkppB2ZS+7b9fhfavt88yGCejZDf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ee08bf-7d7c-47ef-533f-08df18ca3ade
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:54:56.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+BPjNPoAArf/q7BAVB8Oi5WQGbHQ73mqEqJFzGv0O9ZWdkRteob6t6T3ai0FfsfzeK4i8WdT6Ld4qmK44B4xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

find_proxy_task() can call proxy_resched_idle() from return
expressions inside mutex wait_lock and blocked task lock guard scopes.
Return expressions are evaluated before scoped guards are released, so
proxy_resched_idle() invokes scheduling-class callbacks while both raw
spinlocks are held.

Route these cases through a common label outside the guard scopes. The
common label is required because a direct return would evaluate
proxy_resched_idle() before guard cleanup and run the class callbacks
under the proxy-exec locks again.

This is a preparatory change to support proxy execution with sched_ext.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 145eea2d99a1c..3026d01fd7aef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6961,7 +6961,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
 			/* XXX Don't handle blocked owners/delayed dequeue yet */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			__clear_task_blocked_on(p, NULL);
 			goto deactivate;
 		}
@@ -6973,7 +6973,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * and leave that CPU to sort things out.
 			 */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			goto migrate_task;
 		}
 
@@ -6986,7 +6986,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * case we should end up back in find_proxy_task(), this time
 			 * hopefully with all relevant tasks already enqueued.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 
 		/*
@@ -7023,7 +7023,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * So schedule rq->idle so that ttwu_runnable() can get the rq
 			 * lock and mark owner as running.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 		/*
 		 * OK, now we're absolutely sure @owner is on this
@@ -7035,6 +7035,8 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
 
+resched_idle:
+	return proxy_resched_idle(rq);
 deactivate:
 	proxy_deactivate(rq, p);
 	return NULL;
-- 
2.55.0

