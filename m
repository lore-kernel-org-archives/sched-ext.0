Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A754438488
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237445; cv=fail; b=EQqgMJu6es2GcQnVUYPGqLoy5Mrg/5cJ1+DuluzSg6nLS9d19WgDAsVLgk5Vpa/aiJyu6K4J8L0RZ92D0/7xTfmDM3j9h3InzD52LW6gkvbxJzrXdaHrevGGLu1Dr+/aejNvJSRocaBtjmldMz4TfbBbgYjc/5eCcETadjMPqCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237445; c=relaxed/simple;
	bh=OPm6f0wY7A5sfaNsBCk80RuHdZSy3EJ8VhRUi4rtvOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kU4WGVfNdOXy4eDmszYmA/m1n6xXPYwmZJntbGValKJ5MVHo9h0E+QcdVw+LDSKZO5kw72ykHGUIVM7hHN7pSjqkEpWPjJp0kjvifNL2b8xy6sNhIoO6NhOc8m3na0a/VRZp8KAcFhE9j7e4M84gw+68YeAszQTLTDeMHeNHyxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f0FcINO5; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f0FcINO5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+TCD4gJTQ0Z7XiVCtRO6t87UQ/fEWR6U9zcDxkFHuIUd4NgC4cPbc9S4VVxn1DUwGuSCCxJAJaMdmepX0M1Kpp5a6bQUGU/eecuXI0MAicQFeIQexpGXevdnzpu/l8LHAmzVbdSdSjjRpaaTTthiqcfScmYnlvZE4rqpNXYChqAuAdNNgaPTV4rf2RAZDB9YGC7yl9ErvdnjWdnpGeo5A7QJjfJyrZscNIxDC88Du6bMciuLhIMceGU99r3YNt3Cm/rHK8P7sYHeBIQJ2/fk4OTgF42k4qVk/saG2Tk/Mb67F4FnfR+9wM8u5Vn7SuCrcMRGw20PU/2uIHOhcN4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RSjUp7cNuERSu4nbA+W9hgdw75GP1RroM7etfe4gc0=;
 b=FJjAAUCviqaSxh51UX0SDlCcVFTZ7pDHbfLetN6D38tPO0vn/LXth8ZisKn42A2uqi8wSanLqDSzR2T2uSZvDJjjYtOXxrff/U9w+5enwDtQS2dPiLNj0XDmzp5eiMDpp9GnGxcR38Wg5B/3SXp3G7DhDr97WgZ5JAMeOvnht+L9h2t/2oKMI3yw73k+aWp2d4bKuxFE3Uh4ddQwYchoO94Db9E6S4M9BTaGP2zrq4LwJ1ew4R1OkJMB86FochVR4XjZnD0RTgaFmy2pnfAszmUS1fq3NANG6iguOubLsSsSoKGIzu5pVZrs259kyMEHBy4zkNxgzRSti3uuwVU8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RSjUp7cNuERSu4nbA+W9hgdw75GP1RroM7etfe4gc0=;
 b=f0FcINO5qTNnlRY4ZH6L1vqTAA5hEfYBXmB4kfve2Sei3BqEaey+pTv2fB6V5+ABmfTPAVTyGApeQp4m6CT00asmC5qgOjG1MccTNr5Y59Klngq3PuMhJJ/s8UkCSj3LXugo5K0rOeTBvD3P6gjDIwG2jefBMVulFkmb4klFvBs=
Received: from SJ0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:a03:331::13)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 08:10:35 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::11) by SJ0PR03CA0068.outlook.office365.com
 (2603:10b6:a03:331::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 08:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 08:10:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 03:10:33 -0500
Received: from [10.136.33.35] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 03:10:28 -0500
Message-ID: <05319013-86e6-4a80-bb8f-385657cee410@amd.com>
Date: Thu, 24 Sep 2026 13:40:27 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v14 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
To: Peter Zijlstra <peterz@infradead.org>, Andrea Righi <arighi@nvidia.com>
CC: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Changwoo Min
	<changwoo@igalia.com>, John Stultz <jstultz@google.com>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Christian
 Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, Koba Ko
	<kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan
	<shuah@kernel.org>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260922165445.943315-1-arighi@nvidia.com>
 <20260924075237.GH2009045@noisy.programming.kicks-ass.net>
 <20260924075925.GE4121620@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260924075925.GE4121620@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3a9070-6c62-4fee-a56c-08df1a134f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|82310400026|36860700016|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	piAnvf/tXexQBo/dx0X8Mm2SoTFaiNMe++QQxQPIRvntRdyt1Lyn1x2RQb0qGvSYwgStyIG41gavn82hTUJ8rMMM8Ka8U8kZBE1VJm5mbxX9jDj8U6NAox2TgCU4eJRZXztW6H9yVxlkD+qK9O//KsE0BuYiVUb155vydqg5/bKAt+JnVCFnGw4uq4Kx/7d89ckAyGc63MXaBYDUzd6Y8N3ziiR5Ra33Dt+rUXDILu5tLXpgmhe9aI1QMGPjxGA+YYAOWA0KmywVpLGq8c6XncmlD9KEir0X8Mly0kINgyN4ReHTY6F06KNvZyM8DDA2ar72r2DfXAjjtMuLng9PbYasp5003r1scTnqy+VzqRRMY2hvkDT0qw1sAd1eIqRjyAzRaKGUo9zm+f0UwF5E0jZ3azSTxHiZIVL/6ZCB4ai602vgk11hrQASaiZ8O8r+8AQpcdsX4KcoFX4kEPiBRRngm2LVCTrPG+CncZXIQXUkHiyOr9A2nhh/M6p7hSiXzWSaTajKgiy/krk4pCDQ337ki20+7EmnNXpjuvf8f7osDyBP6+AA5zLImCKsJeGMBfbKtaV8VD9PpqwAiPqH0Z7/jjWKEd9VPs5uxFpGQJP/bHDneB64sODM84+t4raP3CxNmaYIoNVnNEbSWhs2KHgF5kG52qUwQxjR9MSsCEIK9+Sww8mmgaA7mXGC+ySI8slm/sEIo9WQyDJXuuTSOg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7jEplqX1jtWfUF7XvqjHcqze436Q8WePF1YofTPKDoxmFE3iZe5qQpi+7ZyqqstnQPZUNzIFnf28sx8IlEYJLWrZPngiRWI8XeqAaHdr9Zyw0oakoBQvwNOngO9dMp6Nio5vo0aGJcCwBZYDsawQFHaslVZ+QME4lgSjZFzIKP2Et68pVUz73N0kCw0guk1OFhnu4x0oDWRqANaup8Mbu8P9KSwxXqYNytsv+6fJqEAS7Lqep68Yc+v0Ftku5jDooDx55h7R1xc083rDHDlJ854gR3z7zt9qPoBU33RQCyqn9Ch8hrd73vXgPNskfejL40Mvcrf37Lq+OlroBMQ6xnnfDdLbbSC1e1nIdR4j/rvs0W9od0gbo2+C0N4BwmwhvndsF321ivF5bvCPVYTT7avzvtRpmM3vhKYN+p0GGnGj+1n8ZKi3bP9Sc1JUs+Wg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:10:34.2655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3a9070-6c62-4fee-a56c-08df1a134f18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

On 9/24/2026 1:29 PM, Peter Zijlstra wrote:
>>   Almost like switching_to_scx(), except it needs to change ctx->queued in case
>>   of p->is_blocked. Hence a new callback ran before sched_change_begin().
> 
> And I wonder, would something like so work?
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index adcc9264c0c6..3e7691d24930 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11215,8 +11215,13 @@ void sched_change_end(struct sched_change_ctx *ctx)
>  	 */
>  	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
>  
> -	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
> -		p->sched_class->switching_to(rq, p);
> +	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to) {
> +		bool block = p->sched_class->switching_to(rq, p);
> +		if (block && p->is_blocked) {

Shouldn't this also check for "ctx->queued"?

> +			block_task(rq, p, READ_ONCE(p->__state));

Otherwise we may block an already off rq task.

> +			ctx->queued = false;
> +		}
> +	}
>  
>  	if (ctx->queued)
>  		enqueue_task(rq, p, ctx->flags);
-- 
Thanks and Regards,
Prateek

