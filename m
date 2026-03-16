Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90172C0270
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672182; cv=fail; b=P6wcjsyOr6BBqGigpQ3MzAYbFKtpkKggguYQvmme3jx5H2LUpyjwLdCExoEIDwyAU2/M5o4bVq6EgtyXBqZudc3KJcf25ouJ6mpSEkBnW4X2a7SPDE0/r59phahChYI6QuJ0W1qNVz+hy9yk7Todsb4ZCQe9C760i7NJn5kGp5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672182; c=relaxed/simple;
	bh=9auMUbx6ihBBXD2FhavYPxahR8zfgHZ98JUlIPZ6Xo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CagOr2lQutUm5M3VWXpuLUsg4fViOdQOvilyb1QPBqjYVUnlnpTqgFVGDPb4QTQUY8fJZDpwTsQiKYFlRMTtqocQfm1FL87056R2X94P6XPhU29MYUxaiW1031iQCEuucKwL7AAuZUfidi3DSwcPCZvM9pq94HtgdKDJ+9iEToQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mhoIfkOI; arc=fail smtp.client-ip=40.107.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mhoIfkOI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sT5+iJX5JKgZhyfOuT7BAvNZ3BHdWweukY40EImwb6RRKBeFI//XCzbw7uaAMBNIcTiEwyJFBxXFReS+gmxbHW5BQR8g2II0L6ERdtNh3RjC5T7gI8RoBpsELu1B/XE3Yc05Pu+2wQrgvhkWN1jxbZgHwcfJXHjKprFzkuXf9NyLL5HBYuQlSqCQO1qobHg2JaYa2f6WeIplo9+Yl6frgiP6+IGNZdo0dl8TdMBemLsZaL+P38vVriaWA3YuC9ghXNxZoqxKVApXP+DWjA7rpl4d3UWNZUVSzsa/72IPoNocskn0a41vkTET5aVBplzmedN2DfB4pfXTnFBNoWWw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIpFQDNgwtM+CQ6l7kxrisLsHFMuakhK1ZbrvcNhA5E=;
 b=MmScW2aD0TEwkUf+W6+TA0HKnhrripNYt+6fphp4Hr/DYD+GvX+rcgNd3Mr5o6UP+xm/2otp3JJ7LbGO8ggS2wSKDWC2FXUIyXXOfshTPONZMy6efR4hpV4Lh2L8qzNJkOn0Ms5cw35IhoDSraG2qb4xdgdc233ZbCFsXJb/b9PxG0avYYMeK1APZbiS8HB/+GCtr/5KlqtPBRtURaeyy7xo+9jxVW5tuP4jxFtRO3YDyxUMJOgxJTKE4X5QrSStIqgDy0BVlhP5o3WDLJjn2TSFZU3BlgzhyjU3rYnK3pDJbPLiwjfw0ojZCu/oXxyEcLVgFY4RR0T28Ldtqgjw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIpFQDNgwtM+CQ6l7kxrisLsHFMuakhK1ZbrvcNhA5E=;
 b=mhoIfkOIyFrZqvfNS5sNvaCz1XGnXJ3NGiQ7oQiuO+rCdIKTPWzfLe5Eb13bVha20dnxwrCcsIW1p4ArHYgXpJ+T278o+2hT6tBkl0yp5UlcglivwhF6doCmnwR0FxRc7mOikRlUfvC4QkDEjx50kUa+HoqZ455MeihT/a3Cz5SQSVQall4+A2b25SOGncHjVpaCrmA6zLRMtR/nSqJSJHWd2K9WiOe/ZmIHCtEwglTiz8D9q3p+ZjFZS0za7V/qIjXTZ8ZYLUTbPozVwXMwhYX/AYT5FmtJYK0C87wN5irJkLOjXlWwYTt4lMiDAGRgH1VUh1KvYii3D4AaP+CL8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:42:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 16 Mar 2026
 14:42:57 +0000
Date: Mon, 16 Mar 2026 15:42:47 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
	shuah@kernel.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/2] sched_ext: Prevent SCX_KICK_WAIT deadlock by
 serialization
Message-ID: <abgW57af9nXrXHxN@gpd4>
References: <20260316100249.1651641-1-christian.loehle@arm.com>
 <20260316100249.1651641-2-christian.loehle@arm.com>
 <abfgRv5DkOnCzz-q@gpd4>
 <1e72dc1d-ce46-4dcd-9811-761221fa20c0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e72dc1d-ce46-4dcd-9811-761221fa20c0@arm.com>
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 352df937-269c-4524-3042-08de836a503e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	b+hOOd2gY+AEIRp3yNu8CbMs8vsOAE1VHgEToUWOjh+KQZGVC1LNkLrrM4RUFg6FBrPcIPxEY73SgBwEdKyh+UVaJo3PTQJTB69PRxWkKxxLg8xA6fcvrJFqFHYHNwycvmOhvZTPPnei7k4vB+zaxZcsz0AwUfeejKLk0QFJKSM5NBlicLpP8fv+6gJ10rmL6zhiyYJeRhkGenB0AZJyib21pBFjWKdDVBpXaKgdVZhxcV71bKGNEJ89DUu5BJQthJV20VZQ5xPLp68qGbUkKszsw3M4wr9V19t5IGp4ZH86+k3NPiXKDW7zM1jyX8rIF4dGm4pm9RiDqktY0NdTyLeep19+VlDkGuAs6exSVup5GAMWnLA7S3jB2P0iK2Lx6oDOHJZRaSk8YCFnI+nfT6jB9WkIYGcozH2MdYt/hxXdvP4WWLyORD/UOlYwqIJY4JbNJ8NHBvZbJ8P8jyD7GsF94uPZwfdaVRu10zz19ApGSVJJewyOmRYKi+iNpRGHQcljUOirr4f9HVeOUplMtc5vKto+JnWr9FQyDsqGmcPu8qpVuGORjRkBC1fgaQHBC2gq6XAFnyS8mN5SaX+GYbi5CCTRaRR/13uywJUdrHIExgA9zt6F++r+R+LmBfUWlJMDG/IAmTjOVHDzEfPAT3Y0vORTqL6+K4A3DsvIlDLMheaPObG3mtlsKwvQa336E35wclGj4GycYQ1653Dm1kQe8YRARpawSP697L013ks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTJyb1lTUHFEaDdTYXpEUHVpRHlVWWxZc2ZsQXB0TUxxUkU2N2FocGRpM2s4?=
 =?utf-8?B?MHVPK2IwOEhLYzc4NmZGWVF4Q2VRdyt6aVZaWjdHY2t1Zmp6MEpmT2tUaDZN?=
 =?utf-8?B?a05Canp0TG9NalpHSjI3VWhaTGthVDNORU01K3ZBcGxDeGdKQU5KN2psV0w5?=
 =?utf-8?B?eGo2Y2NXaVlFLyt1aHUzZWhQTjdzdEJxMitKUnlrTWEvNVpUMDdQNHoreE9k?=
 =?utf-8?B?d0hmbmJ5UysrRm0rTk5tU2NRVzFkSDhDbHNFWElOZnRJc0lsZVZoMDhFdkZE?=
 =?utf-8?B?R3JsVWJHNWNEM1ZDMFBONE92UXlpZGNPUU95MkFBL3BqVXpabDk5WE9wdDNX?=
 =?utf-8?B?M0NzYWZuLzBOaTFhWW03T2F2cjlNT2doZ2doZVJjK0NmWGk5ZURyZ0tzK21R?=
 =?utf-8?B?cWs3WG1FNEh4VGtVMHB3QWIyRUl0aVBENlY4d01yNlU1KzJ5bXB6RXZVTTVs?=
 =?utf-8?B?UFM1L09rR0J5QURpTlZsQW56MC9XLzBPVDJpZ2dXQkt0OXRkZUs4RVVBQWdN?=
 =?utf-8?B?b0oybXRzUmJBclJLSm5nSUhTaEVOaDF1bWJkVjVmMG8yQ2dXYkJJY2VSVU9Y?=
 =?utf-8?B?b1Q5RUkyRUJMQ2NrRkdzU1hnRk8zQld5cUxBSEYvKzVoYWJXcjN5S2MxT1oz?=
 =?utf-8?B?cDVoVWROWTZndVh5ZGJGK2d5MUllUWlVSWVmNE5zZTNLNGFiNzl3RXVoTVhG?=
 =?utf-8?B?OWo4M0g2S3RocENWOEt5QkxONU5GVVNFeWdGaVRxNXdsWHpoMkNwYlRjeTFp?=
 =?utf-8?B?WGJpRHV0S2xIbHg0bnR2S3UycXhCMWlWRGVTbVpiQ2grZk5Xc2hpd210ZmRD?=
 =?utf-8?B?Z0J0amF6bU14VVMrT251ZkFMUlQrMFpCOGJPVkVXUkNCSkg2VklWaWtPUmRL?=
 =?utf-8?B?Mnl4eWtDU0NsK2dwRVd3QjBsRjhRT3lyT0JWL09ZUmRYUWFKK1dHV01ENkM5?=
 =?utf-8?B?R0h0c29LTzZWcU5tTk1nYVdRcSszUGFXbnBFam9XMEdRRVlYUmxibkRTTVB0?=
 =?utf-8?B?ZjBCYmpxTGYxb3hyNk41QlNnbk9FL0xra3ZOcjlQdzk3NVdHUmhJTXJ1YzNZ?=
 =?utf-8?B?R3hGQ1M4Z3p6NkZPNnJJdm00MHJjME0vWUF3TEs5N2V3Slc5OHZmcFV5NFEx?=
 =?utf-8?B?NjVsVzhQY3ovc05pR2haZll4OE9MdUtDR1VlaTNVQm83RUJuNGlFL0pYMG9N?=
 =?utf-8?B?RENnOWt0bUZyM3VPcDRQaTdwYW45REorK0JOV3NxQS92dDByM2duS1BnTFBX?=
 =?utf-8?B?TXZPaXpOZXgvVXpUbENzTHNkMXNuZXBUVmw3K3Yyd1Vpd1RBZFp6VnA3clB4?=
 =?utf-8?B?aDI2NEtSZ21HTEkzSmQ3YW0xT2ZjbEM4U2VDNG4rWGJvWXFvUjVROS8yNTZK?=
 =?utf-8?B?ek5jejRLSGI3NUl6WkpPNlhNdnU2NzcyNVFJTTZTTXI5T285M1RUK2hWWGlu?=
 =?utf-8?B?L3piMENiaW9Vam9ic01WZ3ZtdFZFTlE5Mk9oUUFzZjNCckpiRThoM0hqNDhH?=
 =?utf-8?B?SjFmdmpQN0EyeE5YS0tHQ3lHNFZQL2x4bHZhNERyanM4WnNyeWFBZWl6L29D?=
 =?utf-8?B?SGoxV0xNQnphRXJDMXhTWE85YWYxaVZUem1LN0luWThiNTgzN1pteU1rUE5S?=
 =?utf-8?B?RGFBd2MzR1BiUlBhMlAyY0Q3Lys1dzNoY0pCL0lHalJubU4xN05kUy9hT21D?=
 =?utf-8?B?eFhXbWtHc2JuT0E3ZGwwcHFnRHdieEJRSEwzbzNvMWo0a1lyYStFQ1JCdUJj?=
 =?utf-8?B?N2kwRlk1c01EdGZJamtLNEN5SHJ3V1RtWlFyL3V4STVFaEM4WlIyRmlRTWlF?=
 =?utf-8?B?VFZuNS9OUW9jQkFueHB4WXB4bmNvckNDbDltalNTdXpzSkJkclM0bTl2QWsv?=
 =?utf-8?B?ZVZteURpR203T2pad1daU01FTE5VM1JCRGhJZXE3MlBWRm5iOVhpTGtkU2pV?=
 =?utf-8?B?MlpoV1BEOURBV2c0ajMzQmRMcEVzcUJuMklIVTFMeVpSLzNUbktVT0VydlZJ?=
 =?utf-8?B?cjUxOFlYZDVtS3BGRkFYVGhJTzZBTjNuWXNEQXdKR0RvTVFncFM0ZEtRRGx6?=
 =?utf-8?B?aSszbVN6TjdzTDJxMUI1Tm1LY09ZVk8vd296VUllK1NVc0VVZFZpakdILzBT?=
 =?utf-8?B?VU55RmJyblIyUTg2WCtPTllhNHpudUZWVEdhTktPbjlMVWxRZlA4UWZ3T3l6?=
 =?utf-8?B?dElGRnZ4N3EyRU5lZFY5WGZkc2ZvU0kxQ2Nkd3h5K09DZzBJTktWeEdWdUg5?=
 =?utf-8?B?ajNUcWhiQWVJb043NHpkM25lYlZKQVFGV1M1ZHZNektvYkFacUpVcjdBWnFq?=
 =?utf-8?B?bk4yQTlvWDVLamlNeEJBLzh4eXVkK3l3Q3p3ZzZaaWxLejBZOHJWQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352df937-269c-4524-3042-08de836a503e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:42:57.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66tWVdyXWSbEAjeQkdfX8uE5TO0JwE2+cpcxaRpV+bomVrk8mA95M9JxqTvsaf5UzCsKnaXANjzuMLgLz8KlCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956

On Mon, Mar 16, 2026 at 11:12:43AM +0000, Christian Loehle wrote:
> On 3/16/26 10:49, Andrea Righi wrote:
> > Hi Christian,
> > 
> > On Mon, Mar 16, 2026 at 10:02:48AM +0000, Christian Loehle wrote:
> >> SCX_KICK_WAIT causes kick_cpus_irq_workfn() to busy-wait using
> >> smp_cond_load_acquire() until the target CPU's current SCX task has been
> >> context-switched out (its kick_sync counter advanced).
> >>
> >> If multiple CPUs each issue SCX_KICK_WAIT targeting one another
> >> concurrently — e.g. CPU A waits for CPU B, B waits for CPU C, C waits for
> >> CPU A — all CPUs can end up wedged inside smp_cond_load_acquire()
> >> simultaneously.  Because each victim CPU is spinning in hardirq/irq_work
> >> context, it cannot reschedule, so no kick_sync counter ever advances and
> >> the system deadlocks.
> >>
> >> Fix this by serializing access to the wait loop behind a global raw
> >> spinlock (scx_kick_wait_lock).  Only one CPU at a time may execute the
> >> wait loop; any other CPU that has SCX_KICK_WAIT work to do and fails to
> >> acquire the lock records itself in scx_kick_wait_pending and returns.
> >> When the active waiter finishes and releases the lock, it replays the
> >> pending set by re-queuing each pending CPU's kick_cpus_irq_work, ensuring
> >> no wait request is silently dropped.
> >>
> >> This is deliberately a coarse serialization: multiple simultaneous wait
> >> operations now run sequentially, increasing latency.  In exchange,
> >> deadlocks are impossible regardless of the cycle length (A->B->C->...->A).
> >>
> >> Also clear scx_kick_wait_pending in free_kick_syncs() so that any stale
> >> bits left by a CPU that deferred just as the scheduler exited are reset
> >> before the next scheduler instance loads.
> >>
> >> Fixes: 90e55164dad4 ("sched_ext: Implement SCX_KICK_WAIT")
> >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >> ---
> >>  kernel/sched/ext.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 43 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> >> index 26a6ac2f8826..b63ae13d0486 100644
> >> --- a/kernel/sched/ext.c
> >> +++ b/kernel/sched/ext.c
> >> @@ -89,6 +89,19 @@ struct scx_kick_syncs {
> >>  
> >>  static DEFINE_PER_CPU(struct scx_kick_syncs __rcu *, scx_kick_syncs);
> >>  
> >> +/*
> >> + * Serialize %SCX_KICK_WAIT processing across CPUs to avoid wait cycles.
> >> + * Callers failing to acquire @scx_kick_wait_lock defer by recording
> >> + * themselves in @scx_kick_wait_pending and are retriggered when the active
> >> + * waiter completes.
> >> + *
> >> + * Lock ordering: @scx_kick_wait_lock is always acquired before
> >> + * @scx_kick_wait_pending_lock; the two are never taken in the opposite order.
> >> + */
> >> +static DEFINE_RAW_SPINLOCK(scx_kick_wait_lock);
> >> +static DEFINE_RAW_SPINLOCK(scx_kick_wait_pending_lock);
> >> +static cpumask_t scx_kick_wait_pending;
> >> +
> >>  /*
> >>   * Direct dispatch marker.
> >>   *
> >> @@ -4279,6 +4292,13 @@ static void free_kick_syncs(void)
> >>  		if (to_free)
> >>  			kvfree_rcu(to_free, rcu);
> >>  	}
> >> +
> >> +	/*
> >> +	 * Clear any CPUs that were waiting for the lock when the scheduler
> >> +	 * exited.  Their irq_work has already returned so no in-flight
> >> +	 * waiter can observe the stale bits on the next enable.
> >> +	 */
> >> +	cpumask_clear(&scx_kick_wait_pending);
> > 
> > Do we need a raw_spin_lock/unlock(&scx_kick_wait_pending_lock) here to make
> > sure we're not racing with with cpumask_set_cpu()/cpumask_clear_cpu()?
> > Probably it's not that relevant at this point, but I'd keep the locking for
> > correctness.
> 
> Of course, thanks. Noted for v2!
> 
> Are you fine with the approach, i.e. hitting it with the sledge hammer of global
> serialization?
> I have something more complex in mind too, but yeah, we'd need to at least either
> let scx_bpf_kick_cpu() fail / -ERETRY or restrict kicking/kicked CPUs and introduce
> a whole lot of infra, which seems a bit overkill for a apparently barely used
> interface and also would be nasty to backport.

Yes, the current approach looks reasonable to me, I think the potential
latency increase (assuming there's any noticeable increase) is totally
acceptable in order to fix the deadlock.

Thanks,
-Andrea
