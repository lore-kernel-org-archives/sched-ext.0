Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D2242D72
	for <sched-ext@lists.linux.dev>; Fri, 25 Jul 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445209; cv=fail; b=O78rNiM1ya1olDMplGKnl5bmR9okU0jaICoofqblBRr2Frd5Aza8oyhzSQkqZ0TRIazun8QQHlEvkDesMKUm8brypO80UI06/iDi4YoGJPPy26MhADntS8ecMO9l66JLAHG5i7M1k/ftxlXA4jjX8LtHWwArILZLilsvOlYxDTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445209; c=relaxed/simple;
	bh=0Vgfa9oRefYZbddT8XfOfvwWJDFZ37GztfyzxqbFzU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cvIYytbFcGRDj25b7sS3jlimheCZH9icNEKVfd1CIadR1t5+EscuMMwQCWNVpcN0iDYm72b2J+2vtZTxN+faZR5d2qrA6a634nohFhgNwUMv73vpViUwcBMwe+9kkl0LAFg2PeMi+Wqo0uscjq5yeeINmTUsn8V3MBEaVWrZa8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLVZQsRP; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLVZQsRP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByV8IQNctVx5V16GWLnfBNU4YXlFfxPPWkXoYTn4ZhWLWCPjiALvnK4aPwK/23aDhOuEZSr1oad2/5pj8dTBJUj+GIC/4OyWsc7C0U5tn0Xw9ArBv3Fl0+mYgvJvI5LSUL+AxsRHnD9oYwhPs//zKuwuUeGE9HTVn/omlRyKXbxfsN7T8JIoM0mzOarK/kOZK5wBZ5lKZJSdQ48zK2Bw7EqWr4jMBICnm/AnyO6rYLqpusQFDjQZpL7nUVwfeg89pMfL35oW/PA7cE5IdlmJWyLThP5F0z+jJFknkRcGlRi4bgvZwGH6/x02cRspA6awD3/FBFOZ4/Lc3Z6ZiIkuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANDzvJmkZd17QX/w3ppeXn6atbRrUMhH+4jGnrbq7DA=;
 b=BnhK6atbhqtPZ9DJYQGYykx0cIPzbIVjK6lSVmg6lJs+sFFTqNH9NnN1hJWAsI03QWeaj5PeOmVa1zqNwlkfj0KxIIwjZ1Dj2lzcHwNJzD6L8lb42E0asdO+bgK5aZ3tt0PaYpoggSWH5yG+zFwJFLe5oh/4dY8ISDpf+a3ZfIMK8DgcJlPNJxKdUgTl+1WbrAzOHCMQAJf/OFBvZZ0H6t8b4JmlIi2Hzmp4beVfylgfY6K9Z/ELtTL4MJea6pwo08Nimiu+z1S/MK+YzRytuL2HHjI5Els+ben6/6x5v5Tn8uK2GNaEIqdI+0Jkj/c16dojWNrXHEYoncXzUyK0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANDzvJmkZd17QX/w3ppeXn6atbRrUMhH+4jGnrbq7DA=;
 b=cLVZQsRPja8l9bca3BIfStTMAna/+4QsZX4f41xhLtJR/bUCcga1NeilZFNIR53RrAoala9atfi+qaHpvXfIIuWNZCz+WhwqtuhhJY+YPJ9jUh6sLV22r1BhO5DimZ+tOde0H9ErMJT0l5XZ7a09hE6McuOXTh1UTrr79n4RLaaIBNoSZ/7fN//b9JhgpEkDkOY16dD2QmhyyE2nYIYCRnRJLNQ1/oIlX/7X0V5YPFis1dCA1Isiyo95+1fcX6N3QDuSt4X4b14fcT+5AC8OFn6z+ZpzaEGBcMCgXxvkBRFozW7kMoDc0z/zMGklNKZtm7LzvR7aqcZ6L0DyHZnbZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:06:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 12:06:41 +0000
Date: Fri, 25 Jul 2025 14:06:37 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2] sched_ext: Sync with scx upstream
Message-ID: <aINzTW6Hi40EPSt8@gpd4>
References: <20250723130243.53691-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723130243.53691-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: a70ac7c5-5c19-4938-3b57-08ddcb73b736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8AUQ5T4zYjmWWLlK63Jf6ZLyS+pQLKrRBxRnQ7VWtLFiIJyogyaEGT7Coax4?=
 =?us-ascii?Q?UfI36a7qu2GotaIsCCJ1ePu0Cn1HX4wCE3HGo/dfzKfiK6/2tJ7FoEWM2sVx?=
 =?us-ascii?Q?pHt3lMnu9Gw1UIjHv0lu2ind7ViVr0tORo8i3Oz8At4jZ56Ebz/n37CwKWfy?=
 =?us-ascii?Q?3D/9UDZVTHB8LsMSGFtC29jaPW0+7JuZcrVeTd/KMOhWmvJiKxXRniG5a7dF?=
 =?us-ascii?Q?LIpjiL3CjkFSaOxTkcZ5tUvPniSWFLpHbs8ZUwZM0/Ou5v/z3tnLHCHyOCOW?=
 =?us-ascii?Q?tX4bq6mTVLBORFphN52nFicfKuDrDpvfnQPZ1ik+IWr7lfQ08CppsyDaIgLX?=
 =?us-ascii?Q?z0u9XIPf8Q7LFsGFbgRKoQeAihPrwxiJ4uYbnpiT1W6ctMlscw6fIpXuIF9U?=
 =?us-ascii?Q?6e7m5hEKz6ZGgJWxiC6wW1Hupd4AjHXZcVQ4aLRCvO1qPFet+8Y46PeCdvhB?=
 =?us-ascii?Q?00Lb+tdTeZl/XpPrPbp55pZ3kifNgP5LectS8AGbYE1VwmupaDHWVIWhiNKB?=
 =?us-ascii?Q?sKiwoSizIaMET9/kO74IwcoqKj3XyDvc17DOlzXICZORM2Vkfj93b5xR6Saw?=
 =?us-ascii?Q?dOycD9xvFF1q0eahNCIi3CGNdiY9l9BqE5UqoyUR3N2ydQinwolG1uBq1iOc?=
 =?us-ascii?Q?AhsTla/2BZLl4atI4vHuh3Mr0M72ozLgTP2BD+F0YPZ7i9iWJq1R5qu2Vko8?=
 =?us-ascii?Q?ARe1xtseFcLHjjnrHjDOGYR8P3zwqjVr+j8CuQ7qykkxsycHmF4+bMh0yYZJ?=
 =?us-ascii?Q?kbufmOUh21mGGBgghOryYYpEBcyIc7WtO0hKaDcBZSD9xUUDhpDL/e9DhyF6?=
 =?us-ascii?Q?9j7r2MIX0G6YWQJmOl2vh0g+lHvNdM0UntOEuyob+ZDBwp+hkyl6iGJQKY+e?=
 =?us-ascii?Q?eoG99h3hYbSyBKS6NhwcTymCm+HN4/LT6hjet/3tmcpDmJFVZciUOrvTwXl5?=
 =?us-ascii?Q?Er1PphRONR9/moURHoC/6sSfaFySNlr4GUIMs01P9zYHuFSQYj89aUnBXv9O?=
 =?us-ascii?Q?eMe/H9uDYCTDzxMEVT/a28XKszXuWVzt0FFF5EIiRiofAWtMRvALu1wCpBmN?=
 =?us-ascii?Q?Ls0ef2WEWEMgpvjb7DADTDcOrzg6lMEOPN8NY/5XJKVjbUtG0UjErYQzjEKZ?=
 =?us-ascii?Q?6wbIcJJQiu8u96o26Yx1pkwCpWKYUnFHJFVQRR5C/7SwDSkKwVUvnfQ69K81?=
 =?us-ascii?Q?luP9SvnR2hwvSP7KoiKo70pE2uufCSt5T5V5m4nNE+8ptdK5FnnJRauY6y0Q?=
 =?us-ascii?Q?I/s4xzd4xLZ6/io5uZYx2yl5lfTNPhcqb2KZTQxPlnMs/Je0iJe2ksy2gbWJ?=
 =?us-ascii?Q?4f0LHhxnNpeJ9mYtOUeO5Sjz5gX8BgH1jfwn+cdeqNcOJlFq7uap50EL/DSA?=
 =?us-ascii?Q?lajzElbm1FzzpNAFOA6AauNgh1+5D2lijhVJsd/A6vlK3SJGmzH33i+l2Xue?=
 =?us-ascii?Q?XtNwp2g7K+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZSJBmjJHrBD+kcF0mNn/QlSYBPrCfRpMEf1uzqOJ/UIq1nCv3BdgMYxcvcRH?=
 =?us-ascii?Q?/DluL9Ph/KP8Vdqjx0wiEgJrhqkOXmaiqx0dWJqSfMMpRBzUwUN0E3f0PclX?=
 =?us-ascii?Q?TzjQbnRZn8j+FB9ULW4sSkTb46wg5JKJLTGvqk4K4cY22eL45o2VB6Uc3o55?=
 =?us-ascii?Q?dDmjDGr3NmamhRSuCYTfFf439kmOsFs3mN6ko45sYL7Hq4foGBHwKHW44Re6?=
 =?us-ascii?Q?PkLvSpSCYasNnOtd3+L2mxM5HnL0AeowRcyiTveAUMunkwFaXEjWL8hFIWYY?=
 =?us-ascii?Q?BHA+8lucOST/3qyxmOWDuXWjAPhQH0yrY01qeEQMqmw4PLJbSl/Vp6nbDCiK?=
 =?us-ascii?Q?chpAgXDRUj2K/IyjNcuekRVVCKGN7uuHUT3FEQ4Seys9v9+Su3hM16+pMmnX?=
 =?us-ascii?Q?mFgq1q5j0WtN6ZGj4TnRV/6EgVFGLySQNp1ZOYZfNPSZYpg6s6zXV7dS5Uey?=
 =?us-ascii?Q?DeKy/RP7zn1a0YaOT8HfNac357QqJGbX7xT34TxwXarM+sCRbdZMi5emt+gy?=
 =?us-ascii?Q?iG7n1KaOOAu4C1G//VrrI238j1C5MroLtDiMDRql4g+XovxfWxHlMeZjyW9D?=
 =?us-ascii?Q?BEfD8GAr9YO8A7vN/pvexHnYJUWzhz+VUMY4gYVr8n7TGlMJXJ5XzwEMV0Sg?=
 =?us-ascii?Q?JjY2aYJ5h4YxMxtw4ryYMr5E7+ozmmK8MhFW/tnHX+JcVcuyVZ+9SiX01S/5?=
 =?us-ascii?Q?0MOO8bs/xLQ8pX5aDxKlcltrZQpfJ4cZul8ABYz67Q3nKAn37noD2OxupLKb?=
 =?us-ascii?Q?Wptn1SfYzG3hrPS39O40Hzra1yKkx1VJ6wut5biOENFBl6BWDGsUqJU5Hx7z?=
 =?us-ascii?Q?k2c67p0UpGDlkBrE6Ah6ojBk1H4daqVI6/88whRXtgk4LM0JoNtBLOd9B2QP?=
 =?us-ascii?Q?EoKCtXJ+ULrXmFjnZcbFd8vWhiHIW8rzJHd0X24pJh8Rb6eacLQLFQDI0scI?=
 =?us-ascii?Q?NhG572TCmRgCcSJnjlkIJBt5MUk++CW8t3fcIJdmb1TKBO5/5H4O782rkVUW?=
 =?us-ascii?Q?jBfIKBXhSu5w6SggWtwVKq7qkDRhS7X0NrLOSbSbH5tan9/r1295MZhIzZ6F?=
 =?us-ascii?Q?Stuu7bH4i3+PFyT0EZ0c7wetxHl8FiO850zPQpk+pmJ7r3gvJTRv4NdjGDSV?=
 =?us-ascii?Q?iJZdnH+TBOlS5G76HkQrXRp4mH4kbMRALLgFPh7dIt+P/a2j5KfHPam5oI9g?=
 =?us-ascii?Q?q6pZCPPlB6u17i6f3IIMLh6ePXgNqn21yfOCUvYkc2kgcclY/tnJQsN+711f?=
 =?us-ascii?Q?z8d60l3DDLgYZVmUUPRfPo35BmwvInqRjpJcmclBV9RG4tMmIEIXbGQO2tfP?=
 =?us-ascii?Q?A1NZWdcKpweV9ceLG4k8asOIhJvTeIDDPIoIqc+tpzODXvDy2F5SHz4b1+wi?=
 =?us-ascii?Q?42kTOHczbQorDDBqZb0itjhCtfNx0juRTF9QYe2ftAmCNNax9vI0Rkv18pS+?=
 =?us-ascii?Q?JzrFUH2kJg06QXQYwmyfoMvUqAi5HAgqRRY+dQwlzGHu6fCYiDea96SevS8/?=
 =?us-ascii?Q?dljs9SWB3mfPcIcS2yqBv8cfTyhB28UCnZQRFxXAcgq1NsNj3p2+/Ka54OGP?=
 =?us-ascii?Q?dD6ro5iJ3OtJ90Wl1TnEHyExPMz5hfrns/XLqNx5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70ac7c5-5c19-4938-3b57-08ddcb73b736
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:06:41.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaAGFghnqUsRV+4FHh8oKr4DUIC+sskqDpNCmK14HOewnEBkEqZVqP1vKHba5buHu79ibGGycaidW1oweJBeLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699

On Wed, Jul 23, 2025 at 09:02:43PM +0800, Cheng-Yang Chou wrote:
> Sync via ./sync-to-kernel.sh /path/to/kernel/tree, as suggested by
> the upstream scx repository.
> 
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

This breaks the build of the sched_ext kselftests:

$ cd tools/testing/selftests/sched_ext
$ make -j$(nproc)
...
In file included from /home/arighi/src/linux/tools/sched_ext/include/scx/common.h:73,
                 from scx_test.h:12,
                 from runner.c:12:
/home/arighi/src/linux/tools/sched_ext/include/scx/user_exit_info.h:16:10: fatal error: user_exit_info_common.h: No such file or directory
   16 | #include "user_exit_info_common.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile:190: /home/arighi/src/linux/tools/testing/selftests/sched_ext/build/obj/sched_ext/runner.o] Error 1
make: *** Waiting for unfinished jobs....

The problem is that we're missing the following files from the scx repo:
 - scheds/include/scx/user_exit_info.bpf.h
 - scheds/include/scx/user_exit_info_common.h

They need to be copied under tools/sched_ext/include/scx.
Can you add these files as well?

Ideally it'd be nice to fix also sync-to-kernel.sh in the scx repo, if you
have time, otherwise I'll take a look.

Thanks,
-Andrea

> ---
>  tools/sched_ext/include/scx/common.bpf.h     | 102 +++++++++++++++++--
>  tools/sched_ext/include/scx/common.h         |   5 +-
>  tools/sched_ext/include/scx/compat.bpf.h     |   5 +
>  tools/sched_ext/include/scx/user_exit_info.h |  49 +--------
>  tools/sched_ext/scx_central.bpf.c            |   2 +-
>  tools/sched_ext/scx_central.c                |   1 +
>  tools/sched_ext/scx_flatcg.bpf.c             |   2 +-
>  tools/sched_ext/scx_flatcg.c                 |   2 +
>  tools/sched_ext/scx_qmap.bpf.c               |  23 -----
>  tools/sched_ext/scx_simple.c                 |   2 +
>  10 files changed, 110 insertions(+), 83 deletions(-)
> 
> Changes in v2:
>  - Squash all changes into one patch
>  - Link to v1: https://lore.kernel.org/all/20250723120746.52847-1-yphbchou0911@gmail.com/
> 
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index d4e21558e982..86abdb3c3142 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -24,14 +24,26 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <asm-generic/errno.h>
> -#include "user_exit_info.h"
> +#include "user_exit_info.bpf.h"
>  #include "enum_defs.autogen.h"
>  
> +#define PF_IDLE				0x00000002	/* I am an IDLE thread */
> +#define PF_IO_WORKER			0x00000010	/* Task is an IO worker */
>  #define PF_WQ_WORKER			0x00000020	/* I'm a workqueue worker */
> +#define PF_KCOMPACTD			0x00010000      /* I am kcompactd */
> +#define PF_KSWAPD			0x00020000      /* I am kswapd */
>  #define PF_KTHREAD			0x00200000	/* I am a kernel thread */
>  #define PF_EXITING			0x00000004
>  #define CLOCK_MONOTONIC			1
>  
> +#ifndef NR_CPUS
> +#define NR_CPUS 1024
> +#endif
> +
> +#ifndef NUMA_NO_NODE
> +#define	NUMA_NO_NODE	(-1)
> +#endif
> +
>  extern int LINUX_KERNEL_VERSION __kconfig;
>  extern const char CONFIG_CC_VERSION_TEXT[64] __kconfig __weak;
>  extern const char CONFIG_LOCALVERSION[64] __kconfig __weak;
> @@ -107,6 +119,9 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
>  static inline __attribute__((format(printf, 1, 2)))
>  void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
>  
> +#define SCX_STRINGIFY(x) #x
> +#define SCX_TOSTRING(x) SCX_STRINGIFY(x)
> +
>  /*
>   * Helper macro for initializing the fmt and variadic argument inputs to both
>   * bstr exit kfuncs. Callers to this function should use ___fmt and ___param to
> @@ -141,13 +156,15 @@ void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
>   * scx_bpf_error() wraps the scx_bpf_error_bstr() kfunc with variadic arguments
>   * instead of an array of u64. Invoking this macro will cause the scheduler to
>   * exit in an erroneous state, with diagnostic information being passed to the
> - * user.
> + * user. It appends the file and line number to aid debugging.
>   */
>  #define scx_bpf_error(fmt, args...)						\
>  ({										\
> -	scx_bpf_bstr_preamble(fmt, args)					\
> +	scx_bpf_bstr_preamble(							\
> +		__FILE__ ":" SCX_TOSTRING(__LINE__) ": " fmt, ##args)		\
>  	scx_bpf_error_bstr(___fmt, ___param, sizeof(___param));			\
> -	___scx_bpf_bstr_format_checker(fmt, ##args);				\
> +	___scx_bpf_bstr_format_checker(						\
> +		__FILE__ ":" SCX_TOSTRING(__LINE__) ": " fmt, ##args);		\
>  })
>  
>  /*
> @@ -229,6 +246,7 @@ BPF_PROG(name, ##args)
>   * be a pointer to the area. Use `MEMBER_VPTR(*ptr, .member)` instead of
>   * `MEMBER_VPTR(ptr, ->member)`.
>   */
> +#ifndef MEMBER_VPTR
>  #define MEMBER_VPTR(base, member) (typeof((base) member) *)			\
>  ({										\
>  	u64 __base = (u64)&(base);						\
> @@ -245,6 +263,7 @@ BPF_PROG(name, ##args)
>  		  [max]"i"(sizeof(base) - sizeof((base) member)));		\
>  	__addr;									\
>  })
> +#endif /* MEMBER_VPTR */
>  
>  /**
>   * ARRAY_ELEM_PTR - Obtain the verified pointer to an array element
> @@ -260,6 +279,7 @@ BPF_PROG(name, ##args)
>   * size of the array to compute the max, which will result in rejection by
>   * the verifier.
>   */
> +#ifndef ARRAY_ELEM_PTR
>  #define ARRAY_ELEM_PTR(arr, i, n) (typeof(arr[i]) *)				\
>  ({										\
>  	u64 __base = (u64)arr;							\
> @@ -274,7 +294,7 @@ BPF_PROG(name, ##args)
>  		  [max]"r"(sizeof(arr[0]) * ((n) - 1)));			\
>  	__addr;									\
>  })
> -
> +#endif /* ARRAY_ELEM_PTR */
>  
>  /*
>   * BPF declarations and helpers
> @@ -438,8 +458,27 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
>   */
>  static inline bool is_migration_disabled(const struct task_struct *p)
>  {
> -	if (bpf_core_field_exists(p->migration_disabled))
> -		return p->migration_disabled;
> +	/*
> +	 * Testing p->migration_disabled in a BPF code is tricky because the
> +	 * migration is _always_ disabled while running the BPF code.
> +	 * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) for BPF
> +	 * code execution disable and re-enable the migration of the current
> +	 * task, respectively. So, the _current_ task of the sched_ext ops is
> +	 * always migration-disabled. Moreover, p->migration_disabled could be
> +	 * two or greater when a sched_ext ops BPF code (e.g., ops.tick) is
> +	 * executed in the middle of the other BPF code execution.
> +	 *
> +	 * Therefore, we should decide that the _current_ task is
> +	 * migration-disabled only when its migration_disabled count is greater
> +	 * than one. In other words, when  p->migration_disabled == 1, there is
> +	 * an ambiguity, so we should check if @p is the current task or not.
> +	 */
> +	if (bpf_core_field_exists(p->migration_disabled)) {
> +		if (p->migration_disabled == 1)
> +			return bpf_get_current_task_btf() != p;
> +		else
> +			return p->migration_disabled;
> +	}
>  	return false;
>  }
>  
> @@ -476,7 +515,7 @@ static inline s64 time_delta(u64 after, u64 before)
>   */
>  static inline bool time_after(u64 a, u64 b)
>  {
> -	 return (s64)(b - a) < 0;
> +	return (s64)(b - a) < 0;
>  }
>  
>  /**
> @@ -500,7 +539,7 @@ static inline bool time_before(u64 a, u64 b)
>   */
>  static inline bool time_after_eq(u64 a, u64 b)
>  {
> -	 return (s64)(a - b) >= 0;
> +	return (s64)(a - b) >= 0;
>  }
>  
>  /**
> @@ -547,9 +586,15 @@ static inline bool time_in_range_open(u64 a, u64 b, u64 c)
>   */
>  
>  /* useful compiler attributes */
> +#ifndef likely
>  #define likely(x) __builtin_expect(!!(x), 1)
> +#endif
> +#ifndef unlikely
>  #define unlikely(x) __builtin_expect(!!(x), 0)
> +#endif
> +#ifndef __maybe_unused
>  #define __maybe_unused __attribute__((__unused__))
> +#endif
>  
>  /*
>   * READ/WRITE_ONCE() are from kernel (include/asm-generic/rwonce.h). They
> @@ -632,6 +677,26 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>  	__u.__val;								\
>  })
>  
> +/*
> + * __calc_avg - Calculate exponential weighted moving average (EWMA) with
> + * @old and @new values. @decay represents how large the @old value remains.
> + * With a larger @decay value, the moving average changes slowly, exhibiting
> + * fewer fluctuations.
> + */
> +#define __calc_avg(old, new, decay) ({						\
> +	typeof(decay) thr = 1 << (decay);					\
> +	typeof(old) ret;							\
> +	if (((old) < thr) || ((new) < thr)) {					\
> +		if (((old) == 1) && ((new) == 0))				\
> +			ret = 0;						\
> +		else								\
> +			ret = ((old) - ((old) >> 1)) + ((new) >> 1);		\
> +	} else {								\
> +		ret = ((old) - ((old) >> (decay))) + ((new) >> (decay));	\
> +	}									\
> +	ret;									\
> +})
> +
>  /*
>   * log2_u32 - Compute the base 2 logarithm of a 32-bit exponential value.
>   * @v: The value for which we're computing the base 2 logarithm.
> @@ -662,6 +727,25 @@ static inline u32 log2_u64(u64 v)
>                  return log2_u32(v) + 1;
>  }
>  
> +/*
> + * sqrt_u64 - Calculate the square root of value @x using Newton's method.
> + */
> +static inline u64 __sqrt_u64(u64 x)
> +{
> +	if (x == 0 || x == 1)
> +		return x;
> +
> +	u64 r = ((1ULL << 32) > x) ? x : (1ULL << 32);
> +
> +	for (int i = 0; i < 8; ++i) {
> +		u64 q = x / r;
> +		if (r <= q)
> +			break;
> +		r = (r + q) >> 1;
> +	}
> +	return r;
> +}
> +
>  /*
>   * Return a value proportionally scaled to the task's weight.
>   */
> diff --git a/tools/sched_ext/include/scx/common.h b/tools/sched_ext/include/scx/common.h
> index 1dc76bd84296..b3c6372bcf81 100644
> --- a/tools/sched_ext/include/scx/common.h
> +++ b/tools/sched_ext/include/scx/common.h
> @@ -75,8 +75,9 @@ typedef int64_t s64;
>  #include "enums.h"
>  
>  /* not available when building kernel tools/sched_ext */
> -#if __has_include(<lib/sdt_task.h>)
> -#include <lib/sdt_task.h>
> +#if __has_include(<lib/sdt_task_defs.h>)
> +#include "bpf_arena_common.h"
> +#include <lib/sdt_task_defs.h>
>  #endif
>  
>  #endif	/* __SCHED_EXT_COMMON_H */
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index 9252e1a00556..36e0cd2fd4ed 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -38,6 +38,7 @@ void scx_bpf_dispatch_from_dsq_set_slice___compat(struct bpf_iter_scx_dsq *it__i
>  void scx_bpf_dispatch_from_dsq_set_vtime___compat(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
>  bool scx_bpf_dispatch_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
>  bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> +int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
>  
>  #define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)				\
>  	(bpf_ksym_exists(scx_bpf_dsq_insert) ?					\
> @@ -82,6 +83,10 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
>  	  scx_bpf_dispatch_vtime_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
>  	  false))
>  
> +#define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
> +	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
> +	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
> +
>  #define scx_bpf_dispatch(p, dsq_id, slice, enq_flags)				\
>  	_Static_assert(false, "scx_bpf_dispatch() renamed to scx_bpf_dsq_insert()")
>  
> diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
> index 66f856640ee7..399697fa372f 100644
> --- a/tools/sched_ext/include/scx/user_exit_info.h
> +++ b/tools/sched_ext/include/scx/user_exit_info.h
> @@ -10,55 +10,11 @@
>  #ifndef __USER_EXIT_INFO_H
>  #define __USER_EXIT_INFO_H
>  
> -#ifdef LSP
> -#define __bpf__
> -#include "../vmlinux.h"
> -#endif
> -
> -enum uei_sizes {
> -	UEI_REASON_LEN		= 128,
> -	UEI_MSG_LEN		= 1024,
> -	UEI_DUMP_DFL_LEN	= 32768,
> -};
> -
> -struct user_exit_info {
> -	int		kind;
> -	s64		exit_code;
> -	char		reason[UEI_REASON_LEN];
> -	char		msg[UEI_MSG_LEN];
> -};
> -
> -#ifdef __bpf__
> -
> -#ifndef LSP
> -#include "vmlinux.h"
> -#endif
> -#include <bpf/bpf_core_read.h>
> -
> -#define UEI_DEFINE(__name)							\
> -	char RESIZABLE_ARRAY(data, __name##_dump);				\
> -	const volatile u32 __name##_dump_len;					\
> -	struct user_exit_info __name SEC(".data")
> -
> -#define UEI_RECORD(__uei_name, __ei) ({						\
> -	bpf_probe_read_kernel_str(__uei_name.reason,				\
> -				  sizeof(__uei_name.reason), (__ei)->reason);	\
> -	bpf_probe_read_kernel_str(__uei_name.msg,				\
> -				  sizeof(__uei_name.msg), (__ei)->msg);		\
> -	bpf_probe_read_kernel_str(__uei_name##_dump,				\
> -				  __uei_name##_dump_len, (__ei)->dump);		\
> -	if (bpf_core_field_exists((__ei)->exit_code))				\
> -		__uei_name.exit_code = (__ei)->exit_code;			\
> -	/* use __sync to force memory barrier */				\
> -	__sync_val_compare_and_swap(&__uei_name.kind, __uei_name.kind,		\
> -				    (__ei)->kind);				\
> -})
> -
> -#else	/* !__bpf__ */
> -
>  #include <stdio.h>
>  #include <stdbool.h>
>  
> +#include "user_exit_info_common.h"
> +
>  /* no need to call the following explicitly if SCX_OPS_LOAD() is used */
>  #define UEI_SET_SIZE(__skel, __ops_name, __uei_name) ({					\
>  	u32 __len = (__skel)->struct_ops.__ops_name->exit_dump_len ?: UEI_DUMP_DFL_LEN;	\
> @@ -114,5 +70,4 @@ enum uei_ecode_mask {
>  
>  #define UEI_ECODE_RESTART(__ecode)	(UEI_ECODE_SYS_ACT((__ecode)) == SCX_ECODE_ACT_RESTART)
>  
> -#endif	/* __bpf__ */
>  #endif	/* __USER_EXIT_INFO_H */
> diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
> index 50bc1737c167..55df8b798865 100644
> --- a/tools/sched_ext/scx_central.bpf.c
> +++ b/tools/sched_ext/scx_central.bpf.c
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * A central FIFO sched_ext scheduler which demonstrates the followings:
> + * A central FIFO sched_ext scheduler which demonstrates the following:
>   *
>   * a. Making all scheduling decisions from one CPU:
>   *
> diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
> index 6ba6e610eeaa..55931a4cd71c 100644
> --- a/tools/sched_ext/scx_central.c
> +++ b/tools/sched_ext/scx_central.c
> @@ -61,6 +61,7 @@ int main(int argc, char **argv)
>  	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
>  	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
>  
> +	assert(skel->rodata->nr_cpu_ids > 0);
>  	assert(skel->rodata->nr_cpu_ids <= INT32_MAX);
>  
>  	while ((opt = getopt(argc, argv, "s:c:pvh")) != -1) {
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index fdc7170639e6..2c720e3ecad5 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -950,5 +950,5 @@ SCX_OPS_DEFINE(flatcg_ops,
>  	       .cgroup_move		= (void *)fcg_cgroup_move,
>  	       .init			= (void *)fcg_init,
>  	       .exit			= (void *)fcg_exit,
> -	       .flags			= SCX_OPS_ENQ_EXITING,
> +	       .flags			= SCX_OPS_HAS_CGROUP_WEIGHT | SCX_OPS_ENQ_EXITING,
>  	       .name			= "flatcg");
> diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
> index 6dd423eeb4ff..cd85eb401179 100644
> --- a/tools/sched_ext/scx_flatcg.c
> +++ b/tools/sched_ext/scx_flatcg.c
> @@ -6,6 +6,7 @@
>   */
>  #include <stdio.h>
>  #include <signal.h>
> +#include <assert.h>
>  #include <unistd.h>
>  #include <libgen.h>
>  #include <limits.h>
> @@ -137,6 +138,7 @@ int main(int argc, char **argv)
>  	skel = SCX_OPS_OPEN(flatcg_ops, scx_flatcg);
>  
>  	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
> +	assert(skel->rodata->nr_cpus > 0);
>  	skel->rodata->cgrp_slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
>  
>  	while ((opt = getopt(argc, argv, "s:i:dfvh")) != -1) {
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index 69d877501cb7..c3cd9a17d48e 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -615,26 +615,6 @@ void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struc
>  		     taskc->force_local, taskc->core_sched_seq);
>  }
>  
> -s32 BPF_STRUCT_OPS(qmap_cgroup_init, struct cgroup *cgrp, struct scx_cgroup_init_args *args)
> -{
> -	bpf_printk("CGRP INIT %llu weight=%u period=%lu quota=%ld burst=%lu",
> -		   cgrp->kn->id, args->weight, args->bw_period_us,
> -		   args->bw_quota_us, args->bw_burst_us);
> -	return 0;
> -}
> -
> -void BPF_STRUCT_OPS(qmap_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
> -{
> -	bpf_printk("CGRP SET %llu weight=%u", cgrp->kn->id, weight);
> -}
> -
> -void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
> -		    u64 period_us, u64 quota_us, u64 burst_us)
> -{
> -	bpf_printk("CGRP SET %llu period=%lu quota=%ld burst=%lu", cgrp->kn->id,
> -		   period_us, quota_us, burst_us);
> -}
> -
>  /*
>   * Print out the online and possible CPU map using bpf_printk() as a
>   * demonstration of using the cpumask kfuncs and ops.cpu_on/offline().
> @@ -860,9 +840,6 @@ SCX_OPS_DEFINE(qmap_ops,
>  	       .dump			= (void *)qmap_dump,
>  	       .dump_cpu		= (void *)qmap_dump_cpu,
>  	       .dump_task		= (void *)qmap_dump_task,
> -	       .cgroup_init		= (void *)qmap_cgroup_init,
> -	       .cgroup_set_weight	= (void *)qmap_cgroup_set_weight,
> -	       .cgroup_set_bandwidth	= (void *)qmap_cgroup_set_bandwidth,
>  	       .cpu_online		= (void *)qmap_cpu_online,
>  	       .cpu_offline		= (void *)qmap_cpu_offline,
>  	       .init			= (void *)qmap_init,
> diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
> index 76d83199545c..06d4b13bf76b 100644
> --- a/tools/sched_ext/scx_simple.c
> +++ b/tools/sched_ext/scx_simple.c
> @@ -7,6 +7,7 @@
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <signal.h>
> +#include <assert.h>
>  #include <libgen.h>
>  #include <bpf/bpf.h>
>  #include <scx/common.h>
> @@ -41,6 +42,7 @@ static void sigint_handler(int simple)
>  static void read_stats(struct scx_simple *skel, __u64 *stats)
>  {
>  	int nr_cpus = libbpf_num_possible_cpus();
> +	assert(nr_cpus > 0);
>  	__u64 cnts[2][nr_cpus];
>  	__u32 idx;
>  
> -- 
> 2.48.1
> 
