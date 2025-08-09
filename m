Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1362C158B
	for <sched-ext@lists.linux.dev>; Sat,  9 Aug 2025 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765313; cv=fail; b=CS1RadD+YJ4Pwxg0oiNf/GAdqwHXN8z+sCnpR08GAZSJxeps483qyrNg2D1mF1LLB6mes+O/lfyl7CDU8JWBOOj9AV9Zzl+RGOGRoOx6IyKpRXOoy36VGQOWApJoq2Spay7+cKhTyIGBqtQLqnkgxEUYY8aDomgymZXbcg+WsDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765313; c=relaxed/simple;
	bh=/OzvQxs18eSHHmn4oaoaLYLK8emxG0fO0GD0vjQcMOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iv1aITO4oq8RfQ4zAJZNW5bCGYHjFACsCKmCzn8uY2qqMmsmiz8itUeCKKwp92rYN/GklV+NQNiLcx+18TnI60LRq4YpkAeVVOZ7GhRrM8pVKl1A6FNAz8ofGPhli/eM/tj1oJZNF5PN7toyRNb3d3dtfNB/gc6FRNfgu7FmMLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnlvcpK4; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnlvcpK4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKT1g1eCsMazOgvSNLE5OjDDTlmkfMc3dWHw2Aseh+0XnLaxc1X2Bm+twvq4scXFzzQ7LTIrdyrhqu5ZUmCqKjuEC1AxUuys5bQKaJLMGFFLCmCAluqhvUuOZtNKoNFDPhRqOzzBzrUZEpl18Q5DOadkLncvYWai6G1MsXChZuM4dhXsdJpU5Eithvc++fhK8/gk88C+/AFwDeYzRKEZM8r0J6F2r1C+/OFW7UY3O/AQbS30QxG9m7LEpUMV5WtwXNp4GvdPezKgsifjw/XStrcTtJ3qv46JnAOE66/fqXq36Eb7IHpbAsH31arFj5Y6Kf2Tydp78rGqq0jD7akLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLbGcHsCTQY3Cta9c3Kg/oPDXLsocUs+v6HVKWPAefg=;
 b=FqQsSurOQ73vJ60XowqR1k5tB4uFa+ZyDGggHEvDfYFE3j9OqncvAUZRNVJvFMGv776m64hlNU3xTPqZeY5UKsg0l+7N14DGyQ8F/i8nHXgdx4ocnEDsyNlKlzI0i5/kBWOCpzkXZ9U+gvf8c1R2GRJqaSfZiTwfAkuAVvGdFz2VzwvUb+Z2IId/oLUMTkRyAZIt7WMbVe2O2LukydPDJZjhaMk/yPQcugUzDJHSZJjDtolE9kqrKRXlSjIJ+KyeMOOoldIAhXuxBZ4Pdjmgyj+2aaNY4wD+AZKq6+hEQwruka3zDwMWG8LGqeInasgmFnx2Ilw0sDk5rva1GakzgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLbGcHsCTQY3Cta9c3Kg/oPDXLsocUs+v6HVKWPAefg=;
 b=nnlvcpK44lSQC46fmiH5AN29xStULxJbXdlDyFCqevrAj4q7OLksZL+owjA5uQhizoH3IFebFeF+f4VQb3FA8K3WyA7X2xVYKDNY0W2kHf4S+LgDGZZFTk9AWgwTSvShjyMiItgGzaoGzmLwPXOlDALOUOuZKae67G6b+LeRJyWhJkskzmv/oCMBFw1MdWFw3VNfwFH4w0GKTlattsHGqN4goGj5u+0lprbwCF9SeKPvZftOHypp3d21cN1A3OU+4tawBTWBFDWY5RVPROk+0A0VBDe1o646ZZUc5yCaTm7A9dK2Nf47UM9NcUw1Pq8Q/1ESPYVN/IhVgPu9swZD6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:29 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH -rebased 05/15] sched: Add support to pick functions to take rf
Date: Sat,  9 Aug 2025 14:47:50 -0400
Message-Id: <20250809184800.129831-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:256::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: bf29c71f-4a89-4476-6234-08ddd77554c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lgplc2DR5RWqokWIQcCHDMq0FJm2GpELEswZGJMmXde/N+mSkasLz9QY5+Kh?=
 =?us-ascii?Q?VYRi/Ic1bnJQ84ynMvPrMz+hBbLBXf04Hvy4crijL9ai5yHMPceiucSTzNFp?=
 =?us-ascii?Q?rpU+uRFOJ2BiEfKgfLjohtW4eDuE3yklTccq5AoSx76gmq6wZqVbsExtMjvp?=
 =?us-ascii?Q?A833VCB9eINbe/ikkGxjwItwGyM9SBHf7evZF+RUvFfX0MOcF+CjMx8DUK/N?=
 =?us-ascii?Q?jxaRFQLaHXzwJVBKH1tWER5rufEeWZkO4De9r/WeR07JrVg5KqiK6RlGIArn?=
 =?us-ascii?Q?xEa3IEWlblDW9Qktyq6oOP6e8OUn4MNAQhqDg+tTmrVDmxJhFivJqurgspBS?=
 =?us-ascii?Q?yfEXzxACAtR2h6nGLz5Ep/QdcnJO0/NUFIZmwKNG54zPbkd9vyIQiF678DM9?=
 =?us-ascii?Q?QbjhnXNUpgz/D171MaassU2rGZvzGApxEkUYiTYKQgUs1seFZIN0Cc2Wj1tE?=
 =?us-ascii?Q?7b7zpVSsuWIGkZYJiROPlPYDpzAFDv2SwtcY7rHaAMa3d45MPQ7jdWObuJFo?=
 =?us-ascii?Q?7po8J307V9AaMw9gN9S5I7UE1vMgIeTFI5EHsh1J9z0+lBMVxZ9H/yU/fdJl?=
 =?us-ascii?Q?CZFMLtmLatwcME4UmNK9htC6MatJ1Jsn2ct5cmiksi+b1Wahpn9pRMPTljtO?=
 =?us-ascii?Q?qmwkDqOEN+T0NxcQat+eNHOMXSlCqLr50UIQrSgPR41jr5pyWC9Oi9KGHcnu?=
 =?us-ascii?Q?L7bpbJa7LD12Of4Je3RepX4q3tNgHvKeo+smYVXqZ0bzBOa05SrvJ8ppRobe?=
 =?us-ascii?Q?LXK9m4P8K7mk8LSHBtbCjLbwmWiSGausmu/I8UWdCnG/V2H9D9BBbixpIZn+?=
 =?us-ascii?Q?f/OZKGu5i3Z5NubbXIaueWt0cyW0XYFcFiitCIxxVfsLo3iSS/LbRDN0h42x?=
 =?us-ascii?Q?ztTTzWAyriuVKEDbRCtV8089z86dKdGyLvuT/hB17fxduqpa4o++GdKrmUYT?=
 =?us-ascii?Q?obTaL7kKM3HcKgV1XjsVnKdTeHmnjxxrDJ0qTEJpJ2VlMm0DyJPoPRRykhld?=
 =?us-ascii?Q?VViN9/P2msxnrFpHPHmTnpfN3u3V6DmXh6T1oAy7WkmC6pPemkOa8F740iB5?=
 =?us-ascii?Q?mmhb11fHQcPNmyIJTIdu2dsFoqcomw4zxmZKZS+q9iEXmseTcJ4vzxt0LbwX?=
 =?us-ascii?Q?KF4xArr6YeA1p5tRubS5M59AGytTHhUzG43igPcYJIcrl3jYgFsHP1jhTqsr?=
 =?us-ascii?Q?QCl6BJ7JMpDenFISXTqtWCcO4ZVOYHDtZUrFsJszyZ3S8/m2Z3ZyFArtWaID?=
 =?us-ascii?Q?+mPDaTJhEm58PiOE1QGzQ1vbhC4mD5FlaWMBO1LrACGI/U3D9ZIh7XjjWhx8?=
 =?us-ascii?Q?PVOfx+C23TA0pMn5pEp6nuTIbiLKQEZ8bDiMrJ83Uxmxvk5lr5kRo/+5Mv+S?=
 =?us-ascii?Q?d0ymPGAqSGWLfPTUfN/b+Q4wLheOCt8uo8/SRIAM4Umibn+J1JMcl4LKrxuC?=
 =?us-ascii?Q?fDoRhdcd8KrOpHkMIdqBDg9gWGXVm8btmolwhWWE3I85PXXyTO7Zaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lqc6kLxE4g2ba0rfYQDdBUhCwtTWuvF6wflJi4MniRfbY8p7Z8RGaeo1PQWG?=
 =?us-ascii?Q?22ufCAx1Jqphl17l9AaksZsXlARX4g+moTqRZ8DQw3aP2gTaSCsMF1PDGrAD?=
 =?us-ascii?Q?EPa2YToJCuAvXKLcjI+j7I62VybMvzkyh6HoXmIAOxgW6wqPpAi25UrEm0bP?=
 =?us-ascii?Q?U1ftLtHjX0U+YpDUmjhai4O6hRXeHAnYvrLhPPrhXZYA4wBh+APXyf7E40aI?=
 =?us-ascii?Q?hU537VE0idj23t3rQUyTCk9CeHARbvo3OBtPlPhRYPmbUegTpXs6aDLQW0t5?=
 =?us-ascii?Q?0jUwbef3W89GukABnNUXEwNNX6p/iNkRqTpyUmLAqG95PXw4KEiqJow2mmRI?=
 =?us-ascii?Q?7dQLVw35P/ul8v+ViZYNrjxs7lK8bGofAh1y2r4sw2M7Pth+CKM/h6cAAxWJ?=
 =?us-ascii?Q?e/9y24vsGpTnNDxQeX4TL8RUBRuN/cPNhUgl7Y5SSmy7N3/P7jPjFhIwgs2j?=
 =?us-ascii?Q?RhLitrFiE2A7CmPeGcD3iiY8pzIdoEcJtNLrcqlPGS/zC5k/pcZ1iwj2olY5?=
 =?us-ascii?Q?yFvZxjm5GkNrD8V2JiX0fmbZVnQJOcGNEI6Sfu/53rhL7+7t6VvRVXvpJv60?=
 =?us-ascii?Q?A2TbMudrvs7Pg5IVt9rtYwhMtrjc0m78EH7TMRLk6FeUikepcUXdyIHkVNqW?=
 =?us-ascii?Q?PKGwCQaxHoSxeOkHdAZt6kD9RSc2ZQIaGodWQFYFr28bx9x08RQcw/PL2u/F?=
 =?us-ascii?Q?U0M7ge5EOB3uqOSbkNWoCiVi+jmBqGBw9nh7UAeT/4PUa3WKAtyrwdfDIZ2x?=
 =?us-ascii?Q?5Sleslj7lamGHQOnDZ8DFU4GtpwWtd1R0ZDrlB2ydu8wZokwcyp4sNm79ZM/?=
 =?us-ascii?Q?gOIBYDJZTNzZVoPAA3SvVPD88oUv3rMe5ehamvpgbnLurRc/wm1l4y6jGCjn?=
 =?us-ascii?Q?h9nuoWDc/BYs/BEjbzKgHtVMzGBxYBUTgmWgHYcfaDZ8AlFCdJRzEjpWRWHx?=
 =?us-ascii?Q?LqkLtnIOQ/qqdkFpqyLwPrV4tZBc1gbF8l1a+Luai3kkGv39WA/i3N+1XiEK?=
 =?us-ascii?Q?NAKBopzY3lWe0uPePZF7z9qP0CNmL4MMmxDihHsqW0hAgBlvxV1chpqzVE5z?=
 =?us-ascii?Q?o1bmpflFloKwPcyDfsJKvhRjlmLHc2uZZ9p+t7OLJVAuqZ3EMWpP+VHfxMMN?=
 =?us-ascii?Q?FAnSw890iLjBpfRYQ0m7j/QgmcJzDFibQO8VJjnoHb9x9uVhvQOJG05SNGrF?=
 =?us-ascii?Q?LgU+K+44USkmPJLU1pzH/pDbntzxIo0R9PCuSRlY09w/6fzr81I2E55pWLcJ?=
 =?us-ascii?Q?d3j7rpfxWAOgYwF0CcJB8JpFxAXpw8eBe33KzYusRe4/+knmb1hkeyja2ICz?=
 =?us-ascii?Q?cr1FE7jqPSquVgmBrzSRiJl9RuH37dI/2HWzKXtHSKAnLkRSGpyR6l983P7W?=
 =?us-ascii?Q?ZhgEdxlQ+EHGEKTDFlHl7eg4FeTCh2UtlhYC+xZyNjGgaPp9MlwUMoh5YlpQ?=
 =?us-ascii?Q?3euLJZt12AWSl1HrpADINWCS3dyfw8/syNqfcJgMbg8eaqYS8n90W1ufDmCk?=
 =?us-ascii?Q?CsYFisLevbYOMWF3OEL8XneUJjrTBFFsCrUgO/TvMIwSgGBTY4/dlAQAbGxk?=
 =?us-ascii?Q?jpf4uCUncOBtYOZJIhW+elvSTFG9eSfIG4yBdsay?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf29c71f-4a89-4476-6234-08ddd77554c8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:29.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+rn62gpP7s64gQgr30V7OSf8B+U6n/tRx5SjGA25umzjNviFWpiu/LNYv1vA/YRoCumwytCjE//ikdFV8tAIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

Some pick functions like the internal pick_next_task_fair() already take
rf but some others dont. We need this for scx's server pick function.
Prepare for this by having pick functions accept it.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/sched.h    |  2 +-
 kernel/sched/core.c      | 16 ++++++++--------
 kernel/sched/deadline.c  |  8 ++++----
 kernel/sched/ext.c       |  2 +-
 kernel/sched/fair.c      | 13 ++++++++-----
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  2 +-
 kernel/sched/sched.h     | 10 ++++++----
 kernel/sched/stop_task.c |  2 +-
 9 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2b272382673d..4ce4434e7c4f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -635,7 +635,7 @@ struct sched_rt_entity {
 } __randomize_layout;
 
 typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
-typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *, void *);
 
 struct sched_dl_entity {
 	struct rb_node			rb_node;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..f3a26d13b926 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6004,7 +6004,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
-			p = pick_task_idle(rq);
+			p = pick_task_idle(rq, rf);
 			put_prev_set_next_task(rq, prev, p);
 		}
 
@@ -6016,11 +6016,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	for_each_active_class(class) {
 		if (class->pick_next_task) {
-			p = class->pick_next_task(rq, prev);
+			p = class->pick_next_task(rq, prev, rf);
 			if (p)
 				return p;
 		} else {
-			p = class->pick_task(rq);
+			p = class->pick_task(rq, rf);
 			if (p) {
 				put_prev_set_next_task(rq, prev, p);
 				return p;
@@ -6050,7 +6050,7 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
-static inline struct task_struct *pick_task(struct rq *rq)
+static inline struct task_struct *pick_task(struct rq *rq, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -6058,7 +6058,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	rq->dl_server = NULL;
 
 	for_each_active_class(class) {
-		p = class->pick_task(rq);
+		p = class->pick_task(rq, rf);
 		if (p)
 			return p;
 	}
@@ -6158,7 +6158,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		next = pick_task(rq);
+		next = pick_task(rq, rf);
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
 			rq->core_dl_server = NULL;
@@ -6189,7 +6189,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
 
-		rq_i->core_pick = p = pick_task(rq_i);
+		rq_i->core_pick = p = pick_task(rq_i, rf);
 		rq_i->core_dl_server = rq_i->dl_server;
 
 		if (!max || prio_less(max, p, fi_before))
@@ -6211,7 +6211,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			if (cookie)
 				p = sched_core_find(rq_i, cookie);
 			if (!p)
-				p = idle_sched_class.pick_task(rq_i);
+				p = idle_sched_class.pick_task(rq_i, rf);
 		}
 
 		rq_i->core_pick = p;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 753e50b1e86f..7baf2ff11587 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2377,7 +2377,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
  * __pick_next_task_dl - Helper to pick the next -deadline task to run.
  * @rq: The runqueue to pick the next task from.
  */
-static struct task_struct *__pick_task_dl(struct rq *rq)
+static struct task_struct *__pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2391,7 +2391,7 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		p = dl_se->server_pick_task(dl_se);
+		p = dl_se->server_pick_task(dl_se, rf);
 		if (!p) {
 			if (!dl_server_stopped(dl_se)) {
 				dl_se->dl_yielded = 1;
@@ -2407,9 +2407,9 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	return p;
 }
 
-static struct task_struct *pick_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
-	return __pick_task_dl(rq);
+	return __pick_task_dl(rq, rf);
 }
 
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fedc0dcb8b38..f6a55cb823d8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3395,7 +3395,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 					struct task_struct, scx.dsq_list.node);
 }
 
-static struct task_struct *pick_task_scx(struct rq *rq)
+static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..2c44354b0ed0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8737,7 +8737,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	resched_curr_lazy(rq);
 }
 
-static struct task_struct *pick_task_fair(struct rq *rq)
+static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
@@ -8775,7 +8775,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	int new_tasks;
 
 again:
-	p = pick_task_fair(rq);
+	p = pick_task_fair(rq, rf);
 	if (!p)
 		goto idle;
 	se = &p->se;
@@ -8854,7 +8854,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	return NULL;
 }
 
-static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev)
+static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev,
+						 struct rq_flags *rf)
 {
 	return pick_next_task_fair(rq, prev, NULL);
 }
@@ -8864,9 +8865,11 @@ static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 	return !!dl_se->rq->cfs.nr_queued;
 }
 
-static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
+static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se, void *flags)
 {
-	return pick_task_fair(dl_se->rq);
+	struct rq_flags *rf = flags;
+
+	return pick_task_fair(dl_se->rq, rf);
 }
 
 void fair_server_init(struct rq *rq)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c39b089d4f09..6c6cc82ac2c4 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -466,7 +466,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	next->se.exec_start = rq_clock_task(rq);
 }
 
-struct task_struct *pick_task_idle(struct rq *rq)
+struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf)
 {
 	scx_update_idle(rq, true, false);
 	return rq->idle;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d4333731..145a91ae611f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1695,7 +1695,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *p;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..0175946568a2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2380,7 +2380,7 @@ struct sched_class {
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-	struct task_struct *(*pick_task)(struct rq *rq);
+	struct task_struct *(*pick_task)(struct rq *rq, struct rq_flags *rf);
 	/*
 	 * Optional! When implemented pick_next_task() should be equivalent to:
 	 *
@@ -2390,7 +2390,8 @@ struct sched_class {
 	 *       set_next_task_first(next);
 	 *   }
 	 */
-	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
+	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev,
+					      struct rq_flags *rf);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
@@ -2550,8 +2551,9 @@ static inline bool sched_fair_runnable(struct rq *rq)
 	return rq->cfs.nr_queued > 0;
 }
 
-extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_task_idle(struct rq *rq);
+extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev,
+					       struct rq_flags *rf);
+extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 2d4e279f05ee..5de508f9550b 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -32,7 +32,7 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq, struct rq_flags *rf)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;
-- 
2.34.1

