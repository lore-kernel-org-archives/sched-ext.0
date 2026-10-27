Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793079030;
	b=W6yZJBQQhvGriG4M8OGBTcWGK+W+AQmRZnhdwWXjo3jkGpsjFh9xwN3emNHoep8yEsmZ
	 S3dwitT7kjQxdI6bDhOBQAxSZG3g+w/3Lg/FpN7nQto5fQSiuRm78eTsWb/ViWQHhkv3/
	 LdnLg+/wXM+4MKCNqMMNIelOTf0F0tQFO6EfnmLnjaljb05UARWS7OzjB8emDZd4LAkoR
	 BF2dg6oifNpERNYuHKus4vRXTTEVHQmRy9FioU2tnyxEMmfsNPGUa7XPhDDgapqiiuiS0
	 qt7Vzdciruq/2ISBOK/l9B/kBOY5bZvf39ckln/8hfiS6VBJ3vsFv7APLv2Bo7PsFoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079030;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=ZzDHygYXrOKIJbl6puacNsd8dR5DBQW5HpxCkO1uSO0=;
	b=zQ8NGF8frTwHxTfyX/ie0uTKxMkQSbBcSIyRIyoMvLKrUAZW78pls6wWUnFGE2ueB7Tw
	 pL6qvvkcuhvwkXhywy0YeQlk33fa7va64xgsIVhF7MWr59/FFhtx6u31PTHzoUSZVXBed
	 YW/XnawjD2QnWMHjNcG+oic+hdmcaaTj6j9gft4yTIE4E5YXunCbEvpq6CHszpfdaiwHg
	 mqSSv8I+PCeLTbiL835v8tEMDQSfGuA/NbnzEad0YV0ozCh3rV2pA8eFWSNFfDC4QHCFz
	 3Rk0gnoz/zwItLM9nHjtRAa9h4YnBX9+wBy2dWeFOVvbOtMmk1tcZKjSukTqk7xLWBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eueuYFIc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.53
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED667606A31A
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 05:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED667606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eueuYFIc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Se6vAp2Mvbu1HVQprxqFJ5TJLOi0QGJ/GZADsviIXtdwtn4n3cP2/BAuxo7VkA9IvCisNbc6RroD+DqDW8njWG3z79L+PAZb1+auK3qwsbaoEsQXc2cdy3+7OcJp/jIEc5jMeT24trQXDHxjBXn4Pn4hty6s4AtWLXYrs1raXlI89SpM8fsVuSBzw+tE36DtPuU7QQk5gT+7cbspnv6DRcXSn+9sV50eJ0I/pbs80KQRwv0yJihaHXCBZwKc9kLEnpdJMOmZRev8pbqvIAnh22M2JTSdjUNPMmeNyF4H4iTYz5MyDuX1CMbWo0W0h2rVlMJkF0Z+2VtM/FDUImf4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzDHygYXrOKIJbl6puacNsd8dR5DBQW5HpxCkO1uSO0=;
 b=wUe8/c0ZS7I/JyrfItBmrlMK07zZfSvyvyV3n8uQ/QB6GFdMNwynD8gsLn5eO/aEOMXKwbeieHWVnonNNzH9N8QFrg7oX2omlHA3ZvKYGdpe1D1k5ZEopd0nJqvCRGDTxsEBV4llRzTqKrFBAs9HOaUevtGIzdr+faG5NOGdeHM4pKo8mwCAbpOd81XneFRc9L65cRHwnL4ArP3V1FIqH2YW6XWOtFBaY779oX1iNZwPRVxSeftzh6O36rkEtk/bSYw5R4KtK0iX3eH5Dw85VWUWxE5Ts1cNnsVmqGzCqrOa3mHKGueXA2nM4Kq3XAH3KPyWK3jAK4K7anARKjZs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzDHygYXrOKIJbl6puacNsd8dR5DBQW5HpxCkO1uSO0=;
 b=eueuYFIck59F1/06uL09itHxlCfEgTTBiRmMKUX36TqU+9NPwgglqvsDPtwoGCjDxjLhpbS1hCO086nGFjthkPD5Loly4wM/tN6XFI/xrFehbGxWO3Nx//g0G6q1HrRb4FD9Z39nWw9zx+mkT2ZO4tzuX5ZLYqn3/ZlcbgnoAJU=
Received: from BY5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:1d0::12)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 05:30:25 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::a7) by BY5PR04CA0002.outlook.office365.com
 (2603:10b6:a03:1d0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 05:30:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 05:30:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 00:30:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 00:30:24 -0500
Received: from [10.136.43.232] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 00:30:18 -0500
Message-ID: <26d4c1d1-19dd-415e-beb4-05b7f34fecb3@amd.com>
Date: Tue, 27 Oct 2026 11:00:17 +0530
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
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, David Vernet
	<void@manifault.com>, Changwoo Min <changwoo@igalia.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"Vladimir Vdovin" <deliran@verdict.gg>, Gregory Price <gourry@gourry.net>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>, Christian
 Loehle <christian.loehle@arm.com>, Balbir Singh <balbirs@nvidia.com>, Lee
 Trager <ltrager@nvidia.com>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-4-arighi@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261027041536.3317971-4-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 61433450-a38d-488d-cf0e-08df33eb6752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|23010399003|1800799024|261026121527099003|4143699003|11063799006|56012099006|261022105027099003|10067099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	9YyIJ0w74LySUSDr+hwAyE6YA1SOxeQFm7j+0d+o+jILMDxM1zijhIwoW6FXt4HOTRyVtq9HG02/7xwQQAIevRin/qs+RNNkwNfPgRXLNfyrrRLAzkUWzpi7VvYPRkVKwfqC4hA1hwiqGylHpV+GqQPLG/lQrHyemheYDjZA9xKIjFQq/OnX+wRgemjhH5c5a3V0jjREUByrwCIc4WOI3mWjeYBLPscs0HFXi1vHDfrIpLIEclKx1CfWbtypuJZeHGfYTUPqTf/ZWJ1y7VZLMvGq24SS0OdlFSvXfXER0qqMutGolHsKQ4TkLdFQ9RmTyFVk3MKpoepLxnFDb6A3WdUP7iyhqZ1YmmwdnV5AxlVUCxD2lWpcUSlN0p4oCMolHZSIsMVaThT0ndeBouGSDusVsoRV6wCujistELaXF0Y4+6aykyu0/XuR0EPYbRQTHjvOrOaIQ47njo17KkXyz7JqJgWkcS3zMS0ZlFR7ybonNealmNPD4ZlmOC+Crm/Gy2l/gSDZ/0G7bHpGeLyZkvYJ7G/6LjBTs/bFa5KV3zVA225YBC54LvsE7mSXp1EGEUzLVerKO99Hr1cTV5bJfXAXoGjy5vcwE8u+AmYhUs7DaZ0OkeD58sqW9qGwMUkiGKTT8s779/aNgJep/j0MqFwQymtTyfJCYcYivr4hIFgsyc+uQ8EZUmITCLUb0rYBzOteqJfeCrnSHfMcqtRmug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(261026121527099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(10067099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EMQo0IIV2X33WAx0MXeusBTRV6Am70P6pTCub2t5HdcwfC0r0mfMdfy1d95XifngDdMuDIBGxVKoAhO5RuKtfWBZQN+MDZOSk12eWP/J3x1HtcpVnHWCLnXa8XlZcWY1gEEWVqJy9D51E0dsT1irqV450FZSPBIb9sKbRzqQLzXkSJ3YeV1GXtWlcJMqwUFtk3GvZxl+QBYFeROxfg00hSMftkaCh8ZqaIlJ1t8knAqc8kNVQYJ3CU3bRP0Oo7bqE+RRsJ0MGHU6Mnt/Bx3a+P+h2eAz/NV26KzWwxITCbA8XJtxLYZjPWFVfjoh0tJFJrkgWmSdCTUESrmkhRv6mPzFcFgNPk7htmJmn5F0lAhx4gV8N9fB3ng57a+WdR4r2j69u2K2msuiAkGC4mpkyUsJC22I01UPJ7pb/5erLtToidg2/3o8FiXrqmmxDlEd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 05:30:25.2431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61433450-a38d-488d-cf0e-08df33eb6752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

Hello Andrea,

On 10/27/2026 9:43 AM, Andrea Righi wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8331,8 +8331,13 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>  void sched_setnuma(struct task_struct *p, int nid)
>  {
>  	guard(task_rq_lock)(p);
> -	scoped_guard (sched_change, p, DEQUEUE_SAVE)
> +	scoped_guard (sched_change, p, DEQUEUE_SAVE) {
> +		bool changed = p->numa_preferred_nid != nid;

Don't the callers of sched_setnuma() already check for this?

Only one that doesn't is task_numa_migrate() but
numa_migrate_preferred() only calls it when
"task_node(p) == p->numa_preferred_nid" is false and "!sd "case resets
"p->numa_preferred_nid" to "task_node(p)" when the task cannot be
migrated.

Afaict, "changed" is always true here. Is there a scenario that I might
be missing?

> +
>  		p->numa_preferred_nid = nid;
> +		if (changed && p->sched_class->numa_node_changed)
> +			p->sched_class->numa_node_changed(task_rq(p), p, nid);
> +	}
>  }
>  #endif /* CONFIG_NUMA_BALANCING */

-- 
Thanks and Regards,
Prateek

