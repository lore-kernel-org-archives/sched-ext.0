Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC043E8C51
	for <sched-ext@lists.linux.dev>; Thu,  5 Feb 2026 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305601; cv=fail; b=sLGUZUuJYRabPlkXZSEdyHshJDpXIIBvwFwXyESnaf3nIkrqHZWRSRsrI8uz1oOhx8MWY3z5RPDBdBejPPAaj4TQm6amRn5Pic2jjykfHniLCNM9VqAqKZYAtFdDgNBGFWfaIYltC1OkuavAZ9HHahAhOFURJBiJ//1FuDeEJeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305601; c=relaxed/simple;
	bh=Xf+OaHMZNXgpv+h37y4ZjRj7M6UsxFL4S+iRkmRmW2U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QnKrbaE8NhGfIWd2jcF7aAdeYhp73q0maX90popLIrEwwQEzDZ8eaWWBD3MxfaRStEOuDelNmuvDcUKDyfjJpJp9adrga2DyWvOX700BruWP8PjWcEGtwHOs+NnOuysyYOBPagyM9lBJsyv+ZnSungAmNlbAeut4E8NaLEeR4UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CAXisvzm; arc=fail smtp.client-ip=40.107.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CAXisvzm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoWmZ3u8miHxzbeXbeObBkZvzY5ha/bJ7j+jttlwkYSyk6nWDQsyFQsCkTWRRRSzSng+lQoJPID0DMMlSCZSvYlRGIaV68pdA+wQAFgTWoJY8DPgl9todKCpbT+dqgcljJZTrBC6GQL5ZNPyb5aQY3I3gNRdxlfV+kLkFlnAwPt7UYroViLktkbiTQAa/tn80fjQ0rEJQ1CQFxBVffw+t7Ie6v3mSZE8iXWaLuKUYwptccMMxLexnIqM2WDplh3/ORy7KG1VG/quj1hstzQDa9ZF5fUy8cqBfF9N62NHOUytNuHgt5GgY4znhndFXAp2D/dXjg5oT6oPs1tck0Js5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZtPQsZ1a2U6fLNkMU1OdzFUeQy7NaI/zMXbny/VYaw=;
 b=TfOB9DKEeEbPVv9czr0UO3mDrGt+yfj3EsZf/CHFwulmkpsnGsKFMlHH7+Bi+W7YLnHF1RjUSezXpDRE5kwS1kHTTi1qh7jVEd6J3GF6WIbdUrSkhyVjXjTmvrv1m2CLYnHMCb/PZnKkqXfK3HfNV64zDhVz3mh03gHKplefpl+BYGXL5X2ZOuYWoT67NRifnOd/wM1ydggRAv0IOer7cQ7btTVjCYhaUdKomnUaYiOdLNSk/Cn3QGL+c3eyAHoEQDBg+44+n0jEl6NpwPbnrFuW85nvHJEFyO4V2KUz8I5vvgEwSWMCBdMxUUM6g5QeRQ2AFA3YxfGd499boh1w+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZtPQsZ1a2U6fLNkMU1OdzFUeQy7NaI/zMXbny/VYaw=;
 b=CAXisvzmL6ssnDXyA7Zujn+4zWJVaWEwzPNDIR5S6G6+UB6z4dw8a8T9r+ysxvGJnOGCxRRVlQdokXvLiWgmNM43os6FK7rg8wwOGoVYt3xjjxN3R2XonZrsCbD87NWmIeG4uxpRB/I9+8amJPOEugNGCzpCC2VKw8OTcBq5xXV/GyZivcgC2TlOf4uDXOFN0CaZXT7wjwgEBxaDN2gZ16EWw3fqBcNxAkvcliviDxHjlNRY+SdPKaLeN7MLipPp5VD0KKFd8bYR3+ikHnu97yTcduk2R1JloGOeGU/xIimc9Qy0by53d30I9mbBPDxX6yMzJ2gYzps8v8kv6yJFnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 15:33:17 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:33:16 +0000
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
Subject: [PATCHSET v6] sched_ext: Fix ops.dequeue() semantics
Date: Thu,  5 Feb 2026 16:32:14 +0100
Message-ID: <20260205153304.1996142-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::11) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: edde2b45-429a-448d-f579-08de64cbe1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Vl9vuJITy49YC+v9JPXWAVpfsHpWajkW3IRpjXGOZrKST+Lr91dp6i9dByE?=
 =?us-ascii?Q?2xaGnfCkB3b9I2isH8NZCael1M4djK0ZTiOK/hbjfyhB9D4YSyituhT5apz6?=
 =?us-ascii?Q?Jxih9sHWZ603w6DelMyiJnG8J1hR1hYQaLRtip+UZdc1BV7jFr8N/pe86aHx?=
 =?us-ascii?Q?kzVKrTph+KYTZEN+a5uq3GzsL57XQxATgKZNmyzvggzavcBMyT1ES2EuJ1oG?=
 =?us-ascii?Q?BxtxUCiy/Zr2WmcYDKGAVfc/NbUs7NVIWkxIOW906qhi3batIXmQvV2s27oc?=
 =?us-ascii?Q?LOn3QTsL1EPqZUIWSgrz9r4xqPZJQgbxD/0e+LHuzRqucT9Z+cdBdHpsz6oP?=
 =?us-ascii?Q?xEgSDtw9ZYrLJJujXDhIkM7IgvFlSVgihhPLCwmMiRrkq+Pb3KqV+fFEgH/r?=
 =?us-ascii?Q?e2T5rtYqEj38349Eed9lpfhVXq7PZdrsvik5/UEvvbp+I6ijgLJnm3+pzIXK?=
 =?us-ascii?Q?K4TlE9AKYUd4zywLsYqnI8yfwrsgJvMbpAnyUJ8crj1u4o7VuU9+ATjVXuCp?=
 =?us-ascii?Q?8nL3hglSkwakE8WL7dZ3UvlQZRy2NAZyx5sRu50AuNlpWYi51r4OHX1z3eS2?=
 =?us-ascii?Q?mJYtZaDhnnxGYp4BLmVTt0qtF5pp1OQULqUgph6SR0FtHe0r4/Eg7pk7FBDn?=
 =?us-ascii?Q?oRzQ9+uNHastdiO7JLwG1uR5/+RCDcezamUgYYpNeuTyu4aTiqeoT9Ue5VF2?=
 =?us-ascii?Q?dPGSD23/f76DaxOE/m3QbORI9ZvBOcKTIRr5BwkF+bkAyaqK8B75UP5M8K36?=
 =?us-ascii?Q?VCGn+GpIuuVe/LIuSGv8K/E8ws2mf8TE86ljtGG5Gn4XMp1KfAQVWgFJJ2Bm?=
 =?us-ascii?Q?A3KvFirqntWY/aW/sIXQjjnThr9hF7Y6ikczdTp2HmchK8FsnryjCtbOi3Hh?=
 =?us-ascii?Q?qVaMJguhKHRRoKBZi4HlM7aHvrYWqVEsnITg26geMKpcMOJfs9K+zCcMRCu2?=
 =?us-ascii?Q?25NxXQusoHB06NzN0+4igWIJyoNWWmt1dQHD6gNvH8L8HKGySu2Mr3KKdM/3?=
 =?us-ascii?Q?UJ2eSrFPPxjhEbWVv+WePTMmXdB97rUAf0Agp+kplmVild3bZA8REbGT9OiW?=
 =?us-ascii?Q?7Jjf9Exn/LFURH5W53wLrkNM6t7r2XNFDyxABBO+teGBTsxOsUEOBSNJQEVc?=
 =?us-ascii?Q?K7x6nyHRNm2z32UOs1tPxtN0sG3a7pDwQzSFnobnsua6LdXuIghGmxcq7wqV?=
 =?us-ascii?Q?m4aeItv/+C88ce95kCEHOct4rKdMo3vBYRxniqkxwyy8mRC3gO7ZehZwxz+h?=
 =?us-ascii?Q?/2FdoSeut5G83/jdxQzkImJchRNHGA4dwiqQcYFnMQ+n+PxE0l8+xeQSzUUW?=
 =?us-ascii?Q?Zq6BANnfIRwdFmpjMmccsPRknIY1gDWl92ckTsK+cGC5FRX32Hpem6sJ/S8C?=
 =?us-ascii?Q?WbyrhXLEIgbLDlH3iZMZc7cX1cp84/Lzsy89l9kopXBVz6/zuhGMoEkl7u1M?=
 =?us-ascii?Q?s0dVdqf3muE+FZKDVjziPodsQw0IFAuEy4129BrrGCtBUlPa2cW0VrjX4xK6?=
 =?us-ascii?Q?ElLQkN1aLMG+mCzUC7EgUnxjAq44hdrxmTA/k9TwXGOrIRYvC30QyHrBAdkh?=
 =?us-ascii?Q?NRa6Gj86mbn/iYH2SV+Hwf+lGpDXzlYOzFE2AZVB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqYs3AIb4pKLMZOAKBH/YA2YnkuT0qmNVd6djj5Tht5NTdFVXgsCMNQRebub?=
 =?us-ascii?Q?pOi2q4eHQ1h2A0n8cS09KBns16IDs6appn3AKbtnzwz1zhj4hStUpXZb/CvM?=
 =?us-ascii?Q?cY3IanXBW+qxhYw2+iJrbLarMJE4bRxgnJtvxpstskWv1FDQiPqP6eSwcTf0?=
 =?us-ascii?Q?AvuzhsCZKxOF494eZqfAvajZjdn/Yn/lw2JoYOPRo7pn73J7KMftU+HktQJo?=
 =?us-ascii?Q?oKGZ0r2FZO5+ug5mphSIJIR+jgRXgytpqPInjVNqn57F096tmBvMMimqvYtp?=
 =?us-ascii?Q?tZ8heAhZT1/dxCuNgn+WiMYGbonm40KXJP9OmJpvoC7Z/1cydONiSGPtpN/o?=
 =?us-ascii?Q?F2mqliCmnu9l9aEqLZ6jNEz3caXa8bcbWSnLNm3RFZdXbkNK699Fdv6522go?=
 =?us-ascii?Q?Qd8cYqnTBdsCs2T8WaOQP7AEe3ArepxZ61+BLi7FuSmHpNk9DD+ykM5XpN7E?=
 =?us-ascii?Q?GymfaVRMNnuyaF776O+PxE3JH0wYfPqPbEGCJ2YVfNwfslPLVHvPGOtyi2Zd?=
 =?us-ascii?Q?Ge/R3kRf6/nfrrxHMjAQONEQXA5Xgjg2ovkv941a1m94uPH0CEk6wO9mRt1W?=
 =?us-ascii?Q?q7oXaxfTbnvDza9ACwMfNQJh5q8Ckv2xzzSUIUAel0Yuvw9UXNtQ8IvatbFc?=
 =?us-ascii?Q?py/qXyrSRiNy2+drsJTBmQJkpH2Burx/0yk8ZVAJMBoeYxMBGlSsaabZ8Q99?=
 =?us-ascii?Q?LW+15sfPi4P7nC9vxqhgkcznPi28SvIL1NmcEUUCRHdct5DdB0lvC3Y+lFAF?=
 =?us-ascii?Q?gLG7b2pY6170yPZJChBpWf7+8KiAsda6IinVauWD/ryiu6+XnUjjuANGZkmS?=
 =?us-ascii?Q?noAgldU/8LlqZXWtfVAyQm4F1fS4zNccd3giSaJLyLspRWcAzrMocfN+uiZF?=
 =?us-ascii?Q?rliuUzWFIqdv128LUMFxiSjsGSKe7UMKWL6O8qgOcIGBOekXEitF1qso3ygO?=
 =?us-ascii?Q?s9EOsDDrdgm3tu3WaAAo4qzECVUpR6Mh1A1TzUzYi8V9E7r1NZNK2XZ5SC26?=
 =?us-ascii?Q?bRL5gaN68IYcTx13AojGJkq1J0qeX6I/H/p9i+jz7Zn64NA32GukkNCwnp2k?=
 =?us-ascii?Q?ysy8ujoYfGmRy+e/ZusYGlusfTE41sURGr2pnrXHuAPJMvL6cyrrDlweWEIr?=
 =?us-ascii?Q?tiSV1Fl+GdEHWQ4vxN31ThXNTeG4/YQJzbd8a4Ez07rAiUuyIH3r8jOBs5af?=
 =?us-ascii?Q?5038hv9lrVmwGuwjBOhOzl1J1glS76g/+q6KbEvaud4T1+lbtQlgKKxKFYmv?=
 =?us-ascii?Q?JNObGMG2f8gQT0klN5BEEKsmlBYBGPLwoiElrtsYupB5N1hm5DwU78zIhYmR?=
 =?us-ascii?Q?0+1SaOBFkZQDYI7MO+Qo2/pmFWIQoKCfmUzRPK9MYRXueDu+R4frH5S2uASH?=
 =?us-ascii?Q?xrbfwYWO4MhlUZBA3+hLgatzmh6lpDObuUoM/hh/M/bDYrrbdGnU9FFMle01?=
 =?us-ascii?Q?8LndoqrTHXDkX2Bg05pgn+C/MFZBfW7uPhvoJaQhhGdrVxzRGbpkfg6vjOsk?=
 =?us-ascii?Q?fEXy4bUKT3tLXaWC/DHODEaaFViUzLgcFSQ2Q/3Lf8CT8YhMIqXLQnhazq4p?=
 =?us-ascii?Q?MqWkNvNWQVtR/OxvOtVMWtyS/ITZBKxOM9UnK3E7XFQ90YiZP6z2necOkL8k?=
 =?us-ascii?Q?0z0rggtRi/hMUkaj3JCcoE69fRFJwe44U+rQpG+Cuff9gQfxynqXJYqXbtU3?=
 =?us-ascii?Q?adCGJvpAOz+Ag577AgEcABhKvlWIyXB/BFS1c5KOXvYScAkfDtBB2Iz+/lF6?=
 =?us-ascii?Q?oGTFzVYZyA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edde2b45-429a-448d-f579-08de64cbe1b3
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:33:16.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7cs8VNuFRcfGcGoS4xMcMrRH/9ow3HHlXXO1t0hhdkE5pgqvH0J6Xw7ZunkDsnbUChj+Ni5vMmGQUJ08ovPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803

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

Andrea Righi (2):
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics

 Documentation/scheduler/sched-ext.rst           |  53 ++++
 include/linux/sched/ext.h                       |   1 +
 kernel/sched/ext.c                              | 130 ++++++++-
 kernel/sched/ext_internal.h                     |   7 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 334 ++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 222 ++++++++++++++++
 10 files changed, 739 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
