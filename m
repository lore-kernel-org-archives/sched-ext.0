Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E243284669
	for <sched-ext@lists.linux.dev>; Wed, 24 Sep 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702400; cv=fail; b=XMJUHzOuUi/DDF7n2lU848tb6FiqzV1hZNGK4UO+uvxnnd6B7dUpuNYqXgPROn8HLgy6pi0PoXSoeBRocaFG0EHrFQdrwl4PccaA6aknCkW5I+o9DB4Ph1F4/akNCTZY2r1FKPXVq1R+TGt151lYsvgRdk15AhMoT/vBH7cXTc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702400; c=relaxed/simple;
	bh=M4Nd8zp/zEQtw+kz15SuWHKcVzJxEUQitQQX9XJ+RtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LASB/Yea6pSHDGFLEgHKoc5QkTgDoHGMQHFi8mq1j+Hh+aryJZSMqQJe7qOj9uT3kDIfpmPBX2FwkvNXl8i2pkMydXRiKZytP5y5J8sfLZFJzPEVZ1a0h/CbDTNjTfRdfHZ4SZT26E9IAVpmcIFoD1iJku16T71Pljs7kTLNyP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n6QsOmQE; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n6QsOmQE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvQpnYKCTDVSd7m9UHnWM9w2VjbfBnuyPbWyBy7twzVrBhh1DjjSTGY4/osJX0fP2j6vKyry+aEUIAx3u0Df+egQLz8Z5oAy7/vSZWte8HOCPCTH1E5ZLlh9tWE6M+ls8yNL4WF9g5exSEMI6Ax23TgqxgiJipFNo/qh50osp3HhBKZ70R1WKauQui2QwCq1qZ2PPseu8sM4UhTjY7PEpaoB5hdJXANCp+gBqlsor9RCmWOIiFKRNFA9tgxxUuZLTiWfALB+Rv1fp3GcStbHVQH/8NOPwL9R/cBi1WxpxOi2hz0oEGJOeUrz6BVMTWUD4dOSlUgN9xnidbJMmhaDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXB3haVWorDdyJnTEbDsxQI55aIffIXvKQn6RMuFo0A=;
 b=RTOCgpx9wzD3I7H0GjkY5oeTq5I0qCl/iJBW60/8SlmMejXGosY9XWp7DHh+4i2Z7ywIyHlCWuo1GX6rbVAlDzRJ0fc8QCgtis59xKFbFFEFIOwx4mHZjR3GMwSlX5wNdowCSLULtqs3kq4zmhJDsQOgapJfkXEZupOAn05SEQ4HM4N3lkuLpvlo68xdvDgww3XI1Htp09nycdutAdZFu5wGHaGQcRbkGB0Is0sX8NydvpkDiQYbuS3517Al2wwFEWR/4p1FiNBfov7AOz3/fcKMnFbGqvzAaTyqRHMNl7YI8K1bqN02vYbZuuj1Rlwk8K2I7RVdrHMSNYOtqNtykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXB3haVWorDdyJnTEbDsxQI55aIffIXvKQn6RMuFo0A=;
 b=n6QsOmQEJ08Isu5f3kED113kV+ZTBRBtj7JreuWlr1O1Ge7WfXy5St/R0WduzfHSHlgVKsp6cigJqsUGKYLQ2zqXUtWrt2ZBLpABKDOVJrfUyuPqZ7PKXCj2TgBI3tWmM7xxvj915pPN5zSJ1Qn3magEsHJ5AANpkhilptMP77zrxkTapXBHSvhgFs01hOCkXxwPXs244QhLPMraJlj8U2UxWvtOdezjWcUfjSlBBuAqEkSPgzkQtrIA5RluYwoU8fAHHtYrIww8kup4MZP1tmEGlgzUYcn0GWk2WrT0D23TxqqcD1GhKJ+VIGsPFE+XDUjIA2kTaBfC/uOoE+Nm3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 08:26:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:26:34 +0000
Date: Wed, 24 Sep 2025 10:26:24 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of
 rhashtable_lookup_fast()
Message-ID: <aNOrMNYJipF_nTGD@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
 <aNOMK1gk9if3UTgQ@gpd4>
 <aNORzVQ6OVkPHAjS@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNORzVQ6OVkPHAjS@slm.duckdns.org>
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0ef9b8-c4e6-4041-f402-08ddfb44123e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2q+TUtzvsv0APT4j2wLlF+Fr5m0ZifJR2mkPrlPb25Don2/h6mk/dj34dFBy?=
 =?us-ascii?Q?V+sGoEMNcqzpyL9wg4M/OnOBl/jyl4HBOo9uXO28/Gj0r17ilr/hQQcvc93w?=
 =?us-ascii?Q?ndx7ig0xFj/5Lyp5CYqy7DqVLeszdV9+OnJUyM+0xxanuJbo2UngSkNsxuhA?=
 =?us-ascii?Q?vfbetxd0H57qTXdMvnZXG4WWGmT+SzB1+xqDDkKqhhMHlJ50KGmwpRe9q0Ej?=
 =?us-ascii?Q?vN62pDABGMIiPTSLcBnboNFtovDiAnDLKJhc3xmCYjQzZ/fVdfdjVXSU/8DY?=
 =?us-ascii?Q?ttWJ2878BzetVZI4k8T3o1BY+ATw6lJO6VHLKtU1DAGjEpNtJ9LrBdTGFhsy?=
 =?us-ascii?Q?FOmkAFxbHzkdaM8+FVVae03ijkIQXRwvMm7IM9YR/t0UjzGIrlajszR/bapy?=
 =?us-ascii?Q?LxStEbhgI1qjd97gfFzXyCWiOsBkMiTLjgVrAe/mItFlVJjYtz062fyFclEk?=
 =?us-ascii?Q?wHxVwoX38t00ubTpo8eqU92JC4k//tAyD+V90Ku7cydZOHWeJFBKIQQQDPXp?=
 =?us-ascii?Q?aewMq6tWI4c/Q/C+6msVJFJF/UKtsX04PYrDPr4wDlimP9NiJyIoRwHCbM9N?=
 =?us-ascii?Q?va2sMV9WZUMxLxwepX7hxEjxvRmbT4LLSKxfRevcYmu/p8WDa+v34HsR1le1?=
 =?us-ascii?Q?kNmHWWEQ2uEYNFyuuyp/gHdmXyq1AD5l17vfvF+it+7fVmay7vkPv5GYfgFC?=
 =?us-ascii?Q?vPwzkDHz/M+oL+pyUygCqd70zi5t+UeC0p3aD2WDjl5pewsWgsJsabTGpT5W?=
 =?us-ascii?Q?uiOaIuP2M84a7TRdDGPyj4pqL/I4x/ZPQDMyt2GliVlNn0nqIiD0LSTQQTcv?=
 =?us-ascii?Q?TIqvXABpQgG/3WrE8F8f2IRxtgoyY/7ZAGALN+aXPZmaK/YuHEZgKWfzJJYU?=
 =?us-ascii?Q?EgZAM5C0FF5pDoKRi3P03mU1ap/nGNGAe7lHcpvW9237yJT1SXsgb+fxmeui?=
 =?us-ascii?Q?B9kax82OKnYC4F9HJFXivHftz+fqwYdAroC6dx9ONzVyfTvqcQBFuUORlK9M?=
 =?us-ascii?Q?shFX9RMBDOL9oimLRMOLRN26FI/3/XqCnkky0e5wFN9SeLsjigXJXbFg1bby?=
 =?us-ascii?Q?2UfRFzDemR65JPp/fdcxampOJlMkZOGUS09JNmONC84dUXCoYhPbtugXY7Y3?=
 =?us-ascii?Q?6XjGKl5KZmxhcDFQa2TlYyJPhjsv3SDja4oKBEeHUDfCkrEt+BrllnG5JQO9?=
 =?us-ascii?Q?oK5j0g4oqZNNHd/SEUt9iQgylvEwJ74Lv9c/ltFOsHZNSqvTsrJcYnp7DbRw?=
 =?us-ascii?Q?74N0VqxOURvDtt27I8iNPCCFCIEx/6L1hRN0WpUiaO4wZsJN4+iO7XyYChWd?=
 =?us-ascii?Q?2k8nCM1q58YWWUQPSosokr7RzkAxLgQA0fzigBfeSxC0jo5sT42meXQPbGw7?=
 =?us-ascii?Q?llUatmnvQzAbXKbobvZ7wIyQYMQObLFplPHNcFKdyQ4qnaAWxhA0z/tguxp0?=
 =?us-ascii?Q?+IY9obX71Ks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1kzsmS+sg/WHbLBSo4D88kfYDT9Bb2uZsm0r4l9OX5ue0de675syjttoANIg?=
 =?us-ascii?Q?hQa0t0Sg9e29YeGqzbWgFFcd8b6JeXYwotepDmjxaAM6rI/OCGR3xvvEi2XV?=
 =?us-ascii?Q?4BzYXkUl1fcwYoMGgwecaxvP85gaA/C9aYZam1YGE+UWZlRp1T0T1sxrcIsz?=
 =?us-ascii?Q?8IY1a4I/c3oCIc8uzcpOUD7JPDI9x5+g95l0aVgYONpeeF2aU92qvVdm9FLg?=
 =?us-ascii?Q?41fx6YK6RijaqSgBvArmq/d6OzBbvJLJvvd0cYlAHOnDA0OA1jFYdJQAcUDy?=
 =?us-ascii?Q?sTcopmWlIrvw4wFsCMlD/xRd1jQ32DlrRR2zK38Ev7iG5PBGPkF/WWeH1H6E?=
 =?us-ascii?Q?MdvG6fVzThpvtkYviuitmMmzE2l70vvxNTQuTZUIOUCcAHm8wT/+mVIc9Myn?=
 =?us-ascii?Q?hgVA9veKlzL7tjrXGsDKAqCh6eFJXcUaSQ6D70KyqMIf57xpwKw2SinKX4Hp?=
 =?us-ascii?Q?acrCv4xE4VvLrqp77ZrX2J+n7VhBkPuHFdTIzYXyp9iAuE88sY6zGh7aUHig?=
 =?us-ascii?Q?v3dY9byrgQroEA2AnuaB7DdsKCWN/B96XiSsPFOiXb4hsqTsLbYVryZE5qCD?=
 =?us-ascii?Q?Z0pZwuVcCk7fDtgeyo8W5KIxQndQQw0dl5aO3nw1L/tL0fzlxzoKnjd7QXkl?=
 =?us-ascii?Q?MC/5GmVfF0ywOjuV4YMAok9+1RUAqqp7YqTE101to9BuP2b866L9sLhAVMd9?=
 =?us-ascii?Q?x8I6SyNkIu8LHOOcoaPu5aGmp0OFvtR6pr8Pkfw6X7SRA6lRC+OYXhFg27MQ?=
 =?us-ascii?Q?FCagZE9GN89ipqA1KDqMGmZt4RFZjese9MdjurBiLa+VEFN+5PAMw4SY7AWN?=
 =?us-ascii?Q?HhXkPGGak/IcSlVy0tB4XNIDlDd2+U3R2fchTSqVSXYjIZEeBpeyplNYXTkE?=
 =?us-ascii?Q?CuYLA3dbCnCWLZD7Hc1Ewj6UT7wSjJ2PVDf9An61agtgIk86DRsLrF6DGwsf?=
 =?us-ascii?Q?cdGbpPoHbz9DASClBoFqkSoEtKjIDn2J9ix1DifYsvNN7218lYQDzqBGSM3a?=
 =?us-ascii?Q?3HS6xCcFRR/28kYT9we13Sji+irsP7sko8pc/hkzHZNdHkPLvgmqPWHcXb5J?=
 =?us-ascii?Q?ZS4lVRWwqSz32L3ETFCXv00Xhsry3piE/QRBkU33ed+/UPKapdpGw8bEN6P7?=
 =?us-ascii?Q?L6dyR0fefTbl5ZhzmWS1L+x1OJvJmmhKnjQt2WiMF4CSl7vE0AIHbhLV5Hr7?=
 =?us-ascii?Q?C7Lw8s5bAwBgLqEbgntm2/wXGKPbtaYW/1V2eCixCQi70+M/nx5SQbRdVlyU?=
 =?us-ascii?Q?or4FZlyb2Xo94JJzX+1nDt2jJt7R+qAbbkFclCk+j+VQRsIICTbh/3bf8M1K?=
 =?us-ascii?Q?xFfihGC3q3js0j+Uqbjd85ywdUeJ484mwewcFm91Og/zc1zVOQhSF4KE31nd?=
 =?us-ascii?Q?6PJ/1BV4sth6yMbslddPpw0/qRuz9AYfY1ikfcl6CpnU2nnlFqgtNZ4to5sU?=
 =?us-ascii?Q?FEZhe0QXtgjWzE1yAQ8+x2wmDMMTH64frRHUPCqNkDYrcmNen7wznSd64OIi?=
 =?us-ascii?Q?amj3P8GH2TfKYop+RbmzzyzpjP92a+v+IyZGiK5rzGkw7ViQAtnMUhBYs5Fq?=
 =?us-ascii?Q?oOITi80PxMWik6MKv1nWig6Q6hde5IxbD8Pr8r3h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0ef9b8-c4e6-4041-f402-08ddfb44123e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:26:34.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpVUdcBomCYYKWPJOhj8SvOWhFW6o6UmV63kHFFtPrRc+/yn9ehFCcs+opLMdw3Bmz9JQghbzemWbh1O8Z1CAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973

On Tue, Sep 23, 2025 at 08:38:05PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 24, 2025 at 08:14:03AM +0200, Andrea Righi wrote:
> > Hi Tejun
> > 
> > On Sun, Sep 21, 2025 at 03:32:40PM -1000, Tejun Heo wrote:
> > > The find_user_dsq() function is called from contexts that are already
> > > under RCU read lock protection. Switch from rhashtable_lookup_fast() to
> > > rhashtable_lookup() to avoid redundant RCU locking.
> > > 
> > > Signed-off-by: Tejun Heo <tj@kernel.org>
> > 
> > It looks like the ttwu_queue() path isn't RCU read lock protected.
> > With this applied:
> > 
> > [    6.647598] =============================
> > [    6.647603] WARNING: suspicious RCU usage
> > [    6.647605] 6.17.0-rc7-virtme #1 Not tainted
> > [    6.647608] -----------------------------
> > [    6.647608] ./include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
> > [    6.647610]
> > [    6.647610] other info that might help us debug this:
> > [    6.647610]
> > [    6.647612]
> > [    6.647612] rcu_scheduler_active = 2, debug_locks = 1
> > [    6.647613] 1 lock held by swapper/10/0:
> > [    6.647614]  #0: ffff8b14bbb3cc98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x20/0x90
> > [    6.647630]
> > [    6.647630] stack backtrace:
> > [    6.647633] CPU: 10 UID: 0 PID: 0 Comm: swapper/10 Not tainted 6.17.0-rc7-virtme #1 PREEMPT(full)
> > [    6.647643] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> > [    6.647646] Sched_ext: beerland_1.0.2_g27d63fc3_x86_64_unknown_linux_gnu (enabled+all)
> > [    6.647648] Call Trace:
> > [    6.647652]  <IRQ>
> > [    6.647655]  dump_stack_lvl+0x78/0xe0
> > [    6.647665]  lockdep_rcu_suspicious+0x14a/0x1b0
> > [    6.647672]  __rhashtable_lookup.constprop.0+0x1d5/0x250
> > [    6.647680]  find_dsq_for_dispatch+0xbc/0x190
> > [    6.647684]  do_enqueue_task+0x25b/0x550
> > [    6.647689]  enqueue_task_scx+0x21d/0x360
> > [    6.647692]  ? trace_lock_acquire+0x22/0xb0
> > [    6.647695]  enqueue_task+0x2e/0xd0
> > [    6.647698]  ttwu_do_activate+0xa2/0x290
> > [    6.647703]  sched_ttwu_pending+0xfd/0x250
> > [    6.647706]  __flush_smp_call_function_queue+0x1cd/0x610
> > [    6.647714]  __sysvec_call_function_single+0x34/0x150
> > [    6.647720]  sysvec_call_function_single+0x6e/0x80
> > [    6.647726]  </IRQ>
> > [    6.647726]  <TASK>
> > [    6.647727]  asm_sysvec_call_function_single+0x1a/0x20
> > 
> > Should we revert this?
> 
> IRQ is disabled, so it is in RCU protected region but the lockdep annotation
> isn't happy with it. :-( I'll revert the patch for now.

We just need this: https://lore.kernel.org/all/aL_4gCJibYMW0J98@gondor.apana.org.au/

With this one lockdep is happy.

-Andrea
