Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3821A453
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516018; cv=fail; b=Pti4oNFK+8VAfbUH2L1oyPXKlir8e7aYs0+Np/eeyYeXyVG0MwTq/9tqE2pdnMRAgoLynfxM/SQ6Mygc/kQRd2ZV+qtf4lMYchEqObMGTtCFb15iZOsDB6RoO3Ml+vohm363e0qYyu/msDxsVsvbqsVNF8MC85VYo5D8RHtzeQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516018; c=relaxed/simple;
	bh=LxJWRz+eISzEylyiH9B1pLZkcy1kPqLFP1x7D9W+waQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a8UMa91jCJEM28o58g2g4P5SnNV30geOwg7Rc1szNckrqJ5ltidihv/Z5fRbObMeukjWs0FSsFYPX2h+R6HITMgNUNW1TDFVEP75ODu1PL40m+fsNh2xxnifH9tn0uhtwc/iYYj/sV95ntlgZA3XjkiZGd6PTfqDVP5RXAV9hqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ps1Be9vt; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ps1Be9vt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQ3HzPJp+Uacazcm7xWP4GF8+MjTyXLG0xEa+BVkybE2pDRuKPpCsTK+vcofJAc4xYaZepdq2V/Ms8sm7UJsXNq3+mAsLf3pI9a+y8QusBKuzvyZnkX6EoXP79HSO4huiYESWo/IwxFCuBiRNVV31xYrj3TzyTiBJ3GnJLCJ2XGAZUOum/GVeJsLKq2PaNBGJv9/F1fQwPejWkYOimvQuP9NZ7mymCOsIpG8At5DW36iP+XNWWVN4EEefQn01JyXAoA9jQnemRQMD7WhhGL89yQT1bO583TFrG+rTKjQJBSe6spot6Pq4nGRPwqYFIsv09Gj6Iibr8zAdm7J6MRbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSrsiAYQE/GyNx4dGMqEDiCJKxIEsXz/qVynlspdezU=;
 b=pgW65vp2XE+WU8OK9WehBKYIT2BC6FhtLmOjkY/sM+hkxQCbFPA5MSc9MiGQ7p9mzMUz//RiPAB8RzzQjTRu6Gl2RPzw75CQ6CoNhbbKdKXSgyEOCn8vw75CCPqUOVtLMtT2P5AeaX5kYJrVCX+bPcOro7jcVsxXJOKjBaYs9OEakSzW9RsOZ3fiCtvJCUBzBI8RvWYbiD/SOLz0avpsS3l5tYF6OEfBd5X8Wa4f+s2xhD/tiBoyla/C5OHk0LGOOBuAYmsjpW79bDV5AakQhOFgeoTOE8+VREl82HoPOByL9cyuw50xa3r30ar0EUuHoQIyvHU7vbveh6QMRlIlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSrsiAYQE/GyNx4dGMqEDiCJKxIEsXz/qVynlspdezU=;
 b=Ps1Be9vtvjkVkebdisprcTeqomdE3fdEK9U8raycNkqBzBx8HdOv+q/htn0BXE0voedfw6VzwBkESe4eD2QMFJnZiWuQZrO7VRhxIw2JEwQNcZMGibih4zO0mTLBAhkdz7lsC0owK4TWRZteiBculwLH+OgYIDrTNdXFISziJFBlYX8hDSYAoQD3MhlDyqwerUaxbE1sncMBmf4TfKmYTk5W/aqAO8Mpgj6QPF6RJNU2eDJHCvC8DHP8HsyCJvgBjtNkMzj43nfMym6nLDIx4OYes0VpFooEDlLLm848kf7Zqzi9xjiX6hd6WqU7KM/rXMwJT/08H+if/PFfyWw2Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 13:06:48 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 13:06:48 +0000
Date: Wed, 8 Jul 2026 15:06:36 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 25/36] sched_ext: Add the
 SCX_CAP_ENQ_IMMED cap
Message-ID: <ak5LXNSj0buDiPMz@gpd4>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-26-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707001229.1410929-26-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 097a4595-601f-442d-8a73-08dedcf1c50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|3023799007|18002099003|22082099003|6133799003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	/d+NWzngfBHd4apthTPTD0PyR23vWG8Sjky8RqItRoI+LLHBWEQ7Tw2V8Zl3Og/ZSWRsPgiC7XeWhPp3NtM1j7x/Odo1OOuCx+eaoysG1sH4L4a3orhdBIvOk9uCkK49U6jfdWa1YyBHzVN+KenhnlmdoWZEGEsy0WwhxX3qY93URkWgymRGPlebib1qVwsTGWtXpsqVusHpK8jHfJGxQ2EspSxctABG8Zrns0fOXfOfkIT/kRjleUfFkJrV99cHV5zu4aFyAZJ3FFhzaP8EJB1e0m2Fb2NaWI8GYu44l2rNW3zuCcPjfngKDbZEAJPWx+4QDUMQC3mtCMh2ITOi4jD4msFkgsYOYUm5lPAAUt82sp+6i/AKJUoNJMmiWyK0ELPp2DIpNR0g9dA1v1uqpKgW8Y236b19FpTZi9HkjVwaY5bRPazaKKZhee12meRsLBS8eAMI8yUZIvYAJ8cFP/8bKFDfSzMGplCEAV+KNxx3uf8jwBWpSgOffC7We940qq+1BQIHW4lPURxxIMsWQEiYJThdeZVcL/NF2OTQgx8FUEyQnSZ1O85ADyOEJGi6FQ4w2wEbv0cqMXP6akXLyPez//mrk6IEtXU9Utoe2QRGKwZ92N/hHSKwea/woGMAP3Bd0aDaXXZELJWRIgzEbspBsCbCldYgWpkyZnW0pgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(3023799007)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c21oeDFGRFZXSkV4SHh2c2EyYVhRck54MFNRTFgvTk5kZzUxRkU2MG0rZ3ZP?=
 =?utf-8?B?U1Izczh4YlRRZUhOTHdJOWZHTmRqcG55NGJKU0JRVEI1SmI1a2JFUTZEVDQy?=
 =?utf-8?B?WlVldWlSbHBqbkFaVUxxN2dLS2IvS0JLcVhYZHp2Sk82SlNCVExGSGJMb2Rs?=
 =?utf-8?B?MGVXOGZyUEl1WTB6dDhmbUFzYXdjWDdFWHZxbmhTNlJYRko0RUV4bWFDWVVE?=
 =?utf-8?B?cXBWMzcyVEVLdnJLZ3RoNTdmbUlxd1JCSDJDTWE5UW9TcXd1Rk1jVm9HTDh5?=
 =?utf-8?B?RTRNTkhEYmh5NEIvWkRsSFFpZm5KUWtoNmo3QXUxRWNnQUxaNEoxcFBscVhY?=
 =?utf-8?B?VUNjUFUweUtCd21jMWpGbUJlN3VnaG4zUDZtN2FWWkRrbXZnclRRd2NndDZR?=
 =?utf-8?B?M2FEUEJZREVEdGhiRzU2cjgzdHR3NDh4WDlvTDdXQWNnM0pXallxSnplcENE?=
 =?utf-8?B?WmpDZ1N1Q3dicEFtVjRoWXk2SG1VUUdSYm5KN2FOcysxYnROMnZ3d3RnTGpi?=
 =?utf-8?B?cnV2N1dFb24wQkRqMG92UGVvY25VUEVWZ2lkRkNSTk9oNk4rVmRSd292YzQ3?=
 =?utf-8?B?N1JNVklnSnBBNDR0M3hrbGlhTytZV1NMbGo2WEZtSDJtdjRUK2ZTZUl5cjlj?=
 =?utf-8?B?WStLWFNqMDBzQkRYeEN5ODlyMStsbHJ0Qy9jNGJxZzBHNVdxU0JQTDk5dWZj?=
 =?utf-8?B?ZEhiYmE5STJkSFVNNHI1Nk45OW5nUFBGekhNbHdyVlZCM05tRVQwOXIzM0Nx?=
 =?utf-8?B?QUZHampuYU5sb0NNdnp1UUlIVTZna3hPRDV0WmdJVGwzK3FLMGU3UFU5Q1Ro?=
 =?utf-8?B?TXNsNTliK2YwN21kQ0dkdE0vSHZNaGtGOS85NUtDditMeGJyMitJYktoYklw?=
 =?utf-8?B?YkprczdMRlMvTjdhNWdyaTJNaGZFNDVlQkJVMVo3YXRaYkJlVVBlcE1UM2Yx?=
 =?utf-8?B?enlFY2FKL1RteVB4dS9XVXRXQjdvY0wwaHMyWkdKS2pmc0ErMGh3Rkg3NWFO?=
 =?utf-8?B?QjB5em5GeUJhWm9NTVMyNkVKY3VqWGx2SzI2WEFIcE93dHVKeVdQbjR1MlJi?=
 =?utf-8?B?ZHR2ek5ZenkwLzYwQ2ZPRUdsUTYvVzFENXJmSjcxWUxWRHBZd2szZDZPVWl3?=
 =?utf-8?B?OUpqUytJenpuUkpJMGU5bFU2OHZxOXNkU21INzdldzB3cXVlRnNTRy91TXE2?=
 =?utf-8?B?VTc0Z2NuU2cxVm1GMXU1ZjgxbVR1Z2VVR25xTlFzbTNEajN1R3FqQituaWQx?=
 =?utf-8?B?ZGVubWtqU3Bjd05GOW9zQWJhbVFLOStPd1RmSTdqYkJtTHJOdFhldFpyakVy?=
 =?utf-8?B?M0J3eGVqc0FjWmRtdUZFdysybTIvdVJ6S0R3MGo0bzhHYkZDMms4MFZySnhr?=
 =?utf-8?B?YlpEb3p1ZVNQTVF5RGlKZ0RuMXNmbEJkNWpUZGY2d0gvemNkRTI3SnkvSDRX?=
 =?utf-8?B?ZFgrL1crUk4xWHA2Q3AyUngzV28waEd0Nm9vVldDY09TKy9WOFRDV0RaVXVm?=
 =?utf-8?B?aTloQ3UyOUd3MlNOY1dPTjZUUEdoQURzS2NFc0FJMkR6SXFPQ3dLZmkxWkRW?=
 =?utf-8?B?Z3U5RXppbnpFcmVJZ1YrbnFaYUh5Z2hndlFjcTFGL1pjRDdkN1Nrc3lldjFD?=
 =?utf-8?B?Ni96U1hDZjlvRXljbUR3K3ZIbS96czZmdEVjN1p2Q0dpTEYwbGRxZ2NsZTRY?=
 =?utf-8?B?OGlET2I0bzFMMDBiT1QwU25EM3ZkNENLSy9XSEZHM1l0QzQxZFYyQ3VsR1E5?=
 =?utf-8?B?YzJkWEloRWpkanVqSzRuSWFtYUdqdkhveGk3YU83R0VRLzUzdGJFTi83SkhH?=
 =?utf-8?B?c1NQQWt4M253UklIYVRMc2tVUU0zSWRiSjdDNUlTdWlmekJTeFgrRmxMV2Jv?=
 =?utf-8?B?d01BQU5VNFVrMURMQ2RSQm5BeEpxMGhjUnVlMHdNanFUQzVqN0R2a2ZtV1ZB?=
 =?utf-8?B?TUpqMDJOQjVHbFBWaDZtWTIwdlQzdjdQNnFLUkxYcE80QXZjQWFNNmZEU05z?=
 =?utf-8?B?R3lEVHkrR2o5WXZXVWYwSmRXaTdIYnpyN0dEWVpMZDZ4cC9aNkF4MFprKzQ3?=
 =?utf-8?B?WUc4dlZOLytXZWl1OHlZdjlCemZNLzN6by9Yb1dBSU9ZcTlkbWc3RlY4TEtF?=
 =?utf-8?B?TEsxa2hJT2dxRzBZQ2NNWWJsWm4yQk9mQVNWR05LaWwwYjJPczZaV0kzY3Nw?=
 =?utf-8?B?RzRXczFNeWtQbGFOb05CSGloaWU2R2lVNGZ2bG5ZZ0NOaVBsWnJQNUw3MjN6?=
 =?utf-8?B?Nm1VQk9yR213SUlOTFN2SkE5a1ZCK2FKei92RDk4RnlrZzI0NjNpVTNxeXpJ?=
 =?utf-8?B?Vncra2FYd1htQStHYmllaDc2UWNwWENYaXB1UzFGTXdqOUtFRSswdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097a4595-601f-442d-8a73-08dedcf1c50d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:06:48.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqGW1ug0qfHb4ibJtPc5UZHH9o4EfvDkEtJyCtIYZHlOgeGCZKxGHxQHckS2ja1FG3pD0w95LqMA7JzbZzpn8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466

Hi Tejun,

On Mon, Jul 06, 2026 at 02:12:18PM -1000, Tejun Heo wrote:
> Replace the __SCX_CAP_DUMMY placeholder with SCX_CAP_ENQ_IMMED, which gates
> inserting IMMED tasks onto a cid's local DSQ. An IMMED enqueue is guaranteed
> to either get its task running on the cpu at once or hand it back to the
> scheduler, so IMMED work can never pile up on the cpu's queue and a cpu can
> be shared across sub-scheds through IMMED access without any of them
> swamping it.
> 
> That makes ENQ_IMMED the natural baseline, the minimal cap to make any use
> of a cpu. SCX_CAP_BASE aliases it so gates on basic cpu access can state the
> intention instead of naming ENQ_IMMED.
> 
> Enforcement covers inserts and queued tasks. An insert without the cap is
> diverted to the reject DSQ, and queued tasks are reenqueued when the cap is
> lost. scx_bpf_sub_dispatch() skips a child that lacks the cap on the cpu, as
> its inserts would only be rejected. Vacating the running task on cap loss
> lands in a later patch.

I was able to trigger the following RCU stall with scx_qmap attached to a "test"
cgroup and running `stress-ng --race-sched 0` inside it:

[  183.913108] sched_ext: BPF sub-scheduler "qmap" enabled
[  209.915162] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  209.915521] rcu: 	6-....: (0 ticks this GP) idle=a794/1/0x4000000000000000 softirq=3550/3550 fqs=6500
[  209.916217] rcu: 	7-....: (2 GPs behind) idle=fc7c/1/0x4000000000000000 softirq=3550/3551 fqs=6500
[  209.916581] rcu: 	(detected by 0, t=26003 jiffies, g=35149, q=153 ncpus=16)
[  209.916799] Sending NMI from CPU 0 to CPUs 6:
[  209.916820] NMI backtrace for cpu 6
[  209.916827] CPU: 6 UID: 1000 PID: 12259 Comm: stress-ng-race- Not tainted 7.1.0-virtme #1 PREEMPT(full)
[  209.916833] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  209.916836] Sched_ext: qmap (enabled+all), task: runnable_at=-26004ms
[  209.916839] RIP: 0010:check_chain_key+0x15e/0x1a0
[  209.916849] Code: f9 67 48 0f b9 3a eb 21 e8 af cb 50 00 48 8d 3d 38 3d 45 02 41 8b b6 40 0c 00 00 4d 8b 04 24 89 da 4c 89 f9 67 48 0f b9 3a 5b <41> 5c 41 5e 41 5f c3 cc cc cc cc cc 90 e8 80 cb 50 00 85 c0 74 1c
[  209.916852] RSP: 0018:ffffc900001d8de0 EFLAGS: 00000046
[  209.916856] RAX: ffff8881392253c8 RBX: ffff888139224780 RCX: ffff8881392253f0
[  209.916858] RDX: 0000000000000001 RSI: 00000000e23450be RDI: ffff888139224780
[  209.916860] RBP: 0000000000004051 R08: 000000000000e304 R09: 0000000000004000
[  209.916861] R10: ffff8882b381a000 R11: ffffffffc002f373 R12: ffff8881392253c8
[  209.916863] R13: 35590c0ea7cde75a R14: ffff888139224780 R15: 35590c0ea7cde75a
[  209.916870] FS:  00007fb7c6b86b00(0000) GS:ffff8882b381a000(0000) knlGS:0000000000000000
[  209.916876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  209.916878] CR2: 00007ffd98a3b7de CR3: 0000000138ec8000 CR4: 0000000000750ef0
[  209.916885] PKRU: 55555554
[  209.916889] Call Trace:
[  209.916892]  <IRQ>
[  209.916896]  __lock_acquire+0xcf9/0x2a40
[  209.916905]  ? __irq_work_queue_local+0x67/0x120
[  209.916909]  ? arch_irq_work_raise+0x26/0x30
[  209.916913]  ? irq_work_queue_on+0x3e/0xa0
[  209.916915]  ? scx_dispatch_enqueue+0x2f4/0x460
[  209.916922]  ? ktime_get+0x1e/0xf0
[  209.916925]  lock_acquire+0xd3/0x280
[  209.916929]  ? ktime_get+0x1e/0xf0
[  209.916932]  ? irq_work_run_list+0x93/0xc0
[  209.916935]  ? ktime_get+0x1e/0xf0
[  209.916938]  seqcount_lockdep_reader_access+0x34/0xc0
[  209.916941]  ? ktime_get+0x1e/0xf0
[  209.916944]  ktime_get+0x1e/0xf0
[  209.916947]  tick_nohz_irq_exit+0x4c/0xb0
[  209.916951]  irq_exit_rcu+0xe/0x20
[  209.916956]  sysvec_irq_work+0x73/0x80
[  209.916961]  </IRQ>
[  209.916961]  <TASK>
[  209.916963]  asm_sysvec_irq_work+0x1a/0x20
[  209.916966] RIP: 0010:preempt_schedule_irq+0x4d/0x70

I bisected it and this was to be the offending commit.

IIUC, what's happening is that qmap grants the child CPUs 2–3, but race-sched
stressor can pin its tasks to CPU 1. Since the child has no enqueue capability
there, the tasks repeatedly land on the reject DSQ and eventually trigger the
RCU stall.

Maybe we need a forced fallback when a task's affinity mask has no active CPU on
which its scheduler holds SCX_CAP_BASE?

Checking this only during sched_setaffinity() won't work because capabilities
can be revoked after the affinity change succeeds. What do you think?

Thanks,
-Andrea

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/ext.c      |  2 +-
>  kernel/sched/ext/internal.h | 11 ++++++++---
>  kernel/sched/ext/sub.c      |  8 ++++++++
>  kernel/sched/ext/sub.h      |  4 ++--
>  4 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index d0966412ee42..d4e4340fdcd8 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4752,7 +4752,7 @@ SCX_ATTR(events);
>  
>  #ifdef CONFIG_EXT_SUB_SCHED
>  static const char *scx_cap_names[__SCX_NR_CAPS] = {
> -	[__SCX_CAP_DUMMY]	= "dummy",
> +	[__SCX_CAP_ENQ_IMMED]	= "enq_immed",
>  };
>  
>  static ssize_t scx_attr_caps_show(struct kobject *kobj,
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 7cc7e10457d7..5d4edd505ed1 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -1270,17 +1270,22 @@ struct scx_sched_pnode {
>   * topology-aligned and likely to serve as the locality unit when cids are
>   * allocated to schedulers, so per-shard lock granularity scales naturally with
>   * the allocation pattern.
> + *
> + * ENQ_IMMED  insert an IMMED task onto the cid's local DSQ
>   */
>  enum scx_cap_flags {
> -	__SCX_CAP_DUMMY			= 0,
> +	__SCX_CAP_ENQ_IMMED		= 0,
>  
>  	__SCX_NR_CAPS,
>  	__SCX_CAP_ALL			= BIT_U64(__SCX_NR_CAPS) - 1,
>  
> -	SCX_CAP_DUMMY			= BIT_U64(__SCX_CAP_DUMMY),
> +	SCX_CAP_ENQ_IMMED		= BIT_U64(__SCX_CAP_ENQ_IMMED),
> +
> +	/* alias for minimal cap to make any use of a cpu */
> +	SCX_CAP_BASE			= SCX_CAP_ENQ_IMMED,
>  
>  	/* caps whose loss strands queued tasks, see scx_process_sync_ecaps() */
> -	SCX_CAPS_REENQ_ON_LOSS		= 0,
> +	SCX_CAPS_REENQ_ON_LOSS		= SCX_CAP_ENQ_IMMED,
>  };
>  
>  #ifdef CONFIG_EXT_SUB_SCHED
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 23686c609336..778ae3f6f91f 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1270,6 +1270,14 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
>  		return false;
>  	}
>  
> +	/*
> +	 * Skip a child that does not effectively hold the base cap on this cpu:
> +	 * its inserts would only be rejected. ecaps are synced at the top of
> +	 * balance_one() before dispatch, so this reflects the in-effect state.
> +	 */
> +	if (scx_missing_caps(child, cpu_of(this_rq), SCX_CAP_BASE))
> +		return false;
> +
>  	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_prev,
>  				  true);
>  }
> diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
> index 51400e174cd0..f3548976800b 100644
> --- a/kernel/sched/ext/sub.h
> +++ b/kernel/sched/ext/sub.h
> @@ -106,13 +106,13 @@ static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
>  /* map @enq_flags to the SCX_CAP_* bit required for the local-DSQ insert */
>  static inline u64 scx_caps_for_enq(u64 enq_flags)
>  {
> -	return 0;
> +	return SCX_CAP_ENQ_IMMED;
>  }
>  
>  /* map queued @p to the SCX_CAP_* bit required to stay on its local DSQ */
>  static inline u64 scx_caps_for_task(struct task_struct *p)
>  {
> -	return 0;
> +	return SCX_CAP_ENQ_IMMED;
>  }
>  
>  /* caps implied by holding @cap */
> -- 
> 2.54.0
> 
