Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793088190;
	b=1Qk0ycbQtiQYw1rG5pQLysRE5g9hoka4rXoyHyf4AJd3XeUOaU7fiGyvobDrW+TTGEy/
	 xG0rEBqeklm9N6o7bNWRTFpT0cpwrw3gucJ2xa6TEnBHG4HbDNkZmwT2syx4PIAyAFhwU
	 TgewS4mHBtgFrSU9Z9pSHiZSuiCzRmjxuh4hlCMBFUxn4F8pYDTpOThRCi2ZiGu3zQec5
	 nXRbSQoGFSWo4VGJkY4pgjtpagGQ7NW92WZPkIJhztq6xRqbZd3SnxWfRNZi+bh0fQCse
	 uu5pc3ksKsZBvPu2Agt1vzcO8eTVQSZH4YkVg+1P1J9CKO7g2LXLt9TM7qfPSpgUI3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088190;
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
	bh=bkmDQ6lkNSLuAb0BzKfG+TQA9PEwYXUGia2SoymG3dE=;
	b=Av9BDYOVNUH/daKo/cwHxNIBJUShpnBEIZK6ttJJQO1BKVQ7gycjBc4dE5rqASaUWkNW
	 66RfSijvp0zXAbPwNmjuGIpL2toNnZ92syZIbwO8qU+nG7qsisTWIlLtRfQOSc3+ldqNV
	 8hFn/8h+cFZIjgM/csphlUHZ0/KSA1i5Af60De5LQ5k2hfahqQul7DM0AiOsbmzlSVRzM
	 N1+DyhZ5wXTPLccHQ1SEozz9eUZ01x7T02vd2bamdpQWz18nd+oW/DIGW9OFxkMwUKN4s
	 AJLGYvCfZYXA06gOWGI8Dia1erE+5yqOei4dIUzzMIFmvRVpcghRm34DGsM/oqhDatQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H0ivI0yt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.7
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010007.outbound.protection.outlook.com [52.101.193.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF79606A31B
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 08:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DF79606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H0ivI0yt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZpmR59PPC+dh9kRGDaemj9DKmXkuBsNMjY+GF6ZHTVUAmT+pCCzm/MUgAXA+goP36m1KZeyDuvrqfHDBtn1OTpKedOfzk1win6dIwkVld181Ry8IYyDJ2p0l4GzVlIo9anAJCvPkhI/78U7dOG0OwcO2GBbDbiAxDzJvnjUa2bbqOm555l/VdXr2UXJkKkmmxKmEhURBdmkgutWqjZLrliFiVvpu6kxY5A0ByxZxF9Aa6X5F4+M605whrINXVeebex5cOLTxqw36aTrwK1dlAHNeOEIqbDNV2V9RwJApmQHfdFfuRL2l41HypJgvR3cDytcHVTijVG2pYc8iTV9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkmDQ6lkNSLuAb0BzKfG+TQA9PEwYXUGia2SoymG3dE=;
 b=Rf7wGGGA66y83EaK5gtW9g1bQpsC74FZctWr0uZCG43QCLzCGwJfw83+hhh+U196MGqq3Na76ZQ1xv24+4vjHOs7rANhGlC0xU1qVijqNsV1DUJ9pi5YlJFxeofQlsP5SO1jRB+pF/iOm79cb9Tytc8F3WhDLu1fOrV4MT0OJnyeJ4qojvvcfvCBVt/QdYmccr3vMOvzmwp/bnHY5FCPtR8D+5tVqxDZA65I9YpsKjdsdhBWUwu/f47AcYRGc5qgFOhePdb0nFjRn0GqY0hEXm+yDsPzS+XK8bdPxLGIlfx3Fmpc1un5WX2UgLtPU9SGG6QXeFgJLbt8SKkPVq9cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkmDQ6lkNSLuAb0BzKfG+TQA9PEwYXUGia2SoymG3dE=;
 b=H0ivI0ytB6kEZJRkGQC2jufk3+Y5V451GtOdYNcEW8rl+B+Peu4U5RcwF6/tkCtLnpOVHY/UVjImoJOux8VQZqolQjCITgvJvg8W/CcSiXtUw6tv+0xFSL2m/+XzxA9R01KLlzrwyfN1vBc8X2qzGrWV/NhZHs86B8MSVbGEqJk=
Received: from PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::25)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:03:02 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::75) by PH7P220CA0042.outlook.office365.com
 (2603:10b6:510:32b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 08:03:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 08:03:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 03:03:01 -0500
Received: from [10.136.43.232] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 03:02:55 -0500
Message-ID: <006b2a7f-ae4f-4622-87ed-de76d92847b6@amd.com>
Date: Tue, 27 Oct 2026 13:32:54 +0530
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
Subject: Re: [PATCH 3/6] sched/numa: Notify the scheduling class of preferred
 node changes
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
 <20261027041536.3317971-4-arighi@nvidia.com>
 <26d4c1d1-19dd-415e-beb4-05b7f34fecb3@amd.com> <auBF7UTiwNblg6Uc@gpd4>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <auBF7UTiwNblg6Uc@gpd4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf9bae5-2050-42b5-a574-08df3400b935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|261026121527099003|5023799004|4143699003|11063799006|56012099006|261022105027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Uo5iCtDVxDqd5H36mnbgh9gg7oTeafiwnKEmaNXOXitVCdBYyUDi+Lx3D+tmS5xfaJ94zEOBI2QM2pD03QfAtmUgyT98fqT6TOK5CbEAn12OnbTdmLy4M6PEG+VrT97xMjCir2Y23ZKQZSt8pTFoyQuqCAEG929/U4J61toZo9Cvkb2PqF7ew0jlj3T7UEnZTedcBVYocwS8G8+vEGidGTchC2Bv2f7EBSIJE25XuWL6UNe+qcomKoN74thpAUj0NadErLxbbNQbn0Quf6p5kDySL8sC8N7CGF9Lmhsa23B4lkUZplR+Y59OY3rfFkf8yQLBcgOGvEHAwwb9d5soJ1JM0MeOgGStqrL61ZmztbwG+hnurRPxi8wKzkJv8vvGOhUX97ggDoH55qUdx/dD/w7TC0PSBGU3qYSs4GaYVVorxUo2XacNskG0ZPgKwrY6M9ehzUf7M5bpaPom7yHb6v3ktihsVHrP6Gm0HlqR+RIPLZm+WPXTuzSuRko5k3NdzTznt1vOI9CXEh649/ZoaH0F2h+3lzJotC3HJfWx2bk6W0m3kSNdLgtlvfxO0+zLT4JLFbNW5BeTdJh/5zBk+/pcjBGb59dheau5btRojUBkRk1oG+ULkfPWMBadAPSHQBRfVvA6jEJbh1sFK916ViNJSvT76Lo4NzXheRCQ6+lAzAsTsnbYDgfFUnW74z8uPAJ0ycNfCmfKo9d/rwVBCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(261026121527099003)(5023799004)(4143699003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V0NFAtfjplA6t3ytGjVyBT8ovuIhZdV3DmcAwyRSvW7+eMeHHM0PaqbePoVS/DJzlDXxxsMZjAcfD3et5TnId4ZZ/QKsK1x4pc/RKlydt/nn17vgt8lnASHbr6EmcWKgh9qfzW+MtHbrPaIlrnt+ABwTgZIcDNgdoTRL+H18d6fAWTt3nC/3DF7e0cOzQdl9GSBTcxXUW+r+J5MMMOgl7WG6qnEEF121Erh1/JlNHKlyIeqmI4SbpSEUoLg1BMzieU1DBwGB35h8tRzHoE45Z9ckJkAy9hhQMGtponNX2RLyqPnLRWgdPIXrIeT3ZUIwq3svk868ExMWLzgNFCdHCMopRe93Ws7SDbvzjt/RmPBy+/mzPAlVa1cuerlYu8S2M5OgnuNuv2n6buB0z4c1W0iZmQdvOHZASZxXm8LdHfXueFvw7fXCdUYJTDiTD0ia
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:03:02.0836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf9bae5-2050-42b5-a574-08df3400b935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

Hello Andrea,

>> On 10/27/2026 9:43 AM, Andrea Righi wrote:
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -8331,8 +8331,13 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>>>  void sched_setnuma(struct task_struct *p, int nid)
>>>  {
>>>  	guard(task_rq_lock)(p);
>>> -	scoped_guard (sched_change, p, DEQUEUE_SAVE)
>>> +	scoped_guard (sched_change, p, DEQUEUE_SAVE) {
>>> +		bool changed = p->numa_preferred_nid != nid;
>>
>> Don't the callers of sched_setnuma() already check for this?
>>
>> Only one that doesn't is task_numa_migrate() but
>> numa_migrate_preferred() only calls it when
>> "task_node(p) == p->numa_preferred_nid" is false and "!sd "case resets
>> "p->numa_preferred_nid" to "task_node(p)" when the task cannot be
>> migrated.
>>
>> Afaict, "changed" is always true here. Is there a scenario that I might
>> be missing?
> 
> With the current callers it's always true for the tasks that can reach
> the callback.
> 
>  added the check just because ->numa_node_changed() is a generic
> sched_class callback and its contract is that it's invoked only when the
> preferred node actually changes. Checking it in sched_setnuma(), under
> the rq lock we're already holding, makes sure that the contract is
> honored independently of what the callers of sched_setnuma() are doing,
> now and in the future, instead of relying on each of them to check it.
> 
> That said, I don't have a strong opinion on that, if we prefer to keep
> sched_setnuma() minimal, I can drop the check and document that the
> callers must only invoke it on a change.

I too don't have a strong opinion but I'm all for smaller diffstat
whenever possible ;-)

Let us wait on Peter in case he would prefer to have the defensive
check. FWIW, I've been running a kernel with a:

  WARN_ON_ONCE(p->numa_preferred_nid == nid)

for a while and I haven't hit any warnings yet from sched_setnuma().

-- 
Thanks and Regards,
Prateek

"Program testing can be used to show the presence of bugs,
 but never to show their absence!" - Edsger W. Dijkstra
