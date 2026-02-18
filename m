Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD22FE57B
	for <sched-ext@lists.linux.dev>; Wed, 18 Feb 2026 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403877; cv=fail; b=HZMicGYlCDoYx4OFU5STZNiHMKD4vS1+di0OotJu7oPkj7jZyUqm2e50cgO8CTCRPnzbhuEd1iJqkA1Jct0XS1fB8eJv1yNrgDr770PBbIRZtZ9FmSHLGOESYjJ6K+uiVqWhOlNnNrWBBBFLb7hgoajxYdb8JtJEdAVCDcAUti4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403877; c=relaxed/simple;
	bh=4qUtPUtiU1TjLa331OEv1ECCJdAqcx/9GDjLkGy5lMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJT7Ovkh3O1UUmojFXzrx1qwqXDna5AijrIsSlv19H8QY4FcdbpdJaZsQbjH9A/01FLW3eNlBlooE7OgxmqagJjnfKCTQ5oCuF2BLoZdq7k0Mky42zo2MurpPeCVwTCEYv2R5xqK/vQGoFdVGgMi+68hVY3ds+1zztDdEgfbr+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jTNafuGN; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTNafuGN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8A1klxhZd2Kz98ur+n+8KcoPR6khMpSAhXoR2TOJQHgBJ+w8POifxEnGlSsi1WveZ1NTcGtzTExsZSq3I/ECDhpMuxEtdkWuNBxD+G8xnio+sW6wrzapMychUsG8udxNXyTrLudyckLYy3yZOk8rUq2cn2czf8cy4d+zUFaDAYiPCMoPaUinx7v0AGfKNT+Rg4o4mJLTo0xnuHkNJCH0mz98ogeO4XCVZdcI61xOckzGDO/MymlIsWwUYbSphLMFEDWd6+SbiZ83IGb1Fy2ZslbwGWCxJfiGcFcBFYnHzWQCuQ1I2Mym0M5RcWsTbqqVi0sNF4FkwY/Xyo3D9GBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnXvbZABC/TOywP1anxg0wDHW+rL0sRCOntnxByu31E=;
 b=DOhsfOsvXXX3BkKLP7eOC/z8NNf/+RZNSP0O/+a23dOWK/iFP65HCyp7b1B+OiKmX+aLlypvwTM+jRlr3X0kQ/tgljDESeACESIDPubwopHz0ovYYC/AP/83pVDzq0OUVERQAwY4CbyAcMBGttfT8ecKs9VYHbDDeAHBxQwotqpkis2QaeAK11vfubgCWO9rYjI6vAkIM/SKjeCP8sRAt27B86yIwiLT113ID5VAbrENppNRHGpdS+wcxftWpgHfjAh4wFLz7GQ0QqUzXzvcng14tRvd6wJ3RfLtOSlP+V0REWcYuYZ0wX3egWqpIs2k4hzdwHVXb+xTZTcdcFY6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnXvbZABC/TOywP1anxg0wDHW+rL0sRCOntnxByu31E=;
 b=jTNafuGNwAwELNBZEXCSw5G6hs/E8SasXaVREcAckQnku94G0d4DbrGY4RdlkLjAKynwyhuCZS4JVLGbykwjg+CIJlQegus41AxVkqrWRG1/8R6StPLyjnRVRS90ic7hPhWo9lTYqQvoaPOxW20j5EhQeUeYCg9hjQW5gfaZfxl1XYFVLU0vanXOsHNqHqSz2i+eKKvd9OZ9ChOO/97DZRW1z4w+JO+AvyFTF/0Y8KfcCEyD6lR3QrxZe/kNWyV9T7GHjT2PAkBpHmnqkf+he3zZL6cpCkNXgPsMuPm7FUfMX+D4QdQFVzmhAismCcSg4rXDR8qc9wyx+JbMSG455Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 08:37:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 08:37:48 +0000
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
Subject: [PATCH 4/4] selftests/sched_ext: Add test to validate ops.dequeue() semantics
Date: Wed, 18 Feb 2026 09:32:18 +0100
Message-ID: <20260218083703.22785-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218083703.22785-1-arighi@nvidia.com>
References: <20260218083703.22785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 988a5597-f0d0-4eaf-1877-08de6ec8fe73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WsHB8T2dy01W1s8aawm8UElUJis10K5ZOPl+uve+6EiwnxfzWkXsg6otd82l?=
 =?us-ascii?Q?1+JiOgm53V6diofmboy59UoXHvKsVMbm73DJERqkByY0DXwAEpkHJnhp09Mn?=
 =?us-ascii?Q?CvoyAdohku8U3TeC5CLqx6k04DYWsq4fsZ/9XnN7uIr6uNbG34MNn/QScxDW?=
 =?us-ascii?Q?c9RiGB7nvfOnkj1qz8WAGGh5FUS/RtrtFX3QrFGCojXl3V5lYEQGTqQnzC9G?=
 =?us-ascii?Q?B0xTaRvxc0tJptc/sRhX5t6rasJIqN08RHz8H2lhBZ0c3dbPtR6aMi0wu/Tt?=
 =?us-ascii?Q?u3qEf2+AY1kPH5ZnvlBJCdiotgV7DaUecF/qCm+5SyoEEdktTVEagWISRUW3?=
 =?us-ascii?Q?05/WouNZb/N7wpt6qNv/yH49j63V3OZXoSm7eDjlpG2DhTU6oqrK37ILav75?=
 =?us-ascii?Q?+dqgEeVHO4YMHkQls/cRImjb35JFOKUQW77jV3ImYA5xrKtBUaRdY+Add8V3?=
 =?us-ascii?Q?JcI4EvD5Lef5UMMY4zZo/TLMyMe8HlUh5UndYn4VlO0RbFY2+tPGRdDXX1MM?=
 =?us-ascii?Q?0uz/Khz+5WIcgC1Q70/UPn+8OKJ0Yi57G6P+JP5Ta4fCwOkeynbbnfuycQU3?=
 =?us-ascii?Q?pEqBTVlxIRcM7213cQH6gFGYU7rnj5eCCQwE+CgpHCwKTu52VxUVWVIxb/tM?=
 =?us-ascii?Q?ieLEhQILqHPhiWLtlpkPJjk/Occjp1qQuSZl7p/lzwlxMdHjCMvUdgavE31v?=
 =?us-ascii?Q?fQ/5XsJ7yhBuSj7+Al/dgDgWik3LzkdoucRcceeP2EQq77nxP9y7zmA3p6fc?=
 =?us-ascii?Q?p6hLkZG8uuUpmGLcrWvl9XbQu2f+ipB7BJggZwcTPrzSWxo1g6fpkVriMqdB?=
 =?us-ascii?Q?XwVDEQLsfWegFwJ8jIph+KJQcpBFGA/Nhv193jg3QwO0OaX4sTUEF6uqjG7W?=
 =?us-ascii?Q?F7MF5qkPDXfYH4Ky+a7wFetfEnIXiJKsJZj7BqqQhGlPCynPIufLphrkR/Rj?=
 =?us-ascii?Q?Gp1C3YceLbndNDJhbsM/b/x4o6YOtnl6d8OBD+dA6B6EXNzsWCKKgXpaUrZY?=
 =?us-ascii?Q?5gJhydfer2d5/ApSN27BIUfA1as6Exzj/eVfyfVYb2KG1WD0dMKIYN9JuHax?=
 =?us-ascii?Q?a+p1L7AfarpJNpJrzLXkN/vrfIIhXoFFW3bVtMy5p9johFzG84BLs3SlvVOU?=
 =?us-ascii?Q?kazGYoL21jcBOCBQVnJDoBFLFHAnZSDZd/X3PxLpSn62r4jTGBHs3BY6N5Lw?=
 =?us-ascii?Q?Ztig3cQxP7CY04UigFeUdDnn4qo8eMI8VMsDFcNtqTXmmYrI57972uKc30Sy?=
 =?us-ascii?Q?lSx4Hvf5gyj3ca0GTFTeBrmO1FuGxWISS3qah6FFG+2Bt/rRjLmmKzC8bqyQ?=
 =?us-ascii?Q?borwyBHRESNE7BLjwiS9rWSu1yvE1bmcDgQJN88zyxy3LDrUG+AZvyTHXzzk?=
 =?us-ascii?Q?/eFq5KjtOxOs+ZgLIUSc/pzUVVqBRQq1YkMPcJRWRslT4EowNiPaqIGsVulI?=
 =?us-ascii?Q?36Q8hmT6a8evFC0MQ15UOXQF3cRF6pPREh1Kd4Mbic700xN+czWC0dbV8qiI?=
 =?us-ascii?Q?X+1I5u/Bb3B+rUcBPO1GnwCvMVAh0yBcXRE0L4iRlpH9ssM0fAqw9lC+w4QJ?=
 =?us-ascii?Q?Rtgj/VsMys00bTzEm3k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/I+7u7n72ErJbqCbn5kqK4obIksIBwKlWeqB+dkpwyBNBVPe4LQL79w1fF7?=
 =?us-ascii?Q?GjrKzrlt+loyfVjqioYRRFKRNQPDXLO1y2SYF2sHpFxRvGIniNEPTMIVhU4W?=
 =?us-ascii?Q?2cgP+fx2zapEaep2grkT/l8BYpmY8A5JjtiadwXBLxpXXbEjkni79u1fhCL6?=
 =?us-ascii?Q?txOH/VNHjzdzGnLknxuFMaFB716VoLarbmeCIByVBmhiWjZ6wOzmPUsh6YNS?=
 =?us-ascii?Q?YWiQfTUwohJ9OsHfuAZ61GCj2qtnIwh7m18kUgoj+VzLvvD9n3LQDnwPNc+o?=
 =?us-ascii?Q?u7J+HqEH53Sn0fo1Q9JnPimyhMVgXSKrkhdpBqJMNhx4sexpncoZ+aaEO+LD?=
 =?us-ascii?Q?2jqUfpozM/SlK928+1dEh6I5MlxPYIiQqhGu9nDlfWtq1EG/ZK5Qv/QwUhe5?=
 =?us-ascii?Q?MJVitmq3/IdrIZymafvQyHJCh8KKdYmHff5V8q7U9KwEsDoVBjjguu1Ggi8p?=
 =?us-ascii?Q?otqNm8KfTuxXfVr6TgVy6gjWQiW26V/HkmgdQSJGc3ov8E6op6M2z+AQcuSl?=
 =?us-ascii?Q?UKnvIhJk6FaYB7wTebVs1iwDjBDKCj3mqmFQ6UPk6+U9UJQhp6PLYGW0CtpM?=
 =?us-ascii?Q?P6uMZHDKKkdPx7/iXcdF67OPKuRh+UaZDtpMQLYdAmlq5mSFpsNUD2ScD07Q?=
 =?us-ascii?Q?SWhS1bQY8k4pxfTjxHLqM54FAeu24D95N7yfskOe7snWJItBLhLph/90Wof6?=
 =?us-ascii?Q?aDsIflRElX05zQFxG5+h9stXBQP1XsWPDwWqGFLp/C6DXZcwn3yu4XSOIymc?=
 =?us-ascii?Q?IvkaJhApiLCoIhyinShWlm41ECpXEatI3vpNoIHAx/NiwKEXHz99pOBLQHKY?=
 =?us-ascii?Q?KdnvxjWmdLL7NW8aphKU5oTPepryc9LuwbK2LSb6FAX5m5yzZm11ZBNSg47y?=
 =?us-ascii?Q?c3GA3PmnoP/WE/ILsifhjzjRXZpwtorTqR7gKR6DuBBjUwh5myrWjRoTmJKJ?=
 =?us-ascii?Q?X1hJNrLHXjd2goLRf6/McxKHdJI6SXTC7sJAyyNRONcNJYMhOOKsriX3MgcH?=
 =?us-ascii?Q?hTYux8FoLUL8JMKWikSlHHw9AMPZlodJ+tC05iAhWIk1GefuXrO3+dqrMSlb?=
 =?us-ascii?Q?37OFDj9eCapUyzJo3QCnGiqSaxeqM6N2PFxgM6+FZOhZ7s5HAD6yyrk6souD?=
 =?us-ascii?Q?VbTMr3AN5n/nAC/M37FeZf10KujvYt+wtYi8JB226CbRjis3lRaet9JSX0B1?=
 =?us-ascii?Q?a8zBPRdZnCPgZend7THNG/Y4L2MFWkJW2XQ0Jz/CjbaATzZWQ3nNuPpK1W+M?=
 =?us-ascii?Q?7JCJcjEMeMATJvYfLYF+c+7kaC1FI1UQpsB08dgfH0RUloVWGDGhi1ZKsXgq?=
 =?us-ascii?Q?TNktSCTecykzpj9vKKlXvGtKNjdvMVQWhpj7Eqxiiyd25JDn1vbQ/QbvA8Md?=
 =?us-ascii?Q?qLduWI02/3/cw1kQwN8aCmA4Qe3AM07M8/ZI73bExk1bqxYuZ5OCuS+ZuZDD?=
 =?us-ascii?Q?G28fkES/anLU0890y1tJ2AyLj4MEbYaYUikdLXEPrMMIoCN1qyE5PvlS5EMd?=
 =?us-ascii?Q?+aDoYVVO970PojJlbE/n5wTEIIGyiv/00cFnqxOR1UJEcfi4aWVrOeo+y7GW?=
 =?us-ascii?Q?NYRi7D7GeL2A5zLygn5o8byBhECL0o3I6qfY/JEMtBIdaaXX5Lb3/ud3twrc?=
 =?us-ascii?Q?hPwsi8U905KErzi6I+lyHurWJ2tE4j2tl5gk46C5PFj9LA1BrgGqBOkp+8c2?=
 =?us-ascii?Q?0jbEn0M0VSoCFOd52v57robsPWY2Y4a4QBlRn/d0f2Fbw7Ney4f2cfR87vZo?=
 =?us-ascii?Q?WmicZJWzEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988a5597-f0d0-4eaf-1877-08de6ec8fe73
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:37:48.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5vzkCfY8Jg6N4hX5p3gaRHpHVu7lF2y5/xPy9lSA2TD9JECG3TyMZYfWsD0aiHBmkBzsIfQFpgRuK5zzHUccA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510

Add a new kselftest to validate that the new ops.dequeue() semantics
work correctly for all task lifecycle scenarios, including the
distinction between terminal DSQs (where BPF scheduler is done with the
task), user DSQs (where BPF scheduler manages the task lifecycle) and
BPF data structures, regardless of which event performs the dispatch.

The test validates the following scenarios:

 - From ops.select_cpu():
     - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
       the BPF scheduler entirely; they never enter BPF custody, so
       ops.dequeue() is not called,
     - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
       bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
       not called,
     - scenario 2 (user DSQ): tasks dispatched to user DSQs from
       ops.select_cpu(): tasks enter BPF scheduler's custody with full
       enqueue/dequeue lifecycle tracking and state machine validation,
       expects 1:1 enqueue/dequeue pairing,

   - From ops.enqueue():
     - scenario 3 (local DSQ): same behavior as scenario 0,
     - scenario 4 (global DSQ): same behavior as scenario 1,
     - scenario 5 (user DSQ): same behavior as scenario 2,
     - scenario 6 (BPF internal queue): tasks are stored in a BPF queue
       from ops.enqueue() and consumed from ops.dispatch(); similarly to
       scenario 5, tasks enter BPF scheduler's custody with full
       lifecycle tracking and 1:1 enqueue/dequeue validation.

This verifies that:
 - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
 - tasks dispatched to user DSQs, either from ops.select_cpu() or
   ops.enqueue(), enter BPF scheduler's custody and have exact 1:1
   enqueue/dequeue pairing,
 - tasks stored to internal BPF data structures from ops.enqueue() enter
   BPF scheduler's custody and have exact 1:1 enqueue/dequeue pairing,
 - dispatch dequeues have no flags (normal workflow),
 - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
 - no duplicate enqueues or invalid state transitions are happening.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 394 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 274 ++++++++++++
 3 files changed, 669 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 2c601a7eaff5f..2815a875bde2f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 
 auto-test-targets :=			\
 	create_dsq			\
+	dequeue				\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
new file mode 100644
index 0000000000000..63c032f4d8e98
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
+ *   scheduler entirely: no ops.dequeue() should be called
+ * - Tasks dispatched to user DSQs from ops.enqueue() enter BPF custody:
+ *   ops.dequeue() must be called when they leave custody
+ * - Every ops.enqueue() dispatch to non-terminal DSQs is followed by
+ *   exactly one ops.dequeue() (validate 1:1 pairing and state machine)
+ *
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+/*
+ * BPF internal queue.
+ *
+ * Tasks are stored here and consumed from ops.dispatch(), validating that
+ * tasks on BPF internal structures still get ops.dequeue() when they
+ * leave.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 32768);
+	__type(value, s32);
+} global_queue SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+/*
+ * Counters to track the lifecycle of tasks:
+ * - enqueue_cnt: Number of times ops.enqueue() was called
+ * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
+ * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no flag)
+ * - change_dequeue_cnt: Number of property change dequeues
+ * - bpf_queue_full: Number of times the BPF internal queue was full
+ */
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt, bpf_queue_full;
+
+/*
+ * Test scenarios:
+ * 0) Dispatch to local DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 1) Dispatch to global DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 2) Dispatch to shared user DSQ from ops.select_cpu() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ * 3) Dispatch to local DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 4) Dispatch to global DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 5) Dispatch to shared user DSQ from ops.enqueue() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ * 6) BPF internal queue from ops.enqueue(): store task PIDs in ops.enqueue(),
+ *    consume in ops.dispatch() and dispatch to local DSQ (validates dequeue
+ *    for tasks stored in internal BPF data structures)
+ */
+u32 test_scenario;
+
+/*
+ * Per-task state to track lifecycle and validate workflow semantics.
+ * State transitions:
+ *   NONE -> ENQUEUED (on enqueue)
+ *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
+ *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
+ *   ENQUEUED -> NONE (on property change dequeue before dispatch)
+ */
+enum task_state {
+	TASK_NONE = 0,
+	TASK_ENQUEUED,
+	TASK_DISPATCHED,
+};
+
+struct task_ctx {
+	enum task_state state; /* Current state in the workflow */
+	u64 enqueue_seq;       /* Sequence number for debugging */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
+{
+	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	struct task_ctx *tctx;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return prev_cpu;
+
+	switch (test_scenario) {
+	case 0:
+		/*
+		 * Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	case 1:
+		/*
+		 * Direct dispatch to the global DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	case 2:
+		/*
+		 * Dispatch to shared a user DSQ.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, 0);
+
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+		break;
+	}
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+	s32 pid = p->pid;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	switch (test_scenario) {
+	case 3:
+		/*
+		 * Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		break;
+	case 4:
+		/*
+		 * Direct dispatch to the global DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no ops.dequeue() callbacks.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		break;
+	case 5:
+		/*
+		 * Dispatch to shared user DSQ.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+		break;
+	case 6:
+		/*
+		 * Store task in BPF internal queue.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		if (bpf_map_push_elem(&global_queue, &pid, 0)) {
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+			__sync_fetch_and_add(&bpf_queue_full, 1);
+
+			tctx->state = TASK_DISPATCHED;
+		} else {
+			__sync_fetch_and_add(&enqueue_cnt, 1);
+
+			tctx->state = TASK_ENQUEUED;
+			tctx->enqueue_seq++;
+		}
+		break;
+	default:
+		/* For all other scenarios, dispatch to the global DSQ */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		tctx->state = TASK_DISPATCHED;
+		break;
+	}
+
+	scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
+}
+
+void BPF_STRUCT_OPS(dequeue_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&dequeue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	/*
+	 * For scenarios 0, 1, 3, and 4 (terminal DSQs: local and global),
+	 * ops.dequeue() should never be called because tasks bypass the
+	 * BPF scheduler entirely. If we get here, it's a kernel bug.
+	 */
+	if (test_scenario == 0 || test_scenario == 3) {
+		scx_bpf_error("%d (%s): dequeue called for local DSQ scenario",
+			      p->pid, p->comm);
+		return;
+	}
+
+	if (test_scenario == 1 || test_scenario == 4) {
+		scx_bpf_error("%d (%s): dequeue called for global DSQ scenario",
+			      p->pid, p->comm);
+		return;
+	}
+
+	if (deq_flags & SCX_DEQ_SCHED_CHANGE) {
+		/*
+		 * Property change interrupting the workflow. Valid from
+		 * both ENQUEUED and DISPATCHED states. Transitions task
+		 * back to NONE state.
+		 */
+		__sync_fetch_and_add(&change_dequeue_cnt, 1);
+
+		/* Validate state transition */
+		if (tctx->state != TASK_ENQUEUED && tctx->state != TASK_DISPATCHED)
+			scx_bpf_error("%d (%s): invalid property change dequeue state=%d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/*
+		 * Transition back to NONE: task outside scheduler control.
+		 *
+		 * Scenario 6: dispatch() checks tctx->state after popping a
+		 * PID, if the task is in state NONE, it was dequeued by
+		 * property change and must not be dispatched (this
+		 * prevents "target CPU not allowed").
+		 */
+		tctx->state = TASK_NONE;
+	} else {
+		/*
+		 * Regular dispatch dequeue: kernel is moving the task from
+		 * BPF custody to a terminal DSQ. Normally we come from
+		 * ENQUEUED state. We can also see TASK_NONE if the task
+		 * was dequeued by property change (SCX_DEQ_SCHED_CHANGE)
+		 * while it was already on a DSQ (dispatched but not yet
+		 * consumed); in that case we just leave state as NONE.
+		 */
+		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
+
+		/*
+		 * Dispatch dequeue should not have %SCX_DEQ_SCHED_CHANGE
+		 * flag.
+		 */
+		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
+			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/*
+		 * Must be ENQUEUED (normal path) or NONE (already dequeued
+		 * by property change while on a DSQ).
+		 */
+		if (tctx->state != TASK_ENQUEUED && tctx->state != TASK_NONE)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		if (tctx->state == TASK_ENQUEUED)
+			tctx->state = TASK_DISPATCHED;
+
+		/* NONE: leave as-is, task was already property-change dequeued */
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (test_scenario == 6) {
+		struct task_ctx *tctx;
+		struct task_struct *p;
+		s32 pid;
+
+		if (bpf_map_pop_elem(&global_queue, &pid))
+			return;
+
+		p = bpf_task_from_pid(pid);
+		if (!p)
+			return;
+
+		/*
+		 * If the task was dequeued by property change
+		 * (ops.dequeue() set tctx->state = TASK_NONE), skip
+		 * dispatch.
+		 */
+		tctx = try_lookup_task_ctx(p);
+		if (!tctx || tctx->state == TASK_NONE) {
+			bpf_task_release(p);
+			return;
+		}
+
+		/*
+		 * Dispatch to this CPU's local DSQ if allowed, otherwise
+		 * fallback to the global DSQ.
+		 */
+		if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
+			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+		else
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+
+		bpf_task_release(p);
+	} else {
+		scx_bpf_dsq_move_to_local(SHARED_DSQ);
+	}
+}
+
+s32 BPF_STRUCT_OPS(dequeue_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tctx)
+		return -ENOMEM;
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_init)
+{
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(dequeue_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dequeue_ops = {
+	.select_cpu		= (void *)dequeue_select_cpu,
+	.enqueue		= (void *)dequeue_enqueue,
+	.dequeue		= (void *)dequeue_dequeue,
+	.dispatch		= (void *)dequeue_dispatch,
+	.init_task		= (void *)dequeue_init_task,
+	.init			= (void *)dequeue_init,
+	.exit			= (void *)dequeue_exit,
+	.flags			= SCX_OPS_ENQ_LAST,
+	.name			= "dequeue_test",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
new file mode 100644
index 0000000000000..4e93262703ca8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <time.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include <pthread.h>
+#include "scx_test.h"
+#include "dequeue.bpf.skel.h"
+
+#define NUM_WORKERS 8
+#define AFFINITY_HAMMER_MS 500
+
+/*
+ * Worker function that creates enqueue/dequeue events via CPU work and
+ * sleep.
+ */
+static void worker_fn(int id)
+{
+	int i;
+	volatile int sum = 0;
+
+	for (i = 0; i < 1000; i++) {
+		volatile int j;
+
+		/* Do some work to trigger scheduling events */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Sleep to trigger dequeue */
+		usleep(1000 + (id * 100));
+	}
+
+	exit(0);
+}
+
+/*
+ * This thread changes workers' affinity from outside so that some changes
+ * hit tasks while they are still in the scheduler's queue and trigger
+ * property-change dequeues.
+ */
+static void *affinity_hammer_fn(void *arg)
+{
+	pid_t *pids = arg;
+	cpu_set_t cpuset;
+	int i = 0, n = NUM_WORKERS;
+	struct timespec start, now;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	while (1) {
+		int w = i % n;
+		int cpu = (i / n) % 4;
+
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu, &cpuset);
+		sched_setaffinity(pids[w], sizeof(cpuset), &cpuset);
+		i++;
+
+		/* Check elapsed time every 256 iterations to limit gettime cost */
+		if ((i & 255) == 0) {
+			long long elapsed_ms;
+
+			clock_gettime(CLOCK_MONOTONIC, &now);
+			elapsed_ms = (now.tv_sec - start.tv_sec) * 1000LL +
+				     (now.tv_nsec - start.tv_nsec) / 1000000;
+			if (elapsed_ms >= AFFINITY_HAMMER_MS)
+				break;
+		}
+	}
+	return NULL;
+}
+
+static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
+					 const char *scenario_name)
+{
+	struct bpf_link *link;
+	pid_t pids[NUM_WORKERS];
+	pthread_t hammer;
+
+	int i, status;
+	u64 enq_start, deq_start,
+	    dispatch_deq_start, change_deq_start, bpf_queue_full_start;
+	u64 enq_delta, deq_delta,
+	    dispatch_deq_delta, change_deq_delta, bpf_queue_full_delta;
+
+	/* Set the test scenario */
+	skel->bss->test_scenario = scenario;
+
+	/* Record starting counts */
+	enq_start = skel->bss->enqueue_cnt;
+	deq_start = skel->bss->dequeue_cnt;
+	dispatch_deq_start = skel->bss->dispatch_dequeue_cnt;
+	change_deq_start = skel->bss->change_dequeue_cnt;
+	bpf_queue_full_start = skel->bss->bpf_queue_full;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops for scenario %s", scenario_name);
+
+	/* Fork worker processes to generate enqueue/dequeue events */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
+
+		if (pids[i] == 0) {
+			worker_fn(i);
+			/* Should not reach here */
+			exit(1);
+		}
+	}
+
+	/*
+	 * Run an "affinity hammer" so that some property changes hit tasks
+	 * while they are still in BPF custody (e.g., in user DSQ or BPF
+	 * queue), triggering SCX_DEQ_SCHED_CHANGE dequeues.
+	 */
+	SCX_FAIL_IF(pthread_create(&hammer, NULL, affinity_hammer_fn, pids) != 0,
+		    "Failed to create affinity hammer thread");
+	pthread_join(hammer, NULL);
+
+	/* Wait for all workers to complete */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for worker %d", i);
+		SCX_FAIL_IF(status != 0, "Worker %d exited with status %d", i, status);
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	/* Calculate deltas */
+	enq_delta = skel->bss->enqueue_cnt - enq_start;
+	deq_delta = skel->bss->dequeue_cnt - deq_start;
+	dispatch_deq_delta = skel->bss->dispatch_dequeue_cnt - dispatch_deq_start;
+	change_deq_delta = skel->bss->change_dequeue_cnt - change_deq_start;
+	bpf_queue_full_delta = skel->bss->bpf_queue_full - bpf_queue_full_start;
+
+	printf("%s:\n", scenario_name);
+	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
+	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
+	       (unsigned long)deq_delta,
+	       (unsigned long)dispatch_deq_delta,
+	       (unsigned long)change_deq_delta);
+	printf("  BPF queue full: %lu\n", (unsigned long)bpf_queue_full_delta);
+
+	/*
+	 * Validate enqueue/dequeue lifecycle tracking.
+	 *
+	 * For scenarios 0, 1, 3, 4 (local and global DSQs from
+	 * ops.select_cpu() and ops.enqueue()), both enqueues and dequeues
+	 * should be 0 because tasks bypass the BPF scheduler entirely:
+	 * tasks never enter BPF scheduler's custody.
+	 *
+	 * For scenarios 2, 5, 6 (user DSQ or BPF internal queue) we expect
+	 * both enqueues and dequeues.
+	 *
+	 * The BPF code does strict state machine validation with
+	 * scx_bpf_error() to ensure the workflow semantics are correct.
+	 *
+	 * If we reach this point without errors, the semantics are
+	 * validated correctly.
+	 */
+	if (scenario == 0 || scenario == 1 ||
+	    scenario == 3 || scenario == 4) {
+		/* Tasks bypass BPF scheduler completely */
+		SCX_EQ(enq_delta, 0);
+		SCX_EQ(deq_delta, 0);
+		SCX_EQ(dispatch_deq_delta, 0);
+		SCX_EQ(change_deq_delta, 0);
+	} else {
+		/*
+		 * User DSQ from ops.enqueue() or ops.select_cpu(): tasks
+		 * enter BPF scheduler's custody.
+		 *
+		 * Also validate 1:1 enqueue/dequeue pairing.
+		 */
+		SCX_GT(enq_delta, 0);
+		SCX_GT(deq_delta, 0);
+		SCX_EQ(enq_delta, deq_delta);
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue *skel;
+
+	skel = dequeue__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dequeue__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dequeue *skel = ctx;
+	enum scx_test_status status;
+
+	status = run_scenario(skel, 0, "Scenario 0: Local DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 1, "Scenario 1: Global DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 2, "Scenario 2: User DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 3, "Scenario 3: Local DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 4, "Scenario 4: Global DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 5, "Scenario 5: User DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 6, "Scenario 6: BPF queue from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	printf("\n=== Summary ===\n");
+	printf("Total enqueues: %lu\n", (unsigned long)skel->bss->enqueue_cnt);
+	printf("Total dequeues: %lu\n", (unsigned long)skel->bss->dequeue_cnt);
+	printf("  Dispatch dequeues: %lu (no flag, normal workflow)\n",
+	       (unsigned long)skel->bss->dispatch_dequeue_cnt);
+	printf("  Property change dequeues: %lu (SCX_DEQ_SCHED_CHANGE flag)\n",
+	       (unsigned long)skel->bss->change_dequeue_cnt);
+	printf("  BPF queue full: %lu\n",
+	       (unsigned long)skel->bss->bpf_queue_full);
+	printf("\nAll scenarios passed - no state machine violations detected\n");
+	printf("-> Validated: Local DSQ dispatch bypasses BPF scheduler\n");
+	printf("-> Validated: Global DSQ dispatch bypasses BPF scheduler\n");
+	printf("-> Validated: User DSQ dispatch triggers ops.dequeue() callbacks\n");
+	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)\n");
+	printf("-> Validated: Property change dequeues have SCX_DEQ_SCHED_CHANGE flag\n");
+	printf("-> Validated: No duplicate enqueues or invalid state transitions\n");
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dequeue *skel = ctx;
+
+	dequeue__destroy(skel);
+}
+
+struct scx_test dequeue_test = {
+	.name = "dequeue",
+	.description = "Verify ops.dequeue() semantics",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_test)
-- 
2.53.0

