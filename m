Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53D421246
	for <sched-ext@lists.linux.dev>; Wed,  5 Aug 2026 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948315; cv=fail; b=Z0s5dDHGP6w+tpAwfi05bZ3rGcynN+jkj7hyzjrKYRU1grvOPGGmJ+c+dA3C608UGL9JIFFB5GLCzyETBGkEndIueBoLCmqnA46d8bp/bxaENCQPc8Hdt4eteuCytxszpc5pLU/azy1usiGEtPGhQHqETmLHrHJ2dGjntQ30cjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948315; c=relaxed/simple;
	bh=zJ4UhCDv+Z2hbxpkyk+8OwWhTM/yY71UaoAsYbPtNlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LUb46hNGMXTsun5Hu6HOMxcFabESwdj2H3orRVzk3jtZf3cQ4T0Jz1iNihzWlK7Y+pHlNHEn7Fzskb+jEYIhwh5kbgGwSbi2K1Kfv645VH5LwTJacVPjmiNhJoC0y8xvPdpSUM96dGmBtdHcoqRjmwQ7s3RZ2mI8MkAr/6EJfiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OLnnjXk1; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OLnnjXk1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpxVriB/snmV151MuUS9z/pksCKsC2gXkGxc3ISjj6HIoOmeBlkb9Txsl43bEoxt5T6jdIPJ6Y1sKBHy6huKoIi2KfI4lCMk3ja/fKyquUwcgpuqBA9Q0zOLphNl0l1v7qiBCZfDghUYjR13yA8rX6Vw1Lv9slbRIhWZJaeqdGvkBsc4D6lVnledDsWm+gcbsQtZC8JkZ+3M6HfudwwQvf/pQNT8d1L/pE7dBhOGcRy1zZFwqMsZ1EaxdQDD4y9gHIuDOvlnB1OQEW3YXQ1TFZtuZ8un+5Vyb/YW4WybEGjMOew1HqL/e+HQP9jkpIOeVSltGKa/SITGzUdebcYT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QiT4kPMZRT8FJGPFIORGECm5esAJVMKopM7y8XjmD8=;
 b=agCA6JFXxt8JIJ5XacsazZ9PPx9TeTAG+htyk5dwxvvW3GnrRWKlpzyGBYlM0P+fVo7bKjamaHzAIX7ZoEkns25yx4DRCuJGy1j7MKjPGgmHH0AC+ouVXISfHOU4V5Ig3Y27WAZvfOAzmz47UflhRn0CmHT24utAI7vqi5Tph97PSa3jOy8N2AbgH32VHSmDQ/94dB35KUxr8VP+Fhtot4kkyQiWL0dNj2MQs96yOFO7Olo+AXVihaYvx5uuEdkQCJgxPLh8P2M0NQCEW03ac+c2X6pRQeXj5L0n6UuYcLzJMAg1y9uLGiklZVRYEUf7LbJSUt2QwG2gmJ4JFDLX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QiT4kPMZRT8FJGPFIORGECm5esAJVMKopM7y8XjmD8=;
 b=OLnnjXk1aGVTgwa9lSBovQLYn5DqbkyhVSpQ+atbuI/DxBg7ZUyfweIseVMZJEwlSBdbJ/elUiHjM248uHDP/KwjWrM0xiuqWPCa46/AQU64KqG5VVr+3/nZYhyJ0k3P0OpstBOOeE0Qww+SvZPqt4HFIBlqRRSOL6m/tSvrMHky917Vn8m3NfX/wbPcqNJdJQSmOerY++THwJu0cjGU1kyoeQnyszvaYkbgc2itybLf69FeHF+xBA33T8IoGkWj1SRMQR1VuU9Q8lsbA9Aa+LeFUWcX4w1XgBuH8iGGPwJnaG3KoqTNiuO683garMMu9rErv77yAjpn4zmgIT+BFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Wed, 5 Aug
 2026 16:45:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 16:45:06 +0000
Date: Wed, 5 Aug 2026 18:44:55 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
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
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] sched_ext: Handle proxy-exec races in remote DSQ
 transfers
Message-ID: <anNohzDzNEhrpvRc@gpd4>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-11-arighi@nvidia.com>
 <anEJ5xj2bhXg5GSf@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anEJ5xj2bhXg5GSf@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 912c045d-b91a-4b93-d9fb-08def310e767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0Oe5pauxkVe6KYQaUlY+oeuzTibcm914guVy0BJfVk0Dc0bzMgDqfjHwXQmRxtjBUTKB/oJfQPUWzoT1eRXpNS8YoGfkc61q7dc+Xc08eLqd3rh2SUUGhcnrib8tQTaIsPdzPM9x2SV6o8tD1ByiSP5u1tmNxvu1OYVa8MMo3Gfv7pyiu5AKWx7w4c0Oxgm2b6yTLRp80+1RmK63gueklGlpqLccHfCgLnMuSdOZA8az2jtqFB/kpvh6nua6TIVe8mZk0mv4/MHq67TgM+hHbuu0LqbtdEAW1/s9nDRao6Q3LaocJ+3bTDugNOQFysHfpFxZpeI6gKLFhhGqe7OtBL9g6bji1qLqTy7U3D3m6FqVgTEx7+Ww+z6aNZ2tDi53skhR4VbyJzlF0/PpOm7TIU92uPq9P6+rPiuIOTOjA/PVFqbNZ6g5r5kfDyfqcPKhVZ5MVzR0DvPrU4h0WpHXej+UZwN2CRIfeFc7vrZ0H0SdADrt96u3LwucSffXWefMV5EQo9Nh+bsBJEpU6pXlLTnn7rWXmBi2A0oNhQWDQil+UkiF2yM4nuPsoIDLs/HAEkzwrxsXrZ5ZFWH1mj7jcKY1CpFJCLN13anSA4b4Hy3oWnJtV8lmj1oTxWjYQRpgPWYvDY1fvdywyf0ikBdEQWzjzFKuRu3ZIVPZENKoV2o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5lqyaSlx4bYzvbYgmPEhSdIkqmM+zjzEMLbNMqGTfpK7KJHoNIqz4hAJ+iyg?=
 =?us-ascii?Q?SqOpfNretohQXofXGrwraGOdBfojHWKEfF2g/d2VyLiXjfgFOCff5FKMKaHp?=
 =?us-ascii?Q?rNd2W7+C9qsWA29wxeSjVLSWPclihGQVBhlwCMynlMwa4HRWdIZGhihK2VhX?=
 =?us-ascii?Q?4n20P6dW0BnSFR3Hd8ToAQG+nFmBYpS2fkn0lACOXQ3CObU5JTa/pmhwBlBA?=
 =?us-ascii?Q?hgnKHdWFTrPjJ08NL0YHWzUA4ywX5iD3g6rb9iye1LvrCzMFSAwN8b/9wKrS?=
 =?us-ascii?Q?w+FZCiNfJTdoehN42VzcaAIL0HtAREiuFRCp1N4wXVm06B1QfmCgPaSzCaCc?=
 =?us-ascii?Q?H9cWWopzmeYLWZ7Oc6S2zKq4oSF9ZG9jx/ENCg3zSyIiBgff20kmz7sbZ418?=
 =?us-ascii?Q?V3T7prW9w2o3cK9vN9Z8cLFcsG1UcrNP9Z3Hoe25ZET7GHmVs9E+Jav/hGUY?=
 =?us-ascii?Q?6ozBiJniip25f6bU2lQHj9PChH8R4qzPmaO4PEAK5NVGDpK7Qhu+/HdBbtsr?=
 =?us-ascii?Q?jmVEz2XgLRd77Fk6Vp3TBfipSmPg4E3dM8CrSKUCcxANwPNOtBwcbAwS4Vl0?=
 =?us-ascii?Q?z/LoybDmFEP6cBtYcqixunz5LSLiZ/oHW5IUfcsGOQvuISs8Ki4HDaQbvo9k?=
 =?us-ascii?Q?GFlS4yVKJ9rBp1yRRStOwASmAqVN4RU/8vTHGgMKMN50C1BtpqgTSd+izl9S?=
 =?us-ascii?Q?7lAKFrPqXVL0BbSEZg7bumwIVnj7LYc67uMG9U7WYW+ZYrAEyre6HVkt94bV?=
 =?us-ascii?Q?rodmfODRKU8P/f6eg/37fzjbW5NUWQj+R1bMR4K85LRw5ml6vuN/s4EBE7WL?=
 =?us-ascii?Q?my0AFDz5AZO5wOjXZD5P15nme6yyJAj/CkcMZHtS6B9fLDiGDrf35FI5JSxE?=
 =?us-ascii?Q?DbSCb8YEmeggA5de5O+I7xBcCmxpyMUX0r3IUuNde4g1LL1t2mWVCSc1Xw0f?=
 =?us-ascii?Q?qbhHmxCQAEU2bUaDXhlZ8fTdNc9BQFEP/4FF9wN92djA0mYMgEflFC9wKrLb?=
 =?us-ascii?Q?thu7N3M1bQcJGTilUBFZgG1yZ7hePc4HhQcpskBnSNsCoWOjOX0aM/1Qm5Fy?=
 =?us-ascii?Q?jCArQedv/l86Mhv4fM4AHgs/h1keulW7lhS8IDYOMUf/WBoj4k0Hu7g6Dg2k?=
 =?us-ascii?Q?f3a/2K4QRVqkhs4Zi1SvD0UKUbIy+pS8ztQOKAHzP/OAUcbBdrhAeiliUNQm?=
 =?us-ascii?Q?yZ9BHOlY+s68LyN54o2cYsH3VaPNmIly+XckXna40etwtLdJhxIhUNhrau6a?=
 =?us-ascii?Q?9GC2qTB+AXCiwJP1BQXZBns6B+dGB1oCgTZKDfyW/t0ED742dT8rtOXW28t4?=
 =?us-ascii?Q?geYol0BfjiLmTSGXe9OTYRY0bfsPJbMC+NuemYTekaD+nvLpD1dpiZ251ujC?=
 =?us-ascii?Q?IEDfq6LN22edKMSQnNed1FMrLZsAWNsYIigCxz/kPu6FQD5qc7vHBNAd4y27?=
 =?us-ascii?Q?KuwgZRfgwVy9RtsJK2kVeUc8IZ6sE8B2+cs02O94xy/T0cyH9jBYn7Nut0ni?=
 =?us-ascii?Q?24b1QW/+H6I262u7BgB9dtAgfKJngeNWGZ4aO4eHgyKh4EDwHcCjVCqO9XVG?=
 =?us-ascii?Q?iIwWKxNzeBchaO3E7M56nrursWEgi0eMEul84odPuZ8ucBAfceY6POZb3mme?=
 =?us-ascii?Q?cezjoG3qgHyfqs4cT992OD3J3mG/iCf0mikY1bAxzNsBswYbE4+Ru53LmttT?=
 =?us-ascii?Q?DAAFlimAK2pf4ykRDMneHai6i3XBFunwerxub4ubUrEPIvqOQHDE1BsN8gwT?=
 =?us-ascii?Q?bk/7YCVfPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912c045d-b91a-4b93-d9fb-08def310e767
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:45:06.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DikficeMakm1FC7Y72psAc3XqZg7h4Bo+Zh/D2AGyLQw7J0+VXpHftnLtJEYMQj7Jj0LDf13bbLKhZMKkalRLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371

Hi Tejun,

On Mon, Aug 03, 2026 at 11:36:39AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jul 28, 2026 at 05:43:28PM +0200, Andrea Righi wrote:
> ...
> > @@ -135,6 +135,9 @@ enum scx_ent_flags {
> > @@ -145,6 +148,8 @@ enum scx_ent_flags {
> >  	SCX_TASK_REENQ_IMMED	= 2 << SCX_TASK_REENQ_REASON_SHIFT,
> >  	SCX_TASK_REENQ_PREEMPTED = 3 << SCX_TASK_REENQ_REASON_SHIFT,
> >  	SCX_TASK_REENQ_CAP	= 4 << SCX_TASK_REENQ_REASON_SHIFT,
> > +	SCX_TASK_REENQ_MIGRATION_DISABLED = 5 << SCX_TASK_REENQ_REASON_SHIFT,
> > +	SCX_TASK_REENQ_PROXY	= 6 << SCX_TASK_REENQ_REASON_SHIFT,
> 
> Given that MIGRATION_DISABLED can only happen with proxy execution, it may
> be better to name it accordingly. Maybe that's too long. Do we have to
> distinguish between PROXY and MIGRATION_DISABLED? We can count both as
> PROXY, no?

Ack, both conditions have the same outcome: abort the BPF-directed remote
transfer, park the task on the source rq and return it to its owning scheduler.

I'll drop SCX_TASK_REENQ_MIGRATION_DISABLED and use SCX_TASK_REENQ_PROXY for all
of these cases.

> 
> > +/*
> > + * Proxy execution can change @p's execution and migration-disabled state
> > + * without touching its DSQ entry or clearing holding_cpu. Check those states
> > + * with @p's rq locked. Without proxy execution, the holding_cpu handshake is
> > + * sufficient and this must not affect the existing migration path.
> > + */
> > +static u32 task_move_reject_reason(struct task_struct *p)
> > +{
> > +	struct rq *src_rq = task_rq(p);
> > +
> > +	lockdep_assert_rq_held(src_rq);
> > +
> > +	if (!sched_proxy_exec())
> > +		return SCX_TASK_REENQ_NONE;
> > +
> > +	/* @p may be rq->curr under another task's scheduling context. */
> > +	if (task_on_cpu(src_rq, p))
> > +		return SCX_TASK_REENQ_PROXY;
> > +
> > +	/*
> > +	 * Reject only BPF-directed migration. proxy_migrate_task() may still
> > +	 * move a blocked donor's scheduling context to its lock owner's CPU.
> > +	 */
> 
> I have a hard time understanding this comment. Can you explain a bit more?

The distinction here is between normal task placement and proxy donor migration.

A BPF-directed transfer to a remote local DSQ performs a normal task migration
and, as we know, migration-disabled tasks can't migrate.

With proxy-exec, instead, donors can always be migrated towards the mutex
owner's CPU, because they don't actually execute there; it's the owner that runs
using the donated scheduling context; wake_cpu is preserved so that the donor
returns to its original CPU when the owner releases the mutex. For that reason,
proxy_migrate_task() should be allowed to migrate even when the donor is
migration-disabled or when the target CPU outside its affinity mask.

I'll expand the comment to make this more clear.

> 
> > +	if (is_migration_disabled(p))
> > +		return SCX_TASK_REENQ_MIGRATION_DISABLED;
> > +
> > +	/* Don't move an active scheduling context off its source rq. */
> > +	if (task_current_donor(src_rq, p))
> > +		return SCX_TASK_REENQ_PROXY;
> > +
> > +	return SCX_TASK_REENQ_NONE;
> > +}
> > +
> > +/*
> > + * Park a task whose remote transfer raced with proxy execution. Reenqueueing
> > + * from the source rq makes the task's owning scheduler choose its placement
> > + * again and preserves sub-scheduler containment.
> > + */
> > +static void scx_reject_task(struct scx_sched *sch, struct rq *rq,
> > +			    struct task_struct *p, u64 enq_flags, u32 reason)
> > +{
> > +	lockdep_assert_rq_held(rq);
> > +	WARN_ON_ONCE(reason != SCX_TASK_REENQ_MIGRATION_DISABLED &&
> > +		     reason != SCX_TASK_REENQ_PROXY);
> > +	WARN_ON_ONCE(p->scx.reject_reason);
> > +
> > +	p->scx.holding_cpu = -1;
> > +	p->scx.reject_reason = reason;
> > +	p->scx.flags &= ~SCX_TASK_IMMED;
> > +	enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT);
> 
> SCX_ENQ_HEAD likely needs clearing too. After applying the rescue patchset,
> scx_resolve_local_dsq() has:

Right, we're missing SCX_ENQ_HEAD here.

> 
> 	/*
> 	 * Diverting to rescue or reject, neither of which honors IMMED, PREEMPT
> 	 * or HEAD - a diversion has no priority and IMMED is not allowed on
> 	 * non-local DSQs. Strip the enq and task flags along with the slice.
> 	 */
> 	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
> 			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
> 	p->scx.flags &= ~SCX_TASK_IMMED;
> 
> We should probably factor that out and use that whenever we're diverting.

I'll factor this into a common helper and use it from both
scx_resolve_local_dsq() and the proxy rejection path.

> 
> > @@ -2533,6 +2617,15 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> >  
> >  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
> >  		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
> > +		reject_reason = src_rq != dst_rq ?
> > +			task_move_reject_reason(p) : SCX_TASK_REENQ_NONE;
> > +		if (unlikely(reject_reason)) {
> > +			dispatch_dequeue_locked(p, src_dsq);
> > +			raw_spin_unlock(&src_dsq->lock);
> > +			scx_reject_task(sch, src_rq, p, enq_flags,
> > +					reject_reason);
> > +			return src_rq;
> > +		}
> 
> I wonder whether it'd be cleaner if we just mark the task for rejection and
> then make scx_resolve_local_dsq() resolve that to reject dsq instead of
> directly inserting from each site. I guess the problem is that the rejection
> has to be on the source rq, not the destination one. I hope there's a neater
> way to do this.

Right, the source rq requirement is the complication. By the time
scx_resolve_local_dsq() is normally called, it is resolving an insertion
relative to the requested destination rq. In this case the transfer must be
aborted before changing task_rq() and the task must be parked on the source rq,
so that its owning scheduler/sub-scheduler containment are preserved.

I can simplify this by making the race predicate boolean, making the PROXY
reason implicit in the rejection helper, and using the common helper mentioned
above. The individual transfer paths will still need a small branch, because
they reach this point with different DSQ and rq locking states.

I don't see a better way to do this...

> 
> >  /*
> > - * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
> > - * scheduler chooses placement again.
> > + * Drain ready tasks from @rq->scx.reject_dsq and reenqueue them so that their
> > + * owning BPF schedulers choose placement again. Proxy-active tasks remain
> > + * parked until proxy resolution schedules another drain after switch-out.
> >   *
> >   * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
> >   * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
> > - * scheduler. The private list below prevents a task from being revisited in
> > - * the same round.
> > + * scheduler.
> >   */
> >  static void scx_reenq_reject(struct rq *rq)
> >  {
> >  	LIST_HEAD(tasks);
> >  	struct task_struct *p, *n;
> > +	bool proxy_pending = false;
> >  
> >  	lockdep_assert_rq_held(rq);
> >  
> > -	if (list_empty(&rq->scx.reject_dsq.list))
> > +	if (list_empty(&rq->scx.reject_dsq.list)) {
> > +		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
> >  		return;
> > +	}
> >  
> >  	/*
> > -	 * Move tasks to a private list so a task re-rejected by
> > +	 * Move ready tasks to a private list so a task re-rejected by
> >  	 * scx_do_enqueue_task() below isn't revisited this round.
> >  	 */
> >  	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
> >  		u32 reason = p->scx.reject_reason;
> >  
> >  		/* migration_pending tasks should have bypassed to local DSQ */
> > -		if (WARN_ON_ONCE(p->migration_pending))
> > -			continue;
> > +		WARN_ON_ONCE(p->migration_pending);
> 
> Why this change? Also, wouldn't this now be allowed to happen? During task
> move, if it hits migration_pending due to proxy exec, the task would be put
> on reject DSQ, right? Reenq can trigger from other sources before
> migration_pending is cleared and then would see the migration_pending set.
> Shouldn't it just continue?

Yes, it should continue. Dropping the continue is wrong.

migration_pending is separate from proxy donor migration. It belongs to the
generic affinity machinery, whereas proxy_migrate_task() moves only the donor's
scheduling context and does not use migration_pending.

If a task on the proxy reject DSQ has migration_pending set, the affinity
machinery owns its placement and will dequeue/reactivate it as necessary.

> 
> >  		if (WARN_ON_ONCE(!reason))
> >  			continue;
> >  
> > +		if (reason == SCX_TASK_REENQ_PROXY &&
> > +		    (task_on_cpu(rq, p) || task_current_donor(rq, p))) {
> > +			proxy_pending = true;
> > +			continue;
> > +		}
> 
> ie. Shouldn't migration_pending() be one of the || conditions above? And
> then if it's still migraiton_pending, that should trigger a warning?

I think it should be handled by a separate early continue rather than included
in this condition.

task_on_cpu() and task_current_donor() are resolved by the proxy switch-out
path, so they set proxy_pending and arrange another drain from
scx_proxy_resolved().

migration_pending is resolved by the affinity migration machinery, not by
scx_proxy_resolved(). Treating it as proxy_pending would associate it with the
wrong completion event.

Maybe we can structure it as following?

 	if (p->migration_pending) {
  		WARN_ON_ONCE(reason != SCX_TASK_REENQ_PROXY);
  		continue;
  	}

  	if (reason == SCX_TASK_REENQ_PROXY &&
  	    (task_on_cpu(rq, p) || task_current_donor(rq, p))) {
  		proxy_pending = true;
  		continue;
  	}

This keeps the task parked while the affinity request is pending without
restricting proxy_migrate_task(), which remains free to move blocked donors
towards their mutex owners.

Thanks,
-Andrea
