Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E234D3B1
	for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790368; cv=fail; b=JQp3f/ERj/6i0KrLy3zNxvZo95Szedv6SiDlBbo9oNWvP1QKrdbnr5Ht0hxzAm49+r8DEAxDVoDsjgfD9p6AtdkcJvlNJEzux9i6pXwoCR6+v/ZS+tit6vvxo9c/z6VbM2nMVk1eRqyvEe70XcKyGaJc/mFwCES6gCZXnL2keKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790368; c=relaxed/simple;
	bh=mdbyiUmu2OCBHpym612kMWBckL3DxNX7wx4ejtlrZfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u3PqwrF62F5FRZhJoIpu9Ri9/WGfROwv6k5qcNI9HToaUEY7R2HV8UEgWeHJTNsJifS/AzjF3bZTqCoonugkIrj2J7wN7jPlBbK0tP0Wcg6lwP0FdE9O3EjrubnYqz0AMXdzV1xuHfOrNY814SMf6ufVtzN8LWVt2/F+kdlYQmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E3AU+pqh; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E3AU+pqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y66XmxgSajB5z0T7G++b3yhbgCygnwnyTYlUilS6CvhtxpJbhSxIKFMkLcuSnn4NXfzvsKwrgVV7fjWhiwqw7cf9gF5Fdx9EP3YWwSzlDwSyGZyV/fJPOo64qIv8wn8JphWSv8x/A4mJgm0hP1VGk34Qc1NtyPzYmIms4wcj1E2Jf/6Jqh/f1blkYeisL3rCiN3fF01WiyiQKfQ14LsM7bwWvz2t8My73girDIsRenx3+3GNso9ortzoaBIIsx6PnIAQ4Mvqrfdioq3i7FRnjzD/1TyTrTTnEopOui2LV3eotBFyWwJ2fohGth/otDGlvUorfg6X0DxRlKM7+TojXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eMsNdTi5nhwR6lpi+/fe5nl99WwODKLa/fi1GFk/4U=;
 b=iM2pZ5EAx/NgraFCQg/gRQbihvWs48szXMk9Un7GYVEkprziSemr5/1eNE4mB7WBDe6ZIfH9EtMDKFpOnjwHty27Cxk9bT+uXVCvsAb8z2R9hFf5vWTo6MpXzc/64+KgZs3cnl/RxLpi97Iq0Jh1Bh28vXkvFjre3RBqkJDjiHb5teNMEbH0o7ZUUdZYE99at0YeI+xX/65BxL9BbzroPxvrVzqfDKXpnmcH2v+mqEhGLIzGG5udK44U/lmZ2i7Uxi42QCA/cYaoiTWltjFIJDy9PpV3zWPBgI3uYLgGBGbEGloxuKbqGMuJR/+xS07GkVtPIBVxwPmk6n4Frt9Vpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eMsNdTi5nhwR6lpi+/fe5nl99WwODKLa/fi1GFk/4U=;
 b=E3AU+pqhpY4iwAaOO+DvOUxzlLZV8kAECY8tkNUKieM0mFvhuQayj7UaeZM3/mMvuonhVxbaN4LenYN2MAH6RPuomu6kT/g5djtHLbOU1+SZNNU5oEnEnYsd57HU3vja9GChhoneuFR8UU8lO6hQ6OnFKDnSs4OyB9NiyytB88xu70AHn0rvqnLQQP9ApxMS69vEUadKleIdLc9KvR2bLOlFvxh6L6KHh7RSy2ohA0MQ2bCyxrF4vaz+mmXlhCths/J8LGW0WDlV+tTy4gu+b18Ismbh+aopPUYVZTczAdeslx5laP1D0SyqJZa7HJeb3RVZYfvBh4PhjgjtRy4Zrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Fri, 30 Jan
 2026 16:26:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 16:26:00 +0000
Date: Fri, 30 Jan 2026 17:25:56 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <aXzblMyzyUoyNF36@gpd4>
References: <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
 <aXoSFOONWJmdyCQB@gpd4>
 <20260130122413.GA3306656@noisy.programming.kicks-ass.net>
 <20260130122620.GB1079264@noisy.programming.kicks-ass.net>
 <20260130124100.GC1079264@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130124100.GC1079264@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: a4af12a5-d443-4a8b-1000-08de601c4136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWDBfRU/lHikVbssDTrQpLIKV1ie1Uzh7aNojBr31S7TU5zEPSXi2Zd/C73r?=
 =?us-ascii?Q?+ZbiPqRqIowCcisYy9LyIjo89397XdLaGpe/UKqhNDVA8gkIABrvvIWe+fT1?=
 =?us-ascii?Q?D0/midwEswq/iNPdSuPPSbgIrP1Dqj0Dnt5/Ax4Xh2nbVA7UB7Jlf2dg+pJv?=
 =?us-ascii?Q?yiNlASg2qENZ3Imn6KXzc2pDvb4tYylZGDJUiLFsT/z360hd1LBj1CJxJQ9x?=
 =?us-ascii?Q?irPWwfEFsgkulWQxlEBQU+3uLITabkbuOldCFOCdOy8dmUaXRn69Y0k5YGG5?=
 =?us-ascii?Q?2JBPDX+4e9LrQ/7C3gX+bfLD7ouc2qIFfzziFwYbeIQw1fFA226c4M7SWplj?=
 =?us-ascii?Q?QgcNbqNHMGrcX575Wbr+Pd49LiWYL+rBdGjzBMJD/HgtiO2PTW7TYJxEoCPy?=
 =?us-ascii?Q?IyNKGlrV9rXCGvNqtOr9G16/8TZzuTL/ZGFIQv2p7x2g+eZC1viE1FsHqDf2?=
 =?us-ascii?Q?4uyUdJ7XZKnPY2wmiNOWcsNMrQ52NXWu1iVRGaLPcxKoqgaNoGRsuS9C/RwD?=
 =?us-ascii?Q?yxeU6NM9RNo/UD4sSKDfsLKZcvaqJMCxw/KTFvSX+AbIJMQCinkrlMwemV9O?=
 =?us-ascii?Q?XAWe2RaJM7DNHfNevxEI0a9CqtZFDQfnEha3es1tWFv1K8iRPEFS9TyO14xK?=
 =?us-ascii?Q?dA+VEarf40Fj1ILWxJmQ4PUyxgKM7bdattWy7tTip4z0MDPKL9LbnwTceOhd?=
 =?us-ascii?Q?je7+n4H4ss7pHu2AfEY3K2lhRGZXEZrMlIX5k6W9doQ/h9x9kd+Xts1czerJ?=
 =?us-ascii?Q?KAnuPA5kem9lnUt/cfNhf7Il6HpeLTtrr1oSuAyRoZYQGiC1BNnKfGYXkp95?=
 =?us-ascii?Q?ZZvdbLnkSljbmr/OEsnwqBwAlsI/E0sZHJJup4nrITPpafa1MpU8VXUSf+qV?=
 =?us-ascii?Q?0HP5G2iZQk2ZTOEzSePjTlV79xi0gUJXt3F6CQP6U745X6Mc8mJWiP+BFRpA?=
 =?us-ascii?Q?XnClDdHem0FcVKD4/jIlnX/9/6oSFPewSFuhhVTpJNuJfeaC0lxPRX2cajLC?=
 =?us-ascii?Q?iFbDLm5nKBJX2pxo1tS8puDS55XEBjKLCFC7sTHyMp7cnBafbVEuUhpz27Lk?=
 =?us-ascii?Q?0cunoMt3u97NbJ9kZLmzJH9AJlQu10uJCVpYxgL1OJtzvAQ0gJCtwq+H4SEb?=
 =?us-ascii?Q?yMMBgadvCnDScejKIDE/oZQ28O8EmybszCPo8UQNOOWgBNnmczGyK17jGv7H?=
 =?us-ascii?Q?+loRQaqF5pzfzSk3fXvjA3BBg12ODn38iY8+qOXzycY9quNmgNc5XBFPq0Wk?=
 =?us-ascii?Q?4MM4hrk/A4aYFz7fe3eVPor/ALuI0tAA5GPgzG70vBxLKsvd11d7BiTlV4jM?=
 =?us-ascii?Q?lpHojWb9TRjxc6DNuUdgKiasOnqs1k18n4a6uhsM2VEGFI8tcEBecOawx4wu?=
 =?us-ascii?Q?WDLdMcXbWH7TyBm0em/RCvYMIbImXEE/HKbvMNKe3kkJg/0cw5cdwdgoQgE6?=
 =?us-ascii?Q?YuHNQevhWDMqEdNP4q0ktNTDV2ElEFHEPr8GHLX/pIFl1NYfdAxpim8p5lxa?=
 =?us-ascii?Q?vSSLr0yPCb4NccIcMuO7k3JwE8Lndz+pfSCSLbjC+DJrmjxOCr4HMbhkksUE?=
 =?us-ascii?Q?bAkcup+5Ao4HUMtAmwkx037yYEwMr/yZdl0ukgFL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vSj/+RxFgTDcAwF4Ujz7d5sunR7dbfF/VxpwqzKodqdhx3TZ7MhF5Gf/iRrg?=
 =?us-ascii?Q?HYkzZ0MiMRF3aTWHJoIrYLph3IkG3yiernBjSpyTWppoOWp0vGkrt7WjXONL?=
 =?us-ascii?Q?SwRE1dbM1tsq2Eu9jKf4wQlVDP5DgGBkhmLEKheGx3Fd645bTkg0gJjv5b/E?=
 =?us-ascii?Q?b5JG8HmAukx69ac0bnlT6Rwi+LmJMQ871jo/avroTyAxOVpf+APBNCiGwMbn?=
 =?us-ascii?Q?4ArUORu+zSmiL5ylkM09UKZU2GebskKrkRMJivUuU+x/+MmVbRWBftwtpaQh?=
 =?us-ascii?Q?3GM5xf3S6OJcMCV3DE4VwG9+wa0MO0DzSvnZlh9O3ruUGos7rVCIQzwcGyFI?=
 =?us-ascii?Q?g7FE1tgI5lr+niZC+/kGVvtp+r7Kcjrf+1JIkloswVrR+BRW4IDRb6HfXAcO?=
 =?us-ascii?Q?usAiFcQyNl7bt5fXGD7DmMm6q1uIoBatSwEFvrlGB4KI4O9aKYYbgaPqU5OO?=
 =?us-ascii?Q?ZYVnIuGMpfXYdMr/SB7+f3dkQE2PDkEc41xxvuc1ZPZZ0l58VXDOR17BI7lH?=
 =?us-ascii?Q?sqdUAJuncUN3h9R/JdnMwr+g800mvm3yxVzEyk4fWysFDpk9mJAa0KX3LJZg?=
 =?us-ascii?Q?PdKsqVWM70tQ0g7svHu4+nfmV43l2V6dLM7fEuq1phVQDTWH5LeI6OFVA9FN?=
 =?us-ascii?Q?DgquS8AkwgILbJgbTyQ3nqsj8ys7bdA0hpSbbhAEFseGsK/GKDPN8PkE2L+g?=
 =?us-ascii?Q?rX8ge570KuSDEh3MfEB+SgV+iR4kRP6FQjJAL8q8xdnnJnAbO/kaCPZ2F0y0?=
 =?us-ascii?Q?b3OWKKo6vv6ltQ1cD/3M0U5b+sLoj86ya9yzb2gTKQT6Zgpp5gYpue9sjzHc?=
 =?us-ascii?Q?r5oETv7js7N1bopLNy5gvK33q4tu2O0+de7fJKHbvBfedafGhEDPC82HVmj/?=
 =?us-ascii?Q?PN99z7bgQwxeZTne45HhFY8NwLAkl7iuUJyQIWhiXqoPtkxDvtQYbSKZORw4?=
 =?us-ascii?Q?Ci/ijM2G/2y8Wwz/7UT7CkJ3wNulXnLB6dQ8W517jvt3aZhBP4zQjdCqFzLa?=
 =?us-ascii?Q?KKBUjYJ4Rj6Td772kYSsbLb1y4rBk8UbW6Z1A6GiMNrZ7TsBtud9vikKWYhV?=
 =?us-ascii?Q?nuiD6wHQwQ5t91BpUJG22WQw//YygiN9iyC6M4RSuDdRKpyDtR4bwG8/cNG2?=
 =?us-ascii?Q?SBL7retK77G4WrdjRV56gWAEiXzNueFhTSybcOtHAlisq0rFVzNylrcM3Ihh?=
 =?us-ascii?Q?0SuB2+Mj4WP9Qt4uleSqGPDjPC+gbENnk3XWBQ2TEjG84xa6DmsRKxQpQ64+?=
 =?us-ascii?Q?gKkwx00CrmL/upggi4LSLiIVja+/bHOy/M0V5dV8p9njLirrgpxOcGzmkwKC?=
 =?us-ascii?Q?bVC0kTCcYvIKj+oEwsp5t0y5WBtdSBhYXYMEchHnwXNhx1WA6hLDMZZbvGK+?=
 =?us-ascii?Q?Rm9HU2Ch/pX3WHc8C0qOTfznb+nmr8VVMFnJsN+65QwVt+55X2Kq7Hmjqqfc?=
 =?us-ascii?Q?Aw4DkhnNI+FOFlJbF3tL5tzFcfG7A1XO8/FxsGiigE8T52utxisY7oir8Bdg?=
 =?us-ascii?Q?xoILslOR+ooKzBXvbFs4dUEhWq8T+59mHnJIaFEhwAhGegQ+MNYeKOdlSXyk?=
 =?us-ascii?Q?JEFN1N+y0WDVM536xXKb5tVRLDaRwx8OdjS3v1AlcSU3D1Veqr4X1R5kS2PL?=
 =?us-ascii?Q?X5/dCvFScBYjRuLxfNRuieNvvUuEYrVCmpFoiq5jRYtXUVDaQA0vmXti+c2g?=
 =?us-ascii?Q?Ifqw+MzPZ/YKIeDOpyPDGVk5TmfUGmR3NcHCqQ/JgQUiv1ko?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4af12a5-d443-4a8b-1000-08de601c4136
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 16:26:00.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyhESD2ILZr3lS9WnKOixYMYtC/aGPg4CCchvyxNwrceVaTuLfiG0PcAVeyAb4a4ZrUfjfANrAda+LTumzOhhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

Hi Peter,

On Fri, Jan 30, 2026 at 01:41:00PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 30, 2026 at 01:26:20PM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 30, 2026 at 01:24:13PM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 28, 2026 at 02:41:40PM +0100, Andrea Righi wrote:
> > > 
> > > > Just to make sure we're testing the same thing, I'm currently using
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git, branch
> > > > scx-dl-server.
> > > > 
> > > > I'm running this test inside virtme-ng:
> > > >   $ vng -vb --config tools/testing/selftests/sched_ext/config
> > > >   $ vng -v -- tools/testing/selftests/sched_ext/runner -t rt_stall
> > > 
> > > Apparently you also have to actually have that runner thing built from
> > > that tree.
> > > 
> > > Anyway, all I seem to be able to get (on x86) is PASS: 1 :/
> > 
> > Argh, that tree has the dodgy 'fix' in. Let me go revert that.
> 
> This seems to work?

Great! Makes sense to me, I re-ran all my stress tests and everything looks
good on my side. FWIW,

Tested-by: Andrea Righi arighi@nvidia.com

Can we route this through your branch / want me to send a new patch?

Thanks!
-Andrea

> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 80c9559a3e30..aa3da4d3b8e3 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1036,6 +1036,12 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
>  			return;
>  		}
>  
> +		/*
> +		 * When [4] D->A is followed by [1] A->B, dl_defer_running
> +		 * needs to be cleared, otherwise it will fail to properly
> +		 * start the zero-laxity timer.
> +		 */
> +		dl_se->dl_defer_running = 0;
>  		replenish_dl_new_period(dl_se, rq);
>  	} else if (dl_server(dl_se) && dl_se->dl_defer) {
>  		/*
> @@ -1654,6 +1660,12 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
>   *   dl_server_active = 1;
>   *   enqueue_dl_entity()
>   *     update_dl_entity(WAKEUP)
> + *       if (dl_time_before() || dl_entity_overflow)
> + *         dl_defer_running = 0;
> + *         replenish_dl_new_period();
> + *           // fwd period
> + *           dl_throttled = 1;
> + *           dl_defer_armed = 1;
>   *       if (!dl_defer_running)
>   *         dl_defer_armed = 1;
>   *         dl_throttled = 1;
