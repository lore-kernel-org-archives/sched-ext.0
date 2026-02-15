Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83223D7DE
	for <sched-ext@lists.linux.dev>; Sun, 15 Feb 2026 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771183192; cv=fail; b=pLe7DFGmDAISSdBwj7LvpeFsSdZI031VCsBIbmcI6lH2n6KdynFvLOERibJAO5XLTrRvqyL00GrQldFWH0U3zJgfOsjCgxuZlhT8oxoi4MH6NScCRDUHcF4xIalK6+fpQAJ5YUu8BMMKNPlz/1ljzjPaYcuotjmmtpL4VF83A+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771183192; c=relaxed/simple;
	bh=Ne61se2pcwlxUR7kI6R/chCJa0dUZxxvRIhFcdFfOKo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a1nuMFtqPR+05yeONp/1GI+hpNz9cTiyzH1/7LrcnV/rq0SGO2Lwr8dlBqvx03+SVSU85Tgbe1bJxq7YeHLIt51AryGzDa0dm/eFfDSKlJIyOK2YTCqZXD5CfgX98xFr6K+N8U4BmFfcSWFxzyCSGIw0mvFEHBQYEPxTJ4kM/QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i4eCm/Mb; arc=fail smtp.client-ip=40.107.200.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i4eCm/Mb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sD5AJrKgaYb3n5/HLAAaT6VKdPUXicj/VbokA5f3Wowu0mklGSDhpy+YGmeNr/wIAM2QjIQz1/uahlPrBtY3TnWzVANsgr+azQsdblR9IXyiDg5Zel5canNxtCrhBF+0T5m0d9oMf/W+c5veX6AgfB6wmZr+y+AGPzpUe80jmerKRjnQDUM+oYGSiKzCnoSw0jvLyjxXaFWgcmzCOeKlMu5HOkXeADgPEB3I9K/s9FKgQ4Zkm8+vg4qMkc5IQFbEg+HnxGZ613sQ5MmWfAluO0GpHd/4UtLObbCFLSSUNQT8JJnLDyyu6g9BOc2GSZZ46P2wrXYR1cwSw4ZrUmCNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z93qOUpNhEWL2VrY2ornhv51VobM0X1EtL8TrdNRzQM=;
 b=h6fmaZWU3qclQ4aCNIN+ZFBFvODiWS+4wd9SsOPagd3nMzjnrqBWEPYdlaV+nQp/m/v7T3fn+el+7my4li4BmZC7D7GiwvXWzLZya5YR5zexrVrHc8TKTEBX7LAo58BBKI2LRSLymisexJTluysDPMbD7vrlyv196pgHotNMCB3qHsPB7jek2pDzy/RnT+ms2lcVvrOAvOa9Qqhq5WDtoCv0vZwm2Zekqqnt6UmRZ37hYpVVfpl8L/sDZ5cQde563RfvoFN+78GVHo0QH04iOSgiuuPa7TxRidqz+2eifl9svjoYS2IdqBj78PS3aLVHmcuZodVAAjItMbO7nJ36cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z93qOUpNhEWL2VrY2ornhv51VobM0X1EtL8TrdNRzQM=;
 b=i4eCm/MbpQYU7LppV3WKT7jDO/GwDO1Mj19d4XGcx95FTnXT6Oje2HFw83kTTPrAWjvIJ/lTb7JQxT3JjfbI9l8UBWBIcMkS1DkuKGPKBVhHH4L0vJn7ZlxRCh7wDHmwlTRaYTMg4UI2zHLdxwpp2cx84LM3Ep1DBI6pJK/60uQCM4L4SlZQfUXOexOJLJK91cs2xa3u41M8pXfUlc83ugvIc0RBwCpK4LE0vZljcU6fcDzOrP9dgJA/WTrg2ps+AwUvSvUazP+RB9siBiZ40f1830gcIWAfswnPXjQOVfN0Y0HnrBXsmoXaN1wAqnShTMYUgmpWNSudcZFiUG1UnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 19:19:43 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 19:19:43 +0000
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
Subject: [PATCHSET v9] sched_ext: Fix ops.dequeue() semantics
Date: Sun, 15 Feb 2026 20:16:52 +0100
Message-ID: <20260215191933.2358161-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: f6348dd9-eecd-4c1f-8d1e-08de6cc72bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22o+ioAtxKWscCJEFRzZvPd4QNKQ1QaVkbF/9W0YDmdcnX7jjH89kAU0hFMB?=
 =?us-ascii?Q?jqQCsLxWxcJ1SD8T+C8Tzsa1r4K713mMsbr8gTvahH9J5zZjy+7b5Oa+rVpE?=
 =?us-ascii?Q?2X+WHThN1nSHSQcOb2eUx4o2Q3b8BkC+p2H3+jeCXB8BINmP6YkHy/Zq7wYx?=
 =?us-ascii?Q?tVMrOyF6WrTruOhZR9obrXcjtHOuWGMoHK5bvLBxWc/zJK6TqWr8uMWUo21o?=
 =?us-ascii?Q?z7RSO07aiWo3fWAG4VNy+DE1E7uV63n21iYFnQ3gAQ1kTw5Io/+BJp0WnFYH?=
 =?us-ascii?Q?woMTYQymyqFts1qXi3uipXpxzsL0KC9vsSKpN3e7Nh22wUbFmHyEwPetzjxS?=
 =?us-ascii?Q?BwlwoF4A392CcZU4FywhmflRKYziBuXxeF/AgZdDoB7NkD4bLtJbIq4crVIP?=
 =?us-ascii?Q?mGNQp+0o2vlM/c9Nm+G5P0h41WxQ1zTlAgvO0/90V/Z+/c7hiHEf1AYpD3UU?=
 =?us-ascii?Q?TRRE1vMsWrSSi5FrzzoX3fTibHlHrBpCgn+Qyi+ANM/yI13Hv3HphafZPTj7?=
 =?us-ascii?Q?gXwxWNFfv3l0oNQ0PUeZg1GIVUT5SEac18u641vMArt+aTcPloguDwjE6bj6?=
 =?us-ascii?Q?4RTyNZVNuNK7kJh2r1uaDzIQiJBBxn2zQnN0GrUEh908J4uhvcfx8612ClIl?=
 =?us-ascii?Q?mHirdXsHIgV6enheZcgITf6QB6EYwpXJVkn4RboziuCD9Ba06Jmypj/1cGFB?=
 =?us-ascii?Q?1WPsxpb3bX2S7PViwcvzEN6pCV8PR5MxzsIAgZSAwG/8qovg12k8OAcmA4l0?=
 =?us-ascii?Q?jqrDtQ626MuA9Go6YPnZB9DTr/SUsTr/L/J+cxRcJkItRa1uiZPEDIEGFxVF?=
 =?us-ascii?Q?NTqg6mjK4Rzjlo3/338GlTLG/+q81Ah5kBOmlI/Gd2cogGViquk0fQQgNSvC?=
 =?us-ascii?Q?pOWIPhnePq3SDwf4kIDWb1dqtK3MvUwx+8jTcq3p+WQAcKRTcRULcyVQNizP?=
 =?us-ascii?Q?kOAKgHKvVSIqK7LZQRHwr29/pEmDMlTS2tMGA2wbMmoSCRtBtoIBZJXVS/UV?=
 =?us-ascii?Q?Cm30SlYBbgHLjUEhp62p0MUJKcKwso0J6k910KdgEuxMX3vXYds8RQJ7UEzd?=
 =?us-ascii?Q?iMALZii2AQ4CsMtOtm3qDP75f9qVAN75EL9F2ArqEgekLNMKNrkbOAMiTHOe?=
 =?us-ascii?Q?IslJB4u3FAaGkPxJS9dY1xtbaLgIUJp2sB1JOcHRzDXNMaClxBdjTWEVrwH5?=
 =?us-ascii?Q?8QxDDsqOfFrBOoyR8DtH6FNqQKuq+peviQCAJjKXx9iuJ1hdBuwuPfiPQZDz?=
 =?us-ascii?Q?aUQMU9Sio/gP+TcQbewIn9kMOPvyS+6bLSOFDEb2lpBdsGIdoNbV7HmwJ9cB?=
 =?us-ascii?Q?oafGj/4ckV/wgA0pPw+u+zeDEAdvQ2CaZjJcT8eSePPU6K1ri6ivwvO43M7W?=
 =?us-ascii?Q?Gmc3op7GS2LMY05KfoEWCcXImJj4jM2QobYlkcOI2Sr1ErBTFAk1gJzan22Z?=
 =?us-ascii?Q?21+NI0utJMF57kPmRNvn4X7+lNLd8urDhCqiBI4zH5U9ZZ4Pu+5ARZs1W2Kq?=
 =?us-ascii?Q?Fk8dnFj3ZFSbKZ6eX980Q/lEYbYotH6Ei+5f5c2CWnl0QvjUhpibHYAYKnbE?=
 =?us-ascii?Q?KQPLVuIs0FznHsVifiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74hkg3SZvUtm/gWd0QBJHiS+EJhkdS8nxcXMTRxkfHztVBO9JHYN5HxFaQ0g?=
 =?us-ascii?Q?QrtYByXMjb970Y1QmsoBEmNxJa0O1FET/+168i993nm7DwYWKjgkwoX5a99+?=
 =?us-ascii?Q?Aj/lFKEA1pAC1e77jSWGTiLbdLBdtXnN7naxVx7T1aWIoFbN9+dDjYLL1hx8?=
 =?us-ascii?Q?xo5q800WokMBhFX1EIHfb04pDlw5PO+qz3C6lrjhWxLUceyae0jEm7nZ+hxr?=
 =?us-ascii?Q?9PR+8r/K8cNC2YpYYRDhbRXNJdK/SkumtO/QRQ00gmFM/cz/hhV8ZHmJZpjN?=
 =?us-ascii?Q?burgE/GdS8LJJzOFbDlPU+jP5LW+/55u5JYqPaHKx1jgHS8uVL2ovGDnZrt+?=
 =?us-ascii?Q?jLKVuXxidpZsyxRXaXegDS4tdqpw05LeVItFcA2Kj27rxKwcYwI/0Zi8oofp?=
 =?us-ascii?Q?lb0PxSIP14hNu49KijWr7Owh3BQdGYGjhCtmkHM2wdT3BAFqXML7bmknIAsp?=
 =?us-ascii?Q?u9DuslO3QfFX1zsl5hpL78iX5q0eOelYReC1hilQsaZN+C3Pn7qI8NfYf1hC?=
 =?us-ascii?Q?4S+Em5emGeuiRXeoDTI67K/lWji/8FO6EUvM4Brg2x5YAXoPrEPcLKF9yC/4?=
 =?us-ascii?Q?uPJHIMT6Ug04qo2S1Oto8Q4xEAjpOoFng9qKqFitUxoB9yGSG6nJK+6lQmCn?=
 =?us-ascii?Q?bi6zaf20XeYbUOzU17En2XLkwo1NI8wzluEwyqwrzLJ4w1yd0ONiiRXi08Sp?=
 =?us-ascii?Q?QM9cpsdv1oHaSH0/32ODM6ouAqxLpm+37HnzqZQTo+rMPdDWq4Hfn38ZYOaH?=
 =?us-ascii?Q?/ptHbyG94b+qgLEjZxGfe7asVZlpE+4TucB012O6o8n2sFBnaEsIOdBToPxH?=
 =?us-ascii?Q?P9lS9fyBlFKRlXt3DcXEIpbAfxqWfs51fpVSkIhuPckbqex6h3evN6zCo+wR?=
 =?us-ascii?Q?ACNcswnSaLP5oBiFO0GLrzNTy5CGh+jbvHpAjFkB6ax8ioWZwWEd6oOUN1zG?=
 =?us-ascii?Q?nj22CzdnR1Vx/PMwdnbJ9lWQNSzGRQfhFbze/JNmEw7qzFBXOrjbiCdQvV3w?=
 =?us-ascii?Q?i9WOcWwzLI/yqi1MyTUL46/aiEoS1HLCPq1D4aWFfFDZBqlDUGajvUIDvFwa?=
 =?us-ascii?Q?YuzaQ05JxjZ/nbYjpkkOUoBjWEAhBTs6E0aVD138w1MSIWrLaW0nS8yeodZB?=
 =?us-ascii?Q?RxUnU0OGGSegr/TYHZbnRWuM6CPx3rqkXEsWk7K5cfKtXaUZKXhKURDv1qlE?=
 =?us-ascii?Q?5g7xJCC9sFwwX/H6lyftwsvCdLo5q34BX4h4EHjkcVHIkHT5gv8cmzkfz/F4?=
 =?us-ascii?Q?UkU6t/ojGc0/L11B+cepdEuEY19qz9RrDz5cf86sYDcqfXwUo2JyHRcoSjW6?=
 =?us-ascii?Q?fhJkBLX63sVfrEEaFywj5BPOKw+a1YR7lTnFw8kUuYd083dCnoraNZrxb68j?=
 =?us-ascii?Q?4HKv/aEOpVej51Oo5JStkG9FC4xPaZdKs+D/9C4URPqKJJ9urJ/dIFxaCKDf?=
 =?us-ascii?Q?oCIaRTXho0yFyF2PUXlVZmmB6Ijh/cxp0WbJS+TqP0jdMnqRolKCUpYy4cDo?=
 =?us-ascii?Q?LaPrBBGgmpt4bhJddOfKWtzXOXZotAgLkfS/dbKYZObi+Ygo5c4eAGLvrC5j?=
 =?us-ascii?Q?RSb6B3ZQmZU9/2hWNNCVFj7DoK+mwSIZIKNZ2GvmXm0XcQrtj1Irl2zUhe2s?=
 =?us-ascii?Q?eC8KaSvAuK8nl98VuFx8Gfzucu0oATVtnMVllWpH+IqwrGJii6KW7OrCdWEj?=
 =?us-ascii?Q?ksu0+C0HWDB2i+8ItG8u6ud6e0e6P/tBF7lffDD/icVt1dnK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6348dd9-eecd-4c1f-8d1e-08de6cc72bf6
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 19:19:42.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Loj71C4j10YezlV/8hPJXNJdSCu1THNpsoVsXDb9V5UFSrYZFu2ip07gLW8jD7+caD7KAb9tOB92uh7Lr6etLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

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
property change (e.g., sched_setaffinity(), sched_setscheduler(),
set_user_nice(), NUMA balancing, etc.).

To identify property change dequeues a new ops.dequeue() flag is
introduced: %SCX_DEQ_SCHED_CHANGE.

Together, these changes allow BPF schedulers to reliably track task
ownership and maintain accurate accounting.

Changes in v9:
 - Ignore internal SCX migrations: do not notify BPF schedulers for
   internal enqueue/dequeue events
 - Use sticky_cpu to determine when a task is undergoing an internal
   SCX migration
 - Trigger ops.dequeue() consistently from ops_dequeue() or when directly
   dispatching to terminal DSQs
 - Add preliminary patches to refactor dispatch_enqueue() and properly mark
   internal migrations using sticky_cpu
 - Link to v8:
   https://lore.kernel.org/all/20260210212813.796548-1-arighi@nvidia.com

Changes in v8:
 - Rename SCX_TASK_NEED_DEQ -> SCX_TASK_IN_CUSTODY and set/clear this flag
   also when ops.dequeue() is not implemented (can be used for other
   purposes in the future)
 - Clarify ops.select_cpu() behavior: dispatch to terminal DSQs doesn't
   trigger ops.dequeue(), dispatch to user DSQs triggers ops.dequeue(),
   store to BPF-internal data structure is discouraged
 - Link to v7:
   https://lore.kernel.org/all/20260206135742.2339918-1-arighi@nvidia.com

Changes in v7:
 - Handle tasks stored to BPF internal data structures (trigger
   ops.dequeue())
 - Add a kselftest scenario with a BPF queue to verify ops.dequeue()
   behavior with tasks stored in internal BPF data structures
 - Link to v6:
   https://lore.kernel.org/all/20260205153304.1996142-1-arighi@nvidia.com

Changes in v6:
 - Rename SCX_TASK_OPS_ENQUEUED -> SCX_TASK_NEED_DSQ
 - Use SCX_DSQ_FLAG_BUILTIN in is_terminal_dsq() to check for all builtin
   DSQs (local, global, bypass)
 - centralize ops.dequeue() logic in dispatch_enqueue()
 - Remove "Property Change Notifications for Running Tasks" section from
   the documentation
 - The kselftest now validates the right behavior both from ops.enqueue()
   and ops.select_cpu()
 - Link to v5: https://lore.kernel.org/all/20260204160710.1475802-1-arighi@nvidia.com

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

Andrea Righi (4):
      sched_ext: Properly mark SCX-internal migrations via sticky_cpu
      sched_ext: Add rq parameter to dispatch_enqueue()
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics

 Documentation/scheduler/sched-ext.rst           |  78 ++++-
 include/linux/sched/ext.h                       |   1 +
 kernel/sched/ext.c                              | 180 ++++++++++--
 kernel/sched/ext_internal.h                     |   7 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 367 ++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 265 +++++++++++++++++
 10 files changed, 874 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
