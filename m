Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53823643E
	for <sched-ext@lists.linux.dev>; Sun, 10 Aug 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754823187; cv=fail; b=Scdm+zH+NvcMzpq1ukWGgYePmQjqdDcPjzGSIGAkNbuuabN3Zxr8hggp3E/6/lOaJuKEaYzk0+45PakxyZ502ECgwLypiwLhCQIp+bzmW/fwI0/4JP49SNRXf5E+7vR8InZUMY8epgmncpYxJrUqTAAbSezj9EIkavMZjetBg28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754823187; c=relaxed/simple;
	bh=WlZHDJmytQbGrU9MsNr1y4TaP4IoDh+azR7e0F1ldR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDzM9EBVETR6xtUGQG45WzHG0I4BOuefOVxiC0F5Ywwt2sKXKdJvfe8hukHpXdpFDkT3vERmSqtz0jYLXooPrilJsF9HBrBoTCqPszyroyu2QM4+rGbErAky/iG47FWXVY6OU+KMShjWmYT9soT3C6r3NtZ/RYviKtS/RZxAhHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q0rw1wZZ; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q0rw1wZZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAdujArQvDipuKAT9cxD+l0TIavVxJIAIFQ4DiBwm7PmlyzzK9u0Xxao9E54xwXUhsk5Zd/Ri4G8srrL54BNlaotbjBq+t0zVs4z8rSY3jh415m34pJAUQ9Q5GDzOFTCi+3++nDJ7uukq9bD883H66XDf45Pvc8WgwUNBhat4+3FUfiqQPtHRGSjUJqU7VPi/Q+uik4+UzAzsJjLyqYhhSZ0/jgIx0Q+BVuCQSVck4JdApI0W/lTn/yB7jpeLj+QkCtkV4Zr4EQVVxcb7/Jw/V7i331sy9CHb40jTtgvpID0wNNI9H3BaTh+Uj+IML2V1UhHQHOg3Db2kj1rWbxuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koXupoyooN6Pv745GkqCgesFhgXitbaiaKRxybrQqro=;
 b=DlaDLQ9Na3HMS6Q1EMQnsUw62+RTXR9IcxyYva58ixsnqyJ/IaDKiM8a0xYNyPY/8qFVY6dA8lWNinnhFqKsEHoodk5j2jDtKuMGQAk9rIpXF2/AVCL+CHEXEVQ+ZrmH9NO9EDXPjXQ4tqq8y+TYWx4OB+TZsUCtjd1vAFPCYnqIHrE9niOmYdK2rn0Hx6WDYbC/ddh5jOLufu+71OAvKc6Bj5zObBr3MOLgrPQRslPpH/7iRXac0eSXnGc0WEICUgBj0v2up98LJIYnXtaj0oSv35iTgyntW2JaGh7KcuuxiU1ja0jVzoEsc2C135gkPz4YykkLSdr9nF8/lEkH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koXupoyooN6Pv745GkqCgesFhgXitbaiaKRxybrQqro=;
 b=Q0rw1wZZvqf/ULNEAMxaXj6AJzPG5JZAAM527I+XbTFI+f6XwUZARBUJ1XkDhJLGJXa5q3AlaBR+jBU4FK/jLG00OSGhRiotBqT2K9IlqBTh56AK2VM4tHkeinA1fbIVdPJeyK9Vdh/P/nPicm4UjVVaSV6IX16fp4lKDqUix+95OpxTHvb0FiESCWEUFh1RLA2fYKEyIb3K0zg46Jm49O/fKo87/QLLT1N7R83/XNmF6dqdLvUJg3gMrGOJVY2OUBd4XhyEGvtccTJ9RHnaLvkgsu022k3Soxc3gSSr3w+9MKBDZt89kJ2xhyLpuTF23xwCOeBrxaKpzHXHXQkoGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Sun, 10 Aug
 2025 10:53:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9009.018; Sun, 10 Aug 2025
 10:53:02 +0000
Date: Sun, 10 Aug 2025 12:52:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, void@manifault.com,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	changwoo@igalia.com, hodgesd@meta.com, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v3 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Message-ID: <aJh6BWX7rYCNrzGu@gpd4>
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-4-christian.loehle@arm.com>
 <aJebkj-neVJNKEJ4@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJebkj-neVJNKEJ4@slm.duckdns.org>
X-ClientProxiedBy: MR2P264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 02517fa6-318e-4206-be2c-08ddd7fc13bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YiBDAdSk9cJXikX4eHZntC7Jo+pMfYDq4OIxwy47eTIcnQ2fAHLyMoDjD51v?=
 =?us-ascii?Q?lLDsgawpxJrQc8ED/jRe7lfySLEMTkjhzxW0nk46Lzy8v1quZngxlE8UqoKp?=
 =?us-ascii?Q?4AQbBhLvum62oFjiSmYXthWOPCUzv7POdlhRN7KT6350gruXXpVZPtlIIxhe?=
 =?us-ascii?Q?EIxBEXjn7KLbiAgsJgzlMm/9Z5XY0GvPZOsN8U/xdGZq0XHTfsaT44OzGVdK?=
 =?us-ascii?Q?vO/KOhdfvzwJ/bkWrVBYrMBzFF4Ma7oKHUyk0uBr6WricaqX9qC29QFCuxBb?=
 =?us-ascii?Q?Ai+x3hkvISYzvGDo865I9PsA+YBrW+xwlydxX7VBgMyoU1xQraDHNrH3gr+1?=
 =?us-ascii?Q?piaNox0NCrExDqOv5ZB6VwUm3iFEhKJCUwku3fG3rP6HzdbUESPuPi9IGY+j?=
 =?us-ascii?Q?/c1UCIYgPrzk5hPvsVlW80+mGI0LPW6YvjILP3JompZ9KWUGOyIUAlsUskx+?=
 =?us-ascii?Q?RPGk+JtyCcR0X8fSeX1asiElOKaJytw2apy7PjpiK3IuPKKwfgutez5uuzp1?=
 =?us-ascii?Q?ZSTBtphIeb5oE6/s70wSCnrfwaOjZamQyhNLCqO52hNJVcDrRJibg/c9OF37?=
 =?us-ascii?Q?eDrh2DgM/fzRK0tLcFTstA1+B/pm6CUiDwaY9W5dkIEPTTOAQLR18518nlwV?=
 =?us-ascii?Q?hpbCLhuMYp5kQCQHhmwrPYQ21OiDhdIhX1Dx0CRvbRMhqtgKWXV5ioVSHcux?=
 =?us-ascii?Q?2DCUaBJZoJmMzaYRWqvIsxFjFkZq+mv7N2lRJSfQKXirlA0dyEBaNYI69FT7?=
 =?us-ascii?Q?R96rxX2hU+y385ZFyOy4AlV2HWjpJuKWAJ9Jt3t8NpKFp1Jlcxru00Y5qSl4?=
 =?us-ascii?Q?kqd49bVaq7okfzJESV64QFhVhqh7kiMirsD+DGlD1hdqdCStL4NZRO13RC7x?=
 =?us-ascii?Q?iOS36oAPF4dZBBeeAJ2S0uF/S6gq446pf6ddwomk7J+L5woRnt6du92jU58G?=
 =?us-ascii?Q?z3v5KOSZc1YrnuoQkbHn4attaagfcolHSPMjkLfKIJXWC2jQg9f+MXiUqEIE?=
 =?us-ascii?Q?DRQIkKuwrAEzWa5hCs8md6U+SRVY7BmLclbLvcTwB1W+mpTBRihKk5ufFbX8?=
 =?us-ascii?Q?J993yQ4ahnU9Bta3nA+tbbGl5BaYHEOuUTTBaTUn4I71LR1p/z5IBzEkCbJD?=
 =?us-ascii?Q?+lTWFQjsrRf8Ux8WqF7AGcKNh2aLNJkDXLDAS95m63dHMNXVJv+LT4AOaYBh?=
 =?us-ascii?Q?y/NXVAIG7l+LKRNCmg2c7RmPrsETutH4JNTRnZDiAWsdeV0X2XO8zZuOZQgq?=
 =?us-ascii?Q?BNGv51Zhu5SBLnor3PU5jON9XIeChYtPht0y9l0HhaEpLPg4MqzXsb7H6z3Y?=
 =?us-ascii?Q?9nl1sA0nw+TDGWz9XXkNDzkatWDrPjpnLstDZnHDvZmCXAkdqrph5uH0Z52z?=
 =?us-ascii?Q?Jj4JCk9dWfSzTAH5fxZI9uvSQJU6wkIS5bs8wnu1OR8zGwmTWS3AOl7NGbKN?=
 =?us-ascii?Q?a8Xd9vVv0w8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cZ29X/ipbQ6Yx5qFfH6FaelPu2eueRm9MDGVF4/xyhhM02TAvVYJgEb1SCmK?=
 =?us-ascii?Q?f0CePwAW+LtuH9jGKFzzkKvTmpufdEp1R1LZ9Nbf6DERDTGRlo5adhNHxOfM?=
 =?us-ascii?Q?YGQs/RM79LdJ3dJrija3QogWOP+DE99aw+It/Me5+AkBVrmv9C+ldD0bmFoV?=
 =?us-ascii?Q?gZEkeDu72KIejqRhs6jLO8DAY2mcmoUJ2JsL22w+6S2gNWB7SUCxkkiBN8ku?=
 =?us-ascii?Q?6f0BZd7Fh6XbW12THf0ysuLvO6aWDZ+UnC125Y+3wvNf2Hx9OiWqTY8lb2EC?=
 =?us-ascii?Q?SzZR0ZcyG6tfFx+ihWRtf9QZbWdDQAaCRBMSTyIYLO8ND7gM4tTMyJBzC1gL?=
 =?us-ascii?Q?JuMNSi04mzix7i5OjP9b305iGHxoYIrUP8DSXZU60fJADH9Tr68b3AzbJboR?=
 =?us-ascii?Q?lP2l/8dtwPup2UHTnorBt33HHo/NtTg1y3JeSG0NAh8TPKMF0QnFzqzh8gQ4?=
 =?us-ascii?Q?pirMQLBeRcjGjK+XB4je7y1PG5kuIFRVNh/5Bu8Vb7OblW74CimrAtmpQgua?=
 =?us-ascii?Q?1h5rIcn+Zbr5w/vF3rdnmyz+qgkevyLZt2OHOYmjcr8IRqy07TyakUH9mRfw?=
 =?us-ascii?Q?pA0ZNxvyUS6FiVn2rwA9iIOCk6kbqCXr6fMaP98K1c2vCpYOiEagveKjbBRy?=
 =?us-ascii?Q?unH1O9Glm1+mcPJF6eKA3pOAUUS6Q4IWdiNwAodD1qes2quX9FlbYyoCuweG?=
 =?us-ascii?Q?R7umggAH2AtnP1KRHCLaQdDbSwGDDx4MEVuVDWNqZVa3l2ThcXeJ6WG0TLPj?=
 =?us-ascii?Q?47VrAQ3WC6QG77+yFEJiAlfDUcN0hanFL4W+NIgRAArodY5ZLEMMNn/KCL9V?=
 =?us-ascii?Q?hoblBW1Non2qqckotdHeykGUuhMtVnlWT5zcJIRal6OVnKBUmTlIpDr0vZBa?=
 =?us-ascii?Q?ohwSY/2Qx+D9xG5+pW4/xOY1dQ3FTGygflp5VnzIAk9/bcwG0NhsDcG+KxIj?=
 =?us-ascii?Q?V4KupWSu1rV+3QP5QZN3CXauRcJlsYA2OWfIX+wHptUym+TqDlnGCsCqvtGy?=
 =?us-ascii?Q?BsayvoPAEAu8snyRL6yMqcEvpBYeu51OgDSBzcYu+FUzlkg7FJsqTpyEP7jw?=
 =?us-ascii?Q?Qp0HIcSrO/zwS0yBsQpNnkb0vA0rWcdfZbD6hzsGA5ibhKEb/iX929YQlYm/?=
 =?us-ascii?Q?qlux5dEbE3f7LEOQ2aelwxlAIr6JUZKwO7in198+udunqsgnujkdTiyBfTRa?=
 =?us-ascii?Q?/RGfRF/JlzSq1/HxifKw8KQ4mrrUTqk3cMtKLoX+JznUuTVlsiYFd7fAMFOt?=
 =?us-ascii?Q?NjLibKXr/HSCIvCnYYlxL3lkf/2yNUB0EMK5O+WrFjy6fWbHMkGwcbuy/50r?=
 =?us-ascii?Q?FthGXs+A/fUxQ9K1/PJ9H1l/CkNjQ1UonA10L9Zx3Ppe3ry9tsL5Oq1j9LRg?=
 =?us-ascii?Q?obQ+i0mLiTSBywd9U4sFVRTXhEUoPgsfwc93oQzRs7iUmt+xXmDMbABJgHqB?=
 =?us-ascii?Q?LuEt+Ha9L8D/3and3ZPBg0kir2x/73LbC3JExW5JbOa8mZSEDH/hjj31OyJh?=
 =?us-ascii?Q?EjkfJBafDX1TPNzi+3IJRtmL50nmXyU+k1G5bX1uH9Jbav3UVKOMfYGmezZx?=
 =?us-ascii?Q?O16er1RFK4gXYkqD8wUvZYw1NeguKvDdQiyMeO+G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02517fa6-318e-4206-be2c-08ddd7fc13bf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 10:53:02.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNabyJSkkVbfyHmv+hTS5JWsThGHCOt+WRZVzvbjx+o78H1HA7y+gFJXBEf6zERp09b35nil6sW8y+21Gx5RBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633

On Sat, Aug 09, 2025 at 09:03:46AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Aug 05, 2025 at 12:10:36PM +0100, Christian Loehle wrote:
> > @@ -7420,10 +7420,20 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
> >   */
> >  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
> >  {
> > +	struct rq *rq;
> > +
> >  	if (!kf_cpu_valid(cpu, NULL))
> >  		return NULL;
> >  
> > -	return cpu_rq(cpu);
> > +	preempt_disable();
> > +	rq = cpu_rq(cpu);
> > +	if (rq != scx_locked_rq()) {
> > +		scx_kf_error("Accessing not locked rq %d", cpu);
> > +		rq = NULL;
> > +	}
> > +	preempt_enable();
> 
> So, this will break the existing scheduler binaries immediately, which I
> don't think is a good way to go about it. Can you add a pr_warn_once() to
> print deprecation warning and add e.g. scx_bpf_locked_cpu_rq() instead?

Yeah, this is not nice, but they would be still broken though, in PATCH 1/3
we force schedulers to check for NULL and, if they don't, the verifier
won't be happy, so this already breaks existing binaries.

Even if a scheduler performs the NULL check, this change might still cause
incorrect behaviors, which can be worse than triggering an error.

How about we introduce scx_bpf_locked_cpu_rq() and we still trigger an
error in scx_bpf_cpu_rq(), mentioning about the new locked kfunc and
scx_bpf_task_acquire_remote_curr()?

Thanks,
-Andrea
