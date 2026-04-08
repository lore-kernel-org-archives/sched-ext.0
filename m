Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B73B19D5
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660085; cv=fail; b=UvEQYyxZDCzfKwKgYJ89waDq1Lv7ymWY5isBEv+LUtVLVKcc8vb7VcGj1oeBCx5c+9CCgL2cW8Tu1jGmd0ohxZiZLIQvi3KHjVKJ9/CUitdkWa4PBzFTDTRVZ8zbAhaycNDcECC28aax1xlNJwo1wlHpZhOGmMWUmlPH+zqaMrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660085; c=relaxed/simple;
	bh=IcRt3wFet0H7s/jJ85LuaZXu5uhyEvccGyj+VKBTfF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6IfNR6TUrEZMtoEqo3ForLmuds6ItYghkpGh7+lEzhcQjdrJNfGrJx+msMkCHeSkQgB6+cT7r/QNkdQlraKCXcNLVZAAX06s5A0E4bch96yoUFp9eTbL2WeF4YCbTHhJeWmXMXZAbg8tLPTVSf2zpw02aPk8qvkV/XlzQcXZrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAChYAfO; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAChYAfO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drdQ4gX5QESxuOrgkNUX/yO6D+dy5On3aaQxMWFW3s5z3J4BQ5EO77JzPNpfkMvovwdeUyY6V2Ctp+HVK9h/OWqxqb0hQHR6Hazu4+tCiEK3EUU11voJ1UHwOZfXKLSA7QsHggE5FwOlc5VzYkfcnArC3CHyRxZDV/R+uD1MhB59whoTOFRig6Mlpp2KzmZU50W4t0tAZkhKqnxz2GRjjDG8B5VEHwA7Ba71GkVw9U7Kf6WE+R7ICXmYyEEcVp6ArVTMGxyuUyrAoGGeVv6HMFRx1uKdxbBTkS9j+FqoPV4JWEIckzYXaJI147+W4EAeo112UDf/gce+h4zTUemw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp8njhjokBr3Ha5ZojdJnC0Eimi4FTmCDM6lhzcDJtI=;
 b=h7GOpIotUMUaU4HlA8gKwsPp7/km2VxuoFHqpmm5w1XsrOg1mAepHKNoNpLKF6DVbQiEz1LJFLo4R3E4ygw5+kA6np43y9IpoHgQhoIc+zI5/u/G3uuaQIk3Ku2sBS4yA0qABPk8kJUMSVUlmrU/ZopJsBf/j8WrUrlQg2t1/PTN0GDW10TVU6pj0+JovIQ4u7pGdzjiVm+Qq6xSoEr3QnefwqL1c/sipXy/TkPaJZHGq38qDXxewx6hyML+m4HFe7LrcJwLv43O8fkisFT6tHBjBVLuw8oHVbEguGEFmdjZiDFZ4Y/3Uefbn/zY6mHwBdT/wbl82Y/bMOn4VTtm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp8njhjokBr3Ha5ZojdJnC0Eimi4FTmCDM6lhzcDJtI=;
 b=iAChYAfOR3xJwtG/w/0tyrQsSI7LXTaqQOINLO6SJcyVlvUjnqY0IUL4rqVhotzfWSqp1PDY3cgPGPMVovox3H/Y1Vs3LKBqfWM2Ne6t8ksycF/j9s5mE6YLIFBvvtT0OSORLiAbJjfWzcXLEKU8YQg3tRhB3lMwttxpsk+ZbvB5R8xiDS29Hkeavu8qkGluPlJRVC0xE9TvodqQ2MX6gpXczMBAXzfVh054ao4oAKtIflcCfXsXOccsVgLRStxPGymd2GD/0IECZCOGHMvxCFSkR/0hKJOe5AfYNwEPFjL+fhbgqqXvP3awqftMeJz2XXc6rPIQnKOueIaOu5FH2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 14:54:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 14:54:33 +0000
Date: Wed, 8 Apr 2026 16:54:29 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
Message-ID: <adZsJZDFNgtod-Bd@gpd4>
References: <adUxZ5Qp_vH6cBZj@gpd4>
 <20260408091821.91063-1-jpiecuch@google.com>
 <adY76wiI82pUBYkr@gpd4>
 <DHNS3RWRB1C5.29B8SXO481CHK@google.com>
 <adZc8caEfOZw8TLE@gpd4>
 <DHNU5YSWABWC.2B8Q38OKJGVDR@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHNU5YSWABWC.2B8Q38OKJGVDR@google.com>
X-ClientProxiedBy: ZR0P278CA0217.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 771cfe3a-a31b-4894-5593-08de957ebec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TDIxYIR57UO0SpO4+AhkVWsNZWyWSJY117WyYxcwe2dnNnsS24VYHeqM8VTqi21JXOa4pMnPBoisQWTr4GIJH47u1OxeGdRWzGLvVI0lIvu9YjlLcaecwN9JgUdAMoWMWIMyznoTpvXYTTzYaEuz10JMcexrPrMbBAqMaWIlq5PsdaTuFtkMkvhcOA8o+E0PLTQ0FyTHcZuH0+QsE/IuINFfyxQWEhn6fKP7nDelMtyd/4gnx6K1EXo6cZB2WjAKV+7uS/SJDOj8RjiRp8p82CNp1NnyBjnKk4HLgElvcwAapsbr40o7Gr85B2HTJmJ7wdxeH/T/RwXU1hWiuLtkYnfQAHts542ML4NA95Zq8+VVVgaVO+aJca043yG/lziPUzxY9u5YQnQJrMl6npToNhOSKoCFdyzuiTZ34AkqWErW39VyyQ7GSS2lQROmQP8bBjz2rWX/c/0dVEesf3G/SrGNkScZKiDuRa8rCzXq/hGSQoMK5g82MsIWL+BRVdOM/oPNATC+l5fkqu+BMFT/FvN+dZJhWkeNz1Ck52o4imaKA8C1Qp1gXbXCeCkLu6L4el6TmVL9kQpF55JSz8vI0FeJItGK5GELJcG24Exx35PLJtLPtlZOEKhcSXQLlA+95o34cltJB58JFCvsRQ4Iq4nunrtN12Jwko2jyUDYuNpXCYSLge6TtkHSXnqaLY345CggDRjyi5B4IxasSbzUpf0srWTSjYk+Lb5NRgyMutE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVi2Hkg8a2bDxdpx+uzBG+y64jmbzsDOfsU1WHu6rZdERVbR+DbO9WC7WCPD?=
 =?us-ascii?Q?vLTrWukm+ktXXe/61trXVJjiPtcgfdG6VICNAPtIqisiFb8mhn3X55LwvtKN?=
 =?us-ascii?Q?l68dpOYdvXOUTkbMj1jRALP4uJHIIpEQrVtPMYxX7t7OxKZ6lb4XS5qtni18?=
 =?us-ascii?Q?+nXeliPSm/HxhfihR05E2yvYnaFjJ0sUs7XTFh+NUSOKd8G8znoaWDePSXIM?=
 =?us-ascii?Q?onGykAaxZT8VDUks05NtFGOPt/HilcyLYYtgzivDzc6zu7R3uoI3kYc5tHoz?=
 =?us-ascii?Q?X2BPsl371/Htxjsb87N4oF40bPzKxQE/+UFoMLUL252zbtM5zAFV2nlQxHEh?=
 =?us-ascii?Q?Yzy7Pf9uR99G7frDrATVgQ0P8waw/vlLz16aQ83A5nCX/XRKjgz4oa1zN7V5?=
 =?us-ascii?Q?UdldrsoSesjBYhYQIcbWG2/cPSYvWirNeF/DNBxkEdjo7/zp3M4/HxLHEqs1?=
 =?us-ascii?Q?B8B2OHdGpIXoGWX6ZnJMIK6BU/MtOcOTEL5FnRAPAIHn/JeQb8djelfs9+wz?=
 =?us-ascii?Q?jRP1QqD2pspGafyjaWmOOE33pC+kXaqDk+DaP17kuMfsAMdAqsl1uWLqg1hW?=
 =?us-ascii?Q?pX+gMZnxVmYxCsHAfFKY/d70XfpbQ73bkik4lsQTeYhoonklSK8csffTLgDi?=
 =?us-ascii?Q?Loh+56awPUb4wYDsIMIFp785d1IeHHfKZEsVjHD/hQQCiyZih8wLBHS3zLlf?=
 =?us-ascii?Q?LU+1R0MC9YFWr7tkEkMG24Kov6lXhPEzMEcSOe6zPxE0OlFVll1QLStQC5rq?=
 =?us-ascii?Q?reKfOxb/I/RRrzNP5sNZBpcGtf94a8GPB+K6//mCvJLVtf4aPyOEss/eFEuS?=
 =?us-ascii?Q?DA1wYb5vGUxPvPEpynbVAjH+/Ai+HF8V9OtNZ5rpz9/WLRgBAgAz0TuvqDTh?=
 =?us-ascii?Q?ZKXadEeqJFyg0jZK2twLJb4GsrLVGMQzvGO8563JgC1BmJOMcsSJLQlJF7py?=
 =?us-ascii?Q?D05zZPpBj0Z0RxoFQz/N0YX2j1vQv04ZDz4cgr571urt8+uenXIdaGfRI/80?=
 =?us-ascii?Q?QPGYej4zWTpe7BKawo+Eyqcap0l6fZfH1DXiXCTcMJOJ1FvdgPL50aFmjWfO?=
 =?us-ascii?Q?SbWG+dPiT7VEzCVdOJKfmTJuI2S3cSIAX/uTGK5dFoZngDWISGbU6/a+C09L?=
 =?us-ascii?Q?158X5xCTLLQXPXDoxwfK5BnqBdyTEXGIlsUKhGVT2t+F9futu5Rc7Ttf0gGu?=
 =?us-ascii?Q?QU0bClBU+0yM/Tlv/5YhUL1DIp0BJg8dkoJYPRb/X26Iedj1JXZWPOPnc4K7?=
 =?us-ascii?Q?GiOTJoQzZ3/jpnkjOhhgYGa4/cIsmIu8oNfMRQNHWvpZLDOpgxa4HlPZWl8r?=
 =?us-ascii?Q?dTxhfYwXceC2hTHGCLfjLo122vTEuVM2be6LmcBxNYSlM3ugIkROb56+lfHk?=
 =?us-ascii?Q?UMFnmAmkvou9MRELyZH8YhF2dfwQrf+1Gjryt8UilNMIlbS1BXP9xNd3RE5g?=
 =?us-ascii?Q?By37cdH/bjWnFMltbsd2DWVSSM9PBvw44hkH28RzOt1zL/x/XjPQCs19MHxt?=
 =?us-ascii?Q?ErM0OJDqegUzD25EgDN4/NOZIoaz31knyvbnaAtJuXYd55FTMEAvpJWxV9nk?=
 =?us-ascii?Q?+NNb5NRbPjelWUWvNfc5BmyDGWdl67fe3k9F5u4CMHqD+HYnbiI3vFp3Q7DP?=
 =?us-ascii?Q?NV/rxQrEcqpgNK8ma6ZTy3QiBtJJNDnhboCGct8j4666D0y8ovSxci+dLmS6?=
 =?us-ascii?Q?hb0IGIRrI+vwxcM4aWMut9bxbukHRu2lHXcpBBl5txPyl2EDvIlFc47fMqLW?=
 =?us-ascii?Q?B/vkebTA9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771cfe3a-a31b-4894-5593-08de957ebec3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:54:33.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAG+VV0h/b3SFXpU6F83+Orio4gePgJp/IwVjJtVIBUEkuBinBvNPGQMrYT8X+oU8CLgOLWZ0PY5rEavM8KvZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074

Hi Kuba,

On Wed, Apr 08, 2026 at 02:17:03PM +0000, Kuba Piecuch wrote:
> On Wed Apr 8, 2026 at 1:49 PM UTC, Andrea Righi wrote:
> > On Wed, Apr 08, 2026 at 12:40:09PM +0000, Kuba Piecuch wrote:
> >> Hi Andrea,
> >> 
> >> On Wed Apr 8, 2026 at 11:28 AM UTC, Andrea Righi wrote:
> >> ...
> >> >
> >> > Looks good, but I noticed another issue, should we also change the condition up
> >> > above as following?
> >> >
> >> >  Documentation/scheduler/sched-ext.rst | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> >> > index 29d36e248f58b..99df4cc982375 100644
> >> > --- a/Documentation/scheduler/sched-ext.rst
> >> > +++ b/Documentation/scheduler/sched-ext.rst
> >> > @@ -423,7 +423,7 @@ by a sched_ext scheduler:
> >> >          ops.runnable();         /* Task becomes ready to run */
> >> >  
> >> >          while (task_is_runnable(task)) {
> >> > -            if (task is not in a DSQ && task->scx.slice == 0) {
> >> > +            if (task is not in a DSQ || task->scx.slice == 0) {
> >> >                  ops.enqueue();  /* Task can be added to a DSQ */
> >> >  
> >> >                  /* Task property change (i.e., affinity, nice, etc.)? */
> >> >
> >> > Because we trigger ops.enqueue() when the task expired its time slice or it
> >> > becomes runnable and has not been added to a DSQ.
> >> >
> >> > This also represents correctly the sched_change() scenario: a task being
> >> > re-enqueued after sched_change() still has its time slice > 0, but we need to
> >> > call ops.enqueue() for it.
> >> 
> >> I agree that the condition should be changed, but I'm not sure that this is
> >> what it should look like.
> >> 
> >> Is the "task is not in a DSQ" part of the condition there to handle direct
> >> dispatch? Apart from direct dispatch from ops.select_cpu(), I wasn't able to
> >> come up with a situation where we would reach this condition with the task
> >> present on some DSQ.
> >
> > The intent is to represent the direct dispatch from ops.select_cpu(), since in
> > that case ops.enqueue() is skipped.
> >
> > Honestly I think if we change the && to || in that condition, everything should
> > be pretty accurate.
> 
> In the case of direct dispatch from ops.select_cpu() we don't invoke
> ops.dispatch() and ops.dequeue() before ops.running(), right? The current
> pseudocode calls them unconditionally.

We can move ops.dispatch() and ops.dequeue() inside the
if (task is not in a DSQ || task->scx.slice == 0) block.

> 
> Another inaccuracy not related to direct dispatch: property changes can occur
> while a task is running, while the psedocode only allows for property changes
> while a task is queued.

Sure... but again, modelling all the possible scenarios would make the
pseudocode completely unreadable.

IMHO it'd be better to give an overview of the most common use cases here and
clarify in the description that the diagram doesn't cover all the possible
scenarios. This one is a special use case that, personally, I wouldn't cover in
the pseudocode.

> 
> There's also preemption by a higher sched class, which is not covered in the
> loop condition (task_is_runnable(task) && task->scx.slice > 0), unless we take
> task_is_runnable() to return false if there's a higher-priority sched class
> with runnable tasks on the CPU, though that would be in conflict with the
> actual implementation of task_is_runnable() in include/linux/sched.h.

Ditto.

> 
> >
> >> 
> >> A more general comment about the pseudocode: I think it can be useful to
> >> introduce someone new to the general flow of the callbacks in sched_ext,
> >> but the documentation should be clear that this is a simplified view that
> >> makes assumptions about the behavior of the BPF scheduler itself (flags like
> >> SCX_OPS_ENQ_LAST, whether the scheduler uses direct dispatch), as well as
> >> the overall system (Can sched_ext be preempted by a higher-priority sched
> >> class? Can scheduling properties of a task be changed while it's running?)
> >> Without stating these assumptions clearly, we risk leaving the reader falsely
> >> believing they have a complete understanding.
> >
> > Of course this schema is not a complete representation of the entire sched_ext
> > state machine, if we put everything it'd become too big and complex. I think we
> > should just cover the most common use cases here. Maybe we can clarify this in
> > the description before this diagram.
> 
> Let's agree on what inaccuracies need to be fixed and I'll send a v2 with fixes
> and attach an appropriate disclaimer to the pseudocode.

If we move ops.dispatch() + ops.dequeue() inside the ops.enqueue() block I think
the pseudocode becomes "fairly" accurate. At least more accurate than what we
have right now. It won't be perfect, but it can help newer sched_ext devs having
an overview the task lifecycle without going too much into implementation
details.

So, to recap, what do you think about this?

    ops.init_task();            /* A new task is created */
    ops.enable();               /* Enable BPF scheduling for the task */

    while (task in SCHED_EXT) {
        if (task can migrate)
            ops.select_cpu();   /* Called on wakeup (optimization) */

        ops.runnable();         /* Task becomes ready to run */

        while (task_is_runnable(task)) {
            if (task is not in a DSQ || task->scx.slice == 0) {
                ops.enqueue();  /* Task can be added to a DSQ */

                /* Task property change (i.e., affinity, nice, etc.)? */
                if (sched_change(task)) {
                    ops.dequeue(); /* Exiting BPF scheduler custody */
                    ops.quiescent();

                    /* Property change callback, e.g. ops.set_weight() */

                    ops.runnable();
                    continue;
                }

                /* Any usable CPU becomes available */

                ops.dispatch();     /* Task is moved to a local DSQ */
                ops.dequeue();      /* Exiting BPF scheduler custody */
            }

            ops.running();      /* Task starts running on its assigned CPU */

            while (task_is_runnable(task) && task->scx.slice > 0) {
                ops.tick();     /* Called every 1/HZ seconds */

                if (task->scx.slice == 0)
                    ops.dispatch(); /* task->scx.slice can be refilled */
            }

            ops.stopping();     /* Task stops running (time slice expires or wait) */
        }

        ops.quiescent();        /* Task releases its assigned CPU (wait) */
    }

    ops.disable();              /* Disable BPF scheduling for the task */
    ops.exit_task();            /* Task is destroyed */

Thanks,
-Andrea
