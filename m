Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793101146;
	b=MGa5suIdGwhTK3ESi83R8/hgbTT6SVwoQD7pc9UrwSTNtwsf9uotv+wZuBVpeJ/UiSEV
	 JeAaD6tnk0mzKS71XyIKECQA2F0cE0yNKjvhUYQAP1ZoreH1TW1x7VwpO8kkNJJMgyqUX
	 EUnFzvP023fPL3FZ9EJVfYxpW6w5UlVrfs6o2VcV+Ip8cTJ3Vi7UvQRaI/Vm5s7k7I0TJ
	 ztXyL0DwTQom+srqo4oAlURq88+kXQFQLgiFlPMmdmj+rLgMRMrvxYMf8ImD+N7uIbuK3
	 8+dmVraauZWdEQREMBwKAChEthnZngNWtGzN/vth18ayvLrUcD3p7uRmWmf5F51EYtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101146;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hmci46Qqf1rO22cHOZc6V46V903BeIrI79fMjtAYBwM=;
	b=2jbw/tApMN76nV5jKxFZQHxTNp/UkkONuvbnwNudEAgae17RQ0HMlARZt8qQ694NiazI
	 tAshQEWR/FQeIu9oe9kUa+WV/dIeTS6kJHXXXU9TgCMG7h3UdFWP+4ElMONFkCeBOTj4i
	 +nPnUSgZsY0caUteTFQNgbkegmATwuggL10JU7+r3bkFgL/tMfwz3NvPeYuF9UHZT7nwY
	 9VT/3TqyVE2jWmOMKHz9WduFJ8gtlRhgwWLqnd6qrArx7O3VCrkXhZ79S8zamqcKmeHob
	 FS9675uxhCqpFo5//EICkuAvJ3hJh8u/W2r6rp0B2+gw2Zdjl0DwK2EgDeVJ+Lmfyyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X7nsBCW9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.4
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1F6070BA0
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 11:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C1F6070BA0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X7nsBCW9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSdLikhJrat/U+Uz1puCdUpPY0PkRFXJh1ET/VdZpF/Soy88dj5k+dqicaq7c6Ra6nRXfq+pTGRPZIsVB1K//OqV8LTK3JAzFABcV/wPYacMDd9jSCipYEZ5I4NCBgeJbyA1hQ5N2Bvpv43TvdduyT1lxlL8YTMUWVFtvmkHXwmfSMsVpf3a0S2V/36YORUC+8nr5pocOaEymggkfWU54WwCDWJiDROB2Siuu7ZBvE62PwMw/9JGqWYPZhJJvRBwXXwr7z3XQQY17McbE1xupE5WaLr5dTjTcqR564expSFK1TKbwGBkRW//itszBrF1ONXE/2cmzpDIxEu07YSD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmci46Qqf1rO22cHOZc6V46V903BeIrI79fMjtAYBwM=;
 b=QyxOcoqvKd29RHZEGDZ9MzUGu8MUnpZzW9yyiGn7Px5H2dUVN4NKB7t2fVvD6n0Ccxdsb7Wxk9tNHVEoX0V4IFvmqQMtCcJtAJqrK2zbanvmpdDtfmesy20CoHdozevAPHJkFlAbhxCBnvX39LnFS2RPLAsQilWSUlSv0eHgEkCBXn7oUaMNFEDMALi6pa9Wo+hu1IQArxDbCWsbn/RzT9eH6XdcqyHhmw+YQfvQQhD9FTpQ44XM0qzYbfbCcWr3oGQQfs2L+sBnOfrmyT0IOA8ttSjXFT7Ln2uR8q6nBnym2r1Cw72LC4/b3qbnrQyI0dQpycAzqPIYSp9LsCymVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmci46Qqf1rO22cHOZc6V46V903BeIrI79fMjtAYBwM=;
 b=X7nsBCW9tavbjq7J+FAeJScT714qbnQabOOpMy9on+q2cHASVrXnQVFmgkmmX97+u+9CfgrREWknAKY1zKpL4OAt/df/HWSvqbQeLy5Ho15hQ6q5HNUqZBrIE35tRRA3/xd+KBx4Rizi7pCxhdfuXdlJD3iJ4VP20aSUsl3RcrpTurYG4hX2vuqMKy+TBrbbF4LMC23Hrqwak5NvULO0OtAQGl+5+AlzVPaTL4oc6PpE3qe1IEy/5ZNzwApid8CrzA+sw1QHQ7x0A3C8cFM+j+utvOZr7KXwjS1TdPsfBLcHiiomxyGnrl5rpXGRMsyq2ixVOu+NEUmbQ0ABKDFARg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Tue, 27 Oct
 2026 11:38:57 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:38:56 +0000
Date: Tue, 27 Oct 2026 12:38:49 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.5] sched_ext: Add NUMA balancing
 support
Message-ID: <auCNSY0fCBu9uIDB@gpd4>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027105209.GF2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027105209.GF2668564@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1PEPF000008C4.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::426) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a66e21-d030-4e41-c179-08df341ee2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|261009223027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|56012099006|261026140227099003|22082099003|18002099003|261026121527099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	KrS8O5IREBBMCwtX0CXorg8Nom6upLwRas8mcLiam3/AzYKSpl9RVu2SCoxKcrc0ybRmlO6sHz+s/++Kln9bS8lnrQqgnD89rtTyH8pxNf/vrRECWZIbc+KCCI90SaFRAL355eKRW8SOgOqrjvpkEF0f2SnVj8rYPsybdG4DN6T/PnfejT/93E5He55yE2aRiPjeuAzfBTzEDY0Yun/ZzDVzFmObT/LzTXSdjEnE14Sh/0+t2S+IJaWa6/cQGZwDv2XCHNNEVEso09vtux7e32yvjTqS1CYAh+m+STnCuK59kmR7IkoFTNlcu4j7OrbVA8Owut+YJPCz4XIPexq5zi4R99bPxc8CEK0ZLqE2qvvMTbQiimThmifaR4C9pizUfqumA14PhFlI0By/1aRCYeO4G3zK1tRLfZU69VCgesbQpQUse9wbhrYbV2xXBEUtlGTbPqywpszPGlez/Mwhu+rRIf+oRfJ9+640M54nI2krh4VOgMv9rsWXewQpsNnVSfIeT5Au3QNhdAeM2VusAqALl/Pqk6RJN4/qhkG7ipMFttVgU+y70ku+2naStegwI5bN80VdM6syoCGCYhu3TqQ0DbpDBGSwZoJqEfo0RpVBa8VCZqcoGHaDWJ6g9VSstRu3b3ug6KHBPbnsKrE08hFGpB3RKJm1LAW90Gp9EUo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(261026140227099003)(22082099003)(18002099003)(261026121527099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TUC7BW4IGBVrAaH8L4Q87AnaSeUDiE92phwjZkc5cqonW95lEPCtri05Xtrg?=
 =?us-ascii?Q?lCLHSiAf4eb8nMKaHOZ4gzF0llybiv/kKd10iKF7HVWHbr38ALI56kBzSKjx?=
 =?us-ascii?Q?n/5S8ctSX7OcmxE7DpimwqVKQNQGvCwgudHsy71J+Pl1TF5GocJcfDKL81qX?=
 =?us-ascii?Q?YjImQDtKclHIMiNfu6lYoldJR0hGfvOyhp9oZtSzUoM036NLemdhPefEypfw?=
 =?us-ascii?Q?Ux3KRJ1bYDamyml8Fa3UI6r8QN62SjoZTOP9vxHQoAUPuBAx6yKYAFH7Uq6W?=
 =?us-ascii?Q?kqJIq9QDhbWBTLGibg9+TuacXG0O3Xlmrih7Lg2jWSh7YvhFulg6+chgJmkd?=
 =?us-ascii?Q?9BylwLLKQ85jFWm49xkYxft6ewvP+eykDJ+SodR1Q6W2dlHdm293YFB//jN7?=
 =?us-ascii?Q?lHjhpxdD6cb7WSxTRV9liSRzbH2tTTKdeJJ7zQE9T7XPF7C0Xeq1KPDuqC18?=
 =?us-ascii?Q?pzu8AUvFH6QPfnkzLNFkfuIqiFlMBauis0TgR7bgjFxBSzccRxJhZvQfvk3j?=
 =?us-ascii?Q?BNqh4YIaPPc4n1acrHM6me3EBHJGL9p3CfEVv14dPaL8YA1HyzhR5ciwXo4y?=
 =?us-ascii?Q?rV0NkTuj7u8MHWXl/X/1wihobJD21Lw7Lsq1Uwq/NxYxAPvH0gY5Gj6TGvzq?=
 =?us-ascii?Q?Yjy37bVxsS3231aE5rvB0sAc3hFhvOEaubdpaShogJhmyGP8LG0nibhSclOz?=
 =?us-ascii?Q?0lMDtbt+ENbTDUNb6OScaYAB7cwyxWp52+D1uVVDRDQXXMq32/xRTNVB6unB?=
 =?us-ascii?Q?0K3uwHq008pKRwRrlUgTa6gDyvnwNlfoX4s/hwHjOanfLfvfVi4ihXyEzclA?=
 =?us-ascii?Q?6//qHlsgvc/HF389nk4SZU1KQAb+hsOSjSp6Dy8NbLcCMbwkxzwf3+LoUha3?=
 =?us-ascii?Q?MG6SdnYI9zUsDpcLHTNCRl0qCUiyZ8wtRVbtioSQOCzHOJbERTAokoMo47a0?=
 =?us-ascii?Q?SF41OKd0uaqhNIs5z6VcRAWCeNFz7oOar+jrT0Yu+QNhaBhUH6d7OHjHbluv?=
 =?us-ascii?Q?oUVXbXgt6qnTa3nUWP8fnNslkgZnmL1uyDkU4ZU0Q9TAlItKqPlvfY0wYZzy?=
 =?us-ascii?Q?ccx3nxRDtnpQOnH+ObUvzk3gmFGJclSxa30NAHvYLaKVOq9BgnU59BRYAgR1?=
 =?us-ascii?Q?7y3o0Afgqk4C7HIV/CbKyhJ47dGm+7cf0F8DSD38QX4SHSp5x9YYb50vjGJK?=
 =?us-ascii?Q?CnqfIvbSVPQjsvOKCZwgmHUGilNZdYolfy0mm4+6qD0br1fWsczErLpTY6xy?=
 =?us-ascii?Q?NXdmyKg7F+qJx2JZG7H7iK86BC55poknb66SlHjWcvd9Xj1XuwajcsgcaWLY?=
 =?us-ascii?Q?2kL1hqN137eulG5m/LK9oZ00K5GwOW710Fol7EPzeO3bmbAGgeoRkUceY85i?=
 =?us-ascii?Q?53p+6WvUhVqnjy+9+K7wBtotsnjXDbWkTXA2YySpU7WDh0BLyD6FaksVIFrJ?=
 =?us-ascii?Q?PYlaPcOc9u5IhjnK18VIuBrmkskeHFoXlFEDXD84BqzY+qYVx8AjFKHpvs75?=
 =?us-ascii?Q?LpBn9/knEZSoK23vd6YZ0BYWy/QFykqt6vQ9N0HtOVwWtyZ2+F7zDxmGVa4x?=
 =?us-ascii?Q?TmXOciMbHbSy8oEKnKfd3fGX4Ar1Bga4Zxn5tgZq/y/7Y8MByRNAgL58q//w?=
 =?us-ascii?Q?FND13kb97ja/cpahyPIUfIZ+2my+zC7r04Bto7XsyxwKF4t9JRZN20ZpMupB?=
 =?us-ascii?Q?g8O2DvYDCZ85S4XYSdIPrDl6YsEPShr0Vo5CZFEmaeZZfOGm4PQGYNJhpFZ8?=
 =?us-ascii?Q?QiI0DqNjUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a66e21-d030-4e41-c179-08df341ee2b9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:38:56.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylQpOyCy0aFFlsMnhrYQU4Lf68qCmKFwUi8X6aT+juj5Ov093CIh1nretwaNWVS5YEXVwLoFXee3+fMMnrc2pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902

On Tue, Oct 27, 2026 at 11:52:09AM +0100, Peter Zijlstra wrote:
> On Tue, Oct 27, 2026 at 05:13:29AM +0100, Andrea Righi wrote:
> 
> > Ideally the ultimate goal is to give BPF schedulers both controls that
> > NUMA balancing combines: moving a task to the node where its memory is
> > and moving the memory a task uses to the node where the task runs. This
> > series provides the first: with the preferred node available, a
> > scheduler can decide where to run the task. A second series, to follow
> > once this one lands, will provide the second: a kfunc that lets a
> > scheduler request the node a task's memory should migrate to.
> 
> Fair has no real control over the memory migration part either; why
> would you want to give BPF that?

Yeah, that's a fair point and the wording in the cover letter is a bit
too vague.

The use case behind the second part is accelerator/device locality,
discussed at LPC in the sched_ext MC [1]: with multi-GPU systems the
heaviest user of a task's host memory is often the device, which NUMA
balancing can't see, since hinting faults only track CPU accesses. So
memory follows the CPU even when it should stay close to the device, and
today the only option is to pin everything with numactl and/or disable
NUMA balancing.

But that needs to be discussed separately: as Gregory pointed out at
LPC, NUMA balancing needs some cleanups first, and the right interface
may not be BPF-specific at all (e.g., extending the home node concept of
set_mempolicy_home_node() to NUMA balancing, or a device-aware hint in
mm that both fair and ext could use, or something else).

The first step for now is to, at least, allow sched_ext to see the
preferred node computed by NUMA balancing, which is what this series
does.

[1] https://lpc.events/event/20/sessions/270/attachments/2223/5283/lpc-2026-sched_ext-mc-report.md

Thanks,
-Andrea
