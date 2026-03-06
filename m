Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BF377005
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839299; cv=fail; b=tJyRgPJEhYz6N3S+QV5IYxUZ3XJZQvMd6w1DZR9TNxDjxQXQITPX1TfcOb52Ff5KbIXMe/NUEKDbSnx4AQOo7JX9tA3mX21rEegF+0chTxZEPHCyLnu+eCIs+VywnafZ2H6NcScjOPfhv1AJ9Nxli9bon5TL9PITRxG3tx0RPj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839299; c=relaxed/simple;
	bh=POCFfIACpuxHghu2AZAurc2TEewa11llks3iSfy0+Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qu+Nv0aX+pXzXs20+GAdgJyG8PDkLeBM3xfevBNLnqCja/SnNmH9D8aw7sffQQHQ6VyGD8NcaBkJOdx7r/iX0sdcGjQVcQ6G/Usj5x671aVoL1lNRIUxeHGlrnqylmU6zcvHtcCKaf97eydW7ZA+OIk9X3rP7WFRG37qjSNFj3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bysI0Zod; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NQ9iO1Zx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bysI0Zod";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NQ9iO1Zx"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626Mntmq533278;
	Fri, 6 Mar 2026 23:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jSA1pjV8gMRYW+hv5B
	KuKyAc4V1scXbvdZRawYr6DRw=; b=bysI0ZodnWjwPlnZh6NOHQg4q8rlWmTHkO
	rg25f6ik0S5CwOVjhImkZ05eyDI0r9PFku26J7E0gFgERTVeuTpQbE32DXiopofo
	0ThUgrLEuvrCABzzPoQ6PjDsAFhqgZq/bjRZv3Ry6BO9nnmwVYCuHFyY3y/Tf5sJ
	qGv/nrBLJ9F1E929ZojAyYlOIFB3YOvTWQ/rba18AVyEXuLfJU4mDolEV2MXUSrT
	upsrCMkHfq4dl51X+HZj8fCnHHBNG+SaEux8kUl9jSbUXgOUMBdtx06kUJyJO4cO
	yUDDRYAEncQpFCCktp9CHh6sEmjbj8DY031E2ALAYILbivVcbVHw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cr82fr0qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:21:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626MLYXT036999;
	Fri, 6 Mar 2026 23:21:31 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptf1b5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II3fowJhArpI+g2UZYwbJqoXf/zpavgD2WOxDjoxS+7pv8aQ2yc+EhlBBNQtYKAQYfUvcWG+Mm15nlSlD7gkoPsC/6lpVsy0soXj+MsvspTXtvrwklA7NLkKotQd8MvoPzrFAgvGxsGe7VhrHnXC44kLbgcOSEyvezFUJyeQSzF8qknBKYYdFWSvKBzFZCG5ZfEt8CONRdX4cVEu1gBMkelF2VB95dPcbYOoChVkQApOvomQFjRyXcvkHF2vmUoxCz7gnNn0QIjhB1CQWNE+zW+yVnqOk8T2XHC8wUxEk6U1oPb4BjVHM/qiuW1NwZ4AhEqb5Fx0dGIl2nq1U17QrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSA1pjV8gMRYW+hv5BKuKyAc4V1scXbvdZRawYr6DRw=;
 b=W8y/+nqsxzp8o5jXyNwk1tt9xZFy6+hd6a5u6il4r30w1F9iXIziRC8LwL075B4bnBqvZgpjYqq6g3+K9sKv7i8+5dH7h0Kj5QAGAtyI5qmcBm1dsagikOdh1P1yo+FElveUGLzs9xW4pxfYwyueB4xwy6t+lxNUkN+pFc23vUcfXGLiiSpjTUpiYB8i3nrk4EOIO6xIxd2L/Ick58wXKZjY/ZEp5CjiSVz+doO0d4+OF8JwcFcDIEH3tsmWDCiqW7imJGuCubPu4LSgmsXNjQGex2s36x1FJvbKBWP/CJSVxC+JCsIBLCHQb+FrItDYltcBjuJcYmNakFspxsQIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSA1pjV8gMRYW+hv5BKuKyAc4V1scXbvdZRawYr6DRw=;
 b=NQ9iO1Zx76vCTvHzj4I8dBAMKkC11Js9Z1t8PcS400YYT8VsqdFc+cSfTjlgE92MtKd92kpyQONO3XsR/Fxob9gcFEzJCw3ZtCgLYqB2yq6e95A0TgeYFlbGih9zaCbRIuAyBbRlPYXTnbgIYvX6PN8MBorGeY7Qmc+IE7a33v8=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by SJ0PR10MB6328.namprd10.prod.outlook.com (2603:10b6:a03:44e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 23:21:27 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 23:21:27 +0000
Date: Fri, 6 Mar 2026 18:21:25 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
        void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
        emil@etsalapatis.com
Subject: Re: [PATCH 04/15] sched_ext: Change find_global_dsq() to take CPU
 number instead of task
Message-ID: <aathao9aQYWRYKTL@dmjordan-vm.corpdevsubnet.oravirtteamphx.oraclevcn.com>
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306190623.1076074-5-tj@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::24) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|SJ0PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 1886fb92-0620-428e-9ea4-08de7bd7175f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	54bKulEol7Tf+qMuYpDM7LsJU6uINnPx1b71YNGYJaTWvbFQSH0canTupuPvI4Tmha/4vztILENF4tgg2XUGdcOk4bIgY4uvPDDwpgKQ6t4q2+BtOuvBed7kQvm4O1NTWXvkZ+aVsijXqS1DlSGzmvEsnXXWHU7uEqhbivmnsORBkg0zPQL+EbrMFIZ+H0rAUxiOu1GEAAwO+o2PveQ7vUOYituSZE6a+7NoJO0Z/ykimLSBBzpZsBQ993DDdktGEZ2ypDlNuCgCiMaFeu1I8fCRExYL4O1DNGp8vG+g0qG7trs1qZmzWzd9SDzkir9nyBGeSxeLmzwJwLseN0aJPoBYheGHR4Kco5Ty1Stmk5H0UOYusZ3XGSjlNFrmJz9b954RsYi245eT2TSbCnGarHW55HuxErzlEKUB7pKcSGGl8N72erLo3RzkNQMgySXiNDZUszntYXHc/qitSkxjbXZo+i4+HDLpevnwuqaBXOQjwM2y63lQj1E3gsrQ0KpwHNQvTse9vJTRSNClyBblBlxZVn+UK0DXXzliwOmG4Y2tFf2g/25FG0UTLHr0Q9Cy3UjX/8Llx7PnN3YNasQgh0hL+ac7fUoZ79a2e2d24iiXV6RKZrnXvLx3Eve+g37Etuxvxa8bSR4jxmDoXhm22tGHXnAk8/PxLJ9QxvJKTEDUyJ/V4CViNNQbHbHawtLNt4QL+kV/sQ/ygP4Pa0bNy/eoo71tRSqjhYmTQ6CT4cU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K8EoTO/ZUW5Fkuxk5QZl6vUlQvowG8Mp9F8tYilpNB/6WiP/Q9PNfMifLaGL?=
 =?us-ascii?Q?T6KRHn2wLgyfPLI84X85YVLKJFpPNkU6hDaE2mW3MBCpXAYaoGFpCQFA6voU?=
 =?us-ascii?Q?9I9RzrQ4FseReS4RBs8GeV6eibyJd1dRrWeWKLz6KYsOwwLqKlYnP/1tKI9W?=
 =?us-ascii?Q?rB0DkmUuTsMdBjThTweEXhXCa3k4RijBTDl48wxYd+qs6oGcVWLQ/NN1j7X7?=
 =?us-ascii?Q?sgqRUS7JHKym+HWY+CWRDYrCZMRlvuhjK5hwtP9+9ISoSXxzkEp55r1n/Yzo?=
 =?us-ascii?Q?qfLrYNgoieIB1kUFtIHfEFa0bJgEVzsVKhBFYHYyrkahcRm4T3qEwJs64fH6?=
 =?us-ascii?Q?oNX8d9qexx2x013iv1A15raaPeOCmk0py/nAArFdwuzFr+xzzFm+mW99hIxg?=
 =?us-ascii?Q?6smc8y2BgGSvFWPntZVE1wozmvczMTVpev6DWq5XoX+xI4nNKahIpwbY27UE?=
 =?us-ascii?Q?lWBb54iIylJqqz2E8ISwYfckRHBvEviwriS0B8FT/xLnw4h96Fy7QFWSs8Rg?=
 =?us-ascii?Q?FXCqL68nass3VI5lcaC9WOUsGbaiMl4sbKioXu7XC/LAf8CwZdidINnCRdXt?=
 =?us-ascii?Q?VlLysib5aGQ0kKvGaKmcRlszs2haJkWeZsaLyxvXqUMV2kda5xUBf8FGNzqL?=
 =?us-ascii?Q?D24uUOy9lCma129VWG4t8GbHTAZUhKqKkGyYRCttg90M5QPD2Go/iOuo37lQ?=
 =?us-ascii?Q?4hZcqvpO6oenoC8knAuxK7t0qYCEQ1YTlABjjglFZ8/6vgFXH/oJbndzitDj?=
 =?us-ascii?Q?z4TiH7JBLHAucVPxL4nmkW/oz1DRsCa1QR3oXK6ttCb00cbiR43xzUiLo/pj?=
 =?us-ascii?Q?sBjtooYjmPl/cNYrDKoB8IJlPbMFv14NkIiNJl+tT35MVEs9LoBgS8S9LkFP?=
 =?us-ascii?Q?o7qetMgnNavsTJrowwQXA+6SuHLWTxqZNSw7Qf9umm+PV5EVmSllCcejEnrY?=
 =?us-ascii?Q?lcU/0U1opCW5relSZVoMuqGQztQZdm7YXnUUf2SO5tuSAbPlct7B1Xf7WPjS?=
 =?us-ascii?Q?CkUUlifDwreUHEjIKjt+iRhRuerGchpiGabueKMS/L3WvsXeXW/8YO4VhK8h?=
 =?us-ascii?Q?IDrPehNoC1A2MNRqjjioyF3mwRnMp/cx6CN89YBu0uydQ9ZFGtTQ/a9k9LOa?=
 =?us-ascii?Q?VJn1Sl8kLHzi9EC7vq4YkMqUe3xbPYfORTdG8nqBurD2Ig3Dns/j35P02TpK?=
 =?us-ascii?Q?zrFG42TVZMLyNhmy8Yaw+xIgx4EqwRGG1ALFuk2PXa4JR1REBsJe6Y36nue5?=
 =?us-ascii?Q?EK2CO40axFh08CaGQGK8OFDsM/HOOj6KeaW5Tu0OUr3RKETiP3CJgFxtllmc?=
 =?us-ascii?Q?OChNNiGapdzB6AxjMg+dTe+my7vc7PlJ6jVZaCSiOtRrirWJw6K4e944ByI0?=
 =?us-ascii?Q?BO5EdCJicbCT8+CN6tkLjWYWUTb1XoHBibLFtXiF+R4wZZwRjFtJBH5ML/Nq?=
 =?us-ascii?Q?x1vMkjGCQO0XDPYITpAFIgRI3UHgzUBl0+OdDmGdFL9CrVwOCJKHJgxvy2Nb?=
 =?us-ascii?Q?PuuW85mXuK2PUqDe0RHWAdkHU5XNJOLFIJcCYIU2OiLi1BMru4m8PiuISIOA?=
 =?us-ascii?Q?raOCHmQSI4wcATREHtZXo8p0dIIDtAS0Pluwxt0edApAz8rH8e2iqxAJvskW?=
 =?us-ascii?Q?ePL5KaX7h9GKLuTitj0q6/cLjyI8fdc1Ghgan+H0RHG5wCWjAAQmp1ju8dn6?=
 =?us-ascii?Q?WvfkDfPnQ0mHu6u9heNPhU7vi51RctPvTGBVclO9DyPp/Df+rJbjkd8O2XXL?=
 =?us-ascii?Q?lr9CjYVgX++Eo/BR71wRLH6aFvu1iVA=3D?=
X-Exchange-RoutingPolicyChecked:
	vuhxdk8TS5bKBEiVjwimgHFuhcx7CpL6C44M1Ww1SS9I6yxBsm2UQUNUelS+GVkFO8mfb5FWZIffWICmv1M3PsnKWItu5iIFUBQh9vBy5fJWRapWhX4LaBkeqE4K9J3022ISzfSgd15JzeaVchoWJD/S8iAAW5m5ACKLf53RrK3Z5HzWu8fXvxXEq37LvaOLwopUXi3lVAgGZxGxT97oCnBTKg5agThK87nmBxU3qnamfmwreIo/YgcBwsgfnyWBFRIMPE2+b8y5qNYnCKxK2raUEvglNFO84kFtVtNGlEWBYKDP5yB6rVbGwsqIo7KVJJoNJb8mvbTju3lzKky3Tg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eqBXyuoyGikShgbCRCNyqQi/YQWfndTQJyhKH5eh5aVUw9jRI3AadNa9E1ZEHctbMcI9GLDSVvSTwFkXdWDUmMNwKDt3H2xIWmIG5l7E7i9LcSUZxDrrwBiFHCmLrghrW5SZuZepP4E2LPtyjbz/PRfVg6hhLUsOg/HKz12Izlsm1Ofwhehqx5HEabPd3nV1VfYnxlV5sQWDPuqWCk2Hsc1PBQOZ6DNhKBWAaEsES+RNczOhO/UbnAgIDdbuzVMLMtfHj5Ib4rM9Pm6gZBDc2BW9tqwM8DhQtknV8y8+sCbqGVuw1a81PZ+jXc3lnC8VnGf+iXgeAocWZIh8TLi9acrV3RYSHU3wS4Spv+EFqGZVUZ1fRtcseSh+NkllqAndWFjfd2sTozWyObbet4BQ6gosJ7rObrT5JcP+gAJZD6GbIMrxG4VoJQ5F0cZztAFOAWMiesp4Lu3SrqtBqmKVdGbHepXW0d9+9YsTgjSwCUEPQYMVar4uCHKLPiKjhuBcNqXjKjx1VxSQz9J3DjV3KQ5AO5DPG8hFrUuvwZ3LYflssn/hVmVfiMZS2dZMwX5rC36stsbvO47Bl9oSTcUiYAS8oNa4Cl8pRDIY/h1Vw4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1886fb92-0620-428e-9ea4-08de7bd7175f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:21:27.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vK3Eq0iKTBgbU7G9jSS/2lTlnHk1shBXb2k/RMXT/6tdXUUYufuxFpa7oIQPTj5vNqJQs63/TfOOfT6bWaJOG5VuIFodpdiqV+o3NJIT3WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=869 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060220
X-Proofpoint-GUID: ajBMrKKC6DB4Me0eMSVZ8ugTXK2GF3pk
X-Proofpoint-ORIG-GUID: ajBMrKKC6DB4Me0eMSVZ8ugTXK2GF3pk
X-Authority-Analysis: v=2.4 cv=AKXlSMJK c=1 sm=1 tr=0 ts=69ab617c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=MoGO1J0jMVrw_ztfbyoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIyMCBTYWx0ZWRfX1NW6Q9eZv8/I
 dS54HO4jBPjx11V8zv8W7RgDQqgo0Uzi4eQk5jpLqGp0OExnpWwpCghNHGDDgtYN3NyzuY0nwvh
 2bEbUcV6fcegmlZY/YglpkqTKtq2T6rhbHkk5rGtF1jprvMRL/VUkP2Q8oQJazVmGTUk69vEm/9
 ciF9dm4QkimEXS9l6aGkGGVcG3OZc33QWB8brJwCS85ihRqiylJxjTH4qc9nfPuKxR3z+Pk8N6J
 aqrglnX/r9v+XiMAqedhiR1sVFOfrplWAEug8c6Ml5LK0mnFVkyv1lA4BIQ8OYR6aDec7+SmwLS
 f+5WfnbuJIon63miU9VkP+MsX76abtJinszeBT/D3sUQM+3X7cR1sbEXaXTe4lQ6WC2rh6OKJad
 npoLJuyM1ux9dW8lc+fSUeJxXXPlCm2xKj3JxQNnvVwoCqrfgCi5t0Dms9DAx9FQRBpr0Fa0V2r
 I+athE0EnHbHql7YxnA==

On Fri, Mar 06, 2026 at 09:06:12AM -1000, Tejun Heo wrote:
> Change find_global_dsq() to take a CPU number directly instead of a task
> pointer. This prepares for callers where the CPU is available but the task is
> not.
> 
> No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
