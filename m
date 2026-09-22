Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F856E057
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096109; cv=fail; b=iokV6dWT0U+GSx8+zFVToZpPq09G1nSSHJlYoSKd0FlJwk+hQv1/jOk7EcDrvjs4YrEKgFrsYv9wqMay7UzDd7rnQLzxRMA7F1ibJg7WWnsmtwc1vppZ4X+g5xWRXPRkTf2Iy9jbnSSq5RhvzHIpvx6F+twAd6AsHorCuObtIPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096109; c=relaxed/simple;
	bh=yOKmOp3Or/HS2vhS+9KkcX5EOD7oHjCnjUPmqJRf3Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2iD+Hsrd4niMpubicT0hE/0umi4mdspwbFmBZ0pRV8TgYH1cQX5w/h4dKx9odS7q+ffcVvmRTD0Tc+ozKr9UVlpRZgwwDxv2SQVIA4fohb0gBPbWem4dhj7co+mUFrn5Knui1OSkPvQcCJlvS3QDgM/fIkMq+lXs8UIJmKHF9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=anM0JY1y; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="anM0JY1y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2LzNo0mFOHKwzNdFngZEiGbb95Y92NkatcNbPKkErIM2p3RTnMbddWx6ARn2n9+3WKVm7ao/8QY1i8y2yiWwAASRIk9hL7hUFP3rw2LM5FRfrzLLUZt1TYkyPElgz/e2iw9DrNJtFZr4dEJuDLZ3397S3cg8yd0imM5ivjaDqH4jOpWUESujw289T8DBUhVbD00mVHXL0Ny2S3/LgN1OUKpWDUYNDVpOjw+Fh4g3ewRSH+jiIdBlTRUXYHlf1odk10iE6k0YoX3UufmaKJUxoEF2rmN4Q2R/nmOKYRXp48pW2km9gKIdXokGRSVbJDSS4JfkOlDEpBXJIaihjGGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/s8vQ1CQguolT9rXVx5OZSvJCOnuWGtuAYXsfWNeSo=;
 b=Dk5FopscbPMjUAzCNKpb58VEFWjs1+Ob2LMxwifQHLRJvjbyFG+u84ASCHJDo3vhRhjHuruCKGdhxTmgaOY21B0pH08uVjTuaa5RqLERSRcX7jSp1ud9q5arEjnG2VvYK5c7ghfoQEkITsfFkF37Fjv7bsJGzImzYommLp63tK9ackYFi5EN6dF82nCjZTt6gLlK9rcZ6o0PkijEJaV/evaZxoni5qfIv1UPRgNscLdNgA5AC+cQ1ichgJrEkmn8NJpibR6GQ4AsESX/uETkZ9KaQH68USvwzRkf9jN8Ik38n7M6PMb0BmNMeVl866Vr/2w4uhpr7SdplwSmoptMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/s8vQ1CQguolT9rXVx5OZSvJCOnuWGtuAYXsfWNeSo=;
 b=anM0JY1yFuOcBeJvytKiCRsxAnv4FbOD+YQRCWeDTLWJDC9UXmX5ZRgnTbsrqkMp03leN9eW19q4IYWJYm3BSwWMYXg4OkgMMRRxHJY7dkCbvBrkwo4/p9g9fsvB/VFGeFPuWj3AoDRqyRFuH3XYWKnatxEdtjJrrkax5+l4PVbWchoEbLK1aFubWerejCXW/wtnL7xA3jkj/8d/Mr2S0SrDO3r5/XLpdWA8Dsh/xdnecSH/FQsFFNFy1QdyvAIfkPpoBAL4YHtBqdegL1+oiExu2AgTIwYZem+Q8XkKTtg1vVVtfvdgwsrZK7tAJqL3EOc9Pw3APvVRvPVCYMPH3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:55:05 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:04 +0000
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
Subject: [PATCH 03/16] sched/core: Mark wakeups completed through ttwu_runnable()
Date: Tue, 22 Sep 2026 18:51:42 +0200
Message-ID: <20260922165445.943315-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0246.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: e5075d93-1ba5-4255-f621-08df18ca3fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5f9ixNGvO7gOH6HnqDexCEroOxmfVx96kEKEl7q/vKXyzkqtWOF3jjBLTBDSRjAzA/Kt9gtgmc3d2EywyeiIYjBPdbs1rwd4l/asM/v1BiDHRT0rDezfKfvLdAV5oNZmoHM/Jo6a8vsODHkSaifKNlT6wiI+P9YhXXrbT0N6uJferxEnP7/hwxagc12abaSeP+922fR22GsmPF6rUMp33Eu8fWFkOoO0A/0/2EZNktMEGXpJAK0+aDVCdHxnPQxp1OZ09/av2OxKkzto/Qegzq22NPpbYZveDiaAbtslspzV9cp7a6Foc/yEcjjtrti9+eJ0DW+Mfqr7CyOdXswKnyqAFNC8wzpfHVPeFa2ZC1znBU4wavh8ciK9137DvI4yrKnZtsmlUpHvpgz/0x0ZqB85CgnDARp04TJJaTuRZN70fG/OFpUN84LlK8NX49BNSYVibK2LCv1dHH4BwYajfK2EqX3arHN1AcFk7/IO6hMcH6bPKb95qrtkL65yewKDpv8YOYGi9fZpwf/QdbVYmJB6dZSurPCGes9ruOWOfYLXoqKsgY2Uow1323m1L6vpHEn2SbRoO7/HyB3t474wLqMAuB0UuehM7X+U3xbBzRv1SEUAcrTAhrFtc2+T8WoefxSwOu5mkxcyPq7tvbvTQd3sTHpqaBxIj78bIALppOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ohqt6mJPPty2uAdLftVzZbupK2kS1QOsXmQvEidsOeoO62L611gXmj5ymIOE?=
 =?us-ascii?Q?JUIQ+Ev1XvtCpYhy3pu+yGPwJeh1CtDDVNU/0q7gR5oeISm/wiWPIkpuWR/L?=
 =?us-ascii?Q?DerWYF2Cw/dLKTxoD53/eaIAm4e2IiC2dOHRJN2N37/A9CyXOJhfsMqUqwlg?=
 =?us-ascii?Q?sHpzj4K3N/3EmaG/9RlyyOFpxEVDZZ1wilw3Hd3gHCxXnT3JL/6sH37irfPT?=
 =?us-ascii?Q?otbrwrbP+28O3BJlPoXkIGtu8LgJE1G0B+klvYFU3xBRQFKK/eGwgoD1zBDk?=
 =?us-ascii?Q?qKiFQn1FOkYcFm4OANcKTZ0G8oOfTRCKziivYyOZyxnhDTkc+c9sLTeWCbh4?=
 =?us-ascii?Q?mCuQk1Y7iwUr9OQITPr1WPSbLGtZnxBcewGt2KdFDlARPBUBVM/L6nbnmSVs?=
 =?us-ascii?Q?85XokDzSsYJpnYfxGrc2eoOpbg7WElH2JIJTIe570Em7bqTJZaTXvLibpEEr?=
 =?us-ascii?Q?ASsG93c8Z7po14rxyrHmlppami2eM4vR2ansFwRUFM4YkBW92bZ/aqvncwSJ?=
 =?us-ascii?Q?f5Hzo0wJ6sEsSpabSHSEGJYWMReFV3PJ5fgnMNnnkyMzdmQBtvg5J2xnSEd/?=
 =?us-ascii?Q?iDsJyEDmBbuav+Af+Ko1Z2gz1o2xSTRZ4+gEtQDfNqxOjCKdnhNpUgykonk1?=
 =?us-ascii?Q?3NnO00p3uw7lqf6eLahLajycHWLomUuBlEmpXHIQRcQzUVLqXrfDttlHh+FX?=
 =?us-ascii?Q?NpCdHB2HExM/qFIN8pd755GtUL+szOCyzsrkrWSm91LHRzod01r3zEXyp78Y?=
 =?us-ascii?Q?35tc+6kGBc86RR53LNdZcfDZn17uIC85N/HrZejW1T4OedCfOOBw9wLIejAO?=
 =?us-ascii?Q?L3lForrwCeHcpo8//8mWQLp2c4q17ehWFM7NburhpsB7xWYCWIeQgVPMxyuM?=
 =?us-ascii?Q?t8Q7prKurdi2rtrVzTnxbqao8DlsjmLoVMCqtwE73Pxd05kQSc1AJF/xwnv/?=
 =?us-ascii?Q?qHystr+mW77+UMDrqZQQYW7G41nQCtuKEow9hRcm9KRvUjVAsBtSQytOrXZJ?=
 =?us-ascii?Q?E89Uy0xMtNPQkRmLZqA0ldzMHc1Fw9FG0PA45v1Gqz80gbnUNoI3eRanm5xv?=
 =?us-ascii?Q?NTlMSQEH7u/5tVjRhCfx/jLAgeVEOkgXfExWW1Q4zWzGLBk8XRPK0aPHUOHN?=
 =?us-ascii?Q?LEuuh4BZNbR68L+ccVvBD8dtvsf2hbfKgBtIfzE3dwETsEJuZVD0RkNyS6rf?=
 =?us-ascii?Q?cBIToAHHRm4vj5YLDr4IGxW7/v5bT7Tnca0MwNwqFVuPccPhy5XSYHGZVtLC?=
 =?us-ascii?Q?GJjkHSOwxwlaxNyh7cLGQ3SaCOTX+xhbpPRr0zs2o9brVtXntoUIEPCtou1z?=
 =?us-ascii?Q?bHpaCItgkfo77hnSk+mFQ3eTjfRnk5TzQOATL4H1afTKSSsiIsD5mkPuRR1w?=
 =?us-ascii?Q?ps7V0wK+w4ioF4gxkwprPpLnbBwDo/zbQKi+01ZH4kgVMdk0xok1XajPrsrn?=
 =?us-ascii?Q?/FkiJvFM15xPGZbxrUXW7pm4UJHvLH2MLWSH3ebUJ+dHAPWtxGL/6nS4NcEu?=
 =?us-ascii?Q?RYku3QoWmEpJ9swtJijLu45T3xuk8zBSl+xehYvS70KB4KWa06lWeVKRNAzt?=
 =?us-ascii?Q?uB6thQHU+yUZ+iMYLguUCr+yhihCvqFqjr5+cx77W1dlOMAiezgaXiqVhVkS?=
 =?us-ascii?Q?5Iihmb9a6cuI2TizkY9E2RB5HABowe5dg1N9dhYbPOehR8j2WyUC6C0bmtCd?=
 =?us-ascii?Q?h/rIbnJvExLtpL03bcfG1PcUv6/27tXRpSHotsCbsOa1qqNe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5075d93-1ba5-4255-f621-08df18ca3fe0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:04.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kicQKp38YhjikFHsPMv+Xr15+UPjmv7aTe3zelZYBiYnt3KQbmHkyX20rE6j3yaUuR5ZdnhnQw2kRQKuMad/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

ttwu_runnable() completes a wakeup for a task which remains queued
without calling activate_task() or its scheduling-class enqueue
callback. Scheduling classes currently cannot distinguish this path
from wakeups which performed a full activation.

Add WF_TTWU_RQ to identify wakeups completed through ttwu_runnable().
A later sched_ext change uses it to reconsider retained proxy donors
which wake without another ops.enqueue() call.

No functional change.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/sched.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83b220e3a232a..124f0a5220869 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3913,7 +3913,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 		 * When on_rq && !on_cpu the task is preempted, see if
 		 * it should preempt the task that is current now.
 		 */
-		wakeup_preempt(rq, p, wake_flags);
+		wakeup_preempt(rq, p, wake_flags | WF_TTWU_RQ);
 	}
 	ttwu_do_wakeup(p);
 	return 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7701a5a60972c..6801d8e5c1480 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2516,6 +2516,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_MIGRATED		0x20 /* Internal use, task got migrated */
 #define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
 #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
+#define WF_TTWU_RQ		0x100 /* Wakeup completed through ttwu_runnable() */
 
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
 static_assert(WF_FORK == SD_BALANCE_FORK);
-- 
2.55.0

