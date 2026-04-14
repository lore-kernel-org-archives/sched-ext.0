Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759A35E921
	for <sched-ext@lists.linux.dev>; Tue, 14 Apr 2026 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200476; cv=fail; b=svofIxlNQElr539Thwo8iOo0SXNTBwroL50TPRfdVVJVYMRojcefzMBqxkWuo55C4C9XLlmrv5t1yBuY7l0v2MBdv9b2o4YK9/ae7Qb8Ehoyrq4qCABsNTAbTS/io+9YJUY+xhJjiJdttPJmtVTyufAu9rnbKEZzKJZZ/jsCj/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200476; c=relaxed/simple;
	bh=HQChTyK5EZioEvmNsKW3xOIzwjx0AsmtNzLNp2LurQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m9J2xXer05X0llN9dr8jB2OjG92gzJfInXPwWmNmI6AGrzTudOYuXGVblwVCNxKSQmfC1IQEswh32Tx/QMDHAwRjq/DTegnMtcoRnGcNvJ8JlDQG3sPCzanThQXu9JPl+Hp650sxBDuNVmGiArkVbW9yRc2h8JAKWuyJL2SNX2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phuI9kjj; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phuI9kjj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7ggwqAGrwFokb6PXN1ocG3LSKT8wc0PVkJ75c2BQkEH89DfrAo5e3iXCY/QDJhte5iUwZXb6NXiYx8GJapjgWJf1t0AOJGh8RAYsz5UFTgJeEuhYXMkY708Uq65DEoBtVqBu4Nt/syJvWqh+dSAyakt7BDZEoARqyZ+H9wfOTJe7Y/O5NjjcK6bNc0lKQwOqLQinQmptcxSEPycWH24gc0u6kuDUOsCJJa0AdOqiNoA3QKPUF7jh9a/sMuTkNHi37LSfRwBt/Yanqfz6c2FFSGmxdbqGPSzpFcRg3uSmXjuYCKbVSrujdUpknTcJx0btvltqVcpQJbIDppd1WtGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqi7aFebKat4zoyjbeRTySqM9la4BZmSIMnWW/CsrP8=;
 b=nACzC5ZdjNoDEHIjr6o/u58XQxCBU4OJ3CwO42KDX0Vmy/3SXRqCadoRq6YCBdfz7KwnomFIV1CPw0gGhGQspaqKUecWoeSSDRxG2rBkB9w5UMnw3C1GOCbNCI1mKlZEDlk6BER+sofDqOxgNX8zdsQNGudtELrvufzR2B5GJddgq7muxZxjN05tUHfbrNMZNlprGROzQuRjBZ/EnEbXxRJiH3wFkEG3GrEdEsibKpBG5b3dCpoffOYXjgEqpOn2t1V6OgQ6x97VqfBI7FsobYn+0xYU53PxjEAQKB6S/sgxIDYyKhZ908GNGdDnRhsTZ65EIZExkQVSRU+SzYpgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqi7aFebKat4zoyjbeRTySqM9la4BZmSIMnWW/CsrP8=;
 b=phuI9kjjc/exdKsmse6h5xSz4k028EsBNMVr3/M2J4+ot+VbZhdiOV3O7XRrRii8NqtYa77lUuzCysrQycAVlfuu/vzv5rP9Cfq1btj96Y2MXY5ZwdezZNaoX8jiwS4xHAmqdThLA2NIoXb9SihP9t7KbzZwxigvwXmfW2U8QTxkdyaJmuwwv5RZIQ17oW9eYxZWZzwvYum0k8T5l+YTZiOTqNcQdVJGkOhIIQxsN0ee8UmKE8HTw2yYotZ3hKpd4eNGQ/98Naf3o4AvXiGCukdU1tUhq3LEfa5k5XqZ1dhM/Gl/nguxjBjaJxnhNQJwqqczNGS3FSrbnl1spBe3LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 21:01:11 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 21:01:11 +0000
Date: Tue, 14 Apr 2026 23:01:00 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
Message-ID: <ad6rDORuL6SAYCN9@gpd4>
References: <20260413110453.357198-1-yphbchou0911@gmail.com>
 <DHS4U9BLRCPG.1S9E4BT1UIHQT@google.com>
 <s3khi4ec55rog6tgbgxip5skqjdhimcemhwzf3h7pbbvxslnu7@5r4v7jbv4w7z>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s3khi4ec55rog6tgbgxip5skqjdhimcemhwzf3h7pbbvxslnu7@5r4v7jbv4w7z>
X-ClientProxiedBy: LO4P123CA0528.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::10) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f939be-8f51-4cb3-f22f-08de9a68f511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yD5VvIltPERkQopR98GKoUVc4X4VDVaa7u8pcRD54bVqo8RUcsa/BzBR9BDbMSkbeHpUqGf/sj0l7KOnbmtag7xmnkszFj0BORdAoR2ddVqh5MTOM+5Hvt83jWQ0z6qSScIHTyGUXWQAqXZWHPkUyxr5QfE6CI7tK0OYnKrRTtyinQbKEOVBj4HDqCE8ezrht4bSbC4RPlVL4SXgEbv0NfF0el05IfXZq/HAKvFsl6L9tzzj0HZhp/ZdDBkad2elQ1ov6Lym3KoD++vOhFPmyD0c2MugjUaK6jo5dyZcL4Q5BzRXv0Oad5NgBFXYV0f1lClp66vGSIe2iWZPLSBNUHbAgIa4x7FPfs2z5XH4+muqB/3TzDwwslWcxtmNnA85rHTyOHlKS+nxpjtc2Oyyr3wc7uDr0lnC10I0pJq35p7mgaumgB9HawiKiHs9O3qgfRuD2i0NLjEihXRK9PJW3g6NnpNJYFRzEDUvXwFlNANr63oBDLt5v0EPSmvJNQCOci7uXgF6azSFH2WrpFhe2XEBBH4XpiZG0yDK6n20dGJQFjnT6k7t7A1BVV3BvXrAjYNfYCJ+CQpOHgSvoM4iVFacuyyCAwcCduC7VA1HFw+d5ZZ68+ZU710MXcW6hbLT8czwcXJBgx2Zr4aAbUGLthipdWtvX1yUGVBkR9e48vkyqlul5VhSFYtnvzNtlH1AHZV5ICxJqOEJHVL0uynzq/paQlnyLcoveqrYUJP9IF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EDyY7xmiNt/eDsPYWr7nMZ3t3BfGWu2cZszLIO9R5aETp08+cMRWQwzUCzbS?=
 =?us-ascii?Q?2U+ZdNYbiPzzLIrtog27rGULdJX9R0EDEHGEgw9E5QJ2vWnoo6BiuhVa4Dzd?=
 =?us-ascii?Q?BB7ZZZZezAZPsH7nkYnvGCQ4sEP89z+8JTS2THDzRQXocfOsXZILhQPoRaVO?=
 =?us-ascii?Q?6oZvb8/P2bo5wqhosU4n7hoQangPX5TIGa2jgMJEV+QPZ4/ovmPDu55+cAcE?=
 =?us-ascii?Q?XLcLACXH9Lq/vs+rcwCj7JduaAtlMGvgtlBpU08G7X8lbljVf4MZSRRXw8lR?=
 =?us-ascii?Q?4uVVCIBm/BQFlvTKQnSdxq+qiMyCaEz0tK0I9/bLuG4UHm4v85irnEWcLLmN?=
 =?us-ascii?Q?HDAEYso1E//DkbPowKPwDMW+bfkZWKrcY+Z8tHusdHfxqIePbsVeLb36EdVC?=
 =?us-ascii?Q?Vrzkx913mt1OaB8I1i33JwWFYbp/xQzpDuwZnecWYxIjq2kP/qa4thMPEjke?=
 =?us-ascii?Q?pjTg1Nz61F9mXKustasKCzi2aTQkRxbhMUdakvwIjeFfMFfxmEIiLJpG5vdd?=
 =?us-ascii?Q?W86gNS3h5H6ctDJiCBV51W3rd2r9ZRniYXX/+FO2qiw/a34slVay02uXoo/b?=
 =?us-ascii?Q?7mwQTCOS2wuQWxAFIQa4451osSkDcm48OESdDOPc8dpBOeFHA1SOLTbOghZi?=
 =?us-ascii?Q?Pi4sRbcZ7dX9I6a5jaFYOX+aIcT9ZliKgXbTJXlQMJ7udg48cX8FonDt9SIF?=
 =?us-ascii?Q?x2ap+zIFiLYRe+0UbvUwOxiDnpKMZSc6Azu48is1tIXGtVQ/4tx+UEd3Ibgw?=
 =?us-ascii?Q?gdX8gII/CBElee1mQjbLSpLgH8EaYKuUHqhmUIinMCNKDzNXxVcJpb/a51C4?=
 =?us-ascii?Q?ri0fcprq7U618pbJmix0vr/g2Xcp4F6Q1FbrbRtQ+WtZ3e5xqfhpYqQkJLB5?=
 =?us-ascii?Q?GQGNx/EAKFyamvTRJqjePKQot2Ku+M9AZf4BIIdT+3B5EiGGCOUZ15sLDYub?=
 =?us-ascii?Q?A0XodduChp60q0f1f/o24F9NfR5t35x+FNBQi5+aySE3zXYCFjss4yDP/siB?=
 =?us-ascii?Q?IX3ABIDu5g9jWSPA2BShCMLG5YXj6zCx6/NvKtgFvcdrGGY15Eyo3ekmMUNF?=
 =?us-ascii?Q?dT4+sYOehMYAYENUwOtj1RRtfeVQdgNV2aub3O/RON+wPtdeBvLZEuuLzXne?=
 =?us-ascii?Q?ByNQ131wNv8C5lLyx4oJ1UaCWjQAN/77z+3mq5h/bjvKRj9/NcKhxoGlf5jh?=
 =?us-ascii?Q?tcs7sEtOwG4e/BSC9hhPd2BMTOhrftUEjbHh4NKaDAIYD6eRmNO2Xbz1iwJY?=
 =?us-ascii?Q?KTbuwgUNPtwWn4K8Ft2JsV9fnQTN+Hcj9ptKu2yFf3tcNuRdvMIWSyzGRp5K?=
 =?us-ascii?Q?2VXsocPUiscw5ZdQaHtPGudxFItdT7XoDLqqL/uKcjbV6P8s0ZJm6366cPG/?=
 =?us-ascii?Q?85zj2L+4L1QGMSfcjYle8ZAH0bLExxYgNQtwmWqFr+AtF8R3JG7uNRlSJU8y?=
 =?us-ascii?Q?k63HKr44xmiP4M/00A1PFxiAJmkEJ6fhkgsqLa1AnfnZeU6T0eyHC+I2xVEG?=
 =?us-ascii?Q?hDDMmoKkL5+Ke3WFt9nauy+5t/qsnHrGUctt0T8GPApIeY5xNLfJO5BW8rZX?=
 =?us-ascii?Q?/ogHR9LN172sSkXz81ukYyNzOBmaiNE3DYHCXanZYzUCdzDrFoMU1OPFCDkH?=
 =?us-ascii?Q?/aAJl3UdgrBauum15ItAFT67VzN9jZ1HYLkIavVWpfYLUON8mm9lIuEerQ3p?=
 =?us-ascii?Q?OWOwyLLB68zjMKZ+/r7J78oJBjbT16Q5LCrA8miZaJZSqScM0XVv/E2rqJqB?=
 =?us-ascii?Q?APOlflI+Zw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f939be-8f51-4cb3-f22f-08de9a68f511
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 21:01:11.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WATEoM2xfEJnHp0BjnS3G2XhViAvsYpXnY5szBUu0J1EuU4iDFARG7jn348eJ8bBFPPJNi5yMSTfxR/87UMXFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806

Hi Cheng-Yang,

On Tue, Apr 14, 2026 at 11:45:59AM +0800, Cheng-Yang Chou wrote:
...
> @@ -155,6 +166,13 @@ static bool dispatch_to_cpu(s32 cpu)
>  		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
>  			__sync_fetch_and_add(&nr_mismatches, 1);
>  			scx_bpf_dsq_insert(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
> +
> +			/*
> +			 * Kick the task's home CPU to pick it up from the
> +			 * fallback DSQ promptly.
> +			 */
> +			scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_PREEMPT);
> +

You can also pass SCX_ENQ_PREEMPT to scx_bpf_dsq_insert() and avoid calling
scx_bpf_kick_cpu().

More in general, do we really need to preempt the CPU here? It'll be preempted
in the central_timerfn() handler later, right? If we preempt the CPU here we may
have lots of preemption events when many affinitized tasks are running (i.e.,
stress-ng --race-sched 0).

Thanks,
-Andrea

>  			bpf_task_release(p);
>  			/*
>  			 * We might run out of dispatch buffer slots if we continue dispatching
> -- 
> 2.48.1
> 

