Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8C214204
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 05:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662622; cv=fail; b=YecA0jTbr4Zkw6cqGyr5OsOwj780J2Sfgce+UQLUBKyETCjS2q8ptiztocrf8LSFKoxoDgO9/H7tTQhiPQxvyFsT4ZmaiG/X2JIXnlXiUxjZ0WwDw/JBUCUNWLs6KpMdvQ2dO0zZbOhY8WKMh3fVGhdndxdFNQ+tbc6JtM7Zt20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662622; c=relaxed/simple;
	bh=ljhqbwNZ3vKNMt7cqGBaK8H1l98zm2QOedreAycpOd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mW0FbY6ICiRNu7p7tVw3QWnlcdByQbQV4jdDUB2/A0t35RyX1y0fDAXAw+BPNrcSHiZrvDUJoSA+XCKEgpOxfcEAadPkf3vuJ6moqFibCKAXL+5POtUWcIBw/YX/vbXvyY6p2expAh6KlOv18QDzmvBwgcW96Cb3Ifc4r2LIibA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YzWxudKA; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YzWxudKA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGskieTc3WJq42m1DaJW6X33MLbzyAU02AEkxxyEFMyYNk9idaXwiTu2jIB7P3HYj1X0huEDpE9mCvOTo7XCX6jmW5ND83Sfbia16JFI0kRpIe1QcHURO7OTO32tXoKogSndtwlX2yl72bf1yxia9w2HrlbguDIvieKiHKVv1Dw+qRJ14T13Vw8sj5qrzF1SyeRyNA4yfSqGEkaqahbDxr/9KHEsC8oGZvdFTqa+yKfVS4ZIwXsVKe0ViCrE8Vxamr8PXho2DojqCdTQZ97D/9+xmP07tz/zLi688ENDaOAWdq1lVF9QTA3RV0EhDDFH1VJ10V9HjCuBJEz2qtyYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4HYTj/lOtF8QQQ0vz0pXycsWqLj1wnwRbdCp+OrUVg=;
 b=KIhoro/krRe8ik3mtQyuNcLhqWp0/pJaDwK+9382cNRWT/r4J9kQNNQ2J3ciSZ5vOwcSKgL5W+1BQWpKzdOmqsi1sNwZzX82CLaVSOKFpSTtGM1+iX33OJnAwiLJlUB8jHpW6bok2urTGfQluvImIDXY9DElr6zc4UBrTEZpuod7z+qt/t8MZdrvUbmaAxgyKeq8CPrTV4y0EndzmM18c+z5Is4rnIWaOPp+xg6HrEWbKIhzZz00Y4slFxDa1u9MSTvwr4Xyy57lHDg+GI53269isJdbQuZ6516ruSBYjq46VEl7dhlck+kfSH5k9vd/67WqsghYYud7S6+c2AP/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4HYTj/lOtF8QQQ0vz0pXycsWqLj1wnwRbdCp+OrUVg=;
 b=YzWxudKAtnFhyfc1i8GT9275bNAceGwWTZD8L17hQQ2i85p0wOG7KoyW6TH6aEqOu9kVp407f8DKEs2g2iEiDkqpDZlvnIvKh31ExQojIzdgyZ13KSDWXoLn0MsL2Kul45uk6Bn2AgcWtPEyZW/kRJo1GcBOYI3qWt3NOV6Oz2GpStfQlyTMbh7o8pN6TMPhQ7N9bFgaARmoicaTGbuycfI0cg3OvpQfJg5drq4J+1F26lI9qwLf46sw6cRDXvkAyOPSMJAi9CMNipSgOR2evxBuONePO0t2EbQlzb/O/xA/Es2LBsNRSA7aXjVbRjfnWAPDdIpx7fRru7v7XJ7CVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 05:23:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 05:23:34 +0000
Date: Mon, 20 Apr 2026 07:23:30 +0200
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH v2] sched_ext: Honor SCX_OPS_ALWAYS_ENQ_IMMED on
 framework-internal goto-local paths
Message-ID: <aeW4UlU5Zi-XSd42@gpd4>
References: <20260420035646.1715762-1-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260420035646.1715762-1-suzhidao@xiaomi.com>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae54975-65ff-4a63-5b49-08de9e9cf7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CG+K4vovdlZ05HtfAcbRmG5oBvT1YyvKVuv/C9+pBPwltFqEI7catKWjYSIXNbPwwQVIkvAh6toDSUkG5pryaD3ADwSiLAdaGGAjRqb9ohOErrFQ95QERwvo4ZTMSOOMu+8aRSp8lNg1pyH/BbdB6aROx9lE/vD8W+N3042dVcw0trAbXZi7//pUixRLW2VHUjr4xFQH4gWnr0h4AGwzFNpsqJHe9vVDYJ52Xsgr4SunpiMiJZkv8hLKs5gzSEgqxD5j3jSgE18+FiukUUTLgIaje/CWZvzjqxjPEbL/kbL+0Ds67LX0ln6Bb4s0oAmEpC4/VDEGNf879pX1U6my2fsGNbfJ+W2vn40GNBJAHAZo30nDJY+ECLShxGGEwInqpdlLvCu3p76pisuV2D8Qwi6u77ScDRytNOkkkzwEpPvBhgRynZJypa1lgkkUY0Hkfcvh5Dulw3coJRAfl6hvIT9WCgSGcqG3I/zuwhLB5tk3jqmNX3SZZY4ahNEzkdldeiPpCKceWONX6N7AX9jZKX3glBb64psMm17kA/k70Xn6G7qJuLrSZyzzi3It0KvMxEPj5Zt8lgW3de+hE9BVXmEarSru9GnUosymYXC2RUcPA0oqVXRFAnTrlHcY5hi/jFp6aq5vmrNXZZk/A7MGZ81mpSSrzv4lCFBghGrgC9ZJgMR9ZqMnOxDKKvuBbUtEVBACc/6UwkmndDrGI2rnpdnDxTqGaPOd2Y2UvpFaLls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azR4ckFVYm4yVXFUd2tVT3BwTUl0dEd2NzA4bEFjUC9BcU4wU3dJdGVSd2Jq?=
 =?utf-8?B?UWlFV3o3K3lHNEF0bVB6OTl4MHRkdURLSDd3QTZyNXMwQ2tINDZHeFJ6VUlY?=
 =?utf-8?B?anp3ekt6WEZGNnlGcWEyYk53dWh3S0FEWkZHNmhaaitON0FLMlAvUDBYTG9E?=
 =?utf-8?B?QndKMS9mV2RiVkhhOURIWDJzaWdZd1hnbmZUNGE3MUVFWlh6M2FZYjZoRWcv?=
 =?utf-8?B?eXYzQ24yUmdnNWd6WndFU1E3b2xBb1FwKzZ5NFAxZzNrN2xjcWFBOU5KajF6?=
 =?utf-8?B?aVJzRXRCWjVHVEFFWHRkWTE1L0l2bG9FWHN5VkFIUXluQm5kc29kVXNlWlNB?=
 =?utf-8?B?c08rTkdRUXJtNzhmeS9TRDlWVE5wQ0YxU0xZUlpHY2V5RzFyeWFVMUJGblFC?=
 =?utf-8?B?clFhYzVHWjN5TjRmZkxzdDM5SER2YVZiempONG9Iak1MVWhGSjJqUXErRktm?=
 =?utf-8?B?Y2tjQStFWnVLVlBZYnRHVWNja3FuTlR2ZHN4bEFWcCtzZk9VSjRrQmJVSGJZ?=
 =?utf-8?B?bDMyUG1FbzhiV1k2eTRGaklweE9OYkJHN0hRTm5kOUUvNXdIUm1sOVU4U1d5?=
 =?utf-8?B?WXVwb1g3VUZVeWloQzhuc21CdWJNYW1qMnNwb3J5ZCs0aXhoMmxZZ2Y5ZVAr?=
 =?utf-8?B?MGNsdWlvL01tRkZGQ0J4d2t2RXkrbVZ6OHhNektFcm10aXFJK3hiMjJTZ2tl?=
 =?utf-8?B?Nm9vVS9ycjRDQlVRc2FrcStvUWptVzJ3NThURVRRRmRZZ1VDb2dBMDBKU2Nm?=
 =?utf-8?B?TXFTcEVtZU1KK1FJdkN1d0ZOUElTUVJFV3A4ZDJucTZoRTZyMWp0dEQxYmpT?=
 =?utf-8?B?UlE4SzlySEtVL2t5OHJZK0h0YWh0MWpzZ21tT3dVM3pBa2Q5MHE2K2RhSTRl?=
 =?utf-8?B?NWtndC9mcFYzTlpxVTFEZHd3QmR3YThmTDNpSisvditVUExjeGhuejZyMzY5?=
 =?utf-8?B?Ly9EZ0R6S09kRlp2ZXFQZHM3MGVFOW1RNytyVnVRTStvcDY5d3Zxa1FsVVBi?=
 =?utf-8?B?ZTJrclg4STNRSVRmMUpDQ1N2VThwVStJN2lvb2Z0L044NStiOHBlcHZTc1Nz?=
 =?utf-8?B?bWliUmFDQlJqa2JFZHhWbTR6cWgxL3ZuUkxjNkVpYkphaHRkWmFkMVhoZjls?=
 =?utf-8?B?bmE0R2ZrWEszeG9ueWlJRVZDTThLZ2YxbDBaNVl0RTRPMnEwZEV0cFZNc08r?=
 =?utf-8?B?Yk83UGVZNWFBMElMcUJlb1pjK1pqZkc1MGVnWFNtVFJBc21JRmpEOFR3R2ZB?=
 =?utf-8?B?NFo0akgvK3MwK0d2eHN4amxoSm9VbGZRZGV6TUlKRWQvL3pjRURYQnhnczho?=
 =?utf-8?B?Z0tJTzlucmtDd3VBWVVKaEpHWnVXcDJ4THJiUklQWXE2M0NCbFJyNXQzb1dz?=
 =?utf-8?B?bFF1UGkza2podGhESFlRVDdGVEdXbXNvK3BjbWdHbGpCeDFPZ2tVRllpOEpG?=
 =?utf-8?B?U1RDVnVPbzJ2aGZSWW9mSEhPdWdaa3loV2lFWCt4Mit1TnpyemMvLytKQjgy?=
 =?utf-8?B?SWh4Qi9wQ1pQRWZTSUIzKzQvbk9UajV3bjlEdEl0ZVZEWGQ4V1ozaVVNM05F?=
 =?utf-8?B?OFZvTUs2eGlST0h0Ym1ESmo5SzZwM1M4QmtBLzlCdmp4QVBIcnFrekdPMmJv?=
 =?utf-8?B?ZHJSb2dYZ0JBSmZPZ2htODNMMkxwMnl1QlBLejVpcFArZkdvdkRoQzZUWklF?=
 =?utf-8?B?bjFRYWhMZ3gzMFNqLy85L24zZDdtT3NCNFd3SzhaVDd0Q21hK2d6VnBNdnNF?=
 =?utf-8?B?Z3k2M2QvTmJSYUJXUVVPT1drRmUrcWxURjB3UFpuQXNBMUdxaElVNFdmOHQ1?=
 =?utf-8?B?WWV6WHhlRkJkdmhzeDJIeXYwYWhNOWt5YnptM1VWZ1QwOCtRWjJkeHhqNlB1?=
 =?utf-8?B?cVJFdlJWOVVHQkdueGhLbW9VM0pKbHNvSFR2cndmVExjSytxRXZ2RnZ4NGt5?=
 =?utf-8?B?djZZSWJReGQ4WENWTWlSVlU5SnJLSTg1MTIxUHFJdWd5L3JGcDFHWTh2MElo?=
 =?utf-8?B?UWhLUXpRNDcrU25Fa0s1MVM3cndZbEp5R0lHU2MydEkySVVlcmhCSzV6YXQw?=
 =?utf-8?B?aVJBaHlwNCtaVHhsWDBVdHYzYk5Wa2JDU0tQVytYL3BPNG4vMlA0dHhnM1Za?=
 =?utf-8?B?QUFSTElJWG5UWWtBa2JKVWxlVFpwM1pHQlFwd0dZRmZmTnFkMEdNbGFBcEJi?=
 =?utf-8?B?Z2F2TVJia2tPOG0zQitEU0tqUXk1QjltU0NORVRuQmpObTBHSEM2YnpiblJD?=
 =?utf-8?B?THhtenlXQmMzTjdjdlRuc0FMTm9rQm80ZGJIWVFhNFRhZVJEMFZMTlc0OEhq?=
 =?utf-8?B?dEk0SG1WNTF1ZFgyaDl0VmxkbVV4Vml0MDhNZ044UHArN2Y3OWhQZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae54975-65ff-4a63-5b49-08de9e9cf7e2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:23:34.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86/LTSgsV2A3qFoqO3S9HbiUVTuxHvKn7bsofyYkhwgTwuafVekM87y6ojBcq/P7w+TYqOqxj7gIVY1TBE38LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183

Hi zhidao,

On Mon, Apr 20, 2026 at 11:56:46AM +0800, zhidao su wrote:
> SCX_OPS_ALWAYS_ENQ_IMMED promises that SCX_ENQ_IMMED is set on all local
> DSQ enqueues. scx_vet_enq_flags() enforces this for BPF kfunc callers
> (scx_bpf_dsq_insert, scx_bpf_dsq_move_*), but the framework-internal
> goto-local paths in do_enqueue_task() — PF_EXITING, migration-disabled,
> and !scx_rq_online fallbacks — bypass scx_vet_enq_flags() entirely.
> 
> When a scheduler sets SCX_OPS_ALWAYS_ENQ_IMMED, tasks hitting these
> goto-local paths arrive at dispatch_enqueue() without SCX_ENQ_IMMED in
> enq_flags, violating the flag's documented semantics.
> 
> This can be observed with trace_printk instrumentation at the enqueue:
> label while running a multi-threaded fork-exit workload under a scheduler
> with SCX_OPS_ALWAYS_ENQ_IMMED:
> 
>   Before (scx_simple + ALWAYS_ENQ_IMMED, 2 CPUs, mmap-contention exit):
>     95 PF_EXITING local enqueues, 95/95 IMMED=0 ALW=1   <-- bug
> 
>   After:
>     1030 PF_EXITING local enqueues, 1030/1030 IMMED=1 ALW=1  <-- fixed
> 
> Fix by checking SCX_OPS_ALWAYS_ENQ_IMMED at the enqueue: label and
> setting SCX_ENQ_IMMED when dispatching to a local DSQ. This mirrors
> what scx_vet_enq_flags() does for BPF callers.
> 
> Fixes: 3229ac4a5ef5 ("sched_ext: Add SCX_OPS_ALWAYS_ENQ_IMMED ops flag")
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
> ---
> v2: Resend to correct a submission error in v1 where unrelated files
>     were accidentally included in the patch. The code change is
>     identical; only kernel/sched/ext.c is modified. Apologies for
>     the noise.
> ---
>  kernel/sched/ext.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9628c64e5592..0758f5e5a8f0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1859,7 +1859,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	 * Clear persistent TASK_IMMED for fresh enqueues, see dsq_inc_nr().
>  	 * Note that exiting and migration-disabled tasks that skip
>  	 * ops.enqueue() below will lose IMMED protection unless
> -	 * %SCX_OPS_ENQ_EXITING / %SCX_OPS_ENQ_MIGRATION_DISABLED are set.
> +	 * %SCX_OPS_ENQ_EXITING / %SCX_OPS_ENQ_MIGRATION_DISABLED are set,
> +	 * or %SCX_OPS_ALWAYS_ENQ_IMMED is enabled (which re-applies IMMED
> +	 * at the enqueue: label below).
>  	 */
>  	p->scx.flags &= ~SCX_TASK_IMMED;
>  
> @@ -1949,6 +1951,17 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	 */
>  	touch_core_sched(rq, p);
>  	refill_task_slice_dfl(sch, p);
> +
> +	/*
> +	 * Honor %SCX_OPS_ALWAYS_ENQ_IMMED for framework-internal local DSQ
> +	 * enqueues (PF_EXITING, migration-disabled, !online fallbacks).
> +	 * scx_vet_enq_flags() already handles this for BPF kfunc callers,
> +	 * but the goto-local paths above bypass it.
> +	 */
> +	if ((sch->ops.flags & SCX_OPS_ALWAYS_ENQ_IMMED) &&
> +	    dsq == &rq->scx.local_dsq)
> +		enq_flags |= SCX_ENQ_IMMED;
> +

I'm not sure this should be applied across all fallback cases, it's probably
safer to avoid triggering re-enqueues for the internal events, especially
considering that the BPF scheduler doesn't have visibility into them.

If we do this we should also update %SCX_ENQ_IMMED documentation, that says:

 * Exiting and migration-disabled tasks bypass ops.enqueue() and
 * are placed directly on a local DSQ without IMMED protection
 * unless %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED
 * are set respectively.

But again, do we actually want to do this? If SCX_OPS_ENQ_EXITING and
SCX_OPS_ENQ_MIGRATION_DISABLED aren't set, these cases are handled internally by
the sched_ext core, so triggering a re-enqueue seems unnecessary, as the BPF
scheduler wouldn't have visibility of such events anyway.

>  	dispatch_enqueue(sch, rq, dsq, p, enq_flags);
>  }
>  
> -- 
> 2.43.0
> 

Thanks,
-Andrea
