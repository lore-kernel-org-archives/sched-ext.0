Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1122E8B83
	for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771640837; cv=fail; b=kX5KWOWyNXoX56MlNuq64Y0wDhu/pFb9IOJ8aX6Gtu4DVr6bQM2PWwjMPz5VPKpEkHhDuK8J/vwmTtDbG8B7wEakmAHh/6YhbeEeTQHhsty8kjj1d2Nj6B7AfpKraIfxuq9ZM3XjEDlBYnX0wdcmUVJWXZ88yqz384clCWpR4d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771640837; c=relaxed/simple;
	bh=yfaD0FfFXHBZhTZDg0kEbdfQXvagwa0yNXN7h3MZlGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5Ou38QilmyoQW3hfPNNT52KhYGfPs7EyCVE8sVlPyTy4ZpwF6nVI1+nbjWJ7mEZatbmFzbYrZbxmot+hMI/y3RVMDaQQHSqkGDHXPOs1+KYmShBxa4/21lTqZISA8VBt+7e3MUQAJifG+YAkJ8/xQtMICsACTToVm4GPgFf+0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lZDnZ5ig; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TEsb03Ts; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZDnZ5ig";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TEsb03Ts"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61L2DLV0403718;
	Sat, 21 Feb 2026 02:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IQZuAoLPCjOvr4HuhE3YLc/Dz4uckUmkxefEKtcqTHo=; b=
	lZDnZ5igm1osSmoW7/rkFNETNEMDOABDtHPjhY9jcf2RWuUd7mj0Ag55id7FyI+b
	eLT2bvl6jEIx++PhLk3HJ7q1NoRoY/GUknswa6cB5HG3Z/T9R31kw/OsnLOY7Rig
	lBnTQhk3+G/6KWSZ/yi9vJjNokfLiZpNG7UxCDD9SybqkYGp05+UoC+E/bRZHW/h
	6kP/+ApN49OS4HiqRcSpEdWw/Y+oTt1Wgrz4dPO3R/42zO2wQvh8ajzrIpX7vVLw
	GKSiGB/mN314i5Z6ozxZa6YZd8hTvT06dYMGh77P82xPTNSqFAnrVnkqTToyRBN1
	nEBGeJcGiMf7fI952IwcHw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3g3g0b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Feb 2026 02:26:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61L1XdtP015533;
	Sat, 21 Feb 2026 02:26:56 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf356rs6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Feb 2026 02:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXWNgXur8LDNCzMNkWe7pRHALGrTVHjoEFmDoaF8DBlsLa/WXktIAg9a20HNVAhkojNceopz0qVvc+wn8gVQEwZALwuX7I2M/lIiSUWMvo+o0h4VVRYSfJx5d0Qub3dycWyascSYHFdW1tbzzsEvwk4wHl/24TlVVtm+6+AfiHJmWKanO7iv0pfbB6uOR8RUJkje8oSnc/N4+EWPjsis1d8Ynoz7v4Lz0Avn89gUTNFniQ4ZxdFQWpAvOPaSe+fEt5ByamZOjdN0T2gcaOYMQlWOBLvK1gbENwxWE6s5JX7JkftpcP1VP9zyhFCHifD/pet/ULT0HotdHf0gyVOjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQZuAoLPCjOvr4HuhE3YLc/Dz4uckUmkxefEKtcqTHo=;
 b=I9Y434UtV6+Wy2TV53bR65z2Jds6YgR+WzZ5oitB8heAcC05dkj8EhbioKUFc7bIHK+ONusMYaWXPZeffRRW3CTsk9OFLFNSxjQeWKihc1MntaOCnhDfg1RBcOor7+1xSZSk4xZ0R1mniNDsN/1R1dhKj2xI0D7kWn2A7DqlOYlz0lFdMpqC5h2JMINuuXh0Ub2skdc+iNbYtE+lqleUvp/byo+Nn4kM3dv6zvjo+qWOREEM3bdVNCaJ1ubg100rnyJjuyFtgC17QRrd0UtJ82Kam1wDIkKFmgrcWtshIWMRfu/ps+GzhGI7AV6OuE9eqWpKN6oxLNOWJ9oqYXL0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQZuAoLPCjOvr4HuhE3YLc/Dz4uckUmkxefEKtcqTHo=;
 b=TEsb03TspuJagIVUVhW5Wo8ppgHye4j7ScTOnzO5emBTtfaEpu5+1oMjvEWn/tf03Z8CosJBZq4SPjo7HiO9T2+vDKqgmcxx1KYew84BLlRO+SjR9gITOoPbztkGpe3shKBVTOAdeQ7eUFEY7XfWQfqtPXmbzGEndblcyaEMEjw=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by LV8PR10MB7799.namprd10.prod.outlook.com (2603:10b6:408:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sat, 21 Feb
 2026 02:26:53 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::854c:c282:c889:45a2%4]) with mapi id 15.20.9632.010; Sat, 21 Feb 2026
 02:26:53 +0000
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: arighi@nvidia.com
Cc: changwoo@igalia.com, christian.loehle@arm.com, emil@etsalapatis.com,
        hodgesd@meta.com, jpiecuch@google.com, linux-kernel@vger.kernel.org,
        sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
        daniel.m.jordan@oracle.com
Subject: Re: [PATCH 4/4] selftests/sched_ext: Add test to validate ops.dequeue() semantics
Date: Fri, 20 Feb 2026 21:26:51 -0500
Message-ID: <20260221022651.59391-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218083703.22785-5-arighi@nvidia.com>
References: <20260218083703.22785-5-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0069.namprd02.prod.outlook.com
 (2603:10b6:207:3d::46) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|LV8PR10MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddb2796-1fa4-46d0-b651-08de70f0ad2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLYMSUvln3yEkVqj6WY8rG5Q0G4Dpctc0rYcaX6snZcGhLxGMqwDSDBC+Ez0?=
 =?us-ascii?Q?t39B9+MKat9OHPcZLFLqZMrPoA4g103St04Onm4WBAdF2ddE0I6prxPiDIRE?=
 =?us-ascii?Q?RaonMvMrujwPRLUCYcg0etn9/RCHR+cBRr2ztwzzNZPptAOY0+j1nr3k1WEO?=
 =?us-ascii?Q?zWYPemQ0wqganjOLIRX6WUZ7xiGM9F8pfXusunpyxtRK27Ac8ESgu+8H3wKC?=
 =?us-ascii?Q?Vf4v4eiNwfRBaIyoY7gXkh1SbhgH9pw4Esew+iCg/oJJ6stYOxbkQm4pwh6S?=
 =?us-ascii?Q?efrCqUy1uOpKD+YuFJWcMhEpMkZJgcLp80lUB+QgQiOnF1j+5NO4jUo3x8fS?=
 =?us-ascii?Q?tNKlCnkBJv//YDgVZY2LS7aa/9xa+D87xnVIiadAaU1NvSHExO8dd/iuh7xv?=
 =?us-ascii?Q?zq0tS1dP04qFnazc1MMCEJ/81Zlz+YL/h3nBRp+QxATwOQ2j7eXjOTy8DpXV?=
 =?us-ascii?Q?6jnzN8STcDlf/6byvSUyyfdEhS36Opn77v1TPXwaSa7AUptol5HK1Da7bnyP?=
 =?us-ascii?Q?rDBvB6n3/Xi9vAZv4XPiAZua+SD3geM5lK3iwRZ1F1vUOU0qpBxqbFMqOszM?=
 =?us-ascii?Q?ztln5yQLZ3STjKbtP5tqcvR2arTqjgksIEC9oxWMKjrkFzHRK4KpmTeRo/Zq?=
 =?us-ascii?Q?uLUKVd8mSsy3B+EpmundOrE8xjGrvmXIViq58iKY52nNPmnR4P8vhXbGHzSO?=
 =?us-ascii?Q?KXZSBn5pmYxmkhE+Pt06GtGv7WUXKj6vZpuX0F6FPTST9K/2atrix7bl8mZg?=
 =?us-ascii?Q?DXPjlwcTbeqiuPARh+xZADZDhawjNguVq5elVN4PXJ+YnF4FWdwvqP7hn5V4?=
 =?us-ascii?Q?g9KGYIEMwA0IOy7AexxxGplVgECrSlEdegfsso0Dg2Nkm2Q53JWD7HRJqG73?=
 =?us-ascii?Q?FoM0nuqIZM6abWJ3m91gxLaEGlujDIvK7nqQstgxXkHXaJ+1CLzNyDBqtWU1?=
 =?us-ascii?Q?QdWc+PAvM2GWTmxDwcjj9pqpBPIvnzWVYqqImNrRlWAdXWdl5CaBjM1/C48V?=
 =?us-ascii?Q?OfY/Pg66w7yCeFqs7fCN/zOw+/VmWI41y70LT3MRsl/MZoGfB97nzY/dPAyv?=
 =?us-ascii?Q?S4S2HgY+zEse3uhQDj5HGe9qf2fKcGFNH3fP3JHYx4KSyd/AdZ+RAyDjk2Ea?=
 =?us-ascii?Q?LteeQUDkeeb4ep/U1jN8Kj1DYasBPcAzE1QKVZI66nC2QmYTVFMLrLtbNDzW?=
 =?us-ascii?Q?GNF8D8TSVACWAVd6wSYd+cmmfh4nJzVtg3f+3B8Z9gl8FUeccsbFs29jHBpn?=
 =?us-ascii?Q?bkzPohHpOr6Gd5iwvQCQebfUxRdoEl8SUx62GKe9Z5EbtZ3xAvJ+ywC/23IR?=
 =?us-ascii?Q?iIZuNFi1aYVIUAuVnWjXyr0vIfcdDBd9bp0ZPl1EkkxVP23IBpvUJsiN5pXr?=
 =?us-ascii?Q?apyhdGakL6cRDwKTm2VpjF6e/7mv6mz9AfAjOXwh6uy8YtR5xQmRyLChUOtC?=
 =?us-ascii?Q?JwnDkLcfzxeVOGR04MWfbff0QrN4cbh/IJZHg/v/EPRbAJupuJN1j+VoNVtr?=
 =?us-ascii?Q?D0xz/FS9kXR51ci1V4dqNcUi4ytLFLkUMNIUbCPXei1tBT8SolyOjLMharuM?=
 =?us-ascii?Q?VvfBg3323Q/OK+HpzVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Wbe9e7vg0Qj7FuYqHHdIZ4si7LnplGE47BqstJtnuTfeZ3Nd9fNMNpHatFh?=
 =?us-ascii?Q?kOTwXat1SxwwJi1reXx1MoEph40X4sV3j+brAPOaI8dvdjC15yZr1Jw5utrO?=
 =?us-ascii?Q?HjmHshXyORV/h2GpTEqjGhE73YnVlTyK9ezsEtDnThPzosgijBm8q9mpYrnh?=
 =?us-ascii?Q?zwdEIuCQ5r4jl51Pj5QvfYybZCar4lUniFUmnUxbH12XvlKQkAW896RJlbe0?=
 =?us-ascii?Q?Z9MLebjExvlelJD3J3675f3f5Bh2vpew55Hokfx9cc5TFeduwzcpclc3JtOi?=
 =?us-ascii?Q?X1G+82rjnL+gNndvscsAEOcn8JL6sY9N5pQ69EAWDPt+myELVkncMgC9Al9j?=
 =?us-ascii?Q?RbE57oiagscph5aJoxTOUAlHLAA2+CbvDj1tg9XYjnVFljpGXgNWJOKnNeRq?=
 =?us-ascii?Q?OtIdhHSSBamsYwNQX/c3HfwGjEMTHIfGvan338j29AJvm5i4MJVImjylUPaV?=
 =?us-ascii?Q?Yt9CPv3nTI54Dy6zLqsqo2tXBkCu65vde1/dvH6vOKttHhDYwCPqxp9YqNvx?=
 =?us-ascii?Q?Ih7k0rSE35gayKxzlorOxHqf+PzNyDkPhQOnyNe9BhYxy09zG6r1QmXTyt0e?=
 =?us-ascii?Q?71CG/DHFDtRDBDcnspOWaACGVRfpGcoyRrPZOUGpf5GsqGGGhJ0N3KmfhkzD?=
 =?us-ascii?Q?ar1yTsNzbzFrbTcYt6iS1smmu5R/XwwCRQPsj2hok4lrxOpT5n/38TsAL5wl?=
 =?us-ascii?Q?m74A0jZrC9iwCrBo1tuPKD2NrQeV5t8wd5Tc5n+y+O32nPtqXDxJvYnV222W?=
 =?us-ascii?Q?gSHZiGRr+ECEuemeeGbiVUvGg3CkHd+v7dbG+7/hXzCRizXb5YTS1AygUzDU?=
 =?us-ascii?Q?ZeM0SEMiLnf8I2j7Krd1bzf5nuS6FyVNC8TmgB3pJOe4nDm0Pi0POM11dISP?=
 =?us-ascii?Q?PiWLfR/PRC/PG8J9XR3U4wKVsIWnRGrSeqbqVfBFYxFjQBrgXbTUPIxJFKWp?=
 =?us-ascii?Q?RHyUbo3na8llzTQZ3e2L48RFJ8KrVzrLpSVi0fLND3/Ym3U5SzlTIkuer4Jq?=
 =?us-ascii?Q?aCQ66+ZB3h8AoAUiN9luzMy85QT6W9QV8LXbNwqdUljQXFTnHj13LpvUkyjH?=
 =?us-ascii?Q?SJDPcSG+wHiayFc4B7tVvdoe6MEIx4KJyczDgWT33DoDPin0tOjTdq80IeSc?=
 =?us-ascii?Q?lftWAtL1zSzOiicXPzGGKWF+JUr4DDmfbKpgUPWkWGAVU9UyYXYi71us7Ih8?=
 =?us-ascii?Q?i8DZwmxzLybhqFYELhI3pfESYfoUJ1wDIDWXEq67pHxaqYzgDd2GLnKIJ6Pk?=
 =?us-ascii?Q?iLRwJNoDhX+4PzfvnlvWgC44P6Dvx0xREIYSRAXbXfVE/8+SXOvqMZ6pcOy/?=
 =?us-ascii?Q?bq1zXrw8EBly3QsIEcu3T6nKWt6X3zt5rMgVmsOhbAIQRz30gUAhyDoXHtsW?=
 =?us-ascii?Q?ZfRWcjKRe1F09fnOhO+dYKof5FSVxXKrjglTYMBtKrsk3TuFhtse/5sU5AhZ?=
 =?us-ascii?Q?0WXaccvmHNSzuSPx5qR7qT4wG+F8rxhDc6P6vrVPJcsgesPscsKSYKi5CGrU?=
 =?us-ascii?Q?A8E1UoyDa84slCFY2cMW69Z4T5l/JQjY2YNBlElFoE5CdMtfte0L8bib5LVf?=
 =?us-ascii?Q?4UKuq6BFit9dCe0d2Wl36YgKJcB9sE/MMc5jv/epW0C1F+T8uig02ClQeIsr?=
 =?us-ascii?Q?TnR7fdn429N3tf74K6p6dTECCvT1BvZ4n0WrlO53gohjtF4FstDww1MOnPwu?=
 =?us-ascii?Q?RB8jDQLvt7STh8Z4qlzzu1hkwI8O35WiHWo6vTXAk5ZqX4s0842vS2Z+yJoV?=
 =?us-ascii?Q?2pXnypzVuOSzprQeP76nPYA7g9aNVbg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YKddExxisCexKKuszzS6gxFfayNePdZdaurFVg1p5JnRNLpUxFd4w3EneWb2ZFqZZ/3Q9QSLP/t8/yROSyjud20rXgldghY1YySl380IS6hxhjONwkzXBK1Al+UMq5NDUu1p9zDSkJGfZiPBgY/szHv4M7cSkv+XiW2/6+eEMO4BwvxRbALYXgMJyCQ2V1P9T97qgPf0G+J5s7I0XQnQccq3CttJhbIGSkqSw1xKQA3iD1D1B8dyN/bmesf0RTv5svudvDgvKJ/8trZjZUNr/gYF5dqeeGTZ1Qz0GhQHDJazKqEqVJgewA6hPFMejAAzrD37S9RIYYJODyiqQZ6ydqIthneR30GB3MsC3e8JzHVZ1ycUWtXzxdmqmN7Wn+JkkS8OaR2yK6yBV7hi/lk5I4VsxDagKT93xusm0cw1fVkYtmeNT6v+wdKGVK1zlEFVMfCqCAoAy3u8XQZf83P2eKEZfCvnlNwdquQK+yFtH+OUCbAfNU0xng54hMQKcSZU2qle2uFnWBEkcHaAcI6liKLuo+hwNJxzO1gMHZvAmFEgaL3zBf6WbjelYj+B2fpLgJZjYfZgq1GFsRumk+MP3rGf2wGzGNs0PnyC8QyEnAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddb2796-1fa4-46d0-b651-08de70f0ad2e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 02:26:53.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6GWIStUg2IkhyciquMT07a+qWWGt6avQ+We8Y4KvDFJAKIrTB2OsFeb1ExnPE+CqIr6+KZkoN3d8gfhBRDpf4up3Ig92A/Y6BP3wMq5cVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602210023
X-Authority-Analysis: v=2.4 cv=Y6r1cxeN c=1 sm=1 tr=0 ts=699917f1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=lMN5HaJSj9HDdNWbQ8IA:9
X-Proofpoint-ORIG-GUID: j3gDQqisxwrBIM2YpYDxGO9TMJgY1bvG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDAyMyBTYWx0ZWRfXydKPRWF/joYL
 iiL+nmpJ+p4BaUbPVrTLP+ESggOiBUwzZcpdrjB6eSxx9F0/Yaem6iqvCvPPm4992ldtPJh/xTE
 szkw1k8Kcfc1Pz8t/Ks2gyIS44nUgry+y8kRZCWJ7bsi2xrp5eIhWtKb/Xb+SanZ+jZz24heoJm
 iwldv15u7aDvlnkMIPIhGEK0tFGqfvBmEYFhyu/2LuDIoqQlrP9d6urMWdQ5XFGaQH2n4LP7F1I
 hg1R1gtxv4ZQagV4Ljo92W2ciE/iq7otzLTOHtbmOgs9KRRNtlxlYHohmQEmbAAqDfEtreXdM73
 H0nHsFRZnMGJkWhf6bo3qAtx3lmsALVWsqYw/FspatiTcPIgSWN6pdjKxryCywXe0lHu0mMQfLW
 M4LNzjC6HvJAsezBhneW5sZFnpa08ZmXtY1SQ986uyhEem7FPY17bLB8svPld0yroqriMNfNxrq
 O8SSMGLiPGsCRm2wrqg==
X-Proofpoint-GUID: j3gDQqisxwrBIM2YpYDxGO9TMJgY1bvG

Hi Andrea,

Looks clean, runs fine.

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

All minor stuff, no need for a respin here in v10.

> diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> +/*
> + * Per-task state to track lifecycle and validate workflow semantics.
> + * State transitions:
> + *   NONE -> ENQUEUED (on enqueue)
> + *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
> + *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
> + *   ENQUEUED -> NONE (on property change dequeue before dispatch)

NONE -> DISPATCHED is a valid transition too.

> +void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	struct task_ctx *tctx;
> +	s32 pid = p->pid;
> +
> +	tctx = try_lookup_task_ctx(p);
> +	if (!tctx)
> +		return;
> +
> +	switch (test_scenario) {
> +	case 3:
> +		/*
> +		 * Direct dispatch to the local DSQ.
> +		 *
> +		 * Task bypasses BPF scheduler entirely: no enqueue
> +		 * tracking, no ops.dequeue() callbacks.
> +		 */
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);

Could do with

                tctx->state = TASK_DISPATCHED;

> +		break;
> +	case 4:
> +		/*
> +		 * Direct dispatch to the global DSQ.
> +		 *
> +		 * Task bypasses BPF scheduler entirely: no enqueue
> +		 * tracking, no ops.dequeue() callbacks.
> +		 */
> +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);

...and also here

                tctx->state = TASK_DISPATCHED;

to be consistent with how select_cpu sets this state, but I don't think setting
DISPATCHED has any effect in select_cpu or here.

> +void BPF_STRUCT_OPS(dequeue_dequeue, struct task_struct *p, u64 deq_flags)
...
> +	} else {
...
> +		/*
> +		 * Dispatch dequeue should not have %SCX_DEQ_SCHED_CHANGE
> +		 * flag.
> +		 */
> +		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
> +			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue seq=%llu",
> +				      p->pid, p->comm, tctx->enqueue_seq);

This 'if' can be deleted.
