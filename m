Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7122FBDE0
	for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382361; cv=fail; b=h/ELHLwHRDLLhN30omZFYtgsX/JaCZsG2gwLgPp4RgKlfAUf3kr2xfXJFaMlqMINzdT/4SX4otFRlT4gSXwT+9RF9nZC3yW035146PLWF4NL/TCmJwH8lRMfGJk6ALmRmhXMpyYA85k+wKhi/f1rX+Tn9DM58s2Kmn2qaRZPkMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382361; c=relaxed/simple;
	bh=OeRDoV9vPBgki6GhPEMpDgBex6FFpPmk+8RZ6L9Wbiw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T07XEoGfGud+r6WAjVXu2/GGEXA0lWNnb0F+D+g6wXSPgA+lqLV+M2rbo8AF+EElg4D8KOwHJL1Os7YxP8xMCCcjtaOuHjSDPYPq85WJnNeTgRpLASYxV4CpSp/x4fHyy/xPsRRTJKlEH0hchntWb7Tvnk+//UkzH7lJ6FJIziE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NG4cE6va; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YhlQOmMP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NG4cE6va";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YhlQOmMP"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJgRDI613140;
	Tue, 24 Mar 2026 19:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=qIQaveh7bJJrWz2l
	q2TMOD3RXeEigaeNIhADQKuLmr4=; b=NG4cE6vaRErQWbdMJLEKCjWKb8G4wQkt
	zOpxoj+ST49IK30xP2u1Z6TmYuWJGrBcbuwA7bLCkbJWusfANVXNbkl8hNGNGOZ1
	ZutnDDgIJJw2AsPBXEJS/l0oA1a2JrA7mezK8UAbELmOG41NhScUjoRFRCvL3D+S
	+8B6yjugI2eEld+D+ggrgEqWbTYTRvZSUK6rb59DP8P8ACS5/kBMTmwfxaPSq1BV
	oGZlxrWC/FdE1Nn+/bSAdKx/UzRwAXDaPxUuiRNM0rxGK1riUAZDu8WW6aG+uAiy
	9iLiwI9ThbIDmGB6AAnbmtUML/s8ysCQq4QkqxNeM76IHQvOysZpaw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf51m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 19:58:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OIo62m028955;
	Tue, 24 Mar 2026 19:58:44 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsadqdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 19:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRSumF0hII7Ucxo6MfgP0XNXgJui1bizsKbmg+7iIQ+lYh1OcmUojaod5X73oqgMT8Dss/1OJUsaS4ItSOUXhW8zsgHvaqlhxcwKP6rHXsHoJJiNmAaq1BUVUpuVHi4WvKuDOEvO6BPfROwbZejedcARb7szQ7qSzwZfYHvBMkD+zqLVblPWi4NySiimkuMQtichBg7wDkRk0+bivfN6sCVR82Q4JN6yHCEq7SrSJ57mWofjRS8UHJSWFv5mRIHK/Wilb64ANS0BatRZCOjKkA3oJz78Gj8nxUEADJcbyJI0i7m3++44/frWp6H3y8mXSJvbyVdYGvrpcmjIjU4LVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIQaveh7bJJrWz2lq2TMOD3RXeEigaeNIhADQKuLmr4=;
 b=RzstT9rkTanenlD14R6oDbrtTopcd6SnZsPxJBnntWn2+fIIm8JcRjWK93l4gkQREdE3/CvSp3NJWSQkRKedtBQYLt9QR2iRofgPBPpc8erHBi8JFlxxP3VFZNMsqSE/LAGPohJW7E4SRl7ZltwFqL8YF32FMaiWRH5Uh/DQe1tlNfTb+k6nzEn5jvfq0PNwdZ/OUFHEkuk/NbwNOVbWDNlDfqBEOd1IiwrV5BTMrH4PNzu9eTbolaSCdudnoZj73HfNRgEKLs+aCpvkIia+v3pnVR3V/Fi4Oykm7Iri4eRQig9IVRLcoxhbejw/v+BBcqFGTDvao/rWSXhETVUSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIQaveh7bJJrWz2lq2TMOD3RXeEigaeNIhADQKuLmr4=;
 b=YhlQOmMPTVARQ3/g0HKbMk41oe/bD1nlzDMlj89WZZmmuXCEc/7hJ7pYb0d/GvbOXpR1F4SabB5jkjg/bbty1EpuSZhNwA+x3N3v56N5MoHRlYyAwEfCauFOk6c/3NzzkyGzXBnNtOkH/KaiS8sdkpPQBoTRzNKdbyQNUAxMM0c=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by MW4PR10MB5837.namprd10.prod.outlook.com (2603:10b6:303:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:58:38 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 19:58:38 +0000
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
Subject: [PATCH] sched_ext: idle: use active idle domain in WAKE_SYNC check
Date: Tue, 24 Mar 2026 15:58:36 -0400
Message-ID: <20260324195836.949831-1-joseph.salisbury@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:510:2da::15) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|MW4PR10MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7aa2ce-28ca-4c5f-f3ee-08de89dfbd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CzpWZlfyjzGXSxcS8ulwYuumG99xX07P5KOBSSgiYSCQUVULqShUUhIpTpROoN88VuLQdMFjHfqDRmHkqHfLYoGJkL5Fe50GmLj617YPXhyamtM/hfEvhm/sDbZUjpSHACe94TzjFxRRhyXwBtbbOdyI3i6rcOSZ0R9nNg09SPyk68AdM1MeGN5D5EOt4ccs2lIBdstFeta3y+/UohKN7lGw/A8nhbclJShbL0ppC/ZqPb3Uq9WbfTxjCbsMfnOtRwlOBtQwZCyes3OJWktEdNE/L+3bfckXbA9oKnmVpVYLNy9Bs6lYEnKsrECM6X2FzupSxEfp4W2shnXxMuycJ6fKN2G9kFeMdFydtqPRtWdyY2uYtxNLrtjdA9lGIilnTTHeRgxRNoCFByCK5VBJdhNQXa26A2dUfIU752N8OdpCU85ojnKQ3EUXUZ4PK5qqpm2RhjBFUBVSRLRiDxSnHWv5KS9dbtI61bJNoz9MclUU+Hf9Zg1NilGf36TKqvK0xdTBmFpTHfS2d4AZjRFCQOq3ar5zoyVxuAYaAnVeITm22uykpPyPDmcVruVYj+rwVEqHL68k0YE/WL+0i8BEQqMaYALm/rTbbVktwdqGAErgM1gTDDAAShzGPy4twYUUTj6v9xt3rmTcK0001CHH+5/IMXarcpsbd7DlCZg5dUOOg9A/ALS9bM1NRueeWlJc5R+OvlzfDeWL/e2Tk5UN6A90oJcCzaFCvzkWDnD75og=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oN4yJOMJCgULFkpP51Nkx3KDLH6PZg961VIpLOjTmVE186XHZe7IVP+ckDEB?=
 =?us-ascii?Q?Q79D1jAuqdUoH84lhBrh0PKx3vdwUbKhArZOsLSVDiCXw1u98h4fFmLzHPs/?=
 =?us-ascii?Q?c4arFqct0ANIve/8mbwv/0/UMgQ3l/JN2qzPFxR1oe+cVa4/XkYp1++qCReM?=
 =?us-ascii?Q?ZDtRgfzdg1c1m+6DXO6mQvTVZPVKtCJ0WhICTpj5is79KAsGa7+P4Gp2AZ18?=
 =?us-ascii?Q?WKcBPtfEYauHOxmuA3nFQLMEl5T7LNcCIZ5p3PFFIWAHUIYkAMcrrvulhQsW?=
 =?us-ascii?Q?i/EopriVbjcu42WaH8tsxY7VpOxgYTFbuX7W+LOPn5IOyV3xNslTYXYXXpTj?=
 =?us-ascii?Q?L74TqgarGvAib/ChhRc3y5o5JGlAHN0dNU6hzTAGIYe9zGzhgmS7MqH0DIOE?=
 =?us-ascii?Q?Ddxp7CXL6XQmmLcvnSCXrU3rEDRqHGwFcczbx+vJEtHuxZ+CQ9EfKQ/NHkjr?=
 =?us-ascii?Q?uFH2IwXXXleKdQm4nYnHIpzowIArvdZqz1TkC+14aDSLxD5lrn43QRencKyt?=
 =?us-ascii?Q?39cS0WOCwfWG3FSaVKMSpxFueiP6I2fXt463Az+cUbo/RBcgJghKm4zZ+OM2?=
 =?us-ascii?Q?BTjkrNLkGp440W17pkjspYXS0IyxfYccEGtpg5bm2Gx0vCHJPutrqxByUo4M?=
 =?us-ascii?Q?cwoC+8hFjGPa99oWJIfbRnA6+pZt+MSn/Jq2ZgvxRhBsu+ZL0coOkWQ+nljW?=
 =?us-ascii?Q?mOcmzundZHHPSUBA3KX3blHYFQ1kOjQqzn+B3oClvkN7/Za6SdrXDmunlx7w?=
 =?us-ascii?Q?rgydiZfDb3z4GcYvrgT6Flxmsyyqx93C5ZuTYrGO/hcQ5orn8jQ8jNUSaj9J?=
 =?us-ascii?Q?PaPoUAU9p6k+vJSkkn705gdzEIZMCUg7KyDQwQbPu1LMf6mIvCmG6fVEa1dF?=
 =?us-ascii?Q?YsxBo2qaFj4brztpAH5sczmmi9ucem0eWfWr5ExRyKksJp5JiozMS6oMcNBP?=
 =?us-ascii?Q?axNdLCQxrLSOO7PVQaZR+/zCbpWB+PaTMhaERvbO5l2TGKSU2hfxrRci98h7?=
 =?us-ascii?Q?63LnsLLKNZxwkdL3o2We7igfL7ve3FJUHQIepONDw3cP1SzxdBCu0ifVpRqu?=
 =?us-ascii?Q?RUzknVJEw2K3DrF+Ie32PxiIQQC7sVgTtcJIclWKIvrIOuNInlskT2wW3oGO?=
 =?us-ascii?Q?JFXf+Ylog44ArJE6EQWTXZXHQ9FnD1mIF2fiTSeiKLKDPiOEqMu6cnJDALkR?=
 =?us-ascii?Q?ubY5irjh6WKB3KUUZA08da7EhTV4/5Xj7zUf5R9uW88vaZLs9vq5F433zEtu?=
 =?us-ascii?Q?287deLean/1M2sXvPi6GpGfh494rElyQEAJgSz7LjXgier7sxYunlf91wCdp?=
 =?us-ascii?Q?YmpKze6Ae7H8byR0QE9x7rLVoaENwyt7HRQuQUC8rhU2E6HK3B7WuGS6Tccv?=
 =?us-ascii?Q?5NEKJ/NMfMUmRNjBSBlzYe5kAAhMtJNSmNiML3Yuwv7CDtOlwEIQBSbbejcb?=
 =?us-ascii?Q?OmP9lY5oInjIR40Ys4WQ3wHIwrgZAn2qvSs8rIvTB18259AwAb0iUSgppGgQ?=
 =?us-ascii?Q?q8z1A8d/ZKsjg1HKc8vTDfa//PYLO0UlpXdnPX7iH/RADlxJZoDJsh3tdu6N?=
 =?us-ascii?Q?o14OOunlAKNqZGtn3fJEh+f7A0D/NSGgkG3FQ3zN0QG59bMAEcwvXbFcew3P?=
 =?us-ascii?Q?wlp4NomnOZQpHFByA2NCpqtzOrBnZJWGmgNANsh9UxhO0HIcIQ5THIpru5DA?=
 =?us-ascii?Q?EUnGhMRePQGyPJ/Qbhrvjaoo/iflK5Alnw/ccrDhAf65NRmwlwDaLoR03rTt?=
 =?us-ascii?Q?E99ohDOc7dlBUPdcnCxjLB0XcMrd/5M=3D?=
X-Exchange-RoutingPolicyChecked:
	X/E2gQ/KvIJXskb/2i1yNvSquVYxi33LViikGKVtI/WtT3Wm0em3zuyVaObImAgWyKKx9iFyATUIQa4QwLkykAA02Ak/uvUuP5OWqCov5ekHZlVSnBoYQfQrqJHGO+x6QHXS0ffIGzbHqZWWHpRrCiwu4Q8J83SrfKLd10hHffHfl5HR1aOx+QClD7qOcScKoAqOpNua8HUo6WJKCd55wCzBAg/RRlVZPQPKMWM7L7YL1tdncnhw9owEZ+YNjamCVTAzX2Rd+Ohfde18dbIBk0bWafeEo9GNpp4XCZsM8C6r9DcDXSmpsVx6PSo7/MUnkgDkHqNfUGihuvWRcAGO2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eVG3R9yjPC9ZGJR1P3a8fDxNopSPSyY+VQiRvdATa1AHg+pGiuhj5oPb2hhj9k6jA7qXjAg6znLA1bziauOW2OgnrHeP2D6fGx/qbGVoLhyEuDsNqWUC+CcH1XTYNdOO/DLR2xz3qGMDeaaWwqPhSxik4yLglVb1tvxsUVm7AHGPngdRMYgaqvsupuOQQB+0hcBnj61bpvyOdyNMGk9LNsXvZbSYybIvOlh4673DH05AxYn/A7uDwk8MjpE4BF496FaIYv8swJOJeAWW0EDKkn6D+GKTB32THFeBTQJUkVdc8O55m2AGf5CB99kwuzK6ER2MDJMlhrtGCfvSf/H3h1uKm8qmwke8/xre7iw5F6Y9q+WF/uAGGZADwjW/PlK/OpdU0Sw2shdHDRYMYItQHo1QlkOVA+i6CmXieVJiBuRnkoAbZ61Znp7506nYZW+gPeDMJcTcWe29jiElE9Y9be131LW7YV44nxTESr09aQ21JNZlMaOe8pUgSWYVrklfyIvH7bAKt+X1svORz3IdaU83PNLqgQX2hicFWyIJvYzFfwmSLQnUW/MadVCbE3yZ8Z1Xwj14JsxbPftqP2OGEgm5qEJL9/jT2gMBqTPAYZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7aa2ce-28ca-4c5f-f3ee-08de89dfbd6c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:58:38.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJxkmNfDkBvEjW9ryD2O13jE4KkG21c325y4vgOfJFH8Xk4Iacg2ulTpp1onA0jFQr6oQbdts4h4e74bgsaZqgAbXMmfQM1H/rfeFy6MPis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1NSBTYWx0ZWRfX4Lbk2/qaRWXY
 S1kmh7J/jJ678WsYiXfjKv7o6vNfZ8DePlC56N8KfUkaMZ0tVHEdY3KUVyGV0aVY34KtroYRHBP
 cxkZU3tHtk658VQcw7Iy2rGN0a1RIS7vWi9ccK5U1GBk3jx+JT524YnikScH8bvJvog+3UA7KaE
 DzSsAFUkcZSYxGnlh69sbYaP9MCWPwA0fgC0QwM6x13BHxQaB9Bvgmb96KwZQqfLEANogOMecpv
 oydfEet8vYUwSadKjbG+qbNOIG/HeWef+Wnrgp3SrzPjIvrtb+sAfuOqnjmrsSO9z45ZkRXX0u5
 w5y8fXq9uZTsZofSdRdWwzXYkfsn6VCE7ujLVNb0xKCia9z27q1eDWREwTdR14AkCcZV1QngY3t
 NQ1T+KjkMkusnCmj9FkoKfktbOSj4YB9APFf1JlHmslafAc3zIwAsFtXLdpKHHMWOP76/Smsd6N
 lelbnD31ErszG//3OYQ==
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69c2ecf4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=14YIWGqh1p4NlqadjxIA:9
X-Proofpoint-ORIG-GUID: 0Htki4s_DoRiScu5o4I3nw-HpFlEE_Mh
X-Proofpoint-GUID: 0Htki4s_DoRiScu5o4I3nw-HpFlEE_Mh

The WAKE_SYNC fast path checks whether there are idle CPUs before
biasing wakeups to the waker CPU.  After per-node idle masks were
introduced, this path started indexing idle_cpumask() with
cpu_to_node().

When per-node idle tracking is disabled, per-node masks are not kept in
sync and may be stale.  Reading them here can mis-detect system
utilization and lead to incorrect WAKE_SYNC wakeup placement.

Use scx_cpu_node_if_enabled() for the waker node lookup so this check
uses the global idle mask when per-node tracking is disabled and the
per-node mask only when that mode is enabled.

Fixes: 48849271e661 ("sched_ext: idle: Per-node idle cpumasks")
Cc: stable@vger.kernel.org # v6.15+
Assisted-by: Codex:GPT-5
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
---
 kernel/sched/ext_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 8cfe0e9a7319..6b4520ed563d 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -543,7 +543,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		waker_node = cpu_to_node(cpu);
+		waker_node = scx_cpu_node_if_enabled(cpu);
 		if (!(current->flags & PF_EXITING) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
-- 
2.47.3
