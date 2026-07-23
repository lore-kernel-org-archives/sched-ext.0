Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F357385D7F
	for <sched-ext@lists.linux.dev>; Thu, 23 Jul 2026 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825288; cv=fail; b=IGdcXy/H+2CyiYSzoDhcg0hklmdwh/SO7vo8xqUqU/LprEIvjHenPT+0HqiWeMnEjW/UqSYrj41W/SaeW2gHJEaoHcBizemv4rryDOOys4MyQB2ghxCr/F8hocRyZH793WTvygOV47t/YoKvCJ+ELWKbJ3li5EFtdXhGRlnAnAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825288; c=relaxed/simple;
	bh=poURGhcHicnGqtePGspwTf5PX4Y5c8vL5UeZgPA3l6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cjogj4SgYvd8EnVTtunrhtqbhehXwFufG8BOj934ou/j3BeCsoXmmI9UdUk++GL9d7Bcu6MciCRuMfTsoiy4EO83Kj8DaPrps2hKW+txB5Bek4C00Fe4+o4eglUEbJ8/QYoFoq2sTtQr90lIWFvbxUnkrxC4/aW2/ZBx+r1Jklg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a7T2UCyB; arc=fail smtp.client-ip=52.101.57.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a7T2UCyB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBETdM19RhKl9cAqBMg2zj8QLD+KGTz9V6t0GVKnpkXZgeiKaWbLmwkgQ5nN+6RcmjQiLU8H2uqjlgPB9jNkbbE1iOsNDi+IlHNnXN2p8Algg+7Rhi3nCxRerQ7a5oaOd2VJ8Z7EK5k82/F/9kwocsrL93FmeagZtIwCKARkbYoEtE0U8E8JIcsC2hkis5kpaQs42nwbFG4gGxWNPdGjVxABYekduGUL8peWjnpA5kLDBUWDxZ3nVTlbHDUoXU/wrdMJkNHj893GBvR/1KJlSGqpUM6yIiQRcuDhv2/6WnQMViA/bKflwYRfTu1NFA7wknMx+XP0gOxhl8Pwhm/PCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afkUZeVd6qWsqrfnaiOMNyFHoslmCVkVB2wDH/YRexU=;
 b=vLYIsAIp5LCfqXUW6DPGC8UkibQLqP4uRWg8DFVh8/5AuO00NsAjYiZO+Ls/ZN/llH/8WNP46RAu16aDHzyHDQZAn6CMXl5ZZHaqdLmUFCnUVjxtd7jTL8WHe5PQf3H9dQAlPiHPh8h8OGw0r7mu6SNtQYLPwmhkQXjwt/SFmxDlGJPFS2BEksIwuo93pFL4LT6q1xk8Woj8XrOAiLSN78/nlHuY5ZBMP09FWJFLL+UlEdhPt8rgZguAXBw+YI9XaE0Kw3ccNgQF1l4GiVh+zoJ4jYyBEVFVXAY9d37fUDFGGh7OjnixVdg6V5bir9BkQB65v3KafdhcSFwkmaZEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afkUZeVd6qWsqrfnaiOMNyFHoslmCVkVB2wDH/YRexU=;
 b=a7T2UCyBc97PWxO0kcwIj9QG4RTt3LFZKFlSc8FxVX6rGUCATrRsZbXLOK1mBotv/FWdayi5uk55sn7zcYFo1Hn56WHIuk/+yvxqJMF6im5dAG8IKR7hI9SFlndNXdY1XcLOIkqIpZNXN4KWohLsuT6JeTA+TKXjm1LqLe4hGwA3IHPIJjb1Xs8GVuS9miR6kror86hNJ8iHArvupj+T7qiGJ6Hcq7g7O7iYafI3uMRqTIzjeCrjOL4IQVA1cHdSFiY97jP4FDlYu7HZWvDWSEc8Hg19Lbc4KjIDvFJSZ0D9RSa401XWZozRCz0rMRzo9CLalBwGUKUKQBOEvbMzyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 16:47:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 16:47:55 +0000
Date: Thu, 23 Jul 2026 18:47:41 +0200
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
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] sched_ext: Block proxy donors across scheduler
 transitions
Message-ID: <amJFrZ1wRkjAkXu_@gpd4>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-5-arighi@nvidia.com>
 <7a3647c91dac2faa35fd6ba29119806a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3647c91dac2faa35fd6ba29119806a@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B87.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::405) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 88aceaae-36aa-4da5-b6b7-08dee8da24ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|56012099006|5023799004|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y7xy6YymELnpT/BCDB1OsT17Pe3ZG1p7selw+LrcGVT+y1R+gQdaHDXaBrcCSj8LFC6+GI3zHt3oJnxd5XDTwAKFgGEDFUvUFs+xYXlzfMzSHVZ9Gnlimf9BpEV3dcL7FYHgeOHRMe5MfmV9vYMhDKMixWSvCIrQ5zEYgyDQJbwh9yz1h8KtLsq8qjFkRFkMGlbUqtexIeR6+5tlVCU8dg+sHA0K4N9SqwiijdmNh2lDqaaEGKJ7JbVSkyqg/bCHzeUUr/v5xyEKU3Vq/UTE9cP/pSBIY8aHj435CNbjrCPz+BEw96Q4IGiFJEBNBvRbo7JHi0lujoPn2tNDzSzLF4vwIQ4sun8DHdyUbLuyhNRkrixlQZvxHQJac3Y7g65A5NF86TJteibSUEkUlcmjbB5Bpg7eK5wWGEJrYyVECzB0kAlyIYrVx3zx4/bvw9Dj5ZFEexdubTfTbaRtn/b6gEVXQ4DiIMbkD9iIBGCNKcoJzEjag1htgmyUAj7V4o/fe2nV4p0CKdBqz8dtm2JubR9ZmDS1T8QHgq9mieVOgE3P6/fUG9p3H9/EhHqNAHp51di1fRAFeNGn2wqoo7yttE6DUw9iVnbLXjJdK6b1tdwq8jL9MYHIv1eZNEUxxN73v+f3OyVQAvuiO7K4+ZWVl5j3ihxMs4cTQFKPPBRRFeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smu06MUgn3fZkME6z5xG8s6TH0kT5PmUs/wY5726CgE+A8Kh671l5SAqvgFx?=
 =?us-ascii?Q?Nu538zBmWlOnWs7HhXXaOy3CAiibVd9an/+sbiIAXJzFTSRM06ovos1AqA48?=
 =?us-ascii?Q?yusyhZ8kmW8nuHix726RrJr7AirC//s/dj5Y5niQsK9hKfVV8CHT4DWyL2kv?=
 =?us-ascii?Q?t/GuY7/s5KVEtcguY9XgePTjA7vS+2RMGKw0Az/APzuZ2qBxCliYGac1e97Z?=
 =?us-ascii?Q?4uOrYtxGyVLychTy8uyyxg/VP6k0wbfnblsaB+pV2Epq5oeB5JE0QutTdzVk?=
 =?us-ascii?Q?Nacl8tPN/BWqcHED0Rfoi+KwCw4T8yvt5cbCVJxX+WcW+bLUrjDiQkX+XW6R?=
 =?us-ascii?Q?ZgyctO55Y1XTBhmRp9yv/ZdLcHreKRs0qmu+U+7yTaLiG8GCxsK0EzycoKTw?=
 =?us-ascii?Q?xCsjo7KlBJPTO3CdR0WF5JXSV22q846iNtT7IoPLRL5HJG/j7ia/TMQLal22?=
 =?us-ascii?Q?+EOOmI/8HI+nd/dmA2EVWxEwJjOxDeY2Pa+3O42hSt/Q2zgaJ2T16x4w5J3F?=
 =?us-ascii?Q?XkxhRdRvRebFXcX+izMbXzGkVTxiN2Nl9Pl8+yYyNc2LqIHiSIXlfF52TYV0?=
 =?us-ascii?Q?U6z7aK1gVHVTuC21oMtlfgulFCJiqKn8wTw2xEmmxvyZckOeuqX94end3+kN?=
 =?us-ascii?Q?f9qdffKhecYy9+OhoNfntFJIv86YmxnBO6mHBC3OTeJq31I0IH10wydF5tvD?=
 =?us-ascii?Q?L0dwRGYsuTRAMBk+2X2kMaEM6WCfDfktjsie9chjD5aZYRCZjDw4ZLT61W6Z?=
 =?us-ascii?Q?6yGPppiemPzojXqlSyZmtq1SilhUjx227iWgRLoFaAVUC0GZm4lDyy962jK5?=
 =?us-ascii?Q?7XGD4TTb5+SjAZfVSr8hTBxSsu01oJHsJALDUS+3nWzR873PQc0O0gjw0owZ?=
 =?us-ascii?Q?XRDH2u2xkiTQq+btdQY/Ks+lAr6UIrXbhfFN35Ug9B/7b25u5cLL0cXjqU1f?=
 =?us-ascii?Q?WbPOUNHyEJdSdWhL+f14OofBPavkxJ/A+HqZieSYbvPVkzMToWs1nlBxk/5h?=
 =?us-ascii?Q?+uEA+i+JBYT0+xnr680XnCCCifjj2YGzItDi6kAI73uAt/SIWgkqBDa85zXW?=
 =?us-ascii?Q?ZWaYINHxC2PKvD36+M4ltT5keIetWvV4yx94AXp9eiXPTj0hErxb3l7Lw4oQ?=
 =?us-ascii?Q?u5f/X8l91A3/s1Xi0eni4w1F/qImUL4KJajMtZfAx/Qh13goEIkoa3y0Jx19?=
 =?us-ascii?Q?0YHPPPbgS4xJSxaA0SoGS8hhlhVAKd4L11KWQ9Jfo3/5y6hxZSlh17nfOF0M?=
 =?us-ascii?Q?AtueCn9uFfZMcXr5PhW0cixbDq1qZhVnk56z59BADMdk8ajMwyMSCKDKS73s?=
 =?us-ascii?Q?vM4++J7eagoMG26Wtj2rKTn22eMQFlqcNphm9sAhEBBLx1jSSQcnQEdNlt3c?=
 =?us-ascii?Q?aJL3RoFSKQLZPParfhzTAAbt1sfherq4Ix0DQ7t9akZCJHzhSQtOQlvAtb6e?=
 =?us-ascii?Q?tzIrCzA8NUBZLKct7VoD6MGXi3N4hlhf4J+mBymAaHJhPw6/Hl+FdEscCT6V?=
 =?us-ascii?Q?/UKLuwPAVWPsatdAWsbb2wRUUPIYgGfpFsN9sb7Sv1ciuCI5Nz/gZVBvw+m4?=
 =?us-ascii?Q?8HpHNWyd71JYUQY14J4FwkmXZqGZq1iraWUuPJAPG84bt9PIXmmURrvWzuHF?=
 =?us-ascii?Q?sHuVh/rkMHEThThhvG6aIBZVtoGWTT0IJaBzkDy4oWtDR+AN/sk1XmM3chfb?=
 =?us-ascii?Q?J6SlaPfwyKaSKcrfSc8LExGQayh7q2PUD7kNYej7tpgCYgtEeuxLoPRuNZcM?=
 =?us-ascii?Q?qkAawzLing=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88aceaae-36aa-4da5-b6b7-08dee8da24ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:47:55.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bAsOLp0dASa0VTFivND6YRB4Z6Re8slocvIDhezPDchS/t1nCQXwm8slp0nmckPOfXEdyBVZRNA0m2IYEy28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

On Wed, Jul 22, 2026 at 01:26:03PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Tue, Jul 21, 2026 at 08:31:25AM +0200, Andrea Righi wrote:
> > @@ -7168,7 +7168,8 @@ static void __sched notrace __schedule(int sched_mode)
> >  		 * task_is_blocked() will always be false).
> >  		 */
> >  		try_to_block_task(rq, prev, &prev_state,
> > -				  !task_is_blocked(prev));
> > +				  !task_is_blocked(prev) ||
> > +				  !scx_allow_proxy_exec(prev));
> 
> The condition fits on one line.

Ack.

> 
> > @@ -7721,6 +7722,8 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
> >  	if (prev_class != next_class)
> >  		queue_flag |= DEQUEUE_CLASS;
> >
> > +	scx_prepare_setscheduler(p, next_class);
> > +
> >  	scoped_guard (sched_change, p, queue_flag) {
> 
> Calling directly into sched_ext from rt_mutex_setprio() and
> __sched_setscheduler() isn't the prettiest. This may want to be a class
> callback invoked from sched_change_begin() on the incoming class before the
> queued state is recorded - the existing ones are either too late or on the
> outgoing class.
> 
> Peter, what do you think?

Yeah, makes sense to me, it'd be a lot cleaner. If Peter is ok with that, I can
add a preparatory patch to introduce this new class callback, something like
prepare_switch()?

> 
> > +void scx_prepare_setscheduler(struct task_struct *p,
> > +			      const struct sched_class *next_class)
> 
> Fits on one line. Ditto for the declaration in ext.h.

Ack.

Thanks,
-Andrea
