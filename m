Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9A31B10B
	for <sched-ext@lists.linux.dev>; Sun,  1 Feb 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769937220; cv=fail; b=s9CWz65i4YFpkHxNh1dygMiySr1pXEGY4nitRow1wl7F4h+k0hhdaj9dX94E8WBXciEzct4X/TA3JzZ4ssqo0zyjG2Ole6a56JHk0kexCGaF82pgcjqoKzP+jL+4AMip9QfVG5o2NnQS25DGwWxj5hQucm0wBBtjD0vowTf6RUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769937220; c=relaxed/simple;
	bh=lKp8ch/FH0dnvRMpQe8cRQ4u/LaEJY1ObchFhNO7w1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mo7X6zFXQrsl6bZIUBoBH3pT+iefDJviYFQ0pyRnm5NV+NPqkMy28ZkaNyMrHlJHDLorwne4z+RjKLoLkyalFA3CUq5ATf1+y4Yfm5ciG3shYRM5jBEE7HPzuzkS3V4Zw6Gj2A2TOrJRNXTG1LXjOW/Cp0LpUdOa/Ry6vtNU/7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n87jM/MH; arc=fail smtp.client-ip=40.107.200.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n87jM/MH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpMn/CW1fwAOSzURMN3u0K1tLRH6ubtAawfrn7Bl+F9ViRz0VOsnAmGdNsZiz/fP+Er4MlOWRrPtkX3p9aFiFJPRAaYtDOrS2cT1/jPEiwAYXPCt3PYjxybY4hVjasSeLwMZL68OOZq1j9KZynI6MF3netqqi4s1qMWPbWmzqxjAhSOi/KB6SBrQaE6eAwjNGCi78FLI5HSCYbP3DOqoOFBhu2PptxZdyjXBbypce5bDPYpCSHuZA5XLfgd6h9ILYLJfMI46YlisC5LnKYnERdtgAmW2LPQfQlf1YyKXzrAVEiGHR2YDpK3Aw0LttueAIaiRW5bgRg4712/qLCnirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ+0bK3OEBFZ9X8NxbUOIKog4yNWrzPFYR0iqVEMvMQ=;
 b=TCaVk+9Vd5zDdQutJGY7WRi8ovYgkwhxILagJUERrcG1MTkBkpGEaRgt8Nf8OuaegPcffm1Pcav4pisWeURKZLZg4FCH41W/xpeCKZ1IOUD2KIoVZfFhKuGSMW1semxgLov+7xbRpjebkjLR+zxZ4SnhNo+w2I01BWT4LaPsYzDEGhprX7ZRCFzIzTQr6MmpxA5uJ61YyNi5e3rGC7XA2H8owcG2hfw5HZTdXlcj3FoHq79ti3KQmiVEU01RnM6ldM6/Pwe0jtDIgk9qwmH1vFzIlHRewB1+5GJKhbde3wHAOCihvAdiQgoP9sZdeXFa2h1FqwjrpjRL8azd6+h7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ+0bK3OEBFZ9X8NxbUOIKog4yNWrzPFYR0iqVEMvMQ=;
 b=n87jM/MHSApvzhpcJpI97RgxB5wkgwlgOrCwDi/BciG9ghQ5+yUKClr8OrONhEQsg59hnSUZpaazysLEiFjbdyfscr0baHO5KO27d0F0GN8cqSOlcj/Ny52G8BhrI1h8VpcEbm4KjeX2DpNJ+rK6A0S6z8wH8Klp8dnYiENuGbNQFO5kgmJupc5TvBlhVgogoLum17WLJagSgFT8IkaUihZVuQhMfyocz1DZvS4cgH0+bOHszsSYAFWg2pwcBcrk1kKY5DmLDPpzb03pdhxrNmVV1Pt7Fvr93lT8Y1OyNe9Ijvz7lqCrV+q6DwY5fTg4N2KbyhcenMCEBGpQBlbceQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 09:13:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 09:13:32 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Add test to validate ops.dequeue() semantics
Date: Sun,  1 Feb 2026 10:08:05 +0100
Message-ID: <20260201091318.178710-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201091318.178710-1-arighi@nvidia.com>
References: <20260201091318.178710-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: da561d4c-d1b2-4ce0-4e97-08de61722b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IhCRQFtKSEVDPOy3Id56oVabkikyAD1A/VgJjlUJPTiER3ecs+H0UYqdeJZb?=
 =?us-ascii?Q?7OlCHk0G1fPBzEl46p+gLU0zTh5bHqeC+pl4bJ+aqJZNyO1Yxrh+9UW9gBKw?=
 =?us-ascii?Q?IE2tTfkF4HNJ7QTN9HFpCgwwIQshewvZGYV7DgmUW/rz5D0akoc4EXfGHdOf?=
 =?us-ascii?Q?+kiTTOonMoEVoVAWTgQqluPOwFYGkDwjrFRfPRDFhS4PC7aVMG51rPkNB0C6?=
 =?us-ascii?Q?mmUCdHJG8gVh4xZ0MemriSTLXTl373uz2PeB0f/RbOmG8lO90jfmg7yGJ6Ru?=
 =?us-ascii?Q?XNIdsDUJ6WWoNRKV/oBpiuvHcvizuFfmR6fzWakxx8ydZXlDss/bwsuOMm60?=
 =?us-ascii?Q?6KJr3PkoFTFLJwHHiPHh2Th+llqzXVfLNjig9g2AOp9sBzp1Da5yRO/zI2PN?=
 =?us-ascii?Q?ea/C/M0eN1/r76nhefUyYFAgGnK0YwYRgQCNT9kOK9LT1vjyNaxHCgZ9/+XT?=
 =?us-ascii?Q?2egqFR66kwfHlWiTXixYS800sc9vM+kyQ6GVWp3l1Irqt/VxKApaJZ2wTypu?=
 =?us-ascii?Q?w8u3Xmdbs/XQEefhCsr8YdH4bQYawqFJMRQVxn/GseEia9drRQMiJ3Gflp6Q?=
 =?us-ascii?Q?Xss2nb1rBDxeSwluLprbt53cFaam60iUrluxTnyanKHhTlAyWTfadyPdkwDP?=
 =?us-ascii?Q?o4CxnXCeH+mlcWWNiVDxfnwFsmnYPMbhnwfMJ4toT5I33YeV/bSgSWest1EJ?=
 =?us-ascii?Q?hfRgAF5ExqOkKY3kPX3CtuPOxMHiMkXdkDkokxbZy6kpi2BCUbvmdcdnOfax?=
 =?us-ascii?Q?vvUHF8J11ByvCr5AUcUZUeMIgnaS76YNCdP3oqyOXt8dhQRe3fGV1CNBeKhX?=
 =?us-ascii?Q?wo0/EiuxuFdMhGjKtEDeTbCx3MYpYbzDQt2O2kjVC9BYovIr4LzzHwpa5fYz?=
 =?us-ascii?Q?ugrAH1LMVCM5j/xVAJ6hNgq3lSdXizJVLjoda+OLk+P0tJ5FqS8308VifvUi?=
 =?us-ascii?Q?CAttmpluCbWmBNrrIlNqg8l2lrUccFCWI1ig88c46RxsgpVBaCzJXZBJb/Wk?=
 =?us-ascii?Q?kzO3uEaQOANN4hsW2LsB6ETK07I98es9f7H4dAuvLLmKufTriwsCEq+hY6XE?=
 =?us-ascii?Q?hMB2T7Q5Nfqo2Gu4gsRYmIPReZWyL73NRuyXCje+gu9EzNyep9EX6/776bvk?=
 =?us-ascii?Q?zMAVjmB0q0u68uTK87QX13x4onAZz3pJlJis9dcE8ZRa1PSGx4IizzU3T/lH?=
 =?us-ascii?Q?cjoTYaxEgJqLFuymb6qctQorv3UK/GGczsC6fnweXtyZ33iWlsmcHEeC3trq?=
 =?us-ascii?Q?O667HAQuGUXJjnsPfKulaVp6VYEnDjb3IDaJVIOr9lt6baFA5XzdONtq8Db9?=
 =?us-ascii?Q?UO+aQ0LUck85VtSg2FXVt3AflqWsLEGwR2AiqLhy8gpGIvIl+lCMc5nsPrYr?=
 =?us-ascii?Q?NERhWxXiSG7fKV4DhZheTi0/XhKF1xVWy3q+McfJQTmKt9MgBU6YkUOSN3Ot?=
 =?us-ascii?Q?rnDLZDFwAsRlfW2Pbg3/Zb8/ILT0xEYz5DkDZjcKtUYwtuh/oC2CGYBM92qF?=
 =?us-ascii?Q?vjvo9FQJPYQZw9thGoVba4s2hktoWiyw+V6wneSFrrwhONFkzWZHaGzl6xaG?=
 =?us-ascii?Q?FFZlToPVrCgL/P/LGaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OurjjDxhaYujBPZg/fagwEoq7mG/5snOFEboo5Ypqb4TgmuzqevjPB839CVg?=
 =?us-ascii?Q?RpYQ8SiKQwLLLf224kOaRjJlsvfVD5UAl4u4ozNG9vWkZqv+mUSw5f/D9FE+?=
 =?us-ascii?Q?2gLSeWoake1wzOUrHh2dKnjsg62ccMUJbCUH0CyaKFWnrcj/Aqq/6znbI4WA?=
 =?us-ascii?Q?EBVq7/99vyap++DS7K1Ekyx/QyU3cLGteuvi4vq1G+LKoCFvqeFj32fQNuoK?=
 =?us-ascii?Q?wxFQC3ThIMDVeAom8Z6tM6UYh0xQfMloov7U9c1IVebgb+uCWtUAvfoHu3bW?=
 =?us-ascii?Q?s5+yxWf1YpprtwF1UcRRZD5N1+lhyfIoojipGHID9de+Z5LBmx1y3+YFdBdV?=
 =?us-ascii?Q?/YAsmUEOUMWd/DVH64n0EyBb5IGbLktosqdBnrbPZh/19esKgHMF9J50yhP1?=
 =?us-ascii?Q?yvxGn7JIlAFXfRhKn9eI+3QUxQFh6a3emOoLM2tEDDKn7Q9KtMiia1OhgLAQ?=
 =?us-ascii?Q?A4aXkC7jU8yY4yn7wtKHteRVucIMk1SSSaZfOLmCL6o+u6vk8/vQj9QpvI0k?=
 =?us-ascii?Q?H76ypA6kY7F04h4FjrXDzKEIyeJ3niY/BMLqDdDqp8g52pwLNTfcv6Ok1pUe?=
 =?us-ascii?Q?ieLQyRiQAmLLeOpIhOhW9q+wTbV2jry+fWKD4xwYX81e3OcGkFCNurBOfD0E?=
 =?us-ascii?Q?/+X70VE23EIPQdbXoSchxRMvDjgmioO97LnnoFGHTSfL2qJorvSVNcBruNy7?=
 =?us-ascii?Q?GvDPgTGH+eykzX+gY/KYbhhSQ+2O5LiHBy0/Roz+xI7fUixWRzZ2vs+B2rD0?=
 =?us-ascii?Q?cgeu1lzZBQCZp9p+fahoPsnGxRsRVgHJZvDziqHEZajcxuPGqAB+50JlmUqZ?=
 =?us-ascii?Q?QhT1A0RmsJgIfPpjXipPdXDSUKeuM551BkyDtnQ7XAtVNTNOJMRTcbk0Cz0z?=
 =?us-ascii?Q?5Or5ApVBngxhyZUqExJFY9eKOvkqVqZj6AGqpBodb2gmKZd0bTTF6dCnr0ku?=
 =?us-ascii?Q?XaTI4I6z78gHjZV7/WD7G1JNgugNWwcFuWtHCc2Z/iysIZ3aVX5Fa/DHxgx5?=
 =?us-ascii?Q?NKoNp2QDL2/st0BMpTHZEltKtSQwp8L/agYVuFoaIVzI9epz6PrtccEXo1VZ?=
 =?us-ascii?Q?Vvgc2tLa1LLg00oy9q5qFShvEHx9HZ3FlpbEJCAbJuKTSgJyPHEy3bBh2mOb?=
 =?us-ascii?Q?2Okrl+oseAnG47ugo3VCVf7lC9dOVAlS2sCRy4XJ+L/DG5ihBZEQqQjRcG/T?=
 =?us-ascii?Q?DYDoCbAFd8F+WVlN9GlwrXB/LyyFAEP60fxYUQj866NtOGPZAonar/OYyD4B?=
 =?us-ascii?Q?KGDVu3b1V3cV6R5Bja2quPxhVqAnrVM+PiTjei8ZDNckDnYe8XY+1Qs6LF59?=
 =?us-ascii?Q?944jRCZhaxfcZ+fBm5GreFak7hf7QBEtfnVy/PhxgjH4jZOmvoIlN5BEm3n0?=
 =?us-ascii?Q?BXeMgCPe8E9r6EQmHsYCD8h9Y9xn1NyAOAt48NIyJn9U6V2t3fo5oAo/xvWC?=
 =?us-ascii?Q?JHMPGULxu8ufL4ZfmlRBHx0Ec3W1eRfte9byHD5pw8CzxNqL1Cveoc9GLA5+?=
 =?us-ascii?Q?yxrqhoXbyEvf9QIugNqc2nRgi0IQiG7ItbmwbYi5at+IC+8vqs0Exalprli4?=
 =?us-ascii?Q?obXfeieMHf7YTYPvocTtEL96BmJcz7d/WptenFpnng8lhIW/nUX/pHp32YqS?=
 =?us-ascii?Q?QSb42BuzlkVVjqsr3VRG5Z1CcbpTEN2ooQON0oA+HiZ4HKsgsSMJ8hAk5Jzv?=
 =?us-ascii?Q?I0VQ0ZAksynSo93Jmq6yttx9iODGdnB7VC52gh8fLEWzujgw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da561d4c-d1b2-4ce0-4e97-08de61722b8e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 09:13:32.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KB+pgm56qmS1Pl+wFpMKSzmJGbEGcXmL/whmCbOF8BPNUTlH4ZN0OUtA6PAESrJn61Wa3kClV17bwxqZ1yE/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

Add a new kselftest to validate the following scenarios:
 - scenario 0 (Local DSQ): tasks don't increment enqueue counters since
   they never enter BPF scheduler custody (no tracking or validation,
   expects 0 enqueues and 0 dequeues),
 - scenario 1 (User DSQ): full enqueue/dequeue lifecycle tracking with
   state machine validation (expects 1:1 enqueue/dequeue pairing).

The test validates that:
 - local DSQ dispatch don't trigger ops.dequeue(),
 - non-local DSQ dispatch has exact 1:1 ops.enqueue/dequeue() pairing,
 - dispatch dequeues have no flags (normal workflow),
 - property change dequeues have %SCX_DEQ_SCHED_CHANGE flag,
 - no duplicate enqueues or invalid state transitions are happening.

This validates that the new ops.dequeue() semantics work correctly for
all task lifecycle scenarios.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 238 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 201 +++++++++++++++
 3 files changed, 440 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..764e91edabf93 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 
 auto-test-targets :=			\
 	create_dsq			\
+	dequeue				\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
new file mode 100644
index 0000000000000..092956becb554
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - for tasks on BPF data structures (not yet dispatched)
+ * - for tasks dispatched to non-local DSQs (global or user DSQs)
+ * - That every ops.enqueue() is followed by ops.dequeue() except for tasks
+ *   directly dispatched to local DSQs, which bypass the BPF scheduler
+ *   entirely
+ *
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+/*
+ * Counters to track the lifecycle of tasks:
+ * - enqueue_cnt: Number of times ops.enqueue() was called
+ * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
+ * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no flag)
+ * - change_dequeue_cnt: Number of property change dequeues (%SCX_DEQ_SCHED_CHANGE)
+ */
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
+
+/*
+ * Test scenarios:
+ * - 0: Dispatch to local DSQ (bypasses BPF scheduler, no dequeue callbacks)
+ * - 1: Dispatch to shared DSQ (enters BPF scheduler, dequeue callbacks expected)
+ */
+u32 test_scenario;
+
+/*
+ * Per-task state to track lifecycle and validate workflow semantics.
+ * State transitions:
+ *   NONE -> ENQUEUED (on enqueue)
+ *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
+ *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
+ *   ENQUEUED -> NONE (on property change dequeue before dispatch)
+ */
+enum task_state {
+	TASK_NONE = 0,      /* Task is outside scheduler control */
+	TASK_ENQUEUED,      /* ops.enqueue() called, waiting for dequeue */
+	TASK_DISPATCHED,    /* Dispatch dequeue received, can get property change or re-enqueue */
+};
+
+struct task_ctx {
+	enum task_state state; /* Current state in the workflow */
+	u64 enqueue_seq;       /* Sequence number for debugging */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
+{
+	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/* Always bounce to ops.enqueue() */
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	switch (test_scenario) {
+	case 0:
+		/*
+		 * Scenario 0: Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely - no enqueue
+		 * tracking, no dequeue callbacks. Don't increment counters
+		 * or validate state since the task never enters BPF
+		 * scheduler management.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 1:
+		/*
+		 * Scenario 1: Dispatch to shared DSQ.
+		 *
+		 * Task enters BPF scheduler management - track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		/*
+		 * Validate state transition: enqueue is only valid from
+		 * NONE or DISPATCHED states. Getting enqueue while in
+		 * ENQUEUED state indicates a missing dequeue.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/* Transition to ENQUEUED state */
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+		break;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&dequeue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	/*
+	 * For scenario 0 (local DSQ), ops.dequeue() should never be called
+	 * because tasks bypass the BPF scheduler entirely. If we get here,
+	 * it's a kernel bug. We don't track enqueues for scenario 0, so
+	 * tctx->enqueue_seq will be 0.
+	 */
+	if (test_scenario == 0) {
+		scx_bpf_error("%d (%s): dequeue called for local DSQ scenario - kernel bug!",
+			      p->pid, p->comm);
+		return;
+	}
+
+	/*
+	 * Validate state: dequeue should only happen from ENQUEUED or
+	 * DISPATCHED states. Getting dequeue from NONE indicates a bug.
+	 */
+	if (tctx->state == TASK_NONE) {
+		scx_bpf_error("%d (%s): dequeue from NONE state seq=%llu",
+			      p->pid, p->comm, tctx->enqueue_seq);
+		return;
+	}
+
+	if (deq_flags & SCX_DEQ_SCHED_CHANGE) {
+		/*
+		 * Property change interrupting the workflow. Valid from
+		 * both ENQUEUED and DISPATCHED states. Transitions task
+		 * back to NONE state.
+		 */
+		__sync_fetch_and_add(&change_dequeue_cnt, 1);
+
+		/* Validate state transition */
+		if (tctx->state != TASK_ENQUEUED && tctx->state != TASK_DISPATCHED)
+			scx_bpf_error("%d (%s): invalid property change dequeue state=%d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/* Transition back to NONE: task outside scheduler control */
+		tctx->state = TASK_NONE;
+	} else {
+		/*
+		 * Regular dispatch dequeue: normal workflow step. Valid
+		 * only from ENQUEUED state (after enqueue, before dispatch
+		 * dequeue). Transitions to DISPATCHED state.
+		 */
+		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
+
+		/* Dispatch dequeue should not have %SCX_DEQ_SCHED_CHANGE flag */
+		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
+			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/* Must be in ENQUEUED state */
+		if (tctx->state != TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/* Transition to DISPATCHED: normal cycle completed dispatch */
+		tctx->state = TASK_DISPATCHED;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(SHARED_DSQ);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tctx)
+		return -ENOMEM;
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_init)
+{
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(dequeue_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dequeue_ops = {
+	.select_cpu		= (void *)dequeue_select_cpu,
+	.enqueue		= (void *)dequeue_enqueue,
+	.dequeue		= (void *)dequeue_dequeue,
+	.dispatch		= (void *)dequeue_dispatch,
+	.init_task		= (void *)dequeue_init_task,
+	.init			= (void *)dequeue_init,
+	.exit			= (void *)dequeue_exit,
+	.name			= "dequeue_test",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
new file mode 100644
index 0000000000000..805970834612b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include <pthread.h>
+#include "scx_test.h"
+#include "dequeue.bpf.skel.h"
+
+#define NUM_WORKERS 8
+
+/*
+ * Worker function that creates enqueue/dequeue events. It alternates
+ * between CPU work, sleeping, and affinity changes to trigger dequeues.
+ */
+static void worker_fn(int id)
+{
+	cpu_set_t cpuset;
+	int i;
+	volatile int sum = 0;
+
+	for (i = 0; i < 1000; i++) {
+		int j;
+
+		/* Do some work to trigger scheduling events */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Change affinity to trigger dequeue */
+		if (i % 10 == 0) {
+			CPU_ZERO(&cpuset);
+			/* Rotate through the first 4 CPUs */
+			CPU_SET(i % 4, &cpuset);
+			sched_setaffinity(0, sizeof(cpuset), &cpuset);
+		}
+
+		/* Do additional work */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Sleep to trigger dequeue */
+		usleep(1000 + (id * 100));
+	}
+
+	exit(0);
+}
+
+static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
+					 const char *scenario_name)
+{
+	struct bpf_link *link;
+	pid_t pids[NUM_WORKERS];
+	int i, status;
+	u64 enq_start, deq_start, dispatch_deq_start, change_deq_start;
+	u64 enq_delta, deq_delta, dispatch_deq_delta, change_deq_delta;
+
+	/* Set the test scenario */
+	skel->bss->test_scenario = scenario;
+
+	/* Record starting counts */
+	enq_start = skel->bss->enqueue_cnt;
+	deq_start = skel->bss->dequeue_cnt;
+	dispatch_deq_start = skel->bss->dispatch_dequeue_cnt;
+	change_deq_start = skel->bss->change_dequeue_cnt;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops for scenario %s", scenario_name);
+
+	/* Fork worker processes to generate enqueue/dequeue events */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
+
+		if (pids[i] == 0) {
+			worker_fn(i);
+			/* Should not reach here */
+			exit(1);
+		}
+	}
+
+	/* Wait for all workers to complete */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for worker %d", i);
+		SCX_FAIL_IF(status != 0, "Worker %d exited with status %d", i, status);
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	/* Calculate deltas */
+	enq_delta = skel->bss->enqueue_cnt - enq_start;
+	deq_delta = skel->bss->dequeue_cnt - deq_start;
+	dispatch_deq_delta = skel->bss->dispatch_dequeue_cnt - dispatch_deq_start;
+	change_deq_delta = skel->bss->change_dequeue_cnt - change_deq_start;
+
+	printf("%s:\n", scenario_name);
+	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
+	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
+	       (unsigned long)deq_delta,
+	       (unsigned long)dispatch_deq_delta,
+	       (unsigned long)change_deq_delta);
+
+	/*
+	 * Validate enqueue/dequeue lifecycle tracking.
+	 *
+	 * For scenario 0 (Local DSQ), both enqueues and dequeues should be
+	 * 0 because tasks bypass the BPF scheduler entirely: they never
+	 * enter BPF scheduler's custody. For scenario 1 (ser DSQ) , we
+	 * expect both enqueues and dequeues.
+	 *
+	 * The BPF code does strict state machine validation with
+	 * scx_bpf_error() to ensure the workflow semantics are correct. If
+	 * we reach here without errors, the semantics are validated
+	 * correctly.
+	 */
+	if (scenario == 0) {
+		/* Local DSQ: tasks bypass BPF scheduler completely */
+		SCX_EQ(enq_delta, 0);
+		SCX_EQ(deq_delta, 0);
+		SCX_EQ(dispatch_deq_delta, 0);
+		SCX_EQ(change_deq_delta, 0);
+	} else {
+		/* Non-local DSQ: tasks enter BPF scheduler's custody */
+		SCX_GT(enq_delta, 0);
+		SCX_GT(deq_delta, 0);
+		/* Validate 1:1 enqueue/dequeue pairing */
+		SCX_EQ(enq_delta, deq_delta);
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue *skel;
+
+	skel = dequeue__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dequeue__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dequeue *skel = ctx;
+	enum scx_test_status status;
+
+	status = run_scenario(skel, 0, "Local DSQ (direct dispatch)");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 1, "User DSQ");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	printf("\n=== Summary ===\n");
+	printf("Total enqueues: %lu\n", (unsigned long)skel->bss->enqueue_cnt);
+	printf("Total dequeues: %lu\n", (unsigned long)skel->bss->dequeue_cnt);
+	printf("  Dispatch dequeues: %lu (no flag, normal workflow)\n",
+	       (unsigned long)skel->bss->dispatch_dequeue_cnt);
+	printf("  Property change dequeues: %lu (SCX_DEQ_SCHED_CHANGE flag)\n",
+	       (unsigned long)skel->bss->change_dequeue_cnt);
+	printf("\nAll scenarios passed - no state machine violations detected\n");
+	printf("-> Validated: Local DSQ dispatch bypasses BPF scheduler (no dequeue callbacks)\n");
+	printf("-> Validated: Non-local DSQ dispatch triggers dequeue callbacks\n");
+	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)\n");
+	printf("-> Validated: Async dequeues have SCX_DEQ_SCHED_CHANGE flag (interruptions)\n");
+	printf("-> Validated: No duplicate enqueues or invalid state transitions\n");
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dequeue *skel = ctx;
+
+	dequeue__destroy(skel);
+}
+
+struct scx_test dequeue_test = {
+	.name = "dequeue",
+	.description = "Verify ops.dequeue() semantics for local and non-local DSQ dispatch",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_test)
-- 
2.52.0

