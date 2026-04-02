Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADE38B120
	for <sched-ext@lists.linux.dev>; Thu,  2 Apr 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135261; cv=fail; b=Ms8jf+Pf1u7sMpo58r4QxaHqwZNu9NrJx1uga6o/VKLedVQH+dwC/OxCA9wOgyC1aQxFzFCPi8EzLQja5TrMU3SCapDapklNH2Gs9+mmejOM3DnsgtTcAnXtFGhF+4nkrN1Fl7gsS0pUKHFJGsOB9ZrL+rC/hWb+DtH1aQXk2o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135261; c=relaxed/simple;
	bh=Ehdrbp7Z/An7pB5cHxEBytTDSFof9+0Y659xFIt3gAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KyyMEsyCj0jcUsahgrP5ecsDdCJZR1NqbdytK71SCcntiU+LNrlIdMpAa29Bl4ZlX/bptqCNzp60vhCBU/tCdy3j1tGaVuxjIJNe4KQrIYER0lSeKHhsN88HEmAYNi8/8LTWpHvXPV3u2VECKJhRyfHFNgiTqFjAhNB7Nqned/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PcWkYrDq; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PcWkYrDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/jMAbmZjMnDhspMLGwHIVgOTSWVUEHHJ14/f+edlRCaQRrrPQatfo1SDqrDCT4Je82o189o/VGtDOyULCmCUcy2aoQow4YGh5GRkFrLGt411LtnyP0sEgRR6C2Ms11YihDFbMo014TpxheHTDt0IiNVkktvirEI/TOLbSEBPLxfAO5pmnD1YcrCU0uywyDQK39xm9qwx04xvr5cuSvmbetDm4qiF+SfQ3IWJBKJFx/8Wu6bODurAAkw0rT84hiY9EETq9D50aUKtIki80jQGsCT+XYO3JbXN+xpQMJ9jOsH6+04XLxFw5hzFxJm63KB+Iu8ya03cUyLf4yhmsQafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2KYg4z7f4Gg270loKXDbFrF2SG0gBVBfzaTB1AqJfA=;
 b=KudTWHFW1mvt7ZgQQ3aqpCCdOtlRnALIhmmqxxsPEr9HsQTVmzsEnkgGMbgXxAAsVyznlepcxrrFnGnHjqky/EHOkE7wi+m/JpKj2sTN7xw0I3psCDpYsVLMm/GLw6mvXb+ZXJZqW9PjNt6A6pXcRtkbJhxPSeaYDoc3FByy/w/nR8HdQRcfS+JqVfuhcLsU0I+0mx3GTMG2e5Xs9OYPaypzFfVJbDuUa+SVQFOnH1CUqX3hfcahcIsUJC9E96a2xMP2dIFtcVcBq1TnUNIQY2XSw7VUBvSWNHDF5s5hen8iaNlVVpSNsHPa3Ocu94E04BjsNEwuSCY0mcJiI9fgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2KYg4z7f4Gg270loKXDbFrF2SG0gBVBfzaTB1AqJfA=;
 b=PcWkYrDqW4HkP/hG/eeWozzWnbzvcdp+3QWrziUHFF09sIYK3Z7PMR+E9Xmj5S3ENmbqPOw4s2sw1gXscY8wfFcdtgP4W0/xWq4LooHaoDPpBnrAjxUrjKPUMbjfsFuo7VplALjQH6mYFCstNwLkL63jKa7+GRQsob9psZksdzBsMkUWZfmXCyngJXqrkd0DDl9vROEy2so06pbpSSQOcHgrqmWZx5msiOWt/TfHUUgKTLaxM7dwG3merJz6VJCJBVwJejS5tsy/n1Vqy9CSmmnMbqOaau9yC+JOXtNvvYN7qK3DmpubQ8nECrnYgift5jcSyVIXT0SAtTFBVxqE6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 13:07:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 13:07:30 +0000
Date: Thu, 2 Apr 2026 15:07:08 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Samuele Mariotti <smariotti@disroot.org>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH BUGFIX 1/1] sched_ext: Fix missing warning in
 scx_set_task_state() default case
Message-ID: <ac5p_Ct9uE5JlYLn@gpd4>
References: <20260402115707.1200476-1-smariotti@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402115707.1200476-1-smariotti@disroot.org>
X-ClientProxiedBy: MI3PEPF00004EA7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44b) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 6987d389-50fd-44ac-bab9-08de90b8cbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PqvL2QkoK9O13wVyWRZv3fuxasSu+tiCT851a/6ZLgdLznUXXXc3pVRl0wlHNJDcd651pLzXS9uxjoJvD8eT3QdU5m/uhbuUkUMwfH+5vY49GneFKjZhTXpWCw7YEoimsGfwgjEecCbQNcKYBatCH3Q8cuCvWGKvsiFhB/G7wXOftQa5KI1E9BGI2Xu1CA73EMad/Z16atM0xVu3VmQtbqWe4R7nECMjP9ZDessPGLlkusqbG4BSweAHrTtvuOdGkXxZDvgA7z1CMrtJpdEi0cGrc+yZVZsSc/A/sIpKj4zzbW7UXzWz/6IpmjrnW4QYUaXQW7wVyQE/G492O4lm4xRi+iPm4BNB6JfQ4RcD3WDSp2ss/rQfjAluiQGwoDfo/3lbGGC/drvCjyJxUZvHRpf9xhdb3dfHz8XkMcERx/4KYSi9Qzqi6wz//pKYM3wARc6QCNaDNuAzbNN75IocA0bzu1k/yvqmscYlHOsNUFkpAycHzMLupF8SrqETK/Laztrvm3zPh/+aFHZ7eNnqrsr3x139pVcVeXERjSI44SGUMBFYI4fK7CUi09qbLMHAKBXlZ6fCL1M5MIlTQVWiO92B45k8wFieVMSamTeP8zR+wBdBs94PEIl/2zkXJl0OV6tlWf3jnXwgH9T02OUO4KZEh117V976vvdYww4X+9T7e+gQlkaxgcYKGcb+13T5LnCfubdwywlfambDxsGvrlH++9J/akTQWBSiQGHNbgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1mpygSxzYWefh2HyBzc81hc2T1C+yaqlcp+DoOIh43ve7QVfzPXPmzZQx04?=
 =?us-ascii?Q?Ah3DBcKtdsa0nyMKTG+he2rlhcgnS1vXYxT/w4YtBtbcs3Cz1pVugu7PKlD5?=
 =?us-ascii?Q?8UXlPfIqE4yiL8Dss/I3EbE13XycNruD/lbbECsU8yIpt0MmmWOz6/KbU5wt?=
 =?us-ascii?Q?Zpp9TSk8YZ/aCk4I7k1B0pJhFUt5FMm05RRgq5Ed9y6ped/hAN9JqVKyKVYz?=
 =?us-ascii?Q?jAFLpvL5Wg6q5dArvSn1AyL2xMbzeHFtXFKhflDzyDUTpBnafow/4PLl2Xvg?=
 =?us-ascii?Q?D/74mTTAVBk9bVOZdcJL3EYH2YtgOkhKB+QejNBTIq6ZFy14jA2eFsIYTIVt?=
 =?us-ascii?Q?vjKKMkFHzboQTwEvwrFhiSRxjFb9fpMR2llrT4miwgKWrKEho43oH50PW1ir?=
 =?us-ascii?Q?5q6287PCVaYbpt9AvVjzo3y+1TwqfZv/wV8+KG3FAVssHQ7c65LbE4Gjpz2p?=
 =?us-ascii?Q?RRsLl2kQFAN6CJjZZRkM92uCo7HYtCG7ril6vlDDmg0rgnK9/1sEyybEvaoY?=
 =?us-ascii?Q?+2bCY3B1IPXYa2rtdpC4Ivja0VqXFg9fS+GHowYRN/q5uheANUAXx6egQVQe?=
 =?us-ascii?Q?5LVAx36tM4H78e/Oi9kJgEwJp+BxT2H8LrsBXpYmV+O+ZZk0tQBgUgcqBT9N?=
 =?us-ascii?Q?nZbP8Abu1Ef4EkJH6SGlzspj8F3jL4wioFXd8eJyLnd6/FY87wQf9U3WAh+U?=
 =?us-ascii?Q?w4fbIgarXcDW2Lh/PDIhM3yd/HV1fl5LveXyB2btwymdwcVj29R5zmcob88E?=
 =?us-ascii?Q?D07JqibSYnnbhvzSZeqgf4HjBWIIyZAmXW/HwLU/PdEEWmVVH9Xhg6xuf3hn?=
 =?us-ascii?Q?eh4aCcciHqfmTZi5JG3C1oTRGHIiPCHG2uegpgSS9TDDCuW2USoHCzRa3qiG?=
 =?us-ascii?Q?Wv8uFFco+IpzRzAEYSERXStsFsQFJixOJZ3xzY67uHffXxZsG9Sv4afPzD5Z?=
 =?us-ascii?Q?EHQALGuSaiCmPcT/nAqURzFgB/suxNzaI3eEQGICyWF7quqbPCMYvmwxmiME?=
 =?us-ascii?Q?zlrN26BMGS4Wze6VlYHt/h1jCPL3bKfi6Q5sbzU9S6gEJoUWznsvCHB79Zb2?=
 =?us-ascii?Q?kr47LM1Skr+qECUHtBAzas8qYnEYbB1Dwa+QKW0RRgg8rDd+AcE5ph9C4jwG?=
 =?us-ascii?Q?sih22OCAC8LqX0UBIXb7OAtBLI0WLs1PDCDxd8Agt/kzcmkqvrAJlcEevZ43?=
 =?us-ascii?Q?tC8CmI6ERiCBGURHkmzpK/At1cmBe6hkPNIqsmdKRjdCyh/lpIsTsZw1xNCF?=
 =?us-ascii?Q?VQe8WaLQkUvnXZp9XeURPd+NVCrOXVyMI81dyXUtTU2S46F3cCxb/8Ga4Wng?=
 =?us-ascii?Q?2lk+qv/jwQvXji310hbP00aZMnSQlouJd4VOFlfHR5vJLIEm5IvFEf8RsFrS?=
 =?us-ascii?Q?LVaHwabSnf047+ACfshayaTa8oVGMYvyf3/hLGQMbvaAxg0XoAWHmdtWAbiQ?=
 =?us-ascii?Q?blH1fOyV8od6L/kQ2iG9tgDj71dYhVXqcTRsbX1z5yCcDfyUm7Dv7JYPDOtv?=
 =?us-ascii?Q?hXtukyRGP0FHwbI6jU656Ubm+GNUJkXW78FrXYzXwtYUkw4kq9TqrDSDgUJ1?=
 =?us-ascii?Q?sVz9nS6M53eMmnmY/cqsys6Vz55tECvRWsR4EgJna2va/qe5jZ5gOm19OZeR?=
 =?us-ascii?Q?Jrz6R3GWoSZbhjx1sJEbiZsCSiLfoOCGWx9CBPzWjFGrOOpFNsmZ7nVQxBY6?=
 =?us-ascii?Q?FYUB0y7t8qCMpffSg40ETJPQKmOtDJTOXlMFawZt7kEP74J6+1XQu4yWOKpa?=
 =?us-ascii?Q?cSVG43LQDw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6987d389-50fd-44ac-bab9-08de90b8cbc5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 13:07:30.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svWDvNIFnPirJkdHARMnZ3T4JAFb8o0MEYaiOeyJNRZk3KDp9Yq4AjceQh1/ECWEmwf7dF9uy6yeGc8YbQO1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

Hi Samuele,

On Thu, Apr 02, 2026 at 01:57:07PM +0200, Samuele Mariotti wrote:
> In scx_set_task_state(), the default case was setting the
> warn flag, but then returning immediately. This is problematic
> because the only purpose of the warn flag is to trigger
> WARN_ONCE, but the early return prevented it from ever firing,
> leaving invalid task states undetected and untraced.
> 
> To fix this, a WARN_ONCE call is now added directly in the
> default case.
> 
> The fix addresses two aspects:
> 
>  - Guarantees the invalid task states are properly logged
>    and traced.
> 
>  - Provides a distinct warning message
>    ("sched_ext: Invalid task state") specifically for
>    states outside the defined scx_task_state enum values,
>    making it easier to distinguish from other transition
>    warnings.
> 
> This ensures proper detection and reporting of invalid states.
> 
> Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
> Signed-off-by: Paolo Valente <paolo.valente@unimore.it>

Nice catch, we should probably add:

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")

With that:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1594987d637b..10683ce4e415 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2863,7 +2863,8 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
>  		warn = prev_state != SCX_TASK_READY;
>  		break;
>  	default:
> -		warn = true;
> +		WARN_ONCE(1, "sched_ext: Invalid task state %d -> %d for %s[%d]",
> +			  prev_state, state, p->comm, p->pid);
>  		return;
>  	}
>  
> -- 
> 2.47.3
> 
