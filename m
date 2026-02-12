Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B62D46B4
	for <sched-ext@lists.linux.dev>; Thu, 12 Feb 2026 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891405; cv=fail; b=RVUIVkXpEtpP9ruZJxMKpBLTzkmuuT2QnByavVQAhkJy8PBJ3bhIfkX8WqUQJZ0CnO2kEoYnMMm52BAXcFpkyxn2/msy5fsSxUYcNS+xDYhu6/HlWlVCWroCIP3fP8XcP/EuEb1KmFecaU0txIinbo1QdrkV297l9CxADUoRTTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891405; c=relaxed/simple;
	bh=XbmOCMoFT/jk8YQkpHob6bh62jhaIqXTiIzimrqfw/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cZEaQ+hLD43uzVP/UKKS9xk4EfRMVB9OrgQMz85t6G3MT/Y6yEcyJF1sNcwirJvhUMnp7+3jPVkVeRYO5vYtYnYUeiFMpW+qkQVLLcngDqb2RXL0s9OvhI/xp3TwLdX1AhNARkNbpuf7ORP4sNjAXaeq/mKbAOg0i9K+yeXrVJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dMu0EtJB; arc=fail smtp.client-ip=52.101.48.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMu0EtJB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO2QXfczt6VPd0B0F9pJROykgVdP9z+0zLtdL8ZCyxFoJDXcs64iCtgKPQ8+0vKuAtAjicdIROJyYa6yFqCt419TWxJyGrcwpTcSAHyTkqhP+pAD6+PIjhXV3aDiCNErJVQSlPtW9yXyuXlDaEMWYisrbI2g7D/erCh5ga/NJW3haBv2l89Def5fEOu95xR3nwGDrUtdS5ZVMR6IAPrFyKTZ6nalVNsnkf9Mr2ODvkexo8/ItMteb6GjIiPJDOA0OUF72GnEyp6HPZvy5NwM6NJr1JX+zFndowAp+SNKte1fCD2rXPB3DUy/qEXp3LVhI2HML2phr/vSFW1vQBQrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/9KdqwFWvdq9vMmEoTCs8rFBThXvpssxIqh6P0KDTw=;
 b=Xp/z83Sie8OZkijyolHhWN4ggNXT/jmv2U71Y20/xT2j2SI+GW6p2o4fTDkSH6+omtanhAakO0JpkES2oj1P3HaZKGdgVEHQx1R8RUlq9uaPyNMFlNtxUG9hD6Oq/cpFavd8hanWROqrywQyhOSajlvptHeiBU1+wIJX1f4uZB1fTBoCwreYO57bqeSK+B2leu6nzVLAeBEjaYixPDgQ5cvE1K79gzqi7DxgbOKKSu7AVdbljzdQGUNOQ1Sfc6tus9Vh+RTH6Msr0IuqZ1L9LxAkUUbRERlC6zZuhcuMuBIW4bREBZUnnuCbQjk+afe3S2N+z/U3FizaIdpkqnaaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/9KdqwFWvdq9vMmEoTCs8rFBThXvpssxIqh6P0KDTw=;
 b=dMu0EtJBimEXy7K4WiT6JYzDjWixpIgh9Gv1oxuixFygciInzlcSXqW6Bwuu+pEq0TKN2lhuO0euYlq9JTkS0ivjs8njdM0Iqqsa2CnJhikVbxEK8mpA/ZZRF+ThIVWhNxbpVKVH67aY5WD70dd3HDaLyhhvy/lP1pTCxUUdYeucb0vvENdIPOMp4Dlj9wpVYgccEJ3SevNjDY4UXFpRsDuiIJPY9Xg2LCTpdNoOQ96bqNF/f3T0hypgrrtMoBD8A8JxxDbxR/bmWVzoSCTtNUkwHCRQTIujs+bPf39Hbv8ALc41I+RW8F9iuDs+ue3wwea5Zj/kQeXsmxMv9fcu/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 10:16:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:16:38 +0000
Date: Thu, 12 Feb 2026 11:16:29 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aY2ofYcZpni9L0px@gpd4>
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
X-ClientProxiedBy: ZR0P278CA0175.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: cee58b49-04e1-433d-a55a-08de6a1fcee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?12VEZJYxhQV57nNpt+7sWHSVuHk8xOF2jMUI8dQhymg8ckBkHyv7L40jfv/P?=
 =?us-ascii?Q?ASXNyPV11fBxvW+aNzULnHhqxiFnaBRbVfUTfoZrSC0f+kvjImULc6VyKD83?=
 =?us-ascii?Q?DS1mRwEy/xmfoPDpYBFoXlFVpKQsQkWWO1pwozHzZnX0gpjZHHyf+UM7kYx2?=
 =?us-ascii?Q?hvrZVgD8BA+NJ0OU50Az/PnG3Gzi3e1ov3w932cfUR/1yfraa55LaMVafLQM?=
 =?us-ascii?Q?9SwAuFDPJ5xafrF02rD/2YYF7a3oHyLEY+8gwKb2zMmAsNbQpSxvYBoh+jrm?=
 =?us-ascii?Q?rpfg7gke7iL74V1/izDUx5smMiSQ9hS2h+aGuLW2Kwv6y1jVE2pBTkBOo1UX?=
 =?us-ascii?Q?otSX13LYcfqJ+Zavo2a9ghMyvKGgBnIXL0ckSJENZrU1nH40N8vY/9xIoK2S?=
 =?us-ascii?Q?tDjkW8NqbA4LL2M+zmI+3IPmivbHHyB6cZK6zUvikiu+yYj99eDn8X/MllOw?=
 =?us-ascii?Q?YvnKl+aIOeQ1mN+mSBGEQSinlyjfyNFRrZjjaahvTLNpVuM07Rc8FGGSDK7H?=
 =?us-ascii?Q?nTQtXcxt67HdTWPulo8ijf3al4HVcvAaDgch4RXO4hJrpHlZStwuBPaRwB6S?=
 =?us-ascii?Q?tPpthYseYpLphI7FPejQXLUuHJtJBJrKhY5JwlSmgmrehw8hBrivmNuOXh65?=
 =?us-ascii?Q?rmkt/IOULLqYolv99icWraxRh9QVqcmkoPXiBKv+DEkTUioU5BXbGwcrXAqT?=
 =?us-ascii?Q?yv3o7aSLfNiYaTFAFgeUXZ6pND1kLaBre393A1u56iZDk7tRkbfmgm1BLb6s?=
 =?us-ascii?Q?ZRyfIVdMZhcFv1IFfHBMNEToDUa5S3FA0WqAdxA6pL8MiNB21R4T9ZlcCVQT?=
 =?us-ascii?Q?wpHaFO9JRdBeCx2FNcunw2U+WQ8MK1lzDNhf4iAOmSIKT/M829Ue6rnVCaAU?=
 =?us-ascii?Q?scopLWGQqQofTgablrn0nYyc4vWWGWrxFP4TMw4L7a49EfV35EE8wdhVu6fq?=
 =?us-ascii?Q?J+X+sligfyxdbNV3X0ubDXeyPmmgdWFhNznfBm0IaHEzV1nMztYkne1YZNLt?=
 =?us-ascii?Q?HFNMgAWiIq9MCg/CvZCoXbYyQ/VG4lJxz0KvfoKKxJ84fjxQJ1t24jHcBlyG?=
 =?us-ascii?Q?pSh1eYF3f4cPBi47oiGU9tCvOX11XnZ5JKzM6/pdp8u6ZQvN1tGCNmiVw2im?=
 =?us-ascii?Q?SeZYKlq4XD/W+qRL3uEw3bEnk3Jjd9x/lWtgdfZYj7IO28au6R2AQdverqIT?=
 =?us-ascii?Q?ftz2KvIi8dSgreCC/JP+8TouzSnEBUlUYHlRNG1/ZxzsQZ/2nkUdG0fDRV1u?=
 =?us-ascii?Q?hXpfhY40hYmPALdTyMtkmSx0f+t1oyKpHKB5DLMqvMZs9+cyEhGjVDXieJGx?=
 =?us-ascii?Q?BDy6iGNehGRw9BHz7W8w7PgqyD0a4dPG0kGUg12a35Kc6uKYJhi57wc9tu4t?=
 =?us-ascii?Q?YpIqSofrRf7zDIzDzGWU/jFKhciHB3FFgf7CQZXP19QGesdhSgj1z+XycYWN?=
 =?us-ascii?Q?U/1dgS+lIfwX5TyPTalBCEXVPVsNyoCjCbnpRlvX9TxRq6lol3Uisup+P4L1?=
 =?us-ascii?Q?AO+zKFgZHVFJNqqKaHxcwNJTkC42WY+TcRbkmPmIVwunKJzhyEI0FrKK8lCZ?=
 =?us-ascii?Q?QFP2Bn8WPnnS+/8gxII=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F0Qt2YWXQOdkioK1iiNUHgJ94lynhI8LMvGt9xX75Vdii8T14xWFSkvV01ra?=
 =?us-ascii?Q?H1o/nlnL6CY+4umyWdhbDctMFlTmym/88+jpfIAdIJnBTlgcDUbfuFderQvJ?=
 =?us-ascii?Q?lmKdKSIQW6bEtsKzyjumKmqE3rkWyHb0/cBgROo9lk5sFy+7tp9HYwJLm+zz?=
 =?us-ascii?Q?Ql/UsxkYvOcOi0hyHWSKlB4nDbJXI+rMEkOd4+QDgy++yCtjCYOerCTARX5K?=
 =?us-ascii?Q?r6ICN53hZN3cHDSi+fIbixRb5FdzF/m3QC4xD3fysBVRqlrK9U9oQf71np32?=
 =?us-ascii?Q?vx0wYIJKgat0wlZQLQy00wZfAcqR407UQ4mhw7w6TCpQBa+IrZjHW8ZO6jHx?=
 =?us-ascii?Q?DKCjNXg7XkEvSlb2S2N5Dr50tR8VdvGMopWWxz2XVar0rjH4Es+FqA+w3zlx?=
 =?us-ascii?Q?IMs3rXJcBlMGF5eKH18xMrGOTlGxN5zGs2k2e47jCbN5gq4x3FwhbE84Fmrk?=
 =?us-ascii?Q?3mWI4EocOwvwdZJ7gOqdoE9g04XspGsu8SRu5qvcMLqvxgfz3aW94UIp89tj?=
 =?us-ascii?Q?oV6A7cllGBuDnl0nF3PVf5JdYfsZngmt9B/qf/n+u7b9Yb1f+4PnTVWZFqEn?=
 =?us-ascii?Q?JmbC+3A0XqSsq3f+JpFDX91bCrrGGgzYCT0mFskIcHP1f5sfbyD8rUl5o9DS?=
 =?us-ascii?Q?x8A3XmahGMA//lfcMDuGSikWdS1lEjLdah/c99ZVauyZ7PQu2gAJHBA7+kpw?=
 =?us-ascii?Q?K34tdSwU9OChOwrdHptRs+0bmtccR6KlORl+IydpNKHVnAxiqg5jsaI0at02?=
 =?us-ascii?Q?BLMMnId/C/b9R8Z8hnbZCXvytf1Z9lRD/NkU4v2NW8VOe33E8dIPGJr/pPd8?=
 =?us-ascii?Q?X/ckPo0BezjtPPSQbGCT6pIPvgG5M7KVqnL6rOH26g40vQTAtcH0pbgRWIkX?=
 =?us-ascii?Q?+FETWQTt9cP4RGGsOzhv2DYoalRJbQwLABvlPzss932KAdarrHfj7SuRz8nA?=
 =?us-ascii?Q?rsHqccDDisVsOIIHxb8mABQQRiUwHOZ7leSnpI+p60tO8mWAbUIKT325HiWl?=
 =?us-ascii?Q?MNbe4SucGJCeeS3jTbtslEq4ZF3dH4i5PDTnolYCPh08hBm/6ScFY0eOXwvY?=
 =?us-ascii?Q?T2SVvoHpPAgMPj3sHf/tYKuQo6A++UtRAoHNRuoVCKajm3I8NM4FdwV7FoVz?=
 =?us-ascii?Q?SB1cmbm+XbRaH2Td+9HN1Gj5IxLjNosLCf0EuvGJF75QH8nzvWrllaFmksJl?=
 =?us-ascii?Q?T4JPP67EyZOa3r5uzO0vDqWeciCnAaycqMPiLzkzzKiJqw/6i3AjI54ZLBkQ?=
 =?us-ascii?Q?A+DuZTTCbjhrbj7zF7MNOI/9CJB+h83Cg/At5w7J2uR/7KfkzrJAgcpp4sAU?=
 =?us-ascii?Q?PPuW/kBhvYA0urLyHN2WsNZ/HI8B7QHTgcv3MstB1UO7grUFU7+YFs3n1WPu?=
 =?us-ascii?Q?UJVPB5PfozVxOzv8+Iezs/rFOzfNMBt+QiPIi2Ufd4tOoXAurXmmWyYZhP5x?=
 =?us-ascii?Q?twt67+Qb2GOIdJ/9ReBkkV83RNPh2Ux2Iys1MIjS8RFALofhoHTOyQvPAwqH?=
 =?us-ascii?Q?hdM4LsS76BFiICuoLdCvbmVBC+s46uEoV5Fw+y4zh60By0fKLn9oGV2cjPYS?=
 =?us-ascii?Q?z4PRk+BO9ozD6Tsw1G2Bz6jDN91t31VMrtER6qkJWysCtcrdTFG92DgQziWG?=
 =?us-ascii?Q?Q0YKJ6Oj3rDzMAldmCjy1ImZrbtDkbBUXbjP0dl3uB3xnCJe6G5klzZSQei4?=
 =?us-ascii?Q?ldEVE/5N7loj3sMR+U0ZI3DDZNSw9dwV8glBfWArv+UrGvpVZGnad1PQfLKA?=
 =?us-ascii?Q?wjqk+3QG7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee58b49-04e1-433d-a55a-08de6a1fcee8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:16:38.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LM5efkMzMxZ0cqeYYrTEa/7ODdwUCiqKw2LiZsG1PH+6KBnOGxtbSrI+nWe4CarFK4F7bx/Z3WnqMFmjn6Ar6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744

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

Alright, let me re-elaborate more on this with a (slightly) fresher brain.

We have two main classes of migrations:

 1) Internal SCX-initiated migrations: e.g.,
    dispatch_to_local_dsq() -> move_remote_task_to_local_dsq(), or
    consume_remote_task() -> move_remote_task_to_local_dsq(), these
    are completely internal to SCX and shouldn't trigger
    ops.dequeue/enqueue()

 2) Core scheduler migrations
  - CPU affinity: sched_setaffinity, cpuset/cgroup mask change, etc.
    affine_move_task -> move_queued_task migrates it -> we trigger
    ops.dequeue(SCX_DEQ_SCHED_CHANGE) on the source and ops.enqueue() on
    the target.

  - Core scheduling (CONFIG_SCHED_CORE): two different cases:
    - Migration (task moved between runqueues via move_queued_task_locked()
      to satisfy core cookie)

  - NUMA balancing: migrate_task_to() can move an SCX task to another CPU

  - CPU hotplug: on CPU down, runnable tasks are pushed off via
    __balance_push_cpu_stop() -> __migrate_task()

If we want to skip ops.dequeue() only for internal SCX migrations (and
maybe also for NUMA and hotplug?), then only checking
task_on_rq_migrating(p) is not enough, because that's true for every
migration listed above and we'd skip all of them.

So, we need a way to mark "this migration is internal to SCX", like a new
SCX_TASK_MIGRATING_INTERNAL flag?

The alternative is to always trigger ops.dequeue/enqueue() on every
migration (no flag): even for internal SCX migrations the BPF scheduler
could use it to track task movements, though there's nothing it can do.
That way we don't need the additional flag.

Does one of these directions fit better with what you have in mind?

Thanks,
-Andrea
