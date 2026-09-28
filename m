Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012040.outbound.protection.outlook.com [52.101.126.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B083644C4
	for <sched-ext@lists.linux.dev>; Mon, 28 Sep 2026 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790562724; cv=fail; b=QFs8I+cq0JRILNi0c6Veewinc9jISl9JDEv+YGAorDnc0bCSCElyhV9RRzoj85Q6WCPMsaK2H0dxBGtrOp8+vypMK7tkT0ah6wFdOdFgn4X97sOopbfc/ymRUN5BSnzslyqZONSk6o1qEwkIpeja6DYdqMczDNH7AurG5YOA1sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790562724; c=relaxed/simple;
	bh=fgiklfoyKU2Fqektc2JPf1Bu2bKaGo5Qr03tCdMT6nc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvnUf3u0DJurgKbQTDxVQBcqmzhOl7NQYT2D9gEInuh8F0AcL0lS1XZltWIZBJs1bKm/rfdktG0aSgT3egsay1Rg6dZ7wqMAZLdr6pWUuswOJkcm5NfpvILo9eAa+GBanUS0WeABmFeERtAYV/8HCO1FR6WEhsqMXysS4FuxMdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Q1HpubH/; arc=fail smtp.client-ip=52.101.126.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Q1HpubH/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp6XKTS+S6Vi+jVQiCOhGwTloosaMcWlxfwbN1f0PLJevxQ+eETDaH8Q9pIsNBeqf+QVfWfNKYqGhNcEUnCE0ZTNeyiU3n14t7RpTBg/P14n/AWs1W2GMTKXkIdlTZVvrKQLXnixhpHa5B6+cIkcs2QtzKorNvvBAoRRdK/zlWqNxzYMA4kvLUI+zDrm3F/binS2dqE4LiJuLJ+1nJc5JtPl0YKYki0Bj1jyXesvbwDaj1pY8RsXI/6YmbfDOtcXfOjb/D2KpcIbBkyGQZ8dqS8+1wVNispk5C/dSnp9RkIvXZqPQUMR4oe6MM8+aSa4blieD+B/Xq+qqPpyWSDjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5aO3PNqbIqksJ92mmb2qOoncOf3caPYSu2Esc37mP0=;
 b=ukxlgson5+7FEuV6E3lrCttHvo4Y1d2LsQHgoe2Y1OuD4v9DZq7dI8b3gwVjYS9s5FKLevLEH7Q+Kn3JrgVVpcCyIdZDOaM0+BMnmwoLeS0SvXneVwjTHdEryHck2hBez0loJAFCw1/BH8sbahqCOPDOn/7hY78fcqoqropA9RJlqERPoOfeZ0NHryujrZnEC5EDmH/t6+3qKxArRswFq4ki8vTQFzdSVIaCR39WClxYMOPZjVTu/Ecc4CDiUVf3F+ELbfqnvQUiTYIgb+k1HbU79mWB98eGyC0u0BFdllej5L7jt+gIHrtIlWjZwns1fnFBioUqJMs0hf/48DyR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5aO3PNqbIqksJ92mmb2qOoncOf3caPYSu2Esc37mP0=;
 b=Q1HpubH/8bdwzk23eQkwFMPhJzRJjmyQrAmTKLmXhFj1c5V8NmqcS2zIrUBkjD3GWTz8+9ELXRNoM7WUH1VPKzGH5VAkeHAfUijK/UUaIUPRVAPEylnrmAIVyPXw9IZZ94d7bjdDuzRQ51Sx6dsMOSMCH33eLC7ADgTOTWeuRM7yIPKfrtGiFuhvZ4jWmOv8XTdFavA/16bTllsF6fkubTgp9dv5ekyvrz+G3IMsZs8DkiZSbZU+o8MwrRRh9QRpA1txD1i/uRZ6DWmn4v30hRJzcNJwWaDjiO8dXlgHUAPl85yBF6fazga4lpWlQpwScGmptDB3A5OCqj0ec8H4Cg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYQPR06MB8119.apcprd06.prod.outlook.com (2603:1096:405:2fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 02:31:58 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 02:31:58 +0000
Message-ID: <da627cb7-2329-43dd-a2ff-6e61b75092bf@vivo.com>
Date: Mon, 28 Sep 2026 10:31:54 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH v2] tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers
 using open opts
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260923035613.20099-1-zhaofuyu@vivo.com>
 <87f1a460f3dee3782d6161ec5493ff2c@kernel.org>
In-Reply-To: <87f1a460f3dee3782d6161ec5493ff2c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYQPR06MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: b0af64d4-4acd-4692-8864-08df1d08aada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	UMJayNA1q3wckg15Dse6t3vfwPjIy6bgl0TzGG2l0CqgA4h+S0cIwtn2er058XD27ygNs7nPk7X5M7aWToMONxXWSUwI43jgKc6hvPhWvVgLk0rwZ9Ppf7vIMUGlqmoX//eEWa85SMoGy5xkHP4ZZh90wMv6r11j+yzZ2/xoN2RUmTKocWWWx0A8Iopg3LQvUgi/W+Z+y+Key8PshlK0nkqSbhooLTGIB9QkjwJMw+tMEK7SGWQmRjQVbBMiOVaol0z3xL4B89QUR8osH148hlAINxAVaWpACh0yoWXizwj3p7LQlcBiV2xwIBs+1AlodzSvd6ClgMX988oFoTU/nOJuoJE+TohBfodxAKDbM/bWaRNz8xyNa6PywI/+E7lH6YXORMKou3i5qK0HSLb5jtakIBSqupmSKf5RL6PEi8PaJdI7+ZMddeybaFyCeEOUDvrxaCA4zLDqW/uim0gn2X1cZQoIhile5L2RRLMX8Rm6oZmdUFQt040hX3AS3YzPwg55sBc8oVykdGDN2VTUwgTIRX1aIGqhMnrOz1jATy+i06a+wAzMDrnsj5Kopsmv1YuppEBeSbhjFmtHyUlsNBoASzYK2Y93lr80fYGzJ4qgkw/6Pfl+m+KIBVeir80hRNBL8DTMo6t89rbQED99NY180UEc5M9iAG9rSX6hMPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUtKeVA2U1Z2WkFvT1MwODQvZDY0UE9RcjRLdlRyN2U3R0JFTEQ5ZDZuR2J2?=
 =?utf-8?B?QmR5V09xSVBIQy91ZklEQ1JxekYxaTlRSm03YzRsZlY3TitnSE1kck41OGs0?=
 =?utf-8?B?QVV0TGpQUXFlNmJieU5lSHNLdEswRHoxUVRqOExGbEdGWTBzckM0L3FUWXI3?=
 =?utf-8?B?M1NsZy9kaGxqU2JnaUVRQUZaQ3NYVG5senBwSjFiT094N1FLZHdIN0pmZmhR?=
 =?utf-8?B?RDJ2QzlQQitqK2k2VTN0cWNHemVkbHMvUVo5Ym14bjhjWjdwcE1VR2ZuZ1Rw?=
 =?utf-8?B?WEpTaGZnUENlRVphd0M0OVdXVTN4c0xnTUdkQ3FTWXpLU1JteGhEZHExZDNP?=
 =?utf-8?B?SGEyYWRsbXFtZGdJa1FYM0RKU1duNG1mZGFPQVIrMC9xenpneFJvTnQxNWhB?=
 =?utf-8?B?NUc4N0thK2hsVU5JTHFQbVd1elpxNUNLemErZXJ1bVVONWI0ZEZFeXUyeTdJ?=
 =?utf-8?B?eTkzbGUya3Ayb2QzZUp6dGx4WU9BL0V4UUN3cXVNVHQrQml5aWVVZTVYM3FI?=
 =?utf-8?B?SnNTcnlweUxFVElzL2FhVkpJL3lkRjlOa1JRMGRVTVB1ZGRxTHhXK09pTjh5?=
 =?utf-8?B?NWdJZFRpVzRIbnJQRUxNa0o1VFJSUVAxUC8zUEJJS1FEeWtvWVhuTFhoOGlQ?=
 =?utf-8?B?YnpjaDhoSkpnbmRFYytZODlGS3BXN1pYc0tNa1B4QldDdWhQUXV2akJoYklF?=
 =?utf-8?B?MWtnNHBMUXZmVmsrbzB6cEpGVEpqRlBHb21sMzVURkNOdDdpUHE1ZVY4amtK?=
 =?utf-8?B?UVMyRWRnZFFIZkdUVjVwbiszK1REMGpqQW5hZUpRa3hVcHptMVpmb1hDNUkz?=
 =?utf-8?B?L2E1cDJ6K1JrTlliczIvUW9pWWpJRlEyTXpvREFUb3h0S1h2OXIwT2pKSlJF?=
 =?utf-8?B?MEZIMms1ZXNXUm0raE1SNEJ1ZWNUcmlGNjBpTnhncXV6NWkrcjdKN0tqUitv?=
 =?utf-8?B?YmJOT2hRZ3JQT3lVdk0wZnBDODc2bnJFUzl1b25aSnkrcHFxcUlEOWJTcVhJ?=
 =?utf-8?B?WmJPYWlLTndkNmd5TlAzVVVTdWtZci8rcFk3VzJoR0VtSDNwTmFBcHd1ZTU4?=
 =?utf-8?B?SlQ0ZHJWdmFNRVNWWmVubU43NUFScm16a3NsdVg1VmM0cGhyeDFkR1F6WVJx?=
 =?utf-8?B?VE5kYndNdHRzMzZoWmJPUGc4NlhDS3Zaa1oxT0d3RU8vK24vWk42VENGd3ZP?=
 =?utf-8?B?UGM4dG0wWDR0ZkMrcXRaYTJQd1grSWgrQ2dFQ3NPakZzdkZrMUlId1laS3Yz?=
 =?utf-8?B?cE1rSTgzcks4ZFN0cUprLzNnRWU5VURZNVV3cjMySGlqQzQxbU56QmlMQTBF?=
 =?utf-8?B?dHl1a0djSzBHdDJlYXQ3SC9PRGgvTFFyQ1R5Y05BQW1wZW5FMUlMOERPdCtR?=
 =?utf-8?B?ZXFNVGh6dzdzK3p0S0I3N0J1d2FRLys4RGRLZWk5a2ZYWUNsRmxIOVFRbVV4?=
 =?utf-8?B?NE1pdFZVSGVOYXltdlY2SnExNCtXdFc5TVVHV1h0QzBwVWZ4VHB4aHdEb2pR?=
 =?utf-8?B?b2hGalcrV0xVWkpyTWhlUVlZVThCaUN3WFF5bnN5QlhmVjFSUnBNdmI2akZL?=
 =?utf-8?B?ZnphUTBMam44R054d1FleEdXWXNQRy85T1NzTVpiOWVpQjhLdFJ5UUlOV1Qx?=
 =?utf-8?B?azdKOXUvWnJWN0UrdnRxeEpCbkhBWlcybFBlYkExU3VWK3BpS0ZhTFdKbmV5?=
 =?utf-8?B?Q2dPSkN0ek5zcTZMOWJFNnMxMWorRVVqVFlPQml4T3FnTkw1VlVLcCs3aVZu?=
 =?utf-8?B?OXR4MXFKS3V6TWdPQnNtblNvR0dKUHZTYUgySGppMGJTbXFiY0Z1TElScm80?=
 =?utf-8?B?WloraUNGOWRXekZKSXZHWllDR3k4WWJvVDRDRllxelNlZ3FKTVNQWmxpQWh1?=
 =?utf-8?B?VzBzS1poSFhuZkwxOTNYMEdYZjFEcVFRK2JMN204eWN5TXZpWTJTRnBrdDRm?=
 =?utf-8?B?SXRKNWdVeGE0aUtPTWM2VEFsYzU5YVBYQ2o5dUFPZUpOcjlSZmVKMFFMMVln?=
 =?utf-8?B?dTFDL0VHbWhBUFpDTDUvdGNGMnNLWGpCMmlxWGJ5c1A1ZHNJL2NYVnd3dDlM?=
 =?utf-8?B?TXlVTHdNZ2RpWTUyZjlQaXRPMWw5QmUrV1FocldVeEJMamsxVy81Vk1qeWpB?=
 =?utf-8?B?OG03L1JsRmNtTVdSbWF5cUdoa2hSVTgybkNiNThkQXRGQUNhZkhrQXBVT3o1?=
 =?utf-8?B?czVJVjB1UDZZaTlwNG13andzRHczY3V5RDF1d1dIUW16R1NpaEhqSVZvOW04?=
 =?utf-8?B?OFhqZjJDK0d3a240UG9hYXhpT0FpQmFvV0hySU11eTRpWnlMcTlkTHZSaTBp?=
 =?utf-8?B?MFRQYjM3ckV3TjR6QkFWd3g1c0tUdllESDI4SDNwRUY1QmZvVjJSdz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0af64d4-4acd-4692-8864-08df1d08aada
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 02:31:58.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS+dvYcP2WcBCafCr+Y0183IYakrtupnvgPHPm2K4b1P4tfnT72Z68n/bsl8UKgpppxZx93BvQmmemzjtWYI1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8119



On 9/24/2026 11:50 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 23, 2026 at 11:56:13AM +0800, Fuyu Zhao wrote:
>>  #define SCX_OPS_CID_OPEN(__ops_name, __scx_name)				\
>> -	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid")
>> +	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid", 0)
> 
> Can you add SCX_OPS_CID_OPEN_OPTS() too and have SCX_OPS_CID_OPEN() call it
> with 0, the same way as SCX_OPS_OPEN()?
> 
> Thanks.
> 
> --
> tejun

Sorry for the late response.

I'll add SCX_OPS_CID_OPEN_OPTS() in v3.

Thanks,
Fuyu

