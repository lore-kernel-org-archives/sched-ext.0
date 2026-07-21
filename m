Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC794343F6
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619255; cv=fail; b=dPDnIq0yRvdMXp1HxpiUwEgfE7VrkcimeHaM+vBghtaaVzXw18YJKW5zSqgUhXbRZJGZgDsSSg2Q2Estt9C0fhkmc2LdQOdvxXTnjZCqT7yZvzQlrD/O30ClYd1AuZgitm2k1/KGjtDcAS7vk8N/QOW2lV73sNREEtQFdsWifrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619255; c=relaxed/simple;
	bh=WiGNDflafkGZX3RklPpbcn/INh8Y5v7FyCpi31JeA8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y9Yco9KVpQoCLj2NaSgc4S2YWxW46Prkmt7X6FqlZEKAyY2qY/McSkDTh1MPN5hXmsAucBbak1yySU9K6W1NXcV+bqUrzWIaKp7BwdNH6DpkyGahoE5NYAP0WGRz/iHzZSJTQ3iT5Eo0gnzKIYqedw1TTcr7RlW7z9fE1BhKbQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nptf4mw8; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nptf4mw8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW1YlxIfSHy3qFSUPQBSIRQhtyDPAYmzSqqkJ7DJQmDn+wjbXUQw/+RW3d9N+KL60D6SSnG6gBznA57N1PBiia1gpTOYibLkgMdTUb9Vd/DJrpVAVVHuq//08Zbu3PehTEeeDCPXtwUr6/xYdcL7YAvSVPI7AsvzczPBZXFeJIionKRpxUBqXagQsYKOQcZ5AWka5j+Md5aF8uSH3w/4eFJCLC7ihXTU85g2MTrnwuBn0kDXElO68PVbFhRb3FktWe4sm2sgBVKUjxAfnOwi1+v0a5EGiWxR9k4G240DAbPiAtDnP7NLqC0CA96EOhsa+oba2/fYxLEYRisUrIIeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hqZLxrOzZG1/3jda8N5Cw6fZzIJ3DDrbCx28BLM8/c=;
 b=W25QUJ/KNHrtimXGlsOtm7osFDqtBijHrD73CchQ3lgvfLD9P9eSoIwLzReGQgdwxOiG1znogWW8xOSUFbLfkyuA4hBLoRC3/aRnn/oSDKkYKRQw1Wa5zvERKBsMkyI7vODI8/+NYWjb1odyUWOX9/TjwTRcOzZKyfxYa9jHQNT8iR6Em8+vuNy8faZx9AtKq6ydD6+mYIskjkg/LIDwR49JLnv8gnZYRYKd2AaGUrT5IAX4f0FTA7PdI0aH57D+S+OAVK+QkJIRj6puyXZ+CVAfFkMwvOQPve8sVGHuOH9JQIHLb051xdkVYSN9xXr5njnP3MEFWBYc/p+PzUxN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hqZLxrOzZG1/3jda8N5Cw6fZzIJ3DDrbCx28BLM8/c=;
 b=Nptf4mw8v7N4g7kM0uRV/Qk7JmkzujmBM1Wh4Nq0040mOi5IjnX+2/HJZJbEoeUFKjZGi7o8WpxZUvwNAW4Wkr3scvm8zSvj/Dr2qRU4jJWH5qHNdWEbdaDn1IHoJt7N6tu8G8qtsbfrBAH0LNEmGdEys0QSUbUwGWUg8hiBa8x4RWDofBkPLR2H2VDVaCwbzfm/UNtgu7So+4DZKu7O3yna8MyxeNqrSzinXbdc57UQ6LD5pSJkJvixJIA8/3XVbAf4QCbH1W7HVqyLW4Qmmr3aWAnuu9qfxAcwcu1TeopgYPI23vqhgQdlWT0o5jCT6Amt6bQQoHJrt7Bz5LzPrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:34:09 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 07:34:09 +0000
Date: Tue, 21 Jul 2026 09:34:01 +0200
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
Subject: Re: [PATCH 01/12] sched/core: Avoid false migration warning for
 proxy donors
Message-ID: <al8g6drlihHCT0Ak@gpd4>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-2-arighi@nvidia.com>
 <CANDhNCpTDwDiMqFYprxir4cKtaC5smc_-G730gt1MrAyFU-aKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCpTDwDiMqFYprxir4cKtaC5smc_-G730gt1MrAyFU-aKA@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0053.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::22) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c45d015-f57f-4e76-e0dc-08dee6fa736b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BzUV3BiDRfKMYYMAQCvCLq4MSYjJVG2iJd7JCLtpDV4RF7DXntt/QD4AybYT3VA5wdw01n6CbtGPZBe/pcbQ26NQ8Zxe3epHPmbi0BGVZk6Fk4Fm9+rAJVExesENUNNeBE0PuImi8RzTdMvr9ih56ukespalc0sLlbLhfcszQFR7bIzdhG8EIM9vfx28m9hF51He7aNZUFO8x+QYcTeDh5QV2m9UwxynOHMGhyfLCdgf9x1EaxeTqy1/hRnRLOJlJeuVoVwVvjOLeLaRQp2S9V1vo02KjVabiF1Yn+zKJuwVZyxZW4x0giJFmtqN57AeCiXYzyaRMoORP9unlC95tG88KrlrTMWuzo5ltGzAE33ERaolKM2D/dgw32+ptUhGRoscUpW7Ne76jYt3rdtnouEvDlWLHYfOLFPX1uuuqJWae2tzebCjIrlGjATpnulnNBCr4ahzGXzy4Bb5wrFei0PAzsIaJTKB4miPEnfLkEX0ytnJ5HB2BHjfxaT5Bf7yYLfLy/1gJCXFRpAPikvr5xjgVu5kHqZVrhu37r+J/N3EwDxdLvJS5luLQOLnIXe2qNZo68lunQWz/p6IJmudPajqqpXG5NRMM56qe5yeLb3m30VEFejlGYG45e2ZKv7eVNiyq2kSB5PosEuICxsneUm8PSouEGbyLW8B80FXPRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWxjWFg5L3lCZkRuWXFWTHBvMjBxT1dOYTVBQTFBRXYwVXc3czZZckxkeXBa?=
 =?utf-8?B?RHhpNGNVRlN5c3dSc0ZlOVg0Y3pFYzg2SHVZa2xmNmxYb1F6WnhTdzZBcWNL?=
 =?utf-8?B?SXZISTByYnY2TUxrTGpNMDZxMjlndVUzbElyRkUzd2ZsR1VCbWdUcmlqeHZN?=
 =?utf-8?B?NC9QUlN4VGw3Z3FkV2FmbXA2VGxRbnBtdDBacW5OM293aXNJYVRPZEcwQ1lR?=
 =?utf-8?B?dW1BMFdnUmt4VnFUWFB6NUdyeEtsR3BGN2toT2V2OG9nZXcrWm9pZUFoaWpM?=
 =?utf-8?B?T0p4cGlheGd3S3lKT1F4MXVSK3EySFVCd2trQkt3VmZwNFBkc1Jpdjcxem9o?=
 =?utf-8?B?ajlneks0UlhGcEdFYWJLQllGckZWNkVoZHJqQUIvbmhGYU5Tc0NPOG85bHh2?=
 =?utf-8?B?ZVBJUFNScDFabUJkQWZUckxHMnJTdnBzVWl6UXBackdHYjVUMjA1UnRIbWQ0?=
 =?utf-8?B?WTJoUmZ5U09pMlgvRVZYRndUWWlQRXl3MUZoOGY3WVRWOUdtNXpTTlpFcVBn?=
 =?utf-8?B?TGJCbVlWSk9aNXBwcmhBTTlSTDY5UlJhV3oyV0ZqSW84Nm1nOEhxQnc5U2ZT?=
 =?utf-8?B?aUlkZ3B4WHgwM0N3REtkMURMajNWOVNaQ1F1ZkdqUjNjRjdPMmxOYUxCL3Jv?=
 =?utf-8?B?TU9rTmIwdHJidzMyV2pnSGhNUVFEdFFNbHR3NzJtKzQrRW9Mb1VlSDZjSlNl?=
 =?utf-8?B?V0ozNzZreU4yZjA3ekRKUHlLeEdKTlRUd25wbmgrOUo5bWJjaWU0ZlZ5NnFF?=
 =?utf-8?B?YmhTaEREbEh5Q1Rna1JORitGcjRTaDE2Q1R2aW44blMxNTd5Y1RDR3J4WVF3?=
 =?utf-8?B?VHpnUlowbWRUU1h0WDZmR3l4b0JzVG95dkpVQW9kWGcxaHhmMHFUOEpzMEcw?=
 =?utf-8?B?UU0yREIwRXV4RnZxL2N2MzJHYyt0dklxVUVrU25Ua2t1NzdkNmVNUVh5VUVS?=
 =?utf-8?B?eWJzMFplbXBCVSsvNkRDSUlQNDFEWTBHa0cyUVNJeTQwbEpOdU9MZDNHbkFT?=
 =?utf-8?B?TVozUGl6N0xHbU43dExCM2RJM2tpNmxlYnE4TDRyT0k4YWJDZ29GbjRKTFpj?=
 =?utf-8?B?R0J4a25pYzNOT2lTYk0zRDM4ZWFaeHNwZGQ1SEQzVWIyRkJubjNjcEY3aTR6?=
 =?utf-8?B?YTZvbEkrTlZjT09jZHNnelFraGNmUmFxMnBpc25lcFBpRStRblNkQzBYaG1T?=
 =?utf-8?B?YlhYamVycitJUWg0NExncitkTDhrTURTODZUZmhWVVN1OC9HUSs1VFJtZXI4?=
 =?utf-8?B?MW1tTjVQRGJRdkt4MzR4S21PME1TOW5IczFFSDRLbkFodHZMenZMRHFDeTdB?=
 =?utf-8?B?aGIraWNnUlF5Ni9NRFRka1RaOWcvS0pJMWtBV3ZuWDRNdmFCeEU3NTZSaXA2?=
 =?utf-8?B?NzVRWmFBWXdJQWQ4TzdYZlpLS3VMUkY3R3JOd3ZMSDkrMzVod0dHWjNTdXJw?=
 =?utf-8?B?ZHlNRStlR1RBdkxaL05TWnVUOU1nbnVFZEluYnh2dEEzT3FDa3ZlWkpKSDNm?=
 =?utf-8?B?SzdUNnNNNWRXU1U1ditTTWlCYnRJQ1o0cTd6VU9EeTFMTlI1YnF2MTN1aWpv?=
 =?utf-8?B?eS9EbkdITGhkTVA2STVWd1RVMVZaSllCekpwUEovZG43dmlxT0VSdGNUcVhS?=
 =?utf-8?B?REVIZkNibkhONEEwaHVjMFFTRVkxU2VvSHFCY0ZMTXc2Q3pITmNreEdIckNx?=
 =?utf-8?B?ZmJ0L3N4cTN1NEFDMU95UXhoTk9aazFpWEFJKzVtUXhFQU9yK3dmNlJiaC96?=
 =?utf-8?B?d0FXU2lvZFhFL0VCVHJqWExMYTl4RWIvY1Vqb00xUDBuSnd2MGgreEdLTVda?=
 =?utf-8?B?NmF6SUJQWU5TUThiTCtwT1pteU1LQXdzYkxDOHdMcUpMd21Cb2hHSkY3Yzdk?=
 =?utf-8?B?bWVncHdLNTV4WHIvU2pUM05naExyTVk2UWRhOWxSZzY3cGFLc0Nsbjh3UGtx?=
 =?utf-8?B?YUxaRlh2VUs5VmcvS1VzQ2QzUitpKzJoN3FLL2JxRXNqUGIwMUttSW9NVTJj?=
 =?utf-8?B?R2U1aGJ2aFpDWVA3VWV1d21QSWdnNFdLTHN6YzkwUkVOMW1sV2RPbGdlVFZt?=
 =?utf-8?B?eXMzS1ByUUlEQzBTSnJpLytYVXpTMU9zUHdQUW1iRndYa05pT1pab1dyK2g4?=
 =?utf-8?B?RmNVQmtZelJvQnRLNHNWYXJuSTYvNWxzZUlodERCb1ZINXJBSVBJNzVpRVN6?=
 =?utf-8?B?NUhoc29QdmFkdWFzSlFaY2dqQms4alRNZm5yVks1MWRaOHRKSVBTUXRkUmFQ?=
 =?utf-8?B?djA2NURBUktidUNOMGhBRUFlV0ZqdCt1VXZPOEFpS08wZTVsZ2hUMEdrUDNz?=
 =?utf-8?B?RFh4cXljYndRUXNsL0J5ZWxlMU94ZDNvdVVRRWN6U0lFdTdKekl1dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c45d015-f57f-4e76-e0dc-08dee6fa736b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 07:34:09.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6nOWB/VljkorpVLLlBwXe92PgFeprVgQ0O4u+9AHnKFDJ4hW5VBEFDNgrY/8lOEOTNFYDecl10MEPFiwcSR+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136

On Tue, Jul 21, 2026 at 12:00:45AM -0700, John Stultz wrote:
> On Mon, Jul 20, 2026 at 11:33 PM Andrea Righi <arighi@nvidia.com> wrote:
> >
> > Proxy execution can move a blocked donor's scheduling context to the
> > lock owner's CPU even when the donor is migration-disabled. The donor
> > does not execute there, and its original execution CPU remains recorded
> > in wake_cpu.
> >
> > set_task_cpu() warns unconditionally for migration-disabled tasks, so a
> > subsequent proxy migration or the wakeup path returning the donor home
> > triggers a false positive. Moving a blocked scheduling context does not
> > violate the migration-disabled execution context.
> >
> > Exclude blocked proxy donors from the warning. The proxy wakeup path
> > restores an executable placement before clearing the blocked state.
> >
> > This is a preparatory fix for enabling proxy execution together with
> > sched_ext.
> >
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> Nice catch on this!
> 
> I'm wondering why I've not tripped this myself yet. Is
> migration_disabled set more often in the sched_ext paths? Or was there
> a specific workload that you hit this with?

I triggered this with a modified scx_cosmos with proxy-exec support (option
--proxy-exec): https://github.com/sched-ext/scx/tree/cosmos-proxy-exec

This was the trace, triggered when scx_cosmos was stopped:

  [   12.992201] WARNING: kernel/sched/core.c:3444 at set_task_cpu+0x1d3/0x280, CPU#6: kworker/u65:1/103
  [   12.992387] Modules linked in:
  [   12.992593] CPU: 6 UID: 0 PID: 103 Comm: kworker/u65:1 Not tainted 7.1.0-virtme #3 PREEMPT(full)
  [   12.993012] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  [   12.993075] Workqueue: events_unbound bpf_map_free_deferred
  [   12.993139] RIP: 0010:set_task_cpu+0x1d3/0x280
  [   12.993285] Code: 14 89 6b 64 c6 83 09 17 00 00 01 5b 41 5e 41 5f 5d c3 cc cc cc cc cc 90 0f 0b 90 66 83 bb 80 05 00 00 00 0f 84 f8 fe
  ff ff 90 <0f> 0b 90 e9 ef fe ff ff 48 8d 3d ce 12 4c 02 67 48 0f b9 3a e9 03
  [   12.993656] RSP: 0018:ffffc900003f7cf8 EFLAGS: 00010002
  [   12.994642] RAX: 0000000000000000 RBX: ffff888100c6c800 RCX: 0000000000000046
  [   12.994756] RDX: ffffc900003f7d2c RSI: ffff888100c6d338 RDI: ffff888100c454d0
  [   12.994860] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  [   12.994956] R10: 000000000000003b R11: ffffffff813f5c30 R12: 0000000000000000
  [   12.995055] R13: ffff888100c6d320 R14: ffff888100c44800 R15: 0000000000000206
  [   12.995167] FS:  0000000000000000(0000) GS:ffff8882b380a000(0000) knlGS:0000000000000000
  [   12.995273] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   12.995354] CR2: 00007fe19b902000 CR3: 000000000364c000 CR4: 0000000000750ef0
  [   12.995462] PKRU: 55555554
  [   12.995502] Call Trace:
  [   12.995540]  <TASK>
  [   12.995580]  try_to_wake_up+0x360/0x6f0
  [   12.995640]  __mutex_unlock_slowpath+0x32f/0x540
  [   12.995716]  ? bpf_local_storage_map_free+0x84/0x280
  [   12.995789]  ? process_scheduled_works+0x225/0x520
  [   12.995861]  bpf_local_storage_map_free+0x257/0x280
  [   12.995934]  bpf_map_free+0x84/0x110
  [   12.995992]  process_scheduled_works+0x271/0x520
  [   12.996071]  worker_thread+0x1e1/0x300
  [   12.996133]  ? __pfx_worker_thread+0x10/0x10
  [   12.996206]  kthread+0x10c/0x140
  [   12.996266]  ? __pfx_kthread+0x10/0x10
  [   12.996319]  ret_from_fork+0x189/0x330
  [   12.996378]  ? __pfx_kthread+0x10/0x10
  [   12.996435]  ret_from_fork_asm+0x1a/0x30
  [   12.996500]  </TASK>

Looking at bpf_local_storage_map_free(), I think I triggered this warning,
because bpf_map_free() calls migrate_disable() around map->ops->map_free() and
the deferred map-free workers can block on mutexes while migration is disabled.
Then proxy-exec moves the worker to the mutex owner's CPU and when the mutex is
released, ttwu returns the worker to its pinned CPU and trips the set_task_cpu()
warning.

> 
> Acked-by: John Stultz <jstultz@google.com>
> 
> thanks
> -john

Thanks,
-Andrea
