Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C163128B6
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072611; cv=fail; b=neMmOkMDvYNSpg1P1Nc06NH0MjfOduIWijh8ucHe9VCM0/Cox8nuSvYAhhJUIhzAd/atMxyNquPW+An6WYQ8YBpC+CvaFb7E7TNOpwUT3roQmIP+HKwyAzQU6CqD62HbOHGgB8DqcRX2Tjld1n620JEgSDAcZI9QmKIPJwxbEHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072611; c=relaxed/simple;
	bh=VuJuWZ1YssQZ2Rfql8Ub3yJmBOUCLG+X+iazZQJt2BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jLdgRjAo6pNdwPLdZ3YyGXs96M8ZDVHLAyPiOIMcKxGtBR5hQy5hbhg6eKZeXaUhS9dHo+LuH8yQuMhq9v3HlR2awFED9sELztYYIzgitA4hYfzAPhqtN6A8408NArT58K836kJDiAek83ogsmCiwmd6J5Yo2zOxrvNnzFY6qC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O+aLRsZ2; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O+aLRsZ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxHShTPIgSr/z1UbGfldLKo2LcC0R4uNp8X6i0WBpaQCPP3YyeqXKCrO+fYmq2VRLn0QIynZf/J2M5p/huq4MNXWGLIxt0ERrRxvnV3N0IdEvWBJfkIr41Co4sqBIYHOsb+FTMysu1ZjrEi43onVDmoaf7cEudUA/txxj3ezosY4cMvT7d8Kq0GnXZS0BVDkdkpf9SYNRpZuJs75q5B1SFApzGFc3g/EnZvMc1PxFsuVUxmn5qaoMLEF5LmO5T/H0lu4rz+qFjM0im6YQXO1tfgFaRyoyRfPZnaano76EjdCp+yyzEMHa9FJa0x5pYjbdcB34+W+GOKMdRmmK/oLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHhsTlciQdh/gvh6qxLaA/aZA1rpDfKoMErNNxxuCMw=;
 b=mv5wZvFF8WRPlL+fTcngSlUnBfBSdRccsBP/vUxR0bWBQkL/ghn2TWbzj7g0IHbr3XQEwMkwm8QuLm+ctxoa8BWMxaQIXnqBSOInmT1MRMO4mRoSYYxkKfyAX5gfyBmH+qFkl0I/78ebAhccZ5BAzVB27L6w8AkfUSDa+YATzsfd+R/VDcF2hsaLtRfaEwsRyw+scs6UXLEV5YnncGUsnTztv4mX/Bog4SkHxWbKWGY/Nj3dWi0l9wqzN1W1PpgncJoDIe0VxVhKIXx4qhFYwtv6MsVLO28D7FiXVTaQuJn2naSpXQIRgNKQM1DSN3oR2ZVPh7hXlG2gb0+/NwMuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHhsTlciQdh/gvh6qxLaA/aZA1rpDfKoMErNNxxuCMw=;
 b=O+aLRsZ2R3k4sQHAHjOkB4ZKrUzDwKd2cHu/eySvmY+bZPB1OWjd9N5js4283TokKe8ncYgl+rhmndlsXwgrDhlmezc42ZIvEg7fS74v0eEqTvi49LuFf33P2V2deyxNuSx4//u7Xbu4v39YnJO23No+NLiZ6rv6BgMHy7JKEqBUc9hH9oFaeAGWmhSKIuWr+r+2YBe1t40GBOcq1PItOpSM1p84Wv5IL7EDY0zz99xJThjtMoVXhj3tddfCCmcnWjINpesd3i/IxsGouLdTrwCOlrPWnNlFXENmiEau1584l20RzUaL3G1en7GpEVl4JIbEzvHkE/cUHp52Y3mpKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 22:50:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 22:50:04 +0000
Date: Mon, 2 Feb 2026 23:50:01 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix NULL pointer deref and warnings during
 scx teardown
Message-ID: <aYEqGSGzxrYU5PZt@gpd4>
References: <20260202151341.796959-1-arighi@nvidia.com>
 <aYDaao9Xb_Bkv0NH@slm.duckdns.org>
 <aYDy-tCqsH990lW9@gpd4>
 <aYEOdPEkgA2eUcTE@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYEOdPEkgA2eUcTE@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b551c17-5ab1-44c7-643b-08de62ad67ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llP+fToSEVsdoQvT/A+iPY0Cub2+junaqYAdlP20yW2YNbL1OW7gaKs0a99o?=
 =?us-ascii?Q?RUa1G2TrdNhCp3JDISHnkzapuYrl+/r6xOfspj2YgzU0ygiaKAZ+IkxEfY7f?=
 =?us-ascii?Q?BL98mgDS4zRDp1mXZpz4wd7lcVDs7rapw37Uk+p1JXrZKqM2ipTK6x4Z9MYe?=
 =?us-ascii?Q?/2PH9fHw0zQfxpaFJIj1+IOx6vxq30cT8hjNRLHS8gkahwC/upNTgTMbLlVr?=
 =?us-ascii?Q?/XAtvcKyGQB7kTtaWUhyL8dh55g4c2oWWJaJp47oIb+hSO/kccoJAqgKp64j?=
 =?us-ascii?Q?fkY4sVR09AhUqfXYHP8ielPMmPvE9TiA7cDFuHS6RlZliQvgPS8DfTdOEndM?=
 =?us-ascii?Q?kKVn4wcz7Apwdq4MBTXJg1M8/ZOw6LbZTRIFDqGskI54SuybvoMSJG/5SrsS?=
 =?us-ascii?Q?DHRckPS1wkSPI9wTkFVeeC7EGEzTn7YYi+BsciiQ59ZwWs9GhwNBVz8MTE9U?=
 =?us-ascii?Q?8emxEEBebVG18s98PsdODxr7XLwmEtq0dDY8H2wOommjZBbRcVW3Gvx4+l+u?=
 =?us-ascii?Q?1HMJ1CJxhW5knd3/iwA/JrmrfJUhpqAj2hYH0xhBiv1oKbocgUNNqrIRUrle?=
 =?us-ascii?Q?xHj3FoPutC2dsoeoCHv3aHgsewn1SKu//9WRAXIKs7fVbHsvRa8WcuD+p6jf?=
 =?us-ascii?Q?CXOyOH7p0DeLtjwL0ymE9n1yLiFp8CFLkTIw9qnQb83mCxEuoYBQC6+l3T0J?=
 =?us-ascii?Q?Ddk8gYq5fxLxkT6ZUiTZagzDxGACSn0x09mg5/04WvO0VHU8UcEyb0rmXr/P?=
 =?us-ascii?Q?by17uKDw/AXh8bBvBFcAWbJlEABLpLGd43D0q+GGCdDZoFBLglhR9KgdQ1E4?=
 =?us-ascii?Q?qmwaTgIMKpEx2Asb8gBWKfk7rq4l1c+KXov6XVo85JsgHZsIpz6uOhKcJmF+?=
 =?us-ascii?Q?utHENaQszISP5I5Obix9+hu/DJy8bguss7FhNteTa7PqADQ5waIo3V8PihME?=
 =?us-ascii?Q?rdrFKBzta1qztuM0LSFRGSFyar1FW7/VTsVGPuo5ac4ORufXJbEiq8DjI5FW?=
 =?us-ascii?Q?hr+V0AegvFgw1gGWF8j8ndqsvZBpSHmuMugDpN3xpjzF6+p0ra1HB4tsayqU?=
 =?us-ascii?Q?QHe/SRSCmwhwI6eFvUvf47ewiJyq9b2jwg20MAJwXp7aIbQtcQSZKHTzv+Kn?=
 =?us-ascii?Q?Lm5IfYvw2DI0ExwdtGYqOH2VbWE8BCXaB/4mlX9rs8dxJ6Uhrveacp39fRhn?=
 =?us-ascii?Q?oAeEfwA2hFO5J34DdUeCquj3hBnFxg0Op0QggoHU26LZHwRQE/5KlB6SXD6X?=
 =?us-ascii?Q?mLf1iMEqsBMDyi4KZD+E7SNK3+UqArK//QLvtEZtfe45lUl3iWFgfI/5q/pY?=
 =?us-ascii?Q?VtkPO+ovcyE10DAvhdkhnIrYINWgzRCE60lQ8ZdPktWtVzz6OMNS4BmhhZ7i?=
 =?us-ascii?Q?4slRlsEITcDIpfoKb0BuL7Nj4eOcd5fNj+Xg3d+wNhRrRe07A2DUvjTwq54D?=
 =?us-ascii?Q?oIGVV7tIWEIg7yfwlP010SDhlE6f2MWVK7pu2CBaQRLZiF6aqpfb+U47mPqn?=
 =?us-ascii?Q?5qPYveTyEhxA+LsLLr8IiEnEeW/bf/NwpizopzLHIETUXf1ajP4UiB8aUlqU?=
 =?us-ascii?Q?Nui1K7YZRXsofWatcLc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBjPFstVNycMJ+MQJIMFHfxPXYmOKMFnxwq4ymCaUOI4aLd1DgLkjGJSTi0b?=
 =?us-ascii?Q?Mj3U0LSweDcJPxDOW2WJPAOPuD/Li25PdwekBh95L28AYI0cw2JwbDiEYb00?=
 =?us-ascii?Q?0iErIOtv8Nm0YdeuYtl5oB/Dv1srE28ihMqRqL0KJn6oXtMfut0oa2b5eIMp?=
 =?us-ascii?Q?cpMjP92qnKuf+C35Z5RaSN4+yZWc9/ZG3JHvKNE54ORGwXO68d7pIMmz9K+/?=
 =?us-ascii?Q?cnFNn/FUDXgTvsVz2N+iuPZWOItTcwEbPmjMHR0Twteb0a5sNdYnoucVoy+6?=
 =?us-ascii?Q?bY/welLR5iD6R4mT/V4Dv7TU0TuR8G+AwXrhXUfCh9s4RYWK4HdH0Q2bUnxF?=
 =?us-ascii?Q?d7dmjq/WXhedCV2VZLNI9rMvq61WG19LxpfkCU4D2WLpyAE33x2sO6NUJnMI?=
 =?us-ascii?Q?jxqP7YtMuYbFehLqagA6ag+xhSn/2cZzQ7m2Z116Ua5RHNGi5c0iNKdrQ+0p?=
 =?us-ascii?Q?lFAE5TnE/d9vPTyDaGO83Yucv7hU4s250F6e37pz+HmpWBlh3FCaTLnv1BfA?=
 =?us-ascii?Q?s4GT3FP080Va5zdG20KOkYxEyOJYgGUhZespquxM2Jit2yVCm88BDpL80pYX?=
 =?us-ascii?Q?GDM0mwzVIbldWGP+2InPubGYAGEE0lU3XQrzEnbqvr37uCrF6/CiP0Y6s48x?=
 =?us-ascii?Q?v+WHrNhBRDKMmmcyH4UD36LXmSi6+YyKm8RTEXdeftgeVd47720HDOzlUnjH?=
 =?us-ascii?Q?6ItGvIqeVLpK9GmlynOC7TPEeJuiO5e+uxzSffQqhfoC9ELNjKzK7UG8Olcg?=
 =?us-ascii?Q?IDCzIRun0hjlEkdn24rfqt42GzNCD08ons8JLOLxjsu0yreD10N7d+SGUOum?=
 =?us-ascii?Q?1stNG20ICDwAjsqNVqL2uV92uN/iQJWM3D31iQizQooq6W/G5YcSEjcEf6TH?=
 =?us-ascii?Q?xt7dGjkgyMoy0YvSz4qKOFMfsP+yQCtQqWklRV+BszVWm0J/HGLTI1EkTMm1?=
 =?us-ascii?Q?nxTbEqO+om9YqYCY/YpeRbF91vXaEGXeykApAwJ35eCrSlhPY6ZV9sa36JbK?=
 =?us-ascii?Q?ZOpKbiJVSBVIcC9zfbQYp+5es/Ph2+1LYPPI6nXiNs4uICI+dK3LJk9wM+m7?=
 =?us-ascii?Q?Rj1dw+gg88O203j+wazXln3hXCI9QwrcGd5OoR/NirIgSo7XaDbuXhg/6biW?=
 =?us-ascii?Q?alOs/zbplrj+lOhBVYPqfkK/i02h1+AS5xl7fGcfcWLgoUXnvW6PlObcNDRZ?=
 =?us-ascii?Q?Mt67IOR864EiZ4uHNKJSTWfuOyFrLEF5HlQ3LU9z5vfbIEEFYBppnfdT4BMF?=
 =?us-ascii?Q?zqOQjbU6dlK0/E2mKRWOC5rOB7R0s98pLdpXL376yktqUtzUkR+wsugpbPtY?=
 =?us-ascii?Q?6MktlBmuI0Dxp7VP7D6gQmBDWVIBY+QF+OnLGHCygyjbjFQbcZcXHIXjz6GM?=
 =?us-ascii?Q?q3lvmitPECx9lMhDai9AS5M3b+Pq1McsxFXaZhODXvchMdt/o3DWp4W8ptw5?=
 =?us-ascii?Q?o0/5Ds2Xdzi4iHKKVg4H2nvVkiLOR5ofLBvuLboR+WV75O47swS2isepPIlt?=
 =?us-ascii?Q?XHqIqCmye8dvA43bkYjXmzzjLUT8ts2Cxa/ljpgJ2fEWdNrnv0BV+AbBL2Nm?=
 =?us-ascii?Q?G/NA98ZNmv1XbIa8YWT1oSBcU1ubVHFWoVjZr98nmYMsGghLazzaJfeToenM?=
 =?us-ascii?Q?xoDTzQPX6rFSykLl23d6tYzZ4KyD+B8yeTL1qcl9YgaHRR9JDrxa1Bm5x68T?=
 =?us-ascii?Q?fdWoZFZ+a1Im7/HUAByXkieT1WbRxnPMsle6f2x+v7DGXgWKr0WQKdA9DWXE?=
 =?us-ascii?Q?ry7YkGldRg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b551c17-5ab1-44c7-643b-08de62ad67ce
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 22:50:04.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsaQ4Seb88DwU88B8mTGDXmPHvU7dTs5OW4lHJEKEdf3r9zhWGmQq/yM4Pz8+vTzqzbP+/DPhHnnKYOPBWu8Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

On Mon, Feb 02, 2026 at 10:52:04AM -1000, Tejun Heo wrote:
> On Mon, Feb 02, 2026 at 07:54:50PM +0100, Andrea Righi wrote:
> > I'm able to reproduce the NULL pointer dereference in set_cpu_allowed_scx()
> > quite easily running `stress-ng --race-sched 0` with an scx scheduler that
> > is intentionally starving tasks, triggering a stall => disable.
> > 
> > I think this is what's happening:
> > 
> >  CPU0                                      CPU1
> >  ----                                      ----
> >  __sched_setscheduler()
> >    task_rq_lock(p)
> > 
> >    next_class = __setscheduler_class()
> >      // next_class is ext_sched_class
> >                                            scx_disable_workfn()
> >                                              scx_set_enable_state(SCX_DISABLING)
> > 
> >                                              scx_task_iter_start()
> >                                              while ((p = next())) {
> > 					       ...
> >                                                p->sched_class = fair_sched_class
> > 					       ...
> >                                              }
> >                                              scx_task_iter_stop()
> > 
> >                                              synchronize_rcu()
> >                                              RCU_INIT_POINTER(scx_root, NULL)
> > 
> >    scoped_guard(sched_change, ...) {
> >      p->sched_class = next_class;
> >        // next_class is still ext_sched_class,
> >        // overwriting fair_sched_class!
> >    }
> >    // Guard ends, calls sched_change_end()
> >    //   switching_to_scx() called
> >    //   scx_root == NULL => returns early
> > 
> >    task_rq_unlock(p)
> > 
> >    sched_setaffinity(p)
> >      set_cpus_allowed_scx()
> >        sch = scx_root; // scx_root == NULL => BUG!
> 
> Does the following patch fix the issue?

Nope, I can still trigger this (with the same modified scx_simple +
stress-ng --race-sched 0:

[   15.899233] sched_ext: BPF scheduler "simple" disabled (runtime error)
[   15.899447] sched_ext: simple: SCX_DSQ_LOCAL[_ON] target CPU 10 not allowed for stress-ng-race-[726]
[   15.899586]    scx_exit+0x50/0x70
[   15.899655]    task_can_run_on_remote_rq+0x8c/0x180
[   15.899735]    dispatch_to_local_dsq+0x61/0x1f0
[   15.899900]    flush_dispatch_buf+0x15e/0x190
[   15.899994]    pick_task_scx+0x2b2/0x890
[   15.900058]    __schedule+0x683/0x1250
[   15.900135]    schedule_idle+0x22/0x40
[   15.900263]    cpu_startup_entry+0x29/0x30
[   15.900330]    start_secondary+0xf8/0x100
[   15.900394]    common_startup_64+0x13e/0x148
[   15.900539] BUG: kernel NULL pointer dereference, address: 00000000000001c0
[   15.900660] #PF: supervisor read access in kernel mode
[   15.900724] #PF: error_code(0x0000) - not-present page
[   15.900787] PGD 0 P4D 0
[   15.900822] Oops: Oops: 0000 [#1] SMP NOPTI
[   15.900872] CPU: 9 UID: 1000 PID: 350 Comm: stress-ng-race- Not tainted 6.19.0-rc8-virtme #43 PREEMPT(voluntary)
[   15.900992] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   15.901068] RIP: 0010:set_cpus_allowed_scx+0x1a/0xa0
[   15.901148] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 48 8b 2d 37 39 6e 02 53 48 89 fb e8 16 9b fe ff <48> 8b 85 c0 01 00 00 f6 c4 10 74 50 65 48 8b 05 ba c9 4c 02 8b b0
[   15.901378] RSP: 0018:ffffd432c0e27df8 EFLAGS: 00010086
[   15.901442] RAX: ffff8cbc827db0d0 RBX: ffff8cbc86870000 RCX: ffff8cbc827db280
[   15.901537] RDX: ffff8cbc86870000 RSI: ffffd432c0e27eb8 RDI: 0000000000000200
[   15.901624] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[   15.901713] R10: 0000000000000001 R11: 0000000000000001 R12: ffffd432c0e27eb8
[   15.901807] R13: ffffd432c0e27e50 R14: ffff8cbcba218500 R15: 0000000000000000
[   15.901900] FS:  00007f398e11eb00(0000) GS:ffff8cbd23723000(0000) knlGS:0000000000000000
[   15.901998] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.902072] CR2: 00000000000001c0 CR3: 0000000103f4b000 CR4: 0000000000750ef0
[   15.902195] PKRU: 55555554
[   15.902232] Call Trace:
[   15.902268]  <TASK>
[   15.902302]  __set_cpus_allowed_ptr_locked+0x142/0x1c0
[   15.902368]  __set_cpus_allowed_ptr+0x64/0xa0
[   15.902435]  __sched_setaffinity+0x72/0x100
[   15.902489]  sched_setaffinity+0x281/0x360
[   15.902543]  __x64_sys_sched_setaffinity+0x50/0x80
[   15.902608]  do_syscall_64+0xbd/0xf80
[   15.902660]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

> 
> Thanks.
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 136b01950a62..1fc2b358a175 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4234,7 +4234,13 @@ static void scx_disable_workfn(struct kthread_work *work)
>  	 * Here, every runnable task is guaranteed to make forward progress and
>  	 * we can safely use blocking synchronization constructs. Actually
>  	 * disable ops.
> +	 *
> +	 * Wait for all CPUs to observe %SCX_DISABLING. Otherwise,
> +	 * task_should_scx() can see %SCX_ENABLED and __sched_setscheduler() put
> +	 * a task into sched_ext while we're migrating tasks out below.
>  	 */
> +	synchronize_rcu();
> +
>  	mutex_lock(&scx_enable_mutex);
>  
>  	static_branch_disable(&__scx_switched_all);

-Andrea
