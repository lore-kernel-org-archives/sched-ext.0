Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB426A0C7
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839240; cv=fail; b=qtjJ2tLrXliXHJxPwRRsjK/pVNezgg4Od2qXoJrfGwrvGgOOUGEpleh32YvfnuRKYAL0Ko4q+dKQ8+86590dbPUu2bNzpjZd9eH59UemXjj/wnkGQtk0uJKas7dvUSCp1aH4aHDZRhW/Rwj61UPjpQzExpCVXvJhbTUtz9Xyes0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839240; c=relaxed/simple;
	bh=e36M4m0wy6SbrzsiD65rGtL7pX20jFSGiR0odb8ZZ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b2OMgnJmrq8KTCVBbBR/lRgUr/NUrV7WwAYo3hd6pefw4e1Hu/+7KhIc1aPK0Cvp7hkzQPs1C9AR13x31kTa3Y5QO9VQ12o/beRBI5k7hbCUu5iMFZfw8/AGWzhM5iw7laTnIexfhCE4Bot/s8Jet6cCdT8XZnRhdVmI3OWNb3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B32it0CE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fCyJXIxB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B32it0CE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fCyJXIxB"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626LkdsF1896167;
	Fri, 6 Mar 2026 23:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rbVaqQCmxR3q6CtORi
	ehjrNlB/rWdl1pqKN+pbkKhcE=; b=B32it0CELxGUWLUx2R/lrFV2wu/HTUoUWz
	klEY1tTz1BXkeyZGNtC1U2Gy6V+EyooJxHislmNNY/0f0joRaU0Pivx5ePFpQHP7
	IvSiT0r6GEEVRGdpT3FOxIxsPB1ujvOdN8tW5nU2a/B9juHC/ombxC50aFPs73Cf
	8Ole3HifMzXwnYFv2s2P1IHtTZQ8qNizmIyPRvAv6zsV2LIwrEp8dPqGtm18LNhJ
	ybVisS8jHmUjUXlfAMhNhKDsp5L2zbdGEpIJDcqu6/6ojL6aYYfJsFnfI0KnTUYY
	UPXhKywFK5T05b3f5bxhUQIrLzArzl00qS5Qyh/vHraXAo4bMeuA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cr74wr2se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:20:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626M092P023007;
	Fri, 6 Mar 2026 23:20:32 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptkk1rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 23:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEFO4nO6k5YcPKW7fp9GzhiVW2Jzke7EcOe7p2GH3aCwf3LJ+w1AIz9ypW/7i9mjMrBF9Ky4t0m2x3IQ8XtzlEXwxjNwbxOwfa06BOmt5Pz0gDLfwnCwk5DBOUh7l3TAuTMpodAtiLkKs9r224xsRD7hGW8vAzxrcAFaHK3rUKi4Z84O0+UCGJYfLeBHgbZGJAk2SwXCIA7WBuS/w8wzF8VfTZOirnXxtijQCfRDlTIbSfc3MO4r7frczlm6tIth4qdeBBZpJhWUfotVstbLDdKxtF9G7tF7TyfeAlmGnaCnQjA4N50SF/loWhELzLMmZx4Vrf/NAs5uRKpoUFPD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbVaqQCmxR3q6CtORiehjrNlB/rWdl1pqKN+pbkKhcE=;
 b=VM2XA39dG4tTBArV2r8ExWCYm4UBW0PzifjT2YPEhAwk3926stOvP8tr5DWS/LQNAN2g8PNOa6Ujf/dm+B8b9GNOzwCZXq6K5lPmqPKOmp8CYcsXdvZ+XcPwx3Hqu5IAjsulrWG+/YhUoY1BHg41lXhi2y3R1MHZSE8eNrqnDiSKvpjWsTVqbBuxmghV3JFZ6kZPxWpymASWyQwfMQkChnZvaVWXqt83Hs2mQGOPFz4DnNqGjkNpQGQm6zlmgqgwU57qE4ggNobJ4VGQMPfy85n1FuJIXDPrdW6mTQM7LDIymtIBtaCYd5ZH3O8of/zNf9p1TiQMOKMTMJpjvzTOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbVaqQCmxR3q6CtORiehjrNlB/rWdl1pqKN+pbkKhcE=;
 b=fCyJXIxBve1QCZenzJKN+IO+6fmN8chKva4yR6VewlKZO+O37yH7SNy7AwnUkPVdOZaD4YJkknzki333vRBonlGwmVNuUgCJLki01rYq5hzU4UtGG89jynrYqW286OgOOizYMnkeun9YFSc015pg1JcwbnXelpOboDyb96qvJW4=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by SJ0PR10MB6328.namprd10.prod.outlook.com (2603:10b6:a03:44e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 23:20:29 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 23:20:29 +0000
Date: Fri, 6 Mar 2026 18:20:12 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
        void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
        emil@etsalapatis.com
Subject: Re: [PATCH 01/15] sched_ext: Relocate scx_bpf_task_cgroup() and its
 BTF_ID to the end of kfunc section
Message-ID: <aathDKJGsuggx3Yw@dmjordan-vm.corpdevsubnet.oravirtteamphx.oraclevcn.com>
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306190623.1076074-2-tj@kernel.org>
X-ClientProxiedBy: PH7P220CA0075.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::11) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|SJ0PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ae2c42-96d3-4fb3-e604-08de7bd6f494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	aSQGYSNY/MrWdI7GncrYh+UnHMPXx8ZEcNkQl1ycw8qomK2CRyNPwmoyMhdstQkk3i+0fXJTngmg+5J/v3q4PRXVD2HTIXcQjU07snJMgbkTLPTK6qpGZ7+KRSBU++itWY5cpwOo1S7mbA1V6+fnIZVg0e97h2aOyBoLsq1SGQVVkylvw+LOkP6lWm7xg2tjSi5FYtGOskXa7C+yymf07pjkzotViHDEX+6QSMrLB9Mejit15sHQfBk9gxDk4UKlvFi3OF2cNJoIjvAV5yG+nvo6Du3DG3JQcDwE+PjmrZSv3m9Dmx1Jq/64EnrnWJLXFz/sNSghuMMMBtFDYb0+XjyUZi7LqojN1FbXUEzJFq5x1uTG3bq3/PB5wvKF5fpB6zNiLgilV0S74ntx+Wu2QOR29GFLwbw2DiK1ij4qA/OO3DtxjHumdCb3lp2qWl81n+Pc3ZhlaPtNiqdy80VWAMPAo171Oryl9zTaItN2B60MPWLNGUD6OBk/gKzJ++EO+d62IjDugwaN4bHmeaQW9w1pLqR+ePRwOI8J6YkWLypzM4NvbvTIuZ7TBOJhUAzXZmnGCl7uBA+bJ96E4GDQA2O+DL4+BTS6jjqG44PUQsQd6LXsTJ6GH21PYs/dOutwqWyHFRCkbrFSdDYR4YuJUbU+I1ZjFNp2ZJgGjiIgvJByB61wE9gxaG2UgsYd4Uuw9LuylespR6/gUKFY7jRjKWjJJ6ZQm2X4qCpGXad88NY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nyFGmPBqcnEC2p4Y6Rs50EDeWaGE1yrqBQi2TjL/0qcHvZr4n3+u/M/3JWeW?=
 =?us-ascii?Q?FXhnwFJV3OFxcXIL46mFXy+fnOlAJlt7+sqSb1UT3KHhY8rdLHW44asedZsx?=
 =?us-ascii?Q?+7Knd1wm0XkVK//SJ5OJwDTnm9qjGn+OuH/aJJM+gm7lLvou7rcGsipySBwG?=
 =?us-ascii?Q?HQihaFGOia8RRog34KbcCXmNFOXSZixVdnkHNqLW6fPPUUSmDojFJj5XSkh4?=
 =?us-ascii?Q?jaO8zzPl249ayB8BzzX8DVt826sKlr3lA5udUcV06i+q3XXJ2gKJVacIghTW?=
 =?us-ascii?Q?ykTYhBOTaEYXTLYVaqXOwDMaWlPUt6jmYVt2meofm8/pL3jdVDsSj7R6cO/8?=
 =?us-ascii?Q?yClp5yywI2KZlfIL2C2s7jMg482gpFmicVMV9fJ+0YFmW2WHHPCmo+EUq4IJ?=
 =?us-ascii?Q?jkU0uZCAe24DhNyjtlO8mtcThVqd+8mBr78Qh9/pZAAsujcPX3QdGBb35O2J?=
 =?us-ascii?Q?v/hDUZZ5sE1QEKc2iXFobsXDOTIdzKdGooqm1FWPtDfQVxpBb2KvIuc5OdfY?=
 =?us-ascii?Q?DUNv+COhY0Bzfms7iZHiZlywy5UWVtEaiyeA1d5UghYUnUqZTxnEnQNLovKF?=
 =?us-ascii?Q?4RoEZpEy9QNZI8RZX7SmgmwHC3GIn387ZCU2j5H9iC3ZXAFS8pJ83Rdehh/S?=
 =?us-ascii?Q?/UYSLsOj9cjeGcSIdhhLyjKwSbPaN4ecePRYWOwZy6MVOf1+EPivx3K+e055?=
 =?us-ascii?Q?tPzCw2GryMO9CSI9DmwINR7fHfjdV9UMS7TONMJUpES223yZ2BNaUzypRKWn?=
 =?us-ascii?Q?DfAFeGIGeSToGVoEPlHdU6FEWaBRdojycQyd6UVhkb5GO2UFynfJ5LlvDdFD?=
 =?us-ascii?Q?4jGbB0g9utQha46xA+xUTVT2G/c0ZKb6OajW+xvEycSgu8+UcSxH5ex/LDLc?=
 =?us-ascii?Q?pEkUtqu20F5pvr6tcQVG0m2xEncTK8y4ewnqvdmauw/LeoE6B4PNp61fYvUB?=
 =?us-ascii?Q?JHxxkeIHOFWPEOJwtt7e2+9g2cr4jAu8IJASPTS0ybFLT0gZHhJKMd7cahr3?=
 =?us-ascii?Q?i4iUI9LKt1MDV+M+EPtY/XEObM4tFJGjLEZlu1CeW6Hp/CXM/m7y5aZRnunM?=
 =?us-ascii?Q?iYYTrhlgLbVxUb8XrM5m1Gy4n7mXodJlny3lJlhprNrTW/O9J0vNI179ACM1?=
 =?us-ascii?Q?cY+df3AVOSFJ8S+S9KJwxd7YLetpVbwaVloCpk41AmpOfQ9mvzaLX/TERhIS?=
 =?us-ascii?Q?CbxxMEkXTNkiW+Fs2CzkpFX9QDFqBQF321VAzekoGcS5991Y0Ahl9hcb9r6t?=
 =?us-ascii?Q?9nsHuJim7cT9ixQJHBWCy3kxxN92FZcXSjV0ytiM6Wvul31GqdPvLQ7h2Ro9?=
 =?us-ascii?Q?IbT6+XWR13ib/2WxTuy9in8Q4fupUNAIC0aadTYTySw94R8j+uw8OnUaiHj4?=
 =?us-ascii?Q?GWKFbtcdyxJMYeyXGx6BuPOLYPlNGbiqYO9hOALALRG7eaUO57WqqJGzzm8C?=
 =?us-ascii?Q?faSem/XOfPq72sdJ1ziIST+sUdlCiM8ALWwra6APIoXGDGmdEdgE+ATCGUO+?=
 =?us-ascii?Q?+XeoqMVPEDcNeruIi33/AnalM+LwxCtbL8UweOGwvb+wxckH7qV+R4guOjLF?=
 =?us-ascii?Q?Z8kiCrp0ffOt1PyZ7w5R73JW62P1z60+dJcbhYE0HAvQWcx3li/rzsxegNyi?=
 =?us-ascii?Q?uuLwBWv3DbQz1/5QMuVUXgvrmRnacu4WEoSk+dmn1Tvsb+eQnFhFtFHv19el?=
 =?us-ascii?Q?sJmaOxst+yCUiHSv/E/RzELeaNg31Dw6z80JkGTDxeDTgUZf1KcG2lAuPob9?=
 =?us-ascii?Q?6FpP2xcD6dgP4sef24oFw1KbVgyJbPU=3D?=
X-Exchange-RoutingPolicyChecked:
	g1yR7FSwwzMrBKNXTK1efioi/DEK8JNT/6k+7eyuZIQ70cG7EoTUp+QsnVN6VlN75XXG5kR4AqgRxq4i1G9VAXtziDr9e4uT/pr7i2s+TNC43HSf859uS/BJoaARd6fSMrOu9rdZz4jJ5J6nQ05AK3CPxTbEPEqJQ1MAyjAFUH6O3Xp6D+rovNn6eRsBGyGGXlqqKcMtjFhPFJi82PcirU35qtw2zNx4cWbd6cTrOEY1ztQQGvGfP6J6MgoIzFO2DTWAoVlCLWcwxqsV2ysvOAg9hIn83pQYk4BlRY0VKWj+/2m7NLIRsCYOXUjYVQMxaWim+XepDnHONgvsBOwLBQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C0MobBrq7aXzB8KbzUqRzHeT1V1Njmg2QuQKicFqAZf0BIFWe4C9JPqBlTgnmTNHWxp7KtloaOsHqv1I+C0e31vxT5Z0qLbMlfXF9zwC+AVXjZFs6sg20GqVsiniVtf4W8De2YiDQMQ5E1ldGplnI/o2iyMItRV1pehcw2g+CZsDZAsaAlVBaSU6m8rovao98JmnlQv5kCGNYYoid9aJjGfcuTn9sK9m9GDXTNR5ndRBHcNwIJWvdbt4s2uCcajh13BXbQAx7Dyc6ijvbgwT0iLCpIay9SFwbBHIC8Gwp1yRKMo7XO7QcKHtcwLlcWO8gFnXYj0iaDJz0ADR8FpdmkbXli4owGGuw8UHCY3IiYHaftFoLIIm3qxAULV/duROVXzdCyzUCz1s0OrU6E4I4O/Is4ezfHRVZqachFQtBnj4IviJThhqxFQEG11yrD/CmJbsO+932ngTsn8Vn1lI51/apTqEcR7kZbMUreOobo8AHUE5uZooMotSI2A20BCAiCld4LyR4UHytVV+W1bJqsEjt/vWr9to2CWfkgjTx7EEYPQy2eTRYkQkBbdgvR/ArfbyOYNLMIU6FR1YgQ4o51b2BA6LYJaNJwxzHaocTyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ae2c42-96d3-4fb3-e604-08de7bd6f494
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:20:29.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Iea/HBjbo760/VYa9sLZcyiZUnElz9G9mLOrBKtAa81wk5zIhxAdeSjg10ttsrP8uifaLvhRobknInl7/BrRkePtO5V4bTezCVpa77Cu4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060220
X-Authority-Analysis: v=2.4 cv=L5IQguT8 c=1 sm=1 tr=0 ts=69ab6140 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=h42At_PwtjAI58pJ:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1bW6dOxjPjnLntniyNUA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12267
X-Proofpoint-GUID: LUROODfgFsUk36ZbzGMBgh-uu-D7ESqD
X-Proofpoint-ORIG-GUID: LUROODfgFsUk36ZbzGMBgh-uu-D7ESqD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIyMCBTYWx0ZWRfX8cTgwQckaTmF
 K8b0kNyQIhHOsZpcdXXfBXERSZiDx7fKLtg8f5fqJ5whfowfADJb1pco7JsoKKt3IJfJnSS9Ep6
 AhQW5EKhuJxMTaQbxmRXFn/5TVlOjfoP07orEDi2vRLHmuOgPadeiSWS8mfttNguumAj3kOADqY
 fOFwP2+BIZG6Y6mXkfuSF/zG0nbNuT5j8HCt4AuQonAtoJOpC7xNXKd/cH/5g7roSITcVQiUFhY
 Uw6DzBZZlNTT0fXOdtOeTcgvPM1MEUFu+jM0NrRDkhxzj5yfkQEsYL3LQzY/TjCDuXHXQVkCn1n
 5pSlsZ6rVSkpBSONyHQQCAx6H3Ozgjq1BfyRwpjsduEUc2etF/MWcsbm9a2Lf0IKKcA4mhbAfbo
 eCJffEtadTLSBUE+YD9eqRcqjFxk+wK6vYOZ9k2TLddT4It0F3lfe2eY6Lt+d5NN9mTVC7diYK+
 O0C9P/lyOG8qKwFA9LHofBay5C6/8n6tYsuXQIxk=

On Fri, Mar 06, 2026 at 09:06:09AM -1000, Tejun Heo wrote:
> Move scx_bpf_task_cgroup() kfunc definition and its BTF_ID entry to the end
> of the kfunc section before __bpf_kfunc_end_defs() for cleaner code
> organization.
> 
> No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
