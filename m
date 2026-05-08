Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B22517AC
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227744; cv=fail; b=EHPuZBnPE6QaBp7dYY9DJYJhog3eGYHzD2wb/p3sYoGP/y7yIIW53NyFBZ+fLv1NAJqP34CasSRXOpRECrvDEt2UvJatohZFQVq3SUT5lqPpgq+0SoLxo7TkOJW3TM5WE+TDqPPVNvPee1GhzNRfvxLmvJE0wqJHr2MOmTT0460=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227744; c=relaxed/simple;
	bh=hb3uknCFaummuagZ25CJD/r5SLgX1iJq52IrBkBV3CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xf1WdejeM3LOzkwOXEjyT0lvRdh0pFjXetYDIuY6l2dozVVw3tQv3ZUJlUu5GVSPlyuxUtv4+zY8chv+tklWD3k7lmh9HXqnK7hfghBn9jcJEjB/47tOUE842AE7rmNyfGgiFmEZS6prb094frSY4VnexrSgi74eLQOHr9P1L3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gdMwdEU7; arc=fail smtp.client-ip=52.101.52.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gdMwdEU7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veOeR709hgkHa7gjraQCgdekNH9EdPM+GHYUKcJjtLwqG6QpNweQ2FRpDK1HyroIEile/g3QXKwOMtmbodmSniqw5GrQxY7L8d82/xb45lyHhfHooB8gI1K8moOiTdKoQsswmiFnlakgKmm6iXKGG80DkpP0QevdvYVkOKTr4aoaBeTTq1Z/xZuOrWSW9QzmAOMO9c/+YF4z5tbY48S6H7cu83BkRHcDtp083BhZrl2bKgwjnLj5/8fnfhTT3aY+0I8av5VRZckbWdVpgDn8grrNiPEsnKuyMDa0yOrq/zAIhaOth20KfL46E0gxQHO26RqeN2MZpPMoqNWh7fMF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/MsVAn3SHLXP/r2GSmLvn0/RSdU0xrpP+xz0k+4tIs=;
 b=fLvQw5qmAkTGFBDvXraaBcRcgW/Qlo4+22P95MEeR9oGUzIFpFCUc6v8QOX8AJv00Yi1xpp7Rmt78g40p6MpqVCtLEAtPj9DzR1iOtoI99mUb/9c5LKtC4loqC1j+gJ3GNcO2XSzdOtlSH1AB3+SWSuFoRgUfln8A7In7vJ7q6PO10+PfMi6PzMoStlifEWhbsYBPcPJXMjSfWUyzxSJR8X3jjk8cVeS4ebQ/1bXgstfoqLn5ib/U4DeoQgV8scIldbe/8YhCjpHyjY1yPuEVNElFxAw4e2ggP+5r3bSqoJ01gL8xTKx6+uFocDOG+854clg8LCA6PKqgLdbRFYWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/MsVAn3SHLXP/r2GSmLvn0/RSdU0xrpP+xz0k+4tIs=;
 b=gdMwdEU7hL73EsawS4ZqDEXBnHjwZrIer/LmP/3QFQXhFv23aMxbcrr/rzNoj4ggfu2MeebjLPfbl0cSHbwnup+dqS5cvldF58vA33WwCviMq+0QGbLV8s8UffKNtuGGv0Wg0SnrgdX4h/MZDtDylQuBaPmCuDOuEPc2WfYl/uAcKsiJ7ea3XJXIjenXpXw7zjG5/T4Ie8HEXJB7vsR48ZvDoSRA6w08KZWJVQdVV3IUQDWW6w6gsJn0///XkDfW5yz3A9p7pCO2iO3qI+3vKLJrXPALAkhzqF+Fnq1Ae3eCK+wr22Y+oziUdNdRlyrTaMwD1ueP//JrwVcKFk5RSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 08:08:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 08:08:58 +0000
Date: Fri, 8 May 2026 10:08:47 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] selftests/sched_ext: Fix
 select_cpu_dfl link leak on early return
Message-ID: <af2aD8-tFi_yhPOV@gpd4>
References: <20260508065514.1723906-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508065514.1723906-1-yphbchou0911@gmail.com>
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3da198-87d5-4826-f7e0-08deacd90e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6g8wBQViJ8o9ia8Nt5tl3sU9JWJ6594qg9W2wYLLntvRkQXxwOozIqPjvzTtcI3tc8vd1o34ddpSEiryY7dU5tsb/0MGqBRNGwHI3i2aB/F2G89H1D5K9ro6goJQHeyi6U2nfJIgjb+rSrov6HCgMOFg3QiQLFlf8O2ius+arzRi9Y1s9plFoDvm7UgBahGJt9CqMEt3anFzIeLikSctRrjDttZccNvrFTKevAqFRJ+yxKJ2H5LTYhuEwWtCtkjdj+m2fdeaBorasE35di3eMdH+XXNyvrvC9Qm8Jx7LYMdBF2YDsQ3oIrdBoOOilsKb9NVLP+T0f0UqrR4vNI8JngVEuszgUC7W3qewxF8+38GAtyzUJR2UJ6Q1uTLs+iP4pn2hgG1TsxYRI85wyzaxmp0aLh3vtN33UwzoYeRmld07A6Pcshgn2aJU0IK7uOrSPHI3AjGC52TmXZfpiG6z/2sxB5+WGsDAe/wwcgXtd0pJ6cZ33kpamj8v3PIzhxJfaZDOM4dHmZprFClmwCkT4opFOKkISGkqs5OGfAS+5iqkMl8U39CDvJC2t2ZiqhQXkwAvk3t9EFdcOuz5AAzDDw8E3QWu3F1Hw49BUwnTbgpdV8MGg1P/Svx681oIE38ljd31EOcsXzrc6Kf6PPP4nwqRgBLXztr8mjO4Lg0+CR7Oi2tf0hb0ZyL4H1E3hXZI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q05mfklfb2I80qr+FI+2D+S3A4br6AdtHlEUVRZ/l7KVGdqUw1bAMLKkNd/K?=
 =?us-ascii?Q?bXi4Oy0lajgpJromSH4yfZ4otymAJNOI77Z+nGsiJyFVT+LG3yZem39s/XOT?=
 =?us-ascii?Q?hhMqbV7HDHkc9QTtW/NIsnIsF2b4r11b8zm/48DMBqr7DYiCws6C0KwRlk1A?=
 =?us-ascii?Q?qDrANEXk2NSlRyKzAVPnl3W3N4nNllF1vKL8x0jSlPNxAAm5lTIrgHP69v1W?=
 =?us-ascii?Q?1fpRDUWRw71chsQ+7777Z/0Va+A0a9xPaDkd0LuqdhfVDG6sy4VY4USkydst?=
 =?us-ascii?Q?TbZAHoPulLmoOxh4aIpoOq03fEdicdIYyflVibNgKxXZDJC8zUgeBplaDy0F?=
 =?us-ascii?Q?uaDPc1+iJlesRQs5taaHDxJBBQl5S6C5TixfYr4ra6DESKAqD5DDKJrc/Ma/?=
 =?us-ascii?Q?Cf3mJBX/7Ie7/kO5j85SfXpn4MirWjuAG13Vb5Zcbm7csJI9WHwkGFsWVuE3?=
 =?us-ascii?Q?AwFJEHX4SP3MGiyx2/uMsg5Ko4xIDASfpleQ8nRwIEgR/Kbaj2f41W83VFsW?=
 =?us-ascii?Q?Gnkho7gwEHE9++JThcVUprGoouvgGFGG8wSlrpwUcH1FP/rOlP9nC7RjPuXu?=
 =?us-ascii?Q?e2sDvbsj/jMUuP4/MXgsCq/yt8oscVNaag/48/DvZaW7GLE4m06VHNQxF9am?=
 =?us-ascii?Q?LahgoKaboiqmxS1lzmz353SQ20cvSwXFf/hzp1SDu8Ws6PP+KIsQs3zQGNV3?=
 =?us-ascii?Q?xvZoiQISRqL8IwZb00UjW7umdAMbG6Yd40zoz7AcZ1JMZpO0I9jjoNCzr1o9?=
 =?us-ascii?Q?KS9ORGrMgz9En+NDO0IZfr8tttblmjxzBPU6aNDSRwYD+ZUOM9lumiDgbD/y?=
 =?us-ascii?Q?g/fH/asTxDP/B94W4r/54WOXRR5hA3SIVuBuu6yLzzz+PmZjkO0ND9t/Gkep?=
 =?us-ascii?Q?/mGwC4fzI04XzwBgEQH6mJAKGiVhz6rf6SxIIhziXh3nEFuXP+TyGETTJoWO?=
 =?us-ascii?Q?tU4zpvhg8yJQdJ0/jsxMJB0dKWUR37sq0fBLruJYb9vpAyj+YiluBq4JfiIW?=
 =?us-ascii?Q?9NbWBqxjbssw4lR+H+W/g/h+q9r755xMG68fD7SWagc3swTv+EOJPRLuMeQi?=
 =?us-ascii?Q?12K0kE7Ew61hhfVA09VeJ0WjE8qkETAWsgOcLmcWX5Yv6M4b0be66bZ7lioV?=
 =?us-ascii?Q?TzZO4GhY+36c1qgk4zVjdvHUOwyS6qeiPdUVk7ZE5Btd0JL7dei4vp+adhxT?=
 =?us-ascii?Q?+5JtNt+zQfKExyMc1hh2uAh7VNKMDaRyQXKxJ7pomALK501kv8jaXYBUVGAK?=
 =?us-ascii?Q?7A9b+4RiULY0vpPS8tBW+Rgi0x8zjjojWKGKPex4JcGZXkPue7EwQmSsDkIV?=
 =?us-ascii?Q?wVk3ItWYtBf1kPGS4XCc+e/dDRIF5uNMRiDj0TKnN6mZh0FT7WgVX+rUZzPE?=
 =?us-ascii?Q?BlNSnD06IFPbW1ovmeTfWIBIK3T+dfC537Q6NrAVq4r2fXOtbVOyqR7joGy5?=
 =?us-ascii?Q?tlAyGI7Mae0An0iZcWxqxLbLc6DrH3JYIpVh0mqw5uLuDFKjpUooJfe6Pg/f?=
 =?us-ascii?Q?iW5OVahgvLOsa1S3TfZ1Z+iJjuSQ9dOIZFCGxQHHkmJABnisBYFzEBkdQmg/?=
 =?us-ascii?Q?LO7xfHOqzvel2K+M/CWqjgrZzQSwckjzVWWcBDSgRp/Ys9shAmPrILhIL1e3?=
 =?us-ascii?Q?AjJhN4MwhCb7RnR4MfA/jRzZSe2ckYT0Dr7tEkf2qb2nqmfNW9REZHSwHFwl?=
 =?us-ascii?Q?WEWYEo62kdjHB/9lhyp147KiV9IvSgZjCs9GX+fhhclcGgZDeriNUrYu1hvp?=
 =?us-ascii?Q?uCnk+w2nSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3da198-87d5-4826-f7e0-08deacd90e34
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 08:08:58.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0k8K9pQ+rgRMjcPMNin7jQ6wxZ4ikYXn/H2anTDxq0xxdd/h2JlgC/L6nHnRyb/KLxB51gVESoaN+n1ybQCew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157

Hi Cheng-Yang,

On Fri, May 08, 2026 at 02:55:12PM +0800, Cheng-Yang Chou wrote:
> If run() exits early via SCX_EQ/SCX_ASSERT (which calls return
> directly), bpf_link__destroy() is never reached and the BPF
> scheduler stays loaded. All subsequent tests then fail to attach
> because SCX is not in the DISABLED state.
> 
> Move bpf_link into a context struct so cleanup() always destroys
> it, regardless of how run() exits. Also skip waitpid() for children
> where fork() returned -1, avoiding waitpid(-1,...) accidentally
> reaping an unrelated child and triggering the early return path.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

I think other selftests may need a similar change to prevent potential cascading
failures.

Thanks,
-Andrea

> ---
> I was hitting this error when testing the defer SCX bandwidth patchset,
> though I think it shouldn't hit the bug under regular testing. Tested
> this on the for-next branch and everything still looks fine.
> 
>  .../selftests/sched_ext/select_cpu_dfl.c      | 54 +++++++++++++------
>  1 file changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
> index 5b6e045e1109..7e342c0cec65 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_dfl.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
> @@ -6,6 +6,7 @@
>   */
>  #include <bpf/bpf.h>
>  #include <scx/common.h>
> +#include <stdlib.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
>  #include "select_cpu_dfl.bpf.skel.h"
> @@ -13,29 +14,44 @@
>  
>  #define NUM_CHILDREN 1028
>  
> +struct select_cpu_dfl_ctx {
> +	struct select_cpu_dfl	*skel;
> +	struct bpf_link		*link;
> +};
> +
>  static enum scx_test_status setup(void **ctx)
>  {
> -	struct select_cpu_dfl *skel;
> +	struct select_cpu_dfl_ctx *tctx;
> +
> +	tctx = malloc(sizeof(*tctx));
> +	SCX_FAIL_IF(!tctx, "Failed to allocate test context");
> +	tctx->link = NULL;
>  
> -	skel = select_cpu_dfl__open();
> -	SCX_FAIL_IF(!skel, "Failed to open");
> -	SCX_ENUM_INIT(skel);
> -	SCX_FAIL_IF(select_cpu_dfl__load(skel), "Failed to load skel");
> +	tctx->skel = select_cpu_dfl__open();
> +	if (!tctx->skel) {
> +		free(tctx);
> +		SCX_FAIL("Failed to open");
> +	}
> +	SCX_ENUM_INIT(tctx->skel);
> +	if (select_cpu_dfl__load(tctx->skel)) {
> +		select_cpu_dfl__destroy(tctx->skel);
> +		free(tctx);
> +		SCX_FAIL("Failed to load skel");
> +	}
>  
> -	*ctx = skel;
> +	*ctx = tctx;
>  
>  	return SCX_TEST_PASS;
>  }
>  
>  static enum scx_test_status run(void *ctx)
>  {
> -	struct select_cpu_dfl *skel = ctx;
> -	struct bpf_link *link;
> +	struct select_cpu_dfl_ctx *tctx = ctx;
>  	pid_t pids[NUM_CHILDREN];
> -	int i, status;
> +	int i, status, nforked = 0;
>  
> -	link = bpf_map__attach_struct_ops(skel->maps.select_cpu_dfl_ops);
> -	SCX_FAIL_IF(!link, "Failed to attach scheduler");
> +	tctx->link = bpf_map__attach_struct_ops(tctx->skel->maps.select_cpu_dfl_ops);
> +	SCX_FAIL_IF(!tctx->link, "Failed to attach scheduler");
>  
>  	for (i = 0; i < NUM_CHILDREN; i++) {
>  		pids[i] = fork();
> @@ -43,25 +59,31 @@ static enum scx_test_status run(void *ctx)
>  			sleep(1);
>  			exit(0);
>  		}
> +		if (pids[i] > 0)
> +			nforked++;
>  	}
>  
>  	for (i = 0; i < NUM_CHILDREN; i++) {
> +		if (pids[i] <= 0)
> +			continue;
>  		SCX_EQ(waitpid(pids[i], &status, 0), pids[i]);
>  		SCX_EQ(status, 0);
>  	}
>  
> -	SCX_ASSERT(!skel->bss->saw_local);
> -
> -	bpf_link__destroy(link);
> +	SCX_GT(nforked, 0);
> +	SCX_ASSERT(!tctx->skel->bss->saw_local);
>  
>  	return SCX_TEST_PASS;
>  }
>  
>  static void cleanup(void *ctx)
>  {
> -	struct select_cpu_dfl *skel = ctx;
> +	struct select_cpu_dfl_ctx *tctx = ctx;
>  
> -	select_cpu_dfl__destroy(skel);
> +	if (tctx->link)
> +		bpf_link__destroy(tctx->link);
> +	select_cpu_dfl__destroy(tctx->skel);
> +	free(tctx);
>  }
>  
>  struct scx_test select_cpu_dfl = {
> -- 
> 2.48.1
> 
