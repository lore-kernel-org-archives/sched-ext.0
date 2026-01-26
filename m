Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE032AAD0
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421668; cv=fail; b=W2mWI7K3zZI0kcrvjXsFZyWn/yeFW2K2vU5k/g3gG/ePJxESKTUcK15yiQGfxdriV9sP5q4uB5Wxj4ASKLVN6cCZvQbXW3ahW+BzyuIFdc58MIs3e+cZEIRmwDcV6SieTsevL9IEJUZzRIQAecFoS7K6CasJvqC6FztYnYnjgck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421668; c=relaxed/simple;
	bh=Z4uUYJTSyVvrPXcXHIULPQp/8qepikNYWAOGmVgjNdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K7k+7rXyZcFwNT3K9ibM3ZpxFUjAxIIZD1tbg34Rqs8CDDbfquC6h8dRJQUtUzdDDCM7ile6RbbYDlEKTloRI6yNKgVWa266ULLYIHk+PL6G317RZlLRMW3T//5bwjML9icGfddmamO++AH2Wxikp6g6tyMMfsWuOKU9c1P+IAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZeKWQP/4; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZeKWQP/4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As0dGHDHoZwyLTCklxXPyll8t8g8V+fUUZcTZA3JX8oc1laMXJu4/zfeGHqWCqS9qEFDz1yBjDrWcfIaUwjYIdWcSJgiYGicGKnv/IiCww4pKYYS2I71Hsv4beAUp3ajzlj70tLRzTExjgQsPfqQaP/czjgmcLA1C3H5J0GMSLUa5KMx2SZUksqUWNZtWO4rQGtb3b7D9Amznaz141TtXsSHfXzUzwOzkv8eXM7a08MIhKKj6+KHjCZupSeZwu2VB714c4koNcbN4RakuOb1D8dRH2aNh66pQ++2MardDHyxrFpFGNVK6lt7aJEGxKFcS00FmgOLf2eZPWA+6EHIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPJG8qHRfwbUrBEnWh9CT7qFsCkB+7QfAp+Cgd55RoQ=;
 b=UoA35R+nx4+WTeKkQQe+jdZ/g4UKzL96Ic++5aF6td1mVExkTDWmXtaKVcfg0w95UDLJH/oi2M18ybvY41QTTUi579LgCfWEICP1kxnbEghDy4vwt1mJ+q3YGiNMjqpfQA4K6Jr9Lks48yxAvbNg6/Iq0nqISVY4dCvRCjqZB0Ngjm4tiaLlN9ywtOA7t5+xDDCu/jr5DVzJB8VQm10P7uNo5Q83weYzm/9e1FTMAq8ezNjiQHYcOBwOQDTFNFydxU2oQyR6acM3A+5ooFdv/tWzJ0ps0viRDUUVAHvY5SzsCT9NNg1bQtFjvWeR5kE7HtzoCPgFIRDPvPv8A1Of6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPJG8qHRfwbUrBEnWh9CT7qFsCkB+7QfAp+Cgd55RoQ=;
 b=ZeKWQP/45L0LDjV0QooCYJYeokDu3YxeoHCBOcE+IqhHX4en7/oW4FrC2BS/SDjulxUrBp50ag6dXzDg/GMvK0FlJXJocjGsaLS2X63Foca5p23FFojeRXGe9pZX4dwuNheuxA9No0LvOieS3jB6gT2hp0Mhfy5qkxf8fIm94EWHRDUTQRIoXjyITR0RonfvqEHus3rUYnl95MYr+rxe417/M8g3s/BwgzLt5sHptUEc1nvACpNi6S5RBezV8QZezMkLZU/X4sgXgg7hLHR+ryOGRlQ8V+OMGFoOMxTF8haOu8PwJxKRUGPRuoG7cK0P3f2bm59R+VMnX1PI+lMbQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:01:02 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:01:01 +0000
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
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] sched/deadline: Clear the defer params
Date: Mon, 26 Jan 2026 10:58:59 +0100
Message-ID: <20260126100050.3854740-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126100050.3854740-1-arighi@nvidia.com>
References: <20260126100050.3854740-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0149.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::11) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc61a05-98d8-4621-4a5b-08de5cc1cfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/AZBA2V7o0FimvX61Jv78svqDJme3mP7Y3YLeu2Mby+50bWkgOFT/Q/N0wVD?=
 =?us-ascii?Q?fScS+EvhzuuqzwKL55/9Zz7XuShc44Id6Wq03IzBPKj3oAy00Flw709c2+Vu?=
 =?us-ascii?Q?NsYhITO5OF5GrUs7KaJJLa9PBNEfZQljziyPWUTTqs8+V1lkUJLf8gmt1Zyx?=
 =?us-ascii?Q?odWcfTVZAMAfPv4pUtn+PXmAWJFBGMZkaCf3TxgKe+MH99xO9aqLpUJclNnc?=
 =?us-ascii?Q?k8f0IIzwAo+20Kk5+sKS1j27GRHEsh8DLI16f3xijS5/azMKg0rXYt3GKf1d?=
 =?us-ascii?Q?8GJ6tAlPXrxpCBRuTSsoEBWB3ZG/UUgNZFsR4xVXIthI+GiGyJBGHH1ynUlk?=
 =?us-ascii?Q?GnXYQXZscy/rnI4Kbn5Wo2WfTaq7PRLxnlkeE3YWUrnZ9QhsVyVjwEiJB4IF?=
 =?us-ascii?Q?/l94wDosKeXn81SMsgDu44N0NtAlcHMuTOpe61a+tHaKzuCJB/RN6sF6qBBg?=
 =?us-ascii?Q?6ztjm1Pk9uvcAem5aKiW80WOmImvwdnG90GwUeAAo/bFdET3rEKqm8Pb0WWv?=
 =?us-ascii?Q?cx9bebiy3cydrfIVB/7VjZUx7nGmJ9nH2vDcQ5PFZsgq0z5uTXXeD1GrAjIb?=
 =?us-ascii?Q?l8NmIVMdHFhQ/gHkEhyIkmpFxiRUSV/1Ncun2A0P+JaDV5GkXxKZY5hH1ZX8?=
 =?us-ascii?Q?v1HLZgeBKKP0jCFopOETdNqwBS4V+eTeKPSI3X0AYOqOob9tPcK/jF4277df?=
 =?us-ascii?Q?9Z8+upLWo9nzR5f7y0ddYpRYBVTUQu1keVqWSiUVgiehYyDx/Zjqc1iGeAg9?=
 =?us-ascii?Q?I3mM6G9ctmQwMbo8bsl0YbnzhhZ2Gu/dAfRTr9vCf75RDfH6HPsUvyzvUnfC?=
 =?us-ascii?Q?7NaRfZ3IoJD58T4/ES58xa68Ltk5dpR63xnlMuiMKJlLWI79BayiiMsM7j2R?=
 =?us-ascii?Q?GQUJ5oDGvyizBqxvuFupAy00MnwxuOMnEnClA9FT9zGZRh3GsDbUAKczIy5Y?=
 =?us-ascii?Q?mxvz8HY+sGZUn4jx0EjNWTsagK+YBBRyWxa+Zh6USZmRnpE+7q5lR1alJnAu?=
 =?us-ascii?Q?AAvHJM1vHHMDn4ZuD4+KEmlq3ArO7o9OHcC4dvdTYFp9PVXjJ+MXefxrV4a8?=
 =?us-ascii?Q?DybmGC8MEXl66hMNiU+isey4yuHIx0CW/klzUqZDG+u3VcuJyBUNZpgIY5Ou?=
 =?us-ascii?Q?rw+CxEtWYglfIHAr5ivQLnfYGVquoJ26TDbbLAWq33leAHuFkj9bPifJ6lIu?=
 =?us-ascii?Q?c4IxCuHUJfk+v+lhpgMtf1dl7iclGTYJg3jsWIX1rUBSSaFe/Fh4EBQTf/3y?=
 =?us-ascii?Q?38gfNM35EXwtMzG6rk4PBGi/U7dZUDEoE+gr9q4LNdrhPc1W4neQsFEcju3S?=
 =?us-ascii?Q?zoJ4Ylqo0ZB35Oar3ECyWtWinF3PYZov+UasJbU2ZGFP3kpBQ1OfanI1HSHL?=
 =?us-ascii?Q?GvISq/v79Q3IXduvFyBc1SC2DQXJPHjn8IdBcicKkripRBwy4i1kuNt1B3Ap?=
 =?us-ascii?Q?9Edk+JVyuUvAPngAqglycSxdqVNkWCKONg6wL9ieDRJr8uQv5Vi7wHT4xO3c?=
 =?us-ascii?Q?yhQu7huMKJf0uwk/lzIB0RIR+ifux+da9u9weNEnNWqaki1ZwW/ppYvF11E8?=
 =?us-ascii?Q?FldVLuSZrtVLTZ10RK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCBc1iTDwLhy5xmDBZdAsNkGpvs8y6TUw2olVXf66aKTFI4fXixrkTQrI6X8?=
 =?us-ascii?Q?ZdiLrR0vOIkyyCZEMxchXtxF7gPwojeFxxGXKExlr2gqjbS/4BM0WPAEuy3P?=
 =?us-ascii?Q?Y3mIr1b4nOcxHsEqY8xpqKo/oSFNMcPpRWVp8izSWyuOO+xHsg71lNKQn3eX?=
 =?us-ascii?Q?SFCwMnwSasu1uu1df00xrf2GOzGaKNLLNKYwbIewMCSCx7SgD9CFgx5+Ck4L?=
 =?us-ascii?Q?Pd7lnUnI4pt52etTkol0L3QPD/NYINrBmstPQV7LAQlrI4tFQz6gdTDCfLkR?=
 =?us-ascii?Q?XoekMhQc8ZDh9fqcZOqbIA6b1zDyya3KUVM4qCq7BhlbI2g/baM7BTJmLy8U?=
 =?us-ascii?Q?hOcfSUbTuV1PwrWWs/LfXTHAFZ9sbdemAUVXhtGPF3jNvzQY1V0k4b4N2gSB?=
 =?us-ascii?Q?GcbmJunrudWy8UH+ibzYudycjtEacieyhWnbrHn0TQvv1anqA9TOCObKfMAb?=
 =?us-ascii?Q?k6Dh+yHGFqcPcOi0qqPvgonskiDja+NpNt6WIaFBSGS24I1B4U6u+F/5a8+t?=
 =?us-ascii?Q?OKY3etaywHecm7ILkcTCRGo7SXgCQE8JPWwyyxbAIyi/iYFWZrawCcGO8uu3?=
 =?us-ascii?Q?hLFCHotjafYNKAcugkLOwlx6YSK7bZdTM4wfWEZJ+oh+hSOg0k3GKlvL+EDT?=
 =?us-ascii?Q?lx598cGgWmoya1rCd06FwJDckTuxxAJ1tDPPc/GvgH6r281pk3DdZXe3zPUq?=
 =?us-ascii?Q?BJEn81gUkiGiP9OEU8nldSIJT8xsSjp+CcW+xofxTNkh8rjPNr31yUe7rEQE?=
 =?us-ascii?Q?45t7Ycm7wuvcQwRXq9fWPo6p3j1yk1QzFiMIrOYI4XGx9z9bgcn9lS0KgMxr?=
 =?us-ascii?Q?DRCA7D1/QWYT0pOeRvIt3DWmT1UBLOz+MyDYYwclK9b/U4OIXb2JBQXa0G/y?=
 =?us-ascii?Q?CCU9bOZNyYjkLhpb1b5VvYNuQEY1hGLaLd89uitmUvqeTf4HbdTspC/DZkhD?=
 =?us-ascii?Q?nc/5pNY0dRFA2TD7q6TvexBfvI1ar+b5ppg4GCJDViok4IbpQ4vRo4oirTnF?=
 =?us-ascii?Q?llK+ygV+JdRaMCg5GMuHhJ11F5A5sxDSeW6bjx44gzfijesf9FSZW0cGwTQA?=
 =?us-ascii?Q?yJLSqWhQXoHlME+Rfo0ty6khAz4kV0JQNcukrbbWHTgVrKiEuOkdUatcTgrt?=
 =?us-ascii?Q?/lUWevlV42ZNXFfmLx/YPQeqGW3riN+WyAqVWgXVNvcE8jWSAuANhUyCeQoH?=
 =?us-ascii?Q?op6nrxg00f2mNWSZ3BtyhTmVIYG3KprfJR7zbThpjfFxQgYQG7v11Uh4HEc8?=
 =?us-ascii?Q?UBfmcTa2XwZJZDuVSe1bxNIdjAFIH4Rr9ZlVw3rJHoigh2Ml2Z6bSZCMFOq0?=
 =?us-ascii?Q?P3bJUWhDqxTeQYOxDgZtifxAcAL/2Uja0Lz6PSkQnQo7+UkxDz02gkXEUGuS?=
 =?us-ascii?Q?GAON7emc6NtT/ZADlV8cpgKXpXvfThUhjMveWJC3aW1L9syPCH862AHmZER1?=
 =?us-ascii?Q?oiuG3fGKGH3GNnZaiKkmowHQbzjXsICPWH8rZPouBwK510OGZGnpGku4WdAE?=
 =?us-ascii?Q?SiOcZoR+qMe5lPtNaS+xP4FOxjdGkPb3FiNRvHqvYSvl9Pf7wz4uFNgs3jW1?=
 =?us-ascii?Q?w8gMQw1qZqeTbtjLD1KB2y9180rUax/E5HhaUS6khMvQhlswI8XWesudFt7G?=
 =?us-ascii?Q?YmoBY9GG7ztP47uXeAOWDiHGI+EaSzzAl5cuQvczSHnTHIe0yr053rYYEXXJ?=
 =?us-ascii?Q?soC73ZgTeYdcFHviL1vqlT6sMkbRbcB9I+yDMpaHwtrj8Bl4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc61a05-98d8-4621-4a5b-08de5cc1cfc4
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:01:01.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qbnh8OMp0cqkqAWJ05Q60oOSufY0m78YqaUfVzsm2ok1TVs1D7Orq06iLjj5zjZJ7eGLd6vydK8oYupA4tTXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

From: Joel Fernandes <joelagnelf@nvidia.com>

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Tested-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e42867061ea77..28823f7eb8667 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3646,6 +3646,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
 	dl_se->dl_server		= 0;
+	dl_se->dl_defer			= 0;
+	dl_se->dl_defer_running		= 0;
+	dl_se->dl_defer_armed		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
-- 
2.52.0

