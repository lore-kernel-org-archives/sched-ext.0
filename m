Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E9346760
	for <sched-ext@lists.linux.dev>; Thu, 22 Jan 2026 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090926; cv=fail; b=W+5C8QyvLj1nI5bPxBnYNr+s2r4Wzb1rRHi6Zss8fegRUTiRkgS19Hn1PMGSD8owzXciMTx1bcNNoshEvGGtnsOJ6cKo8LD2vwNOTszehQuTWLzHn+ecEVhQiA7AweEjpzvREDeFf5kKrCmllhsOGe954Wc4MwHhrZiytJfkz8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090926; c=relaxed/simple;
	bh=JOdICgIqWt6cLFvM76qplXKLgyVsyIyIyD6aMxKttO0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X23KP8b62/idtJIeSuXL8YpUpcsIhmsXHfRlz85Ik+UZK6DqoaTy6nGNhJQIFiUzX6CRc4xpvKZ3kMzGJ+a+k0vCqyeWXGb1w3haXNilbYiMBrL4mpGRY8IrPxcnJ4u+H4g/ekx9y7LG48QTUMjcW0e9o6XdvAyc2o3lGYFaSKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CjbF1ojG; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CjbF1ojG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfF4nFIEylbTNLKyV/MXgR5TTHdLf1kYmk/KSuOI/VQX0sdfjbUeInjaWODC8xLa24rHFlGkTVm9WkIJg3EZ2rw76C+nT7gU1k6iA+ddJ1Wif9g2JifJ+nyO8enBCEygbIGTA0Hh2BE6s49ipqHCbF50JiUp7Va/1wnwUmVisKIiRhFMH2y9QW200fjOzWl9ptZgsH4ytcGkXeCsA/Tx0pNAeL4p+QG9RVpgG+zaAl/7FDAHOQ1I7hCGdhiuRew89Ag66TtGp3iaKKWRLa0SAjDzQS1Qewsyp1ttkzqczmMjmR0AiMFZKUte419BgiSuI5VgLuvoDqvid0AkZyoQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8ED0V48GOZfYpXcUTu0iRxQrQVTtekyKtwLf3WCO/k=;
 b=KuR1yWM3pM4Y4qSRnNsNiz8ZCwFGTXh4gxzgbT/Pc7guzS5D0io08RFFuA27oHgWJVq5iDS9UZAh/RM7nvOf5RnI8P7dq1diW8p4JRq0rYBkIJeg6Sx1/CFutzZdV7HFJqHu7e0BWR7lB4GfCQoPxS45RieiUPraQP3/uK8fWksOSnVJvdaN0cvHxttxZXTZW4EX0qQMq9BLPfju4BnNwInPhN6CjIoCQQE96ROwdqOJ8ENhWpw0LXm5wa+5ZuydrUJk1NV7uzU5CmEGlJljhQSk1IqO3B+sn39Auc/yvMCW6bktRpra029H8kRMCNSS9wUCgX0MDMUnqo4EuYT2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8ED0V48GOZfYpXcUTu0iRxQrQVTtekyKtwLf3WCO/k=;
 b=CjbF1ojGy6AU79dYhs/yudbfFo2tlSFX6SiClXQO4097Bwv5yMdiFphrMHAn8yXcuUAWJ07j75KmbSLqPmJ1zT7NI9XqXJOLgNYCgsX3qpMuce4WPzkBIQvlIGPhMzzdCS1iVgCMMPL03edZikv4h1xmTLvWVP2okoqajkhEBe96aEC7ifpScY6sK5LPeawP2Xl7QIPJzlhHT4jWu3H8t/CmF61FKIu0mQbWbPURyJeAm5gSQCMQOGWIt/1/rhjfFzPtPaT/KqLDM/s0wTuVKJYAF6fSOKvuDGkcvo2ZN4dDrsbLp8Gxz8seiBme5qbM+gN+JhwPLP+1di3uokitpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 14:08:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 14:08:40 +0000
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
Subject: [PATCH] sched/deadline: Reset dl_server execution state on stop
Date: Thu, 22 Jan 2026 15:08:33 +0100
Message-ID: <20260122140833.1655020-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0100.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 555b31e9-a55f-4b31-03de-08de59bfbe8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7O3KwA8CIDq1T4x2Dyr0uzHi3K/d8+rjoguKue4q2Ts7DW2w12iXcXE6abdS?=
 =?us-ascii?Q?nOiNMKx8IAOn07I0vDEDD4x5Z9+QlFMOCLWisqAhT/CCAVoMt61fM4VFmBJu?=
 =?us-ascii?Q?FejbkL4xladUx5DLUlazeDPV5dsXUmR/GrHkevhHp7BMQp61bB61L8blbOlK?=
 =?us-ascii?Q?/uA6KHTugHV/sCnIJwGMg82tJnC9NXO1JmsYvbgqw667eWGYXsMRN03mZOye?=
 =?us-ascii?Q?TTWD8GrzFjeQMflR+tvpENQI/PzE064XEOpVvNwqJlkxNQjyL/F0XPBStdGa?=
 =?us-ascii?Q?BFI/WC5OnYMWGjEzPqQHf27aW3Zr7MwQMUxSaHIOel+z/61LZYoJyqSEf2B9?=
 =?us-ascii?Q?qw+k0o+OlKaGFdYKZZgB19IxA0tLDbCjANkgUyJ5zB+APch6n4zGSR7WRSf1?=
 =?us-ascii?Q?0sruvaJiS28IKALx6N0bAKE2zIzNIs6oAWTGmZKxX8mMPaEP73nUQVoKQPlh?=
 =?us-ascii?Q?I6NZZXccchnLIyNmb4qPstt05RBU1fkZzGbd6SW9smq6UfcmW+O7mIe51/rf?=
 =?us-ascii?Q?YrsjTj2dWja5J6S4/bZa0TD+MDthDBnsAP+kQSNWwNt3X1tfYOXLu3ZH2uJV?=
 =?us-ascii?Q?q5sy1pQM27gGMvecaPQLsyPZxH37WHlpR/ufNrAqQV2NRQr+DkkVFAvepvJC?=
 =?us-ascii?Q?2YjEx0FcIyLqOCwUXaByVuDXb2tLmZPwiJgJuK2YoAQyLvF6t/ZVxMFR/xjX?=
 =?us-ascii?Q?ClyaREdijd2c0QyueqJ+kKGXb7SH0FFdIA1EIGsoszzzIm0f2i4YSCE3z4eX?=
 =?us-ascii?Q?NNMtJTiqfaQGHOf6Us4IQDqo0pBT4jiUXXsQkoSJXlLp4KEtLJ/UfZ77wHRB?=
 =?us-ascii?Q?OUSVPoR+d2Z6m2vnmnFKr/DEETWTaYbLC7tjk54zbPlgDV6VirCX5AJXEB91?=
 =?us-ascii?Q?FKU+oDAiG6LLov20pWOFiTVN6A6l1ww8kM+7iQ5Na1cN4RzkIYhb7AvrAfSq?=
 =?us-ascii?Q?J4ItiYP+F0269WU0AYIjGNAym6nnWI3lG3z5CjTEw9Tt21rnkhrKBL/mDIfd?=
 =?us-ascii?Q?lZDL/6dDnbC+qnNRYYMV9mRwbbWmfy/yIfe71lnybA5mmKBRYP8DUT4XH60N?=
 =?us-ascii?Q?SruE7BCXxIHu5KjReSHpctzGImSqGkIm73u9OCndmruc563uFPYAzGIiu2Mr?=
 =?us-ascii?Q?1Q7mscnRPro86Ic4v/D5S4cAKm3NBqM0CUhHqo1qnGZakTP1xvdJkPN2SN5x?=
 =?us-ascii?Q?uJdBEOk/mWazvMIzWracUwtqixYse1YNwNI09MD8vRvuyJJJY29YnhuKjmnU?=
 =?us-ascii?Q?3PgZo+yvdm2OGunrNMaYuL4g/y5y+x6f/Un6KFEGNJ/XLXYsEFbVcCl4NI2D?=
 =?us-ascii?Q?k4YnTEAzwYrEczH4Foi0SrpEhesmbv/IYs0vF2g5Hp/hq1LJaeAWghtyBEJi?=
 =?us-ascii?Q?x+Nh/kkPoYF8C+OAlhOIGOi6Piw8A6lAr6gLQTZETZK8B6X+XYAiTFX7251a?=
 =?us-ascii?Q?EC/vdklxAFQPod677hsWKcbkn0lvqZfF1/JOJi/7oDvWmAXZJxIXvrf5GqS/?=
 =?us-ascii?Q?KUeZzqsVWslhQxSKNlX/VB/BLXO8kBQzAeYhHHLOT512/weoaMqTsomK00px?=
 =?us-ascii?Q?gI4/oeZUfSTsRb7AEa8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KuIoFNWUWAGLcErFdcgZKIGf5Ww7w5ni85kykpuFxYf/2suN2bBu3lw4i0yU?=
 =?us-ascii?Q?U+MvH0CJbH0k5ZKzcRMJG3DBmdskjozYRsc1ePEhVULLIFwMA6I93Eo8NdNn?=
 =?us-ascii?Q?D+TaOgC+uE/YM9rzZXS6S4avbsCLHzHGWLEs29mvVwIsopEIpQB4Stk/IUY/?=
 =?us-ascii?Q?rwLCiSmRppjNRBKpBpe++b1Tb0oIAR1uX0r35qKHWMpme5cDCt4VMqwh7P+6?=
 =?us-ascii?Q?2Q55qvxGC4+/cSPBK/G14FA7x0tJGLS9eh40VxlPqWedrxQX2n1eL4GnXyZF?=
 =?us-ascii?Q?PkWIdTP+eoVvLh3o0b1/S3ghsJ4rcypcBQ7u218UbHGKSuZibL/vXU+JE0p6?=
 =?us-ascii?Q?loV6zc4uqr/LjGfHDzzBZplxN4wU0nyKH636pbkGcIkN7aGV4H+74OropQi/?=
 =?us-ascii?Q?uVAvUqVj07Kbs+u8ogYEGC+dPFjK0TUAxMW3WajfD2GQL9k4KZefgZSQmylT?=
 =?us-ascii?Q?xKEWtSxcQni6iUcvsa78DNcS/ECUqaC/q/KPIg6rWWNkQMJVafxNk+crYbQS?=
 =?us-ascii?Q?QMetCzeaopMU+/HZgVZ4zUFtfCXPlKLEv3psRw6xJ9SeGR0hxVv/bHnDsOqJ?=
 =?us-ascii?Q?m/YP3PZd2SgpyIfgV5pZu6/Ut6xp4/YCg2ht7Vo9r8XNxfLDC8R+2C2K8ex4?=
 =?us-ascii?Q?x83E56CYqzI1Cru2dsKM5OcweOzgxOYmPKSpxgeXdyaQf0iX85l8XsJsq4TW?=
 =?us-ascii?Q?i8r5ASZsHk2+IjzT3Fik2jvlUK4TvA6btwkiq0KZ8F9z8PkhPPBpUIE31BJU?=
 =?us-ascii?Q?EK7ItS+UKbNxx+6SH1aJqbZcgu+btGmb0AAqNuwcpowmFfz513FxMZEhM0AK?=
 =?us-ascii?Q?Vmf1a2nYYPQ4JCTbPl/tU30ojP9yTL7NNMJ9NWXa1bcarZ/I1tvlQeqJQBtm?=
 =?us-ascii?Q?2rtGgEVFxbZEPi/p9DAFeIbzhEv0tzacrw7Ywqb2cjXV3v+QZ54PNMR6FuT5?=
 =?us-ascii?Q?w8OkOi4TC/PTG/tO5NW3DDolnXAOMVdvxauH3LIvH0R0uZgcBhNm0Hxp7sXf?=
 =?us-ascii?Q?CF/C8zzbWR5lDJo5mR8notY+c+xiSh3GBMve8bIfRhYQdfx5uQlDbPK7vWTa?=
 =?us-ascii?Q?fCDEfdKWr/DEy6WZhZHaY3W4hj/uOz/LXuQ+Df/qbG4wgohFC2K2SobaC619?=
 =?us-ascii?Q?oLhd4TCASixY6rXxDZnFYMZ/Bwr0WKrIlkDqYx2LDLleWmfJAXgDPpxBq7mg?=
 =?us-ascii?Q?V4cxUcWI3wUuTkf5m1zKCRFhwwbAHp2px5OcjrmodUaiDdQWvc0FgkIIzhOM?=
 =?us-ascii?Q?BU1BbxEC5eM+BiHbq+qORdo7FJ/qho62knMCKzaw+a3R6apxDgZHWbp39Lgw?=
 =?us-ascii?Q?3ivrHHCQv8v8X5I8St0LtDptHqaFM6antPAuLzahg9mVT6cycmSL0RXHltLZ?=
 =?us-ascii?Q?bOYK7vdE1sm/kTIpFR4LDtN8rNuzBMcRAdenUTb7/o9R79BtZBJjWU3XW5Za?=
 =?us-ascii?Q?E/iGMvpv0S4J2vN9/9Rn4iTxjd6m0ym1G8jBL2rfEINxKPAoVAezhFyOBN/w?=
 =?us-ascii?Q?ivO4ei+jm8mM02SYGtMhsGdrGPrgIEiSHKKlwzGqIj3MYQcuCucgGLyOm0lQ?=
 =?us-ascii?Q?LHArrlMzRZ41y7u+sK+gYn3c4o/B0p9MgeIEl9wXDAd8jzzfua133X/McB1z?=
 =?us-ascii?Q?r2rfsxqLfsRCXF7pJTaUqh+7WBJUtxYb2WCdaWltA+0ZP0Byc1T2GjaM/e8v?=
 =?us-ascii?Q?5k0GQ/27AV9iQrlz/zRejfaflF8FLwpGr+upH8ee0TC0fRaKmmIphkdvCGCr?=
 =?us-ascii?Q?ybNmIz8m7Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555b31e9-a55f-4b31-03de-08de59bfbe8f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:08:40.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANVSahOgefePptRW9Acfl1gXyM/aqMb/jScMfNm+r9Wn8PE1zoObzW1M4JNHOQ+QTYH6R/B+85VnyOm/5rTyig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094

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
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c509f2e7d69de..214fe62a59723 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1813,6 +1813,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_defer_running = 0;
 	dl_se->dl_defer_idle = 0;
 	dl_se->dl_server_active = 0;
 }
-- 
2.52.0

