Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42A21CA13
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058501; cv=fail; b=fONxvA2rhYpnKZGgWBWgQpRZwvtMTpTiRIZt25H8FteKLmqQz3TVSWNq3GKnpq1bbDqLu6dY8mVlUiUQsjfGlpu/sjTznTeZewLhR/cOOKYcuMMXDLe/FJSUrlgDOzfXQKmMwi1kapSWzWLDQ88zXZkMr+VryEWFK8PwyWfaXkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058501; c=relaxed/simple;
	bh=0GS23eZ8sjWpCJ/afi/OrYdWGow27V2YB+jiKss4ii8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oe0mYPpYHeeFjvaB8eYtTQUnWWsklJzWB5Iz0goudMm8r6rHDxE+s3feHJ8szt3t/1snF6kIJP3Tv+M4XC0dEktiaXCjgUKwlXm/Pfr7VEwLQIiNyUaagvWvT07RnVd5GYuJ0+nJFAP5PUTc2mHzmr2SOzL1H0l8P9FsvyCZLXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NjX9kfVN; arc=fail smtp.client-ip=40.107.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NjX9kfVN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExcO8DggSAhyC7sQRtI44XbI9BZux2jWu2eGDr6eUsRq/58+nbuhi/pjbXTV0GLmyif0VRxAYXrG40nO220EwqDwafhu0xnL3EoR3HU2WUg+fq1AgCDpiALclYp1HMDBihnK6fU75X/cHGJGdUyf632i1VJ5YDLTjOr9p8B6I6IfBNIZEjQ1p5mbdi2Z4wDJv9ri3/EZQj+iLoH3oP82ngvghMP5eAaX2lbtPxTd5nZ3zDb4FkohJcd96Koj6XhPFkbog+P3Se/NfdGKG6FKRc1nyQBjhl1N3ZLxw54MrI7b0qdpsj0nsHypVQVIA+U+cw4irR+wL2xrR1GlfqbQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUVQpKcscMTTVOGcqOGsfJjW4izjE2n1c9Mv+zG+lKg=;
 b=uzx443kjYGux7EUGQLgxwPZY2GD3xP0DZ4UOHiy0Bj491y50pKBoH9d2FS5v9ZBxlSig7wufbXNg8G6Ij89z1pBvSkTUuNYa55IIVZQAO+ka0WHGzVeMTNncosMnvOKJcmMiNq+cMSO74T37qs37KmSGzB3bxzMtQ62ejk2qz1o5pNhPXaxxFFZv1CpWyw2uEHQWq0WfzvMBt63jL/a7GH3Epy95IM1BJzhQMRPHhtyCwnwiYE6K0En6/m4m/3rF4eKvwjsd75AhwQyJpgHP6zGCOMGUBKfvDO43XXqI1rcRVaf6z6xp+cqlC7TSoNO1xj7QtDZgWMnq61K0l1LQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUVQpKcscMTTVOGcqOGsfJjW4izjE2n1c9Mv+zG+lKg=;
 b=NjX9kfVNUYh1aQVGBPxtF+6rOTA0QmYylGorD4wDj+QiLY5oQzRbvE0ar1uQzyQTZxw/BQWrW0GjpGXKyRu4lCXsYrEwmTDLdoKpa7IUw1yePkZwzBbsvH4W5O99kw/jCFbxOd1oFGYcuBXohQyTLBZRyokWGLE7tPr2bZcv/1+d1i5VXDka/p7Ds7rZSbvTVmf8zQyqtP1TktCw5GYcGx3YGuNqxwOAu8zSbtpy7aFQNWgYb75Q5Uh+9wELMoSkoGZAiW2nkwodusw2z5C2koXdvqDbeZPNPchf7i5yj23+zZyCCTyUIacmtcmp9LQHKVTstTkaA0XTZEqNZwyzqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 18:54:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 18:54:54 +0000
Date: Mon, 2 Feb 2026 19:54:50 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix NULL pointer deref and warnings during
 scx teardown
Message-ID: <aYDy-tCqsH990lW9@gpd4>
References: <20260202151341.796959-1-arighi@nvidia.com>
 <aYDaao9Xb_Bkv0NH@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDaao9Xb_Bkv0NH@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 594df53b-0a3c-47be-3cb9-08de628c8d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BSi7WEeNfH1HDnMP+ZPmtL2umMcyEi17F03ydX4dnfkXxTecPtnV10XbXCSr?=
 =?us-ascii?Q?iqh9vsPD5GgBrc2hvBygWz48yCL2+8AjbIdelufqkcevhsuLOd/2LQIdnIFk?=
 =?us-ascii?Q?zBjNTG6qJito1ty1DhusMKsBeU4MNeAdAy7QtMqiuJLN+ioGERAqLFxmZ6W+?=
 =?us-ascii?Q?UfsPBi9ABuVpbq4lnbsr9YTyrvEEmI+IJUQpJv0U2fMRZyYneXZHXz2zTbYn?=
 =?us-ascii?Q?pDyEPCW9NxGx9wUgnabRfERc6b6LlWS0IVoOU6o5NsUxHegjiJWNFNy2d9qL?=
 =?us-ascii?Q?c58oFKa1rNFuNk9NFNTlLv2+++xHuU0hhgaeBp4GI32qQV9Usbi1ZGWtREC7?=
 =?us-ascii?Q?RNeOvfgUalgoRL7PL6Jxdf0/C+YmgdsyYIJU/s8vW7WOJWXr1yJM3vgrBKHo?=
 =?us-ascii?Q?quC6Cj1lxEXQBr2JakqYIOj2OECLLqjfGsbPBWUieK9I6y/lPmHUqiFr0eLE?=
 =?us-ascii?Q?ZWhS1XsmKtJ1cNs9jnwxJ6upMQvnAsohoo1rnL+BJca+9eb1Q+w2cej1TjyG?=
 =?us-ascii?Q?Jid6OHRCuYOAYiSbrcQa5IOGHkyL4JmhqnODbQDMORp+coCjtYJ55VngrczT?=
 =?us-ascii?Q?wnJ9AOaHUba4AYvNg4QVu4ZVyGyjZblhsTMgaPPB+6DcSRGltnDB1AbFgmND?=
 =?us-ascii?Q?rdB5+DTbVUyJ3HVJp863J6azB2hoJRs7oXJvUti1K7+ANpAfq82+J+JADARo?=
 =?us-ascii?Q?J82vL5uC78D0tdSqHeKHdKvf6kGnR0Kfp3GZT/ROqPcz0b/Q1KOegipHbtLi?=
 =?us-ascii?Q?eBsYbxole4b7QLImJD54m33WLXCOT5xG3WHxUvuL7HEdJwA0je8t5RgB9S84?=
 =?us-ascii?Q?LN5AKWqM/0s6XkzEdpiNgNdayftlTBTX6f57zIJ/OoUU3PJTZ1RxMRhbMhtD?=
 =?us-ascii?Q?naFJNSHseWox01qzNpTUl7VMyAyifFkiQXm8fgUH5wmg1Wl9Vk0J8ptqg1F5?=
 =?us-ascii?Q?Lpjs8eP+ajT09MTckH6zKXOEUIaidIvezdmAwixgjID0WEnjWYR/HlXvx60q?=
 =?us-ascii?Q?ZUdtWhfSYdAYOAISSf662px1147Bfb/E/NlcyUD/O2DLqeWfDt4PGNiCCUME?=
 =?us-ascii?Q?NdvM8v88iWBBoAUB1zPIFQ/wTj7kahHqDjD+i377caTXRhsHD9c9jGXHiVRI?=
 =?us-ascii?Q?LT1LA7S8N5ekxGnXSR4RtzQO8DkN0jxQgTyTqElFK8NdxF9ASgxBsa9txrXp?=
 =?us-ascii?Q?YBYvFjUmdIqRb90t4vBy3gQhA50MktQ9wP9n5D+I/5hax7UmHNuj3xzYAu17?=
 =?us-ascii?Q?LL+Tf6gVrd2wj2EWzMsCzVYYwD41F83nwbNkA9oql4vPgY5j9aTa8aoP8lSc?=
 =?us-ascii?Q?p/vQiiLgpGlWykGv/PsGgJMhxjmYhTMdncqv9FSBDhxs6myoQAO2fua+SnbU?=
 =?us-ascii?Q?BqTa9I7IXfhdj2WCFJvjUZI7K7xppCBy7TwSZ0rVuuiXd1Oapbf2BFvr0a2A?=
 =?us-ascii?Q?ZafIjwzj04LmPZkihUanYprwp8qgRP+RFAuaj5uUp+3VwuNpUKphUFtjBiVx?=
 =?us-ascii?Q?7qnjnRcMvzBh2Xomrzforr2FZYAg4ZVwJuEEBQ0I/pSmlk0u0LkLeRHQYDMF?=
 =?us-ascii?Q?I/TFVosdf4ce8Dbko28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N8QW32vY8TlHSNBjmp6JnoZYMfCIw0gUqVZB3JfeVVKsXg+SgDSwtmQci3DH?=
 =?us-ascii?Q?Zc9xj1WVgH7W4OnZHuvtVH+RXpsDNfHrzThLXXPleLNeIFD4t8odx7dQ5bWa?=
 =?us-ascii?Q?X9jXn79crXYHD7kzZs7U0RrVOT60z4Qz+c0vP2wTpzcdqcvsOoHmKqbVSmdF?=
 =?us-ascii?Q?UYkgVeGCw9IUV+upT0Q4PMJANzDD3gtn5bTZN4eFXoZhWjocZD9a09uA3SZ3?=
 =?us-ascii?Q?z7uZC4qGVcf6i8Wk9UOCGIkD0cUP14Lnka4k6xPz9TmDxBA2QjhbGtbLFNha?=
 =?us-ascii?Q?0sLVQvtEI4MShLIC6IR6xwed81sbnm7mWkPyI+quDOt3Ws4WxAGmODgSXpfQ?=
 =?us-ascii?Q?YpamamptVD2567VXnsvh4Ht0GMbRD22nyQN51TWo+NmujW7ShssYOAciOZcD?=
 =?us-ascii?Q?8AARTFHusW+0d9/+gm7XHwKFfb1XHx6Eegf1zI8LtWl4M6j1+fhb+nsWUGSD?=
 =?us-ascii?Q?SAlpFcsRoBzNAWFTwkAh2Xo67Fhd1N5z2bXTenJwPY7dDyltcLnUXaPwliFy?=
 =?us-ascii?Q?9oTHpRTG3XBx5rFmfEpFY6g8v4fIg/3bMIMdjXgXw0fbY408a6SXUuu4e4xP?=
 =?us-ascii?Q?DLtc8zf2j46UVJ0NC05nb1F6zFwg3Ys/AvIO5faHsivyCv1qwYW/ScKx8RmT?=
 =?us-ascii?Q?J9+6lv+bRh6TT/u+XbUGZ9e0B8R6XQ7j2O9F+Adyp7o0SjPQ+7hZptjf/DnW?=
 =?us-ascii?Q?d8DtCz2A9t1xi7vIWjcpWlsDVawGwr/KlaHUCOFhaFsCbSCWEmd3G55cjA9G?=
 =?us-ascii?Q?t0a95cVQQXaP8OmCKeUaZOLD7bRoFed7qvz9IizHZK89o6X3VAiw9vszSHdL?=
 =?us-ascii?Q?vEJoHmRe4EKa7UeSTddpoRrfOzw95UMb74Al+JFkRTc1KzVQ0UAxAxzh4sZl?=
 =?us-ascii?Q?RxncBSSzLp2TAbVPUdnTzHm24/0rf0bMqI1Nd91qGBsJdIwuMzwUhJTYa0oI?=
 =?us-ascii?Q?coU4u9yJPwHgYiWJsEHapcSQwxKDLzA8h5v5jjQB+eaxzrPEy0vGLY3u4PM5?=
 =?us-ascii?Q?nbtqYVAnkQGThIXsguC7DnjqSuN1M/Nqrd6UpIf2ZA/P8LyQOngLzaaSuunA?=
 =?us-ascii?Q?6vdgJBClIw0yZSauz2LosFjpHsL8Aq4+LPlKRre3KCF/qij0AId2YGuZsTMQ?=
 =?us-ascii?Q?Y/WkWpdMCs0cd4fPpIT4Eg4YSwm5l74pzOHNQlDnTNyni6Is/jDmLsAFcTuG?=
 =?us-ascii?Q?ZhBlxWzM6GRC7OTk3wFQJvCMnkIS0n7mpyHfdgMsUIIlI/l1K/j6prRCHb9p?=
 =?us-ascii?Q?E7mg3B+Kb+vLPuj4/1tD5IFbwMxV/ddJ7ylZ+kSJkLTVtdl07zBIZlrVirJo?=
 =?us-ascii?Q?wC1NJI99zGFCQgxaZ4y3GSvOnCtaSKJ8jgULjQL5Jo1hPRdX9/Jz1pMs2Rf6?=
 =?us-ascii?Q?ydxV5k1s4P7Ar22VQBbs2i4GErl2gozPTpRv9kD/IxSJN2drMFFs4C6psVT0?=
 =?us-ascii?Q?BPouF3FBw5GRaRzaEmnTiSNWee804h1K9FXnX3K6woGBXkYBo7NiZvI11e3+?=
 =?us-ascii?Q?/kq+u5u0chXp3M5uH64NcLZ8B1ZSQ1gY2m4DuPS1ozYw6NQuOkDMAGMTQTAM?=
 =?us-ascii?Q?SKqOQkGCghWEzoyCf1vmtxJ+lXUb2IB5yEYdMt7BApAeIaKAMpKh70Abj5bH?=
 =?us-ascii?Q?jusYo4e8tuEuhUqmb3rSNKY3d10bkWNj02svy00XB1ZsnDXdaMqwT7yCAlJc?=
 =?us-ascii?Q?+bgGXu4gVq6PjFh5tz8Y9bySfZKICAScVdL+rO+7/ErQ+99z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594df53b-0a3c-47be-3cb9-08de628c8d7e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 18:54:54.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv4hL6PQWBdiDXc9cPpn33yDLHi/5Pr86iNgVDOFaLSNB5Lum3lWNPwHEvf8mNy9YuarfVgiW0OYfK64Hvy4FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174

On Mon, Feb 02, 2026 at 07:10:02AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 02, 2026 at 04:13:41PM +0100, Andrea Righi wrote:
> > @@ -2619,6 +2619,9 @@ static void set_cpus_allowed_scx(struct task_struct *p,
> >  
> >  	set_cpus_allowed_common(p, ac);
> >  
> > +	if (unlikely(!sch))
> > +		return;
> > +
> 
> I don't quite understand how this would happen. set_cpu_allowed_scx() is
> called from do_set_cpus_allowed() with task_rq locked. ie. the task *has* to
> be on sched_ext for it to be called. It's straightforward task rq lock
> synchronization, so there's no race window.
> 
> Combined with the failures in switching_to_scx() and switched_form_scx(), I
> wonder whether what's actually broken is more something like the disable
> path missing some tasks?
> 
> Thanks.
> 
> -- 
> tejun

I'm able to reproduce the NULL pointer dereference in set_cpu_allowed_scx()
quite easily running `stress-ng --race-sched 0` with an scx scheduler that
is intentionally starving tasks, triggering a stall => disable.

I think this is what's happening:

 CPU0                                      CPU1
 ----                                      ----
 __sched_setscheduler()
   task_rq_lock(p)

   next_class = __setscheduler_class()
     // next_class is ext_sched_class
                                           scx_disable_workfn()
                                             scx_set_enable_state(SCX_DISABLING)

                                             scx_task_iter_start()
                                             while ((p = next())) {
					       ...
                                               p->sched_class = fair_sched_class
					       ...
                                             }
                                             scx_task_iter_stop()

                                             synchronize_rcu()
                                             RCU_INIT_POINTER(scx_root, NULL)

   scoped_guard(sched_change, ...) {
     p->sched_class = next_class;
       // next_class is still ext_sched_class,
       // overwriting fair_sched_class!
   }
   // Guard ends, calls sched_change_end()
   //   switching_to_scx() called
   //   scx_root == NULL => returns early

   task_rq_unlock(p)

   sched_setaffinity(p)
     set_cpus_allowed_scx()
       sch = scx_root; // scx_root == NULL => BUG!

-Andrea
