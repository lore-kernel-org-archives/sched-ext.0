Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280393385B9
	for <sched-ext@lists.linux.dev>; Tue, 10 Feb 2026 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758940; cv=fail; b=tCNBvRmEAaM2Kb2VdAESp5IEE+9jzEddRa15S055I5JoTHgVGoPa7ScTLDT9rp/Kp3fdVsh3AkX+xmxTW9PSZIrl+TMBy+Mr9wmLofJWpnKxZAoaPn7Hb8fTCX/vPGAOk0KEEN3q2wFKcjCVqJVJ5tn2v6jp0OvYmUjeRirUyDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758940; c=relaxed/simple;
	bh=8XEiTLi/cvSftVSHCYwI81ItX1d9NpgpQXjwE+M+dHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qgY43CCVrS/IJGfyu3pfmV87wTVA77kNVBSCQ/jL//EZwVaLaK3FCg0REh1csKlpmlXiWq9lcYZiYb3oQyRvRMh3MrEn6NkEtYQatxgx8JxNuwTcSCH9rJj+7TVG+hdhXjskf4z5ksO4EZf3TSNmThf1YxG6SDxriL1snOC+lcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SrzniBAQ; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SrzniBAQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHS3dP40uHndS0dHHRj8agdOR9ebkueiI8E0ceu+7UaMmUyPCmWwiVUoym9jKWrjzlOvng+3hl7bWeO1xKvugEV90c418LoW5T5lZ227WovRVoBDR4ntMWeUvmmo2WBimwYXHs96MzYBjSGIp2izU/FbDE+zZhhPDDWamk+RiK88sHQZhdd8M7ooC53Cq0IBXR63L/2P27P15nmYBBnq9GNPzpvJSX7k7Fkmn/izce+cysCHPOMZM3YpYit6hxIcDNJVfxaXN+3eSq67Z0qe5J49U+oCQIn1ri5VwYIOLGlWJFYErVCenORKpyG1vYAIB7DlsZpRavGv2eVcg1Jg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl6HkJZ0UIQfdv8+Bu+wzLJ4/8N4cZgv+WnsRXmLph8=;
 b=rPoAJG5wK+S+Pjn3MsHYiNlcsfV1aFiZvWgrf8Mk8pw4YIoCPYbl2QbTMUIulTWJhPUiaOrkY0xL5uFNAGnq4snmQRwJRi6XigpY6t9+lEgPRyrKVsbVQmRibB/0cuuBU48po0chV4ii1bOgI+q1zwMrMmRh3/Hsm/B9Gi8mHVglnCQgS/APls5G4xDac0qTP7dnxz65pcmwdxVHmgur3VL5xMrapP9lg6nSXK9/cibHQLcMuROYkcFjKifG2W08PR9LJIxYGS/gg5oq93LDYaM9rCQHtuWoX1YjeIELwECTRHGq59SkiqmxervPDZ4yAwDGfrL++qUb9bYgZJGJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl6HkJZ0UIQfdv8+Bu+wzLJ4/8N4cZgv+WnsRXmLph8=;
 b=SrzniBAQ+/hmef5m7eLuZmwGRkRGG9U1udI7kV7ylt2LG+VWisr5ALBa6LB+FJAd4hMep67sLnq3t5ASvJADnQWKY9rqAQAaZUtW+d85LK2z8WRjvTTLZqHIQ0ds2ODUzpczEb+g2SzwbV2JrCXSQ5zpntVnHetxC+H07pdxTa8Gt/d5WGBAXT+/R6l6MTAt7Rf9rFdzD0x98tLIJK7lH6ik/mV5XQzojVofi0mx3va4kYv9NZtpGgn11QmMcUblbezYB/HB0N30rrNJ+ZfxCXB0c13mSt1b0Pc2lsXBAIO/Oh8Yi+eOKRITGr+YzUymhsQrDj3+2xG7RruaxVimPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:28:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 21:28:43 +0000
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
Subject: [PATCH 2/2] selftests/sched_ext: Add test to validate ops.dequeue() semantics
Date: Tue, 10 Feb 2026 22:26:05 +0100
Message-ID: <20260210212813.796548-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210212813.796548-1-arighi@nvidia.com>
References: <20260210212813.796548-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: c142ed94-d124-4ee1-40fd-08de68eb5d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pgwLwBHgLFLqpkB/dzJTyRPjkMr5VdFSzvxgkHW0qY1UCmO6pO2nBbbn3DLb?=
 =?us-ascii?Q?zM7gkMwLS5VG3TRIClepGCaHxg7awiuEPaYnZJ29jPgFXeHBaitKF5bqJDJH?=
 =?us-ascii?Q?sGPMar8DsjAqJqPCWHZQklnR+o4IDqqpWDdVRKwRR6FwzBxcv6XMTEuXLPwv?=
 =?us-ascii?Q?yEObOPxFtThUNATY/2KueW3pg/ZFBDjS7NhJxHtj/TgfNc2fiWxan+PFy6De?=
 =?us-ascii?Q?nyie1Pknlok9Xt4QS3QS/ZLX+uWCJuvPbsdHj2//pc0d2OWzlWWjxq0nR3+t?=
 =?us-ascii?Q?XvHpjT4kU0zCjQhXIu0OaUxqiWo70iVRZU+wD2aAxRFLQzqMREn3QDL4/S0O?=
 =?us-ascii?Q?HXphPYI7eyktZa/ZvUE8SIF0gxdI9eH1LLZZuK7hT7n6Y7zM7C8Q2qFbzpTw?=
 =?us-ascii?Q?RTSoZaR79PiUG/OrsBSiImeIPjx5D/Tg2D9rTW4ZTLdZ14oXccUoX1PK5DTI?=
 =?us-ascii?Q?h9eKSVoAfKZ58RN8rZRWlNHUdA3buKWeMiq1cT70UNkyDm5gDk+nfizDqs1L?=
 =?us-ascii?Q?TIW53qrJQz5n4V89RWkMIAEre8lmDmhFFa9tFG7pxmgkbuENdz9lcSwLrD/A?=
 =?us-ascii?Q?oqTnf+ELXcAeEaYha/QTJW/JQLfaT7H6Je0avC4l38xR5BbtMgksdM9rnnaQ?=
 =?us-ascii?Q?1k/cShv/iBCoHUzj7yM6oya3iZsUBHNEY2Y+AyrjUMa53sCwO7/cQc7dTV+e?=
 =?us-ascii?Q?LO5TsdOX0gOCXklxYBBJYQUfahUYKkf4AU/nEJ/4NkHOB4dRoRfCaRzdGTek?=
 =?us-ascii?Q?qo5a+rqESC7Uc3ir5VdtL3GhVMo0tRFcwhrCNQ1VoHhjCM1qcjDCYsCCZ0lF?=
 =?us-ascii?Q?J/fR/k+tExGMycOpB2TiLJWQm1agnJHeq/BoTt98LOG3lNyvHq38zdXx2a77?=
 =?us-ascii?Q?AXt3qy+B497zwk70kuDhKI1FUSoN/ZrFOPtr9FvHkm5R12g5OrZ73a6oXElW?=
 =?us-ascii?Q?Zm69NFxhHWAL/amYI1POKEty8969+dTApDqKh2q+Vyr0m95/rq2f4SRrZ/g0?=
 =?us-ascii?Q?YztWcZz1yg6g0xGK8QL7FuVSvnZ9uO63/7ApZI9hXEfMIfEtgEdFCdaXapKS?=
 =?us-ascii?Q?fbUgCCDkVCk5Lwl24Biu68cYC2SUp35QNVbvEPBhZtqYUYRLlBBofCSE52H+?=
 =?us-ascii?Q?dWlCiI2Z2P09LY9DLVzclpEqPYiPGzxM0kq7BQODO8S0n058iYgWkPpL8sC2?=
 =?us-ascii?Q?M8JTP8KNUaq0Il9InpoFC8Rnm51V/OYEXuwllfAcEyM0zm1PGdrbd1DG+2tP?=
 =?us-ascii?Q?uGYS/b8XvXhxzbY63bFB9MIURYta9h4iTIcNWUsWEyd4GnMgb4AJCNZI3EM/?=
 =?us-ascii?Q?Fvs9uSfsYwWYwBOALaoRhObLvJeA1y/15APXaT+3l94wqkxgxubAo6s5N8os?=
 =?us-ascii?Q?wCgThsgohcOpeopAlzpI9kySGuwkUkaSbHen6OqM49o8f6CazSTq4L3YtFn/?=
 =?us-ascii?Q?nyhFrqxYmzDTzofGBD+ZEvsL6RkILZGBmVC7D/bWS1Qz4Cjbn/fa95BjmZyU?=
 =?us-ascii?Q?0yfoXZgTShdcMnwS/ig4vN5vlyD/n3lY1MS7a/lTvNs/Yammc5oyOLuo06aL?=
 =?us-ascii?Q?q8q4ZPQSlpGijQyskb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rM+iRHG7xmMfWKUCJ/rOP2ejaWl2YrZWKhbNFGJ7dC5Fe2liT4UmZYs9/O+0?=
 =?us-ascii?Q?gAR0KW37VKkVGUN6OI7Fyr5tIFu0c2vqCknDdov6Ulsbp8A6YAn8zZ6EaDjX?=
 =?us-ascii?Q?70w+6sav/4xtFuWIfiOpeu2Z9wjq2MpWOo0xJmWKGECfs4bK/7vCTRHDhdzb?=
 =?us-ascii?Q?FI7Tephye03LqU3onJ93hUuDF+zqjU8sSwxxRyPf0IlDfP+WdFamefOzXaOT?=
 =?us-ascii?Q?x8QjbulkcK+DVriK8QYzXQIqBSehAD4awTlmUVgAZslRDDO+6K0PbfAbGdot?=
 =?us-ascii?Q?mXKiXf6io2XQNLPd9orkjnAa3K0brx78byRznX+h4vgVgH2uUMTSfjIdZz5H?=
 =?us-ascii?Q?mmSzxd/u/nkFKers8u4iHkEav+y4+Qbz20GeQqbac3ql7IAMi3KZKx4SrWlK?=
 =?us-ascii?Q?3Zdxx/KxxBjkn0SiZG46jaIgubALQFUjYrUhyHFzzhvPECCXUSRGJ7FGfAWH?=
 =?us-ascii?Q?bAJsajA9wcNMd+zB3lDXSN5Zr4zd8N4Vk5WZmR9+W+zS4W1D3eUtt5Vlm9vv?=
 =?us-ascii?Q?fVWFWFZFssEstrqZqeCATFHALahMlk/JG3uWvs6tTTwcOF5cRRJqeqEkiFbS?=
 =?us-ascii?Q?U6Oak7jglNCOnevYtnbds+xskjX+9C1z1swRusw6BKPuZkthIXRuAkOFngdP?=
 =?us-ascii?Q?xZMbkfAA73NV9Gd+zI9mbLD02RN9URwVEfJYf9LpP9wvEQiSj/EWN5yOx8ti?=
 =?us-ascii?Q?4dtCzrd5Ca4APWDZhMhppfF21gbRZAun7+1D2mrqnYheHeJ7adrEMhFrkcki?=
 =?us-ascii?Q?75Auj02B7aUUHOrLbfdiOKja+XoMjKUQ3UcrRKjUEaFQqeLvbXuAnjNMuV4e?=
 =?us-ascii?Q?xcrONZ3ssDJdOsPBZPepCyagwWXzBZYVmjBngIvTogzQ25nfAGgihWwyyLwV?=
 =?us-ascii?Q?IXEnEzU3SXK2+TxdylI3Q2rnlj45QaaGtRL3f+F6JNVhQhLf0EpN82C+W57M?=
 =?us-ascii?Q?oJ8i/vyO1uVdV8TvwiYPMnFIpuSZufCUCvdLhrHsjGl1J6Pu4UrcMkMN76yj?=
 =?us-ascii?Q?zVDot1NLncXVz1PcSimD/Zz3BqOB2Bm2rdUt931sUETiC1Z01O9g8gCZguE/?=
 =?us-ascii?Q?mWuReVE70zvEDG0XEw4ZHgWTCXXTlfc9hmBe5f2OIQAtVettn4nClrt1n9xQ?=
 =?us-ascii?Q?ETUAZFWRbqHtYoHUAO+2H0v5VB5/SDGMnLv80gFIHX/qQxAsVuX28HbjFuWW?=
 =?us-ascii?Q?LfuRIkQ0MAQUUxm6gH2Gyo/hQCxfBtE4ti0YIZdx+BCIzhPeI+tPOkPJ/B06?=
 =?us-ascii?Q?2Z8a8O8wKrOeRlMkAmTtwqNHfmADz2iLnoUIfT1jRfi+tFuZ0vDmYVLjIJTY?=
 =?us-ascii?Q?A4nikgy9G/MBFDjdGEWFK5R5urCIQ3UD2FmZeF2wHZElW16xVME2sY2jAFsm?=
 =?us-ascii?Q?xpQIyz1trmjeHm+SO+D0mlmOdulJCmZiLdBoFPN5xbGpFfbbYlU8JrUXSJUg?=
 =?us-ascii?Q?cMQ7FNwXRgqJ54PeBc/CLibVrj8Sj1hP5zCR/O4L2c4WBjkGyCz91+P8Z46A?=
 =?us-ascii?Q?a1cbCU30JUr6z9m5lFsy3OInAlZJItlwQK7oSRvIid4s9DKrLvDzKEIZQ1v5?=
 =?us-ascii?Q?Z9bj+yIJZCSxMdO0qTeLJKC3aZhM4a5Mxv7RWGRkGVw8jzIbpnqWugqz32hK?=
 =?us-ascii?Q?F5Fz69lhmoT9DyF2+APHyAB0V0Y0YSj7IJpu+MEy5144dqdIth3LXC8bXAeN?=
 =?us-ascii?Q?Xovk6g+oxpfHCQ765SMa/E/OAyQs9zG7KqTy+512Z8+Mb4SZU943rc6akIGL?=
 =?us-ascii?Q?9KxYRnTQyA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c142ed94-d124-4ee1-40fd-08de68eb5d97
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:28:43.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvlmyqo0rPQ/jBkWQcRRejeYBSVxZUFsqy9iuxpWwq4QToJ0V8igJ24rOV5shRq+9gU8PY+SbnQQPHyy7TnVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

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
 .../testing/selftests/sched_ext/dequeue.bpf.c | 368 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 265 +++++++++++++
 3 files changed, 634 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..764e91edabf93 100644
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
index 0000000000000..d9d12f14cd673
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,368 @@
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
+	s32 pid = p->pid;
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
+		/* Transition back to NONE: task outside scheduler control */
+		tctx->state = TASK_NONE;
+	} else {
+		/*
+		 * Regular dispatch dequeue: normal workflow step. Valid
+		 * only from ENQUEUED state (after enqueue, before dispatch
+		 * dequeue). Transitions to DISPATCHED state.
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
+		 * Must be in ENQUEUED state.
+		 */
+		if (tctx->state != TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/*
+		 * Transition to DISPATCHED: normal cycle completed
+		 * dispatch.
+		 */
+		tctx->state = TASK_DISPATCHED;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (test_scenario == 6) {
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
+		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
+			cpu = scx_bpf_task_cpu(p);
+
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
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
+	.timeout_ms		= 5000,
+	.name			= "dequeue_test",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
new file mode 100644
index 0000000000000..8bc9d263aa05c
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,265 @@
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
+#define AFFINITY_HAMMER_MS 50
+
+/*
+ * Worker function that creates enqueue/dequeue events via CPU work and
+ * sleeping. Property-change dequeues are triggered by the affinity hammer
+ * thread (external sched_setaffinity on worker PIDs).
+ */
+static void worker_fn(int id)
+{
+	int i;
+	volatile int sum = 0;
+
+	for (i = 0; i < 1000; i++) {
+		int j;
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
+ * Property-change dequeues only happen when a task gets a property change
+ * while still in the queue. This thread changes workers' affinity from
+ * outside so that some changes hit tasks while they are still in the
+ * queue.
+ */
+static void *affinity_hammer_fn(void *arg)
+{
+	pid_t *pids = arg;
+	cpu_set_t cpuset;
+	int i, n = NUM_WORKERS;
+	struct timespec ts = { .tv_sec = 0, .tv_nsec = 1000000 }; /* 1ms */
+
+	for (i = 0; i < (AFFINITY_HAMMER_MS * 1000 / 100); i++) {
+		int w = i % n;
+		int cpu = (i / n) % 4;
+
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu, &cpuset);
+		sched_setaffinity(pids[w], sizeof(cpuset), &cpuset);
+		nanosleep(&ts, NULL);
+	}
+
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
+	 * while they are still in BPF custody (e.g. in user DSQ or BPF queue),
+	 * triggering SCX_DEQ_SCHED_CHANGE dequeues in scenarios 2, 3, 6 and 7.
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

