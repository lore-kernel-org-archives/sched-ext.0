Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795576245;
	b=hZ4TxZKGsVeExxtwN+aJ174Mvrfj8e7UmhLR8NnBrHWe/6n7CaMV4shkeMfeBNKfNmdF
	 D+VjqbP3tPA6hA2q3jpgaBWo00hNNh38HWPdBfGVQPrqs8vdzbWFLoJ7ft9vDMu0pgXKr
	 HXn1Sa/FxylEseavQo1VLJoK1RTAsdNQg9WCVLMnm9JIxfS1Bz5VRevDR+hUPJ9ItWDX5
	 ifVbb53HzT3B29TClZ2lsFiYy/VwAJdQwcCkLk3gmGIypiZ18wg2QoSZ0KKaYdTWznJST
	 XbK1Z7GaZRclzBv92XzW7uB1sRC+dSnncfVT2WDDcutthv4WFtvaDxkQ7bfgXFWXIKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795576245;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CFQHm7m4V+MDDv7e43M6ffRqCAsEBs/PHHcl6keerBU=;
	b=uIYNaNMdKZtKhZrFyWXA2berOefvu2q5/1RTcCGePw6YTFWccrfdB+8CeJXLT2iQA6ys
	 uVUkiff+o1D70L64BJRFp0j9x4yFfRFun3zUokrWOsofERNYOxstU1Ev3FYCAx3fTbAOT
	 Nr7/6u/bKafk+XJuqp4OLjabg/ncaDk7jD/cPdzjKw9ZjPtoAKbZ5doldfYdhRjvv9PhM
	 htJrecBp4fMBe1evt1BGTxaGTsgdXlOg36d5RnfZLOFeB0LCiR9OweTc8gGmnNqs548pR
	 3ZLn3GYzM34DzZpehWtOvFFvWplh40xLdlb8BwX1VJiHgVb1TT0LFUTiY4M+V0VoWyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EXb5qpfE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.15
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408B606A32A
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 03:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B408B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EXb5qpfE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoa5dy7xwSuc8f0JUQ+OwH6bM/Yprg01HeUX4ODnRE7qNksM3RFfU0X/9a+9HcPX5z8kYFn5JAjy6LlwTt8qyUPb1DPV+j6b4deO4UGr0iEjsyQGNfWMUsELHFm9iuxeG4S48mFZcSkKibahKHecOaa1TMXol06h6Lnn+rRn1aE5gVN45geKJEsRqxypqLxc/WQpyJxwM5JoH9yyK+P4KZasntXszGid2C9Be/ASDZ2zODYYuH4ybmGV4rR/9qDJGqYD7mX2oq2ynKiZDkFTXcbHG/Hp45h0fG4/QvyvASDyN+9bG7n/i37o4zK57Utqo2/MiqdEk6SoIH1T5SS9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFQHm7m4V+MDDv7e43M6ffRqCAsEBs/PHHcl6keerBU=;
 b=wd74d8hpFlOCTlKnwySl7biEuTrbMk+njua0Ga7maXr3Ht/Brc8hWekS7GtHqtEz5XkkX/4CSkDLs2loxqu+HHldfcFVhQU0JaV7n319P3Rq5NAgaDk9gXzm+GBuS+r0bBfQprE6S5ZjNTCGkf0DCk1i7ev6FAYnUPE8Yec5MRWSGLR1BZjiVnbbfL+a/wgS1Zgb8URdp33Ggr/wGBOU1KYBY22e4/0mRz4e5R6tVoD//CG+bFPlQf2X7ncx5eaq53kWzijNmzRszLmcVajWzfXRN0GBM/EjXFzhPbqDOZP0aPesWLInnW2rAUWEe64QshVnoZUjz4HMyyBRhcnowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFQHm7m4V+MDDv7e43M6ffRqCAsEBs/PHHcl6keerBU=;
 b=EXb5qpfE07zfxr1+ftmltGaBRwWvDNOKfd44ka9Zf4FaKdEWlbf66GcXRfVpspGD+vq3ChlbubHyEEWgmokdrfpDrWysFzAUF3AvqgQE9ipnT1i7ftBjmmzBxvfLFIY5G2f3mlqRSWHH+2bMkF9QkyuJCUig4itLxQ3crwjS3sLsUBTRCypJC7WMRI4KLOOcZDJe80EvtJgBBbOz6qc3pczY1cw1NCo9jDocNMAgg4FKQY6MbLIJFjIxFdZMJq+dt6uCGt1a25oI6KhjSuQPwUxjY7dnSqACCR5WR42/Mv9GrOlwrb/2Ztxs5BVSQiaHisDQ18DamRRjKu2ISrLzOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 03:10:38 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 03:10:38 +0000
Date: Wed, 25 Nov 2026 14:10:33 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Tejun Heo <tj@kernel.org>, Vladimir Vdovin <deliran@verdict.gg>, 
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>, Lee Trager <ltrager@nvidia.com>, 
	linux-mm@kvack.org, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched/numa: Only pick a fair task as a swap partner
Message-ID: <awZPWf67TkDy5Tkg@parvat>
References: <20261124070011.2498455-1-arighi@nvidia.com>
 <20261124070011.2498455-4-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261124070011.2498455-4-arighi@nvidia.com>
X-ClientProxiedBy: MEWPR01CA0160.ausprd01.prod.outlook.com
 (2603:10c6:220:1d9::10) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1fe034-a6b2-4b5e-d3b8-08df4aa1ae44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|261022075727099003|22082099003|18002099003|3023799007|261022105027099003|261026121527099003|261026140227099003|4143699003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	23jK05eVgyYg+8Qmnb+OZb5qDhpy1TqPifxDdtdYIqWPPK1RM4zw/A4EhEmMit1fL6ODokjwAdSuOzoclOQTFkVX/r64Okx6+hAfm1gUAdcjdulbvwCtoTi0YF7+Ds8ljbF5w47ZiUOUixBBZpoDVTqIVQxOWPC1quo/bX2SlC5ghoTcljkJgdu3rv+X/oz6rwFAS4xVMX+QjhvJcLj0WY3a1Fx55o/jX2NQeA49mHJGR+8l1Y01RXZYRahFeGTjYlzo4rcjqkWFxvA5aH/e7zmlixhC4gEGKmK+46BtDrlAMt7j4LTvLZkGWNwotyl5u23nZFA5mnwFjlppdKQF5blF5/1Gnb7STPHejiU0MxTuv0usdL3yIO5+I4cCLL4FG5Pgc4Y4Z6YUsxqReRSoxbGb+G9OVaXHBz9K2chzwbGJ84/l6+NSLP/zxKwdNoj4kGFEdsxP4uh6ZeH/5zsRE/VJGNEAdKwwWOFVq0fTt2ZRzklyeRA8mFM8/cEg4ZOFJAYT9JZ3PyAEyC2rsbv924kfBvrJtaJzOmAYGlCBZsWjLHng/+Qm7QfTMYe9QxYSN4uKGzU3HRPDK4iuxGJhDqlLMHGLhweo7Nctu6UlJS05Gb/Tz3Ous6g1mAo+RSn2lvdiG8Hf3fZEO4p4qm2L0P8uucLRAsUhPtTwk7gt6yg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(261022075727099003)(22082099003)(18002099003)(3023799007)(261022105027099003)(261026121527099003)(261026140227099003)(4143699003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3NCLzkvblVwR2ZiZDlJVU16ai9LeHFXWGc2dUxDY1RPZTJldTdJbE1ZWmhs?=
 =?utf-8?B?b2QzSS9tRHJRS0pCRTRLR1owVUNiZHpjM2FUcXBRUEJyZ2tJS2JpdXlnK21O?=
 =?utf-8?B?WVdNK3BmVjNQZzBueHY0U1ZLa3hYNGZOM0ZKZEhSM2sxcFJyTGdiYnczeXRR?=
 =?utf-8?B?U3dXV09sdjYzcXpuLy94MmREN2ZWYUN1ZkUveEMvRXlCVklidmNoRWVVZmdE?=
 =?utf-8?B?N0hYcy9BYmxLQjVBWFU3Ui8rWVd4K2pIalA0NlI0UVQ4RnNtb2kwYUNUT0hR?=
 =?utf-8?B?NlhYM3RMbTdYZytGMXVuN2hDOVdwTTQ3TDkvTTRuTDlQL01mRnludWRnY0JF?=
 =?utf-8?B?RGNhUnE2L0VnUS8zS2I4alBYMnhSY1Z3V01sNkpYVUtJazF6WHVUWENaTFQz?=
 =?utf-8?B?ZVdkUjRHNUpiU3JXQjczUkFxWTg2dXdBK0hzdWhrSmFYUWRQaDRBcWdLMGEr?=
 =?utf-8?B?bnl5YzNUU25MdzNYcmFVTkRuRUZZWkw3UkdhcXRpWTBxbWliNHZGRjZyNmk5?=
 =?utf-8?B?T0krbUdwT1kyUjhjRVBYZDYvSGtqY2NUZmVqZzZnV3hmZFFSZXorNmd4MTZW?=
 =?utf-8?B?cXNTQU0zT2syVnBMcnl0Tzd4NDA3RFE1b2pWR0xOczJQNFVZUEJwT1FvdTBD?=
 =?utf-8?B?YmtWWUV6dExSakppOW9nY0JqcWE2MmgyajdrVHYyNThSNTEzTE9mazYxT0g5?=
 =?utf-8?B?U28xN1o5OUM5VDBvK2o1ZXdTV090QlFieGZWSSszOVNDc3JzdHY5aEs0NmhF?=
 =?utf-8?B?SG1SZ2FuR05EUDJoR1Q5d1hHM2JERW5WUE9TVXh3M3Q1TnJuS2dxYlZ0WjhB?=
 =?utf-8?B?R2tBV3JTZ2U3bE5qeEpUL0tibWswZDZRRGtvNGVoMnJqQm92TkJ4NVZhRW92?=
 =?utf-8?B?WWJ5M3MranJ6YU9pY2NWZGFyYU5DYlBrKzJMZWx0d2d0eGt4SHYrb2dXYng2?=
 =?utf-8?B?WG9LODRxQkVieXNMNnNES1kvaHFuN0NMUCtmbjZpUytXZy95ZXptclh1cU16?=
 =?utf-8?B?WVcyM0luQ2ZyNDRyck8zdkF0NjZyVys5SDBPNUFqL0NMNSt0c21keGoyald1?=
 =?utf-8?B?ODV5MWc1RDQ5bEQ0WjFrSFBhUzBwS1RQKy9Nb0FCYy9JMGZ5VUdCV2EzbFNC?=
 =?utf-8?B?WFhaUEE1U3Y0V2djdjM0RmpFS01kTzZXZ24xWVExQ1cra2lSbGFEYVJrK2hm?=
 =?utf-8?B?cU44REJKRG5NODdHbW9xTDY1TjNFWnQ2MGtmOC9CS05NMmxXbjJKRFB3aEtm?=
 =?utf-8?B?bmgxejRJK05KRVUxM3dKNGFNdFhRTEpkNmk1K2Z1VHprQ0w4dXdNVDRrOGE3?=
 =?utf-8?B?Unl6eVRaY1RTaysrRGwyVEFMQUt1R0tTdUFvdWE0TWdha1FIcXhEWkpkM09D?=
 =?utf-8?B?Zm42c2lDbjhpUlI0OU9VZ2FqaVJSRFloTFhQa1pPTU5KR3V5bVVBOUd2b2lT?=
 =?utf-8?B?VnJEZnBLMTQzRkwzRDdJbGxoWVF0bDltcUlCSHRNdW9NYmVrWUdnbzZaZ1ZL?=
 =?utf-8?B?aVJlZW5hRXVtUWhTTmg3K3RxckNESWptK3dGS0dXWUErT1J5MnYwak8ycEYv?=
 =?utf-8?B?azg1azFoZWhwQUtwN2NscVI3dE5rUXhudTIzcElrcWN5cVRsUUNiZHh2Wmt5?=
 =?utf-8?B?Tmw4KzFTZFY2T3hxaWVoTjZIN2NnaEdNcW5mNWxTeDFYdm9zNFk5Syt2TDgr?=
 =?utf-8?B?SDFJOW5MU1dSSjVDeSsrMUtJeDRLcW1vbTJQa2V4S0dRamFxejNIMjU1MWFm?=
 =?utf-8?B?aE8wQk95QTAzaHpXVEJ4Tk4zV1M4ZXhtOUxFK0VmZkduOEM5ZUxabnc0Vk5G?=
 =?utf-8?B?bUdyTFljTnVERjZLVEtiZEhOV1N3TWhMeURTRGNNaktXdWorTVVHSDZmSXFt?=
 =?utf-8?B?SzZVdHU4UnpMdHcwVUhYWjFMYmxvdlQ3bXBhcVNYekREdTl4S05GaFdZQTRY?=
 =?utf-8?B?L01IYnNZQlVxUDVDNGp0WnFJbFlhTFVkMXNudjhXeWFCZTFwZEpTT25iNGNP?=
 =?utf-8?B?RGs3aVdxTVM3NTM0WWVaa1B0U0NvVEhiYnhFNXJaR1RMT0Z6RDVrbUNZa0x2?=
 =?utf-8?B?Q2xPNktCVW5ORmRPVkgwQU1HUzRzclE5WlhVNVpvT3VTcnQvZUo1akJvNWVv?=
 =?utf-8?B?OXJ6MnQxZ2xreVM3dTI0MFJ1OHBwVUFPTXUyNk9taGs5RWowdGZCWEVvVWV5?=
 =?utf-8?B?NFp4cmhOamhpUGg4Mlg0K3g2dHJPWmoxOW9tWjdEUFJ6MHpDZzdkU095bG0r?=
 =?utf-8?B?RFRUVzMrcFhJM1g0d3ozb3NyVmJ1VndhT0VLVTI4WmFFaUZtbWhJak5vY0ds?=
 =?utf-8?B?T2NmSWtFK2pNY3lrWitJcVYzZWZqNnpqMHZCUnozcUNTQitGMndHdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1fe034-a6b2-4b5e-d3b8-08df4aa1ae44
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:10:38.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwnDKCnRr1RRrZfL1o/qOUqR7JeKvd9xfT0rVvuwL6/UPWiEHGh6SeWKllSEdGHjQ6L2A6gR18V1SSQKLJdw0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

On Tue, Nov 24, 2026 at 07:59:09AM +0100, Andrea Righi wrote:
> When NUMA balancing migrates a fair task, task_numa_compare() considers
> the task currently running on the destination CPU as a swap partner and,
> if it picks it, migrate_swap() moves that task to the source CPU.
> 
> The task running on the destination CPU may belong to a different
> scheduling class: an RT or deadline task, or, with sched_ext in partial
> mode, a task owned by a BPF scheduler. Moving such a task is wrong for
> two reasons:
> 
>  - its placement is driven by its own class (push/pull for RT and
>    deadline, the BPF scheduler for sched_ext), which fair would override;
> 
>  - the swap is weighed on task_h_load(cur), but the load average of a
>    task outside the fair class isn't updated, so the decision is based on
>    whatever load the task had when it left fair.
> 
> Treat a task outside the fair class like a kthread: never swap it, but
> still allow the migrating task to move to the destination CPU alone.
> 
> Fixes: fb13c7ee0ed3 ("sched/numa: Use a system-wide search to find swap/migration candidates")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Vladimir Vdovin <deliran@verdict.gg>
> Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/fair.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5f420141c3026..fa0cfd48a133f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3223,8 +3223,14 @@ static bool task_numa_compare(struct task_numa_env *env,
>  
>  	rcu_read_lock();
>  	cur = rcu_dereference_all(dst_rq->curr);
> +	/*
> +	 * Only swap with a fair task: the placement of a task in any other
> +	 * class is driven by that class, and its load, which the swap is
> +	 * weighed on, isn't tracked by fair. Moving the task alone to the
> +	 * destination is still allowed.
> +	 */
>  	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
> -		    !cur->mm))
> +		    !cur->mm || cur->sched_class != &fair_sched_class))
>  		cur = NULL;
>  
>  	/*

Makes sense!

Acked-by: Balbir Singh <balbirs@nvidia.com>
