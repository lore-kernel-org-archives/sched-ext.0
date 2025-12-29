Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E421ABAC
	for <sched-ext@lists.linux.dev>; Mon, 29 Dec 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767034605; cv=fail; b=enOF9bzgg8MtsPfd6CNIL9horyf5uFUBJJ0bZntE/Jzy7dG1NQ5PkC8dzCUO9K1qlCv4BX9xdQobSHjAysDhmF91WuFq5H6UgZg4KG0cWhAd0Ztoja2O6jtlkIMKICcrH9QHYcd0djpZRDZvbdMQvaBZCEK9bPP1HrHA5LtaDH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767034605; c=relaxed/simple;
	bh=nlXErH9A6FxUXfeJsSk7iyREW2FNeUtL2XL0SPIbsF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=adZEQH+4v4OfJ7Vz8AmJebrm4WNgTXYPIuMWvxfvoqfV2GMpuAaMPM09Ka6ftYtg8gXyPQHuqDfgokGed8MGBq7LpNisqpAGF6lmBN14EveWy1JDqO7+S39KNrijJOkNy31eeTTaEQaksg4stmooLza2rc/qMLv8ZtL9DaJsM6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ii+MSQbw; arc=fail smtp.client-ip=40.107.209.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ii+MSQbw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcRJEa5H+zprFqenvBTQXWvPm12WhFhuo9WFpFwwOFdQwjDe9BcZppA7lE3gFWBwOVXmX8jfilfmkVKD2LuCQU6fMqMEoPUYVEQYouaMP9i0j1ZnD4ma/0Bp1xW2CJmPsdcqhPqu+Tebq6uvs3kbndPV9I9yXTDx2TvMAobJ8M6FIPI+VVBa+mmwDj9T4+2DUhHwodptrOS3lrK78VtYs+cL+1XcsE7FSmWqmxolD4niw3X9UY5BnIhDkQDYeHBH0zfysvk2UX8i5Yj4t3j/Aul27mgp1POumxLljfcXpi/iQehoP9Ki4NMM3zOa2crLlQp6n+hIiIfp2hUeBpr+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nvj6+IpG3tJK48TBxKzYMSIbCBzEJpwe3x6TdKuWOio=;
 b=ZS4ccWdnGpIju2htmUjQva3RB6kOgi70r3pidwwOLYmZzHM2rvYDQ2gk/UMJeuQ2HVfzuLwg+sTOU7Ym7uPmC0HdaNayepvdhI1pKD1JgHS865iZXwfWJGrDiy9dnsomkIpaqYRlo5xypn0mO8Yr4ymQyeh4KJYghPH9tSu/1G/KN67QA0UXqwF/Yy/74giBbZ4t7a0h7JVpC8OXLLPKgffod3oko1SKeaNEbvmi64Z36tX4BFUlRPCWN6TaEtW+oJC0fuRnudGpvo16s8fcVJ4yMbFHBCOSgY/zIRC4+xH1AdxOA/rtfB53OrcPAFhsjFpMyimuUnLSoBTodFcsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvj6+IpG3tJK48TBxKzYMSIbCBzEJpwe3x6TdKuWOio=;
 b=ii+MSQbwVcTohCopHETDz7wB8HywJfOiEO6lBDuDuDTqwJLlu69SX1Xuy0agfpfOwS1R44GQOrl8LsDaYvWuyfZUatVUPiTCLHbHv2SSmOwZO6TXtF45vh/gP3lHQpSMb9gW+ZdQcqIzJtPZn/M542OWsa0HWfLymgOOEeFOCAfNuJV5e/oDwHxqhTcUz8ydjNVI92TKI/AtRlxfzNttvTqV+GhMz7+SOuHQZoZz5NShyOMAJq7AV2mL0M9BexIulW0Xdbuu66jR4QP5DfptKP6fo/PD+E7UOBBKkiR480ULQQGEO4+xVsQLotutwRd2Va4Ixppe/Ow572wMyHDZ4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 18:56:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 18:56:40 +0000
Date: Mon, 29 Dec 2025 19:56:36 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aVLO5CBNhSL7km2v@gpd4>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
 <aVHF-72-6yRcFZ8x@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVHF-72-6yRcFZ8x@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edc587d-77b2-4ea8-c4d4-08de470c0000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QJpxQepPeylzNb5k6OZjx/Ebe3xu6GuNYPeyoFrPA0F8n1fA/5qH6nQWEv4?=
 =?us-ascii?Q?TQka/7tecZL4YTYG5wRC94AcgZSP340pvDJgKzgRMUzrpj3YGFxk+lBP3BYd?=
 =?us-ascii?Q?6GFIPwrrjvpsLO4uHd3zJQ+49rZ2OT0EsCq5nmVdCRXkR/twmoDzbDySFRFG?=
 =?us-ascii?Q?wQHBuBrThR1PZQcpgmJfE5dSUDkWU9HwtE8bhx6XkLJCoYjEcJfI53h2tlk4?=
 =?us-ascii?Q?ZajIVyNuSrSS7rggLJK6eD1TTa+aTuyy1A1t6PqJf4VaQvQziJE31VjbO5bF?=
 =?us-ascii?Q?fFw8+V6Kyw/36BuJ6b9DUlCrb0oHTuRq6H+9KfMJFE2EwdVNhJFbob4PP2aX?=
 =?us-ascii?Q?2y9E+JleO1CdhJxQsJLuFz0BBYNm0q2E6sJBOPpZ0C/vx76+DcBqP1VKXHWW?=
 =?us-ascii?Q?1LibjRi8tvm2Ug3cuEOdiZ18WBSpHviLQ2CjCvuJeUq3ZeuTsBCE8/zFNiJs?=
 =?us-ascii?Q?I7ZLfz3NkQWPqJxvVbE08LBdFv70BjDWsnVqb+/VujeZ5OsvpOtZzaHWDeO7?=
 =?us-ascii?Q?5+UGh5C5xnFsvyBPQFGtmy7DudGyvB9bPe8sV/cdx98wy2VVidNG4CxDXsbA?=
 =?us-ascii?Q?f8VoLe/EB5v2xyGpnVmOa0v5UZt/MVKQoiEqEIGun7KkGO662u0iTAp2o0ac?=
 =?us-ascii?Q?C/Ss1l4Lhq1YYuLLSK8QT2chKA0mOjOFKUU6RdvjHn0OifLbpA2ej56jasjf?=
 =?us-ascii?Q?wZRAgNY3GLEhStRbxqpJmU6sBguJHR1jOqqbewEZBpStrKq+i7S5/pS+mjN6?=
 =?us-ascii?Q?9P7iFkYOzmiu+fkPRqT00YINYTHed5EDYjQ4vaGth9vZNktqE9ruMNC63HT5?=
 =?us-ascii?Q?17O2rqXIA6csiPADiZlBmSouod8V99AM36kswn/0gZHAedZV2lPNCJ6Gejdz?=
 =?us-ascii?Q?WcEj9PeR6YsPUPoG+J9Cbs2ZPiIb0DLtyGsb9dE1ixlB7l2BlRLLbbf4Vk2H?=
 =?us-ascii?Q?delvgKY4Mcs58vs6znDnO8NZsRbJP9aB1jpMKyHvNX3qwt/07yYumOeqyGJQ?=
 =?us-ascii?Q?ztZRlKUn3Q4hHbYuS2wrMvyayiNRa6j+nxn2zKL84r8Ac5D5432xlvRo9moy?=
 =?us-ascii?Q?ctP9PpX4v5jSkaXiyVnyXcEKkPTV+ke808SgFH8BczJvpTGHoMObkxKBWgeq?=
 =?us-ascii?Q?aCwIdCr9n43UHrKh8W7nxkfsG4tgB5EWzmu0Uo/oSdUTdi/4lMXxN8i6T7dw?=
 =?us-ascii?Q?/SuopwwNof3LRrxrm9t7PNod/Ca1daw/5sYUuCs/N7nMbDlQJ7qNgOLNMtgw?=
 =?us-ascii?Q?O1t7mS+OcibA4OmnL4BPOC9HaWoxRFUej0JzLZHHlRT06vie7jAX5DwOKZ4b?=
 =?us-ascii?Q?o7A1viE05aKg250Yg4OftTMjcuemgwCcM1mYLhBphXgeW9whd1FrSIkS2XvL?=
 =?us-ascii?Q?RHNQ8mJLAO2mAx4HpjJl4XGCWIV1F1acPq7rC2ywRXMNXhim+slj62g3QR22?=
 =?us-ascii?Q?ZEE5NUmcP5390AamZovy3dSQJeqLlxTe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjLaelFY0GBVk/9hcQZ99zEDYoEF91x28RIQEK4K+8Ivwy5nxHaYWrh/CKlR?=
 =?us-ascii?Q?NlQnhwnglcJ7MFGBdcYTEIRBcc0zJv7xefYreeF72U9kbHhJolRj4rowXmdw?=
 =?us-ascii?Q?NHq+CrCilQ8mdN+adzXKHSGCMzQB7meDGrAFVnnewiq3kdwK3DbPqLmorHP6?=
 =?us-ascii?Q?P1xp/d7orjJM/vaoivbUh2u6EVsvZYlx/BYv5RJc3a0uOaar7QPGtUIzrRgR?=
 =?us-ascii?Q?v+wOWJXoWfy8IC8F/e7mOATE6p+k61QZf4ln2NYDRgjvyXeHtlwWxQRyeYQr?=
 =?us-ascii?Q?vgqa87Ev5gP+sAuvmbQJgX5Xd07WPpfkdAQDn7ZFIchWTpmwdBTqGIHNzr01?=
 =?us-ascii?Q?Q3c7ECZr2MpklsaI6Cg7uhN9g5T//zEEdVfKbkaYr9GG3L5x2MV8WrUykImU?=
 =?us-ascii?Q?HZb+3Frn5LRt+XC3nwhp9bmb1aG3FtwEcb8mS6UAV/QtQ8/nnCWFPFbwjmHI?=
 =?us-ascii?Q?h3MhVuf2Y4wiGWNErFbbWaNL0vVwjQx5TbCRupMJbS9j0gtxUqOS6SGDoOzC?=
 =?us-ascii?Q?l8hqE0/m1lynW1JQAEBBjjylXGqKYLJaMzrPEZOVNf4Wr0vZFAVRjuhOuO5q?=
 =?us-ascii?Q?UZNMHdizzLY0TC81D7b9p42wJN9DqyiBMl0S/PwLx8V+JAxkPa6teWigvTGS?=
 =?us-ascii?Q?xpZ06BjI7h5bzDpJ3Fq6F5PjSK1ThG6uzrW5fi7c3Y9hNQnQmelFw5R91Ddg?=
 =?us-ascii?Q?kj0jBgmUDcEP32DOdfaSyD25yPe5QbmZJWmP+zfksk7LNYt+ggmmhsbWRhST?=
 =?us-ascii?Q?lNqKjpx8TJ2DoZp3W+8iAHlA+oLmxbLjRQQeFGSX5LWH6/2I3Ne7Zbh2+vP2?=
 =?us-ascii?Q?Wa1uVqu6Pi630zTQirbPsD4CyhFIkpN8b3S5+OmtvXAUYczBbqLytvCiDR9h?=
 =?us-ascii?Q?tMUdukhfSo+6I9zw+XecWMbJZmeO108fC++liOSdYyb/g11FQQLfUP+83sh6?=
 =?us-ascii?Q?FD+QlgUhsLlfPixr82l2bQVqdsT6DfvOf20zgkUH5DierdgtQ/gwuquTFe/Q?=
 =?us-ascii?Q?xC69xqLnaHiOvTZzyfpaavA3Bj4doRYciIFAhcnpSIui1IkFdH5aKYyfXveh?=
 =?us-ascii?Q?2oGZxyU32tmIqDhmzMk8ktKgYmkPQDi/0tlpFtmSfqKx5LW2M+HHgj6dRYuF?=
 =?us-ascii?Q?M09kZXV8CyY7QVoY+BUl5pYmqwmj3ZvJcxb34R2OPowOlxtq1owlzbQfA2Ld?=
 =?us-ascii?Q?auGN3XKBCY432x9T6btRMpOCY6vI3eZjaqDCuVZw5SMb6CRcjoqHjBtG3i+R?=
 =?us-ascii?Q?HiRi/mP3QuIerwxaGhCNvOeglGvZRktX1NnjmwnHDx4bMov3enBah0JDSJRV?=
 =?us-ascii?Q?ol6FNtCKmijbA3zym29ilLk9bwty2fAsVtIlBwTDsg64oILS5DUowaeJy7uQ?=
 =?us-ascii?Q?2FZ6WfcMNgqujI2FJsZSgaswj2QV/lDGZbko4/g3uWhPq0JhpeYrXnUEb9XD?=
 =?us-ascii?Q?dZZdTXmEEdtnarHlN5jr9yGLmZj6zTBnHNl3IfMWNUulHNtr6EWs9aGkKVaJ?=
 =?us-ascii?Q?YpJvwWqA1VDfJg7mx5YC8U8buva2UmDDuYD/HVcdutRhVyyfnYntU/I3oXGY?=
 =?us-ascii?Q?KqTHd6cfgc6Db5fWkIEovyzELj1DjdtDcQbeAa+vP4tBVo0YmdlsDmA99vQQ?=
 =?us-ascii?Q?etyne/K74LGxgl4Ibh6PLBFoR0bNufBOvMwc/B5Ami18YWkLRUuKHoLeB4Fu?=
 =?us-ascii?Q?4J+leeTpeIO4QbaF0uL68We00o5fwbN1N3aqwpFALCQQA1ryMFJOuZwXSaeQ?=
 =?us-ascii?Q?f+5o+/Kxeg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edc587d-77b2-4ea8-c4d4-08de470c0000
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 18:56:40.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mIw6gh+cw0o6rj1ItYafKjNeLcM/LTXJFRc2gTYKVKz5pd+3NDGrZQBD5nRqNfYeAXqNugvHeLoSXEPtmO3Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626

On Sun, Dec 28, 2025 at 02:06:19PM -1000, Tejun Heo wrote:
> Sorry about the million replies. Pretty squirrel brained right now.
> 
> On Fri, Dec 19, 2025 at 11:43:14PM +0100, Andrea Righi wrote:
> > @@ -1390,6 +1390,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> >  	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
> >  
> > +	/* Mark that ops.enqueue() is being called for this task */
> > +	p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> 
> Is this guaranteed to be cleared after dispatch? ops_dequeue() is called
> from dequeue_task_scx() and set_next_task_scx(). It looks like the call from
> set_next_task_scx() may end up calling ops.dequeue() when the task starts
> running, this seems mostly accidental.
> 
> - The BPF sched probably expects ops.dequeue() call immediately after
>   dispatch rather than on the running transition. e.g. imagine a scenario
>   where a BPF sched dispatches multiple tasks to a local DSQ. Wouldn't the
>   expectation be that ops.dequeue() is called as soon as a task is
>   dispatched into a local DSQ?
> 
> - If this depends on the ops_dequeue() call from set_next_task_scx(), it'd
>   also be using the wrong DEQ flag - SCX_DEQ_CORE_SCHED_EXEC - for regular
>   ops.dequeue() following a dispatch. That call there is that way only
>   because ops_dequeue() didn't do anything when OPSS_NONE.

You're right, the flag should be cleared and ops.dequeue() should be called
immediately when the async dispatch completes and the task is inserted into
the DSQ. I'll add an explicit ops.dequeue() call in the dispatch completion
path.

Thanks,
-Andrea
