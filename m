Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11621427FAA
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208239; cv=fail; b=qGvgVjyyRY//YQpOKySDvteEVJmsOkqd3XGw1J70IBAXysoJJPr3hu06fcKm6bZcFgh5NPCDUhPmwkCgI/z5M5hH44SHfM6eeVxX/WS/Uj+8obci22IFVXWrC3Vh/qQ/ESoUThhqad2Q6xIuvD1eiOtwCYC8SbyC/zlKLIW+UY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208239; c=relaxed/simple;
	bh=1FdUVfSt4RQISHefca2TB+7NxXrzIsbbaqLvHILldGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VMSTa579vgw1f+SNuBWFGHfiRp58k0/o7yNu0YNJA1BFsPC0yoy8GK0ffIUFHZaVbjgB5VdicxPehJLuPc/SI1d9sn9NakOfAFrM6OyrHkTrKPZbLDAQNvEfmk8KBsn8XjqQcqa2QdYICQAl30+CEY3/OEzqfr/PXCJPGDzM4yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MvMUbNNe; arc=fail smtp.client-ip=40.107.200.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MvMUbNNe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEB88oPTE9kQUz3TzBbCmYap63Ulpc6Rsl+Vlhmf12PkNNhrf61g3sU5dswNRJmEqUT+smodgv3qo00GZjAat8joOrFy+9tSh7AwZvrm7uV1KVFbYXNemzNqCPRtjjo1OvSSegAMcu/7iod+BcCuepc+fGonaxRB96PZKgjvJVj5D1tlJThpMLoMvpjIaGL8deXWpgB4JXKh58cpFbMiceZ8DCvht1t3k9MfaOauMo5p1xwQipiBT9Culo6zPpodqYfPafomcA/IYm5lfQBBR1RFggHLlVY4e2nuZBh4cIZfFqSt5t3knJ8H6Wutln93v3CX7LHHD8OPWeIEXens4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=q236ILaYrGEPKaYZY+RF5Zix7eJlr+alJbwXF7hMadhKBuHbPoeWCpyRyRyJKLal0AnF23Qvs5HDIdS2rbciVNJ8Gz6ECYqyG59LPe0K5tczSM2nAAAnD5NCUihmw0TzhDZHstxp//4fNCdiMY/nXa50z6JPVWNboSKMDxdnPbZrKaAtAnYKPOl1j7s8iknwFUfTolI3nbpZg3Jm7m3TtVDt0tNbhZC2c9McbX2FP1lcAzAyYfncqSSjC2Nv4tqzGUEAg4I0kyXaeYT0HbCU0PRDcUm9HfKnFJ4hE09UokOGwQzreSn6aKQE3jKqcyi962O1HPUHnhhCYTspHQzBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=MvMUbNNeRelXfoDVaDRuxc/mKwbz2UF1HJLIzsvD92716VVjHvHu08cmhlNjf/rU557zy6zHljc8fm3kiqIfo0XfzToHbIa/GqE7wKVf225lcf+Or12YrrwQNACw5EcXwkq+FCcg9+PN1Ly7fykwT+Hs6F74gqVBQ0TNDrgzNLPSeZUP6bP9fLZ+OELsNtbK/GUegTRsGuNkc2CMmK1jODGV7Fpb9nqPJbc5UD2NQ5CIdKhCj166ppSVOxRo/oTBhxeeuJ2CQU26xZaZp9i4sOOO0WMqBjeqhxeKCz5WesPwolnfSKkPHo5HVly/Gvpvnj5Huoz6MT7OuJjMVOUNXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:23:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:23:53 +0000
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
Subject: [PATCH 11/11] sched: Allow enabling proxy exec with sched_ext
Date: Thu, 16 Jul 2026 15:20:46 +0200
Message-ID: <20260716132229.61603-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008CD.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::43b) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 491655d6-c0bc-47d7-f8de-08dee33d7b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YBrUEuNtom1E9Zcc2gt6uVAocS8Db2aXQu10WgVwGzF6crT2zsohuLPguX/ictyaFLpxnit6udUoZedARakRn3G6YfzJf4X9woLw7ik+ULG50eizazszZq6ffwEFrEFkTFEP4ShKaM0fzlDcy3kzynKS+yDb0VBon4t11nm2H+7LWan3o6KEX0c8vHpajzs9luNgDiRwBHhiYhGsmCA9AuRnA/yLuXfoaPQNhN32XUKxWIejnvXx0djTpFPS5d9bok86DKHWD90+0MzPz2uEEwXiYRYOz3P1c8QER/A/i4mUgsit7WVAM3qgxQksqqRh419QsO3bQOEiWVmEwLzCxgEIrM04fAI9SPm13HRnz3Ud+mPRYxbF3Z/yZSsZT1iKDxgXbzeVKFJjBqmSCleOwycXaCGrSK/5Ig5qy4vSp6sUUT733GJkN4sA7NsZqb2FPbB9yO2dIkc51NHaa2ZiXEbBLRJs8GkM8OGICYXZyLfQltJwCmrcR/6u2EjcfljbNWErURPYJ2hHgD2+hqF/HUqXyUJr+Z448lzFJ2blNIvajrcGdsJATJ8MXZ/FTLd36E+5M5LKMK9jWH0YWs8qg7HfhyBErsw7nM8k5buFJKQ3lbadDNqA+3ZCAzbFULKG9H1LfgVLDPVN/tYlIEOcIZeqmylWxs9LeBTluBci/J0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DISRIqHokI33kR5VzYyMHZV8xkRXP3CjfCgFSzMFJAX8FlvgOTJ6e4Vwa7BF?=
 =?us-ascii?Q?UreQZD6m1v8M2eIUPxrd522qrkfONkBHja3QQJvh1aIFsmjvCVitwAv6X0+z?=
 =?us-ascii?Q?wVmG5W+uglj9cWDSaxPMWRJwnaNln6cepLMudbEHnO1a06wu8dg/l1id1J8l?=
 =?us-ascii?Q?23wbDzD+FNjc5VwPkWy4yD9qRe/fxG6G+ZnY6ibZk9EYeVNIsR/RE1QKU5gS?=
 =?us-ascii?Q?/tBopvowwmNYtdf4T1hnYlpLezZGePxwaFLRXZuOJ7HWdSZMejJ0VevabB6T?=
 =?us-ascii?Q?RP58K3XHqJ6V18IbjMnNf0FiE5x2KDVbYd/WbJigpBsWdAQydGcAEneZ7G1V?=
 =?us-ascii?Q?c0Si11bmRLo5knUxd8EW5b72ziKX8HsPULLzicYeHlS70Lqg4N+BFzMXptr4?=
 =?us-ascii?Q?1dthk5Mj4SJ60nfGkJu5qwzK/5p2RHTBO4tEvIuBE36gGEPX64k/go626PB6?=
 =?us-ascii?Q?QjwyEWFd6Pce0GDxNF5txmQLUEGkJB4lF5HVzP+1KbxS2GYAy2xLRUziPwnx?=
 =?us-ascii?Q?2X8pCafI04wfqQEuQgMh5mZdnzDyga2laXjljuvLaA0uPKoIi7AihyC7pH10?=
 =?us-ascii?Q?1mEfOfrU9lkIwNLPMklFQEgx4j82HuJ4SGfvilxIfKymnj9XefYTdwY46xPn?=
 =?us-ascii?Q?S7gVi9E7oOCiBN7baieDmeNDLTKRczwOp59sUNsH1CU4df9lYmg2/UqswF19?=
 =?us-ascii?Q?He30qs0uxneEUABElAQelGcshB//i3JYKx9SjJOQy3XORcCDafzfSGMwB3ec?=
 =?us-ascii?Q?GgPaYYh6GIxJN5t8VOI0GTLv8efoXpyLQ3LjDTZ61OmgQnRvDTqOBuVijjii?=
 =?us-ascii?Q?DWtFH6UoneksN6YpCchNQ1qm+ycMwAtu7g/JmXQzN7CjK3SdLC82pEJz1Bf6?=
 =?us-ascii?Q?240A2gssGcaYK2whkEvaykPXXuqDe0ItCmcfXrHoxoSPc76RZtEQtrnrzicS?=
 =?us-ascii?Q?kLmrBCSHaqj5togxxiP7qlXmie/t6VT+LduxogzxAqiUTa5/gBZQelL/ExQB?=
 =?us-ascii?Q?9JPE8SN7lLF/m+G3xodQToGbNR7jjV1YiJi4jkeC0dRf9QEMWmkh+fh9L4zd?=
 =?us-ascii?Q?JfMYXrNeh2HAzGsk2GhNVHE0qCUjgKfoB8nBuv/OE/gHRsM5yXfnUFcA4/9W?=
 =?us-ascii?Q?2It7UnPltA2CEPcAwvQtCLoYuP3s9sOSOHvqWgPbVFnpwbtCuOPHHLzXBmvY?=
 =?us-ascii?Q?NHGgOpkVEDVbFpJ3/BYJvkZI4C3MAjCnkKYIf2lpaEf4ZXi2Lr/o9St38kLQ?=
 =?us-ascii?Q?wEGGgmxrD9wZChRENG+vJxUbbVvl8BzCixIF2gNUtKl6EgrtWSvzuUWY5okq?=
 =?us-ascii?Q?Se7NlWDk18HlWTaOuvvVRe5QOW2fID62YideAH6jU6L10FJadzZmBLvxg2gb?=
 =?us-ascii?Q?PuNSiTcJEz/cjYwmddBVOPFLRQ6aKupDnfaFdLnIkCfeODJa6F2KZwzH0aAq?=
 =?us-ascii?Q?kqWTUL8DUcVgo91KIpZZJuWYiJ0x1Lz7RQbxb/zaDd938AEO4LwsjmFLNuCL?=
 =?us-ascii?Q?Hbw6fijJGjxJIjLAA1x5HqaGYTlkfwuslSngTANgJCWDK+GkCA8h1KSqn3Ix?=
 =?us-ascii?Q?SCBJDVh366UFqG2742cjTWXmVEI61qu8A1oyoekuy4440Z1SlXtWjp5Ob2YO?=
 =?us-ascii?Q?51fdw4FGbSUbAhkQEP5vjntPydqBABOcFp73SoQbFhnGckMG7nayrdMiB63N?=
 =?us-ascii?Q?5A9a9e3B7yIx7gxuILTa344JVZmf9jZ4/svlYT06TOFPFUHy7fUQNHQn/+N8?=
 =?us-ascii?Q?ABcAYB8b5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491655d6-c0bc-47d7-f8de-08dee33d7b11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:23:53.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uC6rsqd4WCS1CmtFnDqxkWrcJAd1OMY43qtXZ0wbdGIiw6lfsOnHTgCZrG6l4/5IFLF849tEtAp9K6BWlaLH3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 init/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c8..0817e62266e03 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -934,8 +934,6 @@ config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
 	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
 	depends on !PREEMPT_RT
-	# Need to investigate how to inform sched_ext of split contexts
-	depends on !SCHED_CLASS_EXT
 	# Not particularly useful until we get to multi-rq proxying
 	depends on EXPERT
 	help
-- 
2.55.0

