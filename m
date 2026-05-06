Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F04B8DF6
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089678; cv=fail; b=mqL3nBB0Z+z4Dvqx5ZjJCFVIPYwMNXpm8NWOmvFRNVmXWSw2QzlhZD0e0k446f1d6IPISot0C2ktpycpTmC6tMJxIwXSeLk2l0fujRxVkrrSteKJPVpvW2c8subVVS4NCXDLKWpyGG1SPjMC2+jM88MAUutf/GBdW6mzyEutTsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089678; c=relaxed/simple;
	bh=R9apPPZZZs4hZPLz5so8XCWTCCltb87tGpq+ZhgSPy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPFYHgj9pupWX1ZLDRahJeZ8kYmjmT6igKzp3fka6txBSp5jyx+DxPcZabVrX6FW2sp3mhLQ2BUcFUkHhryXfcQd1rt5Neo3/3htmHD5Im9HD90F+PAdOVVNP3i9fmym+WwpCu/ucJO+Rik1VonJAfi0iN0VEb8k2sLVbF2Ab/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RorTu85T; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RorTu85T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjKejdfXxxLrCw/NlKg17KZoHms1cWOpEye0Dr4uznq5wq0Th7QbHhchHQA51Nz77WRMWM2HvyKBQpxveQ7xUQSfmpzMfzPTENDEtaORUrMm3RSgmw4IYnhSYo+34L6SNASYKN5nUsJ29jVSyhEaPMW1/MbB8yquZUCXKBOuV2Nc0mmIkaBD+IwsvrsDu9TPErvZn73JPy4e1hUFJqYK68L9u48n/t/r2tPQO1zf0X4cvDZ9leZr+/uennc9sQymdpJJGNx+4C7Hyd+y1V+PlRANs8TKnzHT+1EAQFHBOT2Mg7s/Wo0Ya1GA/gFxn6sFfIY+3KJ37eawo0WKSkA1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/1gEyra0WP5g50ycPh5EUurVggNq4MsdvKbcF5st/M=;
 b=UqDXFU9bTW8Kj9yEIihZ3wF43mizVT+1mM5ztMdbBwx851VtC6eHI1xQeT9l3ATjse50j19Q+T9ggKJpRsnxO9XhJoCA6d9MjWzfV0bwZ9QGiW21/Gx/4XJ4mESNThRKGEkxFCYuyGFQ4KgmhPmiVNsjTvHXUbJisvZaSSxPqP7grkZrhL9u/T6mQi046xB6A5yhGviEX4EuGInsVCiRhGjL740aWmZ6eibBaYy3tCtOGlfdAoxHakCYIq8PiK/Rc+LkgGndexzZehbgC+QUaqPDQyp7ks8rjEc1z96U93C78dMy2hq5/PwaqJWTkSaIDZLbE2AwcH3ky2LHOz3EEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/1gEyra0WP5g50ycPh5EUurVggNq4MsdvKbcF5st/M=;
 b=RorTu85TDd+5Xr8i1v71LgCS1nyHvu3aA9Px9bPLfF2pEHaKCMt51y0JLclN6DgR1kVs2MTIVLFhX/SEk+Acu+bGfm/6YF6kh4dSrp01SXpgxKFjppQJ26CXwY7FJo/rv8j0uXVDV4KMFnnkgzs5cAiv91EQlCy0SdcalSSrMee9GGp+sJy0jclVfqlXfyF+c/U+FS1o34trTKrBtkOnvtyVNmcqX6UM6pCW9iJlDS3BXky/CTdsSPd8K/moHEXVcl4KkV81jsmRT2ZP6MxPgIyiwLEEzfAundmpiKi2VdBya46JGFRgIpvgQxIKgYUM/vlJm5G9gJ8OS0j+vYih5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 17:47:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:47:40 +0000
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
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] sched/core: Disable proxy-exec context switch under sched_ext by default
Date: Wed,  6 May 2026 19:45:49 +0200
Message-ID: <20260506174639.535232-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: e6738ede-c680-474c-c28d-08deab9791a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	s7f8PGFkGbKaiq9IBT2rt3WQ/xTV1pBpxvOcOqtdrkX/zlb+bAkhrp5lXTSu27nY3TWQRTeaP4i9h5lfsM+7t4dCbcjWRaoGjOP1mRYZIh6CbTlhMtE4YRjswmblCOcvV0q0Exoo4FPDYySRQ9DFXvQwovSjz5CoCd8gLLw2ax0mvYghTs/i4Uuv9L/V/y8A5z907Eyn6k4fhNraagTVwGizlhfnfKdtow///UvkQJspC0IpyRN9/DpIt840971JYxyrMVToOkmudsi6vuyeMWZjCqNAaO5jNQIPrqZ/hOHYnQl3WqOEU0SIBlBhnixeiJiMCiyTUZr1lF91fTM0xHMM0qSDj1AG8X6ELnhK5EGs7qd0fEzyqqrq9RieFgqm5w5ioy6hpMjO6ttMggwf5aEGJ0QO0GUwDnjhc2l1vbl9FqVH6UeorQ50+2rQ3dayTe5mMTi07Azqgst0TaAgOEENNCas9mnnGPmbCBc9oXVaqflNa23E+nwDGR+H75628KJF8RozFqr+mPXKXn8WQjpd7CzukTrw0k1gSbhqdMDRFc032RQfCLiGu3IX1O/B9oVa4hgTEjGKDxUwdSIZqSsMRyBvNaPxUVjp6KeFpDEcVcfRJ/9tcR75xRHwVJUILbe2MebBov/Li3KTKZK5+5l++PTXo9WBLpbAkVjuI1RXjUU9cQCISpBeZiVT+00p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iCY1qsqTF0tQkiUHWMrEmiPFc2o2NQI4aLDupP6kB5eaQ5mVUVqyMet8UT+O?=
 =?us-ascii?Q?EzWGLrhRkmJtXPaFV/v1Mhf7N4f7EBG1QLq/WbrEEGMo8ZRGgPLuR7bvCS5h?=
 =?us-ascii?Q?2z3dN1RfCj887sPPeSLdGI4UHOm2u7f/tmKablOQfG9SNAfrfjNr2Iuw91Wx?=
 =?us-ascii?Q?tEr8XhXLirZdJooL034kCQ1cLpU3BMhc/OF3/i8ng6+3uvE+DrjgYqLn8fSm?=
 =?us-ascii?Q?4zOl89/VqoCqEOCjI7HhBWI3mbrRCpjrw1WgsluopFtZHgBtXB0rd5Zx0Z/I?=
 =?us-ascii?Q?ldq04A/Q9KZDIjiwXdcxCnTyaKZvHKYtupPQjCuVikFpX01iAlUTnxNoRszx?=
 =?us-ascii?Q?YBs8qfdYSvn+N1g3Ro0wNE07YRR9quGD6xKD7SxAMOQW7kcumLCWM2m7R3Ip?=
 =?us-ascii?Q?vcooPR0mvdNHM5lzCiustx4PmBgsvLJh1clxWYvWlKLhfq6XuJ08xu5CUkGD?=
 =?us-ascii?Q?ubaTh9ZCBMaeOblE7iR8DRoBM2oP2y6FWgUuUnyvhdiSI+Y/5jypmrssYXzb?=
 =?us-ascii?Q?FLfMvgB2XNqKYFsG2/3jGxAPDV5pbB03og3EL4c3NSuvIpYagZ+qLWu0LnNG?=
 =?us-ascii?Q?rN0K+Y/LMEAtWuXLj7IxCSGIxd3KNeua74Hra2EaPpK9clS6PZtzZjIqgVVa?=
 =?us-ascii?Q?lDEq2rzZULTOuFZACWNFFStqifspAJ40zCrWqajStH+4cbANGBR95P87uJC5?=
 =?us-ascii?Q?qoQejrk7d/GgkL+3PA0SbjvJKuFg/6fLVofGstvj3wrCCxR0VW/4bUSSqYgA?=
 =?us-ascii?Q?EyJPh1x8qbn/u5B7iAZ88ILbseGNKhYimG9HbVyceh8x2IBBCOQ1rVevZhQC?=
 =?us-ascii?Q?+P9UfhPQjUXVNvi2gzsOHt4FeZSGa+yzKMcgYph9wjl/X9YUUWff79qy1PGF?=
 =?us-ascii?Q?vZH39rKinCIgj/wd8OM2/g9ladwk6XXjH+rw1VhPeghLxLV46PNOs60oBuAW?=
 =?us-ascii?Q?S0P83bqGJ+1pekuD55ZCpUbfj3pPJJ4PQ3NitgyZX6bledtC6v4GIbPTKq0E?=
 =?us-ascii?Q?kfWa8p2u+Ma3V+s0MLA1DA1v5qnSVkJp/Zon80YklCnMx29wpm8gQ8jfJwwF?=
 =?us-ascii?Q?u0XfxCv/N5M47PVZwVFa2gEFXycJGexc/CAy+uMJwXTag2M1E4g+Uk1Kb0s+?=
 =?us-ascii?Q?G1mLp+rz46o6dJmyr/jEP1ugRpAMtigVQ6WZbIKalI7X2kv89qmjD/Fwq7WO?=
 =?us-ascii?Q?UoTwgA0DMgHA1q8lHKE9IoAd5OlVeWrmXSTmJuYXGx8eGSF3sog1TL5k5ex8?=
 =?us-ascii?Q?TsVl93n+DmySMfq+v1g8yA/kMeTM5Vwbwm5KL4Axb/eNEZHx9Ygv3IVNLlcG?=
 =?us-ascii?Q?+FPdceOmUC2rRWWznRSVmQnmMsiFkYQo0FtRF9Zmq1jAhfu3wae3WJ86MATs?=
 =?us-ascii?Q?nd0/sz+zElQmSygiX96k15Gdkvc+yBiqtVuHu3pGuo//l0NiejWkscGt2Lno?=
 =?us-ascii?Q?iz5dl3seQ/KKWRH7wzAAxDqj4QXWCwefm3vLD7cGMB52ARRqgkOO/p+9Uuc2?=
 =?us-ascii?Q?02CHaEZBvok3vVBdOv4t5Hhzw1x+mMVfROUc0xrRw0QvtVIkEc3a4ycnEibS?=
 =?us-ascii?Q?+2YE9AYg+L2SXcHc5Q/H8shp7bII9rP7iNFxVsrZGP/+yd5slimpadET3hA3?=
 =?us-ascii?Q?PR8JYOYXBKdmcw+M8xWGw/18zfftrOVf0DP1BDCuh1/lFsuQN2txAEq7yB34?=
 =?us-ascii?Q?3KaRJ05IVHEdobSbM1RYxwa6Gh7+Q7Auvv+58gjQcrPgvcVMpFlOHkFaC89V?=
 =?us-ascii?Q?K+yiaMkL4A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6738ede-c680-474c-c28d-08deab9791a2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:47:40.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wxp1ynOsdL5fhIVGBI10OWcLZgjAwUeJB4eGfiYAOczyd58/kronFpvb/6sB1h0+5dBGaGxF2fvyJWFeTtO3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

Proxy execution switches a donor's execution context to the mutex owner,
so the owner can make progress while the donor remains on the runqueue.

This logic might be incompatible with some sched_ext schedulers: the BPF
scheduler picks tasks through its own dispatch interface, and a
proxy-exec switch may end up running a task the BPF scheduler never
dispatched. This mismatch can break BPF context: sched_ext callbacks
fire against a task that isn't the one the BPF scheduler tracks as
running, so any kfunc they invoke operates on an inconsistent view of
the current task.

Therefore, when sched_ext is enabled, disable proxy-exec context
donation by default:

  - Force try_to_block_task() to actually block a mutex-blocked prev
    instead of keeping it on the rq as a donor.

  - Skip find_proxy_task() in the pick path. Clear any leftover
    PROXY_WAKING marker set by the mutex handoff, since
    find_proxy_task() is no longer there to do it; otherwise the task
    trips the blocked_on mismatch WARN in __set_task_blocked_on() when
    it resumes the mutex_lock() retry loop.

However, some schedulers may not consider proxy execution as a real
"task switch" and more like a "function call": the donor effectively
executes the lock owner's critical section, so the switch does not
represent a true change in scheduling ownership.

To handle both semantics, add a boot-time knob to enable proxy execution
under sched_ext when explicitly desired:

  sched_proxy_exec_scx=0|1

The default is 0, keeping proxy-exec disabled for the reasons described
above. Setting it to 1 allows donor->owner context switch even with
sched_ext enabled.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 kernel/sched/core.c                           | 47 ++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4510b4b3c4165..f73c12e9645de 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6821,6 +6821,12 @@ Kernel parameters
 			solution to mutex-based priority inversion.
 			Format: <bool>
 
+	sched_proxy_exec_scx= [KNL]
+			Enables or disables proxy execution when sched_ext is
+			enabled. The default is disabled, meaning proxy-exec
+			context donation is suppressed while sched_ext is active.
+			Format: <bool>
+
 	sched_verbose	[KNL,EARLY] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1c161dd9d7440..0f714c6613771 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -151,14 +151,52 @@ static int __init setup_proxy_exec(char *str)
 	}
 	return 1;
 }
+
+DEFINE_STATIC_KEY_FALSE(__sched_proxy_exec_scx);
+static __always_inline bool sched_proxy_exec_scx(void)
+{
+	return static_branch_unlikely(&__sched_proxy_exec_scx);
+}
+
+static int __init setup_proxy_exec_scx(char *str)
+{
+	bool proxy_scx_enable = false;
+
+	if (*str && kstrtobool(str + 1, &proxy_scx_enable)) {
+		pr_warn("Unable to parse sched_proxy_exec_scx=\n");
+		return 0;
+	}
+
+	if (proxy_scx_enable) {
+		pr_info("sched_proxy_exec_scx enabled via boot arg\n");
+		static_branch_enable(&__sched_proxy_exec_scx);
+	} else {
+		pr_info("sched_proxy_exec_scx disabled via boot arg\n");
+		static_branch_disable(&__sched_proxy_exec_scx);
+	}
+
+	return 1;
+}
 #else
 static int __init setup_proxy_exec(char *str)
 {
 	pr_warn("CONFIG_SCHED_PROXY_EXEC=n, so it cannot be enabled or disabled at boot time\n");
 	return 0;
 }
+
+static __always_inline bool sched_proxy_exec_scx(void)
+{
+	return false;
+}
+
+static int __init setup_proxy_exec_scx(char *str)
+{
+	pr_warn("CONFIG_SCHED_PROXY_EXEC=n, so sched_proxy_exec_scx= is ignored\n");
+	return 0;
+}
 #endif
 __setup("sched_proxy_exec", setup_proxy_exec);
+__setup("sched_proxy_exec_scx", setup_proxy_exec_scx);
 
 /*
  * Debugging: various feature bits
@@ -7111,7 +7149,8 @@ static void __sched notrace __schedule(int sched_mode)
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
-				  !task_is_blocked(prev));
+				  !task_is_blocked(prev) ||
+				  (scx_enabled() && !sched_proxy_exec_scx()));
 		switch_count = &prev->nvcsw;
 	}
 
@@ -7123,6 +7162,12 @@ static void __sched notrace __schedule(int sched_mode)
 		struct task_struct *prev_donor = rq->donor;
 
 		rq_set_donor(rq, next);
+		if (scx_enabled() && !sched_proxy_exec_scx()) {
+			if (unlikely(next->blocked_on))
+				clear_task_blocked_on(next, PROXY_WAKING);
+			goto picked;
+		}
+
 		if (unlikely(next->blocked_on)) {
 			next = find_proxy_task(rq, next, &rf);
 			if (!next) {
-- 
2.54.0

