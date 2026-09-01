Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8937BE63
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249143; cv=fail; b=e2QxUMv34rPFpct39A1It9t9bHd3pispGKQr9oJWiO9IjRKOI66AG78hnwXfQ2v4DA2merDjUbsV/B5toO8ulFNpiJMjyufEqgPDNQ52l9FxWZaO1Zf9H/E1bUZHGLGuXQnJ/fQldXslOiowm9CCSm0Pqw50X1AkBf7COe/+SPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249143; c=relaxed/simple;
	bh=uo5ulbTaUo2LyQSl7vcd8HsSahvjYO+8frWYBRKEW+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DZIDzeyoU3yeBnyGQfsQXUmHqEsn7ju9dLFDKRIhNozzkOBxdI2sBfxxG9bdFAVAHwMJj3sVLbgAO1wCbI6yC0wbf6H3ZHHcBjfr0DJLSa3VXZSTvbBVGOJC7i3nCZC/O50dCuPWBcGBWVCmkVzKM3dpKtjxa+PAlKif8rlkbAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QghIjvgp; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QghIjvgp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rd+SKd0qchvzwVOrWQ8CXfVsqRcgBRh88j+z8hA1eSJFmr05YuIYsrO9ETsR9TrzD/dbPz9LTscw4P6pIdbp0+qskDIYYeNAdYzyO8oZ49VYEX/wxYE/36vqQIhY4x4tWvxuVKCw3YvQsYIfmrZHb0aBOA4+Clowv4sgaKgFyQcJG6AQvD6p1vdIdzy6RPrNhVXeWSnbeHXC3mct1PfWfdXXERY4KaJwPz8yeuFUygCR6kmI+g3yvpP1Cq+5GEejQ5ZwAEq8zXAPGys7UScVB+44mw3g6wwKlx7If0aqlp/NVqcvkavJQrtCgKV4U7kE6g5CvFyexBkQL56C4Oj51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRDVJvfUuQZDCrJyk8e96mkQq8NHcNs1/USIVR1cTFc=;
 b=LwUZDos9xYl8gOJca2oVATP0O76ffX5ZPeXMtVKEz1haoGTpJXYeysvzA2I4OO3wVyqcZOWk7MFS0msTAxsIxKTqjNFBg2+4slQUWyfrm1iAQGs0r9aSyYs3gm5rOPond7aPPdKC/mw+FocbGkZ9Gn+S0oY37jy54Xfu5FOUvNfgaUN6lFEuZKnVe3hhQJIOnLaavqIr13ptmAz0yTo8jq03TTeLjyXVZHrh1chPsHaAk7NL3A5htNX5FHY6+HtjHUAbhraAQNjq3AU3ii42ZnwXvJ/8Vhqkmdck7VR+WqZyYAnHylM7rKWHAhQOMZJgqxTM1YeCOL4g05SJOZLwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRDVJvfUuQZDCrJyk8e96mkQq8NHcNs1/USIVR1cTFc=;
 b=QghIjvgpBNz/xHhox4W7zknLakcMj5BPwsNFk5jlmUNDw+RMEO8fmznMiAHjFlYnNvD2II2Z3rsxYrXAsTiOCTdTm1iqCqocZw8ViHwTabWAS0skEEnJg3OYBZI6K+heNSQ8JtiUtm8BZnVGIk5yH6lkUGUZ5hdoAWfm15pqNTMviQWPeIWgaP1iuXBjurx0YZW2hn40DSKXfZyFArl5kx60ZYL84NYJbKCmPofbTP1TFo/KwlmQYJw+FhzPOYHVXjhLEqk7B+b1y1wizdBympf2arZvzYr+Oqnz4v/a4l1S1yHBGSX6lgjYOzPDMRa7FpGrERWaw1Lq2HshskP6Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PR12MB9672.namprd12.prod.outlook.com (2603:10b6:610:2b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:52:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:52:12 +0000
Date: Tue, 1 Sep 2026 15:52:05 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Emil Tsalapatis <etsal@meta.com>, Lee Trager <ltrager@nvidia.com>, Koba Ko <kobak@nvidia.com>, 
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] sched_ext: scx_qmap: Add proxy execution support
Message-ID: <apaDOhiWKcLH5iQt@MWDK4CY14F>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-18-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-18-arighi@nvidia.com>
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PR12MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9c1f9a-6666-4d46-c95f-08df07fdee57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|4143699003|11063799006|10067099003|22082099003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	QhQFJuIAhP/hczCzCi+MO0TRqq9f6tOqiRpUa02BZ5DrrETrSxpVkF0F95ZOgYPBryhtQQf9EqA7R9xj+GjGmOESSReNNebZ3ZQnJQ5yMrfP/D6eIuuv5/0E5G3UQNSopY80r/TbjiAI4FPDCHjmS2eKMGmUOYoturVutXkVRG060mDcjhTbqk4yRJlP04zalW/UmguT0U5kb4tGpTTRNU3aMhs+PJheSPg/Q9VB7ZdGzMXTMgWI0IWVkTSWrS0kiGeWNpjaZs1ELd2OffBxNxbnSZIaLE3hJPcBHGKtp9MjcIs7l7i3aST6t4GVMZv7+4wJYbRab7HjmP7QlYG9z9G4dk2k2DbByPi83r6Mcoi3ZNZm8+9uaL4HyTzHIF1WMXAtGb2th8q1ofAzgQ4UqcSlfiDbEquIU5v2MhwOTD4/scHMUZG7uSZTUm2kMhe9C9T0gNGkTUB2VMj70ZF7LD7EsrC1Szy9XuFloXhcA8/yEK7b8NmO12fpUF2hIiKw4Xc7N1/8DB9gWU0yUUioJR0SiaTFbvsXuUDw90thFwwYIymt0IvL77bQOtqSQI4ywEI1SaikOM0q9ZU6gFDIR4mVHsRJsoejvqstWimigSTmh30XGk3npAKcipQsqWlpXkkPLh839AlOcRYT3tkHVwd+RHOkryVP8YeFGuwEWUE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FgV7GIY/HOuQKM2uG3RZMnJFj5DMx4hVbiqAhfA0whnpwiNlC/aqpi4fNFqB?=
 =?us-ascii?Q?0cAIlOUyRZX6W/qjHGviJ7CbIXcaaTeaPnx7om72x654m7rKEQAEkcO8EEUj?=
 =?us-ascii?Q?t55msK0TxqZ+tDLIK4Y9H+QLy054ctbrU4Z/uZDS0+xF6krcsoE0kUaiyGJT?=
 =?us-ascii?Q?Z/6dHnNXBW2m6iipxUF2FDO4i6jzhxOYnpaFw+/Qw9zLmNr2Hv34+FsvbDrz?=
 =?us-ascii?Q?5y75yKLkNXpRHPnzG2Vpa5Xv11hZf45Gzqyjc45t2Cu6P1k4UhVK+A1yzxA4?=
 =?us-ascii?Q?WD/VWLHIS2FeHT13W7SuCWuAw7XzQZDWAEjOr5bbANTvzO5V6N786bD776gB?=
 =?us-ascii?Q?AoQkbx676WEsqlkfnwXPmMLTnBiolgLYXLeyya5sURR/VFhTr26zsknd1uXa?=
 =?us-ascii?Q?a/TF6jxO4Ov+i7P9x9ouvsKp3QpgNVF2QwFYbtxWSe35czY96zjqo2wtoEX1?=
 =?us-ascii?Q?Klst77q04M57kekq/am8kPVWtNDjmrfX5uTNAhFr8oNoKX27gYRu5nwCj7HB?=
 =?us-ascii?Q?sAUKr555KWdgUIh/Xfa3noN2R9hjjHqax2Qlg6l7uBynZIrz+EQ9ls48JBM5?=
 =?us-ascii?Q?aTE0xX6TGzOJUTUzKhVknAE+sk03HdbL7w92f43jpzJIkYP6icy7jMVnQW7l?=
 =?us-ascii?Q?hLbLZlxfLeTeP7lUMtVPcJonweHHP0I05iV7jLWF+lMeD2LpQCsmknbkQSFP?=
 =?us-ascii?Q?89NpFt5GGcFCQDlwZSeYiG8EFO/puSFZwh/aCVnIzY9mX8eaTZLga8oBcqyX?=
 =?us-ascii?Q?flIe/PhzfdGyU7QXWqtHtynpN5hhShzu2hnqZ9AKHivmWSat+ppb6hJIBUXd?=
 =?us-ascii?Q?PcTLs3aTxLU1zlv0FyrQTLiEhqdYmRjkzlYYYwYLrxXv/yKEGHnuBBpLr40F?=
 =?us-ascii?Q?24u3E4nL0GXakdmDVMPWlA2lf4C5OML3Cu2BDItHGNrRgVzCNoAcnmMM3pbW?=
 =?us-ascii?Q?cJ850dvbRv97/SuiftBmowoxvjnND1+EgkKXRFbrlyrW/rSRlzjbMJe5p0Zo?=
 =?us-ascii?Q?XW4Ugt9Knll7xoHr2ln4IjmKubVqWxS81CYXMSPdkLqE2h0wzLBqtoyQrgd9?=
 =?us-ascii?Q?xkeaXv2E89Cyrd3diqQOG0TjKY4jx93/s20M121YkFjSfsMItOR8zSCGCjxU?=
 =?us-ascii?Q?hUuPR1yQFxEWUfVCzBdsNuw/w3xxK2ZSQTAvYVJsW4dCEYc+rlwv9E+SQQ5D?=
 =?us-ascii?Q?0soJxDOD+SIZvLFkm11+2ptLS9bvq8MOVOFzpGNgXjBAd8bU9JQ4ghHDzkOC?=
 =?us-ascii?Q?7R9tKL3xZMGuaPFeB+r/gBA7PgEkOOWqQXWVpkGs6vne5rCu1IokWV3GYxMf?=
 =?us-ascii?Q?2R93wRhuXzbWe0nTUUqcufHL5DdOtUY2LVMHOtm8OxtS6fPakfsY8vGaU1Xe?=
 =?us-ascii?Q?o4TulIWx3Jzq2k/E7REd0r37ghdqrutEdEZZI+bCb537J/UuQlh0nZXYQAz6?=
 =?us-ascii?Q?DjqmZ1YII+YRq5BORHiramNgYcbNNPozqgm1Bx+FHrNzTuvU7Q5TEd4cvBKF?=
 =?us-ascii?Q?d+7sU2cXUQMz9cDaIT2lgL+VRTbJlCVmxR5qYH6z14ZWnwE+Fvi8sagzKHrI?=
 =?us-ascii?Q?l//tLSRl2YkZx/DwojJfEhr/t2o8XnaCcpjHUT8DlYMfLIRQq3yd0d9aOxLi?=
 =?us-ascii?Q?bRz0bOLYh1yd3XflBVqCv9VR6xzUokaBO3K8/hL46xJAbG4H1KtLfVC7P5oG?=
 =?us-ascii?Q?gcrtLpiyX23I4u5e69LfVC1fDkyZZFeu7d8q6MynN6KD0l5j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9c1f9a-6666-4d46-c95f-08df07fdee57
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:52:12.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KE9MpNNAGQGEpF8nj4E+Wn/QKd9+Vw73kcFYN3bTVdl4jMzXg0b4dUa739T+uMujIlyV/29GIuAWB/T7OK6K5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9672

On Mon, Aug 31, 2026 at 03:42:27PM +0800, Andrea Righi wrote:
> Add a -X option to opt scx_qmap into queueing mutex-blocked tasks for
> proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
> and mutex waiters block normally. With -X, blocked donors are passed to
> qmap_enqueue() with SCX_ENQ_BLOCKED.
> 
> When scx_qmap receives a blocked donor, select a cid allowed by the task
> and held by qmap, preferring its current cid. Dispatch the donor to that
> cid's local DSQ with a fresh slice and SCX_ENQ_PREEMPT, adding
> SCX_ENQ_IMMED when the cid is time-shared. This places the donor at the
> head of an eligible DSQ and requests an immediate reschedule, allowing
> the core proxy-exec path to run the mutex owner using the donor's
> scheduling context as soon as the donor is selected.
> 
> The blocked policy is intentionally unfair and can strongly prioritize
> tasks using contended mutexes, but scx_qmap is a demo scheduler and such
> aggressive behavior makes proxy-exec support easy to observe. Count all
> blocked dispatch attempts in nr_enq_blocked and report their per-interval
> delta.
> 
> Acked-by: John Stultz <jstultz@google.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  tools/sched_ext/scx_qmap.bpf.c | 53 +++++++++++++++++++++++++++++++++-
>  tools/sched_ext/scx_qmap.c     | 13 +++++++--
>  tools/sched_ext/scx_qmap.h     |  1 +
>  3 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index 5bb8b90a275a3..21f8a9be9650c 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -439,6 +439,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
>  	 */
>  	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
>  
> +	if (enq_flags & SCX_ENQ_BLOCKED)
> +		__sync_fetch_and_add(&qa.nr_enq_blocked, 1);
> +
>  	/*
>  	 * A task of ours that can run on none of our self cids - the parent
>  	 * didn't grant them or we delegated them to children - would starve in
> @@ -446,7 +449,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
>  	 *
>  	 * Force it onto its first allowed cid's local DSQ. If we hold that cid
>  	 * it runs. Otherwise the insert carries SCX_ENQ_RESCUE and the kernel
> -	 * diverts the task to its rescue path.
> +	 * diverts the task to its rescue path. Do this before the blocked-donor
> +	 * fast paths, which also require an eligible self cid to make progress.
>  	 */
>  	if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
>  		s32 c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
> @@ -460,6 +464,53 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
>  		}
>  	}
>  
> +	/*
> +	 * SCX_OPS_ALWAYS_ENQ_IMMED makes the local insertion below implicitly
> +	 * carry SCX_ENQ_IMMED. If the CPU can't run the blocked donor immediately,
> +	 * the core returns it through ops.enqueue() with SCX_ENQ_REENQ. Inserting
> +	 * it into the same local DSQ would repeat the IMMED handback until the
> +	 * scheduler is ejected. Move reenqueued blocked donors to the shared DSQ,
> +	 * which doesn't carry SCX_ENQ_IMMED, so another CPU can consume them.
> +	 */
> +	if ((enq_flags & (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) ==
> +	    (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) {
> +		taskc->force_local = false;
> +		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
> +		cid = cmask_next_and2_set_wrap(&taskc->cpus_allowed,
> +					       &qa.idle_cids.mask,
> +					       &qa.self_cids.mask, 0);
> +		if (cid < scx_bpf_nr_cids())
> +			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
> +		return;
> +	}
> +
> +	/*
> +	 * Insert a blocked mutex donor at the head of an eligible local DSQ with
> +	 * a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate reschedule.
> +	 * The test above guarantees that cpus_allowed intersects self_cids, but
> +	 * the donor's current cid may have been delegated to a child. Search the
> +	 * intersection starting at the current cid, preserving it when qmap still
> +	 * holds it and wrapping to another eligible self cid otherwise.
> +	 *
> +	 * A self cid may be held exclusively with SCX_CAP_ENQ or time-shared with
> +	 * only SCX_CAP_ENQ_IMMED. Add needs_immed() so either kind can accept the
> +	 * local insertion instead of rejecting and reenqueuing the donor for a
> +	 * capability miss. Once selected, the core proxy-exec path can run the
> +	 * mutex owner using the donor's scheduling context.
> +	 *
> +	 * This policy is intentionally unfair and can strongly prioritize tasks
> +	 * using contended mutexes; scx_qmap is a demonstration scheduler and
> +	 * this behavior makes proxy-exec support easy to observe.
> +	 */
> +	if (enq_flags & SCX_ENQ_BLOCKED) {
> +		cid = cmask_next_and_set_wrap(&taskc->cpus_allowed,
> +					      &qa.self_cids.mask,
> +					      scx_bpf_task_cid(p));
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid, slice_ns,
> +				   enq_flags | needs_immed(cid) | SCX_ENQ_PREEMPT);
> +		return;
> +	}
> +

Hi Andrea,

Do we need to do serialization between ops.enqueue() and the paths which rebuild qa.self_cids.mask ?

IMHO, appy_partition() can clear or rebuild self_cids after the check but before cmask_next_and_set_wrap().
If the intersection is NULL, the helper return CID, and then the value gets passed to needs_immed(), hiwch uses it as
an index and do "SCX_DSQ_LOCAL_ON | cid". This will be an invalid CPU.

Maybe do "cid < scx_bpf_nr_cids()" before using it ?

Best regards,
Richard Cheng


>  	/*
>  	 * Fault injection: deliberately dispatch one of our own tasks to a cid
>  	 * we don't hold. The inserts carry SCX_ENQ_RESCUE and divert to the
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index 5bb5f687e579c..d5226e0716573 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -46,7 +46,7 @@ const char help_fmt[] =
>  "See the top-of-file comment in .bpf.c for the design.\n"
>  "\n"
>  "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
> -"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
> +"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-X]\n"
>  "       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
>  "\n"
>  "  -s SLICE_US   Override slice duration\n"
> @@ -65,6 +65,7 @@ const char help_fmt[] =
>  "  -S            Suppress qmap-specific debug dump\n"
>  "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
>  "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
> +"  -X            Turn on SCX_OPS_ENQ_BLOCKED\n"
>  "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
>  "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
>  "  -i SEC        Stats interval, seconds (default 5)\n"
> @@ -107,6 +108,7 @@ struct hier_prev {
>  	u64 nr_dsps[MAX_SUB_SCHEDS];
>  	u64 nr_reenq_cap;
>  	u64 nr_reenq_immed;
> +	u64 nr_enq_blocked;
>  	u64 nr_inject_attempts;
>  	u64 nr_rescue_dsp;
>  };
> @@ -190,14 +192,16 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
>  	}
>  
>  	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
> -	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu rescue=+%llu\n",
> +	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu\n",
>  	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
>  	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
>  	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
> +	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
>  	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts),
>  	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp));
>  	prev->nr_reenq_cap = qa->nr_reenq_cap;
>  	prev->nr_reenq_immed = qa->nr_reenq_immed;
> +	prev->nr_enq_blocked = qa->nr_enq_blocked;
>  	prev->nr_inject_attempts = qa->nr_inject_attempts;
>  	prev->nr_rescue_dsp = qa->nr_rescue_dsp;
>  
> @@ -263,7 +267,7 @@ int main(int argc, char **argv)
>  	skel->rodata->max_tasks = 16384;
>  
>  	while ((opt = getopt(argc, argv,
> -			     "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:B:q:vh")) != -1) {
> +			     "s:e:t:T:l:b:N:PMHc:d:D:SpIXF:C:i:R:J:B:q:vh")) != -1) {
>  		switch (opt) {
>  		case 's':
>  			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
> @@ -324,6 +328,9 @@ int main(int argc, char **argv)
>  		case 'I':
>  			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
>  			break;
> +		case 'X':
> +			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
> +			break;
>  		case 'F':
>  			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
>  			break;
> diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
> index c78d61806b398..fc10b542fb477 100644
> --- a/tools/sched_ext/scx_qmap.h
> +++ b/tools/sched_ext/scx_qmap.h
> @@ -178,6 +178,7 @@ struct qmap_arena {
>  	/* bpf -> userspace: stats */
>  	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
>  	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
> +	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
>  	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
>  	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
>  	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
> -- 
> 2.55.0
> 
