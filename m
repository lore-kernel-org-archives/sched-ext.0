Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7435200C
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017733; cv=fail; b=hAqpGKptbxa+Bhanw+eGHjCjxyuDoNTsZ9rnjR4rCfFHOfRQM6IDUK13VZ0LwUUYrVeyHu5Wq3xjcKpdRVTU0cedv2VSE1q49h/+mBjvTu+BQOFEwDZz3+oRwT4j0G2dz+2q+vAMRedSR1qkge7nIAVhRGfwngQPS3HjEqwII6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017733; c=relaxed/simple;
	bh=hJIv4JYCwLtpgedjBU6qZmdc+dbWoD2nCYkgxfNH6Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ngiS54y94Li9CsLSXh4YeRp5BRO9xySn8UlZhEA9AuZtMb1RDD3vp0JdLARTHJHPsw39J5/CPD13wiWWoZCAqMwAnx1V2GRV+mNYBA5aNKtCHncq43JXz7tMwujw0o5U0rSHhyQ5KJN2WjwC+Y8gdQfk8AMU+7rjYImRSIacETU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kN+Af3Mf; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kN+Af3Mf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvGJbcCeJTPr+y4D1jSxMtZnjCK2nzW62yRTUlqTseULRPcbVGJgGlrItRjv3nXlSpDKRbKBeZIFh6ZYpdDfDdHsjcTpJTXoHcxW7eoHqRiA8PItoyM5j2fL2jZWUOzV6seQXulZnOINTZUW8zeK5RWsyfPhRx/rFem8nsFTUowXwzqWbfX9Xtx6Q3N0bI9RGEz3uN+ltq+a8b6zXXKJwPO4qvnVmIE4UNE3gYz7CEtDzvUaKVJ5osaDVRZJ9WRfPQEx1iaNl4XS0sZMVRR7z3w3BDOo98vTjcfuDcwjr7+iDHnyPiev1rgx6ETFx40QBiCPxZOgLtvZe9XvBObkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkIBDS8gpsh9kgzIGAxAGJ3sBSBFYI0Hm31ANNSbpfA=;
 b=ssHnYxYTdccl6M7zbUx+8eMIwsVcScrH8ZIRwarHrObD6rLtsk+AlrT4I6144Fk46OCRC7+CO7cY5/xu3jPtSRohsRdMo+U1kBZrF5izqh8JMATZkYADPEm3p7drQH/Rph6KbBngODTbB+6+W4XyCL+ojoTAF64cHIVJs0V5a1Ns1mxr8IpPkF8tOiHHiZYwvfBQJTh1TOu/NXmV206QfkbZfkumhaWfpicd9J9UfnYVgvY2v/d5alV7i6clQW5B1dphoZ2XfsHDlfLZ2qexy9IqE5IITKF7Nx/NZSUHI6YIM8Jqmw9WOFSXGsiBaSALxivHELG2p7XYZh89KP7Ueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkIBDS8gpsh9kgzIGAxAGJ3sBSBFYI0Hm31ANNSbpfA=;
 b=kN+Af3MfbXJc2ZUA+XGa3N3PeY62FBROvdPuYJB+mt5UOreLJD3/vlSWazJwWcV7Ft385I/CCPW8Rk/fFzmaJyO4J/CwIL77HNj3LQtfw15hmt+6ge/R2BNPCNGI2CBCv2cHXTYxhrcaz2++FhuGTQmY8z8J1Xh1prqCKBRVk78=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 18:41:54 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::3f) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 18:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 18:41:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 13:41:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 13:41:52 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 13:41:46 -0500
Message-ID: <191a3d02-1dd0-4f74-a977-874678632b7d@amd.com>
Date: Fri, 3 Jul 2026 00:11:40 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] sched_ext: Delegate proxy donor admission to BPF
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
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-10-arighi@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260702171909.1994478-10-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: bac24e72-fc72-49e2-20cd-08ded8699646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|7416014|1800799024|36860700016|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/Pg6/Gdbu7XGVgIdPblLKQ/Ht0N9bocHKWCToIvhdwPIDmBjK9kdgHiM68kpsKJdUacVcLOvdmAK5HwmQUZJzsHivxokrPQtSmdU0zXVCPNIuLnXtj6shHGBvA5dr6Octkt+hXL+ndqZu1QLXJll98evPYOEfk8IAYgApy2jp/h7UcmBRk24MLYST9i31C8A8OvL9RBm0gdm7Sg/mfHHKdb/HiUsnIeNQFEKG9gT6C+ItP3YTjM32phKlA1ro5Pow+R8t7eO87c367+7vBtTvbH+t0uiupYIC1+jQfkTmdfmOlWz6y43GSsGfJLc9caLdAV312BMQZ6lELQqOpMTubv+uRU2Yc1j4bSTC971mMdB8KAAf2jibLCF8FqT6192PHFiAqorlO/5KePUb0zpi+iniqEIET5gN8rxx28iKaHgmcw/tIhK4apazRQJTGhXvy7+iVF0Py7Tw62ruk0ul+E/x39eDWlU2qIENVOZZjHcN3juzuPml5NMmSjouUNhqWb03udLmVyfnSxJvKX4V1VnczUf2RenP5pUPm/lFh1zQdtcXDVIrZJkr8mee/h8xSdr34qYq0sqgkOvKMXCr+l6wwcKwgKT8IvRvr9RHdwLaV1YuBm9eHc2jogkyEWz3XQubSM4ssQ3Vqd3wlNV4Q7Sout9R/P3Bre7yixB4WRG9F5BFNMq9eO+qGi0sdjWeWwR2tm9989KHNkLosMisA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(7416014)(1800799024)(36860700016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vqVRT09ttWf88DGdEMgxf6OsEfgyrfGebBi4T1Ty1kPi9D+R2NRGXg2+a3RIHAVGNLcv9S0R4b1wE8dSIjdZC/OfcyvY9XeEinZR7CLmlIIp5YwANUCCIibhL855vVdWxqAi9VI9WKxG6NFNqptZERjIcjGPh9w27x96ZknXnMGo8i2yx5T3OQozJf2LaRR6MQZL3ukWrYd86ydma1D4q+rAeLCoe6rsAGo5L+d5+tujGqwg9z0aiL9T5tk3704l2i+bTdKrT6Ch+oK92WC/81jmsKb1iwRYjojfZsH1yu3fqH91nSflICwx6oSj4ERYbS1GdhO033/tiN09f3ihg2nUv5ts8etL0lQLTK8oTsnh5OdGbf8g3jROOP9x3nLol59+tg3fcvqp+90CnckSRBm8MPhjt6LadwKtwYiIzpXL7Qb3F0DyVAYL15/bfUp9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 18:41:53.6196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac24e72-fc72-49e2-20cd-08ded8699646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277

Hello Andrea,

On 7/2/2026 10:39 PM, Andrea Righi wrote:
> @@ -7148,7 +7181,8 @@ static void __sched notrace __schedule(int sched_mode)
>  		 * task_is_blocked() will always be false).
>  		 */
>  		try_to_block_task(rq, prev, &prev_state,
> -				  !task_is_blocked(prev));
> +				  !task_is_blocked(prev) ||
> +				  !scx_allow_proxy_exec(prev));
>  		switch_count = &prev->nvcsw;
>  	}
>  
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index c48d043dbe58f..8ffbf857acd51 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -23,6 +23,14 @@
>  
>  DEFINE_RAW_SPINLOCK(scx_sched_lock);
>  
> +bool scx_allow_proxy_exec(const struct task_struct *p)
> +{
> +	if (!task_on_scx(p))
> +		return true;
> +
> +	return scx_task_sched(p)->ops.flags & SCX_OPS_ENQ_BLOCKED;
> +}
> +

What happens when we switch in a a sched-ext scheduler that
doesn't support proxy?

There would be a bunch proxy donors already preset at the time of the
scheduler loading but I don't see anything in the enable path that
would take care of those tasks by blocking them completely.

Is it handled elsewhere?

-- 
Thanks and Regards,
Prateek

