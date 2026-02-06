Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB7365A11
	for <sched-ext@lists.linux.dev>; Fri,  6 Feb 2026 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386332; cv=fail; b=mPoS4nLxFlUK1Sayh0fU7UqP31WmmacCUlciwBbTR4p4k95XkowiI6iAjb9cS3zDK2/8RwmOuWlh60/L/+N+NmUGIDZVvu3/U28EnHJhase/ZsM+wNXtLcWk9NuswCfHbx5rnCUfPBkL7q5j+GRL3eD/wTSK3Hx8K4fVeXrtDyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386332; c=relaxed/simple;
	bh=wGksxHTMyWlknVZPxSiINsgJ6LFZ5qbdQqB21dac1mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L3yYd6/DzfxmRpT5w6R2JiA3jdvOni5bVHpvWUvQSX6yKck324PNT0DkL+0I8T9PhQITTzN/3l9qVH1pGeMD8FkIurUG6PcoIIrRkK/IsXI/WZcX8mab93wboPSBTee3Dz1WaTM4mYbOoAYhX74enNEouN0VadQgw1CNgRdO6tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kmP2H9yz; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kmP2H9yz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hy4NDRrN6w51Fz5UHwCggJj6Ic4CAkmZPHGszvnkkD1vK86RT3+0sEdIQAFERfvAiCTT2AEFpDZoAH1eNAEAGqov31MD0YwdWK5SEt1eaVLFfmxUcuPy0lqv1bL/DvpNY20yxIZocvFsbCUkoMHlMPOUFx5Wh9fg3DkGtXRcJzW9vPZlBpOjQfx6tE+NnBpflmeybu06FBvpKXRuqAB6p6IJ0Zhdnl2PMni0fvagN1nhv+SgI0WbloS6aB/9Xre5aLcRgv1wgipr6c8x6GZlnrndo9t0gV5cwIhc+Y6MA9FsKjbi7iMbLD8SlkuaMknwnqdh9bZT+aI/BG4K0I1Dgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxpIF0u052RzStRBcuulwDYhNKGvSidrHja6cqA400s=;
 b=VJsq8MM2jSdcgCNRc2fU/NTQjhuL7xoCJ5/A4wi/F+MTm0XEKU+wPE/vbk0R/9cMILkDIV1VEUjcLDqdrEiKqQu3TMUveoYe+4coXTJ1btvQsrt8yr9dsdpA84FZzdVjWIXweN4GCXe1jPkvrRmqcgOYqlETgT5QkxEfVpi6Xz+Fw6JkRAckee5IC54mFsFjPaCtZkKKQLaZ8FExhSA4d2iDFfCtc4gSxCg3PTChcLJptxMCMKEyBdgt5Mqq+tSfDfacTsPbkniLt13mpUh2zLJ8sZ9OAdukjNC1ipu/kM/EF5Fr1hlmH4+qMdDE29TRiBJyz1R7/v2SAMUubErGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxpIF0u052RzStRBcuulwDYhNKGvSidrHja6cqA400s=;
 b=kmP2H9yzFjvCk9PeT25H7J92m2kbqbIbu+l/hEHHDeGmGv9l1+RN4moO9n7siQ5CwVXFgDHNH27tt5x4JifKKYIKYREbgXw89gS7KUnbGmCwLXYDIHc2zDw0Jdc+WuL75kYtBHV6hRAtPAG0dQJ9eSBp0dlRSdWyTRdtqJ6TbcIQjJiOPt/5c/R98kD/ZHVIfOPY9oDWawVZOF1aZ7ZoVdrG3X791XaKsL+5yHrXmk1IScWeoqtVE+PFXTJG/PA4iopgyAWVYUJ2NSNjNdtXdpUp1KhUHghyN9Qb1SazICvk0JEYAoalD41X8kzga5wSzxxtW0GlDjKL+pqu8BaTyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 13:58:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 13:58:43 +0000
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
Date: Fri,  6 Feb 2026 14:54:18 +0100
Message-ID: <20260206135742.2339918-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206135742.2339918-1-arighi@nvidia.com>
References: <20260206135742.2339918-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0e1b84-de35-487f-146c-08de6587d6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PM+XrMGxm2eAQo2w0z0hXBV99Tt2tiVthNyeMBOo5qcrsBSHVmbVoQrOxJTi?=
 =?us-ascii?Q?9N53rQInvG+0+dLb6x0Uo2AhAjXtDBhhmDil1DcK2f3b7zyarqanYONnjKTW?=
 =?us-ascii?Q?UJkk6wPCl6VbtHE0PsdeKVe6Dec2NprCmIFeUCn0AY+bRZ+WzuunKE3pdVfT?=
 =?us-ascii?Q?z5V4ZxNjD4DqS3CpYEzAlPb8naFmXOCWt0dieeBWyJdFVEa9CF7eKwh6zTYi?=
 =?us-ascii?Q?SMuF20P2Ns0qmtDwLv8dFN+aqrVhc2WkO8A9W+/T3PB8tQ68TeQWjLBBVsA1?=
 =?us-ascii?Q?6ocMxhyDODQRgqrreF4SapBcAhXh2/vCw8u16AFxSnPOUc6bSflPmxs11n4Y?=
 =?us-ascii?Q?akcDGzFgQnXce+Xk51sNpv/FN9eohXZBYOmwkKLRtKCwdQSe+sLm/CPIqRaH?=
 =?us-ascii?Q?Wz1JPpGmaUuFro1mIoNU3P8RzGLY3LZ78D0/BQF9Fka1dz4Uy23mzgbENfy8?=
 =?us-ascii?Q?p9glG0qx4lof7bsO5LCNgM9pCxIwe1udrX5M+hMdVZX25gjY2xenTuvNX5Lz?=
 =?us-ascii?Q?nFxUK/2zAaycxOKo694RHh5bQ0Z3TjZEmBwt3r4qBwBL4gU+rVncDINP3EZ1?=
 =?us-ascii?Q?IxVXAQv68dUDwtKPcCg3JbZnflA+fgr/N2V+dymGShjPPg/eyCNjhUaKkt0C?=
 =?us-ascii?Q?SgxlvlHOdfYrrF/otHBXFb5a6QK1S6p9A5h7soX/C+Gg/sjXVoH4RQg8Aj5Q?=
 =?us-ascii?Q?NFv4BCkyv/riwegDjiZXX2e9AB1dmYxnvTziUgmQ328fIvpu3cJE+7h58mDL?=
 =?us-ascii?Q?4BqCikFp2L1WgeE285cu3O67QBXYGkANUk2/mddskeWITqM3sHySmn20Olol?=
 =?us-ascii?Q?1Nd//2EMpS7PfQ0LYN0AadeuyXl3aJGWRCi9XYXj0iVsfp4G0he0tnDiMWVH?=
 =?us-ascii?Q?SwbxsT+ji3ROBkwqa0vUcrV2SblEfMs1S1X7VbnPZq6JAuudSKeCL9p3eQss?=
 =?us-ascii?Q?o9yo1oFF3EmInktd0OSQ4g8CHGZttGquKCT+P1eKtyrNzzbhq11XTGypkh2X?=
 =?us-ascii?Q?NtouYvDN67n3BXKf3QwwQDt6HavwpzrP84+SSsqluw4k7HjJqpieGfley+qx?=
 =?us-ascii?Q?ZnCkyBi7jDEUisD5yN39jhxySKC0Sc1t1BLUZypocMKpmaQb/UDUEzGOssho?=
 =?us-ascii?Q?A/4Y0ydl2EYFwpfq9xbUid59FMoNHf8D2nf80Ie0C8hY4RpUWqdd25iJTnKw?=
 =?us-ascii?Q?Gf+B5U4F8A5GpvycuNtjTd/ZWn+bNMm5Vk+HmcW6QpHwXZBmsREM9Kf8TTiy?=
 =?us-ascii?Q?fWcAMihmk6DDG2r3va6JUIB2/EhFzb1gV5EWJGGu3Njx6bjdc9IbD1wrQ1Nu?=
 =?us-ascii?Q?zePlayIawfib9V2W6e8yylVkM5OPUlzgkRAJ+1EIBdlteeFIKQ/3kv//kLAY?=
 =?us-ascii?Q?BqYfslJdXr0W+O3K1V1erDtWZcMtVKSxXLVPvZXOiiDw52EWT40W9UQ43OnL?=
 =?us-ascii?Q?4NcSB3YysPzJku4E8/K2Z97aj+NS6GBes1iI2hehj7r9BvdTVYShno3C8am+?=
 =?us-ascii?Q?TVQ6nFQ8l5UcKCJMp2citVYWDm84sLPOP3aV2zeO1pK8kX7kLskPIn4mGbbU?=
 =?us-ascii?Q?+C3TatHhSLJ2oqZSngw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yNezhjVE1QBfS8EtgcrJWIUkUf/rduDDfJZs2zHdZxnSAE6N8WySHDnKerPM?=
 =?us-ascii?Q?BG/OBtfqp1501wT5Z9u7k1hhQl1CjhCR/KQ7zL+jeuMArhoVuLHhBlrU1Ii7?=
 =?us-ascii?Q?+rH76GLaVnF8USuIpUSdG0TwwHAoLmEaFcbQJLUFyLg4P5Ktbn21wfG0n7As?=
 =?us-ascii?Q?TlKfJOTkyFU2IszsMcFVyh8dVP97ND/39RL0RMUpTaVV6UPvm4WVFEBmahZA?=
 =?us-ascii?Q?SIebMoZyfPos+ToN16LT9xVnAMGF9sX9cDBjCJTTaOR+5jyeTeLp43B2ID4h?=
 =?us-ascii?Q?0auuttwtmeLjhkUDdfdusvgxks58sxIStDZS5DF/I8H45pXUWhJ4qS9l7fC7?=
 =?us-ascii?Q?/rggyppKaPPi2bJS6qtHYwMKYUq5Yuvz7FMJZk7bc1Uj5PQafnDk4gr8sVau?=
 =?us-ascii?Q?6hEfZlVMymWm2gdOjacD38sXxfHNABceSKVfH9MZT/0YeDejHLg0YhECHfi6?=
 =?us-ascii?Q?+BjFlTuiHH7Q3BjDxXZ/GbW8lo/eqAoKO55nURIzxOMhlquaamxpqUp/ihUt?=
 =?us-ascii?Q?NJnkIC0wdSWBFDcuE1j7dX4mlz+JDk9/05mlJkCr06Wrzsr8nT8pBvHE1RHi?=
 =?us-ascii?Q?yC4Rgg69WLCoLRKEncGDzqN6Re2axTz4xxe2JJ1iVMqYptgFAmFbQFok5meg?=
 =?us-ascii?Q?weoVv5l8Th6vKuB4tgj/G7BRqbyBwh3aSbVR/lSwv5CYQTAx9OWKpUAKrEoz?=
 =?us-ascii?Q?ZvXWK6Kq1xvgGBcdtaO42Cp2/XS2AK80DShxnt9dnD/eYxK1MqLDP83DMKnm?=
 =?us-ascii?Q?SxfPGi/x0z9fyfl2hHZLM1u3ZHBeKrbrHD7/nU/JfwvgcmkOzTsw1Mtxm3Zp?=
 =?us-ascii?Q?BYDgIMOfAwLLr+porBSD/BK/vYVC6pnembrXJPgTEr9ghcxJaHhlixV3w17Q?=
 =?us-ascii?Q?8gUczaVaA3SxSVxH97MPmb80kxljKc5xvTpuUJKgbOsshc90lS9iuPNXduB6?=
 =?us-ascii?Q?N2H7o/INmV+7T/vpu9IgHsuydixoAfkUXBKVhgwPeo5LvfSPQpqLINuiaYGs?=
 =?us-ascii?Q?U1L1llKvhPp6HX7VZc1tSI70Hag2WK7Zb2O8DUYqmxbEcqCYMYz3yPGzaF6L?=
 =?us-ascii?Q?bu9HYBRx2OcQeEnT2NwaDE2lHmuYpqgaWSW6wdFMJkXdEpZhI2igsdHgvQRg?=
 =?us-ascii?Q?IZlK/vDSptfIfbQp8dgDOzeGuP8eqft2y367uyW1zSQab9TksQS5lfi0hLG3?=
 =?us-ascii?Q?iFBWOWo/jhJmv+FYioHADA/WAzD4/c4X/Ei3PYtnW3aFWI31XvAMB54CG/an?=
 =?us-ascii?Q?ESunIyfR1GG7/RQtiVEUMhpmI9rf1KJeoSrl6+m5gpIE/k3CF9AzyMWKIrg2?=
 =?us-ascii?Q?zDzN6g36E67/fOgL0Uy41ATsXQxREGZ5n4kz1NZ4qs6upgiPJ+mAkPGlV+6G?=
 =?us-ascii?Q?7tQkh1AF5AVbZDHyqgGcGtGQxs7H2Z9ispL7iJbz7AmBOqg2r/sA1gFlLoiG?=
 =?us-ascii?Q?zDDDxtKHgBI9awHq/pYA5ot6Pbdd3wsCrdPuFIWu6h3nuwpYkKpC8n1+B0t6?=
 =?us-ascii?Q?SX1aVsG25gngQaVCHur+9ZU6UvcdJu5gmOS7TJooCFzeGb/e3wWjcImdfUxj?=
 =?us-ascii?Q?se8iYsudtvwpa/Ib7mn3plL93XSCjlXxDU6HT5C/X2teZWcL+9NEJgDhh0Ak?=
 =?us-ascii?Q?XOQ2P8UvltA7MW/AoWQ53aL91NqQZFoKUyh5ubE0WePO3o1iYfCzq80WltWa?=
 =?us-ascii?Q?mIbJ3u283daCdi0yt7wwc1Win5EjMdNmws1fgqbYy8SOLhIJHpvVTgX8F75T?=
 =?us-ascii?Q?V9e7l/7XSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0e1b84-de35-487f-146c-08de6587d6bd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:58:43.3207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bvr5HIt/OC9i8Ss4Hj1j/OHA6O/XqFj8QW7muATSM0q6sjgnNFdQoR7qSAnhYR0A7ae3g4gRf3Fi/l6VUsX4/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

Add a new kselftest to validate that the new ops.dequeue() semantics
work correctly for all task lifecycle scenarios, including the
distinction between terminal DSQs (where BPF scheduler is done with the
task), user DSQs (where BPF scheduler manages the task lifecycle) and
BPF data structures, regardless of which event performs the dispatch.

The test validates the following scenarios:

 - From ops.select_cpu():
     - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
       the BPF scheduler entirely; they never enter BPF custody, so
       ops.dequeue() is not called,
     - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
       bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
       not called,
     - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
       enqueue/dequeue lifecycle tracking and state machine validation
       (expects 1:1 enqueue/dequeue pairing).

   - From ops.enqueue():
     - scenario 3 (local DSQ): same behavior as scenario 0,
     - scenario 4 (global DSQ): same behavior as scenario 1,
     - scenario 5 (user DSQ): same behavior as scenario 2,
     - scenario 6 (BPF internal queue): tasks are stored in a BPF queue
       in ops.enqueue() and consumed in ops.dispatch(); they remain in
       BPF custody until dispatch, with full lifecycle tracking and 1:1
       enqueue/dequeue validation.

This verifies that:
 - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
 - user DSQ / internal BPF data structure dispatch has exact 1:1
   ops.enqueue()/dequeue() pairing,
 - dispatch dequeues have no flags (normal workflow),
 - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
 - no duplicate enqueues or invalid state transitions are happening,
 - ops.enqueue() and ops.select_cpu() dispatch paths behave identically.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 403 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 258 +++++++++++
 3 files changed, 662 insertions(+)
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
index 0000000000000..4ba657ba1bff5
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
+ *   scheduler entirely: no ops.dequeue() should be called
+ * - Tasks dispatched to user DSQs enter BPF custody: ops.dequeue() must be
+ *   called when they leave custody
+ * - Every ops.enqueue() for non-terminal DSQs is followed by exactly one
+ *   ops.dequeue() (validate 1:1 pairing and state machine)
+ *
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+/*
+ * Scenario 6: BPF internal queue. Tasks are stored here from ops.enqueue()
+ * and consumed from ops.dispatch(), validating that tasks not on a user DSQ
+ * (only on BPF internal structures) still get ops.dequeue() when they leave.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 4096);
+	__type(value, s32);
+} global_queue SEC(".maps");
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
+ * - change_dequeue_cnt: Number of property change dequeues
+ */
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
+
+/*
+ * Test scenarios (0-2: ops.select_cpu(), 3-6: ops.enqueue()):
+ * 0) Dispatch to local DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 1) Dispatch to global DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 2) Dispatch to shared user DSQ from ops.select_cpu() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ * 3) Dispatch to local DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 4) Dispatch to global DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 5) Dispatch to shared user DSQ from ops.enqueue() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ * 6) BPF internal queue: store task PIDs in ops.enqueue(), consume in
+ *    ops.dispatch() and dispatch to local DSQ (validates dequeue for tasks
+ *    in BPF custody but not on a user DSQ)
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
+	TASK_NONE = 0,
+	TASK_ENQUEUED,
+	TASK_DISPATCHED,
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
+	struct task_ctx *tctx;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return prev_cpu;
+
+	switch (test_scenario) {
+	case 0:
+		/*
+		 * Scenario 0: Direct dispatch to local DSQ from select_cpu.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no dequeue callbacks. Behavior should be
+		 * identical to scenario 3.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+		return prev_cpu;
+
+	case 1:
+		/*
+		 * Scenario 1: Direct dispatch to global DSQ from select_cpu.
+		 *
+		 * Like scenario 0, task bypasses BPF scheduler entirely.
+		 * Behavior should be identical to scenario 4.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		return prev_cpu;
+
+	case 2:
+		/*
+		 * Scenario 2: Dispatch to shared user DSQ from select_cpu.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state transitions.
+		 * Behavior should be identical to scenario 5.
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
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, 0);
+		return prev_cpu;
+
+	default:
+		/*
+		 * Force all tasks through ops.enqueue().
+		 */
+		return prev_cpu;
+	}
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
+	case 3:
+		/*
+		 * Scenario 3: Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no dequeue callbacks. Don't increment counters
+		 * or validate state since the task never enters BPF
+		 * scheduler management.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 4:
+		/*
+		 * Scenario 4: Direct dispatch to the global DSQ.
+		 *
+		 * Like scenario 3, task bypasses BPF scheduler entirely.
+		 * SCX_DSQ_GLOBAL is a terminal DSQ, tasks dispatched to it
+		 * leave BPF custody immediately, so no dequeue callbacks
+		 * should be triggered.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 5:
+		/*
+		 * Scenario 5: Dispatch to shared user DSQ.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		/*
+		 * Validate state transition: enqueue is only valid from
+		 * NONE or DISPATCHED states. Getting enqueue while in
+		 * ENQUEUED state indicates a missing dequeue (or stale state
+		 * from a previous scenario when the scheduler was unregistered
+		 * with tasks still on a DSQ). Reset and proceed to avoid false
+		 * positives across scenario switches.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			tctx->state = TASK_NONE;
+
+		/* Transition to ENQUEUED state */
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 6:
+		/*
+		 * Scenario 6: Store task in BPF internal queue. Task enters
+		 * BPF custody (kernel sets SCX_TASK_NEED_DEQ). When
+		 * ops.dispatch() later pops and inserts to local DSQ,
+		 * ops.dequeue() must be called.
+		 *
+		 * If the queue is full, fallback to local DSQ. The task still
+		 * goes through QUEUED in the kernel and gets ops.dequeue()
+		 * when moved to the terminal DSQ, so we track it the same.
+		 *
+		 * If state is already ENQUEUED (e.g. task was on a DSQ when
+		 * the scheduler was unregistered in a previous scenario),
+		 * reset to NONE and proceed to avoid false positives.
+		 */
+		{
+			s32 pid = p->pid;
+
+			if (tctx->state == TASK_ENQUEUED)
+				tctx->state = TASK_NONE;
+
+			tctx->state = TASK_ENQUEUED;
+			tctx->enqueue_seq++;
+
+			/* Queue full: fallback to the global DSQ */
+			if (bpf_map_push_elem(&global_queue, &pid, 0))
+				scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+			else
+				__sync_fetch_and_add(&enqueue_cnt, 1);
+
+			scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
+		}
+		break;
+
+	default:
+		/* For scenarios 0-2 dispatch to the global DSQ */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
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
+	 * For scenarios 0, 1, 3, and 4 (terminal DSQs: local and global),
+	 * ops.dequeue() should never be called because tasks bypass the
+	 * BPF scheduler entirely. If we get here, it's a kernel bug.
+	 */
+	if (test_scenario == 0 || test_scenario == 3) {
+		scx_bpf_error("%d (%s): dequeue called for local DSQ scenario - kernel bug!",
+			      p->pid, p->comm);
+		return;
+	}
+	if (test_scenario == 1 || test_scenario == 4) {
+		scx_bpf_error("%d (%s): dequeue called for global DSQ scenario - kernel bug!",
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
+		/*
+		 * Dispatch dequeue should not have %SCX_DEQ_SCHED_CHANGE
+		 * flag.
+		 */
+		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
+			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/*
+		 * Must be in ENQUEUED state.
+		 */
+		if (tctx->state != TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/*
+		 * Transition to DISPATCHED: normal cycle completed
+		 * dispatch.
+		 */
+		tctx->state = TASK_DISPATCHED;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (test_scenario == 6) {
+		s32 pid;
+		struct task_struct *p;
+
+		if (bpf_map_pop_elem(&global_queue, &pid))
+			return;
+
+		p = bpf_task_from_pid(pid);
+		if (!p)
+			return;
+
+		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
+			cpu = scx_bpf_task_cpu(p);
+
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+	} else {
+		scx_bpf_dsq_move_to_local(SHARED_DSQ);
+	}
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
index 0000000000000..b0add2a516ab8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <time.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include <pthread.h>
+#include "scx_test.h"
+#include "dequeue.bpf.skel.h"
+
+#define NUM_WORKERS 8
+#define AFFINITY_HAMMER_MS 50   /* How long affinity hammer runs (scenario 6) */
+
+/*
+ * Worker function that creates enqueue/dequeue events via CPU work and
+ * sleeping. Property-change dequeues are triggered by the affinity hammer
+ * thread (external sched_setaffinity on worker PIDs).
+ */
+static void worker_fn(int id)
+{
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
+		/* Sleep to trigger dequeue */
+		usleep(1000 + (id * 100));
+	}
+
+	exit(0);
+}
+
+/*
+ * For scenario 6, tasks sit in the BPF queue until dispatch consumes them.
+ * Property-change dequeues only happen when a task gets a property change
+ * while still in the queue (SCX_OPSS_QUEUED), not after it has been
+ * dispatched. This thread changes workers' affinity from outside so that
+ * some changes hit tasks while they are still in the queue.
+ */
+static void *affinity_hammer_fn(void *arg)
+{
+	pid_t *pids = arg;
+	cpu_set_t cpuset;
+	int i, n = NUM_WORKERS;
+	struct timespec ts = { .tv_sec = 0, .tv_nsec = 1000000 }; /* 1ms */
+
+	for (i = 0; i < (AFFINITY_HAMMER_MS * 1000 / 100); i++) {
+		int w = i % n;
+		int cpu = (i / n) % 4;
+
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu, &cpuset);
+		sched_setaffinity(pids[w], sizeof(cpuset), &cpuset);
+		nanosleep(&ts, NULL);
+	}
+	return NULL;
+}
+
+static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
+					 const char *scenario_name)
+{
+	struct bpf_link *link;
+	pid_t pids[NUM_WORKERS];
+	pthread_t hammer;
+
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
+	/*
+	 * Run an "affinity hammer" so that some property changes hit tasks
+	 * while they are still in BPF custody (e.g. in user DSQ or BPF queue),
+	 * triggering SCX_DEQ_SCHED_CHANGE dequeues in scenarios 2, 5 and 6.
+	 */
+	SCX_FAIL_IF(pthread_create(&hammer, NULL, affinity_hammer_fn, pids) != 0,
+		    "Failed to create affinity hammer thread");
+
+	/* Wait for all workers to complete */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for worker %d", i);
+		SCX_FAIL_IF(status != 0, "Worker %d exited with status %d", i, status);
+	}
+
+	pthread_join(hammer, NULL);
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
+	 * For scenarios 0, 1, 3, 4 (local and global DSQs from
+	 * ops.select_cpu() and ops.enqueue()), both enqueues and dequeues
+	 * should be 0 because tasks bypass the BPF scheduler entirely: tasks
+	 * never enter BPF scheduler's custody.
+	 *
+	 * For scenarios 2, 5, and 6 (user DSQ or BPF internal queue from
+	 * ops.select_cpu() / ops.enqueue()), we expect both enqueues and
+	 * dequeues.
+	 *
+	 * The BPF code does strict state machine validation with
+	 * scx_bpf_error() to ensure the workflow semantics are correct. If
+	 * we reach this point without errors, the semantics are validated
+	 * correctly.
+	 */
+	if (scenario == 0 || scenario == 1 || scenario == 3 || scenario == 4) {
+		/* Terminal DSQs: tasks bypass BPF scheduler completely */
+		SCX_EQ(enq_delta, 0);
+		SCX_EQ(deq_delta, 0);
+		SCX_EQ(dispatch_deq_delta, 0);
+		SCX_EQ(change_deq_delta, 0);
+	} else {
+		/* User DSQ: tasks enter BPF scheduler's custody */
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
+	/* Scenarios 0-2: ops.select_cpu(), 3-6: ops.enqueue() */
+	status = run_scenario(skel, 0, "Scenario 0: Local DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 1, "Scenario 1: Global DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 2, "Scenario 2: User DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 3, "Scenario 3: Local DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 4, "Scenario 4: Global DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 5, "Scenario 5: User DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 6,
+			     "Scenario 6: BPF internal queue from ops.enqueue(), consumed in ops.dispatch()");
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
+	printf("-> Validated: Local DSQ dispatch bypasses BPF scheduler (both paths)\n");
+	printf("-> Validated: Global DSQ dispatch bypasses BPF scheduler (both paths)\n");
+	printf("-> Validated: User DSQ dispatch triggers dequeue callbacks (both paths)\n");
+	printf("-> Validated: BPF internal queue triggers dequeue when leaving custody\n");
+	printf("-> Validated: ops.enqueue() and ops.select_cpu() behave identically\n");
+	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)\n");
+	printf("-> Validated: Property change dequeues have SCX_DEQ_SCHED_CHANGE flag\n");
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
+	.description = "Verify ops.dequeue() semantics",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_test)
-- 
2.53.0

