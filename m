Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E4361941
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706674; cv=fail; b=ADo+ywFOQDO15feHt5OUkdn9JeCIcJfGHaBI/yFMRp3iSaVKiw2jppYc7XtIHxzUpaeoW0buhwq5ve8BgBybd2rZIOF+92d4Xd2maNMOKm0gskAZ2+pgSWIUFM/1cxHf5iJntpKtFsql9SodwJcdlj55nfBg25OBfJpYF7bwi4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706674; c=relaxed/simple;
	bh=Z3UeFkUHlIOcP46K+ut+NUCI8LmaLEpFP1qNcEtHjKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fW7gpO/eZb1aKMvcENYdLkejyyd5TDpFd8E/bV3ihU5f4dBUFK2DTGGrZusVriiV0hYP1rzj3MQArYXXDxh5DMXkjIzw34FdXkBV1AUIyU0JK+HgX7nn4R2k/oVmYEmM5vG0kwMHhlRUUS2CszhbjxuJq9HAo9dMX8W9K3IaxIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tkzq09RI; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tkzq09RI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlNDOv7aBP+/d3Rj0BSM2Af5HYdTINw2vAAm7M3n9qC/E7/njGynQZ3T+RV+YQ5m4xKKVaQcc6ssvW8x7yOvRyiSEEC4obDcNx9e7pbSKczbqyKhG0KbM9VICBQTTr/NFj8JFt3rxAx8Htl9uVemoHQ6K2EF62qWhuhbdJHADle+WaLn0zoTf5Kf/zxvH5mKBjxUbrG3qQFt74a2uUV/ZBI9pGPig87qLgBod4InBjqMuChAYzLJdWXCxrt9F3UgB9TKB86e3ewWQ3Vi3wQ+xjP5wP07gQX0CscQMY/YOnL2o/egrbSzHe8mMMfJqyC7fgLp0AZxi2014BEvkvKNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4LMSDsKsGvRVSE1tpG1C4ubaYLNNH7muZmjT8/nqGU=;
 b=Dg5ILZvgDTBeNScoMsofp1kKadk6aiLz6dQ1jfCWcQGkyyE+L4qnAsC0Ot19IK9MKnVbvD9P81Qnr25k8ZtuY0wPVKpfU7/3WiVFyBA3RYnnfNe3dBOncKsPF4b5cjvegAOg/zA61woDUaXqrUm+VRwwihFhSp1u/MXPmwITr67AjniG0aCj2xgt4r0TlNTSnzjNlFy14VlDBeS47ZfJuZgU/0G8EG4QrjwINXj/aTTi5WWcQv4hQeiaLc+YZZ1OMmvrfmadS2czDD7RHeLGk3pwpmHboGsBwODZhurZBZm2BSPEDUpVUjB/AacocmlophdPaOaDgehMdstXrtzszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4LMSDsKsGvRVSE1tpG1C4ubaYLNNH7muZmjT8/nqGU=;
 b=Tkzq09RImxbugNVIOqBCNntU/l1MKfY3c6qaYqnG7k2HE6qxUOwhNWYftYlClCCwLS4UQI1tcn8WS2/OHbc/hPKxrhOCrYG9+uzQXH+hKgCTTl00SJhVMvdY4ADW3bazxPiM6NxidSg1jmV16KwhZ76xDK5fUGtwkSiIlp0/KNfhq3Ja+i17ifI03mFqJH1aVQlFup9lNNhk8if3HXT8xr5Ie22m//OWmkMZTusi61JiA2v4uXqNFM7CinMzThSkwgWmRu1J0ZvBWRmnQ/QUWp2Hf23Ay1JSwt41bkNnlx5uFrscEX5rmz7UX5YaQOagR4Z3n5VtTeNZ4gTWXu8wJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 18:30:42 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 18:30:42 +0000
Date: Tue, 29 Sep 2026 20:30:32 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix missing
 ops.dequeue() on remote local DSQ moves
Message-ID: <arwDyGUX7Uq_oeHg@gpd4>
References: <20260929161730.185271-1-jpiecuch@google.com>
 <46f4b66249f016b675fa16446b2f2f99@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f4b66249f016b675fa16446b2f2f99@kernel.org>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc6ca03-0ab4-4968-b0a6-08df1e57c49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|6133799003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	gCdGZxxD+dg/oHG2IaIQJFpWi+G9f/CSYJhFacQHHuS7b4yTJdjHsN891e2zafWygsHUMwRbnzOLKfg8zN3yYB/nu/fQrGYFrcJKfgkGqcpFpIaOjZPguq+JJFqoet1TIIFSxEEp+0ldiJHvK8tjDJEHUc1ONNlo0phCo09qo6MYQDUEmbuzrKqeok7FBmB6ClvrTD9Z/NQs22wAnL96sDTPQT+z6MoiMTRUTEsxpTfnyd3qDsSsHSNhEs1SCinVUrYELUypghe6UevQmhifSCplKhdXRYCosEpkJ4yQD8IxMyCm0/CICUzfTjaYV7mcpxs3kcMgpxxx+ZGsSTaMC83EUTsXnTlLMRYXtdG6HmNbf8+oPBnTkTbvqL4xKnz5U1srnhu4qKkwgiJLUImj/fk28z8jaE8tzOsqCQr14poBE6jmvd0ByqzNd0t4jbueyxnnO5lvdZDBwNr7TKUafrwa3PeCXVcyu8/cv2sOkBrC+AqddGcQ9PlA64yHIIDNJQLwDYj5HcOH0ZpR7//a438L0k6b8UrXIqPAQw9feJh1dPgdCzT5oBMbTIkl0tymMgyo/oYryvk1dtw9cvTWtKZISC7uynhYQhsx8P+TMlJMP3eV7aQqnnt+A95P5JogFsGOAcERnfnjhSlzQ6SraND3WrTokwNtwNMk8/34J6M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Jbyv0YE1IqMiko6YkQz2UnrZ9YV2WXOYmDdN7Wz3an3xWofNnJL3YstHnVQ?=
 =?us-ascii?Q?wtW+5R/J4XAri6cL2T4nF3WgAfkn25V5SRGrQojGlb/3EbaWP3Batgpz+BdZ?=
 =?us-ascii?Q?ZQ/Cj01aFSkHB0dAlDrVmxti5q8Sy9h4Zp5qe+DCJMm+mQ/OBa0HEpR+nERD?=
 =?us-ascii?Q?szJRb11hSj4QTCGlT3JgD3HBNRYAHgAqyV19ADoo8zdo/HaSXPWxMwNMmtJ7?=
 =?us-ascii?Q?JnNnsyuAsk+RxH6PxPO3UochJCXchQDm0odxRlG5IRslMrYopLK3CYmq897I?=
 =?us-ascii?Q?p8bVzJlfhFZVr415lqnsOGIf4iCbgQiDJ0NnbnXhjbrrIlHBaks3GayBZceA?=
 =?us-ascii?Q?cXK1FKCz+AuHQh91mzf7/s9QvI4t8sa5v9njbI7sucDsnZXVjxYgC4Gaeh3w?=
 =?us-ascii?Q?MzdqSQTFOsP9v5OOPZ3TwFtFr37jAmjRp4rtMzTYRiIlU3SYkb5k2wTXBvGi?=
 =?us-ascii?Q?d5DUocWa85gE3mJajAc1axaD66tjIgQuMFh230bCFU5R20aNtNegDmW+BS6m?=
 =?us-ascii?Q?YkYwjug5HshJwu0YynDZROp/Git7wqE2jx7QVT24jWInhTNI6R0uHd0BnmNA?=
 =?us-ascii?Q?ulHk0MVzuSn6f0JzasHovskT0IxOvu/iG21oNkXLVws08xzuNW4hKbDRrhRL?=
 =?us-ascii?Q?cNLIM2nZqPDCATET5ctKoqBvhtNnycmvaiOS14I/0Jrlx3FT/o/s1ZEIryEC?=
 =?us-ascii?Q?OhFpPDiJpKpUU8T+YkajeMakuszM/Fj+7BIfRC8IvCmxrlezjqKqPfODHXzv?=
 =?us-ascii?Q?4cM4jWHgIUMPcvf9mWJFg5PmC10s46hFyfrGlTjmknqQ6zjBQiUUI2VRsYFL?=
 =?us-ascii?Q?rxeiHob7xJRtqTzrCPGbqrcTlPmI7xLzcJTk3GWZ/Wdr4znnF0XZN4dTMyKo?=
 =?us-ascii?Q?loPSFIZcafoP5e5ACrytpOmVLNzZ5Fhk101NTi5FsEkqmUKCkJUl6trNpZYG?=
 =?us-ascii?Q?WUcg7te/1uIdWQYDoecWHWs+cwpOZSy6DAKvFCUeRLnprImQO2RczbXv3Vp5?=
 =?us-ascii?Q?s81YOkw2wA41KS1BweP0vQNpPMBKpmXOdxHe8peKlhWwxvG4RvxnImBV1Q0b?=
 =?us-ascii?Q?86RR58ioCyvCmu7cbOFENmnzVhwp5QcvLwjVmtXSCuCTdZMj7K5kwxT35CUw?=
 =?us-ascii?Q?7ijOCBuEaeemNdaL1YNNOk8PQBVO8edAd4bXwjnuK/XrScB2BKROrHgVpkzR?=
 =?us-ascii?Q?8Fzj6ezDqLe193ebT/dbhke0h2NcH5dG6FzfU00lLCpyGr9DrILmzu8WBPqA?=
 =?us-ascii?Q?ySHKapT+77tNid+g9LZvQBNUFZD1c1hFyCUl7PZROHKSDtCArwRIThfoy1su?=
 =?us-ascii?Q?w4zA5PZUPVdgeQ3qOVU3236sIX8y7dOfsv3Ic0NXSIIwCVWwgHGfcQI7Mh+B?=
 =?us-ascii?Q?K8X+2sZ7yYD51hXbx43sCbAR8qpMiLMbNMrxx67xzJA7eqd1yXteO/VSOefz?=
 =?us-ascii?Q?W9QhwS3v+MxdkUQLvGuFQtD3vBB77Qd+y51fSpqi3lkndqCxyO7tYS7kbvuZ?=
 =?us-ascii?Q?JuGJqWL9thF0dbWOziZ1EwILq9VtYFkINbHfRFHYmNUtmx1KlVpjKtOGbfi0?=
 =?us-ascii?Q?v+vBW5FPKOMCnWWOSd50Hm2aK5ocAychdh/NM7CR5MKgvyHMsQ4+lo21jJYV?=
 =?us-ascii?Q?miYgSzNJXiAKEjZXYbsHpTBJCR98e6LyiFtROvIIQ2350H8nmmUoWluOQuL2?=
 =?us-ascii?Q?Mco0w9rPna67eujDiF6Jk7R8BdD6qgci6bJsARWDdLsRxzODrXXBDO3ceYrA?=
 =?us-ascii?Q?ZWCGNc1ufA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc6ca03-0ab4-4968-b0a6-08df1e57c49f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:30:42.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijyiA548Yl+Nior+I4pTZCmKgkiGcK2YMbGOy6UUmFZZcCvxqLqLuA+mVcpS17uCCN5D7nYwtbmekhwMdmZOuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658

On Tue, Sep 29, 2026 at 07:13:07AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 29, 2026 at 04:17:23PM +0000, Kuba Piecuch wrote:
> > Since ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics"), every task
> > entering the BPF scheduler's custody gets exactly one ops.dequeue() when
> > it leaves it. A dispatch to a terminal DSQ ends custody with a flag-less
> > ops.dequeue() at insertion time.
> 
> The fix looks good to me. It effectively reverts the enqueue_task_scx()
> half of b75aaea24c9f ("sched_ext: Properly mark SCX-internal migrations
> via sticky_cpu"), which as far as I can see only ever suppressed this
> ops.dequeue(). Andrea, can you confirm?

Yes, I confirm. The source-side sticky_cpu assignment remains in place across
deactivate_task(), so the internal migration doesn't trigger ops.dequeue().
Kuba, thanks for catching this!

> 
> - dequeue_remote.c isn't built until 3/3, so 1/3 can't be built or run.
>   Can you put the fix first, followed by the test with its Makefile entry?
> 
> - 2/3: 7.1.y also needs 18d62044cda7 ("sched_ext: Preserve rq tracking
>   across local DSQ dispatch"). Without it, the nested ops.dequeue() trips
>   lockdep when ops.dispatch() uses scx_bpf_dsq_move() to another CPU's
>   local DSQ. It's tagged for stable too, but maybe note it as a
>   prerequisite?

Agreed. Please mention 18d62044cda7 as a prerequisite for 7.1.y.

Thanks,
-Andrea

> 
> - 2/3: With sub-scheds, scx_resolve_local_dsq() can divert the task to the
>   reject or rescue DSQ, so "inserted into the local DSQ" in the comments
>   isn't always accurate. Maybe "destination DSQ"? The new comment in
>   enqueue_task_scx() could be two lines, and the description could lead
>   with the late SCX_DEQ_CORE_SCHED_EXEC and be a lot shorter.
> 
> - 1/3: A task can only be picked straight out of custody through
>   sched_core_find(), which only returns tasks with a core cookie. Checking
>   p->core_cookie on SCX_DEQ_CORE_SCHED_EXEC would be exact and would
>   remove core_sched_in_use() and the skip.
> 
> - 1/3: _SC_NPROCESSORS_ONLN ignores affinity. With the runner confined to
>   one CPU, the test fails instead of skipping. sched_getaffinity() and
>   CPU_COUNT()?
> 
> - 1/3: Nits. If the /proc scan stays, PR_SCHED_CORE_GET writes a u64, so
>   the cookie should be u64. ops.dispatch() pops one entry per call, so a
>   stale one idles the CPU until the next kick. Maybe loop a few times?
>   missed_dequeue_cnt and core_sched_exec_dequeue_cnt aren't printed
>   per-scenario like the other counters.
> 
> - 1/3: The variants, error conditions and core-sched caveat are repeated
>   across the cover, description, file header and comments. Can you say
>   each once? Also, single-line comments are usually lowercase in
>   sched_ext.
> 
> Thanks.
> 
> --
> tejun
> 
