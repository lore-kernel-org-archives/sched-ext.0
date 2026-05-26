Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E143DB983
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813892; cv=fail; b=aDKQo/4adrX+P6925WrP/6bRmUvhQrc4cJBoQjwVqlrnv6KWTzdqIzWKAC15xyhimp9kVIpBfSZK80Urz7HGJ7sSvvJFeuxIdNqQp9nBIjjQ8nJbuh78BYpcZ1kRH6TwKcRFq9Jng6FeX/lyUtYHDGjg7kBQ3tBQ9s/W6AiFw1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813892; c=relaxed/simple;
	bh=M0XOWJO3n6fZIPlEmHtBTdztia/H2eG4KiLJbDnQnt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCjmvRKTirqmokk8yAldYUj7sTRlLrjjZBBNw6hNo7TOIw6OSxF+dVi6ocG/AwSxnBr6e6FZCNCqZ1cu0//M7SjjRlwvwX2poh5nf132IzvRLl7eneQT/sBXQrz7Pnf+/xMa199J7fzg6kBGvQtFpGrdeJaVew6XCm9lAF1/Xb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GEbHTf12; arc=fail smtp.client-ip=52.101.56.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GEbHTf12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIOFtB03953fvrnWp+Git0io9/bDc7cQDDqqUV3L504tL/WxJWAH0r55DYvJfyFLr6M7Bd9jyYsWVarz75bjaSfOGqpwYNtvcp9o58gMOU8gfwqZZfuMVs62uYQ8bE9oICGGPbW68pXmB6l8VoJ2w3cBIJpB2hruIYzm/vHtwHF9/XBJJ8d5od08+62bJ1in6Ha3NDXyiOanYV6GKF7hCIgamZl5XeNoVf02LpuXbXzwdNJcCeu7HDmIElOUfSEXG1JTBpxE3w4gFp+bbcZXg5NO8RI6zY0xjELGPb7io3BZxuPFoFV3QenxzDq4sD2UUkn+Gp57FibqluKJgDjO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP1y5MDSxD9u0mZDFbV3SH1BF8HdzYHs45cqhlOeess=;
 b=AgEfDUGrPO8UN5zzMnxe+bDIc+xrBu2h2ddqqKoQ4Z1fvsXMHdRMWux0Q52P5mAwrU1bqPJ5mm14pCCZpqZ0g8mRgrLq8xWI/Ld25U/71tcr0uO8seebgYvkdeW9Hxwu7rqWple4OIYKiMi3p7K/2/270Pg8/6gscjP13p7+RTr1iLoPIYjOnusOvIUQNftEVjVFFPOQvkQrZlj+ruc0CXirePtOB0/ajO9oU8oPT+uRThmBY2GYqZHRQpS7GFHLLvi8MAaWUNOZ5Uyh0EOm0hXvhRBRFgDuFG6h9Vj7m10dbSVWyakkla4ZwgxrWwGqVeVgUH7/eOoLxgW0e2HZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP1y5MDSxD9u0mZDFbV3SH1BF8HdzYHs45cqhlOeess=;
 b=GEbHTf123SaHp8I7oDEtDWGpOqxeiTPAPOJKl0CI6IaLRtUuz6pajcKOoztMGqd3++CJSM9+RM9B/LEFf5bB9LjiDSoCx+9DxKrmmY1nEFtHCSjHkPNIeVQDPcQrvv9Zbjr5SU+ZNMfeuJwrvnjfg/AQfduV3yxt5/r+1dK5WTcdRpqR+fbsECGL7MIb8UN3BiFx+u1M37La+B+YIdLqVJQDBfHQJAflfpp3Y9j+hSbgXm2DhQGtfx5jDOtmqynzmsmAntzTavXzEJ+u6PE/bGRR1N2YRsv16VyH5rvGOVSonhufjWu5D0ICtVsgxXqJQe+6LaWM+TfYX9lG8Jo6mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 16:44:44 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 16:44:44 +0000
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
Date: Tue, 26 May 2026 18:42:49 +0200
Message-ID: <20260526164420.638711-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526164420.638711-1-arighi@nvidia.com>
References: <20260526164420.638711-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:805:106::17) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5a457c-1a2e-4738-1023-08debb461716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099006|18002099003|22082099003|6133799003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	8SzXZ6/mnzQwLhQy0104nvTMPwwJweWW5CZpItPa4SocP6g+eQWTilTXQVl/MuCq/1YxvCwq+rEVlRmWvjrz+Rf4CIoSwQfavpUN3qj0sE285Nc6hdgGhZp72Gt2opk4L9M3AXSq2+28w93ObIiYqOFkeSWOkagpy2+Xi5/EWH4p8BIU7YXA2KHflfYuBNjrrL1iPhZEKf3XDgk1TKwbqhSjEWjBQJso268uplfUBrvsZsdt4Mn19QOFv3m644mhmAyJpMt2XT4z/6O/Drw7A65GFFgkrZtzEJsuHrNOl//G3Gvfi7pwb2NV0cdz3MfAVwQFqXA0j1IqHFxxto9FOJsDgNzE8oEOXYUK7OwnVKUn0rxQUfmaGjJivD9KG0BvLdejLYtHLB1HqWUr5SFz3HTm19ItYrVgJ1BMD1NClGM0vdwE/JIjIfAkKlN3+mQE1H2jwnOlI01YMhw8s42fIbv+iljhicdi7IxUjg5veWQ+7kTIYJsX1a8dzlwpc2/8qp24gv1hgIywQvd8YzrRYeTRrCidSOEbqHrDRni7Ystcawj89s+FHLXkPH6PE+sRN47MF4ZKPJO2khRD9cCb6mkbzXPlEBqEg3LolbzfQvKTU0TG3HvwvYnOu9M+R/lVUMsSxB9eaepSChGNzLWEqFLvhoRlKNECVVFcpNEFuKckRMScZgsuP+MRkGUrTWvh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099006)(18002099003)(22082099003)(6133799003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?We2oJBBGGaTlUqGl3KXvTOEXxK1bWWn7a6g4DrW/nKQdzE7cyFjEPH+wfHOY?=
 =?us-ascii?Q?v7iEPoftTqyxKxsrYykyEXWXOmIwrIG8vpchUO+6MH224yKVopDVtVXOQdbe?=
 =?us-ascii?Q?8eBD7NI3QHti3Ach3q+VZtywJqg0YPMlK6yjJVyy4zucz1NfPqBhwEXUU2qE?=
 =?us-ascii?Q?OAHWOcSZhlsUAhEK1mNJzGWn/oWx8Np9JAccNxBL/Il3VTBNB+SmhWW33T7S?=
 =?us-ascii?Q?DHN8sq/m02ed+2jVHNoj2qiFUrBUHyb9zLPCzl1TauycZnl7iWRth0gxkrhB?=
 =?us-ascii?Q?O0BQeGsbZ4WPxTA1Fb5pbHl4220kJgssdNptxCdxkM7IeiuKRcoAqMr31LGq?=
 =?us-ascii?Q?AG9XSvTqtx43kyZaHKpeFBqBBSD0SAUBg6J70D4aEb9GTLTlA+pIXozBv7fK?=
 =?us-ascii?Q?MueY/X9r5XIdvc/HyRPmcjaAOPEV+KnZqnzwJ6TZq9S4qxtSo+3zKid8uBOL?=
 =?us-ascii?Q?g5OSGRCtncL7tqZjqYXt093lWkCkb1thSuzqrhGmmK8L3f3vwAaxZUf0orOV?=
 =?us-ascii?Q?oGfrA1jw7GfBoQ6PL64QgffDQbEIfvt5QGiToKc/zSx+nZBYHrQtF7W52zKv?=
 =?us-ascii?Q?lIcZMvHxQ8DmtXrHCpKFbsrwY0PBOiW59PbzsBXh/7jzwauRCA2wi+m8Cjfv?=
 =?us-ascii?Q?WyQluiS+C+fKuMjrpM9S3lowQBFe5IS80dIYFbyLkAeiCVLZFDYDyUQlUNrL?=
 =?us-ascii?Q?va7C+0YXV5AhrGvf72SEuN8Lzmx2So7oZmtpqBLtbqmdxONAFgl2AcSaGvIN?=
 =?us-ascii?Q?hCmA1l428/yKLZDnk42pwX7ASH6JYBIDoiWQWbe1MNaKSbQpLYbOXYcEF/YG?=
 =?us-ascii?Q?A+tbIE/WIWiK5h5h+/lVy+ecgESozdmQ1tvvxTohbkF2NsjIxB5O7zf0VGyL?=
 =?us-ascii?Q?rmhRU7o6bcLVVzRar27JDgbGx1e9HjEPzHrFJi5LupSAkKMvhp+tEHGEbkzA?=
 =?us-ascii?Q?S0lJCGdHJQZr0JQWG8MSGTv+V4cjNTDpvilaR1nEpzIn3V1l8thqzLKJJ8Oz?=
 =?us-ascii?Q?6NDi51MLBlMNDgZak5Op37HjCdc8GukzgZOYJnSq1xPlM0lsnXQB3ehWQCgx?=
 =?us-ascii?Q?miKTwdXp9bdDtVM54aj2FTvh694eFioKUbSWrEEeUId5OLePC6to9t9K9STE?=
 =?us-ascii?Q?g52vc0YvQrqrH2LY/OyPCzOnCOvRNcKlKPwDF6HTFo4u780tQhxc+51MABvL?=
 =?us-ascii?Q?FqsSMpTBRI5JnmIlS74BaAS/rsoD00bE23sDcyQ4tEI5VaKFFgCgz0Y89ZAv?=
 =?us-ascii?Q?gLwTtPbQrvnllpo5Lt2k6eX2jXQCjHyncZ58y305A6BwZ90IaLHHehCehgQ8?=
 =?us-ascii?Q?6vlY6tsUk1PzMJkCNvKC8udEs3Vqqi1Wy3AcglKApFGwIjJ624sFNuTjgivS?=
 =?us-ascii?Q?cIJgwGHwk2Cuoc1RGjuTjAxYPmM9kmNR9t1G0gUmCi8GFL/ybhsBQAOwZLzJ?=
 =?us-ascii?Q?TRYmSr2uJb47QgEam6QJtz7LujOOXOZuXkq+bCmTcklxVz9IRuKsZ7EuVcPZ?=
 =?us-ascii?Q?yS7ZQo+Krb3C+NBlEQQMtCzw/0rtLgnD9YdI3G8aJkCcVr5+GnsykuR5c/iE?=
 =?us-ascii?Q?yRol3u5gRmKzdpCWchkTn2W4lZvAFqSNSwUbiaOdQpMMMDHcUu8Zbzp2t5Ye?=
 =?us-ascii?Q?PPtSMTsujhC2r4p2uW9MIMNZ0AIZTVs4tXFZoHDEFp5rZkCkMULIR6m5AfYu?=
 =?us-ascii?Q?WuvXy6pHKlA+PZ+b8d9KqUFsbCnUj1orBF5n7kcyweyRL3Nr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5a457c-1a2e-4738-1023-08debb461716
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:44:44.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMDKOstyvvmaME4ujhuUOWI+6vHa12QxY7bMi5/LlU7FcuV2KJ6QMmBwWM0plL9rawZWntaD9I6C6Fx6i9IR3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

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

