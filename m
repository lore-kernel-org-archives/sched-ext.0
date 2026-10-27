Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793081556;
	b=OqW0Itx329ZIqoXXU1OBqq6du3TprmmXCa8U0Khm4MfMhk4kuG7Tpd+1pM6CRAPi4281
	 jkHLRAYvNJfaXDsp1NJHQ7XwwXiVb7hm5bVHwkt8yoWVCgcbYunTv+yPShW6PPU8BUpWy
	 Olin4LA+unabg7MIlBxPf+226t76gFhI08Jt5blz2KRuxvlvqHk5ZtwNKhk5UPZDDfZhA
	 YqP3WSubpxHB8XhohhLY3+IISu/VPF4R63f9boXX3Xkc+RdSqh6Fq0Rt6fqRUiw9xUPo6
	 KaPSyflwxe0JLhV5OW1be8zPLe0DrFz3ENRmyENr1/If3Z9yw48hOmhOZiMjv1I2REQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081556;
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
	bh=18bTafx5rbYmEZkRXuHhVkle3ipOmjLex2FtC4poVSw=;
	b=e1Rx7u6NcsPqj3MbR0bjh9MWhoIGgrc7P/hqdOhY3QODz/KGJcKDpyiqay2yxs4L/Ifx
	 kajJPFzj37vlcjjegaTO65JsnhsG7+nCk+jEaV0wDfCdEtMJD4adAWZRAVdHe/wdYm9/U
	 Ij+zJeL4PeeEe5JfJVWTIepc36SykRZEfzufekmR7A2NfJ0bD25QoUGDh0vlyeSuVzQxR
	 7LlXZaggjXd18KT6GRiicIgdC9gRfLt25UvfReltl9YGGBYdCiXjXFjQgM8eD16JE/kiw
	 u/NoOEvNzCp+CA5FtZ+RIQk7z8QmLR/nsMjOrumnGgsBrNkDI1V0jpkEijNAFJLbvKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KXYcUj66;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.31
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B106606A31B
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 06:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B106606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KXYcUj66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1syounYGRu+4o4LYU7b5kw5iu8NVwc3KUoHXpI5qlfP6C0gzAukQeM+SfbIczORFTouaM3t9gb99p6anc7ZDN7bWu+tmLoycOcdIzNiP8wkxlxuu9FS+/3eMFlYf+KycHl0zrXbz1pKj6epfgq6Ie7e7EQGuWhtjn5KMPPNRxyP4ViTGROjXCbftUEJWPTwtrFSlYVdKB8Hda2iyY+YCzTHTsWj4oc6Htj4oeqU4FiK7T8e/Wa80jSUYNb6FMoW5mL8l5cRoytahFCZQqxd5Ss5JkRt4wxI+yWjunBFooopGwjBL1D1dBcA89yy1QroPT9UdFdEJwXteH0pJd/jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18bTafx5rbYmEZkRXuHhVkle3ipOmjLex2FtC4poVSw=;
 b=MYq9riUo8EM6KauM8FCOmgf35tkp+QZXEXJ0hr35vHntZYujkgq20o3ALODX3T8o+dC5/2x1jjPJOXAsojYWyQLut3sAiFXPbag12Sq0AMFufW+licRA+Yg32gECK0GEWzjImiETUpwxMWEwZtnjNXQvwDHyv/BZy+AUudsBuNb+tV0fqwf8f52cX+myWfnKc16X2TmCT/ldHKbM2rn+SGHyvfMTY0AY8Ehw4iPWHGHsJ/SVEB4RDjockXNmhpjyvn0IfYjmqbJOrhYVB70+x23xBSIaArPKoxmfrbIr0L7IY01xfKZ07XrYMLU1Kdl9EAYS+95qzToTfYhxYq3grQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18bTafx5rbYmEZkRXuHhVkle3ipOmjLex2FtC4poVSw=;
 b=KXYcUj66N7iXP8JS5weu060jpw2S8Sg+oVT36ZLClgCFkBeXCh1gB9WH3kaZD/U9GyAPUrJu+kwM4JlmzK4vlPlasIHlinQlt/TDHXXWWOosc9SKAdpDuQ939A/dlt4LukKrXv1nNG7FTEX1M1aFJ1Hb8fBrMdNO+BrRHvmkai4=
Received: from SJ0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:a03:331::13)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:12:31 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::a4) by SJ0PR03CA0068.outlook.office365.com
 (2603:10b6:a03:331::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 27 Oct 2026 06:12:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 06:12:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 01:12:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 01:12:29 -0500
Received: from [10.136.43.232] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 01:12:23 -0500
Message-ID: <cf3e5585-128e-4ee3-9352-afbddbfd50c1@amd.com>
Date: Tue, 27 Oct 2026 11:42:22 +0530
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
Subject: Re: [PATCH 5/6] sched_ext: Add a kfunc to read a task's preferred
 NUMA node
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
 <20261027041536.3317971-6-arighi@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261027041536.3317971-6-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 1237160e-fe77-4f19-d06b-08df33f1487a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|23010399003|1800799024|261026121527099003|4143699003|5023799004|11063799006|56012099006|261021121427099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jyG4o8rgwMwbjXTnMwiP+nxAka/bvJ7M2eDAkQg+GRbHEAiLmJz1aUTp6xOIGqAEPsxwpzmzV9a8vMtUxD8sKDCvnEb1gNm/+bVNPk4WaFhAVLb7tdzSlnplSjLAZfGxlPgYQ5+YLSh3IZkOdcuKSNhgxkpS6J3Z/Ws3YjdIYJeQeIR8GWesaTPC+DO3RYXQEsHpQUfY106riz0hLXqMhhMACohEmPwdVABd9d4yU5dM08HHocjZzG3qCYdJvOVI4pp68UBHPVRhLs9JZ4hh5y4dZpWV5qT4okY4/DK1iGThEKdP3qm6aawL+4SkRTMHxRtW+9fIr4OYR3Fzgodc9oRSZPHQP5IV6thw+RxX/+h9RM9gaMkH18xzz8rq6pMhgPg9niBAVC2rNtLgqZs/jiVBAVTUX0BWbtVCQ7FMEXRuoOAiUyssMiOn78DaQhYfwUHpPIgz/BHwk7NAL9u6f5hLyjkOGcN+qUP5AhuNseW9rPgqeDRDkU/84EBy/BqU+v789kGWy6Jkd9BB5OQG9Xe/JWZEZMuf/sS8gystCQQo5IjjEVDTc4D25le4Po8/LeMFlfTYxZwQMNRtyPljgA7idSNI2VPXW6Uu7wbzgxQE0vhWCl8cI3ml3YeC3AdEdw1KaSPR3xSaD89IGhLMbW62xlWaAxhldPOBlaV0OSJ3MAufoHlU573u3kPiMx4v
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(261026121527099003)(4143699003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Da7DhH7onSfjvLvidxNzCYNtrEJpTyFjC4TZeJ8Xm+mdmMGP/tyubhHkm9raShc6aLBO03sxrStQP1p+jNitX6VFFWuJBRrieJFUz1EalXdp4ERl7zLAalA2XCFpqfVOPQNJnXJQSVG4IiLexYMXuFHL0VGxC/S7qJg6V5DS9TIO4rxPKy7gdxQ2LcNzNgOCVrAGdY8sGW9ItnRouT0VjRn4E1EBzpLIk8zmGHwWi6t4yGyD9PhOPOoLnddiNkQpg3Rn4MMp87v7KdpMFKHu59xxWeRUcgOjZcAPXiHryu2tjE0JKiEtDP9IPX1svOe/YLQE50BsSgd7F6/bv7DlS9BdNZdHEuOeoXjj/lMxJ6/KgzsUGTMHcQj+zLjUrJM9jakkhr9Rip3X70WV6TgqwBWlz08E8oynPqszd/vfI4AMCSK9KCi0dICU9ZS4rWaO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:12:30.4788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1237160e-fe77-4f19-d06b-08df33f1487a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417

Hello Andrea,

On 10/27/2026 9:43 AM, Andrea Righi wrote:
> +__bpf_kfunc s32 scx_bpf_task_numa_nid(const struct task_struct *p)
> +{
> +#ifdef CONFIG_NUMA_BALANCING
> +	if (task_on_scx(p)) {
> +		struct scx_sched *sch;
> +
> +		guard(rcu)();
> +		sch = scx_task_sched_rcu(p);
> +		if (!sch || !SCX_HAS_OP(sch, set_numa_node))
> +			return NUMA_NO_NODE;
> +	}
> +
> +	return READ_ONCE(p->numa_preferred_nid);

Would the ext scheduler need the raw numa_preferred_nid when
sched_numa_balancing is disabled?

It may just be pointing to some stale value if NUMA balancing
was disabled at runtime right?

> +#else
> +	return NUMA_NO_NODE;
> +#endif
> +}
> +
>  /**
>   * scx_bpf_locked_rq - Return the rq currently locked by SCX
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
> @@ -11836,6 +11877,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)

On a tangential note, scx_bpf_task_running() just does a
rcu_access_pointer() (resolves to a READ_ONCE()) and doesn't take a
rcu_read_lock() so does it really need KF_RCU?

>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_task_numa_nid, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, scx_bpf_cid_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)

-- 
Thanks and Regards,
Prateek

