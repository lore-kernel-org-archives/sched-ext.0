Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE137272E5A
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653240; cv=fail; b=Apki4kY3v/YNDqR/is/oVfQlTZ/noSjelKm1au6roTGgnqA5bItzWlLglwqLY2TrBakfUJwqpYrDUApTntu9o5jdGm3JtlgadIU9BMFqeyYEVaGA1Rv/9oM3xuoLBUDlsC8LNyV6OejniT1jaGzxL6w9DKKAM2YwYDXt26qtwKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653240; c=relaxed/simple;
	bh=jN3we/1FlZ63ASNUXmerXaUznSU2qb4VAG+j/fy8XEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AUiIVPwKBbCn9zC6yQDSA+l5VRoNcU4ZlyoQ1RsilzVbRd15+KOurfjMzkXWX29KU3VL+OVaRREM+vXFY/v6qtBXWb1FskhhJ8v+68k3dywC8nExRUsei18oczq9rNa0vKYZzwGQWciEXz42+bJQg53fc/iJ4jNR5/Gb/KWSPgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aZ43P1XN; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aZ43P1XN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5H/fZmjggOR4inEvmrkppaqNItD3ByDvDne19uGKkeLt4dogsLnXakJlsVEmhq6V6n/xapd1UfJLNJp8X+plNxZi8YrSmlmG38dPo3urSDnc117W3e6mhLlreuIDhSZolxVcJSWp3UXDlvBpTzQodxaCD1MB68iRO4K6t1GsJw6Wz2oW3/3n4+DqsdmOPt/ld6Y5KWxHo/FIT++bBaEUYyQwyWxolUbx3zw+IqJqeLUtA9SI2haVLxj8dc5BuL5Rw345iE54Em9uGDNYvexNUviEPB/VOyy/1efO3PGCQ+CT48z6S/biJUinZzbs1lysLxYz77I9ebZ3XpfPDHz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKvIxvqwoW1RdsgX3I9pBbMCCwxb5r3d6XnR3nf77vE=;
 b=rC0zACQqpP5Zrxe+w0ejryWQMEBK26Ir1c7cADqk7rGAmKRwfSja1uUhyjPlAN5k1pcvJ/li6XgSHFrSRcC6qiV5qQ6n/aQGz7i9Sw/wTeRi9aOyk/45k1D/3jEwip4zNfRdxbEQbj+RXKb6e2VMdThnnzy0Zv0zywtH7dV3i0VKQfXm6aroyYC5G51VupPQH6Kt3/Pd5xpq1FBxnGkO6WLpBzFFW7UU4DPe29D6ZZ64R9Zung8dMnmw1yvvJqAD03bGpLucTdRz6gOUdupGwmm9C3tA6fKc/xah+gzSJ+pXX/0CT2+7gHRooeC46gpzSKRUPBReXJOCqrJAhFHZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKvIxvqwoW1RdsgX3I9pBbMCCwxb5r3d6XnR3nf77vE=;
 b=aZ43P1XNEpUSVGAtRRrCtOi7diq/Qnmro6SpujumT1Onwfz/sruOwIq7nN5cR/4Fl7nxRXY4bvDWGXpEwj8sOsafqgGrUMnv4i71mVJlB/he/Z18lT52/oTaTVS6nX5RpAmZdqh6V0QPbCNqAnFgbFp1AQFCuuZNa6g+g0PHTeXDmD0d4dagQXkBw0N+RRbH6F6+HH0EznH7cRi7X8mrSl3lnB+xKzudESiAb8CLn8Fcsr6/plaG2JPChw9fM1daJu0mLi4QPlE8GFT9ceNoRCcQSyeJ8GC7NMM/Ye+B9YRbPUlYCeyQrBfcTBnfpcdDFdZrID2nwz9EeoBsqBloSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.21; Tue, 23 Sep
 2025 18:47:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 18:47:13 +0000
Date: Tue, 23 Sep 2025 20:47:11 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of
 rhashtable_lookup_fast()
Message-ID: <aNLrL4QKoaljw01m@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
 <aNJJydxk8ItUpBJd@gpd4>
 <aNLD8w2ZILVbERwG@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNLD8w2ZILVbERwG@slm.duckdns.org>
X-ClientProxiedBy: PR3P191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b00a96a-ee7d-4d52-38d2-08ddfad19c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KJY7P5MP712SFCVbreThJLG5MS7+UFubRAp4m5SAq6r+GyMLSZGV7fWkh3Ku?=
 =?us-ascii?Q?QS05xEYya0fg9SMJyflqCpu3T3YP6484u6AKVz88AhSgKqDMeIyoqBSUS8pj?=
 =?us-ascii?Q?3cyZ2HwgQFv1EY4r9imHrtQSBRL2GzPRwHj3BiR3d1ybmfXTNu5SMNHy0j9R?=
 =?us-ascii?Q?vw3RAqjjwej7EzyZn9UnBPTnTYUqJnRxTMQUMw3EbwqeMxuCPBclE57jlW8o?=
 =?us-ascii?Q?KqQPyt9dI1Oa6vmi6lwbbcgzR4/6p9CH9Se1WOU3xkhT0TSRDXWvhaaM0fYt?=
 =?us-ascii?Q?UYLb8S/3OypaYWout3EhtD7tb2rRB42mYQ0P53fJ0UvaddPT3oDjS6sMGYvx?=
 =?us-ascii?Q?JRZykzr/JrPRsmXjMkC+qK+FOPCXN3dDqT22UH12a3OYtK35MUjdPbHfwxny?=
 =?us-ascii?Q?8CHvQzw/hro88CPABIzbW6gZ3MHEJ1U6Qu7Mv9Y3UE+ZEdNT2j+3JZwfiRO9?=
 =?us-ascii?Q?xxoMIN2tHbRKTfq+xq+rDjPcUNrh/qJpScL3u5T1CyFdr+hcfoLO4iaLQKhr?=
 =?us-ascii?Q?93j8VxGVeASKaZ/4vXR/brpt8MNvG9xkgKzuppA9DwJh+PgaEC4/13vG5ref?=
 =?us-ascii?Q?CbB8Ltj1QG/fT2k+6jZg9OG9kYyhxhpg8WnYnnRE24GeBHu9nn42KHjHVnES?=
 =?us-ascii?Q?LYBkIk3u/DGv3bQw0zTp1MEZr/BWaJWd/bWL/xQ5EmpvVaRW9+wkK+5hzjK+?=
 =?us-ascii?Q?sH8u4XZ25KI0VLCQszvz1S9B1LfqL6aH69fIWew+b5z2FKqwP2RASVg/Lqd2?=
 =?us-ascii?Q?9ZFPWNylca6q+3WZUq85DF343oem6a43TYbUlHSuMiKOuf01fpVUhaHVCFb1?=
 =?us-ascii?Q?UfedMbepYCLjXa+30DjmRU+Sqw/AOzVZzh2uglbVC0tG463kyoLVEdybncPU?=
 =?us-ascii?Q?+2rMBKKC5gdqT0DbvnIsMimTqtzRZdtPGTSacGnamn4w5lXW6A1PoBPiZAYu?=
 =?us-ascii?Q?zeJsYTueNWeAFkswJGU022auiO0jHbfb/wTPEvNzq23f0Wb8jMqxZ1C69DqF?=
 =?us-ascii?Q?3pk/m1fjh4TkQ2GSt6umRHAt6dEp+kAJxl20hNmeJ/a1nkFOCM0qnD6N5gHL?=
 =?us-ascii?Q?xzk/DOiMH5S8EHkJYfr4p7IZUmht+Wg95DL90hY8iJeVRdqpQJo5T5sLOxIj?=
 =?us-ascii?Q?SMvBPMi3C2W7zXsLAbdyIuw1Y8nLQn3LClTC0j5rd0osp5WDpxpHQ6PvCLyw?=
 =?us-ascii?Q?ZP3W3LmblM8WReogbaDYRcJdRBIL+gspz6wmxgz8pJ6I40RFYfH7atiyQTN2?=
 =?us-ascii?Q?v+5wElD6LCUf9ELpprUXuJvI54rSi1ygrysUWyWSRqJDI+0VnW+qE/MBcJoI?=
 =?us-ascii?Q?bAatQLCFwwF/gaEAS3RRELIVS94vmAa/JEME9nbzQn7jTat3VCbtNtzJwntc?=
 =?us-ascii?Q?QDuYvTtLMrCSiI5kLO+CSD5Js4FV2mg4dN/Qtk1gZWn4EHRJ6rDChuPYQ4xt?=
 =?us-ascii?Q?bpnvJlA/Gi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mAn3zHnEhhLfomY2PSxK1Ngy604vSVFptY9lGlOlFaLJMA2ZJfgGtzuyNXQ9?=
 =?us-ascii?Q?YtI+hlCa/tjfnV386cm/WwsuxXpwES3ht5Qjhv45+S6vz8Itky4fNts4Sa6s?=
 =?us-ascii?Q?gVSE0sr363NDPrE9sy5k67jKqTOAjyAAD8CChVASjcmPvga73KHH1pWwcFt/?=
 =?us-ascii?Q?rY58P6fnRkDFfEJdF5Jpb2dXgkd9FlE+ELVHOp5E1afsKeg1MpdnUN654q0+?=
 =?us-ascii?Q?IDenmMULnDDYA/eRDD9rgb1Xv9xD1nNY8kLmiyXj4JT+w+xY6DM7noidxjzJ?=
 =?us-ascii?Q?95+wGpWNyAjuXgDlmx99r4fVa9DuVDsYp25ky2VmAJxekhWXo70rp6dYHmt7?=
 =?us-ascii?Q?FlCsiQMo4Fa7Bs1d2oWmp8ys4+Vq6u9DajoXtUkoXqcOV8o8rSt12KnxSJ40?=
 =?us-ascii?Q?wVU/rx6rAAKj9otm2Gl4+RSYJQfrvjAAjAtTpR4HTa5tbKzScOK89p++i7Mo?=
 =?us-ascii?Q?QqhNJK0MQ7jRrXNBqxiqV/ycCDMKW1johE/wlYQ7kWuOKVJ8IiKLZwquW0YH?=
 =?us-ascii?Q?gOUvaVtSqSaYCDTc2oABdXm5x83dGaDyNURwKYqlqu9SqAsyWvumet7aqWjF?=
 =?us-ascii?Q?1u1Q3pt+xxONujYeMfET7o6pGdiDp87zXeQMFii6flEKxlHMKF7WVdPjvU7a?=
 =?us-ascii?Q?S8Zy/D1yQE5Wce13W7OIx7SAL0ji4hWsjfOw2a7iTLXMzDe3VM80QehyVp4k?=
 =?us-ascii?Q?gG0LGJxwvz2EEc0dhk5o5IVm5LwbLw5dQ35Tx2HRHfcMJRHAoRa7wWy4myap?=
 =?us-ascii?Q?xGs1bZbesWiWd24U1AlbK6uNEyfvoUN0Xpwm2Xmhl4/Kn6TCP2oI52+Axrgs?=
 =?us-ascii?Q?D9x4cP2dvD8C8+dt9/IdeMJ7Rr59I3hf8KF/mXA3xi10H5CPDzTlAa4JO9fu?=
 =?us-ascii?Q?eOrHGaz1g+1Mn5c25oS98Ye9GMH2hhKvdNhanaY9f3HulBfdKOQg4tQy0VGz?=
 =?us-ascii?Q?MFTVj6GeOd4I+Q7RoLcCn3mBmgUjLDvOvj6tV8+KwihOCTQraReMVsObzNzt?=
 =?us-ascii?Q?2+efGx/04aHPb+6fa76iYO3g5OdLZztuGD2EMExlw2bBu3kGCVWQKh4tXxjG?=
 =?us-ascii?Q?KfB3MvLYgv80wnHOFu5C8rwogUWHzmjup70iZPY7AILBlMQZ59zXExTr9Kpv?=
 =?us-ascii?Q?R4wa4Oo9SLxw2qQFkRXsHEFJbXtqM8Li1hmGIdpBwaCYa9QlXkxzDdjmJclR?=
 =?us-ascii?Q?9LgUzkYh4Gn5i0gjsfQKTgGF/kFhzS60T34n4GIVpUMSPbHyDrvmYZrrPNT5?=
 =?us-ascii?Q?gOgCdHhD016fWTrpRoaKEFp4mte9mid/h+Fd5FqpxhHxPJ1CM8gE22pk9TYa?=
 =?us-ascii?Q?dGShMyxPIgCM5PnokQuxpRjHe1j5XNSiY/snriKQH0EN/bJJ01zPsW3rz2zz?=
 =?us-ascii?Q?za0u+rPLDZqdSGHGUnp1mkk25k3mw8cyPpZmsHXXvsto85ZlOmFBYFyHkx7R?=
 =?us-ascii?Q?5fFucC8SsQCkncV2dL9K9BSy8MMXgBVPn3tdzjUw08/6mxLiTG0JExSzuM11?=
 =?us-ascii?Q?SaPGPhX8GRz02QLIugkxf3P0z4FzlrwgA7Hpr7Bp1Qlhouif/br2fTU3+NuT?=
 =?us-ascii?Q?xIp2JFL8l1EpvavpDJh0EKln3OMmDeMNeUdpLkk6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b00a96a-ee7d-4d52-38d2-08ddfad19c6f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 18:47:13.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnTz8T4Ci4mu+QGAq6sHR9RvD6No3IGTBCuo2Qh7VrKsNWbO0hL9EY2ax7NT8tV9waO2DPBcLXWLvp/MgyelyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

On Tue, Sep 23, 2025 at 05:59:47AM -1000, Tejun Heo wrote:
> On Tue, Sep 23, 2025 at 09:18:33AM +0200, Andrea Righi wrote:
> > Hi Tejun,
> > 
> > On Sun, Sep 21, 2025 at 03:32:40PM -1000, Tejun Heo wrote:
> > > The find_user_dsq() function is called from contexts that are already
> > > under RCU read lock protection. Switch from rhashtable_lookup_fast() to
> > > rhashtable_lookup() to avoid redundant RCU locking.
> > > 
> > > Signed-off-by: Tejun Heo <tj@kernel.org>
> > > ---
> > >  kernel/sched/ext.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > > index f5873f8ed669..df433f6fab4b 100644
> > > --- a/kernel/sched/ext.c
> > > +++ b/kernel/sched/ext.c
> > > @@ -207,7 +207,7 @@ static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
> > >  
> > >  static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
> > >  {
> > 
> > Maybe we should add a WARN_ON_ONCE(!rcu_read_lock_held()) to make sure the
> > assumption is correct and catch potential non RCU read locked usage in the
> > future?
> 
> rhashtable_lookup() already has that as it uses rcu_dereference_check()
> internally.

Oh that's right, I see it now. Then looks good.

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea
