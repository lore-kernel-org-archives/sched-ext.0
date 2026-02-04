Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12942314B
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221247; cv=fail; b=pJ2Je3jff+2zF3Wm0Zp9EQLHT0Gzqd7eyLkqfXNQBIzSE1AU4sEIcKvRxC6/tE7b1Q3RYfp/gukErsxZw//Tj+XUr4ZSPR8MP3eppxDQasxSQN4t7OpbgecSwIMTzTcG/+ud20dsznreqbhxjH3gK2AtCU9j14rG7LkpZKH0I5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221247; c=relaxed/simple;
	bh=d+k6DTl53B/8ifZudzUd711eHTk0NQTDFhK3qx731p4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pyLDQmGCbQtma4kQczprMZEXezv01p5EXkOzK95+nHbzmKFa6lOQ+om5POapUtoOijqkII2N0TOkGup6KJ0hfLVcOSjCHWijYCr4/2ftRjpqiPnioTgt3bQ21KpKp5Ryhae0gC9PcVswv62l2b72ttikeO1vV9436R19rkeIoLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSnR06xF; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSnR06xF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nt2/0rQ5a5j5k6CrFA+EMgI1uI8Vug5Ti2g0OkJ3kqUGL5/sH0JyN/zCI3p2o2CcExwlOWxpXoOR3naqKsplKCWMBwUgVFk6fitmLd1bmdMRDMS68Yg2MpYFITIYnTjzu/h3E0MCWKlJcl7WSiBKJ0kkta5ElcWk750jAl1hwtr8Vn62zQgbH99+tvmlsvH2HTeJek7Kz+SG0XSSil74H41cJPAg6GqOznlqUh2Xll0PVHUADFt6zkcBw8YPyIXKFUJ1KJ8mhmu9+CVUU/28cy/qs9PVCWwNZex6wlbIPDNRik1gTh6uJUjnI0AD/W3swKEKNKPjXUlhRNpS3RNYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+9zG9jQFAu+EjY5R36YIROl68Haa/DKxnuVnr8Agms=;
 b=BY0RXjOGfNHgJ3pamvWI8RLw3pyJU3///u8XnbatUmVv+FO581AbtmiR8H8PQE5dv+yQ2ZTyXXsvwtgP5XYj5JZUUl3IS0KYWDCTx7V4G3LM58a/pwmc4DqFQrakDFfGGuvYmBm2qJDyIPc+KOEzd89TNq2GfN0ybeNyCN/nCLvis/8oQxOHlICBhovsz5EngsIiWuTzv0c72s5TeeOKLxK6iEuw1OQXGBd9a2ZH5wb0chJ2LXHxFB8uNo50RgjXZINPHrdIz/3GqHhaOtZjhs/uWKnN/qqVMWMW5CuPjzZxEABVwNjA73fctii4v9IFsNdRo3BPlXMcNJureEIUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+9zG9jQFAu+EjY5R36YIROl68Haa/DKxnuVnr8Agms=;
 b=TSnR06xFkdF5+TD4BKjglrTY0U7YWnQjIVZ+LdNMYgmlZZgK6rh+nlvmaY4mytvQyi5DTRAJz9c6uKVxnAAPw1nSy4WEZJQiZdlFU/ydCxFijqixdEWedh46jPoEURQQNXRt3B12ZCm7B+O2VbPRUOlcjYYSM0OwC94QzBMUSqxBikRJk5xRahLtcbk4JgSfVgkCQYCSBn9t2hoQfAwMlwCJBwZvlC3Z+9R+NhYRd/1TIVr593SL47NU6+H0G3zengTiKHRqiaZTy7KfT016U/i/5hcNLLwpCufwe/sOTR2gyeH8CBC5oSPFNo42FjtJVUCigFGNuxwxF3jWQ+ubHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 16:07:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 16:07:20 +0000
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
Subject: [PATCHSET v5] sched_ext: Fix ops.dequeue() semantics
Date: Wed,  4 Feb 2026 17:05:57 +0100
Message-ID: <20260204160710.1475802-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: f45d46b5-f410-4e83-51db-08de640779c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NnhCYYH3XYhLxSIkt5siBny2Lbu7pFxpBq32UNxvuYexz1EXZFPeKd2pFjsj?=
 =?us-ascii?Q?Kc9LPiBvBr+/rF4ZGKBTEqIdKTFMuyjqoilHsrwclffAv7tiQe3npCkLR0q/?=
 =?us-ascii?Q?VqUwtm1FdZGo3uT8diY8V1Wn1aicr/fyKC7yZ/CdlbzbQbXI/Yiv+ZTOhL4S?=
 =?us-ascii?Q?aeIib7C7ZC6pyyS4bj2TIMD27QCJh62QUqvLTjVuEt3wF0hE9zz/IOah7O4F?=
 =?us-ascii?Q?T91fTOgiQP4aIVUlL/pZ7zGkGpa2mqkKIpDjK5JueyManz+7m3FqDm/9fMqZ?=
 =?us-ascii?Q?zC6LYM7dZDGpBOlytkG9r860fA8h4qmnb8djaS+azXCTh+gBZFd5kIyEuS+r?=
 =?us-ascii?Q?koDdh8QkMIS3t1pVRgXAq+MviAR8hiIzAr/d+NEV39ikEmRvgzVl0Prttimq?=
 =?us-ascii?Q?Yik822rUfsC4s0HOWEdR6bm6/mFP1lRTmkaabSkwDin9vO4qeMwg0h88Vznr?=
 =?us-ascii?Q?NLcqIEwu8csjO14CAsCdVKGuDaSU00I1MFiw722ir/YE82knkPIsjAOHZKmK?=
 =?us-ascii?Q?Ellx/JQ/PGgLU2qXtsRGAq9WM5cj/KwtaHK+CdRlSd7hJCWPj40BBG2CWxGe?=
 =?us-ascii?Q?RjQz+nceTnwujAyjeJjc50/f9mHMSPNRFKLXV1MdizRfSqmtld3L4ezS43tI?=
 =?us-ascii?Q?fS/SolbVHO3GOF+Cr1rIjvN6REaya/igL891v8026VpeNPE4FbVpgkonQJkk?=
 =?us-ascii?Q?6/v+PFzEpdsfEhDDDVW7GmLPBJ1jY6OZBp1OCQzOgqAB/+8iBFLQ0A7FTP0V?=
 =?us-ascii?Q?FjkxyWNVMjU7aBTnNQmmkbW4kseFcL4lV6ALSJemp9uHWECMSlpUO/iUdCXq?=
 =?us-ascii?Q?lxGJOFPRpt/mdsHTNyXp0V/1of1DVDrD6M8VR2ZNabn9xXrDliYwMVQPa8CA?=
 =?us-ascii?Q?izNzUe94jZ1LQQb0nX6+nLp8COKmVp0KflA7Zo7YWCmr40EEb5bA/HzzN/Nm?=
 =?us-ascii?Q?/PpkNkHKaKXSbmb1Yu+hdzJyfS1WDXOnGL328FIBJD5M+8Pjtllq/hES6xJT?=
 =?us-ascii?Q?pyO+VD793c0e4drGZj7810P+priwMdPijv6sun6hdVmyoVPMnG4PeUFmzFAL?=
 =?us-ascii?Q?HhGoYowDkNBihoceETTkMhU/7LA3+1OKp6E3tN7wVwaEeNesGY6BIdnqE0rx?=
 =?us-ascii?Q?6bGMzLU6KHgl5uEfyzJvrkk2wLej8xTuFpeukLSjpOzmxVJp05/si1zYL3uI?=
 =?us-ascii?Q?aRDwlHOIj/110Ms3ZLng3SzjquKzxkS+FMz7RmdjvjFKcaIQmNmsXbZwCBpG?=
 =?us-ascii?Q?NNOvstDlyxK0d1OOCZODGnILEejdELCrBgv5T16OUeEBnpNTLzHOuInuFo53?=
 =?us-ascii?Q?DGfT/Q/tb+OqWiBr8dyhizE59yR4eHQDc/ezqlmpsXbIQEI5JNB+36qaSIQ0?=
 =?us-ascii?Q?kHMpoEgM+ZV8PVADC1weTw/5/CiL1NPIJ18VvbFWejj05H6NTstd8Xn5LidR?=
 =?us-ascii?Q?MJNPzWcCSJbnHwoth+D/Bi+vmyemjX4yoYRiqOrYloeRlJ4AppBTP6IhcF3e?=
 =?us-ascii?Q?uDLJhSPX60+/Cp81J6hpLs56CEdBO7ol89XBGtdjjRIy7xjvbk3wbZGI3tWX?=
 =?us-ascii?Q?JTD1+Cb1EI9wSyPuzZUvKXimROqC/211GqCuWIgE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qz7zU1JzE8UFPny6pSyNk5/V4kgIBegn+CvbrB0QE0Q0eBUoyIiBgsWXzurV?=
 =?us-ascii?Q?oKiVm11qTZ4FK567kS2+ABAAk9zn9YhLaZVvKLhqrV8rTZXY7s1P5cO72NEz?=
 =?us-ascii?Q?VCRlD1IKIdhpz9raXR8MGBMGc5VoqcJaK81XPk5atXkZRv/mPhG2AVpomo+I?=
 =?us-ascii?Q?vjussOUk2Fg9ytkIh3NOhplaWUqAepoNoD6tioDwFh7Uw3EgvJio+SypiGZX?=
 =?us-ascii?Q?SOwPowOjbgT+aJlDpGjOF5zBwxN5km+WFFwGxSp/jsZs8lGwA4W+USjMqXuB?=
 =?us-ascii?Q?4fC/VHIuD5zE+Gz95jaAgZXGiWg6AwI28GdNGgNt9fyuUnilobldOv36EBxi?=
 =?us-ascii?Q?8zQDzNb8SVZwHKPtNurz8cE8ZSHh+fFTpXYlPLbtUGAmozR8yFcscT2cobu2?=
 =?us-ascii?Q?mYm1YXRRcqi58la7O0X/OFXDikqxdCAUx9PHPlfv+jj5nxF/vk+EgX+m3tlr?=
 =?us-ascii?Q?q1yFualxOi7za2HDcPCo7/dnimj1JagrXP8bwcyvkQv7j9lHb8NUXkEGhU9Y?=
 =?us-ascii?Q?mme/NZnBKshp7jsYdIsgiDol5myjKE//eQkkSTV+5Ry8ukr/Sj6laJ8RTild?=
 =?us-ascii?Q?QSunxRGF7wNMY3nRfMBSzq1pNmCLcYgNf0NoCV23G03Jp62bYyINBTxM3z0q?=
 =?us-ascii?Q?DzC1jGUQ9YPvDJOmMDCmje5aQDPSRSJaM9qzZcbH/wVWJSCd0yK09Oz4ubqN?=
 =?us-ascii?Q?DqdJ0+dYVRDuHN7wPoNhNJPuwcwQlLOB2AMqaBJBRqoUZYXFQ7OdTVBg9gGl?=
 =?us-ascii?Q?w2hdKEH9iroqriuq7lGrKNdDs5+f58qXhi9f51ezVy2TMySMhErSIKZTqmBR?=
 =?us-ascii?Q?fmngaoLwfGsoyGha9gCugFjZ/xPeqIG7Uy/t7U0N+ttA9XraZlSYAyCBSzRP?=
 =?us-ascii?Q?LuWpOYbZpyfWXxhiFQBWTEtnxt+axWm/4w8vGrVSrQN8kt0LAt8zRJV7zUQ1?=
 =?us-ascii?Q?+iCQogf7bnOBcxNr8I1MLlVlf1ab//hFEU5p3RumR/ngl6YtMDbpHVyi/s3E?=
 =?us-ascii?Q?NlNA2mAN2gQrSJSetFZ9ZAceUQum2ZgPGDUjONFrb+WxYS3OLK08xmKA6f+W?=
 =?us-ascii?Q?By1KFserKXKx/eJ0PDwPsI/nxjZP20E0lOp+YeQ9sfHsAO2Sd39gmPRSnKhR?=
 =?us-ascii?Q?LfLDhpVP4kBfgFbkHABxpIHLDzwG2OAF/mHKW+5sluZPTFEgTKNMxvSmBTZt?=
 =?us-ascii?Q?H7uzsgJZlLirrXNnokC7CLO7xPYRqDfMuW7WB8Z9Bh73EUCb3Gy+9bPpb+WL?=
 =?us-ascii?Q?3YKIk7h7s8p4l3QCDzoqMtwEVksbeGb4Ox18seLUx6EVKsBYudscRc77xhHF?=
 =?us-ascii?Q?KsjUJyZCnBynoRlogS6Buc0Lo3/hxV4T0mh33MNF+dfcSO4A1SJOs431mHpv?=
 =?us-ascii?Q?EUYYEqF2Ur3r6FbWxxL7Tm2B68yJzY9/dXw65jJz/NISdZVtRQ65GHiG3Ydf?=
 =?us-ascii?Q?P2q4wXYEWYq6QEHdUBevIaH43XDnX4aDy1I++Sq/lHEwzFh8CcN34sBEP8Ge?=
 =?us-ascii?Q?os8tsbZBmades//Kf4uoZHvNgvGOU0MPFR+Ut4frgw6LxMKhVt/CwW0dZ8Z1?=
 =?us-ascii?Q?2nGxhN2/6+ZO2dUI3UM9IIgE10acr40xTzqG+NERUH7oAJ/kn5kQLFX387kY?=
 =?us-ascii?Q?qdx8JDoVwKCcfVxtCEap0zuKt02hSvZ7FcbdktT2nMAjF1ViQT+hs/F7ESIz?=
 =?us-ascii?Q?BX/JZujaP6HuLAG6d1djTlQSkwcFApGNUbw9MID6mmVTqwYt1fjMpLHYCE3h?=
 =?us-ascii?Q?tIqFsxUpdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45d46b5-f410-4e83-51db-08de640779c8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 16:07:20.5683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLsBx4M0bp6zatPNEEbFLSaFh7nvcvQte1RQd8G0f/v7Ir6XS7lSQMZZXsJ3nr2Kjhv8AWqlhY/IY62d7pU59Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

The callback ops.dequeue() is provided to let BPF schedulers observe when a
task leaves the scheduler, either because it is dispatched or due to a task
property change. However, this callback is currently unreliable and not
invoked systematically, which can result in missed ops.dequeue() events.

In particular, once a task is removed from the scheduler (whether for
dispatch or due to a property change) the BPF scheduler loses visibility of
the task and the sched_ext core may not always trigger ops.dequeue().

This breaks accurate accounting (i.e., per-DSQ queued runtime sums) and
prevents reliable tracking of task lifecycle transitions.

This patch set fixes the semantics of ops.dequeue(), by guaranteeing that
each task entering the BPF scheduler's custody triggers exactly one
ops.dequeue() call when it leaves that custody, whether the exit is due to
a dispatch (regular or via a core scheduling pick) or to a scheduling
property change (e.g.  sched_setaffinity(), sched_setscheduler(),
set_user_nice(), NUMA balancing, etc.).

To identify property change dequeues a new ops.dequeue() flag is
introduced: %SCX_DEQ_SCHED_CHANGE.

Together, these changes allow BPF schedulers to reliably track task
ownership and maintain accurate accounting.

Changes in v5:
 - Introduce the concept of "terminal DSQ" (when a task is dispatched to a
   terminal DSQ, the task leaves the BPF scheduler's custody)
 - Consider SCX_DSQ_GLOBAL as a terminal DSQ
 - Link to v4: https://lore.kernel.org/all/20260201091318.178710-1-arighi@nvidia.com

Changes in v4:
 - Introduce the concept of "BPF scheduler custody"
 - Do not trigger ops.dequeue() for direct dispatches to local DSQs
 - Trigger ops.dequeue() only once; after the task leaves BPF scheduler
   custody, further dequeue events are not reported.
 - Link to v3: https://lore.kernel.org/all/20260126084258.3798129-1-arighi@nvidia.com

Changes in v3:
 - Rename SCX_DEQ_ASYNC to SCX_DEQ_SCHED_CHANGE
 - Handle core-sched dequeues (Kuba)
 - Link to v2: https://lore.kernel.org/all/20260121123118.964704-1-arighi@nvidia.com

Changes in v2:
 - Distinguish between "dispatch" dequeues and "property change" dequeues
   (flag SCX_DEQ_ASYNC)
 - Link to v1: https://lore.kernel.org/all/20251219224450.2537941-1-arighi@nvidia.com

Andrea Righi (2):
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics

 Documentation/scheduler/sched-ext.rst           |  74 +++++++
 include/linux/sched/ext.h                       |   1 +
 kernel/sched/ext.c                              | 186 +++++++++++++++-
 kernel/sched/ext_internal.h                     |   7 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 269 ++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 207 ++++++++++++++++++
 10 files changed, 746 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
