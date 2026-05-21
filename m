Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2C3E5587
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385554; cv=fail; b=ZLxSfT78yhRC9INTnBaF9YVCnYkTlGdbBLa9dwmnajYq+oZA52lGndBfO5sJfe4rMCqms1dFft0a+C9uHVNR6FiYBilzB2Xi4w/BIIKK0BUgW+glorYmpl4buxUCXvnfs1VH8anq+OS9todIP8x/VYyAZvdf8x9b9owaz6ALSpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385554; c=relaxed/simple;
	bh=3vCcO1a6jt3sWLqk8jNmtN7zfifk91mxpiZ7sLNI8QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjYUK5NGnI2C1GZplYXppVD4lgL+vO4aCzvAk41n6tal0TcLSQA6G6SUMEVjSNXS/yeOAP6zfa4MPxFMn3pOIftKAal+tFO8sV/T59+colQUWHTpWqeCqB3NFJ+ukItPlATpgmdE+kds6zMdHpIVWRbFfYDKI4aN7/KkqaC2/AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=byXcAzSd; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byXcAzSd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmgd+/2Dxq14Y0EPaC2Eqx4i6LC0heWNb7MLOqfSA2vNwf/ZfNHUgClRH71RWGuarlROtt/HnMDqmDCQ0/0YxE50qfcBfHB45httlvcwzIqDRbktWs2te1j6DvOMxzCqIjyA9NYsJBFsWkCC+2yJHj7im+Bwx2gg12iQduJ1Tc+KBAr2+k9aVkK7n49//qBIdnAinzrp+ECel0/ZvNrtioP9gTuMdGXgvly2zgvwg3ip5afi0zTD05fK11vOCLZ0vqMEDmp4fy3purTY4E/WEZXl0PRCpaKdDUQs2sEg/NllyxMcL/V3KTC5K6UO1CQ6Icb8D9T+1qVWtSxYWFiPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeWPDOmBMFTx/wyXi3XAKLs/RD5pHxVvIGNhTy0EX68=;
 b=AXtMVuy4VbpD7/GX3+56KycCy7z257GezvDIcITd0+Du0ik8vFgzRbG+glaUL/kRWVjCNAPDISK4rakshKhbDAN2HLxTF+ver5xo9xAx0WRv+Iw2v17xwZjEmZz1SACKIDdzioRPiBWQhzxDvrE16eJ3tUpu+4kCXO3zRShJ01AAuQ9yuqYdOqVtMRLbxYjJd5INIlJhpzLw7JWH0RpvW5cZ1+HESxb4Z+HZ297F1aC9ffpTSxS2syUYgdghyPrzV0YEDkzprxvo2+UJ7NqqT01s2Bdc3cqbR2OHLKzfrVo6Oz+JmoXvHCF3U2xo6My7j1TSHAFRll4WZUUQANTRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeWPDOmBMFTx/wyXi3XAKLs/RD5pHxVvIGNhTy0EX68=;
 b=byXcAzSdyd3cYzySXN+rBNZQufgwRD/hkP5US9zgAs3fHdl0ghUfuC/p8e4pl/0CxyYV4sr8TLm6P4aqTFfw2NUt/AFv1yU2rS0f7xxI2kU1+EGCvxJ85aSjfqRTQiouNtEZYh/7gbOxZ7R87LYzWVgHQ+j+IlswnsQnqj7+52/zw3d3Or4PtZvbhWus9rGqUqmCdzFH8AWAnjkZ52Ecc74yFW2P5wgA78oXIvi7vmxYs8ctfSQmLm1/zmjjoP1Aff/LwjBTSFmllBpIPgCbPMsClSKfyHMlJxi8l5vitpb1w75ZqWjIBP8z2IGXjgJ3f+5NUPwbXXEesbTEfwAi6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 21 May
 2026 17:45:41 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:45:41 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>,
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Validate dl_server attach/detach in total_bw test
Date: Thu, 21 May 2026 19:33:57 +0200
Message-ID: <20260521174509.1534623-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521174509.1534623-1-arighi@nvidia.com>
References: <20260521174509.1534623-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:805:f2::27) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: dd24fa38-8587-477b-f37e-08deb760c6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|11063799006|18002099003|22082099003|56012099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	wWlpBqCGd0kW6jlGERi3Nbe+6A/TnUuKIGykCptb4eWyqzbMvC4Gn67ogaPxixZC6qvAtPbSMRXkvdSeYqI9Fz9o11/2imvzKqdyqvESZOLJR6xVBE4Ue1Z0r2SvZRdFGCIaYZTzTnSdx0gf6zqWiGJmofi8BKpbjacMMcdv7KtNOMdyoMw7rl0hwf9ZJbRWwRRntZK6fVA5y3UnVP5i5qTmQLv+dSD2nImzykvFE8WalCEbmRO/HyFdFW2NWSsBUO/haCCz417LBeGMlVdq5AWy6LKtZ0azCa1SJDmja47pdTPjL3Dm9t8XhwLJc5zyGAhlYBktXOtreUn3QdoRyyhv/J9g5SXfuVp2v1W6Mmcupt9thbG3t7vrkZRebr3Gs13bAZHa7mkxA9YCZ6xNvFEx1WFzpoGF/6MdMo8PkdzvQt64+9mBIcKVZtnyVw15xbqs9JMgdK50Uqp/x7787BkLEn3LiI1AepMfjg4CBPuiDaCXWandEMcROt5jeiAPc8Ou/ji4Qqgzg1F39LU3ldUivWfcQawBLK+Y+tTAF/g5hB8hXaYnMk+OlxypsvEaEUPrYjy/IpaUMypX4NlnZ4LsRkddKEW/dnsvBmdkuhqPfE4Pnty8AdkSPlo8sFCSNwscdOZ+QyrDNlUTeq0xbwUT1/W79GkKTKhNMOMa4vjvSkVMdyI0T3HL2s2p/qVr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z/P9fBX+F3m/D4NOiub3C5v+LSo4ph0yjjTg6ZQ2ZXp8Mx/ueAGifqabuaHK?=
 =?us-ascii?Q?oaHvtjoRMq94YM9+m75Y7oiQEC9gRsu5YWQxh76j23YWu0j608BdQm58Ym0o?=
 =?us-ascii?Q?h6uQgyZ2nmBsB5wCVSl/hErr0R7Ox7VEgYtDJ2Zqv2b9hOMBvzrpKOP9qbTI?=
 =?us-ascii?Q?DemHPrXohkWO/Y8ISt3KaNmCEahSVYiLPdxucxCBI9G2sJEYGLsfhfecrefv?=
 =?us-ascii?Q?5A9SQoOff0AWSaxmryReHdPtuFSSOfmT49FJaTciuHjZTAXALqS8jkeP4KN3?=
 =?us-ascii?Q?eo8NOOmrkOxN7KzvdPW9tRBf4xWZ2AsOe92/DapZehZCMIeWP5H/ojRVAqUn?=
 =?us-ascii?Q?6o0epwECdRFOTrRFXuu74ss68LZKVjIzF4xCSmEL0YHGGb+EWZHfubfCNPdZ?=
 =?us-ascii?Q?5gJpLbSJL5tUwLAmSW3a/rfju34AimXryck587K+JtxHrvOoOLdyBvzio2P4?=
 =?us-ascii?Q?5KC5tIT/2EjrgGIP5BLxUunmZu5qOLkWrNjKGVrKSrqIbHp8xpKtVwIubCs8?=
 =?us-ascii?Q?YoI7wcOgqO4lyyeMsOZx3wFtC5uwKByCelzBT8zzt/7SQ43CXQWZ3rwYM3SU?=
 =?us-ascii?Q?RT/vbpwfO+uXojx0JTt+3o1/bKDaRs0lJGYm1eVifKM17KTDytmeit9KyHD4?=
 =?us-ascii?Q?WWJsn1Rnq/F6sXeW/0dvfUHboKdcKDtdUYx3BPjdbhuX5e35qE+m1WslOKAv?=
 =?us-ascii?Q?O3u2sdDXwi6JfCWNBm5LxUYUoPUeC6cqZbMckeiV3wzPNKBFjmZGtkVUzzCF?=
 =?us-ascii?Q?S/cRYkxrPmyNPDKSYS+heqY0QQG8L/VhyoccMImtrZcHxvKGke2XKP3CkeKG?=
 =?us-ascii?Q?rbeokIfEpPTXZNrBhk/FJ6FTI8xLSdgMMmIU0mCP9ddu7ujU7H/AWczjuPEv?=
 =?us-ascii?Q?6FYA+Pckjrdsq+smPxv7OqfLJuQS5lAhU/YlNAhDRHHFVdApNWMuxo4K+bAS?=
 =?us-ascii?Q?h1HkO8okL+GYDL+qEUQvaz87YZJJAYqmOI7LwRxMhr/Z1Kp+/Jj3RGhu4WkA?=
 =?us-ascii?Q?6W+xwJ+snBB3iTx9qmdj4naDKrK3c0xh3EcNi/+JP1TsQDd+J6OZyfbvbmXR?=
 =?us-ascii?Q?2HUvBMGv/psb45X329T/Acqe2PDIHRc4MILWLvPGwj68PDE7xAWoQSr8VTzK?=
 =?us-ascii?Q?TRpLflVMzdu5tiCpafj8U1CaDhooYhthItYIIAIAvIWeaRE2FdoLICbyXsU0?=
 =?us-ascii?Q?FSsSSGIFOSvZwxZLL7WhAm9w9McUaPlAK7DsfFYSXzCcghxxdNkhJxN5XPwQ?=
 =?us-ascii?Q?kDa8J7opGLSFEWPv18cAquLFrx1Vewxu7oz3IoSJ1j+/kWwRTIKriOuZWlcQ?=
 =?us-ascii?Q?aU3NTeNXK6YwVz3KPj52LxTHNb7y17VAKyUz0RdILlVZLso8n5jOAEqziyyp?=
 =?us-ascii?Q?kZ12f988UELkvaQLnXwfhJVdKJxOBqq+2SHuNsSN1i6mvVZxUQ5w2NThHDB4?=
 =?us-ascii?Q?6TGMFHf8/IBeC4lEhQsL6HmArAc/SEqNjXxwBN2BVnN8U0QMQ3WJsFna9RuR?=
 =?us-ascii?Q?/oZRFDiArG6GAhjllFi9lI9ysbtHExKQSzU8aixy4nDWuP+HDRBCZK3mR78s?=
 =?us-ascii?Q?RiAex85f9ZiFP/bo+NKlAua+6K+caJuy6RI0j5keEDHjBtZP4l3rN5MhI1WJ?=
 =?us-ascii?Q?/09zuYoTUk849a8XiJ+187KI8UwlpX90BdWa6SADry2gN3Z5wnBiNV/yfC8Z?=
 =?us-ascii?Q?jlYlrMh6JKr6HV7jkVvzpFpb/EbCUPA6A1okBytJsabv1xX1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd24fa38-8587-477b-f37e-08deb760c6b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:45:41.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dsx1E7kU7+oj188GSwq5g5b9XMlzSYbjBoOdbUmdMCa4dS0azevJGdbNth8zMOfGy4jVTjaghZ9uxZ5StBRgOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1

Extend the total_bw selftest to validate the fair/ext dl_server
auto-attach/detach operations.

After the existing consistency checks, the test now doubles the
fair_server's runtime on every CPU via debugfs and verifies that:
 1. total_bw grew after the customization (proves fair_server was
    attached and apply_params() honored the dl_bw_attached flag),
 2. with the minimal BPF scheduler loaded, total_bw drops back to the
    baseline value (proves fair_server was detached and ext_server was
    attached at its own default runtime),
 3. after unload total_bw matches the doubled value from step 1 (proves
    fair_server was re-attached with the runtime customization preserved
    across the load/unload cycle).

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/total_bw.c | 171 ++++++++++++++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
index 5b0a619bab86e..8eea12e8868ac 100644
--- a/tools/testing/selftests/sched_ext/total_bw.c
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -100,6 +100,66 @@ static int read_total_bw_values(long *bw_values, int max_cpus)
 	return cpu_count;
 }
 
+/*
+ * Read a per-CPU dl_server param (runtime or period) from debugfs.
+ * Returns the value in nanoseconds, or -1 on failure.
+ */
+static long read_server_param(const char *server, const char *param, int cpu)
+{
+	char path[128];
+	long value = -1;
+	FILE *fp;
+
+	snprintf(path, sizeof(path),
+		 "/sys/kernel/debug/sched/%s_server/cpu%d/%s",
+		 server, cpu, param);
+	fp = fopen(path, "r");
+	if (!fp)
+		return -1;
+	if (fscanf(fp, "%ld", &value) != 1)
+		value = -1;
+	fclose(fp);
+
+	return value;
+}
+
+/*
+ * Write a per-CPU dl_server param to debugfs. Returns 0 on success.
+ */
+static int write_server_param(const char *server, const char *param,
+			      int cpu, long value)
+{
+	char path[128];
+	FILE *fp;
+	int ret = 0;
+
+	snprintf(path, sizeof(path),
+		 "/sys/kernel/debug/sched/%s_server/cpu%d/%s",
+		 server, cpu, param);
+	fp = fopen(path, "w");
+	if (!fp)
+		return -1;
+	if (fprintf(fp, "%ld", value) < 0)
+		ret = -1;
+	fclose(fp);
+
+	return ret;
+}
+
+static int write_fair_runtime_all(int nr_cpus, long value)
+{
+	int i;
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (write_server_param("fair", "runtime", i, value) < 0) {
+			SCX_ERR("Failed to write fair_server runtime on CPU %d", i);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static bool verify_total_bw_consistency(long *bw_values, int count)
 {
 	int i;
@@ -217,6 +277,9 @@ static enum scx_test_status run(void *ctx)
 	struct bpf_link *link;
 	long loaded_bw[MAX_CPUS];
 	long unloaded_bw[MAX_CPUS];
+	long doubled_bw[MAX_CPUS];
+	long original_runtime, doubled_runtime;
+	enum scx_test_status ret;
 	int i;
 
 	/* Test scenario 2: BPF program loaded */
@@ -257,7 +320,113 @@ static enum scx_test_status run(void *ctx)
 	}
 
 	fprintf(stderr, "All total_bw values are consistent across all scenarios\n");
-	return SCX_TEST_PASS;
+
+	/*
+	 * Validate auto-register/unregister of dl_server bandwidth reservations.
+	 *
+	 * Doubling fair_server's runtime doubles its bw contribution. With a
+	 * full-mode BPF scheduler (minimal_ops), the kernel should detach
+	 * fair_server and attach ext_server, dropping total_bw back to its
+	 * pre-customization (default ext_server-only) value. On unload, the
+	 * fair_server reservation should come back with its customized runtime
+	 * preserved, so total_bw doubles again.
+	 */
+	original_runtime = read_server_param("fair", "runtime", 0);
+	if (original_runtime <= 0) {
+		fprintf(stderr, "Skipping attach/detach validation: debugfs not accessible\n");
+		return SCX_TEST_PASS;
+	}
+	doubled_runtime = original_runtime * 2;
+
+	fprintf(stderr,
+		"Setting fair_server runtime to %ld ns on all CPUs (orig %ld)\n",
+		doubled_runtime, original_runtime);
+
+	if (write_fair_runtime_all(test_ctx->nr_cpus, doubled_runtime) < 0) {
+		ret = SCX_TEST_FAIL;
+		goto restore;
+	}
+
+	if (fetch_verify_total_bw(doubled_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values after doubling fair runtime");
+		ret = SCX_TEST_FAIL;
+		goto restore;
+	}
+
+	/*
+	 * After doubling the runtime, fair_server's bw contribution must grow.
+	 * We don't assert exactly 2x, because the kernel's to_ratio() truncates
+	 * the value, so 2 * to_ratio(period, runtime) and
+	 * to_ratio(period, 2 * runtime) can differ.
+	 */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (doubled_bw[i] <= test_ctx->baseline_bw[i]) {
+			SCX_ERR("CPU%d: doubling fair runtime did not increase total_bw (baseline=%ld, doubled=%ld)",
+				i, test_ctx->baseline_bw[i], doubled_bw[i]);
+			ret = SCX_TEST_FAIL;
+			goto restore;
+		}
+	}
+
+	link = bpf_map__attach_struct_ops(test_ctx->skel->maps.minimal_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler for detach test");
+		ret = SCX_TEST_FAIL;
+		goto restore;
+	}
+
+	if (fetch_verify_total_bw(loaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values with BPF loaded (detach test)");
+		bpf_link__destroy(link);
+		ret = SCX_TEST_FAIL;
+		goto restore;
+	}
+
+	/*
+	 * In full mode the customized fair_server is detached and ext_server
+	 * is attached at its default runtime - total_bw must match baseline.
+	 */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (loaded_bw[i] != test_ctx->baseline_bw[i]) {
+			SCX_ERR("CPU%d: BPF loaded with 2x fair: expected %ld (fair detached, ext default), got %ld",
+				i, test_ctx->baseline_bw[i], loaded_bw[i]);
+			bpf_link__destroy(link);
+			ret = SCX_TEST_FAIL;
+			goto restore;
+		}
+	}
+
+	bpf_link__destroy(link);
+
+	if (fetch_verify_total_bw(unloaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values after BPF unload (detach test)");
+		ret = SCX_TEST_FAIL;
+		goto restore;
+	}
+
+	/*
+	 * After unload, fair_server is re-attached with its preserved 2x
+	 * runtime, so total_bw should return to the doubled value.
+	 */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (unloaded_bw[i] != doubled_bw[i]) {
+			SCX_ERR("CPU%d: BPF unloaded: expected %ld (fair restored at 2x), got %ld",
+				i, doubled_bw[i], unloaded_bw[i]);
+			ret = SCX_TEST_FAIL;
+			goto restore;
+		}
+	}
+
+	fprintf(stderr,
+		"dl_server attach/detach with customized fair runtime verified\n");
+	ret = SCX_TEST_PASS;
+
+restore:
+	if (write_fair_runtime_all(test_ctx->nr_cpus, original_runtime) < 0)
+		SCX_ERR("Failed to restore fair_server runtime to %ld",
+			original_runtime);
+
+	return ret;
 }
 
 static void cleanup(void *ctx)
-- 
2.54.0

