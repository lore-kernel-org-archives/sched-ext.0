Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC839185D
	for <sched-ext@lists.linux.dev>; Mon,  6 Apr 2026 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775502548; cv=fail; b=UVfH0jrv+cPUDA6EXOKYVYlv3H8CeUKAY4Bk8ND2mL4GKaPBQz1CXfLNIODwg6xO+nv7Sfmt8YgxbLaE0FeXI1+Ftm4FhvImuS2VSAoDJU2alBQKnjoWWtE90rgHDtiL9HXrmxhsetHHPHMwi6OnUwaroirsdI0fM/HjfLT8q/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775502548; c=relaxed/simple;
	bh=TSRydsG/ba5EiYvzpubzqFQhnhDp3S2AtiGUFQx3j9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEHou28VLmxhdooTJAkWXbmn3P1vzjZ2sEx6nsbacOwOxDWUv0SK2ovTsPbImTNZKPEkf9+ZjyYQqJUgdUNa8JU80Y+OMOcKzNgetVLPzmwNkvcpFlroQw1T48HeIRTkpZ7s19v6OrP46tHaYESzgpFU5w+O75oGZjSg3vuEMvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oPRYO28i; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oPRYO28i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQRemQAQIRuNOhCMxt6WLUQu6rf7IOIwWmgI8K/A4z69C7zZYaTO6dS/0CzlNMe6C3QvGpoRA62TiEqZLsMMJ1t1fiGxhfIptg7k7IvtUcVuzHfQOwKPrU/WEI0MTtXyblQ8uX6oTfFo+ARfCDya5HrTEhOWkOGNB9a2ZRmdzG7855AGHTZ1rHO2ZW02PC/st+vbylyXr7t41HC0afnD66dGbe0dbMzqhA3ue4dfalIw1acbN32DSBhsdcxDwypDSNFcNLanTBw/12m2mxLcsaFLwDSxO34SiYr+TjFvdCibr5Mml6zOZri1e+TCuRoPFPcJRYQjRrczoud3tBC41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjKu3IGeDT3Q3uTrsfofn/867L6zzS8lcj/K8mBrA9o=;
 b=I2c/7hWg72qth+7UrC2sv3kRTvQvkG/cr5uorRQv8HMrrBkNBmS3YiL2FCFXS3BU6k64O5DuzCpDbicm2XxrZfCmEVgj33affwx/MSWPSpzZMLuURiWWgfI8MiTfsaJzwJpq5lkdCQ/EIL3Wi73SaFlwhn4GAOSsSZjFbeWtRk7r9mLqkgN6tqBYESQyj94zQQ8TFUDHANrGtSO5uO2ReCgnPdAJDA9whap36KHgCe3HSuqfJwYDMURjNwo2jCQ0strckup9hks9CKZ9pC11vXqng4SquSYq4FzWDderhP/5ZdtiDQ8KTxcZ6RYSPGEdjYk+mIHuZLnY1Zg9UeOE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjKu3IGeDT3Q3uTrsfofn/867L6zzS8lcj/K8mBrA9o=;
 b=oPRYO28ivyA6YtuLXnKPfFP4jzg3RhAKbL+mitg2QD4QME6ATayPin9o6gUQDBBfge3hxTCSWg8CVLtQn/7oKfZ9IytnYQ56h+jdAOi3N01sVLYSWoQsfAaFV8kiL99KZBSH6EZc6M1E6vnQ0NUL9Ku6Zr78y+43/oOBjKI7aMuhRN+HvGcGEUqGsbaQ01LbA7IwHm3UFmv08iMV21AZ2fIWav0g3SdswU2U6fuiA7URSjnZyGW7mVbO3T8SoUc5h4PE2moTZP2fn9fS0pxY7KryC16U2gEGC2Xm+OItcGZ3BLOhurPo5WtSbhp5jJ2l1mcEyQg+4h0phIJ9FNhfVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 19:08:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 19:08:59 +0000
Date: Mon, 6 Apr 2026 21:08:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add
 ops.dequeue() to task lifecycle
Message-ID: <adQEw0BZyXDDU5cD@gpd4>
References: <20260406114755.840497-1-arighi@nvidia.com>
 <DHM5LKD95FE4.3WR8JAYD4IGL@etsalapatis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHM5LKD95FE4.3WR8JAYD4IGL@etsalapatis.com>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4a70ff-ae2f-4914-def3-08de940ff4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WTgthE3z0Heb2F1NKQMya3Wl5GJNZnejWvl3cTjonfMcq7H5Mps4aNX60ezMyCtgtX3jwmahjq31IykkwXQhaw2DfRQfN6dQJtwgFz+bkQAZiOzEa6pgMh9JmWoPHAj6aHcCxGuKWgZT8J2ZBJkVkVb7uXScnHeXV2zYxf/JDeIeHUTiaf4QGajxZizQTqkvAf7bC6KwwGys79e/ZRJDZzOAUcKvzrN+oRLRbDwBnsHiTwUqS/B/0au3H7wnrYGlQJjjnHKt23BA+mQ0ebA6OHAY91CCVD4NbgzqYS4VqOiobUqtWMT+o1KpCjGvvignIZl22WOHZsBreuibSwwiwOeyRi0MXrSOt8KopgF5sBlQs3H1c1Z89ozsKqqKvKHrZNh3tVja7Zb+889QPVF6lJxfGEr607smnllnGHSBEmq6vcFnxb23fXNqlbiY6MykQYOm4PrhbBHqrMhTM+HXXjwmiHSEcPSNReu04TknLRjHMUVPbCl2s2kQJw+H7eXxUxWw4m2sF3PDVylA8f0VLL/mOLaJVZzStKSXH6l0UpMcZ2IeWIOxpC2ixNd0a3R/nfTtHJidg7nJCQQ1nh/nrcUSK7LkrZW96tEIme9bF+dA9uLWOFAywBHN4qgbHLgnBBbQzWdrWeFx1cUmS8kFvyT+fXqy0aqOl+Ytf6qAqBu5NScc0PVp8H+Q0eueHsMaIj2iXferEUIsKeFtJ2kFj/KtgAjfHjmcYyvJc7sbCDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iKh96SZVGkq8D0hsSsBxjYChL5gtTU/ptZ/seO2fBcUOgrfRFqVDIpeFqs36?=
 =?us-ascii?Q?+1FSk8+DwfLBj0lKciDDwd+4zLpOWOxlI+u13EFxw2exhjApsPbtOImwuZds?=
 =?us-ascii?Q?oNchlTw7JEU05eW8p+G3dg4h1r/jmkUH4WiJalVAt/zbV7xIPK1lb6gP+s1R?=
 =?us-ascii?Q?YyRjJfJeww2H7XkIJ4zvaFegVcUN7cJrwYzZR8H2K8OAqd7pcwybmnQwFGvS?=
 =?us-ascii?Q?JTuvGOMhTA3JBOb+Qgb8Vl2A0L7QDloSQAWAmxEJIh+GuD3j9B7IWVUyj1Zk?=
 =?us-ascii?Q?3H2qfq+/89W9ARzkVRqCHN4xApUXhBSDP2LvITQzzNtklii6JrnqiAe7uTqc?=
 =?us-ascii?Q?24tq2M8Wbu5RRvsH1BlvyhJRqCmPthHQlg1fJ+l0yxiI/7zW1rzJ1M9Dtff7?=
 =?us-ascii?Q?BdtxmllrYAqZReImgFT97KkrHWs8Jgs/wDA/x9og4i51k1b7O64iPROzD611?=
 =?us-ascii?Q?3UCyowR1r7hIoXLsUKVp/FOJeLw9rXY2BgCXzWqdx7r8BmAjOBxX+mQSwhBL?=
 =?us-ascii?Q?560O+dAULHraYydaD1Fn53KnH97bGtYFjLG6YZiPh+36LQSiBVrRwywywFnC?=
 =?us-ascii?Q?i/5y/49sdL4eZCB2NlTLQZ2YfflM6dbfoqErbxkT2o15r3c7sZUOY/xtPv3t?=
 =?us-ascii?Q?5mi6mXuGVvLIsmbiZ1Rp+r4kNzj3nkU1nEkw7qCsGyWRfKZ249PKaV3HSSA+?=
 =?us-ascii?Q?AYTwBf47c9SO//Bv8VyKIaLL3RMl4/pwrv4yEkP5J6tIxBh53/8Y6twwVwx3?=
 =?us-ascii?Q?mnazS9JOw8tCrehZErAOJsC1sEm5nlf3OtPn4udWf99kna90EKWjAHk3b8kG?=
 =?us-ascii?Q?DTxnq9wSAs761KbYFJrprY2QAkWAvSF3H9R7TMCRa9uy+LZLHYHlcBP3oqvk?=
 =?us-ascii?Q?3UMBC7A2znHrPheu1KXHnfMXOeJcdD1UAzFyfPxQLfYRrm/fTy9TnNPfPlGI?=
 =?us-ascii?Q?gvoresGqte6y7O/g58XnCX6iDs/FWOv99cb0Cd9w4tcxqyekNBdK5wJAY3ai?=
 =?us-ascii?Q?m3iom2iY8eGK7fDl4/KKLqf/yJWKOwTb4i/U/Frc5jvbhQzAWBS2FrEXi56L?=
 =?us-ascii?Q?q6y9K2FXgElSomDkt933AcUiz0LQmptugVh0TOpjkqZ/OXftRjFw5xw0AeXG?=
 =?us-ascii?Q?roejIUp2DeFlOeehlrxBafvp/nG4xLlrH/oQQ0TJAhSVh+Cu6zsiZC2f8Kx3?=
 =?us-ascii?Q?Q//h5nMErU0A31ni+N/wNtaXVV3aCDzskHUxoYvDI+4UyI32emIOVdtIzYSu?=
 =?us-ascii?Q?HnW7LTVBasTZQ9sLeOtHk7Mb5+OouUU7QorZdjJL554HAbkSyehKPL5h3C5T?=
 =?us-ascii?Q?fc/66C2lcPpuXksL3+srHSj0HkhD+4DgNDsoa31+4BWe5lMiTxm2mcXxNppZ?=
 =?us-ascii?Q?9Slc4S8IafTi7Mfl2YzABl0IHkCEoHk3YHh09DTYJgbSAqbmP4bZTIARD61T?=
 =?us-ascii?Q?5eCf+eTUeZu8OhSx4iho+8UHl7nEYHxveHQgMVJAMfB3FH42BrmLMmEnxJor?=
 =?us-ascii?Q?EJBwCelQe5jP5n94dGBUpJOq1nniGfpDTTEk7Exk+p0sXuT3t+Nim+0dNec+?=
 =?us-ascii?Q?wdrE/xKts81M81FBLR4WBrHeau2v7YrU4bXJ6x6cjjphndDqOiPIOxEv16Tp?=
 =?us-ascii?Q?Ls1kmWYSaIJfQ7xJjdzzLda9FnSdGAvv+pjPiEuZ3K/6kp0eV8WU+10TwKo8?=
 =?us-ascii?Q?k5F9Nu6ND9bwbG5aGBQTiXcjrtAiOnkDLEXBORilcOcsobljEtMnBOPuldfO?=
 =?us-ascii?Q?vV57VecfyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4a70ff-ae2f-4914-def3-08de940ff4e9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 19:08:58.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcnze7Po2l4iUZZyoqP5R2vCVOkPQw4KttxBmGNhSnaIcSlExfO/b4OaqxJ/4Q4bfWAXOdmcyNYVHCJm2KA/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

Hi Emil,

On Mon, Apr 06, 2026 at 10:49:18AM -0400, Emil Tsalapatis wrote:
> On Mon Apr 6, 2026 at 7:47 AM EDT, Andrea Righi wrote:
> > Document ops.dequeue() in the sched_ext task lifecycle now that its
> > semantics are well-defined.
> >
> > Also update the pseudo-code to use task_is_runnable() consistently and
> > clarify the case where ops.dispatch() does not refill the time slice.
> >
> > Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> 
> Is the Fixes: tag appropriate here? It's not like the original patch
> introduced a bug by fixing ops.dequeue().

Yeah, the intent here was to make sure this commit isn't applied without
ebf1ccff79c4 (otherwise the state machine would be inaccurate), but that
shouldn't happen, so it's probably reasonable to drop the Fixes line.

Thanks,
-Andrea

> 
> Otherwise the state machine looks fine to me!
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
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
> > +                    continue;
> > +                }
> > +            }
> >  
> > -                ops.dispatch(); /* Task is moved to a local DSQ */
> > +            /* Any usable CPU becomes available */
> > +
> > +            ops.dispatch();     /* Task is moved to a local DSQ */
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
