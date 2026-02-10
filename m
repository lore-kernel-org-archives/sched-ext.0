Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F03335081
	for <sched-ext@lists.linux.dev>; Tue, 10 Feb 2026 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758924; cv=fail; b=J2Mqki7z+fAxpBnQvMBhXsVGxu56zUnyBDeshzVQZdMQaUK5ciRsGmhyyQ/l78+UCpEw50cZvcz9Mgun2YELeWNX3RWUrab/DHGMZ1FbFWWwKKFKVt6AS0HlM6SCCpBhOIkwQOcZRJkN1AOeza+G88CvHGjqnCwS2loazxoUPaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758924; c=relaxed/simple;
	bh=TQ7QOR9fucaVaF5vS6tVccGzYke557eiJM2CC54NsTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HY6LdcDTiYaboMozd/oOSEhTAmzGlcA7ASqo2/HBxhXvLvC6XrNuV2DOKUnZzZfTc1yBjUxPT3+VOufqcKXV9xMaznQSiflirByKuQZlcI5f4cAHGrpZzCCrwRGmULzapLw5pqIOqJns93hRx6uqEHcAfBXIPDI3lAkllpNBI5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=riPK42FQ; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="riPK42FQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk3FJ0HEH9+L7wLrS7500U2ki7SlV7As8bg2PYTzJRNMW0O3EZY/hCfipk4TCgI9zsk1X0RAwNTENQLimPhqcExvzJxW/TJ8nMAyMrfl/zR+W75SiFOEe2UD+M/jmNf4lEIlgYPEB+5OWkCJtfOhQb6NOpg9u2fjNLlLamy6L/zz2r8Wxc0Izlqq2p1df99Unh8JMcL8QqXqbU2eSUfV2rNbSs2x2Icgm4+pb0PUI5/gwl2oAnvyk7y8MSnZ/iLlLP7Knjj8t4KJMtKuEye48T5BruxOEOrLQV+mO6KEH0+0zFgpxbx28hsyhwM1uvLRnptt2MS8ZOmqTpTvskvvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT4J70sfzx0I18YvNxAsCLG3hJH5QNN3uhjWjfTNdi8=;
 b=eolMHmTiUGjsaku3xvTdabI/ouj7JOCBVIXsdOixaHvbACpvFllq1T11ZwJ0wvKMfOsreym43kgLzJUK2wuYwOeu0MR9+4aFzOvf8SJxdiYD4ysP3V6ZlcxGtgVzJPj0U+RJX0epcK3i2HyiTj+WfWyudwzsEeDyyPWl/jUODdxuu3mahlbEzMznxfV0AszKEc1yM9JHvJSJbbiAs71ZxBG/rmJtPeFkMyj+ZkCapVxKlwBVySpJAHw9ILlEX4cfyzVlrL0jJdl6Wv8DjP/+SKJVjPjj11+rgiYPYMGqpcYp7XhqbTVhXXmY5ggr2buzKIWkkTX3qj4BspO8pHqdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT4J70sfzx0I18YvNxAsCLG3hJH5QNN3uhjWjfTNdi8=;
 b=riPK42FQQKaSUhzOiDAK0YWOHCCRazX9Gr9MadihJNJQxUPNJ51YitgIWnW/3qXxVdv/BsYej/3Uh0aSKwQ3rCJQJqTsYJW8N4w6xJIHVapwm8QFUT6zhjL21VTBonNmx0oXXH2IYA95eqQ5omtf7s85vBxkOuOtiWj1Ofd/ADX64BjoxDDFek60CH8jlkn1/py5XwqijM6wdZfw7VeQQH9VkBnBxDi1EF8ukUzBifr3/I1p7jkPNXT2WRTLiNTcQDtYfjLd/aNEYRGN9r5GIgRizzVCG5zsj/52me0UBufKvWU9J1HAnbsKu5gZAROaIMBGpLzWgeeL3Yo91KGE0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:28:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 21:28:35 +0000
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
Date: Tue, 10 Feb 2026 22:26:04 +0100
Message-ID: <20260210212813.796548-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210212813.796548-1-arighi@nvidia.com>
References: <20260210212813.796548-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e07c4cd-68ca-4dfc-5101-08de68eb58ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nFb4rhlgcN5eX2WeSwDivcno3pZ8buuVKxmeuxQiJpM1iZQ4IM8lLKx8JH4r?=
 =?us-ascii?Q?kkAXU6qNoJDzunoR+C1+b+0tAxBdSZx7g2Tfy+lFW6SyaGSJc6DkxkcjxrcE?=
 =?us-ascii?Q?7VTHPXzENUb0GP1KtuDvEmvMcbxm2FCbsag6py3r2Nzbczxp4pf+1+kcMMyz?=
 =?us-ascii?Q?NC3+FizjnLC0USKFh6VVb6QJQvi8Ji7iBGkBQS4VkfFLaX+6r9vBTx4pW4gj?=
 =?us-ascii?Q?kPUhdP1rIsWEDrrfMB6KCohoObEWTIcgXeiDteJIAScN09VfTXsIKpMB4lVp?=
 =?us-ascii?Q?jKgQV/0CuXQXiSLS1WjLpxBi1GlLcaDRCLq8uWTqUl+iX3/I7Pi4NTm5P5uD?=
 =?us-ascii?Q?O4EaUuPeD8WosTJS7VzitcuRYtH7+w6nPKfPEijBmKUti7jLhAe+a602c/UB?=
 =?us-ascii?Q?LHYLO20FLBwEoFz/8pyM2xKm6iTpL09MV7OZIwqmhgEzunhWqN8BZkFPYQ+0?=
 =?us-ascii?Q?mYmmOdmyzaxb5rhFU4Yhz084Kzze8u/zvwT5RPKo7py4WkpxmJarlGi2s+Xz?=
 =?us-ascii?Q?y+aMx+XVCWdGGwprEccwGH+6ePJsueQG8WvgOp2M9hI4r0kQJEcGyv6nxPyV?=
 =?us-ascii?Q?FItHiuz8cvijN22HB3Gsh8a9MJ53+xukQkWYc8JuctcuHK/TcTC4e7oJi1UB?=
 =?us-ascii?Q?JiUeRH74QCtdnlOfyTlB1PlLnxU2FwMZSdw7MGVn9jbrpfxn6Oju0K3CuOYz?=
 =?us-ascii?Q?0GoIYpXO7pUwaHRVyn4xeoL3b6IesgYxmD9nsiuNOD+fXfB2246Q8HSBD8c0?=
 =?us-ascii?Q?9sQa9aU90cK9a375w21metj0RehRlr9o9QkZqGW0T4v7YKwx4sIhJYarvetl?=
 =?us-ascii?Q?BFOEkbkb+uhYBT5CqiJ7Z3E7S+oeunMGOMOXjTAYKemdjipudcEr/8pmn9yr?=
 =?us-ascii?Q?475wWIEQvBzf679l6PmeD57i+lEjMQNvDtoH71K2JvInBzS4nKv0tUgHK0MU?=
 =?us-ascii?Q?w+Wf7lQVU2a7qARHto/dQyH5CrqhhaHi8i0bTYjtm8jYHS5IloqvVJ8LV+nR?=
 =?us-ascii?Q?FQmsiQX+I008ns3xPwCkQxLixkkvzwYIjZMPviribTNg1WtPMaDZsynHFj0G?=
 =?us-ascii?Q?LdjzIkr8rdtIXbZpITSSyHF4b4u6OMarMfSOePucosNvXnD+3GZsl6yv4rTa?=
 =?us-ascii?Q?YD6E2hg9uJxvLXq+sIaPTs6lPQiUS/ohKOs2+UjL/3jNoUiaO8uBnxTVjhVQ?=
 =?us-ascii?Q?nOksE8FLmaL6Xm7KNj6AkvBMwxQa3BjP9/wyZ95fmodDXdKmIDjaNC1snVVr?=
 =?us-ascii?Q?eaxMdD27pEeRkCxugiynRKmkT34CEGKuWrD5ZFc0iCkerYr/odMBiocHJnCZ?=
 =?us-ascii?Q?96Newfl2aKBCgRSOqrh8nL5NXBz+/Os6nRL4G58ibHeZp4L4xxT0bOnVy2V4?=
 =?us-ascii?Q?8K0H9iMRhNXsPd3c8q8lCqnJYcPO6AZ0D5OImQp4ewLNDnU5HOckqS/09lHA?=
 =?us-ascii?Q?2Iou3kshFno25Zn6nXM0B8nM+X+gbeJ3RJBe1VR3SEhBqY6G49DrlX0Mlenp?=
 =?us-ascii?Q?c5k5KPiBNfeP8RsIZ0vNHuYoClbC8mCm8chAO/P+dqAPcgeAqiQWPSMW7AyZ?=
 =?us-ascii?Q?JliMedIWqh36ePb31fs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0eMLbS6UtI5Yyn4dIY57tkP3Z4oXNT6s7ZvTFmpqMdJ6aN+mfHSUAN19kO1?=
 =?us-ascii?Q?+zSM9oJ9LBMihWT+JEuSArgOq7GqPjoiacRP9hz8hVkY+FlER4vR1XSPELUW?=
 =?us-ascii?Q?j9x6Hqjdn2GzrOu9vn6d2Dh/y1QlHYReVvxxqDExGnSsnmWV4HnilISsBliA?=
 =?us-ascii?Q?/R48AjmjV8WKJvq8elDXki7nAk0Nzv47Ovlg+iu8JWdMU2KJBWclqIys7FqI?=
 =?us-ascii?Q?HxdoxpDuRaXOIUNv5WU8KMOZB/N9CroWx2SAvvRxrL7y//r3pbFi2BSBsh+Q?=
 =?us-ascii?Q?Aghv5Cg0qLVoEsQihgMU7K6qHUd4ZHRoQ4tdOBNYRAnma8tziDW6XIqGQhdt?=
 =?us-ascii?Q?r5gU7PUbWuVKvqVw0uvZquNeMKlVsN5oahx3Ji9ht2y0yslz2OGR5rsItRce?=
 =?us-ascii?Q?XQWLwbenZ42HkEABFQQYaZPgqi+ZIHORVbsAjW9ka3LYNHL/+9s9MzD+hsah?=
 =?us-ascii?Q?yDaqHMze/SvnZT7pXYwNsTCXaKedchaAo36s4+05Jjy6qzqNSHePGoObP7N7?=
 =?us-ascii?Q?2pJ81cdbGD6esv/zLzVGBb2qXOLsJdxWOlXaPWFnRIkCQ/KwJR1xjBwEcy7A?=
 =?us-ascii?Q?4ZPOtvsH3SOoCCMqEHacTu0CvfBJQpRLWxEtuLknT6EISpGf8027wn6dES9b?=
 =?us-ascii?Q?g6o3CLvluo+pCKPEbTF5tUb7GfDIK2XvmY45Cfm9O46POfHzy9QlF5lwWF7X?=
 =?us-ascii?Q?2LIuwreg4JqrTp8iisZ/w/GanxGiqFPle4AwBmK1G4ZKIFv/hJVTSQBXLFWI?=
 =?us-ascii?Q?hn88xY+4ZRYYJjj9ge72XA+u/bW9HA5lSy0e6OiT1miYxhgLLpoREIHJIvYv?=
 =?us-ascii?Q?TmD0q5iX3b+BBlpvtXvb1PZcN6hxo/ZaeaTD91JqXq8lbBEty5Kr7Arxl4HL?=
 =?us-ascii?Q?N4NYR0E5aebCzhSv43b/7Cr3OKYkePYEzFe5zf0YhhGEKcUMlywrESO8Smg4?=
 =?us-ascii?Q?ymsKbnx/x/bP0H/k5ILJ8NJKKE7MmlB2Dzo4WPoorBnoeOB+zgXZejB20UPP?=
 =?us-ascii?Q?4WCaZ8wlyoodWIsizsNRER/AZnHnPWw07H9K7ZdkQK8jFN2s/SE/GRbYoBvq?=
 =?us-ascii?Q?KN6o3fXD79Nv9PGIzCuZ6/xg30WyBVP3izp+S02YKsgWvn6aWENngkL4R526?=
 =?us-ascii?Q?zp5EKGQQSIxoSBzhmzFsPz2P2tiZf2XQLn7RG6nIRomxg5BAMvymQOig+kH6?=
 =?us-ascii?Q?cZOskaWMlXi20WfHtor0yOH0IxArx3GwwjegpP11ktNU1I5cW4Zc5wXThEdJ?=
 =?us-ascii?Q?ztPc/41kbTUW5oF1gjTNIQ5fuWcUPj2vx4bMCmaRjDFa35ICHzmTFO3j4/f+?=
 =?us-ascii?Q?AxhxO3qOgJesMnJ6ZmpTJvwLwGUsbuzWAcQrNr2pTyBo07GxNChh2KnJ0r8b?=
 =?us-ascii?Q?/kCp3Qh/l2DPMrZmB8iO+EEa/IDyHSlsgYjRQ9L6kmZbqb/0nOpPC/g3ouzA?=
 =?us-ascii?Q?4UuJkVwEN8/7uV1rqFefbrOVGWcKm9xnjLBmjB4KWlK64x54NIMXJmrtyV7I?=
 =?us-ascii?Q?cb/W6bK2ANP2qQbXKNfs2mI8bUThfouy1KZ/012r7uREqVmrIaBjOJkPsZdC?=
 =?us-ascii?Q?nVpRRMhOhh0k/CQHqvIXfYfVi7oKWbxGAQ22YcXcVIz5KjW0tnDQi406L66I?=
 =?us-ascii?Q?EKSGBkuHDmNFkBY+jN5rsTW/1PdLe8J6Zw1+PYRimG0ubF6ZNNsgnniLzTVw?=
 =?us-ascii?Q?SwKhe/YQAMIS4qxW0e/aVHlZLbUP5hpGyK4aUfMRDF2By4y2m6hzhhAdCFUG?=
 =?us-ascii?Q?jwH8H4FXJw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e07c4cd-68ca-4dfc-5101-08de68eb58ea
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:28:35.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZRGHxO+vQUOGy00SML4MB0s7x3JnAAZqvRhe26fBppEfvfrSCCDyof7FIOW29c49+JZjXSJMf/oeZZKO9oocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

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

BPF scheduler custody concept: a task is considered to be in the BPF
scheduler's custody when the scheduler is responsible for managing its
lifecycle. This includes tasks dispatched to user-created DSQs or stored
in the BPF scheduler's internal data structures from ops.enqueue().
Custody ends when the task is dispatched to a terminal DSQ (such as the
local DSQ or %SCX_DSQ_GLOBAL), selected by core scheduling, or removed
due to a property change.

Tasks directly dispatched to terminal DSQs bypass the BPF scheduler
entirely and are never in its custody. Terminal DSQs include:
 - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
   where tasks go directly to execution.
 - Global DSQ (%SCX_DSQ_GLOBAL): the built-in fallback queue where the
   BPF scheduler is considered "done" with the task.

As a result, ops.dequeue() is not invoked for tasks directly dispatched
to terminal DSQs.

To identify dequeues triggered by scheduling property changes, introduce
the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
the dequeue was caused by a scheduling property change.

New ops.dequeue() semantics:
 - ops.dequeue() is invoked exactly once when the task leaves the BPF
   scheduler's custody, in one of the following cases:
   a) regular dispatch: a task dispatched to a user DSQ or stored in
      internal BPF data structures is moved to a terminal DSQ
      (ops.dequeue() called without any special flags set),
   b) core scheduling dispatch: core-sched picks task before dispatch
      (ops.dequeue() called with %SCX_DEQ_CORE_SCHED_EXEC flag set),
   c) property change: task properties modified before dispatch,
      (ops.dequeue() called with %SCX_DEQ_SCHED_CHANGE flag set).

This allows BPF schedulers to:
 - reliably track task ownership and lifecycle,
 - maintain accurate accounting of managed tasks,
 - update internal state when tasks change properties.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         |  78 ++++++++-
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            | 155 ++++++++++++++++--
 kernel/sched/ext_internal.h                   |   7 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 7 files changed, 221 insertions(+), 24 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a769..21c65e504da7c 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -229,16 +229,23 @@ The following briefly shows how a waking task is scheduled and executed.
    scheduler can wake up any cpu using the ``scx_bpf_kick_cpu()`` helper,
    using ``ops.select_cpu()`` judiciously can be simpler and more efficient.
 
-   A task can be immediately inserted into a DSQ from ``ops.select_cpu()``
-   by calling ``scx_bpf_dsq_insert()``. If the task is inserted into
-   ``SCX_DSQ_LOCAL`` from ``ops.select_cpu()``, it will be inserted into the
-   local DSQ of whichever CPU is returned from ``ops.select_cpu()``.
-   Additionally, inserting directly from ``ops.select_cpu()`` will cause the
-   ``ops.enqueue()`` callback to be skipped.
-
    Note that the scheduler core will ignore an invalid CPU selection, for
    example, if it's outside the allowed cpumask of the task.
 
+   A task can be immediately inserted into a DSQ from ``ops.select_cpu()``
+   by calling ``scx_bpf_dsq_insert()`` or ``scx_bpf_dsq_insert_vtime()``.
+
+   If the task is inserted into ``SCX_DSQ_LOCAL`` from
+   ``ops.select_cpu()``, it will be added to the local DSQ of whichever CPU
+   is returned from ``ops.select_cpu()``. Additionally, inserting directly
+   from ``ops.select_cpu()`` will cause the ``ops.enqueue()`` callback to
+   be skipped.
+
+   Any other attempt to store a task in BPF-internal data structures from
+   ``ops.select_cpu()`` does not prevent ``ops.enqueue()`` from being
+   invoked. This is discouraged, as it can introduce racy or inconsistent
+   state.
+
 2. Once the target CPU is selected, ``ops.enqueue()`` is invoked (unless the
    task was inserted directly from ``ops.select_cpu()``). ``ops.enqueue()``
    can make one of the following decisions:
@@ -252,6 +259,61 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   **Task State Tracking and ops.dequeue() Semantics**
+
+   A task is in the "BPF scheduler's custody" when the BPF scheduler is
+   responsible for managing its lifecycle. A task enters custody when it is
+   dispatched to a user DSQ or stored in the BPF scheduler's internal data
+   structures. Custody is entered only from ``ops.enqueue()`` for those
+   operations. The only exception is dispatching to a user DSQ from
+   ``ops.select_cpu()``: although the task is not yet technically in BPF
+   scheduler custody at that point, the dispatch has the same semantic
+   effect as dispatching from ``ops.enqueue()`` for custody-related
+   semantics.
+
+   Once ``ops.enqueue()`` is called, the task may or may not enter custody
+   depending on what the scheduler does:
+
+   * **Directly dispatched to terminal DSQs** (``SCX_DSQ_LOCAL``,
+     ``SCX_DSQ_LOCAL_ON | cpu``, or ``SCX_DSQ_GLOBAL``): the BPF scheduler
+     is done with the task - it either goes straight to a CPU's local run
+     queue or to the global DSQ as a fallback. The task never enters (or
+     exits) BPF custody, and ``ops.dequeue()`` will not be called.
+
+   * **Dispatch to user-created DSQs** (custom DSQs): the task enters the
+     BPF scheduler's custody. When the task later leaves BPF custody
+     (dispatched to a terminal DSQ, picked by core-sched, or dequeued for
+     sleep/property changes), ``ops.dequeue()`` will be called exactly
+     once.
+
+   * **Stored in BPF data structures** (e.g., internal BPF queues): the
+     task is in BPF custody. ``ops.dequeue()`` will be called when it
+     leaves (e.g., when ``ops.dispatch()`` moves it to a terminal DSQ, or
+     on property change / sleep).
+
+   When a task leaves BPF scheduler custody, ``ops.dequeue()`` is invoked.
+   The dequeue can happen for different reasons, distinguished by flags:
+
+   1. **Regular dispatch**: when a task in BPF custody is dispatched to a
+      terminal DSQ from ``ops.dispatch()`` (leaving BPF custody for
+      execution), ``ops.dequeue()`` is triggered without any special flags.
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
+   **Important**: Once a task has left BPF custody (e.g. after being
+   dispatched to a terminal DSQ), property changes will not trigger
+   ``ops.dequeue()``, since the task is no longer managed by the BPF
+   scheduler.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -319,6 +381,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..4601e5ecb43c0 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,6 +84,7 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_IN_CUSTODY	= 1 << 1, /* in custody, needs ops.dequeue() when leaving */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0bb8fa927e9e9..5f7c9088f90a9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -925,6 +925,27 @@ static void touch_core_sched(struct rq *rq, struct task_struct *p)
 #endif
 }
 
+/**
+ * is_terminal_dsq - Check if a DSQ is terminal for ops.dequeue() purposes
+ * @dsq_id: DSQ ID to check
+ *
+ * Returns true if @dsq_id is a terminal/builtin DSQ where the BPF
+ * scheduler is considered "done" with the task.
+ *
+ * Builtin DSQs include:
+ *  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
+ *    where tasks go directly to execution,
+ *  - Global DSQ (%SCX_DSQ_GLOBAL): built-in fallback queue,
+ *  - Bypass DSQ: used during bypass mode.
+ *
+ * Tasks dispatched to builtin DSQs exit BPF scheduler custody and do not
+ * trigger ops.dequeue() when they are later consumed.
+ */
+static inline bool is_terminal_dsq(u64 dsq_id)
+{
+	return dsq_id & SCX_DSQ_FLAG_BUILTIN && dsq_id != SCX_DSQ_INVALID;
+}
+
 /**
  * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
  * @rq: rq to read clock from, must be locked
@@ -1008,7 +1029,8 @@ static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p
 		resched_curr(rq);
 }
 
-static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
+static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
+			     struct scx_dispatch_q *dsq,
 			     struct task_struct *p, u64 enq_flags)
 {
 	bool is_local = dsq->id == SCX_DSQ_LOCAL;
@@ -1103,6 +1125,23 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
+	/*
+	 * Handle ops.dequeue() and custody tracking.
+	 *
+	 * Terminal DSQs: the BPF scheduler is done with the task. If it
+	 * was in BPF custody, call ops.dequeue() and clear the flag.
+	 *
+	 * Non-terminal DSQs: task is in BPF scheduler's custody.
+	 */
+	if (is_terminal_dsq(dsq->id)) {
+		if (SCX_HAS_OP(sch, dequeue) &&
+		    (p->scx.flags & SCX_TASK_IN_CUSTODY))
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
+		p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+	} else {
+		p->scx.flags |= SCX_TASK_IN_CUSTODY;
+	}
+
 	/*
 	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
 	 * direct dispatch path, but we clear them here because the direct
@@ -1323,7 +1362,7 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	dispatch_enqueue(sch, dsq, p,
+	dispatch_enqueue(sch, rq, dsq, p,
 			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
@@ -1407,13 +1446,19 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 * dequeue may be waiting. The store_release matches their load_acquire.
 	 */
 	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
+
+	/*
+	 * Task is now in BPF scheduler's custody. Set %SCX_TASK_IN_CUSTODY
+	 * so ops.dequeue() is called when it leaves custody.
+	 */
+	p->scx.flags |= SCX_TASK_IN_CUSTODY;
 	return;
 
 direct:
 	direct_dispatch(sch, p, enq_flags);
 	return;
 local_norefill:
-	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, enq_flags);
 	return;
 local:
 	dsq = &rq->scx.local_dsq;
@@ -1433,7 +1478,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -1511,6 +1556,27 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 		__scx_add_event(sch, SCX_EV_SELECT_CPU_FALLBACK, 1);
 }
 
+/*
+ * Call ops.dequeue() for a task leaving BPF custody.
+ */
+static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
+			      struct task_struct *p, u64 deq_flags,
+			      bool is_sched_change)
+{
+	if (SCX_HAS_OP(sch, dequeue)) {
+		/*
+		 * Set %SCX_DEQ_SCHED_CHANGE when the dequeue is due to a
+		 * property change (not sleep or core-sched pick).
+		 */
+		if (is_sched_change &&
+		    !(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+			deq_flags |= SCX_DEQ_SCHED_CHANGE;
+
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, deq_flags);
+	}
+	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+}
+
 static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 {
 	struct scx_sched *sch = scx_root;
@@ -1524,6 +1590,12 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 	switch (opss & SCX_OPSS_STATE_MASK) {
 	case SCX_OPSS_NONE:
+		/*
+		 * If the task is still in BPF scheduler's custody
+		 * (%SCX_TASK_IN_CUSTODY is set) call ops.dequeue().
+		 */
+		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
+			call_task_dequeue(sch, rq, p, deq_flags, true);
 		break;
 	case SCX_OPSS_QUEUEING:
 		/*
@@ -1532,9 +1604,12 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		if (SCX_HAS_OP(sch, dequeue))
-			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
-					 p, deq_flags);
+		/*
+		 * Task is BPF scheduler's custody (not dispatched yet).
+		 * Call ops.dequeue() to notify that it's leaving custody.
+		 */
+		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
+		call_task_dequeue(sch, rq, p, deq_flags, true);
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -1631,6 +1706,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
 {
+	struct scx_sched *sch = scx_root;
 	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
 
 	/* @dsq is locked and @p is on @dst_rq */
@@ -1639,6 +1715,16 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 
+	/*
+	 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
+	 * Call ops.dequeue() if the task was in BPF custody.
+	 */
+	if (p->scx.flags & SCX_TASK_IN_CUSTODY) {
+		if (SCX_HAS_OP(sch, dequeue))
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
+		p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+	}
+
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
 	else
@@ -1801,12 +1887,19 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 		!WARN_ON_ONCE(src_rq != task_rq(p));
 }
 
-static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
-				struct scx_dispatch_q *dsq, struct rq *src_rq)
+static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
+			       struct task_struct *p,
+			       struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	raw_spin_rq_unlock(this_rq);
 
 	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
+		/*
+		 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
+		 * Call ops.dequeue() if the task was in BPF custody.
+		 */
+		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
+			call_task_dequeue(sch, src_rq, p, 0, false);
 		move_remote_task_to_local_dsq(p, 0, src_rq, this_rq);
 		return true;
 	} else {
@@ -1867,6 +1960,13 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 						     src_dsq, dst_rq);
 			raw_spin_unlock(&src_dsq->lock);
 		} else {
+			/*
+			 * Moving to a local DSQ, dispatch_enqueue() is not
+			 * used, so call ops.dequeue() here if the task was
+			 * in BPF scheduler's custody.
+			 */
+			if (p->scx.flags & SCX_TASK_IN_CUSTODY)
+				call_task_dequeue(sch, src_rq, p, 0, false);
 			raw_spin_unlock(&src_dsq->lock);
 			move_remote_task_to_local_dsq(p, enq_flags,
 						      src_rq, dst_rq);
@@ -1879,7 +1979,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		dispatch_dequeue_locked(p, src_dsq);
 		raw_spin_unlock(&src_dsq->lock);
 
-		dispatch_enqueue(sch, dst_dsq, p, enq_flags);
+		dispatch_enqueue(sch, dst_rq, dst_dsq, p, enq_flags);
 	}
 
 	return dst_rq;
@@ -1922,7 +2022,7 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		}
 
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, dsq, task_rq)))
+			if (likely(consume_remote_task(sch, rq, p, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
@@ -1969,14 +2069,14 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	 * If dispatching to @rq that @p is already on, no lock dancing needed.
 	 */
 	if (rq == src_rq && rq == dst_rq) {
-		dispatch_enqueue(sch, dst_dsq, p,
+		dispatch_enqueue(sch, rq, dst_dsq, p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
 
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
+		dispatch_enqueue(sch, rq, find_global_dsq(sch, p), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
@@ -2014,9 +2114,16 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		 */
 		if (src_rq == dst_rq) {
 			p->scx.holding_cpu = -1;
-			dispatch_enqueue(sch, &dst_rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					 enq_flags);
 		} else {
+			/*
+			 * Moving to a local DSQ, dispatch_enqueue() is not
+			 * used, so call ops.dequeue() here if the task was
+			 * in BPF scheduler's custody.
+			 */
+			if (p->scx.flags & SCX_TASK_IN_CUSTODY)
+				call_task_dequeue(sch, src_rq, p, 0, false);
 			move_remote_task_to_local_dsq(p, enq_flags,
 						      src_rq, dst_rq);
 			/* task has been moved to dst_rq, which is now locked */
@@ -2113,7 +2220,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 	if (dsq->id == SCX_DSQ_LOCAL)
 		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
 	else
-		dispatch_enqueue(sch, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+		dispatch_enqueue(sch, rq, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
@@ -2414,7 +2521,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * DSQ.
 		 */
 		if (p->scx.slice && !scx_rq_bypassing(rq)) {
-			dispatch_enqueue(sch, &rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p,
 					 SCX_ENQ_HEAD);
 			goto switch_class;
 		}
@@ -2898,6 +3005,13 @@ static void scx_enable_task(struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
+
 	/*
 	 * Set the weight before calling ops.enable() so that the scheduler
 	 * doesn't see a stale value if they inspect the task struct.
@@ -2929,6 +3043,13 @@ static void scx_disable_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
+
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
 }
 
 static void scx_exit_task(struct task_struct *p)
@@ -3919,7 +4040,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		 * between bypass DSQs.
 		 */
 		dispatch_dequeue_locked(p, donor_dsq);
-		dispatch_enqueue(sch, donee_dsq, p, SCX_ENQ_NESTED);
+		dispatch_enqueue(sch, donee_rq, donee_dsq, p, SCX_ENQ_NESTED);
 
 		/*
 		 * $donee might have been idle and need to be woken up. No need
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
2.53.0

