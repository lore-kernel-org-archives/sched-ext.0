Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427E27AC57
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773902738; cv=fail; b=dHiydhOswz9RjE7UttyYnTISTlUH3gYZVDNNXN7ZyQ7ir54xWs1+3VYEHbv1UXlbso6JGOP5BfF2PLU9Rmxhwt7NVCu0EbDXqGW3ROjKbZiAbr1rK4WzEm3CNlRzG8OIlvENwlSdRzoTlKpwTS9CNRojLjRw280xEEmtIGakBAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773902738; c=relaxed/simple;
	bh=mZpGqwbuzarr1u8weep0Qkx4XgNcutaLA/33/BE7IeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FFLNMLjLDeafjO4xhK3JNC5cAWagM62/Tech/IvSVB/bpXt0CqD/ds1K2mLg0Lb3fAdkyCC4Xal0y+ARng1Z/VcgLQwGj2Y+Uddm1gVWOiGyF90nyLsrkJ+9x2YPAfBiE6B2PfJW/G/FyDpjXHKxkNuyNvZY0c2GyMRUtNJZZi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MtDg4NSM reason="signature verification failed"; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MtDg4NSM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHcZxrlVNMdXe/OHJhZP/1clANnKbYhH91GDKeLjAPrL759aClr0VbdYqQWZUCG18C0dQ/0MtkRIJazUKmi7i+AFTp491v9yTRwlYgF0YN10gUjHw8mFBLEjoGhl+OhZhJNkJyMuhHrDNy4VjvvkaFIq8Frsk/MQjgrDOTfRF71uI7d2ScR/VIUrAIudoY5TWcuIwfZOymFrnwVGm8lW0Hp9gY+cAxcUqmr6AN9/QrtRrhNAKh44TDdpojbcizHEoleooW2VFnF8SzokPNi+tQSx2gCBER9SzPnkgvc0uLEN2ZYwRuzr5+gJZr6tcAdgZHyZguGvInQTWOeNU2GB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqhhUxX3BmgZo5IRLzvBa2LPvhFY/azqTXkgDDcDL7k=;
 b=tTcY7zLkKrJSlbfbLInA+WEqbaLo2NeOpD9BS3PVDoS5GbvcyLyQkOTyD1P8kcW8R0/KOpuUQGq5qc1p0ijhHFZZj1mypY3sn+tlgkj10zu+RuYkLXu8jRZdPjJD6q6ff4Wjba/AcUxwprHBzr6XFwd2bhe+XEHnJGCvU+np8JB2MFGGDro4kOjz8st7rjqVLYodQvGZr4wArgm4v7oJlygfauQln5HgmeNFeQft+2+X8qOGTticTEdxxkXC6nwvpEJdc453WP+WYLJ2t4QuRL1zH54y7kDjHwqcAgu18uvooSvw1XMJh8PuYumd9XL691WUlUjlICPmi5z8DJRmIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqhhUxX3BmgZo5IRLzvBa2LPvhFY/azqTXkgDDcDL7k=;
 b=MtDg4NSMUsy9WsjKZhdO78oaWW0QWD2S6MyMH0jipXdryN8EeCRnevMaFhH8/VAoRJkedzPBFs3OYRyGp4OnS961KcSyNokXX3CJHX3fwQVZyW2fA/PxlS0Z1MmO3HCCFyR1sK1IgCSNa7oQLYQCbK2v6v8u+93P9NhMtGfYRAKILwGwMwFJoz6oXLvfQ+5BYcSwJJJDxysqOnv/emYfjHfK9LuEt3bvQeZehkzV+Fdz15CC+jW8/gze6VKu1kAz/WT6vuJTMe2zSANGhybiIK0JENjxPxdvhRjHPOL/SrrSJJDG7DkyM/UnhIh4Go0/nBzNQNDi1Dvz66xh1Gt23A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 06:45:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Thu, 19 Mar 2026
 06:45:33 +0000
Date: Thu, 19 Mar 2026 07:45:29 +0100
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
	void@manifault.com, changwoo@igalia.com, peterz@infradead.org,
	mingo@redhat.com, zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH 1/2] sched_ext: Documentation: Document events sysfs file
 and module parameters
Message-ID: <abubiaubvpc2GqNH@gpd4>
References: <20260319053026.447892-1-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319053026.447892-1-suzhidao@xiaomi.com>
X-ClientProxiedBy: ZR2P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bf3f85-22cc-42e6-55f9-08de85831e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Xysdv5hUFCnZ5YUNjQOeMqSioXDGymwegqgIY9lQ/cttN1KJ+Hkveu1cVIdeH+xfbAWSWemk4HGCIdyvGqd6/zxYuj8cQXmuPTqQqN+qIj2ojhGQhbgH8Ls8uFzsTKGgSyimjXSrHbgK1feOwDL+AxrwgjuIDVEnT88eUP3YfgHwd0YWLZV2zuHEsnYf5RC0X6Wfwunqg/+2uenA+hXtw6k/h+WazpaQYlWCSGeKeo8u/Fnpp+itRAeOuRXgiuJ3jCcyFLAmP0OL9nq/W05gUFfLPx2Guv+4OqH+JW42eY4cBhEVTe1JGuqgu7g/GhU/7AvhREFE3O7D9f5YCHWY0ZoTrxYdea+SOAzaCFMVKfeoVNtDsQekDYSPu4uLIbeMn2/3RC0fKVRybl8NmhXZmWlWiL27M2C6lUN9eZtDMx5iin0PXfbK1Ce4CQEDE86kS+9rYj5twKcC9V/cdHvAlAPPSfsvteU5nEISoYVOhTMw15Wn+4mATJc4wkevUEjfy6sJp7mvEYsyJ0vqmf2pnC0obM76IDjRW+Kc8wA2Y76HiCfP86B26+H3Ynp7mooSQkTHpM8pOKxRn1PNYTZwoTneau02Vz3WIm7+KmhuZDZ/DS4niMx/ozUuyezXLch2GpmAg2oYsKBJwJGpqytrb5kd0gvdI8axIMoJ8buAWBm1lb/FEGWcWWPjpSo1jFdynIk8z5pf+U4XENnWoGYPhWhQWaVko1mYJ0JD/hUSz28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?WOockMaL/bpTiaAeQMZphnhtzBOqxgeThviNtEKdzNwVNeT3WCS8/B6qMD?=
 =?iso-8859-1?Q?S13U1vgOgNo40zOJmAluJ4tUW8b3wU7/eqMQ/f1/dJQi3EsXU5tAk6OYds?=
 =?iso-8859-1?Q?XNNlHg3d54YSLuqqKogy2HgUb/Uj/5gxKpsvkavW8tCaVFSiPccC5p6OUw?=
 =?iso-8859-1?Q?UvWd3mCCelD4wv3BlB9NADYjMzVXhSdtGtA7vtK+1cj4QQPqdYWjrErviY?=
 =?iso-8859-1?Q?gbJ085MEeqfwMPeB1GFWXLhnfdpPHx3eiwf3nbW1nin4WkTrLsoV0HMavN?=
 =?iso-8859-1?Q?rMHdE9YfrqHevXqRJbEq7lRSRvcz3aCW43dy48OIXxdZ53i9D4sTwQXsuk?=
 =?iso-8859-1?Q?ZzVptoSscKWcLmfye2y0fFrRNaMH2rpJ/6UZUfXv6dtCGeKTsaSLWxaLWv?=
 =?iso-8859-1?Q?q4AK237b1AIaxzOndsiUoU/zhgHBO1GQ8M/YJrY1y2F5tuIKB3mVVBUOqF?=
 =?iso-8859-1?Q?wCYmWGFTnYqEXwkV46V0LDAYuBaBEZTmxIO9bf7eEEQENEQk325xy5QTeu?=
 =?iso-8859-1?Q?3MMl4c13liN+VPkIMcla5tvULTIDPMU0PgAQEnIUV23W6w5LvgsmGco6dH?=
 =?iso-8859-1?Q?rhayr+OyfjLEuN/SbEjpn4sr8Op4bHjJ3Q2065JIDNXo6o8IYXolLkWJ9f?=
 =?iso-8859-1?Q?c7JENiFX9NHWuqNv4x+9pNuVnUWp6vK/g+sKiQSdIuZ8SBReIWNDKj1ypv?=
 =?iso-8859-1?Q?XN+XzmvdwB0TW+j0uZxQN3dHcxdk3KlL5oWMwz7LbCINDoOzrDRVqCUzlQ?=
 =?iso-8859-1?Q?1lIFnW1BlRBRtDDqgG3OihAhw+Gly7Yz6SBs4sEaNINR2jH7QmvQi6AZBu?=
 =?iso-8859-1?Q?1s/Bh5i7btCUZejjxeAlmJQzBw6T8nbaYQisVTMtmk+wQbiHwTJWO1gKgZ?=
 =?iso-8859-1?Q?WWhHHCiUHtPm+fhVvzMob4XkZVlnSytkI9XovT2sLKH0W1JStfCTuuleF8?=
 =?iso-8859-1?Q?V4XMV4w01YzlXydtFTovUxxs1Yty2a58JhZx+nDNKHMwBXzpeOGEL52Wx7?=
 =?iso-8859-1?Q?n9f2SQM7hQWdEz1TXPT6TErOaShFqbm+QqvBwZVUfg4tLqRLvynHFjCg3E?=
 =?iso-8859-1?Q?TSZSViPSAza6ZENcYZL5IpMYZ0Zixhk1ebgLyHY2IZdOK/BgCTDydbyi34?=
 =?iso-8859-1?Q?QR+9+QTmhrSKJwSE8QbGqF2I1/RorvznMiVHRwG3pb3lifu/o37tiSdfQA?=
 =?iso-8859-1?Q?A1vpJZqurxLz9rBnVHFAsl0FdrM8hunkeU1l1501zwIeHTydtU73sT0sHt?=
 =?iso-8859-1?Q?dsdBbFRCUgf5ad47ZMDBtyLbpszSEoomkjIke2KsJlb3OlzXajEtaohGvh?=
 =?iso-8859-1?Q?q46OzsdX1RVXgdbtpaFyEwVrJlbie5KihQYvLCM9QUjMUiqqbK8ydKokbN?=
 =?iso-8859-1?Q?G+OVmZND8zcVbrwtL8f7/ix0akRaydaN1S8d1zHA5fgA80/RR6sBQJ7Q1A?=
 =?iso-8859-1?Q?oDjFp+G57ZZCd7GZTGHIacs9Jbo5q2B/8DL7oyJCW/cazVfusuqIl0+cDw?=
 =?iso-8859-1?Q?ucJG2GcXFXG/Of8zqYw568dAf8NbX1wfv0kaDKCl+JFTeGm+wz7hkvHkq+?=
 =?iso-8859-1?Q?e76XADxCPxzs9jfR6d3enSMcn43Ad+MTBZlFObhx/gEom2SXikioI3o5ln?=
 =?iso-8859-1?Q?o50yuXjwm8IaKpIKZQhGWuOhOo3M448Kpx1F+Ecu2lnqBd5HFiYKGD+kPx?=
 =?iso-8859-1?Q?gy86H6ZkdkXqdMRJtRCt7b4ERQR8d3/knMer/hlnhBDnMMcXq9drneHc7v?=
 =?iso-8859-1?Q?mc9b5+R/XCZi0jcm/H1/IKLvGnptZxnqRTS2ZAkKRoY3Ci?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bf3f85-22cc-42e6-55f9-08de85831e9c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 06:45:33.7584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcWnC972hhC7d8HGo03krJjEthHM1qpbgzRDgnFuXdr3xkbVDl+nFRKuUJmaBGvj4i+Vq5iYv8IuST8M2b3VRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647

Hi,

On Thu, Mar 19, 2026 at 01:30:25PM +0800, zhidao su wrote:
> Two categories of sched_ext diagnostics are currently undocumented:
> 
> 1. Per-scheduler events sysfs file
>    Each active BPF scheduler exposes a set of diagnostic counters at
>    /sys/kernel/sched_ext/<name>/events.  These counters are defined
>    (with detailed comments) in kernel/sched/ext_internal.h but have
>    no corresponding documentation in sched-ext.rst.  BPF scheduler
>    developers must read kernel source to understand what each counter
>    means.
> 
>    Add a description of the events file, an example of its output, and
>    a brief explanation of every counter.
> 
> 2. Module parameters
>    kernel/sched/ext.c registers two parameters under the sched_ext.
>    prefix (slice_bypass_us, bypass_lb_intv_us) via module_param_cb()
>    with MODULE_PARM_DESC() strings, but sched-ext.rst makes no mention
>    of them.  Users who need to tune bypass-mode behavior have no
>    in-tree documentation to consult.
> 
>    Add a "Module Parameters" section documenting both knobs: their
>    default values, valid ranges (taken from the set_*() validators in
>    ext.c), and the note from the source that they are primarily for
>    debugging.
> 
> No functional changes.
> 
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>

Thanks for documenting this. Comments below.

> ---
>  Documentation/scheduler/sched-ext.rst | 68 +++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index f4f7d8f4f9e4..6fc7e720a956 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -93,6 +93,55 @@ scheduler has been loaded):
>      # cat /sys/kernel/sched_ext/enable_seq
>      1
>  
> +Each running scheduler also exposes a per-scheduler ``events`` file under
> +``/sys/kernel/sched_ext/<scheduler-name>/events`` that tracks diagnostic

The right path is /sys/kernel/sched_ext/root/events. And now that we have
sub-schedulers it's probably worth mentioning that sub-scheduler events
file is located at /sys/kernel/sched_ext/root/sub/sub-<cgroup_id>/events.

> +counters. Each counter occupies one ``name value`` line:
> +
> +.. code-block:: none
> +
> +    # cat /sys/kernel/sched_ext/simple/events
> +    SCX_EV_SELECT_CPU_FALLBACK 0
> +    SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE 0
> +    SCX_EV_DISPATCH_KEEP_LAST 123
> +    SCX_EV_ENQ_SKIP_EXITING 0
> +    SCX_EV_ENQ_SKIP_MIGRATION_DISABLED 0
> +    SCX_EV_REENQ_IMMED 0
> +    SCX_EV_REENQ_LOCAL_REPEAT 0
> +    SCX_EV_REFILL_SLICE_DFL 456789
> +    SCX_EV_BYPASS_DURATION 0
> +    SCX_EV_BYPASS_DISPATCH 0
> +    SCX_EV_BYPASS_ACTIVATE 0
> +    SCX_EV_INSERT_NOT_OWNED 0
> +    SCX_EV_SUB_BYPASS_DISPATCH 0
> +
> +The counters are described in ``kernel/sched/ext_internal.h``; briefly:
> +
> +* ``SCX_EV_SELECT_CPU_FALLBACK``: ops.select_cpu() returned a CPU unusable by
> +  the task and the core scheduler silently picked a fallback CPU.
> +* ``SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE``: a local-DSQ dispatch was redirected
> +  to the global DSQ because the target CPU went offline.
> +* ``SCX_EV_DISPATCH_KEEP_LAST``: a task continued running because no other
> +  task was available (only when ``SCX_OPS_ENQ_LAST`` is not set).
> +* ``SCX_EV_ENQ_SKIP_EXITING``: an exiting task was dispatched to the local DSQ
> +  directly, bypassing ops.enqueue() (only when ``SCX_OPS_ENQ_EXITING`` is not set).
> +* ``SCX_EV_ENQ_SKIP_MIGRATION_DISABLED``: a migration-disabled task was
> +  dispatched to its local DSQ directly (only when
> +  ``SCX_OPS_ENQ_MIGRATION_DISABLED`` is not set).
> +* ``SCX_EV_REENQ_IMMED``: a task dispatched with ``SCX_ENQ_IMMED`` was
> +  re-enqueued because the target CPU was not available for immediate execution.
> +* ``SCX_EV_REENQ_LOCAL_REPEAT``: a reenqueue of the local DSQ triggered
> +  another reenqueue; recurring counts indicate incorrect ``SCX_ENQ_REENQ``
> +  handling in the BPF scheduler.
> +* ``SCX_EV_REFILL_SLICE_DFL``: a task's time slice was refilled with the
> +  default value (``SCX_SLICE_DFL``).
> +* ``SCX_EV_BYPASS_DURATION``: total nanoseconds spent in bypass mode.
> +* ``SCX_EV_BYPASS_DISPATCH``: number of tasks dispatched while in bypass mode.
> +* ``SCX_EV_BYPASS_ACTIVATE``: number of times bypass mode was activated.
> +* ``SCX_EV_INSERT_NOT_OWNED``: attempted to insert a task into a DSQ not owned
> +  by this scheduler; such attempts are silently ignored.
> +* ``SCX_EV_SUB_BYPASS_DISPATCH``: tasks dispatched from sub-scheduler bypass
> +  DSQs (only relevant with ``CONFIG_EXT_SUB_SCHED``).
> +
>  ``tools/sched_ext/scx_show_state.py`` is a drgn script which shows more
>  detailed information:
>  
> @@ -441,6 +490,25 @@ Where to Look
>      scheduling. Tasks with CPU affinity are direct-dispatched in FIFO order;
>      all others are scheduled in user space by a simple vruntime scheduler.
>  
> +Module Parameters
> +=================
> +
> +sched_ext exposes two module parameters under the ``sched_ext.`` prefix that

Maybe ``sched_ext.`` namespace?

> +control bypass-mode behaviour. These knobs are primarily for debugging; there
> +is usually no reason to change them during normal operation. They can be read
> +and written at runtime (mode 0600) via
> +``/sys/module/sched_ext/parameters/``.
> +
> +``sched_ext.slice_bypass_us`` (default: 5000 µs)
> +    The time slice assigned to all tasks when the scheduler is in bypass mode,
> +    i.e. during BPF scheduler load, unload, and error recovery. Valid range is
> +    100 µs to 100 ms.
> +
> +``sched_ext.bypass_lb_intv_us`` (default: 500000 µs)
> +    The interval at which the bypass-mode load balancer redistributes tasks
> +    across CPUs. Set to 0 to disable load balancing during bypass mode. Valid
> +    range is 0 to 10 s.
> +
>  ABI Instability
>  ===============
>  
> -- 
> 2.43.0
> 

Thanks,
-Andrea
