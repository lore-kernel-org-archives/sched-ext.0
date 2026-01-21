Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440947F2EC
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998695; cv=fail; b=j3kDaAFfXymx5RS8bEavdsZJ5FFsPT2Uq4xJKT/37gHkUrPP97Obz7OuKk788IvVUpLCL9VUM1fYwAjBFzUE01tJOqbMylqhuqVs8+8Ds4xxbjrmDQXGH6hNlUcvclGIT7/gW2axEU6GMWSqMdIOraC9LcqsDKMH1ja0ZtEva9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998695; c=relaxed/simple;
	bh=9U3fSi0n3lWpHIKKX0INDs1v+mqnwALxLlEKGDbwCDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJ8VxdOIr8eHZo4CgHs+yK9UfGipN6i14pKsz5TQwXB7GfP0Pc5OJWg+7gA2A7SqmZOgcgbl1U4sJi47ri1IbNI/REPal/c7UGwUn4f2e1gruMNbBPNNZMvrOjhs7QWK4xM9fCQdpJXAU+wtaEFZyQLwD5tbGLopu9C61fh9OaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0RiK7NC; arc=fail smtp.client-ip=40.107.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0RiK7NC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHmox1HjLEwiOJYNgcob/PjRXzWLC5UF059THbbgaa4Dnv+EdZuEq+n+5bjnZLnG4IF1+RqmwT7FS71WS983Kkg4x9GgQHW60ql6OazEGX3sUC1BfHqrzW84kTPpcnThQanbZj/dmxAxUQpAX6U57ClNsTCTTjd9qjmB22mtRz+HYKp4SyFIywRQjlbnKlAD6M3yFEqxKRDODGgUTVsyxsWFOgJYP9aXmXfSFBWex9j1Ko/MXDJ49N9kwkAjUZ3HKZlFJ819s1sGFIUo3OENVti0b5Y74SrsX7ErWrHD2ImJ9Gb+1ut+CqjY9Nkd+Wrkh5UWvg1CMEw5Jdwqh6N39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MasqPS5jlPdIKreFsGdkYi42jAG5VNA93yD5QfdHQM=;
 b=wxaJDUb+boVRTgGeF7TYhWoRtcp+NuTgEkxnIpEtzZe5CA84b8uGqzhwNH2NYLH4y49YZdU4kIdm/PRQQmYChS5W0vYi97jro2EHDRNwuIgKAgaKg/CYR8d7/wsmfLdQ0KRtkRe6aSi4cbgX+Wqf2XGcbJSdjjJ+zEOcf894fQ5vnMc96+29nzFNhsQwp9W9bNqlJRz1KFKDo1I0WoTfJaEVI4NR+5O2tHEruzYCqltnd7gV+7EYKtmYt5bb2LfY9sdB1Ox5Y8j/XZ9Rkux4eZC/p7N3zY6sdE0DX7GLQKQzL3RerH7eMl03L6VESpWPtLPeEAv71s+kfLzV0Cdt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MasqPS5jlPdIKreFsGdkYi42jAG5VNA93yD5QfdHQM=;
 b=R0RiK7NCVY9btmtPRYrmPjZuQeBYul5k/puwvEtfO2yN5HIrKMwWQBjRCxvrt52CF6BgtakSbZPSk5sTX4+F1PPGlEef1ZXVuK2PdAhH0ldb36PQSDC1g6pUt7fzXeDJtAN2eBi76SULy6M540oWMVV3nN5RIL5l+tPqxpJoQI/Nvk5O8sAio1lH5ZeoPoPQ46+D6mGejCACbCJBWIY62ab9qIJY2S5Q638rBHZiTF7zlHepJKe6a0racL3XC2Xe08L2K7mJB53av2dbLNMxXlOdx3XplW0Rz7ponlWlePRXeWtv4k2SDAOLBvC6Nxu2iIwlBVIhY5MJFb5JCokC/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:31:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:31:27 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Date: Wed, 21 Jan 2026 13:25:30 +0100
Message-ID: <20260121123118.964704-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121123118.964704-1-arighi@nvidia.com>
References: <20260121123118.964704-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: f5aa0714-7019-416e-cb68-08de58e8ff43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?axHRQKu/ATSJFdMQsXtctxwC8BtNqMmrazL8Zc5E6TBe9y3kkAFOMdAiyAV3?=
 =?us-ascii?Q?ubJQQ6tKm65y3kHIOseuYqEy1R1V0pWRwyEzBYfgKJFwIPZTo/GQmnoX9yNx?=
 =?us-ascii?Q?yxBGxjli1SELj5MBxvtsFWh7SXf9ApyjfAwhZVWCql05yu4E/osmANBc2uF/?=
 =?us-ascii?Q?OQSp6F+PTXVMF4eQ6Uvyffl/O4kKlg72qj44D8KrLzivYyrenJ2RDnWBv9T2?=
 =?us-ascii?Q?XCEUrayELGsgm8DQxl1uPaHM1CDlR0wKPemZPaPjA1hZx3P1jTvl6dE9nJ8e?=
 =?us-ascii?Q?VPRY8sOmEkoE4P7U8VJ8yFBZuZ5I3NO96qCEFHXJhAE/Z1tarww7Ded+QXRt?=
 =?us-ascii?Q?4WGyqFsJMvfwDhoEMwcTvQvQsLY0VsAb9rzyEzEqKTm5i7Pf7JlNPO4olWSb?=
 =?us-ascii?Q?46NtU0rHgEs0mvrK4QB67wbc267kxvrMrO3M4v0HE3zQeC5Js86s5+SHMNVn?=
 =?us-ascii?Q?CzPC2XfBtcHAad//p6ySMTtE/azWl266bH3PeTyBPqQrteabSHEnglPu83he?=
 =?us-ascii?Q?1FZ8KTdn/moUuaXyP8YBU/ylw3snmAABbjgsnhInJ4jH/AwJBRxz8xX0urB1?=
 =?us-ascii?Q?BlsaoKZOdeU+Ha7sz2mfKSC2a2paLoYq0lSABoS370V1rOy7Dr7h+E1JfDpu?=
 =?us-ascii?Q?KMy0i46f2BgwhmELNMGUawAEtFEvgfRyR1k9kYkiBTtWO9tLYySPKZZag9bX?=
 =?us-ascii?Q?mB4y4H+XBMJDWkfqGzVYtRmp+sBt/nNY/HkIZXgUbUcdHPeLIs2yk3lrfOhz?=
 =?us-ascii?Q?nHqY5GyeDQ2c9ZaJCcaZEcFRWGntE7zzCgzKlI70oR4yH6SFyvKFCB2zqqwd?=
 =?us-ascii?Q?04xL7RFJxeCZQ0E+yQm0L29y9D4BhNqv9atN/hXzdohaVmiVB0f4Y3mF+Myj?=
 =?us-ascii?Q?JuTla0xwrsd5KpadhGNzkRqKQSpVtb1X79kZdtbPNB2VKGXyYtuZ4+1sarkE?=
 =?us-ascii?Q?SvQHdkVaqY/FGdoXwy2jsPqGQxIaBWy5WHHPiRyHOVxHObPgRKubNbfd/CGA?=
 =?us-ascii?Q?2xwZWIN0Y0UEq8SflfcAK05ebfUX0BAdqSKZAznOXiL9KvFCKgoljSvrmriD?=
 =?us-ascii?Q?7WPdyQiO8CoUPWmCcoEl1ByV5znjFx534vpf9J8c3ONliGmnm9dMiedxwXrU?=
 =?us-ascii?Q?tUWkmGHALreiYbk7MTleOPHdzYBXd1Nhm3HH+l2ADuCMlBe9H3EzJDv69nBV?=
 =?us-ascii?Q?YkuJspjPZTX3Sc5nPgNORkyq5VK47cJq7rjCX3elrvS15Vz6L5H3ya8MDLbG?=
 =?us-ascii?Q?ZNpENllZeDR+ya6DCTqQ69TsyVopELohoGThc+a+JPCrdya02+P51DyOo2py?=
 =?us-ascii?Q?gXJ8ehp5iGk0ekjA78bxmNITSw8sAvrvWISPgccWLJcYKYdLhRZBRXVmyhG6?=
 =?us-ascii?Q?etlms+zggSPRVWEvpb2Atz5soD7mrjYOYeuG1/WDSQQY3oLvuqC5hdLNmlG1?=
 =?us-ascii?Q?Y/3jUy17R+9lajDmBkQltfZcSyv2svYDF17FV+khtMieOhYkVTyAOBjGV+Wg?=
 =?us-ascii?Q?X7UOEJWFQUDQ+xojVgYOT3lun9ygiA0teRAceq4Y63eEzuo+Rm9emk738l/U?=
 =?us-ascii?Q?Px81Rr4WpbHDXQGbMWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XpfaVRG8I2IwOW9ESD+QSjzzkNedMlecQBz/2i/3Bu08X3OP2BNfBxitnFa4?=
 =?us-ascii?Q?52hShUoHT60GITpsWqQaJJGrSfZTbYdAAzsUFgY0LoBEYSqJjuoNXnS1TOft?=
 =?us-ascii?Q?N/mdwntHJ2xgaZi7rKSmHTApwxUx8eAkl8sse7jPU1t67WyVTdTDxuIo06Zb?=
 =?us-ascii?Q?rNt9Om2WFf8W/8ULEq1R0CEJUzb5zrWO9HowC3Kt0Eygfc3FfFLsVlF+UM2V?=
 =?us-ascii?Q?G3LRzWM3QPCiMKkV8g1OgLYSV2hBl8hvpduy9UHyziDwAL83KAwpzz0tCMNo?=
 =?us-ascii?Q?kXBJmlXYXHH0madSxCPJ2mcU8ClXhYMDiG0Msv1t3unc1tUtKmYmY9zR19MH?=
 =?us-ascii?Q?dSK7F5Z2jT2z50mMLQkmQ7WOlua8l4KJJqp7O3W77JokusKoRnHBNV410chk?=
 =?us-ascii?Q?uNFQZOjFWBzTDiSdOITJChoAOaTWVTXoCN2WpYnzymE04azWYAQ5mq1RJT9D?=
 =?us-ascii?Q?DDmZCPkUw/50Mzm9gfrhpE5hVKlGavn/iHxmT73DBE5eQFuvZNzSlBh4xjnp?=
 =?us-ascii?Q?RqXdndXZozgqmO1ySJHNqIzuUGkwpScpculc/zTXukZQ8fZ4zPV4xTaHejv8?=
 =?us-ascii?Q?M6aHzqKp6kzGdrNHSOoQmeDDbTPfJJy1+n5r5QJLuwY7P3G+NJ+tdRkGKqpr?=
 =?us-ascii?Q?wHRPkLDjTT1jqOyPoO3VFnnfurK9FGAwx8vQm0CUfpJWU5hvWF40ZCFxeLsT?=
 =?us-ascii?Q?v4kwdRxYPnkt7DmJoRlpE04ECCB+wh/yUOXgROrdy4vFlgi7KW0AayspO+P3?=
 =?us-ascii?Q?ecuP1Tt5T/bKDROZdDMfR+ci9oNYjrUmXho8HV4Rp729QaqyblNxXnY1IU1u?=
 =?us-ascii?Q?ULSR1ZKdDDPn6riU+KIsi1o5dkHZOGkODYaZ2WSIcecDXzTiNb8E/OKrImlP?=
 =?us-ascii?Q?jPQcYYNt6mH7o9FFUwaiE8nJoeakiX/n3dBKSGoWZ0uXVc4Pd8Eoz7rWZJUk?=
 =?us-ascii?Q?rsBteoVgun3M2zEsgkmbJWLHd9AMHqFWSd6ENZp/JhYLncevu8/jvo46vAyh?=
 =?us-ascii?Q?65ZwfoqfisL15hKE+3E27I7ykcSbqBxbbN644jH+Z7EV6wKq3zuZ6p0Dcs2+?=
 =?us-ascii?Q?m6FBbjy8++rov01V965IDDsck4NchA2uKWUwWBXnbOBBIhjRxhyq6mfjNZVj?=
 =?us-ascii?Q?XcTgqrtVdO60SP0yCupmC3dPCSP7+i+81P0qoj4OGWcfkkEdgxoqsoBudNEU?=
 =?us-ascii?Q?fc5WgXsk1cRUuNTvj9S28LXkY9By5QUvFzVUpzSyO8otUNjLKKZRE3dgc8Jr?=
 =?us-ascii?Q?Ei3SQLbX1rxh+/ca4TrzbEOT6w9nadzJzb5pg8tEudwNNkJuEK41uh/zFUrP?=
 =?us-ascii?Q?o00+J0Aoyrels67Bu7Mbyw0lkvJ+p1o42gxj7psV4SiQwELhO8lHDPFCA0Fh?=
 =?us-ascii?Q?HSI++PGnwruymrava3QN7FIX+tMIHqKgJOPvFJTFcyrHblOhMCtPp6ehNBeB?=
 =?us-ascii?Q?lWOXAMLORN7zFpu4e79ZKAFBh/rWi0HL44wJDshzhwJ/i5XNBDwDiXc1PalA?=
 =?us-ascii?Q?PGi5fuohZsDIP7IPdnQsR13EyK5TIpIK2QoFpMgolcSf/V0AB/B+W0VZKAWG?=
 =?us-ascii?Q?bUTNSDtDuGYSL565c2fr0XG0SMNkkg4mRwof3r1Ank/yHXJEMaKDnufTZm6o?=
 =?us-ascii?Q?/bzlwRXb/2OFsRI7AP5tAWLX8wTnP637rO1Mfu2NPCuC+R7Mv/k/nTmhP2wL?=
 =?us-ascii?Q?EXeqYflKPez8nsob8eo1zUBnzVLv+Ds/0Yneg1pZX9i74N1JYWlAZpY8EkdQ?=
 =?us-ascii?Q?gtXBd3mTug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5aa0714-7019-416e-cb68-08de58e8ff43
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:31:27.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqooNh10sdXJZsp1Irj7qaoXq7xG37+fY3nCmYgUbC9/GDofX/lzmOrlipJk0hEPmmPjqmcO+pn4si/QA1vUJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

Currently, ops.dequeue() is only invoked when the sched_ext core knows
that a task resides in BPF-managed data structures, which causes it to
miss scheduling property change scenarios. As a result, BPF schedulers
cannot reliably track task state.

In addition, some ops.dequeue() callbacks can be skipped (e.g., during
direct dispatch), so ops.enqueue() calls are not always paired with a
corresponding ops.dequeue(), potentially breaking accounting logic.

Fix this by guaranteeing that every ops.enqueue() is matched with a
corresponding ops.dequeue(), and introduce the SCX_DEQ_ASYNC flag to
distinguish dequeues triggered by scheduling property changes from those
occurring in the normal dispatch workflow.

New semantics:
1. ops.enqueue() is called when a task enters the BPF scheduler
2. ops.dequeue() is called when the task leaves the BPF scheduler,
   because it is dispatched to a DSQ (regular workflow)
3. ops.dequeue(SCX_DEQ_ASYNC) is called when the task leaves the BPF
   scheduler, because a task property is changed (sched_change)

The SCX_DEQ_ASYNC flag allows BPF schedulers to distinguish between a
regular dispatch workflow and a task property changes (e.g.,
sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
balancing, CPU migrations, etc.).

This allows BPF schedulers to:
- reliably track task ownership and lifecycle,
- maintain accurate accounting of enqueue/dequeue pairs,
- update internal state when tasks change properties.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         | 33 ++++++++++
 include/linux/sched/ext.h                     | 11 ++++
 kernel/sched/ext.c                            | 63 ++++++++++++++++++-
 kernel/sched/ext_internal.h                   |  6 ++
 .../sched_ext/include/scx/enum_defs.autogen.h |  2 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |  2 +
 tools/sched_ext/include/scx/enums.autogen.h   |  1 +
 7 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a769..960125c1439ab 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -252,6 +252,37 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   Once ``ops.enqueue()`` is called, the task enters the "enqueued state".
+   The task remains in this state until ``ops.dequeue()`` is called, which
+   happens in two cases:
+
+   1. **Regular dispatch workflow**: when the task is successfully
+      dispatched to a DSQ (local, global, or user DSQ), ``ops.dequeue()``
+      is triggered immediately to notify the BPF scheduler.
+
+   2. **Scheduling property change**: when a task property changes (via
+      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
+      priority changes, CPU migrations, etc.), ``ops.dequeue()`` is called
+      with the ``SCX_DEQ_ASYNC`` flag set in ``deq_flags``.
+
+   **Important**: ``ops.dequeue()`` is called for *any* enqueued task,
+   regardless of whether the task is still on a BPF data structure, or it
+   has already been dispatched to a DSQ. This guarantees that every
+   ``ops.enqueue()`` will eventually be followed by a corresponding
+   ``ops.dequeue()``.
+
+   The ``SCX_DEQ_ASYNC`` flag allows BPF schedulers to distinguish between:
+   - normal dispatch workflow (task successfully dispatched to a DSQ),
+   - asynchronous dequeues (``SCX_DEQ_ASYNC``): task property changes that
+     require the scheduler to update its internal state.
+
+   This makes it reliable for BPF schedulers to track the enqueued state
+   and maintain accurate accounting.
+
+   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
+   don't need to track these transitions. The sched_ext core will safely
+   handle all dequeue operations regardless.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -319,6 +350,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..f3094b4a72a56 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,8 +84,19 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	/*
+	 * Set when ops.enqueue() is called; used to determine if ops.dequeue()
+	 * should be invoked when transitioning out of SCX_OPSS_NONE state.
+	 */
+	SCX_TASK_OPS_ENQUEUED	= 1 << 1,
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
+	/*
+	 * Set when ops.dequeue() is called after successful dispatch; used to
+	 * distinguish dispatch dequeues from async dequeues (property changes)
+	 * and to prevent duplicate dequeue calls.
+	 */
+	SCX_TASK_DISPATCH_DEQUEUED = 1 << 4,
 
 	SCX_TASK_STATE_SHIFT	= 8,	  /* bit 8 and 9 are used to carry scx_task_state */
 	SCX_TASK_STATE_BITS	= 2,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 809f774183202..ac13115c463d2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1289,6 +1289,20 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 
 	p->scx.ddsp_enq_flags |= enq_flags;
 
+	/*
+	 * The task is about to be dispatched. If ops.enqueue() was called,
+	 * notify the BPF scheduler by calling ops.dequeue().
+	 *
+	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
+	 * changes can trigger ops.dequeue() with %SCX_DEQ_ASYNC. Mark that
+	 * the dispatch dequeue has been called to distinguish from
+	 * property change dequeues.
+	 */
+	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
+		p->scx.flags |= SCX_TASK_DISPATCH_DEQUEUED;
+	}
+
 	/*
 	 * We are in the enqueue path with @rq locked and pinned, and thus can't
 	 * double lock a remote rq and enqueue to its local DSQ. For
@@ -1393,6 +1407,16 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
 	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
 
+	/*
+	 * Mark that ops.enqueue() is being called for this task.
+	 * Clear the dispatch dequeue flag for the new enqueue cycle.
+	 * Only track these flags if ops.dequeue() is implemented.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+		p->scx.flags &= ~SCX_TASK_DISPATCH_DEQUEUED;
+	}
+
 	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
@@ -1529,6 +1553,17 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 	switch (opss & SCX_OPSS_STATE_MASK) {
 	case SCX_OPSS_NONE:
+		if (SCX_HAS_OP(sch, dequeue) &&
+		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
+			bool is_async_dequeue =
+				!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC));
+
+			if (is_async_dequeue)
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
+						 p, deq_flags | SCX_DEQ_ASYNC);
+			p->scx.flags &= ~(SCX_TASK_OPS_ENQUEUED |
+					  SCX_TASK_DISPATCH_DEQUEUED);
+		}
 		break;
 	case SCX_OPSS_QUEUEING:
 		/*
@@ -1537,9 +1572,17 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		if (SCX_HAS_OP(sch, dequeue))
+		/*
+		 * Task is in the enqueued state. This is a property change
+		 * dequeue before dispatch completes. Notify the BPF scheduler
+		 * with SCX_DEQ_ASYNC flag.
+		 */
+		if (SCX_HAS_OP(sch, dequeue)) {
 			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
-					 p, deq_flags);
+					 p, deq_flags | SCX_DEQ_ASYNC);
+			p->scx.flags &= ~(SCX_TASK_OPS_ENQUEUED |
+					  SCX_TASK_DISPATCH_DEQUEUED);
+		}
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -2113,6 +2156,22 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
 
+	/*
+	 * The task is about to be dispatched. If ops.enqueue() was called,
+	 * notify the BPF scheduler by calling ops.dequeue().
+	 *
+	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
+	 * changes can trigger ops.dequeue() with %SCX_DEQ_ASYNC. Mark that
+	 * the dispatch dequeue has been called to distinguish from
+	 * property change dequeues.
+	 */
+	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
+		struct rq *task_rq = task_rq(p);
+
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, task_rq, p, 0);
+		p->scx.flags |= SCX_TASK_DISPATCH_DEQUEUED;
+	}
+
 	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, p);
 
 	if (dsq->id == SCX_DSQ_LOCAL)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 386c677e4c9a0..068c7c2892a16 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -982,6 +982,12 @@ enum scx_deq_flags {
 	 * it hasn't been dispatched yet. Dequeue from the BPF side.
 	 */
 	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
+
+	/*
+	 * The task is being dequeued due to an asynchronous event (e.g.,
+	 * property change via sched_setaffinity(), priority change, etc.).
+	 */
+	SCX_DEQ_ASYNC		= 1LLU << 33,
 };
 
 enum scx_pick_idle_cpu_flags {
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index c2c33df9292c2..17d8f4324b856 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -21,6 +21,7 @@
 #define HAVE_SCX_CPU_PREEMPT_UNKNOWN
 #define HAVE_SCX_DEQ_SLEEP
 #define HAVE_SCX_DEQ_CORE_SCHED_EXEC
+#define HAVE_SCX_DEQ_ASYNC
 #define HAVE_SCX_DSQ_FLAG_BUILTIN
 #define HAVE_SCX_DSQ_FLAG_LOCAL_ON
 #define HAVE_SCX_DSQ_INVALID
@@ -48,6 +49,7 @@
 #define HAVE_SCX_TASK_QUEUED
 #define HAVE_SCX_TASK_RESET_RUNNABLE_AT
 #define HAVE_SCX_TASK_DEQD_FOR_SLEEP
+#define HAVE_SCX_TASK_DISPATCH_DEQUEUED
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 2f8002bcc19ad..b3ecd6783d1e5 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -127,3 +127,5 @@ const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 const volatile u64 __SCX_ENQ_DSQ_PRIQ __weak;
 #define SCX_ENQ_DSQ_PRIQ __SCX_ENQ_DSQ_PRIQ
 
+const volatile u64 __SCX_DEQ_ASYNC __weak;
+#define SCX_DEQ_ASYNC __SCX_DEQ_ASYNC
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index fedec938584be..89359ab65cd3c 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -46,4 +46,5 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
+	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_ASYNC); \
 } while (0)
-- 
2.52.0

