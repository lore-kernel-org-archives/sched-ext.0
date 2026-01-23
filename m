Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AB23EA90
	for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185023; cv=fail; b=W/EUbJuubK3V7onGVc10/y/eHytwzZ4gsUzt++okxJVZEcmyvzBqs/JLOQWNoUxVqbeRmKT/iYe8wBxOdWL0bXDYmKIz1NrDC3QuV0DNiwf8nzXniw4+/cFzvSf0PZ3UnePjP+owxxfAd9Pd1oEE4F2CzIQKbzhhEdHmlSQHXJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185023; c=relaxed/simple;
	bh=LSUJ3Xk9vKRR99ljxOkoY5dtNtPBmdAH4IS8OyuIeR4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qXWl7t92gbu9dQfc85hT3D19ldqZiJ42rColU41CtSrb2RPrVAC9SfziC8rM77MQ9qnZVcpfZHZSogQb/6uRsPqVs4/Hdtv0IONI20fHkuUdw4Tu16lz8JT+XIdC2lOqy7+6tOdFpL9p8jLWCxWDZ10ky3C9gJbfxsckLFuE+IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nUsrnpbP; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nUsrnpbP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq8Ky05iweHM2mNmOzBQd+BFY7nc3PraZbdKpnwxZLgTMmqhxl01mQI9yvpiuEx/pzMEtmSkkdaKo2CVHU3yUUFfYWwTfzp4or4xqHREf2JZjPnJQdDApwb/j4RfAD3o7rvwH8OipnHUuxvdBBS0kOEiZFGc5lLUWuiMlxyOciCWHi9PKIZMHxvDNQi+HI/v6FHd2XTAC22Q3SxtdcZn+98vBlj3KVColLuYjc77ghpWevRb3X3Lsm6q4t4BSw0kjTP7mtEJ6qJPLu01Y8YDJYpMcd9KagrHUcxSxye1emO4ieG1SaT4w6y8D/O7baeVrm7WKwI6nBI435dPklcviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FkMn6YAmIKpSK2PVLbqjD/QbqdMLfLlQEqB+Pmoeig=;
 b=L+fAGaVw8mtjfMMsk/BaeTvIMaf8oYDumf4yvc5hBOxzSHLe/Tmkzn2e89nApoXYTmHSjU5PcUpiahgjnm8XqGOdjIP1obnzWkn4jkq2N9jjsw1bADWuGyQ0mpgzbBHIA/Vd08mwM5k+N3zJsZgRiTfK8+rXi0c9Yr6u2+o9iZuIyc83PTM89AHhSwhD4YHLNBrI7NIfSagIWeDEd+Y1ctUocJWqSlFA3ID3TCS0jb6xfm4Tc+4rcg1/4WAxtew1pbvzBcY0RxZUv8hvcmqXVjec93D/D/XUITMlYuz4MeJJmStQ8R/X0kUntD2GefLuR87GtsEe4IhxKh9EZjdSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FkMn6YAmIKpSK2PVLbqjD/QbqdMLfLlQEqB+Pmoeig=;
 b=nUsrnpbP9n1Vlmz7MTnbIiLpLyql9ZAfGRKKqKP7xevv+LRTv1+0iBe3tDniT/AwagXgfXx/Bogm1rvJU5Ng7eLDJEuXzCykdp6pcEqZfnmAbkCQZo7EWr+rgjrx5GjWrgyh+KEnRjjbAhcJL3YODx/9FKUkLB8FK/ZfMHQlk4ykhpS2WJUPKT8mNCaQ/aHf1ZXIIL57lecCGu3De32pt9r9ZNrxTqp9KbjK2YO4TIV5lGNQwsyfGcFnHTWO3tvC3HDlUghB+Alq/YPW3DMFDE4jdTuovDA6a72hc6yswn7Go66NEhWt1V8YL9KFF6JWEZrYclVGwHbOeYN6idyvhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 16:16:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 16:16:54 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/deadline: Reset dl_server execution state on stop
Date: Fri, 23 Jan 2026 17:16:45 +0100
Message-ID: <20260123161645.2181752-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: a2166153-f177-4c5f-d513-08de5a9ad32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m7VEUHaYzbq+vFkqiMued0V/QSvjMQ4vAampSC2UR0sGtf+ybhWAstBwiV28?=
 =?us-ascii?Q?/xiNGdEsjTIeXJpRYZXD8K/zJ+I/5SADSP+4mhqLWAxnVuXlypiHQcSo4r/M?=
 =?us-ascii?Q?VceVdQ5Atvyb/iFtJ3e5gOT+i3245UEq3Et30b43rIXwcsNYygFf/CzdEIlD?=
 =?us-ascii?Q?Y4D4C+xie64mNuIWYqJn0Kzx55uN2TzLLA6Qg9JEXn08zQ/uxBMlDe/x69Hf?=
 =?us-ascii?Q?dvGYt14qAa7E03Dv2N6JuzigEWwKAzqvlMtIRXOd2J5qJO6sWMSS0y9KHosw?=
 =?us-ascii?Q?vJqpM4ZUCSiUr/u87Lu/Z9cxn2gnD4+ujAI2LdJY1SOfOfSzuJ+wqT1QV/yd?=
 =?us-ascii?Q?jE4S5gGCX+1hNeSAXlSoFFQ9RCSUIxl+zLa+uodaDQIlBnHYcjIrXdsSCD6P?=
 =?us-ascii?Q?1pit1C3mT/76wEFXz7oA6ESSUx9s80W7L+RTdYr0x+ZCQx0mcYWRjI5wdyyp?=
 =?us-ascii?Q?71QE5jhMflOyJJQZyvGJPRN8JsAjzwarR+OASoxgcL9y/ruCadP8ucuLq5MV?=
 =?us-ascii?Q?ZFZwAAexrj2GXg0ZXE6pxjdW+ETkf2PEAXb8o0OKHW1z2bTwqpqCcNQxCH1B?=
 =?us-ascii?Q?qMQdZ7iDJvDoeN2inU8+SbAV+ikWuRvOhRpSSxyCt/YfbtjxttDyxsdWTO0r?=
 =?us-ascii?Q?9hg9sARaE5GDHTpIYFboihk7MEDHitSOcWqOZ/crLvX1GL47qddc+p0+G8Lt?=
 =?us-ascii?Q?XvylM6J17jj+Ri06Dv/aFBfDHksnllpGdp80/bRW7lK+LiH2iZcQH3rHkxig?=
 =?us-ascii?Q?PmuKQj/WXhqogE4fXJSkAcEVxTlCRDnCrfC823OqSvmZ3fLvN+IFgqT1qlhy?=
 =?us-ascii?Q?z2yegc+//s+F/FxHMsWjt6Sh51qGRsQzSrGRrLBbLUTQxyTPW04HnZsghzdm?=
 =?us-ascii?Q?PPvlYXr6m2T+LiNRs8gliIZnCDRC/2l5zy++t057dPloUoTllztMkh1kDCBy?=
 =?us-ascii?Q?KkCLdxtej9SijU2zIl4/b2O2G9W8ifr4AKYuqqIOgpOwznWqTiq07U2wWigG?=
 =?us-ascii?Q?jIeduhjAnXhnmEsVdnacQeLHvUFji5nmspPcMmeGU409LdUZZPbGUNzqFhN1?=
 =?us-ascii?Q?PJxiKrzgjqXTh/u70hfGiOHeoZopYsQQSLsy6DwO1xasXRNmkhj9xyuEHJJC?=
 =?us-ascii?Q?6q4UZWQusSe45Ls++eicDEebvEo++SPfwEj6hUija0MyOUfLjeURyXd4vRQS?=
 =?us-ascii?Q?7d2m9kXbCQh2SMzUZoQkYHfVXhfDR3Hw/JcirsOKUw3C+1sb0P26JRRiis27?=
 =?us-ascii?Q?WwIfhyvSsLWgXqwFzOzpk1+ECT78p7TBSTsedNfTSeloTvjtDq9TQ6sMElSN?=
 =?us-ascii?Q?uLnVAJ8kZooHh1lXGRh46PsAJc4TYtmdNP/MVS9iiuNVLolFAiT7iZXD5Txa?=
 =?us-ascii?Q?fvgkeHt1qtE+TMbtZrOmo5Enc5aibEEfA7U4DaOhMFTDon79NX3qMUGBPE95?=
 =?us-ascii?Q?jJyCmo1dyJ6e5Yq0OCfXaxa+MH9aaIguvIIk02tlm21x6W/1wtFsvsjclN9M?=
 =?us-ascii?Q?BxxY5rRTRwIZoyNqz3GDqIb5mMd5EIYNd48Sh9bOcsFy5dIosaZnqIIteWQ/?=
 =?us-ascii?Q?6vRz3i8rCYiSKbPlgTGW0PhSys3yo5C72v/dRS88?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fZ58A7NmRc/AlzP7YLl+B57/98zOg2+98UJeir8t7qBYsIdaXwzRSlYtIemR?=
 =?us-ascii?Q?MkXeQs2UhMcnS5N3Ix8HaFpo1Zs7BwvsSiTd4fHee+YlCsyaSXPeXkGgh61e?=
 =?us-ascii?Q?RtF8dUgxfivGISxqeKFYMnpqbiMiHCKszJArbcTfI80g46qIxqfz23G/h1VL?=
 =?us-ascii?Q?8ue6GyOKbcxGy2YrhkS/sYM4Yiq7gSkzfll0C1MYc+9mdps+WSK+WfruxDso?=
 =?us-ascii?Q?A2vQF4gmNilOcujIfX3LNBvBM0GvZcx7oS1LFi6hOp9KeFYT7fmS9rW9YpLS?=
 =?us-ascii?Q?T3lQCOpiy5+io1dE6UJZDSRPd9nlD/HZBJaY+OPTDgHjc8urqhoZofXyU5wq?=
 =?us-ascii?Q?jxVVzOsliA8gZDmgMYIdOUZKf6LW+OwWtzQiWZ4W06sR/8HrWb0QDBwe/Ys+?=
 =?us-ascii?Q?6pPLS2h88ElgQJydFbILAiwR5P+t4SqLn1oaweI6kcNS9PGnIVRAYE50awrp?=
 =?us-ascii?Q?KGHueJtgNOUM0qmWBvMAKQYowJ6ChiGDzDyzSoPyZCiLiVM5xN8gn0RGuk9P?=
 =?us-ascii?Q?eFDDMIkKPtaNYdMnAZFHwN+ZKq1W76YBNyJWIWTfhTWWEwMjnNKLunf3J5Oj?=
 =?us-ascii?Q?FFkT47VAF+Keu6rqSBoB0JdbkYXESeELppla+SqyHWSentPgOyLfo3IsxzWX?=
 =?us-ascii?Q?4aq/GJhL3qNeMMVxAkbAbrTLsnhrAxtfDuOdoIs4rFR3kasBT1mCmr7IBLY6?=
 =?us-ascii?Q?7FXRllDQGVPuuMx7dIAljkjqvl1c7ma7ptq+y6xOQw6yfT0CAY5XVVuxgceF?=
 =?us-ascii?Q?zMb1L8squnoKZDsh/Ve/0RVqoBpu5MzfpqGzFPalvYhoVTfsduDF/tfjmay6?=
 =?us-ascii?Q?s3Ygee6/X0QLWzp9NlO9qcujYesAJqTkLoDSdg4EfNFc4h6LerNlC/KL/sbH?=
 =?us-ascii?Q?4u/uSPHXkJkE6H2Mmv/sDYTOO/dOD4zTMbINvvsR+4fQeB94TAtAd+JAXHTo?=
 =?us-ascii?Q?eK44t51A7NHTzLUwQvvcNfqStyk4CVxh/C85BNtII/2MdMmzUGC/OSker7EG?=
 =?us-ascii?Q?0J9zQzg6LFVYxk2uC6mhhYYn85nlN9uZn9ZdKxD7gMxLbH4XlzLURZPY1qtJ?=
 =?us-ascii?Q?rEvbWBhdkVUyo6SCSc1aapu7QPzXhK99pvRfqZb3pd20WGEiD4zn2QhKMLrO?=
 =?us-ascii?Q?tWwblWgFrLumtpyfy7dzLiO2+z7JVMDhao/Fx03fugqr3It9GWkvEuaZnoHZ?=
 =?us-ascii?Q?2ufyGyPevNIhWj7YTVvztOoVDz9MbOepj1xwIuqa4+CaiqOv2PfB7Y2vT+Ex?=
 =?us-ascii?Q?jyikbzA7XCoNStpFoyiIgr1+hcfzhsJTmAovRh182HlklRISyz+kSrGBEtxV?=
 =?us-ascii?Q?JFdwGG0W2fQwTIbZ4Lw6LXaJckI9lX5YR1ZuvbooLqaQuYbvuk0IUGPsOhtT?=
 =?us-ascii?Q?Hoqn1oaz5hLanMAOwyiFGK7hE0fb9wvEcweGKlhBAkSM3xiOMwgomCn2EwMZ?=
 =?us-ascii?Q?/Q41RrEQX02cSTfHPm/E36/8Zy11V5QdZJmlPiCHuxzI4+BOhfm63eNYy80M?=
 =?us-ascii?Q?vUc/glX0+xVY/30YggiEf3Ielv4YsZ2vspvq7+IuXWRVjVAIu151EiW5HNa+?=
 =?us-ascii?Q?Squn8LTsHuRatKcYb/SUnVe/kbLiOscRdlQSC9B+HnQW0PM4zMmxc0VQOmbZ?=
 =?us-ascii?Q?9GrRrGAG50XszsWTYfQykyEsqe+WZT8lO/z1Ak/SjMEqW6OVTKvXBN7EFDs2?=
 =?us-ascii?Q?Im3GtpGIqJ4ss5achLYm+k/hjp81oqVF1yWOUnBcDzOjdQ9FcRc+msixqpI0?=
 =?us-ascii?Q?e/+sdMaOkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2166153-f177-4c5f-d513-08de5a9ad32c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 16:16:54.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ShNcGj1KSalnNzOMkagwrUMcSy5G+BVh0JZxV5LGIoZ8/bymHJSCmdP5JFlztRNfZuDzAxJ5efSQVpP0WR7Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092

dl_server_stop() can leave a deadline server in an inconsistent internal
state across stop/start transitions, causing it to bypass its required
deferral phase when restarted. This breaks the scheduler invariant that
a restarted server must re-establish eligibility before being allowed to
execute.

When the server is stopped (e.g., because the associated task blocks),
it's expected to transition back to an inactive, initial state. However,
dl_server_stop() does not fully reset the execution state. As a result,
the server can be logically inactive while still appearing as if it was
still running.

When the server is restarted via dl_server_start(), the following
sequence occurs:
  1. dl_server_start() calls enqueue_dl_entity(ENQUEUE_WAKEUP),
  2. enqueue_dl_entity() calls update_dl_entity(),
  3. update_dl_entity() checks (!dl_se->dl_defer_running) to decide
     whether to arm the deferral mechanism,
  4. because dl_defer_running is stale, the check fails,
  5. dl_defer_armed and dl_throttled are not set,
  6. enqueue_dl_entity() skips start_dl_timer(), because
     dl_throttled == 0,
  7. the server is enqueued via __enqueue_dl_entity(),
  8. the scheduler picks the server to run,
  9. update_curr_dl_se() detects that the server has exhausted its
     runtime (or has negative runtime), as it wasn't properly
     replenished/deferred,
 10. the server is throttled (dl_throttled set to 1) and dequeued,
 11. the server repeatedly cycles through wakeup and throttling,
     effectively receiving no usable CPU bandwidth.

This results in starvation of the tasks serviced by the deadline server
in the presence of competing RT workloads.

This issue can be confirmed adding debugging traces, which show that the
server skips the deferral timer and is immediately throttled upon
execution with negative runtime:

 DEBUG: dl_server_start: dl_defer_running=1 active=0
 DEBUG: enqueue_dl_entity: flags=1 dl_throttled=0 dl_defer=1
 DEBUG: update_dl_entity: dl_defer_running=1
 DEBUG: enqueue_dl_entity: SKIPPING start_dl_timer! dl_throttled=0
 ...
 DEBUG: update_curr_dl_se: THROTTLED runtime=-954758

Fix this by properly resetting dl_defer_running in dl_server_stop(),
ensuring the server correctly enters the defer phase upon restart.

This issue is quite difficult to observe when only the fair server
is present, as the required stop/start patterns are relatively rare.
However, it becomes easier to trigger with an additional deadline server
with more frequent server lifecycle transitions (such as a sched_ext
deadline server).

This change is a prerequisite for introducing a sched_ext deadline
server, as it ensures correct and predictable behavior across server
stop/start cycles.

Link: https://lore.kernel.org/all/aXEMat4IoNnGYgxw@gpd4/
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Update state machine documentation
 - Link to v1: https://lore.kernel.org/all/20260122140833.1655020-1-arighi@nvidia.com/

 kernel/sched/deadline.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c509f2e7d69de..e42867061ea77 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1615,7 +1615,7 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  *   dl_server_active = 0
  *   dl_throttled = 0
  *   dl_defer_armed = 0
- *   dl_defer_running = 0/1
+ *   dl_defer_running = 0
  *   dl_defer_idle = 0
  *
  * [B] - zero_laxity-wait
@@ -1704,6 +1704,7 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  *       hrtimer_try_to_cancel();
  *       dl_defer_armed = 0;
  *       dl_throttled = 0;
+ *       dl_defer_running = 0;
  *       dl_server_active = 0;
  *       // [A]
  *   return p;
@@ -1813,6 +1814,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_defer_running = 0;
 	dl_se->dl_defer_idle = 0;
 	dl_se->dl_server_active = 0;
 }
-- 
2.52.0

