Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B534DCEB
	for <sched-ext@lists.linux.dev>; Thu,  4 Jun 2026 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553936; cv=fail; b=Xf4slVAUwfQaPUXWsn3ES/3gLTbidGjdIk5da+3w8xWVVZneqiveHRZooWT+/lp2LL522a0F7FI3BmGAsr3RbR70TJmFHtRVKQP4K2x1mMQ7UfbWbj4au8Fwu9JzXBCDnIBf7Ev0e+dzW8FniZGFqKszdOQcMrL3LvqrDNipeOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553936; c=relaxed/simple;
	bh=mt2jdd7tOIAknkXi0npgEQwCj2/rtZ1qHgnwlov8YYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dUX0DSUiMWfh0ETlFoUlnLgklwbLZQGugO7/0RcxbzjoVg4/NcPuVN8E0m62VME4w6I/E1Dl+ZTUcj8wBBmgN7dtFV+dxxfSiJAoE016cjnx1t8kz3TpX1z3nQIYXh5QAwUYGM8TDhBZTucGJfZLnUyCTqHhsrYaPZewo5vkyYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N4JYFIU1; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N4JYFIU1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxIgpNIWLbLhEBVXiyk/q8OOs8NRUPdDgiz6ItUICeoy246VS32tE+oLZ2cdqJkdeXdjyiZw45lkXFMtuMrwnFT2H/W/cJeNZTcD0WxjFLi8+Q60POmS0aAzamf21ztsI3RcuiwhSQuO4duWtb4CBNi6TBrddTI4X1tdnewZEGy/+KzXWvZ+iji4+61Kjzlu6aT+rrTzVCq3SicHPIgzOFstSPbPaYr4eLufgatKkGMhhYbCY/MhoDVDbpFvH7H8hR4gAMstiOzL4sajFf8CZYkhj7Bw2trBUM3jGJV9TJ+jg8YP1LJlRv4QdmyI1CB+4Oy3ogReUxN2YhFKV+JdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njnN+FDNZWEr/qF12PYvqdtqCnxfCQkYx6WeMdueHQU=;
 b=C+gMh9XSkqt70yrK91bQ2eSbPihDShpu8pszOUvNcxnr00FjXrbyaTTt63RitX5NO/TYNIN6719dPZj1Ag/SCh7GltcfTWTC/Ewqzm+zgv0tLgeMTnLLqEoWPoHfM0gJ+KAu2uciXAm2AA00Nhchx+hctJTVIs4t64gervQzuIjPD8TkSx9RYOJbFGWq8a15RsLXoPg7p84Zu1oZa7ipZNV8qPOjNn1Iuo2f8ZbBRjzZgTIY8Sy8XAr9XHlWle4eW13fGg6hXqfPLaxBRdjAsT5a/Akrr5IgtAfEm5X47aacMiEtr3YNUXqijYHciDtLyiQiKWURnK54S+QspYTR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njnN+FDNZWEr/qF12PYvqdtqCnxfCQkYx6WeMdueHQU=;
 b=N4JYFIU1BYPvWT2ztWAnVHmSFlNYc/oJx4NC6d3QOozSyR1SnKw7L4Gs05wcJHB9IXetMQhZDSI16AQosF4W15cX3+KoOzvn4s+PCC78Br6UgIUFMu0G/gLALCM1gurBoR6v2TJ1vYiTrpXW0VVtw6CBybDbdQLFh+4CfFqdUHxZriJS9fjhYHHNEt9oGVrW1BS0R5kT3qqkmJZ3c5jHsajpDyHYI6ekzodaNhHspG9aTWmF3jDZchk4aRSxl4ukpEDK2bu/p4KMYaOz96+KlbUvyPxZ6iOqbc3pEwp/MFjOUc6a98qZ9ux+tlknCw/q26FYQBOT1DbSWKAQy4Q5Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 06:18:50 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 06:18:50 +0000
Date: Thu, 4 Jun 2026 08:18:41 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.2] sched_ext: cid/cmask interface
 prep
Message-ID: <aiEYwXRzuNe_CF5q@gpd4>
References: <20260604020032.3536466-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604020032.3536466-1-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0160.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a828d91-e36e-45e2-6ea6-08dec2012489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|6133799003|22082099003|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	d5zVQaGK9UH/02LuAtFKI1V2tsfD9PLHzi8US7mZXav1t+arcOYzUZ5JFxFRXloGRAWc36QTWul2WEK3lFK88xP6mJdEX+xJZ/hDX5BeuZfBCRMjPqx5gdP13WdEMrAfHOLAwLIAK/AZtulOLARUPgfJIxC3mxrYljXmCCaBjXScVsbT4hLt9F7yyLj+YeSHe//l+bm+YmjPnY+9n2a1Bh/NZBTpbO5CA0r/ED0rGNtWtKfyRSxDWuOoJJMyZyAxVKKa8pd+aZM3lD1gk8sKzJsKvrmL27C5iXQccc3IuZLAFEqqVzdwW9uF8OscCH7mn/QL4i9/hxKwbUAD5VIb1bi0nmg1u/gpf27hVsabbEMguPFEWaCcVble+WL43ItaaetkuiJsWE4VlcAh9Sbq9602q7w9bVIy7+Jt15nJJlwhWQzjf5a7CtZ+8Wfo3HGIBfAk3OoPvCQpHR4xIVkqJAbNH6fu/Lb89Y8x27GLJo7+LTPN8FUj4D9dSpUC/h3v4kdUqM0AXd3lqH6xgTHNgntVPQLihWxqEmZIOtmIJVeE0X+dkLdZvie8FweMnk6wVTvDc35ad/6OIhaNv3xmS0VO3J89d6pj+sXPXw97X5WsRNQG8RHqCBQiDMdupXxzimCkMiOiu93xRLbL7EllGIy5HOoteGNGjdKj8Y3uwDlGHsRzRGB1GkPsBKKPwOtGVhTbTatpvSPT/dguiuMrpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HP4zpjgqPLk7avlscVCo/h2YLXv3K6PVf3sJnLEMY0o++W5+JehBUuuxPiP8?=
 =?us-ascii?Q?+njfGJWrm2QZlfIHnykK/dDOragRLXiSwgUSHGI+gYeMYHL1ZBjo6j8h+t3j?=
 =?us-ascii?Q?giSobFCtNpiWZ9a9ORKDLlzIMfqPoNW8e4dDM6cfxVmsFeKlWYMJX3LYnUOE?=
 =?us-ascii?Q?HVphh+DTHAB22VzKi+SqGQKp/NJ71oorF2FJtNcrnZKgI5S8V9as3xGDz+Yr?=
 =?us-ascii?Q?n6hTNaY0yiAmneSwcQKo86S7oGTz2qDf4bbAYJzvQ+ZccxzS/itM0XW4BTFc?=
 =?us-ascii?Q?U8PMEsoB+jwO5Res9VErE0WbAlbdVH/O5WuezRhPc+Hboqd+7fo5lz8hOr5T?=
 =?us-ascii?Q?Zqrp58jWM0Dbgn3RaDagX+qSNE25K2Y89MsQnOe46m6SuuQ3yoK9Xnko1D+J?=
 =?us-ascii?Q?VFtjXyaymVeFUm6fSjxYfP+45tq7g8xCANXN3mhcMqD9flbu3v4mC1qtTogN?=
 =?us-ascii?Q?aDCkL/5kxGQWxesATtJ47nE9f06Li9DSmsVZCr7fHvSNRYsI/hLnWKTeI8DE?=
 =?us-ascii?Q?ETJt/eyRn3+yW7fYdlH7REsNuLTS6yoOOQ2Yg+aSMYpC3C1KlT9S5oZpqsux?=
 =?us-ascii?Q?yrFLP7t5EpUbQ3L/3OgDkZy38lgAHbbE/i8AF7Pnc35VhkMOwZkQR6Q9Fh0E?=
 =?us-ascii?Q?fEozTkN99jAKmDhC1ikkRnps3lpGUYuzkIvMwNHvDVrGByWz0AVzUpaisW9Q?=
 =?us-ascii?Q?3J0GDdbrXsMz+7BaCQFZQYyBWOn9fc0db3A0Ea7OUs1e49Ly7H+HSFeMqdxS?=
 =?us-ascii?Q?ikpcvpJFjGQBBAa9uWlPZJ/0Gu0o3c1JJW4r5/xAhZ7HG+k1eApAkeX7MnMh?=
 =?us-ascii?Q?iyIMLg/2f5NsSQ4ToHogQ0EVy7pw67wL5NfawhdE7+btWvpI+yfpOnByXN2o?=
 =?us-ascii?Q?FKHfflle5cKEw3mr9DxmcWWRUcPX/hG/jEIhDDOuZE7o7BbCAv03GqODA0PY?=
 =?us-ascii?Q?oh4dnJ3GUJO6vzRx6Ho1IL+D78Z0DD5FZTgsk3ENpTtWyQXzGucyKZ8/y2IY?=
 =?us-ascii?Q?lGydSlb+YWeWCeyLxQ77cxleTPE2Ip7AsViyGc7JKXVUxWGShbkmw+NEsa2j?=
 =?us-ascii?Q?3bhSCNX7UtpjagMKi7IKBi7HlLiZScZ07pIuWhCamZVFdmdiBH34UXoL0wBf?=
 =?us-ascii?Q?KuJDBuhuajRekJYbYzorEQGOvdcSEwZ5Zm7cPbNSxALB2eModqYI/q78H5T3?=
 =?us-ascii?Q?DpN4o+opwaertKcdZEJaZr+cyO8Z3aE+lUbKclm8sJGudm2GuAAAwHVLYScY?=
 =?us-ascii?Q?qwrNmWO31PB05GepSI+Ueo7MW5GcUG3zx4wm+/anOTe06Dj8nG1NtY8D2fe1?=
 =?us-ascii?Q?81FbK74xX1d2dS2iHRNRSmxLJpOTf3AcIPuG2K6MXYJvOZVlI69PRAqowp8U?=
 =?us-ascii?Q?op4V3NFTDvu9zzc/wySev6rT929shvJ8ZyyC6CsfshFzmoHPHPUaBXS4MSqZ?=
 =?us-ascii?Q?6dRXn+uwKiZVr51LUNpFF1Rs0Qedv1n92F1Y1m6Ns4+VCp+H70svrOwvD9Pn?=
 =?us-ascii?Q?rlZU+HUrYSH+/jlEm0Hv02DEbWor5pPGfACMT2Xn3v4xM9UCmynlOw+EA8pF?=
 =?us-ascii?Q?Uowh/Ae4x9oBXGIx/hQYWVxWKWmgkmsmOhvcXjPpr9Av0j70hNIncRQW959p?=
 =?us-ascii?Q?8vEH1J6dVSxP5dTV3IgzYYbX0e88yeLe1YiJWQelbrveXhRgpKPj77WPXovI?=
 =?us-ascii?Q?waSttQVjAY+DZ7Psb6IwsQu/j1XLV9SBGj1+fjrteQeemCar?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a828d91-e36e-45e2-6ea6-08dec2012489
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 06:18:49.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCc8ti2C2SJahL4e4ZkdRjPxj7NRIs89aLIBJTAOMCtyKDhlVApT7dkdDeOie8gR8MHuNFVMVuwkyl7Rj6A+UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

Hi Tejun,

On Wed, Jun 03, 2026 at 04:00:28PM -1000, Tejun Heo wrote:
> Hello,
> 
> v2:
> - New patch 2 reorders the BPF-side cmask helpers (cid.bpf.h) and their
>   callers to (cid, mask) so the kernel and BPF interfaces match.
> - Bound scx_cmask_for_each_cid() to the active range so a stale word past
>   it can't yield a phantom cid (sashiko AI).
> - scx_bpf_kick_cid() returns scx_cid_to_cpu()'s errno instead of -EINVAL
>   (Andrea).
> 
> v1: https://lore.kernel.org/r/20260603172153.3081861-1-tj@kernel.org
> 
> Preparatory changes to the cid/cmask interface that landed in for-7.2 this
> cycle - a single-cid helper-argument reorder on the kernel and BPF sides,
> two new helpers, and a kfunc return-type change. Posting ahead of the merge
> window, in particular the scx_bpf_kick_cid() return-type change in patch 4 -
> it changes a kfunc's signature and is cleaner to settle before 7.2 ships.
> 
> - Patch 1 reorders the single-cid cmask helpers to (cid, mask), matching the
>   kernel's index-first bit and cpumask predicates.
> - Patch 2 reorders the BPF-side counterparts in cid.bpf.h the same way.
> - Patch 3 adds scx_cmask_test() and scx_cmask_for_each_cid().
> - Patch 4 switches scx_bpf_kick_cid() from void to s32 so future cap
>   enforcement can surface failures. The cid interface has no external users
>   yet, so the ABI change is safe now.
> 
> These are extracted from the in-development sub-scheduler series. Nothing
> here depends on the rest of that work.

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
