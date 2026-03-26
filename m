Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE53E393DE2
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549151; cv=fail; b=XQFrb06Qkulcx0fH1N+bgowsw+Up0rqwHnmQNJQLZXxwYf7IGfLD1dpG/qjcGSAFwbkPbMWkPuCDbk/PxaHQ71JDCVFjJg9BwLTky5Bb/3ngcqP0YOFpnCGiz7VAyPzMQqNb/OKgRkwtMqWMLkJ9OO434U7CkEWbUVbLk3/jQPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549151; c=relaxed/simple;
	bh=ZwJp8a6HNerZQztUso12lbQBJTOlH2mdCD5eRyWsUkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kk7A/Zw9kZIMu9bAt44NxF3OtSxzrR6Lt/Cr+MLaUDuNSyVHLke0loej16BHUIMhMmgN+XgGwxMFHgbJ5sX0bFMNLW7n6D0QLbFyAzm+NsoUjKQIZX/bBqPm4/m6/NvaUnfgZ96qdj/12D2j4MRVZdwaFM1APwLRaWEu29OuPfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M6KhMLXb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UIBiKTL9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M6KhMLXb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UIBiKTL9"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFtxeV2206504;
	Thu, 26 Mar 2026 18:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vdxOiRKCpLjWQzRkbaWbH/Zt2xKJrTM3cZxnIp6c5L8=; b=
	M6KhMLXbApf5N6SnVvez/8wG7LQ+G6K4VT6/JGrx302dWtzwMl+iBkc9K6ggkTz6
	5pdxJiIkcKWVuHNdqC/BGjGzQZGHILNcB2YmgY7r73AHp+qi4/tcOlzaMM/mJycO
	RIuqaMChmYi+5tOlLeTMDiWehCuPr7S3Md+JFxwoeYkUhGUFiZrM5eMGwT1359td
	cNVvpzJaHl/LlTScuCSxlZz7BopPsp3QcaGJQp22PoMzUSJBCksz6RQtu2swl2xF
	LheEgbZPS/yJQos0oewZMzKYJlSr18UxdnA9Fji0VU3Su1AzHYVuR+dLHSV7F6YC
	MA6Fz+OTrtxHhBHAzVOKJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgfrsg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 18:18:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QGiHcc038469;
	Thu, 26 Mar 2026 18:18:43 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d26xt0npe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 18:18:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lERAKwf+MLdyJW4qI8GH0f1SRAB8L1M/70yvqKc5Ykupmf1LPnW20NfQWL9bKrLdqhsYZaBgXILtg0ih7/2LESx6e4lzeYKpcTRYmubLwJhvRcLH16bt5UqTBQ+EAGQPMRKzTJgDVLJ3jU7+5BYTy6GJETAOZbNamYuDe15Q0mnpjqGE+dmXAd7IcfLvII5T7F29nvg8X73+nDROJv4LfL9jgJarAZdQlMceU3Gug613GnVY2MGmCiTLX1RqZh+FMQWvIK8Q40qNpLgEIBpseFlC2uIfII1BcDR73qHEvfa+LodkgM+QwJNlKHlmSm52HRn5Njaavx/GAGeADqYZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdxOiRKCpLjWQzRkbaWbH/Zt2xKJrTM3cZxnIp6c5L8=;
 b=Q8pumxwNSwe4/hQDJA4+BUwRnjr1Fjr2Y/fARI6xIAVyvo6QZUKBDuuARUtlHrAkGuRp7EiiXc1JVzh44JXDLF2pUyb6TUrKBmgGAShfmmJRmakuuQuVFixlG9o/Rvu7dVWfYJNhQJvoRE/kmo0g0yAcUXYMa8q+bqsFINcH+l2e/jEY6QfDTfqrKuqW/WimWCLh96oKFiVL1zqyx33UVsoT+MvigRdRG/+nYMgNpzxb11c92CK+00UtfI5uRvxnYFYHtVxtZZ+tL4vYDyYbt2EGi3hsvPHHhpxYFiMNEWK00IqAgDbvPgOlNSin93+CQCERnXCsMw1ApQx4jY1cAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdxOiRKCpLjWQzRkbaWbH/Zt2xKJrTM3cZxnIp6c5L8=;
 b=UIBiKTL9DEXbTHm+Qhu/0DqrdMu2OPtrgPzoE04niKsUEEFKyAFKstHoKrHe0ie3OX0iGxWut3VqDpZDLM4rlDJ3EEtTCsWOj+744zp6p41gmk64i4drdf9vFcO8KsVtYS7mhun7bJiEBIbWYpXbW8ad9+FdjVnSsv28dWdhNSI=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by SJ0PR10MB4431.namprd10.prod.outlook.com (2603:10b6:a03:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 18:18:21 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 18:18:20 +0000
Message-ID: <f01b925a-7fa9-4c69-abe7-4a3a49bec615@oracle.com>
Date: Thu, 26 Mar 2026 14:18:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH] sched_ext: idle: honor built-in idle
 disablement in node kfuncs
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260324194235.942952-1-joseph.salisbury@oracle.com>
 <acRgKzZodHT2Xn1n@gpd4>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <acRgKzZodHT2Xn1n@gpd4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::26) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|SJ0PR10MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e734d2-98b4-4a48-ca6d-08de8b640f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9y+BVqaW38nlC94p1elABPYgHz0a/81oOhcBj5lZYhXpL6xFj/b+tb96OMQvDAqSLO/uXRQEY+e/BNo5oVB8t1qQAiCmW1YnQVieWlKKscdD4uoiBRKCjKKQYMx0IPt64TVCjRoAHMJGCvdI0qe0L+/9ho8NMftSPctyYVbPvrxXEQ49UxbxKkMFqyGxbONrVRwOkFS9KuuO18YPUFAsmxufO3rXjomPjKaIkjhaQaxdfBc2QxCUyZJ5VYHejrRnw/A9NEkA34urrJm2HkJGuwzwaX7Ju6d0YllXlUSebqiCeqwt+ygcdOy2Q8TBjaBKHnjTKYpqqe+3m/trGwMcZtbGjTFfswIuA9m3bYZboFAq+yCeJQsE1s25L7Tj62mXMSM82RQkAMsuJdVmzejAyGNge8ud6eIXvg+HU4VBGNxJ/3uoTwMkJI8D5VbNsPYf2WVn3gj1GYht7Sntub6nnE1Q6uq//Fs9EX006MaEO4XE6uuNHPUiSEAtfLeMPEghJd+dAu48ROnRQICvHbHqah28dIvRr0vr9Xv9CF8eOFGcHu9/FahoASqrvIxL34hvqE7eh3iRCJ3ThcQcDsyZ1lqWEx1sV3lF2EycS72uWpPIawNNbOHguN3gyVMoLjZuhn/t/PwAOPLJxbnIPFTBP6I8tji5YZDOPIP+EGwtk+llxOLVCGryeydhRp3YLs047ZpxBN/VTPRrox4esx/EvjHwpgI/SoIJTnTni/ESfDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXNqaDNpb2hGYXlGUUwrMzJXWllvS0lEdmJRUjJ4ZzF2STlUMmFNaU1PTGQw?=
 =?utf-8?B?ZUlHRUI4SW9EaE4rMUFWQk55Um9oY2JZSkc0NGRqeEpBSDdSSVpsR2Y4SDEr?=
 =?utf-8?B?OVNRbUgyakVzdG9xNks1QnUxZDRPdVFhazBuUHBwS0VNNWhFYTY4NE9xWlVj?=
 =?utf-8?B?MW51ZTdOYlNHWWtZaUhxYXN4M0FVdHlhZlFIZ2FHRDN0VEZIblNySWlsTEZM?=
 =?utf-8?B?V3pTcU8vTllHOWpiWDRNV242QmdyY0hZd2EwcFVXOFgwWjFEc2RnQ0J1ajZ6?=
 =?utf-8?B?YkJpelJLS2cwSWxGeWg0ZlhGb2pkOFNiRERwdmpPYVVZWlF5RndaVHphWWpl?=
 =?utf-8?B?UkNqdTgrTVpsRmJuNDNPbWpOcWxRcFQvR09QcXcxM3NqZEwvekdMVDdrR1F0?=
 =?utf-8?B?VStNcW9veTBPaitwdnNCYVo2NDVKSjU0UXNFT3hGUVZqNnRyUmJYRUczQXoz?=
 =?utf-8?B?QmRlYlY0VlE0OVlZU25rbC9ZYnFWY0IvZCsyNUNHUVNyNXF2bkxRKzRpNFdI?=
 =?utf-8?B?TFlKK2FVaDU0Q1JOcmliYlMvRUJud1lZK0lqMWNETXJpdmFGeWpXSTA3Sm1Y?=
 =?utf-8?B?QklvVXU1RVlmT2lJU0YrOVgzZEJ1ZzVvZENjSkJUZUhNcjY3VGROTXVxZ0R1?=
 =?utf-8?B?RmxMMXNNd1hjQWlpeVp2Q2JXVzQwek9JZTBVUnhvUlBLNjd2aHFBQ0NDT0FQ?=
 =?utf-8?B?djE0QmFkbGR4U1pYam5vMzhIeVI5SThmYlIreWFvRTFDS0RqZmt3Wi9ndFFW?=
 =?utf-8?B?aWRYVktDaTJ6OFJoT3FIVUY2WTF6L2QyMW5xWGJnTEN0WG1WS2VVeXp2dmhj?=
 =?utf-8?B?c0VGalFpdUpuUjlzQUo0Y1MxUTdxT1RicUN3Snd3K29KRCs0WXc5RFZwZFh3?=
 =?utf-8?B?RStmYVBKNkhXNVpoU2ZiTUFCeHRsQWdpOWFaWEZ3S0NyaFBObHJpQlJJa1Uw?=
 =?utf-8?B?UEptMnlDYitlblhnNk9jRUUrNFQ2U1I1RU9NRGd6d1RGUHIvbVhKVlBXNmZU?=
 =?utf-8?B?QTB2Nk9tVTlwakpYcGNhWjFKRFFlY0wwZ1Fta0s1V002U2Q1b2xBTUNPNGZK?=
 =?utf-8?B?N0ZxdTlTVGZSa1MrL2RzSEtuQWRJZERZbWk5dEVqVE1ocVFHYUNwczF6Vkds?=
 =?utf-8?B?anY5RG5vSmtWb3llQmJVNzdlbTdEdGE2NGthUXlTeW9CUE8xdWV3LytLZWtM?=
 =?utf-8?B?Mm9BL1M4elVoTFowdStCZlQ5dXRZeC8rYzVvZW9YVWVJby9UdERNWXlOcVM4?=
 =?utf-8?B?ZTk4OFlxRDlMVEVjWkI4Vy9JZjVCYUY2cXRKN1JiVVgwRTNiRGo2d1ZlanA5?=
 =?utf-8?B?ZkhjdWFBTzZrL3RqRGE3NzRwMG9nUmhBS21ZWDRSK28xY0RsQXVSMHU4bFZq?=
 =?utf-8?B?elJ3dEtyMHpPQ214SGVXU1B2Q1k4QTRUN0tyQXNpZXJYOTJ6M2oySWp4RVJF?=
 =?utf-8?B?d09yVUVZYVVldWZTMFVkYWlocnBwcDdMZEpUd21PT1BKMXpZYmpxSzZpSktz?=
 =?utf-8?B?eEc2cVpFMDVuQ2ZZQnB6MmVyTDBETzhtMTNra1RlaU1PektsaCt5T0UwN1lB?=
 =?utf-8?B?SHYrRmxtTGllRmFKV3ZNa04zaDdXdnJ5b29IWkNxdnZzREFoc1FyNmxZMCt3?=
 =?utf-8?B?ZFVQaGZwSXFKUThJUlJHS3A4WVhrK0N4cVNJL3A2bXlYQXNjODllU3hrVkRL?=
 =?utf-8?B?eHk5dG5KSmZVb21za2xGWjRNMFR0ZnRNbVN0d2E2Sllob1FjY2xqcWhuZmlI?=
 =?utf-8?B?WjVOTmJQQ1RjZmVWWHVRMmZMM3hzRmh3KzM3ckYrOFVodFpCSFFGUzQrTVVO?=
 =?utf-8?B?OXlBZHgzY216ZTVTSHlkWTFEZHJVa2dvdUp6aTFMbkJka0d4SnNWM2VlOXpq?=
 =?utf-8?B?a2I4R2d4VytPcDZrS1BHNGszeHBZUFIvSFVLemJaUS9NWHhYNzRkQTd0cTg3?=
 =?utf-8?B?MGpnUEExK1A3N3l2SUl5THVJbjdxUGpleFhuNHVYcmFta284WC85VW9oall5?=
 =?utf-8?B?WGdQdms5VWY1a1lDQittVm5OTENwK0Ywc25RczVhRjJObWU3VFlnYVh1aEc1?=
 =?utf-8?B?RkxZMFREK2IzYzZtTk5VQ2QxckRrN3U4aDFmeXpUYnRPZ0Jpdm1VVDBnZ0th?=
 =?utf-8?B?eUVIR1RLZlVSSjZYanBEMGdnYmVoMnhXSmVRS0dXb0ZITkdkNFJkM3BQY1dY?=
 =?utf-8?B?Y0FkQ25BMC93MkROODJxVXlCcXM1aVBxSnFKMVZ0aUtqTVlUOXNDNEM5c05U?=
 =?utf-8?B?aGsrazlWMURMM2NmWHVsTk9MdGZkSm12M1VLeGM4TVRGVjdkNUMrRldLNXJW?=
 =?utf-8?B?REJVSnl0Mmowc1pqS3hubUV5eFNYVG53RW5ockpidzNkM25VZVF2eWthVUZC?=
 =?utf-8?Q?5dCKUZVaPWIesaOw=3D?=
X-Exchange-RoutingPolicyChecked:
	XD+yK28DRUk1iRbU4pFv9Y09LPAGdhqMBS99D6xUSyjbEDD9lbQT9IjKiF5UQuzMM30Px5SmGak/h10wjLSCr1lyhjNp9JnizT2Qkc2FX2BRUJ6pOcrIM1UB50fyGNjkoeCzoE5sjL3dfwBZIEsNV5Qufx4jDkans7s+6WmywsG5lodoMlldwdxBwEiNvkU3l5XQ6QGQ+nNl88ZI6gcJrqcydRnVGiQIYwDn2Hg6eibzkl3+Hjfg/yRJ2q6xwbIfpQp34SnYPOTAi9b62MAcXKlwlsbLYCDAfTeqNjuekr8i9mrYfA5dBbp5LLVpoRQMx1xNcy9DwSkXbenNqLyLGw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QbbGzrQZ5JSJ7X83ABmACDNqn1iU0K2oZPsz07NoTtDSljhUiEFmIwXBTFUyZOFGGcx7mO3n4Zo7XrTRU+lqIlvfJ1V9pO7AZ0YRYX7nxNU3INSbxKf60Co6P31kZdTu1ph4IVSsJYYGzmArwJeDttb9EI1KOGyWibDx1L2BYFfN3LYFGNPYF5IW7irE4DnepxumWNdRhirmkRyqLyIIW6FzgurBdQCzMNlMrOTs8SjTXtEIGvQ+UcOnK4OOjaKf31Tl7aCK5Uok/zi+boIIw3kUk1PEOirY39yux0dS/XJQBrb9pZFGJ/C0UWkSdKqMpnyszEWE2K83pTOA+P+RPKX11ozYdntDamf3+Z/EmQThzMTOuT7Xa70C7nAvf0B0qBZLXnKJxDcrPoH/YDhUz7GObuwgbecVspBWbNPYKD95QEroH+4UvxrihDfVNqSEnzKvKj9GXFXVCaRENua6H+/vynaXc0QI6v6XmdZi8pdNuz12qjm/iK4WK7OtCCA1UlaP1oEwtrzp5gmJ7MciL9m5MKpiFgBqGC/B14LrY/khlQUkYq446lbnJjNM3NVR9L/PWIrrnKLWDmdvtnbG3ZgX2nx51n0dtJ36mH1GbRo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e734d2-98b4-4a48-ca6d-08de8b640f7a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 18:18:20.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VamO2gy8Cl7ruwBhmJJduKTKfJkpI53vDd1aM/PlkM32yk2fqcUbYqWwMpjenqUO+iCL4ADd57FhWuD0iIbvpOuMonvuLpa5lE65RNlutQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603260131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzMSBTYWx0ZWRfXwqdBZIR6wc9Z
 RhDjNuOichvrJsm7UviihLFYKhuSW7fU3lRC3KrKUcdH71rGKtV1wW1tsik1sju0oXlF45NyOBg
 XWuS68wttP2DU34c04iHI6L5rz9+WgVcSWC8xx8dcjm8awPxCKu5ZD/+6dVaMA+cXv9USOg6Va0
 T6MW/FdlVnGNLeNgmUBMveqmnwePhvCQHN3uY9Srvs7/Nrc99QXndxLBYVt4Dr5gUldfxsvcA9Z
 WJBMv4XrkP821/CXAzqxBl7Tv3nXNRe+bSWqrmpDz/SHGEqHSN87OwSpvDTp/Zzm8/2esmC5cH/
 qNS2Atn7DByRnOS3eV6SINjhuhOcFFzRKgAE1lPfBq/K275ip1OF2YjIDY1uRnpjBidpugE/3O9
 zIus6eu4J5DZMw06ePEDKTucHTkFqOQL3Ihq3MdVh/4LzgTwTnOOKO4zNFragdib8rZkbX0G0D0
 HmR7BJpEcqgct4x39WxEuBj2SQ0RR9KWmacR9Qlw=
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c57883 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=m_BcAVxTKpAc-Ej16NUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12276
X-Proofpoint-ORIG-GUID: iJQTfxlHm09JkxOIt_SGvkV-PgDjRYpQ
X-Proofpoint-GUID: iJQTfxlHm09JkxOIt_SGvkV-PgDjRYpQ



On 3/25/26 6:22 PM, Andrea Righi wrote:
> Hi Joe,
>
> On Tue, Mar 24, 2026 at 03:42:35PM -0400, Joseph Salisbury wrote:
>> The node-aware idle kfunc helpers validate per-node idle tracking, but they
>> don't check whether built-in idle tracking itself is enabled.
>>
>> As a result, when ops.update_idle() disables built-in idle tracking, the
>> node helpers can still read per-node idle masks and attempt idle CPU
>> selection.  This violates the documented behavior and can expose stale
>> idle state to BPF schedulers.
>>
>> Fix this by checking check_builtin_idle_enabled() in the node mask getters
>> and in scx_bpf_pick_idle_cpu_node(), matching the behavior of the non-node
>> helpers.
>>
>> scx_bpf_pick_any_cpu_node() is different by: when built-in idle
>> tracking is disabled, it should skip idle selection and fall back directly
>> to the any-CPU path.  Make it do so and match scx_bpf_pick_any_cpu().
>>
>> Fixes: 01059219b0cf ("sched_ext: idle: Introduce node-aware idle cpu kfunc helpers")
>> Cc: stable@vger.kernel.org # v6.15+
>> Assisted-by: Codex:GPT-5
>> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> We are already validating this at load time, see validate_ops():
> ...
>         /*
>           * SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in CPU idle
>           * selection policy to be enabled.
>           */
>          if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
>              (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))) {
>                  scx_error(sch, "SCX_OPS_BUILTIN_IDLE_PER_NODE requires CPU idle selection enabled");
>                  return -EINVAL;
>          }
> ...
>
> In practice you can't have SCX_OPS_BUILTIN_IDLE_PER_NODE set without
> built-in idle enabled if a scheduler is running and we are checking for
> SCX_OPS_BUILTIN_IDLE_PER_NODE in validate_node(). So I think these extra
> checks are not needed.
>
> Thanks,
> -Andrea

Hi Andrea,

Thanks for the review.  I missed the validate_ops() check and focused on 
the helper-side behavior.

SCX_OPS_BUILTIN_IDLE_PER_NODE is rejected when ops.update_idle() 
disables built-in idle unless SCX_OPS_KEEP_BUILTIN_IDLE is set, so the 
state I was trying to guard is not reachable for a running scheduler.  
That makes the added checks unnecessary.

I thought scx_bpf_pick_any_cpu_node() should mirror 
scx_bpf_pick_any_cpu() and fall back when built-in idle is disabled.  
However, that only makes sense for the non-node helper, where built-in 
idle disabled is a valid configuration. For the per-node case, 
validate_ops() rejects that combination, so there is no runtime case to 
handle.

While looking at this, I noticed the comment above 
scx_bpf_pick_any_cpu_node() still describes that unreachable 
built-in-idle-disabled fallback case (Line 1364 in ext_idle.c in 
mainline).  I can create a comment-only cleanup to align the comment 
with the current behavior.  Do you think that is worth sending? Maybe 
something like this:


- * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE 
is not
- * set, this function can't tell which CPUs are idle and will always 
pick any
- * CPU.
+ * %SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in idle tracking, so
+ * this helper always attempts node-aware idle selection before falling
+ * back to picking any CPU.


Thanks for the explanation, and sorry for the noise.

Thanks,

Joe

>
>> ---
>>   kernel/sched/ext_idle.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
>> index ba298ac3ce6c..948f6b4f8ab5 100644
>> --- a/kernel/sched/ext_idle.c
>> +++ b/kernel/sched/ext_idle.c
>> @@ -1082,6 +1082,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
>>   	if (node < 0)
>>   		return cpu_none_mask;
>>   
>> +	if (!check_builtin_idle_enabled(sch))
>> +		return cpu_none_mask;
>> +
>>   	return idle_cpumask(node)->cpu;
>>   }
>>   
>> @@ -1137,6 +1140,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
>>   	if (node < 0)
>>   		return cpu_none_mask;
>>   
>> +	if (!check_builtin_idle_enabled(sch))
>> +		return cpu_none_mask;
>> +
>>   	if (sched_smt_active())
>>   		return idle_cpumask(node)->smt;
>>   	else
>> @@ -1253,6 +1259,9 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
>>   	if (node < 0)
>>   		return node;
>>   
>> +	if (!check_builtin_idle_enabled(sch))
>> +		return -EBUSY;
>> +
>>   	return scx_pick_idle_cpu(cpus_allowed, node, flags);
>>   }
>>   
>> @@ -1337,9 +1346,11 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
>>   	if (node < 0)
>>   		return node;
>>   
>> -	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
>> -	if (cpu >= 0)
>> -		return cpu;
>> +	if (static_branch_likely(&scx_builtin_idle_enabled)) {
>> +		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
>> +		if (cpu >= 0)
>> +			return cpu;
>> +	}
>>   
>>   	if (flags & SCX_PICK_IDLE_IN_NODE)
>>   		cpu = cpumask_any_and_distribute(cpumask_of_node(node), cpus_allowed);
>> -- 
>> 2.47.3
>>

