Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B635A948
	for <sched-ext@lists.linux.dev>; Tue,  7 Apr 2026 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579505; cv=fail; b=N6x5aFl1FFL9TTaBxXGGPkormXidlIAQEzWLpsfRaaKT8/1mRKIthnTQaaZhfx1KM3BUEVGbMjPkEkcCDT4H+oXcyIUP2EKcY1xNvC/cdLic5fRntjnnKHyowJPy30AjZtSe0Z4ImTHp+6bM+CzWmKZeM6ptbhwTr9AwYfXNUxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579505; c=relaxed/simple;
	bh=Y3bqTr1/ExrdzCA442Hnyrtn7wK94Dc8NLKHLiX59Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FUE86+zM4khz2Nldm82NMGLniM6ihb/TiafjpS4MlfxqYE8dtC/osJiBroDa0CUNdQNNaCVeh5DLVpc0NofXkYnGJgOLJ//weJQllanxZ4LZYc/x12mFOMjIzaTF5fGfdgw29AK5OeNybl8WyP3l3a6O7YgXTMwDYqUKm8gypTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZCt+CdB6; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZCt+CdB6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOYRRAbAgIetNPZwUbfsBJmyerOGI/olzBA5iBYqgPFA0eh/bk1T6EcaVaBE5Tmrzazk+R69yFs2LtI39vBAB4IyRbd4wgcBCjZmEejJYYiEIwZLDafKmGA50qxwUu8vjtVvvpjGF6nwiYmHzqhUr8ZDZ4kd1t8FYTL39rE77AyKppGu6yjFbJBOsimsLhjoM/4F7WtodMuea8JXxmVSBg9Pu+zW/0eaKr82k7uyMexpYYDdQvNyHCAps2GkohYKPkLadRzuUQE0PiaxWsjreiBYqDHtwOF9Gd4Vn00/JeF8+XibmPkc8OfUwDgcGkymxk4TJY1SOcuI378Cg1o1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxnKVK9JLwqXh05DzYnt7zASU1S4dewKOe7Lj3sgEkM=;
 b=ZTiNc5ntTYXSzqELeavZqhREM9Ml8eerS7i4tJ+3kyxSRs3zKNlsQ6rluNTkuImGo+z+ryod3ktIxGFCrfyuOiMRJVrk463UKvZZa2jf6vKOwA/Gq3ce0yySb4KvuEvK+lRhHnMI4+2RqX37YOFLQeryTnw5tT6ALtw3tmX/D6goRls6wuqN6tAzfNHLvhSleKYuNXd1F+lEmvmSd1RmWby3wiTBqS7tcJ+qtPSPqDEKX10MisDfED2rtWbZF3XZ221gT4w66GnIgKeAgSq5gGlyYVsDnKrq/mTa8qGv3eN4vzL/l1tVefHWCjVNepprvQXvrZnjyo3fLNQZAjJo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxnKVK9JLwqXh05DzYnt7zASU1S4dewKOe7Lj3sgEkM=;
 b=ZCt+CdB6y9zvy30l8WnZn1H+nGJ5sPgzhFbRNz5hnHsciOn+eIioPYTAU7Bot0gbmAWybJFzWcjH2fnZMD3fKb8pIWqXJy0Usi0a/69t6fUgLZ9WqAafpNf58MMnl2XIaIF5pTYsMBQY4FkNlK6+y5vKbjxTL/HH+hc/HvMhbS0W9272fnM5dSdM119FfjH6bFeSV/MH2mdxM441xSfUNRrUjocFTZkiuTKeGTtw3sDCsq+LCNu8T8H6whtgWE6zt1c0pTOdDIBhW8rwDX0Y1DRMeFDtjs0x2eg/UI3gkUUD5qFoxFZK5/XUtZWqtFqXht6rt376iFcsYfWqoIegPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 16:31:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 16:31:40 +0000
Date: Tue, 7 Apr 2026 18:31:35 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add
 ops.dequeue() to task lifecycle
Message-ID: <adUxZ5Qp_vH6cBZj@gpd4>
References: <20260406114755.840497-1-arighi@nvidia.com>
 <DHMTYAUXLBZ4.RTEFCELFZ0J6@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHMTYAUXLBZ4.RTEFCELFZ0J6@google.com>
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bc92a1-c7f1-4183-2fff-08de94c32539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZLWkepzjL/DK4REf+5L5MY9r7MqvDgoMUj0ApDbiAQ5jjKfy32UA9+BmxBqpoNTBP6n+d+Hr+XQLjwuw9SUrtI2IcIS6G/6Y8buu4aZnkZ+R/AFRTExHUlo7fLadcEfR82lumQhCfmmfD3u/22/i4uRBQvIemOOiVq2cQCBbACKPd+OL/+rkDjxMUgXwxHFQOHsdmmrhinz73aCKVYW6Iw/qrqkyNKxND45MHMFO/NFt1OGHiQY8jSdau8ph6vZuin8FQHrAjvpn6uM+iYqx38O0x6FRH5AP6uxjJk1dlXx5pdk2C6+KXISytqZVLKhU4arLKWrQVm+DZ6kVOkJWRsBr9QZgvqCe5aQLjchfgz4NDY79Nz8SxkYkPQXo5IMmr2yC3QV1d1Ens1UzY7dy3W3cflAxjeaZJl5rbeciMZ64K9IJueARv35y79oTVlJgSR2XO3uNG+siBs92PygPRfDUhE5kws8XVlHecXhnxdm4ECesrQ6snJE+VceaMapjfR88uG1Z5pWUaWspmRLquAjT1KE4FQCG+9aayo9TrMBIij8kBpqiW+85Ye9dCwI55WDAq3OLok2punNv3Fc9wRh9ZX34gsi2TvWIsbufuvJRAqAGCEzEqpcCCyFz3Qsv+mtTTL4cmQfUyiLx0IAAmcpD8tiqLgaJ3v7yS0tpjh1CEDjtbKmVuWPWIsMNWHfpAB2aKGhVQQwDBK70Is+ay5ZVBSe3k+Uxu7nSSaJC1e0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ueoX7agJCAbosLxO1PAehRSrVvJHGa8j5mvJMDAe9GJno9g2nHZTvm14OW/?=
 =?us-ascii?Q?se4DvB1YWNmUL82PHqAdDdTYEqTzaVK39ahQL+XOh3xPyFgFC+8ckfZwpiGr?=
 =?us-ascii?Q?Ft7ShVf0N4EZuDAghkC4XEOrzx0EZ4/rVA3lC+jHyO1kG5oR2Xo9xMIBx5PG?=
 =?us-ascii?Q?tQZkupTy3vw/PgYrP/KBdlNHfo6nMUBGL1/j+uEjNLkGKOQxLHmtocmEcZxC?=
 =?us-ascii?Q?TUlptlkr2dmHy443ECyu+pyAV9YK3xmYyEsGVpbZTYwFPO/q7NH2xWoxWWzT?=
 =?us-ascii?Q?uzh4L8jfiXA/L61QTzF3Fh35sMMhLuzLIkgnpI7Bt/+RXsqf0JzkqBSk+ILD?=
 =?us-ascii?Q?T56rzZHXqlxq/f4UC0NCDp579j24AtdjZrZ1OWl2mwnSAdR9MOBec4WMAlC0?=
 =?us-ascii?Q?6grio4xaYVu6LbGRf5gyICOgO38ppz2ixQ5UFkYdi/eXlFta4X/Qhlmk5Inn?=
 =?us-ascii?Q?ABQ8lmwlAzR+dvATU70h7JylyWditQGDXNBuD733DsvgapEH6kGoXEI6QyQL?=
 =?us-ascii?Q?SLjK8f6uYXCcZEvdArInS1lwcCStmVjtANzDGL7cfYePeqiQCPeubHcsaTXi?=
 =?us-ascii?Q?oEbygYCWjHpWSBUbbLZWvxELv65AnUL3WhshbPlhMGscnD6QxkKme7xDSKvs?=
 =?us-ascii?Q?mbyOgG9UXyEoOFywcUNifuvS3pdtToWDzPtFA+EFcujP8JqiuqJFeFyL/PLM?=
 =?us-ascii?Q?g+hsD6yaGFkhncOVbiu0sQ6r9XJ7ZEzmYOVamYNNw9e7V5tsGu418YuLlfKm?=
 =?us-ascii?Q?Q8wuMc9FxgsywlqukiwEHX+ulLVGlyTYP482ZPNahI9ATRZ90h7t5DYb2a9i?=
 =?us-ascii?Q?A4Wz/1EyB+vmFeiMbDwt+ZGc57IPerMUka0mlrHkgdg/Iwgd1fDqevf5ecX2?=
 =?us-ascii?Q?aNKyVEwAe0lCST8jdUd2lje2/Ff8vq6iCpHU+/4yzmCFl2I8b/Btf3h08C5i?=
 =?us-ascii?Q?Q15AQ0wx4WulB5d7wZe8PJEeQWYqA/3OD69vbzHctZndHxIY9sdGvI6b7TFv?=
 =?us-ascii?Q?G9uUAHxwFlkxiZMeU9X+dhxMb+DyjvIXaUkk3UKudqWtd1/vrws6lyFn/teo?=
 =?us-ascii?Q?0Xqnt5UqZEE/QZ5YHlE5xmN+Ldnhtqp3OlL+wMjyosjbcxEy2nT9IJaWy2hP?=
 =?us-ascii?Q?3PCXX1jIgyD89xw3jo57WVeReI6u81azaO5SwDbkW0Q2B5QEm1H45ZgLpKZC?=
 =?us-ascii?Q?A/Ysgw34rso8lEFaqSTrqivvZVNqcXTDYjxci3EFRfEarBRcJI3tNBxm6L96?=
 =?us-ascii?Q?kz3OBp0+N4U6qxOMavvI8xCXRKJHO5HTW3/cJC8r8ppRMrCwGw1Q+IOuBslu?=
 =?us-ascii?Q?cQ6ZajOaGz68gvNQjnBrop6B9EZN0RbYatEaHeJWBJB5g0V1gohTlowTBkTT?=
 =?us-ascii?Q?rp3TC1xXgwDnIHy08ws4QPhoD6/lcOufMT8wL5tJTJb2xkppZUJOoxnEDwXj?=
 =?us-ascii?Q?dmthGfvjMF3Vv5P+y+oiAZzGeOFTKoLG7aXXRLI46lKVlWSB3IVDbLI2dgX5?=
 =?us-ascii?Q?zwvjJ5t9zwLPjbdVDA++p60LYgcfJpAIOn45NXbAYGs+UM5CzK5v8dMtqKAh?=
 =?us-ascii?Q?x8b0rCSqbNCvqx7kruAMPgGxUm3squ3txHMebhdthfPR66U4x5C7IE8H2e+3?=
 =?us-ascii?Q?WYxpGqwf5MMDKhoxSsJ2zU0p7qCWo/I5bL2i/mx3hlPRzvMgJelurnCvFOZO?=
 =?us-ascii?Q?FH78V2nFjF7vAbtqjUqL3leRZCFDmIHdKnGD38jLRmZgmJWMa0HHJJdS/aKk?=
 =?us-ascii?Q?eh/E+Ruf8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bc92a1-c7f1-4183-2fff-08de94c32539
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 16:31:40.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcY9lsRUd/EO0HOdVTTzR1FpcrDFh2KcmvVodk5TLA90RBxxNJUNJYkflNN1AcJPlxcFuMh6ckiom3VS3PhZIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648

Hi Kuba,

On Tue, Apr 07, 2026 at 09:54:22AM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Mon Apr 6, 2026 at 11:47 AM UTC, Andrea Righi wrote:
> > Document ops.dequeue() in the sched_ext task lifecycle now that its
> > semantics are well-defined.
> >
> > Also update the pseudo-code to use task_is_runnable() consistently and
> > clarify the case where ops.dispatch() does not refill the time slice.
> >
> > Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  Documentation/scheduler/sched-ext.rst | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> > index 404b4e4c33f7e..9f03650abfeba 100644
> > --- a/Documentation/scheduler/sched-ext.rst
> > +++ b/Documentation/scheduler/sched-ext.rst
> > @@ -422,23 +422,29 @@ by a sched_ext scheduler:
> >  
> >          ops.runnable();         /* Task becomes ready to run */
> >  
> > -        while (task is runnable) {
> > +        while (task_is_runnable(task)) {
> >              if (task is not in a DSQ && task->scx.slice == 0) {
> >                  ops.enqueue();  /* Task can be added to a DSQ */
> >  
> > -                /* Any usable CPU becomes available */
> > +                /* Task property change (i.e., affinity, nice, etc.)? */
> > +                if (sched_change(task)) {
> > +                    ops.dequeue(); /* Exiting BPF scheduler custody */
> 
> Doesn't the task also go through quiescent -> runnable here? The full path
> being dequeue -> quiescent -> (actual property change) -> runnable -> enqueue.
> 
> I guess we should be accurate here since quiescent and runnable are present
> elsewhere in the pseudocode.

Ah yes, we need to add ops.quiescent() and ops.runnable() here. Tejun already
applied this patch to his branch, can you send another patch on top of this?

> 
> > +                    continue;
> > +                }
> > +            }
> >  
> > -                ops.dispatch(); /* Task is moved to a local DSQ */
> > +            /* Any usable CPU becomes available */
> > +
> > +            ops.dispatch();     /* Task is moved to a local DSQ */
> 
> s/local/terminal/?

Technically it'd be correct to say "terminal", but typically we use
scx_bpf_move_to_local() here, which moves the task to a local DSQ. Then it may
fallback into SCX_DSQ_GLOBAL if something goes wrong, but, from a logical
perspective, the intention is to move the task to local DSQ at this point.

So, I'm not sure if saying "terminal" here would be more confusing than
helpful... but I don't have a strong opinion on that.

Thanks,
-Andrea

> 
> > +            ops.dequeue();      /* Exiting BPF scheduler custody */
> >  
> > -                ops.dequeue(); /* Exiting BPF scheduler */
> > -            }
> >              ops.running();      /* Task starts running on its assigned CPU */
> >  
> > -            while task_is_runnable(p) {
> > -                while (task->scx.slice > 0 && task_is_runnable(p))
> > -                    ops.tick();     /* Called every 1/HZ seconds */
> > +            while (task_is_runnable(task) && task->scx.slice > 0) {
> > +                ops.tick();     /* Called every 1/HZ seconds */
> >  
> > -                ops.dispatch();     /* task->scx.slice can be refilled */
> > +                if (task->scx.slice == 0)
> > +                    ops.dispatch(); /* task->scx.slice can be refilled */
> >              }
> >  
> >              ops.stopping();     /* Task stops running (time slice expires or wait) */
> 
> Thanks,
> Kuba
