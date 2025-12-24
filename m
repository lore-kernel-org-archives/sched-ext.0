Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620C313265
	for <sched-ext@lists.linux.dev>; Wed, 24 Dec 2025 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766598142; cv=fail; b=qWE19BwcgjAAZLypVFanAQ3ZuGT2ctsjxLggnUBOjJ1yR5+sqOVa1hbNzIGZbmsYB7jQWvpyMEZTNtzW+jnuR5ebfN7wMXO7XUhlEX94QjDan+otI95Wy6g1P0MWVZhKAaLaNMdPlCMlxmH7GelvDzHm0J9M8wo/r5590RDEtII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766598142; c=relaxed/simple;
	bh=NFrHewMEM5oAbYaCuW2+bajcw3wj1TdV7pdfAtKNA4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EQKmslCrodUH7/92jm6B2QiyVUd4W2dFp6Kes66xoFqMiDmPigBQMudxaFet3prZgBkLiHPPR3qaC3HtsTR/k9wfyubmKIgCHTPRqmMgMrGbUOZBShp5wOodLXZW+yD5QCYtco4sUOrQdYZEKzQxHmT3TRjL5aE8KLSqGx6obn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RwUUxL84; arc=fail smtp.client-ip=52.101.193.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RwUUxL84"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFYF54UwFltq6vLTF4c6hUG8ZCnj8Y4MaDhakFG639Nk8zoFuoJvAx0Rz3DR9yN9mpkmlp+9OgfHSzoPwU1HzdGSZJoJmSC2usMGONo0JNLUeIXaMMoZi4XSsmDsi4cNFgRLlM9th/OQpiop7WDWLUMP8B+3c2EE3+PPLearwsnsOLZcg7XwC0SCg4obd2+jRiuv9oG6/uev0P5l6eJoj5VlshExixUgpB1E3FDO/86kfvBsvOBId/3IB6yAGJiUMkEgHUdPrAwFrUch83VlY7mmt1z5yp32I6ljpYukPrYx3OYogPJj+/MU8v45IRFZZgD6XDsxPV5itWDyIfBvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFrHewMEM5oAbYaCuW2+bajcw3wj1TdV7pdfAtKNA4w=;
 b=LwjAYdQPZJzXwWYMMeEJvsUNV88NTZAx6XI6LvyHNFzFdzeh4Gg7+oZPPBahr9uOCaoA5HSsyNeZiREF+PvZGqx7PWtoDq+v7/9sJSwtthp4a+wTYDmhkg+j84IAfoLCuwBsd5TXLmPFS/6yy1c40DkUP9iUo0KL7xHVQMASlPtyEMPqA/nGkqhA79ImLemIvoDCEi5sQgo4j4d2wNx8vyMWGdeYFVVqCFkD0JPPdyyv0Lg9VncOdEtdOtME+he2Y3zWgGrawDZcmf8E7zVls+7i29Ds6BabKOLn6BHO8XG+Mh4z+88JPG+/buxpyox32udbcNpZ7DQLzJITlyCtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFrHewMEM5oAbYaCuW2+bajcw3wj1TdV7pdfAtKNA4w=;
 b=RwUUxL8496LpNvYeAdybf3Wr+J/LwQGAHFMfhnFFY+59qaUr+UcPteaGTYCDhfIm7nqSJEup+C60/qMK+097102EsD+sSaa8b+abcAZIvlNXq5PHpHz/UyM7OUNmtHhFxySfC3Khr8mIGMLySzaaQZgQeYaL4XAXMgW0lIIzjoY4Nvw4fsIZQ4RgkAEdxv9LvdDOy033xfAaEOB2Mh2FRi1Tu2Hgt3sPN28m580BoouFU65ohnhXjprONzCB4aEktXv4LmoFIkswhGhD/YO2N8NuPhDSFT9b44OpQ6JWYaJun2TKBDc2hpAJb7RnZ90ZecT3WI56GNt3CW5J6GnxHw==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 17:42:15 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 17:42:15 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, David Vernet <void@manifault.com>, Andrea
 Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>
Subject: Re: [RFT] sched_ext: Skip stack trace capture in NMI context
Thread-Topic: [RFT] sched_ext: Skip stack trace capture in NMI context
Thread-Index:
 AQHcc6YuWUnFmwPZKUOPGiAcbVMw5bUuhMiAgAAeo42AAQuNAIAAOdKAgADwVwCAADjbuQ==
Date: Wed, 24 Dec 2025 17:42:15 +0000
Message-ID: <3662F4D2-C5ED-4C53-BF7C-B7B17047BFDB@nvidia.com>
References: <20251223005038.62406-1-joelagnelf@nvidia.com>
	<aUoCBVhHig737uKt@slm.duckdns.org>
	<9D417792-A0A8-44C4-884B-A3406D2E7A1D@nvidia.com>
	<20251223153136.761d99af@gandalf.local.home>
	<20251223235833.GA1273740@joelbox2>
 <20251224091846.3851271a@gandalf.local.home>
In-Reply-To: <20251224091846.3851271a@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|DS0PR12MB7994:EE_
x-ms-office365-filtering-correlation-id: f42a17f6-d959-4996-fbc4-08de4313c717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFlUUDd2NHVMcWxPMklXL0ZwM01rVWdPbGhTQXBlRndyZTNXZnU1WVJTS0hV?=
 =?utf-8?B?L1B1VTUvOU4xaVZGQitlMlJFeW15R1lRTGtGWkJXMmNEQjFnUkQyN0tkaVYw?=
 =?utf-8?B?eVhSaXZIR3BQTEdHWGVLOVhRVXBlN0xMd1VWeTRKaGpybVdrSnl0UDJZcnhQ?=
 =?utf-8?B?U21vdU5qU0doR05YSlQ4U0plcko4cFl3UUFBd3FPUlRvcGhKRkRRVHMrVmEv?=
 =?utf-8?B?NVJ2QUpYRTZXREkyR2JjM1JKUENCK3dBcTJGZ0YwVml5YnZVUnpIeUljNEJa?=
 =?utf-8?B?eWtDeEtpWnBVY3V5MWZWY0x3VE5DZzExS29pWWJ2dTdMejNmekwzNzNKd0JJ?=
 =?utf-8?B?RWNrOTYwVzNweHpvSkpGOEVkUUh2RDhWY1dkYlBPa2tvcUJUclZHTkhXOG5F?=
 =?utf-8?B?QVlnYWdMTzBrWE5aN1BQWVF2d0lkM1dxb1BJMnloYW5sMEtJbGkyRmpKbmxi?=
 =?utf-8?B?TkYyWW85M3h6ZXp6ZXI0NjFuR2ZoVUhrL1dNTVUzZjh1d2RpYm1VU0svWmI4?=
 =?utf-8?B?SjViNUdzdEZkTm9FUnVrNVBqcmRNdjJQa2xIS0w1R3M3ak1QQ2tqRTF5cHU4?=
 =?utf-8?B?Q0VoUCtGdjFrZ0pRK0RUSHVPOTNNN2ZsVlEwT3dvMU5xYkUyUjJ5eWMydEYv?=
 =?utf-8?B?Q2daOGZmaHR6eTlTTTdSMVoyTmtnSGFXU3VHeXZLV0daVThNZ3FrZmNjNGcx?=
 =?utf-8?B?cWhpYUlPRko4WkVoREE3N2VTVG1oeVRoeVpoNWhqQXVFejVnSjdZK2UzUGxz?=
 =?utf-8?B?dk1EQWdTOUN5MlRZWkhFTG5VWjRoWk9lSTlVYzFvR1cxbkRGRTB1dE91bGZD?=
 =?utf-8?B?MmNpaUZDYzRhZDdLa004ZndaQTNBUDk2RGJtK3FETmZVcTQ5aFEzTzhVYkli?=
 =?utf-8?B?b3ZBNkN3Q3lKNE5QRjdzUlNBLzRlYlBnSXZnU1ZsL1lKV3Eyc2ZVWWZoZ253?=
 =?utf-8?B?bWdnS0N3eTBSbWN0dXFKSFp6L242SkhGZXlscFJDVHN3ZFp6Z25Hd05ZZ1FU?=
 =?utf-8?B?dXFGd3hYSng0RGlOb0ZDa1hXb2hyOU9iM01LOXdaSDF5T2s1OHZFU2ZTL1Vt?=
 =?utf-8?B?OS83Z3RQTTA1bHU4YndXZzUzV3BYbHQyL25tcU5aUG5CL05PUGw1UjF1VDFW?=
 =?utf-8?B?Y2U0dEJsMUx4UHVTS2dkZUllalM4bUhhc011MWI3NVF4TGJVRE5maGtzTjht?=
 =?utf-8?B?NUZlVFZXOWpFdTlEemFwSEE2dUZOK3ZWVjBUS0pZRWtCcURWdWlSVyt6c1Nq?=
 =?utf-8?B?TUUzbVcrOVdabGRFUEErZ01yeG9IUVdaVEpSNHFYL0cveWF2UlhkUzBUY05m?=
 =?utf-8?B?UWM3YkpYTDdzc3VtajJaNkFyb1Z0YzkxREVsYWNrd2o5YjZWS1ZZM2ZFV1Vk?=
 =?utf-8?B?RkRKbkxtRng4WWp6ajZ6SVpzdWpjMlp0NWRlcWRrUWY0Ry9LcFBRa3FpUlFh?=
 =?utf-8?B?UTc3VXF2S0VxTUxReE9uR1BPQjlrRmo3bkl5YzlrVFZzSFg1VTRTTjhYUHYz?=
 =?utf-8?B?ai8rV3J6Z1RKM01nblZwUlNneitVM0MwSlA1b1pjZE5Vc2kzTHh1ZFd3Mnlo?=
 =?utf-8?B?TCt5ZmlXRG9xajlGZFFhRVZWTHU5bXRhVllrZ1dWL3JMcXA0SThFZGlSbC8r?=
 =?utf-8?B?ZEw3VU1IQ2pvOElyNVdnRHYvQjNMejZBZC81OHhKQUcyM2loTU1CRWdoWXVm?=
 =?utf-8?B?OFVaelBkUHdkbzY2S1kvMDlTZE9IZ1cwZ0ZoV3ZXbjBWNTM2WmVXT3AxaGFY?=
 =?utf-8?B?bW1qTnpQWW5XUmF2NEFrT1JSR25Bcm96a2hoQjJOZTFFM1hYU0Q1azVXem1O?=
 =?utf-8?B?Z1p2NVhidmZDREVDcDNIUUdqdjM4cjc5Yk16ME1lUU5GM3E4cVpNUDJXekJI?=
 =?utf-8?B?SmlGZlhydGhMR0J3M1ZUcjhBMzRhVlZxV0R4Z0N0SEVoZ2JZN3hFdmtjTXh1?=
 =?utf-8?B?VFBIb1NBY3NQYWF0dDZDendjZVhWSFhwczJodVI0SThleVN1NDZKeVlrU2Fa?=
 =?utf-8?B?d3NaZzFsSVQybTJqQitSNEF3YTN0T2xBejN5UytiRkZwM0tTNWZyaDg1WitO?=
 =?utf-8?Q?U66vHd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1NIdTVlMXA1OHpsVi90QTN2SkFNT2pkckhkWEdEeHUxYTVVaTdUK2hMcEJn?=
 =?utf-8?B?cmNzQW5mektkajFkeE96MENEdytIbVNzTDdSMVhqSlN6bkI3aHlBSGJRb1kz?=
 =?utf-8?B?UWpFaDdGNkwxcEpUZlJMemZYeVBFa2c0M3hTT3NYOFBTV2VIU0UzY2hEMzR5?=
 =?utf-8?B?R0VQT0NGRCtyUmNPbUVvTjZINlJsMWFad2RidUZRcEY4Z1EyaEZKVjhSb1NG?=
 =?utf-8?B?SDFleUdMVkI3TXBWTjZ5ays4eTkzeVh6ZXVzaDNHOVhDTlFZRzdER0VabG40?=
 =?utf-8?B?dHkvUkQ4TWgxYjhOMHdZN0ZHWXFJWXpzd2g5Y2JVUm9mWm1tNEJQbEdPV21p?=
 =?utf-8?B?SzVoNTd4T3JCeW1lcWRFTXdBeVdwSkUySFpnSGlvdzltSU92NG42cTVWYlNx?=
 =?utf-8?B?N0VqVEx2RlI3OEJvMkxyK3phRU84UkpoWGVzTW5YN2ZxTG5BNWJzNU02alha?=
 =?utf-8?B?VjFITlFvQ0JMRUJkUURVcVR1cVJxbHp3cUlSTVMxaE5hOWZ2UWQvbTdNSHVx?=
 =?utf-8?B?ZFVUOTJsYVNzWDB6SThCUURWWDZLSXNVYXF6Z0Q1SFJCVVVEMy9RT2VEUEJv?=
 =?utf-8?B?bm1pTEMxL1d6MWY0M1VIbDZtMXVjcmltWWxKNGN1bCsrTnlqc2Fua0ZuaDJy?=
 =?utf-8?B?VE9rRlJkWVdET3p3RFE2SU1XdFVLRXdJWGErUkpWSitady9saGxyRFcwL1lu?=
 =?utf-8?B?b003TkhLQkx4cWZWT0thR0prV1p4WVZNNW9Bd1hkaHdyVlRCLzdKSDBmaUoz?=
 =?utf-8?B?OFMwV2k0QUt5RnNGZ2JDQm42TEpLQU9ON3h5RlVSemVBeDJ0N1Y5QzZYbUpT?=
 =?utf-8?B?Szl1V3VrLzByVFlnREVEWll1MzhRS1ErSDUrYWZUMUVZM1Z2a3ZEbHRWUnhC?=
 =?utf-8?B?c2lUb1kvcGtzckVVY1duVGVmN2YrdTcyMW5qMVhnMnNpaW5GVy9IN3YxM2N0?=
 =?utf-8?B?b1M2VzE0RFNBRFRDd1MwNGM4bStzVUZQN09zRGlpckh4U2dwbXcxQnlTNVRH?=
 =?utf-8?B?SVZ4djYrSXc4bXJZekh6eUY3ZDltOEYvcUVYbHFTQTdjTVVTYmF3K1dpOFZR?=
 =?utf-8?B?bndHZ0RudldiUVpvZ2RXVlBDZjhiOFZYczN1WWQ3b0hSRnNQenlXWGUveXlm?=
 =?utf-8?B?V0cyTk0wTTBSa1gxWjBrbmE0ODJkeVpGNmRJUCtxbWRCaXhUM1hBa0JvU2ZH?=
 =?utf-8?B?Wk00c3ArNDgvOU1ibW4xM0Jxa1V5WTdPRHNpWTFCTURFWGt3cW05cEV6UWg1?=
 =?utf-8?B?WDJZcE9KcnE4aDVXK29LZnZ0TTZDd2gzZWNvVlBiTUJDMW9zaDJoNmNoSEgv?=
 =?utf-8?B?MEFQUzVaMHQ4UzcvT1BvLzRyUXp1R281UXcydVF0TUgrV2xCb1QvN3lhYThz?=
 =?utf-8?B?eTFNMjJKbnRNZ3Y4bkRaS2RGMGxxWHVicmhRUjA1QmRHRFQ4d21QRm45M09q?=
 =?utf-8?B?aTZKeWZXZ0VtM29nSTVVTWtLUzVWaHhReUt6enRsZVlvQ2dncWFQd0d5T1pM?=
 =?utf-8?B?Zlczakl2OThFaWhsT0NRQzlNbHdET0NkOXgrME9JYkZYRS9OeGZFeStWL2JD?=
 =?utf-8?B?TUZEeERPckVkMC91U3B2UkdiZWxzSEhqemFTUWdqK0ZtbWFpa1JaQzhETEd6?=
 =?utf-8?B?YnUzTVdETFhVUEcxMWRmY3BCQjlYNWw5WW1NMktUS25QTnc4YWJEQTRXcXgr?=
 =?utf-8?B?bFNlTHArMnIwUEFKL2p2RUY4MnozM05KKzFqc0dxRTJjU29KWFAzc1RLYUZ6?=
 =?utf-8?B?R2Y3RmRkaUhmbk56U1dJd1lLVGNCdDllVnprMDRzN3NRRVUyLzV4d2Rab1dB?=
 =?utf-8?B?dWwzeVA2SWJzc1YxRE5GWjV3ZUR2cjI1d0NnQVI1eC9za2V1L3FFLzU3bXZO?=
 =?utf-8?B?WnhVSUF6cDd5QWs2ZStaWVNzYlMraU90R3JrdHFDQTdnVm83a2cyV25kWENm?=
 =?utf-8?B?UUtUcTlESVQ2M3RKRk12bFRVMGN0MVZqbk5SWS9hYjk5TnYrMG5rUlYxRVJq?=
 =?utf-8?B?Skg5STcrdklmUjRyYkhsYU4zUFF4MGQ4dnpKWWNSeHlqSlZra1Y1NnBtSjAw?=
 =?utf-8?B?SnZWaDhCUGQyUTJnWDFEeWJnSkY1MEloejlLcitmNFlXYmlhNkVnQU11QWd6?=
 =?utf-8?B?RnRmN0JndGJZazVCamQ2VnhRU2ZlVFJBUlVpc2J2SjN6OS9HM0M3VHVoY1FJ?=
 =?utf-8?B?bDdIY2g5dTJXZHAyRVQxUHV6ajFTUTZCWjhlSE9UaXg0K3NPT3hEczRNWkJ5?=
 =?utf-8?B?SGthRDB3aGN2UEx4TS81ZlEzNWxEQjZqWW5WQ2FqMnlrSnM5MEhSNkJhWWhB?=
 =?utf-8?B?Umg0eWx4TmZlMVdCU01rMGxyK2RjRzcrKzIwajNGNyszQWhPNzUzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42a17f6-d959-4996-fbc4-08de4313c717
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 17:42:15.6351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0khD/gab6A7spxUv7QNGDMhKo1aLm6UP40h/bGBqRYC/khtRgELIsDotlDwbaR7QuYVSKyYql8HLYPx5hL9ABA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994

DQoNCj4gT24gRGVjIDI0LCAyMDI1LCBhdCA5OjE34oCvQU0sIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0
ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFR1ZSwgMjMgRGVjIDIwMjUgMTg6
NTg6MzMgLTA1MDANCj4gSm9lbCBGZXJuYW5kZXMgPGpvZWxhZ25lbGZAbnZpZGlhLmNvbT4gd3Jv
dGU6DQo+IA0KPj4gU29tZSBkb2N1bWVudGF0aW9uIHN1Z2dlc3RzIElTVCBpcyByZXF1aXJlZCBm
b3IgcmVsaWFibGUgTk1JIHN0YWNrIHRyYWNpbmcNCj4+IFsxXSBbMl0gd2hpY2ggMzItYml0IGRv
ZXMgbm90IGhhdmUuDQo+PiDigJ1JZiBhbiBpbnRlcnJ1cHQgb3Igb3RoZXIgZXhjZXB0aW9uIGlz
IHRha2VuIHdoaWxlIHRoZSBzdGFjayBvciBvdGhlciB1bndpbmQNCj4+IHN0YXRlIGlzIGluIGFu
IGluY29uc2lzdGVudCBzdGF0ZSwgaXQgbWF5IG5vdCBiZSBwb3NzaWJsZSB0byByZWxpYWJseSB1
bndpbmQsDQo+PiBhbmQgaXQgbWF5IG5vdCBiZSBwb3NzaWJsZSB0byBpZGVudGlmeSB3aGV0aGVy
IHN1Y2ggdW53aW5kaW5nIHdpbGwgYmUNCj4+IHJlbGlhYmxlLiBTZWUgYmVsb3cgZm9yIGV4YW1w
bGVzLuKAnA0KPj4gDQo+PiBQcm9iYWJseSB0aGUgaXNzdWUgaGFwcGVucyB0byBiZSBtb3JlIG9m
IHByaW50aW5nIGdhcmJhZ2UgdGhhbiBjcmFzaGluZyB0aGUNCj4+IGtlcm5lbCwgYnV0IEkgYW0g
bm90IGNvbnZpbmNlZCBpdCBpcyBzdGFibGUuIEhtbS4NCj4gDQo+IENvcnJlY3QuIEl0J3MgYWJv
dXQgcmVsaWFibGUgc3RhY2sgdHJhY2VzLCBhcyBsaXZlIGtlcm5lbCBwYXRjaGluZyByZXF1aXJl
cw0KPiB0aGF0IHRoZSBzdGFjayBpdCBsb29rcyBhdCBpcyByZWxpYWJsZSBiZWZvcmUgaXQgY2Fu
IG1vZGlmeSB0aGUgY29kZS4gV2hhdA0KPiBoYXBwZW5zIGlmIGl0J3Mgbm90IHJlbGlhYmxlLCBt
ZWFucyBpdCB3aWxsIGp1c3Qgc3RvcCBhdCB0aGUgaW50ZXJydXB0DQo+IGhhbmRsZXIgYW5kIHlv
dSBkb24ndCBnZXQgdG8gc2VlIHRoZSByZXN0IChvciB5b3UnbGwgc2VlIGEgYnVuY2ggb2YNCj4g
ZnVuY3Rpb25zIHdpdGggIj8iIGluIGZyb250IG9mIHRoZW0pLg0KDQpBaCwgdGhhbmtzIFN0ZXZl
IGZvciBjbGFyaWZ5aW5nIQ0KDQogLSBKb2VsDQoNCg0KPiANCj4gLS0gU3RldmUNCg==
