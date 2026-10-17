Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070ED3CF692
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792231980; cv=fail; b=nH4V26KcaALgva8EGIgFQo90eoeoD8SypexX333l8sOgBGxAip5s1+nl7KliAxBRVGySVlc5/IoirMGB+Dk3Bbsrbphn3teftB6NC/eeN3znvZ3O4xDu9SzL+lsR+FBljFKH9nJPybl6uF8WmT2HXkKR+0IyWsLkE6IWiGHcNLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792231980; c=relaxed/simple;
	bh=qKdgZuXhxxA80KyUja0UvoJ8rJ9uUfRD6tlNTbxxS/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LtZ7T3lDUhGojnAnb05VSsHXXj+nZa/ciBjFx2qT/2+WgBCjuDPx6XquAlubhagwFnPGGIhFuyhm5EgB1mQtBm+0iijnKwr1xSPXhnf0XDAeD4nLOAX/gY3u7zlcH8NfF3T/Z+gxb1cw88QonFXQOSNP/buwaph2eKjH1ZmCyfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R9GZmhuK; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R9GZmhuK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc3KMQW42gzkdSB0T5xjLZigGhP8pz36o2Hj+J8PU5So0N/IWivJO24/szHjEK+hPiBANerKlS15K1hDIljlfiKK/zG1Jwz5GnuqPSvWxan3rpBnzJrbwhOsnkBQvJhE7zFtP78YC/cjLfYzZvXAAYTJC1nWYVWWCF3rKZczuX9aMZp/pCI/dEzl8SQwv9iIfyyauA+iuEqjwRzav8psabguJVeUhFrh0paXQ0j1IKpcUceM89sk1wQzGH3NtFpTr00omAB4kNv81D5W5SHkSagg7PDDtkHWfpewRc61H/MUwxsYHW3TFCsNFtWq2BbuaAZ0csFCVh292LPaCJkWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/oeaDAqXuZ9br23fW+oOI5zC/Uw8qK6mSW7SbVSloY=;
 b=wi/JVrnssCW9wz5gaeKbXZtFvBIscOUgbZN5iawKcrzJS1Vfs8873cuXZgx1A6E7SCu7CAkuMeKRK1zLG7Ya3RdBnNgWY3hjqWbensCCFpbR9SOQx3WuTU8L31zomoOb0wepXsBofyrtXuQnc8RFsyrvDmfT/l8Tj4aaeLXq4/hywMsWMbj50R6UPmZOhHxXEj9w1QrZh69GYAYBbh6pQbunn/jwILm4bwTVrcUac1aWvYKKPJwcM8DPsRiLy1+up4syNEpwIDhdPpD04RCD2Zf0W+JoHxVxapnQqZn3/RlWbwxlx5RYrvN3yS8P+u12u3Qv0r7U2qt3k2u1YI6GkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/oeaDAqXuZ9br23fW+oOI5zC/Uw8qK6mSW7SbVSloY=;
 b=R9GZmhuK91e0ZIgYJlXpjJa+O+qpqfgcVv8a7qYf4Iv3NGDfuydJ/A7BcMwBSUO1Wtx9k6q9wuFi2ubO02AM9DgRw64otEnF42c3yBH5i3t/TydTo193JiLlvzDHFWDtudBDqiQZftglf1RdYVtq4iDa8evvZRwVZG4Ks8hg8OTUWSHSDcF6OFbbsptO7fJ1Wu6VSTexvSZIIUhmWcfSDJdFZtEIGnRgFJlydS3opdA8nm8VLF5hNTfL49l8BxjRNUWRGruKSyc9rSKvKNrZdoBj2NOMAXezPA3F50KhscKMS8zRfp2KHiXlPiORfKh0I18gHymIHNq86MZjBd98tg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Sat, 17 Oct
 2026 10:12:53 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 10:12:53 +0000
Date: Sat, 17 Oct 2026 12:12:44 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix bypass leaving
 the running task protected and bypassed tasks stranded
Message-ID: <atNKHI9K-_Rbh9Og@gpd4>
References: <20261017053717.3162619-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017053717.3162619-1-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c8e736-01fe-4f6f-82f3-08df2c3734b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	77Qc7Dzio2RElYhPWzH7J5x4NqtJLjaEogH0F0dU5gNUNeqogLSYMA3lNA/c04kuppGk0RHiLaCq69h/K/45XFwmYixqk15v/RBCWDRrOe8km1FWEslr/Ij+A7UHjOvRUK+20JTVgvD4hy/ve+wmDuEU3yZM7tod8/J3svR5TFCi1PYIgitnY8GGt4lnUKfGixAdeUxd9OeWA03rcKmCHulOClW/paGXd1d8cR7+VV6iYlYtCVXUrep/ZbvxW+tTP5z9e9DDCKW6ckmWsIE7+sUjIhTdGXEQzBer/Na+kjHsHV4glKUtf7zfbhMZwSC2+gglxe82+mvWzjUGeidFVFdl2Ay2TsYnsyHfMXRO8ZYJHv8xNMLU4RNb34QQUuxnj7zKY5Hro1AvAfNfpI7tlu1c946WMmIojTzy4ev+Q0Af5g3qNS48YxM8LImwcRuRKq/mkVwq6VgXIQ9Fp7e9H5Zj0IC9Ct3ECYU8FGS7gYUtfZqMG68CCV/dZQsCC89K3DUHR8ZGXETiG5hodsBQCr45OvX0ObB9DjJmUiuY8VNpJjSTQcbe0WfA9uYAhx138EktZMrhcea2+sy6z6LcTvLvThn3eoOsIzZ7UCLAewq4KyHskqFfX7zbwjYjXdOoZtrEvwoE0JclezarAX2WieBJWpnIeevYj+FjlibS0EA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djt3Pp8F4IXjgh7322qac2/vToropDNkCV62n/IqVaRMYKcucEFcaw3hhyKz?=
 =?us-ascii?Q?IY4eKdOrHqR/ULB8LYcQArs8/rVA2Y/2xfIVE872ET96W6yX86tYQWhx7vod?=
 =?us-ascii?Q?Njk/TDRsnSZS3x268I6/2efHsi5qjPK81l7QoKNqYJh5O7IsQY7ASV/tacBX?=
 =?us-ascii?Q?lQSZFLMG4eBKhW10wLvc3FwJllGvBPM3MkM4s9EGY0RsB5k+HZxh4xfYjX53?=
 =?us-ascii?Q?oSv9DyfTGKVzF4NJCc5xuIKkpQ0pWIvea7uLXhlFOvNH02stP1L1VYAwXnLZ?=
 =?us-ascii?Q?AJ0LTE/AOLAahHK7gkm7Cscl/a4nS7xLMwJSoYKyUGPha4d4XO6vXbTSB7Y5?=
 =?us-ascii?Q?QrSqRU7x/EQdTg4LIMfQUAUHfU629/NV2Kg4SOvZ0aa4kLBO9ZOe35uKhE5u?=
 =?us-ascii?Q?p5OCDFj5j+xeUW28VI9YRihO4wFk2ib+SpVaT7cbESG46mLLhb3XwVeNGfig?=
 =?us-ascii?Q?AfN0JRnt/xwwBUoMRZMTHjI/O26Rhn0PKWipho4NPaVeYf5w0yDV5iyuEL18?=
 =?us-ascii?Q?Uh5Ss5sxeiYtJDoTQnZb276bmDdIdug3jf4yTWfI/ULFxQlIZJmeXMOTvDxv?=
 =?us-ascii?Q?5FrNeQ6sJKmtg3i/nYDy+y7RqAPAwqIL/igC9+0SKVlwIIh+TzEtKD2iqRqf?=
 =?us-ascii?Q?JhpusGBtUxMEPH13XTBubQ7giC+hVp3I1ltjs99hd2Vm1MrxTna/J/Ku8ZPE?=
 =?us-ascii?Q?d+/LNlofOVL4FRSuHupW/vImv6xMZbqV8j5ykTN83ybRxeIVKkUQ+KTIX7ug?=
 =?us-ascii?Q?n6MaPSz94LC0PO6elIQmHaDC/aD3zhlJzwhWx1FpB5JAlMpOpvScz0j9jFln?=
 =?us-ascii?Q?f1uq24KDlAJwEE9qZSUq8jpdJM5ewBTjSqOLjbDSzzP9QEnv99VO7zMp4Ep0?=
 =?us-ascii?Q?+rJoXiP3yIFliYLWUbQl1TL/Ik/xvy4M0E7hnPVZ7dp78OKnlvYzpqQxmYei?=
 =?us-ascii?Q?VU6uo4SiSP8ePd+1SXyuT3i8Eo06UqtJkd/ERsbgZlu20f5dudNAb94OZq72?=
 =?us-ascii?Q?xZaYeEdGyndpg/7sTtMZ4gFfivn4K4IWYN3p79C74GbZtP8wuth2it15krnv?=
 =?us-ascii?Q?8R5diLCxi4YgXBKpCnuc3BRk4wGwVrWEB9pEy1fEtkEVDXwvkVlz5p7gxqoN?=
 =?us-ascii?Q?+6FmVmm2wWyWXeygBQdbMTdFdlfOVqdWPZFQxa9tqbx6Wsbt6cQ7aWGqZ0z0?=
 =?us-ascii?Q?fb1lAe2cyfoI4FbT7EV/AEe81mszxtAaufqzWY8Clgk7EDJtbYk90fi6wpNF?=
 =?us-ascii?Q?8wbmmz0XbJ6qgkQ704mCuOVFPaS3Dmtux0PbZe2bIrVHPSRkdoSF21S9+Lcu?=
 =?us-ascii?Q?3inAKZNAG4yNHrfZqk1Nc+8xHAk4wJqcn5akw55e12TA/CHAVyu/uInsqMdF?=
 =?us-ascii?Q?MQjaZbxdWUMp5ySoAmnQi9o/gFIvxLTH3MUVTvqsNlUqMKdkKW4ag2Siqw1G?=
 =?us-ascii?Q?DlZsrA+KTbGxFz2WncUnhNzP1aLlH0YynaQOHJBVqdf+AzyCC1JFCGWWZGBR?=
 =?us-ascii?Q?VpSNLjugv5wFWX0EZQOLKpqxnNymetCAIvCWuHdymWOco+iwg94/pKib80cM?=
 =?us-ascii?Q?ydMnSxqL0oeZZ0J1mTfOGFYsbQJkdEOkXmRihNqz4kdf1niJU9ec7GBH3XZI?=
 =?us-ascii?Q?HQ7UsrfClUb9WDlHlx0MnjHsTU9UGW/E+1rHD3G+ovUf8pC95J0B58akjp56?=
 =?us-ascii?Q?0YYh9LPWiPXy4Y6HqHOKzioWC53DlDoDeAG1d/aKR7VVFbC5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c8e736-01fe-4f6f-82f3-08df2c3734b2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 10:12:53.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqeeksQJP2Y/EWMJ+c7zOiS9ERsL/DP6L7/Njji778rtodZpzmWByy3WPL9Q6z74ANmxErDti4ZV/3kRdiznJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545

Hi Tejun,

On Fri, Oct 16, 2026 at 07:37:15PM -1000, Tejun Heo wrote:
> Hello,
> 
> scx_bypass() handles the running task inside its walk over the runnable
> list, which never contains the running task, so the protection strip at
> bypass entry never runs. Separately, a bypassing sub-scheduler's tasks are
> run by its nearest ancestor that isn't bypassing, but whether such a task
> may stay on its cpu is still checked against the caps of its own scheduler.
> A bypassed task that the bypass load balancer moved to a cpu where its
> scheduler holds no caps can't stay there once its slice runs out, and the
> cpu can go idle with the task queued on the ancestor's bypass DSQ.
> 
> Patch 1 handles the running task outside the walk. Patch 2 checks a bypassed
> task against the caps of the scheduler running it and, in the block patch 1
> adds, evicts the running task when bypass lifts if its own scheduler lacks
> the caps to keep it.
> 
> Verified on bare metal by attaching and detaching a sub-scheduler repeatedly
> under load. A debug knob that marks the running task protected at each
> bypass entry finds every such task stripped with patch 1. Without it, they
> all keep their protection and the bypass tick can't cut their slices. In a
> VM, running tasks whose scheduler holds no caps on their cpu leave it within
> about 50us of the bypass lift with patch 2, instead of running out their
> bypass slice. The sched_ext selftests pass.

A few notes:

 - when merging for-7.3-fixes into for-7.4, with proxy exec the slice and the
   protection belong to the donor, so I think the resolution should use rq->donor
   instead of rq->curr, both for the strip on bypass and for the eviction on
   unbypass. With rq->curr, a blocked SCX donor would keep its protection into
   bypass and we'd act on the proxy owner instead.

 - not a regression and probably transient (I haven't verified it):
   bypass_lb_cpu() doesn't look at caps, when the nearest non-bypassing ancestor
   running a bypassed sched's tasks is itself a sub-sched with caps only on some
   CPUs, could a bypassed task still be moved to a CPU it can't stay on, until
   bypass lifts?

For the series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Based on sched_ext/for-7.3-fixes (43e1ef14a472).
> 
> This patchset contains the following 2 patches.
> 
>  0001 sched_ext: Fix the running task keeping its protection into bypass
>  0002 sched_ext: Fix a bypassed task stalling on a cpu its scheduler has no caps on
> 
> The patchset is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git bypass-stall-fixes
> 
> diffstat follows. Thanks.
> 
>  kernel/sched/ext/ext.c      | 32 +++++++++++++++++++-------------
>  kernel/sched/ext/internal.h | 17 +++++++++++++++++
>  kernel/sched/ext/sub.c      |  7 +++++--
>  kernel/sched/ext/sub.h      |  6 +++++-
>  4 files changed, 46 insertions(+), 16 deletions(-)
> 
> --
> tejun
