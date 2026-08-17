Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0E3033CB
	for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948218; cv=fail; b=sIC75RaN3t0T4GVAzoZYWYSksUyVMgNFAaom9aTwTKcMdHR13gck2ZogrmlGKJGYs6UyPuHtIKfS/KsMN7WVoXND/hSTzfNMN2YnnXGhwQ8Ok7Eou2OVqvMz+zOp/MxzhKwFjJ1Up1HMZ+8RjFfanFEHnm3mNMC6aMzDcWAMlW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948218; c=relaxed/simple;
	bh=JdmDrWWN1XY14AwThkzY97+wkKzsgUAYYwE9SnrLQJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D77+H6eLXpqYMtsqkUbbaAGRQkSceR8OoA84wYztGEbmkbpj9EJy7thGuVecXu7b6Ey4eS0mlxKkhCIF3mTNXlbccVsxUBpGhCr72zk5yxKG2TPXRZStJLwsv26wFb+17w5RfXs5wp7pa/cUw4cMoxVX01DOQ7glf64k+NuTTPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PBGe31f5; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PBGe31f5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUpOkyrZL8ihUR8k6CBQGYlAKBjEbT1xSHjSIkmTr25uXOCvpey2tR2LxMefj3huLZsxOPEVUCM4z7sAh/4gPm2C6woGrPjiKgLbDShgTEJsF85kRt5i/sNIOAhbX/DcM58Do4y0TnshWHHsawTGa1JZ98PuD1/rn+6chiUMVQGWzr/MP8Dl6if/Iw3SEzP/4pvZjMhP+6JbG+EHX+HqVm+mcWS3vFJ1qubOXVN1ISD+PwCelOcXOYwahlXVpfPHesPodDX2APAFhm6I2N5iqB3qBkNayugfG4qURkAB8iXTOZoY0e6rYWGTwAEiXFk2EVjoVH1jv5ESXLFlSIBRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42j83v+Vsrzij7uTi63iI9dnAK72mj3mY48Y/LhIUhY=;
 b=v4ZSI/bOfG0UureDAxY2HuozN2XGSlSpXE5hQIGaXCXwMhndO4vwWf4pWRAg7XtUXznct720cdZRAUh0Fp2DHf+pQXcSRvtduPif63wPUyADEtYrMMvoL2DCp2Wk3lOBVTtS5sHSyUtTmiVQNQfWuzLYYnb5T75TIlWN9iVX7qGKFtN2p6Ej0nMRA+3Y/fJp/kE/XfTCMxIKdF6SZqV5PewazZeVeUIOwZlWlHTgjl6/DLRGRETOLAiCtLGDcj9ttP89pzGGAiPFdQGEhrOrHIOQ911FdiN33JseRAABa/ZRfQIOHOQUqbWXSSMnx7Tu8z/lnp7VKRY3Oaqf6GIwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42j83v+Vsrzij7uTi63iI9dnAK72mj3mY48Y/LhIUhY=;
 b=PBGe31f5iRCndiPeRFNw/cIrWS4tsYbovJC8isvGCS61RVK3IJj4qpFdu/NbCL6bglXr8+hSi8TJd+sZJlr3ySplzAafEt7dOU8cVyBILhyXQTcB98422a9tz6bUsebf4auYBZBszUMuQ9frqiFWw7ni+Zw8krnmZA5mv16OShR/43TtMSMAq+TXS0v5z3oHeaLFyzd2/FQTUl5MkST+rCpoLO1PRVsqrTGP+eHnWmiOO7v732hShqPB0E+qk10Ukw7QVGETu7rLvlayEtWCIaL6AZGntSJV7nDZG7gu6x5bAUw9zMO8cl8OO1BjnX4/I/11Sar21TNZDdmuNvlHSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:30:12 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:30:05 +0000
Date: Mon, 17 Aug 2026 08:29:59 +0200
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
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] sched_ext: Generalize the reject DSQ reenqueue path
Message-ID: <aoKqZ6vwgfvOw5gH@gpd4>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-12-arighi@nvidia.com>
 <f3ec3ccd48df8f75d6fb944151f0f928@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ec3ccd48df8f75d6fb944151f0f928@kernel.org>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cbf561-73e6-450b-f11f-08defc28f8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	z1CcuJbIczsxaWTW8+SNtpPhNfnPGgM2omnPGRabdWTMVGg5+4sY1JwhPuU+c805ixIG4tobIGgYkIHwRkrqqcM6Nt+QXxyaKKFHwgC44hW3fAZxhcJgnPRkjKHlfzoFqX3IMpyTI38q8qBt8cFM2j9877pQu2CJwKsG+bgLEfN2/T/bmf1LN9YHc3whjbKcl68GBj3Xtv3MKEw2jt3e+qg9ZL9gIRTUJiMpahn9Oct0atM6pthd7JRi7UJeq2NARGVCRsF205wIgfJIwO8k/Hso2boqwUlIpCh60Cjqr5nbIEadjZykrSfGa1AeQ2AA4Eh/I0uHDRH9XyyYCbivOAFwOLZloCFdMlw5c8AE03xMj4PqTYAgIsLxCxNKvUnL1NHI8MfeQwiYXbwuvsNqWXspkZmiGQp9sfl70HySrYarP9+30OAmgNSXDHshyF/y8FW/FOiBrjOSNDhqxBNsz8AcENebgagftbJxsxIDwcyXQ/s9AB4qOaM3Emth129OvJpc7qadJ0CtmMrfWNA9mZQucMRVXPA5taoRaUW9jvO+VpQWcQ+DairnhRK2Qy3XzDqPPxA6zFxq44BER7gNBTsUP3nn87NzBsSXyM/I+QNQAT3l4HOsZU8leMokxEtfIHyjE3VPlJwyAodCviaZVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LP5PIL1CzE/hVSrX35k2c8IKczd6lniyaeWOU9CwU6/pfpLkFf/ANUMzN8VG?=
 =?us-ascii?Q?8fXez0H4elOyEibHKu/JgBcpbyy2bcc4/rPOZ1YE/QgJ0abgTEPPSC1u+b+D?=
 =?us-ascii?Q?jOlQpnqISRhBVHlyWNSNNJn5a622PnpRWCy2rBdJ5HAk/KPFL1Ixap3yzFrQ?=
 =?us-ascii?Q?l5jqf8Iln38iQjlGXBX5KdVtr9UYDrfBkExredmht8z3xlygyCybd4A9VWsf?=
 =?us-ascii?Q?Kh03JV0eE5pPtKNL/YvdE76utAwLozMIEJc7sJ+x0o5G1V/Zx991q0XrYWU8?=
 =?us-ascii?Q?n8fQdJvxZ9+VDglxBx7313nY9Z0M58hl6P7vnxTWLzM7kWrlCeYw4D64DLBF?=
 =?us-ascii?Q?fG0uEOzD8IEKGR4fBuq1JAKJq+ILxo1MXGO9YmCipLLG3ROUiD1a0ThvcK7S?=
 =?us-ascii?Q?A1q5f2gAEVI7+LG6H0FMPnPo2m6BoiBSBHsRINotsq7Bw4bqelVQ6NVNz0vV?=
 =?us-ascii?Q?QjNhXzIwiDMQ5jCb3K/acXQVOEkguIJxuputoi63P7gYI9Yo3vSjLUrRrWwD?=
 =?us-ascii?Q?dto7bJGdiMzAXU0mH6mR2s2+nyhU9WfVL5yVKHbEJg200k4qI35djcSgVCZ+?=
 =?us-ascii?Q?DCroyiJ5FWTG2gyfExdSyKrhOtZxUvYFRDiHMiQH7PUIlZdNlBvWVEuVzJAw?=
 =?us-ascii?Q?xiCjQkQh+5NycD1+RPiA827Gc+GqyXJhujRiOL5rdYEzklahaaWOdERsRQWu?=
 =?us-ascii?Q?npNLsdHdiPbXzU66rCMWCtbbzBnyG03FREtbv8BSthMO1KtjsBTTc2ISs3G1?=
 =?us-ascii?Q?KZwl/axCfYZFRETHQJ39+lO1IY5fZ1ge1Jo98O8xUc3ApopCtS3FiOFaPElA?=
 =?us-ascii?Q?mkTYqB3CqJ/Yc6NOtJd9tBohqT0LTEy08LFu5eZnEUcF0dBtX1/0pk79QV+7?=
 =?us-ascii?Q?yw2wMnKrwQ8hDlcmMTT/bpJQOhwBefQOmqRVkbuCMjStf9a99qqir5l1SWR2?=
 =?us-ascii?Q?WGnq5fEy8FczXgtXhc9Trw2+oT0x+aoBWd14nFO1ZgxH2bpCoouMcm82Rwzy?=
 =?us-ascii?Q?s3i1z6qH6O6ZgGQZWmM0J9Fjh6/c6ZkWhEPNtzVmoe8CeFYQb5okFpiuf3PZ?=
 =?us-ascii?Q?iRErcLFu3k6fUDVI5f4zvKpqlOb6kvajX3SPHf1Qztaq6mW7vnuLGHiUNUi4?=
 =?us-ascii?Q?jIMUCP6pHQu9XZXvZbdeyRx/bXn/VevPLtqdhPe7Una4QnmwYMVini5KBGrh?=
 =?us-ascii?Q?433TlgZon4BV6fdxZH+Hp6RXNy3xC4kMOkez/hsWagbYGPMerdgDT/w0oB31?=
 =?us-ascii?Q?Ft9oHBbaeNCuXk1SeLXSP6qmZ3p0+MPf7UD1jzv4y+HfAQToWD9+yzUzmpm7?=
 =?us-ascii?Q?I1vpYnqbxHxzYZf5plkAN8LOtunmkqqGE27c4Arq0m5+crzb/gaLY10N/+BU?=
 =?us-ascii?Q?r5FZ+hCJK3kGuiMs5SFw2m7Daq+cxPsbkT9ItRWJjfRC8N6c3uDr7A6rpR/w?=
 =?us-ascii?Q?+S1iUpAyiulDu1CYUcLSrhEV0TlBOvYEiu9C1WYoaWAyPom9VI2A+5ZzAv1s?=
 =?us-ascii?Q?Mmyix4pbz6mZl3CxF+CBZa/VEUczdwmNZLCO7YfxAJpFcAIadbiNzGTzsGQL?=
 =?us-ascii?Q?8GNqo+KLfgkXKpkfNm4yAjsgGd4VgdrTwzR43nUTo8lYisv93J3UJ7ZozBfS?=
 =?us-ascii?Q?fSfB1OP1FbrAVW6VkQVyafdmPezqBhCrZJctULwiXQHItq9XSr1tSHkhCm38?=
 =?us-ascii?Q?zFoi4LyE3ZYDSmla+zY7x9+KDVB/RUa0Nn1jp3eSX7YNIwc5EJUGqueDT4Lh?=
 =?us-ascii?Q?0hY2T4yE/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cbf561-73e6-450b-f11f-08defc28f8d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:30:03.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IlfZfIZN81PWPTu/Swuam1De3NS79dw5gOfts6Zj8glx2z5/+GoICwfhSSMIyLRpwNbe5dMBeUFkJt7GLKcpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690

Hi Tejun,

On Sun, Aug 16, 2026 at 12:45:50PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sun, Aug 16, 2026 at 07:35:09PM +0200, Andrea Righi wrote:
> > @@ -1807,6 +1806,9 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
> >  	}
> >  	p->scx.dsq = NULL;
> >
> > +	if (dsq->id == SCX_DSQ_REJECT)
> > +		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> 
> Two things bother me here. scx_dispatch_dequeue() is a DSQ unlink
> primitive and managing the reason lifetime doesn't seem to belong in it.
> And it leads to the following in scx_reenq_reject():
> 
> > 	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
> > +		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
> ...
> >  		scx_dispatch_dequeue(rq, p);
> > -
> > -		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
> > -			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> > -		p->scx.flags |= SCX_TASK_REENQ_CAP;
> > +		p->scx.flags |= reason;
> 
> where the drain clears the reason just to immediately put it back.
> 
> Can't we keep scx_dispatch_dequeue() oblivious of the reason and instead
> clear it explicitly where its lifetime actually ends? ie. Clear directly
> in dequeue_task_scx() after the DSQ removal and in the
> SCX_DEQ_CORE_SCHED_EXEC path of set_next_task_scx(), and keep the
> conditional helper for the reenqueue sites, maybe renamed to
> scx_maybe_clear_reenq_reason() as clearing is conditional only there.
> Then the drain doesn't need to save and restore anything.

Yes, that makes sense. The reason lifetime belongs to the reenqueue transaction,
ratehr than the generic DSQ unlink primitive. I'll keep scx_dispatch_dequeue()
oblivious to it, clear it explicitly from dequeue_task_scx() and the core-sched
execution path, and rename the conditional reenqueue helper.

Thanks for lookinga at this series!
-Andrea
