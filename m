Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0F304BB2
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707380; cv=fail; b=PyTLn8L4BlmWEEAZkXperdegeQfNqJxGzrqStrqtYuUAkIIUudbg3F9+Psq7zDwaoZ5gQcofUG77TSqjF+s62IGDakONbFG7r7pItTmWkpw19By2080uvVUmtPko4AtFMpvexWZQJ8j53kG9csr5qCb2kvA0z4h3JBVfiUYVgss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707380; c=relaxed/simple;
	bh=/NnCGZU8MBrwFIoxrMQkqvbohV8ulv38aEOmyERoYSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IhG5gi9Io4Z5OAD4Xz9tOwh6C9cxgCUfDtRacnmqS5dQIwZawd4XRWXOKLUsuLpgwy9wHTxQXYv2bsqv3WCuTo6f++tG3ZRSh9BTm7/EGeOB3/kehuIHahhUXxmkm/dhEs2sQcV9PBA/1VlWAjDOI5P39DXrFxw29+xZ2TxuVaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZJGBEU4N; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZJGBEU4N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+LOFln9Q5X4Gkx+SsAeqbgr5+f9KqsoraGL47BS6AHN5+RYeyaj/rG6yZRnVXh0EALfwbERGaGl9PP1y48YOfyIurtVWv11U4yk/ZF2t1NdjwU4VWXV6BSOneGVQ3REzEdAf94KyamgWIi0yv1emjhtN/qFv90gW1vbhBpQ/6oPO54sczwd5kwEnQSHYFwo6cI15ropOqEaFLP7JIXMefxRze1DfTeRpeDbFflajCkwigOE2am9Tnb9WmPTmGMbWSlkHmGw2VOe2zgbh1PivApJ4wcMX0+F+jFvoSOMt+sSQZMa01nm7QsbmTRDvCxdPBw//BI+ONPMNsH6O/A+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5gcMt0f77RLycOfNQzKbt2N7xNpAnEAsEFVqBsY7ZE=;
 b=zPpF/jhLsnSMHtjKO7XG11t0D9fyrV4sFKilBP0qpgMwhtdluLUHURtPP8ZJCFoBlkavX4TYe3ACG1h6OuTs1kO4lBQ5HO5rmKyQL8Jl6eVKby0+pQ95fTRUWZwPWbUAuCbFMrdVJC7WtIYn026Vu/rNvWyj/4LD5tjbZ6sA1SJ4sbYDMM8Cgyow31aPkyeSHA4lPfGX2MNdAdGg1SgR+OsEHhHzBsrV0ELCy+/QBYrucqBnJoIajDGuuXsPkKOSLeQrXtP6tXKid8hAZHbsN3p+c9BGMeeRVLeWPgA1RF0r+R6TIcou5gIr6u2H1DkdGSb0clZgEff6498flaM+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5gcMt0f77RLycOfNQzKbt2N7xNpAnEAsEFVqBsY7ZE=;
 b=ZJGBEU4Nq3IqeNJeV0D1iQTlNxxPd6OQ/ZKpkA2PXtA4XI+Ggt24A398Sf9pcFuB9tkKxRQ9EamrP4yR/BaaBsm9nxlxDQeph+fBd1WbUqpHY1NDrYhTma3LAMOzaRvZdW86KkzxI44YwgT697InJz08SY6Yt8qFX84rm3WoUYENG5KwACV09mCcLHvVViJgQn0OGjE4bLTkfrYTvpEb7xo2zQYQsXoG0zClTxEU4AZ0mCxN+BAfdUhlG22mQa3SpFr7FMv91h891kxSDhHP1kmw8aqrv3pHgwsWXn4vwzgiCNHhksUhVdBLDDTUKRubxJB+1AwNWjlvFh7NVgViAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 18:42:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 18:42:51 +0000
Date: Tue, 29 Sep 2026 20:42:40 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/sched_ext: Add a test for ops.dequeue() on
 remote local DSQ moves
Message-ID: <arwGoJF3PMV7llAK@gpd4>
References: <20260929161730.185271-1-jpiecuch@google.com>
 <20260929161730.185271-2-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929161730.185271-2-jpiecuch@google.com>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 477100b4-85ad-4def-9018-08df1e597709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|6133799003|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FcWSrLP7Cvcxx4XatjHgvbRJRUUglfhMhKfMu3t7xGejb3BUb0CfQx9i1/8bi83+o74zRvK3P+8XzTtXbkDXqsTg6MTCL+B2D5oXa69pM8RWa6HhM9Lsx7EYvqA3r8LKUGyKItNQionWImb7fsmPGygC8qrJyIuvmtlGkOFyWKMYg7BAKX35BNqjXFpGP9xbQxS9VRRTVRDxPKGVsOguvaV9KULaM3/HRGY/Bp7g8WzFUmlDdiuNdFpsdHM24DTkgAcAshOOkTWGBp3Mq0Dr8oY5zSG0+cAGLKoCF9XeK+SqmwOEDXIh7GQ0KmWQL+Sg9oqLZ/JjncRv9QIfZa+5fYgWZf+Bi5BuWzbu++kwaJ4ceOUZkAG+Yh8hcXzjsPS3mJ6mGiuGGVdV3ehr2P7roIE1uxet3Jqz+p8Ksi51l6lzp0dhsxLj4aThyzc5dLV3Cm+lRCGmeKd+qEaTwi6iVm8O0bYe5RhQFjv0P3Jyg+YT8xS49px/daAhQDUQaROwsbc5HWhRSdHahdCDi2T00F0Jd5fJwqX3Vb8cK2b7zDXWLKyAi0QIJiDu3VEYWXEZsCUIHEXbjUcsLgodITJUGiFTV/CWdwSENwYmYgsxEixVqoWiiPa5CGk0M8Aq6Wp6IG8PEzSf6WKQ84yq+rL1mAWr8Zvms1tt4Y8kMy8ODcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(6133799003)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?He6MmpRoSKLdVXlt6HA2iGRi6r9xHjGpway1CCrK3q2GsUBPfJDCsA6GdJWg?=
 =?us-ascii?Q?Zja3pwiiB9Woch55Zfaqx/KaplqK2/D0ksXji97mibRxMfN/Y0R7396Vv1D0?=
 =?us-ascii?Q?8EHfNFnHKfAvu3TgFlxuvQ2u93HQTK/vYDKVeCZ15dlO0wWFtaYgwyCv2kfl?=
 =?us-ascii?Q?CLMEOKYi5cjyj+Wsssko6LCY9Sqnq8kxCfCY4n+HixuIbEdzUlY2d/dAKL4n?=
 =?us-ascii?Q?lBTIvTieKMIiFUL/DaaNp5sWcyBjGko7aO9JpQwroMXBN4OXECwkj2uTZBtK?=
 =?us-ascii?Q?v49iGP1pwOrx0RH9fgjuTR36bmxg9pl9ywSF7Nvim5DILqdZu+BnYg+rDUFh?=
 =?us-ascii?Q?NebYGJ7/NUyj/VFoLrJxGzN6KQj8HI37Ns0I4hqb24Qb85A1EqPRtyerge7T?=
 =?us-ascii?Q?AKrMiggwgMjXP7lw0fXz7fDBBYlS4SIukRI8//DohZyDDwhx/3OesJmG1ITe?=
 =?us-ascii?Q?VvihUYyFdzr3szB0A0wqpV65Ig+hSgbbnjnxxsbz6UqH/+NJpfjjMDfuf9Pw?=
 =?us-ascii?Q?8YdOTyA3CCuuKYPgz3JgD+g1dCR/kFYHbARdESxKXetyzYh2P9c6CzJa9nL7?=
 =?us-ascii?Q?GEG3vRpsXG9ItxqiDXXyKFTPtJ+MIn/U5Zg0Dt3thSxfs7LTzoG2ymaB+iwh?=
 =?us-ascii?Q?06/yvGq1f6rsZURUBZz9En44Ra5lBIp3GJlVaZ3Yc9EEmSkOk/47GpVnIPJy?=
 =?us-ascii?Q?RuNWTzEGuaPOXNZij6r/U3HER46Mcr1sIHqkSkBKDTSbHEjbzYJ564YuHlfm?=
 =?us-ascii?Q?phYxEt8ghCq4O+elfyAbSTqTXOXFeDD0JrAzixNrv70giWvLyZjs0/H+A/GH?=
 =?us-ascii?Q?btxoDkiOZqxCW4fwb+VLVIqf/iRCNJmufrCWJuChH2LTzuMnhh14oSEh//Eh?=
 =?us-ascii?Q?SEq68jKE+q4Stk5d5LqTRMkPr0h7HGsBmmIQvgunwMYnF4k1DgR1Ytmubzbl?=
 =?us-ascii?Q?IUrgxli7LBqSxaeVg+fE1GaN9P180B2ssFhHe6aZDO7iYFqA4kaXhGd5+Ikc?=
 =?us-ascii?Q?YJo2Vy9+FJxC0fddvuYqF/ZMu1hu3N4koklOQCd39GqPO1w6AXyva3zIaXC0?=
 =?us-ascii?Q?bW9WK9BKDElLj8LI77srQEgr+Q3QN0TrgrkZhVjBe+1DuDraOPq7+ljsLOW+?=
 =?us-ascii?Q?66vLAOLkWCl7z0ujPGcJJ5Com+f7Jt6AceRjV35fdYACAsruTJE52o6X8slC?=
 =?us-ascii?Q?bKQ6O21ZISD/Zf18qhhsOmARf7fPE44jDXSZP/feRudv8XaZQrrfqtyd6Otz?=
 =?us-ascii?Q?K3SSoR4X/MjUBEhr1lmqPJBtXsyh2GrMWzXp8PBuolHkL86VnVeIZ0aPL4QY?=
 =?us-ascii?Q?t7ylKICdz0/+VSht+UtGpdjb97dSqZ50ZQI4WQNrkG5Q+2mxVY3vbuxBulxn?=
 =?us-ascii?Q?LIwKqMaZNJ5oKxC6P3G7UF+YCA/Hko8SN1BYIeu/ZyXHg3W9xLgownjtET3o?=
 =?us-ascii?Q?JhhdHI7fxEuTNKpORGaL+hXf7WLeh/3CTWRveMhKKY7ABQT0WH5+URl71ob7?=
 =?us-ascii?Q?uBEwXD1B6grrtttQwcMb8gZyNFEwmCqh9SsqvwFRvtoZbWDCeS66BiTgmDbx?=
 =?us-ascii?Q?3h7qNqN9nMYOskphuxYIHCs/rGEbf7n5zLgcDwuQAM7X4umlsCHoc8R4VjX1?=
 =?us-ascii?Q?UWnnnhrEJVKL4NiLw9cYnMylfnLkihO8RNzmGS8b6jP79IjDBzMrQlG/fwQ0?=
 =?us-ascii?Q?uARu7YvtPoPBiGtLwIHUWGMNspPAfZIK2bRnFdg2ILgQCfbdpAxIxZA7ZZlw?=
 =?us-ascii?Q?1l0+zV+AGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477100b4-85ad-4def-9018-08df1e597709
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:42:50.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhKuXQW9X8YtCg3M9KlYm1xxqmCjVCmmJHbnT3JdoUKLZO0yiLO9vYA+Tnf2ftn4xLslAodxqT3K20drGxr6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536

Hi Kuba,

On Tue, Sep 29, 2026 at 04:17:24PM +0000, Kuba Piecuch wrote:
> When a BPF scheduler moves a task that is in its custody to the local DSQ
> of a CPU other than the one whose rq the task is on, sched_ext migrates the
> task with move_remote_task_to_local_dsq(). The task leaves the BPF
> scheduler's custody when it is inserted into the destination local DSQ and
> ops.dequeue() should be called at that point, just like for same-rq
> dispatches.
> 
> Add a dequeue_remote test that exercises this path. All tasks are put
> into custody from ops.enqueue() and moved to the local DSQ of whichever
> CPU runs ops.dispatch(), so that most moves cross CPUs. Two variants are
> covered, selected by test_use_move_to_local:
> 
>  - false: tasks are queued in a BPF queue and dispatched with
>    scx_bpf_dsq_insert(SCX_DSQ_LOCAL_ON | cpu), going through
>    dispatch_to_local_dsq(),
> 
>  - true: tasks are queued on a user DSQ and consumed with
>    scx_bpf_dsq_move_to_local(), going through consume_remote_task().
> 
> The BPF scheduler tracks each task's custody state and triggers
> scx_bpf_error() if:
> 
>  - ops.dequeue() is called with SCX_DEQ_CORE_SCHED_EXEC, meaning that
>    the custody exit was missed on insertion into the local DSQ and
>    deferred to set_next_task_scx(),
> 
>  - a task starts running without ops.dequeue() having been called since
>    its last ops.enqueue(),
> 
>  - ops.dequeue() is called for a task that isn't in custody, or
>    ops.enqueue() for a task that is.
> 
> Core scheduling can legitimately pick tasks straight out of custody, so
> the test is skipped if any task has a core scheduling cookie when it
> starts.
> 
> The test currently fails:
> 
>   sched_ext: dequeue_remote: dequeue_remote.bpf.c:143: 156 (runner): late ops.dequeue() with SCX_DEQ_CORE_SCHED_EXEC (enq_cpu=1 cpu=3 seq=1)
>      ...
>      ops_dequeue+0x114/0x170
>      set_next_task_scx+0x104/0x1e0
>      __pick_next_task+0xc7/0x180
>      __schedule+0x154/0x1870
> 
> so don't add it to auto-test-targets yet. It will be enabled once the
> underlying bug is fixed.
> 
> Assisted-by: Claude:claude-opus-5.5
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

We can probably fold the this into PATCH 3.

Thanks,
-Andrea
