Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C303B42CD
	for <sched-ext@lists.linux.dev>; Mon, 20 Jul 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784529006; cv=fail; b=K5bnTYSvWnBADfzAXrTDVCPc30EdacIkgtwpn2Uv6qTWquwptozVipUwd0+A44LdUbroPfLmF/jOmFR/OB6UREnmmHzYz4inhwJmJPCrA0FTB1OuArvOSNkEU07cWjnFFCeR0Lpin/8NjGA25gp/X0zXymnygxWeWGVKItV2rRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784529006; c=relaxed/simple;
	bh=G/gsIBE/aNJwpUH7a2IpaRGpVPIeIjTV7BuV9S6rl4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hxZbFFcrgxPhJvluekbNrh67wnzN4kb04lZgZ59kch5pUAdF/o1pPG1dngl7/GdtYe4u87CLk0Uy8E4zwG2gUl9yUXSxxynlF4gG5rITBWpFZPJ8JFNtsg3eKHTyK5MlmTI3wVfEk3z6y/lYI5NKDHmalQKKtbD+C7BOtbwailM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RUiv1Y0v; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RUiv1Y0v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrVSjUyJeOHVTF9GSkEai+/2UCDb5ZZXO8ySv0jhi58Nb/47Cvk7QrxySH0K0Q9cjWwI9hYHlLzt30fMpsR/FUdZbLbSfzAOwGzl/R6qI+wj1CTwp0Xs0x52UTrz49o5YRIYzII0v+hidL+Vb4l9+eg7C46+Li463eT6I30uTYUzj0IYlFffTiv1UoWSyDreTWPBynkm1Cg3wSxpivpue2lCI0DJxaPeZVAPRAgQ31mhJNUUHvSEXCXBvJxRSOi9BScLWtcH+xLpjFDau/0ry+vYAGdxeufCrunESJ9YsrY3ubKN1kZWmmQYSoOlCICj6AYAZiPeJ8Fvz+Fwlg4SpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VP/Ceoq26iZQ80Iw6QdTRvKc2P2MCmEjZOtRj7vVdbE=;
 b=Ba/XTrGVUq8vanFy4MeTMtPMb6S1E6erTetN5ewUwVwBpPA4RFsEKvvCui5rqszmWv3sKxM8dPVB9f5xmEfcaASTovvFrf3yqT5yUO5NvciOf9ztOBN/62AYhLVMJjHPEwh/sD5CDyUunmCqJuIDAPgDtbGwFX16K7Fyj1cYwVzcF0BFoEA8Y53u1d5a9GyBzdoykP5MmeDlXVOSUz6pXT0sQS7VdNaTqcufWHiDuZ1bJS40R6KewrthGAplnQrFnMcwwPMsc50UeO88YVDhrVcbqo0ZaceSWoog9c+0KT8Epb+k3kEX0sabEhI9wZ95ASLBvXrC4pkTFSxyyj2EhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP/Ceoq26iZQ80Iw6QdTRvKc2P2MCmEjZOtRj7vVdbE=;
 b=RUiv1Y0vCUyh7PcC2dZCEOFTj+95WiH9S/1Qf8fCp31tT4j/s0mN0SpJGm34mQtVve8ye6ajD8O87urszG/tykMQvAKP1h/+CeHfmjQsrOU0wOQPUwSRvzFKgWgg1uaSD7YuydlKT56+g6AiSLZ6oF9be5ds7dPkhzttC3Su6rdiUn41jPGph1yl83PM8fT5a0JJS5Yvd6Sts5kwsY4FihEJS9XgBUF/+5HsZyQu1m2IMPJY44mzjIp2ESQWVfGcNLQl4ZNSkFsfEOQGqXqMZqfpeKForJRmJ4VQsSDFjHOn8I7JsIlKkIeJDjDPzIHyxJiHrAeisYP3E9O2Yu0W0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 20 Jul
 2026 06:29:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 06:29:57 +0000
Date: Mon, 20 Jul 2026 08:29:49 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: Rename the cid-form
 cgroup ops to cpuctl_*
Message-ID: <al3AXT4K6CuURSxE@gpd4>
References: <20260718101029.725350-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718101029.725350-1-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA1.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::450) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1d4e37-91d4-454c-0a8c-08dee6285199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	n08Jnb1d5UH6RbNKtCQcLYRS00F49WG9EFOhh3+e4o7/Th0n4YpfHtOrj3b84wY/LdfkUKglgFqBTJZRBlA/fhDC5GaQTz+sNMQCsERtfnLIgH1rK8VIza/XE4l7DfBN4R80PhX62Xrq3snK0mzJDOwzS3bUw630jGeIZeDsKNisq9ztGm5zDQFSqCsTbspONHPJfN2FeVFcZ5Jn6dzSrd0kdJ5pL5RSDV+2CBbdr6Ktb19d9yfN1aVgALs/1jQNRekfhds6HFko5T/1PAsBWsDQt5H0EqlHhtW87jcCJQawbj+kSprblmQeAHuG0eyW+jLR0h6cVxYuJ7OW88ROSZ+2c7GHKaRgiUZLVe8xMfO7YLVnRCkzJCuuEl7a5jsJO7uWVx92wxeJAZG3yCkKjqqJB3Mgp54XlJrBPtX7MmvFLg5SzuA4tyTTbyDz3xo2VeAHUeZ4jVYgziHhbGrlmZLrX4m3XKfvVfNLjJajvzocNbdqYtzJZu6MnaL4tNV45V/uwhekY8KilfL8wzS7/+XV3T7fLt6spAN+b4y5W+97jWvbOXDUQFjmDgseflp8pmRV0JcviDGvfVvqqEBKVUB87pXuHkxZKEPr4F3qfZ4mA6zte+FQl29bYbTiSVYd5WupsNpgPqQmu8QXoHt8x04EdjisyeC+0J5K+TRJFkw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zJzJXlsQ48XzGf8jKL9/2drduw1ebH+Ohm06HCGC7NbtWHVxOpMp/EV+DQTi?=
 =?us-ascii?Q?rnEbTCk2AZ3b3dqzRBwwptau6rgMyZh5PNxYZLvKGTnJPBsQUl5uMy9QUcXX?=
 =?us-ascii?Q?Qb7CxtYN7+iehAnmqu0tnDKOyLfial7UT1MxuClmjH8aDCwJI6Cqry+LvNwv?=
 =?us-ascii?Q?f51HY8eAa/aA+RYls/L9ce78djy4f3UOWhfEaydbDH3ZAt9qih68/9wDZ1eL?=
 =?us-ascii?Q?yMDoP9UuczGjfyYdZBiSVe1A4niChYZM0zHsOJ7OHtML/aGgQHjBsphGA9qS?=
 =?us-ascii?Q?E3rAZ+yw8e1ol4POP0r7fY0QHcMKGbtijRiCKW7P9c2ia5KvGph+QPD4di4s?=
 =?us-ascii?Q?/q4rADyKizqjjt5N/iGMP41OXEDM071yoQkVKPn+uy3b/xDcaSP8wCVWlwNm?=
 =?us-ascii?Q?wi/Qf13xdZn4/yGlly48c2jtqZotFTudql+gxnhvS+Cnco85R4Tb616qPcFw?=
 =?us-ascii?Q?p8cZGAgZHvVoSQzerjmg5GvldK184n9+wV84GJcrLkTZDferY8xshTq+g/cU?=
 =?us-ascii?Q?tccslTCFkdREienlzpR27lrdmMnUs8yM3nZxsasnxWhtB9+x2AJJKsvO94l8?=
 =?us-ascii?Q?qJZ1bIYus2Zg+5J2pQ+3qxa4Ko3Kl5YThUAJpTv18Ybt+bfVI8TaEoGEN46a?=
 =?us-ascii?Q?euODc99cLgp1ryHoqNbYZYuccfCRNYc4P6FAbsH4jnXktVAWm+mRVeFEqP1e?=
 =?us-ascii?Q?neCmD1S4G77EGH7rP+BjsLMyR/pvUvlnL77U0Go5ZOywTae9+e4y2VrIu3OI?=
 =?us-ascii?Q?WPJdoNIQYMHbhaTwrw+rf4F4KTVQ//E/8BhQ5FZjtA/kvTKgHaEFwpScnw4a?=
 =?us-ascii?Q?aZtsV6FJdt9XDj9Ky54Nzq+tQzlfHV9jIkIyBk+C78ZUWx57JHnXmfytrxWz?=
 =?us-ascii?Q?3bWmSP5iYSJ5v3m/bicQFJMrOUKzAwiMYdfPv2WbXNuRNiaU21LhLIEJKRPF?=
 =?us-ascii?Q?vGdVzmxGBi+1gvM/X7a6zcMDDUJBqjSM5ZGyACFzJVQBMmSjmXgHC+oZ/qrr?=
 =?us-ascii?Q?/fZCnmYVWZO3TommryjiMCB+S977SRL2NnMWWsx7ib2/Miy2kY3aSQV3D+wZ?=
 =?us-ascii?Q?LcRypMWOrE3JdWIuYBX760MjcEAm7Hx9+UzQtOXY3iysY5F5NyC8ruyjfzst?=
 =?us-ascii?Q?US9Q/UoHRHHMPcpaYBD0HI5pIkpHjbVgz/8+8YXtLd7rW7D3RXOesiRqro7b?=
 =?us-ascii?Q?I9izksB1J4nxSHNiwu/V/SrXU1uBRLZsRgLseH3QfeKnja2APSawQjLYJ6ol?=
 =?us-ascii?Q?5HAwBvYKnX2r9Mz6obgWArTP5GLADncPMrhqFdylXPchvXnw+UFfKfyCsVvV?=
 =?us-ascii?Q?hxwpL5XhEzUx0aCtiMPYjXADHhKMCXThMhQI/CftjrXiIGNnQOVkplaVD0Jo?=
 =?us-ascii?Q?xL58GMNDhDpq/fVlmmOtr5SzvkwUQ9yab4XX9qpgDwp57sOBq791zyw8fSls?=
 =?us-ascii?Q?MSrddOwW9hDcfmWawji0CYn1ylkyisy/zYTHAvj/OoYiDeSf+GHs3Vb/Qeiv?=
 =?us-ascii?Q?xycQJckr8qoR+IWZCPYLoIKcf18PHCtlAMnQWjIzcQZROPevg4RemTIWr9Yn?=
 =?us-ascii?Q?CwgiK09yP4yJtuMUkfKRof2o3bJEphXvHtFr8BMkPyMaDnkyK1XwWMvLX+vR?=
 =?us-ascii?Q?zOKcvKgilxi/ydEBeC7e8TSPUNwGG1l5qnncIOxbQHd9kYIf+h8qScY21ShF?=
 =?us-ascii?Q?FOHGtXRMGBlAYwjvXEsfAKttRDh+icXNtx9lSbBULdubdqHNgR9dEJ8xscZZ?=
 =?us-ascii?Q?dDyo6YszBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1d4e37-91d4-454c-0a8c-08dee6285199
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 06:29:57.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WfqHu47Y5dGIJtulRF9/OdsycVolbSsGB5B0ry+eCSC873GIHwjbmx0QnjWyDKdY7cFeYCHPACDv05gq3TGDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259

On Sat, Jul 18, 2026 at 12:10:27AM -1000, Tejun Heo wrote:
> Hello,
> 
> Two unrelated things go by "cgroup" in the cid form. Sub-schedulers attach
> to cgroups, and the cgroup_*() ops deliver cpu controller events. While the
> ops names suggest cgroup2 hierarchy, they actually operate on the cpu
> controller. The cid form has no users beyond scx_qmap yet, so rename the
> ops to cpuctl_* while the ABI can still change. The cpu form is deployed
> ABI and keeps the old names.

Conceptually it makes sense, cpuctl_* is a more precise terminology since these
callbacks report CPU-controller events.

This breaks existing CID-form schedulers, but I guess it's fine, since we don't
have any user of the CID-form API right now (except scx_qmap, which is in tree),
so we should be fine with that.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> 
> - 0001 factors the skeleton open path out of SCX_OPS_OPEN() and adds
>   SCX_OPS_CID_OPEN() so that cid-form skeletons don't depend on the
>   cpu-form member names dereferenced by the compat clears.
> 
> - 0002 renames the ops to cpuctl_* in struct sched_ext_ops_cid and updates
>   scx_qmap, the only cid-form scheduler.
> 
> Based on sched_ext/for-7.3 (7c2cd767705d) plus the cgroup migration
> patchset:
> 
>   https://lore.kernel.org/r/20260718081727.582037-1-tj@kernel.org
> 
> Tejun Heo (2):
>   tools/sched_ext: Add SCX_OPS_CID_OPEN for cid-form schedulers
>   sched_ext: Rename the cid-form cgroup ops to cpuctl_*
> 
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-cpuctl-rename
> 
>  kernel/sched/ext/ext.c               | 36 ++++++++++++++++++------------------
>  kernel/sched/ext/internal.h          | 25 ++++++++++++-------------
>  tools/sched_ext/include/scx/compat.h | 30 ++++++++++++++++++++++--------
>  tools/sched_ext/scx_qmap.bpf.c       | 22 +++++++++++-----------
>  tools/sched_ext/scx_qmap.c           |  4 ++--
>  tools/sched_ext/scx_qmap.h           |  2 +-
>  6 files changed, 66 insertions(+), 53 deletions(-)
> 
> --
> tejun
