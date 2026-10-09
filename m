Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0234F6491
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577000; cv=fail; b=OL+ZKtZsZeDbw/sLULf7MIaBv3OlIMUj78EyrprgoPm2rObklQAIbtqo0hWQh/i2GwahGJLUkIkjnsSQmWeQFWeP/+eDY5PPmpFae2PiwC25BdhMGcFI9uThanu75oOIrGdi3+of5Ijayzi8SdW8AfNVgxnGhW9WGQYpa36HXQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577000; c=relaxed/simple;
	bh=t5VJdZaFC3DypYTk26s2SOgTUgHbeFXfdGGD7nu8CXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZAiWWuv+izK4al7x868YF7+oTU+9haz0AQPfs7Uf0xfkcd3LAmAh7q6+GesaHgCA9w2obyQdQ/Z44Mg8e6FQOcDU9vnerjZiLK4bf/WztMT4zHcmIRqoTIwE5hfoOga6oiOGkN4WYZYPn4ojqKoCXA1Jt2wnXuBDckKszYlcao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VSj6yG1o; arc=fail smtp.client-ip=40.107.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VSj6yG1o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuENfavLxQa25fvhEcnUjBWvujlwQnuz8Z3EDUZXXuwjzzvVDvrYEZ+ueSccicKVRcsQJzFBOsWJ9VgFnKx2MMU9ODaJ8C6RkVn6skN7LesfbzH+SOUvr47J1HdO8PbyIub4deTXsVB4IkhsCFhjUOTHdwT/3cr0K85APb0nzdwtmhAqAQ+KnebgHva9lwb36gHdd7m9T2t311PqFCxFwnt3Yp1262ZZr7cWFUtW9nfzyUeY2U6/F4vbC3J8LVwRXHKp/yOFGZre9DRcjkuEMFvptsbZYgJZEtOJJKGghu3Z9qLPoiF1Z6EK/CsbodJ1AnXHQ5480ooMqbXq/rkCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTuiNzGIrQoDOhb7svKivD5iLLv664aoxuJgATUhYkA=;
 b=sCh0u1DoGPpPcjY9LE2SupxGRChSYxjUHQqjvtFZZA3Rl4gSYQ+ifb37yYcnc/FHpU58g2e7jxTjpzrdBocdvcACiC2CCdoJtJUWCWrEAPMber64gLF9XtYp4tB0LZbLWaUUuwDZRRkj9mTJUr3Rae1G7yhGPdXDbEAvCfH7H/0+gyPTgW0GB4ZJd6KHTN+ZNPJmUT+ui/o4lHPHpLqPnxWnFZEEkKPOsksAu60IlwOTvXsti/OldHOg7TJ3vk27rRHv0NPN8yzsaWIgOx6e/tRWT9YSGvEdgHKUJFonwZenPsCdaBS5MYFXu9ZOo3kJDenF54WsYBFLjj21nA5aGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTuiNzGIrQoDOhb7svKivD5iLLv664aoxuJgATUhYkA=;
 b=VSj6yG1ocsvmwS9KJVFBBdxF5uJovln+sGoLrbyc+sAfr3eQsdRCAlISNsaTE1OCkusUj6TudRlXCbm3EDFOVPUSJ/fuMXF/8Es/H22guh4YPO2+qBy7U5ITfY7gSDIx8V9zH8DqUdcQ8mBLJOSL8c6YNbAa/A5Gq+o/shML27PgK2VgCFyLozX6LoiVuZGl7oxZrKGBJqABRc0gvJygbzch+YLuO9gxGGsGTDBj+4WmPVuQOUyzZ92oXWF63SPzrq00jtTXzfSaWIPJpIgdl+APry1DEuY2qTe1exmoVsd+tGt8LE0SNwz4NWZI1Kg4pVQNXHxOFWLlYuKwt0rdKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 20:15:03 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 20:15:03 +0000
Date: Fri, 9 Oct 2026 22:14:55 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add ops.sub_child_ecaps_updated() to
 report a child's effective cap changes
Message-ID: <aslLP_r6bl6TC8u1@gpd4>
References: <20261008093228.2015427-1-tj@kernel.org>
 <20261008093228.2015427-2-tj@kernel.org>
 <asjNO0ggCPcfIP7Y@gpd4>
 <75b599f5c3e38cc62e33c4bf370a1d84@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75b599f5c3e38cc62e33c4bf370a1d84@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA3.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::459) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 705af726-351a-41e3-9843-08df26420062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IJVilkiL7oOxKLERbLOVjMKahI2tNzpNtKmxcYQQo6zkp3+BI40wkfI9RygpTXrLkLzN6oKKxqqDQQfpoohn5p06P8Qggfq4aIZuJW3BDhOADjZyPbtzb4uQdMyX3TMofWHQ/fZUv6Vjsn7P60pzIY8xrUUw6KADhzC4l2anDGz3RlQcXzFCiNVpVYj86eJ10t2L051h7JUQfW8w2sst2T7K3P9Fw1cRrQSh1a5kZpLErH38ubJ1c33/1YnKaFIjdn0KcEQCilf2uWRuaJDo5J66V61CZPeQtFrNGb4ll+uqDQdekRvT+bUMzWkSDyQIJtywcuZgJ8n++pmmMYTtL7BcUIlAp6fYoPV0nB3aPGWCvG73wjnNisIbP4pbO7wWlF6LY2YdsETKWTFTR3zK+6uZhX9F0skgCz3HxeJSfL15+pBB7lTF+3gomLQSz1h3z3qwh1hcbQBafi33+bY57x7AieVbip/Qu8xKxw3NN5E1tVxJQOXna/pn+YsmeAGLVIYHlrOP0fRE4LF1ufoAhjxC9ty22LwH5KbUInQiVQE1dAwkT5xCyAVa21zeTl5rhFTcodW7HDfOK1ubvSBubX7NIR/Z2Q+Q0LSPXRZ29pPpCGPjY3WAR0kR/896avXUZ4amS0d4HT5a76UrJqGqJ3IgNTFEFfQYWpu7Q8m7yUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KRE97KEq7iuuuassEWelqegcdVInlu5UpLvOdhpUKq6IsU9YTLAXRdD+1m9E?=
 =?us-ascii?Q?iEsjJZCt3DGtsdJcfy4lg+3TpLQJZr+5tKknNK0kupjA124TMOfK7jWqCYvp?=
 =?us-ascii?Q?ZXdJ8oyoz7Wx3J57NSjZiDmLZD8SId27DefbhkvioeoEwj6faeRZHfYO7IA8?=
 =?us-ascii?Q?lU57tpxzJuzwIIIXTWEiIrzuzYmVpwRcn9HQY37fcueACOV16Pphq/F+FvnF?=
 =?us-ascii?Q?VSMXZ+XCzx6fW7NFkcpY7Gdy3HWp5xVrJuTwSRkY5QRDzB2ScdC6qk53x6X2?=
 =?us-ascii?Q?q6VsulDckU26Y9xkSH8tiHMSmFsBx1ltoh0pKxU4uI8fM7thYG3cUEl+kvQX?=
 =?us-ascii?Q?V7ZKLEbBAUkQRpuvBbqHJXaJK3Uw7qXyFU3z2RmoU19QyTy5Aj7idc6vD2HQ?=
 =?us-ascii?Q?c/oA+EHT6H687kLE8ao9FzkM9gMsCwWAUGDERLFXupKMh6nCDVB0n4kJDl5k?=
 =?us-ascii?Q?F6wH1T7ioJxibgMLEvlfiGawya7NaPNJRd7quyNmWkzSyA317nWPqHzy2z7/?=
 =?us-ascii?Q?/CUQ+/hxC6c9FAUDR39IynhZNLQf+jEDH/VaBofN82tPerveFsdHMkRtLcd7?=
 =?us-ascii?Q?foz4fcFpeDh8BDKkpv2iHJIpyO+sGGHc7dGS0LPN7wiyVm4cct6KClTH1wjJ?=
 =?us-ascii?Q?+d7bGemeibpyT5k/uI9Yjmqgg9tIGuH5Asf5xeLT3ewzC4MbcTnkiFzzIqp8?=
 =?us-ascii?Q?WopBEn4vBeIUAGBE1bjMb/Ac7uUNzpAi+YpqtU0i8xAMVCCqeb4kAGsaAOp4?=
 =?us-ascii?Q?KUdTjsJLvpCBdcHoqBD+mPJN1tPcDYsocL6AsxbREeinuxuCQuxPYy++ifzV?=
 =?us-ascii?Q?uytN8VkG/vvAiHyLWiHMrrzQ+MUejxVbnx5c8JmdE1VVUgPnwOnJ/viAYUj9?=
 =?us-ascii?Q?U6wd5rGEpw/+TWJ+z7BT16PG9bf+jDMP8GxWiC6Bg4klabqHxoqjn/YRmqL6?=
 =?us-ascii?Q?RtezWzfajOMwiWNQvq5yZplM6ypM4jjSkomXUGY51kWxD969/tShm50WpFca?=
 =?us-ascii?Q?g21nQCk9O6fDfW/bH4QgKe/jiqpqLwiexIfyJfwpv0rgsHPrCiXWAZog+P4F?=
 =?us-ascii?Q?iO//GHuF1h8zByS7AGoP1vfeZVa/eIPh92sYAp7JbSZahWK+6HnAE6Bh+LCr?=
 =?us-ascii?Q?b0wWqB8wpKIdwW2PoZs0Nvo5GEOhhnqgtVk5eWv4XV0em/FKaE56Isat7m+L?=
 =?us-ascii?Q?4ozvjrX2KRYnNN2rjqZMOP0YXWg85P0WK1lCTgOBQSuPR2eKLfXMEZOzHG9e?=
 =?us-ascii?Q?tP38OO6YosAMXdhCEsUqsNLrJXbqgFOYIwvMYa6z82eFjZon/PXSXpyJJLtI?=
 =?us-ascii?Q?szLSicYyiEgJ41r+YtfqSoxHmNRXLeZeHjBu5AgM+SMksDzpf/bqoMMrpQPe?=
 =?us-ascii?Q?bEGK2xHTgX77LexiI2ThT7NUH999ViCu0oZti8/cwqYJuDqQaKbfHQFttLjY?=
 =?us-ascii?Q?/bTIoYaTc4ZqchjWtyXI940pScda34tM1BSYkqCelyxREXtd4+pEHmWiKJOw?=
 =?us-ascii?Q?3Yv7H5IKQ1zM+7XCU6t1x4fn1N1he2Rx5A26yMJfLTjezOtnmqjEdN3oqIS6?=
 =?us-ascii?Q?0/JZmwmx49MUQiSmBpmbaM4Z4rbuosALgO6wxOhslcdQuCWUfPQQ6JnpfBXN?=
 =?us-ascii?Q?Ju3i5HQEffTu6s6VjFWNzr+mE/7xLytNgPeIy2wexhs2yC+s/Ny22l2R1ska?=
 =?us-ascii?Q?wStcDMAHgjNy+pKA9m7QYTNbhH0EICSatF7JWbjutMe78gG3mdJfT+JQV6sS?=
 =?us-ascii?Q?TJ+RJgDK9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705af726-351a-41e3-9843-08df26420062
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:15:03.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iZmBlh1Gm+WN9TicMKP1gr1Wi2E6f5ZEkp0hvt4pjNd2lbraJHwD2zUiHsEElrb239H5CqoenOTbN+RT0PB7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860

On Fri, Oct 09, 2026 at 10:04:11AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Fri, Oct 09, 2026 at 01:17:15PM +0200, Andrea Righi wrote:
> > Should ops.sub_child_ecaps_updated() still be delivered to the parent when the
> > child is bypassing but the parent is not?
> >
> > For example, the shared pool may rotate away from a bypassing child. IIUC, its
> > PERF revoke takes effect at the next dispatch, but the child's bypass state
> > suppresses the parent notification too. If the child is being disabled, it never
> > leaves bypass, so the parent only gets ops.sub_detach() and cannot tell when the
> > revoke took effect.
> >
> > Could we notify the parent when the revoke takes effect, even if the child is
> > bypassing, while continuing to defer the child's own notification until it
> > leaves bypass?
> 
> A child can't enter and stay in bypass on its own. It bypasses during its
> own enable, which is lifted and replayed, during its own disable, or when
> the whole hierarchy is bypassing and so is the parent. That leaves disable.
> v1 reported the revokes of a disabling child and it got nasty because the
> calling context differs from the sync path: the dispatch kfuncs needed their
> context set up outside the dispatch path, the nested sub dispatch had to be
> gated, and keeping the report clear of the PM bypass took a lock that could
> stall a suspend. The simpler contract that works is that ops.sub_detach()
> covers a disabling child. All of the child's caps are gone by the time it
> runs, so the parent restores what it delegated from there.

Ah yes, it makes sense, disable is the only case where a child remains bypassed
while the parent is active. Handling final cleanup in ops.sub_detach() is
reasonable given the different calling context.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
