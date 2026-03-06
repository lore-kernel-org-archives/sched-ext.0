Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8C26A0C7
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839262; cv=fail; b=C+xA/Ccyan9NL0XlUM4nUJswvkkoQqsBt/kAHVpdAb0i3nsrnZ1i4roP65GwnAo5Oxe9L3DisT0HVboULYyph50jV5LllyA0H9q2ujsTzR2lI3lbq6CZPnk9lzawD2Ah9TTyTCE4kgrPb9SG54ONZKMFFe9TQxhhiR+S/F2IA3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839262; c=relaxed/simple;
	bh=oq58rrWwAgrIK17cQLRnuG20xUYlVHrwGAJPZWuYdQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=khmifTm4z6Sj/eDiy/rdGLCXRbqVfGoDnbLutcDHaE9eb++AFhzBWbvsO2oLrvt+oLramN2soe99WZ5lHXbBZCnblHpG5MjvcdSLJhr3iZJxxmPFmBZ1H7FxCqMFVK9xlrELC7llLXoJH1Ns36s6b3Zr9sgAkZmwsajq1PYrqMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZS8vrb8D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PTDihNOL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZS8vrb8D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PTDihNOL"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626NJ293383734;
	Fri, 6 Mar 2026 23:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Pp3FhyJnY0mRdgnt9D
	7AVW5vIz5a9ny/bphT/h28xQo=; b=ZS8vrb8Dw37QxeDaVV9uvczMNLK4mhgOYn
	2ahZD/zvses18fLYkLuygCfPnqiElVvCgXzYJrsD1/o+dZ8y+e2QdUp7tDaQI1Jr
	mO4beYmyqDRfhobSSS0cFsmPzmQRMoGCtZCdj76OUuYSIxzKzlpzbsnTJTt0tsGe
	QBHbzUUpdn3emWIvG9WWXwSjlWostGMdwzdZMMWFj3QQHB8jn5USiuGcNvRxeYvo
	p/uo/YsD10jj9FYjU8xh5FtYe5hB1JLyeJDGwVFGIJs4dy4IWnwlRyggOqUBy1l6
	fAnkVbfbdWZM1StSIKZMUh4qsIBGgRKyVtdSmh+JWZ3E/bDfUt7Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cr88jr0b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:20:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626M0sF8029878;
	Fri, 6 Mar 2026 23:20:53 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptf8qyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:20:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gskvU7raVCQ3dLIh9OJ9F8WlMUWiWQAB6LeiB9Srzs7QFmNSKShUSXUKU9uM4ksodj311CSdH1Bbnk35C2hN3ILrJog4N8DJVQ3jsfuPWRaUyYfGAdWlYs2qJAlYGAeliFIZjmfCjOvbv7zEopuf3EvQ7x+7ZUROmc0m31mXdqZlGhrsKGf6UZHJyEILJe5WF5zd1yoHioDpPbcRcffmbguz2JMTncmp1aKtMpo0GRjMxDFVegjb1OH/caEbsLCZWeyE0feqSoJuw5nfK75rAzKdqzgQYuQyrIs1faHOYbtxcvQYwuQlBY58yyCXr/lduI+BuTYf6TPaIvQuIlpTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp3FhyJnY0mRdgnt9D7AVW5vIz5a9ny/bphT/h28xQo=;
 b=sDjGe/zx+NgMLQSRtOcLDFa5zkBNcyT/z/ZZ7GBUTUOWMAWsqDMZSzIIS+aVkygG4q8NVaWnBReZuxg87CbpIlrf805l86SdafSgHxNhdXIgCNGacSChyWvoYxwn9Sf5R86hCn33Kw93rOGGc2nhZ2ZGgNA9ADoX9eVsQiom1eLMdNQ7KDEL7Qwbs2QGP4pq/RmdQZ19zMTH7qR+QBaZA4zPvnX9ChooKimUeRsf+EDMhg8kNa4uhsC4nZ23SPazfXOBQdU3vrXGrk2cxn6Um0YhdBZ4a5bCiUWyQfEMWtOkohHmuR+CwATkagBdGgGNulLLZOsoaTnA2QDL2U4g1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp3FhyJnY0mRdgnt9D7AVW5vIz5a9ny/bphT/h28xQo=;
 b=PTDihNOLjLovsxdSmBHRLUsPkzIO6Y8258kcOj7WGKMnWuyeytdGKuoLjoPqVkjxNJMIOKfPP6sXBd56K62CQAGvY4a9/5U2gJO3MGxumswQcJBmdGinieP4Lbs/hGPBukd52wsamqLe4WoMyX3CJUyrzJY2AjyAVb+AZnY7Xp0=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by SJ0PR10MB6328.namprd10.prod.outlook.com (2603:10b6:a03:44e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 23:20:50 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 23:20:50 +0000
Date: Fri, 6 Mar 2026 18:20:48 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
        void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
        emil@etsalapatis.com
Subject: Re: [PATCH 02/15] sched_ext: Wrap global DSQs in per-node structure
Message-ID: <aathQ40Icvz15yrF@dmjordan-vm.corpdevsubnet.oravirtteamphx.oraclevcn.com>
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306190623.1076074-3-tj@kernel.org>
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|SJ0PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 31030f0b-803b-47a5-4b5a-08de7bd70182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	Hd1SPxg1m0/DEOjLb4X0NbnPWVKcjMB43NqC3x8Kv7iUC0iGKEu26bGUm/CmgedtY1kusbyFDwWrx01GpyoYNN82J7eybbNp65Dmrjubil1u/o5b0kutG18RIR7Ny+ktYHBJHy17JV0Fuigvt1cYttYeDu8fxmqobE1iGOLebqbq6ZBVQsJRMyyR2RvrUBaYaHMDSlLxHuxkaKtiLYOxdpGUitzMNefnj2Tg2wMutUWIxHUdT8IvyM4OWSkONIJ9qbyu576w7lkd0aGUDNgUt9XxbITT2yawztt2At60r0DXaanLJ7X3gnCDqFcRglHQFRVseI3frH6EQo48ZGaEioPsXUAbdBNmJYetbfa/FJs6SLxHsHLqcZHgv/M794tXJfYftW4l7aytZg8w1KQxeM36fiYpqMrU56iWMDnFzkETNGs63V3UKE+ulw8Ayly2FaDf9sqExlZf6V1ohPoUIdsQ70cyRpdFIvTgV5dcmNUO358ReNGpKacrxhom25GNbkN8uH7IxnfnClgdUTWh/NzCnozqReqJV8rp/hFI21IzLpqch3t8OBSX/5AAcj1dgf4yRH17AtqbstO9Y5yzBPTZU8V2ukQCxriRbnYXTaTApWaLaAb7QltesflwqVbR8MGx7TFsPQfYCrs6t9B+Kq3EnWrGps6LFXH3BcEI1Gw92os4GkyfBYv+F7BpV95X0sn0pGhr1IqH1HQUWC8EhcOa1tHeQdlT2iNzD1ZGO4c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hnJ5S1Yl4/xVGSAIziae8wU2xgQrPRNecd+RVAQT3fyqsY3cnVuxzVX2dyOQ?=
 =?us-ascii?Q?O0NvQ0D1A6H4Y5a4uQ/s+QA+GWOJ2X1tQDkW6Ki42Iw4LyPILwAH68m3VZR+?=
 =?us-ascii?Q?ph6IsuaVrRMvBh6ptuY8+Yg/CdfyFg9fGF9bSVEVPNo3qBkXeYSeOjQIlIU1?=
 =?us-ascii?Q?uIToKTKCH7WCv8/y77TeuoyaP2v36cj/oragjvZorCMqGOp/szGmXnNZ5cwG?=
 =?us-ascii?Q?MCLnhVl9/DzMj3WkDKLWZQ4V2S7l5So9Fzh8p9gIkhLyGPVFjJQU9TS1EOUE?=
 =?us-ascii?Q?LDjUb5rntBFOrbT/RjX96xhZfGy+R+paToXb7Kg4G8M5G/yJDNcrfHx5cwPU?=
 =?us-ascii?Q?SYgSaj1x8J3oCbq4plI/d3GmXD+PZ76/6dkesHoKI60eHanAqfstuem7U2Fj?=
 =?us-ascii?Q?bK8lrKSOcSynVLC2lnE27Tla2+dye+eTOc6rva0BTqEtxhB2I2XX8VlJRxnX?=
 =?us-ascii?Q?HUreCw1McfpJvasuQjB3xu1eedKzTw+P0aBu7T8BbMTXWwPVENmh4Y9r+mNm?=
 =?us-ascii?Q?4m3j7kSJzi7Jjip9ycjfH9XI57WrA+bOyhyF3x3iGwTFi7f52nkK8HidqhqM?=
 =?us-ascii?Q?gFuZ2oTwF1zxgLvqRxENMg6U6UCSVgSr+7Tu0o2avaG0Z3Duw7ZGuy6/7MVi?=
 =?us-ascii?Q?wwcfrT16IaTBkFlbm2gDi8GV5l/G9Awbvo2XJAuec9pKXDavFZSdm2ZEUVnm?=
 =?us-ascii?Q?g0JrCHxnBZTUZiM6gDlblKeaIZA54kcZmEZ4uIkOosJInakAFilAkd+XJ9/B?=
 =?us-ascii?Q?eWBduXKV8+3RdnCY+y/NUHtfctzlsPB3EtXjIJxfgefSDugOjGC4AFU9OolN?=
 =?us-ascii?Q?Q8sidtLM/dQTRnyBf3cKBRcaSV+bDYHGsgnzxozCfAeB1krCym4MjV6KWR6l?=
 =?us-ascii?Q?sq5++6oyd2i6iKP0QKOYoAz2IYaXQdziBSpc+9xwTe3LCfeqeKXkwaN5ZssH?=
 =?us-ascii?Q?JT43fb6sb1utskrUWurcwx7Jy6LuRvsy1apW6WY4OwUHg/AKoNIcfIy78WYl?=
 =?us-ascii?Q?FeGLUFDK+oIIMdzQRnkjURbXhvmpUmwARHawFMXdxHqEuKggTMdkOeSAvVk/?=
 =?us-ascii?Q?XOWwwiQOqMVqQJoDft+oKSA8f7/DYQ0kO2FObID3L0UfMHmbMEupJAe0GLWC?=
 =?us-ascii?Q?ZGFVoQWGEwv/nPWFWqKpSjPGCD90SF3qjseYYygOZLETmA0H722YmC+VWav0?=
 =?us-ascii?Q?nOjRPq0d9pvsRcZpktOLZSdqqyYEGP7AGmkNL4cBEaqT1npZ5kxw4DoK6FkO?=
 =?us-ascii?Q?2FW/L/uK58qZ/v7tZlrFv/VPG5bFtj+DWdxcrYwIXbvAwsYxxaW0h9oqB0ep?=
 =?us-ascii?Q?DiGD5NleWDuxOaiQ+gSPtUPCymBeyLLiQ7iJtHP5BjN3+kkoatV76im2iU2X?=
 =?us-ascii?Q?xNRojmTkY6/LGgWGodtxWip2D5ZcOuCEN6OImuM2+rFxiMBS/XFdCHjg4N0t?=
 =?us-ascii?Q?+g6UMxPjjaDkHI4qpQh3xS50ejD5vkCTPa1pBHhT8CbpeHbP72h83IY7T/YD?=
 =?us-ascii?Q?waJg3ReZpaLuuaihXyx+9LgHqEJ+2Ve9MAjfTTvNT1FxOVTLeJbx9KPSPHE1?=
 =?us-ascii?Q?ogCM+9yds+vA0p52aNuIqkyNHhoAJGaQ5bdkYKsSYT5swZyaETmlUaUbfdTW?=
 =?us-ascii?Q?WptkJgNFUUM1seUQz4KtMxuL0lDPtlPmhIuA1hI0zmPOdmsJUdQ4icocG+mI?=
 =?us-ascii?Q?1d6mFqqI02gOXNC5BYKQE4AjUQpXk1p40QqMom3UL/ektJgA/TVQ2yrptpQE?=
 =?us-ascii?Q?B2jk1UBHbDJz03yteOgy/UYvN0kZ0FM=3D?=
X-Exchange-RoutingPolicyChecked:
	rJNvHeypvCNcElhwFrfxzcE8Fuu+bJDaT7cwn9xq9oznP3wMuIOTVZ/NPT/CuLkDSROLh8chPfT9M5l1Kkm08lv4ChPEOK162hRLMIJRrqxOkSKSnbDmlKZQM8fFx+ct0UTWyP1pxJ46TjaObri2j5Ns2HkSPvaJluqHD+92u3sDeQh6xHmp/JnZYpkiyMz5dxGYw6TIy6imo3rLIKDGjUg94eDYbHvRBRAf7N4Pc5gR9oswTWY0P8q/s+T6+cqlzYKyisGynNuuz7gd58ptSBVywB/HbPnBy9zCJJvSrV9y6MKhZE0d48XNP2sFvYr7pItOVfGbtPlResCl+MlP8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vK4BNg6LnsAaWoD0ro7NDFG3mqvKUgWnLpdNjcUinj5Vnsr/s4XtP9PqNtH5zuPVknzrbY+x65ooEuAoVShHG/IipgwAXE3RPpXJ9DLk7ZYNxw0agIxF/eWCOQKxJADrc4O/kZDvpgMhgoAmBqiugxTv2R2Tzl8dFTq8G9efN6yWUI2nb0G1JYFWEnQjYrBV1N4V6ZPq4SCS8KA30Kav5RdP+FM4sYzluctT6ivLlpb+YCyuJG6639bj6zG0hRbnB0tUprCxBO1q9CgiaC5zpT1FRtvikshDupekihwtqXzL1pj/pjiqAR0k6EiJDB/nIgUGiai4AtiLkQwvYYOjPH84d/2j9Q8seo+DC27geGfK6YZ//lzBeen1tdL3nYh52PT3AaVIg1Ib2eHMK1Ffo7cWcBcUb/nyKpzUsN0/HnRx9sSvrjFSK6vsXqX56SRESB0uurqJL1d8tTCCS3HrIbhh63XkpLdrIe+lm3Bj/bouQ3yA6gzuNygkRovWx+OWBJePOFjlkx7kcy+51Bd+lITNMcyhcK1knXPt6SPDyRiJxIKEv9iy4H0Ah9k5jj+GsKWJ82q2qmmB7Oa9O9DXcCH4a+LoSGgZhttDVpj3eSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31030f0b-803b-47a5-4b5a-08de7bd70182
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:20:50.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQ+ys/DCdHf/835M3oegUbKhoEFq8EAqbOJHZYIx/llFOlRT+I58sQ3zJp2b6AT4VMw/Dp7T19uI+q/FKi6/k+Ol2QxgLhvLUyOAacPH+3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603060220
X-Proofpoint-ORIG-GUID: E7Ns-p-WA_sMoWIiikzBXO8EIIxxBsuc
X-Authority-Analysis: v=2.4 cv=Fcg6BZ+6 c=1 sm=1 tr=0 ts=69ab6156 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=k1MChUltrRICuQFXyhcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIyMCBTYWx0ZWRfX3l2/aZbO2tmM
 Q1uLgh2NLuUrDw2/VxPnrlgsAO6muM3gdAkntXM1mL3DBSX3xpfEZe8yZRIcudm99oLn02GJLgX
 D7ynhSKB5Y+4ceDY+gibdJaAJ5JKRklyV0xfNRXzAj93VMjEkJ9SDr9g7aZtJGrK0bB28BZsX4P
 9JZf/1fTHjDRa+ecdHcs4bNw9TIcjvDGnWKn5FLZ4RHrQhP8lKBwU4f4LJ0h1W32ahGxJYeqpNg
 mJPydZEJJXF8uDL2mQU74p5o//fog2dQfuAnfkEAIp7vz5NFsLatNM0pyWSebIK4oV7v5liltFA
 XlsYS6TliphnihUhuUhdl7xMcXJHZ6dot208NH7jXKoFSY/akOWe/pppaW85pzrgctJZO8KU4vy
 Uau9EQJuz6oRKpzG7RqeX9POdjCMYQu+T1lUzrCBtgpONSe1EOeUGG0b141Hv22L0whL8IuHn/o
 oQ58y6shLHpHsBOoL4A==
X-Proofpoint-GUID: E7Ns-p-WA_sMoWIiikzBXO8EIIxxBsuc

On Fri, Mar 06, 2026 at 09:06:10AM -1000, Tejun Heo wrote:
> Global DSQs are currently stored as an array of scx_dispatch_q pointers,
> one per NUMA node. To allow adding more per-node data structures, wrap the
> global DSQ in scx_sched_pnode and replace global_dsqs with pnode array.
> 
> NUMA-aware allocation is maintained. No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
