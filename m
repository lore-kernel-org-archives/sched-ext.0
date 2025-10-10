Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D23F9D2
	for <sched-ext@lists.linux.dev>; Fri, 10 Oct 2025 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077923; cv=fail; b=Qk2cnFpoTYGwrJ4CLJbXOaXN5/tu4e2q+3pL5uVd95ZWjgaUHpGMmIe0KyIEZFYFkZjfM5T14RZj8GEGuLqodruh7dMgwvfi49253aW6NCgal6UnUznQm2g/5C2ahdFnNQfGGHtZFsQkVeo2q7+w6CqE1ZB2A12DL6WdDHi5Cd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077923; c=relaxed/simple;
	bh=H1xidnI1DBFaB1WEBto7IyiFVIPw14FYRg5kjRyz4S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DumZEf+VZZHDYWS7Lxx5EQMZYG+cMV6qq6KqWsgqENb8yf4fGyYIaYexcJ7qtJf1DdqzY6Lr8utpM/6wdC5ljpJBolca7Ofg2DU16kRXyR8RIfo3rpX/ifT43kPB3xepiz9MvDUynpU3bHyd0fyidpTVVagNT70K3rSq7AByJ8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJQ5xGc3; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJQ5xGc3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzVwC8mhVPLoeUgFJjQS4bckkngEE5wmn0+DXq2qOm5i+7H35EtQ8KILIgmjerMScF4X4GV5v5Xdp6J98mNWRGmyGlmlswQ2frEvOCxiBmBCkva8IHoqM+ytWbnOEkVP2QeMJB9FwPbdiEZrbgbyEyfBuv+/Rj554wAIotaiMDs/T/PyVnZ+YNxDkF8/pYSGpb2UqjbkIcebITDoHKVTJf9kL0kWmWdIDf3jb5gf4bq+qxxnywJu9/FthuxuSKXX1B6vBweFJotwmGsAsPILYaEK9OV6U1hVH1TDXxTzQVZxc/9F0MARaQmVtPrFVhMpkEWipdBA+mAfacEb4BlT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h71l2rTK39VL66uq/2vnZlzcYyhPY6eGZ2wHYrnAhY=;
 b=yxVWc8Z6DpwHBPAr6BPtLtoCl36YIH+0HrrKeYwFa7dI48y7HwkWYeXVxCeAUfsx5zSwr/2o1Nn599ZYD7U1aiEGR+xjEbD7hrKLwCN+QwfbBLuB8ADtTFUklnwVm+27oMDeGSO8ycl7BsisjAa7jL2KSHi6FF6Nb5wtgbhrIckqyI+R13NEiYkeauEF36c0+qmicMsoW9n9MJjtKk7HoH9lggQ8VtrXNwd5Gy2i8Nm6bqFcrQ2dujN3FuZPo4yXq7NbqBHfhJiZ2fHeXuSwTImV3XF068PBiwUU3xloFt9fRL1SsXYUHCEizMgEOFDVJvhYgFkBHFZNi8V0F2J2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h71l2rTK39VL66uq/2vnZlzcYyhPY6eGZ2wHYrnAhY=;
 b=HJQ5xGc3J6hg9n8AuAztG3eAbGFN4vneMWY05SzOkUkzdF+G3l7xHfudeEEt+QdcHi+UHO7rzoihZaDlUaOF7cjB6dklpWskTr5V9YD273QfQwIl6NLCy8Vxg2LFvEk1LMQ4i8yUt0I08XazA3JYDS6acRtHTo64xJ8dPvzukSFo/KHuQ0LSjucTRW76nTMcOZyk4O31kW1V8wla5zWJ6jcgQDY2pH4AACV6lxLLM9Ug5xR/880PeFh5jJkdE41gK+XRtKJUAVBgOpPDg+wTMKxI1q67eWUJRviR9U1jhTYQZFaKl0QQBTd22aqtQfjnnLB1fFXqsXKWI45dn7Gu9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:31:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 06:31:57 +0000
Date: Fri, 10 Oct 2025 08:31:49 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-6.18-fixes] sched_ext: Sync error_irq_work
 before freeing scx_sched
Message-ID: <aOioVT5imc8YSOJb@gpd4>
References: <20251009235623.4135746-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009235623.4135746-1-tj@kernel.org>
X-ClientProxiedBy: MR2P264CA0034.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::22)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a42c9f2-6d6d-4ef2-96c1-08de07c6b626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1G5sEbgeI2Q5REr+k+xLIBjUtlHB1JXcDpiEFqkoqBI7qODcanTprHXbEeI6?=
 =?us-ascii?Q?5rzCqArAbMQCFI7zYo9kqLkYrc8bOtXSl8BIonbYu2m4ssQdqyWERZISN4n9?=
 =?us-ascii?Q?B4SZmI6LesC5p/jDlbQk3WiVjwGGtWXcIOiO0K2Gcwxf88nMoTN08cl1z+Pe?=
 =?us-ascii?Q?l3twU5mjXkPUUFsy2auvqOP8ZuvT3RPC3jNim63dsqRzPs6SuuizhU5nXWKu?=
 =?us-ascii?Q?AEtKuEYKtW2QGLjCsdUZkzrKqBtG5SoocqMZl+xi/xElZWiM9MGGFh/QJe9P?=
 =?us-ascii?Q?oEeitMF9HJZdx8rNr35VZFX6HYsKKzZzghfdewStEEvAY6DRD8g+hBNwRnMy?=
 =?us-ascii?Q?VphIH/MBViSQkHTfXlepIaGmyLEs+jXzyaKxU2DLjiOyj+6kAvoW1XosPno8?=
 =?us-ascii?Q?/YU0+eQhrs1kDnivdLIDHb4sGf0LNeztqmiOdQwo/EHX6w2oorOzeXS7SUmc?=
 =?us-ascii?Q?/vgzW8r5uys73jcV9jNOuzSkoYXuCW8yPgqFkBLgs2dwP/0y3++ekBQ99r6Y?=
 =?us-ascii?Q?sxkNv8Ag8dpy+CTxsJSps3JlWm7beBMkT2kKaGa4rgUIt3vO+x8XGgSdH3N1?=
 =?us-ascii?Q?on04vDZfOCLkSDdUbD+0xBEE/449Ww0z8qzWn0GfZCV4+ZXup329ALSs6/Vl?=
 =?us-ascii?Q?IE94Mttx+r54Z0rV5mf258wkpKIt6OnwFuT2tSPDTEj4dVDISYc7YWNsRA3E?=
 =?us-ascii?Q?g62ZDEe+uMzJipPznqjNUWq2UQtl5hUOdW76K6p5u0owYrh+9OBf63Hinz4t?=
 =?us-ascii?Q?S3r/pbbP1LUMqOvcgFfWLJK3HyFY3u1ZFFAz7OGmTYmTeEx/G43Qxalt5RN4?=
 =?us-ascii?Q?ITwQeW0Yst7/gXpQsTZZFQ668Sa90LRdkipBPLz4XrArt3RK1wrHxm3jjdJ1?=
 =?us-ascii?Q?8Vp3/VyHVguipUnEl/sS9NCyQxugpL/x7lKGoRThS1ZHwRlBvPQ0mA+UrqdS?=
 =?us-ascii?Q?yP24EWIpUSJJkUM5dKtRuNxK1Cvfgyq22E7mSQhQ2rnxt2kcOwZcsaq0GnkN?=
 =?us-ascii?Q?rEuP4kJGxFZjn3G6S8M02Op/0luLIMd0BmVm0Y7PdsIjLG+jGRsFB+IU47Su?=
 =?us-ascii?Q?I+R3x2RyUKfPfkC8U8CgfPftIaOyFqWMK1vydrwwvurjnRrAQHqnu2jvIOl+?=
 =?us-ascii?Q?mSblrzKdht0p7mu5XUr1tHfSnD5SQEqT0aus6IVANKt+uDgXpB7vGOY0NEIa?=
 =?us-ascii?Q?t3ra0XoPJT00RxmS71WQnYhhHnfH6mgf7G0CYVLqq9ItMnTNDofzfg3e2pNH?=
 =?us-ascii?Q?SRzETHHwx51iIQxKV17Rq/HCQjHEz5TuLvfbwwZyVs841c+yng0GL1PD3/fO?=
 =?us-ascii?Q?+gHDJDwQ6OwvR8G8XR1WqYrtYshqxD+vaOoq3f+L/S55JABzShVkKDPbQXj5?=
 =?us-ascii?Q?wdP9+nM7aX3LeikePTrs6ssrWZxdomdADZXKCAACkHW8u1Sj7tJF4cfWx8U/?=
 =?us-ascii?Q?Dgv4wO7TJBVejaDBI4nY+KRsekhlUbgV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GLuZztwQVfJiMCNfDix4/Q/G8QQelps+5MXE2XmtfY+vDS+TXuJ6Vs0bTKPR?=
 =?us-ascii?Q?N44hHr1eO2rxgwB1DUxlwRem9yXyoj9QNw2dLcOtJzksifeLXXt8EvQvyYE1?=
 =?us-ascii?Q?5np/CLtfmdghFlU1vr41xq7+RkM2a9xvkr649sm9nwI4+2OMX7UZ94FdJYkt?=
 =?us-ascii?Q?MaXmmqUl2lXx1Z0Wolj8jbI7C1QFWa5xVW8PeCgOCf9FIMUllaonjXLUVgKO?=
 =?us-ascii?Q?p5gDHo5UPQoUhnlmnIr2AFjYG8VLhfLqPJnzHnCgmK6PhBYt4VgJE7c/DHiE?=
 =?us-ascii?Q?/wz9shiwryHDUEo0eFDqOOvHPICsFQs6LUlVp0PAmEU/o3vlEUSVB/pYC/xQ?=
 =?us-ascii?Q?FMEMVM4Bo7ZVH+8SIox1vpHejAAyTeMJQCbSHmHYnHOGRjZVFQJ/tJ8lJyQa?=
 =?us-ascii?Q?cfvKpIp4fwhPus8k6iX3ISDdZ+I4xFNSkzPm5jBTkqPBHRCQzoTqL3nzvi/E?=
 =?us-ascii?Q?fd3nS2RIPodMW5hl0MmkHeWtKy18J9c2JRoiqdtbioeDSBIu+E1bi7ZL3Doo?=
 =?us-ascii?Q?4P0FcqkSvRwMLWe0DOzVTze2agNJCkx8lDSpbVLYD/xYkL4v0lWfDWyziH+k?=
 =?us-ascii?Q?dx1q6Q4sifpUqVuYoSXDxISyTFj5f+V44Tl5XElFwLqeuK822iQNeB7svose?=
 =?us-ascii?Q?zILdtC7nkC9xpo+//Mykr3pKlVjcoTdTXH4tzodFvbOGmXMwau5lWksfv2Q7?=
 =?us-ascii?Q?nVRhzy8VrMsKn/GgrSlEXrTOc5vXJ4FC4Y3EXBmYDkzUpt7DD3euosfgjWQg?=
 =?us-ascii?Q?IoMcCPznKSTTFwhXA9ldqVNWLIm6KNAeY1f8rg4fq/7dipW+e70ITyns26U0?=
 =?us-ascii?Q?3GeXWEMOgNlwVuzF8TogiIw3Y4zGUB6ayYJgRGW+q5fOFcQnDyoHEgE3QLoF?=
 =?us-ascii?Q?CzMYgykHff3Jtj+05p+NdPI/JfHI+QA8TAkaUGq6lti9cBHuMslYmHWZds1a?=
 =?us-ascii?Q?q0XdBtlNwvWjgAQR+0MFQyXwTJ4xYWTz4iJB1FiuvzVQYREZ2uWJW4/U5Wxi?=
 =?us-ascii?Q?H80Ou57HVNfW8SD1+zTjYXFy0Lt4fnRm5cF4cFdAFQ+/y6klDwyylCqlTugp?=
 =?us-ascii?Q?ubp85wMRHulbmBt2wbsEDdyUtpohJ6+T6NQc59cM+bPwp45P5erAP8jgG2n9?=
 =?us-ascii?Q?6mMGsSI9NPP1asW8Vd2l+DEsiN2eZV9dlzXqJvnd+2jqMxodBk5voli+uwhq?=
 =?us-ascii?Q?sPIs6d5mL07hQv0sSL/eaI3jQRIiNHexcfErKCdqdjXkgw77BMIcxV7Ym3oP?=
 =?us-ascii?Q?938rBw6H3mELYwJ5yaCPk2pLcT+taFJz3Bwc4aT19ffQWCMBsg7icGreos0Q?=
 =?us-ascii?Q?nwE10k7Ex03+bDaIhpW9/aN0KiTEUQq3yMaHXCUVgAdgC9e2UotcL8bis0Sm?=
 =?us-ascii?Q?1v2ZymBJ+s8BMD1A0qJLIXaSlswqcgyqrMqwT7oQLZY63UrEAffwyoQ9Wi9L?=
 =?us-ascii?Q?6Me6Hd9VmtF1gbJQmM5CwjA0mIvsoEzwigtXWOgCvziMXFgdWkovCIhsUE8u?=
 =?us-ascii?Q?d5lXBc1j7B+Qw7lys3lokBFf8qzr53OyRRH6ePYAZZK2IUTFGpRTXF6TUzHh?=
 =?us-ascii?Q?dHc5fSWYVuY0dt27MAmQ9CCJ5KTJHVsv+Nd9SOb9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a42c9f2-6d6d-4ef2-96c1-08de07c6b626
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 06:31:57.8562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEq2PEI3BaM0hjQ1p1+gJa3Ix4Fo0YCi/EtiH1pDwZO7KyGX3DYOqkLy7xE9p8qjI5PbW+rMI210+mIjiYJveQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621

On Thu, Oct 09, 2025 at 01:56:23PM -1000, Tejun Heo wrote:
> By the time scx_sched_free_rcu_work() runs, the scx_sched is no longer
> reachable. However, a previously queued error_irq_work may still be pending or
> running. Ensure it completes before proceeding with teardown.
> 
> Fixes: bff3b5aec1b7 ("sched_ext: Move disable machinery into scx_sched")
> Signed-off-by: Tejun Heo <tj@kernel.org>

Good catch.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index XXXXXXXX..XXXXXXXX 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3471,7 +3471,9 @@ static void scx_sched_free_rcu_work(struct rcu_work *rwork)
>  	struct scx_dispatch_q *dsq;
>  	int node;
> 
> +	irq_work_sync(&sch->error_irq_work);
>  	kthread_stop(sch->helper->task);
> +
>  	free_percpu(sch->pcpu);
> 
>  	for_each_node_state(node, N_POSSIBLE)
> --
> 2.48.0
