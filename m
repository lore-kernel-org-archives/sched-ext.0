Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419024EA38E
	for <sched-ext@lists.linux.dev>; Tue,  8 Sep 2026 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860073; cv=fail; b=TIEq7cwrg8FQgBcT9dQ4+Pq2hyRmLFHiqPfa3DcOkjyFcWEIuCtJtGlYXpkpjODxJ2kWsL5GaVtQ8zMQL1t1oRUEB2n0LWMEwOdsKgCbs0GJu3jZ6jYqlLryHEAlZ6oJgCV5ORp+GYmvSk7VBFu/6f7OujBlMBvj6JHJ7EFBgzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860073; c=relaxed/simple;
	bh=WZ71iSR00DEOCP17RFpshtxijvHQwB499BmN8YhLHdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d87+DCVDtXsEXiUOPxgQGfMARWL1i7NooTeaeIygxi0yFnVqFUJ6G7kn19Hj/5NHPHiY5X0RzYXpg8blY5nUA2Ys+HDH75ZoMJNmVBix7iEPSZYn4Cj67Vj3wnVlshfAMo2M9YrTIa8Y9azfhqZq1P+dEWLTJUHWp01EpUDHA5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qNp7uy4t; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qNp7uy4t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvua/VfYLAjhnutu53fXJBtA73jsdPuSHkqL3ulay1eN4j+6eNGUhDXMUBvFol0xX/uSqQVKPIRBGaYc9QImxF6VAmPBMXDd9TPOQzfM3UM/nD6xbWclIY792W6GoQad2poAnKsStyTyYAed3K5NmBxj5rDOtsVSeLqnz1KlyeZ2pxN6XLqbL2AQQDG3H7tMMYg7lZZhKZbg7KcwgQvc1u55anO62d2uwLS1vCd4V0vF48MbePK/JK6TyfMP/TbTcqj2SEZoOBRlwdhjDBfB9fjsDccOEojJVtpEGFrM0c6AscQBlY/QzgWrsy6r4IBwHRY69D4fACQB8+SmHQ7/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUXs6EiHqfuDVbtZhJ8m2BTZ/2446XLNEk31bRyw2oo=;
 b=sp+OL0nBqvf3K+UmT/tglfwftSWunzYAUhSNJvLXeUXRXgG3MOij5o3BuvVTalicbjKsI8m9+3m+MVgqq41aILTgWiOVO52jEt3Km0PQ+zMR5k29J+bd9r1mcwL9mbJnzSv5Wr8DKbvNJYG5r6ddbv4w74WzBBCYDHHeU9jiF+P0dkIW+o5airHNzo9yR5PitMF8J152S43AvlxPOur89IXYig+zp8OPnzW5L8BEFYKsl/Y6WJ85e+wfj2B107IYoo5HlhOrZKoZ/KqfifMqr8FSs+0LhL2cJyhv6DhxCZDMw68FJ6mUEUDmJNiyXDwWSakUTwCJdvKs9Q6k7P63sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUXs6EiHqfuDVbtZhJ8m2BTZ/2446XLNEk31bRyw2oo=;
 b=qNp7uy4tbBJ+T07aTbodCZiaoT4aciyAX5ayJI+cK9EKID3dRAZIUrurVIFbJPH8vBBzBEITtvbRBR1uxi0JicdjLt1IEJoJf1mXpW3qUxaY5XPqo+E/dWA/XmXbx+RoniNLDMqtSgb0U8giIdiNwJDnnHfLupQX2lx1RpE8ahypflMNgPdZ53pBjt780KVisvp737qH17LRgSkSOkaIbCnj9OJfYr6cdyF7OS5KGENwVkL+caP/ke0BPjyNq2Xz88zzGv+7esQ2qHV17DJxvMParkRIIACSJhVoTQlTGvn54K57FqsbTbtxUfIKFh+bZNRC9pDf2X4ex5G0VbZsmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 09:34:27 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 09:34:27 +0000
Date: Tue, 8 Sep 2026 11:34:18 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/18] sched_ext: Generalize the reject DSQ reenqueue path
Message-ID: <ap_WmoSlrAYbJglk@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-13-arighi@nvidia.com>
 <apn3GHPzhPZtGbSs@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apn3GHPzhPZtGbSs@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be3d0bc-0b7d-4639-9318-08df0d8c5ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2ykO0eOfD01qh99oKXlUfX5J8tQ7DXxLMq+k+Re2zmF3hJlHYByRMq/2nv89WUAdyozHfrCgeoBiQRUzKEW2IMfH6623tUFgFbLzsKi0sl2QmD+ofSc0g9lmFEc13l4rdGRz0F3Zsr8P2q9HZ+715BXILBpNBTw3gxTCZUjK3pDPJo9eyeJwRWG3ku78S+UmkULbYpPqyfD64rQ7kg0ErU9OKVtGKCDN5b+AgDJA8uMb3W48Xf2dC3GbogNBFd3Qbk30PzGbZ09Z6vTpRm1Wo3IxkRi3R58RlVhETK+vMg5D4D8gaAnzyDUJelmCYqrUQtAepRp19Ksh4bHHDQJBNhV+UosYFM8dtByM42lkkNCRbnVnH+7pN11YsqU6mVuuYWWeflqLNCQCjBheZZX+WGbNtLm5cH3ZjNFFyuxD4lHkBltGuW2EBpjRKS12twXhB5bdqRQXq3RXNwIWhiCIPdc4FaqSDv/nuSbKpj7sCl6iSbutumIrz0PnLHODizH2P9E9hzF5F77bC90xS0FR8dSveFg+ZQk75oWqMefhkOW5nZmPRvEKckLpQxi4JjK0+07Fl+Iphmd+hlLYsyGks1f5mq0ZZZt8Ej1pYxM8EJI4v4HtJueWR1wfuTR8aGLjPG49ctFindDBzfS33iF2DDtQuofZ/HPZVIm+MPE7NjY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?++aARTHs5Hlx3duHynjl0BMrgM6ll1wUkcVDexj07aAQ8HgLg0Vn8f2YgGP9?=
 =?us-ascii?Q?9qSPhIUpgbHER26CQVuq0KYZzRW2PjSP1CA/KxiyTY9hbehOX4Ev80lRfyiu?=
 =?us-ascii?Q?fDhCKal6w2oVuUjlFcbZlmPKxje+ME6db/X4pKpeOF5t/kUvuRB4wyADNKkf?=
 =?us-ascii?Q?l0LD5zKYTNco6c2FA6g38t1mbY2J6HcI0Y8vS4Po/Mx3B4xTlIfj1ZJfS7/N?=
 =?us-ascii?Q?FJtElZTecGX/pDpkRBl+sOqXRZj03pC5QyN600Q7k2aYPe8YTJMuZ3Hcb2xu?=
 =?us-ascii?Q?4ZQeIllCpiwe+GFw44fPKZsqbpSwtpDRFKtIaBHPDXABX3KJFRPIDwJ9N6gW?=
 =?us-ascii?Q?vN0qpX9lc92iI+dGKYyGx9VDIfZEvYLXM10o2kTLsFiDCy2cLVgi1pjQRPXJ?=
 =?us-ascii?Q?SIrNMmsWkFCM4VsPsno9WNPkL5J9XU1rkuX32rqnLsh6u6io7XJ+F/Ksucbm?=
 =?us-ascii?Q?OcR9h14y5OnnNQYh86nMO6dDLJ04gS2LAokeq1Q3vgGyqQNHknf9fDUlLzo8?=
 =?us-ascii?Q?yUAPmowzHvCO1DRa5K+zN1VPX9sdivhrriudHnGJ2nd/uuGB1XS6m5Fhaf/Z?=
 =?us-ascii?Q?FT+1vFJtc7SAMliBcvDWifbbgigpVJ/vn8F+l1uo81EoIMm2qzwPmi7lFfzG?=
 =?us-ascii?Q?Iol3Cr3RQxLpQ92IMyExayyatjuAFxz17zIaEqH4CPesW39dWYXPmpNOlgrC?=
 =?us-ascii?Q?CcrB1SDz52lMGxHuiNiDHOWtG2O9EE2jAhWGuPnUIDYGtJ/5IHQxzdY6bw2a?=
 =?us-ascii?Q?nOFSDfDJzJ5jaFiRAMzpnyMG8zTuA2hQILwkuGOLcDZTQnhhT+u5QfWb+spv?=
 =?us-ascii?Q?GTR2neD8bTJ/El0c63L7BlLlYT8KR4CADmcyMwPp1iNqgvTfPA/d6xVI8yeO?=
 =?us-ascii?Q?4Ja7iM8gUTpPLOWiJs0I7/DOPLlsUE6Bw0gXSAKhtzwAX7LSbSj+T/o7b8NA?=
 =?us-ascii?Q?PsHalC5gwwfwhiaDlR8BqfoaEp2wFduToR7KOwvdT5yepaO3xDi4ttKqzk4h?=
 =?us-ascii?Q?anCkT8+Gw+s22der0Xl685aqsgcOaZgxm6bEvHCOt1cMJH0BPmIrR7aBDVZT?=
 =?us-ascii?Q?6wA4TkiS7OIrOQYNJ3/23bwvmrjBp6q6939SmT131WIKvgPB27alPPlpZkSZ?=
 =?us-ascii?Q?oGTWa896WM0YCITg5rdEIwVxMfDEp29E8jC+DbFR6DlGIIU9+tpXLJhbK8Tw?=
 =?us-ascii?Q?KRRgtfMwh13AeEEAPMO5sNaKO9UUyo92/MCHGnWyRFcw280UIeEjzahhoaaA?=
 =?us-ascii?Q?dHaLOw+UopBXGdrTEonjYcqHuAhpB8xrys9QBUzGFdb/QvvSicfF9ZmKbH4n?=
 =?us-ascii?Q?6hCAcGHLyF5/9RFl6l0lvqOHQRNpp337kpwtdjgM/BT/Ry1yh2cWeHexSdEC?=
 =?us-ascii?Q?jwPlo21EddNgGQDlC5VOUk19/AJ3uey+6jCgxZ57MzMocGTGClhetdXhSlEX?=
 =?us-ascii?Q?p6W8oeuWpTG80gZyg2FtO8rwBJmE1pj7lcYaJFaZe9vC1euTy12E8vD80SfH?=
 =?us-ascii?Q?jLb3pF35Jxu0KukROfbs6Tsax7U71mCvj1zwsP7ZrXZkuW/7WIVR0F7i3/VF?=
 =?us-ascii?Q?Sl1Cyua27Rjpgndqk9aO0RZklwG0uquNbYp2+22FIAcTYEvczta2V53LaYAx?=
 =?us-ascii?Q?W7FuICcwYCXB2Am7LLHl4Bit2h6K1boAdnZJXu1ccrjP0LSuJqqK2W3M2zV8?=
 =?us-ascii?Q?Dgi6kq8uvAVeQ1Sqmt2lv5hs94JwMZnGQ3bqLCx1TPlsbNm8rwJOzSrXMT05?=
 =?us-ascii?Q?mfi0ykqVzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be3d0bc-0b7d-4639-9318-08df0d8c5ff9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:34:26.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdeYrAEjHDYDbDyZ7d76cA4e1IgZIMbbsSYuBEBHWB9OYZW/p9EzK3AOGZYRGXibAwOfGx+VyRlvPT7MHOf7Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849

Hi Tejun,

On Thu, Sep 03, 2026 at 12:39:20PM -1000, Tejun Heo wrote:
> Hello,
> 
> Nits follow.
> 
> On Mon, Aug 31, 2026 at 03:42:22PM +0200, Andrea Righi wrote:
> > @@ -1599,11 +1599,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
> >  				 struct scx_dispatch_q *dsq, struct task_struct *p,
> >  				 u64 slice, u64 vtime, u64 enq_flags)
> >  {
> > -	bool is_rq_owned = false;
> > +	bool is_rq_owned = dsq_is_rq_owned(dsq);
> >  
> >  	if (dsq->id == SCX_DSQ_LOCAL) {
> >  		dsq = scx_resolve_local_dsq(sch, rq, p, &enq_flags);
> > -		is_rq_owned = true;
> >  	}
> 
> No need for {}.
> 
> > @@ -2017,6 +2016,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  			__scx_exit(sch, SCX_EXIT_ERROR_REENQ, 0, cpu_of(rq),
> >  				   "%s[%d] reenqueued %u times without running",
> >  				   p->comm, p->pid, p->scx.reenq_cnt);
> > +			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> >  			return;
> >  		}
> >  	}
> > @@ -2067,6 +2067,8 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  
> >  	SCX_CALL_OP_TASK(sch, enqueue, rq, p, enq_flags);
> >  
> > +	/* The reason is input to ops.enqueue(), not to the resulting placement. */
> > +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> >  	*ddsp_taskp = NULL;
> >  	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> >  		goto direct;
> > @@ -2085,9 +2087,11 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  	return;
> >  
> >  direct:
> > +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> >  	direct_dispatch(sch, p, enq_flags);
> >  	return;
> >  local_norefill:
> > +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> >  	scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0, enq_flags);
> >  	return;
> >  local:
> > @@ -2101,6 +2105,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  	goto enqueue;
> >  
> >  enqueue:
> > +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> >  	refill_task_slice_dfl(sch, p);
> >  	clear_direct_dispatch(p);
> >  	scx_dispatch_enqueue(sch, rq, dsq, p, 0, 0, enq_flags);
> 
> This is too messy. The clearing is scattered all over and sometimes done
> twice. Can't you add one label that everyone jumps to for exit and clear it
> there?
> 
> Thanks.

Ack to all the nits, I'll clean them up.

Thanks,
-Andrea
