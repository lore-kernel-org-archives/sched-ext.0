Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F17A3358D6
	for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878658; cv=fail; b=c7V0oWYN+at4H6WuSVGenE3XnBt0aZSSfAOMtRcr3KvEvsMVgIGnzO4+M/kFHmsDbkJh6C2V2C8R4EEIIw/dTH//2MPhEF4SVpHxS3abwVgJ30BKOA0NvTYgWVC0tvJIWCAoreX2BPmitm2Ill2ujtGvQel3zCypqg/o+1EhCbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878658; c=relaxed/simple;
	bh=3ulmCuu1E8VNLkqnshb0VGiIpRr2Sg8B4AIF+8lASrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EQOBXxmlIJWi51oMwbpSJua6tY11DBBfacNNvsD2BitwYN0qcsBynZ9VNMTi7Ue7xkMCKixqLxI5+kIjfRRd8dWzv6kZ79IfzikCNyLeYHyIcyZ1GO+6A/IZi8pb36VS2xrIijcrYJ04xn/nbtq4UlSr5/sw5j36mouOG/sKROE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FFKyiX2z; arc=fail smtp.client-ip=52.101.48.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FFKyiX2z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W//z537DdSCq3DFsEubOzhJT7jT0TSvcybBbhAdSzvsTqAdWbLQ9sbJ6xCp25FjrocFLlbO8hkUNMxJGN8IxjT+XJpeID86WfMHrYm2vCUQ0Bbw7skJtaBx0okG8E1iA7RYVB8iBy1AaaLvxspfdoT9yPzD/QrpKbRzmn1WNRedl1YimBY/3vjO0Ge3xMkFJIDo0C5ahs6IUP4GLC8xNQvhQaPlk9SaFc3srlfbgTCHNzDdfp+ebEMqJaW5xzHzwinXnxELE/ZowfgIgpaiAsyZ+3FdIv+nBr8LE7jwk5cPyIkROGEezFivei3Dy/Q1CS/BYwnPtXNV11x6I5meheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO1IaH3PAty+HUaHa3THuh/HVRt0JvTWbMFw1tDf6jM=;
 b=oCxr+6xRHcMazIvQoXWwfu2Be7oopcJYHfazh0bFkzwgOgIqYvQefpcPSaqymv+NYIy4KP4pWe8jmq/XEqwSgDa92uE9zVt+KXRJ516WzrDydKOTdFLbkjVMQ8Os8JyDvn+a7ndFzcsiOTVS8Gg0Z/lFAvE1nNBMug5hMFQ1sRQEM00NjYhRSgakYXXH+BaxxJ4eStbBOCtZPHM+LICUVQcvLztDVRQ+ATPS+Pk26OmBjBeJHjHzBSORu3XrVbC+68P/goD7i2Tk1GbRkAcCipHA30iFZPNHzvBCQMbCfoWPg7fpRHONGiBQmKNr0/2aB/b6em78nD9LxjKC/SApgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO1IaH3PAty+HUaHa3THuh/HVRt0JvTWbMFw1tDf6jM=;
 b=FFKyiX2zvpsbP++ezRvsXFDiDev0rmodJN9mugL5usLVQmH1PBJgDCiM2YY71vZ/JJ+J29p+UovTznQsPenD/Xq3v5vVSZ2hMiFucFUJgCTrl9Zyidn5+G2bWmWDmvsQFE8i0Va8lB3E+EpB4yan7md1+MLcsq1DltlpJ8W6lfEZmcWrWGT/slu9erGAVIS78NXYFKbH4iw9gkAeMYoxJ41GaKHFsJUR4jBcUZc3i6nLcE0AXv+nNHw9lJQ/xA1zEDEaUXHjzti7CUYV4VGTQMIFPkiTTtZH1UBiET2EG37PjYzfJl1hWzAZ4JPyF06xUy2v+7G6DJJpfxcp/EK5tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 09:50:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:50:51 +0000
Date: Tue, 16 Dec 2025 10:50:47 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Liang Jie <buaajxlj@163.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER - SCHED_EXT" <sched-ext@lists.linux.dev>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
	liangjie@lixiang.com, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] sched_ext: fix uninitialized ret on alloc_percpu()
 failure
Message-ID: <aUErd53BltjN3XaB@gpd4>
References: <20251216093955.2928453-1-buaajxlj@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216093955.2928453-1-buaajxlj@163.com>
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b27d77-d59d-4652-fac5-08de3c88992e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7vskdNXL1KqSF2kjhfrFdN3TKX0v/aLiXmITc+ojn6GhOBUBaGULpD64AuGC?=
 =?us-ascii?Q?na+T6M321loT5RPTBpxh5uR8PjojHpcDDcmliGw9OCQzpIRC70hpGOWKLy4E?=
 =?us-ascii?Q?pXTU1cd5WpS1pMZGnKi5J5GyarN8+ApbTSSflHMRWflBSjHpr+WRe5qRPYLX?=
 =?us-ascii?Q?fjn3m+60mv3qIbthnE0+w58RkFuzDewEyOZjtX7yIvwj65mCWEF62e6ema16?=
 =?us-ascii?Q?ZKgzvC6vWl6mN0jQk2YPHnHjswUIxq1ZFCo78D3zRIxu+oR+q1nK6xp8ScPU?=
 =?us-ascii?Q?YtJZl2T18RDw1zSRuUnWXAgoBBZNv431ceqpAWj4BPmAEhwzun8LLM5v3cR0?=
 =?us-ascii?Q?s/UaPnHsh0mOgo5R+Iyu7lMvn07wgZ2ALxCk3cINR4L0Pa5bfErjUfgwNl/C?=
 =?us-ascii?Q?GULE5VzaFHsDw5SnGSoMjG25RUL4VUqZiXloBrq8Db7DKuKQzzgogNVjoUpp?=
 =?us-ascii?Q?gBSXoEHLwfIcsozZpT/BOKjsj+bxkMYIJGsvhjREGksbOa6xoFA7EOgtbSIF?=
 =?us-ascii?Q?RUkkfbkS6zC9PKjvItFUKWy07wcMlo0pKMRIKvbZNQBgvMg20hisSAQW6Gnw?=
 =?us-ascii?Q?8UdD0rqj4yQPsfD92V6f7HW3cdTew0xMvbS+5tCgMlIIF8uwQNJOT0mow6W4?=
 =?us-ascii?Q?mZt7Bj5cBaukeLpYkZYvLNCuCqB0XYUk6FpLIAafHolhMdFH1fgbls8Y6/7M?=
 =?us-ascii?Q?9+mgh6w+JB0rkGMbtYWnIB7+uY93rXz858C13VH96BLpx2bLpbucz9vDeuLF?=
 =?us-ascii?Q?H0IIfk9fzppGwosKDu39aaOuCLy1ul5zY4JUMYK17DMM9etk9jwIkp1DIBc1?=
 =?us-ascii?Q?Go0eRrk+dK2222EU9C4P6U8pagYxtuq4AOaD2JWD62maUkqEQa6JlQqxdwnX?=
 =?us-ascii?Q?ZxapbwfYTbsi8GKX2+kRmodjY09M09qFAjxOjANDjA40Km4ACcd/jlTowXS5?=
 =?us-ascii?Q?e2GoeWmUbLAL55+ZyvM5LvU44Uc7n0nwdpaP4DGwQcUYP5AQSMZh/49mi5J5?=
 =?us-ascii?Q?YNEOoTZIZvo+bg0mAfI1wjOfEIUpuuwDpAg+R7NNPn9kQxE8PJ9fNQWZ54ms?=
 =?us-ascii?Q?65kfkhsh1QqegCjCW/0RqWWspz04L2eDNLTQELyNCJbEcHrg/KIsuGJOEZx4?=
 =?us-ascii?Q?byPwbLMIQRPNbzjHvhxFQW6RQsEkhWvFkeR2CPbz9wyKEPJ7S0S/vLBfByUi?=
 =?us-ascii?Q?OF5d0NrI0m0hjkbbgkcg/o8g25HYbnZo9nfw5sXw/WfyffsEd4FqN3WnRS5o?=
 =?us-ascii?Q?3W9+IeIEi6mTf/0+W0NPV813OH2kYk087u+oGvduwa1kj76JTk4GEpexVUw1?=
 =?us-ascii?Q?ObAqEaKVdxKJsWcR7Nzznyjf38tc2G48MohnYbjsXVQHD37JLmY4Ei08CWRK?=
 =?us-ascii?Q?v1sCwhvIXXZ3yB3+f0ZsxHdM1549HYEum/LITrkb9scsurwfMdbUGRy9ketU?=
 =?us-ascii?Q?X/6v4OujFnvXuhNRmYcLVjiTAsFICyk5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YNj2nYjPSyFuVScV6AbftJ10LAx80m5Io9LCYx/K93cgQd5pUbEMlx4f1cQd?=
 =?us-ascii?Q?5W9RaP41d2LzrL0tg0+A72rkXHF/EPHC75u45NcuWYqfRL92y2YaUWcZSvIX?=
 =?us-ascii?Q?KuAyWiS5uz/wSMl84qixc0x1j2FaoiIq2m21leFCmSkpD8FY6905nYXu3gSc?=
 =?us-ascii?Q?nf6lFvtT9a83q3YBDia3sdVdoLit8uN5fuaBDXmfffqRe8nDQ+EkEttLP1ZV?=
 =?us-ascii?Q?P0ueQdEv0vwazVIJqb1SITwVyf2HYnG4af25zd3GqMO6J5EP3yCmiRKTHLID?=
 =?us-ascii?Q?WamQUTFKqNmFRpvAtJVaF5oilsV7X1bruOZyrr+W4uTNH2OOz5Wr0YIfiyRy?=
 =?us-ascii?Q?F6BrkmRxQc/6tLhJ2t7LTrtCG//TSiMuUABcYFKY1HwzP5gwBnQ5t3E9OuoY?=
 =?us-ascii?Q?oVBoiCh5cYPYteBbBx2o5A5aZ8mhTF7MFINDmxG1pJfrUmXB1i0Z6Vs7bwqI?=
 =?us-ascii?Q?ZrWTeXd/bsNwMdzNffCZgA7zTkH0DTEJwTMVTI30UqfCY28kcyj3k1f7mhjw?=
 =?us-ascii?Q?hF575dLk5Ht+s47xQkqsTXI4tSabfSF58NfVwaVhKZ5iZJwqJU0XULbP4HE0?=
 =?us-ascii?Q?Ft5/wzyMoR3o5I3Y+AUpwrXva13nM1RGbNmSA9utyl1SbCjdu+CPzBrQImhf?=
 =?us-ascii?Q?KDm8MOXqZo6xwruuJQ8SZEwrGyq9ea2D8ypdrXqZazVrxdcRS6C3Wenvg/wN?=
 =?us-ascii?Q?nxMO4/7u+racLyDTHyDXwi1CFmwFiUhr6ugbKfAVC7/HcIlZ54F5FWQ28sYw?=
 =?us-ascii?Q?E7bHevGfYEhRORjYHRCulOdO9Yyzi9TUfK2FVuOfavHHNWAiX6y3jGo/X7jI?=
 =?us-ascii?Q?PypaxIU8M8xnHCbFvONvHKh21YPc/uYG/fLdT10fjKO9Dplr4PD558BJX3yZ?=
 =?us-ascii?Q?+ZEpgB9p1BE8aokneOU6xPIRpKjmncdS8XdVvoEjSsfd9iktpTCedlBNi95k?=
 =?us-ascii?Q?pyeNTjm7g4r6t7mFl9MJgfk+c/i5QoPe72reShTjqP3PX3ZDajMNxB4qtMNb?=
 =?us-ascii?Q?fdMbxKtBiFr/9H3kP5V2Nen9Zx3ZAqYz2bwmL2basAj4UhGucX/R9Uc3zH6k?=
 =?us-ascii?Q?YF7YE3KxbWXwW5JSQz20bxfqYv1YPtEz2hm8KX37v21REwZHIV9ZHL4Z5Nbx?=
 =?us-ascii?Q?TEw/keJzBOwK8DSCQWg4gMVFgbLSGU4fR5dVFdJP6Pspq1aCCLZFMEKvxGVR?=
 =?us-ascii?Q?3t+t1rtkpsgjS2ilIfqfm4iESuhtjnPHZEqpF+W7pja0TorIE9VGWiigdg2c?=
 =?us-ascii?Q?b21QT0OrRAWK+XCNb0y4D9fOG8oU4LL4tpOCKQyjgggKcdEE3q7wOvOhc/OC?=
 =?us-ascii?Q?aTvKd1ZxfJK8CNXACT4oTdUcLq6/nDL8SER6EemgtqAcXf5j9HZ7XyFBAXxl?=
 =?us-ascii?Q?axRRca21pdTjGBmmYPJ2Goxx+K2iTK19TkuByCtRjvj1HxgqseZGOPeuVYPn?=
 =?us-ascii?Q?Ap1iniy50/w3ANHn/CC/0p9JRag598HRaOQCGFRvD+2R4hXJ50njOMcesa4I?=
 =?us-ascii?Q?3LXyAZO3rC/D1/w0C/jTENHsOhfF2oFPtt8oAm88VD2JHIx+dUHQqrv0jEQs?=
 =?us-ascii?Q?YxWdFqyWEervV6pJ+AZbkuIyDRHUxOBentIIIY/M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b27d77-d59d-4652-fac5-08de3c88992e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:50:51.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5MoFuW4ci9dhVsWvHtCMpXVksGcLVfgdlO1kFrpwqhpoCKpDCxo6s+OIDeqKOihFyiSrLXG/KuD2XmaqTKXkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616

On Tue, Dec 16, 2025 at 05:39:55PM +0800, Liang Jie wrote:
> From: Liang Jie <liangjie@lixiang.com>
> 
> Smatch reported:
> 
>   kernel/sched/ext.c:5332 scx_alloc_and_add_sched() warn: passing zero to 'ERR_PTR'
> 
> In scx_alloc_and_add_sched(), the alloc_percpu() failure path jumps to
> err_free_gdsqs without initializing @ret. That can lead to returning
> ERR_PTR(0), which violates the ERR_PTR() convention and confuses
> callers.
> 
> Set @ret to -ENOMEM before jumping to the error path when
> alloc_percpu() fails.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202512141601.yAXDAeA9-lkp@intel.com/
> Reported-by: Dan Carpenter <error27@gmail.com>
> Fixes: c201ea1578d3 ("sched_ext: Move event_stats_cpu into scx_sched")
> Signed-off-by: Liang Jie <liangjie@lixiang.com>

Makes sense to me, good catch.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 05f5a49e9649..8ea243b04dc9 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4761,8 +4761,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
>  	}
>  
>  	sch->pcpu = alloc_percpu(struct scx_sched_pcpu);
> -	if (!sch->pcpu)
> +	if (!sch->pcpu) {
> +		ret = -ENOMEM;
>  		goto err_free_gdsqs;
> +	}
>  
>  	sch->helper = kthread_run_worker(0, "sched_ext_helper");
>  	if (IS_ERR(sch->helper)) {
> -- 
> 2.25.1
> 
