Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8BE388E72
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975844; cv=fail; b=nZGpNheJRqvaUB+V4xFNy/s+QIIlkD0kLi9ENJfvUCGp9cmzRAS/5wX/koxAQ1az1zuTNiSustXuM3ge99YsLU5FQmts1XYAej/VnFPauZHCyppoSeK8raIDWQVrUmca1/ZmwNJR2vofj9aYyYSsxaTsTrAYNOd86pmSJT7D6Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975844; c=relaxed/simple;
	bh=yzNaYYTFNAAEzkAk3qjy2u0LZv8F4BE4nAAsAnuxeyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G6BAGs4eSPMtifh+XA3i4/Irm9NnmpcS1486Bp9UaUPxg8fGciudVUre4rq1JMSljeNNZGZuJP1h8aetv9i7lcNUaZOywJkcnW3a5OVwp9UgyKKI1VN1X+faypZVeUaKaYIwUZleWv3cYcBIUQVVPV1b02s9WHR8p/jbHMjEXEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pz7uIj6f; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pz7uIj6f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJjE21gQ+6AK/5gAQsYospACUPaq6xC768yi7bsRPxq4Ubt9375R9kzc6FIDawLX6sHYwdSsaQN62d5Pn2mOF7fypOkyWbCSxrVXBlm8F60GwHpF/entQ9sxW8yS/voUlqCpwuyHItdYeqkL28JwqL7RvAd26NXcTyhW668jeCU+Pmc+0eDhZ8IROlpLrWdGpQj+FMIDxnOYnfeqJc9Ch/J+9XP5dHkn7JnpNS8qFIBJ/HRVI6x6eatP3BKyQMoMCDOIZv4l5Y2S3b6Oiy581DW3Ueqb1TkoulDnOPf83RJ8SvMFhfLTf1mPpSbRO0cnNMdkHka7acNjeTAbx7tgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQK/bHD99SBZf8V3l1xXRyKFcpZYnIu2xZa1cujRQOM=;
 b=x8b/vRirarYvCPA7vGfEtpYX3BJi7zr123SCrnWCxN5GWdETjPpErhB1+cg/9I3baqALx9aqTkL345ZpWfdzzmBHjbv+7nlCUPdwIAPdL063vVzS/rCfyNWn6IOKYz/UugO3cD0/vnuMrJJU49kdn2OedNeY8JaE7XiMP7ww5/EZLHmnsv4rB86DxdBU01Tx6RTTA1tG+dti60O4Uygn/dqN021BNWC6fhx3ZciTGxvMC86gXP/zhvP1kuNkqYZ39ddk3687nVtEtlY1ZU6+z9o0wGAn6zc0EiBV8R/FBy9+xEWKBRECmkooGZK6tIBpEKH87/jqZPGXzRv3gzx/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQK/bHD99SBZf8V3l1xXRyKFcpZYnIu2xZa1cujRQOM=;
 b=pz7uIj6ftA/87hEdo9dZ24FeNdVb/u5lEiQe0Mz7cR55nms5xIpvVrlmJSCMOplW0XKYFnvdlLW1VAAPzlIloU+HiQRYvqseJwjNVBM8XhpO8cgp49ymeaEVyoWoT5VUt9wvf1ih87cL0u+0Lkfm57F/YEpk56ZN6Ls56YH3Mm2xqzO0O80LzbCZNnBtn82av/CohySN7pc10TePUvUnpJUap9PZLEUiIwREDfYvnJOx48tHd2FmIkrmVEWBjcntydaQ7Gni7of7258qNZFhEcoPi6+ogK06y1t8OSfsXVQOYEij1SSBSOz0wYGW45wE/X6kmdKReKLln1Y904PPOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 17:43:55 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0382.014; Wed, 9 Sep 2026
 17:43:55 +0000
Date: Wed, 9 Sep 2026 19:43:44 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Hui Su <sh_def@163.com>
Cc: bsegall@google.com, changwoo@igalia.com, connoro@google.com,
	dietmar.eggemann@arm.com, jstultz@google.com, juri.lelli@redhat.com,
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, sched-ext@lists.linux.dev,
	tim.c.chen@linux.intel.com, tj@kernel.org,
	vincent.guittot@linaro.org, void@manifault.com, vschneid@redhat.com,
	yu.c.chen@intel.com
Subject: Re: [PATCH v4 1/5] sched: Dispatch task ticks for donor and
 execution classes
Message-ID: <aqGa0J1_LM99oDkP@gpd4>
References: <20260909092901.2989564-2-sh_def@163.com>
 <20260909104251.3131056-1-sh_def@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909104251.3131056-1-sh_def@163.com>
X-ClientProxiedBy: MI1PEPF000008C7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::429) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 60246994-1b7a-427d-42b3-08df0e99eb21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tSLPxqqE0YUdWzJIEsUeSSW64s4M4HQoesf9sENuWt8/XMZfwt7x2ee7WjgZrB8enQkmSj6n6DIw5rQ1DDl7f6CP2weliDO4/ZMNCVma+NuCyAEVYtXhWjL33CNl2/tjw4r+k15EB5PGiGdJMGeT5UGpZAdZ6cgFjjHul8C+O+anr2zroE8zS9RrgDE6kOxHG1jc8aB8eLKsjzpW+oani/MRYEGnpbcn1B8S9J0PGqq8kT4kZpHjR1c+RmsAwABAEF7j8m7CCRGDlhQKtZgT92X7CzRpDU78Ai9QZ0HXRKXTWn5Qo4f12hJejO1O6Q6JhpswitpsZn90oicbE/sx6aUZsVp2qdRgIx2Cn6OdwFnkyoWUBJ9ttYnZ3qUu6PVNBE0d2yIqeNdtBCR9AHtvX02gdgJ2Ktm9RGENpntLjf+AZ1wOsxBVUofB0KspkBRwBzUvIqkkwnVK5BFz2Vi80c4sarpmtPz6jAT9YKeuTF1i5OLmI3cK05AhIlaVorTZHcXSrK46uO+xuMysHy0Lo4neLwZH8dh8VYkIzYIeOs0/t55DXlFLOUlDYu5tbiBnIRY1/JdaheNOHP2JXaf96Dxzh6FtbXseVZvj8MQITF58Q1F4SqrVPB+maHF5GQu/MCL/3wmiM38j3r6oY8ldH5AMOq0xXqDSSoOpwiODPwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vz7Kq4QijfxXI0NzKifmbMt5hYFq2m7C7OjuZtNeo0iya2UCTHzsdO9e3KW6?=
 =?us-ascii?Q?/8ID0LkMLhlhZrd7/yqb0h7Sdh69DzhgWu6LAH8tTAfUHjtlMeXvddDSp84m?=
 =?us-ascii?Q?FTrgjh3UHioKg31NT0pYf+FFcQLpvcZUV9MMXqjT5FIXXdPPZGk/QGr5mRy5?=
 =?us-ascii?Q?MrutpB2mHN+xL8kiKICRodpAKNnZx+Q1Rr2lemigpPh4yJKAwb3gazEAqYcs?=
 =?us-ascii?Q?VUpbcBfU4YbyElLw0u+oX3/LMWuJnN4qqDP8CGuB8rBdTbUInmhA6Iq05LJJ?=
 =?us-ascii?Q?7toIfR+YcbYarkk0bwfoNhTB9sW7ZORn7+hLQjngnRm4OE1MkqigKwd8/GqM?=
 =?us-ascii?Q?FNqRSeig2PiR7O9K4HZfRvvN9PoCtl7f/r+RB4SjnbwSrlqETGMaI4s216Fr?=
 =?us-ascii?Q?eicoHyJmqcie0tNO1wF7leUbfaprbCuBI1DXUQr598O+ncTRc5z5I36eXKt/?=
 =?us-ascii?Q?/UE+gicVp8WepEQMdCtLMX08Tewr+3xdZ9VEuPARd/dBAUMm6KO5c+1gW5Rv?=
 =?us-ascii?Q?oTONtFyk//HImFWxZieskcwSc9jdAUZE9h/VkyQ3OPjWWtQxADt3eRfp2N1/?=
 =?us-ascii?Q?1hAH7yT/9U/DvU2IEh+1bfgaMa5ePmk1m6wTUhNg1ewKcY3yyBAhKQxFoa1M?=
 =?us-ascii?Q?Wo4xaol4B1C8lD4ee2ok1lC7nPAPhSpTprkplGqIlpMIswLoSAGeKs9nTkum?=
 =?us-ascii?Q?3idiZTvg3d1FdN6hnhjCRxl/WtLRQHmbF2LrZ7dCx/gcp3ECCCtfTnMqE7pr?=
 =?us-ascii?Q?4tlMoMmx6yGGv1zgygOR08FMEDRMGWhYcsDmzIvewTvNEu3jhs0Is/mVPNb0?=
 =?us-ascii?Q?+/YP8Y4WUvkbPKfn7Ogxp3l0kWf+T0ToG+4ppF4mN0Rs4LzxddljJjsXrmeI?=
 =?us-ascii?Q?RUIG1IV+XqPbgR6IvBvxrGc+aaokqKtgtkM9Zzz4y3SzOelYCgVDQmqhWppY?=
 =?us-ascii?Q?VjhxXeh58VvjdKq3opM+jbb4Rr6PwlfUOVE+rVa/u+z5FJFjNhQdrD1SKIZf?=
 =?us-ascii?Q?dQPwRtNatJDRQxpAclDt7MbEdR2xZZ3OyVcvB2n9xF9bYP50ju4hNHfVtb/h?=
 =?us-ascii?Q?ImV7cuzLXWgcoWpEvIGV2JMVXEEr9c9JYjl3nbO+sJie7G0RbnL0+WyQEbnj?=
 =?us-ascii?Q?P2jP3FMLyHwGuGQEOM+AFCvJoWI62H5NGb65idHNTrP2zFUTySYv7WB3z9wL?=
 =?us-ascii?Q?Ryysh2BR/tKUERt+5u0Uoirgn8Q26rqPxqdS3OhWR/JbXjGCgo9/gWrWIksQ?=
 =?us-ascii?Q?ZZivJzn833VDU0hZlaYkDkYLHsLDUKA+lo+FDVwTwGnuoP+wsEtmOozjXi3x?=
 =?us-ascii?Q?GITRlj3I/MTNmGioCXXNes9Bq0Jrzve84Splr64kJ7R09xsqVLY6MewKOx9G?=
 =?us-ascii?Q?g/ujBoHXbpT6xkDaV7TRDq8n/X0C3Z5+YAjHNeQ9CSVE3TB0tEDRF+mevrvk?=
 =?us-ascii?Q?mSTh5lx2adgXNn19Sunyo6dw4axJ/VdxySb9gqQNBrlFSFlPTwz3rIub6MNa?=
 =?us-ascii?Q?1GCKFA+2w9ajkORfilI+kBGD6jLAfmylezzIYThBbcjyH/V/No4SQo4qX66R?=
 =?us-ascii?Q?G1/yiC1ilbJTMezO8TdrDbvDOyQ35aWuj9xMKQ/7Rk902czTyQS5VW4MY9HX?=
 =?us-ascii?Q?C27RrikSmgYIEVmdtO3UyZX4T+MCxfmA68WD2ArsJWkiuBfBb15fghYJGnMu?=
 =?us-ascii?Q?vQU8jPrdJk1SCcTmAMoV6+rseVFx7dq+qlgoLTWpqChS1Zs6PSSh64mhzUkv?=
 =?us-ascii?Q?LBA1jWPJQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60246994-1b7a-427d-42b3-08df0e99eb21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 17:43:54.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQSissmykFa2Zc0JtWVcp7ICF24S3yYBxUFx8pMfkCODav8BFoAkpq8MzLYIuvfXGs9uTPdV5IkZQxPdScjXzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693

Hi Hui,

On Wed, Sep 09, 2026 at 07:42:51PM +0900, Hui Su wrote:
> On Tue, Sep 09, 2026, Sashiko AI review wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> >
> > - ## [High] Infinite timeslice and preemption bypass during SCX proxy
> >   execution due to a mismatch between slice decrement (execution context)
> >   and slice checking (scheduling context).
> >
> > commit ff57ff4a11692a1b0d98a6cd57257eb58a1bd864
> > Author: Hui Su <sh_def@163.com>
> >
> > Does this cause an infinite timeslice for SCX tasks during proxy execution?
> >
> > When an SCX task acts as a donor in proxy execution, task_tick_scx() sets
> > curr to rq->donor. However, update_curr_scx() applies the slice decrement
> > to the execution context (rq->curr):
> >
> > static void update_curr_scx(struct rq *rq)
> > {
> >         struct task_struct *curr = rq->curr;
> >         ...
> >         if (curr->scx.slice != SCX_SLICE_INF)
> >                 curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
> >         ...
> > }
> >
> > Later in task_tick_scx(), the slice check is performed against the donor
> > task which was never decremented:
> >
> >         if (!curr->scx.slice)
> >                 resched_curr(rq);
> >
> > Since the donor's slice doesn't decrease, it will never hit zero, meaning
> > resched_curr(rq) is bypassed indefinitely.
> >
> > Additionally, if the proxy task is SCX but the donor is not,
> > task_tick_scx() returns early here because the donor is not an SCX task,
> > skipping the SCX tick processing completely. Should the slice management
> > be explicitly tied to the execution context rather than the donor?
> >
> > --
> > Sashiko AI review
> 
> Thanks for the report.
> 
> This configuration is currently unreachable. CONFIG_SCHED_PROXY_EXEC
> depends on !SCHED_CLASS_EXT, so sched_ext and proxy execution cannot be
> enabled together.
> 
> When CONFIG_SCHED_CLASS_EXT=y, proxy execution is disabled and rq->donor
> and rq->curr alias the same task. Therefore task_tick_scx() using
> rq->donor and update_curr_scx() using rq->curr still operate on the same
> task, and the slice decrement and check cannot diverge.
> 
> The sched_ext change in this patch only adapts it to the new task_tick()
> interface for the currently supported configuration.
> 
> If sched_ext and proxy execution are made compatible in the future, the
> SCX donor/execution-context ownership will need to be handled as part of
> that integration.

They should be compatible soon:
https://lore.kernel.org/r/20260831134338.1531664-1-arighi@nvidia.com/

It'd be good to handle SCX donor/execution context ownership in this serie as
well, or we can coordinate to figure out the required changes.

I haven't looked at the whole patch series yet (will do soon), this is JFYI. :)

Thanks,
-Andrea
