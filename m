Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA422DF6EA
	for <sched-ext@lists.linux.dev>; Tue,  2 Sep 2025 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822244; cv=fail; b=ZB+4as9JSM7DPh1UYokz7PuUbDPVvitmG1Vr1T3qqnscsQMQQ2GGW/EqoCRG4O4/2CvIVxHhsd7mhaMkppOGp1Zd9hk23LHv9Kd4bElwHtXzFfLfksXMKQc6QSpvVbkJR2g9sOdH7CaQajl/gJAU/I6M2kXNhDs+97sTNU45SPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822244; c=relaxed/simple;
	bh=UJDiOVkkhq63qTJzVhVpulLqxFhswdREyq6QCmY1APE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E7mCOKIt7lCsbHVbmht5R0J9mhbVtc62ARWsOkxfKnTbi94wTcjycVCWfMhdhp5eXe9FG9YqIKJqjDMWju3QpMx5fHoHhgmur/Yf89OgJBX+CuZpsn2OW7G1vdvCyhgp3HYf/pZnC32M45HDJwhR+a9e7gWGFZ4ASabhhASU9w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZpBYu+D; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZpBYu+D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUEPlG16kCy6AQYsizgIaSgX+KtG9vMc0w589DJVVk02mxA0aeZoNYcE45v5PQ8O5vmgNJ8ClD+2xhBmrDTRuzRvVB692ycK2UAE/iactETOFpQ80Xa0OzpA/GEBp5P0ahh4/PHuZf2F6r0EQ9Y99iTWvEtuFlmmCX+ma0XBCiun+0gpzBnse7G1QMnZ6AhVXkGPXOC0pC65LbRcdpatEvqTAYhWyhYspL5zpnAC1lZ7/6HYcxJZVabKo9x4CxH6LuPX42hexXw7+1rrdEumZBJnwjJ7diZlMFe/XRBQ1g6Oq/lnlU8cNgptokmaL6TreIliKyvRVjGcyVtwF40jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSS5ssCPjUufEtQqj7Ki8w24QUQvVDptY7qILBFRucA=;
 b=D/ad7wAxEsxDGb1xF8ESX3C11DQwqAAZK6/wVx8SSdCohbDsesCnkRG5rdklyqwIp8Rh3YoVFQZQ+YXrv8ZoqZ63EfdpepTeogmHdjcAGIjPCOgbG4Z8fKVEdg+pAx9vi42CB0iTBAI5l92atnW5xPukxlBEWfN1cxLDRe/IaBO8D+OBVzCWVaS51MGM0c7YOJeCHm53KTvsA0E20LG45SaicWAg0aqe4yV/QajEjKcBUXOTlPKOFy/DljXg0gFcfox3FSb5XMVCtpydS+tgovwM3A4++EpI6Ur/qCgJFDr+TqgMeb/645Qz3bcR2g+VezpHwFTkS5I7P/0MZoEGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSS5ssCPjUufEtQqj7Ki8w24QUQvVDptY7qILBFRucA=;
 b=XZpBYu+DtoGNzmOve1lGf44SrSmraJbww8UlncOQVsUTpq1im2l4a3F4mGp7e4XvTpF+EASXWUfYHHecBftFktebs9otjwEjSsAhiqXwWyvU4XVeoxIr08FoIiuvpDGZjNwnqhbwBZSFciw3MaAYG6GIwSJbjq/lkyVojJ2yYR2HyfNZqjg2iuaMuI33A6G16dvIt/taarqtDV9TSNDpEcoTSlsgaQ0kn6oLN0lnZzjmwJK5RPjllfwfEZtaMMnQ6252ElU1zELHw8eas16zfmn9Zo0IcR48XD7F1Na0WLMqUsuEsltJJ4j4Ajy/TkI9g/BWSeqvMJPZ9LZCRxIHrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 14:10:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 14:10:39 +0000
Date: Tue, 2 Sep 2025 16:10:36 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
Subject: Re: [PATCH v6 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Message-ID: <aLb63B1THHD-aF0W@gpd4>
References: <20250902111143.2667154-1-christian.loehle@arm.com>
 <aLbb9ljZvAvghZa8@gpd4>
 <9025e90b-3385-467b-ac24-1b1f60767ef9@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9025e90b-3385-467b-ac24-1b1f60767ef9@arm.com>
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d1aac7-0423-449d-0b2d-08ddea2a7f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?872O3T75/PzJ97VPFpw4lK1wXnBdGvUxaW7l6xJTsqMv9mOg4ww9k1Go5vXQ?=
 =?us-ascii?Q?p3aei5IO74/PDIIJGuGmJwHNMPI6ylWOUKz2dONdAMIM6e7uwA46y88CcJzG?=
 =?us-ascii?Q?0/euSy+4OZuWu/aO2tnWqRLQY1zaC+1rjSK424tZlXxtaK+TvTpuxi9LN9eq?=
 =?us-ascii?Q?vXE03jrNtk77u5KA2Bg30jEbHU8vuBnEKD7kF+pV5jZRCFYY0/H85Y0J3bd3?=
 =?us-ascii?Q?3AHVcSLXVqFNkuzYZJKG20JWbJN2P4YqHx2+bsNccAaypb8UTLbuuZ0bzanL?=
 =?us-ascii?Q?jOhcHd7R4Z+/o3qyPxwNWwSb0oBjmGRTHCFUtHN88HLVRndiuEYTXy+l577Z?=
 =?us-ascii?Q?CU7XbRUA04AsO/FqwnljUiPOBSfEETl1EteVSnYpSsfkBO9G/pdhDNakMInk?=
 =?us-ascii?Q?bIQIop+DvnyMG8RaGcf7HLjXt7UWbcyGeFlZqRCyORUy/uxwTTrb2+8PsarD?=
 =?us-ascii?Q?GMGaKtNGicZzfo+f7So+uMx65bbCdV6yd8yz2y95rchFHO0ByNLeSh6QLzDV?=
 =?us-ascii?Q?vmSnIIMIf06klsNpMlCTxUAbgkkUqAs/i8cVIy3kxuXpDKjUKyezyR0Vt327?=
 =?us-ascii?Q?QiR6uVtdoBZeS+5ncTY0AjRWPTzQxl25jUV2y0xPohPIRVMk240Rc4GVeE/4?=
 =?us-ascii?Q?zLs7/mUWrte6/8oZMwq9D5a5yoyLDI2kGBjxVKBT5RtqYJ8rIOzYtqmLFfRE?=
 =?us-ascii?Q?NAmo8mX6fA7tVmh6SeDNQMYzP/pkhBOlJmTNjvWHhD55gKR0PnNbZc5w1BCD?=
 =?us-ascii?Q?7XzYxVQK7XwQUiWXepFfpC5Kz4GrHkFWcTq9+C2WWYKix01HJEL3vP1wyjwq?=
 =?us-ascii?Q?ipabNO7UUp+GAssmVs3dDtMaPoZ6JySSsbuj3NJ7Vgq/yH7UXBnD4D/actl8?=
 =?us-ascii?Q?7tYdpFhC57W42Vdo7evdrCf/CVZNqIPUucyM3QZ+tmSQCpw4xIG7PlEarE5J?=
 =?us-ascii?Q?fd9Pmw0ozAA7PNpejTfBg+BTMRqn53zARbhsX6YaWf4rpfr8UJq0qG8X/8q0?=
 =?us-ascii?Q?FmSjG4aQUnhhEh1M5rkCZqsLp8CbUWrHCoekM0iRdMGElo94ivFR8dX9Ew6q?=
 =?us-ascii?Q?oopKAWdiTOCxlfR6VCDKllwx5CYXRuPgJVakSXCOhqSOa9SLS7aNrmB5Tyxo?=
 =?us-ascii?Q?RlOWsugeag5pT7tbOnwzs4a8+GNfJ0eIEls4wf6arQ9FKzFIApmPzrfIZ4b+?=
 =?us-ascii?Q?S7HIUrWEd/8hqv7oYh1VL3fqhBy/h7e1+CdFhEmOlPY14ukRPHGsmxYAyJ0G?=
 =?us-ascii?Q?d79yW4dqrqK6dc42BX5hp9fo9ECxX7YFpOf8fo7rbAjiiQni1kmQDIRSUQGx?=
 =?us-ascii?Q?PqFC/4zsyTXnLbi9e2wDAlsffeBOwdkU7f0RXmSi/Yl4KHASvbTDZAJepL2S?=
 =?us-ascii?Q?pCWUTLCdOdwIA/M0YMwxL5yJZ46ZN0ubmianFJmoO2nAi2FILAmBLd2oPkVD?=
 =?us-ascii?Q?3vigAf0dY7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ckw52V6Cfb0TfGlM5aOHNwdTbWOO4WLsfmkgGLPq2XJfeDKvlktM+L0/D6Vb?=
 =?us-ascii?Q?9MUcwF7g9VpjxMW8gMfB+fAKPmHvlv1OriGT4DNK5poM3+crpTXdT/yQ66r5?=
 =?us-ascii?Q?r26I+9tapc0dIYEpAUeUIz0LWc+H702sN+p4ZY05kDlsRrAPFFtbrJ/FMl4h?=
 =?us-ascii?Q?vzZhQ1U+DsraFcd83CKsVHCJ3UOFKlcncwcck/AdAK2FEOMH4T7lJwm6luoP?=
 =?us-ascii?Q?Xa28nCiWztTydHZ6IJebo5TJy9285h+dz891GrPl+DKuqp65tkkiW4NB7uGP?=
 =?us-ascii?Q?c2O+XDx8wM1ZJ7Yx8LtPkIsoqq7dR16TiZRZG6+sv/UJP4ekKL0Bp95YB4V5?=
 =?us-ascii?Q?tbhiP3062As6rq6/MZh9kFXNVp9Gi13j1J2SklcYY5bDiqXXrGxQvATijs6a?=
 =?us-ascii?Q?doUfbLJUBkSSQt5umvc4KAbIT3tji0gyLO+T15hBSE16bsZ3LI0ikn4TEfxS?=
 =?us-ascii?Q?XytvA+lATkl8yudMyXNWXw/v2WmiOpbhom3RiYsY6jUvzwiknpr7CdM1OXLs?=
 =?us-ascii?Q?BD0bzikPh0vUYznuGEBSZ4+q1ppzYTqu1LLDObiYPcHQ3j0i4dIhz0yj8zKE?=
 =?us-ascii?Q?F1vSXtUEEKBXxPG9Mz+EZ54VMJhR9VkuqeCjVkErp5RUTOh65/5/gIgJJS1A?=
 =?us-ascii?Q?hCWWhUCio8ilQ5km4HkTv2LZ1bimm4N4995pi5zUyMDhTlKcY/Miy6gM0xk/?=
 =?us-ascii?Q?n7eknaTEt6mNTP60uCiDU/ucBJDwoEvC268W/vSTnSvH4Z9TvdTESlXsR9yK?=
 =?us-ascii?Q?42sgFCAGTcblsP+r6YeSVRRsqsDHpqYk6nlEggPEmtNkt5pjJ+zVj2Z8hDwC?=
 =?us-ascii?Q?D17bThAJ1YxGKXMOc52+qcpxEovgzUDun3zrPTRZjMKJXUB2mohcJeBxzquC?=
 =?us-ascii?Q?KlT1exyFaqfh7WaXJ3+mtTY4pw5mdgKOpPvO2QXOPrZWy7+dmSEVW9tpkvIj?=
 =?us-ascii?Q?jJjvqVfFFKOWp8RqQfXx6AaUIFJ8XTJAioXAUSkJn6cqQk9Cf11vQHyHpiZX?=
 =?us-ascii?Q?uA6jJGj8yZ3KVamgWKkt+IVVoOB+UV79nQAS1T6PU4rEDEQZ+tz8v8IorD89?=
 =?us-ascii?Q?w89cVrCJtBWviISN6ckLQ0H72lYCJicupK1XM9db7Tn13X42kads/c1lzJl2?=
 =?us-ascii?Q?V8IQQJn6/bigqultLmT3mSLNtuuzl1sM22cjY0wmGxbKjVIzAsR731OFQCmZ?=
 =?us-ascii?Q?iis7lIA1d85nZ7KrU8TL8kByysdfcQXfosuP9KL61kKXPlgWizzvM6Wb9mtp?=
 =?us-ascii?Q?t+Dm3iAr19zLZyOITQ86bVVGKCz2qPORe4dfLnHm27fsRwFUs68L5UNkvGa1?=
 =?us-ascii?Q?JeKWxd9zc7tZScQcXaa8d69eCwc0VEzUzSKThqKPb6OPEBrseWQ3UA+8ycCI?=
 =?us-ascii?Q?z0u5pIbegSU4oWkq6fdZM4IKyzYnN/nxSQfDeqqasVBZ9n5WVbsCnnCWna18?=
 =?us-ascii?Q?nota41EC5Y238OCGzR0VaLUSTAfyNQ3WvJ1Bm1ZU09o0fdiaMzX9Zry7xIxM?=
 =?us-ascii?Q?KqnKxvmsdDDQgsq7FqCNB+l9nPKX7pNgea0K427N1QapAiMZdnVPtzlcA0gG?=
 =?us-ascii?Q?ONJuQ8+b+qm+ki5P9ClEPVg7sBTIo2PJS2WgsNlw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d1aac7-0423-449d-0b2d-08ddea2a7f00
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:10:39.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WOiDb44vSUtTgwsQabTjyJGzVLZF6v6obPmQU76VNbRcjQOhHytkiw8Ewltz3/Igj76Gxwu4xXAwlRqOtzolw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293

On Tue, Sep 02, 2025 at 02:53:56PM +0100, Christian Loehle wrote:
> On 9/2/25 12:58, Andrea Righi wrote:
> > On Tue, Sep 02, 2025 at 12:11:40PM +0100, Christian Loehle wrote:
> >> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
> >> holding the associated rq.
> >> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
> >> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
> >> So provide an alternative scx_bpf_remote_curr() that doesn't expose struct rq
> >> and provide a hardened scx_bpf_cpu_rq_locked() by ensuring we hold the rq lock.
> >> Add a deprecation warning to scx_bpf_cpu_rq() that mentions the two alternatives.
> >>
> >> This also simplifies scx code from:
> >>
> >> rq = scx_bpf_cpu_rq(cpu);
> >> if (!rq)
> >> 	return;
> >> p = rq->curr
> >> /* ... Do something with p */
> >>
> >> into:
> >>
> >> p = scx_bpf_remote_curr(cpu);
> >> /* ... Do something with p */
> > 
> > This looks good to me.
> > 
> > We should probably add a __COMPAT_scx_bpf_remote_curr() macro, so that the
> > BPF schedulers can be updated to use this new kfunc without breaking the
> > compatibility with older kernels, but we can do this later, I'll send a
> > follow-up patch. For now:
> > 
> > Acked-by: Andrea Righi <arighi@nvidia.com>
> 
> Thanks!
> I'd have the compat patch ready as well and would send it out in a bit.

Awesome, I was thinking about something like the following (untested).
Feel free to include this in your patch.

Thanks,
-Andrea

 tools/sched_ext/include/scx/compat.bpf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 36e0cd2fd4eda..67594ff99a461 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -230,6 +230,15 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
 	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
 
+/*
+ * v6.18: Add a helper to retrieve the current task from a runqueue.
+ *
+ * Keep this macro available until v6.20 for compatibility.
+ */
+#define __COMPAT_scx_bpf_remote_curr(cpu)					\
+	(bpf_ksym_exists(scx_bpf_remote_curr) ?					\
+	 scx_bpf_remote_curr(cpu) : scx_bpf_cpu_rq(cpu)->curr)
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
