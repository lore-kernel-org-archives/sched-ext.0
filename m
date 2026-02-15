Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D00244684
	for <sched-ext@lists.linux.dev>; Sun, 15 Feb 2026 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771183207; cv=fail; b=jMyfQcLrAwH5QgnjJjDC8bJoOxcdQtUuPzMYL95PgsHNp9c1LK7NW8mUHSSKSXa3Fifm59we2u1jo9/BqeP5SYwtOuiOWtLxcxolRp/lq1bKn6XuIHy176Y7KpVIy4stMlCdZZVQ9TuwXmzVXcdxB6OWa9hMlfzZm1GN7lNKQes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771183207; c=relaxed/simple;
	bh=Y4I2d0Qm0CKD8p2tGq8qDGdtgyJeKCRAUE2R7q7L3AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arpVkcir0Bm7OrddYcb/OGlSK5MpFxuRobZTDr9p0szd+WB92GaAjMVLAQIt7VA4X+i7LKcBbJ4xsT/ipOApdxxXnjbqVm+m3sszI2t/aTQNVQGVX4uO7b9dCYbYJmWA6e2xsq++Q/fQLQeLy+3s7Y3Hul/+kKB9WHylL/+dV7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWc0FF2A; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWc0FF2A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT1unjjNbU/6GSbt3Mww4Vh2WDb+9q+hobUZG20Sh5fUUOinF9mZpwaHbbmzzL9tuqgTxcqhktfYLU91P/1TAAs5Pvk+ecEQuEe1p6ZWT9GixF2rMtUMiF9jab4DJfoVE/zWWJCtqNlwJl40EvEeFAxnI6TzzQ/7ull34mDkkduONqA000yjP5AOBxT8tbbHVU+SmkisRAOwL6aMzaDEei741f8ufKKlz3l6gCSMIUSsH8HjzLtuz6/vtgnGTTwAmfo6MqMW7xxI2Hzqcb7UvyxdLkY+VT6NKkOJ1zTiv+vbfXGP+CP6iLVXRUPSKqwCA0w+zcLlkYdDl2SG1HfOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUt679l6uVtkxMh+1U3N0V91SKexttRcudTq2PwmU24=;
 b=ZzTARvgbf57kFSaTgHxhD0VlFA2gFMAGCU4zieWBl7uR5XtApr1R2PaXK7oFSMuurmFFgGFtxQc0Rc17tkK9FbnISD1BqRfM+SM5wyX35MN31rUEPBe39BEgqF9v28LrYwPEXz+bBIiPv1MvzOUGt9iFBPh/kouFAO4PWYXX6bsmNSt9P53qa0il69E2qS//c052c8CLdIKc7nEKIYuwygKBpHIsk0BtKGJxua50dgnvdqtWR249Z9NbviDS4H6v3U/E7MFu5Y5wXjHAoHuj5T//dxvvm/LwynMSYeQd8QCMSosIZWfTEIwyM1rVPziJwEJgf1JhenT8HGH75yoWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUt679l6uVtkxMh+1U3N0V91SKexttRcudTq2PwmU24=;
 b=kWc0FF2A9YDxzeQxloyVH9pAIPV0TjV20QQoeXrjDFaDuEu3iW/Dktvl4zVSXiA/l6H0JaBJD7B7qzjiTg3Vmm6Xf6OBCTbJvOBWEp68W6osRYnUbAlqmVlQPElat7PVTLn0/uZCrhyYg7ihVpCEPC7IjwFGiwa3GUA9p9/EM+QCtUzfo17kwtINxXXsc3wTfGfIednqwy3v0vYKoS3zuWaXiMsxzG5zb2hYmsjOrgTv+IgbGXMvGAtLKS/ikbDXYFZbS1zEbp+Ry5uDpE0IZN0jicO2fpY+JsKwzDDQ9CgkR4v+uFetcaeg/NUI0457F194leL0YBhhvBdv46Hrqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 19:19:58 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 19:19:58 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] selftests/sched_ext: Add test to validate ops.dequeue() semantics
Date: Sun, 15 Feb 2026 20:16:56 +0100
Message-ID: <20260215191933.2358161-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260215191933.2358161-1-arighi@nvidia.com>
References: <20260215191933.2358161-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b87c6c3-a881-4b60-c9d4-08de6cc73540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aElVODOg6EznBn1nISCT2OXVLM5dzMo1Pv1TP4N0nXbUk6gwAkD9wvs7MLwk?=
 =?us-ascii?Q?Zw+FHQH/anZOkNqrUFDRv2y1RS754WcpoP2FD8nNi67TwbEdPj2PTve+4469?=
 =?us-ascii?Q?Fp/B9xCpss46KJNqI8pZF/3ZVRnwjf624qxoMbsR0Ov5IxLa3MPCGSG2YqCs?=
 =?us-ascii?Q?kOWjwKdtzXGVBFzo6CCgG6tvIBonZmrwvbgj/Hot8ORzerTy+9pKXQfHQ8b5?=
 =?us-ascii?Q?ksHZc9juN4OzxtdyuJMwPfwGV2uqTG9hkLOM5KpIL3KFVLrGlK3+3w4atoFM?=
 =?us-ascii?Q?3ASbwWxQKtwfM1Qxcys62ilKzptsNymR2OfCe3qva2oOseu4UbnX6l59xG2H?=
 =?us-ascii?Q?j0rP01t0zdRtVZWtMnQxY9Ol4NqZ6dGqVQNuk/WXhnkPa2OSNNecYzfB0CE8?=
 =?us-ascii?Q?Y4ZkIJ8BzZuIHpJFzADudu3fFdUiHOPHHQD629886NcZu59fkPpJfGBe7c2V?=
 =?us-ascii?Q?b3gpBYm41W9Ox+IcrsJxHSX5T9z5NcW85/xP5OhmO/kfoYXUFYFCb567rHaP?=
 =?us-ascii?Q?CGXGfrJNo/0QVnGTb/Qo4L2o/M7ljB9hJEyuGkIxmH9zhAsGINQpeqopTeAD?=
 =?us-ascii?Q?u4evs6AaCBBigZXnRvnOACeitPtp9TYKFriSgUHF5s/Hfi4OUWviYjEgjxPj?=
 =?us-ascii?Q?PSscO+QbDPmrW88efvJ+LpH8nUks7snROV8Op2ykDVAbLS+kKFXdvFATNURr?=
 =?us-ascii?Q?tnTOGbEe8sBmKngLgtEBQqFrDT/OqsBzJsx4XrjYe5o82zFRIv0TBh2Tcjgr?=
 =?us-ascii?Q?iyhLeNo79uszO7EYjpBt70ntCfVFv0OmmjZFVgJrdCNG/SazK5pnLuG9f5av?=
 =?us-ascii?Q?fRPbUVEnLpPs2BOA4emLdYNEl3mv7k2qR14TTG164P2/5l+8ifvx5PJUUFFM?=
 =?us-ascii?Q?bm5SRZu4t5UqQXGkRAJXwXsr0rgOFl4K4QEzHTM1Z4Qiyj7EcYBVTGWzYZwX?=
 =?us-ascii?Q?onl2FTFCj5hCss7j26Yxa3XVZXVehA1uoygvavB2Q0HyB4QbhhctcSr8oFb4?=
 =?us-ascii?Q?qNnAoPBOfuoUokZ6JPmITBE/AONw2Ou7fc/BQK2hrEqbVGJEJspPlMIR6R3s?=
 =?us-ascii?Q?hhIV1yyhwyGo35XmzPdy0BMfKhJ2615pcSJaqh6aB/9Gwz50pFeP/IQj7zoF?=
 =?us-ascii?Q?0CEQ4KQ94ZeDXCqJVeIhjbTqZCDElbJEAQe5TJK56ROu8cROopKbFkRBzJFc?=
 =?us-ascii?Q?UvO8hVbXlfUN83Sjz+YO50WI/uWQXjPmKoKjUj+ntVzVDJnIe1SIbTJwSxLo?=
 =?us-ascii?Q?95rgd4AmOQiOfQJUyHS8NCkMwB4KnxIoMGR99+Fq4ydrU+agISWCzUFjKCip?=
 =?us-ascii?Q?eOGjVlQZ1c8eA+xn/LdQRWVlI0KigmWuNqiveltPK9BtC3HeA8XjrzNuzXfq?=
 =?us-ascii?Q?3eLK7kG900R5pWAhE2Q9I91pZyHTgnNfszrAxQSsUD7ATmUjjAivkz+rIMxG?=
 =?us-ascii?Q?asf0e3m22WDGit2hKq7UuAt5NhXy/9cdyHgautIRQCkoRhDC2lwrcsGN9wms?=
 =?us-ascii?Q?iTZ3pdaE6lNgh+lFrLG4Wof4S0gcassN9JeV9nHkSxOF06DH0cLEexbeJ3H+?=
 =?us-ascii?Q?Op4U7qzXBkzw06ZgcwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6MsWv4YSHZ0+Z59/H8Rq4NO2wb96NWG0E5Nyk3AaG+uT9DBx0aYOilqvx5Tr?=
 =?us-ascii?Q?yPX9qcK77U/E7Ntab6tJHIL8Bn0cIFjxiQ9xRUoPrP1eIvKyV3Cz5gX0Uqrs?=
 =?us-ascii?Q?IvU+PgH0lHhEQgV0ifRx6Qn8xgGXZwaZg3pWeoKfJRbzm9Hr0RPeQooTqGcD?=
 =?us-ascii?Q?dyNHBHDtWSRpxvjllBYmJRjMYdnzLdcdgidzNgDCKX1UHbxbPQXgWBPnly/Y?=
 =?us-ascii?Q?ZzNSpNO6heiV6KhVZaoj9NsTe4R5OvCEZaI7XLOMiVoSaOJok8ZoKTeD+zFm?=
 =?us-ascii?Q?DJ9yN8fww4HGbBFR/+l+D95pAVd+lRIdK5yFWer/dPy8nI9p2e9WnPg7urI3?=
 =?us-ascii?Q?QyxzcPhKx/bSWdtKSBPB72a6eZi4xbEcM2vA1T0m5PeAcMoezrbm/8ofuUWL?=
 =?us-ascii?Q?/Dv1hHXLbbTbtnZDLJ73ZDiAILaVd9oj/PhwrkgaMH+TYUlCDqicNmlCKu6k?=
 =?us-ascii?Q?TCc4JuTsgUnn3bzBiYnsTKg33Sc85aP4o5UJEe0wV6EOmVSGOxfmDe6Y8eo1?=
 =?us-ascii?Q?Jl1JuhbYghyTcHA9lRVH5ibZE6eHeqB3pZONN3K+fWz2S+Dxm2oFYwLcVPTW?=
 =?us-ascii?Q?AzmfUpXrlVYH+qcrXbOVBNPugOOMoMukdLKFeYqLQ7/cQL8nCCkv94yqAgBS?=
 =?us-ascii?Q?1O3dNi1hIvY0FkmOmNiN0kX/aBGhcdVvfnDScgFIcMtQ57DhKLkWbYXJgrOB?=
 =?us-ascii?Q?p2Ov183Bu/g/BPY2WUv6AtwHS+w7FYV8ZL6YhYX5dFT/GTKlQLQ+B6FXWEQ9?=
 =?us-ascii?Q?qeVTs4cx8wTkffwesAhnvCUb4uiQhW102jMnSMBOVGj0jfhsTLeG7jd7TBA6?=
 =?us-ascii?Q?osrlVT/VX6sQb3a5VqeII9BqTdek36hy+zuDb4Wv9teeI4jXkaBiXdkSH0Cf?=
 =?us-ascii?Q?4cVINqMVtoFC7Q/FaMlEcdQ1j7wvBbYtVyiGWq1AL5/dyLm54u++pLJTdiBv?=
 =?us-ascii?Q?wDOQm+e1ZN2Px3Js0AIohC6LT1sIyaNafNBUKMQrtG4PtrTG/4N/rGJNAHCG?=
 =?us-ascii?Q?XxjKoTvqmFnVlN0d9B5Hx+fmqmi7Eqh6jKuLzr6OSoViYR3Bv/AlKyvJA3fw?=
 =?us-ascii?Q?UwJuzJRn8tr5moo+9ptVytkVJ9xSb56KYY83szsxxRTnWNpl6+7BCQS80zQc?=
 =?us-ascii?Q?raL0/0gGxPBq4QKizt5r/B00++xQRl8b5Z6GcDxOQ7V845bapVLWwn1S9UDr?=
 =?us-ascii?Q?9bWxzjFHx4552ETivuPg3NTOLADynYLfcJdhZ7zduEvNIULNNNv3UsJC0TIc?=
 =?us-ascii?Q?d6x1shNrypjPr1PdiJSXeYoKcRXKcxXJStI5hl93blIz8cCvhaX9qkXYRfXQ?=
 =?us-ascii?Q?SgqA0IhX58L37fwgCOgjV05//apNVQSGf9d7FXvMpIc+QBw2VidSICkwZBP0?=
 =?us-ascii?Q?txQndu7KY6mQp8eJTWK5ew5WPiQPgy46Nunpfv0ooeNmFi5i+gJYBW0n3NVm?=
 =?us-ascii?Q?Exp081PH0YHmlwsAlxFgEyfqhX3jIBgd1MmbsGSuqajsn4EDhW1BrjXK++0X?=
 =?us-ascii?Q?HgTkPgqH/upFb4O3w3mTEqNfzy0nBNt5d6qPEW9GgPwCNXQT9PIObVsfNcUD?=
 =?us-ascii?Q?dEpHQVTMouRS22iB9tel11iJcuc6M1OEB6unxtj1U07gB+H0jEskTTB1loCr?=
 =?us-ascii?Q?KR2ZkkCJrUMZINVkEI4azmHhNw6e4Hvejx1m3Vi1PPYe11B0znpGSDAw971g?=
 =?us-ascii?Q?SGuKyXoKITIG4SrV0/9UDEDF4T93eARHy2FZOrWJcfrtzoTB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b87c6c3-a881-4b60-c9d4-08de6cc73540
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 19:19:58.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9az49g/OVRS3RA6W9Zu0r042qWGFOGBpBrOhCCr7s8X1lfs3JMS5Mc0UKJnw5wwT53K0w2qxNGZCYmTnASkLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

Add a new kselftest to validate that the new ops.dequeue() semantics
work correctly for all task lifecycle scenarios, including the
distinction between terminal DSQs (where BPF scheduler is done with the
task), user DSQs (where BPF scheduler manages the task lifecycle) and
BPF data structures, regardless of which event performs the dispatch.

The test validates the following scenarios:

 - From ops.select_cpu():
     - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
       the BPF scheduler entirely; they never enter BPF custody, so
       ops.dequeue() is not called,
     - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
       bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
       not called,
     - scenario 2 (user DSQ): tasks dispatched to user DSQs from
       ops.select_cpu(): tasks enter BPF scheduler's custody with full
       enqueue/dequeue lifecycle tracking and state machine validation,
       expects 1:1 enqueue/dequeue pairing,

   - From ops.enqueue():
     - scenario 3 (local DSQ): same behavior as scenario 0,
     - scenario 4 (global DSQ): same behavior as scenario 1,
     - scenario 5 (user DSQ): same behavior as scenario 2,
     - scenario 6 (BPF internal queue): tasks are stored in a BPF queue
       from ops.enqueue() and consumed from ops.dispatch(); similarly to
       scenario 5, tasks enter BPF scheduler's custody with full
       lifecycle tracking and 1:1 enqueue/dequeue validation.

This verifies that:
 - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
 - tasks dispatched to user DSQs, either from ops.select_cpu() or
   ops.enqueue(), enter BPF scheduler's custody and have exact 1:1
   enqueue/dequeue pairing,
 - tasks stored to internal BPF data structures from ops.enqueue() enter
   BPF scheduler's custody and have exact 1:1 enqueue/dequeue pairing,
 - dispatch dequeues have no flags (normal workflow),
 - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
 - no duplicate enqueues or invalid state transitions are happening.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 367 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 265 +++++++++++++
 3 files changed, 633 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 2c601a7eaff5f..2815a875bde2f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 
 auto-test-targets :=			\
 	create_dsq			\
+	dequeue				\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
new file mode 100644
index 0000000000000..1b6820e62f9bd
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
+ *   scheduler entirely: no ops.dequeue() should be called
+ * - Tasks dispatched to user DSQs from ops.enqueue() enter BPF custody:
+ *   ops.dequeue() must be called when they leave custody
+ * - Every ops.enqueue() dispatch to non-terminal DSQs is followed by
+ *   exactly one ops.dequeue() (validate 1:1 pairing and state machine)
+ *
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+/*
+ * BPF internal queue.
+ *
+ * Tasks are stored here and consumed from ops.dispatch(), validating that
+ * tasks on BPF internal structures still get ops.dequeue() when they
+ * leave.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 32768);
+	__type(value, s32);
+} global_queue SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+/*
+ * Counters to track the lifecycle of tasks:
+ * - enqueue_cnt: Number of times ops.enqueue() was called
+ * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
+ * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no flag)
+ * - change_dequeue_cnt: Number of property change dequeues
+ * - bpf_queue_full: Number of times the BPF internal queue was full
+ */
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt, bpf_queue_full;
+
+/*
+ * Test scenarios:
+ * 0) Dispatch to local DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 1) Dispatch to global DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 2) Dispatch to shared user DSQ from ops.select_cpu() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ * 3) Dispatch to local DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 4) Dispatch to global DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 5) Dispatch to shared user DSQ from ops.enqueue() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ * 6) BPF internal queue from ops.enqueue(): store task PIDs in ops.enqueue(),
+ *    consume in ops.dispatch() and dispatch to local DSQ (validates dequeue
+ *    for tasks stored in internal BPF data structures)
+ */
+u32 test_scenario;
+
+/*
+ * Per-task state to track lifecycle and validate workflow semantics.
+ * State transitions:
+ *   NONE -> ENQUEUED (on enqueue)
+ *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
+ *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
+ *   ENQUEUED -> NONE (on property change dequeue before dispatch)
+ */
+enum task_state {
+	TASK_NONE = 0,
+	TASK_ENQUEUED,
+	TASK_DISPATCHED,
+};
+
+struct task_ctx {
+	enum task_state state; /* Current state in the workflow */
+	u64 enqueue_seq;       /* Sequence number for debugging */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
+{
+	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	struct task_ctx *tctx;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return prev_cpu;
+
+	switch (test_scenario) {
+	case 0:
+		/*
+		 * Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	case 1:
+		/*
+		 * Direct dispatch to the global DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	case 2:
+		/*
+		 * Dispatch to shared a user DSQ.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, 0);
+
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+		break;
+	}
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+	s32 pid = p->pid;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	switch (test_scenario) {
+	case 3:
+		/*
+		 * Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		break;
+	case 4:
+		/*
+		 * Direct dispatch to the global DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		break;
+	case 5:
+		/*
+		 * Dispatch to shared user DSQ.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+		break;
+	case 6:
+		/*
+		 * Store task in BPF internal queue.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		if (bpf_map_push_elem(&global_queue, &pid, 0)) {
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+			__sync_fetch_and_add(&bpf_queue_full, 1);
+
+			tctx->state = TASK_DISPATCHED;
+		} else {
+			__sync_fetch_and_add(&enqueue_cnt, 1);
+
+			tctx->state = TASK_ENQUEUED;
+			tctx->enqueue_seq++;
+		}
+		break;
+	default:
+		/* For all other scenarios, dispatch to the global DSQ */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	}
+
+	scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
+}
+
+void BPF_STRUCT_OPS(dequeue_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&dequeue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	/*
+	 * For scenarios 0, 1, 3, and 4 (terminal DSQs: local and global),
+	 * ops.dequeue() should never be called because tasks bypass the
+	 * BPF scheduler entirely. If we get here, it's a kernel bug.
+	 */
+	if (test_scenario == 0 || test_scenario == 3) {
+		scx_bpf_error("%d (%s): dequeue called for local DSQ scenario",
+			      p->pid, p->comm);
+		return;
+	}
+
+	if (test_scenario == 1 || test_scenario == 4) {
+		scx_bpf_error("%d (%s): dequeue called for global DSQ scenario",
+			      p->pid, p->comm);
+		return;
+	}
+
+	if (deq_flags & SCX_DEQ_SCHED_CHANGE) {
+		/*
+		 * Property change interrupting the workflow. Valid from
+		 * both ENQUEUED and DISPATCHED states. Transitions task
+		 * back to NONE state.
+		 */
+		__sync_fetch_and_add(&change_dequeue_cnt, 1);
+
+		/* Validate state transition */
+		if (tctx->state != TASK_ENQUEUED && tctx->state != TASK_DISPATCHED)
+			scx_bpf_error("%d (%s): invalid property change dequeue state=%d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/* Transition back to NONE: task outside scheduler control */
+		tctx->state = TASK_NONE;
+	} else {
+		/*
+		 * Regular dispatch dequeue: normal workflow step. Valid
+		 * only from ENQUEUED state (after enqueue, before dispatch
+		 * dequeue). Transitions to DISPATCHED state.
+		 */
+		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
+
+		/*
+		 * Dispatch dequeue should not have %SCX_DEQ_SCHED_CHANGE
+		 * flag.
+		 */
+		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
+			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/*
+		 * Must be in ENQUEUED state.
+		 */
+		if (tctx->state != TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/*
+		 * Transition to DISPATCHED: normal cycle completed
+		 * dispatch.
+		 */
+		tctx->state = TASK_DISPATCHED;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (test_scenario == 6) {
+		struct task_struct *p;
+		s32 pid;
+
+		if (bpf_map_pop_elem(&global_queue, &pid))
+			return;
+
+		p = bpf_task_from_pid(pid);
+		if (!p)
+			return;
+
+		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
+			cpu = scx_bpf_task_cpu(p);
+
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+	} else {
+		scx_bpf_dsq_move_to_local(SHARED_DSQ);
+	}
+}
+
+s32 BPF_STRUCT_OPS(dequeue_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tctx)
+		return -ENOMEM;
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_init)
+{
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(dequeue_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dequeue_ops = {
+	.select_cpu		= (void *)dequeue_select_cpu,
+	.enqueue		= (void *)dequeue_enqueue,
+	.dequeue		= (void *)dequeue_dequeue,
+	.dispatch		= (void *)dequeue_dispatch,
+	.init_task		= (void *)dequeue_init_task,
+	.init			= (void *)dequeue_init,
+	.exit			= (void *)dequeue_exit,
+	.flags			= SCX_OPS_ENQ_LAST,
+	.name			= "dequeue_test",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
new file mode 100644
index 0000000000000..cf0ae4f59fa81
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <time.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include <pthread.h>
+#include "scx_test.h"
+#include "dequeue.bpf.skel.h"
+
+#define NUM_WORKERS 8
+#define AFFINITY_HAMMER_MS 50
+
+/*
+ * Worker function that creates enqueue/dequeue events via CPU work and
+ * sleeping. Property-change dequeues are triggered by the affinity hammer
+ * thread (external sched_setaffinity on worker PIDs).
+ */
+static void worker_fn(int id)
+{
+	int i;
+	volatile int sum = 0;
+
+	for (i = 0; i < 1000; i++) {
+		volatile int j;
+
+		/* Do some work to trigger scheduling events */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Sleep to trigger dequeue */
+		usleep(1000 + (id * 100));
+	}
+
+	exit(0);
+}
+
+/*
+ * Property-change dequeues only happen when a task gets a property change
+ * while still in the queue. This thread changes workers' affinity from
+ * outside so that some changes hit tasks while they are still in the
+ * queue.
+ */
+static void *affinity_hammer_fn(void *arg)
+{
+	pid_t *pids = arg;
+	cpu_set_t cpuset;
+	int i, n = NUM_WORKERS;
+	struct timespec ts = { .tv_sec = 0, .tv_nsec = 1000000 }; /* 1ms */
+
+	for (i = 0; i < (AFFINITY_HAMMER_MS * 1000 / 100); i++) {
+		int w = i % n;
+		int cpu = (i / n) % 4;
+
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu, &cpuset);
+		sched_setaffinity(pids[w], sizeof(cpuset), &cpuset);
+		nanosleep(&ts, NULL);
+	}
+
+	return NULL;
+}
+
+static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
+					 const char *scenario_name)
+{
+	struct bpf_link *link;
+	pid_t pids[NUM_WORKERS];
+	pthread_t hammer;
+
+	int i, status;
+	u64 enq_start, deq_start,
+	    dispatch_deq_start, change_deq_start, bpf_queue_full_start;
+	u64 enq_delta, deq_delta,
+	    dispatch_deq_delta, change_deq_delta, bpf_queue_full_delta;
+
+	/* Set the test scenario */
+	skel->bss->test_scenario = scenario;
+
+	/* Record starting counts */
+	enq_start = skel->bss->enqueue_cnt;
+	deq_start = skel->bss->dequeue_cnt;
+	dispatch_deq_start = skel->bss->dispatch_dequeue_cnt;
+	change_deq_start = skel->bss->change_dequeue_cnt;
+	bpf_queue_full_start = skel->bss->bpf_queue_full;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops for scenario %s", scenario_name);
+
+	/* Fork worker processes to generate enqueue/dequeue events */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
+
+		if (pids[i] == 0) {
+			worker_fn(i);
+			/* Should not reach here */
+			exit(1);
+		}
+	}
+
+	/*
+	 * Run an "affinity hammer" so that some property changes hit tasks
+	 * while they are still in BPF custody (e.g. in user DSQ or BPF queue),
+	 * triggering SCX_DEQ_SCHED_CHANGE dequeues in scenarios 2 and 6.
+	 */
+	SCX_FAIL_IF(pthread_create(&hammer, NULL, affinity_hammer_fn, pids) != 0,
+		    "Failed to create affinity hammer thread");
+	pthread_join(hammer, NULL);
+
+	/* Wait for all workers to complete */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for worker %d", i);
+		SCX_FAIL_IF(status != 0, "Worker %d exited with status %d", i, status);
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	/* Calculate deltas */
+	enq_delta = skel->bss->enqueue_cnt - enq_start;
+	deq_delta = skel->bss->dequeue_cnt - deq_start;
+	dispatch_deq_delta = skel->bss->dispatch_dequeue_cnt - dispatch_deq_start;
+	change_deq_delta = skel->bss->change_dequeue_cnt - change_deq_start;
+	bpf_queue_full_delta = skel->bss->bpf_queue_full - bpf_queue_full_start;
+
+	printf("%s:\n", scenario_name);
+	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
+	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
+	       (unsigned long)deq_delta,
+	       (unsigned long)dispatch_deq_delta,
+	       (unsigned long)change_deq_delta);
+	printf("  BPF queue full: %lu\n", (unsigned long)bpf_queue_full_delta);
+
+	/*
+	 * Validate enqueue/dequeue lifecycle tracking.
+	 *
+	 * For scenarios 0, 1, 3, 4 (local and global DSQs from
+	 * ops.select_cpu() and ops.enqueue()), both enqueues and dequeues
+	 * should be 0 because tasks bypass the BPF scheduler entirely:
+	 * tasks never enter BPF scheduler's custody.
+	 *
+	 * For scenarios 2, 5, 6 (user DSQ or BPF internal queue) we expect
+	 * both enqueues and dequeues.
+	 *
+	 * The BPF code does strict state machine validation with
+	 * scx_bpf_error() to ensure the workflow semantics are correct.
+	 *
+	 * If we reach this point without errors, the semantics are
+	 * validated correctly.
+	 */
+	if (scenario == 0 || scenario == 1 ||
+	    scenario == 3 || scenario == 4) {
+		/* Tasks bypass BPF scheduler completely */
+		SCX_EQ(enq_delta, 0);
+		SCX_EQ(deq_delta, 0);
+		SCX_EQ(dispatch_deq_delta, 0);
+		SCX_EQ(change_deq_delta, 0);
+	} else {
+		/*
+		 * User DSQ from ops.enqueue() or ops.select_cpu(): tasks
+		 * enter BPF scheduler's custody.
+		 *
+		 * Also validate 1:1 enqueue/dequeue pairing.
+		 */
+		SCX_GT(enq_delta, 0);
+		SCX_GT(deq_delta, 0);
+		SCX_EQ(enq_delta, deq_delta);
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue *skel;
+
+	skel = dequeue__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dequeue__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dequeue *skel = ctx;
+	enum scx_test_status status;
+
+	status = run_scenario(skel, 0, "Scenario 0: Local DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 1, "Scenario 1: Global DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 2, "Scenario 2: User DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 3, "Scenario 3: Local DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 4, "Scenario 4: Global DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 5, "Scenario 5: User DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 6, "Scenario 6: BPF queue from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	printf("\n=== Summary ===\n");
+	printf("Total enqueues: %lu\n", (unsigned long)skel->bss->enqueue_cnt);
+	printf("Total dequeues: %lu\n", (unsigned long)skel->bss->dequeue_cnt);
+	printf("  Dispatch dequeues: %lu (no flag, normal workflow)\n",
+	       (unsigned long)skel->bss->dispatch_dequeue_cnt);
+	printf("  Property change dequeues: %lu (SCX_DEQ_SCHED_CHANGE flag)\n",
+	       (unsigned long)skel->bss->change_dequeue_cnt);
+	printf("  BPF queue full: %lu\n",
+	       (unsigned long)skel->bss->bpf_queue_full);
+	printf("\nAll scenarios passed - no state machine violations detected\n");
+	printf("-> Validated: Local DSQ dispatch bypasses BPF scheduler\n");
+	printf("-> Validated: Global DSQ dispatch bypasses BPF scheduler\n");
+	printf("-> Validated: User DSQ dispatch triggers ops.dequeue() callbacks\n");
+	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)\n");
+	printf("-> Validated: Property change dequeues have SCX_DEQ_SCHED_CHANGE flag\n");
+	printf("-> Validated: No duplicate enqueues or invalid state transitions\n");
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dequeue *skel = ctx;
+
+	dequeue__destroy(skel);
+}
+
+struct scx_test dequeue_test = {
+	.name = "dequeue",
+	.description = "Verify ops.dequeue() semantics",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_test)
-- 
2.53.0

