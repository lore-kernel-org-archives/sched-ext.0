Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09192DEA90
	for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471654; cv=fail; b=LfuDlNimwEtASUlimPOhJ4jsjh91W4/qydHpUGLCdgmGC9P2F8vUGJaR2F01QOBDFqzpkvVgoHjTK7iM510SsCVIJ66CxZoqm949VAT7pArbw4E5rCm4J6BmhbNd1nCI2Ie4GwMf8/GeyAjalKGWXCH2PLQnTwHcS1Cle8wtF+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471654; c=relaxed/simple;
	bh=VG7O1UrPyRrhDHzCeaoZaKvvmETYkZ1WVD9R0dxiw50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Whbd9/gJai6T7yTv5RxVPNThjElE2lDkWlleclBiRMwzUrUjGwU2xCvW6e/ms342wNcy7UJKK50JeEi40K/tnYN8FggUiPVuW6/uuRBrk0GTFex18JobulUo1A3qVVSBAyoeOj2YDuFrtdTYAqgB9IFy0zLns1zA/i/7dPwOoPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=siulgwT6; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="siulgwT6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtDPOxNXtdRWZuts30/5DpFfjb59wFK50XxhZAX6c3h49ufm30i/NILkgIKKSzJCco8oFmVoP7VzeJLf8WKDceephAVeaDR73erzgsFXAt60br1pVPmPb27pIkMazrR1BJCIflsxI/Qkidm7RnPUnl3HIMd0dy9w4OSz2+BG3fWSGfDa0TQD8jgYu5ns5ZbAJpEfPGqk7/DQue2jdIcwAtjW76jY3cxD0yDSMyLNeg0/XuDYdVxFTnSmVKh0n5Pt3n8xewL1uq+U/SIaVyf+zVL38XrrKKFTE4+BXoTnGv5Vgisy7UKIGQODVotuMJVPu4jAuPGZQLfeND5qJgXJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vudzeWqlYaikN1I9K+pbYS7d3WjyOljKBW0ylcf21mY=;
 b=XAjtCdjCIJfrM4+EeTdvIbke0FaUP9/+RaYRNjYuVNn5mY2l4xiyHW+VDgtJHeLmvMCqC67zvre22JNGJH3n//Ve9FfV4gmD70ZcDWVhBXKMTQ2lCiFEeRKdeM2vHn2dgezifGs+DLdJaf8+9kzmPcWql7/sShiZzl60qo7j8W60LPAfy7JQSzO0wfYLPs7Gv+gnI+vxQgKMa47yJMyDlvdS7x4yDPLfBUENvTlISAaGrDmd6F2t0QORS0eQ+sn8cLlV29CRQk/uV1Zx3Wr7Ebcjel+VXD9L97/xxPVmV4R74LcURho/ssUYVDbE4ntL1+mY13jENQZ9+7VNbmsq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vudzeWqlYaikN1I9K+pbYS7d3WjyOljKBW0ylcf21mY=;
 b=siulgwT6EM0hTVkQQZtwtHGuyk50PUcIkZqtQTPwy/DtOGs75eOJZgqFOkMmEQzSidSmzj+mLC+cfDT58uAkPvLWE/sk71Y4j3kI+nMILiYTz3MJXqqYOgNEL7Q4WKyuxsW/8wUXgTWNjbgyIjmqwohkLF73XksG+3XJKrkn6ePr9nj7U8vSvpBJhHBKBS/j4bYfO2XzjABSSLpRw/NMN4z7HPROi1MRWpirYBdoElxZupvABxpUZjRh8IrRWQRfYoUWLHyhTXLOcx0v5y5M5kWHiLI55px0hps8O67pDfTqMl1wRxgeKjt0/Td5xRNTWOCubTEzHW/+AUa4AONG/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Wed, 29 Apr
 2026 14:07:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 14:07:28 +0000
Date: Wed, 29 Apr 2026 16:07:20 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH 08/17] sched_ext: Add scx_bpf_cid_override() kfunc
Message-ID: <afIQmB4H6li6jL4I@gpd4>
References: <20260428203545.181052-1-tj@kernel.org>
 <20260428203545.181052-9-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428203545.181052-9-tj@kernel.org>
X-ClientProxiedBy: ZR2P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1d5726-74a7-4835-ac8c-08dea5f8a59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DQgYFg2iOYDENVZytGbghxTIdEPfSLqRezddQmzEDFSljKKrOTDhmlRcyzNIM5wsFUypF5qdZ8Lyjr4hzfLB6AZvdPxKtCTu0rYWgg7wB/kx6GTJl1dabq6pePBHirSu4Y97dpcb6bFWwFimjqb9h2Lyv+1IgLqRa17wEKY7Q5bZ5+Iu0sz5UM3Sjd3EAZ8JQaAs3qYWWZmEql8TkdTCpdf2BasKVQSi32bFk03MEc8/qXbyvm7KgrFbe5HhTplkqnRgmTdpHth/TqQnDYTamOu3JptJ0LvXL2bnuJWyGrP/FvmMnlrvqfm1T6ldakLTt2OYQETtyfiqfYbbL5kHd30zyiFKKJo+X6TimaXEUeX5Cloy/079e5vA5MZuVB96GUkIRvbjwqYHYiLaZiaiYMM7vyJeKeGiNRo/Am8etS01kiOhq1fH61HWrFK+Od8vqnxNErhN1waIbX/ihow+BxFdcb9PnTEIXwH5jokMMLpd5QYOd5O4+zHNiCLhm7jE3DizQTfDaAHfhCF09XXFJqDl9wj4vl5Pxcux3vinyF45M6jKkcVIcb10BChYtyasPiJUWk9vQotccli++5PiLJyC0RWpJirjaVqBwHC36/ezbNdESqW/Ln6h0QAoTnesRHGnOVNuXNre8f5vbYXKQHoGhCjvn5pFdPJ1HFbN8N6+2mnbrt7S+AsFc6iyubJmHG5Xz51+M8AUaCjz34ms4XjcdoQICbCV1NndBH+IEoE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6+QxeVtSVfwgED+kFDLB2gSqO9aVNTDtxptPk26EFTp1uAxcidkdpigEhHHm?=
 =?us-ascii?Q?b0WigUmsE0x1SLtRd4qKt2/9XBZJpAAPpArV3q5I/1zI1J0l9fuH/Z+7jShA?=
 =?us-ascii?Q?bRSjuOYquDzNwJb253AKlEu4Uw+/XfJR688ogiLzH9Uic00f8ZBAirjlyCAg?=
 =?us-ascii?Q?OqC/UKXhUcIg3sKwuXTeC67eH2YYQ6AQhZDUUweLdv4k3Gwq6/usmEVYw7cW?=
 =?us-ascii?Q?4+o3hmwAO0khCyKRvcqYTT/sELhiBqEAd9EjrySi6TuoLhceE/8QGJ9LlkoY?=
 =?us-ascii?Q?j647x0yhMZ0D32KI7tEwTaJZsyIl9vLZfgvZ6mBB0h4sGu1IKUwXvEE+bzFF?=
 =?us-ascii?Q?N7rGFgdNcaLqWLjd2l2S/6AcfAsx2IHiwHHbTZB+gGSPntyonUme9U10F0Jq?=
 =?us-ascii?Q?HVQ9i6cyh320F61GkyBQGF178bm+P0hRF80WqqU8wlxwcEaa5XMy/ejbwFdv?=
 =?us-ascii?Q?dJ8jMsw/gcnBRTa1FsVr52x80GVWWFqr+liJbrAVSyqM94f8ll2MBA1ysEnj?=
 =?us-ascii?Q?LlC9coZVcyhpo5vgU5kldnYwDfG9lzku3Wh8bg4puYJ2+rojVmUJteg/Egdn?=
 =?us-ascii?Q?rN4mgWiWFRBBFrOwdXgwGXBQ0QrPLZTRquIVJm5UVA5FA7Xi8AgYJfw+dohp?=
 =?us-ascii?Q?Liu3GxqmHZ5q9Ye/BnH3gHrWh3wguroQNiSYdg+7qodvFXBnefyR9ogc8QxC?=
 =?us-ascii?Q?XmMUUznwbaByoRpl1/ta7/+5DdpWqU5TL8jYxvPYGDyRc9jr6x2DSD3Ydw5I?=
 =?us-ascii?Q?JVEmZ25UPk+aSkGs27n0Ji+Xn8vy/6KJv/ixuS+jikwx6tA7weSugYrEPuku?=
 =?us-ascii?Q?k/koE+g63CPD8smkydSy1CUD2tCm+edDkeTYvkg2itahrb9Bf23X1/Tptn+h?=
 =?us-ascii?Q?J9lbkTEaZ6/rdAWHYorzdmAUnYl/+lRm3XiZVZJBgfOmYzVu23So8SXUoNnp?=
 =?us-ascii?Q?cV68WlOPT1feHKANB5qC2Fv6USNDCoWxndEo7jhVpQubW8A+YlFp3hYa+VnR?=
 =?us-ascii?Q?0RGk2fcC83w6HOhqcy+4FFIs+JuL09NtKjHn7MeCQMvKs3rnlndTRQSPgSQZ?=
 =?us-ascii?Q?2HWRPagANLnrAVYBj0ZvWNeE7CgYVLARizgXhmniHMo4RYoZ+KMvqbLy+bVF?=
 =?us-ascii?Q?AZ1oCq9PzFOXDBtGck9h3n4ISSNLvGKblRbaxxY/sbcTd1ZDXu4rRBwFAZ0I?=
 =?us-ascii?Q?CxLOJgKmPCM7voord/ZV7jQ5prdadmtOxL/BOLtO4BHw9URClH2/w9I5YfuN?=
 =?us-ascii?Q?E+Wxo0Gmj26xxExup5mfVS0ZoL2/FYYfL+OaPBbru/FN9zXE+j10Y2YRZvBV?=
 =?us-ascii?Q?Z02APNY6FyhNud9OVai+1E8VjBddutSNFiNZrSN/GMLtT6O0A5H7jhLZFa9M?=
 =?us-ascii?Q?WbsUw82djUY71tllk1sNUuv6TSrbusDrk7jIZe4xO+LoJUa6tLRm5kY2mo2c?=
 =?us-ascii?Q?VVRKzQYw76S2kHdlcqwazCgNDoonT3ygTt047SXohN67gU8zMn79WSP/JwIa?=
 =?us-ascii?Q?HiblwgxMLCCqGic+kZ+MPlqBXtffWs0WyZhMTbYjfCdK+Gle8ejKodwXj7lB?=
 =?us-ascii?Q?itDQZxL26vkvVK2+iTEE3S+Lg+4ZhfubMbT7zG2w/GVFYERjL4VbalGDT5bp?=
 =?us-ascii?Q?Rpiij1nTj5/PeND2vBzALBTOusqJIBoZWcaphBOtsLFKm5y0DhohngJzPwcJ?=
 =?us-ascii?Q?JI00Z6t/fqqonDIHL91KIVe9xISSqYM/ZnqD0ePEXKw611GIYHK5W4lnWLt/?=
 =?us-ascii?Q?7DCdQ8tMEg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1d5726-74a7-4835-ac8c-08dea5f8a59d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:07:28.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcTtOjP3paVrcymd03ljmp+xeMNwueY4IcMtkLEqW4ofjilKbS0qYzhTfXDfVAJRTcMF4ri+wp2rb2eOc6I+6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156

Hi Tejun,

On Tue, Apr 28, 2026 at 10:35:36AM -1000, Tejun Heo wrote:
> The auto-probed cid mapping reflects the kernel's view of topology
> (node -> LLC -> core), but a BPF scheduler may want a different layout -
> to align cid slices with its own partitioning, or to work around how the
> kernel reports a particular machine.
> 
> Add scx_bpf_cid_override(), callable from ops.init() of the root
> scheduler. It validates the caller-supplied cpu->cid array and replaces
> the in-place mapping; topo info is invalidated. A compat.bpf.h wrapper
> silently no-ops on kernels that lack the kfunc.
> 
> A new SCX_KF_ALLOW_INIT bit in the kfunc context filter restricts the
> kfunc to ops.init() at verifier load time.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
...
> +/**
> + * scx_bpf_cid_override - Install an explicit cpu->cid mapping
> + * @cpu_to_cid: array of nr_cpu_ids s32 entries (cid for each cpu)
> + * @cpu_to_cid__sz: must be nr_cpu_ids * sizeof(s32) bytes
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
> + *
> + * May only be called from ops.init() of the root scheduler. Replace the
> + * topology-probed cid mapping with the caller-provided one. Each possible cpu
> + * must map to a unique cid in [0, num_possible_cpus()). Topo info is cleared.
> + * On invalid input, trigger scx_error() to abort the scheduler.
> + */
> +__bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
> +				      const struct bpf_prog_aux *aux)
> +{
> +	cpumask_var_t seen __free(free_cpumask_var) = CPUMASK_VAR_NULL;
> +	struct scx_sched *sch;
> +	bool alloced;
> +	s32 cpu, cid;
> +
> +	/* GFP_KERNEL alloc must happen before the rcu read section */
> +	alloced = zalloc_cpumask_var(&seen, GFP_KERNEL);
> +
> +	guard(rcu)();
> +
> +	sch = scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		return;
> +
> +	if (!alloced) {
> +		scx_error(sch, "scx_bpf_cid_override: failed to allocate cpumask");
> +		return;
> +	}
> +
> +	if (scx_parent(sch)) {
> +		scx_error(sch, "scx_bpf_cid_override() only allowed from root sched");
> +		return;
> +	}
> +
> +	if (cpu_to_cid__sz != nr_cpu_ids * sizeof(s32)) {
> +		scx_error(sch, "scx_bpf_cid_override: expected %zu bytes, got %u",
> +			  nr_cpu_ids * sizeof(s32), cpu_to_cid__sz);
> +		return;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		s32 c = cpu_to_cid[cpu];
> +
> +		if (!cid_valid(sch, c))
> +			return;
> +		if (cpumask_test_and_set_cpu(c, seen)) {
> +			scx_error(sch, "cid %d assigned to multiple cpus", c);
> +			return;
> +		}
> +		scx_cpu_to_cid_tbl[cpu] = c;
> +		scx_cid_to_cpu_tbl[c] = cpu;
> +	}
> +
> +	/* Invalidate stale topo info - the override carries no topology. */
> +	for (cid = 0; cid < num_possible_cpus(); cid++)
> +		scx_cid_topo[cid] = SCX_CID_TOPO_NEG;

Considering that the topology info is wiped when scx_bpf_cid_override() is used,
should we error if a scheduler is also trying to use scx_bpf_cid_topo() (i.e.,
setting a flag or similar)?

Thanks,
-Andrea
