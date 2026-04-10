Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F00230BE9
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843145; cv=fail; b=GxwG4QVNePzbb/dZrIPbp5bURMNiE15Uw4zJOJFpzkEkYOmfrTqfmH5YMWUGT5c5WwbKv26Ft+fHX0Tx7+0F53+vx50SL4JScqIzgNqjNvwiMF4HNeBcegMJATVBSx9/x6UQUjoFpH2W6jLR8dNhwmF8KRXA8g4m6ekkr1qQW60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843145; c=relaxed/simple;
	bh=ir8nRuY+6I6dbzjjGj8nSbDrYtVZoD5jNwPxijWL/o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gy/hfynM0WLTxkbp6uq85K0NyPvxHwwTfRA0FQgecb+kEACJvT3cp4uduLPnnxzPcLziiw04MD03Ki0Tkg9iPdfksYNIjRAydYbhiogQuBJFeT0QBGpl/n/jfkN5zlSNyeJqMuXgi90vmqYcZ/6PN4JLCBL1rLL68nsqPpiAmVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V/r7+EjU; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V/r7+EjU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvRtvHUHcbJJEaHcXC/iCk+UUCvkmUXLgc9e9+r1F2yaZFuow1OWEhBEgsLTEscxeBHF6ky5PdgU2ip/TH3jXoWOkL33aJUSniisMbLkpCbe2b3E+bt/qV7N2cVVq93JNDTlssQtkie8oLmKSSOYXElRRErnqC4I4nkqvy/43l9qM+OpDPEMXBPbrcb1SZIkw6KMgEWl1EQTnFt+G2I+qLc1khCHEIYe9RO7pAM7LOCx4SLmXdNVXdECblyh50x09ogFS8LGKPLwARtPbq/MODUOp0bZo7Ho06XskKCoukVWDeZu/WaZltilM/fR5xt0jFqDoqjaLmASAFjMCSKcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DTJAPM+CD2s8cBkOGNrbmQ/aspoC3tif4ogQybgNcI=;
 b=WFvAw7hA7RK0WxRk2vP5dLO0qdIBrRmDArpxD7o3aBpfpbjIZoW+byXWgFLUO+1lgzh2//AqDAnPub8yh4gfKrKCIBfbnMFKXi29xFhfoybEOO1pAf0eK2/mjrwb8vt5sxh3ZVQqErmLLTWCgbb+kYhaFFZ1+7sGtu9i/X1/8yuHnccslEC0o1l4IRSFwpjsWL77JkKBWH2MquIi5pLfTUBiBn3ROtwaI0yZLjC1F+qJtwEUanOiS1RJsZcCLK64p7D0048mM8UEKH+R5/tBivqzvFantfvdbjEPfhc2ysjKep7NRr7GdlYVFlp1I5m+91x78qzVvOz0moopmOCwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DTJAPM+CD2s8cBkOGNrbmQ/aspoC3tif4ogQybgNcI=;
 b=V/r7+EjUv7sauWtUTYIpIvBp4PRHY311a7rApa2drZRK/tJKyazF2E1lt081z/DQ5f3kILkbdXWqO8Rf/yy5pgc79H8ZonDDDqJWGZcgDLSFkOD5KprJ41TZtzdKNlDJKniL+nA4esXLxjIjWLgABwC3I4DyHfEllQ65191XTgnUOe6bAXRB4kct93giHhM+IXm7EVKLuuRT8+YJdvjU0kOStPW41CS5bRWFPs4JuFQcl/Q2akhpGQqxbOgVKtS593lZRwhJ1rSeaJS+tAAZICHygItCF7dOunQD3ao1qZAF5cc7asnANqkZu7qnZfU7OZroYe8Ly2zbgplveSmEMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 10 Apr
 2026 17:45:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 17:45:40 +0000
Date: Fri, 10 Apr 2026 19:45:32 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] sched_ext: Add verifier-time kfunc
 context filter
Message-ID: <adk3PF5tJOwJbeop@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-1-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: c81b25dc-b56d-4bd7-d51e-08de9728fb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gVfG/DURPuqwcONrvZw1sz/TzIY42b6j/Sc2MPdTdXMW0oNJU+FU1hCv6tiYxCkrv3FU/eMnE/H5zv/Nyz59ajWUEPAQT8eC/SnbdNAjVUzd0O8ezzJV+aOeWeGdBvUEDxC0kLZXESXA64JbgmQNMiexJYTdVU40P91gwOlCcq2JuY+r1mErERaC7ie6e06zICKFLgPYV5fSCeKP5/W9VGpcZ3hL2PyA6TZiduFSn++qE/5RFCaPyc/5HvPSXrt3pINUrB8eJvckX1Ljtxjp5UwRWjHNzueWTQiwhwKmYlpJi1J9PlR3c19ihwoqx3lxgUx1e0B1XMqs/3xbe0jg8l/wWINu/PVENYJX8VrdoXOQNtP/8TmlzGFl/L5WgyLefCLlMSu6oxoXh01flrBLOVPBOFAmSOA4uMkzA/QeZLXJ4C3yC3krfWNbiAnEvW5X4eUahoc6KCmShv6OJJnACF6XVdn77B6fwNX2iiSeGlFwOBN6V1197TKwUSkxZRa4tF7f51/CI4upyQBGwoJA5LnJl5xhjKM0F3N8/qR3M0OffwY5IFFiMn4SMCBJbiCtGgQUH2MjCiJLqxmumt4nIzY6kMo+x2H3ab1uvOkYk2oOpTNvzTDlVvKGzVr9y8pRi5MX2d43BAumQd6G1oQ86H+Mz+lpL5YrQQTbwVRDuo770asd/zr8YMEs4vx1tEhbXGkr9fMbfXaOsig9AiZbAR+xQ90pIqEcAKeL0JdnUFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qqF/cmyoAZUEVnZ+yhpDinAqmHQELRB1B5IkHAa+6WaqoMkY5+m5gMNhNODI?=
 =?us-ascii?Q?nih/79XA2TdEhfKRGVKyflY9za+85Ms18NgpsJbtC29bC7p8cVXWYUYN2jNz?=
 =?us-ascii?Q?K2GOFSeA/NMMKwTcUtS+RaiJEUERbgGbcEuffee3fimW56BcKRmVvoy83tlG?=
 =?us-ascii?Q?WfYLlXMmwgf9BxugvpORg+n1PJ21E1+Kf2N70PIZg8WzHWTRN3bE2bCs9C59?=
 =?us-ascii?Q?ekVdV8duMSrt9L9uZOKiJaCECSVUvkFtzM2AY+SDCU5m9Nz5V/bCRVgrMgUg?=
 =?us-ascii?Q?DOQjka7TZXNv+svldxiodCkl3UedscA74RqkmxaVzHP/0OHHhOvX/shlZ5mO?=
 =?us-ascii?Q?/pjYsGudDhxnHqB8+sW0dCuGg98a5ZYiXqnQXFghXOK5AMvLNQ+X2JWOSWZj?=
 =?us-ascii?Q?rxXT9EZfOjpfdadp059wPvLb14mN98gdZ5LMhNJCxDb2lLREqlaZd9RXzaiU?=
 =?us-ascii?Q?Ev5sObjfpOgrGnkBwpTTZn366hx/JUdVVvPIAkF6HMBIko5zZSYpGXSyWw6o?=
 =?us-ascii?Q?fnbuPo2blqUD29unu+fK6VBGrhf09JxtCdF2wq4rqcZFNAvmYmdNGobQEecp?=
 =?us-ascii?Q?HxIksuegyZUxnRNBSCzsvtQiiZhUWocrSlrTz2bb3Rw1rlaNXwshq60yVfO0?=
 =?us-ascii?Q?tfGP0jCsFiRCoezJCzw/w1jOK8Oz1HZ38NXRtbTXw/rL32cu81OctLKzpeot?=
 =?us-ascii?Q?JWb58bXCGBqxfsv0906DmhAhOzPwWNUMlc/1Do+wiT9+J5Y9I1PxG6+BXs7i?=
 =?us-ascii?Q?r4WOnlCdpu1I/o/HmRe79u/pO/DeFFaC6MZUthkRr3j4IOCLjfEXVj+W+db0?=
 =?us-ascii?Q?qmgWS+g1HhxBGny4gmDMlwH4jgOU63GAV/9ouV4bynz7eAATAzG7cwqCplvM?=
 =?us-ascii?Q?j0q2nzMxg+4EBGq9RzSFscWyBcEe61WKoxnOgCrPbj1kTgeeZbUm0FLhlCpP?=
 =?us-ascii?Q?B7TrrKTQ4lX4G0YgfdHlBah1iPyYFbcDSZ7GAOE4qE5gypzU3Gnsdh8TtLuB?=
 =?us-ascii?Q?NhMgPu4G7DfBX3IN5Kgd6nd+pO/Efu5t3Qg8vYu7s1a6p90Xbg864tw2iQ0G?=
 =?us-ascii?Q?q16GFHZVF5l6gMjjSns96ajhAEOzgQyzb7l4vHyRVchVl8pvPC7654sT7DyF?=
 =?us-ascii?Q?FaYmp2HppJe8D9T3C2k4Ao1JmRFSjS2wPAQ/qPkZzb0YhKM0j7A+yRm0Kjvm?=
 =?us-ascii?Q?EIzrN9cF1VC/AyG3N8/kvj4/DfPBTK40gBamnJLtTpGf9OYFurc1dZQWI9tz?=
 =?us-ascii?Q?/yrDu6vx83tLWZZMHb0vUFEye8dAh0r4+GJVh9lyBS4/7kLjIbnYAxHZSe0D?=
 =?us-ascii?Q?2gKtXC8nzoWh34vGIl9plC8wZSjYh63hFyCs0JuksrRnt2XE2Y/JOyJ8t8Ub?=
 =?us-ascii?Q?THgbpsR6jNKwzVhT2r39CNFUPK/85j06tbVcPg4+Hlg1nW6zsKP7HiyBgbD9?=
 =?us-ascii?Q?kYLXNA1VXIA21d8hit66c/kzi+3knPtnyeYvW20Aml5xdUJv9UiT05fmmwHi?=
 =?us-ascii?Q?6CDEk3kAteHE5cR5EVVlKjMTeglyy2SaTsGOac8EQUXL9JUssJxNWdzHbuPB?=
 =?us-ascii?Q?+dla0njAFNjUvv4CTYg8OCrisPl91OrFEHDDgu61YkDjGe/W+RTwoaUy2FBd?=
 =?us-ascii?Q?RsQd27P8tzeIqFCr4EbJao4Ti7x3aNdc94w3sO/QZU7GecFyWkMuhgocxObD?=
 =?us-ascii?Q?xuNh9U8Yc8NOsPl6RUhZ9d22mKyE0QJV62aCEMrpJpUKgeaKwYnFhP53KfV8?=
 =?us-ascii?Q?84i4s2IF0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81b25dc-b56d-4bd7-d51e-08de9728fb22
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 17:45:40.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OheLr6ZOBzW/WmCh58QeKEmBhFZgvxf+g/bfakxRGJV4MEM3b+bZFg0dhoeylIB/JFEDzNwGcJAFhqu6ItHLRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

On Thu, Apr 09, 2026 at 08:30:36PM -1000, Tejun Heo wrote:
> Hello,
> 
> This moves enforcement of SCX context-sensitive kfunc restrictions from
> runtime kf_mask checks to BPF verifier-time filtering, using the BPF core's
> struct_ops context information.
> 
> This is based on work by Juntong Deng and Cheng-Yang Chou:
> 
>   https://lore.kernel.org/r/20260406154834.1920962-1-yphbchou0911@gmail.com
> 
> I ended up redoing the series. The number of changes needed and the
> difficulty of validating each one made iterating through review emails
> impractical:
> 
>  - Pre-existing call-site bugs needed fixing first. ops.cgroup_move() was
>    mislabeled as SCX_KF_UNLOCKED when sched_move_task() actually holds the
>    rq lock, and set_cpus_allowed_scx() passed rq=NULL to SCX_CALL_OP_TASK
>    despite holding the rq lock. These had to be sorted out before the
>    runtime-to-verifier conversion could be validated.
> 
>  - The macro-based kfunc ID deduplication (SCX_KFUNCS_*) made it hard to
>    verify that the new code produced the same accept/reject verdicts as
>    the old.
> 
>  - No systematic validation of the full (kfunc, caller) verdict matrix
>    existed, so it wasn't clear whether the conversion was correct.
> 
> This series takes a different approach: first fix the call-site bugs that
> made the conversion harder than it needed to be, then do the conversion in
> small isolated steps, and verify the full verdict matrix at each stage.

Thanks Tejun, Juntong and Cheng-Yang for working on this!

I've done some basic smoke tests with this and everything seems to work fine so
far. I'm planning to run more extensive performance tests, last time that I
tried to brutally comment out scx_kf_allowed() I was getting some small but
consistent performance improvements, so I'm expecting to notice something
similar with this one. Will keep you informed.

Thanks,
-Andrea
