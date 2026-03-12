Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7A2874E3
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301365; cv=fail; b=t15Kf0DqrMzIV28g6FpK9emyU0KZEBaK2Ufd4bt7mqpIakj3rYoV09ctVAB+fGIcZSL/g/G8R76sfUJdyFtELj8NkW4orCx96/4CVzhxfra4iGsAyHEV8vspYw5YtBrpJVAtxNsJMcTzkw1bDfAlFE3/zdI2KY+KWq1susd38ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301365; c=relaxed/simple;
	bh=b3Vru3/RmUW6q6AtO5P5JVWWsxMdTXRQLqe210d7QIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bV1YG78JsCID8gme9yVs0320yII+k+L7y9sAhUi5gF6rHkHhEOglT+TvMoTksDZHuUKPRGClQkpWhGVdsww4G39fzxy8AU7IamJpyrWCj9JHN/3Y7d8VBYOP5LWoC98D86nJRW8z/HUPn34tm3HGmTJvw5S13ZOW6pZxK1DM8B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TdZzTGvb; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TdZzTGvb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPmvSByWwvmSYJNFjN9SLc8asswLvmbwP88DYI6GAaG/h5uuxcqEyC3YE3muCKrOQmhV04aSi0WolaCotuQ/Q//BEz2XtBUUw0V8W4eVoe3GeZ3kLT8uJacrIFazLCkt1LKW3UELR5G63bf0VqDgcN1zJCIAdX7wcr8JMPT7Bv2ksSLjicfYx8beQnmx7xNYYFoAvKJqOtEsS7PvDOVeMOFFkI/P0cKDJMEcWNCcNQYim1XYFpS3btalLdvZr1gPWlMiEFT79SesW9YCYdrQGpdsZvUfKe/XYkFyEIJsFEJ/Avfhytkw2Jvlv+GdTzsgsuqx9W4hjEmRw24VoHiyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O13HRaK+I1x5VoXAPcf8ussHidCz8V3ERXo+VPSC9Go=;
 b=VMvsub4GJprhi7ijrOASonXaSxfvYXwrWfI2+F5FIEObg3fpWSGjJihVlCUtSCDJU9RUDQbV7973LyrxElFTDFkgQxRx4C/Kxwj7rkNfJPwVAQpq2wVNvGPHB/6/kn3rUTb6wkkgaq0e7oIS5wh8bEqdidGOlM+nJba1FzI+g63karfaJAPruVUiIQdz/kzuSTjKv4YZPr14gpOtU5+rMMCWkgHsy97edPTk9hpZ0GQRV3rtuWz96fXN7PL7QnkGcKHijGHkppuM7JUbL4zcVESvNsQdOOn6w+O+L2HAVvQ/7WXH0DsTV/NqPCVLwInY9q4UUd9KNWg0Pd0tJIltiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O13HRaK+I1x5VoXAPcf8ussHidCz8V3ERXo+VPSC9Go=;
 b=TdZzTGvbHaxMAXAfE6Rgx62+987MHksh2p+F9qpTrd2nkOiK77GUzYWCxa0dgQUWJ2ViRvTGsnJcqWRuNLUIf1JkR9UtQ0txpXLpG/qbnphuf3g4ZMYZ816u7b/TOSXhaPVnx2VVNEFHTWEI1uY4fdUsB2DCRUMoHMOstMu2uKMALw+m16OdO3iKz0qYBBF41tkBDSPGkQGz7GcDuEMMINpC/xc3Ku0pO4EaoDxe/WgFbL4rdCmZjvwFPa6pm/RNSwUbkMeTTdP71RVegJH1WuXjU+4XQGkk1ORa6jgMO/s5hSANhUg9r10dTyTiL1uDWw9UKx8vHkZswhyTuTDFPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 07:40:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 07:40:39 +0000
Date: Thu, 12 Mar 2026 08:40:30 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 2/2] sched_ext: Update demo schedulers and selftests to
 drop ops.cpu_acquire/release()
Message-ID: <abJt7tIXGC0qv7ex@gpd4>
References: <20260312042001.955675-1-yphbchou0911@gmail.com>
 <20260312042001.955675-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312042001.955675-3-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fe321c-3e66-46ba-1406-08de800aa7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	4cmTv3wK3zAfzPBFOaTcayap9XJcWoTQu6ahMW8AIqLy65o/KsI2eLrMY4OqUWJQdZXAKQD4PQanOMOjQrIKpyrUrjpExnb28aSlYNKzfOpUl3CH10cu+sGBSYScxMTD8brGaTNKK1vEX0WYjqnwdcY7p8ipxUHGM0/LOABYAZG8gDJ7zjk/EBm1tBlGdZzTKt5N6ynbn1YNk7qlBhdqlpxtY0AKHuymse/p1YSD/fptxvofTNDhYe+vBhDcHRzZ+c4w5SXSc4LuUjn/HDqTgcQoOFDO0rJYxsfbe7pwNz8hRLRUydhs7Ya+FdPbb50OoShRAFUj/O+sYGU/0vGkPNNZlnA3BTZcNsvnrT+rSe0meeXnOcP9+HnBbB9uKYOdrpXNd/BhwbrORkoY1rJdV+1FszgjybwGcG5foRuDiPeprZ9YLdLq0wu9lxNNQ6yW4hKqAlwRnoPmfpVnnrMHSObU+9/62O6pX+J8ocXwQYAAZlBIBoyt3yO9Pkt6JRJpOLz/mxbRBMm0/BxytVTubRF+iTd8+M9qOFbVQ65XlH8P3oaDvgEGyP0+ndLrLrW/NABS2d8KUX8j23yi/mhkaG/ZpcdlChd1C61u+OF5/ZduERwRL7uGpv0cHplcM7TDayhtlFgdGfj4rluve2I59pj2tms85G8GkK+LL4GFX5sPPUC/PtyCzhQmxoRd8boZLSCWeIRTb8P2TFsNtw5uiWZ8LL1sJFViVmvwomo6SLY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ol05EZg6iwfvtjHp0V3hUc4T/BnN/kGWZtOb76QyQvRHOz4aZ+IhW+yAnmAZ?=
 =?us-ascii?Q?EJbEASFQG/IKkfVolcZ5SlW3+qVU97wwg9eXJDmGMxKKcnJsd4BNLM8q7kmf?=
 =?us-ascii?Q?6dLhVfZFtD5yyDjz6Pbed+QQ0hsoCEUq8tpjdwzMLES9OTQobN8q1tyalROB?=
 =?us-ascii?Q?34/wT7br16fhM0BsquBmrkmbWeqgpSqgHRgnyACWJGjJ+dRMd/YuVkjT58Rn?=
 =?us-ascii?Q?Gxqj+8XfFu4x9qD/vRgx2Xf+yM9H+Za0IGyplmPW7np537/VqQ1VNn7l/Ix5?=
 =?us-ascii?Q?KEoY00fi7QLN4Z2iFZwtC9yZpKQgWhR1QlwPQnglAr2tOj4MnBfEuLC3d9rW?=
 =?us-ascii?Q?PMItZj+T9+PeB63kBwB6xnOP5JaIvBUSYyTBJk/sCMiNDzOOC/Be25JyByMi?=
 =?us-ascii?Q?oiFc4TrLT2g5BzU+WfJzeairOaAvEdwFPkSinaL+YDLIOGG19hkyjGltQLw4?=
 =?us-ascii?Q?w52esEj/DgFLQY1deb7QI3kyl58sK3ajKkdNqw/76jxIHGxCw12LV1SkZ7C/?=
 =?us-ascii?Q?VTf9bStmGOhXAKN4qMqCJbRKFC4Rq8L5HjSJH0C3pppfoOuo5+bfWKPhlzKG?=
 =?us-ascii?Q?0EDAZvOL8jpMg/3QxTLdnfE1nb6ZNd8ZdrjI40sdXFDqaNLd3aOTnX+PCoS9?=
 =?us-ascii?Q?mqFcsWJPxevm9V7Lu39Q+VlZA0Le0t+N4RAmTBKx1yHeh7Ydw5qnkl+SsiZD?=
 =?us-ascii?Q?LZqiH4SFde70Gv/3QdH3Vn2HLiY6OsqNj9aXLhPPxXEJ8Cz80SAPMG8LNY6x?=
 =?us-ascii?Q?tW0JiG71rG775fd5UVH3CSjQXuwjZfXipBYlUXKyKOmKjGxVC4q4KbGZwSPB?=
 =?us-ascii?Q?EYO7+Y+aLJftVO3xPBgw4cAY5qC4mIPWUVU4YdGchQt/RFYRHkoBDOJatv+t?=
 =?us-ascii?Q?s4U9ugBWmhcYOjgqG031iYkS5OMxNUA4x/i2qCWyIdmclSMIw2DyK6xMAkGn?=
 =?us-ascii?Q?vq6pKWA2W4RXDwkIDVVnoVg2u7BVIjA5SkP1eva0iXo7mYXylGCIk8uEtHMk?=
 =?us-ascii?Q?VtztSO2Sh21d5B6OXEupnB7TcEG/p0SnWPg42tHGvPbr3UlA2lxL4BLqC/to?=
 =?us-ascii?Q?9eZjVWrlSNsdixhumQTKm9JkPDhHG77s1GV0vnk2fhrridKa0rbwNifyKj7D?=
 =?us-ascii?Q?NcAf2wlsgLBLaIefF38mcHqSuBzTWb9UG7M3wslgZxE+b18y5m9PyTRTv/pM?=
 =?us-ascii?Q?g+Vg87uoLGm6oAmpqRGAdTXeLRsxYJ7bVVHhoKIDeprpwcgvF4QuSOrYO5+y?=
 =?us-ascii?Q?dnpV3+dEpDbMYBhwSdvWVJ1bU4xmWVg217HCREZLbk8VIZa6IhtpqRgRuzmC?=
 =?us-ascii?Q?v65G4rgUhAnk0x0p95EXzY+aWWf1OZ64aIPhVoNYuiIfECk7azYlbt47LnGq?=
 =?us-ascii?Q?dHX+KC7saxcT3hbjlpSxeMyksDN55dh0fadhA6/VS3AXdKFPQL7gV/jQ+U6Z?=
 =?us-ascii?Q?Hqg0PZMc+Y24u0UXbJ8+UDKyYs4FZaJJvLIU/RJdK8xoanwkpdnwjzeyoS2c?=
 =?us-ascii?Q?2yiQuGkw6ma9Hjz1UJbBIUeLCSnqAFZ+jrTzKSelmAqaBaEP79TpnFWqgTPo?=
 =?us-ascii?Q?kU1cx2q9yjf7KaTxWd9R9qj4qW4YaYXOMMrkT2ZIz8OgTqeKc/2KWShZkgFv?=
 =?us-ascii?Q?geKb0iJYCF/GCX7JayxLI/BEF1ZM5PQc5Eql64chJBbd87gh25ry+ErarbK4?=
 =?us-ascii?Q?UxynR0Abg0lC7ZHQ/aZ2nqf4yGSdD07dI07X9WnP3Gdn6vRkePjWDpxFF6CF?=
 =?us-ascii?Q?l51ofWKCeA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fe321c-3e66-46ba-1406-08de800aa7fe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 07:40:39.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IzJXdaS1TuGWXJEs00dN5uY57lLwdcSosp7op1hEZPUWke9Yq0CaEjxQQpSXvYr8D+TFrKEi5NpAFiWO1ZRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

Hi Cheng-Yang,

On Thu, Mar 12, 2026 at 12:20:01PM +0800, Cheng-Yang Chou wrote:
> ops.cpu_acquire() and ops.cpu_release() are deprecated in favor of
> handling CPU preemption via the sched_switch tracepoint. Update scx_qmap
> and the maximal selftest to use the new approach.

We could mention that commit a3f5d4822253 ("sched_ext: Allow
scx_bpf_reenqueue_local() to be called from anywhere") is deprecating
ops.cpu_acquire/relese().

> 
> In scx_qmap, remove the cpu_release fallback and the
> __COMPAT_scx_bpf_reenqueue_local_from_anywhere() compat guard from
> qmap_sched_switch(), unconditionally handling preemption via the TP.
> 
> In the maximal selftest, replace the cpu_acquire and cpu_release stubs
> with a minimal sched_switch TP program.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  tools/sched_ext/scx_qmap.bpf.c                  | 15 ++-------------
>  tools/testing/selftests/sched_ext/maximal.bpf.c | 15 ++++++---------
>  2 files changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index a4a1b84fe359..a11e27c8de77 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -11,8 +11,8 @@
>   *
>   * - BPF-side queueing using PIDs.
>   * - Sleepable per-task storage allocation using ops.prep_enable().
> - * - Using ops.cpu_release() to handle a higher priority scheduling class taking
> - *   the CPU away.
> + * - Using the sched_switch tracepoint to handle a higher priority scheduling
> + *   class taking the CPU away.
>   * - Core-sched support.
>   *
>   * This scheduler is primarily for demonstration and testing of sched_ext
> @@ -562,9 +562,6 @@ SEC("tp_btf/sched_switch")
>  int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
>  	     struct task_struct *next, unsigned long prev_state)
>  {
> -	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> -		return 0;
> -
>  	/*
>  	 * If @cpu is taken by a higher priority scheduling class, it is no
>  	 * longer available for executing sched_ext tasks. As we don't want the
> @@ -586,13 +583,6 @@ int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
>  	return 0;
>  }
>  
> -void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
> -{
> -	/* see qmap_sched_switch() to learn how to do this on newer kernels */
> -	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> -		scx_bpf_reenqueue_local();
> -}
> -
>  s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
>  		   struct scx_init_task_args *args)
>  {
> @@ -999,7 +989,6 @@ SCX_OPS_DEFINE(qmap_ops,
>  	       .dispatch		= (void *)qmap_dispatch,
>  	       .tick			= (void *)qmap_tick,
>  	       .core_sched_before	= (void *)qmap_core_sched_before,
> -	       .cpu_release		= (void *)qmap_cpu_release,
>  	       .init_task		= (void *)qmap_init_task,
>  	       .dump			= (void *)qmap_dump,
>  	       .dump_cpu		= (void *)qmap_dump_cpu,
> diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
> index 01cf4f3da4e0..5858f64313e9 100644
> --- a/tools/testing/selftests/sched_ext/maximal.bpf.c
> +++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
> @@ -67,13 +67,12 @@ void BPF_STRUCT_OPS(maximal_set_cpumask, struct task_struct *p,
>  void BPF_STRUCT_OPS(maximal_update_idle, s32 cpu, bool idle)
>  {}
>  
> -void BPF_STRUCT_OPS(maximal_cpu_acquire, s32 cpu,
> -		    struct scx_cpu_acquire_args *args)
> -{}
> -
> -void BPF_STRUCT_OPS(maximal_cpu_release, s32 cpu,
> -		    struct scx_cpu_release_args *args)
> -{}
> +SEC("tp_btf/sched_switch")
> +int BPF_PROG(maximal_sched_switch, bool preempt, struct task_struct *prev,
> +	     struct task_struct *next, unsigned long prev_state)
> +{
> +	return 0;
> +}

I think this tracepoint is never attached. You can verify it by adding a
bpf_printk("hello") here and check if you see any message in
/sys/kernel/tracing/trace_pipe.

To attach this TP you need to do something like this:

diff --git a/tools/testing/selftests/sched_ext/maximal.c b/tools/testing/selftests/sched_ext/maximal.c
index c6be50a9941d5..1dc3692246705 100644
--- a/tools/testing/selftests/sched_ext/maximal.c
+++ b/tools/testing/selftests/sched_ext/maximal.c
@@ -19,6 +19,9 @@ static enum scx_test_status setup(void **ctx)
 	SCX_ENUM_INIT(skel);
 	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
 
+	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
+	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
index 308211d804364..49297b83d748d 100644
--- a/tools/testing/selftests/sched_ext/reload_loop.c
+++ b/tools/testing/selftests/sched_ext/reload_loop.c
@@ -23,6 +23,9 @@ static enum scx_test_status setup(void **ctx)
 	SCX_ENUM_INIT(skel);
 	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
 
+	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
+	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
+
 	return SCX_TEST_PASS;
 }
 
>  
>  void BPF_STRUCT_OPS(maximal_cpu_online, s32 cpu)
>  {}
> @@ -150,8 +149,6 @@ struct sched_ext_ops maximal_ops = {
>  	.set_weight		= (void *) maximal_set_weight,
>  	.set_cpumask		= (void *) maximal_set_cpumask,
>  	.update_idle		= (void *) maximal_update_idle,
> -	.cpu_acquire		= (void *) maximal_cpu_acquire,
> -	.cpu_release		= (void *) maximal_cpu_release,
>  	.cpu_online		= (void *) maximal_cpu_online,
>  	.cpu_offline		= (void *) maximal_cpu_offline,
>  	.init_task		= (void *) maximal_init_task,
> -- 
> 2.48.1
> 

Thanks,
-Andrea
