Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE47389E18
	for <sched-ext@lists.linux.dev>; Sat,  9 May 2026 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361876; cv=fail; b=QA92Nj0AzdOCy+7oXx98vRVmXXbtzvnu3DnS8NIzZTzePpMj+WaAer7YP6F8NMh87yLGwlSaObbVw3BpvfoLmhNC1Y03q4yJHHUcejkgg32rTE6iG832AkweanWd2tlQU5fN25o6msGJfo233nsdrOmowhK8SQ7XADSNhRrLzJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361876; c=relaxed/simple;
	bh=5CKmvwS4xi01qsawQtD5x2Fpify6Ls1/lDXAEgbLZfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XvVDxTwMN5CvK7rP5q8Sdx+OL5XpXNKS2NUYdF7hQE1/lL4rYsG69OHG6IkFzqUi7s2Ooou9+XSRZeKHBHebeIyoaIXfFbRtJIOAwBTClcDO8LfkvpT+jtJKBLvOWYXGm1G8uTwIsdi+V32cbyKvfO00LOAT3xxPbzSoBb5sko4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IGBqgD98; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IGBqgD98"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsGGeCdKGsVvu2Z1aXwhLRngILyzBdjuzxFgFu+ZJOI95a79UHheypMLkE6XsM48eHXLKSF6IGGNVdHdnbc6z7aY6/OUCEvsHO0o4MGevkL5amaOouH7NmqjYP0782lxw1vpWC0KRzbzv16T5CuNvEUFZYiChAdSGuw1tEnEJajOFCvM5TBgq2kbuRCVmT9012ScvObutuIW+DR7iL/NQasP2IeLucVSyWpeg02cTy0ypqkGJoqADjrOsllGlfRLOWwfhc8S5D3RGs8Hroco5YYC/RLzONhZPe37uudba691Th9KEzwqxKHWJSni8+FrJvGrNWjlC9ALfOCg/qeTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytPy53U1WUBUppG7hxEgMC/oecuRV8fEgNyin2e2vPY=;
 b=Ieoq+y1iuw8Imxj0aEeGbp/N6hllba1kAuHkr6fIoKs4+Kl29G9alkn+KOg0tvDu9h+FTRj15HwVp3xmsN+JwewfxJah3OpkEY8teAMEfIFdb9GCxNChU1wYjMCtLvRy9vTSV9ZT+RONx3wBIxE7NcLkG2iJYBtzD3Ce2WxGqREcuyN0WnkpIS79YjgkkMx5hQDYwv4K+3fCYPAR2VqWO1wA87pCLH8SM15fKKUcZLjUETXacbzXgMQ6DIvtKdgZxkAtHDTnRveNcA5AOX7D8WuOIQRaxHs9gFL2Ow0kG1ZPR46Tvk9ylcwo2btwoAtkzIJdR79qKkkzitX4xamD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytPy53U1WUBUppG7hxEgMC/oecuRV8fEgNyin2e2vPY=;
 b=IGBqgD98/D2Vfj+DsuT/d9B8EwEy/NHc+EOFzYM3uXdxPDUfGYk9YtVPzGWGJY7Qvkv7kxnXpdwKew3kHcMj2VDi1TkF1XbfSsotBHkstp9p/qfzNMi204VKowwh0X3qkTt35fioHmA7mUwQ2lNCxgHwRJqPDoO6kB4g9xs3TIYwsPUa47vchhV9HpqzAprB8aSU58AV5f96zLb0N177FhClLVWqgGJfQdnNYDN51vZ3PmWC4f7Zenm6MUK/bKO4VbSNvcMu1hicwG9iQoxk55hGM4LsxiE0bBmZaCO0pJNzkFY4aBgLBTLyZ+BkbKfwo3yycM9FIksgesNQf2hlBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.21; Sat, 9 May 2026 21:24:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 21:24:28 +0000
Date: Sat, 9 May 2026 23:24:12 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 1/2] sched_ext: Add dispatch transaction API
Message-ID: <af-l_M9p9npc9FUA@gpd4>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
 <20260509191223.168648-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509191223.168648-2-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1P293CA0022.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d5b902-0676-46cb-d4e4-08deae11591f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	TPOzY3bZHFlJv69jxtYyj2Qn6rBSIFZJF3ThRRarzpzOHtBNSnVdN4HYyVonhIPgDFHIMUe/r3B8EKCeA0iA+Wn1D/ydHvCDp3bJmeEzWQPjCSZWUK0x6XmMb/kkdnsmDi1zg6P0amBBW8U2JcjnIQ+6KHLP9IUFuuIMBI8NWiKDoBK7RJQ3+2RsGbnL5JVD60Yeu87ryYi8eWunD2itMd0Onxem2jfGkbrfF/1M2Dz0KghlB6RdbTEWVbBFnZFTljqRWZHPyByraXp/QYrHDxO/dLfpX7ve+/xIgPdNS6WSVm1GFJkcZSNRlS4WElcOlf1kUZRU71d1e+RV3a0aAasuMQI+XYqaaTcbrGoCdeUmu6VJw/9RagltT7vNq1taI01v3VytLkHRSKStYWY9dKWnuzKqUpv+7IYOg/UUuCtsUEcxiH/rogUA6JskVSjwMNfmA/WHz/u8+aVlLveL2uQ9cZLnw/7J9Qt++OBz06ECWbKrLfeZW88WY8RpnMNwLZSaE3etrnSSQjFEyFiGruEF6RMPKXh7STkgPdYin3E4xwMXOMmWdnXxNwDwLW2HcCy31BnmWLeOQYJmvv0UdRf04n+5ffujVNLgrAj0bDx0YBmcX0XM63sNxo7BYUfZRse6f2KxomJcWvHK1G2KQDQ4BJ0hzDlaLRHpxF5Sl72+IdFAjHOB4tz+a7sfGLSrz5OOqDX2pgVEYl0OlqJDjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2UqOodg3bt3ZwYHVZuArwVlNRI5yGqVgyJ7whpPggZxNLJNOYfCFW0JiX5I6?=
 =?us-ascii?Q?DL3vgn+PeW4Uc3bFIcRvhPH0vkIIWMEFGk7mqSryIFwavyMRnbJ1Of+p4gi8?=
 =?us-ascii?Q?u2301hNjh6G52iIsRbt2pcrBOWNEHZMuRatoO5+J3zT4/fYOTPhQy0HlfOFC?=
 =?us-ascii?Q?T/s7TgfR3JL3trKFo4QAvT4ysmsj5b9Oe7RVkfNRYgHHWm1JZF2vQkZloucR?=
 =?us-ascii?Q?V5CxpYA/3bWzAt+wjPneuU1GRDujDS/3srThwtY0h1OxbdizZMg7tbWkDfDC?=
 =?us-ascii?Q?4K3c75BVYml/TU4aHBWMOByf246F5FYLq/viSjvKhzcY83n9VErsuUHZf8mY?=
 =?us-ascii?Q?BC05rPdV/ezph3bO7BqmKLWW1TJKo/fcSp8oCMlkH5cFSH+foXb1N26QSdTb?=
 =?us-ascii?Q?/MRFG0GNLpQ7+hhAkcFowxfaLUL9BuKvW/JzqvSfWPXffmSgL9VKcFqmm5QW?=
 =?us-ascii?Q?bMalnNC4RuCx3A2PvgYA76vhYZVsgJ7+vb9Lx/zQ9q2YSOc3uhI5z1VXxzcd?=
 =?us-ascii?Q?t1rhmZal8KUJQSz0q85pPknlepdbdf592Qr1/A2d/ExPdjxhDlcCjaDXra0m?=
 =?us-ascii?Q?+zw8YZENBAqSrk0S26DhRhaK84266KgSggJB0YCBtaNZ5xdOuroMtTAVH0PE?=
 =?us-ascii?Q?Pp435zMeRUX5o0OeIAqraMqkfhDXWvuS7310E9wv9lZGdqTDzJti0FPhQSPj?=
 =?us-ascii?Q?qMnDUoBmIN790+d/CjAY91AGLjx+zrs2cG2fCdxJNZ7kUjGJKQzmRQ15Mu08?=
 =?us-ascii?Q?4vHMdAl7MNOGrMkNmBgIv934zzwou+1MFuUem4ez2+RwOCXTVv+aOsNuYFim?=
 =?us-ascii?Q?GnoO2/Naw6qu7LGtOAytUAeDMxF8M0Me0S+ghO23RUx8CxT+Zuz+d+6Bi6R1?=
 =?us-ascii?Q?h7FeasGmN/GaJOdv1iFrpiiqzghFB9I6EwL3afaCYinzc8LoXpRl5ambP+tV?=
 =?us-ascii?Q?7rNGIPVmig2G/2w1DDEuqNCcdWgWhTkLqk8aGZX2bH2hV74x8JBq+gMYjByn?=
 =?us-ascii?Q?gaEsbeFplYHHtHPGVAOQtIuDWJuN2Z/dhnJqCDWnoV4EdtFlfrVV4dduMAZ5?=
 =?us-ascii?Q?efYIKl/8kejcRtoHpAcer0u12/Vd5nMGecORsuVKOVW6vUCDYZmsA6Ahy9VA?=
 =?us-ascii?Q?bl6DLD9YZksua0FiM/BVdi+7KNHTNegoe4u/ldGyCyIvijvoqjiKV89h8/ej?=
 =?us-ascii?Q?A/CbXPMvpSvh95XrejhQbsEIqIhK/GAVJCaeCLzJ6WNd1+Ld9NxFkNdOwBuf?=
 =?us-ascii?Q?zrNdbDp2yMs5Ns9JFlsVewq+YohUri91YhyDfM38mp9b5t9genC0HymqAyWn?=
 =?us-ascii?Q?v4vnByvs7ntrMAVzNNk1wp/Jy6SqpPk20dhiWDy/FrG/qMIcKxOIErgkXnPj?=
 =?us-ascii?Q?R3CH9mmN7PcUB3tFNpMNy20D1WZuzWwE4yzC3PIXeJpXePMSMXHcDE4YQL8F?=
 =?us-ascii?Q?Ld+XOTFUHE1fTCsadm+3eyE+z+a80thp9YXoSBg1zqW2yAvHHdrFfWcoLFya?=
 =?us-ascii?Q?C2CHQUDptsrOD2+Z2TNOBGwmOtUb3Mhp92L4y+/5yVfUfAT6rLBEeTkxGjmK?=
 =?us-ascii?Q?7B/4SopUSRkCqWnn2l80+Rk7RX6NWqhaaNyk3ItamrE4vRsO6ymCrQ45zhxl?=
 =?us-ascii?Q?H1vNIDk+NmIxHiPTvcOyWglOQo3FSb4ANuwyrpIOVZZOTgBNQ87pcMgRG2ok?=
 =?us-ascii?Q?SrdJDA/+3Phh8eOX8p4Ut50nCHdUnhBjQjXEH0nGRbjBzSXn+NOH0tr2capc?=
 =?us-ascii?Q?Ncpn/uGGAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d5b902-0676-46cb-d4e4-08deae11591f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 21:24:28.0025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ktt4aIYl0FTxaLHXHCbdVr2aK4NsSwzCLDQHP0wcDZLuBBHVWaZlIHr9CBjdoW2AWzJD2ECwqU+rEuQ4a7JoCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144

Hi Cheng-Yang,

On Sun, May 10, 2026 at 03:11:56AM +0800, Cheng-Yang Chou wrote:
> scx_bpf_dsq_insert() captures the task's dispatch token at insert time.
> Any BPF-side validity checks performed before the insert fall outside
> the race detection window: a dequeue/re-enqueue occurring between the
> check and the insert goes undetected, and finish_dispatch() proceeds
> with stale assumptions.
> 
> Introduce two new kfuncs to extend the detection window via a dispatch
> transaction:
> 
> - scx_bpf_dsq_insert_begin(p)
>     Starts a dispatch transaction for @p and returns an opaque u64
>     token. The BPF scheduler should call this before performing
>     pre-dispatch validity checks. The token may be stored in BPF maps
>     to support cross-CPU dispatch patterns.
> 
> - scx_bpf_dsq_insert_commit(p, dsq_id, enq_flags, token)
>     Like scx_bpf_dsq_insert() with slice=0, but commits using the
>     token captured by scx_bpf_dsq_insert_begin(). If @p was dequeued
>     or claimed between begin and commit, the transaction is silently
>     discarded. Use scx_bpf_task_set_slice() to set a non-default slice.

Why not passing slice to scx_bpf_dsq_insert_commit()? Is it because of the BPF
args limitation? In that case we could introduce a struct similar to
scx_bpf_dsq_insert_vtime_args.

Speaking of vtime, we may also need a scx_bpf_dsq_insert_vtime_commit() that
accepts dsq_vtime as well, otherwise how do we use priority DSQs with this new
transaction variant?

> 
> To support explicit token passing, rename scx_dsq_insert_commit() to
> scx_dsq_insert_buf() and add a qseq parameter. All existing callers
> preserve the original behavior.
> 
> This mechanism is intended for schedulers that do not implement
> properly synchronized dequeue. A scheduler whose ops.dequeue()
> synchronizes atomically with the dispatch path does not need this API.

I'm wondering if we should validate qseq also in mark_direct_dispatch(), it
seems that we're not validating qseq in the direct dispatch path, or am I
missing something?

Thanks,
-Andrea

> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Kuba Piecuch <jpiecuch@google.com>
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Link: https://lore.kernel.org/r/20260203230639.1259869-1-arighi@nvidia.com/
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  kernel/sched/ext.c                       | 72 ++++++++++++++++++++++--
>  tools/sched_ext/include/scx/common.bpf.h |  2 +
>  2 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b2741b6fb046..81483520f5cc 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -8315,8 +8315,8 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
>  	return true;
>  }
>  
> -static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
> -				  u64 dsq_id, u64 enq_flags)
> +static void scx_dsq_insert_buf(struct scx_sched *sch, struct task_struct *p,
> +			       u64 dsq_id, u64 enq_flags, unsigned long qseq)
>  {
>  	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
>  	struct task_struct *ddsp_task;
> @@ -8334,7 +8334,7 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
>  
>  	dspc->buf[dspc->cursor++] = (struct scx_dsp_buf_ent){
>  		.task = p,
> -		.qseq = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK,
> +		.qseq = qseq,
>  		.dsq_id = dsq_id,
>  		.enq_flags = enq_flags,
>  	};
> @@ -8401,7 +8401,8 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
>  	else
>  		p->scx.slice = p->scx.slice ?: 1;
>  
> -	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
> +	scx_dsq_insert_buf(sch, p, dsq_id, enq_flags,
> +			      atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK);
>  
>  	return true;
>  }
> @@ -8429,7 +8430,8 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
>  
>  	p->scx.dsq_vtime = vtime;
>  
> -	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
> +	scx_dsq_insert_buf(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ,
> +			      atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK);
>  
>  	return true;
>  }
> @@ -8518,13 +8520,72 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
>  	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
>  }
>  
> +/**
> + * scx_bpf_dsq_insert_begin - Begin a dispatch transaction for a task
> + * @p: task_struct to dispatch
> + *
> + * Returns an opaque u64 dispatch token. Pass the token to
> + * scx_bpf_dsq_insert_commit() to insert @p into a DSQ. If @p is dequeued
> + * or claimed by another path between scx_bpf_dsq_insert_begin() and
> + * scx_bpf_dsq_insert_commit(), the commit will silently fail.
> + *
> + * This API is intended for schedulers that do not implement properly
> + * synchronized dequeue.
> + */
> +__bpf_kfunc u64 scx_bpf_dsq_insert_begin(struct task_struct *p)
> +{
> +	return atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;
> +}
> +
> +/**
> + * scx_bpf_dsq_insert_commit - Commit a dispatch transaction
> + * @p: task_struct to insert
> + * @dsq_id: DSQ to insert into
> + * @enq_flags: SCX_ENQ_*
> + * @token: token from scx_bpf_dsq_insert_begin()
> + * @aux: implicit BPF argument
> + *
> + * Like scx_bpf_dsq_insert() with slice=0, but commits a dispatch transaction
> + * begun with scx_bpf_dsq_insert_begin(). If @p was dequeued or claimed
> + * between begin and commit, the dispatch is silently discarded. Use
> + * scx_bpf_task_set_slice() to set a non-default slice.
> + *
> + * Returns %true if the entry was buffered for dispatch, %false on preamble
> + * failure (e.g. @p is not owned by this scheduler). Note: stale token
> + * detection fires asynchronously in finish_dispatch() after ops.dispatch()
> + * returns. A %true return does not guarantee the task was actually dispatched.
> + */
> +__bpf_kfunc bool scx_bpf_dsq_insert_commit(struct task_struct *p,
> +					    u64 dsq_id, u64 enq_flags,
> +					    u64 token,
> +					    const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *sch;
> +
> +	guard(rcu)();
> +	sch = scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		return false;
> +
> +	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
> +		return false;
> +
> +	p->scx.slice = p->scx.slice ?: 1;
> +
> +	scx_dsq_insert_buf(sch, p, dsq_id, enq_flags, (unsigned long)token);
> +
> +	return true;
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_commit, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_begin, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
>  
>  static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
> @@ -10194,6 +10255,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_begin, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 5f715d69cde6..fb793008e2e3 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -63,6 +63,8 @@ s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
>  			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
>  bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
> +u64 scx_bpf_dsq_insert_begin(struct task_struct *p) __ksym __weak;
> +bool scx_bpf_dsq_insert_commit(struct task_struct *p, u64 dsq_id, u64 enq_flags, u64 token) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> -- 
> 2.48.1
> 
