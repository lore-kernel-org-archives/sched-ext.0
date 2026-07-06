Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F63328FD
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324188; cv=fail; b=ghWOQZhiot05Poo+2lTWzs+aJeQoGREghjgGUeu4focf6UA4CmaqQ1nsHFsb2LCRrgAWak38uQPixC5vM7CkP0C1yd79bsAC9vLstX83/CgpAeARWCVH2qHHJH9IO0Se+gkqDjc6ZyWqYvMDLONP9EeWkrhfeEkj1zAuqleX/yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324188; c=relaxed/simple;
	bh=mGiB6hv9Y6sR39MpuiC4IRXHaANfk79eg1loqfpB6XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BzmCLKNwEFUo+WSuI94gOvPMGzn0pNbzcxA8IG5jOoYb+9DhYVerK9Hh95SrI/LZ0zeyd0EN7RxusWar2chgPNkseBSLt49LAKnnjvmlsLALHJ0Lf2S7J0KClSZTFUgH3Y7hfRBILmpwkI2ae5tGdUF+tYJHOHi/FaMPmSLCwt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4LhszFO7; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4LhszFO7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCCyS7WVmeQV2qG/rTQspbGcvwFqma+iRihK5t486A/9FHD00dL6ehK5AcVG/uyqxwoFWlkCIZKIKEvAIqVVYTgdNogNcC+XDsbpRp2CueBrIG6fVU1IUkoClo2hrJjP13ZdqNwYI6kEUCG8AclPvimy0+PQF8eRU6KlrYrgKdh9Zlx4cs6M5B+6S5mGxqHFjBxDo3Gdxj9HVMoWyEeCB7UWTYSNL6AtmDdB+m8tKsSuMQ/mQGFfzr16hCsLyEkksM4AniZwjCc+3vcHpg34pib47X0ZZT934g1/PC7Cg+0FlXxSaGATVZ2AV6FxOa24FLlkp9HAnWX22bFk0SeuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAdFrOwWIcWrX2SPXH/fFvACur89QONM2G3KwpjE7yg=;
 b=rt2k3yZi4P0nbBH07PQgMwGZK1D0Qk9+GmLf2x/UNkBw566QjSd0c0q9UnLZv7tmTKtF5Z7w3ZJNCk+OzhJiXBCcIuODHZznZCpI5Qv2K68h4i9Ql7mXV3lBSSpKqkdDTIS9emnETdFn41J8gKnCzyqmDJyxwnMS3stGla4MN3Ahp7ZpHEVpfF9CFsKmnwghxT0v6fJC8qjwgNceeKRRvhnzNLXAgoLgA2Mv4GPAxMC50j6K5potMnbLg9cn5Y1QkI862qYeNRPooDgUbLHT1mFNjvsBmnZ3n7vSlol2NASxnX1ot7puAhbNy6kYSkupoEmTkQDStw8I6YOC1INQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAdFrOwWIcWrX2SPXH/fFvACur89QONM2G3KwpjE7yg=;
 b=4LhszFO7UQqlPEHj1gviFgzT7gbrXxQWTjjmTiagK8q42PfpzYnncRn9TeCYBA3Gmx91M5K3eJddikG3KtC0GqT16D6uArfdGqPaBrgmdfhvIiVqjSOABvhm0utJP54sxeSD+7tGZ1TPGRw0mei39xiX/aQGihNtoL9ivcSGNxI=
Received: from DS7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:3b8::16)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:49:34 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::1e) by DS7PR03CA0011.outlook.office365.com
 (2603:10b6:5:3b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 07:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 07:49:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 02:49:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 02:49:33 -0500
Received: from [10.136.39.91] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 02:49:27 -0500
Message-ID: <83348be4-ceb9-42fb-b818-c6499cc3bb1e@amd.com>
Date: Mon, 6 Jul 2026 13:19:21 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] sched_ext: Delegate proxy donor admission to BPF
 schedulers
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
References: <20260706070410.282826-1-arighi@nvidia.com>
 <20260706070410.282826-7-arighi@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260706070410.282826-7-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e817358-b96a-46c7-03af-08dedb331f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|7416014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZhyyuvMNwGiSld3IlREwb8PNsc6pdsaJ93+NgpztoGEoBPWHH0uCeQIXY2cxST6BcPsrp/0KBmaCD+vK9IOF/TnVai+1nbtZaLy3zzxj+R/WcrVA7gF5aWWxKHrjsH1C3IP0H711dvv1Y7y9htLP1kw32ly31R5sKwDcMvrwetbaV6UwDLdKL77zKb+3keNaKfhkgDSCl0vaQTEAo8HrL6xk9EqWO9GPc+7vDkxbouCSsuH3JgmCwNRW2qFyT+tfs0FzAlM5RvUMn7t+wFkfJxoOKLeFMnO88mOkd9+JJztU/AaVWYyBqQSYJYlAGHhUbmxTDZxKtrN+oyJhMzQuieqtmupVweLQqZH44kAa4RRewoSdVqamMei2a35N2v3J43m6sm1gZJEPUevtja64ctYobKt2I2lYnwrFfxufwn3pG2g9QU20tlmWNK/vLKSNhHQ8S7uIb2hRa5fV3wv5Dv2WfTvjqzNn/sob02xakYjYHDwUJTvfqDkWfJNT32E+QZ8TP0dE8SPUQ+8kEEahQX22KEMgfmUzg939Zx50P0UnIMImm6HB9XjT9cVs3LwvYDa/+A+i3rtiDar83xmKrxF7qndCzcI9MK2IWey35eZ7IiT1T1giKARaeFHeTa07IgpHWOBbMubjv6PbzBPhRENDD5jMbyM7Kz04uXlzzoSUgn5hEy+/kwVwZtxpOgMn//6gByNedJv0J79lxAzPCw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(7416014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S2BitbjrLhR+6RHEhZ6HtmOCmAihc/9k7WxaqlI0dT61dcK1+fSCMbJCdatRc1UR7d2vbIsBs62YvD5nyhfoEFFV1WqRRv/UFGFBX+tN04j2BxJi39XvwyF0hGeVU9vYRaKMIALTFNNTsmd67rLMnAxKRXQ94jp+xSRX4PgzUoJcUdiyt532yZiPTxnxahtHpaYMrr3jqUWyOyWa7R2BWoeFKv64iMGtKItip1FMFWzFPKn1Otf9i5Ual9pXKa2qJd+RGJRenXWuRw8TO2qjUql86jpNIBb2i3HC671AYktwNBKpjftHeSzfJKIllpmhaCsNgTQsPNZWwYMMtvs2Jzc3ytl4sBtTyADXXG7F4PCywAj6qo5qJ+5CUQD0Zwi2r+/NHxKU7Yb/cgSUDK/Fid1EcL8Sd3spxkOUkIykmjUtgAjujLPbeqYdl2Aef/yx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:49:34.5427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e817358-b96a-46c7-03af-08dedb331f30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523

Hello Andrea,

On 7/6/2026 12:21 PM, Andrea Righi wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0139cd4a8be7e..f3b6c3c952e69 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6764,6 +6764,28 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
>  	block_task(rq, donor, state);
>  }
>  
> +/*
> + * Remove a retained proxy donor before changing its scheduler ownership.
> + * The caller holds p->pi_lock, so p cannot wake and migrate after block_task()
> + * drops it from the runqueue.
> + */
> +void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
> +{
> +	unsigned long state = READ_ONCE(p->__state);
> +
> +	lockdep_assert_held(&p->pi_lock);
> +	lockdep_assert_rq_held(rq);
> +
> +	if (!task_is_blocked(p) || !task_on_rq_queued(p))

nit.

You may want to use p->is_blocked indicator for this which marks if the
task has gone beyond the blocking point in __schedule(). I'll ensure
we doesn't prematurely block task before here before it hits the
correct blocking point in __schedule().

> +		return;
> +	if (WARN_ON_ONCE(state == TASK_RUNNING))
> +		return;
> +
> +	if (task_current_donor(rq, p))
> +		proxy_resched_idle(rq);
> +	block_task(rq, p, state);
> +}
> +
>  static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
>  	__releases(__rq_lockp(rq))
>  {
> @@ -7006,6 +7028,39 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  	proxy_migrate_task(rq, rf, p, owner_cpu);
>  	return NULL;
>  }
> +
> +int task_proxy_cpu(struct task_struct *p)
> +{
> +	struct task_struct *owner;
> +	struct mutex *mutex;
> +	int owner_cpu;
> +
> +	if (!task_is_blocked(p))
> +		return -ENOENT;
> +

This entry check should also use p->is_blocked now. Before that, proxy
doesn't start for core.

> +	mutex = READ_ONCE(p->blocked_on);
> +	if (!mutex)
> +		return -ENOENT;
> +
> +	guard(raw_spinlock)(&mutex->wait_lock);
> +	guard(raw_spinlock)(&p->blocked_lock);
> +
> +	if (mutex != __get_task_blocked_on(p))
> +		return -EAGAIN;
> +
> +	owner = __mutex_owner(mutex);
> +	if (!owner)
> +		return -ENOENT;
> +	if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed)
> +		return -EAGAIN;

This probabaly warrants a different return code since you don't want to
keep retrying until the owner wakes up.

> +
> +	owner_cpu = task_cpu(owner);
> +	if (owner_cpu != task_cpu(p) &&
> +	    (p->nr_cpus_allowed == 1 || is_migration_disabled(p)))
> +		return -EOPNOTSUPP;

Do we need this? Proxy can work even if the owner is on a CPU where
the donor cannot run.

> +
> +	return owner_cpu;
> +}
>  #else /* SCHED_PROXY_EXEC */
>  static struct task_struct *
>  find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)

-- 
Thanks and Regards,
Prateek

