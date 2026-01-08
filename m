Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D321C5D7D
	for <sched-ext@lists.linux.dev>; Thu,  8 Jan 2026 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853318; cv=fail; b=GqhvPLfTHHBp+brj8ygMsTq1fe/iTAs4zZqRgBceqBeYRRpnSMwxAmMjTBPr33MjcpQm+7ixwxh+PfJNzImTJSqDENzhhEXa9aBGP2JhUev+Bbo/JDuiZBYz1fv0bebislfDfHuqZiZhr05y/M6K0SXxw3k5d82SGYbm69r/w6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853318; c=relaxed/simple;
	bh=bjyzg0Nsm/joHBxBzoDsEWuY6oO1ZGgT3WKwAuvcjOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rCeHVURxfogbOSx68eKNKgaTO+jSAfWq+HieamxOVJdfFvBdlMgn7U6gD+pdokXX5KBXkUtaCGHPnUQea0EMNHHHXLoSqW3W3mwR5HMoJLNAt+yhkEwK5hmZoZ1BhiE3Ezp72xayQ4+SJxKBGJ9M4SEHlo3T0o+ova5PSHCEeI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VsN8klbt; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VsN8klbt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1MvNSSN/0c/IIkpmGIPrlqMO5SnGz38Ej8/MGUjI968JAO0Q4poxZnzqFaxgS9l0tLv4Xvosk10SaSJ5dnz+2euaPi6nRfpOIsgsAUbagwYkce9iJmSBliLndy8n4+lLsXgn60lJdyDNz4eN5tCaZ3ZcK8dJhCYckP07FwdhsfwwL7yLSq91zWZwSvImYGTNPYXTYXDO/hE7rLH/MYVQwLPYyZT1sJRs5PXTvWFA5FI7+CexZp+4Ljm8tmrLThymbcZFz9IEhhtP8xST8aLbMllEs0tIUWIt2ZFt415CPiFrMwA8NzmZRFJ9otbLpTM18OPqdFp4SD1zhq7YuLe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuQFMmF9VpiCL6ljFfUMbTWRG/f5RLkiVeM+udOTo1E=;
 b=ZnbWPC/FToDpCVZ5GAgJqFd4MTjP055dBAx2KyvhMk+IjskTNYxiwCEGf654FLQTIx1Kucq6ayYgRFAWPTzFxGc9UGolzO6x+zV/liCKzpuJ5BtVfg8FwukCC222GzqXbse8CLfGIkUthWLoKCwu5xnaMjXbdw7Uc8Th00nYQGrmR9PVEtZDDoZWMcC2v6woecxAy6dSKp8jvO6cMjb9MHMLSb1QZJZE3svZRvUgERHswrnOCNA3zKMdXrCkpj2UYvEULXM/uSmYvfLcGkJSIBrt0eUZliJMnNGGt7BCAGuGR/ZGJPY1ps7qgdqw+OL32Lj3VNkRo02s7GJsva1coA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuQFMmF9VpiCL6ljFfUMbTWRG/f5RLkiVeM+udOTo1E=;
 b=VsN8klbt+yiSx9hwOpCnOK8563sA77awaueGQx7JtTnHuxOBkP7FMcuP+DsjhAk6bl2XQtIQYnnUd236zT9Q109bTGAzXoYTg39zi0ujwv9czKFM0JoWF8Sv6LotT8A2hAhv+c+eglUsVtPvkFYdnnIf1HFnoVkPYISUuw1mB3phU/HRIDCrJ2KUIHkB4CO43ae/kk4K7KTWvXEjppkVBWE/00U2QteJTdpIGAd3+L8jcfMHfa136Vv65xEI6HqihviY/tYH8OKiLp1uNnrievXViK3HofSDC2OZ3CxxCWnFBBuC+8Trp13lPjjzT7SbjrVmZkkKR4x+2uTbLnxAAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 06:21:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 06:21:50 +0000
Date: Thu, 8 Jan 2026 07:21:41 +0100
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH] sched_ext: Add DSQ statistics collection functionality
Message-ID: <aV9M9RlSt28ljqCG@gpd4>
References: <20260108023554.1735052-1-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108023554.1735052-1-suzhidao@xiaomi.com>
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ca3957-7799-4ca1-82c4-08de4e7e3572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b8gp9pNi2UWxeBfAqpqgTCrjnGAJUvyLjXGdGICKQXkMe5jm1Me5pEDQwKd+?=
 =?us-ascii?Q?WOpf/EOV3oSZniK6wcSnD8zO/7isNIStbITM8lePq+LI/riSvIIYEeAi1+0N?=
 =?us-ascii?Q?+1UEf5iIqOsBpFrlZAC5fdvMM1HvuEQ89OM88poiSfJvrH9C1OigUmLwInF+?=
 =?us-ascii?Q?EOQBJbVK3LeVQ2jTWwFI0d+TJvg2RKZGc6R2Hb1w2Aiu9RuNOyUSl3wTUx4n?=
 =?us-ascii?Q?ps/ODamzIGjHkweh8gP+xrqsVYOe/vDsDd/P0DDI+o9cmDk1Y4BtDZaZxXPD?=
 =?us-ascii?Q?k7oHB444cx/utYMH6m8upq7S6atJTbNzMutkx+V+P3MTJHFO/3fzWBQxyawP?=
 =?us-ascii?Q?eZsx/81gnQ/Mx7Ql3rxwrp+DLg8FYntA/ID4xYi3g2VKwlOTTNIhdweZNQCI?=
 =?us-ascii?Q?rvrw/OLrYBfMXsxzKwRG+tHm687+XADlH3XKGQdZtkzQTE5cF1RTVgrYXIAJ?=
 =?us-ascii?Q?++tXG8MOu0lfIHO5IWouv4/UBPmSXC5eiKHrMe/dfR4M5kPNhiZvBU7aOA+O?=
 =?us-ascii?Q?sDFGpcWj9ND11N1C/h8i1t318i/U4WqGyvSFykKM3okYwqsJ5gJC4R9R5gix?=
 =?us-ascii?Q?DKfk4sgwfLlZxszlFikVIccjAOPq6AyI/Pbw8aS2qVDdIMaTBMnIxH0T62O4?=
 =?us-ascii?Q?mEglo56SuQGyjlUmZDiRzXKvPcf2xsCZplKdjkmhSERC3kcGpgIWFuG1325u?=
 =?us-ascii?Q?FC+NebrbNsWPCI2COanIE+OtAuLnaczYFBpDHPGR/8IxaobjGcmBrqMhhTqW?=
 =?us-ascii?Q?pquq6VXKpqmzHtPRK94PmCgwY8J5RlsKg7Dp1gag8IBdVz9p44FOjFoqpReC?=
 =?us-ascii?Q?CcVAGFW2CmNmc1mNTVK+ANk/OAqwvQx6aYP7yNOBEXb5apniCf9DfKfe+h4y?=
 =?us-ascii?Q?Z7WCY/NIA5FSgFO6o0Bq0VxzMEkDUbZQ7mTz4mu7DmJb5T7PCAgnWmN/Ti19?=
 =?us-ascii?Q?zzYGpW1yhbmvNRCZoRMy/3H6/hs/jPcGdSGDGKJBuo44c8HEnUVPwRWdaqLB?=
 =?us-ascii?Q?Wpns2HLZtQWI5LZaCXvc54Tu+BwOcN7DCVLq2aYbDfoaQMaMJGef2zNbAZ1X?=
 =?us-ascii?Q?4S5ADAXBkySscagxMA4X8fG8rrHINzRZPG+imKKmXgvfrIRP2xtEtZZjmKwL?=
 =?us-ascii?Q?wOXY96rd0FwGV7h2mfceoS7EJSFPnbsmlw3gp9lNXSPr++CyXzBT6gYAGKJz?=
 =?us-ascii?Q?Cfh1okzEp4U/qPRZJSoEbyyHS76j4iMg0C2CdIj/cUfOAyOKRECmn3DgLmNE?=
 =?us-ascii?Q?+RDdluIutTDJ3mWAp30lnN2AeOLFEXRXnbFwdjWuI3caE+qkIj++SipfG7bn?=
 =?us-ascii?Q?SIuXBe5vyC3n0WErnHjWQmKAS8lmLB4lGk0qUTQs4GWBME1u1laU7EY247O4?=
 =?us-ascii?Q?H40H4l0u8eG2qchbMWfTphpJ23TFkKHsuJL4r25707E8jHu9ayTT0/E+67mP?=
 =?us-ascii?Q?N1nk7EGM2mbWbGE7VSc5XyN+u5C8Ckqn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mj5ZfXT0VYCmZcI/SqXehAm3K4bdFcb1zkyUH4qgjOhYwtX0sBP5d+OM4NBy?=
 =?us-ascii?Q?O0AibtBWPWLEuJOKzlBN2dwoSqdWMliLFZmohegObRoxOdkIxaskBFrsK0TF?=
 =?us-ascii?Q?mzjhRp7SkVF7cLwO4/Zi9bg34EeGG3o3Bm50tumVThHpLi5abTiofFvuj/Dg?=
 =?us-ascii?Q?yYZ6q2+wZ0LQB8w+A0xU6/YvNb1ZUfYXQ7c5XWaLiB2aPlfUo+c3VhRCjYrG?=
 =?us-ascii?Q?tLhcQ7e1wZlIAT0u24eb0/2JOEJlpad93L4qzyXJERBDAM/NGlH40xwjwZJ1?=
 =?us-ascii?Q?RmOENuHo5yCtVNBP5lf5BP8gordFApbfnBgCccb3S3cxNBfPFajScdcs7cEG?=
 =?us-ascii?Q?9FnP5Jnu1PIph9NX6crdCPwGCawUkWuWM/Er7PD5DyO0cokIeP3bPwpnEKLA?=
 =?us-ascii?Q?MKoOhe/x7RjURDTxE91ylBKspg14yS/xywNje1WZt8feIiLNxkp0XRBIOeyg?=
 =?us-ascii?Q?INBGc7OB5TsAbuxb20LRXwNsKS1FHQTzHuazdiqNdwcAGZJsms9fxdx9yH8k?=
 =?us-ascii?Q?cXwqZq3o3MOMTAsB0fbEOjeaZcxFkB88/z6eoBU8lyR1qZJBq1vCkTMmVqio?=
 =?us-ascii?Q?7WB9c8tN5aJ6ETPHSHD5SvlXd88MZ6Yu7wPM8UwzMzRyG/FDAgrQfJXvEaBR?=
 =?us-ascii?Q?rkloGuTupdRMefgf81hIIBoGYTpBdn4/5MY9DcCyKlNa0CNnPP2KeJy5TntH?=
 =?us-ascii?Q?B1FC7Eviv1G5vHPe0WoxqCTf0rWFvM471Keh0pVdn16HBWs37LcK1Od2MQg8?=
 =?us-ascii?Q?XInOy/UfFkWrzN1Akaiv78VESs4T7yf1zBgWejY01TPFfM1wjgkoja4Pjh9n?=
 =?us-ascii?Q?z46QGViAydRi9wTY3Z8x6IVnP4uyAoQtyoXBdwkmb7RXZilrc9KpeS/7BQrU?=
 =?us-ascii?Q?iogu/atG3eEnhB/0Q34Sc8gJpPq0oBA/6fNOb6bkAFg/8bV1+phq26j7sB4e?=
 =?us-ascii?Q?de0F3eDAP1l4C5YeMLAeKmA5o0kpx605IyaN1rruBCFC/gyweHmTTMlLWuOF?=
 =?us-ascii?Q?rpZIASyl2RQZ+tQ1J/+u7tz7q//P8fjXHFd6JY5W91tIytJEcl9YO/38CBJR?=
 =?us-ascii?Q?c3tC7IxILtv3SEvET+zWnN57yosIZw6BtVHB7JGImg8zNG7i9wlWwfWWXNtk?=
 =?us-ascii?Q?zWGL9E2u/iJ3dFtJdNY6rBtf2dxpJllek+GhNTrzaetRYr1cAJM3CmlMbkx7?=
 =?us-ascii?Q?cu6XuQsVXHz7HssBeuM8kaVx1B1k0/elGq7HyHO0nZNKRyZ52jQUcv0kApUN?=
 =?us-ascii?Q?b3nK3UraWYgH5QzrInhTE2P7B0LRV2/gvs6oIqNpJhHYE2YSfDdqrDN6jkBt?=
 =?us-ascii?Q?ds5RI0eSyRnaZBXyI4N2vzkHJrY0lRdbWp/Y9DLNAbHh9kMpKT1GVATxIlUp?=
 =?us-ascii?Q?x717tzKRCEb3tLgI3nBsmXipW8GNTKuWmY6QzpoNPPuffkvsAQtMDFqvrGuZ?=
 =?us-ascii?Q?TqMW41NSlFGmoWlhA7iZAZPiaumDo9LB+WOtWeCi58e3bdNftW1TlQYHIRHt?=
 =?us-ascii?Q?Do4n/bHZUX2A5LYjLrJwzVbi1jCjIHuJPw5H7WE/8olvFKzBLu1e4PUSZ1r1?=
 =?us-ascii?Q?kF0K95ccOg0T7Eg7BOcTLb52xfVznwOmgJwtjY2ESWarQjr/mcSwPZShO5oh?=
 =?us-ascii?Q?y3tdmD+NA38qIQOSTONU4PVTHmnWYrcbcK+uJPNg/jqn4TzgdII89lF3P6PN?=
 =?us-ascii?Q?e9X6Cy+cwwvd/iyWMxsX9/BUkBd0HoIO9ehXlboJakY4MIAs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ca3957-7799-4ca1-82c4-08de4e7e3572
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 06:21:50.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9V8BL3imcVTokdnxfvPhpWCtIpzBcWNOkfzYAEKuPyhAL7lruGRkzQ3xgtzM6QLDcbjgL7XwtASPfs59HEmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110

Hi,

On Thu, Jan 08, 2026 at 10:35:54AM +0800, zhidao su wrote:
> This patch adds statistics collection to the Dispatch Queue (DSQ) system in
> the sched_ext scheduler. Statistics tracked:
> 
> 1. Total enqueue count (number of tasks enqueued to a DSQ)
> 2. Total dequeue count (number of tasks dequeued from a DSQ)
> 3. Peak queue length (maximum number of tasks simultaneously queued)
> 
> New BPF interface functions:
> - scx_bpf_dsq_enqueue_count(dsq_id): Get total enqueue count
> - scx_bpf_dsq_dequeue_count(dsq_id): Get total dequeue count
> - scx_bpf_dsq_peak_nr(dsq_id): Get peak queue length
> 
> Implementation uses atomic operations for concurrency safety and follows
> existing kernel patterns for statistics collection. Compatibility macros
> are provided in compat.bpf.h for backward compatibility.

I think there's a cost in adding all these atomic ops in the hot paths.

Also, why implementing this in the kernel? These statistics can be easily
determined directly in BPF.

Thanks,
-Andrea

> 
> A comprehensive test case (dsq_stats) is included to verify functionality.
> 
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
> ---
>  include/linux/sched/ext.h                     |   6 +
>  kernel/sched/ext.c                            | 156 +++++++++++++++++-
>  tools/sched_ext/include/scx/compat.bpf.h      |  17 ++
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/dsq_stats.bpf.c       | 101 ++++++++++++
>  tools/testing/selftests/sched_ext/dsq_stats.c | 147 +++++++++++++++++
>  6 files changed, 427 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/sched_ext/dsq_stats.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/dsq_stats.c
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index bcb962d5ee7d..b79bedc26388 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/llist.h>
>  #include <linux/rhashtable-types.h>
> +#include <linux/atomic.h>
>  
>  enum scx_public_consts {
>  	SCX_OPS_NAME_LEN	= 128,
> @@ -79,6 +80,11 @@ struct scx_dispatch_q {
>  	struct rhash_head	hash_node;
>  	struct llist_node	free_node;
>  	struct rcu_head		rcu;
> +
> +	/* Statistics fields */
> +	atomic64_t		enqueue_count;
> +	atomic64_t		dequeue_count;
> +	atomic_t		peak_nr;
>  };
>  
>  /* scx_entity.flags */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 136b01950a62..a025d68acdef 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -972,8 +972,20 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
>  
>  static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
>  {
> +	u32 new_nr;
> +
>  	/* scx_bpf_dsq_nr_queued() reads ->nr without locking, use WRITE_ONCE() */
> -	WRITE_ONCE(dsq->nr, dsq->nr + delta);
> +	new_nr = dsq->nr + delta;
> +	WRITE_ONCE(dsq->nr, new_nr);
> +
> +	/* Update peak queue length */
> +	if (delta > 0) {
> +
> +		u32 peak = atomic_read(&dsq->peak_nr);
> +
> +		if (new_nr > peak)
> +			atomic_set(&dsq->peak_nr, new_nr);
> +	}
>  }
>  
>  static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
> @@ -1099,6 +1111,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  	p->scx.dsq_seq = dsq->seq;
>  
>  	dsq_mod_nr(dsq, 1);
> +	atomic64_inc(&dsq->enqueue_count);  /* Increment enqueue count */
>  	p->scx.dsq = dsq;
>  
>  	/*
> @@ -1136,6 +1149,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
>  
>  	list_del_init(&p->scx.dsq_list.node);
>  	dsq_mod_nr(dsq, -1);
> +	atomic64_inc(&dsq->dequeue_count);  /* Increment dequeue count */
>  
>  	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
>  		struct task_struct *first_task;
> @@ -3396,6 +3410,11 @@ static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
>  	raw_spin_lock_init(&dsq->lock);
>  	INIT_LIST_HEAD(&dsq->list);
>  	dsq->id = dsq_id;
> +
> +	/* Initialize statistics */
> +	atomic64_set(&dsq->enqueue_count, 0);
> +	atomic64_set(&dsq->dequeue_count, 0);
> +	atomic_set(&dsq->peak_nr, 0);
>  }
>  
>  static void free_dsq_irq_workfn(struct irq_work *irq_work)
> @@ -6476,6 +6495,138 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id)
>  	return ret;
>  }
>  
> +/**
> + * scx_bpf_dsq_enqueue_count - Return the total number of enqueued tasks
> + * @dsq_id: id of the DSQ
> + *
> + * Return the total number of tasks that have been enqueued to the DSQ
> + * matching @dsq_id. If not found, -%ENOENT is returned.
> + */
> +__bpf_kfunc s64 scx_bpf_dsq_enqueue_count(u64 dsq_id)
> +{
> +	struct scx_sched *sch;
> +	struct scx_dispatch_q *dsq;
> +	s64 ret;
> +
> +	preempt_disable();
> +
> +	sch = rcu_dereference_sched(scx_root);
> +	if (unlikely(!sch)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (dsq_id == SCX_DSQ_LOCAL) {
> +		ret = atomic64_read(&this_rq()->scx.local_dsq.enqueue_count);
> +		goto out;
> +	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
> +		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
> +
> +		if (ops_cpu_valid(sch, cpu, NULL)) {
> +			ret = atomic64_read(&cpu_rq(cpu)->scx.local_dsq.enqueue_count);
> +			goto out;
> +		}
> +	} else {
> +		dsq = find_user_dsq(sch, dsq_id);
> +		if (dsq) {
> +			ret = atomic64_read(&dsq->enqueue_count);
> +			goto out;
> +		}
> +	}
> +	ret = -ENOENT;
> +out:
> +	preempt_enable();
> +	return ret;
> +}
> +
> +/**
> + * scx_bpf_dsq_dequeue_count - Return the total number of dequeued tasks
> + * @dsq_id: id of the DSQ
> + *
> + * Return the total number of tasks that have been dequeued from the DSQ
> + * matching @dsq_id. If not found, -%ENOENT is returned.
> + */
> +__bpf_kfunc s64 scx_bpf_dsq_dequeue_count(u64 dsq_id)
> +{
> +	struct scx_sched *sch;
> +	struct scx_dispatch_q *dsq;
> +	s64 ret;
> +
> +	preempt_disable();
> +
> +	sch = rcu_dereference_sched(scx_root);
> +	if (unlikely(!sch)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (dsq_id == SCX_DSQ_LOCAL) {
> +		ret = atomic64_read(&this_rq()->scx.local_dsq.dequeue_count);
> +		goto out;
> +	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
> +		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
> +
> +		if (ops_cpu_valid(sch, cpu, NULL)) {
> +			ret = atomic64_read(&cpu_rq(cpu)->scx.local_dsq.dequeue_count);
> +			goto out;
> +		}
> +	} else {
> +		dsq = find_user_dsq(sch, dsq_id);
> +		if (dsq) {
> +			ret = atomic64_read(&dsq->dequeue_count);
> +			goto out;
> +		}
> +	}
> +	ret = -ENOENT;
> +out:
> +	preempt_enable();
> +	return ret;
> +}
> +
> +/**
> + * scx_bpf_dsq_peak_nr - Return the peak number of queued tasks
> + * @dsq_id: id of the DSQ
> + *
> + * Return the peak number of tasks that have been simultaneously queued in
> + * the DSQ matching @dsq_id. If not found, -%ENOENT is returned.
> + */
> +__bpf_kfunc s32 scx_bpf_dsq_peak_nr(u64 dsq_id)
> +{
> +	struct scx_sched *sch;
> +	struct scx_dispatch_q *dsq;
> +	s32 ret;
> +
> +	preempt_disable();
> +
> +	sch = rcu_dereference_sched(scx_root);
> +	if (unlikely(!sch)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (dsq_id == SCX_DSQ_LOCAL) {
> +		ret = atomic_read(&this_rq()->scx.local_dsq.peak_nr);
> +		goto out;
> +	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
> +		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
> +
> +		if (ops_cpu_valid(sch, cpu, NULL)) {
> +			ret = atomic_read(&cpu_rq(cpu)->scx.local_dsq.peak_nr);
> +			goto out;
> +		}
> +	} else {
> +		dsq = find_user_dsq(sch, dsq_id);
> +		if (dsq) {
> +			ret = atomic_read(&dsq->peak_nr);
> +			goto out;
> +		}
> +	}
> +	ret = -ENOENT;
> +out:
> +	preempt_enable();
> +	return ret;
> +}
> +
>  /**
>   * scx_bpf_destroy_dsq - Destroy a custom DSQ
>   * @dsq_id: DSQ to destroy
> @@ -7221,6 +7372,9 @@ BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
>  BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_enqueue_count)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_dequeue_count)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_peak_nr)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index f2969c3061a7..8222ef8055df 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -375,6 +375,23 @@ static inline void scx_bpf_reenqueue_local(void)
>  		scx_bpf_reenqueue_local___v1();
>  }
>  
> +/*
> + * v6.20: Add DSQ statistics functions.
> + *
> + * Preserve the following macros until v6.22.
> + */
> +#define __COMPAT_scx_bpf_dsq_enqueue_count(dsq_id)		\
> +	(bpf_ksym_exists(scx_bpf_dsq_enqueue_count) ?		\
> +	 scx_bpf_dsq_enqueue_count(dsq_id) : -ENOENT)
> +
> +#define __COMPAT_scx_bpf_dsq_dequeue_count(dsq_id)		\
> +	(bpf_ksym_exists(scx_bpf_dsq_dequeue_count) ?		\
> +	 scx_bpf_dsq_dequeue_count(dsq_id) : -ENOENT)
> +
> +#define __COMPAT_scx_bpf_dsq_peak_nr(dsq_id)			\
> +	(bpf_ksym_exists(scx_bpf_dsq_peak_nr) ?			\
> +	 scx_bpf_dsq_peak_nr(dsq_id) : -ENOENT)
> +
>  /*
>   * Define sched_ext_ops. This may be expanded to define multiple variants for
>   * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> index 5fe45f9c5f8f..546534159d74 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
>  
>  auto-test-targets :=			\
>  	create_dsq			\
> +	dsq_stats			\
>  	enq_last_no_enq_fails		\
>  	ddsp_bogus_dsq_fail		\
>  	ddsp_vtimelocal_fail		\
> diff --git a/tools/testing/selftests/sched_ext/dsq_stats.bpf.c b/tools/testing/selftests/sched_ext/dsq_stats.bpf.c
> new file mode 100644
> index 000000000000..bd3f8ac78456
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dsq_stats.bpf.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A BPF program for testing DSQ statistics functionality.
> + *
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> + */
> +
> +#include <scx/common.bpf.h>
> +#include <scx/compat.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +UEI_DEFINE(uei); /* Error handling */
> +
> +#define TEST_DSQ_ID 1234
> +
> +/* Test variables to store results */
> +s64 test_enqueue_count = -1;
> +s64 test_dequeue_count = -1;
> +s32 test_peak_nr = -1;
> +s32 current_nr = -1;
> +
> +/* Test completion flag */
> +int test_completed;
> +
> +/* Test task */
> +int test_pid = -1;
> +
> +static void test_dsq_stats(void)
> +{
> +	s64 enqueue_count, dequeue_count;
> +	s32 peak_nr, nr;
> +
> +	/* Test the new statistics functions */
> +	enqueue_count = __COMPAT_scx_bpf_dsq_enqueue_count(TEST_DSQ_ID);
> +	dequeue_count = __COMPAT_scx_bpf_dsq_dequeue_count(TEST_DSQ_ID);
> +	peak_nr = __COMPAT_scx_bpf_dsq_peak_nr(TEST_DSQ_ID);
> +	nr = scx_bpf_dsq_nr_queued(TEST_DSQ_ID);
> +
> +	/* Store results */
> +	test_enqueue_count = enqueue_count;
> +	test_dequeue_count = dequeue_count;
> +	test_peak_nr = peak_nr;
> +	current_nr = nr;
> +
> +	test_completed = 1;
> +}
> +
> +void BPF_STRUCT_OPS(dsq_stats_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	/* Create DSQ on first task */
> +	if (test_pid == -1) {
> +		test_pid = p->pid;
> +
> +		/* Create test DSQ */
> +		if (scx_bpf_create_dsq(TEST_DSQ_ID, -1)) {
> +			bpf_printk("Failed to create test DSQ\n");
> +			return;
> +		}
> +
> +		/* Insert task into DSQ to test statistics */
> +		scx_bpf_dsq_insert(p, TEST_DSQ_ID, 0, enq_flags);
> +	}
> +}
> +
> +void BPF_STRUCT_OPS(dsq_stats_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	/* Run test if not completed */
> +	if (!test_completed && test_pid != -1) {
> +		test_dsq_stats();
> +
> +		/* Consume the task to complete the test */
> +		scx_bpf_dsq_move_to_local(TEST_DSQ_ID);
> +	}
> +}
> +
> +s32 BPF_STRUCT_OPS_SLEEPABLE(dsq_stats_init)
> +{
> +	/* Initialize test variables */
> +	test_pid = -1;
> +	test_completed = 0;
> +
> +	return 0;
> +}
> +
> +void BPF_STRUCT_OPS(dsq_stats_exit, struct scx_exit_info *ei)
> +{
> +	/* Destroy test DSQ */
> +	scx_bpf_destroy_dsq(TEST_DSQ_ID);
> +
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SEC(".struct_ops.link")
> +struct sched_ext_ops dsq_stats_ops = {
> +	.enqueue = (void *)dsq_stats_enqueue,
> +	.dispatch = (void *)dsq_stats_dispatch,
> +	.init = (void *)dsq_stats_init,
> +	.exit = (void *)dsq_stats_exit,
> +	.name = "dsq_stats",
> +};
> diff --git a/tools/testing/selftests/sched_ext/dsq_stats.c b/tools/testing/selftests/sched_ext/dsq_stats.c
> new file mode 100644
> index 000000000000..b54912a0d2ca
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dsq_stats.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test for DSQ statistics functionality.
> + *
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> + */
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +#include <string.h>
> +#include <sched.h>
> +#include "dsq_stats.bpf.skel.h"
> +#include "scx_test.h"
> +
> +#define NUM_WORKERS 2
> +
> +static bool workload_running = true;
> +static pthread_t workload_threads[NUM_WORKERS];
> +
> +/**
> + * Background workload thread that exercises the scheduler to trigger
> + * DSQ operations and statistics collection.
> + */
> +static void *workload_thread_fn(void *arg)
> +{
> +	while (workload_running) {
> +		/* Sleep for a very short time to trigger scheduler activity */
> +		usleep(1000); /* 1ms sleep */
> +		/* Yield to ensure we go through the scheduler */
> +		sched_yield();
> +	}
> +	return NULL;
> +}
> +
> +static enum scx_test_status setup(void **ctx)
> +{
> +	struct dsq_stats *skel;
> +	int i, ret;
> +
> +	skel = dsq_stats__open();
> +	SCX_FAIL_IF(!skel, "Failed to open");
> +
> +	SCX_ENUM_INIT(skel);
> +	SCX_FAIL_IF(dsq_stats__load(skel), "Failed to load skel");
> +
> +	/* Start background workload threads */
> +	for (i = 0; i < NUM_WORKERS; i++) {
> +		ret = pthread_create(&workload_threads[i], NULL, workload_thread_fn, NULL);
> +		SCX_FAIL_IF(ret, "Failed to create workload thread %d", i);
> +	}
> +
> +	*ctx = skel;
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static enum scx_test_status run(void *ctx)
> +{
> +	struct dsq_stats *skel = ctx;
> +	struct bpf_link *link;
> +	int duration = 2; /* Run test for 2 seconds */
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.dsq_stats_ops);
> +	SCX_FAIL_IF(!link, "Failed to attach scheduler");
> +
> +	/* Let the scheduler run for a while to collect statistics */
> +	sleep(duration);
> +
> +	workload_running = false;
> +
> +	bpf_link__destroy(link);
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static enum scx_test_status check_results(void *ctx)
> +{
> +	struct dsq_stats *skel = ctx;
> +
> +	/* Wait for test to complete */
> +	int timeout = 50; /* 5 seconds timeout */
> +
> +	while (!skel->bss->test_completed && timeout > 0) {
> +		usleep(100000); /* 100ms */
> +		timeout--;
> +	}
> +
> +	SCX_FAIL_IF(timeout <= 0, "Test timed out waiting for completion");
> +
> +	/* Check that statistics were collected */
> +	SCX_FAIL_IF(skel->bss->test_enqueue_count < 0,
> +		   "Enqueue count not collected: %lld",
> +		   (long long)skel->bss->test_enqueue_count);
> +
> +	SCX_FAIL_IF(skel->bss->test_dequeue_count < 0,
> +		   "Dequeue count not collected: %lld",
> +		   (long long)skel->bss->test_dequeue_count);
> +
> +	SCX_FAIL_IF(skel->bss->test_peak_nr < 0,
> +		   "Peak NR not collected: %d",
> +		   skel->bss->test_peak_nr);
> +
> +	/* Basic sanity checks */
> +	SCX_FAIL_IF(skel->bss->test_enqueue_count != skel->bss->test_dequeue_count,
> +		   "Enqueue count (%lld) != Dequeue count (%lld)",
> +		   (long long)skel->bss->test_enqueue_count,
> +		   (long long)skel->bss->test_dequeue_count);
> +
> +	SCX_FAIL_IF(skel->bss->test_peak_nr < skel->bss->current_nr,
> +		   "Peak NR (%d) < Current NR (%d)",
> +		   skel->bss->test_peak_nr, skel->bss->current_nr);
> +
> +	bpf_printk("DSQ Stats Test Results:\n");
> +	bpf_printk("  Enqueue Count: %lld\n", (long long)skel->bss->test_enqueue_count);
> +	bpf_printk("  Dequeue Count: %lld\n", (long long)skel->bss->test_dequeue_count);
> +	bpf_printk("  Peak NR: %d\n", skel->bss->test_peak_nr);
> +	bpf_printk("  Current NR: %d\n", skel->bss->current_nr);
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static void cleanup(void *ctx)
> +{
> +	struct dsq_stats *skel = ctx;
> +	int i;
> +
> +	/* Stop workload threads */
> +	workload_running = false;
> +	for (i = 0; i < NUM_WORKERS; i++) {
> +		if (workload_threads[i])
> +			pthread_join(workload_threads[i], NULL);
> +	}
> +
> +	dsq_stats__destroy(skel);
> +}
> +
> +struct scx_test dsq_stats = {
> +	.name = "dsq_stats",
> +	.description = "Test DSQ statistics functionality",
> +	.setup = setup,
> +	.run = run,
> +	.check_results = check_results,
> +	.cleanup = cleanup,
> +};
> +REGISTER_SCX_TEST(&dsq_stats)
> -- 
> 2.43.0
> 
