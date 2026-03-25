Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D31D3612FB
	for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481092; cv=fail; b=T/SJMXeDFifuRQv8V046wtRmlWObKh5dJ3Kb1mxJVTuu1f0ZKWHD+TJP6uArksD0rzzK32tb1G+3gcMbtu2nDiyk4zexgRWL1nmmcwedTtrVckJ5G6q22hMNAE9BHvXXJ4h3fb1LjaVxknAfUsPytKnVrbt53f9uvdwpJomKzSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481092; c=relaxed/simple;
	bh=qSYfUDbcxj7chPb0jzK7p57zIYTTDLYpvaJR0/WeueI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=so/SDfPWdFdmSgxn+70yLbZYNQcoBuwbI4Ni95YTfL8/+bocd5LonH2PXy+LLMSfpKIfkZgYhu2ustx0fHq3yRNDCidLwWKfjSxb4Isr+gOH8dWYxkeY2I1C2LPw/lnvJ2OlsKRtJZP1e+igi3zrqYvbwkV7xRX/2cl1S/p+qTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hXQbAOw9; arc=fail smtp.client-ip=52.101.52.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXQbAOw9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oomIgDL2aaWKaemHiYeckhOESHyIjnWnR0Yq622lq1iZ5kA7VySoo3Pz0MUcMaau9jXx1EXQzyh/N+vb7GBzA4ZxUP2t88Q0uAAYMX8aSaoJ2G9pxmrECmhnzlrT2tynT7CxPYj+Y7nQFlmYBULzYe+NEOEEevDEKTete23oBOAAgsJOh3qUdVPQE4j55kFzDsz9IeiEu33erVl5D4+stoYmhhNXrrvK0+aE2MtmK2yZKjxCGsQ5ZXMfObOdoQQAmGCof3dTZ3pm6sSisrR7JLM3/7tPgAkSulou24hJQgb+ZrjKd90xXpaixv8RDSk+yQ3e8sbABwHzR9xEhjxqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLg04AUQkrLGqW6vpzeRQRSvqq4tYnGK20tJ4enrcsI=;
 b=rp5S2e/u2TwCu0/RR2UbSlHpLmvwQgFykybceEAUCVH1GzsgZIIujN7sG36KtIg5NcpG63YkCZocJjWYsXHfo1jyaRwcNj/i/Pd1MUwgOnxpqCNv7hf/UteqwGqv5YaA1ZjbY9xP3e/SoTZdhd+btv9qIAJJ9BX2vLi2Eu0Gjv3N5n0oK4kwqi3eDtGvwdwgfQXcoZxeLOGFzCt0GXWh4viUOvWRPjW7lXegR2LC972ZHCXiaHoAGRS7ip/pIpGqKdRUbL25aJr4woexMF6fgH2vKZWLW83HupeiE6lmZy7d0yGAiFbYRj4rKv1pZREk6WVHIhraVD07rIWsVdlkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLg04AUQkrLGqW6vpzeRQRSvqq4tYnGK20tJ4enrcsI=;
 b=hXQbAOw9tV7keDXO6G83oYeOG5dMcmeGZF+sS3K++ufTztuJBf4Sq/eIVg6Bbunm4+tMxfsdaGt6gTIXxStTRGu684VKm/3x+XP83BxPk3LZi46kvhV12s0IUrCM67U6xqC7HnkkTMcY+nuLmmfcv6M5Rq5x6sLRb4FPW65esL0V/bEI9UWm66BoMuFfTh6mw25w024VBtbie7fh946ijnkydpLV3lhvzlfNxlm0CBUTWhiqNx97hhzsQSHZtEpqi8xaunr6ELsPNAePiQtR/yVWXNtpj/DATMvtKQZKy8iVH/tKkDgmKsjfurJLROUlY0MHxGh01M4vkWyTCAQ3OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Wed, 25 Mar
 2026 23:24:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 23:24:43 +0000
Date: Thu, 26 Mar 2026 00:24:34 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: idle: use active idle domain in WAKE_SYNC
 check
Message-ID: <acRusibUxjWj3WCW@gpd4>
References: <20260324195836.949831-1-joseph.salisbury@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324195836.949831-1-joseph.salisbury@oracle.com>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: 60855844-7226-412e-3077-08de8ac5b205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9oSOq/OxmHB15IhJW1aH89W6RtNGQW51xDmhLNRU4VqguA0YB8f0AZ8vLCl2hrxzVfFZur1Em+y1To/UF+eQ/h+F31uQMAwjodxcpHkPI+/T5m2m3J2EmeEiBZD7arWhTdhbmSYPNiZEj1Tq4bN8mhXN1xiYhPXtchkwuBUQWNmCvRBrboVRDLxfhNXnmCH6JTLz0+6gowZ9jJT380u2lauGS/w/QoeQBJ8IZue3IOgK8p42RAybZmNb5NzNuPdSqPyvkuH1t9HkU8HBqmgnjHdg4a1CahpilPi0tk0V1p3ZZb15/GrRXt53jLR85cNiGYrqqxyGrqRO+rRNAczkbRVHFqpMQr8IvzDcDpwU3UEDa090W+kFoojLvKA4wJna0PZZmFPA/cEL2txkZBf9p6fIsm0iYzmyV9avwCclWJzq6XUPHiWPrIuNWETGT6CIxepq66ULMIecS8gksgpC4/diAT0JwfxoNQNWAdOD5Gzw/yld8+DvumZnmPw1xKNazcdtigGpbhZZIXoa1V5M+nFB4gnvSYEUvJn34Y1MEQvOJVZUhgFrBIRqMlOiBbRaElbVt56SCNINoB9kFkVtDiTwnDZeTRsw+swS+jgLAl9JgFXzdy7w2b2t8xoLZlt5WcC+n+EbT+GL13/4Gjb5rSUTVWJXHOy4XQGYF0m0EigXw9nrJaP21plZWSGijbDqKthbDda744Uo+ylzvLFzIyNaJ7e/qUWaYZGWYNuOQ/xHLBAQMXy3D4d0S0wEzvlT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dHTA6CZsS3xurpDtAu+EbXoyhJju6tcYAuH9rabpaLZJtUO6L7SuBQPu8Vta?=
 =?us-ascii?Q?iToKU9TBUkYdomtiKzyjx0WakbxeMpmyYq7g8VeZHxsXPXCfAVikL88VsOsr?=
 =?us-ascii?Q?ZbEUqB4Dh4ZNlG8in/lSBZ+7prlOTPV719w3CbL9UdHj7w1JbF+zBBSam9Up?=
 =?us-ascii?Q?rZe+Lb4pEqSubEsLpTOh9HNp+rGf0NGxBmUZ/m4Xp+3gSvavfhfNMpNH32Ku?=
 =?us-ascii?Q?FZ+iBve25lDkuRtevZw1ySY3qFmKzsce4EJ6H68sy3ZU7WAgQiXbhMNYt9tz?=
 =?us-ascii?Q?Fag+UwrlA3tsgGkrrCknc7GAJZWFnEn16YsosnO3U6vER/bLmrr1UrfB8C4m?=
 =?us-ascii?Q?0Dl0gzyjdufdQR3oYwbQyo6+a8tJt0bYDdGMPO1FHCECJM+HRG0zY38ER3/t?=
 =?us-ascii?Q?17w70aSigyARSUQvIVIbwYqqUeQYSuY/LkdMAsx4/9lCZFKx6kibvrEu0i/J?=
 =?us-ascii?Q?/8fxcQGpYG27ocxBIU3KkU/lPpFBX1gDzeaVhDvwsl80oq0HeTJjrnwHZcSn?=
 =?us-ascii?Q?aO0RFzOaj5RIaEpAdqkvcEsX2hw//nsaW1Qf8y8lMtFzSB5tc/Kf44CzMBUC?=
 =?us-ascii?Q?RXdxtYIpvl4BO9VH7zUCC26cd3xKYWz7X8OxMJy9aAjfQVzgmdW456F1BiFv?=
 =?us-ascii?Q?cOSY9nppD3RKvSUbTpXNK1H9YcwkxlDl5cOckxQORgx9dbFX1AMZVdBsIxZk?=
 =?us-ascii?Q?gJ3KV4H38F4O9+BvEcIYrif5KJJ/vTASpRVGpmG3K1XVakkRP5PNSFGhq+jK?=
 =?us-ascii?Q?pSKHul9xSKgU4xFZ/3ihJb5gRiretZ8PQ+leWfJswB56eeiqVORI1S5Fo/SZ?=
 =?us-ascii?Q?LIFag7vVTGFW5Gxsaz0MfL8lYot6vqV4PKSdrT0GoXJF3ZV9m1koCgdpkK3y?=
 =?us-ascii?Q?/RRuFUNC91RmMeAcXNGaSQoOMH5d+yIgctCD7CBOPBTdRcqHLIpqychIaXz7?=
 =?us-ascii?Q?jYbzR9ASjq1/t7Yfc8uG/1Ib4hur6psIS0PsbP24AvK7/UWb9RyvyoGsd5yk?=
 =?us-ascii?Q?vLwZZU55TpL7PYkU6O7jY3vGjz43qP4H9YK93eokyOAiGTQImYuNoKz2RUlW?=
 =?us-ascii?Q?roMG5Xq0CHmad2T9Nt0yQnWaUI4Tw8h4I8G4zQZCCsJkdSahrh9u8TWPe1D+?=
 =?us-ascii?Q?U0SeynD8+7KA3mGTnJ4djP9wOouK7KJzoN1LM9rEiE/DsjuxJzRm6UZjATK8?=
 =?us-ascii?Q?rn12RsXU9Xzl5+P4hLCch82IBeOGQsZVn+gtn+ztSu8kMk2OASGZ2JZJU+up?=
 =?us-ascii?Q?oyEBxb0F92PwlcOC009ANUBBnnizWwSlWbRLIyUsqY2sWrz/ekXPSVZ4UcjF?=
 =?us-ascii?Q?RzTdjC3a57nj0JerRFWRRVlMml85fXzslbqdJai0jsq4JjQyUbD39uOGlF6y?=
 =?us-ascii?Q?c3KfT0wwENUktlNjigx2Kne+k2Zw3+m6D9N5rpEDs1MMvZTQyEwMTYU50Zq9?=
 =?us-ascii?Q?oubvQNxdH80mAN2zxrU7TSUwe6IUx7eA3tOdvtL+cP96o5iQm/RgH9uchfF3?=
 =?us-ascii?Q?T5glldjQ8nOBO7P1TW2SvHAnD0oZPxPlVSgkb/cx9JrH0VlBwq9GB2glUXGD?=
 =?us-ascii?Q?4r0kz+pBSfQ/1HTWIyZteVLpAm6Bl5nMilPX8Mkfrza77cYUbAv9PxsZFc9s?=
 =?us-ascii?Q?wQ9+Qsg1ateCLiBPhd9fUt+8Z6CxeZlN+SHgqE6TZxaN9RTYPPudss8QOyw/?=
 =?us-ascii?Q?KPUwgq+3ZpQ6YBIOJ92LfmmvjDbolJ2glWA7myXYPEX7+SEBWWr3kZivE6RF?=
 =?us-ascii?Q?MP+AdRyMcQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60855844-7226-412e-3077-08de8ac5b205
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 23:24:43.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juASllWTJcclDq0Eg0qM5oXRWrT4mdGZlPEHXvFyRGa4Rn/lF4u9P2entsxRXvG6PPB8jVKB0eTAsv7EvY0b8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70

Hi Joe,

On Tue, Mar 24, 2026 at 03:58:36PM -0400, Joseph Salisbury wrote:
> The WAKE_SYNC fast path checks whether there are idle CPUs before
> biasing wakeups to the waker CPU.  After per-node idle masks were
> introduced, this path started indexing idle_cpumask() with
> cpu_to_node().
> 
> When per-node idle tracking is disabled, per-node masks are not kept in
> sync and may be stale.  Reading them here can mis-detect system
> utilization and lead to incorrect WAKE_SYNC wakeup placement.
> 
> Use scx_cpu_node_if_enabled() for the waker node lookup so this check
> uses the global idle mask when per-node tracking is disabled and the
> per-node mask only when that mode is enabled.
> 
> Fixes: 48849271e661 ("sched_ext: idle: Per-node idle cpumasks")
> Cc: stable@vger.kernel.org # v6.15+
> Assisted-by: Codex:GPT-5
> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>

This is good, but it's already fixed:
https://lore.kernel.org/all/20260321105503.869337-1-yphbchou0911@gmail.com

You can probably use Tejun's branch to search for new issues/bugs:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git

Thanks,
-Andrea

> ---
>  kernel/sched/ext_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 8cfe0e9a7319..6b4520ed563d 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -543,7 +543,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  		 * piled up on it even if there is an idle core elsewhere on
>  		 * the system.
>  		 */
> -		waker_node = cpu_to_node(cpu);
> +		waker_node = scx_cpu_node_if_enabled(cpu);
>  		if (!(current->flags & PF_EXITING) &&
>  		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
>  		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
> -- 
> 2.47.3
