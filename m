Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490CD3FCB01
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954569; cv=fail; b=e6DTsBOoA5jgO2xrMgk2mNkL8IBkbSzyN8unxEzzoCDCaNZFbYmt6GpjC96ufYyWu2Yg0KGsw28EedfClzXCW6pVPQ9tUUK6CqNbNXDz1yBtmJmuGoXl26bUzg9hoju9u8CWbCIjBjWfb/06lw3yNoqOw1lIcBRQmDZIFc8tTog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954569; c=relaxed/simple;
	bh=ysvQEG3rUt+ehaRt717p9R8NJMwE5UcdzZ/lEulOqqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JcfLEHznO8FbDOYHPvmD1aCjsvpDNC2Oal8ZoFRjTTLEpPLeC6fWtFS0qUEWviPKdi6j0vorOw7UTNrsl484CWsZLLhq+5a38Vuny0gwhkm8hCv4/2GK0ZVQkXpNglX1Zur2GNShB2ii0t7swaZ5u3JjlJeDl71syWkICC8BX8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jx6HrKFE; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jx6HrKFE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlicZ5fN8bizguN/FcOcpd2Dm4SJ9nagju54qtisHeL+yeDJ/RZMaVxawteS+OyMYE8iXaJx3VKuDa8i7TSfsKSUI9o0yYFHWNvTY5fGNdCAYI1JFhvj7emGimzHSAfU5IwH66T07zrF03ARF4PZsZV5Zgb43t08wfLBlN+iEimUu8wrRrmUE0kLtKkuTYXDElfsVWSUGXez3/66S5PtxH2aO3wyGePl6oZd2g0pXEzrN0eAiW5aRJVfPnrsW7D4ENQif4LzEJ3A84AdNULffY4uQdP31q5AItf+93jqGmC/jvV7GcmWh6f6GHU3xfK1CY3tRsu5G/vIAk3HWO8SrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oRImMX4N1bTUFvMs3W1gK7YzL1yfrG4BkBMgs/aqFU=;
 b=G+1Eww/2xEL+BX3YtsAFLc8+ap33vUhlEEg7eOYauTp2yQNiBz/uHenUPF2S/S8yl4VdbqNYnyE/dSU56HnsvDr8nBlkGA3PCNUZVVpTjaJ9oU+I6lFXvTnF899swwvvGTAlme28kfvLvNOsNXcnbiGrZGBMTDFZCPyO16EW86gl0i6GvqA4V0hF1olsglblID7SUcw+JeQJaReQ05nepgPzXUULjKO99T4NNaK38NeSBuYuAK5XMscdu+48s4eSwy47WkckgyVqljUuJcDRiEsc/uXyhLtCiA2YFam45cLuzSB80iA5PPL36RDrfz3M4IZeNFjyuz0fWwuAvY5HQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oRImMX4N1bTUFvMs3W1gK7YzL1yfrG4BkBMgs/aqFU=;
 b=jx6HrKFElxZ9VuMUZ9F2AohQuBLDO8v4D2oVDaGIxNVAsetqv95Xfo8InHpJYYUQXxeQVUkELUnLlj3N570nAJIi1TsWnO17yfnh2iThH/Jw+XeBuTOo2YgAncIOZ0VMfCwOppYldsW/VafHdUg11a/4j7Qeq42Kp6DDzpH+8wwk0AGe1yadWNhJKCl+7kvqTFkfqBBQUtN9BBW/IFfa2WoMHtZyoziNxb0oYaSSYR9GCOAGv+GRuFVydA5vRRQGx49qBMw52MKj/dDlm+Uf62RWq6jhbFo2TD9psqFxU2F1MAW91+gGw89LNX+ZPfPY3Hr5+nqYfw14cDLYeSwZ5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Thu, 19 Mar
 2026 21:09:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Thu, 19 Mar 2026
 21:09:19 +0000
Date: Thu, 19 Mar 2026 22:09:15 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <abxl-xw7nt1jp5qT@gpd4>
References: <20260319083518.94673-1-arighi@nvidia.com>
 <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df1f2df-47b0-4a3d-951b-08de85fbc8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11062099010|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CrB0cyRCKcODdJibJ2f5taL8TQldodo9BWvJImsJQo4uyjofiP3bKciG6RaIbKmxSSZbDndZPfEpPvDNBN3tTWFgIP7sH6qP+lzQIfqCH8g8bYFDLwfi1mytCR+UtqvieYmgN/aE8XvXrjXOaND90xpdz6iAv/EKI9Pzk6J2HXdl/0blRwg71xXEY+jFfwAYrbuqGlhl336qsvUjC+ZT/RjLqTisNnsk2l9QMvv+z/Qapjl6E2V+8yEC/R0Qx6bxSpUAX0lHY8a0wn2Xlv+InwIpvlK5oC8KviEx5dmtxmlj7TnzTzofcGK1+7Qqzz+R4fE0+P0uKr5w/eQC2GrsgwTUsa55FWJQzuIL3YV4jXYJ+LfDWozDv2UkY4DBn0tZHXqa83HlmmFxEh+jwYPepcSOlYNtc18AccKmuZSpjsjUmNdqNZSzZUhzP37MJz/yQKoYIC4rXyYo9J128woFfJZtaDXA6yFpyRLTyVDu19cq1yoCIeOsjmtc2RIYLCELH0rVwlIbox7kvrOweI893SLFMZdpaU1V6Th20j264SvAapY+33+cxsxmF7ZntbatnHrzaHUMGnBlKMHRhLN623/A1NUpalEKB4P1RfyDbbNy1Bc8ICV5MBtZd4QXdrTY/5zqk/4LMvuhKaQOfHOQBwz0nsenw8FNyQPsge4bKBLcITfFG126bWRq4pmv670dpYagHouhlFxkdbp2lj7TrzcPXT5uyiVr02fVfNOcj20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11062099010)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uHRj+w4jwfGql1iv/z/5xKUzveUs8XTiw2KvseWJ0qiZbUmaPIrrpII44Hhw?=
 =?us-ascii?Q?v96CI5fc8NlTXjQe5suZcKyoq8rZxiRbbe9DQrqQrCJzD9fblom4joHQWgFH?=
 =?us-ascii?Q?Fy/xiRTOxpI2CtACCUflV43yH8QdWiAcn8dbCppiPG9FYIdn8afG7nKNB+Yb?=
 =?us-ascii?Q?n+4E6SrCggeu55Iw78ukJVbumE1OWX/+P12jjBb8MMcjTcthaywTOm4lQbL7?=
 =?us-ascii?Q?hn2lkkNMqcQvPO+gFmHeniQrST6mxRN6FJY9uWiJjt6X6llH9WuERPNUjvYk?=
 =?us-ascii?Q?7YDhlwuKq18NKe+nMAhAzE653oSc6bI0soBVWCOIhvZpLcwdmkSAnmo4IkMJ?=
 =?us-ascii?Q?qK7rvxdOMxJb/pYu9AccbdVsca0wa2B3GFYj0gUfwrSkZd3YQjd29YILEEpG?=
 =?us-ascii?Q?NhFDMndFdNlgP19HxGI9qhe/KqoDng7XP5LLQFkhbJS3nl6WoLDrOvxl0d37?=
 =?us-ascii?Q?IdO5m/8r5LDXjZEKwTr0URfIYlLnBFzPsFoBGsaDG7WVtC9qlvjiEFsc4gkp?=
 =?us-ascii?Q?9qDNZNg10F35Ja7gOyYDY0IhjgYxDqdxujKZHYRkeZWqybFnlk7ewfo1Gy5G?=
 =?us-ascii?Q?HaSqsyqjeOMs+BvLFQ8G40U2SOP4XAOU8qbDXzdeuM5itJ3acmIPl7ZyMAJq?=
 =?us-ascii?Q?YRxrCxfCUCuntf/aX72ZerwFUOUr9X1AZpqyci0f+NVwFnaZRYekBhhIGXGm?=
 =?us-ascii?Q?Xu5tXMLmzQPMf4XzEEgQVsjpWSKu/B1B3yLwTdA5d/ZHe3T31Spc9nZLhBOa?=
 =?us-ascii?Q?qHKQZ2z0aKy8RD3bOrnwIqBxykZpEJMV29j+dWPitu9sI3lVDmLQbOwunO1F?=
 =?us-ascii?Q?PUgQD+vye+NHjZE56T9CpetTrEYQ1J5tRslJNJal+dw+jOo35hyvzMa5VY/z?=
 =?us-ascii?Q?dlOzWK8Qf0x3vrCUJaBhtIEta1uJOwoaEHuZWWl2E7Y1nrd6u+lw34ZnG1GV?=
 =?us-ascii?Q?nptY7ClvB5y3GByDYWqCyKAribPS2eCpGWnQhG65LpC0h7ibbuTCXn5YUUcc?=
 =?us-ascii?Q?UrMSutpskRf1XuIReW4Wa3LR4aZ3pcO3aE/vmo+IiRfW1ZHWpKSrRqB/x4gg?=
 =?us-ascii?Q?P2CrGJ1QMjxMmgn2GC2Ta6Tq5m4IR2xw6oVJDIj3rwgBd9v77DNGnHW97Mu2?=
 =?us-ascii?Q?mFb6fLRZNF7qdENifiT+Qm0F36ok7rLYQR5FkpsurTnHWBTqQvj5EShsR9ll?=
 =?us-ascii?Q?vVMeBA3MLDlr2YanYbpCPmYGcUcJpL1Act2boqFrcdaldZozbfDqXTyVuUT0?=
 =?us-ascii?Q?GHdX3Jg4mwJv7grUhPAGA9ONlGSCjGJEomXFc/10UJ+2Qb2fIlVRtrVV9MOn?=
 =?us-ascii?Q?c01rk1NJc1l6/5Co68Qi8fScyF0ZO5FpelfG01RICIPERLSxDM8Rhkqybnna?=
 =?us-ascii?Q?VIzprLJQjuLsIM6Xf1AyYuvOE/ncHU6gXCmrmgLHYpgUePYWoFHj9S0Al/Q2?=
 =?us-ascii?Q?m+ZXPYDtWX/9B3Zy88xT4T/gLuwKqHoAQnGAtN7P8Ngrfdh6yiKJz62P5Y5F?=
 =?us-ascii?Q?gMbMRg+ZB/3u/HKsQpdxebalkIgqiBDeH/TeRwEzhPlLJKxih5qHwdSmQWoF?=
 =?us-ascii?Q?WDCfMXMooy/tLYZJ1WZx5oNe1R6X0Su9svUp4FZvoG0NbNKZWZf3JNja+/FV?=
 =?us-ascii?Q?rGeMYpdFD30ppxRF2ylU106/uov7cWjwyPT1QwZFWfUf0V054c1VK6yaBKM9?=
 =?us-ascii?Q?uQ+/8/dmXqFEatKPmOP/BcC8uFaCELdKmmuIEQHCiQ/e6hC3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df1f2df-47b0-4a3d-951b-08de85fbc8ca
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 21:09:19.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ1lrHwy0MX2IgGp8AQg9ZquRZFB7sJOme3lpsAY2+PMC2gRckSbMF4v1QHGVi7xtO2q0i+9ZcWO3vAAhfewyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

On Thu, Mar 19, 2026 at 10:31:30AM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Thu Mar 19, 2026 at 8:35 AM UTC, Andrea Righi wrote:
> > @@ -2043,6 +2041,13 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  		 */
> >  		BUG();
> >  	case SCX_OPSS_QUEUED:
> > +		/*
> > +		 * Invalidate any in-flight dispatches for this task. The
> > +		 * task is leaving the runqueue, so any dispatch decision
> > +		 * made while it was queued is stale.
> > +		 */
> > +		rq->scx.ops_qseq++;
> 
> I'm not sure why this is necessary. Isn't setting the ops_state to
> SCX_OPSS_NONE enough to invalidate in-flight dispatches? Could you describe
> a scenario where incrementing qseq on dequeue is necessary?

I'm looking back at the code and I think you're right, ops_qseq is already
incremented by the new enqueue, so setting the state to NONE on dequeue
should be enough to drop the in-flight dispatch.

I did some quick tests and everything seems to work also without this
increment. Thanks for noticing this!

> 
> > @@ -2537,9 +2546,26 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
> >  	}
> >  
> >  	if (src_rq != dst_rq &&
> > -	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> > -		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
> > -				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
> > +	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
> > +		/*
> > +		 * Affinity changed after dispatch decision and the task
> > +		 * can't run anymore on the destination rq.
> 
> More of a nitpick, but this doesn't necessarily mean that the affinity changed.
> The scheduler could have also issued an invalid dispatch to a CPU outside of
> the task's cpumask (e.g. due to a bug), in which case the task won't be
> re-enqueued if we simply drop the dispatch, correct?

That's right, the scheduler could have issues an invalid dispatch and in
that case we would just drop the task on the floor, which is not really
nice, it'd be better to immediately error in this case. And we don't need
the global DSQ fallback, since we're erroring anyway.

I need to rethink this part...

> 
> > +		 *
> > +		 * Drop the dispatch, the task will be re-enqueued. Set the
> 
> Just to clarify, is this referring to the enqueue that happens in
> do_set_cpus_allowed(), immediately after the actual cpumask change?

Correct, it's the enqueue that happens from sched_change_end() in
do_set_cpus_allowed().

Thanks,
-Andrea
