Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD341684B
	for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375820; cv=fail; b=KpQE+qmSV0lhgAeW4nc6SQ8FOnldy33+4MFBJAILEyDxKu3HngzdWbbp5zhEm7JZ71rsHi0ZXyQxC7w/vdaLQjNUYBy5VJhjH3kgAPipKhT4Pp6HC10HvxME1ppVq9/yxJG/jTAUNSnSj62aeSKJwN5dSOyk8rvBrKtAB7DKaTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375820; c=relaxed/simple;
	bh=dezCchqhzhQhzN+flx8TmY6Txfdk2BKb2BrmSu/MZic=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lLLx/M5zDiqobCOtsjYL3EJfjB1qxdPZyXDlO6Sw8insYg1pSWp1fyrYRvhci5WrzaFPgzl+N4l4p4exBuZYh2mgWWqe7Lg/ymmMZHBa6EHRNyOrrdvsgNw6vy88w/CChLUS37O1leBZvNLfwx92XTlyCFtFAVo8u2XKqg150pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TRyqArHV; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TRyqArHV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwnf1y+/t+9yk8NAVdXeHhUWRWHHi/3biLxUisoD5sM1UJUpAIfgLcE/TzgfEOWAMsTrYMPqyXQk7Q+cdTOEVPzVDnBp1gp63hCmpBRKfiYMij0EUqmOQsGZwkKWxQRttSwBEnzA7cKy841A9yV2bwbS0I8lNtO8lV30pTz10CS7APwENT/225XmroSxTJhakdfYPCSyCcC99CiKh4CvQ89Xgb9MAHZTjibID0hh1bIQgdEWzLPOieY1/E+6j2YpI4NRGaEqYDSgkXCTqnldJpLiX3AsuLbSNFSW3Yt+FvYv2lCRTlpX7Oj9qUA5In/UVhBK7LWvjMkbrrLhjpqRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsZ58M60wccX3/kBee6YIGPDb5Qzs+n5tpk+WjpspVE=;
 b=R3M7lzQVsbnTHJHpDD+MI6xWAkyYQZr5RcGaE9lMrimhD2PgSRknAxQZB3yK8GvXoQicYf1rzdx/CyD9G7CKfZJR/pqZjh5t+yAtoZMBe5omW2pizblJVTDd4Hc3DuSCBoSi0FNCLXaLFggO6yKvgK19gZ4nNsZZboUFzoMh9yJCRUmA4k0RthDU/TGu0iTCorP5LykfVQlv6pYRvzWvcruKlUrU8uYz3XdE//KqPTZ7UdIKphHmFysAN1i9mIeQv75dhSSoiGh2tJbb2ySn0S/LnH+HYXJVBAe4nOgGl3P7ZWpYRQpjddqTzUMRu0ky1rEr9A0icLIoQiGzRwB7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsZ58M60wccX3/kBee6YIGPDb5Qzs+n5tpk+WjpspVE=;
 b=TRyqArHVu4xMDMbQaNcqg0mNFQsbIFvjYMjMnJIewi7mflF1lj6tyEHDa+LaShtSPH/1RqyYRBEVXDcEszSvsiT4uR/0YcakunMUQ48qnaWtZaBOsPQ7budluG5ky/fJ7TVyfijoL+Bwkyp6LM5g7srVW4EyMDDSLUHnuzmi3jpH2PH5EzC/mTfgvc14p4aCr7sDJ9ChFsI4PyD8QSrlATaMwduldUv7RWYcsVnijhjLroU6h5vDTXyDZJ1XUKXNUKTtqGZfc5XFAhqAmSvizLS2CALLWOhBLvW/ZP9Y7AnLZ4syPcCJ1Sk404Pv6NUQYnxAANOaX566OjCQBdfARA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Mon, 14 Sep 2026 08:50:10 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:50:09 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-7.4] sched_ext: Add lazy preemption support
Date: Mon, 14 Sep 2026 10:47:44 +0200
Message-ID: <20260914084955.1798562-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA6.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::45c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: fc10f20e-6012-48a4-6c62-08df123d2eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BTXdTLAM/uOi0diWdN14s5NY1bQkFyUSVUfUo5GxnEnP0NGUyxt3Y1tD/dDdA1W7rwEYzGaFeYdDkOoQjdhTQltV6DZg6/s7PyR7Mxp7c/+zU507U0FslndN/synY+5r9EerXlsqnbFDFaWMNJFbdmgF70BtFG3Y1K6GNMuvABOCE2JHX7dNpw1c+MUww5k/drmaHWhov0ckkLf2u+NMCbH/iZ453ZuUg1S+fa9YY/EQrZGJ6CyaClNNhmH7vL0gHrnEdWYX/GKTIQf+5K656/h37It58NnWo8aKsQQFuXyh0UBTFciE7kpgLX8J3JU1wRWolcLTC16qpE+XUC3988Ai0L5HLEFYB2vqpGHwBMRYAwiQ2Jwe/ukZSFaGi6rlk5StMMc+0UFBfXoQ/I6hFm7nvrUS3yFbzhvOitFKJKy5yYLVEpvnTnipOJFG+5zcKMUOpW6t/K6r30TkBD5Ck1RtKVNDeWnM/+QuYg7p4NtoQAjTWuotvku+gfGDTcBIk4VBicjc6eHsKHJE9AwrUMmgWsPie2JZxraGZ4tiuRqMBqtWE8pl9S6eetznjtyg2kS/DppLRyUq/CdpQbgyPcApPiGbLzkGXp1tZ0p4xvLGnY7mHPk2z03XDBPSzAEwXfgnLvi1Rvn8mHEP3uQkuPNfYqfOv4+3Xx8nqRQuQ3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?boJmGpO3g8rYj4+mhsgPYC398fVYj+wXnV0ReuFz+PIpo7PJkcWzLaDSUDEz?=
 =?us-ascii?Q?VQRc8xT4+zWIBVaxlMIowjRPGCXbaVlqs1tplzMAJ0qJ4z9T2buP3EZX/iXS?=
 =?us-ascii?Q?TDeUkNC3CRv5mRB2h/fKMTrMJwbmaGbwPw8uGR5GrBL7d1n4cGd0zJcB0S1P?=
 =?us-ascii?Q?V2bx1IdrGTTEw9BUbOYpFFbZ7gsakD0skG3XcJfMV15HaWilwCzrpMRU79iL?=
 =?us-ascii?Q?2ioGsFUCSAz4lkkYmw/lWuz8f763AfAgEdWdvkN3oJE2lU58rnAOTqnJVKtH?=
 =?us-ascii?Q?Lz304WNGOz5sk0mWDNwyuMrM8hXeYgBjmTkK7tfgjn7OgkqYkYBCT1VK/Rdc?=
 =?us-ascii?Q?vC2VMg1WLhfE92DJ+LN3AKYM6gMCwp9r8PpydLqv52XZKhMfW3xWlRIlCEyB?=
 =?us-ascii?Q?gi59Zg+GUZLLUY3wmCiAlNttEfeMgXhkIuCwoNXwZt/S1Ff8Qq03K4bI8ygA?=
 =?us-ascii?Q?J0T+NAw66+axdCUhONXwuxXNwidVQO1M+C6TWomuexjJRPfz0LsN/EPHgAu7?=
 =?us-ascii?Q?HsKHiDCLmCE6apUywbHr04xvt885AI92L2P/MRvrqYiuidsRtgR9s7d3Kjaa?=
 =?us-ascii?Q?dtkwrpYhJg4NCgXP6IpspSsePp9ZsFbYdfvz0jaUsRoI85BI2uNtMMHrTspb?=
 =?us-ascii?Q?hT/aWQzSDqP633a8KjsT+sbSWMOkZW6H3pEPW3BGjda98nZx8+Nixu5/oCn1?=
 =?us-ascii?Q?jSk97LnIxGMv57w6yZdI4NddDldB9SVKcZvaKryMP/z+0q0PaBFuS4m4Mboo?=
 =?us-ascii?Q?XEnMwN6tvayNIzwa75JRQhJaLdL0tEg+a8YMC080XtV05ufIF+7BgjkbZxG5?=
 =?us-ascii?Q?LVMuAPBhykXjknfV8MrEkxsdQUx7MevTt++9i+puKKSty/uGPiv+NAz12B7x?=
 =?us-ascii?Q?N/1HrSsPWT0zvZLO3S9i3wei+xZbW0NxgYRPlYBgtcv2+v0jNMfp3PZMI5JW?=
 =?us-ascii?Q?c51Ou0mkr4SArTj5JIvmJH1vL3tgmdFx7w37HB1pY7D6ADiDtdXz9gQcczGx?=
 =?us-ascii?Q?AX2jA10HLcvs+mkuj2ieZqFrTCw4wfB7F145CZ+v9/x6nSPqySO/2DXaAkVO?=
 =?us-ascii?Q?D1Cvzw18q5csel7s2Uy2W9iZz9caZmO8EHSkXjBZVLJUmG7PizouAqQw2o3e?=
 =?us-ascii?Q?HGgL7AFWzQXD4Ja3Zdlg4v80uTyp6JTeq98cqQfH53KKfrlsGRIqtD8oFs8p?=
 =?us-ascii?Q?fPFIsV3zNreHM7mgFSPrjZVgHvcX7XMsb6S7MzLNBJYfwFGrS6JKnPjr7ATP?=
 =?us-ascii?Q?hhz1aq8etm2bms9DmfZ83GEtdmflI0JaK/OXcjjwi9Lr+DLwHwA0OVdjSTSa?=
 =?us-ascii?Q?q7V+HkF9ZbnrUNYv/PkvA6OeGckAXKTlMvCNlmSLfPgDxyI2lOrfTQRoQDq7?=
 =?us-ascii?Q?rSjegbHJewt9cs0tI6nz0r/87RwFT/f8DjYtjKRB1uaAGthwyor4i1BG8QdC?=
 =?us-ascii?Q?hMF2qAo+rPYdcgPiDvAbx4vbR/Grwoz4BABo+bHSPGDqyt8KKyjS6aBZox5O?=
 =?us-ascii?Q?Ko98r0pHnsL5cHPIJWiN1WPF+qx+/OdHYG8TvTwaChBudhRMxoZ4t0jQUWOe?=
 =?us-ascii?Q?mfA1W2jzjDekFgS6bGSOkX/nFO6mAbsxUN/4WPRyGj7KFbF5247CFC9958Ao?=
 =?us-ascii?Q?oPw56YCjhepOlR5bGUs7YWmBB152L/0CziF3JjQb6oMyr3TU++A1waYuUbet?=
 =?us-ascii?Q?/8G4+CWEV+FU3O2P9bVot3KK96LNdnzNgHTxQozsNSHjhiearueb8tjoH4zl?=
 =?us-ascii?Q?/xbrZdB60g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc10f20e-6012-48a4-6c62-08df123d2eb9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:50:09.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jug3Iufu1rr7j58J2lw2O/KLTwWDNRMRwdOfvqOAbJjWvsg1dTHOPnCIBxkvFGumE8BJsHdWsw6vUGmB3M/GyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464

The fair scheduling class can defer a scheduling boundary through lazy
rescheduling, but sched_ext currently exposes only immediate preemption to BPF
schedulers.

This series adds lazy variants of the enqueue and kick preemption flags. They
expire the running sched_ext task's slice while allowing the scheduling boundary
to be deferred until a return to user space or the next scheduler tick.

SCX_OPS_LAZY_SLICE_EXPIRY selects lazy slice expiry by default. Schedulers can
override that default in either direction for individual tasks through
scx_bpf_task_set_slice_expiry(). The helper preserves sub-scheduler task
ownership boundaries. Bypass continues to force immediate rescheduling.

Lazy enqueue and kick requests also restore the scheduler tick when targeting an
infinite-slice task on a NO_HZ_FULL CPU, ensuring forward progress even when the
target's tick has stopped.

The kselftests cover immediate and lazy preemption, coalescing and precedence
between kick modes, enqueue preemption, per-task slice-expiry overrides, invalid
flags and lazy preemption of infinite-slice tasks on NO_HZ_FULL CPUs.

Tested in separate virtme-ng runs, covering preempt=lazy and nohz_full:

 $ vng -a "preempt=lazy" -- tools/testing/selftests/sched_ext/runner -t kick
 $ vng -a "preempt=lazy nohz_full=8-15" -- tools/testing/selftests/sched_ext/runner -t nohz_tick

  kick:
    PASSED:  6
    SKIPPED: 0
    FAILED:  0

  nohz_tick:
    CPU 8 received 7 finite-slice ticks
    PASSED:  1
    SKIPPED: 0
    FAILED:  0

Changes in v2:
 - Make lazy slice expiry a per-task property (Tejun Heo).
 - Add scx_bpf_task_set_slice_expiry() for per-task overrides from any sched_ext
   callback (preserving sub-scheduler task ownership).
 - Restore the scheduler tick dependency for lazy enqueue and kick preemption of
   infinite-slice tasks on NO_HZ_FULL CPUs (Tejun Heo).
 - Accumulate immediate and lazy kick requests independently and resolve their
   precedence in kick_one_cpu() (Tejun Heo).
 - Allow PREEMPT|PREEMPT_LAZY and WAIT|PREEMPT_LAZY, immediate preemption, WAIT
   and plain kicks take precedence over lazy preemption (Tejun Heo).
 - Clear both preemption masks together when processing or skipping a preemption
   request (Tejun Heo).
 - Extend the kselftests with combined and ordered kick requests, per-task
   expiry overrides and NO_HZ_FULL coverage.
 - Link to v1: https://lore.kernel.org/r/20260911195800.974364-1-arighi@nvidia.com

Andrea Righi (2):
  sched_ext: Add lazy preemption support
  selftests/sched_ext: Add lazy preemption tests

 include/linux/sched/ext.h                         |   8 +
 kernel/sched/ext/ext.c                            | 146 +++++-
 kernel/sched/ext/internal.h                       |  39 +-
 kernel/sched/ext/sub.c                            |  15 +-
 tools/sched_ext/include/scx/compat.bpf.h          |  13 +
 tools/sched_ext/include/scx/enum_defs.autogen.h   |   3 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h   |   6 +
 tools/sched_ext/include/scx/enums.autogen.h       |   2 +
 tools/sched_ext/include/scx/enums_abi.autogen.h   |   5 +-
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c      | 166 +++++++
 tools/testing/selftests/sched_ext/kick.c          | 526 ++++++++++++++++++++++
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c |  54 ++-
 tools/testing/selftests/sched_ext/nohz_tick.c     | 189 +++++++-
 14 files changed, 1129 insertions(+), 44 deletions(-)
