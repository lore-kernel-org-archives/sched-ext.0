Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493B2F8E93
	for <sched-ext@lists.linux.dev>; Thu, 28 May 2026 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984821; cv=fail; b=EoxchcbvBbf+biTEATNn6GQ6RXXFiIBRABxPHamTZlfc//I426VWmx5N91lHXPTOiV6rcsZGXpCve+VXKp5+MP7A928uI6Rc664oJDyy2RVkuxidTvYwPuD4lXtV4vX9EWeKYXhExCHzU20b2xDG6cp4i5bgM2m+V96aCmPK/Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984821; c=relaxed/simple;
	bh=eBYFlRwRfryXughKGkyDNP0kSsudOGYhnMsRJv4F970=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P2qgZwXqfsf97SrUG1HIjwUuqNTmQ4zchuPespgIeCLBjDxk45mkTayjfOFe23n6vLbesGoYkbNQ7DWdrX1n4+FkmqqSWwLpQEsfLODznftaPYGeN31z9AlNcBt3RK3jdSUgLn67VN/peJdhOF0Duwg6Ku+kQmYtHgqMMRYiys8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tUM0L46D; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tUM0L46D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YstY59gElHfYalQaV+6aWa70aAkCJBSRfmJ1s8bxRTqjt+bhaKvRnwIO3L2SSV9lJ+qO2vPlXCpC7xrUHEGeMD3KkTAZrU08ao+W0EkTTw6RL1wcDcLhXv48hZ0cKUW71tsgoYRjBKnk78Hse6vqFxU0eoZTy4lLYYAQPv1YfqbI6BlsZqkGmw6BtiMDoY/QJ9gmVIXa0XtL6qUxSVS22VkOCax19N6L2Cekgmf1X0OKQZ1pFUBDVYrlwzYag3ZZKLrxVp4ROFHRL0InWAacJcpG6QP4UBoYWUb9ftGM89xgieq+ZeWtLlSnWiMaS1ymsc35vY0V4XMVw5YxCyRxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Atra2L0UiGpr1NEnzsf4Q5nPRREDhl9wuQlrOHeGL0=;
 b=wWW6DbMiDS3mvQT9a8c/j8znyyJ5NMeuieLwFclFemtw2Osr62vpDQJT3FNXiCfW0zYal28TkqiKyooZcuHjEcAYVHtkLxzyCBdlE5YjkTdqo40QywYxet7W8P85ke44r+FtihiJN3DHgSv4FtO1fv9OQbiW/3dDQ2+Zdz3kgqk5NQN1v5nipj6kAhLXApBbe8QJMtnR61zM76LkxFCfMLdluSGzqsqiBe5nf/2JIumb0QqdGLeQvHq6v2aCKMD4e19rpzA0teYqKpobGAgH3bgA5RkGzQavdYvLYZvv7K+kcatys9KwxAad+xptAapT9U2yNI8SXRkbxjacibO/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Atra2L0UiGpr1NEnzsf4Q5nPRREDhl9wuQlrOHeGL0=;
 b=tUM0L46DSUEJ0kTZSC23+hoHtDB2OHg+treyLHcE8C6YkXPI9E0B/oIz0X9U9zRgQMk2xuP9n7W9CrADgU7WefDltgyNZM7V1mgN479sCuyBSQKOOX7WvtzU/CXtg1phFdgneNpQV1m5vGVdID93n3wfJ22pFwGPGFitczEZUv8FiK/Duthz2AaYubxBK6/8IMULQR9dvQZBR295Z/QsudS6FL0e3Xs8ADiOjbSwQW4jhCrmzc6tD/4vv5uj5K+ZXT860rZsj3pQoVjFNFjzt65f4SDiNMZXbspVSijxWPpMzXEoU58tyTGo8orbb2Z2TSV4WPfCJphgAidP7uXCrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 16:13:31 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 16:13:25 +0000
Date: Thu, 28 May 2026 18:13:10 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Auto-manage ext/fair
 dl_server bandwidth
Message-ID: <ahhplv6a6etqcF4p@gpd4>
References: <20260526164420.638711-1-arighi@nvidia.com>
 <ahblQnYT6Y9CTJMJ@jlelli-thinkpadt14gen4.remote.csb>
 <20260528113317.GD3493090@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528113317.GD3493090@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 845e79ae-3899-41c3-8803-08debcd408c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|4143699003|5023799004|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	2Q8zBPKX77hw5mUb1eJHFVoVDE04Q0vhgDtqqM+eVSolghsEOOq7x0tCG6hsMFxrqdFDQogQeWCmhGbqMKzo2gRrtcNrpx8guDQ7IteYBHn89jFM+tBWcKK3gVUzNdTKWPM2ZuYoS58t7EFmRWaFGYIEdIDK+XP3XRubdUAc/7NmKAzgy687bN2Rz2lIvh41mrqqa7cnUKcVF7VXfKx6z0O0YuWDS+Msm34y4WQGeZTCUMjEnT8AgYlO9hhjjTYAYbOkWXRtQiYUUKIbgW0+5NAGkqs/Bmn62bROC1ji/4HOnyPBkeMqy0UmLQwYCgWNvPfxFI8PZH1A3WgBgDBTrOQI3TfwaSnQZvTRMF34meyM1TlI78HuH1Tt4PM3tjvZUXKJLnKGalDWx9hNVIBc1Q2RH073abR5OzUK4EIo3IJMSzBJVCOoq37JvDaE4C6qewpF2OhD6P8KMZNhOhb32veKp/PUWMJeXCaRPI/FiDsk1Qy76HXaCg7N9SRO3pvCniven0iNu/srcuvBYAjQltFpIonfMAyBJDCHdwP7LrBpX03nFtPlgXLZKocWCz5NbDT0VdqKY713GVQj9PxerVDRim29nNm0iVHrzW15QmGBS6SqGJhUp6BGTomFj3avUx3ddHbJSo+mmRl+64ewWB0PH5rMMyVQqyopyQ/GyPUmsFdbtRp1hhb/QMx1EbQZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(4143699003)(5023799004)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9wTBf6LMIYJx2O1xgBH9XZpIFXBpISKZg0R0z5T907WQURF1JF368OVBWUcu?=
 =?us-ascii?Q?ul9ezKy4qRG6KTvbufyJrC200188Qiw6K+0dubnE8r9F77qhl2IlPV3gNhLB?=
 =?us-ascii?Q?l5xhG/LfhNBccILfWqCpSOMsYPePsedAlJpEeyoiv4uMBAUCWGYLQeV9gU2n?=
 =?us-ascii?Q?roSyxbO517g1PR7mRo4w8vQZBnRSg2JMPdgjhOuWYVJeUZ/xAVQrfq0WO0C0?=
 =?us-ascii?Q?4Z4D2ONAQcSMkLZ7QVKyXXmfsxOtN54k7IfM9rQLcvceDMaJId5W+KKD7VEe?=
 =?us-ascii?Q?kfRQF6a6h/9eGi0eRZxB6ju/LxWoI6zYcPN+Cs6iw39f6dWA9oebdrs7oM4i?=
 =?us-ascii?Q?oitOTN6P5SxPfW7UVkXxmqKugmvqeHoj/NN0/6/7bE7ZxtOp/vQQd/IW9l61?=
 =?us-ascii?Q?ZdD4wXW39mQPBKdzn/uvwKKzx7NhyPiotgZ1mv7SV149RqpP7bvppm2ShkMT?=
 =?us-ascii?Q?FqxykE7g9Z1tW81fVyg/t7QdAC1/hrwk2JM4dDQ2n0MP6iANSZlfL8x404oG?=
 =?us-ascii?Q?t87wt2vjuO6//sdEchMXeSImtrPLF0VpUB6l5MIZlnFI59RZIobvpCWiGlPY?=
 =?us-ascii?Q?dtDgCHylcTemVhlOQt98acJZJFVnpm+6sFWRm24ct/m4+1+eOpNO0NSw2taJ?=
 =?us-ascii?Q?p0xuoqfMj12KVF+lhkT9OuMbW5PHTL0bzTwRvVVcevOuU6CukkAqsU+dTpIm?=
 =?us-ascii?Q?WBUffTnygZeK/1tUw6eyxOFxYvKTLOx+KQ5IJPNPUAqsnudW1GK4M/VL8YYt?=
 =?us-ascii?Q?iZ4wzPRdAdQfk4VMB43VrtVJhrya3URbnNoeMSpuPqOMdopGc3os6Jo4ThOD?=
 =?us-ascii?Q?FKwkgLbDDngCoNGEaaancXVYtKBndnT5J/h9yTzq4yc8S2LB4KpblXE/6gXI?=
 =?us-ascii?Q?EhtdBkQFsl8W2umRMiTww63lmtbS09Qv6l28l2gJS0GdoCvGet7fNj20tf2O?=
 =?us-ascii?Q?rE5fio3VJffErl+2+q+U0rGV0efrxC4VCp+u/L+WKPMVTLFgbC45vuO75c6p?=
 =?us-ascii?Q?hARbr6lSMndDvE0FyVLxxLU9jl34lOZWQoxhPJMrtbtpClvz5yzDm+Io4jwH?=
 =?us-ascii?Q?fqIJaIHjWg1ozsculb+0pya84BJleUXhWLplQYHi9ZbCQisjUCFdDwCpYZZP?=
 =?us-ascii?Q?klByxwNm/i8FzpZx3AvngScvcl2kv9EAMByJ9M5ON4ONJAgpsIx4lt2NVxmX?=
 =?us-ascii?Q?1n81Y7g7gqajE1sJzDzjDPo5+qjO0bV4XjlLAXXsUNZR+ECfrv1K4VRMYCuw?=
 =?us-ascii?Q?D43mm+hTptKSVqhuSAODDOwgFXqOpI2Syoz2NQ/QwdlWUhy862V0/Cza6i2g?=
 =?us-ascii?Q?hCUCdKzaOf/sUVZ2dxsoNW1iloqSk2+dcgSz2NwlVViMDQuSgf/s8uwnwIUY?=
 =?us-ascii?Q?obUOTWD8jQ4MqIbvF853Ana2Vp4ey4Kd3a7sE0pZTKL9yfwyGIYjdWFlHYDw?=
 =?us-ascii?Q?pP4w+7uivy9slu9I3skZjJJ74Nu9E8Q3m9hP0zIPB+GvNuIT/ex+ZcRFHHM3?=
 =?us-ascii?Q?NQp79ZEaUR07HV9t49provueJyTkSxHLpLpp0mPoT8P/tqUyTzmXm/YE+Pec?=
 =?us-ascii?Q?v/CzWkb1sUgrCgYA8Ava7YrWjPNLkPl61EbGTNSMEeJBhh8rqCo5sGnXqavt?=
 =?us-ascii?Q?rXA9FF18hdCjL92nLaQ0mkhpje2bMBOzC1q46igor9nnHUi73Q8nmF1KBLhD?=
 =?us-ascii?Q?KRadocwzZzeZ0JQnmxR9IeCYNa3jF5wVMjX/J/pqwI9ouU/1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845e79ae-3899-41c3-8803-08debcd408c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 16:13:20.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZTEs9PVFQ56hqiX6MP6lkR4NJX8+ul3SubyQQCbbRdMoB5x9nLSny9qWrt2HbqZwodRMjRYIdKIXKieYIFm5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714

Hi Peter,

On Thu, May 28, 2026 at 01:33:17PM +0200, Peter Zijlstra wrote:
> On Wed, May 27, 2026 at 02:36:18PM +0200, Juri Lelli wrote:
> > Hi Andrea,
> > 
> > On 26/05/26 18:42, Andrea Righi wrote:
> > > Currently, a fixed bandwidth is reserved at boot for both the fair and ext
> > > deadline servers, and this reservation remains unchanged unless explicitly
> > > modified via debugfs. As a result, both servers permanently contribute to global
> > > bandwidth accounting, regardless of whether a BPF scheduler is active.
> > > 
> > > While unused bandwidth can still be reclaimed at runtime by other classes, this
> > > static reservation prevents RT from fully utilizing available headroom in
> > > situations where one of the sched_ext or fair class is guaranteed to be inactive
> > > (for example, when no BPF scheduler is loaded, or when sched_ext runs in full
> > > mode and replaces fair).
> > > 
> > > As discussed at the VIII OSPM summit in Cambridge [1], a better solution would
> > > be to dynamically register and unregister deadline server bandwidth based on the
> > > active sched_ext state. This allows the kernel to automatically enable bandwidth
> > > accounting only for the scheduling class that is currently active, while
> > > disabling it for inactive ones.
> > > 
> > > This patch series implements this automatic register/unregister logic. Moreover,
> > > the sched_ext total_bw kselftest is also modified to validate the correct
> > > behavior across the different scheduling configurations and ensure that
> > > bandwidth accounting follows the expected state transitions.
> > > 
> > > [1] https://retis.santannapisa.it/ospm-summit/
> > > 
> > > Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git dl-server-bw-v3
> > > 
> > > Changes in v3:
> > >  - Don't bypass __dl_overflow() for detached servers in dl_server_apply_params()
> > >    to reject oversized configs up front (reported by Sashiko)
> > >  - A potential divide-by-zero in dl_server_apply_params() reported by Sashiko
> > >    has been fixed in a separate patch (not introduced by this patch set):
> > >    https://lore.kernel.org/all/20260526100502.575774-1-arighi@nvidia.com/
> > >  - Link to v2: https://lore.kernel.org/all/20260526082954.550958-1-arighi@nvidia.com/
> > 
> > This looks now good to me.
> > 
> > Acked-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Thanks!, I've stuck them in queue:sched/core for the robots to chew on.
> There was an absolutely trivial reject in ext.c that I fixed up, so
> something moved around there.

FYI, I re-ran all my tests with queue:sched/core, everything looks good on my
side.

Thanks,
-Andrea
