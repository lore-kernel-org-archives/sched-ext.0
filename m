Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5A302CC3
	for <sched-ext@lists.linux.dev>; Tue,  2 Sep 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814340; cv=fail; b=mdut45GsreWTjMdf5OVJW6E8/OZMn/4+Dfa2mby89HuhqHVe6C7G4Rd0lj1z9moAQqwjS76saL8bdOMm2rgHPk/ISj5EsIs9enGKr7g5wMEc3pgBSPV2ghtuDEK9f7R2eaQy2Bm8D5uAWPT41LGfJK7JQB0NjTGp/CELFgvn9gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814340; c=relaxed/simple;
	bh=KT/BdS5cldmtqw+rd0gJG6cchxW/oxgiqD+wfYNc++w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVrI/s18S8MANIyfH4BzQlnOP+r4AJWtLGhISEIa/i8nnp64d7jsY/+JBS7KzKJj5SHHDKcNfrjLcU8NiWrPbqdxgf+DDgfR1NxJLKjCi/obOvRTEaYGm3cZZBN/ad3cmiPU1y2SzSqp8sTrV/0uCR+0g0ttnnfRzodr0FIe/z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AnaT/se7; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AnaT/se7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoTr0n0aOrJXAvQNN38zlY5cnMx+Drkmm0dFhaUceqGyzJt0yT3iUdpPbsYAcZk4oN3gyDeI0doxURegcBN75n3Rh+D5O9oRsrDSWISaXmDbCO2/b8ske5YWVh3HL1+iWu1ICR8F32CTIpFCrByGfkYGZxKWbpIkt63ncfNMRVJcrkF6TmjEX0dZJEfBnRr78C9fseVw4p4YtC6KJm4LL9w1Du7+4dnWmD9Xa5UtDnDCoI/80NfoO+a3c0fZFZe/fBfE6P03bgLn/xAMLlTZCgIL+jeoQaS8JEmNiJfghn0cuKxmenwr4La3Faj4wqA7jyuUynXOY6WY2JpzuekyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gcbtCvCHQyO0mme+to3pBgypf7rmUsnu2G4bFkRPMc=;
 b=srFolcxJEUcRLN7xQjFQ/HDm0Q/m+GJJyKr5yimceIjmLlcJEFKJi4eSS59sIVeyHrgV+K16GHYnnf2p8kE//gD2umOPYa8mD+s1kFtS+FvbPaH/CM67HBnW2v3tZIg0ZtvL6VyIQS7H0gCVqsuw7EKGLX1k8UcXOtaJa9BquUJZEq+tC2OThD0TbZO1tV7j7YHg/UNQIvUgq+F4TDnq2xT1RQsMTZu+GKv4iLUbAHUWyvi+x8soRetr4W3B0325x2Z+pVobVXApROirf37134xR3ZQNqWjAD+qGRyBT/tuSATKHePrx43kjhrjky8RmTl6O5kpeyGU66v+eV5sQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gcbtCvCHQyO0mme+to3pBgypf7rmUsnu2G4bFkRPMc=;
 b=AnaT/se7ddP/WFoivfVmn7rkH6N/AjY49jqDtfJDJfAoPP/Kiv5jQARb50HgAW4nBTh3mJbodeDkyMvu7KhDRco6BJxTCVYYs7z7Qsj8q5RAPDMUfV8CYj+Gkk5P3QWi+GWLporqRP6K7RNGQyo7ibU0YllIQYIryP6/k8Dennr7C6ngJ1lG/CYg5L1rEfthdYr6qs2eaSVwJ4C8T7W8cSVCH0XsMSAKDs9i5VsGcx1aMlNeYpfZrfLEHtAKclUm8KU7RDpSqcFOnSDw4X9DCD5vKBdt8lSLCkQi5KXrIdNHeSkaraLbuIvr/uwY7A/wdfih+ihv+aRxRL4t/xyMHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 11:58:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:58:55 +0000
Date: Tue, 2 Sep 2025 13:58:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
Subject: Re: [PATCH v6 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Message-ID: <aLbb9ljZvAvghZa8@gpd4>
References: <20250902111143.2667154-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902111143.2667154-1-christian.loehle@arm.com>
X-ClientProxiedBy: ZR0P278CA0168.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b8d3e5-3000-4b14-0d20-08ddea181796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ndo9UXsCG4VWhh+A/F+2OjxWtZ0r+DVayvUWFkMUob24tIyxrl6hol85U5DB?=
 =?us-ascii?Q?UJzfLk5Srobz4lmyZ2xawbUx3G7dxO1bbT9v4Sw6mzC6rOO+BuyEFIVXRg3R?=
 =?us-ascii?Q?kmuCd285wKAiprT6Kxt5y5lpb/NJRMkWmBwrn/gaAKq6XJsIRu+gBxfpLiVl?=
 =?us-ascii?Q?0v6HYoNOF4lLtWM3Szhqxo5pEUeCuz7nzXn1VgDnW1Rrnaa+NUtWfaBU3UO9?=
 =?us-ascii?Q?NbzgW+NCEDK5Eer7yej5wtN4iCyM3dPRL6UqHG4GozAN4eFx7SwxYEzl+Vji?=
 =?us-ascii?Q?Yu/N4XPPqrJdANEIhlUglHX9RG5ejy69yjToUBT9nzdyCbXVokTXs0TmJCmo?=
 =?us-ascii?Q?rWywIyc7xjkYVA5jFloM7wU4BydoQLMZ96Nza/+Pc1pXM7fMN/M7hYSlkLjw?=
 =?us-ascii?Q?F7Ow5J7dMhtQifESRgq9gYl7HZt6sI0dp9YxMnZaJN4wRYfPA9tmyXyzjmMv?=
 =?us-ascii?Q?RdbcR/Dr1p6hHPSCajFA2PrnxRqy8IDLQuGDwU7iVXcV+rcX46WP9kVvJNlO?=
 =?us-ascii?Q?JL+8r6/iV2SKp2QCYG8or3lY6zffrynhcu1idAaMZyMdNHsjHdTQcmkWS2xp?=
 =?us-ascii?Q?LMMZnucT69yPucOMXEty5/h48K0l+ayU/7oh30wQqVX7hZYL33EbThEs7fSf?=
 =?us-ascii?Q?AcUwEvQDcuPok4xJScCgRS/axIpYqmhvDkyQZo51A5J2Enpu02NWiyimCiia?=
 =?us-ascii?Q?eF4grWSz6Te4GYm4/gnbVRevmQD3qgQeteWGGnP3m+1f0f21Y2e/xj4tsnBi?=
 =?us-ascii?Q?aNhWbOT37Ij9TLLQCnDgsAxqIUGpf5a0r1MNS8Y+d6sd60+sC1JyY6XJYPWa?=
 =?us-ascii?Q?1H46V9nL2GC6HKRyKhlO1GBmdiBrvagc8icuQEEhnI83eZhA9frtRd1AE1XG?=
 =?us-ascii?Q?h9P4+vrH54xEdxFvasDVIBm1OW376CeH23aYnM2CT0cr2iy7eCCYlnTr4kC6?=
 =?us-ascii?Q?tfrGXOC0USx0+ArHzEoPCzWKqKnkwhmUQ/d36OPPcpPWKTcBuVnQdk1TVBT6?=
 =?us-ascii?Q?ZzyvVqufxdfsj6oRAxFgRUaL/F7ou7jVBinnl9e+8pvuC2wFlhpYP5Nl0kej?=
 =?us-ascii?Q?tSHzikPEvLrInqmaesa3olvOpeFUZDML6E1h3473m5W54aCyZ5imgyvKnSGv?=
 =?us-ascii?Q?x+RcX2K18oiXoM9bp5p3XPQfqsJN5bmxAEZSbsN5FnDxEcnzt1H2XMSxXwg7?=
 =?us-ascii?Q?dM0a68PCPkx2gFW0AzrZ4X9bjhBgR96k5uY6mQ1Q5ILp/gT6WCwFHAxKvpO6?=
 =?us-ascii?Q?CIT0nrzf10DDuRoM/PcA4WlgS572JrfT1l9hexhV2U3BsZ73PTrktJkknI+H?=
 =?us-ascii?Q?b33JK6oUl2uKPbveDJc8gw6X3iGLRPZwrSZ1Z+LFNum0I6M2fCss8oUEkfAp?=
 =?us-ascii?Q?nXCr9HgPrPRFeBLDkDGoECXlekPtW7Z0JrZ6MbtCmcrGXdSmuMSyS6TxL2Sj?=
 =?us-ascii?Q?xMsooTydEK4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C6SoX1Ho+SpA+gzhjFFcEYlCJj7e3OcNTdJGxGSk11V9lD3MWxl5SXnU8nlh?=
 =?us-ascii?Q?irniy/Wr94TU++OvnawEVw2D+d++UkWx/wJTgsmwjAQh48+O0SXsFXuo0RYY?=
 =?us-ascii?Q?E89zy5GhoQJdQOy6HleQ1/wCR5gBkdz9eb8FXJmyfjTTzJl/fbd4hQzvHwgO?=
 =?us-ascii?Q?Img0M7Zieb/U0H/SwlDmeUJoHQwMRcwkMJX/eReOC4hTrZbu79lfhdlFbjvw?=
 =?us-ascii?Q?vgkr2CayaN7V/WUVXr/pirYaC9VW5ZMTxjxk6HjDWqmHkIm1efLijcgvkYid?=
 =?us-ascii?Q?JATwMCoZ5nHo+NnJ/2VGmlZoCL3ZIg1/6eptM9on7UprZ5RQJ42GB+Rsyfa+?=
 =?us-ascii?Q?F3ysZHvkJkkYLZQ/thKo3C5bZjXNfKrUpifD/tbvHSVT/Mov6WgkwKUQ1Aoj?=
 =?us-ascii?Q?h9YIbXIF5LMvF1e5+sS0KMwEt8UUA9Go7Qm0cbq6CjirRcQjf3ij0RRpadEl?=
 =?us-ascii?Q?gZF6oEfTSNqTLBvAmLSt/W1UHg3GCE7rM5BoRbzCRd0z0KHWIliOY2uvQIhO?=
 =?us-ascii?Q?WVBzsO+Rw7DZbLyIEPdx1d/BtU5nC5l0rHImp+x/+tgxJMJIx12I+PNCwJ30?=
 =?us-ascii?Q?WHTZY169EP6VdiH3IF0KeK0CFmT5/KnVWWpoOTRw3x7NC3iNwDY868bA3Coy?=
 =?us-ascii?Q?9yj0lsYJQBjp/bXPujTyAVVSqCieIBMf2yuNrGB2GcghXDz8TSvrWH/JoPBP?=
 =?us-ascii?Q?dJM8lE361LFVbdRfw0FveabQ+kDAXi/GktP6SMepscyP0+mNccVV91Ern+K6?=
 =?us-ascii?Q?h/BDN3if+pquqGtlVG9AcCUzTZdn0NDcwRsLKDhupcG823O8Vo0VOKwvqkG/?=
 =?us-ascii?Q?o9OJVBwTUw6ch5rSGpQJhohger8CyK/QodyXLtGITVYLujN2JpYoqMl5qFzX?=
 =?us-ascii?Q?dDqdpxZw2B+ifmoL0OtRiWWj6XuX9zWSyBVEreWJEPz2M0shoDGfh+bzt98w?=
 =?us-ascii?Q?4Vrv94Us+iEXO/vF1/HceTiOLXvJoZjGP27cEmRjmStkusNAV1TJXgVX7yPP?=
 =?us-ascii?Q?JQajugLAP6nkCQ2pmkfR57ZPz+I8reDxAafuZVLrWbR6sCf3O8pUs2S7LGC2?=
 =?us-ascii?Q?lKXeF/TIY6dyyeygMSHWQnNXNFYjtKQGFgeeVnYjdlEf868kTOSFxgCNmkRm?=
 =?us-ascii?Q?zEoQIWTuH87T3w6IBCa51cNNY0AWBcaPuKiQhOU+ZvZ47WDwjnFaVaLLn9Ci?=
 =?us-ascii?Q?RKiaxni1U8PlCskXCB2Coht9vuBQxSMKjUsOtSWNN9j6YqJqFxeMJPTBzgB/?=
 =?us-ascii?Q?nypqT9EfBmhrHTDt2lxYbZGOsx0t8uKN3L75s6ORb+stNS9VmcZ1XZEeNa/b?=
 =?us-ascii?Q?WZqu5MkDwrYq5opgcDALDOwdN3ltuxjZ1Q8PzIaP5qFRRCAS9++3lhV5pMkB?=
 =?us-ascii?Q?HYwkbOdktDHu8EzjvUmB1lWNLK6YCrBsNwE0Ebybt+ihHaVO4p3sznAVMGd0?=
 =?us-ascii?Q?Z+/Yhirb3dK6x6R7H08F0Dv4XJot5/05RVynt6EWGubQg6XccLveOKguj46r?=
 =?us-ascii?Q?GQkJ8l5Ry75JCLqKxpmTlxiF8NmbBfK13+WV34dqD85S0mkZIdY0znpIw/YE?=
 =?us-ascii?Q?ZF3Y/aCWXxZEt2HomKhHM9vDyl1aa7sHiGWNNV8G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b8d3e5-3000-4b14-0d20-08ddea181796
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:58:55.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMyBoei6NFrfGVvzw87q0ywP4mtSUA3IUvXGC1s4L+Yqx5BQB/hozEEKPc+uFOwKQM/MmwDUMMBcx8r5Gh/Fng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015

On Tue, Sep 02, 2025 at 12:11:40PM +0100, Christian Loehle wrote:
> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
> holding the associated rq.
> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
> So provide an alternative scx_bpf_remote_curr() that doesn't expose struct rq
> and provide a hardened scx_bpf_cpu_rq_locked() by ensuring we hold the rq lock.
> Add a deprecation warning to scx_bpf_cpu_rq() that mentions the two alternatives.
> 
> This also simplifies scx code from:
> 
> rq = scx_bpf_cpu_rq(cpu);
> if (!rq)
> 	return;
> p = rq->curr
> /* ... Do something with p */
> 
> into:
> 
> p = scx_bpf_remote_curr(cpu);
> /* ... Do something with p */

This looks good to me.

We should probably add a __COMPAT_scx_bpf_remote_curr() macro, so that the
BPF schedulers can be updated to use this new kfunc without breaking the
compatibility with older kernels, but we can do this later, I'll send a
follow-up patch. For now:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
