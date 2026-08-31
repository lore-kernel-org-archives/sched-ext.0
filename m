Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF405419AA
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183972; cv=fail; b=osWrvxdo2tWTS5A1Z+gxoKLLdRLx8nzDEBPoyAcUjv/m+RdlN7r+AhkxkhKC2DQjvqav5b62gTf8cFAyu7zj9aggeJACuYV2x3p6cgDAH3BITlPVhBc4gXiDwK0X4n4/HQ+m8yDYkByDh4+jCe6cq1+ZCO+F9Lu0aFxXB8lAPWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183972; c=relaxed/simple;
	bh=R4jzsFYEnIaUAe3P7VSe6pLAxM6Dgbg8ElRvboxzaSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PsYpF6hGSYAPpHjqEu8U2++7QZiQlOZ0syWbkOauESRtW9CLz4u5V759KDexfsbJ18z+0AG17xxefr+we/jP6fEVSpYPdXstltUt345bfD4aNgleQj5dqAgu883q6SE7TxxbwBWwZgvgZHbNmevtKQi4DBWMc1ZaDDwmW8yO7i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fy4vMYGf; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fy4vMYGf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqmDK1gDhV6Twj0ifdKhEWfzVuICNOSVb9DUv30L2u3cbO7as+Gw5Pjk6/stn9MHUs9dcyUbrwijmZPetWIcSAqlEY0+QayQnXT/kTJeXER29jwPF3ktYhqwEIY0P6uGTXuCoxNaEvz6NycUkyFYv8WOsmyd6ELwurzOz4WkHAKLzm3iD8GA2U5i6ztRyVDsNm1OWsPT7PKmXljshW0VfNtaY5Za466lF+VvU80jQYe5GAxtkDCV64YeuOQiCAYZdh1aWxXDW6EPreFqGfHU5a2A/dSY/2G7O4ErK/km1YtpTwR40Ru3eC7nWdVawUJUsGUyhYAEB4nKom9zhawFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8oIIx5qCJ/qG+Xg6UxdAUrUxgKPrJ4WQy+5Bhc1krA=;
 b=txl5Sc99guOEwJA/INRv8sCXLMv8X5T5GWAKqk/SvNNjpW4YgIZxtrhDDifGBp3qfkcDGLRwG5CZiKnci8gZsyDzoKzE9UzTNHbn6qUnJTYOCzW8fMaq1hthOgHCJXDi7HV3rlHLK7jpBNesXDsZow+jSVwjXdOidxd/odT+nrcNFNatZkdcZSFtJYjCoXRRJK57dKivKOc/r/kyozNlAovWQMUADv/sZA1B9OVkVW2BoAy7BTVbiJybJPpVVZ2lb+J1EYXFg0KBNpFSI3Hsidd6j+gk0D4gMbwPkuOog5+rzQ/pgHNvwCK/0Go8iMkLPc5WrvRZC+bSCqbFfR+2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8oIIx5qCJ/qG+Xg6UxdAUrUxgKPrJ4WQy+5Bhc1krA=;
 b=fy4vMYGfnxVyttZBka3OpDF9GO/Y1jY2rqkoAcMusPMz8ckOKM1RDznRr2bEuPMgqkDEVve346RHww4gBT4vYcWufZmwWh+pHC+dgGUnIi+PS1LmI+J8zbpCqSo+TjhwlWX+8blKG1PbKR+KjzCYUemZDaQuGSmwTjBwKt+ZZmpJ+naIiySNRfVVkIDXIpfU3fUkmtyzUsqbNZE2IVvt23dLB61FQewm2FQr2UtUJ1sM3akyOwsW5aYzhL1yomtsyEMU/RQtR6k77TbsSrzUjv8qOqPu2c/2Q1FuII2C2EgNutEBi/8yQBeozp16WWHJGWTytYv2xG0jZeyge88DKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:46:01 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:46:01 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/18] sched: Allow enabling proxy exec with sched_ext
Date: Mon, 31 Aug 2026 15:42:28 +0200
Message-ID: <20260831134338.1531664-19-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abbc527-3ef5-4013-529e-08df076631f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	66Nw0kYB79X2ZDyaPd6u8DG/V/H1lNMo4pl707RwoNWUr9ptJ96wuumf8+UDbKVM0Ow+kDqW2mug+n1e7F0PWZD8zWPcfILWA+/hLbgYd+LsYr8wAyc5jtC8zCdMWDtzeCZvT+M5bSYCmj9mQCvcou2Jp1H/dRMwJz2AXD9s0GAafcvB+aYjC7p2EwYlaDXmwXbC+gWHLpuVokdRQdI4jS3j26RIWkq78N91n9muXHeYH/VeQ+DPBoJ2IMn1ukJAyA1U8S6hJPzOdaYwdQ32EJQ/Fws4ckDXpX6VUKUowZqTF1VYunHw1Vux3KDEbe8KrmPqRlPSK2hnXSCiHnVGeyDszlsDQxiW5x4kRuxSahpykWUiJxq/1WDbUFuH7MQny1Q0hJzEzOYAFs9JfudbdWBeS1kPBZXhsOcslSlRNdyeH3UK84GSc8kWYUx/1GfZswA4zcVIv3cVx34rKBf5fTHVk3cGzqriH1R3l6qJVpHePv7WpZD6mqlZ9agC7iilURhe4/s4/r0V+6/5B4g2A1aNE7nGIRtKvYut5gJCdqb5Qz6/8vub37gMXNjI30tvrX9FoztywuNPF7sBHF+cB4CnT/2CTWQMxAeutzlq8LM3z8fS6dVcE+n0/GMczKT9VLXACElI8Bn93v1mOpAiGeIdsYShquVHboWo3wewbkc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMx20tmzyH25fquZqbZyHOz7FiT3T9ABLbvdBQaGXhE5E80TvXFrORAY+C7w?=
 =?us-ascii?Q?Q7a1DUHXDLyqe1usPx7r0Ar2NGMCJr/3vutOewUy/dooTmanGeKQ4IhdYTas?=
 =?us-ascii?Q?e226baKBiRWPCuH8AZowbYXqb2Zi120o2ydVqt6Thd4rwQrYts0haD8qtymg?=
 =?us-ascii?Q?36hiLiNiWfekUjuzuHYOkvYrpBPlFdwSwiPLnKnqdVwj89HErQVONgcKw9r6?=
 =?us-ascii?Q?0nvTOvykzEoKcGf0mxC6Dn5/NwwM91h9532bPM/UkafoFMV2V06Yo8FOD2/M?=
 =?us-ascii?Q?/WK2hEXRbekFqLCJNeY0UJTOVOkMVNIS7oxyB+PE0iWWuiBFJmviMdT7T08Q?=
 =?us-ascii?Q?PpqDmQxJoiU8B467gjznldsF/MWkIABR8oSUpKdahP5K0PlutwB7JhbhREZb?=
 =?us-ascii?Q?6N+9z/ZlW4JoLyAHfg54ovU05DzZdopQ4wlwDBdnbd24LvxdTVBXHceTjcAU?=
 =?us-ascii?Q?mxHf6X8GBzY/G7D4QLZDbtSeIZWPVzTzBBjXik1i30TtehqobjELk+8dd7tr?=
 =?us-ascii?Q?D+fEodhVhnfHi0Sc9wGzmJmPGxUtqnsdg3ZwzFXwklJDhCuML7em1olW0QS2?=
 =?us-ascii?Q?4Uk5KiU2aMukZp8A/1+j2ncn9ELb4oKWwzlyY5wtfbHPn0Vjd1u6Z08+mPNr?=
 =?us-ascii?Q?XtRi0ut/6ufoEe63tJgLgWYOkl97w9ttM1ftHV79Xc8OL5YVVuw652z6BF/G?=
 =?us-ascii?Q?yHWD0VPYpUcHPvHLKnkQwdIMXh2vyGx/cPD938nDPKogcbDV/dVvdEWqrZWw?=
 =?us-ascii?Q?+oCS+0/5CQOz+OHpVQqlUeEn2eNvBp7NSMBjGVWfKUUReED577Zvjsng8JVI?=
 =?us-ascii?Q?yt+oiZZn4VX7+xoq+Dy/hHdOJy+WdbM+Z0x/z2BA+amNKQHG4wvFls8PY1dG?=
 =?us-ascii?Q?Aumx5YR8i+ymOTJNaPwrNBjQ9r+hidRf3KOFeJZuilnldDSdynAZFkKO9a+D?=
 =?us-ascii?Q?XCf4fdlIZb5exvPxSl5WpQUsKc1rzaEvpH5QVfh3pvoGNnjA/Plc5ytzi27H?=
 =?us-ascii?Q?tff7Mie9uD0TN2UQX5KqAgt9hv9VoqUNFJhLXCBcwep0B14YV3r/0YZE4SHP?=
 =?us-ascii?Q?BmwGe2+T7rGEPKQ1oYK07jOL1h03h5SXT5JerInHvG5F4+uQ6cXicqGi4UPZ?=
 =?us-ascii?Q?CV1Vi3TyRvoI7/K3VI3EnaTNbW9RBPO9Un35Cwc/gh3ZmBZ51RLvLEKjkf4t?=
 =?us-ascii?Q?ABxj63xTDMo3n06s0Wv0GDFhtUwu8Dohl3158H5P8W5Bp9G+jtDEdWf3axdw?=
 =?us-ascii?Q?DSxM2h+h579A0gACfOwwW737rNuMGwnoE6p+Pb+wGQ/P78C+ZdoLj1qoxAC+?=
 =?us-ascii?Q?cxHXiC1uxXRFINtLYo6B7RmkxTCbKgrY5NT4QtULzH5MkqTZtpmQJyLgnZSB?=
 =?us-ascii?Q?3tIrevXlwGWk9ZXI+W55g9inrVi3M3VwJ26lFzW9Wc/qoKUahOnv5XGSUee4?=
 =?us-ascii?Q?IDCuBMJInRG7ZghlPWgldDvlfL5osxdLUXFauKr5Gh/OMK5TZlSayEi4zClP?=
 =?us-ascii?Q?py+HUUAy4fgydoEACQnOw+swfXeBiv34vbj7+T84lUSBeKxLrPsg58jXCrEP?=
 =?us-ascii?Q?dC1vUzRW85JTBrU/QjaSbr5JGot/a1yDkg2uX70leXZrDQ2Pdro/Q5DqiEfl?=
 =?us-ascii?Q?dcrd6iCNzpmmn+XL1KO5i2ijskWodIieXoGY9KemZqXkOUo2vRgwYjRwIx08?=
 =?us-ascii?Q?992KXZkfuyZGsrmefeuJgDTP9zkMa2sjQRHE2E1L9kQ4i7ayaCJIbO2S+U/2?=
 =?us-ascii?Q?EzN5Kt6S1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abbc527-3ef5-4013-529e-08df076631f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:46:01.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXNuzA/QKH6uWvb6w9tMZRfemw8bkq0bHLOFwmd5uIIRLd8JqxyK42uJTvIWw6ZAa/cG3h1p29DbFb7R5oXjuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 init/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c522..f3b3bbd14dc41 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -938,8 +938,6 @@ config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
 	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
 	depends on !PREEMPT_RT
-	# Need to investigate how to inform sched_ext of split contexts
-	depends on !SCHED_CLASS_EXT
 	# Not particularly useful until we get to multi-rq proxying
 	depends on EXPERT
 	help
-- 
2.55.0

