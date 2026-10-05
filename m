Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AE41378D
	for <sched-ext@lists.linux.dev>; Mon,  5 Oct 2026 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236262; cv=fail; b=C/+3/DHJb/0GdqJdXX20a6tbvMg2Ke6FUKdEbrOOQ1qzEedI2OSGHbdP4LfXFc1LWzs3FdERPolok4Y5+aA/qgyzzK+mLVuRjAq52RgNurUFS5BjkyZYB3NxP+1z7Zjkhv7/iautF69309R36NzbEIMYt6kmOrmxxLMFpf80LPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236262; c=relaxed/simple;
	bh=n/bWOuUGO1G3l0OhBHIRa+8eIDhJ5gFJIpIdl6VHmNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=golnyGVGPya9Y0Q7AoqEKhMeFNhy4tvDLT6mteV1PfjwI9wrTxkBT543hEhgvuV66LR+KKztlIuhabEuH+Hq1y55xeq883HYV+DDUcspR1w+QHR0PYSEfzl9Dpup2n3bM5/CgL7FcKQWQAK9sxBfYSW56JypkzqwrJIjh8/2Yyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ald0t4Dw; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ald0t4Dw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgqY1yTWWSFfZOTBanKeC2uaTvs/qQXqBcv0M1sKWP4f6Q7LfNNdoLGqB36x54thARqWgorF4t//WWq9s+FoG1CYYGDlq6p2LSNlqZ6DIYNZnqepY5VU7TOnf/YUEbEXwjlZlN8AT5FaT3CyAEXdyMLXEJQQae17gbMhnXn3mu3cyvqRI4zTcM/ruT2N86985nd3kkzS+W58iNTqLkXBNUQIvOSN1DnXDFyGjRrXd5pYBrtgNlypsyMUgXJEyw+bXZHALdoRbzDxaxU08VEkY6wrP73d2NBwINTZ+8zmPg8UbSUARqo5J8RNZBP6gQckcaeHkAeMZ6+9pcraYFudtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP6ywUa4vjZJBVBtBvX8O2VZ9PJ9OcBYvtqy6wyl6IM=;
 b=DlytkDRXa9dIvRZaZ7g5r4gOQ9sz754JqzVMzhhGh5xusEotFEeErhc/DrZBLGWxNIoh+1okgVl7omFo5Emn31bkF7n9ZfQFuQqk3Ri6C4t4fQxIMPdmDjWJ4E/qGKpNt2jl9w7O05blkpuFT6p0nAQ2UU9idqiywg0213CGXCOY2Ar+62OL8UD2x+NmecJUCQeBq2kmOn6vc17cobXooA9iu+P3KARCy91Cnm9rDFhglipDih32XDxxENdRSlSF4aWQReIUVc5OzfJYInlnvOvNDidg5gRDEAn+If8YwI2hwOge2HxLGPuytiaoalTPjwjaX0tZgo9pO2lmYIaC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP6ywUa4vjZJBVBtBvX8O2VZ9PJ9OcBYvtqy6wyl6IM=;
 b=ald0t4DwPjuzkIW0sLE2jZ8lQB35yub+vNI5KLQYC7M+UL8wjz+WHJEYWlewYdkuXvA3yIUw/h9msAkn5G6PRErI0Cp//f54y7zRY6CvAydaKxLd92XDst0dMuGIgvz1FfRq/gGciNFkdI3vFKmbTp+mnUcsINGsWtFsBXVAP6lTZ5+FWSIAvk1XjZJe9dODQrWnMRgtlWNmG0lE44RoqekOxlMQDMomYR4l2upFH7GqpviYTq23UAkhQy6V3Qw0W4uXFA+mj+vFDL6RzCH1LHv7LgwgZmxMJIIv+3LliAVh9mYg6bImE5NsKeLaVhkMEQN1Q4TeymIwD3fP/rfcjw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Mon, 5 Oct
 2026 21:37:33 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 21:37:33 +0000
Date: Mon, 5 Oct 2026 23:37:30 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Vladimir Vdovin <deliran@verdict.gg>
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
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	Hui Su <sh_def@163.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] sched_ext: Scan NUMA hinting faults for opted-in BPF
 schedulers
Message-ID: <asQYmmrL2SyhZ4sb@gpd4>
References: <20261004072901.3579967-1-arighi@nvidia.com>
 <20261004072901.3579967-4-arighi@nvidia.com>
 <DLWVCRDZK3XK.1JG5J57YQV0VI@verdict.gg>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLWVCRDZK3XK.1JG5J57YQV0VI@verdict.gg>
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: f63baef7-6a46-4cc3-8e4e-08df2328dd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|11063799006|56012099006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	TEUWM4Vt2iSis1ojNQOmhUWxSs+ZXmODxgJe6B2oTr0z6BNbqeZ2kTbPHgu2hrL836XMqELto8CbTP+Sko3myqRB8i20+VC8SP415R8juDRxiIUTwdFSJ/D2SUtRFfnnwldKK5Z5daQWT32qFWhMnclc/Zc0OhISleD4Og5qH+PQwTLSvAsknM3rcLMc968BQLqv4WV1uWE89jvAwc6hvHvlrvkhrtpYKTsBJ+YGPFjfzA1L9PokV4wdOJQW7isDTIPtk9zyUq6FU8deXQGzlWQJpa5H4Eekw4eKHuhoJbhS3w8XeemDQf1/nuT4lw9a3ydv8LDjaFDvK2kTdGuVYioSrgfMIbuRyGv5MVl85TBOhVqqkauV4MwU19upyYhXSymxBYpnE81dV+/aWoPLt+xNoAkr2l/syTwmH6BCBiBPPjWzwPFmTkS8t6qcelgSAE3TktUSxtmjxq/Fo+lHM/Ix3IQVacxf/qfo1gNK87Mc3M0KXDnPeCvmaXZ5YZXokGBQuPbC1NxGofz3JwdW85jmsiAR9WQ1XTV7nkEGYK6cPgQHFjMlhveNYe/Dl0efWKVoD6MuYp/E3Dm6RiWwxjL6pUMWjBD5plgMiFt7IwJWTZVSQvI0OaaFQRnByZMVsBQXGepiXTCxWBlwoNhHtpWx5YiLii8APJScQfRheKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hCZK7NnDREy2nY8FH0NP0OcHgte/ilT4zghVzzc3Z0PHsQR79llaA2ZdF/7I?=
 =?us-ascii?Q?CybCa+NbSvTjfG+SlJJTTH+FJY5N993Hc00Kpp1fZZ8jcVe4hiOCb4HTfXUV?=
 =?us-ascii?Q?+10+2ddHG5J0bY7vZ99oh3RrdFRapmvHZujvRjBBkjFV7YLdFOGz9C2ZNB2/?=
 =?us-ascii?Q?L9Sg5gHrDweM43+EnnszAmP1AfoB+I6AC18OZrsG/8b9RW1kl8ssgj9ruDjS?=
 =?us-ascii?Q?ti14gN7SGdcv9DnA9bbTypKyOMQerWSEk45VkcxAiDJ+N3Zme2w8x+Bn4QXc?=
 =?us-ascii?Q?fAPhguVcYQxip1hgptGeBGG3+tSL/wFGSl/rIFL5yl2GPGZiI58VPRvubWIB?=
 =?us-ascii?Q?rqe5vca1GfXIs8eEnqX5l49P3V1kxahxbwKh3kzrF3eFZdTqZ6rGQTC8Pws9?=
 =?us-ascii?Q?LCruDYAbcnKbZechuX3aBrtVY7MJwEMlVe2DbLLugpft7dvUqbIyZR5gUlcX?=
 =?us-ascii?Q?DfIO/Ovgfu7Pdh/pl3tQD/6iZf+L+qIJQrSccAXdUU/aJ70lUSuTHdr1gR1M?=
 =?us-ascii?Q?ds9J7aFNnVnAwOOvYgwAWRVPI2l0vSOBFZD7RXdRm7OlBZRKgbRPreGgHXGF?=
 =?us-ascii?Q?eMnLCn6SNBdSewLhVt5IZlMN08GoyO1FjD4jybKcU4y3kkdw72F2w5sVrIuw?=
 =?us-ascii?Q?X1JueyjuQvgZtS4U3eF8iCGxaRhDmCjUedw7oZIKdmCQjHaJPYi4m6kg7FkK?=
 =?us-ascii?Q?SJrLSatPMSkjGD5CfUJkeGsVkFp3ztrKNgUT5++TJfOjRbtw16wQURCxdj1q?=
 =?us-ascii?Q?W0z+xQmBKNTnPKYvH+s+iwJlvktEowOVJrU6ASHHFzPmg72Sdemaqk4CA+21?=
 =?us-ascii?Q?oaNmPdzpfYcATmm2OjoPWHQeoUAjd+f8NVig5vJ0X4xIlB0CrUCyIpmoYP47?=
 =?us-ascii?Q?4gaKijJfENZgiQZXuml/ImDbmoLgXfRYVOsUDql4cYr/jW1r4UqcJ4p+T7z7?=
 =?us-ascii?Q?rOArhsBCuR1KrpmCsjoWdJ0GSTQJZMPYd5xlBppmvO64G2HEUjybcwDc8ktG?=
 =?us-ascii?Q?s4cxnLmyfoeUwQuEvN9iuJjqpYD0wjetoJFkqQgdxJRLDQOdW0qG3xah2wNw?=
 =?us-ascii?Q?wiaDbxnGR+jLVZjn8cI0pbY1AZ+w6OCAA8YmsdPsfTRGOQt+CDfj139zLzUS?=
 =?us-ascii?Q?dTXus3uQ7RsqZm6Le3QcLDREe5+iwujTQFkenkEwisbE6sfTjmHYjRUteISc?=
 =?us-ascii?Q?VgruSbbLOzVe5NbdaCddxrEH2dmCBEWUTR80KLUL0pSXLvhH3Rmrb4GpXndK?=
 =?us-ascii?Q?fr/IDXCU6YVTA/eo9mNtc7+V40x2l0AsPtPQbyveh6WyDB+jLyBfLI7IrLuO?=
 =?us-ascii?Q?789UCtK8hoesU4GgPo1p7+vsiJxKKt+X3gTM5gwihaYUKk8zOiS7Zg3rl0HF?=
 =?us-ascii?Q?XHWO8sMsJm9fvQIqIniaNFmYegJU3oe6jo+DN+eTACHBetgEIwVU3K2FCGeL?=
 =?us-ascii?Q?dBA93TXyIJxkfiYNj+5JmCkA1LG94hwSTZ5tgMnLJLSxuQ52F3ye2Zyi6tne?=
 =?us-ascii?Q?qsZ6EnJ1BgZ5l4O51jpspsNX3SWp2KazxAbh5j3TBVuK5PAUHYKLD+6r9ssM?=
 =?us-ascii?Q?XzOTjZ+5j+FN+Nz8uiWPFmpkRuSyqwbzW9FZo6l1eMebst81oXzHaGmTAvxl?=
 =?us-ascii?Q?WoagUbMDPCLAso4lgDNQJyvEC2lnS156t2ef74zscL+YRCYKUFIzF19gtck0?=
 =?us-ascii?Q?DxS6LIZle75tbonOuYVxm1fn+G2UIUl+D1Qui1pCyFpPHYN46WD/GPlG9dVL?=
 =?us-ascii?Q?scHXMXiSBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63baef7-6a46-4cc3-8e4e-08df2328dd94
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 21:37:33.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dueiIRCs44fjn826lkapsCwf2yqUv8mmsi8oqQ94A82/5I9/oDOe2zZsUOgGz9GL5hx/+XJ7mqN4GOaa7uPjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156

Hi Vladimir,

On Mon, Oct 05, 2026 at 02:30:50PM +0300, Vladimir Vdovin wrote:
> Hi Andrea,
> 
> Thanks for putting this together so quickly, and for picking up the RFC.
> 
> On Sun, Oct 04, 2026 at 09:27:09AM +0200, Andrea Righi wrote:
> > +   if (!queued && (sch->ops.flags & SCX_OPS_NUMA_BALANCING) &&
> > +       static_branch_unlikely(&sched_numa_balancing))
> > +           task_tick_numa(rq, donor);
> 
> One question about proxy execution, which I may well be missing context
> on. Hui Su's tick series moves the fair NUMA tick to the execution
> context, with the reasoning that task_tick_numa() works on the mm and
> NUMA work state of the task that is actually running:
> 
>   https://lore.kernel.org/r/20260909092901.2989564-3-sh_def@163.com
> 
> Here the scan is driven from the donor. I understand that in your proxy
> execution integration SCX runtime is accounted to the donor, so maybe
> this is intentional to keep the pacing consistent, but then the scan
> would cover the donor's address space rather than the one being
> accessed. Is the donor the intended choice here, or should this follow
> rq->curr once SCHED_PROXY_EXEC no longer depends on !SCHED_CLASS_EXT?
> 
> Thanks,
> Vladimir

Yes, that's a good point, thanks for brining this up. The donor here is used
just for consistency with the current task_tick_fair() implementation.

A small clarification on the accounting: under proxy exec, sched_ext charges the
slice to the donor (update_curr_scx() decrements donor->scx.slice), but the task
runtime, p->se.sum_exec_runtime, is charged to rq->curr by update_se(). Since
task_tick_numa() paces the scan on sum_exec_runtime, passing the donor means its
scan does not progress while it's blocked, which is fine, and the owner's scan
is delayed until it gets ticks on its own. So nothing is scanned on the wrong
mm: task_tick_numa(rq, p) checks whether p is due for a scan and, if so, queues
p's scan as task work, which runs later in p's own context and p's own mm. The
owner never scans the donor's memory or the other way around. Essentially, the
only effect of passing the donor is timing: during the proxy window the donor's
scan may get queued, while the owner's scan waits until the owner is schedued on
its own behalf.

That said, I agree the scan should follow rq->curr and Hui's series gives the
right hook to do it. But I'd rather not diverge from fair for now, so the idea
would be to keep the donor here and switch sched_ext together with fair when
Hui's series lands.

Thanks,
-Andrea
