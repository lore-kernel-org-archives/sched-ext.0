Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A183F1653
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672778; cv=fail; b=vADKCw4V+EI5dd2bKwnQoq8ht7QsvX9TZ0K8t1+O7keyHjqXNpoD+D+zNRwzNoiDMovogN7sdpP9zI0a3cDS9VEHUSEBb9XjGfpZJExSOjb4t8lkIGfNOVl7E0+zhxA/BE0/5/pBhYs1sC4cFTLTNr72s7aQFx8Q1BrkkpvYkT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672778; c=relaxed/simple;
	bh=sbqmlEJVngOUyh/4M4RvsvkXh9hMAhDrnG1A2JdZtVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K+6zYsMfeY0ESfY3NaBKaMRt5o0kJSFJw1Zpnnf5CRj7ZQ3y/MNtz9w6fW6emBD5PnSr04a68Q3W9j34aDCQ5BqVdOBixeVllgHKPp0sHYpAOA3TSx9YcdGAexCCgPot3af/X4+T238E1B8cHgD/sLruhLAsZt52NdiXiL2yF+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k6rhFAg1; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k6rhFAg1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxtYOE/JWBlwSEQdkq5vRGJOR8i3KZWPf9ic2tFcS0YaU3lyNMxaGoxAW2pOfITSE1h2m0XkBsiJwR36PPuiWTeq4lOCykTWlEX+v/rSyf2Yu5IlKWxnmyDNnrdPr16diKGwSbza2BECKZrAxSx2dOpfDWDgcprz5SYh1FbYrL6bboQqKpHWK64SJ8aGVKKRUUIwmlMZszkCW3lfZ8jcM9KGWI+2FwXCxV/IEUiLkGBUBjkyzonDpnylGN/8PyeTuon4z2n7JAvnYNfeIcEZ+lI05RYc6xRJ/v/rscKodY+iQNOLTCb6Yop7GWirKCNp+NP292jF8MQLZwVBLvFHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1BXj3F5q/zqtFVa+5u+d1QMzilCWgn9i4xn5aDLyVw=;
 b=QRGAHUxR4jx/MGpdhh4ci1nfmhI/bq4bdSWCE4tzle5fL91/U420r5oDjqNTkGmvIy8jSbTdb8E0ZlEJgXQhW1sbJ1B1fL9ReLlOi2cCroGh/H6FdCm9zT/sn75wsbVcdqeVL/IAHuijEL2fIE3HNkyJ0YYCav6JbJLdshMB88dAxI2VaK6IPvfrXJlXjYjYzM/Gftjbd/bfbZrHblt0t1cuLzv8hMltW8u8hZ4gmg3g50d1+E9zPPuvYPWYI5/MUxDEYvr03tJa3SxqJ+6ZsndvW47mrWutuvNM7tTYzi/JVAwK4Vz/r1dhzCkdLuiGU6q/gQCjmq8AqSjoJKOb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1BXj3F5q/zqtFVa+5u+d1QMzilCWgn9i4xn5aDLyVw=;
 b=k6rhFAg1Tx7CqSvb0uUeIV/7C0gMY9SSEy2exXuh5QiofZ4VptGav6egmZrvl2lRqZ7SWucee+4E2XSvGdAiLW9Sc5wBQB9Rl2YI4x5WiE3i6xD3CD0AguK1lp2GaCIBCzGA++JxepVkT8LXF+d/ATYWtPZTIIcJztBHoupjacMznOnazhaQOZ04ADLlhU3QrmphF0nx+SvJDT4a7eBZYPmvH1RACy/WP92om9YmEdM6Nok2xZFFYshr70njZfVsKD8o+OoHUAmnJ6UFs1Q/SwA4niSYvn2KQWdIVAVKP3iiWB6pA9f9FfeVKxJUqYxAo/aFhvYb1z78obMKW4mljw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:39:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:39:29 +0000
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
Subject: [PATCH 01/10] sched/core: Drop mutex locks before proxy rescheduling
Date: Fri, 10 Jul 2026 10:36:25 +0200
Message-ID: <20260710083913.30573-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710083913.30573-1-arighi@nvidia.com>
References: <20260710083913.30573-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00007537.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: cf663ed6-726e-4c96-baa2-08dede5ec193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fYbR1tOoINzIQmGWkrJP/QYUd2gj4YrFhunNRfo5f+MfbDF65ivqAvjLpjr1Za/ka7GbfP+iM8vWletudYZ+lBcez5GzNQ3/BTpcd4Z9FXCQZYerRC6RgWNfNUJ1t431aC10vyWXe/bRx413/Ezr4zSH5x70TroV84wkuXghblkirYEYQWZiSEUAuNJIPwMUXMHivJ3q4p72IJurFhbyVnkVTuoJDu3IzK6IDMHAyihudP0f6lawXWAyLbVTJpEzq+migpVh1Cb2uNrSV1UrTaJv90csiTs7MTvPLW8o9bx6jSlj5wdXgZHiHid1eAaRy2HEpC8ZO0Fc+aLIucbNZksQkawQwBsE19zYVQN8YvsxheWaFtsoY3QoihGIwC1xYZJg203H6pVHHVmYQ3DWfw6r2Va0RNRTQ1T34aSVR1sNpapBksiC2AIhj5nf1yWtKSqPCoCROcC2rNaJv3mdjwFOfIo3eYQp4/fiK71s5kg3aXKtKOtV/3crwi93CBgXM8743t6zqF+Vf6a3MHkxZksTOQ3wK9Rn8Rf3zlOS5Wyip6GTwzlFnSv+DYwvE7Nlu7r2YsjfJ9VIiCnkTH5d4jTF2WaYMvrHWRKsa2b1AwSrxMrv9InDlTsTAnorK4DQEDw1YOceb/1wBA7V5veOjpklIN8/BJ/It8oOYtcJAoU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RdM41clZABwDK131UzaUkdZFxCKgMan42ui3w1lU71VDGO5Sv1475xfv1Kdt?=
 =?us-ascii?Q?hHRRyDHjvtaf//fQEAEVBJ9IXQRGAM1CCNYgXVkO8h7wfic1fuk9HRiABZ2H?=
 =?us-ascii?Q?6fjBeg88ZrY8OnLCEQcdQxqo22cCJFZgVV8lbSJiYKcJ8PyVGUEwlDly79XD?=
 =?us-ascii?Q?ygslxvEZtXtEFZU/7FcD7KKd2sRi+3/6sRlWqzAA9HhdRwLsXlvovaUhiZDy?=
 =?us-ascii?Q?pn80DVpGunW1nOEtk1hmdIb3x8pPacq6VNZcimqeKl2yxHzQ74tEXYPq7JOR?=
 =?us-ascii?Q?tDhUxh9AQnSBxgREBt7eMfgZU4JScMWSlEUiV34Ps3WqDf58VEWsJ0TTouuu?=
 =?us-ascii?Q?//lhnnrojdkJ3yxzgZCg5G505q7i5O7Rw1LT5o8CzfxRWBOporg1VxOjW4oQ?=
 =?us-ascii?Q?4iXO1FbTyijNVt23ljwom6+hXwMzIZJW3YINPRLsbfrh/ewRaqXPG2sNE58F?=
 =?us-ascii?Q?dJlLt3bK/7moiBu3FnvSb6j960l9D0ooktDlxirT4IB+g1DoI3vQK1zuh8cw?=
 =?us-ascii?Q?F+A41UuYvYYutPFZqTdEIS/dgpPzyPhZdgO+MZgL72fT/7/+JjzUkgbz8pe9?=
 =?us-ascii?Q?BY/isBzsy35ea/yuK2BExqqJJ9t3djyGsg0dYhiNUq430HXWYXAMBKx3P43D?=
 =?us-ascii?Q?s9ZOU0x520lD78WiEtuCF/jmU1Y/DjKx1OZXKG83GuCR926AHI3JenDB9Pa0?=
 =?us-ascii?Q?8YjV4fpFkczE6pO3gv7jUYPBHMO3w5hlifDLcy+kRSX57PUgo5MsaUmJPeVo?=
 =?us-ascii?Q?6T20LQOHxgaa8A72yNmXSHDVF/daPjqhUO7YCPHamBy4AmT3CKgjxIHqAHU2?=
 =?us-ascii?Q?b8KtjaG+1AI9ptS/AJZ8bzAfjlt7ZFYYGvhj3HDcEGzI0zs3aMOk4GRzbNI8?=
 =?us-ascii?Q?iaXU9Zwm9VfwQ4LEn8daEPRJX4zP8t+HxBG/E0cUjsF7FP1OzgehwUgTNADN?=
 =?us-ascii?Q?dzCc6SrEYj9g5r1YeLGanktqnKsuWtPPezupKSjRtCbu8qrdlkfZLt/yKEiq?=
 =?us-ascii?Q?HsK+BIQ1oZRocQYcnzX9UD6Ls5siF4t65SzDuAUMBDY0psESmQVasEMF5H6b?=
 =?us-ascii?Q?39hVt5jDoYFY5IYDn3f47dKio4tds465PZDLWrHhAI0KxHc2M0U+RmmnRyZG?=
 =?us-ascii?Q?0OAjGe914mKZk74uveUBWagPFI92CPH76LdmsQh/z2R4Vgc6z9hWHbhQ0qcl?=
 =?us-ascii?Q?BKqA5+ePezkcVDLlzz9qPChkeH0eOfY4Gd/CNcgFzY6d3ir4X5meplKyXPPi?=
 =?us-ascii?Q?sX7LtAB1zMkzr0WGVfnbCGFgjIKsdDC9qCvX2a6Rhq0aB/ro9RhomiIj9AUt?=
 =?us-ascii?Q?g8FYoCvhPLp56XslwPfopEpaUlLQIpeiatPOLIZEGA4ufF9v3xaMIIiODHYa?=
 =?us-ascii?Q?Iq6q4ZonBWmWYGAymUf410e/wtnoP+4Yp4Nw/WoCWweWl6IspX+x8NjO54YD?=
 =?us-ascii?Q?0HYbPJgocxPFMnDWLRftEplG4AK/nxR0JFHh+gAhFrRL7+ucDT+0NjETeHIM?=
 =?us-ascii?Q?GOB0JEE2ISf64tSWvMfnnVh0vAQY1Q3RO9dDfEixHJ2HrKjRUafPaqKHPGgt?=
 =?us-ascii?Q?42Tmhe8nTmXX5Q0Rbv74DcDjxaYk3L3mc66bHmUG9AVuB49uBvOtjQhWJATx?=
 =?us-ascii?Q?Xc2dSUI4CT1MiSof1H5OcNcTceRdzn8kmu6F6SoojNKcXsF+WH54CS9/1P+h?=
 =?us-ascii?Q?/2iwyRQksOPjOQ7mgjfakc4xSMmm8Ol72lOjqYnpOaptNffSY8q1IrX8cNCt?=
 =?us-ascii?Q?y9/oPcd4OQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf663ed6-726e-4c96-baa2-08dede5ec193
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:39:29.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTSvF2xue/FA0eELlb0gRgB8DKCV+YVYzCvVbRyR5V3jKWHiQtQw8+WKY5Ziju3r1ZqBQt6tu75dze8UWbjxIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

find_proxy_task() can call proxy_resched_idle() while holding a mutex
wait_lock and the blocked task lock. Guard cleanup does not run until
after the return expression is evaluated.

proxy_resched_idle() invokes scheduling-class callbacks through
put_prev_set_next_task(). Calling those callbacks with the mutex locks
held prevents them from safely inspecting the proxy chain, as doing so
may require acquiring the same locks.

This is a preparatory change to support proxy execution in sched_ext. It
leaves the guard scope before calling proxy_resched_idle() so sched_ext
callbacks can safely inspect the proxy chain.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cc6fb1d20547..0139cd4a8be7e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6923,7 +6923,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
 			/* XXX Don't handle blocked owners/delayed dequeue yet */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			__clear_task_blocked_on(p, NULL);
 			goto deactivate;
 		}
@@ -6935,7 +6935,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * and leave that CPU to sort things out.
 			 */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			goto migrate_task;
 		}
 
@@ -6948,7 +6948,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * case we should end up back in find_proxy_task(), this time
 			 * hopefully with all relevant tasks already enqueued.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 
 		/*
@@ -6985,7 +6985,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * So schedule rq->idle so that ttwu_runnable() can get the rq
 			 * lock and mark owner as running.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 		/*
 		 * OK, now we're absolutely sure @owner is on this
@@ -6997,6 +6997,8 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
 
+resched_idle:
+	return proxy_resched_idle(rq);
 deactivate:
 	proxy_deactivate(rq, p);
 	return NULL;
-- 
2.55.0

