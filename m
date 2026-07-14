Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3028381B01
	for <sched-ext@lists.linux.dev>; Tue, 14 Jul 2026 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009913; cv=fail; b=kLC9vkX504Gwun2S9YWpNn5igN/bgLHGIcz0xzWHRH8tRuPWu3ZF0SRyBHHQ5FYuQJttQCBZ6RtIrtgI7KghilXu5pDxgtTvzwPcot6p420M88A10JGS7mhP3jNbhx1qD1dulcDL41ouoBgbm1V1EfSJH0NzAm567CfatbYGXoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009913; c=relaxed/simple;
	bh=R2oHqhf6jANKgWwBO3qkUy8qW70gBFd/4Njj3L43Mgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p+gnk6Vje5Yq14NGPuORs08X1fEhIRZWy1uENA8MKHSMp/EwFvQXMxhqBV2rj0JPx+1MLIlQhW6Lkq4PXrELZLb4ge6mFofTINYDjLaAKNzj53S37BeN/f+J3nfaf1+zyYdW1Xvw3+C6T+R6Fcb44iaCGNnRIlaXw8lOS70JxWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KbtpeuVu; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KbtpeuVu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bevEque5/dqg5fkJ/zUUO9B5V6QKMuUFhOeGrY809rAtwHUyoCE8Fo/85OvthhaEl2L85G15fdqawiEGji/DXNjB25u8npcm0Qf29P8wmjvCCC4Z1velcDawhRVTimZyELqf5JwVxIYmfk6TlkbPPDk8NChK5V4Kvvih2oBfTRq2zjUncca3DgEEyu47cilPhWShUMbkt2BX96CACic30GmVvkP4Hzv4zptxH72oXQVZin09pj/gANiSyNtr0wUg+KZgnO9/215pn06hIb55agMzOqnxla1Hdz7KmwC4kG5hZWVuvPjO76FGsq9TdSLvUk/MLJqR2Aao7eXlu2/kYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAk36lMMHOMOuxXfUJi6NvSDkXvxCWeyUX+bNbNmvT8=;
 b=prn1S4TWGm16Ku3drFNxYwwi2hO3hBbY6k0rq6VhkXOSVRXhJKxwysZsigJdHXsFlNuEF0a7AB6u99tvRCFQSbEyFFjU3zfCratbPdQj4PhVWFwYzEigKxEIDQTu7LzoS8Rq3eK74516JRMHCJUJXuhJagPt+ldwxA26WDrctzRZ7X/UKvskYvedBosUrhT4VTNOSIvtnAaVeSe8RDK1aWoVXyCnJ5jNYk2XftWHsGTLYuliUHbrphX2y1XsMGEoFjOEXM6nfVVqfcY/QqdV/N6iMCR2vIrBawb9lU2BQltYsvuXSrNXzhRCnP82h5mt8H8itW7NIOO4vWz6zqFqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAk36lMMHOMOuxXfUJi6NvSDkXvxCWeyUX+bNbNmvT8=;
 b=KbtpeuVuJfOToAO39pdlZbI5XVMmJ8cAOUSp4UIDCIsAfBCVYCi8miceZJgq4zi+rdOk/EqmyI956Hrh7APGqP30VFtYMyWsdZZCwCbR4SzwArNJRiAiHb/ctDhYJdKAcXDHedOieWKGn4Ch4LlhRT70HjcA2KjBoUIr352eIMzHdntGvbjIMWpZgrQ1NNXqO7hbbu/hA73FjbKuu3JWA4Yt/X/osVWdnv1dlPLUUz68hlHq8rmpFUo6gx+qjU3N3dINfFxmcXAVeQsTS6QsOnPy4KUxp6PRuAgWnzd3lPPXbu8VqjcPRdoOa4y7R2cMuDJXTH19sMB3GXMGRiap2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 06:18:28 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 06:18:28 +0000
Date: Tue, 14 Jul 2026 08:18:20 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 sched_ext/for-7.3 28/33] sched_ext: Route
 ops.update_idle() to sub-schedulers and re-notify owed scheds
Message-ID: <alXUrLY3WMdAyXIc@gpd4>
References: <20260709225041.1695495-1-tj@kernel.org>
 <20260709225041.1695495-29-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709225041.1695495-29-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: df1cce8a-dddd-446e-f488-08dee16fb85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|5023799004|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UKgPYmoNIZPHBUpP4v+zzlxgmuxrLSxGwUXWYCy/a6u56qVYfO66WnMJ9EogZYlXU18NdxDDoYph/2owoA5ePBbCmuYYoCEUCeRDef36sPga8fHAhUtkFPm5flOa1O706F/IgbZTM9Ea52hK3NK7vJDssnM3NM8owa4DDi4fCPbT+p7rTOs3YomzI9pM+nDImnJ9uHnkAXn0McH4UAQEuJA712hkQOxTEVwJPJg8KCpiD2Qo/qT5S+Ax7YmJUeTrabeaQKj8QjSPd18z9+k9bK7Wow+fL1q4xZEw61XU7JMIRPFvFINpiRNJXx6FWAK6p4uAQkMICJY1+rHjlx7iR3l8WYjmt0V1UeX/NKqI1LNJjBfydCBMi2XmvvGZ7Ll3ndn0vNkMNNoZX5NJnOXK3YrSOIhohuj+qyepPgajUwCNQ1afuJNSmXpk4m33FiPRIsCGd2DZhvNHqpdhabtP5ZvUClwrSZnEQL14K1tctnlVBZ9TxgYGHBCAzqYyH9fvcPGTNMOHnHE11rDFup+nzD6vpR9T99+j6MIaD/8wVIfVlH0Dnaa5ewAxGDYbFBKtaKBxlMEVhFeMxiLHP7w5GGJTlgRsGFavtq8O+7ZQAyvWjtP4Vki94QCq2NQVhOAAq4WAWlUsXtFUFotP7mXmcMC+w0RHFFWBpTe5JD7qNyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(5023799004)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kzO9nsn3hrvDinneL1RWJzpEsZnSXGjhFA1q9rtQfUMfzVkY9cQpP5BDlQpC?=
 =?us-ascii?Q?rcprc53+n74oZhyAjWJ7zvM3bhefquT3H1UFIsfHitw5+5/HrzukTR+cZSpT?=
 =?us-ascii?Q?MWPFR129pfw08zLmhJneHfMQBKKe4xt86KA10hS1wh7BI3sVbvTpbhqkMf+z?=
 =?us-ascii?Q?agec11p7OXnbH4ffAfYrq18ElbCWmgZvCaR+rLJUGQ+TcD9pYJzlPOQ5DWNh?=
 =?us-ascii?Q?nSCKgIQzXk3quoRsL4rlWDJi7ojHeFSwjuwz6klb2rZbJpTSwxh9vwaa56nw?=
 =?us-ascii?Q?RWOxCQKADULEETaKWgilBy2wv+YL4VRIQ08f1PZ6zc5upkC/sF3lJKOququl?=
 =?us-ascii?Q?L0wfOc1e3HHFRvAl8rvE5wT6WIm+XrwMxuJGP8sn+7ZAD1LcZyYvyc1ZSCB8?=
 =?us-ascii?Q?Cb0GguSiZuE8YBPDf5JxbkAxWlVSMt1FJg+3Wm2C+P158OWbMWpHK1bz7YZC?=
 =?us-ascii?Q?fc1PqJHOAtsEDgkcFAHdg05nJ2fc6D9LjERYO9RcpNbECueuSvBRAAM+O+a/?=
 =?us-ascii?Q?hiBSj2gdBeeyvz3sVrANwUjpcS/8IwasycdTse6xqimkU4YZ4qy4423BwcWT?=
 =?us-ascii?Q?yTGuQaFx+kLV7dRCq+Aaok0xbd9JBgG9swpL1v8oD8YcHPI802AMaTjL+0q6?=
 =?us-ascii?Q?WYx5I9YwNUJ93E8ZemgF+wSOxB1meyDYFAsO43DT3WnUC+vjIV474rxWSZR/?=
 =?us-ascii?Q?JW/4S52XWjJ/fDC2Pd77hIBvgs2j3Saif1L3PId9LaYv3+wf9modj8b9Oe1C?=
 =?us-ascii?Q?OhQ8vXo7xTZHfHAEBJ8JENeuZah8g+M2Oiw3Fq+lHC6ohHoSSlVsPX5adNBZ?=
 =?us-ascii?Q?E4x9r3vU/RLePO3Jvu56dZQDcdhXXrW0dN1eyQquFOpZwk40GzUDHvvY9uma?=
 =?us-ascii?Q?xhWLpyw8QFFXTm4Nut2MMp4mtT+A0bwsSIjDPj26FdpGkbi9tGvkzIQVxCqo?=
 =?us-ascii?Q?qoms1GuTlvYL2weARwDkZfebjn8ucNhgxx/L5ay9jb8j/ohwhyo6+OBqs+dY?=
 =?us-ascii?Q?oudUWfBtFYDftaIBJnA/h53LEw3XS//O3JHVGuJhoT1K7Qry20QsCsMAGvJo?=
 =?us-ascii?Q?6zrUxswHv+jjBUSYNt07miMUMAFRIXG3kAgG97uWSxTT0h6KzgTFh1Cl01Eb?=
 =?us-ascii?Q?N1xwWZURnbH30mHMrAcJvcab8XvYh+/n/V5AbNCrfyTZ8S2Ey+MutZ3o5x52?=
 =?us-ascii?Q?mAMEMMMSQJAKNDoavVscL4mxpW1Wzarw78H/LkYjSb/1vMNyGnclgn14VSZi?=
 =?us-ascii?Q?e/Z3dy7N1UKAzWdWRnq2ynw9KsfqzfclldcTQRQSb53yw9XBmwW7ojuNjun6?=
 =?us-ascii?Q?V4REAIiUzzbEj9WmbVujrRFq8Rd2LMDJcIjna+05aRgRRe2Lb+IiFycdSYMM?=
 =?us-ascii?Q?ciu76p1ZMWZV+2Sed6I7yln4WoXknWyglEyQLC167Coi0Ek4g3ljJLeWgyXU?=
 =?us-ascii?Q?Pw9tbfY9SVpKlBXd4gAtbEewfS1m3faOUxeRIdB6iK+wy8bsMQx4raGbgnT3?=
 =?us-ascii?Q?qWn6yB9IwRj4pNnVwXHaXlBxDqwtS1sVV3ObE+ucdf8f54bCkXBZvs55wgbo?=
 =?us-ascii?Q?tS1wtcB0qRlqJdb8X5url+tSx8QDjrm0FWaItkE+NfJD7ngLtzRP1fGUmrkc?=
 =?us-ascii?Q?loefIwOO/pfw4g16p8cbClLzbPcPTfO9bRk3cktsklQFnFFnv8sWFP4VZYmH?=
 =?us-ascii?Q?CspXEIYoDLpJi+DKZ3rd5Uo2zeq6WWFj2Jqbn6tPJ89+bSjVseDo500WpdGI?=
 =?us-ascii?Q?uz6MN8rWcg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1cce8a-dddd-446e-f488-08dee16fb85c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:18:28.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDQLPTskPE5UXH9Vetr9pd3W9wwVfXWnJxEm1OEtAkv7tfn8OwrI22RQebY8XYt2qJ9reFWyip8VYETEOs25YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

Hi Tejun,

On Thu, Jul 09, 2026 at 12:50:36PM -1000, Tejun Heo wrote:
> __scx_update_idle() notified only the root scheduler. A sub-scheduler that
> holds a cid needs that cid's idle state to place and kick on it.
> 
> Deliver ops.update_idle() to every scheduler that holds SCX_CAP_BASE on the
> transitioning cid. The root holds every cap, so a real transition always
> reaches it.
> 
> Real transitions are not enough on their own. A cid that is already idle
> when a sub-sched gains baseline access produces no transition, so the new
> holder would never learn it is idle. The ecaps sync arms a re-notify on the
> gain, and the next idle pick delivers ops.update_idle() to just that sched,
> leaving holders that already track the cpu untouched. A matching loss of
> baseline access drops any pending re-notify.
> 
> Bypass suppresses ops.update_idle() too, so a cpu that goes idle during a
> bypass window and stays idle yields no transition to re-deliver on
> un-bypass. Arm the same re-notify for every sched leaving bypass. The acute
> case is a child granted cids during its own ops.sub_attach(). The grant
> lands while the child is bypassed and the notify walk skips it, so on
> un-bypass it holds cids it never saw go idle. The root is owed the same and
> is armed through a separate per-rq flag, which keeps this working when
> sub-schedulers are compiled out.
> 
> v2: Gate the idle catch-up in pick_task_idle() to avoid a double ops.update_idle(). (sashiko AI)
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> +/*
> + * Notify schedulers of an idle transition on @cpu's cid, delivering to every
> + * sched that holds %SCX_CAP_BASE on the cid (the root holds every cap). A real
> + * transition (@do_notify) reaches all holders. A forced one (@root_renotify for
> + * the root, a sub-sched's idle_renotify marker for a sub) reaches only the owed
> + * scheds.
> + */
> +static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bool root_renotify)
> +{
> +	s32 cpu = cpu_of(rq);
> +	s32 cid = scx_cpu_arg(cpu);
> +	struct scx_sched *pos;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	pos = scx_next_descendant_pre(NULL, scx_root);
> +	while (pos) {
> +		bool forced = false;
> +
> +		if (unlikely(scx_missing_caps(pos, cpu, SCX_CAP_BASE))) {
> +			pos = scx_skip_subtree_pre(pos, scx_root);
> +			continue;
> +		}
> +
> +		if (pos == scx_root) {
> +			forced = root_renotify;
> +		}
> +#ifdef CONFIG_EXT_SUB_SCHED
> +		else if (per_cpu_ptr(pos->pcpu, cpu)->idle_renotify) {
> +			per_cpu_ptr(pos->pcpu, cpu)->idle_renotify = false;
> +			forced = true;
> +		}
> +#endif
> +		if ((do_notify || forced) && SCX_HAS_OP(pos, update_idle) &&
> +		    !scx_bypassing(pos, cpu))
> +			SCX_CALL_OP(pos, update_idle, rq, cid, idle);
> +		pos = scx_next_descendant_pre(pos, scx_root);
> +	}
> +}

So, this makes every real idle/busy transition walk the whole scheduler
hierarchy and potentially invoke ops.update_idle() for every cap-holding
scheduler while the rq lock is held and IRQs are disabled?

This becomes O(number of cap-holding schedulers) BPF callbacks per idle
transition.

I haven't benchmarked this, so I'm not sure if it's a valid performance concern.
We don't have to fix this now, it can be a future improvement. In that case, if
we prove that we have a real bottleneck here, would it make sense to maintain a
per-rq list of schedulers that both hold effective SCX_CAP_BASE and implement
ops.update_idle()?

Also, for the root-only case, would it be worth keeping the old direct
ops.update_idle() path behind a static key which is enabled while any
sub-scheduler is attached?

Thanks,
-Andrea
