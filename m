Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FB2C11E7
	for <sched-ext@lists.linux.dev>; Thu,  5 Feb 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313093; cv=fail; b=B8G5G3OHl1enOZwd0HrJnQeAksZPmw/Bq28n/daDY3TTXbjMrr7Df4A/jgYomuPo1yYFAuWId8nxWyxY0Dd0UKDRcLTjA+uCiQzfOA98q0sB3b7X1Fz8ybpLG21aiQVLh4CbIZ4I+R4uI8oTid1/7dLRso5w3Ox5pz+g5r9xQ70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313093; c=relaxed/simple;
	bh=wrET2moC13ahCEFuaYT+Go4NEUtoIrbkiUynNnia1ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a8t2N/thTTsObyqTi65NTZp810UIW8xVKHKIFcjYzAFevlZOHP7cMxKdqNZGv6IUzyy7XzERPBwULTnKDDcRNnINzfVdzrlWntBdWkWCSgKfdgf+Yz/SxKsmqXMlYJuLYs8PMFRUt6NM7fh+mCY6tS2C1wi0MBLv1L1VKh1mL9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGUjE/24; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGUjE/24"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yb56rcUg/BU31CYloLhc+/8dN/HSx1Y1iLVZ/ncKd4q+GHdSrpD/ylhx2Uufc/sQDWstSDoCV7v2+vSORO1jH6WvaLynBnIjNxsJm1uNvQZIglTs30xkNip2cfzqzaAfA485Fi0nIDYpclWOFUsmWgFKPl+YzHBwQig+cWIJDJ4HvG09DAFmiS3QUo0gj25sufwfaQB9Q77GqGOgfb8Do8tpoeLhTGI41kMXHsE7ztKehkWKzyMtgbbqdjU0mXv3jQJlGWWntAaSylZ9ZKgH//o1/d3A9vmZBEVf70dPG2FvsC1MnKg5rrt6Z2MJ4TLCK9DoRQAe1cPsVgG7mhBjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgPIwd/xiMKR3muX+KNONWOy0N7xlGma2PVVjXKevn0=;
 b=MjJLl0g6ZFh4ICHwO0MWCC5Iu81Cy62L7X7sR8RsBuTtwhIWUvX9+OECC8PwZTPav2tyBE6JO9wVwgNmX3pE5NybMbN1sWVom5HKkzUVi9Su/LqjBnZXrCETh25EHO+0JdSTCo1LgDoIt3TuFUJnauzHtP7Dc62LMcZYgmbICA1LJDhj0mV8wbbg4ZHBxpYEe3lQfaTGOs6ZS2RblzOqWBE2lDjxVM6WcpYOm6542qA1wVFdy5f4f5paOfu7TfdN9wQfV4L6XDYynJt9KnkZVKecnyh8KTrR11kyX1QH1nodHb4aggK71GLWn80DuReEbaio4SJI/syBAzPdK68olQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgPIwd/xiMKR3muX+KNONWOy0N7xlGma2PVVjXKevn0=;
 b=UGUjE/243NOARXtBFjohKqpKy8qz4Yop8sf4uO/7z/7EUSncgrpF0bAuyENgHAoGiCVenoD592fsd+yypwbrOqDknUeYtUOLf2EnW6VcOKAfT0frq9RYfUEEkrEYKRiaRs3kly4SzJp3jGlw0J7MMykA2PgxjQmHsavHrV/LvYefyMBL4IyVQ+u+Dbfo+CbMh2xeE0QaVcOPGHg22gLWT8M3/nFgZkcxOh2KCLqJ76GVl8X9y1mEgFJlNxAcTwt//IyNGmVLNewC4vvjsa6avC5E0JVB12NT0QD3USiah3i0IhMEVbmHdQg6+EN8zaYenhKsyai1L5L89UjHEPoqGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 17:38:09 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 17:38:09 +0000
Date: Thu, 5 Feb 2026 18:37:59 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity
 changes
Message-ID: <aYTVd2UeB9HXOrLE@gpd4>
References: <20260203230639.1259869-1-arighi@nvidia.com>
 <DG67IMOVU2GX.2CKP769EXJS12@google.com>
 <aYNnmI26oS7YNuMP@gpd4>
 <DG6C5HB3PHH3.2JRZX83QMLK2X@google.com>
 <aYOIRZosqGk-k3l-@gpd4>
 <DG778ERAXQH6.WKAOVK8AGLNL@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG778ERAXQH6.WKAOVK8AGLNL@google.com>
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f7b70e-86cd-4a9e-158d-08de64dd5406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RNOcRKrh96I/WnB7fpqJa4MhjZrU29POqn0UfMVPRxyr2H+P0nd4Cyidn45E?=
 =?us-ascii?Q?t60jorwGwe9dO6q4fmvm3CUvydLMTA0Lf9XARCTFTZMW+q+wAxoChwDROT8w?=
 =?us-ascii?Q?qrTrNQUZSHKll0HGGuKDJbmjUUF0H5d+rl6t2unNqtvyNb1CPx+jFT8eJw4U?=
 =?us-ascii?Q?3Fl6jW96aM8VsOrbtHiQlsTy4QVbpNASkZ3FlC/+V/kzOKGxm0DwgRRIzmg3?=
 =?us-ascii?Q?iuCNfA+aIwZRAbQ433VHFMbyrP8yq1WSYSY2FJH8y7BHBh0fREYilmD0p3ro?=
 =?us-ascii?Q?wnMJDEP4QFqzTxAfUbK+6zbfSdSxKl7xEbbD/CFSIaP4AAJELsUe7V9Gthvd?=
 =?us-ascii?Q?RrkDxiIJtMyAFRhSZtcZLExW7WWz7O3ECEOw9oi7sghQQf28x1nMhpn8wA6A?=
 =?us-ascii?Q?1M6f/x0jLelZ8DCVIuS2+FRSMQvLQRwz3M8VDAcwK8YtrO2I35YfycbzsdeK?=
 =?us-ascii?Q?lFvNS+EQ2JSnx7a/FWP/I2hm7zLnktXBzHov8b+QL5xenX2PeIbR0RCXUeXS?=
 =?us-ascii?Q?GfWFyvPg5baNf+Tuh1aRCepdHyv8osvgNlewnIX8BmIZJWYQR3UXDqCAFs+M?=
 =?us-ascii?Q?Qa6ebaYOoZG+NW2eDFJ+XfHCkrM66zPN9YF1M/MBa9fxQi2YCW1sGZA4SRE4?=
 =?us-ascii?Q?Bxfc9seoWXRUlE+0nZYbqLHurGtDSIhw5Yyt15BAFrZRJRHHPGKLGq2iac6j?=
 =?us-ascii?Q?+40x+yULUVwp/qQuS1YX5vs+AaUbuNBV7Lx9gspp4wgjQiYXoj7MKGLqxuY1?=
 =?us-ascii?Q?jBozyLTf5SN23J1EI0csx0aYwcz11S0bw2YiXPsSigXLc7ELhg4MvidS/MtP?=
 =?us-ascii?Q?V13x/oayYf32hVKjB68A9pcmtcEPqyLxip/Nmjscf/sa7klu7ZOIzkYK9Cy0?=
 =?us-ascii?Q?TrhTpHbZIJHYgSL5S+1XHwts6UPp7yIAsdWS8V0nJQZIzXkIFYQGq2RiW9HE?=
 =?us-ascii?Q?enwAB+guTqDu44Ddd9M8qiMsWciPL6RPZJiG/yy55doHPG841766lPyqi/a8?=
 =?us-ascii?Q?3rYVHn5/c5NRCPT2QAxUQp+S1G3o8TM6y+kgNv1BJh5lyoFyjJPCyHQEtB4C?=
 =?us-ascii?Q?naX86//yNkK44QanIgVBhmNo5Gc++XIdxJkhuhlcHXgdOj/XIOc7xSgC2U9l?=
 =?us-ascii?Q?/9HS36zo7rBtpH00YfiyG884Cwx/CJasBQ/Y96UWSCWoYKDTDBDQXIBahAuC?=
 =?us-ascii?Q?xqUDtXKi/mOBaaNOD1arzp19sgbDuRxJtf1HDPaiCsA21jKXyEKbNM1b8esH?=
 =?us-ascii?Q?+/j5ckhfL2IiTfYumya4DiH4nQ8+mJNjJXLTbAJ7sU3z5u+nhBkwbHBpzxt5?=
 =?us-ascii?Q?GsRpQeH4er+igm+rrmTNddpd/bBU5nGKDbPphP4Hjh7Yh72fHNLSKQrRWTi8?=
 =?us-ascii?Q?u2mE14HPYtCGOI6sJx2FOzLlABYY2tk25zgspbQd/35/LDoyUHBS/ni1Izhl?=
 =?us-ascii?Q?gM1WGsjAlnpB2G7aV0gLickjRbQTVGE5ZCSZi/m8H049pxzqjH3+7b4W1U2K?=
 =?us-ascii?Q?aLyXHoJhqdpqq9dEwkTayCVvPkp08PsJG0rogutqU4x30jq96dmK5aVc6Wse?=
 =?us-ascii?Q?C71gOXLl0RKaxkOLXA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7lXLXBgi+I9RdqLAWMq9anxsYEsQYvWU0JWPh/fE/GaWrTM/vX8nmzpSSarr?=
 =?us-ascii?Q?SWkYZoCw+vD4jCTA2SsNiTnylNQVdxBEtOwqy0OnxADbX0LBwil7ahEkjsfA?=
 =?us-ascii?Q?iAdpI4MSWKItjr/M+dtZSl77Fd4e9OBHp6l2RkhYLnzG+wDT03QXyyU5zw+u?=
 =?us-ascii?Q?0oy50Pr0L9YoeeoE0vMeVM9UG0q6hTpKNwr/LczdF0XpUY5Zb6uCG1H3Ok//?=
 =?us-ascii?Q?wIljeUrGLtrmyaxEj+pclBhVcve7QeFmpR01dL3RYNJDiTe4bj7IRIjcACix?=
 =?us-ascii?Q?SzCEpiPHkmTsCXfhnYFGxy9OWVZqgTMdy/46BaV+8CnoOp3XUMfnLBRpnICs?=
 =?us-ascii?Q?Lpqejf3rUBj2yTN5oP0trM1K8/PLNDLkNl8sLXiHOirUumK9MLpFSDuMzSBr?=
 =?us-ascii?Q?Oov2ISaoDA7K2N/Qn7EALMZTl9VBN+VDkDO7C809KGFQASAxxsydqtT1+6kn?=
 =?us-ascii?Q?cyQF42TcbCUythXiU86rBMWj2zs6AevYfhIGwA8Rg/kzRe5ikSaZ0+tJ32rF?=
 =?us-ascii?Q?JydLDOG1SNAmsnYuAoIdBAxipOExjkMjsSX/pQbILBR5YPL8caOXx5av5ulg?=
 =?us-ascii?Q?GZ9DQI9dE00k+xYyDjyN0ghKWrmaDWKSkTe8GnZO8B4l+9WKiYjsAz2VD8iQ?=
 =?us-ascii?Q?w09bJvwbBDdec2sZJNYOkI1c7NlIe7LDzMgeDAkVPgt/vrVU0BO3mCo1QGdv?=
 =?us-ascii?Q?wh7Kz6KytX5B3eVmr9+eAWnz/7JLFgAiKYDHzC5r3eaUVE60JvE5yGJanKbr?=
 =?us-ascii?Q?EN3uw+0Dy/mA9DfMRU6Vjty96pMJwq4wgQddSIzMEUVS9dwZQQuJjmP5jIOS?=
 =?us-ascii?Q?BsYFRZ1LxhBaYATvQDWun5EZffX8niC5wExO6pocTzjkZCxnNu/bTRbuZ6mX?=
 =?us-ascii?Q?sFR4Aspl9Sm0Hh/9DmuDo9mGjTZDNgEFqpUyZOibD7TF6EmlbQwCK2Yl5PLH?=
 =?us-ascii?Q?VVDusGoaQi8UoqE1paTE32a4f3TDCCDV54M2pic5q7MU4OWzehNRCretqGmJ?=
 =?us-ascii?Q?i04IuVYt6WHuVYkho0IEkY50mEpqTm1AYSWceAcAPecagqesPuvMRjCgf007?=
 =?us-ascii?Q?d5iAAzsFmvNuqxXDJEo0f94N6VbE0qOfuaB3hOmnAJ5g5Q29brclLyX+QpLE?=
 =?us-ascii?Q?cKAINpGakqXOrse6paEWxvdmJoXseUU3tRqw8a2lqB/jQswN+fHhjqM7aCfP?=
 =?us-ascii?Q?FDSlF75HHo2z2IXv1cHwQb1U54nYqL3a3GDQzISDWfnAkJiS+q/QHnuLaJgS?=
 =?us-ascii?Q?T5b1M+n3cYAwYrBQFLHE6IR3jDddZ5xVmEBERs2V8tBfbcwwUkqa9SMB5fzS?=
 =?us-ascii?Q?DmUmqnGgf4UkaZhpLU4xWiTrZ0qVA+Ri012umXfCkZaPKsKi9UrPdHt2I7Qf?=
 =?us-ascii?Q?2Ma/YEK1tq7DdKqq5sE3teozzpJ7314+LAf+1xthNmYHBXKr9qSGt/Yzis4I?=
 =?us-ascii?Q?83cnwQ8ITRi6DX92W/eFprOLq3e5czDdWl1HsZ+/jxqj8FNVp53+Vn8lj4pb?=
 =?us-ascii?Q?PL7hcM/OnuoCvln2ZN/haYsanzr6ixwBB4iLpeBY7efjGXvjbjW60c5zZ5mn?=
 =?us-ascii?Q?7rFXFRr3wDmYc9BQ8z0G6jCN0seKPJPfpYJvYatMBXlxbAWppUhqwHVk8ZW+?=
 =?us-ascii?Q?Ng/3Z1/Ku6h4UCpD9KQAOaQwCJiJXp296lMolFC2RNWQh/ZsEm7Sk25mDoTZ?=
 =?us-ascii?Q?Pz5gtAAnu3RRKwZ1BUY05YCfpioOUwdDfQ3rZCTbQcF3rDGkIOm2G/lMmV2p?=
 =?us-ascii?Q?eb99wfebIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f7b70e-86cd-4a9e-158d-08de64dd5406
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 17:38:09.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIyyDof+1pabdhb7e7NpxtklhFlE8NmyC1qgSra9v7q5SOVPtpkAm5sx3kBkt/X768BXs4RbOe9P+BThB0Tvxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737

On Thu, Feb 05, 2026 at 05:20:11PM +0000, Kuba Piecuch wrote:
> On Wed Feb 4, 2026 at 5:56 PM UTC, Andrea Righi wrote:
> > Right. At this point I think we can just rely on the affinity validation
> > via task_can_run_on_remote_rq(), where p->cpus_ptr is always stable and
> > just drop invalid dispatches.
> >
> > And to prevent dropped tasks, I was wondering if we could just insert the
> > task into a per-rq fallback DSQ, that can be consumed from balance_scx() to
> > re-enqueue the task (setting SCX_ENQ_REENQ). This should solve the
> > re-enqueue problem avoiding the locking complexity of calling ops.enqueue()
> > directly from finish_dispatch().
> >
> > Thoughts?
> 
> How would these fallback DSQs work?
> 
> 1. Would inserting the task into the fallback DSQ trigger ops.dequeue(), so
>    that we can later balance it with the re-enqueue?

Yeah, but ... see below.

> 
> 2. Which rq's fallback DSQ will the task be inserted into? The one belonging to
>    the CPU doing the dispatch?

I was thinking the task's rq.

> 
> 3. Is the re-enqueue going to happen inside the same call to balance_one() that
>    tried to dispatch the task?

balance_one().

> 
> I'm not opposed to the idea, I'm curious to see how it works in practice.

Thinking more about this, it's a bit problematic, when
set_cpus_allowed_scx() triggers dequeue+enqueue we get another enqueue
without the SCX_ENQ_REENQ flag and it's a bit tricky to manage that with
the fallback DSQ.

So, I'm back to the drawing board, trying to explore the qseq approach...

-Andrea
