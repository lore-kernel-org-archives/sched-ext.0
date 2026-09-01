Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985F39F166
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240301; cv=fail; b=OvfWe0VH571RKH+Ib6sqAr6q7tsu+CCY7Pbki1nMXQqDK0pAy0Lg7vX54L6+HIA7DuSyuBNFYAI/IxEw2LQOZPqHYaGecGMD8Uc9gAPKpjva2mG8tG1rhWNZyH5zQwSLYBYDvCYKpT1B3NAo/7I5yQ0etLME8eZecdx1O+F9tEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240301; c=relaxed/simple;
	bh=15ABNfV/eg+h9uPU86VpSgdErcigug/MzsePgF3fTjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SebKsDvL+G4xKmzoo00K1RLqMvm2kPZd/3XlcFb+F6Eu3pMaYxyUnuVcbHA1DQ435ICLZRvD9K/AWz44v4nSo8fdsqG1tbcqodIdgMcwImclIIntx9GUaRzUPorqoC1rC4L6wHV+8K/tVTmsjMlsProoEyqMx1tka8I5FhJYV9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yOfdh2Ut; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yOfdh2Ut"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsBa7AFWpyWsyL4QPd8ymelwpfv/7Wm4PvtHokWmKy6CouEjhPAbS/6Pt/5WJL3+M4CDptBqzET4jxMoR3nJZbXhakZB/cZs58QgQzuhctOyDIcgvlxD9CttpPWUMMWXoZhxJ8qJ78N/Sc67l5XBK1hbulbntee8r/UYnQUe1r3XEFeC0pxsHWPYfhD3QoqCPq51xwj4ZAxBOEor45yMCx/EZzyVBoQAMT26eWHol73IXtntWQWrKZ/2tY5ug7wXmtQo66Fvc2AMqp/S1YcqAVFJE2XnFnGedSTkOn55k/3AQ12xWFf1NHuQ4/AmEjKDY1LRI6/TY3oafYSrK4RwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ONVNPKXt7CmcjrVT1GT7PuLQvDQ3a3gHxRfZA3gbvU=;
 b=YVL9XhSKPa/oTgoQam768PNaZl3Lw96lyBdjFXtK1Ehp+DjO7HtZD8bPw+kPkP69bTtV6pciJYn3PhcZ82u4ezGk08khWKTSdVCVJl0NEae+wLe6RMC/seRX1lr0/KYwCG/fZkcZ42BihSMos9XG817kd3Cn7PF4dFQD9YNMwIWeYhP0FKxlgNR2LGVbIhvkyjNmi/L0Eut1SytbglxllutR61Czhnrl1Xuj4S50OrzUiCoG7YPQvrjVgfQhdciP16Y6r9LzmBbysyk3r3iiuqj6nRODdN8PrmbY+rc1htgtgpyDdKHI2jdmtZd0kjMIMflbgBx935hsi8DwYFqg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ONVNPKXt7CmcjrVT1GT7PuLQvDQ3a3gHxRfZA3gbvU=;
 b=yOfdh2UtwLsBKuHX98WaqlWBreE77UNY536CkhY02cPpFu+unukLJ4RliaDiVQjkrXzqjcNvaKdFrSjUvANhoO5oVTVSZ7wiwPcoT0DO4Wf5JMa19ihDBBQDt29HLtgKeaQwSTFzKwlltqtcqTbMGO4duAguxdLQ3ySbwiPPSDw=
Received: from PH8PR02CA0027.namprd02.prod.outlook.com (2603:10b6:510:2da::18)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 05:24:52 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::73) by PH8PR02CA0027.outlook.office365.com
 (2603:10b6:510:2da::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 05:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 05:24:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 00:24:51 -0500
Received: from [10.136.35.162] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 00:24:45 -0500
Message-ID: <3d4116ff-0634-4ab6-be24-0bd2c68f1698@amd.com>
Date: Tue, 1 Sep 2026 10:54:44 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] sched/core: Dequeue waking proxy donors before
 reset
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, David Vernet
	<void@manifault.com>, Changwoo Min <changwoo@igalia.com>, John Stultz
	<jstultz@google.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Christian
 Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, Emil
 Tsalapatis <etsal@meta.com>, Lee Trager <ltrager@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, Koba Ko <kobak@nvidia.com>, Aiqun Yu
	<aiqun.yu@oss.qualcomm.com>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-3-arighi@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260831134338.1531664-3-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b70c9ff-223a-4fa2-313a-08df07e9598c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|1800799024|82310400026|56012099006|10067099003|6133799003|4143699003|22082099003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	FeKVG5WTLAmb5JmsesApmQbD+w3Uz93paVENU8wZROgW0x/bxfKOcX5GjOAuiDzJmKdV7kWSB/Kiak31BqOnStYwBJTMV0dtoBIu93hXXEWQZAtcxbhzH7Ozg00XrUkHvSkvjv23baK4g+OI75Nudb6RHMc1zPzX359bjPSB8Gg0ui3M+0xfD84yaiTUzu4grfr1ZTyvnA3RGzAKu6pz9GYQrqIzik0T8YSScQ46+JfQiuWiMP8lmxHB2X9yOxZFpio2ZGaDGBjecRivSZ+jt1DLV/s5iqeP5DwSKBA7Dl4be4BmQri3h1oiDIK9XmKPpyQBQY93rwmVgcDGwz2o7UFEYXjH3JQMGw4Orj9d3u51pNy3CWPgzteWPtCapA1Knilo+B/CVok+V3n+pmDJsXA0cX6frCbxKUS5XZjCA7MDRnmCeoSOjQ4m2nex6tpCNQlQwAERvzqs4DU46gNrbvCyRj0uTQgf7pPIs/Kq/fKkGZMA6/+l/aVjCypqJt4RLxNuXAIenExPQ8DrrRnbk4bn7NjYMSG0srtdEtOtUUWYguqW7qbXB/FeSNvFQFwIERycgYIUkxWdX/nfs2W24PMLTz0wCLxdSlYoJuOyqqv/872saOuzvskj2HWLMb80Ey8QL5m41wWKKXytSkGNBiaDif5ckBcxHaBXQ/gCh98e4SyMtJ8Ma74sgegNSxPf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(56012099006)(10067099003)(6133799003)(4143699003)(22082099003)(18002099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OSAEnz0qSwnYlsY8Grgq+IcaPxd4E+Hiy208cRt0f7ecF9FqrCxbEATMJf0nUWj1CDrFHrwVG22abh+7Xhy9QoIcG88ignzQr1B4277ixmo+eBwhXP7PqXT6SNcylSPwNnj1Tu7VVRnTUGF9+VbnM/naTsVk03CLfDcLfIJilks9BWZeCmOaiBg37lpNH4mQnGN92j6o48+YdGepTFs79ReeYalyawFI+O1aqsXovNhy4xnU6wwgI5ypDUu3VWn5dsfm/oF9CJqxQo7zIvj9u4nvrQl0XCl1d4zur5XzxLF5r4nIvWL4v9p+peMuNlsJIKabUSqJXfkryO0jkq6uQp7kKPDApYONQZZNlhHs/2md1QvZnoRJxrCKpGyq5i9g4eWCFhkNlorFzdAxSzscDIUdK/AWWKSHga9a8/mxGxAzR57LmGAabza/2Y9qyF8A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 05:24:52.0141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b70c9ff-223a-4fa2-313a-08df07e9598c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192

Hello Andrea,

On 8/31/2026 7:12 PM, Andrea Righi wrote:
> proxy_needs_return() resets an active donor while holding blocked_lock.
> proxy_reset_donor() invokes scheduling-class callbacks, adding an
> unnecessary raw-spinlock nesting. It also presents the waking donor to
> put_prev_task() as still runnable immediately before block_task()
> removes it from the runqueue.

Is that an issue for scx?

> Split block_task() so the waking donor can first be dequeued from its
> scheduling class. Release blocked_lock, dequeue the donor while its
> generic on_rq state still prevents migration, replace all donor
> references, and only then complete the generic runqueue removal. This
> follows the normal sleep ordering and avoids transiently re-enqueuing
> the waking donor.
> 
> This is a preparatory change to support proxy execution with sched_ext.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5817d1a4cea2c..237d216382f46 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2252,7 +2252,8 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
>  	dequeue_task(rq, p, flags);
>  }
>  
> -static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_state)
> +static bool dequeue_block_task(struct rq *rq, struct task_struct *p,
> +			       unsigned long task_state)
>  {
>  	int flags = DEQUEUE_NOCLOCK;
>  
> @@ -2273,9 +2274,15 @@ static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_
>  	 *
>  	 * Where __schedule() and ttwu() have matching control dependencies.
>  	 *
> -	 * After this, schedule() must not care about p->state any more.
> +	 * Once the caller invokes __block_task(), schedule() must not care about
> +	 * p->state any more.
>  	 */
> -	if (dequeue_task(rq, p, DEQUEUE_SLEEP | flags))
> +	return dequeue_task(rq, p, DEQUEUE_SLEEP | flags);
> +}
> +
> +static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_state)
> +{
> +	if (dequeue_block_task(rq, p, task_state))
>  		__block_task(rq, p);
>  }
>  
> @@ -3774,6 +3781,9 @@ static inline void proxy_reset_donor(struct rq *rq)
>   */
>  static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
>  {
> +	bool reset_donor = false;
> +	bool dequeued;
> +
>  	/*
>  	 * Typically per __set_task_cpu(), task_cpu(p) == p->wake_cpu.
>  	 *
> @@ -3797,11 +3807,17 @@ static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
>  		if (task_current(rq, p))
>  			return false;
>  
> -		/* If we're return migrating the rq->donor, switch it out for idle */
> -		if (task_current_donor(rq, p))
> -			proxy_reset_donor(rq);
> +		reset_donor = task_current_donor(rq, p);

nit.

Since proxy_needs_return() holds the rq_lock, you can check this outside
the blocked_lock safely, even after the dequeue. There is no need to
stash "reset_donor".

>  	}
> -	block_task(rq, p, TASK_WAKING);
> +
> +	dequeued = dequeue_block_task(rq, p, TASK_WAKING);
> +
> +	/* Keep on_rq set until all donor references have been replaced. */
> +	if (reset_donor)
> +		proxy_reset_donor(rq);

Since TASK_WAKING is guaranteed to block the task by adding
DEQUEUE_SPECIAL, you can just move the proxy_reset_donor() bit out the
blocked lock and keep everything else the same right?

I'm not sure I understand "transiently re-enqueuing the waking donor"
bit. How is that possible if we just do:

    /* __task_rq_lock is held throughout. */

    if (task_current_donor(rq, p))
        proxy_reset_donor(rq, p);

    block_task(rq, p, TASK_WAKING);


Is the split because dequeue_task_scx() needs a correct rq->donor
reference or does ext requires dequeue_task_scx() to be called
before doing put_prev_task_scx() always?

> +
> +	if (dequeued)
> +		__block_task(rq, p);
>  	return true;
>  }
>  #else /* !CONFIG_SCHED_PROXY_EXEC */

-- 
Thanks and Regards,
Prateek

