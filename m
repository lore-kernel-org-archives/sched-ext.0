Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD21DEFE0
	for <sched-ext@lists.linux.dev>; Sat, 18 Oct 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760796633; cv=fail; b=XPH9yhwJ+T9N3S++WrTIpmSBBMBbmwn9FsVzHsDfqu4f1oLylDdINS2na8GPIvMrn8Uf8Nyoi1Ec1dOfEipruqn76QIimd0WeYOWYlJUKUEGKmEbhLhPesr1/0GgiXNmQWajC/sVPSpHPv4BZxg50/ts2DuIEKBVNo9Bf7P36OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760796633; c=relaxed/simple;
	bh=Ss/0sMeJdC5UND3T95Pldinw8Yx2sUfY9S/N7cx5Mx4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WkwiMsbHJ/exh9Ip/I8HcADG9UNFZpB+kYu5DzGZ4UbGddMn+oXKtDIuG3LQgYV8bkw3ptjmwClWZqYgK8QEShdju6Vfvwjdn2UJA9W2ZJ45XrZfq6C5GQtdNR2GKPOmNv2dAbJxgOUAICsRQ8FaXfH7TbmKakWXB796LA5TTok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h6BbkAoP; arc=fail smtp.client-ip=52.101.57.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h6BbkAoP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIpDMG+xVqeKsTo5PkLAbXVJb4u5nT3m77R8n7zGZz/Ps4PB1qFOlYc90HNANmimvkRMrt5+YQ9SXN2pb0ctiPZoRjrRTKoSAM0Gkt1c3GKli950m/ldZa7fUNRpJ4gts0/HQwz0yeSS6ZfOHookr0ipGIXo5feY4N7aOJTKxSiUnrrSVCh4aKXfkqUq3V4f32bN9FbFbF+a2lZ9eUfnL8gPh3hrzw1Cuqd6m02PSEaa4frpZCXSujNUyQKzF7c9f4OE7SFUltGizK4eBnD1uM+B4srEnztnj41nzXr08KYYT4VQObJQWr2nTzMW0XzQEZlm3x4jGz/4NbExHiyEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TepBbDallWw6fl/9fCfORbqLhV7yA+AK5Rmd/R9OFHA=;
 b=lNDOghb8yBVhiaWBtynLGWs7h52fGMp6/HaigHVLNXf4/DTNyuWKRR/o1wc9SzEsYwI6M6sbWrwYThWt/qgeyhMAOOROYG54jqhbnooV24yBecUZEQoq8acFxMLWYBZvfLIkr7B951vDUwxg2yrbma3NRYgdVty7rqBQdapge8kgcDr7qW5fteUZ/XtuMq+bzDMt+BAdrfIlKSJk6oC6yuGyMmXJXyzT7w1iNIYxbKak5Wk4FZROwTrj2TQpKOiMzjUqjTUDkDHT/rM3dyqIWsjsyQ4CeUbv+M6fm0dWtFuBkzNG2MP8UgzdU83gDN8JwuuBp2P+BExzRKik3iqTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TepBbDallWw6fl/9fCfORbqLhV7yA+AK5Rmd/R9OFHA=;
 b=h6BbkAoPESEbVB3hucN4qId9WF2uSfD1Lmwhl5ptk6t+uqbzcFl7lxfug595c61gqqHa3cUuTh+D83en0XolYfGRj6mj3/dOEGio4mu+bZ4AeJT0Lx0jMTaNIjXKjSTVLZV4gK25C/T7bywVXGCzsaQpzWldvw1FimuiqbxTW0KysNOu1m0grliOFl3QPjwH+z0TNtO5lkGVeDocPtUPhmmoPhyTjr2fOz/A2IAE7r7LGz1QwtCsuNrE/gBAZshTHycj2SN6hth04zq8Ld4Qv/omqzvR5Vn6VGcvRO0h27nY0E3e65GwOXWbDhknIlKj5J9Mxukf1xhzP3OVbAJoTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Sat, 18 Oct
 2025 14:10:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 14:10:25 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext: Allow forcibly picking an scx task
Date: Sat, 18 Oct 2025 16:10:14 +0200
Message-ID: <20251018141014.212571-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.1.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ee969d-cacb-4688-ef52-08de0e5014c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DNNWsZ8a2tOazDxPj/RbfDJsrsXjjYJ9lQsnk41K5p4LBkR0QVM5qgCihe7q?=
 =?us-ascii?Q?G4HvAHjTsXpNp3ZF/Z/EweAbMq+suUfNL7ewpSKq/UEIUTRlV6N6k8he9/v+?=
 =?us-ascii?Q?NlYzUWRd1F8ooeqfTCv/kcLX4tGFyCAq/EwzR2b521zgIE9VkXxkscMpDRuS?=
 =?us-ascii?Q?A6TTR8X+NMlcAB9bStHNeXPa4m0/ETrc4/rTdWgrNA0v168K9hDMM4Pgbid6?=
 =?us-ascii?Q?vskHmgCgQSwQ+yvvf22kkUiHFlwLZHLHE5Srm9isjtRin8xVNUpae1lIM96T?=
 =?us-ascii?Q?12GSWffS5kWO1tVqDKtPO2LTyczBLkeZrfkpjGQ15N0ioLIbFzBP13BW0Yxr?=
 =?us-ascii?Q?R8wz57XUzyQQ2BBUfbDpOFvQ9vNr+NXpy0gFoVKdRGqEcRFBQsI6QsuYXM1b?=
 =?us-ascii?Q?HrcKiDcCigC1KKqOuLY+O+li8t2UOyKw19nRcpHaiJr6Hgv8FcUmHCZRIDyG?=
 =?us-ascii?Q?cQUqfB1O4JHc//nDQQnia+fDzWeseql88Ak+LZXkq7KechcEhq6hkSdniamu?=
 =?us-ascii?Q?XmFfobiC06T/GKd8bu5d5lehsDFqQgrVLCQHSPmUzNtl/Eda+659l+W77xBG?=
 =?us-ascii?Q?IbPyM+fEFcxk2zh1SZqFDkv6F4Oli9ZUrXLYhvFu3CqkvymxqWhB+ZtheH5u?=
 =?us-ascii?Q?ntF/oYRM9yL6C1MWutLMcS91GfMoLMrUR7TgDY7Ro+4wPhXqwSDPoxLHi4Gn?=
 =?us-ascii?Q?kamHpMWKMw43hO9ewt2RCkT/h+lFhB2Y3DjJi/VQ19LEDk+YUJ4GBapF0l1b?=
 =?us-ascii?Q?pbcALg/C+GXbfyBjRQbLMlXMeW3rt0xnpgcd2oBmzWcJz6LXsIlfduk2kmoD?=
 =?us-ascii?Q?cGTxoXr8hSvU99UkYEIupKA5/CAFcCqEGDSjx6iQS0wL21ILPkOkam1a11M5?=
 =?us-ascii?Q?x6wjoYpAfueG7bk0+yPUn256AL9iSW8EjK2p82nBP6CZcX5Txvfd3NvYgaLH?=
 =?us-ascii?Q?iNhnvC120fwuXnpPemzBZ4ii6Dk/ju7r8bCKKPaQHZ5y1f4G+TsMSBqfQBEm?=
 =?us-ascii?Q?TT05p0mbxGtD7lktjvXUEcsdy+AgKxAsb0Q8338BWqQDqHj/wT2WTW6aPFk5?=
 =?us-ascii?Q?48SVyQd3MWOK0efKBq4ZnVyJhGaiCf6koPf93L817K1Qm9FoHyrxB4Jkv+Dt?=
 =?us-ascii?Q?7pEOzxtaPS7tc0HFK9wJap+UU5Dx6h86a9Rzc5EuWiPKFaj5Qpd9NUB/ElJT?=
 =?us-ascii?Q?2QTsFiSjQpKPM9kd0J6/DOBmn6BqJnqrUlPCvg0wA7HCF5S0bwlw/QyJb0VW?=
 =?us-ascii?Q?RVjmpe95s45XRfEj3rvFwtRLfJImxaAnm1cn74eZ7Cx6cRatZiLk/qJHN6Go?=
 =?us-ascii?Q?MkS2aIEgUrsg93dhabr3f6QIug2tT24wgD852DCI2cgQt1tAmqVt9T/aHxRp?=
 =?us-ascii?Q?Er15ebf66mk+bdZ2tMBgLoMr+vR3XIhlIFwukscFxN/drihJTYfenWAO2Mq6?=
 =?us-ascii?Q?iu3C6y4nANhFOaVpG1b6n/rq76Xqxac3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WNB6G9LmS5smYrJjt4SPGTIUhzpT+ecj4KDlwiOvn/9zcPVaUlYuySgk9Fb+?=
 =?us-ascii?Q?jz1MAM6rOxnB6Rafwx9hxdGAHbWARJTNyrHfv90B2jOj1/1Xw2feIqItwlIz?=
 =?us-ascii?Q?38esHG9XN3QZqihjeIy2apTk24hrXcLUybq/ZjlWM71RqS791a3vi3XaK+7G?=
 =?us-ascii?Q?yy+tifit8b7aYxw4gWlh2kP4UWdLYLGEGu7U0UPFrjiKYiHB16fbKW+4DZlc?=
 =?us-ascii?Q?Xetn4vMDiTwGFyyygW0XpB2IpHWxSZhjx2TvF3OoVDD5al5F7VD8m1q0zq3U?=
 =?us-ascii?Q?uaFldb/dNreJWDHeeVNgQcZY4mo3aC9zNUtY8uCfv73UT4NzPIO2OEmsGiNt?=
 =?us-ascii?Q?OdjtUjIwi06LE2GSfYdFHcbkZZTpyKSSaxVitWmyUxf+TydeZ7ZNLBLI4Q7k?=
 =?us-ascii?Q?rpHMjHw9VYezgpBhyXnsuIxDBloi6F+eq1jDx+Zqb3KhxxJQcGu8A4m6wruw?=
 =?us-ascii?Q?7zxYfvBltKbO84mCnZB35G+gIed/VSfMB3Tcumko5Y0d3eezPnSNeTX1lL+q?=
 =?us-ascii?Q?KPadHaAFSa2Jk1Z6UsvXxfulqHo6X3a+QAbT7bf3YntPj+SN5b+rN3oPhyoV?=
 =?us-ascii?Q?OHzZSA8K+7rTzluQcQBTslPtANm6vBevVzcbxyufHTdLrEDaTxULo/yd9oc8?=
 =?us-ascii?Q?qsaAqHbB2cUGOSVcyAwhcb0X3dnlRVcR6r8oTO9Ja1+ZZ0ihSXTzVBwfZohJ?=
 =?us-ascii?Q?fwuhNIytwEmwdtOFiJThWRQZd2goAkkaTJ0Ncof47HHsjV+I4MuFuoipiZJV?=
 =?us-ascii?Q?My3F77rzaNGdn/mw8vwTbZ6pDm9tSt/xK+TsQACpwr3U7zyThVtwR+jW9xUu?=
 =?us-ascii?Q?VodbUKQCjug2Rgc4uKi7r63KNr2FwsHKyNAkNLmVjgpDVY2Pz7zx6g27V+2q?=
 =?us-ascii?Q?Zbwtn85uow8+hb2XdXk441oZBFnpx4P5WVp8MjWwcodS1QSBOyFDpLvMVcyU?=
 =?us-ascii?Q?MqPZg3wWMcA72PnomeVQh8ksCyKoM4nOKqrLniY+zSZNHkxvp2X1k+q8oD2j?=
 =?us-ascii?Q?/M1EwqVVXy7u+nGi0JxaGFsUymUNhCRf/WIrDJSBae+U2GkvF2j1E9sXbRxh?=
 =?us-ascii?Q?eNLdjd21O42uxbpvQ9D9baUHQMHq/HWtn7zcqp5sE5e51T/m9rOILzLSES52?=
 =?us-ascii?Q?CpmV7Pm+BlPJY64e5YMiznVgDtJundNjqHNK2dfxoLpWJf52C+p0bLAxjw/I?=
 =?us-ascii?Q?jTEawFMGYUHtU1EjGYwkr0w2QpkD0GZrOiNP2QSNa7E3FHyic94ScjcDbpD2?=
 =?us-ascii?Q?gMWWb+2W/dTMkvBqLfAfYoSZRcP6d12pUwdHtAkPVd+RLIK9Or+w9t0LEC9D?=
 =?us-ascii?Q?SRiLw+7RuAEx7Jx4kac4ckm5piUzkp7kWhGFINmHorDS59C+4pPb2/7xIRPP?=
 =?us-ascii?Q?7YizNtzYCEnTS5sEYYkw9UHFFaU1a+YdI5B9mG5m9KwZbq+7K+qjQQNNTbCC?=
 =?us-ascii?Q?bXDvjVNrJDL7khweveh6luYRhHv138GExE5wlI4wl7R2L++xV0Akq0EPAtFv?=
 =?us-ascii?Q?jfkyDxtD0+uBDILRstg1ZvWjTIH8LWwR+8S9wMQBi8BMm84u9P5oF3OA0EvR?=
 =?us-ascii?Q?gfZHNq0xK4M9Mi66+i1bJL6dUm1vOIpGex4pMVZt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ee969d-cacb-4688-ef52-08de0e5014c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 14:10:24.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yn8TKRHN05Lsq870WMWTIpO+JOaZo1Yes7hK41khJV5Uv5t4vYlEmSvxjyinCi15ltVghbfu8KjEo5HbsatGFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

Refactor pick_task_scx() adding a new argument to forcibly pick a
SCHED_EXT task, ignoring any higher-priority sched class activity.

This refactoring prepares the code for future scenarios, e.g., allowing
the ext dl_server to force a SCHED_EXT task selection.

No functional changes.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index adff739b396ce..35bc37c7ee199 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2351,7 +2351,8 @@ static struct task_struct *first_local_task(struct rq *rq)
 					struct task_struct, scx.dsq_list.node);
 }
 
-static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
+static struct task_struct *
+do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
 	struct task_struct *prev = rq->curr;
 	bool keep_prev, kick_idle = false;
@@ -2365,7 +2366,15 @@ static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 
 	maybe_queue_balance_callback(rq);
 
-	if (rq_modified_above(rq, &ext_sched_class))
+	/*
+	 * If any higher-priority sched class enqueued a runnable task on
+	 * this rq during balance_one(), abort and return RETRY_TASK, so
+	 * that the scheduler loop can restart.
+	 *
+	 * If @force_scx is true, always try to pick a SCHED_EXT task,
+	 * regardless of any higher-priority sched classes activity.
+	 */
+	if (!force_scx && rq_modified_above(rq, &ext_sched_class))
 		return RETRY_TASK;
 
 	keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
@@ -2408,6 +2417,11 @@ static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 	return p;
 }
 
+static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
+{
+	return do_pick_task_scx(rq, rf, false);
+}
+
 #ifdef CONFIG_SCHED_CORE
 /**
  * scx_prio_less - Task ordering for core-sched
-- 
2.51.1.dirty

