Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113D4A0EF1
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492858; cv=fail; b=fSwGrzp+UNPNar5ja47zPjcJhNrsImKyGzApY+70ahxPTt1JPu3BHXVi/nf/XR3jsjspCROwwJLD529fDp1aljgN1czHc+U2DXKiidbBXj1DFgTly6nCMOvMVKiPIyGjdMY42+pP4r1bQZg6HyzHUuCf6ZK0zgm76sSdX4Ig57w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492858; c=relaxed/simple;
	bh=v53I8buvPv/SNt3Tzcf7JssvWKJK7GS7b7hYA4CBF9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p2QE9uK520Dm9YeOwNtrZfGqu7naCOgh5PC8idd2ZW3m2/MUZ1ZpsfyuLCx0qA7bz5hVaaz6RONr/ZG07tmj6qXpE/Gfw2r54kAKcwPgC9yDAQXM2Z04JmlidvDZ6ZZ2vzFrIuOn9QjjO6CIKK7knqOJciFfCz2T6XaOhu/FRVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OyjJGoO4; arc=fail smtp.client-ip=52.101.62.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OyjJGoO4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVrOWCZlQ/QYsmmjsgHjty0u/7gdXTKV3ohNkVocKGq5V/ssMKW+peyv48QTij/yMD7G+86AwD11z9iJ3vWxvc007vCbvYuhy4dImnczIUzTGUugCTTHiLp/9mwruL6/3gLi2dLKwFGSuencr1glVeKSW7t67WjodgXorde0cluhtikvTDBxHimyCqKCO9VC3YxtEYCO2QpUhZqbLOL5Qq0+ZbULd0R78c/Mz9KjOEwJVBsJ+I+JTTlA9xbQspOq7sJQyC2k4E1pXEnsqZatM9P+cjgZN0mK8gJSwJDPXMcBnwIDQgFXwOLtoId+KQnfOW4ZW150jGPl2di/FD4W6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxisORoUnhw5fn2LzbvVjuHObQOqsTMlisdClSHMzvw=;
 b=j4Wcd6vEuYWvIpLaBVLwO8ahHyyQQM+fdOTm/phkHMyy52dCHtPAQyIN6/5YXQG2VGczHtdborwR3wbVciG7Y6qmudY6ZZT8/q7kqXVrrUgxqDuLScFMZ5+vBTsjcFx8ALuyIOuYo6r1mhfHfwzosdGx3QrWaohjvP/pr93qJodm51pWXdU0x0Xz9AhB+MQVlMb8XcfgOqX5f+jmW9wg3A6JzBIHMUpFy9Jw7z/SWhn+MTFuXQx1h8TsoGGwjwmxw7Taah7L9fpdKnjua38NdkPNzCoWyLiywKeHbo//LQdnAwP0qkmpvdjf7sqZTgDorV5QuUXltZbmOznUpBzZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxisORoUnhw5fn2LzbvVjuHObQOqsTMlisdClSHMzvw=;
 b=OyjJGoO4zxrOPs2SoseIIjyVY2MApTZUJ3KSRiYyKRnR5kH3+h2dfDr5Mn738fYSB/NzVRhaon1KhzD74Ra5AjSwywGFJ8TrTR5uCgwign6MFynQOqOo9qVYcAHEviO9/03Qh3jo4n8UvolgtVRj7LCC/Pt6KS1t5rCjG6Yolo+S9gg6IeUcJ/xmKTo5W6JWSFoQCqOstRYMRBcK36TNc3dOlnhgdOQOw83uyQJkdY2Nlqlm+N6ITghjlEePvB7D8lzYcVG6WC3sOj8sXkuM6F5/AIqgF0cfuhfp9oXN1UmtJOcEAZeKpcGM66VqZc/glO6c6IXCKbkMESjSjVUXPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SACPR12MB048696.namprd12.prod.outlook.com (2603:10b6:806:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 17:20:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 17:20:53 +0000
Date: Tue, 15 Sep 2026 19:20:45 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/18] sched/core: Avoid false migration warning for
 proxy donors
Message-ID: <aql-bQRXTP6lCcso@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-5-arighi@nvidia.com>
 <20260910100652.GF4120091@noisy.programming.kicks-ass.net>
 <aqlstkw_QzFqe03A@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqlstkw_QzFqe03A@gpd4>
X-ClientProxiedBy: MI2PEPF00000B78.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SACPR12MB048696:EE_
X-MS-Office365-Filtering-Correlation-Id: 019b74f2-c7cf-4ce6-64f6-08df134db1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jva4jmdyZXPF5ErYQVid0bTyBJPBAjr3VQzd7uWwdeWpxjUtxNe0jWbQdlbhiYITFfJ2/3tQn1h0lXI/G6+MFvuSTqElkohCkXGKC5DE6muGBf2F688L8N3kE8a1xF2nOfpZbbMBPG5dZF52pnR79eRHGMHXxq0nhKggedrdUqiHV89xwKAJF5TXhBBWCMhelzhKMEXXJShB1fH48IZaqIGk8hXJ/JY1N2Ehn9ohr2jqYSfPHoWUbhTCHIUhywa+badeKDVPXpO51GrjUEJjdfBHdkpikNjjXHX3g6XU2P53SqQpw8UU36d7u5HHiOfzvUUB3GtNQ2kfBmnmkAxxjtgxMOZwBIyw0L+7pmNMceNPVgU7w6br4X/BDyPejf1ETrYJs1q3a8dDAZtajn1/Lk0sPw4OiO2ueMfNEVSP7PmkKrpVrUbCUNQq20aO3tlZKmH0FRyTZoRoe/QJ6S8nD83FN06bkSB39Cq2BprbpellqwzLA4pb+wRFjk6Jp4MlqKNXIE1UK0IkcnItXV7O+16d+36DdP+gwz7yRX0eOe/sFG3VSgRnITyGpTvcnjCQ7Xi7q8YtKW8nrWbZcmDOAxSHozi2leHcXdOG9sUEOOmKPfLjmpvR/sMvgOwtJCT77qqhWShSCNiVOAJpvjJsZpKIa50mMDCkpczSzTHnPSw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c3E1UxLgBJHUkEnp+i2DJmN2KUKpM+tjMEvFy1pEFKaecUxHVJ237kr8SUzd?=
 =?us-ascii?Q?eoZq06bpVblmmqTnyqkJGTmUOlX3+Kki7QHn/e224N3P7Dtp5fjghc73IJ8V?=
 =?us-ascii?Q?LqulFRTvQRsqcWAK4d6uERZh2rINkxBdgSB06dIQi9B3jC6ti64dQeXxwCro?=
 =?us-ascii?Q?3XMmyHT41KFue9C48XrWTRfEisZUykoguPnkKccV06q360Ib8XppTkNnCxdp?=
 =?us-ascii?Q?+cqS2p0xjUsCBuDCkKjAgEqu6NWc8x6BrI43r/aeoaUl6ntULYa4AzVi9r2p?=
 =?us-ascii?Q?PM5VXIqwaHsmi0wMmZvCmUy+VW+5hIXYhXC5v8LM6P+EtzDXeHEqpSU6vaQG?=
 =?us-ascii?Q?+bWSBQQCSMoyDTSlVYV4WXXnCE0Bv7blhSkFQ0yqcvBeox81uJbcKv/zHdxG?=
 =?us-ascii?Q?l5JqUT3rPJ0WDPwwy1uyYohyDqpoVA9BH3IeHDfK7jctDA3dA7sOxTWkKtvb?=
 =?us-ascii?Q?zpVuhrL9sCdiWWwr3FtTueWkRxgCoQlTcYW4O9oRJ3VKYbDnC5MtfAYunfgm?=
 =?us-ascii?Q?YuDHXAg1Lfwt7IS706hz1Tucoo7kKnAFH2Bq4PBdR4BgauKDEkdY/n3dGmdk?=
 =?us-ascii?Q?gjNLMotwPePdiwCyPwaHDrBezqu0GCWxjXmycNcYLasxz5WmZn5D7qmolVH/?=
 =?us-ascii?Q?ZFYQJs61/QEioxQc7HdnpoKnHd1GLEdIkqe/WlLK4FHG5+eWblKP+BiqGxMh?=
 =?us-ascii?Q?gV7rfcg3awGN+c/cmCiSOkPqdrxkbD9k4pN2vpsBHIQcU34N8786RWAnut+6?=
 =?us-ascii?Q?p0Z49XGncDxz/Y8bbvChgzHzZXU/JHy0W/5CYHp05z3SVQuS9G78LE21TJqo?=
 =?us-ascii?Q?qD6DzU6Os1YQrzXQ0JHlwgaM6dN0TUTATQFN2XFUmtF5d2e5sTTQMNfl0vW/?=
 =?us-ascii?Q?OsJl4xKYBrps+6HRCBX2TnFHfnFmcFB6wo12tvO/3iVWesm4pI3kOzZ+nry/?=
 =?us-ascii?Q?mPkw4JDZb4qY2Nx4BGiyNY060ONCdjDD6GZ7Y1AhBBLT+gtZo5u3ZNbuhuMf?=
 =?us-ascii?Q?LYlyvUoQyPVkHiKcSFRU+XbRrw4z/7SQSlnYtPTpYOL3SU9hpVJKP7W8C8df?=
 =?us-ascii?Q?8/3kUUW281NcgB/zLDl4RW/FmOodMWYpUJ29lm4KU4GgnhAYH6Fvkbve7Phs?=
 =?us-ascii?Q?xYzQ4OJnq0HY31a+iiKi8iTENT85BF9MHcwBTximSjkL2qJLgF1cOIqZYOWf?=
 =?us-ascii?Q?O+cqnRsjK949Nfjqb4kyU698SQ5Quj9hDRAeC+v0CREhrXS2s74XbFRwwRVy?=
 =?us-ascii?Q?2g71WbM6VZYDMFYFKfTuEExwd/gM5AC1REFtVzn7SQoh6jnLg9ugncPJpX05?=
 =?us-ascii?Q?LKz+p8HUal8MI8VTPcpBPCY0pPJleVkLzCYIN4gkQrZq5+Wxh+5rz6kbhqbb?=
 =?us-ascii?Q?/Y70sGo3hOssZhxNJka7glEqF7xKbvG+d+17FXZuNiujj5eLu1P8rWu7ayMy?=
 =?us-ascii?Q?aiHH9XhsAw8ZPYVfJA+rtEpK3KEcD9GBchtrGp9p/p/r8tPbV7WtDqjEDQFL?=
 =?us-ascii?Q?NaBJ35r2tpyRRMeJy3AnmG+VlmWw9c4VeCpezenGQNIN8qiveEncgrVOf8Aa?=
 =?us-ascii?Q?7vJkdS1Xxs9Kx4/HihfX6Ymxo6hf5zioaaisRnCXImsFeDrB2LkBu9H5Rhk6?=
 =?us-ascii?Q?uT4GQJBX8OsQYHO7ZlxPmjjLRU2oW26+XFRfFAfo6AZ52pSh6NHgcyqbyIHv?=
 =?us-ascii?Q?4AzHxHXKXmUJL+6CKLD/7ItoKrTbotobY8Zg4oSSW3H2TukC9g7/ZxenN0Y7?=
 =?us-ascii?Q?GKCSASvwAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019b74f2-c7cf-4ce6-64f6-08df134db1f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:20:53.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1wunMsNxFvCwVG5AfNcwVM4ngW49O9QMMcH5sftBykyNiACwljcawvKrvVWIGepQlpp1LqQlU82AzNBQcXDMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR12MB048696

On Tue, Sep 15, 2026 at 06:05:19PM +0200, Andrea Righi wrote:
> On Thu, Sep 10, 2026 at 12:06:52PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 31, 2026 at 03:42:14PM +0200, Andrea Righi wrote:
> > > Proxy execution can move a blocked donor's scheduling context to the
> > > lock owner's CPU even when the donor is migration-disabled. The donor
> > > does not execute there, and its original execution CPU remains recorded
> > > in wake_cpu.
> > > 
> > > set_task_cpu() warns unconditionally for migration-disabled tasks, so a
> > > subsequent proxy migration or the wakeup path returning the donor home
> > > triggers a false positive. Moving a blocked scheduling context does not
> > > violate the migration-disabled execution context.
> > > 
> > > Exclude blocked proxy donors from the warning. The proxy wakeup path
> > > restores an executable placement before clearing the blocked state.
> > > 
> > > This is a preparatory fix for enabling proxy execution together with
> > > sched_ext.
> > > 
> > > Acked-by: John Stultz <jstultz@google.com>
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > ---
> > >  kernel/sched/core.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 14d0d5c884393..0a2eabadfee02 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3351,6 +3351,8 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
> > >  void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
> > >  {
> > >  	unsigned int state = READ_ONCE(p->__state);
> > > +	bool proxy_migrated = sched_proxy_exec() && p->is_blocked &&
> > > +			      task_cpu(p) != p->wake_cpu;
> > >  
> > >  	/*
> > >  	 * We should never call set_task_cpu() on a blocked task,
> > > @@ -3386,7 +3388,12 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
> > >  	 */
> > >  	WARN_ON_ONCE(!cpu_online(new_cpu));
> > >  
> > > -	WARN_ON_ONCE(is_migration_disabled(p));
> > > +	/*
> > > +	 * Proxy execution can move a blocked task's scheduling context to any
> > > +	 * CPU without moving its migration-disabled execution context. The
> > > +	 * wakeup path will return the task to a CPU where it can execute.
> > > +	 */
> > > +	WARN_ON_ONCE(is_migration_disabled(p) && !proxy_migrated);
> > >  
> > >  	trace_sched_migrate_task(p, new_cpu);
> > 
> > I'm not sure why we're not hitting this upstream?
> 
> I think this can be hit upstream as well. I'll try to create a reproducer.

And I can reproduce this with the latest tip/master:

  proxy_migrate_repro: donor blocking on CPU0 with migration disabled
  proxy_migrate_repro: donor moved from CPU0 to CPU1
  WARNING: kernel/sched/core.c:3389 at set_task_cpu+0x1d3/0x280
  ...
  Call Trace:
   try_to_wake_up+0x43f/0x780
   __mutex_unlock_slowpath+0x330/0x540
   owner_fn+0x9f/0xc0 [proxy_migrate_repro]
  ...
  proxy_migrate_repro: donor woke on CPU0, task_cpu=0
  proxy_migrate_repro: completed

The reproducer creates a mutex owner on CPU1 and a migration-disabled waiter on
CPU0. The waiter is proxy-migrated to CPU1 while blocked. When the owner
releases the mutex, try_to_wake_up() returns the waiter to its pinned CPU0
through set_task_cpu(), triggering the warning.

I guess I can send this as a separate fix, it doesn't necessarily need to be in
this series.

Thanks,
-Andrea
