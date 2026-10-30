Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793340713;
	b=bwR1rUigYnFm7a7TwMwKWrbubgHKniLgWIPeNbKPOjkL9+MZofLm+R02h4O0KM4PrwD/
	 FI1Ica1Gr0rgQsGpjoyPQNb7ly2N4kPsBH6SZNS/AHg0YL2lJ+7B19Dktt57trKqfKfS6
	 jMTo69OOk/YjRltZG5whYwBmJ+wLw5DEAenSkkpS79GwgQE4rPk2/KeosH9mu5QrpYaIl
	 Ry/NXauJ1Yi3FjKI/HgFKj+H/ZO0qwr220M6n4+lPDGuMSujTuu2Aj+cxrFboRpsz3J8z
	 HfJ1U/ctk7x6hQOd8aYt7ptCE+arVjckgG+yenKM4IqF4/9mpqwIQ+g3zoBYLoYDW8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340713;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2IrSp4UnAzmjBcpX5+4melajkIl5rFWC1mh+sotSw70=;
	b=pL0tABy+5xLvgU759YTSfDJPOrkvaKeCtuCFnFOftPZOnzSS+maiD/zpSr8w/KqXlFcz
	 gykEegLoV4dhF9JM7iUEVhcvZ3aR5Ykpez4szzpmfQd09HPcvOl73b7SP8RVwpwQm5HAe
	 gqjvY9QBkIVB4v0orX6oTXWuCqtSN1gjgqtXFv9P7I0bhnU22yXKb+5D8Pjn5q4VCUsGb
	 HkSpns6Rs8Mogj3zKbvTFbwA2Sc9C/yd+bnxGVhtZQ3D/Xz8PrTgF+aRi1A7bfMcAv0oL
	 kJQaGvaOdw6POpFiyK4BWgbmOO11ySkvni9htgZyln5/wyyCExeW3/LYrv6Tm7nzsqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Cb32rxVH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.49
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64571606A324
	for <sched-ext@lists.linux.dev>; Fri, 30 Oct 2026 06:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64571606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Cb32rxVH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqMiHJBtoKRqPiy8gE2Sr2nZzKRQy0K1kNgngZnpvr17bcL9kmyoRTRPHLwum6uJ9yPI+IxJDQHBRbGohuDBFLUf1882LL9y9a+mDcCoBrdQ7Xc5yYKpMMHn+fj4kGqN5X/Ob8mwDyhz/YUqsIb/LaZraKgbvQLCEmjKwHeW8AjzxqKOWIEyugJYx6mM7G72kJgZWrNMiXJTodvwTeXnF9SI4zxRR8ZPDQDkYgYFxtjbISvYu4sv0k+tA3QzLEo2kDvz6JcOg6MxTUZNjmLFsGM6CA/kNrN/bSMYfVewHNL2/nwD+PJeZ1J6ifxGyG9ctS+L2/Sc8otGEIPu1o4zPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IrSp4UnAzmjBcpX5+4melajkIl5rFWC1mh+sotSw70=;
 b=LVpOypBSUAHop+3s88J4oq7rAkOyDcjUcTH4D/I3hfkH2DTzdB+klXRLnTxFJI/Uj6UjTRkSv99IwlO8Rq0G4+WA6g5MwPabspO0ZAzKxk7tcgPKkC4NRLQ7gTxP8vBwVNJ2jpNMXQrl8diSG3XVf8u4D7kc9MlpzB/YcHYIbUEMRXl80To58rNLqc7mHVr/M6U9o0jHGTH/3iICVP5bDsrePROYTpOxCGaO34byvBv0prFpbxbZ3HMF2zl88Ee6SRw5IxVcGdlatwj5Bdtjedzsc9pxxw2TYbEjv9tDWnqhHFrGAJ9J2eZs0vja8KfLbJMjdqoP926aW2BGxD8SAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IrSp4UnAzmjBcpX5+4melajkIl5rFWC1mh+sotSw70=;
 b=Cb32rxVHV3DZ9YizrJXemZsQnEnZqxuOElKxTav0Zj9KQP5gtj09IHA1XHtmE50INhNUuK9UhriLTPb9Xa3wK70KHYloFE1dhtx9sQGe/OPdm1TVtIWWdPvSNa9a/A1M1SmVoa9RpUD2jRRyfY1Y/FoU7OamzFT2Baih64xmglkUo4jMPYPnEGdq50mlVoYBhy/w8khVtBuhOhJiI/Sv3WGBc+xyth2QiBTPKrwOS0dYaIVnFCLHaKM5YITis+eKwZMWZiSYTl6s9AT41MCVxYqU1NQWy8ByTCdZNb4RST6J66hu/WOC+AR3MKI4UHiAozQp0WYuE3nqLIN5YvFtdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 06:11:47 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 06:11:47 +0000
Date: Fri, 30 Oct 2026 07:11:35 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix
 scx_bpf_dsq_reenq() kerneldoc claiming NMI calls are allowed
Message-ID: <auQ1F9VjDeROkSEq@gpd4>
References: <20261029235251.3235814-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029235251.3235814-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a5d83b-b35c-4fcd-f2f5-08df364cadbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|261021123027099003|56012099006|11063799006|5023799004|261009223027099003|261021121427099003|261022075727099003|22082099003|261026121527099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rd9cjMhAaL7scjOkXtuwbQIu1QnUMMmHc9pAwEpd5h2PSjrFlM1ubEYjXRNcnGpjIKwPKLBzv3qpKica/T5Pj/9C7HqpIYMTlWHKFchNf6GzsiStPidtPy4DyJyHwr6f7Qfq5vx3lBw+RrUUiO3cJKyOUuEA9GO2FzFbPLMqPx5CmAEGtURoOT9pRL6GeSQO+wedRZ/MuXeYSZkVobuOjyAT9IuWpll7Elj3mREVepSLf7VMP5y+vMiRWXyhI4z2FESMNoJN2h0Hcy8XsF5/qURop6eoJgNoneGthZt9Stdn8sv8kQOW5+qCbAbT9XIvZnrDNptww/+8vABr1XXzM6WAeSQOdxeCgkpbcW7Hc+yLOg12pHaL+U2mOjGB3BwWIRDHO9Tx64UiPNHd1L/GYVXlMICsuCX4SqaYVnHuSSnMv3sC3RkhT5PNvnG1w3ffXIDjfueNX1S1O2+T0AjM7nvHC08TCkz4QKVTowk+iASwZIZyp7V6n7J0UqX9eQxXcJOTqtE3dwlLsphWvX1iH47f2zKCakVHUVFVw4rZfhhTH+k8XO9X6SjYxBBE4TIzdk34TqFvgiTIW8Sb5o7QyU9qI3WRKFfV+coVZ6Zi/RcXDFVqrsipCfA/miBSGKlfthgzwTxgkS+fPCAVsI03rY8XHKfwVQVHfVjIEHgBvag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261021123027099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261021121427099003)(261022075727099003)(22082099003)(261026121527099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8HwmHJG96I3JMTOKZ0vQ5TsBSJGdHGg//kAzVEvsMqcrkBbaFG5jI6pcNjJ/?=
 =?us-ascii?Q?IUCy2yF0nZV+Ua0N+wXis8VR7RFJFiHchUw8L4LmylxbRmds9LIjg9v3eLfx?=
 =?us-ascii?Q?W010IoyOnCcBkD5Y2Yyf70XWmYxMBsbGwka45mAfMIjx61+Pf0lLd+nGWX7k?=
 =?us-ascii?Q?tTTZGW9TtT3KE2RsKzsL2NVtEk+WXnvXoTSqPY9Ar87O8MFCRCQn863QXean?=
 =?us-ascii?Q?RcfIC8WCnFmSV1kFuIXNSBdSP6uq1RdYF5Yg9YpHEMb90cirw/1hC/mOAdFC?=
 =?us-ascii?Q?HMEsl9OcY4c3o7QoVe23Uida3k1Il1o3m2GzH9izAX2QbFUwTqY+S4XqOZDZ?=
 =?us-ascii?Q?1KW6x+qmb66AITJLUTgS0NVss22gtRIzuh39E7OfXa1mMXBJCBMlfMzQlTT2?=
 =?us-ascii?Q?rYnEou4QQen1tGCZJJW5iJ1Vgbz/A5vNfkB+DmQzG8nUetakH3muvKBWOIfA?=
 =?us-ascii?Q?f1k4HiNjoHSL9aelJMF9m2v8Fb5XNKmlUdA28KhhiSjQbbAWxg5j4hwkHXvx?=
 =?us-ascii?Q?03tBKWs23PPevKBL915KVF1oMVOw2pPlOwpFR9kH+qXCCdab0voYOS3QLkTX?=
 =?us-ascii?Q?9Eh4yqWU4Fp8zmi2I29wr/zhQaWD5iLgw/eyC8BRu6KLAjRdVAxIOl5D5CAk?=
 =?us-ascii?Q?1nfkXX+2iJk2lWIsRPc2uwJ4AMVC9+zAlU/mEwTqrOpDUOewu3ZYWuwFJ4hf?=
 =?us-ascii?Q?TdkPfUgl7pxRL71v1RWmADllhz4gn0QDC89oJ1oPdLrXky+n1issr5+nfK55?=
 =?us-ascii?Q?S2egzVjbr9UTKZReJJ+23CGCu+zC6dMJ7wbDtnTjwoNwOeCM9TXTbY6gDvUD?=
 =?us-ascii?Q?lWLeelfFUjC8zmsw69slTNn5tZh5t8gb/o3ovI1qxFJOEIcweZqS8sa9qhwt?=
 =?us-ascii?Q?LYJejQweiuSi4y7Q2rXkacRm/xSsyIlfcAk9MPeEkS8zqClUlrTjlDmZHbk+?=
 =?us-ascii?Q?HtUnv+0OOx06UKvHtHKj9cgjFTrtnVD+LfcUHtiC12mvEQKiyMwwKTKrntCJ?=
 =?us-ascii?Q?FHgVOolD++RKBF0jZoba1kbbgCDMQ6Ez3YR+R2a3lB7PwEedgANjOMIhsEXf?=
 =?us-ascii?Q?HVsbETBCLwiQ3FB61ktcGWMuuxUOoOwXzF1JdBBANuDOS02Re/0XakKgRDkk?=
 =?us-ascii?Q?pV/UePqIFXdooDGtu5JrWYViXcqojRrU975nxJckpCMhKI2tNTETbOhaRTC/?=
 =?us-ascii?Q?Oyfc93hIa4qgh6L1/xtBtQ8Dchs9Hrly0meYcvdSfr+SzMy0KiuRo0O56yGc?=
 =?us-ascii?Q?OV7aMA8/UPbEjgwmFs5LXkT4OYIe27ESodnUvbMDTrn99ZRL/h/pXfcaG3dC?=
 =?us-ascii?Q?mwe+//7kIvNzECST5N+dmpA49XzQswAroBpycTrkurvIA3vEcYcm9jgLYXWP?=
 =?us-ascii?Q?01JlbJvZElWjxinGyRiMYMNttH4KxpkcESlSdB6+ZOE52jRxH9Ixy11WbM8C?=
 =?us-ascii?Q?7BJngzN6gt78GUoOFrAkkM/pgOIGzQj+bV59WgBvuDhxbVMyXQoY5qklb5d+?=
 =?us-ascii?Q?5nfcPfmn0H7tPSpFzm1dCtSRLVe1EULS58BzaD/ugFiPGugitfoWne7zTqFJ?=
 =?us-ascii?Q?7m490LZlrmI8YWHFzOjVmd0vLdRqvv/mD8eEi/S9iKfmN6Ats7q7odLbPxGu?=
 =?us-ascii?Q?3gYNFsL3OG8jlSdMpC5O95ZMrostHjxowont/panGvS0/8yy2L9Q1ZDKpYHi?=
 =?us-ascii?Q?ReZwNc5w4uzrN8vIaoEiGsas1+sdfA6i6vAWD6hefOQfpnkN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a5d83b-b35c-4fcd-f2f5-08df364cadbb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:11:47.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIa7B2fUrHQOWayemymMwqkAhmPo0GdvLhnLASXJ2Xp6NzPIgZTYnIY+3eRJt5cPFA49yY2M3oKSjY95lTDZ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

On Thu, Oct 29, 2026 at 01:52:51PM -1000, Tejun Heo wrote:
> c659e506f9a7 ("sched_ext: Reject NMI calls to lock-taking kfuncs") made
> scx_bpf_dsq_reenq() abort the scheduler when called from NMI. The kerneldocs
> of scx_bpf_dsq_reenq() and of its wrapper scx_bpf_reenqueue_local___v2()
> still say the kfuncs can be called from anywhere. Update both to exclude
> NMI.
> 
> While at it, fix the wrapper's kerneldoc, which says it re-enqueues the
> calling CPU's local DSQ rather than the one SCX_DSQ_LOCAL resolves to, and
> the SCX_RENQ_* typo in the scx_bpf_dsq_reenq() kerneldoc.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 15123f181b5b..cd923f9f1f2a 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -11115,7 +11115,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
>  /**
>   * scx_bpf_dsq_reenq - Re-enqueue tasks on a DSQ
>   * @dsq_id: DSQ to re-enqueue
> - * @reenq_flags: %SCX_RENQ_*
> + * @reenq_flags: %SCX_REENQ_*
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
>   *
>   * Iterate over all of the tasks currently enqueued on the DSQ identified by
> @@ -11125,8 +11125,9 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
>   * - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON | $cpu)
>   * - User DSQs
>   *
> - * Re-enqueues are performed asynchronously. Can be called from anywhere. A
> - * re-enqueue of an inactive cpu's local DSQ is ignored.
> + * Re-enqueues are performed asynchronously. Can be called from any context
> + * except NMI. A call from NMI aborts the scheduler. A re-enqueue of an inactive
> + * cpu's local DSQ is ignored.
>   *
>   * %SCX_DSQ_LOCAL resolves to the local DSQ of the rq the current scheduler
>   * operation is locked to - e.g. the rq being dispatched for in ops.dispatch() -
> @@ -11223,9 +11224,10 @@ __bpf_kfunc bool scx_bpf_dsq_reenq_task(struct bpf_iter_scx_dsq *it__iter,
>   * scx_bpf_reenqueue_local___v2 - Re-enqueue tasks on a local DSQ
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
>   *
> - * Iterate over all of the tasks currently enqueued on the local DSQ of the
> - * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called from
> - * anywhere.
> + * Iterate over all of the tasks currently enqueued on the local DSQ of the rq
> + * the current scheduler operation is locked to, or the calling CPU's when no rq
> + * is locked, and re-enqueue them in the BPF scheduler. Can be called from any
> + * context except NMI. A call from NMI aborts the scheduler.
>   *
>   * This is now a special case of scx_bpf_dsq_reenq() and may be removed in the
>   * future.
> -- 
> 2.56.0
> 
