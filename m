Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70023CBE6F
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149059; cv=fail; b=cWd8XU5nD4OviRWEvOL1gYPwCm74pCfLV+MLVgUTSOZoZ6JTKLW5WaADSlTP+btGUKaauSIqrdEwwG1sHf5fR3+IV8aNbbU8W+fk+0IyoQzIOQFMLA9hknuCcGR7c4+OKNbjWGfEGheBd7A8FADnJvcR/SgTXczwECUk+2VloWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149059; c=relaxed/simple;
	bh=49+3VAEs/pQ7JvgkBK0U2nH8I2wCny5fsGoPcm038KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZvuFfvWCoVxJEf+aLAIPFNktRoOo2Pn4QT0IRcJIwHIfx4Yum65YY5gE9GyLQ7ViAeRVBhPKtfQR+xZ/E8rSDjvbF3/dPN29f6dqFXFZtQlCOf1qkkHQXVNqdJBWxtM2PiGWH1dEr0/qAe7p0GbZDs/dLZ+AC2cO87eGzpoY04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MiA2RLyi; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MiA2RLyi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDiesopozOzXe1trAtLAys22m3z8hUFSLm7huifKtwhxgUz2qq2kZMLg5Ys45+nNANPc/np7lRmGTziYcA5Ry63iHXj9LzEkj4yzr8YLCdLS+hUQGqDpPyIHHw+f1Eor/fnWVFDb7VdEmYPUjusbvqcTSFtAsrxXqPwOEokj/pL49JR+SV+jjefRGYUTlxys/fe5M7p2cjBwmYLy1YfHI3ofSuFZ349yb5OmLYYN1AeenwnDs5N8yk95gtjbWGxR+HgQ38fye25GmcRTZp5fCGnCGTM7lh4FncrIRINOlQ5aIpiJf0p5m7LL5lsK73bWfrZhhwDnS3RG2S4DRKKNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vybciGX3pu6XhB3hmsXMb62apvfhr59ZOjCP+mvhnnw=;
 b=HjSEN8Sh7cCJmNATEhVV+9z8ChHz6HMkCz7BgjbWlO0xaxHv27zKOs/J8BaUJ2pQkaihFKWGpC2JZW3jnY8zoqFhcFYhF37qRmOsuaJ82IZrwkTFv1Jf1OKz1URElZ8H1cE0RcqpnHX3zpfCflFe6ciqOdp6QiDGK4ELa/PXj+eIRUPwlWgZz30oytWcMipSW2Ki7lEBbzeKcapvw5R4hM+ayH2dDPvQlfhO0Tf2/0JX3i5EeNviUQX6+rhXPMxA1TsP3EMUT08YVBCzqdDr71ur+ycfL4nrfxftaUQy1X+eahW8pxQEdb/jJ7S4GenphujtxFweKvD2p3/I9HNlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vybciGX3pu6XhB3hmsXMb62apvfhr59ZOjCP+mvhnnw=;
 b=MiA2RLyisJGe0VX4mNNw+pBB0FRSiMb6xq8t8PacCXLl4naW9IvSDEvR9IDQLzHMcC2aol8I+yisbTgIPy1ki2/CQTMwVH48s+WQ4YGWinbbHZ2CrzcwsnT1K4ameAsu1uW4gD0TvbsVGZ1QITlOZ+ANgLR93wgPvzO3XhacZmKSh416Qr29OSLail58Uy9U5XTEqLl4hMvzJDq/eYcER2WhvXN8fWeBZKTqInE1XaqooA9lQ82F11KHgqCu6HV00OLncY3MCkwI6GaF6gyoPW3iGGInkEoOhqKM6gvJYYa+PkOMiUTRv/w/CBcr1RqLM/mtOE3RemgjeaEhXFeouA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:57:24 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:57:24 +0000
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
Subject: [PATCH 09/11] sched_ext: Add selftest for blocked donor admission
Date: Wed, 15 Jul 2026 22:54:17 +0200
Message-ID: <20260715205622.276220-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: a01dbc60-9660-4153-1129-08dee2b3ab3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|3023799007|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5F6M5EgN9bKa2DxuERp4ewoUyxbciniKlKxvXICrZFb8tc4ZGMl/T0qQ0lYdKbL/nZMM+JCAwVyU9Lam4skPNFxmNCQREY4jIcZq9EmUBpYhLwOcLMMnmuZwGvaZQnobe6v58xk1+aW0GBI6LD35/upS6YyjqvjO9npdSSdlsT1s+guDKDSO8GvmNWADZnNJ/QFip+ihi95/gjT1NMiRPQGC47prnSQKbxhajniLMDO8PRo9UmlEhEqMRLMvdX9zOO1373WP6Ak+9ilxAwbHjovqZbhGCy/uRPSu4+roVE/axEFRXM4lFoGaS0ueJJricY4Ms6XKzp5ekwJs+Xn/OludGvspCYTxmzwv20SjBgC3nwYHLLfKo1wo3iOcuT57OoUluO25VVrCSU6RyL++obJOqmvkTUENjTNLuZvu1K7lN8sA0e5Xsca0Y35M7xx15jOFyOia+gdmOR6Iouy3uqn9torB1id3vsY1mlS/vltgpPJ165AMFfzm69eud7UHxBkxj670/pIyLzrgM6tCygY/V3nr89KpWirOsPmZecMA98p7AxM/4zJAMeViA2f7rm3m2xZhkykhfGTbjHxljgAV4Vp7BTQmgt1DUGr026l9SD1ZOArshwkBLig6t3Ucz4Iro/i4VmhQm3aGxQvxeWGGtZ/ZB4pEYpHF6xJiK0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5U0eRH93Ao74vMnbdxI3Gwhg5DzBeZeT20VQW0A5bvVYF2gnkL4dSX8JA/4?=
 =?us-ascii?Q?VRBejE4BYl2X9/E422U0ZPg3f/jFYzap44Om5wn1dd9kfUpwMff1v1NtpCu9?=
 =?us-ascii?Q?Uz6H8ncqtiWoI0Bkva19CiZDxfrCvJPcqBFBqawFG0jQ8zR4/+CQHo/SH8YA?=
 =?us-ascii?Q?qjDzkcJfgHhC3WZBJvdORx86uzLKPRDFKnT7/XizD/9RyhIP3DrBOjFVVCBc?=
 =?us-ascii?Q?pdRyl7cvfVxrgUiiu/UHjhJOc9g1p33sLngo29OcNVsPrtqNBAGBTJX6s231?=
 =?us-ascii?Q?9wY+aX7scKh1+1d0HHu5Hw9hFAWarZ9l9xLi5EcteARywDvYlz/Jft50+CV/?=
 =?us-ascii?Q?r086Iggygy7aACcjdmiIcFHCBjqq6jD5dEdwWyvzWt2OA5+4Oq9cUZyUJyYi?=
 =?us-ascii?Q?U/XFsyejIQSM4bE4bQmWd7ybM1ChuwoSeazqROB0nOJ/1BoY6SlgfsuJR1Ys?=
 =?us-ascii?Q?2tEv21DLxIMVB+teFn7Gyz1zX5UaOaA6hiwiU/WVT8rBvJ40h6AjLqfwy8y/?=
 =?us-ascii?Q?t7tObG7GM8Re7kvDIPyT876N6CX4PAqwxe7phKveb7M1N+Qxv4LfrIhAubJW?=
 =?us-ascii?Q?Z0OR7UOW6XWao/5Ei/OrlqD/lD6DjhF7h3kXb2vLqTuEZ1J2TWVLWLOi1bdr?=
 =?us-ascii?Q?EK6yxo4BPVBBcJK60U41bhG7x9mQhVBQiB17NJOxtU4FvRUY22LVWx2DwWwi?=
 =?us-ascii?Q?d35ZjClY4KwdEITw6KKJXL812OsvKTr7/l9RLm+GwrACCKUFk60JtFjcbEti?=
 =?us-ascii?Q?nUm/QL9HvQfck3bp872jUlCOINXQ5B63yY2GZx826ROC4ivKvJ0BytkS6fHq?=
 =?us-ascii?Q?bOQQRvnO61j0X7rjXFGEaPkx9tJF10eFTlM/pQxDv665FyseQzDLPcSMMPvN?=
 =?us-ascii?Q?MMyQYtoW3mehPKHAECtp8gYk10VIoxx9yn7EDwgrj3OeIU1i1Da+EsjgDFFR?=
 =?us-ascii?Q?wfWDry/uEjDKBA27BaysGDWiq2PR5NU7ChE6xxRwwsA/cNdhMn0rH4JDmGnD?=
 =?us-ascii?Q?9sbVu3wfzWEG4YK6GLmgisMnAxRswPD6qNWh4S5LqsVgiLK14L6sPLsv47JR?=
 =?us-ascii?Q?KeGQeNisdI2LFtV97h1N2Y+moJyh000Lz67xpkvXPf5BMqnAmImhdVcbWIuk?=
 =?us-ascii?Q?dJjiZvgKc2WKnGfupPdo6mwHWsRVoEhMtxTUW6nQyZpULRfxPxJkshE0vqHg?=
 =?us-ascii?Q?2NZSvDt3Qm2jLhlq6wrulFPXh9WEdFdx/j+D1w6uCdfogHRhkAknBF4eCHNB?=
 =?us-ascii?Q?ymruU3fzLCI4JTBI0EeBhstiyKYDmVVuk+KkJGYy/UnXsZidUHY8V4ncqAOS?=
 =?us-ascii?Q?0xqzHp7mWm/CsMreExXp/fRtWo3+hkeIDg+G3F1tx++ZpktY5qcW1cDvzL5Y?=
 =?us-ascii?Q?d69M2NBdjF+WCs0AxKJxcYE+azi/BB76jaaZHnCDgZ8Ne4dfWTfIy7XjQCr/?=
 =?us-ascii?Q?+2cucd1wJ3Sx+fpZCfg47wl/DTmVazQYOUvmVmWd2OjlQco2nL/M7MdEdzvF?=
 =?us-ascii?Q?Z9WRYO/R+g43N8vwJEFhrEiHp8w5+seF5fA5Mbcku1Lzu9PXw65O/AVkIRvl?=
 =?us-ascii?Q?N2v4sFxRtpwuxw/Qv20ENp3UO8oLb1nwcWibJF1fLlF3PIBNnW9zPPkIyacd?=
 =?us-ascii?Q?XKHkRCU8H3v0M23dE7CAE7C8HV+6jvYLd5i8cu1gesJ+mBml6NziHSgeGtBs?=
 =?us-ascii?Q?/Ce8FRiAS8mg/P7KLB5MdWlA/mC3n8cT/tp5Om56o3jGr5rN9iQe+3at2BG2?=
 =?us-ascii?Q?v3zvCBHVxQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01dbc60-9660-4153-1129-08dee2b3ab3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:57:24.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv0vwEuXmkmwPuXB0Uz2bJHPK6P6weT3qPYc8MyXSFom1HUGhT21lb3bgY2IGURiWlwyqEOuhDGfCMhje5F67w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

SCX_OPS_ENQ_BLOCKED allows BPF schedulers to receive blocked proxy
donors through ops.enqueue(). SCX_ENQ_BLOCKED identifies blocked-donor
admission requests. Add selftest coverage for this interface.

Exercise a priority inversion using a weighted-vruntime BPF scheduler.
A nice +19 owner holds a shared mutex, a nice -20 donor blocks on it,
and nice 0 CPU contenders, one per allowed CPU, keep the system busy.
Test both a same-CPU topology and a cross-CPU topology with the donor
and owner on different CPUs.

Treat blocked donors according to the normal BPF ordering policy and
assign the default slice on every enqueue, as for other tasks. Run each
CPU placement configuration with SCX_OPS_ENQ_BLOCKED first disabled and
then enabled, count blocked-donor enqueues by CPU and report average
mutex hold and wait times. Reject enqueues carrying both
SCX_ENQ_WAKEUP and SCX_ENQ_BLOCKED, as full wakeups are not retained
donor admissions.

Proxy execution coverage requires CONFIG_SCHED_PROXY_EXEC=y, which the
selftest config selects. Access to the kernel mutex is provided via a
loadable kernel module, built through TEST_GEN_MODS_DIR and managed by
the test.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/.gitignore  |   4 +
 tools/testing/selftests/sched_ext/Makefile    |   2 +
 tools/testing/selftests/sched_ext/config      |   2 +
 .../selftests/sched_ext/enq_blocked.bpf.c     | 116 +++
 .../testing/selftests/sched_ext/enq_blocked.c | 908 ++++++++++++++++++
 .../testing/selftests/sched_ext/enq_blocked.h |  27 +
 .../selftests/sched_ext/test_modules/Makefile |  13 +
 .../test_modules/scx_enq_blocked_test.c       | 193 ++++
 8 files changed, 1265 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c

diff --git a/tools/testing/selftests/sched_ext/.gitignore b/tools/testing/selftests/sched_ext/.gitignore
index ae5491a114c09..54a1fd2af713d 100644
--- a/tools/testing/selftests/sched_ext/.gitignore
+++ b/tools/testing/selftests/sched_ext/.gitignore
@@ -4,3 +4,7 @@
 !Makefile
 !.gitignore
 !config
+!test_modules/
+!test_modules/scx_enq_blocked_test.c
+!test_modules/Makefile
+test_modules/*.mod.c
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 3cfe90e0f34fa..51a16b3d32d9b 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -5,6 +5,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 TEST_GEN_PROGS := runner
+TEST_GEN_MODS_DIR := test_modules
 
 # override lib.mk's default rules
 OVERRIDE_TARGETS := 1
@@ -164,6 +165,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 auto-test-targets :=			\
 	create_dsq			\
 	dequeue				\
+	enq_blocked			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/config b/tools/testing/selftests/sched_ext/config
index aa901b05c8ad6..affa3cf33470a 100644
--- a/tools/testing/selftests/sched_ext/config
+++ b/tools/testing/selftests/sched_ext/config
@@ -6,3 +6,5 @@ CONFIG_BPF=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_BTF=y
+CONFIG_EXPERT=y
+CONFIG_SCHED_PROXY_EXEC=y
diff --git a/tools/testing/selftests/sched_ext/enq_blocked.bpf.c b/tools/testing/selftests/sched_ext/enq_blocked.bpf.c
new file mode 100644
index 0000000000000..212690bf4e07b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_blocked.bpf.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ *
+ * Verify that SCX_OPS_ENQ_BLOCKED passes blocked proxy donors through
+ * ops.enqueue() and record whether callbacks occur on the donor or owner CPU.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ 0
+
+char _license[] SEC("license") = "GPL";
+
+s32 donor_pid;
+s32 donor_cpu = -1;
+s32 owner_cpu = -1;
+u64 nr_blocked_enqueues;
+u64 nr_blocked_enqueues_donor_cpu;
+u64 nr_blocked_enqueues_owner_cpu;
+u64 nr_blocked_enqueues_other_cpu;
+u64 nr_blocked_wakeups;
+static u64 vtime_now;
+
+UEI_DEFINE(uei);
+
+s32 BPF_STRUCT_OPS(enq_blocked_select_cpu,
+		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(enq_blocked_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	u64 vtime = p->scx.dsq_vtime;
+
+	if (enq_flags & SCX_ENQ_BLOCKED) {
+		int cpu = scx_bpf_task_cpu(p);
+
+		if (enq_flags & SCX_ENQ_WAKEUP)
+			__sync_fetch_and_add(&nr_blocked_wakeups, 1);
+
+		if (p->pid == donor_pid) {
+			__sync_fetch_and_add(&nr_blocked_enqueues, 1);
+			if (cpu == donor_cpu)
+				__sync_fetch_and_add(&nr_blocked_enqueues_donor_cpu, 1);
+			else if (cpu == owner_cpu)
+				__sync_fetch_and_add(&nr_blocked_enqueues_owner_cpu, 1);
+			else
+				__sync_fetch_and_add(&nr_blocked_enqueues_other_cpu, 1);
+		}
+	}
+
+	/* Limit the amount of budget an idling task can accumulate. */
+	if (time_before(vtime, vtime_now - SCX_SLICE_DFL))
+		vtime = vtime_now - SCX_SLICE_DFL;
+
+	scx_bpf_dsq_insert_vtime(p, SHARED_DSQ, SCX_SLICE_DFL, vtime,
+				 enq_flags);
+	scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
+}
+
+void BPF_STRUCT_OPS(enq_blocked_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
+}
+
+void BPF_STRUCT_OPS(enq_blocked_running, struct task_struct *p)
+{
+	if (time_before(vtime_now, p->scx.dsq_vtime))
+		vtime_now = p->scx.dsq_vtime;
+}
+
+void BPF_STRUCT_OPS(enq_blocked_stopping, struct task_struct *p, bool runnable)
+{
+	u64 delta = scale_by_task_weight_inverse(p,
+					 SCX_SLICE_DFL - p->scx.slice);
+
+	scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
+}
+
+void BPF_STRUCT_OPS(enq_blocked_enable, struct task_struct *p)
+{
+	scx_bpf_task_set_dsq_vtime(p, vtime_now);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(enq_blocked_init)
+{
+	int ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", SHARED_DSQ, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(enq_blocked_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops enq_blocked_ops = {
+	.select_cpu		= (void *)enq_blocked_select_cpu,
+	.enqueue		= (void *)enq_blocked_enqueue,
+	.dispatch		= (void *)enq_blocked_dispatch,
+	.running		= (void *)enq_blocked_running,
+	.stopping		= (void *)enq_blocked_stopping,
+	.enable			= (void *)enq_blocked_enable,
+	.init			= (void *)enq_blocked_init,
+	.exit			= (void *)enq_blocked_exit,
+	.name			= "enq_blocked",
+};
diff --git a/tools/testing/selftests/sched_ext/enq_blocked.c b/tools/testing/selftests/sched_ext/enq_blocked.c
new file mode 100644
index 0000000000000..9798b89f6d305
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_blocked.c
@@ -0,0 +1,908 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ *
+ * Exercise a priority inversion with the owner and donor first pinned to the
+ * same CPU, then with each on a different CPU. A high-priority donor blocks on
+ * a mutex held by a low-priority owner while one medium-priority contender per
+ * available CPU keeps the system busy. A weighted-vruntime BPF scheduler runs
+ * both CPU placement configurations with SCX_OPS_ENQ_BLOCKED first disabled
+ * and then enabled. The test validates blocked-donor admission and reports the
+ * average mutex hold and wait times, plus their enabled-minus-disabled deltas,
+ * for each configuration. The timing data is informational.
+ *
+ * CONFIG_SCHED_PROXY_EXEC=y is required to exercise the proxy-execution paths.
+ */
+#define _GNU_SOURCE
+
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <pthread.h>
+#include <sched.h>
+#include <scx/common.h>
+#include <stdatomic.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/resource.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "enq_blocked.bpf.skel.h"
+#include "enq_blocked.h"
+#include "scx_test.h"
+
+#define MODULE_NAME	"scx_enq_blocked_test"
+#define MODULE_FILE	"test_modules/" MODULE_NAME ".ko"
+#define DEVICE_PATH	"/dev/scx_enq_blocked"
+#define WAIT_STEP_US	1000
+#define WAIT_TIMEOUT_MS	2000
+#define NR_WARMUP_TRIALS	1
+#define NR_MEASURED_TRIALS	10
+#define NR_TRIALS	(NR_WARMUP_TRIALS + NR_MEASURED_TRIALS)
+#define JOIN_TIMEOUT_MS	((NR_TRIALS + 1) * WAIT_TIMEOUT_MS)
+#define OWNER_NICE	19
+#define DONOR_NICE	-20
+#define CONTENDER_NICE	0
+
+struct thread_ctx {
+	atomic_bool start_donor;
+	atomic_bool abort;
+	atomic_bool stop_contender;
+	atomic_bool measurement_ready;
+	atomic_int donor_pid;
+	atomic_int donor_completed;
+	int fd;
+	int donor_cpu;
+	int owner_cpu;
+};
+
+struct contender_ctx {
+	struct thread_ctx *thread_ctx;
+	atomic_int status;
+	int cpu;
+};
+
+struct run_result {
+	struct enq_blocked_stats stats;
+	u64 nr_blocked_enqueues;
+	u64 nr_blocked_enqueues_donor_cpu;
+	u64 nr_blocked_enqueues_owner_cpu;
+	u64 nr_blocked_enqueues_other_cpu;
+	u64 nr_blocked_wakeups;
+};
+
+static bool parse_bool(const char *value, bool *result)
+{
+	if (!strcasecmp(value, "1") || !strcasecmp(value, "y") ||
+	    !strcasecmp(value, "yes") || !strcasecmp(value, "on") ||
+	    !strcasecmp(value, "true")) {
+		*result = true;
+		return true;
+	}
+
+	if (!strcasecmp(value, "0") || !strcasecmp(value, "n") ||
+	    !strcasecmp(value, "no") || !strcasecmp(value, "off") ||
+	    !strcasecmp(value, "false")) {
+		*result = false;
+		return true;
+	}
+
+	return false;
+}
+
+static bool cmdline_bool(const char *name, bool default_value)
+{
+	char cmdline[4096], *newline, *saveptr = NULL, *token;
+	size_t name_len = strlen(name);
+	bool value = default_value;
+	FILE *file;
+
+	file = fopen("/proc/cmdline", "r");
+	if (!file)
+		return default_value;
+
+	if (!fgets(cmdline, sizeof(cmdline), file)) {
+		fclose(file);
+		return default_value;
+	}
+	fclose(file);
+	newline = strchr(cmdline, '\n');
+	if (newline)
+		*newline = '\0';
+
+	for (token = strtok_r(cmdline, " ", &saveptr); token;
+	     token = strtok_r(NULL, " ", &saveptr)) {
+		bool parsed;
+
+		if (strncmp(token, name, name_len) || token[name_len] != '=')
+			continue;
+		if (parse_bool(token + name_len + 1, &parsed))
+			value = parsed;
+	}
+
+	return value;
+}
+
+static int module_path(char *path, size_t size)
+{
+	ssize_t len;
+	char *slash;
+
+	len = readlink("/proc/self/exe", path, size - 1);
+	if (len < 0)
+		return -errno;
+	path[len] = '\0';
+
+	slash = strrchr(path, '/');
+	if (!slash)
+		return -EINVAL;
+	*slash = '\0';
+
+	if (snprintf(slash, size - (slash - path), "/%s", MODULE_FILE) >=
+	    size - (slash - path))
+		return -ENAMETOOLONG;
+
+	return 0;
+}
+
+static int load_test_module(bool *loaded_here)
+{
+	char path[PATH_MAX];
+	int fd, err;
+
+	err = module_path(path, sizeof(path));
+	if (err)
+		return err;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	if (syscall(SYS_finit_module, fd, "", 0)) {
+		err = errno;
+		close(fd);
+		if (err == EEXIST)
+			return 0;
+		return -err;
+	}
+
+	close(fd);
+	*loaded_here = true;
+	return 0;
+}
+
+static void unload_test_module(bool loaded_here)
+{
+	if (loaded_here && syscall(SYS_delete_module, MODULE_NAME, O_NONBLOCK))
+		SCX_ERR("Failed to unload %s (%d)", MODULE_NAME, errno);
+}
+
+static int pin_to_cpu(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	return sched_setaffinity(0, sizeof(mask), &mask) ? errno : 0;
+}
+
+static int select_test_cpus(bool cross_cpu, cpu_set_t *mask, int *donor_cpu,
+			    int *owner_cpu)
+{
+	int cpu, first = -1;
+
+	if (sched_getaffinity(0, sizeof(*mask), mask))
+		return -errno;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, mask))
+			continue;
+		if (first < 0) {
+			first = cpu;
+			if (!cross_cpu)
+				break;
+		} else {
+			*donor_cpu = first;
+			*owner_cpu = cpu;
+			return 0;
+		}
+	}
+
+	if (first < 0)
+		return -ENODEV;
+	if (cross_cpu)
+		return -EAGAIN;
+
+	*donor_cpu = first;
+	*owner_cpu = first;
+	return 0;
+}
+
+static int set_nice(int nice)
+{
+	return setpriority(PRIO_PROCESS, 0, nice) ? errno : 0;
+}
+
+static bool wait_for_pid(atomic_int *pid)
+{
+	int waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		if (atomic_load_explicit(pid, memory_order_acquire) > 0)
+			return true;
+		usleep(WAIT_STEP_US);
+	}
+
+	return false;
+}
+
+static int wait_for_contenders(struct contender_ctx *contenders,
+			       size_t nr_contenders)
+{
+	size_t i, nr_ready;
+	int status, waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		nr_ready = 0;
+		for (i = 0; i < nr_contenders; i++) {
+			status = atomic_load_explicit(&contenders[i].status,
+						      memory_order_acquire);
+			if (status < 0)
+				return status;
+			if (status > 0)
+				nr_ready++;
+		}
+		if (nr_ready == nr_contenders)
+			return 1;
+		usleep(WAIT_STEP_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int wait_for_donor_state(struct thread_ctx *ctx, int expected)
+{
+	int state, waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		state = ioctl(ctx->fd, ENQ_BLOCKED_IOCTL_DONOR_STATE);
+		if (state == expected)
+			return state;
+		if (state < 0 && errno != ENOENT)
+			return -errno;
+		usleep(WAIT_STEP_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static bool wait_for_donor(struct thread_ctx *ctx, int trial)
+{
+	int waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		if (atomic_load_explicit(&ctx->donor_completed,
+					 memory_order_acquire) >= trial)
+			return true;
+		if (atomic_load_explicit(&ctx->abort, memory_order_relaxed))
+			return false;
+		usleep(WAIT_STEP_US);
+	}
+
+	return false;
+}
+
+static bool wait_for_measurement(struct thread_ctx *ctx)
+{
+	while (!atomic_load_explicit(&ctx->measurement_ready,
+				     memory_order_acquire) &&
+	       !atomic_load_explicit(&ctx->abort, memory_order_relaxed))
+		sched_yield();
+
+	return !atomic_load_explicit(&ctx->abort, memory_order_relaxed);
+}
+
+static void *contender_fn(void *arg)
+{
+	struct contender_ctx *contender = arg;
+	struct thread_ctx *ctx = contender->thread_ctx;
+	int err;
+
+	err = pin_to_cpu(contender->cpu);
+	if (!err)
+		err = set_nice(CONTENDER_NICE);
+	atomic_store_explicit(&contender->status, err ? -err : 1,
+			      memory_order_release);
+	if (err)
+		return (void *)(uintptr_t)err;
+
+	while (!atomic_load_explicit(&ctx->stop_contender,
+				     memory_order_relaxed))
+		;
+
+	return NULL;
+}
+
+static void *owner_fn(void *arg)
+{
+	struct thread_ctx *ctx = arg;
+	int err, i;
+
+	err = pin_to_cpu(ctx->owner_cpu);
+	if (err)
+		return (void *)(uintptr_t)err;
+	err = set_nice(OWNER_NICE);
+	if (err)
+		return (void *)(uintptr_t)err;
+
+	for (i = 0; i < NR_TRIALS; i++) {
+		if (ioctl(ctx->fd, ENQ_BLOCKED_IOCTL_OWNER))
+			return (void *)(uintptr_t)errno;
+		if (!wait_for_donor(ctx, i + 1))
+			return (void *)(uintptr_t)ETIMEDOUT;
+
+		if (i + 1 == NR_WARMUP_TRIALS && !wait_for_measurement(ctx))
+			return NULL;
+	}
+
+	return NULL;
+}
+
+static int run_donor_trial(struct thread_ctx *ctx)
+{
+	int waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		if (!ioctl(ctx->fd, ENQ_BLOCKED_IOCTL_DONOR))
+			return 0;
+		if (errno != EAGAIN)
+			return -errno;
+		usleep(WAIT_STEP_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void *donor_fn(void *arg)
+{
+	struct thread_ctx *ctx = arg;
+	int err, i;
+
+	err = pin_to_cpu(ctx->donor_cpu);
+	if (err)
+		return (void *)(uintptr_t)err;
+	err = set_nice(DONOR_NICE);
+	if (err)
+		return (void *)(uintptr_t)err;
+
+	atomic_store_explicit(&ctx->donor_pid, syscall(SYS_gettid),
+			      memory_order_release);
+	while (!atomic_load_explicit(&ctx->start_donor, memory_order_acquire) &&
+	       !atomic_load_explicit(&ctx->abort, memory_order_relaxed))
+		sched_yield();
+
+	if (atomic_load_explicit(&ctx->abort, memory_order_relaxed))
+		return NULL;
+
+	for (i = 0; i < NR_TRIALS; i++) {
+		err = run_donor_trial(ctx);
+		if (err)
+			return (void *)(uintptr_t)-err;
+		atomic_store_explicit(&ctx->donor_completed, i + 1,
+				      memory_order_release);
+	}
+
+	return NULL;
+}
+
+static void print_avg_time(const char *name, u64 total_ns, u64 samples)
+{
+	u64 avg_ns = samples ? total_ns / samples : 0;
+
+	printf("  %s_avg_ns=%llu (%llu.%03llu ms, samples=%llu)\n", name,
+	       (unsigned long long)avg_ns,
+	       (unsigned long long)(avg_ns / 1000000),
+	       (unsigned long long)((avg_ns / 1000) % 1000),
+	       (unsigned long long)samples);
+}
+
+static void print_avg_delta(const char *name, u64 disabled_total,
+			    u64 disabled_samples, u64 enabled_total,
+			    u64 enabled_samples)
+{
+	u64 disabled_avg, enabled_avg;
+	s64 delta_ns;
+	double delta_pct;
+
+	if (!disabled_samples || !enabled_samples)
+		return;
+
+	disabled_avg = disabled_total / disabled_samples;
+	enabled_avg = enabled_total / enabled_samples;
+	delta_ns = (s64)enabled_avg - (s64)disabled_avg;
+	delta_pct = disabled_avg ? 100.0 * delta_ns / disabled_avg : 0.0;
+
+	printf("  %s_delta_ns=%+lld (%+.2f%%)\n", name,
+	       (long long)delta_ns, delta_pct);
+}
+
+static int join_thread(pthread_t thread, const struct timespec *deadline,
+		       int *thread_err)
+{
+	void *result;
+	int err;
+
+	err = pthread_timedjoin_np(thread, &result, deadline);
+	if (err)
+		return err;
+
+	*thread_err = (int)(uintptr_t)result;
+	return 0;
+}
+
+static void set_join_deadline(struct timespec *deadline)
+{
+	clock_gettime(CLOCK_REALTIME, deadline);
+	deadline->tv_sec += JOIN_TIMEOUT_MS / 1000;
+	deadline->tv_nsec += (JOIN_TIMEOUT_MS % 1000) * 1000000;
+	if (deadline->tv_nsec >= 1000000000) {
+		deadline->tv_sec++;
+		deadline->tv_nsec -= 1000000000;
+	}
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct enq_blocked *skel;
+	u64 flag;
+
+	skel = enq_blocked__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+
+	flag = SCX_OPS_ENQ_BLOCKED;
+	if (!flag) {
+		enq_blocked__destroy(skel);
+		fprintf(stderr, "SKIP: SCX_OPS_ENQ_BLOCKED is unavailable\n");
+		return SCX_TEST_SKIP;
+	}
+
+	enq_blocked__destroy(skel);
+	*ctx = NULL;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run_one(bool enq_blocked, bool cross_cpu,
+				    struct run_result *result)
+{
+	struct enq_blocked *skel;
+	struct thread_ctx thread_ctx = {};
+	struct contender_ctx *contender_ctxs = NULL;
+	struct bpf_link *link = NULL;
+	pthread_t owner, donor, *contenders = NULL;
+	struct timespec join_deadline;
+	cpu_set_t allowed_cpus;
+	bool module_loaded = false;
+	bool owner_started = false, donor_started = false;
+	bool join_timed_out = false;
+	bool proxy_enabled;
+	enum scx_test_status status = SCX_TEST_PASS;
+	int cpu, donor_pid, donor_state, err, thread_err;
+	size_t i, nr_contenders, nr_contenders_started = 0;
+	size_t nr_contenders_joined = 0;
+	u64 nr_blocked, nr_blocked_donor_cpu, nr_blocked_owner_cpu;
+	u64 nr_blocked_other_cpu, nr_blocked_wakeups;
+	struct enq_blocked_stats stats;
+
+	err = select_test_cpus(cross_cpu, &allowed_cpus, &thread_ctx.donor_cpu,
+			       &thread_ctx.owner_cpu);
+	if (err == -EAGAIN) {
+		fprintf(stderr, "SKIP: cross-CPU case requires two allowed CPUs\n");
+		return SCX_TEST_SKIP;
+	}
+	if (err) {
+		SCX_ERR("Failed to select test CPUs (%d)", -err);
+		return SCX_TEST_FAIL;
+	}
+	nr_contenders = CPU_COUNT(&allowed_cpus);
+	contenders = calloc(nr_contenders, sizeof(*contenders));
+	contender_ctxs = calloc(nr_contenders, sizeof(*contender_ctxs));
+	if (!contenders || !contender_ctxs) {
+		SCX_ERR("Failed to allocate %zu contender threads", nr_contenders);
+		status = SCX_TEST_FAIL;
+		goto out_contenders;
+	}
+
+	skel = enq_blocked__open();
+	if (!skel) {
+		SCX_ERR("Failed to open skel");
+		status = SCX_TEST_FAIL;
+		goto out_contenders;
+	}
+	SCX_ENUM_INIT(skel);
+	skel->struct_ops.enq_blocked_ops->flags =
+		SCX_OPS_ENQ_LAST |
+		(enq_blocked ? SCX_OPS_ENQ_BLOCKED : 0);
+	if (enq_blocked__load(skel)) {
+		SCX_ERR("Failed to load skel");
+		status = SCX_TEST_FAIL;
+		goto out_skel;
+	}
+
+	proxy_enabled = cmdline_bool("sched_proxy_exec", true);
+
+	err = load_test_module(&module_loaded);
+	if (err == -EPERM || err == -ENOENT) {
+		fprintf(stderr, "SKIP: cannot load mutex fixture (%d)\n", -err);
+		status = SCX_TEST_SKIP;
+		goto out_skel;
+	}
+	if (err) {
+		SCX_ERR("Failed to load mutex fixture (%d)", -err);
+		status = SCX_TEST_FAIL;
+		goto out_skel;
+	}
+
+	thread_ctx.fd = open(DEVICE_PATH, O_RDONLY | O_CLOEXEC);
+	if (thread_ctx.fd < 0) {
+		SCX_ERR("Failed to open %s (%d)", DEVICE_PATH, errno);
+		status = SCX_TEST_FAIL;
+		goto out_module;
+	}
+	if (ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_RESET_STATS)) {
+		SCX_ERR("Failed to reset mutex statistics (%d)", errno);
+		status = SCX_TEST_FAIL;
+		goto out_fd;
+	}
+
+	if (ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_PREP_ATTACH)) {
+		SCX_ERR("Failed to prepare scheduler attachment (%d)", errno);
+		status = SCX_TEST_FAIL;
+		goto out_fd;
+	}
+
+	err = pthread_create(&owner, NULL, owner_fn, &thread_ctx);
+	if (err) {
+		SCX_ERR("Failed to create owner thread (%d)", err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+	owner_started = true;
+
+	err = pthread_create(&donor, NULL, donor_fn, &thread_ctx);
+	if (err) {
+		SCX_ERR("Failed to create donor thread (%d)", err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+	donor_started = true;
+
+	if (!wait_for_pid(&thread_ctx.donor_pid)) {
+		SCX_ERR("Timed out waiting for donor thread");
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	donor_pid = atomic_load_explicit(&thread_ctx.donor_pid,
+					 memory_order_acquire);
+	skel->bss->donor_pid = donor_pid;
+	skel->data->donor_cpu = thread_ctx.donor_cpu;
+	skel->data->owner_cpu = thread_ctx.owner_cpu;
+	atomic_store_explicit(&thread_ctx.start_donor, true,
+			      memory_order_release);
+
+	donor_state = ENQ_BLOCKED_DONOR_SLEEPING;
+	if (proxy_enabled)
+		donor_state |= ENQ_BLOCKED_DONOR_ON_RQ;
+	err = wait_for_donor_state(&thread_ctx, donor_state);
+	if (err < 0) {
+		SCX_ERR("Donor did not block before scheduler attachment (%d)", -err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	link = bpf_map__attach_struct_ops(skel->maps.enq_blocked_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	donor_state = ENQ_BLOCKED_DONOR_SLEEPING;
+	if (proxy_enabled && enq_blocked)
+		donor_state |= ENQ_BLOCKED_DONOR_ON_RQ;
+	err = wait_for_donor_state(&thread_ctx, donor_state);
+	if (err < 0) {
+		SCX_ERR("Unexpected donor state after scheduler attachment (%d)",
+			-err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	if (ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_ATTACH_DONE)) {
+		SCX_ERR("Failed to complete scheduler attachment (%d)", errno);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	i = 0;
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, &allowed_cpus))
+			continue;
+
+		contender_ctxs[i].thread_ctx = &thread_ctx;
+		contender_ctxs[i].cpu = cpu;
+		atomic_init(&contender_ctxs[i].status, 0);
+		err = pthread_create(&contenders[i], NULL, contender_fn,
+				     &contender_ctxs[i]);
+		if (err) {
+			SCX_ERR("Failed to create contender for CPU %d (%d)",
+				cpu, err);
+			status = SCX_TEST_FAIL;
+			goto out;
+		}
+		nr_contenders_started++;
+		i++;
+	}
+
+	err = wait_for_contenders(contender_ctxs, nr_contenders);
+	if (err != 1) {
+		SCX_ERR("Contender threads failed (%d)", -err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	/*
+	 * The first trial spans scheduler attachment and validates the state
+	 * transition, but including it would skew scheduling latency. Exclude it
+	 * from both the mutex and BPF enqueue measurements.
+	 */
+	if (!wait_for_donor(&thread_ctx, NR_WARMUP_TRIALS)) {
+		SCX_ERR("Timed out waiting for warm-up trial");
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+	if (ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_RESET_STATS)) {
+		SCX_ERR("Failed to reset mutex statistics after warm-up (%d)",
+			errno);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+	skel->bss->nr_blocked_enqueues = 0;
+	skel->bss->nr_blocked_enqueues_donor_cpu = 0;
+	skel->bss->nr_blocked_enqueues_owner_cpu = 0;
+	skel->bss->nr_blocked_enqueues_other_cpu = 0;
+	skel->bss->nr_blocked_wakeups = 0;
+	atomic_store_explicit(&thread_ctx.measurement_ready, true,
+			      memory_order_release);
+
+out:
+	ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_ATTACH_DONE);
+	if (status != SCX_TEST_PASS) {
+		atomic_store_explicit(&thread_ctx.abort, true, memory_order_release);
+		atomic_store_explicit(&thread_ctx.start_donor, true,
+				      memory_order_release);
+		atomic_store_explicit(&thread_ctx.measurement_ready, true,
+				      memory_order_release);
+	}
+
+	set_join_deadline(&join_deadline);
+	if (donor_started) {
+		err = join_thread(donor, &join_deadline, &thread_err);
+		if (err == ETIMEDOUT) {
+			SCX_ERR("Timed out waiting for donor thread");
+			join_timed_out = true;
+			status = SCX_TEST_FAIL;
+		} else if (err) {
+			SCX_ERR("Failed to join donor thread (%d)", err);
+			status = SCX_TEST_FAIL;
+		} else {
+			donor_started = false;
+			if (thread_err) {
+				SCX_ERR("Donor thread failed (%d)", thread_err);
+				status = SCX_TEST_FAIL;
+			}
+		}
+	}
+	if (!join_timed_out && owner_started) {
+		err = join_thread(owner, &join_deadline, &thread_err);
+		if (err == ETIMEDOUT) {
+			SCX_ERR("Timed out waiting for owner thread");
+			join_timed_out = true;
+			status = SCX_TEST_FAIL;
+		} else if (err) {
+			SCX_ERR("Failed to join owner thread (%d)", err);
+			status = SCX_TEST_FAIL;
+		} else {
+			owner_started = false;
+			if (thread_err) {
+				SCX_ERR("Owner thread failed (%d)", thread_err);
+				status = SCX_TEST_FAIL;
+			}
+		}
+	}
+	atomic_store_explicit(&thread_ctx.stop_contender, true,
+			      memory_order_release);
+	for (i = 0; !join_timed_out && i < nr_contenders_started; i++) {
+		err = join_thread(contenders[i], &join_deadline, &thread_err);
+		if (err == ETIMEDOUT) {
+			SCX_ERR("Timed out waiting for contender on CPU %d",
+				contender_ctxs[i].cpu);
+			join_timed_out = true;
+			status = SCX_TEST_FAIL;
+		} else if (err) {
+			SCX_ERR("Failed to join contender on CPU %d (%d)",
+				contender_ctxs[i].cpu, err);
+			status = SCX_TEST_FAIL;
+		} else {
+			nr_contenders_joined++;
+			if (thread_err) {
+				SCX_ERR("Contender on CPU %d failed (%d)",
+					contender_ctxs[i].cpu, thread_err);
+				status = SCX_TEST_FAIL;
+			}
+		}
+	}
+
+	/* Restore the fair scheduler before waiting for any stranded thread. */
+	if (join_timed_out) {
+		atomic_store_explicit(&thread_ctx.abort, true,
+				      memory_order_release);
+		if (link) {
+			bpf_link__destroy(link);
+			link = NULL;
+		}
+		if (donor_started)
+			pthread_join(donor, NULL);
+		if (owner_started)
+			pthread_join(owner, NULL);
+		for (i = nr_contenders_joined;
+		     i < nr_contenders_started; i++)
+			pthread_join(contenders[i], NULL);
+	}
+
+	if (ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_GET_STATS, &stats)) {
+		SCX_ERR("Failed to read mutex statistics (%d)", errno);
+		status = SCX_TEST_FAIL;
+	} else {
+		result->stats = stats;
+		printf("\n[topology=%s SCX_OPS_ENQ_BLOCKED=%s]\n",
+		       cross_cpu ? "cross-cpu" : "same-cpu",
+		       enq_blocked ? "enabled" : "disabled");
+		printf("  proxy_exec=%s\n",
+		       proxy_enabled ? "enabled" : "disabled");
+		printf("  donor_cpu=%d\n", thread_ctx.donor_cpu);
+		printf("  owner_cpu=%d\n", thread_ctx.owner_cpu);
+		printf("  nr_contenders=%zu\n", nr_contenders);
+		printf("  measured_trials=%d\n", NR_MEASURED_TRIALS);
+		printf("  owner_nice=%d\n", OWNER_NICE);
+		printf("  donor_nice=%d\n", DONOR_NICE);
+		printf("  contender_nice=%d\n", CONTENDER_NICE);
+		print_avg_time("mutex_hold", stats.hold_time_ns, stats.nr_holds);
+		print_avg_time("mutex_wait", stats.wait_time_ns, stats.nr_waits);
+		if (stats.nr_holds != NR_MEASURED_TRIALS ||
+		    stats.nr_waits != NR_MEASURED_TRIALS) {
+			SCX_ERR("Expected %d measured trials, got %llu holds and %llu waits",
+				NR_MEASURED_TRIALS,
+				(unsigned long long)stats.nr_holds,
+				(unsigned long long)stats.nr_waits);
+			status = SCX_TEST_FAIL;
+		}
+	}
+
+	nr_blocked = skel->bss->nr_blocked_enqueues;
+	nr_blocked_donor_cpu = skel->bss->nr_blocked_enqueues_donor_cpu;
+	nr_blocked_owner_cpu = skel->bss->nr_blocked_enqueues_owner_cpu;
+	nr_blocked_other_cpu = skel->bss->nr_blocked_enqueues_other_cpu;
+	nr_blocked_wakeups = skel->bss->nr_blocked_wakeups;
+	result->nr_blocked_enqueues = nr_blocked;
+	result->nr_blocked_enqueues_donor_cpu = nr_blocked_donor_cpu;
+	result->nr_blocked_enqueues_owner_cpu = nr_blocked_owner_cpu;
+	result->nr_blocked_enqueues_other_cpu = nr_blocked_other_cpu;
+	result->nr_blocked_wakeups = nr_blocked_wakeups;
+	printf("  nr_blocked_enqueues=%llu\n",
+	       (unsigned long long)nr_blocked);
+	printf("  nr_blocked_enqueues_donor_cpu=%llu\n",
+	       (unsigned long long)nr_blocked_donor_cpu);
+	printf("  nr_blocked_enqueues_owner_cpu=%llu\n",
+	       (unsigned long long)nr_blocked_owner_cpu);
+	printf("  nr_blocked_enqueues_other_cpu=%llu\n",
+	       (unsigned long long)nr_blocked_other_cpu);
+	printf("  nr_blocked_wakeups=%llu\n",
+	       (unsigned long long)nr_blocked_wakeups);
+	if (status == SCX_TEST_PASS) {
+		if (enq_blocked && proxy_enabled && !nr_blocked) {
+			SCX_ERR("ops.enqueue() did not receive the blocked donor");
+			status = SCX_TEST_FAIL;
+		} else if ((!enq_blocked || !proxy_enabled) && nr_blocked) {
+			SCX_ERR("ops.enqueue() unexpectedly received %llu blocked donors",
+				(unsigned long long)nr_blocked);
+			status = SCX_TEST_FAIL;
+		} else if (nr_blocked_wakeups) {
+			SCX_ERR("Ordinary wakeups received %llu blocked enqueue flags",
+				(unsigned long long)nr_blocked_wakeups);
+			status = SCX_TEST_FAIL;
+		} else if (nr_blocked_other_cpu) {
+			SCX_ERR("Blocked donor had %llu enqueues on unexpected CPUs",
+				(unsigned long long)nr_blocked_other_cpu);
+			status = SCX_TEST_FAIL;
+		}
+	}
+
+	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+		SCX_ERR("Scheduler exited unexpectedly (kind=%llu code=%lld)",
+			(unsigned long long)skel->data->uei.kind,
+			(long long)skel->data->uei.exit_code);
+		status = SCX_TEST_FAIL;
+	}
+
+	if (link)
+		bpf_link__destroy(link);
+out_fd:
+	close(thread_ctx.fd);
+out_module:
+	unload_test_module(module_loaded);
+out_skel:
+	enq_blocked__destroy(skel);
+out_contenders:
+	free(contender_ctxs);
+	free(contenders);
+	return status;
+}
+
+static enum scx_test_status run_topology(bool cross_cpu)
+{
+	struct run_result disabled = {}, enabled = {};
+	enum scx_test_status status;
+
+	status = run_one(false, cross_cpu, &disabled);
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_one(true, cross_cpu, &enabled);
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	printf("\n[topology=%s delta: enabled - disabled]\n",
+	       cross_cpu ? "cross-cpu" : "same-cpu");
+	print_avg_delta("mutex_hold", disabled.stats.hold_time_ns,
+			disabled.stats.nr_holds, enabled.stats.hold_time_ns,
+			enabled.stats.nr_holds);
+	print_avg_delta("mutex_wait", disabled.stats.wait_time_ns,
+			disabled.stats.nr_waits, enabled.stats.wait_time_ns,
+			enabled.stats.nr_waits);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	enum scx_test_status status;
+
+	(void)ctx;
+
+	status = run_topology(false);
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_topology(true);
+	if (status == SCX_TEST_SKIP)
+		return SCX_TEST_PASS;
+
+	return status;
+}
+
+struct scx_test enq_blocked = {
+	.name = "enq_blocked",
+	.description = "Verify proxy donor admission under CPU-wide contention",
+	.setup = setup,
+	.run = run,
+};
+
+REGISTER_SCX_TEST(&enq_blocked)
diff --git a/tools/testing/selftests/sched_ext/enq_blocked.h b/tools/testing/selftests/sched_ext/enq_blocked.h
new file mode 100644
index 0000000000000..68094fb06c875
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_blocked.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES */
+#ifndef __ENQ_BLOCKED_H
+#define __ENQ_BLOCKED_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+struct enq_blocked_stats {
+	__u64 hold_time_ns;
+	__u64 wait_time_ns;
+	__u64 nr_holds;
+	__u64 nr_waits;
+};
+
+#define ENQ_BLOCKED_IOCTL_OWNER	_IO('s', 1)
+#define ENQ_BLOCKED_IOCTL_DONOR	_IO('s', 2)
+#define ENQ_BLOCKED_IOCTL_RESET_STATS	_IO('s', 3)
+#define ENQ_BLOCKED_IOCTL_GET_STATS	_IOR('s', 4, struct enq_blocked_stats)
+#define ENQ_BLOCKED_IOCTL_PREP_ATTACH	_IO('s', 5)
+#define ENQ_BLOCKED_IOCTL_ATTACH_DONE	_IO('s', 6)
+#define ENQ_BLOCKED_IOCTL_DONOR_STATE	_IO('s', 7)
+
+#define ENQ_BLOCKED_DONOR_SLEEPING	(1U << 0)
+#define ENQ_BLOCKED_DONOR_ON_RQ		(1U << 1)
+
+#endif /* __ENQ_BLOCKED_H */
diff --git a/tools/testing/selftests/sched_ext/test_modules/Makefile b/tools/testing/selftests/sched_ext/test_modules/Makefile
new file mode 100644
index 0000000000000..a0e9e9401ead6
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/test_modules/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+
+TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(if $(O),$(O),$(realpath ../../../../..))
+
+obj-m += scx_enq_blocked_test.o
+
+all:
+	+$(Q)$(MAKE) -C $(KDIR) M=$(TESTMODS_DIR) modules
+
+clean:
+	+$(Q)$(MAKE) -C $(KDIR) M=$(TESTMODS_DIR) clean
diff --git a/tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c b/tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
new file mode 100644
index 0000000000000..e352301d9e274
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ *
+ * Kernel mutex fixture for the sched_ext SCX_OPS_ENQ_BLOCKED selftest.
+ */
+
+#include <linux/atomic.h>
+#include <linux/fs.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+
+#include "../enq_blocked.h"
+
+#define DONOR_WAIT_TIMEOUT	msecs_to_jiffies(2000)
+#define ATTACH_WAIT_TIMEOUT	msecs_to_jiffies(10000)
+#define MUTEX_HOLD_TIME		msecs_to_jiffies(200)
+
+static DEFINE_MUTEX(test_mutex);
+static DEFINE_SPINLOCK(donor_lock);
+static struct task_struct *donor_task;
+static atomic_t owner_ready = ATOMIC_INIT(0);
+static atomic_t donor_started = ATOMIC_INIT(0);
+static atomic_t attach_pending = ATOMIC_INIT(0);
+static atomic_t attach_done = ATOMIC_INIT(0);
+static atomic64_t hold_time_ns = ATOMIC64_INIT(0);
+static atomic64_t wait_time_ns = ATOMIC64_INIT(0);
+static atomic64_t nr_holds = ATOMIC64_INIT(0);
+static atomic64_t nr_waits = ATOMIC64_INIT(0);
+
+static long run_owner(void)
+{
+	unsigned long timeout;
+	u64 start_ns;
+	long ret = 0;
+
+	atomic_set(&donor_started, 0);
+	mutex_lock(&test_mutex);
+	start_ns = ktime_get_ns();
+	atomic_set(&owner_ready, 1);
+
+	timeout = jiffies + DONOR_WAIT_TIMEOUT;
+	while (!atomic_read(&donor_started)) {
+		if (time_after(jiffies, timeout)) {
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+		cond_resched();
+	}
+	if (atomic_xchg(&attach_pending, 0)) {
+		timeout = jiffies + ATTACH_WAIT_TIMEOUT;
+		while (!atomic_read(&attach_done)) {
+			if (time_after(jiffies, timeout)) {
+				ret = -ETIMEDOUT;
+				goto out;
+			}
+			cond_resched();
+		}
+	}
+
+	/* Keep yielding while the donor blocks on test_mutex. */
+	timeout = jiffies + MUTEX_HOLD_TIME;
+	while (time_before(jiffies, timeout))
+		cond_resched();
+
+out:
+	atomic_set(&owner_ready, 0);
+	atomic64_add(ktime_get_ns() - start_ns, &hold_time_ns);
+	atomic64_inc(&nr_holds);
+	mutex_unlock(&test_mutex);
+	return ret;
+}
+
+static long run_donor(void)
+{
+	unsigned long flags;
+	u64 start_ns;
+
+	if (!atomic_read(&owner_ready))
+		return -EAGAIN;
+
+	get_task_struct(current);
+	spin_lock_irqsave(&donor_lock, flags);
+	WARN_ON_ONCE(donor_task);
+	donor_task = current;
+	spin_unlock_irqrestore(&donor_lock, flags);
+
+	atomic_set(&donor_started, 1);
+	start_ns = ktime_get_ns();
+	mutex_lock(&test_mutex);
+
+	spin_lock_irqsave(&donor_lock, flags);
+	donor_task = NULL;
+	spin_unlock_irqrestore(&donor_lock, flags);
+	put_task_struct(current);
+
+	atomic64_add(ktime_get_ns() - start_ns, &wait_time_ns);
+	atomic64_inc(&nr_waits);
+	mutex_unlock(&test_mutex);
+	return 0;
+}
+
+static long get_donor_state(void)
+{
+	struct task_struct *task;
+	unsigned long flags;
+	long state = 0;
+
+	spin_lock_irqsave(&donor_lock, flags);
+	task = donor_task;
+	if (task)
+		get_task_struct(task);
+	spin_unlock_irqrestore(&donor_lock, flags);
+	if (!task)
+		return -ENOENT;
+
+	if (READ_ONCE(task->__state) != TASK_RUNNING)
+		state |= ENQ_BLOCKED_DONOR_SLEEPING;
+	if (READ_ONCE(task->on_rq))
+		state |= ENQ_BLOCKED_DONOR_ON_RQ;
+	put_task_struct(task);
+	return state;
+}
+
+static void reset_stats(void)
+{
+	atomic64_set(&hold_time_ns, 0);
+	atomic64_set(&wait_time_ns, 0);
+	atomic64_set(&nr_holds, 0);
+	atomic64_set(&nr_waits, 0);
+}
+
+static long get_stats(unsigned long arg)
+{
+	struct enq_blocked_stats stats = {
+		.hold_time_ns = atomic64_read(&hold_time_ns),
+		.wait_time_ns = atomic64_read(&wait_time_ns),
+		.nr_holds = atomic64_read(&nr_holds),
+		.nr_waits = atomic64_read(&nr_waits),
+	};
+
+	return copy_to_user((void __user *)arg, &stats, sizeof(stats)) ?
+		-EFAULT : 0;
+}
+
+static long enq_blocked_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	switch (cmd) {
+	case ENQ_BLOCKED_IOCTL_OWNER:
+		return run_owner();
+	case ENQ_BLOCKED_IOCTL_DONOR:
+		return run_donor();
+	case ENQ_BLOCKED_IOCTL_RESET_STATS:
+		reset_stats();
+		return 0;
+	case ENQ_BLOCKED_IOCTL_GET_STATS:
+		return get_stats(arg);
+	case ENQ_BLOCKED_IOCTL_PREP_ATTACH:
+		atomic_set(&attach_done, 0);
+		atomic_set(&attach_pending, 1);
+		return 0;
+	case ENQ_BLOCKED_IOCTL_ATTACH_DONE:
+		atomic_set(&attach_done, 1);
+		return 0;
+	case ENQ_BLOCKED_IOCTL_DONOR_STATE:
+		return get_donor_state();
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations enq_blocked_fops = {
+	.owner			= THIS_MODULE,
+	.unlocked_ioctl		= enq_blocked_ioctl,
+};
+
+static struct miscdevice enq_blocked_device = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "scx_enq_blocked",
+	.fops	= &enq_blocked_fops,
+	.mode	= 0600,
+};
+
+module_misc_device(enq_blocked_device);
+MODULE_AUTHOR("Andrea Righi <arighi@nvidia.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("sched_ext blocked donor test module");
-- 
2.55.0

