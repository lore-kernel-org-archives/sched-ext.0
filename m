Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94F1A23B9
	for <sched-ext@lists.linux.dev>; Sun,  7 Dec 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765097679; cv=fail; b=hTMBEn98xT9Eha5WgjhoMGnvMliayp/wAJwfkDGDEisAfODrlLhpDsp3qlNOnP8uoz1LIIN/LWuD41GNvxWB04JpEBzjTRQFMIPRsKTDzl/wBawYPSDEixFfduOEbqmUtRD33D+CRo3C1QyyAmLcgIy+qNfz/xyWOzX+KZTGiA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765097679; c=relaxed/simple;
	bh=dstiWtFIOo9WDMvLDFkLciRPbEwTVXSLMFKZhxCqxRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SA+HhkSNSk8kR474shtcv8PNFx3K5t7OTDVMW0C1sT136weJEf1GfaGu2TqzgUPtkQMijkA6WTwzxXcwUIk4B5PKOjFTF2xt20T3+5KjYChWgxHnxCCPo19tyOWNjM0L1sy2pL4Sr+v33gczhsuYi4X24TP8wFrA7z7lmOMbVKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SUe5P93N; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SUe5P93N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnu3a59MkwejX1XsSf2gpGMjFLSWdtFpnVAAmxR2mQVmPM6SFm5UHd2Rxt6RCjVcUJLVM4HqWEOvoAbWvUX5D+eM3j0n1T4k6VB8PXZ71vBvJJchA7T/U9GzIt1I650LlPFIObw8AuSkTL/alhud+755APdRyKauzPKHZEbbJ6eZqM/4WFk1vkQ+k2oELNAOzvl/n8ZSBZ8OvBy0MELuTnJlu+bFer9PQztNS1eia+hYGsDO/dFd0b+WXPTiGeLiGgysZUoKJdQx+jFUAodxFXtFOr827x9ln4DPghG2rwFVS0Ejc4FDPS4Bzk3AtgaOjAL2g2cVnxKlyr8oxgaDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLd4edVExoiUdahda4ZzFbB1dKcwMYMBroNVIaFTqhM=;
 b=QCwHfFDWBksDHX65is1wOp37DIfYRb4kSDc/QAPUYATnNV5Ub3xx9YyDkUmrr7K/AsNXr1qAhPwn1rtmmS+xeXN0BsgP0dfL2KnV6Gq3pKZDT+bVqYw2az7cInbd3oAIziu29yV8BaFUv9mSvmhdAu83HB+Pignomf9c8s6x4Ia83CmUQHTeN4Vbp4/uaQUTEuzr4JPke+SScTG1PWbIn5JiRLLBFkwTHl7JrUatHqUSEkM12PvP5S7bh23fNdI0d+RJdDvGYiPh0EA/xnOXuNC/z3l0oPfJLvtFCmnfUtVyJFoXgkELdYDsBkgM6x9fE4wh1K05Ohhx/7D9NAEk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLd4edVExoiUdahda4ZzFbB1dKcwMYMBroNVIaFTqhM=;
 b=SUe5P93NMfvEOq2eWBn6B0U8GZG8OxAHxYEm4tP7hTbQgoj/kUYaDT0qDJDBrbugrmuhClc7VGdqGhec6UyNZs8uVYJbP0+jHiq/n10K7x4ZhcxdrHbcQJ3j4lg9O0TxT27ZzjS8ICTZlqG9HvkQLCu/lohzSqyWC9etrvyOeOr4M/O4p7Eiz4skJJ40d8V0yiqubA41aZmABaYAkQ142WvM4RqvCvwzmqexCnJFj9Zu/1zDr9YL5KQodQsm3QDJFU2uYlqbWU1A8w54u29rjfuBncufhyrQEf0nzCaMR9mUZa3jkM4OvADf1LPNpTtsG/cs+FW43VpbQIJyXHzp/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Sun, 7 Dec
 2025 08:54:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9388.013; Sun, 7 Dec 2025
 08:54:32 +0000
Date: Sun, 7 Dec 2025 09:54:28 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/ext: Split curr|donor references properly
Message-ID: <aTVAxCUVyBtv3hVh@gpd4>
References: <20251206001451.1418225-1-jstultz@google.com>
 <20251206024724.GA71744@joelbox2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206024724.GA71744@joelbox2>
X-ClientProxiedBy: ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: a29f97e4-a93f-4e89-440d-08de356e3cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N4h3WjwXomEtoqpuwkv1IhP2W4vnRG9+pS/0wKsPy69PFw1a2uuf7crh8aMi?=
 =?us-ascii?Q?2BmmRPf4Zi8OtJvX+wv1KyQT7sA5KnvN8tWwHHaPlQuzNmHDABZyWBoRRsGd?=
 =?us-ascii?Q?q3uXzZQvzo5GhB5VjSEuJ2Kco1Xyr0P40/CeZCFBQ4cUtAdV+o6Goyp8u0kP?=
 =?us-ascii?Q?OHBXWTmB0eHbpmUCITkVVMmA2mekEhDwAjiFNXh3Z/dOzK/G2n9q4GnFKWX6?=
 =?us-ascii?Q?K1YfklUhOKS7Tq7dG5eUA35hkMM+l0FEHYIj+7lonjKvgdRmDktUIrn5oXVI?=
 =?us-ascii?Q?SV15ErC89UHe1fj6lx25fD6nPw5r8geByrO6qr75wyGiu5RbKIQtBlErlf/O?=
 =?us-ascii?Q?6ngzKQEVb4b8CKD3iZDX2NBxv7HbyPbfFPMBs+iVuJn6f/utdtkjGWS9LmeP?=
 =?us-ascii?Q?o6wbBAXl6f0t/wI/HwnqBlM0fnZQETrOpOm82etsm/IvIZSXdW6BBfdoFnKf?=
 =?us-ascii?Q?OCiKQ4qXCVQWLkY3U3Mo7BBIDOAv6DRtGM4RkONQws4CU4ArJkJRenKX8bUk?=
 =?us-ascii?Q?uQjtue5VEpDJvTAdJrAP1P+07EYbJ1esajlOA/4dOV/XClml2FHtCZ29GaEp?=
 =?us-ascii?Q?GFmt+GtGCaTMgbwdseuWs+HfLUZRC6JVdQI+7xPq5C/5TT1QFjpAK9dh2Rb+?=
 =?us-ascii?Q?dQiacj6NGapp3jeT8bs+jCVhN8zMC13sq2706+9PC+zTLwrI51ul1ixsFo8T?=
 =?us-ascii?Q?MUm2uQ0kjFxsi9pbKmXF4Ve93jg7ZbJR2jxm8VAotfjDct/tT41eGBRHK8vu?=
 =?us-ascii?Q?otI14EW5r508K5MCnkCY9R2rUer/VOVQIbzKVHw7IRs96VdjHTo/qll78OM3?=
 =?us-ascii?Q?EyAjCnagxC7DYpJoTQr7ChAW7TO7ucr+oMucIjYvAKbMuJ5/V/OQkPBP5Xi3?=
 =?us-ascii?Q?sXf7iN+n5p3mBeAg0i6cdjmQFtjJbs2NUanqcI0ew+7Gg5W0KUzsylduJzvm?=
 =?us-ascii?Q?7w3x5xQcLkB39Nb/2T0PYWwxbQxsYmxIf8J06Y2lW6awSroV1b7QFooryRQW?=
 =?us-ascii?Q?kFt/drdPqo02lBv4O9Z9C4a7PXF+stvxmD20BbqMEsqPGZj5rW4YgLBS6TUq?=
 =?us-ascii?Q?oafTfHNCZZnlxjl6Xeip4wuaYcaHE7dZTgWPJcwDu6ELwgq7Z80Uo+gyA/pr?=
 =?us-ascii?Q?honOB1o2QSyaSZbIyt/6ncJtJunq/wR2xqIUJQpOVolodWmSXInhaD7pETW7?=
 =?us-ascii?Q?+JVcK+JphHntNHSotAexV0rwaBTHvlPjb2/jChQbQkmPFAazFYDws5Z6TmkF?=
 =?us-ascii?Q?xsR15DShD+Mt/VEkPkhyKzlns0OWDSuTdSgIBcGxF44FbN5zXmHh/aPjgdOj?=
 =?us-ascii?Q?SWFw4d8nzxT4TvUt7CEBILTW2BMEpqbgNNTFwO3gWc+LdySW8oVRs1RMLm2X?=
 =?us-ascii?Q?1A0+NwQcI0qtLo6PyvxyFjkJEaWOD4ocWwGcHiQYcRKC4DP+dsH3khnKwH5a?=
 =?us-ascii?Q?yDLYPaJVJVtdal5mzxdQUYPfOckTnMbz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bl7A4LBtzq7ACEvrhb4Rys98TcmDuKzKUT5ZDZNzIPPGKW8sr7ikjR+D7L7M?=
 =?us-ascii?Q?Ouj2lGc+ILMoFIs4n4nOPH4kkQqiisUx40ZcLmvYYj9NtgdEBvddI0lRFlLb?=
 =?us-ascii?Q?jJO9AIsjwg488XCu+3rVGO5D2r4Rvvma8wvj9hjNnmpQHIF0O8xTj7a6oqhM?=
 =?us-ascii?Q?PlG8ed11ToC7ysVZr0t4qkrTRLi/vtY0g0PZzNqt7PruiyLiEG7k/Qn0D2zy?=
 =?us-ascii?Q?sezHH4xoYTGynrTz5viqC2wkjC8d6/jY74h+p9rFcsHT2HhVefUdD1PolABQ?=
 =?us-ascii?Q?SZ6ls4tbJpYXOhuz6Dy1c4bM8hhjD7Dts7aOPxjDQZMDomyjh2nym37tZOTc?=
 =?us-ascii?Q?cKoTvzwRDbOHavQpdZCYOkQ2+9PaCV9FpuO1FhGOmrpEPFPGj2Wfwmi/Iq6X?=
 =?us-ascii?Q?fl8J89DDgy3kryQq24af88tKzls0oGksRHtNAXZt5LaF0cbpqDvMJbV+qFWG?=
 =?us-ascii?Q?lI1BJM4GG739M6378xt7sleuOIPybhtHry9srE0HAQjrUDckymgEVFqPvahF?=
 =?us-ascii?Q?Z1M6YpgV2xPgKGP8hw3obCWtMzG2o6etR7K1UTNz28isTq5JtkMY64SYuDv8?=
 =?us-ascii?Q?YPzngAUFrjhC4T3Pq9r+FQzurXL2J1lYrknSC9w/8Dm1I05GdGsoG41T2P44?=
 =?us-ascii?Q?PCfd/ay1/T7wtqS9umnZeYR9jQOr/GROLUnxVfcIcx9jt2JUQoJvdnj9KIzu?=
 =?us-ascii?Q?nRrFTb4Dhdwtp6rgzAk9vjAOmCUTVyPo/QVmM1oZggx74RlhwYrUPQZhrNnV?=
 =?us-ascii?Q?aEaCIXcJfUGjKklxO73Ee0ZyeVmvTzwqcszSfZ5xIZE3OXS2heOE5zNvDgsY?=
 =?us-ascii?Q?wwto/cEyBie5e4isG1A2AAfEN+riAW7rz8JXovr5dtKjbF0Nc2YkluZtP6sQ?=
 =?us-ascii?Q?GAtk+4JqgKuWqHndFwHPeH/pNN/BOEJ37w8L0Ipdozyk/ekJ1DrArqzS14NJ?=
 =?us-ascii?Q?wmHh21L4RHpwnyN4rVmCk00k/b+hrNVE9HP7cnHNMz+GtuyYLyw/nmab1bG/?=
 =?us-ascii?Q?2v2orl1906AvoAZJ/dpVZu8qd72GIW2y2ucxVamT/bl0k5K8xSWkl1gUlw7O?=
 =?us-ascii?Q?QPIPTKAe4q/dzUl4O6FxX/NmucsaeMj4kA/jjTUFvLShbMZzTrBduV/YKkRy?=
 =?us-ascii?Q?zcxgGOyOpBnPaQxVmj13QFFiBOOjxX0ODMFX7jnnZSmCGzGU9EZakems7y0S?=
 =?us-ascii?Q?yuujcmOjWY21PpNWeTLELjZHQgm5gOheTA/Syg+fmV693EdtTnpO/2j0fBon?=
 =?us-ascii?Q?gr3L+PDt1fntCSDcwk6St2NYrSkNljgJduADXoclYhqtkVJWjHscyqlayFE+?=
 =?us-ascii?Q?s2TwSo70zYOFxX3D859WH3pvqgfKQuvL/YYJW7IuLsmkX7Rjj3zWJCfa1SFo?=
 =?us-ascii?Q?6lyl8MV86b9K1+ASQXhLnMetjRx7+lrP7cEhEzzAOUa/U6I/Ak3tyOgtGiWH?=
 =?us-ascii?Q?H1jHeRg2fHxowth4NIH3XDrDxBr3USRg1F+jyTgJkHLrT2eXHGm9jF0UyPUN?=
 =?us-ascii?Q?4/ySx3Ahlphpk4NtL/TPJKT/alg6gudoMkhFfZ/RGXiJSMm3Hk7E8RSOGMVr?=
 =?us-ascii?Q?Rq8iITGAC6jYZpWs2DshQYmk0tqDJdYnu/GLkAm1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29f97e4-a93f-4e89-440d-08de356e3cea
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 08:54:32.0996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHE1ZQBZzpn+MGTMGpRE3YoG2Z+xSF3uTwlfd4rGiq4iWGy7BQ/aB+meh83UKnVyCF1w1diJrDwIi+JKIK0cgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

On Fri, Dec 05, 2025 at 09:47:24PM -0500, Joel Fernandes wrote:
> On Sat, Dec 06, 2025 at 12:14:45AM +0000, John Stultz wrote:
> > With proxy-exec, we want to do the accounting against the donor
> > most of the time. Without proxy-exec, there should be no
> > difference as the rq->donor and rq->curr are the same.
> > 
> > So rework the logic to reference the rq->donor where appropriate.
> > 
> > Also add donor info to scx_dump_state()
> > 
> > Since CONFIG_SCHED_PROXY_EXEC currently depends on
> > !CONFIG_SCHED_CLASS_EXT, this should have no effect
> > (other then the extra donor output in scx_dump_state),
> > but this is one step needed to eventually remove that
> > constraint for proxy-exec.
> > 
> > Just wanted to send this out for early review prior to LPC.
> > 
> > Feedback or thoughts would be greatly appreciated!
> 
> Hi John,
> 
> I'm wondering if this will work well for BPF tasks because my understanding
> is that some scheduler BPF programs also monitor runtime statistics. If they are unaware of proxy execution, how will it work?

Right, some schedulers are relying on p->scx.slice to evaluate task
runtime. It'd be nice for the BPF schedulers to be aware of the donor.

> 
> I don't see any code in the patch that passes the donor information to the
> BPF ops, for instance. I would really like the SCX folks to chime in before
> we can move this patch forward. Thanks for marking it as an RFC.
> 
> We need to get a handle on how a scheduler BPF program will pass information
> about the donor to the currently executing task. If we can make this happen
> transparently, that's ideal. Otherwise, we may have to pass both the donor
> task and the currently executing task to the BPF ops.

That's what I was thinking, callbacks like ops.running(), ops.tick() and
ops.stopping() should probably have a struct task_struct *donor argument in
addition to struct task_struct *p. Then the BPF scheduler can decide how to
use the donor information (this would address also the runtime evaluation).

Thanks,
-Andrea

> 
> Thanks,
> 
>  - Joel
> 
> 
> > 
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> > Cc: Joel Fernandes <joelaf@google.com>
> > Cc: Qais Yousef <qyousef@layalina.io>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Zimuzo Ezeozue <zezeozue@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Metin Kaya <Metin.Kaya@arm.com>
> > Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> > Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: David Vernet <void@manifault.com>
> > Cc: Andrea Righi <arighi@nvidia.com>
> > Cc: Changwoo Min <changwoo@igalia.com>
> > Cc: sched-ext@lists.linux.dev
> > Cc: kernel-team@android.com
> > ---
> >  kernel/sched/ext.c | 31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 05f5a49e9649a..446091cba4429 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -938,17 +938,17 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
> >  
> >  static void update_curr_scx(struct rq *rq)
> >  {
> > -	struct task_struct *curr = rq->curr;
> > +	struct task_struct *donor = rq->donor;
> >  	s64 delta_exec;
> >  
> >  	delta_exec = update_curr_common(rq);
> >  	if (unlikely(delta_exec <= 0))
> >  		return;
> >  
> > -	if (curr->scx.slice != SCX_SLICE_INF) {
> > -		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
> > -		if (!curr->scx.slice)
> > -			touch_core_sched(rq, curr);
> > +	if (donor->scx.slice != SCX_SLICE_INF) {
> > +		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
> > +		if (!donor->scx.slice)
> > +			touch_core_sched(rq, donor);
> >  	}
> >  }
> >  
> > @@ -1090,14 +1090,14 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> >  		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
> >  		bool preempt = false;
> >  
> > -		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
> > -		    rq->curr->sched_class == &ext_sched_class) {
> > -			rq->curr->scx.slice = 0;
> > +		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
> > +		    rq->donor->sched_class == &ext_sched_class) {
> > +			rq->donor->scx.slice = 0;
> >  			preempt = true;
> >  		}
> >  
> >  		if (preempt || sched_class_above(&ext_sched_class,
> > -						 rq->curr->sched_class))
> > +						 rq->donor->sched_class))
> >  			resched_curr(rq);
> >  	} else {
> >  		raw_spin_unlock(&dsq->lock);
> > @@ -2001,7 +2001,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
> >  		}
> >  
> >  		/* if the destination CPU is idle, wake it up */
> > -		if (sched_class_above(p->sched_class, dst_rq->curr->sched_class))
> > +		if (sched_class_above(p->sched_class, dst_rq->donor->sched_class))
> >  			resched_curr(dst_rq);
> >  	}
> >  
> > @@ -2424,7 +2424,7 @@ static struct task_struct *first_local_task(struct rq *rq)
> >  static struct task_struct *
> >  do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
> >  {
> > -	struct task_struct *prev = rq->curr;
> > +	struct task_struct *prev = rq->donor;
> >  	bool keep_prev, kick_idle = false;
> >  	struct task_struct *p;
> >  
> > @@ -3093,7 +3093,7 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
> >  #ifdef CONFIG_NO_HZ_FULL
> >  bool scx_can_stop_tick(struct rq *rq)
> >  {
> > -	struct task_struct *p = rq->curr;
> > +	struct task_struct *p = rq->donor;
> >  
> >  	if (scx_rq_bypassing(rq))
> >  		return false;
> > @@ -4587,6 +4587,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
> >  		dump_line(&ns, "          curr=%s[%d] class=%ps",
> >  			  rq->curr->comm, rq->curr->pid,
> >  			  rq->curr->sched_class);
> > +		dump_line(&ns, "          donor=%s[%d] class=%ps",
> > +			  rq->donor->comm, rq->donor->pid,
> > +			  rq->donor->sched_class);
> >  		if (!cpumask_empty(rq->scx.cpus_to_kick))
> >  			dump_line(&ns, "  cpus_to_kick   : %*pb",
> >  				  cpumask_pr_args(rq->scx.cpus_to_kick));
> > @@ -5426,7 +5429,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
> >  	unsigned long flags;
> >  
> >  	raw_spin_rq_lock_irqsave(rq, flags);
> > -	cur_class = rq->curr->sched_class;
> > +	cur_class = rq->donor->sched_class;
> >  
> >  	/*
> >  	 * During CPU hotplug, a CPU may depend on kicking itself to make
> > @@ -5438,7 +5441,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
> >  	    !sched_class_above(cur_class, &ext_sched_class)) {
> >  		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
> >  			if (cur_class == &ext_sched_class)
> > -				rq->curr->scx.slice = 0;
> > +				rq->donor->scx.slice = 0;
> >  			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
> >  		}
> >  
> > -- 
> > 2.52.0.223.gf5cc29aaa4-goog
> > 
