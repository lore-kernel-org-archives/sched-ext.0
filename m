Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF0331A45
	for <sched-ext@lists.linux.dev>; Mon, 29 Dec 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026180; cv=fail; b=p/dt+kCampy7hc+TP96WH6EYTjO34rwn8EX7SjeDWFxqYfjjrXPa/6MIz9VGyY6EfNq34FqxGp89/xIov2aFr3zADRSPDv787OTD5rh1TwkVNkQIVsQT7Oonks/5vHsUCjTrZhObE+9odaOWMaTr4Ov4f/wWm5IN9g1f10AFEAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026180; c=relaxed/simple;
	bh=wZgY/T3K1RyKr7MprIg6J8l4OEIMYdqiMNX0BSTJXlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CwJb2wsgJr9Gr/pXkbcDHy4hc+OiDO+OT6Vgu1zkzvfmvqpjqALFxX2XJwuY1Jfhd2wze6HYoa4wPd5V24tpE+OSuub7I5cBitm+pUsqysySykrwdX+MQ1atIlP4JyjE5T+eBlPD5PqRAP8apdULovGbIh98k/acs7RuN8JY6M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgAbby8T; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgAbby8T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkD07IfsK2wVgstPIjc3OjhIr9jzgX8AjFzabKnAGxBveTLzffBtQkx1lD1HJGkaAQ3zOSiF+5sBzNL4WefbdNPiTsk6UWBLMuooBLTOI9Fgb7jX5ZQZsQ/VcTACvXhQ9rov+q61MRJYXLlNZeij6Uk75kfQQYhUskuKKcbIongUXGfHWDatQxvR931CQ+P6195Ly9pVNPF6J2PTsm4XwewKjHY3eBa7PRB8b/qmHWeuzeqq+VIAVzgA/OCs1bZO6PMA7rV2oBj1dn2E3judn6Jganh9hZ8RO7GbV7NJDDPY8snw+6FUo23GJVY460dGa+7+pnw3ih0G3rVRYAEM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW1XCNwCf9Z8qptXIRuBFSGy6bKW1jowdgUmFVFEHiU=;
 b=Ap3CIwxfxkFFisXee0BVyJi8C5Xnr03Rhyw/v/aZMVxENPs957dnB8J+FwepteuBGTWNcXomHlTYupxiV7MkB9GvDuSWoaaU8pZu9gt1ukakeEO2q092GlAzBMK1nxtrd7lrbnEPs1hhO42fTNIAnb52qVa6jjbrGo9587Maqqly7Zv/j3NGQaJ0Ek4oHuALMABpLsvg8wXHOTN8m5+Fm0BRzya6HG154ez6eGTHAhd+4uRFgsS+G7YIDBtGGOQtaUEGtFi+uPFOUJ9csAuq67SOXYVAOKRYwQnn6A7eAioktpGVK4tU/BCgPor2syuny6zeHI/5c9b+n3xWvzZIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW1XCNwCf9Z8qptXIRuBFSGy6bKW1jowdgUmFVFEHiU=;
 b=kgAbby8TeSZNWLn5E9rQ9x+Qsi37ZZMyzpUkZJgC3Au8jkEid4uC4P+ie9pav/0HjD8hD9606110/owQ+xpUkDhsF6McO8Z2e4xCAF8rqPMkHz3m14QmuBXDvAWHRdH6Y+FgJua0dDylM7fvDVV2Sr1bBZ21V8PywRE3udbUHJmglaZ3qJBULug0yri849dRUCmStw9mTWXjNtbeKPh5rAcL0aNvtnm+Oo/bk3EFFI5T7jvT8kKFFlV6sD5tADy003bq2emt81ZaY9Wd6wdANrvOkhasZ4E9Jw0Y7CPLLso4LPfT0uQPbyeRojfSjsrVbQqMEzlIlyDG7fcEHzJf6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::995) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 16:36:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 16:36:12 +0000
Date: Mon, 29 Dec 2025 17:36:09 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aVKt-cmkOxPe3MI6@gpd4>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
 <DF9IXXXOIXP7.LILBQBLDYVM7@etsalapatis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF9IXXXOIXP7.LILBQBLDYVM7@etsalapatis.com>
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0a7f92-a0c2-48f5-80e1-08de46f8608b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZibXBSoh7mSLIWm1Gjzy0Q7SebNo1HzRQgI/y8eYYVG5sNsZPASv/6NGyJ09?=
 =?us-ascii?Q?QmWtVV3Q59W8yCBcW02MnAj4rq6ucu5fnZuCseqf6mVPkgzMnIaDcfZp87Y3?=
 =?us-ascii?Q?of4luKXMxRgRCxOqsEHlFBtv+oCCLKr+3wQCCBEvkmZb5lIaWPQC7QrCo+LV?=
 =?us-ascii?Q?tnOyEbgbGjXa4n+cZ5ph9AAGZSNZo5tz6GIWdK51Nd0FYHDQIWwZkz+FP1EI?=
 =?us-ascii?Q?JTvyIoR1OS4dFKhhImMQc7bRI4Q71ARHYDfEsvbXniWj0iXcnvhPDBsZ2s+A?=
 =?us-ascii?Q?dsA7LrGlMSvwqSNUK/sgKKAjgO3yXamznm/bIyLas8wn2I2YZQRb6yk+OKis?=
 =?us-ascii?Q?ZR/MoCcbB9Un3ZL3OoXoN6rQVSo5Th7GihkZtDxW8Jx+FJe1kMAybOFaYWF8?=
 =?us-ascii?Q?Yl00YOSNYjFEdU/Wy94em1on3/CzupHtKXh/6Fw7icbnw0rZkL4ZtQmpInev?=
 =?us-ascii?Q?eDEHux0gQMdCcLtDpPdygomye/giAchxTr9eYSh9pkAIVtRXH0spw0wwrDoi?=
 =?us-ascii?Q?j2ectld2o5O1DR1QX0fN9EghSnE43ED8ebzv4kz+BLjNhTDrOXRftTcrd0ff?=
 =?us-ascii?Q?8fxC0mGypZ+i2bkmJ5jbs+fT3gGSOypa37pbyUoN9rvk9glaC1+WvtKiRFVB?=
 =?us-ascii?Q?Ob/stunNfhd0I4+cZGwLkKR3r1gONDItRU3gr1FFKj/kh3liG4GWHakBGqXu?=
 =?us-ascii?Q?HBWflqzaX3lZXzIAwBbCJ5W+DdQ4TtWWWDgX4Y6m+WYFKsh0u3niXhmX6UdQ?=
 =?us-ascii?Q?BuIVDKRTWFnSZIIJG2WGRoscN1ozPPokHLRa5qFeyyYWIzEY5F/1fdPHZ/YY?=
 =?us-ascii?Q?tQnWv5m07+FcNM5pEZElV3b/SNeFif2XXL5Wrny9TKw27Xp5VD19Ij8mXYCI?=
 =?us-ascii?Q?FEcxLuc6vZmU9brLcEQB1RaBLY0x2wAcKQhF6HVUeVCAGio85RedfixzIoA/?=
 =?us-ascii?Q?GHY4rwHPvmaAmUE04xdVsK0Cvky1YiwxVnyCYZN+8eSocGccctdfqdzayNgq?=
 =?us-ascii?Q?fMwygU1mf0qU/ru0nSVcw9IXBY0vr3ohKBNJ5E++PoHKExAskSYrmPwV3flN?=
 =?us-ascii?Q?MaTmB3G+rwnLsnMR6w2iE8B8G0QIMN2b9+WGW6CSBsD6lNrZmBi0b9hk4GNh?=
 =?us-ascii?Q?dd0xj7KAsT+1tHudzn3zSpTNM8gp2pqfJhlrfMDLEswp9I3/0+9xXA6dBEV6?=
 =?us-ascii?Q?BLzPPcySI0FM3aMBQOSmYNw85ce+xuUOsUG128HfQsUaaxKEQ4I2i5waFKRM?=
 =?us-ascii?Q?G90Q1zluP3fWYaX9LlAQ1DOUcEfKdSKMe1owudlOIntkUC//Pz+/ZDRRptFs?=
 =?us-ascii?Q?yOq+0v/ZciR2fuESUaV76lxNkN+F2dWZJdKKXTEKsogQUKNjMFIJA3zxNd9V?=
 =?us-ascii?Q?tfWielpkuSQH2lqkZbXj7Gm3GzIOZm23b5aj4KxUv8w30G+lBf9I+jwL0UqS?=
 =?us-ascii?Q?GKEQooTZnWS2FvmejWAVpKLoY1aYsfxe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nrbIQjOFHy+7j5PMt30DmMiZtPAfxaPdzv5l0vEE+fbL6EWpu22IRzlps4c3?=
 =?us-ascii?Q?RS8nAV8Y/WPTr+W5BMubiJnI8p96sU1Ifrz6NLRlL60s6acIsuWV5LxsT7eT?=
 =?us-ascii?Q?6KL8gvriIwx7hBQNeDtiw1OEgRDSLEm5d8Sws6FDdl/Upsy2PeGEKj9M/C67?=
 =?us-ascii?Q?KHJSZ1RykiYlFFgWC8WJd/cFja/Lan/oh5Y93mGNJ0QjDT1WcRVlxdg+zngW?=
 =?us-ascii?Q?p0N+++0N8Meyl1Q0YTih7O+6FFFfEJsDGQInev6OaVY/GAlFsrFBzKmebW6R?=
 =?us-ascii?Q?thPFHSIzvhIR+Vq6DmZjTKaxpO0F6PgNTNYN8UXJxeW5PZJ+cJyVRDu3pDjQ?=
 =?us-ascii?Q?QukpyXTyY0z6tu/f65ED+UmmMni8FouZ7f5yDcIqt3D2nJIRPhky5JM4IwYv?=
 =?us-ascii?Q?1lIg8UyQAGcmyaZrs1mmgXJcB51uc40SGL8IyE2KhWGNKsWPfDiXtYrjVIwa?=
 =?us-ascii?Q?RvtVC46AqLh8HZ4ngXtesG9f12Eb2A7/uEFNrfobJ/YQNGpyvfnnV8oEzCcb?=
 =?us-ascii?Q?MHcIQ1Goj8T5rzpD3Op7oxb4UGTjvQUfmB8cj7LXZYNXZ39hcTWbNT/ncc7P?=
 =?us-ascii?Q?XKrANM0KyKTTsPp6HD3A3KW1+dFIs02gaL4yWjumF9tpFsRniKBectlwm3AB?=
 =?us-ascii?Q?q0Oz42HfDLUy7Tdz5fgv8IopluqE5RaVK7sy8xxc+d8cg6euJh4sRKJq5jV0?=
 =?us-ascii?Q?fzDuqV4OQMnOmdv7WXYjUVBLo6kR9UQSYlIEOqNi2DUqHx76zz1hx6/SanZN?=
 =?us-ascii?Q?9zkKG+ntrtF6ckOfYjCpbdaWs1RczutiMZ5oUl5RqCwYN3eJZUSMueNwMShP?=
 =?us-ascii?Q?VboQG8tcOEz4IOKSlCMm8PYVa1vQ2C2JBMxZ+AhrnVk4vHPI2pE51scQLDh+?=
 =?us-ascii?Q?vEaVz5aN/a88hsJo/XZMbLUF5xFrVtZ5K3ypAVbsAnbXwcH//zA7YZV8zbXn?=
 =?us-ascii?Q?aPLBSCC0/wyb41N4iIuFyiSWiIRJrzNQLC1oDUXTFOeOVs0VJp7kkFEH/7H0?=
 =?us-ascii?Q?T3SZ1NsJBXJSWVxeD91l/Epimf644Yu2QF0ezibiqeen2XEiMM6UBq2ZceyL?=
 =?us-ascii?Q?VYOANhgrI1GVw6iP541xRQ24VIbdNZtiDfD6gkndYTOHjuU8dWyN0JfuJZpu?=
 =?us-ascii?Q?1rS9zD3kErNb4Ik1I4YosbRfjTq2XlNSbPtSsB4Frrz9/n5maps1h1xqPYai?=
 =?us-ascii?Q?ZDVUd62Q+bhaKvEqq4C4lcV+mTmHAX4n7m5Xbbtxg5HsD+k8/Gtgp0u/lHhX?=
 =?us-ascii?Q?fNsUI4PDCE8xm6m+g+gxLQRdp27DDwRQ9h09TAqJFQ+xymBQZTuemSDWpxQw?=
 =?us-ascii?Q?L3KRhV13ibXwjXBSz3HgsEhjyENp+MdFxpV3qqCKHf0eQCB2CHjm9zdsXrRI?=
 =?us-ascii?Q?lFuj7b5d2Funhf2U7zE3Q8BsrHE39H3ugy/pXxxbXpN+Zk4qGdhTbA0U3pwI?=
 =?us-ascii?Q?Biactu2n0OMxoK1Fj0tv2DrRsC71HYW6XhfJTj8/AIalGw5+RjNzWDoykKo3?=
 =?us-ascii?Q?CSmou8i4OVqH7fIdIfqB/pjnM/Qn4/DA8AqkANahbn9RaAU9EdfWXNpJ3mTy?=
 =?us-ascii?Q?Mz+v/zTgeaQj7M1Nb6ENruUMTZEn0kGh3ytzP+nilrjJMy1IS/l4N4iuzimj?=
 =?us-ascii?Q?PupQ4LTR4RokZbCSaGCcmikI1xmvdVpDajnmrfvtrS3LhPQAWIEU5YQX+Eae?=
 =?us-ascii?Q?/wLJTCFbCBDQ203EXqg+bH6j67ceVGbNb3b9ZcPKYdFGd5Tob8t1FZlo3tYN?=
 =?us-ascii?Q?LJKOCaHnRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0a7f92-a0c2-48f5-80e1-08de46f8608b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 16:36:12.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkxZ3vnQ/aqIuE3uFL16z9//rfkqHHgP3lpaR2eP8kn0sGoI0+vZBCDgFYUaQHmNDbJv27Uukt4vczoqwQ8zDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1

Hi Emil,

On Sat, Dec 27, 2025 at 10:20:06PM -0500, Emil Tsalapatis wrote:
> On Fri Dec 19, 2025 at 5:43 PM EST, Andrea Righi wrote:
> > Properly implement ops.dequeue() to ensure every ops.enqueue() is
> > balanced by a corresponding ops.dequeue() call, regardless of whether
> > the task is on a BPF data structure or already dispatched to a DSQ.
> >
> > A task is considered enqueued when it is owned by the BPF scheduler.
> > This ownership persists until the task is either dispatched (moved to a
> > local DSQ for execution) or removed from the BPF scheduler, such as when
> > it blocks waiting for an event or when its properties (for example, CPU
> > affinity or priority) are updated.
> >
> > When the task enters the BPF scheduler ops.enqueue() is invoked, when it
> > leaves BPF scheduler ownership, ops.dequeue() is invoked.
> >
> > This allows BPF schedulers to reliably track task ownership and maintain
> > accurate accounting.
> >
> > Cc: Emil Tsalapatis <emil@etsalapatis.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> 
> 
> Hi Andrea,
> 
> 	This change looks reasonable to me. Some comments inline:
> 
> >  Documentation/scheduler/sched-ext.rst | 22 ++++++++++++++++++++++
> >  include/linux/sched/ext.h             |  1 +
> >  kernel/sched/ext.c                    | 27 ++++++++++++++++++++++++++-
> >  3 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> > index 404fe6126a769..3ed4be53f97da 100644
> > --- a/Documentation/scheduler/sched-ext.rst
> > +++ b/Documentation/scheduler/sched-ext.rst
> > @@ -252,6 +252,26 @@ The following briefly shows how a waking task is scheduled and executed.
> >  
> >     * Queue the task on the BPF side.
> >  
> > +   Once ``ops.enqueue()`` is called, the task is considered "enqueued" and
> > +   is owned by the BPF scheduler. Ownership is retained until the task is
> > +   either dispatched (moved to a local DSQ for execution) or dequeued
> > +   (removed from the scheduler due to a blocking event, or to modify a
> > +   property, like CPU affinity, priority, etc.). When the task leaves the
> > +   BPF scheduler ``ops.dequeue()`` is invoked.
> > +
> 
> Can we say "leaves the scx class" instead? On direct dispatch we
> technically never insert the task into the BPF scheduler.

Hm.. I agree that'd be more accurate, but it might also be slightly
misleading, as it could be interpreted as the task being moved to a
different scheduling class. How about saying "leaves the enqueued state"
instead, where enqueued means ops.enqueue() being called... I can't find a
better name for this state, like "ops_enqueued", but that's be even more
confusing. :)

> 
> > +   **Important**: ``ops.dequeue()`` is called for *any* enqueued task,
> > +   regardless of whether the task is still on a BPF data structure, or it
> > +   is already dispatched to a DSQ (global, local, or user DSQ)
> > +
> > +   This guarantees that every ``ops.enqueue()`` will eventually be followed
> > +   by a ``ops.dequeue()``. This makes it reliable for BPF schedulers to
> > +   track task ownership and maintain accurate accounting, such as per-DSQ
> > +   queued runtime sums.
> > +
> > +   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
> > +   don't need to track these transitions. The sched_ext core will safely
> > +   handle all dequeue operations regardless.
> > +
> >  3. When a CPU is ready to schedule, it first looks at its local DSQ. If
> >     empty, it then looks at the global DSQ. If there still isn't a task to
> >     run, ``ops.dispatch()`` is invoked which can use the following two
> > @@ -319,6 +339,8 @@ by a sched_ext scheduler:
> >                  /* Any usable CPU becomes available */
> >  
> >                  ops.dispatch(); /* Task is moved to a local DSQ */
> > +
> > +                ops.dequeue(); /* Exiting BPF scheduler */
> >              }
> >              ops.running();      /* Task starts running on its assigned CPU */
> >              while (task->scx.slice > 0 && task is runnable)
> > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> > index bcb962d5ee7d8..334c3692a9c62 100644
> > --- a/include/linux/sched/ext.h
> > +++ b/include/linux/sched/ext.h
> > @@ -84,6 +84,7 @@ struct scx_dispatch_q {
> >  /* scx_entity.flags */
> >  enum scx_ent_flags {
> >  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> > +	SCX_TASK_OPS_ENQUEUED	= 1 << 1, /* ops.enqueue() was called */
> 
> Can we rename this flag? For direct dispatch we never got enqueued.
> Something like "DEQ_ON_DISPATCH" would show the purpose of the
> flag more clearly.

Good point. However, ops.dequeue() isn't only called on dispatch, it can
also be triggered when a task property is changed.

So the flag should represent the "enqueued state" in the sense that
ops.enqueue() has been called and a corresponding ops.dequeue() is
expected. This is a lifecycle state, not an indication that the task is in
any queue.

Would a more descriptive comment clarify this? Something like:

  SCX_TASK_OPS_ENQUEUED = 1 << 1, /* Task in enqueued state: ops.enqueue()
                                     called, ops.dequeue() will be called
                                     when task leaves this state. */

> 
> >  	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
> >  	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
> >  
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 94164f2dec6dc..985d75d374385 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -1390,6 +1390,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> >  	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
> >  
> > +	/* Mark that ops.enqueue() is being called for this task */
> > +	p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> > +
> 
> Can we avoid setting this flag when we have no .dequeue() method?
> Otherwise it stays set forever AFAICT, even after the task has been
> sent to the runqueues.

Good catch! Definitely we don't need to set this for schedulers that don't
implement ops.dequeue().

> 
> >  	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
> >  	WARN_ON_ONCE(*ddsp_taskp);
> >  	*ddsp_taskp = p;
> > @@ -1522,6 +1525,21 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  
> >  	switch (opss & SCX_OPSS_STATE_MASK) {
> >  	case SCX_OPSS_NONE:
> > +		/*
> > +		 * Task is not currently being enqueued or queued on the BPF
> > +		 * scheduler. Check if ops.enqueue() was called for this task.
> > +		 */
> > +		if ((p->scx.flags & SCX_TASK_OPS_ENQUEUED) &&
> > +		    SCX_HAS_OP(sch, dequeue)) {
> > +			/*
> > +			 * ops.enqueue() was called and the task was dispatched.
> > +			 * Call ops.dequeue() to notify the BPF scheduler that
> > +			 * the task is leaving.
> > +			 */
> > +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> > +					 p, deq_flags);
> > +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> > +		}
> >  		break;
> >  	case SCX_OPSS_QUEUEING:
> >  		/*
> > @@ -1530,9 +1548,16 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  		 */
> >  		BUG();
> >  	case SCX_OPSS_QUEUED:
> > -		if (SCX_HAS_OP(sch, dequeue))
> > +		/*
> > +		 * Task is owned by the BPF scheduler. Call ops.dequeue()
> > +		 * to notify the BPF scheduler that the task is being
> > +		 * removed.
> > +		 */
> > +		if (SCX_HAS_OP(sch, dequeue)) {
> 
> Edge case, but if we have a .dequeue() method but not an .enqueue() we
> still make this call. Can we add flags & SCX_TASK_OPS_ENQUEUED as an 
> extra condition to be consistent with the SCX_OPSS_NONE case above?

Also good catch. Will add that.

> 
> >  			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> >  					 p, deq_flags);
> > +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> > +		}
> >  
> >  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
> >  					    SCX_OPSS_NONE))
> 

Thanks,
-Andrea
