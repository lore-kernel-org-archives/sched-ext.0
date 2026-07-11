Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD923EA97
	for <sched-ext@lists.linux.dev>; Sat, 11 Jul 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783760695; cv=fail; b=UMw+h+iPbZrTNjcpnjtOfPes5n1fisf1UAaZJQIxMwlWM4S+22qHK7n/NkFLVYiXie5hj7PGRX5hClZ5z0ty5ZFn9OQJchxsTb+ZESBwSLxtwCxar0VV3mNJtUHJgqA3D2gFftEkle+mwtX04KcaHIFQvCfzrVxEQWf8GJwrUX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783760695; c=relaxed/simple;
	bh=kfqoIcmxAMiK/Oonjl4h+C8ZIUJA2tMq5b3/iBpeyB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DeuZRACaw5wxXpbn0bbV+Rj9YWyfA1cigGhZDstmJh+XgaOEUcopTaOnTBYaafBtlvy3ngso6jb3yqdyP1vua6PXAhZM2c/yR1YSopKAlqjLATFSncoGnk+DTLUwaD81AznWzGm/pH1vEDjRJ3fYbRePyXxId+DKHzJK8dNSvSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nax2kt0L; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nax2kt0L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0wdb0CX23QA+hfzLW1KWBKfmMyXHkOCMtJdIyuvS4j2gK669eQhE7FidcbTtdG+K6c2ompt6WIEF9dEojzx2to4o7fSCqirfYK0f56Kw8lzoTJVKlc4ilw51poDHtJBoAKBtm6sNTAjmdXoMAcc6ETwrq2fy5bILZ3vIaN53qc2MvtHT5VA+D5hbjjHz9KoCPsyDEDYBUM/zDJGc/Za9kW9ahPiuPHwVYbCQRfRaBuLXFPl/X2KKZEoEj2hEjXuZHaNiqrAAMmD9iBuu/cypu9sITEOZvE2PCUk7/u3UHMbziXXP6QSMU4aWxARCPPVpLsn6vx8D/MX6KPfJgbg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0Xtwju9Dukohy+L5Xd6r1jo5H6OZBuiu5BDMz0xUWk=;
 b=ixe2d/dIRNsxzB/1JOHRtqXeDqRgYJJshJRV9A0ZzXFrpj4jFm4yUsrGAjJYxFzeiqNjh+PyaMWBYZ0oru4c30KGj9Y9xYnghd9IcSfIJqLiUGq5vHUbz1k7JwFSdEoiIEkekEnjEak1opS2828nSItNRMYDUCf/1FcS+Nwbhy2Tr26P3mFp1cn96gzRwFmIH9Qj0FlgH+I0BZNLaJr1ZjrEv4XuSNQv6oi1bR4hF6gVOtGgXZWOLovQ8ULWetf4hcY78QXP2ZQQ34NzK4ZRaDtIzAY4t3WyH+S9I2HM5ggVGnxkQg3UK+GCRcr4kx2W6k5N5zXFsXFyoeDLUFeF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0Xtwju9Dukohy+L5Xd6r1jo5H6OZBuiu5BDMz0xUWk=;
 b=nax2kt0Lafk/IKG9WkMnsPswQ3jeVVfek7u0dD1l8k5llOIDySvJ1YbgwDr4ltoZY4FJgFUN9ccF64xYzZKvY/qSb3ThpzfsyAGAE7zE4dFV1ATjt1cw0941bd94DC0QjFBMuaQekBi2VYoCwcorI6enbs77wKUenOxFVUxfCFK6ttGTWnpjIdpFBLOIf65xO7NZSGYKnzHP5wFFoEotEw+328axRSr4Qnua6odin75kcAZABvGRWBZb58vMrad/aREpl/wibm8mMc1ILqLUVFtUIncL9FVFCMIJRsZOo8wyWy/52yuc61ydxe17NDZKgYRTbiRpbjLqn6u4a3h0Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Sat, 11 Jul
 2026 09:04:47 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0181.016; Sat, 11 Jul 2026
 09:04:46 +0000
Date: Sat, 11 Jul 2026 11:04:37 +0200
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
Subject: Re: [PATCH 01/10] sched/core: Drop mutex locks before proxy
 rescheduling
Message-ID: <alIHJf72RhxOn40c@gpd4>
References: <20260710083913.30573-1-arighi@nvidia.com>
 <20260710083913.30573-2-arighi@nvidia.com>
 <CANDhNCrR+jiW2QEDE9yhbuFEp2nfnWh2Vf-_GT9NWhSP3oSE2Q@mail.gmail.com>
 <alFaVuDMuGNz8a-g@gpd4>
 <CANDhNCoyO=KaOhQZDy4drXpyeCbwt9src3cpXe+1EFJgEpPN2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCoyO=KaOhQZDy4drXpyeCbwt9src3cpXe+1EFJgEpPN2w@mail.gmail.com>
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8f981e-ee96-4b58-3e1a-08dedf2b73be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PyF0lUgZzQHVTeO1+qY4kzRT4vVXtcCdC2ZOtImtwH9HJXwwApx8NJJZeP1UxwloG4KhDOBxss2MHg4J11E9YnjgTKv4bYRboihfIh+bxd8ZTmGAf8zAnCabMs+t0tbpggischTHPoFD2tJeUfgqFfyOy8ddz9ADEg/n7QqwZk+4PqwDkwjqnQ9CFtrnWb5B4GgRIJqNBsefEnXle5aUeWaLXuT9CTNJHripSWODPwjSncuHnoun8UdNM7ZEt25yI5HWoSCO95VNbHpChZwDUonbDzx77/Ly49byvivpCGDBJO+D1Jf53guqGOJCFM6jweBYbwzru7+NpwT90vmjQcsVEOy/uSDnJTzL7i93OeLptw+/TvdfN1VnwYZqH50ycjtAxhPgPQ60paJ5/kZoeUo8sB0MP+WipawxMydE8639n9K2rE5CgeB9u8V6TccB+AAaP75T6fXi64Hc1GRJ0llh0aNP1m2imVomMBp7IfdH6m19mt94XlpX3VTEeyJYHG0/+3E9P/m32cVw9eiouFXEm52m+y093ap/T2srATnuBLlI/ncgblnyKm/EA6LWL4HKVuXBIZEztxA8kQAtSl0zFdQt7UWX1WJMKLS6GFWxGJAP2ZdgP7vERCrEJXy+hmK+LHAGARKtN78Y02QVqAaJH4PbA1cHgw8n5uEq8gM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1Q3M1hxSXJSb0p0bm5ibmxsS3RBbURDZXl6UGlXUXNaQ3JRd2JjOVBxM3Rn?=
 =?utf-8?B?cHo1LzYxeTlQVzJmckVobDNheENWK0lYT3lZMm04cDBoTUNYSEF0aWpyUWJv?=
 =?utf-8?B?RG51QXJtZXpPUmtnbXkzYTFqZk14N25Ibmt0VVMrOXZtWHA1RktkZDZvV0Ur?=
 =?utf-8?B?UGR0R2wxdytwTEUrdFBBR3JhOGVuRlJrRURkT2s1RjBJTndDNmptSFNKTlND?=
 =?utf-8?B?YnhSTm50NVdUY1JEM0NtL3JpMkZGazM4aCtjTHZxSWNHQnFUZVJPQVdza1ZT?=
 =?utf-8?B?bmRTaDFvOHBObmNnTk5TMVhKVzhvTG1udU5XKzdwRGJCd0QxYmpMU2VMQk5Y?=
 =?utf-8?B?UjVpYjZxU0FiNmxvbXdxUDJaL2hRcVFaM3FGcy8rQnRkNUJHMVJsOGlBb1Bk?=
 =?utf-8?B?Y0w4WUN1ekVDd053OHUwa3FFeGlXeTk5VGFGYU0wRjd2aUxXTmZXK3lLYXhI?=
 =?utf-8?B?M25EZ2ZHZ0xYZllqRmdzWkt1dndyRkszc2VNV2Zic0dmdXdGcVd0bU1ZNUVS?=
 =?utf-8?B?OEE5enU4R2VyMWdWblhzUm9CZG1adVBJSEEycGs2MlRZUTRMK0pPTldTdVpT?=
 =?utf-8?B?Qk5mbHlENFhObmM4M1libmJBZU94VXRxL3ZDNGwvajVndjRVSHdvRjRHb1hj?=
 =?utf-8?B?c1ZkWmxaeGJrdUVvaXNuQm55bjdUMExIem4rcUlMQUtKYnVDbnpjQjdtMlZ5?=
 =?utf-8?B?eXk3VXFqNmNrS1lYYW1YWUtQZDJtM1VxMlc0RlQyK3hOczJWSXErL3VlaGlG?=
 =?utf-8?B?QVF4amlXUExoOU5DMzRNamtwdmFNOVZnQVBld3F3ODVjb1grTXdQY1RISlN3?=
 =?utf-8?B?VlA0V3lzbkdleXg3a0haYUpRNDcrclhRcGo4VXp1eGxkbTRSa3AyYjZIVVNx?=
 =?utf-8?B?RTRzL0FFVS9oN1NZY2s0OXFsRVA1MFlHR2FuMjJIdEdXOGNIZkhqa2NXb3Js?=
 =?utf-8?B?MHo1Ly9UOWpxYndPbDlDaitzbVZNVWZIUFZmN1FLcUV4WmEycExSc2N1TzVF?=
 =?utf-8?B?U2tZcVU1UzIyWHhvelNQdzRaa2NJRElhcGwyQURHZVRBMmlSVVNNWWIxL1o1?=
 =?utf-8?B?aktkQjVLRTVOY1NUTW10S05zVGJ6VmVxV2dMQkZNNnc4cVNRMHVVVm85dHpv?=
 =?utf-8?B?STdSeGFocllUdGxGR3B6T0J1UHFFRGVPWjlQd2owUm1uZHZyeWVyVEovYVBy?=
 =?utf-8?B?ejNSL0JqY3dWYWNOZmlUMmo2SXN2VlBNTUtyc2tOd2wva1h2dkw1UkNTcnRu?=
 =?utf-8?B?WkMxYWpVNlljZ3lVMytXS2k2c2EyaWVoaTkxWVJ1RHQ5RW1yMmk4YjFxOUFC?=
 =?utf-8?B?SFEyRTB5SXZneHFjMkJMYU1teElVWExFUzRFZEt3TEloVE8yYXEza2JNZ29v?=
 =?utf-8?B?MDhNeG8ydVRVVk0xK1U1YVUwVHFLMWFRUjE3SUt6cjdCakovblBpcDE0V290?=
 =?utf-8?B?RDgxckU2T2I5amZCUnBzVC8zQ1Y4cUg5bE1xWVRoQncyYzJrSGRvWmFsMTR0?=
 =?utf-8?B?K0hrak1QSVhlSzVTNXlxWUNESDdOdjZoclRDU05lYmxwWFJsOWtMNzIvVjlq?=
 =?utf-8?B?Y0NFaFMydGRkZXFTSkJsMm8vc2VHMXFQNFlBVGNLdlVkVWNBRkNtN25pQkU5?=
 =?utf-8?B?aDY0Y1E4bDlyL0t5NUg0cGI1SUx3blV5azhidGgxTi95bWFFWlVYWUxEVGxB?=
 =?utf-8?B?MncvOFpQaEZicUVmN0JnWXFkK1NEcEVPU3l1RDhoVlVmM0RUd1crSHQvZzJR?=
 =?utf-8?B?bnoxUE04YW9aZXgyOTlJZzBIUDZ0WVpWejF2cjRkK0xjZmkrNE83ZHZITWIy?=
 =?utf-8?B?UVFIaWcvU2tuS3RkSTZSWUlGVDdCVGZPV0hqem1pbUVwbEdROXp5L0diT0ps?=
 =?utf-8?B?WW5nUjg3WjZHQzBOaTIwTzVGajY3ajZ6RFd3amE1U09FUkJZTVIrL3YzamVZ?=
 =?utf-8?B?RFFhd1ZFS2VyT3o3SkkwVkszWUpqR1lSYVE0ai82NHVvL1BTdTZWT1ZEOE1t?=
 =?utf-8?B?TGdUaE5Qanc1cUpLZWVtOWtjOFJIV3JWQU5WMm9hRWEra1R4UVp3OVJ6OVF2?=
 =?utf-8?B?TWs2ZEduanNKQ2pHcjNjZFBGWER3V0FpNk1hY3VtTDYvUXRacTJRbFZPL1hp?=
 =?utf-8?B?ME9zT3hWR0tDWDA4TkFwUjJlYm4zQ1pZK2VVMGhMaWJ0NG43cEZyUjhCaHFy?=
 =?utf-8?B?TUVGMFg2aUtISkRPQVdOU3pHcnQ5d3Z4OCtrNFd1V2djZlVHeitBR0tKMlNY?=
 =?utf-8?B?ZGNzRVNEdVRBNzlNQ3ZzYlNHZlFoTDRodE5TalQxQ1oxYUVoS2NrdHlsNDFD?=
 =?utf-8?B?ZFFPZ20xNmlHOVcvLzhQd3lTUkdzY0VSVVR0S0JjUFJiTTF2QXNkZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8f981e-ee96-4b58-3e1a-08dedf2b73be
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 09:04:46.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNfr3RordpwflJl2aUn/p+EtlgbDI48bldjgGa/x+xhU+w+0TdnOLOZhPEpSTWTgWpd+wWP0VXxSr/MGISJ4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672

On Fri, Jul 10, 2026 at 05:21:45PM -0700, John Stultz wrote:
> On Fri, Jul 10, 2026 at 1:47 PM Andrea Righi <arighi@nvidia.com> wrote:
> > Inspecting the proxy chain is not strictly required. A BPF scheduler can just
> > accept a blocked donor, enqueue it on its current CPU and let the core
> > proxy-exec path resolve and "virtually" migrate it as needed to the owner's CPU.
> >
> > The motivation for providing a scx_bpf_task_proxy_cpu() kfunc is purely for
> > optimization reasons. By knowing the owner's CPU, a scheduler could make more
> > informed admission decisions. For example, it can inspect the task currently
> > running on the target CPU, determine whether the donor should take precedence
> > over the running task and kick that CPU to trigger a preemption. Without this
> > information, the scheduler can only enqueue the donor and wait until the task
> > running on the owner's CPU releases it (potentially adding up to one time slice
> > of latency).
> 
> So... I suspect I'm missing a subtlety of scx, but in the non-scx
> case, if a blocked task is important enough to be selected on the
> current cpu, the find_proxy_task() logic will walk the chain and do
> the proxy-migration if needed and mark resched, so then that cpu can
> evaluate which of the currently running task or the migrated donor is
> important enough to run.

With scx if a resched is triggered balance_one() does this:

if (prev is runnable and prev->scx.slice > 0)
    keep running prev;

We need to set the prev->scx.slice to 0 to select the new task. That means, if
the donor is "more important" than the task running in the owner's CPU we need
to zero it's time slice. And This can be done via
scx_bpf_kick_cpu(cpu, SCX_KICK_PREEMPT).

That's the reason why I was considering introducing the
scx_bpf_task_proxy_cpu() kfunc.

However, I agree that this is adding too much complexity and we can ignore this
for now.

Moreover, let's also consider the following:
 - if donor and owner are on the same CPU everything is already working as
   intended without scx_bpf_task_proxy_cpu()
 - if donor and owner are on different CPUs, something like this should happen
   (D = donor, O = owner, C = contending task):

  CPU0                              CPU1
  ----                              ----
  D blocks                          C runs
  ops.enqueue(D, SCX_ENQ_BLOCKED)
    [D inserted into CPU0 local DSQ]
  D briefly yields to idle
  D selected from local DSQ
  D migrates ---------------------> ops.enqueue(D, SCX_ENQ_BLOCKED)
                                      [D enters CPU1 local DSQ]
                                    resched, but C retains its slice
                                    C continues
                                    C's slice expires
				    ops.enqueue(C, 0)
				      [C is returned to the BPF policy]
                                    D selected as donor
                                    O proxy-runs using D's slice
                                    O releases mutex

If we want to handle the preemption when the donor's CPU != owner's CPU we can
just use SCX_ENQ_PREEMPT when scx_bpf_cpu_curr(scx_bpf_task_cpu(p)) is an SCX
task.

So the BPF scheduler could do something like this:

ops.enqueue(p, enq_flags) {
  if (enq_flags & SCX_ENQ_BLOCKED) { // p is a donor
      struct task_struct *curr = scx_bpf_cpu_curr(cpu);

      if ((curr && task_is_scx(curr) && is_more_important(p, curr))
          enq_flags |= SCX_ENQ_PREEMPT; // curr->scx.slice to 0 + resched

      scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, 0, flags);
}

Therefore we don't really need scx_bpf_task_proxy_cpu().

> 
> I worry the difficulty (with my poor understanding of the
> optimization) is that it seems like its evaluting the preemption on
> admission (I assume this means the point when we keep the blocked_on
> task on the rq? I may be totally off base here), is that if a very
> important task was breifly running at that moment, you might not allow
> the blocked_on task to be enqueued. And at that point the donor is
> effectively sleeping and no proxying can happen until it wakes (which
> may be only when the lock owner eventually runs and releases the
> lock).  In this way the optimization might make a call in that instant
> that results in *many* time slices of latency (particularly if there
> are lots other unimportant tasks on that cpu).
> 
> By letting the proxy logic handle the proxy migration and
> rescheduling, the blocked_on tasks are just in the same pool of
> selectable tasks on that cpu and the scheduler on that cpu gets to
> decide what is the most important thing to run next.
> 
> Now, I can see the benefit of potentially saving the resched kick on
> the target cpu when we do a proxy-migration - it is an interesting
> idea I should think more on to see how we might do that better in the
> core logic.
> 
> > That said, I don't see a correctness dependency on exposing this information.
> > If the latency-policy use case is not strong enough to justify the API, I'm
> > happy to drop the query kfuncs and this preparatory lock-scope change for now,
> > the blocked-donor admission support can stand on its own.
> 
> Yeah. If that's the case I wonder if it might be worth waiting a bit
> on these optimizations until after the rest of the core proxy logic
> makes it upstream and settles a bit?

Agreed. I've already dropped that in my local tree. Let's keep it simple for
now. :)

> 
> It might also help make sure the demand for this
> optimization/interface is strong before we start adding interfaces
> prematurely.
> 
> Really, I'd like it to all be transparent to the class schedulers, but
> given the complexities, just having the ability for the scx bpf
> schedulers to disable keeping blocked_on tasks on the rq (effectively
> disabling scx proxy donation) seems like a good initial step.
> 
> Again, I am really excited about your work here! I've sadly really not
> had any time since Dec to look into sched_ext details, and I've had to
> tell a few folks who are interested in both sched_ext and proxy_exec
> that they should turn proxy_exec off if they want to use sched_ext.
> So I'm very eager to have a better answer there!
> 
> Thanks for all your great work here!
> -john

Thank you!
-Andrea
