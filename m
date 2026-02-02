Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662B2C026E
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063666; cv=fail; b=IwM1df5mz+XneU56McFsV8r6miZXvBixoGV9hrA6D7K0gIUGCPx2upt7XEFLGgsy/oDBiLrPffr+wwSuIsVFZXY6XIV/VUWtynTeAvKZ2nP0S3NvvcVAUduBlRAR3rmoY2O/H48lMSkcKZyfoKmMQonj+LzWKvBMpQ7aKIR+vP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063666; c=relaxed/simple;
	bh=eF+rbWj8MwjEpZVf1heTsF2Zk17BsacDZrbFNuIb5VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B2P7y1AwcpmMefbYWYSaI+mywCPIsviopsEzGbO83+SvPJumesLb5EcnsxYGJkSIsI7tBd0SLhf+JeHv2oammG+1BKguQwoaXxTCpey7PmR+/cYBxr/Nbbmta/wvUiV3e3rQUH5kAw2cAuznW+BFYCmO9GWC+tvAcl/DWCq3WLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r8QA3oL9; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8QA3oL9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s48BZ2yFYmeVjua4cRljMr2COA1TkaNc7yEHEV9UWYWWdtVV9GEFgW8uXAdZ8dwsVNwZK2Gp4XAE/zzley1/25+BKstvymcpIvOeLaiEMjuonbKkn9ZOgArtH52eKX4O+7bB2Ib+BK6j8k23lBN5rjfzVCHKmBFRggqKrOSLtB/bJx7M+uDwM2yTaB7mKnn+FNR2ezqqE03vtMYKQN6wUk8LdPbB7Yy4+XYlXcWhPxpPsEC9TEIjjQUpa/nOvp/LR5SkMLSTNndl9vL+itwbTONAVgd0mZ72G6VebOLk1h4WELUfydE9HdMHBvglDiqSBmhJJV6emk+6OQKWFA5zzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWcRitGH9u6MwrGGE7RWpSxEIC4r0xBBtPbmSN39Ads=;
 b=QWdhPRy2CszNcPJOU793SdjkhmCWdfxQ4FwQZv+Y7kUMwBouSrxlKST3OZLE2XwR+NchGxlXAOaiD1EXZZWNAADv/17g8E7QAo/Mi3xGWHWBxDD9/P2mpZxYoJf+I+fGCuEfCCiitmu+DTq7fLO/3414O/D+blQ2Wu9MW6vdEr/NSxsIbtHs5oLH9YG/x6FCFGClPh9Y6vrtXluuI+osOobYgrUg79nvlfBuGavTdPoGwgPg9XUyYOZM34p++SzBv3Rm7w+6VGtpTwjCXzXpP+7u4RmZHSV729CtnPcWCmzSVjF1K/Rr8p/YohiqIuMTawTn5FZXGYP6ydgK0tX7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWcRitGH9u6MwrGGE7RWpSxEIC4r0xBBtPbmSN39Ads=;
 b=r8QA3oL9u2BoIUBF3lvpb0F/iegZnYUNNuOeI/UEYghONILg6R552gM4V5PpEx4Fiv2zuNDw1M0JBAfwqsOTDmLmXp/j0t23Vx/wHq4SOhLyprAoersZMYL3kmnM8JOAPsBD6v93Juz0UoCE5sjW4OQYrAxBmct1Wak9zejlWJoVKY2EEwwFbrknFrJ7f8ZuJoEnbVeEpuoXLZsnU7JMKvzI/TfiiQRRqo9DFP4/NJWVw7EI13l+3G2ZZH6PwEuFlJKyxs9XapdxZ0Cxknd5t+W8A5jIXSL3JzimO72zdZfPvEVhWgcR31Z8RtdPq5qAEOVVeWH5//fCsLSUuFaLlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 20:21:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 20:21:01 +0000
Date: Mon, 2 Feb 2026 21:20:57 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.20] selftests/sched_ext: Fix
 init_enable_count flakiness
Message-ID: <aYEHKTYHBVuQflNu@gpd4>
References: <03982d7b5642c0ad003668178f9e5df7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03982d7b5642c0ad003668178f9e5df7@kernel.org>
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: 399c3dc1-451c-496b-5458-08de629894f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s0PvmhYDZYJDNWSDnPWWD5fARstfy/2o6KNq1oG0HcR9OV+8p6wFqUbYLsa4?=
 =?us-ascii?Q?Ei+5ZkgF8YeMJHfDqIdq3PVLKU2mLJKMD72/dK2k9vKQbFCSvKkvNqBjUhBt?=
 =?us-ascii?Q?CI+oStKJN8E0QwXA51GMs4JnNYWB6kLPzf9QQuRFqdkbeJTGDmI+tQIaX9hA?=
 =?us-ascii?Q?nKUEfzDoE0woAE6+kYpbRwEOWdB5SXe3d0UIvplaDb8GWyKKy4gZk7Fe3Tk9?=
 =?us-ascii?Q?UJjEa9J5ppLdSvaXPtL660LG5VmtY5W++6+hX3+nkUEd0MTYly75wWx5YUBg?=
 =?us-ascii?Q?eio7lqeEjKiYF19ZdWdY+zd6YxhzQwDaS15qCsHzYoJ3iMB+8d8Bxneh9qnr?=
 =?us-ascii?Q?8Jz7PGzenngnkQkSrUiCtxqwvHg6PvWaQNTChdPazH0SH9muCIj8Nuqqudel?=
 =?us-ascii?Q?6bfjYzZDrrLLGo4FXe6Xo4U91kh0IRFT7TVRcEgsv2I3mYuTWtUTJJo54Fg/?=
 =?us-ascii?Q?UY6bcbi7VuIVGHveraxzLOCuGbDC4x5xMB1bt7UKxn+07KtUqUptAaC6o5Yo?=
 =?us-ascii?Q?WB2PNHwWD/e0TS2eeEaKFBKMflXC7GdgPd/T/93zm5a7wyaWlo8MZYDajb8p?=
 =?us-ascii?Q?jw8Kg2yKcuhNK+KZ0uknpU6NO0gUX5/YFn5Dt3N0zto/X51N9vybrR0fcPf7?=
 =?us-ascii?Q?Ssmacw3ox1tsP+XrLAHkdV1L2WTCheuFFoBTnqobJdLQPLnSRLnCg/+DBzv7?=
 =?us-ascii?Q?sWwILawSGCM+hwM3VaqFxKPMNFG3KmBehjbTKYfJ4CziOgRb4JvgOi8UxDX5?=
 =?us-ascii?Q?6bsvrXOjDhCn5dIal6L74uCf7bDkCWvR3F65hRg+NzmVQLmxQT6uLvMx+UX9?=
 =?us-ascii?Q?rttM13kO56+YeUCcbrlDGi22oqlvp5uQMoGeUPGtG5hXcXiEq+f8qD4NcHZ8?=
 =?us-ascii?Q?7ocnULtE5U/DCXc3hD/QNrqAXByWrGhUTtPfNzdmGZGPR1aqU3z2d/5TgpPR?=
 =?us-ascii?Q?n5+7mpGfhLC81SDNlBNbT0L0SL+XaOT0GvtkdUSaqcQ2w3wVxNKOT5wawTD5?=
 =?us-ascii?Q?Qm/Lqbr352WRDmNcxIRvWsOoS5PMwfFVP44LGVii89EAXcw1To5fDerGJ01T?=
 =?us-ascii?Q?Ipin5FsRqZ9fUhrBLXda14JP6cy+XyTtx8ywKWl9vQT+QJ60R361DjQO9w7U?=
 =?us-ascii?Q?MGJcBy/ZZt6NwNK2JjaH1ceAhOAq5yRnTs5fvYueW20f7tit9qHQRa6xkTgi?=
 =?us-ascii?Q?UlCvzOuwHRSfZm6f1qgXBbHu16/gta9Q54TIrMh6dCdseZwBeHdEAm2XMArK?=
 =?us-ascii?Q?ezlGYAHeBE0c2oYfuTjtnTbUhelTP00h6nNvkLYrOqLsFFrBiNy+xXauVoMa?=
 =?us-ascii?Q?yweT3dZAptRC94wxwlX9MaCnSSaXRpupb1TTv59vRQ6aAyWZV1CkhLmf+jKi?=
 =?us-ascii?Q?7gCXu5DBkShyl8tTWbsQwtH4gHBre4Dk7xzUXJzbxXotS1zD5oP7sj5Yt7bt?=
 =?us-ascii?Q?sScZUuk/Ey9jO/iBwHoOezUWrfLItBOlG08KjrB7rUrREoPUK3oqd4J9U3X+?=
 =?us-ascii?Q?bY14xACN1tzKu5k1CdZ+/IaXpm6RJzjYxKCu3QQq7xEqLWe9BbhdE8W4ztfW?=
 =?us-ascii?Q?71C3sklzNXC2HeE48+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EIfDFubtcHBrZD6pG6N330m8cJRKEEhM5wRmrmBF86lLNDjnM8X0xmFNudU4?=
 =?us-ascii?Q?nsV8Reh9MexS1BuMAPdEFGOjUZIlovhkna3hg0xgujSE0BPJTQ01qYVi0MfC?=
 =?us-ascii?Q?DEyODtpra7L929Ed9Js7YuZMfoj1nGdamUeyDMwGQurYGsN7F0+BXMAoSDbU?=
 =?us-ascii?Q?xaDugN3Dz3kC8Iw6DRuRvSWSsA5fxrC6ZtPuyEzc09LZxF8+q02BBZaSWdrT?=
 =?us-ascii?Q?bh9sQkfvMGJZU/aKfAkkY2r98R/o5X43yPSBS3717n7uLtXXOCm4sqWSLWKS?=
 =?us-ascii?Q?Kl0r15btmO6UFs5fgSDbjMBMK2mFbJ0qJ5NvsKze779Wk2UejWWtsozXJYwG?=
 =?us-ascii?Q?gO41xYlxvUDrdDmd8MxnpYH/RsHOQeCrQumHAyN5uXN1lMSK9SdOywnq2Don?=
 =?us-ascii?Q?N0NRB3wk2dZgiPnRnG3+o3K8M42XXvlGNLEEeje0adlPPsZrlXyG2pXwZHlw?=
 =?us-ascii?Q?c00eGO+A/H1YuooJXgFaONjf1Tct6aOy2Yq5dHO292fQEO1g8ms/tkD4Aogo?=
 =?us-ascii?Q?3Y1MaDYRhTJDvbL8uVqkSApugY8ATENfZPVsnc4UVgzS490KXvVlBUd2uz96?=
 =?us-ascii?Q?YxpQa5pb3Vt1EpRoSphzHQ+CTK4MGeM6i/NxrVbJaOKDc8WvzpGOPUw4tPoe?=
 =?us-ascii?Q?Ztt7rr25Y8QbP0LMd/CwJhzVSkiR5qs997BeiODWz5QnEIzlfm3SQEUDJFJC?=
 =?us-ascii?Q?MRhKh3E6SnX19LqfjQAWbC7pHJM6x96echEp0XmhGUtAWnperWG/BMh60Srh?=
 =?us-ascii?Q?7bFbYs0cZtL6gcrM52AY6H6+hOElessf2L00ie+3X9zH0xOEOFaMz0/YkeNq?=
 =?us-ascii?Q?+Mw2B7FWMHpf/Bnbvrqw1PSVuT2vyhHCnrwgDj1Hl17v83B9TQms4ZbtMl1s?=
 =?us-ascii?Q?E2MrpK/nEIp3+bhL79t01XsKAeKZB8ToXxHoWE0EDLeMGZgdzuXKZnmx+sHA?=
 =?us-ascii?Q?nUAE/DvgwNlNzSM3iS0QI+d554C/RtfNtUEmSpX3BAcwz2J9JfUi8FTKFeYx?=
 =?us-ascii?Q?8h3OI3NljUdZ+njChI6UjQpCQLLcBRWSSTS7Lqtxh4JZEEvmhMbOf4gQHXyD?=
 =?us-ascii?Q?bqiTYKdzngQ0weMdRhHUMez8Eb5aloD/kUdFTIMBN/xV0eK+ZREtoxB4e2n2?=
 =?us-ascii?Q?eFE8Kkwc3QhU39yyfrwj+OY/NUwLP54YC+qQQjt7/CkqQiQHNIHHhAGPzOw9?=
 =?us-ascii?Q?gXHe1o0MXHyarx/aMj7IMkOk1BgorKiY4LoTVpVjn8I1QnJCaT/CkmtQpUsz?=
 =?us-ascii?Q?9hXsIG41GrIH/hT91JeiqveYiwrcYI0jnpYsqQnh2gUQl0d9AS3zigkszyP3?=
 =?us-ascii?Q?oE7UREs7istx1wKasypUZVjY/w0xyf1FKjjp5xcQWXWg/+qQAhaw2zJ/C5WD?=
 =?us-ascii?Q?fCkItc6TxDWRWG/MuNvWfiEVIwr3sS38DvwmyZEwVVWvFJ+mmW+oAvV5K2u4?=
 =?us-ascii?Q?r1X3PRMv34i/XANjuOVcjuJ1BHi3gb/E+3eB8bEHvP9NtBoe3arD8oHVjyzq?=
 =?us-ascii?Q?c1X/Bv6n2U7rEovPRvj4MJUMIKrK0pAqj1W88UbCBcAUEr5HTkdIAaw8j6s9?=
 =?us-ascii?Q?XCxR5eIQl4b7zAiCOuGG1M2CfeOBgJTI0Kve2NoZitaH0LXSi2eSC8RQmCCt?=
 =?us-ascii?Q?agBN9k5e/pK9MjZeu/XxTvcAnXec3C814A338hjLmFt+a36naV1CWoAw3Mhb?=
 =?us-ascii?Q?8m4rlk+nicIR7LPJhBOYlxM/LtXDf9lIDHzJUhHWRlotvlp1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399c3dc1-451c-496b-5458-08de629894f5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 20:21:00.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a91ZMwEIBxhuVSma+y+0/blV3E+nzRpOj98DmBEEYfnPjeqO0+O8cYwA2EVDjyq+ZYQ7uFv0KRWrWVzMcpmgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048

On Mon, Feb 02, 2026 at 09:40:22AM -1000, Tejun Heo wrote:
> The init_enable_count test is flaky. The test forks 1024 children before
> attaching the scheduler to verify that existing tasks get ops.init_task()
> called. The children were using sleep(1) before exiting.
> 
> 7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free()
> to finish_task_switch()") changed when tasks are removed from scx_tasks -
> previously when the task_struct was freed, now immediately in
> finish_task_switch() when the task dies.
> 
> Before the commit, pre-forked children would linger on scx_tasks until freed
> regardless of when they exited, so the scheduler would always see them during
> iteration. The sleep(1) was unnecessary. After the commit, children are
> removed as soon as they die. The sleep(1) masks the problem in most cases but
> the test becomes flaky depending on timing.
> 
> Fix by synchronizing properly using a pipe. All children block on read() and
> the parent signals them to exit by closing the write end after attaching the
> scheduler. The children are auto-reaped so there's no need to wait on them.
> 
> Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: David Vernet <void@manifault.com>
> Cc: Andrea Righi <arighi@nvidia.com>
> Cc: Changwoo Min <changwoo@igalia.com>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

LGTM.

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> ---
>  tools/testing/selftests/sched_ext/init_enable_count.c |   34 ++++++++++++------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> --- a/tools/testing/selftests/sched_ext/init_enable_count.c
> +++ b/tools/testing/selftests/sched_ext/init_enable_count.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2023 David Vernet <dvernet@meta.com>
>   * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
>   */
> +#include <signal.h>
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <sched.h>
> @@ -23,6 +24,9 @@ static enum scx_test_status run_test(boo
>  	int ret, i, status;
>  	struct sched_param param = {};
>  	pid_t pids[num_pre_forks];
> +	int pipe_fds[2];
> +
> +	SCX_FAIL_IF(pipe(pipe_fds) < 0, "Failed to create pipe");
> 
>  	skel = init_enable_count__open();
>  	SCX_FAIL_IF(!skel, "Failed to open");
> @@ -38,26 +42,34 @@ static enum scx_test_status run_test(boo
>  	 * ensure (at least in practical terms) that there are more tasks that
>  	 * transition from SCHED_OTHER -> SCHED_EXT than there are tasks that
>  	 * take the fork() path either below or in other processes.
> +	 *
> +	 * All children will block on read() on the pipe until the parent closes
> +	 * the write end after attaching the scheduler, which signals all of
> +	 * them to exit simultaneously. Auto-reap so we don't have to wait on
> +	 * them.
>  	 */
> +	signal(SIGCHLD, SIG_IGN);
>  	for (i = 0; i < num_pre_forks; i++) {
> -		pids[i] = fork();
> -		SCX_FAIL_IF(pids[i] < 0, "Failed to fork child");
> -		if (pids[i] == 0) {
> -			sleep(1);
> +		pid_t pid = fork();
> +
> +		SCX_FAIL_IF(pid < 0, "Failed to fork child");
> +		if (pid == 0) {
> +			char buf;
> +
> +			close(pipe_fds[1]);
> +			read(pipe_fds[0], &buf, 1);
> +			close(pipe_fds[0]);
>  			exit(0);
>  		}
>  	}
> +	close(pipe_fds[0]);
> 
>  	link = bpf_map__attach_struct_ops(skel->maps.init_enable_count_ops);
>  	SCX_FAIL_IF(!link, "Failed to attach struct_ops");
> 
> -	for (i = 0; i < num_pre_forks; i++) {
> -		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
> -			    "Failed to wait for pre-forked child\n");
> -
> -		SCX_FAIL_IF(status != 0, "Pre-forked child %d exited with status %d\n", i,
> -			    status);
> -	}
> +	/* Signal all pre-forked children to exit. */
> +	close(pipe_fds[1]);
> +	signal(SIGCHLD, SIG_DFL);
> 
>  	bpf_link__destroy(link);
>  	SCX_GE(skel->bss->init_task_cnt, num_pre_forks);
