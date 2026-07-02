Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645B35DA65
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016283; cv=fail; b=ETa3gdtsGCySS3Ir85H2UpFX9L7g7Xo/ERWGnIdSaxzfvvOV2k2pHztMbxJJpKqOUajGukgFenT3xyXVj63gDr9wsO6XIBaYq48cMBiz+qimDJGnAq5vCsm9ZwJTdr/s7b82T+YbvwDJXyte/SoAGBfDIRLhO+desm0ty+yaRSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016283; c=relaxed/simple;
	bh=oesbn6ZO4x50j7waqh5D+naSAU7LNvHQtXdyvLCCpU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=utBvhBSGE5uynFGvSh9pGy8GKWFddQl9OQbF/khrRgYfFNs/og/58VkWqNH88i0IBCC9GpEKxUwV8G/fcBYEauYsHYmSDCjiv4F28UEgxpns83B0AgI5IUt1SD8gNE5i/IA2EVjkMWVsyk9ubMQYNrrAYNvP97Ure/aKM7pcwSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=keKlrmGL; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="keKlrmGL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiyEcy8uv2fw470i6wvd5dWpCMhvXBKGLlKGB/rCzy6/Fo7KTWmW6Ty9y+P4BgbUlWe/XkSJFrPqgazl9pdNEX1bZLVEFC0hojimtIkRzmy/a13ooZ589ZU78xJcLmnk8lLyCIM5Ll0F9cUDovDqPqxDtMsTIEiS96hjtEPuFWXobJ7YLNBzmxZR852U+V51orJjVujpxV+j/ricuDN9+RjyPc8zHNlPIhxPgHLyjn1BHRXqWgoU9Do1xVh5o97bfFCNighohFHs0GRjqiu7xsRhcObG+Hhyr4/uUkyKLOil67AMISVlAZtSI81CBPMP5Tm/DXrBKIqyLduC9n4gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnA0fRatK9QL/HYyH3xn+w1YDP4I+BNjD3n0apd05uE=;
 b=yWiLgfxJoIs0NZWF2qbEA8vnBYO97hy44br+F+3JiyMph2UvXBw5qROb9m0/qiedYOzKQ0kZTNdg+zQDQiWQz1LNmQp3ye1G/mlQgkLQiOpO5BJvbeJWtNYZo6F8i0uS0nru2dHU/ieKU3fakelWvZm9Dou4ffJz65bq58oNNxLKCwTXl4MiGBjxPQw4OxbGi6VOn3xvcNZ61G64nq65ZYjBKL+TAPjUoOt9V3zmWBEVOq65+6X/AJYaogVgvybiyUg9kn5khstWjpgQ08yTzHgh+SVdmPgqZgZVbh9sZ0Apm0VIEspoPxBr4N3dUkdoyXAmHBHGyNI1vnKHHP5z9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnA0fRatK9QL/HYyH3xn+w1YDP4I+BNjD3n0apd05uE=;
 b=keKlrmGLQFnVs29fpyflC14Mhnn6FVjvMVawRg469H6W23oXqi6kWG2RGU9nEqKs3t4IP+b40FZMJHm2H8rU35TIc/vj9QxVKU+1EHlNnPEql2LNVIG/PIjBt3wnfEF9pWqL1cDTMpiI1ftpiwO6CF/QvxvcGgE6ZGFlxtdJZ9s=
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 18:17:52 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::50) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Thu, 2
 Jul 2026 18:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 18:17:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 13:17:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 13:17:48 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 13:17:41 -0500
Message-ID: <d1fdddf6-eec8-48bc-bbd5-d750c8cc3c17@amd.com>
Date: Thu, 2 Jul 2026 23:47:35 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] sched/core: Skip migration disabled tasks in proxy
 execution
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, David Vernet
	<void@manifault.com>, Changwoo Min <changwoo@igalia.com>, John Stultz
	<jstultz@google.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"Christian Loehle" <christian.loehle@arm.com>, David Dai
	<david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>, Aiqun Yu
	<aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	<sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-2-arighi@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260702171909.1994478-2-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fb1664-90db-4183-cc65-08ded8663b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|7136999003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EC8HeuWHQeAvdFePc1OiZlXYlCGsWL5o7/pdjIm6NZU/529m4yvCOs/1qy7JVaOMu4VXnv0LQz93fX/NS4hjkBElsTVaxZ0gM6QcWg3VB1K5grw6E3dG89vgj2rmRALFQmk5TNqrDpmqE5BuGRFEB5jXv93ocLfZuGg2GpHXVq6lnBi173pCkPZ0krgzHGPtR7tInlo96LyG7znFwT9wUrrixq4SY4xS0iDZoGv4diMyh8I9rhhsPXM6loDkPhOj9CzEqfsT/6bfj/cbt9XIXGGN3XdAZksAGc5Smukh6yIAH00sR7MokXVbXr5Wovyi3zADVpLvPa00Zbw2Tco30oO0ce382LIxZKOK55Slly1CiI9Zh1IfGCckNbKGsg6S6aT9LF11X9+FURfYAw5+qYZvp7+bnyoDTegP3LyhrXGut+iESePHVfR4m9cmGj7GMryWQ1N/tRh3O0j/XG6vZTGdXsIHn8qklNBk5+/kiH6063MQgQrywbIp0UJY5TA9Ae8lLjnRNycJJSzg3kXoZfAnDGvdls1VhdiSpRwerumbZFA8JgO5PS4ucvrdbLR9yn2ul+9u9HVgtgKgbCV3xUFvVOEFGcmca5LtmaKajHl40gTpfOPChA1X1KwdkkpEzJvkLvIK/jTlccdGOhSFG1DH80YZRu03ko6znTo1DP9r4bgXNYvsbvMmqndkGBTb6FBIphLdxN5k8kPghg3G4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(7136999003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kX4/YK/t9Eu5X2lG9zDx/26wyoT2WJQCfOSUHTkqa3KFeMFJaOgT3fQ6egY+eV0KWCgnWKeO52YnHJkG1QY5gqfxiXK1jFaRrrUrw2XPyxwYN+19P6u3b0v2e+LtnwqTQE4zk2oZ4yclDEYlUvnww2K3v2tYSkHzQ0syFsiyGBmNRN6AMtbubO0tPHh12nGVflxbnlV7CMJ8xJ9bijjsWUSHz2Hl6Z+WVt/IEQKCFvPih/uG8Y+ZU2XxkZKBwrFalUHwngAa38AYIBq8+rntpJCZZ2vvFsUoOPe/FgWslEyMTILeN1BV+glhp5gjmUFnknqlSwn6ckdv4o7E18zINeG/CGQAa6muEhDMYhla/RZhEq67d48sdrI8hMxbfP9OPBl7ShoKZRNGPPQjLrIg27NxHXm/zWzStly4tZSnWm8hXsWfvWZDzu7jLzbxNM8G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 18:17:52.2300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fb1664-90db-4183-cc65-08ded8663b1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527

Hello Andrea,

On 7/2/2026 10:39 PM, Andrea Righi wrote:
> Never attempt to migrate migration-disabled tasks or tasks that can only
> run on a single CPU when switching donor's execution context, preventing
> task pinning violations.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3cc6fb1d20547..8a3eecc7caf5d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6936,6 +6936,20 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  			 */
>  			if (curr_in_chain)
>  				return proxy_resched_idle(rq);
> +			/*
> +			 * Tasks pinned to a single CPU (per-CPU kthreads via
> +			 * kthread_bind(), tasks under migrate_disable()) cannot
> +			 * be moved to @owner_cpu. proxy_migrate_task() uses

We only move it to donate the vruntime context. It is never actually
run there.

> +			 * __set_task_cpu() which would silently violate the
> +			 * pinning and leave the task to run on a CPU outside
> +			 * its cpus_ptr once it is unblocked. Deactivate it on

For the task to run as normal, p->is_blocked needs to be cleared. It is
only done in the wakeup path (and sometimes in find_proxy_task() if
the task is rq->curr) which ensures all the affinity / migrate disable
bits get fixed when the task gets to actually run.

Where / how is this being violated?

> +			 * this CPU; the owner running elsewhere will wake @p
> +			 * back up when the mutex becomes available.
> +			 */
> +			if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
> +				__clear_task_blocked_on(p, NULL);
> +				goto deactivate;
> +			}

Proxy depends on the ability to migrate the donor context to owner's
CPU without actually running the task. The task is superficially on
the CPU only to give it's runtime share to the lock owner. Feels like
you are tripping a shortcoming in ext core if this is a problem.

>  			goto migrate_task;
>  		}
>  

-- 
Thanks and Regards,
Prateek

