Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6001A3166
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416994; cv=fail; b=EkYN9Hnf6cJKR8ejJpW3KlBSCGrS4rvgomaK903SBYMhBYVV4ziRIOvWYs4BaM5CWRAJEj7YujBy2iFlXEpdqRz3nFFKgY7f83bmQ1ovOyxCMxG/AFT/dRvSmUOr/GKFLF6kqMEbqGYnG9ImNMgLJs4sKOuHMpdpMpIVWzYoOrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416994; c=relaxed/simple;
	bh=O8vYKjh8wxjNZkGIKDAULwytJmdagElLVk+ts433A/w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G1a9Yf2uX4qySpUE9FWi+h3BwyT1/BfBYnA3NlnPfIiMl4tHq35TRFvQQn6///zKafNFpNl7EacENDprwovHXDsC3uZ8v1I+MsNwdOSRDGS+ydm8AFbPWna7y8yG0uDwU0wcWg/PjbnQiIVPmnXFU8RtfGvAa3iUCLASEnaXyOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XsGtw/In; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XsGtw/In"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQ4t8jylMo48BUgd631zqAA3zx/s4cN+2izUG5kZpSKrYLesZpGtFx9vHxNU7mRNtJVQdotuyeOsbHzoIqitWLFHVAbQmmgUnePxEAe4RtlbEkLqWzN8+9ozv3IgOWvXtF0Dp2d8LacnapoLPdi6PIreCW1YDF4ZUkQwHOx+NuY5SSs29/BiWPGuT9v9PnPyyxHdgjQ1YTRdTr0dBhXg8BJhuPWCb874X4rxDZnQtLo+BgsGk+xzx8n1wE+bxDfwu8BAsw0MxHYFKAEauJqyJtCCzlWk5HTz5VEcexXq3j6kcd5ZgHQSJov34twRLAh/dxzRTE2gdkjf+/toLHDBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKe81DemYkbrQpGCrSyS+CNGGy6e+19LFAofL0H3j3M=;
 b=SQcwv6Sxb9H4jt9L25Cuy1pfqR3cNp6VQO2I1Sx4JqgPYba7dYIbBwBrQe8YkUTmbWZV5V+TjS4EhwVaZuJlBpKLK2pUgU5kG/FomHuySq8Bq+hmFbmHVMDPMUoia6oyfbUS7f76nS/D2q9VuhvVbmv3EXI7yXhMZwz66AgsW6uR0MwqL5Ifj9IuBPxj9zgES00x6QgKzZGX7XkIkE4fGNEyC3SDiR91oz8Q8KttTr7GwwXh0LNoTEw/eB51yvOuWmnQRSeEAOCKwGqlF0ooMxy4NrN6njqTVA/xccE6fxFE0rqVraaF0fjvZmCHYYoeV4yubufGXcckLoVoW4JRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKe81DemYkbrQpGCrSyS+CNGGy6e+19LFAofL0H3j3M=;
 b=XsGtw/InNyaCqnAvd8umZ1qLvM6xJxTOlmxZv6nSpPFSTRhgHPR1ZjwEnSwib8p83Hj17falLLH4Zz5ukBOB0fURnmKg9wQGcZu7RW+LhrutkSBmNop6Ewbd9Y2uqDA1/jDqIsJ5HncB9wv7wCWmoIcG9sRjjmC7bnUzgyNELQLNP4QzDgjUmTm8XXLVxgToErgPjN8NxtDDbP++8wZ+g1TSkCXBWcuX96dLe8KFGZ3RrGZlaUtVLw5jkdGCsCZaypFlKYRQFfLghZeFwJolyPwC1M+sAh9dPjEqYLe68IbSjuSTTsfvUhvWSJ6NT4OyA2AD5wM5ovGR5eMR5dX4mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 26 Jan
 2026 08:43:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 08:43:08 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 sched_ext/for-6.20] sched_ext: Fix ops.dequeue() semantics
Date: Mon, 26 Jan 2026 09:41:48 +0100
Message-ID: <20260126084258.3798129-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1c7ebb-15b3-498d-866e-08de5cb6ee26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IWTVO/RoWd+AEBhgMMg8g8Wkbc0JJPUxx2KWO0mLTyA0KUtOyOD8fx35t/v+?=
 =?us-ascii?Q?8UlCskqeWmvGAkLZ6FQv1wWuyUXDDp+mJy+krn7WSj3banThzMhL4YhRlSzw?=
 =?us-ascii?Q?uC2s452lBNDfDFKefIa7N3k7iha6/YoYoZdgr2oh+9WVAJbKMHW2qrZF40Nq?=
 =?us-ascii?Q?yu3Dr7Ej/mV9nEVZ2iHautxDc7is14VFIQb8HeiY/mzBb6GOL+vVVof8reyZ?=
 =?us-ascii?Q?ltU4YdgggzCwZ9rTUOTfyLOClpP6+9vdDds5/YTb6zMoQQbmMBJ0gmhO+q3l?=
 =?us-ascii?Q?K/mHLHY+X843lDlcwPxTT2DpV8KZXOZs8zrBBSe2YdkuOd5zlHY3pC8lrj65?=
 =?us-ascii?Q?lZ2e3wkTgu9VAWbxe4teQkc8JZ4wiV9z7Q3vmX8oXqKoX/FDGT46Btdeqh3e?=
 =?us-ascii?Q?O8xucuKoYWbwlSjJrg/VCYW3m8DDAH8AIcdcPtM9I96o+PpkzLXRI1O0JtFi?=
 =?us-ascii?Q?MpUe7JVTyHfwU3zGMzmuUIOjyS+hlrHHmYUWpjr25iuwyRrjd6fDv63t/b+f?=
 =?us-ascii?Q?4wmuKOB8Do0MD5JAQcGSn+RZ4aWmzDdPlEH+Aaz64hkpQ76pRJbzurim483r?=
 =?us-ascii?Q?5mOkHuXmL62Fo1DHwFF+YOWg9/TmRu4u3Cbiw+uAWOGDPX3w+bXHCXnaTl3C?=
 =?us-ascii?Q?QrspDKReuiQLhfNqH8dVcGPxPuOs1GsUcK1qHqHOqIGpU+0s0PUZSCWY9Ruu?=
 =?us-ascii?Q?EbEoFiLx/q89gJZg94ewSyy8TT4jEoQNn6pyxXv48ci7xrkiAaf78o2Prhbt?=
 =?us-ascii?Q?RChEaIe2LLFM9D0SjPPNpUWN5AHP5Z5zKg/uVUT0EwaS66i5AkI1C7ZwEi2H?=
 =?us-ascii?Q?j56pvxzJya8Hn6ggayL8nJJvFADpHu5hWdQY+93HUX9GnBpK13iBcO3ctSA9?=
 =?us-ascii?Q?EWHTirgDVo14+dUrxgr2sYSor9ZU4OcauFvwocx3arPrBBHS9h0UivJqcVq/?=
 =?us-ascii?Q?N/Z+VbpGpbRNfXx7DNwd6Exw65K8AJeTfxA/WCuyki3+Jfadsf6bgYcHjWvt?=
 =?us-ascii?Q?+bLxy2/t9O/wl+HHmzUss+WptCHYjvCVupJMHnvO/u8CuGBl01U68+wen8G8?=
 =?us-ascii?Q?uXC7bpyK3rjikCBAQ5XL2J8vSuWmnqjZPWOE3nsooVtPfcv9pFQN5atzBfdx?=
 =?us-ascii?Q?PqcifttSFJvenvh0Tyhe41x8fl8nQ58gQvt+K06Nc6XgnEyMzZ6u0aELkrwQ?=
 =?us-ascii?Q?BM89i0gg9WCzmG7xxvRy08KfeHnCXISPNhDvgCze1lygiZwPwiOXEhAcCdes?=
 =?us-ascii?Q?jdbKd47gKwyk8JuNH8p/fxVmKHgtAGfDTdV5lkQ+e2pr3pyG8FxYv1u4QiOt?=
 =?us-ascii?Q?Vb2yaoxgxytQf3nECm+95IKe/8RjpD6pYzwz+vHzof1xN7gS3+7erMb3FRNg?=
 =?us-ascii?Q?IRixKdcrFg80e1yJCzTC8orlVuCOgN8+EaIdd2a+HLfgPd20C0aAe4vqR9Cp?=
 =?us-ascii?Q?34O8qZNY0pbupuga+TFnF7icXokm4jm8Sipt8BRluYexoKe5UGsd2G9HapCb?=
 =?us-ascii?Q?40usfWJzc2GsF3LFx1TjDLe9ZvdxqVoLx64As7fFKLD9qMEgggZhlnqYh9zS?=
 =?us-ascii?Q?HxGFUyqtxudkzHzhOUECfE58ZZ++zEYMdj2CtrjJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HYa0gbCMgu1CftCaEi/fqHHxVLAwoIJxYcF5b6xtmbmLxGT4DtlmcEL6hZIC?=
 =?us-ascii?Q?UlW+Gt7NTBD2bb8xq5H5m2G24zmat5ayKQcZhUnsewjIABy4c/jNQy5joKXk?=
 =?us-ascii?Q?ym9PDXWS2ptk7+hQ7jzM68o6wt8+9qmi9AV3SWCeFt1d2p9ravlxoux2FLzH?=
 =?us-ascii?Q?5lilFp7vZUY2paTERwCAuSu/f76j6A+O1MpBZkRNfYiv4x/WIkWKk9W+d/t0?=
 =?us-ascii?Q?G5I3JH+z7kc3NPguAkBfdCgfK0hR2p0QFDpjLGVbhRswArKWRd9KSln9lfOo?=
 =?us-ascii?Q?+UPRTbE5f8Z9ELsAx289OuiRyJlseXinX7rYZudxaw4Ew0I/cjYwrgIx6pWV?=
 =?us-ascii?Q?hl6rtfqlQ4urBZMc4P3t3R1MkcXLXBLdC6k/2xajlJGqC/RquIuH2U4ahCoM?=
 =?us-ascii?Q?cF6qs1DQKzJTfSfWTqTa7lPN6lKJydzPTvINCM/VsezQtlOZdNdAmQwkulOk?=
 =?us-ascii?Q?7NVXk3J3Vc7S48tqsfy1rSLEtpdg6KAdryjnUa4rusokBPbeSoSysnTF/3U+?=
 =?us-ascii?Q?iwXAVm0/mphIjxc6WZmMkl6/0iA5hvVKZVpQWI6mW6H4vkl5YRdh2zhOSIlG?=
 =?us-ascii?Q?8p3RYIi1OW4cqq1su7GCuwXyGeClZCtVlVybnaxCK+vZJh+Iky9a96jfC+WR?=
 =?us-ascii?Q?lZwE3YNCHT+PijxEIIsDKSmCk+H2ztwxbzBL+XqQ3fyjdaeuSMeIAynmgmpm?=
 =?us-ascii?Q?8TVe5GAq5VzqF4N1zwpBEdURUYdXNF44B+D4LyOifearLm/hEARfDmS9xqGG?=
 =?us-ascii?Q?VUJvSYSgnzME/kLhwEfPImF/cSX1UAuL67rAsRcV/XKRpW7D8+vu4wRv3BKm?=
 =?us-ascii?Q?BIeHn3bcicEYsFjHRldFDsPLcCFJgV0+O9/F8C8qfAIlD32w/Z/uB2VPVHV0?=
 =?us-ascii?Q?1sF576+kgQdigOSWeRew4BaVBwljF6fR9cqw7TtCOe3sGMaoyUY4WU1xuza5?=
 =?us-ascii?Q?rR5DV9MHytWuBIhc0K60DQT9vGVvrVZ2iY/An+qUBnPCPZEgB/tre1JTkDMZ?=
 =?us-ascii?Q?WgGzzKvByROqjbaVgvp9A5k/qwlbKjPQuJC6MuiM0e0zptNUzhgUnTVtM0u7?=
 =?us-ascii?Q?CRvBGffe9Q+T4HiYHwMcEp1sVyP42Z86RyMxzrKe1lQ+++onVP7j3v7SL4Y3?=
 =?us-ascii?Q?sq1GjQ5FJB+qHJ/+P3wMRccVGbN7dnZg+o8etcon/eepkF4GXKz6wz73sEBd?=
 =?us-ascii?Q?kuVb7lP8X3bSUrT9pxM3I2F56dVUExGl+ImqxDQm6t6EZZ7wyr6geE6sV6aO?=
 =?us-ascii?Q?+GyjJJv0E+Rq18qvUeM/oFlBX4KxFvhbImgmagNSR4i7kg2XFM0tJWhRWZW3?=
 =?us-ascii?Q?qQ6O3BAdB67WsGQp6VM8tcF3hoZL7KUyRLoPYE2EFxYqz+IftIrpqiSz25q5?=
 =?us-ascii?Q?0IPyDcYn5uO4cv9i/aimHG++TGnQssEqeD1Ia1aYm9QiXZqGHWO5e4oDsf+x?=
 =?us-ascii?Q?oEFlj+WjptKqyT7MkNVZcCMGZ0z8i3S92v7qWCjgwh6vWuzewxwDC6oE9Wct?=
 =?us-ascii?Q?R/zXJtAEYZLyLTOBEvscG7E3leSsKiwi37iYnMEzM1zLt31dEatAwn68+p6Z?=
 =?us-ascii?Q?b8L3OBEkhO6NfsemJ5kQsYxX6mxUQAZjmxAfiMzPLoijunO3p/DKuaT9mmvz?=
 =?us-ascii?Q?8xfEEnc0Gl8vvqNdO1DF8JE0tknTV6VW+2AEyYOSF2ggHpFx2gEpTxB4ruxt?=
 =?us-ascii?Q?gwSwbQX6JZf+V8ZtRWQf+CEqaUzRtJINa6DOPBMljyLpwUc9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1c7ebb-15b3-498d-866e-08de5cb6ee26
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 08:43:08.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ey6Zo1b9Y3lKhy4MAhTkebDa3430qXeMilDg46e0hQOg7imuPDIy9JJrH1XRmzNPERpOcrwjpkfb3WVirub5NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

The callback ops.dequeue() is provided to let BPF schedulers observe when a
task leaves the scheduler, either because it is dispatched or due to a task
property change. However, this callback is currently unreliable and not
invoked systematically, which can result in missed ops.dequeue() events.

In particular, once a task is removed from the scheduler (whether for
dispatch or due to a property change) the BPF scheduler loses visibility of
the task and the sched_ext core may not always trigger ops.dequeue().

This breaks accurate accounting (i.e., per-DSQ queued runtime sums) and
prevents reliable tracking of task lifecycle transitions.

This patch set fixes the semantics of ops.dequeue(), ensuring that every
ops.enqueue() is balanced by a corresponding ops.dequeue() invocation. In
addition, ops.dequeue() is now properly invoked when tasks are removed from
the sched_ext class, such as on task property changes.

To distinguish between a "regular" dequeue and a property change dequeue a
new dequeue flag is introduced: %SCX_DEQ_SCHED_CHANGE. BPF schedulers can
use this flag to distinguish between regular dispatch dequeues
(%SCX_DEQ_SCHED_CHANGE unset) and property change dequeues
(%SCX_DEQ_SCHED_CHANGE set).

Together, these changes allow BPF schedulers to reliably track task
ownership and maintain accurate accounting.

Changes in v3:
 - Rename SCX_DEQ_ASYNC to SCX_DEQ_SCHED_CHANGE
 - Handle core-sched dequeues (Kuba)
 - Link to v2: https://lore.kernel.org/all/20260121123118.964704-1-arighi@nvidia.com/

Changes in v2:
 - Distinguish between "dispatch" dequeues and "property change" dequeues
   (flag SCX_DEQ_ASYNC)
 - Link to v1: https://lore.kernel.org/all/20251219224450.2537941-1-arighi@nvidia.com

Andrea Righi (2):
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics

 Documentation/scheduler/sched-ext.rst           |  33 ++++
 include/linux/sched/ext.h                       |  11 ++
 kernel/sched/ext.c                              |  89 +++++++++-
 kernel/sched/ext_internal.h                     |   7 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 209 ++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 182 +++++++++++++++++++++
 10 files changed, 534 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
