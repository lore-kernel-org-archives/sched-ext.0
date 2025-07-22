Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B52D3EDD
	for <sched-ext@lists.linux.dev>; Tue, 22 Jul 2025 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173296; cv=fail; b=abwuDbDaESYvYz8uOb36FTlrMX0dr3Rl1/9L6rGP8Gh/WgYqBkYLfTMQxZNKE2MLsQvqnTxVUJPrdvSZ0pHNGfz57VYc5qvGw5ZQ/58RBQLh449XH3KRQJ3OPti7spnFEU6SxQ90/ojMUF4LU0Os73lW/A0Szo5dt9+BJG0iRbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173296; c=relaxed/simple;
	bh=0CHYhWniMsh7m1pJiRZ/glbHRYGnNDPNgXqRVwGr7nA=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=d+tILy79crHaVpW6JEyXF3zK6fhwLsiFMwm1Wa8oA5VJsIa3NQqLbAg7WcU9IyBuarZvOIRPsbfhFPZ/rFqEIgVTcW5RSQsJK5tEDp6FxDxdeqRo/Jg7NpQ8/zjoBySF3LfmJ18mjtaUq/JL6adfZSnLix8CMp96T6d+y5xcVEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjRf92NH; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjRf92NH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCq6s2nuuwtRj73L7suT6oyoz5zPXeiy5SHKk3W0nGsukJJ55b59kedBb5yHWawoNAOBEsgFgRI8/dx7OLMTNn79t0mb9aQ7J0C1U1YwxdpnO89nCWDy6ru9+nO+OFyafs6vxvIEx2NTIg5OGFPZeWqWQ0eSKQirGw659ukcpFKRAV4nqIIjWFUpAsBhogB3oldQJLlnwOsMTDd7Kw32rAts4gLnQuBmce7Qmbj9WVTcnnYxJtSxUbNTeLxOZsv64RyrJ2ENC4UQrvz4Nfvu+zjOAzVd9t1U+L4MAhmu7inIu7IdW+/NQJ7+XpW/13WML0gaG2VTxRHYjqnuBMFyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9aaacWsTxhKO1ppBNdPbk/xZ9z7lMG2PAcUg5rqxN8=;
 b=FdsCARgDza7MO5WW0jfo43HxGUhKbmOnJmEvA++MxcLe4dL76FfcUlQAMkipfM7kUD7azK+nyfQy0aPjLGt2sw8KiVWkVNEJ3g6JJhIPY7/mxmrBAAijQi1K3+QdcW9vvZseyjUGZtfIhTBa9+kKVRWjZZ+E/zaJYF/d7GEbSro8o1+EFzPBgnxy3WOQFrgdRlUtaABXt3aN3nbO6hVDib9EZxAqRSHqNblRqqXZQa8a+yUt9B/LYS69unNesS9fwaWDhSsNUgOP2u7DU4HHyVdLDd7NIdbqlkGDJLEppT6XQfLuIShMKUy3hdQqJZrf75wTjta1yxmeRHpOoDCxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9aaacWsTxhKO1ppBNdPbk/xZ9z7lMG2PAcUg5rqxN8=;
 b=tjRf92NHWsLjV7IO7Xpu2wrs8i5aFIBL19J1EEzTuweaiX1XyDMyIn6TgTxCNssyHLjpP+h6NTTY4eg9LK8vD0k/a/+nQIN2rl31WCmMBXAX01PKOUSi+LcUeFcG9JRO1tchOgvUqxb4b/pmnh61KrxG9qOFWoKhu/xBP4YW0cJB6/WY7i6+4uDFcpWbJjTU2eQMQ+o+4JFO2D8aM5b/v48ptZoZ0whJ268Ocng/ZFArDzJY4yqgTcvwTqTD8C2srB832y7uMOCOXIIjrBMKb/6mV/Ne/3jPoz2mH8LSSfg9p9zREuuiCWfX5/F1VZYz/Rmlw6tR0KF0lGyrta86jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 08:34:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:34:51 +0000
Date: Tue, 22 Jul 2025 10:34:40 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Changwoo Min <changwoo@igalia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Subject: [ANNOUNCEMENT] LPC 2025 sched_ext Microconference CFP
Message-ID: <aH9NIL4C4JdDrOFt@gpd4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7da84f-75a7-45a6-ed63-08ddc8fa9ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0ZZM24xWnFaM0FNS2x6V0I3djlUT3dTR2ZQblVsNERwbngyL1RaYk1zZlh3?=
 =?utf-8?B?d2dhUUJULzEyS1AxSmdEcUk3UUJVZVhFUHVzbTN2Um9xNEdWcVZsZm1USzQ1?=
 =?utf-8?B?bmJna1lkMmEra3pRRG1ZTTZLUDJCT3pWNzJ4MG5NbWVRbU9SOG5MS29kbDNm?=
 =?utf-8?B?ay9GSWVHNTN2Z0UrTDlNRTdxb1h0cmhENkxQRHdKNGFGc1RpODBaMmR0T0lo?=
 =?utf-8?B?bi9XbG1sbFM2MTR2Szcwb3cvSGlpc1FzQ1V1d1ZOSmdNVEVOZThuOG1UUWRy?=
 =?utf-8?B?azBwTS9wUk45L1hjbUVqc2JqN1FNQ1BEaU1IWkdkQVFzVldlbXcveGFKbGc0?=
 =?utf-8?B?c3NVWngzb0V5U2x4VldwMEdZcjFrSFhZOXZDcmZNMFltMUlZeHBOM0lockdl?=
 =?utf-8?B?dEJGSC9HN0o3YWpjS3FnMTk1eEdXelkxWFEzRFplUDBOZW5NWkZ0b09Ca3Ry?=
 =?utf-8?B?SklVZnJqcWlGekpURTV0Rjhsc0pWVUU2V3VkVnhmbXIxVnhSeHpaVkZvMzZz?=
 =?utf-8?B?cXIzZTR3ZDE3TWIweVlqSnZvM0ZhRzZVQ2x6ZWZSbWV0NlQzcVRpVzJLN3A4?=
 =?utf-8?B?d0l4dkFoT1loeWRnaEtQT0tVMFlmZ0Z5TVpTSHExZEhDS2tXYTZzeXpXVy9y?=
 =?utf-8?B?ZXY0RmNOck9aTURJbnROa08xWFR2Z3V0TXRhUWY5dkdGVHFrU3dVdXRjK0Qz?=
 =?utf-8?B?N2tLeS9xY2k2T28vbWFWNU45MmE4U0Naa2xYQ2k3d1hpRENwNnBPVjJhdXZM?=
 =?utf-8?B?QVpuWEoxdkpLMXZkZlFlRFRKVU5kTFRSeVEwR3JHRmt0VzRLZzZMa0x0cUdy?=
 =?utf-8?B?MEdPSFQzd1BwcGY0RVVBSjc1THplM2JKMDdhdFlBZGh5ekd5dWFEdFVjS2NP?=
 =?utf-8?B?aFE0cW5SRlBrWit1UzJHaFY1Y20rZDM4eGY4QVlpcENaNHZkU0JoTzU1R05k?=
 =?utf-8?B?ZkVJWXcyYWUySHpwN1JRTjhMRlRSMU1oK1pPK3pRemhybkdNOEZremVTQkNX?=
 =?utf-8?B?NnpXcFJlSy8zV25OUnZLZithZlpjeTJvcTJzYzBuYkxKL1RTSW0ySmtIbTdS?=
 =?utf-8?B?RWkxVmZwNCthNUhnM05wT0V1dXIweDBZZGNFemIzam55MjlTOGQzaEplSlds?=
 =?utf-8?B?alBwaEx4a1A2cnF1NWFQNExJYURQRENqajJoa1hYMEFaVnV1emNiVHNUd3dC?=
 =?utf-8?B?NlNPeXJ0ZS8vNXJBOHpHZGYreno4dVI4Mi8zd0oyZFlqZzhYK1hlZk8zRnh6?=
 =?utf-8?B?V0pweE5wbE5SUk9keHF5WmgzY3hVRWFuTjI0U3N4MzJHZFo1TmU4WUVYNjZj?=
 =?utf-8?B?QSticG9KM3N5RHliY0hzRjRvYkRETlVnWjRtQWhOWG5QeHV2MytVVElUQVBY?=
 =?utf-8?B?NVdkUlNoajJGb3Ywb0JvdmtmYkh0NGkzeTVRcndxQ0RSRHZBaFJxUFl0UnU2?=
 =?utf-8?B?OUNHNDdWSkJSbmVsUW9VMzBRVjduM1hWWlcrZzlTZFgrUnNVankwNUI0NURB?=
 =?utf-8?B?WUtPdlNpQ0I0RjdvVmhESjlSb2QyOHo5YmxUU0FxY0xOdUg3SlhLMGFiV2Y2?=
 =?utf-8?B?NktVSis3bG9iOEhMWXlXQXhidXBBNTBXbWdLOGJzVFoyWVBpN3RVL2Jndzlk?=
 =?utf-8?B?N1A4RVcrMU4vQlNmT0FOQVVNeUhLa25WNmxNVzl2OVdQNXNzaWRuT1NMZ29j?=
 =?utf-8?B?NXREUjlvOFhJSG80Uk9COU4yc2FVSnAvK2JaUXh5ZTROVU11VHo1UW1zRWps?=
 =?utf-8?B?RjA1WXUrUWxvYWI1a1RoYWhRWUhmVjUvN0FlWng2V0pYNklNRVllclRBM0p6?=
 =?utf-8?B?WjZ0bHA3TGdQTGFrMXZJN1grQmRmUDYydURINkNwMjdSYXY2YkVoT21RdHhz?=
 =?utf-8?B?VlZvWDJqN2JLcEpaeWR4UStKMVI5cFRLbXRqbURjWnFxUHdXbWNtNzFSVjVS?=
 =?utf-8?Q?iFWEzBTVAeM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXQ1bTB6YUNoS2dJQzFxWUpvSmU2Y0QwL0ptUytwbTdEdWg0YlRyVVg2SUhK?=
 =?utf-8?B?dnNDeW9yUXIwWUl0VXhUeDB1SmtLdkFlTW9lU0p1ZzdrS24reFRLNWVaWEZF?=
 =?utf-8?B?SFUwd2Y1VGdtb29WZzF6VWZWQ05PdGxqdzN2TllkcGswTm42SUJDdWUvaXJi?=
 =?utf-8?B?K0tpYjV0Y0wwaUFVTk9BTGR4SmFvY21laTJZc0hpaUk3ZXY4Mi9Cd082enhv?=
 =?utf-8?B?OWlFcG9qcTRCd2V2MWRYNFFJZmZCUHZ6R1l6NkhTNUxMbEp3SnFPWlZ5Y1Vl?=
 =?utf-8?B?MFVGNTZ4N1Y4cmVRbklZMy9oWTh2WlUzdUxQVDNrMHlxS3ZJRDlBUmtHMXQ1?=
 =?utf-8?B?SldiTzQ1UEc4RTRGbUU4TzR3b014cTJlVkFIVXFFVTMvakthejI0VENJcE5F?=
 =?utf-8?B?MWUxMXp3Z2NlT09GaEk5OUNLaEN6NmREdVhLMVdZdkFxQU9GSkxaR08ySkMw?=
 =?utf-8?B?NFVualBsUmVnRit2OXZHMXBwSEhLd2RrQXZvbDJXaERMeFM1WGs0KzdSUUdH?=
 =?utf-8?B?WFc2aWdnRUV6RXg3U0lDSWxWZFVReUNGZ0p3V2VzM3o4M3hkcTJ6eTNZZXdR?=
 =?utf-8?B?RVZnWlU1aHN2TWROTUF5Qlh1T0tuYnZFdUdJaXhKTld6ZkdhMDlzRndRVlJw?=
 =?utf-8?B?TmE0aStVRTd5Q1hVbWNhY2x0T0ltRkdtWk9mVWc0UjRxR0JYRVF0cDBMRUEv?=
 =?utf-8?B?NkFhU0o0OFBicW1YTzhVVmtuaUpsa3JEYldJT1VrM1VWNUVHVHNYVGFFOEd5?=
 =?utf-8?B?V2M2VS81OGNHRFdtTVRETW5iRmMwS1h5eVkzSWdnditMdWtoK3JCZjE0UW1L?=
 =?utf-8?B?OWVGeGdvTytWQnlQajB4MklvdWQ5R1JRNEpwaDZiamRQVXNJa25qM1hQT3JQ?=
 =?utf-8?B?MXFmU2hPaUN6WFU5eW1VQldheHhGNHRMQzNSRm1NdEIxZ0ZUTWdCbXZYVU1Y?=
 =?utf-8?B?UUVVSDExZkpHOHJhcHhVb2tYaDd4cGxjRWdEWmlZTmlzSE9DUFAxUTE5TlZu?=
 =?utf-8?B?OWNoeFRNNXh4N3cyY1ZoUGRrZmU2eTM4UWYyUUFXMmk1S21TSCsraHhoY2k0?=
 =?utf-8?B?MEVwWFlOL04zUkxBOWxPOVdUdFJxWWZaTmNaZEExK2I2VFoyNkdVbXB2ZGFq?=
 =?utf-8?B?NkNxRjR5T1Z6MHNoNUhZangzdDAwRlJvUHhHNWFldldNVWljMEsrcCs3a3Jq?=
 =?utf-8?B?SzlHc2lvNDJpYzJRTEZwSmZxOGJ4SUpYM2Nmc1F3VjVwSWhKeDVsREpaYjdw?=
 =?utf-8?B?czRxbWxGa2VTMGwreTh6b2twT3V1ek81cEh5V1hmMUFMZ01PaHpna2pvQnlv?=
 =?utf-8?B?ZUh0U3VMT01jWHk4QlhQWERJdzhqTzlCTHkyS3U2RVBrVDR3cVpmNHh4M2tE?=
 =?utf-8?B?RVhYVGxxNytYWUFFNmw5L0NzV29WM2F6L3c0TGhpZk9QdWszMm9OMHB3SHFl?=
 =?utf-8?B?R0tXWmRHMEdVaXlKN1R1WGN5dTRHZ0EzRlM5NGo2azdvTHd4dnh0OVhFTWY4?=
 =?utf-8?B?Q0hpWWhWMmYxVWh5Q1krRk00MXE5ZG9acEdUS0VoMjVWcVNXMzdjdUk5anlL?=
 =?utf-8?B?T3c2Uk9Nd0UzMWxRZWZiNmlIN0w1bXlyY0tHdUtNeGN0SDZac1BiL1M0eEZR?=
 =?utf-8?B?QWRCRlVxSE92NWdRTHRLMjRDbXdFT3dzS05jZFZoNFJJdC9MMkdZbXplRlBj?=
 =?utf-8?B?OXA5aXM0azZOMitwYzB0VngxM3lVR3ZYYmRiSjlwam5XMFJnSlFQT3NXV3Np?=
 =?utf-8?B?cXJWRzVqUTNhSkFVeVdYTnVYY0JnNG1EK045YVRncTZKMG1PZTFSMGNyZEdh?=
 =?utf-8?B?bDB5NUlaKy8ySm0wRDYxamdVL0NIREJuUmpwaHE5UmVQN0gyblJuTHFXeGZF?=
 =?utf-8?B?YlBtbG0wWlNUNTNOUWY5SWZxYS82bzkxTmtxU1JmV2hmdU80S2YwNzllMk5J?=
 =?utf-8?B?a1F4M0lPOTlaS2Q1WGtyMkRwZGdTOHc3SHV2allhWjBZR2JlWU4vTWRISklo?=
 =?utf-8?B?OE1Pa1o0Mys1aWNTaVlFTFdoWStlQm5BYVNGWHF2eTB4TUwrck1hV25CQnJT?=
 =?utf-8?B?WWtUSUFCR2FuZnYwOGFNRDR2ejVTTWRWcGQvbytVQmpaUy94U0ZCdnJEZ0xn?=
 =?utf-8?Q?MOjayWREDMCQ2sS45WndR1F0y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7da84f-75a7-45a6-ed63-08ddc8fa9ffb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:34:50.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwUB32CFuq8F0pXF57BLJY5P5gGpDDxUaOq81HFesl4ZrqNRJDOzEbFz3+BCojRju92PEQa4TV9iFmOXKTadTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

We are pleased to announce the Call for Proposals (CFP) for the sched_ext
track at the 2025 edition of the Linux Plumbers Conference (LPC), taking
place in Tokyo, Japan, from December 11–13, 2025:

 https://lpc.events/event/19/sessions/229/

This microconference provides an opportunity for the community to discuss
upcoming sched_ext development and outline future strategies for improving
integration within the Linux ecosystem.

Topics suggested for discussion include (but are not limited to):
 - Use of BPF arenas for task/CPU context sharing between kernel, BPF, and
   user space
 - Composable schedulers / scheduler libraries
 - Deadline server(s) for the SCHED_EXT class
 - Integration with other scheduling-related features (RCUs, proxy
   execution, PREEMPT_RT, etc.) and other Linux subsystems (e.g., power
   management, Rust-for-Linux, etc.)
 - Workload-optimized schedulers (GPU/AI, gaming, server, ...)
 - Tickless scheduling
 - Tools and benchmarks to analyze and understand scheduler activities

Proposals can be submitted here:

 https://lpc.events/event/19/abstracts/

Note that the primary purpose of a microconference talk is open discussion,
not formal presentations. Slides should be brief and only provide context.
Each 15-30 minute topic is intended to encourage brainstorming and discuss
open issues, not necessarily to resolve them.

For any questions, feel free to contact the microconference leads:
 - Andrea Righi <arighi@nvidia.com>
 - Joel Fernandes <joelagnelf@nvidia.com>
 - Daniel Hodges <hodgesd@meta.com>
 - Changwoo Min <changwoo@igalia.com>

We look forward to your proposals!

-Andrea
