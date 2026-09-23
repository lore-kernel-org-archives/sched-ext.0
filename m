Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013002.outbound.protection.outlook.com [40.107.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6D31716D
	for <sched-ext@lists.linux.dev>; Wed, 23 Sep 2026 03:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134553; cv=fail; b=DO9OgxM98/xDubjKRAYOBIOZcmz+act7AqgeuJ4X2JnFeFTOitgrHDUaoS9aJK3VPgbVJo62LSEJDToMBzd0vTt9Wls2JeYwzA8qvHrDMIO6JbE6J/zwiACWRzGk+K0VaAeI2hBQgFGt9rpmpD4qq0EjAMbXbnnT77/3QojuEFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134553; c=relaxed/simple;
	bh=ghAA7P014S6RPvOvDB2jBQsQxznH5Hzxj3BwQN5UPPA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTAHjNHfRIJvY4Av2eiQNWpBi7pl4jbmiEuqNVElXD1HBhaGC4Vyoko4EfT5c8EGh7+pSG+dC4v5Nhyz5Ad4Pvko5IkKhyg9BuN6KTatHWoW57ed4KtubZe7ZhFQDGV6MbJ1kHYMTkZUC06mb5cdrXNESUkp+jvF6FGGJkHvbTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eRyoxTz8; arc=fail smtp.client-ip=40.107.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eRyoxTz8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDAYqb0SdTZT+y9q26MTERS5pFY0ogA+elU9BtBNSGRnDMjrHAfgEryI+O6WqiVSc/ORvylnd9oHRgWC4RwmumnhWS4tASM0/g4PTcgBrC5cK63dnctcSKE/D1inPyTYObOtIg3xUEo5+iU88VbRVt7bSOwQXbi+iYhH30TsaWVochtZSaQdpnerPpDVSjgCERrfrBj19YwQQvIFzCyxcLFGp7xGSQH6RFsbs3BnbnMGzlsotJeMm4w88jbOl5chQpmGXovOw++a/AgTwPQa+eEtyAH1vEJjlXeIxQQZ2d7fJgh3EK+djgJ0d/eBgZ3cWtqKLXek27ew1C6RjbSITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fV92DVEuk1OkqSotXpuwJMwsT1aqSsEybuAqCnQYFw=;
 b=gAbsHD+Ng+bZxGzjN7aMFxmXYwkIltiIxlA8TgRVrIzlTysfi8y/aU9fjPFV2NVnA05qlby5jJOlnH6SYeuj8pV3OHTZDAEU2Typb7GbSgQBybQ5/GZyXjb/WgkGHBQcdvc5fSsdp4/b5OgCVCeYU9pyyN15TnKgmnTzb0p3PaqPLGKio83SJTy83/IBlcu0hy7pCFgwxJ4hc4dhylbj/0ZUk26cWVhYLDpuTVKM6tD5e+HAP14SKvoQkcvFvCPHSQLmfboP3+mwfRXDyrH6rJPS6LE20d/NLDtlYO95pPFh20LWlZw7wJcaaeU7ov4kC2zDsI/W6VOSgHOQFcL8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fV92DVEuk1OkqSotXpuwJMwsT1aqSsEybuAqCnQYFw=;
 b=eRyoxTz8cLFJSpmrnFJ1oZ8+h90xr/wWtYfxRkjcWujvhmoptP9yq0MpPwTqsL70bjygBbZ2jiPrvUQiURsKQkwa+WTlMwp1jwkAIdyB/w3jDF99/CG6wR//jXTdIlX3qQbmLnOl1+AWGswQmF16gWQVBBSg7fl8Ow1J64UjMEL81rBUPa23zS6Eqs+X6h68fX9eZyt+/pXWjuL4JVqbPZHyfwUEFJ9X+UHCT1qyVRLzMfPjZwV0Ryj/OheIP32pRkJ2THn8c4nk3ji8hMySjI8cF7ziPjrU3zWcUZPKmX+2pCK5MrDdreiBRvAssd4inZ/k6BKOlDPPIjYLmpozzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB6742.apcprd06.prod.outlook.com (2603:1096:101:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 03:35:45 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 03:35:44 +0000
Message-ID: <ae983d52-e7f9-49fc-98cf-4b682b6c0503@vivo.com>
Date: Wed, 23 Sep 2026 11:35:41 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH] tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers
 using open opts
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260922031618.2858-1-zhaofuyu@vivo.com>
 <arKlQTkhFAOxaPGS@slm.duckdns.org>
In-Reply-To: <arKlQTkhFAOxaPGS@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5c3c38-81cf-48b6-949b-08df1923bfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8pyTcsZ9kK++vsxB4RIbD/nGiCLKveZrrrAVxQDcD1DiFE3XZIE2RyrHV9R3F6sx93UZgJvuyHOcptHt4dM0eshqQV7XJjOKieuKZ+p/Nv/lxHeQRDDdCQ7XNnzmOmdwm8ujKuZ9MZ6aWbt/NUXQBQ1fbD7BqsBPuxI0I4dQgxduXo7n+VJ0GNZHNSGAJiee2sawOdhedc9Q4Pr5QziS8hwbge6BShWqde9lGAPMHt1aWZKNarWNJElcUaGE68ZsfY48FnC5wBeRmI2DQbyalQLxIY6hs3kHpGM0J+qlIHueTkH2eYvV17nbPViuhtn7HCCW1HA370ZwtF72yDkC+9weCbewNhXHiUTgCEq3yWAhbhKRk2PRPNbsTJiHlUvvYmYUxsXViP3ulrKAEPka4jyLh8o0nV2bABD7s3/ypjeIEsgpzMX5MmibXYbx1T01Jh/xErpJ8lTSVbErWAw8cxjOPrw0ymPQCFxdaHFUw58wb9+jPDYTB0oDTRQlwm0x4dUK9vK8MgqyOFioUOqJtNZ+YW+9wA3pM8J4HfjYpcfOnrEfvntjtsvjgeqJZoJueAb+7aNQ2EJrJAVsWUBvRZdMlXnig1ZbxjGIU4nXIhFloi7E+gJAHc0WXPtLEHWkUosyP+KW7cwkMjtn6JEoSDHWHtjfzRUwArkOG0D8ROQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0JpQVpWTTRyWVlBc0pCQWlFOGdqbHRLeHZCQkZvVmpFaFhBbG9ERWd6c1dj?=
 =?utf-8?B?WE93UGV6K2lnbEZzMjBmVFBnekY1MDFnckNXWFVrVTlkYllub3ozWGNydzVL?=
 =?utf-8?B?TkEzejZNOC9PUHh5dU0rTGMrRW5SNFAxSWkwUi9OK1dyQzlQcVFuRSthZmhU?=
 =?utf-8?B?bzVQTmk3Zzh6N0k1YnBmajUzYVltbGJtbGVIdlFnanN2S2phV1FtN0J0MzJD?=
 =?utf-8?B?T2syNCtZNnpFUGpoNXh2MnFjR3N0TjdWcHkwb2s5eC9QQ3FxdTNBczJ5VTRw?=
 =?utf-8?B?UFhaeGVrR3hPT1JIcHhScHFPREYzVUh3SXRCMXBMeko4OUd3ODI0NGFLQjV1?=
 =?utf-8?B?K1Z3V08vUjVPMktkZlJ4ak5XcVBzNWxKekdnemtoQkZSQUdJeitEdHh3QmRm?=
 =?utf-8?B?SWprVWptZi8yWFhaMDZORVN4ZHhrV1N0dWpLY1pMWGg4Undmdkd0ajR3bllt?=
 =?utf-8?B?aXFsV1FFbUZiS0lTdUdKaStaT2VzSENEeUJwdnhoaXZreEpkd1lsMGdKTkxV?=
 =?utf-8?B?b0ltd1EyemJzb0lKM1FFWjFUU3RxUWdIRk0zOGhiWThUVXBkYk1VQmc1NEJs?=
 =?utf-8?B?YWRmTzV3RDk4Y3FzVVdFaldtZTVNTW13R01JTFdqL0pPa2xodUJqQjM5TWRo?=
 =?utf-8?B?Q1U4V2VjSFI4UHB5ZVdKUUhwN0NHdTFYTkx3RGp0SEFuV0tyV1dFU0R4OGov?=
 =?utf-8?B?TVlCTHlGNzduU0drN2JrVW0xNkpUbkRtTU9kOUVKUlNXeUVsVFh6U05OOGJB?=
 =?utf-8?B?RVlvUFl0elBPckhnRVdsblZqazhxb28wL2lOSGw0a25MclYyUVJ3TGhiMUNo?=
 =?utf-8?B?UWVVM1R4NklqeFQ3QWdtK3UrYjVxZDJWU0puNE1oSmlLcSt3OTcwZTRwRDlH?=
 =?utf-8?B?b2FaVnVyNGRWamtVTTAwWVp5VElQWHE3R0RHK2Q3Wm9NVzdYamI5UmlQYmJ4?=
 =?utf-8?B?M2xhMjJwcGczam9sd1pEVmhNQlZ3Q0RQSUVtNEJTTTNsRmsxRmN4dFNOTkxH?=
 =?utf-8?B?SEk3RUhZMUlNUFMya2hIQWh4RW1zZGtrbWlGMVRCYkRpYllwVHltN1p6UWVj?=
 =?utf-8?B?WHNYeVgzcnphN2RPSkZJcFlNd0pha1F2RjdYWE1hZWdsQnQ4Y1VXWXFzb01L?=
 =?utf-8?B?UVh2alJYV3MwZUthaEhhVUxiUUFPU0NjaUdRUlF6WHZ2ekIrRzI1OFN4dXY1?=
 =?utf-8?B?aHZvdUtzd1dSdUVRbWdvZ3dFcEVQUmUzdE5PVE9KbUVaemg3K3Rqa3RlM3l1?=
 =?utf-8?B?b01vb0JMNzJpWS9UMUdJa0pUVHQyanBFRFp3WWZMS2c5Z2RtcE5ORGhxWTND?=
 =?utf-8?B?aVdkUTlrd1oxbFFlSzRNaHZGMHRPVDdNcXJONXVuUHhkcSs0c21tMS8wVm1W?=
 =?utf-8?B?QVpQc01jcGJvVDRuRXorazAxVFZNUUZJalBqUTJOUC9kZDZ4VHcxRmdkVU85?=
 =?utf-8?B?eUt1alNLeTR3OHRqbmJQcnV1aTJkY0pHbW04RGhkbmtaVk5MaUZmOElCa2JY?=
 =?utf-8?B?ZVRzUzJkeVY1THpJRmRBMWw5K1VyS2tPUGdKMENDOUl5UytSTFE5SldNaFUv?=
 =?utf-8?B?b2JsZ25GelZDaEpaelRZajdmVEVyUHEyVDFiYndjaDhSUXVhMHFqMFFHWWV6?=
 =?utf-8?B?bGxkY3FjdHo2TGlDb1RhSnVZajZxM3ZiY3UwZEJjLzNSZ1ZjUWpVRVNZaGZL?=
 =?utf-8?B?TEl3NzlSN0V6ZHlXemVTU09tNEFQVEk5T01KbG1wU3hISzZqZnFCY09SdlYr?=
 =?utf-8?B?R0RPTm51MUtLMGZieEN5M25JQ0VFdFlxSVVob05ENkpsR3pVbElxK3dObXdF?=
 =?utf-8?B?NWtWcTVkanBUWHFKM05aRTZGZnBHTXdWbEtUaXZ2SUkwVlRIMmJKTVpYZ2dP?=
 =?utf-8?B?c1Z1L0ZURks1YnZ5Smw1Rmw3MWY2STJMSENXQU53RTFCVHhOYWh4THRQSFU4?=
 =?utf-8?B?b1hVdFNCYS8rV0NkQTBTeGNwTjBKb2lkSGRtOWtGakptbGE0cHIzZ2dVd0dN?=
 =?utf-8?B?Ry84cDVaMzNPTlkyOGVYQTArWklXRFVBUk1PT2EwTDlXUndSL051VVEyRjNT?=
 =?utf-8?B?eUVLUUx4WHJrRGpYNjFrMDJEUHJreWNINkZPVEdyS1pvL3Vvc3BabGd5QjNo?=
 =?utf-8?B?V3U5T2RJUVh4SHM1Y3JyR05ZNEJid1k2ZWJBaUVTdTExaktTalF6SVllWWNL?=
 =?utf-8?B?RlJBZDg1c3h2UmNQUzN0Q2JpeEFJTGljQmpieFlHVTMyY0JPdlZzWXd4WEhk?=
 =?utf-8?B?YTNtWE90V3BzOGxaMXRQN0ViWStKTklEZUNXdHZZQ2Y2dWVWRnVXSndQcFFS?=
 =?utf-8?B?QVczc3NqZkNVemk1NTdORXNmMWpMZTVYRkhjQWZzTitWNTB1SzhOUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5c3c38-81cf-48b6-949b-08df1923bfd3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 03:35:44.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EUwsSzsDXcTP0zsoWpjU7xp9UfU9yR79sFwZGdEp9ZTF9vGPUIHyO8DpCOumvjRoqYttpVUbhq653Di5fndNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6742



On 9/22/2026 11:56 PM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 22, 2026 at 11:16:18AM +0800, Fuyu Zhao wrote:
>> +#define SCX_OPS_OPEN_OPTS(__ops_name, __scx_name, __opts)			\
>> +	__SCX_OPS_OPEN(__ops_name, __scx_name,					\
>> +		       __scx_name##__open_opts(__opts))
> 
> Can SCX_OPS_OPEN() just call SCX_OPS_OPEN_OPTS() with 0 as opts?
> 
> Thanks.
> 
Yes, that makes sense. I'll update the patch accordingly.

Thanks,
Fuyu

