Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391233C198
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253574; cv=fail; b=eCGLBddyYyyw/08MgJDx/VKnMGzPjQQAv5sz1IJB60wMhtw8CJ4quNZGPj8feBdqByrvddWNILq/ATTf3Rt5QKgdkihaG8LIkMaaPwEmRybuzxddetxm6OHqOWyrA/g4iMGQsXMQATGFxCM+LbgsL4j646sWsyUw1lztLjkSRQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253574; c=relaxed/simple;
	bh=AW22c+oIVPm54OunVnTdZfmqlUX7ak5Fx9HZTSaJyuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8C1SvligoxUeuqbEkJYwUPcxcTukJfUSSQAirNNH3X86ZYnL2bQDvA1oEEYQ3/FAO2H6LcnPqPbXZw/pyUeA/GZ52rqibgFJBdo688YFQORcj+t7duY9hvSJNU4jXpVGTSduJr6x48n8XRey7ZrBkE5hAXfdd2tFY+5ZlpGIwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=giEXowxl; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="giEXowxl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY87OBJu6S9ALhYwTtQHVH1xMe087/I/2d1n72w8/MWskK8Lbu1CS6SUbFsQeSepUrT9DRfbqwQSC813UiJNzHDzqLK8O8GtKEMnUzZPS0ukLItn07Dtxq2E1GGX8+afd8uxHTqJ/QCv0Sq3Xs6Cz2t0WU+22x3/J/vKSAl4YosGO3+65YaVzq9bGmReXAUt2cEbv6aquSkLvJGtgmsBjIF6CJE3QSEO+GVGc7n945nZfZ5uaWub34Oe5AZOpzB09W3J24Uq6AZvjNi5PejjoWQM0Ua/Z2vQCueLR+3zKo6zl5MQf8+8KQDNsORPLppExWkCRwnLlo+Uf73lLDnNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKBjgsNrAPpclO6ZzyqJNEcASQmIz711P7QoZ9+Jc5Q=;
 b=VL8Nq1I/vrvwpAU6gjntjMKoqCGCXFbAZ1hzoBfWEbpI6Rm0px/O7Yql7PsRh17YGUA3/O14wjuHwlWDm5gG7ETylS2GouGyItZHsQc9goOBAYiVthdQLCcJ4tb+lWhKWq5NkkVQL+WlPfdsKI7eY9jlK+KRFeta4Bgdosmo5BzK5rMNejMnzkHWnG4TI0rcI9I9VKqazTuWWHtqBSPCmVxjRo3inNKPERyyLAqzelDNJxfWgclqLhiB9g66vyczcJxFCCcN0qqAhb/UjTfGmKh2ZO47BMAjUTF6nxrI2zBJ6iGPlPnZu8GLbE31d+CswaCOkF/P+nX1L1Z4q0epuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKBjgsNrAPpclO6ZzyqJNEcASQmIz711P7QoZ9+Jc5Q=;
 b=giEXowxlllIGN2icvgb0FOiE6ODUUAZd2iAcUGs2/t2iL2NT79NRwsryetISEXknrL6+5kYBb/+9SQmiXjv5D3dfRV7A0xueFeD48veUBx7Hq8AO++nPkfZYT3/oGCsxLRXdpTgz4odkPpGpEhUnUVivgElEjtX+aSs/S10xK13VZHLeuSALrVkpG+Ska7CUEB1pvMb/GBAfCnyOA9WDaqpZKzhWS3YG+xb6Xjas8y1VPwvjicuYXEvMvCTSuV3cS3JrfxyAnVWrGj209HoZK6cgykchlAbQzxO0Z7W9236AfYYlLO5RdfioXFHpMdIl801HfLc+n9BS1/Md+dhMVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:46:02 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:46:02 +0000
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
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] sched: Allow enabling proxy exec with sched_ext
Date: Tue, 28 Jul 2026 17:43:33 +0200
Message-ID: <20260728154425.1549660-16-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::28) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f9f5a8-7457-46ba-0d49-08deecbf53d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W2UmjRP11olJHU1ksqLV0DtORyVcV87T82iWakPK0OqZ84ij5cPdcUpVds2ZOJZfc1FziWlqCUgUYpShF7nTyLSAh5Oot9IvXqC8x9L0gxYawrZRzQIXPZQAl7BzvNzw96Drl6MSi07vxSIhAxozRwkIACV1BrtP3EXzVN4k6VP9UsYMMy0CPJEJZ/xWhl30/HPpZffdpgU+/yKn9kXfPMTGd8h4d+RGqcQBbDgJDpdttisdsCwOgmvheJSiFd7+6jICQP3YZrAV9lf3oMSyZb6npRFOT5GvJUgCYioxp2SSZ5CofyLYIHpIaH1ARPucINLLgdw19O9zwp0CMDyfR6HRyMMyVLB3wOxsKf3ELA2SIHp7XxtJUPJgsBjMzO7SyumcskJPsgy2b8J7PmHsdWW1yki5YbFecBFVqgYN0alQcQPctyZBvzB8ZI4XiSOVU5jD2QN2i61Zd19jIx8gzb7t+aGOTH3JeBtGLNCV5abPdliC+R8vjFjiD64/KJKw7IJPPgfTPSZLbjIOVTwhIiMY/SYlp5VXCdFa6XSSUrXNbOvNaq80Cwy1Sn9SD2DoPCl+5FFcw0y9DzOJmE3vl7TGc/qftHXE7gSug8jsCWf1JkfRM4uOKd9t2HvKNvQd/raINeXqAcQi8HzEtxONuKzvMBHAyXwVev0IK6apsnY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CFNDr2JqMF3fD1Uj/g6rUsypFiJocoAdk0TFCIrcu1t9whDEKNroxlcw9QOG?=
 =?us-ascii?Q?vehnkeYE4j//vQxAWVRM1pP+I5oZn8uVXMRQyw+IoNozcAqvmZdT8RrpTqKA?=
 =?us-ascii?Q?5My0BQzshTkMPqgVLWPvFczx8a/l+n1gRtEIpK1EMnPfh2HXqLuNHxdUwUy9?=
 =?us-ascii?Q?yrdeZ9DcRXgx2+0FgBz6zNbYCYue+InMQMsXTkZiR+43gf+9EvhGfDxwJspN?=
 =?us-ascii?Q?rwDeisVCPQIlmxu4yiweCru47i7sClcCpf/J77zEujrKk4XvvbNLP++kByd5?=
 =?us-ascii?Q?AYKEkrPd/zg7buSIO8+YCEvwm3qRA9xqpx3U2+R/0DtwtdiOo+XITZ5z5ZIC?=
 =?us-ascii?Q?mx9cP37wn7eHnWDIWoPdXssb8JhSEeDGrLfb/oOiZG7rLqZPrWstJ22cs3dP?=
 =?us-ascii?Q?OYQ+0Opu4uy3Cg/duOmJL044hheHX8EQbSXoLb0JZW6ArNvE+oN4pEEmRMfx?=
 =?us-ascii?Q?4O8yfF9aYVhi9G9AqTHayDJ9FSU/RN1rn886pxxbnJhMylyv7ehWI9cL8ePc?=
 =?us-ascii?Q?J5TZ1rax4iM5gnpu4+a/tmm2kTiEvMdPhM0xT06noHHgb2tHBoxyvG12K86n?=
 =?us-ascii?Q?95yh1jKms67HFYeNt4sVSNMg1phgOnNCnV6NNKMoTWXlDIgpCvTJlp6giCi3?=
 =?us-ascii?Q?s4jmKXJRfZ9t8wI13ZGGIQEtIsYgB/4hIgma7kVhxFNPUR6mVvPZa7qI08qy?=
 =?us-ascii?Q?rJUBosCeGWYlhI01YiP1ky/TlantgUUH0UyIUevqFluliL5m12bP7XVk2arB?=
 =?us-ascii?Q?4J6rhmy7v4JdrvH/fcJhMI9ojEOxMJq6Dyqs07RNJXFRF6jQ1+J5SVQt4sd9?=
 =?us-ascii?Q?evH0WaKjqhboOTaf68ty0XcZ2DCpxs69NNNHTI+jE7MBXU3JA7rPEAHuOi6W?=
 =?us-ascii?Q?p4Qvo+ZWCET9ONmpWPlpZVwp5wFcCYO3QWyleprM7ds9XABIVc1DgO/devFL?=
 =?us-ascii?Q?IxA00i3+U0D+6D0PdUQxRPNlqA9H18cSoqo/jVyGsSNvxv0x2+S7pF/LlDmJ?=
 =?us-ascii?Q?6NIa1Jwd4dsNVbgIl/B6Kis8gog4YK3Up1UGLPhzKVut2DGIO2hzgtYZ2Ikb?=
 =?us-ascii?Q?FFMf0YzoI0jG4d56ARyq5ehAV5ms2gH9eexm/rRY4l3bZ1+V9tyCcIIMTYwh?=
 =?us-ascii?Q?mWaHgR7Amq3GeD3PzsHiZ5uMkk07ENABB5WztWjOodRFmseVZ9wUbPmhpMs/?=
 =?us-ascii?Q?u2UgruS7ixHzrRCdc8b+EIlI0DBLWZi/T00Rq2XqYdCavlH+qwV4uNuVWZ5h?=
 =?us-ascii?Q?v1VJvWqB70dShP5qQuKPvyUuGauclvoPvaK55rR0IphBLyyk3dPWXenrJCga?=
 =?us-ascii?Q?blxMzUApmK9cltO0XVuRRXLTmTOOJ4oxiRsNdww/HS0yoYAlCOh9/gCrnpHM?=
 =?us-ascii?Q?onf3pOpR49a3TgfxzNO8m0EvfZyofGrxkZ2r0NREmX7ZDJJWB4fe1ZQ3jK2V?=
 =?us-ascii?Q?LKcHULnISxRxWU10buSbEoHZcDeBnoNAqDBcBfwSZZcTcwqhYo1iSNWvyTrA?=
 =?us-ascii?Q?z7T+blV70yl84FUM8FGvMRe4ov9aJI+iDn9Bo8SN+fri9O+KVbY4ABYxQ7zq?=
 =?us-ascii?Q?cscF3VAAJe9Aou3BaMZO+KZNjDhuIujS0XxPhiKiFnGoJljI7+1Krde8WqSY?=
 =?us-ascii?Q?28KTeEZZKZ8wVkVb83Z8N6HyGrdqVqAIkWtmviUoJAxOO0+ehk+IK4IRU5NH?=
 =?us-ascii?Q?DZn+hw/hrzpgp/OLnUlWRCzItrIL5UymKDyEE75brByz3Q78kshKEYZ93qUa?=
 =?us-ascii?Q?i8St/+HE6g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f9f5a8-7457-46ba-0d49-08deecbf53d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:46:02.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIXkWfXo/aAZ4c/cbIjvjUbHzcYpIrwn+vMCxP0KOCEinWCwmgmZaow4afJqx5P8nG7K3+RzKJd2EFULaWRKvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

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
index 5230d4879b1c8..0817e62266e03 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -934,8 +934,6 @@ config SCHED_PROXY_EXEC
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

