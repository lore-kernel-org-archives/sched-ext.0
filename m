Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0574399D5
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500725; cv=fail; b=NQWllDtPoOhm8wDFh8KIrRBIbTpMO7Ld+aYj4uKBGCUymbFE2RUV3ULEgSaPDZ9QZgEXpxJIaJ1xvKtXvCvGw4J810AdZXcEtEy0eMKUWfxaZS7SGim6dIqW6TdjK87picWcPyWbAID7xJNuwnpmvm04VJbXZ16L98KXNZlB1/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500725; c=relaxed/simple;
	bh=VtmN1e+44nMNO/X0au/I3G9BgMMyiZxeBqIM2YC44xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HQ5A9v3psGBYBQwaEhf8y7jUc+/QCK7615Q4Sc42ET4xzm2txVX2ynit4MbqyIb6zL3GJIxmOm2xbooVH60OPlaGVQQodl4xAXHtMxkirC4xmGQ+WyvkF05ZKPHyP4ZjiWq1dkwJfhnCSdkVR/3MlSYYPcKwqemup13fJRrWS0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8MiSpPK; arc=fail smtp.client-ip=52.101.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8MiSpPK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPcsal2wvvoNKL3m4cSu5ZjAAx38E/gD6JJCkXrtgCu37SRZAH5hRLVcY+WVeZApNf0hbnokrhXigndyaQxwyuGGnCwzXxKcONP3XWUOCPeOOWqtVsNkfCJcpJpbJtZJpWd4/jGx87Ld1Cp7Av4u9uizK+mGlc7sZhzeT35A+WjRTIQvZJe6RRIc9VoCvVJKcbhN8tx3T2gqEtdrv4ZHDgHU/2oArl5ixY1W5AJHEGXwN/3KsziPWZ45vanyrXfhcikiNm/czezjlatIV5MGaL+p9JFp2+GuI0r3PiMFYc3leU+EVIYJgv5Akh2HFdduuPMdYDClegWA/l6+KljkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHTuBYCtK0Gpn5vkpyfXsadQt3iUaL1j+Nu43LNfHrU=;
 b=XuWEqy7LlrUbZ0du+7qGlp1UCK6ppN//U+/YxFnAu0dIXAPqKfLw4Jx0RwvWmKQYhGARUcpktVGmi2YISHtPYfTFm2X3w8GYR8soGVAEmHDEmKRKfsKCtf3JqDYpDffY4IOmvJSW/WDnqPSZvQbuk/yzbTVGw8NaRFwWw8FNg2DnzIJP/RHXJpqVDR+a37JXDG5TTv16FsmV6i0p+QYxgs2rNcyCEsZwcU/iQpeJlW3b8tmN81qsWm4ni19nDchV7FkRT6niOT4o14FPu4zDNzK7Lj288tCvdL7NERUKlZ9ArnzXCvHGnlhiVsrAOWM9fyBn04L3/QFY5UMmVqFGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHTuBYCtK0Gpn5vkpyfXsadQt3iUaL1j+Nu43LNfHrU=;
 b=t8MiSpPKGFyiHRGOP386mOZEcb9CEVt8315UqEb4klEmumgTuBlQpdkfAF5VlYC6lH6fXW49p0rN7xHjhH7x4RkLXID0HJlOM/iMJT8BEI7yMfP11PQ6hwvLQ9nGIxioZZoDOHR8yC1R5UjdkGoAx94TMyY0WkVvrcJUApzfq4A+/tNa4bgY9YT/dDFZthLVTVNjiAqXI/Clepa74FDQhs6xS/TYD2OWNcEt0FxgvKHI6tNBQX6F+Qe6gqAyOHHKf5o3BYiaNlwqXZ4TPRQBUfUUsohrlYWsnsatojB/F5PB/j3FihIU5BVdK3heFN1wnEuvP9pW2tbg/qEcUwQsOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPF0D2C72F0D.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 19:31:59 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 19:31:59 +0000
Date: Tue, 15 Sep 2026 21:31:51 +0200
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
Subject: Re: [PATCH 05/18] sched: Pass next class to sched_change_begin()
Message-ID: <aqmdJ7ZjoNJ6vMNJ@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-6-arighi@nvidia.com>
 <20260910101222.GG4120091@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910101222.GG4120091@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPF0D2C72F0D:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c097db3-a672-43ba-72da-08df136002c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Phe+sZC267uffFKL6G+2/dOpq/L1nYHcFX3rWq7FKjiksDfB8zJ56Biy3i84jtC9yaw+G75FtGXWfKlL3vB4Ef3xM4TNgJl3CHimGgM4YHnVzwSNqChP+wj5SUE9Ln0pY0q5dJGfmwpqNU3GsrNIfJHGegFIak0g6V1lFKpJc5gWmZvNP+webppO45D+yhp5vCF/Bk2TZ+nv4zEwKRJFze4AHetymC8xjqbJmgP/Ulg/wPtltyXU9xzm/j77OpV9ELr45oZuwh5yRkm43JWZ6Q8MlEmplQjuYX5S6uPbCZPDglEu5hqLO2IAImb0mnFkmnoc8dmb6j1xFSB637wGiNIywb2m5tyEjjNLDY76Ohh6GVC9941IG/kF79wNNc5kZf/q+ocBJo7bID5jS4cRSy/eazybmJ1ZF3FhojF6obS3AK/Y5fBHwqP5K/QRmzaDYIjvAMQgJDDbZRS6tWilficxHL7ZXrIeCOjx4jq7nPzOMv8EeqjXLDs28Akrhc3anq5kO1ksmb1syviv+/d0eGOwsOeRZchkGZHfDCOaYc8jLkCDGBFPCgG3vwM2hvw02tH7j3MMo9Jf4GZSUwzgVuLuW4HgbC6ppw2EduHkk8xYaKT6XI02nsAxZfkwQJpb6JV7PJR3T+ycICqsa3BLFpfwa+ACiuROpPRwP57suUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0+HLTlzoCw9dUtcl+8KHQsXM2P1DvL4idmM9IrbOrn3y0kucKnT3lPua7XYq?=
 =?us-ascii?Q?SSnzD8oKtNepCCbQWbkxMzCjFm58USrap208HwUThH3cmKdNbuaZg30R1CRf?=
 =?us-ascii?Q?ddoZxJDvRI7QwX4svlfLhR8nAZ0Qy3mlmi+1G/cNvKmQhHKKIy3HCyma1d15?=
 =?us-ascii?Q?/MohSduDIPBAfH7n9Dyp3Lv9667xIflw1S3ORK5MjcztbeMn2lgk7IRZxC3h?=
 =?us-ascii?Q?yjcLowDCC6mM8MH/rqIsyKuFWgU/tNixTu26jbQyTbn6ifJxnFZVUsNfyFmO?=
 =?us-ascii?Q?hJ+WNj2/16eVPf0hMp7bYIo7uee9sKMwyeQkG+EQ0d5EeajIq8hl3Sk4ouI3?=
 =?us-ascii?Q?Y7eCbx6ymDQa2YsSYU/PkJGs7Nqh6HBGWsKuQ+Wnf/R4bBWNp9nklb+yQpco?=
 =?us-ascii?Q?qcEnOM9yeTelR97Sk1SpSzKsbjiOQCCtXqsBnI39XlpyJ6tbg4nvTS9xrhoM?=
 =?us-ascii?Q?n05ivrljRl1ErV2wiTI1qMfsSKRFONQ5kagB+XMMFnrbJzAIlE5p8cqzuXRN?=
 =?us-ascii?Q?XlJAaXMR1V2LX6JLvsIBDwkN5izJuxFjFAvf37Z15pvsKeIfwkzq/vr2NT4c?=
 =?us-ascii?Q?UsL86cIAvQc0btFMBdff0QGFCO6ppuyMbpMj3HUXsJBzaaZdT7TJVWToZJb9?=
 =?us-ascii?Q?WOHD7Y1gkN3t2dHp8Qbeq7iOabE93IZiA+nPW6EwzIj8nEqQ45VZDsAzHREU?=
 =?us-ascii?Q?MGxrKHdrDRim/M811fp+Sr43Uobq8bwTkzMDUN1DCNLU0NXaUhG3pb6r6T6/?=
 =?us-ascii?Q?ObE7wvVelwXlhNBZkRNbH8V9sk4PAdEIHVFcjiDt16DeTGCjsYdS8IDWdlwu?=
 =?us-ascii?Q?Z+Y8XYzvFj/YTR8wrTFhwxoHf3oZrkNa77pG8pBcdySUt01qXSgomuObKBiz?=
 =?us-ascii?Q?lvtM5rCIcEy8XWC08ODNvJ4mU+F0YlPVgxilq3mUJXpM+XRDGxOKSlFDCVs7?=
 =?us-ascii?Q?j8TLysDDepSEhyXIhkjYmnl7kVCKx0rtn+HtjUqhs6hoc8sVTVVJrgVMolB/?=
 =?us-ascii?Q?R+tfbmK7Yg+rzGOHkTO+VHoLrDtwI1fciP+c/i6c+puitX3F/Iu9JAy5DXIG?=
 =?us-ascii?Q?5xqoxjxiNcycHXGNN9MDIPOaBr1M6il2XgVsZG2kmcqp3NVP9iCYB4DGUHnC?=
 =?us-ascii?Q?gQAmlpXqQcVeNfsSIDTeruRtMeI7y1lV7bFKoG3DNsqjyP+IVCmbs4UGzPEp?=
 =?us-ascii?Q?LYB3u8UaGrW+fG6TsEd1wpxYHXt6kPdy2xZOqt+j/t672lJBVdhXlfS2+piU?=
 =?us-ascii?Q?MmU2Gd4LIQc36S3qVAYS/CHOBLIcY8oXsGOw3kJ+/h04PNT3hgRylfUXYd6i?=
 =?us-ascii?Q?lH4qEFeOVp3biGXs7gz73B+i27dFAraxRwguDwKYV7U2TcItuIym3nJ8JlWe?=
 =?us-ascii?Q?fLN68KOc5AgG+14C1VOvA9ym7qO6LCkwUdwMwBdRBNWTPmsjF+cpwV86hsXb?=
 =?us-ascii?Q?wtklfQKBgvuH4GLP9vOhgE/fgxuwZ5ZXwTn5YaFPkKJpPavluZlKyLA9llnk?=
 =?us-ascii?Q?za48H0EjEbINlN81IrE9dyImbZ+j5dSUDxEBLCw2D5KjmgRgKkJJDDWuU4Nk?=
 =?us-ascii?Q?8C5jFBlSzZTrKkyPhKllwkZGku7kQMkVP1WpwyjEJ8WDTb87YOfg8Ma2yeak?=
 =?us-ascii?Q?kBKT+TIJXf0GHYDk82IzI5CWZtjf6ChnoveeR7YFzRybTPZa+dhjlsuNs8mJ?=
 =?us-ascii?Q?femTN07DXppzJRwR+j65Vg14tHnEoe8Xe9C1H1MaMe2m8ob3T0QMTJ+MpO2+?=
 =?us-ascii?Q?3oL6/eJIGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c097db3-a672-43ba-72da-08df136002c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 19:31:59.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5Ds1VRdO8FdXb3pAIlkkBQdLbOz4tCV/6bj+z/FORnYLUd9fh0FeJXyYCgXxv5Vos0ouGB+9p/kzhUBls9OUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D2C72F0D

On Thu, Sep 10, 2026 at 12:12:22PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 31, 2026 at 03:42:15PM +0200, Andrea Righi wrote:
> > sched_change_begin() currently only receives the task whose scheduling
> > state is being changed. It cannot distinguish a class transition from a
> > same-class update before recording the task queueing state.
> 
> Uh, yes it can. That's what {EN,DE}QUEUE_CLASS are for, no?

Right, I overlooked DEQUEUE_CLASS. I'll drop this patch and make the later
proxy-donor handling conditional on DEQUEUE_CLASS directly.

Thanks,
-Andrea
