Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928392FE57B
	for <sched-ext@lists.linux.dev>; Wed, 18 Feb 2026 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403842; cv=fail; b=Ss9AYqxTIyUOB3wDLR/fno13JORQcFosPAw5TpTx5Ftwi/NZwfRvJJDVrK+5nWOUb6YPbcdKQcyehVd7UY34ZkWcQwCYkz4zfX/9pM53J+nKX+FrpjbUugePb8dvyNgsPOMb1u80Q9glEhuCJj0pUY3Cm1c9czglkUAmzxm9CuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403842; c=relaxed/simple;
	bh=qnpgYQvnOwWDypiOAR/pSqXhMuInWThIaE8vtAjZDzM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ad2aZ5DlERNvhVQ0C/zKUA7EtA9vggnB9AOr9yiH4NMhaGaoP/1fRTymajwq8mmuT/cVEdGMeuWfN1OmC7qGDGIitIU7fJSdO0u8HrsdoF7CNJ50x6vAZX3XA3DP1OGtHYZrnKmWC9KMyBkPgqYcuWtE4+b09PuaBecFQYROXxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hXMFFOpv; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXMFFOpv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhvfcZdDA0JizIjxMnQpLvILNhIFSfPhBgtC2zQgHTrVBK2Mn9SQmwMmhmcIQXIRyU00oqeoQrdrBbwLBvjPDHWnZ1ERMon/RhT9sSjgi9tJqGCLKafUIDqGmIHakbfjOoB6tkq778n1TASmpKYFWK/zkIPN7Uq1na7NRSov1cqpspgISlEoP0ZtKUtjbkvjtE0mZpZc/zQDCXm1RgNo5TplaBMhiudL7TXiQp0OAc9nuH5G6Itk1MvWnC+zR97UjzJYi9ERg3G5Z1R8Ti9oKXW3h5Rp4ewzi9knCOIDYb/oxrI4TC1XO8dogKHm6DuXCh7aRwEnqkMDeD/kSQR6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfcaHup9RNgIUvT2A0l70l0bEg6mhWXhDr203Wk3eW0=;
 b=HlnNk4/C1p+Ip2Hq4YjslGoZdAMYWdFEx581ElDfU6IakaxpFH1oModupMNXLS+LVBloL5gDRXz/SdK1LMz/tSelJBysenZXex54a8BKyCEMqh9pCgiZ1eemoZTLNvBf9s9dQheRtzeZhJbfFthWz26Sk9INGRaTryM1AMlX1MKPMdC2gxVie0elQJP2Lcn/0wznEaHWsKP8WCdEnuw0a8Nr2RisvzL9gPbQyu/xe9w9pOvmIHK93IME7nNTJqgFzcs6O7/qt+fSYIL0gvnBFWdPOOjzWkjv8uvp/hn67GBpCCZlcV5iuYfsNOvAosf91+f6YDUbwnP/lSgnRhK35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfcaHup9RNgIUvT2A0l70l0bEg6mhWXhDr203Wk3eW0=;
 b=hXMFFOpvJd2GjACTSrfOxfB8ED10xDNIVWEBCzLtwolZ8ovAjSzYimTySDjBFWRSyOD9nnR+NTG3gJB53jHGM5Ssf3rmtSt2cwDYW0wOZVg0lrbTzy5p5PV8cVM8ezM61vbUMnlzmmQUMOM2HytJi0U0TMkPaIsdLqSfT8gHl0DzoYA1x1IeIreNF6HjiPTKwSMeMqlUxuapFpGXJ92M+Jpu+5etgwmOORZxK/pw6GbS2h8OCZs0Ux6HSOxzz7n4fKUf6bMTrFumzLwMGes9q6L5i3E/hDuipKCZCPSx5kg+NeygI++9aseZJ+Qv+JrDUIrj+M/8jGK7koglJwNnPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 08:37:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 08:37:15 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v10] sched_ext: Fix ops.dequeue() semantics
Date: Wed, 18 Feb 2026 09:32:14 +0100
Message-ID: <20260218083703.22785-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0143.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 786fe185-9477-4262-201e-08de6ec8eb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUtnMlVTWGtGSEo2YXVybGJockYrTUNmYlorYkllaDZYRFpKcEVBTHQ4YUFh?=
 =?utf-8?B?NnZlY2lNY2ZxZ3BEeWNtcUhWTzI4NmJkcStaRkhiOGRYQkxGcEFZdGZaZU5z?=
 =?utf-8?B?MUNPZkJEQjlvS1h4SGFBa3dBRGZQT2xyRTlTdTJXOVg2MXBVU3VSWTlRTDBl?=
 =?utf-8?B?MjR6UnpHMjRiS2VaT0JubFJZL0U2aDJwSlhJT2NtZEZTZGhVbU5pVTcyTTZY?=
 =?utf-8?B?Vi9DNzlsNWpUK3ZyNmc0S2RGQVFIZ05LZWRoSkQ1S05ZNnN6cXFkbk9oYkh6?=
 =?utf-8?B?VHVnS3h1b2FmY2hSRXNvc0lvbW1yQ044cWNCM2JsVG0wR0hQM2VDNEtYWk9U?=
 =?utf-8?B?dFlpNis0eENudWVZWmVzNWQxbUJRTFh1S25Bbm5IaURqSTFxZE9vbFNLUldh?=
 =?utf-8?B?NVV3WTNzUjh1azZoNGl1TlcyRE50ekRhUVpkSEpnVnNlRzkrN2ZFaHBqdXgx?=
 =?utf-8?B?TmJ2Zzh5VE9kR09uMUIyRENJMEJVY1dnNVUwRXdJMUZUaHNqK0JyZlBIZHdZ?=
 =?utf-8?B?b3gzODMzVk9iL3dBWmlkY0dCcU9wb3NjbUhMMVdJL1Z6MUo1bHRhZlAwQjl4?=
 =?utf-8?B?U3lwUmF5VFBhbWZicjJxL1N0czhrc0UzZXVSdXM5K3d5bXQ2ZEljM21pdEgw?=
 =?utf-8?B?NjB0TFFWL0VQQXdTQ1NwSW15SmZtSWlVa2hFcjczQ1lzbDBaWU1qL1hiUU9m?=
 =?utf-8?B?RlE1TTMvd3lVNlZGRkFrUDh6QnJsN3V6bktMaXdYczBFdDBITlNRcll2R2c0?=
 =?utf-8?B?dnhzdTRUcWRycUhEVTBwdnppZlNqY2lDR0xVSjMxTk02SENvREZ3WE5oMjcv?=
 =?utf-8?B?ZlVMT3FIZEhRUUFNdXB6MHpFMHA1S0ttcVg1Vi9CcHZ1ZTZPdDBzQWdGYWZG?=
 =?utf-8?B?bVo0b3QwVG40Rzd4UURkTEw3RlUxMFNHa1MrUERIWW84aEF6eGZNRzcwRkov?=
 =?utf-8?B?ZEo0UCs3cDM1eHp2czhLTnVZdlFsbUgya3p6TC9YbVNZZTR6NWFRT3JMRDVW?=
 =?utf-8?B?Y3Fha1lXL0tFMnhZekNNTEY0bjkwM2JpQTdJSG9OK2JpOTk2Vmx5cmFxV2dt?=
 =?utf-8?B?V2FKa1A3bDJxOWNoajJDOHA1R0Q0OUNPNjdaOUNwWEZmczB6OUtMamtDL1lZ?=
 =?utf-8?B?ZzZsWU56K3JFc0g5TTNyNEp4N1Q4dTM2clBnZytuOUtIcmhNY2lVMThhTHhM?=
 =?utf-8?B?WFpWa3pOMDFOVzB0YnBMdHphdFhBNUZWTzFWOFVjWGMrZXdmOFdBWXlZRndi?=
 =?utf-8?B?M3ZXbllHK0pRZjFNSVdBcElsTU1ya09hSXRudkpHRmpaRE9zUkRhTVpRci9x?=
 =?utf-8?B?bVFoTWhTQXBhT0pUaDROQTl6R2xXQkgwOFVBVittbkVndzVQRU5YWHA2TVZj?=
 =?utf-8?B?bXhtZ2xxcGNjREhnd3dKQWFHY2JmMnkydVI3cHl2SFBTMVNDZ1owVkhEMTRL?=
 =?utf-8?B?VTNaV0k1ZHhCRE9USTZVd0RXVDYzT0xWUyt1RStOZTgrenZpeDNzbVlHdlNh?=
 =?utf-8?B?MElja0JDMjRIS2EwVS9yalg1OWxzSU0zS1pSV05qWkM0RXRaM2hMa0pTSlR6?=
 =?utf-8?B?UUVnUHhmSVVSUmZDTWhpQkF2aXlYQndLT0EwcjlzZWErWlpDZjlHN1VUdXFB?=
 =?utf-8?B?K2lMS0E2eUpqUDlaNUNNWlMwUjBZZXVqWEtXRDJ5L3d3d2twYlppcDJVUzVX?=
 =?utf-8?B?VlA4eUx0b1l2amhvSWpBRE5TWkhMaXdKdnUwTGlNNGNickJPenl6SUV4QXhx?=
 =?utf-8?B?dU9ndlJ6MzEydXVnbTdJcmZXZ3ZuQjBzd3l5OGsrMjJaNGthMWNTbFlpZS9s?=
 =?utf-8?B?YmoxRXFFSm93RGNBeUR2Z0oyWUx5cnpmOWV6T0pxZS93azljUEs4U2Jzc3Jl?=
 =?utf-8?B?T2xIUlVTZmc1ZGc0MituNDhUL2xteTI1bmhSQlAzU2U0SE4xekcvN2VrdHlE?=
 =?utf-8?B?NFk5OEljVmFrczNKcDB5d25hZUwyNXMvVUxNRWpGajlvSXhXYmRUakpwa2l6?=
 =?utf-8?B?bEJ2RnUzNEYxdWJ3dk5abHlFTDF1c3pwcVJxcTFITllnN2huS1ZEY01iaEh5?=
 =?utf-8?B?RXNZUTFzUFEyOGtYVTBHR0t0ZEI1aTRZanBteGRmcTg2WWlGaEZUUHMyOUJm?=
 =?utf-8?Q?Bn4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2FUL0Q0VmRBbFRrNVN3TmZOUG5BVXg1b2t2cDJqTjFrSGJBbmw0NDlZbXJ3?=
 =?utf-8?B?UktzS3lsTlVjSmVLcStkT1hyd2o5RUxURFVIT1oyc1VHejU5ZVoyUk5Fa3dR?=
 =?utf-8?B?Q2RBbFFERHQ3NlV2dFNVSzB6MSthT1FkUjJYdC93NXpGb0ZMbHJKbkN2M0FM?=
 =?utf-8?B?djl6Z3lUQ3pHQTZob1Jqa2xERHR6MmxLWU1zVjRxWERuSWJRcFg5OHl5NnZT?=
 =?utf-8?B?VVlvMmRzNXFtNXczek4xRUVuMmdjdUplU0NSTzNzWjUvTUcyY1V0YVltZGg1?=
 =?utf-8?B?TEU1RDNKL0N3Rno0anowUWZpdEhIcnlFMDVrYmt3VG5BdnpUanNsQ0VEbnZD?=
 =?utf-8?B?MDgweWF4TWxXZ0hnSjNNVzVlSVhGa2c1QlRCL0E5MXBObXRyUm43N0lFdGxV?=
 =?utf-8?B?bGtyNTF3MnRoMzljZDBhWDNHV0t1Y05iaXhyb084bWVUQlIrSkNpRG52NWxV?=
 =?utf-8?B?SXRMbmZwc3NYOFlEWU9zY3IvR2NEb0FBVVdPaHdWY3dGamtXL2NNV0Y2c2hk?=
 =?utf-8?B?WDVFWU5EdCtzL2NjTUl0Yk9pWlR5eFBDdEpYQ3lyKzFJaDVkS0FqREgzYnEw?=
 =?utf-8?B?R2w4MGNsWmhTS3VBME9PQzQxd3JoS1kwbnFpU09MdXEweWFoMHpnYmM5cEtD?=
 =?utf-8?B?dTJvVjREVTFMejJhUDlQV3VrWDYrNEltQmVTb2JGK01qWUgvdmFOY1Y1TjBn?=
 =?utf-8?B?dVh4d3U2cG90WVBPYTZvcDMzR2d1eVdzak5mNFdpSTRzSEFLWm5QRDJRcG15?=
 =?utf-8?B?UFVuQ05CTGFOMlVUOEFuWk9BRUhsbHk2YnVmSU1uWW15aXlGNFBGbm5pbWQx?=
 =?utf-8?B?bitlbnhYdEFJOXlqOVRabEwxRTQvS1NIbzM2dGlmUy84VERSN1JDTTJXeHVT?=
 =?utf-8?B?bG1LZCtwMGRFRFp1SHg5WjNqWVVmVzRscXNyVnVKNVRmZlN1Wk9tNGRwT3V1?=
 =?utf-8?B?SHBlMGRnemRtUjRQUWhhWlpUMUE4NGZiV3JtcDRWdEpSa2ZDUit1ZDdIejBr?=
 =?utf-8?B?ZnVnNWt3UzVzeFVBcXVUaFpEUncxY1NXa0l4aUxRQ1g4bFNqeDN4VVN1Nlc1?=
 =?utf-8?B?VlkreHBrRjJXUk1rQXhNMmJ2Z3RXNjI4OUpobW1NaGNaa2NIZXVCT3I4YXYv?=
 =?utf-8?B?bnBSSkJvM3FYSXB3VmZLU1RYRU0yOGl2TFo2akZBRVpiemN2SnNjZ2tSejZD?=
 =?utf-8?B?Ums3NDVJa2tUYnpMR2F0aWl3UTlianRwa0ExTDFGczBYWnFqWjdOMmpSS1pn?=
 =?utf-8?B?NWs3V2t0dHZrVHZYc0JXcU1oUmltTUdIazU2dVVrUGRKbnVKV1pwamRiS2VY?=
 =?utf-8?B?Z2NvekJSdE5GL0gySWo3RXRKRDVqbzdSN1p2ZXU0bkxGYkU3dVpYbGxYcDlu?=
 =?utf-8?B?ZnpWYlhSUDF0SEhPVkV2bFY0UzkzL08zSjl1RlNIL2Q2MXVYVlJ3MDNjL1lP?=
 =?utf-8?B?M1YwQXZ6a2pMcGNWSWJxYjNyQlZzVC9IOGVnUU4xUXlxaFN0aS82NFBPK1N4?=
 =?utf-8?B?RVJRcmNyQzF3bFpER1FmYXpqYjlRbjRYQjhZZ0YwVnVNdFNDeDZYd0hRcFJQ?=
 =?utf-8?B?ZTlQVlg4dG5TSVlxbkMzUzBTSXBOV29DaXl2Y3ZZM01qVU96c2VXbDFoV0tD?=
 =?utf-8?B?bVYrRWVLSGtsTTIvMjlHamd5bHFVTmlXQVZ6RjMrU2xwZzZhUVR5YWdVMHNK?=
 =?utf-8?B?Rml0M3lVQjZhcFExSDZVZXVPTmE5NFJHSjBaalFVSjBReDNxeGgvSW4rNVlS?=
 =?utf-8?B?NWZzM3BNK0xRU2svbW9xQlRXNVIxZVptUFkzamY0OW1WK0lxSWdUNG5jNG5j?=
 =?utf-8?B?VVVqVHBaelZEVlFwZWJZaE1OSUZkZG5lNS8zUVdyRThqWk9ROXFQMm0vVFhU?=
 =?utf-8?B?RDJwVmVnai9XYTVMY2R3bWczMjFKa1g2MU5wRmw0Nlc5bTZVMUpjdjdzblJr?=
 =?utf-8?B?bjNsMWhKTnVCVExRWXd3czNleWo0ZENEdVVLUVJMQ0svbVVXeUxKT2UvU1Rz?=
 =?utf-8?B?N3RzQXdsRHQxRjE5MU1xcWR1b2I1UUxaRUtyVDRKeVZLYXpEUjc4YkVVYXRJ?=
 =?utf-8?B?WHRhN2dPdFJrcTljcDREbllkQzVtQ3A5MHRINFBuUnZoUDYzaDdSakRuVHVq?=
 =?utf-8?B?U2FsbVZJeFVTMXRvZHZJWDFIU0ZWQzZQT0htckd1TDREUXVtWTl0L0NVTEFK?=
 =?utf-8?B?MEJiWkQzc2VtMnNEU2g0a1ByNzIxWENnNTRFRVAzTWRzS0QreDEvcXRDS05U?=
 =?utf-8?B?NWkzd1Y0ck84TVlZdFE3enU5SWNPbmRla2NOM3lsNUt4ZVV4cGVFUXJGTGNi?=
 =?utf-8?B?QTZvTHJYeEkxWmFBTkh6L0dzZUdUV1ZNWnUyeXR4MS9nek1FdWRkUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786fe185-9477-4262-201e-08de6ec8eb05
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:37:15.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUwfU+y8lptroCB3YEiFO0iX7UUDLleEypG3XWtg0iSGWAtoInN5Tu4avmihwMkvFeI8thzkaT0pwi90doLGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510

The callback ops.dequeue() is provided to let BPF schedulers observe when a
task leaves the scheduler, either because it is dispatched or due to a task
property change. However, this callback is currently unreliable and not
invoked systematically, which can result in missed ops.dequeue() events.

In particular, once a task is removed from the scheduler (whether for
dispatch or due to a property change) the BPF scheduler loses visibility of
the task and the sched_ext core may not always trigger ops.dequeue().

This breaks accurate accounting (i.e., per-DSQ queued runtime sums) and
prevents reliable tracking of task lifecycle transitions.

This patch set fixes the semantics of ops.dequeue(), by guaranteeing that
each task entering the BPF scheduler's custody triggers exactly one
ops.dequeue() call when it leaves that custody, whether the exit is due to
a dispatch (regular or via a core scheduling pick) or to a scheduling
property change (e.g., sched_setaffinity(), sched_setscheduler(),
set_user_nice(), NUMA balancing, etc.).

To identify property change dequeues a new ops.dequeue() flag is
introduced: %SCX_DEQ_SCHED_CHANGE.

Together, these changes allow BPF schedulers to reliably track task
ownership and maintain accurate accounting.

This patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-dequeue

Changes in v10:
 - Rely only on p->scx.sticky_cpu to detect in-progress SCX internal
   migrations
 - Set SCX_TASK_IN_CUSTODY only on the non‑local path and only for
   non‑terminal DSQs
 - Centralize "call ops.dequeue() when leaving custody" in one place,
   call_task_dequeue(), after the task state switch
 - Fixed a p->scx.flags race between dispatch_enqueue() and
   dequeue_task_scx()
 - Add proper synchronization in the dequeue kselftest to validate the
   usage of SCX_DSQ_LOCAL_ON from ops.dispatch()
 - Link to v9:
   https://lore.kernel.org/all/20260215191933.2358161-1-arighi@nvidia.com

Changes in v9:
 - Ignore internal SCX migrations (do not notify BPF schedulers for
   internal enqueue/dequeue events)
 - Rely on sticky_cpu to determine when a task is doing an internal
   migration
 - Trigger ops.dequeue() consistently from ops_dequeue() or when directly
   dispatching to terminal DSQs
 - Add preliminary patches to refactor dispatch_enqueue() and mark internal
   migrations using sticky_cpu
 - Link to v8:
   https://lore.kernel.org/all/20260210212813.796548-1-arighi@nvidia.com

Changes in v8:
 - Rename SCX_TASK_NEED_DEQ -> SCX_TASK_IN_CUSTODY and set/clear this flag
   also when ops.dequeue() is not implemented (can be used for other
   purposes in the future)
 - Clarify ops.select_cpu() behavior: dispatch to terminal DSQs doesn't
   trigger ops.dequeue(), dispatch to user DSQs triggers ops.dequeue(),
   store to BPF-internal data structure is discouraged
 - Link to v7:
   https://lore.kernel.org/all/20260206135742.2339918-1-arighi@nvidia.com

Changes in v7:
 - Handle tasks stored to BPF internal data structures (trigger
   ops.dequeue())
 - Add a kselftest scenario with a BPF queue to verify ops.dequeue()
   behavior with tasks stored in internal BPF data structures
 - Link to v6:
   https://lore.kernel.org/all/20260205153304.1996142-1-arighi@nvidia.com

Changes in v6:
 - Rename SCX_TASK_OPS_ENQUEUED -> SCX_TASK_NEED_DSQ
 - Use SCX_DSQ_FLAG_BUILTIN in is_terminal_dsq() to check for all builtin
   DSQs (local, global, bypass)
 - centralize ops.dequeue() logic in dispatch_enqueue()
 - Remove "Property Change Notifications for Running Tasks" section from
   the documentation
 - The kselftest now validates the right behavior both from ops.enqueue()
   and ops.select_cpu()
 - Link to v5: https://lore.kernel.org/all/20260204160710.1475802-1-arighi@nvidia.com

Changes in v5:
 - Introduce the concept of "terminal DSQ" (when a task is dispatched to a
   terminal DSQ, the task leaves the BPF scheduler's custody)
 - Consider SCX_DSQ_GLOBAL as a terminal DSQ
 - Link to v4: https://lore.kernel.org/all/20260201091318.178710-1-arighi@nvidia.com

Changes in v4:
 - Introduce the concept of "BPF scheduler custody"
 - Do not trigger ops.dequeue() for direct dispatches to local DSQs
 - Trigger ops.dequeue() only once; after the task leaves BPF scheduler
   custody, further dequeue events are not reported.
 - Link to v3: https://lore.kernel.org/all/20260126084258.3798129-1-arighi@nvidia.com

Changes in v3:
 - Rename SCX_DEQ_ASYNC to SCX_DEQ_SCHED_CHANGE
 - Handle core-sched dequeues (Kuba)
 - Link to v2: https://lore.kernel.org/all/20260121123118.964704-1-arighi@nvidia.com

Changes in v2:
 - Distinguish between "dispatch" dequeues and "property change" dequeues
   (flag SCX_DEQ_ASYNC)
 - Link to v1: https://lore.kernel.org/all/20251219224450.2537941-1-arighi@nvidia.com

Andrea Righi (4):
      sched_ext: Properly mark SCX-internal migrations via sticky_cpu
      sched_ext: Add rq parameter to dispatch_enqueue()
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics

 Documentation/scheduler/sched-ext.rst           |  78 ++++-
 include/linux/sched/ext.h                       |   1 +
 kernel/sched/ext.c                              | 164 ++++++++--
 kernel/sched/ext_internal.h                     |   7 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 394 ++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 274 ++++++++++++++++
 10 files changed, 890 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
