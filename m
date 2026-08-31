Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319C4A6CEB
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183906; cv=fail; b=qiV5hCFkJpZjESI7O2M3olR0kahk1nOyqj7ud1URcYCb2BAoDdX15Wr+i0R/dxJffsJncErgVctpMi601i9i7PC3/7ZT7pLBV8zM9A8ktRzzSkUf3AxMTaOdVTPyKhDfR1qPUpEohAmz5EXTS/4GNv4xS6tHjIAaoX+sG9w8P6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183906; c=relaxed/simple;
	bh=Wq3wBXv6BOsPy4L5d9OoKrvq0N2MREydFk0OzlHAFAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OAxWaQJPO4d2pPUnKCHkqlYdcCoXDUEuy0HqCru6MlK2RDagAVViw4wuArXfNLXVj75KvxPowXLln8M4Jt3C5zdS4ON2Bvo2r5TzDkqAKe0S3hPTnFJ+zKC8B7QwbAu6hUe/p8SYEosI5j1D6ho3pL8pCn7h2HNRFGxyK5CUEHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqi1PR+7; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqi1PR+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJNGTQhwN5SK6KeqGR2Rvp9JZZ5mTIF/9RJZ5vOx0OS+grBHDwm8ucla7wf/eqSeY5EPr23Y0GJ1NeX/lW2z2YJdRCw+KPKv09GDDtbrnaqu79A5X4dElwecHfeRqSjeYfH2Ngu15DzTUKQBITeenyrj6oWmo+HobA/wc15qjUWKQwOrx03BJ7Zo+Z9pmUGXKQH+aS2xpJvo98lHKpwW91Cied1E5jLJRTPg+z/VGofpApX0apIO4yDm9Rjf26KLSM7dSIHn4iwGAJg2ifV1xN9351CC+UkrkRL4p664xPwZj7HZGlcSeB+B+QufEx43Xgcflz0NiD//nHnPXRfhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh/cIef6OruU4Kl4uhFyYrMto78fRMpVVLFQN6JSB70=;
 b=nyC9rOwv/NKWiMnf5QeKAzNEur5JgqhA9C7fj2E7Fu1z4KF2LcN5uAcvvwOBGUlNjXRjQXdPmlBbeTBy+BF/NJaxnAXS6zWORWoMEAZjn2xj97f9VFozQvARJQwDvWBxhTSDJyw+mfaNxS6AG+QfdRIK0BVdlIOm6bw9CjwcfmPMIqECztn7YMhqajYhAdlB004RuKCKymc5tUAV389jN+OzBVgCJ4lAgglcnSUAqItmMujZYEN4F5KklAWXfzIwJTaWTKJdKtKv7qQuXkxucI8u3Kp8LZhS6RDhKgwLig5HS3em7OePN+GMQ5drLZPBdjGDGI6SZirno6+JT61nqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh/cIef6OruU4Kl4uhFyYrMto78fRMpVVLFQN6JSB70=;
 b=uqi1PR+76piM/e6lQTIz6TVZyw8AIJ5wzyX2cZCfgx5OI9OrnTuRUL0w/z4gh3b4Z8AybPZUauweSOBvu6ccu0eNouW3p3ZHiGvw6i5SjDL4mSU4LHgsYns/KrAzeihondW4NaLjES7okY358hXTnQLryDv0Du9XG9V3fRGUkGKTVTlozCNjh/SpqR/SJDwaqK6cOVIJc9a0oq2wEoswJ0DA8p26Ff4O6/4Uw12Fr9EctzYu/ctjyVHbpBBZ9jl5oTsi01Lnd4XTKW5hxC8kOraYxaya2fWHFupQfiJ7mNilJLIBClhFxZx993hia75PJKx9Po3qvRHyhOGon+7Oug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:44:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:44:58 +0000
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
Subject: [PATCH 09/18] sched_ext: Block proxy donors across scheduler transitions
Date: Mon, 31 Aug 2026 15:42:19 +0200
Message-ID: <20260831134338.1531664-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 353d9e07-f0f0-47cb-5fee-08df07660a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bdZl3d0kIEt2+bZgT7oQfEDjA5CGYf8LWTnaAaqu3iduaJoxGGGhUKNll+nRzk7LmWKtsdjoMZNSFOYwIHfpESRseWje96ze8JoRvQAnVC6RjgNPVDI1VxWhn8PHQMziQmR9J+c+Ejw1+a+OocvNIlRNzPIuX+kEjB/p6YCLgqK+lGiX46WWhrOR6gE7F2ualCFRdEhk7zgeB2HouicGq0W/zX6h+PnMCNbZIu+BgSQwmJT6d1tD4L8fxc7UlGUwbawYqewGAPvdNEptT1JtHIaLGRYrT4JMGxZJ3L5L7ovPQZIECSox3JE8HC9i+bEdhYc+qgGZLEb8AGs9GUNhcuBH/j1lx+jJIlvr9hsOewlTa2Qe+eL+cjBFqI9I0LPLBcCHup+HIEu8RGd/gqMyAmxQw8M4C7g9kF21n0xDc0EtJ3MeVxVBTjCm2d7H7y0GfAULYs+FC2eUX8y2W+8FzKT06q62ZiXOWaFSt1A7kIJXuTUiIS9+JEQ2lMyF4GEYkhMGVxp7qJoJGtLPp5VgvYonDuu8fEHUN1LPigwHeBfC6v4FQ7WX6glDfSvSVIpi9Pu8UtGMG0KRpuGF+XOGqCfgLtZR+OqWnjrPolY34jQr+2gdBzvsuOO/qYg+A4jJKs8EBw6wfYGq7ydGYHoW3Ob9QIDVt/YgI4l6dcKPX7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tlwR2NyjGfSilWa7h0srTelQ8sFz84PpFdAfd5dNMGzZaEpDXoKJ5ESyrS3n?=
 =?us-ascii?Q?/4voWIj5GuRvvAfEI9dKueIDJPhKh94Aiqw6Gl3MfjFVTyR9oci9oGIuSbmm?=
 =?us-ascii?Q?LzJUz1hJev89afZIbPpLNbisoY8oK5P1fpgwhEvpO2On7iAJZyCMCsEKio8J?=
 =?us-ascii?Q?WIKzY4xkPH6IVHWCNJvUrvIWGUpk0dASdXBNI3zC4Xa9H19Wzvk6pr5bKA9I?=
 =?us-ascii?Q?gJqpeJCZw6dUYfXnzL2yMgZkAdRi+ueOHBws5bpIyAS7JWU45XJulQgbDddc?=
 =?us-ascii?Q?ucAqdpnaQtjFDt1AXQ6CjNkk0kTFK/7MChqXjTMMLnP0gFPWI7nvG1ca3K3P?=
 =?us-ascii?Q?t0bzZUoBj+e43/R54b8LgvD4cu5bECIML2BWJw9qHXI0HluH/0XNlfUCOkRv?=
 =?us-ascii?Q?BqOPAA46DO+SDYDFrefp101rbiyEGSX0jFQhBnWjtK23y0BHHL2Ov1MfJTqo?=
 =?us-ascii?Q?0KnXv9acP9ZyT88+c8utbd82NrmCdcS6JtqJ4aJdczDZeDCbfi4cFYpPwHom?=
 =?us-ascii?Q?hHMeq5n2AvIkHomC2fcWYxxYtwvx63HxxSkY23ESkw0GjYM7jQ4LAszP+0bY?=
 =?us-ascii?Q?MhbrxGBDy7tX0QoB38fAF30301wSD98mnlJWTrIE7p7Dh4eCZD5JJwa28lN7?=
 =?us-ascii?Q?54PBu9uWwxMqRGq6FCunF98wDqI7ED81Kgt4KZci94iDB287XFgCUykowiBT?=
 =?us-ascii?Q?HPxd2MHaPa3pYmzUYhsPpiUx5VXrtJQN7VTzOjr5g5b1n8Q/WLoWC/eoCDy6?=
 =?us-ascii?Q?upmnp7B1lclkQJnQGjnEoUrP7dkV7bl7sQTqfHFFd1x/7MLSO2cpu2ViiRvD?=
 =?us-ascii?Q?nJB4Kcty0I++uSPEDxFbmYIOo62u2kSghwPyKY1IxekCZplKVZSsNSRt9XyE?=
 =?us-ascii?Q?H5m825FQAmI/IU2xC5cdTFfN2tf+8zvvLMmIsiarWZta2gTic2GZma0n8U1L?=
 =?us-ascii?Q?zM50rEAAM9dbW9ph40OwzZTnL+9rKANWCHxqc0wKxTuDIS1nWidECWWIf7m2?=
 =?us-ascii?Q?pUIWqOSP4PwiYpG65Tjif6/ScEInpUyrpileib/LnkDqsEsQtJTFKMzk8mAZ?=
 =?us-ascii?Q?wA+kPnOXtXC4GW6pW/ErFQ8gWq0fBe950jTfUNIYpDJekkEddJsQuJo4e177?=
 =?us-ascii?Q?Ogia3FJbCc9RNcUyVhH1c9u7TYWkjxRkjNjLbmAbvD0/3Wxml3nGMKvVCPUV?=
 =?us-ascii?Q?SPznuSywiDdBjPhcX28+pZbVTw8TxgwELAc6B4s66WSZTB85B5FJDW2X4zfz?=
 =?us-ascii?Q?dDDjG/bhu9TEk+fE0A6JhJD9d2hbZ1/bNqMbA/06r7GAD6gaPiZbiN3P9pwT?=
 =?us-ascii?Q?qLdc4IxHxRlGjibnCGB7cmypAuaVcS3Us4mrPp5NrDckohPzRwt1qUZBiwI9?=
 =?us-ascii?Q?yAb8fj51zKPzjL3alZzUrNwjapB1AjDgRUnYmn6HpXH338/56/vqWYEdm2iZ?=
 =?us-ascii?Q?BEGjq3niNBiYKJ2SNU1M2fi59uAvHXGKwShXwxuLffzq0/QwNeoaT6iyiOxo?=
 =?us-ascii?Q?qzbc56dLmNnu1JXC0gmv5nAnc2fknlqq0BBugAO2HmBC343sHMdRKfVa6T65?=
 =?us-ascii?Q?CtxZaLbjI+A3NeoQLfuKjHH/1YAwZodwOj++bJ4aYj0JPk+kGuZRiLKsfsRD?=
 =?us-ascii?Q?Ur8rOAiwk1xv1vABYjBDmvu2q/pHMA5dAwN7341d5G7W7TXXK67JbJoJ7/vR?=
 =?us-ascii?Q?HteZE/BnT1g0pWYHEferykLZcY/xWoE5Aj/IfJJRaGsbV44t5revXwo4HEVm?=
 =?us-ascii?Q?hsGQA+Fkyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353d9e07-f0f0-47cb-5fee-08df07660a85
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:44:58.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEQqPt3xIZf4+zhGq/2ObxLcwh+5s8q1/UKbx4ZrFhSGIsLDYgD0SopcVvxTkxnBlkUZdxmFTSQ7FW6UBWaHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

Proxy execution retains mutex-blocked donors on the runqueue so their
scheduling context can execute a lock owner. sched_ext cannot safely retain
such donors unless the BPF scheduler explicitly participates in their
admission and ordering.

Make sched_ext reject retained donors by default. Implement
scx_allow_proxy_exec() to force blocked EXT tasks through the regular block
path in schedule().

Also fully deactivate any retained proxy donor in sched_change_begin()
before changing its scheduling class. This prevents sched_setscheduler(),
PI transitions and sched_ext activation from carrying an existing proxy
session into the new class.

Some RT/DL PI transitions could usefully preserve the proxy session. For
example, an RT waiter can boost a FAIR donor which is itself blocked on a
non-PI mutex; retaining the donor would allow the boosted context to keep
proxy-executing that mutex owner. Doing so safely requires defining which
scheduling classes can carry retained proxy state across a transition. Keep
the conservative reset for now and leave compatible RT/DL PI chains for
future work.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c    | 9 +++++++++
 kernel/sched/ext/ext.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f142ab455b797..4bd956182af8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11302,6 +11302,15 @@ sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
 		flags |= DEQUEUE_NOCLOCK;
 	}
 
+	/*
+	 * Don't carry retained proxy state across scheduling class changes.
+	 * Compatible RT/DL PI transitions could preserve the session so that a
+	 * boosted donor continues proxy-executing its lock owner. Defining which
+	 * class transitions can safely retain that state is left for future work.
+	 */
+	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class)
+		sched_proxy_block_task(rq, p);
+
 	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
 		p->sched_class->switching_from(rq, p);
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f3e59f4fad4ac..d5ed996ebfb4c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,7 +26,7 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return true;
+	return p->sched_class != &ext_sched_class;
 }
 
 /*
-- 
2.55.0

