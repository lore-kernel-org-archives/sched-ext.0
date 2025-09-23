Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3E264602
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611923; cv=fail; b=dwDHmsvpPVRfhh2kc6lZUGyg/CBeIo5kVUNRTJgD+naQKlgCVvYdfkzGVIW6fmHKiqRdrxxG4OhWb/37qfxpvepC3XvwenyApAY5yxdsTWsaqRx6yIXFKaerqMl5mpZ08IxcSpScEZAgLq0h1EnqIxkU+ZYKOKTuM3MM4P3tBZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611923; c=relaxed/simple;
	bh=XsoUaVNqIYhUFMAm7VhXvoJZ5gzOGlp3CVn3U6ohj4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gfn3AK3DvVmLtzoFSjsc0dnj3X8XjVwRqNhSHyInBZlXGsC0EXGce+ne870vFQMWB3z86PCq2PW2I/H1w+nKlm+c4MfsjfxPNReoDR1BpeVaN8iBUOMCZCvDyZp1WPdzcvC7BQMAAdyR6ZCDIrB4t1d7OGyZQr30yg5M2BLlqhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UomyOQrR; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UomyOQrR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNZPdtrup9BMSnzGhK3qQORP0VG93TRoqAZCaa4bIyURao9IWvpjOe2YMSW2yH66ZY0cBRdTOSnZj/PgPbYYdFFkSSasbS+OnfqzJKAm7XnWB9m90yeNPs0CNDj0h19eVwbQCwoeMsfTatxPynqcH/P7U1KMxUlM6KrbNSVF9LewQu6oKghjPPtbkQigAzW7ZU6vqui3LAIT6JICqQGKpEUOyZ6Cuj/Eqp/CqyB7Y9BQnmBRAoBHGG2jYU5UDLpMFT19VhWumDfORLnGZk3fJfmnrEy0HreYXISd6Xu209JdIUCoZMYgwKIbb1jLhmPra5yUoduilrfes8OmusL5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQpcuqst9mKk3KNQ3S3yUhdEZCQhGyU9kuSnRSr0ecs=;
 b=hfhzV5c2qkFI6VWvPkNbbtkMCwDBAx5xVf16D2m6SMjR2Nd3RtezEXx6KFWAIbxByAY2w8z3pZAloJjYxc5z9DJVAfy/NIOFRjnOb9sO5FlhpGPeGOUDH2ybJZa5PSn+vc1T9X7yeGCAf2D/Uhksgx4lijXJHTowWknAlq7wkQdXLCMPLrB85F57yUUL+OZD5uWwF1iM9ke0skTKyusAb6LQ7IQE0UW8CvxNc0Z+Cf0/QFprzwB0l0a+FAzHHWw80hPDxDjnf5gx/2/Py0bY4Bkxj0/ULclbHHqUCOVa2Lw0NF1tNx2AHtAc8x5Qd607FuVP60fSZ4U4OIUJMyVBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQpcuqst9mKk3KNQ3S3yUhdEZCQhGyU9kuSnRSr0ecs=;
 b=UomyOQrRAxPV5FHCY45RZVX8HwCrPIgtmKdX0csdPy3oYw5wUFSBnkEZV9TwF9pHpheezaodfWbU7iUkkwFwTSlKuvFEVWo13JIhs6UXjf1+M33H8YtfqI5V/hD/HI1xWAGzMCw/+pi5FRrwu69DLKSXozwdvPNY/sRP/IR4JTDzhsrWBBPJOqnJn0eo+lcK8Hp3cjHAEvYZtOf68qSoIzlXGw+OQlzrs3NFEbZy23o2or5Bum/sWsCDNb6pWyABKPS4fHhKCXdveB8yzasMrKOzmYYf+2BnD0xPWed4gSLk67y6r380pSoA778wppE4Er7nyQDsRVwQGwYzskdH+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:18:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 07:18:39 +0000
Date: Tue, 23 Sep 2025 09:18:33 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of
 rhashtable_lookup_fast()
Message-ID: <aNJJydxk8ItUpBJd@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-1-tj@kernel.org>
X-ClientProxiedBy: PA7P264CA0221.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a095419-32e5-480c-4eaa-08ddfa716b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+K22e5lV4TNbNe7weCZ7Gj0CW8e2+GB+b2QJ5/QUVDF4WkK1ZXPLikPSTYYU?=
 =?us-ascii?Q?lTm7Eu0F3R6MteUeaED6CIGEGze2+/F+oZWNaua/cRN8R68gfIly5bli2hN9?=
 =?us-ascii?Q?RYZr5/q6WbHQ2q2/l3NIqwzjzhbXVbGKV1KrKFOaNjNUBODmrwLc2NB+7iOH?=
 =?us-ascii?Q?9FqZ3fbpFPmI+SH0uenc0zRQGJJcLQEvgm1bIu45kcrPGUFgl97poSwjgicJ?=
 =?us-ascii?Q?YrLjdUJlIzzoLJH62hozhNRE8YsDe/t2e0wQu3WAs8TDzAxdOJAkPdJ3o9R7?=
 =?us-ascii?Q?tpBuQIVJXdqYWdkl14yuouEY3D5ySpFpGhdkEwVZaMXbEnhPog0LX+atSrMw?=
 =?us-ascii?Q?d3fd0sS18nbHfRfMx2s4xcXUBeVRuJex8UaatoM3X7vzz0AbtJzleU4fDsmz?=
 =?us-ascii?Q?5syVZM4FJ3ZTRo1g5rR5wjZvBzlHvcUhhWx259p2b7JD1fA98CcjHYAmhgS3?=
 =?us-ascii?Q?S9/TLLTH86Ty66Z9X3SANfbWvgLA6pN0DIjGhfApKZxpmeuQF8QqR2mnlWS6?=
 =?us-ascii?Q?XtxG8LEASKGUeYk4G4ots2lSfsPoCaUnP4Mq0KnzcMk4FimoPfd2yUpQqCbH?=
 =?us-ascii?Q?sEeNeQcFwfVlSJXhdT9hm6oowha7e1cfQ8mOR0J4mWD7jiDc+xuiZXE3X3mm?=
 =?us-ascii?Q?3+JGFx2y+6Wz8E4O5N/i2BezUhoCeiHH8cpwziIkfuq9qJZi8wn92Q5EI67w?=
 =?us-ascii?Q?fckSSwbbOfPEgqcrwTJDFbvmQJQbqw5swbb4M7AlkoC1rmpOl6GjyKr/wz+Q?=
 =?us-ascii?Q?bRbUMZXqL6AzzGH7FwY3RVAdnjQPPqZ7cp9IBEFfI1NfbSBEjn+raChipfe+?=
 =?us-ascii?Q?EAIFDP9ijcIh54pWRPGB9H/MrGQOTPC3YNSbfaXNb/X5MEzkiBJOckMN52Vi?=
 =?us-ascii?Q?X5GicZySZVgwyNv3Uuy2X/43l5+WHGjF5ocyKzOhTSgVJpqVvPK7L6R8jNNg?=
 =?us-ascii?Q?D4m1czSSLRsWEUrRqCj47ZeFa7y2JKiWGv1SrAhWPuVpkPVa+m7Y/olXhTDW?=
 =?us-ascii?Q?iAi52pjwqJiVqA2+R17YpWCjk/nOvQdRJmfw40BwIKxKg5Pis2sk5drimT3j?=
 =?us-ascii?Q?Ry6AgeVoPSpBYC4riywWJSwlALEpLHly2wz5TWHgykM1d2qaAiabvVaw6ocu?=
 =?us-ascii?Q?27KTby9JR6mqYQNKjmM/80wHJPL7DCGVvKYUgKwmyTaI1szBxdbjn4qqwyOj?=
 =?us-ascii?Q?aJDX/qHETb+HHuO9yCtCkt2ofIoGLRQqBwpojDvFKnKsmKCryZWs/8QwCK9F?=
 =?us-ascii?Q?7ZxsKElK6wgaWNXu38TFJ7tCOMIKGPEXzv/3o7HSBv6u0RDzv1dx77NWfM2J?=
 =?us-ascii?Q?uCz4cSkhL3WLNzvx+SHA0p9x9H0j0zvbKUJG3SLy2nEIDuBNQ9Hvu56ETmkQ?=
 =?us-ascii?Q?/EGveEnQ0y/Rke7e85vV53WzM8fzhZ4XVontnxDADevFSBIwQnfNJ+8Ysshe?=
 =?us-ascii?Q?ic2hDCyPHsM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FEwFj7Rve5tlvQyycBo9ZPtSVAJ8jR+lb9OahUs9HODGlq3yyy/0dFYa/bS5?=
 =?us-ascii?Q?qcXotEIFRWeU/TXFbM7sW5v1FGbCWCsbpo9KmSA5AK/p9R47cvv3jukqVr40?=
 =?us-ascii?Q?SB3WWdAtfmPlcOuaRhc2E44rzDj+IJSnVSlvNm1UcRpqsoFZHsM6ULl/E0cN?=
 =?us-ascii?Q?NLTDpBFLuYlo38ML+eFq4n+0NatUaz8KpVGORhS/6L57EOAamQQBwDDQw8hR?=
 =?us-ascii?Q?mz3DJ8ggluU5tQONCRBOBssgvQoL35aTYFuFFDtpSzO+k22VI4VUIWmOHLXA?=
 =?us-ascii?Q?V0ICN5Ddb6HoJm6m2okA8erBRneCGBgsyz2rS4mnt3ys4mPh+L7CJbqHf18e?=
 =?us-ascii?Q?vA53TVGoSV1r0qHaxT6yJbv0hbrDXhevpc6R3p87Kcs+/tKKNlD6yEBiLODP?=
 =?us-ascii?Q?u9GQFiTosKZJuUxRTgwr2qRxrrkYS1vJO2R+lg/wY2UCDBQafnJxnTUNWwLC?=
 =?us-ascii?Q?LaheVHb1AapVli189udIPiIDVN5IC6dBL82u0WykZz35U6QnORfvjTmQ277x?=
 =?us-ascii?Q?eKpuGdd68g/rGrN6aPvfxVtSAJE9PqQJjYXhtctfT+hX0icFS4UcNB0uM77N?=
 =?us-ascii?Q?xfZtUt4B0Jut1vyx61bFzkrFJd4Q1KVT+hGh4U6bGjbQcoE2ZeHtWRIW+UlW?=
 =?us-ascii?Q?J++rse70gixen6+JgKNMJbnSvJvYWqLRHCrg26CD1VgxNCN9pesAeP+GEZKx?=
 =?us-ascii?Q?ks6WS4eVUTKoujz0Dh3br6cS2wzhbsVHwXSmNVxvqfBIqOt3ZbO5UOFSKRNF?=
 =?us-ascii?Q?YfNVcX2WooPbtkEC07npBitGudlF1VWwTmz7OdRKmq6a9EQdz/x3pB2rCr0c?=
 =?us-ascii?Q?QNyTWh8McsE8MAmrzOi0SnKKCaswZNl292Mq0pIqvEfjhzxoXmN+0zgKhR1b?=
 =?us-ascii?Q?kQc6l0mT2aQVrNS5nqaw/JkbBEZaYfc0bjIN/qo/tJDIDSoO/et1zoaFozvi?=
 =?us-ascii?Q?CxYSoJhF04qzRar8GSnB5J0lp8jii/0nDaYrGTi57upqwYgS9ANAk2su2rC3?=
 =?us-ascii?Q?UpGwWKKlIhXa0GOdT3xi31VwupuXFaVTuaHBFkl+ev5S4uBgScw46VbDqCRK?=
 =?us-ascii?Q?PMlHuC0+PC0tp7/kd0xh0n85lsGS89610rPGjoHOPDWBPfoZkcHoco1vqJmO?=
 =?us-ascii?Q?6zXGFdeqouBqdxhJAefaf7AUbLxizX6Q6mDiks9/o2NrNHYgmGkcsSbSftBi?=
 =?us-ascii?Q?CfNmAVZdNUsPxeJXC5LknmppueFkKC1s0W8SyFTBnwBc2qj0Bc8K66lyAHvF?=
 =?us-ascii?Q?KVmGxrkY1eTBkCG4jL2k4dBzvuqs12w/pbHxDyfIoT2AHNxbaWhvVIOcEHf+?=
 =?us-ascii?Q?ojHD+TIhguVL44mVlEAZoWR6KJqHGvSO6WO8QD0bSdxmhJ4TMgHETozPdP6I?=
 =?us-ascii?Q?1ngLzLn5nDp/3MSJs9GY4qF6IdbNJmDbE0ENa0SMp1rfdaIdrVU1T2OAC/c+?=
 =?us-ascii?Q?ZR7ZbfOqhCumrGepDRM6Oeo1uRbZO3Naur1vO1SY2i2r9STNwAMZT3jNmsU2?=
 =?us-ascii?Q?4pBZY7e914N0zt/25AyPQVojVi7zb76CR4J/bTN+FxQnBTxb7c6OLd5hNguz?=
 =?us-ascii?Q?A9SjSfa4OZ6wLIVLXtjNtercG8vpU7empGIfHoGL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a095419-32e5-480c-4eaa-08ddfa716b1f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:18:39.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMFCN9USaoK49NGcyh5WaAKoTsDohMsf3GPRUuRRuoArHGMb1RulozVsmJBckDoe0MFcePyPJgBAp2vOpe/6BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

Hi Tejun,

On Sun, Sep 21, 2025 at 03:32:40PM -1000, Tejun Heo wrote:
> The find_user_dsq() function is called from contexts that are already
> under RCU read lock protection. Switch from rhashtable_lookup_fast() to
> rhashtable_lookup() to avoid redundant RCU locking.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f5873f8ed669..df433f6fab4b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -207,7 +207,7 @@ static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
>  
>  static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
>  {

Maybe we should add a WARN_ON_ONCE(!rcu_read_lock_held()) to make sure the
assumption is correct and catch potential non RCU read locked usage in the
future?

> -	return rhashtable_lookup_fast(&sch->dsq_hash, &dsq_id, dsq_hash_params);
> +	return rhashtable_lookup(&sch->dsq_hash, &dsq_id, dsq_hash_params);
>  }
>  
>  /*

Thanks,
-Andrea
