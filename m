Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDB3F23CB
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089633; cv=fail; b=cqV2dljnrDAW1yRpKawMxoEj+CdIsan3UyDMb1HcodDiZ6bY4MEtnHRH79CSHkM9/WWDvU2qDpOXr1T+ErL4ngb4ogXBxza4ZHK/OFVz01pUkNmBapoVbW0rhBAvqElfRT0+i6rv1dskdcXjiSMSMxxl3HGVwK88WW5lEHHSGX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089633; c=relaxed/simple;
	bh=i7zf6FkLHTUrdNcI5LCle42zVp10dvuloLWOvUf2DUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nGw66okizOib21CuyhYmrNv8CLuk4Qdun4+/UcmwIRzQN2JkRrZRmemyvLqbVauvitjmA6vFxUYdEk4MDua+MTysrCAdBpk2q68dgBb52VGBz4c6r9cD2yM0EkhUtL16CxGM91YkgBc0JZQgkBFsJdOSyi+C8Z4hwnDKXs5OrVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AuFnFhcZ; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AuFnFhcZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMunHKU8bpx/hOWP+rVOXGCVLvmHAHeVCYITV4PrtDnhDHhV4gS+xTHiUD0RSmg/IL1vHG2YhSHPC8am9lkKivb+YXD2LZl09yFfql2Jv37wS1y2BdWSYQkZ6ih16mIB8ekPB0OhymZKqtn8ABZq2Zyc4vSzwn8OEwhs4PPNwzmSfBzcC+c27EpVjahOV3ve0omF9w2Mdvvbd6WlJjrBhr45kF6tJJBZ36QwL/7MIHZyGL+sBHG/Tg4/kw6pzVrLRkDS0q1u8LG6q31ngWC66duFOTefr8Vo/oDNhuZa4nD8OosnNXkZf3Ib67aet6aFoQcOkLA2AFmVpbcJqYncXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeAbtdz8SdPUu4dChtnv7NUk9iQ/BKVViCIsAVWjVLM=;
 b=Ck21atnujSd5jYi1+r0rgaZ4wMsqEuIU7+nmPFDxwRzvywgdHnVcoUVlEGARWgNQnLs6aCK6kyzHQ0dZaWSNVsE6WGhEy5gE7tcrL46yr3D5Y/IwXX0zP39ZEdmQhedP5WclfIDjjQabyjV5aQwjujFw3LEdm/hqooFRkgpVZi2a+2li/8nVmE5hkiXe+3CBhHiaASylxkesAg6BZVEmuMEQth/OpphjATF8bDDMtzSXhK0u5H2EuNV8a9ttw4mIytk9Hpr1nLjCfbw1tAxKCfu1Gmd6PXaDUsVtmwxDX8j5cgWM8ey5FqihfejOnQvP/d9NXqsxZ+YMH70hiBr6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeAbtdz8SdPUu4dChtnv7NUk9iQ/BKVViCIsAVWjVLM=;
 b=AuFnFhcZNdyDHs/tOyllBbH4w+hYSQh3debJKvpdJTxTX+sOE4DuZld3r+Azf2I5j7sE/wnSF/LxSVv9h49Tigsl0ass2USk7yfh02lKvbRnuODjf5IHHocG9/VGeOdfRO6H/Mciq7OWVB6WWkWsNFyNk1k0ZJLgLJlMMUmZG02ivd37ZAs67YrxMjdyGC5NypDbcmqluqbS9lFuwctBFTWuk6w4E7cIWdGMknHOCtUxZ3GHmZDJy0Zwkr5T6y6OGugZgg65zrZy42fimkLg2IxWNm+8F8xG0qHT5U9EJx/zwqLIbNvggjXqhG4Fj59Ia7c30/SyBYCKWRU0GwhyAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 17:46:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:46:58 +0000
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
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] sched/core: Skip put_prev_task/set_next_task re-entry for sched_ext donors
Date: Wed,  6 May 2026 19:45:42 +0200
Message-ID: <20260506174639.535232-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: df6b7c18-1770-4c07-486c-08deab977865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PePRzlSR45uzYjlpWnd+jY0xyUpaObtjiVR/uhhrSYq9HLZ69dyw2HCfgu+KCPTvF/9z1iQL//Wc/TlDb0WTRIhWtbGprhycf1qoA3h+UCU7kV6JkXSALGtLA30LujyoY6d8eZIdXDCGE5yCnAsnxgtI3sBQFu+evkg5yBIcYVruS7bk239PwrCdP3qAWTLzFFFbIksX+qQ6LUgxihHEmALbRl27w6evtYSxzgFbpOA3/G/ZZhUxQbX7pYXHnhPveBK1fuok2lYEUOnmJEVdC2od3od3yREfwu4brk5DbjSH8Gz7+wJeBnmTTvMKLRe5FUxx7IgvBI+jaeoGSY6lmhKd3/KE30qrFWIXyyir+rqmiariuhu1kL4IcordqJ/x/IN0kVmyt+zbe2QTuAPFE+OuxSA8NtTzCw4rdufJFcn2Oy9dsLp7VmcIitx7lIGx+DDMhqVJLTjYuJmkxXqoUnDFK/veSBtsreHp0nmg+TuZRsu8+bIdUb4pGbIdPgwwuvnye3Sf9igiLj11MsR6cbZ2quO62a8KBTAUCW+6OJ6IKKkrylk12GRaLiX598FcJUbY1pO3livkRyRPnSWfYzffHT6rCygfF0p16Bz4tuLY1OjleaiBiIQSYgibuFxQFMsDwXoP5uz5Whjc6UiS5uza+WYopTSbNnUpzd7vKuyiA+SK3wPep62tUt0EFY45
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QetjqSEnhxA8hCP7/4enBIIpkuid5V3i7ANHU6/S70zVwtiQcMohntg5XUKY?=
 =?us-ascii?Q?RlFP603UqNK4W3wy/fpV7n+3yoz1KAFUfOmnNdXSYF8h3sGL7TZaOkTcWxZm?=
 =?us-ascii?Q?swtcCc1gDUNbqo0vS1JxRIcseu5o58oF/NDIszlsFvCvDoHRSGGKdJi7Xvya?=
 =?us-ascii?Q?fpXu05h/zVvFX39+VIdNbJ/m8egYhwx26YD7KFTVagxrMQzaJrTpSflfi3P0?=
 =?us-ascii?Q?8/J0Nc+ukbWCHSJ8zaMY+fKa3qU+fC6lYBimNyY5qM6l+JyH7TnFJE1gC7hj?=
 =?us-ascii?Q?fOrJVrc9PrIhT6BISdPufzh1evGmB8y3vKC+BDEI+pOVPdBGFCes7jvcbMKe?=
 =?us-ascii?Q?aJ6LBD/0rhixdahXtlARvgJks3ehOkPPm+6pYaLZWkT1xCsHeV682CrxNAJo?=
 =?us-ascii?Q?WoVrnpwarC+ZRO25OOiQsU5H6yulgwp7vvbTwnqwmceiMcBT/jAt0mtmQ75z?=
 =?us-ascii?Q?jjNGhUeC9tr15Tqn6xZOxCQIsQzpeP0owgzfgG4DQLGH209IJ5Qe05//GtAQ?=
 =?us-ascii?Q?hRECZd1QRb954ZxKyOMj+QD1sMRhJ4bMwpgVpqouXN80lSaCc5MzVWYSgMYe?=
 =?us-ascii?Q?SetCA440fbhqYqHdpCHzmCneZn8ZtfEHYPRzbtgS+zSoy6HBQWO6KlfxLcqq?=
 =?us-ascii?Q?vupusznHoL/b/gHslQFPEoWfwc/j5oOVo7xX3uOYxecFvE+zAsWzDArzuzn+?=
 =?us-ascii?Q?FITECr0B/4VRKi7oGjDigd4gyq4OdCGQAH7PYB0JXgFIlMDAviw5XffYtwri?=
 =?us-ascii?Q?n9LWsoU7CNT1AMdGOQc9pEesjiU7910JzDiUjA5gkM3I/qSuHTM9I951mC9H?=
 =?us-ascii?Q?7Z4lT8qi36ExTJ1K3vxMtJ/ipUnP+dF/JzGp37Lg5ptHcTYC+z3fi/yBpg8y?=
 =?us-ascii?Q?LOjQxuonInLz8V9H3F3CjGcaexLfIFxOyawPB/4K8ub+K1OaVX8fDP1LZXCK?=
 =?us-ascii?Q?IdOu3iiUdgzhVeXBGGqTvrFkDS0DOE14WA5CFtltIVdDYgbd4wu1LhRG5YoO?=
 =?us-ascii?Q?VRQrdszxVDVTt9vAW/qAVP6UqkvuTOuFdOq3dYjevQUQY2pJT5bSVDq3sajz?=
 =?us-ascii?Q?zs4CjxYJTsNMnesXo7Js+OzxuRH7J4d1V87lZC4rgic/LnMvFBpMj/GlVj2D?=
 =?us-ascii?Q?uNhekXOjx5yUrlTbyBOLdQ8pqQoXzixO9sEOU18onvLA4wa34EclbFnZNFKJ?=
 =?us-ascii?Q?9f0BD+jLVrf1VRSQQrx71HGMBbq+W69ScacoMeX0IoPdkG03yeKtvDP5h00r?=
 =?us-ascii?Q?XV1x/FH8JQTVPo+lC/8BXcG1jxh32YlsavaJm7gpTj7Iwj6f7ZkVNIZxK0d5?=
 =?us-ascii?Q?LpvQcn/uldBy+wVUJ00vJm5zXGMx5X+ZskZJRNDFZ+gtRyBsg0YTx8Zl1sn9?=
 =?us-ascii?Q?/j1CGzKNJKDfY2YLxi0ynPOz1rSpYF9v1VHF3tN/IX76P4CdDQxAmucX4aF3?=
 =?us-ascii?Q?kMD+w+8qSbGfVzInb+R3h02XFvUDwp8PgsZdeVPYnf2vRqC21tQbslQsr6iC?=
 =?us-ascii?Q?6Rxdmw6Me8yANyOv6/pwtZZF/oC6pZxkQw051JJlfyrreVVs2BpGr0QbksDR?=
 =?us-ascii?Q?qlhxZromkCOpCwteBBoALVo/aMIlkMNkGvgbuOcuoLnCOt1B9LXmlnbHcbcb?=
 =?us-ascii?Q?dH5J/ctQ1FuwrotQ7d/nfcWyEiPNHHa4Gq9E9QG4ble9I3Hqup1DGG9vjfBp?=
 =?us-ascii?Q?XA1T5o7OaKRUH5B4ZJkNV5Ew22/QvMQQA3sQp5k3REAGOVau?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6b7c18-1770-4c07-486c-08deab977865
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:46:58.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTZn6NysZFBcqe/f9MOahL2lWJBdST3tMPtkLmSf6SE7BqXtUiVBPoUihwyBFwHyCAl1obGcesCKyytNB9FiPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467

In __schedule(), the proxy-exec donor-stabilization block calls
put_prev_task() and set_next_task() when rq->donor == prev_donor and
prev != next.

For sched_ext tasks, re-entering set_next_task_scx() for a donor that
has already been seen by BPF ops.running via the normal pick path causes
issues. It fires SCX_CALL_OP_TASK(sch, running, rq, donor) a second
time, and sch->ops dispatch can land on a vtable slot in a state that
yields a NULL function pointer or corrupts the stack.

Fix this by skipping the put_prev_task/set_next_task re-entry when the
donor is in the ext_sched_class, since sched_ext tracks curr/donor
itself.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75541e5bb66d1..1c161dd9d7440 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7147,9 +7147,14 @@ static void __sched notrace __schedule(int sched_mode)
 			 * anything, since B == B. However, A might have
 			 * missed a RT/DL balance opportunity due to being
 			 * on_cpu.
+			 *
+			 * sched_ext tracks curr/donor itself; re-entering set_next_task_scx
+			 * here dispatches through a stale/NULL BPF ops vtable.
 			 */
-			donor->sched_class->put_prev_task(rq, donor, donor);
-			donor->sched_class->set_next_task(rq, donor, true);
+			if (donor->sched_class != &ext_sched_class) {
+				donor->sched_class->put_prev_task(rq, donor, donor);
+				donor->sched_class->set_next_task(rq, donor, true);
+			}
 		}
 	} else {
 		rq_set_donor(rq, next);
-- 
2.54.0

