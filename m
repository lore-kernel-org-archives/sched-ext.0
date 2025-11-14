Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E2226CFE
	for <sched-ext@lists.linux.dev>; Fri, 14 Nov 2025 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105597; cv=fail; b=jtWRIGdMvKCcRxNg/FtK/8eWHrCuqpVcLw47t6zeZZTfJ3QoLsTHMklHJBZ4GRFzPuFs2mg6a10uRum7sN0fXBV8/hb3+AnDgAwtbURm7k3Cwo5bbrsJFHwE38E5mn6ZLOvqqxsesmuR4YjRROP1wLWSBrS6bscpPNdTEjR60bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105597; c=relaxed/simple;
	bh=qU3iTeVzF5SGZkBmJQW+ucQXxqIxB2lemJuehZyfXKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WHChmVVjjYfnDj4sXwwPii0QdA9zskZbrll1/sVR7tt7EVZ6SgJ/ta43ahFnWxTFFJ+CZpPiVeMJAevYGrHQntYLEuAqQLmO7eBuMRdqyABGMt0TTjhBo9PUdIwLuCe/mzL72agvi7h8kR1P3QoAgai5z14BMexu7v9tGBojZeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqY1MdHd; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqY1MdHd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z16EDTI7w2HJs2O899KIqzil/y/LjEtagmV9+f5m+mvaySZH35oZj+q2AG3zPed9hiCWLI/3SSr2URI+9AETJIQIpcbaIs6N0uQTjdI+Co0EodLgQIuI7D2XgMlLAC4GVobXFHSrUt8hQa9EbaFVidoJlqRKIkLXWAcVx/mAbE2sQh35LncNYB8QKD8lnmuO1Rdj2v5UNUhGKaDE1iZ7lKNkLlYYFny2a8Ui7FMFwoYWfI3G7Eoj4uBkZPdYbd9BWS0uQGuo1TRV6AMWTIX6gSjV7+qVZEZJ/J57y3X35GrJI5xIjLTuSiYVc0b93XbYlCMgLbBPsNw4TgCaWDa7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywvAkZTAvTEDCfOJycQ3YpKplN8kk+ufvtbFoeqloCs=;
 b=ZbdTHQBCigxALQEP2K/En92ITtL7X5bmcSFopq38v+4JXyI5E+/0g9/0Zt6xI3Ju396TVGio0lV9Uz/uI6C+sSTZgR54yimcYZff1Q6irDMNtJssz46Aocq9SS8caCWLJXaWw+SrzdrMBoHTBVO/0laedVPKeBGeker2dX/jxP41xiPCixON/anSKtwqKcsCuJ99T1LBvWb7k7MKxCKqDLnrDG6/f2VhHOwqg8v3jN3kRQgOyQ8q48oivrdP/ia5dWj6nsuiHmSt5uJ6tajQKx+7hOax1RAu686fwousgzmefOZ7E547trh5CJCCxUPo62Eer/C7iABu0fmpHVIbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywvAkZTAvTEDCfOJycQ3YpKplN8kk+ufvtbFoeqloCs=;
 b=mqY1MdHdF6tE5cuJN26mbbl6OXAHgLq+bqo8WQMYdbrs4H3s3h+SLttzY0+WRGavg/6wcO1wqh35W+hiXcrtY3VVpdBNNkdrmL5+NPfbArYQUe93zu3bKIP4Aa9fRk/zMBHPCzEkPSa1GQQVTH+kPT969g2gbUCINmYyyCGtE87WEj8hWNbDXT6ACxlzVEHaS/HVLr9raNa3kaUpmaY9AffDhMu01YyU44H4OvuzcWh1I0bewTiyVqX96Bj0fw9l6jWhtIBbcRr8Tz89VeSHhJAbzg+9IPx24lHu9WieCcgb+0EMen9PhuCr4dpW5kOgsvFiA9NK8X05wkyKfiDLmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 07:33:13 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4%5]) with mapi id 15.20.9320.018; Fri, 14 Nov 2025
 07:33:12 +0000
Date: Fri, 14 Nov 2025 08:32:21 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Pass locked CPU parameter
 to scx_hardlockup() and add docs
Message-ID: <aRbbBfVbyRV-SU2i@gpd4>
References: <20251111191816.862797-1-tj@kernel.org>
 <20251111191816.862797-10-tj@kernel.org>
 <CAD=FV=Ujf7PJxBANGv4e6oVa9YMS4sNLvxp=u+=5n5aaAAn9Cw@mail.gmail.com>
 <aRaG9X9xfS_QL2QF@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRaG9X9xfS_QL2QF@slm.duckdns.org>
X-ClientProxiedBy: ZR2P278CA0081.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: f142679e-7e25-479d-7e22-08de234ffff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xNBK8fidZ54oRVFe+PTrjSGL0gXFli4f5cRqLv+/MIZXTTFtq2T3+eCH8x2W?=
 =?us-ascii?Q?+fQ2Gg2rjWqUBfAcKlNkcAdUk4rYHDv9Usn8IGnPq61L8+GvgGFb6/uOHVng?=
 =?us-ascii?Q?HEoqv5LOdhsQUDtL8pnJn8oM3VXUfhRhF5UWJO9KE3TCgD5FXBhGVeBXfzUQ?=
 =?us-ascii?Q?lkGrFsLep7kDMUVzGM2XpoR6QlJfGUfMYAAv/C4nMyz1gd6MXbsUTbb8Kk5s?=
 =?us-ascii?Q?H6C/PRNXminFqT9Xy8E638T2CDJyBmUB4FFQgLluf/vPUjzEnFhpZ0DhcHjv?=
 =?us-ascii?Q?6PjF95sIElfEbB1xboQffl/zRqWADpizcIF2Y7vKPyP9HPyfIuZXbsxePju2?=
 =?us-ascii?Q?pOXase0uhbKNmpwx0fxD+7B0ldGt49gYrjS9UyYe7JaLokEcpS9SW3CUUBMX?=
 =?us-ascii?Q?JRDjI7QlL7AQ5+u2V6u1EMMR0+0ilf9a9VpCAHsyCbgHWWayTEc7RTUXgsQc?=
 =?us-ascii?Q?BLhf9FBomk3GkvEtOhy9AKaZpPLU5AKvvkYP9c90E5Zt8SQ4+rVTgGN30QlZ?=
 =?us-ascii?Q?f/2Hq9L1pNi5vCm5dsCiv4PDaI2sjNqgCbBn9txAnUKkfLPoGjqoyp5ANOp0?=
 =?us-ascii?Q?leBQsiSGoiqEBPv0tYqKWAc5+L8BR5gJQ6Fyq4znguu7nwNSpTj0X0KreyuV?=
 =?us-ascii?Q?P+yxZ7EEoi0aVj/k9GU9cVgxGrGnBb9jdu91gNJ0DSx/PihvDJkv1B6P8j3z?=
 =?us-ascii?Q?G9nnejqbI6eC9/Xc3au9IFB/6BWj/tQpNut/+Hb1NtqVC//tr48X7cF0aHbe?=
 =?us-ascii?Q?JNOVEnz2aEsNHdElxBN/IvxxylYUvV1Mv/jZGc48Ndj0T7PnvLALcGrjnu6a?=
 =?us-ascii?Q?VXWOXW31bDrOjBRagj6sVakCroG1/vZRs6znCdm6/VzDGHM9QRWPd2bjCvt8?=
 =?us-ascii?Q?ohW4I3D0KsRfYHdJIzpC+niGIkfkS2sawQNmUF1+ah8QrFlxIgGlzXX8QTQe?=
 =?us-ascii?Q?UB4qXDKWUDx1RsFd/wQvwBI5fuU1HEUTEIQC0x7Y9h8woD/ILvKo1A9MU6od?=
 =?us-ascii?Q?lfjCEP+4VbmSwPvlLE0PU/7O0//oGY1Ig3rFSwOswckN1AdksIKaIZPyWYd4?=
 =?us-ascii?Q?94jczDx0472/MPdwStABJN38/TO+0MHFfyJ8Pg0o5aFIN06uALbUZuPM2mMj?=
 =?us-ascii?Q?92LpWx33XB3I4bEwt1HApdl1F1DqBWa8uvuoEb6+bITyqqxbdxpdblccb5cZ?=
 =?us-ascii?Q?b+AB2kcpGmO8S+vMtturCSpVbjiTQONqylHTEV06+xCnxMbAOqCNVcGUiwa2?=
 =?us-ascii?Q?Gp4vdGeVmWwFo/VC54sad79kvSP/ZuHBmT6+twwXWyNdYRd4fexh+LbXlBSw?=
 =?us-ascii?Q?j5Sc3npTJwyhRqQpUbJhmE9GmKBifCeXs5jipfIMl16hCXbUBYYiquZlMU5/?=
 =?us-ascii?Q?kSKKBN90JvWR01bXVQcbKpx4K1JTvwn6HfW2bLziZgnWRF6/e9IxKWBM8ZB0?=
 =?us-ascii?Q?cBeyDq0XM9Bb23t+ojJDTTnITfvG4BkX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P5I2WYWp+JpPPasgzgkcB7WA5bsxv26C/Y4q8aSu6baq0hOY1XX4zjjnfQr5?=
 =?us-ascii?Q?eEwRVchwa4ssqzPTKL1lGF016N1aJn+FG/ht+hsHA8N9VEvKswZjwWkgfG7F?=
 =?us-ascii?Q?QwDfJaGerPGgl6da9Dx8rGZHWGUpL3woqPsBEZbTQsAf1F7nIPeyCw1dXZjm?=
 =?us-ascii?Q?N1ArYmECgLq7ZE+xSQpObdFuk/vx/SypkKE86klXK68PacMPe1Kt1TDsVtne?=
 =?us-ascii?Q?jMNJWVIIuv5YLLnJ/fnSFgdheExqxbkkxjTkw/Gzogu955Fy8TUeTha/dLwa?=
 =?us-ascii?Q?+8BxyMUwuaWGY6YIbm8xqogNu73bDLBY0Us+K/HJ/qno8UwGDZuNPAeytc5V?=
 =?us-ascii?Q?Nbxi8C5JUQYDemLtnuEnp+ckLoLZ0mwTLTagvLDPiz1ubXLNDAGi1C4zQvNM?=
 =?us-ascii?Q?lGtmQzAJu7fjk9Ajd7jedXWhEL/DVr8uOM9QmrJae0hFN13ITnkY22oPdkAf?=
 =?us-ascii?Q?hU3C5rdq5swcnlUMenkqWmsySZq3T/jSSEKYpy7w+k11/MJkl5cOTOe8vxu9?=
 =?us-ascii?Q?KQpk6+zbuBl+sgT5+8wod/O3xIznt/Ya4vMDTYEmzuhSkO35esjuzR82+1xU?=
 =?us-ascii?Q?D4QX7y+24nvpZTocH5jkZc0Xo++IrzT59QvigoW5pTiDyfu0TzNResMBi219?=
 =?us-ascii?Q?FHFHqaV1Se4NCiDWDe4hAVTQzE5D2nWM4zUzjfTx/f8ZKSSM/dP8WoZogzd3?=
 =?us-ascii?Q?M8S0HMsN46qlsRShNfB6yhf0MDwp/6Vvpy1/c62vPxO96Hv186gn8cZtYE+g?=
 =?us-ascii?Q?eVcxYbOpNk3iOrVN9YzquGEy/MZRGAsyMLU74NJ0Aeut++mLw4St3ZzL4PQG?=
 =?us-ascii?Q?6ZKZOJ89kdAKyD9iCI7jd3HAEvgAIXHPrpryN7kL/mvrbK2GujGIWhKdStP0?=
 =?us-ascii?Q?uu3xi21+yxRj0XKZ6oXWWyTzxaRX02Dg8YvHzVfcb5zuv1zrZPXwJqoKxGkX?=
 =?us-ascii?Q?AYRzoRvKlhzsk0htoBlb+c77VKVqcb4w4Z/TFXA0P8c/k/EwNE5GJzspF7tu?=
 =?us-ascii?Q?9ohIveuEVHnfHl7iWxsioguXjsv8P9D2RUoQqPLnYY/nw8AmDPR4qPh2ReKM?=
 =?us-ascii?Q?9r7oxErCtxFTu8aeSO0FMiH7N5+e0kRsHQswpPEog7OzCj03QhKICbTYzmU6?=
 =?us-ascii?Q?3sNx3YcjledlUvH2aQCCq8BHs/4mlQmGRWMDnVvYh87qMWgkONFtFIOAXQse?=
 =?us-ascii?Q?+zzsOYKlZ6wRCm1fTAlTiH+sP3aUS1QTzugUHNdw5MLBmr8cxs//A3T5coNo?=
 =?us-ascii?Q?ydPX6Ai/dobLrEkNZO08p6iQmHcUvg2uuZbWJqaY/ZjoPDtt1C/JRkiWDhYm?=
 =?us-ascii?Q?TW9FJ1yCmiVRFhD2dopH0aNLdFjri8iKkQ5oMjv/candz5/XBulTi1GB7SW3?=
 =?us-ascii?Q?eqmmS9pI5B7z8qf8Uo7Yho9RKRkQY27tfXR9+KhY7V7Kib54COE2b9eZyvxG?=
 =?us-ascii?Q?18F3d+8Tdndqg61sloYSXL+FafQfEuY2S+QxzoaYZMDSwbQS6hqHEOBgAGt8?=
 =?us-ascii?Q?QyD79ov5mbBVS8ul+P50ZuwRuX8xa7fkCPaVDo+FrmlMKzG5TEu1e5weMi+2?=
 =?us-ascii?Q?KJSQbiol3Fq2loD8GKUQcw0iwAim7gZ+QDmRm4H7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f142679e-7e25-479d-7e22-08de234ffff4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:33:12.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsyOHLdgmR6Q86aveRgpiGKrH1uL41LN9Ex4wKlkJ7Q9t4w216u0+aPpkRZy4MslyK/Ebrst/GoZ4yZ291ly3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635

On Thu, Nov 13, 2025 at 03:33:41PM -1000, Tejun Heo wrote:
> With the buddy lockup detector, smp_processor_id() returns the detecting CPU,
> not the locked CPU, making scx_hardlockup()'s printouts confusing. Pass the
> locked CPU number from watchdog_hardlockup_check() as a parameter instead.
> 
> Also add kerneldoc comments to handle_lockup(), scx_hardlockup(), and
> scx_rcu_cpu_stall() documenting their return value semantics.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Makes sense.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  include/linux/sched/ext.h |    4 ++--
>  kernel/sched/ext.c        |   25 ++++++++++++++++++++++---
>  kernel/watchdog.c         |    2 +-
>  3 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 70ee5c28a74d..bcb962d5ee7d 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -230,7 +230,7 @@ struct sched_ext_entity {
>  void sched_ext_dead(struct task_struct *p);
>  void print_scx_info(const char *log_lvl, struct task_struct *p);
>  void scx_softlockup(u32 dur_s);
> -bool scx_hardlockup(void);
> +bool scx_hardlockup(int cpu);
>  bool scx_rcu_cpu_stall(void);
> 
>  #else	/* !CONFIG_SCHED_CLASS_EXT */
> @@ -238,7 +238,7 @@ bool scx_rcu_cpu_stall(void);
>  static inline void sched_ext_dead(struct task_struct *p) {}
>  static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
>  static inline void scx_softlockup(u32 dur_s) {}
> -static inline bool scx_hardlockup(void) { return false; }
> +static inline bool scx_hardlockup(int cpu) { return false; }
>  static inline bool scx_rcu_cpu_stall(void) { return false; }
> 
>  #endif	/* CONFIG_SCHED_CLASS_EXT */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 8a3b8f64a06b..918573f3f088 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3687,6 +3687,17 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
>  	return false;
>  }
> 
> +/**
> + * handle_lockup - sched_ext common lockup handler
> + * @fmt: format string
> + *
> + * Called on system stall or lockup condition and initiates abort of sched_ext
> + * if enabled, which may resolve the reported lockup.
> + *
> + * Returns %true if sched_ext is enabled and abort was initiated, which may
> + * resolve the lockup. %false if sched_ext is not enabled or abort was already
> + * initiated by someone else.
> + */
>  static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  {
>  	struct scx_sched *sch;
> @@ -3718,6 +3729,10 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>   * that may not be caused by the current BPF scheduler, try kicking out the
>   * current scheduler in an attempt to recover the system to a good state before
>   * issuing panics.
> + *
> + * Returns %true if sched_ext is enabled and abort was initiated, which may
> + * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
> + * else already initiated abort.
>   */
>  bool scx_rcu_cpu_stall(void)
>  {
> @@ -3750,14 +3765,18 @@ void scx_softlockup(u32 dur_s)
>   * numerous affinitized tasks in a single queue and directing all CPUs at it.
>   * Try kicking out the current scheduler in an attempt to recover the system to
>   * a good state before taking more drastic actions.
> + *
> + * Returns %true if sched_ext is enabled and abort was initiated, which may
> + * resolve the reported hardlockdup. %false if sched_ext is not enabled or
> + * someone else already initiated abort.
>   */
> -bool scx_hardlockup(void)
> +bool scx_hardlockup(int cpu)
>  {
> -	if (!handle_lockup("hard lockup - CPU %d", smp_processor_id()))
> +	if (!handle_lockup("hard lockup - CPU %d", cpu))
>  		return false;
> 
>  	printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
> -			smp_processor_id());
> +			cpu);
>  	return true;
>  }
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 8dfac4a8f587..873020a2a581 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -203,7 +203,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
>  		 * only once when sched_ext is enabled and will immediately
>  		 * abort the BPF scheduler and print out a warning message.
>  		 */
> -		if (scx_hardlockup())
> +		if (scx_hardlockup(cpu))
>  			return;
> 
>  		/* Only print hardlockups once. */
