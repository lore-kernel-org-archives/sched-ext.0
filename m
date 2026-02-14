Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA51E5B63
	for <sched-ext@lists.linux.dev>; Sat, 14 Feb 2026 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771064205; cv=fail; b=fVyoF/5aqW1G2Cyr2KoOgTUnBAJx77pQxTjnuXOkWYZJlIA1yCv7xWAcU+OglvzM9sY5qjhKFzFkqz8v81N7i7IQThJzpfL+N2qSOVWYujL2CtaTB1HoJg8tEtwP74DQv1v4Hn7sjU0Hs37G9aanJU39jOqM/xawwpJ2sywk3Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771064205; c=relaxed/simple;
	bh=wFsOEgzgcxbVzdxJ8rlgQyhHGlZSj9MPHjO6sVPlegY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rJPb0ZTiEnLlTHBTviLbHAxjVi/khUQDTNxVyF/EXO7d8TPrnW/+CZ7GmrsYLxW7mOhlaRHnvaUB6HEoqxMDcuoT7HPMsmKly0mlsBUal+0BEjUmcrPd4LCVmfXH/18m5UhQCAVlMVlDjWi/FIqJzcj1bRqrtuNsNNM141vj/+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HCLokhy0; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HCLokhy0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZw7Xf3LEOX6mYFiABb381zrQ0qwIF8Zt9ylkceZfAqARBlea8sgjhwneH/snA5s+h93FiYEVjXBlY5+DHI2fPXRN82x86yUJXOVyV+ACXqg/U5fIQxZ3kt4jjf8bfLBBfvFfcMhOOh5bi4EkBGw7acR8mv87OIbbGZhBIGmNOROrldYRAUqD94G+QcDeRu9r0OUzHai38hjmt5p65ncEaDlx89hsr0MCRcU6FCYt+ERQPAWPF07ijWw4+s8W7LitLXIeiuaxHj19IDkfucoOv+6dD0IUMgobUL/38Rs4tE47ai3F3KNnKTDJNEJCcTNfCJE8Q5w5aK8HKQ3kSONXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS4WoWDWRzsIHQHaD+QR2QE/EiWRKhFNAxmiCosYZ9o=;
 b=DafA8mlhI5+7VEqDlNAkIVarjcir0NC74B7SR/CfJaXvljBVPJe+7dfjgWMHJLLHV+bQtUxNprqMaxXA01G8psD5bwnjsdZve8ORcQQvkWDurjgZD4YQX7ljc7jfCjZUYXGd2e1Aq5g5sKz2CDX7i/hSNxyje6ycBdurti1aaFfj29mEFB+C9C8sZtk+Gt6Qe++EDneYbzozRXjx8hA5fBLTu4E7KpCz+f6b80/qn6Pc8VRjYa9lt6l0iTNgshiYxPnE+wwoHIyi4gIYCBU9l41B98bwAk9QYUbO4Sz1hxZ/2o4EMaEVxwPGOHYGQJ9WdBuOgysNmdFQ0k/QP8Vd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS4WoWDWRzsIHQHaD+QR2QE/EiWRKhFNAxmiCosYZ9o=;
 b=HCLokhy0ti8I4J6nAsp1LoCzYx2l77gybPdTYXBPE/C7gko7y6VvyF+5PleTeueOu4hezTXCmN1lcltB8Rw+wWJLwGRrRkU9/9sEG8o3Oojmk21oWaNmGaoDZ2s5euOMTcihuzgtfT+WPwNMFR3kw7m6fJmOm5WeowWipsuMtEOgVzMsm9lWBcrwjaBiaR/bAf+iB3xPSWvrlgmL1hsA5yllDR/jAWWPCRfyhlLgRg6IKpvh9I2DWwQJ2ldGKAWbfmFNYAc7nP+7b2m/jsPlXcIKor9Bf3DAWbt/1o/Kg0fm0eIwP+LjbHp6eskwVEuhGaepDIpidEpMrv6imt6uRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sat, 14 Feb
 2026 10:16:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 10:16:38 +0000
Date: Sat, 14 Feb 2026 11:16:34 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aZBLgiGv6U8xiZlA@gpd4>
References: <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
 <aY0EDpFD1FSrigB6@gpd4>
 <aY0EmUnmo4gGitcW@slm.duckdns.org>
 <aY2ofYcZpni9L0px@gpd4>
 <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
 <aY31pzTFyZ-nKK1J@gpd4>
 <aY4IuX59PsmSsi1g@slm.duckdns.org>
 <aY4YdW79Y3FBM5jo@gpd4>
 <aY4di9M4BUfutfrw@slm.duckdns.org>
 <aY5Ua_mFijPmRJSi@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY5Ua_mFijPmRJSi@gpd4>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 0380b76d-86f5-4a79-301e-08de6bb2230b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XWMxgaIvZDTtvpKxtq+qVh4/GGjPBjWDEsxKTdJ/vtbNPYlklqj48sFGMeLL?=
 =?us-ascii?Q?Nk5go4dFlWSYRj5SAoHymEcddI8by07NjzTl+zpDvbc9/fsuKNeMj7jJnpzV?=
 =?us-ascii?Q?oYUxcsRVmjvNdxj8U9vxSOuaLZFgCRkv+g0al4i9G/FqYQEQYzzfeF6NfJ2u?=
 =?us-ascii?Q?qrSsIxb6A657YzkWa7YrYlPBSSZYzAEYvm6RVl3RiEmYhbo+Jq3VwS9OVi7j?=
 =?us-ascii?Q?kAcgw2hhMF7WepX29JsIPjgn78cV/1ZDYiPYlKmDLgmhXqnUcmJr2/d9DvPa?=
 =?us-ascii?Q?HHNiv23IvRdt1oiMZnyV4JM8lvzsxOW5IJONG1xsX3e8XrAiMgLufY6sL+T2?=
 =?us-ascii?Q?uw03nxrh480fb56npoVSd4V6opD7yjRwmS18tIOaqs7ox6nOGo+CYzlrlNQW?=
 =?us-ascii?Q?ZApzHbs9OZJkWUB4GQM9qGVDjYnKkctKziDj8di+xxl/RX4PU4BYBDa/79lm?=
 =?us-ascii?Q?7fz0Gr/SDV9ckDBJ7to+3XNImpYuBS5Rbrim2YgUHyazikdTTlpge55dzpoq?=
 =?us-ascii?Q?XFHIL7pbqmQe26MpEkPU9uMm1qP73J8lMLWQIvWEOD0v6wvWGB/yIstQm4Wq?=
 =?us-ascii?Q?bYi6g5i/8TM1y7n89qa/L5OqCRYpOqpKsSWvWN/yWvYKdi1Vfqppl/YtDS2v?=
 =?us-ascii?Q?N84qoIdhw0uZxsNiVGaTg/KoYv7UyPSTHg4ewKLXz0sTqoRCptYgi79XOEdN?=
 =?us-ascii?Q?VXNU807HYW7IHCGWwCWCxwJLtNllJX02CfiBfI1f3ribN6tM2zP0Aeu72Ql5?=
 =?us-ascii?Q?A1iY5MJKreKBIaxWgu3Bl9KMlD+7/Z1tKPqUef2YAMGT9XdEhf52BkT313z1?=
 =?us-ascii?Q?9z+CvstZYRiRctlNysoKDejAtgv4UoeGfE+F09h8M8YsPvHCDMyyrWMblvP3?=
 =?us-ascii?Q?yxUcq64kgpUYLRx0TcnqACx9B3NOL+aQ7rPInqVGiGrSCddJuD6bb7JDBZgG?=
 =?us-ascii?Q?+KeUlK7oe3Tnxg45mXF2ztNGrVX4t7YbgbMm2uKoo+2XCpGdrI0rGXGefJJ4?=
 =?us-ascii?Q?4j8QFFdZeQgr7TQpELTGA0pa9t7uK+//fPBD5bCffeu59deNaMN567widnk2?=
 =?us-ascii?Q?cBCyr1BodKgrp9IzjoB/gi0anCtRbkLyQuEQsBcleuFrPOJrydwTUqssZ+Xj?=
 =?us-ascii?Q?CRO7E/mZLGVsFjJU0UqoT1SfCfZ8q2MttiKIV59/sivzeptLuUF6NowMHz+z?=
 =?us-ascii?Q?NOeC0P7a4tAI5maqAkNchfpdVm+Q62ajnabdpNZyvQD2eZlUscD2eP33npbU?=
 =?us-ascii?Q?OUa6nTPGK+ZLb3MJrdSaUWidUWv/KL4ymKn8sqCmDDwn2bNRUhBSwZwOVCXr?=
 =?us-ascii?Q?E8tp4RijfVnMrcmz9jOnpGVdTF5kGZywJWLISDOOqLId6PZu6g0xkmQN0v8e?=
 =?us-ascii?Q?1kIOSoEtuEuFOOA2RCWskuBRUw3UfVFR/z4x1p0uF6GSLRmfpdVRVsjmNSrx?=
 =?us-ascii?Q?LfG0kswj+Mdi1r16LxrbOzc1+h6k46kfiHhlndeYWcugb+mEibfRKUEBpSSG?=
 =?us-ascii?Q?RBUBPPKZyAfUbWlt9gPoHGHzF2unoL4DaJLYYdLwqP3PWuiuaYQGFiDgb2GG?=
 =?us-ascii?Q?y05vju78T8R58tKFvb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZO603t3sXHZ3d9yOhf9SmrTgoWVvbrgg2mv4Rp4Xl88gW8lJ19OGAplep5YY?=
 =?us-ascii?Q?GYs1HvEt9xkQtm2XXI9gqwHlrlRbnwq57lVAQ8UznYPiKgLLM3kX/7BsRIT7?=
 =?us-ascii?Q?KVq03PyPRAfFO64KDaWhv5Ic/uQD7wcsRtn4Lhd+H6nyM7TOP6Ge+vZrhhqK?=
 =?us-ascii?Q?sByPGZYNQ8j5IX42GjQHsH3hmN6EDxQLB6lVPfXsKQIHf2UIclDJyqXcyo3k?=
 =?us-ascii?Q?J+ikca9rzHZlFcmlrADlySgN426tPrwjAyfd86ENYFOEZycRaNoUURn10ZJa?=
 =?us-ascii?Q?Su4oMc1sfzWXLeEQJHyJ0kOnYMwo8N2HLCGZrRsh4qUzM/h6RL6hwOJAVN9i?=
 =?us-ascii?Q?zMQSy+5J3moY3GXIRTcqujsvj6CTzCDYyoQo78uV9m0V67UMqorYqdYgSXth?=
 =?us-ascii?Q?Hkm758L1JDUnOBpmrgfKNhhGfAacMu5HAcR6lm5xjo7CSyQ2Y3/AB25Y/jHj?=
 =?us-ascii?Q?DonhW08G9at3unEFEc6srcoHa4LOhIkytlnWFMU1zN29EYn7Wg2nWO3sqZke?=
 =?us-ascii?Q?PmtG8SKJxqhLz3WSoNviK1MEiwSyankjlSvs1LoXx/zHGqgKEpkrNlmHI62Z?=
 =?us-ascii?Q?Uqp6hi4Lcq9NPBlYSbS9q4P1CgAsap5lBGIVGfVnp5hG733wOSNycZoocZHi?=
 =?us-ascii?Q?TvcCwbdEQ7H/I35YyrHForHj/0OlAWNF+o9qLEERcVssZb7SbLJzMj8o1LYf?=
 =?us-ascii?Q?DGZjsyskopWTbxu96qNcsGuwp7fAiJL+JzcLc01qDi0FQXpzv/DVHMfPgJ/V?=
 =?us-ascii?Q?KUvFFGKof5PbuWDs1nlYqtPzNo/SJjCC42A0Zkfty2r/g0KSVSG8kb5oGbMO?=
 =?us-ascii?Q?8Fqm8Avd1NbbwI6oGi25v13VitXnO+1hbidXDfkt1qnGPamlc/RGtPpE1MR3?=
 =?us-ascii?Q?xJpnqeKSeBDnl2hrbWJJUI/OjDGqciuKdrAcKJ92z4BVUyaqw0NwuLfvXRbx?=
 =?us-ascii?Q?q09TtsmADiHW9mTvOvM/09nO/qSI/A2goHyxl8LkBzRIMY56PeYLEhjbrhbY?=
 =?us-ascii?Q?3D7v4zHd0w2Fo7hIdBFPxCSBiQDnf9RHGwVppWPH5tvfMT2pmjT7Q6aPEonr?=
 =?us-ascii?Q?AJlebD2pMPfhQyf/zjgHby2p5c2AUF9xV3LlxxHudzd4ScGxj7iomFy1TfXH?=
 =?us-ascii?Q?VDZsG8lH8BsJHBFU/vu2qeIJ2U+qbWN23Ll9vZ0dHLB79ljSduPQaCbco3g1?=
 =?us-ascii?Q?p78G0jxgZiHegsjDjQTi4ECPJQPEop2LuRjryDFxz3tHrLf+O7QMdxml/xxO?=
 =?us-ascii?Q?BkWDuQM5n55wWXZeGBP0Tlh8rigwiB49tgIbiK04sw8d9gQgNp4cwvgVhrmx?=
 =?us-ascii?Q?lAcJyvtXBnJLAhKZgMfz1iqXPmN7EKZ9B8dSQAQkNGkl7Dj3kAXYYT4tPEe0?=
 =?us-ascii?Q?QTsypJYniTIDjfnHnoLRZ6wH5PEW3T0HVKFwrYGxoIe/AeQUcQCTOpJmQwHE?=
 =?us-ascii?Q?5NCQMFOBIAePKNdRV+opa3dRuyui1ykUfBeMGeRJAQU49JOdyN89hLo7PJCW?=
 =?us-ascii?Q?mXWl/xnSotdhQHq1H5YsM1nUPybf3cDRGZ3C8mtBjUETRgF9JBcJOYRlGcb/?=
 =?us-ascii?Q?e7dk6eFAHM1SJg+NGE1NMpnUXxE+8/0EKY9K/gifYu8WbE2jfwFzVFMMFe+4?=
 =?us-ascii?Q?Pt1Pjy1WT1EHaQMYzCx7nflHJpFUFV3UowJ0Pji98gCHqSEi7Pj5JI6x9COy?=
 =?us-ascii?Q?qJQPKXvdFuqPqf9/KTlOJ90BlBt35OSeBpRRgvlrCfqxiN1s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0380b76d-86f5-4a79-301e-08de6bb2230b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 10:16:38.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fzLd9gT3TjNIKft4pAcln+CexCb6geb/gl9LXXEizzHcfWup+Wgw9ze1EiAuqbWHlsrPMnDDR677fYVUwmiRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958

On Thu, Feb 12, 2026 at 11:30:14PM +0100, Andrea Righi wrote:
> On Thu, Feb 12, 2026 at 08:35:55AM -1000, Tejun Heo wrote:
> > Hello, Andrea.
> > 
> > On Thu, Feb 12, 2026 at 07:14:13PM +0100, Andrea Righi wrote:
> > ...
> > > In ops.enqueue() the BPF scheduler doesn't necessarily pick a target CPU:
> > > it can put the task on an arbitrary DSQ or even in some internal BPF data
> > > structures. The task is still associated with a runqueue, but only to
> > > satisfy a kernel requirement, for sched_ext that association isn't
> > > meaningful, because the task isn't really "on" that CPU (in fact in
> > > ops.dispatch() can do the "last minute" migration).
> > 
> > Yes.
> > 
> > > Therefore, keeping accurate per-CPU information from the kernel's
> > > perspective doesn't buy us much, given that the BPF scheduler can keep
> > > tasks in its own queues or structures.
> > > 
> > > Accurate PELT is still doable: the BPF scheduler can track where it puts
> > > each task in its own state, updates runnable load when it places the task
> > > in a DSQ / data structure and when the task leaves (dequeue). And it can
> > > use ops.running() / ops.stopping() for utilization.
> > 
> > And the BPF sched might choose to do load aggregation at a differnt level
> > too - e.g. maybe per-CPU load metric doesn't make sense given the machine
> > and scheduler and only per-LLC level aggregation would be meaningful, which
> > would be true for multiple of the current SCX schedulers given the per-LLC
> > DSQ usage.
> > 
> > > And with a proper ops.dequeue() semantics, PELT can be driven by the BPF
> > > scheduler's own placement and the scx callbacks, not by the specific rq a
> > > task is on.
> > > 
> > > If all of the above makes sense for everyone, I agree that we don't need to
> > > notify all the internal migrations.
> > 
> > Yeah, I think we're on the same page. BTW, I wonder whether we could use
> > p->scx.sticky_cpu to detect internal migrations. It's only used for internal
> > migrations, so maybe it can be used for detection.
> 
> Perfect. And yes, I think if we set p->scx.sticky_cpu before
> deactivate_task() in move_remote_task_to_local_dsq(), then in ops_dequeue()
> we should be able to catch the internal migrations checking
> task_on_rq_migrating(p) && p->scx.sticky_cpu >= 0.
> 
> I'll run some tests with that.

I ran more tests and I don't think we can simply rely on p->scx.sticky_cpu.

In particular, I don't see how to handle this scenario using only
p->scx.sticky_cpu: a task starts an internal migration, a sched_change
occurs, and ops.dequeue() gets skipped because p->scx.sticky_cpu >= 0.

So I'm back to the idea of introducing an SCX_TASK_MIGRATING_INTERNAL
flag...

-Andrea
