Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898661A267
	for <sched-ext@lists.linux.dev>; Thu, 12 Feb 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770911164; cv=fail; b=YX53WSnntWHhUmDhmKd7lxECPJujaCJtjAbPZjKeEGo3pbC+rhfSsGSATB0cNtlJkSl2jeJxeeUK3VqLutj74TDq0wfqJFHqgvd09Kjijrja105/L0CejlDS84ywYOT2AVjmuEy2TjFlbCDJ+seIEMxRCPduxrtxOz0taKP1n1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770911164; c=relaxed/simple;
	bh=6K90AIHgFbKSjAolhJ/F/qYMq2TuJZuLHqHGQ8wJcdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GVGK26RxhAT0c1NEfw5h+obCjKRUFE6Tb5ZfdlFqQv0NIGY/560pdHPy7KmDjVBzQI1hJwphWIW+l7/7wpyje69WUnFAWrbokZEqiZM5gH2PnGeeM2XVkGJbfxBdHN0/dCbl0wKSjdpcLqujbOklkammtvZEiaIxmkXTUfpR6mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bsECT9Q3; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bsECT9Q3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhPz8AHESPTQaGIy4z+NwxsqgkCAJY6nESx7Vk3g+pdOn2D4tYUCM05Ph9qRSOGC3Ni9w4Z39XhyQGyl5SfzV068OBF71PL+NB2X82r/mhcPv9ijVL2SoLE8TxDW9nleHM6IiHZxjuzo2kRVFqGFjNJCQHoPfs5o+9oZmN8eeaLHMYPzY3kgpWVOjXg5rsDtGo0fENxoOQYpu1zvdMNvvvB21azNpZ40S2iALXmqRg9fVIGnOPxzEc/5ZDpDW2HDtNZ8fF89YUtDywp7e9ZSF+WvRyGEEqyJO3JaMSESreJzF8R9lC3Otvj2l2SghNRzbLriWWQgZeLEkuimxRXdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBnWuq0o9lys6YvGpEiLQaNB7JXNxOSRsE+DEbkDMsI=;
 b=X8TOA64IOUPvJCUaUgQbVwZEnIwz5BmYa0gPdaODJS61+u3Pf/p0JyHfzkBAkIriQ7sK7CfHj0oM4V47YqGRUWy1ef3gBvEhbugLYVLwvLl6jPmZUicbm0e532MgOhyCrHFCggu9OIuTsSquqZ72+3Li7OydRxFB0buDfOA3YAJ6PJhKPfHtso3PiXHCBTr4BWaea890DsRu692GyufPIqQjNg06uE/fu5niqakzNikaKrJiu5MTL5ghNy3lnL0P78WMjRRcotUZTKMd/kyvEk4l2vBpW1YbP0zR1DLm3PkpMCCEnTGF9RSwkmxDVK/af0i42crTr5tnrbOcfWR3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBnWuq0o9lys6YvGpEiLQaNB7JXNxOSRsE+DEbkDMsI=;
 b=bsECT9Q3sexvadWTFn7Ej49XT9ZtGbxVJ5ytSlVWRfbQxeW1aZmOM8/YJJ7JeAIXBmAY9RWxtd17hxRYazuK2ijJsSWweSQAC69ZDhMgKWmD0EWkG/bvJxoYFTZBE0BLSjoCgyYyHtQ7LDuCxOrIlzKj1+Ft/rFHBU4SGzrBXA340wzwMTbWXhEeRcDilxtyWodVZuTtIS9mCVdC0uZGeX+4w9LgUoycO1nKhuL9vLgC4Hayy70QV3eL6gOvK4MEdp8wzfvJwzEY+1LWRZbXR7oAPel16dlGARu1UCEFGONZ/1SAl/C+rpZbvQsiyv+oFrapJrDQ1UAxBMEg2Bxiyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Thu, 12 Feb
 2026 15:45:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 15:45:56 +0000
Date: Thu, 12 Feb 2026 16:45:43 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aY31pzTFyZ-nKK1J@gpd4>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
 <aYu9KzKTMfNIFDwD@slm.duckdns.org>
 <aYyo_ALV_BT6WaE0@gpd4>
 <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
 <aY0EDpFD1FSrigB6@gpd4>
 <aY0EmUnmo4gGitcW@slm.duckdns.org>
 <aY2ofYcZpni9L0px@gpd4>
 <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
X-ClientProxiedBy: ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 4428fc6d-1b63-4024-d54a-08de6a4dcf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VXx1Iw4dH0VRis+Z+3XS9Pci6tVQNz7F9f058b+0muRM/g/HkbtvbImlTbbK?=
 =?us-ascii?Q?0tq/4j1PU5z28khvxXFzyoYpNdQTdW87WR3JTkZKND1RWhwTo0ijX0hdWMrW?=
 =?us-ascii?Q?sqtkuO3xLYOHVYrGnAQxKa0j5Umqdjh+rdRbHosE1LTmatpvb5xRYfgXA/n5?=
 =?us-ascii?Q?CJxeh6kIWgXfciGQHXToR8zlHRZFxWRkCNQgSvATawZqmD3O1ygkX+cEJ6XA?=
 =?us-ascii?Q?VJfEfOJx4wG2GLOkiypTcXCaRasFteHzGK80xa2W73OoSRtNMa2ExU+9PR0R?=
 =?us-ascii?Q?/GHjwTCwS75m0iJKWtWxzNWC6ad8sWUZEXMXvMu4yoSDFqlj8t+ttu7zaKwo?=
 =?us-ascii?Q?J9BKDHmWN41J/49Jam9889qNKvTHksgmNqn9Pc5T/+XUyktRqFj88iTa4Ip5?=
 =?us-ascii?Q?CqsMAn+FC6uqnH+iYzQBZOHJBXayogZEMwxtjDgI9DvF0t0TMBqJZBeZK4JU?=
 =?us-ascii?Q?eRkntNF6qivDfisfI1lb7Akm1zzZkSgRugpNtzB6AadOEmqSXMDwN9mFYYkq?=
 =?us-ascii?Q?wexTy/9kT2+xeqDobB8DzecNR79LwxgRDldmIXhtOFYjr+A22aw0THB40vCR?=
 =?us-ascii?Q?098DZCYt+8ArxgWPXtJlyu9ftS4781Q7JwQRzPhcy9JEQkwySQBiJcYQ1m9H?=
 =?us-ascii?Q?P0dnTfzpcPCk+Lr512SJsW3j3rpFcDZeeE5q0noUupa9M37w0j0Zy+zOHfhW?=
 =?us-ascii?Q?nqvic7JpmUswDMikVKpnPiiRuW+T5fqRavhIS5vfz/o/XzpcBRpuX9ecnJMX?=
 =?us-ascii?Q?JAC+GewBpQI18W5/1+m216jKimYoDv3JnmWh5Vmu6QiBFgvxR6Gid3/h0r76?=
 =?us-ascii?Q?Qzcp2s9SwS4hLlOrkoT8wqtEOEmwPU4sO4hRJGGfPpi+vpEMs4nLx8kkgsRI?=
 =?us-ascii?Q?rcg8s6k3ojZDWZJBeUiXLl6QU049ZmDHgcT6E25LhNgwdJjtx3OidX+xirCC?=
 =?us-ascii?Q?1sEI6VQ1wrnKhveNQl7xKl7r1jB7TrUs4xR2f6s1kQRYETpYqpxoaTbQIXD/?=
 =?us-ascii?Q?YKcuBschq2VFyMXGQj9TeyBvBLx2eHVSY+T8255Fc+yAWXV+3cP4wUgVOz/c?=
 =?us-ascii?Q?PESNeBeh1Dwr4R3ZFqtt8o5HMVQPWHYLnvyffru3pM40gTT9fPaGuEAtym77?=
 =?us-ascii?Q?b1OFi0GTB8O6VSQngPMA9ed3sg0Tj4vwiPaliWb6vJqBmj52pBqNX1CgQ6RM?=
 =?us-ascii?Q?cv8rk5WlGUYwU67V/SWlqVANWAjx2+j74O0kZls03v5IxpKC4nY0+9djFAHT?=
 =?us-ascii?Q?AJ7qHsOk4xkNb2oAX92jfZEr4eYZ81tUJR+l6GtjKxnSrpIegq51mAzaBoGV?=
 =?us-ascii?Q?7Z+V2ItokHCNRusIA88olwUOPGE15mW4sGJpFwXIhtstRjYjIl3RaxKbDLQU?=
 =?us-ascii?Q?pHYJ/MHtpfF/d/p6zmzuGqaeYhLjbNQA1RFQxEDLnQbcBYouWZ4lCdWn5HkR?=
 =?us-ascii?Q?cKOfvRwaiiTF8dBT4vWjxSRJjaBBkxK1lK1eiXNcHTBcdULMb+PtneiQOjIp?=
 =?us-ascii?Q?r8A49PPWFRVDxZadHZdyoLfAwtmQc8MgDvQuQmOD/4oRuav3ArkGeTPS4wij?=
 =?us-ascii?Q?i6uDpIKwowRt6B7+qEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZoEPHJqKds+yR43JIZ6A9NjnIRvhTADCNBxtF0SoMVZHPBJ18Tff/ehMb6D?=
 =?us-ascii?Q?kNBFL6LokiNqY+WL+b20UwLi/xAFMOUNsAIusPVxym110qj66SOYpcswp2uH?=
 =?us-ascii?Q?tZ9lyWOlz3v6t/tjZtSTASjsU6S6WfBFH64BEAv7n2uEFCzhQ3LZNA7YmTef?=
 =?us-ascii?Q?H06fWCgPA38pkbpwkr4dCDOJfMJYWdol62cVC+K3RDje9bkn8M+4MpdV6iXJ?=
 =?us-ascii?Q?weB+brRWrOGd1qlOM+ybJNB9Pq1WKAoWYGLbqS41F9I16g4QZp3W7q67FDzw?=
 =?us-ascii?Q?wNmlBm2PKFGLr8e37IAv2DzbpmUDjeoPqNX+b91azk0soVWlhNPQFig6azI8?=
 =?us-ascii?Q?sEz8d7EnP0Cd9YYa/xApeMWUc+HdQ5+t/sM2R2c0Kmxd5uHjFn2eu7W1IrPR?=
 =?us-ascii?Q?4QZcwyB1gyBRfi+Yk8/RxZgsDnoUPOWE51PLsCMhgSD8sp3gyJ1M+RZXCYan?=
 =?us-ascii?Q?IAWRGWrg9tNf5bxQ7rO27cEFFVzvYio42nGOWxqF3lcf43JNldTWB4Ft6Ygs?=
 =?us-ascii?Q?1LInZaV4xCwuvCnF7NluJ57D/pXx7371Ie1E6GprbQ/SP4fur/49MMuwlbXC?=
 =?us-ascii?Q?R6dcKom1iozsJIED0Es73yh3Bag9WN7kWEfyrqfhAzrm8zSZaqxRKztuQJAU?=
 =?us-ascii?Q?BbNmOc5OiavYiY2kKT4jxDX1yu2raX5Tu+/rFW1sikgnpOk3PNF0giGI+X4v?=
 =?us-ascii?Q?i5ywB/A6n9bkyiYxsMh6TGfrbpyU3Ovc00J8JlVn67Enkb0+mfZnFV3fg/l9?=
 =?us-ascii?Q?u1ynRhxxPUJST6IVMEIi7PvbKbWMPD6WI+uYPLQDg4suqN/7qKbZ+kE6ruX6?=
 =?us-ascii?Q?Ck+vk6QAI159861hZzsqAubUrNOmO7/XiUnTJYWOQLQhIrPallfs8dCT4sdp?=
 =?us-ascii?Q?qwaZvFpLh1WpA3BNyxQ1cOrp51OB8acmZqLfODsGt5aj0seYtpnVcOQkIekz?=
 =?us-ascii?Q?OQyfr7aYQMNAn2gN19osAmFEWqotIfcff08A0CautM5W67xti17VT2iPvm+9?=
 =?us-ascii?Q?I6HvqQVgtFtwiGyK5NEeqxcIWqSyENu5MshfDTdg+h+Ok7mr4XMnI49TwQzf?=
 =?us-ascii?Q?Ac1/Ch3/oocIbejYHlxB6+Ksu1ZjzT0hh7fb99YOfrsvGyiT1L1KDoJkRwoR?=
 =?us-ascii?Q?2QfbN1FO7W5UVl9ULkH+j4lii0Zi8UPXE47UKImZOQbvaRIMS6iF4g58zjnf?=
 =?us-ascii?Q?EJuJZaWlYVOrcf+Tz0H1QCdA8KuAfT0HtxvMTMbBBctwixNU3EAU2kqJN6Pb?=
 =?us-ascii?Q?90+qhWnJOom8f189ABpymKoFZv0JIKxa7kLCRZfSUDJ6cRezMmKAhOi46Ria?=
 =?us-ascii?Q?CbsGwP8B+MZya1AW6+lWoxzMARzfeTD//fa/1tSZfe/2h7Lf2gEGrcs1bcDl?=
 =?us-ascii?Q?SDQ4k9vmfY6/klIcDYVTmNq55kLRLG3pPKp4/xNK5EyDYzDnv6vQGQhBABNG?=
 =?us-ascii?Q?BVzcztfxu1rdR+L+2gSf84oxPtwqyxVLpb6oMM9VFxwgUkB9H6I0uElnjzEo?=
 =?us-ascii?Q?uUZsncRj05dgevRVEhSrtL9ErPtsHI9kAc6bW0emWDB6vNNN7FzcHXyL7cxp?=
 =?us-ascii?Q?EX9rW5lDz7xcy8u2EvoQ7bRZVJscIFy/jV2wHRuRb7TiG5SsrIgnOD9v1Ijh?=
 =?us-ascii?Q?tR1Uj9eIHNFqMcROH8fpKmJFyHnrXCuvqCCLDMRvggZIMVceBtdaSWYwjTLK?=
 =?us-ascii?Q?A97Kasuv9I9fnHvfEzf/9pkjgjlfyiMmrK6LFrCf5G2aO/ghUBgZcqjqE+wB?=
 =?us-ascii?Q?jYeWBSDiTQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4428fc6d-1b63-4024-d54a-08de6a4dcf81
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 15:45:56.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaUSkHdFTZtenv5tDjS9hzJ/STwVLV96Ok2poEDNXGYHLKXJoqy2M13/VDYDCupJq7GVdSdkWXjEbHMv/iYHeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901

On Thu, Feb 12, 2026 at 02:32:02PM +0000, Christian Loehle wrote:
> On 2/12/26 10:16, Andrea Righi wrote:
> > On Wed, Feb 11, 2026 at 12:37:13PM -1000, Tejun Heo wrote:
> >> Hello,
> >>
> >> On Wed, Feb 11, 2026 at 11:34:54PM +0100, Andrea Righi wrote:
> >>>> The end result is about the same because whenever we migrate we're sending
> >>>> it to the local DSQ of the destination CPU, so whether we generate the event
> >>>> on deactivation of the source CPU or activation on the destination doesn't
> >>>> make *whole* lot of difference. However, conceptually, migrations are
> >>>> internal events. There isn't anything actionable for the BPF scheduler. The
> >>>> reason why ops.dequeue() should be emitted is not because the task is
> >>>> changing CPUs (which caused the deactivation) but the fact that it ends up
> >>>> in a local DSQ afterwards. I think it'll be cleaner both conceptually and
> >>>> code-wise to emit ops.dequeue() only from dispatch_enqueue() and dequeue
> >>>> paths.
> >>>
> >>> Does this include core scheduler migrations or just SCX-initiated
> >>> migrations (move_remote_task_to_local_dsq())?
> >>>
> >>> Because with core scheduler migrations we trigger ops.enqueue(), so we
> >>> should also trigger ops.dequeue(). Or we need to send the task straight to
> >>> local to prevent calling ops.enqueue().
> >>
> >> I'm a bit lost. Can you elaborate on core scheduler migrations triggering
> >> ops.enqueue()?
> > 
> > Alright, let me re-elaborate more on this with a (slightly) fresher brain.
> > 
> > We have two main classes of migrations:
> > 
> >  1) Internal SCX-initiated migrations: e.g.,
> >     dispatch_to_local_dsq() -> move_remote_task_to_local_dsq(), or
> >     consume_remote_task() -> move_remote_task_to_local_dsq(), these
> >     are completely internal to SCX and shouldn't trigger
> >     ops.dequeue/enqueue()
> > 
> >  2) Core scheduler migrations
> >   - CPU affinity: sched_setaffinity, cpuset/cgroup mask change, etc.
> >     affine_move_task -> move_queued_task migrates it -> we trigger
> >     ops.dequeue(SCX_DEQ_SCHED_CHANGE) on the source and ops.enqueue() on
> >     the target.
> > 
> >   - Core scheduling (CONFIG_SCHED_CORE): two different cases:
> >     - Migration (task moved between runqueues via move_queued_task_locked()
> >       to satisfy core cookie)
> > 
> >   - NUMA balancing: migrate_task_to() can move an SCX task to another CPU
> > 
> >   - CPU hotplug: on CPU down, runnable tasks are pushed off via
> >     __balance_push_cpu_stop() -> __migrate_task()
> > 
> > If we want to skip ops.dequeue() only for internal SCX migrations (and
> > maybe also for NUMA and hotplug?), then only checking
> > task_on_rq_migrating(p) is not enough, because that's true for every
> > migration listed above and we'd skip all of them.
> > 
> > So, we need a way to mark "this migration is internal to SCX", like a new
> > SCX_TASK_MIGRATING_INTERNAL flag?
> > 
> > The alternative is to always trigger ops.dequeue/enqueue() on every
> > migration (no flag): even for internal SCX migrations the BPF scheduler
> > could use it to track task movements, though there's nothing it can do.
> > That way we don't need the additional flag.
> > 
> > Does one of these directions fit better with what you have in mind?
> IIUC one example might sway your opinion (or not):
> Note that not receiving a ops.dequeue() for tasks leaving one LOCAL_DSQ
> (and maybe being enqueued at another) prevents e.g. accurate PELT load
> tracking on the BPF side.
> Regular utilization tracking works through ops.running() and 
> ops.stopping() but load I don't think load can be implemented accurately.

It makes sense to me and I think it's actually valid reason to prefer the
"always trigger" way.

We have DSQs and potentially BPF can have its own queues, but to implement
accurate PELT (runnable contribution to a runqueue, possibly with decay),
we'd also need to know exactly when a task leaves one runqueue and joins
another.

Essentially we could get the full task lifecyle in BPF:
 - runnable lifecycle:
   - ops.dequeue(): task leaves runqueue, source CPU = scx_bpf_task_cpu(p),
   - ops.enqueue(): task wants to run, curr CPU = scx_bpf_task_cpu(p),
 - running lifecycle:
   - ops.running(p): task starts running on scx_bpf_task_cpu(p),
   - ops.stopping(p): task stops running on scx_bpf_task_cpu(p).

A potential concern could be about introducing more overhead, but I don't
think it matters much, especially since schedulers that don't implement
ops.dequeue() effectively pay no cost for these events.

Thanks,
-Andrea
