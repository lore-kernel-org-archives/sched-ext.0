Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374535C684
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501588; cv=fail; b=pXUtCPVcMfXDHf5C572h5w5N34eckqna3QoharU1+u6yR7IAracIyljOp19jDzf79E8SW/UO3dLutKUVWXJ64rss0k7XziX1SIhsDHRLyRQPI2tppFPKRH1n3QQN/SGWxBJhUNw4Y2vrL888nDT8cL32sWdnAHZbfeHIt1ZAaZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501588; c=relaxed/simple;
	bh=2cntv+Z9LVzbfmXOdFUATslkZ8qO9FyqA6Yg5nCnNdE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IiMT9mf08trKOJ7dc9d6rFHEhXlkFOcuOG/df+tX9OU6hg85PFIDRQkT3VvwYGtSQOFyfNh742bDa62ays3qfnyUADSEfsMFklISITD3TZmfImYHyDtZaWhH8ft6KaxklL1/8SnuWySUZv2aNs2SG4sz+QfQv0m8aAT00cdaFWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NPmyP9l0; arc=fail smtp.client-ip=52.101.193.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NPmyP9l0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voKgassVHn3kyt041ZF3wJVF9lWPZ8D+oovK6E8bKeRMa35kNp+ZQHh+cnJamFnLz7TJEMVzzrqkIwdXbNQsRacaFT+kKhzkkytKohbyB3CChmD744KjexuIoJt7xOOqFhl31SgaJvBFUcgRKyVpa6lJJHcvEjmFm1bFLIkNeHHAVWMJKLldOClsM4zYTPLnXdfzzPILMQ+/w9wv6teijJSABxzq6id/sKm8ouXe0EFMZMFZyWu3z6pjzx3oFnSIaDASkQQOG8FillYQZYsnk9XTTSACItMcvd0fPK0u3tzLpujO5d0NDKvfvekdmDY8gm+v8L1ud6+aMAV+nA11mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx/BteHX0SHnaYgt0rFty87WIbuQj59vAeemVupO47g=;
 b=XZE3440p59RSatIUuC0xQMBo6nNtvvvFsfDBmEptSTdwSUt7d2OjaYUrEZC9ey5kCFTXuhGq74YnK+3j+Y6b3S9N0vsjG7KhvM61YJzurH+JkMDqdIFIitLvIuFP4HfiTsNWjbyiymSS2IiueFPgUQot3FdOjFUget/3xj26CcfFtH73aGXgIEbGrA4+1VAew+aDNfiRNJXyiUzrmnUvcNrXexix+SrskHcpFWvqkZ7zX/EtDD6bhVUr3jlFE+//NIcBkv4IOW4wsRap0PJ1pcMyXl5KCzWbc2X8+Y4+jQMY8oi8iHxstTrzgnUp6+dbwAY+qLuLkPL9cT1HIu5nuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx/BteHX0SHnaYgt0rFty87WIbuQj59vAeemVupO47g=;
 b=NPmyP9l0J+DTWrEYhgSP7xsMScacnYIZc8gH7z/5HN7eJHqwmgsYW2jZ2JfvU2ynWlOM1rHJ2u8bRIlrd4etV97DAumgCTqQSBccdR5CpWGslrn8sMk05zGcVjVVDfryd17YhNcGrefx+aSo0vir/YOVADWyJQEY/jBlUnalWiKTqZ1HjhRkamFZ20riDOTX6VRJrmglkGcRbrh4UjT/L+8qre8WwI/d+ml4o42OLV2CEApmG3Ug/EYOTfnkGawmWvwyGmw4vSP5eM0wsLdb5J7PiKddoVh/zPc7dMjFj/ObblQmaOJrBlkfgfDZhpshqsnwe8jnrAGeGeCxqQqiJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 19:46:21 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 19:46:21 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v5 sched_ext/for-7.4] sched_ext: Add lazy preemption support
Date: Tue, 15 Sep 2026 21:45:11 +0200
Message-ID: <20260915194611.2674127-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9443a5-e09f-4d98-ffcf-08df136203d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|3023799007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	pqGqL6VD1eHBG5sGfcHgLXftFxVlaEIZRzSqDoXuCaMTrqXbYS/6YZwF8qtw9T84E3o7hnZAbQUo/0vbboCQ8jPSBPj1+XsC5caRfRnXVkIjsI9cGYYOELy5B1XU4YY2XxBGE47gHVr2GvEwMMi/y0MHceutXKG4ZWHrQs9doKV5Y4psd9QgeA/vkc4RmwX15PurLtilH91R0jEUWtpdDuKFNpoNam1xD6Mw74kncq4HMgvPYyYjuRsMMqTtbKYXHOYNEUEsjavNcnTK7ydWDXzuy4KwJYLcEljKZLYhn/zYYAgA+7wuXZvYpvI3NEPla4Mr46EPHL6PzpQKdhIa2NjpOBtYnoGqzCAVA+uoB96+EDBQ4FXUqWqZFeWuKynuO5hRI0gX+JzU+Z6buCHipS0/Y2gjRS88fcgD5E8TybFS0ljVznrhrV19MRjnrhihnWjbOo3+Zxt+o+obJrn2rx+2Alm/MMA43XZTG+a0ivjBR0XQi6c85i32Brpn9qBdoLpAIZq3xC4Oj6jr3PAKmPMKeaJ4GNUh7u96jQXEC9sEl+i+CzSLVCRGddMVaP4znStDjbYi+CjHis8CLUnqSmAcgdFQgCOP69/Xt7ofFuS0NEhAMGm4eCUplmBwKFdoIkuG4/Hb2UtagMGPU52a3dBNdPE/ogv/trW9dA+m4qk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(3023799007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slr6zfcOL3IbD1soXavwvlDyRFnL5niV7xHIB5EMf9ZBbBOPVvG2g+GXX8PB?=
 =?us-ascii?Q?NAT8EIMV+1rsIFit83ef4/dkNq/uvSKq+HZ8dCLb5YL8SkvK4kTfllP+k97S?=
 =?us-ascii?Q?yTuNsuDWvkoIypTEf0emfWNwV8IbzhjOxWpuAwUyoH2EbVjvj3cjcpkMyEk/?=
 =?us-ascii?Q?ndkcWIU/vtzymOTO9wHmNKsX5otsCB5KGMNNsUpUDN0j9wGLKL240DxCNV3d?=
 =?us-ascii?Q?axLlgbsC4Q7YQMA0n801O2C/HpmPfQzxUhitJEKTd1Z08n2MIEknssYhEJEe?=
 =?us-ascii?Q?P4ol/Scf7ZAk1/5BOi7Itb+f7AeuF/Rk7DwGz96nY//FqMYgmgqU0pt+wHqd?=
 =?us-ascii?Q?5lk7GjycNZeJON+Clk9mhLXJQa41CCCOFl6plPDCX+i7dqOxWYR0FIShqWEK?=
 =?us-ascii?Q?rP66iCWcv/iqFPONA5j8wUCHcxQAR/0iC9dAuJI7szoK8sc1JkapjEi5DgtW?=
 =?us-ascii?Q?5XHS5MDfFCSyhWrwATdETOJ47Qm32frBrceynKqp/IFSbqxVkyz9UvBQVSAJ?=
 =?us-ascii?Q?oQltDMV5WlYTSA6fZF4sSRWyWvxERmjZSPYY8FEo9KawCb96fqqF1oO7nvJ8?=
 =?us-ascii?Q?HhnOb1lpNiAVyI4sD6McxyUuSPnVAyY8NAQ7kH+OR9j+w4tZtn9nI5QDMNYV?=
 =?us-ascii?Q?025huYRILiKwgnOw70c4sPINnG6xXC177cnfuln8c0Omb1fAwcj8Ygptq54y?=
 =?us-ascii?Q?cWHTppEdSYkHvOEHTzH+C/1q+seLjx8czTPWa1M5w49BdHxLtV9k+lFIp86b?=
 =?us-ascii?Q?qwe6JzRcxPeZJqmkZCV49tAoPq3tMivmRYKHEiiGGr4q+Zb2nzbiHyUAdkJr?=
 =?us-ascii?Q?vbk27wv3JWTr4udWYsbta1eo4/kSPsVGpl0FZfqzARE2+Ihb19zle+alQ+to?=
 =?us-ascii?Q?KIAfgz67Jg3lmDRiDwJ6/O0VyRiIbDJEKZZEf72mb2RTFvGoN1wIvUu7I4us?=
 =?us-ascii?Q?cSGo1CzdABSLXfWJOe4w9eqQoQob8fGhmX3ffpx4zwANG4907hZ9CAS7gX9Y?=
 =?us-ascii?Q?VC5t/ETBX14Ef+962zMJLY+umxoZcM/SIZKPZeS/5wXBZcSNnqQa2E568/Bs?=
 =?us-ascii?Q?HK9rlM4G/wvHaUUvSuVI7xPyHZoGngvb0v42Co5w3wk0lUvE/iMaQibpP6tn?=
 =?us-ascii?Q?fwL+hWDH4UBl3KuZzBxdN9eRYcOTvjw9vjOU4mGHrBsGGcc2eKfcKFEJTI96?=
 =?us-ascii?Q?tDDlvK/eIM1aDNxDm1Zik06N0x044RBX0/n6TwehJ0zZICH8bdaU/dIwvsEM?=
 =?us-ascii?Q?MV/X26C3meKU18wANgWhQbAORoaRJeGAbmlIIafSb3WWN7V9S6biTaqctT+X?=
 =?us-ascii?Q?A68SPUMadaLtyeXX7lbLLQ2zvwa/l5YbWyFhwF2XTIL3y/VUlvbtl7acIIor?=
 =?us-ascii?Q?BcYkzFo7T93wmbJIUOk5/JlagtQYJX7YqxqAEXIZAA2xBll2+eRh6/Q04anY?=
 =?us-ascii?Q?KZrJZ3ZwP0j+wxC4TC4cWKjGyiS4RPg+OBs13phWUCnXgx+M4yIskp9lzxpG?=
 =?us-ascii?Q?nNV2aXf80xU4NzwFG6kk1Qt8Ql6TveHwE/TNr0sd/11zwv+aBrHvvx0GQpEp?=
 =?us-ascii?Q?cklCJ/GTsjKnkbr0okfYoKGTVckYwS/SsCxR9hAF8gMfrio9fpm4m36NM7Lb?=
 =?us-ascii?Q?F0H05P8UEIJJMU7W+Sr2uLzqw5Dwhxl6cpjCzNn1esaq/5TgESm9uaPi1Awu?=
 =?us-ascii?Q?ls4FN/UmGGtaS8NCY9DEAplzzn3h1vdE5KAcMQ7ktVHveROIs+G0dipL/YVX?=
 =?us-ascii?Q?kWUiRa6SWw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9443a5-e09f-4d98-ffcf-08df136203d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 19:46:21.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1XzAQpaVAv/dUmODQwnxJ3tVMS3Ktaflu5wQSUS1SZE3QTrJgP/CIzaFOK0Auc+iiiXn/Kea2IlzGq2b66idA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

The fair scheduling class can defer a scheduling boundary through lazy
rescheduling, but sched_ext currently exposes only immediate preemption to BPF
schedulers.

This series adds lazy variants of the enqueue and kick preemption flags.  They
expire the running sched_ext task's slice while allowing the scheduling boundary
to be deferred until a return to user space or the next scheduler tick.

SCX_OPS_LAZY_SLICE_EXPIRY selects lazy slice expiry by default.  Schedulers can
override that default in either direction for individual tasks through
scx_bpf_task_set_slice_expiry().  The helper preserves sub-scheduler task
ownership boundaries.  Bypass continues to force immediate rescheduling.

Lazy enqueue and kick requests also restore the scheduler tick when targeting an
infinite-slice task on a NO_HZ_FULL CPU, ensuring forward progress even when the
target's tick has stopped.

The selftests cover immediate and lazy preemption, coalescing and precedence
between kick modes, enqueue preemption, per-task slice-expiry overrides, invalid
flags, and lazy preemption of infinite-slice tasks on NO_HZ_FULL CPUs.

Tested in separate virtme-ng runs, covering preempt=lazy and nohz_full:

 $ vng -a "preempt=lazy" -- tools/testing/selftests/sched_ext/runner -t kick

  kick:
    PASSED:  6
    SKIPPED: 0
    FAILED:  0

 $ vng -a "preempt=lazy nohz_full=8-15" -- tools/testing/selftests/sched_ext/runner -t nohz_tick

  nohz_tick:
    CPU 8 received 7 finite-slice ticks
    PASSED:  1
    SKIPPED: 0
    FAILED:  0

Changes in v5:
 - kselftest: detect static lazy preemption when CONFIG_PREEMPT_DYNAMIC is
   disabled and the sched/preempt debugfs file is unavailable (Cheng-Yang Chou).
 - Link to v4: https://lore.kernel.org/r/20260915090127.2321020-1-arighi@nvidia.com

Changes in v4:
 - Preserve SCX_KICK_WAIT synchronization when it is combined with
   SCX_KICK_PREEMPT_LAZY (Sashiko).
 - Restore the scheduler tick dependency when ops.tick() lazily expires an
   infinite slice, ensuring the request is promoted by a later tick (Sashiko).
 - kselftest: verify that the deferred SCX_KICK_WAIT callback runs (Sashiko).
 - kselftest: keep the kick test controller off the victim CPU and skip cleanly
   when a second allowed CPU is unavailable (Sashiko).
 - kselftest: select the nohz_tick controller from allowed housekeeping CPUs
   outside the NOHZ_FULL mask and skip when the required topology is
   unavailable.
 - Link to v3: https://lore.kernel.org/r/20260914144620.2032614-1-arighi@nvidia.com

Changes in v3:
 - Avoid redundant rq clock updates when restoring the tick dependency and use
   the pinned rq lock helpers for lazy kick delivery (Sashiko).
 - Set PR_SET_PDEATHSIG for the indefinitely spinning kick test workers so they
   don't survive unexpected test-runner exit (Sashiko).
 - Wait for a delta in nr_lazy_victim_running instead of an absolute count that
   may include reschedules from the previous phase (Sashiko).
 - Increase the nohz_tick scheduler watchdog and phase timeouts to tolerate
   scheduling delays in oversubscribed test VMs.
 - Link to v2: https://lore.kernel.org/r/20260914084955.1798562-1-arighi@nvidia.com

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
 kernel/sched/ext/ext.c                            | 153 +++++-
 kernel/sched/ext/internal.h                       |  39 +-
 kernel/sched/ext/sub.c                            |  15 +-
 tools/sched_ext/include/scx/compat.bpf.h          |  13 +
 tools/sched_ext/include/scx/enum_defs.autogen.h   |   3 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h   |   6 +
 tools/sched_ext/include/scx/enums.autogen.h       |   2 +
 tools/sched_ext/include/scx/enums_abi.autogen.h   |   5 +-
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c      | 182 +++++++
 tools/testing/selftests/sched_ext/kick.c          | 617 ++++++++++++++++++++++
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c |  56 +-
 tools/testing/selftests/sched_ext/nohz_tick.c     | 249 ++++++++-
 14 files changed, 1282 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/kick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/kick.c
