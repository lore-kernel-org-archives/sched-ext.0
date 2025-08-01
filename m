Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672D26CE07
	for <sched-ext@lists.linux.dev>; Fri,  1 Aug 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059163; cv=fail; b=AA9TozMwuZ2nYVsKuU5QQRUIX3gPeaN5QlQhjX4cbDUM3835354vvwtV/Z6kHOwpbPtEFeT9RY3fWQ/c19O00amkg6EFh0E6CKlPOa5ousBYtYwg+vORQ36X3q0Y/NXtzIoa11OVTjDN9TjyPmOHvAA9adhZzEcidJKI9NP1CmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059163; c=relaxed/simple;
	bh=cwO6Ua05NWT4plmvhJvPFa7Fn/J/NxzbTbS/AHOz6Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iDZgtGw9Z0eDzr8uOScj80BS3NUmqaHrYFXplvzhW/pX6uDGO9UAN1OUlqtmKVPobkSdc9CkAt8LhBUIPHJo4UWjdA5q7rOKO0/qRRPHZua+bcdhL1I872bohnRHe65d/XfIhq6DudUgEOQvqDHXfRZOjTBAqjCNN/TJSxj25i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OP3VInNr; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OP3VInNr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdtYnphbTZxOgnviHl4jTwnvA7HJMEvz2T0/bo59BEeWlPZ3Hp6ErOlpT4DnitTIFqYLZA+Reu/IqOGKvlLwRmhDTVSzE+jZE3x/tnw6Ua9s//KUKEhDgEoH9zZnYwT3uw6WN5yWEwjmjqMphbs0x8FBH28HNef1xNpE35IzIQGDHOxqJyIwH9wW6UAxvTq3hwK8ARY3Br1cAY9sTCi5yi/Z1QiAzASMRANOPp7nGCk5LmAV2UzaUUIXF/qQIKd2l+OGFD26r6h9Urdpyk4H0aptl+tMaR+sxCGVb4ixgr310MESypoXggjpdOxt7Gjizduw3MIsdWhTggS+oac/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eb+el83gP30+DtKSy8bV3yQTFLrhdcd+R6vQVc6AVsI=;
 b=ktmnoVY6qGDUD2DeuC+NsFDAe7O7OTGMCM4xUNcoxeuo/ZR8bIXn7I/ALA5rrfoB73xuD2j81IFeal+BJYttYxupXVR0Xr1e40vw+7XzXbTHaZFuMImTkdjzUyhf46s6RO5CFsH2vzyIqvP4cZzG7lM63Ng1wBYZiNHcIraeYab+IOKOp9WrUn21hWWLSSZtKgQBTQIjS+oCwLhDpeaG0G8JnxA4707a9HrubAdM3xLHMGRrq6bgniyBgj65x+EqizAQDQ5Eoi6iJRQDCg3h7/cXRFV4p+svfS5wMENEQ1Za4F2gCXsGkCv391O8GXrB5GC2Y/mE2MN7lNobnsCnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb+el83gP30+DtKSy8bV3yQTFLrhdcd+R6vQVc6AVsI=;
 b=OP3VInNrRMMSHqJjSXPrsDpuTJDyebvVdVys+XP1pb/LCFx2D8wHtydtY8m0VlAEDhavc3kKm+S3SKNl1CWFTFy6b4Y4vV6hk8aw8CaCD9IIvNDeZFu4aUMD4LbCsUPPhA1MUZXg3ZEpipFY1tm54Pd43u14PfW4KipxkEDwbd78uBTgzJivURIHcUSQRG/3yZiyONjj/PzhRJHbWsUEEyi0BZPvpAeyYHA5LbfuLX88G42dIrtmplWcmBgGUQFT/Dge8jzIrioSo25/byCf6Iebj/CVCfeTYVXZzWYp1BL+nJlCxJ2USLnbqgC02UcxySGFu5xUK22f877JuMyrsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 14:39:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 14:39:19 +0000
Date: Fri, 1 Aug 2025 16:39:12 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org,
	void@manifault.com, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Message-ID: <aIzRkEZLGSFybEfd@gpd4>
References: <20250801141741.355059-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801141741.355059-1-christian.loehle@arm.com>
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 8141e814-d403-400f-e8ab-08ddd10932a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fUVirI39O/HF49qkvGdTATDXbyCje5v3z0LRQi5QD5g0E+aEr3yGM0StaFux?=
 =?us-ascii?Q?s37I5iEvt0PlY1EaaxdehonQ9rRhXGWlkEbCbhBaASgEcfpsxyWBH/rCsLJ3?=
 =?us-ascii?Q?mX9CfKSOZJpd6qYLTEc6/6u6e9sVoImV+DCsNJ+7EClPNImWZsSdybPICPPJ?=
 =?us-ascii?Q?ikXZli/iKOo9jACr+PlZepuNMRlmRwgt3iMEficQgEECP32kD63t76bMeJC4?=
 =?us-ascii?Q?2FkQHF8zVYrrLK2DO20E70cwrq3H9gyw/xB8+54GDCP7Ux9TNM0KJeKF6aRl?=
 =?us-ascii?Q?e5evjH9H5fdc+cplZxrUjVWNt9tz92Kxo2sjpbYDE8bwOE8TuSqVhGGFTMxK?=
 =?us-ascii?Q?xU/LKtcvMHOXpHaccYJ9/t9kLLWu9K3c09d1/uKzBBwLGvfOexcK+tvjbjBf?=
 =?us-ascii?Q?IKTC+tj3N6jFqQFnW+xeqMvkUsaYhMZKAEz/GCfEdLCdRSRNefGo01gI2jMJ?=
 =?us-ascii?Q?yqAHFfHWg543JPMwlAt66KUS6SsmEYaofWSk7mrUloFmePzy3cMEuTLYYxdD?=
 =?us-ascii?Q?/wBHVUpcPKG+piw8htAoOqcvyuAwpHzAufEtt2xalf0QW7FPG+sbbr+h+RAf?=
 =?us-ascii?Q?2aHJTydpRBNkmrwYL+raXO8D1zV2ALth4nJU1cCyafibOK1lcEc4dfmRTP1F?=
 =?us-ascii?Q?BtCmuSpf1XFO4sxiMjVadN8zgd5BP1r8WcThkcxo0mEvlBXZrLt4PPhghJi+?=
 =?us-ascii?Q?sqnlgjw9XxNGfQck5z3BLv+rp/aP5mk3SH/1hd7MSB4R8XMoXqZps5NjoBB7?=
 =?us-ascii?Q?TlXdMx/GZrSq9G+oNY4A2OrjsiCY8Gr3+zYPHS2kRSgWX+FdigPygr83a91g?=
 =?us-ascii?Q?kEJ+ACvZQRDq2nuI3LAolUuhJAgiyEvZeVxkOIqopPisyDF5fdiiKZnB6apq?=
 =?us-ascii?Q?scM2LwZibX3NK2KKmTGc4wNq48imIvCwooRspIKrMuOHOwFfF+Ku84khHHk9?=
 =?us-ascii?Q?S93ypK+REXzJsJDFbNvP7S8hbpfp8c74F3pj3vIpLjg/KksWE60ZSLBCY9wE?=
 =?us-ascii?Q?rNZlWp3sNFLLnGFb36pLVInFXY9eX8WFOGuzEJgQX7pOR0wQmfPuTLczHGPD?=
 =?us-ascii?Q?cRerUQdDsrREvsUQJjRsAckVCiuAhVIIUS/cf0fg/Qz8F480vrx75xOwbKYQ?=
 =?us-ascii?Q?3sIWkPbIVHPgXsS6IdBoIUBlMl0KdgtNNjU1ztVXo1+EPlXxbJZvkwdeb+hF?=
 =?us-ascii?Q?5iiGv7YVy1rqTZjEzlNsUTYESL2qcJU9QI+ra5wtMQZGYZmyt6ii4lC1v07u?=
 =?us-ascii?Q?encTbGzO5Oamn6Bkf4SqWFxd0aWE3o1Qb+TIOz7fkaYEwl6AtkDBkiDmwyoQ?=
 =?us-ascii?Q?Id1S663Q6sxOfCWbGajl3jC8/wtaYRZtMb/ZyBQzcCa8oQ15u281Godxfh45?=
 =?us-ascii?Q?GoDsHMA37pz/ij0hrCfgMDYAU3dqtowhP61/pSVSaXcU1bJ3WuA1cdLwVGi8?=
 =?us-ascii?Q?O/BVUoZpy4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q9zk297THX4H5OMLWMPzvQnkBXjtdbn8SN7VfoseWtmUpqPBxWsqKYgiP0oh?=
 =?us-ascii?Q?KDlfT99mCNTzbBRnWJyUHhbGRb3KiXBod1EiyEmnzyYVAvqZbHCazwGDav4Y?=
 =?us-ascii?Q?j3w2dUPllbC1w2LFje3A8StLsW0RILnJKQIOdLs/zPy32INVJGy7jxZ/EkJl?=
 =?us-ascii?Q?xoaMs7PdwHfjJhF8alIPEGTDTRKueMZEBETxNVWxf2YoVV4XWEV4C561ohVe?=
 =?us-ascii?Q?mi+7cGrr74f4TL26nvawmASx9276uMbepTqa0qltZfjF/+KenvfI0IEuH0aC?=
 =?us-ascii?Q?n44ruALnUi36iyMUWuClwGYKgiK2u9/qS1UGJtkNsu3HVpmUPyzmACZ2x7oY?=
 =?us-ascii?Q?o7BZpLwjDtJ5+5CY1RUaLLPE+Ug0anXlP1jGKPdRcq3DjajjDuk0o2exq6Zh?=
 =?us-ascii?Q?78Kk4j2RCqURIUNQuho1OXcVL++MGxd/5XnniH+in/2VUr3JHUI1WmijXkkf?=
 =?us-ascii?Q?BwjYIUvR9bV7UECxmU07GOMWOHdYMJvCzvrO0D3F7llQhBxpGFfWMzME9Ywb?=
 =?us-ascii?Q?BHxv2ilB6BJoxVypak5Sq4fQmFKyHHZGKUYF5atsmbKOnEUp7QvArAskjrlW?=
 =?us-ascii?Q?Bf+2xAuDAe4apQ7Vd+MsgLdxrxiQ/d8DADjY0/s4Kymmi6JQtWCZPXa+mQIW?=
 =?us-ascii?Q?DBNcUxWsISDF3bgqn9ctTCUBbl4h32EyqU01+HtWV244BRMSLlbPKEe0FIW4?=
 =?us-ascii?Q?aukY7ZWvSEhtw+rV4g90+3L6VX242xwSUoRXwTTG40WERDIjJvcKU/ZpAbPA?=
 =?us-ascii?Q?p5xHbkeIFiPTcoJySOuuWPthMC/ajCzEPJBcap6K9eTK01PyMez1LXpzcly8?=
 =?us-ascii?Q?raor5ctl+XqGSZVwtPSKqpSJuMsusCWpN1r0kBN97Br5KebQvfz3Bww/OQW0?=
 =?us-ascii?Q?LXidDFwJ0h2p1Xmq0gHK1BLo5vWTVAVwwI9GPqSZP4sI8AuLnNb2Uqf2UEIP?=
 =?us-ascii?Q?w5JXTZrkgGYJCtNoANtfT9nUInDbzil24CwamsaxFmDW4jg8PFJNkpcKfaNZ?=
 =?us-ascii?Q?zTxxokmJhQ5c4ikQ2Yi8O6OZ+mTRDLXcBh9rG+dhKakLytWFYwKWBRyVGXgQ?=
 =?us-ascii?Q?Xy684k1XiGvE4dNKxFUiaFV30oVfTgCvqr4KtRwCyS6jsbdwLrt9qImgnGlS?=
 =?us-ascii?Q?zLYzk5ucO5Av23XYEH/rYzR5p9XyABV6gy2TR6cVm+Q60ArBuVs5zopqSaKt?=
 =?us-ascii?Q?9JgcBEP70srsMHfjtMLCHoZfolnUAaBQhaWMzzC4s1KtSUgbkw3ZHimNhze2?=
 =?us-ascii?Q?eCW49jU6RaZzcmQtHbQquI/xLVPFssFFexdgbEt/60iirMTZIb5jOF0TaTfb?=
 =?us-ascii?Q?7F85+vsaZ+lE4PqMOR+b7XsOT6ETogO2zpamJbOrLTBjknzaQVBK8Rd0vSst?=
 =?us-ascii?Q?ZmWgye7wzq1/+sytoP5qlKVSAn9RhE86/11yYU9YnHPth785fAD2XBm+o0e1?=
 =?us-ascii?Q?Lzsql+H9VNQn6OYM0uFNfZGrVQ+YYaGNeROhR3qB29WKmy+PD1D/E57Xf9s8?=
 =?us-ascii?Q?TpnbVP3KUubghIjbieyXOThAfwSFvMq3VXz46kXZSMaOo4pnrkILVZBTbwcf?=
 =?us-ascii?Q?D4/NcuY7ys9mcfu6oPraAIIocIMzbOdFfjbDM9qL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8141e814-d403-400f-e8ab-08ddd10932a4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:39:19.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eY1YxfxsEIQBfvoSDYQ/cSDgwbrqEjd/syyRNIWZUw7fEg3Xw2hjuiPEd39Qaay8vJujLyTaNOP/ggni2aC0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480

Hi Christian,

thanks for tackling this! Comments below.

On Fri, Aug 01, 2025 at 03:17:38PM +0100, Christian Loehle wrote:
> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
> holding the associated rq.
> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
> So provide an alternative scx_bpf_remote_curr() that doesn't expose
> struct rq and harden scx_bpf_cpu_rq() by ensuring we hold the rq lock.
> 
> This also simplifies scx code from:
> 
> rq = scx_bpf_cpu_rq(cpu);
> if (!rq)
> 	return;
> p = rq->curr
> if (!p)
> 	return;
> /* ... Do something with p */
> 
> into:
> 
> p = scx_bpf_remote_curr(cpu);
> if (!p)
> 	return;
> /* ... Do something with p */

To be 100% correct I think we should do something similar to
bpf_task_from_pid(), acquire a reference to the task and release it via
bpf_task_release().

Basically:

 p = scx_bpf_remote_curr(cpu);
 if (!p)
 	return;
 /* ... Do something with p */
 bpf_task_release(p);

Thanks
-Andrea
