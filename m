Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E14CB8D9
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554503; cv=fail; b=HZHDyKJxHywHaRvr+s5p7xxVPwK1zE1ZieTAjpfZq4T8g9WNKfn0lFKePYWCqAyGb/sCAo2hWrZ2sveW3ugDknxPyRxgzwMttVuR+Ysup7rf+7lWPYUPFON1czHFcVymObSD9GNyiCbPLR2ktpKL+QsoLkYwK8YyJ9j86Xy2Mf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554503; c=relaxed/simple;
	bh=ukJrqcvL4Sezls3Bj+jfUs9NchCl3CuQDSJIfg9SGD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X7Po1WTkCCcX9ozCv3CdcY/YN9e557oI9igpacvAy+NwmtPGuDSXcgQsdeEn3Vp5oPY+fb/MmP0LpyJHvosmOm1Pk4XgQpYzEvHq9zn7/tJjxaJMTpZbcTwVcTgVNIuYlcfHWpP2hSnLUrfZm05RIoNFy0yU27rYjbWteWPLoTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DcgT2Q9m; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DcgT2Q9m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmoJ9el5tXdq4Yp0bcKTY08GZVu7fA8lbw/7AFmcWgskwiFLnqrlQOX5+bjHwzgOHgCTv1UifTV7PBLabuNgdxSIwWH6lCbzLgYxUGaHZZ3BiFapTY2c7EcNTOSgfpe13D1Wy2N3eGOOLWReWQrsy6hT1IuEH8us7t/UuLVMXjkGpwzNzvFr57CFSonnBtwnGr5Ymd5s/yJAcFf69h0LuMohLtysG1p0zy4wvvfta3nrD/jGGdl0t6JOXu3ayQF19qScNm7ng9qZkQZChoNQd6WZOXtc4WDOqz79tdFA5DjorqALj6YMuKCFVnYDqycTE0KWr0O3olYJq/KARhHc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wIIn/nQhenGVPpHhmXNQDC/Dz5OMvsLv4e2hQMrrRg=;
 b=EY4J69uCeZoYY3gd5rIvVnwxCpEBWc83mxD9uprgWxbtHWzJX8XvIOs9E6GgeilTVuhz/9UXnVAkXUZihU3PFmWE2sqy4Qr24jfb8tP/UgYTnRIUMhXto3hsDwboTAg9f1Xj2Hbgx/NGwHjcTMAMX1PMReZ3oc2/vNtCnEifuNAK+OnEY4AQihXJdMu0AriDswErZcyRWkudYEpBWxVKbcmJjWOlxVTdgBiK5x6HABGx5WfyRWmzZI0wie/TUP3DfnukZ3/zgsE3CzRE+m6PmIbwqc7bYVralffTBCkQieKogcvWA/+6/VEb9yTA+ims9eJ159NlCzK17omnD/rWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wIIn/nQhenGVPpHhmXNQDC/Dz5OMvsLv4e2hQMrrRg=;
 b=DcgT2Q9mBHDUoXLG9y2+g4Oo5aGT/zr7atvVd9YAd2QmWINVhk5smmflsLJUcjhzqobPvBq3IrPjVsCkbtG71/RGap8lbdKwS4pdq+u1Dme6IMpujklm9mYEWpvvPcliKLJ2cjspeR0ESJIq9fvRmPF9oD/r4Us5biOwov1/srY=
Received: from BN1PR10CA0003.namprd10.prod.outlook.com (2603:10b6:408:e0::8)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:28:05 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::7) by BN1PR10CA0003.outlook.office365.com
 (2603:10b6:408:e0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 10:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:28:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 05:28:03 -0500
Received: from [10.136.41.131] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 05:27:55 -0500
Message-ID: <40a61874-4841-4e38-b22b-6b8c30667340@amd.com>
Date: Wed, 16 Sep 2026 15:57:54 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] sched: Introduce WF_ON_RQ wake flag
To: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>
CC: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, David Vernet
	<void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Christian
 Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, Emil
 Tsalapatis <etsal@meta.com>, Lee Trager <ltrager@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, Koba Ko <kobak@nvidia.com>, Aiqun Yu
	<aiqun.yu@oss.qualcomm.com>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-9-arighi@nvidia.com>
 <20260910104528.GI4120091@noisy.programming.kicks-ass.net>
 <aqmw0OT5cCtge-QI@gpd4>
 <CANDhNCqN+mJdrjgjRD_pMQYssHCrmrnE9CW8cMprPQm0dZPtWw@mail.gmail.com>
 <20260916091908.GG4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260916091908.GG4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 4311b2f6-63c7-4a01-5742-08df13dd30d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Z9BxyZMccqg36rswymvnRd8EAQjNr1oGqMGyN5fD7CEzcHaVb/GGQ8FqWNbf5x8NizpP74BqH3WDVXyroC1sR4Ah2fBr31hRy4t6h2B7of9Gzu/NbDN6XzZRK1CS1bQ+bf/8TANtrtGk15LITP/N219+Tg0u7IeUbr+Bn2nECg4S6OisqRU1A4KScGpMcKZEyr/1ZP4piHDjNsKfw6vxto/36ZSJTaQp8Qj0gIPclsX1n2uSaB2XOrxp58ad9Y8pPIYYGDdfwjow5zCd2yvXUjzTGSkIPPixq7yWDhoViBXTH+ExaIu3sXAYwOtUzpeB8FbJw4lKaZVgTpuxAh8DpiLz9nN1OWFAs3RfcVLbsf+Ue5EPCRDys8HeXq2iGvmc1+enOxNHO4SnW7YtH41Jh6RkZBmSVDoRMrHCJw0wpnGhi3OejHxch4i++UeFpGVbR9I7QmCiTkAHCQJyr0kyoq2NpCp/1eXnger7Lr/NfcsA7WSuzmk2HaQZvrt7Os7oYumclakt/g6ah2NzssIV6OPmXcG7leOGvwJk27cIqgi8oWPWUaQqgB77uQrDJ+OokOVBB0z97yywM0/GQKYzLamTPI7KUg0CJERQ4U4jDRK+kbr/z17g6kmgxi+ur4bjyyAY2f28Ro7tLc9oGfXxjCfyppq0nzHGLcFzR3BhE+OVNTDlmTePXrNHukL/uMpNyqW38rWHkA0gJk0AeJV5dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fS/ozqHyxrudfwZIq84VVDFvb78/GMgN+JUuZW+99GIBrB5uV+PLSwFU81gqsel0WcXfNvyV5egOuLHYOOb0AWmnEzFE0RImZpah8CKTr/imA4uwIeCAwbWvCURfbDoCxibFeplftT7EnMnO1tfwB4XiL3YjgDaKFNckxuCgd9RUtG8Of/kiVlOYTlUGXo9Qch4zlVGFEqsUhpLsTaSgWRiCfQuOk0q9ha7bFxLE/VSloI/Fu36JzcmMV+FlWS02gC0w4tfwoFu+ltpADXdIh3yfXRUXE3NcVaRsznHS9CikIcHTCC36VMvaudqMrOkyk3qot3DZGRrZyZPAciZlPp47agY6pEcJvi7X3WaUO5zr7NAUyi60bma0DXscjmAV6oqiIM9fcFOBk6SePvadZRkyr3iCbVCvKaI1PlBBjPUFiPlF7SCs+vwT3MynOhaa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:28:03.7618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4311b2f6-63c7-4a01-5742-08df13dd30d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484

Hello Peter,

On 9/16/2026 2:49 PM, Peter Zijlstra wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 91f059a55695..9a583e3cc528 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -305,7 +305,7 @@ static inline int rb_sched_core_cmp(const void *key, const struct rb_node *node)
>  
>  void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>  {
> -	if (p->se.sched_delayed)
> +	if (p->is_blocked)
>  		return;
>  
>  	rq->core->core_task_seq++;
> @@ -318,7 +318,7 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>  
>  void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
>  {
> -	if (p->se.sched_delayed)
> +	if (p->is_blocked)
>  		return;
>  
>  	rq->core->core_task_seq++;

Although we don't support proxy with mis-matched cookie, this might
still be required down the line when we add support for it.

I can add it back then if that is a better option.

> @@ -1880,7 +1880,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p, int flags
>  		return;
>  
>  	/* Only inc the delayed task which being woken up. */
> -	if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
> +	if (p->is_blocked && !(flags & ENQUEUE_BLOCKED))
>  		return;
>  
>  	for_each_clamp_id(clamp_id)
> @@ -1907,7 +1907,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;
>  
> -	if (p->se.sched_delayed)
> +	if (p->is_blocked)
>  		return;
>  
>  	for_each_clamp_id(clamp_id)
> @@ -2393,8 +2393,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
>  		 * If task is sched_delayed, force dequeue it, to avoid always
>  		 * hitting the tick timeout in the queued case
>  		 */
> -		if (p->se.sched_delayed)
> -			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> +		if (p->is_blocked)
> +			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_BLOCKED);

For proxy donors, this will simply dequeue the task without
transitioning p->on_rq to 0.

If we want to break proxy at this point, maybe we want to bring
that __block_task() into dequeue task and do it for
DEQUEUE_BLOCKED?

>  		trace_sched_wait_task(p);
>  		running = task_on_cpu(rq, p);
>  		queued = task_on_rq_queued(p);
> @@ -3889,8 +3889,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  
>  	update_rq_clock(rq);
>  	if (p->is_blocked) {
> -		if (p->se.sched_delayed)
> -			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> +		enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_BLOCKED);

For proxy donors on rq that don't belong to fair, this will enqueue
an already enqueued task.

Although the sched call callbacks may be able to handle it,
psi_enqueue() will do double accounting since block_task() was
skipped for proxy donors.

>  		if (proxy_needs_return(rq, p))
>  			return 0;
>  	}

-- 
Thanks and Regards,
Prateek

