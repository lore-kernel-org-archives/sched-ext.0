Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB433554C
	for <sched-ext@lists.linux.dev>; Tue, 17 Feb 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329090; cv=fail; b=Mq3NYS9Xtx2JEaFArJfXouaTTKmjoYzK+INGvjD1rL79k5I3bTQh1vi/G5yyw2e5zZgfeblobt9/AfjeTpMkgmlIA1dNUBq5nOAHLiOIWZRlIT9MHDCn1w0G09fBHj7KkJNdEYjSOec57Bmaym5Jnx0Ud787oZupJREJVnEzFak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329090; c=relaxed/simple;
	bh=sraXlWrpxRI3vhSpFSeOwjGzjzAFcwlB9Cik9PE25DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PK+wyIQHYSEctktwQXnc855zBGsW4sqkVP7UjCL/mq0xD+xWhg3ZlvbsL5vBVF4WWqsxsEroTr5f1iu6aIa4Lm2nzRuI5ay5yoFhAF0B3jSPzjh4ceH1fzL+TVid1qa06TY5L4/iZaQpE4vOBefGmVKEOUk6QORB9GA9LQmFkr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kikeDcuv; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kikeDcuv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abwNeChCvU9aAi2hzhRIW65GPPwcAoS/FC4ANSQD6Q5s3br9pu6hdA97SqcuhsHI3ox17dtclPwfC+uw2ztwfLvFtXF+oIDCWdfUnryZ9S9gePNpLFKMv37RCo2VYALPmzZVOaWhEqxy9+mjHv0vH+Sgm1xyZz0e/Y2leKa6lHpeDOrqjzfAzJsF8OOygihOcM42xidUHl38PftG+4XeL8zuj+aoOSXKghxuq4jnxVozoERcBbbsbyxj/hlwSpia23cF+b0S4RU6yESLbLhy7t4xBGU+t2r8x1PxCmOWO8EocsM8tMhcKarqzD5WTaVu6FNRM4/4ZPXWcBD2wClZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpQNdfqGsFqOUpkAjZLKAxnhCK0tv5VarZ+3nTWdsZ0=;
 b=hIPEiSH1pCq36dU05hiSQ+urm/gdQETtvhPFchfm+vlZPHkS9AwMO/6hkCq090/vXlijo8lwfEr7PuHDORSsWJW8udy79+0aSGtq+kOVEoMju28ay9erCZ07nEtYhmbs1vIi1aacwWxiHOzkUSWejlWIk3IJ6p3gXQ3FWTd/S+aWKoeFMd67ZLEJc2oGSYn/jI7tEQ6sT0mCb35pmE0RuNdbCYcIk1ZBnWS41SCCZW9knGiRFRsD2MA2QIVffGglygcl+SpvQDCB0uuLRcgRXrQr3BzCpaylN/G/BxbZG+ZDfr8PUJ7KvZKyKsVOeOVzkYb6QtD9Zm9r7/nP+rVsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpQNdfqGsFqOUpkAjZLKAxnhCK0tv5VarZ+3nTWdsZ0=;
 b=kikeDcuvqjpA2rclYHHzmZ25yczdlvl4VljO1dDNfMzwi0Ltk+En/pXDzbcWnT4D64RyZagLwpafjjlI+bmDwi4vbS19/6pKusPqySNlFROaPzDmiwloYEvihO5p0NZlz/rqTJwOnSWo9eUphG0XCrODmJRPWbppUfKwNlgpfsVnncAwW/JUQgB9ToU6mSTCvNtZk1TrgZloP6Ucg5jR9vyUUE80CDMqiCD293w1M5ynVGpttfDMYEuB+KuxZm1i7QTAfGRHMAr81SOvWSLr4LwykoxjFzKU5asKQ76rtsE+UmumBXk46YDwtCBoNiQP2sDgyNuL3w8pqrBcdIVPXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:51:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 11:51:25 +0000
Date: Tue, 17 Feb 2026 12:51:13 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aZRWMcY6dJe9UD_h@gpd4>
References: <20260215191933.2358161-1-arighi@nvidia.com>
 <20260215191933.2358161-4-arighi@nvidia.com>
 <aZQLFBEBkbF23-K8@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZQLFBEBkbF23-K8@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be6d052-38dc-420b-43df-08de6e1ae0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWK5pCssaY//n/tMizKj0tB8yvMmqZwBJHHkc5JTnClzjuCgpqsBS4zYxHPQ?=
 =?us-ascii?Q?EwZmZOY7UBtYcurSQz66j7lku4t0ld4mt0yBEbeFka4QzWHkK/4ZDn0YHtsi?=
 =?us-ascii?Q?VXe/4C4wcA5LzTI1FjaS2uxueJK8dDds5kpCqbyOTHyk5IM1B+p25cuvT0a6?=
 =?us-ascii?Q?QKoMG6A9gRUvKBNJdUUFuGWAnOhzuwRTUglBgo81JHbx4v6ag7lbEf6pPSL1?=
 =?us-ascii?Q?k5r3chq7iDTiLWB28NHf4k+r8dbMlObE9gaUZInWiGqwFJcOPez93/YJKDr3?=
 =?us-ascii?Q?jA3rX2JDzROZi3PUYV1LZtESakeuZejUSDWJY0GGmIqU/Ace7ah/4x73CIsb?=
 =?us-ascii?Q?a8+eGqti7REB3gzPthHpFDaK2yWdGqFmr07yl1T85tmOcBlUAValh5o/4p5E?=
 =?us-ascii?Q?voxLJsUnfMwA0UH53lPalCs9ULOhL8LwdhWOkq1idqOkoOEqZfHt/C1/x++W?=
 =?us-ascii?Q?6HjLlSudrJS4LNWSfqQpquk/1cCugq9EAaHyaTTmJPNwQqGieaBXw9aSiWlc?=
 =?us-ascii?Q?ESoMzirvYs8tziLLK0wHAFhCbR7UGP+SJHXkrLRr2HuN5qNxroLAzRuRiPsr?=
 =?us-ascii?Q?nJ7NEuQOT2x+Nwt5P0/c5IJLjha7JkRUXYxfV7f1UrBl/0LdNL43VM0g5qLe?=
 =?us-ascii?Q?Zap7tBtZeq4kmJ1JB6Z9ix41ZFnmj+rY6R+psohcXqEF4hZbTihwCdGzCjoP?=
 =?us-ascii?Q?uMDqWUjhyiih7iniusKBGrnygKC3nn+35GHvQJhFryvMikmrI0QIMVhw0e7t?=
 =?us-ascii?Q?Sdnv9svIhWgePqmO02k/Lurc23ujY+WEEICizpzzI8KkKQbqkmXl0NwTXOx4?=
 =?us-ascii?Q?0LHdtuN2Nd3krZHjgNaXXih5vM30UJMg523eGSOOGivxlGN4+5zky+1730TI?=
 =?us-ascii?Q?hOVHUOg7Gbwy0aSb09pWfq4/74NiQrrwE4JBZ1qrbjL82JKCUJz1k/fghkh0?=
 =?us-ascii?Q?iIMzHrbw44sOTuK1SYBAd1i/lYM6/vb2FkIimoS7DTfqGn4jojEmagFe7kWl?=
 =?us-ascii?Q?320Bba9rSiUyPx7AnKXXDsEDzVIy8bfcFgJQ5naYYEtAX7QcO7MSLDbm02O4?=
 =?us-ascii?Q?RfycenP00FSBPKAN1ywNiQAZHIrysxxD4Udt4kG5o+3eh8xC1wXbPW37jwi/?=
 =?us-ascii?Q?x0tqpOklLKbkBiktOC3mSzWbc/0QSrcyePCN1fOZRGh7bn5CfqGTBJqhcE7O?=
 =?us-ascii?Q?TluNaxdveaSy5EhPeXUFbpwUhce1bWhkQT56Mo9yHcZfdx/0HCGjdEJnyYe0?=
 =?us-ascii?Q?lJuU9jEDUwHmLhUeZO2pNBvSOmBw3CBsIrmyj5bssuIb2IAUD5uKJUIczGAw?=
 =?us-ascii?Q?RcAsALmJ55GkfCrn2F1tKIqzVsSL9C+jHAMvsPx3Y2rm7MF1i2JGBOXYH5Yp?=
 =?us-ascii?Q?s+HEe/Vpvsya4Dp2S/wTF+QXKWt2tgLj4sEP1RTh1RlQLREK45uMNEorYKS8?=
 =?us-ascii?Q?xKa+25lSWH//39NT5+dj6f1NwwBYAYuiQkqaJapfI0hBRQFg2bHJ/ESsToBF?=
 =?us-ascii?Q?2/AOPj9ghvspv9514HD6LGj7FP4+6Fn9QMwGjalG6qUvcW3CsVuQMYDqDa4v?=
 =?us-ascii?Q?VqO21guynlh7NizIdkk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JWXRJwq03flE90Yfm0OBJTDDOYxq+3SDiQU0LsCmOf2rusY3Yh9zQtAZBKH?=
 =?us-ascii?Q?FxpL85kh/GqDsnS9LRr+Uj6zd1W0n6HYGue460dVB7tlmy/+0e+0E182V/WN?=
 =?us-ascii?Q?G4+grSd1JFrD/rkUggFGaezNUNkzwstP83ujxZcoRKQLFXuPSQ2njpzlFOCF?=
 =?us-ascii?Q?JAsFzkLUwOSaRiDb9cwAs3qJ+3SykU9b+naRaA5ikaIBCG8K6NrgaWSFBKRB?=
 =?us-ascii?Q?Yh6rgVkTGyMj82EuhsCBiCltZs6IZmsXGqgqFhMK0+1Af0EvuHFLSIq2quUK?=
 =?us-ascii?Q?KPXA23rG4tC19yMkpI0h07S5SY18evEjqcjWvsLJjODdl+ZwL7bsUNOgDpg9?=
 =?us-ascii?Q?tKndfoI3MeYqxochgeza4UgS0X2fgmztBcDTkwKWUwghtNYnNk3b4w9YUDAo?=
 =?us-ascii?Q?AAt4moOalBGljCIH51NUuxDbhzT5LagsopQ+fzF19DA8SQIrq24o0uYQrjcF?=
 =?us-ascii?Q?2UsXRaczTPeJyIzcRZkBUoXah1PrxOcSNHVhM6rlmVRy5hIIvyIfnncBZDBU?=
 =?us-ascii?Q?obo5fpt3MaaEKC/JrUjpFS7PMNN6gvqT7MqLBp/WX5maUE1T12VQz5HDazPL?=
 =?us-ascii?Q?H6JpGfGobFF9NfUBbfA3TgVfujdpMzMLqjMKucXIhHQKHms1ucFyQpo/Ak1d?=
 =?us-ascii?Q?MFPlZh9yBzc2hAzp52Fy74jKHujxjd23VlaGs9VvI/riPidMk319fTdaQj3U?=
 =?us-ascii?Q?t8Qc/8JttFrMEJr3tMNNpbGQAeKK1IGIgbMAsU8KHe606CAip9iQ1YRVjB4R?=
 =?us-ascii?Q?bWWCsNBAk651tCnB/uC0FTXuCeIiQm2Axk3DC621RgbwfFcUj7PtDyrGcZUc?=
 =?us-ascii?Q?Vr4ELIorbzygEkNVfN38pNhDLc3qN4dLt1acZR4mP0VEsiYjVPJeYcKoD8pm?=
 =?us-ascii?Q?1bBU9uo7aLIYG/1McHVXSIyLnPLSXgaxgyrBAIBOn/cqg+LzBslALJwJlKx+?=
 =?us-ascii?Q?bhV48ZX+Zu8vTHt5gf3aHiL6RPPFhj6/L61mZlT/5Qk9rbnuQ8kGdImoD9+F?=
 =?us-ascii?Q?F+W/uac7M4bF09HdpD2lHBoON11UBwvAcdLpYoQGUEoEqMmiPBUwBw9nT9ne?=
 =?us-ascii?Q?AAxtyS6siGADBV1+QN0Sr10tShRrTc+MIsLkFoUGPAs82yExN2gjNsXrYBRy?=
 =?us-ascii?Q?6S422xNLfRSsX/+x5D3oTUSxQQWnjPiJvxMHV3TNCy14gYarB+UpW6bbaLk/?=
 =?us-ascii?Q?bPRAkRlMXJg8y4F2b3zR5GIYrSat6VUOczqT9zr/ob+8qS+ieVFxymgx/6BG?=
 =?us-ascii?Q?jbfwcobG/qDmwbXxMYJyYB2/ZW93S/NOGp767+3VTD8mp7Uh1e8qzC7A2DnL?=
 =?us-ascii?Q?KvX4VeQ0gdfu5fqN8NYpRFKzgR4czPXI7iexw9nwPNKS+11WnLxt35It4yiF?=
 =?us-ascii?Q?hNwJ79qW6cHLg7abfFhuybd0kQejbfJ61RA+wJEPC18bcVLLyovUoWbrJGGY?=
 =?us-ascii?Q?/nBAoX19iOK517K7Bp/mV1DQFMafoDoqr2tFFV0YhsdBNtI+H4m4Mub9+tTW?=
 =?us-ascii?Q?qIvHd/CI1tEp8FoXzW8aZf4zeyBh1vuQlg+p3OiOFw4YBPxDYK6VUVNdJdLN?=
 =?us-ascii?Q?kPesEmT86W/iRrQfa8DhKnNhfks6hYOhYeav+tjKHC8tjftlWUMQrFxoDkAr?=
 =?us-ascii?Q?T7Eh7KhCEYkqtT1YV8ZIvi+T4NlPdEzxeA5ZiplmqBKqnChnbYGwoe0uR0Gi?=
 =?us-ascii?Q?gwoPFvNxvCcL0b3I37HX+ig7TUqzVGC5pUNNzgKpJFnSZ4zQyYAdL5H8j+gU?=
 =?us-ascii?Q?0hBwdOdA/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be6d052-38dc-420b-43df-08de6e1ae0d7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:51:25.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAI/7/RYuxXQNl64ugRRYu2erZe/My4jv/vrCUlhzIogVhVqP6ASgu99AvI57tM7vsE5shAtk2KX0NCrTw+zIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235

On Mon, Feb 16, 2026 at 08:30:44PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Feb 15, 2026 at 08:16:55PM +0100, Andrea Righi wrote:
> > +/*
> > + * Return true if @p is moving due to an internal SCX migration, false
> > + * otherwise.
> > + */
> > +static inline bool task_scx_migrating(struct task_struct *p)
> > +{
> > +	return task_on_rq_migrating(p) && p->scx.sticky_cpu >= 0;
> > +}
> 
> Can you explain why testing task_on_rq_migrating() is necessary? What does
> just testing p->scx.sticky_cpu miss?

Yeah, we just need to check sticky_cpu here, whenever sticky_cpu >= 0 we
are by definition in the middle of an SCX-initiated migration. I'll change
that and add a comment.

> 
> > @@ -1106,6 +1153,12 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
> >  	dsq_mod_nr(dsq, 1);
> >  	p->scx.dsq = dsq;
> >  
> > +	/*
> > +	 * Non-terminal DSQs: task enters BPF scheduler's custody.
> > +	 */
> > +	if (!is_terminal_dsq(dsq))
> > +		p->scx.flags |= SCX_TASK_IN_CUSTODY;
> 
> Can't this be done in the local_dsq_post_enq() else block?

Oh yes, this is better.

> 
> >  	/*
> >  	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
> >  	 * direct dispatch path, but we clear them here because the direct
> > @@ -1122,10 +1175,23 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
> >  	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
> >  		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
> >  
> > -	if (is_local)
> > +	if (is_local) {
> >  		local_dsq_post_enq(dsq, p, enq_flags);
> > -	else
> > +	} else {
> > +		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS) {
> > +			/*
> > +			 * Task is on the global or bypass DSQ: call
> > +			 * ops.dequeue() if the task was in BPF custody and
> > +			 * it's not an internal SCX migration.
> > +			 */
> > +			if ((p->scx.flags & SCX_TASK_IN_CUSTODY) &&
> > +			    !task_scx_migrating(p)) {
> > +				call_task_dequeue(sch, rq, p, 0);
> > +				p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> > +			}
> > +		}
> 
> If you add else {} here, that'd catch the non-terminal DSQs, right? If that
> works, I think that'd be more logical organization.

Agreed.

> 
> > @@ -1531,6 +1611,25 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  
> >  	switch (opss & SCX_OPSS_STATE_MASK) {
> >  	case SCX_OPSS_NONE:
> > +		/*
> > +		 * If the task is still in BPF scheduler's custody
> > +		 * (%SCX_TASK_IN_CUSTODY is set) call ops.dequeue().
> > +		 *
> > +		 * The code that clears ops_state to %SCX_OPSS_NONE does
> > +		 * not always clear %SCX_TASK_IN_CUSTODY: in
> > +		 * dispatch_to_local_dsq(), when we're moving a task that
> > +		 * was in %SCX_OPSS_DISPATCHING to a remote CPU's local
> > +		 * DSQ, we only set ops_state to %SCX_OPSS_NONE so that a
> > +		 * concurrent dequeue can proceed, but we clear
> > +		 * %SCX_TASK_IN_CUSTODY only when we later enqueue or move
> > +		 * the task. So we can see NONE + IN_CUSTODY here and we
> > +		 * must handle it.
> > +		 */
> > +		if ((p->scx.flags & SCX_TASK_IN_CUSTODY) &&
> > +		    !task_scx_migrating(p)) {
> > +			call_task_dequeue(sch, rq, p, op_deq_flags);
> > +			p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> > +		}
> 
> Except for OPSS_QUEUED path, all call_task_dequeue() callers are using the
> same code block and OPSS_QUEUED can too. Can't we move the whole block into
> call_task_dequeue()?

Ack.

> 
> >  		break;
> >  	case SCX_OPSS_QUEUEING:
> >  		/*
> > @@ -1539,9 +1638,18 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  		 */
> >  		BUG();
> >  	case SCX_OPSS_QUEUED:
> > -		if (SCX_HAS_OP(sch, dequeue))
> > -			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> > -					 p, deq_flags);
> > +		/*
> > +		 * Task is in BPF scheduler's custody (not dispatched yet).
> > +		 * Call ops.dequeue() unless this is an SCX-initiated
> > +		 * migration.
> > +		 *
> > +		 * A queued task must be always in BPF scheduler's custody.
> > +		 */
> > +		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
> > +		if (!task_scx_migrating(p)) {
> > +			call_task_dequeue(sch, rq, p, op_deq_flags);
> > +			p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> > +		}
> 
> This placement is a bit odd as before the following try_cmpxchg, this path
> doesn't have the ownership of the task. Please see below.
> 
> >  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
> >  					    SCX_OPSS_NONE))
> > @@ -1563,6 +1671,16 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  		 */
> >  		wait_ops_state(p, SCX_OPSS_DISPATCHING);
> >  		BUG_ON(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> > +
> > +		 /*
> > +		  * After DISPATCHING completes, task may still be
> > +		  * IN_CUSTODY (see the NONE case).
> > +		  */
> > +		if ((p->scx.flags & SCX_TASK_IN_CUSTODY) &&
> > +		    !task_scx_migrating(p)) {
> > +			call_task_dequeue(sch, rq, p, op_deq_flags);
> > +			p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> > +		}
> >  		break;
> >  	}
> >  }
> 
> If you move QUEUED case after successful try_cmpxchg(), it's always calling
> dequeue before breaking out of the switch block. Might as well do it in a
> single spot right after the switch block?

Makes sense. I'll move this after the switch block.

Thanks!
-Andrea
