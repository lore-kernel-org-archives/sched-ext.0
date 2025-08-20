Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF726F2B6
	for <sched-ext@lists.linux.dev>; Wed, 20 Aug 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712358; cv=fail; b=LOp1PeH6Tz+VKQgw7zTK999MphETEdry9/N4Ni55H6Qex+k3D31DeVC1yp5oOQRhQRxcN7/x5OZ7bFuWptp+aRuOtqenw9j712v5/Gm98V2S/U/lPfFsZACadWSkB9KywJ8R+bk6g2Ck9Z4zroZBVusVNS9WbGDQhu0Kst5Xqcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712358; c=relaxed/simple;
	bh=cbu7yc6afnVzGOIUhkf1DmymJX2OfpvuTGv6QKuiBsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l01A1eMVfQviOtxXn5pROTWhsNg1Cq2ToxkKDQzRgB6WDHQ2lX3fpQiLDR0CZiHpyOz4AWnXDmdM5jsGAJ62Q+5WV7sKX2ZOCMio43xHU2jSyb2VrncIWlRJh7YEQK2b1QFcJPyCAwaaXl36ZBcpVnOcnn2Aj8KySGMch0UUVCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aMAO43OO; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aMAO43OO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLZC6qdvsyTz8Vk8W0jwgGRr1YcnjIwGYiCNtr++YiPSJqKZwzmwKCwAOBjv//M6RDx4iZrZonDuiu9tCDnYOT8fdzE5BPISyMKz/z3KBKTAxhOYLxL17bbTGwP7UMkYLd/qXfWI6sjV1D+pz196HGqP6HVp0F3oQ0YdkDn0c04wSRwWuP0y3BxXmPFBZUf0jePkPSOE62U0yEX6FWFj0f1yf2L7kpqc2a2837n5msPhZImT2no+oyYlDcRdLpyhItnjsr/I64ATvIZD1iJYQgYeXsUpmRaCFpAuY+9kkl6+vPKf7ZXC4trEoVG52l8kN7KfyLElycSZvNlhAwNCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDFsI36kHPg68y1IYERNeNq35stZHdOMUmWR/rKftqw=;
 b=bVi6fCht2TgAX5okPLxKFnUTdg+UMdzF7Og1bjyBVYEmDcSkN/mFOKWO3mSHNDBuzG2bdvJXrnjVBwu1I0BDjx8MKfl/puUT0fYloI4knXQlCWftxpf1Q5DeRQtRI2Z8VyGeSA5d7QtazdGt4L+qA4UyRjnIRAwGz7uzZw8Ss1s+Y9lqtMI9RVvvIlrv+ajHFS0lQAtoc1mtqP4HoMYDhH2mNnUAaebOx5yGLXJcBlNBvq3upTV4WThsqSEeBWXxrB2BI6GbHbAHnkkZkS2x7sd3+F6Z8GbxQVlPCMOsWLuKd8CdirmKsSbPywMpLu3D/uGXTT76E78wweOWw42OSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDFsI36kHPg68y1IYERNeNq35stZHdOMUmWR/rKftqw=;
 b=aMAO43OOhQJz70rEUak8IOCQ+ORdEdALsDANlyZpMRdDqbQ5CLKd1sHJG8y9AgRa4t+KhdHTLTtWa+UwGZYh5Vuf7bnfiVpmdECk5NLMhF12JATxdx0mmYPW8GjCGsLCe+S5pHtENe5L4tDdSfFilI0/q4Ae68VHuKV8AuQIdo137GJmXmy3C0wde8rYXWtCBk+T0+NYxT4cgjzqYsnZykgpy3Vv0Jq9RtswWEy29mtBbXmeZcYO/pWM1EMHiFwJV6fSs/Z+jXC0tDeud+I28dY0IQRrJX758e6CakDnmI9A4H5rzqvMDba2ns9UTdPgIEJEPK0MrtgF+oGziBEmgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 17:52:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 17:52:28 +0000
Message-ID: <b832305f-5642-4d9b-8694-a60ab7c4adc5@nvidia.com>
Date: Wed, 20 Aug 2025 23:22:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -rebased 07/15] sched_ext: Add a DL server for sched_ext
 tasks
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Luigi De Matteis <ldematteis123@gmail.com>, sched-ext@lists.linux.dev
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
 <20250809184800.129831-8-joelagnelf@nvidia.com>
 <20250819075714.GE3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250819075714.GE3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:208:35::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 481c4152-aa0f-420f-3055-08dde012547c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aER6aGxjZHZKSTNJRkExOFJqK3JGZ3J4cVd6THFGZ29sUm5PV1N3dnpPQzBo?=
 =?utf-8?B?M09tVEE2NzNtbTN2c3Q0dVBsaXZYdmFDT3FkS3JYYUVxeUw3aWpHZnVOcU1P?=
 =?utf-8?B?NkJ4a0dXRDdJTGtGV3cwRVAva3dLbXUvY3BFQmFXVDJ1T0NJNmw2QlpOdWIy?=
 =?utf-8?B?RlNUVFg2WkgvZU84djIxMzlHZU4yYnFabjN3c3phaWl4ZnZDMWpGS1NnRk55?=
 =?utf-8?B?V1hnWTZaV1E1azhJNXpyYTFqcUdWY0o2TTJhbC9TK0ZnMk9STEpuQ1RJNXFj?=
 =?utf-8?B?aWdMUExQdlEzdEtCTXhEdVhRalo1M0YvcStSZ3ZYSDFISkloUW9ISDBEbUVL?=
 =?utf-8?B?Ukx6T2Y1blV0aUhoQTZwUEtBeWJEb3l4VEd1TDRySVdXTjZxbWhnS05ITlVu?=
 =?utf-8?B?ckMwMVVlMEdnYjZhb3pFODZ6ckE4b1k5Y1VuNW9EZVZZR3pHWmdZMVZoSGpN?=
 =?utf-8?B?KzRHN2dVdHZESW12OTEyVFpUWEVFMEVwSmhUZis0T3hydTlpNUlDbzIrRmtm?=
 =?utf-8?B?a3JESHc0UjZRdmhhZGxzZ2NBd1l5VjhLT1hnRUZrSi82VnpmbFFoS2xIUzIy?=
 =?utf-8?B?RDVHRk94MmJheWVreE05bGh1S3dsbUw4Z3ZQSnZvdlhTbUdWbGg5M3NyTTlR?=
 =?utf-8?B?MEVRYU5YWFRaSEtYSkdMVlNLdkkwbXVJcTdYeWdXYXd1RmFlRzlvODExclA4?=
 =?utf-8?B?bzAwVUorc2VVQkFObHhzNG5UR2IwSUo3REVHL1ljektCSjZHNGVPWFNxcEk3?=
 =?utf-8?B?RU45czFjSmUzZ1FibjZXTHpLVWFUd2xOZzBoT1ZxbU9sRWlCdUk5c3duMGds?=
 =?utf-8?B?Vk1BNU9ya1doNnZXYTFZNjZwQ2h0c1poR1NMU0JOTUROemJJekRVa0oySkx1?=
 =?utf-8?B?dEFGN2tjbTdUWUgzTmFiMTFNTnhFTnI5RC93RUVkUGhzbEtsR2hhL0g3UzBl?=
 =?utf-8?B?d3J3bHRMaW1HWDN5UkVDdWpoTDNyOTF3blRDZFlBbWtnallPeVJZM3VSZDhx?=
 =?utf-8?B?VWFReXlPcHRHZDRsMW8xdWorSGpvOFlydFpGc3hOUGM1MURQbzZjcENFWkJP?=
 =?utf-8?B?OVplblVqOWg0Ukd2Yk0vVDBWbTBkYTQ4Z2d2Y080K1QrUSs2KzJKWVVNU2Ru?=
 =?utf-8?B?RXFPM0pHVmh1a3lMdmdaMFBtSHh1QzE3TmVST2kxbFJIdWNvUEVxUlpYMkh4?=
 =?utf-8?B?eWVzanNSM2prNHBFSkVMTkRPNG92eHNKSjh0ZjhZWEduaElucmVaelJBUzlp?=
 =?utf-8?B?b0ZJWlNYWmY4Z3VXdURLMzRMdnVYSHBmbFpPdlBJN1ovRk4vQXprVTJEUzA2?=
 =?utf-8?B?VVRNeFhaakdZM1VFYmVHWUlQQUdpTHYvRzdPWVEvd0pHT2RXWkxpNUpCMFNk?=
 =?utf-8?B?OFdBejJ5WDNtTVV5c3ZDek9UekJhNmt6dGd3WHVWNWk1SzA2U1F0a096RlNV?=
 =?utf-8?B?a2U3M1BPUFNZZXRRcEpMZHgzcU1jYm9jMFZ0WllsSUlqaXRJdWgrbUk2Z29i?=
 =?utf-8?B?QUVtN1FVbm5aL0VhQnpmR1pDNktqZVd1NHpKU0dWMGh5NEN6SklicVU5UjdQ?=
 =?utf-8?B?ZFFIK1g4bVJvVjhiVXFWMWFrSm5FR0djVmxibWhBNEZheUZrS3pIaXhIR2ox?=
 =?utf-8?B?NkRvZmR0RmJxbEROUGdsMUIvdGdURE1wNFRuVGlrS3VqQXlNcjNjV2U5RFhy?=
 =?utf-8?B?aEVaVk4vd0h2aFJWYUZmamRDanQzNmt3d21QSmF3d0pqTjJYeU9ycjRaOU5Y?=
 =?utf-8?B?Q1YwSzNaWXd6QVBtRnUyRmtsRDNFYUxSN09RYk02dzdXQnB2NWhDcHl1L25V?=
 =?utf-8?B?UjFjZlVaSmJSTHJLZkhTWVlhM0xxdmdlMG5kUHRCbGRqVTdHWW1XYTRncE1j?=
 =?utf-8?B?T0NmS2dISHlaemRTYXB1VDFuVjhrRkpTeHBtOFozeDhtcDQrSHJmMi8yMHZj?=
 =?utf-8?Q?rBUgnQxX5ts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1ZoV0hvVnBISG1RN2lNeC81bk1nSGNqeVl5NnhwWUY0eVNDZE52M3hwZ0py?=
 =?utf-8?B?UnQ0R1hJaEhDY0g2VWROWTBsL0NaNGRIUW1hU3ZZcWVGcm1iSkJEanBPdW14?=
 =?utf-8?B?Tmt5dGE3VXFBUmZIR3hQeWNrYTZBYW1BcUFDeFpuL1JBb2VNVDh4bEd5aHJl?=
 =?utf-8?B?TXEzYmh4WWx0NE9TTUxnWWczRmJwK0IyYWQ1enM5RnNNdk5zZ05JdFdNZVl6?=
 =?utf-8?B?RDhZVXN6akVJV0k3Z2UrNGQvbnJJM2lDd05rVmhFdnhheFRRVGphNlBYMzEr?=
 =?utf-8?B?VmpjekR4MktGNTR4dkJCUDFGS1NPS0xOa0ZVd040M3JjejZ6c28yaHdYTG56?=
 =?utf-8?B?enEzNFErbkVoZCtZNEhPY3ZSbkZtMUdQSlJoQ0dQTm1qNUFkWXpUNHhpLy9N?=
 =?utf-8?B?RG1NZG5sZkhJQ3J5QXc0c1VVYWwvZ3BBcGlOOS9iSEI5OVJBRVhNNHlOQUZ5?=
 =?utf-8?B?bGhacnpWS1k2VTdBeGFtNnFYMHdEeEl3aWlVRXNnSWFTOVQ0UklVMmhlTkhF?=
 =?utf-8?B?ZEpnZ0wya2JVZUxEeDVzb0FIeUJvUXRHSE5TYzVTV0tsRmZVQUdJOEV3SzZ5?=
 =?utf-8?B?V2srNVhUZ3FPV3pKQ1dTYSt0N2hYV1YxRHFQQ3Z3eDM2QjlFSkVITGM0eCtx?=
 =?utf-8?B?REZYY2VpOWVBWHJOMkxFKzlWeWhWU2UyaDA3YjQ1R25haDRyTnZjcjdRbzZ3?=
 =?utf-8?B?Z0xaZkw4ZFZXU2V5TVUwb1dJWE91dHVxb2E3ZmFydnZOdFVRb1ZSMWZmSVgr?=
 =?utf-8?B?cVMxVFh6MmlZS3Q4dVdHYUtNN0dDemgvRHBCMit6WDBML09uYlUvMEVKdlNo?=
 =?utf-8?B?NER2WGp6d2lyL2ZFNUtDRFdMaFZ4SGlTZXFSTk8xeW5YdzhSSG14eUtQZ0dk?=
 =?utf-8?B?ZkV2ZnlaTjF0RFo2UHVHNWVZRnYzM1M0blJqbUl5OXRwcHc2WDkycnRBSi81?=
 =?utf-8?B?OGZKNnhYUGdLQlZBaWZ3djlTRytucHBsa3VHVCtqZWVVdzZEQjJTbGRNdVE3?=
 =?utf-8?B?cVRKcUs0b2cxcmVRM2VpdHNvMGZtSk1veXVIYWF1WmQ3NkxrMEJDTVhReDdo?=
 =?utf-8?B?QXlSeVY2L3RFSjZmdmJRZG9venR2ekhmb3d0dGNJQXR2NzNCazFXNDZubXBR?=
 =?utf-8?B?azE5NHlvNGFpUG12d3hic28zODRMUmFIcWVGWDRtSE1CUTB3YmFNZGo2U3FX?=
 =?utf-8?B?cWJqdjhjd3FqcGNLSWpuK0ZzbmoxTy9UMVhtekViUCsvNG4vVC9Ibm84cnlE?=
 =?utf-8?B?bGhzdkdVR2w1MkFKNHV2QmZ6dGhiZ3FIRUVYVThJQmY3akN6N0dSQWFWVDRx?=
 =?utf-8?B?QWM2cGVzNnV3OGZUMnVHbUdrMWNNZkh3c1A3UURLekxnenFBSDIxRVZwSlBR?=
 =?utf-8?B?bnJabU5pWERGalBVejkxc1dLb2NPd3pNSWx1VWNkTGVub1haWnZMV2lid2Vs?=
 =?utf-8?B?UFE2VGZLNHZQNStyRzlLNlF6bEZ4cnk5WlNRdmtBaWZ4dmdKWFBaZkZNQ0Rl?=
 =?utf-8?B?VldlajlwQ1dPcXoxS1JIUTUzTUpwS0RzVnFKYm4rRHo4MTZFWXhvNmp5b1lr?=
 =?utf-8?B?NDlVNHhnRTdVcEx6QjFJVHpkVndSZHV5VjBVL3Z3Zy9uTzVxSFk5QXp3U2VE?=
 =?utf-8?B?VlE5UFhjb3YrdHVuWCtWTlNvdkJkV0duR2ZoRENkTDd2TDhaR0xIQUJxSk9J?=
 =?utf-8?B?U2w4aWkrb1RQV2JZS1UvSFR2Z2E5a1lySkQwdHBLWVRGVWpCREtIeUZkRHZR?=
 =?utf-8?B?cWtLdXRJK2tCdzlRVGtvb0xnc2hvYnFQZjMrVkJ6OGJtcllkUDZPN3Vmc3ZY?=
 =?utf-8?B?SVBTQTNVaDEyakpweUh2MWpPOEQwOVJrUUV1QUUrSWZvM1ZBM2thVXFudFhQ?=
 =?utf-8?B?ZjREQXhjVmV1NHd3blVUZnVPakN1R3RqOFQ3NEVhY2oxV3c3TnR1cG5UUm5u?=
 =?utf-8?B?SUNKZCtjSGFJVFNIdGE2cW1NckI5T1FMQWRKdlpUc1IvV3VFVmc0MWNRZWVH?=
 =?utf-8?B?UnNmK0wvN25vY3QreS92Wkw2VFcxS3dCUFBTV0pWekg1ZU00NVl3M2I1bnBE?=
 =?utf-8?B?Q2RlM244eHdjVDFRb0c4MkRDVEV0K1ZUZHhXOGRsS09wYmZSMXkyRXJsZHhk?=
 =?utf-8?Q?S2hufEtc9agCArUhRGpHedp1B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481c4152-aa0f-420f-3055-08dde012547c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:52:28.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA7BiWfGh632l3XQkubwbroYgiQD1pr/ln0vhIjoY2Ev/ZqK6sJelyNjqlcMFtUW31RCJ3ToFp4lI0SnBCZu9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642



On 8/19/2025 3:57 AM, Peter Zijlstra wrote:
> On Sat, Aug 09, 2025 at 02:47:52PM -0400, Joel Fernandes wrote:
> 
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -1510,7 +1510,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>>  	 * The fair server (sole dl_server) does not account for real-time
>>  	 * workload because it is running fair work.
>>  	 */
>> -	if (dl_se == &rq->fair_server)
>> +	if (dl_se == &rq->fair_server || dl_se == &rq->ext_server)
>>  		return;
> 
> Does that want to be: if (dl_se->dl_server) ?
> 

Yes, that sounds good to me. Andrea, while you're at it could you roll this
change in too? I'll pick up your branch once I am back from travel next week.

thanks,

 - Joel

