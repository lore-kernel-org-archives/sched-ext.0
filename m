Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012055.outbound.protection.outlook.com [40.93.195.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471B37E313
	for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770549; cv=fail; b=NQr3E45KdYEUXiWHtfbRhMSm+bstyXMw8C9/JXPejTmH95T0g89i093g8ROmL/qSQ6LVmsnyIZmPaZhMYdf7dn7rFFCy7oh9qGqX4xXtj0goDymgNJyb2IGnZWJl/tvcEyih92CPjQlOi6RlTcwaUIgP+WY8Py0f55fxQln7epc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770549; c=relaxed/simple;
	bh=uW0dhyxalvp2gafMECG0Sn2Q+5uBdJB3tdu4+ErSB9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kNlsPWGCCJIjj6mvV98BZfY0FKICDH0JIOvTDKduXlm3uCcY0vDBofGel7n9HjprkQr37J+zyfDa/wFlFc1hSPJPRGLt1M7vocOkYVaBzkFvq+KLCNDAuBik0Yv8h8keZuJNC2EV4f4KwE0tNKevgVVsdfQAx82o09OmEf67dyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DvXYOpoM; arc=fail smtp.client-ip=40.93.195.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DvXYOpoM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uU1N1pW1yJw79b9f/9+s2tZunXisQnWda1GCVIkql6ZihARTeEmj1JMD5tD63UcFAhe4UDry/TczmNLnqtTf6RQACLEuzkxIKa2eVlXWOHqmhkShTdXWylWG3cjejRg6lf9H+BYE0bpZXXXGijogTnB6WmQpGU5jkndkQT4y9spZLYURdQHCijSmggw/yyWvtXnUjNq2cwUR3w9mPDqIy/OmfSMsTXrY0Hq+wDUC4T9wE3raotMuIbngPAxbhL+5jd77YAtYW5Jh7/sfpqDS3yYSSACMsGQibZKC/6WMLMG6ee5owUDI7eDc9qygtFYPciWe6QFLb8TDjsmts6pBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0H0DwDnQan3hzjG8w9EvXWiWlAPfa6jlajp8krcf0U=;
 b=hswCAmrt9RixiLYSWnNWFODbka/sNtbLLrTtXF5n2cNSifuJnGwDp8ltVbvnf6ZJEckK48PRihsgdqCev2BLpFjNStSqN9C6QA/qAopY88u/NLR8dzzxFQkkOtSaOYxO+25DcTqLWE9M+Kpaeu2KuPagdF7N0mO/y5WbCbwOvh5UFc1+ojCXOWWQNfmV6JNmTJiv8TzSp7HDKGoHgDhcav5sQvxwB+GWnBC2+D1JJYinBUOtu01edEMMWREeyztSvYcCPcyVZHUVQDt4rU0NQctSd9+hu1GA9mGVYdCURWyXZLxl1l0ZWs7gGjNVwUyMJK+oVTtePPwG0YWaDpnVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0H0DwDnQan3hzjG8w9EvXWiWlAPfa6jlajp8krcf0U=;
 b=DvXYOpoMV2VdF2KDWFd6BvnrMAwfI0ZXTqgI44QR+rWr39UINN7Va4iN6izesbWD2guWYnzAM+hM/h97DQlqzxZeynLChP00RRAWVFtSL/aJmgPK9cF3TsmXIYIwkcPFv6GqppfN1T1Ri77J5V76wkeK/tFtagPVKeZVTBc+7YpkSw9F5gdmt1JolzoUgJ0lOzpjRKhX2/lZmOOdpHTe9EdiaXCM5ggnL35Rog7t00y2bfg18EbA6SymTIWeOQWsKE05XPJR56PSpmHLe9YU4FZ41x0xbuX37Nv2TW6jqedsnOrFTbK+pOaboOyE/Rz49IGhSIjJ6z87wYbPoircTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 18:02:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Tue, 17 Mar 2026
 18:02:23 +0000
Date: Tue, 17 Mar 2026 19:02:12 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 1/2] sched_ext: Cache per-node NUMA distance order in
 scx_idle_init_masks()
Message-ID: <abmXJGGsb9dnpPzS@gpd4>
References: <20260315181017.1377138-1-yphbchou0911@gmail.com>
 <20260315181017.1377138-2-yphbchou0911@gmail.com>
 <abgnBgO83uXd7Xq-@gpd4>
 <bwbqaaeptqcjfuotszesmckmkept2o5exdkbn67nx7uz6bwilh@mlrjlhh4ovzi>
 <abmQRgwQZhZk9-_S@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abmQRgwQZhZk9-_S@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cab22c4-919f-4618-9bf4-08de844f574b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3TRfLOm88DYOFcRx6O6hIEFcGKE7aus3v3lI/R+a+itA3ZxMXIjxH2vwPDbRLlaAyUtuwOO0OEG1g+xpcliTB/X/tAf/ML7cjCaXBe8UrE/OPahlNNayffEZpu5ZyLYGMfH9/Hd+Zblvm5kUSa0f2wmAu0N9hcji9NOYxBwm+2JF8vEec1vVk6165bAD5G9j13nKWiPZ1uxHmWm2sfg6ciJmWSVHt/WLgpAfxbQBjGNraR7zM8J0vyZH9zYejOOHMr1NB2nF6XRq+ZXlWzQU+NJrM8MHWdawoo2B4y3SoVyNQduEd7byHj5kn/tyJVkBCsg7Kx1BS6pKk3C93YfjQ6pZzwwcZqr9knzqfQ4/P1Q5BpdFQEh+xBTOSGOzEEzKihhAJB31ztfSe0jc3pyBlI+eUi9zGHT7eZS4nOewCckCW+UwSq2qJssUFRN4vDE+BOXcF2TFXWgehmIMTjxBGxxYjDSb1vipzhqDSmHFaSvz7d6EIcQOBdXahPdW8ikw0JLl2Tl16N4pQZMLs1AmF2D2ITJnrbOqIXBss8KV3thjBR18h9mrypKGP3x5T8cxM86VSqUm1pIz6WFIeObX3MxRCL2iaMAHxrpDotMoCUHIqjGIDwfJmMAVP5ZqVdO+Vx8dPmt1Yw3dVEgHDTXpZA77tUcCs+SiIvOYI7X3ETYxIUzmRjPCnQ+5jKxD0MeSzeaOOfIEiq7LvmZEHy14F84r+Wf36uc7oOLyjXJrYWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOPjMVXAn16Hq7ERFyxm8Bl/MDFYfTSP1CJRXLMup5PPSaJOvzD0kloA1z3o?=
 =?us-ascii?Q?1Ze6cNa2ML0SHLD8+ikkjaVPiL5y09yEV1aD3CZrIylHowrV5A0QT/BayAtP?=
 =?us-ascii?Q?BbyFQsaWJplkkxJwLOlnHKzmWsCG2LO5VCfZf9sN2m8cuNBM0Unah+qPkKa/?=
 =?us-ascii?Q?593ySaScAQN94R6H6U02XIOpPCUYx/MrzjCrn/NswnqHDro9d1xrN1TSB+3s?=
 =?us-ascii?Q?ko1KCjOlyBUw6XkqTXYndaRS/FuSNGMBBR/8uVCGh2SUpDriWozwcjNErMXN?=
 =?us-ascii?Q?Sa+dhjkpKEYqC1HNyyqBKGibGnHffSzM83IT1wj5R/QnST6RGnuE0Ocz94tK?=
 =?us-ascii?Q?I+nvqPVNVKTWL+rrZXJZ3AWUZN3BQLkvEKb8bknmZhzIENxUNBy49PXBjV1H?=
 =?us-ascii?Q?ZaBL5DB3PRPAWgcpOoHZ45IcRubCRSCYaC9NEQRzvycKSL8GKTM+ItqmsQyM?=
 =?us-ascii?Q?bvgxGZ6AcieLY/PoOe9KE7lbRkdctSTs4pzo8MgKgr7icaA2oJgq2KfI91sv?=
 =?us-ascii?Q?pg9fUi2Fi59euGxFJfn8QUcYAOcJeMqxNJd3Vu/u5BHezkKhPJ7BK0UgWRNx?=
 =?us-ascii?Q?jTHnLTGSjfg+LJCaLa7kqQZ8wZNkhn+gqzzesSMe/wMxLPAfMxOviQGXQuHO?=
 =?us-ascii?Q?33AnaRK3NOKgHyMSig5CvwD9dznDUuk0JAk7e6szKTOj93oOj+w1TVIlltjz?=
 =?us-ascii?Q?rFvGjKizGDiItZ/tw8gAHK5a0SQ1mvxO7y/gdFNb96kHyv3JOpOA4uWyIziT?=
 =?us-ascii?Q?/Yy48Pi553Om1MnE3q0IA7Y03O1geOICBqp2yJ0f0t1P1pL9xgkX1tvZlO2I?=
 =?us-ascii?Q?3v+QjfYVU+Y4p4UsEjrniCxTChpc1ki4sbXjlI1nvMv9tbcuWbF3XJwj+gkj?=
 =?us-ascii?Q?canAantXfTgx6rk4iRoytb1sHfGZebDEdC7k/xOnYvfk1Xfg590tujIkmC/i?=
 =?us-ascii?Q?ueMhE18vldtnv5qfuVk8+gFvVa4J8kKsJbRN44mKuOP/+jdDKw9AgOJNwQO0?=
 =?us-ascii?Q?Z7Uu8bu11rxT/Zy7fkzvb7gVcMT+GBwoRQoEw4ewSbSVVQjzrCkj5wB0tMtV?=
 =?us-ascii?Q?sI/7r+2minpp4Xkqe9ve2l7Xg0uohhzuCC91WcYWO39UVHVIs36d9b9qFNfC?=
 =?us-ascii?Q?wlHZpq4c3Gp/SqKZpUsOZqWRorA2PxaEzENbBgD67qoHfUWmww6W/v+RZTKq?=
 =?us-ascii?Q?xunTo7n8GezYVc0Pts87E9j3rSxjsLs/1sb3pYa/JGRArH+AZh57EG8b7CHh?=
 =?us-ascii?Q?hmfBlEbcJUEU5/MVRtPR4/vhmwUVdYCPBlKsP3EtAx8JEzHqzJaUw0TbRDTD?=
 =?us-ascii?Q?CCuq6BN4uSBc0p0UjgdkO4JtuTZlgdXca1kaIHC0IfCpj1EiUfFqaxC8W6nY?=
 =?us-ascii?Q?Rm1ZhHEt0iiUZw1+Oem5qZ3JtYdRG7RG0ZU83A3tf8IscLuJgBAoo1AarSs/?=
 =?us-ascii?Q?eMTx5UGWTlb7Er5tWi3kiyAiOgJZigOejtgqpERJP5JgvfeDDWBFHgWAC17k?=
 =?us-ascii?Q?hyP6sMOznebVsh8W/ttaTsw9oilDX0+sbduC+FXwSBEQAOJPiNdfP3b2ZrNU?=
 =?us-ascii?Q?4Ce2qng35QmA1cgVQgSQs4gCh8BPvLuW+PeAdEUIFTvuag9rhsD164BrLCoS?=
 =?us-ascii?Q?1igrU/dvvQmK0YOvRvn9OASx5vVp6HZeWuEs4XG470ewY5wEhzSX24clEFCL?=
 =?us-ascii?Q?RMEsrGJhVfPnnRvkqkF4FbEfuNb129XCqGpVi4xsUO5ymnHS/j6Uqs0M/ZBN?=
 =?us-ascii?Q?lNT5ryl63g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cab22c4-919f-4618-9bf4-08de844f574b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:02:23.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doEJgAcOpp3g8vC0jjqTe0XSRNfV6ds+qEDCGM2PfsoAJIraylDYSg9SZhHuY6O52FAzVnEIfzD3otDuviALIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358

On Tue, Mar 17, 2026 at 07:32:54AM -1000, Tejun Heo wrote:
> On Tue, Mar 17, 2026 at 11:04:11PM +0800, Cheng-Yang Chou wrote:
> > Hi Andrea,
> > 
> > On Mon, Mar 16, 2026 at 04:51:34PM +0100, Andrea Righi wrote:
> > > Hi Cheng-Yang,
> > > 
> > > this has been sitting in my TODO list for a while, so thanks for looking
> > > at it. :)
> > > 
> > > Comments below.
> > > 
> > > On Mon, Mar 16, 2026 at 02:10:14AM +0800, Cheng-Yang Chou wrote:
> > > > Add scx_numa_node_order[] and scx_numa_node_order_cnt[], per-node
> > > > arrays that store NUMA nodes sorted by increasing distance from each
> > > > node. They are allocated and populated once during boot in
> > > > scx_idle_init_masks() using the existing for_each_node_numadist()
> > > > O(N^2) traversal, so the cost is paid only at init time.
> 
> Wasn't the conclusion that given the low numa node count, O(N^2) doesn't
> matter for now here although I can see node count becoming high enough with
> AMD fake LLC NUMA enabled on an actual large NUMA machines. But if we decide
> that's an actual problem, shouldn't it be addressed in the topology code
> rather than from sched_ext side?

Yes, that was the conclusion from the previous discussion on this topic.
Honestly I've never seen NUMA system where the O(N^2) could be an issue.
One thing that I like about this change is the removal of
preempt_disable/enable() when we iterate nodes.

However, speaking of performance, the O(N^2) bitmask iteration on a single
nodemask_t is probably more efficient than the O(N) iteration through the
scx_numa_node_order[] array (it should be more cache friendly). Ideally we
should run some tests on those big Intel NUMA machines that were showing
the bad regressions with the single global idle cpumasks, but I don't think
I have access to them anymore...

So, thinking more about this, I'm still conflicted if we should apply this
change or not, especially because we don't have any performance number...

-Andrea
