Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B5424D58
	for <sched-ext@lists.linux.dev>; Thu,  6 Aug 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007254; cv=fail; b=dePX96WMbS50/97HBZpRRbtwXGp9wkZr09mtYpNqNm4jzoXECfOEvbdI1xUD1Xi8dM9rPgiwzoMFP3ZewITGvMP0ZKZPI/2Kre9DwTwxNW+PH9MrhuKouefKgjyy6ggQSBfmkxld4jQ6jc40vqeag6k4bDA4LlVk7MoJPOOnW8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007254; c=relaxed/simple;
	bh=j/+lnV/WQdUeZQ0K4o+M8Y0hOGIRo5ms2d2tAg765J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huAC262vgRUkNZv/ZIQZB1PpbIfPa9LpIesCS7i92Kd7SZ21mv1gd3+kF3QvVDXkxgr0y5STaZVZH/hMzwrNUMXVs2R/K8mjawRAgCcZi3kMQbdaYlo3hDHwhXzxInRjb4ES5dQYwdkuXVIql4qHriYegVBK52j6JDowJCxRyBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lc9WviMB; arc=fail smtp.client-ip=52.101.193.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lc9WviMB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/9iRoUT8u2qdOxprfC95EJ/AJ7aTt/AretKodLfvqWTRygAc/oAPdBYtuLJqn62k4qSuv+3kMYo/T8AL+kqnn4N7tVzz0gbj1vxS7Xgbx7fkz4Qvy4hccIMI7y5svYJb5PTgxkEQbu5rVX1Y8wK55/vRxcsc4agt0uWKh+3V2FJHzgX03AFaGnY0gcSw6PzBz3ce2A/m5MiSPdnhrj1S1FABewQ6FtNRchx3xGKg9eqdyZ86mrZ2RLA/7GPQ/yrKBFBT9+ZhH0sTVsALhkwtBIKSCDkdxOwQnC9ETmxBsUD8Hqmiwubd8BaZ3Cd5DDgPNnNR9Y1Ya5CkqLH8+vW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkg8+sPz3+1wPdCN2tI4PCC64X2aXBhfDnIol65qdG8=;
 b=wpMpb837tk4iUJYLgMhJ51zbMIqDBOdjsG1Ai5ohcLv/OkZ3HfbhgVodk2hP3pojyZ4B1bZ4+t19Lrx09WHxBQ7O2RMf3mvzC4Z9ZyHohJZf2F6MAjlvLbULeI5ih2jOiGskBuN7uWpnLfWBsL7lihHjOUvch38jNCqCV7x7OhmEH6OwiNV5q3MpGp5uXgboQj3loIEXtGVIOoFAiSK1lOMaC7Pa5TBT58NQkjeH9STtKFGaSe+lwzYYGSvsby51WjsFvFMGjiG/AScGPZwSGwYNNPRsss+mvmMzdHI8QcBVsVGuuPf77ojHs86GlB+Ce15zVV4P+GXI9Cz+INjCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkg8+sPz3+1wPdCN2tI4PCC64X2aXBhfDnIol65qdG8=;
 b=lc9WviMBK+TNPs97KRRn8fk//8dnaTtSJhoH3C/f0/Z0EG8WpyLGTAVVj3VevjZBzPGpvxyGFbiT4PeBWctVmbbYcESpdg4CZOsPOWxQrG9TMsBmFubD8kcHkPg/t87roVCFfxBTtVT/d4QjCjuzxVFr2o1e8W/PMd8APXhYT4TT0N1o6Et1emUzE0kfcLkiqIG+sg/x7OLd3jtlC0r/l8cPG+NpwxmFuMZ4FLk879K4QDCcXl6gYHRz9ny02QNztdf5WJl7N84cAu1wc6NAYMK7NxbpHpfNA7TmRic3qi1bf0Gkz+MkwpabByYvaZkZgdgFi/2kBgnjJdDEyhmX8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 09:07:27 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 09:07:27 +0000
Date: Thu, 6 Aug 2026 11:07:11 +0200
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
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] sched_ext: Block proxy donors across scheduler
 transitions
Message-ID: <anROv0yJJJCrR1gy@gpd4>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-8-arighi@nvidia.com>
 <anD72EDnXYgSg5Eg@slm.duckdns.org>
 <anLf8lH8icsdd3Yl@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anLf8lH8icsdd3Yl@gpd4>
X-ClientProxiedBy: MI2PEPF00000B7D.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::410) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ba951e-d210-42af-e1b0-08def39a1f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|4143699003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qe+V3sWuB2h71Yg9d6nfhfBRsAaE0eyVi4aMNYHx5gmVDtWgDGViLWOkL/3PnR5cdswrFv13olxrQRX9KmdrL7uVW1LXT+gcMZneiiXFMZM2W0yselHL78eS1i0Zlz63njHlSW1vcICagnLEKF6CC2LOjeY4u+IR6fIBjTurJ9PN0J8WZw/x7MWD4v77+EXbRoSE6hrcbGWmZr7Rs+NRsr1nuGFdbIpIn9I75A41peT0h666SUd4bThWs/G7KTxgMMzNEPt8ojQtGDq/6L7bM4abD590BQ/xF4I1d1g3TaZ28GpkTsEEZojxU2i+aDGAoyQMoALgTY8I6+B49R8i6IFd3zcnrldNhO59W3myY//16zVuYAi1N/CzleL3PQfiH7iqnWGPLMuf0+fnviNm21KkwXhtq74Znv43iy04HgEw6jrFPnikiC2X5oyaec6t95Er+lQq5yKpF9mRSz2lYmu6O0EFgLQ6U3GJ/j7hIudhGDBntFhGI3AQjCZu+ZEeaFIqJ7PKOsrilW5VFE3JZcdpPDPd2oBwgQ1RkzOLVom1bDZJ3brBjDZUaLL8E1YVhV/tPPIAz9pPq5h7oqOD5oEmgaiFnysLTOk8bnPYdEnPcfAbN/pyczRq1AUSip4vu2gDB2fWc1uXacWfYNRMVS6aXJsQpfQ1XMmH8OpIXpQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(4143699003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5jXqUXMp/zTxhqxQH6FZ9y/FxiRgL9+1brYmstMU9Z+/WNkPA3hoDiF66HOA?=
 =?us-ascii?Q?UHcS+2wcvCTO8PlbB32XQ5U81pJJdMKZcusyZypoSPDVv9ZNF+eGHxhkIOW5?=
 =?us-ascii?Q?F40XcDaSkdOelgb7e0QrmUe6vLT8mddHYOsSxCt53y5X6r2BER7dVizRaSb5?=
 =?us-ascii?Q?l709afkuhhy4wmK4osNAua32uIVfHId9eWUPeEJU8D1G7Wk37jdeqy8poOVc?=
 =?us-ascii?Q?6nZ7e6HERCKcrSGoNPpHu23B2XVKMVYbYdya0LVIpOntiOHuOxQqggn07ejT?=
 =?us-ascii?Q?LDniflGj6XHuXQ2b8toVlo0dckJABptkygd7HusPoxwILBHg1nfjQ2+hsVwu?=
 =?us-ascii?Q?8RQKX3lRyqwOJFSgfGHHZmblp/wZHU4YST7RI/sZ6m79UEzUU/7MqhcKe4KV?=
 =?us-ascii?Q?150UjrVKUyzU7LKlYKZRUIf0MzGp/mrQ+9bEGWBZIPBY/xkY/JH2cMshzMhE?=
 =?us-ascii?Q?EvaFSMvFQOvnqkF5Bk74vRhh7k7ptA+389RowrHbwvqNuDuCjm/gpbfJb/fB?=
 =?us-ascii?Q?gSIgV51QZmmxEiPJO0M5xFO0QDFI3JXXfhRXyMlL3gZn73klzcsuV9uT63AS?=
 =?us-ascii?Q?IFtkVPfM0zASMh8N5dtuWSieGM8Ccfz800Kb8+olTEQ9iqHvE1h0wnZ+FpAv?=
 =?us-ascii?Q?oPSTs4mpCfpd9UIdypUml9YY7O5LaM0HlWDiLLphx1OkPqDDzT9qPEoP9l+Q?=
 =?us-ascii?Q?jlz4qYm2yKC1VYeeKFVkM9DCMKhlor2UheopHMioXtucDYJqY3vKWeDvnl1Y?=
 =?us-ascii?Q?MpG3t6jHExSfB59g5jXNdmEMj0Xzl22Bi5dKRcT742dlBWmsClpvqypogifi?=
 =?us-ascii?Q?3GluUKuJ9QHl32WD9UsMILzfTngupNp6GQEwp+YbgxXmtIhGqJXmN5Jlxlwi?=
 =?us-ascii?Q?PLuQsZ8trMWtM2Ov88L0a3i1hbpPnrJAdefithWXECbNrDbPYhtvDD3v/cCg?=
 =?us-ascii?Q?He5P53Xhbg3sY7jOilC+L5JINSMwFVWiy8uFc2trkVP8BHalrGjUDa6P5+8t?=
 =?us-ascii?Q?D3ATjmHt3czE2EHE/045SMfB10vFuvwRGsCZse1j+mxT9ebQ08UOY+WzJwMz?=
 =?us-ascii?Q?EqXq5c/mFQH6dTjIAj7g/0mno29cGUEDok/vyuObnQIYI3auiWfhbPfrb3aF?=
 =?us-ascii?Q?2Cz410mI02AhgCSz8m62k2E0MDP39Red2ciZt1rpAuRhPZvTcMbbPGY5uGMY?=
 =?us-ascii?Q?ZQlTCDWRUm25jANaGjEAsrYYZ6I9VUksNI5wzCEbK6U/WwHcFvt2KY4F8yuS?=
 =?us-ascii?Q?H7wop7VQXKV5QxmC5/xL9dZ2SCONeyLKa63hgX6u3qOzHfv4tZWCfGZ0N7ct?=
 =?us-ascii?Q?ZBJOaRkCnSLK7h7Jq7KXCsyqUsQkRa6UjXm8DBEn2/VajGYvxzarEob+7fSe?=
 =?us-ascii?Q?/l/o8dqiv9FaznB2oQwqk/y/tX4hggpWEpTsOmwrAUYDUdJvtHizcZzO8L9E?=
 =?us-ascii?Q?3Wyqc8VOIvJAVc2e7j7lQIaCPX5ovNVLl1i9oERsmGTLiROIqEOk1RdxG3i3?=
 =?us-ascii?Q?QU1oWllSqEtTL2awHQUTftc9BQIeHn0jcTuG+S0z/IByxML6P2nbdDKlkKtM?=
 =?us-ascii?Q?HWEJwhgZxNpOSAILS8JqGUvZ6Qxx/ssW/t8ar/MoysgMj/2qoL6VxXtHf7bG?=
 =?us-ascii?Q?UgsftgSo8m+3kWLT0nDX8fCou5iz6aa8uiISt7wR3gXs6+RMdZrTw690saIh?=
 =?us-ascii?Q?M3kvFnZLBiwZghzokSabYjD3YDLPAEIO2/U3oPY8MAtnukK9mkoQ2BBZ2bU1?=
 =?us-ascii?Q?rtp/Oefd1w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ba951e-d210-42af-e1b0-08def39a1f88
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 09:07:27.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE+Yg8vs9OuIyHF9RU3+4Zhw4Uq/iMxHPWoxIpuyNuWto8GIn+d91pHp1vVCHmCfmcaP+L3lOTFZvZQ86AzdmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121

On Wed, Aug 05, 2026 at 09:02:10AM +0200, Andrea Righi wrote:
> Hi Tejun,
> 
> On Mon, Aug 03, 2026 at 10:36:40AM -1000, Tejun Heo wrote:
> > On Tue, Jul 28, 2026 at 05:43:25PM +0200, Andrea Righi wrote:
> > ...
> > > +static void prepare_switch_scx(struct rq *rq, struct task_struct *p)
> > > +{
> > > +	lockdep_assert_held(&p->pi_lock);
> > > +	lockdep_assert_rq_held(rq);
> > > +
> > > +	sched_proxy_block_task(rq, p);
> > >  }
> > 
> > Are there use cases where proxy execution instance needs to survive across
> > class changes (the mutex rt PI, maybe)? If not, maybe this can be the global
> > behavior?
> 
> I think RT/DL PI is a use case where a proxy donor needs to survive a class
> change. Example:
> 
>   H (RT) waits on rtmutex R owned by D
>   D (FAIR) waits on normal mutex M owned by O
> 
> rt_mutex_setprio(D, H) promotes D from FAIR to RT. If D remains a retained proxy
> donor, its new RT scheduling context can proxy-exec O, allowing O to release M,
> then D to release R.
> 
> If every class transition called sched_proxy_block_task(), D would be removed
> from the runqueue when FAIR->RT occurs. The PI boost would then stop at the
> ordinary mutex boundary, and O would execute only under its own scheduling
> context. The same issue exists for RT/DL deboost transitions.
> 
> Potentially this could be generalized in core as a per-class "supports retained
> proxy donors" capability, but unconditional global blocking would discard useful
> PI behavior.

Following up on my response to patch 12 (which essentially contradicts my
earlier response here), we can probably take a more conservative approach for
now and leave more selective handling for future work.

While preserving a proxy session across some RT/DL PI class transitions is
useful, terminating retained proxy execution centrally in sched_change_begin(),
whenever the scheduling class changes, simplifies the implementation and it can
make the initial integration safer.

In the next version of this series I'll document this limitation in both the
code and patch description and leave support for compatible RT/DL PI transitions
as a future improvement.

Thanks,
-Andrea
