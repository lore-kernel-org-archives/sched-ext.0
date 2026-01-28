Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E24352FAF
	for <sched-ext@lists.linux.dev>; Wed, 28 Jan 2026 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607713; cv=fail; b=g7kQyR+apryu1z4NE8gTgyTirHFx4uVIE723jfvItD6Vz/LOH+v69yXt9lFfNl1RZXHuD8nbJozxTMiqW56BKCSXFyVT3aN0iMjPazDzCakYtO1L3ZporXEPaj/Ukr5rNLHAD9eDzlNrsIo6vqnRjC9BA+/gBrob+swViQ6Ec+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607713; c=relaxed/simple;
	bh=Ky+5KclwblCuUUYDvo0c1JfB/hxWrjYa3EEgyCZmykk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dyNakvR3XagD70CUf4lRPOOjjGvgn4S2NbLs4mWQBeJWIKj/f8OZeM0Hzak/7prV608kpp69M0Yna/kkVfq21OnaaTs4AmYrlV+OZNjh9YLiwwprMc5ZjFczNgKdgQORZgu0GecBAA/l7PdYJYYM7Eef6OL6K6P2epRVsKbgl4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mYFUQtBq; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mYFUQtBq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rl4YCsH2xSnEC3i6ILpuhq4P9veIVFu5k0Trfvd+/dqKEEVetufiWo67gnbrKryo7SOGhgItGsm8JQBWmff86MqNqvybG9NZryvN9OBo+deguL3PxzdMjikHVRHb6Xekmi5ziYfR3D5+Tgm4KQTGfm2Pxprp1fNl5paGNpr32bsDq9PlCs1ziJsjM5KoBAfOHqx9WPLs2FPoE+WeMEjnijfbp22xeaapDnVWWfeC4cSaJmdvTYfKYMl1i3qkUCKVxuiD86HQsZ53xybfESnsQLHcAKdz0s1ZehcRfeGHjJPKoA9R3NL+i09v5KNCovThBsC45N3bCYD2M4e+te0OFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96e39KkCo5NHMfG/hjeLdxFio/XroVfOXwmG/0oc6bk=;
 b=UQDoB5b8f7DFERWv6gdCMUWSw1cadRfX/i8d6oVRbZLhqQmOHNNkonaT3MdF9gmMalW87jnO3P5mWVkE3CAqzN9oMmmOcRVVZBVWEnKklVZVtuYmsAea8VB/ABcj3ptTYXHGmBeyn7O1bFgpBIj52Kqp0zcdK8+4S5lWxKCaskv7lh5LrUzHAXs+B9jOP3iKNqHx8ZaJmdUeA4nioPd0tWib86O0ui8CUYNanXBymYzL/SNmTPXt37dk+pJNeGOMPMeHKtO11gQXtitzqBXotE0g7+FxNYs8HCClpxDv66cf5ubC1Gm+wpHXnIWzjA0uhH2zXzzP+kYS1kip76q1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96e39KkCo5NHMfG/hjeLdxFio/XroVfOXwmG/0oc6bk=;
 b=mYFUQtBq0HXjJUQShxvm30gvkE7D+SRbfBczahO6xAIaCwavJTN6xKjccNg225tyfKiWH0+rnysCBn9/fyVgF6nK315go30Ma3MuOp+fQ4mT8nZsXjdcWgpScUVdaf+Qc1fIbj8MJ/5mZzZGmycANu56FKlIKZE4hjySfnPsONUIA+3jEtQ5BknMDNi0sFa+SoyNBw9BEcPYuoIZtwE/ljf72rYMzFTiTg7GVZsKg6IG95g2t40ywR9iFxM1O+7azXlOdDOIGRzQs8RBwVi89+mfbbzqVAXRrGDv23Ipiri6IceFydx/XmFFTguOwrWvN3F5U89i4cueafpLATAXTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 13:41:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 13:41:44 +0000
Date: Wed, 28 Jan 2026 14:41:40 +0100
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
Message-ID: <aXoSFOONWJmdyCQB@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com>
 <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com>
 <aXeWnzI3ymUSm3Cu@gpd4>
 <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
 <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
X-ClientProxiedBy: ZR0P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9c1e84-2d4e-4807-eb1a-08de5e72f98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nN3krntbQWzHwhMWAq7BRmxjDxFtJcEXvgrLdH5J9ZDJ+J3P2XmAuaBxNtRM?=
 =?us-ascii?Q?jjn99Xt8yrjd5S/A/4bGlxPYuhlxrwJ5Q8R7BnVkwGAqkgOyKwSETsL1ynuA?=
 =?us-ascii?Q?w/PvtmBEZePAi13fP3jL4+7XmnUZvCylofdWR3IcSgPJDDsoE8tN4RWn+VXt?=
 =?us-ascii?Q?APNXJrLkPMV77b7KOuRRWLXp+0A979VL8LfFgdx8+inPW4R++7ppVpICdw0F?=
 =?us-ascii?Q?uHFg5+7tmkKm6kKa05QS1UXoi+pGxpUIqOlmlmxcqxRKu9hfeL9+sJobaq8M?=
 =?us-ascii?Q?UYXM/vhSP3t0pikupedNLOJX5y4kypWq3EA/quC0/PDwbr91wou1XbUxs1ec?=
 =?us-ascii?Q?sQRLwZ0Y+VOqmjKuJ6rxz9F6BsJc0JgtguKzVTahwFBa2pVPTpAMj0F0+WjW?=
 =?us-ascii?Q?6NOAwImCazvy1KF4Yn1nRvo7KOvwbt7nherlClMjufV9ly9vzWyuE0J6kcvS?=
 =?us-ascii?Q?IYgrc8DbLHd509BsshHEPgeUL6ebebejeOdZdBGAbObM0CII0ok+AMDrDQjw?=
 =?us-ascii?Q?awNoMX6dFgVPEJdw5bp2+4H02T3+SDUvtp7RSYyKoaoxkSJS3W8O6xgKBD3J?=
 =?us-ascii?Q?MYh9j9TNvKwnepo/bP0iPpX92yukiADxBPsAPV1o/nBkmhmOU5JsqGCasJgk?=
 =?us-ascii?Q?FjBLBNRmbhXlW0hioKUHWJr+hkyTqJENLXc/IhQegxxZOMIN1JihooTF3un5?=
 =?us-ascii?Q?f2fhpOTxD+Cey/tcnbRLFpdjfCNT34wuQBjedXpinOtC38iBdPbpcLiHD/YC?=
 =?us-ascii?Q?PkDi5RFXYmxcWy3310ClFgV0gdeQuilQk+Oj8UzRyKTyjmKbE2jPjaVLwpkN?=
 =?us-ascii?Q?vuoXCCl69Etg7h3IhkAshUMfSLW+EuGY227f54N55EwBZmsNC3vFMgG2BFoz?=
 =?us-ascii?Q?gN2mzix6BTmnGwL+HQ6C5/kED1Xy7nmwCr7wUxx7YA/AYZlPg+LHzglSFINk?=
 =?us-ascii?Q?3lHqeYpI36cqBBcoZV7lSofG7IX9x5W1Q01t3xIRhj0QCXhhluRZ3x7Hxjj2?=
 =?us-ascii?Q?d5wbts1VmFerkbHGXW1IVgeUYUVE9RXCYZaazEjxjZJeO1pJUYS/MkzdyxPJ?=
 =?us-ascii?Q?IGF2uoyNkWlA0U/eyGvWyk+YDhhKmfoi7Nu5ox4iN31ZoBbuUDhKFoZura9I?=
 =?us-ascii?Q?gJ08qWzXUJklvoyvDuX4OHor+vpTtOtlBTfbbm5K8XsXZBd3jIPNCTx7abDn?=
 =?us-ascii?Q?42ZqqsagUy9q9yEx/FHYT+Z9dofniwyySJBqcimgIR380HyCAPydQ4JVVQKL?=
 =?us-ascii?Q?mF0af8ziUKPEOkOLPq147ADmqfJh6K30R4o9TMfYLiIigepH4w4eNZw9i418?=
 =?us-ascii?Q?D4MOywjRIccZ1h2m5wGhraV4P+n3gaK1NXQSpPuX+3Ca29tmOCe4pTNjprsa?=
 =?us-ascii?Q?dg8G6/KYEsF9blZnsQbPJl/uf0p5l6hr67UjL7exzX9UFflLt5GylYV5fDJf?=
 =?us-ascii?Q?1GPLY8I++PAG7Er3hF950z/KhYzwFjYoqfBE1QfW2T5l2t3ETdghJQWEVIp3?=
 =?us-ascii?Q?tmoaR1rIrLtolNW9rQNZQ2nP0tQnwkH/MnhFHyr5bIizEQbRvYBeEOPnsFvS?=
 =?us-ascii?Q?d71+xi+448IQMcYWmJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/k1TJBSAjDpqev7vZSqj8W3oT2bxJYmgcQn39Qff2OFIGbzybLhd693bcTK?=
 =?us-ascii?Q?vY/P8wm/zRaCAjrNnRpO5xbbzTvP6Zk7Ipr0Z9CGir48OtXYXfsXxINO7Pso?=
 =?us-ascii?Q?MKGJt0iVlfHqwZP41vNfUT9/+O/KUxxMM+iSDbKokUHj02tpczHrZ+IT0bXc?=
 =?us-ascii?Q?edING/ryCmedV4XFonybYjmED4K7j0k62sIE3bkQw4TRuBobB10DvDrzGYBt?=
 =?us-ascii?Q?l71JiC43r3L+52ulJ1j72ny73hkbt8UVuvAbaoZhgl2rtEpHUbhJ3A4BfRw4?=
 =?us-ascii?Q?seM4pJQN+5fgg5bq707UDV1JGcidxcUdcWlaX/ryQkSt2MxjioarpktgaV5M?=
 =?us-ascii?Q?4h2Ou4xTkEL8KO6K6390xM3Qdf6igNgY7hB5/CVr/kX4zr+NI7fL6ZXRR4nE?=
 =?us-ascii?Q?sr5B0WT7LFRXdSv0jDrw+E2qiWHVvqVUMt5un6APlP8qHYaM4v3ftOmgFahB?=
 =?us-ascii?Q?vBh3DCWzZdph/wsUguEZnsR9zi6Wimis72W/YRDTDYvLwkxU4nZcHoZt8gHK?=
 =?us-ascii?Q?xh7xtvG2KbzZC0pp55IGzA0z1qZQkfp6S4vO4eMtNKVdycVqMjrLpIZDP0+t?=
 =?us-ascii?Q?77OyRv5U1xram4sKDO03S65aeYKXqZynxdxT+8gnRPa+wBNVyFbeO9nO91ci?=
 =?us-ascii?Q?hj3jdXqPqg8Ppo5FbgJ7NQoY97Qkze+RcZjmdtj6A0QgDQbOM8sb4vSrqxwU?=
 =?us-ascii?Q?TEnXfAcnTRxukzc96jJZfLvT7/+eyAOtCCXDJMGcuaROxsDgT4MGC4VN4yY3?=
 =?us-ascii?Q?GsZr0MFre8YfGtPCimUDHCGg28rSMy/nEwuUwTM/jnXLmv8LWdVIK86fbrnZ?=
 =?us-ascii?Q?EYBQvIvEy7LsYnwL+U2esyXxMhQs1KDNPMyRnskS/0aHVKsNJ3c4GUj6j7La?=
 =?us-ascii?Q?YVedD1YBU7u4Z08hN2NO5fmfRvZc4NRkdtVAiLYxUIXB0urIiLED57ZEBqYv?=
 =?us-ascii?Q?gxqW56SZ+6aHpdy58npHsjQn1CzE/SWLhygOUAZn2D/D+tzy98fV0R9yTBBD?=
 =?us-ascii?Q?UOh61cEHv1RaCUNeFVxNrT5GlU2fui0oDPovfkt2nRi6fXZUvKguzcPtDAO4?=
 =?us-ascii?Q?iw7Wg4RcV7sE0tUk/ENvn5WrjhjK7iNkV6W97BaK+iaSeUVY2y0auPw+J3cz?=
 =?us-ascii?Q?sTCSY+ST4k+GQaTAFrRl7xWLhnXCMziPfxNu9O6Q43HAVzpfUtD2NwvpBxKX?=
 =?us-ascii?Q?MxbsqjWxJOs+TnbD7nJmBTLgvS4i0137Y85dIF12TA1i2ksTgtUfDkSwGIZ+?=
 =?us-ascii?Q?LK8nIe2AzQaWeI0jKlDpgTrrBna5Xf+R/AK+8dTrdxVkwUzT4eHrvn147e4q?=
 =?us-ascii?Q?iaYdpyEPFfDd6N0HGSXAINWFaChop4WiqnZY+QUcryY+IMYVB5lAx5WCbomg?=
 =?us-ascii?Q?mwYCR+EBSqq8PcyFOKcoA8jNzZd8lwW4I2CBQt7PAJ0o4hp/terfA5HvCjIK?=
 =?us-ascii?Q?8JbDKg7lrUBatThWBQ4330p+sbnNZGblTSXUGJ1S2Yjsl1kg1NMmKiGXeJGF?=
 =?us-ascii?Q?eJ49XwfRLvNcP09KbFV9f/JoX642apYdBNTXdKNOPJLQNYqWTfHc4zha78O5?=
 =?us-ascii?Q?avyofNxNu3K3o0O9easG8kLz6cvmjBhD50NbH12ukpsj0mJKWt2/tWT+YoZa?=
 =?us-ascii?Q?gPv3745fIIuZaamjwdb/SHPQDJEsDxB48qXogaftFQs0JDZAgkpnTyNNte9p?=
 =?us-ascii?Q?a724K6KoeHQVWBWfSnSBw7XPWTysazQVgEaCV/YYdPVr2nJK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9c1e84-2d4e-4807-eb1a-08de5e72f98f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:41:44.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAaT/iLKpxLL59bFm4sX885BPdJDDnNI/6fNeMqr3m8YTer4TX7QewvpWXrNt0bXUP9OX03nQB7UBE6OnjBNoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492

On Wed, Jan 28, 2026 at 09:50:36AM +0000, Gabriele Monaco wrote:
> 2026-01-27T18:55:02Z Andrea Righi <arighi@nvidia.com>:
> > Unfortunately checking only runtime <= 0 isn't enough for the sched_ext DL
> > server case:
> >
> > # Runtime of EXT task (PID 2025) is 0.000000 seconds
> > # Runtime of RT task (PID 2026) is 4.990000 seconds
> > # EXT task got 0.00% of total runtime
> > not ok 2 FAIL: EXT task got less than 4.00% of runtime
> >
> > With the unconditional reset the EXT task gets 5% of the bandwidth. I'll
> > add some debugging to figure out exactly what is happening.
> 
> Thanks for testing it. That's quite strange..
> 
> I run your test on a kernel without ext server, as far as I understand, the test is kinda indirectly checking also the fair server and that does not fail, right?
> At least that's what I get on an arm64 machine with 128 CPUs.

That's right, withtout the ext server, the EXT task is supposed to starve.

And yes, the test is also checking the fair server, just to make sure we're
not breaking anything in fair while we're loading / unloading the BPF
scheduler.

> 
> After letting the test continue on failure I get:
> 
> # # Runtime of FAIR task (PID 22503) is 0.240000 seconds
> # # Runtime of RT task (PID 22504) is 4.750000 seconds
> # # FAIR task got 4.81% of total runtime
> # ok 1 PASS: FAIR task got more than 4.00% of runtime
> # TAP version 13
> # 1..1
> # # Runtime of EXT task (PID 22511) is 0.020000 seconds
> # # Runtime of RT task (PID 22512) is 4.970000 seconds
> # # EXT task got 0.40% of total runtime
> # not ok 2 FAIL: EXT task got less than 4.00% of runtime
> # TAP version 13
> # 1..1
> # # Runtime of FAIR task (PID 22518) is 0.240000 seconds
> # # Runtime of RT task (PID 22519) is 4.750000 seconds
> # # FAIR task got 4.81% of total runtime
> # ok 3 PASS: FAIR task got more than 4.00% of runtime
> # TAP version 13
> # 1..1
> # # Runtime of EXT task (PID 22525) is 0.000000 seconds
> # # Runtime of RT task (PID 22526) is 4.990000 seconds
> # # EXT task got 0.00% of total runtime
> # not ok 4 FAIL: EXT task got less than 4.00% of runtime
> # ok 24 rt_stall #
> 
> Mind that it's expected for the ext task to starve (I didn't apply the patches enabling the server).

Correct, this makes sense.

> 
> After adding all your patches [1], also the ext passes the test (i.e. gets boosted just fine).
> 
> I tried disabling all CPUs but CPU0 and run the same test and it hung (bad sign), then I also enabled CPU1 (total 2 CPUs online) and again I see both fair and ext getting their share.
> 
> What am I missing here?

With the ext server patchset [1], without resetting dl_defer_running in
dl_server_stop() I get this:

$ sudo ./runner -t rt_stall
===== START =====
TEST: rt_stall
DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
OUTPUT:
TAP version 13
1..1
# Runtime of FAIR task (PID 1993) is 0.250000 seconds
# Runtime of RT task (PID 1994) is 4.740000 seconds
# FAIR task got 5.01% of total runtime
ok 1 PASS: FAIR task got more than 4.00% of runtime
[   28.494515] sched_ext: BPF scheduler "rt_stall" enabled
TAP version 13
1..1
# Runtime of EXT task (PID 1996) is 0.240000 seconds
# Runtime of RT task (PID 1997) is 4.740000 seconds
# EXT task got 4.82% of total runtime
ok 2 PASS: EXT task got more than 4.00% of runtime
[   33.538466] sched_ext: BPF scheduler "rt_stall" disabled (unregistered from user space)
TAP version 13
1..1
# Runtime of FAIR task (PID 1999) is 0.000000 seconds
# Runtime of RT task (PID 2000) is 4.990000 seconds
# FAIR task got 0.00% of total runtime
not ok 3 FAIL: FAIR task got less than 4.00% of runtime
# Planned tests != run tests (1 != 3)
# Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0

The fair server works, ext server works, but once the ext server is
unloaded, the fair server is broken.

If I apply the fix to reset dl_defer_running in dl_server_stop() on top of
[1], the test is passing:

$ sudo ./runner -t rt_stall
===== START =====
TEST: rt_stall
DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
OUTPUT:
TAP version 13
1..1
# Runtime of FAIR task (PID 1965) is 0.240000 seconds
# Runtime of RT task (PID 1966) is 4.740000 seconds
# FAIR task got 4.82% of total runtime
ok 1 PASS: FAIR task got more than 4.00% of runtime
[   25.307989] sched_ext: BPF scheduler "rt_stall" enabled
TAP version 13
1..1
[   26.257788] hrtimer: interrupt took 112519 ns
# Runtime of EXT task (PID 1968) is 0.250000 seconds
# Runtime of RT task (PID 1969) is 4.750000 seconds
# EXT task got 5.00% of total runtime
ok 2 PASS: EXT task got more than 4.00% of runtime
[   30.344700] sched_ext: BPF scheduler "rt_stall" disabled (unregistered from user space)
TAP version 13
1..1
# Runtime of FAIR task (PID 1971) is 0.250000 seconds
# Runtime of RT task (PID 1972) is 4.750000 seconds
# FAIR task got 5.00% of total runtime
ok 3 PASS: FAIR task got more than 4.00% of runtime
[   35.373585] sched_ext: BPF scheduler "rt_stall" enabled
TAP version 13
1..1
# Runtime of EXT task (PID 1975) is 0.240000 seconds
# Runtime of RT task (PID 1976) is 4.740000 seconds
# EXT task got 4.82% of total runtime
ok 4 PASS: EXT task got more than 4.00% of runtime
[   40.403697] sched_ext: BPF scheduler "rt_stall" disabled (unregistered from user space)
ok 1 rt_stall #
=====  END  =====


=============================

RESULTS:

PASSED:  1
SKIPPED: 0
FAILED:  0

> 
> Thanks,
> Gabriele
> 
> [1] - https://lore.kernel.org/lkml/20260126100050.3854740-1-arighi@nvidia.com
> 

Just to make sure we're testing the same thing, I'm currently using
https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git, branch
scx-dl-server.

I'm running this test inside virtme-ng:
  $ vng -vb --config tools/testing/selftests/sched_ext/config
  $ vng -v -- tools/testing/selftests/sched_ext/runner -t rt_stall

Thanks,
-Andrea
