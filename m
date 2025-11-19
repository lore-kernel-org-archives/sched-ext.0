Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49423817E
	for <sched-ext@lists.linux.dev>; Wed, 19 Nov 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566935; cv=fail; b=mMWqRsshgwSI7oNaX79hNvr5Rgu4BID0SdElIQqknoUaelosd/vLr9/xELN+lqAcD2CgAwVLCw9Mwe6e2CHptC9cNDUMKCISshT+O764Dc69Sz3pgJ8BRL7gWhfo+yAlm81VaxrpxrVRG3h+wqXLKZb5ZkbVA6o3AFNa/kBD9vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566935; c=relaxed/simple;
	bh=/C19lbhqGqIQ0hdR4/FhwiYqLH971hMBSonZJMBXBTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=blBcQwpbP5vAZBnvjytKObS9YYn8lWIPfooMGGXeq1bLCMxVilwLbvsF9AwrCdQDgri6itHZSnAAfMXHqnPy1jpLa5fnJ7H6Zx2d4bDSwN6Cay/FRtnokHXqyHLWh3EJ3mmHowIc5hy0EcBCniVa3Sv6PnWi7aJ4tlhJvnN1gn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DGjFUdJT; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DGjFUdJT"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJBuWvC2468246;
	Wed, 19 Nov 2025 07:41:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=/C19lbhqGqIQ0hdR4/FhwiYqLH971hMBSonZJMBXBTw=; b=DGjFUdJTlTbc
	JA9TR+6ImIs85S7atOZSwjgNDLSha/kb5y2vr5plk4xAZ4c/q/94SGv3Oyvr0EHX
	DEdlAh3Pe6M/VjXrOmV1Qkub7IWesWKEi0IOgWcwVFDppsbAB3fN6sj9TB9hJU2h
	odefTjZddqCDqXdJJInrphD4vYWv5d/R2RgN+fHshXWG653SLc40UuV9zHHd4Vyl
	Jt1LGMCmOtUsx6DB7FB8gCOfN+yDKnVe+QrIX6GLS2kD+h2QlNCgf9w9hXjlAfLL
	mtZcV6rcMcbsB0HGJXS24tPlizDYwpoz86D+gQQibhn577yKVmjmUFMwlV8LPKct
	bf/1BH3WBA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ahdf7sjey-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 07:41:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9ZZ/s3YY8Ou5BIMUCu8k6rU69zVErAdTP1mySO2YlITzZpZiw7DNfVcVLAZZOTmkRaPYxJV/Tm7wp3OBRJ8SpDZyFIvn6zBf3Ojv9VI+wuca9y14sAHFEyD/KX2ke6TfuXTpqP3sbmyqcw4EzAHwXGjFKLMr/HHjVsy1FZQnkLIjH4+vU5mdBTF32WBE8SzDVNLZ5WrXuyvYPnaxQD0rTGawbDsBVQISKP6AKEZ5hPJA/N+oQYc65BX0gkSPts6rsxmNIm771AOk5W2Ti5BeY25iuB+ZGdEWg3M8jG980Vq8rVsvNU2JhGZd4D41LcJgPjRK5kFMsrKdI/2YdwCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXLS2xtwmBWhDKvM4Kmi46H1bTpo1KjxeIBylpJQhgM=;
 b=xTr8VyMyfs+oK6qUK9ikI4ree+cCbcuP5Ostn3phX8ZQYbiQAvURKUjruF8o876hsGXJ9g1JSryPvImLGQapW+eStfwwbUx1I8m5uwGzViNgV34kiOJcp4fQqUzwEY43eVYbXU1Er0jHTWa3dgOq7/Sa5+XdTpyFJH0MISXwKKLigorbKpyZMUFXeU3VK26NEI0OjCWpV5HnDE1lrsDIwif5GQVkgh8WoO3J8Qv0WmOTpDbQysfULSYUjIHUJuyiOQ+zVeaJiCUlhaVeYabSSMWT6jIJTZKSSA7+MZrKlD2fCzCU8U1NQ/n+vD0AKEqRfnxtqb6RR4h+coIq+SO6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BL1PR15MB5314.namprd15.prod.outlook.com (2603:10b6:208:385::20)
 by SN7PR15MB5684.namprd15.prod.outlook.com (2603:10b6:806:345::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:41:33 +0000
Received: from BL1PR15MB5314.namprd15.prod.outlook.com
 ([fe80::6d4:d6ab:3e2:c21d]) by BL1PR15MB5314.namprd15.prod.outlook.com
 ([fe80::6d4:d6ab:3e2:c21d%6]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:41:32 +0000
From: Emil Tsalapatis <etsal@meta.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
        "samir@linux.ibm.com"
	<samir@linux.ibm.com>,
        "sachinpb@linux.ibm.com" <sachinpb@linux.ibm.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "arighi@nvidia.com" <arighi@nvidia.com>,
        "changwoo@igalia.com"
	<changwoo@igalia.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>
Subject: Re: [PATCH] sched_ext: Fix scx_enable() crash on helper kthread
 creation failure
Thread-Topic: [PATCH] sched_ext: Fix scx_enable() crash on helper kthread
 creation failure
Thread-Index: AQHcWUChmJ1dJJxyiUCmZl/luSgPBLT6ImDW
Date: Wed, 19 Nov 2025 15:41:32 +0000
Message-ID:
 <BL1PR15MB531422F04E2C750D2979FD22C7D7A@BL1PR15MB5314.namprd15.prod.outlook.com>
References: <20251119103722.309211-1-skb99@linux.ibm.com>
In-Reply-To: <20251119103722.309211-1-skb99@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR15MB5314:EE_|SN7PR15MB5684:EE_
x-ms-office365-filtering-correlation-id: 96d12703-3776-4214-d452-08de27821d91
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Xl7oPAPiUc6ElXmKkuSWePsEVPRn8ccmfaRfhqBqDa6Aq9Ssxnwz0MAnGY?=
 =?iso-8859-1?Q?FoMWjvr1nnIIFiVTGp65RGb/Whyb47UBo8b8kYlZw5/hbjGc3NetyaGGnq?=
 =?iso-8859-1?Q?ZHGeUxrBFPF7w2+oEDHFaWBbFAxvjZxrjdM32Z/4t22Q2Cb1wsCPsU+GEY?=
 =?iso-8859-1?Q?R8LGG+ruGYlVoOcyQeeSMALIoZ7TqJQmJkA/xlFz5qLYZwNCqoFkUICdla?=
 =?iso-8859-1?Q?bqp1zPBh1gwQum+/XE4onWQbZp5m3sAcv5S/O7SAqnoc+9zDJulbLKZykG?=
 =?iso-8859-1?Q?fDcGHStUWGRInzYUEXoEROs+YdLVxqopGAon8iJEOUV0k0N2lZk1/TRtS5?=
 =?iso-8859-1?Q?WyoLcW2rbJKaNom+OOsq/xXOaSxbJ7ZWEa1Ab0rDv8zL8ncIt8owcZIHv8?=
 =?iso-8859-1?Q?OqEnuajiQkIYJYe+O09x7Metacaa/Ns7hhucg2XII4A4J8NOU0Gw9VeaW5?=
 =?iso-8859-1?Q?tX8BvcDnb0KuAnI37Vv8RbA5W8kZXW61K+620RhUGZWSoTIxoMYq+gk8KQ?=
 =?iso-8859-1?Q?W7DswxIEWwHQLQCjAtzCntT6H00y7jMoexpv2yX9AKzsMQChlZx1RwLYDu?=
 =?iso-8859-1?Q?sOnN8DoGBigGOzUibnZYZUnkUzsnrukjUU6L2t3g+WsPVyI9xpwrnqLkYg?=
 =?iso-8859-1?Q?ieIlikygSrYjTfaEXMzp1mFag6a3Wo6Pkf/2iy5zfu2lcd7mdOE1kwf6JU?=
 =?iso-8859-1?Q?M6nuBtwVYAKwrLcYPIAG3GYClucwOY2r0L85WdUhD1+8H8kzk3Qv6U455J?=
 =?iso-8859-1?Q?1XgJKXKoc0k51yGKApK8iNMvt/ZAdpu0CsPoZQPUTQInuNslt2iulB6IQ8?=
 =?iso-8859-1?Q?ou2Ux3rNNIXbjNyqX4QYZPS1goCwNDS3+16EN0XGDhKL7/KQxOY+XZs1TG?=
 =?iso-8859-1?Q?M3limfcMvrpGnWmPc+sr2D55OozySAxkeqbqrCwMIZUHZua7lJgPypm0iM?=
 =?iso-8859-1?Q?ha9S3E2opa4Juo1oBUSzAgxnPT6sIAlX0pajpVDQflxdraZUnYkwZa7eCq?=
 =?iso-8859-1?Q?T0986+yN6GvzOHjkLvDfEbntjLYMmKCa0dIQGnm64NyfEr6NwRhknsZ/vQ?=
 =?iso-8859-1?Q?zl/0bsc9ZP9CL8A+193J91fXBqLWNkLfpcAn4wP/QIXttOZBp6E5be+Do+?=
 =?iso-8859-1?Q?rUeksDpjNvNHuD4bTu9rjf0iYBUCLCUuOUCBnHlrcVm0TZ0peCkonLRBwJ?=
 =?iso-8859-1?Q?cALV0vIB4gyg+/O5v/rPXE4bZIl92IvMDUKX1KHkerc5kMuZJqzeq/ksYo?=
 =?iso-8859-1?Q?OZoD35krlV+ANsILjgVdBAsriXgOZ/+MXbzSvyijrHIaBVWaY61afIrsKG?=
 =?iso-8859-1?Q?dmsrMISEQ3nKawSL+99x9v7n+JKGfHisNpKhU78FKPmwkLZgPlN/8sbfWP?=
 =?iso-8859-1?Q?ZvBo0ne4VjwS4EUSfN8a/ot2QPZTm0sY5wf/fl0DugvCPrUWAYThYp3z5d?=
 =?iso-8859-1?Q?25nBemLv+e64QokokZYy99RyFp4246g6Dfc8vySFptjxkV8cxBPFqujhXg?=
 =?iso-8859-1?Q?5GI/gtsvVM4QL2IDl8CPixkVp/oJltUK8M0KnwxVTSDiiGGuv/PgqjjFdS?=
 =?iso-8859-1?Q?fyybDkx+Dk9HiHRkKcBRW6MOMwq9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR15MB5314.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p2d1umYFvFSvCZu40WtaNkZof3jwvUamhr6LuL85CYiYpRH8PeCJHQUaeu?=
 =?iso-8859-1?Q?KmYsNO3UDA5Fh7zSWwGPAwTYjOZvMvNiM2WhTBDlLsKrLN47Xqb8PRmd2w?=
 =?iso-8859-1?Q?ft/bYmLRUvf26WRleCMyDlmD08Nwno01jxAdf/SmMUUiPXLp+9Zbmwo1bY?=
 =?iso-8859-1?Q?DbKa+JOFv/kuuI66jkFqtPTLtTxc31aTw1kLihk90kUQfa77TFUw8GvZpf?=
 =?iso-8859-1?Q?IX2L5MG25WRKtg8LTebGuBn47Hf6w3SLSmqD7fyx1FWOXBBbAMkW59BydP?=
 =?iso-8859-1?Q?byAezfx/aGyN94ZEj95otr1D0wjoXO6Me+2zp7CXefoo18PXs9hSQKVRr4?=
 =?iso-8859-1?Q?s6bR/LeXWakjarhiljHPHi+Z5nkdA0WUt4VuCUmCOlX0WvbF488BBThB67?=
 =?iso-8859-1?Q?h3nl44zd4ZltN+HvE0tPlOu773T3qnA59VPR7Q241BMWm6ZqdOtaCKDZW/?=
 =?iso-8859-1?Q?t1Upu9zVJ7yIRTuXaGpFNlL5Y19D9jIvowfxiSNaSTJSmKDwF6d7yyJAXW?=
 =?iso-8859-1?Q?axFEYRLmGdttYMbtgovLRXyjMY8ATKDqKrPOpfsi0ZBudbpNlhe5wMIl49?=
 =?iso-8859-1?Q?1I6C8V2vU2dhPbSl6mb0RH3sVsBlrUnSN6GYcWWseAl70uUUhjobBE4AL9?=
 =?iso-8859-1?Q?Wvo9rCuzmf/jvrhaxm74/aDDIJ7ALRTg63Jjz6MouAHidv0y/wxnNdCmam?=
 =?iso-8859-1?Q?ATFPbpmHFsXl0fABwq0qCm/DCs86p10tldAS2ZIVgT7Rx1NQDKYppxZHiR?=
 =?iso-8859-1?Q?CwsGJd/1gjiGw6QMmmM91WJRYHiKSFvINM9apPO/SKAQegj4JAePjPidq5?=
 =?iso-8859-1?Q?CzKISleEiKirOdfWGuePsogG08E5CQTB8hVtEU3NCRKq0ksGTWb4p2iOxX?=
 =?iso-8859-1?Q?oRTRWHsILHH0dhjPriBi0BJ1DFUrq1fvIu2O5fSVHlNxltSj4dmS/i87Nj?=
 =?iso-8859-1?Q?0Xkfs1noCSfyTwvUcNZnXR3bI0xic7zkYyp3CzSVSsWkM0kyXB1x1j1oPH?=
 =?iso-8859-1?Q?RawV1ThNe2xNw5jU6G9tU6BTgO+5RbFtsVR09XJMWMsQROCDbAu/Ik/S6i?=
 =?iso-8859-1?Q?q4mWfaORVmeEF3m7GeUWc6uZ+Us4f3pQNxt0cxFHrlnZGPrH9m3hu/s3/q?=
 =?iso-8859-1?Q?mLg4nalScgjdoPWtO+xiFFngSiA11hxPkkhpD/wReOKVSAelnoOsIzpWW8?=
 =?iso-8859-1?Q?Lq1lO65zalxNcFRtqShnP7lCJ57bDSUKLBAqMnbSQ5yzGEq+UZaTESMI3Y?=
 =?iso-8859-1?Q?OB3i+f4d24AxdMvtsYzqdvNRK3mLzT3YogCYrqZGGbf5iEWw+IcdqXEsKw?=
 =?iso-8859-1?Q?yWT3bL17U9OJXO7tNAnV1qXI5U+7Ey5UMxbMb5DnUuT/H713OccTQSff34?=
 =?iso-8859-1?Q?CJCwugwfk2nww39szWq2Jg4oI+HDI9GicZtr7IP7d/poqsttj61xRywqkU?=
 =?iso-8859-1?Q?1skHoYLlPFfiMrlHcgifLka/m8JGTIQym4qBdc2I1pGc8lAGg9nIsZgCTi?=
 =?iso-8859-1?Q?DrSj8Xz986JNoRhXx+/Q9hhAaoymlHrvdycmskQl/VnA1iIXzEcJWNlYS6?=
 =?iso-8859-1?Q?+4V27ZixRQ10u/II0tcdWSUC6ErvB9ky280dqFcPeO/hexRqvN8ABNzJOW?=
 =?iso-8859-1?Q?ZicpzYyAodn4pXfjzQICLcWugmlWh7T45L?=
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR15MB5314.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d12703-3776-4214-d452-08de27821d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:41:32.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tamEllxtEgzpaGXHteS1jMjVhzlWZEQByYS7bjbYGy5it4vXdEzMEmfMIKA8SPzd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5684
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyNCBTYWx0ZWRfX9VPDN8zmGKgH
 0If6RMFB4dpj1brE8nqRxZDSRL7Duqwy0fjviMJ6qHYaBVjueQq4e53QB4Ro1misYu8yBot27Fe
 Xm2jgNvEqu4GJuP+V6CULw1NXPZGOkHgYxQNlJOT2/u//6CONw7MJmxsTX05Ge/O5aKHhIwO2YK
 SgrWo7JBdeE0UvoZv2p1oKnQ6YR0EaOXWkRJgtWtULu+HUjlR7901UNZ++lpUDvhl+eUguqyx+M
 e8vEz2JvI5QhGMlRzlWbS68hGMi56LYv5pTvycZE11dsl8zpu/Mf9/nd+/aEOxMz3N3J9bPVw7v
 mzQMwXnAG/Car7VO8lB8VghF1U5iYEMofCWXJNh/V9F4Zg+d3k4lD6b1/vXzqZErbFKL4Z5iwKy
 ieqKZjN0RW+329Sc0sdFeQi5vAPCkQ==
X-Authority-Analysis: v=2.4 cv=ZeAQ98VA c=1 sm=1 tr=0 ts=691de530 cx=c_pps
 a=3/9ZW+mBBPtU5+OO10+n1Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=VF6qZnJ4AAAA:8 a=Ikd4Dj_1AAAA:8 a=V2sgnzSHAAAA:8 a=20KFwNOVAAAA:8
 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=meVymXHHAAAA:8
 a=1XWaLZrsAAAA:8 a=CWErhr8FAAAA:8 a=GGuUjdjYq4hxUu3L6b4A:9 a=wPNLvfGTeEIA:10
 a=9q4iEFIXrH76IA-M63OW:22 a=Z31ocT7rh6aUJxSkT1EX:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=2JgSa4NbpEOStq-L5dxp:22
 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-ORIG-GUID: hSqbgq2Ug5YG50XGUjAzDmqea2gbaoaT
X-Proofpoint-GUID: hSqbgq2Ug5YG50XGUjAzDmqea2gbaoaT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01




________________________________________
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Sent: Wednesday, November 19, 2025 5:37 AM
To: sched-ext@lists.linux.dev; linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com; samir@linux.ibm.com; sachinpb@linux.ibm.com; tj=
@kernel.org; void@manifault.com; arighi@nvidia.com; changwoo@igalia.com; mi=
ngo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com; vincent.guitto=
t@linaro.org; dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google=
.com; mgorman@suse.de; vschneid@redhat.com
Subject: [PATCH] sched_ext: Fix scx_enable() crash on helper kthread creati=
on failure

A crash was observed when the sched_ext selftests runner was
terminated with Ctrl+\ while test 15 was running:

NIP [c00000000028fa58] scx_enable.constprop.0+0x358/0x12b0
LR [c00000000028fa2c] scx_enable.constprop.0+0x32c/0x12b0
Call Trace:
scx_enable.constprop.0+0x32c/0x12b0 (unreliable)
bpf_struct_ops_link_create+0x18c/0x22c
__sys_bpf+0x23f8/0x3044
sys_bpf+0x2c/0x6c
system_call_exception+0x124/0x320
system_call_vectored_common+0x15c/0x2ec

kthread_run_worker() returns an ERR_PTR() on failure rather than NULL,
but the current code in scx_alloc_and_add_sched() only checks for a NULL
helper. Incase of failure on SIGQUIT, the error is not handled in
scx_alloc_and_add_sched() and scx_enable() ends up dereferencing an
error pointer.

Error handling is fixed in scx_alloc_and_add_sched() to propagate
PTR_ERR() into ret, so that scx_enable() jumps to the existing error
path, avoiding random dereference on failure.

Fixes: bff3b5aec1b7 ("sched_ext: Move disable machinery into scx_sched")
Reported-by: Samir Mulani <samir@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 kernel/sched/ext.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>


