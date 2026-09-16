Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A634E8E08
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555160; cv=fail; b=ZwlEx14P5ATky21bikekk8tvHEJy5oygFxJqg96WfhGSFLx9IvgJ4NAfFxooP5oSBdMT0jJ0Ad31lNGTmxuLrTw75P9jWAE21iQeEJIqP/Xq5DtT8yjGjUh/LJOE0Ko3QB2/D5UF46ncr7UluN1X0DeZl4qRW06oBOBn+UfOad4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555160; c=relaxed/simple;
	bh=1P4nMhMFvYuCEXkK5c8v0f4xLCFSLgbmWtm90KOnn3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=grtDt9fRcK+WgmLHMDVR544ysy8PeeDTSBUol+z8UQ9qv0Wwq1Pp6f9ddc50oDfhqDzFHKjB13btjlYRho4LX6IcqJI4D3G1h/lvOAE+nDjnzJ6e2LJBUc627lfcZY1HAiErsDh0E30QZEldE7j2olg8+6sqykqOPjvnvv6t9Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JFIFNf2q; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JFIFNf2q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTmK3BlwBB2GRlgr8x37x8dv4WgcRufA+HjwZC0oqVEgou3sU0d0eulqTfh8BrJHuLNLSbBwYpGqdmxRcbnwv8GUDS18qjbHwK+Yb6OyErIH8edHZeQzimjQ/rf6+spzNVOMBBAx8bDHMl0k1FERQ972axEWDeNn/i3eAlAj9LmCV1MENr4cFg5F8AftIGqXXCcs4xdZP+cEeErFgTN4F0Piz7s7DfItBfRahY0FDcQ7JJ/FNlR4QDQIEbC6KuAmcteiH9qITl5fnYsw1m+SDn4QRYlPiB7+iCNh7R6kRjqe6iyapC8txW86YyBRG0Ttvg6RSnKEslw6mBbHV6Zimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0xTXPMrTPRWC1SWbY9GqKYO9JjoYxj8qwJSbFKHke4=;
 b=kQnviDlRqnWuW/A9XERS6PXf8PW5RBmJHMPENd6Ro+Vao2y07RCrhIoMfcYVUEEndpl/SmS9mWqygwOr4sXjXsoIN55tUEnKcsn6Megc2jqV51M7x0xrvb+q9rNmhBRcgvIJ/ki+jyrartms1+eIk7iFqIi6Qg2aiCzyAeTKay/Sq9AOHenELY9JydAJHc+gTDkezRkmnBLTjPu2YX6bb7TcMQCouXIGwnkSWiEGaN4Cc6b0n7ONkNnvXZOtJ5Wrg3RZIlb57/GWTzaN7KE9xEgMHgFqyWBg4YDPwFMeKfzHyHwiOA8H3W1mMdEpSN+U5Faa4UHzgc+6XoSkpl2yGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0xTXPMrTPRWC1SWbY9GqKYO9JjoYxj8qwJSbFKHke4=;
 b=JFIFNf2qv0tGAMV41Ca9oSEbduAGkMrqfm+5p3BdQD1KYjyWK1aQm7bcirXjdQ8rLXu6G5GhPVOKWv4HSGu+4PxqE548sGOtXwdW1M0icloGSpAyYSC2jIHry8g1sJJ2FUpJO1yT3GLn6UwQdahEFb/BkZ0bwb1okRyAnv5rcX8=
Received: from SA9PR13CA0126.namprd13.prod.outlook.com (2603:10b6:806:27::11)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:38:56 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::8f) by SA9PR13CA0126.outlook.office365.com
 (2603:10b6:806:27::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 10:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:38:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 05:38:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 05:38:54 -0500
Received: from [10.136.41.131] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 05:38:49 -0500
Message-ID: <62d8da7f-fd6f-4e65-8e6d-520d39d55570@amd.com>
Date: Wed, 16 Sep 2026 16:08:48 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] sched: Introduce WF_ON_RQ wake flag
To: Peter Zijlstra <peterz@infradead.org>
CC: John Stultz <jstultz@google.com>, Andrea Righi <arighi@nvidia.com>, "Tejun
 Heo" <tj@kernel.org>, David Vernet <void@manifault.com>, Changwoo Min
	<changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Christian Loehle
	<christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, Emil Tsalapatis
	<etsal@meta.com>, Lee Trager <ltrager@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, Koba Ko <kobak@nvidia.com>, Aiqun Yu
	<aiqun.yu@oss.qualcomm.com>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-9-arighi@nvidia.com>
 <20260910104528.GI4120091@noisy.programming.kicks-ass.net>
 <aqmw0OT5cCtge-QI@gpd4>
 <CANDhNCqN+mJdrjgjRD_pMQYssHCrmrnE9CW8cMprPQm0dZPtWw@mail.gmail.com>
 <20260916091908.GG4121339@noisy.programming.kicks-ass.net>
 <40a61874-4841-4e38-b22b-6b8c30667340@amd.com>
 <20260916103043.GC776954@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260916103043.GC776954@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: feb4ccac-1dda-4bd7-a2f8-08df13deb54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|23010399003|82310400026|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LFv5hEJ7YWOukLiMkMcwBr1WUGCR/f4mqqPm4VlvjKoffEv+XVExokWblkCAAFoKdLTjgqCtvYKYRaTSkyNqtIgQhW2/WNm1k6ncZCjTxJZQMRbNE75+MWWfyJBy29gnGqB/QaTTm3gQoQIZ6gu9ODCfVQgYjbuTmgrXZPs74Ii3hKy3N/PBw4CMUnfLuTuur2IOw19/3QZ6jm/z7QWG7j4Edf5euYMG/7AP9D+Jpb37DLsV2LZkbznQTOC3IyehgzTKOY1uYgVb9sf2Xd2IZ0HCRWqCq4akZ1GUmOxxKhXzR11nJE/AU2OrfJPDGBK66xs7EOVKnVqvXTCVR7EZPR1LMubRFvYYrD6yN4oJ1nIwToquTae+Mq8Xd63b23CQl8vwtT9E9Q9dMpn4ifRH2ceyBsh8gwm3y96D80JuolLmiNJmIWqzFmNJw5mN99qRJj4fOkqiIpzOztWEJiC0qp27Nrw5Yxuz9xlnoGr2DGkXbDaf4vzsL00JAt0Ptcr5jVH2H4Iql2C7IIjER6+U38w20fo+Nk5mv6lwR0/18Zq68MaNp749drsLaF0XtbdLwCOytqWkwo+2j4gNzMKlWTDHRrNR9B24or8sy8C244MMe7MA+foh84nY119dUcB6wVa1V8OV2uIQd3spsmLNTnRzmsfZ8Nb8xH5WvsD6qf0xPR5CklBMW603IJt0XV17U2wr2oo0CmNCFXgO4naI8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iGBHsQEB9t19O1zfhJOIkwCrdrylR1Kf3w+YRtSIP6/y3LXCyrj48qAFvvh09LeLkQKqjRZZXF4kXaIj2ESmWPhbilJbs30Om8PKsNfz+xEuePmw2s80NESFk4AiQvLq7o5vuhEWm3DRV2QYJEhazY0P6nclAHa1MuOgI7CWqU46WTk/CxXbbxob4wheuiuDqEx/qyd5PgA6ay1brYeMYCPB0PqdCyJR0dltXLBvYfdf8MWzFkihteiJV7pBC7shHVtYYm64m2nGgN9BlL3ND1j6BwUVIkel1AZGQkC/SLIFFYvNhCFgscRWw6JXlpaDdhy3d8guCW5cw63okbYh0xPAyJ8FamTZVJsamS04GAJUzSBI0hsfgFtJvBjkchUECBqlHFJGFRcWXphuYK+ir+aHjoT+ryT6P7VkL4Ks8sRAnYgWI/kHuqj7IRPjE0t8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:38:55.4753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb4ccac-1dda-4bd7-a2f8-08df13deb54a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468



On 9/16/2026 4:00 PM, Peter Zijlstra wrote:
> On Wed, Sep 16, 2026 at 03:57:54PM +0530, K Prateek Nayak wrote:
> 
>>> @@ -2393,8 +2393,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
>>>  		 * If task is sched_delayed, force dequeue it, to avoid always
>>>  		 * hitting the tick timeout in the queued case
>>>  		 */
>>> -		if (p->se.sched_delayed)
>>> -			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>>> +		if (p->is_blocked)
>>> +			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_BLOCKED);
>>
>> For proxy donors, this will simply dequeue the task without
>> transitioning p->on_rq to 0.
>>
>> If we want to break proxy at this point, maybe we want to bring
>> that __block_task() into dequeue task and do it for
>> DEQUEUE_BLOCKED?
>>
>>>  		trace_sched_wait_task(p);
>>>  		running = task_on_cpu(rq, p);
>>>  		queued = task_on_rq_queued(p);
>>> @@ -3889,8 +3889,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>>>  
>>>  	update_rq_clock(rq);
>>>  	if (p->is_blocked) {
>>> -		if (p->se.sched_delayed)
>>> -			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
>>> +		enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_BLOCKED);
>>
>> For proxy donors on rq that don't belong to fair, this will enqueue
>> an already enqueued task.
> 
> For both the idea would be that {EN,DE}QUEUE_BLOCKED would be ignored
> when inappropriate.
> 
> Eg. fair will no-op when !sched_delayed.
> 
> I did mention none of the other classes behave properly in this regard,
> although the note was perhaps a little cryptic.

My bad! But what do you think about having a bitmap of allowed flags
that lives in sched_class->flags and is checked at enqueue / dequeue?

Only the lower nibble is set conditionally for matching flags and the
upper ones are set unconditionally. Only user would be fair for
DEQUEUE_BLOCKED / ENQUEUE_BLOCKED but is kinda extensible if more
class specific flags emerge.

-- 
Thanks and Regards,
Prateek

