Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91AF14A4F0
	for <sched-ext@lists.linux.dev>; Wed, 11 Feb 2026 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770850117; cv=fail; b=N6lPTXjhpGGu8HiEmK9WClT0o71QhjIijRzROifTLfwy1ex4bc3o99QwzMCyD2MZTk5XaTBhkmolVEb6PaRsU1awnErja+m5LQAYffHVHCcbdQ6YqcNeoA4jPHW9VqvQJUjvIFOuCqgmzv/uIdmspb0CP9ZlaQ7z5DoNzbChwq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770850117; c=relaxed/simple;
	bh=i69tn7CE/MLlDAgcb+qzGJXS2PLpNPi1JpPUbghbS2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O37Dcj07bB05+uLkSl9VkYSCZLRzFZGHOm2Nw1Lt+Dc0Pu2nSfAJUhGCmBViwVMV/eLYgJn7KWXOnYWVSIrLiTi5CmPseES8lvHL9yaANMEgCKK0Jvif/hq14WYCKE2TIOLvImCcPhO87dGBnONfk4S/saRtuH4Plh1SLfC0gBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UsN1kMVo; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UsN1kMVo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rk6wHc3AF+P3NGYRO4J1hEQzLDIohQmZ8599xeQMVEp5TJlKnAFzGjBscBQ1b/1LLx98D+Doq+AjmSx8Z92SgggLJD9yvd0rJFZPp92skhCKGEaKOPhd7Mf+Zs902Pqk7yUmgjTVqk1SXkDcDfoNDoUHGo5oWWqpbMT9HUScuPLzRSCPvPfPu/Ye8AIwdZT8RaSljeLy+zXeo0Sw1iAoQzyURejDmkdLwhcN4a2CCpPXl8PIk8axYw7NBCe2txn+qWWhLtkajoDrSfd0ShUh4LX5Tqx0eEjCs6w1jBgYJNq9dIQtpJj7/zFprd8jjaaoxZG/vZCwtb187gDsqp2FIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnwY23hk74FmIBpkM4maI0yHivDDvw5Nw4BfxbMr+lU=;
 b=MmkMlQqnX72P5U/MIge90oX0O5rauB/IYeEhzOALmHuv2fe1tFvgcxYtrABBBIy1KeYQ5woXpx81cyh75IeAxbbhD5dECDmumUv0ny4nwklZPOzo15lHpvPcy07HPJsBEZLTqcZv6O3rU+FO3JusRjrPiUydcajDp10+yS1tyGSOukmvSJCnBuzaGzEME4d+2mOsYph715Tr8wLye0uUVeu99pZ6JyyozB32cHOkljJNfeSDTO8XLasP8dP7ar678CLtTYUEDB8TeT2BiZEEo/QTubYhG4NycoEGV+YLH1iDs87cKtRpW/OFbMrcnkXaUTgWcY1SUlvxMpcc9PnKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnwY23hk74FmIBpkM4maI0yHivDDvw5Nw4BfxbMr+lU=;
 b=UsN1kMVo1zLKp1o7vDEyRQ55qUf6U4eQxYUZ44t6YiD7Piwu9QzGCWFkhzgwJXig8FZFSbn4mi+b4bnBT7X7AQd/3H5Ts9hKxcx2mUAW+1m+lAEdN292t/Xf1LOe+Yc2gco55h4lIJbr7SX65tA4kF/fXlnlwskL4hi04Fhs8lesRARX7yKIFhYF7yGeDoDBuiH49EuiYzPmiQMZGFIxa0j0L2wVnnx5C/6cEW8rOOxt868zgl1aoE/YwS/MDXoLYXdMeuDJQrafGjAYr2iKpMecEF3zjXO+ynr5WtLoWb4xAH89FcZyjZ7Os3pfwFanCZbeCoR2mL4Hg/71KskihA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:48:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 22:48:32 +0000
Date: Wed, 11 Feb 2026 23:48:24 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aY0HOKn1HuYn9efK@gpd4>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
 <aYu9KzKTMfNIFDwD@slm.duckdns.org>
 <aYyo_ALV_BT6WaE0@gpd4>
 <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
 <aY0EDpFD1FSrigB6@gpd4>
 <aY0EmUnmo4gGitcW@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY0EmUnmo4gGitcW@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d50270a-b54b-40bb-e174-08de69bfae60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LNYg1aTu7kwRMIs/Vh+6hZmvtxiI7Bzeje51lueEi7oAU6eYAjwd29Ks9Z9F?=
 =?us-ascii?Q?mRMgtksqr7EXxUITXBQtijQVoYnoSHpaFUQMO2ljzMf1vaXVmJe+MmTOxzdj?=
 =?us-ascii?Q?wS73ajSuaPGVRr0zdI3ystJf7MUky2gcNn+4993fpNTtsKT1C3N5qCwfiBZt?=
 =?us-ascii?Q?LG/aWupsdWUz+6WKcVa2/c0/v4Ucp/cExfYQveIPL/935VjzYRJ9C1TxKHTT?=
 =?us-ascii?Q?y4v5u2A00KrrV3SiEjNrqdTCxCZmdkNSXbtIK3FQNvKCPksKbHnTeu1GYNnZ?=
 =?us-ascii?Q?4cl5I57genSb5ca3x9sNExORn2ui4R3JKHvjZvq+ar629DCQxthDfdWjI13O?=
 =?us-ascii?Q?B6eW2klMYnHYN9pPfhfOlS4qyTPttKSBJ7Zwi0WI+K2i6lHf3z5G3B+KWaIt?=
 =?us-ascii?Q?18YwePnyO0AKc0/nc/0DmGVphr3tLVNQCz0CTGv6ug6e1DOOsBtGPx5LGw7d?=
 =?us-ascii?Q?iMKO5UZ4xN+t4gQetaWzcXaGvKlkFdRA2PIcs5UBUkh3TiR1X94O8Zl1hF3B?=
 =?us-ascii?Q?HtBGde/FGwc+NBHNg0eJeHnDkV2qnQA1NhKjSaijV5LFh35neVheMldBjzGm?=
 =?us-ascii?Q?4KdwhzLCCNTBMRCpbbehD9f8Ivxcd0xzq2FWDF8rOScNeEXGb5bDcnlLlI+O?=
 =?us-ascii?Q?hTczCjKhujpS7tnETM7cU6GPTTlkK5wlU5gmm7+5A1nPUnSRS6aeOXCZuEL3?=
 =?us-ascii?Q?b2EQ34qdNjC3+aMS/fwrW2BZcxJ22nfLha2BkBNlsLRI/DsT7a+H33cVmv6R?=
 =?us-ascii?Q?YIgjXCf1C41Nb1Ai1ebcrcwfSuVsJEwMpcDgsmbL+3v7SOR4bD4xiMX0NXTR?=
 =?us-ascii?Q?KSinaS4x6UBmSmudxNHBQBsyge8ihN1PYTAGKkg7kAgbM4s+EF5WD4btcd3b?=
 =?us-ascii?Q?w4G+IkBkAEMOjwWWrZJrwr74YWtHlHXOElMZVA2I4pWRx21FGXFzal32zqQ5?=
 =?us-ascii?Q?art5o0r1zw06WbOE3KPI6a9ytWREeuJOu1f3plMNffOfgvZEoApAd1oZS9/b?=
 =?us-ascii?Q?nBIosfoSEquR+XLe3NKghv65R/K8b3Q6Zea/qhII7qW7o+GdtxImzvKMUrzO?=
 =?us-ascii?Q?VIiD9CoDwdeDE3u23P/TXKdp742UsWG76y0taXhWjkHYv689H/WZH7WgR0xk?=
 =?us-ascii?Q?8QfDQM2ptpHIZfrqCjlLlgpb3PEJdo4vm88lH7A1Z9k/yPa9O5FvFbcKBdQp?=
 =?us-ascii?Q?NC/Zpnc9pz+Oh/s2eZ1kvk1Y5mleLiQjKhOI3Zo8yje6CTg4Q0YNEdKN60qh?=
 =?us-ascii?Q?kWO5oZcp7FelhEWY9sxSR32mDJAWIxsEnukaFq8PGK1JDrwN/+CvaE/joSvQ?=
 =?us-ascii?Q?yNOa0y/63JNM8QYm65rw/2h+ve0EtSbD8ZYxcSMjNo/zhMeMsT4tBtghw1NC?=
 =?us-ascii?Q?QYkjCvGvOPoNIX0Osm6Fpo6Ys8JSiGIBBDZO/LPLNEQ7U0hO/l/e9tBYQUp0?=
 =?us-ascii?Q?C2+W2FulwO4f/hlvI1STNJB9kCx8zYgXKZYTPSOyHxYQIuAE+fRRUe1Gtdou?=
 =?us-ascii?Q?7jHdj4Q486P90eEp6YUxPd10l4TPGb+Zz4yp17e1xqv6n0HRsO8U4A3XzyFv?=
 =?us-ascii?Q?GyYyjrmb43qoe1I0cIg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WiUdHBYOEbNSE+puPrAm47RENx2kiMxHKqUvETp9jVWeCLBlmtfOlvABaXvM?=
 =?us-ascii?Q?qqF7yOrqgBlH3j1bUAX9ujFoRM62I5Dpc+kVeA/hTSME+jwEpMXhvrx8DiS3?=
 =?us-ascii?Q?uWx+TM4jzxyjtHjfrFv1YEuoFtDq5qOmIN+fdyyDTJPEzg9Osu9q+IVCk1G5?=
 =?us-ascii?Q?Oxfh646XNPEUcIWs8hR9H2VH/iG04dvawLVyCJc9YK55UB3FcYFMCQBj+hV4?=
 =?us-ascii?Q?F9cjESw3jjLj6X/nJEqkIYL+THny8HRwHJ4jrEOLqbwUnmFu4Im/Qdw/AG7S?=
 =?us-ascii?Q?t4kiUw0729eQEBAKaHbr6jRDsBzErn6hKCweRCn5FMY0Wu4+YXajq8txhoYB?=
 =?us-ascii?Q?U6jnNLYYFq17R+TN6a2Voy89NnX6marj6MZdDI+cz+bF9TDqtxpAg96T4B9P?=
 =?us-ascii?Q?tIBpw4zLISMFEjTyUMZOucDawGfOFtPTD1hAWlvvYVWLhx0NSw9UsM8RtFwQ?=
 =?us-ascii?Q?MA66d+z5df+NFmq04ukxG723O91Hv6FlVuDrXjds+4S9yn43Wyg7hP2/J5P3?=
 =?us-ascii?Q?FhtVbuSD+Ja3ucdiU0JxEYXjcuXkJvmdQ8/t3lTiGCreDEtexAr6Tl5hfqlv?=
 =?us-ascii?Q?IMREc4hzm5LzE9nE21FK8Ym1ZdXrIhL54yfUFYSUZOo/UMmtwx6kOe1cQmbh?=
 =?us-ascii?Q?zSGW5pP1dR3OE/3m1Zz88Bv0PS/tx8RaGLaXWOwgqRWEDvqYGApwvSEFwzLS?=
 =?us-ascii?Q?Y33BVeehbex5OT+4HkWZM6oKCMcECm1Bifh74PfdPIuT30qoIYR2sO3XTO3R?=
 =?us-ascii?Q?bt3a/3Im3GbanxzaiqJZ03+2TgYHs9YM7xx74sVarBEhWqkxn3MqoTAt9icp?=
 =?us-ascii?Q?9l9QJLkIg6PL7x4h7z5afB3w5dqkzoSORP7uluVq518gKNO3HgrmknJmBQZq?=
 =?us-ascii?Q?vyBPtcvsJd6XX7DB86mBh4Bh2MiZX2mKqRdE6qc8YHzHtUP4ahxnsTdvW4VR?=
 =?us-ascii?Q?Ktxdez6kXJq4kEghrAt62BIKBvBz+46wEumln517dGsObw5ZbeXCrRngC7GT?=
 =?us-ascii?Q?LhfDjfr4QTsOuoOBbzVOF9BuQpagbxQSZQzCHD2yEY/GvsE7DT6dACd0ayym?=
 =?us-ascii?Q?crkiBpNflNMamEli51o5AQ3ec+IoTZIB3KChVHwNNTHyi94jubadQbbqHPht?=
 =?us-ascii?Q?wBfsp8x0VN2/rScHswIti+fTuIkaYhq8MUjAvXdu/ORwExso3ruGi1zaHO6X?=
 =?us-ascii?Q?I8A/bmu8r7dezRTqD8rvoT1nze7QiuD9UOViVlaIuHnHvul+/xKErgS18FDu?=
 =?us-ascii?Q?y5S+QIHKg4BLkywulU+qXPDHlYLXHDP2r/VzE+cHMco1a+bWOGEqkqTGksET?=
 =?us-ascii?Q?DgYtwHaqdeGMLx1eBSULTZGoUKw1dWCXycJLervJx351TM9LoH0Lf4NT3SiL?=
 =?us-ascii?Q?vhh7fnfgV3Lcgz81p88YZZxFC9QyCVXXlBSwXx02LDi/yMDESJsPldzEh7aP?=
 =?us-ascii?Q?pkSGoPwp4MEIPZFQpI94EqYgI6utXnCzlJ0BxaoaugSffa/JFTq8wzdZ6Sla?=
 =?us-ascii?Q?u4t1Nm0+KcDbTpTSz0zGE42+oUOL+mI37mpA1nsuysf8wg4sDnxj+ETakq8j?=
 =?us-ascii?Q?yq31uXGXEYftijG1U0SYV2MkVFzxe8/2iVhy0osti9dHLhutSMfMx7Dc6jHi?=
 =?us-ascii?Q?w4+EVQYAb/qP/BWDu8Uc1KJj/rO1Qu7PW112216iC2tdh4ufmomr4JvTWhd3?=
 =?us-ascii?Q?ut+aowjxcoS0ToQeo43FJWnXemPjJIK5pV11R8CR1q/PCEitmmOLIUSrxI4G?=
 =?us-ascii?Q?pENT+A+3Tw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d50270a-b54b-40bb-e174-08de69bfae60
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:48:31.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p26Ns9PrSrDnZ4trpOvU2M4Do7vAyyOwY77SWGttyTbmiJ3XYQCXcDUTIrha3wtZ3TNJQzPplc173KOU87UuNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

On Wed, Feb 11, 2026 at 12:37:13PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 11, 2026 at 11:34:54PM +0100, Andrea Righi wrote:
> > > The end result is about the same because whenever we migrate we're sending
> > > it to the local DSQ of the destination CPU, so whether we generate the event
> > > on deactivation of the source CPU or activation on the destination doesn't
> > > make *whole* lot of difference. However, conceptually, migrations are
> > > internal events. There isn't anything actionable for the BPF scheduler. The
> > > reason why ops.dequeue() should be emitted is not because the task is
> > > changing CPUs (which caused the deactivation) but the fact that it ends up
> > > in a local DSQ afterwards. I think it'll be cleaner both conceptually and
> > > code-wise to emit ops.dequeue() only from dispatch_enqueue() and dequeue
> > > paths.
> > 
> > Does this include core scheduler migrations or just SCX-initiated
> > migrations (move_remote_task_to_local_dsq())?
> > 
> > Because with core scheduler migrations we trigger ops.enqueue(), so we
> > should also trigger ops.dequeue(). Or we need to send the task straight to
> > local to prevent calling ops.enqueue().
> 
> I'm a bit lost. Can you elaborate on core scheduler migrations triggering
> ops.enqueue()?

Nevermind, just ignore that comment, we clearly want to trigger
ops.dequeue/enqueue() in that case, it's the whole point of
SCX_DEQ_SCHED_CHANGE. I should probably go to bed and get some sleep. :)

-Andrea
