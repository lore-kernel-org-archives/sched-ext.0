Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871B2ECD20
	for <sched-ext@lists.linux.dev>; Fri, 20 Jun 2025 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451579; cv=fail; b=hLoEyeiPfLHtnFZu1Jzfyt2tJVCWu2n4jrjVtsX9Ud+cZl0DmcoBZ0eeX65D3a8KjvdMv7tma2g9vK8j6bElvohO2ZmPIbb7fdn53QC919tX1SKnPLvXmZzxBokGL8kiwb9n3ReGXXJu5z+h9SctY7cbpKVsXEEjO4yv+C8v02o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451579; c=relaxed/simple;
	bh=itu4WLXHnjKHo54R095bRDOHGygdRSISzQ+k2q0iHsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9MpTcgjCr/CqEem8d+aBBTtTynIxu3sk3IdNOcn+/UD1/953ryiQqLeGBDl+cvrWrbZyEd6N6nGMXz4LoCKM6nDsgjSy2h9P+UAhsIOyBQaaGjWnSp/orFVWGW5PxQZmResKI6bgDuINPhjmsQhVkjGpzGpE4fvDNB7A5RPJt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXnAPhre; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXnAPhre"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBSMQCR+KSzRRlh9DDBfaSfyD4d2XjDt9QayPj9P8D1N6ESKGty8b184BXiKsxD/Mls6VB8oU9daITlnaPA4Ky2n18g3xv9lueyqbLIy8IBrEi12XfDV6D/6iBXDRd0Jrr0lQyjc3IqTbt/tLcWkxj616CW9Pa5KYKWSR4ICZ0ClYYuzlfG6HUKcFJsmXl/+e7uEBmtWPs6ICf7Mxp6VyRw+zMLfAfXJ7z4gvmSCqzNjxqzgCvKAaoFWfXRJSAV/hJfPobFdGw9dRCDOm2PbVoMegjj2fbynRMDQL31Tw8a8jaj1XgQNlWcHhdCY2J0yAG9R+hJaDAxeP2Kv9mo9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nehNJ3KCiOpoO30h6w4HKtKq7377I6RYKn3/bc5v9X4=;
 b=u28xbroh89TMNNrmlp0abtXZ6yAMgFIqBQ40vhbNqO7U2CvNE4ITbb/NIUXyaYvrZ0CBLqJzOBD+gsE9Jt9d3p/BsglHN0HK09jcgvo3hFyfniVM8H9Cq72UclNg+DQOhOtsRkg8bI4nvRqcgs8xGFAE/bSZw4xZ+FWzoJQLEFOp2C/fnjE8LeeLUYUpRTeVbkeZwbcO8G+zpR6tV+JZ+PqqKlAfg/Z34jUQ0bxxHC5jXkExvkVL35kPvUbtKoYz0ukyS8ICqLvwlZMgLbIbHasjkUyVg75G7tCOay8G/EOH8B7PFH2ObxMRb9hIXTBwfxrrtGwHNq9kHwqy45oPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nehNJ3KCiOpoO30h6w4HKtKq7377I6RYKn3/bc5v9X4=;
 b=UXnAPhreUIZkpdohL7/qoJO7vIok5V88dmRE0Lc122Yiq0M9l3IoL1syoS6FJYUheiFV+Ze39Xoe7D/MF9y0Xp9SlpLfxiGzw4wPtkpiqoPYXxA5o9s0ETGoeBe7P89w8e8GTsNut2AXFzaGx9AFBsWtbEcSb4aB4XZbttfDgwfrWupKelvFPgqGGl/d1yH2UFDQJSpXdmrI/Kji1xUkyzEGKL9MTWEys7IZOKTr7ywsVqKmY/WR5jCuJafYk3+8sTuZ+ooLMl6/tocyGLfK0h1fCF8KrW8UEe2T/OFZjikGccmZADDFmC/5lG1O2Xzso5y1COjCATgQIbFU4Org5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 20:32:54 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 20:32:54 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH v5 06/14] sched: Add support to pick functions to take rf
Date: Fri, 20 Jun 2025 16:32:21 -0400
Message-ID: <20250620203234.3349930-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620203234.3349930-1-joelagnelf@nvidia.com>
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:408:112::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: eac55dfd-c5b2-4dfd-130a-08ddb039a265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bcRh1EYNBFt89I5RAl30C8hUuGeUM+KemTw11HcEfXw8p8pjy4NGC2jWymtZ?=
 =?us-ascii?Q?2jCzyTiGYGJkVEjEx9fPhdhQdk2eBYdsVHDlf9rVrcp3jjVx4J9vKlIAV5yY?=
 =?us-ascii?Q?Mrtx+U+z2mrwAMCZaIWRWwKfXNpELT+v+B/LF79uttDQpyuk+Ch1sZZAhZSX?=
 =?us-ascii?Q?8bO6MyPj1CmfOpBCdxrI+UWAlXjfX8j7fnGH4R9+fRUfDMKEN/1OZG7nIlR1?=
 =?us-ascii?Q?yhGP1uypy7TwB+ttkwdfotpmEgR+h/DcKecvoXHspJMjhx+zYiIgyOR11wAE?=
 =?us-ascii?Q?l64qs+6Z9ggAgqHWnG1E2b14NlNyZIAIOalXYR72ILhVRY7XWUY6SpRvNwYF?=
 =?us-ascii?Q?UniV8bUCKVzfBcA898+9487BIr2uJwiP/nRgCGQSbf8vT+mRuuQHotl+nKLQ?=
 =?us-ascii?Q?InuTVfDrOI3FU/FbJncux4MQ6fI+SPi/jVZZMMRzmV2bUmFeI+4L2tJ/g07p?=
 =?us-ascii?Q?fRfhxgIcd90EhFD58Jp/eK/MdhBC/Ndp2p7ifBofVZmggt6NK+75MLcJ5Ojm?=
 =?us-ascii?Q?Pc+YCX7Kvch9AtfNJ5MS2SBt/U7YRvButJUUeq5+rYPVM3thDJIaH4UPZKbh?=
 =?us-ascii?Q?J7+5kepm1tKlUyMOgLtNmKGI1ZuzqDNdzw31ftTpJdnpmJA6vpyDnYYFkthD?=
 =?us-ascii?Q?k/HiOY8ZmV3WBZ2FpapDQii6utIXiNQjRiSP5S+9Pf3uml8u7NIuHuChWzZw?=
 =?us-ascii?Q?X6rAjWJCTdkQ+d2mFnpjolQ2bc+Woqk4KEKtHZ6FnS845OS992C/aSQUMkjP?=
 =?us-ascii?Q?KuWlSrIm488ZeS/9gjzTrWRYUfIO1izJ5Hw0i9cZb4mmHZ4uMHT7Er1Wriwn?=
 =?us-ascii?Q?oE8NC899PM+60GeywuEZdw2x1hxTmZ01hOCClDPz0eUEqSIZHpolldqg+ZwR?=
 =?us-ascii?Q?ttrDwR0WlfUW1Yk9qWUEt8hP1OurfUhp0rwPMLpWP62+mNnpOXKY/6RF0LEb?=
 =?us-ascii?Q?OoWJYSkYv1LmRvuD/OTcfdxiFxyEr4GlVZ2P6XbCIoK7xmcIWXdkPJhSe0nm?=
 =?us-ascii?Q?qWdmIm8vVxj5K+oQVVNBWI6XQllFE2sXz01HeJ08hr4HTpvF49hptNlRNZNh?=
 =?us-ascii?Q?hMKqYYDE9hWaj7eGrZZEy+QE2TetBBZ2+/MNw49fRD6va0IoLbzaRMwHcshB?=
 =?us-ascii?Q?pu0yM64+LFKP398mpKK9cdz55kR4Y679KOEvNaXRZ/stVwCG5T9TfNwY7yd/?=
 =?us-ascii?Q?SfZKTY1Rp0t8HFwwJKsJiz5BwD3POQ1HNfGf9wMgYn7V52wcki8tGbi2azo7?=
 =?us-ascii?Q?231GxzYN6GpIOGv4jPo8bnvAMK2u9pRt4AowgO2oRuySdGAN8thFJrZar3H/?=
 =?us-ascii?Q?NnbRdbJQ8z4moBuNTaidMo/ND8tJf+HGDuZZDiEyRa4aHy8QHcE/dljwcVdl?=
 =?us-ascii?Q?bSbaX38/tmCtIrgy3oDGkUhv5OOZyPSi7MgyR6CYo2CxVM2y+SiCH1ONKmp0?=
 =?us-ascii?Q?zuAgaij3IC7LgEF6cBjARhlxcXwHfjU3+67Ni/ZXaqyJDmzBEsGKEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQUR/G6NpGS713C8mqqqLswOirxq1lHK71Ru7SfydKNwZD9th7aPuRVzNKIz?=
 =?us-ascii?Q?zOXa47dQjTuFbhvlyaUwz8Kc7Rdd22FdFFqCLyyGaNkOLR6s1lVAeyRPvKuF?=
 =?us-ascii?Q?djkGnSekEe8+UWBRufHN6iiwog/aKoWLL5JR4nAcKn73q9wpclTlRWvdZFCD?=
 =?us-ascii?Q?5Wx0DQ5n9PMIyBT/wS5YDBZehHarRtmSxOK1Yp5MMqR8QkjniVX7uvQHnYC3?=
 =?us-ascii?Q?V02HQT/m/4/stM6CIFrmjgqTjAFm9L1KXZPwAC/TlidpM0hLvcgtYGtODoQN?=
 =?us-ascii?Q?01MkGG/DB3fmXr4+ABooVQqKeb0QoLXluVIvp/yVqYIXFFwzmZYxpnJZw5lo?=
 =?us-ascii?Q?DUfsSN6UBe1scaP11gFF3kc/24ASLfq+ZRTGS3C3krGYZvYbNHpIrsSkaFEG?=
 =?us-ascii?Q?AERWskGGRCl/hRzPW/IPa+NZrRtV/UBAe36Q2JL3bnN1lROg+xV0uicQS8V9?=
 =?us-ascii?Q?LcoIkJp1HixdYENO0N0eun3v0w+hynC21hIMqCwdaKJBQ39k6nipODjQlu3P?=
 =?us-ascii?Q?Mre+BRDN+xk8aYsadsUbP1CZMvkjzqq6Oo+B91GnMxH4c6bFiW36DJtgOJVN?=
 =?us-ascii?Q?Ok3c4dbdf+k6g1oWOmla6Ew3D63QDpx63k3EL1sOn06i+bcpb7FhHY/3OFd2?=
 =?us-ascii?Q?q/dBSp7HO+Jd/wnGtcutDEQK0hUvDPdY3lB8VAYxntwI4/hdMU3527ypOPvM?=
 =?us-ascii?Q?TspGXxDGVTqnNOdnN0ls+gjr1Zvqz82P2px0AvaCvL9abLPWimQAkPclFDNm?=
 =?us-ascii?Q?t+8rOPZ8jvPiVMn+0Ol5syYpnvQmXeDZC9GTBuD3mboWOhVnXPuBpWLi4IBB?=
 =?us-ascii?Q?CU82xqfg+AyiI/GFUmA7hkzGzKTy6Ii96EnJrqpwydvjmrFrCjImQEnunhNH?=
 =?us-ascii?Q?8n9x+QdQm8R5bfJdHwKOEX63hjK/ksVRjqHolmePB8PRinsrA9YOdaMkoxyI?=
 =?us-ascii?Q?GjewiiXfnLjW7cOgHBBs03NhvTRGdv9aYAfYKDWFtsW4gE02ubZ6j2fZSQtZ?=
 =?us-ascii?Q?hMxOaSZ92qPfYVhJYcQOXh9OyzE0gjDQ2IqolR5CVeQ9AOxfbFCa/jk61vKa?=
 =?us-ascii?Q?jaTU0pkqIS6jtbzD3WZ3idmmZ7QJIj80IZlVEF8fB4Ktgqm78GoveF8xC4KK?=
 =?us-ascii?Q?J6GITpdgC8rM/61NmSNvG0oIEJNUZd9VnQxKWnBrm7f3KiEkG9kptvI8YIof?=
 =?us-ascii?Q?/D3d+jOr+QPx1VIXEAzLlG8iH+1FpsudT2ttVucPOuEQ55n7ecv92sg5TQIk?=
 =?us-ascii?Q?XC9qzlrNOsK83e6JxcDmemacY9FKO5mYW+OyKhnPe1KwHdsL1ZRaK6a+Ar2F?=
 =?us-ascii?Q?xjU3wSoDHyv0Kd0Vr9CyV6nuOH9evf0FyUc8Tki3smxcxxMHKeGHvFCLHHDb?=
 =?us-ascii?Q?3ct+xpj+W2hW7Dhacl80YILonENiF7KgdemMG0o9nW7w0itDvLuKYGMUG09F?=
 =?us-ascii?Q?tLVBJpFO6f0mmKRkFxKGlFXgRuoz9moJpq+miAF8JORTyABh0BYThXpOsbKs?=
 =?us-ascii?Q?ulNMFInrNsPjyF3XUfucksPfVxVOuP2IlC6kUuEcift7w3XqiYN6lD2vsdfj?=
 =?us-ascii?Q?4I2CkBBbr8bc5yIb96a4mU4Kz4IjaMXC51Kn30YM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac55dfd-c5b2-4dfd-130a-08ddb039a265
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:32:54.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugwfNJd2Elx+ezGZKvcyhQ+emlR5Z4ZFb4N/ScAOpqegKfekvZN6Dp1JHIyyShyWBYhbCMH09BAg96Kd5K+jVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

Some pick functions like the internal pick_next_task_fair() already take
rf but some others dont. We need this for scx's server pick function.
Prepare for this by having pick functions accept it.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/sched.h    |  2 +-
 kernel/sched/core.c      | 16 ++++++++--------
 kernel/sched/deadline.c  |  8 ++++----
 kernel/sched/ext.c       |  2 +-
 kernel/sched/fair.c      | 13 ++++++++-----
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  2 +-
 kernel/sched/sched.h     |  7 ++++---
 kernel/sched/stop_task.c |  2 +-
 9 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52..6799c14061b7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -634,7 +634,7 @@ struct sched_rt_entity {
 } __randomize_layout;
 
 typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
-typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *, void *);
 
 struct sched_dl_entity {
 	struct rb_node			rb_node;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8988d38d46a3..7d856d8dcb94 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6049,7 +6049,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
-			p = pick_task_idle(rq);
+			p = pick_task_idle(rq, rf);
 			put_prev_set_next_task(rq, prev, p);
 		}
 
@@ -6061,11 +6061,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	for_each_active_class(class) {
 		if (class->pick_next_task) {
-			p = class->pick_next_task(rq, prev);
+			p = class->pick_next_task(rq, prev, rf);
 			if (p)
 				return p;
 		} else {
-			p = class->pick_task(rq);
+			p = class->pick_task(rq, rf);
 			if (p) {
 				put_prev_set_next_task(rq, prev, p);
 				return p;
@@ -6095,7 +6095,7 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
-static inline struct task_struct *pick_task(struct rq *rq)
+static inline struct task_struct *pick_task(struct rq *rq, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -6103,7 +6103,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	rq->dl_server = NULL;
 
 	for_each_active_class(class) {
-		p = class->pick_task(rq);
+		p = class->pick_task(rq, rf);
 		if (p)
 			return p;
 	}
@@ -6203,7 +6203,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		next = pick_task(rq);
+		next = pick_task(rq, rf);
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
 			rq->core_dl_server = NULL;
@@ -6234,7 +6234,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
 
-		rq_i->core_pick = p = pick_task(rq_i);
+		rq_i->core_pick = p = pick_task(rq_i, rf);
 		rq_i->core_dl_server = rq_i->dl_server;
 
 		if (!max || prio_less(max, p, fi_before))
@@ -6256,7 +6256,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			if (cookie)
 				p = sched_core_find(rq_i, cookie);
 			if (!p)
-				p = idle_sched_class.pick_task(rq_i);
+				p = idle_sched_class.pick_task(rq_i, rf);
 		}
 
 		rq_i->core_pick = p;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 749c1453a809..ca2a31da8107 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2422,7 +2422,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
  * __pick_next_task_dl - Helper to pick the next -deadline task to run.
  * @rq: The runqueue to pick the next task from.
  */
-static struct task_struct *__pick_task_dl(struct rq *rq)
+static struct task_struct *__pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2436,7 +2436,7 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		p = dl_se->server_pick_task(dl_se);
+		p = dl_se->server_pick_task(dl_se, rf);
 		if (!p) {
 			if (dl_server_active(dl_se)) {
 				dl_se->dl_yielded = 1;
@@ -2452,9 +2452,9 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	return p;
 }
 
-static struct task_struct *pick_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
-	return __pick_task_dl(rq);
+	return __pick_task_dl(rq, rf);
 }
 
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba21..f00bb75ad539 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3397,7 +3397,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 					struct task_struct, scx.dsq_list.node);
 }
 
-static struct task_struct *pick_task_scx(struct rq *rq)
+static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb..6bf097e39b4a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8852,7 +8852,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	resched_curr_lazy(rq);
 }
 
-static struct task_struct *pick_task_fair(struct rq *rq)
+static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
@@ -8890,7 +8890,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	int new_tasks;
 
 again:
-	p = pick_task_fair(rq);
+	p = pick_task_fair(rq, rf);
 	if (!p)
 		goto idle;
 	se = &p->se;
@@ -8969,7 +8969,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	return NULL;
 }
 
-static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev)
+static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev,
+												 struct rq_flags *rf)
 {
 	return pick_next_task_fair(rq, prev, NULL);
 }
@@ -8979,9 +8980,11 @@ static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 	return !!dl_se->rq->cfs.nr_queued;
 }
 
-static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
+static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se, void *flags)
 {
-	return pick_task_fair(dl_se->rq);
+	struct rq_flags *rf = flags;
+
+	return pick_task_fair(dl_se->rq, rf);
 }
 
 void fair_server_init(struct rq *rq)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 2c85c86b455f..01e9612deefe 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -463,7 +463,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	next->se.exec_start = rq_clock_task(rq);
 }
 
-struct task_struct *pick_task_idle(struct rq *rq)
+struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf)
 {
 	scx_update_idle(rq, true, false);
 	return rq->idle;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e40422c37033..6e62fe531067 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1744,7 +1744,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *p;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb5998295..35d7b328a9c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2401,7 +2401,7 @@ struct sched_class {
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-	struct task_struct *(*pick_task)(struct rq *rq);
+	struct task_struct *(*pick_task)(struct rq *rq, struct rq_flags *rf);
 	/*
 	 * Optional! When implemented pick_next_task() should be equivalent to:
 	 *
@@ -2411,7 +2411,8 @@ struct sched_class {
 	 *       set_next_task_first(next);
 	 *   }
 	 */
-	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
+	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev,
+										  struct rq_flags *rf);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
@@ -2574,7 +2575,7 @@ static inline bool sched_fair_runnable(struct rq *rq)
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_task_idle(struct rq *rq);
+extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 058dd42e3d9b..1c70123cb6a4 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -33,7 +33,7 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq, struct rq_flags *rf)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;
-- 
2.43.0

