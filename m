Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6A35BDB8
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071861; cv=fail; b=ppATUwfg46KXAkJshTJMUFBDv7i/gicTyiLN0T9RbG5PLnP2ccY2fGy4smKy7rtngexxuIIQbFT5gSzyz8xUttW9dGPGwgYXTAm7HnQiatjonLfGj6aG10VrwsO0Vfal2hpa+vKv47bubiGp8QrXilE7+DnCAcoqV5PB3W0emf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071861; c=relaxed/simple;
	bh=H6oh09EXoegRaW9Uqdqyjtt8Op7mP8M5R+PP8FPLQuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CwKqst+CKgHMWsO/nDPFoVLBL4aBfFLj3rejQJPtoZvqhCE7dt48DbKE/9xhNR9j7vYlpTIlrs0pSM5QLMwy8qFghPcgB1m8xBzpu5GWYntrMQsuptD28ad8iCR5HHWTBs2wu+RyhUwgN3jLdCHGB43qwlnBfOSDt9/QY88N2Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KTAyXhcb; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KTAyXhcb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSTxNVmOUcSM6P1el2rog1aaJ6E/J/Q2wB6PK6R9kmGapuGisAagXPAosHqAS0uJ4Ule4H+xW2agKnSEuIfNBm2YjY9ibAk5yulaUJ2zriFDAC5+thb7JjKkmNXUEsZp2OkGwdmTDyqmHmSY+7JbQP2ApnPzZnYXseXWvQpKf7w1cm+KcVd87aMvwgeHkCr9Au8vnBuz3jUCx1M+BvHezkIuBnggYJAvf5eE65eXwGJ2BjWpvukVV2mOa0OF/npNM+2ghCgrNSFiFY37B8LXPsG0nZJchBpZH6Z85L45pp9Dx8uIqAkIZ8PWXMhOqvz2AZU12C/sQrttOtKgJSgAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCxmPIzPkzNdHsAGCqGKwNgQp5tAMJPqSk4wWHUhii8=;
 b=KSIag9ikpwL5gBj/CL4QBQr0zeFDu56UXoqTSHCUAyIu96XhHvYjPVCOEjF22ui4FA5J9AyLQ8IgKlrFAfXHCHu8FWMVCa86G6oBHq51LVgMsXEUEed/DcGHLCzUBb6K7Ncmo3JfYdc2f+PJhhxPpAQRSeF3eGWACWdZy+mas6w3psWfIqAjUV6ces8YfAykiRDn2iifM3Uy9UVnkaOSea5t/lFyK0F47a3m7/5ztthr1olpur7rsKRCFkh/T3PNRV/BCQ2FICI0eYf4eiUD/BvvIKL9BME2XkOnAdAMz0OY0WRqiBz20ZPnt/3BbU2ettsfVLLkcyz8Y2W2OU01kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCxmPIzPkzNdHsAGCqGKwNgQp5tAMJPqSk4wWHUhii8=;
 b=KTAyXhcb6Ax1x4iVryf2T9llp+mHbvNQYS+vjv0wI28j0b+JEhHCsqn725XjoJsarGN5vsTgPMASvimoktYnS4FdURAGh2kUR4qS4FYHS/ptGOsAEFaN+dFLH045Xwuelf6SVYvOYh5Jz+JnAEJbUf35kIEjCt5wvle+p5XNQXe0HrhpqMBZGd+BZr6Bv4fKo2+Gp1HoB1GA+VDJxxBPZ8f8jGXVZCwCTiYVckUVH8Vd36sOwU9pYn6J1STq7EWtN4fX6y4AaHofPbz/ZAgCC7Znvbq4VqUBgwLTzibDT0Xf78cPlfO9aMqg/qs6Cc0MIrmBILr49KZM5EqXhEdgqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 22:37:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 22:37:34 +0000
Date: Mon, 2 Feb 2026 23:37:31 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aYEnK57vUwtgGXwH@gpd4>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-4-arighi@nvidia.com>
 <20260202211326.GN1395266@noisy.programming.kicks-ass.net>
 <20260202211723.GF1395416@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202211723.GF1395416@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cb3855-3a9a-4b3e-56d6-08de62aba8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UGUaiGiBsr4jahftWD92lcrcMRn4gK5kmwfYPcMsZxlwDPktBo49sNJ7DTvh?=
 =?us-ascii?Q?JbHBGp1cMT4on0j7C3fEbT6ls6x/ObYjdjSX3biWYee4qFMpZIoUUTxlllCV?=
 =?us-ascii?Q?6D0UBRkmDQG7UDqnExoUymIPAGJRRd7sGNoJGyrf0sWhN7pH/gC/lf2tKRPC?=
 =?us-ascii?Q?iORIIgN7Jb0hZ5DEVH+4xTvmbwlPmbI8yoFzy0ax7k5sxjYGpEZ2ZoOKP1Ye?=
 =?us-ascii?Q?R+ay9a2IF3NSXwqSKom54KwuH26TtQrtFaQLjszf27aWxKpUWs3wyAiQ5sO/?=
 =?us-ascii?Q?3oQox5Kwv3FWU06GCdVF0+xu8VUUpbjx0CBmdWyurTIhxrv91ATTez+EFf1i?=
 =?us-ascii?Q?KxzJ3/JXOYf0v93b8KzexaHyLwWf0onnoA+zABTnw7pMMOC+RIQas+b4Px5M?=
 =?us-ascii?Q?t404YneHsx/RSf5o0tMNeuhmaxsHOr2aAUbVWckUNAvXj8FyRd/NfvzPPpp2?=
 =?us-ascii?Q?ATOElnPgyH862nMJ1rG6wHVr+dVN833H2HnI6Rz110f5mkx10oYPgFikbC7Q?=
 =?us-ascii?Q?nedzR8K6CjgFVoM3CTGE3MnKPD+1f1yAp2UCEOP0CUEJuaq92mb0IuTTT0Ti?=
 =?us-ascii?Q?Hy0VvJ/lvfrViOUZR9OkdcvzPdw7pm0kPpmIgmznfUvg5HFFAoYguST2bOl/?=
 =?us-ascii?Q?OJEy9ORvgU0PYxrYbIVTyHGx2wlPr51UxV+QajSyPPdMdi1p5eW+6GXAjY4Y?=
 =?us-ascii?Q?5dUFs8+4sK9tgtcOZeH5yIoeyQ49/aevcVx5p+jeMdDYyfAMiFHqr+tJLZYk?=
 =?us-ascii?Q?Dr/l3i2amYmN+SlqItem/xFowGO/7oOh2AVgyjsifrSoVM5wHM/kjR7AQJK6?=
 =?us-ascii?Q?y4LJ/E0buW3scd4VczqRgybPNvPIzIkAAkkGXXMyeU/LchmIlF2eyYt/XbRo?=
 =?us-ascii?Q?+tumflSykoWSjVqwKS4TyhnHzenilqyvB5WkKzzrbvBjQ1lhSXux5jG/e2B1?=
 =?us-ascii?Q?kG2QTlCgLRiA0aAdduM103X9CzoI3u9n9SdruVse0VDLYZsJMK8UIs8HMifp?=
 =?us-ascii?Q?NwxnfT1b/07c0tgq7awSEplz5h+NZKliJxpCK6csTP8HbxxNUdY3qJ3DotBI?=
 =?us-ascii?Q?q1HM1LMRqO37h9lIk381gKXZkbUsp/yrLc4F2eLXsK1JPaIoQKjJxy4KDYaK?=
 =?us-ascii?Q?zdNBf4JCBu63ndXsNWhxIf8STOPUYgO09CDSoMtbCH2UNzMno4OZlKXydoc0?=
 =?us-ascii?Q?XhXaD4aBTTqp0usvVIhMwRJnN+EQtRc3TPU6Ft+L55zT2Mc2FMDa4wHEWS/R?=
 =?us-ascii?Q?DwARxpgsYbAzgHS0Ky98ZYZFXHuewTRce0KHb12qufWCi0iitc+uanifqwkk?=
 =?us-ascii?Q?nquBKZd3D/6icMODzi13JOM2wLjq2oYufAqGRyIbsegPScIMWzBNoSbp1h/w?=
 =?us-ascii?Q?r8DMz6GdT3nErSbGsA6mY0OwQhYsjSWEHNg4LtyCSwFhrCHfHF+B6UYCq/Qe?=
 =?us-ascii?Q?7+s9yJh0slapi+4GklZAhtx/cCkB6A7JBrHZv8ONlag5nakNLburNaymT2nC?=
 =?us-ascii?Q?hZIv93oWbdlwos/y0vlq4PH4BNplNjmFXyP4buWy7488GvI6phsfWtP8aQEE?=
 =?us-ascii?Q?4cCSgpUF6a65F+PhMHg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xxx4vCLhOqS2LYbbC/7vDRxFafCjr70i92YFCM0sn8nKDkY+FWu2qmgclMqy?=
 =?us-ascii?Q?rQW2bno9ErrX5iinndgMpHNE8Dk2HF0sqDEM9ihi4OhOcRpEJsecr21oqiCZ?=
 =?us-ascii?Q?WylbFYAgKVo4VQT8adqTStD53l/6WRTJLccwLT8ft+nFmsYzGOLqCrqwVtkl?=
 =?us-ascii?Q?i708r33vOGfyXqiLDIuQP7eVBHH+OgBbwrkxEG0lU2/4gxJGTPvKlWciMSg2?=
 =?us-ascii?Q?Mi5ySriEIHex3N5HYdsqnVEc1MMqXI1eH3JIwIxsbFMHwTIeJtkQdsQHN5++?=
 =?us-ascii?Q?gyiSUGQe+wsRuMFJdggKvaALVBZuTODIArzt6Hix6lTCOXhLAvKacqnI/epv?=
 =?us-ascii?Q?VAYTofGVeu1jvrsYvJNPvXSKPBgC5IoYSjvcANVULow6B0hYaAFN46LRyhSS?=
 =?us-ascii?Q?UoU/bGjArFfdvmtGUF4051Y6rIe97zJML/DQlbJHZos4I7cGfNzkSK6eVY+Z?=
 =?us-ascii?Q?eaPxwoqu25RfP/jA/LjVJXx9wLmC6tx3ABbZXaBURQpFv6D/fy9U2G7oQ0wh?=
 =?us-ascii?Q?jeeryl/ee8stvsxafeSSlePiat3tLFZRrFQt2UOgixfs6r5G7Ol3sJnB2KF8?=
 =?us-ascii?Q?MmGmLsHF6iV1Mhp4VTm0wv5e1ze+odqX99k5DZP8Cr7YJ/tAzRn0zt9HvqPa?=
 =?us-ascii?Q?VLfovGc97e2h/p2fYhWx2xbyH+it5D6oH5aBqHyU1RRnvgBL91AA1cKdx80T?=
 =?us-ascii?Q?CjnRMNvWi3xD9+oEzb8cGw+JYYpMRVR9LouUYYEZr0Dnd0eZbvgKM8sV/PyY?=
 =?us-ascii?Q?yg6CpcI8FVfG59MdtOIbqJNgFoLdG3iqLKG0gtfe43IPxk7hY7Yo0iCIOBRY?=
 =?us-ascii?Q?Ij4IVmFRnot7hMVVd7wvPkwhIHOZlK4uDSUAglbAwVCqCuPGCH6z/RPUJNrB?=
 =?us-ascii?Q?7kA9IZpQVPLnpHi14qDcXqZSQWSwtoo7p0OuadEHgfzzMeY6/X7faVOozc2w?=
 =?us-ascii?Q?k+aNe9HAvxZ0hAxh5LYixMDA2AVUnR/WnoDT68x02/oexjLIoWraWbysvHUY?=
 =?us-ascii?Q?AhWUyUYJjTjq0hLZ28HPm6FI94UysEafbF1e8hQFhCJnkzBvee3mV1vcqfZF?=
 =?us-ascii?Q?sRWbTXWtrj85ACFcu23x0+k0I3Ohyjo/BKJtgdK2M6L2n3WAjS1RPdi/P3zf?=
 =?us-ascii?Q?bBZAuIyrSzs1QJp6oA0g80Om+VshOVHMrP0627p2/uhO4/539KqbhGHgiLBF?=
 =?us-ascii?Q?s7q17++1vWbRW8wzIod/oOrUHM6GNe/GNTzPiUdnXEQeuQ6vEQGWgkc1O4Ut?=
 =?us-ascii?Q?DvTZS2rDYGSIa9NwDEoFNQ6lfWwIwzBIiTdS7fkzwIcKg6+4jjpk5vHsRms2?=
 =?us-ascii?Q?UCmd9vvuSvtnkeWma4Z2pub7L8Uh8bbwM2/V6ne0XfDv4hpfv0Q1vD+LEGdw?=
 =?us-ascii?Q?kNV5GIuSL9oY+SJO9WtENu6MAyl7YWo6Uoc6vFtTMmm3UdFheVyGzHHhHRwC?=
 =?us-ascii?Q?Gv+KU2mrf+bpRrQUVJ/1meW6htwPJgu1FanVHPthohbkVmfOJy1Mlov4Ycsf?=
 =?us-ascii?Q?XenDvMWsamksHghoQHpcPzfVM+ZFIGkv1pMHsQXtSIwyu6yxIpHJPR3e3erp?=
 =?us-ascii?Q?hVjEqv2eYfMWtj3GuVNTResCx+Mor9lAqIu+f0t4viuBsJwGPV0zyHPJLStx?=
 =?us-ascii?Q?fnF2mFbprmMrvaFKfaer9CpnOHELf/frCgRkatIcxDJKoEhe1Bd+6T9dlz6i?=
 =?us-ascii?Q?e0FMr5Jh2eO0qPMvRusXPBVm8n0vL+Y85sIpKhC+NyZrHH76DEw6v3RTGkb1?=
 =?us-ascii?Q?LP/ShUrQOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cb3855-3a9a-4b3e-56d6-08de62aba8d2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 22:37:34.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YW/Y/XvD7cNXZwYONog6Wcg4O7t0ZAWGUeGaGiTq2jHY2iZZdk9/4vzeBm04Xc4bxI/AfkPCSXNkFV1/J2QPew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306

On Mon, Feb 02, 2026 at 10:17:23PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 10:13:26PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 26, 2026 at 10:59:01AM +0100, Andrea Righi wrote:
> > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > Currently the DL server interface for applying parameters checks
> > > CFS-internals to identify if the server is active. This is error-prone
> > > and makes it difficult when adding new servers in the future.
> > > 
> > > Fix it, by using dl_server_active() which is also used by the DL server
> > > code to determine if the DL server was started.
> > > 
> > > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > > Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> > > Reviewed-by: Andrea Righi <arighi@nvidia.com>
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > ---
> > >  kernel/sched/debug.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > > index 93f009e1076d8..dd793f8f3858a 100644
> > > --- a/kernel/sched/debug.c
> > > +++ b/kernel/sched/debug.c
> > > @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  		return err;
> > >  
> > >  	scoped_guard (rq_lock_irqsave, rq) {
> > > +		bool is_active;
> > > +
> > >  		runtime  = rq->fair_server.dl_runtime;
> > >  		period = rq->fair_server.dl_period;
> > >  
> > > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  			return  -EINVAL;
> > >  		}
> > >  
> > > -		update_rq_clock(rq);
> > > -		dl_server_stop(&rq->fair_server);
> > > +		is_active = dl_server_active(&rq->fair_server);
> > > +		if (is_active) {
> > > +			update_rq_clock(rq);
> > > +			dl_server_stop(&rq->fair_server);
> > > +		}
> > >  
> > >  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> > >  
> > > @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> > >  					cpu_of(rq));
> > >  
> > > -		if (rq->cfs.h_nr_queued)
> > > +		if (is_active && runtime)
> > >  			dl_server_start(&rq->fair_server);
> > >  
> > >  		if (retval < 0)
> > 
> > Suppose runtime was 0, and gets incremented while there are already
> > tasks enqueued, then the above isn't going to DTRT.
> 

Right that's a bug, if the user sets runtime=0, tasks can be enqueued while
the server is disabled, when the user later sets runtime>0 to re-enable the
server, the current code doesn't start it.

Also, as discussed with Juri at LPC, we likely need a better interface than
debugfs for configuring these parameters (possibly a topic for OSPM).

> Something like so perhaps?
> 
> ---
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 59e650f9d436..884bdf7a292f 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -340,7 +340,7 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
>  	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
>  	struct rq *rq = cpu_rq(cpu);
>  	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
> -	u64 runtime, period;
> +	u64 old_runtime, runtime, period;
>  	int retval = 0;
>  	size_t err;
>  	u64 value;
> @@ -352,7 +352,7 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
>  	scoped_guard (rq_lock_irqsave, rq) {
>  		bool is_active;
>  
> -		runtime = dl_se->dl_runtime;
> +		old_runtime = runtime = dl_se->dl_runtime;
>  		period = dl_se->dl_period;
>  
>  		switch (param) {
> @@ -382,17 +382,20 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
>  
>  		retval = dl_server_apply_params(dl_se, runtime, period, 0);
>  
> -		if (!runtime)
> -			printk_deferred("%s server disabled in CPU %d, system may crash due to starvation.\n",
> -					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
> -
> -		if (is_active && runtime)
> +		if (runtime)
>  			dl_server_start(dl_se);
>  
>  		if (retval < 0)
>  			return retval;
>  	}
>  
> +	if (!!old_runtime ^ !!runtime) {
> +		pr_info("%s server %sabled in CPU %d, system may crash due to starvation.\n",
> +			server == &rq->fair_server ? "Fair" : "Ext",
> +			runtime ? "en" : "dis",
> +			cpu_of(rq));

Or:

    pr_info("%s server %sabled in CPU %d%s\n",
              server == &rq->fair_server ? "Fair" : "Ext",
              runtime ? "en" : "dis",
              cpu_of(rq),
              runtime ? "" : ", system may crash due to starvation");

> +	}
> +
>  	*ppos += cnt;
>  	return cnt;
>  }

I like that, it should fix the issue.

Thanks,
-Andrea
