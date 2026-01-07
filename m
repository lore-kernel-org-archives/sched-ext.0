Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671837B3FD
	for <sched-ext@lists.linux.dev>; Wed,  7 Jan 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807170; cv=fail; b=uH2k4izVRG/GB4BoxtkdmdikJ6URK/4UiBQ3BGuFpiuJ0aRDjmqjwMlFPOcGsDrOGX8JyqvQ/Xeb84zgbZgwvmReM5CSE0ESRMyPAAymVIrROWyOQzqUDT50PnyjB7poUV+RREmfp/aytokULj/y3qSGGlyuARuODeWZ5IU64vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807170; c=relaxed/simple;
	bh=snuGNBNYX8WW3Qsd2bveySjYg3qzA2HWTItyu9hlc9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=q2Wq6yz9bUeqAMpTUO0bBDRn6tppgT/02e7yKrfWGupvrlVJDf8j4nqgEX3aWvqyOS6D+jIX38WwaebDIkuvc5q+UEjOhn/Ansmg4nAFg6r1X8EjcAuU3aR8bQDuonS0RyP7UMsb+sZrmkhmosqwq7JODbOdQe7FH4pMSIkvRzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uVVevAl0; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uVVevAl0"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607GgP5T1343292;
	Wed, 7 Jan 2026 09:32:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=pi8JoE5s9pJGTk907sx1N3Ux8olvIKkRZZl41IhDHkU=; b=uVVevAl0UNE/
	9MftfZV1ewVQ4IoxrZHte/XPQGUI/pUTcswV7K2yXllcj6/707rkXlTsqVdnAhS3
	BgWEr5Oacjr7u8LpZJdjRXzFp3VXdnIwWd5TEer1DFpU11CbWb2g2quXGVPlA/Vw
	JFA5Awll/QLwkXMbn4Ll3pUCxdO+bzfdqWJ80orPyIDZ9XLee8NzqWP2iCIwBc3S
	PdSpFKfpUa33uIvgzwFdsMhxzB6Ry7gF6ZlIEJeBa8+TbYoOxSAHHjR/b3Aqb6Gh
	weKjmukKtsImryxFXG2jjPCC7MFZ2cl8nwDE/W+9aD5VvmE7ABTX2nQ4jJJ4AjaP
	/lW4bTT3VQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bhhm44j83-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 09:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StO3WMLtrM4aP7JZq5lwjerzJOP4EU6RhUA4+jX6r5CtHFHgUVe2+/j8umHxUQSwupi4ysE2g9YA+4XPVMkrZvDj9fBkEydCjBC913nDbuJjgSDRn1OxRD7W66yFmCpKua7SnmjuHolks8aylUJwfZ9iQV1C5PfHS4SSyGutDKkd74By3wDtyjNWlydIW/09cxVXpoxR+9ZqYFW9+PYkJGVHPBffOlUIBJkNnGBHQCkrGZmNEy0nXrFj6KcsHQzUe138FxnXM0nrciBkJJ00etnDubyXfab9FUK6KgTGsYUwBgxF/bBHZSIwYaVPW1pG/FITYPFsZssb8bYTnXS1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2r8A59DZik0vznRx9t6fADL3Pdg/MuWnJc1PNfylNE=;
 b=wZy8fMIWt+Hyo+7FMdb40N9Jp9xPa90rrplByj26ZYGY6c66OZTsitB33AJJ0W0R5HOt2Sy2PWTZF0YS8B9XVC68VLMppYz9i4cE+pe18L1jns18DdAk+11JU/8H3FL4P/z2b+UznKAbSJ+zrda6H2zD//tpeMsMjWhEvpmO8jr/CNO5m+XK+2uJJOWJ2iXWAdUCRlqC1+RSLLgT5b1fz2ajcn+jnyzOMeJ66PyV2ZlbwIo5JTJ7xUid6lyLYKiIhDSN/WUnEWWtWKBuwjuMZsB7cm6YfCeDX/+/33U02c+dd4vQRl2Mwx6XLzA0453DH45ZwvSQqTb5j4/qTuDuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BL1PR15MB5314.namprd15.prod.outlook.com (2603:10b6:208:385::20)
 by LVXPR15MB7102.namprd15.prod.outlook.com (2603:10b6:408:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:32:21 +0000
Received: from BL1PR15MB5314.namprd15.prod.outlook.com
 ([fe80::6d4:d6ab:3e2:c21d]) by BL1PR15MB5314.namprd15.prod.outlook.com
 ([fe80::6d4:d6ab:3e2:c21d%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:32:21 +0000
From: Emil Tsalapatis <etsal@meta.com>
To: George Guo <dongtai.guo@linux.dev>, "tj@kernel.org" <tj@kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "arighi@nvidia.com"
	<arighi@nvidia.com>,
        "changwoo@igalia.com" <changwoo@igalia.com>
CC: "sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        George Guo
	<guodongtai@kylinos.cn>
Subject: Re: [PATCH 1/1] sched_ext: Add error logging for dsq creation
 failures
Thread-Topic: [PATCH 1/1] sched_ext: Add error logging for dsq creation
 failures
Thread-Index: AQHcf57x5ZC3sAhSnkOuEx6PJEPUdbVG9C97
Date: Wed, 7 Jan 2026 17:32:20 +0000
Message-ID:
 <BL1PR15MB531447D39DAACF121532E6A8C784A@BL1PR15MB5314.namprd15.prod.outlook.com>
References: <20260107062851.82471-1-dongtai.guo@linux.dev>
In-Reply-To: <20260107062851.82471-1-dongtai.guo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR15MB5314:EE_|LVXPR15MB7102:EE_
x-ms-office365-filtering-correlation-id: ad35c0ad-50e2-41cd-b748-08de4e12b66f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8Gz50phmVWBePfjthK/VBtMp6CwC1Nf1InOWnOBY88b3JraTi+eFTiqBQ+?=
 =?iso-8859-1?Q?GKAhXQPeKaW7KU2DEO5jSeodlb7NPKtOWla8i1mw3JX2oVwYNiGQLKR6mW?=
 =?iso-8859-1?Q?aLExjwy69IMCGXrTXZk+R5EBBHVSwx9tW59lIgzGhPkeNSY4CYW5zlzGLI?=
 =?iso-8859-1?Q?J3HPmLTRrTAVzo9lRjNtp1WEhfyh8ruRI1cMS8ijX2NwTitTfdCG34/wZT?=
 =?iso-8859-1?Q?WUHvIDBFmM70TgfbU3+ufiiToYZdPToznVDaZdvDvS4JtnEDpIeZsJj62t?=
 =?iso-8859-1?Q?K9M1VGaCHIq+H1eQERq+uje+p7DeWPlfxOhKPo/4vZSR44rMbGWYyQLlbD?=
 =?iso-8859-1?Q?JKnxNMHnQTPLWZHSIeYUGgn3x9vDSiZLN5NBmDcUlSq/5nSSfoRBw+oqx4?=
 =?iso-8859-1?Q?+fIzTHhjy5PxFHeSGuTRqNXWBmiecuwoWwoz+xnxxbXRjGhwpD36C6uLZk?=
 =?iso-8859-1?Q?FiZw3fiBdSO38Hy7foUk+t9R52GOvgAuJdqhJ3Lh27LRRZnf41jiWWm3Yx?=
 =?iso-8859-1?Q?MaFvfyRBQNmYofWvQZaep9R5ik8cwunbJZFyFhCCXl/UxSbpFL/e0tvFSs?=
 =?iso-8859-1?Q?9jCdlpa7Erjk+mqnsdwZrqyK2EIvMpfAIEUgUYoSgyqbcoP+GdnrC/bsP8?=
 =?iso-8859-1?Q?rwT0mftFZfp5MiQMexfx4ZGYALxwHN4LYGkZGnos8WGioENhOWJrR0K8ek?=
 =?iso-8859-1?Q?3D1AVravP6gPP8qf4RIh3PD+gV7KXBAmQch3AW48YQ7MkuevEssY8ktJoH?=
 =?iso-8859-1?Q?sXeVfL9yTQINO7b2T19yDUFw8ZhSgLhV+U4EOZwFrrCd+uFOSojC4wMIpw?=
 =?iso-8859-1?Q?wAFlzLX5H3HmF9kM/T9QoGKz12GcAEHL8wvITYL5ypQNaSKJVSLZnWLfWn?=
 =?iso-8859-1?Q?zyDDFN0JMV2PigK14ogzfj2sNchqm2uH0FtyyJSSAKykmdHJKhAUhJVglh?=
 =?iso-8859-1?Q?O240PX0HE4jdYGCNMar09Ggh/x0WiXD9hqQDwRSrXrgC/FfLf03XMMwKkP?=
 =?iso-8859-1?Q?JCkoSdxaww5GxcCCBHdou5CsnJcnhOu3dwPwLjn/bEgv4lTgQ1iGiC2DvC?=
 =?iso-8859-1?Q?1OfD7P5zt6UteYkWtCgZt2ZAGljgfyl2zrh1ujofbRwU4DUQcDnrexFjsl?=
 =?iso-8859-1?Q?TEVBAbCMOCn7lgSv9XSngoJSujg96EYCi3ntiudWpS2VJV27VWSqK5f1zv?=
 =?iso-8859-1?Q?LCJDndZ1cDhLCOz6ry7Gfum3GFvgqB/cDw5IhIAdORJ0MBBwrPVYaA/bUJ?=
 =?iso-8859-1?Q?ObWu5xVLA9pFi2S859z5/4GEr8z3GRSQg37ZC2l2kFVunJ9DgPEhp6WcIe?=
 =?iso-8859-1?Q?Ab9J8AXmErqK4/aETlx7fCgh7jzPnZtx1MPlKuSdN5WAjjqUhFyTLKY+rD?=
 =?iso-8859-1?Q?AwBtWeMbfDTkOO4BDVGCHEFHqYYRdmsbW9kExQWlL1rE8yd9TxYEQcfMjD?=
 =?iso-8859-1?Q?pfQhjDZ/+HkM1m8ZVGmEQPtfF8OwAuanesSZU9ZoSJUExgXyYNPK8BeGA7?=
 =?iso-8859-1?Q?uciXOqHCR6GoVeu9v9XxDjDrR1Zd8IocdWOQMV0cq4g56Eh1RAiLqMdHkQ?=
 =?iso-8859-1?Q?vB4V0T0Cgaaw6bIuPVJefe+q3ASd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR15MB5314.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ge1FhsnXleo5fkmh6O3nTyo2dmFaXhQ8P6goFRRl22BMOUFKj0rUiUWMAi?=
 =?iso-8859-1?Q?Cnr2PjYYUjQffiJz2bu6QvEUAHe986qUEthxErbRsZ5FL5lOoyT2R0A5Ri?=
 =?iso-8859-1?Q?Nlou/xMHZAfTAg0FBcbp3ppvWH6SFBCbzHq59KHC1y7Ovqa3DoTFcQvN3z?=
 =?iso-8859-1?Q?+agOa7UT9WqQnX8bGeojWckj3OvXF+gpossrxAOY/aRni+oG8JLDbJTG5h?=
 =?iso-8859-1?Q?m9SIOYyPAOUfIqE824IN3GdJOg0GPzYSJvWWGX3QQJp3No4sWrpUvhdvr1?=
 =?iso-8859-1?Q?wSuZlgRMpOcuBuhhckI7lb8BOfPkRVSgdp5JHMxBbMB/xpFy98tlY19McH?=
 =?iso-8859-1?Q?gV+OCqSJwRNsB4TJ0cAu52XnnDOa6A5LxLDhzA5ZQH9P3IyOhnaYskQQwQ?=
 =?iso-8859-1?Q?pI570Mdcb/+oHBn8DlnmE57gblmsXww/iyq0eoqvY/QXmgNfu7wQl+9WIg?=
 =?iso-8859-1?Q?KCbGepNHaD6UnhVc8ITCwDpx49JL7r6AzE3e2s1HccTwDm+RMutY8MN5IH?=
 =?iso-8859-1?Q?p8Xy4JYVw9UZA1PkACT4dBBb3y/ePeNJeMt2j86gr7PBK9uUAHBek/TiIz?=
 =?iso-8859-1?Q?wWmJIQ6IR2+whYcCkql7Q+mZ/uNlMMrwspHHEpI71jy/rAVgBOF3ph91Ya?=
 =?iso-8859-1?Q?faLf8y2hpEdNDB0BRuF4hmh0hV4d1xp/sdGOHR0F8AyfeBGh3kMROIRx6f?=
 =?iso-8859-1?Q?Y1LfcqP6U55INDHP2iaUhHs6XVO90uWDw6A//V3PnfPJhmTxGrOE1FY2pt?=
 =?iso-8859-1?Q?wOUb7pqqDBHphzhkZjz6uZgDdrfM00bNXY3n7jWKP5Pu6FkVYpGv3ztedN?=
 =?iso-8859-1?Q?zEFD+yuzkk77ysqhRWLxPnDnBdlIDbARTJCRNbkcjLiBUaIbF2OLY/Krd+?=
 =?iso-8859-1?Q?W+0HtLriZgIj0PVuA+Aw8YcwV+1JrO2x3KZnodlLJoQTSZ6p0cbizfMl5q?=
 =?iso-8859-1?Q?F9xGTMYnCRoU0m0dzfa9G0E7eSZzJkujIqLAY5P7RSuE5TLJ7JvCWSH2p5?=
 =?iso-8859-1?Q?rLg0Oyyb3gVnz04YmB5HvpYSE/ZCh6S5aT1F7ypRGN4BIe1qMmsr2pN0E2?=
 =?iso-8859-1?Q?nnCEkYtNdLxVAqM2EdFXVAIcoKEzXaKkex+/WZpbM2o66Fhqs3mUaKk7j3?=
 =?iso-8859-1?Q?2k3eBPW0/bUX/wqGjwPgnpmbCS4B8bUMF5PkkzjjkkBhLAVNtaEBQR+KFm?=
 =?iso-8859-1?Q?9RYddZnIsbOaV7hKcSRQyIiR0HKGZmjdb3l0Cd26XIThmhaJoZ+3GfeO4P?=
 =?iso-8859-1?Q?S23goa1/gq2meX8phBHuZ9lQIb2XhEg7lIlz1TB9ExGu2CjZdJeJETYN0K?=
 =?iso-8859-1?Q?3EETSGzX8MjMRSk+OGatWPbxXpMsWgfjT4XDRgzbfZTAQELcJFCxIN8a45?=
 =?iso-8859-1?Q?QZKEGJGvmstw0vJ66u/9xnsl0rq2sPzpTZqfXIXn/xFgrybte9t22WxjRs?=
 =?iso-8859-1?Q?o9h67+L94To+KcoHqvpHNcKnrfHrqBD4X2d6Yvff30bPi6q70hkuvIOCjZ?=
 =?iso-8859-1?Q?aTx2rav/ObTs1fQLQq4xo8LT5Mam1iK5WZGDwknUkux9C0XIYYD2kuUTCh?=
 =?iso-8859-1?Q?h/J6oyRh/eY6edapzkn+NwlY0m4CetVEcpAsujmaqhvkWWN244Js46fCHe?=
 =?iso-8859-1?Q?caKN46fBQUcfpLPTdxgOa2Y35eVkx3XvWhDPL0bZ+e3Gejys0liumCNFR3?=
 =?iso-8859-1?Q?SHpCc7F+zTnasC26M2Nv5XT/pDIZnLEduuEpIThjHhU4DdtAud2r9C6yin?=
 =?iso-8859-1?Q?cYKUYFJJ/r8UePdRwASfDojKbZ0Pnlywb/4FpvFKKOZiLczBTOZ3Dbi+9f?=
 =?iso-8859-1?Q?Ef8ZzCMfMw=3D=3D?=
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR15MB5314.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad35c0ad-50e2-41cd-b748-08de4e12b66f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:32:20.9869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYwazQ5I6IstbVzs1Sa1X92tmez2sPDhh0cy9lkWKKBoR0H0cQGYo++tTsXAI1XQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR15MB7102
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEzNyBTYWx0ZWRfX4wRHye2y+xav
 a2q2E+E/df7Uj7GMkNpfDfWzm2dQAViPFSe4q/m5dIU8kvU769Bbu5PL8uDCOS01V/T98ilnGav
 oU9BlbDVyOZatsBCg0HG7J5VpXTW06/r/Z/vOEr4gexR5Tm1NcwAiXZi/TIpkRznbDQuRi9QNuv
 vHLmYuCUj59qldpaoeiJ6Ay5aIpcZCHnIUXw/0qWQlAKiQUx+tBdHO1oweSfvDmFlCt7mO4iUKu
 manOCgqBYR9lyCPRWH0/zwPni00pqLaQX3dksUag06EcEjpG8X4s4YBTEaZP+0/ef3m4f9ygnJh
 P6Y3TF4orVxm9vdKKsBYgH+jTNYkhcFDii6FhKrl/84QJQBAQWTPktN2T0AuEcnCR48GagpvzEr
 OsgTXDFbw4yExWq4xXyBFGcxsqkXMl/ceNGRLZB+wehrtiFEdVBwo2NfeskZjx5NLC48BlgNOaU
 YhOAnxkBW6bcGQ9c1aw==
X-Proofpoint-GUID: IJRhC0DBC5U2Pb3RqKl7DPIMSF8xeESF
X-Proofpoint-ORIG-GUID: IJRhC0DBC5U2Pb3RqKl7DPIMSF8xeESF
X-Authority-Analysis: v=2.4 cv=DNOCIiNb c=1 sm=1 tr=0 ts=695e98a6 cx=c_pps
 a=sujALEMa9QlLHAoAbbwPUw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VF6qZnJ4AAAA:8
 a=Ikd4Dj_1AAAA:8 a=V2sgnzSHAAAA:8 a=YoXSfiX_NsfXzSk22rIA:9 a=wPNLvfGTeEIA:10
 a=9q4iEFIXrH76IA-M63OW:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01

Hi George,

(sorry for the formatting, my email client has decided not to indent the em=
ail)

________________________________________
From: George Guo <dongtai.guo@linux.dev>
Sent: Wednesday, January 7, 2026 1:28 AM
To: tj@kernel.org; void@manifault.com; arighi@nvidia.com; changwoo@igalia.c=
om
Cc: sched-ext@lists.linux.dev; linux-kernel@vger.kernel.org; George Guo
Subject: [PATCH 1/1] sched_ext: Add error logging for dsq creation failures

From: George Guo <guodongtai@kylinos.cn>

Add scx_bpf_error() calls when scx_bpf_create_dsq() fails in multiple
schedulers to improve debuggability:

- scx_central.bpf.c: central_init()
- scx_flatcg.bpf.c: fcg_cgroup_init() and fcg_init()
- scx_qmap.bpf.c: qmap_init()
- scx_simple.bpf.c: simple_init()

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---

While the change looks correct, is there any benefit to it?=20

- Failing to create a dsq will already cause init() to fail with the error =
code=20
from the failed call. In scx_simple in particular, the  change adds no new=
=20
info because the function amounts to a single scx_bpf_create_dsq() call.

- Regressions to scx_bpf_dsq_create() from kernel-side (as opposed to
BPF scheduler-side) changes will be caught by the selftests.

Not opposed to it, just curious what the advantages are.=
