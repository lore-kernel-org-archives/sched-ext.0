Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631E47F2EC
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998693; cv=fail; b=OvtdteUSXOGeqNZcTheyvYS9W83DOvuX1NJAtnf5Mvf4UwJqa4TyQEvBPnbmsaM+jCz90pFw2jbT1JaabPxqcE1xePO8lghPwusUzDEQs0i8lHmztaWQF7W8gUAbhrJScE7PZbw58SgRfHJsrIUrzp2v7aUzzGnaUPjUL8mr9/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998693; c=relaxed/simple;
	bh=OS19zgRiq4Zp6XQDvNJP3lIM4aHKwPtxu2q0WbT2SzA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eiQcgzxg8j+HHSygl4rcABsW6eO5eoeN/ZKBGRNnHDkxT46MYZA+8HXmUsDoNyrg+tNBgr6WPFsty98cFiCQIdXP7fgvihc1YVm6YH1m7rs9ZnK+BOU9KH9YHxoR8HYFTijwptPxdZBOq1cBZt0qnp2FzvD98P1WlfWRl+gRqRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MuMYSb3L; arc=fail smtp.client-ip=40.107.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MuMYSb3L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqiF99kMAywbMX1iT77vWlN+90wkkHVT/Nmsgfb3aFtT34z/OOsyEQ8okvXQxyNrMpbFumE4yzcwUc1ZsZOyUzTJk0h0/Q4BztFPI77ZFz/C1xV22+lyWMlCF9PSc2RFVGtYrPpVUKSJ/Sot5WhXXbg4rkvGVe/Z6MqF9Q6DC/hqvBaBthXxcJGh0HOd6QI0hsqhBCWAZEw4EAtds6zYe3/Q2eiq6TNwFcmjkLCRJnXA5ahNQnjTppKECBmI0yoqPE1nw1ZfxJxa4qfMDHNseMZKzr8+bCJ4qU3YPsRffN16Aq9RTkQSwtvyoD/YpiAxIa4f9DVBUrL0sQCY8J8eSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+QxpRGcEW891bL9mznicWFvmB/BsLuJHWPlrvkIVjc=;
 b=Gew8usRfNH1YMyri93Hum4fvQkRYYMSGoWcmqQWHWWVu1tqBshxfrhGA2EpCEjvQJcZV2p/IpxlxxaiSqSYrji2P/ogsYgFjc6HsdyAas16uCYMKh3fxmT/5gZWEB91BvPPDFSCmXkyAOZ2SOOR6lW8fBuwEDWhQPx3a6RVZ78jDDSSFlRF2lfuuKpaCe+K8Ad94LWiv461e3lmo5E01it+0wBF+IUMjXZJfaS1VoH7TEWfFlhaZQxkxNpPDvmYxA2VauGeBWse5j4Pa/LOAug0x2GHoKkIE127zG+5nmN+7Ilkd8SwjoLA0ZrpL2b2pndfpBC5zrfL0VWM6T3Wchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+QxpRGcEW891bL9mznicWFvmB/BsLuJHWPlrvkIVjc=;
 b=MuMYSb3Ltwq//vyUXtoSWIgou7yKF77ztaGo6IWK2caCqWFNRc4Tsnl2Er4oPO4mjqCri7mh43KZxiTmK8M9icI3JOg3PoVeiKk8yT+Zu7EcPRYXPCFlyEMv4YvxV2MnmmHQI0aQsSWSwOP6x/HGfzkFJ4a0lwM5tcPT1BbHja7Ydqgnbhf7D1+OlXxhIP620iIZ0Tfp15YcFguummiFoAN6cYLGJTdRokQUI37eHoRRWGhBF3vw5ifi5rrHxse2OosSWQQ0wpttTjYtk5HwYhkHacf4PDEBlUE34zFj6Bl9mj3BlUH9e4oZrzKRqylChm5jZWWECpD8RbdzUidujg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:31:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:31:23 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-6.20] sched_ext: Fix ops.dequeue() semantics
Date: Wed, 21 Jan 2026 13:25:29 +0100
Message-ID: <20260121123118.964704-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0195.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 552b3397-649c-46ab-856f-08de58e8fcfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/A3RF331BzOQAMrU5FYwHp+rAlidki+wlcMmzbWt6Bgfql+U8SXj6y1+PCtz?=
 =?us-ascii?Q?4fCZ1IBDdHvCB6DBJ4sXNa8umTNMLL1Xm9IOl+PcYQTKN46hQw4O9KGQJ3PR?=
 =?us-ascii?Q?EM2DYqhM/DDC+FktzT6PmAHMZuX75yW4/XMV+TdUFICLqr5PRYL/uI87hznQ?=
 =?us-ascii?Q?iMK0SjuiDyG3Nzj0R9R9+5IJsMRuA0/rDoR5J3o1QQJFa7Qw7gr65rwbcI2/?=
 =?us-ascii?Q?6kNwuO1XYBBi1K40igAJTaX0vKiV+o+9xa/6294vgnaOORj9tgZa4WtaOWwZ?=
 =?us-ascii?Q?ueZpCForiYvPjgxYE68OBKuvvs7VrAEMBNph7ipZxmAreBEOBqrFXVticysT?=
 =?us-ascii?Q?B/VYs6gLmGwI5hPh3T38vr4FugGApbqZ4kAT8uvSvZRHhN0WHUEsaS0u82N+?=
 =?us-ascii?Q?ejRVxhKT8NknImplPd7BSq7X8bqcOXMLKh2BPg1CRAR55cT0ZICa1FKkXAbC?=
 =?us-ascii?Q?S06Cv4IV8aWoy0Y6iAgx+iVQgCvBtmAM7Z2nrWwgaqSKFpx/6kZERRpQ23Qv?=
 =?us-ascii?Q?OS2eD8AkLxenDgKNAkHRADiqBiHBsjkL1NpyzcMeru+XPstLFN8A/Q4eErlK?=
 =?us-ascii?Q?4h4yPdFWKwk+YdOKYs+9RJT2m7t4weHCcA7JUJ4QA1n1Qq5KoNkoDhj2TvQP?=
 =?us-ascii?Q?dfax5Trsm8Tk7S5ylE/dR7nRM10ABrzP78Na2hfK/jkJFI7Ca6igHN8sU7rF?=
 =?us-ascii?Q?IZIZboCte9wvnabI2jdp4O4lXTNmetu3/96O3wr0LvmGOjtihDwqz7/AeouB?=
 =?us-ascii?Q?krotAOgVoVXU7+QIMBdYWRKnebnmgZmJ+VXctk0wySt+M2NW8Kiw5qVQ1IFz?=
 =?us-ascii?Q?dA94UgSZWtt5refijXcDPYTLSI65gJ2ZtNYP6NrIeP/G8fLb4dxInCGIXC5Q?=
 =?us-ascii?Q?8HvKD1sIp3wXgPNrO4TTrJ1q1Qpi9sBZ86FpiVhMyS/vDse7of9aZ/V6BFFS?=
 =?us-ascii?Q?wrViAD6XH5bV4CokyirkG2zumMu7wC8ZI6pCQLi6cVlVs2WLboyt2xLB3pOV?=
 =?us-ascii?Q?X9qaop6DZ66z5BR/+mrVU9J/gR6i1S78ymS4g85UzLtra8bZHzWfB7a+Ae4y?=
 =?us-ascii?Q?/K+Au84HRxPtJkt2aVQ0lxMZP2UGS/U0xPTGQ1FDYjkRTCTgaOFY0bxd6xoO?=
 =?us-ascii?Q?D4Q43Yn8U4H6/iqDeBodCYmblYpOz2CXjQ4Bx1o+kyA2epyOqk8OKg+0V1Dw?=
 =?us-ascii?Q?EanX5evkmxEw5zUlhw6ByMSh9jcAchWeI24rppdP8pYRAPSXhY8Kz8cbiZCI?=
 =?us-ascii?Q?xrndrBYt+oSSid74iDVsEdrMUVx7GfshuVX9vQWhLhYLk24DwErlZ8k21tQq?=
 =?us-ascii?Q?9c7Ku3NHojqHSSZ+dcAWXKbyTDXhxciOHMOR/G3OvFnK13sDL53JUDLVXkSV?=
 =?us-ascii?Q?LRH7oLvFCSRinabS8rJht87Wo3BeB/mJwG+jnY3GO0gdRYugRyxI711SDpD7?=
 =?us-ascii?Q?HxHEdqF9PJDzDBA4yvvUmYuCJ6H7DX9pcJZ/BFdM/JUC+FztwgE7nQNzVsT6?=
 =?us-ascii?Q?GH05vwg7LY5+E6FISKc4/kyAS6laKEHAWQBn+2uRgmMdmQzRrUM0ISkZreoJ?=
 =?us-ascii?Q?0tlboEoceN5DGYnWqtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/2r/1f6aDRFIswDEr0sQVao9rEZmvFtTC6wCv7xT8JxQ52Ds+NeixqrCYu/7?=
 =?us-ascii?Q?INf4/POwQ3wY9l/rJ+xX01tPr2/O7WQK7/j7lrH0tFLmj/aZJJBKqxXaJXep?=
 =?us-ascii?Q?Gq8C3W64PuNebOlsX45fAjOl3abAoI3AVqmDzwmNElRjCSpXK1im4CsAd+8A?=
 =?us-ascii?Q?EJleVBL8RalKJnSSamWWHCPSwruv3i4p67hKVaiHixK0AePbZGe+6bk7jukc?=
 =?us-ascii?Q?ui6H1IGIfGcyiaUI40DfRnYOM0uLNs6g08wdqsIlgLQdFtCGLljXbiWBX6en?=
 =?us-ascii?Q?5gxCdcTttlyDWiIqUsHzEwfYn6kI0u2JyLEgkEwFW85s7iboWnFizAdMngcM?=
 =?us-ascii?Q?UzzXNFGPcUXiGQhUtpxRt0XXL2MEsIHKGES2HSQONV3RxsV5nc4zMCAdr9eL?=
 =?us-ascii?Q?8l8yCVRsQskPjbRNxpaFo3/j1GY01Qilf2dPd3X5F/Ed84p0E2/7E20o6Pac?=
 =?us-ascii?Q?ozSngFzJXcA09Cqhe8YN5B+jgvEyccFZ8lmtQjQSmkhzqnve+9bBZ0FvPPsT?=
 =?us-ascii?Q?LJD2adr7bHVAIo0ZmNW1k47KKpa4f3z4ZCklmaV+mHmW6oguWDsj/FzLde6l?=
 =?us-ascii?Q?ADVtLjJYB/INKBiSEiiT/l6Tbdn4JK6deWWxPyvcV394N8/qvZiSiVdnpISK?=
 =?us-ascii?Q?kTLjFsygAeqH9suim1sXdmgh9g2iK95StBkAe5CYgIX7CbkucNSCWVcdwVga?=
 =?us-ascii?Q?bbWSCsPTjnVBnfHNbk0bqknJ1wAWVCrliOOc8mElGIYf9mFvcRzhyHC2kAHi?=
 =?us-ascii?Q?zj6QUXGWIdN/onzsD64tIG2oanirgIHOrxQCQJJAvITepmXC/C9EwYSbgk5T?=
 =?us-ascii?Q?ZtbeGgISPnkdKy27EtaNhYojkfnACFWmpALw34hrNb+mYfMnUQ8v5KX6ZzSs?=
 =?us-ascii?Q?hdavoz+YNBfeMBDs6/UwvSd6Fyg3PXJeAHDgdxPTny5MxqniAVn34CaE1VLA?=
 =?us-ascii?Q?LupWu9ZuVH9poWqtxxZhiQjNv8v42v3Lo0le36+7cNhg6HjRlwMukSOsBi7G?=
 =?us-ascii?Q?3+s/L3T7yqVs99QwUvSru3eXcMynvR/N2jsUaYn+L1PnA+eHRPMw0ChZuX9l?=
 =?us-ascii?Q?D5NJ01zCG/6qMOJtUw0rPH1vONpBos4ifCHGe2it5LWPEsxIJyBjCZtJ2LPL?=
 =?us-ascii?Q?clULD6bVwOznVzN63KcjpG/IU1KXlUfASct2T9j1EO/weTs+ZVHfhhfZQaKd?=
 =?us-ascii?Q?prf0xQCwLVbX6FrPv877khemnhjcpmjcQ3uKuZfv2CjQl98F7qAWBmxysJxQ?=
 =?us-ascii?Q?8Vr+q/1/Ya7+U5k3/HmM40HTVlSNE7sMjcY4qgNzxnVBpvE1Wnyk1rqBy+w9?=
 =?us-ascii?Q?f9SylfEPv8P8T4BvYXMsH5NFoWQUZzsmiEqi3zklXwogtxmArnntI+UhvHcr?=
 =?us-ascii?Q?wP/KvE3z0k1PzXFyHEKitZQG8xe9XV3/MogULCe3SpbUSMDUF5tyhIZK08zF?=
 =?us-ascii?Q?1gSpFh7B9Zik61eOuFya6YtSy3LQLuaOStEGk1d8AFd0bNxwv6xVdg3YQmzI?=
 =?us-ascii?Q?YVBUJ1vRLSguzguaZ3sWZ7LDQCK6lQsGUlOfOsNlKXWrKYu1a8D4qCc4Ik8y?=
 =?us-ascii?Q?ziDLY6ufxUX73YBHQjH7tRS41bHvwsculv7KkgGKw7cABVKDzNpI8y6mt1tw?=
 =?us-ascii?Q?4ZRewJO3wX6Yhu6oq1D8bTFVs5b2wxFwnLEJb93+0LAnpozJyj31Eo5qXaVh?=
 =?us-ascii?Q?TbZfqTorK/9rwu+rQ7SZ7+akhx+ru3LJghGotwwimBL+pJ9S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552b3397-649c-46ab-856f-08de58e8fcfe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:31:23.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOE77InZrBjZdKH/MNsOeAlhA1DFcfc2RXNf9J1ZKtw8xF837o35fUUWvCQI+RtDoq/tW4kFCl+zNUjdHANhVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

The callback ops.dequeue() is provided to let BPF schedulers observe when a
task leaves the scheduler, either because it is dispatched or due to a task
property change. However, this callback is currently unreliable and not
invoked systematically, which can result in missed ops.dequeue() events.

In particular, once a task is removed from the BPF scheduler, either due to
dispatch or a property change, visibility of the task is lost and the
sched_ext core may not invoke ops.dequeue(). This breaks accurate
accounting (i.e., per-DSQ queued runtime sums) and prevents reliable
tracking of task lifecycle transitions.

This patch set fixes the semantics of ops.dequeue(), ensuring that every
ops.enqueue() is balanced by a corresponding ops.dequeue() invocation. In
addition, ops.dequeue() is now properly invoked when tasks are removed from
the sched_ext class, such as on task property changes.

To distinguish between a dispatch dequeue and a property change dequeue,
introduce a new dequeue flag: SCX_DEQ_ASYNC (I'm open to suggestions to
find a better name for this flag). BPF schedulers can use this flag to
distinguish between regular dispatch dequeues (SCX_DSQ_ASYNC unset) and
property change dequeues (SCX_DEQ_ASYNC set).

In addition, a kselftest is provided to validate the behavior of
ops.dequeue() in all the different cases.

Together, these changes allow BPF schedulers to reliably track task
ownership and maintain accurate accounting.

Changes in v2:
 - Distinguish between "dispatch" dequeues and "property change" dequeues
   (flag SCX_DSQ_ASYNC)
 - Link to v1: https://lore.kernel.org/all/20251219224450.2537941-1-arighi@nvidia.com

Andrea Righi (2):
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics

 Documentation/scheduler/sched-ext.rst           |  33 ++++
 include/linux/sched/ext.h                       |  11 ++
 kernel/sched/ext.c                              |  63 ++++++-
 kernel/sched/ext_internal.h                     |   6 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 209 ++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 182 +++++++++++++++++++++
 10 files changed, 508 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
