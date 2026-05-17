Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7E3D091B
	for <sched-ext@lists.linux.dev>; Sun, 17 May 2026 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043668; cv=fail; b=kbGBV04rTZnE5w+FShmi77HvLr9DoG40wvGz9jg24E/0hsBKptzjeZQ6Lgz1jLqfoeO0gAW8fQO2wtYDqxH60qHeDE3dQHmpk5OVLs65zkN2C5DXfgLS9LvQcKGO+fPTIjfdGbh4AUS8S7mLVxHX40hL/rTtDAb92+vtQvMb0Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043668; c=relaxed/simple;
	bh=kMoIwMWa72X62jtjh6RCmHiowDInsgTV+H4SNr6KmjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NcQy7elrCyGnKYGVE7DCi7hlzNg9JpYwfm1LvFwwvr31C3FD50GPJB3FovW0DOTPMdPGJtMVtOK8ykcpOmK5gTmxVg6/+LmaJc2Tzmn8rFSraNiasdW/UQzXawDTepIzHLPkt6RHgymnW28yky1S/H4aNMC6/RCdefxGUG2DE1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LdgCCO4F; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LdgCCO4F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAVokHABTuFLLkrcV5mnXM7i+PVO8ted+NviXX1DbvElablU6TfEkTobDwtz6b+iIbVvdfzh+Q6HcgTgBdl72euZdf4VSusgqn019M4fPsrgx8VzcL4Mv9G2EiaxdI/lGgOLwbvOXdLzf3pWB1fSTBeBRgmf19Ap/B3UomjBxbXMOntO3OQ6ZdhdfZV9zGi6Orj6CLeCltnj6LrHEqQsRnohps5sgdKTAkcJVSi0fZZkFjnqdFhT2WWWrOGXOL1Iz4WXsj5vXK3pu71BmEjbKUweXqVejfJPT9IeFDndcbduDVJyzAZ1kIhkV7NfbB2n1bh68uOJOLBgxkk1dTghhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pU+xovFf5/ZyvFu3JOeRvTysIM7z90vSRWjGFiPgnc=;
 b=HHfsh5hW3cu8s4BMjZf54XxLRa8CQL0Q7/z6IxDtP239I2FKsx8LMZjKCJsZ0BuFRWH69fxcnfvmk22DK2eH5vtVnE+hnGXzhHyadzYT1SfNUe6QnNpJd4sKWbpNegbJgUDReWw62OipZlhwKo3lneNASSiVz9UeqG/f8SWVTaJmuXkOO51vIsspR3oye+GHstmTjoIC4spXlzGTkhmdY6YC9kaKp7DO0ogguDdxDDedizOQsqdhqLCsuTDozKWuryabGwBK5eQrHbag4qymeKThafolgUHi3thcczfN1z0HkCLYHXaTph3J6ztPcf5duyM7z1lJmACWI3zs+S6A7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pU+xovFf5/ZyvFu3JOeRvTysIM7z90vSRWjGFiPgnc=;
 b=LdgCCO4FuabcuGjYdE4OkxzO7BntvG7tJXF7u0eSlTRSiLNQT/Jql65RXaiILQpdlMWq4ZgjAr40Y7S+1XTG2S2eL8VxGBVWnyQRAwSp0nTZlv6LBkHIQpKB0I9PvejpeWe1yEQijO1ydqzZ12TgC6OUIYbM64ogmvnt4A6SVuFRJ+zR5CulexkCxem4jtP/w8oZX14Uax1sq76knJCsW4w+wDXLQjM6+sLc5NOfBmUSGfs/DoOpmWZtnzG+fyGhNLiiz21iXSEwIoA1+5o55LfCEsOvhV8OXHIPg0MgPRZ2jLLWwQ8sFVvHiRnzXXBVlJ3F/wGq3Vs03DlkqGQDwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Sun, 17 May
 2026 18:47:41 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.20.9913.009; Sun, 17 May 2026
 18:47:41 +0000
Date: Sun, 17 May 2026 20:47:31 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix deadlock
 between scx_root_disable() and concurrent forks
Message-ID: <agoNQ7cKgkX1pWmo@gpd4>
References: <39ab37b4e79c6e5361a907c06ab27e72@kernel.org>
 <362a365eb559003ed21c6dac12d92c5d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <362a365eb559003ed21c6dac12d92c5d@kernel.org>
X-ClientProxiedBy: MI3PEPF00004E99.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::449) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 902ed542-f2df-4648-1cc4-08deb444c640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	kdXAO9hPDMiVdPaTy+brv8yu2ljrfN+NmzJmi5FjCx01tj2oI4GMbqaZxURrwvkqtg0ZvZl+TSbmotB/DgpzAwMKdHgM8Sst6Frvw/QiDhJm0jDN+gwttgyyqvnMMxgKiwQ+5/m72XAiAg3frLcVoo4+m+AOfUA39SgjSHK9gfw8CLA4KdINtmF5qX9M9CsUGAa1YXi+duh7aWRez+FAJARx9/KR4xh/GL/j8pcey6Vbqp5P7hNdpOJbsFVipjVyIzZLWkqYe818ZZUyO6jfgN/P/D7tInWQ+t0YnS/eUxeTPkwuR0T2SnZgQ6SS+A3QAt21ebWclfyEsazsuoOxdhEi0W2kzO0MLZYwRB3ICvMuYzCqEyY5Zu9AbEbORW32XGFX2JrEE/5aS2jgr9oP7h/rmTKEqrPQHXeXTrUa3O8R8ci/4kauZbWZOVxBwTJuOK3wcc7QZFtZ7snCxteXTVFM25Bd6+hX4k+pvn8j7xaMu3weRaNroVUQ3GmKb8AlOQsjRZMZSjjiWIiQ3HrGvRBKlbb2+avaYbqZjQkBC1KvEreE9RGy2uaOfVmROe5zHUIjCYCcHGHGuPi4ouBA8WMW4eSz5i6mFCOB7q75vzqUO44S7L0jR6416Bw29DZVpqTxLSA24qA75uYgF13dXFxLyrqfNSRESWZdL5ejAnC8tGTf5JNtmBASw0j7qYEj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Pw1d+sbrw8mh1LyCF81JT6+/kuzZIFnmGipoT8lO/4UO2kclk3tUz0Bv1QJ?=
 =?us-ascii?Q?QesYuLEY6Y5xMj/Td+WtsRfr6r0Gt5v+sYfI+jsHeIAxXPsMhbjIWeDKcnUm?=
 =?us-ascii?Q?kjAxARu7Ihd7yVKQdEyZnsOlSvJe1S+hHtPvDpITcB4k1C9+c9CroL2B4Ys/?=
 =?us-ascii?Q?DoV+btYaNFjhJTGB2SnKu5w3V+jQ7vVWJigealSKlTl6XGTSCqM3otrIqjMU?=
 =?us-ascii?Q?Hy8uDJ8UKQTaWzR9CR/DThqEzlmdbkWP+qdiWWJPoJUYJ14iyQYrlnGUf9Mf?=
 =?us-ascii?Q?Ncj5RBqKhgRWeEye1bEqLW/LhitKoaCSxbhuxhjzEHSjjqFl0YL9NajP3LR/?=
 =?us-ascii?Q?+BPSFTHMVcQ6Exe9q4/U4dzU2uLIzN7VPcOybeJCU8KQ9NFYkQvk51aNd1zv?=
 =?us-ascii?Q?HcZlxP/r1Ne28BC7gvGcer5nhM8eHGKKUoe2EhkThDzLgHXGNholyL5JQHh3?=
 =?us-ascii?Q?5+PYcTy4y3k2HtFfGJ6ZN5T3R/9Fe4o6q7Pxnxm0qoF1xbkEZ+qxlXFk3e8S?=
 =?us-ascii?Q?7YM1Na+3F0AeZ3mPbA+k7k4hlLnjusz4iMdEJwJrigAzqcXE2MMiWnUFw7if?=
 =?us-ascii?Q?ArcEXpPlsV83RTYIoXsTwYy1TnP08mAmAh5xIMoH+h/wtx0TgeHj5rkZw4TA?=
 =?us-ascii?Q?Au7+HF1U40V5UP06HJinEQZepEiVY1647mnZptS6CvK7fr9DK8BaDEB7dyP1?=
 =?us-ascii?Q?UO7gqsU3+kz4iUjRr3ugERXjrN5H/+1eowIR8UH6+c9Jy++qiYxdSYcI6ygJ?=
 =?us-ascii?Q?ee6oGhwCSACwgg++yPuQ22bsPzuRXMOFMReyp0hOd6hGOQzt+29/WVk+8l7K?=
 =?us-ascii?Q?0TkTYqp1oz/QW+FaCMZNrGih9xQNKCWEwzibNuskmebquCsGavPJTdxUHo+w?=
 =?us-ascii?Q?KMeyAH50WwWyNbJ9RIp7vT3MHQXIGmKox7WnOdB7AjMpdKOx2wSTUKFm8JS4?=
 =?us-ascii?Q?+tHp1JuW/LjNyu1Fue2ISAJZCXh5TxEXhIhe5rzt5Mx7g1t1Zw8ASqQWTpTL?=
 =?us-ascii?Q?ZaN2jxqxk+B7aweYR9Vzcw/zyMX6fzB5N/Vemah7mH5b2JhOssh6OOZKe3hg?=
 =?us-ascii?Q?qHoV8Cg+0qqmuCVRcNI8VxuYGRKxVtKJxTMe3q2yiMPgdw6m+aVsTX0ZzSDX?=
 =?us-ascii?Q?Pqs35E9Px++hl2C2UIDfOZ0ijC/ZUJEIeYPxiZCle2+tbkXYCVUMWavWtkEo?=
 =?us-ascii?Q?8pOggzWlcfTrQ82Xt3kLlI+/2TohZmcXRoP76cCnp9LywOAsRa9fjvVzgVUd?=
 =?us-ascii?Q?Fuu1ERPOpZxgwvPpPfyl9Ybsulma9RCDKJYGPvFkjSVe9pOOSRop3eLGOs3g?=
 =?us-ascii?Q?YN9y+P5ujssQFrYLrspbT/270fga52jy68aHQcV7YlqVD9PXHDxfcL5z68Hx?=
 =?us-ascii?Q?BywgQ7j5iM3FtbbeVPg5HOQMd7KcdLTdFkrt44Gq7UPBVJg7P1IkQl8qsMcA?=
 =?us-ascii?Q?rP1uWTd+ydmQ9DTNsVW7sBP0+aiAem+Qo3CIUCZ/g1Yq7NVtazl5/5guHs7u?=
 =?us-ascii?Q?StynsWfLBGYrv5BDjyjjrV+X8ynSLAG39k5mfgf5gWJLx7F1yrrOxMwQYJvi?=
 =?us-ascii?Q?eoc7iYOrS382ZI5EZYtVlwbQ0Suph98czsc4pXu3xkn7zaJnhGwAn5wqOZJU?=
 =?us-ascii?Q?9WAJIadqTCdjFiDwK6SUH9XWmavVUkMqKJPl/b4N0gLWxXXR+zmTZBx5XTzJ?=
 =?us-ascii?Q?d2ZZELxOWD7nxfmVS5U8Rj+0wFMil9P48zRVaOtSpAwRLlDE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902ed542-f2df-4648-1cc4-08deb444c640
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 18:47:41.1441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qV5VrdZXbsl8TcPcgLwXT46Qkrz4czffvyd+d2TALTKTezfiCYD7JK8DiaHPbB4DL4hjFLzT1wOzuutLSXkTSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

Hi Tejun,

On Sun, May 17, 2026 at 07:43:16AM -1000, Tejun Heo wrote:
> scx_root_disable() enters SCX_DISABLING before it grabs scx_enable_mutex to
> clear __scx_switched_all and scx_switching_all. task_should_scx() short-circuits on DISABLING,
> so forks in that window land on fair while next_active_class() still skips
> fair - the new tasks stall.
> 
> This can deadlock the disable path itself: scx_alloc_and_add_sched() runs
> under scx_enable_mutex and creates a helper kthread; if that new kthread is
> one of the stalled fair tasks, the mutex holder waits forever and
> scx_root_disable() can never make progress. Only sub-sched support exposes
> this, since sub-sched enables are the only path where
> scx_alloc_and_add_sched() can race the root's disable.
> 
> Move the DISABLING check after @scx_switching_all. @scx_switching_all
> serves as a proxy for __scx_switched_all, so while it's set, forks keep
> going to scx. Once cleared, DISABLING applies normally.
> 
> v2: Reword in-source comment and description. (Andrea)
> 
> Fixes: 337ec00b1d9c ("sched_ext: Implement cgroup sub-sched enabling and disabling")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5092,10 +5092,30 @@ static const struct kset_uevent_ops scx_
>   */
>  bool task_should_scx(int policy)
>  {
> -	if (!scx_enabled() || unlikely(scx_enable_state() == SCX_DISABLING))
> +	/* if disabled, nothing should be on it */
> +	if (!scx_enabled())
>  		return false;
> +
> +	/* scx is taking over all SCHED_OTHER and SCHED_EXT tasks */
>  	if (READ_ONCE(scx_switching_all))
>  		return true;
> +
> +	/*
> +	 * scx is tearing down - keep new SCHED_EXT tasks out.
> +	 *
> +	 * Must come after scx_switching_all test, which serves as a proxy
> +	 * for __scx_switched_all. While __scx_switched_all is set, we must
> +	 * return true via the branch above: a fork routed to fair would
> +	 * stall because next_active_class() skips fair.
> +	 *
> +	 * This can develop into a deadlock - scx holds scx_enable_mutex across
> +	 * kthread_create() in scx_alloc_and_add_sched(); if the new kthread is
> +	 * the stalled task, the disable path can never grab the mutex to clear
> +	 * scx_switching_all.
> +	 */

Yeah, this is much better than my comment (that was quite confusing).

To make sure I understand: what fixes the deadlock is checking scx_switching_all
before DISABLING in task_should_scx(), because in this way the sched_ext_helper
kthread goes to scx (not fair), runs, the enable path completes, releases the
mutex and the disable path moves forward.

When I wrote my comment I was looking at the ordering of [__]scx_switched_all in
scx_root_disable():

  static_branch_disable(&__scx_switched_all);
  WRITE_ONCE(scx_switching_all, false);

And I was wondering, if we invert those we'd have a similar issue: a small
window where __scx_switched_all == ON and scx_switching_all == false. But the
current order is already the safe one, so no change needed.

Thanks,
-Andrea

> +	if (unlikely(scx_enable_state() == SCX_DISABLING))
> +		return false;
> +
>  	return policy == SCHED_EXT;
>  }
> 
