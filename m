Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991BD24336D
	for <sched-ext@lists.linux.dev>; Sat, 11 Jul 2026 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783758279; cv=fail; b=iKMiPJxlROs1T8qacI4sq4xHwd1VUqYit1ovpBO3KlknTFS2fcg62QhdELzWCqD4/dQMsQeXBh/6JaTQXR2AhZvBZ4Ub/ZTlWwEV9XODFQfQ8tjbmzK6WMRrsWQMsJ+JwFIpOmVQRk36OTU7IcMNftuSuY4yIaTZs0Z6BAFe7Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783758279; c=relaxed/simple;
	bh=Evf5DpEKinDlpChArvQYWRWz0vwjvNBykOMEIZAzPfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qua3dcFXaufnU01MbcEQisaHKEu+GUKeYgDH9mkkdqk8tnlcNjEBzFfCyB7oOuhWo+WPSFTOuYoZz4liZx5yuMOp31gWl6+AK37+5pl2AGxpCaei2M+qxQ2Psg9ynNGzE7Rodj7IdrEGyCyN2RUHxXSgGRPD7hZzr8jmeq9mlw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uLt3hljj; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uLt3hljj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbX78KYT8ugJzhHPB3QuvEJssJgOWyT3SmQaYi42fNe2lQznyuaIicOH7NYO7klliU8UD79JqhI6zZDpNTXQ92Kv3reNAzWyqePCO075ch1FeNEdLc0YGxZbQG7+hFD8Jk0Wx9R2zIPBPt1kHEb0wgYfeXVLdZeEV2lReHASOI31eWSFwYZ2q4YvNPdDb56tit10epWy6Oa7Ij41fuc/jkyQZRTvzZ9Z0LtysGD/ejo6Exd+xRAHM1eO2C8FH3f3O9BmCwV4QFXLGsJms47ANRpHXAx6Sg+wcEuZ8emAiG1/c5Tk5I8iRAmG95EobNW+llHeHnimMzyOEBeWUS3UBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKqd9NjBiejURoUYsFK1cPcbNxUGlb8EjVPlz4Svr+A=;
 b=cqQ+uH+zk34dl7yxmaHoO8JOjzu+qSbAoHTzmUW9NZgdGVlMnyClMJvidzz0oagpA8EaaizRUrAy7rSpE7C0NYtS4fsF+ZdKaNcJCtcG5RqJgTLGu/i79LxcUYDKSNH3/ndo4yp6l3f1tsTOZZPML+Z0op8AZp4Cfhc/h0SQfN9jd2twmLx+5IWYxg1pkD2c6XoeyUFNRVmmU+vfXiVChcXy5zHNqY/IMC31VuCZkMKdwWko2ZsNIyk7b7lFSFDpJcZzj9UwvVVpRnq30VBkfGZh6kI1gI2r+RfJGZlnn+uiAhw32jqxwmviksCE2mcVDzLAY0dqawYLuVDEFgffdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKqd9NjBiejURoUYsFK1cPcbNxUGlb8EjVPlz4Svr+A=;
 b=uLt3hljjGjABM30W3Zs+11EG2GD8nbMfJtLunTRlvvDRupk8YHKYWhzoQ8N/UClXEuI7ZP0PSF4EoccT1T4bmEdVJysRqXRgwJtS2ZqUSa6tzk+qZ+JNAVuPn0Hwe2uw4UUU71cy7CO1v6zkPNLeQf4SPwrwBvGo54v7KLQ6qZVn363b+vmyLGQn+vlqowjR/NTIU3Uru8hLNUF4CBnuMEQBZCJBtwcm7PxO30pujm2KRzXKDDLbqyi1sdFw3ixQWDsSyOq206Aay30ZjxHQzZPThq4brNuK2RR4rqqmAcMspqaoiixF/20gYRT9RSabNbFB+RC2004ysxT7ZAOGAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Sat, 11 Jul
 2026 08:24:31 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0181.016; Sat, 11 Jul 2026
 08:24:31 +0000
Date: Sat, 11 Jul 2026 10:24:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: John Stultz <jstultz@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH 06/10] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <alH9sy7Fnsp8GSSH@gpd4>
References: <20260710083913.30573-1-arighi@nvidia.com>
 <20260710083913.30573-7-arighi@nvidia.com>
 <CANDhNCr2eTjjvFv-iNwD-XpStibW_NwyR7Zg+5Zh20mEuPsQ1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCr2eTjjvFv-iNwD-XpStibW_NwyR7Zg+5Zh20mEuPsQ1w@mail.gmail.com>
X-ClientProxiedBy: MI2PEPF00000B77.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40b) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb45ebd-6758-4117-cf31-08dedf25d3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|6133799003|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	7u7k/4J56L+fi+w1XNG1BWi80Xc7ufW60IeqZ2AfmQI83kYvko2npu6Fid6ZVtvbPAYN0xai7/W61x55khlh3jV0KGdk2sQaFJIMsBurlEI47hhbmdYBvF3/WWuFwjHyXYa4SPkbB4USGHBd0HqQUAB4tFfuTMDiuCckC0yN8SImDsRvDLz0r6ZkHJ3lyAMYjWaijj9GAL9BadGiUv/vlFvOxvvk2tumhDw0xriZceslLJwuEZqlzqIP5ISuuyctTEThx19N66xgab+1mGTWjYKXrNFcfh1K8UOnXU2YMZ7XznYU2Wy/79MMRcvbNgv6JidTL+NoZbLSdrW5wP7Qb9j0JdWrzmyu9JmwFJtCvmNssvEjsxGqoFh0nzWB7lc9i2ndisYpFHBz9x5O90R5L6xHbw04fNWgZPvLyX9cmeMRFa+aqYO925I9d2HR8fBwh1OAUpONv5Uzt41ggIEQY371xjOv29FoecUAf4eiaNvHYsOmfJafLhEm5GRcR9Pkrg9ExGIrW2cnQVqKqz7yosp3kqzNw0zurlBSI/15vWDmRAYT1PBOPmmcFwOjnP71pQso+CAglm5VrRrOEh+j9cayjncEZlm6WFDiu6d2SFjcFMIJwF7pXZeLNLzENA4fo+XTQB3MlZDnSlYxxAwiUJKNgpfA1otw6SyoDGiy07Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFU4RE5hM3dpK0djK1ZBZ3RDZUF1em1FdGtPSnRUTEZhbE00VlZtejBzdVJk?=
 =?utf-8?B?cjk0ODRZVnZ3VTNPZmJISGZ1eDQzbC80TllUaEtyQndyNTIvc2NYVnlzRmJo?=
 =?utf-8?B?dFJwZTVnZlFkdGZtdUduVTZMR1BibFY2VDZqMTdWZVZ3eGwwdkFDME8rUEc4?=
 =?utf-8?B?K2JjTGx4c05jQzlOUTBWOXlCSW9tOU8wSUNxejFWdHMzbG9JNmNyMThrbnlv?=
 =?utf-8?B?dUdiRTNkUGR2SjBJVUdOTkU4dlNQNzhOWThHUk1hUFlLOXBwQ1NIK0JFTUpJ?=
 =?utf-8?B?cU5SdHR1UWdnMzZKYnJIczQ5azFLenE3blRXcFp1SmRCalZ4ZUc2TGpxWWJk?=
 =?utf-8?B?QkpIclNhVi9aQmhielVQQTl6ak1KL1ZBbDhSb29RWlNMTWU2N3hqL25QNG85?=
 =?utf-8?B?N0xFREg1d3VaeDM1OFlqdnl2ZldxZXJZQzU0cEZVWktoclFrdks5QVBML3FD?=
 =?utf-8?B?Z1NDNnBVbm5lVVo1ZkI3WmQrZjJ3dWRXNGlwbGdjOWRTbldua294R2hNeGRx?=
 =?utf-8?B?ZUpTU2dMTzRQSkFwNmhtODUwamxaaTZtZWh1M3oyMUMybmVCQ3paMGZiK20v?=
 =?utf-8?B?UUFmc2xDYWpsdmw4bTgrajMxSkx0TkJUTXJmQittQ0FPZEFOTnV3eStKU3Vu?=
 =?utf-8?B?bGRrSmovTDVYeFZkMWluanNzMm9oZWQ4ZkdJdmFsZ0xiSnRzV3hKSExlWlZU?=
 =?utf-8?B?Q0NsSC9XQ3BpUTRPUzJYdFg5TSthL1RhOTJOa1dpR0xMTG5oWTF1bDdBN3l4?=
 =?utf-8?B?ZExTc2hGNEZQQ2VtV0Z3bkNvdWhWY0NwN21PdUhVS3poZDJWRGlvckp5RFlC?=
 =?utf-8?B?cTJUVVRHMkpDU1M1ZnkrVHA5b052MkQ4OEhENkZrRlZlN0NnRVhlYTFoZ3pl?=
 =?utf-8?B?SG5hck5abkhRT0Q3TmVWUFRxc2pLbER3Q29TRk4yOGF4VWVoVzlRWlNLdFJt?=
 =?utf-8?B?clh0LzE1Q2lCZ1gzc0pVYVJCRC9LQ013dnFpbUQ2a244OUcrSGJkNGFVTU4v?=
 =?utf-8?B?ejhsQXVwTmxiQTdhY29RT1o3NmtxRFRSd1lPWmxJTVV3K2tpOHdWTG5IOVlL?=
 =?utf-8?B?VzA4Y2NRQjJpZGN4VmlVbGlBbjZSVmxSNEJIdWVETEo1L1Q3TFRTcjIzN04w?=
 =?utf-8?B?V0U4ZXVQNzlHaGZ5cDdRU2hTRnlJT1FhZG9jRTBiOTZVQlJwY1kyTnFUWDNa?=
 =?utf-8?B?UzNvMDRaZFBHZmRSVjE0S05JZzE3aGh0ZG85MlZWWHIxQzZJVkFFYkZ4NlBr?=
 =?utf-8?B?dWcxaHV3OW1rcmc1VTRMenhZK29EcVBadkJUelljWS9CVUZkdkdodDFjbXVD?=
 =?utf-8?B?bmQzL0dwc1dYTGQwQ2t6Z3VaQnhvWldHZzFWVHZFdTVMbmNicVczYzJSTkFm?=
 =?utf-8?B?S1d3cjRRMnJENzFId3ZzNER2c3FndkZ5dEc0T09FWmRIOGg2aEpFMFRXWlNv?=
 =?utf-8?B?amFRMVFEamM2b1A3enVLaFd5dStWOGNDZjNHS2g1bnA5VEVNQmNaTkl5S0k4?=
 =?utf-8?B?ZnlQbUJGYnVpczdlVXRVdzFOSElDc3ZMcDNQVUtVZE1EYTQwM256ZVVwMVps?=
 =?utf-8?B?ZVF0SmQxRnRQWG1ieFMycEI2eVB5Q0NRNWRja3N1bFI5M29OMlZUVjVYN1pm?=
 =?utf-8?B?NWpGQnB4cFI4WlcvME9heDgwM2M4aUYzUE9JTUZwUnZVK2ZpSmU4Ry9wTUl4?=
 =?utf-8?B?MDBnQmZac1JUSWRvbUEwQVNLeFJhOGJ2ckhzcVVobkw4Yi90L0hyaHZSWllv?=
 =?utf-8?B?ZkRqZzdKK1ZUdjMra2IrUklyZ0tidnVaMTlGbm5HN1dTeDM0dWRnQlMrRlhF?=
 =?utf-8?B?cDltSU5jZWR6dDVyNGliTG5abzB1YmVaQVIyYmdkK1Jta0ZISjV6SStZZnZW?=
 =?utf-8?B?UWIxRk9kVkVXRittU2RSblAxYXFhNnB1MjR6TTFwMDN5QXhqNTE2T3l0d2pi?=
 =?utf-8?B?bTlBKzZBM0lOcGxpYjg1T0NSeE5FUnZLbDJFWjNHSnBrMStaeEg3dE1SWU9z?=
 =?utf-8?B?QlBTOS9tNFlaMXU5bExuMkVEbTRybFNqYndmUy9FVTMxRWNqLzlCb3VLUjdj?=
 =?utf-8?B?c1BHenkvUzV1Q0hnTDkrTXRpOFdDamNiNFZIUjREdDdVVmpVL0hma2hMb042?=
 =?utf-8?B?K3RYL1ExWFpTVFNPM1RodGJUUmJtNHpjSWd3SjdERWNlWGhBQ0JIb09FUjBz?=
 =?utf-8?B?YndLZjFabTJnaXFlcEhneEIvMk96L2luQWx4ZkJxbjZnd2pJWnhScXJWRGYz?=
 =?utf-8?B?SEF6K0d4V2hKVTZiZkNLMzFnYnYySzdScmprcHloVFhmVVhSM3VDd2UrNVVj?=
 =?utf-8?B?ek5qb0RFYUhSdm5oeUNpckhwVkprMFN1NVBxbEFYaGoyQVZieGkwUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb45ebd-6758-4117-cf31-08dedf25d3ca
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 08:24:31.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKPfOYEV2WJWjX3PueIQRXhLb8U6umFAVOrYMKLnCjLpxTZlGGam/28XcRjPyCGZM+PzoPAt9ZjJkdJfQ71xmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965

Hi John,

On Fri, Jul 10, 2026 at 06:43:44PM -0700, John Stultz wrote:
> On Fri, Jul 10, 2026 at 1:40 AM Andrea Righi <arighi@nvidia.com> wrote:
> > @@ -2866,18 +2938,12 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
> >                 set_task_runnable(rq, p);
> >
> >                 /*
> > -                * Mutex-blocked donors stay queued on the runqueue under proxy
> > -                * execution, but the donor never runs as itself, proxy-exec
> > -                * walks the blocked_on chain on the next __schedule() and runs
> > -                * the lock owner in its place.
> > -                *
> > -                * Put the donor on the local DSQ directly so pick_next_task()
> > -                * can still see it. find_proxy_task() will either run the chain
> > -                * owner or deactivate the donor so the wakeup path can return it
> > -                * and let BPF make a new dispatch decision once it is unblocked.
> > +                * Mutex-blocked donors only stay queued when their BPF scheduler
> > +                * enables %SCX_OPS_ENQ_BLOCKED, so always delegate their admission.
> >                  */
> >                 if (task_is_blocked(p)) {
> > -                       scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
> > +                       WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
> > +                       scx_do_enqueue_task(rq, p, 0, -1);
> >                         goto switch_class;
> >                 }
> >
> 
> Just FYI: So in doing some testing running my priority-inversion-demo
> test in a loop with this series (rebased on 7.2-rc2), goining through
> the example schedulers in tools/sched_ext/ I hit this WARN_ON after
> running awhile with the scx_pair scheduler.
> 
> Haven't done much debugging on it yet, may have to wait until monday,
> but the splat is below.

Yeah, this is because put_prev_task_scx() uses task_is_blocked(p), and we should
use p->is_blocked instead, since task_is_blocked() can become true before the
task has actually been processed as blocked by the scheduler.

I've fixed this in my local tree, this should disappear in the next version.

Thanks!
-Andrea

> 
> thanks
> -john
> 
> [25733.271828] WARNING: kernel/sched/ext/ext.c:2945 at
> put_prev_task_scx+0x449/0x460, CPU#0: foreground/25080
> [25733.277072] CPU: 0 UID: 0 PID: 25080 Comm: foreground Not tainted
> 7.2.0-rc2-00043-g9699f4add4b0 #39 PREEMPT(full)
> [25733.286458] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [25733.295933] Sched_ext: pair (enabled+all), task: runnable_at=-798ms
> [25733.295937] RIP: 0010:put_prev_task_scx+0x449/0x460
> [25733.306251] Code: 48 8b 83 68 11 00 00 48 8b b5 10 04 00 00 48 39
> b0 98 11 00 00 0f 85 79 ff ff ff e9 65 ff ff ff 90 0f 0b 90 e9 46 fe
> ff ff 90 <0f> 0b 90 e9 b5 fd ff ff b8 02 00 00 00 e9 94 fc ff ff e8 90
> bb 2d
> [25733.322497] RSP: 0018:ffffc90011f7faa8 EFLAGS: 00010046
> [25733.325750] RAX: 0000000000000001 RBX: ffff8881b8e2db80 RCX: ffff8880bd482650
> [25733.333460] RDX: ffff8881b8e2e618 RSI: ffff8880bd482650 RDI: ffff8881073b2650
> [25733.338640] RBP: ffff8881073b22c0 R08: 0000000000000000 R09: 0000000000000000
> [25733.344710] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88800ba23000
> [25733.351179] R13: ffff8880bd4822c0 R14: ffffffff82f6a518 R15: ffffffff82f6a040
> [25733.356585] FS:  00007f9badd90780(0000) GS:ffff888234841000(0000)
> knlGS:0000000000000000
> [25733.362523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [25733.365426] CR2: 00007f91f1e48110 CR3: 000000001113c006 CR4: 0000000000370ef0
> [25733.372285] Call Trace:
> [25733.373817]  <TASK>
> [25733.375178]  __pick_next_task+0xa8/0x180
> [25733.378968]  __schedule+0x268/0x2600
> [25733.381092]  ? mark_held_locks+0x40/0x70
> [25733.383556]  preempt_schedule_notrace+0x43/0xa0
> [25733.386311]  ? preempt_schedule_notrace_thunk+0x16/0x30
> [25733.390954]  preempt_schedule_notrace_thunk+0x16/0x30
> [25733.395476]  rcu_is_watching+0x3e/0x50
> [25733.397722]  lock_acquire+0x2c0/0x310
> [25733.401168]  ? _raw_spin_unlock_irqrestore+0x50/0x60
> [25733.404224]  schedule+0x9d/0x100
> [25733.406428]  ? schedule+0x7e/0x100
> [25733.408130]  schedule_preempt_disabled+0x18/0x30
> [25733.411008]  __mutex_lock+0x800/0x1100
> [25733.415788]  ? __start_renaming+0x5d/0x190
> [25733.419011]  ? lock_acquire+0xd9/0x310
> [25733.421518]  ? __start_renaming+0x5d/0x190
> [25733.424188]  __start_renaming+0x5d/0x190
> [25733.426676]  filename_renameat2+0x318/0x420
> [25733.429258]  ? find_held_lock+0x2b/0x80
> [25733.432581]  __x64_sys_rename+0x48/0x70
> [25733.435240]  do_syscall_64+0xf3/0x6c0
> [25733.437675]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
