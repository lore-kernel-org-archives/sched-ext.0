Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91391409277
	for <sched-ext@lists.linux.dev>; Fri, 18 Sep 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751756; cv=fail; b=c+yXE6cLfXbjR7zqU9jP9axCLPWOA4lY6gYvZWToX0Qq2ABrwMkTxOrDmZ02HzQugvwdOv5DCCDH1DneXeg4cyzeBfyPXRpsZQKHqW7gaI0m9TzXnXGfKu8Ktn7C9ySlTZRH6hm6UbqXK9ZI5PqmoNlnI/HoA7I0Uucc571FzzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751756; c=relaxed/simple;
	bh=RHresDP6mBv3Unv5jRnXG7M/S25LOoK49SASM+6AUDc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KbUWxScyxxX7OAy0/rU1vvosHGKUfzQKDb91QvBYjmOTKRbddTjxjZ4giTxFyTzIu08M/MbZdkGuMvDrCjyjFvtqE5l1p2wje4hZ97AvLhg/yTVQLZ31n68a1Dfy5BqGb8Qalf6HfnPHYC5+RLyjqbryi8977Kk99jfEds7yGlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=luj4CEvp; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="luj4CEvp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm4UPCiZwh8qXcbSeO3UF22cJqgVApqYuMIaVIRJ1GLlYyXxUOEs3bz4QC+wZjYqBD1lswTtJgUgGbJxA8BQcg0l2ioZ/Tor18BQDLSj/lUO1rukivUPSuHihg8k3eS5KTYM8G+IgpRbPOV0ZLMkOqn3WpOaJbkCQ39LigEwVrLjtnj8bFa6XrdS7OGU+wkf2rSqNpyszBvdUAghfL76Dq7udhDPsgaBw2B9qdekWF1JRrDGiwq4msSveDFvdLC1Tg5GuNr6y8IxDH2BIp5AckmxgLuakNiNX6lwIP5PYIznE4iWbyA7WnldDD7k/0WHfweDz5EcDWpbdGwk5z3Kzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlUbDc03a8s6ZFqpDDsi90fQBlRqMmfFBY6kZAfFkqQ=;
 b=ivCZjUMuDA1moFsZ1Pe0nsCFn7WtXdrNzm4X9fXHK9Iu4UavsP816goFirOz/vMoV8apjbOV1Ig6js4v2dd7fTt90rXx97YFl/ylrO4ve2fxichVS5Mwof6MO+8CkHQfh79oVkKegWhJw9Dx5zPnyP8GB1SJnBUSwxmqofSxQnWrZXU9qFZbO5yqJQ4grUkxhoGr1x8lIHAQIzY2haMHptNretbmebFoukqDPGt5zaw+Z1qtYhrMyJr/jMXOod3D7Fqs+5Kuv+7HtHBATrXhTjmYsdX1NjY5Snkq8eozhxeJIb66QNnLDVJRc90HP1TcbF75dM2htpIQ+oNUsk2L3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlUbDc03a8s6ZFqpDDsi90fQBlRqMmfFBY6kZAfFkqQ=;
 b=luj4CEvpPdT594Bv6MSVcxvfz7ceOt/kQTd3iW2wAGFebTOPWzBFV8mz9g1VvjyB6R/kcA+UD50imywCzhyVaqyI6StJE7AU+M+VGy8atXaMeShgUy6jD+Km7xG7DPRSIvPEbyFJ/+hq8swF8RS73U6YT6SUSpqjuiLvDFBBcyN1DLhlh8cYOUiuTD+i7ODLqq6M8rlW1AJgBG6/Nz4NhL5Z1cio1mS9laAB/QUQmxcn4mgq/68wOMqTJepcJIyCzncnrb8guEFb/mrs35xNve9/NoS1dbamyHTypx67m7Qtkk8ejUxq9eQMIRLREz0ykHRnzFB9w48iiNVVm4ru2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV2PR12MB919616.namprd12.prod.outlook.com (2603:10b6:408:417::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 17:15:50 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 17:15:50 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Tao Cui <cui.tao@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v7 sched_ext/for-7.4] sched_ext: Add lazy preemption support
Date: Fri, 18 Sep 2026 19:13:26 +0200
Message-ID: <20260918171539.214204-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV2PR12MB919616:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ad920e-1eee-4431-1df6-08df15a87cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|6133799003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	c8XGalytWQVvef7bv1poGELfE0242DWepr8zNgGUJDmzMe1MlXMD+njknpDL1WoK8P0+Ca2BwngXMvpAU002YK5orBQKl4dxLXruJtwI1XzQ5RVLfdFyiKp/9hLg7nO5Ep/ms8p6nGAHFLnuDCTN3Dk9pRk21W3eES/Jr/BazDbi0vq/DhbjRm+Qg7+B+AYI8KnIhedYsUi0ZF1ltxTEpiWvlvUpl//brGLN8cQDe2wi6ExIAGE/FdwarngYnIMiF0dgvgE+82gEtDcYdRjxa7rbGR4LnaIYRUz5UkLZ0ev4lchoa3vXcEB14OzB55RWJKgpAko4fBwh4s44DHsq748gylm3Da4am7YOkGlJNM+yHIju+RL+7hUhEv5jEUxvEK5WyiK3rtiUc77rKGo64eTdZpwklzMwYyjpkk/BCfWZ92ynrMhPT4jODp1CB4yX85ZEXxSvSbrMsx/fPKdYGGgBmhMvrB6W+GLgs9OYwxPZS6V7CMwb8dX+yvU9sE7mwJVzN+Dt1wt0nqGepC0ntItpbCGzGfqHe3nX4X6ul2wq/Owf5QPmnQ3iJVt2yJAXpJUJaJEaJ3/6Z2XD5pI17hP0y5ztOBN7le4aQ5Tbo7KZnhuDyQ/OloNuuUBnuzFM53+mPjhIQYZqCuxDHjBr4IzBXnsyBwHjJwDNPORd8lg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BHCv/EMNvl7/fNXn+RMH+xLGcwGZsI8aloHFYKhi+cx8rWgCLWKwi500p46D?=
 =?us-ascii?Q?IMVZICT9+T7jJiLxY5UlT5MFQEpwnG79nsDtaH1pKlfBKWSz8KIkgGEr2lgs?=
 =?us-ascii?Q?JDddKHik/OnmOBmUdlEfXZ5HPas2nc1GlKFlwZsENvGg/DgUVj50nKS5Qku+?=
 =?us-ascii?Q?/+Dd5sLk8M92cFyn9xEjbm0n73JdoYKLlL4S/RlU1aD2MytovYtjVvKQFVor?=
 =?us-ascii?Q?vkEJgl61i7c7wqssfsCIBScryVI7p5ufDy3vgYu7dZD4/zvxInGSyRXd1Yvl?=
 =?us-ascii?Q?M/hTjtIhXB7x6M6eswBWThmYQcvjdR5fzsbXl0YuZeJOmENtcsc2HmIVmdvi?=
 =?us-ascii?Q?QtGrHfV1qEKHmweWSDudhJyf7jnJ4gUmhKLaKGXFtMZ3LjasFZdl0aC99Oiy?=
 =?us-ascii?Q?RqUYIPrJIGtKZnaTaHCfxvoxV2sN7u5c9A4Np4VukFAdBM46mDpYauq9375j?=
 =?us-ascii?Q?Pb4dQ7VFMPo3yNFYxG4Cn0LoZRsXqc1qjWEr4dZ9C67tsJXR238xYy2Skv6q?=
 =?us-ascii?Q?F/yvoy+FtVFaMKDo0/luimybO23nIaiHQ31yKnEXvD2PE86L6rZbMJ0nZOs9?=
 =?us-ascii?Q?JeSv+1vB+IvyEAWwQDPLdDn6pmCu6o+M+d+21JLqWudJeSsc+WuZLu9bgbzd?=
 =?us-ascii?Q?P9xdWA//7XJ+aKTFDmK5x5Kiy0B4RiNta8BOgHwzSyomAry41BFOC8RTu8VZ?=
 =?us-ascii?Q?LHA4fhLUOrIrolvoqVR936za91GQN2N26M1Z7r7IcZMtE95hbpayr1hkRKB0?=
 =?us-ascii?Q?9R0Yz/IOMDtDXSCIGFDLZAwchDWlTQoJT3H+F1WfiwqcrTvJ3KdiSX8035T+?=
 =?us-ascii?Q?OBpdshcmRR8Ti3QVzh49Wpd0YVRU+yBnkBPv5bNWRSoNuid3L2+Qd6mWbH+/?=
 =?us-ascii?Q?413WYt10jzAoNAHAyeYYleMUc44XbhDTqALdNIJHpRGSBa+bEgTHupLNB29u?=
 =?us-ascii?Q?o2/9a4owMvpjVDjqCv1WDVKiX/XnMs5mvPT+Z4D6j1e0+q5S6pdys33BiWIG?=
 =?us-ascii?Q?HnS1jTrlHTCmjf9c4oGGvUd1+Ruct/WRAxbtO7SKfj6+rGatWr385wsoo6Kn?=
 =?us-ascii?Q?gnMXuabso3zXFY2aTc9d7xYQQ4gOv/QWXaq/E2guSsCbUmKOfgchTnsUjyGY?=
 =?us-ascii?Q?6bME1akmMOEt3efqAZmtMEAFF0iKRql/ZH/8ldJ3+dCpmkP+XfaRZ14oMW4o?=
 =?us-ascii?Q?3fc8DsxxWGAIK1poRw8CVzcdg+rVVEN75P62Xp+RUunq1H/sVwKdpP8KnjK+?=
 =?us-ascii?Q?PWwncLQOQ7FoinnhJnQH9POj/jM2lQtpmoqtjnAXN69pi3Sp+uW27jLX9PFa?=
 =?us-ascii?Q?UB/VlzwORhNQdMbLyOiPku13zSSqniL8X7b5r8IwzF8GIdrKXIaUjH2+wp6b?=
 =?us-ascii?Q?JCjhmWjmVqbPriagHRxh7C89RA9IDb5nWDNx6VGaiwBkmyWjRmp81I5L6rg6?=
 =?us-ascii?Q?Mnppnx0GeNWvmQY1h3uL2SFdfck2aQoFH7maV0FZMk8tmzR1xDVwH7KT8aFn?=
 =?us-ascii?Q?+miibH4OUvgjlg/25QIni35LLiPrQD/DkavPW+4y58Hpk+tKHseFzUFLqdC/?=
 =?us-ascii?Q?sPULuK/wnFIiRwF175iFDwERJ+YxhT7iZa3EmK88+Rrt431a0yXSNjlRp+tD?=
 =?us-ascii?Q?lD/wsJ0cxOJfHlhY50xU/PBTUjh0zLcCmH/VMONeigVDpw1qYMV40TBgJZrk?=
 =?us-ascii?Q?HKdD3230EFFXr5coYCbRX6ZDCjo3QZZYXp9/42Dy58uCyWUwcIuG8Zq0n+CE?=
 =?us-ascii?Q?fu8+c+tCyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ad920e-1eee-4431-1df6-08df15a87cf7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 17:15:50.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RYMLgEfwpQuEeaR6dCmzRw0jvhaJFTNoO+tqoEbvLH7CNWalxT21KOUc7SSLLo8tzRt7JIjIjIKCjQEVeCN6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB919616

The fair scheduling class can defer a scheduling boundary through lazy
rescheduling, but sched_ext currently exposes only immediate preemption to BPF
schedulers.

This series adds lazy variants of the enqueue and kick preemption flags.
They expire the running sched_ext task's slice while allowing the scheduling
boundary to be deferred until a return to user space or the next scheduler tick.

SCX_OPS_LAZY_RESCHED selects lazy rescheduling on slice expiry by default.
Schedulers can override that persistent policy in either direction for
individual tasks through scx_bpf_task_set_lazy_resched(). Unlike the one-shot
SCX_ENQ_PREEMPT_LAZY and SCX_KICK_PREEMPT_LAZY operations, the kfunc does not
request rescheduling itself; it controls what happens when a later scheduler
tick finds the task's slice depleted. A compatibility wrapper makes the call a
no-op on older kernels that lack the kfunc.  The helper preserves sub-scheduler
task ownership boundaries. Bypass continues to force immediate rescheduling.

Lazy enqueue and kick requests also restore the scheduler tick when targeting an
infinite-slice task on a NO_HZ_FULL CPU. The reschedule request is set first so
that the dependency update's IPI can serve it on return to user space, while the
restored tick guarantees eventual promotion otherwise.

The selftests cover immediate and lazy preemption, coalescing and precedence
between kick modes, enqueue preemption, per-task lazy rescheduling policy
overrides, invalid flags, and lazy preemption of infinite-slice tasks on
NO_HZ_FULL CPUs. The NO_HZ_FULL cases verify that the tick has stopped before
issuing the lazy request.

Tested in separate virtme-ng runs, covering preempt=lazy and nohz_full:

 $ vng -a "preempt=lazy" -- \
     tools/testing/selftests/sched_ext/runner -t kick

  kick:
    PASSED:  6
    SKIPPED: 0
    FAILED:  0

 $ vng --cpus 4 -a "nohz_full=1-3" -- \
     tools/testing/selftests/sched_ext/runner -t nohz_tick

  nohz_tick:
    CPU 1 received 6 finite-slice ticks
    PASSED:  1
    SKIPPED: 0
    FAILED:  0

The mode-sensitive kick_lazy and kick_tick cases also passed after switching
/sys/kernel/debug/sched/preempt between lazy and full. Tejun Heo additionally
reported successful vng runs in lazy and full modes, with nohz_full on CPUs 2-3
and on CPUs 1-3.

Tao Cui tested v6 in a 4-CPU KVM guest. Lazy and immediate wakeup preemption
both averaged 59 usecs, compared to 60 usecs for CFS, over 2,000 iterations.
Lazy slice expiry reduced the context-switch rate of six busy hogs from about
1,000/s with CFS to about 215/s.

Changes in v7:
 - Fold normal and lazy kick processing into one CPU loop, avoiding a second rq
   lock and clearing idle-kick state for lazy-only targets (Tejun Heo).
 - Rename scx_bpf_task_set_slice_expiry() to scx_bpf_task_set_lazy_resched(),
   together with its task field and default ops flag (Tejun Heo).
 - Clarify that scx_bpf_task_set_lazy_resched() sets a persistent per-task
   policy, while SCX_ENQ_PREEMPT_LAZY and SCX_KICK_PREEMPT_LAZY are one-shot
   requests.
 - Add SCX_KICK_ALL_FLAGS and simplify validation of SCX_KICK_IDLE combinations
   (Tejun Heo).
 - Fix the compatibility-wrapper comment and separate the ops flag documentation
   paragraphs (Tejun Heo).
 - Share test enums between BPF and userspace, consolidate gated-worker helpers
   in util.c and remove an unused generated configuration include (Tejun Heo).
 - Detect static preemption modes through /proc/config.gz when debugfs does not
   expose sched/preempt, and skip mode-sensitive assertions when the active mode
   cannot be determined (Tejun Heo).
 - Restrict coalescing, per-task override and lazy NO_HZ_FULL checks to kernels
   running with lazy preemption enabled (Tejun Heo).
 - Stop infinite-slice victims before their challengers and check the scheduler
   exit state while polling (Tejun Heo).
 - Run the NO_HZ_FULL lazy phases with SCX_OPS_LAZY_RESCHED so that a remote
   tick cannot turn the test request into immediate preemption (Tejun Heo).
 - Link to v6:
   https://lore.kernel.org/r/20260917070751.3617935-1-arighi@nvidia.com

Changes in v6:
 - Pack slice_expires_lazy next to scx.disallow instead of growing
   task_struct by eight bytes (Tejun Heo).
 - Correct the SCX_OPS_LAZY_SLICE_EXPIRY documentation for
   PREEMPT_DYNAMIC and bypass (Tejun Heo).
 - Set the lazy reschedule request before restoring the tick dependency,
   so the dependency update's IPI can serve it on return to user space
   (Tejun Heo).
 - Explain the pinned rq locking and the newly rejected unknown kick
   flags in the patch description (Tejun Heo).
 - Regenerate the enum headers in definition order (Tejun Heo).
 - kselftest: use SCX_OPS_ENQ_LAST to drive kick-test victims through
   ops.stopping() (Tejun Heo).
 - kselftest: poll for the SCX_KICK_WAIT callback after ops.stopping()
   (Tejun Heo).
 - kselftest: skip trace-based tests when their BTF targets are
   unavailable (Tejun Heo).
 - kselftest: verify that the NO_HZ_FULL tick has stopped before testing
   lazy enqueue and kick requests (Tejun Heo).
 - Link to v5:
   https://lore.kernel.org/r/20260915194611.2674127-1-arighi@nvidia.com

Changes in v5:
 - kselftest: detect static lazy preemption when CONFIG_PREEMPT_DYNAMIC
   is disabled and the sched/preempt debugfs file is unavailable
   (Cheng-Yang Chou).
 - Link to v4:
   https://lore.kernel.org/r/20260915090127.2321020-1-arighi@nvidia.com

Changes in v4:
 - Preserve SCX_KICK_WAIT synchronization when it is combined with
   SCX_KICK_PREEMPT_LAZY (Sashiko).
 - Restore the scheduler tick dependency when ops.tick() lazily expires
   an infinite slice, ensuring the request is promoted by a later tick
   (Sashiko).
 - kselftest: verify that the deferred SCX_KICK_WAIT callback runs
   (Sashiko).
 - kselftest: keep the kick test controller off the victim CPU and skip
   cleanly when a second allowed CPU is unavailable (Sashiko).
 - kselftest: select the nohz_tick controller from allowed housekeeping
   CPUs outside the NOHZ_FULL mask and skip when the required topology
   is unavailable.
 - Link to v3:
   https://lore.kernel.org/r/20260914144620.2032614-1-arighi@nvidia.com

Changes in v3:
 - Avoid redundant rq clock updates when restoring the tick dependency
   and use the pinned rq lock helpers for lazy kick delivery (Sashiko).
 - Set PR_SET_PDEATHSIG for the indefinitely spinning kick test workers
   so they don't survive unexpected test-runner exit (Sashiko).
 - Wait for a delta in nr_lazy_victim_running instead of an absolute
   count that may include reschedules from the previous phase (Sashiko).
 - Increase the nohz_tick scheduler watchdog and phase timeouts to
   tolerate scheduling delays in oversubscribed test VMs.
 - Link to v2:
   https://lore.kernel.org/r/20260914084955.1798562-1-arighi@nvidia.com

Changes in v2:
 - Make lazy slice expiry a per-task property (Tejun Heo).
 - Add scx_bpf_task_set_slice_expiry() for per-task overrides from any
   sched_ext callback while preserving sub-scheduler task ownership.
 - Restore the scheduler tick dependency for lazy enqueue and kick
   preemption of infinite-slice tasks on NO_HZ_FULL CPUs (Tejun Heo).
 - Accumulate immediate and lazy kick requests independently and resolve
   their precedence in kick_one_cpu() (Tejun Heo).
 - Allow PREEMPT|PREEMPT_LAZY and WAIT|PREEMPT_LAZY; immediate
   preemption, WAIT and plain kicks take precedence over lazy preemption
   (Tejun Heo).
 - Clear both preemption masks together when processing or skipping a
   preemption request (Tejun Heo).
 - Extend the kselftests with combined and ordered kick requests,
   per-task expiry overrides and NO_HZ_FULL coverage.
 - Link to v1:
   https://lore.kernel.org/r/20260911195800.974364-1-arighi@nvidia.com

Andrea Righi (2):
      sched_ext: Add lazy preemption support
      selftests/sched_ext: Add lazy preemption tests

 include/linux/sched/ext.h                          |   8 +
 kernel/sched/ext/ext.c                             | 151 +++++-
 kernel/sched/ext/internal.h                        |  44 +-
 kernel/sched/ext/sub.c                             |  15 +-
 tools/sched_ext/include/scx/compat.bpf.h           |   9 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   4 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   9 +
 tools/sched_ext/include/scx/enums.autogen.h        |   3 +
 tools/sched_ext/include/scx/enums_abi.autogen.h    |   6 +-
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c       | 170 +++++++
 tools/testing/selftests/sched_ext/kick.c           | 531 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/kick_test.h      |  29 ++
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c  |  57 ++-
 tools/testing/selftests/sched_ext/nohz_tick.c      | 220 ++++++++-
 tools/testing/selftests/sched_ext/nohz_tick_test.h |  13 +
 tools/testing/selftests/sched_ext/util.c           | 144 ++++++
 tools/testing/selftests/sched_ext/util.h           |  13 +
 18 files changed, 1357 insertions(+), 70 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/kick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/kick.c
 create mode 100644 tools/testing/selftests/sched_ext/kick_test.h
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick_test.h
