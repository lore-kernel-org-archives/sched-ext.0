Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D813033CF
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107849; cv=fail; b=na+gXY4dsED5XY3NyV12LePctv3GyDV8GtqDb9GYnoxcscOINx9BHU/CGTI81NyTrRFWdo2ebktwN/JAL5UMY537+auQXEkZ/eMJAeFDOeN450FS/ST/xpkW4friki51QP/Nqy/A2m4AqjU8FxyZd/ygmsieLNCBiZ1zFOCJXxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107849; c=relaxed/simple;
	bh=Ch37PqHlRsf/1jS016lXKv/8lH3SOeTCH0rngMWbgks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KzHbp+8yQbKKdKbqzdQdhHlTPI+FHCIzVqw8cNPom2WgfBPQ3btNQBb5dFo1s3AyXyKRg4R3Vsz/vRkr4qmi4xKzYoTIVLenMxpnUswDlYl4/0sFC7p6yEqKctQnQCnJGUMTMKmFl07fUmYo/WCIpSkn4KQwz4tk84qr62Y0uAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KEy+2m48; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KEy+2m48"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErgnRjBEt9X3/P668nZ2hLMNRZEJxjyvyHJtOev8Dp65FyuIg2ogI4g5lytlE40EtM5PdLOBi+1aIM8VqtMP1uJT6bJikiLGGtTh0yw1JOcMBEw2fC96XadMyphCjcXt3+VWUAHfrPQzhJonbqbBZJRwZuILqJKCkrRAwYlPgE7cBFs0h+b4ItsflDYDnp7pGbleXXkVQMAfl87QfIZhfaiNQXzqYy8HoTzkChkLrCpfwUPMMsYxLg5pN+7Fq37p0j/LLqgxtl4/U8nWOBNqgT+W8gAcK6+0GA0OlYMQFMruI+VCvrBmlHxDFBHcvoYM1z55ja7qDCnL0TmdW3oz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTUuSWnS+NbIH9ARCowMEwUtW+raG8z30QaBMj5xJUo=;
 b=R59wpR5VJuxZHMiQ2LXvuCmtNzfv0f/mynm0QZGuNIzCE7+xUf7caAvuVgM8KIJybqqKR370OoGgxB1bzPvJY3vsBZVOL9ee84tQpzZvHkKUaS45FsNEBe4TvFdzPty+9MSAmZ3B2NbKpnYIXa4Aqj4JMqYQ/6XDWGB5BAXz6hJa6n8R4W1qKiUG/o3rAfqSkgnXNfvfDbj/3xjMMmrbCbjUwcy6mhdz5svLTCqfcSfGp5uVClsXtniXJSTDLlonK22KWaC9fW4MhyjSfwsxayeETsc2O8SVlTi4rEWko32n7ZE8o34Vel2t2bPR/c6J0vT9v77MXdTiT1Zi2ZDPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTUuSWnS+NbIH9ARCowMEwUtW+raG8z30QaBMj5xJUo=;
 b=KEy+2m48/21WGJ1/kR54KV4K/tcSxwBAloXnfjqp59ywfgXOQfPskj0y0UG2jmVCPESfGD2AZWZD+svF3BrdREMTGewrThhqXg7RNRaVJMBACTaDvRR08DB3GbTFIf/HiWGo8JEkOwGUeKV8tiixMHyREQwPGnUaH/ABEoBmNsti7YYS1Gx3KIBXUn2lAIjx4YL9WyUdG9sEdHgUHrXHt38KAOiSJQiZI6nRH2D2oYZvwVVoZqPb0mfx/P0EcrNfRXQ+NB+CsssgvP3IAZUO2bR4FMU3cBGfyc577IrigGpeJUsYgd1NiUb3WwiP5pq+0UknneJBe4SSHtPwfVhqRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PPF16C2BD7B0.namprd12.prod.outlook.com (2603:10b6:61f:fc00::607) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 08:37:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 08:37:21 +0000
Date: Tue, 3 Feb 2026 09:37:14 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Tejun Heo <tj@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
	Ryan Newton <newton@meta.com>, David Dai <david.dai@linux.dev>,
	zhidao su <suzhidao@xiaomi.com>, Jake Hillion <jake@hillion.co.uk>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/ext: Add cpumask to skip unsuitable dispatch queues
Message-ID: <aYGzumDW2sQ8xQSD@gpd4>
References: <20260203030400.3313990-1-realwujing@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203030400.3313990-1-realwujing@gmail.com>
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PPF16C2BD7B0:EE_
X-MS-Office365-Filtering-Correlation-Id: f756d583-878c-439f-b380-08de62ff72c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H4f1qC06gZn0p4c+OrlMzStXahpk+87RSC3er5o0x3byZBSzqvFVUiai0FQv?=
 =?us-ascii?Q?869Pt85cK8a0L4C1l5apZJPmMQBH49WSlmOwmWuPnLNtA2KJdqzyWtQa/biv?=
 =?us-ascii?Q?r1/XrkKBxLpfb0PtsDp0+RcT3LLzS8CDSSqhL1BOC2/s8UeI4eO4uXuq8kUs?=
 =?us-ascii?Q?ee3kweTcu9jKono9MOGlK7keaIklljoa1jmgsq6+rQ19R0CVD6JfdtENxKym?=
 =?us-ascii?Q?pohNS2BKkmfK3XRpe1QfqGP6cqtCmu8DMoxQ3TUaswipTqJRQ9EPI3iJw4B4?=
 =?us-ascii?Q?AkMBLV34Sry9VMkxBCA1cMxgCg5Rf3f/FVqtqHe7JwCaLB6IHsmCC+bSi57S?=
 =?us-ascii?Q?9KYbcdmnr0VSSpT2WAibhsR43cjQDZzjf28orpmMJmLKjVV5oN25XqbHAEkO?=
 =?us-ascii?Q?tUgEbm1XzbSxSSomszAXRIIHG2U392iMCPLCqLiagh2BOb+m2wLUETF70f2J?=
 =?us-ascii?Q?jgXEsEjE3/QUUgzYbc2XeUd8XND4yAOdkWvQ0XWk+kcs1FwAjejDS3PvvztQ?=
 =?us-ascii?Q?hzZS5gC28OZxws1OcH3IxESWfoTrtbe9GSmpB5yz7wT7ciJ/v7ZU9+AwSn9q?=
 =?us-ascii?Q?l4oHWHFKx1dlTbOoH/aVyMeEn4pZul9LjLzmNq4gjYV6/uA1XxauBVNQPbtX?=
 =?us-ascii?Q?U3r+3RyFGd4CxZ1F0r4sR/8sRvHY/ZLzj/WZ0cz5cjJBlR3nyA6MHKv7gZ4/?=
 =?us-ascii?Q?A66pVrjsaHD0MAYUze8jSodCyYCSfwHIRBZnUsF/UrsHOcQ0nKx1XXglW1hy?=
 =?us-ascii?Q?Oy6fJuu8BqAt6mFhN0XZK9XjKlAT9rRZIxSGrVEIOVvvSq/En21Mu/OxjKEd?=
 =?us-ascii?Q?X9+uyt0wcjPdOko5Ku9LnMvtGAxqNgnkkQgasQQ4sfQ2Tm8FJn2X89zkWSWD?=
 =?us-ascii?Q?Wr21ZmIsRNzoD05N2ViIXUL19jqZyVLzcz34U89/KeV5HnxJYs6hr+PWgKC0?=
 =?us-ascii?Q?D+vy6FLxhGOOEh5PEstXfuHdcyxbWP4VW5i7dS8sxCX37ESdtYoLOnVkAmjQ?=
 =?us-ascii?Q?8+DLVND6GrXFfN5+sBUrHdEcxBGXOQqpdaP8dTPeYPPHR6lMB5Y5CSjfggaI?=
 =?us-ascii?Q?MrI3zDmkxBLL7/CS5ESBEcWC7YiGu4BQQzGFuQZvhBck6IVpicv0DV7/pMOG?=
 =?us-ascii?Q?ZdIXQaqOk7Ot5pxULxKJVsOn9OVS8uskFYSzoyvfVOOvCqh7HluKjJ/K2yDi?=
 =?us-ascii?Q?72hs16yIbaCYURHXZshAuqJiSdIJ9EglrQ2srf1YQIC1KN+6lci3NRpPeSx0?=
 =?us-ascii?Q?NtcX5Xsm+tOMggxVxFT4isQdLFMIMLbXr7X3Q1AqvmlneNvIdWnN2udxyyPs?=
 =?us-ascii?Q?l8QP/ZYjZsJXadOoIfJksXv5a7ssoJgPoyKMpUWMKwCZ9FA8Dyk5risAAh0h?=
 =?us-ascii?Q?HpJYAt9EEAO+9PPTUxmOVd1aYPVReWlTg5zIpRirZMjymAY1dejpI6i1Z23X?=
 =?us-ascii?Q?TlnEbtRBFejknvtH3GaFa3yCAzdUrfPVxfF1Ky08iMkphfpO2VyNcic0HqBB?=
 =?us-ascii?Q?oPhvC6xOTEsJmryt+ILi+vVjV4+8fJhDwC/YOhy5jjLO46WYgPbuiiLpTviu?=
 =?us-ascii?Q?lADeYABLDtuTtCcVkKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4BP9k+fsrj+7ITaSAUWxqQbaWv0p7Ipqn2WeEq7Qw+deAevmfFo6AZUnai7u?=
 =?us-ascii?Q?kF9DDaWw1iHP3BPWSz+nVyIPBovVvCMqkR5TCzRb+J0NltGKj6fIMWvBaUbL?=
 =?us-ascii?Q?QZBPKnQ0nqdNY2hwEfmLORP15jBMazBqGvKsvBn2quXH9x9A4T3O4MUhYF1+?=
 =?us-ascii?Q?yfiShQXHdqdePgwtAVbWmxI7tjR8vAXesmv1jWG2P+1JaYJpqhhFDME61kI8?=
 =?us-ascii?Q?65TfJBM4VjLqFxVRA2ZDvPUP9yLdTPPkPsK061exXHlSRcQJ6A9etahxlvk3?=
 =?us-ascii?Q?Qjry97kduaZoANMD+yrfdHhXc/VOK+/IeHPkoTGrL7ENlF7sOXOSur5TpXIE?=
 =?us-ascii?Q?wSWHm+K2lsdjwgqtzFm5IbP9u5E8gBdsDxoyLICx0uy7GAjpY1nANuk9McmF?=
 =?us-ascii?Q?ED89Ycv00AnJFKmpcvkiyEX3o+EvdChNRWEh/GuY7mERpiIqejRVaqf+NpCl?=
 =?us-ascii?Q?fwvoA33bAlcex+ZPOFxd8IaqlWRAV9HauKl47fmEFPgnslIIX52nr0S1azAo?=
 =?us-ascii?Q?kdzfDmRUz/SWG6HKrxpxw7oKNCS1yMsGDPYSw29G9PoFCKtmx8ufP/0DWmK5?=
 =?us-ascii?Q?Vxl8/RZSW3ehDxUPXlGG1tjtGrlYR+QQW+w1QRhtK6I9kSZYexqMl3YlhVPJ?=
 =?us-ascii?Q?JKYn9upc1ixi441UdvPqBNWWVVDHZH2Yoq+7rVAWRy0tyLBTr1/9zxj/kaOl?=
 =?us-ascii?Q?LQIdo6JB6rJSKukNEv6C0VxSNPrON0uIfGHy04RvW2aOX5r1bGOFMyrYzdrS?=
 =?us-ascii?Q?IBPjvT3JgOLEj2MUef4tJRWOaEcw7k3uH0CBmDe+/yird+1RQOqcEhkka1XR?=
 =?us-ascii?Q?OK2bgYXL0tOcFEZbIb30K7wzY2hxGXiy9OB3ToaovgBX7ivoPBkfMWr2AcsI?=
 =?us-ascii?Q?a7bcA3lYlNmELmOwFeAke/q7Sdm9y0x6hRQ2HrzXRvC+ABTYYdtXl9exPMMR?=
 =?us-ascii?Q?Qv60PdtuuKEDDZza36Sr4Odqn3otiAbtJlAwaM4DJz5VX977kqLfW1J+IKT1?=
 =?us-ascii?Q?ngIwX+xP6CozqHX190VK6mMyeAZveVzTTrL63FRJXKy4B6xRAsAtaD5pQR5Y?=
 =?us-ascii?Q?Bo5yRy/+yozIaReTFECryqFwmksmJ7MYkyEKVzC4za25BMAbolYSdZNbqwGz?=
 =?us-ascii?Q?+1X8v8Pcu2DOlBYENK3ux11ejOMIcR3M/+4pLz3uA0AJwhuls/TA5enPDpUb?=
 =?us-ascii?Q?jhQnm0LW+A/tR3EHAYG2eRovLceQ3vT8D8HcudN1VNxzybgPyBWllKmDFxw2?=
 =?us-ascii?Q?zmBDE0Xwc3Qk9+3kEEaSUtwu9SFKl6+swlI2A7kY0dTrl6097zt4MYDcVc0P?=
 =?us-ascii?Q?zOzkBM2i+UPuc1JOpqQ/S79Uv3m6gcD/F2hK2JytIgG8a2kAq5jjbfGGQUHo?=
 =?us-ascii?Q?rGuArK8pPhUOLZKF8KhFU+OySUqacFjauxaVm/xebcHSn6OAg6M8dRlcNhkw?=
 =?us-ascii?Q?jThWZ2vaGE5cC5IKp3jDGsZmfCrXyO7/WR1EKF43XizWvF5e0GeZGC+jI53w?=
 =?us-ascii?Q?uxAvzPBPw+987HV839cf+Szm3nNrNr/RabbZcaJkvgzKkcc0INwpoasC5gro?=
 =?us-ascii?Q?JMJ9vifUkPgRhglr6kHBInUFuTZdYzI9FX/0fLHmKpp/iAwYdoKMjLn/9Z3+?=
 =?us-ascii?Q?a2uAMfB5VEVO+f+AgCNqZbjG8uTLKH0tP7fM29bwPAbFpVDfvupKVhJkDe5m?=
 =?us-ascii?Q?cmEcp6LiIgfHe19yYmULbQul3IynPwePusrTiyNKG75H++lkHXetaCd8+RJF?=
 =?us-ascii?Q?lJzjCUyYzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f756d583-878c-439f-b380-08de62ff72c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 08:37:21.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivI7v7lt8Ty3H7CGwhi1dGSk2YLvmG10VwpdBv8tByDbYI/ce48amdQJOAnfRfhViiigD2ptW7IpLUPCArgkLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF16C2BD7B0

Hi Qiliang,

On Mon, Feb 02, 2026 at 10:03:46PM -0500, Qiliang Yuan wrote:
> Add a cpumask field to struct scx_dispatch_q to track the union of
> allowed CPUs for all tasks in the queue. Use this mask to perform an
> O(1) check in consume_dispatch_q() before scanning the queue.
> 
> When a CPU attempts to consume from a queue, it currently must iterate
> through all N tasks to determine if any can run on that CPU. If the
> queue contains only tasks pinned to other CPUs (via sched_setaffinity
> or cgroups), this O(N) scan finds nothing.
> 
> With the cpumask, if the current CPU is not in the allowed set, skip
> the entire queue immediately with a single bit test. This changes the
> "queue is unsuitable" case from O(N) to O(1).
> 
> The mask is updated when tasks are enqueued and cleared when the queue
> becomes empty, preventing permanent saturation from transient pinned
> tasks.
> 
> This benefits large systems with CPU-pinned workloads, where CPUs
> frequently scan queues containing no eligible tasks.

Did you run some benchmarks / have some numbers?

It's true that we save the O(N) scan when the DSQ has no eligible tasks,
but we're adding cost on every enqueue: cpumask_or() on potentially large
cpumasks can be expensive.

I think this optimization can help when queues frequently contain only
tasks pinned to other CPUs or when the queue has many tasks (N is large).
I have the feeling that for small queues or mixed workloads, the cpumask
overhead probably exceeds the savings...

> 
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
>  include/linux/sched/ext.h |  1 +
>  kernel/sched/ext.c        | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index bcb962d5ee7d..f20e57cf53a3 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -79,6 +79,7 @@ struct scx_dispatch_q {
>  	struct rhash_head	hash_node;
>  	struct llist_node	free_node;
>  	struct rcu_head		rcu;
> +	struct cpumask		*cpus_allowed; /* union of all tasks' allowed cpus */
>  };
>  
>  /* scx_entity.flags */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index afe28c04d5aa..5a060c97cd64 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1120,8 +1120,12 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  
>  	if (is_local)
>  		local_dsq_post_enq(dsq, p, enq_flags);
> -	else
> +	else {
> +		/* Update cpumask to track union of all tasks' allowed CPUs */
> +		if (dsq->cpus_allowed)
> +			cpumask_or(dsq->cpus_allowed, dsq->cpus_allowed, p->cpus_ptr);
>  		raw_spin_unlock(&dsq->lock);
> +	}
>  }

The cpumask is only updated during enqueue and cleared when the queue
empties. If a task's affinity changes while it's already in the queue
(i.e., sched_setaffinity()), the cpus_allowed mask becomes stale. This
means: 1) the mask might include CPUs that no task can actually run on
anymore (false positive) or, more critically, 2) if a task's affinity
expands, the mask won't reflect this, causing CPUs to skip a queue that
actually has eligible tasks (false negative).

I think we need to hook something in sched_change to update the mask when
p->cpus_ptr changes.

>  
>  static void task_unlink_from_dsq(struct task_struct *p,
> @@ -1138,6 +1142,10 @@ static void task_unlink_from_dsq(struct task_struct *p,
>  	list_del_init(&p->scx.dsq_list.node);
>  	dsq_mod_nr(dsq, -1);
>  
> +	/* Clear cpumask when queue becomes empty to prevent saturation */
> +	if (dsq->nr == 0 && dsq->cpus_allowed)
> +		cpumask_clear(dsq->cpus_allowed);
> +
>  	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
>  		struct task_struct *first_task;
>  
> @@ -1897,6 +1905,14 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
>  	if (list_empty(&dsq->list))
>  		return false;
>  
> +	/*
> +	 * O(1) optimization: Check if any task in the queue can run on this CPU.
> +	 * If the cpumask is allocated and this CPU is not in the allowed set,
> +	 * we can skip the entire queue without scanning.
> +	 */
> +	if (dsq->cpus_allowed && !cpumask_test_cpu(cpu_of(rq), dsq->cpus_allowed))
> +		return false;
> +
>  	raw_spin_lock(&dsq->lock);
>  
>  	nldsq_for_each_task(p, dsq) {
> @@ -3397,6 +3413,9 @@ static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
>  	raw_spin_lock_init(&dsq->lock);
>  	INIT_LIST_HEAD(&dsq->list);
>  	dsq->id = dsq_id;
> +	
> +	/* Allocate cpumask for tracking allowed CPUs */
> +	dsq->cpus_allowed = kzalloc(cpumask_size(), GFP_KERNEL);

I don't see the corresponding kfree() in the cleanup path.

>  }
>  
>  static void free_dsq_irq_workfn(struct irq_work *irq_work)
> -- 
> 2.51.0
> 

Thanks,
-Andrea
