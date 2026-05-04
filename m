Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AF199FAB
	for <sched-ext@lists.linux.dev>; Mon,  4 May 2026 05:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777872274; cv=fail; b=VQEVhjtiKCkLS5Lm9MmBpn/Qo46/ftXDVX13jpnu9Vp8P6nsovzlj1hkRpeQGlIuqzOLrXMF1qn4UUkkBdEvBd4kpk1yv4eaSmruRM2C33EW1h1AXzQ7bAvmljYmHl9XbaQRYndhHXegPRV01PU5wQHRwluSR5v02ZaHVQKlBIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777872274; c=relaxed/simple;
	bh=nWqmJ8qUDsr3Ns1YOLT7DxTyZnLN+kuQPg8YZc7ERgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f4Gaj1tG6H5P/C2YvLE9jQUj/P0/vo6+PA6AjpFP8OYkItnMvXsUJH/izjcawj2dAf+shvHZkTxofzVwFoeGBtvQAJNAY71BPKunfC41TUMZijmTwE6oRLdrHrSEMTdCJTAI/Z9rc8sU0p3P+zOQYKltTt80b/Y3LOPQEmQUyLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hqsIpFZ5; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqsIpFZ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3vEPjVMzgdxz1BZm3Rw0RE8BXSTlowCT44fiQJ7sQzSqyuQqlcLzxTZ4/gRdLRNBSrhte9cKjJhruZduVnb9xWHPYxuda6kQeciNBsf39Q2JY7uQ94S4oipqamRJEAkIWHjrT5J7mM0urmrj8BKZtaEo1VBdgnBid9ZHF4YI7mjpxvbRlUL/3P1l4fpX8tCAzt38qNbUNI7Sw+a2nylQfsabo25Xm+ZGmy6BKh2KDcKwUVs2EOZRe4XMPoyP6NVROEVsllwyLfVt3ljgwUyfCHeHfNvkjfpywqA6APhohdkvWUbNGJBKN15Iir/J3b/N+kmBATfrl/kOkzBMjXhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiXkOSDcyWlW3poPu54CDb8YUABK1zencFMIhTd4hq0=;
 b=cYE6OTck6qc5G3J1jAae+sw2o3ltQfSPVJSwgCbABQ6b67LPXex01qe3YRCmcNi4+kCiq+tvszChiiQgFJWhdNd4U565tOE6gc+Kszr957aads8HpEwBwWlzXHV1D6rQcQGv3EYOS5KZdWMVf9g+rwt8okUaPqMDN9y6uPTfUoQf66UwWrH9sHJfzSjhJ1OZ1LUi2GFrHESFlB1TKeqWstm47kWehNg04LXn7xgNsMqO1VGmnCnWdV6Ni0QSDWJB00J5+YgH4a2I9afGaWK5zfG7vdOpNgJAtf7BJD82OpkwPF9MR3iurxsGVCreF6RdUdPZjahzkxjQ/LXqIhEVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiXkOSDcyWlW3poPu54CDb8YUABK1zencFMIhTd4hq0=;
 b=hqsIpFZ5YJiiIdvWY1ta6A9r8ZGsngaBw+hb5RX0+4JKr1GDqu9/xw1BJOGaq3n30pCw/4FWzaZCKZrUe7GC77c9GtMDRrwlIipO/4EwlrxET9SUUbrkB+j+ujUdobTD86VchtRR/KUw05woaEweQeAYZTvx/otQfK3codUzqIVo9HYUWqSbRHkoBdXciqMph78x1WvKKErc/5QaamthycPQPGYpHNd2LIQzEpYbpf7B16/qwNsUvxCMAEZTBTai+sszUhWgiBrB5n+AVEQnLVvlaTLIe4dIorzxcnugwra0VAENH8lmTtys0DBCfV1GtAvi9KVz0eLceF++/wDTGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 05:24:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 05:24:29 +0000
Date: Mon, 4 May 2026 07:24:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Remove redundant rcu_read_lock/unlock() in
 sysrq_handle_sched_ext_reset()
Message-ID: <afgtiSECNu9_I7-2@gpd4>
References: <20260430084543.25137-1-qiang.zhang@linux.dev>
 <afgr1Tj3n85nYsdZ@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afgr1Tj3n85nYsdZ@gpd4>
X-ClientProxiedBy: MI1PEPF000008CC.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::43a) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5c6371-d439-4170-bc88-08dea99d6a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LtAcQnsDZrbMkb/B50dz68pLmVTtu82yvxPFisFGxWRJCfCcrv68sOH2o6YJV7FejZ0CFnptepzqTqDZI+oSZbw3GryyQAjfrxZ9pRyZx3DtUjFnNEwbmvV782s1GEWLc03kltTvzvojtTg+yriOSLai8A7vvYqy5PiVyWS89hiX5nxwQaSfldD/i7bLXq0CSEPs8PFBLM8R/K7JTFEhXAEsuD2hN8FsoXcPhHRuSVIHdeOR5KeTWp3IAMIUhuUOgtNmvVM5b93b2shGMfJRKESmpXK7UiLTgAGbpSgrcez4aKgpLj/29UIg/ZsLOtt+k1CBVK33yctMwL1hatgJ8JhEvfdqgRj8enz7V6bQzo4/PH6vSvkecFtPVgFSEdlfYzrkML2yBLkfcRnvudQNiNh5LxBXQXnwpNY91bgTv7dY4Ih4gEljQuoLRvtfNmraMKhDCUAr2nrCwzcQaDo6fTJvOW/7HMfA5Ar1uWRcMLWrKWHfgK4jqYQ55kzLqKLZLPPcwCvfe4fqQJ9VsT53dLtPv4iyCx9gjCHfKX1QkyFC0FORb/H8H2qrZQNHLZ6k5rVT57L7BgyoRICjY9lmkzA+HAkOuqMluLLhgpahw/93RM/749HmwVHpmOce+joNexP6Z5jr6jJ1EPnctUaf2tCfGpHCqtCGyoTB8CErgfkHZtgMJBNoFtxL4oOeJTyX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3WsJQgEGdUL0ONP7ptYVpqfSvbfY6ZV2pe+5RKpZ3yYgvQ4eIbr/o0Z72iB?=
 =?us-ascii?Q?TuGt/ynUr+S7xPWYxS9BThRIvjeu+uji9w0+70/CZxMY61GZbnacNnK8CfSo?=
 =?us-ascii?Q?QwhIFLDWjVoeTA4+MuqOUJYCjIXthvQJ/viCk9KcDSNOFhBr1wxOiyRZaLl6?=
 =?us-ascii?Q?4gj3k+N8cQ/uA6CuSTo7rVymyLn18ksfUrMXFb1Q8HngrsUp2y+EGl9kh48U?=
 =?us-ascii?Q?2ZpO5hkZGfWMAgQDU6na/gEQwsftNeWM5b0t9XTkdeSyHBXQZ33cVkRjpryF?=
 =?us-ascii?Q?sOdA2yKdG/HzEDG6dNruA65m/noHYTc+h94KMCjPrNNatKEic/0qHZ3ZcJfQ?=
 =?us-ascii?Q?oEzm+xUPASH5ZE/L92awCFY2vUSIyMgWRqkj64a6hm8hDF1tY/z3Mx19EcWd?=
 =?us-ascii?Q?I78KJmhq/AJxVKd433FL8NyasOV6xHZMII/pVAVvM9rYMThs2mqaLr2JaXH3?=
 =?us-ascii?Q?bfW8F0HGuilUdl2Jv/wIRdrt9OBQsbOma0sJ6F9EhRSS8V5qAPgYXZd4q6Xc?=
 =?us-ascii?Q?YkiLo0W72TZTAjt64pRxuge1e8ZWzmDpHPBaIPn9ymrq6x0Laa0H4HsCCJ9B?=
 =?us-ascii?Q?WH12i91lK2jC56D6rxXONuxE34LLBP49L5neq94oeBERuIwXqgzD0v1AG/Ya?=
 =?us-ascii?Q?ABw5UQmJ4Dgx4zy8HfxoiiqzkhurpRKY24JJ7AL/Zq4dnVOAMl+oiLFdalKq?=
 =?us-ascii?Q?I/MGA+5obajllllqUxnHQTtMSsI/RgC/aEjtwwAZsB9nH+LooIkPRV6RpTS+?=
 =?us-ascii?Q?f58LP5bW9SGxKS+kVkpE5Kke/uz6t/V8zxnLZ06C9r43ItBy+0UYOSV612yZ?=
 =?us-ascii?Q?SQ5i66RnJTW3zB3HNQD+n6+g1WfrZUIRJNh2gjyr3cIhdg5RqLLB4GG7u7EE?=
 =?us-ascii?Q?JrA2sZS6H7FBO4RjsgCVt4uyJ+iE44tXk+fA29I3GZflKAJsFX4lJdl8h/Bn?=
 =?us-ascii?Q?z/NQmhxqUPH40nJZIcLbnuWgZ3vXR2PmVnQ7hOEc7wR6glcXVBT4i8NuJER/?=
 =?us-ascii?Q?H4SMfpFd5FMHS0DKRbzlNCbmHkJcxWltcecZFfB2LL0BJC65HR0lpechdY5q?=
 =?us-ascii?Q?QT8+dncva7+wY6gMinOmXoYTvZlILL/xUw+0ysTXD8f+OywH7hvflD8Ge6S2?=
 =?us-ascii?Q?NO5bavvYeMJR27bp3ykycP1orekJbShvKPQRd9jV6QdNZntLEsOhYCirivy2?=
 =?us-ascii?Q?xNG7bLIDWqvO/EkegLMu0mRbAMNi1YgO3MV7KuZKXNRvX6Z7kelRHqUsUEDu?=
 =?us-ascii?Q?SbMAVjPGop2+PZ0Isk44+VeRLKwtSM2/QdvcSQDiJorohaPhXcgKEyCWXjWW?=
 =?us-ascii?Q?6HhzD5/cWzo0eOwuP/GSUqhq6WwVvSvD+D8977Ci4Odxnd98ozCz6uBU+NYl?=
 =?us-ascii?Q?rLFDFkGQbAOrmGVb3oobVi2jWRadh5IgaHBY3KCuJvG95w/tiRRAh1xjvvqe?=
 =?us-ascii?Q?nnLtwWsAbOxHhPTIcvnikKoHM5fGOeQXvY6oFeTAdI6GF1Ps5nM5pUH0ZFzJ?=
 =?us-ascii?Q?5uk5yQBsTTnaRctVNtKPLQrTR28hOlyHtiQCNdeHiumAdNFKKFIICH/vSZP5?=
 =?us-ascii?Q?Gil/wYkTlfGD/KhTe7dxSJafSVuecdEvm6NDodJMvR3zkHsW6dxZ0IYuPtSu?=
 =?us-ascii?Q?WMtOU5Fnfn2P4qbGFJX9+gf5WFCdCFv8iYd9mi6gFjrtpVsVqptUUXlBfaFq?=
 =?us-ascii?Q?gGLYA58hKnJ+aOKus3nfkeDzhuZhzrf1FhbHbmNmr5gdx2sC9WvKAjS2TEoQ?=
 =?us-ascii?Q?oyE/9g29lQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5c6371-d439-4170-bc88-08dea99d6a5a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 05:24:29.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzOAin6SSU8Y43CVfPf6O4Odmb8qPycPLpWCYVEFK5DBF0XZONgp7IOLTrLwvwli39gcugpGcm1DZy+j+Tb1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871

On Mon, May 04, 2026 at 07:17:16AM +0200, Andrea Righi wrote:
> Hi Zqiang,
> 
> On Thu, Apr 30, 2026 at 04:45:43PM +0800, Zqiang wrote:
> > The sysrq_handle_sched_ext_reset() callback has already been
> > executed in the rcu read critical section within __handle_sysrq(),
> > this commit therefore remove redundant rcu_read_lock/unlock() in
> > the sysrq_handle_sched_ext_reset().

Actually, minor nits in the commit message:

1) s/has already been executed/is executed/
2) s/remove/removes/

Or maybe rephrase as following?

  sysrq_handle_sched_ext_reset() is called from __handle_sysrq(), which already
  holds rcu_read_lock() while invoking the sysrq handler. Remove the redundant
  rcu_read_lock/unlock() pair.

Thanks,
-Andrea

> > 
> > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> 
> Looks good to me.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> 
> Thanks,
> -Andrea
> 
> > ---
> >  kernel/sched/ext.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 45a2668284bc..0f3e9d088151 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -7953,13 +7953,11 @@ static void sysrq_handle_sched_ext_reset(u8 key)
> >  {
> >  	struct scx_sched *sch;
> >  
> > -	rcu_read_lock();
> >  	sch = rcu_dereference(scx_root);
> >  	if (likely(sch))
> >  		scx_disable(sch, SCX_EXIT_SYSRQ);
> >  	else
> >  		pr_info("sched_ext: BPF schedulers not loaded\n");
> > -	rcu_read_unlock();
> >  }
> >  
> >  static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
> > -- 
> > 2.17.1
> > 
