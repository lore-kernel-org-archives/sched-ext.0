Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32013D3485
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813878; cv=fail; b=KD4udeDBa64XhJgD9RTVi7Kj6KJLaiKX2tP5KvhnybbLQLXpQepSTDsfCWR+6YslS5WslSPsFFVlbZWN+0+OPfmvGxodwAv9+ZnW+oD3k99YPHq/+RcvPSYas/yFAMJz2VjlseQu6Lh9cU9qiDafZjKipgIh1VWvPM8IbVU5NaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813878; c=relaxed/simple;
	bh=FB/Me65tcN2tjT3ltpdXl2KK1Y74DPm+U1oo615OGWc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q9ql0ZnpYl7UK3ucd+xf14eToouhGCJYb86+zyeyM7P6ZpTlq8uiqYaRfJrHmsEp869Sjz9qK7jNLxnyfa0RRsbGjd9lIbiJ8GHl9dcUDH81b944WFc+KkpYMTw6815T0+pFI2GIyaJx5eWKIVvGkRO7PnLjdOIlt+Kjzq2Cx+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YmQmqvwk; arc=fail smtp.client-ip=40.93.194.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YmQmqvwk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrUeoS3vD67xHVJnw90md8tgig/3RiYyfzdlFtlLRGQWn/pdSwzyL7ODO+WCn/pvxPPfMJvZ64nSwUccXCjGR5/zySihquH9gdU4SDBREDZh7KuhI2/9W/2+hHeFhqVTNqC0VtqRryLhZfUxGi7nVjBcQ5kFbGGKSIGV/3RLf42EdbM7t3+rhuz/kVSRwHxjGScepMJjy1vt9McaJsTFaSOr6XvFtAcIr3vuWrJ0hJLIyKouOsM94rjJHyWV0Yqf+vlF7KgiewEVn99d7P1IuJGw1NU36mBV+CQqYmfkFtPd1JdzjpGEF1KZohcxqL72Cjf2BWMCDlc4b+G+gKC9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgymNmp+WxK7DM55Sat9aGW3pHHU4moAU5iHZ68Bquo=;
 b=aBiqT9iPHvSZLAkcuqiQfrPjdWaRh2wZ74IHGzsCJdDZmuj8QOeM3ANplnyxrc9MTBgItZB+TqlgAxeseo6w4vRoDak6XkSoWId8jjSyI5iDw4uo8qN8XXDuufN2cVWS3WUjTB2dtBtFoJjCiOOiCKZMiaZaEgBqRyypmGzCtPxZvq3KD29VYktLS1MhigM9id3vonVaIlNgmdIFDsdNMmr0Bs/4mnrclBpzNxj8s/0/sC7W3af6nUJPfeHKiiDjzPV9JkbSZPnBHyUl1mbmiB/w1S+IoMwsLONSS/DtPLjTAIQDQKuLuI4EDGixcqfRftuQX4mJ4j1HLju8JZm2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgymNmp+WxK7DM55Sat9aGW3pHHU4moAU5iHZ68Bquo=;
 b=YmQmqvwkxA5FheTRJbtVjwo3r/bxiAkEsxbPGd1Y/ZNL2LkOYfOoUvfcpakJS/AZ2YqENLPtaveSRydThCBndHDrSFiTXZD7FG8nr/uks+7VA2vpT+qebkm+awlu9Nyy6FC1tyV/V+PmA7sovV/F0WMEkHAcoJAFBGJDz3k0e+AFWCocd2AXLw8P7jnUvJu9WRFRBG/WQDerijpai528Si25M6HVclpWyVXvtjPYNs4h+EnXTM5l+ik+JQM4EkOAlbv9r6Pz/1Jv53Z18NhrH0ElC1xWcBXMCge7PZ0G0iCXpeT/W9w/Xt2WFdAjA94sYxDhGT0Kqpi4hE5de0aoIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 16:44:32 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 16:44:31 +0000
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
Subject: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Auto-manage ext/fair dl_server bandwidth
Date: Tue, 26 May 2026 18:42:47 +0200
Message-ID: <20260526164420.638711-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E99.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::449) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7b4db6-bce1-491e-c084-08debb460f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099006|18002099003|6133799003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZodUKnrvJ0lkj0vBkxekIQFz3S/Kqi8ctZjPPnZYZGuWRmhxMTKkXmH0mt8ABV/zYPon6+07IVp9SCKjgYL8Nw/FdztvoJ2G4TeZkl6afbqNYrwpfpC7fuZODPvZfs+KN+M1VdhfIo3gW1Xu2quPCBU3uSaXEVT28Lwor8OeQ5WfjQ8cq2MI0OzHvNXxjpSoP2/FOW3clMZvQF7YotxFC/0xpemRTFAH2JG33/6v6AbHFdH5H2Ju73J3eIHdwd25N9gyRGhFRQ4oGU4c4TG8w2EBg/YAHX482gEzdo7GjworG/QTOBcLvhaPeqFMZXUgn8rkLz+fgL4hJG6YIbY0norfyFpOGrUT9uC5I9Scqao0ucNZaLd4wWjN8fi/AF3gz2OiNiqKTitmtQ9BAn/3kAH7WXx8qKbFTi7XyZjt4Cn3atzCwwmVmcc9oDuCtzsU/Q90JGyToZrSI6hjs3vyU/t23lRMoUBI+YkvponMKjz7DJHlukl58wIS++0DQjcvYFsvpQeCtKxP5J+poDcgozCBazP+dPupQp+BseK4ttjgGlmukfbdjHTPZvbJdarDEBvGJDb6uyVLmzxCxfTipuRo24dCQuHL+XiwKZPAzrQQv50AghepaOllpCrCx/LDEIsohFZrotY85n+BKIi5gwri0qzVi1CoryTs/Ka92P479UIFaVku9y37x0P3og3F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099006)(18002099003)(6133799003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/YbGl0zPpzWLH9p328CkgG5ZvrYUOBuhk6m9De2ADEESaHycj6Bqz5aJZeNv?=
 =?us-ascii?Q?sMzaM7H4r9jTJIwk0MG4hmyLTfuf9KwGAXF0wpYtdEA/x3dK5fS+sh2P8qld?=
 =?us-ascii?Q?wLbeTGKIbskxFSzRdHZccfx4lg4s93ROpbxDjAnSZClGMUaTrXbJu4WPFxaX?=
 =?us-ascii?Q?wrjWOfwPijJ4vxJLHZ9ccPVE71l6o58+hVbqcDSDagC28v+tmuvRWqWDS1q5?=
 =?us-ascii?Q?IvVNJ9sxNr1XojnnJvTHFvgMyVy+7DCfiAkETkol3cDxzXaN/GsoB37kubtK?=
 =?us-ascii?Q?/3p6cvTvWv2pZHdMScNj9gY8U7JCMl6Aqy2TWBkGSRTB5cb5qhiGDA6XEzcI?=
 =?us-ascii?Q?9TUFPKD5yprSkZ6M/O7fCOFmVcVLyFb9qNe9t82JQVmj11ZXrNTRVZkCYN27?=
 =?us-ascii?Q?PysRbAgk8Ux0/qrKmp3ZHDHvI2Lx9niYkteEJdc07TnKMI7sTfR1bca1KZ6z?=
 =?us-ascii?Q?HXbGlNUI8rWhfSZtkaHpjmJSQzL0FRhubMhPcvdbGTMWxTFLLb7Lynzh3Ay/?=
 =?us-ascii?Q?MK0qro0zre6P+MdzKcFlydKov++7d2FgFZ8AtASkr/0CHzJnjwoYXy02BLp7?=
 =?us-ascii?Q?9WhGPGRG3L5b5/vNHIm8bpH9GnS4+NKGcMS1+mEKQ4WdeYpasPRlI5iqseUF?=
 =?us-ascii?Q?qSpFWw/XVOswIpbgeZkR/B3VDoMpmVnRDf5ltbzWg4HQiUdT7QBmtQZwC+wk?=
 =?us-ascii?Q?qnKhkol9H1qQor0SOA9FwFt9B3DnGoNaMzQsEbfi05Uc6xrVtul1RBO5pk8f?=
 =?us-ascii?Q?9X0O1u8dCBLsRgdJhjwafMKp0GO6rESYt3paIieYK+df01ZbJxpPdgPEFQXT?=
 =?us-ascii?Q?O6/334OgqmHdCCX6B0nqLfSuc+F9ywyLWBi81kvHnXsmjPRA08O+/nb7MCDJ?=
 =?us-ascii?Q?l6O2U4J3pfuZX7IHfro1GINarBRJAWP25OIDh6uL/mfbS9fucrOy74zoaVHF?=
 =?us-ascii?Q?iJl2cmrlXvWlOcyL7boVLDjJ/B/oEXrG4Jub2gQgA7hCvfrmof3u++pFRhJv?=
 =?us-ascii?Q?nZ1T2wQhqKQXqNP+XaDu7JFWy2OT0F+HEbFiyhH/CJ6b8QJKd+ejaRZr2Keu?=
 =?us-ascii?Q?WNzwI2XjC6wWd2hrytqBqbN+gOR4JOwkoV2jyaD5QcDrdlDqpSXp084JGteg?=
 =?us-ascii?Q?Gj9L/xdpUGvnipFmBk8qi9cx/Y3fPyUQ1vdPNFcn1L7J/p8sz6Sc0vl0xZUk?=
 =?us-ascii?Q?WDyxgZr5Mhk0AV+RFnIAab6lDBySLOHbLLAh58YP75p+iHp0iA4aF3RqUNjc?=
 =?us-ascii?Q?6vWwdMmt3+lI6IosGUlj8NgmQp6HCH/3y+1gei2QfF3VP+y04HerBFulRlJY?=
 =?us-ascii?Q?Ts3GSGQZGXQI0m0bmyeTfOZL+TP1HGysix/PRi5R9RtCz+WeMPlIttl0JU9e?=
 =?us-ascii?Q?0eLyFgIXD7rG4dacLN33Aw6O2LQkm4DvrVgUFrqkN9FO/0bqu01fQ0uJ4JIy?=
 =?us-ascii?Q?fKfZEq3bww1GGqmz2/prEtM3/xcYud3dWEAsnpKM2KHFJlib3qqvoiLhopvn?=
 =?us-ascii?Q?DffbwmEpSu1TGvdHmQOX9u2597/hrAAyk1YbdJ+PUhLR/ipcuP9nWWDt8px1?=
 =?us-ascii?Q?8suZK1n4m3mbIFnn/dibpybGBuKza+MooaYLpmpDoiBRT3rrqTYEW6ihjHF0?=
 =?us-ascii?Q?KVZb5+9behs6PkHdr8k+GTtZTySMFSFpEv7YcAHdChudjOkOUnstKcTm+wT9?=
 =?us-ascii?Q?o7ngab2zgzJ2zRDy5HY5aJ2Ab+oiMz44cyMjR49TUahBknc+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7b4db6-bce1-491e-c084-08debb460f6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:44:31.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3cIOrUz84p6e1zAqHNzt4zT3FpOVoQgzPBKFWga/CLpHffxLBPVTBxEaaDgfn3C7QB+xKZLl8NdX9MB5Kmu3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

Currently, a fixed bandwidth is reserved at boot for both the fair and ext
deadline servers, and this reservation remains unchanged unless explicitly
modified via debugfs. As a result, both servers permanently contribute to global
bandwidth accounting, regardless of whether a BPF scheduler is active.

While unused bandwidth can still be reclaimed at runtime by other classes, this
static reservation prevents RT from fully utilizing available headroom in
situations where one of the sched_ext or fair class is guaranteed to be inactive
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

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git dl-server-bw-v3

Changes in v3:
 - Don't bypass __dl_overflow() for detached servers in dl_server_apply_params()
   to reject oversized configs up front (reported by Sashiko)
 - A potential divide-by-zero in dl_server_apply_params() reported by Sashiko
   has been fixed in a separate patch (not introduced by this patch set):
   https://lore.kernel.org/all/20260526100502.575774-1-arighi@nvidia.com/
 - Link to v2: https://lore.kernel.org/all/20260526082954.550958-1-arighi@nvidia.com/

Changes in v2:
 - Rework the sched_ext enable path as suggested by Peter: attach ext_server
   before committing the scheduler switch and fail the enable if admission
   control rejects the reservation; detach fair_server only after a successful
   full-mode switch.
 - Added dl_server_swap_bw() for the disable/recovery path so ext_server detach
   and fair_server reattach happen under the same dl_b->lock, closing the
   window where concurrent SCHED_DEADLINE admission could steal the freed
   bandwidth (reported by Sashiko).
 - Fixed the attach/detach accounting issue reported by Sashiko by updating
   rq->dl.this_bw together with root-domain total_bw, draining active or
   non-contending servers before detach and preventing detached servers from
   starting.
 - Reuse dl_rq_change_utilization() to drain the server, so the detach path goes
   through the same machinery as dl_server_apply_params()
 - Made root-domain accounting honor the same cpu_active() conditions used by
   root-domain rebuilds, while preserving runtime/period updates made while a
   server is detached.
 - Fixed the total_bw selftest issues reported by Sashiko: check fclose()
   errors for debugfs writes, preserve per-CPU fair_server runtime values, and
   restore all CPUs on cleanup even if one write fails.
 - Link to v1: https://lore.kernel.org/all/20260521174509.1534623-1-arighi@nvidia.com/

Andrea Righi (2):
      sched_ext: Auto-register/unregister dl_server reservations
      selftests/sched_ext: Validate dl_server attach/detach in total_bw test

 include/linux/sched.h                        |   6 +
 kernel/sched/deadline.c                      | 204 ++++++++++++++++++++++++++-
 kernel/sched/ext.c                           |  71 ++++++++++
 kernel/sched/sched.h                         |   4 +
 tools/testing/selftests/sched_ext/total_bw.c | 201 +++++++++++++++++++++++++-
 5 files changed, 478 insertions(+), 8 deletions(-)
