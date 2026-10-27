Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793074580;
	b=DHi7gpy3ODuB/KOw7fGpo4khdq//QOeB7MxS9i0K2jEun6r8/0MyOViXSNpGo8Cz7uCr
	 BSm9O+sSuF3QD79aCo1SSFTDPtF0c8fFhMfujFq18KftFvOiNyj0XCP7OBtqoW9/SOQmZ
	 7aff4PY97NzO+9ik32uDLTgvWohJxy/CL3fJGmdl4HRUKvFAKfnEsKvflccxOmUuR6Dii
	 nl/WXEpfqz4x56lVKxBUai7lEPbJLuk5mv9bCXiQUvlz/Mk+2RNlP0+140n7g/ikz5xIl
	 UHvSCplv8ur3WZF1Z5Y1jpazguqpGm0Fj+QMCINry51JPoXjEy/l72gKZXwBy6gROlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074580;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=g0Mt/5WdaaduaaoQsSlOobTC5KNDbA9S82ZT9vDcMFI=;
	b=ccFUkmwOOOVAa+HQW80r+WMMmRZeUYTpOulDze7o/dPkP3k0QVpN6A1w0CCGucWECkvx
	 wOGfBXa55Bq24IL3gwvLAXlyYo3aF4YmkQdKkmt7ALw1ZMYc2VK1wv9iVpscqsuJOMazs
	 skGK+3cD3b7yVLrbqe2LlrDgKwS5xltcair83Rmqo18Y77xtYiwlKAAvMYL2OkFlkJfCV
	 JqayJCIZQhILSy7bHNoDlIFAoqF97+nzHg95uO7So08ydUPRqRvLKeNKgBI9Vx6+Wr3MW
	 m3ciDlXEESTLqI6P5/jbQxfy9cl0ABnKbo1D3AqkSmDr7ezKjkbqvJj/j4NJS/p3d4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jN6RkHy7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A49606A324
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 04:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24A49606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jN6RkHy7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrZZsA8vP8bGo6kzr++rvF+efBS00p5niCqQzAdlBIqk1DUyCmEWKRgSgVwcG8ScxCxS8EXbqKTsGjPNryQqilGt7C3S9LCEpeV7mb1n5kejsxMI1JAjjRdZkqNyMOKSFsOXqiobxrG5IOoPWVhDmNKaw2bV6x4RJ/1nPKhaOrVcFZwHbTJyFXei1q5tIaTvParEEIB270/DfT4IRYXUaRFRj/CKpGYuPsvEDSyc2IULtmKk6YEra22MJQuQekO98emJSx3M/LuqvoIUcKZpTgEt84jgyfkzgpjXa3zU8QBK5TjNaeJjFJSSJhP3mFl9QBwWw4A/WguuVegHxY/gfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Mt/5WdaaduaaoQsSlOobTC5KNDbA9S82ZT9vDcMFI=;
 b=Ai+K/x2bwX6SMmlSFsd57Dej+D4dwlMBmATLvseEsnH1l13i4QUKve1xqu6JrJV3X/uxQQruIgQNeGn7qHxGLpms2WWkzVKNm1NGdZspJj2disNgAoAmEVuE7+Y5MaEsWKw298McMrTx+3SEYQrg8VmaGr8hVKl5T7vzH+sN3f2X3UfkK2eFG+FdH1xFmN9jzPaHBcZGwbGCKIfsrsctM/FDjfkKAJFP5zhEFVvvuUPYPgqnwCHTLY3DuFaEKGr/1Ww4VCswuChlwGumZ5QKRdUvD/oeeXMPfWapSu6gxUHl/KL7wzX0dzylOc8cn7INTrgAUgfOayIBfs5j/VJrmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0Mt/5WdaaduaaoQsSlOobTC5KNDbA9S82ZT9vDcMFI=;
 b=jN6RkHy7qL11yv0OJ/bLzDEi909wpGQX66v7QmYQoctNG5qONoy5z/gBxY3y2iOePQeBkHE615URD6KqEwjytMDFFlJt6Zus3NmeZEdM07hhFMZqHPnaae/8GtNxlpExbkJoR/SvfI/aRMv7GZ7vjurrnTSgCv78Lt2QCtB/tD1d9NbEgmFeAzs2dBJmCcbuUGBGjFcogSBWxV2dDwiWsx8eEwWXlWwSoZK3IKiN3aI0qawbGzyAYEwVJ5ooiXAq7alg38tMte9sorHhVBrr6B3kU/7huZ4+sTfFg3+9EfEfWUfj2ovA3I9BDmznUF4ddQSOtcDaJxSCz4s7/oDM/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY0PR12MB825472.namprd12.prod.outlook.com (2603:10b6:930:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:15:58 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:15:58 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
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
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>,
	David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] sched/numa: Leave the placement of a BPF-scheduled task to its scheduler
Date: Tue, 27 Oct 2026 05:13:31 +0100
Message-ID: <20261027041536.3317971-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027041536.3317971-1-arighi@nvidia.com>
References: <20261027041536.3317971-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0156.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::6) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY0PR12MB825472:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd6ab83-660c-49e1-c74e-08df33e100ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	blR9E5lH+Cmk6xbYUijLzV4tFZgagcxHxAzsFiywTWA20+bsxuoyiJfFmpQDnVYxOTcmbWTaCD3VoNdsM0hVkhWd4HqoRYx7E8fjHy9F5gSbZr4pDHJIy+Zx0XfklcSiksfKSJgFEuIoRNk4CA1/XZcxoX6mufoIg0Bfwn1lxpN7DVDRJ1z8WP5BuK62csKLEhf4rR1r7CeYMlwj080aL7THadJdqL1punOWhOc727Hd/WAcodf7WXqg4mdW3pgEh55Of9Giwqi4Qbr0FsLFDNlR3pYZIgIQOK6yKwehHWRDPLNfFwhedwfWzWQoFTeCs704jUjSe365I5mkP+GYL/1TlVendcKRH9Ioz3JEhHQtx9ff7Gm7rkc+YldrkDw2KLBOhFXz5rnJPtUHq/SSo0T+O6csHJin5V4QmvVOgh/8ko4d+u0yoCd/lI5u8yypvWJpm6D/FZd5A94hR8g3w/xWLoU/4yezwz2VXYfPgstFDTjOvx6GMfehImlJY9T8z1mRATL9aQz5kJ/zErSYl0+39IHbWNzQekVo4/aMPo++O8C+mZyyil6l/VcYJ/654q+RC4YzkrMracQhuE6ApWKp3Yb9u/EXh4h59g5/PBkaLAU5VnSPqH0SEbG1P2jftg6Ni1hCvpgLoepsScXEC/hoAQw4vGmZ6EU7TKh3hzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBLVTOmM21z0omksNgjOfHqEwmZsh40VeCr/5AyXqXY7IqqbBFUuf0O1/njj?=
 =?us-ascii?Q?MdKrW2ZkWBSCbVbjB6T/L7FaXPM6AeRhjuANPqskSRKdQrOe+cNdQI6yRnql?=
 =?us-ascii?Q?qrkKvCX03vuF+nBfYAB2SrjANM1xohYqnCXE+crLqVE/RqKLlayUxsMU55CB?=
 =?us-ascii?Q?H2UeAn6DI9Q6CbdVKSbcq6WqrhE2g8RiR85v6uT3DRBYcRIwPkVMfZxcey2W?=
 =?us-ascii?Q?3jraA8VoG5CujFP75I8/isjoinwymFcu/bESPyvovietJN9wOPzEaaaHFOo5?=
 =?us-ascii?Q?+c+Hs57/f3TV89BWYyhS/8s/MniYgrmd0aDDtu5GwDBM/NXzJriKdyd35tWs?=
 =?us-ascii?Q?ZXAk5V4yPJdfAqbc16OOOeLL/DGytTuVtRk0uYO4OoMdMZfeUTOf3froy+Uw?=
 =?us-ascii?Q?Duq4ALmVb9tIpsVuWOblbMO3LgOB/q1qIp3shlg1Mu+HGO/K79JLfDa9YygB?=
 =?us-ascii?Q?I/MRuvwp841PHsoXW2sbr7BUQcLzSAIhHVtbGY4mnvgIHOiedA38GWrMZVCm?=
 =?us-ascii?Q?XAexFm9LMOTbqkLWRD2g4FCWBDqJyRtM8oxGX7KIn6CmU+UNhldH1d/02qTn?=
 =?us-ascii?Q?T4F23+qE6e98O3eo/SlE5mCcFE8MvEADkXVAk0aDld/HrouuCCDiitCFpNyZ?=
 =?us-ascii?Q?UPM+8Wh7DrD7vdU8t2a0gArjASlsOZn73kTeK4hEUpE0M0u5miwz9V5/XwrT?=
 =?us-ascii?Q?EVg4AmT/niPt3qo3uv474hYmHNRzhrJOMmKMv8U83AAT/4YkUEli8LSOcisF?=
 =?us-ascii?Q?Fj76EgXrCCKQ+UrtZ5u12nP3JruEMaPZqwnLtjPOvvrrpAi9mZSNxUZQI2fG?=
 =?us-ascii?Q?9kAZYrbuZLLgYsc8SdUHpGFjDzz0jCHTaNgjDnTkC97jqDVZryKtzI3kxmkT?=
 =?us-ascii?Q?jgIxljLVgvT2wwA+oI6wpYvCNyp1k42cioCZGSgP++ZMem3J8G/JjBnin7Xm?=
 =?us-ascii?Q?ZoxNO5r+ZJIBxFXt/8Of773zTl5P6Y7Ag+5HrBdxRMwBcpz2SJsWrMNYujhK?=
 =?us-ascii?Q?mxKkbiEO3+YqmNbiufX3x7kKEo00eAXbBbpLTmta0ZYO0rn/Q/GDd4Cybk9V?=
 =?us-ascii?Q?fmoDAVeIuNYXaLhs6ZUrEv2DUOIeaaIyPbvdU5+0qfJNTEcXyC7B2qhbz1tR?=
 =?us-ascii?Q?U7AgsU5Ac5TAzBHwas0EOiO0E+XbMm7ih4seH5SFEy/Mfe1C+jwM9U03H8y5?=
 =?us-ascii?Q?hwegz1Tw/NQ+WhKQwKAjdDJJ32hPCpIT5xfEmeAz5GVO+soBWxrfqrxamEEx?=
 =?us-ascii?Q?MFq62ucoDJkzc3U8pSux+v0gIAbtpCxAyBZ5CVBlFDNNspDeP6B/ieBUbgrZ?=
 =?us-ascii?Q?8rrPbiIs9l864StMfv95T5c+PrCTP0st/vl7alUGY0TbDOxnQFjUElOT5EUD?=
 =?us-ascii?Q?mtmvkw2K4Tz0nY7BWlrEVUNE22/cXa4r70s77Kk5oLLswOYlzd7DJpWY3t5c?=
 =?us-ascii?Q?vU6Gw/bq2RklzyFX05Ut5eNsVKTpYlxMYB84yu9hh4U0IQvCbEQ26c9fqe67?=
 =?us-ascii?Q?Gqy08muy60l9Jc/FayZ/CUmV041XsltWVCgLeHh3Bfl6dATyv7VPZDcOLLaW?=
 =?us-ascii?Q?lpeT1GYFKiih8czGInZOy6/uObstSg3GiPxX17xhQpiSQQtTnb9aFYWgZbGi?=
 =?us-ascii?Q?StHFQRamfAmcXEscLDzLJSagaooUORsyDhBppHykD6jar6ZhZax48ksIPxrz?=
 =?us-ascii?Q?g57OVU602JxSzk78ycIzaRgtoPc9mjWOh6scQVwh3jUbkf0J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd6ab83-660c-49e1-c74e-08df33e100ea
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:15:58.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv5bSifJ/KtowJaNRS6NkTOfd1+a9uLREO/SInNq1OWvlQDBPT0Kjah/9SrV3KpgkEio9pUg4GRRLk8WooHLcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB825472

A task under a BPF scheduler can take NUMA hinting faults via
task_numa_fault() and then reach numa_migrate_preferred(), which may
migrate the task to its preferred node through task_numa_migrate().

The migration of such a task should always be driven by its BPF
scheduler, which owns the placement of its tasks.

Keep collecting the statistics, which is what makes
p->numa_preferred_nid worth reading, but skip the migration for a task
owned by a BPF scheduler. The scheduler can read the preferred node and
decide for itself whether moving the task is worth the cost.

For the same reason, never pick a task owned by a BPF scheduler as the
swap partner of another task that NUMA balancing migrates, e.g., a fair
task when the BPF scheduler runs in partial mode. Such a task is
treated like a kthread on the destination CPU: the migrating task can
still move there alone, but the BPF-scheduled task is left in place.

Reported-by: Vladimir Vdovin <deliran@verdict.gg>
Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/fair.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 36df9a4dde534..5064c7b707f4d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3267,8 +3267,13 @@ static bool task_numa_compare(struct task_numa_env *env,
 
 	rcu_read_lock();
 	cur = rcu_dereference_all(dst_rq->curr);
+	/*
+	 * Never pick a task under a BPF scheduler as the swap partner: its
+	 * placement is left to that scheduler, see numa_migrate_preferred().
+	 * Moving the faulting task alone to the destination is still allowed.
+	 */
 	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
-		    !cur->mm))
+		    !cur->mm || task_on_scx(cur)))
 		cur = NULL;
 
 	/*
@@ -3645,6 +3650,14 @@ static void numa_migrate_preferred(struct task_struct *p)
 	if (task_node(p) == p->numa_preferred_nid)
 		return;
 
+	/*
+	 * A task under a BPF scheduler is placed by that scheduler. Keep the
+	 * statistics coming, which is what makes p->numa_preferred_nid worth
+	 * reading, but leave the placement alone.
+	 */
+	if (task_on_scx(p))
+		return;
+
 	/* Otherwise, try migrate to a CPU on the preferred node */
 	task_numa_migrate(p);
 }
-- 
2.56.0

