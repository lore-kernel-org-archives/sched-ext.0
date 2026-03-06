Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E53783A3
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839298; cv=fail; b=NiRsM6czZC0kruxYQr6Qa9et9K572LBIhUMv9plT3RSVg1iZxOLSoD0y1PZNp7Bfxtq2HRd5sgMKowPNT5yliU8b77QpLk831SZNWeHcVSiQbZMEqhISLJWfG4mcbY+YQ2e3XVjR8mTtNiSVJGErL1gcrABR410GxbBv2Iq9tzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839298; c=relaxed/simple;
	bh=QKpTcojKIX0YsimhuquFMx+Kn5MVKlFxDB1UfzLbeyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pW54jYxClZD8pJsj9GBQEta2RpBUaRR9anM1GATfdOma1sNjecq/hdRIzB9LveDURemC5izdRuGervu7pL00H9fwGZdJAEYlFtKGdAVxLehwDG9jBOUUQEiT2dgEIY+wmbG3Vj2IBvwxNm7moEMH4Id43EiuOQ2LduCOOZt0Fe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hq/68TpZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OEEDVkU7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hq/68TpZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OEEDVkU7"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626NHnnY3715870;
	Fri, 6 Mar 2026 23:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iZ7HCxiHntiqrSinaG
	qrCvejjSijRrAYVzbUOriTXQs=; b=hq/68TpZsB92sG27JGsA7ia1sF1rZ92bSY
	aqytjVgz2gZKWz/i5rJlf8mQ+SUqOfouCiWjaxAt4sNz5PRUw7CK16C1YTBxAIwj
	gvFkAOzRW8HvtDLjHMYjUNlGMY1n4miQXEk1u9jQlt5gCLH8kDn6jTyPHRx1S8wz
	L+54++7VII8NLXjBtiFKuiv2lutPfBHHUdTKETNqJHj1h7MFMVp0CWQ7WlXNc7Tl
	DcMsWQ/kcEp+ydpdEwHmKmxImoHmi/kDCpUPyrskw4sxS9bQzIoFuWzT1ZIo3Tsq
	IORtOCSqQH13rG/lvYyniIZtxu7lh6guJKyiFo1M83HA71qYZonQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cr8fh803b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:21:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626M3gFo034689;
	Fri, 6 Mar 2026 23:21:23 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptkbfue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+DTtOG9FWCtzTOeNAGmMVCIPs4wcFjCBvlO/mdcX+5ObVi2bfSlE2HfDH82vNCF7pTzNxOBcUMQhkT/ag6jvtXPi2+FUMd/nxHT3CxRR4iMo7XPLYo3W/BoXzuXXmoliVxj8PXcQ5LzWvVgjEDvhosQAND1ZGX1opf6DIfYoFK0NA15NkUenHTMSCuwg2SX0GlW3pH7rMz7xUHfyQ7OeketysTZw3lQaDDQXnDEnTFNUaP553rjZbEkisc+trpG3zZsUomIfvFDwbrgp9FZsTsTCzxtUkQR9C6EYJ8kPMdokCbZl4BqMbT3olBwlc9adalWj7GmeEMeAeXFVCoQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ7HCxiHntiqrSinaGqrCvejjSijRrAYVzbUOriTXQs=;
 b=x+1lEXCa0ZL8kYnprFUsfRBQS9WasNIKovnr9pEnhBGrWx9z8sRm1HRE4xGUdskhSvzdo28YaKWqC1JbEERbJBiRkAdi7qJ+bs3tIEI7NDBKBaZie+AHz42cGHYxw7Ln8LC1x4vxEjFnJpcnnSbAkHwwFOiiIjhDxir7asmcSGnXbsqPvN3KdcuxhpBRjlkLJ3XB9lA17e5iRK3ZWX4zM1rOIO5Gta9CFgQrg7MGWEVUOC530fcsec+BPggWVuCGYTrxL2oAi7TIdvUs/WPyJyBnZkQsIQCHFEutCDgbqBCcQvEfKDtFw/rSL177TeSHVYlUxETOhn7aZUg/drSq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ7HCxiHntiqrSinaGqrCvejjSijRrAYVzbUOriTXQs=;
 b=OEEDVkU7W/nCh42/ckqJn9xuDhOqjkdBqt2/4vbFGS2EiORuZtsvWp6iOWYuooMiglf3/ztwlu6otRUA98f8hYiMpLdxE9cReMx6wMpp/OkkfMJdjIYS337uLHQzsfez16BEtU5QnchHo6Cqf6QX2eX8t+FcihVF8vtID0Wf/zU=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by SJ0PR10MB6328.namprd10.prod.outlook.com (2603:10b6:a03:44e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 23:21:08 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 23:21:08 +0000
Date: Fri, 6 Mar 2026 18:21:04 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
        void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
        emil@etsalapatis.com
Subject: Re: [PATCH 03/15] sched_ext: Factor out pnode allocation and
 deallocation into helpers
Message-ID: <aathVT2U3vKGWgR7@dmjordan-vm.corpdevsubnet.oravirtteamphx.oraclevcn.com>
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306190623.1076074-4-tj@kernel.org>
X-ClientProxiedBy: BL1PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::11) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|SJ0PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d71fc8-2556-45d2-6768-08de7bd70bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	/lMVmQaK/vxiz+vpSdVgyDccmj1yUrosARBBRHE4Rp+BBfuCWof6CYAGrxz3Bf0brSzdPwJlV4Jey+XtEk1zg6m2uA40c9Wp/I5Q6W2I7QCVc7gXWgwYV74Zk2NHymd0+P62fLfNE3A42N5ogOlTgrvdU7X7lJ0uoQjNsCwAnIl62FysWy9SE69ztWJRf69Oj+zbm8zf/BqENBg1btImalRLK+7/7te8H2lRXAK6WJt6fPi8fwy6+oAUJ98LJ5vqKrAkztLYefArIaw08nY37m17KJ/WHXPCw/jvTL1C5TgoJaNpwKoJt7akIAzxIHw1BWbRgT6r8Y2eDeZwPEk32RS3/m9PGUDhKXOctS7GLQasRj2EQ7Jg1Rf0f30cBckHqfGWgu3q74tmb3PWhjWOYwwnYJv5yF9/DRzzY+fCmjS2KQvvR9mSTfMzp7E8IsSwlRERPQs8e1u2lecycTEz+k75L7zbS8qVlTvmhE8+ai6UfM/wLQMk50n/qU1k4HYh0/4RxBLS7O+s/K1MeduaMz050D5jCMzJFTF/WOGBq4kbu07n+KhDSXFohz2ZveiGmKYKCSwsHP8iW9HyugmkrmCPKOoGh1y9iWlJn1OGTDFnJc1/LRYKmpbpz6jNpKl6Tah0tGBj2h4CLXAJTvLDsQvczEPOX68KPD0slh2ap3rPqJEhPjCLa6550eCueAoqqU7/VA+9t93SueTWxjW1Mvea5LwQ6H4l26p7BpEfuv8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DvPkvYWgtoadU9pdwwkcJ3nyn2hecpIbgbtQ5h0xeg5JSUQpJMR1uL4oQEmz?=
 =?us-ascii?Q?O82xY8NqxIVjMW8oa2aAKNHNhu9YYYXVkOYNMbkeWoUyd5Zqbq9m0Wu7N/4y?=
 =?us-ascii?Q?XbuWKRhmHETbyWhSZzqkZ90FpgqLQMtjf1wyNTO8flahuozu4GYiwnpCI/nN?=
 =?us-ascii?Q?DFEMdHK3E9uY8gY5/nHA9cfJ6jTJzFsqQeR10f2HUM7Ac3d5el8DtZqMS3O7?=
 =?us-ascii?Q?80LXM7wpvXc3DixMP6PXBlK82hXBOBZHz55uZQlGaoA16d1PuAANo7iROIIT?=
 =?us-ascii?Q?qM0AYO/j6zLN8JUslxEcuyZV9IHlEe63Dv6yWwQRZ3VxEaukDWUIS26W+p4m?=
 =?us-ascii?Q?+QTAH1jBm9yjfCsoG8q1v1L3+4uz90cO1nolwpqvIr52kPbKKw3j2Mqa00hx?=
 =?us-ascii?Q?wubbdF/aScNqhogc++kqp1EpgSLvAxk5gh9gKp+yjgOFWQxBkK3H7kj/z26u?=
 =?us-ascii?Q?kwpeO3u6T67Z+GcfIvwIqHZzmCOzC52TarNZRaBoQaSef/AVzaXdVie+jbR1?=
 =?us-ascii?Q?4RVKDzA0Pmwc7PAtNbo+j5xRl+jrvucNzfx3/8SDqTLCyZF5eFbOjjqgxSbY?=
 =?us-ascii?Q?dSgG+ZkneMxE6+sbuYZ1fl6o/C+hZ1HlTOtwDFVC6vIwIieAF0NsT5amltsg?=
 =?us-ascii?Q?xKEVrA8TNoDL7KPC2sJphfJsqOB0AvadXhtoQNxgucrgbtW2D6pJqyog7AVr?=
 =?us-ascii?Q?RH925kwhxona/FvbRWY8Q0M+ZzKCQPyGSx4K0nY9FjlnnWP1Q5rj4gZ1EJYW?=
 =?us-ascii?Q?7XtfwcecjOeYPZblhMGYUgMhpqen6mYhh5OiQOorGpXkKBkPgAkQcW2JrxQY?=
 =?us-ascii?Q?+L7lNNU2uNRLycI3IV1YBKm5tFWSzn+xTYZNPqpbqL+EZNUIwcDJgOfUqywG?=
 =?us-ascii?Q?ospV2PG+vPtIYQKbo+BkH+Xzws/u56nPbgEC3us3R+4vXCv9tJIzCwPd5HR+?=
 =?us-ascii?Q?guYcMP1oJynQhMvMPNAs7N4oUoRhTsdN6BCSbUYK3IOKF416tPVnwxUpZvor?=
 =?us-ascii?Q?3AKyBcAMwwzTDnzNnrqWnsBdVCXbHKHBlbf6qOca701PjasR19+47HaFeVZt?=
 =?us-ascii?Q?oaA/2kxEZP63G8SI7uhLYVG3Dk22jA5emBxbkXl1W46ixylZLwjSYrFcrfQE?=
 =?us-ascii?Q?10BQZieLePb5MxflHXw6gWqAHCwYAfRimeQZaixgCDbmRpl83DABKyofvOCT?=
 =?us-ascii?Q?bLzKxjPMeXh6ekDXQvErRwD9Jb01KiDjO7e62cFIO9dwYljFggY2ZfZv0P2Y?=
 =?us-ascii?Q?1BTX3tHpkyZkVsiPzwQr9QqOggfI4DGwgyDy52o2WdAfR67epAbaO9QNeNWD?=
 =?us-ascii?Q?3CuzmZ/qwFE5LDKqN3VeipSpz9IjeN+/Jih5r5Y/tNagCBGajpicksWKpjLy?=
 =?us-ascii?Q?fgFdUaqUi6hPoMiESBDEuPsgCKxmw9vb3yP7gPi/yynAcDFAeleDHTG27A7i?=
 =?us-ascii?Q?k1w28GPdrPhL8sF+nQd8gG6+cc1dv53eG1DV3vHLkpDWaXVrlKxWH/n4Uljp?=
 =?us-ascii?Q?ZBS4iKrednlvlfh2jDW6kBwmedzh2oymUoRU+XuB1DQqrLrWp1XPtUHsfzlY?=
 =?us-ascii?Q?5DOdJnfhR+2j9IDjH+c/aLfr+F2QWd8eadSHiYbMOMlQmJQnShrOxSmVB1iD?=
 =?us-ascii?Q?Nx9a+sggkjtKuZGEcpF9Soz7T5YovpKhhJaDr5AbWw35XLWhNxoQlZY4173x?=
 =?us-ascii?Q?qp5UzSkpFj1wy+cQl68jHnLlpUtRXiiCi2borDqW9PgI7zZUkDJBUlgi7JuK?=
 =?us-ascii?Q?coEoHSpkcI+aun53BEWgvjx26h3wXQU=3D?=
X-Exchange-RoutingPolicyChecked:
	dK5jhz2Exr9vZXroO4Wv+FMsVjodmkXBFZ/2E6BtWhLO+zIvJpcrZGiBeiiAcq/+lA5odR5tSt06/eYD1QyFT8yxfTmEQc41J5JHasyhFSly9lVxDf1BwK+HBWXYi80dz3bE2YUc9qRN7YZscX3zvILA2jzNF9gE6J9w/ZLtdKYJFliadnYlv5TdA5Uks/lLpTsXbjyKeDQDzfT1IkhXN+nRl0AOUVpYPDq+bxPrBinmWoUnbZRtsGhm4kfZfsMeF+X16tCR28Iz53VXLjSDU5L47QTggzT8TurM9du457nEcTgvpH7ege6+6WhnCGSgBnP75320lKxSKp7m84wnXQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xNfeZj5Re0YvNlmSwJB1vjrPdti5GQmFJdBvcEWW7kLFrxixy/qByBkhMxtlbXVRky0zSY8OZDcxEHb68pZFOUroVy2H0QSadDRdZD/UZom4OwOxGYTV9c01tTwFn9c8wooPSNZWeo7dd1QKw7aef5++HVpMG8bLy4kp2cz6xWAne0yQOT1K+Zzp1lEHuU0OBYnIJh0LuL7sDvCUW4fI2/uUEp9N62T2HfbD/fc5kb+pphSxbRVs8c/cfSlYtN+/JFqggtafHflIKWyccEWgJqciRpTbOH9hADZeCaA4ANYgkbYLscv985/eR98xEvHY0Ltu7WArkaTSEhkrkxRBooaC262crj6AUyiD4UCPj/Gk3jxrFmjE4pDtseZzzTLiWD0sEfL94hCEgjKlwR1FMOmsATyATYOxouFDQIhIWkVhkWcmhozEYrWDksaiKeSixkIeGArxeVr9BvsSWDsDD+Cp/hfSROgMUfTOzDmWi1kBuZ0pj6Alscld6aCxVtZWXj8LVpEEUmy3e53NRWnJtsN1YwRFEsXdwzHjygG/pRV6jOnBGnyvdLDz7btuqdnZpFSPWHD6jwqZlSVe3LZzwPM+mvrMvezwc1qD8dXHDUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d71fc8-2556-45d2-6768-08de7bd70bde
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:21:08.2528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX5YjQJ858jnRb1BUUV+nLlAHMmBclTPA/IjJQJ1xp6YczDC1Fo2v5ti8e8OuVPNiKxTAqW04Ydi64QRZopXQ6BLcVjO1FnpnaBzxkHnitU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603060220
X-Proofpoint-GUID: thuoCuzQtg07fJAom9eSflv8oxMRtAD1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIxOSBTYWx0ZWRfX7UHPPDg/Dyp/
 BFIMltuTzjIIyKtsuGhNJsWt/RrkZuRNMXdV0ELuUVwY96cYCpLKyoaG/bVKfXL2I7tjDuu2Ys3
 fxUnjDNZUrvtOdyNlSrTKTtY5jc87OeZE2Ej6uwk/qJ/nxk3A2yiUs2HSX0YRK6tozQKUhzzOlO
 bUMPq+0wi4VfaQU//7qMrVKeYCnQeixHW19pptf2nDLgr/eKq88FiNfDMDXjHhf98fPZ9bPvnCQ
 /r7SFyIG9wd2D4btzv1aGGgCr5nrJvBjyg5xNjjNQQ+4fEAlPytg3vecIwt9o6jVeC0yxVqDFmU
 oUXs9UQvkGRagpBSv2LzoHiMkEibxVJc0ozN3aOnFSL8VDSdQK/x7dcL9q/bfoKqyNuQCRjHmIN
 ULBCaumKH4EzGSoCQMEDpbhGBBi4a/CpVlSKOSnjwswaQCYnunEu3G3NHSVw0/UjXOvafPEbA8e
 fepqNCyssHsj2I22GIuwpHh/2YRlTZuA8EZEvbiE=
X-Proofpoint-ORIG-GUID: thuoCuzQtg07fJAom9eSflv8oxMRtAD1
X-Authority-Analysis: v=2.4 cv=C6HkCAP+ c=1 sm=1 tr=0 ts=69ab6175 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=sCtBTKsq4hDq6gnT66wA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12266

On Fri, Mar 06, 2026 at 09:06:11AM -1000, Tejun Heo wrote:
> Extract pnode allocation and deallocation logic into alloc_pnode() and
> free_pnode() helpers. This simplifies scx_alloc_and_add_sched() and prepares
> for adding more per-node initialization and cleanup in subsequent patches.
> 
> No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
