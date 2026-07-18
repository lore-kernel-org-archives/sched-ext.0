Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012070.outbound.protection.outlook.com [40.107.200.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC352E3B12
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784363077; cv=fail; b=pYnTCuK97QntuwURvbqoWeWJKHMCBf3iIHyQSdvTQJdOuA0QpFJo7bCndLLrmr7XQMM30FXfnD4OQpAkl4YVvCRH5+Wo/VsKPYZNafb/VDLR56c+P0iId/HuCzKYenNyJymn4+sYL3VvMjqV+/aN6rSAyr3QDit21cbqKZXOJpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784363077; c=relaxed/simple;
	bh=420Rt7fXmiKDbm3NichwWANveGdsPeBA0QuE3Ogtz9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qovrptE4lPrjlpW6FNU1aA/VAUpKGQGsKhUA/MtxBAa03AMii4riaEw2Q89KmXET5f9QI3Z1zLzqbZOFn9ZYZZU07axVCUBSth6QdU0OoFI0sZwogHCcSGOoRnBF9ZPMNiAxukGeMPC+UGs7hJw+FXBkvIUZmqZzdgmvhuGInbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IYIb+d/4; arc=fail smtp.client-ip=40.107.200.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IYIb+d/4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkaJ7jFD76OMYMaXQqpVwqKGjnNqZD1JuDjFo14vRlCBdHnvmwzTHThDTwtig4KPe9riyPo7fY8D6gzhMhEE9YzFRG8e04ITr6xLYU6e9jQ+vn3aovp5gcab+qKZfTcfq8tCE1F+fMzJpjdRFdmoXKWJIZh6Lu9kdPfHGrR0PA4DLwpCktkL+49gf2fW7PxzLOq5+yyoXNYyYV31pyrQLlf5WKxJz/AtzDVjreTJy/TKufuofOVyFA9arH/tGJw2pss0ikC2InBE8DKmXirjNdrs9gX1dp/0PkIrBXakQx1frUgSwrkaoeI+41vPs31F3+yWT5zk2d5AIh1/BQ4QGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39RU8b1Xkc6LxrCHcUODe5CqqLZNBEh8gfu6a9blAOU=;
 b=d6ku2Pi9cFFry7KW0YZhGR3R63jwNR1/Y/lNOH8Gz3Ce8RzjOxidfwUf3mV2u64ISED1ZBDLx4TBN7Gby1m+fV9NdpVASKrDfUBoFa5J0tbOqtl/foWDtU2z500om2t3+WLXWkhtqRZfwVUmaofuFuyQoLJeOEW6Kxr+FWl6wLIgj1ab5Re4A4QaLqOLA99rW7xks2rxWwaVwCjmikGvOYVLP18/nwYtfNQL3SYFIUs+PHAT++bB7hJ2sTH9TAHHYyg8n5k48g2NtQPoChPwDeuwMcI1kJwkD3Uyh4WRZHFWjGPC6V2O2Io1/V0QJ0llplFW0/hJBb1qQt/UxXlN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39RU8b1Xkc6LxrCHcUODe5CqqLZNBEh8gfu6a9blAOU=;
 b=IYIb+d/4REnnjKKMwvaEyOPR3rn6OXWtwquaic6NiWpJOUhwfYF7vkhBfFRZ4teVDEZ5swpCZI8QY0Gb+2K21A+vwCxsc/eHNV7LjD+41XEN0sk6XFdIAL7d3OPsdpOTNnkTfTIRtU8ADzhhccAL80da0TX0qfcA/yFrnnQDmfxfu5S+VIaHRGwnBrRPklzX31eRm4+DcbZ+Qd24bB4PPUYogxtC1NAO9GbW4KFalJG4Tstb6e37qnUqj8MbmFG/nswN5l1crMkgJBO1Fmg94fN5ubvZFgds3f4/3VKzFSNLKORMxBTDsrqDffiXnMlF7grIEydI8s9RseUp0rA1xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 08:24:31 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 08:24:31 +0000
Date: Sat, 18 Jul 2026 10:24:21 +0200
From: Andrea Righi <arighi@nvidia.com>
To: John Stultz <jstultz@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution support
Message-ID: <als4NSM0zWyhAgEf@gpd4>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-11-arighi@nvidia.com>
 <CANDhNCoaZnQXeFcxAv4XA4dW9sq9k+nm+0=EcqmLDvhMqKPdnw@mail.gmail.com>
 <alsTZ3oBDndrw52u@gpd4>
 <CANDhNCqSSf9UPzo_6Z+giTJHRWC6X=D=daWuzbLWyDYsFbZ2qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqSSf9UPzo_6Z+giTJHRWC6X=D=daWuzbLWyDYsFbZ2qA@mail.gmail.com>
X-ClientProxiedBy: MI3PEPF00007533.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c5) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7beabd-8e0a-4c94-8b81-08dee4a5fd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GEiDvgVUZu3nu471P+OIJWxz6JoYSOVC5fedUahh49tDG9EG72aMY64WdbYA+mMk1A0z7SrjsUIzFhHK1vZ3znnhT/i2zJTlcUPEUFe605CP30FwR4FgcOMSJAHDULpAx7q0PdRMrixATfb1s+xZoeuQfXOooX2JQifzvhSE0zEuIKWi96NiYiKUG4/EWSgeyKrzRrDDfUsdULRFUmYP60xtGhBg0HzM/PCKXP8xov7rr+0sKQwzsgZM1Ap/4uzBNy8TXRbRf+ucnTgwI/U60kxNiMjMSSroUx+jixWADFn3lOQGVdtNjzDTgxyvk//+CY9HJd65SLyrJDufXCXh03KfY+oJz0aA7d6kz1EJIcgA9BdPf7IxOmPNxiu4yVzPngpFRtvxiGdaLvUs20bXPb4cMSVUUJ3yRyOV8zH13Jkx91BMxM9dEWeC+Ca9tVx9hbRWw2ru5NHoDLBf80MquTFAjOJBY+rC2Nn2149NQmL+P05z2wRam9u2d/6/PxagTWA18jjFfMl+Rbu6wJxxQSZQAwGS8+62fuUltGHssb4FX/bbL1K/sjHZF6F56URvZTBbKhEBiSXkSY8Z7LcnAxbRPcqfNF66Kv55g1n2dvfqIFAFpUEvhJW+fR8ph4TLVHuMfzeeKrrrMAPRKj8BSZrGK/Fqs3zg0Psr0xxI4+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFpnOURaeXE3d2VBR1hjd3AxNjFLRWwvK0dYYjhOR1MyRm9RVHdmSHk1Wlox?=
 =?utf-8?B?Z1BKYjgrNi9YYVJMdEsyMHcvdG00QThnWFZ1TzU1cmpOQVAwSkJVVjhJMDI3?=
 =?utf-8?B?cjR2Vk9heEtlYkd3dzhzcWJZSkJqaWdMNXRTNXRLWitpU0hLODB1b1UwcDVR?=
 =?utf-8?B?WHkwc3gyam5hazlOTU5vU0tjemdZSHVGYyt6eDRxc2VuNTNZYjRGQW1zQVlh?=
 =?utf-8?B?cHZqTG1uWGRQZjB4RU5rWFZobUFrSW9CcjlYOWpTbFhpZUZFZVZFRDE4UzNH?=
 =?utf-8?B?ZlMzM3draEltaGNjbFc1dDhabSt4R1lKQ21GSk9RMWJHWWJXczBvWkJXdjFG?=
 =?utf-8?B?dU84SUx3VFJ1UTNVVDYxNXo3ZkhOLzRDZTNFUTFLY3ZSQmVRWlhhRWZYOUJW?=
 =?utf-8?B?Y240TC9nb1VSUGJsd0svQVN6L2F3SjV4bVZJdVF5Ym1wRTc5ckFXV3IvTG4v?=
 =?utf-8?B?Yk9FMWhaK2xPYkpLRXpYZ0trSlY0elBVK2l1Y2t0TElqVmdUVExhUlpzcU14?=
 =?utf-8?B?dlp4c3JlKzdXeVN5MGk3dkVGb2ZnVG9LOENvc3VFNzgzdHFqRDczc0N6Wm4y?=
 =?utf-8?B?VlMzK1EwVkhZdk9uRlhmc0tsYWszTXdSdVVRRXRXYzAyZUxjT1Y5VVVFZWRm?=
 =?utf-8?B?cW83MkxxUDFCazM5dGNGcjlxalVielJ0MFRoNVJsYWdIaVROOTVoRERpckZV?=
 =?utf-8?B?TEErbnZzZEkydVU1TTAyWnhkS0YzR05nOFJsbk5mSTYwNnlWOEpLTnB2ai84?=
 =?utf-8?B?cksyQ3lqdG42VDRUVWxjTFdmTk1hQkh1Z2FNK3BPY3VEbW83eTNCN0hTUzds?=
 =?utf-8?B?N1BCamlJOElDckxEdXo5c1ZnWHdaWTRvMFdPNHQ2bjNTcmRxTFJJTmJOdTRP?=
 =?utf-8?B?MTN2WENrNHJMZVFCS29TUXJhM3FLMVhIak9UakdKdE0vUFdPSFZvVHd0Zmow?=
 =?utf-8?B?Ri96M3F5SWVnK2trVHhWSFB4cW9FaTQwbzNVeW9GNHltakdXT29sSDYrOUxQ?=
 =?utf-8?B?K2VxTTRSS001UlZxVWpla0dWS211UGFyUDdQVmRBRVBzdmlZSGtYc2F6eUk4?=
 =?utf-8?B?V0lwUjNCRERKd0FuTUZQTjZKdENPL1JQQk5GNCtPdm1oNmdIY29seVdkbmpp?=
 =?utf-8?B?bkxkOFIwSXVvMklaV1N3SUFZY1g4bEtxYno2NTRpZzNpMzFYMGJ5UldJM3k3?=
 =?utf-8?B?M0hhS0poQ3FSM3JDQTMzaHpvWEc4cE45UkYvcTdvWVd1SjB5cEwwSi8rLzRB?=
 =?utf-8?B?L20ra1VUNEFoU2tnRzFKVEZUVW1IN08yTy9pRm5OQWVjTFdmcGZoY1drbVBW?=
 =?utf-8?B?WUxTUWdmYy82NVIvSG9jMXA3VnVFeVp4dlJkYmdzdTNBc0NnNmNKNlozc2cw?=
 =?utf-8?B?cmNvK2NqemRteDViaDBORFYrVnZ5RlRSSVB6VllBK1NYdU9WSHBCNTh5bTg2?=
 =?utf-8?B?RkNRa2xvLzZKZXFQWGxlZkRaaHYrWDgva3BCWENjOVhGdmhSNDhHREhHUUxn?=
 =?utf-8?B?SzN1eDZvZ2lkbjZXWlpJN2dDVHBlaHI0Q2hvYkw3bXVaZFZhR0pEMVhhaEpu?=
 =?utf-8?B?MGR2bDlIbSs0SmpxUS9CdnlQWHhsM0hENnNnMWRNdGdzdjF3UlRBYXRENkVP?=
 =?utf-8?B?bW5LODJhWTVuTkpyOGVXVUlVa0doTzhTZ3RCNGN2enZOcVIrYXltUjJGYW9B?=
 =?utf-8?B?WU5ndStBUTB2OGpDZ3NveEMyd3dlTUpNdHdCZ1Z3TmwxMU5ickVyTkhvdkhj?=
 =?utf-8?B?Vi9ka3p3U3ZKU1NpaVJiMUIzTERwTUllQlBkRUdXNi96MmtGWkgvVWYzWVNY?=
 =?utf-8?B?MkJodmsvblNBdjVwOEVuc0dncDEyekpraXpKQ2RON1c4WXlVaFRjd0N1U3pH?=
 =?utf-8?B?eVlhYnRUZGxhVHNGTUd4NWxUUlJIV1p5K3lzajRoS1FhM1FMUGRGS3diUHFN?=
 =?utf-8?B?YXBkTm9sUEZIeGtJMk5qM25EZXdqUFVjRytlb244Y3M4Qks2RmxxeDc0Q0p5?=
 =?utf-8?B?Vno3RVlNeXk1TEU3YXo4aHZEdlZLWmF5Q24xMGlNYzhHNm1XeGxFT2VSWkdO?=
 =?utf-8?B?SXNrd05aa1dZaVFrTUFhTU54dXp3YlUzK1pPLytaRnhmZE1VYXRwSXdhVUUz?=
 =?utf-8?B?VS8wRHUxdElvNEZWZnFRMEpJQStrcGNWMXhRemh2a1Joc2JGeXB6WFArT20y?=
 =?utf-8?B?ZEgyR1JpQUx3c1lRSHJPMUxZNHRYbnZ3N0VmR0RZYWV1L1p3UklCd2FFOUVt?=
 =?utf-8?B?SnhrZDRydldERnBuSnhWRE82dmlKR3RPTktKSVR6K1lqRUJxeCtOa0pqM3ls?=
 =?utf-8?B?eFVDYXBrQjlXbk5ZdVA1ZWQvb2M5U2w0cnZ0aldhclkvZ3VVMUlGQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7beabd-8e0a-4c94-8b81-08dee4a5fd7a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 08:24:30.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tS+gLZGZKyDVk8cP1WdSDcX4D6zR8C3dOI9XJYugIlonfF59pXK5c4SSS5tx0eVq2I3/TcqkbqhW83kdjPbR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

On Fri, Jul 17, 2026 at 11:04:16PM -0700, John Stultz wrote:
> On Fri, Jul 17, 2026 at 10:47 PM Andrea Righi <arighi@nvidia.com> wrote:
> > This looks like something related to BPF arena pointers and incorrectly
> > generated BPF code (the other schedulers don't use BPF arenas, so that'd explain
> > why you only see this with scx_qmap).
> >
> > Which version of clang are you using?
> 
> Debian clang version 19.1.7 (3+b1)
> 
> Running in a debian 13 vm.   Though I'm using gcc normally for my
> builds (but I see the tools/sched_ext/ build does use clang explicitly
> for some things).

Yeah, we explicitly use clang to build BPF code. I'm on CachyOS, which ships
clang 22.1.8. In theory clang-19 should be enough... if you can mess up the VM
maybe give it a try with clang 20? From the dump it really looks like the
compiler failed to generate proper BPF code for arenas.

Thanks,
-Andrea
