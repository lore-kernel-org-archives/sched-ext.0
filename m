Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F637C908
	for <sched-ext@lists.linux.dev>; Fri, 18 Sep 2026 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713482; cv=fail; b=FQYUdRlW118P9BLBpKK7t0TZAfJdTPEcgKeXVhAkjlBgk5BEmwmOfHVeulvawnnLy2hhoPNSEioAgV7eXDKtEtuj/o1Rt/2+PVxldHw5SekWhD91Qf+VR1Wva+MdNn9FZL2sMNPeIw9rW7xZ/bScFUuGU3dX+5SL4VPxLs+8EVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713482; c=relaxed/simple;
	bh=IZ0zY2y9Y9bNXUwq0sGnSMeeZHb4JYdYpn5RmZZuT4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CCxaIv+mTeoVWv9nEPyGD/CVf2tVHPwFoFtehO3MgUGKYKn+x2u+HV78ZGxIC3WPszSr8a9wvvoNK5B5fyoMAwdq7OZRAtwJOS3CcCzD0ksCIlXVlV6TkFH2vCVDVHeuXjnc85Pj1YW0pq5u+0Zu03aADBTPgvF/YqDYRkyhGEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r3IPQrSu; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3IPQrSu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbCDYH+G7YFlBMn6kr7t4JW1dq5w9r42VqnNgZRHBJdY5W+WrnPHv3i4mplW9/oyfrP7c5/uCHXglGso6Rf7JleH6r6+KFVDl8qSqpHDz344tUS0Nkr9aWPbBNZW8nDDLxrpGqZF6GfROGA/sWwtfl6H5u1kcyh2ZmcmCABw+aF6zcqof9QfzNEQhc2PQU3zH5ZOkkNDKlAFRZjlfHT929c2Pd5DyvPxVmejS+oms6gUQj3olu5LA6/Lrdtjg0qaj6SfDb4ZyczM0khD7Uy8Qp6VarN/nihDU3KbNLy8TFf27CgPaYbcvDFR7OZUSRFp2AG5tCDb6saiezxdV/OATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9k0vBKmo9ERssWDulaYrjeWpKHHgYmSc/P0equ04tY=;
 b=y5Jk9HPp3K6i+o27yv/cOa1eXwTQdpOKicJ79/AMbJTqGBszb00Ki8qYHPCn+cJVozFyZI4GQat8yhmHs+rCRgdUGMVAGnTS0j1OqCixvBsvlmreJAwBPgbjbKMy2f/ntKgkhxbY8138WmUupKiFasCvRwNyM7kOd+0AizmvfdzrWfS/qbdM5DjENVTLH081ZSm8EbBov9UTN3aHimblhJ/Zq1dQUziWiV5cfF8ucJp/+vOCgo2twKpD29GwzpU1ZhVJKpxdW61v0Opt6oOgTeWWO+KaEyaXIvYYIuPJnIdh897HBu3jUSiYLrvRqMLfWbglbyGUA3QbqYIOfBa7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9k0vBKmo9ERssWDulaYrjeWpKHHgYmSc/P0equ04tY=;
 b=r3IPQrSuYCyVHrdZ8wWSAs+wUDE3F1xNoMYkT/0PtV0qB6D7yH9e4kiYpvp6OflMlH9Pp/IilaWQcIkot7pONQuMpi+J7Wj5+KnqIfXTA08OwQXcQWoDaij6SDkMYH9E0mO544/PO0y0y5tDgm3iaN0u+0GdBFHVcAx1j2TKKX6aM7tBcgK+NcLW9MsUj7kX5iABnmaSfR/2eJWgot983el1AbAnoItRhtD/AVScrmN3sLC2ZalWGhIKsMwoyo4zNlRRPJEjwiYZ6N4nFhmoTWsQnbBaVyt5LHNV0maVbdBtqwgvakaLihpgOaOdV9+vXRX/7l3PLYvhF2E7SMduHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Fri, 18 Sep
 2026 06:37:51 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 06:37:50 +0000
Date: Fri, 18 Sep 2026 08:37:40 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Message-ID: <aqzcNFzP-qwYwhgp@gpd4>
References: <20260917070751.3617935-1-arighi@nvidia.com>
 <20260917070751.3617935-2-arighi@nvidia.com>
 <c20825cf-9bc6-455f-815a-77f0d5c3e76b@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c20825cf-9bc6-455f-815a-77f0d5c3e76b@linux.dev>
X-ClientProxiedBy: ZR0P278CA0136.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e06086f-b512-48ec-b41d-08df154f5c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|3023799007|6133799003|22082099003|10067099003|11063799006|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1GX6lp1K+XNkZDJ1wWVH8EmNcR8oI27urJgVpyMSohmV+hm1t27AwVl9RcESVTVRJptI39SbZKxjosVYpLXOrW9f3jqAV/zHQheb4D1M7tRR0wdzfJU1W7s8Q/GPskvTQyT5MAa1EtpXSR1wMm3ySlm+OftWQyjij4xHbnuXSL9U8mWQ22BrcXoQCBIS8oCIMBN3yF1PwlxMg4eed+MnUws/FzvFINKenG1v06DWO6tpO1ch8MdVr1vuFzI3gkOLo1PHuH2dISNhogpBhfPeSz82mh8B3C8spYBDOnkwBzOEiH8Zo5KHVYLK4lgT7G0bPPETniva53cEmaVoZRZu9jRbGSHCjC4emlskm2UeHX7jigu7vbmWhTJU+8fZCz0FVBtq7DwJpUEXjs6jHQpUkhonBcadzRMYqyFR4sBcg8M3vN/cL3Wy/nWUKt+r2enGYV8uI5Rtmxk+Oz5gkeoQ9inTp5MV6QcLjUclZApBhiPO25vLdyKT9OAwmkBXlpVI2XLsOHjFcBYfXoEQmn2eGSFdWRRBSJKiqkCpsrm3FlfOkDH4i3T+iibTyY1zkLh2rgfmwY9HNa74L1rDY/RhQ+eMFWKX4T32QWtw5wUJm728JNTYzy1rfygA3QTSjvqxuHIxu7E/VL55tlDr2GWyPJ7clD4dO9F1BciRCbHidtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(3023799007)(6133799003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0RZbjZiL0hIT09samR3M3lWZ08wdkU2Z0R1eWpxYjNXQ2VKL2ZOUkpJc3g2?=
 =?utf-8?B?TkVYRVVVVFhEMGZUVGQxLzVVYkRyTktndXBtS0xkNEpFVFZWVlFvV0duY1FU?=
 =?utf-8?B?VHhDZk5WV1dwbUQrWWM4MmlqZDdIUW85OXJDa0Y4bUNQTVdIT2xlUmxUOHBK?=
 =?utf-8?B?RUpNV1Y5SEJ5Y0thTUk4WnNLWFFLWGovNUN0TEowUmRQTXBqSEVyVFZNY1Fx?=
 =?utf-8?B?bFB2VncwVjdXaEl5ZWJBVEpJWVZyK3ZOd0RaTWNFUHNadG1ZaHU1bEZiK2JK?=
 =?utf-8?B?bVo1bFVrQ0Q2aWFSTG1ZMmNtR0EwNzJZS1JhUGZoLzgxdlZtN0p2ZnZBWnht?=
 =?utf-8?B?V1BBMEdNa1R5U3RzT0tFME15TkFkMUVpM3BWakRVcGFBYTVUVlgxUnlOdStv?=
 =?utf-8?B?T3lqK2JvVzEya1pad1dJamx2R0FHNFpyanRtQ2EyM2o4WW9mZlZXWXlhcXgx?=
 =?utf-8?B?Z0ExZU1aNGJuY3V4UDZiUFdrVTIzQ2FuK3JlWU1VNHdYR3h3SzJlK3lyWFE4?=
 =?utf-8?B?TGlPOEVveE9FaVE4Q0M4NVZPTUpYeWZZZnBIL01NNFZIaXFDeElnOGlIODRZ?=
 =?utf-8?B?MDQwa2g0WlBkVXhWTnlqNkFHZTJSckxYNlJQZ0ZJL0NvVEV3T0hkWklsNGVP?=
 =?utf-8?B?N3ZTSENnOG9uM0RsVHJvMkwvUHY5Tk1hNy9PQVY0KzAvUXdGUTdPZmJDV1Jt?=
 =?utf-8?B?cU9qMnA5RDQ2VmJaQVZ0NjJQckNwWk84TlIycEZwZytGN0pqaUt0RnlsWk9v?=
 =?utf-8?B?YU0rRGZ1dzJpL1VYYTB4a2RPU2daZWdHd1AzT3VWck91Sm1RaTR2bkp0aldU?=
 =?utf-8?B?QjRnWkFuUkY4am5ERnBPOVlONGx4OVNtUC9wQ3RydkczeG5lQjg3L1RtaUNQ?=
 =?utf-8?B?bFB2dkJDK013R0xScE5rVkUwcjg2QkZPalg4aFZLWjlvT0gxZWZCM2R1dUJN?=
 =?utf-8?B?QWM3aXZpOEkyUG51bmpWWmVNYXc1cFdMeS85Ti9EVnI3aUtJdFcvL0EyQk9z?=
 =?utf-8?B?UkpIWjJBOFNFTElreUhlN3g4cjdCOTgwb2ZXbXJMbTJsMmJFU0lWUjlBdEg1?=
 =?utf-8?B?ck1QMnZaMDhjQ2IrTnlvNVVDU2pUN0lMT09FamRhNVRkQTdGcURRNDlCdUxI?=
 =?utf-8?B?YURyeHdwMlpYazVvQWdFcEEyZ29RVTlsYmxVdXpaY2krcW8xd3d6ZmxKS0ZK?=
 =?utf-8?B?a2dCRlFvZTRHUGgyYWZ5WmRpNWt6d1UzVEkweklYSXgvakUvZ3c0UlQ5T1Q2?=
 =?utf-8?B?Q2VRcGtRMWdVSHlsUXAxakg0MTZlbWM4NXpzTm4vMC93ODh5MEpIZHRQS0NB?=
 =?utf-8?B?emwxZnhibWdKdGlwYWZ3Z1JNdm1ZMkVUT0pQM3JoUitDOVIxSkI1UVdKQ3g5?=
 =?utf-8?B?aHdwZE4wbmczRFZUZnRhWkZqWVNtVkQ0N01GT09QZVd5OS9SRHBGNzhNUjlx?=
 =?utf-8?B?VC9SMXZRYTFPdktxZUVUTFo3amo1M0U5WjQ1RTNnMWFKMmRyQ0pkam9oWlJy?=
 =?utf-8?B?MTYzVlU3WXR4MSthd1d4NitWdDEyZzg5Q0NJbWpDSlFnMGVybkRSMkJPKzBh?=
 =?utf-8?B?akhBU2YwaVJNc3IvUGFndTdLYnYxS3NOcFZ1OGxwM3B5RGV5TjNyZEZiVkt4?=
 =?utf-8?B?SXBjVTdPMm12Z1c5NldvQlhyOUs2MFZ6RmhsczluOTVFV2RrR0JIajhyTFoy?=
 =?utf-8?B?NEdYZkRRc3pmaDlpeWZ4dGR6UmI0bGJ4dzNRSENNM0QwY2xES2k5VHFFT0hQ?=
 =?utf-8?B?WHJnSVhJOVhua0RsQkhGYWI4ejJwejJxcSs2OURnL25SZnpScnlvYkR6OHBq?=
 =?utf-8?B?b1dLL3JnUTdVc3NVaVp4SnJwL1VtUGVVOU90Qmk2MVdGRzMrUXV4M0pkNm8r?=
 =?utf-8?B?UjlkRitRbEFENzFXemZ2WWQrOXdoeWhFMy9yZTNKdTBHY0haMWR6cFF3SklG?=
 =?utf-8?B?WWM3dXQ1c0tZT1BmTGJ2UEVSNVVZNnhLOVE3RERZSjgwb1Foa2tCcHBleE54?=
 =?utf-8?B?T2JFbUlDdzg3bkczK2tuL3BxM3NtbjU0bWx3S2RBSlRvYTVEUHRtWDFRQTd3?=
 =?utf-8?B?OHdna2pRYUdna3dVNEhQd2c0dU0yM1hvUnNUWmNYNnpFOHhSbW9oazFreFRN?=
 =?utf-8?B?ZzhOaWVYdm41M2xGMWdtaWRPTko3K0JsOHlzVGwwT2VYeFRYQSsrMXdHdGFN?=
 =?utf-8?B?Ykl1YmNoVEJnL0hxb1pRZTAvUzh3Z05tcEcvcUFnMFpGTlBTV2FvcnhnUDNh?=
 =?utf-8?B?Y3AzVzgzaGVmUFBKOXBDWnBpUnlnckN2cEhhVHBsYU4yMG0veEhIUGoyNXh3?=
 =?utf-8?B?eVh1b0EwV3FpamFSZTU0OFF6dkM0YjIreVJURGd5WW41YnhHb05udz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e06086f-b512-48ec-b41d-08df154f5c02
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 06:37:50.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCm7pF0+H8qMOl9t6BPLAmJoy+yydlhVXJbnufqjkVb9EdhX2D65Qmi6jZi/+AdgVs/pAHzPiETALZWlaNoChQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866

Hi Tao,

On Fri, Sep 18, 2026 at 11:35:25AM +0800, Tao Cui wrote:
> Hi Andrea,
> 
> 在 2026/9/17 15:02, Andrea Righi 写道:
> > The fair scheduling class can request lazy rescheduling, deferring an
> > in-kernel scheduling boundary until returning to user space or until the
> > next scheduler tick. sched_ext only exposes immediate preemption,
> > preventing BPF schedulers from making the same trade-off.
> > 
> > Add SCX_ENQ_PREEMPT_LAZY and SCX_KICK_PREEMPT_LAZY. Both expire the
> > current sched_ext task slice but request lazy rescheduling. Immediate
> > preemption, WAIT and plain kicks take precedence when requests are
> > combined, while a lazy enqueue to a non-local DSQ retains the
> > head-insertion semantics of SCX_ENQ_PREEMPT.
> > 
> > Add SCX_OPS_LAZY_SLICE_EXPIRY as the default expiry policy for newly
> > enabled tasks and initialize it before ops.enable(). Add
> > scx_bpf_task_set_slice_expiry() so the owning scheduler can override the
> > policy per task from any callback while preserving sub-scheduler task
> > ownership boundaries. Bypass continues to force immediate expiry.
> > 
> > For an infinite-slice task whose tick is stopped, set the lazy
> > reschedule request before restoring the scheduler tick dependency. This
> > lets the dependency update's IPI serve the request on return to user
> > space and guarantees that the next tick promotes it otherwise. Use
> > pinned rq locking for remote kick delivery so RQCF_UPDATED reflects
> > clock updates since lock acquisition.
> > 
> > Accumulate kick requests independently and resolve precedence while
> > holding the target rq lock. Reject invalid SCX_KICK_IDLE combinations
> > and unknown kick flags, which were previously silently ignored.
> > 
> 
> I tested v6 on sched_ext/for-7.4 in a 4-CPU KVM guest: wakeup latency
> of a 1ms-period timer task under a scx_simple-based probe scheduler
> (SCX_OPS_LAZY_SLICE_EXPIRY) with a busy loop on the same CPU.
> 
>                      avg     p50     p99
>   CFS (no scx)        60      59      66
>   no wake preempt  20919   20982   21002
>   SCX_ENQ_PREEMPT     59      58      64
>   SCX_ENQ_PREEMPT_LAZY 59     59      64
>   CFS (control)       60      59      68
> 
> (usecs, 2000 iterations each)
> 
> Lazy and immediate preemption are identical here and on par with CFS,
> i.e. no wakeup latency regression in the common case, matching the
> intended semantics. SCX_OPS_LAZY_SLICE_EXPIRY also cut the context
> switch rate of 6 busy hogs from ~1000/s (CFS) to ~215/s. Repeated
> cgroup knob churn (cpu.weight/cpu.idle) ran clean, no warnings in
> dmesg.
> 
> Overall the series looks well-behaved in these scenarios. Thanks for
> working on this!
> 
> Tested-by: Tao Cui <cuitao@kylinos.cn>

Thanks for testing and sharing the results!

-Andrea
