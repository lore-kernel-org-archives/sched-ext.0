Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792561048;
	b=GJeUnsEKVVDom9eHJGvm/gIpsaAXqSjbRlh4Pium7OhDFHPz+K5AgNnFREczp1t4Zwut
	 Ma/ETGgkvTMabVkhTJtvG2cFzl9LQtLbDHEJ/RPZDpHWCPxUyUs6xdt4qubof/xQotwo3
	 JIyRz5DnRbbIqZTlMPvEnSbR/bn3TBS8yO+fh9VlgbvIsU47kaJN0sr0agR4Ie1my+NtP
	 ZzAeGSgzvC4NL/SDeBc1fGJlqrZaZ/kETY7t6pBg22BXqYRoxZJ9r77Gf+CR4BbB32dZp
	 NCQRVxq/9phIEkA97iS3GBnCBHQ+CpFgbojwscFruJVQ9E0Sqw2ZGSzj4nQ3d8EGgaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561048;
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
	bh=5R9xsYQE2XORaWaE5QrkTBJVP9i4XJl1iKOTfXJ5mk4=;
	b=1OQu0KKX9Mum7XfiE/O5hu4vzruAwfpM279MBRKLlWVMUGZLVEJwoaDPkj5WUJfL+4+v
	 vurDibVLc4sZrbd0MpxRBjdnI4UuqSGl0TPdZoQZC5blu6yOTADRyuMm6J+4ryXu9dyX+
	 CKPWjEF8P1+mpf8iv+qwpBwc8fg3irVmCE3H3iQBBFWJdROu7XB6k5AZdwXylktbgqowa
	 U6DArcn9oqM3frXpODVceTjegNB+WWeD6duLMhc+u/JQiawVDJaZoZAsHvVmyn+xwIupF
	 h681W0rZUbw3xWSdokVa2FTzlqRYsk7QiYpxQOLx0/eL3tNf+nONx9tI1koGS2SCxrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fokizz3s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.6
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19F606A319
	for <sched-ext@lists.linux.dev>; Wed, 21 Oct 2026 05:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A19F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fokizz3s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA4VEeBsyATqsjxwUiwL8QYkR1c8JdkKeVW1ULwht1TZ8nce5lcn9zmN/0zXsmMNnltO4FwoC2TM8qo7eTeDKG8dTHmI2q+VK9n0v13dpsRC0ajyfr4FqJLgsXZ2MfB6V6nYwmsIlFb+S/pJ1ed+IA0b5QsB5icSJu8WNzpF/nzSR+q41N8gZ1AUOtBMbI6daA1t9y5woUELlBZyuQf+C8jadiMSh5Lo8U94PMJybr7IE1WDD6RUywNZ3HiCIME5g9zJ5cOdsiqUEvWeRuS66rlD1vwS78lnkHqU+AfQ+NUqWKXZXHY3MDbR0zKoYE0QTZ9GnVdIRmkh/yJpCIdmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5R9xsYQE2XORaWaE5QrkTBJVP9i4XJl1iKOTfXJ5mk4=;
 b=gea0BLH6NmoY/aSpDsOuV/HISVEiLIWPJcqscT9GVQkKWcpn9M0u8WNnxrvGbOeev+9dYbh/ksIdmOFAvChn/Ukx6wlnI9wqKH9Xttl+/Of/50VaiQshINJn9WmOs1RUi+Gw9dEX3Lz6us6QLosN/jezMaDQ/T/MPT45X5BAl/Op2zM014wED3H1oVCEhn+iqLYOd2NOz5IVlEOp01xPZhqAuVdYwQdVkMLZTo+YDL5B8bcYwur1ihqfk3AU/rmtDV76TJM9Si7CV+Qo0p+NdoqWt5TbFMFlvBTiS7KTI+IBKkXGW/dnvDkD81BbeY2OKb7MZcGudKit5PEnZNGQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R9xsYQE2XORaWaE5QrkTBJVP9i4XJl1iKOTfXJ5mk4=;
 b=fokizz3sROtVrTcgvca0ACeV1Gs00YZcKdDU0oT6yTBWQMcgJ4641TJCH/O14wOr929nCjkfslJg+l2Wh9QZ2562wkU9SHst3mXjirlwLJlZaXoosKDFUzpt4lc/ikvsfD19Bmix57Ca0x3/Y/ZUmsc6XZPp0/0OIZFVlWgM284oIumGPU70b/xBZOSFATPNy6NC10KeJZKs5StE5Jyu3+dEAgKlXh/GTp6V3QYKULsi4HLrwHUqvou+kxA6EyxwSt4jhi1iXK2XoceCskxadmOohuGiMYJwCaG22a3GaiHkaPn4irYM2CzoPsz4TCNa+2xnrD53pAhhkc4c2w45vQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 05:37:25 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 05:37:25 +0000
Date: Wed, 21 Oct 2026 07:37:16 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/core: Avoid requeueing a singleton balance
 callback
Message-ID: <athPjBvCLvIILiKL@gpd4>
References: <20261020084400.845842-1-arighi@nvidia.com>
 <20261020084400.845842-2-arighi@nvidia.com>
 <61d3176fb616261d1571449114fd9f67@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d3176fb616261d1571449114fd9f67@kernel.org>
X-ClientProxiedBy: ZR0P278CA0157.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::22) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0095f16c-9cb9-4b38-b823-08df2f3562df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o3v6MqmaLP+kfLU4tq/yDXQ2wakbkR0im7Xm7hE/1O3ovx2nD59rKWzAiHUGiIEsawopj9NKWHdv54tA5OtPGqOwV/dQ9o7I/Qz/A9anKLhulxvPAtnJTonjzhB5We5wDIxcuRaOyE5hyi/x7vACWEk9KUX/ES/TrSXE5q3zhyMFXahfNqqDOhSCKh8jGOxvsyi88KCdxHRWlfHe5VRRekfTj4hJGZILTGris4wslfkaTlTQ42KQapybeqeuPDErFyg5Dhe51xZM5yOBR2AtZUe7B4ypsGsabGZSuyKZR+kixz6M1OGcqWNEE+AErBBe7VGWUkEjr0LcWiq33SVZqiwVEYmLQyJatoz+QScW8VGNF9Mawo2QR2Cf9n0v1ue9Znhz3vXo2zMqqykjVkfv2ZZWcCs/ud5bGQACWxME1Jafe7NDwk1XMJho25aflrUO+SFvYUGAwmOwdscIXPiAZaBNG+jUkKWztPOJH6HfpVI6YiYDEtQIw5P+MLcUGXI3Cq/GQrHANbMfs+YfhRfX7g6D2hwTQWFvfEg9Njuk0g1st1ljlcVcDPQ63FLSJg7B3kIGLAPoe0aLzHp423RQNcy/zmATEZ93gofs3PxeJXMdLB7b+7Jox5qJlDcRckZh5+ce774nnQq+jHSBHnNPLKWw813wGxc1jwH8Ptw7JoE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ABu3SLQGMcWIagfAZTG+VnNlTgzbPsG3qeuPAICeSkElcc3jEb3RXdiOp+9T?=
 =?us-ascii?Q?u07w8MfXJzwjxsXndDtd7sCsJqgQp2urVQTd4RV20tUwxisx6bcZ45QZ6FbO?=
 =?us-ascii?Q?6CpLk0Rwl6FxZ8MztWvX3xrjiQz1a4sGzcHYjNmd4l7GtU5OKla4WXyiEHFt?=
 =?us-ascii?Q?bkjUmuELfxk4LSnB50cCkgAEM8fmT9i3lZDiSo5mhVNtnrbe8jtoooTGh40H?=
 =?us-ascii?Q?SWsMmkJp9uOCTFC04xOtHTLgCCuuLwMgZZrOiCF07Rjg1DCCP+HmjooIJJ9C?=
 =?us-ascii?Q?FMbLB+7RmjgNGiYjoqeNv4KNya7q97UVzzbIBWrPCys8gtnD6OhpHXi3fW60?=
 =?us-ascii?Q?4lbqZyAJqGhxlb2H01vz5Hr4Z7UOX3YTBDNBqw8RdNjXjY3NN4wL+nbWZ/QG?=
 =?us-ascii?Q?76oKGHfdp43/Brnlnd9HHVuzgqwmmrP6uMqlFd1bz2Ixcv4CayLi5clrUCoR?=
 =?us-ascii?Q?SKEvIU9vjxpFcLVvB+GkjZZDgjY/gm44OblIlgmeE/ycnmi+EYYtKjoq1EjK?=
 =?us-ascii?Q?wPNbyuuPgvLXVCdTs6Em/b2WopnIYcsBvEwkCyTpLV3JuOE7EGzM0366jZF3?=
 =?us-ascii?Q?ONBEdAfpv+VTDKf5SPmrLErtOHyxXECEmNDkzmgLb8XuURx2kV973O9VpTEo?=
 =?us-ascii?Q?EXJKG2iu5pBPEURqQUHwU0Bo86p6AXePAjTk8SSBvhQcYbyRgXH9C9hv0xYq?=
 =?us-ascii?Q?hNYCxarjwMDTZSrmBkUt0CF5f89rzlVDSaFUGDDrLeoC/YR2gdBAyg6jtJU4?=
 =?us-ascii?Q?2oGbQyv9iHU1KeLOvewkPTu2T3xdD7jLj2jEZyxnWSvwXm5SC+O8TRVsr/9j?=
 =?us-ascii?Q?Yb7x87f7S8dzmuaf1/0DuMjdvitfZILm7gEyN/5YRCOJEkOMUbZEArM2rkG9?=
 =?us-ascii?Q?+MrQ50URboaTVInkZ6+vJwVI2zOFCqlzMb+0a1K/WAI9LHw7+C1v5AgWQ0mk?=
 =?us-ascii?Q?bOSFOKrFqHhcxWjXpliXISqo5H4yjotCTjfifrOd3yVwWrrB4DxG6dopgLoq?=
 =?us-ascii?Q?2rcsEvX8doWLAO3iTEQZ/0n3mEz2k5QbF5LtB9d3R3lRIsfrVi2ZBfb8gN5c?=
 =?us-ascii?Q?fyNRzff6+mevkOjOGhIn+XTwfHUti5A4blNhfzNGG7iGog8v4BmF0UXNsfqV?=
 =?us-ascii?Q?aGiRlllwu5eiEikCUkHz9SX6hmlCDFr/Ddp9lsNrIw6sDDEZjVWS4cYda8py?=
 =?us-ascii?Q?pf+XyzZz2u6L66MYH3qVdl7qxtIVVy9zlcveqS/PMlFJzCxkQFv3DYYfjeEG?=
 =?us-ascii?Q?xLYSoP1Np95LrpCwHghGpL8X+L2AYlOnzSB9irZIwD/QDxp0YA/ofKnqyrHG?=
 =?us-ascii?Q?kz7eGryizCOhLxuW7K2evY9nafi7onOAM54bmTwFQvGUBsNgfQBfA6gIDTBP?=
 =?us-ascii?Q?U3vsu1Y9qJC6em80YtITj+zrgcr9CQhcfPGMGc9W/MlCGPwksZERwdkU/0sS?=
 =?us-ascii?Q?puwvVSzY372Ir5wCKdn4YdTBx9aaMIcCHojk8oGrurBQNmkvh6DB8whlxHkx?=
 =?us-ascii?Q?GSKNkJyadIep0jnHppsbJphKpzuf/2tyPMDi7q8vi8eedQCALE54xu3+/Jqt?=
 =?us-ascii?Q?ziM5RlXCEp6/QHpLVwOjWdxJai0Sgay16xGk0KO2Iu8ScVLqeV8+2h/2sNhn?=
 =?us-ascii?Q?ztBqEfBmPUiN+f2krGFT2k46LdsisKvJzVr58jAevf9oz8kWM2aGlAYWyaL+?=
 =?us-ascii?Q?0WYabiNZtvaZRsooUG1vGx6M+mYuPMNOMGtk2imoUikDZitD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0095f16c-9cb9-4b38-b823-08df2f3562df
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:37:24.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcuTgYnaEFJoqinyDsg2x+vMoUkdSJmbdkhc819MAFroObKiga9+GneLFYghkUnQdap3IWH0diQUqROh4UzSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385

Hi Tejun,

On Tue, Oct 20, 2026 at 08:20:25AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Tue, Oct 20, 2026 at 10:43:19AM +0200, Andrea Righi wrote:
> > When the callback is the only list entry, its next pointer is NULL, so
> > the existing duplicate check misses it. Queueing it again links it to
> > itself and causes the wait to run twice.
> 
> The last entry of a longer list has the same problem. Its next is NULL
> and it isn't rq->balance_callback, so it can be queued again:
> 
> 1. A is queued on an empty list. A->next is NULL.
> 2. B is queued. The list is B -> A.
> 3. A is queued again. A->next = B and the list becomes A -> B -> A.
> 
> do_balance_callbacks() then runs A twice. This doesn't affect
> kick_sync_bal_cb, as nothing gets queued between the SNT_REPICK and
> SNT_PICK calls.

Ah yes, thanks for pointing that out. Agreed, the head check only covers
the singleton case, but the tail-entry case remains.

I'll keep this fix scoped to the reported issue and address the
duplicate detection for a separate follow-up with Peter.

Thanks,
-Andrea
