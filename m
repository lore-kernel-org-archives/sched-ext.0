Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A649379C23
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496916; cv=fail; b=qOHhzKABaf5puKte3sBJe2Rw8Q9ZLgKnC675lHkLlHhQeqxIEb/7ay0cKWp8CjPgrHkGHILLxHWoUDT1vjCClyC/o8IbzC+terlnDq7aflQlYSc9NHxsUankfBd2fnoSi/T6q82Nf0gnzO4V/WswctQYhti9IdDEj0Jim0JAiPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496916; c=relaxed/simple;
	bh=gl9ZIuzMBO4e4GWGajeI2VoVUzg6mKrrlHPA13ylSk8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VXf3sRMTm1szAwx/v4PMeVhrr4pjxzxRG4ioik1ei1+8aV5eVCjNm/xyzPsbJZ26rCpYkEykPqZjMVXglad7IlopV4EpMSjtWSbv+NflVdCi9trMLiYpZXG/eakRvRcNOUopjkKuEJwJb2j2ZC99oMTHm2KPekoMFyhboGJX9t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e2OF3QcJ; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e2OF3QcJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODtq69hL1VnITjxAQN5TTkloyLQ3FNqjeS95e+/fmQZdE8XPznVXWV8kgr1saPEPYsoYhzv6MQrSjJ1bQFXpk3GinAlo8S1vMr6EsG2Z5y6yH0BE7fNPu/o3RxG95l3NPM0BT4kEAtc0AYRfClmxUtL1Lu1WvZJvTADDLtogGWc8c/5oZP/fXerA3FkE3bvWHF1l0s2+meAEfITuZPFgfnyiVZZfeB/OkEM7Hlx0hH1hjz5zPjUY/G07l/0VZZd2vfj/p9T3SlS0EDofWF2IHqyqCoC28rpBrTWOFkf9eebBkmIjf0sVLJpGpxn2u+emZjGqt//Dv7oMWuKd4yOJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+CkwvEFXusaNof10HC/p38sS7stPJ3Q7aOZwGoBC28=;
 b=U7tnoMIjDIVwZZK0mMc+EdA8G+ERGjLlC4ZKmtp5xg1wcUND0PAkQCft+HuvO1wd02hne0ooHnS5i8SHU5AMxj71XMQrlYM4nqEI29e+uPJijDJRUjLzcRAMcKZehrdQk1SB7IFMPlDYTWcqgOksGn7N9oWrFTnsB10h+8upajL/PWxHwktdWKZCa0bfBzPu6lBd1VZI2nmhjdVBkDyeJrEvYBD2kSqkj44P8sVzoPKYYhWMqxGCIVCMtyDvEPNVkOxGGURHDqTeSl07BahQ3nLwdcrQOGGLuouNkSIaAO8QVQbItSjQKN44+wPS9s6342nS16+71BJ/z+0Z1mbSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+CkwvEFXusaNof10HC/p38sS7stPJ3Q7aOZwGoBC28=;
 b=e2OF3QcJOBX3H773Mw1INoZWFtBxx4SjVso/GoReqQmxAwYcsthyqZ72C4DUg3V7FYJTtEq7b1ksKZAvlLtXR3nzpkUuga+1nx3pReDiUrFkbnvnJV8HAYHx8bFthdGWfb/KPFuPGYNvAjOD7cLI04r+Mr0ZAhKFhx35HOhwuzx7jXO6ZzXzTLUdypAEXPVv3vACm5PjFdgYk280GK1m6Gw5Nk+Y7t097um0gDbVEFE8+yUlhiVLxNaIYHoqLMjBQOEEx/xm5Or25MSZg1v3juGV4EDYHRYggwT8h/ok8jjThX+vbfztTCEA8ev8KKmGqVxbdCMpFqUCGYm8TVhoqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:48:21 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:48:21 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 sched_ext/for-7.2-fixes] sched_ext: Fix finite-slice ticks on nohz_full
Date: Wed,  8 Jul 2026 09:46:47 +0200
Message-ID: <20260708074812.1041434-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B77.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40b) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2b4faa-9601-4c91-f60a-08dedcc5485d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jzpg3nn30Io79MvN0CabIsRmBW9OAZTew/cKqlAaPuhHBJgsO1ixPG/TK3g0TdVvI7baqmUuT0QCpOY6wVDs7uPHVNwZflYwHIyAGcmYFKJZt5u2UK4BpUX3ZU1ixENDQWXN0t3OIImgGMYmZ8az+faI/0OM0dfNIklTImSTdC7w/gLCX/hAvZOadbqcjlCVyjbknxKPdeVJ+0y2FwDPcVCn9sYAl+Z/g0knV7FTbe1t5+DpsEz9RmABPGsJ6P4WxmozxrTllC7Wpxm7YKvesh/8pc1rW2RdxTqUKs/Dz9TvFImpkscm9VeTy+ma3e39dIAkXsh5SImX3k9aCTs4917+epD+NC0pzAlLNWqtEKhQSV0LIk73ARsViSaU6ac/md3i3F4Ssns+OP11NrB381jUW0K6JgSIYJvLqnJleIDMMMxyIdznQ3+ZngMQVjjOt+n/+wvj1foW452cbdR+YB/+YBfkwDgtco4OJ9Hc9e4Cxi/B8jhN6fbcGcNTVEnLE2i4AkQITGHH3fXQ4EYvBKOfCCbhWTzGNTJZKXqMsnL2EsrA0R/BCzU2fJ+bH4oQyurSAvJ2ZBmHMmhzWo9pQdesI/WXcdOTQnkV9ySq3z9Y7bMPLX16Xa6/lHmsrHEPceouo4uvz0g8CI2GndJXMQkeynofSFdtszPnN1+yz9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yW0mSJXchGGn6hWVqsdLSVH56Kq2Hd6lj5UVtZ1PNR5NOwhmeyBkgwxrEMVa?=
 =?us-ascii?Q?LigM/8Uu4VqNQqoUGAPGsJzxak4MeAczQZN8tg4dd8X+CZRQLjWARTB1LNWS?=
 =?us-ascii?Q?lW+fXaYNxXeJvPU52lC3vvYiLoSrDkKIBnJQcT1GmrinCtih4c0Y7iDb9KM+?=
 =?us-ascii?Q?D0JWph1YhbLfWWe7rAVSbOsrspp3kVI7qBGruLosXFh607XomEIPcS5cLdBJ?=
 =?us-ascii?Q?bVNFQOISsuL5GnISlFLyEN7eY+k+K2TW2x1XO2FOOPdB2uAp449FUCJ0IvAi?=
 =?us-ascii?Q?8gbzoILuNz5NA9hfXFWXPOOtNTFfg0DH+34EfHuzPo91v+kWSGoIpqbVmiLU?=
 =?us-ascii?Q?8H43a0yUlrYFt4cu+R90mxPvZj1ZJUXo3oRF67MQQn8JUEZJA2RfYHbWCm3E?=
 =?us-ascii?Q?qZ9LyYi3T902TkO+nlSM2k+ThBFg9++qlJPOPj2TUYbzPgNeqYbRG5COK2h2?=
 =?us-ascii?Q?ASDk8w410Mq89B+6N5X6vxIL/N5gWvf1pL1RuXwTO+ho5vl8JvSS4czAJBEY?=
 =?us-ascii?Q?8IbuzH0PWJLwpjpQRycMxHk+S0kgAjF486iLNqvCirb1Dt/PvKUfWfldg1AZ?=
 =?us-ascii?Q?afsMB9RKUSSpWVQnA0gAXRewogFWr92zPDd4PFX9779Q3eF0zyv1Z6wUE2jz?=
 =?us-ascii?Q?t6aMzF5T3MyHBf4xvLXfOXwhNKIOj0of8AaNQErMujhmvFohncCqBV+rQhaS?=
 =?us-ascii?Q?PiP4hAR0qgWS2BCR84S+y8GmEmMWt9GIEsYGmJRKyOfAhd69GV0whkEC/J22?=
 =?us-ascii?Q?MuMpcNrMZ4syEFee3SRZXizWV/aKAUY/CNZiTiXNtlqoo0Sn2OlJlRN1GU5Z?=
 =?us-ascii?Q?JqwkW4nN48flU9ne1hXCHvdaK4LT6DwTF/u1gE1mZJK9vdU0qNts2UjXLPbI?=
 =?us-ascii?Q?Cm0sAxfZNXQ6u7lJ8AJ7LAcv0eA8KBg24QtcK+sh1qcFkgZVt7U7LZuuCHHM?=
 =?us-ascii?Q?Cb9e3+HKke+v8wWTWJRV+aT9pZ+tbGG5izym7UzWSr6JXWTXKmQXQCOQoA6y?=
 =?us-ascii?Q?+SbZFaN/qYbKxLo/rr8KmPiqll/1JJzzT0sbF8EU8LeKgIjSCcyFn6980dPp?=
 =?us-ascii?Q?RlxG0sWb7j3ivel/Zc29moJcxalOTQAbTPzWQ5r4yEvWGx/gna8mhs4+F8sn?=
 =?us-ascii?Q?wZU/4TuKuKmufQEhFdHwPDDhZQY9SgWvky/4yTCUd8MD9YIezCaVRyk09ub3?=
 =?us-ascii?Q?HT/lzWvHSzxLyMXFMRJ3ZvjxMvflrm3TcgFfXBnlX7ztNcQ+ELRWpHQ8hmyf?=
 =?us-ascii?Q?6Cs+UmyTTCuTWeSvO6KxyBylMuBhywoGE6cgow+AlvdtVO1zqdjBcFdZIhIO?=
 =?us-ascii?Q?S714TYoxL/IdBr0D8yhST6UB+5tNIKrlp7b2GDxvgNasy76VKP7EWoYpbkey?=
 =?us-ascii?Q?QpTO5DtpDXQi6r0vUXk57XyYhoQw3s6z/g+iSB9gZ5fnsNC0UhAwzU52GGPI?=
 =?us-ascii?Q?diCZQqUT0favKzIJj7Esajry13ERjwQIjxkcPOwh8Vd6MCeqUSwc25FYUaYy?=
 =?us-ascii?Q?xgEj91qOUUUqa5bXBOr+77RvYZ9YzcLsZ/5JHEKMZ94L0xgPLFhUnxr2IxBL?=
 =?us-ascii?Q?j28549AEGnasi3wAuRVJzv4XD/v4B5rn6bkKn9Uc1QsLNXmRw37qMluVf3zS?=
 =?us-ascii?Q?/A8piM2Ui4yQpWbvUSGjaRvdq+j66Vs508IwsGobnFYHP/zbKEfFjZckcv9U?=
 =?us-ascii?Q?jFOwS/30ZFfKjFAHBnnbOgIdijC/ySmBjOzO1wRYEYsJSN4CUc3kD+VZXl2D?=
 =?us-ascii?Q?ArElV6/wDw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2b4faa-9601-4c91-f60a-08dedcc5485d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:48:21.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTpL1jYlhmsYTy9QcL5ZOb9qdisGksU9iX54MJqTOFwQVGJl6OjkaI8Yz1CtNR6PUfaC6t86yAx2xJ2PgHO/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070

The scheduler tick dependency for EXT tasks can become stale across context
switches on nohz_full CPUs. An incoming finite-slice task may incorrectly keep
the tick disabled because the scheduler still observes the outgoing task. The
same can happen after an idle interval when the previous EXT task also had a
finite slice. Likewise, when the last finite-slice EXT task is dequeued, its
outgoing state can incorrectly keep the tick enabled after the CPU goes idle.

Fix this by directly asserting the scheduler tick dependency whenever a
finite-slice EXT task is selected and by ignoring the outgoing EXT slice state
when no EXT tasks are accounted on the runqueue.

Moreover, provide a kselftest that exercises both infinite-to-finite and
finite-to-finite transitions across an idle interval and verifies that scheduler
ticks are delivered correctly. The test is skipped when an allowed nohz_full CPU
and a separate housekeeping CPU are not available.

Test case (using virtme-ng):

  $ vng -vb --config tools/testing/selftests/sched_ext/config \
        --configitem CONFIG_NO_HZ_FULL=y
  $ vng --append "nohz_full=all" -- \
        tools/testing/selftests/sched_ext/runner -t nohz_tick

Before:

  $ vng --append "nohz_full=all" -- tools/testing/selftests/sched_ext/runner -t nohz_tick
  ===== START =====
  TEST: nohz_tick
  DESCRIPTION: Verify finite EXT slices restart the NOHZ_FULL tick
  OUTPUT:
  ERR: nohz_tick.c:270
  Finite-slice worker received only 1 scheduler ticks
  not ok 1 nohz_tick #
  =====  END  =====


  =============================

  RESULTS:

  PASSED:  0
  SKIPPED: 0
  FAILED:  1

  Failed tests:
    - nohz_tick

After:

  $ vng --append "nohz_full=all" -- tools/testing/selftests/sched_ext/runner -t nohz_tick
  ===== START =====
  TEST: nohz_tick
  DESCRIPTION: Verify finite EXT slices restart the NOHZ_FULL tick
  OUTPUT:
  CPU 1 received 6 finite-slice ticks
  ok 1 nohz_tick #
  =====  END  =====


  =============================

  RESULTS:

  PASSED:  1
  SKIPPED: 0
  FAILED:  0

Changes in v3:
 - Split the infinite/finite-slice paths so that the slice type is tested only
   once (Tejun)
 - Adjust/rephrase code comments
 - Link to v2: https://lore.kernel.org/all/20260707082537.918068-1-arighi@nvidia.com/

Changes in v2:
 - Reassert the tick dependency for every selected finite-slice EXT task,
   fixing the finite-to-idle-to-finite case and extend the selftest to cover it
   (Tejun, sashiko AI)
 - Ignore stale outgoing EXT slice state when no EXT tasks are accounted on
   the runqueue (sashiko AI).
 - Clarify that the infinite-slice bypass scenario is unreachable because bypass
   mode always assigns finite slices (sashiko AI).
 - Kill test workers automatically if their parent exits unexpectedly in the
   selfetst (sashiko AI)
 - Link to v1: https://lore.kernel.org/all/20260706162819.650155-1-arighi@nvidia.com/

Andrea Righi (2):
      sched_ext: Enable tick for finite slices on nohz_full
      selftests/sched_ext: Verify nohz_full tick behavior

 kernel/sched/ext/ext.c                            |  47 ++-
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c |  65 ++++
 tools/testing/selftests/sched_ext/nohz_tick.c     | 347 ++++++++++++++++++++++
 4 files changed, 448 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick.c
