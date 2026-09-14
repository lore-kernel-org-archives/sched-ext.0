Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6A44C4EA;
	Mon, 14 Sep 2026 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388492; cv=fail; b=GVN857v76VeqhS9Y8ZrleP2TOCwFF1MYtfwWkw63VQthGZVjna1QDfXekfVtfXDTvh48S52ff3MaVl11FmVIYaXsC2qKws6T1sXn5KpvgkVVXUATglnXC6xbaO4YXZ/5vUfeImc7jVQhIuyYQdgmDpaI7KckZ6dG7DXQ5W3+FOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388492; c=relaxed/simple;
	bh=DPbUHz8iK+JtmCAWBeTB7jNJlO/NhH+gzslwSP1XjOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TOzw/wovALngk3cWtRDOy0GzVZXRKKJJvTm8uN50pmWWk1G4NUBZCRPD9w0/XorrvYxyANVT7BwaLEBI4h+JXcT4VHZqvQ7F9K5qpiiY6ZZzhBKQHbAeP4MVqmu4eiRh2xSuBgqTUGzJ2S6yYZyVMU4dB9yLH45db3s4ogy77EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aRi4AXDp; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aRi4AXDp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NL9zwrwJbOnluva3Pa1rZaYjs82UR+y0j3cgybUYl91UAHdiuAxObYZqzTFVTpH/Axoo8bxN72kYRYNJwXAlfZivWlx4GFleNeK1Q6aJ1yaHLLBpEteAEjlOwXdd0Jy5EXMMdlHE1v5VeDp1ExYhlnBeoletTZQGdzZcYTpdbYVVora+I6V3m41sPvaO5ZFv6/6emfsx3/pDkRXGm8GXaY1pP/xkLtqqedkKwW5jk9TRlhrQL+8m3AqZmmujflNnRaO9raGTyZ41UkZ+4sXGVq3Fum0UwxfNqqnOxTUm+tWnnWAeEttJNQsri9ALoTzMVKbcfolOtYzYyhnprxnaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re0UVsFLztwOlOFSF5HEAvT7ur07dUE08Y/zCzMghHE=;
 b=H53elitrJfhKDzvLvUe6GOx73wxDZ7ATEmL/QRFbUNirLIzrntBAcmPqgdUxKNsIOqyDUP7k1wmfUaoK1Kwhh8oOrkFsprFKY5ul4w3Niol6nYNxu0ue97Fz+XTyyJoahBCMerj+9RTWNSZnFG8zQc+oYUJ8xqKnweyfWCOuoNdo1krcJNGYpKq5tZnb3plixU/sHXnGd067vDstq7Y4S1Vadc+dap8YnooxQ3M1X4tzK2GVeY2Zre0QnbJp7mQw6yWzKR9rWrDr+UzN7dtK++GUNIG2BHeezgSUPVbXcdJqZjYcJfIt2G+CBVeSmTL7ekzT3liM/7gERqQPVERPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re0UVsFLztwOlOFSF5HEAvT7ur07dUE08Y/zCzMghHE=;
 b=aRi4AXDp/kx0NiFx+xKm+I713Cse4G35sqbb6r/X6t87+5GhFBWifvi0FyjAQwQfMKM9VcMUqaQ+lXExKxa/dT3Y71X88j7SV9zvLkoTVpLNxyPPJ5elwfWUbPMiy7hk3NAZKpsb9r1vCeEv5TAUSfwZmgT1T2+CNIGzBPkSeBO6qesqJpsIlWyfEhdM0l0y/dq5u8t2jfqyukzA9NwOx+OaRcVKFdKqByPfb9RkIgI12LBfdE7rMJePQ4ZR5rkr8H7xTkNE+ggIS8lVao9gmADJ+cz3jaJETmIld9kxZeWnTFOBbFVSCG+1m3WJVTC07mHM6pFWa2xZdja45FQiuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Mon, 14 Sep
 2026 12:21:27 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 12:21:26 +0000
Date: Mon, 14 Sep 2026 14:21:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Message-ID: <aqfmv__uhZ0ReyLo@gpd4>
References: <20260914084955.1798562-1-arighi@nvidia.com>
 <20260914084955.1798562-3-arighi@nvidia.com>
 <20260914090155.DE2901F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914090155.DE2901F000FF@smtp.kernel.org>
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f87d46d-0538-4016-442e-08df125ab2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|4143699003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Z4jUcDagKTM4T1DcI9zkgc5lDscdxyx2PXnJb0qVbdqRKcVxZo8fpRbK060CdsAN11R6ofBoLTz2EXLQAYtIntqRk0jbnIboRQrJpuqXx1f4GqiIQaGqrRpBv6oXb9fa9blnEQpvKlQ6+k/Wrjmn7ncOiLMrHvbEtaFD5rhgSMbNa4sWMFlVaJyIr/KI38+vznU6QoQ+nb/U1P6v2ksRlQHEsIgNMJPvBQArfeDSkn9i3aF+cK4aSFyUa6W23IQswnwSCJNzk33uJGstOffDnyoGV4Y/BYJz3w9+TsFfszD+JRATQOkD23ExNXM8sQ1XtgxGJptrUGzKTPDihxX3MWvDKmpdiCo8L1Wi218d1pDP/AD8FJbjllqevYpsh388115OFik6TqWWgP7QDRtXFwC4DdqUD6+dx0e+VjNtiUeiFBuadmpXcSksq2wd6/7cyq7b0qq9uljk4/fGr/x/KpEi3616Ez1zqMX72nCPEluJ98aOPHAr+fezxWnRIat0epVhZwGB3zoDCRW8vqXO+Y2YcMbruRUN0Dv3rx9x2iBeqU1Oppj1qVJbj8Ah5E/iJxslwXDjImLNoiv45Yti0fAwvYjbWz6jiOvAiaRu1PUOBfzJfVjKCBwSbiaF5OzB2oHGSZgOa5qLaNz4qfVwS9TUw/FP0YIUH0DVZ9Rtm9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ERHrOpOshyXQjSDHcJ9Qw1RiVBnq65CxtSFdVH0iiIvFhZKbL8eH3hefhoi?=
 =?us-ascii?Q?fPM6PwiLpumBNvVP6JNajTk3qPSoi2QAwhEfT5/9WaWaVHcK0+Wz5lYWl2ON?=
 =?us-ascii?Q?AdvFpec/LOaTKxQwo+JjFMVU8W++V9BUfT6TB+jnxwp3tXbDno6U76uwsT30?=
 =?us-ascii?Q?dISU6Q6aqEH7dKSFRQLv+Ws/JjbZWO2uLEN2Wv0tIEFVXqGZSd2Inp7WakcL?=
 =?us-ascii?Q?IDSAWMluAJTLHf6hX/GHkulmc/O1vmDupiVDd8n0SyAJCRyml0CM9FYbsjBX?=
 =?us-ascii?Q?Ke0vXRXtvLF52wBlEAl73WLAuPHs6/vrYrDG9VgYaSy3gdzH12+NBPfyWNAt?=
 =?us-ascii?Q?/3s2ladah0zHRqPq9bDfI/7zz404WeMYAf5d8nVvyG76xF/xMouLFIS4Dj17?=
 =?us-ascii?Q?T1eyjD23YN9r3hLIsViuFC3rkYXr7V2D2Ib7sHLnf0x9gheMeapz2Tslanoo?=
 =?us-ascii?Q?82FPS5Ow/ES6cEbbt8R/EIBwbQYHGAyssj5Sp7VGZ7TW3vt4/iV3woyiuRS1?=
 =?us-ascii?Q?6mP6ld4HGx8aPA+JoeK5ydgUZ9SDnRma2VbuPVkIRzkjtr5aO0km9me4wNb1?=
 =?us-ascii?Q?ne8Wmn59r+jpKE0RxVLEaePbZc/i6x89doJu6tzbmwdOt5J3de+n5Msy6nzF?=
 =?us-ascii?Q?s5//P5eU52utK4SdZ3UTkJomBKUN0fCUwPg4+FqYp4A/3SNvZq674OYXuZdX?=
 =?us-ascii?Q?h270Ws8XGDdR3hdidXVvXRe31DWSt1wPBbCjDSGXNSHR793kACYr0VId8uYW?=
 =?us-ascii?Q?pcprzz/MSVdd/X9iKrGs/13Gbj/pIPyj7YoaZTk+1Xy+3ae3cIEkLYSSxFhX?=
 =?us-ascii?Q?ZNs7dWsZOSFCUdNuzLYibcCnWvvBhiO98NxReAC83xOEYiQ0RD2P6jOfZykX?=
 =?us-ascii?Q?Gvo1GWijhCX53/E/HfcmOBlsGsMMtkSIXkPm+O1m8v5+6lPkCNXCjPYJdS3g?=
 =?us-ascii?Q?DHnbxeWqLZE/iyq5y/dU44UmjRPtTR9d+rphZtXT4yxCl9zhBFoA01aUQ5Sj?=
 =?us-ascii?Q?ZJR3MrM5dHQe2XoSfRkENQrHHSk0+2wyU/mv9EXWYb6T3zteC5NPLR3uA+/p?=
 =?us-ascii?Q?VQfwr9viH80//xi8rfwFT1b2Yw5Bv9G9YLs+UynbNm5BHzNCtn98tzTgMniT?=
 =?us-ascii?Q?ehKa8zye4ygEntF+5Fily5rewbIuWbxdLg8TXoYv7fyGokFRuhKBASl0Y0jA?=
 =?us-ascii?Q?6uyCC3ULb8nGF6uLStwIBx3Q82GFxHlbMuTYbyBom1WEL/iovmngi3epG5EN?=
 =?us-ascii?Q?kr73rWUCbL7HdddK4ln02z5edMal4jcskqB3pFUtfL8UGLlfPBU2p8RD5RC4?=
 =?us-ascii?Q?z6RNcC/r1Rb0X8MLzFXBeV9GRxWIz22sB9LB7nDLoKctrvLsDLgogxu2FZ/d?=
 =?us-ascii?Q?AYnunUdRdwf3bRtES5HO9hpkM47vq5vMJWJ5WM8g+kqSd25IMMhCV4Zwruh1?=
 =?us-ascii?Q?odkeF5etbe/Siwx8sXCEXNbuVT9pNTXa17yQ5PZgegmyLhxFGH27/Q/jXYqR?=
 =?us-ascii?Q?Sv09O+nyo473JhdNQdfs+l2gqtRLjQcs6dd3GTX5P5J/onmGDId++vkR7w+F?=
 =?us-ascii?Q?xJJIsUIWqv4/VWf4SnqTy6N6yKFGe8XKLP/0+k1h0fbHT1+bwMnHaHVCV0e4?=
 =?us-ascii?Q?EtLn8Bd3UBZ4kO51D5iXMxTGGv159GD66VoLABaTEmPJC1BhWW1wOZIenlw6?=
 =?us-ascii?Q?Ki0J9tkHGNIRd1EPMVrcjkNsY915MsIk0VSNRUK0U+Renv9W63V1ezoLTeXS?=
 =?us-ascii?Q?ePHkGDr+8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f87d46d-0538-4016-442e-08df125ab2e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 12:21:26.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GswUk+IZWJS95rY9hfTkPn6kI2llLOn7NDAEijhVXTohp20GZPRZ7FhSMy/QGI3t4XPc4ZD02PDZdWo8taHSdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

On Mon, Sep 14, 2026 at 09:01:55AM +0000, sashiko-bot@kernel.org wrote:
...
> > +	victim.pid = fork();
> > +	if (!victim.pid) {
> > +		cpu_set_t mask;
> > +
> > +		close(ready[0]);
> > +		close(start[1]);
> > +		CPU_ZERO(&mask);
> > +		CPU_SET(cpu, &mask);
> > +		if (sched_setaffinity(0, sizeof(mask), &mask))
> > +			_exit(1);
> > +		if (write(ready[1], &byte, 1) != 1)
> > +			_exit(1);
> > +		close(ready[1]);
> > +		if (read(start[0], &byte, 1) != 1)
> > +			_exit(1);
> > +		close(start[0]);
> > +		for (;;)
> > +			asm volatile("" ::: "memory");
> 
> [Severity: Medium]
> Will this lead to orphaned tasks spinning at 100% CPU if the test runner
> crashes?
> 
> If the test is forcefully terminated or crashes before stop_victim() is
> called, the child processes will be orphaned and continue their infinite loop
> indefinitely.
> 
> Should prctl(PR_SET_PDEATHSIG, SIGKILL) be used here, similar to how it is
> used in spawn_gated_worker() elsewhere in this patchset?

Although this is a kselftest intended for a test environment, it may still run
on a persistent test host, and these workers spin indefinitely. Since I'm
already planning to send a v3, I'll fix this as well.

> 
> > +	}
> [ ... ]
> > diff --git a/tools/testing/selftests/sched_ext/nohz_tick.c b/tools/testing/selftests/sched_ext/nohz_tick.c
> > index 028f54391c2ca..a5266a5412935 100644
> > --- a/tools/testing/selftests/sched_ext/nohz_tick.c
> > +++ b/tools/testing/selftests/sched_ext/nohz_tick.c
> [ ... ]
> > +	/* Repeat with a lazy kick delivered from a housekeeping CPU. */
> > +	__atomic_store_n(&skel->bss->phase, NOHZ_PHASE_LAZY_KICK,
> > +			 __ATOMIC_RELEASE);
> > +	victim = spawn_gated_worker(ctx->test_cpu);
> > +	challenger = spawn_gated_worker(ctx->test_cpu);
> > +	trigger = spawn_gated_worker(ctx->housekeeping_cpu);
> > +	if (victim.pid < 0 || challenger.pid < 0 || trigger.pid < 0) {
> > +		SCX_ERR("Failed to spawn lazy-kick workers");
> > +		goto out;
> > +	}
> > +	skel->bss->victim_pid = victim.pid;
> > +	skel->bss->challenger_pid = challenger.pid;
> > +	skel->bss->trigger_pid = trigger.pid;
> > +	if (!start_gated_worker(&victim) ||
> > +	    !wait_for_counter(&skel->bss->nr_lazy_victim_running, 2,
> > +			      PHASE_TIMEOUT_MS)) {
> 
> [Severity: Medium]
> Could this wait condition cause the test to flake by relying on an absolute
> counter value?
> 
> During the teardown of the previous phase (NOHZ_PHASE_LAZY_ENQ), stopping the
> challenger can allow the original victim to be rescheduled, incrementing
> nr_lazy_victim_running to 2 before this new phase begins.
> 
> If that happens, wait_for_counter() will return immediately here, and the test
> will proceed to launch the new challenger before the new victim is running. If
> the new challenger is scheduled before the new victim, the subsequent check on
> nr_lazy_kick_running can fail.
> 
> Should this wait condition account for intermediate preemptions instead of
> hardcoding 2?

We can snapshot nr_lazy_kick_running before starting the new victim and wait for
the counter to increase by one. I'll also fix this on v3.

-Andrea
