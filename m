Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA033CD8AE
	for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022244; cv=fail; b=ZDlt57u9epQdePRHlFI0dGbON7p81bahe8PsOSUasozriD8469RcjuXRqJPxD4RyJ50iJRenm3z6HWpwPoM7x0OnH7wL8mAMWrexgS3W2CJw+sB2jiC8UlNpeVfv701JxDm+rGYd4t3ymKYPDJtE338y35vf31TtzTb7DKIqK7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022244; c=relaxed/simple;
	bh=2+dham4iTK1FHW0s+7f5P56JsS9YmqRFJi7PtxM26wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OhOKvrwiqd3AvsxiZUWF91b7MWqk38I1mJMuqEQgtf5WG88G9kILtpItHj8cuB1zJvtSxBy/RC8mvG1D/wsrhDp8c8eRzhnmduOIdOVXivPGUVY8hgBX+iVEYFc1z28xk+b4XmjdCiGOfNysYe1R5GCBn/KqPYNUCSwt93HPhBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RreSiBZE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MbaVBLN7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RreSiBZE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MbaVBLN7"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8XoKP2498394;
	Fri, 20 Mar 2026 15:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DRModKBa2wTx0NgF+X
	mkXrmFMBi1WO/SL6F5X/UlpGw=; b=RreSiBZE+BwgyivyaycUG5LuNtTiVafscY
	2cBwg3I5dUg0O/Hauibdx/L6cZjHAry9Y2ZNwGvg5vnsBsansTDFA3iThuO1zhyk
	qvEidwi46ihAjQSkl8gDKtlmiJL5quGIQHeppN7hW05/SaCxXQd0dMR5XCy0uX38
	4+TDoZr1T/x/OGX+H2jox3et/Oy8cXXPBxu7vpsktcDmnOdCPILSROUxyi/Ky8/B
	Vg3Qyrv2u8dc8nXw9TGlq532CxFsbSapAV4xOyYrrO3UyWWJRxMXkGNUjeuMg5LF
	ktrk7dKg3TZ/xGCEfnfFDLuwHGhD98vQtUcESQrCJ9Q2c9YffYTg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rhy4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 15:57:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62KFfhpw003623;
	Fri, 20 Mar 2026 15:57:12 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4edmm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 15:57:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNJymv/kR6hzjjwqyQr9BEBWzp1k6T9OM0lWcpoi/5A2yyvNzC2tBU+2Qvhg4aEkPEbJiLeEpGW2FpiQcTWusCAt28zrFdZAZxU4kXm8nI986mjYtIXxjo6JPZF5sGWq9viWtsuaWrdzXDGWSCJAAtPduPGvlg1iKreu5jURrlVMgw8/VAQ2elV5IdgqN8qa1V+f7LcmntcG5f3hbg3wcVJvvFowd9dPlHgJLzowyIz58LjU/SUReNbXs/B6+F3VQLG0QrA35WMKdUVUoaoYH9yAb1ptwKfviBvNgSzAUih6Wkg8BRj5BcmTLL11JdtAoNwE9FkoAAjWSJUN2L6vYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRModKBa2wTx0NgF+XmkXrmFMBi1WO/SL6F5X/UlpGw=;
 b=yVWglomhQbxuGHXYp24cJL65msWSf7C+FVSs9ejSNpi8Ox+wJFyNPNiXWT8Gry6EjDnCu5jNyOZEQqxo6DKSr/lry3rwSA/O//oy1E+9PaeIvi520bl2Cl0ySllP/zsri1yWttgEDSUg96aVoO/xEZR/p3au2l6lxZkdXThoyvb0wn9gihTpTD/4jFM41rn7m32n9Y8SH1ECnXZH9xS2Yx7zCyLCrSEZKZslNWM2V5SFH/mojOnI8t+3YW1m3SqGjiaAUG73y9YdoPQ6eCa9ADvoqwhTYSP51k8TiWVpfhKInbaJGpyi/BRPbc14fiEyMrNJ/W7h9u1FdtdPh/q2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRModKBa2wTx0NgF+XmkXrmFMBi1WO/SL6F5X/UlpGw=;
 b=MbaVBLN7t4ToWdifPSr+issrEOWSP3Sc2MPOPP8jHAdLnT+bbb6kq6pPIzY4/mQZfXTwC5w2HqkPRJ7nq5FeD1FgoxAUoBx6By/glC/8vSsz1a/echpsK/FUaCPlf7RvWZUXvCT5D2nXhwBM5GXflvFI7naIBbQ7+h43SO8foo4=
Received: from DS0PR10MB7270.namprd10.prod.outlook.com (2603:10b6:8:f4::13) by
 DM4PR10MB6765.namprd10.prod.outlook.com (2603:10b6:8:10f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.23; Fri, 20 Mar 2026 15:57:09 +0000
Received: from DS0PR10MB7270.namprd10.prod.outlook.com
 ([fe80::a605:ff36:2427:6a34]) by DS0PR10MB7270.namprd10.prod.outlook.com
 ([fe80::a605:ff36:2427:6a34%4]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 15:57:09 +0000
Date: Fri, 20 Mar 2026 11:57:02 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Changwoo Min <changwoo@igalia.com>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: idle: Prioritize idle SMT
 sibling
Message-ID: <ab1tumOcNCiwZqOc@dmjordan-vm.corpdevsubnet.oravirtteamphx.oraclevcn.com>
References: <20260318003842.762275-1-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318003842.762275-1-arighi@nvidia.com>
X-ClientProxiedBy: CYZPR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:930:8b::25) To DS0PR10MB7270.namprd10.prod.outlook.com
 (2603:10b6:8:f4::13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7270:EE_|DM4PR10MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce6eb18-2f80-4244-af42-08de869957ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MSkKXBM61QImdD088S6nVINqnDbL5HJRVODFIjJ+dbbqIiO+SP6sq3IlD5GfWGAaH7/qn5X/Q7zQDFgzY7XqDrq7bQLl/SrDHJ3K4yp6wLx9YOYCFLvpR2588edzIdwJ9edSNsv4kNHfF7Al0zhUyZRssTr5O/sOhL3NaVju4V0pv+AwaXhnmMwyQYLRsmbx5QnXEw9Eyyrbw1quL0zSDypXPxlo55i5KCkmHnflEtgywRjFYrO9/8MEMLXhDr4r8LjoUNz4q/HHRRKa46CPgscFevcx7x7SKx2Dkwwsoty+W05SWCdYRHoosMsul990ZmyU6AT5jd2sEx7d+dEABVhSU73wiFSESXZYpeBsKSrZCkRK+FF+Bov81gfDoUoxbwCHMnBwXZWY47I3pQvIME9vmfdz+dHdrNomKw77NwfXi+E4co4frt0fle7Dy/1pj5n8+bwsAC9yygxaZZ1ouaU1WuE1oDpIxauMlaEGFxvXveQfbEwuFxufH0jcjlOqQLpXUDE47jE240oaOcDTECgLogVIKOhzYas36jXLz2MQQ7a/dYG4XCE183pHRnzY/KgGNFOy8JiHgL/EjZRxwjPn23Jb+3y22aA1sy+dfzw6bL5+PWscEIQmO94VF6cwPY+4gG4N0zJxLx37UtT6vo+bgUHw5VYUdgIKlhOd+axA+x6mKkKww5ixsUjB0EN7vvnHP/iKFVBJ5jriOY98ZmivrftNRBW0Izi2MkJ15II=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6x7XozfhOPPvMrhQLP6FjnWVrFgWMmjsetaF5Sqautc6ue3GCwbKk8+V6+R?=
 =?us-ascii?Q?+yPQFrzG4azTqW+OAhszp6XZKPpUhrss5Yo8/smUqIh7XTdDTupMDvo7/F0J?=
 =?us-ascii?Q?Q/kk0K2bHgp6I2BzrcgyVkK23RCtVoR5t0ak95ywcCEDMUKYmc4SEr+RTgAM?=
 =?us-ascii?Q?bNcoWcLQI6D2r3nHLnCWW4CpojBrxWKCMNlNxwOh2sgeAKtib91Ju0E/Svxd?=
 =?us-ascii?Q?Umwtgo0k6r5maaOONRqhlgUIfQ2GMk4ZKTzA8ntBSJS4JuIptdWoG3iFNsVL?=
 =?us-ascii?Q?R6aGTGdvnBbR/GtCQDQGfhqggjWorKe+LQ/ktX+hGc2aFfsCsGb9ljgLysHc?=
 =?us-ascii?Q?YRFnj01Ho+fUFe63mM6e/tt9dc3xfBJUMAtm7Pi9xZYXxBg8Ifa4MELPry1+?=
 =?us-ascii?Q?OxpvZagxJOSLxPTK4AHhkQtxtXEb+vIMhDiHrLyynWfzveGgX+Fn2F5Psfci?=
 =?us-ascii?Q?4h+9Lt6YSKENty4M0C1hLEdy7f+tg/8Nz+4g0CS69XE+Tlx6QZd6f0207jz6?=
 =?us-ascii?Q?uFUFzoZfsg0vEwgqaiPUbHR6BNY//Zm8w2V1vVeRQV8v8hvEHj2LbPSVVugw?=
 =?us-ascii?Q?K64NcbcKWQUeSJZVUB3Qwi83RdiAmUlty8uGQZyZo5UhKCS4qvOGDB5LQEhf?=
 =?us-ascii?Q?kvEpnQ5VE7/uR1PAHJl/nrhD0WTXGAhqvTnAthC/bePVGHuozMGXrYOZ3EC1?=
 =?us-ascii?Q?LZDY5YN+Ps2T3Vc/w9vZoRWq7tvtCfXfewAwdepIh/RJlurxHAGwSCfY7wBX?=
 =?us-ascii?Q?c+ESGMPuLHJgxf30BPVIN2fkL76S9/ceTXUFJRtovd3BhPat0WRyPxLgAQ4B?=
 =?us-ascii?Q?9rh2Aqu6MMa71jrXDRu+n58tO1KpfwiY53Qh+DLIJgsnmY7/Q4HDiazb0OQ4?=
 =?us-ascii?Q?PSqhfG6zZAFkkpfzX5fGW0TovNPvItrqgGIVdGJR3Lt+33w8lzo8qi+ztuln?=
 =?us-ascii?Q?ND9WPmoaeT78w00eXDsP4oUgTs68DEspwnLdaXULJQbvyfRwaa2VFK/JkR/z?=
 =?us-ascii?Q?K0nV0SDU1dgUjTO92rx0tuMmbRWlColCj85Z2MZF8hl15VYZFvkyT6tAUlGZ?=
 =?us-ascii?Q?R4LYDhN2+YAOAxAQmGhVYgr8LQd2lsx+oq8dxXBkog3t2r/8o0GBpqwAz6oC?=
 =?us-ascii?Q?er5DPLB+sIDmw/RLF9Qq5BNd8JczMEqZm/OQ2T8QU19eI7+gcu4ttgPwaEPx?=
 =?us-ascii?Q?pomBmv2CTMfiLEeUq1E/RpECFRsXBv/EUx/n1j/I9196DoKpJSbQyrwN5ZAZ?=
 =?us-ascii?Q?C/59PTgAlJI/ui8OJS2kwODnsQMNuApVsSG9BQ+H9zdR2QoZbhcj94ulKnMH?=
 =?us-ascii?Q?6pYYaS1QuKprO5yy7qWHF6owSP7p1L2JIUe2BsrPg49aljFGhqdw3JAeVsmu?=
 =?us-ascii?Q?HDwio5yOnaDIFPAAYuqT7vynBbSXa0Np8OMi/hqTaXLDeZiasSW/Tr/ZOs9b?=
 =?us-ascii?Q?OQtAtbWU6O+48gBAu2k8EQTFdIqcLYoo1n95zut1GfBui2Dkz5Kae6O5FV1V?=
 =?us-ascii?Q?cOwivii7yHGD5Zv/VR5y6pVPs6spXhq5P4LrGyFt3cs/HJeiQBiEoRkAWmRD?=
 =?us-ascii?Q?x48Qb4qVnx/0cG1bEOEJtIfgdzgGU1ClaQvS/SX5+liE0f+//i8RJ+MhSIQ7?=
 =?us-ascii?Q?YRKL8yiICQ3CTXjMqtRhi+flwO+QYWGY31UFZibdcBWxEZfzX69Od+CEeDWp?=
 =?us-ascii?Q?+swgS3Ix6Of0eONPStAr55CcJE5CUtkIvABlaMtcC9i45gq1fNfctIykd3Uc?=
 =?us-ascii?Q?atQKvGUpDVVNk4SiftlvZK9DWqwlIO0=3D?=
X-Exchange-RoutingPolicyChecked:
	v4y4hmqO03EeO9AoR2FtTEABvu/bKM4zNGGF8GYTTYE2QZB5VanlAbdWAag+Ti5bkKY+59qlkIrOKGKV1cnZMOrJXCxeBUevuGYjX3kUAPGZ2GOzAYaoZ5n8+IyT09YiLGqYI9KsAbtbi2TxoGDguL4YRlj318Mk3osC32LV53eOJCDDLVDhcADqxx1SRbaKEWuTpHz/Ukxf5DMBbgYjg7KPsjR6xBPfwzLtIoE3Ly//Z5OzS31iZWla6V5y2W4s80EUXVZNBG+hPUL1FNr5rgR+yjOhceV+sX0afjpx9BZ04XWJ63MIWqUwKawjsG1GxFfdLuNjSeETea+khLPNfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	04QxJbWSdBkVBPwQR3mtZwvbaxxZEcNKmKkHiJ16roUe4Q2p11kuUVHIIXffsHIAmBt65aBNqOAoRBNOHI/MeHBTbBhkOKTDn7xrZ5KHw71Vcdf/kHrT2z9swYFj1jh4AwKUMKhJUItqf7X8QqvWfSwTzAxp8dTZ28SBuKZOUlCjCUcohxA1t/Itogbvtc3N6W68Zs8T8u+Jm86xTk5eKzkazeBbKEf3vXrvHCZyJcUkEDWz48+YTM+21sExeH6zzU1fqb+jWI6j9p7cmYNqEvKI/5WrShQ+FWhN9HBku6Syb6xzMT+o6f/vMrmFbGdEi0haQKaXGCVx52z/VRQLl1uqNPB+/ZNGU9XfwFy4C66AEbBExO0l1r1R6EsW2A3EnL8OBqh5y05eOgQjnaKGVfs8wrA6k4OTNLJzWABf6CRlfUKDKncRxm667U0QIE1DJWMyqFyYZhPN2UR9DKAoG3a36GVAurKpFc6e/aIo3+ip5KHgWkLd961aQPw7FsFIBTokLi8cEF31n9Jaj9MA67mUFS0eV0WFH3a4b+ChmdrzCF70QPy0NyCU3cmwDjKy6KD4GnSJDoN0Y4CY+DR/vKpCmqdt4nxfrMfN/jzyj9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce6eb18-2f80-4244-af42-08de869957ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:57:09.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhOukj7IjZ1YyllaO+eOCFVRXFTc8c3dZ0MhT0etWPBAvN+wP8U2yXDP6J/pUMMWHDYA7wtJVA36hcJnAJDYGyZnV3msI0j7BN6tJMyif2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603200127
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69bd6e59 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=Eh1VrYCNLxuh08t6mL4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: im7BMF4pT5loWKzJV6pFaDpCvmW_BD70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEyOCBTYWx0ZWRfX9t7yCg2eG0La
 fsQaPr8bptYELxrSUkpo68iYJztBbBs4mjNasgVXXHHV7UOyMTT02JScCQdJRJZD+fDQfvvbWzj
 BWBYucRzVl8u+ShtEr4fOQDRtKrBU0ZzVaQidrzW6xHljimAkkEfpFPW66t1eoSj1wShb0sNofb
 FGYfpMCntc/uzjiuzO4ADMIWJ6h0ujgXu+0WNbaeyz7qZwppCRiu0/IPtrriu0jMhQH7JiadUeC
 95Z3i29t26LzEsLxQTnZEvw2Qkfsr4AQC5o+WWV/Bb54S2FYXL8RXLeXQnkReublc6d9aR3Hf0r
 IzWFaHBXTII427iioqUWRXEkJ8SSeByTPD+SvLEBM61z+cvV8Tea6KPyIRqbYjL6qF17/CXBD2Q
 ZmwJY+I/fqzzAIUbwuH4w1QD/Q8qjNbIAeVa3T4abF2VzLmI5+pbM1haPz7hjCS0oHNfFiamsbd
 z6OOVSYToNcXT2h711Q==
X-Proofpoint-GUID: im7BMF4pT5loWKzJV6pFaDpCvmW_BD70

Hi Andrea,

On Wed, Mar 18, 2026 at 01:38:42AM +0100, Andrea Righi wrote:
> In the default built-in idle CPU selection policy, when @prev_cpu is
> busy and no fully idle core is available, try to place the task on its
> SMT sibling if that sibling is idle, before searching any other idle CPU
> in the same LLC.
> 
> Migration to the sibling is cheap and keeps the task on the same core,
> preserving L1 cache and reducing wakeup latency.

Seems reasonable.

> On large SMT systems this appears to consistently boost throughput by
> roughly 2-3% on CPU-bound workloads (running a number of tasks equal to
> the number of SMT cores).

What workloads out of curiosity?
