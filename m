Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592730AD05
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412757; cv=fail; b=Flg9RKhqcxzqbffp9tSGIDPh1UrigzLs6RligOMp+0oyiaUZiBwCb7V/mM5MjKW8skFXtL7ulblFrFi03X37cUPt0ktMzgqXdXwealvE8IG+Goy5SwtHymyAV/PMk6HcY8dQPLgmnf3SY6it3ocmKJ7ovAddX/9pb5Qxe/uZRv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412757; c=relaxed/simple;
	bh=68hJ/b+NhWQjdb5v0qImkrmsLJlbac1YWp0q2rM/Rnw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cuACMXuAikYjCs9Y00odkvYFkj6cpMI6bRTfv/GsH2b4hLukDMJkAmEoCgkrujhHWAS5d6nG03wfi4kTXVsxLVV+0wYXt13niSLXCEuh4bURphG6wB/xANveVJIYoamKGC9HDsIqzJDfbxQPpQ9O0FhGmS9AdEdPszyPfxloCKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L3g/+XGb; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L3g/+XGb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LElPQ6qV7N+mPaxXiiH2bCWsLcOEYpr5pvG+6ufRjysrrsZuULzod3phlV6rJGsEChrg5uWyRfQHF3MkxKCA0C4nFleYbaj1mfBuJxWcEbAgO2AOWNBXHPQGQq7SyzEnsHdoVUaymDiMCn8W2ecl6M3+9VvfpJW5qLgUuHECuZxNj4iIjsJyP03EB6N+fcGnvpGVshbiljTr90KFTR8dntVJBeYpT3FSz9/tNRy9638GYah0ZGFkUatOXMaftWxAaDV6nAcJ+eep34T7WM1ob5f+d1WsCtq0iIgtY8h60vDBdPMr3Gv1XdduyuEE87nmxTPDmyOIObzHZRKAF6rgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRA5DxkyGozXCqgsR4og8Ujqi9rrMbZMi0snQjRZ/yA=;
 b=HitA6+VeNI+s7jwBoIJEuR9Gyv0KVka/9v8bk62iWRscOzg3zfNWi7aXtfcwKrQ77ocqli0zJhg+lrMdD9G8Aciwm/cx0Pbz4MZua24jBrJvJndJ4MtrUQwsXCb/8DHNtaMvclYtZzR83ODGgOQEYTbdTC878ZqJPF/a9uPOKtedFwK1aHcNaHlQdCWNFyV4fTR8IDeJOrgBMayymYxKoRRtQyy5aME2Oph0qSTEFbtqHaPZ5TIrO7d/RtxpTfgMSyk5SsBQAIpx5KzZJbXf9bKHGNYcO8AEuIbRy+IcQPYhxLYW8f2gUgiColUUXleHDJf202ZXt/eQpD0iurp7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRA5DxkyGozXCqgsR4og8Ujqi9rrMbZMi0snQjRZ/yA=;
 b=L3g/+XGbTTB72yZbuXyxsGqhu4f2IKTXyqQ+zAXF5PeFOtYIEwiSkWBkwqBErQZGkFC6B7yE5ceKvi8YPhA58rzGxBRng2UK4yvExGViVG2u3JxYty6QhWvNb3F6OzPdc3t2j8CJzPqu5eJVNP4YVuI5yVn8anZv/FmVrQRO8m1417u4Y7MgpDu0f5NAfLTIEJSoFJFsHYsImfeLC8jBe9juLtgKKV7EmHQjXqQ8Y2k8ZeieafqVJCdL2pyck0lgoB8u2vbhrKcj/ro9iuAhFWguXayAhZVVaT1jPFMebR9elMzfmdkcsdDS0ic3+o2D29rnQ662qXPAXlOiQ7qb8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 08:25:52 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:25:51 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-7.2-fixes] sched_ext: Fix finite-slice ticks on nohz_full
Date: Tue,  7 Jul 2026 10:17:58 +0200
Message-ID: <20260707082537.918068-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008C1.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::437) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 999d315e-37c1-4467-ead5-08dedc015b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+ZccCfLNIbw6pa76C0+pnBD0oaBB05zrRMwwZ3JEwffOsHCwbUPd/3EmKKapsgb3uBb8AuGSrOKK8dXudvaCPVc1LiQs0vvn6sfemZICfMwS5DC0y5rQwpq0LDCSuZGy23wxE0+BEYxXc4ZsqdHrHxwOMfSc02b4KMt8sB1n9n8CnQzCVqa8fj79rPv4tcn3+NGo78oosg660mQO7My9Q2umLBFQVKbWYvV9wPSYtf6r/oB6yAmW/NCeBVsmO5edhryTWp8afULz0RV7kyXkztzzqFEB3JVl+q9S/G9a4A975QmhFye9Q5wSnVZg503eERPg3HssTsUh/JFDMlPB+n9D2HklK8RBoAxq0x+JUlxmtoAy86mrCfpZg2+JDBgMVj4hn7Dso1atVlRDSctx1gDtvH3yMXcs51c97Oohiho3LFn6BSv4I9t2cHhNde8jD6SKVoaHOYCggY61mVYh+1c1fl+vkJi6yneIezEU1lo063k3jn4yPpcJs/JAUP5d+p+SdEuItYmU43c2SvUMrXWzxp8P+j7zS5DOSfKT7C5dAJ2pFAzW7MKCuBaf7J8ciJU5x1ketjOhmNrpMJmXpbQPPFiQEk6sZwuGGbThxb2G3CpeRFE7bWxyW9ueTVuu1wYPcRVuk0Q4UqSgwW4w4k3dg8tf/KjE+mlnT6IPU8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pvdJY6qIhduwVvxWWL3iQJT4v3TLAZfJ8Y0DMESj2WE3w6skgnnjTWv7k/n9?=
 =?us-ascii?Q?baqWVRcUHFPuXKrQhAEB4HtWD9OvhxOK3GroRluM45uoltrHxeu/N7j3H2dC?=
 =?us-ascii?Q?BmbbSuZGg2s1JpMmsfGhLoGYGoDuWN6oc0ggS7dhCwhWWK4x++uYu8sU/qGn?=
 =?us-ascii?Q?HqiLOPmrI70FY3o7jz3BowP1Ns82QcQrG5tEtsJBfdrUkD+/ES364psvbqLw?=
 =?us-ascii?Q?YQ/22+bX/nLJvKaID6HmqOvaTiLyG/Vxm60/pgBxAAbn4B+/DAA5Fami+9km?=
 =?us-ascii?Q?daqzWHUujiDUqtyfotNH4K+WKM4zlR2hd7Zemlgx1h+WSICTFW/t8PjZ8MMB?=
 =?us-ascii?Q?pXiuWKiB/JRl9LJ+58h7vP4zFiC5TxInfImqD6wmacUqf60ukysCcjTbyBkk?=
 =?us-ascii?Q?IvtfA0VbZWR+F2mQLJMW41cdfMKUSRYiStRWQUiH6jj9YOPVE9ATs4sGeGqx?=
 =?us-ascii?Q?Umd8ac1j6M2xjhVOEWX1Jx+e6NYmKDyEV03c1cM1SXpvholomwxjD4e29lxf?=
 =?us-ascii?Q?xbVriyHKUfpQ0Pxfowc58yYtyczAGlkUXWHTa8hcGq3jNGaY9vvGcAtLRBCC?=
 =?us-ascii?Q?TLF9dhRQaZrOtXooh7YEsvZ1HcWLBnhL2vE3Td+ziz6n/fga8YZBki4DfiK0?=
 =?us-ascii?Q?wIvOcfpZWjypc3ROflLjKpRGUZFfkx/r1JMSpBgAQ5AlNbfVzLQ1fPU3DxWe?=
 =?us-ascii?Q?78xekFGo98sS44xY44SffUZKmdh5CqYbzjGZrI5bxwfo16wY5JuJGBfG8G2H?=
 =?us-ascii?Q?T1jIZR3eLUAm+iOrXNQBFR/TiIjjZderbrNEboxzdmD9kIQTTmJssrcLcVY5?=
 =?us-ascii?Q?iD3/y/zwDuaGfg5abDSficLHYzGneVF12RFB7lgoW4SOSSNqYrX0MGZSzSZe?=
 =?us-ascii?Q?zlgfAqUUQ8zAF96YzK3QpYRunx1efaVSqp6vmCSnHQYfIXct6kP8HWFyD8QU?=
 =?us-ascii?Q?36Kh8aOSUz2XFY9dgtHmVhHGXZ6SSrmI1Q0YtR3oY0xaFIKS2wJNoipn4ojT?=
 =?us-ascii?Q?QJB0qlY9hw+NVnWlC4y0aYvZTPIq8q8C7FLl0G3cEzGExH/M6ipDf3xl6OzW?=
 =?us-ascii?Q?2IOdmbVa8rF9UjUrQjFIBqb4ZUg5fBBytxv4lJfFFHeyQSxAjN0mGzFuZLHG?=
 =?us-ascii?Q?faMxcl+xgqX/zGPhcO+k/dNSvTUztknD6yPZhVaKlOSnYrHgGRNRJ4PEt1pE?=
 =?us-ascii?Q?y5Lt1AmYM9s2IEJrdeJaxGP1PLbS0HOniOv+dz27teBC2l3miTOqzeWRLlCv?=
 =?us-ascii?Q?3QDpDRyvm/zXy7F9sXeE0gsfZu9ME7n2ohK2TBvZxxibDPXzgb4DqDi109Lz?=
 =?us-ascii?Q?eaSlHwMMD9fiP4lJ+emwAYtxoOr9RMYDPw96oPrwHHheCwHdXInBnAFG0J4K?=
 =?us-ascii?Q?JmiMZBLNTELoIY642KQMC1LCN4BshOBB700DhJjWU2GTqj/ac1uod7Kg5b2m?=
 =?us-ascii?Q?x+cakR/2ISafmyCF12WuIDcTk7qJ997MplgfGOKQcLyGpsWQeB0sw398i82p?=
 =?us-ascii?Q?+vTCkO4W6Z1+F7zv5L0u7zQM16VOrhmGHSYRFd3cn7vGi3z6y20OD2rLBmJR?=
 =?us-ascii?Q?7JEK0MV2Kyze7RLSacVES7uNAL86osPWgxx8Q+htdd1tOeD9/9pl1787xaPF?=
 =?us-ascii?Q?lkfCXcV1jquxmf1906qFvj71V2LLyrkfWGPFltPFazxGjU4sk3mi3z1uqevv?=
 =?us-ascii?Q?bh4wqjf0BoGVohZp2/MrkRa4LbM8JRzz43Aqrl3wqkqgOOuxUOe7QmcAljNX?=
 =?us-ascii?Q?D2QAPsh2PA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999d315e-37c1-4467-ead5-08dedc015b26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:25:51.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Czfp6wKAKYNMrckiFI12OVd+UU0q17bkzWH8rNUsXdaySO8wxAmpNyw4vpxzoZ7gffWhVpg0yi3wtUyOAot5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841

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
  ERR: nohz_tick.c:277
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

Changes in v2:
 - Reassert the tick dependency for every selected finite-slice EXT task, fixing
   the finite-to-idle-to-finite case and extend the selftest to cover it
   (Tejun, sashiko AI)
 - Ignore stale outgoing EXT slice state when no EXT tasks are accounted on the
   runqueue (sashiko AI).
 - Clarify that the infinite-slice bypass scenario is unreachable because bypass
   mode always assigns finite slices (sashiko AI).
 - Kill test workers automatically if their parent exits unexpectedly in the
   selfetst (sashiko AI)
 - Link to v1: https://lore.kernel.org/all/20260706162819.650155-1-arighi@nvidia.com/

Andrea Righi (2):
      sched_ext: Enable tick for finite slices on nohz_full
      selftests/sched_ext: Verify nohz_full tick behavior

 kernel/sched/ext/ext.c                            |  31 +-
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c |  65 ++++
 tools/testing/selftests/sched_ext/nohz_tick.c     | 347 ++++++++++++++++++++++
 4 files changed, 440 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick.c
