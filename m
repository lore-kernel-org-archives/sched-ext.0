Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2338911B
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784384627; cv=fail; b=qc+k2cyCrfsJso3I5eSClHH7QiIrgeuLzUTcTCk9aQ/hCZaZtGJT5QyCY3tvMm9/GVn4R9D9+xyrSJFuHHDPw6OcnIu91EMGC2QRTZHmwZgttXW01w5GNHo1c3ZzXduJRzqTtM9v5gSltu9g9AFGlz00dQS1BGYBxOUcFWtwlrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784384627; c=relaxed/simple;
	bh=SIVesZ97lfbOEHNjYBTi16Y3+osOa0Od6rj2D/hSyIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j+KE/HJPRvVuaF4ucL+cO9eScAD41I+MFiKyK9qTlCsSf8FQIzJyB0+XIRlf70CEoDP0jrY6bIRMPcc8dNHiJdAlwyOxTwP0zTJGsCYdlNx1xgZTUyxDbQRa1cs41nsYsXgOlNZ0yG2Tv4lKdIvLBS3LhX37h4OH+aGOaF1y2IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h+gzoP81; arc=fail smtp.client-ip=40.93.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h+gzoP81"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTz3ijvtv20Utft8Q5DT5vw06PP/tV7vLZvoqKe3XLOqkAnVrmi59o8v1AON2K9wnHqAYkj1Kp3qrZHdjK1fc4YXkjEMai2hJ3IcCg2wqFneblf/y7y7HRYiN6PUiTh4NwpiRBK0CLMb2BB5x5o1J0AIPyN3CAeEwi5DpIgg5pdXPESr9c+Gw9jlItdETGrTy+We27NWk+iAoEoFL6lsIOfswubzwt7IAE7AKn1za1CaRfCvJm7LPMdmT3D6mR0zIc7eNH9CSff+DBxPLlSAAc6ZJuUNV8/AvJ0MU9syJrXz/qTv8WBwgmaqG6S7fs6PRkQ9cDJT5pxPLO9+a1/kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY5kRyE6uKQISkOdu3pbGtcynSMhxe35jS8Vu7WB6oI=;
 b=j7yPnDtfce6GaOzy9J1QpAcIha3z1AFgdg3k4jhHPLfxNHNpuzdW++oyPW4jP61TbIpwAYD97Acau56HozRjUyRxkDAT9Ig86K9ecpSEf7x9DlMwaVGq43HfODhPUduHgo9Fdh0AemNW/CThPwyXk707kkqMlMxIDCbWc7w7cW9mRbZfD5mWMIl7+ChQcus+o8r0txf/L+psD9uF5S1Mbw0LKhFAUTtTbES6JD++N/JSwTrVgbMsIuVpwL3esl/kNm8zjl6e7mSnrMrII+MtCkPFT9gp7h4gP0NtWN0Gzwn12GwYFkcGZETAjUAz1+1WFfSKtinKoAtrMszmU720Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY5kRyE6uKQISkOdu3pbGtcynSMhxe35jS8Vu7WB6oI=;
 b=h+gzoP81XapQGlmtGgICooy78PRd6+b6qFy1rmxBVcG8o9cUffPAp0IxoMy8jQoWDrAreApeFxOACROAb/CHE2ojLRPLnh2MOFdU2Kv7sZHraNjvMgDc+GHirm7KDGkxR7acHlIsoaCpvmUE8hc2Z/AyNV6qUimXVzsdWhrxmRXzCw1ZGVgj7E0ETXsJJatmJ6nb7MEk6+lWQ99wU+/bLFvf0SA/xhHLbfssvpT/d9WG6sBdeCmDYIoxUxPPlxiWqdzTMnQYxDz2pTHpbE5RfoNBgx1fo3imySV+dxxXcCZNKsBj7tInL7Za+NFj6XxjLnrvWQePo+tHlm4Oubdc9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Sat, 18 Jul
 2026 14:23:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 14:23:38 +0000
Date: Sat, 18 Jul 2026 16:23:21 +0200
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
Subject: Re: [PATCH 08/11] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <aluMWf5H936NXA0N@gpd4>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-9-arighi@nvidia.com>
 <CANDhNCq4pijyx=h5mcqFji0hDQSOPDqkS7LdeYcUKNneX_wNsw@mail.gmail.com>
 <CANDhNCp01g3PN4=hZgCBLUn79_H++y8hyAr4RZP+C3MYckon7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCp01g3PN4=hZgCBLUn79_H++y8hyAr4RZP+C3MYckon7g@mail.gmail.com>
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2327da-4ab4-45d7-2728-08dee4d825f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|56012099006|11063799006|4143699003|5023799004|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pluStx2OHSRZTcDKLJw5PMOC/Gdpm7JHYWYNLbwjvP1FLFs+YYVi+mwz53kFCzbzXkggmohBO0uHhKfrNvTX8hSe0pOvN45MyovRuYwSbfwmW0IX1XX9yykVeUnyvolJOGhjaCRFBI9aBFt7M/OuDGv1wtBHLXRfHbmJ/wmrKUvhxy+8zHXzDGs2l6ySOFgOy5lXqh+ujWEXIzN8wNztgc/GS/Ldf11IbAZ+gz2NtrtHy6iI3SuA+NpiO0Er/+MFE+EpfgmVsyCGPFqfFwgq8g5MwLStEFl1IjoKFDrJG2G6NHm+bgM1ZCBbWPOwYbeMuvd6sOrPfAE2nPlKF6banUGg8qk1NpJAF3V+gsNhLFq+qStfuCTVLJHhOt9D3+CEGXNRUuepqPTk6S//Cvj1+cndFB0PuG17zofJ05SQNzEVwwna5IemtiN9yQcrnvU1gPM3tL1GnF1muvFghDwHystwpWSpXpXBDrNaB3kLLA2/UCLny2qRX2hZufOjSVwxO1y+xBa1gV67ZRNOxDHudSZJabGB3v0AC9QXNA4ZtrV0zpxtn31dh4GZLLeQ9R6prwUrGCLXpozLhJur+yB6DWAeNvktqHz6jwd1Z7U4c7V6229IRwa4L1HP8Xt4Dv5BnLdh7J6h5PyQCDGu8ktZLhh49SBUBwiHGm2zSaUKknk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1h4MUJIWjFiRGdvNk5yOWtVUmhhSUt4OEtEVEIrbTZIaG9DYnJoY3cyWU9x?=
 =?utf-8?B?SGZUVnc2UE5FRzdPOENja0oyeENweXlyMGZZN0N2UHdVRmxrbm1PWmNVMGRq?=
 =?utf-8?B?MFp6MWNiakU2VDNSdHpCMG5qSFNGUy9Rc2hzWnhkdkZLbU9iTTdNa1Z6TlZP?=
 =?utf-8?B?MkVIL1ZKZzFzb0FSdldsL20yd21qM0tRZDlnc2lNd2UvZ01CY3JMb0NWTCt6?=
 =?utf-8?B?aEpaamlmMndDY1BPQlE3U045b3ZrUnNNcDZDSEV1bkZodTFiOG9yT1NzWHRY?=
 =?utf-8?B?bitoUjhJMGdpV2xoNlFLUmZLZjJpVHEvcnVXRWhVVlVFMXJWOGQ4NFhoUFVs?=
 =?utf-8?B?WXM4MjBRb0g1Tmx1N0IrSTVaemJNNmkranhvMkFjc2FtMmlHZlFsVU81STNB?=
 =?utf-8?B?MW1PRkthaEk2N2J5YXdDM0FLblpGOWRXOXdZYWYyQ012WWlyQVlnMHQxdm10?=
 =?utf-8?B?SzJFTGlvVmRsNng0WlFpN1UxNnBTNGJoQ0VicGUwcnJJNHF2ZFIyazRWR0FD?=
 =?utf-8?B?VUZGQ2tkV09MejhKVGJEK1RObFN0U2pwcjIrNVlVaDNFZTc2c3VPV01rWVpp?=
 =?utf-8?B?bFU2b0V4YmN5VmdnRE9HSXp4ZnNtb2JkdlY4cWJreHRvcVdGL3FneEhJOTRY?=
 =?utf-8?B?aWdLZkszNEZVaFM4NkpITTMwZEs4c2lKTkNBVTE0ZXNjMG91a3NQc0JTQ3RI?=
 =?utf-8?B?eUJpVE53OUd1NDQ1cm5tRUYvMFFlYkYxckJoeUFtaDRiUWJYeEYxN2ZoSTNB?=
 =?utf-8?B?bWlBcGwzc3FncXh3RHZ2Q3NNWlNiSldTRVQ4ZzFUMTN6YWZVc0JGbWF4eHp4?=
 =?utf-8?B?L1lKelp1WDE4LytWZTRwV0dtMEE1UHNUUktFWUVVb3Iyd2RiNUoxd3JlZGF4?=
 =?utf-8?B?Q2VYeS9Eb2VjNG5Ka3Q3QytCeW5oL2JvdzloNzVBZWJnVlUxMzhKSWYzOVNI?=
 =?utf-8?B?L1pYamxKS1dqVTNCV1BkQjY3STFzc3YybDhDcEZvV1p5NDVRZkdYRXlEWnBC?=
 =?utf-8?B?ZXFVZGN3NkM4Vit4dFhTSUZTU0ZSL1ZEcEh0SFlEa2tobW5oMTdVeGdDcExY?=
 =?utf-8?B?bCtmRWZlR3IyNE9XUHJrNDhaNlV2azR1UUJ3M0F0MWJURnpveWZrUHVuWjY0?=
 =?utf-8?B?bENCWkM0TEJhbTM2eWZuR0QrYzl5dXdQNmNlV2JyNWVUL2ozVGRGVVRMWFBZ?=
 =?utf-8?B?OFNzVDFpR0p1eld0OTFFRjJSdTFONFhtcXFQMlMwWVA1MEdjVVBBYktidmdL?=
 =?utf-8?B?VzR1cXVQK3M1bWxpcFR3aURCWjhxQnR0UnlvU3lHejV2ckxLcXNSdjZWR0NV?=
 =?utf-8?B?VVVBODJDWU40SmJxeVAzQ2FZdUJHUmZlallnbXR6SFZIMDd5KzdPR1ZPZ0Fa?=
 =?utf-8?B?aVM1aytydXRraHN6dGZDdUYxUUtsNDVCMnYycEFjWGZEdlYzL21tTmVIV2NK?=
 =?utf-8?B?ejV1aEl1dWJ1bm1vTWtxNHE1YTJ6OVlyUWlsaUFVRzMwVkpnVWtjaGREMzhK?=
 =?utf-8?B?WlZUWDY2YkJKVmcrbG9kd3p6aTNDY09mKzFzUlk5akk5ZjFJSmtpT0ZpYVhD?=
 =?utf-8?B?ZnBlTFN5YXMrV2pUT1I3clFCVmhJeFVqQ255ZXk4VWMrUkx1TlNUOGRDME03?=
 =?utf-8?B?U1RONXZJMU1kSjByWTdxdk5CVFVaZ1NQdkJWUjJSVDkxL2haR3E0bk1BbGhm?=
 =?utf-8?B?V0tpb2d2eU9URE92cE5NSHdQOWQvdFFNWGJ1VEhHZWtCaDM1Y0dQM3I2ZDlu?=
 =?utf-8?B?bDlJNnMwTWg2MUlTZ3U1RXc5ekdYYWd0UWZBVDl6RlMvWk5hZXN0akVOT3NU?=
 =?utf-8?B?dVBkNnhJd091dkdIQkZRbGEvbXRIb2J4WndpcStVbjJXOGdYdWNHajA5aHIz?=
 =?utf-8?B?Y0E2T0ZVR1AxZy90eFoyeE5keEQvYmsyOS9abTR0WmZkQUxLK01yd1orbE4r?=
 =?utf-8?B?YlpXcG93R1JRcXRBQXg5NUdySWJxWlVPSGdPdkZVazhJeVZvRWNPUDRBc3JY?=
 =?utf-8?B?TFFQYzk3cm5LcFg5V2pkNU81c3FrUDVqMXdyakp4dmFxTUZDR3lOb21ZbUdn?=
 =?utf-8?B?aFRTZXYwcDBvTlJwVkt1RG5YS1hHL3hwMC9mRzc4cVVkVWk2KzUwV1Rna0RS?=
 =?utf-8?B?TTdLajJ1SGpWenJGS1M4RUpHYTVFVGxSR0ZJM09JNDRGWHJLbGJwNXhQRWNS?=
 =?utf-8?B?ZHFzWlFNZDFEcktsYy9UN3diZUNEbklZQVl2U2srT0tUOTU3eWFvSUx3dHlF?=
 =?utf-8?B?eFpFMjhiVFl0bUlZM0hjL3pvUkZ6S0RCNW9CR2Z3aG9aNTRKS1o1UGZHYUYz?=
 =?utf-8?B?VjNCanBWYStNVFVvSGpDdXlyWHpWcGg4UTV0d1lvUmJJa3BVUEZRdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2327da-4ab4-45d7-2728-08dee4d825f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 14:23:38.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtuytlIenE/W8k0NBD60KZEZDmBFONFG9GsuXMq6bo4GqhPw5NKRXCTJBUtawqg1sXaY3R2U8d+gHkzgJ6Q7jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210

Hi John,

On Fri, Jul 17, 2026 at 11:50:20PM -0700, John Stultz wrote:
> On Fri, Jul 17, 2026 at 11:16 PM John Stultz <jstultz@google.com> wrote:
> >
> > On Thu, Jul 16, 2026 at 6:23 AM Andrea Righi <arighi@nvidia.com> wrote:
> > > @@ -3098,18 +3164,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
> > >                 set_task_runnable(rq, p);
> > >
> > >                 /*
> > > -                * Mutex-blocked donors stay queued on the runqueue under proxy
> > > -                * execution, but the donor never runs as itself, proxy-exec
> > > -                * walks the blocked_on chain on the next __schedule() and runs
> > > -                * the lock owner in its place.
> > > +                * Mutex-blocked donors only stay queued when their BPF scheduler
> > > +                * enables %SCX_OPS_ENQ_BLOCKED. The rq lock has remained held since
> > > +                * scx_allow_proxy_exec(), so @p's scheduler association cannot have
> > > +                * changed and @sch must be non-NULL with the flag set.
> > >                  *
> > > -                * Put the donor on the local DSQ directly so pick_next_task()
> > > -                * can still see it. find_proxy_task() will either run the chain
> > > -                * owner or deactivate the donor so the wakeup path can return it
> > > -                * and let BPF make a new dispatch decision once it is unblocked.
> > > +                * Delegate admission to the BPF scheduler.
> > >                  */
> > >                 if (p->is_blocked) {
> > > -                       scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
> > > +                       WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
> > > +                       scx_do_enqueue_task(rq, p, 0, -1);
> > >                         goto switch_class;
> > >                 }
> > >
> >
> > So this isn't a blocker for your patches, but just as a heads up: when
> > applying my sleeping owner handling changes (even just patches 4-7
> > from my v30 submission[1]), I managed to trip the above WARN_ON, when
> > running the test-ww_mutex driver under the scx_pair (usually right as
> > scx_pair loads).
> >
> > [ 5818.970324] WARNING: kernel/sched/ext/ext.c:3175 at
> > put_prev_task_scx+0x527/0x550, CPU#54: kworker/u261:11/30527
> > [ 5818.974927] CPU: 54 UID: 0 PID: 30527 Comm: kworker/u261:11
> > Tainted: G        W           7.1.0-13303-gb5ecf3c9f881 #116
> > PREEMPT(full)
> > [ 5818.979484] Tainted: [W]=WARN
> > [ 5818.980654] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> > [ 5818.984225] Workqueue: test-ww_mutex test_cycle_work
> > [ 5818.986199] Sched_ext: pair (enabled+all), task: runnable_at=-369ms
> > [ 5818.986202] RIP: 0010:put_prev_task_scx+0x527/0x550
> > [ 5818.990473] Code: 48 2b 05 34 f3 21 03 75 3c 48 83 c4 30 48 89 de
> > 48 89 ef b9 ff ff ff ff 5b 31 d2 5d 41 5c 41 5d 41 5e 41 5f e9 fa f0
> > ff ff 90 <0f> 0b 90 e9 b8 fe ff ff 90 0f 0b 90 e9 35 fe ff ff b8 02 00
> > 00 00
> > [ 5818.997428] RSP: 0018:ffffc900088dfb28 EFLAGS: 00010046
> > [ 5818.999426] RAX: 0000000000000036 RBX: ffff888101258000 RCX: ffff888101d64990
> > [ 5819.002113] RDX: ffff8881b9bae638 RSI: ffff888101d64990 RDI: ffff888101258390
> > [ 5819.004787] RBP: ffff8881b9badb00 R08: ffff8881b9badb00 R09: 0000000000000000
> > [ 5819.007967] R10: 0000000000000036 R11: ffff888120a9b030 R12: ffff888100c30000
> > [ 5819.010697] R13: ffff88810d163800 R14: ffff888101258000 R15: ffff888100c30000
> > [ 5819.013378] FS:  0000000000000000(0000) GS:ffff8882355c0000(0000)
> > knlGS:0000000000000000
> > [ 5819.016354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 5819.018524] CR2: 00007ffe7b985348 CR3: 0000000123ec6004 CR4: 0000000000370ef0
> > [ 5819.021163] Call Trace:
> > [ 5819.022168]  <TASK>
> > [ 5819.023010]  __schedule+0x15c4/0x2460
> > [ 5819.024504]  ? find_held_lock+0x2b/0x80
> > [ 5819.025981]  ? lock_release+0x191/0x310
> > [ 5819.027503]  schedule+0x3d/0x130
> > [ 5819.028772]  schedule_preempt_disabled+0x18/0x30
> > [ 5819.030539]  __ww_mutex_lock.constprop.0+0xaea/0x19e0
> > [ 5819.032492]  ? schedule_timeout+0xca/0x130
> > [ 5819.034095]  ? test_cycle_work+0x15d/0x340
> > [ 5819.035686]  ? ww_mutex_lock+0x3c/0xb0
> > [ 5819.037094]  ww_mutex_lock+0x3c/0xb0
> > [ 5819.038494]  test_cycle_work+0x15d/0x340
> > [ 5819.039949]  process_one_work+0x20c/0x5e0
> > [ 5819.041631]  ? lock_is_held_type+0xcd/0x130
> > [ 5819.043277]  worker_thread+0x1a4/0x360
> > [ 5819.044717]  ? __pfx_worker_thread+0x10/0x10
> > [ 5819.046392]  kthread+0x103/0x130
> > [ 5819.047650]  ? __pfx_kthread+0x10/0x10
> > [ 5819.049074]  ret_from_fork+0x27c/0x340
> > [ 5819.050525]  ? __pfx_kthread+0x10/0x10
> > [ 5819.051990]  ret_from_fork_asm+0x1a/0x30
> > [ 5819.053488]  </TASK>
> > [ 5819.054371] irq event stamp: 38
> > [ 5819.055583] hardirqs last  enabled at (37): [<ffffffff826a7100>]
> > _raw_spin_unlock_irqrestore+0x50/0x60
> > [ 5819.059054] hardirqs last disabled at (38): [<ffffffff82699205>]
> > __schedule+0xb95/0x2460
> > [ 5819.061998] softirqs last  enabled at (26): [<ffffffff813244d0>]
> > __irq_exit_rcu+0xe0/0x150
> > [ 5819.065015] softirqs last disabled at (21): [<ffffffff813244d0>]
> > __irq_exit_rcu+0xe0/0x150
> > [ 5819.068013] ---[ end trace 0000000000000000 ]---
> >
> > It seems to be coming from the proxy_resched_idle() call in the "if
> > (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {" case in
> > find_proxy_task(), prior to proxy_enqueue_on_owner() calling
> > block_task().
> >
> > I'll have to dig a bit more next week on this, as I'm not yet seeing
> > whats going wrong here.
> 
> Ok, my tired theory is something like:
> 
> 1) You have a task A that that is_blocked waiting on a sleeping owner
> B. It gets enqueued onto that owner and waits.
> 
> 2) We start scx_pair, and scx_prepare_task_sched_change() calls
> sched_proxy_block_task(), which bails because !task_on_rq_queued()
> 
> 3) B wakes up, and that causes us to activate_blocked_waiters(), which
> re-adds A (with is_blocked still set) to the rq
>    - this is problematic because now we have is_blocked tasks on the
> sched_ext DSQ where its not allowed.
> 
> 4) A is selected as a donor, and maybe B is sleeping again, so we call
> put_prev_set_next() and hti the warning because we see A is is_blocked
> when the sched_ext scheduler doesn't support it.
> 
> I'll work to prove this out a bit further next week.  I suspect we'll
> need something somewhere between activate_blocked_waiters() ->
> scx_do_enqueue_task() to skip enquing of is_blocked tasks when
> SCX_OPS_ENQ_BLOCKED isn't set.

Your theory looks correct to me. I was also able to reproduce this. I think the
problem is that scx_prepare_task_sched_change() calls sched_proxy_block_task(),
but the latter has nothing to do when the donor is already off the runqueue
behind a sleeping owner.

When the owner subsequently wakes, activate_blocked_waiters() unconditionally
reactivates the donor while is_blocked is still set. Since this activation
carries ENQUEUE_WAKEUP, sched_ext treats it as a normal wakeup rather than a
blocked-donor admission. The donor can therefore enter an scx scheduler that
doesn't set SCX_OPS_ENQ_BLOCKED (scx_pair in this case), eventually triggering
the warning in put_prev_task_scx(): unexpected proxy donor without
SCX_OPS_ENQ_BLOCKED set.

I think we can fix this by checking scx_allow_proxy_exec() in
do_activate_blocked_waiter() before reactivating the donor. If the scx scheduler
doesn't support proxy donors (SCX_OPS_ENQ_BLOCKED not set), the task should
remain blocked and will be activated normally by the mutex wakeup.

While looking at this, I noticed another issue in the same path:
activate_blocked_waiters() currently passes ENQUEUE_WAKEUP because the generic
scheduling classes need wakeup-style enqueue accounting. However, this is not a
real mutex wakeup, the donor remains blocked and is only being made runnable so
that it can donate its scheduling context.

As a result, even a scheduler that sets SCX_OPS_ENQ_BLOCKED currently receives
this sleeping-owner activation as SCX_ENQ_WAKEUP rather than SCX_ENQ_BLOCKED.
That's because the existing sched_ext test:

  p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP)

doesn't distinguish a genuine mutex wakeup from this proxy activation.

Maybe we can address this by adding an internal ENQUEUE_PROXY flag to the
sleeping-owner activation. The generic classes will continue to see
ENQUEUE_WAKEUP, preserving their accounting behavior, while sched_ext will use
ENQUEUE_PROXY to expose the event to BPF as SCX_ENQ_BLOCKED without
SCX_ENQ_WAKEUP. And a genuine mutex wakeup will continue to be reported as
SCX_ENQ_WAKEUP. What do you think?

Thanks,
-Andrea
