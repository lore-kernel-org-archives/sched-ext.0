Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEEA5221F1
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183853; cv=fail; b=NWdEjJjYmL1Tk/WdyxjbxYFnssSNO/ycq6Gf32xQF3kc4DXIQ8bwIdgYfuUTOmqV7HensmC/sTgpUiZh4e6tHyn3xQUjf3/8CVWIaIP2qNhBLTOPek84IcobBd6aQUuxgHGkYmmOnJa6CLwE+/BrPfLbOK7COGxYP8BDkHJduJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183853; c=relaxed/simple;
	bh=C+HBXMYQulRRvBCN0D/QX46yO9Vveic+UHSu7lUtqtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHDMGoBTvCy11fkfP0EQFfI5lTGvyCHqJ18xuaYaDMlCI6KHiaZ2C+nGMN0hwHQNkLuQjcxLjHkMWJ+lnefigB0XBMVMQBs07cZ/1ualdCQNMWj5CxfqeLOr6PHT/IhtjSsaSgt3Ik1EMOHQ36mgnUBrdJCMprKXDwq1ba5orK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lnc1IfWH; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lnc1IfWH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO7Qa9fAYb+qFoqDNFQjRxC1E2wrRSAmop2sgdATQXMKgRZjuJ11muXlXDIO+43wOY833gxB1NWST8lVPNU+w+CnplseCgjjOlFCrKCeeXc0DDyLQjGhLaEKbX3ekGFyGoDy9kzKxdQeWQXL68+VQLgmna1CRlGMVEQBrPQu8fsx1RJgEh4KBHHctFun/UzMZGqo+habFcPxbA14W2mE7hl7JANXOipOzjhZAW0o7+55uq0l4C5jSe7KncP4WrN3XGiGoSvYHqvpinfaN9BYUkMO2wOM/ueiJJ5iBrR2R57SzaPPpnsJQuGAKMVRXTccxq9Z8SyAzLIHXPJuidFrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNZHxzmduVJRXJxzV4kGYXkdMWfDHVIKALndi205aiE=;
 b=LuvCGZZ2RJuvrS5GojmKOu5DjIOEImawt0Zao8EjNh1MpzAlbJI+6Qtq7hPmkmVahJXbDUC1292QuvX8wjjV7OaYYU/sNAQy/ZooqphFzSjnCh9DCl7XmugkOTlJyOffwr+iTtTEut6fQfb2Wt3SHwVElb+Pn5JgAZNNL5bnCV/fBhKvQNdJck3+gdp3G4RIhKx4tt7pGXbWkTF+7q0aZ5K4WbWUJZPy5DNtyuHNaEE30n5J27R2O42dzjpph3Nrn2/nAkrXADl3vRRqu7w/vl1NPk1/7c24X7SXdvAVA/ZvnSwCBa0SQPITmBpw7BnK6yaIijZTx5vXq/r6m/0hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNZHxzmduVJRXJxzV4kGYXkdMWfDHVIKALndi205aiE=;
 b=Lnc1IfWH+aDRdPvpet15YNmm8uWkIDzFFuPFkE3bi0ItbTAzbyPoPYa7TNebKN37eTbVHtg/ZSB0hvU99UzAMRhKNhF1tRyT+kKweWetbMvXxLKMckSYewlfK5s9Ch+yqIAdpmDbrVgf/s2a6IcvLiMF/CLQdUZbUGgdsbFioRCewaHaW8MsiEV9woNJpa4xzpQA2cNTnin6dRPZSx8agiVgsA+S61/CQbqq7wPfBff+hDkt37MOV0fGtAg2hwXbiAXJP/dl03qYrH9Fpyt8eadWVGjk6wU4IHRQkWu5ruRqpkulJP/xBWIidhG+E5jkRrSg+WiWxTtT/+mW5sM6QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:43:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:43:57 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] sched/core: Drop mutex locks before proxy rescheduling
Date: Mon, 31 Aug 2026 15:42:11 +0200
Message-ID: <20260831134338.1531664-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 206af4ee-c1ad-4058-68e0-08df0765e820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|10067099003|56012099006|18002099003|22082099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	i+JEDW3zacxYdgSVVC2bADcP84zsP5O7Djfb9mcoZAGjZAYzapjJSgy7doyO4d2G2m3o4/luH9gXjFGDNII7+k61FsbQr7x0DPfXDgknKE/rfpDFXuFjMK8RegdUYY32xTJEDZZlLrBEuGxvVtJo3p+RoQTujpvSImihvfMhHJZjTqPEwPDfTf8+iiEY39fIUM+5JUtSsllXGpAV/QmG/BVN7UFEmCuOUCKtBzR+ES1wT5e2uKVmhT1CSf48zurR+5V2xIbtijp0fDRTNF0PBEC5aMq2JgFbE058uC+xSH6ZBbBWyLZOuGVcCowp1UYPuddsAqpyyMX0DsXk5W2sxtafPlKE4JwaVw9Bx1I3TzzsnkWyXyUQrESnTAusygTu9V/PHcl6lzIHHd6er0utVs91Vby11ubZsl/v9h2j/pmpsq5IIFvMm+78VkYfhQV8cX1kZiHm+qZCRcufIDYTFZCA9JW3owD+41XXn3lMYOItDoB54I0/KvBNLNlXJ7sEnw9ppfk+hu/37ug17VYoqH7e+FAR3eEuXwuhj1//sC5byIi8lXqAIlrb75GRJJFuzHDI0f02Rcfmw0lAR/Wm8ay2NFv+nUTzksduMsXnsiA9Bh8u5Z63WzUjD3GQXnByzdyDG3SxKCj7srYMGL6MF6iMMLTZGI704iux4W8D+1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u7M8gQuZntWeYJs2vrq6Zo3ILbgPH1GknIMfR0GBnkG9IhAssGX3dhbWeT5r?=
 =?us-ascii?Q?NfuVy+bF+ZBCOIADaUZOduyJ8+Kq0MYhF4/9LSrxhiUxCXgOAxM/on4iRsJ6?=
 =?us-ascii?Q?++qnCrfLDDeXiPrBZVv8qaWpweWcpxpPBQ6mfJ8BnlNc8n1RgKhZ3Sx0MOrT?=
 =?us-ascii?Q?x0xO9DmDnl0/qXMPgh/hdrfhn6l7a/DxCSlfBwKIj+/9KkxoxYP4Y35vTSAj?=
 =?us-ascii?Q?JNV5/J9ZwNq1JmGsXIRPnz5vEjY6XiUSUF8osD+UHe6phcACb8exM216End0?=
 =?us-ascii?Q?dsz1ud/a4pCvlWLePp8lYA7UH+tz9DAqeZrW+aVjwZ/G7aLoWOptG+7WSUpF?=
 =?us-ascii?Q?ommROmQ4uY2E37b0w8b1l76xIj6MMbmutCf+7Ix2btPYZFVyn4/WC9EU5T1w?=
 =?us-ascii?Q?ojRN1FKqdWrg1A6K9qDeBx08+Adb6Jnbbb8FcB6lp0tY+Q7tDWfs7hbO//la?=
 =?us-ascii?Q?DBk9phMpbWnhPighSV0Rr8qyibIFYypm4A1h9Lg3dq9hF6BTOuZmUw/6YlNZ?=
 =?us-ascii?Q?T2Ct0vcin4tHwwK3Qann0Co5AdzY3xnv1zXbWNL5ewqluRHEGLp0/JB0Ivev?=
 =?us-ascii?Q?0hynCBrgaH4nE8sbjR3bHPnUQ5X0JzprnwdSHs52VMjtQjPzbq+61U6BZSUe?=
 =?us-ascii?Q?0zq2qtTDqpt+bijDOIVR8BXIRTvqYkUzl6DRuwXR7IMHI3QsSUdp7O2NfF1t?=
 =?us-ascii?Q?td/dI/wpbVdUAy6OlzWDMgb0G+7GBKxgQMRj4zhrabBYGIgjNcjZwt3vZmWZ?=
 =?us-ascii?Q?RnsB70kSc0ZrryhaOySNC5yRNkVPFT6owZJYSRf2ZNzfqzTFpmpSDGG35HGy?=
 =?us-ascii?Q?WIYlhqWQqUkIkWB52sZQ44Dr3FripjAFh/dqpmoVIXC0NPVoVMt6bA8MJHqN?=
 =?us-ascii?Q?ZavzOvOtd0ZnDaJhiHICG60+vEzCDm8al5dZIsseX/uDpGCMl0ARB2dRxBY/?=
 =?us-ascii?Q?tbBmiHn2MR1fRk8RgdTrTqHT+H0KWIKcENi6Re97KVqglkExoN5JC3TrKBQq?=
 =?us-ascii?Q?XqeDTw+EbQj/uIktrU8/NHQy3gudEuIArNFM3k1E51GIW/3dl9oMv47w0PgD?=
 =?us-ascii?Q?7miNyb/Fi0ep/HX2mpou0oYRqLovjFxPSKn+YCkU7N93fx3WZpMuWsBcUhyr?=
 =?us-ascii?Q?9vFrQQNkjFx7f2a3rWA9uTh7OrFlR4Q7Sr42dXQ3ERfNnQyMRlTDHE+jU3YF?=
 =?us-ascii?Q?wGiU0PKMb+UCLC9sUdxNDosIYdUWBHK5hgtTHPqQinOh++KH98aRtVKEYyCG?=
 =?us-ascii?Q?ENw1yaYfuq1ZzunHQdJpk9oRCzmk8PH9Xwa4U20bB4j7q9EgM9Ivs3jVaxFS?=
 =?us-ascii?Q?HIefuuQC1MpfiG5wvVGmatDHrwwqX/fG9x6OFkjUuADe5vcQS8Qgy+XfzuKl?=
 =?us-ascii?Q?gzzBCrGuqb0XnDkF/WvxNfVlXV1VqBEvspqRNhBH33vq+KDe9RjXTE+22eey?=
 =?us-ascii?Q?1ZHwMwsS7O037sQzWFg5Y99PIXHHJWA2QYXBchqqSzEh0EQSreTrJUx7Ucz5?=
 =?us-ascii?Q?fdjN4YBpJ8+t5a3YUEj/GY843GlrXcaf3zq2nFaQom8EQ1XW1aGqS7d9DTgk?=
 =?us-ascii?Q?76O3YE5ej7VRMthw0wC1icO1xjB/K2TRpIdeWY7pLJnzHxOkq3JgFCJhyRiN?=
 =?us-ascii?Q?5WGz5h7MLk20GyFGCCvCik1GMVWSTMnJXL+c0teTaqaqLsbFHeaDlcQ4ookV?=
 =?us-ascii?Q?mcsYh3AI1nlZBg/lOvzbKvtYnhwFeCB9JU1Cels7H8DbC4NRc/BHFhO1mfIH?=
 =?us-ascii?Q?hA1JdNjicw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206af4ee-c1ad-4058-68e0-08df0765e820
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:43:57.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgFzcrKG7KZoRZHrCgtpUvIIWVmcz/66HaMEb9v1hWS38wzHbgEYNZzImvBNkVT+j8u7e+YsBwpphMkQD8tjUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198

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
index f78275192036b..5817d1a4cea2c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6965,7 +6965,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
 			/* XXX Don't handle blocked owners/delayed dequeue yet */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			__clear_task_blocked_on(p, NULL);
 			goto deactivate;
 		}
@@ -6977,7 +6977,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * and leave that CPU to sort things out.
 			 */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			goto migrate_task;
 		}
 
@@ -6990,7 +6990,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * case we should end up back in find_proxy_task(), this time
 			 * hopefully with all relevant tasks already enqueued.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 
 		/*
@@ -7027,7 +7027,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * So schedule rq->idle so that ttwu_runnable() can get the rq
 			 * lock and mark owner as running.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 		/*
 		 * OK, now we're absolutely sure @owner is on this
@@ -7039,6 +7039,8 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
 
+resched_idle:
+	return proxy_resched_idle(rq);
 deactivate:
 	proxy_deactivate(rq, p);
 	return NULL;
-- 
2.55.0

