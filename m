Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FC421886
	for <sched-ext@lists.linux.dev>; Thu,  5 Feb 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305607; cv=fail; b=DHhHNBW08M4EoMgR+p95Rlck/UCBC+AoBISImzjddkYzkgDsBSJqTfEtSE6R522l5/EiZdPoKXO2sgOQnP54MP/GowKNe/kME99eb3ZUtZ/UL2FSi3LN0Rj9JepmDWLOejLoIjjkHA1B6nnM8ckhIbIa02RD+4cwYa21APvDXZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305607; c=relaxed/simple;
	bh=M/boSoGYqz4GJs/w7UgJEScR4tUGx1jkG1JQXajUCyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KsjmXIQmn6P8OMFXs0yWdNdpleBFg8KK7d65IZixgMwUCYmQUnS2cEWrXTOCX5yJ3/2+S2ui2PQ33wGUWHiYXrfeeb++J+qxwcKGH4ekWCa2Wj2A/W8sHeadGii/XYFMFjUOjk9khB9IGOyuQYDE/pkVa0ppKsSRae7A5u0fPNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PdOUxIqn; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PdOUxIqn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/gBf+xdYWSWEX90Byx6d5F5jcPA3ZyL/R+YyJFNLHgzD406KYSzPpQMZuIt5s6/j/ZMNN7e2uRAZIUYNyhJu9HDXniFjeo0SMNqRa6OhIuLp7O8DNjFoTZGIEEZTtWHghhYTdenZHU9wUHrmAHShAak4CzQOO3AeL5DfhwyPTbO7TRBdCQK/sYw3qhnUbiwBp5E8wZigt/vLTr6Q/vLJ1qCxfo2o9VaiWav7uOQIB/fMLBsCN9fe5MmyCXtHMCKP8cF6EjWbtA2ObPxd+Vgp77po5boXGsz/rHBHipODpv3C5EQxkh5TevzslGu6MTOY36kKi3J1bI/Il6Co2/jTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LktoIu54Jc7WgxTFzQ57iD8iZboQFgK81IWxzgYoCVc=;
 b=sbrhFRwmnHaihkrf9uGJlap/szd+vR+I6x6xaOZjFwdfsrXuWUdONJKiWbYM9ShQsl8oCi7OzwlXIkB6jBns5hvdR524OikwNkONWCtSmJCPyaTkjRStQidrj+xAi9GlIZinAYpigalWaJ0f0bmyhzl5TBjGSL6pIsc4UqKwtn78b0noe8drVB1OfkPD2PEP/3hM+IH2bN4OUZc8odaMicF1Zsd+ky8qEX+M0/vAx9COGJ7H/aUgAWY68dX+79/N27y/0gJQ399P6TcPMAIGdtm4nEW+ZZzUd6UEAx2RJNckwp4QawJ8J9LpBLESl/FBQN1MHbZ42yZ5G6RymOz8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LktoIu54Jc7WgxTFzQ57iD8iZboQFgK81IWxzgYoCVc=;
 b=PdOUxIqnaAtApXTU29a11GlxOnu2oUMQD66kzsrRH4A9LLcuK1JRA8nRAQFtfK9t+7oilafgGpFYIj99KT9PN7+nCwKuAY4Hp5QFC8pcHjN1UslJ9OQgVuo17dgI14kd32acQO+ko9b+Xh61rU+zSqscmw674kpvrcNpYs7F/QGoGv7O1Od1uBy65UL0ap7lONwzeUj8DsxsC0OnacuPrfqnPdhcdxQZNAXOSVLxu4/sGMdtqp7rCqJbtDqxnlmkh6C9o8ZUttk7wY15VoBpz1jwQ9/5oWZlwklKNhHusMG77Haca5peSIrCla4uGJ71oBCWEtEFqIcL9+A/eGabxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 15:33:22 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:33:21 +0000
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
Date: Thu,  5 Feb 2026 16:32:15 +0100
Message-ID: <20260205153304.1996142-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205153304.1996142-1-arighi@nvidia.com>
References: <20260205153304.1996142-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 68125f24-67df-4129-0d47-08de64cbe4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQA0kJuwPK+29FrGfmjmazx9TUMocfTvtI2LZoJA3clAtCU5CKpzq7JCwNJS?=
 =?us-ascii?Q?90mQ+CsuzQrQdv1IMI1dHkW7H3pQapvxWX4M2wI61w1wTbOJq1hJrTKAd2wf?=
 =?us-ascii?Q?1b+1JHyQsmP2nGOKCgD9FBs5VSCwJvJy+wbXOA+JJv9GjEkGVlZ0RhS3I4th?=
 =?us-ascii?Q?eQiV40Jq2c7Ep/oJTbFRQCm/LHx9iVPatXQj7frvWq2GqvejxRcEi6Xfxr3u?=
 =?us-ascii?Q?pPxgdpG4AEQ4YTg+alHnFXxTIw69JFLuMLvd9nzDOFClwu/CiS/XP52hvh1/?=
 =?us-ascii?Q?DzLvF4zXTtTCJQDlYOT+rhlrGK6RcT7IRkxwl4ZYoKgCJlxM+QHYuKA4RQpb?=
 =?us-ascii?Q?yqcoIhB+qcqNy5MQPVTgI5KUcHTAsYpQvfoaruLrFJTsqwEbns5SA5maF6b+?=
 =?us-ascii?Q?ElstbwiAeOPj16HmARYq2AvutdQfJYHsqcHmayXqrHPBjHfUdooW35zak/uZ?=
 =?us-ascii?Q?jMAx4JCc0ro2qzUBStneEED/RElIrGEOuEImbZu9JTicNApXxs72P4qZ+KPm?=
 =?us-ascii?Q?O8mKwfO9IpPDg91POC6BNy0cd8H4QpzpSofmuUjChifiW+q3M6wNpsVOff07?=
 =?us-ascii?Q?52JNfixZ8Vdk8J9pIpFi/wCP+01/Ote7WRIKDba1Sg9EKi2qVZDG39luzqge?=
 =?us-ascii?Q?b6MeFisC37iD/IeZGWcpW+ZSqHBeaP2ZFSWXH72CDT03FQEeGFfkU+kbVNe/?=
 =?us-ascii?Q?ZKIqSOcA/MSorQ1Flw3MkJpplnH2t1CT01mUD7NJx9KLmFJL7KBHICSmpXre?=
 =?us-ascii?Q?zvfkNsmH6BsHDVEU1GGJ/iFIizfjpH9sGgZLocVIkgtCGa9SYt2LQBhes9QD?=
 =?us-ascii?Q?evSf18tgIuwdblCfq994I4nBj6Jlq2W26snRnU8X92D8tWfkR/Cf87N0bXE+?=
 =?us-ascii?Q?HChG4KiS8NbKZrjCK68ftFAauThI4M5y8BQhR2iW41T8axiNb6TQdzD1tpos?=
 =?us-ascii?Q?aLTyU4jdgfaGmgJ96HuaAesB4w/BVXGHph0GdXmNj92rkWH+gHKtc/WQr/gz?=
 =?us-ascii?Q?54/kRlIahE/8Lvn42TckuiV2pED8mnf/y9SE8u6HAJnlj9BmUKJ7Zsa4m2Hx?=
 =?us-ascii?Q?jFhQ9LumLgTVxiZaQnW5nD2fT+AhWighcjlkylR2dY0ZL8SX5yVJLMR4P3Fd?=
 =?us-ascii?Q?y7kBLJQ29PIRqhKGJcha5YfCWoMROhcU5Yh3r/6hxUk0I6OGuyOr0ADLTyKQ?=
 =?us-ascii?Q?4NR+xgrL+kAjw/uZEwtWJuWC/mHG991S1jZu5j0VRXwOs3u6XUWe8Fa0iyJI?=
 =?us-ascii?Q?r83D/H2W8Gizb/5FmUJItkwFruArLZAXeO6QuWV2UyzSFxbYIF5NDe49cd/p?=
 =?us-ascii?Q?a+BzPanEwY2MLKzEcRNWDVt3a8cgJUH9MWoXAFVSKEuNKwFCXIJsGN+axQBZ?=
 =?us-ascii?Q?0HJFPrFZ05OM9eWqKm85Hs7Gwm5t0nbyCDxg0oBqJBsyFGj+Yc7cZzzj6VdT?=
 =?us-ascii?Q?pGopzYMLe3u6ltXz4QyNVjwCJlQ4fKoWA1SuIPZ9dSCZBG+sDbr50EqXAIq9?=
 =?us-ascii?Q?i4u0IdCpFsCK8NVmCVzEyEGnlnUbn0duWWo6T9c2JaGQQyTx0uH/YEueLTzX?=
 =?us-ascii?Q?wTzDy1Eptw0GmuVTjaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9zOpL+Geq+fSPm6BgtY/lE1kPbQaUmfdNCOK6KYHreP0VtF39DDBzs+HpJsv?=
 =?us-ascii?Q?JfsUw68KoBPfVKYhMlydNMza7k9tR7RbyDjOaHa66GMihE5rLFPoH3IPRtK9?=
 =?us-ascii?Q?ciPuxdMUtLRx+u50cWZc7OzKK6hxkQc91bK5UWID+6l0DBBhezM//wJwIC3e?=
 =?us-ascii?Q?uA2oYdwishJqm4D1Bfc+G2NPwFtnkhVTIgpR3rab7l3dqe7Rs35cBWp4k/Hz?=
 =?us-ascii?Q?ZPL3RgeAozkBcOwX/ok1d7LFEoE2CxBz9KLCghwBAJK5kDh6KbWpPNGR/u4i?=
 =?us-ascii?Q?d5ubfQeZP9SwitqWe4Rs3newt+kXzm4D/oFjs8FDo1Ioruckk2gbQ/Rq7KKj?=
 =?us-ascii?Q?K1SM9VEBxsX0vZhNOXPuvj8tPGjKa5qw0LWdZXNR8B05pRyqQy9o99ehr2cG?=
 =?us-ascii?Q?7q+MQk81Vt+rF6OJ3Ncg0mkisybkyR0rplg/yI2FvKtMIefZAF2AhYzmWiuc?=
 =?us-ascii?Q?XdHG05cZm8yO1xeWXio92HtHpnqIT4GiLmPZbtxUaiMpMBa/w081pOXaa8cq?=
 =?us-ascii?Q?jXB9jDs+EXIsHa5gURfvBxFFMAwcm/QY9vFjA7sZ5FWhvmxrrzoBrKBwXaNS?=
 =?us-ascii?Q?14bxAheMIMyaIFUgXBnlnNv3vyoDhjGUJ3HGBwVMSPKHSIyJWhvm9SH0v2wz?=
 =?us-ascii?Q?/UXPwLe/erqzD2AAHmJu7xXozYqgRHFQ0Sc4WJdQsQ+j8dgGdCNlm8uRgxVq?=
 =?us-ascii?Q?xANVmLC6GDzXjxf7UkGo9c8sAHTXceic3riV1EUOzUAyVy7VCyrgIxzXmHO8?=
 =?us-ascii?Q?mGBSHxu6gw5ZEOkAX8yf7XTr7PhqKy+LFf3O1d3i+GfMvbc7LEVFY48shjdY?=
 =?us-ascii?Q?QUX6SIV6cfRB95hr8EAmAx6vwJWpQv0+TxfQqLtXmYEPs9iPQe2hytUqFVR3?=
 =?us-ascii?Q?DlIYDsmoFruGG+I+zTEpdcttQMhvXs/Jd2rBXbe4qlp2iAWNeGUwymX6lmlN?=
 =?us-ascii?Q?ogbY2eUpfMaqeY6lrswhL8q0c5BYsjqNOwIrfHvYV3Xh8YrH3M35l787eQNf?=
 =?us-ascii?Q?cssskp4aI3uNzBSPwxlxKg0sH/G3r9iNdHxwHYX32c+akSaE7LapJca87Z59?=
 =?us-ascii?Q?AM5m3r312VuCresfsXSKBgScNkEysFo5pFLwvMMkqNySSB5SS2+Vu3/ssj7z?=
 =?us-ascii?Q?k1ft3M1DF1jpYthpalhftlrQrz7ofyVBLfuD7J4hQQ7gtscSGaEPXEnKMnwJ?=
 =?us-ascii?Q?JySanZj/fDy1CVFwMKBUK/DlNSwg2eiGm9FGsQXIRlj6DLJntLJzNikT/a34?=
 =?us-ascii?Q?BALtG3GW4+btcFuo7Dpkm2yNC/hUN68RcsWHXSTCkmTW1LoGNEwylDIXmChZ?=
 =?us-ascii?Q?qwN3gESzoIow7NjD5AUuj6gZoIMJpvXHS713nQaCbVN40DjE1/CQMMzvzOMa?=
 =?us-ascii?Q?S5hP7Ac59jTeeZs6gyYYr0Ay/vsoBGuTBt0Z2mEdudAmEDfE6zrhBHm5bp02?=
 =?us-ascii?Q?bz0lQuJrgqkIWRbEA8ScS7MjPQKOrEyeCy/njcD8x0VpDvbxSKxdOXqrgno8?=
 =?us-ascii?Q?KYhgik7yEPM0009hbPshim/5y4m8LdWGL8rWWzusBsRQEdgNqXxtW/5n0eji?=
 =?us-ascii?Q?+c/CNzyJM2MemL+Y3MWKtlk2+6jY2cjGCZEW2n57Jf28NLPhOr/TGedXiJkM?=
 =?us-ascii?Q?51xWp70anaZmJ/T0rZmV2gXn+vm8IAiM3W+a22v1+4axapyif3hptqpBBUBT?=
 =?us-ascii?Q?NDhB78c+4SWHmePzEQGrtnIYsiNlFIr5qz63eRcXXW2TyYUvcecZquEtZltj?=
 =?us-ascii?Q?CMEERQz4gQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68125f24-67df-4129-0d47-08de64cbe4f8
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:33:21.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1sq935UaLe1NMyXu2YF4hHZZXleqUCO/4E0eQgiKFdEjGiLAHIl1Lc8QIf6p41ZJTMn3bOOQlHZD6N0PHKs3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803

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
scheduler's custody" when it has been queued in user-created DSQs and
the BPF scheduler is responsible for its lifecycle. Custody ends when
the task is dispatched to a terminal DSQ (local DSQ or SCX_DSQ_GLOBAL),
selected by core scheduling, or removed due to a property change.

Tasks directly dispatched to terminal DSQs bypass the BPF scheduler
entirely and are not in its custody. Terminal DSQs include:
 - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
   where tasks go directly to execution.
 - Global DSQ (%SCX_DSQ_GLOBAL): the built-in fallback queue where the
   BPF scheduler is considered "done" with the task.

As a result, ops.dequeue() is not invoked for tasks dispatched to
terminal DSQs, as the BPF scheduler no longer retains custody of them.

To identify dequeues triggered by scheduling property changes, introduce
the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
the dequeue was caused by a scheduling property change.

New ops.dequeue() semantics:
 - ops.dequeue() is invoked exactly once when the task leaves the BPF
   scheduler's custody, in one of the following cases:
   a) regular dispatch: a task dispatched to a user DSQ is moved to a
      terminal DSQ (ops.dequeue() called without any special flags set),
   b) core scheduling dispatch: core-sched picks task before dispatch,
      ops.dequeue() called with %SCX_DEQ_CORE_SCHED_EXEC flag set,
   c) property change: task properties modified before dispatch,
      ops.dequeue() called with %SCX_DEQ_SCHED_CHANGE flag set.

This allows BPF schedulers to:
 - reliably track task ownership and lifecycle,
 - maintain accurate accounting of managed tasks,
 - update internal state when tasks change properties.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         |  53 +++++++
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            | 130 ++++++++++++++++--
 kernel/sched/ext_internal.h                   |   7 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 7 files changed, 182 insertions(+), 13 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a769..ccd1fad3b3b92 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -252,6 +252,57 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   **Task State Tracking and ops.dequeue() Semantics**
+
+   Once ``ops.select_cpu()`` or ``ops.enqueue()`` is called, the task may
+   enter the "BPF scheduler's custody" depending on where it's dispatched:
+
+   * **Direct dispatch to terminal DSQs** (``SCX_DSQ_LOCAL``,
+     ``SCX_DSQ_LOCAL_ON | cpu``, or ``SCX_DSQ_GLOBAL``): The BPF scheduler
+     is done with the task - it either goes straight to a CPU's local run
+     queue or to the global DSQ as a fallback. The task never enters (or
+     exits) BPF custody, and ``ops.dequeue()`` will not be called.
+
+   * **Dispatch to user-created DSQs** (custom DSQs): the task enters the
+     BPF scheduler's custody. When the task later leaves BPF custody
+     (dispatched to a terminal DSQ, picked by core-sched, or dequeued for
+     sleep/property changes), ``ops.dequeue()`` will be called exactly once.
+
+   * **Queued on BPF side**: The task is in BPF data structures and in BPF
+     custody, ``ops.dequeue()`` will be called when it leaves.
+
+   The key principle: **ops.dequeue() is called when a task leaves the BPF
+   scheduler's custody**.
+
+   This works also with the ``ops.select_cpu()`` direct dispatch
+   optimization: even though it skips ``ops.enqueue()`` invocation, if the
+   task is dispatched to a user-created DSQ, it enters BPF custody and will
+   get ``ops.dequeue()`` when it leaves. If dispatched to a terminal DSQ,
+   the BPF scheduler is done with it immediately. This provides the
+   performance benefit of avoiding the ``ops.enqueue()`` roundtrip while
+   maintaining correct state tracking.
+
+   The dequeue can happen for different reasons, distinguished by flags:
+
+   1. **Regular dispatch workflow**: when the task is dispatched from a
+      user-created DSQ to a terminal DSQ (leaving BPF custody for execution),
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
+   **Important**: Once a task has left BPF custody (dispatched to a
+   terminal DSQ), property changes will not trigger ``ops.dequeue()``,
+   since the task is no longer being managed by the BPF scheduler.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -319,6 +370,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..35a88942810b4 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,6 +84,7 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_NEED_DEQ	= 1 << 1, /* task needs ops.dequeue() */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0bb8fa927e9e9..9ebca357196b4 100644
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
+	return dsq_id & SCX_DSQ_FLAG_BUILTIN;
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
@@ -1103,6 +1125,27 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
+	/*
+	 * Handle ops.dequeue() and custody tracking.
+	 *
+	 * Builtin DSQs (local, global, bypass) are terminal: the BPF
+	 * scheduler is done with the task. If it was in BPF custody, call
+	 * ops.dequeue() and clear the flag.
+	 *
+	 * User DSQs: Task is in BPF scheduler's custody. Set the flag so
+	 * ops.dequeue() will be called when it leaves.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		if (is_terminal_dsq(dsq->id)) {
+			if (p->scx.flags & SCX_TASK_NEED_DEQ)
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue,
+						 rq, p, 0);
+			p->scx.flags &= ~SCX_TASK_NEED_DEQ;
+		} else {
+			p->scx.flags |= SCX_TASK_NEED_DEQ;
+		}
+	}
+
 	/*
 	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
 	 * direct dispatch path, but we clear them here because the direct
@@ -1323,7 +1366,7 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	dispatch_enqueue(sch, dsq, p,
+	dispatch_enqueue(sch, rq, dsq, p,
 			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
@@ -1413,7 +1456,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	direct_dispatch(sch, p, enq_flags);
 	return;
 local_norefill:
-	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, enq_flags);
 	return;
 local:
 	dsq = &rq->scx.local_dsq;
@@ -1433,7 +1476,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, dsq, p, enq_flags);
+	dispatch_enqueue(sch, rq, dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -1511,6 +1554,18 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 		__scx_add_event(sch, SCX_EV_SELECT_CPU_FALLBACK, 1);
 }
 
+static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
+			      struct task_struct *p, u64 deq_flags)
+{
+	u64 flags = deq_flags;
+
+	if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+		flags |= SCX_DEQ_SCHED_CHANGE;
+
+	SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
+	p->scx.flags &= ~SCX_TASK_NEED_DEQ;
+}
+
 static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 {
 	struct scx_sched *sch = scx_root;
@@ -1524,6 +1579,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 	switch (opss & SCX_OPSS_STATE_MASK) {
 	case SCX_OPSS_NONE:
+		/*
+		 * Task is not in BPF data structures (either dispatched to
+		 * a DSQ or running). Only call ops.dequeue() if the task
+		 * is still in BPF scheduler's custody (%SCX_TASK_NEED_DEQ
+		 * is set).
+		 *
+		 * If the task has already been dispatched to a terminal
+		 * DSQ (local DSQ or %SCX_DSQ_GLOBAL), it has left the BPF
+		 * scheduler's custody and the flag will be clear, so we
+		 * skip ops.dequeue().
+		 *
+		 * If this is a property change (not sleep/core-sched) and
+		 * the task is still in BPF custody, set the
+		 * %SCX_DEQ_SCHED_CHANGE flag.
+		 */
+		if (SCX_HAS_OP(sch, dequeue) &&
+		    (p->scx.flags & SCX_TASK_NEED_DEQ))
+			call_task_dequeue(sch, rq, p, deq_flags);
 		break;
 	case SCX_OPSS_QUEUEING:
 		/*
@@ -1532,9 +1605,14 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
+		/*
+		 * Task is still on the BPF scheduler (not dispatched yet).
+		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
+		 * only for property changes, not for core-sched picks or
+		 * sleep.
+		 */
 		if (SCX_HAS_OP(sch, dequeue))
-			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
-					 p, deq_flags);
+			call_task_dequeue(sch, rq, p, deq_flags);
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -1631,6 +1709,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
 {
+	struct scx_sched *sch = scx_root;
 	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
 
 	/* @dsq is locked and @p is on @dst_rq */
@@ -1639,6 +1718,15 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 
+	/*
+	 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
+	 * Call ops.dequeue() if the task was in BPF custody.
+	 */
+	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_NEED_DEQ)) {
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
+		p->scx.flags &= ~SCX_TASK_NEED_DEQ;
+	}
+
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
 	else
@@ -1879,7 +1967,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		dispatch_dequeue_locked(p, src_dsq);
 		raw_spin_unlock(&src_dsq->lock);
 
-		dispatch_enqueue(sch, dst_dsq, p, enq_flags);
+		dispatch_enqueue(sch, dst_rq, dst_dsq, p, enq_flags);
 	}
 
 	return dst_rq;
@@ -1969,14 +2057,14 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
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
@@ -2014,7 +2102,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		 */
 		if (src_rq == dst_rq) {
 			p->scx.holding_cpu = -1;
-			dispatch_enqueue(sch, &dst_rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					 enq_flags);
 		} else {
 			move_remote_task_to_local_dsq(p, enq_flags,
@@ -2113,7 +2201,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 	if (dsq->id == SCX_DSQ_LOCAL)
 		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
 	else
-		dispatch_enqueue(sch, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+		dispatch_enqueue(sch, rq, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
@@ -2414,7 +2502,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * DSQ.
 		 */
 		if (p->scx.slice && !scx_rq_bypassing(rq)) {
-			dispatch_enqueue(sch, &rq->scx.local_dsq, p,
+			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p,
 					 SCX_ENQ_HEAD);
 			goto switch_class;
 		}
@@ -2898,6 +2986,14 @@ static void scx_enable_task(struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		WARN_ON_ONCE(p->scx.flags & SCX_TASK_NEED_DEQ);
+
 	/*
 	 * Set the weight before calling ops.enable() so that the scheduler
 	 * doesn't see a stale value if they inspect the task struct.
@@ -2929,6 +3025,14 @@ static void scx_disable_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
+
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	if (SCX_HAS_OP(sch, dequeue))
+		WARN_ON_ONCE(p->scx.flags & SCX_TASK_NEED_DEQ);
 }
 
 static void scx_exit_task(struct task_struct *p)
@@ -3919,7 +4023,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
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

