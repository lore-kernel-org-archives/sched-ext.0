Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675041167E
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615602; cv=fail; b=BcnbJPPA1uNnFqFVfgxEEa1MvXdsHGiI56KaxCC/dt4pPQoCa1UaQ8SQUAadO/7rnA7FnFLaPL1ATmF/9tf5NI9HgUtTmiOK6wZn5DOFzRVXhEYOVrEI5OD6FS5JOzQAAFNpn5bOmwYpROx6BTI5oKcw0/HxOqcjoHZEgI2Tn1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615602; c=relaxed/simple;
	bh=6Bn0JzIJpZC6rTmqZJ3046PSki1HFpvh6Ey4rzF3ZJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TssV0Gp+kzxjLpHl03osxf8WkIQ+QFzPIMwUKGZTMCAJVCwLw0T9Na5e6xD+bKK7jlozW2WsrfXsTgxcuIj0zVqUM/HcohSMtGLDtMm9OZ6AR2j59tAD2iDBZFp1IsJEB1kHibFJAx0zuD42j3kurklPWAn9y2Kl1U1a9Hx0BXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X9gddY8t; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X9gddY8t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWgDUSyOR5590nb7H2qLkqLQoQCRTIYul0cP7/gzN44HKJep/JyozftiVqy9x0iwTwU0DwPcpvGA0bxL9DoGNgKn2pdP/szQzpnV/c6MmHrlPoKNtHDv49Kvhn2stve23kGkamMZ09HfQbS1svFU57qCVruMwClVIfzmMVy5C+Fden1wNe84Iie7XyVleKOvtnhq6MTanGq5mBuxfeuZvZeSHdQiXYACpiO27NvFbM8mxHq+CjN5tGGqvYvSm2s5P6uzh6Ko7hyPHponCTKvCBQQV5WSAU9LOlLsHxFKndt5XH1PkZKHpDg09CHmNQqDFoOVc4nUzepReUzE7UFrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jETwS7svPMw006cHfpTn2+vhwOgZ0K3nhxnhDePhcb4=;
 b=AULY/rjEWJe2MuD/8CN3mmvVPkaLtgG34u/ls5kEQnfSaiheGLxa8YvWfH/0p3P0DzE1EEj6g4R//XhQryiu36troQ23gnxPFEwL344X8ewrzMg35I7EI5zoHgjKJOp8uB48l8roleSnL8DfHRqbmtjNIOdu6Tq9MXHA2jh/0rbgERYNuSV1TsDd3nZX9JZFbFOZbyi4H6cu7w9nREO5P4GPvP/Kbg4pdvl1Tf77TRQ37w+r7+O/bDFnKMJ0xRUfGT1QGvt+8UbbTBwNQ5PUAYHxEFWBVp2zZByvrwZeQmljkFl1jKDBgaeUGU7iZxSQuKTz+vNzIKL0wA1EpAcLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jETwS7svPMw006cHfpTn2+vhwOgZ0K3nhxnhDePhcb4=;
 b=X9gddY8tWo0fvBSqeQbAofkYu1a5xGgSdqz3NUf3pwXL1Aj64bQ/eO9WIrWrbkV3CWIOlnnWme18Mk3gv0VoXpjGkKaLI4jmlghfHWmm+wI11Lzw3j6pTRuJu7TXSnOYhnUeEw02C1Y1S2ZLEbm9LeP0pZ9Z0gYwcsRAUHJVHU6ROAZ7gMOLyTrjbHP47Ox1FUiwWv4FWbOqfxzpgyglpw9uv3Ql89iKQ/JfNiOdDRc2mfrKIlanWzkuJIiwYWonvILs0qTdlQjkYp2/s/IW90rglwbi0NLD9o7VcPKDqIqJbnC1PjfNQFH4u4mIGVm+FpTEe3JsEWroQmhwU7444g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:33:17 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:33:17 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] sched/core: Avoid false migration warning for proxy donors
Date: Tue, 21 Jul 2026 08:31:22 +0200
Message-ID: <20260721063242.552774-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 13319d53-5d98-4d31-3f55-08dee6f1f2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+qknsADcldzQ2WGR7Vw8C/Ptd9O8rD2+WM/Gjh7QFoTwZLqCnQnMVQCEjrz0j8arB7IUB8dq3/nVuMqoYtB3dNBtor7c/0XQicKbhDiw8F4769bvtS6jwgcCaRnxwp4/uaPb/bDEUbZBL4O5eaCNltaaeuHHnn/YwZHYjTqbpSj8UNc9tHsKHKOEEgp58+GF5li5HHnVKP7z/o01ndSEo7E93HmYdazZSqn4pV+p518f0+KPqRfGEGOlOBlAKkT+u0/YJrtsHnJJs78CYQX2pWQ+iotmmiHhNE7Aly4VvaK3t+Z8nq1wXlNcb0Qj7fHRTbHpdgyitDQ+Hur4V0Iih8bbLxqA8XhZEuSBwjO8rxjeGJyM1gyNR+Q+fVktP1bmDrXSqB9ohu2a3+BQI2nL1S9Wj3CZhMt9LibrgH7vWRnvcS2gM/f0v1Q8goLn7yvnBTq0eTvnU6fH5gzLx/GDRRBZIxvMu/jQrELt9famVQkza3T5U5D28cP0nDE5mCcAmezg38Cidm/+xPgTISUrTlbiIiUw8fe8u1otQNFd+/48GROWfFV30OU63/bvCslvr6Gvl1fCqv6l0+OAPqNN8meCc7VhUaJJsxA8RagHa1X5N4jlz2yIU1AAhA7G3qfo3QlrFLXFm4wqYuNXuOgoevOEjK7vhkhM4/65/HgZkt8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n3TnmW4ynmI33wVqoTxD3+tAUeBcMEEe2zEO3+hqNLLmn7/iK0b6teEr0HCz?=
 =?us-ascii?Q?oXWTlue3HrSb6qN/rEnwIpQT+AUZm3eCe+Bvrc5D8cPfmE9Y8GrVDUm0k7Oa?=
 =?us-ascii?Q?tdQWu5qGIHBraTTwv8TxOUR3ya8i2GwkesuBoXPpcfoPx25WNUCRRItI+Npe?=
 =?us-ascii?Q?jwIqKbT32ELhJsiAMP3C+trjl6FZfMuOqIGe0Or5lyOFt59gMC63Ip86OuY7?=
 =?us-ascii?Q?de0Sl/279QmBX6ncen1x4Anf3BA0LoHapyvWhYq3N7oSScks+Oa6O9r8gYZ6?=
 =?us-ascii?Q?akuby3UHm/rxyNN7dTE/yAhdsWr7tooRnZTMqNrfHNwN4UEjvtVN3sb8qxge?=
 =?us-ascii?Q?egWpO8LN6GhRSulY8xG9hYc9XyaO5MbeKXB8FIIHRF7Sy0qzyO9PdZQdd0Qk?=
 =?us-ascii?Q?8dKNjt7u6K2ZVl5ocYydW666d4TeMzAInL6z9i1uoI/d6cwljHGCDSt2hQrO?=
 =?us-ascii?Q?I9vvM4GPdUYurdsMMsO1Z3d0QhVCcq0TdJfag2Sm6SyW+z9nUP6QlEG7D51u?=
 =?us-ascii?Q?tt3F1zzUeMyaBHFy/u7CiVY7oOq+TkNSM/Xput1Fbmm4PLPQauTTRAx8meYM?=
 =?us-ascii?Q?kVSDyoPDHAKc1EenvNG+EQeuFpWETVEn6OlgHfZD7NIcIjK1agyaHP5O1gu9?=
 =?us-ascii?Q?OSoaePaWNimB5uatcDr/FfOcF6IZi+e5TwlGLaRk/OuMcUv0Zba1TTbJkwGf?=
 =?us-ascii?Q?S2Mv4J4iIG2XNz6iHAogSET1NfvrkHyrw/6bLyQyEseVWbC/0bakrFqPkZGD?=
 =?us-ascii?Q?Muirdbfz1nN3zGxSfxe68TK4h7SYj3YbYiSkAqL5t+U3/J2n6FbwbT4rPOcr?=
 =?us-ascii?Q?Z60RAk5C39IyBQMfa7IANIYi20b+lx/bWlyVoJzzp55/c6LlvTU3T3roOlGl?=
 =?us-ascii?Q?AbRFpiAW8ms7KNivMABOtOf1JQEtalJrmmGp59lbuf47LNhbwOSOzUaJ30wy?=
 =?us-ascii?Q?8PvuAUlGF3UYfaI0xJtcNN9LLnJ7Bw6wDauBqmZOmMZlKxJSFfKDL0GkobbG?=
 =?us-ascii?Q?CbbBOpx1nXMMCGZctv9/waYtqgGaNRwiYHXctcvmqSXUwtXxGT8xjW7NRh/v?=
 =?us-ascii?Q?kj3yvAGZPV7uEVYL/ZZeOF22ngj4MryIof8DSACrYEMIE7GQeJhKkbbQZxmw?=
 =?us-ascii?Q?rHyJ9IZeGuwlZHZ6JdAvthshE41Z5JrieiuDU9vV959ncL1wUqvPHiBuDX5q?=
 =?us-ascii?Q?BK2QNRtjpTMS2uQt26qPo3Thmb+VHtPKj5PSYP+CTugyXPQX0/VeQy/BAtWx?=
 =?us-ascii?Q?5VeQ+RAOa1gkNahAgA9KaK1muCaDlhEhk9+JVWlkUv+MYjyoMQRSlINYzUrR?=
 =?us-ascii?Q?BeTko1VOoAGBTwdQzm1VRlHInn9ofOk87yrdrTkdib6kre55AFqC4jcbEv5a?=
 =?us-ascii?Q?wMX2tAHNbXQtJI2iMhvu2sBRbY6epI9WPx3QgTUl0zyiAYc3/DJ/fXEaHOIT?=
 =?us-ascii?Q?ouKwtmLj/awIClbGXYQVnnhGGBaT+mbAYXMDacdzpvixEnGNLMK9v6dhiPG4?=
 =?us-ascii?Q?BdF7VKmridCesi3A+9YfeGIXvr0iBanAGqXtvWPV+ZDym/jwVeEZtVb1FIcp?=
 =?us-ascii?Q?eDNMrBRIegd49P/+H3Q7QvQ/9M0SSZX1n3I0dZGkFTNpYcXbDJmTCdILpZ7I?=
 =?us-ascii?Q?90RJ8QmOBwBVudLkvgzwqKALYrfqHx3eG3fMtTr08KmpGBDxSuSvPVfYc6dw?=
 =?us-ascii?Q?nWGw0fb8e2t/+MH7huG/YkLCZrjrYOuyp+v/Fkp//2aISsWavzt81IOe1aoE?=
 =?us-ascii?Q?iLKO2uQt0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13319d53-5d98-4d31-3f55-08dee6f1f2c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:33:17.0566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FauzLXjTJA4rhIUIxaOgAoFBed/TKXI3JDVEC6H9C/a+40i2nbsV0W7XOjs40nqfgMk2W/dhl4yyyEoC9NuOJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

Proxy execution can move a blocked donor's scheduling context to the
lock owner's CPU even when the donor is migration-disabled. The donor
does not execute there, and its original execution CPU remains recorded
in wake_cpu.

set_task_cpu() warns unconditionally for migration-disabled tasks, so a
subsequent proxy migration or the wakeup path returning the donor home
triggers a false positive. Moving a blocked scheduling context does not
violate the migration-disabled execution context.

Exclude blocked proxy donors from the warning. The proxy wakeup path
restores an executable placement before clearing the blocked state.

This is a preparatory fix for enabling proxy execution together with
sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cc6fb1d20547..a0e813abddc28 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3376,7 +3376,13 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
 
-	WARN_ON_ONCE(is_migration_disabled(p));
+	/*
+	 * Proxy execution can move a blocked task's scheduling context to any
+	 * CPU without moving its migration-disabled execution context. The
+	 * wakeup path will return the task to a CPU where it can execute.
+	 */
+	WARN_ON_ONCE(is_migration_disabled(p) &&
+		     !(sched_proxy_exec() && p->is_blocked));
 
 	trace_sched_migrate_task(p, new_cpu);
 
-- 
2.55.0

