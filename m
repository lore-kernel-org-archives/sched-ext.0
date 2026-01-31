Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF9378804
	for <sched-ext@lists.linux.dev>; Sat, 31 Jan 2026 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769891231; cv=fail; b=RHlifqGUEqkiL2vaGLR1mGkHOVccUedkY5K2whYLdjcG/euOrt53g1A5ono6RvG6+zzUYgleA8WLp/ty3EeYFiVGqxxOEHQf2qXwy1SCQTRlizUwAUQI1gheujPKY2xN//kj6xOiJ8vyW7/Y9UZ1NdOvstsvqeV74aFTfdDh3HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769891231; c=relaxed/simple;
	bh=rnLdeDdawu7KLxrUprNtUvQRsu+jNY/Qqg7jCSrTFCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nka13019l51ABcYJUvOviibEceG8ZjDXDaDIEzjb+nA1ouHSMfkZeAxBckmANQfCLQU2KS+z9S88gbusCdF+9ndlI9ci9z/u9/3Z55IUwHlaG3jKifCzeNSYluZDCDhNYaE2YVr1s2SrG6/DLcyonLGm1kGJhRHBUa1RVmWfsVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rix6/rpX; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rix6/rpX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvWx5CaY/26IRFnjVnlikdoJzM7Cz+XPUZN2uke69lgW+rr5UaVsc2kwzyFdozpgTKLKShsXUsZIBZqhGIDG81bO/Dmw/2nnL66nTXuwvo+4rfw2wdnQvvuC3l4HG37+7TqEKjCJuQQLz5M57x+bEd5OlBDDuQn5WnzgxoyLEJm0H/e7KSW1CTDEeXi7DCVefxegMgwpkQu8NYokzyjlYEnky9aAc+qnQfbYzkbL37x60aiNBM/vPb1amnqXgYcplu29VjRyXxPuxQwz5y2mv+9UsRKhb2LJHrUNzwzANboPA3mM6AHeJrU5Uh4twpn7/QTk507XTvFFyocP9G6rEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90SjdzDOQQZ88guFUryOqLKmc4oAGk8xFq1oNR6YOKA=;
 b=u43H71fuZUFhdNsyBMoVMakkl8P6js70aiGMTI8VSXKwwy3ejm0Hj31X3TFHIl4owKMxxVJEvlwQUjQiyShmQhpsGsDedPXmif/OQkM2AduWp/RV8YygXo7KwK0aIh96XTAmRXfm7GjuDLjJUcT9gkBJ8siwXBhTQxzbBwjkKMFY4JmpJS91JA0R8yPlHHV8kTs4Xj06M0CA5VllLK0aVuP3ShocH9y6H0p1RojKQJQf7EPIzbAoywxd+a5VJD3NnrWeB2dmx+LCCATBMEhLGhjy8/HbaTdTWWQ5BroWDBc8SHzUYPf+DzeSSFg3CjcVashhJp95XtSgTAifoprLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90SjdzDOQQZ88guFUryOqLKmc4oAGk8xFq1oNR6YOKA=;
 b=rix6/rpX05kOYSr4zfxkoxFSRyvgQONvTw/28l4LZdLdhcjmzY+ou6E7+VrGfOD4WncHen+c3VuUjOn8gg5aRa+KeJkRPe7KIJqGovpFlYI8Mc1SvZhV65AWkbnTIlaBaWuL4egN7RB145MiMlFHMwEq8e2BYpHFXfvP7YlYHfP63eF6AHJdrvpVc4Kq1qs0K4aA7X7wfk0RLITHoQxSIU9Cidoo+T3suAUaBmDkT5y3mO10PbwnrRPETh0TGEtEBdh6UX4ho5vMQ1ZA7tRNAZPIJPLfWWwQOkjqcCxlbqNmOAqfNmcaa7KDLmBAArLzggL2AiHqPTOvXDnf8/FxBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Sat, 31 Jan
 2026 20:27:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 20:27:01 +0000
Date: Sat, 31 Jan 2026 21:26:56 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aX5lkCVr9uU78DxL@gpd4>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
 <aXp9xSpYhaysBLQ2@slm.duckdns.org>
 <DG1WJEB6B0AC.151EBIUYXCR55@google.com>
 <aX3FG00RNMv8VnQQ@gpd4>
 <DG2YT5LJFC9T.AXB2OHJBQG4U@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DG2YT5LJFC9T.AXB2OHJBQG4U@google.com>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 9202cc43-77f6-4fd4-b8f2-08de610716ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG54RlE3cFZITS9INVUwOFJwTmZZa3VVaG1IVVg1QlpaNnRjY05KeDZyRzA3?=
 =?utf-8?B?Q0txRFhoVDJudGVhZXNHS0lmOUVHbFQwQUZyaVhGa2dUM3NPSXNzSDlkenU4?=
 =?utf-8?B?dkFtVzc2ZXJ4OGtsWDJyWjBzYTNjemZKZXFKR2dJaWUyTVNmb3lRNUJ5YWhi?=
 =?utf-8?B?OTBiY3ZyaVFIL2FOejJjQWlMVEx4dWRXOHhqNnVkeEJHVmtQM1R6ZExyVFVy?=
 =?utf-8?B?UEZESkJNZ3lEYmdkOGhIcEpHQkFkaE5XTFZ2bk44OFBRNXBNdUFPY3VkRXZN?=
 =?utf-8?B?NW9ZZ0h4WldZcisrdGNrU0c1Vkh3bENCdWV0RTVkdGtYeFhVZ2ZldUxiK2o4?=
 =?utf-8?B?VGJPc2szQWNUNEFZUnU4WVBpZmZLWVg4Vmlod0xscGVMUUQxRjJQZzk5THlP?=
 =?utf-8?B?Q0ZQclczTmtGSDgrT09pRUVlZkdyWWNicEc5UnliQjU1RFpVL1Y2Q2o2ODZZ?=
 =?utf-8?B?WndkRVNuWHBCSW5oaHBvQjBnMUxMNDlheU44MmVMclhMRW03ZzEvZ1U3bUpM?=
 =?utf-8?B?bTVCWlRuVG1zWnNKbmRReG1CeDhEOHc2UVo0MUNsSWhIZEJFNGp6QzFhalVR?=
 =?utf-8?B?N2srWDhnbmhDY1dNRmR4VGJVekhXeDhROUhVampuRmdVRzJBVEdCeHVnQlN4?=
 =?utf-8?B?VkpIcjR1ZmlYZXNZOU9IVHB1UHk1SzdwY3JjcGtUTFRPeFBSckdPdGVuZEZ2?=
 =?utf-8?B?MHY5clRjRENJZVB0Z3hWNHoxUG44Q0ZNcmtJSnR0SGhaaE5XS1NXMDA5NHVh?=
 =?utf-8?B?SjJNMU9BUDZiRzJqU3F0Vk1Ga3VxM3JpbFBzaWxQT3RGd0ZINVYwalR5TC80?=
 =?utf-8?B?ZGlKTXZkdmxCWEhKamZaU0hZMUQ5MkV5eTNpSWlJWE5FR0kwZUxvenVuaHpZ?=
 =?utf-8?B?bG5mSnByOU9ReEljREs2ZGJQOHNYSC83RkF2ckZHa3U3alowMnNONitmVDYx?=
 =?utf-8?B?ZUFaOWhuMHZaK3NJSjRZSk96ajRFYkplenl2OEZUcjJuODdCd0FmTGpqU0Q2?=
 =?utf-8?B?MDJUSHdUMm1xR3k5VGh6dUtaQll4SVM1aWxFa25PRmRKWk9IRjNyZjYvMTB2?=
 =?utf-8?B?WW0xNmpmbnlQaFBRd0wvd0M5dmY5dXY5MFBYMEptY2M1R0toS3ViRUlYL3Zi?=
 =?utf-8?B?RmFXeDdjZVBmNjErK3k4Mnh2cnhqeVNWQXdlR2pqRDZDTCtkZU1lZHBXNE94?=
 =?utf-8?B?YzJWa2FkSkV2QTlNREtIY1h0THdKV2F3Uk5iaTM5bUVoRzFHcU1Lc0ovbS9q?=
 =?utf-8?B?MFAvd0pHcm8wMnI5UGJyVVovbjlWRFk1cDRON2wvZnhTSHRkYy9sVXhiM1Vh?=
 =?utf-8?B?NWJVREpDVTNKNG4wY0Y4M1lKWExoaUtDZFFsWit4b0wxZjFVUVYxNlFoczBV?=
 =?utf-8?B?WDBPbUlaeVUyR0NnUlZrMG9kZ3FqZmM2ZmlRWWhzZU1YSmU3K1N1NWMxNUV1?=
 =?utf-8?B?RlhzYS9NQUxQMEFFMVhkNXRJNG9QRXNsWGdmbVJwU1ZpMUQzakRqTWw1cHU0?=
 =?utf-8?B?MHRoVVdrY25NYThDM3N3dmp6c0wra0NJNHQwc29OZnRqY25nV2Nwajl0U3VX?=
 =?utf-8?B?NTFOZnJQenVKeTgyV2FZbURxc25qNTFmTWhQZ2lYbnNQYkV3dE94d0FIeFRS?=
 =?utf-8?B?VUo1dmd3YzVkZ1h5aUxEZEFTZGF0NGJ3MWhreEZvcnYramhTWTNzYlhsVTNP?=
 =?utf-8?B?RnU4QnRhSzVoZ2RaZHJTRnhaVjdKV1l1cjBscVNodUR3d3JZUThYd29TSnVV?=
 =?utf-8?B?bFlsMDMyU2JyVld5c3dFdXY2WUJWZ1ZxaGt5VXl3dzEzdjd4MWlULzd0OFov?=
 =?utf-8?B?Y2IvV2d4VkhVWEUrbXVha2dJNnRENkdwTnpKRlJnYlpwT0p6dHkwQ1doQ3Iv?=
 =?utf-8?B?RkFmRFRURXpNbjlEbmd1TldFd2hCRUNNQjkxOEcrR0VEY3ZjekZtd1VESmFE?=
 =?utf-8?B?cUh3dU8yMktBNkFYRDJvNGczeU91bnM5OFdvUFZtZkpkbm82VzB1UXg0NWJR?=
 =?utf-8?B?M3BGMHZIcWRJVTVKTDd6TXlYRWwrR25TdnhudU0wczhXSjd1NzNlL1d2b0dM?=
 =?utf-8?B?ZlJPSXRqeEFkUFFvTk9hbFhROTZERHlxM0o5V2dheHFDdllVM3krZXF5cUVq?=
 =?utf-8?Q?L/k7r+jJEVGuGunuPPb8+mDun?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFltOSt1aXZaWXJ4RUpNeWxiZTNUd1dRTHNMOEZCdlhZY21NbXNyNS80Y1k5?=
 =?utf-8?B?YlJ6dytrNFJBaG95WUtCTHlXdVdybko5RGVCdDdUWGJMRHBza2ZtVzRMbEtp?=
 =?utf-8?B?dFlrR09ZeEpFOCtNMEpueG9OTkQvWlQ3dlVTTTFSdkFMZ1JGTEZCaE9zQ28z?=
 =?utf-8?B?dmZBZUFHQ0JVSiszdktEMjB4YlFWNFJMT3ZGaUJFRDdweGtSSmJoOEFjbVBO?=
 =?utf-8?B?VjhwWnJtWFVZelA4RDJrMm9VcXlBVkNGa3VGcDlOeXZMb29GSE52T3VEYzY5?=
 =?utf-8?B?by9aazlEemZOWks2SlFXeUJjWUdEY09NWnRjSTZkUjZOejhPOEY2NWVEaU9o?=
 =?utf-8?B?YytsR0xBaFI2MzYwWlB5V0RRSW16QlVUY0FkNldJYVdGajBFbXRzVDEvTjVo?=
 =?utf-8?B?akhTSU5TQUtjblJJWWM5VWpvR3lNYmR5SGc0VUk4YWg3dTR6d2c1ZmdBaVJN?=
 =?utf-8?B?a3FFMUpyN0JzNzBsemo0bWNlUll4K01rVVc2NC93MS95OUVHblp6a0owMUg4?=
 =?utf-8?B?WFdsM1VtSmJCV2owakFYOW1uS3JWRk1Mcm5QK1FIdGRvT3hiR25VRmtQdHBU?=
 =?utf-8?B?NFBaTlg4ZzVQTjVySE5nYlpJVEVXZ042OFg2WjhoZW5ETFF6dm1yQ0FSRWNJ?=
 =?utf-8?B?dW1rVFdJZ2ZXT2ZTL2pROXNFMStpVkFzM1U3dldMRWU2VThwZXc3L0dYVkNo?=
 =?utf-8?B?RHpEWHVrYmtFb0VZdjlWdU1qR05XYmN3dTdia2V1WTVYN2MzQU9tZlRxeC9k?=
 =?utf-8?B?NkJVUmg4eTYraXU4dDRORldQZ2RiVGJPWmIxU3pZdm9Ld2RiSzg1MW1Nc3Np?=
 =?utf-8?B?akFEUHVhbkRvL3F6N2kzYlhXYzJ1L05ZNU1iT0UvSVhCenp6RlZGRlE0ZWQ2?=
 =?utf-8?B?TC9PWEFsNGZOdUZxMEFRZStJL0tlc1l0dHgzc3krRSsxLzN6ekE3a2docHRX?=
 =?utf-8?B?T2pzQmJSS2tBRWtzZitHNlR2aC9LYkFZL0ZTc2lDcmI0bE90U3hJMTV0aEFl?=
 =?utf-8?B?Sm5QK0pjRUlEZWFxZ2wwK05XK2xhZGJCOStkZ3g5N1V5OXBHdEdjTVFTeE9n?=
 =?utf-8?B?ejJhZFc2K25hQjhtS0thMEVmMXp5QUZQekVEUjM3SXMyM1RjcDdEa1lhem5Z?=
 =?utf-8?B?MjlMdEVHbTA0WExsY3o4b0JOcWp1OWxGMVN5SnBjYU01YkFKYWtRQURzbmpW?=
 =?utf-8?B?Mm5pTDVXeFZKNFM0QktYaVJwNmdYcHFlYm1MRUt1dlRybVBFVlNLRFYyS1lp?=
 =?utf-8?B?NllndlZJd0NncGt5WjIrd0owbmRPNVhLUGRSY09GNkd6dXdoM1lheG5VZUtu?=
 =?utf-8?B?SWhIM1NzRWhVNkMxUm9YOHRPU2hqTjkwc1BCRnB6ME81djdvS3dpcndPZGd5?=
 =?utf-8?B?STRWMThESFBORUxxTHJ5YW1JaHVrSTVKYU96YzVRMjJQTFlEU1lZWTc4aXVD?=
 =?utf-8?B?Unhyby91T1ZGaXduSDFhK0lkWEpLeWxzR3o3QUFBMmZ5QkNYeHFvdDNlSFNX?=
 =?utf-8?B?c3dTTjNZSkg5OE9RWmczK29IM3JPbzhDQ05oYTV2UTA3MmxkaWtsTkdFSGtQ?=
 =?utf-8?B?OFh4Um42YUZiOVMrdjBpQ3pzUjVjODNWOHRPeit1d2NLaElOdWlrajB6RmFQ?=
 =?utf-8?B?ckRkODZZc1BiVkw3bVZ5anZqN1lBUWNhTHBmeDNCK1pBaHBxRFA3Wk95RFdr?=
 =?utf-8?B?K09TYzhqVk9ZdGRReUxFZ2RwTjFpSytvVXlHNksrY25jdWdGS0ErVjJ4MWh2?=
 =?utf-8?B?U3NHZFFuVHB1WDNQb3NUYWRNRVVnbGd3Vk5RVUdFNWE1ZGpnMkxxV2U5ejV4?=
 =?utf-8?B?b3BQTGNVa1BicEs3bVo2VnMzMG9xVUNaRG9ROVR0MHU4V214WTVrS0ZqdVlh?=
 =?utf-8?B?Zy81UHZNUGQ5djhld3FpcDRDd3NwV0NVSEdUdTNCL1FnUUZaNEY0LyttUHZY?=
 =?utf-8?B?cWNZTFZFTEFCQ1kzVFdiZmFWTHZ0NlVMRHJmUElHQUdFMEd1TjhyeXFuTklS?=
 =?utf-8?B?SStaMDFLMGlubjdjbUZxSnBVcitwWUFyb1E0WGpnQ3BRRGF3RVRTZW8vaDVv?=
 =?utf-8?B?ZVZyeE9Pc24xUi9HdWd3ZERJc3NPQjZFSmQvb1YxMFgyTDlSK2c0TlBIZzZ1?=
 =?utf-8?B?NFVobjZsQnIzNU5IK2RJR043ejl4NW5rTkI0bzh1ZUhKRHBSL2VzN2V0Uy9z?=
 =?utf-8?B?YW9UMzl3N1Z6K3BncFltK0J3YkpiR0p6WTdUbEhEOCtjNGNSUForK0pveUpS?=
 =?utf-8?B?R3hsRWFoNkFFaWJuT1kzZjJ6dVdkT3UrQzBjbGJKWHIzWEZHYlNOV0xHTkkw?=
 =?utf-8?Q?JBe9skOWGTn8s2VcXA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9202cc43-77f6-4fd4-b8f2-08de610716ec
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 20:27:01.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZQvCIjK/G6iQR5UrVh3ZV7tgpck+xvv8w+t2Uu76VJAaFHh3HmZQtqbGHtpEnzGrTtQFt5pDvHkrCIB7k1tDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122

On Sat, Jan 31, 2026 at 05:53:27PM +0000, Kuba Piecuch wrote:
> On Sat Jan 31, 2026 at 9:02 AM UTC, Andrea Righi wrote:
> > On Fri, Jan 30, 2026 at 11:54:00AM +0000, Kuba Piecuch wrote:
> >> Is "local" short for "local or global", i.e. not user-created?
> >> Direct dispatching into the global DSQ also shouldn't trigger ops.dequeue(),
> >> since dispatch isn't necessary for the task to run. This follows from the last
> >> paragraph:
> >> 
> >>   Note that, this way, whether ops.dequeue() needs to be called agrees with
> >>   whether the task needs to be dispatched to run.
> >> 
> >> I agree with your points, just wanted to clarify this one thing.
> >
> > I think this should be interpreted as local DSQs only
> > (SCX_DSQ_LOCAL / SCX_DSQ_LOCAL_ON), not any built-in DSQ. SCX_DSQ_GLOBAL is
> > essentially a built-in user DSQ, provided for convenience, it's not really
> > a "direct dispatch" DSQ.
> 
> SCX_DSQ_GLOBAL is significantly different from user DSQs, because balance_one()
> can pull tasks directly from SCX_DSQ_GLOBAL, while it cannot pull tasks from
> user-created DSQs.
> 
> If a BPF scheduler puts a task onto SCX_DSQ_GLOBAL, then it _must_ be ok with
> balance_one() coming along and pulling that task without the BPF scheduler's
> intervention, so in that way I believe SCX_DSQ_GLOBAL is semantically quite
> similar to local DSQs.

I agree that SCX_DSQ_GLOBAL behaves differently from user-created DSQs at
the implementation level, but I think that difference shouldn't leak into
the logical model.

From a semantic point of view, dispatching a task to SCX_DSQ_GLOBAL does
not mean that the task leaves the "enqueued by BPF" state. The task is
still under the BPF scheduler's custody, not directly dispatched to a
specific CPU, and remains sched_ext-managed. The scheduler has queued the
task and it hasn't relinquished control over it.

That said, I don't have a strong opinion here. If we prefer to treat
SCX_DSQ_GLOBAL as a "direct dispatch" DSQ for the purposes of ops.dequeue()
semantics, then I'm fine with adjusting the logic accordingly (with proper
documentation).

Tejun, thoughts?

> 
> >> Here's my attempt at documenting this behavior:
> >> 
> >> After ops.enqueue() is called on a task, the task is owned by the BPF
> >> scheduler, provided the task wasn't direct-dispatched to a local/global DSQ.
> >> When a task is owned by the BPF scheduler, the scheduler needs to dispatch the
> >> task to a local/global DSQ in order for it to run.
> >> When the BPF scheduler loses ownership of the task, either due to dispatching it
> >> to a local/global DSQ or due to external events (core-sched pick, CPU
> >> migration, scheduling property changes), the BPF scheduler is notified through
> >> ops.dequeue() with appropriate flags (TBD).
> >
> > This looks good overall, except for the global DSQ part. Also, it might be
> > better to avoid the term “owned”, internally the kernel already uses the
> > concept of "task ownership" with a different meaning (see
> > https://lore.kernel.org/all/aVHAZNbIJLLBHEXY@slm.duckdns.org), and reusing
> > it here could be misleading.
> >
> > With that in mind, I'd probably rephrase your documentation along these
> > lines:
> >
> > After ops.enqueue() is called, the task is considered *enqueued* by the BPF
> > scheduler, unless it is directly dispatched to a local DSQ (via
> > SCX_DSQ_LOCAL or SCX_DSQ_LOCAL_ON).
> >
> > While a task is enqueued, the BPF scheduler must explicitly dispatch it to
> > a DSQ in order for it to run.
> >
> > When a task leaves the enqueued state (either because it is dispatched to a
> > non-local DSQ, or due to external events such as a core-sched pick, CPU
> 
> Shouldn't it be "dispatched to a local DSQ"?

Oh yes, sorry, it should be "dispatched to a local DSQ, ...".

> 
> > migration, or scheduling property changes), ops.dequeue() is invoked to
> > notify the BPF scheduler, with flags indicating the reason for the dequeue:
> > regular dispatch dequeues have no flags set, whereas dequeues triggered by
> > scheduling property changes are reported with SCX_DEQ_SCHED_CHANGE.
> 
> Core-sched dequeues also have a dedicated flag, it should probably be included
> here.

Right, core-sched dequeues should be mentioned as well.

> 
> >
> > What do you think?
> 
> I think using the term "enqueued" isn't very good either since it results in
> two ways in which a task can be considered enqueued:
> 
> 1. Between ops.enqueue() and ops.dequeue()
> 2. Between enqueue_task_scx() and dequeue_task_scx()
> 
> The two are not equivalent, since a task that's running is not enqueued
> according to 1. but is enqueued according to 2.
> 
> I would be ok with it if we change it to something unambiguous, e.g.
> "BPF-enqueued", although that poses a risk of people getting lazy and using
> "enqueued" anyway.
> 
> Some potential alternative terms: "resident"/"BPF-resident",
> "managed"/"BPF-managed", "dispatchable", "pending dispatch",
> or simply "pending".

I agree that enqueued is a very ambiguous term and we probably need
something more BPF-specific. How about a task "under BPF custody"?

Thanks,
-Andrea
