Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9937C10C
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279627; cv=fail; b=Utyg5FL+m4/R4PZtjTU4yDmU7EZRODwKo3RCeK5lYMg/+8o06wbfzCxLQnnlsxDC0wv66lmXXZZ9veKNOVxbJjOUsUW/J+yAqdFdfb2BSMKVy3LLhZUYRkaW6agzcikRNmEkUph6CkVRvllL7yAUw4nBhB+UVjENMOGxW5aCqns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279627; c=relaxed/simple;
	bh=zY0teeK85MrttpRhyn8XDReRFECPaxvef0IMeiegEMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AO22T8hu7XJmU4bt8tvi2qRXIQEyru92AqcQb6ERj+rpL58DZmtz9sn/jZtSc5O/c0wsssAlUxS2zwOT7bE65/5lRdkXufxsjKspNUybGBb76Oab97SiCEjK4DOPIGqp5AofKTvPrV0dWmfC41m7j/U1gf2R1XIQcyAHarpdgfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CIM8Dyx2; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CIM8Dyx2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrLQ3RjJv2BS8XC2qx90Qr6sm9iZwc8/f/uOP7fyc+oZigHBGplxnfE/qM7QdSlcKxyucO64cY1+ZfHWVIRx6U7iTDCk3AUCwrO171v6pEAiFk0HHQwsPPZYx439K04SQkYKewEbPVtECs7VwEVts1j9IBA/IOOxuCA9SA6pZvBqpVDCbt6kodBScFNphkaobnZFyGsWdwi63thT1mnkfN5xaTrEwAk6On7jUMObnwtoMkrwWpnYyhAa3+Crg35xoAzrWgFwfSZng6GmW75Ro6d8Bn8uaByCBmxKkPCJF7SFe2eheY/V+zxPKYS8KhsaY2iZ7X2NCyHQ100nhWvEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBjr3HeBeHoTmxbRSNksSQwb2lxD8Sgv4Pksl3YRheM=;
 b=ah44QrB4lVrTf1GOLQ2RU4Lshxp5qqnh9nqIb5gmkAiQubVNbTlb6qX7r50IVaXRGesKxaT29ORHKW1Cmo1sK4lRDEuq2FQWOIoaUDuuBPCfI0+tliFMrr7b8N38goS4wWrq4JV9x0QeTiRWRaayiNqIl/Z9ohDnwvQV7kAiVR5MjJNzJg+gg7NbptYhxKrj5QP4tptjgkPxo66wQEX49vtSaj0jyzN5z32mhj07SJkJ0XcGj6zVUNo4zkRxtkXy4dciExFWX+cYJ3icQ1NGoN3fVJXmY5p0nBetbkPKKmNAs/G1WUhfTWkJtoVAOkv8VvoLoUKVVVwJCTw7VKZZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBjr3HeBeHoTmxbRSNksSQwb2lxD8Sgv4Pksl3YRheM=;
 b=CIM8Dyx2MzdZR/NLGUK/tJPyztNzJ0DOf6m7Guu54MBNYfmHqJRXGheFg6MikUj1Pwj9sxG1AvAEkz+6FA5DjpdtgWL78EM/cfNnyVCxlxCdInRvz7BdRnRjFI2VzKniaIA1P5rOfiGbkLzXpqcIT/yZLSA1HlNtDi8tmvHt2nIMSp97qHYi8HKYU1zSyL/oz9g6MigWJ7E+UOI/Ld0Rvb7V9Fab2mWGs1cdnpX5TdCd1XhjNr1heFtkAuhDC2lydK9uuAnFkgx5m71FpKIolVoDVv1S2e7TBWBA/kkD+OoTkqMLGti/UhMoh56bUWRXK9GoS1Zhf3wkQlkKcPEDhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:20:22 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:20:22 +0000
Date: Tue, 1 Sep 2026 18:20:09 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Michal Blaszczyk <michalblk@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Use atomic cpumask_clear_cpu in
 scx_idle_test_and_clear_cpu()
Message-ID: <apb7OapVwIDZV3D4@gpd4>
References: <20260901152212.1691696-1-michalblk@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901152212.1691696-1-michalblk@google.com>
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce51c43-b1e8-4597-65cf-08df0844ec28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	k4o/okR/N5t2tYl4OVc1pftjsJtkntnZz7bWSO67y4g6FxRydxyVMVfGl1aFYhcZVEhabhj5tyfbjueeCNgH0TJdzrNorLxQqDqAK6W5kBfmZllVfbK7rPhbbyKKk1aSrLB6H+49ynMxmwWU4eCqGzY2AGeJKrICXAXstJe7yY69OTT0dH8IFO2dVb3THZDPVCC8gE3PReYcrLp7cYIwSvMGIYCzFbJCyhKI6IG1mW2hwWNqWLljoaxu8pN4quUO8hG0rE8Sy7qfvdanI4kU9hNnH8EoISQyqSFEapLa2uDuMfEh7xG/gvoQVjVufVOQKya6NtyVC47998FqrK7IS21sIHNxlLrr5cduXXRA8l68YUOLgeuuqrPMEwYf+LZS8gkF9x1BI2zR9z7+siqWExziNjlILviiDzKFTznC82ql0MFwSDdSu+IerAutNTppXx+NK9Tc+dQ1Pp2AvahjX1WwnXGaA5mtkpdS1+MrBBcLqQnOyT40EYEzsHOZk0S6Rs20y/ojf+inaBNTvyS+eP8Lhtup55Ep5mfJ/fDAVvDu6W1UFz5rHjZKytf4JRjCGxi5W04d0HRzkbrPRqUTX/8s6bsFQPBhEU3IQtMXsm1semLfp88z0IAQKW/frLjDRdkT/oLWMUSSxXlHEC8NjHIFg6zBbfnmhol+KGXDZXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7qDTPijc2tMeqit9xsZpQhGDeLBs4vjKRDwGMzohaDnJ+Ne8pW7g9U2rZCS2?=
 =?us-ascii?Q?YV4VdUaLGRkg57hcI7hlOhWXMyuBb50OJyTM0H4eQVjEf7Mbz2qHGtpZo7S0?=
 =?us-ascii?Q?jAaDYsfTffwzBVatZWbl4Ra+q2CCn52XtWReAmAn9rIIzeB5GdHn6xiViRmH?=
 =?us-ascii?Q?3JkJ4Oz5CkCzdeh8MLJdgfH2I5FdqniwpdPDleJf+S/QY/B1BD0SbdEjj1kj?=
 =?us-ascii?Q?nmv/5S6h87a2iODVgqpVVkNorYSyPUl+56TeLlmb6zmtnSb1JnJf2xeQiK35?=
 =?us-ascii?Q?/egQkqfYYK842pLAv1LicamKwoEuqx5szr0Zd560ZvBVixZhOEQZ5E7smY/L?=
 =?us-ascii?Q?86zcB6drtD/TE/Rrr1I5Uf95Wd5oXCfEXk9JK9NXBcSBxobu1nODpYwqKlez?=
 =?us-ascii?Q?o4b4CiVN8MnB3CPr4cvFZ94aR6pDYrzmB8ku+qWPtdWQ0E1662uZzvTDxXPR?=
 =?us-ascii?Q?6rik72p6FQtZi2/WMdyJ8eZOO/nxXPwax6k3QJRLk90sGgkGJAThipExbmUO?=
 =?us-ascii?Q?oD4AanmCYoHu2p8PVpbXZcCkUOZgc8Sbx8O4SM0ehfOYTZT1vZ12OtYdK7yh?=
 =?us-ascii?Q?QSl5hqYNhKONEh23WINu2+w3WsLkFpPZlltF3nsWtadqFOYugzuHExZKkPyl?=
 =?us-ascii?Q?J4k1zVgJUVSqRxQKrDM8HMH5iOjRhwAlIOLtkzwYu0zb6Fz9iG49Bs52a5mH?=
 =?us-ascii?Q?eoK4rqNdvAoCsKN1OMYo9ZkHCSHjv3fBW9KwTNW9N/gC/zY0z5wruVmg/RqL?=
 =?us-ascii?Q?HDOr+rOY0D1y/XMKpa+BgYf93xJJfpG9RpbXtJmakEBAOYkWAF0Yfy7SYym1?=
 =?us-ascii?Q?iH60Bl5jMp2LwJW5+BcxaAg7VDJJByLtLxzVZdiobnmntwojJwy5ILxOYgE4?=
 =?us-ascii?Q?YBz7BrEnQlE9zUdHU3KFTctzdYecDY46KOYGNQxabsYm8h7ElJbbQftA4ndI?=
 =?us-ascii?Q?l6olWeSIY/9ofgKE0BBTxMTcxpydOQeP+6bRiULi00blhZ8XXDNihNCYY8eA?=
 =?us-ascii?Q?QFa239YTh/mz9HafN/DI89cGzzNDiufVPpxhAZ88KjP8/Mugs2OLzwCw/qum?=
 =?us-ascii?Q?8nwVWPR7h6dWY6DlGaQFeRB+O+cfF6P54sLRCpQcrQ/1uPYID2emYt4gi0H0?=
 =?us-ascii?Q?ytcpnv6aE1kd0AHVBB5Dn2pV59ldbloovFb7SPwnnTgSbRXiBaxPonG3659G?=
 =?us-ascii?Q?kcIWHH4lrL6ZpzMQXS6kEBGVx18ojfCmVpXrwwpXdrcqS4hHI+H3eu3wJPpv?=
 =?us-ascii?Q?MLJQFtxV3aXyuf/oaKh8JYmeZHqa2qBtV28E10UONrM538sC9eDxdQuHruJi?=
 =?us-ascii?Q?MwefEDfgb1IYdqg1TSkjteXc4sQC7SBGNUk7p4Ykl6Ul0DkQ8Cw9/nAdL84c?=
 =?us-ascii?Q?XcUwhIPaXWw2YiZtfOlSSr1HTexgZqGjb+VduplfbWZhTHeMK+meqG38fMcJ?=
 =?us-ascii?Q?3EPeC+5jZe94UcqIc3DDxuFO0gtl3JrwaoWBfdEkEi95uw38mdgvfpUSFiua?=
 =?us-ascii?Q?8q3b6MIdWUtIqQFBtajLzpKMqshxLMUm5H54wR+bZWoNefLeu+LS8/as6Hei?=
 =?us-ascii?Q?DWAEn1Zm/PIKz7X33nhjc4qCe8qezliH+dfk89PcutXjMuAhnqhIu+rhWnNv?=
 =?us-ascii?Q?w9vrayuzQD5nm2vE+VyBY+Y5dBBCh2wx+QPG6LKURi9PpM/ts9jfBuLB1JK0?=
 =?us-ascii?Q?A047o9XHMhlYEKJAGhJs8Ia3h+iwNj/rh6JEo5ZRCR9KJWUUcHEJtdkkAzHZ?=
 =?us-ascii?Q?sHHXHtG+8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce51c43-b1e8-4597-65cf-08df0844ec28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:20:22.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H39P5djbgHe2ZXsixAd6W5TD8Ns6CMIoNhTekGWk9vkZ0us57Eg8FYuyOMsqjhPjhZhteINbjbT9C8s1J4dgLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759

Hi Michal,

On Tue, Sep 01, 2026 at 03:22:12PM +0000, Michal Blaszczyk wrote:
> In scx_idle_test_and_clear_cpu(), the shared idle_smts mask is modified
> locklessly by concurrent CPUs. Currently, the code uses
> __cpumask_clear_cpu() to clear a CPU from the mask. Because this is
> a non-atomic read-modify-write operation, concurrent modifications to
> different bits within the same memory word can lead to data races and
> lost updates.
> 
> Fix this by replacing __cpumask_clear_cpu() with the atomic
> cpumask_clear_cpu().

I think the atomic clear makes sense here, but, as sashiko also pointed out, it
does not fully address the race, because idle_smts is also modified by the
non-atomic cpumask_andnot() below and cpumask_or() in update_builtin_idle().

> 
> Fixes: 48849271e661 ("sched_ext: idle: Per-node idle cpumasks")

And the race existed way before this commit, the idle SMT tracking has been
always documented as racy and self-correcting.

This change may still be a best-effort improvement, but the commit message
should describe it in this way. Did you notice any improvements/benefits with
some workloads with this patch applied?

Thanks,
-Andrea

> Signed-off-by: Michal Blaszczyk <michalblk@google.com>
> ---
>  kernel/sched/ext/idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index d2973fb3af6d..8985b48c83a5 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c
> @@ -104,7 +104,7 @@ static bool scx_idle_test_and_clear_cpu(int cpu)
>  		if (cpumask_intersects(smt, idle_smts))
>  			cpumask_andnot(idle_smts, idle_smts, smt);
>  		else if (cpumask_test_cpu(cpu, idle_smts))
> -			__cpumask_clear_cpu(cpu, idle_smts);
> +			cpumask_clear_cpu(cpu, idle_smts);
>  	}
>  
>  	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
> -- 
> 2.55.0.897.gb25b4bd76c-goog
> 
