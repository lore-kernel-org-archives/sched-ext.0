Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69A2F5487
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761609; cv=fail; b=CLE31MRH9gjzWuwsdMu0lkTUiOGPGp8yg8SxkYo4j5XCPJ4rQ7KSdrVecle9f8dHtpHYXaDks8HvmwuDPVKMbA8XFV9aUhG79BzHwBwTxMCbemSE6b3whlyJnGuz6AxogG8T5/UOsyf2T+oHmUtD5uFx5iw1N1swQHPdkJj6V0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761609; c=relaxed/simple;
	bh=2jElXFrJBK4gM4dKt/0D7GMmVuWVxHbiy/KmOd+i1i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mNsKB7ndWJNgmoN4mC+9mxq9ym6lOhm+V0RYJMmN6FRaIwpUFca0rCW22ASuSZoiwY7zdqNrBzXEAkP/lrXZDRgwtkWwI753tWL8hGnPjHNAi0CHwx3/dSuSr2y+HgdRvszQA4nrLOnKU51cbS04dtHaIaCLQLoEP344Oc4TqIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=acqDBlaI; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="acqDBlaI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae6VN+vZexjR8S9rYzBOvP7tpkIqtKu91jEAfeeKCVUIgpFfacAUie72HkTehOcecBbrOjmwkTBlsonsvkCmkDabK2XZI1TcCO7/+tllTj+J/BhlXokcqu0y6jKC6mX9KNy51FitiCZZxMME80QI2Qe0HVr7UXMs3pW1/QqbUCwIIECYqXPU1Rf5qf/qdFlUMDbW5q06gGtzmPncBtBLKNnWCcqXZEWRjGO5n2Ec1szfMjOP5u0OXn2fl9CV32u+MSxhyYbze+F5HTkYu83AKO9ZsTUIl5wCzKKmsCzbSQreGKCdIaIx1yZ6cL6lFxrSTe2nue67F54VN7yEpFgfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+4mJ6jNyXCMVLnGRaobWT50tPADnfHgtlGeLGXOx58=;
 b=Gt+UtVMsHuGIFeSfFgJCRmBzh+XeCD5B1RkxqCVlZJ7MJZkEypzjgLSL4Cu17zntBxG9q+dSDJrePVgufXG4v74/0cU3ML6L6If8r+4Y2IvS3T6h75feMACDIHbOCeQy6W7mwGM7s7i795NWwepEWIDEZdxjnvolnE0OLizpyOg5ETm+p2gTxjJdrcUPY20xnlW7ASjVfngTDZzDDzmHV9C+qNuGOXINjE+kmtSg9Vh0MBrGqAcr3KdRFKwi6se4NbV8oEjIBOhcGqKOjPxK24dWusQ/a/KVaS8RU5kiiDqBDIOXrGiIwEjNqhLBMOojoSpa0gAxbF1TY5gRaQ2I0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+4mJ6jNyXCMVLnGRaobWT50tPADnfHgtlGeLGXOx58=;
 b=acqDBlaIYMWpqGTN1pRpLRjRfxmDpI+5on7ITHZ3cp07t9fs7e1fjxlUaoJ5QQMzZWMwiFStGHrYznMnnTjfvr+32SOnNrd4J40gxRPQIz1DHqqzJOk+SmK8bE3fduujJIMhuPvp7ocUNHtoIU7adaPRjgn/gJWeDcNCT4rwTFwiWWUpyNpdMyZD5BBuiis3m2GBjoerjbzbOucj8T7CVrL5RFWidYH7K5s85EBVEVdXKEGAi7R3/8ZGTwwUSVrd+fS5+374CuejCeChhgpAR0kTfdMzMfOZkdvMZ/KfUqSlld9LJBpHm5tekIZ93qteqwzsocofTb1E5O1CuvOxPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 08:00:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 08:00:04 +0000
Date: Mon, 10 Nov 2025 08:59:56 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] sched_ext: Make slice values tunable and use
 shorter slice in bypass mode
Message-ID: <aRGbfO7COrEpijtd@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-3-tj@kernel.org>
 <aRGOSSN9PiCBCoWy@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGOSSN9PiCBCoWy@gpd4>
X-ClientProxiedBy: ZR2P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d54254-3073-418a-3975-08de202f2822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTUGHd9jN2N4RU+H08rhjrlMTRo4byfHZghQD+ZnM/HGLK2p03m80BMSsm+4?=
 =?us-ascii?Q?gAs1DPMsxq6olk/JrjnR3/W6Kajw9ywHnviiyTM94+/RHG3aHgoLED0Axtig?=
 =?us-ascii?Q?sm1aV9R3z9DxcrnkxNw4iu70HW0iZniWp7YREYo1mSi/aUZtNHerb50Ky7BV?=
 =?us-ascii?Q?iNBfGazjUfklZxER0O1LCIUXjS0fV8wWDe45h7hZV6eb3swNJie8lbdCGhpF?=
 =?us-ascii?Q?yfK2M3+I2SEcWBJWCbBEuIl+r4NvIqDvS9ntIfEIFf2TWsxo9bO1/HedUVTV?=
 =?us-ascii?Q?7POua03IAGIf/lyWEP7Ompv0IqlaQxGg46ZLFJLNBCngq9BhGxwkMYXQEiSn?=
 =?us-ascii?Q?J2m0ljDcQDIR0dLlMd+IjFhhLVsL4veKkGli8+UL/tNaBNoFUyZBNZ6b0bXJ?=
 =?us-ascii?Q?dil8b6aAEZq01ORXj24p1suDfhduAyelBDeHkyK7xPFV9P4540CNS7Z9eV1L?=
 =?us-ascii?Q?CBsELII7mFsaxRhb+6K91m3lgQZnV3STW6Ko+ZeTPKjQ/NGXkQ2cUAmYJO24?=
 =?us-ascii?Q?k01KNMYr4QVHF9f7u4C7knMPod8O4XgpUfx8LKMeZe9z60bnvEbqCZxqVRV+?=
 =?us-ascii?Q?xvRe+PkebamdLUM6gtX4Z2sqfltBF7r+cwSKWt0iP77E7hEDuXdP487o3yWY?=
 =?us-ascii?Q?2FL/LAAQ4iG3hBYbOmBt7A20hoMtO2LHMZswVAJYayUciOYET6MVhyNxKNla?=
 =?us-ascii?Q?dPVqTkmR98/4gM8V4Ly/hzhQ0Qubzt3x0swi5XZGpiPQY/7FSfYhRWIUnC92?=
 =?us-ascii?Q?ya5T7EMIk+JcyYixtVk8qtGoBhqDMtfsLXimGrbl8XunWsjWVuprQ1hhQJxw?=
 =?us-ascii?Q?uN27Lv5JpzjKXuVSTH5mgq4zGXbGCluuxVDmmLdEP2dmw/EUjYWfmBt1U99J?=
 =?us-ascii?Q?HmLmCPG4zEgLSU7dQam7NgkBRCzwQqJvraD+72+owWQHj7Hn6g1e9KUCqQUk?=
 =?us-ascii?Q?KuBdpdAL7pXO4WtF+KRAe5vZRyEdhAYZ5Mb8vdy5+WIPYUoepQwa3LiNlrDU?=
 =?us-ascii?Q?J04tRIdIw7y7gSHmFAkIOVrRpBoY7EWXSfvWHREHg7u29iWIJrDtdIoS/eb+?=
 =?us-ascii?Q?mZWtBL8AmthT3kvECVDMO8BCUGFvyjDS1pMCGZqbD1UGKctwx2Ji49lXvUSr?=
 =?us-ascii?Q?ryhZcfZ93/5oqC58MP3XCmZExm6hxm1OYBXlSwpxkbS1i3vUA8rNTVO4VMxh?=
 =?us-ascii?Q?FtMGTCfVtV90m04XHTZpO0pxevxXAuxIaNvIfCkz+OS9wgISAQLs6o7YKv84?=
 =?us-ascii?Q?IKA1KFt0qc0OjabPZr+94HaNZnQL4mYpOhJmF/+Jg+If6kZ4c3KarAZRn6OV?=
 =?us-ascii?Q?nR/wfQM5BXLuheFYZTHw37f7ILgsVGUWzMFOb80pm5U/flvs/pFZHUbCeKHC?=
 =?us-ascii?Q?w517Onv+A/6mEhrASkUAsjCx2kaxl4Mo639xc3kxjP830xW9uJLFC7FjyW72?=
 =?us-ascii?Q?R/1bSTwReslO927Rci+RPY+14b64umjH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wAyAR1gTYoe8I2oSJSfApPl22Nxw3gOWBxuU7ZOt6LSkYIx2rZ0O71WZyoEd?=
 =?us-ascii?Q?KaoL5zOPxHWeoGKLa4GF2YXYRFkoQ0s46h1U2T0a0/Fq5MK6BXHyFhcgfbjY?=
 =?us-ascii?Q?c8R1y8xj1jWz0KTmsMycGesggh9n1HtAQH+C/l/FJ1wsSh7bxfRuEx6BoJjJ?=
 =?us-ascii?Q?L53bblayCJQhQrjW4TtVtJkiOpWh9dUuLz6NfPM/DZfMoiwylTvoVNsV6mpM?=
 =?us-ascii?Q?XPiJPpit0ED34WxrXHPXQbSsN783Gzt5rptTr8/TUmrTock4tEi8cXbYbAnU?=
 =?us-ascii?Q?aP1bjrE2iquEkVdFMiBu3PrJ7bQeqigWDR4ETbQrTVMVmtASZjXVR357gLOV?=
 =?us-ascii?Q?oOmJhscLEZRBdZEgh0PM5yRxId9Ys/TsTR3bGT6K8iprLgFOUwENVzae9LX1?=
 =?us-ascii?Q?L5KiI6OOQ4APOCIWYP1FOI4lkdRQRsv9yuvjgznyB1obvQ1lWWZit1gr/67f?=
 =?us-ascii?Q?USj+pPeRq1KFC4xcPFZfcHuq6rgH1kU1guSXxbnesyKGb1QCXP1vuN1IbX2C?=
 =?us-ascii?Q?pXmRrPh0PcRXAD0d+iyUHUKHDeUIjK7ll21573h1o72PGRE6PLd5LlPdcntz?=
 =?us-ascii?Q?YPFibx3mRHya3mOnNuxP9hejs1NWUbzJFMTp42qFj0jsJuQf/WIa+nLiZKvK?=
 =?us-ascii?Q?IzTMK7eoB1Y09yfFOUpkDyVOAU45ZiXNOYUm50tO7uVEmicqMBjM2sXMc8WK?=
 =?us-ascii?Q?UOTImArRCToWHdvWaC7ABYamTidHS59PiVOlwUCllX4NSMmjwD/+6Sq4pb3S?=
 =?us-ascii?Q?6LssVkmb2MCy/PaEflNa5zSDpIp6/v2LnISwz854RFcc0smQQ6D0VwDdi6tQ?=
 =?us-ascii?Q?I4oD4MbWIaxP8agtRCJZbDXPtt6UuZTsODujmUlpnbW0cuPT9sU3ZzeVjF+0?=
 =?us-ascii?Q?hZX0yQnd7pDnrE2Za3kUx/NF8Pk2HmcmXfaPiM3OMdV8kraKqZDf36P/4t+9?=
 =?us-ascii?Q?C8Z7t4XQ3bzp4aFQ54IEOsS4qHJV2AkJwnlaaD+dwuFBilJyCCTC3WeLAjJi?=
 =?us-ascii?Q?zEOrZ702BM9GdxDiMzrwCwcxxaLrmMBKLmTeefkGrICA6wb9zDobrXMuC9b8?=
 =?us-ascii?Q?eD66e/GvBK0niTvuk9qUDB/2wLbfhxIEDX79Bwtzo1Q1xmM++fDGXemvWs/E?=
 =?us-ascii?Q?C5Jio7KOuz/rJeDKPn7qoicl6RCwfj8koYMwgJkV0Qdp1tvpnasgBmpGkfkI?=
 =?us-ascii?Q?1Osf5phBovdWwMHHbnaLVXDpyr3M8Rh81pxB68FfSGraL8OLYp1ULSkO7RYQ?=
 =?us-ascii?Q?L6eqkkg8yIpOHy8foyeXSSmq9Nvn7m9foKTM6wSmpR9BHrcDJKXfCpC3mK+B?=
 =?us-ascii?Q?9e5GDqug20EkxjrhQMb48GI4p94bUMVE+MlYKbkiUf35j7oC6WHl2NFJ9CNn?=
 =?us-ascii?Q?xbeRoukrs1A5BY9RDGG1ve6IMkXjfJdQR3VSEcC5iWO7qHPWAY5wsW6yquSN?=
 =?us-ascii?Q?6iCBmGRElzn4EvXxV0W8eP+b+a9g4nXgkqXP04u1ze55/m9zy0t51rmpB0rk?=
 =?us-ascii?Q?Hcd/7diTnabBmUrYild+fN2sFCxXhJrHX1aIZ3JuBAy81gmWfosyb1IW91QC?=
 =?us-ascii?Q?f2wAotM1A2g1uJiahWjRu3QvJp7QqsbQJnrkhWoJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d54254-3073-418a-3975-08de202f2822
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 08:00:04.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBLxS5HfspHGTpiAgmcb4519/yegFI6LZ4iRf/GUNqBgXo2pthME25Tn+fxvXEMcvlJS9bDClZ9GKiKlfMjMmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200

On Mon, Nov 10, 2025 at 08:03:45AM +0100, Andrea Righi wrote:
> Hi Tejun,
> 
> On Sun, Nov 09, 2025 at 08:31:01AM -1000, Tejun Heo wrote:
> > There have been reported cases of bypass mode not making forward progress fast
> > enough. The 20ms default slice is unnecessarily long for bypass mode where the
> > primary goal is ensuring all tasks can make forward progress.
> > 
> > Introduce SCX_SLICE_BYPASS set to 5ms and make the scheduler automatically
> > switch to it when entering bypass mode. Also make both the default and bypass
> > slice values tunable through module parameters (slice_dfl_us and
> > slice_bypass_us, adjustable between 100us and 100ms) to make it easier to test
> > whether slice durations are a factor in problem cases. Note that the configured
> > values are applied through bypass mode switching and thus are guaranteed to
> > apply only during scheduler [un]load operations.
> 
> IIRC Changwoo suggested to introduce a tunable to change the default time
> slice in the past.
> 
> I agree that slice_bypass_us can be a tunable in sysfs, but I think it'd be
> nicer if the default time slice would be a property of sched_ext_ops, is
> there any reason to not do that?

Moreover (not necessarily for this patchset, we can add this later), should
we turn SCX_SLICE_DFL into a special value (e.g., 0) and have the
schedulers that currently rely on it automatically pick up the new global
default time slice internally?

Thanks,
-Andrea

> 
> Thanks,
> -Andrea
> 
> > 
> > Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> > Cc: Emil Tsalapatis <etsal@meta.com>
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  include/linux/sched/ext.h | 11 +++++++++++
> >  kernel/sched/ext.c        | 37 ++++++++++++++++++++++++++++++++++---
> >  2 files changed, 45 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> > index eb776b094d36..9f5b0f2be310 100644
> > --- a/include/linux/sched/ext.h
> > +++ b/include/linux/sched/ext.h
> > @@ -17,7 +17,18 @@
> >  enum scx_public_consts {
> >  	SCX_OPS_NAME_LEN	= 128,
> >  
> > +	/*
> > +	 * %SCX_SLICE_DFL is used to refill slices when the BPF scheduler misses
> > +	 * to set the slice for a task that is selected for execution.
> > +	 * %SCX_EV_REFILL_SLICE_DFL counts the number of times the default slice
> > +	 * refill has been triggered.
> > +	 *
> > +	 * %SCX_SLICE_BYPASS is used as the slice for all tasks in the bypass
> > +	 * mode. As mkaing forward progress for all tasks is the main goal of
> > +	 * the bypass mode, a shorter slice is used.
> > +	 */
> >  	SCX_SLICE_DFL		= 20 * 1000000,	/* 20ms */
> > +	SCX_SLICE_BYPASS	=  5 * 1000000, /*  5ms */
> >  	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
> >  };
> >  
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index cf8d86a2585c..2ce226018dbe 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -143,6 +143,35 @@ static struct scx_dump_data scx_dump_data = {
> >  /* /sys/kernel/sched_ext interface */
> >  static struct kset *scx_kset;
> >  
> > +/*
> > + * Parameter that can be adjusted through /sys/module/sched_ext/parameters.
> > + * There usually is no reason to modify these as normal scheduler opertion
> > + * shouldn't be affected by them. The knobs are primarily for debugging.
> > + */
> > +static u64 scx_slice_dfl = SCX_SLICE_DFL;
> > +static unsigned int scx_slice_dfl_us = SCX_SLICE_DFL / NSEC_PER_USEC;
> > +static unsigned int scx_slice_bypass_us = SCX_SLICE_BYPASS / NSEC_PER_USEC;
> > +
> > +static int set_slice_us(const char *val, const struct kernel_param *kp)
> > +{
> > +	return param_set_uint_minmax(val, kp, 100, 100 * USEC_PER_MSEC);
> > +}
> > +
> > +static const struct kernel_param_ops slice_us_param_ops = {
> > +	.set = set_slice_us,
> > +	.get = param_get_uint,
> > +};
> > +
> > +#undef MODULE_PARAM_PREFIX
> > +#define MODULE_PARAM_PREFIX	"sched_ext."
> > +
> > +module_param_cb(slice_dfl_us, &slice_us_param_ops, &scx_slice_dfl_us, 0600);
> > +MODULE_PARM_DESC(slice_dfl_us, "default slice in microseconds, applied on [un]load (100us to 100ms)");
> > +module_param_cb(slice_bypass_us, &slice_us_param_ops, &scx_slice_bypass_us, 0600);
> > +MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]load (100us to 100ms)");
> > +
> > +#undef MODULE_PARAM_PREFIX
> > +
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/sched_ext.h>
> >  
> > @@ -919,7 +948,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
> >  
> >  static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
> >  {
> > -	p->scx.slice = SCX_SLICE_DFL;
> > +	p->scx.slice = scx_slice_dfl;
> >  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
> >  }
> >  
> > @@ -2892,7 +2921,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
> >  	INIT_LIST_HEAD(&scx->runnable_node);
> >  	scx->runnable_at = jiffies;
> >  	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
> > -	scx->slice = SCX_SLICE_DFL;
> > +	scx->slice = scx_slice_dfl;
> >  }
> >  
> >  void scx_pre_fork(struct task_struct *p)
> > @@ -3770,6 +3799,7 @@ static void scx_bypass(bool bypass)
> >  		WARN_ON_ONCE(scx_bypass_depth <= 0);
> >  		if (scx_bypass_depth != 1)
> >  			goto unlock;
> > +		scx_slice_dfl = scx_slice_bypass_us * NSEC_PER_USEC;
> >  		bypass_timestamp = ktime_get_ns();
> >  		if (sch)
> >  			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
> > @@ -3778,6 +3808,7 @@ static void scx_bypass(bool bypass)
> >  		WARN_ON_ONCE(scx_bypass_depth < 0);
> >  		if (scx_bypass_depth != 0)
> >  			goto unlock;
> > +		scx_slice_dfl = scx_slice_dfl_us * NSEC_PER_USEC;
> >  		if (sch)
> >  			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
> >  				      ktime_get_ns() - bypass_timestamp);
> > @@ -4776,7 +4807,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
> >  			queue_flags |= DEQUEUE_CLASS;
> >  
> >  		scoped_guard (sched_change, p, queue_flags) {
> > -			p->scx.slice = SCX_SLICE_DFL;
> > +			p->scx.slice = scx_slice_dfl;
> >  			p->sched_class = new_class;
> >  		}
> >  	}
> > -- 
> > 2.51.1
> > 
