Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E939FCAC
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696294; cv=fail; b=ZKGJSYYKd0joLHWWVSbMg5YGgmfC/UzeN8SBOJN5SWOHQ4CVV3/Vasn0JRbepfz+u6mXMdpgYCWZRUTKdk0B9dWkQQMXsz1cxgI2EyEQcjurkrRLuyLxaDNZvzTw4ePZetwmUcN2ZER3EHetWntaDZG+p6QFIQBMwZbKAKbBrzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696294; c=relaxed/simple;
	bh=MzLifgD/U/ezvG/dOem9qttfIm0bIIe2ezQGgOQkcmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JHyXhgDq2HMm9lX4ko4IF2GIPjRSjfdAImi0fJtN0r9pJtllLmzJnBWTC4Fqgau1JwU7CbwiOCbU+0xaUGIkVVarzOou8O17/ShTtdzuGU9PK/XKMPWILe2peYtys6Mrn53RlkpCJUjIZ59J0sjM++sYEGr1STosyDg9Mpux2ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FYmfXbZV; arc=fail smtp.client-ip=40.93.195.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FYmfXbZV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfDKTxJAsbrFVXTF/ck5Fcl4Vo7h/m+yMOaNodc7kxcFSX1f7Y4+t/dMh5PYX277GLn66zvBfaAXR9myNRNrUnHOTzwHsJrDEOSvMU7YLpAoDakZQIgumEQlES9Z5ocqXjwdEoGRiYs2wYp0UZAK4ALDP9CBZwf82odBiXcGzDC0qm0xMi9HLTn13IMwtNETGA+63nV02+jz9XelHA0K/mRwSgJuDWIffi3Hvnc7+EiNZQ/k20aI9I1yC1ou1VUIBq0s9YeytSpJvIHQZNVzhiyjqP8/ccx1mO+CBcDaCcCl1AwaDIPhCs2YXaz4u6pl1rQxOlFJsAJrGlNZ+XXpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHekBaZbS9TFHzYDmkz8++BbhgZnaK5MlhuvUfyoYkc=;
 b=O86ueWnyflK/9EWHhlkwja66+QLqiikQLu1Ubhm4HetGhMOpCj7DBrB9TzKS9dUM02446KTQMh+xeJOLOGsm8s7rLFNJNEmgjb6sDLkZjWI/ePo6xQYKrCLaxkvryFYfSWt/+hS3exB2qRudnHWdk9Vz4qifhJThzC40M7yhGVwrLskgZp3zWYb+juQrGC9NbgTMAB2Y01JP6sgRWwmzW2rrkQkSz0Kd2V93dXi0o6YXUtzdPMBGMe5+8cNpTQ6Mc9mz+pmhJWEVcqQ78nKEK6/bsG7g2E4ilupibDt+01f/oDs1eYiv+M6QVbmcHoWBRcsXKhWNJ2YETmX+IxrbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHekBaZbS9TFHzYDmkz8++BbhgZnaK5MlhuvUfyoYkc=;
 b=FYmfXbZV/vf1yJz+lgk55BhRFfTAfOUz0N8DGxsmhzkrvVkE6AnY0JUyL8Nj8xzPN3h4zKaOxfncwLUUFdDA8XKbIUXIQSpFcKjuEmliRVrUjNQN4/4M/5vXSk1xr/P4TrKRO01gssDtByLPYZCZoUGza+nAo314msyGNpHWT8/0Qv6d7q0rjLWLvNkBvU2+iB8Y9wbeEbPavfxUVWhulRVxTpP8hxW9O18qgkB9uFWrkOzdTwV2sVqmFDnUwtskzETjkqWYeYBpup8m8HGeZD7SjR+/Zez9T9BJKSYe6nnaPp/DpNMBUCKNe896vI57NDEh0tJnFOhPhJqwYknmgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 14:44:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 14:44:48 +0000
Date: Mon, 20 Apr 2026 16:44:38 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Documentation: add note about multiple
 ops.enqueue() calls in a row
Message-ID: <aeY71ushadT9U9I1@gpd4>
References: <20260420143939.3636883-1-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420143939.3636883-1-jpiecuch@google.com>
X-ClientProxiedBy: ZR0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: b9014f20-daf1-41d8-e76e-08de9eeb5f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bzK4iQhyN0v2JHUrq/trvebt22zOyRozojfT6t4c0rLaf0ZPoB1vaI7lssVE8UziP7ZezpXCR2vsx7Tb4rp9JEbWeLXhqT2RiPMHZgHrDFyYeZtFvFpD0OwOo3gmOdNhMssj+TY9ocdza1uk0BvA0S10s6uTd6chATZELZFNk2zqlQ0wnJ5vC0gHi6JIw1rE/Jg3oeS8ZXNucOZ+LfSFc5A7AGLNqnwy+aBIn0kIdiwJJrKP4xK3kgt1eO6+YvcR1vagGavX0R+QQ8yFLjZrKrlHx1rE+85U+kxmVsAo55q/+3jLtvvLK3NHhPX9LyNCPD9wTc67eLK86J4PNH3r48VXVFlBsxmgfJZMOWMCD+93hg9CMcMJLehzv1mjVlO7gISBFY1n6gXkZ4LkCG1BLI2nwxK/H25VY1kpj9/fRlnT9lhEmn9SAzY6wq8Yc8Q124axS+DHUxdJ3N/CwoVtF/xMQlUksushFaJ5V4lukYboO9y+AM8K2OVujUUoMTqxk+ipeElJkZRWHKjHr+vLdYNPCQoDKpQEdjgk/D5zsZiyjcbqfkrNudjRJQTKR/SxOf5U+PkaU0o+gGlGwA9Boh8tIZq07Uc9GpBgP/eiU0i+h7MztzudJ64taVDDn99/W/OmCNNAmAbkoVIWG40mWmgikgIpKGnz2dZmCcmdy3R0THVyGGM6ZPHgVxNkF1k4H17N6T8LMHY/rLuspCHN8FUp7Qe9gEH0FehSjouDl+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aFlYS7fcn7WVTQmWmyWQJUxzNBf/50HnBf2iQT/570nWNVacGaCIJ8E6UWjq?=
 =?us-ascii?Q?5vv+KpvVnSrsYaYIyvIvdgnPBoAqfGVR9PSKOSWzW0w0E2+vTu4WlVp7Fg05?=
 =?us-ascii?Q?xkuPiP/KxaBtE5h9rKvr4SerziS8N96nrbFY4fSyi4wAIQh4mKKG1KAUy2qk?=
 =?us-ascii?Q?Gk2IaeSgnBwDZ10D3OpdzwjzTVpeAZzhpatHLMV1RnawCAaFZCX6iFRA9HvT?=
 =?us-ascii?Q?7spOyO30Y+yYUJazi/QLC/WsWq4cK43LchAxzHE/6aWutn97UGn0qhkhJ2og?=
 =?us-ascii?Q?pTD6lgk2tDFu/f2setV7jPDlHVn2JMOOJaAk1wfjsWkLr6tDiKqxR5k3fllL?=
 =?us-ascii?Q?1rT2yTw9m/GT6e27UGmIIlJbJzLEAm9l8DCrmFqNdbnHp7dEefeUKT/25ZPa?=
 =?us-ascii?Q?NMuxMnf0WGiuLSrpOdLg9iTX0KDfVLrBY1TJUhCuLtYbayDnWNBYo4GI5NYr?=
 =?us-ascii?Q?fN1jCqAErDCCPH4ij3zhLkqHqS1Kd8uZy0EW/IZEpx5H7/biKsYvhEvpXyXB?=
 =?us-ascii?Q?D007/tuRjoucLU0rR1ATBzDQwvPK+hCaFu8q58F3uLfw2L5xqeIPKpCAQo9U?=
 =?us-ascii?Q?QgzRgN5f2frVdhV6WiHDhVjbdezNWU6rfZU1JrfvG2keb2VA2l5J0e9fi9Qm?=
 =?us-ascii?Q?Ozo00jxDoHtddYKxv7PMjmQp2O4jJ+Ikb3n1xUTHGJSm+f/F+Lu57lR3JGEJ?=
 =?us-ascii?Q?KPx4SbK/2KvlXwoQFWZl5gy3uq6UV+LZTwFIa7RWFcgHUYnPkJ6S6kfJjF9t?=
 =?us-ascii?Q?/PeFKTZpISrmq272b3GYR7gzSOm8M8fedSIUXlgbTQuCq14HFEsxZPQ5MphR?=
 =?us-ascii?Q?UHpxorbio3+1YsVSdCR0vKTN4kVSm6z0dILUb6AIxguQs20tx7coSZFE77+9?=
 =?us-ascii?Q?tBaE/6M1vfFtuhHzpTio7NG7TwmgRQiHDfBAXU9m/ZF27K54K22HQgZK5RYH?=
 =?us-ascii?Q?wvEBIisdAxxvEXWB7Q4B0JmxS4jMYkZytvLXCDNOcT+/bMia7vGLusg4KYYx?=
 =?us-ascii?Q?h+wkrwqGQt8xKBeKI2dNc6VvOc3qwTuHa66A1X8USa9ZEpv0SBZUyoaVg9Eq?=
 =?us-ascii?Q?VKvhL9HwQb2hFhRk9NRx5RffjQaPpaniPL4A/u+6j8NiZeOWnhSYCSXdszIY?=
 =?us-ascii?Q?Yq1ABlHvvOST/C5MeqmhlpGbB6Pn+7T6G/kUjiKh3jUuHePQayJyHKPN9I2t?=
 =?us-ascii?Q?+2fCuB1n7dcs65PA57OagihtBhJ+fdFNTbjF0TR2Xy/FiuoC2/7FQyvI71Kq?=
 =?us-ascii?Q?9OnYvgxV5o4QorLqp3/yTl6dx+BLilxiMTJ5oSWT5S3QaEbKZJSwW5vSqD/F?=
 =?us-ascii?Q?v97tmdz3KNmczKvUqjgN4aXpqrg8PawQpjF28jvI+5oKGjuN8I1XcgJv2xE+?=
 =?us-ascii?Q?LIrqlxwGu2oPT5V/6W1ZjQbciGBVHFYbOYMvSL15WufEIaaipxY57Okpb/K3?=
 =?us-ascii?Q?31Xda05L1w8QAuj0iirBKG0s3fygKHNvmGOT7sRTRcI0xvFgSN2loaw6Iuu9?=
 =?us-ascii?Q?FqV8xr3QWxSdtGxbBG9pRk0+MA6cIhsQ77oi/3GF2kkD3xuAiRlAR3QjHov0?=
 =?us-ascii?Q?1tvA+A7tIWcTxCpGhImJzmIRzFacuPqZiQDEFD9+6ZpCazJBUM5Fw6Hn1Lpp?=
 =?us-ascii?Q?UIoDRWRZhQtj5q+q7ZK/Yq2w+pEswM+UYrmF6M6MUFObFYw2O70ppaX3weyc?=
 =?us-ascii?Q?7aPn99VeBSOMLe1knuW7rs8mM3JX3KeFH/EK8KK28ase1hHgiQvlQwQl9WuE?=
 =?us-ascii?Q?Keh66Kif3w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9014f20-daf1-41d8-e76e-08de9eeb5f11
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 14:44:48.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byjOH3lETfKAkg80Q8ahIia9k2/u5eMoVpHINY9zwtfkN87bpALGQ85s6t598+eheaFYCyQcqU8ANFq71s8sWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

Hi Kuba,

On Mon, Apr 20, 2026 at 02:39:39PM +0000, Kuba Piecuch wrote:
> Commit 84b1a0ea0b7c
> ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
> introduced the possibility of ops.enqueue() being called multiple times
> in a row for the same task without intervening calls to ops.dequeue().
> AFAIK this was not possible before that commit.
> Document this behavior as it may be surprising to some.
> 
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

Looks good to me and I think it's good to document this special case.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  Documentation/scheduler/sched-ext.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 03d595d178ea..fba09aa1cd4e 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -339,6 +339,11 @@ The following briefly shows how a waking task is scheduled and executed.
>       leaves (e.g., when ``ops.dispatch()`` moves it to a terminal DSQ, or
>       on property change / sleep).
>  
> +   Note that ``ops.enqueue()`` can be called multiple times in a row without
> +   an intervening call to ``ops.dequeue()``. This can happen, for example,
> +   when a task on a user-created DSQ is re-enqueued using
> +   ``scx_bpf_dsq_reenq()``. The task stays in BPF custody the entire time.
> +
>     When a task leaves BPF scheduler custody, ``ops.dequeue()`` is invoked.
>     The dequeue can happen for different reasons, distinguished by flags:
>  
> -- 
> 2.54.0.rc1.555.g9c883467ad-goog
> 
