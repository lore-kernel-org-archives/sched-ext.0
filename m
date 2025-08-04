Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD226FA58
	for <sched-ext@lists.linux.dev>; Mon,  4 Aug 2025 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322508; cv=fail; b=NLS8UsYFX714qe2LMgQ73RumrQ3TCN4XVIe0QLdRuJFBqtE+QlIZJ9STJcA5PZZJpWtSPCB50F9sjRHiprI58LBCmXWnqNZAw+nk2ZATkXr1NLCU0nkow2yNjM0Fxt8AyBi0qEbNN11+x12XoeJyj/n0YIKqnyFd608QRUk6nQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322508; c=relaxed/simple;
	bh=UFTMmkxYiriAet6oRoDib77ri2YH1bn8jaf+1vtRZXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=froGvWg3Wha/HZ59/xodrnDiSRw7aKlp09RszqBcXItIBmbXy+hvoF4gbbisH0uhMIiyhUe0Vhw+8ExSY25KDDb/GzNIebNZ8wESGFLUN1AzcMa2xD1WFlF5nzGdMo27PfGkH9C02j9YIeQVaE2ZcfEp+l9zb6LyDt2qTfJmMgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sMnjlJcI; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sMnjlJcI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iun5q0W2sTy8lTPeEhaHDWiiuhFEGs4Qu2Okkf2WFNsZmy7EFo7jkNWmmL66iqTA/hORlmEFNze3t7alpH9lgh5BgCcUlZwd4bqVO4BxrMouB/dLTt9xiYhjJ9M6MFe/3tXlslBb6TrmiwtyGOwrazM8dQmfETlWVkLSlafyYU9lSEjj92UanXaFWgcHgejryZji/HzUIoL4PG5x/DGKsyiEDpbJO0hj8b+arWRMLKN0afqlrRjIPmhd/pk3O0GZCT/WBhO97/C6/TJ5m8heI5Si/AC6Ijj+Xg2AFDx+LD8uB16GiukuTH0A7xlqG1ifFFso6UIVYjdB/GuDRunRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb0CvhiptFPztINxwcuoKbUrfAwRYlqAIldQ9xE6dX0=;
 b=VvNvV8qQl0f1EIoRlsBzKgmyfBa/+Y0x2r15+AxtX8zaxDnzUFkdCF0pI18oAHoYqNXRphiZcAi/jkETC2RQrIyozOoSA/Yhrv5twUxAI1mhuH8n1CvViX71pHCy0aJFFiz+OluU4qq85J0FsnDTi6jIXFeB08H+4wk0mXfdYm+Dxb8apSBf6XZLjFSB/GnggB7Nr/vCYg2haqMvXpESUutFH89ylEU9rSCy5Mur8DjNoqsZEN+KRVYD3BwNNRehjvnxhj8OQteQiARKZl03bakhXf/GoUC+M/CqqwuyNPrQKML8GdT12rsvB3ceP5xAwoxGeYR50c2MqYuk+OT1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb0CvhiptFPztINxwcuoKbUrfAwRYlqAIldQ9xE6dX0=;
 b=sMnjlJcITe1q+miG4pHhhfau04fkvtP8EzTb/tSu7AWPCZVIDVAkOZKOmlHdNQGhKVSgcshEXmLZlfpKeRztwFM6ThisTlufNRqUs08Yu1oTnAMWfWbvO7YX3kRB4aUodPEWUJ0/mOTxxybteuvz19F2UNZiXn9ngL3iXi/gfKh0/c8uCx2PY1Y72fxI82+8b4V90BaZNF+Vvr9hOgZgVVJCFFKSpCaIio+j3llixrg62JKKA4e2snCjbHe+1ppDr9aAju+G/8ZwafMwQNI0tMdC+vUuoKYH6UwkJmoM0ZpfB/tVJfnBpKxzN5AcbqAZbBRIP+0wLGPSibmNT3v4Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 15:48:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:48:19 +0000
Date: Mon, 4 Aug 2025 17:48:06 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v2 2/3] sched_ext: Provide scx_bpf_remote_curr()
Message-ID: <aJDWNkhKOgxZKVBk@gpd4>
References: <20250804112743.711816-1-christian.loehle@arm.com>
 <20250804112743.711816-3-christian.loehle@arm.com>
 <aJCsx7hbCD9f5RK3@gpd4>
 <c8b71208-b8da-4f64-9550-13ddeca9b225@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b71208-b8da-4f64-9550-13ddeca9b225@arm.com>
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: db3ade7e-2a46-4c02-d380-08ddd36e55db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hyqpLTmOtiEr75pA84n+5KmvyNd6EE5M1WYytC1iMwdBrvNEzMQcVZnSvO90?=
 =?us-ascii?Q?BQVdcs8RaFW498cQdVeJI1O2yMN8RQPZj8Bt1FvhxcerANUK3ERf59f46rRy?=
 =?us-ascii?Q?ZOkyuFvBBqDa4KH0IvxZBcb61j//X9cBiGFWTMLtvaGbz5aSD+kJp5oL3Htz?=
 =?us-ascii?Q?rW0Gth7BKwxvWvvGwVU4VHyZf1Z9JJa8NtfACrOuzrK/yIu0wNwFHX+0N6hX?=
 =?us-ascii?Q?2VIjozNVFYcf1eCNhsxZfN+ABwwEBCkKOmdaUzfbZefmQQO3M2IJKXdq/CED?=
 =?us-ascii?Q?3BiySJE8vBuwe/jOnM+y9ERgMdoPli2nQIQVhis87O1+Mtzosmhi9/rLKDIz?=
 =?us-ascii?Q?LqlnDHh/7y0kOaned6rsVU+alYalKxQhpJp9/i1HGJ1HznA4sfVFQspvYmH1?=
 =?us-ascii?Q?3H3PAO+KpyFVYz4iB4Mujld+O00PfpPufPOib3ksiR+C/f4+dsYfKFWCu/I5?=
 =?us-ascii?Q?3NYyNGUDZWPtBrUWOAZn/Plu4t6lVSHST2JDUGMGi7THAxzWuzwcBcrmjZGP?=
 =?us-ascii?Q?JUs8+3njQUR5WH1o8JTH4hSmkRuaAdKgUXuFnhFWk56GJF1fcGLSLZvyWv4M?=
 =?us-ascii?Q?8DSz4l8JSIW+sq77iEwftjyPtarYHFJ+21Q2YQhTHbaMdKc+Q4+TucG93/rj?=
 =?us-ascii?Q?dIdlWyFWmcfgzGDwi57tsg9HcmSrSTnBMUWJX31rOaDKPR+qSR4pb6vhOtFk?=
 =?us-ascii?Q?vc282MyvN29hzgQgeazGFBh1/RqyjANuQFhfAwsQt/w2FNK1vq2oiSmN4K/X?=
 =?us-ascii?Q?1BMiGsmgzl3eK61uK1eM8SfRe/HJGvJwTo1Dfb7yYy8chz4lWhYE1vui9jGh?=
 =?us-ascii?Q?n3gF4qHhFs4hcellQOZnU3sF7nzCy3EMw/SROFe8afHYqyFVtbQvow4VgmGZ?=
 =?us-ascii?Q?XhY81BZyA6a+McFgeisXknwwXetVMU8H6HYanYO3OFhDSDoy4qThgUdWZUwS?=
 =?us-ascii?Q?QxOcWqbHqoritkBtRGVLxVO2BUzsW9CdfbHvYJc9kXphq/a5XYUM2kTzSfv/?=
 =?us-ascii?Q?W+FOkQBHLMYuXtDN/GZ2a4GptEZN31LxagmE5KC7gCVuqvcHO86Qu2QMaM/v?=
 =?us-ascii?Q?x6XLJZWZsfyCQ1jXApy028HUTIIxMyvTHAFjqko4pEEl6V/rZ+5YXpDfJaTA?=
 =?us-ascii?Q?LVFD1td/yoFldAVtdpabEEA3AsMImVN+JcZcvpTv4GP27CO/vUlTZxGCoxhM?=
 =?us-ascii?Q?O6yBaq8hKHwQ1KCgg5HjzOZ3mzQOgpAZgTcRbHRuSo1ABGOKTzesyHHd9EHS?=
 =?us-ascii?Q?k655jCcFTej/so5MXgrjpVbgmVyyuw3khJYHvsGjstZhMLD6EA+qQY6gir9u?=
 =?us-ascii?Q?80cq5xS5bp5p/OXA6Uk9B1+TW0NGV2JtNYiu5WmC5LF9WrfVbZ06hadHlVun?=
 =?us-ascii?Q?rmMm3bwGJbNrhEh1hluyoUS2AizISgLTveLB3uKDkOAg2GuxtMhmvaeCTk4e?=
 =?us-ascii?Q?WVjsMHEUnrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1C4yETrFbj27SwDpCTdWJ1KkUh8SzwtILBcLBfLWlyg4XKHYcuq8Zu+rIV+e?=
 =?us-ascii?Q?4Wqs+YZgrkmh5ZLBQ1E2K7PJjYPLeemFse8nv9WmtmKiRG2T+g45MFYTN64P?=
 =?us-ascii?Q?YE6153f1jMV8IUdXZnvEJjTH0KcBKIK35VdtBVs+ZBuDWqqte+6cEVFn43Pd?=
 =?us-ascii?Q?gred+oMizILaS9klPO0b651tYZJw+aiFix0L/2Mie/toaT0WE21GzBoyn6uR?=
 =?us-ascii?Q?WDPsX4gBSL9Os3XnzIw1Mxf0UNrX1nwKZTJSoaek8YnqN0SPGADUqZlJ/GKL?=
 =?us-ascii?Q?TOXqe0CxIqozE0n7iDjPMf8vzbiPT09g/qskO6h6OGU7Mek9dOzM2r+GMtIn?=
 =?us-ascii?Q?/gCHSxwjvcM9BWJnSLHMZ7BBJy7fmipldTnDG+Hyfjj42SnqgVPf4ep+F0/o?=
 =?us-ascii?Q?vN28evdjHO5ZIx8NKBOp34qDLXBbEJ5Y+Bk0amnFgRWuHakCTwLHLQ3Ptc5c?=
 =?us-ascii?Q?kao8MjD7Ky5EkRwyoxrLxeFtFLxjcD8TA3iN37lo+B9Q0yngP348n8+Q35KW?=
 =?us-ascii?Q?UnbYLbHa4B9iqgU1OI0bvGjb+QiYHGVNMSZXxUGQHkw7O98XGpGfjLMFRk6F?=
 =?us-ascii?Q?8c8yGlqdNsVDrAQbVndheeDEf1z0O8bwPOlKpPBG4EWMqbqGswhY2SgTPiys?=
 =?us-ascii?Q?9J/hLE0stTTXlzyOyI35qlLkqKMO3+kFyxfMqOP7S7f6LaYYKpfWjOvoDEly?=
 =?us-ascii?Q?4IsYVzbz4p9Ny2MqhxYrQijWgHdrsSisPVnA1XMaHNnc6Pe8I2mtC8Sm8/D8?=
 =?us-ascii?Q?8wq1KYersMIvEF2OLRxSdrlXjQQ1UXpi43PdgIdlJOymDsl/GXYE3B1sQrcr?=
 =?us-ascii?Q?4fhi2iaic5Qx/D7T1ukTf7JTcA5X4YcK0pkiEW9qmiO8kw0kwmIKhIweTa40?=
 =?us-ascii?Q?CTCFeMpbgRhbGFn08dB1KFFRPR21P/BmImlTeY7biF2jTNWkyNVu/BRRFfIZ?=
 =?us-ascii?Q?XkB3B7JDPZET4veVZK3XFvazP4nFs1aXRl74MG2zOz/u44IgADo+IK/UevKT?=
 =?us-ascii?Q?q+fOkL8yznj0JDxzi1qUZ9RN8shihvAvOAfEEpo16p+k/qa1MlnK7g+n9PVP?=
 =?us-ascii?Q?lksb5ROpzdQeKhORoO/MQ+JlU7wwFNBVQYAazacgMgZnt5pAL8bJq0ly1Pg0?=
 =?us-ascii?Q?3XIM0RTGvnZ68Nu4Q5BXqItlEOXRYOjraRZRQpnKQJT79GEP6cm1Bq0rPa3P?=
 =?us-ascii?Q?vkHQUbpGLik8z2aCCeds9BPZ32noiJx/EmFNzz2PCfrW1d2zxh6Q7y+VcRel?=
 =?us-ascii?Q?Q0r9WRUcWs4KrQaeUAiwXZMjzAU3Rq7F639niyjiUU4o/OejvYebI8sB7quI?=
 =?us-ascii?Q?QpgA1zRQAA+9PrvA+0hs8M4E+RJ+Ad1NTog7WtMQMWdM0CYVLGCZxrJs2NIx?=
 =?us-ascii?Q?qpY0pC5qd62356Kn7N2fiE7GMUogsN7nmuJ+2eVnSUunXPWD3Xrylw3aSvaA?=
 =?us-ascii?Q?1wWYPSVe5eG1RAaphJm7tQguCkZmghIyioA4lL/sDVxoqX0gy7lGzD6P3La0?=
 =?us-ascii?Q?uS4fHXEIdp045feA7CALYwG1XQD9XCaTv//gLcPvqND3O69WwM0kkWY8kZJ3?=
 =?us-ascii?Q?KVSuGR6IpCdwvZjBG79B0uB1o3G/mY0moUV4iqBo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3ade7e-2a46-4c02-d380-08ddd36e55db
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:48:19.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4PQrf53w/MfMclXl2nKWEclVs+ikGlxbpVGJsP2Xha4NOv27al11iUazD3hfvlRwVDbGfJ0VKZmDnh75iRmyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

On Mon, Aug 04, 2025 at 02:27:14PM +0100, Christian Loehle wrote:
> On 8/4/25 13:51, Andrea Righi wrote:
> > On Mon, Aug 04, 2025 at 12:27:42PM +0100, Christian Loehle wrote:
> >> Provide scx_bpf_remote_curr() as a way for scx schedulers to
> >> check the curr task of a remote rq, without assuming its lock
> >> is held.
> >>
> >> Many scx schedulers make use of scx_bpf_cpu_rq() to check a
> >> remote curr (e.g. to see if it should be preempted). This is
> >> problematic because scx_bpf_cpu_rq() provides access to all
> >> fields of struct rq, most of which aren't safe to use without
> >> holding the associated rq lock.
> >>
> >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >> ---
> >>  kernel/sched/ext.c                       | 24 ++++++++++++++++++++++++
> >>  tools/sched_ext/include/scx/common.bpf.h |  1 +
> >>  2 files changed, 25 insertions(+)
> >>
> >> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> >> index 3ea3f0f18030..1d9d9cbed0aa 100644
> >> --- a/kernel/sched/ext.c
> >> +++ b/kernel/sched/ext.c
> >> @@ -7426,6 +7426,29 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
> >>  	return cpu_rq(cpu);
> >>  }
> >>
> >> +struct task_struct *bpf_task_acquire(struct task_struct *p);
> > 
> > Can we move include <linux/btf.h> all the way to the top? In this way we
> > don't have to add this forward declaration.
> > 
> 
> At least currently <linux/btf.h> doesn't declare bpf_task_acquire.
> I'm not quite sure what's most elegant here, none of the bpf helper
> kfuncs seem to be used from kernel code / kernel/sched/ext.c

Oh I see, it's a kfunc, so its prototype is only available in BPF.

Maybe we can use `if (refcount_inc_not_zero(&p->rcu_users))` directly,
instead of bpf_task_acquire()?

> 
> 
> >> +
> >> +/**
> >> + * scx_bpf_remote_curr - Fetch the curr of a rq without acquiring its rq lock
> >> + * @cpu: CPU of the rq
> >> + *
> >> + * Increments the refcount of the task_struct which needs to be released later.
> > 
> > Maybe we should mention that the task must be released by calling
> > bpf_task_release().
> 
> Sure.
> 
> > 
> > While at it, what do you think about renaming this to something like
> > scx_bpf_task_acquire_on_cpu(), so that it looks similar to
> > bpf_task_acquire()?
> 
> Will change it to
> bpf_task_acquire_remote_curr()?
> ..on_cpu() seems like a bit of a jump semantically.

Ack.

-Andrea
