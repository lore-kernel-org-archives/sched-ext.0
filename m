Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF34A43F1
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969907; cv=fail; b=ZAl5CxHgZAP+wuP/P5lPyXnQba/ut5wj+5YRQcwBaGTScCzujnu5pSH3gM5V2luZW15jzGh2umDjqvSAp0+v0QzNDxp1JgSJQfBYEzQ7gKDkoSKYMPLJpARpgwbb6n4SE0v0VovnQku9iSztr80NVCfTl8KR9ifxMdXb1oCfjPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969907; c=relaxed/simple;
	bh=0q4jygsyVs4MaZZzBZAxPEKsGFPfXbzT7Xgh3P4kkLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uQxVHFXn8Wob/IuxivDhGbl972pYSgsA6doqDIM7pt+z4wZLy7VJG4Yv2FLT9bDo4AzxcrVoCksXsz/8a3jktD5tggjYhEUvwwXJNSk8esgJ4RewvfCkKpKYg55GmMlp+hZFJGi5tgxRPawzIoayRisgElOsjNlZzxYG1NdEj70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jk1iLssV; arc=fail smtp.client-ip=52.101.52.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jk1iLssV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syKScPseqE2o2HdfSFwY6pb+4+DM/9eMVFACPaYqgAdUsOctrTjRfRrMxG3RDPMK6WzVo35XP71SvJgI5vR+VIRBk5+0PMzpSyrRPGKYw7xgCwSWEG51Fr+M3OxNP4si2INOag8rj41FErNWH5fxHwy9ij+EVgvlVi4oG99xbrAw9oIZkP647rqraUWPYodgB83DXDRceX3ukYl013duvTlxjteSpHcyu9RP3CbQhhNTWI+WdF33gPFMyZuaAwwpwJrHXPzRLaeUFqKylJ/8e9YKGF4exNjeSyVA0l3NUdtqP0D1FdSIurLiLHE1qWTLKcV7yjuNmv3+DjZmcBGzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WPPCYQ2iFeVXSYQBiboM7o7sBtbPb9TwiJycjj0p8A=;
 b=yHzbYmU1XRcRQuviUyUegVMRmmggcz4uFVFFm5V31+DdjVEpnqOaBmvqM+5o8ObQJkaS7P0oseGT0lzEWXggr+sDA3MTT5OwUAg5mb/dM0sXGZQsCkWxjoQ2eObkP2RiJKXjQSli41PSZxHJc7plctj1uh0GOHiEk25vmkKuns265yIINBd+6+YBGSufzK62J/UoB8IwLpYAGHS1/TEgn5Lp/cl33i0PmmksOD1OoXN7f2SMIAHqEVsk40gehwv0Xl9ntlUfhj/VB5nYu4SVG2T3qz+XeVvEf5E07TPYZj8sOYFjK5BLTlZVRb8WrHeNTGK76ffv+0J13QUmVEQXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WPPCYQ2iFeVXSYQBiboM7o7sBtbPb9TwiJycjj0p8A=;
 b=Jk1iLssV2T+APE8akcIuKXWWmogC+zXFcFQBgrZ4tnN2b8EQa+p0qjBE5R/+9ZZoMHI0m25Twh6CYs3aSF1KqB76FkFUCQqlA6MO7S1SC0gmGWyY2QkQ8ny1TmR1iQH6WQT7rQNyqNbGIscXsbvwCXhm38ho2iXRK/rgc500Uf0eGjGkE4HTgJ3ASV9PwjefdNUldrcx1B5jtj7SAHF1dL80cSYDCRZi2yr+twy+0VniMM8alwPFyZmPzcqGWj/Pygifg8/iaPKV+59YRMdzTNmJmQaDSw5e37kFS3xUNCPChUtBbpt9qOR+9J15rrMERPNt9mkmOGFfeP+Xal7Wyg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 19:38:11 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 19:38:11 +0000
Date: Fri, 2 Oct 2026 21:38:08 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Keep proxy donors with
 slice left on the local DSQ
Message-ID: <asAIIDSdSjwEjir9@gpd4>
References: <20261001191216.2391359-1-arighi@nvidia.com>
 <59be0f173a7bc73a5a7eb6927f635605@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59be0f173a7bc73a5a7eb6927f635605@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B83.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::419) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 1201225a-d063-4c3d-7619-08df20bcb154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|10067099003|56012099006|6133799003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fkXgAkj9xW0bTjPxdD6gyy79sdT6P3V1L0PgWloHfMR8vUFhldbf9HPmPUHdHBFTt9D+TgVK5jW6b008jwDthwxMLZV3vpA02AtaZC/aPcguYGfMtJ72zXn9U5mx/CVZhfmZYUKHziPIVO1OY4tJPP17pLIdeFgZ20einyOJ2FjiSYPwc9sN4EEnqwAVEAVhpjraeG1Dd+KG7joS4tuUvCVRfgqWBUPBpqHMKvrGqT8vR/miA+6ECtV54Y9Oulof6G6+5k7aD1Ib5EJDD/nQj193npmkEpPVeWSDUYpKFyh5xgNwWJzucRrbbELX0SF+HJZX9IUpn1PKFG8PTDrYH+TsdsyIgEhT0NrCz2u+ip/bUP9JkoDINQT+3f4E3XeFrYU4uMzaAVnfm8DXJ7ozttQWEtP9OdV7MRJj+4OiNyHU7+spy8590etV6416QgvTXLSuaMDGwCwAQ3vpYoWSBvq3hg6tGP+T3IX2XePwqFXJlnjSFdgCxMZlwFctcYN+zYCnun5QHkZjcVhUpAM5OHwrEipSuMuWFLV1zyKiLJ/4VqLZ2CgjGYwlktmQ5kqdQbDImjgHcbLcp1SVRhZugbAhgAYfsdgCnRODL/AaIQIwiqBwUsE/+I1g3TDMG4yI+fZ5Y5oFx4DVtsO8bUEr4uYUsk5jrzI5nigfq+lvDNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(10067099003)(56012099006)(6133799003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VOTw/OMGwEkAgJ20wC/f0AnUVRmmnKKnIo6Rur4jTwwWrSRvyaVk2pRuZHLi?=
 =?us-ascii?Q?YEcNsGcH8tP6WHavuyFyCbpelOEJ/tdU/Z53otjQY0zr6IWyi5KH/YXltc1Q?=
 =?us-ascii?Q?azg+eHg7723H0ExxzpZBI9/QfIuBCup8BBZjzuvGzqcCTTCV+N7SwrMu62/k?=
 =?us-ascii?Q?YvrN4SsEvSsCG7wN2JCPBGTYyULxkzL/M/RFqTHWosgL2QMldUJ3cB/xOjlK?=
 =?us-ascii?Q?M74JGuR8pyRP0oPa/SY/5VMLde2MS1L4rlgP9+MZ6NL/g/XxlZdpEoVhKc9l?=
 =?us-ascii?Q?vnSk5/ZNiELECDzfSbmHWghaxY6qP5hE4Ep/10V3SlnPmCpMHFK6N433PG0U?=
 =?us-ascii?Q?NNkGPUx7/sUjAbAq10P/u0nPb5BkTojoLINngulMg4GiNBd6OC6dFDZmhHzf?=
 =?us-ascii?Q?rKEXSLsFexweh1LRDoFbBPr8/TYy3ETY0ravLjXQK9f2dn6e0/wfIwySaBKU?=
 =?us-ascii?Q?SGayJPXvyMQ/Wi9xW1dLwVbS7HXxJzFHhgpGHLruGJh7E1F3jI9CLcz5c0Fy?=
 =?us-ascii?Q?LD6x3Ujr7+djV86snnpXIzulTBy5Rxzhny97t9rC53Mbhafnj9MXyzGOMPtg?=
 =?us-ascii?Q?6JJedW8sthucbhXVd3P+gB6EMtL6kb345hHek2UQuGvtrOrythmWo6q/lOFy?=
 =?us-ascii?Q?R5Uwie4mCWMJuzNGKRBwjdWh5PZkYSYlGxlbK43XH1UaTyCzaZ5SlhOiEwyP?=
 =?us-ascii?Q?9VCi4dOg83Zgf2l6qnJTzNrh4sGutdmyuyYy+Y9LOykQpVnRr2HKXSKc+W/O?=
 =?us-ascii?Q?FFErYQwNWChZqx1vDluIyoA86wAn5gP6XMaXcwqdKTqHxIOf+m1Nx1NkCQ7a?=
 =?us-ascii?Q?zwwi34wVqe7kHpOhTwmYhhShL2+MJ+mqIkfSXRby1KCLNqM/ha3y7djhO9jo?=
 =?us-ascii?Q?IZTsDXwiwmrH4/r9vWw17n9iu1jFa4J9hrgFjhUZu5QvSlyuI0ZeaO5plZp5?=
 =?us-ascii?Q?PPHMmtM1XF8aV/F+TUJaJFCUq7+hV7uiJpt8Cot3sAk2PGVyFH5WpAVtG0nj?=
 =?us-ascii?Q?H4q3pgy1KgPpHj4pdLNOF54PjJVaz6kYugzK7mgPI30KLU+iarfGgAp6AEFQ?=
 =?us-ascii?Q?USJxBHRR7Suv0R7g5hm/nF7IGVB73lPsjYbqwaloQFEb8L+oNshcXzbdWfXn?=
 =?us-ascii?Q?0a0EdafBpM0WsEA3dmSkn4cwEb7V063vy72aumkLG14PrmHXQang4+nBIf/M?=
 =?us-ascii?Q?2U3klgKp/gb0FSlxrzNdfg/zWb1copPFOOVTFDOv9RsAtXLpdkq6EyeXIpYG?=
 =?us-ascii?Q?EeyfeCa2VDp3ciPN44OTN5rhSL6BGm4RPzNgXVIzFYT9Dyq7QOjQhPQPV62m?=
 =?us-ascii?Q?KoT2Dwwd8FXvoOaIXMvXlbVLjO+uaIc4czO/LDQa0TSpJdjZpUabedtTJIfZ?=
 =?us-ascii?Q?SDK186QYbMlUfBi6dn2+FfAprE/6dHmr3LfUzXVKHt2J/ZKaW4UI1fbNsclN?=
 =?us-ascii?Q?JaKOjEzI3EMB3Lb6nrLg4IRXwNqzk8H0HKL2gtE+FUZNaJtzpAlUsy5bp0RW?=
 =?us-ascii?Q?YpsdVosJQnZItj5/z/XVTPDSb3+Ly/s6HG1Cv1Q8vFRD/rI9EPB2yr5auyLP?=
 =?us-ascii?Q?PhbQRlo/B+hRHoIykQbiJzgzghwkAlQwzC8LjgQD7KSzy7PA9FueEyWewuc9?=
 =?us-ascii?Q?k2zwWrzRazx1+gq6kyaJuXA/5/7QhtGGXlPGgT+TAiimIUp4i1WBhNFX1ECA?=
 =?us-ascii?Q?5AqrqDXRY5Nopa+im2sLJik0qs/6V2weU+bJYggXCJYMr5QY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1201225a-d063-4c3d-7619-08df20bcb154
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:38:11.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKTMIiOAkaF5pGBha2Lt6qoIVg8xL3enBooGcc4yBItSunzIBa2C2cx3amMZ3qGoyiUsznRMBduBqFHJ9PUh/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

Hi Tejun,

On Fri, Oct 02, 2026 at 07:30:16AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Thu, Oct 01, 2026 at 09:12:16PM +0200, Andrea Righi wrote:
> > +			if ((p->scx.flags & SCX_TASK_IMMED) && !proxy_put) {
> >  				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
> >  				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
> 
> I wonder whether IMMED should matter for a blocked donor at all. IMMED
> should trigger a reenqueue iff the task is not being serviced by a CPU. A
> donor under proxy execution is being serviced. The CPU is working on its
> behalf and there's nothing the scheduler can do to make it go faster by
> placing it elsewhere. If so, a donor with slice left can stay on the local
> DSQ regardless of IMMED and of which put this is, and
> SCX_RQ_PROXY_PICK_PENDING isn't needed. The deferred local check would need
> the same exemption as the task stays SCX_TASK_IMMED.

I think you're right, the donor's progress depends on its mutex owner, so
re-enqueuing the donor alone can't make it run sooner. Therefore we can just
keep it local, remove SCX_RQ_PROXY_PICK_PENDING and simplify the code.

> 
> > +		/* Delegate retained donor admission to its owning BPF scheduler. */
> > +		if (p->is_blocked) {
> > +			if (WARN_ON_ONCE(!sch))
> > +				goto switch_class;
> > +			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
> > +			scx_do_enqueue_task(rq, p, 0, -1);
> > +			goto switch_class;
> > +		}
> 
> Can this be folded into the following block? scx_do_enqueue_task() already
> adds SCX_ENQ_BLOCKED, so a !p->is_blocked test on the ENQ_LAST condition
> would route donors to the plain enqueue.

Agreed.

Thanks!
-Andrea
