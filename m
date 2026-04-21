Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68B37DE97
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754039; cv=fail; b=JSjlgIilARlCvFOYnW533oXwSG5Y/R1J8OjJxbVfJSHY6OqcBtTh3Z1YptBFoCOuH4635zSfxqeENI74BBmod6nES3/z0LzbdeodPsCV8EaDf8POI5JAeP8RFw1BxBDpy5XqlUnc/ECWGvPnQ7hTMV5mhP6w0eLiaQPYpHWFFdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754039; c=relaxed/simple;
	bh=LdA3hGUx96K+/32/gRlxJYIJKmw4hyFw2EBTjrp2QVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hyw8Mf0GcN4ayo229opp0Qqe9A6zhsvALbCEOGCQ59sEis/mwhmIJb/fo1O7Jok4XunvMGrEFf6YgfKPCfVFP2xu7vD4rcERqWNbX9cHQqBSUgvEbKT5m2zLQpIAPIT2iZBvSH9af4cmSlurnSzlpRCAZO3KUJZK91FgPdUJVtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fBm998Xm; arc=fail smtp.client-ip=52.101.193.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fBm998Xm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrECCoi0ZEN0pQLx+k0J8JsH3zDcUx999QAlxqa5CxqKpCt2hGtQTXw2t7Vnwvsuj2q/DsQ53bIxvWAkIQ6xRgQDv5NHTG11aPZYMBvCJLuNalyfsB2PljVtc7YJbTK2o2M5x8zo/WRwrq2csjMy1TeUO5iakPzWlZhiltext/vwTz9zDeBqz0kbVV0YYjtw39snl8P/ZSOOO4JF11E73LPVA63oxjN+kO0Q64uFyqDscSGqYcCge5zaRVYn6imgqrfVnETQIf6aEQLWDNOy/Ej8EgWs+4cbiq/K62jb10bTELbXuaJX3syKDNQL7XbJEmmdXaQwXzlUCtugD6DSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VTxs2SDZJuEFahnC3p+qdWPm8H12bv98MZ3bCZqy+I=;
 b=LqC7ZV2rpn7HuyJEvwrCZlJF3x24PjY2GxAICSq+Tp25yn6mfot44IL57UV7vlL7bOsIBhHXoxQB2bDEhk26og+hBwBIybTOHR+0ThCjdeMBu/h/TcvepxYwatN6VaRNfwdlYlbRF5RWTwABO1wKOjS1E2cy5yACXB/guLIZJdR9ox7IfL/Zv8L/hGTCDccgwNCifIKa9/di1GYjkDdO4Ln7XdSjIyA55Z3fPXIKg4Ba+1dnJ7kfeXaRNKx7m61vrdi7F3+qQESQ6fh61BBtxe+6Na7fI098s2JFhb3tIZx9xydFTi/wsH8B8uoNsalsULiYmNidRX9NNTgo1ASixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VTxs2SDZJuEFahnC3p+qdWPm8H12bv98MZ3bCZqy+I=;
 b=fBm998XmUMu15GMB9HJSJuk4cUt/kG7YiiuGlRtv7uICYgXHd3TN6ni1ATSBMZgta2ys5IFekTVDrUGIaHcOXDiIkiHGotlNNBOByovMQR8zTlCCJxdxKhbfi9Vt+sCUhQgpdXLMlHg9lDYkQJt0MpTz69S5ur6LeyqN0qrrYmCNdnBXuit0Toxg4qNzUn2CuszDlETQ1nMBU2AoKpsbeDtYGkceyqd7H1cvpI3LLOSKsKdfoaOYwTYVTbUJh6mpEnNrdFWotBvASLzSmEWaagyMIsznytbJ6tlitfMlar+QSuTe4ElfihKD/wyOlBA+2IirgcTPZuLBclTAXaQzXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 06:47:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:47:14 +0000
Date: Tue, 21 Apr 2026 08:47:03 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] tools/sched_ext: scx_qmap:
 Silence task_ctx lookup miss
Message-ID: <aecdZ0k0c02i4t3w@gpd4>
References: <59bc5171ee5aa02746c2f576d0f1e14f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59bc5171ee5aa02746c2f576d0f1e14f@kernel.org>
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfd9d3b-8955-46af-6474-08de9f71d1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4yWweiPZg4VUak93yK1WLLLxxrmtMjGHPATZe5+M8qphTbKEBLAyGJNqSogrIaXVTiJ1btN22Q0HZWUGf0MrS3BHru15wyVhhIo+mIsBgeY/QIl+GaLoEWEHzC7hQvsYppC12v+3XeJx7hpE33H6hAZyCNjg4T74dvtO+gBeaeKCA33eYFic3mOJGJGmPHNvZA5j1ZdHjYtROvKtCL557WxlzUuiw5w1EyrccumGQWtSUdgg3vRwleSjYiCybR4Wx/LDP/LVeZlXrx39PvZxKmWMW460aw2hZ8e1iM4VD5UzNihiXcwQAejiUboibJfq2xA8knWcHSALUv+pjpn8LTlj9PBYCqSymrZvrLCwZGA4Q769RH7dyWkGlOnd0+C8oOysFovtZd7Im2T0wVfmXBv5YVIt24MXgrd/OQxTvmHCW54x3fjyoSOzf6Anz3jZnoAjjDmT6/IWjT9UAEVugGEXCY44YIpjYC93pz0IAOTddsXKb3u4arje69eqePJLhOdSu68RD2bcJVCqE1y84Ag0/YL0zkws98FR+AI+z+269w0ge4oXBnOtJtm9xnhRz3I71xV4hAumWCFJHJWI6naRJNyZOxnsRFHEiaYicthRhZa8ylwO+W3U8Sg21M6d+7GX6/uDSCxSs2hi+yU+rhyJ5wI6b+Ii08s4J3B91HD2SIpGuKx1UUWPjvnmKFPs6KZqNWsA/ccR+w2322cTve6Y/H1fvPFHlm4owOltiSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHULBmrTOHR4ALpID6Bgia11uzksntaodBQALVRetVbYxz4UFzjEcJW1rSym?=
 =?us-ascii?Q?mPNFVK3ws0v/bNTGPBFH9LPrsjcHG5vMZzCsipRJTPzcWUMaPGuuO+7aqFvo?=
 =?us-ascii?Q?8ag6JU1dUkGcy81j7zUR/+wX8QJrmMc34Lxi58g/GFPqd49N+b03xu5wWyst?=
 =?us-ascii?Q?esnTV53U0pGTrXjt0hdUvJnyKKuJedn2QSEKGApMmnzUvF+i+0nssyOBC1cc?=
 =?us-ascii?Q?lZzTfOCzQ2+5koQaysbVTZW4a58ePxkjkiPGDdYhi33e0TKCJCQQvcpiZz+x?=
 =?us-ascii?Q?+1woxTJbEqIS5h7cYNYWtudNXJCZ3TeQc7lulWw3L0siNeJQnrOnswaXlhkU?=
 =?us-ascii?Q?ozir5Q+YcLE24tLAq/UMBMU44peK2bCu3m74hauKNCA2aSwoSeXYFnPqJzmf?=
 =?us-ascii?Q?oFs1lEv2W8wDqdzKw9ScPqV2Q1iYfJ7dgWlu54Ezxv6sehmz+wzRT5w9/nQc?=
 =?us-ascii?Q?rwYVUq7PZaE7RPNYnQpfcyrvo0O/WQfFWYawO8pH9YHpi1C02FZTruC3bXG8?=
 =?us-ascii?Q?iW8kKuSXNfC4q18QV7XSEWrm+eCFqNE8hKVOYDM82PJXFVlNXrcq6h2iiYy2?=
 =?us-ascii?Q?omppUmAZul99bgzMMR1qzmX+hddEjTwerO167jfUcxflsZsCqIWqpEHPkQkg?=
 =?us-ascii?Q?gx+wgRs7R2h+Pi2KX0JLOqx9g1zDGGROsSMbY+K5T7W5rjGcAVxLDkk6ARwW?=
 =?us-ascii?Q?u1iYhP5IPcOdREPESAzU6nhZWq+1C8bTFNgikKmrlt6nAP7inRweCm5IOWVZ?=
 =?us-ascii?Q?ig/O7x0z3cLuJpKrpACVnyFTQHC037QA/9O+kWPuSO+jQ5FQiJlCjYXgbDWe?=
 =?us-ascii?Q?ThcH2m3OoqBOL6UxInqiJfr0r67vHu2NrB21FFgxUiWtuuyHYgIO3zUE0Snf?=
 =?us-ascii?Q?bWaGcVmzpg5kqLX3Ajpkrlaf7PJmZjpg/CavuS0EL8sIZq9dsliLVexgahab?=
 =?us-ascii?Q?Q81SbH3vfOe2w2X9tg6DT6GE+TYowX/szKT8yXzwbTXLx56s3KbYTjQbFNrI?=
 =?us-ascii?Q?zE+EKAeWxcvgKx5n4C12reVf4yWZck7V7VD98AKCeh8rce46ql+pGV4kfkQH?=
 =?us-ascii?Q?tr6vcPbMwUA9B+QIcgczC3p5ZmSTQbCQwW5KPFjlY7c2FZm0tjwEYh9Az98g?=
 =?us-ascii?Q?iyIwO9LtiIsVA6SA8qKrLnEpgKGBqtZ7qr6/aWN3kZEkl3MzKo4tLD8RHVvs?=
 =?us-ascii?Q?UGRfiORSGJ6wkB4U6WfQcxjt3lRSVzKqL1w58aaIMqOx74b2J+9E+TYjoPq7?=
 =?us-ascii?Q?stcfYDA4jhxIvYdIqW/Qd9b/ojlBmiifjomtcIlvrZUXqhgqy2vqS1TGwCGj?=
 =?us-ascii?Q?JYNHv6p4/RhI/xQrrlh9TgHzO86L5QM3HsaUsincfLbjCKFNzAz8OBTpjGRc?=
 =?us-ascii?Q?X6pZ5fe9rXV6MvqEoqC5Xi/LUODpZy0WXzaVww0hBPujv+QATAOcks3Z+yF+?=
 =?us-ascii?Q?tAbkW1PROyDO2OgkrLqeeqkPq+YMMisPKEwt4synjVliAVIyZI3/q8B4rzy5?=
 =?us-ascii?Q?zIiG3zKxqzqCw0XHy2N9JT+puRz2umXbBdjVq1B57UaBjDH7x/QrsHvQO7PV?=
 =?us-ascii?Q?GMYSllBucrMIKp5wHa/tPYHtDvzlTOrXPBo4eDJDO9lBwmg82p4Fr8ylmX7j?=
 =?us-ascii?Q?lTBIZC32bmB11O+talBfw18ZQ+rKrcmvrAIpLgMCw6hY6UB0ssaHfYT4AqTo?=
 =?us-ascii?Q?JZRbcD9uHFKoaqIqYhR++OVnpohnIZ9Ia1e0VYkuZpuMvZQSg1kWVMaPZDRd?=
 =?us-ascii?Q?gEEt/3t4Wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfd9d3b-8955-46af-6474-08de9f71d1f0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:47:14.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJMlamrPCXpharrncH5i5UEj/tQdU9ua8IcNV+KCx2Ls4ms3O5fxW0nsXtbHNwcQGfgZ52cD51NQcb/Nlf26pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591

Hi Tejun,

On Mon, Apr 20, 2026 at 08:13:09PM -1000, Tejun Heo wrote:
> scx_fork() dispatches ops.init_task to exactly one scheduler - the one
> owning the forking task's cgroup. A task forked inside a sub-scheduler's
> cgroup is init'd into the sub only; the root scheduler has no task_ctx
> entry for it. When that task later appears as @prev in the root's
> qmap_dispatch() (or flows through core-sched comparison via task_qdist),
> the bpf_task_storage_get() legitimately misses.
> 
> qmap treated those misses as fatal via scx_bpf_error("task_ctx lookup
> failed") and aborted the scheduler as soon as the first cross-sched
> task hit the root. Drop the error in the three sites where the miss is
> legitimate: lookup_task_ctx() (helper; callers already check for NULL),
> qmap_dispatch()'s @prev branch (bookkeeping-only), and task_qdist()
> (returns 0 which makes the comparison a no-op). The existing scx_error
> was a paranoid guard from the pre-sub-sched world where every task was
> owned by the one and only scheduler.
> 
> Fixes: 4f8b122848db ("sched_ext: Add basic building blocks for nested sub-scheduler dispatching")
> Signed-off-by: Tejun Heo <tj@kernel.org>

Should we return prev_cpu in qmap_select_cpu() instead of -ESRCH when
lookup_task_ctx() returns NULL? Otherwise the scheduler would error.

Apart than that looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_qmap.bpf.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index b68abb9e760b..0330ba15210d 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -159,13 +159,7 @@ static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
> 
>  static struct task_ctx *lookup_task_ctx(struct task_struct *p)
>  {
> -	struct task_ctx *tctx;
> -
> -	if (!(tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0))) {
> -		scx_bpf_error("task_ctx lookup failed");
> -		return NULL;
> -	}
> -	return tctx;
> +	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
>  }
> 
>  s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
> @@ -540,13 +534,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
>  	 */
>  	if (prev) {
>  		tctx = bpf_task_storage_get(&task_ctx_stor, prev, 0, 0);
> -		if (!tctx) {
> -			scx_bpf_error("task_ctx lookup failed");
> -			return;
> -		}
> -
> -		tctx->core_sched_seq =
> -			core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
> +		if (tctx)
> +			tctx->core_sched_seq =
> +				core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
>  	}
>  }
> 
> @@ -584,10 +574,8 @@ static s64 task_qdist(struct task_struct *p)
>  	s64 qdist;
> 
>  	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> -	if (!tctx) {
> -		scx_bpf_error("task_ctx lookup failed");
> +	if (!tctx)
>  		return 0;
> -	}
> 
>  	qdist = tctx->core_sched_seq - core_sched_head_seqs[idx];
> 
> --
> 2.53.0
