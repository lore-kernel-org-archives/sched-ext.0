Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7B17D6
	for <sched-ext@lists.linux.dev>; Sat,  7 Feb 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770456386; cv=fail; b=eNMXhUBZRQyevUEKzSjDAss2DUxoorYqdcwLipKmCD9+LfQbRbrPTFRhb1zKGLGKq6LNM3qPuadCL9a5IwiDVJelYphenQD0IsXRDFk2JSLxNvnPFYsWA/AaK7878SrFe0qfmUhWCykY+l0TyVLcmFWSEolLU2UJUCS/kwAKC6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770456386; c=relaxed/simple;
	bh=NeGxd3qjlB/4ht2wfnMdVSU20sgYkNyAU4dlDbRgzZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DKt5EyVJ6EgclXllc6TKtpMFeaNBplcnNqbj0tAFhtOuCR8Nz0n/im22JmbmGUSUONq5rFCTfquY4BNBrXEuRgpbBpeu3hq26nJDQThaF3NgpHeG/5tE2Olwr9uOAaewCQPJOes0cbILycpCHcqAm86wzcF0/Ro+9nJ2RXCFE7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TzyulnQS; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TzyulnQS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNUNYNBIA5HMmiUtTtaE3ENMpq5K62yXwcDEQMCzImggNmuMiKJ/LMVI0xBUjdb1EqtTU7NHpiB4LD1aejR525sD95m51ReiHz3aRxVUuetCEUWHB2P9rEblZxMztYrL07ndKheNL5Tf6XCOh0fWgTRr6R06S9pRKBStmNg/Ano49y+0ehp8KfWzrYdDBmvcGzyaCqYpzu6tzIsbfe9EWLoP0jrrmjpu0Oe1YdFp13byJBqJfDkuCbkPKefHisHVulL53sqC2nT8TFn+RbFpMDuikb9kuE360rbBS3HUQ5C7O3HeKSEQMdme+8HuZRZlRfVc0WwEGhPx2jahopQljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6T09UUfRktfCmWU1U6hRjzcd6mnidgLnSBj0IPwBHE=;
 b=RZ0h7tg/KikzodNpM/WGE+nEB4/VrXQ/QvZRylaTNrqNyifKEFtT1hrhze5+XPjAnFucq6UsjkzN5Dhcn81k+JvIPQMREvdjv+kwpxQuENdCCmVrXn8s350oCBDZ3V4fPv0LkWyEHush6SvLyJRI2LOeA6ooF6taITk9sUtg6E56kYi4Zlrc3/sYxpo+IKGMYLz0dQsFEdev+ruQxQcvMTFYMHivBu9B6SvJwSP0NGR5VlCVgJ7c5wLTn8URdIygWQRli23Og78LKT+Nbt9kckocuoLlBTcDFJJb9ihl2z8Nnq4Ej3XBtYanF0fTpU1moT5liytkkUHExQf0J57GiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6T09UUfRktfCmWU1U6hRjzcd6mnidgLnSBj0IPwBHE=;
 b=TzyulnQSWHbF7bcgdcQnKPmhx4PmwuuOejdpX8CZeFtrMb3wp4ece1o1K4kqkuGexyZ9DXjq05hsWRr7pmNBpuB59EnbfYHrUHhRvc9GGjQeCMWpAS+W1nbLYItGlf/ZnZh8DEpOnKrz1oQOAQ17LorV4cZpNWgHxrVbph89V2FA3sxv3fja+HdSuBcOEydRuk73SNzHuf0dOKEuVdBu3WKK3tY4dV2sjhF3KvO86PDoTB8AgECpqhutxvBHLjBBBDasrfyEKzvtqCc1HVUy4UEKTWFQpGgqvXP4BEwk9c6LSf07v7dqx5Gr7/EFTlDnzCFOdXODutD7BbToGEIpQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sat, 7 Feb
 2026 09:26:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 09:26:20 +0000
Date: Sat, 7 Feb 2026 10:26:17 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYcFOVlJhUU5huNd@gpd4>
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-2-arighi@nvidia.com>
 <DG860JW64VVD.31BS2QTEB8XZQ@etsalapatis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG860JW64VVD.31BS2QTEB8XZQ@etsalapatis.com>
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 77267c63-67c1-4c3f-89c3-08de662af3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXQXafH1ZEaJr5IwZSp3+XHWuDDHBzqhqXNxax2cdT1aSMKdNLunEDSJTOJl?=
 =?us-ascii?Q?058n/i4zIPs4PomarIrs/Je5wyG2gCupYC840vMhSn9cZaCJ+GViLWVRlqbD?=
 =?us-ascii?Q?vuP8UfzDF3IJyhSMNl9uJys96Q42xkP1t2nLJhn0q9RCD2DKV631U9ZBI3Jd?=
 =?us-ascii?Q?BsOTV/51BtJjqfU2f5RVUMZ4TIkcX0yxPt8P1kYIZoaPg74HvAlxEnfFzvdX?=
 =?us-ascii?Q?pk/S1amwnmnSEVYAnNXzafEsoODuaptW6lw3AO66MpalikYZWTLLNPjPi2Oa?=
 =?us-ascii?Q?xoy4V1lC/z6Tw00ql0th2/xBEvK3JUGwaJ1EV8gAG70/TFZVWPkFYTlN3UEN?=
 =?us-ascii?Q?m/HsBDSOYXY8YhrkEreR7IR9MFIkvkm7fAhjmTOxJsGLp2LkCBpPzU+U+wVh?=
 =?us-ascii?Q?NAIQkZn6e88eRrj+G8NDLss6hSbzcLNuZ3uvaMB90/ZI5ADZS/B8LfCXYtUh?=
 =?us-ascii?Q?JCaG9hWb7+e3fTHnLKH+i3I8BEgeEmNo4k76j62287a/xFml1mt/M9BA07CJ?=
 =?us-ascii?Q?ClyzHsGOzu1hjh31v41Pm6bh1Dh/T6qm7VzvbCw74rLEVbidlnjeOC9qwEC/?=
 =?us-ascii?Q?9m7rPFpaHyKp5kG3wgBABy2JjWyBiI6orJT+I75wc6ACtwcerpdhqRJ2pHCZ?=
 =?us-ascii?Q?pb10upi7oGXSakb8ULiHu3b7bAv/SFYACR9NArZPDp0tRtrgNqtUdLRPTfgr?=
 =?us-ascii?Q?yTJOLEtxD632wT+U2nuHgHfT82zclPOysXS7D820phkyK9+QLmqFNDqcwaVw?=
 =?us-ascii?Q?9UsprZl79RcrNhSB8iuAFIL6Xg23vJBHezLUPJF5QReGncE9HT6muEQXtlkX?=
 =?us-ascii?Q?83N+H9wChYKl2RwZGZzUfXgNZxXMrZlwsPwWqatkAtWx6jchMLZkbqNyjHTT?=
 =?us-ascii?Q?+xPD4p65KqgJkmtN2iQpeMvvvT/y1eqEn9NfixECDMvdW+/Qnxn+JBTOMyaz?=
 =?us-ascii?Q?IkvABm91lRvSYiiJ2bu7gDiadnm+INB1x/toO9Wz/toCU4fGKGGsFtvwijFi?=
 =?us-ascii?Q?7ZXttChkF4MkXlM0eIjYfLBZS2X+8GuRIZ84yVDo2iNYD6qdFJ7TnNAhLKMb?=
 =?us-ascii?Q?qm+duFWT0SnRQTvu0QWomgNjY1Y/VC3Q3Kb/cHU43bY3QclWI55KqPRnb+tC?=
 =?us-ascii?Q?cx4G4FTDM6hcQSmUQ9ajGnyqFo4RFsoOZkG6T3E44jWs4JIUV8WHaodQxJtd?=
 =?us-ascii?Q?r/d3wA46afY9iS/EfePn6FrNGOGG48nIcuuGbGzxyPHIX15vpm9HPa7dxMMv?=
 =?us-ascii?Q?O3JZEkMx5x2qXLcZdJKWA8Mx44fKreV7LxDmsuvR5ho4VvhJ7tJy/hYNrWca?=
 =?us-ascii?Q?A2ZgSy/M1KYxqQfyfwHkTlq6UnKUsBQEbTs5mp+Z3TJkGzGZG1/f3izZOpiZ?=
 =?us-ascii?Q?ayl25urlApd/01MinMkUZ8alyfXQ9CPYGgCPvXfth691TrXnl+7J070fbL0d?=
 =?us-ascii?Q?PEm1vM8HJpBYC1Tav0tMOF6h7zCi+N2xDHg1Yfuu17OK07sK0aqkzrdSablc?=
 =?us-ascii?Q?vxskRBrLsfeY3bJBiWpofSTSQD1GKgHuFbz184jMCyhG0ijH7uowO2w837bs?=
 =?us-ascii?Q?PDHFdP4/TCYpEkeKKm4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qdiB9sUX5d9ALDVFo35ZBR7cWVo8fNAzs3h8D2CKjzw7YOG0jSa71ivzXitc?=
 =?us-ascii?Q?X1E58CjU/t5q+YHdK8VcraGk4upRVmTF2uACGlfPnYr0nJvvxI/rioC8RwVn?=
 =?us-ascii?Q?ee8f7/NyZVd4pSQIH74D1Ge/1I0mrB0nsaH4NN03XvAyQQRsVoHn8m/CCpdf?=
 =?us-ascii?Q?kboPqNTpUk0XUy4UrDLYsVe/aRHtplQJoJOe7GHfFFXDl1NmLWaDjNHqNQEX?=
 =?us-ascii?Q?PFntspWqTr7WEZcNDHtJcihWh1EeocVATarS65hRIZSq9zLfi3KzKIEYz12u?=
 =?us-ascii?Q?U/bdpzd699baKgk0QGvt2swA0n01U6UDx2nz221h3LmyX0KlUqPVFqATtfgX?=
 =?us-ascii?Q?wBHRzWwpp+Wd5tAZLCHIJ81ZdjZmmHsnFN8hA0QvzIEuL5RgM4eaZUVYBaga?=
 =?us-ascii?Q?jvtpj10vOZWdR/2r6JO9rxo8GbW1Bd4PBHviai2lM1dEZUYGpMnEwBTg6t7g?=
 =?us-ascii?Q?jkWIsCDkmbBiW0kFHjqRc20aFVrFYx6rxPtCaE5nTySCAVtHnC7H3oQtSQGs?=
 =?us-ascii?Q?Lqe1uTqpDd2eI6ZADukHgA7/nqgLuCv9FUdNYhTZbHMQY7Rs4mx0aViog3FH?=
 =?us-ascii?Q?j+8CGzIbmDqaJRp7pGJ+s+S5xSuTlxmMpz0BdW0Gyt7rmlIn9B1v7Yq26Ypa?=
 =?us-ascii?Q?l+5r1nxpqSGYM/1vOwTRqVaFEzPBWNMSza/Y0ZbKUeLkvzJvG5ZH97j8mqF5?=
 =?us-ascii?Q?BHYr5ozgp0JIwdfoml5/rrvzReSzl3rrS303G206F8PCQUqkAYyIj3X095b0?=
 =?us-ascii?Q?f2X/ZlAWlpmqi+YpD2csTXIJd/cRVwETqt3BAlvjzV7Z/sR/gK3JP92pEZHP?=
 =?us-ascii?Q?Emeb6Fri0+XzYOZ32EUb3LAGRFtXAC4KP/UsuNu/lpZdhc3zIGDUp/SwtE8o?=
 =?us-ascii?Q?Hu6+g5HDHRif2CJBVGBK2dY4ChvHjx+7qgHQ94T46QtWxclq2rf/tFka4GsK?=
 =?us-ascii?Q?5/7ndyaiL+0FZuTWlDmVNE07utH6QCt3KK/UlcIhOfKp2zxEIxlcRm7J/K8H?=
 =?us-ascii?Q?PMXKAxqEeum41psrA/MMl0KlM4Zz1h8N6wt0tAJqq/p9ugQh3AyRoR4ahWp9?=
 =?us-ascii?Q?aXVMqXLubC4FNFAIL66pfaaKmv8Soi6kTo0YZU8myfRhMuj2tgq8mHY6F1ow?=
 =?us-ascii?Q?rdhDVSuQwRwulZkysd4xEa0g+iE6YLIIWpp+eT6RX3zKt+YBqAWdKA5MfQ0J?=
 =?us-ascii?Q?sY6/epnOuH2C69O29MOcAw47KSIjh7H2D6O7r6K3MgfmXv8UBbE4aysZBACE?=
 =?us-ascii?Q?t/8Crx0EUcn+lUmlgjLqsaPiJv2gnOlRvW1EUmfgiU5z9dTVagz4Xueay36g?=
 =?us-ascii?Q?5TCxazx5IN4aO+Z842EvlGQrof3T+N9GnhlsYa5f+l7UES+sNNUuBvEr2RyD?=
 =?us-ascii?Q?w3akI79fny0gSFUERXwXDJjf3R13KF5CJcXa1HBjMHR0ziTF4GX+PDtQOsM0?=
 =?us-ascii?Q?t8wu3+ouNTtKbWwRQQrp5EM/1OJP3HPD0rHmxFRt1sVaE9H5PwGtLZNwZ0F/?=
 =?us-ascii?Q?bRNqV1p+MvIdAUYQuFeYG2gGhgiBnlFBsNqdku3ATKfKzZt/+z33YrP9Qhoj?=
 =?us-ascii?Q?pyVJFiwSBboiaslSl3wHI9VB67xrdc40Kod/+4zr5aNaK3gdxMfBIgnlIGAT?=
 =?us-ascii?Q?GZXKLtPonWGnpz3u89FSMM/sS+xQO+K3IPfGhD//3NuVl0AAwvRTZkVp1sUX?=
 =?us-ascii?Q?d1k4CTjz2bX8bVmkH72Gt5GEfBYmCnLfZkMLP7Qovci2UmaI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77267c63-67c1-4c3f-89c3-08de662af3e2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 09:26:20.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXQD5D8cbRgoLss0FNUGUPVbS0/v3QfRkxdbsVRFidZlUT4Fbq2tBWXoo+7vj6K+Sk9P1aTIVGBj4X85yl7mBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471

Hi Emil,

On Fri, Feb 06, 2026 at 03:35:34PM -0500, Emil Tsalapatis wrote:
> On Fri Feb 6, 2026 at 8:54 AM EST, Andrea Righi wrote:
...
> > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> > index bcb962d5ee7d8..c48f818eee9b8 100644
> > --- a/include/linux/sched/ext.h
> > +++ b/include/linux/sched/ext.h
> > @@ -84,6 +84,7 @@ struct scx_dispatch_q {
> >  /* scx_entity.flags */
> >  enum scx_ent_flags {
> >  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> > +	SCX_TASK_NEED_DEQ	= 1 << 1, /* in BPF custody, needs ops.dequeue() when leaving */
> 
> Can we make this "SCX_TASK_IN_BPF"? Since we've now defined what it means to be
> in BPF custody vs the core scx scheduler (terminal DSQs) this is a more
> general property that can be useful to check in the future. An example:
> We can now assert that a task's BPF state is consistent with its actual 
> kernel state when using BPF-based data structures to manage tasks.

Ack. I like SCX_TASK_IN_BPF and I also like the idea of resuing the flag
for other purposes. It can be helpful for debugging as well.

> 
> >  	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
> >  	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
> >  
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 0bb8fa927e9e9..d17fd9141adf4 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -925,6 +925,27 @@ static void touch_core_sched(struct rq *rq, struct task_struct *p)
> >  #endif
> >  }
> >  
> > +/**
> > + * is_terminal_dsq - Check if a DSQ is terminal for ops.dequeue() purposes
> > + * @dsq_id: DSQ ID to check
> > + *
> > + * Returns true if @dsq_id is a terminal/builtin DSQ where the BPF
> > + * scheduler is considered "done" with the task.
> > + *
> > + * Builtin DSQs include:
> > + *  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
> > + *    where tasks go directly to execution,
> > + *  - Global DSQ (%SCX_DSQ_GLOBAL): built-in fallback queue,
> > + *  - Bypass DSQ: used during bypass mode.
> > + *
> > + * Tasks dispatched to builtin DSQs exit BPF scheduler custody and do not
> > + * trigger ops.dequeue() when they are later consumed.
> > + */
> > +static inline bool is_terminal_dsq(u64 dsq_id)
> > +{
> > +	return dsq_id & SCX_DSQ_FLAG_BUILTIN;
> > +}
> > +
> >  /**
> >   * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
> >   * @rq: rq to read clock from, must be locked
> > @@ -1008,7 +1029,8 @@ static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p
> >  		resched_curr(rq);
> >  }
> >  
> > -static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> > +static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
> > +			     struct scx_dispatch_q *dsq,
> >  			     struct task_struct *p, u64 enq_flags)
> >  {
> >  	bool is_local = dsq->id == SCX_DSQ_LOCAL;
> > @@ -1103,6 +1125,27 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> >  	dsq_mod_nr(dsq, 1);
> >  	p->scx.dsq = dsq;
> >  
> > +	/*
> > +	 * Handle ops.dequeue() and custody tracking.
> > +	 *
> > +	 * Builtin DSQs (local, global, bypass) are terminal: the BPF
> > +	 * scheduler is done with the task. If it was in BPF custody, call
> > +	 * ops.dequeue() and clear the flag.
> > +	 *
> > +	 * User DSQs: Task is in BPF scheduler's custody. Set the flag so
> > +	 * ops.dequeue() will be called when it leaves.
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue)) {
> > +		if (is_terminal_dsq(dsq->id)) {
> > +			if (p->scx.flags & SCX_TASK_NEED_DEQ)
> > +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue,
> > +						 rq, p, 0);
> > +			p->scx.flags &= ~SCX_TASK_NEED_DEQ;
> > +		} else {
> > +			p->scx.flags |= SCX_TASK_NEED_DEQ;
> > +		}
> > +	}
> > +
> >  	/*
> >  	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
> >  	 * direct dispatch path, but we clear them here because the direct
> > @@ -1323,7 +1366,7 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
> >  		return;
> >  	}
> >  
> > -	dispatch_enqueue(sch, dsq, p,
> > +	dispatch_enqueue(sch, rq, dsq, p,
> >  			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
> >  }
> >  
> > @@ -1407,13 +1450,22 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  	 * dequeue may be waiting. The store_release matches their load_acquire.
> >  	 */
> >  	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
> > +
> > +	/*
> > +	 * Task is now in BPF scheduler's custody (queued on BPF internal
> > +	 * structures). Set %SCX_TASK_NEED_DEQ so ops.dequeue() is called
> > +	 * when it leaves custody (e.g. dispatched to a terminal DSQ or on
> > +	 * property change).
> > +	 */
> > +	if (SCX_HAS_OP(sch, dequeue))
> 
> Related to the rename: Can we remove the guards and track the flag
> regardless of whether ops.dequeue() is present?
> 
> There is no reason not to track whether a task is in BPF or the core, 
> and it is a property that's independent of whether we implement ops.dequeue(). 
> This also simplifies the code since we now just guard the actual ops.dequeue()
> call.

I was concerned about introducing overhead, with the guard we can save a
few memory writes to p->scx.flags. But I don't have numbers and probably
the overhead is negligible.

Also, if we have a working ops.dequeue(), I guess more schedulers will
start implementing an ops.dequeue() callback, so the guard itself may
actually become the extra overhead.

So, I guess we can remove the guard and just set/clear the flag even
without an ops.dequeue() callback...

Thanks,
-Andrea
