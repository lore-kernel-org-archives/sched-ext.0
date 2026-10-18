Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F441E6B9
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792315198; cv=fail; b=puKkeVw2nlvBeRRVwuw8RH4dCcbxATbZlGtOKo0DVFRkEt2ry3/CmOED5rpSzPRLsPo6p1LVNlj1qO6iSivasz5OlpI/Ytb1EFt5JjRDiGZk985/mgmUhh7fv+HiNQShAD/vNfDom1LFndLRkYFlh5cWOD+onHyky5jfW52ATe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792315198; c=relaxed/simple;
	bh=I3nfEHrllnFZ9XHdR0BQ/0uZ2AIgZOOBHJCKY5LkTFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n81cpXZi2hUSNVmiSKEYFXb5lcbu/7LfIHkY7rMbs/9E7HQSTvvAJKeqw5lcnrtyMAaFx4c7taJL8l+aF6uKOIb9jQu0yOpvNkT6GdNAJQrI5AdIS8hb+ZwkBzRotoU9gzG3aKTDVKhU3GLDg7zbXvpWlPu4yZu06dUw3xTTTSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mZhcw4pN; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZhcw4pN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ6NEKhPSNBv8AlKd5NyxCeUD9m9D37lkqHcfBTUJUFTwUZW14aoHVZFY6IJS1CK6viXMkDsVLspm1a50/Ex3Ozl2IThnvUa+qbO+FFs+sbklV9oQgAhlcA+BnCwI/djUxcD9IG09I2Q1r/tw/UTMQkjMuGKOTACWcK+UGxdE01ig+xFI2pgg3+RCtltGeffG9iZY1s18zVZnwdCuF6xStjmAzV3yGWZTbG8OGWCy90oslpA+rh2IrEA7dSt7ALoiSsrM1YzSRRsmPgOkfbS6Fg9vNg50Y6zTEJiZ83Fx0tT9t3BJZiRcr2S3p1SoJWddRYnyTvIFvGB39H54SDh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmvcQJCKW/4yCVKyL2MVbITkfgcrIyk2P16k7wkqSYc=;
 b=X5LIPYGySQMyswaL1dpjkDnla0qVlAD3RHwnGc6mscqbJpJhsZB2ZHzpYSh/MSjo/P7NAhojIri0DW9IgczTGXufOAXMNSFxoXJRqvVwaIrfT7ptUIvIIN/E77auy74kXJJPGG+xgK7IMfYlq+zCpdrMq5IYZ9pkybfnC9aqcpSKgFvFiQ3w8G8pNB0KbiR7oS6B/afPYdgW2WgNACqFHrVniYmFEfmdr1UDXhSx3T8bSRvO6E6pl7mblLhulGLv1XgSNVtRwjrnIjo0ASMJt0FXIWc+i2WOr2Ruapi/gjltY3jE9NreV9n8onvYdK6OLfV36Hms6Xq+Vn6lVyWvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmvcQJCKW/4yCVKyL2MVbITkfgcrIyk2P16k7wkqSYc=;
 b=mZhcw4pNrzex//geGPvIlgBnRCwsg0tLhQq1ODKFsNWj7KL1NVdogfaWdrS74k1WwZMBsFbzc0h8D3iOAsZFMp+Q0bdro3ONatXH0biltUceXEHFfwMDT91d0lxCsuFWPudLMer86Z6Xnw1GRIhzePxDuUfg4hxxACxRDjTJTp7aQLZkniVIbIqVifMOAAgaRSJmKD5jEBXYBz6oOCN+2ZDF4ICzIjRsa3YnVHWbXIDfnhQCKlRZDfi5FhS6fiLnP0hkcGwuEx6tqc514wDGvLjmkDyMfynoqJ5eHJtHfq7k8NrvA48u7uf3qfvTIt+CgsNH6qgr3HBBJdOr5FcJQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Sun, 18 Oct
 2026 09:19:54 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 09:19:54 +0000
Date: Sun, 18 Oct 2026 11:19:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.4] sched_ext: Report a
 sub-scheduler's ecaps on attach, detach and cpu hotplug
Message-ID: <atSPMmtaEVJCfZxP@gpd4>
References: <20261018015952.1499528-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018015952.1499528-1-tj@kernel.org>
X-ClientProxiedBy: MI1PEPF00000AD4.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4b1) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c965be-3b63-4d1c-4fb0-08df2cf8f86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Kr0sFN/Dce1l5d/5m/bSjNsktih6w4VW6Ti4DVOWcKVOjdwHvhnYOOfe/nGTm4xuy1k+bUTxb50Ld65A6aygeuxnj9+2qSu9rNiH7ZyLvHsCl9b57DpVSlefx9dHBB/Uu2LEflwYkEBTKkr8dqOff3g9osFc4MS1W+WHO+4GeSrHQf29W68BnOciY1Cm4ZCvfwlj/LFtxPQZJXcJ61fIBBesJzmv5h98c566IM718OSypAkSI7+He+0d/M6LXc8dT2SEIOf27agEwcM8HGjn10vS4SuTRJ+vCdHePaXFPeizLrpAuf7KFXIgcjAt8lZYONYKBcRDznmN8ln2DVjXv+AsTQXZUeO7UbImqhHVg0bLXnzgXaSmB7lqTEO7bx1ZGRu5bmaQ+O49igEVSe7nCjFziAn3aIenCzZDS9hR2y2lXH80mc9df5yVz/u6+Vyt7VkADLpEOPJHQx6Je+P9ZLyIqNXH11WpfDrqwCzEeLYCkKwfzcCckXZk8vyePcMVZiFo/2zu2rrVCZecO2qw57gzyTxM/BC+KMWdAa9RaSwpS+AcEGmLD8Txp1cjYJqEl6PCPfmB+o4GcOpqYaFfqEIWP2skYXWqH14A1uPiJ7SGpprVfKORV2lzTRYAXpjWKOX9vspjJlculddiFHddbWPnmqShW0ackgGodUJn7ho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XDT+xaed5rXjLZ3X4ZnVBwQDjd6J25xR6m0fuUYHLG0fBt+2Vc/Ztg2YrIa9?=
 =?us-ascii?Q?A7L6Am6YfAkXixENxBNyChWlmx0y+g6zeEESFKCZWDsb5XtA9x3QcD3/0xwi?=
 =?us-ascii?Q?yCSa3JxlpojR3LiVtQRGlf359pmzhzfd2X/aXF7kNXDWQvWTsQTEfeWGrYnk?=
 =?us-ascii?Q?C8sDWU/dlqH8WaC0URlF8iRVt+kYQzRLndoUk6yuQluv9E/xmeC1goFDwqYC?=
 =?us-ascii?Q?0Ja6zbR/oXlUataGWs5HpoVBOZpTDE0VGUpgoecgVyJLzpn3oZ5WsB6IUQ0y?=
 =?us-ascii?Q?YTqltY1mGxhd5lI5LinBJW9hsW+GmPzrOFy0C8I33CyVBhwujVnqWXuDeim3?=
 =?us-ascii?Q?Smr/4slYoH/kycKEA0+UfvvJPld3SpT75/lQFsGOrNw2OF6gAU8le0gxgITe?=
 =?us-ascii?Q?VAU9F2D5yJcpAO5ISYOfM+UU9mCnA0jUIBnS08iWmBecIOFU+MWE6x+fqWVE?=
 =?us-ascii?Q?n/7RKU8QaUc2ePyPBWCDBp7o9oAgWk+na3xGmqPHSPXtKylXFhWhOiOAW3fv?=
 =?us-ascii?Q?36UX5q5LhmeJeK8ZP9R5Qt4FZ4z1rMtXJVwM4kEFgeimrQxsGnTdfV3VzO8a?=
 =?us-ascii?Q?zYYJcFCtM/LWV8Tv4POSL4EiGjLUWHz2vqHJg5UotOr2lZgushpdmOUC5Obt?=
 =?us-ascii?Q?2jxEMwAVODnPQEHx8dI4XRrZZj1WQb32mdxZpCMLiVGlcoMMBuImZW/7lCz8?=
 =?us-ascii?Q?BywINKOTehPyerZIVxRBc0EU9VzVzlhBAOswRdIGdxUoHC80VKDXeVMtK/fS?=
 =?us-ascii?Q?Amuszcj4bHLRMUJhQikBbE4O42M2p0fz46jHfQ7w1xj7INLafSn2fuJAD8C4?=
 =?us-ascii?Q?ArW+0QPPlwsCb+KGVd9TAxeQT4O6MmG8ikEPQiVej8+vLTg2ji3N531KurGT?=
 =?us-ascii?Q?RsqvWQjoAGnmTRVgOLdYbsYEKELUihbs7mf2ZwhRotc3VavJDY8L3FIlOQnv?=
 =?us-ascii?Q?2Yyyft7DPbGoqG/Qyx779AFfjk5h5YXb6HtCxf14Sf1/tYVQ0FheRiMcYyCo?=
 =?us-ascii?Q?Or+8lj9uUopwQYibYqJbhP+g5M8HVH04ksf4+nDgPWgsE4sLUhK901ljsVcN?=
 =?us-ascii?Q?OIs73bmn3GUh3qv3FB6xGQa/iHrvIoZMQiMZSvORDIDmZJpjmIx/YeJP0HvF?=
 =?us-ascii?Q?QagqhIu+1SppBOoGND/T8WFQAoFdHSxc+TGx3TG6iA4kegBxuo4KlXUOe+IC?=
 =?us-ascii?Q?993rog5GQcdQJ8w/FKkrTI7+EseUEg6oB+iUY7dUcqym8NjqTGv/+QAjfXhz?=
 =?us-ascii?Q?r59pTvIJJPe8r40aHjtdMfu1II2LIOVecAIJwKx6ADlFfZc3qN62BbqziHrB?=
 =?us-ascii?Q?Zv7AAmxdYfxHHbxP7A9OpgOnAkvAFFOiG999vC8aiaVOQL7Xgx0x5q/HOkOS?=
 =?us-ascii?Q?J+1bkjKs1k8nqXdyxts+4ZSUADnF3his6gVmTNKVCKQT0VMVvW2ZDUWwEVuz?=
 =?us-ascii?Q?LPTtc813zZG95O6dib3d/ub3acuxZcqbJZbQgJ6FIqly3aUs2RVhyczXPzr8?=
 =?us-ascii?Q?QlqZy6vkUk6g7dzbjUqg/gWcBm4Cx0wGsndrN/gaIZnKH0mMXepisa8fTODt?=
 =?us-ascii?Q?b5ynDb8dGMvsxXQQruBIWbfYAQ1a1Mc2Yg63YHMeZ6iSWZE6fF8Z9+G4v2e7?=
 =?us-ascii?Q?nIBK6qyXvsG+Yc7lODmAhQQm4HlmH42rQzbrZgLn6RL5jtSV/Rw/LucD6/9s?=
 =?us-ascii?Q?EJRiLl0RJ54E6G0luPIzSF376vmkxpKHX1wuvo+sOOlONu/vaZ0yXMtxvOza?=
 =?us-ascii?Q?5/JUg7AvRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c965be-3b63-4d1c-4fb0-08df2cf8f86a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 09:19:54.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUKhb0HW0zcTOX+5LL2Ykir2x2KZne0C4qhfWI3Feqidem4JyzfLWIhNVDyRqgLTgwRJUeNPimtGeFxT3No4jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

Hi Tejun,

On Sat, Oct 17, 2026 at 03:59:46PM -1000, Tejun Heo wrote:
> Hello,
> 
> v3 (resched from irq work):
> - Reschedule the cpu for its queued ecaps syncs from hard irq work on that
>   cpu instead of a kick. dispatch_one() processes the syncs only at its
>   start, and a kick that lands while the pick has the rq lock dropped is
>   cleared with the pick (#3, #5, sashiko).
> - Fix the SCX_RQ_ONLINE comments (#4) and why no report mark is pending at a
>   suspend down (#6), and update comments and descriptions.
> 
> v2 (detach and cpu hotplug):
> - Report the caps on detach as well as attach, and deliver regardless of
>   bypass, which drops the replay at unbypass (#3).
> - Drop the sync_pcpu_ecaps() factoring. Add the cid_pshard() factoring and
>   free a sub-scheduler a grace period after discarding its syncs (#1, #2).
> - Deliver only while the root has the cpu online, report the loss when a
>   cpu goes offline, and leave suspend and hibernation out (#4-#6).
> 
> v2: https://lore.kernel.org/r/20261017164556.4136807-1-tj@kernel.org
> v1: https://lore.kernel.org/r/20261009094356.2852794-1-tj@kernel.org
> 
> A sub-scheduler learns which cids it holds through ops.sub_ecaps_updated(),
> but the grants its parent makes when it attaches are reported only after its
> enable bypass is lifted, which is also when its tasks are handed to it. So
> it gets its first ops.enqueue() calls before it has been notified of a
> single cid and has to hold the tasks somewhere until the grants arrive.
> 
> The losses aren't reported either. The caps go away on detach and when a cpu
> goes offline without a delivery to the sub-scheduler or its parent. The
> reseed of a cpu coming back can also run their ops before the root's
> ops.cpu_online().
> 
> With this patchset, a sub-scheduler's ecaps change only with the deliveries
> that report them. The attach-time caps are reported before bypass lifts, the
> loss on detach before any task goes back to the parent, and a cpu's loss and
> regain around the root's ops.cpu_offline() and ops.cpu_online(). Suspend
> and hibernation are left out: a cpu they take down keeps the caps last
> delivered, and the resume reports only the net change.
> 
> Verified with sub-schedulers attaching and detaching with tasks queued and
> caps granted and revoked, through cpu hotplug with the races widened by
> debug patches and grants flooding a cpu as it goes down, on PREEMPT_RT as
> well, and across suspend. The protocol between the reports, the per-cpu
> syncs, cpu hotplug, suspend and the free path was model checked with TLC
> for small cpu counts.

For the whole series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
