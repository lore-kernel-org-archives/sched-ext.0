Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532BE3F328D
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304095; cv=fail; b=YK0JXWY2SJ7A+212eIoF0fU1ZQmlhwcUHaW4zohznDXoYDzzJxdY/yH96njifiR9Rtybugzz0TduJX9LMzDFxjc7fM+chDFSp4aNHW2suHQqqtpnCq6oKmmPolwdoHpWvV6q4Mq/JaYAKBdS7Mo/Dw6a4D28TFVnHqDYptaehd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304095; c=relaxed/simple;
	bh=7WpgTxm+vZoC2PCOVLiLeEOfcD+gSX/cAdcJIhmjGtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qi0vhmlSBBCn93pCWieRe2t8dQ+xuG5H9guipECDyFIOGb5gG/KxxZVCFeipH35U6Xtz4iKrSeQ/TUTlS0fFoFccmSkg8mB4B6VBTxbzZxul9TCq0VScwdFHHBBAm6UbTMCJ89jJ5zEWHxGMwoKln8Tfr1PDzgrxOO1beSMpgyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d0XU44WC; arc=fail smtp.client-ip=52.101.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d0XU44WC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijo6qnHaCupp3oT54Ct1rCuPIlryyBrnQzj/1k+S4wU828aid9uKy3Rotko2j/e9v6HHqWuLbCKBDClsq21O6FyNKBfZxl5/r/ymdUAdu+oBDWtpNNulsYq879Jp9qGyHptiiK+8CvBPiN2hbd+s9h+Py6TxXFl903zMETLVD8jDvzwTjlBcjXasuQpXK4wx9E8OIaP30abRelXdlryjxQIr+rje0Qy6kNqJ6dAuJAf/MUrBUWL/EmxhTpuyBS8qp28NBPkJT6GyQUK6dLJsMeu73ktqF86s3Kxp5UXZggnRLqcR14TVScddey/zBY/rKSgxVUyFm3Jnl3ncFMqXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo+YVetHLXvScvaCulnlx0V2SrQhgpWgrhjBF9OBVDk=;
 b=A59VxT9GcWh49DolCc8za1OnU9G2tTIb7QndSEh4TnfrDZ39/RtCVwCvylnIvX4pk4W2rprFxj4bc+qerHUC5XFsjtlSiTjlIGcBOE2XJkHrKGzsUtAhcL/WiiQdVya7+0znSiSxIW/5deR/mgBLP9Q9h5iMGO0DguzvpfnelBWuhqWrwhl3NhYXGys79tWIpUYWSXp4YQhzgOJkHb1Nwif+2Iai9ndhRw7j4S2D2WyElT4HeZoj+BvNVcZhuIKPmTaRFGYq5Kjl5S5b+vbrd3GqnPr2miLhWeHmfCT+ZEILsk4S6KFrryh6z937LktVKNsexXxUiyAMi0d6JwT0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo+YVetHLXvScvaCulnlx0V2SrQhgpWgrhjBF9OBVDk=;
 b=d0XU44WCYOSiaSqRq8qEpkFCWI8+6TPkCsW1zyoeufPFTTrDL/qEywUDAi/qS6KZYYdIdoBF8eCtED+aOboCXcGQ8KHFT/IvhFwCKIUlfvuPrv/KTFsr5Du9FdA6CzT9gkEe87+abFYaeHIbV/lE0xMgT9IzGjoQDJ5hhzU4/ceL91tUAdKfi7rW2VQkm3wL4rohRH91n5zreFoQ0ACLMOeMRua6bxWwrOqkkwlsix4nvyCcdj89sS7XzAlSXk7AVPT9/c1mmV3TTQxH0ROEzuERr2gvwIChbGY7eD7qfl+gxtPxMyLntvscv/eWmlOUkt5Vov+dCZtG2a1uiyiDPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 06:14:50 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 06:14:50 +0000
Date: Sun, 18 Oct 2026 08:14:43 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched_ext: scx_qmap: Also re-enqueue stranded tasks
 with scx_bpf_dsq_reenq_task()
Message-ID: <atRj0-2apF-LkJng@gpd4>
References: <20261017223738.993262-1-tj@kernel.org>
 <20261017223738.993262-4-tj@kernel.org>
 <atP_f5S5v_1V06L2@gpd4>
 <8cacdbb7d499b8a5eaf09d052919dc05@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cacdbb7d499b8a5eaf09d052919dc05@kernel.org>
X-ClientProxiedBy: ZR2P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::16) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 6762f433-1889-49b0-ca08-08df2cdf1dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FaRRxza1TXWDWtGskZJQ92wvPLshitCOmeV2MVVZpnKjJ0hrDSO3hxkFvt2N6jjrMoeBFUFXKQGFpcF4HdAUKDKmZoE1xKya/BLnBXmxBWtYnbgKlPyvebL55hmeL17wJEMncO5d28wXMO4Z7nvabKv5wobQzj66oOhK9Yuzst3Tl9nbG+VGMJxrfyhSmZp+UIWN8HWj4Py0IfgA0io/Vpe7sozYIVYQVC2pR7RohCK845reyVQJOOURiG5eGAEm/9ieA7dh2RFa3p248SRecjEfgqajJPo3glwCjf7/WsZ03xxxpzb3WzaHjk8F6rMJMMcfzwBy4gb2RgPwmq3WrrKkNb58aiCvbQhoaDhqSQ3aI+8B1wDIDrVnUHoFcg45GaFw9Kh9MyxSz7ikhmW/tC8nR5egnQFEbwGoQ1vu+8iB7rbHKRi0hszcl+huUFO0Ra5qiTrB5ZzjSLlueiKzk3HQuhpfo7SjNBUGLG2SuA1DsZaDiupuSZ1qSkKXKIZyc6p2yz6vQYnY1L+f8LOaGC7c4JF3hplkE6P56F4I5of8MX8YAtBsOWzbxtNbihSOMBAErP/f5tNcoFKN9L9bYb8dpLk5S2QnKmnSMKdVbtxHK5yt95xnNU5gpPfPKOc3XVBANMYhxQl8w1P05Qq96Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GhNveOxe4+pBgWiG5Rl6Hd+asWP6HZYWGOpeXVoaEAkOmUlPHVx4AZjU8IZQ?=
 =?us-ascii?Q?sVRIftyDUq/rLSfJ0vfVWL6V2Va8VSyUL6UEbdVRnweFxF7y5NGU6he211C/?=
 =?us-ascii?Q?NrP1xdOOltWieAxlP0BnJvPYDVo+f45XcBqdf7W9p95m/4DSR/gDE5VOIu55?=
 =?us-ascii?Q?e0Glz9W+qbmmrUv90PqKgF/VMsJ7BGDwfqBjEhxGxJDLi1mk1RJV/ucc+YwO?=
 =?us-ascii?Q?JKbtbNvMhnCm7HUGS1rXSaYdaXsrenCh4Igg7jVUdu6koZW/4aBVlZ++BAWo?=
 =?us-ascii?Q?/NNHsvoDSOS6FJO3bBr21UZGbZJU0H3Bu5oi6vX9wn1Vm8eTW0qM2iU6PfFR?=
 =?us-ascii?Q?53jwJufIr3cRqWNwOECDeCufi0V2pJzl1rYYolWvAXQZE2t7HEmHxm4VUCnq?=
 =?us-ascii?Q?n38TzitOCiPfRo4QgdH2zq6ODxePzqUkA+T54OTVmlFXvmjb/36uXgJDy6t9?=
 =?us-ascii?Q?qW72gmMh27l9SQWOCJ0l78vn2Suxn33eF6Um7xOYKMNNrMVKD+vqZ5EcQVd1?=
 =?us-ascii?Q?1NwgjJD8+iT5i3dnmLIXQsopY3tLSIjT2mCXAEUkZq9utBRdc5lfjb1ruCVJ?=
 =?us-ascii?Q?4usCueH+GjdbLCFYA/Y76lM6A2kcKPVQISQc4qlSdHvnVx3VVbbdGJqV3sR/?=
 =?us-ascii?Q?1Ge3TdIiUi8bG0t8BtyXY7mIzGzn3uSyeZfgVumHzZTSBo8pmF1Itjjr6P1c?=
 =?us-ascii?Q?JswMOtW0hTLK0EeCmbMXtHXrz3deHPnZZ3l1darjXohph9tYNG8eE8zQ5JbW?=
 =?us-ascii?Q?Ae3YZWrp2khJ2nATKwMsYP4nU/7HcUpZZeK5Yc8seIZ/qH0EC/lCuUkV2E5W?=
 =?us-ascii?Q?W08qdnyIXc6dJC6zjj139095TKOHAGajcr2teZ4iwvX7haUu+6CnTzMFTjmz?=
 =?us-ascii?Q?R/RgSOnG44zWgOciiUHAp72GCqoVXg44HCZBgO4bvjnFs3ss7cdl69QbDykW?=
 =?us-ascii?Q?DRf0w5422gWprDKdp1+Nu0pbGX00tY8iD+yXlPUPE92CptMuhDkSHU8hmsuL?=
 =?us-ascii?Q?tS4k0sNKEQiylB4/7iO8RmWIda5lm+FiMIdJmUQ7H5XqP7JDYevfoau4jikH?=
 =?us-ascii?Q?eCqbYJ66OcwNS/VYUJvH6GGM+/rFq7qxH5oFaQV/wJHbD/MftM1FAjnuu/97?=
 =?us-ascii?Q?GKK2INSq0xIarjOGbI613CRhSFTAGP5HQ7xWdzkwRQH66L+icc1X5n5RnVQQ?=
 =?us-ascii?Q?+FRgRbcvasR5vxEhzEYljNnHzOlU+w9qqw9S8WoBR4SMXTxL2V48KGCaYPbc?=
 =?us-ascii?Q?h1+HKlgciVQB63hfvJo6n6mTyjd2g2aCz+dIDFJljCGTqM6AiLs8x+MBhaIt?=
 =?us-ascii?Q?GjKGBCCNczws6w9xkmW7P9e2j2K6YxjOx1IicTMPQIKHqvJyR2V9LTV7UzL9?=
 =?us-ascii?Q?U/k0ZzEP7eFhNcDASVi/oe1ov/ituj0gAwjroNDbXUZPlC9O4eihDI6fGHhV?=
 =?us-ascii?Q?xausk4vBCBJEsPyAtRXULOKOopVp9/L2WZ2/9Uo65HVQhIesVUToQn3Qd5uD?=
 =?us-ascii?Q?yITf0MF+b2DqmTEcC8dREhqUQm1bSnhTVdgXjVZNfFDawF0XcL3nYD6ZWW1l?=
 =?us-ascii?Q?PaXF5FyTIYw5PA/zZ+XRXzFO9QkPLo+JrnyByfr+GWsDjJVAM34OiGDhtr3+?=
 =?us-ascii?Q?22mGu6h9BW/tBbwnUsFOY2A0IE/65BkpqpEys/uESWCPatzAINDCM8pYo80m?=
 =?us-ascii?Q?ggmRdKteieG7x3bs6zUB6y7wIgvG/OIRqRWSoIwzdqG1vfxFwVo7WRRPeY63?=
 =?us-ascii?Q?mlhkiLt6bg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6762f433-1889-49b0-ca08-08df2cdf1dc3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 06:14:50.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXarrXT7BjwZ8QquEosZgmpEy9wNKrN6gqKOA/8Rq2aHESaLELImY5gcHBE4eYHSh92tryGdAEsIYP5Bc9dyGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856

On Sat, Oct 17, 2026 at 01:35:13PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sun, Oct 18, 2026 at 01:06:39AM +0200, Andrea Righi wrote:
> > > +	if (p->pid & 1) {
> >
> > nit: if ((p->pid & 1) && __COMPAT_has_dsq_reenq_task())
> 
> scx_qmap is already 7.4-only. It implements ops.sub_cid_sched_updated() and
> ops.sub_child_ecaps_updated(), which older kernels don't have, so it doesn't
> load there anyway.
> 
> Given what qmap is used for, it'd probably make sense to rip out all the
> compat stuff from it and just pair it with the latest kernel by default.

Ah right, it doesn't even load with on kernels. Then ripping all the compat bits
is probably a good thing to do.

Thanks,
-Andrea
