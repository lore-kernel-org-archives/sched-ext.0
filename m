Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76130FF33
	for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381396; cv=fail; b=tuUlF//sZUeSs2vDA5q9K8IhrnznVltuBn3Y2L7iEMG/i7vez+u+SRMe313/koDTpT/AsSb/BeExBG9xd3JMV/1eHwkadpSqSflejSaT7/rQjdTOB0Zf3bH+eH8j+hXMvo8rWjjcb6X2rBPp9YCG7Y5IaXjk1nbTXGUZqNQBEe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381396; c=relaxed/simple;
	bh=+VFz1CiIZD4mIDeSvqPGH7ozdFbGmizC7tpBe7I/+38=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=guG447f5UNxmA2RmdFEzruM5wiiFES3sFYFUkGjhMXo1VGWHjItMeTZqc26IUBVLKWrBgpLNG8iDispfQkc4oOlqhm63EcgxvSSevSGjUIZs2AAVTnXS5ewv5oiua2l/XNhuDLW88JgClhV0IUflMluPWkmTfU580GUgwg8M0Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T7t2vcYJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lw1mqx0N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T7t2vcYJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lw1mqx0N"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJW0qi3886323;
	Tue, 24 Mar 2026 19:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Nc0HMvuTAJJuKPLo
	qFbcI9EQkpxbA4WyfYApQmknAdw=; b=T7t2vcYJ86CQRnPI31NNvjrebfeyDnY4
	qQyuCoG33zyN6Aj3gcnlzE9mjzXufjqjIvbP7lRzqUvF16qQgfiwy/m807c8wSb+
	HiriSPdYW2pJcoEEm5f4lUua7rkoYc+2/LQakV6/AyU1SK6bwrHMK5cLiUluX+3Q
	F4OZlYFX7hjrf1ZL46RUx+k4xfZLrYHX+aIZqEtUmoLLkFE6+W8ajpmNUgeubIwV
	XePvDJ4sCWDT9WD7OwqWeNOB6KUEy6Ybxv+GMgqJrWO3occ+no9xs/Fn+NwFuOvv
	wZE1+aIrQiLwWJwp0UG2Sj0d7bmST8mwpqJxG9zDe0XJJj9vkNBFNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvnn03t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 19:42:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJ779P038371;
	Tue, 24 Mar 2026 19:42:42 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d26xq1mkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 19:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBcLXnWOa2FzScl6Zy4N1VWb+vxHYBkq93CPV5oi2fTdDwELCyRMdlidvPXjmIK6592OLfbErYIvjxtU2g38RswxXdx8fhQaa9lcXAtZ/Oktlmt2ql1KnMXddPkomJVpgCSwK0Pe5aXJsoIE3sOElNxOGomoAHYk80910C8GQxH/dKy80PBb6/oc1/9WlaDtRl1ayaU94JiM02xidszehCKeWR0ZfvMkH0PDBq4VWJEKCmpYs33Y1IMOeBDhjX25A+rRd5VV/DBoIyCg5qRfIIA89KSb5PD5k+/YakSf/E4/cgSsrRy9wDyfQtsWrEG0yPx+LibpRafKj+d4CHwg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc0HMvuTAJJuKPLoqFbcI9EQkpxbA4WyfYApQmknAdw=;
 b=GvrN+AcCd4RKdz+C+M6UWRkaggtIRWfnpNFoqDEK713KFTlTu96IU/VRS4VNn1x0lbc3ybU49zrwNqFz0UneR7+pDD/GG2Nifps4X7kjj0wN8rOmGfAm5b1MDhWgoD9GcWNYYRuwn6hyXeIy0lwSQH15yJAK4ff0GnNBHiyEwc9K/VfVdNKTvqBRfnh/4dBE0LtyfNgFZEKwJELofsDSDS0+c4yQsqq8ou+wdk6W6UOkhfUniGirxM3fLcnCd872gDSI+MWBLsjXAbUZe1AVnp0Edbu6Nq2ZaQNKLsz4lL3mE80c0NXkDKN4WpGeb69UGReEqbDFmmmzB0WD55KP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc0HMvuTAJJuKPLoqFbcI9EQkpxbA4WyfYApQmknAdw=;
 b=lw1mqx0NxzTK6QP0xdyyG7Jpuh/MB9XfO5hArrbzuk33VmTSRCM9OqpvUpfxQy+AB6nxGT673etCvk2Txls1dPwjXWV1ZA5UGj5Cm4H1gmUvfvs6b8VVj9FHfeFopRKB0XzI/FiiUjKMhrHPTPh6e0BbNCYIjPD72pqfD5+xMdU=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 19:42:39 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 19:42:39 +0000
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: idle: honor built-in idle disablement in node kfuncs
Date: Tue, 24 Mar 2026 15:42:35 -0400
Message-ID: <20260324194235.942952-1-joseph.salisbury@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::12) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|MW6PR10MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 703922b3-0033-48b6-312c-08de89dd8188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ifhbpVxYQwdqO/7whoK3AX+Mf2r78LfMCBs+l0TiGFe4U593DQodG17kmRAjo8vB/DyUhD5Jz3FOMltwK266Ivj7cTkpy/Fo7x5Hu8sPml2EcOUSGcHEkoTUoNeM5oqv9Djv4Pyn9Fv5ug3JI9IYLcYOmFeFdruB4jrfDvW933zEX+6DNJsjvgreJuOz/4iyR77XcCJ2Af2TQR/3mqe5TjxmwuxcD/UMk5W6EaS0k5EtQoqLEAciYkBkcg51enIzBH8l6BowmbnKyeQYgGfMK1DqevHn8nyKQPr84j4+j5uuDmORR6GC35aT2Sj9P7qVlTaNgdP/7b+dIRKFVPINhdeivk1Hx1mhcFJ2yOHHfGAcWbp9Gl1VQ0ew7GT/Z9it2nCtgAisrkAz1c2PoKDWsK12prHcfp/4O1jmx9yMTCxdq9tvEdv35qAIKyJQgdMlPq4dvlSjgHvAp4gMCtAuNeZqwd6pFlhZzpoM3JGIbOPrCtdwAE8QCl1T4haqmD7Xkf/m3RF2/8wu7iWGAsUlbZkoOZO00nh3m34Pzb38o8aRjAblhCCc1m3IhimcnS3AFGUox+bAgIUKqDFk4qGo0SEq9zd/9reXfP6QVWVvXnRSRHP1T3jo0z4wI8zuMcbYiCz6JlxHJDtvo1amhdbir2TTuF34eYykUhhlAwLVxcH+bFnYBA0EynHYzISt0TNdlnHqQeh+GFE/qybyz8aEnZeHaa5bv3FM2a9CnnCef2c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZSrfh0Liyi75+APZNquIimVh6DnwQdrgzXcsDl1DZOjFce2jq91THeIQSfI9?=
 =?us-ascii?Q?QlTu1ryk4SusxDd0HHFSfD46Up3SfQkd6TtX4W6+ajIdOvOsTA5bdpnGBQDL?=
 =?us-ascii?Q?7MBiU9+xVHyp0eruHhaMGRe73muzIQVvZpzjwX/EjFyKuqTf8SzY5LdZZFPw?=
 =?us-ascii?Q?FOzozaGjSC1DBtnJ/zgp1D0dasZnpu4SEL6gU+9TDSWLvQIAwE0bsn5OX1zk?=
 =?us-ascii?Q?VFmjhjMHQ+ZavPr2rVMbhEJprbcX8Si70MiQ7bB9GdE4NZ4PDwsMBcYRZXKG?=
 =?us-ascii?Q?yqQzSs/TKdaBfaCqMsssEkCSLZM/FO9jO2KStdKfx6mVG0mp0BCd9utXC66P?=
 =?us-ascii?Q?sdGZ1R4phsOO1dgU2Qdc9EtoJDGxDRzr05Kg0iV3XEYVyjujO59DAgCtXrBg?=
 =?us-ascii?Q?5SFWutn47PAg/2npuQsPr7/67IOXbRD3F4JqaTuDFTvQkNFPaTxVUZZKyjhV?=
 =?us-ascii?Q?jJRzbsGTpnvAUFxTFyrzKOV7RLXIoAMZiqlof8cPdX3O9bGFPQuCymn1UOfd?=
 =?us-ascii?Q?RKquksnpYoNOkOAWcp9ZygTnaXThPYz99dgT0Wt6H6LUOt4eKITtdsPLccpO?=
 =?us-ascii?Q?o3YVAX4QFzJ36iAugcDRXjJbwhlQK0+p4lKL8Y/5h/A2wHu2NZm+GIKYSGnL?=
 =?us-ascii?Q?foesLGBUZX2FM9awAF80zWYyk32g6dI3B8ua6rndv0lRW5x4ucSu4H9JNGKY?=
 =?us-ascii?Q?/FDNqZPJh2A2zdv6dZXHPSy0YIBHR5W9nzP9R+lKI+UMPjkLQGux1klMjKK8?=
 =?us-ascii?Q?cWznhEsVkiYle5XCllBLsVZ6PR7e546IUC/UgvuooeflURZu1jlt/lzGnIom?=
 =?us-ascii?Q?F4dwE95Jg/aNR8NSjNIDFL25Rh/wsJJkoYqSbIjsmRXIn1btzEtdiIruBjMZ?=
 =?us-ascii?Q?xK/dPgwAfLNteBxYmKXcK7QucRBsVQMZoQPSwLsbdLe3lkjfYzdSA0QqJlRg?=
 =?us-ascii?Q?QaRe2JviT+UNFqSUiWsVoDMc9fUaSUbZjBvlAgpQg5JvpEcbvV7BTvzVkASc?=
 =?us-ascii?Q?IRn84R6BddoEvb2wW1REk1+RozVdByfOShPYjPQbQ41heoemip7p8r/NGbl8?=
 =?us-ascii?Q?2rQeS0nbu0NamBGer8xGU6gDddJ+z1UfgMI8KmmmYhbB993BbVa6x/E+QO2d?=
 =?us-ascii?Q?iw2NhMris3yLugsyeuRforezkS1hUaQ7l9dGgJYMOcRlrBCwITKy4JvpETID?=
 =?us-ascii?Q?mnFwzbXY/5orYr9wBoOXyJparvQsswEM5wB8IiVjuTUIUuVxHWRRF9XwQbx7?=
 =?us-ascii?Q?0KAsE43G69Qv9wLmnwaRpZBlxYnRXe18jSmjs4/5PUWvqdvqxpyRUdgRgHQw?=
 =?us-ascii?Q?FapaWpjscHnQ0Anp4iB/f85OQnNOkTuXH83JHC94PgAq6fyXwRJxE3LWsn2t?=
 =?us-ascii?Q?VlEuxMqM4Hfy2WzE/CBiU16lADkwY7VZZf/olQHPOGOru4kIfJumPGtCCudC?=
 =?us-ascii?Q?G5BC5JlWB+xq2H5DyHhXQ+Zuw3F0goRGV4FQtxDuYzlRERlf9e+l9vqBhZBr?=
 =?us-ascii?Q?Lrz243EDJjZtU2OJ90ut8H9W4XPjMiAgvqGDSZyqhXC81Bxwolo4GwBdRChv?=
 =?us-ascii?Q?irlU8q45R7EOVxjToJO4GQlpQxvV5V/rQv0IZMspMvhoAymTbhxJRHwQbBkz?=
 =?us-ascii?Q?mjRPnO7+d8Ca+FpWAxycn/d9ytg5OmjLeksXF9xLUNWNawqkTcVPQ46b2gK/?=
 =?us-ascii?Q?3jFz+82rpFPqnyr7j5RExW3tswGDqsYfZNb8WwWNzkcSXRviaIAbJehcXZc3?=
 =?us-ascii?Q?TZjXoeBeEgOEy36IvZjJi7Mb1BbMEFw=3D?=
X-Exchange-RoutingPolicyChecked:
	lAkhFxleaPw2CCOdA+YkaGoNHEbi2Jz9shBPMH7W7nGQi3Qw9IXUytaeMd4vWQhBmDIcGl4Du1EjvLcQbT1cy1D2aqDrOcerSTBdKcsWc2Un60SMGQPIZKKPA5gLQDCHSS4QwwAgbgeWpqlt+MavBk4j2EEAWz5F8GWXRQDzuXDMvDJYfsJslqXCi6MqKQ6xR4PWKG4712+UOLcsvlfeBnDPdLus/po+XVumkcTM0EqedOjtBhFsFBSE1Wt2NcJx2DiRbXE6jB+xKx8GdLQq9JIeJ+cBJX4Xehba616co/QUUgMNW+9dGTYayc9ZTv1NtRQkvIk+bdztAyYdfcCr8w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QKWu/82zOnH6fzxaC7qT+0sGi4FkeVT2YAus/AmhEM5TTDKF1icYbrD+DvmMLfVQOAmoQH9CXPlU5CTNRHMYt8Yh+dZyb99F58dFa2ZGkuLRS8FlafWOD/g1RzUl9jFsqQn0pNMrwMnAaD5zAt2rRdZVXZrmGHAX30iP5cw/dh/t/c5E/vobFpMWURZhLRL39mRNrRY42yAePNIEPwqKO5w69jA8OzY3Ni6Q82UlngXHhFJw7t0UW1CMOGu5OzS0SwPE+V/mJNGz/7pmU1oNEkCn9Cl3f2EFsTzTDl4kBvdBsTEzmklrh4uerkDHo2L44AY42scndm2+ijKqlGi/G7WVBrqrqXEzsGenW/rWMDFpRCsW5WSJTx4Obqa2MNPFUY/sBF/pycqIQYH36Vu9ZRU6kIA6+zgZDhMemD51RglCVh3N7fkRah0H1kqI/JCxLNFCXfzxQ/1VL6NPOwVyIMTJGBP9eZ1PZP4gF8ouSK3ZdufLOIuiVevAKBpE8Crj8LRVXzcOL8+1+ofDpz9P59rVHBE5EjRnExt415rA0WsCBS7hTWqFG/z3jeue3rsFiqm+BDjwueMjndESQIbkvYy5AHJljp4xM8EKaEbOAn0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703922b3-0033-48b6-312c-08de89dd8188
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:42:38.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PT5nMDAvqk37VQRLsGdRWOxQfgyYb5RwDh3QHJVmAhi1MnFOwZ4UADNCm3wHnHchdtxC9YJw/jga2WtpreBrZydT9C2EVdnwddVZbHWS0fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1MiBTYWx0ZWRfX1eK7CSMwEVEx
 jhwwhqNflQsidsfFvM6D0hgJlG6rJqfXWj4xyeQHNOWepXSZqdB8m8GOYuLuvG1wAFpVwq9H9ux
 gjxkf1GCMpNNqLhDRJnVw5DbRe4W6lSOwBeOin0YJzfatIRz07eC8l1PcDj6TL0C9ahLvNn7HWo
 wmQMnZ6QbNQ98bMsZQMzlRZ+3kbUmmqP+upuPDVE5xDyaS6d4nQV0lqMBq1vAGpTZXufhTnuMBi
 5ZifI5LEma/DkvFj+M52qFnh/E9qRXYtY08MpsAKuWfWjlkzdps58cyLcjAav5R3V33R97uHHiV
 xUNcD9wbN51pkvLMqBXY1P3/pKForNHNzQecyKw8I2TiOzLcoMI1SjJX8gW+zisJsBoaare9ABR
 cfJklE68doX7AlOPHZ/4LlsdFPKnq9BTz9lwJ+ZBoMfFqo1OV6PvxihbYAmxMBPtm74e2cjnt6U
 ZIW03T5+H4vDsBsOU0Hoz5HXoekk8D5Eo0CktEmE=
X-Proofpoint-GUID: Qp9kNcHXsehC_Q7oIFk5ja5CW3nZetWf
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69c2e933 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=sQP0Pt3UPOgp5hvrqcgA:9 cc=ntf awl=host:12273
X-Proofpoint-ORIG-GUID: Qp9kNcHXsehC_Q7oIFk5ja5CW3nZetWf

The node-aware idle kfunc helpers validate per-node idle tracking, but they
don't check whether built-in idle tracking itself is enabled.

As a result, when ops.update_idle() disables built-in idle tracking, the
node helpers can still read per-node idle masks and attempt idle CPU
selection.  This violates the documented behavior and can expose stale
idle state to BPF schedulers.

Fix this by checking check_builtin_idle_enabled() in the node mask getters
and in scx_bpf_pick_idle_cpu_node(), matching the behavior of the non-node
helpers.

scx_bpf_pick_any_cpu_node() is different by: when built-in idle
tracking is disabled, it should skip idle selection and fall back directly
to the any-CPU path.  Make it do so and match scx_bpf_pick_any_cpu().

Fixes: 01059219b0cf ("sched_ext: idle: Introduce node-aware idle cpu kfunc helpers")
Cc: stable@vger.kernel.org # v6.15+
Assisted-by: Codex:GPT-5
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
---
 kernel/sched/ext_idle.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index ba298ac3ce6c..948f6b4f8ab5 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1082,6 +1082,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 	if (node < 0)
 		return cpu_none_mask;
 
+	if (!check_builtin_idle_enabled(sch))
+		return cpu_none_mask;
+
 	return idle_cpumask(node)->cpu;
 }
 
@@ -1137,6 +1140,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 	if (node < 0)
 		return cpu_none_mask;
 
+	if (!check_builtin_idle_enabled(sch))
+		return cpu_none_mask;
+
 	if (sched_smt_active())
 		return idle_cpumask(node)->smt;
 	else
@@ -1253,6 +1259,9 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
 	if (node < 0)
 		return node;
 
+	if (!check_builtin_idle_enabled(sch))
+		return -EBUSY;
+
 	return scx_pick_idle_cpu(cpus_allowed, node, flags);
 }
 
@@ -1337,9 +1346,11 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
 	if (node < 0)
 		return node;
 
-	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
-	if (cpu >= 0)
-		return cpu;
+	if (static_branch_likely(&scx_builtin_idle_enabled)) {
+		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
+		if (cpu >= 0)
+			return cpu;
+	}
 
 	if (flags & SCX_PICK_IDLE_IN_NODE)
 		cpu = cpumask_any_and_distribute(cpumask_of_node(node), cpus_allowed);
-- 
2.47.3

