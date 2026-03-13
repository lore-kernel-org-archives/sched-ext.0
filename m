Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1540DFA1
	for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429365; cv=fail; b=SWoMVepYzOE3sJZ6qIKeaVZxgs+PNt30POfFkicZrvzxKbFGIyFZRChyaChQxBPPveagCnNJfAUnRUonbPm4E97FmTvtwdwrhAJFH0hYUpQnJCsvSXkKupUk7Sk18wRzjVPFwnxz1eucZPgs4iIQ/hd3Wes55p3hvDGKNO+3CXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429365; c=relaxed/simple;
	bh=M11sjtC2IU/z5+d6RNceLt9+I99HMe//2/8u0bik/aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CsozCdwzH29fX66zoVSA1sJRK04ZgFku5XId0z1OIEW38d7aYseaSNdjy7PnVW2UexXwKNp/DWS7Xf0NtDfCm7LSJEafFOdUv5xDRXtStTZ6XvghwxQYUXlvZH7oiszU/ce2dbJYkxAS9HqmaD93Yar6h/cZTyOJ7EWToPuEg4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L8QrfIzt; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L8QrfIzt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LETEBIynnEUaiqaladuNgr7Zs9Ryh+9v/990oXJxhNsx14GUs0v3fhc/xVQnCuKrFIrOjwo3Ah72MlYHCSllCR4LEHWi0hII71VxjlYJl+/tVAsjfFonrWY0q1q+uTAnMFg0M9gOpE6pwBdHxTOTTf6fKcj1xSJcxcL7GDIfziELbADbxqzRvtxMv8t/aHlitu8J4WI8u7/CYgNUE/gfKH4MSyzankYHiIce753+JMNFGJAWPSg0k7E99Fmf+DBEcnRfX6N9GZqRmPnzW2OXLeBWGCRmKJsojT3u5mIOaHIFagPuXDEi8akLR4w5xwxCrlRW1AYFKMIGyDyo5JlDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q32b689WorxOnFnisKObnaWolGqVJe6xS7HdxEMb6v0=;
 b=XZN3OxkJRTUGFRTq1cVdhaMCo4HITNltEscxoWDJ+T9YWIdXnoXbP+lXMhpchaHT/CJGXsc3Z/kyYnsNdccbdDGIksVRNh8f/0Wtj4dERhSDgGjwuQ6HwfdlGcKf8EH32IQUvo235Q5nq0tYnUOBCw9WUL7sESdR9f8y+Q+rcXtnNkZiAwgOegwHtIgh0dqs4TK1SHi4xGk/dLay/uwBiGNJRFE4rtQhzhydzNGwQiROzoHKliRhVSdOwOuP3vXMwDY8xvgT43wnoHOTl1/c2fFsuKMAvHVfKMRq+DyMRE6PJcWNWVARDryLT5iFSWVpzgdIFHzDZp2UdXe0okdB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q32b689WorxOnFnisKObnaWolGqVJe6xS7HdxEMb6v0=;
 b=L8QrfIztY57gmaywPvxZ8ZeddLbni4hibHtfHT/1l40OnJKmqqHtWGZo3n/3RuUUQBd+wmUJWB551TDmw3kuusY8wvmSy6tOkvfEgE2PenhQ2LrgyCsmzbLD4zHD2HLQRcukmnipPevfw+HaeLcUYWTsntr+P15t2rXq1xbCoxROoIbCYINw1fIDdHwvytbACp2Z+5EFKkpUeyGpzPxQCl4yBrvHYShH9/+CBHSew8cYR2GgaPJOaPYv5kCzLXIx3GNln0aRmRZ800r7NPYDCk63KZRkPfsmXCxlGKVdLmVwLAj2Zg5NUUcnSCtZAbobCcmup8boGX9rhzXqZtbaQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 19:15:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 19:15:52 +0000
Date: Fri, 13 Mar 2026 20:15:42 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] sched_ext: Implement SCX_ENQ_IMMED
Message-ID: <abRiXpZBx0WC6pBz@gpd4>
References: <20260313113114.1591010-1-tj@kernel.org>
 <20260313113114.1591010-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313113114.1591010-4-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f61814-22e6-4457-7a7e-08de8134f15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Nsw73Da9/82tjL8Or7n+9u8eJBVOH8GaaxZjk87zivOMn+BpthxY/EC72kQY0Md5zfoL/wXKnYAaSrKSMZpcFsw5yqEK1W41amTVZC+di8zG3PlSItlW0qvfvxZLGTZ5LTtfgdWZPagmGgHDp1adSayHrSc7VnWoCyGiVwMZiqJfTZ44zxrQFUXAkAahGmEVJjfc+llzbx42QKyScS61UE2eUtkCcMpxc2LgKbE80apBInDazGcecys5GvR50RqkoUhJFYIizcUPdkz+gEHL4gRme4zOjsFQUjrzOYJPxmvDLpfqCcbm4bnlUDtvMAQnks14hBZ7x1qhPsv4PbEMhbPvq78Tm4n7wEhPsA07NeWdPN4l7UHEoYmpJsh8nKl27V7fq5pgCeBKD/T60xy23x7ufJ9op1sOBk0hSt9U8wG1/h/xD9IO1fpGJxLAdD5ptgYNsBDLBQGUGW7x4PyN2S7xYbaaMQ5SDv9eLqdsFfSS7kL8f2x7Di+QKWUgV0RM3X0K7qukngspfY/dxSLkLoiyy674WvqyXP8DyW2AjV5Quh+auyqLRKzK+f1LWkvkCdsjqtlGYWpK9HxDrADCKHZZpn2oqZZPZUV7cvd+nizHFdB+MNu9FtXXRI3iinYE/SCLYAYMV2Ft379uTrmb/c4S1x++pJk2TpXtsEJy/5hnbmenugGrm9zQhXVLlz0YL7zZ+eoUBqdKR+x6dI4KWsIfmENEzJ+4Sl/mdDj+Vfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?88cnz6y6dh9Mtl8Lhegwnm75mq8xMkZcUBAjlGVNqRNXbmOXmvWzq8aL7wIT?=
 =?us-ascii?Q?qGpD5MqGyxVXbglOOtQwsU5l+NCp/3j6DA+TtxYixtTE2YopFnvh+ZzqjgQ/?=
 =?us-ascii?Q?W8UWZveIiJb1fh2QMYF6DkZyANufevPIjTrXhXJjdT46Eb3AHEj7pfJqrOuo?=
 =?us-ascii?Q?1dVyN/GXgVWpxFV7XvcQbGu3UnuWOG+eJlOeQ2vE7LBLJQgmaAkzQHOJczP1?=
 =?us-ascii?Q?VB15ZD1KMHw8Ma/hG9bUWAvk4jOJ+v2ZVMMepzKZrUK3OKhPyt0MCCWleT2Q?=
 =?us-ascii?Q?486JGSSYYfdpkijyzKdxaL1EoHWMs9+VNBAkQ9RqDnE8deZVanYUrGjI/W4x?=
 =?us-ascii?Q?iem/6g0MWf+/JE0BXhqRzMBycfpljBJdQI0GzbNfZaH5F1M6yxz9u3AiYY+S?=
 =?us-ascii?Q?/gqRbpDc477I38heTTb46UowsGrhFcSaCHW/4sHaSCRmiu7jgbxbsrnvOJYz?=
 =?us-ascii?Q?Na25bJ8FQ9E55nF2FRdMmx4CZTQxCXlO4i+eQzXtStf86q7SgOZGE6Jvij/z?=
 =?us-ascii?Q?ND4o0hCQVhJusrTGjBpuWZJ7ju4Te8Xv9uU6LUoUF4s2c9FSBJzU0DfVnNfp?=
 =?us-ascii?Q?c0+tSLB/BLE2tmyB/tlEE90PNsfMqrjVPOX/56ELzuXwQH/CMV1hTgaNVUnH?=
 =?us-ascii?Q?5JdFZ4GePi85YuBgVVB5+hfLeqwtk9jHggd9M57pqdBcAHde53ZYy3AKbJLS?=
 =?us-ascii?Q?3hVO+kzIVBzBmrZY0kJW6JJ+EzzBo0PCFogi4xYqryZtL8ZDGUdDTrnRIv9W?=
 =?us-ascii?Q?Ofis2+LGwTdhdpDinHXyrPPB/wxn+LBdnP0+klhAwMS3QwcMTaB+hbHLHxhh?=
 =?us-ascii?Q?79ppaaP1Bx/xtGRlRi5wOhK8fuG0HAxMKrhM0ZyqY+P/55V+o/M+7EWAErmZ?=
 =?us-ascii?Q?eY3cp62OkVaj1qNBYFayxJwXwP2VnhI+8bkgKkyWDZpSFVm5VJbqhFar6um9?=
 =?us-ascii?Q?zntzK3vz8PgCgLkJvjV7sH0SzYcXCI7wUxeXRdG22J8+mYNXFavWO+jVehOB?=
 =?us-ascii?Q?6GkwhoYbrbY8LL4mYsfOtLsDVEBltIRFxeBHWBhetF1c1Tz3k2cvqQmMxlor?=
 =?us-ascii?Q?JzL/TQZ3NCvNV5TH469vY25pEoVp9MEBvqkPI0A/X7dM/3pN9XCacAQ5lvOa?=
 =?us-ascii?Q?FH7bzUOjyLn4piHvvpyafvU/PV0/2+b/KSkls/8UrpcgynR2dNy3BJtRf+MQ?=
 =?us-ascii?Q?bL1+2uKAzhulKUPhIuDptwLA3Dtx4G33OB+ALeg7Dhy00hUHZz/fZdKr9x5h?=
 =?us-ascii?Q?bWd8gP36GTQGi+NspAtPd4l8icidLnbN147i5oFW4S/B0M5y+mEbm0JHpAJu?=
 =?us-ascii?Q?hkb3WMT5fhaGyYyMXpnbO+0PrCsUsQChgRH831GkyfUnFhkqDYUukjabtpSq?=
 =?us-ascii?Q?BpBKakEpzJobtOm0hmCUCarQcUcByTNXEnCs7/UBIp2+vLDLm4cACzwe7UO5?=
 =?us-ascii?Q?Z03+o6s6O6CJ8rV5hvQyY/h4mEAgXthpIPSdPCZ+y1UJA0BX0y5yV4SaGI6w?=
 =?us-ascii?Q?0+9Z10BAGHhpYEQbcdcwnLaHFpPQgiVtwstIWyyVCTxyPUUxd4M3RrDVPCxF?=
 =?us-ascii?Q?1lUyf8z6UX0jpMwPZT1mFtfk5lz2ZpSCnL0FDUOP9ug6q7TTDw2l/WdT+B8I?=
 =?us-ascii?Q?rJnODQpPnKtL7isolUbNx+MUzyxG2ITSFYjB4l9OO1oNTzSsuIz7xJUOXtX8?=
 =?us-ascii?Q?Eb+vWZzV4qH8S2ppN5K16TbpDob7xUtAM1Y1Ku9SaYdzlg/NvdXfpyK7sjqz?=
 =?us-ascii?Q?eylQOw0fFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f61814-22e6-4457-7a7e-08de8134f15b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 19:15:52.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8gk/yVhKi/vS7NRzqTwaDD9DFfPXYhEUYegYQCjPHYgQEObFpJ8mpbHQx9+XS3jVuimttNphUKNvr9T+/mhEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586

Hi Tejun,

On Fri, Mar 13, 2026 at 01:31:11AM -1000, Tejun Heo wrote:
> Add SCX_ENQ_IMMED enqueue flag for local DSQ insertions. Once a task is
> dispatched with IMMED, it either gets on the CPU immediately and stays on it,
> or gets reenqueued back to the BPF scheduler. It will never linger on a local
> DSQ behind other tasks or on a CPU taken by a higher-priority class.
> 
> rq_is_open() uses rq->next_class to determine whether the rq is available,
> and wakeup_preempt_scx() triggers reenqueue when a higher-priority class task
> arrives. These capture all higher class preemptions. Combined with reenqueue
> points in the dispatch path, all cases where an IMMED task would not execute
> immediately are covered.
> 
> SCX_TASK_IMMED persists in p->scx.flags until the next fresh enqueue, so the
> guarantee survives SAVE/RESTORE cycles. If preempted while running,
> put_prev_task_scx() reenqueues through ops.enqueue() with
> SCX_TASK_REENQ_PREEMPTED instead of silently placing the task back on the
> local DSQ.
> 
> This enables tighter scheduling latency control by preventing tasks from
> piling up on local DSQs. It also enables opportunistic CPU sharing across
> sub-schedulers - without this, a sub-scheduler can stuff the local DSQ of a
> shared CPU, making it difficult for others to use.
> 
> v2: - Rewrite is_curr_done() as rq_is_open() using rq->next_class and
>       implement wakeup_preempt_scx() to achieve complete coverage of all
>       cases where IMMED tasks could get stranded.
>     - Track IMMED persistently in p->scx.flags and reenqueue
>       preempted-while-running tasks through ops.enqueue().
>     - Bound deferred reenq cycles (SCX_REENQ_LOCAL_MAX_REPEAT).
>     - Misc renames, documentation.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
...
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2f59265b9b57..85cdb65a5a66 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -406,6 +406,62 @@ static bool bypass_dsp_enabled(struct scx_sched *sch)
>  	return unlikely(atomic_read(&sch->bypass_dsp_enable_depth));
>  }
>  
> +/**
> + * rq_is_open - Is the rq available for immediate execution of an SCX task?
> + * @rq: rq to test
> + * @enq_flags: optional %SCX_ENQ_* of the task being enqueued
> + *
> + * Returns %true if @rq is currently open for executing an SCX task. After a
> + * %false return, @rq is guaranateed to invoke SCX dispatch path at least once

nit: s/guaranateed/guaranteed/

Thanks,
-Andrea
