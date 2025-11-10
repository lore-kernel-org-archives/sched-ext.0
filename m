Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1B28A701
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759302; cv=fail; b=ewKprnLB9N4MOtcHv6STjshYzFZMNh8eRC0Tkqc3dF/ymID2CLzdOifuond8/c06bCPtBmTUD2dDOhbG6bnWQeTrS8iBAsc9NVVeUuGOXhEcO3G8c8wwDcDWXgX+OBfbTT0mQVigkJtOaPfpMF1drDhFNvEq0VMeBEDNlYXohH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759302; c=relaxed/simple;
	bh=F8NUNJeCyOpF/XYti/Sd1l8h3G7FtWOz/xaqqCLv72I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CFmUEgmELUelKbpnEmabbgH0UxEo+XST6I531rlg8OiseeTsBkr+gTFcObDuZvGrX03mffin9LE0M43FTVyQZj98cX1fXiH2LfvcegSMygNbuk884YSnzIZwtlwD/JmP3xCUgLlEUEOdaUf3iPMnBdfu+Vfbp5gZhaM/BBadyi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qmoYbyF0; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qmoYbyF0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrL+lZOG3xoyE6GcgK06f58liC3yQKMy3+U2vAEZog3lPSz+iZ96jkcd7iXvTKJk6OcfhPpOu/I+3C5l6WWO0W5Y7AMjGNHvJQkDiRj3TMZSOZUqd0nHLHAXQDqDaqyMUsW1215XlB+LbaXVlupMoPME4GbYyrsndNXz+dAUFPw7gZSQyh+ZEpPyQD5PrwIaohwWwuaW6jXovxcz3CpDCdL+W2qKqKta193Alf+cjArq5W24VebOr2RIGN/XZTWLe1FYDhVC/L9OJqw2+rqxAb6hwnKpDFty5EgW22quaBKS1AR9A5ipF4auRv8PZrJb9g2o7027erzD11MnoOauuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGVm7LgN2YimQOd6hIpkJz3cxCEWTHUPktk0f+ZbFRs=;
 b=Akt396CuYSujk2xpmWSn8T1hnYhYthr9x67+a0HxXmDZbTnx0U0SO2fo1+m1DkJr6vtUdZ/N8L+9fHXcz9NkVg1qiQ0zpDGbN/XhIJ51pzJiOxZnhdXI5wstGjwHm2DWjwwr3KdOtw5T+ANyMhmn2PNi7RtK7BxP96AG/2oNmZIIeMW3GwWp6THXjRiCaRTDFT+lv1v8qczCZOSFFzYyoDhTRXtRnykQTP+z/AedJGqHo5EQWzjf98TRkVFDJV6Cv03djCmrYkf1XGOHppZ+/HgWQafteGx6P7W+To7yOkg950HRLfFm/P+RdgW0pC5LKmpj4PZYo4XWx7Y7XeYvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGVm7LgN2YimQOd6hIpkJz3cxCEWTHUPktk0f+ZbFRs=;
 b=qmoYbyF0N7y3KKpYZjf6GXKzpdakAoIu7pko7KFkX/cC9RkT5Icn7V8dGUtiaRgf+Z9ZD4eVxMBsMpORcOisQ58U6yTWY7g2q/0niZmFv3STD3NtA5OFK9ORaUBHmjYhqoHN41dmSm7BOjEQnvZdON/fNTKaETk1qZ6dH+9zS/D6/71X/yuBcSPP4Zn7nxnZzjj3oxprifpQhEBmNvU5tmwuJ3iPc07hc9KVtf9Wdj43j5xf+aYjIz3PjyRxCmVK8HZ0Gnz4yQ1Rq/tXkrv5BJJ38XBFhk20FA6JqXcmRPym5UJJQmOys580087klydyVxTj/TjbdDtnfhRvQnujgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 07:21:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 07:21:35 +0000
Date: Mon, 10 Nov 2025 08:21:27 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] sched_ext: Refactor do_enqueue_task() local and
 global DSQ paths
Message-ID: <aRGSd7kqynnhRAWk@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-4-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: fe648a49-116c-44e3-1dfb-08de2029c7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fbZLI1Wzybg4GxX6fDt/t8IwDzIjXNIOwjTT0oQ50Jr2jvDfxHMg9WJOeTXH?=
 =?us-ascii?Q?9IPWWnmzqxiQRMO7Hm8lF0KEpOvUGqUgc6AYZYHtmPSvJjxnGrhZWf7ajmFA?=
 =?us-ascii?Q?xAJVYdXB46RoV3E3RjlseCeaaYh4I8f+eFINZoeWYRyGqGWLrpZ3bIg+rBBB?=
 =?us-ascii?Q?Jo39/WHb61arEPWwuFMx5e6fnigmVEzLPFnQwilQ38ndO5eIb359c7VAfSPF?=
 =?us-ascii?Q?wXQNZwEj0DRqJKp8x+pKLntQoEgCYP6Wx47KC4oJpRTbz/rPw5x64Q4UB0qM?=
 =?us-ascii?Q?KpkzrnZJFwgPoH3l8nnvld+uFsyqyJ0jIhbNWxWalBojVgVcR5iqPxoYEEp8?=
 =?us-ascii?Q?alsbfh1SCOk6mpXwOGX4Nk2mNNa3Hpce27AnnXwFViESMSIvEwRVeTDIK5UT?=
 =?us-ascii?Q?YGzcCvBwXQI0UwTdAbeBjRuHXLmOCG7GO3XzPBdG3UEphKG/oRagdade6UpN?=
 =?us-ascii?Q?XfyD4GP9r7gmIWMfH1K41Hso8MEgxE2nv9JLuF2rzllIpgBT0/5gxpX55ZI0?=
 =?us-ascii?Q?b01kfomEA3sNR2j0IGFE/T96yetWwcQZ4UGCRJkvvkO2R6MFycdsJ23fcSRA?=
 =?us-ascii?Q?M2hiGlqOhGzblLxwpJMdVXIMOAtbnJnacwsg0St/jBB0Q81bHzujg7gHmPyv?=
 =?us-ascii?Q?mpXag8+fMml768lDr2c+ClK1xA0oUDfeS1dezvQcQvdMHnXjgOK/M+z+vque?=
 =?us-ascii?Q?jqK0N6z02VqLxAUTPuKgImNFzQ73frHXQ+4E0KCzn3T+XJRGlHnz4FalN8Ny?=
 =?us-ascii?Q?meeyVhkiWzKCuYvEQDFBtxVlVzu2aT+r9hyFqCS7LPoqWw8c8AZGaq8UtTN5?=
 =?us-ascii?Q?bT4yuto+MkcFKcBCKBQVdhJN5Q+Vbxssryvbxglrzfhe81e10+toXWGSQKGh?=
 =?us-ascii?Q?UmBQM9JgSf4RCIrOzI6NfBxm0rdxIeuKFWeLRlCvP7EN1zrQf7r9k3c7PSVd?=
 =?us-ascii?Q?wD6RK/pBfHzGk0uJMnfSUY7OaS+n8IqbRtbCTRmRn4L82Ma2ZeZm+tc7qriE?=
 =?us-ascii?Q?On0IiP6hhaJCxJiM0IPZucTIcToznSRf/C6ox0i2jPI6H1M3OPwxu7VP88UO?=
 =?us-ascii?Q?ZDQWKNdvMAzep0tFFX+zfad+wGKYQwirb5KTnoBfieZF36A+FYMg8ovvPDs5?=
 =?us-ascii?Q?yTxnDbofWjrbDXDVAr1pdynNhprbOf4DVeHY1tsOGdYz2SH0bVMAJU4zrVEt?=
 =?us-ascii?Q?hhKMu349YLtnJHRuT68u/I78zSWVoiG/cmisvU4m3DsOH3QoNLDgmpJO2gir?=
 =?us-ascii?Q?/QkvYOjuWCcQt5j4c/piaM2cn1y42lVignHfdtghA8q0sjl4WBdaWL4F7n8y?=
 =?us-ascii?Q?QeS2/3DmEWe5qHS9UOkySAxOv/ylU5EyjHQ5TKyTCy8lKp5a8EP4+0MhCZzg?=
 =?us-ascii?Q?NLbpzNVF1/OTiFaXMmBYjO/4zYd3jU9LC+AmLKgDPMb76zXwsDVDyfREDeZZ?=
 =?us-ascii?Q?Z1MteTdUqAfPWLS8hVILZ9kzgNvLCmSx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?galcJVF13NDOUw5TxWiFeCfSZEstCEeylgVu4W1kBR/QEMvhTU7wNcSLQpld?=
 =?us-ascii?Q?rubNRkWT6jSnVExKVp5ZGw3EtSTSBcL0nQq34rAqiY27NVT7VZ3UmTS6xrl0?=
 =?us-ascii?Q?DiumKl5+gHbXWrrnbAER0Qf6rUU8dv3wctp3u6p7Aow1qWlSKGbyA7jHMELE?=
 =?us-ascii?Q?adLfaw9uuqiVL6JeEbi/om5mtxRssEFmnIf+6AIXK7kiHgwD9xuiLQ0qpKLI?=
 =?us-ascii?Q?aIwHUjx71hvfAVWopvlCXHT3qwmU3awuSSEnK0V3662Qbp34ceEIB5sZBASl?=
 =?us-ascii?Q?lfGRF7hPLpmRRRYzjHBKwKDsmWpdU3PXjbYaO5gswq1WMvlAxMH2J/CozbvP?=
 =?us-ascii?Q?LJVD0yE9lv3xjE5uOr1/IOHz4NRQp7zLulPflaFelc/GsRWL8I2hlUjBHkBP?=
 =?us-ascii?Q?rS8ocWRjR2r7fzOEe1C7m5qY4IoB6S9dv2cwD4nYVIAgu9XZ5GGBmxyDjOld?=
 =?us-ascii?Q?uiqCTL9NtFV1ad0WaziII3QRqoJUKKV9/mwsuXwAHwXPsx+X4qbzY6Hifvn9?=
 =?us-ascii?Q?rFO4aet4imSuS/A9dNDLJKI+Kywcrl2RLQ/m2zp73SzDxfBI2/9bj2kU4cgF?=
 =?us-ascii?Q?mGUfW5X4Ia9UoFa0mUKGhFl8O9SY4cihqHrvLPXa9mFV6U/OyDpcKxsYQnZT?=
 =?us-ascii?Q?euC1uIRCqHWqszi/0yXjQKWKPDaZi/L8QKA1UrUaUD9xFBD5MkfaOtCwu+p1?=
 =?us-ascii?Q?OET8I/dQ8p7uq+tU+TpUPfd5UerIWOTqQ0MMb+pvagRncJpAnSkuLF5aKciQ?=
 =?us-ascii?Q?sW1aENyVoYZ+KzqixZfchAjOvtW8p2MoUKGFIwRruxde/Apg+VL+rMsoK8Po?=
 =?us-ascii?Q?6K6FRG5hk/kpz+ymNmx0pNUCTp4F44OZnNlMdW2T62GwM0bBHKI9sVlPn/Vc?=
 =?us-ascii?Q?CcxZ5aOQafv3Hgq54mxpLZslswV6Ui69tly+e78yp8I4DTdKQNeszOx70/r7?=
 =?us-ascii?Q?DRFXLfTS9HzFwbWzANd7AOcpwloqupSLZJvZsh+PTrJ32MDfSaqbVNcI6Fpk?=
 =?us-ascii?Q?+5XE+UJTQtk6MRZqV6QUYqDzbQPcALp0tIkkORJK0S8RnbpOBW8B1bJ4dXFR?=
 =?us-ascii?Q?1Uj20aSj6BkkQf5K9re1e3oXK+ukB+dYHtB0JR/sKUM2vTDzJCBMccLjebW4?=
 =?us-ascii?Q?mzYfq6yAm8jUCQooIlyS/ek8CEzbZqy6sdqE9OnrOGpshH2nVemUSwHlBPBx?=
 =?us-ascii?Q?kiUjEtUIMyb+07GPISF4SvY3ZmiNvs6mUWbolV2bcKrfoixR+fhGg27AHXOj?=
 =?us-ascii?Q?EhsNb8dIFnNcIW2uccria9DWwUQak7+mzaMVPQfIoKwRPGpltMiTsNU3U/Qt?=
 =?us-ascii?Q?jT/FWHFwWxRfsuQtFl11MJD2KOtvu8CE4XeOw95c+ZyDET44rocfsqrkONjw?=
 =?us-ascii?Q?gGlpZpJ6cjGYO/WctvgZV/k/nVE26ym77tMPfVbnZZA6Cw3ZvMX7Ctce3IR0?=
 =?us-ascii?Q?kGxnvBEbXg+3wWx7lc1ZzinmP9Engz2ZCvkinxx+OHOrmTA+KJlzxMXOJmRq?=
 =?us-ascii?Q?har8HQ9kYoYrWapgrih1Kvrip6yKaa3NXkLZz/FepfcyfPCW97FBy/pp9vox?=
 =?us-ascii?Q?sBW3nvBYOCS53kQIeU8rK/82zGlcyDdww3Y4uDng?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe648a49-116c-44e3-1dfb-08de2029c7eb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 07:21:35.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9v2TX5sJVdfLOJIsCywY6y84IljhbYwGCGxy904g5bCO7OUfhZnaDyRHBjJdF34iBmZv/rDOn7euIL8l7nhSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497

On Sun, Nov 09, 2025 at 08:31:02AM -1000, Tejun Heo wrote:
> The local and global DSQ enqueue paths in do_enqueue_task() share the same
> slice refill logic. Factor out the common code into a shared enqueue label.
> This makes adding new enqueue cases easier. No functional changes.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2ce226018dbe..a29bfadde89d 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1282,6 +1282,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  {
>  	struct scx_sched *sch = scx_root;
>  	struct task_struct **ddsp_taskp;
> +	struct scx_dispatch_q *dsq;
>  	unsigned long qseq;
>  
>  	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
> @@ -1349,8 +1350,17 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  direct:
>  	direct_dispatch(sch, p, enq_flags);
>  	return;
> -
> +local_norefill:
> +	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
> +	return;
>  local:
> +	dsq = &rq->scx.local_dsq;
> +	goto enqueue;
> +global:
> +	dsq = find_global_dsq(sch, p);
> +	goto enqueue;
> +
> +enqueue:
>  	/*
>  	 * For task-ordering, slice refill must be treated as implying the end
>  	 * of the current slice. Otherwise, the longer @p stays on the CPU, the
> @@ -1358,14 +1368,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	 */
>  	touch_core_sched(rq, p);
>  	refill_task_slice_dfl(sch, p);
> -local_norefill:
> -	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
> -	return;
> -
> -global:
> -	touch_core_sched(rq, p);	/* see the comment in local: */
> -	refill_task_slice_dfl(sch, p);
> -	dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
> +	dispatch_enqueue(sch, dsq, p, enq_flags);
>  }
>  
>  static bool task_runnable(const struct task_struct *p)
> -- 
> 2.51.1
> 
