Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EDE31B83B
	for <sched-ext@lists.linux.dev>; Sun,  1 Feb 2026 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769937215; cv=fail; b=t7osp+Ug3M+KAtVwO5UvJ0NMAg73HTT9+WURb37Npcs8SMmnbNYYWqKajwAmLS2ebgUm6VQZ/XYNrBHrlHGud7KH3ueYwj7WstVTPgdXMVJBx1rJm3kmuUqUpq/hS9VO61B0t0QwMmWQWnoFJIvWwLSU4RMCkrKuOip0Ng5FQ84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769937215; c=relaxed/simple;
	bh=WaokFygEgiWXsrqgEoJLCErhVP/J83uWOtWUDavuCPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2Fu4neg0UzfeutI0RyHW6Hmy1nX3Vwg9JxVB6EAcwuUzQx79/6aqe6DiV2PKOFV07pYNGJ+iHlDU5q7lPj77brL2iAte8jrlFRM0m/7Bc3g3ob6rouFsz7yAainKTWRPH+4ygnYXNzwGjg9g3i6YUm1iwqhQ4Nch21SDPXgKw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ictnRKbL; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ictnRKbL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7BlfTkgYEOYDU93SwHu7h9l36QceTs73ewBt2jTVfwrwH6trueu9nd5nnAwkGfUT6DFJX4BVD5EOgNKpZl+eh3eTxTnOZHC8DsaSpGB8xtWOZg3kctY6fw24x9asjN1R7DkcB+VOMIqUTKtwaG29UtK8bTqQGyQG5gda0Fv5fU6rWHacL4lRXzAzSJLvU8OmdENEPZRwotIZwU/t+K5OXqzdVZau+9nh9bnB5GVUKjroY/vIom0I5Bp3JagHGTZOhHTyleqsERxgCc54k708ESnFlRnfzB2UxT0NcTgfgaI6I5Ud2HT2Q9XYu9Z/9wkQR9x3ZJ4+ZoUKBQrVgYJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHLE5tvp5/XM+4MCDRvatmUkUrNn7ug35Npd6Yj85Qw=;
 b=lhx4UytaWXjwdlmcurWEs55O4MhkcFRH3bgFmlw/qQN7Mrcceh27Lvn/Gi6avAynFn2BEp7sfhMiiM+m5Gt+14WeHczdJZeuGWcRmOUpw4roR+xlWcaecJY9teJIxXUUkUxQiPB97z2HmO4tvOHJv/XAmcUvOM0Z1atij7zPlOADjJfgqZInKWZH2p5UrOSjgjA0uYuXUE5ATcQP7c946uKT7oQbPByGaIis2TOeU+widWNpHphn1bh7TADtsbiXu6x1zt7XD7wUwYbeVUykBFvMldiztN4lPWTCPhiCa8JXmK33xzKXddEzH6AF/+6wwMuCzPFwrdA6MuHbSpAuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHLE5tvp5/XM+4MCDRvatmUkUrNn7ug35Npd6Yj85Qw=;
 b=ictnRKbLs6K3Pi+S9+06Ywnm99m5xVJ56yrA0cM0yuxhUDdGK7sw381NRKOwv3RlM3LIleoncej0xQEw1Yq9Rai2B0JbhiWRsBrLhNsxz1KYi8QYcig4ken2V6N2K/gvSAotga9Os5+aFi2oIt6y9as0fJwqhY0B9p7jtVlCGUua+gRuGxXoDlX1hwB9O+0hAwSnLQSKKn7lKrIFyt6VaVBgAxzedgL3bb5F92O7nzdUCUmyhEefrB1qcLyAMKO/+sYjczxcD+xC/IrBVp6WPYHbyhnVdEwStYM3o30xUnlnGX9YMq4fwTV8H05D/6nytzDo6zUqzSVsuX5Zxopt/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 09:13:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 09:13:29 +0000
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
Subject: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Date: Sun,  1 Feb 2026 10:08:04 +0100
Message-ID: <20260201091318.178710-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201091318.178710-1-arighi@nvidia.com>
References: <20260201091318.178710-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a731082-5c46-40fc-1701-08de617229bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a7mrLLSVElSBol+hTPh06TlrY7d0MBbKaHA3hCZSMAMzgIwyB25VpVpt8Uv4?=
 =?us-ascii?Q?I9ElU2UHqjBtUu6FBwBgBgeoIf6jzEpPSOYX8VIp/PGuEsCrb2k+dBTpzum+?=
 =?us-ascii?Q?78QtHNNQZe9nQDVP69qFA0OB2euVg449BPf0YR9R05X/ewoWdQA1QJXdqVpQ?=
 =?us-ascii?Q?5EOwMBLy/uA/DIcPCSiiiBwEc5l2HosQMiI5czZYSV1FFIKzrqex6uoUkjXQ?=
 =?us-ascii?Q?vJZY9aCW74HzUmh7bxbRMs5EgrNjO8rJj5WtF0PWauKu1KdFZS+MEGGT6G63?=
 =?us-ascii?Q?Ux5BVjQwjNmIohl50TgwB6CXJ3s2Uf4M2eWEmhKnANCI3+qDs3Onlxi0WG9j?=
 =?us-ascii?Q?skJphkw43oGsAkkeIbD2ICKjAcOBL4DUTKrx/LM4w9F00/LOBuFogwFCgkOS?=
 =?us-ascii?Q?59wuGd2ywlpiDh0m348BQQtk0RPJyJTAsrNzqPdsxGFRYUEgeexb3OYEbnZj?=
 =?us-ascii?Q?8N7esk7yOaXyCELJ6qFFHmOPwnnzg+IRT7UCU7TX2I1S2D6EUd+tcJpi8hGv?=
 =?us-ascii?Q?P6cFQTz3lmImtCYwnO30jDu1lNDBwFn3v3XmADtkR0tU7+WfUAGSSegEP3nR?=
 =?us-ascii?Q?Rj6rz7+3pmgmpiOhWOPcS1Biko5UGZQBnKRwruqtNJZBinG+WKbQCihgNO8b?=
 =?us-ascii?Q?7igJpVE9pgynx3Y65hvsRBtgE3ACkrfHXdNG/5mzzAQfiVSgi2om8+h0MR7m?=
 =?us-ascii?Q?Qn2orVk7oDsepebvdkhk7kHQPGaeLcneHShVn4kziY14T2oUWGfeIv6BgPPH?=
 =?us-ascii?Q?wClDnV1WCCKctdMSPsCS5NtiVDSxr2Y4ybc5kw9OrzvE7zrFIvv9sb7x9n4x?=
 =?us-ascii?Q?cYAIpQ2GBUd8rAh+n6R0Qvl392HDc1b5+i6lYEPYH/ZTozcO/Gxjun0Cjw/x?=
 =?us-ascii?Q?tLDMSn7be+7HDgBtz/u2UVw+UrVM4MrA1FfN3PH30eqTdmICMPnB7eOQKegJ?=
 =?us-ascii?Q?NKqiLIc5Z12pjg0VACuCWogIo7A+gfmeaZhGdeX/5HxBxmTXFcAzWuUc/h08?=
 =?us-ascii?Q?CSyZtUj3DfQocfwKADoaLKWxF3jx6QEN/OTQcbnwLRe/l076Xx01pAwk/yuh?=
 =?us-ascii?Q?PchCGwkWFYl7GKDYleE+1A/k/0wahaXVsxfEZcxQWCvyHviFzJlHYvMtVvwA?=
 =?us-ascii?Q?0yHaL51TgQmpAjwNY/1DmEXLX2ue5bIgzJD1k8BYNNCTbPMnPOZRsLk959iC?=
 =?us-ascii?Q?yaukaXtpQnQ9d/qUZlBzpvkHYju1MQ5wgdzVqMV/Vp1D78sQvRAg7tbaoz2k?=
 =?us-ascii?Q?LQLVJq5BqPjqlOTMezuyC/HNcxoRZrwau2qjzJTjpIceaxIKDVfDKv6HKGZ1?=
 =?us-ascii?Q?cBE5aY4xq9CIic77Qtaaui9CC8qKAhZbg6ltNKagFqPlJumb3dxT2Tw2z05u?=
 =?us-ascii?Q?H3KhsNaoHixI/8ojU5XB09FlGW0o7zFXMu/fgORDdKRHmDLatPmVuXPa3t1p?=
 =?us-ascii?Q?IZZVz3lgA9eUDturNDioDKUFxMUfClW2mj/S/Nj/Ep1h3g4yJjO4ROA7BmfE?=
 =?us-ascii?Q?VdziO+3zsVawAOJh30mxMPOanp61VMIZxrRuWNW1bc7OkLeC16TRLWQTQLaP?=
 =?us-ascii?Q?bs1nm79PyRrpbv8F5BE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eIY1UoUfmjOK111gSWkMeN1ybn9Q59ZuF8441uriZkbJDCfoaatORCwgphHK?=
 =?us-ascii?Q?hYdUjTHWdFpuIQEqT9W5tc3D0hIAOgFOJgGGVCIt3AJGBHKWB1zGu9SyIq0y?=
 =?us-ascii?Q?TE1J76u8Dkswi1bS93v1y8UnZCazMWPLC5k+A5FS3QriSgUsPYnWXRQ8YTby?=
 =?us-ascii?Q?i0LJ9kIA56WGUDGQBGI3Fdhu2EFm/BhyQpV7he0RAyV8Yw8P9v6mNRbVHNIR?=
 =?us-ascii?Q?+ymPSYqarqSJ7JOwWcjK7sv1ktfXDKaeu9QjX0sueuBT/Ltyx5qdxThIVfil?=
 =?us-ascii?Q?aVn4qtZgcmtTgQHfoonoWO0FE3gIbAnbKCtDV0BUyYTbyIe8KbR7+og3hRTu?=
 =?us-ascii?Q?d/vQuxa2nudHqIEm2Hx3ouz7lKeWGWNiVR86/0NCXXjctSxfK+Hv5qF96L9U?=
 =?us-ascii?Q?gXweykMx9HbwPRoHO+pmmckfQIHui2HMdC/cKVS79i9T4I8D8sBw03X0pRxq?=
 =?us-ascii?Q?aEAjhmA88jxSnflAqzilQwGFC0w4GBR5P4W9CcbvVn0GX+qzq3/wYEa5En0r?=
 =?us-ascii?Q?hY0WP3YNI+G6u4qiDoxNamv6e2pbFA2cAMZ0VsryMzKTCZXb9J8BJzfHpA7D?=
 =?us-ascii?Q?0oaQ+BhjIm5GsoxSkPOkThmFoyDVKd6MdVYRZ+3ZbqZ8qPOWgurmVwvu8dff?=
 =?us-ascii?Q?fsgKYQS4NgnQzkVESGU37qUwMZM5XiznViPobXDGILo4sVLZy+kOwut30GmE?=
 =?us-ascii?Q?xzpEf5l5Dt0iAaF9rS91e45BUkQ0w/sJOFN7fLrBeRZDlrAueBVadsHz0zzQ?=
 =?us-ascii?Q?AOXWATQ+ofi/hOfKNFNk9fhYArCyKRFVm5UTijp0q/wmkfrs1pPuu5iMLoE8?=
 =?us-ascii?Q?2Gy1zbdn1KSBrpm7P5JKUY/jyIajRjt5zSL+/4MRFZF1D092MCts7xnOvoFS?=
 =?us-ascii?Q?bFIqObbvQo8mKO7+ZbYezkiWMO8VwoWV1bv12qHe64egUje1rUmDEwXK7Qp4?=
 =?us-ascii?Q?WewxgnL/aYJQHyFiWoSxoZMtBMOPoyYcJZeqOvQpBc/L2G7EfTR0wQqQOXRR?=
 =?us-ascii?Q?WikKuD8TjgzWaIwVP0J4Uok6xOAsbjTH/cdWq4++xTp5ZU3Jwps6umUAxm/3?=
 =?us-ascii?Q?p6lbzltUwyZpB9iFwwC9wQMWoK/qJbJ4iKbfiaBdADbWRCBTa3YjEC7XhQea?=
 =?us-ascii?Q?dsC+87neexK2Sus0LZys1aYZ5pfiVZcfxccngbV6zJkdQxL3M9cqTf/jCSoD?=
 =?us-ascii?Q?ES90DlFQfS14xAzoB9QHypCliafC9h5XFL1NQf8jYEfi6RkdTnQecWvzw1mp?=
 =?us-ascii?Q?RPSKPq0cce02aRIFh2MvTtPNwrrjChoCeW7VxKnsWMbqVovo/pjdTttCZggO?=
 =?us-ascii?Q?wLdd+JAzUGWkkh84f+QsQXZX8mZaGus9EhZQxu1UGe9VNM6e4q9lzCKaiYgj?=
 =?us-ascii?Q?gjEqebpjPlvhlAsT/9Esz5mzzEguWQJ6bhvm7w7PBrTqq+DGhPoWC64aERaG?=
 =?us-ascii?Q?jJZVq2pbFXHqbGyHEJQOwUTaqUQJuAHz0i2M/pKRRHlc3OBPVzWn54MkkJ1o?=
 =?us-ascii?Q?7lFDv+i8OF1b0Y/MezJwyBibRufErw+CR0Catgx6iU7XilPfrYvzD1DU7CyU?=
 =?us-ascii?Q?k+K4eRdtJNzqaxMCGgaaNJq5znApxWs5A7W336tVlrc9MffTc7S0zkLDfOgI?=
 =?us-ascii?Q?WUueozOkPjoNIC7ILq5xP8xsGh7diuOnJKxc2+6VJqqm7S1ZtqrJEaV3wEMi?=
 =?us-ascii?Q?iyXV1Gw/cHHSdOhElE/FSrEqR8TrJnxEl3fKEFoJdCxlEwC8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a731082-5c46-40fc-1701-08de617229bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 09:13:29.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QI47y/O9Fv+v8FXq5mCBRXqlmhXpmRrvLnOl1/7FpNV/uKUdGdZLXnA56TN4NifJEUXGXsY+on1ZShLOq8MiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

Currently, ops.dequeue() is only invoked when the sched_ext core knows
that a task resides in BPF-managed data structures, which causes it to
miss scheduling property change events. In addition, ops.dequeue()
callbacks are completely skipped when tasks are dispatched to non-local
DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
track task state.

Fix this by guaranteeing that each task entering the BPF scheduler's
custody triggers exactly one ops.dequeue() call when it leaves that
custody, whether the exit is due to a dispatch (regular or via a core
scheduling pick) or to a scheduling property change (e.g.
sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
balancing, etc.).

BPF scheduler custody concept: a task is considered to be in "BPF
scheduler's custody" when it has been queued in BPF-managed data
structures and the BPF scheduler is responsible for its lifecycle.
Custody ends when the task is dispatched to a local DSQ, selected by
core scheduling, or removed due to a property change.

Tasks directly dispatched to local DSQs (via %SCX_DSQ_LOCAL or
%SCX_DSQ_LOCAL_ON) bypass the BPF scheduler entirely and are not in its
custody. As a result, ops.dequeue() is not invoked for these tasks.

To identify dequeues triggered by scheduling property changes, introduce
the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
the dequeue was caused by a scheduling property change.

New ops.dequeue() semantics:
 - ops.dequeue() is invoked exactly once when the task leaves the BPF
   scheduler's custody, in one of the following cases:
   a) regular dispatch: task was dispatched to a non-local DSQ (global
      or user DSQ), ops.dequeue() called without any special flags set
   b) core scheduling dispatch: core-sched picks task before dispatch,
      dequeue called with %SCX_DEQ_CORE_SCHED_EXEC flag set
   c) property change: task properties modified before dispatch,
      dequeue called with %SCX_DEQ_SCHED_CHANGE flag set

This allows BPF schedulers to:
 - reliably track task ownership and lifecycle,
 - maintain accurate accounting of managed tasks,
 - update internal state when tasks change properties.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         |  76 ++++++++
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            | 168 +++++++++++++++++-
 kernel/sched/ext_internal.h                   |   7 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 7 files changed, 253 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a769..6d9e82e6ca9d4 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -252,6 +252,80 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   **Task State Tracking and ops.dequeue() Semantics**
+
+   Once ``ops.select_cpu()`` or ``ops.enqueue()`` is called, the task may
+   enter the "BPF scheduler's custody" depending on where it's dispatched:
+
+   * **Direct dispatch to local DSQs** (``SCX_DSQ_LOCAL`` or
+     ``SCX_DSQ_LOCAL_ON | cpu``): The task bypasses the BPF scheduler
+     entirely and goes straight to the CPU's local run queue. The task
+     never enters BPF custody, and ``ops.dequeue()`` will not be called.
+
+   * **Dispatch to non-local DSQs** (``SCX_DSQ_GLOBAL`` or custom DSQs):
+     the task enters the BPF scheduler's custody. When the task later
+     leaves BPF custody (dispatched to a local DSQ, picked by core-sched,
+     or dequeued for sleep/property changes), ``ops.dequeue()`` will be
+     called exactly once.
+
+   * **Queued on BPF side**: The task is in BPF data structures and in BPF
+     custody, ``ops.dequeue()`` will be called when it leaves.
+
+   The key principle: **ops.dequeue() is called when a task leaves the BPF
+   scheduler's custody**. A task is in BPF custody if it's on a non-local
+   DSQ or in BPF data structures. Once dispatched to a local DSQ or after
+   ops.dequeue() is called, the task is out of BPF custody and the BPF
+   scheduler no longer needs to track it.
+
+   This works correctly with the ``ops.select_cpu()`` direct dispatch
+   optimization: even though it skips ``ops.enqueue()`` invocation, if the
+   task is dispatched to a non-local DSQ, it enters BPF custody and will
+   get ``ops.dequeue()`` when it leaves. This provides the performance
+   benefit of avoiding the ``ops.enqueue()`` roundtrip while maintaining
+   correct state tracking.
+
+   The dequeue can happen for different reasons, distinguished by flags:
+
+   1. **Regular dispatch workflow**: when the task is dispatched from a
+      non-local DSQ to a local DSQ (leaving BPF custody for execution),
+      ``ops.dequeue()`` is triggered without any special flags.
+
+   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled and
+      core scheduling picks a task for execution while it's still in BPF
+      custody, ``ops.dequeue()`` is called with the
+      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
+
+   3. **Scheduling property change**: when a task property changes (via
+      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
+      priority changes, CPU migrations, etc.) while the task is still in
+      BPF custody, ``ops.dequeue()`` is called with the
+      ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
+
+   **Important**: Once a task has left BPF custody (dispatched to local
+   DSQ), property changes will not trigger ``ops.dequeue()``, since the
+   task is no longer being managed by the BPF scheduler.
+
+   **Property Change Notifications for Running Tasks**:
+
+   For tasks that have left BPF custody (running or on local DSQs),
+   property changes can be intercepted through the dedicated callbacks:
+
+   * ``ops.set_cpumask()``: Called when a task's CPU affinity changes
+     (e.g., via ``sched_setaffinity()``). This callback is invoked for
+     all tasks regardless of their state or BPF custody.
+
+   * ``ops.set_weight()``: Called when a task's scheduling weight/priority
+     changes (e.g., via ``sched_setscheduler()`` or ``set_user_nice()``).
+     This callback is also invoked for all tasks.
+
+   These callbacks provide complete coverage for property changes,
+   complementing ``ops.dequeue()`` which only applies to tasks in BPF
+   custody.
+
+   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
+   don't need to track these transitions. The sched_ext core will safely
+   handle all dequeue operations regardless.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -319,6 +393,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..0d003d2845393 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,6 +84,7 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_OPS_ENQUEUED	= 1 << 1, /* under ext scheduler's custody */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afe28c04d5aa7..6d6f1253039d8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -924,6 +924,19 @@ static void touch_core_sched(struct rq *rq, struct task_struct *p)
 #endif
 }
 
+/**
+ * is_local_dsq - Check if a DSQ ID represents a local DSQ
+ * @dsq_id: DSQ ID to check
+ *
+ * Returns true if @dsq_id is a local DSQ, false otherwise. Local DSQs are
+ * per-CPU queues where tasks go directly to execution.
+ */
+static inline bool is_local_dsq(u64 dsq_id)
+{
+	return dsq_id == SCX_DSQ_LOCAL ||
+	       (dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON;
+}
+
 /**
  * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
  * @rq: rq to read clock from, must be locked
@@ -1274,6 +1287,24 @@ static void mark_direct_dispatch(struct scx_sched *sch,
 
 	p->scx.ddsp_dsq_id = dsq_id;
 	p->scx.ddsp_enq_flags = enq_flags;
+
+	/*
+	 * Mark the task as entering BPF scheduler's custody if it's being
+	 * dispatched to a non-local DSQ. This handles the case where
+	 * ops.select_cpu() directly dispatches to a non-local DSQ - even
+	 * though ops.enqueue() won't be called, the task enters BPF
+	 * custody and should get ops.dequeue() when it leaves.
+	 *
+	 * For local DSQs, clear the flag, since the task bypasses the BPF
+	 * scheduler entirely. This also clears any flag that was set by
+	 * do_enqueue_task() before we knew the dispatch destination.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		if (!is_local_dsq(dsq_id))
+			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+		else
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+	}
 }
 
 static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
@@ -1287,6 +1318,40 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 
 	p->scx.ddsp_enq_flags |= enq_flags;
 
+	/*
+	 * The task is about to be dispatched, handle ops.dequeue() based
+	 * on where the task is going.
+	 *
+	 * Key principle: ops.dequeue() is called when a task leaves the
+	 * BPF scheduler's custody. A task is in BPF custody if it's on a
+	 * non-local DSQ or in BPF data structures. Once dispatched to a
+	 * local DSQ, it's out of BPF custody.
+	 *
+	 * Direct dispatch to local DSQs: task never enters BPF scheduler's
+	 * custody, it goes straight to the CPU. Don't call ops.dequeue()
+	 * and clear the flag so future property changes also won't trigger
+	 * it.
+	 *
+	 * Direct dispatch to non-local DSQs: task enters BPF scheduler's
+	 * custody. Mark the task as in BPF custody so that when it's later
+	 * dispatched to a local DSQ or dequeued for property changes,
+	 * ops.dequeue() will be called.
+	 *
+	 * This also handles the ops.select_cpu() direct dispatch to
+	 * non-local DSQs: the shortcut skips ops.enqueue() invocation but
+	 * the task still enters BPF custody if dispatched to a non-local
+	 * DSQ, and thus needs ops.dequeue() when it leaves.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		if (!is_local_dsq(dsq->id)) {
+			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+		} else {
+			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
+	}
+
 	/*
 	 * We are in the enqueue path with @rq locked and pinned, and thus can't
 	 * double lock a remote rq and enqueue to its local DSQ. For
@@ -1391,6 +1456,21 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
 	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
 
+	/*
+	 * Mark that ops.enqueue() is being called for this task. This
+	 * indicates the task is entering the BPF scheduler's data
+	 * structures (QUEUED state).
+	 *
+	 * However, if the task was already marked as in BPF custody by
+	 * mark_direct_dispatch() (ops.select_cpu() direct dispatch to
+	 * non-local DSQ), don't clear that - keep the flag set so
+	 * ops.dequeue() will be called when appropriate.
+	 *
+	 * Only track this flag if ops.dequeue() is implemented.
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+
 	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
@@ -1523,6 +1603,30 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 	switch (opss & SCX_OPSS_STATE_MASK) {
 	case SCX_OPSS_NONE:
+		/*
+		 * Task is not in BPF data structures (either dispatched to
+		 * a DSQ or running). Only call ops.dequeue() if the task
+		 * is still in BPF scheduler's custody
+		 * (%SCX_TASK_OPS_ENQUEUED is set).
+		 *
+		 * If the task has already been dispatched to a local DSQ
+		 * (left BPF custody), the flag will be clear and we skip
+		 * ops.dequeue()
+		 *
+		 * If this is a property change (not sleep/core-sched) and
+		 * the task is still in BPF custody, set the
+		 * %SCX_DEQ_SCHED_CHANGE flag.
+		 */
+		if (SCX_HAS_OP(sch, dequeue) &&
+		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
+			u64 flags = deq_flags;
+
+			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+				flags |= SCX_DEQ_SCHED_CHANGE;
+
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
 		break;
 	case SCX_OPSS_QUEUEING:
 		/*
@@ -1531,9 +1635,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		if (SCX_HAS_OP(sch, dequeue))
-			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
-					 p, deq_flags);
+		/*
+		 * Task is still on the BPF scheduler (not dispatched yet).
+		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
+		 * only for property changes, not for core-sched picks or
+		 * sleep.
+		 *
+		 * Clear the flag after calling ops.dequeue(): the task is
+		 * leaving BPF scheduler's custody.
+		 */
+		if (SCX_HAS_OP(sch, dequeue)) {
+			u64 flags = deq_flags;
+
+			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+				flags |= SCX_DEQ_SCHED_CHANGE;
+
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -1630,6 +1749,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
 {
+	struct scx_sched *sch = scx_root;
 	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
 
 	/* @dsq is locked and @p is on @dst_rq */
@@ -1638,6 +1758,15 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 
+	/*
+	 * Task is moving from a non-local DSQ to a local DSQ. Call
+	 * ops.dequeue() if the task was in BPF custody.
+	 */
+	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
+		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+	}
+
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
 	else
@@ -2107,6 +2236,24 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
 
+	/*
+	 * Direct dispatch to local DSQs: call ops.dequeue() if task was in
+	 * BPF custody, then clear the %SCX_TASK_OPS_ENQUEUED flag.
+	 *
+	 * Dispatch to non-local DSQs: task is in BPF scheduler's custody.
+	 * Mark it so ops.dequeue() will be called when it leaves.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		if (!is_local_dsq(dsq_id)) {
+			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+		} else {
+			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, task_rq(p), p, 0);
+
+			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+		}
+	}
+
 	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, p);
 
 	if (dsq->id == SCX_DSQ_LOCAL)
@@ -2894,6 +3041,14 @@ static void scx_enable_task(struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Clear enqueue/dequeue tracking flags when enabling the task.
+	 * This ensures a clean state when the task enters SCX. Only needed
+	 * if ops.dequeue() is implemented.
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
+
 	/*
 	 * Set the weight before calling ops.enable() so that the scheduler
 	 * doesn't see a stale value if they inspect the task struct.
@@ -2925,6 +3080,13 @@ static void scx_disable_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
+
+	/*
+	 * Clear enqueue/dequeue tracking flags when disabling the task.
+	 * Only needed if ops.dequeue() is implemented.
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
 }
 
 static void scx_exit_task(struct task_struct *p)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 386c677e4c9a0..befa9a5d6e53f 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -982,6 +982,13 @@ enum scx_deq_flags {
 	 * it hasn't been dispatched yet. Dequeue from the BPF side.
 	 */
 	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
+
+	/*
+	 * The task is being dequeued due to a property change (e.g.,
+	 * sched_setaffinity(), sched_setscheduler(), set_user_nice(),
+	 * etc.).
+	 */
+	SCX_DEQ_SCHED_CHANGE	= 1LLU << 33,
 };
 
 enum scx_pick_idle_cpu_flags {
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index c2c33df9292c2..dcc945304760f 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -21,6 +21,7 @@
 #define HAVE_SCX_CPU_PREEMPT_UNKNOWN
 #define HAVE_SCX_DEQ_SLEEP
 #define HAVE_SCX_DEQ_CORE_SCHED_EXEC
+#define HAVE_SCX_DEQ_SCHED_CHANGE
 #define HAVE_SCX_DSQ_FLAG_BUILTIN
 #define HAVE_SCX_DSQ_FLAG_LOCAL_ON
 #define HAVE_SCX_DSQ_INVALID
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 2f8002bcc19ad..5da50f9376844 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -127,3 +127,5 @@ const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 const volatile u64 __SCX_ENQ_DSQ_PRIQ __weak;
 #define SCX_ENQ_DSQ_PRIQ __SCX_ENQ_DSQ_PRIQ
 
+const volatile u64 __SCX_DEQ_SCHED_CHANGE __weak;
+#define SCX_DEQ_SCHED_CHANGE __SCX_DEQ_SCHED_CHANGE
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index fedec938584be..fc9a7a4d9dea5 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -46,4 +46,5 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
+	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
 } while (0)
-- 
2.52.0

