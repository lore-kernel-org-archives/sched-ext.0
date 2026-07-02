Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602F2848BE
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017486; cv=fail; b=JxZJ3pUtRflxb0x/zSd8c8XSyu8ezeQoyWmqOvKyG4c7TqCRVPZfiGyh8hkoBfdMDODq2vMuYqM84c+MpI083VHXH48FwUP/vdJlxiejW1sdVvzoCg/B8q12QDh8TpQfL34RZ7rGxXcKpYxrvZ/H6eB5fUS6MrN3mR7xxTyzxlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017486; c=relaxed/simple;
	bh=kZhorCTyyu29ffNuPEwQzudI+AsEx/oDfnjH9GsRDoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=abZIxy/oHNNjye1HwQ8+Kcjbpps4SsSAbx4AAQyHQa8sSZi06M3ajVuXvSZRggboe900tocxnT1jQeHwXA/GwDnBA27noE9ifTisnhyyCgTmmXQ2rXil/zNikfZbYQ0aAy2FkQC7hcbMIZFvyiB/TocOgvG/zU+aEXMean0E/Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9BtFbcx; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9BtFbcx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4zoFj+VqUvkVG5VXgZtJqN186crAnYZab9JxN8H1QvQuQ9X2ybxzrRByXM05okgCKIpcOhtrhcjt0gv06gSK/XM3tVT26epHsW6ROv5HSVi9Qk6m+403Z/SzpHWFKknRFjAIh1LoSrhTJn8dSQimXNpXm+R916ivtg1bRo7LrJkcKjSathWAuNTc104s1jfZ3IpqPDmZLawMLWXunaxkIBzfDvjrFTm8sdk5nxxzl8jcPBnBnj+ZaqpC/9/S5R7d5qT7RfswkL4dS1zcb63uHL4mfI9kfJQVTGZHZqrb3qYs3nnMJbTx1b0ylj5j7n9KB92sHwmt4O8aT1nldLGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aSgkEGx3GZ8NQkEZDQAGuLnACpMF+PYWnFDbyXtszY=;
 b=rCAnRJtl1hGj6IKE69YV9FsFexfKtUjW0RubY1Blbxf3o+YQaZBypnDnsoPfXfHFsr5g+EtP0zYX00urWasvmfUs9+UiiHsXyAH2fCk8ktTpL26Px3+UIQh7mU+j7RMlgWGzfz7mk1n0Tjf96T342IuMGNFqpE48G7hOT9SsZqiOC5ed2Gy5oECPFO4N8O3uRLShLBK9Xz5rj7wjPErUgKVGiZUQqe1AR82Lyf/AksChF/6iXAJuI2nvu20xVw0FM0S/Vx7Z7TxXU1ErhGtcJQ88lYU/rBhnKaEVLrz6eIy2duH3h5dS92SDOrpdNhU+j8IuIs/H52Azn6Cq63AJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aSgkEGx3GZ8NQkEZDQAGuLnACpMF+PYWnFDbyXtszY=;
 b=V9BtFbcxPo/8fkXgoo7EbjRwWFPZjWzHvNX0bkS0pZrLKioxwHH1bNwbzm5T9u+OaohuDVrfDgTaFZ9zFAcO+pwi1MHpElUYzICnc8YvYQ/9w5lomi5LGUv5YYL8zKocAEvRADwF8La7RngkOfQwb9MZV6tDU/ZylYx1DE9P0egoOW3j3jrcXcHJMkSszwy+aGTmliFL5Fhia5tgEKhUPWukLtwbmFuIS8YhrjpmlT0Vuy6kJ+oOkebW0/JMtgSfoexJVnHomTTR4DIGMgtC+Arl044wOrK18MPGLSaAn3rzkkYceBNMfuizp7hZSLzZlFHNZsA96JkHThGSZZGb1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 18:37:56 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 18:37:56 +0000
Date: Thu, 2 Jul 2026 20:37:48 +0200
From: Andrea Righi <arighi@nvidia.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] sched/core: Skip migration disabled tasks in proxy
 execution
Message-ID: <akav_OXky-it8HqZ@gpd4>
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-2-arighi@nvidia.com>
 <d1fdddf6-eec8-48bc-bbd5-d750c8cc3c17@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1fdddf6-eec8-48bc-bbd5-d750c8cc3c17@amd.com>
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 367360ad-023c-48a4-48c0-08ded869088d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|7136999003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0oKUeYfdQi45r7a9yqMfTYaHzHnTyUh77y9+edjWdrfOuWt2EyWkzics4O6ERKAuq8xDpdY7iNhRF+In146v5TDr9Rth7y64JG68zAJ4V5kAx6nNCgeBhudEZkIt8bdqA2dPa17yENV17fV2LqIo/mRHWMKVtpsBg3qcDID7HJas9HUm3rRag0V7flucqpPwpSfaeKd9eln+4jmrKFwR5oG9qeqnPajNH4Q5M/IKYX6O8NMGUT6lb6DJ68PUj0U9VXJ/xP2x6LXZ6t1wwrEHskjldjhtWiPMKyix1NsjzzTvNdxRxWPXDlZc1kzPqs5nCuVjqp9WbiDXcLrd7YNd9FYJSCm1QCdwewvDslWZnKgfFnKGNB5YKKNCCApo5QRlP7DpqmqX+ffmcclojSd06fOqXJqn04x57a8mNUiDDC+rFHKJbvqalqFIAkN7VJDyQis/I2FhuQ3CTDuKwq/ZSoCp9vtcbqQck9oR++PKmWvZO0Kl2hWFHeFMBB2ziHFjQwM9GdSe0Ja9aQ40qkUIzN77YeJ1c3OdgU0Az8g74t2Q+JTwklgPbktWIfk5myp6JuW95m6CRQ5JPcMg37p8vm/1rqSCD2mIMDqV0d9MWIYQWv+FRFaFPn9hjN5A9TTS3d978rPmmYTifzyy4Qx69DLwjZEbh2KE037CeKB/NeU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(7136999003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?25Hi4vIsrPh6uN5r5QjArnjBYW5WdQ3+p2Bpeuq5cY+Hx2LUPWi4VwPL2IED?=
 =?us-ascii?Q?i6TvwC8vpEIcs23KL0/nTjzDfQvie9CWiUtGtIu9Rf4beDtZRuHP5bhhemHt?=
 =?us-ascii?Q?FR+trBQr2MeH8y8jEg5KVAiq43gQpUUXdTybhw5etJYF8/49ru+T6szxsEqB?=
 =?us-ascii?Q?im7VytLfVH/X97Zo8xkdzy/nwqIV57y67BH6vROYYDPz6+gY9qbq6RCtgqyz?=
 =?us-ascii?Q?M/sRXxbMuhZI8MZe0z0hZp1o+NJTwJPhzx/muNl240bsoT1I6qETALV84Gpf?=
 =?us-ascii?Q?+dDbzXCUOjANshcGGKLh7oq4/vErtt0hekAOYB2yJg062uV6jT53LGLEGr3S?=
 =?us-ascii?Q?TOWAaj23CWiVKOX5f+WN/OflIzsGQ+OiSfFJj1YlQh5e7VRxSRClVEUu+GLg?=
 =?us-ascii?Q?q/d3Rs1fY4RUzztnpqc2oQp5Ha9Al+x4w0qG2IHifcCnr2eWr62t2PQ6RZZ7?=
 =?us-ascii?Q?/3nxHPKDRRxnA/KIV8pRu2lc7ixZmVFJ10HgeF3ePma3SygCIRkx+GtGlhKU?=
 =?us-ascii?Q?hggd4bd25cs3j62Mn60ZDKp5qzwBeDOTAEpTOUFds+iHDfd0lw/NLFreGsar?=
 =?us-ascii?Q?+sgKsYscXdUOwq+bnH1HZ0BVk8kbtRGgU20nco02potDNP2GoRY5PxGT/vJ3?=
 =?us-ascii?Q?O1OT2oMwRPbPjqWiv8HEzlCFjM3ijij9oNqF+XiLqLodkh9p2HsRSG41UAn8?=
 =?us-ascii?Q?WICnqKsiQ7fuanrvAeSJrVs6aVZkfhj9wO48gALoFiGF3kTHXmRwTABnpCQD?=
 =?us-ascii?Q?t0NEqTa5K20SnwmEgNBw348YXvlBtMTS4AZUBH0QmrNssqAaVD9YtuwV0XDu?=
 =?us-ascii?Q?BGQD5jwaum28Ssnf4jyYbQ2Uuu0SxRsZUzH2LLpgTsKhMJYBhQMBpxXWIO+E?=
 =?us-ascii?Q?TRe2DAUhhIDjkAY5qTZAlYIFeOatP8YmGicw2LRn2y0WaoXjtjZsV7X/8ZfO?=
 =?us-ascii?Q?MTyXJyPdp3AsqvIaAmwwGEvJSsKIq/oEPOeaP4pFFgQiVIDomqealABOOFXw?=
 =?us-ascii?Q?s0UWYqJiCdDtMN3XWBsx09tQnnKSnxP0whe16fmTfdd9QJ3CfpGK7h2g3dun?=
 =?us-ascii?Q?IRM7iBr/Qb1L8pYDVj1NSwmPf+bp3dHPn5WK2klven1UgsqT6FkEqc1M5h7q?=
 =?us-ascii?Q?ojwQYTtplP7B2jxj+2p05WLQr/THez2czvMBokemds3wIskvZLoCJ71Kk/uV?=
 =?us-ascii?Q?NCCfKA8cliELLuENTRJ78kBz2FPvSuFmyi/mfp9i0JGvKUesngAwsRWFSntV?=
 =?us-ascii?Q?xzWaG6NSVjwQxPfiaAX2AlVxmT95lOP+zqxHe1z001P3wvjGj4jaFilexQTy?=
 =?us-ascii?Q?2fPE/5uXgFmNRm9iZtfzaFoTpYFgvgJitCYLhxvpRKQBVI8STTS+nOLPhFLL?=
 =?us-ascii?Q?+THymt1bJNgv8VXe/4gr4CmwFcJe/rge6UcbMyVZhizITFNzzFFGDsvSM/dc?=
 =?us-ascii?Q?G++I/lXkp0QBIQmKzHDAvPwXnWmG5+xYnY37EVN90wP/xCRwN8/qPg63bCm4?=
 =?us-ascii?Q?e2nPgj23gTeqSRCDQNjnF4k4vCH8p53jqtgn5vfq4JqcIAIH2Y1jIJFdb3Oj?=
 =?us-ascii?Q?5yMvIDyURLgz0nLeZxhEkOPKtF4E81c1/U87wDRZ6bJkAXPB5I6DNra9FEXU?=
 =?us-ascii?Q?+jx8D1hBM/2g0QTmAC0QIojdK7nYN3shGA3Ww6setwwvjHqCb7Cjh2ugcVGA?=
 =?us-ascii?Q?JfydJdTF0byxvvbF7atjtj+2paBNaSq6GAkF5LAhLsTtZ00IE7UqMN+Sh2J5?=
 =?us-ascii?Q?r7UbVxiKFw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367360ad-023c-48a4-48c0-08ded869088d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 18:37:56.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HH8+dQLnmjhqqCiK20ApDj6I3sCuXIKw0fMqxzhaX1tOJBJEWjRMkhZ9arj524qlH+QfrMtf39IHWl21nvchVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712

Hi Prateek,

On Thu, Jul 02, 2026 at 11:47:35PM +0530, K Prateek Nayak wrote:
> Hello Andrea,
> 
> On 7/2/2026 10:39 PM, Andrea Righi wrote:
> > Never attempt to migrate migration-disabled tasks or tasks that can only
> > run on a single CPU when switching donor's execution context, preventing
> > task pinning violations.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/core.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3cc6fb1d20547..8a3eecc7caf5d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6936,6 +6936,20 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> >  			 */
> >  			if (curr_in_chain)
> >  				return proxy_resched_idle(rq);
> > +			/*
> > +			 * Tasks pinned to a single CPU (per-CPU kthreads via
> > +			 * kthread_bind(), tasks under migrate_disable()) cannot
> > +			 * be moved to @owner_cpu. proxy_migrate_task() uses
> 
> We only move it to donate the vruntime context. It is never actually
> run there.
> 
> > +			 * __set_task_cpu() which would silently violate the
> > +			 * pinning and leave the task to run on a CPU outside
> > +			 * its cpus_ptr once it is unblocked. Deactivate it on
> 
> For the task to run as normal, p->is_blocked needs to be cleared. It is
> only done in the wakeup path (and sometimes in find_proxy_task() if
> the task is rq->curr) which ensures all the affinity / migrate disable
> bits get fixed when the task gets to actually run.
> 
> Where / how is this being violated?
> 
> > +			 * this CPU; the owner running elsewhere will wake @p
> > +			 * back up when the mutex becomes available.
> > +			 */
> > +			if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
> > +				__clear_task_blocked_on(p, NULL);
> > +				goto deactivate;
> > +			}
> 
> Proxy depends on the ability to migrate the donor context to owner's
> CPU without actually running the task. The task is superficially on
> the CPU only to give it's runtime share to the lock owner. Feels like
> you are tripping a shortcoming in ext core if this is a problem.

Agree with all of the above. As I mention in the other email, I had this in the
previous version, because I was hitting migration-disabled errors. Maybe they
were related to an issue in the sched_ext core, I'll remove this and repeat my
tests.

Thanks,
-Andrea
