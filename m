Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3242F3C10
	for <sched-ext@lists.linux.dev>; Mon,  3 Aug 2026 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789756; cv=fail; b=utDCrmxGKAICyrv2WtplFhpcSZh/j4hNUsyLtCj0ZziwXaDcOIdaulvE4y2MTmKwCvL/tVKdUQVszWZHfQWIjSK/mECQnrDbjtuY/yp4XvNQG2ckv29sUKgWIYLyMYVAmJuoIlpecIyuSF63s1OxL1bEPk3Grk1bCGdY4yDg/NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789756; c=relaxed/simple;
	bh=ZT+7/D4br5tKk79klczWlrKQZDBJIwWPFS2m+zABFa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DYTJX8Tw7/7ajSd8y4Q+ngdWg0Qd+9isQDUAnuDivWg9aiQ2M/d05lNIcmhlUq2NT675PfvZo/+KDnYRxYlU6m6FfNRsG+I55Mzp/bYF/+JJhRs1w9zjLgmopifkKuVXvWeU+VDuTrcBuf2MC7v5T4AFG62t+If59Syp6LNl+cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DlaayE0z; arc=fail smtp.client-ip=52.101.57.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DlaayE0z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3RzMoaqqrRdNsLZfQL/V4xNDDxeoFbCvwEKOSMJGF0+1VfiVEAwXwZfwuhdsNAq/Lv+sWLMLISyJ5cvwiTxNNG3zfVIrXuH7R6K/WAucwN5Udm9qL9drOg4hkjzaAjpQC/uT/YQ7yCmpvX6vmGO/wnXJnWmggE9zPhfTnU754gMJo4a2gsCftIZLEwcordFPUeEuTC0OSq3VyiRjbfvJ2Y309Jf5mt1wn97JZ9BkZIEvDYJEmqKFxrUTVvqPMQ02A9bXsY+5vC+9KfVcTWeZJJxo5AnQKFGVW3RJMg3zH7oMSdQ5EaWPMsyVR4C+m+TpdnE3FkWpfXlBSw4C+/4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q5Dh/kPT7BOnvJMZChqOnIhbKcsKTIZRZMp+n0ZzYE=;
 b=MqOKnd02VbZ8bb/yuzHkDtYpuMKoP/AtU9XRsKc0bkBQ0hDIrtWWThEsz+uPeVcjxt+askRnsfmGrMwALaqQZAQ83RuHL1aInGYpe9kiJW/Ly9ZyhT4MEBEhkdIVtG7ngLUK06G5pDDKE/+vD/1hVkwk654hZbmaH3ZaOWz7zoDgr/eWNB7P28NQelcup6Z285rUt+AZ4LplHT3Zn28azinOpoJu3y29Sv7LPD+duMo17cjr3hb8lEg2DrOEAoU1/VwlThTn2Jlps9r1d77BY3YOnJ4BZxTFYB/7LVDZdcjjqP5SaXTtFyXi904V55BVqEEPRU+GMkCgVMLGpD1ZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q5Dh/kPT7BOnvJMZChqOnIhbKcsKTIZRZMp+n0ZzYE=;
 b=DlaayE0z+KjXzFxotNHu/f1nSpjX9ZC5seEqz/7LQt5XqLkfpoY+Vv2pBRFViFN6TmZRNgDZa6Vz7lqFKjNupE/C5WygsPsDuYV8HikflHzM4v/uFj7v5PMb/mLDEknuL2SVWwGFDOiM7VofhTMllZOSo5fpta+2i/WMd4sJ8ZRMPypn6QLmqQSa1mihUK7M/tMt3iuHtv1WRK4F4Ne8laTPd/vTVUzDFpLSHnraMeS9loNPEdO8hs2LGvNcKHgImAM3AvZZu7a8bPuVK9BfHlPcmZ0caWkx8/ac8JFkLmajo2Uzn6UjHTVQlmCxFhNY9tbUZ/xCE9gDQ2xRQZAEQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Mon, 3 Aug 2026 20:42:30 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 20:42:30 +0000
Date: Mon, 3 Aug 2026 22:42:17 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Bandwidth-limited
 rescue execution for stranded tasks
Message-ID: <anD9KfBO6Bu2lLVQ@gpd4>
References: <20260802215447.3134509-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802215447.3134509-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7a68a6-2d8c-488e-9955-08def19fbc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|5023799004|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	z0U+7x7wnVb5mFMjRUfzhKsTlc+F+UksVNGOTdT/WCnDwMCa/v9ytCjlSDTeYUmgkDmYRkz10YgWIK1GwbjrNvFSwNpWgqkQnvHpfsvXLT5PNjz0n+vMTssdhRDUID3UrrqPfPZvOHha8SZpR7vcKXoY7D3JdFNxk/vbLL0tjxbOjxNs42jyNxlq1NOBQ5UAxelF24G8Ow0v0Om3LTd6YaOqE5qPsjwBe6uc6zKcNPMqbQQrdEuCLex2z/PL1KzBpTXEsYjVonW/C2Ih0fP9G3U8Ia9/bgb+zy6XsTyGt872hU9jCiJ4IR+pXVmp0iDOPnh8M5MLOKRs0iHv0/P9V9DZtQEXKIsU15rpB5Wv7cL6mNqv8SfqY+wOB4+WXp22tvfQnHrAcppZTi6gW/NN/Mxds783c77RA658nB7sn3L06cEVsqPXpw5UYoD6n3XEgWmjXyiumW7TuusX+ZDoEvU3b1G/NChS2jzYeUTq+y0dDfUF5L6NkPa9u1UsCqiCvAQoNls5QXarcSoXpwkk3jXE/WkHj1KtQRY3PS1I4htRPzd6ZGhYCEMdky5f6KKjrSwvETzz0t9odlxdSdOEddrLwh+9qkR0CBqmPSVwKrk/wyF2dDvvfd7+bOsbWUDTojNfd8bWpNYbbmjOr9k/T70SWFBm/bupUC8lHN08Y04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hhvE0dNOzpVGnZeV7xzVtZWEJT9qO68nkpHDcQfNuRfk/V4ub0A6M1R7n7Vg?=
 =?us-ascii?Q?o3yhZt1qyAgjXemA+UUjxZH1wXSAoy0C7NsV3ZdRHitG0MQb+rp+kJ5k8OV3?=
 =?us-ascii?Q?5sto7P3n7Io3CN6Y+pZdzkZ4apVBMdSyPaGAfFbkt+pq5WOLxg+/jXVt5j4g?=
 =?us-ascii?Q?AdJA0OgVTSgA0wb5JQt8tOKNujeiwHRegNaK0uLti8XT5Wod430aEQizyA+A?=
 =?us-ascii?Q?B331obl4Vqbstde32Ez02GGQf6/bRfUsdL2I+qj5PPARrix5mI8OoenaYWF2?=
 =?us-ascii?Q?cDe620k57sn0dWC6fO+qiRfVtxsZZ2WaWVR9L/n11UUZa6CojdruyhRX0EJi?=
 =?us-ascii?Q?cm1mrZY8IC0JwA/2cqbzg91u1a174OsNcHO9kjbkaHlcxeusXSTgl4D6exGJ?=
 =?us-ascii?Q?cgdVUjD7e+WE/pTb+9pP1drEx85fpBazkxRnsD9anVy46MoaBfTGU1qNDRFC?=
 =?us-ascii?Q?wY3nV9l09e5qTFgGz+5X8bWbUmayUzO5gMaU7BEU4YKc2JboCHepwLs/AsBf?=
 =?us-ascii?Q?teqXNy2YoACT0mypuV2lHa22YtHkuLvaxoM0w7Q4v5l5ZuzAiwX7Hu5RkrjE?=
 =?us-ascii?Q?TxCi3LF3zdfVAjy1Q40rudv08VZHMPw2snDZjh5HIkSjZ4f3Q1ass2sWkyDy?=
 =?us-ascii?Q?YluBuGFHvme7a/N7YOwimwIWl603TkrRnVHCTs0i0FDFQPPeU+lLF7mCgYBV?=
 =?us-ascii?Q?heDLZnnfU9L1p0txYJFPvn9dentKbWkAcHPRESGiCuhMJWFQI/gX2DShqQMr?=
 =?us-ascii?Q?ic8KE/wBS7+lksvN6KRazufmLtzZqjZ0FHqRqV4t9v/gLcQ0ImxqXO8SuuZs?=
 =?us-ascii?Q?G4tOx9372+fH2jR9YrxkHRquyPP+wsBm2KWA0O2eXRjrLFKpdlmRJAutVDMT?=
 =?us-ascii?Q?E8Vyn7zkcuIxSKtHpeSlkmZYkSk2xSLNLC+xwwfz1G1wcSUr9iOcTHDZHAkw?=
 =?us-ascii?Q?7kJzFqHN+CkANd0W+mYeJ8sxmxVfOt07aTXXeoBlavP7Wzw1Ma2bSwHaiu8n?=
 =?us-ascii?Q?YensieFXMyzxlvFznSK7TNmt4T2wSmHEhTlj8eYXmLBFACYUkF8q6K+sSnJo?=
 =?us-ascii?Q?QWYEjNMEQDkKUGaSxNcyEdvtfKOmT2140m8vbX+zufsNNvpzrow7IYt2W3O9?=
 =?us-ascii?Q?C1GVwhSMYQu1fj9I8ESzuf/ahf946a22v3jw7C0YVcFVUU/gT/km7n59jSHO?=
 =?us-ascii?Q?lxneX9aN60oC0JpXUvjeiqdrqKVRfTzjHQp1mDlsiGfLHMurIoC2lhIKQ16F?=
 =?us-ascii?Q?GflM0t3IY10i/zeuRCweYXoTaOlUoPyAtqYIgBweSmF0e9o7gMdo0M2Sqd1D?=
 =?us-ascii?Q?n/RSU+tdIOD52f0DqQLZrhBprwjbSzkb/BgSXpx9M2EWLNqKPNxGLTT6dbil?=
 =?us-ascii?Q?RLWGjgGN7sWocZmjS6BHqCdmOJDQrCiur/UUcZykFKQwwk0DUZAQojl6tJwY?=
 =?us-ascii?Q?pQUcq9+KN8hNbhtrKZE+C+B9eBtRr5XDfVXAdzFR6evEHougaPCv/k9tU04k?=
 =?us-ascii?Q?2nwGJfEhdBVO/qpRePxR2PtSv3YzXii48sH8pV1ma5Pq7gDJrlY8j7644FGo?=
 =?us-ascii?Q?Ko2u5sdbG3FvT/CgijArz7VWMY+a8mcOH9am3qrwQofUvgxjJwyeeddYOFnj?=
 =?us-ascii?Q?2N3Di40lrBqmdwMOhpAmCvEGtQTYdzTdmFU9oUP9poCf90kRDBrErnZBl+xy?=
 =?us-ascii?Q?aJ92QH5vZ+MHu8fp60rASyXBXyaHpj60etkKakptAyVYC3m7b7gKZ3foDutj?=
 =?us-ascii?Q?0yJF/q+Jcg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7a68a6-2d8c-488e-9955-08def19fbc88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 20:42:30.2337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6c0Pl0v3NIQmAsX3URsmjVCJTGwaHaHEEOGjD5PeCefkj6yf0pgYxtPuyDbTkVSHkfR+zXMHB19RXJg3weexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820

Hi Tejun,

On Sun, Aug 02, 2026 at 11:54:35AM -1000, Tejun Heo wrote:
> Hello,
> 
> v2: Changes from the sashiko AI review:
> 
>     - Declare scx_sched_all outside the CONFIG_EXT_SUB_SCHED block, the
>       definition is unconditional (0002).
> 
>     - Track the overload grace and usage-decay timestamps in jiffies_64 so
>       that 32-bit arithmetic on them can't wrap (0009).
> 
>     - Drop the now-unread always_enq_immed rodata mirror (0011).
> 
> v1: https://lore.kernel.org/r/20260801085150.2697653-1-tj@kernel.org
> 
> A sub-scheduler holds only the cids its parent granted and nothing
> guarantees that they cover its tasks' affinities. A task that can run on
> none of them currently has no good ending: the scheduler's insert is
> cap-rejected and reenqueued until the repeat limit ejects the scheduler, or
> the task stalls into the watchdog.
> 
> This series adds kernel-side rescue execution. A scheduler marks an insert
> that may be cap-rejected with SCX_ENQ_RESCUE and the kernel, instead of
> bouncing it, runs the task on the target cpu at a small configured
> bandwidth. A rescue starts out non-disruptive. Schedulers that hold caps on
> the cid largely stay in control of the cpu - a preemption cap, for example,
> still lets its holder preempt the rescuee. When a rescue goes unserved for
> too long, it escalates into protected execution.
> 
> When a cpu's rescue queue stays oversaturated past the overload threshold,
> the kernel ejects the sub-scheduler with the highest recent rescue
> consumption on that cpu instead of misblaming the waiter's owner.

With the updated patch 08/12 everything looks good to me.
For the whole series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
