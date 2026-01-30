Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D42FCBE3
	for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791623; cv=fail; b=QfuiB25m8klhfCF/8z4v6G91w6svQja0q8O7kgyojRpyxPAvIxv5k8SjdsZaruldFnNl92CtvNDPGpCj+ntjiU/yWwC37Pqfy5FvrtEr4aV2pEKu9c7CGn/Isz2D6W28D9i21NXqP6TAHOUyuy6Wzjo0cJ3MHMMsYPr1qPY6W5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791623; c=relaxed/simple;
	bh=+qFUHqUl1Ob1XyH/bGr5SzabGz4Dmux/XUvj0GDGBNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QQt7PuIa8dUy949m/0bUKK5a7mpBoRolJMGTyc1kD1DanC6hP+YXYQgeANSXVNOwCrtzYdek5jtwNsJORohlqFpNJHfNNldQkykamJirtm14ItBe4UHjOzlAJG5W6cbkg9RKK8+6ZB5Dttoe6+X6yR7y/x7jSjTnh9MV0AZ0P20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JUzB2qmo; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JUzB2qmo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay44JCeDRzg8UxHW0dLIAjVnwG/p3wzYaA/I5szLV+pz+9qtg2O+Pz/0Y7br/jK7vCxGugTM032/BhtCogtEuhlZCYVemPqPhNK/UHmKd56SMp9zesZ8nYG5PIJuN1xP4BkuKxbsbdXwRzGE1w7QM9/2bfAdcFWROf8jwtXXsmP+vdYnj91O7GIsvdojwZG4fqgLUfW1W3kZ6t3aPVFCSMd9rO7+1WyWTJkhkdnnlPMcFOmM7spHgKIB1OIr7S//zE0XoYs5WWePobobREHuP2GbzvauaKvK9YZWXNk/2S1SeURaBIQs9edUXrX5EsXe0W9F1La2EhcPd8GWAOutmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iotdWNbctbHqTbqaGziYk2x4rRW1dBF+8u8vKux2EL8=;
 b=BiOTOHaLRJCqE85dYDoMe8FugNi74NSJ/Lg8MjbBOCQusTBT8Cgx5JIDneF6HmE7yH960N3lfInLVkWL3DkRAK8z6D/Cr5jW+81DRxBVeYUU1Lb+m/blNk9HLYx/9ezDL/5vJRm9IoDvMoIvQHy48ZUkvd1CUwHwc54XsQw4Hk0/lQ79QQS89AhkC52DyZfddP685MmlSCZPAYXU9PFpUFOx6uHR5u3Y7O0zwjJgm0NrolZDsuJlGegZdwCoDysmyYWnuWhtf1XpboDFY+XNttehH+C/tc226a9qidNH6tWsVebqKzVTexcfyFR/urbvzkU4Rvgf5CbTifRc87/7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iotdWNbctbHqTbqaGziYk2x4rRW1dBF+8u8vKux2EL8=;
 b=JUzB2qmoaJpjFUdLPSybRbR0U00ZToP3SIoyrNrhLuP0wmnvKn6O6x0qFSY1e2p/GIogaTX64lEfI/0YQs2/iL151HBIR+Z6+uXzSTGFTLuV1Z/VcP2+Sz8OGj87QVg1UH9H42Yhiz0Aa+lmepJvspa2QFSMAtJjvn3aK1B1h/hOcrx5lOAAPKs0mfgaYp9gb4SCsovxKPYbOenUJMrM+lA/e6//CZ3E+B6TtSlkvyut9Sac+kcQjOw/eISiGE7VKtP7BaOVe5QkQKF4bHkcTaZ8OIqlhmeRStAb4HwaKBpGeL4mlEIyikhYBNB5VIpCoyeN18Bjdk1j950SEw2Jiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 16:46:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 16:46:57 +0000
Date: Fri, 30 Jan 2026 17:46:54 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <aXzgftbTn4Rh9jOi@gpd4>
References: <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
 <aXoSFOONWJmdyCQB@gpd4>
 <20260130122413.GA3306656@noisy.programming.kicks-ass.net>
 <20260130122620.GB1079264@noisy.programming.kicks-ass.net>
 <20260130124100.GC1079264@noisy.programming.kicks-ass.net>
 <aXzblMyzyUoyNF36@gpd4>
 <20260130164032.GA1206760@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130164032.GA1206760@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2a6bea-ad3f-426e-4e5f-08de601f2ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WOo2NmdZsk702gaMw1FggaQWqh1WndN9xvXWtAcgXk/WNFeWlEiD7SQzus6E?=
 =?us-ascii?Q?b6mOE7h3QE9IbBzpod3q6PAx/urFxaQyXiCF+o/lITQccK3AeW90ij76yEfh?=
 =?us-ascii?Q?wSPCyR1NFMNNkeV3M0aOjwAGk3HE7wml1P0Ktq/FTd7aBHJTVapqxmp3KjAN?=
 =?us-ascii?Q?gsiQgkuOF4NRI2H8Ji0XcePDrSyOKjShrcIEIieOkVq5P+kWP9PhEzB/Avrp?=
 =?us-ascii?Q?XnSELR4x+OQqiUx9ZzXeCJJAhIMw7P1MYMHYaEfzyRCVPWcRqgQPOgO6B5rs?=
 =?us-ascii?Q?xpmzrybzg+AWz+lyXyNQaRwKYNXbK260f50YluqI6LqF6zo0ps0fMVE1JY9w?=
 =?us-ascii?Q?xn/hIump+a75HdDJBpjQP9Q/j4ACLmMb0CM/owY7UEmn/z6Y+QlZs+ZnS/kQ?=
 =?us-ascii?Q?UNeGACckfovlEIsC8lz/zthtikKxGup039AD3FNR7Ohh6PaapBIUn3abplsq?=
 =?us-ascii?Q?qcUHUmG+N4W+0xaj94Ijofb7lXwF4riLIj9U70ymehoS54u1FbLWjIysgRdt?=
 =?us-ascii?Q?QYVYGvt08o7+HKPrRhTyrAG3/fk3Hoiwz7oGpiy8QU5qPBbz5NxF0v5bRvQX?=
 =?us-ascii?Q?YCa3HCdzoE0uHpScJlOZ5ZnGzkmcCmd7ccUhgWNsmcdTHb0Qkd3hwwsHbcjg?=
 =?us-ascii?Q?pVahH0L3e8XVCx+CoIQdwqVK6Qmdgr8FZRtqykWm2gpd8bLk7IS7jWlpjWHw?=
 =?us-ascii?Q?MVPpVIpho8HgThJQBqzeI+k3NdKzPdYXkxLDXNNNhM9ofDjYezhKEl/a6vHU?=
 =?us-ascii?Q?R3BsUux+nSQiy3l4jT6zL722wdFuQOkhka8b2utOY1f6cleHHuFrZZcxc87m?=
 =?us-ascii?Q?AEbmXsdKQexH9SKVFA1WP69Po7qIQpcM3rjDWg11gtpHfXQUZ0czHwDtdTtA?=
 =?us-ascii?Q?DquL+AUbxvkd8UvSbJLrwyKmQuUsXY6/6YA63lO1/hJ/YL/6b+b31xjgB+Pk?=
 =?us-ascii?Q?KPRtq+IUeuXmZZqSaXtBFy78Tdc46vlLbFfVOL6eR+v/tyon5fVRRfpQq8Uz?=
 =?us-ascii?Q?ky69jV9iEoIAD5b0gWLAUU6FKvn65XMBnrVm5kzj3iq/0gmJUyJ1C/NZr5HI?=
 =?us-ascii?Q?lXNU8RSDZYs/rG1E9KbNYXKm6/g2kQ+4Smz5/nAaxrk/Il6uPQty8pjlIdof?=
 =?us-ascii?Q?rxjBMTdY5aIJngpJBX7G6Ol2BF3rBKhXRg1qpsTwQxzhP899Jftz/9G2prXG?=
 =?us-ascii?Q?hhUBnmRbp8krhnxAXuMRw0elTneIN75XWxhsT1f3Lsvq6Te5O7BaHob6SP/s?=
 =?us-ascii?Q?Z8FmE77tJRP8cHVvl/pPb2MjcN+XaoqyPW4o1JgJYPpK2X1DLRBUPoPoj3kG?=
 =?us-ascii?Q?t0t7WGyxnLW1k6HyEo6qXW9p2+OIN+ckSI6clyoKv3GVFO/9NFWx+9RP8H3A?=
 =?us-ascii?Q?Qn5+8PzyMxoL9PShy4qw6hRQwTxMUmPbAgDf8RPQ4AlQfbF+vaU0j41qaF+1?=
 =?us-ascii?Q?hX/DwD46D17so1jA5A6B6PHVwGAl+m/j1ObSpyv4VqaFkZgjdnPr5cu7Y5TO?=
 =?us-ascii?Q?T3P8FmXcwwCxoyok3aWRd5KAwJE+FdVt48ngDpK8dia31DIveli7eIiguoCL?=
 =?us-ascii?Q?4GwrEqQndHj4zmSU9bY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Kv4xdix0G9KlYvZ3afcR7FS3K1CCN6fy01BPnaGt18CU/I6n5rsN/jp3fZP?=
 =?us-ascii?Q?stXTFcKgeCCTCfsbp6C/kjeW1bVZTaRoNo9N5tpzKUPq8aIhTHp/Xx/RpeIl?=
 =?us-ascii?Q?jb5dKWynHz/r0E+7SaNHJjfv9jS11eAHxLAfwoELf6Y0H8jip8sFfdC/IP3T?=
 =?us-ascii?Q?GES89HIf0MxUbe9MHo9iEtRFj0+CuIqle7rdyPHkDAgip2ysfg8jSMaC7kFT?=
 =?us-ascii?Q?rTQHaXTWPczhCe9ZOnjZUnvTlcKalD8EShma0KyOdEW34s/atIJCR+oBrDwT?=
 =?us-ascii?Q?SbULofPRStliQ5WcK9zbgI7ogK4IPtXHqBSbbaz+jiUhtFK07ECwFQyofZpf?=
 =?us-ascii?Q?BhXW6+OEVQHfGM5r2odWPd1LW3NBkhMMzu7loYUl6V1w7udNWsAEejqz8VuY?=
 =?us-ascii?Q?7CuAlADSoRcsVNGE7iyNaubE/Du4oKdK+XbuFEOKhqeWDaherhMV3LV1HoS8?=
 =?us-ascii?Q?pzFVYP/JCvI5TATmkcn7zeFAbtJkOy7O6dFU27Fs4vQVohfAwx0xIjhuzCt3?=
 =?us-ascii?Q?o2KuNoDjP1cIk3TwixQQx8NrfgOH/zx+7k2yql3jwREGwBi0+tGOUzvIaBIr?=
 =?us-ascii?Q?xt97WsKXQiYjtLUTTaEKgv/CSr6rgi8FkO76tnkfJktO/NSsk0JG1tAC9GqT?=
 =?us-ascii?Q?IA6LjNkodMLsbiQy0El3YXVUP9KyzhDZwQbFbK/pwblcPybsmM6J2TtNuNJA?=
 =?us-ascii?Q?FvKSR1VAdfIgbpYVLzr5jcEC+tiaHr59efdyFZcWoi4v7XfsrZbZQaFiOVYQ?=
 =?us-ascii?Q?Dg6DhUJfJO1MnehJoVuY/TEJSWHD94eS02a2MUaFMpyZJ9ZdAlAf1WSRHqik?=
 =?us-ascii?Q?TGLEpKlhtZuJ8mJ7NCKq+fjNpFwah7JeOSC2QdnOUPum7Swg5i4+2QXLj0Cb?=
 =?us-ascii?Q?C29p1QDMVpSOHBhdRhZWHIzSE5KRFe4rwCEur7N32bSydctNnvQkgVP0qms8?=
 =?us-ascii?Q?UwkGRSmH8eGHSW+pdmUQ50gGQgpRPukgw7VqZRGIiA3BLgFoRMedHcO9ht5n?=
 =?us-ascii?Q?TZD/Vh0jEKae8S4irKKYxCliT+1J7janc/K2oVqRlKskGaOUX3fuSFPBknbw?=
 =?us-ascii?Q?XRTOonS2w9sJx10ApkM5TP75i39lJx5o+dgOcLKM8tOEpncqmZY7Vwg9OW50?=
 =?us-ascii?Q?OLy58kAc0ltdLLanqlcWd73xlv4nntf9jt4sRUcwSZVeMs+6xtpjNElaa8vc?=
 =?us-ascii?Q?eCWLdGgvYO1igfRoUWpUGgVrK552GgzLZcTfEXomrWucINEf+K/qTX1AnxwQ?=
 =?us-ascii?Q?rbYLQtHgSmUXuJaF0ZiVf0bl9MNVMAltxZsEK2uSabDdaqk+OEAnJB/oLPE3?=
 =?us-ascii?Q?V+/DPOY2jWBn/ksgxxKXwcEKPr1wSWcOmMVvNflMvE5ZDtiTiXD5QgnBLHcd?=
 =?us-ascii?Q?8FSg/ZLgncN4lNOVqC/NI4apc32hLUpHgKn/DmvlEiKdMcSbqqHoooHwIlOb?=
 =?us-ascii?Q?JNKEO4xJoj0l7eN1tx598RSjXdqwHj2iO5Tr+6qZWajYWKQws+dvyM5UBkls?=
 =?us-ascii?Q?3bfDfEp49MFoD+4Brj+B319MGAuEMsdOe7q617W2XDpJMxSHmLGAfl3mxZt9?=
 =?us-ascii?Q?GsWTVsJQkjUNu1ArmQeo+PpJ0nzr/cJcZ/WhvGQ7vVZNwPQdsdQ0vwrMuEXb?=
 =?us-ascii?Q?4F26vKIoe4D1pxwGbIoeUBv7BbTA+VwullQLQkveM2WHSa/bUp/2Ssv7bT1P?=
 =?us-ascii?Q?bfNPnMGOSavM2LyDKIH+JFxB4sO5/48KOkcJ8Rfti7OYtFQb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2a6bea-ad3f-426e-4e5f-08de601f2ea9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 16:46:57.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiVQFRdJVDOMmp/JDIARomXfKOipX8iqFfjWDh1V6IaWisiSMWcNdf0M2XOJaKP+nnxFkJuatenrm0N+k8239A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332

On Fri, Jan 30, 2026 at 05:40:32PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 30, 2026 at 05:25:56PM +0100, Andrea Righi wrote:
> 
> > > This seems to work?
> > 
> > Great! Makes sense to me, I re-ran all my stress tests and everything looks
> > good on my side. FWIW,
> > 
> > Tested-by: Andrea Righi arighi@nvidia.com
> 
> Excellent!
> 
> > Can we route this through your branch / want me to send a new patch?
> 
> Yeah, I'll write a Changelog tonight somewhree and stuff it in tip.

Awesome, thanks!

-Andrea
