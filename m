Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB77489FC3
	for <sched-ext@lists.linux.dev>; Fri, 18 Sep 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713018; cv=fail; b=ukEYI/2hUSBE1gasVd6pRdOm52Y7R56cUJ43XHsbCxv4Y8CicEp0xKyY9xbe9MJ6R4Li8z0W3gYnBY6JVUHRMqxjtf4CoIuUvSkKm7BYE3XGPw1R7ni8DUmWnEvukUpkDfdAQSklg478dnQ1e5yWVCwags5K1EWKKFn7y/Cdu6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713018; c=relaxed/simple;
	bh=Da/wnXbpRsUM5QDE6YFjLWya0R20eXT9F2kROlNp7lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p5iqqE/ToSBW0liKQm7JTJr+c0xJtP3sbDg6n73mLsJ7ryv5z69rn5wwYFIyGDGXKRnX5kRU8m7IBVU/ZHjXQ3GJNxxaUifpzAET2TfrzRCdQWdPPk3D8m5ynHrEnZMWnLCvDSXsOcMnQ4ekgirEwyErZBTsm3/45iv3fX5Ts7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uAp+PeQ+; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uAp+PeQ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtNJEMVUtSJs+KioGtfqNj4aSnBmY+q7JK1akvIzIb76Hi3rW75af4r5Y/kt+X6bXF/zc8ZU6R3C12PxN69cLPuj8uJsb4xSiBoVsUEGiGtw6WG8mVn4GupnX1Z681sOKaZlCwQGzuYv0oqY3d543ckJw24mttiRP8+1bc8vZLvwmiUZFiWbJP2kijpdCHdDax+1+LX6NYOkdzwCT3xphdxwa2LCxK1L0vXksE3hpXaYN0dBOTYnrcY9KFAOEYBpqwaJn2BttDleDAdQ5Qab42gSt5bWwDpEVtz71Fv/UPOatY1Gq8JOxfc/5e+PMIAiouldmxcdZs0jlf/yp1rHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTMHMXx7dpkaZ7Udk9i6xsGm2evSXGVGr0oIvq16Rpk=;
 b=QbkwveKuiO8ZHYMADO+a7eIBwUQ7MK46tI2q9DIIAIbuY5qd7a02I63spXulbKiyRLk0OonmZa0sd3lLrSJ5rneIGy/95H/vLXZnVE5oXX1x63RmIcA50KsUj3ZftDi53+iZLt3B05Chv1UIpolmndj00Mrv2KVMhohw6QbwBnd1vA/+lEjKksS2Qlhm6BzDtPay12l25VjsmZ6xVMDa6KYrj0Ewq/g6r/766ur33mCmFaT4SRYPigzoR2oD5z4S5FxSiKMdmN3SId2aBQTng9fYUTM/KTiEylQukIKB6kPg3A9Y3HP9SiAnPRa5QGOx2SRHPD1XXgT92UGnEykYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTMHMXx7dpkaZ7Udk9i6xsGm2evSXGVGr0oIvq16Rpk=;
 b=uAp+PeQ+RSOQrvJynIwzHIrrw39CQVVRPVZMKGRlqtMygvJAz1y4qEKQSfgwmNxD35247VG73E4WncxKn4uv1Z59w2gMLHhf+SODDKJK5oLd2/1J9P9py2FI3irRda43VUINEXszWnSEc5YyYgQzeQWfJisEQa1D+eh5p2/Muyw1fdkLK+aVzkfJZRNEkf/cOXp5ce+yCcib6AyDcb4MdiyJzYCjapo3ZtcDquiWYa36J2JknPjXaCLqmwuy7bPd87jPPtDjiD9eJ2ImaA0zkVlzu4BFudXCkecChu6XEj5h44fTwZ3e+/zQUP3qCpDjGSOitnrouDe+rUif8+bTeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 06:30:13 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 06:30:13 +0000
Date: Fri, 18 Sep 2026 08:30:01 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Message-ID: <aqzaaWBFmXWGmo9I@gpd4>
References: <20260917070751.3617935-1-arighi@nvidia.com>
 <20260917070751.3617935-3-arighi@nvidia.com>
 <04f2f87431aae3f2d5f34349f685b397@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04f2f87431aae3f2d5f34349f685b397@kernel.org>
X-ClientProxiedBy: ZR0P278CA0145.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 4525f73f-c959-47bb-f001-08df154e4acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|4143699003|5023799004|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1Zy6XA2SQGLiNRWBvdzTryOH8lvmFF18SD40mxD6UWLyAeeHuqN2v5CXqhEknjCJY8Dlt0c9Si3NcA21RMB8AImEe2xEjL2yQTR6D4kHc5sp6VSVro25vqRto6YGInP2/K6R2og9/z4/nBkaBUlMlm0s+ZeWZm0aftrPgzgBY91qTNuo4nTEePiRFNXLXtmiWe6vUgGoXfMcdmzkRiB6L1av4VlTdSeJf5mBfUcOzRkBHCUo1fbRUGZkhPFDX51RLNOf39JW4AHUk/pcIFAzKpDTZq53KdmssaOFChKCPcLEYeVRBQv3iULyhGAIw+9y40WsE3E9pzPjuaWooCdDNhk59TVf47EJJ/mvNHbWXcjZNfARaWhtLAPJ31zt7T3kf0XN8NJgfocBRR43NsmDNpADX92Yozw2cT2m4NYyjf0bQ8vwVsdDoMiBCcewMDJ1QMeT8JvHyvxqAYWpJFPyFpdy9sDt6Yqu4teNb+1qRiXrqgYq700drO88DDTSl99/igf0qgoxtWSgJDmu1ShwJd90YnNFyXM764PfHhPD9wKslK7sYHQmWAeoXo1IjFF4EW+Pi67F8Q7Z/o67DXnLuqHOp5MAYNWJGtgEJ5qt9d9vfY/gGlo7WqLQBCejbe6+uyskW++cheHRvilgQe5XMMr7vkh7AG6B2D8o9OqsIhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mngMojqjz2M9zwNeLpk4lMm8oNKmztnyrm2sydGgJ2/FH9xNVpLXHfPBmArZ?=
 =?us-ascii?Q?1AeoloDo1Ado9e/qjKcPpMX0KYJdxw7kJNZijRFoR7SVNy3WL/7BwjVS2dy/?=
 =?us-ascii?Q?Yr07C1qkBUPwrEWg/i7rHiJI447uBJvwLn+mYVEJM4YHU622HgdNWlpMuw+U?=
 =?us-ascii?Q?Dy3z88aZYU5yOm49sVWmUmFkh9G0iUg18s99Q27aOSIsaAdtO/lmGuVk5/XE?=
 =?us-ascii?Q?n7CptGBf2PfHcBJzoQrzSYKIRK/0cObtDP2RFITEAP+uXZYrqyXiTdAGhfcL?=
 =?us-ascii?Q?xJhgs2JZovw5enaU4aiwwNmrkrp+IgU2AISZSILxChzT+LNW+1vKTYDpQbCQ?=
 =?us-ascii?Q?sAfgHHPb549iTaikTlseiEYnsjm0smM8Gt4eE2ukpATfrBy80BQ8oHFiwEvp?=
 =?us-ascii?Q?iivabBpnEcHZPQhdlkpr1J/GDFG8Wi0Bth5Z0MY7YxD5GPpFMRO9tnZ+iB8e?=
 =?us-ascii?Q?3Fbm8Q5vAywbBO03tuZEgsDqQZ3BwwulVehF5ClmBPUl7/WseWeyYfPJM+tX?=
 =?us-ascii?Q?umyqVJ+pzPccpuGcCfzFXoc129HFZ24AQfiBE3Sn80lWcb/cmV41wSGlEhZB?=
 =?us-ascii?Q?bm/k4cOw0DDyuJXCI6DAZjAjoEh7CftVeKXDwlcXjY22FxGsUhWwNoIqT6mE?=
 =?us-ascii?Q?KShw99xdfyj9T4MhV44qo4VKA/VHyfs1q+AiVt75ie73fV9ny5VWXC/GhG84?=
 =?us-ascii?Q?9nMBGUIfNJLQ4rGdeexb9ocbsmtSZGumKbsib0tc66LSBZWoiN/a8XIJsjP/?=
 =?us-ascii?Q?dnBw8XYQk56/jK+rmM/LVSPeLoHGFu8w0EFDtM0T7E3PBNjPCufTlX4IKDR/?=
 =?us-ascii?Q?Ubm6c2xGpj9c8HhEPgRQlJ6140xG0rpdEQhEpaKetzQ1/TD2S4Zs2lqREYsj?=
 =?us-ascii?Q?X8Z2WneOqpxm7KjCsGrTHkvcqEtIsPBtV4tvXRCpPtoiBDgfj2gAXizIv795?=
 =?us-ascii?Q?TjtJKO1bgmUV/gCdi8LmNIqH6+JWnZ60o1H7MGVW3NMcWvUoIIDoXcqXvubM?=
 =?us-ascii?Q?eMaPmwTgIauGm9Gt8qxqjZKS9XqYCaVJWV+xcYiPoqdEV8GreeY1oRusfU8U?=
 =?us-ascii?Q?pzq7BB27XQdm6NGKnP1iSTULmrCWWfNb/AyKTC+echDMORb99BQOfhy5tcvg?=
 =?us-ascii?Q?p7YDPW4mJnsJ6fq1Tf5jQiYTqOdBLxCoMonA7dUSo+VmzWe5Vo4LMveZeq/k?=
 =?us-ascii?Q?4esQ0EFh9rGF4Ly7sTdtuDcmHKJoxQxJnaHAAuI0AMHQT68KQwi3P2WjN4ta?=
 =?us-ascii?Q?REVgS8shB6gPNFnSC/IcatsxUo1qw2jpqoakyN+Q67UPieHyK2aJdjVbKALY?=
 =?us-ascii?Q?r4s7cjtzx1YcbkIpe0JvYu85lb0GKtxrjknpdY9RENkXI/HiqmLcBQ1MScjU?=
 =?us-ascii?Q?GpwhSZdb8wmxTEHOfSklusCsx63nSQi0AnmuD+pCeR5XiqCJRTonVX+ZUJo0?=
 =?us-ascii?Q?ZcmPydYV7Tuo5EBbMcSRWFiEV9J62yUymsnEltTX3I0ChPksexuVRh7eDhY2?=
 =?us-ascii?Q?0lOU/fRV/uCfvxoDHm8R3M0vXHmVPPZhxcaUNN/gq6WneXrE8IQiBJZN/5TC?=
 =?us-ascii?Q?AKZuT+NH0irKeYTrfMpdk71VOkdw13OiyDuPpi95mTzLIMfOU3cx7FKu7SK+?=
 =?us-ascii?Q?D/tc4DA3Lv16BtjEJfP6MtuwgWrz4LQuG7xAOlDtghVIP5FmQ8Ud9rFRASmP?=
 =?us-ascii?Q?5yhcCzKDmUkEOaRURNuPon5v6Hl0EwGU72jem0a0nIF0U+TgYsWP+GdzqL50?=
 =?us-ascii?Q?WE6oOnDFDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4525f73f-c959-47bb-f001-08df154e4acf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 06:30:12.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5Bdwr+pEYtLPlK7VxfP6kIb3Ot/lFrYQnKh7znSfMSejA7/lgPOI65Xf+2nGsNEIVACb18A4hEq8/hZN9D4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412

Hi Tejun,

On Thu, Sep 17, 2026 at 09:19:07AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> This is an AI review. The series was built and the tests pass under vng here
> in lazy and full modes, with nohz_full on 2-3 and on 1-3. Three things worth
> fixing and some leftovers.
> 
> On Thu, Sep 17, 2026 at 09:02:53AM +0200, Andrea Righi wrote:
> > +enum kick_scenario {
> 
> exit_test.h and hotplug_test.h share such enums between the BPF and user
> sides. The same would work here and for nohz_phase. run_invalid() and
> is_trace_scenario() depend on the two copies staying in order.
> 
> > +#ifdef HAVE_GENHDR
> > +#include "autoconf.h"
> > +#endif
> 
> Nothing uses CONFIG_ in kick.c anymore.
> 
> > +static struct victim spawn_victim(int cpu)
> 
> Same as spawn_gated_worker() in nohz_tick.c except for sched_setscheduler().
> util.c could hold one copy.
> 
> > +	file = fopen("/sys/kernel/debug/sched/preempt", "r");
> > +	if (!file)
> > +		return -1;
> 
> That file only exists with PREEMPT_DYNAMIC, and needs debugfs mounted. Every
> static kernel takes the INFO path and passes without comparing, including
> static PREEMPT_LAZY, which is the default on arm64, riscv, powerpc, s390 and
> loongarch where PREEMPT_DYNAMIC defaults off. uname can't tell either, as
> PREEMPT_LAZY selects PREEMPT_BUILD. /proc/config.gz covers static kernels
> when it's there. Otherwise skipping would be more honest than passing.
> 
> > +	SCX_EQ(both.resched_tif, immediate.resched_tif);
> > +	SCX_EQ(lazy_wait.resched_tif, immediate.resched_tif);
> 
> Outside lazy mode the lazy TIF is the immediate one, so these and the
> override checks in run_tick() hold whatever kick_one_cpu() decided. Maybe
> skip or note it when the mode isn't lazy.
> 
> > +	case NOHZ_PHASE_LAZY_ENQ:
> > +	case NOHZ_PHASE_LAZY_KICK:
> > +		dsq_id = SCX_DSQ_LOCAL;
> > +		slice = p->pid == victim_pid ? SCX_SLICE_INF : SCX_SLICE_DFL;
> 
> The victim gets an infinite slice on every enqueue, including the one after
> the lazy preemption puts it back. In the kick phase the challenger is stopped
> first; if its slice runs out before the SIGKILL lands, it's re-enqueued
> behind the victim and never runs again, waitpid() blocks, and the 5s watchdog
> aborts the scheduler, which then fails the test at check_exit. The enqueue
> phase is safe as the challenger re-inserts at the head. Stopping the victim
> first avoids it. ENQ_BOTH in kick.c has the same shape with the global DSQ
> and the default 30s watchdog, a stall rather than a failure there.
> 
> > +static bool wait_for_tick_stop(const u64 *counter, int timeout_ms)
> 
> Neither this nor wait_for_counter() checks uei.kind, so a watchdog abort
> mid-phase reports as no progress.
> 
> > +	if (!start_gated_worker(&challenger) ||
> > +	    !wait_for_counter(&skel->bss->nr_lazy_enq_running, 1,
> > +			      PHASE_TIMEOUT_MS)) {
> > +		SCX_ERR("Lazy enqueue made no progress on CPU %d", ctx->test_cpu);
> 
> This passes even without the tick dependency restore. sched_tick_remote()
> runs task_tick_scx() once a second on the tick-stopped CPU, and as
> nohz_tick_ops doesn't set SCX_OPS_LAZY_SLICE_EXPIRY that path does
> resched_curr() with an IPI, so the challenger runs within a second either
> way. Setting the flag on nohz_tick_ops keeps the remote tick lazy, so a
> missing restore shows up as the timeout. Both phases only test anything in
> lazy mode.

Agree to all of the above. I'll send a new version with all of these fixed.

Thanks,
-Andrea
