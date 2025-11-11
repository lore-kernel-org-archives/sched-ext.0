Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F925A334
	for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889476; cv=fail; b=S+Unbr94w5tyLj7YfYfXGXAjrUbg6kWIsbXFM1Q0tivtQEn3yv/gBtqdgprnXNZLad7YPCB1ZkLkqOtx4HJ2gloxiBxACwT3aWAcyySBOeCELsVNzstVjfOTS05c4e9cuHQOvsE56v3xY28y/cXc+keb6ysxrKUzvcptykVttaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889476; c=relaxed/simple;
	bh=eKJUH/fxySlxqPkqC9iGMy1hUg6sMnz5U8NWs9mMvBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=i4Wv54D4lJ6/QafJe+EKkhkD4ZzhtlkOgUKJEMbqa4CXZezaXDm1g4ey6tAC0/TuvWFQUscXod9ALkjbanHvldP20TYCsNdgYkfjr1s71Uae8mLzTBlqf4dE22DxfDrtx8t5VpYUmFCYN2NSwzBD9YIwgEVtJP+MJiF/2W1KWCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QYxDXygW; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QYxDXygW"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABFtILK3833955;
	Tue, 11 Nov 2025 11:31:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KtbC0mp6PizB1nZgk9XeNPxxf6yPPVMmcslv5aINSOQ=; b=QYxDXygWkDJB
	H2IewFIToOyKAxQX5q/mpe9TMLzfRvuCt0NPcIwL7lJef+ZhHAQLR79tuLTU0q9r
	Alpyquj1Ezk6lT/Zhwakfz0kzHEwa+erBUE5CqqFUfPyFF3nYjFWSU2lILsELQ4s
	vOKn3N5wnTXblYiR5R0aagvFqXsbmX2+3HMBQ6p095XfcQoWZ/5FK7Ys7rpkh3rd
	Z1TOsr/C5es5vCya8JmSzUTt0CtrTQ9eBy+U6cZ6e6W3A2+rwaRQJGwU6DSwI9F+
	A+YdEetrNb/NfbcTIYudoZr1ZJib8w/94oAEXaORWTfSCwhaKNGYtZjL18E+UReb
	UZ0Y2XmwXQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac877syj0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:31:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gydzXm/8lDlshQVKA5MKzmL8jpcjt/GifUw5JCk/k1rn1ibwSZBrcbGLqiTQZIRa4wFB6m77ggKv+ivESAh92/ZBpuDz+TPHQekj7IuyzJdjhuE7tmU06r/pXbnMYmH2+LXTcgQN2jwcr9PNzQSi8mMc7zMsN0T695TNc80s4oH0cosq9I0tgy2WV7TOhgv7Wr0wZgP0xntqYDXEiKcNQjfLlg6oj5gMO/R1Y5x6rBgy6uHEdmvfisnSLq71dEE5hbIkExZuzGQd8DjjYhu2YiBr6P042AFwoym0bij2YNoDtTlMdOIH0gLRY68Fz4RAeZNyUv2RH80J25IIpyrryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k60+WDOQuHWDx5JSUPw/usdTQ8mAXxayRWOCUMs9UCw=;
 b=Fmd0+sjCn3fRnL61YSn+yLqOFGBdUR5I3a191EvMiaC56mXYoCQ/WU/G2FEEd/rx8SOjvSFdI4x/uFf50aKjkZ8qPYlR6CACUNrhjRLEnar0yVvXHnmBakJuAfTsYA1mqv+aXXbSrxeUrQuRLfqw5TwGw2FcfBNVwBepWAUrdXBhMtQMu3o0IRIBVRkVBwk+5uZVNYHmiFV8eSnJSW8gniVk3OclbFbPelVGAFarz2WR9sfxHDCoCUq4gVa1OS4BWQDXngYd1nERMnF2HFnwgelmWvyI1V8TMD1xnv2unlK+SFJ0tVm5eVPYMjTxSY5B8mmlTUuDpfwnHVDIZ3frnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH7PR15MB5318.namprd15.prod.outlook.com (2603:10b6:510:1e1::14)
 by SA1PR15MB4675.namprd15.prod.outlook.com (2603:10b6:806:19e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 19:31:00 +0000
Received: from PH7PR15MB5318.namprd15.prod.outlook.com
 ([fe80::34e5:c585:944e:6e30]) by PH7PR15MB5318.namprd15.prod.outlook.com
 ([fe80::34e5:c585:944e:6e30%3]) with mapi id 15.20.9298.012; Tue, 11 Nov 2025
 19:31:00 +0000
From: Emil Tsalapatis <etsal@meta.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Andrea Righi
	<andrea.righi@linux.dev>,
        Changwoo Min <changwoo@igalia.com>
CC: Dan Schatzberg <schatzberg.dan@gmail.com>,
        "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH 13/13] sched_ext: Implement load balancer for bypass mode
Thread-Topic: [PATCH 13/13] sched_ext: Implement load balancer for bypass mode
Thread-Index: AQHcUz/+EtMdPBnJ0Eyqy1RFblLCLbTt2yOS
Date: Tue, 11 Nov 2025 19:30:59 +0000
Message-ID:
 <PH7PR15MB53188EF161F77FCB7470211EC7CFA@PH7PR15MB5318.namprd15.prod.outlook.com>
References: <20251111191816.862797-1-tj@kernel.org>
 <20251111191816.862797-14-tj@kernel.org>
In-Reply-To: <20251111191816.862797-14-tj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR15MB5318:EE_|SA1PR15MB4675:EE_
x-ms-office365-filtering-correlation-id: 3fe9936d-b157-455e-8ef7-08de2158d82c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sQtPbG4yvlRuTWdXUy/+mjw0I2f3b7XfBBgRmCywhSumojMIkdHvaV1TTW?=
 =?iso-8859-1?Q?RIULGH0cAeR4CJ2WSkBqQwPiIzRSu6ill2XZaBD7mNRmDwVNSSiYhCR0R5?=
 =?iso-8859-1?Q?ItbhqG+rIaVv59IkPt8Oktds73J13foc5e1/D97xbbiQAaBxiG+R5lK3ZR?=
 =?iso-8859-1?Q?j/Q3lyPqOKDicEbjBxsxtrrWbqA7wk/DdD7afHcTBEHQEjt981q6ryDZsZ?=
 =?iso-8859-1?Q?FNoOU7Q4FMDvsNu+sCs4GU+LvcpN1OPdBnWQDQfIe5OmlPiPyDWcgZfbzZ?=
 =?iso-8859-1?Q?inKt/oEmVD/DnwgGfbqvSIL8eHNbyH0Qr5mJxIUwX006DwJPkgtRVSBYMc?=
 =?iso-8859-1?Q?RBkNFeBiIVEteD39yXnX/vyZ8uy66y3GRTuEc/jRm8EeG7IX5xFjrHGSk4?=
 =?iso-8859-1?Q?ynf95VlExhP6xM2B+cOHIAhutiuRCp++1wPUb9/FewG2QNFOY1c17gDN98?=
 =?iso-8859-1?Q?TCMjKxSp5LTBhB8UT+duebZWW1jHH4gb7Wy7bDze2zA9qOPPonjtNuPOvE?=
 =?iso-8859-1?Q?tJoHFFNUSVPLGhLWURqpOjAjCtb31Kz7z5B1fuGpT7nLSYGS+4FgAjct1Z?=
 =?iso-8859-1?Q?V6KiUFAfZWovcZMWFlEzlaRZGoE6ZqnAfC7nJeVBA9QCZ2xUkHR8weiC9T?=
 =?iso-8859-1?Q?lMbKOzZ996fqIB2dlfLexdWkx9yXcMSIs1/eZBYWBPAUcVyXxyHMr7tWfQ?=
 =?iso-8859-1?Q?SOe7aCmkqeLaCZbUhaVCb6Mgj1X2lOfMKaBy02F9WKiLReQs5qh2LakH2R?=
 =?iso-8859-1?Q?7ger4nNFghBNY6uxSVsaNUHXpfJ7A+4zkuBXRoi0QUTen4eYHtD0IpnBb0?=
 =?iso-8859-1?Q?k26lAv+aHQcG1u0xLQ4hSpCHWSVEve7sCn312mus1zJ/92x4NdOxbkY3VB?=
 =?iso-8859-1?Q?iI5GI/+W9tWVShzbNGbfPfMKN9QciNQlxioRwkq7k7GcDye6o0EnKCK6Vs?=
 =?iso-8859-1?Q?SQLWvuhd/gUkyDUYatsQ5Q2fsxDDspHsZfow7He3SwZNqqvz6OdueeTrXW?=
 =?iso-8859-1?Q?HLIHiOGnAC29BhokjkDPhwYqsOsOUFpr0ZXhOIvEl/7Jf8012ATOMYg0V9?=
 =?iso-8859-1?Q?EqGeLsGHERw/55aCwMw49+P71TXwjdAwYgowSz4ftPAALm58a7YmO4JDvS?=
 =?iso-8859-1?Q?UOKPtnoVJzTQ//eZG+jq+3M+22HtrXD6hy83Fg1tMukowpbsv565NiivUa?=
 =?iso-8859-1?Q?I/h3BOfXfqKC3nGi7RAtapysRw8TnNKVGRSdxncFkiKVj84yEBt4VsLhHc?=
 =?iso-8859-1?Q?DGjSMiLT3B69XbUUqTyGWa4rB7DcJ5QmQBYQw39aI2hohfB8Ae8G5A3LK6?=
 =?iso-8859-1?Q?i8EouLlOC0jUUZlRBtK9k5kWSSZKMO7KWtP6CEKUpXAQXTP5L4HSz5MAoW?=
 =?iso-8859-1?Q?A2Hf2gl8iHmcv65vQ+0r1m6nq/79QGAHfjB4CdxWfCyPitDWBa1hguS74z?=
 =?iso-8859-1?Q?gDFaRRfJx1D9EQ8l33888a5mjS5bk/jPQhrghg4s8JIQv4g9khZ7ta2nlK?=
 =?iso-8859-1?Q?L1E50Rfx5GH+9RRs8mucynkY7M+nwKnC69ANZJG0YW0BSB6X14YeFt2FJk?=
 =?iso-8859-1?Q?oa33F22f3wAtAH+LzUqSM3ApmhKu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR15MB5318.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lHXMZfCa1Lrgy8+iZ+V3mUNTh3NA41NVbRWrghpzW9eoHl4xWB9ODbY5X/?=
 =?iso-8859-1?Q?edkK58Z6Te947ljTflA1B/uXMRbKTmGDDmHmQbdozOdKfw9rp01S7O6K8A?=
 =?iso-8859-1?Q?2mDScitn3p+0pZ++eJmA2czqb+0uO/zgFkYX56E3d1ZbT8/O5n6rvI9JW0?=
 =?iso-8859-1?Q?M9sd5YhuMQk+8QP5MZIbLYpTGp8hfpi0THEyrLTrjHqCUSz+3M0DFgKYSi?=
 =?iso-8859-1?Q?YCP2hTeWKvwFUNq1LsY7nTcXMbR8upJ3cOO7kXc2jJHX/TjDTvFfGRr/uK?=
 =?iso-8859-1?Q?c5lmgT1N0iW/WZoI2JgjrQs8dRApCShEPT29AneHA4Ut2SILwY77yGLpmM?=
 =?iso-8859-1?Q?E7JhDErCbZEY9G99wfXbuBatySroErXE9AxT6x3OnzQyDjEKXTNHW3AsPs?=
 =?iso-8859-1?Q?s8LtWOOSxMJzjMYUHdREk7AoNpQ15siPC7PJ/o7YlHnHNeTuhTqaJBH2Uj?=
 =?iso-8859-1?Q?R7rOOa0PTZuVPaWkO4GTyZZHPzTS7b2t8KvksK20g8DDyKgvPJJSOZdqvf?=
 =?iso-8859-1?Q?VAwOKF3yK8UoEtG7Qg7xFiKG96ugixFD0w2OG4CrTaW3gZNMjOQOjKyDDF?=
 =?iso-8859-1?Q?hsE+ebMdTBnV9uU85vl3qTbhhoDt6yZYHe9hwqrmmKsufHJ73Ujmq2+gc8?=
 =?iso-8859-1?Q?WgGmg/hV1EHPPAUiq4sLucDhq0seN9mMfefYM+8r0Rx6NdJEODUAtYQJ0s?=
 =?iso-8859-1?Q?c3vyALVImXmpEu48/Pk3CeLikaT6SF3+KRSOShcoDcfGdcPtMAXrFhx4NP?=
 =?iso-8859-1?Q?7BqqxkVU4+PTpdVbNdP+2eIC3o9pCsCBxso3bzKRxguMT4tdG2zOovD0LS?=
 =?iso-8859-1?Q?D8vhe0Nq31HF3Yrh6JZOS9qZ4bPBASHGjhhlbIpgQgknIgKMdfhrkVV2w2?=
 =?iso-8859-1?Q?dFHb+PS0PORR0rUqj6k2qKMvsn5QAWj1au7czdnLqtiJHrqOCe9onRHRuh?=
 =?iso-8859-1?Q?+tEcD1aPusqXPs6jwUZN9kvF+f4/H9I7EqLDMrSfBoa8h0Iurj7jB47ime?=
 =?iso-8859-1?Q?FlJB0hQkI1LzVKEjH0wyYw6GEb72bYY7W2shLBLqSxU2rYEU28KCKazwC2?=
 =?iso-8859-1?Q?ZZviXMgt9rVCdmDsVSkhYb5L+CF6g8VWVQc4fZJxDIhrbou2j/oMmxfS8O?=
 =?iso-8859-1?Q?ygBJGFoBhw+lNk+oj5QLxfcnDcwTAzQlJGV+Osi9N9hT2V8O8QEsKTtj2Y?=
 =?iso-8859-1?Q?V6pUbH3MzxOnjpZnzDhC0J2Xj1JpcKa3KJH6Gp+CQ1d8kjWTiTtAotEjK8?=
 =?iso-8859-1?Q?A3FeBvTDqhUt7/8/uQizazEBuNPDgVo6bV3rCoTYiwKlSyv4D/bKkSJXky?=
 =?iso-8859-1?Q?IKWnG2eXh7bOgGcfDXtGKyeMUfvbOeQsPmAs8vfeNP6LuMcR6JOnh+BO7Y?=
 =?iso-8859-1?Q?7cMCaYUUUFOSATplGtfEvTI975j0V5OmFRcXvD+ICpUi62pCPK5l04Hx0z?=
 =?iso-8859-1?Q?YfOGFm0YR0rXvwS9q3KiqX7IBm5A0qSUqU7CFVYQwUenUxP5sttd65OmYh?=
 =?iso-8859-1?Q?zTJpVv3r3jeNQHhyCblsIhL0QewtQbiKps6UboD0x8oNJV8EZ5w6ATWzO1?=
 =?iso-8859-1?Q?qcmoNnJoeK/VY6trC7xMK+mSJBCL2b2kCYhFdvqMI0wOkeFUikxvBToQUi?=
 =?iso-8859-1?Q?57nP20SOh8ytnJ7gkmnimDQnKuEhmOcf+V?=
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB5318.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe9936d-b157-455e-8ef7-08de2158d82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 19:30:59.9772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GI3XhzLtCXzbT+DeSLSrNun6UmUqZyJlOmKa5vdSr4uinSnQ2earZcWMEpeuNzx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4675
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: yOY8wswwcEn158D6H-9Ro3hlC6HXqy32
X-Proofpoint-GUID: yOY8wswwcEn158D6H-9Ro3hlC6HXqy32
X-Authority-Analysis: v=2.4 cv=d6X4CBjE c=1 sm=1 tr=0 ts=69138ef8 cx=c_pps
 a=zf46e5KlnE+iQYqYCeD52w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=CWErhr8FAAAA:8
 a=Zp329vL2b4Oz3ClkSGkA:9 a=wPNLvfGTeEIA:10 a=I-g_0vLIplkVOQ0FYkeP:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE1OCBTYWx0ZWRfX//Dfe8n3Ksfl
 yG1Kn05vRQ+imAfBcqvTtprFW4TlTzTrsGZ6O0SrNMDHHbM/RwxLFWTbi/B+N4aK5VaYsbwb+ql
 7KtFAHUdUvqbQZSlxwQhlqA+Cp5Kh4cByIsTCSF5eZG1dO6k/Xbdlm4y6GF624LO6A99JSl84o0
 xR9Z6svHhlNh+xmVarJRncoLjo2MFGPhpt0PH0lfH7ZMGJ8U0/QBIcX6sypYn+w9v9QMOZg4fd0
 P1HAO+KpUyaxWVosPloJ1vFLhXfJgzNt6FyngOEtxVIuWnawCc9n3Ka38jTQR973v1fRIxqoyaS
 gc7GHLa4pG3DqQXYHNSzQ/7NAdT0zjRe9bQj+kM/qbsxPzFt7YOa+kmmVgRV/RNC1jiHDywZPyq
 EZUBfGqnhWqW1ad4RRLi/kAx++qPvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01




________________________________________
From: Tejun Heo=20
Sent: Tuesday, November 11, 2025 2:18 PM
To: David Vernet; Andrea Righi; Changwoo Min
Cc: Dan Schatzberg; Emil Tsalapatis; sched-ext@lists.linux.dev; linux-kerne=
l@vger.kernel.org; Tejun Heo; Andrea Righi
Subject: [PATCH 13/13] sched_ext: Implement load balancer for bypass mode

In bypass mode, tasks are queued on per-CPU bypass DSQs. While this works w=
ell
in most cases, there is a failure mode where a BPF scheduler can skew task
placement severely before triggering bypass in highly over-saturated system=
s.
If most tasks end up concentrated on a few CPUs, those CPUs can accumulate
queues that are too long to drain in a reasonable time, leading to RCU stal=
ls
and hung tasks.

Implement a simple timer-based load balancer that redistributes tasks across
CPUs within each NUMA node. The balancer runs periodically (default 500ms,
tunable via bypass_lb_intv_us module parameter) and moves tasks from overlo=
aded
CPUs to underloaded ones.

When moving tasks between bypass DSQs, the load balancer holds nested DSQ l=
ocks
to avoid dropping and reacquiring the donor DSQ lock on each iteration, as
donor DSQs can be very long and highly contended. Add the SCX_ENQ_NESTED fl=
ag
and use raw_spin_lock_nested() in dispatch_enqueue() to support this. The l=
oad
balancer timer function reads scx_bypass_depth locklessly to check whether
bypass mode is active. Use WRITE_ONCE() when updating scx_bypass_depth to p=
air
with the READ_ONCE() in the timer function.

This has been tested on a 192 CPU dual socket AMD EPYC machine with ~20k
runnable tasks running scx_cpu0. As scx_cpu0 queues all tasks to CPU0, almo=
st
all tasks end up on CPU0 creating severe imbalance. Without the load balanc=
er,
disabling the scheduler can lead to RCU stalls and hung tasks, taking a very
long time to complete. With the load balancer, disable completes in about a
second.

The load balancing operation can be monitored using the sched_ext_bypass_lb
tracepoint and disabled by setting bypass_lb_intv_us to 0.

v2: Lock both rq and DSQ in bypass_lb_cpu() and use dispatch_dequeue_locked=
()
    to prevent races with dispatch_dequeue() (Andrea Righi).

Cc: Andrea Righi=20
Cc: Dan Schatzberg=20
Cc: Emil Tsalapatis=20
Signed-off-by: Tejun Heo=20



Reviewed_by: Emil Tsalapatis <emil@etsalapatis.com>=
