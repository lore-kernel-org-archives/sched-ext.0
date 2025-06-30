Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB2131E49
	for <sched-ext@lists.linux.dev>; Mon, 30 Jun 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296379; cv=fail; b=i5BWxVVYsV8Y63YSW/Dj2VDQSuImfCxAm/GlexiynOIJjwSilCyNE0yAnij7YaFi061cFug0aXc/XCwjWdH30T/vHURJJOoBGIzJgZzIamNd7FZic8nf3Riy6QMQ4Dka4qpRZY386H/HX2F0EVHg+MS/L5dMrnxPcbH/aJfEUgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296379; c=relaxed/simple;
	bh=rBvCtFAMVeUbOXnMZ5zY3nw04klOPO5PzN+LYs6mhaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qnexs2lb30lJo9O53rSgfG+eQhcosiduPX2ou9XOdabI/LrCdrgq+N+32NvW+c4KR5cFcC65VBkt9l0SJbf1SuqCxgmFL/j5duznfGDSS+XiufCqNNt+7kmkhq58tRFqjn/QGUaKQDzJlcUZw0WFJEmq+BwGMBzXsc/ayzg5Ub8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWb++ymm; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWb++ymm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvlkyXrQOSQNbF5LpQJaDSCvGzTHdhrF1feYVpylaZH896YGyuTW5rShlgeWKeBSuVnkb6slIW+6WAQgXp2seMtgBaR34crdidv9IvFuIY//ZVh4YK1il+ZMF+PC7xd1zkhJKR7ED4sLNnToizd7OWNm/r/XAj3HRf46o28/XpKgtVFz97CV1sJJ+z4e20QWcOQs7LCRCXuPdGH4y0Djfp2XAbAf7xYLtTfN8KxVZMEASuGB34NsiQlEoL9g1bGUpFN79dum+RxVNMzs+75R1tbNVz3jdDUkEuxpOx3gQFALEdPUF1uz4PJnkZdpHfzSxvo2mVAusuksP/A9NuyTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buJAc0RZWriTrboVGUOZUdWWF6zm8iXRUNjr6OPeoww=;
 b=rsVnqBCPWGsRXtRKyGq+0+E6PZscMSU/w06HzetM7UrdTteX4aQFmagL+waNB7h3MZ368nqaAF9CCDtjN042owQZP5Gjmrtr/sgLN/qDqqljPYpl7uWVL+ZF0arot7uZn0ZSMmJGT305uLzb/oNQeyamy7MijT5/a8qBqY/ZpDvitnvA9UdzJU0TbG+HWdg7Y1lmLB863j9pkmv/ajM2oGA8qV0uJht1hUPZEA+8JlTK8hCL5ObL3FqOpMxmHd67NzQii1KiBw+UoC6+nZdyrqOCJcVTFbEgaQ8w/GXFwqLmtSCbkK6Ax1o2X0ZI3jXrJWw+9mNFZEFz4qtxO9cqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buJAc0RZWriTrboVGUOZUdWWF6zm8iXRUNjr6OPeoww=;
 b=kWb++ymm3Hv3QBJmWX+CI6MhjyRAvCHcgRp2a8DCe4O31CYwsXdOLfMFfkuknlxQ4B0OfBtG4Y0s7Y+5XRXK2HUzwB3KLGBp+I51z7jZesT6Hz2kF196QZ94nryq6jYQt7IdWHH5ijaweE+hfyX0AC1cWbGFbT4EroZJYWzMChl5HR5NpwGK6td5LAC1kMJWmAvkdu8Kcdfxz7U81CgSpd2MUxbdwcLyQKhfZv5WoXUoYdTzWlemf7cYtpx/Ud7lzmK5Tgz8g6WgIUATbo29MWJ4a8tPE7zY/e8OLtR6cI+vZ+uuicYAcz85fb9utzwYH2bjUhNXYuHz7zT4r8cYmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB9495.namprd12.prod.outlook.com (2603:10b6:610:27d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 30 Jun
 2025 15:12:55 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Mon, 30 Jun 2025
 15:12:55 +0000
Date: Mon, 30 Jun 2025 11:12:52 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v5 08/14] sched/ext: Add a DL server for sched_ext tasks
Message-ID: <20250630151252.GA2443566@joelnvbox>
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
 <20250620203234.3349930-9-joelagnelf@nvidia.com>
 <aFnQ-3L6ixL7nSz0@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFnQ-3L6ixL7nSz0@slm.duckdns.org>
X-ClientProxiedBy: BL0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:207:3c::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: fffe3ef0-670a-4a22-40e6-08ddb7e896d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Incc/qkqLfZsdFRhnI99MsAUJyYq25mV0zXbpNhfYTVtOMdzAcVm+l6WRjm1?=
 =?us-ascii?Q?f7EuGB1yXQZJjVIoHf7o1OsFpgOtrak5BYiUBL7MQtRFoJbCR3vOuVDwWLq7?=
 =?us-ascii?Q?vbSl5oeUCk2lTxhMuSE/Wjk5LxRVamgWAez5Yw3JWIu/xd2GCZAKHGPWPk9Z?=
 =?us-ascii?Q?7RLiS256sTZdN1VTsnpWBeY/RXjKo7D0oEji+p8VgYWBGxa4XpVu9PS7e5Q3?=
 =?us-ascii?Q?6KlDpq53iYh512qzCi6Ffm9DDLHpRF1KvsOW0b7lLRBpx3ihIqjXwLs2U0Ra?=
 =?us-ascii?Q?Jde4KqspZj+KuebEVT70Y+cZQmAaNAxf3T8ZiRP/fP6lCQ5XdTLBortcsKBe?=
 =?us-ascii?Q?PzwdiQ91XKQkOWX3xz0Jng/IePzmKZ7UviziGp42of/wsQQBU8yXHzvSsAIE?=
 =?us-ascii?Q?NU7dqoaM71MbyfuQv0IM/ucf4aNebRW/7ORMVxJENM6Icw2O8CQ8W89AS/FQ?=
 =?us-ascii?Q?r+FiMOjDo69Vojjz5RejCGdKFUuDN3EJXejR5K0r7Z1FBq1IUJdMu81qfQxE?=
 =?us-ascii?Q?2hKQrIUJ0V0DhunaCkpf9UycqlZe2OUHETU7/uObdKPKrexIQ015ovF2gZ94?=
 =?us-ascii?Q?YJ0/WbDBxcy712PG/Es0KjHPbH1QQ0CMoVcSbuWBRGL7d700Br/wHmiS58jk?=
 =?us-ascii?Q?2F57Qw94dMBjmKYULJxG97bnd1c4vPr98PfbS1zNxFxA/ILI3dnBXwgzZn98?=
 =?us-ascii?Q?fBfO16EDp/LtWxZL2GGGVZb0SCEsWiFleoGhlUFl8+Ac7UprwaWPwl9+GyQy?=
 =?us-ascii?Q?pRqv0fPrUIaKcNs8NzSWMyG9nW7CvknKfJeNoxAl1zJCjOMueoRoDf5eh14F?=
 =?us-ascii?Q?evH4SahNIa0p3gMacNs/X8YB5I7JjpjZAXSr7EGRJ4pgLInDX6ONqjsSR8nR?=
 =?us-ascii?Q?rRXD1nHRDABR3yKsBi89l3Aq3O5ItCJAw0NGU5MHQdWerFMHaxEaeABmJYMP?=
 =?us-ascii?Q?FoW6Mw8kz5FZp2HjiLTPF7I/taV5fewqsQriM0N8gIyuqEnQmLQQY54O0UR0?=
 =?us-ascii?Q?kDgHQZeUJK/h/QICA4S+vQUUaUBZ8lFHQ84E7qO/SiQ2EWeyitHRYtMcbGdS?=
 =?us-ascii?Q?8EOa6dHas2nuSRo8Saw5PwYFX9DsseiV9FhJrO0qRFneMVALWoLtKZuum/0V?=
 =?us-ascii?Q?c6UmXRbzEJlk3JRm9doEctvTHQOApRYHrNkk5DwC8aZohsS9omIPwZEAadjm?=
 =?us-ascii?Q?a//OVl83uH9DilJOxpUyofNBOgL+oZ0yaoro/Bxrr5/kDl/+GFZxUb1ccXRU?=
 =?us-ascii?Q?kdqeblNpX0H5EfT8Xw+FwVPEdjK8dM1hnPjCj1ujusqNxMYa9FPZDy0WoQSS?=
 =?us-ascii?Q?pKPHo7vn6jbpfSnyMm6cZ4wXc2kj7gm7lKy0wbfFXLefmkclUaSW2cqxlug5?=
 =?us-ascii?Q?4GVt9m6VAIAePzEgSsmVG8Wh1wMxpqf/l9QWXlDGys+bG4+SO/cSBHTdkmhO?=
 =?us-ascii?Q?arNVd/eG5QU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TymJ9ZjGoSm8TE0IVXyqN16IXoLAnHfUE9DnvyJ4LbTc6d2Gym8NF1/XsACl?=
 =?us-ascii?Q?lscOe9rWqDTc4FY0Y69rTFJNPWkNz0eEnHuplXlj96paczFr6VRSfsP5rC5z?=
 =?us-ascii?Q?MFDUh1bPYjjvJ6bOBgzaIYZMTNs3Fy2+JSlRq0Znnr8TmcTp9vINjPuLUoBM?=
 =?us-ascii?Q?4kNzSaQ93gORYq1rDM9y8299o28ZD5Z0IsMFfyNOfE1k9IXTAdBe3NjPKP2z?=
 =?us-ascii?Q?5OFuW0rCcFRcct/51X0MrL/UAnJLG+DVNjmwfog9rWx7+sucAlmAcHH+SICI?=
 =?us-ascii?Q?8oRvMYU0KUb5XfDi4P5TIMJQ4P7npuh7g37Jx/o8C13atfHlpJWDY8Npizc6?=
 =?us-ascii?Q?sIhhmL0+x8bTAP2mtBLPEpzR4Z1A+IKTFCUoyFDZS1qdF9I9dkeOlmZlZes6?=
 =?us-ascii?Q?UJjoXWtanBotTy2qbo/OT2OdjpmyBCWEhmdSWvas8A60rcwkFoqdL88Ejbqy?=
 =?us-ascii?Q?PPdUQDH7ICqx5JU46E8aXVZQfOMn6/HB064Ff33cjSznzScH0wdcvJHhoa0c?=
 =?us-ascii?Q?GKqmSWUNi+9MCVCYLpt4pYmaaJxmW/NaT3leuxJVL0QGl618GYKizXL5gCO3?=
 =?us-ascii?Q?Rwe2Fy8CowW0Kb2ts4u0rFkLz6hmkDESlsUCCXBuhNH0n4P8Ul6ZE1G88SMW?=
 =?us-ascii?Q?r0bi9fqyf+ewzz+ZNGTHFESreNw1WX5Fe+B3hsBEu5tFWPkj9q42uWjCJFZj?=
 =?us-ascii?Q?1IKrD1AhNzwmbKD+Ryb9kDfwKxLJFU4UAi60LvNCchWyXt2DTm4h8NJDdDYz?=
 =?us-ascii?Q?O+tv8vTQypZIbDLB3EU49QmOSU8uNjmf6Fn6xvv01yAnX82izFdF2pbtDkZy?=
 =?us-ascii?Q?RZLNnUHpk9FcqFSRMsWFXMAj9YC6dHbTc6Y1hMVn6To8lizANPzwKqPDRj0q?=
 =?us-ascii?Q?jDpg3bIULCrELlBe5g56KaPXNWBDvyYCY3XCjTKPZ1istb/pv+a6k67A9ywG?=
 =?us-ascii?Q?5sT+FGfBndKSev4Ka8TP5uJ82/UEmND5GhGPfLLjxSzpAZ/AoGUkyF5E2hYm?=
 =?us-ascii?Q?aQm/LhAQHdf3DsUP50wAT21sqOqsAY5sxSP+ExGDE/Lm7QXCgIHgCiuhT1Qp?=
 =?us-ascii?Q?7mEstAztdve2TNoZcuCmRXUObyCL6flSutcj5PkBuIkrqiJFiV+sXYROnnjX?=
 =?us-ascii?Q?KzS9wmimcox5SG6EriyGjLUVKUJiuPAd19+tJg6VZwpeLYko9e9RHErT0szY?=
 =?us-ascii?Q?C60NBFwgOuXWAKqClAXZUL3sVIv5JmChj9uwZVIMkqJNBHwLrsk7NmCV/u2n?=
 =?us-ascii?Q?IQBV/xhw8mUjx76822lrR30t0kCkXXLNVXXCR6lmrGWKFB4lSZdgoih70pc9?=
 =?us-ascii?Q?YVsbHE5ZQwCfSFf5Ca90qXNkEaM+m5mswGcZ/7ZpfTC+7ksuA9ZgEio9mZae?=
 =?us-ascii?Q?sm6KMT5/v2Y+DkNgxSat/yBX+nTKtS/yh2CulMPw0I5jiENqJ5LidZQjZaHP?=
 =?us-ascii?Q?AzVdbasz2Dss9MHYpU88h/qzwA5yisOjNWv52HdZSv70ETu4NxbS+RW3MWKO?=
 =?us-ascii?Q?LPX/lka30fAfr7ZoQAC71b0xGqycU7EkRMkm74e7QhqqlJTR4rwlhVkxh6k2?=
 =?us-ascii?Q?myYuoYMgMZE+anGKSm9GXkq3j2SzC/jA4oNXWnJQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffe3ef0-670a-4a22-40e6-08ddb7e896d6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:12:54.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/TA+FIev6XlRPGlEa1POp3KfCMuAzCTWmBudIeFRJImpf+DksLBoqgo6wEQJVLO5RLLcupbUXstuguCcOEHIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9495

On Mon, Jun 23, 2025 at 12:11:07PM -1000, Tejun Heo wrote:
> On Fri, Jun 20, 2025 at 04:32:23PM -0400, Joel Fernandes wrote:
> > +static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
> > +						void *flags)
> > +{
> > +	struct rq_flags *rf = flags;
> > +
> > +	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
> > +	return pick_task_scx(dl_se->rq, rf);
> > +}
> ...
> > +void ext_server_init(struct rq *rq)
> > +{
> > +	struct sched_dl_entity *dl_se = &rq->ext_server;
> > +
> > +	init_dl_entity(dl_se);
> > +
> > +	dl_server_init(dl_se, rq, ext_server_has_tasks, ext_server_pick_task);
> > +}
> 
> Needing to pass in @rf to ext_server_pick_task() makes sense as SCX always
> needs to balance first. However, I still don't understand why that
> necessitates adding @rf to sched_class->pick_task(). The existing assumption
> is that ->pick_task() cannot release and regrab the rq lock and that's why
> ->balance() exists in the first place. Breaking this can lead to other
> misbehaviors - e.g. if a higher priority class ->pick_task() releases the rq
> lock, a lower one may end up losing a task that its ->balance() saw. This
> can lead to lower priority class's ->pick_task() being called without its
> ->balance() being called which can lead to stalls.
> 
> One thing that confuses me is that all that the patchset needs to do seems
> to be adding @rf to dl_server_pick_f and that seems fine to me. Why is it
> necessary to add @rf to sched_class->pick_task()?

Because ext_server_pick_task is called via DL's pick_task?

In deadline.c, pick_task_dl -> _pick_task_dl -> ext_server_pick_task

This changes the signature of the pick_task_dl function, which in turn
changes the signature of class->pick_task.

How about I pass NULL to pick_task_scx() from ext_server_pick_task(), and
also annotate all functions where rf is unused, by naming the argument as
rf_unused (except for DL), would that make it more clear that the rq lock
should not be arbitrarily dropped just because rf was passed? And perhaps
sprinkling some more code comments.

thanks,

 - Joel

