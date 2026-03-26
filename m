Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EA3A16A2
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549223; cv=fail; b=KiswOjO5eN73oSbu86PVV4Y//o9mZ7kMZm3E14fgENlTrCc3Beg+VSD36eBvWW60qaWKrD7rtbN/fk0nVWZZlAH1XMIsw5aDuIvorCuZswnNuXuHC/eWqwKnbL5zDhCL/BTJWzd0TLjv0uOmldfJr4MXl4acpvop64DJpOQbfyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549223; c=relaxed/simple;
	bh=Jc/r+pk55kJMm15HWORYyLR7CuYlRa8hufCS6cndDhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMBwPv8sWI8sKiJIrCiGOgzQZQiZ49AENgAv0n+wpWINYBXLdtWEia4xnbjK8Az/du+L+lg0jfVtnXh+GM6JxlvUo/3oNlKXsa/WLvdv2OPKW5qHHh6uASCglSzlxnSA1FpaX1kJXkQeMqZVBs5EJhf+6HY5q0SFDtvxMnSZw5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U1vlKYzD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qilt0l2X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U1vlKYzD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qilt0l2X"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFu2Df1059549;
	Thu, 26 Mar 2026 18:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fdysh/nQaMwRA6hFpzwllY1x/jPiuKGiFoUeyHwrT+E=; b=
	U1vlKYzDG0VTWha6hbVPwsRzLVEpX9HQq5yua/OFvWmGE2u18V9BLfwAVqH5UOYz
	xaZteAWbXb9JgKixXTU9YuxjqnPnv9nDdiamOqLQFrZSCdsB1rNiX8yznJrrN+gp
	DXVqYmzKJNRJfrvJ33KhSGOZVP079ToS25jdoj5VGwwgYEqtd7SHoTmwzxZCxhp1
	+57H+KTPI/10FZ8FIjOwO5ga9Hyyr6aYB/MarS5vh78rnF0+CLJUa+5mpZ2wd3Ew
	HkHVyiNPj03tK/Kz0/q8M1B8wFYeokwxqHCGitCE1OzO5PXANxH2aH3NXFHbTEi1
	U/T0Ikc1Uuyg0o5ZMgvs6w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvnrwku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 18:19:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QHnDuB028864;
	Thu, 26 Mar 2026 18:19:52 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsdbuh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 18:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmPKIbaRelO1IkdS+uCp7OJgUj/vaZDfjxf4K9cTGMjLorEcUNUjqpYa0jAlFnSfSLF54uI6Lw722CUvcjxnOFQ/eYcTSZAAFrIpfuWer2ZmMqtzmbaEnzh/5uH3s8nBsek421W6/KLWIAR9QHUlAQ6SO5vs3iqiTvcbcWw9BZofxcIA1csbWjxsRehPMzrfkPkCAcUiyFsEJaq5mfPAHSWsmTfZFuZJKpLoEt2ksC0x4Iu1nTGNOMc6vHRGmI+H/DizyYir4qfzGCQVuZooJOjRU4PB5Jjd4Q92rpWtQ36r+vHlZlTM0SUrcGsFUyuUbNb2jtUvWdFd6NtkUkDwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdysh/nQaMwRA6hFpzwllY1x/jPiuKGiFoUeyHwrT+E=;
 b=g1lMYpE6tnxAzuHjpcZo8hhqTZij5AVGBWvdOjmj56pqrju3S7ysT8ZIXo6e3P71EkPtscorhq/siNupMvZr1fbwBNzUpjRBF3tWeW57mrImKFwzgMa0N26h9cxPnQhrbCuONXTxgByw25O3AgxMDi8O5RKPdf0AcHePGBwYCiGEevxsQnhs5dbH0K4o4kE4DEnEDfQsE0AOnAxiOeEfKRxUhdWuPYPCOJ2TQwhhHkZuj50pYM768/uCu40AHJoKpOOVvj5l2i3Ku2ZI28w8PyYlj3JYcAPo55DBHRQEVjNdkWXgMCJtwU+Px8bIbWRh7K4IgpB0eawTesb9u5bulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdysh/nQaMwRA6hFpzwllY1x/jPiuKGiFoUeyHwrT+E=;
 b=qilt0l2XcXwePfrhuAjGkwRtcj5WQdrprRxJU4wFVDa7swB4dlOkZCW5kbPR0Hs+qSuWL0RzDYZBLmtibyxzArVYCKeyNHhRsEigck5nzbTwUUabqCiJ/8w58LafI07lqw24IAnWqJJ7x9bKG9oVUub9WO38sGTppfKDH8Q+/pI=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by LV8PR10MB7773.namprd10.prod.outlook.com (2603:10b6:408:1e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 18:19:45 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 18:19:44 +0000
Message-ID: <5601bd76-61b4-4544-94c8-b93dc9d27349@oracle.com>
Date: Thu, 26 Mar 2026 14:19:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH] sched_ext: idle: use active idle domain
 in WAKE_SYNC check
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
References: <20260324195836.949831-1-joseph.salisbury@oracle.com>
 <acRusibUxjWj3WCW@gpd4>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <acRusibUxjWj3WCW@gpd4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::34) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|LV8PR10MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ea8eba-ef0a-4dd2-6dfd-08de8b644184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9kfma50tXgzO92n4YZwAEBDd+GaNFLb1ZG18sYZpQQvcsqtk3KRNzgtoyyXaSl0qa5kOwV/WILdsKBgaI06UnTWL9+cQgigDYErfR4PAT7YsShg6nXmIBSVyjXhbhtyZy8seXfriKGrRqtqus2WsSzwD6Ou9ktoEqpj9ett4whFaAi9KVdfYEoJUM134K3blGmIKg33J5IyxXm8twV33rdCJpFnJmL2PeiFHcc88ggfk66eaDOEn0OL3TBTa7bN0bM/Kh/veGTmoV9Yd/eSqBkSUSb66B5KoM4ipjNPZrsKmDBgGAwmhsCHKA8hY8tVN51j8mkyTyq+Fxjooxf/kdua3UU+LzpRP91K57bP8IU0xKqCcXSKdjXT742RkyhBtBFfZuUlBvBr9nTWS3FCJlfXvqCKpx/vKtv36h+dug3yCF8eqakXsi5lSJtESzPo/FuLNPgAsbb//vmJN1fC39naDJb722Iew37UxnoQunAuyeOAgZXZ5JjFRzsDvwGOqyKwy/9AgxGLKOm8eO/puzHt56rmONttbL3mlO6040Rc/dcPSstdmdBEjsmRVyae+73hr4jZ0fY89d+dl1+kwZP3V1nsYUIlu5ybvfWSWtEiXw8ZQU9Cls0U1juMIRUIPS+6Piq6xIwrNemYv2biPe5+eiDKdLCUf+GaNaQWupmGiBBfVuNrpts/ATKF4TeYC0NiTuZCnnWCD6LDaE2/qOTI44uXd62h8RtXgNAuRCCVz3oM7ZFtOfCHjhszm+Gyr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sjl2QlJPSFgvR2VxR1RBMjQwb2ZXMWxUeEl0eVlLTGNBcjhaK0tBU0h6ODBx?=
 =?utf-8?B?dFhDN001UVdvemZ1eWhVaW5BMmRwTzdCSEJkTlVraHRWTkU1K0R4Mjg0cjA2?=
 =?utf-8?B?MzI4dWRzZ1BSYVZNTEZhcTBmd2h6ZUIzMHIwcHo1aFZwWjVkR05Yc0RyQWR2?=
 =?utf-8?B?bGhiNEpkUG9NRWZsZ1EvR0EyQzNTcW5adjVDbEJQQ0NWMkpKeVY5WkpYTmhP?=
 =?utf-8?B?VjZiMlJVM2ZCQ01NakpyTnVPK2pTWlhJK0lmUkJjSXJ2ZzZHNER5ajNwNHZD?=
 =?utf-8?B?M0t0VVF5K0Yyc01BbG85YzdjRVlYdVI4TEdSeE8wcDNvQVI2am9wQTlOa2N1?=
 =?utf-8?B?NEg1eXZkMEhWNzI0bFQyQXRaK1kzeHAzMENCVXQ4TVVsMndFZmR6R0RZZ3pL?=
 =?utf-8?B?WnlTTHVYWmFuNFhEM09GR3U4L09lejRUTEVvV3A4MUczMUF1VVcyeXZLVk5E?=
 =?utf-8?B?MXR4M2xBUjVyRzFzdTNYeHR4SzVPYUY5TW9lV2l2aGdyT2pmWm1DbkFiS0do?=
 =?utf-8?B?QzBNUVkxME9lUnFsY0ZPQlROZUZPdUg3VDNHcGErMERpM0Q2c2FmanlYQ3BE?=
 =?utf-8?B?ME1JSGY3WlhVMzdGcGVZWlZxc056RVp5bEdBWTRCbFYxUjVjYUJ5T1ZtQTNk?=
 =?utf-8?B?TVhXYUwra0xDZ0syM1dIWlp2WHlMZG1pQk1kTThnZ2haWTZuaHlodW1ZN0hL?=
 =?utf-8?B?NFBBbFh1NGkvRXJGWnR6WUVESFk2S3JRcmdlZ2R4S1RUOUxMbnhBdzhKWlhR?=
 =?utf-8?B?bzlRWEs0SVAwMnhqQTJPWjFQckVvaFNaUjl4blRBYVBzcjgvSExQbzlvT0Vu?=
 =?utf-8?B?bUpmZlBJaS9zNkxGOVNMd2kyTlR6RkhoY1RYUzQ4eU9JTmpHbERiNUl0aVNn?=
 =?utf-8?B?cEZqS3ZEMlZOcHdoMm45amF5MEV5aktObnFmTU9MdG1tNElpMUszYmVvRFpr?=
 =?utf-8?B?MzZVcno4c0d2c3VPUGZabk9mcndJZDBYWHpWRk1tREMxN201MDR2M1hjYndZ?=
 =?utf-8?B?aXJTSjlsaUVlbE1ZYTRKZkxjejlvajdIOXFYR0l0Z3orZ0YzVnVHR1U1aDJD?=
 =?utf-8?B?OUFlV1J2Z3dUYnJITHBaSzYzRkZGYjBUaVdYMjRIT1BnZ2g2TkFXRGY2Z3RB?=
 =?utf-8?B?UUU2aDFvYUM4aXdWWHJJSC9NcEtYNHhKMnM4NzJYRVhqblRBa2JuaFBma2tT?=
 =?utf-8?B?TW56clhwTnlCMy9XdVdqNitpMktsenBaUERPRmtnNk1kMzM0MVpGSVJqS2ky?=
 =?utf-8?B?N0Vrb01TWWh2ZXFBR2d5Sms4YVpMVVkxNnQxcGdGcVVjRkdHMnI2a3VsNFl3?=
 =?utf-8?B?NjFzN0g1ZmZ6TGVRK24vbnFGYis0dStGRlpHWWhBeGVWa0J6NVZuVnJIelFP?=
 =?utf-8?B?eWk1dm81aGJHd1VZdStWZC8wNDkxb0w0aWRUTjlKNm5qcjNBZUdMNTlOMm5p?=
 =?utf-8?B?ZE52REwxS29VY1QzcUd0SXhxR0xXenR3dGhKSmEzbjBXV2Fvc1pLRHlFNHNr?=
 =?utf-8?B?bUdtTTErSGc4TDljMnMyUUZxWFpQNzNtQWpkbFJLVzhNWnJVSDR4RzduRGsy?=
 =?utf-8?B?aVR0RmZCL05nRWxIQXRkOGhrWm9JVDBnbitKL2NrdXV1RDFKRDZzNmlUNi9M?=
 =?utf-8?B?aWxJUTFOTzVHNmFGWVBENVRERWhJYUFmT0NMVTdXMS84ZGJxbUNCZXMzTXY1?=
 =?utf-8?B?bzF2QVprRllhVDVHOFFaSlZpY1Uxb1pDeWlkNXpmbjVJK245T2pmWTRadERs?=
 =?utf-8?B?MGZMQ0dCZnhmWkFhZEs5ZU9XWEcza3g0R0dwVFBEUEdjcU9YRVFpZkhDLzVk?=
 =?utf-8?B?YmJhQlFmSkE3K3RzemlQYlFMSERBOW5ZWU9qd3JSeWcxQk9KRERTMjlHZlND?=
 =?utf-8?B?WnNLd0JXbmUveWR3QmlKSVIyNUF0Zm03Q2VpLythTXNyTTRRcnlYa0FueHh3?=
 =?utf-8?B?NzdXWGdwY3VGRlNlbTArbEZiWWQzaGNveHJFNGcwYU1wNHF2MlJ2am4xdUNY?=
 =?utf-8?B?NTNmdG5sSStXUHZZRU1kS3hIejRKNkNycTM0R291WTB2Z3p0RFlEY3MvTkxl?=
 =?utf-8?B?RHhtcTlWT2hBV3crRnpjOWE0SHZmeFBWT3BBSUgyUHRTNE1LZnIwNXdLeVdk?=
 =?utf-8?B?S3JZT2hhUjhaU0wzdWVXblRLSitXSWY2UTFOWm1uRHFic3F1WWRtT1FqRjhp?=
 =?utf-8?B?WVlTV2tWczk5UW90UUZjK0VxbHB0WnJZNE5lWW5Jbm9wak56b3hxaUQycU9B?=
 =?utf-8?B?QmRVQ1RPYURPeUxoOG5LT25aOWMxOTU5T0dXR3ZzTTlFTmQzVlplOE9aZ3pZ?=
 =?utf-8?B?ZnordXU2bGdTZW5pRGE2SFl6eGFhLzgyazVRa0U2WEMyV2d1ck9EZks4ZnBF?=
 =?utf-8?Q?IWU7lBU0ADArL1V4=3D?=
X-Exchange-RoutingPolicyChecked:
	fNGiKmmzqwYPRGhqfYoHGRo0aZGWV/iU4xITsBFWGCg0oqzATwsk7WLAOCeMyTrAGhRqGvlOfQPp6gHz5uFXMvRC1nSP1yA7/Qj0McvQQ44Xan/7oGDd3WAwuTmwEXoyQs1wn25ZJ8EFqsGAVGen2PYBLCdtoUP5r/agTf6L04QQmy4+SO+Ak2U4cGvzb2LNnP+ug6M1cgOYoWZPz1x2XQQmnnh0+YFK4B507s2YTDKGevhlWPvgzzOoqmoQ/xTJPgZoh3kHezj6yNk5plg6syeBqlBadMaCtk1rPmFrby6pJyAz37618KDfJ2W4iz1U5+rCxI4SxXWpBinEz7kPlQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qh5vHYlVaN/wiE6lXGd7dmRsOFmgoIk9RtuIV393keNxjJdfnztNozNBIOjoEeqerHvctUjBTozTcadc8IaB+VOhpKZmj4RKnccG2Ja8vuyxXIXNX5/dJucvZwKK7eBOXfrLLx2eHo5OEOQGnQvyZbU6I4LUKgBCJt8LgVg1piFKCY+0D/QRZjNMw5k5fVQfJNFN0NhispCzHkLx+EUxP7HJBAiQOyo9OeB70+sb0wESUiHA3nyb1sECMpfA5k02nXbXPfD6R5HL2gDgvQY2StyGVyibJR9PjO89BP7Z5Rpp0Mkf8wMrKSz6IFRle9dEFydV6Glmf6RwtrIOBXy1IsBCD9zLOnbxgrhtFiRJBj+WNU3+2WgF/SThvv+1cAi7G3nITNz3e2oUYyPm4w38lp5kQXvJAkSUlBkaM4/baJFCBpsJHdEw/HxE75JAwzja7RYBwEL85lh1NaZ/P/ss5pGdqra2A4DjyDb8e6YfJA3HvZz11a8uRcOIaEYYs03LPa6FdV1iFxDxjr1M5s1OM3cqNY/VGz8Lx/+fMhfGV/xSIGub99uSQUPktC5xzFOXZLLZf+wK8iBJfkhnEK9PXhGKCHEGNOQJVMi0uDgNEWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ea8eba-ef0a-4dd2-6dfd-08de8b644184
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 18:19:44.6998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RoCn9qNRysa6DVWxb+k79ZV5JoC4nc03B8kyU+uuCzhMUAcoNSdkaNv0xuFLBgrdxELf8NPABqOqDrXeRBwAYPRpSjTGBFTILjm3GsFZXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603260131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzMSBTYWx0ZWRfXww8Vk0bXSe9N
 AmpqYjjZwc+mVKURHmBjufNOrJ4VM4Jq4YOOC6GXIazw0eMabIlOfamYQq/k7jo0+6lv9QD8028
 Eo6EWAxNKmWpOLXgyLsKPRsJs2lBzXC33GMC75VpFpd1A7H0OWYVs8U0QzeBwKXQvi5x0ITUUE6
 wbtFEnukdMXBRuXgY44uhAbeXRvMwaMK5sTAnGGxU8DzeqXxveZZp2ngOOUVCTC0T9xawUf1L+G
 WQd/C8NFVA68gesGRttLxOtnJiZQ7lzll4cbL4g+BjvxHeG1JmFAzozVPDy3QrdYj6YirY7kh/X
 p24ghrTwN7iQ+BOlvKrbgr849pxps5G8w53r4LqoxN/wx0uZobT+piW84wJ6KHDuj3NBrhVkrM5
 PeCwUk+O3R36dtef2C469evNAW5/5uS4JgvX1AhB751DxfsZMdai6XPtjK1PjkiYdvQ3yNzAoPG
 W63t00Vz9xHYv2EWo3g==
X-Proofpoint-GUID: aGbwo47g4eK_lp1ZJ4uXhSuJF-Db6Rkl
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69c578c8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=xB9KACg4fIcRMLFjwBsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aGbwo47g4eK_lp1ZJ4uXhSuJF-Db6Rkl



On 3/25/26 7:24 PM, Andrea Righi wrote:
> Hi Joe,
>
> On Tue, Mar 24, 2026 at 03:58:36PM -0400, Joseph Salisbury wrote:
>> The WAKE_SYNC fast path checks whether there are idle CPUs before
>> biasing wakeups to the waker CPU.  After per-node idle masks were
>> introduced, this path started indexing idle_cpumask() with
>> cpu_to_node().
>>
>> When per-node idle tracking is disabled, per-node masks are not kept in
>> sync and may be stale.  Reading them here can mis-detect system
>> utilization and lead to incorrect WAKE_SYNC wakeup placement.
>>
>> Use scx_cpu_node_if_enabled() for the waker node lookup so this check
>> uses the global idle mask when per-node tracking is disabled and the
>> per-node mask only when that mode is enabled.
>>
>> Fixes: 48849271e661 ("sched_ext: idle: Per-node idle cpumasks")
>> Cc: stable@vger.kernel.org # v6.15+
>> Assisted-by: Codex:GPT-5
>> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> This is good, but it's already fixed:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20260321105503.869337-1-yphbchou0911@gmail.com__;!!ACWV5N9M2RV99hQ!M88Tr7SYG3FHedTvBFVj_5kAPCVI-WVHWNdHhvaysPHoUD3qbj9bZ8kNj8TwcjHXNvVTnhx0BvGh7pM5R6fC$
>
> You can probably use Tejun's branch to search for new issues/bugs:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
Thanks for the pointer!  I'll review this branch prior to sending/fixing 
any more bugs.
>
> Thanks,
> -Andrea
>
>> ---
>>   kernel/sched/ext_idle.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
>> index 8cfe0e9a7319..6b4520ed563d 100644
>> --- a/kernel/sched/ext_idle.c
>> +++ b/kernel/sched/ext_idle.c
>> @@ -543,7 +543,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>>   		 * piled up on it even if there is an idle core elsewhere on
>>   		 * the system.
>>   		 */
>> -		waker_node = cpu_to_node(cpu);
>> +		waker_node = scx_cpu_node_if_enabled(cpu);
>>   		if (!(current->flags & PF_EXITING) &&
>>   		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
>>   		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
>> -- 
>> 2.47.3

