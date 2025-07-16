Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97A35972
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672045; cv=fail; b=h0KpeERbMcfbN5E6FsKU06H1KjHNHYTiuHzA48BYl95MvIPpDFV9H8jR6wN74bohwBg+dOrAY8CsJ6X5YcEFRmSUKWB7A/+QGNwZFUCaUNkq0pqMa/Ir5rz15n4tApF7y/KC7hoLLiC5wPJKBjGLdLVEDwbpLPoQvlezbc/St/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672045; c=relaxed/simple;
	bh=Aon30s8NcsoSU8WT8nXPi/iSSZ83fayBte/IiKeHGUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ouwrHgJaymZzYv99SvhBCbUMTbdqn/gukzxdpT9YDl5/sIlpzPAuzI2mkhZquR+6To17eZ2kgIhUDAaTxHhZhH/0F+wC7D5+g5WBjvLQ0g5NXYRfts2pJ8ntlZffPuTVDjr1FSZm6T5IGZ1VHqO4n4sXx9BOWduOL+vJsrJVprY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k8nAGwgG; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k8nAGwgG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0Zc86yGOCl9T5Krv6atAzfqR1LrxNRCmiROfRpseKWUg07jX+fGRQtsnlfafs5jW4P/wokeJicsHCpNf4eBelqDT0/vdEEEJ1z0vPN4T9jwoJR+g/9FnRC5fu2wEwjZAbJZNkQCjwgWPXccv+djIHFdK79NuKqWQyT8t3HUKOOxKdQ361gi3pLmkluUcV1IpbnCMWeWkrKJRbe3kmd7otkMwralxADqlFEOKThBGufoWyy1TvCKi9cklnvi/B51wkKfl3ivihhTmhPMc7gqm327d/BKkUuHdr8tULuXu+tiyqsLKtkzr/NV/ihB3idbJHmpHwUNbPbckgWYmV8DnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTPoHkf4EgYyH77HahuMfizrR84musfUJsy/CEaM1RE=;
 b=q0Q2KWPgEieemJZ2T/dszUINdt5ZDsYvK3wH526C53JoD/b2nNa/aG5HF4KfGss5c/iIw8E+AwpANG5jJeUPka+0qk98KBZ5yUC2P9AzsHr7t0dmhWwNzTZoeuayCbWC2uy1KMI3amoqTxp8/dXnGTWZiRPU8PbBgePl7NXfF5Khfhp4Q4ZopQGCVdlfROtiunc7fzt4vVgDDxWu73moeZorVl7UbMMK2NpT7uAWiFrRknvOhyGCNTShz3oql3vGgAYhLfmnxPVp2Ssrp1hDeHjPjOqwEg8W1EC1+oqGgGE6ms96nCIH4BdXKGNZAyJ+o5Yb8KfhcGEG4WDbqG2VIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTPoHkf4EgYyH77HahuMfizrR84musfUJsy/CEaM1RE=;
 b=k8nAGwgGb8k6H9aj1WrET5oWFAXBomu91m7F1sKPiANw6aO5pHomY3F90A9EzNGobO/RM1TF7LkQ89W5mGccHxBey/X3mCdOKfW6IQsQbcZ8iGkKoITCSzGbJ26zEwz5UClbfonmnaD1zIkXayHZ6crXBImevZ2Y9JQ1lpwUZoMXpsze/H5F7PH0JyyBmTyMiZPFDV/9sg4AZA1/w5oV5trTfmENOq6P8RrWZiavYt0qBKMH7lQQwgYzCEhWVFHAtBT/50w1ta+de4CchHHhWfXr7UNxpqqvN/JSRBQ0XIC9OP6oCT6Exjpqy5QIQ11R9rzKsEjVFLsU40tGMNyfKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Wed, 16 Jul
 2025 13:20:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 13:20:40 +0000
Date: Wed, 16 Jul 2025 15:20:33 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Breno Leitao <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <aHenIcWaLOXL2Yix@gpd4>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716085447.06feeb86@gandalf.local.home>
 <20250716130652.GB3429938@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716130652.GB3429938@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 053437b1-994b-406f-0bfd-08ddc46b8fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ALCeBDClYjxST0eMEDUR8VwQYZ+Qsn7NDupGYUI+WORyV6p08gwMQYdRC2wD?=
 =?us-ascii?Q?vG2jL0VGv9l7ms5/moWbc0bdCAlwdjPL1e2VO0px82Rn1+D9xTMug2OoVfIP?=
 =?us-ascii?Q?GfkDz0mc96MpwMY7TnVXv9iDuVHTtkblM38pEgfVhS6EDDGWljkC0M0kX47u?=
 =?us-ascii?Q?0aAVYo9kLo7ZXXR5hL1scY2V1Ae/uM53vYny5tp2u9e1Wzix/qM7zD5CO2iN?=
 =?us-ascii?Q?/2QuD/SPDsY6wkDAn3of0Cjh1WBOOuSFrrMSAQSRaZ50UZB/5RXhTHUvz615?=
 =?us-ascii?Q?oeDl5X/9/gLBAdDLfLxjHiMJbY+luEox7AmgWg28t3Hs5Z65ea6HnMaoPKG+?=
 =?us-ascii?Q?I0R7ezly4+3Nw2Q9PcrXkl76m4RPcqmES6TMjSZTFaNhoTXGVjhRjzccw1/0?=
 =?us-ascii?Q?D63ftcs7xZYkxivmw+4clNR51uc2vTvjGrybaVBqK/Epn1bhBK3Sjf3ndh/p?=
 =?us-ascii?Q?b4VqSvnrQPTRiXeTAJTYcl7hqTIRx0xpCuMYCBfaZSNMO6W2MigkJ6IEa0fq?=
 =?us-ascii?Q?BYodPZp1FQdsYfJ0A31C+HW1OAzliDaDa5xJR+JnsWpPRfgEn64ldQtQDEWA?=
 =?us-ascii?Q?dZRsPHTesTQNJfvLJxnoChkDDtlCxJIYeqTuBL8as9nzBuVBUsiZVUG8qqbz?=
 =?us-ascii?Q?ZzoRmCTCcUDYmjL2T0fMo4l9XMU+A0dIoPoycrcL7mVWYNwaWwYo0hdwyIxB?=
 =?us-ascii?Q?YpLIW3SPY0E5/HTCKqe5J3obOQAvRYzmtkRkPSfYjXu4wZaR9tJMDUMregtU?=
 =?us-ascii?Q?WcKzeVuzwWrXvThYvN2TXg7B8NyuaQ784HgxCqQs7ekKB8oda2Fw64p1tLsS?=
 =?us-ascii?Q?T489kKCAGgdeqO/xqPhVb4i4+i8Id+hkpMpPPawy/JFfbCnUKkIgffP0/uLe?=
 =?us-ascii?Q?wmM7ZQ6n/C3Ovx9Y/CdSeS/NXsmZH076/EdzR3q4bV9i/uimc7kpKG8SlIVX?=
 =?us-ascii?Q?B9Domw0eNePBslT9zhJNDRt9xR06CxX7mqSqWG07UY4Bc7FE32l2FGfH3drj?=
 =?us-ascii?Q?Bu+AqUn/eZCa3ozBoilT4q71Z2gQRl+I/KTpDY1nu3YB8F0CxJKX7axA5mhG?=
 =?us-ascii?Q?1snd34mbDCUAc008qBvnX4CZOmEb0kJ1Did0c15Tm+rH5P7jtDfS5DY0vSG1?=
 =?us-ascii?Q?x7pn0EcIo2VpVXyqQyzxvAyHZnuqgdB1lZ5qFa1E7lwo/o1er7b0ejSuqSQY?=
 =?us-ascii?Q?d6yyxL59x6HkNqyz0MPaWDhkjUgQo7xoupXuaX1bwkY1lnKUhXRp1a5ndGHN?=
 =?us-ascii?Q?94LwhfYEy3NW2/MfS5Zm80UhtruGHkgJU7pXWotpnrrK+udh/yCb0h99TFIQ?=
 =?us-ascii?Q?V9Fys7ZNqQWr5zW96naSYkfJfMAuyjqwfI+NxrptSeTOdm933S7dKTMqGbnV?=
 =?us-ascii?Q?CstrMtHs9mZhcea1ewyIa4odt54TcAg1CUuW2F/XeQfOGFPTtpb6q0wtyMX5?=
 =?us-ascii?Q?5GXyBM1Al2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rvx7BChZ3wEKeG/Ki/SeM4jW+O5cPkQEMmi+4ch15adbxYFgIKdTKefjs9i0?=
 =?us-ascii?Q?c6mTjZjmn7FyEQHvRmwF4rQQlpi9jNu34rXixc7n0oicMo9ttCIY62QcH0WR?=
 =?us-ascii?Q?/PSDAdyyGSfT95sEmXmAqMH+gTCMDDrn0hWQvyB9soSgmpodD+LspfXLaYVw?=
 =?us-ascii?Q?FInol2Qjz5afH8vs3y9nZxD4qI+NZCNBhOHrIh+xWMli/JTuRlCd1vXhZ8Vu?=
 =?us-ascii?Q?bqDSmM1xzukqJ3TH8Pf7XPDUQ49ljTyZUNn+9w3UBqSCFPBE+ZqgQUXdWs9W?=
 =?us-ascii?Q?LH5xl5GxywIZHqvrI9PJBi3ZO6n+1ODq7wrQuaFpS2YqmWyd3mcYdvGgLq9n?=
 =?us-ascii?Q?llp61lSFdK+Z9f3P/veL2CjgdAzI/u6EjXSAu2K58OmhcNQM35FtaH5y2/Fq?=
 =?us-ascii?Q?jPpbs344jPlorZ/FnpueGw90z2k0qK/QBpuxsR8P6jHYc68HSecJAFYUyhbj?=
 =?us-ascii?Q?WDeX8AmTM1J6+BrEZ/rz9js2nFfMym87WaDkgMLfhhysdW2gR1iwPJtFNbWd?=
 =?us-ascii?Q?uFbyXoouiHRJqaV1SasrkYyY0+NFhO6y1MVr17j+fXsQcgKMnEvezU2KiYic?=
 =?us-ascii?Q?trQY57YHIRUfLiHiGYZo5h87YRmvj/qKLarLTtnhRosbhKtMbrJFpkG1SL+U?=
 =?us-ascii?Q?CTI6nJnbqMIYocYivhthI2jDHpUYU47zRQm0dHcVFbL3pQLlCMIDe/And7UF?=
 =?us-ascii?Q?miemfp0v3OKa+iJ/oSVrVPwmQGuIKVMSSjcPCYPzWYrOEKfBAsQEZQycTi+s?=
 =?us-ascii?Q?t69irMVhsmj9+hDodwxg3WMnW2fy41ND9yjXqGKa9C5VEliLUNyvL2qW+2gI?=
 =?us-ascii?Q?5e+IwVB/XBEHtAJ93/RLMPwm8gBmXpT3GNU7aN9LxHFb+SAf6bCO9IPuRF3I?=
 =?us-ascii?Q?FPKMpc4kCkYQTMKaoD3HQ7n0/w/LtJKqjaxaIlpSQk1bmVNLmGpfb4QCqAT3?=
 =?us-ascii?Q?Dxhh90M/D4gm9z1F30hhE4W61GwQ3pCAJLPCN+4UoJV86ZGM88/lnpBwaOyu?=
 =?us-ascii?Q?F4VOiAnU8f5wvrS9DDzrLBSosmDr02ZF5rsw0nTkLMTS7gX427J44MMcZ55R?=
 =?us-ascii?Q?PRtwV0jDesguXxMzILAOshimMcCWVhBHpGgTtMFxLxj1oXMr7pysnAOuvK0F?=
 =?us-ascii?Q?HdqIVBgZGm0ZJOehfl3CY2TjofXeSFmTRYs259D3DM3TycJf7RLf5ckzVd5m?=
 =?us-ascii?Q?mrdSQKqiO4c0EEHhWJE6iy/JrSAPchoajHxeUkarotNpNYaEHsli7VA9eQXB?=
 =?us-ascii?Q?RhN3S2koCX2wPwqC79xgo7QPChivLeGU0vOCzyQNZjGPRgucTcdUoHL0qQK7?=
 =?us-ascii?Q?uOqtSP6KyQjrMtFm5ce8rHJfEnFOPCODizc00heTz9Uw+JWXhKjS4uxkpSRR?=
 =?us-ascii?Q?qa7iiM5W8IMhKQbdYdDQCj+GOrsDbUA/27gho8ZualQnYl8eKTExLwKrJ8eZ?=
 =?us-ascii?Q?CcbYJkGojGnQKOB2bzf6gyl78M8apH8aKb7LTRoIQS0fneB+zcBr2kYit04A?=
 =?us-ascii?Q?js828SpMt2QGaSj7l01rjIjjEJzkbtD05as/eoYlCMVCyQzb9vkbmLkzHZ6E?=
 =?us-ascii?Q?NZX0LQVp5HIxkLNUFehqnmFXhyzt4ZgxmIlvw9yN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053437b1-994b-406f-0bfd-08ddc46b8fa4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 13:20:40.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jo8sSdpACoDy9lVd07A80rvXQbk0hwHVxsc33GPenEGVY8y7ZKF6vdvLn9yvLp6D/U/5iOWUmEHaiuMuCk1rrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

On Wed, Jul 16, 2025 at 03:06:52PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 08:54:47AM -0400, Steven Rostedt wrote:
> > On Wed, 16 Jul 2025 05:46:15 -0700
> > Breno Leitao <leitao@debian.org> wrote:
> > 
> > > __this_cpu_write() emits a warning if used with preemption enabled.
> > > 
> > > Function update_locked_rq() might be called with preemption enabled,
> > > which causes the following warning:
> > > 
> > > 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> > > 
> > > Disable preemption around the __this_cpu_write() call in
> > > update_locked_rq() to suppress the warning, without affecting behavior.
> > > 
> > > If preemption triggers a  jump to another CPU during the callback it's
> > > fine, since we would track the rq state on the other CPU with its own
> > > local variable.
> > > 
> > > Suggested-by: Andrea Righi <arighi@nvidia.com>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
> > > Acked-by: Andrea Righi <arighi@nvidia.com>
> > > ---
> > >  kernel/sched/ext.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > > index b498d867ba210..24fcbd7331f73 100644
> > > --- a/kernel/sched/ext.c
> > > +++ b/kernel/sched/ext.c
> > > @@ -1258,7 +1258,14 @@ static inline void update_locked_rq(struct rq *rq)
> > >  	 */
> > >  	if (rq)
> > >  		lockdep_assert_rq_held(rq);
> > 
> > <blink>
> > 
> > If an rq lock is expected to be held, there had better be no preemption
> > enabled. How is this OK?
> 
> The rq=NULL case; but from the usage I've seen that also happens with
> rq lock held.
> 
> Specifically I think the check ought to be:
> 
> 	if (rq)
> 		lockdep_assert_rq_held(rq)
> 	else
> 		lockdep_assert_rq_held(__this_cpu_read(locked_rq));

Hm... but if the same CPU invokes two "unlocked" callbacks in a row,
locked_rq would be NULL during the second call and we would check rq_held
against NULL.

-Andrea
