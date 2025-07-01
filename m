Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE727817C
	for <sched-ext@lists.linux.dev>; Tue,  1 Jul 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376188; cv=fail; b=tP2Q9/4gVZSQJOhxQyB+5/Ps7gGfzZJshox6rEA7uIk/KaaJsdWw4aEZhYSfKNtk3Ankpp/1R6p9b1Z8EWL9eeLCyX0V2wQwvzwPD6lJuErY5cxDMf65keupuk867X1VRg6PaQI2AjaY0UynWO58klBB5fwcb0ljU9FndEIPNlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376188; c=relaxed/simple;
	bh=AohNndIwIYLycKS4Odh6vYp6E8oMR5NzwMP9U5H4NMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k19d5yr9xex9RizDhqFXQQVv9V80isqzDLTFG034L2It/Md22cEtQblbSyjk5jlGDjUD6lVsDNyMoc8OBaBodSHu5LobzAGQTgyKtera5UMEym+dPPMJtQToCyz1TlwxHDKHf0//CQWyJ4J8IsN/3d9wqmHGUwbqApTAphs2oP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d3uN0zLJ; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d3uN0zLJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohmxnx/kM23sNUu31QhJuQfXkjANTYCrM671js1CA5ZQ5zptGB6z/FwbrCEMQBItVxG7xY6z6kAe50+iHuOo3A2DM0lJH5WtywT7VO71OyxVwBE+SuFtaWjZPmbh6w59kppCYsGyUbCAwZeBAyHzmuB6TyfqxKTRDnm7ehCmS0H5KQh76p9pZ7GQds5ObeefUeHQp+Od8mI4FN9MTKjpUVmQOl/XM8JqClXiD1fDW/wplpf/cTTXQoxMp+I3a1Cesn+HwflicdH2z2gVydOk8pqtExPE5XDUJqhTpvlgctNJQ1/p3C9/fEQbRcKhMqCrX0AX9W0hFFiQsi729aPBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AohNndIwIYLycKS4Odh6vYp6E8oMR5NzwMP9U5H4NMQ=;
 b=ujAn0OhF8Q+FRt4qmNefsKDPPYRnxrFLvhy+K2i24AudGqUmmw0ungNvWv1Z1W1VB4JEnYgSkSD41U7LiFxfwKpncINuSgXnAd8J/NC44ZISl379GA6641kcw4cgV3UIIz5+lrpPwhI/OEq7jWGlPDv+LTskac9FnmOxYShzy1lllZc7Y4non3nmlqHmfquh5cGgy0LVCxPuMpRjMlKgOyg/TKZ6H0lAdRgdU3QEm8GWm1FENDbVBJF682knVh00O8ZbW006+WMsgGtJPMooxMMdfaCuZl1Hyaac0x0Uz02J818snkZIxU5myu/67LHkUxYwm3FLRnTGDtYbD1eu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AohNndIwIYLycKS4Odh6vYp6E8oMR5NzwMP9U5H4NMQ=;
 b=d3uN0zLJ7NLYcW55zULr+lA4HpiiAa5JwYc39RhOWuhMp0n22vofzXReP//9NKIFef7v0G2eSVYa4KphWfUdJq6rMhhlk+NmvQuICSoZvQa5XnXO7NmTD/E7ifuE9D0hccuIJ5e0OIrG01z7hACSL0Z4O6s6hwDoaTM1I8lOA6NAoR59Fg//4yC3K7t2X+9XhLJEaurhfMf9EpYOJTqNgqc87E8MK0dMbZoaiUqiqukAFs8NiGLkzdAbFwRNl3Hv2Vr0laU3Fnu9oQRD4eDPl0lvTLKQu6s5hQoijRKHLe6K824atN9BHR2vDn/Xb/n+y1E9uWDln30x/J6PlhB9fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 1 Jul
 2025 13:23:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 13:23:03 +0000
Message-ID: <fe794099-50d4-49f2-ad75-b586157793ac@nvidia.com>
Date: Tue, 1 Jul 2025 09:23:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] sched/ext: Add a DL server for sched_ext tasks
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Luigi De Matteis <ldematteis123@gmail.com>, sched-ext@lists.linux.dev
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
 <20250620203234.3349930-9-joelagnelf@nvidia.com>
 <aFnQ-3L6ixL7nSz0@slm.duckdns.org> <20250630151252.GA2443566@joelnvbox>
 <aGKvW08eOgK-RyQ3@slm.duckdns.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aGKvW08eOgK-RyQ3@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0006.prod.exchangelabs.com
 (2603:10b6:207:18::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be139df-1384-4e67-78f1-08ddb8a26882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmsvME01S2pHczZSSTRiMkk0dVhkQVc0eWN5RVR6L0ZLbEYxZHVrYUNFWm5I?=
 =?utf-8?B?MEhWeS81Y092T0FJZmcxYm1MM0xBZm14RHlVSWF6MVp1L3J6VkRIT0sxMUZS?=
 =?utf-8?B?cGIvRHNIR2ljT3lkN1RkUG5tY1FrZTh0dTN4QytjS2lpc2d5alZzRWdtbkI5?=
 =?utf-8?B?RTVnYkF0NHF6YnRxRXdrZ3Y1VEhuL3FQOEU2bjJIQ1ZSWXFTdWlZZ25QMTky?=
 =?utf-8?B?dG1uQlp0NEc5cVF0VThFeFRkenNGY3lrTXdrMnhpVUp4dFRkRlNSZHhHei9N?=
 =?utf-8?B?cjVkL2wxRTh5NGJjTHNraFpaTmtvWkhEYzdwcTV6bUxNVDQ1QjZsL0kvTVpZ?=
 =?utf-8?B?L0F0ZUVJSVZDWjNldTJPUHVpRUdGMit6aHVaL1FZN2t6dkp2M2VPamNXdUU4?=
 =?utf-8?B?cWxKMkQ1NnZOWDJQK2x4Q1FIaC9YeElKbm1DY2hHWFFmaXhEaGlLcVFSSDEr?=
 =?utf-8?B?N1VrVkgzeVY0ZEpnMVl0OG8rYk1NWEZyeWNodGlXaklKMGsrUDdFQ1BoWEZJ?=
 =?utf-8?B?TnMwSW5pVXZZYkppR0tBTFpoazVXVkM0UzRjd3ZiM1RkbUI1T0R1aUFRMFov?=
 =?utf-8?B?Ym16cDhTcCt6bTlUbjdsckc2RGo2OExvc1lMRFdqY2JmRnFrYjdZN0VLNlln?=
 =?utf-8?B?dHhrSkwxOUt6cllwcmVwWVlYYVRMVTF5a1BBUklVVWQzNnRjS1lnTlQ0SkxT?=
 =?utf-8?B?cVdQK3cwazJnOVZoMWxoSlpEZmZzd3QzT0FXdUZSRDRmekRHNldwMGJLU1do?=
 =?utf-8?B?QVBqQnVMMjJLbmJMR2xsekJ4NUZLUnp1TFF1eXYzN2RTTHhlOFdpcmpEcmlh?=
 =?utf-8?B?MVJnZzQrMVJlUXpOV1FabXF2ZjVTVHN3dVhkYzBiK1pGU2RUZ3lyOU1GUGdh?=
 =?utf-8?B?UlF0VTBpWS9UaXdNYTE4a1NRK1dRZDZNeDVDMzZVMnhiL1lDeHZ6Qnk0RzZN?=
 =?utf-8?B?Tk9rOGdsTk90WHEzVCt3eWM2ZlFPTGpldmFjOWFEMTJ5Z3BYV2h4b1lHZUZq?=
 =?utf-8?B?OXlsWTRsODF5Q2FvTXEybFBLTEhONnlBQ3NJRktyUUk1WGF4UmZxK2hlYUtI?=
 =?utf-8?B?SVByQ3IyakxOZU9rSWpyU0p5MGxiWWp5YW9mbE1FYUFINmx5WDhsdm9UbkZu?=
 =?utf-8?B?L0h4OGlnMkx1MEh6OW96cVp4cmFPUTRRVmY1a0R3NG53ZHkxV1NxdDJVdG9T?=
 =?utf-8?B?RXc0SzBlNWdvVWEzVVhZcGliSk5nLzhIS2pnUWJIU2xob1c2bmF1Y0VTeHBG?=
 =?utf-8?B?ZUlqR2xLcmQ4NWgzRHJGRUIzQ0JxYWpXanJQZkp4M0oxS3FHNmdLaU05RWll?=
 =?utf-8?B?bjdhSlBUek9RZ1YxTWVlK3Z0d1FmTE9VaWUzMXh3RExwSEJyZmNXK25SN0Vi?=
 =?utf-8?B?bFNKRXJKd1R5ZHZUdmJlbUMrYjV2ZktlWHdhVFZib1ZuS0VURHV5MTNuTk0v?=
 =?utf-8?B?NkxBK0N1SkhkUnYxSFRiZXk3dzhZdDNNajZsTGo1NXJJY0JwZjk2S1AvT1o3?=
 =?utf-8?B?b0ZCa1VKWXdyVkpvN3NBT1NnaUVmV0t3MXJQQVJ1bjVaOHhQb1dvRG92RUo2?=
 =?utf-8?B?RTh3eEk1K082RmtEaTB3bWJVLzRqeDFjL3Z0VkhzQVRKKzM1cHJHUUxWZHM2?=
 =?utf-8?B?ZFlHRStmQW9abnI4ZmpuVmlRWERNTmpzcGpURFlNNm5mc3BuU1pMRTQ0VDYr?=
 =?utf-8?B?MFVFYy9kQ3c3RDR2eTB4SUpuNVg2cERiaUJtZ1Q0U0hIYmNRcjBDb1NNenRR?=
 =?utf-8?B?TmF2WlIwQzB6NGlIYjNWZ2ZKMGF0WWYwd1QzamlYUEFtMWFPaFptWTZQQ1R4?=
 =?utf-8?B?NGpxdUR1K2FnYUExNFVLYk1Yd3dGZjZ0Y21MMDRtdnZRbTgwVlBoQVQwOWVw?=
 =?utf-8?B?WmJnYjE0ZHdGL2FOWWdEWjE5NkhzaGtHMGNLQkx0azJVeEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akd6V2dBZG4rYmZXZVBqYnU5U3RsN3k0bjFsYzIwMDU4TVc2VW4xZXplOGV6?=
 =?utf-8?B?K00zVHRENmtUWEh1OFNZN1p1VnoxK3hidSs1WXJpWUZpelp0OXYvTHNmUkw5?=
 =?utf-8?B?SFFaVXBkOVQxZjIxSUgvbUNOMkVRZGpmVHJ1bHFScjJoNCs2Tk1ndGJnRWtB?=
 =?utf-8?B?VUp3STVHdnhNS1l3UmFHN1ZUdUxjMjZma0dIVWJjT0FuSnRNazZJckJJZFFq?=
 =?utf-8?B?ZnNPT0ZYL0RQYkVSSUR1OHk3VEN4WTFKdlNHS1E5R29LcEp3bU5kS1YvNFhx?=
 =?utf-8?B?ZjJlT3Q5VkFZYUdoYUc4eVdGK1lLR1ZtSkhCVWI1K0xYT2VjVW5pN1BaWktl?=
 =?utf-8?B?MnN6OVBVblZwK3ZSTWFhSngvOGNpdmszVGJlUnd5OUt0b2Z2UXZldDJUTytt?=
 =?utf-8?B?RGpKRVhYM3J4eU5qekdNUWV2aks4TGFNc3dDVFNQVXZabDZOQ3JSMHBlR09n?=
 =?utf-8?B?b2pkZkJMd0JScFZqTjFNem8vLzE4dzc2SmdneDJibm5MSFZYK1pDMUxUc3h5?=
 =?utf-8?B?d2ZHM3lvMFNmOWRNRTkwUG44U0JZWExFZVhkMDBUNXcrbHlqWGc3ZWtXdkpv?=
 =?utf-8?B?VVkrYlRuZUdFWjd3S29IUmcvWUl6UXpIZTJyeHkzd1VjY0dvVFhmSTZpSkxT?=
 =?utf-8?B?OFY0Szc5SGJPTVlVem9OT1d0azBYZXFjT2NnNUZpWlVnTWF3NXBpWFNmQTVR?=
 =?utf-8?B?VHYzU0N4bE5wTjlEVWNNWHNaaVJQVjRyWmZObkhmeklhQXlXQUYrNC8yMTRP?=
 =?utf-8?B?Tmladmc4TmRXa0lKOVFpWko2aWdtZGZtK1RXL21qTDAwbklaZE03Z2xMdEtK?=
 =?utf-8?B?d1Q1VkJiZityMXBVd3gycHZ4ZjJxWTlwSGNiNW9pRzZkUjNrR2xzd1JpcXY1?=
 =?utf-8?B?TzRkTFpMdngvVGd3aXUvdWxtZWUvbmM5bzNORWpKT21PdWh0OUJrbkY5OW5K?=
 =?utf-8?B?UTQyWWRUa1krMEhUZmlBVW1ERXkzSm9FM25HUHVBb0JaVE1zc2Q2Rk1zSEdW?=
 =?utf-8?B?cWNMTExJU3dpb3V1bkxKSEE3SGtubGtBTWYwTFphNi9VMHlSL3JhcU0wYmh3?=
 =?utf-8?B?K2Q0Z0xRSUE3Y0Jza3dIZXBaU0Q5U2dsdDh0U3BOU3d4bC95M1JWSVpHK3E0?=
 =?utf-8?B?UTdDUUhIcUFXL1kybzF6L01kTk1FR3dIQXE0RFkzaTFQRlg0K2Q1NHd5ZmZI?=
 =?utf-8?B?Tjh5WDRsNnNzcVNaZEJGOHQ1QXNpU0IxLzFRcWhmcHoxbDhTT3ZiNkZqK0Vr?=
 =?utf-8?B?TkVraFFlOFhCZjlmaGs5MUVxQlZFdDJBOUtJMGpKaHNuOWFFMlBNNlJXait2?=
 =?utf-8?B?QS9SMXM3NWovMUpZNnhhSDRodWtWc3RMV1NoRjF4K1N6aGFEOGVvUjhjcXBM?=
 =?utf-8?B?OTFSckFsR3Rza0lhREM5T1A5ZHVGemdHbStsMmpLMDBHbHBNeVdNUSt3ZkNZ?=
 =?utf-8?B?OTBWNDFkbDA0MnhRV0JnWHFhL2NyRWdwZnRRM25Wa3h4N1QzRlRBVkVWU0RL?=
 =?utf-8?B?S0owY0RSSWZ5R0F6LzBiMjRvSkRpazZZT1c4R0krcUdnSU1PdkE5STVHNmlP?=
 =?utf-8?B?WmRPaWZ5ellBaHNWVkhDa1cxQ20wM1ZOTU43OEl6MnJCR0h5RUhBS0dnNXBK?=
 =?utf-8?B?YzRiME9jTmFVak5mV014QUNheUpKaTRaMVFLUUZ4TmI0dWpnZlhjMlRoRzdR?=
 =?utf-8?B?ck51YzZyVGV1Y1huY3ZqVEZrdzhCUGdQNXNCR1cxL3llN1RjeG9xU3dTNUsv?=
 =?utf-8?B?MlJDUkJEVWdPNkhWRUV5cWdlanFRWm5waVU3cUlYM1VpSHVteUs5U0VDRVhQ?=
 =?utf-8?B?OENZUUUvcnduUitseVRYSW5VWVo5OXllcklWVmVUTm5iYXpnTDFkSENQVm5u?=
 =?utf-8?B?OUMxZFhaeVFwV3ZMOGNWSWF2dGZjaTNPM3RsbjZXK0c1QnpodjVaM1kyM0pE?=
 =?utf-8?B?VDJBZS9TeEpoTUZZcXNSTDM0aEZNREdlUWdZRzkwVWRlMEFTbHNBcldETVhC?=
 =?utf-8?B?aXJuY0RxaHcrUzNHL3BpNnArYlkzNENvSFpmaDQ3RDZ5ajkyQkVMWXA1Rmdn?=
 =?utf-8?B?TGhPS09FQWkyOWNBNzhRVWdNaE53MmZRWFNIVVNXMmErcXhTN1Bja1M0aXJl?=
 =?utf-8?Q?6j9v9Q+CyCZhM30qAS3+5U6Gn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be139df-1384-4e67-78f1-08ddb8a26882
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:23:03.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zalO7Vrm5aNO8hHiL8BVVtx5xK2W6oFRsC/M03upZ+QgzEbQ6ZY2q7SgGjIZbSVhiYBN+rXC42fRVVC91FSJ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033

Hi Tejun,

On 6/30/2025 11:38 AM, Tejun Heo wrote:
>> This changes the signature of the pick_task_dl function, which in turn
>> changes the signature of class->pick_task.
>>
>> How about I pass NULL to pick_task_scx() from ext_server_pick_task(), and
>> also annotate all functions where rf is unused, by naming the argument as
>> rf_unused (except for DL), would that make it more clear that the rq lock
>> should not be arbitrarily dropped just because rf was passed? And perhaps
>> sprinkling some more code comments.
>
> I think what bothers me is that this erases the distinction between
> ->balance() and ->pick_task(). However, I'm not sure the distinction means
> anything anymore especially given the removal of !CONFIG_SMP paths. Looking
> at the balance callsites, I think we can just fold each ->balance() into the
> head of the corresponding ->pick_task(). Peter, what do you think?

I think one added complexity with that would be, the ->balance() would be have
to be embedded into the other sister ->pick_next_task() as well?

And core scheduling paths add complexity there, I'd vouch for keeping it
separate but curious what Peter has to say as well.

thanks,

 - Joel

