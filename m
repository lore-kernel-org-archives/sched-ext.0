Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560153911DD
	for <sched-ext@lists.linux.dev>; Wed,  5 Aug 2026 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913348; cv=fail; b=qXmuCWeGd2r8tf5nFFj8Z4Yvmqf5Tlfa0R1BmO8NRHPK5aSbHCk2OK75F103cOIkrO7hD8SJy+YkQgZPfKUH/dT+e++WmgnjV4pPv3LR010XONa4bUZM1mB1c5p5VO7vyjB/nGk4yk7OY+kZNb3Ke4JJNEOFs9sS4IcizDw9c5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913348; c=relaxed/simple;
	bh=SjE14JrG7KvELB86DCYwF1FJVka9m/9wkhdyjorIMGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X1vJG0tbbLBdlWkawBVlcuyJwoKohCb0WakPOxk2r8U0qS0qAkl0pu8Usg9tHnHRe99kDWYGJQ1ncQqw+Iyjkog7UtQA3kdIJ7H7djy/mNyH3wTkVom1Rq5+8sHY0dZN2svC5qqH+fCUvuEYgBWRKrqdZM0Fysni26gCwIvshLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G2ySwWEy; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2ySwWEy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhgMtyZcs+NBjdPI+x+2ORDgDVAd3UUsepusZu2mxEVDVGzCUuvCvsKJrYaoroIZqb4T2cxQKgI4CmnpPEKRex4ccT9bu+POzyOPIqtD4hq1ynVQlzaADPrFTadaCdA/FW4L9K3pZTwn6lbPBe3Xnqfd9EolgEC0qj71uzD3SjVHp6GHXY/OS0tr8OgKSVTB4oTWDsm4w9cBwBOOLy0//MR/pAZTAQ2perD8X70KHWMOHLewX55uGZ6FaOPtbP5VMNO5oDdJS3ankIaw05WotOUHU6BtiYlq4tJc83GS2YzIDsqnbs9zIjnD3mVZ7ZXs8m7/YWH5mbKnZPkEfUpy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkFbeNcJyp7Wi57AmvNl691zvVAAbQfZjFJmSYzRwq0=;
 b=dPRMwMzLHjc6t0xQeZ3ZYsG4pccBpUZzqREjULXQzrMCh9ZdPYfEAIMaGYCxYoPKZNZfuYI02kA1bWlZQfEBUWDIy8ZT2GXN23EFcSC2ZTT/XPhLkrjiFrxMB0Cbe73WNvB2YrE0bb/bsqK4r9j0Jc+jf44Cl4B40YnCr4e6zYNCMVmRT23+iWLJULGWnromsucMZ6VEkRL6mhXXyqq0oAWf9/WDlPSnuo89p788C+aVtqPGcCedshPpBv10yaGvSG0y8+mrgjFUtvKow7SAlsLBTY1Yz/wqgFzrRyo096c/DRMHiJark9sjx3yVzMrrRRg8r9eCuwrasmYLbE+n/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkFbeNcJyp7Wi57AmvNl691zvVAAbQfZjFJmSYzRwq0=;
 b=G2ySwWEyl17YtFCJrTIzo5Hl6e5cZeLEBgTU4rga2CVp5A9XPUUG0PZQmCx50uUdJLNC57x5/Na0rQaEdunsA7IfE7e7rfl3bwuuCACJ6XNlTTsdRsilbcFDTaDOIFLY2LESYZAGDcptq/arQr7EXEB4vO8aUslnsgESuxMWQaC2lj/VqZR5ei89iJSgEqx4x40UDnR84CocbKBK/N8Vf15F8DCggIdJnJPZrP0vjzMKl16FdXEM3AseZGNowLJjPYAUOzLvFdA/L0Eyf6376n+sxx00SyniGceHIHRiEdBRdQWn/mLYwDxd1e8SmAX8nC98tFKl7wU8+P0KQFgxAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 07:02:18 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 07:02:18 +0000
Date: Wed, 5 Aug 2026 09:02:10 +0200
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
Message-ID: <anLf8lH8icsdd3Yl@gpd4>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-8-arighi@nvidia.com>
 <anD72EDnXYgSg5Eg@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anD72EDnXYgSg5Eg@slm.duckdns.org>
X-ClientProxiedBy: MI1PEPF000008CB.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::439) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b28ad2-64d2-47bd-abb9-08def2bf7cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ONPgw4Lg2WjtYsnb17ekS4JKzDQhEpQ1WBmBARu4iKSazd3fb/qKMXRDI3qAY9DHPMFGsrq4Jw0+bOyuX6dAbFnpa4x8xXTEC7+/BLFqvSiPIj3RA8xu8SxZmIavazEBRrbpByxHEXKsLpDo+CQz69dCMVw1Ho3fUa9z39IhlN1zGlc/aO8aiAK16bC83Be55D9fe7TDi2KektaIJ3vWaWWF3pUQYm2YPCD3dEXr7+69auP/+FJb0uPTP71HprbDgG0FBL38fA3WWyG1IytqHqoOliuoWjz4Uwpsn/ovUHjckCEtmjoNE5T6M9NH4DciwKKo9ltglIpz0k5KrsIS5s2178IiU2Nx0pUhp1WrJCdBTVS5TZP+FPgUaPlUVMSeFJo6kCAgYtCz5N5909LTaSQBcAQR75e02tsd344SpvisPkVZCeOR1rjJqUjseuXGe8l/RmmX3tdGMHhgHv2sGTwB1d9cXbZ9JqqWonxcH+CvarDihcoT61V8Vrj/f8mUmAGvOItJVAsLHE+8gkvgXCtE4AWcdDh7KZ6MnmwIqoS3DR4SenWG7f7FmvkoFR/UiIZopQkb4rWe31JMcZRbgAjnIqJ+r8m+BzyZ1OOX4F579yHnn6Rpd0XRhh0seOPMCphCnZMfILrWxCwj427sx/FgKPbtooar7QHIGUQTs98=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3DF9unCzx4zVDWhGGjD56Hu6zF2bqzU0eVkA5RaIQSaMU4jrSWNdN2SksixW?=
 =?us-ascii?Q?PKfjoMt7QAjyonFfrHd3lHazvR0049l5+JieEFGLUxPzCszftlszXkpWGVFd?=
 =?us-ascii?Q?kL+b6+YfNCroM6cujfOt0kTnF5yK5VRbYGPEqKFH7emZQ3VRA+4t0hCjh3hG?=
 =?us-ascii?Q?SyDMYZKaKnmzJsXvaAKh3dPH5eNG6fLAwlIEU7egeRUtlXZGzxz6yQ5yZ9ux?=
 =?us-ascii?Q?CBtk6uzUxUnesS0gCw2VL1qzh5LvEqyng69mBtAMRqkNUnuZv+8TNqhdIPpX?=
 =?us-ascii?Q?nX4YS2CREJjXe5G6klE6wVP1HxxvE2tz1mOzNfbaLPFE/PaOmxWTrzXmVkwb?=
 =?us-ascii?Q?+FcZczz2G39qonp5IUKNC98A6BFUMSWo+2BKhfBotc54DvgPMoOl5OkJtbTw?=
 =?us-ascii?Q?zyURvvs0grIg6UOCxlJ+XjFsfr2XRFujUHWoxbcNB4rHo8X3WSj2dsOC5skh?=
 =?us-ascii?Q?GLdqpWNf71AqwkzcM8kQD8KDOBj1UaKtpCR3pD/LWFydB6zqknIEmhR3L/KX?=
 =?us-ascii?Q?JRCa5Fg1lW2bk18J3s5UlN3LGO3AzuTHpoT+ZCqeFj1Cofep8lX4Rbngstt/?=
 =?us-ascii?Q?ke7DeaIBLLHfXcA2XfklGM+8NZli0CT+ogjHiYLY+Op/NbaKwsi9gH3YwfyA?=
 =?us-ascii?Q?G7jZvPJ+TwrPlG0oxCc5pszVh4mMjgDS2Urd30ZwssSylLzExW3Nh9rmiNWn?=
 =?us-ascii?Q?ocBvSRMV//gGTLyiqh5FTH9ZNfBrLuwnutYDj23Aha/QJOMeSMDjLNnCwwxz?=
 =?us-ascii?Q?u+a49xx7sdwRke9CHY1E9KBSsdEOQrvdWgV2R9jQ0kyv+PuXaXJaLIRi/v9p?=
 =?us-ascii?Q?29XQJBeigifmDuF6pR2sVqCaX7q91vkL4KQDg8y8h/d8GDAW9wJIsd7Jze+9?=
 =?us-ascii?Q?7lZFriekITb7xBPkN6A1bXkM99+il6lQa3j3Ev/AYv3bYgjhFZk1nsyOdKOm?=
 =?us-ascii?Q?ZIVtWAp0r6wHat+c5ZLxToAaveALA8AYyoRmjwGb/8Evm5K9FhDFyF5IMzM7?=
 =?us-ascii?Q?UJ1zReesA2vvdy2j6Oq8Qjq7LZ4m9Oj6YiTFq7COVitT5L4R57Tntp1s3vcQ?=
 =?us-ascii?Q?cF88H2Ebgih/cG7bXXe7Vn0tWYu83rojyhw2hBIBIQqv48x2ke5Cb3B7Embt?=
 =?us-ascii?Q?a3voPB35DcecToWdVZTJ3SMkgLPYEOhxKbqbeDLec8izWjYSqVMe2runYrue?=
 =?us-ascii?Q?PY9d4urHZ36rxTFq1E9Qo67GvqDM9W+pRyz3qdXA3NYFZaKYYCpWVwSldmdi?=
 =?us-ascii?Q?fVyDGoRKm6CRS4mOpZ5iL+McEy90r0mRh7Ti1ZLeJx8Vtphosaoq7OnJBxzt?=
 =?us-ascii?Q?ev8l/KY3mKgyIly3hBtolOkV3K7l/DsSAsZw9kqhgmvtEdlFLOMjxntUVGtI?=
 =?us-ascii?Q?x30hoIUDDEQsv0t4IkPAr8RIToZdATU03e3aFu3eMpkYmtH04vJ6k0fRHaQK?=
 =?us-ascii?Q?w0ClzN1N/oYrWVGUCVXlRD1Vl7i8ZcLPtkrpWA1Trfo8jtfiQBokUucEkFgR?=
 =?us-ascii?Q?8julu4c8EeCOsfLJTc4huZUAICR32Y5kjqxR80tPlJrdP+VXgQvn1uVUhB4P?=
 =?us-ascii?Q?5oNDaJfKEc/Nri2iq58ml3IeBM5UINcOysAoeblRcn+tN2ZZ8GxJs0OXX4sU?=
 =?us-ascii?Q?V8qu1Y/dIld+DWhi8EemCpXofycqzzd6U768Xm2wPdD75Y5VDyQ9SM9hIM5M?=
 =?us-ascii?Q?3fLemyivhxAfv7q2ZZLW5UD+i7RIziecXOHf1KyF8rU+2M2uLfui36VdWknc?=
 =?us-ascii?Q?J301MLj7Vw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b28ad2-64d2-47bd-abb9-08def2bf7cd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:02:18.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZdxgr7Nlmt1G45L9I3h8z3PPtnVGpO1IiUixCQuGJSdVZ4pJJ/3xOXQPFkCac9PnIXnkpiApzccdYdUWbbwJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512

Hi Tejun,

On Mon, Aug 03, 2026 at 10:36:40AM -1000, Tejun Heo wrote:
> On Tue, Jul 28, 2026 at 05:43:25PM +0200, Andrea Righi wrote:
> ...
> > +static void prepare_switch_scx(struct rq *rq, struct task_struct *p)
> > +{
> > +	lockdep_assert_held(&p->pi_lock);
> > +	lockdep_assert_rq_held(rq);
> > +
> > +	sched_proxy_block_task(rq, p);
> >  }
> 
> Are there use cases where proxy execution instance needs to survive across
> class changes (the mutex rt PI, maybe)? If not, maybe this can be the global
> behavior?

I think RT/DL PI is a use case where a proxy donor needs to survive a class
change. Example:

  H (RT) waits on rtmutex R owned by D
  D (FAIR) waits on normal mutex M owned by O

rt_mutex_setprio(D, H) promotes D from FAIR to RT. If D remains a retained proxy
donor, its new RT scheduling context can proxy-exec O, allowing O to release M,
then D to release R.

If every class transition called sched_proxy_block_task(), D would be removed
from the runqueue when FAIR->RT occurs. The PI boost would then stop at the
ordinary mutex boundary, and O would execute only under its own scheduling
context. The same issue exists for RT/DL deboost transitions.

Potentially this could be generalized in core as a per-class "supports retained
proxy donors" capability, but unconditional global blocking would discard useful
PI behavior.

Thanks,
-Andrea
