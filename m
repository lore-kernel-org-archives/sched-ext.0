Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793206396;
	b=sAODIYBhdkkBSjWoJdJ3qE9I7eNf+6ya7c/LBzTuSC8OHNMkGUtbtXfMzIZ5e45pcke1
	 E/67ycuJBrF4CfJqucIpetExeaHnYesyRQGuU/30IVQGbII4VNq7PudfuCpmDxMoxGM4B
	 5AgL0oiT+OFRSXvbZG1CwBTiPtsBG7t2f9figV7tYy3J5BUpflqmxuUsbiV0IlRBrcSPE
	 9zMK1SYjH3BDnO4X+ySsaXBgA+Bp2eJ3Ru2h+iRHyTOUni75D5ZzOrUOHecfjwppWQWQU
	 QguLqLH7fifwHb28LXkZjZUGVHGkMK4/nyZ9ghPf2k7GkNwRq16HT0kiDpJu+gqU75Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206396;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=K5TWKz7RV8cwGX4HOv20x/LbLk5RU/Ay8Qs1dXwMpIg=;
	b=0Wkiaysz3JKJBW3oymZSB3gWpDGmk6feDa0oJ7hk/gtIVoQxCQUKxNNkHRfR9EeGPIdk
	 cWjUDWlTRZXnVsl8TTp5bA8VNKysEuGmMMXSAMUsskADSncM0IxxS4vKU0XPKjNZPAyaz
	 3/+YGdl7sBUZaOUB9IAAH3wJ9sHSf3hdoK2iXjCr7eL883ff6gYb2Gn46vERTeXoYJUYX
	 FJ7BNfWu1i+rzO40/ueFjyhEbbver1Ooh9V7HplVyj6VtWuuXX4zsloSDFDcnns1sp281
	 J/qqZfnjrG0204dctwkZ5zDXfzzUJGXV3oHteCf3HtmKGkvgIJm4jRffOLfoibHffkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="j/sGziHE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.30
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A55606A31C
	for <sched-ext@lists.linux.dev>; Wed, 28 Oct 2026 16:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A55606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j/sGziHE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+mS2UI5VMQiCdQO1B/BNIP+CcsctZZAAIv6H4HWfE3SVetf4MGXNy+63U21Fj8KPu5ArWTUg2mPBz6FIPasGT2LU2DXJYtj+GA4aL56pwWtLunBBs4qzj4BUoAMrcWpSfEDRYcdyUy7CzsraJD8Vuxjd7CwQKGpzTUv0NWKxPeI92TmGDVBdK5nzAS+tVJCooyZGH1Y7EwQtbVC/irfYoDz9Bp2XZjZMij2TGF1qrLSd9Kvz2BnkFu1f6iFlXVdhnVwqst3lQPWa8TGrHz2LV5O1AO2Zsw8bPKFYg22LM1LfNT0+tAB5qc0D75tJXOl/XiZsxTqgMIOjAwTD9Whrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5TWKz7RV8cwGX4HOv20x/LbLk5RU/Ay8Qs1dXwMpIg=;
 b=KBmOwr8xOiXLCuKyGFTnlDzthWlrSFzkqs/EdHj6FioT5Cd9rNIgOOizjDAyjF3z0ZFu+NBEJzmYaIYUMteYvv2fWHMbY71Pbr46pDpoTxIzRJ70iAC4xlj7aGFkmiVVJ+t2oZtCSaEGadH+hBzZoEcbCUAexFYUDHuTjnAHPwFpi7ycXVH3VbNLHh+IIm+ytSREccpXLR5v1gU7vg5JEmomegXz1IVez+NTasIgUDjIWhrZ9NLzkwiQ5UkeOn58akjlHkDnuwRGnCm0Z6ZVrdBkHlkZPoueQiAMKaq2DGX3KOf0dwNNUKbIyz8SRGViDxRJdE7/HxsJ62Us1ppbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5TWKz7RV8cwGX4HOv20x/LbLk5RU/Ay8Qs1dXwMpIg=;
 b=j/sGziHEU8JHExpRi2QG5oExNm9TsnZ89B4iasIiez8ppUiSDQ4Ssu1F+W40PZTirJKH3agHl5U/x2Tl4joNypnjfAHmUWOu3d3oCsxn+GSEicjVCVcw4NcExkswX50VZGQKIQkoqtU0UhQ0LcEAMYqUhuzrw5XVTF4Ldhb16X6pCDibjG0MMNry34yEsaXUzzvk5YsWQJY4XGVICNXWV47mWxXwbNGQtBfZ+ayeBiWhF+dHrOm5h1F8bTyP3XFACRGYTLz6A3T6jqnjG6YbMOkNpZwWLcKDG1Jb3C/lOxSHr/PO1h8k/ee1JaxvBaXXlgrw/+yDART2qiCyvpU/+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 16:53:11 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:53:11 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Avoid unnecessary IMMED reenqueues on idle CPUs
Date: Wed, 28 Oct 2026 17:52:58 +0100
Message-ID: <20261028165258.3723153-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0326.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::19) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 82eb0ac9-3d3b-48c7-6ecc-08df3513f353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|56012099006|11063799006|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021123027099003|10067099003|261021121427099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	geojjay4pWi5XXGUArZxESIcVWQsp3j3i3AxSdUte2dZwWWmrRZsuUTXzlT90OxMuijbGUs9OPVTKhTe6ydg4minMREvA5AV9sQ4D5sdVNlRyEsFKMcXK8WsOr02iMobdr7NCE6BTPSlNMob+Ru49l4YN/EptCVi2UGrE932YCFd8lwE4VVexqDJK+gFtD6VZYrOJ/LkTTz7x52WZCPmPxhP3y9Ba77wQJROfIF5pSIMutbZjxn/4DC0dzBQ1lLCHFlHPEvHiDOZ0oEvzu9fKJw1MXs7y19HmOnZUUloOirgwa44RC/YnNpzQYNif9KiM4dWDiI5ko21JcgQdEqSlbGQAUKkr/xMAPrXi4P5qbhyzCekJGEXasG57wPZGkFp5dUlxiH3WUlBgr5hqNduZhPdEoIN6jvy8LMZcypHUhC55vEizsEwbYg3pz1KaYeWPv0PDx8Jo8GUn0AwDDnWcomNPchrQdxCIAPae7yAiNkHomdrqls6r5HDfT8Hk24JoZzXRSnxvkhlCB4X75Gs+DSYDla9voGQ96gGetX94H+1ObhXsDQEofGYTrl/xkqW5WXSLJ5sHjQau91oBNF9ffkwpADdbB331XKxCDhSK/PYJS2zeIqP+6I3R70NA4QgYUIrdptU4CLqXs1GiDH7RkJnUf2hfrokD6ylZNBoxnc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ki3xdGzQmHUVrA47ltwDnXTBPBcljKITY3n2XGTExWCKLj+XDSdIy+wXHlhF?=
 =?us-ascii?Q?OQ0A8i09aAgCZXMeTtgRQvdP2MkXKbmqKzrd61dWbvRjRL7KiIIDd+RSVgCb?=
 =?us-ascii?Q?p14vKQ7+EYWm3UmIc+affII+R4R3k5Ym8PZxdwT+1KvC0wDJeL6MGgr0szDH?=
 =?us-ascii?Q?l7z7CoqvAyIEFFXxAJ6XgcbFpI/5w+i6g/geUWgl2FC18oa7IUExWw1N9tUn?=
 =?us-ascii?Q?G10Yx27GX2+SJabYcoGaNVvorc2IYW67hxqzMZ/JMLPxhUUoHBk5i7mdcGxN?=
 =?us-ascii?Q?whpVTldycZTbPdOtXcoWTnyb8sj/FXSTLeTz9+zlHEa447uLTJviSuV0GyzH?=
 =?us-ascii?Q?83z/75fMXFkbQYXUAxLJca10Rt6Lr7ZGBwWQFDEE2V9Sg6nwRCOVuQyBVrO1?=
 =?us-ascii?Q?cpTqp1FBZrqbU5Ee7WAJG6vYGElpA4+qo7Y02eJWhE8ve4j+Dh/Cp+4zdgDe?=
 =?us-ascii?Q?gs2ATV52D4ajBvLnc4lMsfho92gTJKVtZ9VyKaK7YLA/QM0TZZVFrRChobqt?=
 =?us-ascii?Q?vTPwsBMVsHJdcZVW3heqyCaZff1H6s6g8oFzzGyzuLy41zmtrsmSNr8SJwKV?=
 =?us-ascii?Q?r9j7R6LCI3KBwfSEul6zkMewTJLZkr4830WSF1yUhMFoyIUgnj8BmRnpXxV6?=
 =?us-ascii?Q?xr0mpzsjrFMpHC531kiYjVnySq8o4Z5uh6bVwlIuJQ31hB6dtZo0h3B4E+Z1?=
 =?us-ascii?Q?DgsddwMy7HcuFRWJ96F0gHfn7jIimtPJgySE1gbahDmEy8CAJrm70HYx6BWM?=
 =?us-ascii?Q?gA6mWkEyQq2Xa07pnP25ux6lf4g2kjOzp4c9DVx7HD+ajlZfToXeKsyUROtj?=
 =?us-ascii?Q?za220zfTTKMcWM+xkqhbUOujzE6oxaHdlc5W+LhOZmKHECMKBOHqsl0zx7AO?=
 =?us-ascii?Q?WsNZy3NUjPkM1GDBbwngOSWDz1GTSiUiyRDCJihpTrb5c2cxiHf+i6PLGzEe?=
 =?us-ascii?Q?cg/mZFpV5NF6LaoHxeHZ9qPbHui0o4rwPMaBeMgJ9zI5by1773FwfT6wsV4C?=
 =?us-ascii?Q?fvcoGF47VnZealfn0MYLH+p3k5phFrBUMerF1F/JUENSRBltiWjBTF0qmFjo?=
 =?us-ascii?Q?pfd2Vf32SiIP083YUMlb3qvPnLzi2tp03nvb5hrnwp+bbRp80EExCmgCoCUj?=
 =?us-ascii?Q?Ql8HwSfot+6S/YqsLkH6hm0hhP4rpiQrK2YS3Ed8QtnIFRy8FJ+1Ck12f229?=
 =?us-ascii?Q?hA9b1fpeglk/qxyP8VukGyci/GX7Nw4siTIEF1Mg4AjKcBE8NVThdBWQxPTL?=
 =?us-ascii?Q?Q9MUK3XufAJoK+atPGVw+q/1YF4W1siFa9suZU2xZMA4eYoUhMl4KH0FnUsm?=
 =?us-ascii?Q?0yxxUcrhevzqU/CcnY8esaV8ZS3BQD8SholiBi1Lb3MhRZrU94mTbZObSO6A?=
 =?us-ascii?Q?VMS0XrjGDjh58nW7l8QKqCU6onxZj9djoGKLB/TLwve5n9ExwbS6MsH7IPYx?=
 =?us-ascii?Q?R5UY5nuTaoky9COaAPM5LmQ4G1vGrwghVP5Ed23hmzceaH9PhoHdLJJkDzul?=
 =?us-ascii?Q?TxJXTFEkA6vPFOJtMA56ituGGNle+FVsE6tMBVh43FrthXp3Dx1v77YOZEX+?=
 =?us-ascii?Q?SwjLUvRBqXVmk1SInPIE1ZpsXPYT/NBY0Wfx/+lv7q0hsiAMLr8KUObXT9ZD?=
 =?us-ascii?Q?Z3MHkZIhTRXUzGQIF3y7EaCgeYHYI3XcMaZiwj8DpGQIJ319b7YS8H/yQEKA?=
 =?us-ascii?Q?aV/UtS9IDOCsXgSbyUuDeAmrj98dKMeUUqhKzQ4sGJKgAB7e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82eb0ac9-3d3b-48c7-6ecc-08df3513f353
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 16:53:11.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 958En7zwZZBeta6k9oriosCdTYjLui7h3FEV+3cBjr6bHLSnGhocSOExAUzCgetBbg3HXJyJ9qe0mZO0Ox5OGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677

When two IMMED tasks wake on an idle CPU, the kernel can unnecessarily
send both back to BPF instead of keeping the first task ready to run.

The first wakeup inserts a task into the local DSQ and raises
rq->next_class to ext before the CPU leaves idle. The second insertion
queues a reenqueue scan. rq_is_open() sees next_class == ext and reports
the CPU unavailable, although it is still idle. The scan then reenqueues
the head along with the task behind it, losing a placement that could
have been honored on the next pick.

Keep the local DSQ head through the reenqueue scan when the CPU is idle
and, if core scheduling is enabled, its cookie matches. Skipped tasks
still consume the first position, so skipping the head because of
pending migration or scheduler ownership can't let a later IMMED task
stay queued even though it cannot run next.

A local reproducer runs in a four-vCPU virtme-ng guest: two futex
waiters pinned to CPU 0 are woken together from CPU 2, and the BPF
scheduler inserts their wakeups into the local DSQ with SCX_ENQ_IMMED.
Across 10000 pairs, kernel instrumentation counts 9776 unnecessary head
reenqueues while the CPU is idle and next_class is ext. With this fix,
this count is zero (IMMED tasks behind the head still return to BPF).

An additional reproducer exercises the same problem with core scheduling
enabled: it uses a 1 ms kernel mutex hold, a weighted-vruntime BPF
scheduler with SCX_OPS_ENQ_BLOCKED and SCX_OPS_ALWAYS_ENQ_IMMED,
distinct owner and waiter core cookies, and an additional futex wakeup
stream targeting the waiter CPU. Over 2000 measured trials per case, the
mutex waiter receives 154 IMMED reenqueues with a same-CPU owner and 187
with a cross-CPU owner. Both counts drop to zero with this fix.

Fixes: 98d709cba319 ("sched_ext: Implement SCX_ENQ_IMMED")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/1548cc9309a6e0894e358262e0b3d4ee@kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1b098728676f3..ba45fd017afcd 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -429,6 +429,12 @@ static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, struc
 	return dsq;
 }
 
+static struct task_struct *first_local_task(struct rq *rq)
+{
+	return list_first_entry_or_null(&rq->scx.local_dsq.list,
+					struct task_struct, scx.dsq_list.node);
+}
+
 /**
  * rq_is_open - Is the rq available for immediate execution of an SCX task?
  * @rq: rq to test
@@ -461,6 +467,18 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 	 * @rq is either picking, in transition to, or running an SCX task.
 	 */
 
+	/*
+	 * A local insertion can raise next_class to ext while the donor is
+	 * still idle, including after proxy_resched_idle(). The local DSQ head
+	 * is next to run if its cookie matches, so keep it through IMMED reenq.
+	 */
+	if (rq->donor == rq->idle) {
+		struct task_struct *first = first_local_task(rq);
+
+		if (first && sched_cpu_cookie_match(rq, first))
+			return true;
+	}
+
 	/*
 	 * If we're in the dispatch path holding rq lock, $donor may or may not
 	 * be ready depending on whether the on-going dispatch decides to extend
@@ -3909,12 +3927,6 @@ static void kick_sync_wait_bal_cb(struct rq *rq)
 		goto retry;
 }
 
-static struct task_struct *first_local_task(struct rq *rq)
-{
-	return list_first_entry_or_null(&rq->scx.local_dsq.list,
-					struct task_struct, scx.dsq_list.node);
-}
-
 /*
  * Run dispatch for a pick. The follow-up work is queued by do_pick_task_scx()
  * once the pick is final.
@@ -5197,6 +5209,9 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		u32 reason;
 
 		/*
+		 * Skipped tasks still consume the first position in the DSQ. Set
+		 * NOT_FIRST on every path that skips local_task_should_reenq().
+		 *
 		 * If @p is being migrated, @p's current CPU may not agree with
 		 * its allowed CPUs and the migration_cpu_stop is about to
 		 * deactivate and re-activate @p anyway. Skip re-enqueueing.
@@ -5207,11 +5222,15 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		 * the current local DSQ for running tasks and thus are not
 		 * visible to the BPF scheduler.
 		 */
-		if (p->migration_pending)
+		if (p->migration_pending) {
+			reenq_flags |= SCX_REENQ_TSR_NOT_FIRST;
 			continue;
+		}
 
-		if (!scx_is_descendant(task_sch, sch))
+		if (!scx_is_descendant(task_sch, sch)) {
+			reenq_flags |= SCX_REENQ_TSR_NOT_FIRST;
 			continue;
+		}
 
 		if (!local_task_should_reenq(rq, p, &reenq_flags, &reason))
 			continue;
-- 
2.56.0

