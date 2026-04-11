Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4363909A4
	for <sched-ext@lists.linux.dev>; Sat, 11 Apr 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775919802; cv=fail; b=sqo4hpMxhFLJ1I8yx6gfHhgn1l5yiAVrjia387s7ggSvvXB++5n1RinmdZOFpEOMTkn5dQqXEG76Uluvq+5OE352qcySwcIn7nllrJ/J/i9kvzxmcjDujxyxiOO/d+oi3IujrJrS3h81V4BwzJNLO9wtC/4jQTAzqjg0cSe16GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775919802; c=relaxed/simple;
	bh=sG3w4x5R53yfaIlsgjj+4nuI5H3CLBAVOqF30KHZVeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZZlwX5zH1gqB5xet+7WE5Y3kVqSWQCnjBvz4xMIbC8/4Rw6Gfza1K70Lp+FtfwiFSgy22hUT9GlxGLOqSW8GzY5Nu2B/ZqAyeMtj6nLKUkApc/K9bTBaI5drokWikybjW7VjMGH4cfDTUhKCuwv/IbBOwday0YeKYBijJXRoUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lQXayy7O; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQXayy7O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9cuvFqRV7MA+3SBBqBG3Z/ZNPuxO/ZNFjmsn9KM+sCOVXiM+ESmfkDGeDyoMLH/z+GbFmwCTcGXeczOENUhQBCDgGMPrQHhGzP3eBADFT48ZEONGxWepMWZ51/7ephJKXGF3S2u89gwUVQ5WHMCElL56/d1QC1jmIJ0NqybIE2QgDzx+1yPfOq1uC1Fb+qjDLcDaITu1aidQuVte48ThIfnnAOqC+pQITmb+ATsKlsbRgS97J/ok90tpDTmDZN/fJxKKMfXVY9LTEqkUv1rB8Aw1gmxTcRFwIJZemAlEvWXbHEi0KpfwP24CA4JnyMDIZWZycPxYtrkhcZYt+Dglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N4QB0S/zhV+HkU8Ww7GT17gQQVVXlCqphxFM9Oaf/U=;
 b=jHk++8c/D8e3B/YIm/nAamJWrD1lflTAgHRN23x9gWOF670Ad2lD4KgTkLl+3il9QDtV7jzVWr6EbdM60IIHdKUmaz03+5vw/rl6AJWQKrDHYkDTjj0h40XaTM2zKJ2L3kkFkmi24Vj1hUrPXKRga01YTDkZAwePgvNwrA7xw1Jnv/u40ZZdGTFxUgIAYC78BrKm+458BaMPBIV1ZpUuEAAp0mHAvksfJlqGhRR4XM6XEE4iH7GqJPMr1CxyyM/DmZfmfIWfKUnzPH6k/EOnej3qgnJa+QmR8mYlTwKxW28y3iiAZN4W2hO57WIYEolmabQTFLXr7QN3dNgGZpgLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N4QB0S/zhV+HkU8Ww7GT17gQQVVXlCqphxFM9Oaf/U=;
 b=lQXayy7OTQ69t+uRtZElaxIMm4nFvl2qfjrzE5Ldwst5EIF4dVbEtR/6gGClFLa34FIUKjF2lRh2QppXozfSVWiOOkjHMktiGYmU5K72k2EyrL0rt3aWeEX8ckiDJEKusffESiGa7eZiiCAgWkDmy4MG+VbLHkKBmiJXWlvEse9qjCikMkbvhYr5CyjqcTx0+RpEAYwBAhoPpSiJBsxEfIJYnElLnaIp84A+H2yUIGwuBgwo27awetcor5a5tr4MX57tS4rysCbwycbh+g/6v16NwAxv+vAOagvquPZV5Uhy9lusUvuDubtLOOhk84fpIdp61bgqOGSNp9LGR4IBpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sat, 11 Apr
 2026 15:03:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Sat, 11 Apr 2026
 15:03:12 +0000
Date: Sat, 11 Apr 2026 17:03:04 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Kick idle CPU for
 pinned tasks in scx_qmap
Message-ID: <adpiqHmu8YrxBJ78@gpd4>
References: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ac364d-b6db-49dd-b92a-08de97db736c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	q9iD1t6bFsu+sTSF8vFmpmqJ7ZKwJtMXkeKt8uldwW1bOtCngV0bpgYtQ7NWkJcjiFmT9ZWzqSHbIZJNddBxcLJ+qQpstqQLaVwzIjAG53EfgebDx5B4j1E/izUFAkQEFHNpr2L+w8xeNIkgxOb+CVHhdlKrnGy4KsDoUqnn/k2N+5GVHFx0/4KfXL2ApzrFSea3M+7jGjc5VcFMN84EPuuMn36y0VGJstBjk6Mt6qA08gJAP805wIyc95uDIhPxbgtypgpGi0qdKjOJn6AnX2S6CaosK85Che9Xbof2E5Ep2lyncS3q4oKfC7SJfOGjB1EMy3si4POQP6lGoetyua7EQPy0MGatMX+E0LsL7q+BZ5wfAmjNXc5LCi+YjmqBcVmKfAapc6W+m+Vzyx/AUzPoR/YiqdcmYjmknCWHiH35lObPEA6mvn7eneLb6r2DFssICs/H4UP9VrKc9rXAPC89hxe4rxawgiCwzzrVpPz3oEsdXoqu2KxvIFSAjDr1tPGucAzpUXVH1BItEKqj2Jderd1hkN+EDOb1k3oS6rJNM7UTD1n8nxwE3tLy+XVmazIVXdCNfraVghxLbMie7H3XiXPmWAzTu2ZxXBnd0NpRd8sL5kBILFLnrQBmu17H69Czc8MQ+Dig/W6lLsH42EewyUDa+7zjTQ5c5/sXdFNtIuLknsgIbKbHo8Ai6LlsjEOwJH7UJmQvBJvFymCZDOj6cCf2oew7yBORsx3y7ik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UxGbJKrk9xFySkG1Osr5B84AUQ5/rMjN6zkgkSjJGiWNVp1o5uaxS6uRA7G8?=
 =?us-ascii?Q?u8QmFXqzuThmvpt77zRZSFbQVZsiZ+KrpXF5QHY1q3nWlfYy3I6x7XIguf6/?=
 =?us-ascii?Q?2yDbhyEZYva79yZipoZ0brdjIqu/038JF9wJ+Po3UMZAGktkhq3209ZCq24R?=
 =?us-ascii?Q?RoiYZzk9rhqD7agYki6nqSJc+3YNcw1i07tnu5Ohmkjq1UVgCXO0VKybbLMU?=
 =?us-ascii?Q?uI6zFDyegnmYmXlIomgLT2mZWCD/q8TaJ2nM704tVY09taNbVx4xdR3ATvlS?=
 =?us-ascii?Q?0KgX6X/2YCNSologVIIuKm/801mlpf/liiMKFRrttrQhtecWqYFnngMIwReL?=
 =?us-ascii?Q?NsIvxaVMoaDMrIPX37wwjcbIzSbhWuxOGTXppDPccskFoYvMBJWXi9LE/cNY?=
 =?us-ascii?Q?vCvAk2SzSPXhf/0P8Vj3g1o9smAigTOcGlSPzqzXGRX06jvOw8+R6UmQ8xqW?=
 =?us-ascii?Q?O6ckdxljKl/TLo9L41h1RacFAWws0Sl/l3QNn1j3oflcDOaE94xX8/EVIw15?=
 =?us-ascii?Q?IRCCMWuZRGOzgegfCuqDR9VS5cj5/wk3SZuqIiWFWcnJBb9fa+PCRIPiAr7S?=
 =?us-ascii?Q?4ivIUGgZcXxNMkcZ8p1PW27uzGEVie3sYZuTb1aIfjZc/uK/0yFNX82bLsJc?=
 =?us-ascii?Q?DDiwfrfm33dx8PSPfwBxJGRGUahbMGDasqLq1WLFsmlrIJNC3mLftCYWU4n6?=
 =?us-ascii?Q?CjAIzmvoJ9vH44P9hbo/GVMn+qDwOGkuwlyqh437HlAND0QpKRjViDIbIrSk?=
 =?us-ascii?Q?Jn9MrhGZRm8YVcJOS81XEI29DymbqldRA5ZUTeT/JtC6s0DIRrIJdT6p7smP?=
 =?us-ascii?Q?i0ZWD1Jl/Z89p7bjw6UXCCle6KzWyb/TLihExpfl+gMzOZ+mQoC8DxmNrslc?=
 =?us-ascii?Q?LFdMsuk221E/uPGYYReKZ/wnWmbls1nFEmQOwv8yuErbKzT0wy4Td1BPijzS?=
 =?us-ascii?Q?5CNw1apCcEAAQ+JZJ/FPXLIqx2LrNyGPYzCUQSo283FTuINNO2frG+HnTt6q?=
 =?us-ascii?Q?3mTKBDScGnJwNAFU5ef0PCLmq7IxRyDeODyHXSG8K0Hz076cjLfnVRih3s8b?=
 =?us-ascii?Q?L/OroqchCAq3U+J7s2/om0GD9spzbllCpns/1Ugap0ig1r58bauLABTAT+/r?=
 =?us-ascii?Q?FaPB6iIoANcwQip/9FQQtHbAgIHiUvTjSYA/JsOA8kqlDg6m/2nTd72hlrPV?=
 =?us-ascii?Q?E0G798IIrDfGI1bXpxl936o7T3cWCk5pZTKeSqa9ycd6tj1AvMY0ZIST1mKf?=
 =?us-ascii?Q?W+zBxar/D+ygHPuRF86ERuqER/XOQmEViUR9ufvPdQOuiFWp0WxdMLhIrrtz?=
 =?us-ascii?Q?WKLU0YqKMAPEKbjSbYKJ86SIJT6gypQ9D5gvnnNktG8U/cYdPpVMlPZnIctR?=
 =?us-ascii?Q?LKlgkYDaftWvsqutDJzfDUM+fuEQe45f2spurS0Y0FifRT/b3Cn6dQslgYKD?=
 =?us-ascii?Q?9yet1A6iiPQw62WDx3wHKFhVR7fmlBodQrQtX73OlYZg/V8i+oN/EncY9Z48?=
 =?us-ascii?Q?kUNif5/JtQUHwbeIhbBtB29pO2G31bqGRDiV33aEbCI4OLDu49vAYvuhQ3zK?=
 =?us-ascii?Q?/JK/weGz0Fz05qSxDVcsgWty6KKaxmw1ivR4i9qFU2Fltn9U42m2E2hnc2ao?=
 =?us-ascii?Q?DWT3een5Do3QLOl8Sqt5liZ6gPCChgJNSntkS2NB/7GJEwxFDQZi3bixRUt/?=
 =?us-ascii?Q?1gwRcpqfp9GrxKC++MH8HZ1J15JM3oZnz7H8x3Dvzk71PTSQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ac364d-b6db-49dd-b92a-08de97db736c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 15:03:12.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmyFkNqHBZ3MM+qz4tmaB9z/qgNodQPTalTqGuebDHFujGYObcghqYPoQXzcPKWzppWYVsPA+uAHyrB7hIYpPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611

Hi Tejun,

On Sat, Apr 11, 2026 at 01:33:56AM -1000, Tejun Heo wrote:
> scx_qmap uses global BPF queue maps for task dispatch. A task pinned to a
> single CPU can only be dispatched by its home CPU's ops.dispatch(), but an
> idle CPU won't call ops.dispatch() on its own. This leaves per-CPU kthreads
> like ksoftirqd stranded, causing NOHZ tick-stop warnings from pending
> softirqs.
> 
> Kick the target CPU with SCX_KICK_IDLE when enqueueing a pinned task.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/sched_ext/scx_qmap.bpf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index f3587fb709c9..09d1624fb869 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -314,6 +314,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
>  		__sync_fetch_and_add(&nr_highpri_queued, 1);
>  	}
>  	__sync_fetch_and_add(&nr_enqueued, 1);
> +
> +	/*
> +	 * Kick idle target CPU for pinned tasks. Without this, the CPU can
> +	 * idle while ksoftirqd is pending in the BPF queue, triggering NOHZ
> +	 * tick-stop warnings.
> +	 */
> +	if (p->nr_cpus_allowed == 1)
> +		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);

I think we should kick the task's CPU in general, also when
p->nr_cpus_allowed == N, with N < nr_cpus_ids, otherwise we can have the same
problem if one of the N allowed CPUs is never awakened. Moreover, tasks will
have a better chance to keep running on the same CPU, which is nice, unless we
want to limit the amount of CPU wakeups.

If we want to be fancy we could even do something like this:

if (!__COMPAT_is_enq_cpu_selected(enq_flags) && !scx_bpf_task_running(p))
    scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);

In practice: if ops.select_cpu() was called there's no reason to do the kick,
because it's supposed to be done already in ops.select_cpu(). Simiarly, if we've
a queued wakeup event, ops.select_cpu() was skipped, so we should explicitly
kick the CPU if the task was enqueued and it wasn't running already.

Thanks,
-Andrea
