Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF5CA6B
	for <sched-ext@lists.linux.dev>; Thu,  5 Feb 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283587; cv=fail; b=FD9AZxf+FYcg8kSsCJ7W8xhzqjwDxy5nBqTPtJ6vtraVkSg6F+enpBe9GVoplryDvWYen0ZixO+rFqgaWmhUPN6Pgc0/ozn8kHphFgjLQgFR66gqCAkbmrPD25lNi07bPBRo0OpeEjnBq3IpM+qDDSboKbD6FzCKy5TxXqDy4tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283587; c=relaxed/simple;
	bh=etjNtbENKRpsCeZkwwF8qIRFxGz8/FeSt7iFbgjuxns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nQ1gVZrPEyrL8iZiPoLNNY4rs8A/VxOMBAAXR6IhpumMbSPfb3vbHWVub4mHQWcDJtm1kv6tzXzB+SZlC27x4F3jbg9Qecrv+LH9bZbVJ76aNI28QlFrsCogsgxSrbCVMRW1Z9leBuyo7bprcU6Mt4RY15UIPvfGVDpdtG2K46g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PbKGJ6T0; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PbKGJ6T0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVxs1jl968/x1c24jXqHbz74mnsL735Oua/ixAoqz7CP5r5xFgptrgyNkM69Nv8wcbil23WWHWYWDMIBEgmgyqfJ+ubxRcibKdBkJpL1H2/PTcmDqDBdDBow1bp/28EpVe1yTNEscMzCZbp2H8xKy1/kPUE+H18DEdWJcW9/CGrH1YuN2yFYe3M2xDmbfMK5iUeIXXr9ftSdaYT+cCOEU1NVUv15APCFBoCK14sMuVhwfiZmp6P2VpXaJn+gEU23A0awmp+j5tQmGYgof18mq3xlOEZtf7/yLYKocMhZ3DDo+Fdf4BjIG7WIO/mIz9W+jL3adV9scKaMF7sT05efDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p6Ymq0SlIV0NlsWDVNju+T78zWeidAsD6c8KBv7mQM=;
 b=BoNSkudrHcaKgWRVgXLqttXXkvlqm4+NgkIlnjFhe3d6Gg0Z4m3UN0QJbHXOxm6o/ziS9l+QKaeWMYWBOr9ak1+tArqSb+Y5gbcNk1+l7O1Oyq2xnt/ZASRxy828MLAzursBYXVQUfUo+jbDPnGTLUays0YieuJVzAEfQM2I7CVtvm6SrAGBp1ZT5IVj89//USTjc5RRXnWCe+nRNpRI6vG4OWAmApO6xpKf5s7xgkqIh7Vi473IvEDTPp1W+cEV+WGSPqSPRWrlFfWbJHKgzrNv+zOBWQQ5MLEJb5RzCgU3k7/PZLynM7wu8CvHy6G5bTqy1kixKaDiLq61eJU9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p6Ymq0SlIV0NlsWDVNju+T78zWeidAsD6c8KBv7mQM=;
 b=PbKGJ6T05IzkfEgqVxUUDWwoqMrFNSnBiKNyFAcpGM/Xb882xzbYXYjkpOcq2kMkVYQz7AUffN01Y6dT6qX8FrTBAvDmBMWOSCuxC1RTetxlXBLcJ3beK3LGq9iBNaU7h/rM+3ZdkgU8jd3KyJihaQmoY57VLusOPf3DxQyRI3Di0IfIJcxPt1IYgrTtvoL/ceivc9r9U2lBPYQa3OZQQ9xvlGDi+Y6rkH7QkHi5G+gtyfi7qsHhCzaUGzRjlwy6pkyDreLPDYT6d//7EPgXpYIiqdNdlyg3rOPGo8fVfRUpHqVPFi4UpZN0tyeG8slUOe7VP+odbcM7tRyrs7rb1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 09:26:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 09:26:21 +0000
Date: Thu, 5 Feb 2026 10:26:11 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYRiM5leoHcWiXw3@gpd4>
References: <20260204160710.1475802-1-arighi@nvidia.com>
 <20260204160710.1475802-2-arighi@nvidia.com>
 <aYPE0GRJEu5gdBVl@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYPE0GRJEu5gdBVl@slm.duckdns.org>
X-ClientProxiedBy: ZR2P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d01cb44-cf31-4b6b-6437-08de64989fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xIxY2zk9q2Y94+PxQqWyUvZjWtYYttVoP2a3hA2OMdp4KYULYlK3e75ySajd?=
 =?us-ascii?Q?OTbyt/VhDVEKvaZhBLTcC/m2T3SH4xxgl3PwoQgDseABJ3X+2LI3Dxa8vmP8?=
 =?us-ascii?Q?OriwDuSWl1SUJ2A4GTxONDuzxG92S2Vf9332bq1ZbvIVOlBb3FO54WRPHn3l?=
 =?us-ascii?Q?M7pASn1TkMkU1NyoTpwUgsRPQIcjaoQUxYPEv+g7+MJ2tbkt7aHc7LcbENbL?=
 =?us-ascii?Q?D7R5naQbk9bjCK9PW+73skSH59byCTVsxPFNWwNTt8swDtW5GUH6/lNz5dZE?=
 =?us-ascii?Q?60moskI9TytkGZwLPwomSR8nxSzCNXdtPI6kZS5fqHyYrpD07RXuQOqR1PIS?=
 =?us-ascii?Q?SW47k6kiN3I9h98HISFNwmTbenFzuMhioBDVdxcUjfCn1nfXIwnc7/RAK3mV?=
 =?us-ascii?Q?bHJtbr4M4LlMJzvm5DfAxXkox+MComp/YwWnkqK7Jv2AKuBR4oqRql/uYRQR?=
 =?us-ascii?Q?URh3OSNag8dPFx61d5Ge811OAnXOtgGaqHgXvS1iIJeuy3XEhqIeOKTKu9GB?=
 =?us-ascii?Q?aAfoiGXgIPl7AuaQVgikg1cXN+tglRdSMO8pJYmtRByOQV1DgLMm/P/1JPxt?=
 =?us-ascii?Q?NyFgpGiStMnPnUtFruAPGC2zM5SDC4xF6nmx5ju86pZXZKYkDYtaGsn3F/JD?=
 =?us-ascii?Q?hBE+iX8pt6r8pjDbl5I6pyRu4qmoGuc5BhUdeNosRdGp0B7dfoP4OkJAHIZT?=
 =?us-ascii?Q?uEOHlohxmPEl6i0EiIlIegl0iR10yQ8pB7XPRLcxQmBG7tza1u9RwzKebctV?=
 =?us-ascii?Q?i9vdCTdtsVoW/oRgJIojmhMO4TApkW8IGgQ4zhV0NsSfl7bftnSgaFt9+3fi?=
 =?us-ascii?Q?Mpa9aXaHUHwQEy+4hIOkTP0MbWTgq6XmFb7/slF49raPJb0J19d8aCvH8/7Z?=
 =?us-ascii?Q?PoWCLpcRspNkJdL9FrpQ2GZC/ia2USwMz5E5qFjGdFzJshSezwpw3UtBm118?=
 =?us-ascii?Q?wwbSe4pFdSyZSs4KUtExyTSErKVQHru9TYflnB3fBY+K4r5MCBZMLTRRVFeh?=
 =?us-ascii?Q?REAb4l5afBxgo1pKwLG5JS/LTdWj8Sv1aTxINyQy2dHre0HPAE9ChipdW3J5?=
 =?us-ascii?Q?ty/02GvCmM4j+gkgqM0YxOBZ50/TYNbGPMmxd1l82EiZ3wzatT05+L4JFtUk?=
 =?us-ascii?Q?hSioqkoWEx9d61Tws8XmQ0TlStbRlt8P8YYL5QAOoFLT5CPKQtfhm3D6GXqb?=
 =?us-ascii?Q?PF0pMJoRiqHqN6B08Zse3rBarr/bNpuh4c5t/zgYg+Kd2b1lRf1AwdCCLMPx?=
 =?us-ascii?Q?rseLA5IC/qawSRiOkZ+R8C1plcIBC6oszC7gAeBi2A2nzN1kh42MeLCkQdbU?=
 =?us-ascii?Q?8SwrTimOqJ5MB34TWinSEayDv5DEqHPmRI8BatZ02zCS7aVRfSuSQqCGZsQz?=
 =?us-ascii?Q?13oRslsEl/wRVXnI19RCoDF+8WjXpTQXwrXWNxkmuPtB/Syrp/edhHYF+TdR?=
 =?us-ascii?Q?QsFpS3rHgGQfE36oSD5sMLzDiN3APv26AdNmuNlSDeMS+B9iGKFYmrip+rgH?=
 =?us-ascii?Q?SiPVSceth1/RaD6QXUJoJkUEiROjpi5xGbi0/O/bE4gi0HqzysvTG3d7IEQh?=
 =?us-ascii?Q?VEb6ZSkn9wiU3cDfA58=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1piRXOWYT2kBgyqAJNQTjq+GPMtSc9xYrRqsDXCsaDSFBtdKUBZdthM9/1l?=
 =?us-ascii?Q?7L6v1xNqCPWPKAOUE4QmONIJxb5lR+K8H98sHMfWlPIbU2YPhcXkW7EMe5xo?=
 =?us-ascii?Q?MOrz6PdjrbUHfzX+8UKCqJVCtnEd6v5p7ifwxNP6P9FRuodxGqEzjv/qFk/q?=
 =?us-ascii?Q?3Z1jcrQADUeBLXmXdsbSQz/L8MGe7pJmnqXbSrr+kq7tDDbo/3ww2SDMP7Hg?=
 =?us-ascii?Q?7XA97s2QvBr7jHwFRR+tKIZ742v0IUTSw+l/O6R6plueCHPzchFc/giARaOn?=
 =?us-ascii?Q?ZFev7qTSaqv/6zHrLqYwIc42IQzOHimy0RRI5M8cemGwbyCiRYhsnGAOJhLO?=
 =?us-ascii?Q?noGtd9LPfmsuKREkOipTIor+s9vzqub/lfHpHyM1cRvljR1A7rhT2gGmtWju?=
 =?us-ascii?Q?kUY0Kj6Fi0lJqLA/ZNvE1lHtoOhjPuu8EnOYZ0Mlh9Ul5q4VQ7YszPrFBBGf?=
 =?us-ascii?Q?1510esewFYKfpSjEepqRZCbc1xZYN3TGHCvzNQUwMP/TROxPXDaJ3p7+YwuI?=
 =?us-ascii?Q?48kP15lmWCK2tAxZBuPqG4ZJXYSBDJJ6N8ZKlFLqjD3ucMcf8ZbEModRsH0N?=
 =?us-ascii?Q?CpJI5HkD+vd02SF9KK+0pm6JabiosVTwzlCKgrua3nMrW68tH5p5Dz1560wB?=
 =?us-ascii?Q?V4ZDMUx5TjgSEPBFj0QX2/9W+s8PhrvW/YkCILwS4rdNwA7jseRQMr3cRLw5?=
 =?us-ascii?Q?BdQxlP+DaicLrFuiI9re2KIuGFjXgX9LIaKJABr/QrHVcflLY7g9TYsfZFAK?=
 =?us-ascii?Q?HW+6W2oYh+5Nef14tfzctnzPXdeq/cOKhq5mE9of9v3ExjEiVyJpmQtZF8vM?=
 =?us-ascii?Q?VdFDAEOosXbkKdhfcLO04gt8daDJCy5HDjNLJrMJWhM5StF7IL5nGBtcjqUz?=
 =?us-ascii?Q?rsxGQ09/Th8FmZU7gyVhq2VTWy2hpl4iAbXUhI/xjXmuYO+TwIGMdjY3tO53?=
 =?us-ascii?Q?pM/CHrIrhMIEWn8jBiZjuthM2b3lM1s44yExpIMTVos6wLaKYClFyqWT7P62?=
 =?us-ascii?Q?PuOGAmJugO9CrvfIS9WDsOdYps2krTnODP0JqwtQAweEfWyjK4iOAupF3i1m?=
 =?us-ascii?Q?NpG8g2TFUIji9KIhEC26MXxAjJqZN3RAtwm/YYHYz2hdpx4A0nSehMVqc+cB?=
 =?us-ascii?Q?x1yjcfjaMaA3HM+mlXhPcuXIrPmmIQ5nMHm29YL3gh5bG9N09pnQGZP9fZEl?=
 =?us-ascii?Q?lm0Fm3ONz8Yc+fDuIVajdHWsJZLoplnz+rgAOWJrmdUvneOVquh9Z+FojPyz?=
 =?us-ascii?Q?zumlZ1dOc8moDTNxE6zxHv5+kMH7DRTpqjyvnmvdtnyzCjfbzIwnDD31reS5?=
 =?us-ascii?Q?NsWsQnjEjkcvpPghz1hutkoAlz4jdpAmGCdzhhq4P6EJYEdG/ql8hzs4YcuT?=
 =?us-ascii?Q?YG3x0iEp/d+vLjJWOUb4QZZbO1j9a+HicU97QUsa8ZL326pjTgYnyXxzckrg?=
 =?us-ascii?Q?HNvgtwZ7ZDJipGZ1uGoz26Xeqv5+zWnGs83n4GnDiCO5d+ethAtHzSiJGemP?=
 =?us-ascii?Q?H2vlziB3kR6cgXlowT7n+zjqSfb4S8lv9qfzx69pK7zL3EGtHMrutwqCZaY1?=
 =?us-ascii?Q?nr/iNoe93zkjS+P+mRvNAbhoHXQD6r1Fwv9f0EeyX2ehgsxhtg+NFncICTyM?=
 =?us-ascii?Q?8+MyaoTu6yhgQDeFKZcGWjI4C4nayTrG2/FzWvsKPcQcklCDRw2gxg5teGV8?=
 =?us-ascii?Q?SWX4tb5k5MPuaaxLOnIy6GG8RGauh9qi2PRCYSdXW/DHCHB0awfPhMRp0diG?=
 =?us-ascii?Q?zN8ZKE246w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d01cb44-cf31-4b6b-6437-08de64989fa1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 09:26:21.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR5pEzHlSjfjuY7D7l+lGgTpYFh82E4FlzibXDlItbFipEhR5ToTC/E8RXTKhCurzjgQPjIveDhEpd5XYXu2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102

Hi Tejun,

On Wed, Feb 04, 2026 at 12:14:40PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 04, 2026 at 05:05:58PM +0100, Andrea Righi wrote:
> > Currently, ops.dequeue() is only invoked when the sched_ext core knows
> > that a task resides in BPF-managed data structures, which causes it to
> > miss scheduling property change events. In addition, ops.dequeue()
> > callbacks are completely skipped when tasks are dispatched to non-local
> > DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
> > track task state.
> > 
> > Fix this by guaranteeing that each task entering the BPF scheduler's
> > custody triggers exactly one ops.dequeue() call when it leaves that
> > custody, whether the exit is due to a dispatch (regular or via a core
> > scheduling pick) or to a scheduling property change (e.g.
> > sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
> > balancing, etc.).
> > 
> > BPF scheduler custody concept: a task is considered to be in "BPF
> > scheduler's custody" when it has been queued in user-created DSQs and
> > the BPF scheduler is responsible for its lifecycle. Custody ends when
> > the task is dispatched to a terminal DSQ (local DSQ or SCX_DSQ_GLOBAL),
> > selected by core scheduling, or removed due to a property change.
> > 
> > Tasks directly dispatched to terminal DSQs bypass the BPF scheduler
> > entirely and are not in its custody. Terminal DSQs include:
> >  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
> >    where tasks go directly to execution.
> >  - Global DSQ (%SCX_DSQ_GLOBAL): the built-in fallback queue where the
> >    BPF scheduler is considered "done" with the task.
> > 
> > As a result, ops.dequeue() is not invoked for tasks dispatched to
> > terminal DSQs, as the BPF scheduler no longer retains custody of them.
> > 
> > To identify dequeues triggered by scheduling property changes, introduce
> > the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
> > the dequeue was caused by a scheduling property change.
> > 
> ...
> > +   **Property Change Notifications for Running Tasks**:
> > +
> > +   For tasks that have left BPF custody (running or on terminal DSQs),
> > +   property changes can be intercepted through the dedicated callbacks:
> 
> I'm not sure this section is necessary. The way it's phrased makes it sound
> like schedulers would use DEQ_SCHED_CHANGE to process property changes but
> that's not the case. Relevant property changes will be notified in whatever
> ways they're notified and a task being dequeued for SCHED_CHANGE doesn't
> necessarily mean there will be an associated property change event either.
> e.g. We don't do anything re. on sched_setnuma().

Agreed, this section is a bit misleading, DEQ_SCHED_CHANGE is an
informational flag indicating the ops.dequeue() wasn't due to dispatch,
schedulers shouldn't use it to process property changes. I'll remove it.

> 
> > @@ -1102,6 +1122,18 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> >  	dsq_mod_nr(dsq, 1);
> >  	p->scx.dsq = dsq;
> >  
> > +	/*
> > +	 * Mark task as in BPF scheduler's custody if being queued to a
> > +	 * non-builtin (user) DSQ. Builtin DSQs (local, global, bypass) are
> > +	 * terminal: tasks on them have left BPF custody.
> > +	 *
> > +	 * Don't touch the flag if already set (e.g., by
> > +	 * mark_direct_dispatch() or direct_dispatch()/finish_dispatch()
> > +	 * for user DSQs).
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue) && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
> > +		p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> 
> given that this is tied to dequeue, maybe a more direct name would be less
> confusing? e.g. something like SCX_TASK_NEED_DEQ?

Ack.

> 
> > @@ -1274,6 +1306,24 @@ static void mark_direct_dispatch(struct scx_sched *sch,
> >  
> >  	p->scx.ddsp_dsq_id = dsq_id;
> >  	p->scx.ddsp_enq_flags = enq_flags;
> > +
> > +	/*
> > +	 * Mark the task as entering BPF scheduler's custody if it's being
> > +	 * dispatched to a non-terminal DSQ (i.e., custom user DSQs). This
> > +	 * handles the case where ops.select_cpu() directly dispatches - even
> > +	 * though ops.enqueue() won't be called, the task enters BPF custody
> > +	 * if dispatched to a user DSQ and should get ops.dequeue() when it
> > +	 * leaves.
> > +	 *
> > +	 * For terminal DSQs (local DSQs and SCX_DSQ_GLOBAL), ensure the flag
> > +	 * is clear since the BPF scheduler is done with the task.
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue)) {
> > +		if (!is_terminal_dsq(dsq_id))
> > +			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> > +		else
> > +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> > +	}
> 
> Hmm... I'm a bit confused on why this needs to be in mark_direct_dispatch()
> AND dispatch_enqueue(). The flag should be clear when off SCX. The only
> places where it could be set is from the enqueue path - when a task is
> direct dispatched to a non-terminal DSQ or BPF. Both cases can be reliably
> captured in do_enqueue_task(), no?

You're right. I was incorrectly assuming we needed this in
mark_direct_dispatch() to catch direct dispatches to user DSQs from
ops.select_cpu(), but that's not true. All paths go through
do_enqueue_task() which funnels to dispatch_enqueue(), so we can handle it
all in one place.

> 
> >  static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
> > @@ -1287,6 +1337,41 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
> ...
> > +	if (SCX_HAS_OP(sch, dequeue)) {
> > +		if (!is_terminal_dsq(dsq->id)) {
> > +			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> > +		} else {
> > +			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
> > +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
> > +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> > +		}
> > +	}
> 
> And when would direct_dispatch() need to call ops.dequeue()?
> direct_dispatch() is only used from do_enqueue_task() and there can only be
> one direct dispatch attempt on any given enqueue event. A task being
> enqueued shouldn't have the OPS_ENQUEUED set and would get dispatched once
> to either a terminal or non-terminal DSQ. If terminal, there's nothing to
> do. If non-terminal, the flag would need to be set. Am I missing something?

Nah, you're right, direct_dispatch() doesn't need to call ops.dequeue() or
manage the flag. I'll remove all the flag management from direct_dispatch()
and centralize it in dispatch_enqueue().

> 
> > @@ -1523,6 +1608,31 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> ...
> > +		if (SCX_HAS_OP(sch, dequeue) &&
> > +		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
> 
> nit: () around & expression.
> 
> > +			u64 flags = deq_flags;
> > +
> > +			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> > +				flags |= SCX_DEQ_SCHED_CHANGE;
> > +
> > +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
> > +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> > +		}
> >  		break;
> >  	case SCX_OPSS_QUEUEING:
> >  		/*
> > @@ -1531,9 +1641,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  		 */
> >  		BUG();
> >  	case SCX_OPSS_QUEUED:
> > -		if (SCX_HAS_OP(sch, dequeue))
> > -			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> > -					 p, deq_flags);
> > +		/*
> > +		 * Task is still on the BPF scheduler (not dispatched yet).
> > +		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
> > +		 * only for property changes, not for core-sched picks or
> > +		 * sleep.
> > +		 *
> > +		 * Clear the flag after calling ops.dequeue(): the task is
> > +		 * leaving BPF scheduler's custody.
> > +		 */
> > +		if (SCX_HAS_OP(sch, dequeue)) {
> > +			u64 flags = deq_flags;
> > +
> > +			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> > +				flags |= SCX_DEQ_SCHED_CHANGE;
> > +
> > +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
> > +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> 
> I wonder whether this and the above block can be factored somehow.

Ack, we can add a helper for this.

> 
> > @@ -1630,6 +1755,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
> >  					 struct scx_dispatch_q *src_dsq,
> >  					 struct rq *dst_rq)
> >  {
> > +	struct scx_sched *sch = scx_root;
> >  	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
> >  
> >  	/* @dsq is locked and @p is on @dst_rq */
> > @@ -1638,6 +1764,15 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
> >  
> >  	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> >  
> > +	/*
> > +	 * Task is moving from a non-local DSQ to a local DSQ. Call
> > +	 * ops.dequeue() if the task was in BPF custody.
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
> > +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
> > +		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> > +	}
> > +
> >  	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
> >  		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
> >  	else
> > @@ -2107,6 +2242,36 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
> >  
> >  	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
> >  
> > +	/*
> > +	 * Handle ops.dequeue() based on destination DSQ.
> > +	 *
> > +	 * Dispatch to terminal DSQs (local DSQs and SCX_DSQ_GLOBAL): the BPF
> > +	 * scheduler is done with the task. Call ops.dequeue() if it was in
> > +	 * BPF custody, then clear the %SCX_TASK_OPS_ENQUEUED flag.
> > +	 *
> > +	 * Dispatch to user DSQs: task is in BPF scheduler's custody.
> > +	 * Mark it so ops.dequeue() will be called when it leaves.
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue)) {
> > +		if (!is_terminal_dsq(dsq_id)) {
> > +			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> > +		} else {
> 
> Let's do "if (COND) { A } else { B }" instead of "if (!COND) { B } else { A
> }". Continuing from earlier, I don't understand why we'd need to set
> OPS_ENQUEUED here. Given that a transition to a terminal DSQ is terminal, I
> can't think of conditions where we'd need to set OPS_ENQUEUED from
> ops.dispatch().

Right, a task that reaches ops.dispatch() is already in QUEUED state, if
it's in a user DSQ the flag is already set from when it was enqueued, so
there's no need to set the flag in finish_dispatch().

> 
> > +			/*
> > +			 * Locking: we're holding the @rq lock (the
> > +			 * dispatch CPU's rq), but not necessarily
> > +			 * task_rq(p), since @p may be from a remote CPU.
> > +			 *
> > +			 * This is safe because SCX_OPSS_DISPATCHING state
> > +			 * prevents racing dequeues, any concurrent
> > +			 * ops_dequeue() will wait for this state to clear.
> > +			 */
> > +			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
> > +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
> > +
> > +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> > +		}
> > +	}
> 
> I'm not sure finish_dispatch() is the right place to do this. e.g.
> scx_bpf_dsq_move() can also move tasks from a user DSQ to a terminal DSQ and
> the above wouldn't cover it. Wouldn't it make more sense to do this in
> dispatch_enqueue()?

Agreed.

> 
> > @@ -2894,6 +3059,14 @@ static void scx_enable_task(struct task_struct *p)
> >  
> >  	lockdep_assert_rq_held(rq);
> >  
> > +	/*
> > +	 * Clear enqueue/dequeue tracking flags when enabling the task.
> > +	 * This ensures a clean state when the task enters SCX. Only needed
> > +	 * if ops.dequeue() is implemented.
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue))
> > +		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> > +
> >  	/*
> >  	 * Set the weight before calling ops.enable() so that the scheduler
> >  	 * doesn't see a stale value if they inspect the task struct.
> > @@ -2925,6 +3098,13 @@ static void scx_disable_task(struct task_struct *p)
> >  	if (SCX_HAS_OP(sch, disable))
> >  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
> >  	scx_set_task_state(p, SCX_TASK_READY);
> > +
> > +	/*
> > +	 * Clear enqueue/dequeue tracking flags when disabling the task.
> > +	 * Only needed if ops.dequeue() is implemented.
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue))
> > +		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> 
> If we make the flag transitions consistent, we shouldn't need these, right?
> We can add WARN_ON_ONCE() at the head of enqueue maybe.

Correct.

Thanks for the review! I'll post a new version.

-Andrea
