Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937D3A1CD
	for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540093; cv=fail; b=Nfuvg9GLngKrePr+k5QfzI0BeXz6cN1H8a8Sxzoa9TTyuAR3DUFOj3PjlyJ62JSKadfFwZlteGN6JRL+NhblTPd7XmBJvMLVzj42inzdaJKIZRDxtECYrNkl9FLuMcroeGL/vNPzvUyNwq6S3ZVuRE+FaDjCmCJuIpiTbeGmCTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540093; c=relaxed/simple;
	bh=QJpdbHu/sBVzXDEhudwkPt/WhUiwk09krENIX4oqjQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dgl4qGMlWn1BITAqW1VQHO6wi5O/OQK8TB39LqHGf8beotI8Sdc+5dGNVLCaSb/LC2rRCoRA4IS2gvIrMDgSfG2Enk9ZCJJkWtFxxB24AiQV+QXHBZXbIxPdHoDkjMWRg9hj57TijFCiVKHbxc4IHvv+3J7jN2CIvuphG5SgTXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=um3ZTHzG reason="signature verification failed"; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="um3ZTHzG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ProkOKa3MxS1x8bQYokSP11QlOTpnhmxrdMBB8A+gd4gvFQ6G1Uu5W9jJoHlm9TC+9cjfWUBW526Tv8mycrignYYUIEBaes+G/RCsDXzNvTG9qbHgB4KaO8qspUBxfE9+nzRVZkFAX9rFfSvHRXp0rO73hLcjDSX/z/tD9rtM0S5kxurZwa450t+iN4mgnaUErqBVZ9h1Y3nhfXNSzbnUOJdZgfUSBggZL+TAnrbdpXu8301AHdABhn/YT/Dg+3SzVk6oxvhUG8MmaC+zRV4a9VezzzgLEtbfFgRX8ni2jhLbQ0nZSLgq7UgjnxJLu5EgvhFnh/SO5giKBSAhaQKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ce90EEJtyq0VSmpaLEFN+RrFAprYrqXT9EDiPjZnnM=;
 b=mz0yAfUstGYcto1xodHZla+C+fTyoO9pJOXK5BNryCogKkqlAZfKelr0z9PWAd3mHAn4oaxwGSA1COLU+8KJJ771QOTgAyi8GuAN/bmDozJXBWL5yu3lq5a6is7EnX3vIj0bZyp7ZBDkjoRtd+NZB/gelj9AS5Fa4cwHIHmaZhhVA3e4WrUYCFLBfEisQkLJ5lGBqqxw/ckz8nHyslPYQge5bwg0hEwi/Li0HbuTmdp8icU8uwkV8etIng43jkZBGrHCY9RaX6kmK617WXwuTmsB6A94dtCaavyx1kqH5kCbIe3Hi0u+h9MrNj7EtQpjYKlbVwkZqiUvQvJTiZu7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ce90EEJtyq0VSmpaLEFN+RrFAprYrqXT9EDiPjZnnM=;
 b=um3ZTHzGUWm1ncvb1C89LQpDAGPVTYGXSukxKX/lqFkav7gn34SrFOer9jPVEnT4f0tPz4YosUJQjOPcdXdZfyQ/vyY9wZsNzBCIPR90IPRDDa4kQz4xkcgKs+qxYJP8Wjm7wi+gaxNukTeZHd2OrtE03qDXS4/u6d8aa+oagesXI7NC3LNwjV5fM0AIrvJhFmxFjqFnB49nOysnKVxBmfbPs0Y7E1c5JzqDmI2Asr1RhSPBdYDCM5YDI0F8T9dnGuMRxl7ncbnQQxX+5d3ALPCWemzbBsAYcYP43bhu2YteU+6yD3Mb2dqPWXc4FxKUYrs1bJAHTA3LXlJjf66ZpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 18:54:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 18:54:47 +0000
Date: Tue, 27 Jan 2026 19:54:43 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <aXkJ8_zLVSuToLxe@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com>
 <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com>
 <aXeWnzI3ymUSm3Cu@gpd4>
 <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
 <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: d323c096-e26c-4ef8-4e19-08de5dd58adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?EynyDN9xEHco43GFR8tJ6ZF0U9SCed02X7K/Voif088CCR7zzTyE9Ca0Zz?=
 =?iso-8859-1?Q?aQJzeVPUmJOUnCpNMOwKGrTWcO1TBCsgVhpaQxl5grkolcVvteBn2kOwAq?=
 =?iso-8859-1?Q?w02lZ4j8J6ZqLDSSxXBy8Wmgi8mwgxTJV2OgpIHs6NFd07ZW1523cgnOS/?=
 =?iso-8859-1?Q?IhKYc8j4jNAvQ7NLC80oxsBvL7CG+0kDEWxrQro+MsWxj0+Nspr6ixcr+r?=
 =?iso-8859-1?Q?uVpsMPKjsvnfNqPjN3T9+fliVk2+gHnWdPJrsyjYYHrevPfCFjifvg7F6Q?=
 =?iso-8859-1?Q?30gn+GOK4OSSThFzxn9xylbZCwvXnQFT3FXFJ9MaaZommILF+BP8YF1Y2F?=
 =?iso-8859-1?Q?Hotip0O8F/KmKXrdsesj2eCT8HharwLYDVRd6SaEhym28oIiDNf/m5MGOp?=
 =?iso-8859-1?Q?lV7cBCbdiHSpzFQTxek+G1XCpwxuB1ELZg/Qg9r81qAnaD+2oBy09wl/9O?=
 =?iso-8859-1?Q?/ghcC3sbNbzieJ7w+JAUDHTJCcSyeT48P7e8ysyMm2gF2Tlzp+I/x/XYYn?=
 =?iso-8859-1?Q?YPAssUXcXHsaoDOhbSXhZxuR4XUNOWLuc+kQoqewSCM7rCjrjp6usm7Zx5?=
 =?iso-8859-1?Q?fCxsk9RR5MT2Zss6GLqX0mj79bK96wWcZ38CuKcbVIVfyBbcxJ+VpApeN4?=
 =?iso-8859-1?Q?OslkZZk9TIE89xZlHmh2/GQ1huPVSiIPFronKD/vM98HawfDB2huYvBFEw?=
 =?iso-8859-1?Q?YJSP2mD5d1UjUJUiEVZHRgpv5PjhKl89Etmi6oKot4KvvVq/WjiFMocPzg?=
 =?iso-8859-1?Q?5wp6WImxvFN5tpmLoSdl++zUkCMa6lTqgEGEbLCzYvIS2gMFy98colyfVa?=
 =?iso-8859-1?Q?dJdPncdxocBcfgNKoozDgStRsTl5wvbKGdLFSDqpV7uVMRRy0u72mHHYET?=
 =?iso-8859-1?Q?T1ddAAyK66uIZvnFHXTgKHOYWptBlSSywCcPESHNoIINenEv8Do/WymNbG?=
 =?iso-8859-1?Q?tnNfcbVHYH4ZXQSqcDC5dFteg9r6hQRxGCxpGuEcdRN6hFFO0oun3aMsvO?=
 =?iso-8859-1?Q?p+KSlfqorHcFKtpaDGUV4DCaIXVApsqHf45za/w0NDQVwKqhqKcMDp6EgF?=
 =?iso-8859-1?Q?EuToUS58yP3lq84TJNYizT/t4Kv0WRJLOvkEqHL81Dsbq2G2QZ0+Imvvmb?=
 =?iso-8859-1?Q?G2RBBpqGGfzm9UBg52I6SPpOK3syssnooSvDRSSSoEDV0GVoPfLFq5QlHR?=
 =?iso-8859-1?Q?ZelJbuz8ltCL7qarGVtZcJ2fBxWCrtXxxjHDg3nlDWNL2bM6Lkma3PdCvv?=
 =?iso-8859-1?Q?iGyyKpS4GgEXDvyvtfvQFWVAUDcAc+FSpNmFgsUCBVpcxJwVOjzk8YwX7R?=
 =?iso-8859-1?Q?D6qd+KVkGHsl96oo97i5k+n9gMwDHZqr+gkZ9S3BDxpUn1MFxInblOFV+n?=
 =?iso-8859-1?Q?Ph4WEPK66Y10TDHpFjKMozFKcJOoutD7PyYYieVbFqqbDIKMZ5T3p3QVtI?=
 =?iso-8859-1?Q?7j5j0keJtEuHlFi1GAzTsfWKI40k9IUC9umCSIkDU16S0oOAS33r5tB46u?=
 =?iso-8859-1?Q?WrHnSGHSlnBP4RVLejrV/lEVOi2fjcMZmFyug3bybVd2GiKNcHCN4HOFn8?=
 =?iso-8859-1?Q?fHELXQW1cQrs3ezV4P3fPSKyiXwCQtWDF4ZQK62GEdQyIKU20cknCuEY63?=
 =?iso-8859-1?Q?svYMV8KQ/C0sc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?BmJgdLJ38k6XSQKpj5qIINvBZBsnsJ4InPgShDpmtRt3faBN5pHSa+oGIY?=
 =?iso-8859-1?Q?9EJXL5RvaeDvmYwoXjqwaLBuuaSQg5LqfjfjgkoB0vB7rVaJQBXx4nj8LM?=
 =?iso-8859-1?Q?HygO23U7RzRgE7V1zMUsM2rBi02FSuEZGemqXhIweewwfqiH4zRI8tpDzV?=
 =?iso-8859-1?Q?Avzgt1HQGHpdh6M9YKUVn7Os6f92MI8/hEPZ84koNNr913hgrlseYI82RT?=
 =?iso-8859-1?Q?Kwa5m1LBCfYndWwUjUpq8pq4i1mj1FHl9uCt75jyzUD8pVLR8xHCO/FSMY?=
 =?iso-8859-1?Q?Rfo0MkfFm3SMOGZ7Fdv1pFo7m4iTeOgxndaRHfxJcnngieO+oIAAGt70LN?=
 =?iso-8859-1?Q?oZPJ3L3LFb0l48nGDgn8NqjQeYYc34jtw8E13NPqVrQqI/ILu5AnYfhBlE?=
 =?iso-8859-1?Q?puKEM6MI/3y2txUYA0DPvuxnI9SKI3oi03LIBe1Pwa7U1P5ZEz8gbjlPEm?=
 =?iso-8859-1?Q?+Bm3TqCFtozh1QKnmH9Uns5sxb3uN9T0ZDdIf11m2IF6H8A8+0Y+PoVA7i?=
 =?iso-8859-1?Q?+t5zKU2HBhn+gWTM+zCYftaKqdJZEtgpyy9laWR2wabzvGC46x1SG70csM?=
 =?iso-8859-1?Q?ImvY25s9N1Mj4Y5IiEY98ooWzHkaRFISF8CzOiEfRH+lb3iRoTz/kcV5xy?=
 =?iso-8859-1?Q?5kW+cji1LTT03Dg07a5tvEcwy8XNLEnxthfh3H4HrVWzoYPvGb+OIaSr9J?=
 =?iso-8859-1?Q?ZaTnwGZ9TxLZPbxLJ8nveKfPPdNLbMm+nAPuB1HnFT3ioiR51Aed7a+otX?=
 =?iso-8859-1?Q?tP2aXnoJ6VpMX+84w9zoS6GQgvfnX6RhMP3/1E7u+CHP2t+U4yBajq3CDy?=
 =?iso-8859-1?Q?Nzyjl6VqrBq1nu6Hg4Beusv+tOCgcEYFtPjCDtYRVENGws+sUFZdEfCqSK?=
 =?iso-8859-1?Q?uFig6Bi8usvVD6DS+8FTy0/ghP2sTLzjSYCMc+Oz3yW8GvFI3SvdcXbiZt?=
 =?iso-8859-1?Q?nEp175Fhq/7z4HS2xEpLrw3z/n33JbudGVZKe7RYyri/GTpu/kdvEyXStR?=
 =?iso-8859-1?Q?iFqWwbYHfySqHB9+yibky+ic3K+QiuC7tRgylMPZwelEtVRL713hpiBRKg?=
 =?iso-8859-1?Q?ufcCB13qhRHdsueff81YhADYQz++Gho0rbgDT6dNgToPC/2F5xrZZLDRce?=
 =?iso-8859-1?Q?4BT3PlWp7/tkGvuusi6NZwERgP7RVuHvKsK8VgLQhqUflS3mQhNAOAIr0s?=
 =?iso-8859-1?Q?2l5ajj1ER7JinVVOj3bPZ/NEq+6nEyRsFGYUyYy9vUwNaN4yayNvEdKiiY?=
 =?iso-8859-1?Q?NvnTtYLvWOwoMRsdQzEvNwA+DZg1GMsfS5OC7rbny1w1kUDh2z0lJOwW6Z?=
 =?iso-8859-1?Q?YlmbCtqpox9dV3sq7qWH6tTuNPt5mXpuITunjJ6Ury/J93bNzr4wvbkPa1?=
 =?iso-8859-1?Q?HXfC5e2sGH/K76qVhWbV0pWeztEkxnFdMAgIk6t7GnW10izaTd1ktVIa2C?=
 =?iso-8859-1?Q?9EzB2hRNpplGKWhlV2u08a1OmGFuPKyV4Cukc7U4y0MLH2AZbIvyybRg4x?=
 =?iso-8859-1?Q?0wAPrLym1QAUNXy2Cm1rDrgVZDcBlOQF8LfZKR9dcUOf21xXp8v5b0DNEd?=
 =?iso-8859-1?Q?bfvX/oN8z85Q0d8hYDQdYGrDKlcbMlbHrNHdbMrQlYkOAsA/hlroucJPLm?=
 =?iso-8859-1?Q?i2SYlnjAY+rrfpWL9x83dlLC0U/Cc7PVmwA9zA8K0KU7FdnjDyCn5GvBgW?=
 =?iso-8859-1?Q?TLv9cNkOdN0Tn/SzeuFFvGCAzfKGI46ardiH3MqPAoUhQFjOW43su6tUVz?=
 =?iso-8859-1?Q?wE4pg8dTJXLt8fXdX+q0aWqxgbhteCkJjMpV6AmBd7OJ7G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d323c096-e26c-4ef8-4e19-08de5dd58adc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:54:47.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQTxPric+xil81oOIRC2vqIXBcVEj6l4C+UodC27KaKZ+Pj1mzi/0HhjERJLdl/njSF5l60+aesD5DLH6+mKmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192

On Tue, Jan 27, 2026 at 04:00:31PM +0000, Gabriele Monaco wrote:
> 2026-01-27T14:18:29Z Andrea Righi <arighi@nvidia.com>:
> > I think my case should work also doing something like this (I'll run some
> > tests later to double check):
> >
> >     if (dl_se->runtime <= 0)
> >         dl_se->dl_defer_running = 0;
> >
> > In this way:
> > - short sleep + remaining runtime > 0
> >    - dl_defer_running stays set
> >    - restart can go A->D directly
> >    - no extra defer / zero-laxity penalty
> >
> > - stop with exhausted (or negative) runtime
> >    - dl_defer_running is cleared
> >    - restart must re-establish eligibility
> >    - deferral / timer is armed again
> >    - no stale "already running" server
> 
> Yeah that looks like the neatest to me.
> Fair tasks are a bit more penalised than now but won't be if they really sleep before consuming the runtime, which I think was the whole point of this logic.

Unfortunately checking only runtime <= 0 isn't enough for the sched_ext DL
server case:

 # Runtime of EXT task (PID 2025) is 0.000000 seconds
 # Runtime of RT task (PID 2026) is 4.990000 seconds
 # EXT task got 0.00% of total runtime
 not ok 2 FAIL: EXT task got less than 4.00% of runtime

With the unconditional reset the EXT task gets 5% of the bandwidth. I'll
add some debugging to figure out exactly what is happening.

-Andrea
