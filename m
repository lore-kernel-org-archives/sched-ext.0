Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04274483AF
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292313; cv=fail; b=mVaylceUBi9oEU/1j8SVTGaQoqlGkszvjV4wR7pTdkZR+HtVL7Uhlk/YWTm2g3KOK3smo0SLct8keGgfTasM8HHP4LhD2DGZuH3eq+SVLg8r6MKKNmrrzIRhVPSU7MMoOZ95EaLuk9cuYk1Gi5BDKevdd3b44c+jd2jFev6+TrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292313; c=relaxed/simple;
	bh=Uuf0NbmeP4x0mWrOipeImLtutDXYK+rZy1Zm/+lu5TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WugENqMnQ6hj9DMNlrhMYDsc2Abj6bXrd0fygb3qtN5ebOGLaGvdLArmgl9YH9PdA5SloW0y/1eq5F0YntniyeoLBQS/yJP0rc/bRxqrQfFk2OULsNWWp+wDc9MOCQcmE4q8WufzD0lPi9qjpVLkkNRKctd8adfXhUsjM3qq900=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TV7j6X0C; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TV7j6X0C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xsbzf3b1n5yK5tthIJZ0YJmJyEZVhQi7G1oHSx82JZGtfkamBKuDd4qyY9LDgKUFHHay5oSS57NMObxSnb5pGYeiI2DtULGIJ5IuyRiq6MNjBr6nzoW7XdTSr2UTiYUtKQDQslXSX/r0opgB7B1H95vFa2IWEsV62bZ4Xuxeyw3Y8UPsjrcePMb67RuOL9Sl8e1gSz2ER6044a8ffuFUuQuzj3m9GGQFa14YMDESOAocdkx58c7IH40i4n5Q+b1cuAIjgk0YMAbby8oF5WkIJIk38rHwSfvCPvyImPlk2Vb2cCuJKT+gKAPgn3WcOWHahTwiXvubABayoIZWEIhbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWEKtnajw7FKlbatTOg/02tkullvDwBf4KoGTaLDsRQ=;
 b=b82Myy/cPjdSflDGCF66smu2DhrF+sNOutSt/hi7URAABBBq7r0xwvZsru06z7xzqNfSTZT3UW01PJsNTtBmp08HqTy2ji9lFzNVlQq9q/GOcA7akwOtibR+RwumVVwdLjUISRA2c2+fYpvxrIHfMhEZc2D4U40vF8qoL/hNGbjCOTagnqxbN/38grg8S9/Rs68TCmLSZjHgPByD16Hau6/A4fdPHaklekrItj6YRATc3s7rR6YTyGumdTGDYRCKh7ce1nL7fkHs4YEEjFzfluop3GlrVRXAWaeEIr9R4mYHLoXTARQV0qxarRgJPD4t6/YBL/H6ObUv/qB999q1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWEKtnajw7FKlbatTOg/02tkullvDwBf4KoGTaLDsRQ=;
 b=TV7j6X0CaveSUmggBzNZKy4OB20sT6o3bEWA4PARJ2kkBGbrkSsARbg2N5bkudsrRLWNti3W0dmqjAQT3CDPhm8RbNgfx7hw1WAOcaQpGSCfanCHu3tsSYAy1XapPYN5JMV72NEXxY3cOxxmIZjIbM9ZpCPHgBTaKokTyM4Eb5ALr1zkrgnUAWHHXewMTK9ZaeJ3AdZc5FcNM8iYg2LT+rsOctoDg8cdhYRBoGewjs5GDQ5m84TMpxw8ZC65z9QUc9Mb5RwPjJ8ers3JpsovZAYKdyPOK/3ohtH2x30gEj7ymNknqGc/E5333UTK33vY2NkxaatIdaeIfozEooTpmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:51:46 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 19:51:45 +0000
Date: Tue, 1 Sep 2026 21:51:37 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Reject NMI calls to lock-taking kfuncs
Message-ID: <apcsyS2j-N8j5-BN@gpd4>
References: <20260901095652.1009104-1-liwanwu@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901095652.1009104-1-liwanwu@kylinos.cn>
X-ClientProxiedBy: MI3PEPF00007541.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d3) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 81db95b4-9fc8-437d-5e66-08df086273df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O/CUwrzU/B2tJTxEU0QWy7d0gvrmTf1wWt06m9vLgEriG6EGihJ3toddYCBdkONbE7nk8R1TOr92Ak5LBVEDKLssc71YRzZFMEeou4xXUlD+NaqyxFL2IA1Ta9VyLu2/povK1ZIIX5OmzejxunCw9meuHrkA4V0v/pikPratunTlIHoHTPocqTPE8gGMjLCUmL4iTZzda1E3nAa3Bf+bM1iOjFaVfgG88AYQBi9zr8UgezPVplyonce9r6q+SHoasTBWOGzZviw4qOif8wp4uHf+ntsAlnN9ElgGTBU6y3V0w8jw2NH8GYYMIRaZEyQogaDg8aXArXatrto96XlOoG3E+yjLmIgPnBBEzcEeuPNU6zaOha/QFVT591LUVRPaUE1eRKOD5KuG6LH8HpeyXIqLkApK6T5nZQKBCrfuVlhTQ/O21Zv1dui/4VVa43v5Lc6FisHVIHgEZiUSqcdRvsJoi6pD1zPamagYcQO7rtjQ7DQBCTNAdgLIzvUjzU803hm9r6DWaGqpI0GsVKQsFvV4hhQDhPLNiSbYd28J4XmDqwtzPufjNoyW6JsdPPXtmQ2J91KqE7PYb/0j3Jg8FXj/N50JElfxyDL8xfIFmP3oniH73d8f27LIUzDPeujssBP7YUODDW/TfA1y02iDrFWRkyPjQz6gvUd54M6v99Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TLkI6Kvx1qZlmBIcqa+4pDHhLUN/Qb3WOPSlSlGKftcZM9RZsgULm+uWhfS8?=
 =?us-ascii?Q?UsD1vH+Ttl0ZdINhNNjVwfOCF0vgVckyVemCTMZGzUZHHHdRkDM961K2jh/d?=
 =?us-ascii?Q?cjjwCFuryR13YvFSR/j+XNE1odr33ZOrvV3EBqD+1nOYJLrejz05z4PBcyTc?=
 =?us-ascii?Q?icoE2iHh1xKvyXu0kpx4NPmDUzYbfj6kMDF3zuS9SaphC+AS5HH0tL8BY56R?=
 =?us-ascii?Q?L50bkWpyc7S3djUp94PbNZlhpFq8zYFu5w7fADn3DTA7zhcaCj410IQdGwfc?=
 =?us-ascii?Q?56hzbPvW3IfTp8AHuWGm3bpdx6rhJnYLZ6xnRzFxm1UwsS6P0GdQd4sr257O?=
 =?us-ascii?Q?Fgk92S5vuXI4Qb0w/6t/NEFGAlck+s+NkGt+VfDsfh7kjH9JlwFW6+01UPOz?=
 =?us-ascii?Q?3ELPcxI37f6ThSA8XPcTdjxm7ltodEHjn3V9DpHX0C7WPwbtJ3uDUrtNJXj6?=
 =?us-ascii?Q?W21V4RtTLBeAvcahs/4um5DPk1ZPbEfoNRREqmoUHuGge+oGcYtWtE2F8bo2?=
 =?us-ascii?Q?vcUIJtmWQDFOxiieWDjmDB/3yjr15uyk7ITY5oJvVgL+qgpynmK5DdSrj038?=
 =?us-ascii?Q?iLG58D7o+SAn4Tznn+ZCfvKT+EL5iEHWas4Pv4Gxuk+lNIB33GQA6auAD1/p?=
 =?us-ascii?Q?V4+Ltd/ZidYku4vQLnesXZMmgaT1MtTbzwYnDvvZMs0dMchiKg3k+M4GpmWs?=
 =?us-ascii?Q?MFSqA1vSc95fLgmHFrpN5e9XbNDumzqrdCcCoT6QnTbcKiJm1r/AZj3+eElJ?=
 =?us-ascii?Q?PSFty/ofdqntHdZP/8sTeEHS/brjAJ2EBf2dQAotiwAIvnUwZabK3RWV5lgy?=
 =?us-ascii?Q?9HzW7MKgY1uACvu2V2B/U8/Uvsc/XpsdfKk57mLxO6IA6W9EnIgqfofNyTmS?=
 =?us-ascii?Q?Omw1U1ph9QjBQwRouBRlm1nPIMbq4skZ7zhejowF1MZ0cT01TlYzjhf9T/uM?=
 =?us-ascii?Q?zP+5b3Efe3RKhNJIPy7gYKLjI0Yvh9UCV5ZwIK5tIUg4I1xn1Hqo7AcFrrwT?=
 =?us-ascii?Q?yGEwS5THsAJXLFQBgCQQTVsl7oSi8oYK+Xvjotrig0+3bFJYLqPEgCwWxqEG?=
 =?us-ascii?Q?1pCFwI2VqU++idmR1sVSjX4/NKOYqjGjaYuNhJvnceBO9YgycFOEBZBXUIQ9?=
 =?us-ascii?Q?CO8JBBoWDNICcj9NgVT0PUAP+l9Ubsn3Zivmy7XwHVd9PB5n3JBsxTMR2/qV?=
 =?us-ascii?Q?FSLsRQdHQVItWezX2+YbsPZTN+si/gSoX1GtS189Ct+X0wfCt/ySoesbnCNK?=
 =?us-ascii?Q?VRDSqFDqxToEgT+innXDUcFWtEn0mitq0aH/iwZShzi7kYio1jWV0nkDmaqZ?=
 =?us-ascii?Q?KphDbo+zNZqNuzcS+WGjZPIeF/mn3hefQGG6cys8/ITi3jNVgmhWo4qXVYP2?=
 =?us-ascii?Q?sMPk5DMlyWA7dbrP772ximM8Tyc3lGigrty3/gTuoIe1a3qyKsMxzd6Hac0Q?=
 =?us-ascii?Q?Z3w3IC6LM+n1oSseRcHt+L04QMsSU4y9udR1WwATL6O4K/6juNPBZsWyTYRw?=
 =?us-ascii?Q?qwGXKdUZnjNBYmqNI/N5gV3Ib/EwGVvhkCbNFblKvwqKg6PjQ1ise4jG6Hw+?=
 =?us-ascii?Q?3somhIWYndZowxA0x/ryGfn7eMgB2dUYbWi1pZ0TMSTtqlDxwOAxAaiglqPF?=
 =?us-ascii?Q?uDLQCyILxQCLUEcHvAKsPNaetkFvthyLgwPMDassaJmmToRd3TaiXqYfM+VX?=
 =?us-ascii?Q?9cg+OyLOzbQT0TX/lP/bW8d7sI0fB7R2znSvbf3zdO9mRnJYl8jInEIfE406?=
 =?us-ascii?Q?DKaN1jmWtQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81db95b4-9fc8-437d-5e66-08df086273df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:51:45.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NjamP6Bc1J4OdHQvFvDYYlfJBWIjaWmS2HktOwuRnsHuFrupFYN3hVAn1xJXWSEW5vvGyqcUlJHqvFHzUgW3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021

Hi Wanwu,

On Tue, Sep 01, 2026 at 05:56:52PM +0800, Wanwu Li wrote:
> commit e06ece82d7b0 ("sched_ext: Report NMI kicks with scx_error()") made
> scx_bpf_kick_cpu() reject NMI calls, and its cover letter describes the
> reachability: sched_ext kfuncs in the "any" category "are callable from
> tracing progs that can attach to functions running in NMI", and an unlucky
> call from there "could deadlock the machine". The fix in that series made
> the error/exit path lock-free so scx_error() is safe to call from NMI. That
> closes the *error* path of every kfunc, but not a kfunc's own
> business-logic lock acquisition on its success path.
> 
> The remaining lock-taking kfuncs that scx_kfunc_context_filter() exposes to
> BPF_PROG_TYPE_TRACING have the same hazard: if an NMI lands on a CPU whose
> interrupted context already holds the lock, the kfunc's raw spinlock
> acquisition spins forever and hard-locks the CPU:
> 
>  - scx_bpf_destroy_dsq()                    -> dsq->lock
>  - scx_bpf_dsq_reenq()                      -> rq's deferred_reenq_lock
>  - scx_bpf_cpuperf_set() / scx_bpf_cidperf_set() -> rq->lock
>  - scx_bpf_sub_grant() / scx_bpf_sub_revoke()     -> pshard lock
>    (via the shared sub_cap_preamble())
>  - bpf_iter_scx_dsq_next() / bpf_iter_scx_dsq_destroy() -> dsq->lock
>    (bpf_iter_scx_dsq_new() is lockless and needs no guard)
> 
> As things stand, there is no scenario for reenqueueing, iterating a DSQ,
> setting a performance target or granting sub-caps from NMI. The guards
> defend against a buggy or malicious BPF program turning an "any"-category
> kfunc into a machine-wide hard-lockup through the door that
> scx_kfunc_context_filter() already opens. This matches the intent of
> scx_bpf_kick_cpu()'s NMI check, which the commit cited above added not to
> enable an NMI use case but to surface such a bug as a clean abort.

The deadlock scenario makes sense to me, but I wonder whether we should prevent
these kfuncs from being called by tracing programs altogether instead of adding
runtime checks to the scheduler paths.

AFAICS, the lock-taking and state-changing kfuncs do not have a meaningful use
from BPF_PROG_TYPE_TRACING. We could move them out of scx_kfunc_ids_any into a
separate set registered only for BPF_PROG_TYPE_STRUCT_OPS. The read-only kfuncs
could remain available to tracing programs.

This should include:
 - scx_bpf_kick_cpu() / scx_bpf_kick_cid()
 - scx_bpf_destroy_dsq()
 - scx_bpf_dsq_reenq() / scx_bpf_reenqueue_local___v2()
 - bpf_iter_scx_dsq_{new,next,destroy}()
 - scx_bpf_cpuperf_set() / scx_bpf_cidperf_set()
 - scx_bpf_sub_grant() / scx_bpf_sub_revoke()
 (... maybe others that I'm missing ...)

That would reject invalid programs at verification time, avoid the runtime
overhead and make the API boundary explicit: tracing programs can observe
sched_ext state, while only sched_ext schedulers can modify it.

If BPF_PROG_TYPE_SYSCALL registration is needed for test_run or selftests, we
can retain that separately since it cannot execute from NMI.

What do you think?

Thanks,
-Andrea

> 
> Route all of them through a new scx_kfunc_nmi_safe() helper and reuse
> scx_bpf_kick_cpu()'s existing in_nmi() check - now shared with its cid
> equivalent scx_bpf_kick_cid() through scx_kick_cpu() - so the rule is
> stated once and the coverage is auditable from one place. scx_error() is
> already NMI-safe (commit f883dbb64ca5 ("sched_ext: Make exit claiming
> lock-free")), so the reject-abort cannot deadlock the lock acquisition.
> 
> Read-only members of the reachable sets (dsq_peek, dsq_nr_queued,
> cpuperf_cur/cap, sub_caps, the idle cpumask helpers and the cid lookups)
> take no scheduler lock on the path a tracing program reaches them, and were
> audited to that effect; they are correctly left unguarded. The select_cpu
> kfuncs do take pi_lock, but scx_kfunc_context_filter() only exposes the
> any/idle/cid sets to BPF_PROG_TYPE_TRACING, and struct_ops run in task
> context, so no lock-taking path here is reachable from NMI.
> 
> Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
> ---
>  kernel/sched/ext/ext.c      | 27 ++++++++++++++++++++-------
>  kernel/sched/ext/internal.h | 22 ++++++++++++++++++++++
>  kernel/sched/ext/sub.c      |  3 +++
>  3 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10af28a9f2c0..a0b886975e1d 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -5108,6 +5108,9 @@ static void destroy_dsq(struct scx_sched *sch, u64 dsq_id)
>  	struct scx_dispatch_q *dsq;
>  	unsigned long flags;
>  
> +	if (!scx_kfunc_nmi_safe("scx_bpf_destroy_dsq()", sch))
> +		return;
> +
>  	rcu_read_lock();
>  
>  	dsq = find_user_dsq(sch, dsq_id);
> @@ -9518,14 +9521,8 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
>  	struct rq *this_rq;
>  	unsigned long irq_flags;
>  
> -	/*
> -	 * The per-cpu kick list is guarded only by local_irq_save(), which does
> -	 * not mask NMIs, so kicking from NMI could corrupt it and is unsupported.
> -	 */
> -	if (unlikely(in_nmi())) {
> -		scx_error(sch, "scx_bpf_kick_cpu() called from NMI");
> +	if (!scx_kfunc_nmi_safe("scx_bpf_kick_cpu()", sch))
>  		return;
> -	}
>  
>  	local_irq_save(irq_flags);
>  
> @@ -9756,6 +9753,9 @@ __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *i
>  	if (!kit->dsq)
>  		return NULL;
>  
> +	if (!scx_kfunc_nmi_safe(__func__, kit->dsq->sched))
> +		return NULL;
> +
>  	guard(raw_spinlock_irqsave)(&kit->dsq->lock);
>  
>  	return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
> @@ -9777,6 +9777,9 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
>  	if (!list_empty(&kit->cursor.node)) {
>  		unsigned long flags;
>  
> +		if (!scx_kfunc_nmi_safe(__func__, kit->dsq->sched))
> +			return;
> +
>  		raw_spin_lock_irqsave(&kit->dsq->lock, flags);
>  		list_del_init(&kit->cursor.node);
>  		raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
> @@ -9857,6 +9860,9 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
>  		return;
>  	}
>  
> +	if (!scx_kfunc_nmi_safe(__func__, sch))
> +		return;
> +
>  	/* not specifying any filter bits is the same as %SCX_REENQ_ANY */
>  	if (!(reenq_flags & __SCX_REENQ_FILTER_MASK))
>  		reenq_flags |= SCX_REENQ_ANY;
> @@ -10244,6 +10250,9 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
>  	if (unlikely(!sch))
>  		return;
>  
> +	if (!scx_kfunc_nmi_safe(__func__, sch))
> +		return;
> +
>  	scx_cpuperf_set(sch, cpu, perf);
>  }
>  
> @@ -10269,6 +10278,10 @@ __bpf_kfunc s32 scx_bpf_cidperf_set(s32 cid, u32 perf,
>  	sch = scx_prog_sched(aux);
>  	if (unlikely(!sch))
>  		return -ENODEV;
> +
> +	if (!scx_kfunc_nmi_safe(__func__, sch))
> +		return -EBUSY;
> +
>  	cpu = scx_cid_to_cpu(sch, cid);
>  	if (cpu < 0)
>  		return cpu;
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 27bbf5e04d90..49b165effd67 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -2091,6 +2091,28 @@ extern struct scx_sched *scx_enabling_sub_sched;
>  #define scx_error(sch, fmt, args...)						\
>  	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
>  
> +/*
> + * sched_ext kfuncs that take scheduler locks are not NMI-safe: a
> + * BPF_PROG_TYPE_TRACING program can be attached to a function that runs in
> + * NMI, and scx_kfunc_context_filter() lets such a program call every kfunc in
> + * the any/cid/idle sets. Acquiring the rq, dsq or pshard raw spinlocks - or
> + * touching the irq-masking-only kick list - from NMI while the interrupted
> + * context on the same CPU already holds them deadlocks (or corrupts) it.
> + * scx_bpf_kick_cpu() was the first guard; route all of them through here.
> + *
> + * Returns true when the caller may proceed, false when running from NMI and
> + * the kfunc must bail without touching locks. scx_error() is NMI-safe (see the
> + * lock-free ->aborting claim).
> + */
> +static inline bool scx_kfunc_nmi_safe(const char *who, struct scx_sched *sch)
> +{
> +	if (unlikely(in_nmi())) {
> +		scx_error(sch, "%s called from NMI", who);
> +		return false;
> +	}
> +	return true;
> +}
> +
>  /**
>   * scx_root_protected_live - Root sched for paths that only run while live
>   *
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 0554448835bd..b5125a871562 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -2265,6 +2265,9 @@ static s32 sub_cap_preamble(u64 cgroup_id, u64 caps, const struct bpf_prog_aux *
>  	if (unlikely(!parent))
>  		return -ENODEV;
>  
> +	if (!scx_kfunc_nmi_safe("sub-cap kfuncs", parent))
> +		return -EBUSY;
> +
>  	if (!scx_is_cid_type()) {
>  		scx_error(parent, "sub-cap kfuncs require a cid-form scheduler");
>  		return -EOPNOTSUPP;
> -- 
> 2.25.1
> 
