Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A83563FB
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841259; cv=fail; b=nfnvMPCcbhiZL3FRP+lX+L3Px25jR4I6KunZl3eePRIfbPduN8ofC+CxLR1im//0auNwXoqoX/vENjAYItFwhJKBg4cPGQvR6mPkPpw4A3mnWHFP8/gGh+settuyBXLh3bWxdoQdTeFu2hmjiH1yOa2VdOGoRDe/ef+JJScQeFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841259; c=relaxed/simple;
	bh=/jcMAJRE7Yxns2dsuAqHSqoL43exu3qmI7rSEjPLt8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YH0Y1GBg90lUlZT0Jmjfl5MCg1MKa8l3swo60fBEX8DjcDdlBg/0wGUjxfIy6xVSRkV7uEEg0ekPRDFaTHFCIaG/DfVCfxRg59GDBySPqFTqn0r6lLMc9fAyuOCXiPw2v7ASU5eGTkARQOV9dus3oveRDOWkPkImb5zRMDGOOuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kt89NWpc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U/2gEWfA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kt89NWpc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U/2gEWfA"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626NRTKV726369;
	Fri, 6 Mar 2026 23:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kYdbhf+2hzVWRTDDNB
	F/qgKeJktynRa51X8REpiaEFY=; b=Kt89NWpcxbPuBDixbAi6+SeYhuNi3ZXiaF
	PVJtgbWxA8NvihtJFS2PUWkExS4oIIg5JTp5sJ5UnI9iEuHZWnRulqNYwtItXVIJ
	WxyO1BoEbyBXCF7ZKVdbDm8TfecVt37uc8giMKxG1vNK7UhQJJvT0VIqtCsvyBus
	UasLUO3A3tpNgXGHc0BjHCITNsfIjjAsoH6WV284/CcOd+n6mMkrEebQ5KDG3T/g
	JFmUmhS3NmXZTv6PCXmnNSNyvRMQ/NOXU8bBP1q9YI5rAcVg7nejff3Dy0EZM7t/
	vOIPhITQXDToO3dRZyucEAPsSgknnHjoKaW6LhRokLn5Q9Fd3aQg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cr8ktg0gh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:54:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626MwBY6034716;
	Fri, 6 Mar 2026 23:34:30 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptkbtd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XR1gAlJUy1p3M5Gtwc/pveFWUY6RZJH5FlXzE3Jl/yQagt5RyG6QWszvEn1Z7aabBP31eTpdp6XQ4hVBZDUtucVBevlmsWSwveA8otZ4HIH0EBoO5eCmaZqId8Y/59uY8tkvvTA+C66qlXZe27lS/EFjI2illWJQoyx1tBcxVjFWEYOvDl8saltyZGB1HnoJpqEe62Frrw51HlPNd+efqkKIx2Z1j8WgSgSRarIh9TErSaXH1To99LvvgwTYN0VVQLSIQvTg9x0BAxkhfX/xXv7yqieLA5n8HtbvYJGYF2nHGoXtstNc6b/ZLK5JQRsoN4frv9BcykCDcHl1c4WTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYdbhf+2hzVWRTDDNBF/qgKeJktynRa51X8REpiaEFY=;
 b=SuURDX81Ss9pqMx2zBnZWWLV9NwNPdEqPCD3FyKiSC6FqURM5SfXvZ+FTNTAY8HZLarLqhM2J4uzrqqDZLFxo2KlbYdaXBeHnoVlCEElqJFsK9zg89KtdTJvZ4JZDZaqeARFSZtl6hx1AnM/xA2IkwL2CzNIdZvVFR1RUIzByECpKEyQtC1wzbO6sEimMSBNaaBnqQqm09aZ3J/PyLJFSXCg8G/kS9Bn44kIf3vmmzGlzRokxqSUBlWTs0cA8qynUyno+l0VnWm4cAhzawmawhFfkb1u8lDIU6DeW73sRD1yOjjLB4JIvxc6GcmvgDG7daQEuqeZ4Qu0oARVZN+5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYdbhf+2hzVWRTDDNBF/qgKeJktynRa51X8REpiaEFY=;
 b=U/2gEWfAucFp9/N8QTktnKefK1TLyrY7GkVKuzAaspMUBJJGEsR2Jz5SkSV/jluAD9E2jAOcp1XVkUjdV1a38U74rt/s6sX10GyBuBU6zqzz0ScqTliWZHC2CCcj/xmgpA/Jp0ZF7tGQAUIufGtLQUYPbdW8gb9sVWBc0M6T788=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by SJ5PPF88E71D08C.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 23:34:26 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 23:34:25 +0000
Date: Fri, 6 Mar 2026 18:34:18 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
        void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
        emil@etsalapatis.com
Subject: Re: [PATCH 05/15] sched_ext: Relocate reenq_local() and
 run_deferred()
Message-ID: <aathhgmVS5uhTsBo@dmjordan-vm.corpdevsubnet.oravirtteamphx.oraclevcn.com>
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-6-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306190623.1076074-6-tj@kernel.org>
X-ClientProxiedBy: BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::21) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|SJ5PPF88E71D08C:EE_
X-MS-Office365-Filtering-Correlation-Id: fa58b9c1-e0fc-4acc-d166-08de7bd8e74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	gLWxVxPZ+LPjqSexXjOj4tTJrmktm//Ij/nmG0ijm64pKTTauCwt1canGGGV1X9LgT4MXvYNO4Z8Mr54lEiet60ZAqETdFo10DZbrNAKfMnXUNy3UZ7y/ov83Knx1g4pJT81hzaG731gqztuBbZ6MFlPOE922ssV7cEASRw3hxYUdcWHmcOC0vqB5+jWtT8Vf4fnTCWlDaVGfQixh/SDaweU51G7bAH2RMfCTnnQBaLKgbVefW5EarIPzEFxr3en+EcSIx3v21tUuXRXTIDhu7JijBVVpsWT1HsBNE6+RHYk1jxH9vxC/fzEcplBoqLXt1paXS8QociNDQiuqXvHoXeqN65E5QGm5dT/2Joexc+5nc2+H4VbaGCXFz6cReNr5JZy35Fs0vBIJ5Ovr/YfYixyqoEVSsETf9CU3zCP5wsbtswi6VqyoxNNRt1K2p7rBXPmerERAf2OqrMzHB+rktUz8TLN9SYZV939kJ4vMjBQKr1bzXcLfQoVsF9GdVCLtf69UBlYbatbHvuibG/V97xu0MGX0lRVRyRX3/ftK1+vJuEN/Gq994SXfAHPq+x6ID79VWR8FyuVlQY/x216ShQeYcanpqKvn2vRTqy7G221c2U1t5xXgWmL6VzzoikEjwChA9yGAX8+LsWLho8DQxQRuqMj4SG9x2LO2LuPUO3lqCywVQ1D0mla4ZdFuuGjBOGpAAKEUkJxnrpVLnFngSzoK0GE5w/cwiZeuERtYLA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R7T02275PbJS51lfwpnbirLrCKatLo/jhWYbIEA6R0lPIFjOHzR7vpfAalgm?=
 =?us-ascii?Q?YyECr+TDUAFYJkct7vmCl7tGfJ0xHLvX0GM8OzZCGdlsqYPf8DGPPYNcZsCp?=
 =?us-ascii?Q?7JNpYo4cF0t8MeH3LwLjHf45+gAmm95D4jRDZvcB9XPU+3WEHS17pkl65/Mw?=
 =?us-ascii?Q?sky6QclpISb7AEa2DateXwaDUEXQqxvTkabKNxhZ0k9bNQIuQjCJhkaIfS/a?=
 =?us-ascii?Q?ClypwHZyvfoMDrJLjwqOj7RIymzGBGN6FnxuTrG7YQ0WYktSV7nIZVqPQvTc?=
 =?us-ascii?Q?J8ZB/O1D15z3gvHO6UE7p3Wc00CHvZ7PEDV/DauHcFQwtLYfZ6J/aaMJayh4?=
 =?us-ascii?Q?aEec+dkdcuphhY/4ikVHHanfdkyK94btF4A7WDd8hp2qcC9bYD18pvmcyCU/?=
 =?us-ascii?Q?CyN5MGBBWk0kgtZ9gg3MMCtYng3b1dDljy0LziCrvuopBo3hpNMmCXKHKfS9?=
 =?us-ascii?Q?mynwtFE6Vga8Sq90TDrS4ZsprxdNf8O/FsA1F9nA3GXbeAkLxurjG2iIUwcD?=
 =?us-ascii?Q?0sHLl1HTLv+Bi/oI1u43IsdEnztNPZ6cMCe2V+GyfVb9yMWeRfnhp7820/uu?=
 =?us-ascii?Q?roiKefo3tq/OyN3ufYJ4HI9Z+r8wsGrTEX+nKgrrK25j8UVkGHXzWcLv5URA?=
 =?us-ascii?Q?1oy2Od/7TrWcfp61mqbxzKX7oIyK+nawMahpabRn8bLtWYoXmNfidDIaNEvD?=
 =?us-ascii?Q?ggoNuF12Mb+reqFgqjGymNVYmltuOiznSbhw4zNK8A6UAuYxBcOdDnWyyCzz?=
 =?us-ascii?Q?uFSlc168HQMysrSji6hDzBg+KDWVh1W0JCpewYzMMHXCupYJnp93HVuEflDs?=
 =?us-ascii?Q?r4TeemctfVm4+UcaRZiZJWP0XBtRWyD/hrD9FeDKwOU+PEOiZkex5IMdz0Rh?=
 =?us-ascii?Q?p3h4nDhaGxPTsXfZXsGmihkeDjAPu8JT4UMmb4gIYKAjmLOK3yJeTTVlzBdS?=
 =?us-ascii?Q?rJ3g2E2GekUMrYTct2TMKsTDahYVkoB8mq8aeBWKd5pS1A1XOs8fvk35rk+Y?=
 =?us-ascii?Q?DP2u84zqGod69EDu+UJgmWI1x8/NPiqgYzeEvEHoGswuSXkXipq+hX9SYDM5?=
 =?us-ascii?Q?gE3Meq62xOnBDJibiHZSCS0hk10ZJPGBYHNYfAj9K2F9pJ0Wk+ZmuaoA+UTa?=
 =?us-ascii?Q?YCzwH81RQdxy8R9asU8sTumF68sifdnZrhtt3MfXQ1TpDXqdJehLNrq+giE9?=
 =?us-ascii?Q?wviebpyq+DO7mGWAKo15DRUOGSHtl7fZH9WUl+2YKGQmILGm3mKvFthcVuN+?=
 =?us-ascii?Q?+e/YDFkXO49Fjm6OcTEcrGdpTN26d7a/8MPISM4M3c+ifirKFKBya3FX/3UL?=
 =?us-ascii?Q?BMc81uWmiK//G4h7PdSOXn88Tr1o2tKMz4XulUumha/dTxG7u1qLsodWF7fx?=
 =?us-ascii?Q?YkZuky+pGTGqqIhPUMke/ACghdnwbC9nwEid2SRklcXH1Cdx6czy64rtgwn0?=
 =?us-ascii?Q?B3yTqhlPUEeDBGK9l6NQq+eZ4eBjBxLpAj0bPW0fJsFkL67RQzj78cXf7/9h?=
 =?us-ascii?Q?A1JGrEVIPxfA0blBfhvkOZ1JKQ2bof0V7QPPoLEV6f9DgPcBpFpWCOQo87Ac?=
 =?us-ascii?Q?kzXxtFmxlbSfyBvXRa47S2kuKQCHgHXfTClTMDeyjOcTtPj0WVcpMd9Y/j5T?=
 =?us-ascii?Q?n3GPM3zB0whVUEvhR6i1Kq/9RmF5x+BfYUHf3AaQS5a9B1zDGvEXoK31YYAO?=
 =?us-ascii?Q?bsgKfX6fmJ/vZQeOkAL8R6WyvVK9tr69qLzIQ6rr/AhLaIQoS3n12dagUMUn?=
 =?us-ascii?Q?wyOX2ml5aJh5A5PMPgw734AEbdPz6k0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	230nhQrbsfQJsaN1SwGNv/BhjpdL+imaUnsk+kbWH5/RbRdcZpp7smMhkCCFiDlUr52kDtyxodeG99dj9zu8XNi9n+qDG7FT9oZbO1D/oCGu8vBwgECtZx3E7Nw0ss+I1Tb+0x1oYBt6cVVY0YvKZ0a63fnx2hZclUighu+9WmweCN0HAnZy0jRMlLsj0qt5HWkAK9fnYpLAtdTE7tauBUk9a91vZoaqLoWEZUDmtLmC2dAvPLnJS9OuH2GA659Ebxz1lw5Y9q+J2MwDIABsi9geJ4Lz1YOAlUcysPM8jwixrCsddg3W75A1rbiFOPOl7TDRkM5MQ2/B/lgGqKmLVevrHiPAuUxBL5fAeSLUl9wEqqLbDo1xB0FxT1hAaMuQBrO3sE6R+wAVX9LLh3MNTFsk1cyBQNW/mihuzdJoV9me+35E2TL9fyCKPd3oM4P9oW2TZSs1B+2BPv/YzT7MXk5S5yZxYAHazkoxTHVwA1+uDz08abCKvXn7H214O3X0oeHWzhJESnKlLcoa43rqUbcA0EndiTd18Fxc37Fj3lq0GVfhA2X2tih1aKEUMhNC7XHDo3AI+FL/RuWWDr0d9uFQfeJkIZY3fOqdBBYu7Cc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa58b9c1-e0fc-4acc-d166-08de7bd8e74b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:34:25.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN/oTcNbmptahG/FJrTggZsgoX5tqXShRDv+NgyqM/7wR6kC+xb4nypgX7Z/OLTvVyzIT70r145e8eLdcrkCyqZY16IT/6LKJq9vFt+DMqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF88E71D08C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603060222
X-Proofpoint-GUID: XkCYp3Zo5lQ9ExzpdmnE5e9DHCsjJfSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIyNSBTYWx0ZWRfX5SwYk1KrrLH3
 hTtXzj3NyjEa8WAZTba46FCMPKuadvO+NVrif9wmQJmKvDJ7wYfw4zVqcwMeStpl03yU0RE5ykv
 SKWyenptJi1aRSknjbk5blEo0rTSV99JcxuwXH3Oxp023XmlWiBHdkIjbMNoU4HoVkCKybEsy86
 UgbBeYLtxTNLg7Z+kbs3HrJjStQ8OoFJvv489oZEltS6kWM8WJHSg63U8XVBkOOA4JBWKaxEcFm
 fV6TEsEcSqlZlfwjTCA9mXHHmwLsyWQG4XWeFRtYj40VV/p/+R3r79pqV1VxbV03/0nQw7SrZHI
 yDLa7wmel/9xLqB2gYU9TkUHe6yHtwnofygFKvI7prXWRGNB7eiTGCE63R+ZouU0uO1k07vUvxA
 ym4n/SU5DdS/I3+H0bcadIypyXIuhMa9u7Q6tBAWespHQyEox+/N2RbCGgN0BOFz+mxvNO8KhrD
 G0O6r7nxzgsSNi0DcMJZ17JEefcZhWZhHX02CXOE=
X-Proofpoint-ORIG-GUID: XkCYp3Zo5lQ9ExzpdmnE5e9DHCsjJfSL
X-Authority-Analysis: v=2.4 cv=DpxbOW/+ c=1 sm=1 tr=0 ts=69ab6921 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=KWO_waLoUGo5qV44hTQA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12266

On Fri, Mar 06, 2026 at 09:06:13AM -1000, Tejun Heo wrote:
> Previously, both process_ddsp_deferred_locals() and reenq_local() required
> forward declarations. Reorganize so that only run_deferred() needs to be
> declared. This reduces forward declaration clutter and will ease adding more
> to the run_deferred() path.
> 
> No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

process_ddsp_deferred_locals() could be moved closer to run_deferred()
like reenq_local() is.
