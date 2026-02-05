Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4E3EDAC9
	for <sched-ext@lists.linux.dev>; Thu,  5 Feb 2026 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309622; cv=fail; b=Hz8LqzLdjUmC9L46ASD4/4vHdLuTvdcs3GOqAok1jbqFm3uQaHxgTa8cfNVidlzElSWBSN58oAB1flrRjGzCfBoPPFbAFnxzELHn8BWPexVIP5K6B3hhZXtU8fQ74YTOAm56qFqzlISpHERJlIV8c5IuXY/znpzbvo9B5EJJHPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309622; c=relaxed/simple;
	bh=Od3P50eyqkb36jMa/b41w3xbje9SHzBE5THuDrOADKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BWLxZKc3fa7NNMdWgGlabvMZtc97I+ZTOk8IEQL0VvtNtcta01+CT/KYn/jMYZV4F+CLt73FlAmJ9TUmTMahBCFWBpdJxAKTr8PxYFjtyWTQctq3DXjQaYtcW4t6hqxRgq3F+kfnEJXJreL8qh48rxzDxO4ZAK2YF7eoVHkygDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FvONoP7T; arc=fail smtp.client-ip=52.101.46.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FvONoP7T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gxn47GnuuiOi/3HKKebizkpuVef8zDbmC4qS7rf0aklVNk3q/zuT9gljVbMNah9/ooMw0wiw+Q8J9z3hxGkzCqqTyC8vEJm9VgPy/s2lAy31jCJMIoRhUKJu6AK5yjJzX9cRQU6yWzFhRREhX5SmpcuWURxvni+OFCO+JfASOPBN627YRb0R/17yaud+eR7Cx1Yoc+Yl16s1f4QbZFPMB8DzYZwl2Al9xmd9IWcpuWplM+AWPCUuKEAjvywe8h8mLYTbpLbfVmshz9uxs3eOGiT2/ZiYjHL4EkwdgC83a9zNEm8E46PQlBOxjQLJgc0pQUbCaYx5NKLj9ttwke7plg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM5a8UC/ychfq2X+zZlgJW3LFJnbsHx04fa21R4bMNM=;
 b=PScCaybkVSF4Gjw+/J1t98Ilefq4jDUYU2WIHEMnOweOA22TMDOmmpReJGNZzb3OqerqbH7zCPHlW7Ti2OQSg0s5VvgHui3TXFiYbHlU/iS6bCbkalkcgZNT2NzwyUOdQvAa34yIKG6PzdduG0GEy2+SNujbdrts0U02Kzp6O7BQEt+ZOpzYB+Rzlu3JrAz+hvYSzCctQStEz96C+MXLZwVs8TGvGjt7eEop5Z05wrmSDne0nVZKCGcj3YLM7ReXOazhPK9AOr0WTwFIq9QrcMcOmE7NFw+dI+jvYLRT7Vle4ia0bZTPmyUSmTsCOQ4ULKypWCht6DKGGbHU+B/UFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM5a8UC/ychfq2X+zZlgJW3LFJnbsHx04fa21R4bMNM=;
 b=FvONoP7TPnA9Eb/zQCPcubjlZ4lpwRzRkRi/I/rAwEB5/6matq9g4o90baSIfQe6WMSRdcGcsRcM+/j0U9i7Hk44LsgylgYJ8r3ZvzLSB1Yi0FIQgRVnzx0El1XM6a5AyI9pr2qodia5PI+VmH+xGFa2kBaO0wtgDjcCmzf0PUL4wiT667Fw538ghRBrfC7BVQnO9p+7+0QVxaDWlf+J4s7YzqJF2Br/8LVkF1zNf1/wyCI2F2cxk3h5XsrGxzDCUMP7A3YY61M1I0F9+ulG4m764fECNposnMF53osdXX6NJtPX0hRGMKZvkqwFyE//z3d/zkwupCbWd/qOCpkrmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 16:40:17 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 16:40:17 +0000
Date: Thu, 5 Feb 2026 17:40:05 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity
 changes
Message-ID: <aYTH5XT0YFkznqvv@gpd4>
References: <20260203230639.1259869-1-arighi@nvidia.com>
 <aYPW121Y6vGtmtST@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYPW121Y6vGtmtST@slm.duckdns.org>
X-ClientProxiedBy: ZR0P278CA0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::14) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c9a431-56bf-420b-5203-08de64d53df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?96UX4A7ulRYsCUogWwocqNcI4cIaLKhbFM/tAN9SjRm9L2q4EG/dAffBAYXa?=
 =?us-ascii?Q?YfnTTWlUGJg8g3PAlr9Vy7RK+T6pg4HtcbCDMuzqGKIpEVvNA3DEIbZfGpeG?=
 =?us-ascii?Q?PqLXO0JrNaop+ySCwvC7gJIorRQgJZWkLn2xtyNJ0llsK92buCl92iX+fx1X?=
 =?us-ascii?Q?AfUU7gGXcqr3mI9o2lwDmPwsV3gEUs1Jww4XN1IZLBYa6fyyH6IzAyjaPzSq?=
 =?us-ascii?Q?SEW0LO7kIBmoipuoR4IfxokVhfnHgKHaZ5u5r8q/1oz01jvx1QIr1quXu9dv?=
 =?us-ascii?Q?NToMfu6dgh2QTLHnnYGPetaw8G9I3pFdbiNb0wUMTm6Qc5FYW18LgHcqtsbf?=
 =?us-ascii?Q?K8QGT/EM58Lj39302IsKgsH+4F2VBXhElh08lzR7qVLLoUXv95JXYhNEC31q?=
 =?us-ascii?Q?U9K+Zi35HnpHVYqHubY5v6gr/Djg9sbKR4gvxHEXRG975nFRXqF41MhGniBJ?=
 =?us-ascii?Q?WApi9fB5uFKflcgs7JWcv8gcxhHisMKXB2XolhLXSX+jwfg04DkD6cdTnOjT?=
 =?us-ascii?Q?NtPues019rOtrUDxv2nU0Fs5qEAN9Rozm+K+r51dWtpMNxDy6oKXh+vnQLSf?=
 =?us-ascii?Q?wbKYHfEu0fJwfrHe5qGTzSei9NrPORXYemf8t9xLPNU6PQw0k8yW3G+/3cfU?=
 =?us-ascii?Q?EFVpbXvMOELm2XFBSesDpGsSyAHEq0dMrGRblrYcCxgmHocw+3KrMywZ+qec?=
 =?us-ascii?Q?Ld2zAdcHi35b6BXleyMF2CSRRPVj1eOW7I9beNj47ec3NjJAbGp7vdkuzPpZ?=
 =?us-ascii?Q?sdLK4AsSoIohlT75w98+1vWhhHuBjn7Wb5KZkL6YFGkuK+NJDcknEVv+tNj0?=
 =?us-ascii?Q?B3cw3PiyyCHSJZ0Emw+ptEt3TKY2Y0lqQzEqrtwv3C5MW5x0DtMI8+Ipw9wT?=
 =?us-ascii?Q?z4FvRkiLg6hpUkz+9vTq7HSSp7dndJa5bMir1z8JdEP0lJPXHSlgn5IYmBLj?=
 =?us-ascii?Q?tXiMhBfxvFtuoC8242+IhiEyxwMopjaSCTLdhcuD5q+0mN3CoGr9bY8PPUo6?=
 =?us-ascii?Q?vvm+pzcVBbY/weDDHK456ckZHImZ+UJjTTHWBVHdCFJkWTB6wI9c9GVQiZ30?=
 =?us-ascii?Q?wy9chT4uyu8UK7XuAqLNCc+f7Rz+2EXWewYuk6autWj4wIgcx6w8tPK3d/PV?=
 =?us-ascii?Q?nhlNVUMRJpP8B5IPDwbxEPY0uz5XSVUsbzBfF5Xhr53b4Frzhlzcy+qlgYKv?=
 =?us-ascii?Q?09XKXip56cT4XOiA42bQSXhL0KsoOs/DTYRDKhQKRrO5rDwDKsp99a6Zj79Z?=
 =?us-ascii?Q?t0Tf6heTW4FEF92N4aOHlxxPSOl67rL91Lcu4mdtsGzYS2GBXEMAbSmdr+1g?=
 =?us-ascii?Q?f2q8NXR9rXhDN2GCfpd3TXVMpPLrn69yL4NAiskKsXKUMuOVZTiSTypQV7Wd?=
 =?us-ascii?Q?wSrd7U6Dx6C0n/syQseA7jo9N5tVyc9owV38BJzsEp+9aOwt0E1rxHzMo2a0?=
 =?us-ascii?Q?CnLRTlmqh9mCUItAhLu/jwn8mBBsthaHo5aztQX20fjSOSxBsBjqAI97uU6Y?=
 =?us-ascii?Q?ZLHYHV4IhscmLxmHPzAjTl/HNrOiZNkymQwPtkLGnmadPhFlSHZoyM2ZCGyx?=
 =?us-ascii?Q?0chj2+YhSl+qCafpt6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3KZNwAp5LUuKxE3zml5rBdoM9FdD0+8yBva1NwkqBNxPpxk7fieo5fhoX623?=
 =?us-ascii?Q?yN+eEY/HlYcsd34WREMS/Diy34zrkBlk09z9gfP9O1mXczeq7A7b/4qFZTCO?=
 =?us-ascii?Q?tazBs6mVcM5p3OCcS6F0UtI897kuY0QMbNxOSphVM62bX/Cxf8femDD9crdA?=
 =?us-ascii?Q?jqO/dKQSJD62tITtuyZz4yfOu77YbepglV1sVetv9ouWuGRMD6Ai3RrYQPAE?=
 =?us-ascii?Q?ODCW6H81Tl+Zu1baN/eRwQ9p8x5BhPnK7zu7xoVEvErDU3MFX8DiQjbaxCA2?=
 =?us-ascii?Q?6ebN5OXRkVKW3MiYJou3ga37fu56kH2lJKN6PrbRaLyjfJip2iOFSZ+XiZqm?=
 =?us-ascii?Q?ySbo0fNFeHYokwt9NpC+T2awkyMIdRf8mgrFhV8BTCSlWdB3VvT3v/Y41QUq?=
 =?us-ascii?Q?Eyfg8tHvFdtztngDHa4jwhU7ZbRy0U2PQz9DbYpVZP3hsES9kB76WKazTYZ7?=
 =?us-ascii?Q?Gs4KPrM0e0GkJtg99DTgDqOkdI8w7HqqafnizXkJM1y7cC+LBnBSEI65pz4j?=
 =?us-ascii?Q?Zhud4glbt5/842eWPDoETIN8UH2nQ3OZJfetytF5blWlWk4Y0TLOePUDmeUK?=
 =?us-ascii?Q?g46cHftjZXc5ZwrIAL01d5DwpX6N7I0DyZaT6nwoZk3+DAN8CanP93R9Ohid?=
 =?us-ascii?Q?yInM6Ho3nGeLKrdQ/mEGxJ9zcVs2vWBPqLDLQyw5LDl31ZzwpZv2D2wOIB9U?=
 =?us-ascii?Q?eDo7ud5pZWuVlgxtGqEvz9QR8SJKVXq9JHFTMRjKRiKgg2X6rZOQKLQdxHvc?=
 =?us-ascii?Q?lq23ulNDO/yMZzNceJpshEDsAE21wc5Mq9GvYW/+FTZuR3Ikt/FvvCKEqsYX?=
 =?us-ascii?Q?tm1xEG034zolo9H+r/JDWR9wfYjGB2ZjYV1Z35Vrpx3+3wB86nwo36Ofwhgp?=
 =?us-ascii?Q?8TyJem8wzCpAFzJK1QVmDAqLN4q6K/euu4DsU9hy5Lu/znSphfcGCYmF+u/y?=
 =?us-ascii?Q?pnqXl8SQY7Pe0ipygIP0sJaeYHTXkpmGtYLDbSMp9jX+uXEa8AMMSLLS/v6Q?=
 =?us-ascii?Q?tWAJcpGcDBhBxpSKsdjI/aBN2A6+/1YNtqbk08Lew+OBnuZavJVH3ttvXebw?=
 =?us-ascii?Q?2dve69nUoutBtCDhKag4HA2tSo3dPsX0yyNFGFC6fL+UTeYPkvxH6zRHgV2o?=
 =?us-ascii?Q?xaxz1GsI7Xdp28CZ70qToZLhm9mLfgUy1bPgCvVkWUL8Oyr3GWKKPHxh0ig/?=
 =?us-ascii?Q?buYbcrI4TWCd2iqqGxuSlKhB/qCgaaSsnv9f+hT7AduYQL7ZS7r9UyFgrU8q?=
 =?us-ascii?Q?g7wJt/pri/TtJPW12f7VEWTmRDDPYVpOCBilOmNvfauOqR2TyjoHU5ChF0ym?=
 =?us-ascii?Q?Nu5XET387/TFQabLcwcT+/Ge6qjsAWtB2ewPlpiBRk2xjAEwLFh7MdYULcxe?=
 =?us-ascii?Q?1xZSimeXfeWUFJIXk0Zqop2xzrjcXKM3ostC95rsPEkAAIkpZUB5+BX/uRKb?=
 =?us-ascii?Q?+omtGQICj+W+rhvsSLd21bYhIU8ufXuNArxhdpLPt8M/9+Qi38ceAzrMM4ai?=
 =?us-ascii?Q?+2iqGmU2jDFeluwYFPNYLPMDyhH9+GPlVHSomMICEEBH6N6uCR4dH33L3gf0?=
 =?us-ascii?Q?QTBouW1Zvtv67w16kfTeohjrs4fNTTbJdYiYVQ3MzWmKw6ncoW4D4tG8J0Xy?=
 =?us-ascii?Q?xLX5oGo5zESUZDZaCE+7cA6OwHAOUfh7j+oNkKpS55nIsl0gg8XKC6+lvlTN?=
 =?us-ascii?Q?SjrvIWZpaGUAU5XyhP/jf/MKCJIrIyTIktq5ubvCqfHqN1NIj/S+fus6rIeH?=
 =?us-ascii?Q?dpqLDaZu7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c9a431-56bf-420b-5203-08de64d53df6
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:40:16.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17Kk8OGcMRyVpbis9yURzcs9++3sbct0vlmY7/FvHhFQTq8kBrAC1QF3WTiPj2/cpIYegmpQfzS+BKRBZPtwOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717

On Wed, Feb 04, 2026 at 01:31:35PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 04, 2026 at 12:06:39AM +0100, Andrea Righi wrote:
> ...
> >   CPU0                                      CPU1
> >   ----                                      ----
> >                                             task_rq_lock(p)
> >   if (cpumask_test_cpu(cpu, p->cpus_ptr))
> >                                             set_cpus_allowed_scx(p, new_mask)
> >                                             task_rq_unlock(p)
> >       scx_bpf_dsq_insert(p,
> >               SCX_DSQ_LOCAL_ON | cpu, 0)
> > 
> > Fix this by extending the existing qseq invalidation mechanism to also
> > cover CPU affinity changes, in addition to task dequeues/re-enqueues,
> > occurring between dispatch decision and finalization.
> > 
> > When finish_dispatch() detects a qseq mismatch, the dispatch is dropped
> > and the task is returned to the SCX_OPSS_QUEUED state, allowing it to be
> > re-dispatched using up-to-date affinity information.
> 
> It shouldn't be returned, right? set_cpus_allowed() dequeues and
> re-enqueues. What the seq invalidation detected is dequeue racing the async
> dispatch and the invalidation means that the task was dequeued while on the
> async buffer (to be re-enqueued once the property change is complete). It
> should just be ignored.

Yeah, the only downside is that the scheduler doesn't know that the task
has been re-enqueued due to a failed dispatch, but that's probably fine for
now.

> 
> >  static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> >  					 struct task_struct *p, u64 enq_flags,
> > @@ -1845,9 +1846,13 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> >  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
> >  		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
> >  		if (src_rq != dst_rq &&
> > -		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> > -			dst_dsq = find_global_dsq(sch, p);
> > -			dst_rq = src_rq;
> > +		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
> > +			/*
> > +			 * Task affinity changed after dispatch decision:
> > +			 * drop the dispatch, caller will handle returning
> > +			 * the task to its original DSQ.
> > +			 */
> > +			return NULL;
> ...
> > @@ -1974,9 +1979,15 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
> >  	}
> >  
> >  	if (src_rq != dst_rq &&
> > -	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> > -		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
> > -				 enq_flags | SCX_ENQ_CLEAR_OPSS);
> > +	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
> > +		/*
> > +		 * Task affinity changed after dispatch decision: drop the
> > +		 * dispatch, task remains in its current state and will be
> > +		 * dispatched again in a future cycle.
> > +		 */
> > +		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED |
> > +					(atomic_long_read(&p->scx.ops_state) &
> > +					 SCX_OPSS_QSEQ_MASK));
> 
> I don't quite follow why we need the above slippery behavior. The qseq
> invalidation, if reliable, means that there's no race window if the BPF
> scheduler correctly implements ops.dequeue() (after the kernel side fixes it
> of course).
> 
> ie. The BPF scheduler is reponsible for synchronizing its
> scx_bpf_dsq_insert() call against whatever it needs to do in ops.dequeue().
> If ops.dequeue() wins, the task shouldn't be inserted in the first place. If
> ops.dequeue() loses, the qseq invalidation should kill it while on async
> buffer if it wins over finish_dispatch(). If finish_dispatch() wins, the
> task will just be dequeued from the inserted DSQ or the property change will
> happen while the task is running.
> 
> Now, maybe we want to allow BPF schedulre to be lax about ops.dequeue()
> synchronization and let things slide (probably optionally w/ an OPS flag),
> but for that, falling back to global DSQ is fine, no?

I think the problem with the global DSQ fallback is that we're essentially
ignoring a request from the BPF scheduler to dispatch a task to a specific
CPU. Moreover, the global DSQ can potentially introduce starvation: if a
task is silently dispatched to the global DSQ and the BPF scheduler keeps
dispatching tasks to the local DSQs, the task waiting in the global DSQ
will never be consumed.

> 
> > @@ -2616,12 +2627,30 @@ static void set_cpus_allowed_scx(struct task_struct *p,
> >  				 struct affinity_context *ac)
> >  {
> >  	struct scx_sched *sch = scx_root;
> > +	struct rq *rq = task_rq(p);
> > +
> > +	lockdep_assert_rq_held(rq);
> >  
> >  	set_cpus_allowed_common(p, ac);
> >  
> >  	if (unlikely(!sch))
> >  		return;
> >  
> > +	/*
> > +	 * Affinity changes invalidate any pending dispatch decisions made
> > +	 * with the old affinity. Increment the runqueue's ops_qseq and
> > +	 * update the task's qseq to invalidate in-flight dispatches.
> > +	 */
> > +	if (p->scx.flags & SCX_TASK_QUEUED) {
> > +		unsigned long opss;
> > +
> > +		rq->scx.ops_qseq++;
> > +		opss = atomic_long_read(&p->scx.ops_state);
> > +		atomic_long_set(&p->scx.ops_state,
> > +				(opss & SCX_OPSS_STATE_MASK) |
> > +				(rq->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT));
> > +	}
> > +
> 
> I wonder whether we should define an invalid qseq and use that instead. The
> queueing instance really is invalid after this and it would help catching
> cases where BPF scheduler makes mistakes w/ synchronization. Also, wouldn't
> dequeue_task_scx() or ops_dequeue() be a better place to shoot down the
> enqueued instances? While the symptom we most immediately see are through
> cpumask changes, the underlying problem is dequeue not shooting down
> existing enqueued tasks.

I think I like the idea of having an INVALID_QSEQ or similar, it'd also
make debugging easier.

I'm not sure about moving the logic to dequeue_task_scx(), more exactly,
I'm not sure if there're nasty locking implications. I'll do some
experiments, if it works, sure, dequeue would be a better place to cancel
invalid enqueued instances.

Thanks,
-Andrea
