Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793091649;
	b=OPhZYW9Q0Rufxz7Z/yWF601OzJFY/oTLJ7rTAN183SaHDYPm3BZzgxggNELiONcrfHOl
	 fdascBY3X0wpQw6CCh+JP12sdjxWIZgA7uwkasIXtIApmrB3d8EL1ODQiXiialTrB5qwf
	 /ooBIM80dK1Z8sbZW3GkqP4AD3zZSDKGzEeemGgEoz9LS/bFlDpnVRxonE78i9qb/hWvO
	 +hTqx08ArbBihMnQ8P8kMXo+PRtXf/EFq4DQDsaGDYXqmvk/nr381vfXXaogeQuh9asQz
	 nrfoTg4Pk+smf7IRv89TtjggVsgkLGC7F/+iDeDFH6n2TMzNikTa1Ecvqoko0EfhB1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091649;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=t1AJFzy/W8utYdCJt/L+Opm0e9rzqbnuP43zqOwmFxk=;
	b=x/CJmgk4cRFfFqcre6SY02hx0EbPSGujKYjryMP712etbj8DyK9mZhqr7gXEnClOoypo
	 6hspmoT5P7XMKxTha79EcZlAEZw/mGey8L9vTR731UHsCmKjY1pCt8Xoyd4v3ypNPBjjs
	 aUxJdLAz08yqRASE5b/rowyLdHc9TTJHAY95H+xJhv2KWa2L7+6aTN9ltjDGmbX8jJfhy
	 KNbeNCPIbuEujIKfSLO5COhbudNkl8UNVrKh+kmgfeKYuHWxlWTFLtlc/4eo4l1TIinft
	 3YDok4yZ5lFE07VycUzfnaPWGTVjjMN1KAGDZQtdiyeISo+bc92RlREBQtbDXmk51jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NREY3CYN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.22
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90304606A31D
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 09:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90304606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NREY3CYN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eptKaCkdjWc0kLJpiXa/nxyOOi1xY5H8tU/THcMxiqRCajyED6l5XnUGiwtFJSrZngOTShmYKMr/gKT8M3nM1po204x9OUEJZ02XR4T3aKF1J0+Hugs3UGXFKh6Z8SYKTwdCnCjvTHckhtUTUAbRYF0Brw83JHW7dBkNYXiucv7Rk8ydCRPpMSz5+cufXIpJP/eg0/UUURw6J42zcQnftBgpMyBB0uzSMJWMCMx6VVRfQSAVqUdYecnJQTqGmsNCQFl+/AiJf2+EZDFJjZBERIkyJ+fXxFequ3E1w0Wr2wQQ3w9Sf0g8I93VGcvYEbKwtG6j+m5s3u6HY1UlKZjsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1AJFzy/W8utYdCJt/L+Opm0e9rzqbnuP43zqOwmFxk=;
 b=F+Ds/GNWzFTzO3ZtdrvN4atZY3mbCstoyyrNIZkDkdM3xaOJKRb55RZzeub/XiYIxvCbiS+kdGmew2DEvfWSOlW7u/OD81XjfTrOHoow5cZ+/FHpnTwOV55B/FptM59CMfmpAFylWHawrXbrpEzZHjNLaLp4H3rQS66p9zFN4kXeHNXkxx5UNDk5TuB5OyuZWWQirTdquh2DzPQECYiipwokz2l7FNdvgDHMs4Lj34XYF+3hreVHQOfUcohPxI7b2DjRythp6mqK6LaIPcajATq7yromquVODpZ6uT3RWxZDwSan3tQKlZsc/oRSAwutsqHfaCY2MMt+T4+DDusg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1AJFzy/W8utYdCJt/L+Opm0e9rzqbnuP43zqOwmFxk=;
 b=NREY3CYNeRuPsbis+qDimnh71negrcsaFWMK/fOuf7QHkvJsJc2WA2kBFH9fcwN+pX2EVTqwNQBfnzBEuYsVpe+vgs8ol6ZUHRKrAY8yxGc+wxRSTSyLqCT7eFpm+4DXa8neK8mPcNkABmwlrSZJbZAMQLkYvSuGh6ytkY7GUpU=
Received: from BL1PR13CA0423.namprd13.prod.outlook.com (2603:10b6:208:2c3::8)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:00:41 +0000
Received: from IA0PEPF00000043.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::af) by BL1PR13CA0423.outlook.office365.com
 (2603:10b6:208:2c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 27 Oct 2026 09:00:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000043.mail.protection.outlook.com (10.167.249.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 09:00:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 04:00:40 -0500
Received: from [10.136.43.232] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 04:00:32 -0500
Message-ID: <d63c6e92-a722-4061-a9a0-5e84a3313c43@amd.com>
Date: Tue, 27 Oct 2026 14:30:31 +0530
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] sched/numa: Leave the placement of a BPF-scheduled
 task to its scheduler
To: Andrea Righi <arighi@nvidia.com>
CC: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Changwoo Min
	<changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Vladimir
 Vdovin <deliran@verdict.gg>, Gregory Price <gourry@gourry.net>, David Dai
	<david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>, Christian Loehle
	<christian.loehle@arm.com>, Balbir Singh <balbirs@nvidia.com>, Lee Trager
	<ltrager@nvidia.com>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-3-arighi@nvidia.com>
 <8464e356-d1d2-4aea-8702-40429c63bac1@amd.com> <auBIGwZfPR9oDPH6@gpd4>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <auBIGwZfPR9oDPH6@gpd4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000043:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: a8416ee9-367a-4173-0087-08df3408c6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|23010399003|82310400026|261026121527099003|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|3023799007|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	+o1aAdZaIxVVZO6t/QvnLb7F+I7Icjv3Ne3nei+vB2UWh8TqZk1rXnku7gOxCNMqq4WMJa9N/xNqXQ9AlbXzG4KYzlB2MTSwSPfpTxZivqTTvQiMVDtgKv/iNDuUyQhUP+2eJxpIC7jymXPmfguQxu1k/MhYNMCAHMSwT0mYq85EnGK26/Q6iIhoQDgvIm04cJVjheaes8q/rF9D3nwHV+uSixpgv0Y47KNe6b7I37zylfdqa0Rzjm4WVuuMp/2N7pp7ZErPcdummTPaTFZyCQFu6IpGKeZL45Tfl0iT8HMRyeVGFXODx1TNtN6+9j+vgMoOBHfdkPJFUOT1cX24hMSpJEy/whQls2rWhNeFOHPbm4Uil+o8iU/9Y21RYRs71nOyvA9ekaWFQc4Gz/APXgCfUSwiNe4n8zJUf+Ig+ZUzaZglIzgc/yl6uCmCY+oZLPe/7jimENADNFZOICnY14ke+0dqcgP2Rm/toyrKUMEEH8sKe0QQb75nw+f31FawNiVON8+E48enCW5JMIQ2kCfnONlzz20vL2wgi6Cq5Xsq/pO2LwP/ZNoeA9azj9VKfozQUbR82YSAkKKnPP36T7GL8bYQyXiaTvQbK2CE9NDBpmijPMt21kXGikcu6Ho7RGo1xMZ/8VfWqapT9xvCj8Y5YSC8X8F4XpBDM/cpk/VKXGTAwqdNO8BtVjmS3ldx5XNK+KszloOMnd5Kh8IxyA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(23010399003)(82310400026)(261026121527099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(3023799007)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q+06SGQY+GhlyxtGSZWjoPmH+WoyI3ceDQdwXU+3jtbFlGW5YG6GQerG0eA2lkyUEgM0Vo3akS/32bE2wvWzLhYjsdH6BHupO/LQHqNd90OPkFN/PKAX3yI4kMh3I8y3ICwiz75+w9vRJZXUjXsIxk0Y/6+BJLr9tWTCfmE59Ep0815P4988o40MiJIt5bvJTveEQfnyCQwgIZ0b/U7t6pInHfJhznTNf54ZFqMrbJyGEUCXB3lgAMBVm3pU8vS9ZrDlhIHqhfeILa59ADzClY9lOT6nbeZfbYmhtM9rsV8veSCWSuk5QzA7q+/T91xeQCpkFM/gzvkb0llxi91ksU0NUZnA3CvUxha2maCcjHNgrZ/5qW9ONuKbokcZCnQ4W8lSOdx55CWdp+RCZK2l1Gq721Uv44s43r7wz8vClp+sHtX8WPDRAII+wcSbxYxO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 09:00:41.2117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8416ee9-367a-4173-0087-08df3408c6fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000043.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

Hello Andrea,

On 10/27/2026 12:13 PM, Andrea Righi wrote:
>> On 10/27/2026 9:43 AM, Andrea Righi wrote:
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 36df9a4dde534..5064c7b707f4d 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -3267,8 +3267,13 @@ static bool task_numa_compare(struct task_numa_env *env,
>>>  
>>>  	rcu_read_lock();
>>>  	cur = rcu_dereference_all(dst_rq->curr);
>>> +	/*
>>> +	 * Never pick a task under a BPF scheduler as the swap partner: its
>>> +	 * placement is left to that scheduler, see numa_migrate_preferred().
>>> +	 * Moving the faulting task alone to the destination is still allowed.
>>> +	 */
>>>  	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
>>> -		    !cur->mm))
>>> +		    !cur->mm || task_on_scx(cur)))
>>
>> So if you are here, it must be from:
>>
>>   task_numa_migrate()
>>     task_numa_find_cpu()
>>       task_numa_compare()
>>
>> but task_on_scx(p) would skip this and it means a fair task is looking
>> for a swap candidate when scx running in partial mode right?
> 
> Correct.
> 
>>
>> At that point, it feels fair class should be well within its rights to
>> call shots on the swap candidate even if it is an scx task.
>>
>> If scx has a ops.set_numa() defined, it would have accumulated hinting
>> faults and the CPU it is running on is a wrong node anyways so the
>> migration shouldn't be bad in grand scheme of things. If ops.set_numa()
>> is not defined, then the scheduler doesn't care about NUMA placement
>> and it should be okay for a fair task to acquire that CPU.
> 
> The fair task can still acquire that CPU: with cur = NULL,
> task_numa_compare() can still pick the destination CPU for the fair task
> alone, and once it's there it'll preempt the sched_ext task, since fair
> wins over scx. What the check prevents is only the other half of the
> swap, which is fair moving the scx task to the source CPU, overriding
> the placement decided by the BPF scheduler (the idea is that fair should
> be able to preempt scx, but not override scx's task placement).

I guess that is fair - if there is a better target, it should be
preferred. 
> And the fact that the scx task is not on its preferred node doesn't
> necessarily mean that it's on the wrong node: the preferred node only
> tracks memory locality, but the BPF scheduler may have placed the task
> there on purpose for other reasons (e.g., close to a device, which is
> one of the use cases that motivated this work), using the preferred node
> only as a hint.

But is anyone running ext in partial mode expecting good performance
without having moved a ton of tasks to ext beforehand?
> There's also a more practical problem: the swap decision is based on
> data that isn't maintained for sched_ext tasks. task_numa_compare()
> does:
> 
> 	load = task_h_load(env->p) - task_h_load(cur);
> 
> and for an scx task se.avg is not updated, so task_h_load(cur) reflects
> whatever load the task had when it left fair. Similarly, if the BPF
> scheduler doesn't implement ops.set_numa_node(), the task isn't scanned,
> so its NUMA fault statistics are stale as well. So fair would be
> deciding the swap based on frozen values.

I think for fair, since there are no other fair tasks, it is indeed a
CPU without load - much like an idle CPU. NUMA balancing also looks
at load imbalance on the migrate swap path and it wouldn't have seen
the load back then either :-) 
> So I think it makes sense to apply the same principle as in
> numa_migrate_preferred() also to the other task involved in the swap.
> 
> What do you think?

Ack! I think you can keep that check. Let us not disturb a CPU just
because it is preemptible if there is a better option / idle CPUs
around.

-- 
Thanks and Regards,
Prateek

