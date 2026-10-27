Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793099671;
	b=KdcorIgP+Pb5V2M1PM4Z0dr5x3T85ozlRCsh33CqHc0DtXUzkvO9BRIhFtCkDg22u/gw
	 ysK6iYmjgedLqgwG8HfofE29KnSddOyGZWFbKtkU8iER7vstDixNFI7MC5yrbnTU1Rwl/
	 Nhj8cev0F5I/nIph3CG/CDg0un6jFlD/4g2uoFdeAdrXqoYJKtykdIUwJ8//QN+YFIhpj
	 gfulZ5Yw/15geH3AOh8BTgOUFjw6se68+zAxpG+9VsqF6nCzx0ue6kzpEUgr9vceMoo83
	 UrQzsC6Qm5sUUTTdxwkNouz2+zbBzZQhIHOC1BtB4tEkpyRDIQCgeZ7OXKQSXnW5Dgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099671;
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
	bh=9Ck7M9+Rf5J+KjSO0ShmDw/cwwXbJu6SVxwBIqtqHdQ=;
	b=zInXUwqHon4Qa640PF6PEB95E6h+ubqGHkpw39HjLdMqLryCnGq2G5sMfGqBVKaOscTT
	 Rb84GNhKxMFTBoaOa2wb1JRtnishS/uQN2y6Rw/FnGv9dCWYqVGHlSoYjEvyaLMQ37pHI
	 2qp1uqARfUDIyN/t2OB3H+P2lX45VdhOprgBrL2eNA+0tY59mXjNLDlg9wzY7FX5Sep1t
	 H5ss1TNgFhCM165fqPoMXUPK5T0T9Nm0RsczZHl18pYvTR+QYtvRT5pMJDruLaQvj2RSw
	 EA70s3q0NCpOXWkpk4nLqq/ieNCSzZ6cVXkYfoOErxMiaDT4ItljB8Ks5vVoZ8uSkqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WGtd4i3b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.8
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E9606A31B
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 11:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF9E9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WGtd4i3b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meChHRo8rwvy4etwolVbZG4QLdQsNoVMezqbSzKOuAG750vZUbR0/Bhlt1Dm4wZLa2ungNM2kOxkMONsAPkXYwxIo3dheYgNBjkbvog0Dr6yFzut8oOt9oQrwk5I1vnSv9aC62k70+gGx0Bd5ESK4NDr8ODkZlA3Nka72Q9SfMQm2qv52a5TZnQ8Obm6LTJlhT5hKEc1iJak7dqKcBV8g81R/b/Ok44xIMjFSh+1jcAIXq/uSLTnDXU34j4VFx9nbY/qvShyzmW5cn8bq9nlH9MHHn/8NTC15TLKGA+XdDGtXWe3jGL5X0rZuhReepgC7Z/Xx7uCg0+P9LM/mbPMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ck7M9+Rf5J+KjSO0ShmDw/cwwXbJu6SVxwBIqtqHdQ=;
 b=Pshrb3hBnrAblNnzfKHHkwCsAK7EPcBzNb/sAPeRgkf1tu5Hgcyx0WEC1sd52FTEadyR4XFSyDV+zOja/4qa7rYko8lqOZl8QWxEInwZzZfmPUIIy4O1VJ9Yw2Q3QpamTJU+haaHBD12xQYz57Ci8TRLouEluM3IfZ+JLy785v9G8Q+INUf8ehfJP8OoJtxgl0RLQ+IsnL4uHKU4zi14NxkiH49i8v4dSM/Xm2sSnn9sJhYNobVOGpnoYiTUcUlRbK4SyR9XL4yGdewoZpBhEY0ZBuWa3OjWs1+JjHFRr74xRFZtJ3onKGiL+nYH4VofbwE5rsE4oitjsawrEzReoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ck7M9+Rf5J+KjSO0ShmDw/cwwXbJu6SVxwBIqtqHdQ=;
 b=WGtd4i3bB7mTipppVNzODFptOwY9+EfOUAJcuZlrIsB0r5vIjQSq+/rbJY8RZ8Eb9TQZyuuhoYWVcy2jm3ULhc0UpS9WPzJ/QGJAhwLRmMABHCQQ3PAYcgHPsITgb0USLrgOcNt5wfji1kRs1MPLcLcVL0+n5CTVEQhob5UPXjT09wz2wnbxZf692VxgrQ1FjMSW+bln6UpeQUGKjW2Z3Y6JlXHgwm2XcnWtiilgMg3S/VUkKyh6F0Cbqck69Kk0Nmtz4T4wGDpBMDNVA57WuP40uQRyhaEo9X+F/BKOQzvO52zasDzfA18VWeOU9pDjgBplH8Fui3/jsKfiuAqdVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:14:26 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:14:26 +0000
Date: Tue, 27 Oct 2026 12:14:19 +0100
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
Subject: Re: [PATCH 4/6] sched_ext: Report preferred NUMA nodes through
 ops.set_numa_node()
Message-ID: <auCHiyIYb-9FqaPF@gpd4>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-5-arighi@nvidia.com>
 <20261027104901.GD2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027104901.GD2668564@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI3PEPF00004E98.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::448) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: bd694ae2-a552-4fa2-e623-08df341b765c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|261022075727099003|261026140227099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261021121427099003|10067099003|18002099003|22082099003|261026121527099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	26Mnzx6MOVTKhlKCkaH82n05ZYyrZ7H+4XpirSbb5ISHREDugQi+G9wGrIjGdO4tKnsLWLOYHyiQRM8mUTgUfv9OirOnZsVUyp7B9hvAP25GiyvtSuLr4BUJy/TBuDqI1H6P/IvUIavHnfjVuAAzFQ4QuiQXJiuQxks8+pX8lgg3zFBY/9VGO8mgNHj9egfx8UCT7zpo4zPxRH2IdXlQHqkUXhi3Shf9HS3eSi6wLM5jHo22abNHtfPMVMgHw2Vu4QPwAip2beeKHKw5voJd7hIetL8Z+r+/bGSkZJ1Nq5Gqw/hqzS+jmhjA9duIIdS5foGSCP8+/beFzTowzTGxGh7rCZ4HIoqc6vsessrstR08grBrdaWkONIh2BjgN15PwAT9BUA2QRquc0a4sKtluDkZNBNm5qv0D5ibPjTyKQoZxLZT+ChtcrD0VA1fj5QOOWOU7mf1GAgm3TvXt90+To8uuaQ7WPEWfVa3LL2+IS35nLoY49WTtkJ+Fib+8iCwyrOTMUYmI0CVMTUazNumguZqfmINg9aOyMOaTyLnuPt01oGVBW7eeumhtzd3+7wnp+cfMInuSiKPtKr5HggOm9ZoCotWieF7LOjHBXw+5Jj6BtNl2zPAleitMEZs8KOB5NF17+Z5EBqx/iNTgKMa09w1Cu/Q4j5WGimgV8aTBm4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(261022075727099003)(261026140227099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(261026121527099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+rvCKuxOvmOn5z9HXusgd9jb/Jys1iVKd0biOxXMvlE77ivpKC/ljaMWQLZ?=
 =?us-ascii?Q?hexjs7ehkp4jq0LsOqXO+mFwptJKKvebbkpxSyxtFWRTDD+DqeALqx7DjCfX?=
 =?us-ascii?Q?ybjn9fIB8WWTKwUDCu2jyf4NzQkJeWWjl/fxF0TowyYFLc1Ml3pZ5XSzbiii?=
 =?us-ascii?Q?eDoKYY8aSKEj9vAsWfS6ojiwOkbc0cfjBZ6F5BIGaMM/6WtXzIPe+AI4OAyy?=
 =?us-ascii?Q?tROhdbsy45sQKEXQGCAjOFEjHZGgkE+RVtAM1MuRbt/2unb8XxD1VyUDvqwR?=
 =?us-ascii?Q?MZkiqtZ09smmQfptaGGvsLLATzkqJCoG73leTTx834yERn4e7RQQVJ5mopjl?=
 =?us-ascii?Q?4akXbYKp6zRsTxoSSkdAsDypKiABKP91blm2yesRjO66NNTkLmPzGdzpj9yy?=
 =?us-ascii?Q?ZUFacHjOOfiZDTyJRqYpYFLrPI9bFqjjdP8Hm+C3l+Xekj7h2rE2wEuk64nM?=
 =?us-ascii?Q?8gXAvX728NM114Bo937jWYBtjhjsQYzW0fZjYcUdELRdF/eZVPdQ91jQiaNd?=
 =?us-ascii?Q?gY3t+AGC9dj5IcZj9z0xxlnZ+jE2GY2wmJBSrta2Yuv1unjK/vcguZZFqBQj?=
 =?us-ascii?Q?NKE95gqSl4n7MtOYRt7EBCgP+jOSVulHW+m5rfHd7E/aTC+ireK/qzbCaGCf?=
 =?us-ascii?Q?mAvwpPTKDPwakznRIXBG3xr9Lo6h3cwqCrHGYk5wiSjVvs+l01VclxWEV633?=
 =?us-ascii?Q?3rHaq1P7CHa4EfKBzA9aODsb1WFuRf7y7aK7syZn757Gzl9SV9PD8lmvIxMN?=
 =?us-ascii?Q?KHsnp2I5cdQIEjEAxxFjhlTRRCoic4ECvQDFxAjK+NgeGQSBrDVnwktuNQd0?=
 =?us-ascii?Q?LydhwA4NQm3bZrfTROVBLQTI9gXDsfaKma6C93tJucPgGaekHR+shdFidhZl?=
 =?us-ascii?Q?wmx2eKojp4NCmNfiUNpEhh1xUim1jRoL3EHc2kFENLGu7Ms24fsxonj5StBT?=
 =?us-ascii?Q?M4oekTFU1gvV3pmtpiwECEprl53tQoDQU/v+eWpiTDgpDx7H3StSJd6jKD8I?=
 =?us-ascii?Q?lbiCZ5sAHOS1cHUt/1CJsTflX+ag6whsa0v9r2C8Y+eFCjARMn9nx+6je58E?=
 =?us-ascii?Q?S/ZUuA0hSqYjoKxdWoCC0AjZBP5ckrT6Bu5n4mTajQvXLq8Yfdu5NBPTV85e?=
 =?us-ascii?Q?s153QhyDgT158Tuu8+H0t8gyaCysqbocm2DbFFRtZ/wQaQSOWLiN8u5iX+TR?=
 =?us-ascii?Q?NEEHsr9cGsa+b5XvLJeNJ0lJ1qe0RJQqhD3E6M6CWPgZJagIXDNyDwIA91BD?=
 =?us-ascii?Q?YedVbR18pe8ZwI01tGplHPrwspU1Wfv6seZkBzb1Y6zJ5RjIwNXiARc7ldcj?=
 =?us-ascii?Q?GUy55hUD7bf6dTEJ3NyWaFfsTzinlUYoUCLs8jAMl9c1r9nG1YsXSL76FoxN?=
 =?us-ascii?Q?Ki95Mxs6qNBRZowFZhyqtSs5ElJzXrll8Lx9lU+p0qA4qdN8KVYOSnkuuTIx?=
 =?us-ascii?Q?nX+K4huW49nwViFD53AMMwr97XawUcL0xdgYuW8L76GWwePZKHGGYD7kqPWE?=
 =?us-ascii?Q?yJV3fEcGbUPlv15vTzFR30DIdjd8AN5wL9kur+zGF80rjSSqXGx2hBnOlW5P?=
 =?us-ascii?Q?Uu3cmKE4B7gMXEpDAQnunTUpgo5MpqBRhbD3sTbmG+/cfnY6BKhRfcNrdrgU?=
 =?us-ascii?Q?bGobyF1Cixjpmbv/x/QXWrGgfRUoBxr1grCfKkWQlz+er3A4ZMipNHTwqRQF?=
 =?us-ascii?Q?/tnSpdRuaTyrEQX395yy/bif+3U8EdmMj46xYc8RSAaVRPvtBDbEputl/AeV?=
 =?us-ascii?Q?+Al6Osp0Pw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd694ae2-a552-4fa2-e623-08df341b765c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:14:26.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQx0N2eEgFZ5jOEGHNJwZ+1i4hh1WVGQfkXFCG/yyK8wH1uzp3BIEVeCypZObHmAFgda9lm5gjovDri2t7T2UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642

On Tue, Oct 27, 2026 at 11:49:01AM +0100, Peter Zijlstra wrote:
> On Tue, Oct 27, 2026 at 05:13:33AM +0100, Andrea Righi wrote:
> 
> > @@ -4528,6 +4543,15 @@ static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
> >  
> >  	if (SCX_HAS_OP(sch, set_weight))
> >  		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
> > +
> > +	if (SCX_HAS_OP(sch, set_numa_node)) {
> > +		s32 nid = NUMA_NO_NODE;
> > +
> > +#ifdef CONFIG_NUMA_BALANCING
> > +		nid = p->numa_preferred_nid;
> > +#endif
> > +		SCX_CALL_OP_TASK(sch, set_numa_node, rq, p, nid);
> > +	}
> >  }
> >  
> >  void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
> > @@ -4834,6 +4858,20 @@ void sched_ext_dead(struct task_struct *p)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_NUMA_BALANCING
> > +static void numa_node_changed_scx(struct rq *rq, struct task_struct *p, int nid)
> > +{
> > +	struct scx_sched *sch = scx_task_sched(p);
> > +
> > +	if (task_dead_and_done(p) ||
> > +	    scx_get_task_state(p) != SCX_TASK_ENABLED)
> > +		return;
> > +
> > +	if (SCX_HAS_OP(sch, set_numa_node))
> > +		SCX_CALL_OP_TASK(sch, set_numa_node, rq, p, nid);
> > +}
> > +#endif
> 
> I dont get this; why are you calling set_numa_mode() on enable? The
> signal was sched_setnuma(), but now you're doing more.
> 
> Should not the existing enable method check p->numa_preferred_nid rather
> than injecting this weird extra call?

This follows what sched_ext already does with the other "set" callbacks:
ops.set_weight() and ops.set_cpumask() are also invoked at enable with
the initial value, right after ops.enable(), so that a BPF scheduler can
track that property in a single callback, instead of reading the initial
value in ops.enable() and then tracking the changes in a separate
callback.

That said, ops.enable() can also read the initial value directly with
scx_bpf_task_numa_nid() (introduced in patch 5), so if we think it's
cleaner I can drop the call at enable and document that ops.enable()
should do that.

Thanks,
-Andrea
