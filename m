Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCE3EDE78
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385534; cv=fail; b=oVyZ4KLsftERf+9PXRMjPo8/6iLAHTBrgx6J07X4qOoyxzKDCJwq3WtYkkQz1mfB7nuMgSJx8DEWew/omWVqgsXA2dKacewFyI5+ZbPcU6epMp/eQ6+bB5WH3n/3+9QtiG5xSdCgoI+VHrYs40yDn6xPJLvodNy3W+1gK5ppkOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385534; c=relaxed/simple;
	bh=+RzOlF6SOKNvz9L87WHC0dBJ9mvzXSO6pQ2FEreEk1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EIBHil3adqoYWPsHizBa7RV2Xst5Zwjg0NqS0bEoNKXlD3IJAzqntYSmVXdVS3GNvQ0GhAxVWOPnfqrVPrfioeyGi/ifaex7qfhGVSpQCGjuNQB/0/WsxuIguwfQSgwr5xonW0xOyGxUuzbxFyrAy1lox1TiKjNweeuVP0fykto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lln+HLe6; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lln+HLe6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afaxwt7qMgqXPSBj3Adq6mGH/Ph+Oa+vuj+OL7c8Tn8oJLM+4rBzp5DNMCkM70ZgVm0nKsW2hPqCE/FNW1hIrWcczsgUi+FM7/CPATyM1IDZBCCNfdF6OQr3pfgrUA6arWskJCLHT/p4pQlrMHpYpsIXBRXJSNzn+emuoJ4wkQwmXKAvKeub4k7Rc8Dk4987oBd28QjBBI2u8ZXA+Zy716FnwbkilZQqCmnDCo5ZJ4OHyyR6NQcPmoIUrYF8cLyI5SPjbssEUybt7lC4zgX22/A91wgI21nN0V3TH/6gCHbyxFjfPPMTWiFyocLZAeb+VZuypVa1FL7WzyudiQDpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoyX6Cw2LOj25W/rn57vnRtKvyy7t0SE6nere1Fjy9Q=;
 b=LaPvq2/qQocAxpAjE4dvXDogDTI1Ry2C06/mTN77ZX/X774R3bwahoZTiBmYYmUJAIPWrvrMT+bgOCa5E82uLBwY9QAb7ALtB48AV2An0NI8i4tUqsFoQMtIlviATx/KciHwZgc3/W14tVflrFdonZuguIP+2+BY/O+CR2CVUSsWmRYb2Jcp7mzZ1L3G3UDfpcWUCB/y2DEml1urh/XNMoqEP1FpG2UqaQyBTL3r8kGXXL/51+3EnRYORj10G8V/7IVLURuqC+YfVWpKxIjjMfUOZstKNvkLB4WtfY3YEspkN78Hbr8R8f4ZSdLQ2Z4fTNqLQamYqBjPTpc5egESlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoyX6Cw2LOj25W/rn57vnRtKvyy7t0SE6nere1Fjy9Q=;
 b=Lln+HLe6LYEhwvrv2xxQHqVwppCKbgJlvBnfUSZG8ord8AHNuBdvjxNdzpfulpzxpY2hLhjY9nZMLSPMiJYkpr+KTyMHn65PKKbhaUOZQyXkxEKHqEI7CASXKomd+VzFjkHxJURGZhd+LLwy+Y0tU5ODEbrwrKw57PoJAREAT7C0rD67nTv4EM/YEd+FfTkkTM9VhY7o8IjTE/K7pTv+B1+6DGlVUSr3kAOstSrgy3U2Cdo9GaU2XTDyfNZdKxPyZLorkanX9PNBa1aJAGLpZFkFO4TNrOFCLAhy6wMzg1bN9TTNAYr2fAxHuippHeUmO30x1L5w3jFmsh/uxCNQ8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 17:45:28 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:45:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>,
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.2] sched_ext: Auto-manage ext/fair dl_server bandwidth
Date: Thu, 21 May 2026 19:33:55 +0200
Message-ID: <20260521174509.1534623-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008C7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::429) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 39950318-3796-4cda-ca33-08deb760bf15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|5023799004|6133799003|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	unNFgf4qOfgSmdrSKEqgiVyp+n5ZlBIA54g5M5zdjMHto126eytsEZ0eDIsSOj+2uMPzc0lOdP2y0K9ClQFVB1a1aT6uRRtuUqxss/u1RVX/2j3bN0iK0f81y0qyRUs/aZgOJ9Jt21PGRlm819Tm2kVWJcg7LprcYiNp3VuRBE6OWzhM9cUvmMWSwgeDfw8KJc9reyksg5DLlu6tL69RiNYuLZkIhe+NlLq3YM77E8MZAl6AGJIn3R/AL2QVvDYQ4XV/uwk5eg4gwwNLlFia9jLZOiFJhhnWHEwTw6gKMBNGqIBE0L+SQBTOaQhQlwqlr1SZKV5ThtfBHHTBBtr3amWMjFOy6DOUd+vbMKIOrIqWTiACOBkwcuoZmVLoVKdc+fdQEVGw9fjNVYQFns9M2yP8jQIFKM5B+hNtZ13oYirq+cZciW67E1p2GMdc7bXqMmLoEQ8JR2QyVzZZDOqm3W8vmMkZ1kXxMdPCGVSwjr3kibnDMYHSWzwaL8NvQ5dStpcRrAydTHj8q1kvMtCzdg8vNK3a48A0d8+VIzAatbW+Czh8JbBZpTQ2vYCMo3zAb8JveCK1s/vyw2DWov+8NNIHRExnUXNQA+7R3o7D/oyRAZMn5rf9at2bdkyQ2bWVdcaXwmA1mBbeO+UJybGBgdiRYC4GV0yzZQkoicBs+jwBAHr2tYC2uPo8Mu4pH5M/x3/5f/Z8L6H3ZZ0415dMzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(5023799004)(6133799003)(11063799006)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6/XtSceU37TkGGyGRoD3u+np0zF1JQrvVPKZjFarucPBVngPX1flo8rSUiFw?=
 =?us-ascii?Q?08tBNdOlSL2U7b9NCJT9+RlpJkKL2Y1yu0u0MwmMETeM51zdv5vYgUMfPGOq?=
 =?us-ascii?Q?r0FKQ1zYP4R2L8HxbEWbSsFSEqs9lxTUGkaDyUnYppOgB149OTw0sGMpr0vw?=
 =?us-ascii?Q?YF7J2nqsAMhXDPxsiKSeKTkYyzfGlUlRJAsNurlvnSgQ+qxE8LzbChkb2f+Z?=
 =?us-ascii?Q?jpxjRQY+zDmksP9Bb6kitBN7ebI2M3EdEej1esbw1qCqn+kLdq8q+IlwxXAe?=
 =?us-ascii?Q?h3HS0xHg7Rw+36Wz38XK7+BUuXHlifMcN6EMOdkD24vHHKJLQkDQr8RGxO++?=
 =?us-ascii?Q?mUbVexKihH5OKTv7+NHFtKnSstlda2HXQae24QFPUtwJ7m/x7AnIsyoo5p2L?=
 =?us-ascii?Q?XfYMQhgu+f8/KtXvSOjMFgv6J8POW/fQCSpmyD25dpBq5VwI9m+ndbIGJoZd?=
 =?us-ascii?Q?jIYoyt7ZlKTV+tNcUw8bA66uFo9VgAne1/6i++WyXiPUKqaLv83PbYxZfvLa?=
 =?us-ascii?Q?DYOVnj0sKkRXIRxm+yRAbPX4cQbpAki96HvVn4TRm4AIGtJE0maSxEzLKnx2?=
 =?us-ascii?Q?F/QlivRaKCaN6IRnKJ3H6NJ+qdnMH/wi1Tp7FMVkLhqsHZ1DK5VdjEeTEBMo?=
 =?us-ascii?Q?JJy27kGmd0DDJ4EF26BFEtirattrOsUDw2OjHMEdT97io7KoSqPSFJJfPIxN?=
 =?us-ascii?Q?QMqIlso/JbVmz1E+f/RG+1Iy6gySnitH6rjDUSg5kMHNqqWiikSYOhwytE6R?=
 =?us-ascii?Q?/xcb5dCQ+/9FUYkJSRVQ31uJLHOkT1e5yU2MgOeM87vRCwu8+Zn5BMnXUhO9?=
 =?us-ascii?Q?rskfyk40U8nlvSgtofAxP8HxjUG/Rd7CLJcRx9j/UcSuBb8zydTV1pHJ6+eK?=
 =?us-ascii?Q?r5z8uYcJj4R4LMzMspNjZqH/0TTixlGErpkTrrRW3DwpPiIzhvrbPQikBXBK?=
 =?us-ascii?Q?pNlW6OcJ8NO7E+ZHx1pOh7VXVPXCRV25/lWKq/hPiOMmUv+ud82RQC5D/ngL?=
 =?us-ascii?Q?LVCNKj31z6jb3GjFCAdlxbR9EPWAxQ1wHJOZHFkoEO/YBa4G4r80+zXdwdcB?=
 =?us-ascii?Q?DSPB3/HtMx81wAjvgo1lZnyLSXAHlWkFuS24GIidiXz7eh3qI0BwuHbn95pH?=
 =?us-ascii?Q?dqgsdVlGK19VR6GWrgr4KIQfZuXBPAAsNTDA8xPvQW++zGBaT2Xx+rBZczYI?=
 =?us-ascii?Q?/3w6TYv6RSxtHT3ohbOQrk8Pj19rUZBSB2PZB2DLPhhnO11WjcHpE8Ndk9JC?=
 =?us-ascii?Q?5Xzv7XQtpGHJI5RakatDLSvIRcRFQlHIy5S1C9YISno8nyZQ0qi/4kjJKD0A?=
 =?us-ascii?Q?nw06sPCsBgVxF1+Np6V5/h0nLXJUgQhGEl+ACQPBz89Ctml213y2DroOkYy6?=
 =?us-ascii?Q?ZkR/nG/KUjKiDFvvdLMV4cPRQmTA4F6JL270yX2i9F/W0HwIFgMY4R8jBRh1?=
 =?us-ascii?Q?tfd2Dob9VjlnnBHwxr9SkNN+Cv58xm5ETsng1e4cNLQTCsJQFE4AvZsj0rIc?=
 =?us-ascii?Q?9O+sDecY7yW4OqIrs3o0WXAtFsP0T69W4u5xarXQ844Pf3xWoxFsGIJ5HfTG?=
 =?us-ascii?Q?6PAALgMUNtFd7iKdnaJjSUL+lV8BFqZPdiofAiFpzIkf/kU+WLiykAIFUuU/?=
 =?us-ascii?Q?4uiUIzixwQxEn34cTamzpHn3TjWQX5zBtnVGx4IytgwDpKzgGEGA8hx9PeWR?=
 =?us-ascii?Q?wqnQGspYSQo9TfJIzgQB9TgBpwMML2W5JuZFb/N6UZbbY+eN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39950318-3796-4cda-ca33-08deb760bf15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:45:28.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2MHvPE9AwYYfKQSKuZ47TKmZNcVwM3edeCfQi4gad+KVgadyqJdcji0LvMUTOhuBMUq5t2Taa6HzGqvg71BlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

Currently, a fixed bandwidth is reserved at boot for both the fair and ext
deadline servers, and this reservation remains unchanged unless explicitly
modified via debugfs. As a result, both reservations stay accounted in the root
domain's deadline bandwidth pool, regardless of whether a BPF scheduler is
active.

While unused bandwidth can still be reclaimed at runtime by other classes, this
static reservation prevents RT from fully utilizing available headroom in
situations where either the sched_ext or fair class is guaranteed to be inactive
(for example, when no BPF scheduler is loaded, or when sched_ext runs in full
mode and replaces fair).

As discussed at the VIII OSPM summit in Cambridge [1], a better solution would
be to dynamically register and unregister deadline server bandwidth based on the
active sched_ext state. This allows the kernel to automatically enable bandwidth
accounting only for the scheduling class that is currently active, while
disabling it for inactive ones.

This patch series implements this automatic register/unregister logic. Moreover,
the sched_ext total_bw kselftest is also modified to validate the correct
behavior across the different scheduling configurations and ensure that
bandwidth accounting follows the expected state transitions.

[1] https://retis.santannapisa.it/ospm-summit/

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git dl-server-bw

Andrea Righi (2):
      sched_ext: Auto-register/unregister dl_server reservations
      selftests/sched_ext: Validate dl_server attach/detach in total_bw test

 include/linux/sched.h                        |   6 +
 kernel/sched/deadline.c                      | 109 +++++++++++++++--
 kernel/sched/ext.c                           |  43 +++++++
 kernel/sched/sched.h                         |   2 +
 tools/testing/selftests/sched_ext/total_bw.c | 171 ++++++++++++++++++++++++++-
 5 files changed, 323 insertions(+), 8 deletions(-)
