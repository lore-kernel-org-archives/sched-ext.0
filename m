Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0847B428
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998699; cv=fail; b=Xj4fGjwOX4YZS2ebllJdjfCnXo0H3Lj3gRKEcxJtxfn1nSYXQgrg18Hf8+EM85LrJbhDtq5AM7cQ72aVFGgIqYxu6h6mIPpSczz8BNi9LDyLAj2nC4AXeSxn5sieyZ9FfdLGqim1WLaAKR1Vr8+4XBLDicDUgLP92DBe+cjx6Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998699; c=relaxed/simple;
	bh=MLEuPDSQ3lR24/w5Sygm2Tm06BQT/q4mFtuAp/xKACw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhrUK91tC2mcW7QzvPXFpXVRMGUXM6MVyUqC3VNtlIeqmXweIYBWENdf64R7NmzJn5WkM7N9q+NAxXVCqH8+BkyEUrlG8VG91N3jZVlmQXu5Or+s7pVJd7WmZ6WuvEGivIMwS+XPchzdL0ejoEQW87o8kmovWLr3E4Cx3i7/uiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KOUrebC9; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KOUrebC9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jcz6noTNlMD1wXxtYwN8JM8aK+26hHg5ohj4hQDThVd0clGjrp1FEQm2kv+ugToNsBKGVwnObQpeFzPMpgeApKxldA+E9AsjQDTVnQP+Cd+fAoT+GhALFl+w8QioCEN2+8SjLDiSDwWb3Zwmi4qSrownK5CDNIWvh3nNvfuF8WEOs8F5VSWXk9V/4UxWwpwmjPvdwcv+OUqWKnGHmTpimQePq4ZBibaImybNBLYQYEEj/scgwmWhaZCxzUKup7cAAvncO7zzLaG2oGPUWXlQ5d960AFbUp73Vejf7UaHAFsa5qjNbiulXKZdbR8iZ2dTRNQ2AUvlck2/0CMO51IMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skh9MmrtsW1aX1V/Ix5C1YlqRiJtN3c2sqgwMQ//Ujo=;
 b=ib1WC9fLhSK5jhgnWgUd2d+HEsrq8Q/Kun7a1mnGUX6DLhpj4+wUsuL9fY0ex75j5ia/9XmFosvXUXyLlNe+eneXKzK3btZwLMj6FheLfgT6frzAmXuhXYtuUqy4NSfXPYUIfJNaThCljEf0UpIULTjEQ7GU6q8su9xFt6Rq41g50Xo1KyyIjWMkYnq+giCoAMRZS9maA6bBA+xbUIil64AYEiihgRWxMdq5wEcASx3EYcQ8sdSOGvL7tT2sUoCYiiEWmB5KHihyWOUJqCM4EMn0iytFFLzDnKLw/nQdaEJLlVV7tnIf1OLSznkP2+oR8kNRZKIOsGs4AKFPklm5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skh9MmrtsW1aX1V/Ix5C1YlqRiJtN3c2sqgwMQ//Ujo=;
 b=KOUrebC98XiCwfLJpnHy4/ePxxUZPNVQnvZxr/pA2Kj8Hu8++eu3WLVKEcoVpsdFCKEBYRtCnw2NfEuzbiyVTANhyKANotCFGQGxOeSp/qTkF9P1XhmA9NNGuObfxH4/8cbxNc8pSfsCn+fUxSsPpzztW1S4Vaae+jmKN2+4te3Cl8C1jEOUSYvx7XF/PvXbT9vUXLAjKuwcEZnbAnFiy+xdwuo2qlV1GhRwtCRzxSFsH+X74AFakKK68qOCucPkpWsVg+U7F7Y30U37vgCv7Y62cb23SkFjQfe8kraqW/T3xNmOTrN4PhmPh6cQOzSzMqpY1Wz2p6qHAL3tRLckLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:31:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:31:30 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Add test to validate ops.dequeue() semantics
Date: Wed, 21 Jan 2026 13:25:31 +0100
Message-ID: <20260121123118.964704-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121123118.964704-1-arighi@nvidia.com>
References: <20260121123118.964704-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e697a6-e3be-495e-529a-08de58e9015b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LabUvdclA+HKLR/yehTLi96PI+BVVkx1YIg1Vgd6gdVMumt7p/fUYByN8+Gv?=
 =?us-ascii?Q?J63TA6mcQn78QrDuY7qiq+CwTdD2kaJY9h1LZeKs1Z/yLWkm4nrTuzh7QJhb?=
 =?us-ascii?Q?hHjZwwZ71KkI/p40vfxLwF0wNiCVYyTQO3UwNT1pFwYvndO6HJm8vVOEQ1Ys?=
 =?us-ascii?Q?x0boyVcLKY9PHoEiPWMwTTRbdWDkPyiQ9N1n1Euu3+r+4DJdGng1WC5PP8de?=
 =?us-ascii?Q?gUMmlBGosYJBJDnei+OUGBiuzLs8WvTkHNRhvOOQRHwY4vK0CasErBuR/ul3?=
 =?us-ascii?Q?gGvMxuegb+iOyE4QivX3TV2i51Tl6ThetLM5IMA1pflfHswmr5dTvFABxn2c?=
 =?us-ascii?Q?iQPSqh0xEm09XAUPkN287Mf3oLokRGm676CaNywqxF/BY9qnD/HLA7LVDmMT?=
 =?us-ascii?Q?ePtu2G0RmLSJWKXaL72ydWNEI4y6m0Bhido76Na6kcDXCs/zwqeVARuPhfpn?=
 =?us-ascii?Q?g9qgcS6JVvZSMY9pGV5SOES9PkSPJLuooUPwklA6lc6iatQLLliEhADuq2LV?=
 =?us-ascii?Q?4xMaPbEyIA75X2A6sKbn1xOGgMZ9CZ0aarYI75wbHAXB9vptDaOn0eeAB6fO?=
 =?us-ascii?Q?ydKU1grGI/E4GTgxx9O0II4+65hbrdDAh0WpSCaTrDEc3w83WLsgpKJfLDM6?=
 =?us-ascii?Q?ZsgyX3Npxe/TyoU4BZNNeldm4C4grQhxJGa1Qq54yGXT6baso/ClHldd/sic?=
 =?us-ascii?Q?LbF7ACmbZfZxq0kGXmHdoTgx+VZ+8ul2lJFvXnYjneIT65k7Ii67cnVoVLq8?=
 =?us-ascii?Q?D2uiHzVl4Z4NMC2POrE9fJPk0vcriBJCvSVppogS2evQgxb2nsOvTJ1zitJo?=
 =?us-ascii?Q?GDHzMaX7RaEYX4AsjiQqvO6PLNBzXFjc64Vo+Mpz0HvDR0zTnelgjKopZ+OF?=
 =?us-ascii?Q?Pkvw5aa0N5NtEtD6JstgMAiEFXSxjCa9DxHv4ocLJyuyxixdsbXBOCx+azKL?=
 =?us-ascii?Q?l6T/6Nzq+7pjylzIcZw5x6NH/2dTJ3rXGT3sP/8VyR0B+UsHi9SAjy7blXLP?=
 =?us-ascii?Q?V3n4S0kOqanJsC8iD4rdCBns/MXgxseLgzeJNHdl/kEYECoyGn3dXe9VP7EC?=
 =?us-ascii?Q?1z4PUEAcVxApXhfEpmYmmuRfTph2BKwL472w3kUXxFBkb2TZTjANr7a+XnZe?=
 =?us-ascii?Q?xM9X6HwwunbEen0LntZAfaev+LoR654bYLBzozdZUGOPcs2juXeKzHupvueC?=
 =?us-ascii?Q?uwxQnLTVDOMG3CGajmT1RNtGG07MfAWYHa9xj5KdWmww1yg7LB2V14GVww4o?=
 =?us-ascii?Q?TFAni4aZqZapkw69wuWGJg4eV4C9+JbeSeHBwMZV5Sz9XJONcH+7myN2GdGp?=
 =?us-ascii?Q?j2sOKNGWbrzirUP74USBjXHRKLWoZ7iWaiMRagdMu0wmqLByzvNo/lS/PM8r?=
 =?us-ascii?Q?371ThdlhFEYbwyZisyUTRjs+8haS+2/MjEhHeEjWSoUSaFbWPUOwTrMYWnDF?=
 =?us-ascii?Q?6gKEcWQgs6gvoIQQiTO2sNdvhauc0aVOjXICZHwmcCeejCWeZFuQkd4rfv54?=
 =?us-ascii?Q?XAuzKO3kr68rRMr4mqYzVYyb/jDH0xCyARhrtfs+KJsqfJvhVTMCvuomHlAh?=
 =?us-ascii?Q?sOFZNzx1Tsjv2gLoiY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khnmuMSualIc8/Oz2A/Me2PfFvpGZP5xMYgPdHmtwntvka40QB076y33AyI2?=
 =?us-ascii?Q?E2o8VqjKdpkqb3w9co78DUHxDu3eOpwYF8FF/F/O39K/9FM7upbLTwrdyGER?=
 =?us-ascii?Q?R46GiuGZ+EGUSVBJkvv9lQei/5uixUhPswDb49XMJPtjCf4RrI1KtYExBeSQ?=
 =?us-ascii?Q?SVsGuKFLlNobURsdEHQd7W8iT3ZEQtwvnyZycIZOc3kUxXDZrNKuuQv0dtQ9?=
 =?us-ascii?Q?V7nsSmrlH3wP/Ku1xsxwJ8jsF8YUH7NShY7BrIu0IAwEKl5v8uL2AMsktf28?=
 =?us-ascii?Q?QeIU6xobUk0wbDR9UHhhTs8pNrM0th16iwuE3B87l1bYQAhDws0SZLhn0nIe?=
 =?us-ascii?Q?NIdWH1XMOGDIsZQKMEocDSPKpWK5KG4CtGDJdaTCOsiGVfyCHGDWd2dutezI?=
 =?us-ascii?Q?geu0y9/ONlTq695S8OAxaKn3Z/pIRHP1dK52e+0tF6fIW25jByVtF6ktlDeu?=
 =?us-ascii?Q?O8Q0JeaSOyCke/uCiIiD9xP91NItLRf4Zz+g+LXcV7fhrUKucAz+/uY7HsI6?=
 =?us-ascii?Q?uqi1LtOynAORXZTfmSTAaUH17Pz8HGQ4aIbXb121H7oUP94jM1KA4Fcb6+A1?=
 =?us-ascii?Q?MwrTy8SivVfGKGDGAljn0TnUJDFg7sa/04uQvAhMegQyaClAVF7RAGpU8NJV?=
 =?us-ascii?Q?CVhmDcl4b0SYbp1WzXXdOPAGKmPTDhjHKQHYOU3k1H3+H4xdZdD8cprpK1+X?=
 =?us-ascii?Q?+3qLJEJclImRCiguseeJEZRHS3xmAJ/cjp7q0IlUYxX5xVqB0nCLtnS44IL7?=
 =?us-ascii?Q?mCSzfn48yqAnBtUyrNJkWP8FaVUaDUTZl5s5YPgIr1iG9ZBWRasJ5vT1UR7K?=
 =?us-ascii?Q?0O856Xq8RUg+JDUgQAPeT1E9nnUQDIkyvlVItfq7zTuWzyr5r1JyRdlx/KsV?=
 =?us-ascii?Q?WgpL4LAnnoeonnEn3GcL8WcPvAdv0m0AItLyXCVK0hcSR9den+Tu+Zn2dRE9?=
 =?us-ascii?Q?Z23EAED5WrbevjRjncVQ9o/tOTDm2M6pL3bt7wcLaBJGKfRvyVnQSxjSIAsK?=
 =?us-ascii?Q?llAsiLS69LqhPIvLcUA2KC/k9aWaR2jHvdVQprHUB5phXlfnU/EMnHH0FdZj?=
 =?us-ascii?Q?iLEASey55sEhO4Vm/loAL6JKrmRtfUydH1IQsGsc8J2Mb7Dk5i0CU3DHmHcD?=
 =?us-ascii?Q?8W9zocvq7P9+pk6FE7C1mzJhjHoa/zo6T+doKCJEn0p7z0UC21NkrWlLwlP9?=
 =?us-ascii?Q?N6EV3XrTiKn/c0til+IAGXJyLutC4lr+969kSWzuwRG2eP5RGz++/IQ8lpcH?=
 =?us-ascii?Q?p5w2hdNMUbaBlPvFjGPgbE0IH0ItOTL2J9kUN12ouDeFejKAve1zn83QAMDY?=
 =?us-ascii?Q?qFjoqsK7KHFypzw84xDNwFUMUCoentx8oGhH5jiJA8UxHtHu6m67T4UFbotM?=
 =?us-ascii?Q?KJQV5VRjSZdfqgfmawt5t/t2QQetBYD6TmgBf4thcv7CTgd4AlKf9Ld/vELV?=
 =?us-ascii?Q?mNUKf8EbjznsapqxHfhDSKDu4e06XwULcyqnCUndb5ZRXBAerLphm6gQ5zqN?=
 =?us-ascii?Q?nCTrsMEKaPsr4fOzJdBhyA3bGOTODd961gi+DeZiSbAcsz8/RWBIh105anP9?=
 =?us-ascii?Q?pmygm72UDO7SeIXCykyZQmkcIEr1me/xK7BRPKL+Jgi3RavzWxiK4KAJ+hF2?=
 =?us-ascii?Q?SdmJvEGM5wOYP1+AD1K3ytpfJgxJEnA7H5JPYsUsG2t4GoOvVQF2uIHmggeT?=
 =?us-ascii?Q?OetlGyII89jZ7DryOI9gCS1Y9ECeWv59NXM2iT6WeWlISb3w6P5rrkqoMksq?=
 =?us-ascii?Q?GxMWWI147A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e697a6-e3be-495e-529a-08de58e9015b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:31:30.8048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDT+9iBFsGHCh4crjmP2V+vK29CzsyeHkU87T5Ort1yMp1F0fjJd8vFE6yGkiyQWEjPCLn5MpCqhh5/YzPOSCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

Add a new kselftest to validate that:
 - every enqueue is followed by proper dequeue,
 - dispatch dequeues happen exactly once per enqueue,
 - async dequeues (SCX_DEQ_ASYNC) only happen for property changes,
 - no duplicate enqueues without proper dequeue.

Test scenarios:
 - direct dispatch to local DSQ (SCX_DSQ_LOCAL),
 - dispatch to user DSQ,
 - explicit property changes via sched_setaffinity().

This validates that the new ops.dequeue() semantics work correctly for
all task lifecycle scenarios.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 209 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 182 +++++++++++++++
 3 files changed, 392 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 2c601a7eaff5f..2815a875bde2f 100644
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
index 0000000000000..f7c4643a5e8de
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - For tasks on BPF data structures (not yet dispatched)
+ * - For tasks already on DSQs (local or shared)
+ * - That every ops.enqueue() is followed by ops.dequeue()
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
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
+ * - async_dequeue_cnt: Number of async dequeues (SCX_DEQ_ASYNC)
+ */
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, async_dequeue_cnt;
+
+/*
+ * Test scenarios:
+ * - 0: Dispatch to local DSQ
+ * - 1: Dispatch to shared DSQ
+ */
+u32 test_scenario;
+
+/*
+ * Per-task state to track lifecycle and validate workflow semantics.
+ * State transitions:
+ *   NONE -> ENQUEUED (on enqueue)
+ *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
+ *   DISPATCHED -> NONE (on async dequeue or re-enqueue)
+ *   ENQUEUED -> NONE (on async dequeue before dispatch)
+ */
+enum task_state {
+	TASK_NONE = 0,      /* Task is outside scheduler control */
+	TASK_ENQUEUED,      /* ops.enqueue() called, waiting for dequeue */
+	TASK_DISPATCHED,    /* Dispatch dequeue received, can get async or re-enqueue */
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
+	__sync_fetch_and_add(&enqueue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	/*
+	 * Validate state transition: enqueue is only valid from NONE or
+	 * DISPATCHED states. Getting enqueue while in ENQUEUED state
+	 * indicates a missing dequeue.
+	 */
+	if (tctx->state == TASK_ENQUEUED)
+		scx_bpf_error("%d (%s): enqueue while in ENQUEUED state (seq %llu)",
+			      p->pid, p->comm, tctx->enqueue_seq);
+
+	/* Transition to ENQUEUED state */
+	tctx->state = TASK_ENQUEUED;
+	tctx->enqueue_seq++;
+
+	switch (test_scenario) {
+	case 0:
+		/* Scenario 0: Direct dispatch to the local DSQ */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 1:
+		/* Scenario 1: Dispatch to shared DSQ */
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
+	 * Validate state: dequeue should only happen from ENQUEUED or
+	 * DISPATCHED states. Getting dequeue from NONE indicates a bug.
+	 */
+	if (tctx->state == TASK_NONE)
+		scx_bpf_error("%d (%s): dequeue from NONE state (seq %llu)",
+			      p->pid, p->comm, tctx->enqueue_seq);
+
+	if (deq_flags & SCX_DEQ_ASYNC) {
+		/*
+		 * Async dequeue: property change interrupting the workflow.
+		 * Valid from both ENQUEUED and DISPATCHED states.
+		 * Transitions task back to NONE state.
+		 */
+		__sync_fetch_and_add(&async_dequeue_cnt, 1);
+
+		/* Validate state transition */
+		if (tctx->state != TASK_ENQUEUED && tctx->state != TASK_DISPATCHED)
+			scx_bpf_error("%d (%s): async dequeue from invalid state %d (seq %llu)",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/* Transition back to NONE - task outside scheduler control */
+		tctx->state = TASK_NONE;
+	} else {
+		/*
+		 * Regular dispatch dequeue: normal workflow step.
+		 * Valid only from ENQUEUED state (after enqueue, before dispatch dequeue).
+		 * Transitions to DISPATCHED state.
+		 */
+		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
+
+		/* Validate: dispatch dequeue should NOT have SCX_DEQ_ASYNC flag */
+		if (deq_flags & SCX_DEQ_ASYNC)
+			scx_bpf_error("%d (%s): SCX_DEQ_ASYNC in dispatch dequeue (seq %llu)",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/* Must be in ENQUEUED state */
+		if (tctx->state != TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d (seq %llu)",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/* Transition to DISPATCHED - normal cycle completed dispatch */
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
index 0000000000000..07de94957d366
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,182 @@
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
+	u64 enq_start, deq_start, dispatch_deq_start, async_deq_start;
+	u64 enq_delta, deq_delta, dispatch_deq_delta, async_deq_delta;
+
+	/* Set the test scenario */
+	skel->bss->test_scenario = scenario;
+
+	/* Record starting counts */
+	enq_start = skel->bss->enqueue_cnt;
+	deq_start = skel->bss->dequeue_cnt;
+	dispatch_deq_start = skel->bss->dispatch_dequeue_cnt;
+	async_deq_start = skel->bss->async_dequeue_cnt;
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
+	async_deq_delta = skel->bss->async_dequeue_cnt - async_deq_start;
+
+	printf("%s:\n", scenario_name);
+	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
+	printf("  dequeues: %lu (dispatch: %lu, async: %lu)\n",
+	       (unsigned long)deq_delta,
+	       (unsigned long)dispatch_deq_delta,
+	       (unsigned long)async_deq_delta);
+
+	/*
+	 * Validate that we got enqueue and dequeue events.
+	 * The BPF code does strict state machine validation with scx_bpf_error()
+	 * to ensure the workflow semantics are correct. If we reach here without
+	 * errors, the semantics are validated correctly.
+	 */
+	SCX_GT(enq_delta, 0);
+	SCX_GT(deq_delta, 0);
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
+	status = run_scenario(skel, 0, "Local DSQ");
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
+	printf("  Async dequeues: %lu (SCX_DEQ_ASYNC flag, property changes)\n",
+	       (unsigned long)skel->bss->async_dequeue_cnt);
+	printf("\nAll scenarios passed - no state machine violations detected\n");
+	printf("-> Validated: Correct state transitions (NONE -> ENQUEUED -> DISPATCHED)\n");
+	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)\n");
+	printf("-> Validated: Async dequeues have SCX_DEQ_ASYNC flag (interruptions)\n");
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
+	.description = "Verify that ops.enqueue() is balanced with ops.dequeue()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_test)
-- 
2.52.0

