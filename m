Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219129BDBF
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792272666; cv=fail; b=rjjL5shPxEb4zVa5FX3/xKaUtBtckZQNEKmgqoBsDtzYEzQTVZoYijgkemDYllsd5Sy4ep7zIIrcjpKxB2djlC3+wJEv+MXo5bpen64cxS0WSsb/uh96NsRXjVQGXjdGZP4g4gJjlDLN3vaoy8xri3leiKTT+sV+K72aISa2PeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792272666; c=relaxed/simple;
	bh=5MzmFiavOjJwTyIuCDViUqNZjbsM26T1QkTrykrCF1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YydNBcDlTf9PMvDSxNpgb1iWl3NjyqXxNWr4JbAYFVcrRji7QOoQO8z/Ioq1ri7D4+iMeY2yxbjgyGxuDJLZQvyMHkaQ2uK8oOD9vQQl26oZVhTEjJGhd5uN7JOoeO+MkOmPHrc6Gi8sciFZe5Fcun+3Dax3pEC9f8DCMIxediU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=irud8D/l; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="irud8D/l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sim1HYQSgTBMEVJpDm8T56I7ci/Z5dNuHz4UeXBesOjQyoK0mLiwnsKWvp2/+e8kWwmdyyFjyLWb7FBTrytILuo540Q82pF4i+QpwIgmORUkVs3aLePcctGLbTiVGSkMO3KEI5tperBdOAGjZihd6gwTxgs77YTVosW+lua959lrtuyfWcmuqUsbw75BNI9p1X74Q4dCQi/mK/fOpgDDO0QqZs1UTM1V/2YwyJlCBH8NyEQCnr7K2/3cP+VotC8GWWfykbNMWwSygoVhkXZ80TdcXOaM8vsAKmUwIzWhklgZz2quEIRtmwIUYQJPA5L23sFpa/vLssPh6CA+orzfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAyDlnSslJ/xOFJJcwsM1skptHjxqsatqLBxPvEV0NY=;
 b=Z6jV25pcdwb6u/mGwac1EFG6itZoyBzbyuCgPAh3e7W1mMzV+6aJxOPp+uTrPqt45DrYPemQY0jh7ocKghFx6QIohwPnkrA/pfHbQD5PKizyxN7isuHtYOCMZi2SEMGbGS08zfAk3zTdO/kN8VV/l61oWAyhy8Spn+vHfC0pz8O1fez1Msr2DSTSoKeqVHdQDPAXbta6mSWnPWdt+I1kPjfeFAOU2Em1hV5lx9U4QfRC9hN1cIbvI49cnYDZ5ICOaRrOUHAoL79IauZJF7rxY73FRztVpO7tq7vDGSKEtMJC30AREH/xSVV0ShBrIezJ7pfQVbujJHlPyAZ/MijU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAyDlnSslJ/xOFJJcwsM1skptHjxqsatqLBxPvEV0NY=;
 b=irud8D/l5d7YE/FGqgQJ0xy1kunQ+T9OQi1o+6VpzOSa6Dy1oNLPJ+uex9GNdO+pdYaGuIxCM8vOFhWxqLb8QnmgPeN2fibRwj08FkReZV8xUKHCp3OF3RNVA0IQXqpu1kSYhNOT50uvzmT9VKpMoIwcFjzgJZ/R9I6OCl0H9hHh4OO7sA0pDyWgjwoLKV11zN8atCAzpok//CqXX/KtyLqd3fA9YqBW6UW1deplCj5rKv8CvupxgTHt0/4seACCkq9LGEFn+4CSDjtRWklBd3T0gu+tWQEISxbYz+SQUKvTrOqZievnsAfLyg5Knt9r5SnBZwp5uKpWTu0SsI2xIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 21:31:00 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 21:31:00 +0000
Date: Sat, 17 Oct 2026 23:30:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Don't report a
 forced-idle CPU as open for IMMED tasks
Message-ID: <atPpCyLMK3rnvNqF@gpd4>
References: <20261017124749.3608468-1-arighi@nvidia.com>
 <49d76a6ae49b2e0d5359edc831ffaf60@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d76a6ae49b2e0d5359edc831ffaf60@kernel.org>
X-ClientProxiedBy: MI1PEPF000008D6.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::42b) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0296f6-7948-4d64-bae8-08df2c95eff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nDK34H9az3U4iKeifWCkIZmYFobyYGTFYc95cHSvv/pP/tbs7d338CHashGwOt4JDZUmAZQ6+bLhlHiSD/2bzFi7InkEZ1hNKk0H8XNKEPvu7XC6opkgQRQk2yutjJPt47RPLjrOnpr22TCxemkTHEeyFI5UduA22/XwAXE2eo28l3T0QlUXDsjCI671aC+BBPLIFfzoIWAMNqE4m9Ge+V+dJW+oHiE4qQE7k2HApNJPQo7l71U+wuvYSd7eZCxQrUz/0KZDC/5eWBUCpvLygH8CjfroYToiVE22LyjLgTLy+B+0bT91lRzQwg/XkR1dnEE0k1b5CDTPjerLW58/WrzRTCJvlwWqWAjDCIbEvoILEmnlWUDYyKE4upUtBsz6vHYfBQt51x/CCi1P8cbc3X39Zt+7Ktw8Zj+3J4TUPdfpRQ0idP+PA2dXfaW4HpfU/tDsXhHlnOfAKPpUvsEV3l/0er0r+XCTi2CKAsFXTGxDIKhzBTdjZscI9IVtkd59/88oxj6LVJAg6paVxR7twHtkUfETiWJiWAZrLMwKi1HcoFT0MtAOsFKa7HINKl8DyMuSNMDioKzdsSmpITmNow4bYxbla9SVE4ku75OsBJLbZWvjgFB4/8tg26wRGRV0VvC9RS2gxwHjcA93PwZ65/RuSBsCkRqVnkPaYCVHY64=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?doyG0jCfUpHFgc6SzYLMI5ifpKN9tUPg44JaS4eRtYLd+2tJJY+uXt6hBjIa?=
 =?us-ascii?Q?P4wyobOeleSJ+lh3JMcs1AbjwamOdxbOi3sB98fIDf0axwIllL47BtQjiw4f?=
 =?us-ascii?Q?kGJAFU0cSsjFniWlUTSiyRpEMFJNKZkjZLN6bmZxpy5Ylx+dpeYnbGyplaC6?=
 =?us-ascii?Q?GMLVh49LYRjR8ILmGUVZps+IfNDtLKUV8UJ3anst7R8+m7uUTiFd7zo5pNcX?=
 =?us-ascii?Q?zg9TmDEWaw0BnQMNiGKgcsHhgMn1NISclds70qkfcC6BsoR2Eaz8upCYtUpC?=
 =?us-ascii?Q?RruJH5j0Ab1KAmiAt2FwUVahMyqbZfF5DzpXRr48R9eijF1/ANO5nfsZMH3p?=
 =?us-ascii?Q?ZxHO1nAJD7ZrY3ULe0dOxsfjFPWPsEtzeVoBrIlHBWdTcaQLNE30rMqx+jNN?=
 =?us-ascii?Q?ZJNMAcKTsdHiIv69jYwR/tm8ax4hSHWMiyPrwDymeG8Zu0449RF/1G8voua1?=
 =?us-ascii?Q?8cB6NjKo+IYQAXlx/cYQ9AxTXyVb8Yo5T3nrya6vBB32YUr+ULoKpC3Qh00V?=
 =?us-ascii?Q?+O9g5ZLx/SdDA7X61GY17yIqr9/7YPcZax1ON8hOsu/Ae4pC4Vh9Zd3tYWoM?=
 =?us-ascii?Q?QNtTeSGzMkf9JaWHWd0nLp4QcqjjZbEuTp0/FWuca/DTso/8EtYkufFmPh5p?=
 =?us-ascii?Q?L/zz508aG3QknWCbnzhWzku1laWdnIsuThkM98m7Nz+K1CQCZtNkraYIKjAJ?=
 =?us-ascii?Q?qO51EzKYvC0c5gwgPYog/D24s6P/PLSM9KxVTbkAytsrt/EFyrkwrUxz0ddf?=
 =?us-ascii?Q?cRI2F0nbtY+N0R7jFfPfSnZ5rfxkjkQQPgWLSTkIeRR2ZdbNITtM/orHftjP?=
 =?us-ascii?Q?OmcEGvrm1peSzr7ovvA9WBAEuc4dV8E4qFJ+5mfvJv3l2gon0ub7rgxEFQ7O?=
 =?us-ascii?Q?GxhQ7Nu9djtWEOOO5Oz9AtBhPuCLPIZoF0aAuozu+mOrSBLhKW7kCBtLjPhu?=
 =?us-ascii?Q?8RQfLJPC2dh6FR8UwPnBB23mh2DviccMIG1ie0byMnuI+oo739CpVoKgKCe9?=
 =?us-ascii?Q?Nf6/ayWxXe+LlXQl4ngSmSVJZQVyNq36AzhUWzL8CdP2tcCgLCF71rub1ghc?=
 =?us-ascii?Q?It1gCClc/pH06Cvs4nBaMU16IJrrIHi/caCN9YEIZKy58spTNIqNQtJRDxGI?=
 =?us-ascii?Q?T6IM1YTdbgu+KnQycCmbUoUY4Hp3r2vJciDcRZaSGocYJJE5V0thOQDvw2Hx?=
 =?us-ascii?Q?8Rn7RWW0Wutjb6nFXNk/+x49Of0JIzJwQvvMHOIzkOfLIK98WNZtU7dwTy53?=
 =?us-ascii?Q?U8Inj2y+4UshIqXdS8G7tvWfPUvAZSPH2I+ZXzaQ03Mj4DX2EtViHJj2I6Hw?=
 =?us-ascii?Q?JXnl8Fr+3qwlsQkjU6mutdpbgowbpqzrk3nnIKabHRFlC4z0Gwwh8cD23qGt?=
 =?us-ascii?Q?IFcrgOu+MCnmJ277tba16wB65IxcUTGE5YiuNZCueEWqlzcNyo/UGKTcgJEM?=
 =?us-ascii?Q?iFP2TgUPlofK4NFrPT4QERT+ODBRp3T92gidRjIgi8qTI3WFmq+jkmyoF2yA?=
 =?us-ascii?Q?fp9cSAWEv+Pu0i+H9YPARPVZyIASWDxhi4It+fjvX4KTIHPBatRz7cMe5w+/?=
 =?us-ascii?Q?auyt/KAFUnAStPIMuApJefmZBuRJOIhymslUHKax1zG0mlSlg21TheWXORqg?=
 =?us-ascii?Q?jcvJ65ePNOzF98a1jHeqjDVfCdrhJ3VwEAIPTpwdWLmAD0R3mY5hTK8RCRyv?=
 =?us-ascii?Q?8fsv43rEUrisBxjbjzuDdCBMo+ZN3zIN2ii11djD4yEyRB3U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0296f6-7948-4d64-bae8-08df2c95eff2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 21:30:59.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCgxeV6O4Gvc6nJsOxQrkbynGB6XBb649nqAI4YlPnyg7YNLZ0a8lCTpN+MdLwcY+yEp9gGBUV8Ua0L0sTLHSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

Hi Tejun,

On Sat, Oct 17, 2026 at 10:36:19AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sat, Oct 17, 2026 at 02:47:49PM +0200, Andrea Righi wrote:
> > +static bool higher_class_runnable(struct rq *rq)
> > +{
> > +	if (sched_stop_runnable(rq))
> > +		return true;
> > +
> > +	/* The ext server selects SCX tasks ahead of RT and fair tasks. */
> > +	if (sched_dl_runnable(rq))
> > +		return rb_first_cached(&rq->dl.root) != &rq->ext_server.rb_node;
> > +
> > +	return sched_rt_runnable(rq) || sched_fair_runnable(rq);
> > +}
> 
> This duplicates the core pick order in sched_ext, the dl_server ordering
> included, which is brittle. It also misses the case where the IMMED
> task's own cookie forces the CPU idle, e.g. a tagged IMMED task while
> the sibling runs an untagged RT task, as nothing above ext is runnable
> on the CPU itself.

Ah, right, a tagged IMMED task inserted on a CPU whose sibling runs an
untagged SCHED_FIFO task stays parked on the local DSQ with this patch
applied, which is wrong.

> 
> Instead of predicting the pick, how about reacting to it? A CPU picking
> idle with IMMED tasks on its local DSQ means that they didn't run
> immediately, whatever the reason. scx_update_idle() is already called on
> every idle pick, from set_next_task_idle() on a task to idle switch and
> from pick_task_idle() on an idle to idle re-pick, so maybe something
> like the following in __scx_update_idle()?
> 
> 	if (idle && unlikely(rq->scx.nr_immed))
> 		scx_schedule_reenq_local(rq, SCX_REENQ_...);
> 
> Outside forced idle, nr_immed should be zero there as pick_task_scx()
> would have taken the local DSQ head. The reenq would need a flag telling
> reenq_local() to skip rq_is_open(), as next_class is idle and the rq
> would look open, keeping the IMMED task at the head.

Yeah, makes sense and it looks like a much more robust approach. I'll
send a new version that drops higher_class_runnable() and does this,
with an internal SCX_REENQ_IDLE_PICK (?) flag to make reenq_local() skip
rq_is_open().

Thanks for taking a look at this!

-Andrea
