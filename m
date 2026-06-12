Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCD179A3
	for <sched-ext@lists.linux.dev>; Fri, 12 Jun 2026 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288325; cv=fail; b=MOpmrm63QJn8eUR6UAcNKnSpNt/0wQLDWFpHFSjHCNGFuRrCVWUPVbXWmuk0TFARL9vc6vY1A5l/sER/9QYYRlLiydhDvT0kX+5XBAwwpaRNQ5SF1tguoGMOWgwiz7wCY6rK2EzDzihouFw3UIZ+hqmhexbsQktsCUtXMGQ+eaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288325; c=relaxed/simple;
	bh=17vg2agsRkGjA6ovyc1F1HT0JmHhBzFuvHdOAZ1FEjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rbSpKxA9w/VgiczD9xxb1ZRTKVKCgicBXX1JR+S+Syat1KA+nBQ2jISYC301KF1R+/+OydfLaISo4mtZSxSQ32HXgT6aAkKR8T53cs5+MDOlhjUvMkuYKVBt9a8VD6YNxJeSNFsia7+q0jUCFLT5a/D1vLVC4hMmbqLExxWI4tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bZnumNLa; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bZnumNLa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgH98fLoXPFGR2ecyqr7wQEj1nPC4efQB519K3YVmZRXKQorhegtNgJNLDtdxBn9cAD43HDXQmIVORJkvhtJolnXoI6oc5NvGj5PvVV93XvBrXC5sfh9cV7VXNBmNQBFzXcN8vdw6CUNkfXF1fFwIQ+TUtgvc4dVkvk0qAa5KwoJ93gK21sRSrjIm1Ip6gSBD5gYGQUUKNCzhjuQzk1SiR6Pe7vlY4HWoey5m+HXUkuka7TdRF2NBsLYj+k9BCtCi4Gy9QlDX4qa6/WKne7vJDI1Drwh+uYtk2kvhaRqItnsfHaqgTi5h4ahfPyWKr67QLqfPmRxHSOaHjqYBRxlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJf5GhTLctZz8m9MJTwGyup3zY/ugGscucyoKrzFRTI=;
 b=n88Kr4BH61z1H1Gzc/OLEWTGFRwH90AggdA8NPJc0fy0AynK+Ehl8YoC8tP6UhHBPzE+AiBmdw+SplvcfgPwTzHqkVicLJVeSI5wD8wi5NRnk540ibWz/gS13UPnN1c8VJ+gqDJ7oI2aH9/P5VIHn4f7BUAmL++W80ifyZSS1OEZe8tnP9Dwv+5+kIK1RQpoGv2CqR9EynttGyAba3+uaECEvY5B9vXn4mntXLh264o61CPm6Dswle28bguy/+7IcSfaX+FF4YI1nlxbSU4NF+DVMmEXkIvVZkSrlO9mSB8kOZv+KLG843+EMKnKDLWk6axFKCX4DrhBCoS1nHelfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJf5GhTLctZz8m9MJTwGyup3zY/ugGscucyoKrzFRTI=;
 b=bZnumNLa5sG+EwUzVwoAgipHpFWbf88pgx3RA3zXC2vYOh2KV2ZRDmZRC0CyVG3nYmk4C2OYtXd1HMyhdVy/483t9jzrSXnjFxUdX+Ia9uwnc+bDiNqBc7eOyjB1gmu+AQ9BEBf9MEkf0MWhpUYU3+yh2pHBbt1B9/4uAlaBfJauxd+BXxpXQt78GdwbR8CLA3HwsyqBAI8tp66hL143Se8NQfg/ujrkUVSkiP+i9OnAd12d3TDA8TB4oe93CwQsP3a9FhIXVTKsx8Hdi9XEUOcc/p09YF6YXuSAksAQ1dgDxuR0jCpliQIujI1ZZVq3BMAPkUjRWZ+3AZk5XgexLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 18:18:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 18:18:40 +0000
Date: Fri, 12 Jun 2026 20:18:33 +0200
From: Andrea Righi <arighi@nvidia.com>
To: cjian720 <cjian720@163.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] sched_ext:SCX is preemptible by the Fair scheduler
Message-ID: <aixNeeZPeGlH-yQq@gpd4>
References: <20260612161403.105775-1-cjian720@163.com>
 <aiw0mo63sGsV-mnv@gpd4>
 <4a81ba55.9be4.19ebce4727a.Coremail.cjian720@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a81ba55.9be4.19ebce4727a.Coremail.cjian720@163.com>
X-ClientProxiedBy: MI3PEPF00004EA1.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::450) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3a4593-705f-4258-3f22-08dec8af0743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2toFy6m44oWHZIbhJf+iGhQskJ7OgBuy5pvNDkrNbIWf6bXXm0u7d0spMhfZsRcwLPQBwYGjkPKSYjMA0lpd7SyMmy46M73TcgzKhXsJNKcWwKyyU1bqc8zDtXF6XvkHYXl2DvpwnYuc3vRCkC3wexPD+pfVjDs84NeYTXbhoo5sIAminfUu9ncgU1EVSNjYOu7Dax8ngguO0y8CS7cFpcAjNlQM+oYiA7EFJLupWTkmGjCXBatjgq+dRlRzqk4tnHQ+ITa+YOcauJsUiTeas4Aq0vU9F0ASOmyUOhcNA+2ZB7icPD+BVgRsdtjgv8hq9o+F5pSWRHQB2j2Gq4qdxV0h0IOuNJf4/3czBj3DSjg8U0QwDmRvts1Vy+6PvWJwiPGP1/KbC/zVt77J28hoi6jsL9hGVheeWL97P7ktn8ovu2lQvAVeXxGBIWAuAH3dnx3bGHY++mFWIKTyK6fYCz+/ugJJi2flVeQlgi/dMR5WDEX/QVkiyo8V0xqtpuvApe1F4gHZgNI1y/aUOeYdRAwFo2qhfjhc9OAtofCtuxYPB+KQMNqSy81xyzjcY57YMvzlbji2B0S5FISHnPDRCP8KHdyHrDP8qDcwWYRhniQ2s42dPfE5iPJolt/XIPtZJqE8B6MVYXEcrLwLBUG2KmgEFVXjUwJv2lhR9NIlICczDA2YNRsDxsVYbZsSKz8g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VlTTyxt3nI7EWbjrf7MfifEGafy6cYCuty90gAsxMXK4sa4iozTukCoMhAxj?=
 =?us-ascii?Q?6cHnsZ36EJ/7faY0wprSDJ63abQXib71RgYOPEhdnqn9GWC6aPWKt0lWUOH2?=
 =?us-ascii?Q?1gePUwkASKcbR9bOUHBeYGpPNwJgUy7gb0nMekQJHpXuHZSWYv6vaRmn+dGK?=
 =?us-ascii?Q?TbjEhjRwkx46Q9va7SPLpsgBcW+d/z2suzPRW8X+xJTFOjCYdWMaB5dUmudu?=
 =?us-ascii?Q?j6P4gITAQ/zNey6mB82R4rcKka1I1ytn3DASyUqUIbbvW7MK6pEh11oR3qlN?=
 =?us-ascii?Q?RacEV1M28FCkaLOJn2/tjoi9Xx7xat/18axoE8h+1PboqJhIa96sMk6LH+na?=
 =?us-ascii?Q?1RWU7E6xqXtNkh582XFF+EyOdo7sqi7f3LYgoImZ+UAeNgKBUFcbxF2EIV9O?=
 =?us-ascii?Q?FDYWKq7QOHH/rYx9SxlkkXrnMVHU5IMxVNc5Vkl4tJcdmsrrbFivMLD8xAzH?=
 =?us-ascii?Q?/cybUNCHnFTfFUe58VkTRXInV5F4FrbMj56ne5es0DZhCW9nBE6oMM8PnlFS?=
 =?us-ascii?Q?w2SxWEW5BqRruYqHw+PGMZfG4js+w4b+B+WLBbu4EzbY0dMMXelPIqO7HUQF?=
 =?us-ascii?Q?70uvHBp9pY4r5vh6WO/N9ATsXXIM2q34cFm5rDt8KXnqoQHmJvxri7CQ2rxJ?=
 =?us-ascii?Q?fIPnRRIFb6JolDmP3uzC6IHhzSiu3e77vdhZe3mI+e93qDx/O6N5+vB2SS68?=
 =?us-ascii?Q?3NmAWaSBrkLNjsePE9RW3qEafV5Rbxy5YDba33DyZJUN8l4m+aJd4rBz7LXP?=
 =?us-ascii?Q?/HuDCPBLy06g262BwvDblWN7OJpna4R75muxErDA/3IvxHYZPG+TiwqWyhuZ?=
 =?us-ascii?Q?757Vv5A/nT0hxhHHg6o/rVCcrPCTwiC5iwSeNXPaDDgzX2KJBNnDxpxnZtkc?=
 =?us-ascii?Q?EkX65KSvNou2tXNtv19Y18tVm0z/u///g79o2s0ivYl0LW3xEvreW0Hx5B/0?=
 =?us-ascii?Q?QrxP/jJWaMWkGDxGCbUSBTPc29XymhWZ6sfrnreyOqaBnltAS74mmXijy7gn?=
 =?us-ascii?Q?EXd4jmpr7TGKnh5lHShO/qO3ZwUiPpn7QpVpE8Nhf7LvNbmiNzUewhwzBohN?=
 =?us-ascii?Q?Xo6TVRSeu4mf0WAKk8DNH27a+BgTfJ6Ld2bQ4pXP3G+ed4yGTTrUX7GFsna/?=
 =?us-ascii?Q?SjnuvB2hstUY3B0gcRWkjWVLXvfpXJxiYpxX5pAd/yJqavVDqghXVBlAAsz0?=
 =?us-ascii?Q?zzdZY0jcpPbAq69eeABU1aQHA4viWpJ0gFs/RWbNEXN5o+2gCafArucZNGfg?=
 =?us-ascii?Q?TRMX8Jcop3MH9W70wkYBZyPe45yRjMB1+l1BnSga+XgXPSEjp5WAaYx5FSA3?=
 =?us-ascii?Q?bIrwkZJD+XAnKEw+b0hd+25HecjLy9mPXkq7ltvZuIORyrvlRKoGiMJ6LAji?=
 =?us-ascii?Q?vD9qwNVjVZeFRr5uns/BX7H9nwxzbqBYPWrA5VYmT2GA4wZT/ZpmIkrdy7hW?=
 =?us-ascii?Q?MYzyIRLJCIt6e6QlaHhz5wDgXe4ZpEj9hW4haW0E/ghodEiYCqyRGgqKC8pW?=
 =?us-ascii?Q?DeI29+pFZE7ab9rU5o7doUG9SpTdQ5JGCZ0ptuaIPI4z0oSwKbUVhNzQimOP?=
 =?us-ascii?Q?jOXAPdSETt4O/iSmrL0u/8DY94F6RL8mNHPhdsxtV9ztxSvD80/cHWSfdKh7?=
 =?us-ascii?Q?uh7lYrc4WL4TMtQpN/MEhDzPsGn4ohWN9m0sTDe2LjLJwx3m2QI8Xo2V6jZb?=
 =?us-ascii?Q?sxS3f2iUS3PYZ8iMCTjDd6UI7X0PmV6Fp+3ABItVzgX5CkaB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3a4593-705f-4258-3f22-08dec8af0743
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 18:18:40.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw3AsOpuNxDS/PB9KwGXhPd2Fa1LjNCJdwizDM/OM/LhGySfHkj3cQFzjxfZ7ZhvVx/7+d5N04/fC9C6kCsONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373

On Sat, Jun 13, 2026 at 01:32:28AM +0800, cjian720 wrote:
> Hi Andrea, While this callback will be phased out eventually, SCX is still a relatively new scheduling framework. Incomplete preemption reason enums make it hard to analyze interactions between different schedulers, and filling this gap greatly boosts observability for existing SCX workloads. This patch does not touch core scheduling logic, carries zero performance overhead, and adds negligible long-term maintenance cost. 

You can get the same information directly from BPF using the sched_switch
tracepoint and looking at prev->sched_class and next->sched_class. As I
mentioned, ops.cpu_release() is a deprecated API, so I don't see much value
updating/improving it.

Thanks,
-Andrea
