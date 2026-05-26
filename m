Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38C34EF04
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784227; cv=fail; b=hUI1k6UEUAgGYzquL3QCqqcUU/89pJWh6FpFnPpwrOFttxkarP+ULKUHks4CSs/ze5FIjZ+FXRPnmi+OzuIXmO+mAXIK6CWLqA/0UPl+72w8XllBW0YUnMtkAI3gUL+yOIghzqaLRAJvyvK6u4iu2/Lu0A0qRZivAVZ33iM0hlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784227; c=relaxed/simple;
	bh=M0XOWJO3n6fZIPlEmHtBTdztia/H2eG4KiLJbDnQnt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cm6np09ei/aRUei8qhOjxz3BMeLDnRZXCHc7aSox/HD1mimCeHhLpnP70X/l2q2NmPtTMJNmz/gFoge97yRp6Os7sSzJSiSGdv4iKmqCh1xXytLS324rJHWsG1Z1jDQrLzB5w4xyRl/wE3sqfv9SiENOTZe8NFdMWhi6F+E6Wyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ToaXmVfy; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ToaXmVfy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzzFQSNdVm53/J6Wx750rQY1xQlKyoTPFI1X4861lAyUyICp8r73hP4czgoqbzyIq0jo/CFm3sPCrq4j5OrEtI4YSfUcWfFxGMTTu3CyQ4Ev0N5vmMZVpvLMPU/SnCpB9+mo91SH03bjvOQFXXfetF11mwKKpKcc+xvE6A7Qqx2r8F4IO0PjgLo6e5YaS1DlG/+wFnrKpelYul/20hh7blwmxXkBCvN00v9U7hfUBOtKOUOgsEe304wrhfwH7W7+sDa9Ga5oZ5XSQ+czHdDD2Syw2i3SkhDIOxFsP2wLM9yDVPRZeGm8BOv62jcNC+qTWbZV6LpfnQ0BrVZ7eIZmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP1y5MDSxD9u0mZDFbV3SH1BF8HdzYHs45cqhlOeess=;
 b=PppDn8dKUjeO45XO1cG8OSBnuv83pl9RS0/L1QbS4lGsWwAa9VcQ8Ma6pfXzDC3abgi4dCJYAhLoYgcDdpj2p1CqEhtDy12vyRd5qhKLSBIy+mevtbfvZv7jAtzhewaFGfDx65OoUhzz92t1BZqZiHclwl0aAhBTBHMiwQ2PR5pAomZHqN6vdfxZe2lQ24nS9qyS8gYBQUrQFvTsP2gNpPgulUtA+htlWrfQFSUBaX/eNyyl7Q470iWibNp3N5nqD0r8e/Jcn5YcqbWHS7/NvEH7QNMfnw/DGIYVJOOwqrzGlojQkvRqRBPoE8k12g0IzvIlmFYJHTC07JYJtZ3qjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP1y5MDSxD9u0mZDFbV3SH1BF8HdzYHs45cqhlOeess=;
 b=ToaXmVfy10vog7z9wZX02kReSkrZ3T3c9uUah+KORSnjxgncVPm41VM4mbgAbsPXvtDdeAttN2wZBPXVj2MGIGDEgbIPIcrlDHNFEuVtcKVnEDksxu0LMeJBc7awhLC0UK/0Xfp5hbEwoJdBdSKfXSjW92DdaYkIakug4HWdxtQqnBiPfnbRJe3+TT54aqqoIB6RrZM6VifG6SDYfnK1XxepzyQmKawA2igyBWsda8AOb3sn3mhcR4LGqPvC/9ke/Wo6Lx/V0+562qJJA153Fyk8rm05HvcbQCSxuetw3uUrMWeqA+EKtN4kxfqe5q6H4s2oDNWRwyOb9d5Pz8qT5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:30:21 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 08:30:21 +0000
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
Date: Tue, 26 May 2026 10:27:56 +0200
Message-ID: <20260526082954.550958-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526082954.550958-1-arighi@nvidia.com>
References: <20260526082954.550958-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077BB.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::475) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4580656b-0e1c-46dd-2d63-08debb01068b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|11063799006|6133799003|5023799004|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PoSgwlYj+zJQ9arGSLfjeAmN34HIfyDnf8FrVWvU1Ez8t9QIvRTpnzlXbF3pMis1TmRwpuqLLAXMfgkS53GGuKRfUv8CfroCTQPVf98lZ4fHgIkHZCbIPr00Wzgi1upmUiEphUTLpb4026XnFWEjT5HTeN8lD+nrlLsfmfEcsjIOod7qdHieNThVFaa7XJatX30MecM/qEFpHkL8XGEAhg+QN6rIA3iAp4c0O4jSSEHLFg/4EqWVJWMLygmhlSn7CfV1u36E2dmpwTR7GK1BUzAlG0lckklVp2VOyeVh8LXOfFJxrMgrEyVdcAboJB1Ng/zQ6bFvTCuXqOmFYAjlwB955+WC1IXQzUTBrx6eJC4jN/LlnmhUQnP6tN5B+94s0X5LeIjUeKoY7a8SPPjKewjaWs/lMU4+KyedOIo7qL2qA30BbLG8I3B+icDhoyaTK+PgDcqACrYTboi4E5xzX5q61Izv/bjMuJjZhWiuJAZgj94iO2BOZMRUvPsA4g4MXagFP0pTp6CrzD8MiA/WwtULpbgOYM3kuGisjyGdh5Hg9eHIyn+MtowtFcEU3ohsqVLfgVzktbNEUZDTwvJ/Bl8z6qx+ymv5fFLDc2+Zx9043HPaEewBg9qwAvfxkFr19uuSrqjf5jHdGbEjQPPLA/9xpoMJO1UJbmyyAxJPC3a3FeHU+pb5oElFHFb9gtVe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(11063799006)(6133799003)(5023799004)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zsq340qdsSfUP99IiLpOcxFP3aFaaAs7MlQkYO5jpLTyk6BZRIr58l7/mdsg?=
 =?us-ascii?Q?De/pxBYmhhlhtc5hgSiX/3F5oopjXamfgpln/VylVOMdPeH3B6hHmuemQqMZ?=
 =?us-ascii?Q?XEdun3rPCuWl3bGyncdvON7MruIT0D580fKUqIZgy/SRCksVyux8KRCSK/vN?=
 =?us-ascii?Q?65wxd9Xj1HXpNqyEW8ay4/riqQE97ggrCqyD4md578mmbOL7Sz82XQpU2pVG?=
 =?us-ascii?Q?ifJA2XNuam+PzQJjCOcURTYiNzaD+DPYXylZ+LCzA/jFXzU6PI5r+oGfJBdM?=
 =?us-ascii?Q?u4M+kDJyuaPzVQutn82bJCqvKtqhluDcVskGNQXWGsGzoDThbcncEX8Khto0?=
 =?us-ascii?Q?5UcyfAdd81kO4bIeKDUWo3NBKQlR+vAn7U+oa5X9LITupHYFEE9bbMgv6SZG?=
 =?us-ascii?Q?TxYHENfZMyoH9cnJOBDWjVofv7EoOMrBsWZABqSBAOexDK3eqdsSlzU4zu0l?=
 =?us-ascii?Q?sfQc56glp93chTxkEbt6d4wuU+s9ySdfj3OgKYlzz+JKMkEkeRGqoOqreHjN?=
 =?us-ascii?Q?IWwnYUKenLCKIzrqShG7keMoF6LABcsI7CwkLN2aXHgEOhj65NYEo1biOI+T?=
 =?us-ascii?Q?4Zdg4/KBapSIIaCh+F/Ansi02jVEx0T2OtkpJD6p+E+iXPvSOopReZo4Xs9U?=
 =?us-ascii?Q?GJqPZgxQTUNmsVxcGj2vdOBWDak2EkkcBs445FcgXhxd7yn2D2e97s+WvNdp?=
 =?us-ascii?Q?pGKcXnt9EYs0m4raOjBkRLq5z3Aj3ekRFoi3bY7mNmWx64MBLHrgoSur8xh9?=
 =?us-ascii?Q?BOauLE8LYTTC5nl324w/PmbKh9ti9Jf8sApPxYWVos3DhCieAE7wPXoyTRPd?=
 =?us-ascii?Q?DLupICDQkWPiSy1aqvX+Qu9fts4XfTBZraowqR+0yqo1KHitwxdCndMG6xJh?=
 =?us-ascii?Q?xJICwuAWQhC6X2Nt6FP81/SobKTPlZbCxsX5F1T8V1ub+GI9j6BsX0RzXTMH?=
 =?us-ascii?Q?WB3oC5Eb2r8xywODwuneA1fe8nQlRCAJk3OhBa0Sedtark2xzvnGW3BMpL4N?=
 =?us-ascii?Q?j32FvP0tnPqHH0AXzsxNBf1pS7rjQAQUU2ZyIczZG5l1Mh9Eb5kqhWggWmJ/?=
 =?us-ascii?Q?V07G9/modw0PHADIoWuqUmreKbLDglNz6j6JJTPuBW0gTrSyg9BGWpEjEQOF?=
 =?us-ascii?Q?LDeB3t1hiKOXAntUelhThs41ZDOXxltsxq9ClOlu+z1V4/ldF0Yyda+dBJaP?=
 =?us-ascii?Q?L9aaYYlpgNTyRs2924DSIsjWtPuySVN9geIVajhdlNY3eF+P/P5vySTr5bYF?=
 =?us-ascii?Q?rtCd5dTpnoG1sM8Jjrjc1Ikag2SMdpMLvc7dgYyj0Fb3vBdywuo9Mf1qrqfb?=
 =?us-ascii?Q?As4Az9Z5BJUezThOap8l4a4CdNMjvg12FFzFu5X0exLyDub06uDMTEP3jp0Q?=
 =?us-ascii?Q?aV3H/6RKB9wJRztyVCixs9MYEyuG+E6rbsuamonnZBAi8NCGVmjBcupTh1IC?=
 =?us-ascii?Q?fK2b7SVSUk16jFSewosjiMfzDOCMnNSie1Pa4VPfXP9bsJ4MwFzvkroTkZf2?=
 =?us-ascii?Q?9Xh48AuVnihC7I1F5RKBXAotrRoStNNN/0U/TG+b6oSvVwp9MiOt4q4UQ5bA?=
 =?us-ascii?Q?l8RFMVeFQUfCfC/1ZoESp1syiSTH7i4p2orDSuRmo875/eq0YqViLJA4mVw+?=
 =?us-ascii?Q?ks9X2HTooO3TzqUrcmY26C+LRZ7i3/nExivLaOu9RJgAsuvrWgQUgpqGohIN?=
 =?us-ascii?Q?hnV1JdzAuB+zFlGntvFPzmrPj9hAFMAg9OmBAttl/IT3zvm6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4580656b-0e1c-46dd-2d63-08debb01068b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:30:21.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJVuBCOT2IIf7qZX6tGHW4YDQCyKjN16bTw39G6STKGlsekQzsWAFB7NLmzGKHoKbKPaIbqqymtBWgRhoh9wZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586

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
 tools/testing/selftests/sched_ext/total_bw.c | 201 ++++++++++++++++++-
 1 file changed, 200 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
index 5b0a619bab86e..2af01cee90cc0 100644
--- a/tools/testing/selftests/sched_ext/total_bw.c
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -100,6 +100,98 @@ static int read_total_bw_values(long *bw_values, int max_cpus)
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
+	if (fclose(fp) != 0)
+		ret = -1;
+
+	return ret;
+}
+
+static int read_fair_runtime_all(int nr_cpus, long *runtimes)
+{
+	int i;
+
+	for (i = 0; i < nr_cpus; i++) {
+		runtimes[i] = read_server_param("fair", "runtime", i);
+		if (runtimes[i] <= 0)
+			return -1;
+	}
+
+	return 0;
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
+/*
+ * Restore per-CPU fair_server runtimes.
+ */
+static int restore_fair_runtime_all(int nr_cpus, const long *runtimes)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (write_server_param("fair", "runtime", i, runtimes[i]) < 0) {
+			SCX_ERR("Failed to restore fair_server runtime on CPU %d", i);
+			ret = -1;
+		}
+	}
+
+	return ret;
+}
+
 static bool verify_total_bw_consistency(long *bw_values, int count)
 {
 	int i;
@@ -217,6 +309,9 @@ static enum scx_test_status run(void *ctx)
 	struct bpf_link *link;
 	long loaded_bw[MAX_CPUS];
 	long unloaded_bw[MAX_CPUS];
+	long doubled_bw[MAX_CPUS];
+	long original_runtime[MAX_CPUS], doubled_runtime;
+	enum scx_test_status ret;
 	int i;
 
 	/* Test scenario 2: BPF program loaded */
@@ -257,7 +352,111 @@ static enum scx_test_status run(void *ctx)
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
+	if (read_fair_runtime_all(test_ctx->nr_cpus, original_runtime) < 0) {
+		fprintf(stderr, "Skipping attach/detach validation: debugfs not accessible\n");
+		return SCX_TEST_PASS;
+	}
+	doubled_runtime = original_runtime[0] * 2;
+
+	fprintf(stderr,
+		"Setting fair_server runtime to %ld ns on all CPUs (orig %ld)\n",
+		doubled_runtime, original_runtime[0]);
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
+			SCX_ERR("CPU%d: fair did not increase total_bw (baseline=%ld, doubled=%ld)",
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
+	 * In full mode the customized fair_server is detached and ext_server is
+	 * attached at its default runtime, total_bw must match baseline.
+	 */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (loaded_bw[i] != test_ctx->baseline_bw[i]) {
+			SCX_ERR("CPU%d: expected bw %ld (fair detached, ext default), got %ld",
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
+	if (restore_fair_runtime_all(test_ctx->nr_cpus, original_runtime) < 0)
+		SCX_ERR("Failed to fully restore per-CPU fair_server runtimes");
+
+	return ret;
 }
 
 static void cleanup(void *ctx)
-- 
2.54.0

