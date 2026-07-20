Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8853B5E08
	for <sched-ext@lists.linux.dev>; Mon, 20 Jul 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563323; cv=fail; b=FCqSj+BpeXUaDPlq55tZL8PeJ3rIS6nTwivafLEOlmhjAFP6yh1M48jMfdF9A0SPNE2xtta5Ww4gEJ5h/vOgvcC6y5mTpRyfoaKjj4KzzAtl7/8uoBjb0wt6Z9+ylQplhs2+NIWphUGJCge9/Ie3gBBr4cgebG3rq3XuhL72vdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563323; c=relaxed/simple;
	bh=kyhCZqK2wKTqtoYnXql5hptIWG4N8NivTqdrnBE3XiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AHIcm0Qzr+FDkjXunJLAdWVi+whhVwTd4Jzme7pIXhrIZLQ44az6oqwppL8T/2QiN3GjtVvzzS59NQVRAHbR0Piagei9nGy4O8kGQvaE0bMGnNU3sLk2bVsaRNGhEhIXC6tpEwvfawH6JhQIZB2DuRB403EKjHWwgwFf4hT+87c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UEam1slO; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UEam1slO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roCkGOTrpN2k1wUrVKYhZiuTZSpYYotDqDBdGZVUXYoEJCh6GCT8zstB7O5a2ejHkHHFUKEfZe6vEjF2Bu9E+4QCptJOcj2+zgTX6/iUb3Yqp6SfbUBcL9FpiYznVtdnDi3cz0VAkkL6oUSi+2xYje89jQwH20Lhkg8AzuOkqxGM8EoqrHXaZeEI2KB2MZyU6RLDh6ha4QLdYvtUivng4REwVge5h2z8GFW+0CFmVUpT1kaa0aZ+pOoHOy8LUlOTitCz9nGK3TJwdx6vgIAp1bKfcaK1UHhcz7orFrDebgW/jUYWc815X1U31fG0xQrQWNembRAa/DQBPpz3Q77c8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo8pO0xp3vY/Nd2Zd2fV3Shh7uldxcVeLJtnuan19AI=;
 b=FfaneqatcgK2L9NQMMSzFMRx4nL+lqNZTM8rYp7cQUmn5MuC7OaiOms0+bZJJhs10r3jI6aakcjDaNeGFKLjyOeBATmT6dsgouIK7lHiXytYIkuV77xKBWPiTuEU6Dhwq7S1mkHJASjF5FxSZAvHpRcdfhFXLbRKqPW0kTCPOAXMEn5xh1PVvvggKAjGtNhFjdK1RDsg3GC5w/hgcclZSq3xKmhkKi7xtz3vcRxckPx/FXufeKuDjvQ7kj7ycuLyG8SWeXxsDEd51vqZ/jlkSaHPYSmXMkfuk6Wuy5Ih724uaLTN3rR2+WZJ9YqQX/B516vqfrFQou6wFyJtPbsjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo8pO0xp3vY/Nd2Zd2fV3Shh7uldxcVeLJtnuan19AI=;
 b=UEam1slO4D/wAStrCw6IxocBj+Y5yCZM6dbZytD4snBxTZ/gabEnc+K+UFDBKlQWhEQkJ6WtX5wd0Z88yyQ2gf7i/7BkaZ0VOI/3t8rfmxiTnlp6lwnr/Il6BfkvoM8Zj/9YoB7TBgXcw8NXYJYIR3yR8p4m32c5JPNwaa0z18cVvP/kpedK1khXmAaMZPKza5RX+6XcJz2Z3yhEOenrfGffGxGpWofJbWjKGs5hs0Ma8wBl/aikZfbNadb6wGWKWDzwtN1LUrWfS5odtf1VX8rDOPpAb/ScavPo+XE/7zKUkdoMB7Tjac92U9i0aHhzXzdyYQ42H5UpBWVROuiigg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:01:51 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 16:01:50 +0000
Date: Mon, 20 Jul 2026 18:01:41 +0200
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
Subject: Re: [PATCH 08/11] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <al5GZXcH7D0s3I5d@gpd4>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-9-arighi@nvidia.com>
 <CANDhNCq4pijyx=h5mcqFji0hDQSOPDqkS7LdeYcUKNneX_wNsw@mail.gmail.com>
 <CANDhNCp01g3PN4=hZgCBLUn79_H++y8hyAr4RZP+C3MYckon7g@mail.gmail.com>
 <aluMWf5H936NXA0N@gpd4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aluMWf5H936NXA0N@gpd4>
X-ClientProxiedBy: MI2PEPF00000B85.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: be0fef9c-a5e8-4529-5bcf-08dee6783587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|6133799003|5023799004|4143699003|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pNIV5RS+f4hgqO00IhWAit6r0E3sexJWJu8eWQXrl8oZb40W7tgNjex10V0tr8p0Z8MnMcwxpj26kMC/FNL5LBdc4vLT1RSQYeLHf7uwKecbpOKtdKgEZDX12s6GyXcT99VbJMAWLv/5dA9B3Tdv1QGGPo3J0ZJCACKsYx2YrnfBCHTCEUmdgl+xxAe4bzbUn3ulVVSbOmFNopFvruvyJGxUOz2GkK//+s8U6KiFeCuNEf/FD+B1wwGCh4PxODdcu9rexcBETPNgdlLP+WbVYSQa6fvf6uxIbl8sW8bxs89che8pcjet+RReLpubtpHVuvS8TWC8R6U+QE2nUD2FEFgcD2elVF/nKcwhjM+/eMP5gps9mU167iCH5hcCmRNqJyi4M7iK2vmZyG3TnnvmtJtrVjuQer81r9zPAprfxk0+p5RSZL0OZC0cfLaQ4vNING4j5XS/OIBzLFWz1V0r4DTeArb8VZl9cJIvI2O2UUN+OWQ6nefSX/sBmNhh+TeqASL0XyIJw13zx9JNGSw8QE3fJ+MZL3RE2Qod9phaz9tOpAN6r82jRi6AiGiKlxfWCmjmKdH2Zy31EK4AedhWz2yCJHi9Nsmi8oLGLU5S1xVDcURENtp2mjq/duDoPzYI2sUP5kfXkDe4VbQrDotw38thM6Z98DVxb4dKAXGTn6M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(6133799003)(5023799004)(4143699003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1FRcVhQb1QwWkUwSjBScFF5TTdReDRSSlNrb3BScDFJMVVHa0lwcUpteDN3?=
 =?utf-8?B?ckJ3NElvR052eDZ0N0hobE1XL1VoYThhTkFUMG9kSk5qamZLNzAwREFvNU9r?=
 =?utf-8?B?blRUakErTmxUT1NzaDA0ZndQVDJ6bTNwY0pENU0xbUNmOXk2Z2J4WGY5ZnJa?=
 =?utf-8?B?L2E0Q1BrYjQvbXVoemVaQWIveXRxeENMenJzZjhjRlZZd3ljUUFPN1JpMHFm?=
 =?utf-8?B?b1VJVGNsTHFqNGVPR3E0aUkzSzhDMlJkRERIRnFMbFdEdkpjSHh6ZWFTQkhz?=
 =?utf-8?B?Vkh6aWtQcWdnTEhIcU1lTkZqb1BuWDZSUmNlSmRDUyszZ1dSd0pJUmxYZFFu?=
 =?utf-8?B?cjJUbVZDbHJOTm5lTU5KVFZVYnFlMUc3RWExRXo0cGtpc3A1VU1xbHBRRkMx?=
 =?utf-8?B?WkZXbjBHL1d2MWZJbkdONm1UNGlITDB5TVF4VXQ3dlJTVHdITVNDM1Bya0ty?=
 =?utf-8?B?ZlRLMlhHcEdHd0hteTlxRk0rbXJlbU1KY1hzSTRSNG5Sa1piL25QZWxRWlA2?=
 =?utf-8?B?b1BGenZNRG4vOFhCTk1SRExsYVdZaktLMG9vYVFXM2dFNUczaEFDaDhGZDRN?=
 =?utf-8?B?VC9NQjZjSXNiaEdaTDlUU2I3bkxRTWNOQWhueU5tNXc5dXRkY29MbTVRem5p?=
 =?utf-8?B?akdvR1lUNjJiV3lhNnlxZGlsMlBVeERlOEZRNEd5bXI3SWZOU0RUNjl2UGli?=
 =?utf-8?B?REZmdVJTOGo0QWxOVnNCVDkyUHlRWkJ1WDVqejMva1pNVVdWTEJ6eDZUSG8y?=
 =?utf-8?B?UStEVHZJVDB3VjB4S2p1OUduMnRHOHVOV1lENUtHMC84dDJXL3VkQUNENlpM?=
 =?utf-8?B?V2pReUhGcGNrY3hRYXZkTm92ZzQ4WncwWFl3K3IwUm9tVldvSHJ6YWxRMU11?=
 =?utf-8?B?alREaXFUR0dDN0VVVkMwbDM4NkNUN3cwQ2lQd3kzQWdML2dHaWJRNGhiQjhQ?=
 =?utf-8?B?TUpoMWNOaEg2cmh3OUdOaE0wTjgyRnJUZFgvcU5lSUtnRGxwZE5FYk80QVV4?=
 =?utf-8?B?cUtWUldkOEszdGJtc3I5eFp5U0gwZUU3cXJ2Zkt5R2ZjNnZ3QjgyWTBWaE5F?=
 =?utf-8?B?dmNMYXozZzlhM3owdkE5RmdrSHpWZ1AwWnFUMEovTFhTUGx2dVNQNTIrV1hF?=
 =?utf-8?B?amg5eEMvSWJiWEloSzBlZmhuU1R0cVNGaU9jdDdZRXlhRzFWa25xemxBMGNI?=
 =?utf-8?B?VnJ1V1hZZHFDNEllMDh1VzU3eGxiREpNb1F2MHp1cFlLQnlQQVdveDlidC9z?=
 =?utf-8?B?Wjc3RzFza0dYTmhhclptZWp4eFJXYmV2dzdYUjdzOVQvQ0VWRVBLMHd0R0w1?=
 =?utf-8?B?QVpKWGFyWWJTZU5pblNqV3QxbUJvbXhHSnVGYS9MVVhCUDFLNXVNUm8xWDJR?=
 =?utf-8?B?aHgwcFBRMU9zbDNRQ0xHcWRiRTJMbEV2eHZOY2V4Z1JTRytJQnI4QUhGU0Qv?=
 =?utf-8?B?WU45U0lJNmtHU1VjRGdUWTVyOTJPRDV5Sndwd3hiNlRsSzdZb3EvNWxlN2Vw?=
 =?utf-8?B?Skl1RFhTdHBQREo5TGxRTktwU0M5NnZ2SUhENWxtV2JPTDNHeE5TZ1NSUm5p?=
 =?utf-8?B?YXNPUWU2L1EvZWg5YTJBZ1djb2FMbnI2ZWI3a1pDTGk0N1R5dDU3dmNVQ0dx?=
 =?utf-8?B?SUJZbi92REw0N1VzM3RHc2ZLYTM0SHhjRTM4RUc5eGpxalpZeUlTYjJRVWFa?=
 =?utf-8?B?bW96VC9NYTk2TnYremxaaFBMdVV3cTQzZ2xqeFFDaFJONHI0RGkwTzFLK0NH?=
 =?utf-8?B?Sko0K010OVJTNHppR09uMFVMUFRNZFEydVR1bzhhbWVScE1aK0xZbTBoc09m?=
 =?utf-8?B?Zkg2elNLdGZ2eWxhaUYwajUyRzZkQXBodFVSWnU5VmVrM3V6ZHdmMTVoWXhW?=
 =?utf-8?B?ZWJ1SVFvQjVKZ3dGZlZoMUVpRDBGQWN6QW8rTUtJcVlDSk5Lc05ZSGx3NDIx?=
 =?utf-8?B?QWVhVjUrempBVVdVVlVyRnhkMnY3bktETlNoMVI3N2hyWlVWelhkYjUxVFVM?=
 =?utf-8?B?U2FtVVI4MGpHeEdCT1JxS2t4OVd6RkV5TjhjUVM2Y2lxeWtvc3NtK0hUTnM5?=
 =?utf-8?B?dDZ5TU1nc0tuc0FkcDU2d2REVVVMLzg5blJiTms2NXorTjMyWktpWm1YcDdM?=
 =?utf-8?B?Z2lxd2R1cllEMC9VY0dXbHFIc2duanhtVEdhZzJhRUFyR0NzSkVWWnNVMEw1?=
 =?utf-8?B?WVlPS3VYd0tOTkE4SEtFQWNEdngvMmxNUzhESXlZOEJLVVVqN3RSZWE1TE5k?=
 =?utf-8?B?VDdReE1NN2lieGs5eDVnT0JwY2ttYjFrRlM2cmo5NmxGTXdOQi83bU50WVBi?=
 =?utf-8?B?bFZGaTJRaHFQZGZmeC9jenVjL29OTjhwOUh6MEFYcytHeU12MUZmdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0fef9c-a5e8-4529-5bcf-08dee6783587
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:01:50.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmQUwO3uGuFMYZmccT40IGbS8TdPMpAwKrlba3BpOjtYntRaLVoSy3ST0SfNUy1Pn5XUdH+Xe6efBTbx4bzpFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

Hi John,

On Sat, Jul 18, 2026 at 04:23:40PM +0200, Andrea Righi wrote:
> Hi John,
> 
> On Fri, Jul 17, 2026 at 11:50:20PM -0700, John Stultz wrote:
> > On Fri, Jul 17, 2026 at 11:16 PM John Stultz <jstultz@google.com> wrote:
> > >
> > > On Thu, Jul 16, 2026 at 6:23 AM Andrea Righi <arighi@nvidia.com> wrote:
> > > > @@ -3098,18 +3164,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
> > > >                 set_task_runnable(rq, p);
> > > >
> > > >                 /*
> > > > -                * Mutex-blocked donors stay queued on the runqueue under proxy
> > > > -                * execution, but the donor never runs as itself, proxy-exec
> > > > -                * walks the blocked_on chain on the next __schedule() and runs
> > > > -                * the lock owner in its place.
> > > > +                * Mutex-blocked donors only stay queued when their BPF scheduler
> > > > +                * enables %SCX_OPS_ENQ_BLOCKED. The rq lock has remained held since
> > > > +                * scx_allow_proxy_exec(), so @p's scheduler association cannot have
> > > > +                * changed and @sch must be non-NULL with the flag set.
> > > >                  *
> > > > -                * Put the donor on the local DSQ directly so pick_next_task()
> > > > -                * can still see it. find_proxy_task() will either run the chain
> > > > -                * owner or deactivate the donor so the wakeup path can return it
> > > > -                * and let BPF make a new dispatch decision once it is unblocked.
> > > > +                * Delegate admission to the BPF scheduler.
> > > >                  */
> > > >                 if (p->is_blocked) {
> > > > -                       scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
> > > > +                       WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
> > > > +                       scx_do_enqueue_task(rq, p, 0, -1);
> > > >                         goto switch_class;
> > > >                 }
> > > >
> > >
> > > So this isn't a blocker for your patches, but just as a heads up: when
> > > applying my sleeping owner handling changes (even just patches 4-7
> > > from my v30 submission[1]), I managed to trip the above WARN_ON, when
> > > running the test-ww_mutex driver under the scx_pair (usually right as
> > > scx_pair loads).
> > >
> > > [ 5818.970324] WARNING: kernel/sched/ext/ext.c:3175 at
> > > put_prev_task_scx+0x527/0x550, CPU#54: kworker/u261:11/30527
> > > [ 5818.974927] CPU: 54 UID: 0 PID: 30527 Comm: kworker/u261:11
> > > Tainted: G        W           7.1.0-13303-gb5ecf3c9f881 #116
> > > PREEMPT(full)
> > > [ 5818.979484] Tainted: [W]=WARN
> > > [ 5818.980654] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> > > [ 5818.984225] Workqueue: test-ww_mutex test_cycle_work
> > > [ 5818.986199] Sched_ext: pair (enabled+all), task: runnable_at=-369ms
> > > [ 5818.986202] RIP: 0010:put_prev_task_scx+0x527/0x550
> > > [ 5818.990473] Code: 48 2b 05 34 f3 21 03 75 3c 48 83 c4 30 48 89 de
> > > 48 89 ef b9 ff ff ff ff 5b 31 d2 5d 41 5c 41 5d 41 5e 41 5f e9 fa f0
> > > ff ff 90 <0f> 0b 90 e9 b8 fe ff ff 90 0f 0b 90 e9 35 fe ff ff b8 02 00
> > > 00 00
> > > [ 5818.997428] RSP: 0018:ffffc900088dfb28 EFLAGS: 00010046
> > > [ 5818.999426] RAX: 0000000000000036 RBX: ffff888101258000 RCX: ffff888101d64990
> > > [ 5819.002113] RDX: ffff8881b9bae638 RSI: ffff888101d64990 RDI: ffff888101258390
> > > [ 5819.004787] RBP: ffff8881b9badb00 R08: ffff8881b9badb00 R09: 0000000000000000
> > > [ 5819.007967] R10: 0000000000000036 R11: ffff888120a9b030 R12: ffff888100c30000
> > > [ 5819.010697] R13: ffff88810d163800 R14: ffff888101258000 R15: ffff888100c30000
> > > [ 5819.013378] FS:  0000000000000000(0000) GS:ffff8882355c0000(0000)
> > > knlGS:0000000000000000
> > > [ 5819.016354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 5819.018524] CR2: 00007ffe7b985348 CR3: 0000000123ec6004 CR4: 0000000000370ef0
> > > [ 5819.021163] Call Trace:
> > > [ 5819.022168]  <TASK>
> > > [ 5819.023010]  __schedule+0x15c4/0x2460
> > > [ 5819.024504]  ? find_held_lock+0x2b/0x80
> > > [ 5819.025981]  ? lock_release+0x191/0x310
> > > [ 5819.027503]  schedule+0x3d/0x130
> > > [ 5819.028772]  schedule_preempt_disabled+0x18/0x30
> > > [ 5819.030539]  __ww_mutex_lock.constprop.0+0xaea/0x19e0
> > > [ 5819.032492]  ? schedule_timeout+0xca/0x130
> > > [ 5819.034095]  ? test_cycle_work+0x15d/0x340
> > > [ 5819.035686]  ? ww_mutex_lock+0x3c/0xb0
> > > [ 5819.037094]  ww_mutex_lock+0x3c/0xb0
> > > [ 5819.038494]  test_cycle_work+0x15d/0x340
> > > [ 5819.039949]  process_one_work+0x20c/0x5e0
> > > [ 5819.041631]  ? lock_is_held_type+0xcd/0x130
> > > [ 5819.043277]  worker_thread+0x1a4/0x360
> > > [ 5819.044717]  ? __pfx_worker_thread+0x10/0x10
> > > [ 5819.046392]  kthread+0x103/0x130
> > > [ 5819.047650]  ? __pfx_kthread+0x10/0x10
> > > [ 5819.049074]  ret_from_fork+0x27c/0x340
> > > [ 5819.050525]  ? __pfx_kthread+0x10/0x10
> > > [ 5819.051990]  ret_from_fork_asm+0x1a/0x30
> > > [ 5819.053488]  </TASK>
> > > [ 5819.054371] irq event stamp: 38
> > > [ 5819.055583] hardirqs last  enabled at (37): [<ffffffff826a7100>]
> > > _raw_spin_unlock_irqrestore+0x50/0x60
> > > [ 5819.059054] hardirqs last disabled at (38): [<ffffffff82699205>]
> > > __schedule+0xb95/0x2460
> > > [ 5819.061998] softirqs last  enabled at (26): [<ffffffff813244d0>]
> > > __irq_exit_rcu+0xe0/0x150
> > > [ 5819.065015] softirqs last disabled at (21): [<ffffffff813244d0>]
> > > __irq_exit_rcu+0xe0/0x150
> > > [ 5819.068013] ---[ end trace 0000000000000000 ]---
> > >
> > > It seems to be coming from the proxy_resched_idle() call in the "if
> > > (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {" case in
> > > find_proxy_task(), prior to proxy_enqueue_on_owner() calling
> > > block_task().
> > >
> > > I'll have to dig a bit more next week on this, as I'm not yet seeing
> > > whats going wrong here.
> > 
> > Ok, my tired theory is something like:
> > 
> > 1) You have a task A that that is_blocked waiting on a sleeping owner
> > B. It gets enqueued onto that owner and waits.
> > 
> > 2) We start scx_pair, and scx_prepare_task_sched_change() calls
> > sched_proxy_block_task(), which bails because !task_on_rq_queued()
> > 
> > 3) B wakes up, and that causes us to activate_blocked_waiters(), which
> > re-adds A (with is_blocked still set) to the rq
> >    - this is problematic because now we have is_blocked tasks on the
> > sched_ext DSQ where its not allowed.
> > 
> > 4) A is selected as a donor, and maybe B is sleeping again, so we call
> > put_prev_set_next() and hti the warning because we see A is is_blocked
> > when the sched_ext scheduler doesn't support it.
> > 
> > I'll work to prove this out a bit further next week.  I suspect we'll
> > need something somewhere between activate_blocked_waiters() ->
> > scx_do_enqueue_task() to skip enquing of is_blocked tasks when
> > SCX_OPS_ENQ_BLOCKED isn't set.
> 
> Your theory looks correct to me. I was also able to reproduce this. I think the
> problem is that scx_prepare_task_sched_change() calls sched_proxy_block_task(),
> but the latter has nothing to do when the donor is already off the runqueue
> behind a sleeping owner.
> 
> When the owner subsequently wakes, activate_blocked_waiters() unconditionally
> reactivates the donor while is_blocked is still set. Since this activation
> carries ENQUEUE_WAKEUP, sched_ext treats it as a normal wakeup rather than a
> blocked-donor admission. The donor can therefore enter an scx scheduler that
> doesn't set SCX_OPS_ENQ_BLOCKED (scx_pair in this case), eventually triggering
> the warning in put_prev_task_scx(): unexpected proxy donor without
> SCX_OPS_ENQ_BLOCKED set.
> 
> I think we can fix this by checking scx_allow_proxy_exec() in
> do_activate_blocked_waiter() before reactivating the donor. If the scx scheduler
> doesn't support proxy donors (SCX_OPS_ENQ_BLOCKED not set), the task should
> remain blocked and will be activated normally by the mutex wakeup.
> 
> While looking at this, I noticed another issue in the same path:
> activate_blocked_waiters() currently passes ENQUEUE_WAKEUP because the generic
> scheduling classes need wakeup-style enqueue accounting. However, this is not a
> real mutex wakeup, the donor remains blocked and is only being made runnable so
> that it can donate its scheduling context.
> 
> As a result, even a scheduler that sets SCX_OPS_ENQ_BLOCKED currently receives
> this sleeping-owner activation as SCX_ENQ_WAKEUP rather than SCX_ENQ_BLOCKED.
> That's because the existing sched_ext test:
> 
>   p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP)
> 
> doesn't distinguish a genuine mutex wakeup from this proxy activation.
> 
> Maybe we can address this by adding an internal ENQUEUE_PROXY flag to the
> sleeping-owner activation. The generic classes will continue to see
> ENQUEUE_WAKEUP, preserving their accounting behavior, while sched_ext will use
> ENQUEUE_PROXY to expose the event to BPF as SCX_ENQ_BLOCKED without
> SCX_ENQ_WAKEUP. And a genuine mutex wakeup will continue to be reported as
> SCX_ENQ_WAKEUP. What do you think?

FYI, I've applied your sleeping owner changes + the scx-proxy-exec patch series
with the changes mentioned above here:

 git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-proxy-exec-next

Everything looks good on my side so far.

Thanks,
-Andrea
