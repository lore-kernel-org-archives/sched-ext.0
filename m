Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793079972;
	b=QYS8vUvNcvS+j7k2O5Z12xoB0wiW73H886rdWqBwB+3Pi9skFG5f+tCJMp5WJ+Qbl/X5
	 mpPMtrV+qTU41OBtXuza0WUhIff6JvPMWXTPXRdJOac6EzsTooKCNyBztxs1GemYkw81E
	 DRcZCtg7Bc3oegTBjYi24wQgMrTyfe9rBZGkdGEj3R0NdCEDxtDZD2yJn3pj5UMCSGmRJ
	 zz+C96+V7Jqx8mFiS+cbls7XgGf9mHic0Z4DNq1t4MQh+VshMbXnlfu/EEGfYuWtDnMSI
	 7ZQwNGpge017ZNKrcl3uXUNjqGkdDl+t/hxtQzEdoIAA7WDVMR0KPt8+eK4bvjXSbcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079972;
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
	bh=0IUId8kqnrhHKHnczIMJrLOq5xkk1B0BWlxBhHimLgo=;
	b=0+bCZYxcp9NJQbMrjKyrHM5OJVlteebEwfU7W4DNTYSR6WkG5IGPPOEHTZOY7tX8oJd6
	 snCAOw4Z8ReOiTdqoussZF6UQtlt4v8TTa5271GHEIqrIEgUWRJzFt5V6mAWDdEpMOimL
	 L+sN2g2sg21DQra5teiO7SExq2jTHWTqiSIaxWMYSrItSq8UtOQmSmKeF/Vh+lSQgUcvF
	 UYk8RzVd0+DOWYT+/rPO9+Bow7H2hVGRcX7xLI3RqWtA858Pl4HLu2F1zCLgnq0xgk40y
	 ez5e2Wgc2sYfh/kwGgCQC7dRc8Am4lMrZwCY/ijE1yCrXU0wrUEn0rmDngoBH2r/UdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P5gtliSd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.66
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5F606A322
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 05:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12B5F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P5gtliSd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMyb6893zP2dAtf0eBVMu+P4/efrQXXvLELR9NYDruruDkSzjebB+mBLmV16JQvX5rGSySue/cfFAGps3JXMcARCnBsQGis3QaC7ra7KUTLKtgD1zn89PmLyqj2UkZdUHXDpNM0FhBip5H1MhNLFYbAtKeoGcJQx833CQHrM9ao7r4LznHXdsAZF8SbfYsFHOAXDyWEPqN1WocF+4hAY7dWWGWx72IbxKSuiy+2pSLCqRimb8fE3CdYL/D5H5hYlhBmUj0sTAIL3um/0EsM5wEHVz5rRgAH96qzLHmSXwfw9TPf2v2AJROdnIlObDRqeNB1Rb6ojorakK2ok/33mEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IUId8kqnrhHKHnczIMJrLOq5xkk1B0BWlxBhHimLgo=;
 b=TtbCcMoCCKuDwrHNDYWCusXHo34hpMCQ50YsxeEtwDpG2Q2cvooIB9GUNaVT4a6vCOwJsLb4MZEYtE93J8/bZ3HSvM0bpbr8OQevU2Bcra7djWXFdDHiUmAO3R8m3EAjz6YN85dE7MA2oltFt15Fn6QahRj41GVy7u4+BNVc1YihFstALdDeE9vTiyi0AI3fsbbf7wnFSx+5WV1WS1u0Y26Fl9pTwunRS1km5ymy1JHNwyJrRro3LHZKvzJZw2CLJvmjctnylOf20bozJYEbSXZeu878bNOzNZGEVd4/TnKHLwNKa//MA7RYjs6QgK0dT1s/D1LkItb39/x64gz8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IUId8kqnrhHKHnczIMJrLOq5xkk1B0BWlxBhHimLgo=;
 b=P5gtliSdK0jm5EbWiMDMynLoqIR/I0wbN8kD2e2iCkafDIAkYAzq8rmLD4mHDxuw18Ecmf9GE6jTw8gNjay7iLN+MN3inQr0NmvdBegBRIsptZsomZRd+tED7zUjz335v9aMxSsSJMEZEgpsoUVJ2El7dfQwyCWAkALRe+6f0K0=
Received: from CH2PR14CA0059.namprd14.prod.outlook.com (2603:10b6:610:56::39)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 05:46:06 +0000
Received: from CH01EPF000BE94D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::72) by CH2PR14CA0059.outlook.office365.com
 (2603:10b6:610:56::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 05:46:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94D.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 05:46:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 00:46:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 00:46:05 -0500
Received: from [10.136.43.232] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 00:45:59 -0500
Message-ID: <8464e356-d1d2-4aea-8702-40429c63bac1@amd.com>
Date: Tue, 27 Oct 2026 11:15:58 +0530
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
Subject: Re: [PATCH 2/6] sched/numa: Leave the placement of a BPF-scheduled
 task to its scheduler
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
 <20261027041536.3317971-3-arighi@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261027041536.3317971-3-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94D:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bf6eb0-de54-4ca3-d293-08df33ed9821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|82310400026|1800799024|376014|261026121527099003|11063799006|4143699003|56012099006|261022075727099003|261022105027099003|10067099003|18002099003|22082099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	txmvX8xYS8uMt3ZdWp6ehWba+eA2fCMrRK66/pauoxGFlobiKCVnPJVCrMgZEMX8Ah2Lt40ZLY595b4pc7MKZcNJlHCebR0fgG40c8bDurQGANA/BBLCE/dU3+ovkb3HkYlXY1p/xLWnEr57KbvG7VvT0v5E3FWhYjEIZcm0Af8GrM5Z9dhYX4aTC9JgGb5rbwHc/STH5kZMBLECMQzhBaH4fP+A9wrjGdSAolFmR+rV1jjvQDhG727x1v+CzBy1CDpxn6sPCFUEMQG8KyonicaD34005nTA5Rj7az7AO/okQfG/wiEtdfSydkEyBmeVz1mfXxraXB42CMaY3jRm/E3D8FTgCCCQqD/7R502bKZYEoOMpepy5ZpKVZM2wSlBDWgUpieayE477WGQEJ9m4Kc/+IarOXHUr/tfHuYnOz1fWXo9Sd96YmNGpMyuSUb3iDb84Mh8+sEy/rZI3r7dR0Kf172EoYRmh4xkdQU00gew1kd3mBbQfAN7LkVGUDwolqt+m8CgUhhuymBUpYEEvxOhHoWSXQpJUl/q8n5W2s519upOwnGCBpRShgPE9DXP5p5rBMK1TcoH7ATASZoerF1UNqM+K3Wh185gzB3UfUsK+mwazZsKHoMU54ua1Vm9Rr7IzHNAQR0F9xxZC2TIcjKC/cUTLmVuEpDzOWTyiic0unXh4rsfCEQ8J3rZPzhs4Y5W8FLkWGbrLOPqFoINNw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(82310400026)(1800799024)(376014)(261026121527099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yd7TZTRTgI0Golj5Wxbo7m8C6Amj/Yj/5l34xWGegkVSZkm6PjdHT9bhNmopX/a+50+4vJRWOts53wd9pnq6+PZjGwX1Wb3mZVUG9ZZxH/vukslpVShDhjR8kNanUn7A/kKC0tJDC5vnucnogydwAmTxm4pIYM5gwVWwjsR885SMKFnOoi0MuxxXl1QZJzCJGgmajUTnCucFjzxBQwALOEVt6dLb8pHieL0Eoyl+ZdrQtG78tXdnpmVFigym1rnY1Y8/kp4cePnqzwNiKgOL26yGvQZcRdRUhgVgBfPWmLNq4mXrlm7gALEsFjVCbpUAOVu4oQSmQVtkPhqqUzVOzrZO7uuyfs4rBnfB4ACfA+S0dyhFGbOEleqZTCNTnXOKnSBCMxHB6RIeuZzXxfFMKUiAjNJxDoAoQdTXNEFhYmkNuc3ZW3Mhtn/5HdR7wvkF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 05:46:06.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bf6eb0-de54-4ca3-d293-08df33ed9821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

Hello Andrea,

On 10/27/2026 9:43 AM, Andrea Righi wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 36df9a4dde534..5064c7b707f4d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3267,8 +3267,13 @@ static bool task_numa_compare(struct task_numa_env *env,
>  
>  	rcu_read_lock();
>  	cur = rcu_dereference_all(dst_rq->curr);
> +	/*
> +	 * Never pick a task under a BPF scheduler as the swap partner: its
> +	 * placement is left to that scheduler, see numa_migrate_preferred().
> +	 * Moving the faulting task alone to the destination is still allowed.
> +	 */
>  	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
> -		    !cur->mm))
> +		    !cur->mm || task_on_scx(cur)))

So if you are here, it must be from:

  task_numa_migrate()
    task_numa_find_cpu()
      task_numa_compare()

but task_on_scx(p) would skip this and it means a fair task is looking
for a swap candidate when scx running in partial mode right?

At that point, it feels fair class should be well within its rights to
call shots on the swap candidate even if it is an scx task.

If scx has a ops.set_numa() defined, it would have accumulated hinting
faults and the CPU it is running on is a wrong node anyways so the
migration shouldn't be bad in grand scheme of things. If ops.set_numa()
is not defined, then the scheduler doesn't care about NUMA placement
and it should be okay for a fair task to acquire that CPU.

>  		cur = NULL;
>  
>  	/*
> @@ -3645,6 +3650,14 @@ static void numa_migrate_preferred(struct task_struct *p)
>  	if (task_node(p) == p->numa_preferred_nid)
>  		return;
>  
> +	/*
> +	 * A task under a BPF scheduler is placed by that scheduler. Keep the
> +	 * statistics coming, which is what makes p->numa_preferred_nid worth
> +	 * reading, but leave the placement alone.
> +	 */
> +	if (task_on_scx(p))
> +		return;
> +

Restricting ext on this path seems fine.

>  	/* Otherwise, try migrate to a CPU on the preferred node */
>  	task_numa_migrate(p);
>  }

-- 
Thanks and Regards,
Prateek

