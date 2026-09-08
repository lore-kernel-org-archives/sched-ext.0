Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991034B437
	for <sched-ext@lists.linux.dev>; Tue,  8 Sep 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860589; cv=fail; b=tGNK2QNZ810hHrz5kvAg42+QfXpsVkdbuRF5rRRWEGWrSlTkcdKZzqnyxWb64POQk7qp/yFFsviiowVpaxRm0e2zsI0es39uXcGkazKLngckHi4KHvkfpsDX8ndcBzP+qAOTi4bwXfeweWYygINUTcntBlfXFCwr5BC1Sz7XvX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860589; c=relaxed/simple;
	bh=4Gvj2y0U7AJVyw+B3nd4+zdMyDcCPZCkP/A2TiQkIDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S98uEK8KfcSVrnVLaPeKCTFiPqqE5bKncyxi9iP4rGx0JCintlWn3Gcfsx01oLULNcJi5UPGg86AFoxYqEate4H7Mcx0loB6QG/l/+UD8Pnj6nEDyCxRVd1QfnJu/Rk+d38wdFC0FPGaH1ICfb9DFegwAU3NLWNhHg0XXY23Jak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cWOY6Zxn; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cWOY6Zxn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ/ERNS/Ar5V1X4hyIxemEa/O+JnUWzV1JuURqSzm7PdSSgAmUi30MwAGq2/Gs/+AnoLrMNayZCYsZZ/MAqPuYmt9T//TkeidqrHCoiscZun4fbf7Sj6pRvBz94wvXfRe3rGcozwrJ77P593Cc/l+X1+2GCbB1174lm7vnHYcDqZ7RzcxFvzlkEOMMXFFnNPWkxsn7eVBcm/8RIBttO1QHaDZFclwOC3/FWUceXOqh0rOZX6vwWI6+IkvfhVIW/P+ctDsq60MW/DO4lt4yFrPkJ5ytgQq8hdVZMQMnIewvJn29kzshthFqlXlAzvFgCzgnEUUDlq6PINz1lfTLB5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+B9JbLkECntDfgBbMoJ0BMZXk/374l1z3+awr1EfTs=;
 b=Kg1ylcwtnOWJUSG0Vk2bX/6BvpMk/ZjcEctItIijS7isiSkWqGrkCQL1yP5wQir81aHQCLLvocIrKOsqsx+mJ30MtGCGExuXQpC3p6jkRHsS5ZlasHi/j3VKfj9DqDEdLieX8wmslJB1qk+Y2YFANV7x6IFcwyRCkS+xIIQOLftIjb5S5uqL69Y6OP+X3kk4hi2i5Xfg2gRJED+VhOfLhu3SE2OUHL7dSOZhEVbSaNnu5zeA/DJ+yoKHBHo/UucEKIY+sNfdaujaqzDwFQzN4Lz9Cg17smaPlMehddr2Li1GCG9OK4WI9xD+nLaY7Xv/k+4nnNC2U9Cm9JGaQJLvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+B9JbLkECntDfgBbMoJ0BMZXk/374l1z3+awr1EfTs=;
 b=cWOY6ZxnjEwdrIoK6NEMl9g+CJKvkgMif2gD84a9ZmALv1xJD5J5ehA+z7RTy5XbJxzmMk3/5OiA43oxi6x8QBjEPuDrBc1azwKZ6EsPtmgF7gC05WDJeEXZh/1SdXGXcf5SAJ8ZNK0JKvOHuvisiAhdE+hk+b8PAE1+PbbaT87372mFwQqVU03zpxJcM7FHf8AUOYnDtzUSK8Y63aBKdF01IV+82H+hMeSfOpfj0Vy/u9yzKrAmjjISTfYOIFbtFIxwPOzGGm2oxAJXd+tk2dDkFkOyV2u+Lpok2Vq34YPGOSIZ6m/UmNf0HFPWQxW1ga6lk0KyfiefFCfg89fKog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 09:43:01 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 09:43:01 +0000
Date: Tue, 8 Sep 2026 11:42:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] sched_ext: scx_qmap: Add proxy execution support
Message-ID: <ap_YneRnbmk_ZYeQ@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-18-arighi@nvidia.com>
 <apaDOhiWKcLH5iQt@MWDK4CY14F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apaDOhiWKcLH5iQt@MWDK4CY14F>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: cee9a495-2770-4551-d5ea-08df0d8d9279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|6133799003|3023799007|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XA+uHLXnhddgsFMENYVFObDkRrAE5wAqaClSph/UX6fe0fl/n8yme+VRZp3DhXKYP+i8I5yTW/3JR2m6yszRZZwZCN8CiFLepECjrlEZU1SCk+C/o1yN/RcaJgdGzSYziI49AGVhiDShp0j4t/qPa65OHfv9CFCqqEysKZZpSTsZ77BmNUvsYujR3WyGi0i4XYSa3PYjPch/UlkBfqX5W5lAg3IHbOVEWSBWRpG1MsE+LEX1NIXXZl5Sd5mPrrLIePdoNspTj1dM8afcRfogV1KeDH4VQ14+r3pajRhdEvidxJN0TtMvf3XIPKAm3VF2Ia5LTGc2zuhMGH5sPIU+aVCJkHGuQXY4S+Zp2F5knXZxT2EknLcxCZIXS3axQdcl/M9klZBfjh2I/DxvK0ndPHu5twGqHpJvH0IUo/sLz+iSudi0BXKNDJpaaNbGgICzXadUBMBKO/kXIdddAH37SLsdpLULEML0L4lV1GV0akHZpwKTxJaHtmjIy4T0TSkLI61ncQ+/KV2SnahrWTCYMKS1oN3stbvKoCL+UbRfiM1vNeGagFMFjlPI8FPGf3+VMNiNpUE74V+iUh4R0YW2r3VYEybc+F7yL26bSFa67rSCQJnLtkLzXNQXsfH25QRxolh9veAmd67OXGPg/NgLKwI1At8rNEC5FMjCJKsAwvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gZ/izeGmmlVi/JEOhNaaMEMwuvVwZUnpfdDdoG6ZCqZr4z9r5HH0eZaG2IAL?=
 =?us-ascii?Q?fnI0yVeW6aGIB4PL9sgS/HjXa3KrhTvpu+SpbRmBYvgf6xxWJZg2HuFzFjli?=
 =?us-ascii?Q?xzfmqIvYbHsxBULFCXdUbPMOZL0+UtEQTXVWWP3mVoP28sB8VQTnWCM0GV3T?=
 =?us-ascii?Q?cQOB8KITN5zZ7ywVvtwW8xour5IJYLk8rMsg5aHGDvs5ARlObNhdAgKdnEUc?=
 =?us-ascii?Q?ohmBAgWvkhilKyv1yAnKRKxFbhUUtG25JMsYyI/VNoxVASzu8TRJUlD3x5Xq?=
 =?us-ascii?Q?iFRE9p5xppmEPc5qmw3vImwb51fF9Pma7nBwwBGf+T8jPCnfD4M+ShayTO4s?=
 =?us-ascii?Q?d3d7VdQbcyHIIQ+Ar2ggZfgiiBT5gi6yFtzKQPTsUPif/gPWDM6rmzGRajOX?=
 =?us-ascii?Q?LBcXRi+5kgA42wAfmBSt1gm3KcbGsZcOJ/4719aze0OQHbWtk5AF9ZAzMNlA?=
 =?us-ascii?Q?FNFcSPrJu6mKOi6eYU7e5TMR90o4QaHSYU4uZ0aY+nP0Xa/XwcAWHdum3RTX?=
 =?us-ascii?Q?rzWMP+IR9YEtCdlMT9EWWMW4n9kaEBllpXoXxExRLJRQsgaXefKDO6+bUEVP?=
 =?us-ascii?Q?OcjJNpwfCFi9dst4wrjhRJ/MWi2Osk05J4A0c4SmuNSAhfX2NkuJJ09ad6jq?=
 =?us-ascii?Q?7RhqqyWBAXo1nJuecxpAWGw1coArxxc1byhopCgW3sM8mysbcOdgxjZuPWOr?=
 =?us-ascii?Q?oU9dD0UGDhmFjN+o2ouBwldAkwWHJAgZSMKxLF/QiXTurdR+ZE4M/sW68kRT?=
 =?us-ascii?Q?SfEkZpgFn/hUDLWsEyeATQlK/hiLBALhBsF1pQ+M6Ut4qIKWtPokddBn1hvc?=
 =?us-ascii?Q?MTYm0T35zJSOmYGO0JBr3WxokIEGx1pE2Ncc1PY0narinUKKKvv9u8E9i4Ax?=
 =?us-ascii?Q?fbiysObW+AbqQ/yWYGp+PnIbHwV26IF+i6CWvOLnsfN3DFgiEn8kTF5fmYJ+?=
 =?us-ascii?Q?/1ltgRztg2+kwLm7jR/RWxocG6+XdTILFluAMLF4oXuChbBnwHD37mUw0XuR?=
 =?us-ascii?Q?Jnir4WpeDi8Qg9orapRgLzww+4eDFGebhIFw0IQA73FOsG2a07Dg+OnJgOti?=
 =?us-ascii?Q?w7S+A5OKq5PYtJ+mVYnmn8o0XHJEzCPnouairgxZ7XGfxl5//JDcPZ84QzTl?=
 =?us-ascii?Q?SBgEQWeL5i409306i8RdJhhNdwsra672Fryt6/Q67r4UETy5EbuSp9y5pkrn?=
 =?us-ascii?Q?iv5v6aYIGdmFhuCh9W5FmkxTlNpAYZCU11g3meeIPoD35BpKRxujKX7Sc6Mz?=
 =?us-ascii?Q?scR1Y7cs1n1KWx0o6di5iSNKhZbc49kR7frfHoCLuWrGLbsCGIzk5kjVj2uH?=
 =?us-ascii?Q?aKrh7uhVlKVRsWGPSCe7gusBw4sMlBDsX9xhJGpuIaM/qZf0O2FlwA6AaOTI?=
 =?us-ascii?Q?JszraLVHp2cMWfcfHqJQT0FFbkbnC/iaJTH9UWTT9Wrax3gxAhAIEEw3iPuZ?=
 =?us-ascii?Q?mHXLhXOoKYGy3FfMl0JHzLL2BzT4Um8u7AFx/lMTwKTQZRLbUyGoXuObl9jX?=
 =?us-ascii?Q?2vcft29E0rIZFw3kn6k8Ymp/6ByNLylN3xz1k0TJPM7laYL1U/LUTIJtDcN8?=
 =?us-ascii?Q?n/5SO8XD8t4B8Std01/9NCkbZ5Nh51I7hV3luZjNkidEdCT29FdnstwEILjG?=
 =?us-ascii?Q?t0LgnsJXHVaELcf5ZduB8s2PlcPt86BVCOappsaxjBmZsvWLw3QVKZWkTeti?=
 =?us-ascii?Q?ZFrrhJJBY5HaOXA/+yjQ9IVcqMMwAlQyoKtRNVkNsbx5K7bk0dCDP8FNZ+4n?=
 =?us-ascii?Q?6POkbmrK5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee9a495-2770-4551-d5ea-08df0d8d9279
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:43:01.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEywmoWKTdCTnFka1y3/0R0phfv6o7IA1vVya5E8vV0sr+tlJEnfjTDh79ntCoRJD65L4OKpL0VjUdPE/+OlaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

Hi Richard,

On Tue, Sep 01, 2026 at 03:52:05PM +0800, Richard Cheng wrote:
> On Mon, Aug 31, 2026 at 03:42:27PM +0800, Andrea Righi wrote:
> > Add a -X option to opt scx_qmap into queueing mutex-blocked tasks for
> > proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
> > and mutex waiters block normally. With -X, blocked donors are passed to
> > qmap_enqueue() with SCX_ENQ_BLOCKED.
> > 
> > When scx_qmap receives a blocked donor, select a cid allowed by the task
> > and held by qmap, preferring its current cid. Dispatch the donor to that
> > cid's local DSQ with a fresh slice and SCX_ENQ_PREEMPT, adding
> > SCX_ENQ_IMMED when the cid is time-shared. This places the donor at the
> > head of an eligible DSQ and requests an immediate reschedule, allowing
> > the core proxy-exec path to run the mutex owner using the donor's
> > scheduling context as soon as the donor is selected.
> > 
> > The blocked policy is intentionally unfair and can strongly prioritize
> > tasks using contended mutexes, but scx_qmap is a demo scheduler and such
> > aggressive behavior makes proxy-exec support easy to observe. Count all
> > blocked dispatch attempts in nr_enq_blocked and report their per-interval
> > delta.
> > 
> > Acked-by: John Stultz <jstultz@google.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  tools/sched_ext/scx_qmap.bpf.c | 53 +++++++++++++++++++++++++++++++++-
> >  tools/sched_ext/scx_qmap.c     | 13 +++++++--
> >  tools/sched_ext/scx_qmap.h     |  1 +
> >  3 files changed, 63 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> > index 5bb8b90a275a3..21f8a9be9650c 100644
> > --- a/tools/sched_ext/scx_qmap.bpf.c
> > +++ b/tools/sched_ext/scx_qmap.bpf.c
> > @@ -439,6 +439,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
> >  	 */
> >  	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
> >  
> > +	if (enq_flags & SCX_ENQ_BLOCKED)
> > +		__sync_fetch_and_add(&qa.nr_enq_blocked, 1);
> > +
> >  	/*
> >  	 * A task of ours that can run on none of our self cids - the parent
> >  	 * didn't grant them or we delegated them to children - would starve in
> > @@ -446,7 +449,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
> >  	 *
> >  	 * Force it onto its first allowed cid's local DSQ. If we hold that cid
> >  	 * it runs. Otherwise the insert carries SCX_ENQ_RESCUE and the kernel
> > -	 * diverts the task to its rescue path.
> > +	 * diverts the task to its rescue path. Do this before the blocked-donor
> > +	 * fast paths, which also require an eligible self cid to make progress.
> >  	 */
> >  	if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
> >  		s32 c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
> > @@ -460,6 +464,53 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * SCX_OPS_ALWAYS_ENQ_IMMED makes the local insertion below implicitly
> > +	 * carry SCX_ENQ_IMMED. If the CPU can't run the blocked donor immediately,
> > +	 * the core returns it through ops.enqueue() with SCX_ENQ_REENQ. Inserting
> > +	 * it into the same local DSQ would repeat the IMMED handback until the
> > +	 * scheduler is ejected. Move reenqueued blocked donors to the shared DSQ,
> > +	 * which doesn't carry SCX_ENQ_IMMED, so another CPU can consume them.
> > +	 */
> > +	if ((enq_flags & (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) ==
> > +	    (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) {
> > +		taskc->force_local = false;
> > +		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
> > +		cid = cmask_next_and2_set_wrap(&taskc->cpus_allowed,
> > +					       &qa.idle_cids.mask,
> > +					       &qa.self_cids.mask, 0);
> > +		if (cid < scx_bpf_nr_cids())
> > +			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Insert a blocked mutex donor at the head of an eligible local DSQ with
> > +	 * a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate reschedule.
> > +	 * The test above guarantees that cpus_allowed intersects self_cids, but
> > +	 * the donor's current cid may have been delegated to a child. Search the
> > +	 * intersection starting at the current cid, preserving it when qmap still
> > +	 * holds it and wrapping to another eligible self cid otherwise.
> > +	 *
> > +	 * A self cid may be held exclusively with SCX_CAP_ENQ or time-shared with
> > +	 * only SCX_CAP_ENQ_IMMED. Add needs_immed() so either kind can accept the
> > +	 * local insertion instead of rejecting and reenqueuing the donor for a
> > +	 * capability miss. Once selected, the core proxy-exec path can run the
> > +	 * mutex owner using the donor's scheduling context.
> > +	 *
> > +	 * This policy is intentionally unfair and can strongly prioritize tasks
> > +	 * using contended mutexes; scx_qmap is a demonstration scheduler and
> > +	 * this behavior makes proxy-exec support easy to observe.
> > +	 */
> > +	if (enq_flags & SCX_ENQ_BLOCKED) {
> > +		cid = cmask_next_and_set_wrap(&taskc->cpus_allowed,
> > +					      &qa.self_cids.mask,
> > +					      scx_bpf_task_cid(p));
> > +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid, slice_ns,
> > +				   enq_flags | needs_immed(cid) | SCX_ENQ_PREEMPT);
> > +		return;
> > +	}
> > +
> 
> Hi Andrea,
> 
> Do we need to do serialization between ops.enqueue() and the paths which rebuild qa.self_cids.mask ?
> 
> IMHO, appy_partition() can clear or rebuild self_cids after the check but before cmask_next_and_set_wrap().
> If the intersection is NULL, the helper return CID, and then the value gets passed to needs_immed(), hiwch uses it as
> an index and do "SCX_DSQ_LOCAL_ON | cid". This will be an invalid CPU.
> 
> Maybe do "cid < scx_bpf_nr_cids()" before using it ?

I think you're right, the mask can change between the intersection check and
cmask_next_and_set_wrap(), so the returned cid needs to be validated before it
is passed to needs_immed() or encoded into the local DSQ id.

I don't think serialization is necessary here. If ownership changes after a
valid cid has been selected, the core's capability validation should handle the
race by rejecting and reenqueuing the task.

I'll add the bounds check and factor out the existing rescue placement.

Thanks,
-Andrea
